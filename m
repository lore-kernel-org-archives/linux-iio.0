Return-Path: <SRS0=wbiz=B2=pmeerw.net=pmeerw@kernel.org>
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH 08/13] iio: health: max30102: Add power enable parameter to get_temp function
Date: Fri, 27 Oct 2017 21:29:48 +0200
Message-Id: <1509132593-1815-14-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
References: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Chip must not be in shutdown for reading temperature, so briefly leave
shutdown if buffer is not already running

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/iio/health/max30102.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 968b54b..520d905 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -321,20 +321,31 @@ static int max30102_read_temp(struct max30102_data *data, int *val)
 	return 0;
 }
 
-static int max30102_get_temp(struct max30102_data *data, int *val)
+static int max30102_get_temp(struct max30102_data *data, int *val, bool en)
 {
 	int ret;
 
+	if (en) {
+		ret = max30102_set_powermode(data, true);
+		if (ret)
+			return ret;
+	}
+
 	/* start acquisition */
 	ret = regmap_update_bits(data->regmap, MAX30102_REG_TEMP_CONFIG,
 				 MAX30102_REG_TEMP_CONFIG_TEMP_EN,
 				 MAX30102_REG_TEMP_CONFIG_TEMP_EN);
 	if (ret)
-		return ret;
+		goto out;
 
 	msleep(35);
+	ret = max30102_read_temp(data, val);
+
+out:
+	if (en)
+		max30102_set_powermode(data, false);
 
-	return max30102_read_temp(data, val);
+	return ret;
 }
 
 static int max30102_read_raw(struct iio_dev *indio_dev,
@@ -347,20 +358,19 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		/*
-		 * Temperature reading can only be acquired while engine
-		 * is running
+		 * Temperature reading can only be acquired when not in
+		 * shutdown; leave shutdown briefly when buffer not running
 		 */
 		mutex_lock(&indio_dev->mlock);
-
 		if (!iio_buffer_enabled(indio_dev))
-			ret = -EBUSY;
-		else {
-			ret = max30102_get_temp(data, val);
-			if (!ret)
-				ret = IIO_VAL_INT;
-		}
-
+			ret = max30102_get_temp(data, val, true);
+		else
+			ret = max30102_get_temp(data, val, false);
 		mutex_unlock(&indio_dev->mlock);
+		if (ret)
+			return ret;
+
+		ret = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1000;  /* 62.5 */
-- 
2.7.4
