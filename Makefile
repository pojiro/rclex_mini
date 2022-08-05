PRIV_DIR_PATH = $(MIX_APP_PATH)/priv
OBJ_DIR_PATH = $(MIX_APP_PATH)/obj

NIF = $(PRIV_DIR_PATH)/rclex_mini_nif.so

ERL_CFLAGS ?= -I$(ERL_EI_INCLUDE_DIR)
ERL_LDFLAGS ?= -L$(ERL_EI_LIBDIR) -lei

ROS_DIR_PATH = /opt/ros/foxy
ROS_CFLAGS = -I$(ROS_DIR_PATH)/include
ROS_LDFLAGS = -L$(ROS_DIR_PATH)/lib -lrcl

CFLAGS += -fPIC
LDFLAGS += -fPIC -shared

OBJ = nif.o

calling_from_make:
	mix compile

all: $(OBJ_DIR_PATH) $(PRIV_DIR_PATH) $(NIF)

$(OBJ_DIR_PATH)/nif.o: src/nif.c
	$(CC) -c $^ $(CFLAGS) $(ERL_CFLAGS) $(ROS_CFLAGS) -o $@

$(NIF): $(OBJ_DIR_PATH)/nif.o
	$(CC) $^ $(LDFLAGS) $(ERL_LDFLAGS) $(ROS_LDFLAGS) -o $@

$(OBJ_DIR_PATH):
	mkdir -p $(OBJ_DIR_PATH)

$(PRIV_DIR_PATH):
	mkdir -p $(PRIV_DIR_PATH)

clean:
	@test -z "$(MIX_APP_PATH)" && echo "Use mix clean instead of make clean" && exit 1
	$(RM) $(NIF)
