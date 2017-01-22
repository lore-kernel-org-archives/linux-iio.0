Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42277 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdAVWDV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 17:03:21 -0500
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PULL] Second round of IIO new device support, features and cleanup
 for the 4.11 cycle.
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2f1e42fd-fa53-9fcc-fd2e-b9be60afa77b@kernel.org>
Date: Sun, 22 Jan 2017 22:03:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit e30eca0e69cb888125b081c96ca761e958fcb5b4:

  iio:adc:qcom-spmi-vadc: use div64_s64 instead of direct 64 bit division. (2017-01-10 21:13:39 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.11b

for you to fetch changes up to 10e840dfb0b7fc345082dd9e5fff3c1c02e7690e:

  iio: trigger: free trigger resource correctly (2017-01-22 16:14:21 +0000)

----------------------------------------------------------------
Second round of IIO new device support, cleanups and features for the 4.11 cycle

New device support:
* lsm6dsx imu
  - new driver and bindings.
* max11100 adc
  - new driver and bindings.
* tlc4541
  - new driver
* tmp007 thermopile
  - new driver.

Core
* in kernel interfaces
  - pass through raw values if no scaling provided and a processed value is
    requested.
* trigger
  - close a race condition in acquiring trigger reference.
  - constify device_type structures.
  - rework the viio_trigger_alloc function to be much neater and easier to
  read.
  - free trigger resources correctly on some error paths. Avoids putting a
  module we don't have.

Documentation
* ABI
  - specify a unit for proximity measurements.

Cleanups and features
* ads1015
  - constify iio_info structure.
* ads7950 cleanups following merge in previous pull
  - Add device tree bindings
  - Drop the ti prefix from the module name in common with other drivers.
  - Change regulator name to vref to match datasheet and other drivers.
* ak8974
  - remove a redundant zero timeout check.
* bmi160
  - use variable names for sizeof instead of types.
* cm3605
  - mark PM functions as __maybe_unused to avoid a build warning.
* isl29028 (on it's way towards moving out of staging).
  - alignment fixes and newline improvements.
  - combine proxim_get and read_proxim for simpler code.
  - drop unused ISL29028_DEV_ATTR macro
  - move some error logging into functions to cut out repitition.
  - make error messages more consistent.
  - tidy up some brackets.
  - drop the enable flag that nothing uses.
  - only set proximity rate and ALS scale when relevant channel type is enabled.
  - runtime pm support.
* lsm6dsx
  - fix wrong values for gyro sensitivitiy.
* mag3110
  - claim direct mode during sysfs reads to avoid a race condition.
* max1363
  - export OF device table IDs as module aliases.
* max30100
  - use msleep for long uncritical delays.
* mcp4531
  - export OF device table as module aliases.
* ms5611
  - claim direct mode during sysfs reads to avoid a race condition.
* opt3001
  - export OF device table as module aliases.
* sx9500
  - claim direct mode during oversampling changes to avoid a race condition.

----------------------------------------------------------------
Alison Schofield (6):
      iio: magnetometer: mag3110: claim direct mode during raw writes
      iio: proximity: sx9500: claim direct mode during raw proximity reads
      iio: pressure: ms5611: claim direct mode during oversampling changes
      iio: bmi160: use variable names for sizeof() operator
      iio: trigger: close race condition in acquiring trigger reference
      iio: trigger: free trigger resource correctly

Arnd Bergmann (1):
      iio: light: cm3605: mark PM functions as __maybe_unused

Bhumika Goyal (2):
      iio: industrialio-trigger: constify device_type structures
      iio: adc: constify iio_info structures

Brian Masney (15):
      staging: iio: isl29028: fix alignment of function arguments
      staging: iio: isl29028: combine isl29028_proxim_get() and isl29028_read_proxim()
      staging: iio: isl29028: made alignment of variables in struct isl29028_chip consistent
      staging: iio: isl29028: change newlines to improve readability
      staging: iio: isl29028: remove unused define ISL29028_DEV_ATTR
      staging: iio: isl29028: move failure logging into isl29028_set_proxim_sampling()
      staging: iio: isl29028: move failure logging into isl29028_set_als_scale()
      staging: iio: isl29028: made error messages consistent
      staging: iio: isl29028: remove unnecessary error logging in isl29028_chip_init_and_power_on()
      staging: iio: isl29028: remove out of memory log message
      staging: iio: isl29028: remove unnecessary parenthesis
      staging: iio: isl29028: remove enable flag from isl29028_enable_proximity()
      staging: iio: isl29028: only set proximity sampling rate when proximity is enabled
      staging: iio: isl29028: only set ALS scale when ALS/IR sensing is enabled
      staging: iio: isl29028: add runtime power management support

Colin Ian King (1):
      iio: magnetometer: ak8974: remove redundant zero timeout check

Dan Carpenter (1):
      iio: trigger: clean up viio_trigger_alloc()

David Lechner (3):
      DT/bindings: Add bindings for TI ADS7950 A/DC chips
      iio: adc: ti-ads7950: Drop "ti-" prefix from module name
      iio: adc: ti-ads7950: Change regulator matching string to "vref"

Enric Balletbo i Serra (1):
      iio: Documentation: Add proximity unit

Jacopo Mondi (2):
      iio: adc: Add Maxim MAX11100 driver
      dt-bindings: iio: document MAX11100 ADC

Javier Martinez Canillas (3):
      iio: light: opt3001: Export OF device ID table as module aliases
      iio: potentiometer: mcp4531: Export OF device ID table as module aliases
      iio: adc: max1363: Export OF device ID table as module aliases

Linus Walleij (1):
      iio: inkern: pass through raw values if no scaling

Lorenzo Bianconi (3):
      iio: imu: add support to lsm6dsx driver
      Documentation: dt: iio: add st_lsm6dsx sensor device binding
      iio: imu: st_lsm6dsx: fix typo in gyro sensitivity definition

Manivannan Sadhasivam (1):
      iio:temperature: Add support for TI TMP007 sensor

Nicholas Mc Guire (1):
      iio: health: max30100: use msleep() for long uncritical delays

Phil Reid (1):
      iio: adc: tlc4541: add support for TI tlc4541 adc

 Documentation/ABI/testing/sysfs-bus-iio            |   3 +-
 .../devicetree/bindings/iio/adc/max11100.txt       |  18 +
 .../devicetree/bindings/iio/adc/ti-ads7950.txt     |  23 +
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |  24 +
 .../devicetree/bindings/iio/temperature/tmp007.txt |  27 +
 drivers/iio/adc/Kconfig                            |  21 +
 drivers/iio/adc/Makefile                           |   2 +
 drivers/iio/adc/max11100.c                         | 181 ++++++
 drivers/iio/adc/max1363.c                          |   1 +
 drivers/iio/adc/ti-ads1015.c                       |   4 +-
 drivers/iio/adc/ti-ads7950.c                       |  32 +-
 drivers/iio/adc/ti-tlc4541.c                       | 271 +++++++++
 drivers/iio/health/max30100.c                      |   2 +-
 drivers/iio/imu/Kconfig                            |   1 +
 drivers/iio/imu/Makefile                           |   2 +
 drivers/iio/imu/bmi160/bmi160_core.c               |   8 +-
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |  22 +
 drivers/iio/imu/st_lsm6dsx/Makefile                |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            | 141 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     | 454 ++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 673 +++++++++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        | 101 ++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        | 118 ++++
 drivers/iio/industrialio-trigger.c                 |  92 +--
 drivers/iio/inkern.c                               |  10 +-
 drivers/iio/light/cm3605.c                         |   4 +-
 drivers/iio/light/opt3001.c                        |   1 +
 drivers/iio/magnetometer/ak8974.c                  |   8 +-
 drivers/iio/magnetometer/mag3110.c                 |  30 +-
 drivers/iio/potentiometer/mcp4531.c                |   1 +
 drivers/iio/pressure/ms5611_core.c                 |  12 +-
 drivers/iio/proximity/sx9500.c                     |  10 +-
 drivers/iio/temperature/Kconfig                    |  10 +
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/tmp007.c                   | 345 +++++++++++
 drivers/iio/trigger/iio-trig-interrupt.c           |   8 +-
 drivers/iio/trigger/iio-trig-sysfs.c               |   2 +-
 drivers/staging/iio/light/isl29028.c               | 323 ++++++----
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |   4 +-
 39 files changed, 2790 insertions(+), 205 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/max11100.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads7950.txt
 create mode 100644 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/tmp007.txt
 create mode 100644 drivers/iio/adc/max11100.c
 create mode 100644 drivers/iio/adc/ti-tlc4541.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/Kconfig
 create mode 100644 drivers/iio/imu/st_lsm6dsx/Makefile
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
 create mode 100644 drivers/iio/temperature/tmp007.c
