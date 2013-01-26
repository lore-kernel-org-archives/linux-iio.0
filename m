Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45574 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab3AZLbG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 26 Jan 2013 06:31:06 -0500
Message-ID: <5103BE79.5020602@kernel.org>
Date: Sat, 26 Jan 2013 11:31:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO cleanups, new drivers and fixes (IIO set 2 for the 3.9
 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 8f5f90a872c38b4e78f3cc95e8a25434b98e4db2:

  Merge 3.8-rc5 into staging-next (2013-01-25 21:25:02 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.9b

for you to fetch changes up to a412a902158dccfeb946963f9fc908bad1718e30:

  iio:light:tsl2563 move out of staging (2013-01-26 10:40:04 +0000)

----------------------------------------------------------------
Second set of IIO new drivers, cleanups and fixes for the 3.9 cycle.

Minor bits:
1) A Kconfig dependency fix for the max1363 driver that
has been causing some autobuilder fails in Linux Next.
2) Removal of a stale makefile entry
3) Fix an incorrect arguement for a sizeof call
4) Duplicate code removal in tsl2x7x driver
5) A missing spin lock init in hid-sensor-time

New features:
1) mxs adc driver gains support for touchscreen special functions
2) mxs driver gainst supprot for the MX23 and dt entries added
3) adis16400 gains adis16448 support and some additional bells and whistles

Moves out of staging.
1) adis16400 - a venerable driver gets a make over and moves
   out of staging.
2) Kxsd9 moved out fo staging
3) adis16080 gets cleaned up and moved out of staging
4) tsl2563 gets a little cleaned up and move out of staging

Removals
1) sw_ring is killed off with all remaining drivers converted to kfifo.
   This has been scheduled for a long time since we switched to kfifo.
   There is demand for a high performance alternative, but this was
   never it and I'm glad to see this vestage of IIOs youth gone once
   and for all!

----------------------------------------------------------------
Axel Lin (1):
      rtc: hid-sensor-time: Add missing spin_lock_init

Jonathan Cameron (11):
      staging:iio:accel:lis3l02dq remove sw_ring support.
      staging:iio:impedance-analyzer switch from sw_ring to kfifo.
      staging:iio:meter:ade7758 switch from sw_ring to kfifo
      staging:iio: drop sw_ring buffer implementation.
      staging:iio:accel:kxsd9
      iio:accel:kxsd9 move out of staging
      staging:iio:light:tsl2563 drop unnecessary brackets around constants.
      staging:iio:light:tsl2563 clean comments up.
      staging:iio:tsl2563 Simplify exit path on error in read_interrupt_config.
      staging:iio:tsl2563 drop pointless forward declaration
      iio:light:tsl2563 move out of staging

Lars-Peter Clausen (23):
      staging:iio:gyro: Remove stale Makefile entry
      staging:iio:tsl2x7x: Use iio_str_to_fixedpoint instead of open-coding it
      staging:iio:adis16400: Don't pass 0 to ilog2
      staging:iio:adis16400: Fix and cleanup 3db filter setting
      staging:iio:adis16400: Remove unused default_scan_mask
      staging:iio:adis16400: Use adis library
      staging:iio:adis16400: Use triggered buffer setup helper function
      staging:iio:adis16400: Add helper macros for channel declaration
      staging:iio:adis16400: Preallocate transfer message
      staging:iio:adis16400: Remove unit suffix from samplerate attribute
      staging:iio:adis16400: Remove samplerate_available attribute
      staging:iio:adis16400: Code style cleanup
      staging:iio: Move adis16400 out of staging
      iio:adis16400: Increase samplerate precession
      iio:adis16400: Add support for the 52.85 Hz base sampling rate
      iio:adis16400: Expose some debug information in debugfs
      iio:adis16400: Add support for the adis16448
      staging:iio:adis16080: Add device id table entry for the adis16100
      staging:iio:adis16080: Cleanup SPI transfer
      staging:iio:adis16080: be16 cleanups
      staging:iio:adis16080: Remove unnecessary lock
      staging:iio:adis16080: Add scale and offset attributes
      staging:iio:adis16080: Move out of staging

Marek Vasut (3):
      iio: mxs: Implement support for touchscreen
      iio: mxs: Add MX23 support into the IIO driver
      ARM: mxs: Add OF props for MX23 LRADC

