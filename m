Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750781AbeBTIfx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Feb 2018 03:35:53 -0500
Date: Tue, 20 Feb 2018 08:35:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PULL] First set of new device support and cleanups for IIO in the
 4.17 cycle.
Message-ID: <20180220083549.2c38d4ab@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit a66a4e8e01f3b607a9aa5b5ed9ca588b4c3a962e:

  staging: pi433: Cleanup codestyle, indent statements after case labels (2018-01-10 19:29:34 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.17a

for you to fetch changes up to d6ad805844c52d256c2a3ff3d60daa10d27a8b64:

  iio: add SPDX identifier for various drivers (2018-02-18 11:55:19 +0000)

----------------------------------------------------------------
First round of new devices, features and cleanups for IIO in the 4.17 cycle.

Outside of IIO
* Strongly typed 64bit int_sqrt function needed by the mlx90632

New device support
* adc081s
  - New driver supporting adc081s, adc101s and adc121s TI ADCs.
* ad5272
  - New driver supproting the ad5272 and ad5274 ADI digital potentiometers
    with DT bindings.
* axp20x_adc
  - support the AXP813 ADC - includes rework patches to prepare for this.
* mlx90632
  - New driver with dt bindings for this IR temperature sensor.

Features
* axp20x_adc
  - Add DT bindings and probing.
* dht11
  - The sensor has a wider range than advertised in the datasheet - support it.
* st_lsm6dsx
  - Add hardware timestamp su9pport.

Cleanups
* ABI docs
  - Update email contact for Matt Ranostay
* SPDX changes
  - Matt Ranostay has moved his drivers over to SPDX.  Currently we are making
    this an author choice in IIO.
* ad7192
  - Disable burnout current on misconfiguration.  No actually effect as
    they simply won't work otherwise.
* ad7476
  - Drop a license definition that was replicating information in SPDX tag.
* ade7758
  - Expand buf_lock to cover both buffer and state protection allowing
    unintented uses of mlock in the core to be removed.
* ade7759
  - Align parameters to opening parenthesis.
* at91_adc
  - Depend on sysfs instead of selecting it - for try wide consistency.
* ccs811
  - trivial naming type for a define.
* ep93xx
  - Drop a redundant return as a result checking platform_get_resource.
* hts221
  - Regmap conversion which simplifies the driver somewhat.
  - Clean up some restricted endian cast warnings.
  - Drop a trailing whitespace from a comment
  - Drop an unnecessary get_unaligned by changing to the right 16bit data type.
* ms5611
  - Fix coding style in the probe function (whitespace)
* st_accel
  - Use strlcpy instead of strncpy to avoid potentially truncating a string.

----------------------------------------------------------------
Alexandru Ardelean (1):
      staging: iio: adc: ad7192: disable burnout currents on misconfig

Crt Mori (3):
      lib: Add strongly typed 64bit int_sqrt
      dt-bindings: iio: temperature: add MLX90632 device bindings
      iio: temperature: Adding support for MLX90632

Harald Geyer (1):
      iio: dht11: Improve detection of sensor type

Lorenzo Bianconi (5):
      iio: humidity: hts221: remove warnings in hts221_parse_{temp,rh}_caldata()
      iio: humidity: hts221: remove trailing whitespace from a comment
      iio: humidity: hts221: add regmap API support
      iio: humidity: hts221: remove unnecessary get_unaligned_le16()
      iio: imu: st_lsm6dsx: add hw timestamp support

Matt Ranostay (2):
      iio: sysfs-bus-iio-*: update email contact
      iio: add SPDX identifier for various drivers

Milan Stevanovic (2):
      iio: adc: driver for ti adc081s/adc101s/adc121s
      iio: adc: change license description

Phil Reid (2):
      dt-bindings: ad5272: Add bindings for Analog Devices digital potentiometers
      iio: ad5272: Add support for Analog Devices digital potentiometers

Quentin Schulz (4):
      iio: adc: axp20x_adc: put ADC rate setting in a per-variant function
      dt-bindings: iio: adc: add binding for X-Powers AXP PMICs ADC
      iio: adc: axp20x_adc: make it possible to probe from DT
      iio: adc: axp20x_adc: add support for AXP813 ADC

Randy Dunlap (1):
      iio/adc: depend on SYSFS instead of selecting it

Richard Lai (1):
      iio: chemical: ccs811: Typo correction in HW_ID_VALUE constant define naming

Shreeya Patel (1):
      Staging: iio: ade7758: Expand buf_lock to cover both buffer and state protection

Wei Yongjun (1):
      iio: ep93xx: remove redundant return value check of platform_get_resource()

Xiongfeng Wang (1):
      iio: accel: use strlcpy() instead of strncpy()

rodrigosiqueira (2):
      staging: ade7759: Fix open parenthesis alignment
      iio:pressure:ms5611: Fix coding style in probe function

 .../ABI/testing/sysfs-bus-iio-chemical-vz89x       |   2 +-
 .../ABI/testing/sysfs-bus-iio-proximity-as3935     |   4 +-
 .../devicetree/bindings/iio/adc/axp20x_adc.txt     |  48 ++
 .../bindings/iio/potentiometer/ad5272.txt          |  27 +
 .../bindings/iio/temperature/mlx90632.txt          |  28 +
 MAINTAINERS                                        |   7 +
 drivers/iio/accel/st_accel_i2c.c                   |   3 +-
 drivers/iio/adc/Kconfig                            |   3 +-
 drivers/iio/adc/ad7476.c                           |  26 +-
 drivers/iio/adc/axp20x_adc.c                       | 160 ++++-
 drivers/iio/adc/ep93xx_adc.c                       |   4 -
 drivers/iio/adc/ti-adc161s626.c                    |  16 +-
 drivers/iio/chemical/ams-iaq-core.c                |  17 +-
 drivers/iio/chemical/atlas-ph-sensor.c             |  16 +-
 drivers/iio/chemical/ccs811.c                      |   4 +-
 drivers/iio/chemical/vz89x.c                       |  17 +-
 drivers/iio/health/max30100.c                      |  16 +-
 drivers/iio/humidity/Kconfig                       |   2 +
 drivers/iio/humidity/dht11.c                       |   2 +-
 drivers/iio/humidity/hdc100x.c                     |  16 +-
 drivers/iio/humidity/hts221.h                      |  21 +-
 drivers/iio/humidity/hts221_buffer.c               |  39 +-
 drivers/iio/humidity/hts221_core.c                 | 132 ++--
 drivers/iio/humidity/hts221_i2c.c                  |  64 +-
 drivers/iio/humidity/hts221_spi.c                  |  81 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |  29 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     | 161 +++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 104 ++-
 drivers/iio/light/apds9960.c                       |  16 +-
 drivers/iio/potentiometer/Kconfig                  |  10 +
 drivers/iio/potentiometer/Makefile                 |   1 +
 drivers/iio/potentiometer/ad5272.c                 | 231 +++++++
 drivers/iio/potentiometer/tpl0102.c                |  16 +-
 drivers/iio/potentiostat/lmp91000.c                |  16 +-
 drivers/iio/pressure/ms5611.h                      |   2 +-
 drivers/iio/proximity/as3935.c                     |  17 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |  16 +-
 drivers/iio/temperature/Kconfig                    |  12 +
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/maxim_thermocouple.c       |  16 +-
 drivers/iio/temperature/mlx90632.c                 | 750 +++++++++++++++++++++
 drivers/staging/iio/adc/ad7192.c                   |   6 +-
 drivers/staging/iio/meter/ade7758.h                |   2 +-
 drivers/staging/iio/meter/ade7758_core.c           |  52 +-
 drivers/staging/iio/meter/ade7759.c                |  80 ++-
 include/linux/kernel.h                             |   9 +
 include/linux/mfd/axp20x.h                         |   2 +
 lib/int_sqrt.c                                     |  30 +
 48 files changed, 1807 insertions(+), 527 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
 create mode 100644 drivers/iio/potentiometer/ad5272.c
 create mode 100644 drivers/iio/temperature/mlx90632.c
