include ../Makefile.conf

# Module name and description
MODULE_NAME = Hybrid Aster Path Finder
MODULE_COMMENT = Hybrid A* with path optimization


LINK = g++
CXXFLAGS = -std=c++11 -g -O0
CFLAGS += -g -O0

# Application specific include directories.
#IFLAGS +=

SUBDIRS += Interface

# Required default libraries to comunicate with Carmen Core.
LFLAGS += -g -O0 -lparam_interface -lipc -lglobal -lgrid_mapping -lmapper_interface -lmap_server_interface -llocalize_ackerman_interface -lsimulator_ackerman_interface -lrobot_ackerman_interface -lbase_ackerman_interface -lbehavior_selector_interface -lrddf_interface -lm `pkg-config --libs opencv`

# Source code files (.c, .cpp)
SOURCES = hybrid_astar_path_finder_main.cpp Interface/hybrid_astar_interface.cpp PathFinding/HybridAstarPathFinder.cpp VehicleModel/VehicleModel.cpp Entities/Circle.cpp Entities/Pose2D.cpp Entities/State2D.cpp GridMap/GVDLau.cpp GridMap/InternalGridMap.cpp ReedsShepp/ReedsSheppActionSet.cpp ReedsShepp/ReedsSheppModel.cpp PathFinding/HybridAstar/HybridAstarNode.cpp PathFinding/HybridAstar/HybridAstar.cpp PathFinding/HybridAstar/Heuristics/Heuristic.cpp PathFinding/HybridAstar/Heuristics/NonholonomicHeuristicInfo.cpp PathFinding/HybridAstar/Heuristics/Heuristic.cpp PathFinding/HybridAstar/Heuristics/HolonomicHeuristic.cpp PathFinding/Smoother/CGSmoother.cpp ReedsShepp/ReedsSheppActionSet.cpp ReedsShepp/ReedsSheppModel.cpp PathFollower/StanleyController.cpp

PUBLIC_BINARIES = path_finder
PUBLIC_LIBRARIES = libhybrid_astar_interface.a

#TARGETS = path_finder libhybrid_astar_interface.a

# Public headers, linked to 'carmen/include/carmen/'
#PUBLIC_INCLUDES =

## TODO ##

libhybrid_astar_interface.a : Interface/hybrid_astar_interface.o

path_finder: hybrid_astar_path_finder_main.o libhybrid_astar_interface.a Entities/Circle.o Entities/State2D.o Entities/Pose2D.o PathFinding/HybridAstarPathFinder.o GridMap/GVDLau.o GridMap/InternalGridMap.o VehicleModel/VehicleModel.o PathFinding/HybridAstar/HybridAstarNode.o  PathFinding/HybridAstar/HybridAstar.o PathFinding/HybridAstar/Heuristics/NonholonomicHeuristicInfo.o PathFinding/HybridAstar/Heuristics/HolonomicHeuristic.o PathFinding/HybridAstar/Heuristics/Heuristic.o PathFinding/Smoother/CGSmoother.o ReedsShepp/ReedsSheppActionSet.o ReedsShepp/ReedsSheppModel.o PathFollower/StanleyController.o

pf_clear :
	rm */*.o */*/*.o */*/*/*.o path_finder

gvd.o:
	g++ -std=c++11 -O3 -W -Wall -pedantic -c GridMap/GVDLau.cpp -o GridMap/GVDLau.o
	

include ../Makefile.rules
