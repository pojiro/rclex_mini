PRIV_DIR_PATH = $(MIX_APP_PATH)/priv
OBJ_DIR_PATH = $(MIX_APP_PATH)/obj

NIF = $(PRIV_DIR_PATH)/rclex_mini_nif.so

ERL_CFLAGS ?= -I$(ERL_EI_INCLUDE_DIR)
ERL_LDFLAGS ?= -L$(ERL_EI_LIBDIR) -lei

CFLAGS += -fPIC
LDFLAGS += -fPIC -shared

OBJ = nif.o

calling_from_make:
	mix compile

all: $(OBJ_DIR_PATH) $(PRIV_DIR_PATH) $(NIF)

$(OBJ_DIR_PATH)/nif.o: src/nif.c
	$(CC) -c $^ $(ERL_CFLAGS) $(CFLAGS) -o $@

$(NIF): $(OBJ_DIR_PATH)/nif.o
	$(CC) $^ $(ERL_LDFLAGS) $(LDFLAGS) -o $@

$(OBJ_DIR_PATH):
	mkdir -p $(OBJ_DIR_PATH)

$(PRIV_DIR_PATH):
	mkdir -p $(PRIV_DIR_PATH)

clean:
	@test -z "$(MIX_APP_PATH)" && echo "Use mix clean instead of make clean" && exit 1
	$(RM) $(NIF)
