Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35722 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab3CBQRi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:38 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 25/67] iio:dac:ad5624r move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:16:42 +0000
Message-Id: <1362241044-3534-26-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5624r_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index f6e1166..bb298aa 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -174,8 +174,8 @@ static const struct iio_chan_spec_ext_info ad5624r_ext_info[] = {
 	.indexed = 1, \
 	.output = 1, \
 	.channel = (_chan), \
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-		     IIO_CHAN_INFO_SCALE_SHARED_BIT, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
 	.address = (_chan), \
 	.scan_type = IIO_ST('u', (_bits), 16, 16 - (_bits)), \
 	.ext_info = ad5624r_ext_info, \
-- 
1.8.1.4

