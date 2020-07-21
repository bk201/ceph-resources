## Parse Ceph API test logs

Example:

```
# Extract Dashboard API test logs of build ID 4043
$ ./get-log.sh 4043
Logs are saved to ceph-dashboard-pr-backend-4043

$ ls -l ceph-dashboard-pr-backend-4043/
total 45576
-rw-r--r-- 1 kiefer users   438246 Jul 21 14:51 build.log         # build log
-rw-r--r-- 1 kiefer users  3059487 Jul 21 14:51 consoleText.gz    # The original large log
-rw-r--r-- 1 kiefer users  1710356 Jul 21 14:51 mgr.x.log         # Daemons
-rw-r--r-- 1 kiefer users   208158 Jul 21 14:51 mgr.y.log
-rw-r--r-- 1 kiefer users   190503 Jul 21 14:51 mgr.z.log
-rw-r--r-- 1 kiefer users 10326243 Jul 21 14:51 osd.0.log
-rw-r--r-- 1 kiefer users 10645434 Jul 21 14:51 osd.1.log
-rw-r--r-- 1 kiefer users  9072892 Jul 21 14:51 osd.2.log
-rw-r--r-- 1 kiefer users 10849510 Jul 21 14:51 osd.3.log
-rw-r--r-- 1 kiefer users   152363 Jul 21 14:51 test.log          # Test stage log

# See what's going on during test stage
$ tail ceph-dashboard-pr-backend-4043/test.log
    remote.run(args=args, env=vstart_env, timeout=(3 * 60))
  File "../qa/tasks/vstart_runner.py", line 354, in run
    return self._do_run(**kwargs)
  File "../qa/tasks/vstart_runner.py", line 421, in _do_run
    proc.wait()
  File "../qa/tasks/vstart_runner.py", line 205, in wait
    raise CommandFailedError(self.args, self.exitstatus)
teuthology.exceptions.CommandFailedError: Command failed with status 5: ['../src/vstart.sh', '-n', '-d', '--nolockdep']
```