Peter Huewe (1):
      staging/iio: Use correct argument for sizeof

Peter Meerwald (1):
      iio: fix Kconfig for max1363

 .../bindings/staging/iio/adc/mxs-lradc.txt         |    6 +
 arch/arm/boot/dts/imx23.dtsi                       |    2 +
 drivers/iio/accel/Kconfig                          |    7 +
 drivers/iio/accel/Makefile                         |    1 +
 drivers/{staging => }/iio/accel/kxsd9.c            |   10 +-
 drivers/iio/adc/Kconfig                            |    4 +-
 drivers/iio/gyro/Kconfig                           |    7 +
 drivers/iio/gyro/Makefile                          |    1 +
 .../gyro/adis16080_core.c => iio/gyro/adis16080.c} |  154 ++-
 drivers/iio/imu/Kconfig                            |   11 +
 drivers/iio/imu/Makefile                           |    3 +
 drivers/{staging => }/iio/imu/adis16400.h          |  141 +--
 drivers/iio/imu/adis16400_buffer.c                 |   96 ++
 drivers/iio/imu/adis16400_core.c                   |  965 ++++++++++++++
 drivers/iio/light/Kconfig                          |   10 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/{staging => }/iio/light/tsl2563.c          |   96 +-
 drivers/rtc/rtc-hid-sensor-time.c                  |    1 +
 drivers/staging/iio/Kconfig                        |   14 -
 drivers/staging/iio/Makefile                       |    3 -
 drivers/staging/iio/accel/Kconfig                  |   30 +-
 drivers/staging/iio/accel/Makefile                 |    2 -
 drivers/staging/iio/accel/lis3l02dq.h              |    8 -
 drivers/staging/iio/accel/lis3l02dq_ring.c         |    7 +-
 drivers/staging/iio/adc/Kconfig                    |    4 +-
 drivers/staging/iio/adc/mxs-lradc.c                |  522 +++++++-
 drivers/staging/iio/gyro/Kconfig                   |    7 -
 drivers/staging/iio/gyro/Makefile                  |    6 -
 drivers/staging/iio/iio_hwmon.c                    |    2 +-
 drivers/staging/iio/impedance-analyzer/Kconfig     |    2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    8 +-
 drivers/staging/iio/imu/Kconfig                    |   17 -
 drivers/staging/iio/imu/Makefile                   |    7 -
 drivers/staging/iio/imu/adis16400_core.c           | 1320 --------------------
 drivers/staging/iio/imu/adis16400_ring.c           |  204 ---
 drivers/staging/iio/imu/adis16400_trigger.c        |   74 --
 drivers/staging/iio/light/Kconfig                  |   10 -
 drivers/staging/iio/light/Makefile                 |    1 -
 drivers/staging/iio/light/tsl2x7x_core.c           |   78 +-
 drivers/staging/iio/meter/Kconfig                  |    2 +-
 drivers/staging/iio/meter/ade7758_ring.c           |   12 +-
 drivers/staging/iio/ring_sw.c                      |  366 ------
 drivers/staging/iio/ring_sw.h                      |   30 -
 .../linux/platform_data}/tsl2563.h                 |    1 -
 44 files changed, 1845 insertions(+), 2408 deletions(-)
 rename drivers/{staging => }/iio/accel/kxsd9.c (99%)
 rename drivers/{staging/iio/gyro/adis16080_core.c => iio/gyro/adis16080.c} (55%)
 rename drivers/{staging => }/iio/imu/adis16400.h (68%)
 create mode 100644 drivers/iio/imu/adis16400_buffer.c
 create mode 100644 drivers/iio/imu/adis16400_core.c
 rename drivers/{staging => }/iio/light/tsl2563.c (91%)
 delete mode 100644 drivers/staging/iio/imu/Kconfig
 delete mode 100644 drivers/staging/iio/imu/Makefile
 delete mode 100644 drivers/staging/iio/imu/adis16400_core.c
 delete mode 100644 drivers/staging/iio/imu/adis16400_ring.c
 delete mode 100644 drivers/staging/iio/imu/adis16400_trigger.c
 delete mode 100644 drivers/staging/iio/ring_sw.c
 delete mode 100644 drivers/staging/iio/ring_sw.h
 rename {drivers/staging/iio/light => include/linux/platform_data}/tsl2563.h (99%)
