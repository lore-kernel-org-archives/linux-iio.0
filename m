Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:55942 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966786AbcKLSTt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Nov 2016 13:19:49 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v4 11/26] staging: iio: tsl2583: change newlines to improve readability
Date: Sat, 12 Nov 2016 13:19:26 -0500
Message-Id: <1478974781-1457-12-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add and remove newlines to improve code readability in preparation for
moving the driver out of staging.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index be3cbae..8303753 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -202,7 +202,6 @@ static int tsl2583_get_lux(struct iio_dev *indio_dev)
 	ret = i2c_smbus_write_byte(chip->client,
 				   (TSL2583_CMD_REG | TSL2583_CMD_SPL_FN |
 				    TSL2583_CMD_ALS_INT_CLR));
-
 	if (ret < 0) {
 		dev_err(&chip->client->dev, "%s: failed to clear the interrupt bit\n",
 			__func__);
@@ -225,8 +224,10 @@ static int tsl2583_get_lux(struct iio_dev *indio_dev)
 		chip->als_cur_info.lux = 0;
 		goto done;
 	}
+
 	/* calculate ratio */
 	ratio = (ch1 << 15) / ch0;
+
 	/* convert to unscaled lux using the pointer to the table */
 	for (p = (struct tsl2583_lux *)tsl2583_device_lux;
 	     p->ratio != 0 && p->ratio < ratio; p++)
@@ -273,6 +274,7 @@ static int tsl2583_get_lux(struct iio_dev *indio_dev)
 	lux64 >>= 13;
 	lux = lux64;
 	lux = (lux + 500) / 1000;
+
 	if (lux > TSL2583_LUX_CALC_OVER_FLOW) { /* check for overflow */
 return_max:
 		lux = TSL2583_LUX_CALC_OVER_FLOW;
@@ -319,21 +321,23 @@ static int tsl2583_als_calibrate(struct iio_dev *indio_dev)
 			__func__);
 		return -ENODATA;
 	}
+
 	lux_val = tsl2583_get_lux(indio_dev);
 	if (lux_val < 0) {
 		dev_err(&chip->client->dev, "%s: failed to get lux\n",
 			__func__);
 		return lux_val;
 	}
+
 	gain_trim_val = (unsigned int)(((chip->als_settings.als_cal_target)
 			* chip->als_settings.als_gain_trim) / lux_val);
-
 	if ((gain_trim_val < 250) || (gain_trim_val > 4000)) {
 		dev_err(&chip->client->dev,
 			"%s: trim_val of %d is not within the range [250, 4000]\n",
 			__func__, gain_trim_val);
 		return -ENODATA;
 	}
+
 	chip->als_settings.als_gain_trim = (int)gain_trim_val;
 
 	return (int)gain_trim_val;
@@ -529,6 +533,7 @@ static ssize_t in_illuminance_lux_table_show(struct device *dev,
 	}
 
 	offset += sprintf(buf + offset, "\n");
+
 	return offset;
 }
 
@@ -776,6 +781,7 @@ static int tsl2583_probe(struct i2c_client *clientp,
 	indio_dev = devm_iio_device_alloc(&clientp->dev, sizeof(*chip));
 	if (!indio_dev)
 		return -ENOMEM;
+
 	chip = iio_priv(indio_dev);
 	chip->client = clientp;
 	i2c_set_clientdata(clientp, indio_dev);
@@ -803,6 +809,7 @@ static int tsl2583_probe(struct i2c_client *clientp,
 	indio_dev->dev.parent = &clientp->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = chip->client->name;
+
 	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 	if (ret) {
 		dev_err(&clientp->dev, "%s: iio registration failed\n",
@@ -819,6 +826,7 @@ static int tsl2583_probe(struct i2c_client *clientp,
 		return ret;
 
 	dev_info(&clientp->dev, "Light sensor found.\n");
+
 	return 0;
 }
 
@@ -834,6 +842,7 @@ static int __maybe_unused tsl2583_suspend(struct device *dev)
 	chip->suspended = true;
 
 	mutex_unlock(&chip->als_mutex);
+
 	return ret;
 }
 
@@ -848,6 +857,7 @@ static int __maybe_unused tsl2583_resume(struct device *dev)
 	ret = tsl2583_chip_init_and_power_on(indio_dev);
 
 	mutex_unlock(&chip->als_mutex);
+
 	return ret;
 }
 
-- 
2.7.4

