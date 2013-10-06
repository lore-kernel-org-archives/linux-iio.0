Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46876 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab3JFR0P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 6 Oct 2013 13:26:15 -0400
Message-ID: <5251AB64.7090302@kernel.org>
Date: Sun, 06 Oct 2013 19:26:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new driver features and cleanups for 3.13 - set 3
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit de40d1209898884ad5d15a7b5003d13f4f3263d5:

  staging: lustre: fix bug with LL_MRF_RETURN in loop_make_request (2013-09-30 20:46:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.13c

for you to fetch changes up to 3658a71b10c8471ac217983ddf2a2bdde71008af:

  staging:iio:ad9951: Use spi_sync_transfer() (2013-10-05 12:01:12 +0100)

----------------------------------------------------------------
Third set of new functionality and cleanups for IIO in the 3.13 cycle.

Driver New Functionality
* MXS - new interrupt driven touch screen support for i.MX23/28. Old
  polled implementation dropped.

Driver Cleanups
* Some spi_sync boilerplate dropped by using spi_sync_transfer
* Some switching of drivers to the fractional type for scale reading.
  Moves the ugly calculation into one place.
* Fix the documentation for *_voltage_scale which is never been correct
  or as implemented in any driver.
* HID sensor hub and children : Open the sensor hub only when someone cares.
* hmc5843 - various minor

----------------------------------------------------------------
Juergen Beisert (9):
      Staging/iio/adc/touchscreen/MXS: add proper clock handling
      Staging/iio/adc/touchscreen/MXS: distinguish i.MX23's and i.MX28's LRADC
      Staging/iio/adc/touchscreen/MXS: separate i.MX28 specific register bits
      Staging/iio/adc/touchscreen/MXS: simplify register access
      Staging/iio/adc/touchscreen/MXS: add i.MX23 support to the LRADC touchscreen driver
      Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
      Staging/iio/adc/touchscreen/MXS: remove old touchscreen detection implementation
      Staging/iio/adc/touchscreen/MXS: provide devicetree adaption
      Staging/iio: add TODO reminder

Lars-Peter Clausen (33):
      iio:ad5064: Report scale as fractional value
      iio:ad5360: Report scale as fractional value
      iio:ad5380: Report scale as fractional value
      iio:ad5421: Report scale as fractional value
      iio:ad5446: Report scale as fractional value
      iio:ad5504: Report scale as fractional value
      iio:ad5624r: Report scale as fractional value
      iio:ad5686: Report scale as fractional value
      iio:ad5755: Report scale as fractional value
      iio:ad5764: Report scale as fractional value
      iio:ad5791: Report scale as fractional value
      iio:max517: Report scale as fractional value
      iio:mcp4725: Report scale as fractional value
      iio:ad7266: Report scale as fractional value
      iio:ad7476: Report scale as fractional value
      iio:ad7791: Report scale as fractional value
      iio:at91: Report scale as fractional value
      iio:max1363: Report scale as fractional value
      staging:iio:ad7280a: Report scale as fractional value
      staging:iio:ad7606: Report scale as fractional value
      staging:iio:ad7780: Report scale as fractional value
      staging:iio:ad799x: Report scale as fractional value
      staging:iio:ad7746: Report scale as fractional value
      staging:iio:spear_adc: Report scale as fractional value
      iio: Update unit of the voltage scale in the documentation
      iio:ad5449: Use spi_sync_transfer()
      iio:adis16080: Use spi_sync_transfer()
      iio:adxrs450: Use spi_sync_transfer()
      iio:adis16130: Use spi_sync_transfer()
      staging:iio:adis16220: Use spi_sync_transfer()
      staging:iio:ad9852: Use spi_sync_transfer()
      staging:iio:ad9910: Use spi_sync_transfer()
      staging:iio:ad9951: Use spi_sync_transfer()

Peter Meerwald (6):
      staging:iio:hmc5843: Add pointer to i2c client to data struct
      staging:iio:hmc5843: Rewrite init function
      staging:iio:hmc5843: Use INFO_SAMP_FREQ
      staging:iio:hmc5843: Remove unused LSB register #defines
      staging:iio:hmc5843: Tighten comments
      staging:iio:hmc5843: Introduce helper functions to show/check list of int pairs

Srinivas Pandruvada (3):
      HID: Delay opening HID device
      IIO: call sensor hub open close function
      HID RTC: Open sensor hub open close

 Documentation/ABI/testing/sysfs-bus-iio            |   4 +-
 .../bindings/staging/iio/adc/mxs-lradc.txt         |  36 +-
 arch/arm/boot/dts/imx23.dtsi                       |   1 +
 arch/arm/boot/dts/imx28-evk.dts                    |   4 +
 arch/arm/boot/dts/imx28.dtsi                       |   1 +
 drivers/hid/hid-sensor-hub.c                       |  45 +-
 drivers/iio/adc/ad7266.c                           |  21 +-
 drivers/iio/adc/ad7476.c                           |   7 +-
 drivers/iio/adc/ad7791.c                           |  18 +-
 drivers/iio/adc/at91_adc.c                         |   6 +-
 drivers/iio/adc/max1363.c                          |   8 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   6 +
 drivers/iio/dac/ad5064.c                           |   7 +-
 drivers/iio/dac/ad5360.c                           |  11 +-
 drivers/iio/dac/ad5380.c                           |  40 +-
 drivers/iio/dac/ad5421.c                           |  16 +-
 drivers/iio/dac/ad5446.c                           |   9 +-
 drivers/iio/dac/ad5449.c                           |   7 +-
 drivers/iio/dac/ad5504.c                           |   9 +-
 drivers/iio/dac/ad5624r_spi.c                      |   9 +-
 drivers/iio/dac/ad5686.c                           |  10 +-
 drivers/iio/dac/ad5755.c                           |  17 +-
 drivers/iio/dac/ad5764.c                           |  10 +-
 drivers/iio/dac/ad5791.c                           |   6 +-
 drivers/iio/dac/max517.c                           |   8 +-
 drivers/iio/dac/mcp4725.c                          |   8 +-
 drivers/iio/gyro/adis16080.c                       |   7 +-
 drivers/iio/gyro/adis16130.c                       |   6 +-
 drivers/iio/gyro/adxrs450.c                        |  12 +-
 drivers/rtc/rtc-hid-sensor-time.c                  |  15 +-
 drivers/staging/iio/TODO                           |  11 +
 drivers/staging/iio/accel/adis16220_core.c         |   6 +-
 drivers/staging/iio/adc/ad7280a.c                  |  10 +-
 drivers/staging/iio/adc/ad7606_core.c              |   9 +-
 drivers/staging/iio/adc/ad7780.c                   |   9 +-
 drivers/staging/iio/adc/ad799x_core.c              |   8 +-
 drivers/staging/iio/adc/mxs-lradc.c                | 969 ++++++++++++++-------
 drivers/staging/iio/adc/spear_adc.c                |   7 +-
 drivers/staging/iio/cdc/ad7746.c                   |  13 +-
 drivers/staging/iio/frequency/ad9852.c             |  45 +-
 drivers/staging/iio/frequency/ad9910.c             |  82 +-
 drivers/staging/iio/frequency/ad9951.c             |  26 +-
 drivers/staging/iio/magnetometer/hmc5843.c         | 259 +++---
 include/linux/hid-sensor-hub.h                     |  18 +
 44 files changed, 1058 insertions(+), 778 deletions(-)
