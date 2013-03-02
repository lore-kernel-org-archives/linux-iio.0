Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35727 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab3CBQRi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:38 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 28/67] iio:dac:ad5764 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:16:45 +0000
Message-Id: <1362241044-3534-29-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5764.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
index 5b7acd3..7a53f7d 100644
--- a/drivers/iio/dac/ad5764.c
+++ b/drivers/iio/dac/ad5764.c
@@ -78,11 +78,11 @@ enum ad5764_type {
 	.output = 1,						\
 	.channel = (_chan),					\
 	.address = (_chan),					\
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |		\
-		IIO_CHAN_INFO_OFFSET_SHARED_BIT |		\
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT |		\
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |		\
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,		\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+		BIT(IIO_CHAN_INFO_SCALE) |			\
+		BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
+		BIT(IIO_CHAN_INFO_CALIBBIAS),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET),	\
 	.scan_type = IIO_ST('u', (_bits), 16, 16 - (_bits))	\
 }
 
-- 
1.8.1.4

