Return-Path: <SRS0=O2KO=7B=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v3 03/11] iio: adc: ti-ads1015: enable conversion when CONFIG_PM is not set
Date: Mon, 31 Jul 2017 00:12:47 +0900
Message-Id: <1501427575-31045-4-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1501427575-31045-1-git-send-email-akinobu.mita@gmail.com>
References: <1501427575-31045-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

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
