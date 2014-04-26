Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56196 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbaDZOsu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 26 Apr 2014 10:48:50 -0400
Message-ID: <535BC7A9.4030802@kernel.org>
Date: Sat, 26 Apr 2014 15:50:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers, features and cleanups for 3.16 - set 1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 24e7d7990179e5ed38e90d78d12c25fa201c618a:

   staging: cxt1e1: Removed assignments from if statements. (2014-03-13 17:44:45 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.16a

for you to fetch changes up to ea7e586bdd331fd6fba2b6f9fd3777928c2814d8:

   iio: st_sensors: move regulator retrieveal to core (2014-04-26 11:52:42 +0100)

----------------------------------------------------------------
First round of IIO new driver, functionality and cleanups for the 3.16 cycle.

New device support
* AS3935 Lightning Sensor
* MCP3426/7/8 support added to the existing MCP3422 ADC driver
* AK8963 support in the AK8975 driver
* MPU6500 support in the MPU6050 driver (the functionality that is different
   is mostly not supported yet in either part).

Staging Graduations
* AD799x ADC

New functionality
* ACPI enumeration for the ak8975 driver

Cleanup / tweaks
* Use snprintf as a matter of good practice in a few additional places.
* Document *_mean_raw attributes.  These have been there a while, but were
   undocumented.
* Add an in kernel interface to get the mean values.
* Bug in the length of the event info mask that by coincidence wasn't yet
   actually causing any problems.
* itg3000 drop an unreachable return statement.
* spear_adc cleanups (heading for a staging graduation but a few more
   issues showed up in the review of these patches).
* Exynos ADC dependencies changed so it is only built when Exynos is present
   or COMPILE_TEST and OF are set.
* tsl2583 cleanups.
* Some cut and paste typos in the comments of various drivers still in staging.
* Couple of minor improvements to the ST sensor drivers.

----------------------------------------------------------------
Angelo Compagnucci (1):
       Add support for Microchip Technology's MCP3426/7/8 ADC

Jean Delvare (1):
       iio: adc: Fix exynos_adc dependencies

Jonathan Cameron (8):
       iio:core: Fix bug in length of event info_mask and catch unhandled bits set in masks.
       iio:gyro:itg3200 - drop unreachable return ret. Highlighted by smatch
       staging:iio:adc:spear adc - prefix defines to avoid namespace clashes.
       staging:iio:adc:spear_adc drop initialization of unused scan_type
       staging:iio:adc:spear_adc use info_mask_shared_by_all for samp freq
       staging:iio:adc:spear rename device specific state structure to _state
       staging:iio:adc:spear rename iodev -> indio_dev to fit with current convention
       staging:iio:adc:spear rename spear_read_raw to spear_adc_read_raw

Kees Cook (1):
       iio: force snprintf for PAGE_SIZE bufs

Lars-Peter Clausen (2):
       staging:iio:ad799x: Move ring functions to the main file
       staging:iio: Move ad799x driver out of staging

Linus Walleij (2):
       iio: st_sensors: announce registered sensors
       iio: st_sensors: move regulator retrieveal to core

Masanari Iida (1):
       staging: iio: Fix typo in iio

Matt Ranostay (2):
       iio:as3935: Add DT binding docs for AS3935 driver
       iio: Add AS3935 lightning sensor support

Michael Welling (3):
       Staging:iio:tsl2583 Removes unwanted space before semicolon
       Staging:iio:tsl2583 Remove quoted string split across lines warnings
       Staging:iio:tsl2583 Switch from msleep to usleep range per timers-howto.txt

Sebastian Reichel (2):
       iio: documentation: Add ABI documentation for *_mean_raw
       iio: inkern: add iio_read_channel_average_raw

Srinivas Pandruvada (3):
       iio: ak8975 : Add AK8963 compatibility mode support
       iio: ak8975: Added ACPI enumeration
       iio: imu: inv_mpu6050: Add compatibity with MPU6500

  Documentation/ABI/testing/sysfs-bus-iio            |   8 +
  .../ABI/testing/sysfs-bus-iio-proximity-as3935     |  16 +
  .../devicetree/bindings/iio/proximity/as3935.txt   |  28 ++
  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
  drivers/iio/Kconfig                                |   1 +
  drivers/iio/Makefile                               |   1 +
  drivers/iio/accel/st_accel_core.c                  |   7 +
  drivers/iio/adc/Kconfig                            |  20 +-
  drivers/iio/adc/Makefile                           |   1 +
  .../iio/adc/ad799x_core.c => iio/adc/ad799x.c}     | 145 ++++++-
  drivers/iio/adc/mcp3422.c                          |  33 +-
  drivers/iio/common/st_sensors/st_sensors_core.c    |  37 ++
  drivers/iio/gyro/itg3200_core.c                    |   2 -
  drivers/iio/gyro/st_gyro_core.c                    |   7 +
  drivers/iio/imu/inv_mpu6050/Kconfig                |   2 +
  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   1 +
  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   1 +
  drivers/iio/industrialio-core.c                    |   6 +-
  drivers/iio/industrialio-event.c                   |   4 +-
  drivers/iio/inkern.c                               |  18 +
  drivers/iio/magnetometer/Kconfig                   |   3 +-
  drivers/iio/magnetometer/ak8975.c                  |  70 +++-
  drivers/iio/magnetometer/st_magn_core.c            |   7 +
  drivers/iio/pressure/st_pressure_core.c            |  42 +-
  drivers/iio/proximity/Kconfig                      |  19 +
  drivers/iio/proximity/Makefile                     |   6 +
  drivers/iio/proximity/as3935.c                     | 456 +++++++++++++++++++++
  drivers/staging/iio/adc/Kconfig                    |  20 -
  drivers/staging/iio/adc/Makefile                   |   4 -
  drivers/staging/iio/adc/ad7606.h                   |   4 +-
  drivers/staging/iio/adc/ad7816.c                   |   2 +-
  drivers/staging/iio/adc/ad799x.h                   | 121 ------
  drivers/staging/iio/adc/ad799x_ring.c              |  84 ----
  drivers/staging/iio/adc/spear_adc.c                | 315 +++++++-------
  drivers/staging/iio/addac/adt7316.c                |   4 +-
  drivers/staging/iio/cdc/ad7152.c                   |   2 +-
  drivers/staging/iio/cdc/ad7746.c                   |   2 +-
  drivers/staging/iio/light/tsl2583.c                |  38 +-
  include/linux/iio/common/st_sensors.h              |   4 +
  include/linux/iio/consumer.h                       |  13 +
  40 files changed, 1066 insertions(+), 489 deletions(-)
  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
  create mode 100644 Documentation/devicetree/bindings/iio/proximity/as3935.txt
  rename drivers/{staging/iio/adc/ad799x_core.c => iio/adc/ad799x.c} (81%)
  create mode 100644 drivers/iio/proximity/Kconfig
  create mode 100644 drivers/iio/proximity/Makefile
  create mode 100644 drivers/iio/proximity/as3935.c
  delete mode 100644 drivers/staging/iio/adc/ad799x.h
  delete mode 100644 drivers/staging/iio/adc/ad799x_ring.c
