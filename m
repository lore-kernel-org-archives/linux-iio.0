Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:60474 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755136AbbGYWni (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 25 Jul 2015 18:43:38 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH 6/8] iio:adc:berlin2-adc: use channel-array size directly
Date: Sun, 26 Jul 2015 00:43:24 +0200
Message-Id: <e64898d4f93ba8049aa016e1cf8cf8345783557a.1437862404.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437862404.git.knaack.h@gmx.de>
References: <cover.1437862404.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437862404.git.knaack.h@gmx.de>
References: <cover.1437862404.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Drop the otherwise unused definition of the channel-array size and use it
directly in _probe - makes it a bit more obvious.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/adc/berlin2-adc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index 1d14290ba6f2..c840ba8b2aa4 100644
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
2.4.3

