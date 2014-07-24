Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:54343 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933322AbaGXTSZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 24 Jul 2014 15:18:25 -0400
Message-ID: <53D15C8F.1050300@kernel.org>
Date: Thu, 24 Jul 2014 20:20:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers, features and cleanups for 3.17 - set 4
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit db7c17ecbf4d6328597047c4e4d6e8914945477c:

   Merge tag 'iio-for-3.17c' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2014-07-13 12:31:47 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.17d

for you to fetch changes up to e6ca2d848c9b7b292d22cbf6fe10019ccab72345:

   ARM: dts: Fix wrong compatible string for Exynos3250 ADC (2014-07-23 21:59:03 +0100)

----------------------------------------------------------------
Fourth round of IIO new drivers, functionality and cleanups for the 3.17 cycle

New functionality
* A new modifier to indicate that a rotation is relative to either
   true or magnetic north.  This is to be used by some magnetometers
   that provide data in this way.
* hid magnetometer now supports output rotations from various variants on
   North
* HMC5843 driver converted to regmap and reworked to allow easy support
   of other similar devices.  Support for HMC5983 added via both i2c and SPI.
* Rework of Exynos driver to simplify extension to support more devices.
* Addition of support for the Exynos3250 ADC (which requires an additional
   clock)  Support for quite a few more devices on its way.

Cleanups
* ad7997 - a number of cleanups and tweaks to how the events are controlled
   to make it more intuitive.
* kxcjk - cleanups and minor fixes for this new driver.

----------------------------------------------------------------
Chanwoo Choi (4):
       iio: adc: exynos_adc: Add exynos_adc_data structure to improve readability
       iio: adc: exynos_adc: Control special clock of ADC to support Exynos3250 ADC
       iio: devicetree: Add DT binding documentation for Exynos3250 ADC
       ARM: dts: Fix wrong compatible string for Exynos3250 ADC

Josef Gajdusek (5):
       staging:iio:hmc5843: Added regmap support
       staging:iio:hmc5843: Split hmc5843.c to multiple files
       staging:iio:hmc5843: register <-> value arrays now can have different lengths
       staging:iio:hmc5843: Add support for i2c hmc5983
       staging:iio:hmc5843: Add support for spi hmc5983

Peter Meerwald (11):
       iio:adc:ad799x: Drop I2C access helper functions
       iio:adc:ad799x: Save some lines in ad7997_8_update_scan_mode() exit handling
       iio:adc:ad799x: Use BIT() and GENMASK()
       iio:adc:ad799x: Only expose event interface when IRQ is available
       iio:adc:ad799x: Make chan_spec const in ad799x_chip_config struct
       iio:adc:ad799x: Add helper function to read/write config register
       iio:adc:ad799x: Write default config on probe and reset alert status on probe
       iio:adc:ad799x: Set conversion channels and rename ad7997_8_update_scan_mode()
       iio:adc:ad799x: Return more meaningful event enabled state
       iio:adc:ad799x: Allow writing of event config
       iio:kxcjk-1013: Fix endianness in scan_type

Reyad Attiyat (4):
       iio: Documentation: Add documentation for rotation from north sensor usage attributes
       iio: types: Added support for rotation from north usage attributes
       iio: hid-sensor-magn-3d: Scan for usage attributes before setting up iio channels
       iio: hid-sensor-magn-3d: Add support for rotation from north

Srinivas Pandruvada (3):
       iio: accel: kxcjk-1013: Fix setting frequency
       iio: accel: kxcjk-1013: Use try_reenable to ack intr
       iio: accel: kxcjk-1013: Increment ref counter for indio_dev->trig

  Documentation/ABI/testing/sysfs-bus-iio            |  82 ++++
  .../devicetree/bindings/arm/samsung/exynos-adc.txt |  25 +-
  .../bindings/iio/magnetometer/hmc5843.txt          |   1 +
  arch/arm/boot/dts/exynos3250.dtsi                  |   5 +-
  drivers/iio/accel/kxcjk-1013.c                     |  38 +-
  drivers/iio/adc/ad799x.c                           | 504 ++++++++++++---------
  drivers/iio/adc/exynos_adc.c                       | 335 ++++++++++----
  drivers/iio/industrialio-core.c                    |   4 +
  drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 202 +++++++--
  drivers/staging/iio/magnetometer/Kconfig           |  30 +-
  drivers/staging/iio/magnetometer/Makefile          |   4 +-
  drivers/staging/iio/magnetometer/hmc5843.h         |  59 +++
  .../iio/magnetometer/{hmc5843.c => hmc5843_core.c} | 268 ++++++-----
  drivers/staging/iio/magnetometer/hmc5843_i2c.c     | 104 +++++
  drivers/staging/iio/magnetometer/hmc5843_spi.c     | 100 ++++
  include/linux/iio/types.h                          |   4 +
  16 files changed, 1262 insertions(+), 503 deletions(-)
  create mode 100644 drivers/staging/iio/magnetometer/hmc5843.h
  rename drivers/staging/iio/magnetometer/{hmc5843.c => hmc5843_core.c} (72%)
  create mode 100644 drivers/staging/iio/magnetometer/hmc5843_i2c.c
  create mode 100644 drivers/staging/iio/magnetometer/hmc5843_spi.c
