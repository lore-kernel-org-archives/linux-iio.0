Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59250 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759646Ab3B0UkZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:25 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 59/67] staging:iio:isl29028 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:39:05 +0000
Message-Id: <1361997553-31058-60-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/staging/iio/light/isl29028.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index e52af77..c8787ea 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -391,15 +391,15 @@ static const struct attribute_group isl29108_group = {
 static const struct iio_chan_spec isl29028_channels[] = {
 	{
 		.type = IIO_LIGHT,
-		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask_separate = IIO_CHAN_INFO_PROCESSED |
+		IIO_CHAN_INFO_SCALE,
 	}, {
 		.type = IIO_INTENSITY,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+		.info_mask_separate = IIO_CHAN_INFO_RAW,
 	}, {
 		.type = IIO_PROXIMITY,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SAMP_FREQ_SEPARATE_BIT,
+		.info_mask_separate = IIO_CHAN_INFO_RAW |
+		IIO_CHAN_INFO_SAMP_FREQ,
 	}
 };
 
-- 
1.8.1.1

