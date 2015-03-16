Return-Path: <jacob.jun.pan@linux.intel.com>
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: IIO <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Aaron Lu <aaron.lu@intel.com>,
	Todd Brandt <todd.e.brandt@linux.intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] iio/axp288_adc: add missing channel info mask
Date: Mon, 16 Mar 2015 10:34:25 -0700
Message-Id: <1426527265-14979-1-git-send-email-jacob.jun.pan@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Commit 65de7654d39c70c2b ("iio: iio: Fix iio_channel_read return if
channel havn't info") added a check for valid info masks.

This patch adds missing channel info masks for all ADC channels.
Otherwise, iio_read_channel_raw() would return -EINVAL when called
by consumer drivers.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iio/adc/axp288_adc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index 08bcfb0..7ce361c 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -53,39 +53,45 @@ static const struct iio_chan_spec const axp288_adc_channels[] = {
 		.channel = 0,
 		.address = AXP288_TS_ADC_H,
 		.datasheet_name = "TS_PIN",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 	}, {
 		.indexed = 1,
 		.type = IIO_TEMP,
 		.channel = 1,
 		.address = AXP288_PMIC_ADC_H,
 		.datasheet_name = "PMIC_TEMP",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 	}, {
 		.indexed = 1,
 		.type = IIO_TEMP,
 		.channel = 2,
 		.address = AXP288_GP_ADC_H,
 		.datasheet_name = "GPADC",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 	}, {
 		.indexed = 1,
 		.type = IIO_CURRENT,
 		.channel = 3,
 		.address = AXP20X_BATT_CHRG_I_H,
 		.datasheet_name = "BATT_CHG_I",
-		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED)
+		| BIT(IIO_CHAN_INFO_RAW),
 	}, {
 		.indexed = 1,
 		.type = IIO_CURRENT,
 		.channel = 4,
 		.address = AXP20X_BATT_DISCHRG_I_H,
 		.datasheet_name = "BATT_DISCHRG_I",
-		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED)
+		| BIT(IIO_CHAN_INFO_RAW),
 	}, {
 		.indexed = 1,
 		.type = IIO_VOLTAGE,
 		.channel = 5,
 		.address = AXP20X_BATT_V_H,
 		.datasheet_name = "BATT_V",
-		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED)
+		| BIT(IIO_CHAN_INFO_RAW),
 	},
 };
 
@@ -140,20 +146,19 @@ static int axp288_adc_read_raw(struct iio_dev *indio_dev,
 	mutex_lock(&indio_dev->mlock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
 		if (axp288_adc_set_ts(info->regmap, AXP288_ADC_TS_PIN_GPADC,
 					chan->address)) {
 			dev_err(&indio_dev->dev, "GPADC mode\n");
 			ret = -EINVAL;
 			break;
 		}
+
 		ret = axp288_adc_read_channel(val, chan->address, info->regmap);
 		if (axp288_adc_set_ts(info->regmap, AXP288_ADC_TS_PIN_ON,
 						chan->address))
 			dev_err(&indio_dev->dev, "TS pin restore\n");
 		break;
-	case IIO_CHAN_INFO_PROCESSED:
-		ret = axp288_adc_read_channel(val, chan->address, info->regmap);
-		break;
 	default:
 		ret = -EINVAL;
 	}
-- 
1.9.1
