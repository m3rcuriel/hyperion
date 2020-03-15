use bindgen;
use std::env;
use std::path::PathBuf;

fn generate_bindings() {
  const SYMBOL_REGEX: &str = r"HAL_\w+";

  let bindings = bindgen::Builder::default()
    .derive_default(true)
    .header("bindgen.h")
    .whitelist_type(SYMBOL_REGEX)
    .whitelist_function(SYMBOL_REGEX)
    .whitelist_var(SYMBOL_REGEX)
    .default_enum_style(bindgen::EnumVariation::ModuleConsts);

    let output = bindings
        .generate()
        .expect("Unable to generate bindings");

    let out_path = PathBuf::from(env::var("OUT_DIR").unwrap());
    output
        .write_to_file(out_path.join("bindings.rs"))
        .expect("Couldn't write bindings!");
}

fn main() {
  generate_bindings();
}
