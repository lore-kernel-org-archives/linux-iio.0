Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40702 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757680AbdCUTRD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 15:17:03 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] Second set of new IIO device support and cleanups for the 4.12
 cycle
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2efca4ba-3c59-6d57-6049-b0f4867b2d43@kernel.org>
Date: Tue, 21 Mar 2017 19:17:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 1d3da3fed1a211d11d33aff1fb2438a1fc27740e:

  atomisp: USE_KMEM_CACHE is always defined so remove the dead code (2017-03-08 13:40:00 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.12b

for you to fetch changes up to 02b829f9e11fd9e6eeebc1e85e4d5ae641706c70:

  iio: dac: Add support for ltc2632 DACs (2017-03-21 18:43:56 +0000)

----------------------------------------------------------------
2nd set of new device support, features and cleanups for IIO in the 4.12 cycle

A good collection of outreachy related patches in here - mostly staging
driver cleanup. Also a fair number of patches added explicit OF device ID
tables for i2c drivers - a precursor to dropping (eventually) the implicit
probing.

New Device Support
* Allwinner SoC ADC.
  - So far covers the sun4i-a10, sun5i-a13 and sun6i-a31 general purpose ADCs,
  including thermal side of things.
  This missed the last cycle due to my incompetence, so good to get in now,
  particularly as various patches dependent on it are appearing.
* ltc2632
  - new driver supporting ltc2632-l12, ltc2632-l10, ltc2632-l8, ltc2632-h12,
    ltc-2632-h10, ltc-2632-h8 dacs

Cleanups
* Documentation
  - drop a broken reference to i2c/trivial-devices
* ad2s1200
  - drop & from function pointers for consistency.
* ad2s1210
  - formatting fixes.
* ad7152
  - octal permissions instead of symbolic.
  - drop & from function pointers for consistent usage.
* ad7192
  - drop & from function pointers for consistent usage.
* ad7280
  - replace core mlock usage with a local lock as mlock is intended only to
  protect the current device state (direct reads, or triggered and buffered)
* ad7746
  - drop & from function pointers for consistent usage.
  - replace core mlock usage with a local lock as mlock is intended only to
  protect the current device state (direct reads, or triggered and buffered)
* ad7754
  - move contents of header file into source file as not used anywhere else.
* ad7759
  - move contents of header file into source file as not used anywhere else.
* ad7780
  - drop & from function pointers for consistent usage.
* ad7832
  - replace core mlock usage with a local lock as mlock is intended only to
  protect the current device state (direct reads, or triggered and buffered)
* ad9834
  - replace core mlock usage with a local lock as mlock is intended only to
  protect the current device state (direct reads, or triggered and buffered)
  - drop an unnecessary goto in favour of direct return.
* adis16060
  - drop & from function pointers as inconsistent.
* adis16201
  - drop a local mutex as the adis core already protects everything necessary.
  - drop & from function pointers for consistent usage.
* adis16203
  - drop & from function pointers for consistent usage.
* adis16209
  - drop a local mutex as the adis core already protects everything necessary.
  - use an enum for scan index giving slightly nicer code.
  - drop & from function pointers for consistent usage.
* adis16240
  - drop a local mutex as the adis core already protects everything necessary.
  - use an enum for scan index giving slightly nicer code.
  - drop & from function pointers for consistent usage.
* apds9960
  - add OF device ID table.
* bma180
  - add OF device ID table.
  - prefer unsigned int to bare use of unsigned.
* bmc150_magn
  - add OF device ID table.
* hmp03
  - add OF device ID table.
* ina2xx
  - add OF device ID table.
* itg3200
  - add OF device ID table.
* mag3110
  - add OF device ID table.
* max11100
  - remove .owner field as it is set by the spi core.
* max5821
  - add .of_match_table set to the ID table which was present but not used.
* mcp4725
  - add OF device ID table.
* mlx96014
  - add OF device ID table.
* mma7455
  - add OF device ID table.
* mma7660
  - add OF device ID table.
* mpl3115
  - add OF device ID table.
* mpu6050
  - add OF device ID table.
* pc104
  - mask pc104 drivers behind a global pc104 config option.
* ti-ads1015
  - add OF device ID table.
* tsl2563
  - add OF device ID table.
* us5182d
  - add OF device ID table.

----------------------------------------------------------------
Aishwarya Pant (2):
      staging:iio:cdc:ade7746 replace mlock with driver private lock
      staging: iio: accel: adis16201: remove iio_dev mlock

Alison Schofield (1):
      staging: iio: ad9832: replace mlock with driver private lock

Bo Yu (1):
      Staging: iio: return expression instead of return ret

Gargi Sharma (1):
      staging: iio: ad7280: Replace mlock with driver private lock

Javier Martinez Canillas (17):
      iio: adc: ina2xx: Add OF device ID table
      iio: mlx96014: Add OF device ID table
      iio: magnetometer: bmc150_magn_i2c: Add OF device ID table
      iio: dac: mcp4725: Add OF device ID table
      iio: light: us5182d: Add OF device ID table
      iio: light: tsl2563: Add OF device ID table
      iio: pressure: hp03: Add OF device ID table
      iio: imu: inv_mpu6050: Add OF device ID table
      iio: accel: bma180: Add OF device ID table
      iio: light: apds9960: Add OF device ID table
      iio: dac: max5821: Set .of_match_table to OF device ID table
      iio: adc: ti-ads1015: Add OF device ID table
      iio: magnetometer: mag3110: Add OF device ID table
      iio: accel: mma7455_i2c: Add OF device ID table
      iio: pressure: mpl3115: Add OF device ID table
      iio: accel: mma7660: Add OF device ID table
      iio: gyro: itg3200: Add OF device ID table

Maxime Roussin-Belanger (1):
      iio: dac: Add support for ltc2632 DACs

Miguel Robles (4):
      Staging: iio: cdc: ad7152.c, use octal permissions instead of symbolic
      iio: accel: Prefer unsigned int to bare use of unsigned
      Staging: iio: cdc: ad7746: use octal permissions instead of symbolic
      Staging: iio: resolver: ad2s1210: Fix warning, statements should start on a tabstop

Narcisa Ana Maria Vasile (3):
      staging: iio: adis16209: Group similar macros into enums
      staging: iio: adis16240: Group similar macros into enums
      staging: iio: adis16209: Remove mutex_lock() and mutex_unlock() calls

Quentin Schulz (1):
      iio: adc: add support for Allwinner SoCs ADC

Varsha Rao (1):
      staging: iio: adis16240: Remove mutex_lock() and mutex_unlock() function call.

Wei Yongjun (1):
      iio: adc: max11100: remove .owner field for driver

William Breathitt Gray (1):
      iio: pc104: Mask PC/104 drivers via the PC104 Kconfig option

Wolfram Sang (1):
      MAINTAINERS: drop broken reference to i2c/trivial-devices

sayli karnik (4):
      staging: iio: ade7759: Move contents of header file to source file
      staging: iio: ade7754: Move contents of header file to source file
      staging: iio: ad9834: Use private driver lock instead of mlock
      staging: iio: ad9834: Remove unnecessary goto statement

simran singhal (10):
      staging: iio: ad7192: Remove exceptional & on function name
      staging: iio: ad7780: Remove exceptional & on function name
      staging: iio: cdc: ad7746: Remove exceptional & on function name
      staging: iio: cdc: ad7152: Remove exceptional & on function name
      staging: iio: adis16240: Remove exceptional & on function name
      staging: iio: adis16201: Remove exceptional & on function name
      staging: iio: adis16209: Remove exceptional & on function name
      staging: iio: adis16203: Remove exceptional & on function name
      staging: iio: resolver: Remove & on function name to align with other IIO drivers.
      staging: iio: gyro: Remove & on function name to conform to similar IIO drivers

 .../devicetree/bindings/iio/dac/ltc2632.txt        |  23 +
 MAINTAINERS                                        |   1 -
 drivers/iio/accel/bma180.c                         |  32 +-
 drivers/iio/accel/mma7455_i2c.c                    |   8 +
 drivers/iio/accel/mma7660.c                        |   7 +
 drivers/iio/adc/Kconfig                            |  19 +-
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ina2xx-adc.c                       |  34 +-
 drivers/iio/adc/max11100.c                         |   1 -
 drivers/iio/adc/sun4i-gpadc-iio.c                  | 613 +++++++++++++++++++++
 drivers/iio/adc/ti-ads1015.c                       |  24 +-
 drivers/iio/counter/Kconfig                        |   2 +-
 drivers/iio/dac/Kconfig                            |  10 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ltc2632.c                          | 314 +++++++++++
 drivers/iio/dac/max5821.c                          |   1 +
 drivers/iio/dac/mcp4725.c                          |  24 +-
 drivers/iio/gyro/itg3200_core.c                    |   7 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |  38 +-
 drivers/iio/light/apds9960.c                       |   7 +
 drivers/iio/light/tsl2563.c                        |  10 +
 drivers/iio/light/us5182d.c                        |   7 +
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |   9 +
 drivers/iio/magnetometer/mag3110.c                 |   7 +
 drivers/iio/pressure/hp03.c                        |   7 +
 drivers/iio/pressure/mpl3115.c                     |   7 +
 drivers/iio/temperature/mlx90614.c                 |   7 +
 drivers/staging/iio/accel/adis16201.c              |  10 +-
 drivers/staging/iio/accel/adis16203.c              |   4 +-
 drivers/staging/iio/accel/adis16209.c              |  26 +-
 drivers/staging/iio/accel/adis16240.c              |  35 +-
 drivers/staging/iio/adc/ad7192.c                   |  12 +-
 drivers/staging/iio/adc/ad7280a.c                  |  22 +-
 drivers/staging/iio/adc/ad7780.c                   |   2 +-
 drivers/staging/iio/cdc/ad7152.c                   |  14 +-
 drivers/staging/iio/cdc/ad7746.c                   |  32 +-
 drivers/staging/iio/frequency/ad9832.c             |   7 +-
 drivers/staging/iio/frequency/ad9834.c             |  14 +-
 drivers/staging/iio/gyro/adis16060_core.c          |   2 +-
 drivers/staging/iio/meter/ade7754.c                |  91 ++-
 drivers/staging/iio/meter/ade7754.h                |  90 ---
 drivers/staging/iio/meter/ade7759.c                |  50 +-
 drivers/staging/iio/meter/ade7759.h                |  53 --
 drivers/staging/iio/resolver/ad2s1200.c            |   2 +-
 drivers/staging/iio/resolver/ad2s1210.c            |   4 +-
 drivers/staging/iio/resolver/ad2s90.c              |   2 +-
 include/linux/mfd/sun4i-gpadc.h                    |   2 +
 47 files changed, 1429 insertions(+), 266 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ltc2632.txt
 create mode 100644 drivers/iio/adc/sun4i-gpadc-iio.c
 create mode 100644 drivers/iio/dac/ltc2632.c
 delete mode 100644 drivers/staging/iio/meter/ade7754.h
 delete mode 100644 drivers/staging/iio/meter/ade7759.h
