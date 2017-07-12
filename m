Return-Path: <SRS0=pUtU=6P=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4/8] iio: adc: ti-ads1015: enable conversion when CONFIG_PM is not set
Date: Thu, 13 Jul 2017 01:32:00 +0900
Message-Id: <1499877124-21658-5-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1499877124-21658-1-git-send-email-akinobu.mita@gmail.com>
References: <1499877124-21658-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The ADS1015 device have two operating modes, continuous conversion mode
and single-shot mode.  This driver assumes that the continuous conversion
mode is selected by runtime resume callback when the ADC result is
requested.

If CONFIG_PM is disabled, the device is always in the default single-shot
mode and no one begins a single conversion.  So the conversion register
doesn't contain valid ADC result.  Fix it by changing the continuous mode
in probe function.  This also adds a helper function to set conversion
mode as there are a fair number of users.

Cc: Daniel Baluta <daniel.baluta@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 1edf323..984d4bb 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -556,6 +556,13 @@ static void ads1015_get_channels_config(struct i2c_client *client)
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
@@ -613,6 +620,11 @@ static int ads1015_probe(struct i2c_client *client,
 		dev_err(&client->dev, "iio triggered buffer setup failed\n");
 		return ret;
 	}
+
+	ret = ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
+	if (ret)
+		return ret;
+
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret)
 		goto err_buffer_cleanup;
@@ -648,9 +660,7 @@ static int ads1015_remove(struct i2c_client *client)
 	iio_triggered_buffer_cleanup(indio_dev);
 
 	/* power down single shot mode */
-	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
-				  ADS1015_CFG_MOD_MASK,
-				  ADS1015_SINGLESHOT << ADS1015_CFG_MOD_SHIFT);
+	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
 }
 
 #ifdef CONFIG_PM
@@ -659,9 +669,7 @@ static int ads1015_runtime_suspend(struct device *dev)
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct ads1015_data *data = iio_priv(indio_dev);
 
-	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
-				  ADS1015_CFG_MOD_MASK,
-				  ADS1015_SINGLESHOT << ADS1015_CFG_MOD_SHIFT);
+	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
 }
 
 static int ads1015_runtime_resume(struct device *dev)
@@ -669,9 +677,7 @@ static int ads1015_runtime_resume(struct device *dev)
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct ads1015_data *data = iio_priv(indio_dev);
 
-	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
-				  ADS1015_CFG_MOD_MASK,
-				  ADS1015_CONTINUOUS << ADS1015_CFG_MOD_SHIFT);
+	return ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
 }
 #endif
 
-- 
2.7.4
