Return-Path: <matt.ranostay@intel.com>
From: Matt Ranostay <matt.ranostay@intel.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Matt Ranostay <matt.ranostay@intel.com>
Subject: [PATCH 2/3] iio: pressure: bmp280: add per chip initialize function pointer
Date: Mon, 11 Apr 2016 22:21:33 -0700
Message-Id: <1460438494-16135-3-git-send-email-matt.ranostay@intel.com>
In-Reply-To: <1460438494-16135-1-git-send-email-matt.ranostay@intel.com>
References: <1460438494-16135-1-git-send-email-matt.ranostay@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Some variants have functions that need to be enabled outside of an core
chip initialization.

Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
---
 drivers/iio/pressure/bmp280.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
index 2e7cff38f5ff..e80cbf3b21fc 100644
--- a/drivers/iio/pressure/bmp280.c
+++ b/drivers/iio/pressure/bmp280.c
@@ -88,6 +88,9 @@ enum { bmp280, bme280 };
 struct bmp280_chip_info {
 	int id;
 	int num_channels;
+
+	/* per chip initialization function */
+	int (*init)(struct bmp280_data *);
 };
 
 static struct bmp280_chip_info bmp280_chip_info_table[] = {
@@ -336,10 +339,18 @@ static const struct iio_info bmp280_info = {
 	.read_raw = &bmp280_read_raw,
 };
 
-static int bmp280_chip_init(struct bmp280_data *data)
+static int bmp280_common_init(struct bmp280_data *data)
 {
 	int ret;
 
+	if (data->chip->init) {
+		ret = data->chip->init(data);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "failed to run chip init");
+			return ret;
+		}
+	}
+
 	ret = regmap_update_bits(data->regmap, BMP280_REG_CTRL_MEAS,
 				 BMP280_OSRS_TEMP_MASK |
 				 BMP280_OSRS_PRESS_MASK |
@@ -429,7 +440,7 @@ static int bmp280_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	ret = bmp280_chip_init(data);
+	ret = bmp280_common_init(data);
 	if (ret < 0)
 		return ret;
 
-- 
1.9.1
