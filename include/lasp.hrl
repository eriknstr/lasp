-define(TIMEOUT, 100000).

-define(APP, lasp).
-define(VNODE, lasp).

-define(BUCKET, <<"lasp">>).

%% Erlang term storage based backend; no persistence.
% -define(BACKEND, lasp_ets_backend).

%% LevelDB backend; persistence.
-define(BACKEND, lasp_eleveldb_backend).

%% Code which connects the backends to the actual backend
%% implementation.
-define(CORE, lasp_core).

%% Default set implementation for Lasp internal state tracking.
-define(SET, lasp_orset).

-define(N, 3).
-define(W, 2).
-define(R, 2).

-define(PROGRAM_N, 3).
-define(PROGRAM_W, 2).
-define(PROGRAM_R, 2).

-define(PROCESS_R, 1).

-define(PROGRAM_KEY,    registered).
-define(PROGRAM_PREFIX, {lasp, programs}).

-record(lasp_execute_request_v1, {
        module :: atom(),
        req_id :: non_neg_integer(),
        caller :: pid()}).

-define(EXECUTE_REQUEST, #lasp_execute_request_v1).

-record(dv, {value,
             waiting_threads = [],
             lazy_threads = [],
             type}).

-type variable() :: #dv{}.

-type module() :: atom().
-type file() :: iolist().
-type registration() :: preflist | global.
-type id() :: binary().
-type idx() :: term().
-type result() :: term().
-type type() :: lasp_ivar | lasp_orset | riak_dt_gset | riak_dt_orset | riak_dt_orswot | riak_dt_gcounter.
-type value() :: term().
-type func() :: atom().
-type args() :: list().
-type bound() :: true | false.
-type supervisor() :: pid().
-type stream() :: list(#dv{}).
-type store() :: ets:tid() | eleveldb:db_ref() | atom().
-type threshold() :: value() | {strict, value()}.
-type pending_threshold() :: {threshold, read | wait, pid(), type(), threshold()}.
-type operation() :: {atom(), value()}.
-type operations() :: list(operation()).
-type ivar() :: term().
-type actor() :: term().

%% @doc Result of a read operation.
-type var() :: {id(), type(), value()}.

%% @doc Only CRDTs are able to be processed.
-type crdt() :: riak_dt:crdt().

%% @doc Output of program must be a CRDT.
-type output() :: crdt().

%% @doc Any state that needs to be tracked from one execution to the
%%      next execution.
-type state() :: term().

%% @doc Reasons provided by the riak_kv vnode for change.
-type reason() :: put | handoff | delete.

%% @doc The type of objects that we can be notified about.
-type object() :: crdt().
