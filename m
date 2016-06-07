Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58506 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161320AbcFGSfq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jun 2016 14:35:46 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Subject: [PULL] First set of IIO fixes for the 4.7 cycle
Message-ID: <2db2405d-3a99-1d1c-d98b-fa51fe2fe587@kernel.org>
Date: Tue, 7 Jun 2016 19:35:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 5c69585837686e127762bd20658b18c14dfaf57c:

  staging: comedi: mite: tidy up module init/exit (2016-05-03 14:11:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.7a

for you to fetch changes up to 94bef000f1d4aa111f4ddda1482cf3b30ad069ce:

  iio: hudmidity: hdc100x: fix incorrect shifting and scaling (2016-06-03 13:25:33 +0100)

----------------------------------------------------------------
First round of iio fixes for the 4.7 cycle.

A slightly bumper set due to travel delaying the pull request and a fair few
issues with the recent merge window patches.  Patches all over the place.
The st-sensors one is probably the most involved, but definitly solves the
issues seen.  Note there are some other issues around that handler
(and the fact that a lot of boards tie a level interrupt chip to an
edge interrupt only irq chip).  These are not regressions however, so
will turn up the slow route.

* core
  - iio_trigger_attach_pollfunc had some really badly wrong error handling.
  Another nasty triggered whilst chasing down issues with the st sensors
  rework below.
* ad5592r
  - fix an off by one error when allocating channels.
* am2315
  - a stray mutex unlock before we ever take the lock.
* apds9960
  - missing a parent in the driver model (which should be the i2c device).
  Result is it doesn't turn up under /sys/bus/i2c/devices which some
  userspace code uses for repeatable device identification.
* as3935
  - ABI usage bug which meant a processed value was reported as raw. Now
    reporting scale as well to ensure userspace has the info it needs.
  - Don't return processed value via the buffer - it doesn't conform to
    the ABI and will overflow in some cases.
  - Fix a wrongly sized buffer which would overflow trashing part of the
    stack.  Also move it onto the heap as part of the fix.
* bh1780
  - a missing return after write in debugfs lead to an incorrect read and
    a null pointer dereference.
  - dereferencing the wrong pointer in suspend and resume leading to
    unpredictable results.
  - assign a static name to avoid accidentally ending up with no name if
    loaded via device tree.
* bmi160
  - output data rate for the accelerometer was incorrectly reported. Fix it.
  - writing the output data rate was also wrong due to reverse parameters.
* bmp280
  - error message for wrong chip ID gave the wrong expected value.
* hdc100x
  - mask for writing the integration time was wrong allowin g us to get
  'stuck' in a particular value with no way back.
  - temperature reported in celsius rather than millicelsius as per the
  ABI.
  - Get rid of some incorrect data shifting which lead to readings being
  rather incorrect.
* max44000
  - drop scale attribute for proximity as it is an unscaled value (depends
    on what is in range rather than anything knowable at the detector).
* st-pressure
  - ABI compliance fixes - units were wrong.
* st-sensors
  - We introduced some nasty issues with the recent switch over to a
  a somewhat threaded handler in that we broke using a software trigger
  with these devices.  Now do it properly.  It's a larger patch than ideal
  for a fix, but the logic is straight forward.
  - Make sure the trigger is initialized before requesting the interrupt.
  This matters now the interrupt can be shared. Before it was ugly and wrong
  but short of flakey hardware could not be triggered.
  - Hammer down the dataready pin at boot - otherwise with really
  unlucky timing things could get interestingly wedged requiring a hard power
  down of the chip.

----------------------------------------------------------------
Akinobu Mita (1):
      iio: pressure: bmp280: fix error message for wrong chip id

Alison Schofield (1):
      iio: humidity: hdc100x: correct humidity integration time mask

Crestez Dan Leonard (4):
      max44000: Remove scale from proximity
      iio: st_sensors: Init trigger before irq request
      iio: st_sensors: Disable DRDY at init time
      iio: Fix error handling in iio_trigger_attach_poll_func

Dan Carpenter (2):
      iio: dac: ad5592r: Off by one bug in ad5592r_alloc_channels()
      iio: humidity: am2315: Remove a stray unlock

Daniel Baluta (2):
      iio: bmi160: Fix output data rate for accel
      iio: bmi160: Fix ODR setting

Gregor Boirie (1):
      iio:st_pressure: fix sampling gains (bring inline with ABI)

Linus Walleij (4):
      iio: light: bh1780: return after write
      iio: bh1780: dereference the client properly
      iio: light: bh1780: assign a static name
      iio: st_sensors: switch to a threaded interrupt

Matt Ranostay (5):
      iio: proximity: as3935: correct IIO_CHAN_INFO_RAW output
      iio: proximity: as3935: remove triggered buffer processing
      iio: proximity: as3935: fix buffer stack trashing
      iio: humidity: hdc100x: fix IIO_TEMP channel reporting
      iio: hudmidity: hdc100x: fix incorrect shifting and scaling

Yong Li (1):
      iio: light apds9960: Add the missing dev.parent

 .../ABI/testing/sysfs-bus-iio-proximity-as3935     |  2 +-
 drivers/iio/accel/st_accel_buffer.c                |  2 +-
 drivers/iio/accel/st_accel_core.c                  |  1 +
 drivers/iio/common/st_sensors/st_sensors_buffer.c  | 25 ++----
 drivers/iio/common/st_sensors/st_sensors_core.c    |  8 ++
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 96 ++++++++++++++++++++--
 drivers/iio/dac/ad5592r-base.c                     |  2 +-
 drivers/iio/gyro/st_gyro_buffer.c                  |  2 +-
 drivers/iio/gyro/st_gyro_core.c                    |  1 +
 drivers/iio/humidity/am2315.c                      |  4 +-
 drivers/iio/humidity/hdc100x.c                     | 20 ++---
 drivers/iio/imu/bmi160/bmi160_core.c               | 16 ++--
 drivers/iio/industrialio-trigger.c                 | 23 ++++--
 drivers/iio/light/apds9960.c                       |  1 +
 drivers/iio/light/bh1780.c                         | 10 ++-
 drivers/iio/light/max44000.c                       |  1 -
 drivers/iio/magnetometer/st_magn_buffer.c          |  2 +-
 drivers/iio/magnetometer/st_magn_core.c            |  1 +
 drivers/iio/pressure/bmp280.c                      |  4 +-
 drivers/iio/pressure/st_pressure_buffer.c          |  2 +-
 drivers/iio/pressure/st_pressure_core.c            | 81 +++++++++++-------
 drivers/iio/proximity/as3935.c                     | 17 ++--
 include/linux/iio/common/st_sensors.h              |  9 +-
 23 files changed, 230 insertions(+), 100 deletions(-)
