#include "erl_nif.h"
#include "rcl/rcl.h"

ErlNifResourceType* rt_node;

static ERL_NIF_TERM create_node(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]){
 rcl_context_t context = rcl_get_zero_initialized_context();
 // ... initialize the context with rcl_init()
 rcl_node_t node = rcl_get_zero_initialized_node();
 rcl_node_options_t node_ops = rcl_node_get_default_options();
 // ... node options customization
 rcl_ret_t ret = rcl_node_init(&node, "node_name", "/node_ns", &context, &node_ops);
 // ... error handling and then use the node, but eventually deinitialize it:
 ret = rcl_node_fini(&node);

 return enif_make_atom(env, "ok");
}

static ERL_NIF_TERM hello(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]){
  return enif_make_atom(env, "hello");
}

static ErlNifFunc nif_funcs[] = {
  {"create_node", 0, create_node, 0},
  {"hello", 0, hello, 0}
};

ERL_NIF_INIT(Elixir.RclexMini.Nif, nif_funcs, NULL, NULL, NULL, NULL)
