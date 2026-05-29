
# Compilatore MPI per C++
CXX      = mpicxx

# flag di ottimizzazione e abilitazione OpenMP per la compilazione
# Nota: -MMD -MP servono per generare i file .d per le dipendenze degli header
CXXFLAGS = -std=c++20 -Wall -Wextra -O3 -fopenmp -MMD -MP

# Flag per il linker (indispensabile ripetere -fopenmp qui per accoppiare MPI+OpenMP)
LDFLAGS  = -fopenmp

# Include paths (Aggiunto il path standard di MPI se non intercettato dal wrapper)
INCLUDES = -Iinclude -I/usr/local/include/eigen3 -I/usr/local/include

# Directories
SRC_DIR   = src
APP_DIR   = apps
TEST_DIR  = tests
BUILD_DIR = build
BIN_DIR   = bin

# 1. Core Library
SRC_SOURCES = $(wildcard $(SRC_DIR)/*.cpp)
SRC_OBJECTS = $(patsubst %.cpp, $(BUILD_DIR)/%.o, $(SRC_SOURCES))

# 2. Application 
APP_SOURCES = $(wildcard $(APP_DIR)/*.cpp)
APP_OBJECTS = $(patsubst %.cpp, $(BUILD_DIR)/%.o, $(APP_SOURCES))

# 3. Tests 
TEST_SOURCES = $(wildcard $(TEST_DIR)/*.cpp)
TEST_OBJECTS = $(patsubst %.cpp, $(BUILD_DIR)/%.o, $(TEST_SOURCES))

# Combine dependencies for automatic header tracking
DEPS = $(SRC_OBJECTS:.o=.d) $(APP_OBJECTS:.o=.d) $(TEST_OBJECTS:.o=.d)

# Targets
APP_TARGET  = $(BIN_DIR)/laplace2d
TEST_TARGET = $(BIN_DIR)/run_tests


# ==========================================
# Compilation Rules

# Default 'make' builds the main application
all: $(APP_TARGET)

# Rule to build the main application (links src + apps)
$(APP_TARGET): $(SRC_OBJECTS) $(APP_OBJECTS)
	@mkdir -p $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

# Target to build tests 
tests: $(SRC_OBJECTS) $(TEST_OBJECTS)
	@mkdir -p $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -o $(TEST_TARGET) $^ $(LDFLAGS)

# Universal rule to compile any .cpp into a .o file safely
$(BUILD_DIR)/%.o: %.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

# Cleanup
clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR)

# Auto-include dependencies
-include $(DEPS)

.PHONY: all tests clean