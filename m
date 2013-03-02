Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35722 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab3CBQRe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:34 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 05/67] iio:accel:kxsd9 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:16:22 +0000
Message-Id: <1362241044-3534-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/accel/kxsd9.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index c2229a5..7229645 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -177,8 +177,8 @@ error_ret:
 		.type = IIO_ACCEL,					\
 		.modified = 1,						\
 		.channel2 = IIO_MOD_##axis,				\
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |		\
-			IIO_CHAN_INFO_SCALE_SHARED_BIT,			\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 		.address = KXSD9_REG_##axis,				\
 	}
 
@@ -186,7 +186,7 @@ static const struct iio_chan_spec kxsd9_channels[] = {
 	KXSD9_ACCEL_CHAN(X), KXSD9_ACCEL_CHAN(Y), KXSD9_ACCEL_CHAN(Z),
 	{
 		.type = IIO_VOLTAGE,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.indexed = 1,
 		.address = KXSD9_REG_AUX,
 	}
-- 
1.8.1.4

