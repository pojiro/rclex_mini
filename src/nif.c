#include "erl_nif.h"

static ERL_NIF_TERM hello(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]){
  return enif_make_atom(env, "hello");
}

static ErlNifFunc nif_funcs[] = {
  {"hello", 0, hello, 0}
};

ERL_NIF_INIT(Elixir.RclexMini.Nif, nif_funcs, NULL, NULL, NULL, NULL)
