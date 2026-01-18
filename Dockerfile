# Use ROS 2 Jazzy as base image
FROM ros:jazzy-ros-base

# Set environment variables for TurtleBot3
ENV TURTLEBOT3_MODEL=waffle_pi
ENV GAZEBO_MODEL_PATH=/opt/ros/jazzy/share/turtlebot3_gazebo/models:$GAZEBO_MODEL_PATH

# Install required packages
RUN apt-get update && apt-get install -y \
    # ROS 2 packages
    ros-jazzy-slam-toolbox \
    ros-jazzy-nav2-bringup \
    ros-jazzy-navigation2 \
    ros-jazzy-turtlebot3-gazebo \
    ros-jazzy-turtlebot3-description \
    ros-jazzy-turtlebot3-teleop \
    # Development tools
    python3-pip \
    python3-colcon-common-extensions \
    git \
    wget \
    # Gazebo dependencies
    gazebo-harmonic \
    libgazebo-harmonic-dev \
    # Clean up
    && rm -rf /var/lib/apt/lists/*

# Clone TurtleBot3 simulations to workspace
WORKDIR /first_slam_project/src
RUN git clone https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git .

# Copy your custom world and launch files
COPY ./src/turtlebot3_gazebo/launch/turtlebot3_my_world.launch.py /first_slam_project/src/turtlebot3_gazebo/launch/
COPY ./src/turtlebot3_gazebo/worlds/my_world5.world /first_slam_project/src/turtlebot3_gazebo/worlds/

# Create directories for maps
RUN mkdir -p /first_slam_project/maps

# Build the workspace
WORKDIR /first_slam_project
RUN /bin/bash -c "source /opt/ros/jazzy/setup.bash && \
    colcon build --symlink-install"

# Source the workspace in bashrc
RUN echo "source /opt/ros/jazzy/setup.bash" >> /root/.bashrc && \
    echo "source /first_slam_project/install/setup.bash" >> /root/.bashrc && \
    echo "export TURTLEBOT3_MODEL=waffle_pi" >> /root/.bashrc && \
    echo "export GAZEBO_MODEL_PATH=/opt/ros/jazzy/share/turtlebot3_gazebo/models:\$GAZEBO_MODEL_PATH" >> /root/.bashrc

# Copy test maps if they exist
COPY ./tests /first_slam_project/tests/

# Create a launch script
RUN echo '#!/bin/bash\n\
source /opt/ros/jazzy/setup.bash\n\
source /first_slam_project/install/setup.bash\n\
export TURTLEBOT3_MODEL=waffle_pi\n\
export GAZEBO_MODEL_PATH=/opt/ros/jazzy/share/turtlebot3_gazebo/models:$GAZEBO_MODEL_PATH\n\
exec "$@"' > /launch.sh && chmod +x /launch.sh

# Set entrypoint
ENTRYPOINT ["/launch.sh"]

# Default command - launches your custom world
CMD ["ros2", "launch", "turtlebot3_gazebo", "turtlebot3_my_world.launch.py"]
