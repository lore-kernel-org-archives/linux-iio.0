Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35106 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965306AbdGTPYt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jul 2017 11:24:49 -0400
Received: by mail-pg0-f68.google.com with SMTP id d193so3034405pgc.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Jul 2017 08:24:49 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 01/11] iio: adc: ti-ads1015: fix incorrect data rate setting update
Date: Fri, 21 Jul 2017 00:24:17 +0900
Message-Id: <1500564267-8613-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
References: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ti-ads1015 driver has eight iio voltage channels and each iio channel
can hold own sampling frequency information.

The ADS1015 device only have a single config register which contains an
input multiplexer selection, PGA and data rate settings.  So the driver
should load the correct settings when the input multiplexer selection is
changed.

However, regardless of which channlel is currently selected, changing any
iio channel's sampling frequency information immediately overwrites the
current data rate setting in the config register.

It breaks the current data rate setting if the different channel's sampling
frequency information is changed because the data rate setting is not
reloaded when the input multiplexer is switched.

This removes the unexpected config register update and correctly load the
data rate setting before getting adc result.

Cc: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 884b8e46..443444c 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -252,9 +252,11 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
 
 	ret = regmap_update_bits_check(data->regmap, ADS1015_CFG_REG,
 				       ADS1015_CFG_MUX_MASK |
-				       ADS1015_CFG_PGA_MASK,
+				       ADS1015_CFG_PGA_MASK |
+				       ADS1015_CFG_DR_MASK,
 				       chan << ADS1015_CFG_MUX_SHIFT |
-				       pga << ADS1015_CFG_PGA_SHIFT,
+				       pga << ADS1015_CFG_PGA_SHIFT |
+				       dr << ADS1015_CFG_DR_SHIFT,
 				       &change);
 	if (ret < 0)
 		return ret;
@@ -325,25 +327,16 @@ static int ads1015_set_scale(struct ads1015_data *data, int chan,
 
 static int ads1015_set_data_rate(struct ads1015_data *data, int chan, int rate)
 {
-	int i, ret, rindex = -1;
+	int i;
 
-	for (i = 0; i < ARRAY_SIZE(ads1015_data_rate); i++)
+	for (i = 0; i < ARRAY_SIZE(ads1015_data_rate); i++) {
 		if (data->data_rate[i] == rate) {
-			rindex = i;
-			break;
+			data->channel_data[chan].data_rate = i;
+			return 0;
 		}
-	if (rindex < 0)
-		return -EINVAL;
-
-	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
-				 ADS1015_CFG_DR_MASK,
-				 rindex << ADS1015_CFG_DR_SHIFT);
-	if (ret < 0)
-		return ret;
-
-	data->channel_data[chan].data_rate = rindex;
+	}
 
-	return 0;
+	return -EINVAL;
 }
 
 static int ads1015_read_raw(struct iio_dev *indio_dev,
-- 
2.7.4

