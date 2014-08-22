Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63374 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbaHVUsK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 22 Aug 2014 16:48:10 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 0/8] Fix iio_dev->trig assignment
Date: Fri, 22 Aug 2014 13:48:28 -0700
Message-Id: <1408740516-31261-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Instead or removing assignment, use iio_trigger_get to get
reference.
Also the iio_trigger_get returns struct iio_trigger pointer.

Srinivas Pandruvada (8):
  iio:trigger: modify return value for iio_trigger_get
  iio: accel: bma180: Fix indio_dev->trig assignment
  iio: adc: ad_sigma_delta: Fix indio_dev->trig assignment
  iio: hid_sensor_hub: Fix indio_dev->trig assignment
  iio: st_sensors: Fix indio_dev->trig assignment
  iio: gyro: itg3200: Fix indio_dev->trig assignment
  iio: inv_mpu6050: Fix indio_dev->trig assignment
  iio: meter: ade7758: Fix indio_dev->trig assignment

 drivers/iio/accel/bma180.c                          | 2 +-
 drivers/iio/adc/ad_sigma_delta.c                    | 2 +-
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 3 ++-
 drivers/iio/common/st_sensors/st_sensors_trigger.c  | 2 +-
 drivers/iio/gyro/itg3200_buffer.c                   | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c       | 2 +-
 drivers/staging/iio/meter/ade7758_trigger.c         | 2 +-
 include/linux/iio/trigger.h                         | 4 +++-
 8 files changed, 11 insertions(+), 8 deletions(-)

-- 
1.9.3

