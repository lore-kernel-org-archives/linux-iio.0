Return-Path: <leed.aguilar@ti.com>
From: Leed Aguilar <leed.aguilar@ti.com>
To: <linux-iio@vger.kernel.org>
CC: <leed.aguilar@ti.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>
Subject: [PATCH] iio:magnetometer:hmc5843: use kstrtoul instead of strict_strtoul
Date: Fri, 8 Jun 2012 18:14:45 -0400
Message-ID: <1339193685-24164-1-git-send-email-leed.aguilar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Change strict_strtoul() to kstrtoul() to make checkpatch.pl happy

Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/magnetometer/hmc5843.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 6dc0ad6..a993bc5 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -202,7 +202,7 @@ static ssize_t hmc5843_set_operating_mode(struct device *dev,
 	s32 status;
 	int error;
 	mutex_lock(&data->lock);
-	error = strict_strtoul(buf, 10, &operating_mode);
+	error = kstrtoul(buf, 10, &operating_mode);
 	if (error) {
 		count = error;
 		goto exit;
@@ -274,7 +274,7 @@ static ssize_t hmc5843_set_measurement_configuration(struct device *dev,
 	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
 	struct hmc5843_data *data = i2c_get_clientdata(client);
 	unsigned long meas_conf = 0;
-	int error = strict_strtoul(buf, 10, &meas_conf);
+	int error = kstrtoul(buf, 10, &meas_conf);
 	if (error)
 		return error;
 	mutex_lock(&data->lock);
@@ -423,7 +423,7 @@ static ssize_t set_range(struct device *dev,
 	unsigned long range = 0;
 	int error;
 	mutex_lock(&data->lock);
-	error = strict_strtoul(buf, 10, &range);
+	error = kstrtoul(buf, 10, &range);
 	if (error) {
 		count = error;
 		goto exit;
-- 
1.7.1
