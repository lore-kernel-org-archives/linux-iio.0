Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30864 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752567AbcBVPRa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 22 Feb 2016 10:17:30 -0500
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Darshana Padmadas <darshanapadmadas@gmail.com>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	Crt Mori <cmo@melexis.com>,
	"Masanari Iida" <standby24x7@gmail.com>,
	Harald Geyer <harald@ccbib.org>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v3 0/1] iio:core: introduce timestamping clock selection
Date: Mon, 22 Feb 2016 16:17:19 +0100
Message-ID: <cover.1456153753.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO timestamping clock selection support based on the following principles :
* selected timestamping clock is a per-device attribute which the userspace
  may access through a sysfs file ;
* a single reference clock is used for both buffered samples and events of a
  given device at the same time ;
* userspace may choose amongst the following subset of available POSIX clocks:
  CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW, CLOCK_REALTIME_COARSE,
  CLOCK_MONOTONIC_COARSE, CLOCK_BOOTTIME and CLOCK_TAI ;
* sample and event timestamps consistency with respect to clock changes is
  ensured by rejecting the ability to select a new clock as long as an events
  chrdev is opened or a buffered samples channel is enabled for a given device.
* no in-kernel API support since :
  * consumers work synchronously in direct mode, i.e. timestamping may be
    peformed using traditional kernel time keeping ;
  * any given device can only feed a single timestamping channel to all
    consumers.

Changes since v1:
* isolate clock setup from sysfs
* rename timestamping clock sysfs entry to "timestamp_clock"
* make the "timestamp_clock" file content a self-describing string
* merge all 3 patches into a single one
* cosmetics
* rebase onto IIO testing branch

Changes since v2:
* rename timestamping clock sysfs entry to "current_timestamp_clock" to allow a
  futur refinement exposing available clocks through a
  "timestamp_clock_available" sysfs entry
* rename clock ids (remove "CLOCK_" prefix + lower case)
* checkpatch'ed
* rebase onto IIO testing branch

Regards.
Gregor Boirie (1):
  iio:core: timestamping clock selection support

 Documentation/ABI/testing/sysfs-bus-iio           |   7 +
 Documentation/DocBook/iio.tmpl                    |   2 +-
 drivers/iio/accel/bma180.c                        |   2 +-
 drivers/iio/accel/bmc150-accel-core.c             |   4 +-
 drivers/iio/accel/kxcjk-1013.c                    |   2 +-
 drivers/iio/accel/mma7455_core.c                  |   3 +-
 drivers/iio/accel/mma8452.c                       |   4 +-
 drivers/iio/accel/mma9551.c                       |   2 +-
 drivers/iio/accel/mma9553.c                       |   2 +-
 drivers/iio/adc/ad7291.c                          |   2 +-
 drivers/iio/adc/ad7298.c                          |   2 +-
 drivers/iio/adc/ad7476.c                          |   2 +-
 drivers/iio/adc/ad7887.c                          |   2 +-
 drivers/iio/adc/ad7923.c                          |   2 +-
 drivers/iio/adc/ad799x.c                          |   4 +-
 drivers/iio/adc/cc10001_adc.c                     |   2 +-
 drivers/iio/adc/hi8435.c                          |   2 +-
 drivers/iio/adc/ina2xx-adc.c                      |   6 +-
 drivers/iio/adc/max1363.c                         |   5 +-
 drivers/iio/adc/ti-ads1015.c                      |   3 +-
 drivers/iio/adc/vf610_adc.c                       |   3 +-
 drivers/iio/adc/xilinx-xadc-events.c              |   4 +-
 drivers/iio/chemical/atlas-ph-sensor.c            |   2 +-
 drivers/iio/dac/ad5421.c                          |   6 +-
 drivers/iio/dac/ad5504.c                          |   2 +-
 drivers/iio/dummy/iio_simple_dummy_buffer.c       |   3 +-
 drivers/iio/dummy/iio_simple_dummy_events.c       |   2 +-
 drivers/iio/gyro/bmg160_core.c                    |  30 ++--
 drivers/iio/humidity/dht11.c                      |  16 +-
 drivers/iio/iio_core.h                            |   3 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c        |   2 +-
 drivers/iio/industrialio-core.c                   | 179 +++++++++++++++++++++-
 drivers/iio/industrialio-event.c                  |  19 ++-
 drivers/iio/industrialio-trigger.c                |   2 +-
 drivers/iio/light/acpi-als.c                      |   2 +-
 drivers/iio/light/adjd_s311.c                     |   2 +-
 drivers/iio/light/apds9300.c                      |   2 +-
 drivers/iio/light/apds9960.c                      |   4 +-
 drivers/iio/light/cm36651.c                       |   2 +-
 drivers/iio/light/gp2ap020a00f.c                  |   8 +-
 drivers/iio/light/isl29125.c                      |   2 +-
 drivers/iio/light/lm3533-als.c                    |   2 +-
 drivers/iio/light/ltr501.c                        |   7 +-
 drivers/iio/light/opt3001.c                       |   4 +-
 drivers/iio/light/stk3310.c                       |   2 +-
 drivers/iio/light/tcs3414.c                       |   2 +-
 drivers/iio/light/tcs3472.c                       |   2 +-
 drivers/iio/light/tsl2563.c                       |   2 +-
 drivers/iio/light/us5182d.c                       |   2 +-
 drivers/iio/magnetometer/hmc5843_core.c           |   2 +-
 drivers/iio/magnetometer/mag3110.c                |   2 +-
 drivers/iio/pressure/mpl3115.c                    |   2 +-
 drivers/iio/pressure/ms5611_core.c                |   3 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c |   2 +-
 drivers/iio/proximity/sx9500.c                    |   4 +-
 drivers/staging/iio/accel/lis3l02dq_core.c        |   2 +-
 drivers/staging/iio/accel/sca3000_core.c          |   2 +-
 drivers/staging/iio/adc/ad7280a.c                 |   8 +-
 drivers/staging/iio/adc/ad7606_ring.c             |   3 +-
 drivers/staging/iio/adc/ad7816.c                  |   3 +-
 drivers/staging/iio/addac/adt7316.c               |   4 +-
 drivers/staging/iio/cdc/ad7150.c                  |   2 +-
 drivers/staging/iio/light/tsl2x7x_core.c          |   2 +-
 include/linux/iio/iio.h                           |  22 ++-
 64 files changed, 326 insertions(+), 115 deletions(-)

-- 
2.1.4

