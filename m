Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:42628 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754270AbdDFGiY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Apr 2017 02:38:24 -0400
From: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
To: jic23@kernel.org
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        linux-iio@vger.kernel.org,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH 3/6] iio: light: rpr0521 sample_frequency read/write added
Date: Thu,  6 Apr 2017 09:37:04 +0300
Message-Id: <1491460627-18685-3-git-send-email-mikko.koivunen@fi.rohmeurope.com>
In-Reply-To: <1491460627-18685-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
References: <1491460627-18685-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added sysfs read/write sample frequency.
Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.

Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
---
 drivers/iio/light/rpr0521.c | 97 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 30c2592..13e2f9a 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -132,6 +132,30 @@ struct rpr0521_reg_desc {
 	},
 };
 
+struct rpr0521_samp_freq {
+	int	als_hz;
+	int	als_uhz;
+	int	pxs_hz;
+	int	pxs_uhz;
+};
+
+static const struct rpr0521_samp_freq rpr0521_samp_freq_i[13] = {
+/*	{ALS, PXS} */
+	{0, 0, 0, 0},		/* 0000, 0=standby */
+	{0, 0, 100, 0},		/* 0001 */
+	{0, 0, 25, 0},		/* 0010 */
+	{0, 0, 10, 0},		/* 0011 */
+	{0, 0, 2, 500000},	/* 0100 */
+	{10, 0, 20, 0},		/* 0101 */
+	{10, 0, 10, 0},		/* 0110 */
+	{10, 0, 2, 500000},	/* 0111 */
+	{2, 500000, 20, 0},	/* 1000, measurement 100ms, sleep 300ms */
+	{2, 500000, 10, 0},	/* 1001, measurement 100ms, sleep 300ms */
+	{2, 500000, 0, 0},	/* 1010, high sensitivity mode */
+	{2, 500000, 2, 500000},	/* 1011, high sensitivity mode */
+	{20, 0, 20, 0}	/* 1100, ALS_data x 0.5, see specification P.18 */
+};
+
 struct rpr0521_data {
 	struct i2c_client *client;
 
@@ -152,9 +176,14 @@ struct rpr0521_data {
 static IIO_CONST_ATTR(in_intensity_scale_available, RPR0521_ALS_SCALE_AVAIL);
 static IIO_CONST_ATTR(in_proximity_scale_available, RPR0521_PXS_SCALE_AVAIL);
 
+/* Start with easy freq first, whole table of freq combinations is more */
+/* complicated. */
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("2.5 10");
+
 static struct attribute *rpr0521_attributes[] = {
 	&iio_const_attr_in_intensity_scale_available.dev_attr.attr,
 	&iio_const_attr_in_proximity_scale_available.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	NULL,
 };
 
@@ -170,6 +199,7 @@ struct rpr0521_data {
 		.channel2 = IIO_MOD_LIGHT_BOTH,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 	{
 		.type = IIO_INTENSITY,
@@ -178,12 +208,14 @@ struct rpr0521_data {
 		.channel2 = IIO_MOD_LIGHT_IR,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 	{
 		.type = IIO_PROXIMITY,
 		.address = RPR0521_CHAN_PXS,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	}
 };
 
@@ -319,6 +351,55 @@ static int rpr0521_set_gain(struct rpr0521_data *data, int chan,
 				  idx << rpr0521_gain[chan].shift);
 }
 
+static int rpr0521_read_samp_freq(struct rpr0521_data *data,
+				enum iio_chan_type chan_type,
+			    int *val, int *val2)
+{
+	int reg, ret;
+
+	ret = regmap_read(data->regmap, RPR0521_REG_MODE_CTRL, &reg);
+	if (ret < 0)
+		return ret;
+	reg &= RPR0521_MODE_MEAS_TIME_MASK;
+	if (reg >= ARRAY_SIZE(rpr0521_samp_freq_i))
+		return -EINVAL;
+
+	if (chan_type == IIO_INTENSITY) {
+		*val = rpr0521_samp_freq_i[reg].als_hz;
+		*val2 = rpr0521_samp_freq_i[reg].als_uhz;
+	} else if (chan_type == IIO_PROXIMITY) {
+		*val = rpr0521_samp_freq_i[reg].pxs_hz;
+		*val2 = rpr0521_samp_freq_i[reg].pxs_uhz;
+	} else {
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int rpr0521_write_samp_freq_common(struct rpr0521_data *data,
+				enum iio_chan_type chan_type,
+				int val, int val2)
+{
+	int i;
+
+	/* Ignore channel */
+	/* both pxs and als are setup only to same freq because of simplicity */
+	for (i = 0; i < ARRAY_SIZE(rpr0521_samp_freq_i); i++)
+		if ((val == rpr0521_samp_freq_i[i].als_hz)
+			&& (val2 == rpr0521_samp_freq_i[i].als_uhz)
+			&& (val == rpr0521_samp_freq_i[i].pxs_hz)
+			&& (val2 == rpr0521_samp_freq_i[i].pxs_uhz)) {
+			break;
+		}
+	if (i == ARRAY_SIZE(rpr0521_samp_freq_i))
+		return -EINVAL;
+
+	return regmap_update_bits(data->regmap,
+		RPR0521_REG_MODE_CTRL,
+		RPR0521_MODE_MEAS_TIME_MASK,
+		i);
+}
+
 static int rpr0521_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int *val,
 			    int *val2, long mask)
@@ -365,8 +446,16 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&data->lock);
 		if (ret < 0)
 			return ret;
+		return IIO_VAL_INT_PLUS_MICRO;
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		mutex_lock(&data->lock);
+		ret = rpr0521_read_samp_freq(data, chan->type, val, val2);
+		mutex_unlock(&data->lock);
+		if (ret < 0)
+			return ret;
 		return IIO_VAL_INT_PLUS_MICRO;
+
 	default:
 		return -EINVAL;
 	}
@@ -384,8 +473,16 @@ static int rpr0521_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&data->lock);
 		ret = rpr0521_set_gain(data, chan->address, val, val2);
 		mutex_unlock(&data->lock);
+		return ret;
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		mutex_lock(&data->lock);
+		ret = rpr0521_write_samp_freq_common(data,
+			chan->type,
+			val, val2);
+		mutex_unlock(&data->lock);
 		return ret;
+
 	default:
 		return -EINVAL;
 	}
-- 
1.9.1

