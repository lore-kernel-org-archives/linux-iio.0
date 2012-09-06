Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:60464 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232Ab2IFVUL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Sep 2012 17:20:11 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, srinivas.pandruvada@intel.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] staging:iio: hid-sensors Use iio_push_to_buffer
Date: Thu,  6 Sep 2012 22:20:03 +0100
Message-Id: <1346966403-14517-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Consistently use iio_push_to_buffer instead of manually calling the buffers
store_to callback.

These crossed with Lars-Peter's patch set doing every other case.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/accel/hid-sensor-accel-3d.c       | 2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 2 +-
 drivers/iio/light/hid-sensor-als.c            | 2 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 33aa97c..c593eb23 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -212,7 +212,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
 				datum_sz);
 		return;
 	}
-	buffer->access->store_to(buffer, (u8 *)data, timestamp);
+	iio_push_to_buffer(buffer, (u8 *)data, timestamp);
 }
 
 /* Callback handler to send event after all samples are received and captured */
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 50ec09b..94a4740 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -212,7 +212,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
 				datum_sz);
 		return;
 	}
-	buffer->access->store_to(buffer, (u8 *)data, timestamp);
+	iio_push_to_buffer(buffer, (u8 *)data, timestamp);
 }
 
 /* Callback handler to send event after all samples are received and captured */
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 2cff7d5..b3c8e91 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -191,7 +191,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
 				datum_sz);
 		return;
 	}
-	buffer->access->store_to(buffer, (u8 *)data, timestamp);
+	iio_push_to_buffer(buffer, (u8 *)data, timestamp);
 }
 
 /* Callback handler to send event after all samples are received and captured */
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 07591f4..397704e 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -213,7 +213,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
 				datum_sz);
 		return;
 	}
-	buffer->access->store_to(buffer, (u8 *)data, timestamp);
+	iio_push_to_buffer(buffer, (u8 *)data, timestamp);
 }
 
 /* Callback handler to send event after all samples are received and captured */
-- 
1.7.11.4

