LLAMA_CPP_DIR   ?= ../../cl-llama-cpp/llama.cpp
LLAMA_BUILD_DIR ?= $(LLAMA_CPP_DIR)/build/bin

CXX      ?= c++
CXXFLAGS  = -std=c++17 -O2 -fPIC -shared
INCLUDES  = -I$(LLAMA_CPP_DIR)/common -I$(LLAMA_CPP_DIR)/vendor
LDFLAGS   = -L$(LLAMA_BUILD_DIR) -lllama-common -Wl,-rpath,'$$ORIGIN'

TARGET    = $(LLAMA_BUILD_DIR)/libllama-json-schema-shim.so

all: $(TARGET)

$(TARGET): json-schema-shim.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o $@ $< $(LDFLAGS)

clean:
	rm -f $(TARGET)

.PHONY: all clean
