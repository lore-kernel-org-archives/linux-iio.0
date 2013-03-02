Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35735 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab3CBQRq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:46 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Rhyland Klein <rklein@nvidia.com>
Subject: [PATCH 58/67] staging:iio:light:isl29018 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:17:15 +0000
Message-Id: <1362241044-3534-59-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Rhyland Klein <rklein@nvidia.com>
---
 drivers/staging/iio/light/isl29018.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index b0adac0..82478a5 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -412,17 +412,17 @@ static const struct iio_chan_spec isl29018_channels[] = {
 		.type = IIO_LIGHT,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+		BIT(IIO_CHAN_INFO_CALIBSCALE),
 	}, {
 		.type = IIO_INTENSITY,
 		.modified = 1,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.channel2 = IIO_MOD_LIGHT_IR,
 	}, {
 		/* Unindexed in current ABI.  But perhaps it should be. */
 		.type = IIO_PROXIMITY,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 	}
 };
 
-- 
1.8.1.4

