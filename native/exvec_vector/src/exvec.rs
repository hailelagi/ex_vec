use rustler::{Atom, NifResult, NifStruct};

mod atoms {
    rustler::atoms! {ok, error, not_found}
}

#[derive(Debug, NifStruct)]
#[module = "ExVec.Vector"]
pub struct Vector {
    fields: Vec<i32>,
    size: usize,
}

#[rustler::nif]
pub fn new(fields: Vec<i32>) -> NifResult<(Atom, Vector)> {
    let size = fields.len();
    let result = Vector {
        fields: fields,
        size: size,
    };

    Ok((atoms::ok(), result))
}

#[rustler::nif]
pub fn member(vec: Vec<i32>, n: i32) -> NifResult<(Atom, bool)> {
    if vec.contains(&n) {
        Ok((atoms::ok(), true))
    } else {
        Ok((atoms::error(), false))
    }
}

#[rustler::nif]
pub fn get(vec: Vector, index: usize) -> NifResult<(Atom, i32)> {
    match vec.fields.get(index) {
        Some(value) => Ok((atoms::ok(), *value as i32)),
        None => Ok((atoms::error(), -1))
    }
}
