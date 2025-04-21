TARGET = app

SRCS = $(shell fine ./src -type f -name *.cpp)
HEADS = $(shell find ./include -type f -name *.h)
OBJS = $(SRCS:.cpp=.o)
DEPS = Makefile.depend

INCLUDES += -I./include -I$(OECORE_TARGET_SYSROOT)/usr/include
CXXFLAGS += -O2 -Wall $(INCLUDES)
LDFLAGS += -lm

all: $(TARGET)

$(TAREGET): $(OBJS) $(HEADS)
        $(CXX) $(LDFLAGS) -o $@ $(OBJS)

run: all
        @./$(TARGET)

.PHONY: depend clean
depend:
        $(CXX) $(CXXFLAGS) -MM $(SRCS) > $(DEPS)
        $sed -i -E "s/^(.+?).o: $([^ ]+?)\1/\2\1.o: \2\2/g" $(DEPS)

clean:
        $(RM) $(OBJS) $(TARGET)

-incldue $(DEPS)
