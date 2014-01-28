Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.cosmopool.net ([178.63.74.76]:34567 "EHLO
	mail.cosmopool.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbaA1N6q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jan 2014 08:58:46 -0500
From: Harald Geyer <harald@ccbib.org>
To: linux-iio@vger.kernel.org
cc: Marek Vasut <marex@denx.de>
Subject: [RFC] iio: mxs-lradc: Add support for current source
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 28 Jan 2014 14:52:30 +0100
Message-Id: <E1W895a-0000yo-Tm@stardust.g4.wien.funkfeuer.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We pretend the current source to be an independent 4-bit DAC,
which seems to be a valid use of the device. The channel also
allows reading back the value previously written.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
The LRADC can drive two of its ADC channels with a defined current
between 0 and 300uA to allow reading thermistors without external
current source. I'm not sure what the right IIO ABI in this case
should be. The way it is done now has the advantage that no new
ABI is needed and somebody might actually use the device as very
low resolution DAC. OTOH the relationship between output and input
channels is a bit non obvious this way.

Also note, that I didn't find any documentation about the expected
current unit in iio. I think uA is a reasonable choice, but this
should be confirmed and documented at least.

Harald

 drivers/staging/iio/adc/mxs-lradc.c |   80 +++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index df71669..48b1ed7 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -303,6 +303,11 @@ struct mxs_lradc {
 #define	LRADC_CTRL2				0x20
 #define	LRADC_CTRL2_DIVIDE_BY_TWO_OFFSET	24
 #define	LRADC_CTRL2_TEMPSENSE_PWD		(1 << 15)
+#define	LRADC_CTRL2_TEMP_SENSOR_IENABLE1	(1 << 9)
+#define	LRADC_CTRL2_TEMP_SENSOR_IENABLE0	(1 << 8)
+#define	LRADC_CTRL2_TEMP_ISRC1_OFFSET		4
+#define	LRADC_CTRL2_TEMP_ISRC0_OFFSET		0
+#define	LRADC_CTRL2_TEMP_ISRC_MASK		(0x0f)
 
 #define	LRADC_STATUS				0x40
 #define	LRADC_STATUS_TOUCH_DETECT_RAW		(1 << 0)
@@ -891,6 +896,31 @@ static int mxs_lradc_read_temp(struct iio_dev *iio_dev, int *val)
 	return IIO_VAL_INT;
 }
 
+static int mxs_lradc_read_current(struct mxs_lradc *lradc,
+			const struct iio_chan_spec *chan, int *val)
+{
+	*val = 0;
+	if (chan->channel == 0) {
+		if ((readl(lradc->base + LRADC_CTRL2) &
+					LRADC_CTRL2_TEMP_SENSOR_IENABLE0) == 0)
+			return IIO_VAL_INT;
+		*val = (readl(lradc->base + LRADC_CTRL2) >>
+					 LRADC_CTRL2_TEMP_ISRC0_OFFSET) &
+				LRADC_CTRL2_TEMP_ISRC_MASK;
+	} else if (chan->channel == 1) {
+		if ((readl(lradc->base + LRADC_CTRL2) &
+					LRADC_CTRL2_TEMP_SENSOR_IENABLE1) == 0)
+			return IIO_VAL_INT;
+		*val = (readl(lradc->base + LRADC_CTRL2) >>
+					LRADC_CTRL2_TEMP_ISRC1_OFFSET) &
+				LRADC_CTRL2_TEMP_ISRC_MASK;
+	} else {
+		return -EINVAL;
+	}
+
+	return IIO_VAL_INT;
+}
+
 static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
 			const struct iio_chan_spec *chan,
 			int *val, int *val2, long m)
@@ -905,6 +935,8 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
 	case IIO_CHAN_INFO_RAW:
 		if (chan->type == IIO_TEMP)
 			return mxs_lradc_read_temp(iio_dev, val);
+		else if (chan->type == IIO_CURRENT)
+			return mxs_lradc_read_current(lradc, chan, val);
 
 		return mxs_lradc_read_single(iio_dev, chan->channel, val);
 
@@ -916,6 +948,9 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
 			*val = 0;
 			*val2 = 253000;
 			return IIO_VAL_INT_PLUS_MICRO;
+		} else if (chan->type == IIO_CURRENT) {
+			*val = 20;
+			return IIO_VAL_INT;
 		}
 
 		*val = lradc->vref_mv[chan->channel];
@@ -977,6 +1012,31 @@ static int mxs_lradc_write_raw(struct iio_dev *iio_dev,
 		}
 
 		break;
+	case IIO_CHAN_INFO_RAW:
+		ret = -EINVAL;
+		if (!chan->output || (val & ~LRADC_CTRL2_TEMP_ISRC_MASK) != 0) {
+			break;
+		} else if (chan->channel == 0) {
+			mxs_lradc_reg_clear(lradc, LRADC_CTRL2_TEMP_ISRC_MASK
+					<< LRADC_CTRL2_TEMP_ISRC0_OFFSET,
+				LRADC_CTRL2);
+			mxs_lradc_reg_set(lradc,
+				val << LRADC_CTRL2_TEMP_ISRC0_OFFSET
+					| LRADC_CTRL2_TEMP_SENSOR_IENABLE0,
+				LRADC_CTRL2);
+			ret = 0;
+		} else if (chan->channel == 1) {
+			mxs_lradc_reg_clear(lradc, LRADC_CTRL2_TEMP_ISRC_MASK
+					<< LRADC_CTRL2_TEMP_ISRC1_OFFSET,
+				LRADC_CTRL2);
+			mxs_lradc_reg_set(lradc,
+				val << LRADC_CTRL2_TEMP_ISRC1_OFFSET
+					| LRADC_CTRL2_TEMP_SENSOR_IENABLE1,
+				LRADC_CTRL2);
+			ret = 0;
+		}
+
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -1417,6 +1477,24 @@ static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
 	MXS_ADC_CHAN(13, IIO_VOLTAGE),	/* VDDD */
 	MXS_ADC_CHAN(14, IIO_VOLTAGE),	/* VBG */
 	MXS_ADC_CHAN(15, IIO_VOLTAGE),	/* VDD5V */
+	{
+		.output = 1,
+		.type = IIO_CURRENT,
+		.indexed = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.channel = 0,
+		.scan_type = {.sign = 'u', .realbits = 4,},
+	},
+	{
+		.output = 1,
+		.type = IIO_CURRENT,
+		.indexed = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.channel = 1,
+		.scan_type = {.sign = 'u', .realbits = 4,},
+	},
 };
 
 static int mxs_lradc_hw_init(struct mxs_lradc *lradc)
@@ -1657,6 +1735,8 @@ static int mxs_lradc_remove(struct platform_device *pdev)
 	struct iio_dev *iio = platform_get_drvdata(pdev);
 	struct mxs_lradc *lradc = iio_priv(iio);
 
+	mxs_lradc_reg_clear(lradc, LRADC_CTRL2_TEMP_SENSOR_IENABLE0 |
+				LRADC_CTRL2_TEMP_SENSOR_IENABLE1, LRADC_CTRL2);
 	iio_device_unregister(iio);
 	mxs_lradc_ts_unregister(lradc);
 	mxs_lradc_hw_stop(lradc);
-- 
1.7.2.5

