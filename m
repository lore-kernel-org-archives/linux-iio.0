Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:63672 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702AbbG0WjP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jul 2015 18:39:15 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH v2 4/8] iio:adc:berlin2-adc: constify iio_chan_spec
Date: Tue, 28 Jul 2015 00:39:00 +0200
Message-Id: <9c7a4354629cc61c05ea31ac2678dd659a65f38a.1438035998.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438035998.git.knaack.h@gmx.de>
References: <cover.1438035998.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438035998.git.knaack.h@gmx.de>
References: <cover.1438035998.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Mark berlin2_adc_channels array as constant.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/iio/adc/berlin2-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index ed31a0a8d78e..745061091bd3 100644
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
2.4.6

