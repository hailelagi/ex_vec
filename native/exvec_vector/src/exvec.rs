use rustler::{Atom, NifResult, NifStruct};

mod atoms {rustler::atoms! {ok, error}}

#[derive(Debug, NifStruct)]
#[module = "ExVec.Vector"]
pub struct Vector {
   fields: Vec<i32>,
}

#[rustler::nif]
pub fn echo(a: i32) ->  NifResult<(Atom, Vector)> {
    let result = Vector{fields: vec![a]};

    Ok((atoms::ok(), result))
}
