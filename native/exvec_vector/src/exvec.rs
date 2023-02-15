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
pub fn init(fields: Vec<i32>) -> NifResult<Vector> {
    let size = fields.len();

    Ok(Vector {
        fields: fields,
        size: size,
    })
}

#[rustler::nif]
pub fn member(vec: Vector, n: i32) -> NifResult<(Atom, bool)> {
    if vec.fields.contains(&n) {
        Ok((atoms::ok(), true))
    } else {
        Ok((atoms::ok(), false))
    }
}

#[rustler::nif]
pub fn get(vec: Vector, index: usize) -> NifResult<(Atom, i32)> {
    match vec.fields.get(index) {
        Some(value) => Ok((atoms::ok(), *value as i32)),
        None => Ok((atoms::error(), -1)),
    }
}

#[rustler::nif]
pub fn slice(vec: Vector, index: usize) -> NifResult<(Atom, i32)> {
    match vec.fields.get(index) {
        Some(value) => Ok((atoms::ok(), *value as i32)),
        None => Ok((atoms::error(), -1)),
    }
}
