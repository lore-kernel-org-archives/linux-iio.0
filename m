Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38894 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeKINEh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Nov 2018 08:04:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id p4-v6so272986plo.5
        for <linux-iio@vger.kernel.org>; Thu, 08 Nov 2018 19:25:59 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        freeman.liu@unisoc.com, broonie@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH] iio: adc: sc27xx: Add ADC data conversion timeout
Date: Fri,  9 Nov 2018 11:25:31 +0800
Message-Id: <208f9043fbd9b14b7a0c2743f68fa424388f5dcd.1541733478.git.baolin.wang@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Freeman Liu <freeman.liu@unisoc.com>

Sometimes the ADC controller met some problems, and it will not complete
the data conversion, that will can not wake up the read process any more
to block users. So we should add one maximum conversion time to avoid
this issue.

Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/iio/adc/sc27xx_adc.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 7940b23..f7f7a189 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -52,6 +52,9 @@
 /* Timeout (ms) for the trylock of hardware spinlocks */
 #define SC27XX_ADC_HWLOCK_TIMEOUT	5000
 
+/* Timeout (ms) for ADC data conversion according to ADC datasheet */
+#define SC27XX_ADC_RDY_TIMEOUT		100
+
 /* Maximum ADC channel number */
 #define SC27XX_ADC_CHANNEL_MAX		32
 
@@ -223,7 +226,14 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 	if (ret)
 		goto disable_adc;
 
-	wait_for_completion(&data->completion);
+	ret = wait_for_completion_timeout(&data->completion,
+				msecs_to_jiffies(SC27XX_ADC_RDY_TIMEOUT));
+	if (!ret) {
+		dev_err(data->dev, "read ADC data timeout\n");
+		ret = -ETIMEDOUT;
+	} else {
+		ret = 0;
+	}
 
 disable_adc:
 	regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
-- 
1.7.9.5
