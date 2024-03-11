cmake_minimum_required(VERSION 3.16)

project(Music_Player_Demo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(icon @)
set(CMAKE_AUTORCC ON)

set(QML )

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()



file(GLOB_RECURSE CPP_FILES *.cpp *.h)
foreach(filepath ${CPP_FILES})
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" filename ${filepath})
    list(APPEND sources_files ${filename})
endforeach(filepath)

file(GLOB_RECURSE QML_PATHS *.qml)
foreach(filepath ${QML_PATHS})
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" filename ${filepath})
    list(APPEND qml_files ${filename})
endforeach(filepath)

qt_add_executable(appMusic_Player_Demo
    ${sources_files}
    Images.qrc
)

qt_add_qml_module(appMusic_Player_Demo
    URI Music_Player_Demo
    VERSION 1.0
    QML_FILES ${qml_files} #[[App.qml LayoutBottomView.qml LayoutHeaderView.qml PageHomeView.qml]]
)

set_target_properties(appMusic_Player_Demo PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

find_package(Qt6 COMPONENTS Core5Compat REQUIRED)

target_link_libraries(appMusic_Player_Demo PUBLIC Qt6::Core5Compat)
target_link_libraries(appMusic_Player_Demo
    PRIVATE Qt6::Quick
)

install(TARGETS appMusic_Player_Demo
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
