Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59092 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758608Ab3B0Uj5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:39:57 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 04/67] iio:hid_sensors move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:10 +0000
Message-Id: <1361997553-31058-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: srinivas pandruvada <srinivas.pandruvada@intel.com>

---
 drivers/iio/accel/hid-sensor-accel-3d.c       | 24 ++++++++++++------------
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 24 ++++++++++++------------
 drivers/iio/light/hid-sensor-als.c            |  8 ++++----
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 24 ++++++++++++------------
 4 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index dd8ea42..7be0482 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -60,28 +60,28 @@ static const struct iio_chan_spec accel_3d_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT |
-		IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT,
+		.info_mask_shared_by_type = IIO_CHAN_INFO_OFFSET |
+		IIO_CHAN_INFO_SCALE |
+		IIO_CHAN_INFO_SAMP_FREQ |
+		IIO_CHAN_INFO_HYSTERESIS,
 		.scan_index = CHANNEL_SCAN_INDEX_X,
 	}, {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT |
-		IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT,
+		.info_mask_shared_by_type = IIO_CHAN_INFO_OFFSET |
+		IIO_CHAN_INFO_SCALE |
+		IIO_CHAN_INFO_SAMP_FREQ |
+		IIO_CHAN_INFO_HYSTERESIS,
 		.scan_index = CHANNEL_SCAN_INDEX_Y,
 	}, {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT |
-		IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT,
+		.info_mask_shared_by_type = IIO_CHAN_INFO_OFFSET |
+		IIO_CHAN_INFO_SCALE |
+		IIO_CHAN_INFO_SAMP_FREQ |
+		IIO_CHAN_INFO_HYSTERESIS,
 		.scan_index = CHANNEL_SCAN_INDEX_Z,
 	}
 };
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index fcfc83a..3a324ae 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -60,28 +60,28 @@ static const struct iio_chan_spec gyro_3d_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT |
-		IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT,
+		.info_mask_shared_by_type = IIO_CHAN_INFO_OFFSET |
+		IIO_CHAN_INFO_SCALE |
+		IIO_CHAN_INFO_SAMP_FREQ |
+		IIO_CHAN_INFO_HYSTERESIS,
 		.scan_index = CHANNEL_SCAN_INDEX_X,
 	}, {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT |
-		IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT,
+		.info_mask_shared_by_type = IIO_CHAN_INFO_OFFSET |
+		IIO_CHAN_INFO_SCALE |
+		IIO_CHAN_INFO_SAMP_FREQ |
+		IIO_CHAN_INFO_HYSTERESIS,
 		.scan_index = CHANNEL_SCAN_INDEX_Y,
 	}, {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT |
-		IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT,
+		.info_mask_shared_by_type = IIO_CHAN_INFO_OFFSET |
+		IIO_CHAN_INFO_SCALE |
+		IIO_CHAN_INFO_SAMP_FREQ |
+		IIO_CHAN_INFO_HYSTERESIS,
 		.scan_index = CHANNEL_SCAN_INDEX_Z,
 	}
 };
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 3d7e8c9..482dcff 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -49,10 +49,10 @@ static const struct iio_chan_spec als_channels[] = {
 		.type = IIO_INTENSITY,
 		.modified = 1,
 		.channel2 = IIO_MOD_LIGHT_BOTH,
-		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT |
-		IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT,
+		.info_mask_shared_by_type = IIO_CHAN_INFO_OFFSET |
+		IIO_CHAN_INFO_SCALE |
+		IIO_CHAN_INFO_SAMP_FREQ |
+		IIO_CHAN_INFO_HYSTERESIS,
 		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
 	}
 };
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index d8d0126..950dab5 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -60,28 +60,28 @@ static const struct iio_chan_spec magn_3d_channels[] = {
 		.type = IIO_MAGN,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT |
-		IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT,
+		.info_mask_shared_by_type = IIO_CHAN_INFO_OFFSET |
+		IIO_CHAN_INFO_SCALE |
+		IIO_CHAN_INFO_SAMP_FREQ |
+		IIO_CHAN_INFO_HYSTERESIS,
 		.scan_index = CHANNEL_SCAN_INDEX_X,
 	}, {
 		.type = IIO_MAGN,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT |
-		IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT,
+		.info_mask_shared_by_type = IIO_CHAN_INFO_OFFSET |
+		IIO_CHAN_INFO_SCALE |
+		IIO_CHAN_INFO_SAMP_FREQ |
+		IIO_CHAN_INFO_HYSTERESIS,
 		.scan_index = CHANNEL_SCAN_INDEX_Y,
 	}, {
 		.type = IIO_MAGN,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT |
-		IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT,
+		.info_mask_shared_by_type = IIO_CHAN_INFO_OFFSET |
+		IIO_CHAN_INFO_SCALE |
+		IIO_CHAN_INFO_SAMP_FREQ |
+		IIO_CHAN_INFO_HYSTERESIS,
 		.scan_index = CHANNEL_SCAN_INDEX_Z,
 	}
 };
-- 
1.8.1.1

