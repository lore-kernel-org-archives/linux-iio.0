Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41319 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab3FHJP1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2013 05:15:27 -0400
Message-ID: <51B2F62C.6010709@kernel.org>
Date: Sat, 08 Jun 2013 10:15:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO cleanups, new stuff and staging graduations (IIO set 2
 for the 3.11 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit b164935b38d64557a32892e7aa45e213e9d11ea8:

  staging: MIPS: add Octeon USB HCD support (2013-06-03 12:45:03 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.11b

for you to fetch changes up to 78f304d06c47d600ec1a4b0995f1f4c5667a677e:

  iio:trigger:interrupt fix formatting of rsize variable in name (2013-06-08 10:00:58 +0100)

----------------------------------------------------------------
Second round of IIO new stuff and cleanups for the 3.11 cycle.

1) Pressure sensor support in the st sensors driver - LPS331AP currently.
2) Graduation of generic interrupt from staging with some related cleanup.
3) A number of platform_set_drvdata on remove removals.
4) 2 conditional build changes to prevent device tree structures from being
   built in when device tree isn't enabled.  These just save a bit of space
   rather than being strictly required at the moment.
5) A couple of strict_strtoul -> kstrtoul conversions.

----------------------------------------------------------------
Denis CIOCCA (3):
      iio:common: ST_SENSORS_LSM_CHANNELS macro changed
      iio:common: Removed stuff macros, added num_data_channels on st_sensors struct and added support on one-shot sysfs
reads to 3 byte channel
      iio:pressure: Add STMicroelectronics pressures driver

Jingoo Han (1):
      iio: replace strict_strtoul() with kstrtoul()

Jonathan Cameron (5):
      staging:iio:trigger:gpio bug in release of gpio in error path
      staging:iio:triggers: rename iio-trig-gpio to iio-trig-interrupt
      staging:iio:triggers:interrupt trigger - one per platform device.
      iio:triggers:interrupt trigger - move out of staging.
      iio:trigger:interrupt fix formatting of rsize variable in name

Michael Hennerich (1):
      iio: frequency: adf4350: cast value to unsigned to make code checkers happy

Sachin Kamat (5):
      iio: at91_adc: Add missing CONFIG_OF macro
      staging: iio: ad7606_par: Remove redundant platform_set_drvdata()
      staging: iio: spear_adc: Remove redundant platform_set_drvdata()
      staging: iio: lpc32xx_adc: Remove redundant platform_set_drvdata()
      staging: iio: spear_adc: Add missing CONFIG_OF macro

 drivers/iio/Kconfig                               |   1 +
 drivers/iio/Makefile                              |   1 +
 drivers/iio/accel/st_accel_core.c                 |  39 +++-
 drivers/iio/adc/at91_adc.c                        |   2 +
 drivers/iio/adc/max1363.c                         |   2 +-
 drivers/iio/common/st_sensors/st_sensors_buffer.c |  61 +++--
 drivers/iio/common/st_sensors/st_sensors_core.c   |  34 ++-
 drivers/iio/gyro/st_gyro_core.c                   |  24 +-
 drivers/iio/magnetometer/st_magn_core.c           |  39 +++-
 drivers/iio/pressure/Kconfig                      |  35 +++
 drivers/iio/pressure/Makefile                     |  10 +
 drivers/iio/pressure/st_pressure.h                |  39 ++++
 drivers/iio/pressure/st_pressure_buffer.c         | 105 +++++++++
 drivers/iio/pressure/st_pressure_core.c           | 272 ++++++++++++++++++++++
 drivers/iio/pressure/st_pressure_i2c.c            |  77 ++++++
 drivers/iio/pressure/st_pressure_spi.c            |  76 ++++++
 drivers/iio/trigger/Kconfig                       |   9 +
 drivers/iio/trigger/Makefile                      |   1 +
 drivers/iio/trigger/iio-trig-interrupt.c          | 121 ++++++++++
 drivers/iio/trigger/iio-trig-sysfs.c              |   4 +-
 drivers/staging/iio/adc/ad7606_par.c              |   2 -
 drivers/staging/iio/adc/lpc32xx_adc.c             |   1 -
 drivers/staging/iio/adc/spear_adc.c               |   3 +-
 drivers/staging/iio/trigger/Kconfig               |   6 -
 drivers/staging/iio/trigger/Makefile              |   1 -
 drivers/staging/iio/trigger/iio-trig-gpio.c       | 167 -------------
 include/linux/iio/common/st_sensors.h             |  24 +-
 include/linux/iio/frequency/adf4350.h             |   4 +-
 28 files changed, 900 insertions(+), 260 deletions(-)
 create mode 100644 drivers/iio/pressure/Kconfig
 create mode 100644 drivers/iio/pressure/Makefile
 create mode 100644 drivers/iio/pressure/st_pressure.h
 create mode 100644 drivers/iio/pressure/st_pressure_buffer.c
 create mode 100644 drivers/iio/pressure/st_pressure_core.c
 create mode 100644 drivers/iio/pressure/st_pressure_i2c.c
 create mode 100644 drivers/iio/pressure/st_pressure_spi.c
 create mode 100644 drivers/iio/trigger/iio-trig-interrupt.c
 delete mode 100644 drivers/staging/iio/trigger/iio-trig-gpio.c
