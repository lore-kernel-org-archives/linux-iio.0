Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50828 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbdDBTim (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 15:38:42 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] 4th set of IIO fixes for the 4.11 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <209c298f-7ea5-f174-ab38-d94cf95398d0@kernel.org>
Date: Sun, 2 Apr 2017 20:38:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 43c49938bf72b2862aa12b5d66e710e15ce0f7b7:

  Merge tag 'iio-fixes-for-4.11c' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2017-03-22 12:02:01 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.11d

for you to fetch changes up to bba6d9e47f3ea894e501f94b086a59ffe28241ac:

  iio: hid-sensor-attributes: Fix sensor property setting failure. (2017-04-02 11:44:03 +0100)

----------------------------------------------------------------
4th set of IIO fixes for the 4.12 cycle.

core
 - fix IIO_VAL_FRACTIONAL_LOG2 handling for negative values.
bmg160
 - reset chip on probe to avoid a failure on some systems
cros_ec
 - return type correctly when reading raw and calibbias data.
hid-sensor-accel
 - fix a duplicate scan index error due to wrong number of channels
 for gravity sensor.
hid-sensors
 - ensure a get_feature is always done before the first set feature to
 avoid issues with wrong cached values.
st-pressure
 - initalize lps22hb boot time to avoid giving stale data.

----------------------------------------------------------------
Enric Balletbo i Serra (1):
      iio: cros_ec_sensors: Fix return value to get raw and calibbias data.

Nikolaus Schulz (1):
      iio: core: Fix IIO_VAL_FRACTIONAL_LOG2 for negative values

Quentin Schulz (1):
      iio: bmg160: reset chip when probing

Shrirang Bagul (1):
      iio: st_pressure: initialize lps22hb bootime

Song Hongyan (1):
      iio: hid-sensor-attributes: Fix sensor property setting failure.

Srinivas Pandruvada (1):
      iio: accel: hid-sensor-accel-3d: Fix duplicate scan index error

 drivers/iio/accel/hid-sensor-accel-3d.c                |  3 ++-
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c   |  4 ++--
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 10 ++++++++++
 drivers/iio/gyro/bmg160_core.c                         | 12 ++++++++++++
 drivers/iio/industrialio-core.c                        |  7 +++----
 drivers/iio/pressure/st_pressure_core.c                |  1 +
 6 files changed, 30 insertions(+), 7 deletions(-)
