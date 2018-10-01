Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeJBCHq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Oct 2018 22:07:46 -0400
Date: Mon, 1 Oct 2018 20:28:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] Second set of IIO new device support, cleanups etc for 4.20
Message-ID: <20181001202825.315a1a8d@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 6029b7ac292abd36f8dff7f75e83dfd01332b265:

  MAINTAINERS: remove myself as staging FBTFT maintainer (2018-09-14 15:41:34 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.20b

for you to fetch changes up to 8911a43bc198877fad9f4b0246a866b26bb547ab:

  iio: ad5064: Fix regulator handling (2018-09-29 13:28:47 +0100)

----------------------------------------------------------------
Second set of IIO new device support features and cleanup for the 4.20 cycle.

One merge commit in here to bring in the SPI_CS_WORD flag patches
that are also going via the SPI tree.

There are a few more fixes than normal for a pull targetting the
next merge window.  These are all long term issues and as we are late
in the cycle, they can wait.

New device support
* ad7606
  - Add support fo the ad7605-4 driver.  This driver is still in staging
    but is heading in the right direction to graduate, motivated partly
    by the requirement for this device support.
* ST VL53L0X ToF ranging sensor
  - New minimal driver. Interrupt support to follow.

New features

* SPI_CS_WORD optimization allows long transfers with the chip select
  toggled every 16bits.   There is a software fallback as well to let
  drivers not care about whether the hardware supports it.

* bh1750
  - Device tree support and bindings.
* ti-ads7950
  - Use the SPI_CS_WORD optmization to save lots of cpu cycles (assuming
    the hardware supports it)

Fixes and cleanups

* ad5064
  - Fix some long incorrect regulator error handling that preventing
    enabling the internal regulator.
* ad7606
  - The ad7606 doesn't actually have a 2.5V range and the values provided
    for scale have always been wrong.  Fix them.
  - Drop some wrong kernel-doc (things that don't exist)
  - Add missing kernel-doc
* at91-adc
  - Fixing missing ack of dataready on sysfs channel reads to avoid spurious
    interrupts.
  - Fix a wrong channel numbers in triggered_buffer_mode
* hmc5843
  - Fix incorrect part number in a comment.
* imx25-gcq
  - Fix a device_node leak in an error path.
* meson-saradc
  - Drop an unused and pointless define.
  - Use of_device_get_match_data instead of opencoding
  - Tidy up how meson_sar_adc_param is accessed.
  - Rework prior to adding some temperature sensor support.

----------------------------------------------------------------
Alexandru Ardelean (4):
      staging:iio:ad7606: fix voltage scales
      staging:iio:ad7606: Remove incorrect kernel doc annotations
      staging:iio:ad7606: update structs with doc annotations
      staging:iio:ad7606: Add support for the ad7605-4

Alexey Khoroshilov (1):
      iio: adc: imx25-gcq: Fix leak of device_node in mx25_gcq_setup_cfgs()

David Lechner (3):
      spi: add new SPI_CS_WORD flag
      spi: add software implementation for SPI_CS_WORD
      iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU usage

Eugen Hristev (2):
      iio: adc: at91: fix acking DRDY irq on simple conversions
      iio: adc: at91: fix wrong channel number in triggered buffer mode

Jonathan Cameron (1):
      Merge tag 'spi-cs-word' into togreg

Lars-Peter Clausen (1):
      iio: ad5064: Fix regulator handling

Martin Blumenstingl (5):
      iio: adc: meson-saradc: remove #define MESON_SAR_ADC_DELTA_10_TS_C_SHIFT
      iio: adc: meson-saradc: use of_device_get_match_data
      iio: adc: meson-saradc: simplify access to meson_sar_adc_param
      iio: adc: meson-saradc: do not use meson_sar_adc_iio_channels directly
      iio: adc: meson-saradc: use the address attribute from iio_chan_spec

Song Qiang (2):
      iio: magnetometer: hmc5843: Fixed a comment error.
      iio: proximity: Add driver support for ST's VL53L0X ToF ranging sensor.

ryang (2):
      dt-bindings: iio: light: bh1750: Add device tree binding documentation
      iio: light: bh1750: Add device tree support

 .../devicetree/bindings/iio/light/bh1750.txt       |  18 +++
 .../devicetree/bindings/iio/proximity/vl53l0x.txt  |  12 ++
 MAINTAINERS                                        |   7 +
 drivers/iio/adc/at91_adc.c                         |   6 +-
 drivers/iio/adc/fsl-imx25-gcq.c                    |   6 +
 drivers/iio/adc/meson_saradc.c                     |  70 ++++-----
 drivers/iio/adc/ti-ads7950.c                       |  53 ++++---
 drivers/iio/dac/ad5064.c                           |  53 +++++--
 drivers/iio/light/bh1750.c                         |  11 ++
 drivers/iio/magnetometer/hmc5843.h                 |   2 +-
 drivers/iio/proximity/Kconfig                      |  11 ++
 drivers/iio/proximity/Makefile                     |   2 +
 drivers/iio/proximity/vl53l0x-i2c.c                | 164 +++++++++++++++++++++
 drivers/spi/spi.c                                  |  31 +++-
 drivers/staging/iio/adc/Kconfig                    |   2 +-
 drivers/staging/iio/adc/ad7606.c                   |  40 ++++-
 drivers/staging/iio/adc/ad7606.h                   |  31 +++-
 drivers/staging/iio/adc/ad7606_par.c               |   3 +
 drivers/staging/iio/adc/ad7606_spi.c               |   1 +
 include/linux/spi/spi.h                            |   2 +-
 20 files changed, 438 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.txt
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
 create mode 100644 drivers/iio/proximity/vl53l0x-i2c.c
