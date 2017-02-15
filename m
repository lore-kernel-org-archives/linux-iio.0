Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34380 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdBOTcI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Feb 2017 14:32:08 -0500
Received: by mail-wr0-f196.google.com with SMTP id c4so6907800wrd.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Feb 2017 11:32:08 -0800 (PST)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 2/2] iio: adc: meson-saradc: improve
 meson_sar_adc_read_raw_sample
To: Jonathan Cameron <jic23@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <e6dbc777-25a9-15a1-a415-2a020b8e40f7@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Message-ID: <f8490439-7ace-c4ad-0152-53e998706a40@gmail.com>
Date: Wed, 15 Feb 2017 20:31:55 +0100
MIME-Version: 1.0
In-Reply-To: <e6dbc777-25a9-15a1-a415-2a020b8e40f7@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

After sampling there should always be only one value in the FIFO.
This also applies to averaging mode as the averaging is done
chip-internally. So we don't have to loop and let the driver
complain if there's not exactly one value in the FIFO.

If the value belongs to a different channel then don't silently
swallow the value but complain.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
v2:
- rebased
---
 drivers/iio/adc/meson_saradc.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 9f186de2..cde9ca7a 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -278,33 +278,31 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 					 int *val)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
-	int regval, fifo_chan, fifo_val, sum = 0, count = 0;
+	int regval, fifo_chan, fifo_val, count;
 
 	if(!wait_for_completion_timeout(&priv->done,
 				msecs_to_jiffies(MESON_SAR_ADC_TIMEOUT)))
 		return -ETIMEDOUT;
 
-	while (meson_sar_adc_get_fifo_count(indio_dev) > 0 &&
-	       count < MESON_SAR_ADC_MAX_FIFO_SIZE) {
-		regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
-
-		fifo_chan = FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK,
-				      regval);
-		if (fifo_chan != chan->channel)
-			continue;
-
-		fifo_val = FIELD_GET(MESON_SAR_ADC_FIFO_RD_SAMPLE_VALUE_MASK,
-				     regval);
-		fifo_val &= (BIT(priv->data->resolution) - 1);
-
-		sum += fifo_val;
-		count++;
+	count = meson_sar_adc_get_fifo_count(indio_dev);
+	if (count != 1) {
+		dev_err(&indio_dev->dev,
+			"ADC FIFO has %d element(s) instead of one\n", count);
+		return -EINVAL;
 	}
 
-	if (!count)
-		return -ENOENT;
+	regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
+	fifo_chan = FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK, regval);
+	if (fifo_chan != chan->channel) {
+		dev_err(&indio_dev->dev,
+			"ADC FIFO entry belongs to channel %d instead of %d\n",
+			fifo_chan, chan->channel);
+		return -EINVAL;
+	}
 
-	*val = sum / count;
+	fifo_val = FIELD_GET(MESON_SAR_ADC_FIFO_RD_SAMPLE_VALUE_MASK, regval);
+	fifo_val &= GENMASK(priv->data->resolution - 1, 0);
+	*val = fifo_val;
 
 	return 0;
 }
-- 
2.11.1


