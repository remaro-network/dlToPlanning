cmake_minimum_required(VERSION 3.8)
project(owl_to_pddl)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
find_package(ament_cmake_python REQUIRED)

ament_python_install_package(${PROJECT_NAME})

install(PROGRAMS
  owl_to_pddl/owl_to_pddl.py
  DESTINATION lib/${PROJECT_NAME}
)

execute_process(
  COMMAND ./gradlew shadowJar
  WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
)
install(DIRECTORY
  build
  DESTINATION share/${PROJECT_NAME}/
)

ament_package()
