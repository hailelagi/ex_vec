use rustler::{Atom, NifResult, NifStruct};

mod atoms {
    rustler::atoms! {ok, error, not_found, nil}
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

// #[rustler::nif]
// pub fn slice(vec: Vector, index: usize) -> NifResult<(Atom, i32)> {
//     match vec.fields.get(index) {
//         Some(value) => Ok((atoms::ok(), *value as i32)),
//         None => Ok((atoms::error(), -1)),
//     }
// }

#[rustler::nif]
pub fn update(vec: Vector, index: usize, value: i32) -> NifResult<Vector> {
    let mut vec = Vector {
        fields: vec.fields,
        size: vec.size,
    };

    match vec.fields.get(index) {
        Some(_) => {
            vec.fields[index] = value;

            Ok(vec)
        }
        None => Ok(vec),
    }
}

#[rustler::nif]
pub fn delete(vec: Vector, index: usize) -> NifResult<(Atom, (i32, Vector))> {
    let mut vec = Vector {
        fields: vec.fields,
        size: vec.size,
    };

    match vec.fields.get(index) {
        Some(_) => {
            let popped = vec.fields.remove(index);
            vec.size = vec.size - 1;

            Ok((atoms::ok(), (popped, vec)))
        }
        None => Ok((atoms::error(), (-1, vec))),
    }
}
