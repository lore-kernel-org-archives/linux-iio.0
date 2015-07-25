Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:58771 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755136AbbGYWnl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 25 Jul 2015 18:43:41 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH 4/8] iio:adc:berlin2-adc: constify iio_chan_spec
Date: Sun, 26 Jul 2015 00:43:22 +0200
Message-Id: <075fdfa71c79b09fbb583e5ce6c6d28614e7465d.1437862404.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437862404.git.knaack.h@gmx.de>
References: <cover.1437862404.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437862404.git.knaack.h@gmx.de>
References: <cover.1437862404.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Mark berlin2_adc_channels array as constant.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/adc/berlin2-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index 42e214b3e93a..b7df94a0b879 100644
--- a/drivers/iio/adc/berlin2-adc.c
+++ b/drivers/iio/adc/berlin2-adc.c
@@ -86,7 +86,7 @@ struct berlin2_adc_priv {
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 		}
 
-static struct iio_chan_spec berlin2_adc_channels[] = {
+static const struct iio_chan_spec berlin2_adc_channels[] = {
 	BERLIN2_ADC_CHANNEL(0, IIO_VOLTAGE),	/* external input */
 	BERLIN2_ADC_CHANNEL(1, IIO_VOLTAGE),	/* external input */
 	BERLIN2_ADC_CHANNEL(2, IIO_VOLTAGE),	/* external input */
-- 
2.4.3

