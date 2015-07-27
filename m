Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:58940 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546AbbG0WjQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jul 2015 18:39:16 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH v2 6/8] iio:adc:berlin2-adc: use channel-array size directly
Date: Tue, 28 Jul 2015 00:39:02 +0200
Message-Id: <7fa1609e70603e150ce0c41f1b74c2ff1112df01.1438035998.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438035998.git.knaack.h@gmx.de>
References: <cover.1438035998.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438035998.git.knaack.h@gmx.de>
References: <cover.1438035998.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Drop the otherwise unused definition of the channel-array size and use it
directly in _probe - makes it a bit more obvious.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/iio/adc/berlin2-adc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index 1e1d618ce152..6e20c856f479 100644
--- a/drivers/iio/adc/berlin2-adc.c
+++ b/drivers/iio/adc/berlin2-adc.c
@@ -103,7 +103,6 @@ static const struct iio_chan_spec berlin2_adc_channels[] = {
 	BERLIN2_ADC_CHANNEL(7, IIO_VOLTAGE),	/* reserved */
 	IIO_CHAN_SOFT_TIMESTAMP(8),		/* timestamp */
 };
-#define BERLIN2_N_CHANNELS	ARRAY_SIZE(berlin2_adc_channels)
 
 static int berlin2_adc_read(struct iio_dev *indio_dev, int channel)
 {
@@ -324,8 +323,8 @@ static int berlin2_adc_probe(struct platform_device *pdev)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &berlin2_adc_info;
 
-	indio_dev->num_channels = BERLIN2_N_CHANNELS;
 	indio_dev->channels = berlin2_adc_channels;
+	indio_dev->num_channels = ARRAY_SIZE(berlin2_adc_channels);
 
 	/* Power up the ADC */
 	regmap_update_bits(priv->regmap, BERLIN2_SM_CTRL,
-- 
2.4.6

