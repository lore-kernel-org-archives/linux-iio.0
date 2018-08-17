Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39287 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbeHQWHp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Aug 2018 18:07:45 -0400
Received: by mail-pl0-f65.google.com with SMTP id w14-v6so4114311plp.6
        for <linux-iio@vger.kernel.org>; Fri, 17 Aug 2018 12:03:13 -0700 (PDT)
From: David Frey <dpfrey@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, himanshujha199640@gmail.com,
        David Frey <dpfrey@gmail.com>
Subject: [PATCH v3 7/7] iio: chemical: bme680: simplify oversampling handling
Date: Fri, 17 Aug 2018 12:03:19 -0700
Message-Id: <20180817190319.13119-8-dpfrey@gmail.com>
In-Reply-To: <20180817190319.13119-1-dpfrey@gmail.com>
References: <20180817190319.13119-1-dpfrey@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Temperature, pressure and humidity all expose and oversampling setting
that works in the same way.  Provide common handling for the
oversampling sysfs attributes.

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 99 ++++++++++++++------------------------
 1 file changed, 36 insertions(+), 63 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 46afc93041f5..30614ef043ca 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -91,8 +91,6 @@ static const struct iio_chan_spec bme680_channels[] = {
 	},
 };
 
-static const int bme680_oversampling_avail[] = { 1, 2, 4, 8, 16 };
-
 static int bme680_read_calib(struct bme680_data *data,
 			     struct bme680_calib *calib)
 {
@@ -503,12 +501,20 @@ static int bme680_set_mode(struct bme680_data *data, bool mode)
 	return ret;
 }
 
+static u8 bme680_oversampling_to_reg(u8 val)
+{
+	return ilog2(val) + 1;
+}
+
 static int bme680_chip_config(struct bme680_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
-	u8 osrs = FIELD_PREP(BME680_OSRS_HUMIDITY_MASK,
-			     data->oversampling_humid + 1);
+	u8 osrs;
+
+	osrs = FIELD_PREP(
+		BME680_OSRS_HUMIDITY_MASK,
+		bme680_oversampling_to_reg(data->oversampling_humid));
 	/*
 	 * Highly recommended to set oversampling of humidity before
 	 * temperature/pressure oversampling.
@@ -529,12 +535,12 @@ static int bme680_chip_config(struct bme680_data *data)
 		return ret;
 	}
 
-	osrs = FIELD_PREP(BME680_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
-	       FIELD_PREP(BME680_OSRS_PRESS_MASK, data->oversampling_press + 1);
-
+	osrs = FIELD_PREP(BME680_OSRS_TEMP_MASK,
+			  bme680_oversampling_to_reg(data->oversampling_temp)) |
+	       FIELD_PREP(BME680_OSRS_PRESS_MASK,
+			  bme680_oversampling_to_reg(data->oversampling_press));
 	ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
-				BME680_OSRS_TEMP_MASK |
-				BME680_OSRS_PRESS_MASK,
+				BME680_OSRS_TEMP_MASK | BME680_OSRS_PRESS_MASK,
 				osrs);
 	if (ret < 0)
 		dev_err(dev, "failed to write ctrl_meas register\n");
@@ -767,13 +773,13 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
 		case IIO_TEMP:
-			*val = 1 << data->oversampling_temp;
+			*val = data->oversampling_temp;
 			return IIO_VAL_INT;
 		case IIO_PRESSURE:
-			*val = 1 << data->oversampling_press;
+			*val = data->oversampling_press;
 			return IIO_VAL_INT;
 		case IIO_HUMIDITYRELATIVE:
-			*val = 1 << data->oversampling_humid;
+			*val = data->oversampling_humid;
 			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
@@ -783,52 +789,9 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static int bme680_write_oversampling_ratio_temp(struct bme680_data *data,
-						int val)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(bme680_oversampling_avail); i++) {
-		if (bme680_oversampling_avail[i] == val) {
-			data->oversampling_temp = ilog2(val);
-
-			return bme680_chip_config(data);
-		}
-	}
-
-	return -EINVAL;
-}
-
-static int bme680_write_oversampling_ratio_press(struct bme680_data *data,
-						 int val)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(bme680_oversampling_avail); i++) {
-		if (bme680_oversampling_avail[i] == val) {
-			data->oversampling_press = ilog2(val);
-
-			return bme680_chip_config(data);
-		}
-	}
-
-	return -EINVAL;
-}
-
-static int bme680_write_oversampling_ratio_humid(struct bme680_data *data,
-						 int val)
+static bool bme680_is_valid_oversampling(int rate)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(bme680_oversampling_avail); i++) {
-		if (bme680_oversampling_avail[i] == val) {
-			data->oversampling_humid = ilog2(val);
-
-			return bme680_chip_config(data);
-		}
-	}
-
-	return -EINVAL;
+	return (rate > 0 && rate <= 16 && is_power_of_2(rate));
 }
 
 static int bme680_write_raw(struct iio_dev *indio_dev,
@@ -842,16 +805,26 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+	{
+		if (!bme680_is_valid_oversampling(val))
+			return -EINVAL;
+
 		switch (chan->type) {
 		case IIO_TEMP:
-			return bme680_write_oversampling_ratio_temp(data, val);
+			data->oversampling_temp = val;
+			break;
 		case IIO_PRESSURE:
-			return bme680_write_oversampling_ratio_press(data, val);
+			data->oversampling_press = val;
+			break;
 		case IIO_HUMIDITYRELATIVE:
-			return bme680_write_oversampling_ratio_humid(data, val);
+			data->oversampling_humid = val;
+			break;
 		default:
 			return -EINVAL;
 		}
+
+		return bme680_chip_config(data);
+	}
 	default:
 		return -EINVAL;
 	}
@@ -913,9 +886,9 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* default values for the sensor */
-	data->oversampling_humid = ilog2(2); /* 2X oversampling rate */
-	data->oversampling_press = ilog2(4); /* 4X oversampling rate */
-	data->oversampling_temp = ilog2(8);  /* 8X oversampling rate */
+	data->oversampling_humid = 2; /* 2X oversampling rate */
+	data->oversampling_press = 4; /* 4X oversampling rate */
+	data->oversampling_temp = 8;  /* 8X oversampling rate */
 	data->heater_temp = 320; /* degree Celsius */
 	data->heater_dur = 150;  /* milliseconds */
 
-- 
2.11.0
