Return-Path: <SRS0=O2KO=7B=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v3 06/11] iio: adc: ti-ads1015: add adequate wait time to get correct conversion
Date: Mon, 31 Jul 2017 00:12:50 +0900
Message-Id: <1501427575-31045-7-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1501427575-31045-1-git-send-email-akinobu.mita@gmail.com>
References: <1501427575-31045-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This driver assumes that the device is operating in the continuous
conversion mode which performs the conversion continuously.  So this driver
inserts a wait time before reading the conversion register if the
configuration is changed from a previous request.

Currently, the wait time is only the period required for a single
conversion that is calculated as the reciprocal of the sampling frequency.
However we also need to wait for the the previous conversion to complete.
Otherwise we probably get the conversion result for the previous
configuration when the sampling frequency is lower.

Cc: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 1c475e2..9c501e5 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -242,27 +242,34 @@ static
 int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
 {
 	int ret, pga, dr, conv_time;
-	bool change;
+	unsigned int old, mask, cfg;
 
 	if (chan < 0 || chan >= ADS1015_CHANNELS)
 		return -EINVAL;
 
+	ret = regmap_read(data->regmap, ADS1015_CFG_REG, &old);
+	if (ret)
+		return ret;
+
 	pga = data->channel_data[chan].pga;
 	dr = data->channel_data[chan].data_rate;
+	mask = ADS1015_CFG_MUX_MASK | ADS1015_CFG_PGA_MASK |
+		ADS1015_CFG_DR_MASK;
+	cfg = chan << ADS1015_CFG_MUX_SHIFT | pga << ADS1015_CFG_PGA_SHIFT |
+		dr << ADS1015_CFG_DR_SHIFT;
 
-	ret = regmap_update_bits_check(data->regmap, ADS1015_CFG_REG,
-				       ADS1015_CFG_MUX_MASK |
-				       ADS1015_CFG_PGA_MASK |
-				       ADS1015_CFG_DR_MASK,
-				       chan << ADS1015_CFG_MUX_SHIFT |
-				       pga << ADS1015_CFG_PGA_SHIFT |
-				       dr << ADS1015_CFG_DR_SHIFT,
-				       &change);
-	if (ret < 0)
+	cfg = (old & ~mask) | (cfg & mask);
+
+	ret = regmap_write(data->regmap, ADS1015_CFG_REG, cfg);
+	if (ret)
 		return ret;
 
-	if (change || data->conv_invalid) {
-		conv_time = DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
+	if (old != cfg || data->conv_invalid) {
+		int dr_old = (old & ADS1015_CFG_DR_MASK) >>
+				ADS1015_CFG_DR_SHIFT;
+
+		conv_time = DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr_old]);
+		conv_time += DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
 		usleep_range(conv_time, conv_time + 1);
 		data->conv_invalid = false;
 	}
-- 
2.7.4
