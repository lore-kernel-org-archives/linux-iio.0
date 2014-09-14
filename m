Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56813 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbaINUkx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Sep 2014 16:40:53 -0400
Message-ID: <5415FD4F.9000606@kernel.org>
Date: Sun, 14 Sep 2014 21:40:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] First set of IIO fixes for the 3.17 cycle
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit eb29835fb3ae9f7a8c8a4ae92e192052c3473557:

  staging: android: fix a possible memory leak (2014-08-17 07:15:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-3.17a

for you to fetch changes up to a31d0928999fbf33b3a6042e8bcb7b7f7e07d094:

  iio:magnetometer: bugfix magnetometers gain values (2014-09-14 18:21:23 +0100)

----------------------------------------------------------------
First round of IIO fixes for the 3.17 cycle.

* Fix an overwritten error return that can prevent deferred probing when
  using of_iio_channel_get_by_name
* A series that deals with an incorrect reference count when the default
  trigger is set within the main probe routine for a driver.  Can result
  in a double free if the trigger is changed.
* Fix a buglet with xilinx-xadc concerning setup of the address for an
  aux channel.
* At91 adc driver could sometimes get a touchscreen reading rather than
  the intended adc channel.  This is fixed by using the channel data register
  instead.
* Fix some ST magnetometer gain values that differ in production parts from
  the prerelease ones used for driver development.

----------------------------------------------------------------
Denis CIOCCA (1):
      iio:magnetometer: bugfix magnetometers gain values

Johannes Pointner (1):
      iio:inkern: fix overwritten -EPROBE_DEFER in of_iio_channel_get_by_name

Ludovic Desroches (1):
      iio: adc: at91: don't use the last converted data register

Srinivas Pandruvada (8):
      iio:trigger: modify return value for iio_trigger_get
      iio: accel: bma180: Fix indio_dev->trig assignment
      iio: adc: ad_sigma_delta: Fix indio_dev->trig assignment
      iio: hid_sensor_hub: Fix indio_dev->trig assignment
      iio: st_sensors: Fix indio_dev->trig assignment
      iio: gyro: itg3200: Fix indio_dev->trig assignment
      iio: inv_mpu6050: Fix indio_dev->trig assignment
      iio: meter: ade7758: Fix indio_dev->trig assignment

Subbaraya Sundeep Bhatta (1):
      iio: adc: xilinx-xadc: assign auxiliary channels address correctly

 drivers/iio/accel/bma180.c                         |  2 +-
 drivers/iio/adc/ad_sigma_delta.c                   |  2 +-
 drivers/iio/adc/at91_adc.c                         | 12 ++---
 drivers/iio/adc/xilinx-xadc-core.c                 |  2 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  3 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |  2 +-
 drivers/iio/gyro/itg3200_buffer.c                  |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |  2 +-
 drivers/iio/inkern.c                               |  2 +-
 drivers/iio/magnetometer/st_magn_core.c            | 52 +++++++++++++---------
 drivers/staging/iio/meter/ade7758_trigger.c        |  2 +-
 include/linux/iio/trigger.h                        |  4 +-
 12 files changed, 50 insertions(+), 37 deletions(-)
