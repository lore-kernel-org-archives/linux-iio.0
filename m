Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54971 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab2IIJLR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 9 Sep 2012 05:11:17 -0400
Message-ID: <504C5D32.5030903@kernel.org>
Date: Sun, 09 Sep 2012 10:11:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new device support and cleanups (set 3 for the 3.7 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 107f04bbce331bf622b901ccec34a124e6b78584:

  staging: usbip: vhci_hcd: fixed suspend-resume loop (2012-09-06 09:31:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.7c

for you to fetch changes up to 932323b74e2535dbb6a1b245dfa1aa8cd2bbd8e2:

  iio: isl29018: Support fractional ALS scaling. (2012-09-08 10:25:10 +0100)

----------------------------------------------------------------
Third set of IIO rework and new drivers for the 3.7 cycle.

This set includes:

1) HID sensor drivers. This includes a core elements in the
HID subsystem merged through the IIO tree because we have some
ABI changes outstanding (some in this set) which will effect them.
The HID sensors specification covers an extremely wide range of
sensors so we will probably be seeing lots more elements of this
as the hardware hits the market.

2) Some general abi cleanups to use the utility function
iio_push_to_buffer and to drop the used timestamp parameter
from the same call.  For a long time timestamps have taken
the same path as all other channel types into the buffers so
it is good to clean this out.

3) More ADC driver support for Analog Devices parts in the form
of one new driver and some additional supported parts via current
drivers.

4) An increase to the accuracy of the calibration scale for
the isl29018 driver.

So a mixed bag, but all good additions to IIO.

----------------------------------------------------------------
Bryan Freed (1):
      iio: isl29018: Support fractional ALS scaling.

Jonathan Cameron (1):
      staging:iio: hid-sensors Use iio_push_to_buffer

Lars-Peter Clausen (6):
      staging:iio:sysfs-trigger: Use irq_work to properly active trigger
      staging:iio: Use iio_push_to_buffer
      iio: Drop timestamp parameter from buffer store_to callback
      iio:ad5446: Add support for the ad5300/ad5310/ad5320
      iio:ad5446: Add device ids for ad5301/ad5311/ad5321
      staging:iio:adc: Add AD7791 driver

