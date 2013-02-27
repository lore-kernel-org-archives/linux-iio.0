Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59301 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759556Ab3B0Uk1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:27 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 65/67] staging:iio:resolver:ad2s1210 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:39:11 +0000
Message-Id: <1361997553-31058-66-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 53110b6..bea9d63 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -577,12 +577,12 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 		.type = IIO_ANGL,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+		.info_mask_separate = IIO_CHAN_INFO_RAW,
 	}, {
 		.type = IIO_ANGL_VEL,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+		.info_mask_separate = IIO_CHAN_INFO_RAW,
 	}
 };
 
-- 
1.8.1.1

