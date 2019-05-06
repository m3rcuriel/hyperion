extern crate flatbuffers;
extern crate test_fbs;

fn main() {}

#[cfg(test)]
mod test {
    pub use test_fbs::test_fbs::{TestFbs, TestFbsArgs, Vec3};

    #[test]
    fn basic_builder() {
        let test_data: Vec<u8> = [
            12, 0, 0, 0, 0, 0, 6, 0, 16, 0, 4, 0, 6, 0, 0, 0, 0, 0, 64, 64, 0, 0, 192, 64, 0, 0,
            224, 64,
        ]
        .to_vec();
        let mut builder = flatbuffers::FlatBufferBuilder::new_with_capacity(256);
        let _vector = TestFbs::create(
            &mut builder,
            &TestFbsArgs {
                pos: Some(&Vec3::new(3.0, 6.0, 7.0)),
            },
        );
        builder.finish(_vector, None);

        let buf = builder.finished_data();

        assert_eq!(buf.to_vec(), test_data);
    }
}
