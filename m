Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:61470 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755133AbbGYWni (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 25 Jul 2015 18:43:38 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH 7/8] iio:adc:berlin2-adc: enable interrupts with mutex locked
Date: Sun, 26 Jul 2015 00:43:25 +0200
Message-Id: <9defbeeab7b0ed50a68b478edbcaca8fa8ad78a2.1437862404.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437862404.git.knaack.h@gmx.de>
References: <cover.1437862404.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437862404.git.knaack.h@gmx.de>
References: <cover.1437862404.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move the call to enable channel interrupts into its _read() function to
have it protected by a mutex. This ensures that only one channel is
sampled at a time.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/adc/berlin2-adc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index c840ba8b2aa4..3621ee9f5032 100644
--- a/drivers/iio/adc/berlin2-adc.c
+++ b/drivers/iio/adc/berlin2-adc.c
@@ -111,6 +111,10 @@ static int berlin2_adc_read(struct iio_dev *indio_dev, int channel)
 
 	mutex_lock(&priv->lock);
 
+	/* Enable the interrupts */
+	regmap_write(priv->regmap, BERLIN2_SM_ADC_STATUS,
+		     BERLIN2_SM_ADC_STATUS_INT_EN(channel));
+
 	/* Configure the ADC */
 	regmap_update_bits(priv->regmap, BERLIN2_SM_CTRL,
 			BERLIN2_SM_CTRL_ADC_RESET | BERLIN2_SM_CTRL_ADC_SEL_MASK
@@ -149,6 +153,10 @@ static int berlin2_adc_tsen_read(struct iio_dev *indio_dev)
 
 	mutex_lock(&priv->lock);
 
+	/* Enable interrupts */
+	regmap_write(priv->regmap, BERLIN2_SM_TSEN_STATUS,
+		     BERLIN2_SM_TSEN_STATUS_INT_EN);
+
 	/* Configure the ADC */
 	regmap_update_bits(priv->regmap, BERLIN2_SM_CTRL,
 			BERLIN2_SM_CTRL_TSEN_RESET | BERLIN2_SM_CTRL_ADC_ROTATE,
@@ -190,7 +198,6 @@ static int berlin2_adc_read_raw(struct iio_dev *indio_dev,
 		struct iio_chan_spec const *chan, int *val, int *val2,
 		long mask)
 {
-	struct berlin2_adc_priv *priv = iio_priv(indio_dev);
 	int temp;
 
 	switch (mask) {
@@ -198,10 +205,6 @@ static int berlin2_adc_read_raw(struct iio_dev *indio_dev,
 		if (chan->type != IIO_VOLTAGE)
 			return -EINVAL;
 
-		/* Enable the interrupts */
-		regmap_write(priv->regmap, BERLIN2_SM_ADC_STATUS,
-				BERLIN2_SM_ADC_STATUS_INT_EN(chan->channel));
-
 		*val = berlin2_adc_read(indio_dev, chan->channel);
 		if (*val < 0)
 			return *val;
@@ -211,10 +214,6 @@ static int berlin2_adc_read_raw(struct iio_dev *indio_dev,
 		if (chan->type != IIO_TEMP)
 			return -EINVAL;
 
-		/* Enable interrupts */
-		regmap_write(priv->regmap, BERLIN2_SM_TSEN_STATUS,
-				BERLIN2_SM_TSEN_STATUS_INT_EN);
-
 		temp = berlin2_adc_tsen_read(indio_dev);
 		if (temp < 0)
 			return temp;
-- 
2.4.3

