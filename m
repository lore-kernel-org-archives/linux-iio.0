Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38500 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965241AbdGTPYx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jul 2017 11:24:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id s4so3039336pgr.5
        for <linux-iio@vger.kernel.org>; Thu, 20 Jul 2017 08:24:53 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 03/11] iio: adc: ti-ads1015: enable conversion when CONFIG_PM is not set
Date: Fri, 21 Jul 2017 00:24:19 +0900
Message-Id: <1500564267-8613-4-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
References: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ADS1015 device have two operating modes, continuous conversion mode
and single-shot mode.  This driver assumes that the continuous conversion
mode is selected by runtime resume callback when the ADC result is
requested.

If CONFIG_PM is disabled, the device is always in the default single-shot
mode and no one begins a single conversion.  So the conversion register
doesn't contain valid ADC result.  Fix it by changing the continuous mode
in probe function.

Cc: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index f32d046..fcfa570 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -623,6 +623,13 @@ static int ads1015_probe(struct i2c_client *client,
 		dev_err(&client->dev, "iio triggered buffer setup failed\n");
 		return ret;
 	}
+
+	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
+				ADS1015_CFG_MOD_MASK,
+				ADS1015_CONTINUOUS << ADS1015_CFG_MOD_SHIFT);
+	if (ret)
+		return ret;
+
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret)
 		goto err_buffer_cleanup;
-- 
2.7.4

