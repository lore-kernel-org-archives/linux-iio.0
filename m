Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35969 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522Ab2JTJo6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 20 Oct 2012 05:44:58 -0400
Message-ID: <50827299.8000906@kernel.org>
Date: Sat, 20 Oct 2012 10:44:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL]  IIO new device support and cleanups (set 1 for the 3.8 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.8a

for you to fetch changes up to 8341dc04dfb33fbae71727ae648e20c51abc40e3:

  iio:dac: Add support for the ad5449 (2012-10-19 18:46:51 +0100)

----------------------------------------------------------------
First round of new IIO drivers and cleanups for the 3.8 cycle.

Here we have

* New driver ad5449 with the introduction of a new IIO return type
  to simplify power of 2 dividers (extremely common case).
* Some coccinelle warning fixing patches (dull but worthwhile as
  make for easier automated testing and cut down on false positives).
* Some trivial bits of formatting cleanup and spelling corrections.
* Use kcalloc in a few places for semantic reasons.
* Stop lis3l02dq driver (soon to be dropped I hope) using now non
  existent irq_to_gpio.
* Some dead code/unused variable removal
* Convert a few drivers to generic core provided functions instead
  of their own versions.

So all in all a nice new driver and a lot of worthy but dull cleanup.

----------------------------------------------------------------
Arnd Bergmann (1):
      staging/iio/lis3l02dq: fix building without irq_to_gpio

Lars-Peter Clausen (8):
      staging:iio: Remove unused DRIVER_NAME defines
      staging:iio: Don't compare boolean values with true/false
      staging:iio:lpc32xx_adc: Use resource_size instead of opencoding it
      iio: Don't compare boolean values to true/false
      iio: at91_adc: Use devm_kcalloc to allocate arrays
      iio: Use strict_strtouint instead of kstrtoul
      iio: Add a logarithmic fractional value type
      iio:dac: Add support for the ad5449

Peter Meerwald (5):
      iio: remove useless irq_enabled variable in at91
      iio: use iio_push_to_buffer() in at91 driver
      iio: fix spelling of Accelerometer in Kconfig
      staging iio: use iio_trigger_generic_data_rdy_poll() in accel/adis16209,adis16240 driver
      staging iio: consistent commas in adis16400 channel spec

Peter Senna Tschudin (1):
      drivers/staging/iio: Remove unnecessary semicolon

 drivers/iio/accel/Kconfig                     |   2 +-
 drivers/iio/adc/at91_adc.c                    |  21 +-
 drivers/iio/dac/Kconfig                       |  10 +
 drivers/iio/dac/Makefile                      |   1 +
 drivers/iio/dac/ad5449.c                      | 375 ++++++++++++++++++++++++++
 drivers/iio/dac/ad5686.c                      |   2 +-
 drivers/iio/industrialio-buffer.c             |   6 +-
 drivers/iio/industrialio-core.c               |   5 +
 drivers/iio/industrialio-event.c              |   4 +-
 drivers/iio/inkern.c                          |   5 +-
 drivers/staging/iio/accel/adis16201_core.c    |   4 +-
 drivers/staging/iio/accel/adis16203_core.c    |   2 -
 drivers/staging/iio/accel/adis16204_core.c    |   4 +-
 drivers/staging/iio/accel/adis16209_core.c    |   6 +-
 drivers/staging/iio/accel/adis16209_trigger.c |  11 +-
 drivers/staging/iio/accel/adis16220_core.c    |   2 -
 drivers/staging/iio/accel/adis16240_core.c    |   2 -
 drivers/staging/iio/accel/adis16240_trigger.c |  11 +-
 drivers/staging/iio/accel/kxsd9.c             |   2 +-
 drivers/staging/iio/accel/lis3l02dq.h         |   1 +
 drivers/staging/iio/accel/lis3l02dq_core.c    |  10 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c    |   4 +-
 drivers/staging/iio/adc/lpc32xx_adc.c         |   2 +-
 drivers/staging/iio/adc/mxs-lradc.c           |   2 +-
 drivers/staging/iio/cdc/ad7150.c              |  12 +-
 drivers/staging/iio/cdc/ad7152.c              |   2 +-
 drivers/staging/iio/cdc/ad7746.c              |   2 +-
 drivers/staging/iio/gyro/adis16260_core.c     |   6 +-
 drivers/staging/iio/iio_dummy_evgen.c         |   2 +-
 drivers/staging/iio/imu/adis16400_core.c      |  10 +-
 drivers/staging/iio/magnetometer/hmc5843.c    |   2 +-
 drivers/staging/iio/meter/ade7753.h           |   2 -
 drivers/staging/iio/meter/ade7754.h           |   2 -
 drivers/staging/iio/meter/ade7758.h           |   3 -
 drivers/staging/iio/meter/ade7759.h           |   2 -
 drivers/staging/iio/meter/ade7854.h           |   2 -
 include/linux/iio/types.h                     |   1 +
 include/linux/platform_data/ad5449.h          |  40 +++
 38 files changed, 486 insertions(+), 96 deletions(-)
 create mode 100644 drivers/iio/dac/ad5449.c
 create mode 100644 include/linux/platform_data/ad5449.h
