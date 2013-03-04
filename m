Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60276 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758779Ab3CDVQb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Mar 2013 16:16:31 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Roland Stigge <stigge@antcom.de>
Subject: [PATCH 3/3] staging:iio:adc:lpc32xx move to info_mask_(shared_by_type/separate)
Date: Mon,  4 Mar 2013 21:16:20 +0000
Message-Id: <1362431780-27682-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1362431780-27682-1-git-send-email-jic23@kernel.org>
References: <1362431780-27682-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Roland Stigge <stigge@antcom.de>
---
 drivers/staging/iio/adc/lpc32xx_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
index 0bf2a6c..2f2f7fd 100644
--- a/drivers/staging/iio/adc/lpc32xx_adc.c
+++ b/drivers/staging/iio/adc/lpc32xx_adc.c
@@ -103,7 +103,7 @@ static const struct iio_info lpc32xx_adc_iio_info = {
 	.type = IIO_VOLTAGE,				\
 	.indexed = 1,					\
 	.channel = _index,				\
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,	\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 	.address = AD_IN * _index,			\
 	.scan_index = _index,				\
 }
-- 
1.8.1.4

