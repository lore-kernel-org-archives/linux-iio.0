Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v2 0/1] iio:buffer: polling unregistered device stalls user process
Date: Fri, 9 Sep 2016 16:20:37 +0200
Message-ID: <cover.1473430265.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Version 2 of this patchset.

Changes since v1 :
* merge both patches
* reword commit log subject
* remove fixes tag


Unregistering a device currently in use may stall userspace process polling for
data availability (poll syscall). Here is a typical situation detailed below.

zpa2326 barometer driver is loaded.
<console>
/ # lsmod 
Module                  Size  Used by
zpa2326_i2c             2833  0
zpa2326                25360  1 zpa2326_i2c
[...]
</console>

zpa2326 has registered iio device 0 and its own hardware trigger 0.
<console>
/ # lsiio
Device 000: zpa2326
Trigger 000: zpa2326-dev0
/ # ls /dev
bus                 ptmx                tty29               tty52
[...]
iio:device0         tty11               tty35               tty59
</console>

Run an everlasting sampling process (iio_generic_buffer) in hardware triggered
buffer mode then unload module (zpa2326_i2c) driving the device (iio:device0)
under use.
<console>
/ # iio_generic_buffer -a -N 0 -l 2 -c -1 & sleep 1 ; rmmod zpa2326_i2c
iio device number being used is 0
iio trigger number being used is 0
No channels are enabled, enabling all channels
Enabling: in_pressure_en
Enabling: in_timestamp_en
Enabling: in_temp_en
/sys/bus/iio/devices/iio:device0 zpa2326-dev0
103.736877 31265.359375 98504890900 
103.734001 31369.199219 98568173608 
103.739883 31369.199219 98631470327 
103.734070 31369.199219 98694748816 
103.733070 31369.199219 98758036681 
103.736130 31473.039062 98821330691 
103.739006 31369.199219 98884620014 
103.737068 31473.039062 98947911524 
103.732254 31473.039062 99011214754 
103.739006 31473.039062 99074498920 
103.739006 31473.039062 99137784962 
103.734192 31473.039062 99201085431 
103.737190 31473.039062 99264364910 
103.741066 31473.039062 99327655274 
/ #
</console>

After 1 second, iio_generic_buffer output has been muted. A ps shows
iio_generic_buffer is still there, in interruptible sleep state.
<console>
/ # ps | grep iio_generic_buffer
  123 0         1820 S    iio_generic_buffer -a -N 0 -l 2 -c -1
  128 0         2776 S    grep iio_generic_buffer
/ # 
</console>

Strace shows iio_generic_buffer is stalled into poll syscall. Forever...
<console>
/ # strace -p 123
Process 123 attached
poll([{fd=3, events=POLLIN}], 1, -1^CProcess 123 detached
 <detached ...>
</console>

A sysrq task state trace shows iio_generic_buffer is blocking in...
<console>
/ # [  202.859427] sysrq: SysRq : Show State
[  202.863151]   task                PC stack   pid father
[...]
[  205.667101] iio_generic_buf S 8068a254     0   123     98 0x00000000
[  205.673507] [<8068a254>] (__schedule) from [<8068ac0c>] (schedule+0x64/0x100)
[  205.680664] [<8068ac0c>] (schedule) from [<80690820>] (schedule_hrtimeout_range_clock+0x1d8/0x1e8)
[  205.689641] [<80690820>] (schedule_hrtimeout_range_clock) from [<80690858>] (schedule_hrtimeout_range+0x28/0x30)
[  205.699831] [<80690858>] (schedule_hrtimeout_range) from [<8022b148>] (poll_schedule_timeout+0x84/0xc8)
[  205.709241] [<8022b148>] (poll_schedule_timeout) from [<8022d808>] (do_sys_poll+0x640/0x8c4)
[  205.717697] [<8022d808>] (do_sys_poll) from [<8022db0c>] (do_restart_poll+0x80/0xd4)
[  205.725461] [<8022db0c>] (do_restart_poll) from [<8004f660>] (sys_restart_syscall+0x30/0x34)
[  205.733918] [<8004f660>] (sys_restart_syscall) from [<800151a0>] (ret_fast_syscall+0x0/0x1c)
[  205.742351] Showing busy workqueues and worker pools:
[  205.747406] workqueue events: flags=0x0
[  205.751243]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256
[  205.757304]     in-flight: 23:check_carrier
[  205.761551] pool 4: cpus=2 node=0 flags=0x0 nice=0 hung=0s workers=4 idle: 61 77 65
</console>

Killing iio_generic_buffer works.
<console>
/ # kill 123
/ # Caught signal 15
failed to open /sys/bus/iio/devices/iio:device0/buffer/enable
Failed to disable buffer: No such file or directory
Enabling/disabling channels: can't open /sys/bus/iio/devices/iio:device0/scan_elements
Failed to disable all channels
[1]+  Done(241)                  iio_generic_buffer -a -N 0 -l 2 -c -1
/ # 
</console>

This situation happens when the device is being unregistered
(iio_device_unregister()) while a userspace process is executing the poll
syscall.
If device has vanished before running the iio_buffer_fileops poll hook, the
latter will keep returning no events and process will be stalled waiting for
events that will never come if no timeout has been specified.

This patch fixes this by ensuring iio_buffer_poll() returns POLLERR if device
has been previously unregistered. Userspace process will be properly notified
something wrong happened so that it may take appropriate action.

Running the same test as above will now show.
<console>
/ # iio_generic_buffer -a -N 0 -l 2 -c -1 & sleep 1; rmmod zpa2326_i2c
iio device number being used is 0
iio trigger number being used is 0
No channels are enabled, enabling all channels
Enabling: in_pressure_en
Enabling: in_timestamp_en
Enabling: in_temp_en
/sys/bus/iio/devices/iio:device0 zpa2326-dev0
103.679695 31680.718750 54318428312 
103.684631 31680.718750 54381713521 
103.682693 31680.718750 54444999458 
103.681694 31784.558594 54508288521 
103.679878 31784.558594 54571584458 
103.680756 31784.558594 54634876698 
103.677002 31784.558594 54698161020 
103.682755 31784.558594 54761463208 
103.681816 31784.558594 54824749979 
103.673004 31784.558594 54888037583 
103.675819 31784.558594 54951331958 
103.679878 31784.558594 55014612270 
103.671066 31784.558594 55077905447 
103.683693 31784.558594 55141192583 
failed to open /sys/bus/iio/devices/iio:device0/buffer/enable
Failed to disable buffer: No such file or directory
Enabling/disabling channels: can't open /sys/bus/iio/devices/iio:device0/scan_elements
Failed to disable all channels
[1]+  Done(1)                    iio_generic_buffer -a -N 0 -l 2 -c -1
</console>

Regards,
Gregor.

Gregor Boirie (1):
  iio:buffer: let poll report an error for unregistered devices

 drivers/iio/industrialio-buffer.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.1.4
