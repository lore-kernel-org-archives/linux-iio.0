Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754074AbeAGRJj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jan 2018 12:09:39 -0500
Date: Sun, 7 Jan 2018 17:09:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org
Subject: [PULL] Second set of IIO patches for the 4.16 cycle.
Message-ID: <20180107170935.7d843a2d@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 93d3ad90c2d470804b16f79e7e872408747d3e77:

  drivers: visorbus: move driver out of staging (2017-12-08 16:37:50 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.16b

for you to fetch changes up to 1a0f51d5aaf71da6090ab839ba507b7df27efcbd:

  iio: chemical: ccs811: Fix output of IIO_CONCENTRATION channels (2018-01-07 16:39:19 +0000)

----------------------------------------------------------------
Second set containing features and cleanup for IIO in the 4.16 cycle

Lots of work on the ina2xx driver this time including some nice tricks
to reduce bus usage.

There are a couple of fixes in here that would have gone via a
faster route if we were ealier in the cycle.

Features
* Core
  - Add a sysfs attribtue to expose the amount of data available in the
    buffer (where known).
* hx711
  - Add triggered buffer support.

Cleanup / Fixes
* Core
  - Trigger core documentation fixes.
* Docs
  - The ABI docs had wrong name for current_timestamp_clock file.
  - Fix some kernel-doc issues
* ad7152
  - BIT macro conversions.
* adis16136
  - Switch to DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe.
* adis16480
  - Switch to DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe.
* bfin-timer
  - replace device_attr with device_attr_rw.
* ad7192
  - Drop unnecessary parentheses
* am335x_adc
  - remove a pointless bool conversion.
* at91-adc
  - Fix a brace warning.
* bmg160
  - drop a duplicate include
* bmp280
  - Read calibration data once at probe, it doesn't change.
* ccs811
  - Scale value was not conforming with ABI.  Would have gone via
    fixes path if we were earlier in the cycle.
* dummy_evgen
  - Modify the check on return from irq_sim_init as first step in a
    rework of that code so that it returns the base of the range on
    success rather than just 0.  Rework will occur in next cycle.
* hts211
  - Move common code from i2c and spi probes to the core one.
* hx711
  - fix a bug in reset that meant two close together reads would not
    actually cause two reads.
* ina2xx
  - Make the calibration register value fixed as there is no actual
    benefit in changing it and it can be a bad idea.
  - Use a monotonic clock for delay calculation.
  - Align the timetsmp with the conversion ready flag.
  - Manipulate the loop timing to make it line up with real timing
    saving on pointless reads.
  - Drop a bogus cast
  - Clarify size required for the data buffer (documentation and code
    adjusted to make the relationship obvious).
  - Remove unnecessary read to clear CNVR flag.
  - Udelay was potentially for several seconds, switch to usleep_range.
* lsm6dsx
  - Fix an endianness bug in *read_oneshot (note this is in this pull
    as, given time in cycle this is probably fastest merge route)
  - Protect configuration with it's own lock.
  - Switch to using regmap to avoid a locally rolled version of
    same thing.  Follow up patch dropped a left over forward
    declaration.
  - Preallocate the read buffer to fix sparse warning on variable
    length array.
* mcp4725
  - Drop pointless bool conversion.
* meson-saradc
  - Fix a slight error in the clocks for Meson8 and Meson8b.  No
    visible result of being wrong though.
  - Make sure the channel muxes are initialized.  Some devices have
    these already programmed, but on a few devices they aren't so
    you can get garbage on unconfigured channels.
* mma8452
  - SPDX license
* ssp_sensors
  - Use ktime_get_real_ns instead of getnstimeofday to avoid 2038
    issues.
  - As of_device_id.data is const, we can make the value which is
    assigned to it const as well.
* st uvis25
  - Make soem structures static
* stm32
  - SPDX license
  - Fix a bug with multiple channel DMA (would have gone more
    directly if we weren't so late in the cycle).
* tsl2x7x
  - Break some long lines.

----------------------------------------------------------------
Aishwarya Pant (1):
      staging: iio: trigger: blackfin timer: replace device_attr with device_attr_rw

Andreas Klinger (2):
      iio: hx711: add triggered buffer support
      iio: hx711: fix bug in reset functionality

Andrew F. Davis (1):
      iio: dac: mcp4725: Remove unneeded conversions to bool

Arnd Bergmann (1):
      iio: common: ssp_sensors: use ktime_get_real_ns() timestamps

Bartosz Golaszewski (1):
      iio: dummy_evgen: modify the return value check for irq_sim_init()

Benjamin Gaignard (1):
      iio: stm32: Adopt SPDX identifier

Colin Ian King (1):
      iio: light: make a couple of config structures static

Fabrice Gasnier (1):
      iio: adc: stm32: fix scan of multiple channels with DMA

George Edward Bulmer (1):
      staging: iio: light: Add breaks to lengthy lines

Ji-Hun Kim (1):
      staging: iio: remove unnecessary parentheses

Julia Lawall (1):
      iio: common: ssp_sensors: account for const type of of_device_id.data

Linus Walleij (1):
      iio: ABI: Fix name of timestamp sysfs file

Lorenzo Bianconi (6):
      iio: humidity: hts221: move common code in hts221_core
      iio: imu: st_lsm6dsx: fix endianness in st_lsm6dsx_read_oneshot()
      iio: imu: st_lsm6dsx: introduce conf_lock mutex
      iio: imu: st_lsm6dsx: add regmap API support
      iio: imu: st_lsm6dsx: pre-allocate read buffer at bootstrap
      iio: imu: st_lsm6dsx: remove st_lsm6dsx_write_with_mask() declaration

Maciej Purski (1):
      iio: adc: ina2xx: Make calibration register value fixed

Martin Blumenstingl (2):
      iio: adc: meson-saradc: fix the clock frequency on Meson8 and Meson8b
      iio: adc: meson-saradc: program the channel muxes during initialization

Martin Kepplinger (1):
      iio: mma8452: replace license description with SPDX specifier

Matt Fornero (1):
      iio: buffer: Expose data available

Narcisa Ana Maria Vasile (1):
      iio: chemical: ccs811: Fix output of IIO_CONCENTRATION channels

Pravin Shedge (1):
      drivers: iio: gyro: remove duplicate includes

Stefan Brüns (7):
      iio: adc: ina2xx: Remove bogus cast for data argument
      iio: adc: ina2xx: Clarify size requirement for data buffer
      iio: adc: ina2xx: Remove unneeded dummy read to clear CNVR flag
      iio: adc: ina2xx: Do not udelay for several seconds
      iio: adc: ina2xx: Use a monotonic clock for delay calculation
      iio: adc: ina2xx: Align timestamp with conversion ready flag
      iio: adc: ina2xx: Actually align the loop with the conversion ready flag

Stefan Tatschner (1):
      iio:pressure:bmp280: Read calibration data in probe

Sumit Pundir (1):
      Staging: iio: cdc: ad7152: Prefer using BIT macro

Tobin C. Harding (3):
      iio: fix SPHINX kernel-docs build warning
      iio: add kernel-doc for field @owner
      iio: add field identifier for @use_count kernel-doc

Venkat Prashanth B U (4):
      Drivers: iio:adc: fix brace coding style issue in at91_adc.c
      Drivers:iio:adc:ti_am335x_adc remove comparison to bool
      gyro:adis16136: fix debugfs_simple_attr.cocci warnings
      imu:adis16480: fix debugfs_simple_attr.cocci warnings

 Documentation/ABI/testing/sysfs-bus-iio           |  12 +-
 drivers/iio/accel/mma8452.c                       |   4 +-
 drivers/iio/adc/Kconfig                           |   2 +
 drivers/iio/adc/at91_adc.c                        |   4 +-
 drivers/iio/adc/hx711.c                           | 134 ++++++++++----
 drivers/iio/adc/ina2xx-adc.c                      | 174 +++++++++++--------
 drivers/iio/adc/meson_saradc.c                    |  40 ++++-
 drivers/iio/adc/stm32-adc-core.c                  |  14 +-
 drivers/iio/adc/stm32-adc-core.h                  |  14 +-
 drivers/iio/adc/stm32-adc.c                       |  18 +-
 drivers/iio/adc/ti_am335x_adc.c                   |   2 +-
 drivers/iio/chemical/ccs811.c                     |  13 +-
 drivers/iio/common/ssp_sensors/ssp.h              |   2 +-
 drivers/iio/common/ssp_sensors/ssp_dev.c          |   2 +-
 drivers/iio/common/ssp_sensors/ssp_spi.c          |   5 +-
 drivers/iio/counter/stm32-lptimer-cnt.c           |   2 +-
 drivers/iio/dac/mcp4725.c                         |   2 +-
 drivers/iio/dac/stm32-dac-core.c                  |  14 +-
 drivers/iio/dac/stm32-dac-core.h                  |  15 +-
 drivers/iio/dac/stm32-dac.c                       |  15 +-
 drivers/iio/dummy/iio_dummy_evgen.c               |   2 +-
 drivers/iio/gyro/adis16136.c                      |  15 +-
 drivers/iio/gyro/bmg160_core.c                    |   1 -
 drivers/iio/humidity/hts221.h                     |   3 +-
 drivers/iio/humidity/hts221_core.c                |  18 +-
 drivers/iio/humidity/hts221_i2c.c                 |  18 +-
 drivers/iio/humidity/hts221_spi.c                 |  18 +-
 drivers/iio/imu/adis16480.c                       |  28 +--
 drivers/iio/imu/st_lsm6dsx/Kconfig                |   2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h           |  39 ++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 107 ++++++++----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c      | 115 ++++++------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c       |  55 ++----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c       |  70 ++------
 drivers/iio/industrialio-buffer.c                 |  15 ++
 drivers/iio/light/st_uvis25_i2c.c                 |   2 +-
 drivers/iio/light/st_uvis25_spi.c                 |   2 +-
 drivers/iio/pressure/bmp280-core.c                | 203 ++++++++++++++--------
 drivers/iio/trigger/stm32-lptimer-trigger.c       |   3 +-
 drivers/iio/trigger/stm32-timer-trigger.c         |   2 +-
 drivers/staging/iio/adc/ad7192.c                  |   2 +-
 drivers/staging/iio/cdc/ad7152.c                  |   8 +-
 drivers/staging/iio/light/tsl2x7x.c               |   9 +-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c |  15 +-
 include/linux/iio/iio.h                           |   4 +-
 include/linux/iio/trigger.h                       |   3 +-
 46 files changed, 655 insertions(+), 592 deletions(-)
