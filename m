Return-Path: <SRS0=4kh6=6X=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 08/11] iio: adc: ti-ads1015: add helper to set conversion mode
Date: Fri, 21 Jul 2017 00:24:24 +0900
Message-Id: <1500564267-8613-9-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
References: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This adds a helper function to set conversion mode as there are a fair
number of users.

Cc: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index e83cebc..9f3f0c9 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -570,6 +570,13 @@ static void ads1015_get_channels_config(struct i2c_client *client)
 	}
 }
 
+static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
+{
+	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
+				  ADS1015_CFG_MOD_MASK,
+				  mode << ADS1015_CFG_MOD_SHIFT);
+}
+
 static int ads1015_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -628,9 +635,7 @@ static int ads1015_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
-				ADS1015_CFG_MOD_MASK,
-				ADS1015_CONTINUOUS << ADS1015_CFG_MOD_SHIFT);
+	ret = ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
 	if (ret)
 		return ret;
 
@@ -671,9 +676,7 @@ static int ads1015_remove(struct i2c_client *client)
 	iio_triggered_buffer_cleanup(indio_dev);
 
 	/* power down single shot mode */
-	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
-				  ADS1015_CFG_MOD_MASK,
-				  ADS1015_SINGLESHOT << ADS1015_CFG_MOD_SHIFT);
+	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
 }
 
 #ifdef CONFIG_PM
@@ -682,9 +685,7 @@ static int ads1015_runtime_suspend(struct device *dev)
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct ads1015_data *data = iio_priv(indio_dev);
 
-	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
-				  ADS1015_CFG_MOD_MASK,
-				  ADS1015_SINGLESHOT << ADS1015_CFG_MOD_SHIFT);
+	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
 }
 
 static int ads1015_runtime_resume(struct device *dev)
@@ -693,9 +694,7 @@ static int ads1015_runtime_resume(struct device *dev)
 	struct ads1015_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
-				  ADS1015_CFG_MOD_MASK,
-				  ADS1015_CONTINUOUS << ADS1015_CFG_MOD_SHIFT);
+	ret = ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
 	if (!ret)
 		data->conv_invalid = true;
 
-- 
2.7.4
