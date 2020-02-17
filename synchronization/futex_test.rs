use futex;

use std::sync::Arc;

#[test]
fn simple_test() {
  let mutex = futex::Mutex::new(false);
  let condition = Arc::new(futex::CondVar::new(mutex));

  let condition2 = condition.clone();

  let childval = condition.mutex().lock();

  let child = std::thread::spawn(move || {
    let mut childval2 = condition2.mutex().lock();
    condition2.notify_all();
    condition2.wait();
    *childval2 = true;
  });

  condition.wait();
  condition.notify_all();
  std::mem::drop(childval);
  child.join().unwrap();
  let childval = condition.mutex().lock();
  assert_eq!(*childval, true);
}
