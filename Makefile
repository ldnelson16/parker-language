CXX = g++
CXXFLAGS = -Wall

# Define directories
SRC_DIR = src
INCLUDE_DIR = inc
OBJ_DIR = obj
BUILD_DIR = build

# Target program name
TARGET = compiler

# Source file pattern (assuming .cpp files)
SRC_FILES = $(wildcard $(SRC_DIR)/*.cpp)

# Object files derived from source files (using pattern rules)
OBJ_FILES = $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRC_FILES))

# Main target: build the program
compiler: $(BUILD_DIR)/$(TARGET)

# Rule to link object files into the final executable
$(BUILD_DIR)/$(TARGET): $(OBJ_FILES)
	$(CXX) $(CXXFLAGS) -o $@ $^

# Rule to compile each source file into an object file (using pattern rules)
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

%.exe: $(BUILD_DIR)/$(TARGET) %.pkr
	./$(BUILD_DIR)/$(TARGET) $^ $@

# Clean target: remove object files and executable
clean:
	rm -f $(OBJ_DIR)/*.o $(BUILD_DIR)/$(TARGET)