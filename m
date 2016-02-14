Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37041 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbcBNPIR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Feb 2016 10:08:17 -0500
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PULL] Second round of IIO new device support, functionality and
 cleanups for the 4.6 cycle.
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56C0985F.8080601@kernel.org>
Date: Sun, 14 Feb 2016 15:08:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit e5349952de5b1138e6275529e4ec08c0ed33777f:

  staging: wilc1000: linux_mon: remove debug message of kmalloc failure (2016-02-03 15:34:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.6b

for you to fetch changes up to ecc24e72f43735cceab06f4e69aa6ce075a3ae46:

  iio: adc: Add TI ADS1015 ADC driver support (2016-02-13 20:54:15 +0000)

----------------------------------------------------------------
2nd round of new IIO device support, features and cleanups for the 4.6 cycle.

New Device Support
* Apex stx104 DAC
  - new driver for this PC104 board. Right now DAC support only.
* ADI ad5064
  - Add support for ad5625, ad5627, ad5645, ad5665, ad5667 DACs.
  - Add support for Linear Technology ltc2606, ltc2607, ltc2609, ltc2616,
    ltc2617, ltc2619, ltc2626, ltc2627 and ltc2629.
* ADI ad7192
  - add support for the ad7193
* Invensense mpu6050
  - substantial rework of driver to use regmap allowing SPI support extending
    the now split driver to cover the MPU6000.
* TI adc0832
  - new driver supporting ADC0831, ADC0832, ADC0834 and ADC0838 ADCs.
* TI ads1015
  - new driver, note that there is an existing hwmon driver. The long term
    intention is to probably remove the hwmon driver but for now we just have
    guards in place to ensure this driver is not built if that one is enabled.
* TI afe4403
  - new driver for this heart rate monitor / pulse oximeter front end chip.
* TI afe4404
  - new driver for this heart rate monitor / pulse oximeter front end chip.

Staging Graduations
* mxs-lradc
  - A combined general purpose and touch screen (input) device driver.
    Originally held in staging to allow reworking into and MFD but as
    that wasn't happening and isn't an absolute requirement we are moving
    it out of staging.

Driver new features
* ms5611
  - triggered buffer support
  - IIO_CHAN_INFO_SCALE to aid the triggered buffer support.

Driver cleanups / reworks / fixes
* ad5064
  - Use an enum for the register map layout to allow support of additional
    chips (precursor to the new support listed above).
  - Structural driver changes to allow support of the slightly different
    handling for the ltc parts above.
* ad5933
  - drop an exceptional & unnecessary for a function pointer.
* ad7606
  - Cleanup the repeated copies of pm ops.
  - consolidate the various channels specs via a sport of rearranging so only
    one version is needed.
* atlas ph sensor
  - add select IRQ_WORK
* hmc8543 (soon to move out of staging)
  - Comment style fixes
  - functionality of suspend and resume was swapped.
* spear-adc
  - use devm_clk_dev instead of managing the clk lifetime by hand.

Core
* Use new dmaengine_terminate_sync call to avoid a theoretical race.
* Fix docs for mlock in struct iio_dev as it is correctly taken in some
  drivers (docs used to say for core only).
* Add a helper function for calculating the scan index storage size within
  the core cutting out some cut and paste versions of the same code.

----------------------------------------------------------------
Adriana Reus (4):
      iio: imu: inv-mpu6050: Fix interrupt pin configuration
      iio: imu: inv_mpu6050: Use regmap instead of i2c specific functions
      iio: imu: inv_mpu6050: Separate driver into core and i2c functionality.
      iio: imu: inv_mpu6050: Add SPI support for MPU6000

Akinobu Mita (1):
      iio: adc: add support for ADC0831/ADC0832/ADC0834/ADC0838 chips

Andrew F. Davis (4):
      Documentation: afe4404: Add DT bindings for the AFE4404 heart monitor
      iio: health: Add driver for the TI AFE4404 heart monitor
      Documentation: afe4403: Add DT bindings for the AFE4403 heart monitor
      iio: health: Add driver for the TI AFE4403 heart monitor

Arnd Bergmann (1):
      iio: chemical: select IRQ_WORK for ATLAS ph sensor

Bhumika Goyal (1):
      Staging:iio:Remove exceptional & on function name

Cristina Moraru (2):
      iio: hmc5843: Swap suspend and resume implementations
      iio: hmc5843: Fix comment style warnings

Daniel Baluta (4):
      iio: pressure: ms5611: Add IIO_CHAN_INFO_SCALE to mask
      iio: pressure: ms5611: Add triggered buffer support
      iio: Fix documentation for iio_dev mlock
      iio: adc: Add TI ADS1015 ADC driver support

Gujulan Elango, Hari Prasath (H.) (1):
      staging: iio: replace clk_get() with devm_clk_get()

Ksenija Stanojevic (1):
      iio: adc: Move mxs-lradc out of staging

Lars-Peter Clausen (8):
      staging:iio:ad7606: Consolidate channel specs
      iio: Add helper function for calculating scan index storage size
      staging:iio:ad7606: Consolidate PM ops
      iio:ad5064: List support LTC devices in Kconfig
      iio:ad5064: Use a enum for the register map layout type
      iio:ad5064: Add AD5625/AD5627/AD5645/AD5647/AD4665/AD5657 support
      iio: buffer-dmaengine: Use dmaengine_terminate_sync()
      staging:iio:ad7192: Add support for the AD7193

Marc Andre (2):
      iio:ad5064: Structural changes to support LTC2617
      iio:ad5064: Add support for ltc2617 and similar devices

William Breathitt Gray (1):
      iio: Add IIO support for the DAC on the Apex Embedded Systems STX104

 Documentation/ABI/testing/sysfs-bus-iio            |   1 +
 .../ABI/testing/sysfs-bus-iio-health-afe440x       |  54 ++
 .../devicetree/bindings/iio/adc/ti-adc0832.txt     |  19 +
 .../devicetree/bindings/iio/health/afe4403.txt     |  34 +
 .../devicetree/bindings/iio/health/afe4404.txt     |  30 +
 MAINTAINERS                                        |   6 +
 drivers/iio/adc/Kconfig                            |  37 ++
 drivers/iio/adc/Makefile                           |   3 +
 drivers/{staging => }/iio/adc/mxs-lradc.c          |  13 +-
 drivers/iio/adc/ti-adc0832.c                       | 288 +++++++++
 drivers/iio/adc/ti-ads1015.c                       | 612 ++++++++++++++++++
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   7 +-
 drivers/iio/chemical/Kconfig                       |   1 +
 drivers/iio/dac/Kconfig                            |  15 +-
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5064.c                           | 391 +++++++++++-
 drivers/iio/dac/stx104.c                           | 152 +++++
 drivers/iio/health/Kconfig                         |  31 +-
 drivers/iio/health/Makefile                        |   2 +
 drivers/iio/health/afe4403.c                       | 708 +++++++++++++++++++++
 drivers/iio/health/afe4404.c                       | 679 ++++++++++++++++++++
 drivers/iio/health/afe440x.h                       | 191 ++++++
 drivers/iio/imu/inv_mpu6050/Kconfig                |  22 +-
 drivers/iio/imu/inv_mpu6050/Makefile               |   8 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         |  18 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 258 ++------
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          | 206 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  19 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |  35 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |  97 +++
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |  10 +-
 drivers/iio/industrialio-buffer.c                  |  59 +-
 drivers/iio/pressure/Kconfig                       |   1 +
 drivers/iio/pressure/ms5611.h                      |   1 +
 drivers/iio/pressure/ms5611_core.c                 |  92 ++-
 drivers/iio/pressure/ms5611_i2c.c                  |   7 +
 drivers/iio/pressure/ms5611_spi.c                  |   8 +
 drivers/staging/iio/adc/Kconfig                    |  18 +-
 drivers/staging/iio/adc/Makefile                   |   1 -
 drivers/staging/iio/adc/ad7192.c                   |  76 ++-
 drivers/staging/iio/adc/ad7606.h                   |  10 +-
 drivers/staging/iio/adc/ad7606_core.c              |  53 +-
 drivers/staging/iio/adc/ad7606_par.c               |  32 +-
 drivers/staging/iio/adc/ad7606_spi.c               |  32 +-
 drivers/staging/iio/adc/spear_adc.c                |  17 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   8 +-
 drivers/staging/iio/magnetometer/hmc5843.h         |   5 +-
 drivers/staging/iio/magnetometer/hmc5843_core.c    |   4 +-
 drivers/staging/iio/magnetometer/hmc5843_i2c.c     |   3 +-
 drivers/staging/iio/magnetometer/hmc5843_spi.c     |   3 +-
 include/linux/iio/iio.h                            |   2 +-
 51 files changed, 3902 insertions(+), 478 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-health-afe440x
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc0832.txt
 create mode 100644 Documentation/devicetree/bindings/iio/health/afe4403.txt
 create mode 100644 Documentation/devicetree/bindings/iio/health/afe4404.txt
 rename drivers/{staging => }/iio/adc/mxs-lradc.c (99%)
 create mode 100644 drivers/iio/adc/ti-adc0832.c
 create mode 100644 drivers/iio/adc/ti-ads1015.c
 create mode 100644 drivers/iio/dac/stx104.c
 create mode 100644 drivers/iio/health/afe4403.c
 create mode 100644 drivers/iio/health/afe4404.c
 create mode 100644 drivers/iio/health/afe440x.h
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
