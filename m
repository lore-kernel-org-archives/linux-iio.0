Return-Path: <SRS0=Fitd=72=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: adc: ti-ads1015: fix comparator polarity setting
Date: Thu, 24 Aug 2017 09:22:57 +0900
Message-Id: <1503534177-3840-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The comparator polarity field in config register is not correctly
initialized as per the interrupt trigger setting.  Because the bitfield
definision is wrong and bit shifting is missed.

Fixes: d9f39babd8ba ("iio: adc: ti-ads1015: add threshold event support")
Cc: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 36078bfc..1dad9f0 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -52,7 +52,7 @@
 
 #define ADS1015_CFG_COMP_QUE_MASK	GENMASK(1, 0)
 #define ADS1015_CFG_COMP_LAT_MASK	BIT(2)
-#define ADS1015_CFG_COMP_POL_MASK	BIT(2)
+#define ADS1015_CFG_COMP_POL_MASK	BIT(3)
 #define ADS1015_CFG_COMP_MODE_MASK	BIT(4)
 #define ADS1015_CFG_DR_MASK	GENMASK(7, 5)
 #define ADS1015_CFG_MOD_MASK	BIT(8)
@@ -1017,10 +1017,12 @@ static int ads1015_probe(struct i2c_client *client,
 
 		switch (irq_trig) {
 		case IRQF_TRIGGER_LOW:
-			cfg_comp |= ADS1015_CFG_COMP_POL_LOW;
+			cfg_comp |= ADS1015_CFG_COMP_POL_LOW <<
+					ADS1015_CFG_COMP_POL_SHIFT;
 			break;
 		case IRQF_TRIGGER_HIGH:
-			cfg_comp |= ADS1015_CFG_COMP_POL_HIGH;
+			cfg_comp |= ADS1015_CFG_COMP_POL_HIGH <<
+					ADS1015_CFG_COMP_POL_SHIFT;
 			break;
 		default:
 			return -EINVAL;
-- 
2.7.4
