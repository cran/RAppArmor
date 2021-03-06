# Note: keep in mind that RLIMIT_AS is not effective when set to less than what
# has already been allocated in the current process. These tests will fail if
#
context("memory limits")
test_that("Memory limits apply and do not have side effects", {
	expect_that(eval_safe(class(rep(pi, 25*1024*1024))), equals("numeric"))
	expect_that(eval_safe(class(rep(pi, 25*1024*1024)), rlimits = list(as = 200*1024*1024)), throws_error("cannot allocate"));
	expect_that(eval_safe(class(rep(pi, 25*1024*1024))), equals("numeric"))
	expect_that(eval_safe(class(rep(pi, 25*1024*1024)), rlimits = list(as = 200*1024*1024)), throws_error("cannot allocate"));
	expect_that(eval_safe(class(rep(pi, 25*1024*1024))), equals("numeric"))
	expect_that(eval_safe(class(rep(pi, 25*1024*1024)), rlimits = list(as = 200*1024*1024)), throws_error("cannot allocate"));
	expect_that(eval_safe(class(rep(pi, 25*1024*1024))), equals("numeric"))
	expect_that(eval_safe(class(rep(pi, 25*1024*1024)), rlimits = list(as = 200*1024*1024)), throws_error("cannot allocate"));
	expect_that(eval_safe(class(rep(pi, 25*1024*1024))), equals("numeric"))
	expect_that(eval_safe(class(rep(pi, 25*1024*1024)), rlimits = list(as = 200*1024*1024)), throws_error("cannot allocate"));
});

test_that("Raising memory limit by non-root users", {

	#force non-root
	me <- ifelse(getuid() == 0, 1000, getuid());

	#test with different limits.
	#Make sure to not test a value lower than current un-use memory
	gc();
	for(mylim in c(5e7, 1e8, 5e8, 1e9)){
		output <- list(cur = mylim/2, max = mylim);
		expect_that(eval_safe(rlimit_as(mylim*2), rlimits = list(as = mylim), uid=me), throws_error("permi"));
		expect_that(eval_safe(rlimit_as(mylim/2), rlimits = list(as = mylim), uid=me), equals(output));
		rm(output);
	}
})

# Recent linux now supports wide rlim_t
test_that("warnings", {
	#expect_that(rlimit_as(1e12), gives_warning())
	#expect_that(eval_safe(123, RLIMIT_AS=1e12), gives_warning())
})
