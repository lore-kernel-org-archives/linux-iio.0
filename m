Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33110 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965241AbdGTPY4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jul 2017 11:24:56 -0400
Received: by mail-pf0-f194.google.com with SMTP id e199so2670598pfh.0
        for <linux-iio@vger.kernel.org>; Thu, 20 Jul 2017 08:24:56 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 04/11] iio: adc: ti-ads1015: avoid getting stale result after runtime resume
Date: Fri, 21 Jul 2017 00:24:20 +0900
Message-Id: <1500564267-8613-5-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
References: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This driver assumes that the device is operating in the continuous
conversion mode which performs the conversion continuously.  So this driver
doesn't insert a wait time before reading the conversion register if the
configuration is not changed from a previous request.

This assumption is broken if the device is runtime suspended and entered
a power-down state.  The forthcoming request causes reading a stale result
from the conversion register as the device is runtime resumed just before.

Fix it by adding a flag to detect that condition and insert a necessary
wait time.

Cc: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index fcfa570..8905f0d 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -177,6 +177,12 @@ struct ads1015_data {
 	struct ads1015_channel_data channel_data[ADS1015_CHANNELS];
 
 	unsigned int *data_rate;
+	/*
+	 * Set to true when the ADC is switched to the continuous-conversion
+	 * mode and exits from a power-down state.  This flag is used to avoid
+	 * getting the stale result from the conversion register.
+	 */
+	bool conv_invalid;
 };
 
 static bool ads1015_is_writeable_reg(struct device *dev, unsigned int reg)
@@ -255,9 +261,10 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
 	if (ret < 0)
 		return ret;
 
-	if (change) {
+	if (change || data->conv_invalid) {
 		conv_time = DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
 		usleep_range(conv_time, conv_time + 1);
+		data->conv_invalid = false;
 	}
 
 	return regmap_read(data->regmap, ADS1015_CONV_REG, val);
@@ -630,6 +637,8 @@ static int ads1015_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	data->conv_invalid = true;
+
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret)
 		goto err_buffer_cleanup;
@@ -685,10 +694,15 @@ static int ads1015_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct ads1015_data *data = iio_priv(indio_dev);
+	int ret;
 
-	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
+	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
 				  ADS1015_CFG_MOD_MASK,
 				  ADS1015_CONTINUOUS << ADS1015_CFG_MOD_SHIFT);
+	if (!ret)
+		data->conv_invalid = true;
+
+	return ret;
 }
 #endif
 
-- 
2.7.4

