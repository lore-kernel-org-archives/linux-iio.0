Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752990AbdHTOfS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Aug 2017 10:35:18 -0400
Date: Sun, 20 Aug 2017 15:35:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org
Subject: [PULL] Second set of IIO fixes for the 4.13 cycle.
Message-ID: <20170820153514.4c019d8f@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 055655a9f0fefef2256310a128a4cdaff8b8c432:

  Merge tag 'iio-fixes-for-4.13a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2017-07-23 20:54:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/fixes-for-4.13b

for you to fetch changes up to 8b35a5f87a73842601cd376e0f5b9b25831390f4:

  iio: magnetometer: st_magn: remove ihl property for LSM303AGR (2017-08-20 15:21:49 +0100)

----------------------------------------------------------------
Second set of IIO fixes for the 4.13 cycle.

Given the late stage of this series, some more involved fixes have been
held back for the upcoming merge window.

The hid-sensor issue has been causing problems for a long time so it
is great to have that one finally fixed!  No more bug reports for the
userspace guys (well about that anyway).

* documentation
  - some warning fixes due to missing colons in kernel-doc.
* adis16480
  - fix accel scale factor.
* bmp280
  - properly initialize the device for humidity readings - without this
  the humidity readings may be skipped and a magic value of 0x8000 returned.
* hid-sensor-strigger
  - fix a race with user space when powering up the sensor.
* ina291
  - Avoid an underflow for the sleeping time as a result of supporting the
  fastest rates.
* st-magnetometer
  - Fix the status register address for hte LSM303AGR,
  - Remove the ihl property for LSM303AGR as the sensor doesn't support
  active low for the dataready line.
* stm32-adc
  - Fix use of a common clock rate.
* stm32-timer
  - fix the quadrature mode get routine to account for the magic 0 value.
  set on boot.
  - fix the return value of write_raw,
  - fix the get/set down count direction as the enum value was not being
  converted to the relevant bit field,
  - add an enable attribute to actually turn it on when in encoder mode,
  - missing mask when reading the trigger mode.

----------------------------------------------------------------
Andreas Klinger (1):
      iio: bmp280: properly initialize device for humidity reading

Dragos Bogdan (1):
      iio: imu: adis16480: Fix acceleration scale factor for adis16480

Fabrice Gasnier (6):
      iio: trigger: stm32-timer: fix quadrature mode get routine
      iio: trigger: stm32-timer: fix write_raw return value
      iio: trigger: stm32-timer: fix get/set down count direction
      iio: trigger: stm32-timer: add enable attribute
      iio: adc: stm32: fix common clock rate
      iio: trigger: stm32-timer: fix get trigger mode

Jonathan Corbet (1):
      PATCH] iio: Fix some documentation warnings

Lorenzo Bianconi (2):
      iio: magnetometer: st_magn: fix status register address for LSM303AGR
      iio: magnetometer: st_magn: remove ihl property for LSM303AGR

Srinivas Pandruvada (1):
      iio: hid-sensor-trigger: Fix the race with user space powering up sensors

Stefan Brüns (1):
      iio: adc: ina219: Avoid underflow for sleeping time

 drivers/iio/adc/ina2xx-adc.c                       |  2 +-
 drivers/iio/adc/stm32-adc-core.c                   | 10 +--
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  8 +--
 drivers/iio/imu/adis16480.c                        |  2 +-
 drivers/iio/magnetometer/st_magn_core.c            |  4 +-
 drivers/iio/pressure/bmp280-core.c                 | 27 ++++++-
 drivers/iio/pressure/bmp280.h                      |  5 ++
 drivers/iio/trigger/stm32-timer-trigger.c          | 82 ++++++++++++++++------
 include/linux/iio/iio.h                            |  2 +-
 include/linux/iio/trigger.h                        |  4 +-
 10 files changed, 103 insertions(+), 43 deletions(-)
