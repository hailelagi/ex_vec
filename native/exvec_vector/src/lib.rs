mod exvec;

use rustler::{Env, Term};

fn load(env: Env, _: Term) -> bool {
    rustler::resource!(exvec::Vector, env);
    true
}

rustler::init!(
    "Elixir.ExVec.Vector",
    [exvec::new, exvec::member, exvec::get],
    load = load
);
