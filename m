Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbeEVS5F (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 May 2018 14:57:05 -0400
Date: Tue, 22 May 2018 19:57:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PULL] Second new devices, features and cleanup set for IIO in the
 4.18 cycle
Message-ID: <20180522195700.5e1ee493@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 21f4bb8756b22853ae3555f73ab8a44d328ee423:

  staging: wlan-ng: fix block comment alignment in p80211metastruct.h (2018-05-11 12:03:44 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.18b

for you to fetch changes up to 96c92d42e9c93b2647d55b84ad883b11baa76307:

  iio: imu: inv_mpu6050: add comment about frequencies (2018-05-22 18:29:09 +0100)

----------------------------------------------------------------
Second set of new device support, features and cleanup for IIO in the 4.18 cycle

Usual mixture of new devices support and other stuff.  A couple of
staging graduations in here and some old driver drops.

New device support
* ad5686
  - Add support for AD5691R, AD5692R, AD5693 and AD5693R i2c DACs
  - Add support for AD5681R, AD5682R, AD5683 and AD5683R SPI DACs
* lmp91000
  - Add ID for LMP91002
* stm32-dfsdm
  - Add support for the stm32mp1 devices.

Drivers dropped
* ADE7753
  - No longer easily available, no users came forward and needs a lot
    of work to move out of staging.
* ADE7754
* ADE7758
* ADE7759

Staging graduations
- ad2s1200 - good cleanup from David Veenstra.
- tsl2772 (was tsl2x7x) - Brian's quest is at an end and
  staging/iio/light is no more!

Features
* tools
  - loop forever on a negative number of loops being specified.
* ltc 2632
  - add of_match_table
  - support an external reference regulator.
* mag3110
  - Support continuous mode when running fast as it increases the
    posssible sampling rate.
* ti-ads8688
  - Add trigger and buffer support to this ADC.

Cleanups / minor tweaks.
* tools
  - tidy up types in iio_generic_buffer.
* ad2s1200
  - Whitespace cleanup.
  - Drop pointless initializations.
  - Improve kernel docs.
  - Reorder to setup the SPI prior to device registration (race fix).
  - Change to modern gpiod framework.
  - Drop platform data and move to DT bindings. There are no in
    kernel users of the platform data. Any out of tree boards will
    need changes.
  - Add an explicit compatible table.
  - Provide _scale for angular velocity and angle channels.
  - Add David Veenstra to copyright notice as this cleanup was non
    trivial.
* ade8366
  - Avoid a race by ensuring channel init is before registration
    with the subsystem.
* afe
  - binding spelling fix.
* imx7d-adc
  - typo fix in Freescale
* inv_mpu6050
  - tidy up an ugly loop to take advantage of known entry condition.
  - add a comment explaining why the sensible sampling frequencies
    are more limited than might be immediately apparent (aliasing).
* mma8452
  - reduce the sleep time on data not ready when running at high
    frequency.
* stm32-dfsdm
  - add missing header.
* tsl2583
  - fix integration_time_availabe which was in microsecs rather the
    millisecs.
* tsl2x7x/tsl2772
  - Whitespace cleanup.
  - Change to direct returns where sensible.
  - Turn the chip off in the registration error path.
  - Use macro to reduce repition when setting up the device_info
    structures.
  - Change the _available attributes over to read_avail callback,
    and the range definitions that supports.
  - Fix some wrong period values.
  - Add some range checkign for _write_raw.
  - Rename the driver to tsl2772 to avoid wild card clash problems
    in future.

----------------------------------------------------------------
Alexandru Ardelean (1):
      iio: amplifiers: ad8366: move channel init before iio_device_register()

Brian Masney (10):
      staging: iio: tsl2x7x: remove unnecessary whitespace
      staging: iio: tsl2x7x: use direct returns
      staging: iio: tsl2x7x: turn chip off if IIO device registration fails
      staging: iio: tsl2x7x: use macro to populate tsl2X7X_device_info
      staging: iio: tsl2x7x: convert to use read_avail
      staging: iio: tsl2x7x: correct IIO_EV_INFO_PERIOD values
      staging: iio: tsl2x7x: add range checking to tsl2x7x_write_raw
      staging: iio: tsl2x7x: rename driver to tsl2772
      staging: iio: tsl2x7x/tsl2772: move out of staging
      iio: tsl2583: correct values in integration_time_available

Colin Ian King (1):
      iio: adc: fix spelling mistake: "Freeacale" -> "Freescale"

David Veenstra (11):
      staging: iio: ad2s1200: Remove unneeded newline in license
      staging: iio: ad2s1200: Remove unneeded initializations
      staging: iio: ad2s1200: Add kernel docs to driver state
      staging: iio: ad2s1200: Setup spi before iio device register
      staging: iio: ad2s1200: Replace legacy gpio API with modern API
      staging: iio: ad2s1200: Replace platform data with dt bindings
      staging: iio: ad2s1200: Add dt table
      staging: iio: ad2s1200: Add scaling factor for angular velocity channel
      staging: iio: ad2s1200: Add scaling factor for angle channel
      staging: iio: ad2s1200: Add copyright
      staging: iio: ad2s1200: Move driver out of staging

Fabrice Gasnier (2):
      iio: adc: stm32-dfsdm: Add support for stm32mp1
      iio: adc: stm32-dfsdm: include stm32-dfsdm-adc.h

Geert Uytterhoeven (1):
      dt-bindings: iio: afe: Spelling s/mesaurement/measurement/

Jonathan Cameron (4):
      staging:iio:meter: Drop ADE7753 driver
      staging:iio:meter: Drop ADE7754 driver
      staging:iio:meter: Drop ADE7758 driver
      staging:iio:meter: Drop ADE7759 driver

Martin Kelly (4):
      iio: imu: inv_mpu6050: make loop a do-while
      tools: iio: iio_generic_buffer: fix types to match
      tools: iio: iio_generic_buffer: allow continuous looping
      iio: imu: inv_mpu6050: add comment about frequencies

Matt Ranostay (1):
      iio: potentiostat: lmp91000: add LMP91002 support

Richard Tresidder (2):
      iio: magnetometer: mag3110: Add ability to run in continuous mode
      iio: accell: mma8452: Reduce sleep time when data not ready

Sean Nyekjaer (1):
      iio: adc: ti-ads8688: add trigger and buffer support

Silvan Murer (2):
      iio: dac: fix missing of_match_table assignment in the LTC 2632 device
      iio: dac: Add support for external reference voltage through the regulator framework.

Stefan Popa (2):
      iio:dac:ad5686: Add AD5691R/AD5692R/AD5693/AD5693R support
      iio:dac:ad5686: Add AD5681R/AD5682R/AD5683/AD5683R support

 .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        |   7 +-
 .../bindings/iio/afe/current-sense-amplifier.txt   |   2 +-
 .../bindings/iio/afe/current-sense-shunt.txt       |   2 +-
 .../devicetree/bindings/iio/dac/ltc2632.txt        |  14 +
 .../bindings/iio/potentiostat/lmp91000.txt         |   9 +-
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/accel/mma8452.c                        |  24 +-
 drivers/iio/adc/imx7d_adc.c                        |   2 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |   4 +-
 drivers/iio/adc/stm32-dfsdm-core.c                 |  21 +
 drivers/iio/adc/ti-ads8688.c                       |  48 +-
 drivers/iio/amplifiers/ad8366.c                    |   6 +-
 drivers/iio/dac/ad5686-spi.c                       |  42 +-
 drivers/iio/dac/ad5686.c                           | 125 ++-
 drivers/iio/dac/ad5686.h                           |  24 +
 drivers/iio/dac/ad5696-i2c.c                       |   7 +-
 drivers/iio/dac/ltc2632.c                          |  89 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   9 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |   4 +-
 drivers/iio/light/Kconfig                          |   8 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/tsl2583.c                        |   2 +-
 .../iio/light/tsl2x7x.c => iio/light/tsl2772.c}    | 886 ++++++++++---------
 drivers/iio/magnetometer/mag3110.c                 | 158 +++-
 drivers/iio/potentiostat/lmp91000.c                |   2 +
 drivers/iio/resolver/Kconfig                       |  17 +
 drivers/iio/resolver/Makefile                      |   5 +
 drivers/{staging => }/iio/resolver/ad2s1200.c      | 146 ++--
 drivers/staging/iio/Kconfig                        |   1 -
 drivers/staging/iio/Makefile                       |   1 -
 drivers/staging/iio/light/Kconfig                  |  14 -
 drivers/staging/iio/light/Makefile                 |   5 -
 drivers/staging/iio/meter/Kconfig                  |  42 -
 drivers/staging/iio/meter/Makefile                 |   8 -
 drivers/staging/iio/meter/ade7753.c                | 630 --------------
 drivers/staging/iio/meter/ade7754.c                | 664 --------------
 drivers/staging/iio/meter/ade7758.h                | 183 ----
 drivers/staging/iio/meter/ade7758_core.c           | 955 ---------------------
 drivers/staging/iio/meter/ade7758_ring.c           | 177 ----
 drivers/staging/iio/meter/ade7758_trigger.c        | 108 ---
 drivers/staging/iio/meter/ade7759.c                | 558 ------------
 drivers/staging/iio/resolver/Kconfig               |  12 -
 drivers/staging/iio/resolver/Makefile              |   1 -
 include/linux/iio/adc/stm32-dfsdm-adc.h            |   2 +
 .../linux/platform_data/tsl2772.h                  |  51 +-
 tools/iio/iio_generic_buffer.c                     |  13 +-
 47 files changed, 1152 insertions(+), 3939 deletions(-)
 rename drivers/{staging/iio/light/tsl2x7x.c => iio/light/tsl2772.c} (59%)
 create mode 100644 drivers/iio/resolver/Kconfig
 create mode 100644 drivers/iio/resolver/Makefile
 rename drivers/{staging => }/iio/resolver/ad2s1200.c (52%)
 delete mode 100644 drivers/staging/iio/light/Kconfig
 delete mode 100644 drivers/staging/iio/light/Makefile
 delete mode 100644 drivers/staging/iio/meter/ade7753.c
 delete mode 100644 drivers/staging/iio/meter/ade7754.c
 delete mode 100644 drivers/staging/iio/meter/ade7758.h
 delete mode 100644 drivers/staging/iio/meter/ade7758_core.c
 delete mode 100644 drivers/staging/iio/meter/ade7758_ring.c
 delete mode 100644 drivers/staging/iio/meter/ade7758_trigger.c
 delete mode 100644 drivers/staging/iio/meter/ade7759.c
 rename drivers/staging/iio/light/tsl2x7x.h => include/linux/platform_data/tsl2772.h (70%)
