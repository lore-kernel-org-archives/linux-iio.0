Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35736 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387Ab3CBQRh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:37 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 23/67] iio:dac:ad5449 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:16:40 +0000
Message-Id: <1362241044-3534-24-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5449.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
index c4731b7..ba1c914 100644
--- a/drivers/iio/dac/ad5449.c
+++ b/drivers/iio/dac/ad5449.c
@@ -206,8 +206,8 @@ static const struct iio_info ad5449_info = {
 	.indexed = 1,						\
 	.output = 1,						\
 	.channel = (chan),					\
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |		\
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+		BIT(IIO_CHAN_INFO_SCALE),			\
 	.address = (chan),					\
 	.scan_type = IIO_ST('u', (bits), 16, 12 - (bits)),	\
 }
-- 
1.8.1.4

