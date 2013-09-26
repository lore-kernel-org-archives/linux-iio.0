Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 16/18] staging:iio:ad799x: Simplify threshold register look-up
Date: Thu, 26 Sep 2013 14:58:35 +0200
Message-Id: <1380200317-19355-16-git-send-email-lars@metafoo.de>
In-Reply-To: <1380200317-19355-1-git-send-email-lars@metafoo.de>
References: <1380200317-19355-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Given a channel number the corresponding threshold and hysteresis registers can
easily be calculated. No need to use a look-up table.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad799x.h      | 16 ++++------------
 drivers/staging/iio/adc/ad799x_core.c | 34 ++++++++++++++--------------------
 2 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index b51680c..a591aa6 100644
--- a/drivers/staging/iio/adc/ad799x.h
+++ b/drivers/staging/iio/adc/ad799x.h
@@ -36,18 +36,10 @@
 #define AD7998_ALERT_STAT_REG			0x1
 #define AD7998_CONF_REG				0x2
 #define AD7998_CYCLE_TMR_REG			0x3
-#define AD7998_DATALOW_CH1_REG			0x4
-#define AD7998_DATAHIGH_CH1_REG			0x5
-#define AD7998_HYST_CH1_REG			0x6
-#define AD7998_DATALOW_CH2_REG			0x7
-#define AD7998_DATAHIGH_CH2_REG			0x8
-#define AD7998_HYST_CH2_REG			0x9
-#define AD7998_DATALOW_CH3_REG			0xA
-#define AD7998_DATAHIGH_CH3_REG			0xB
-#define AD7998_HYST_CH3_REG			0xC
-#define AD7998_DATALOW_CH4_REG			0xD
-#define AD7998_DATAHIGH_CH4_REG			0xE
-#define AD7998_HYST_CH4_REG			0xF
+
+#define AD7998_DATALOW_REG(x)			((x) * 3 + 0x4)
+#define AD7998_DATAHIGH_REG(x)			((x) * 3 + 0x5)
+#define AD7998_HYST_REG(x)			((x) * 3 + 0x6)
 
 #define AD7998_CYC_MASK				0x7
 #define AD7998_CYC_DIS				0x0
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 73f7604..24e0749 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -261,12 +261,14 @@ static int ad799x_read_event_config(struct iio_dev *indio_dev,
 	return 1;
 }
 
-static const u8 ad799x_threshold_addresses[][2] = {
-	{ AD7998_DATALOW_CH1_REG, AD7998_DATAHIGH_CH1_REG },
-	{ AD7998_DATALOW_CH2_REG, AD7998_DATAHIGH_CH2_REG },
-	{ AD7998_DATALOW_CH3_REG, AD7998_DATAHIGH_CH3_REG },
-	{ AD7998_DATALOW_CH4_REG, AD7998_DATAHIGH_CH4_REG },
-};
+static int ad799x_threshold_reg(const struct iio_chan_spec *chan,
+					enum iio_event_direction dir)
+{
+	if (dir == IIO_EV_DIR_FALLING)
+		return AD7998_DATALOW_REG(chan->channel);
+	else
+		return AD7998_DATAHIGH_REG(chan->channel);
+}
 
 static int ad799x_write_event_value(struct iio_dev *indio_dev,
 				    const struct iio_chan_spec *chan,
@@ -277,13 +279,9 @@ static int ad799x_write_event_value(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct ad799x_state *st = iio_priv(indio_dev);
-	int direction = dir == IIO_EV_DIR_FALLING;
-	int number = chan->channel;
 
 	mutex_lock(&indio_dev->mlock);
-	ret = ad799x_i2c_write16(st,
-				 ad799x_threshold_addresses[number][direction],
-				 val);
+	ret = ad799x_i2c_write16(st, ad799x_threshold_reg(chan, dir), val);
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret;
@@ -298,14 +296,10 @@ static int ad799x_read_event_value(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct ad799x_state *st = iio_priv(indio_dev);
-	int direction = dir == IIO_EV_DIR_FALLING;
-	int number = chan->channel;
 	u16 valin;
 
 	mutex_lock(&indio_dev->mlock);
-	ret = ad799x_i2c_read16(st,
-				ad799x_threshold_addresses[number][direction],
-				&valin);
+	ret = ad799x_i2c_read16(st, ad799x_threshold_reg(chan, dir), &valin);
 	mutex_unlock(&indio_dev->mlock);
 	if (ret < 0)
 		return ret;
@@ -393,25 +387,25 @@ static IIO_DEVICE_ATTR(in_voltage0_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
-		       AD7998_HYST_CH1_REG);
+		       AD7998_HYST_REG(0));
 
 static IIO_DEVICE_ATTR(in_voltage1_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
-		       AD7998_HYST_CH2_REG);
+		       AD7998_HYST_REG(1));
 
 static IIO_DEVICE_ATTR(in_voltage2_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
-		       AD7998_HYST_CH3_REG);
+		       AD7998_HYST_REG(2));
 
 static IIO_DEVICE_ATTR(in_voltage3_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
-		       AD7998_HYST_CH4_REG);
+		       AD7998_HYST_REG(3));
 
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 			      ad799x_read_frequency,
-- 
1.8.0
