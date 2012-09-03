Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46645 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756447Ab2ICUIP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Sep 2012 16:08:15 -0400
Message-ID: <50450E2E.3060005@kernel.org>
Date: Mon, 03 Sep 2012 21:08:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new device support and cleanups (set 2 for the 3.7 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 8f8b77bfdce811acbcf2248219a7aab5f92de938:

  Merge 3.6-rc3 into staging-next (2012-08-27 07:10:40 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-v3.7b

for you to fetch changes up to 0f8c9620046d698b8a00d38d25dcdc1d2fa23592:

  staging:iio: Update email address for Jonathan Cameron. (2012-09-03 20:26:46 +0100)

----------------------------------------------------------------
Second set of IIO rework and new drivers for the 3.7 cycle.

Firstly we have the second half of a series reworking support for
the various sigma delta ADCs from Analog.  The first half was fixes
that have already merged in the v3.6 cycle.  Other than some
little cleanups this mainly consists of a unifying library module
that the various drivers can then use.  Another new driver is
using this undergoing revisions and the code reduction already
seen from this is considerable.  A nice piece of work.

Secondly we have a good number of tidying up patches from various
sources doing things like adding include guards and removing
unintended header ordering requirements.  Also a mass annotation
of missing __devinit/exit.  Peter Meerwald has been getting around
with cleanup of lis3l02dq, documentation fixes, white space clenaups
and a small issue with my spelling ;)

Thirdly we have some improvements to our kfifo usage that have
been around for a while but are now suddenly in demand from a
number of users.

Forth we have some clk_prepare_enable and clk_prepare_disable
cleanups.

Fifth is the addition of i2c dacs to the ad5446 driver

Finally we have some email address updates. I'll do the
MAINTAINERS one separately.

So a general mixed bag but nothing terribly controversial
or 'exciting'.

----------------------------------------------------------------
Jean-Francois Dagenais (2):
      iio:ad5446: Add support for I2C based DACs
      iio:ad5446: get rid of private header file

Jonathan Cameron (5):
      iio:kfifo_buf Take advantage of the fixed record size used in IIO
      iio:kfifo_buf improve error handling in read_first_n.
      iio: kfifo - add poll support.
      IIO: Update email address for Jonathan Cameron.
      staging:iio: Update email address for Jonathan Cameron.

Julia Lawall (2):
      drivers/staging/iio/adc/spear_adc.c: use clk_prepare_enable and clk_disable_unprepare
      drivers/iio/adc/at91_adc.c: use clk_prepare_enable and clk_disable_unprepare

Kim, Milo (1):
      iio: use IIO_CHAN_INFO_RAW rather than 0

Lars-Peter Clausen (13):
      staging:iio:ad7793: Remove unused platform_data from device state struct
      staging:iio:ad7192: Remove unused platform_data from device state struct
      iio: Introduce iio_device_{set,get}_drvdata()
      iio:adc: Add common code for ADI Sigma Delta devices
      staging:iio:ad7780: Use common Sigma Delta library
      staging:iio:ad7793: Use common Sigma Delta library
      staging:iio:ad7192: Use common Sigma Delta library
      staging:iio:ad7793: Add support for ad7794/ad7795
      staging:iio:ad7793: Add ad7785 support
      iio:consumer.h: Fix include guard
      iio: Add missing include guards to headers
      iio:trigger_consumer.h: Add missing includes and forward declarations
      staging:iio: Add missing __devinit and __devexit annotations

Peter Meerwald (5):
      staging iio: lis3l02dq cleanup
      iio: document missing elements
      iio: fix typos
      iio: whitespace cleanup and removal of semicolon after functions
      iio: fix spelling of subsystem

 drivers/iio/Kconfig                                |   2 +-
 drivers/iio/adc/Kconfig                            |   5 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad_sigma_delta.c                   | 558 +++++++++++++++++
 drivers/iio/adc/at91_adc.c                         |  33 +-
 drivers/iio/dac/Kconfig                            |   9 +-
 drivers/iio/dac/ad5446.c                           | 429 +++++++++----
 drivers/iio/dac/ad5446.h                           |  91 ---
 drivers/iio/industrialio-buffer.c                  |  10 +-
 drivers/iio/industrialio-core.c                    |   6 +-
 drivers/iio/inkern.c                               |   6 +-
 drivers/iio/kfifo_buf.c                            |  28 +-
 drivers/staging/iio/Kconfig                        |   2 +-
 drivers/staging/iio/TODO                           |   2 +-
 drivers/staging/iio/accel/adis16201_core.c         |   2 +-
 drivers/staging/iio/accel/adis16203_core.c         |   2 +-
 drivers/staging/iio/accel/adis16204_core.c         |   2 +-
 drivers/staging/iio/accel/adis16209_core.c         |   2 +-
 drivers/staging/iio/accel/adis16220_core.c         |   2 +-
 drivers/staging/iio/accel/adis16240_core.c         |   2 +-
 drivers/staging/iio/accel/kxsd9.c                  |   4 +-
 drivers/staging/iio/accel/lis3l02dq.h              |  14 +-
 drivers/staging/iio/accel/lis3l02dq_core.c         |  10 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c         |  28 +-
 drivers/staging/iio/accel/sca3000.h                |   2 +-
 drivers/staging/iio/accel/sca3000_core.c           |   6 +-
 drivers/staging/iio/accel/sca3000_ring.c           |   2 +-
 drivers/staging/iio/adc/Kconfig                    |  13 +-
 drivers/staging/iio/adc/ad7192.c                   | 521 ++--------------
 drivers/staging/iio/adc/ad7476_core.c              |   2 +-
 drivers/staging/iio/adc/ad7780.c                   | 188 +++---
 drivers/staging/iio/adc/ad7793.c                   | 688 ++++-----------------
 drivers/staging/iio/adc/ad7793.h                   |  10 +-
 drivers/staging/iio/adc/ad7887_core.c              |   2 +-
 drivers/staging/iio/adc/max1363_core.c             |   6 +-
 drivers/staging/iio/adc/spear_adc.c                |  25 +-
 drivers/staging/iio/gyro/adis16060_core.c          |   4 +-
 drivers/staging/iio/gyro/adis16080_core.c          |   2 +-
 drivers/staging/iio/gyro/adis16130_core.c          |   2 +-
 drivers/staging/iio/gyro/adis16260_core.c          |   2 +-
 drivers/staging/iio/gyro/adxrs450_core.c           |   2 +-
 drivers/staging/iio/iio_dummy_evgen.c              |   2 +-
 drivers/staging/iio/iio_hwmon.c                    |   2 +-
 drivers/staging/iio/iio_simple_dummy.c             |   2 +-
 drivers/staging/iio/imu/adis16400.h                |   2 +-
 drivers/staging/iio/imu/adis16400_core.c           |   4 +-
 drivers/staging/iio/light/tsl2563.c                |   2 +-
 drivers/staging/iio/magnetometer/hmc5843.c         |   2 +-
 drivers/staging/iio/meter/ade7753.c                |   2 +-
 drivers/staging/iio/meter/ade7754.c                |   2 +-
 drivers/staging/iio/meter/ade7758_core.c           |   2 +-
 drivers/staging/iio/meter/ade7759.c                |   2 +-
 drivers/staging/iio/meter/ade7854-spi.c            |   2 +-
 drivers/staging/iio/ring_hw.h                      |   2 +-
 drivers/staging/iio/trigger/iio-trig-gpio.c        |   8 +-
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |   8 +-
 include/linux/iio/adc/ad_sigma_delta.h             | 173 ++++++
 include/linux/iio/consumer.h                       |   2 +-
 include/linux/iio/iio.h                            |  43 +-
 include/linux/iio/kfifo_buf.h                      |   3 +
 include/linux/iio/machine.h                        |   5 +
 include/linux/iio/trigger.h                        |  13 +-
 include/linux/iio/trigger_consumer.h               |  11 +
 63 files changed, 1521 insertions(+), 1500 deletions(-)
 create mode 100644 drivers/iio/adc/ad_sigma_delta.c
 delete mode 100644 drivers/iio/dac/ad5446.h
 create mode 100644 include/linux/iio/adc/ad_sigma_delta.h
