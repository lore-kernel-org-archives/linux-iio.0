Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57190 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754612AbcLaOv1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Dec 2016 09:51:27 -0500
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] First round of IIO fixes for the 4.10 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4696228d-4d21-c975-6ea9-1bc01b8e8da8@kernel.org>
Date: Sat, 31 Dec 2016 14:51:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit af8bc2fb99d4eea2d026d42db18abc5f3876936a:

  staging: unisys: visorbus: Remove two passthrough postcode macros (2016-12-01 09:58:48 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.10a

for you to fetch changes up to 65e4345c8ef8811bbb4860fe5f2df10646b7f2e1:

  iio: accel: st_accel: fix LIS3LV02 reading and scaling (2016-12-31 14:35:04 +0000)

----------------------------------------------------------------
First round of IIO fixes for the 4.10 cycle.

* 104-quad-8
  - Fix selecting wrong register when the index control register is desired.
  - Fix an off by one error when addressing the input/output control register.
  - Fix inverted logic on the active high / low control
* bmi160
  - Sleep for worst case rather than best case amount of time after cmd
  execution begins.
* max44000
  - typo fix in illuminance_integration_time_available listing.
* st-sensors
  - Fix channel data passing.  This one took a while to get tested on 24bit
  parts. Definitely one for stable asap as the bug broke quite a few parts.
  - lis3lv02 needs a data alignment bit set and the scaling was wrong.
* ti_am335x
  - depend on HAS_DMA

----------------------------------------------------------------
Akinobu Mita (1):
      iio: max44000: correct value in illuminance_integration_time_available

Geert Uytterhoeven (1):
      iio: adc: TI_AM335X_ADC should depend on HAS_DMA

Linus Walleij (1):
      iio: accel: st_accel: fix LIS3LV02 reading and scaling

Lorenzo Bianconi (1):
      iio: common: st_sensors: fix channel data parsing

Marcin Niestroj (1):
      iio: bmi160: Fix time needed to sleep after command execution

William Breathitt Gray (3):
      iio: 104-quad-8: Fix index control configuration
      iio: 104-quad-8: Fix off-by-one errors when addressing IOR
      iio: 104-quad-8: Fix active level mismatch for the preset enable option

 drivers/iio/accel/st_accel_core.c                 | 12 +++++++++--
 drivers/iio/adc/Kconfig                           |  2 +-
 drivers/iio/common/st_sensors/st_sensors_buffer.c |  4 +++-
 drivers/iio/common/st_sensors/st_sensors_core.c   | 13 +++++++++++-
 drivers/iio/counter/104-quad-8.c                  | 13 +++++++-----
 drivers/iio/imu/bmi160/bmi160_core.c              | 25 ++++++-----------------
 drivers/iio/light/max44000.c                      |  2 +-
 include/linux/iio/common/st_sensors.h             | 12 +++++++++++
 8 files changed, 53 insertions(+), 30 deletions(-)
