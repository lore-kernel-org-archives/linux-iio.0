Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.203]:47595 "EHLO
	mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753940Ab3GEIbO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2013 04:31:14 -0400
From: Hector Palacios <hector.palacios@digi.com>
To: <linux-iio@vger.kernel.org>
CC: <alexandre.belloni@free-electrons.com>, <lars@metafoo.de>,
	<jic23@kernel.org>, <marex@denx.de>, <fabio.estevam@freescale.com>,
	<hector.palacios@digi.com>
Subject: [PATCH 2/4] iio: mxs-lradc: add scale attribute to channels
Date: Fri, 5 Jul 2013 10:30:37 +0200
Message-ID: <1373013039-19461-3-git-send-email-hector.palacios@digi.com>
In-Reply-To: <1373013039-19461-1-git-send-email-hector.palacios@digi.com>
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some LRADC channels have a fixed pre-divider, and all can have enabled
an optional divisor by two which allows a maximum input voltage of
VDDIO - 50mV.

This patch
 - adds the scaling info flag to all channels
 - adds a lookup table with max reference voltage per channel
   (where the fixed pre-dividers apply)
 - allows to read the scaling attribute (computed from the Vref)

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
 drivers/staging/iio/adc/mxs-lradc.c | 122 +++++++++++++++++++++++++++---------
 1 file changed, 93 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index d65a594..012c42e 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -107,19 +107,63 @@ static const char * const mx28_lradc_irq_names[] = {
 	"mxs-lradc-button1",
 };
 
+/*
+ * Max reference voltage (mV) for each channel
+ */
+static const int mx23_vref_mv[LRADC_MAX_TOTAL_CHANS] = {
+	1850,		/* CH0 */
+	1850,		/* CH1 */
+	1850,		/* CH2 */
+	1850,		/* CH3 */
+	1850,		/* CH4 */
+	1850,		/* CH5 */
+	1850 * 2,	/* CH6 VDDIO */
+	1850 * 4,	/* CH7 VBATT */
+	1850,		/* CH8 Temp sense 0 */
+	1850,		/* CH9 Temp sense 1 */
+	1850,		/* CH10 */
+	1850,		/* CH11 */
+	1850,		/* CH12 USB_DP */
+	1850,		/* CH13 USB_DN */
+	1850,		/* CH14 VBG */
+	1850 * 4,	/* CH15 VDD5V */
+};
+
+static const int mx28_vref_mv[LRADC_MAX_TOTAL_CHANS] = {
+	1850,		/* CH0 */
+	1850,		/* CH1 */
+	1850,		/* CH2 */
+	1850,		/* CH3 */
+	1850,		/* CH4 */
+	1850,		/* CH5 */
+	1850,		/* CH6 */
+	1850 * 4,	/* CH7 VBATT */
+	1850,		/* CH8 Temp sense 0 */
+	1850,		/* CH9 Temp sense 1 */
+	1850 * 2,	/* CH10 VDDIO */
+	1850,		/* CH11 VTH */
+	1850 * 2,	/* CH12 VDDA */
+	1850,		/* CH13 VDDD */
+	1850,		/* CH14 VBG */
+	1850 * 4,	/* CH15 VDD5V */
+};
+
 struct mxs_lradc_of_config {
 	const int		irq_count;
 	const char * const	*irq_name;
+	const int 		*vref_mv;
 };
 
 static const struct mxs_lradc_of_config mxs_lradc_of_config[] = {
 	[IMX23_LRADC] = {
 		.irq_count	= ARRAY_SIZE(mx23_lradc_irq_names),
 		.irq_name	= mx23_lradc_irq_names,
+		.vref_mv	= mx23_vref_mv,
 	},
 	[IMX28_LRADC] = {
 		.irq_count	= ARRAY_SIZE(mx28_lradc_irq_names),
 		.irq_name	= mx28_lradc_irq_names,
+		.vref_mv	= mx28_vref_mv,
 	},
 };
 