srinivas pandruvada (9):
      iio: core: Add hysteresis in channel spec
      HID: sensors: add documentation
      HID: sensors: add to special driver list
      HID: sensors: introduce sensor framework
      iio: hid-sensors: Common attribute and trigger
      iio: hid-sensors: Added accelerometer 3D
      iio: hid-sensors: Added Gyroscope 3D
      iio: hid-sensors: Added Compass/Magnetometer 3D
      iio: hid-sensors: Added ALS

 Documentation/hid/hid-sensor.txt                   | 140 +++++
 drivers/hid/Kconfig                                |  14 +
 drivers/hid/Makefile                               |   1 +
 drivers/hid/hid-core.c                             |   5 +
 drivers/hid/hid-ids.h                              |   6 +
 drivers/hid/hid-sensor-hub.c                       | 695 +++++++++++++++++++++
 drivers/iio/Kconfig                                |   5 +
 drivers/iio/Makefile                               |   5 +
 drivers/iio/accel/Kconfig                          |  16 +
 drivers/iio/accel/Makefile                         |   5 +
 drivers/iio/accel/hid-sensor-accel-3d.c            | 418 +++++++++++++
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7266.c                           |   2 +-
 drivers/iio/adc/ad7791.c                           | 460 ++++++++++++++
 drivers/iio/adc/ad_sigma_delta.c                   |   2 +-
 drivers/iio/adc/at91_adc.c                         |   2 +-
 drivers/iio/common/Kconfig                         |   5 +
 drivers/iio/common/Makefile                        |   9 +
 drivers/iio/common/hid-sensors/Kconfig             |  26 +
 drivers/iio/common/hid-sensors/Makefile            |   6 +
 .../iio/common/hid-sensors/hid-sensor-attributes.c | 250 ++++++++
 .../iio/common/hid-sensors/hid-sensor-attributes.h |  57 ++
 .../iio/common/hid-sensors/hid-sensor-trigger.c    | 102 +++
 .../iio/common/hid-sensors/hid-sensor-trigger.h    |  26 +
 drivers/iio/dac/Kconfig                            |   8 +-
 drivers/iio/dac/ad5446.c                           |  21 +
 drivers/iio/gyro/Kconfig                           |  16 +
 drivers/iio/gyro/Makefile                          |   5 +
 drivers/iio/gyro/hid-sensor-gyro-3d.c              | 418 +++++++++++++
 drivers/iio/industrialio-buffer.c                  |   5 +-
 drivers/iio/industrialio-core.c                    |   1 +
 drivers/iio/kfifo_buf.c                            |   3 +-
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/adjd_s311.c                      |   2 +-
 drivers/iio/light/hid-sensor-als.c                 | 385 ++++++++++++
 drivers/iio/magnetometer/Kconfig                   |  16 +
 drivers/iio/magnetometer/Makefile                  |   5 +
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 419 +++++++++++++
 drivers/staging/iio/accel/adis16201_ring.c         |   3 +-
 drivers/staging/iio/accel/adis16203_ring.c         |   5 +-
 drivers/staging/iio/accel/adis16204_ring.c         |   3 +-
 drivers/staging/iio/accel/adis16209_ring.c         |   3 +-
 drivers/staging/iio/accel/adis16240_ring.c         |   3 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c         |   3 +-
 drivers/staging/iio/adc/ad7298_ring.c              |   3 +-
 drivers/staging/iio/adc/ad7476_ring.c              |   2 +-
 drivers/staging/iio/adc/ad7606_ring.c              |   3 +-
 drivers/staging/iio/adc/ad7887_ring.c              |   2 +-
 drivers/staging/iio/adc/ad799x_ring.c              |   3 +-
 drivers/staging/iio/adc/max1363_ring.c             |   2 +-
 drivers/staging/iio/adc/mxs-lradc.c                |   2 +-
 drivers/staging/iio/gyro/adis16260_ring.c          |   3 +-
 drivers/staging/iio/iio_simple_dummy_buffer.c      |   2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   2 +-
 drivers/staging/iio/imu/adis16400_ring.c           |   2 +-
 drivers/staging/iio/light/isl29018.c               |  17 +-
 drivers/staging/iio/meter/ade7758_ring.c           |   3 +-
 drivers/staging/iio/ring_sw.c                      |   7 +-
 drivers/staging/iio/trigger/Kconfig                |   2 +
 drivers/staging/iio/trigger/iio-trig-sysfs.c       |  17 +-
 include/linux/hid-sensor-hub.h                     | 160 +++++
 include/linux/hid-sensor-ids.h                     | 112 ++++
 include/linux/iio/buffer.h                         |   6 +-
 include/linux/iio/iio.h                            |   5 +
 include/linux/platform_data/ad7791.h               |  17 +
 67 files changed, 3922 insertions(+), 55 deletions(-)
 create mode 100755 Documentation/hid/hid-sensor.txt
 create mode 100644 drivers/hid/hid-sensor-hub.c
 create mode 100644 drivers/iio/accel/Kconfig
 create mode 100644 drivers/iio/accel/Makefile
 create mode 100644 drivers/iio/accel/hid-sensor-accel-3d.c
 create mode 100644 drivers/iio/adc/ad7791.c
 create mode 100644 drivers/iio/common/Kconfig
 create mode 100644 drivers/iio/common/Makefile
 create mode 100644 drivers/iio/common/hid-sensors/Kconfig
 create mode 100644 drivers/iio/common/hid-sensors/Makefile
 create mode 100644 drivers/iio/common/hid-sensors/hid-sensor-attributes.c
 create mode 100644 drivers/iio/common/hid-sensors/hid-sensor-attributes.h
 create mode 100644 drivers/iio/common/hid-sensors/hid-sensor-trigger.c
 create mode 100644 drivers/iio/common/hid-sensors/hid-sensor-trigger.h
 create mode 100644 drivers/iio/gyro/Kconfig
 create mode 100644 drivers/iio/gyro/Makefile
 create mode 100644 drivers/iio/gyro/hid-sensor-gyro-3d.c
 create mode 100644 drivers/iio/light/hid-sensor-als.c
 create mode 100644 drivers/iio/magnetometer/Kconfig
 create mode 100644 drivers/iio/magnetometer/Makefile
 create mode 100644 drivers/iio/magnetometer/hid-sensor-magn-3d.c
 create mode 100644 include/linux/hid-sensor-hub.h
 create mode 100644 include/linux/hid-sensor-ids.h
 create mode 100644 include/linux/platform_data/ad7791.h
