# SLAM Project: Custom World Mapping with TurtleBot3

## Student Information
**Name:** Ali Sileiman  
**Program:** Master's in Robotics and AI  
**University:** ITMO University  
**Course:** Robot Programming (Fall 2025)  
**Project Type:** Individual Project

## Project Overview
This project implements a SLAM (Simultaneous Localization and Mapping) system using TurtleBot3 Waffle robot in a custom-designed Gazebo environment. The robot explores the environment, builds a map in real-time, and saves it for future navigation tasks.

## Project Structure

├── build
│   ├── COLCON_IGNORE
│   ├── turtlebot3_fake_node
│   ├── turtlebot3_gazebo
│   └── turtlebot3_simulations
├── Dockerfile
├── install
│   ├── COLCON_IGNORE
│   ├── local_setup.bash
│   ├── local_setup.ps1
│   ├── local_setup.sh
│   ├── _local_setup_util_ps1.py
│   ├── _local_setup_util_sh.py
│   ├── local_setup.zsh
│   ├── setup.bash
│   ├── setup.ps1
│   ├── setup.sh
│   ├── setup.zsh
│   ├── turtlebot3_fake_node
│   ├── turtlebot3_gazebo
│   └── turtlebot3_simulations
├── log
│   ├── build_2026-01-17_22-54-33
│   ├── build_2026-01-17_23-06-45
│   ├── build_2026-01-17_23-25-34
│   ├── build_2026-01-17_23-45-18
│   ├── COLCON_IGNORE
│   ├── latest -> latest_build
│   └── latest_build -> build_2026-01-17_23-45-18
├── map.pbstream
├── README.md
├── src
│   ├── CONTRIBUTING.md
│   ├── LICENSE
│   ├── README.md
│   ├── turtlebot3_fake_node
│   ├── turtlebot3_gazebo
│   ├── turtlebot3_simulations
│   └── turtlebot3_simulations_ci.repos
└── tests
    ├── map.pgm
    ├── map.rviz
    ├── map.yaml
    └── rviz_screenshot_2026_01_18-01_43_04.png

## Results Achieved

### 1. Custom World Creation
- ✅ Created custom Gazebo world: `my_world5.world`
- ✅ Designed environment with multiple obstacles and corridors
- ✅ Configured proper lighting and textures

### 2. Simulation Setup
- ✅ Installed ROS 2 Jazzy on Ubuntu 24.04
- ✅ Configured Gazebo Harmonic integration
- ✅ Built TurtleBot3 simulation workspace

### 3. SLAM Implementation
- ✅ Launched robot in custom environment
- ✅ Used teleoperation for manual exploration
- ✅ Real-time map generation using SLAM algorithms
- ✅ Successfully saved complete map

### 4. Map Quality
- **Map Resolution:** 0.05 meters/pixel
- **Coverage Area:** Approximately 10m × 10m
- **Map Accuracy:** Clear obstacle representation
- **File Size:** map.pgm (100KB), map.yaml (1KB)

## How to Reproduce Results

### Step 1: Clone and Build Project
```bash
# Clone the repository
git clone https://github.com/alislaiman496/first_slam_project.git
cd first_slam_project

# Build the workspace
colcon build --symlink-install
source install/setup.bash
export TURTLEBOT3_MODEL=waffle_pi
Step 2: Launch Custom World
ros2 launch turtlebot3_gazebo turtlebot3_my_world.launch.py

Step 3: Launch SLAM
ros2 launch turtlebot3_cartographer cartographer.launch.py use_sim_time:=True

Step 4: Manual Exploration
ros2 run turtlebot3_teleop teleop_keyboard

Step 5: Save the Map
ros2 run nav2_map_server map_saver_cli -f ~/first_slam_project/tests/map

Technical Details
Custom World Specifications
File: src/turtlebot3_gazebo/worlds/my_world5.world

Dimensions: 10 × 10 meters

Features: Multiple walls, obstacles, open spaces

Lighting: Simulated natural light

Ground: Textured surface

Robot Configuration
Model: TurtleBot3 Waffle

Sensors: LIDAR (360°, 5m range), IMU, Odometry

Control: Differential drive

SLAM Parameters
Algorithm: SLAM Toolbox (async mode)

Map Resolution: 0.05 m/pixel

Update Rate: 1 Hz

Loop Closure: Enabled