@@ -141,6 +185,8 @@ struct mxs_lradc {
 
 	struct completion	completion;
 
+	const int		*vref_mv;
+
 	/*
 	 * Touchscreen LRADC channels receives a private slot in the CTRL4
 	 * register, the slot #7. Therefore only 7 slots instead of 8 in the
@@ -225,39 +271,12 @@ struct mxs_lradc {
 #define	LRADC_CTRL4_LRADCSELECT_MASK(n)		(0xf << ((n) * 4))
 #define	LRADC_CTRL4_LRADCSELECT_OFFSET(n)	((n) * 4)
 
-/*
- * Raw I/O operations
- */
-static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
+static int mxs_lradc_read_single(struct iio_dev *iio_dev,
 			const struct iio_chan_spec *chan,
 			int *val, int *val2, long m)
 {
 	struct mxs_lradc *lradc = iio_priv(iio_dev);
 	int ret;
-	unsigned long mask;
-
-	if (m != IIO_CHAN_INFO_RAW)
-		return -EINVAL;
-
-	/* Check for invalid channel */
-	if (chan->channel > LRADC_MAX_TOTAL_CHANS)
-		return -EINVAL;
-
-	/* Validate the channel if it doesn't intersect with reserved chans. */
-	bitmap_set(&mask, chan->channel, 1);
-	ret = iio_validate_scan_mask_onehot(iio_dev, &mask);
-	if (ret)
-		return -EINVAL;
-
-	/*
-	 * See if there is no buffered operation in progess. If there is, simply
-	 * bail out. This can be improved to support both buffered and raw IO at
-	 * the same time, yet the code becomes horribly complicated. Therefore I
-	 * applied KISS principle here.
-	 */
-	ret = mutex_trylock(&lradc->lock);
-	if (!ret)
-		return -EBUSY;
 
 	INIT_COMPLETION(lradc->completion);
 
@@ -297,6 +316,47 @@ err:
 	writel(LRADC_CTRL1_LRADC_IRQ_EN(0),
 		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
 
+	return ret;
+}
+
+/*
+ * Raw I/O operations
+ */
+static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
+			const struct iio_chan_spec *chan,
+			int *val, int *val2, long m)
+{
+	struct mxs_lradc *lradc = iio_priv(iio_dev);
+	int ret;
+
+	/*
+	 * See if there is no buffered operation in progress. If there is, simply
+	 * bail out. This can be improved to support both buffered and raw IO at
+	 * the same time, yet the code becomes horribly complicated. Therefore I
+	 * applied KISS principle here.
+	 */
+	ret = mutex_trylock(&lradc->lock);
+	if (!ret)
+		return -EBUSY;
+
+	/* Check for invalid channel */
+	if (chan->channel > LRADC_MAX_TOTAL_CHANS)
+		ret = -EINVAL;
+
+	switch(m) {
+	case IIO_CHAN_INFO_RAW:
+		ret = mxs_lradc_read_single(iio_dev, chan, val, val2, m);
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val = lradc->vref_mv[chan->channel];
+		*val2 = chan->scan_type.realbits;
+		ret = IIO_VAL_FRACTIONAL_LOG2;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
 	mutex_unlock(&lradc->lock);
 
 	return ret;
@@ -818,7 +878,8 @@ static const struct iio_buffer_setup_ops mxs_lradc_buffer_ops = {
 	.type = (chan_type),					\
 	.indexed = 1,						\
 	.scan_index = (idx),					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
 	.channel = (idx),					\
 	.scan_type = {						\
 		.sign = 'u',					\
@@ -957,6 +1018,9 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 			goto err_addr;
 	}
 
+	/* Set pointer to Vref array */
+	lradc->vref_mv = of_cfg->vref_mv;
+
 	platform_set_drvdata(pdev, iio);
 
 	init_completion(&lradc->completion);
