Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.208]:44185 "EHLO
	mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753947Ab3GEIbO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2013 04:31:14 -0400
From: Hector Palacios <hector.palacios@digi.com>
To: <linux-iio@vger.kernel.org>
CC: <alexandre.belloni@free-electrons.com>, <lars@metafoo.de>,
	<jic23@kernel.org>, <marex@denx.de>, <fabio.estevam@freescale.com>,
	<hector.palacios@digi.com>
Subject: [PATCH 4/4] iio: mxs-lradc: add write_raw function to modify scale
Date: Fri, 5 Jul 2013 10:30:39 +0200
Message-ID: <1373013039-19461-5-git-send-email-hector.palacios@digi.com>
In-Reply-To: <1373013039-19461-1-git-send-email-hector.palacios@digi.com>
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added write_raw function to manipulate the optional divider_by_two
through the scaling attribute out of the available scales.

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
 drivers/staging/iio/adc/mxs-lradc.c | 55 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 7f98c99..acd05d6 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -188,6 +188,7 @@ struct mxs_lradc {
 
 	const int		*vref_mv;
 	unsigned int		scale_avail[LRADC_MAX_TOTAL_CHANS][2][2];
+	bool			is_divided[LRADC_MAX_TOTAL_CHANS];
 
 	/*
 	 * Touchscreen LRADC channels receives a private slot in the CTRL4
@@ -246,6 +247,7 @@ struct mxs_lradc {
 #define	LRADC_CTRL1_LRADC_IRQ_OFFSET		0
 
 #define	LRADC_CTRL2				0x20
+#define LRADC_CTRL2_DIVIDE_BY_TWO_OFFSET	24
 #define	LRADC_CTRL2_TEMPSENSE_PWD		(1 << 15)
 
 #define	LRADC_STATUS				0x40
@@ -351,7 +353,8 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
 		break;
 	case IIO_CHAN_INFO_SCALE:
 		*val = lradc->vref_mv[chan->channel];
-		*val2 = chan->scan_type.realbits;
+		*val2 = chan->scan_type.realbits -
+			lradc->is_divided[chan->channel];
 		ret = IIO_VAL_FRACTIONAL_LOG2;
 		break;
 	default:
@@ -364,6 +367,54 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
 	return ret;
 }
 
+static int mxs_lradc_write_raw(struct iio_dev *iio_dev,
+			       const struct iio_chan_spec *chan,
+			       int val, int val2, long m)
+{
+	struct mxs_lradc *lradc = iio_priv(iio_dev);
+	int ret;
+
+	ret = mutex_trylock(&lradc->lock);
+	if (!ret)
+		return -EBUSY;
+
+	switch(m) {
+	case IIO_CHAN_INFO_SCALE:
+		ret = -EINVAL;
+		if (val == lradc->scale_avail[chan->channel][0][0] &&
+		    val2 == lradc->scale_avail[chan->channel][0][1]) {
+			/* [0] -> divider by two disabled */
+			writel(1 << LRADC_CTRL2_DIVIDE_BY_TWO_OFFSET,
+			       lradc->base + LRADC_CTRL2 + STMP_OFFSET_REG_CLR);
+			lradc->is_divided[chan->channel] = 0;
+			ret = 0;
+		} else if (val == lradc->scale_avail[chan->channel][1][0] &&
+			   val2 == lradc->scale_avail[chan->channel][1][1]) {
+			/* [1] -> divider by two enabled */
+			writel(1 << LRADC_CTRL2_DIVIDE_BY_TWO_OFFSET,
+			       lradc->base + LRADC_CTRL2 + STMP_OFFSET_REG_SET);
+			lradc->is_divided[chan->channel] = 1;
+			ret = 0;
+		}
+
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&lradc->lock);
+
+	return ret;
+}
+
+static int mxs_lradc_write_raw_get_fmt(struct iio_dev *iio_dev,
+				       const struct iio_chan_spec *chan,
+				       long m)
+{
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
 static ssize_t mxs_lradc_show_scale_available_ch(struct device *dev,
 		struct device_attribute *attr,
 		char *buf,
@@ -456,6 +507,8 @@ static const struct attribute_group mxs_lradc_attribute_group = {
 static const struct iio_info mxs_lradc_iio_info = {
 	.driver_module		= THIS_MODULE,
 	.read_raw		= mxs_lradc_read_raw,
+	.write_raw		= mxs_lradc_write_raw,
+	.write_raw_get_fmt 	= &mxs_lradc_write_raw_get_fmt,
 	.attrs			= &mxs_lradc_attribute_group,
 };
 
