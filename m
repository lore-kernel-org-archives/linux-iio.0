Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59132 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758636Ab3B0UkN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:13 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 17/67] iio:amplifiers:ad8366 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:23 +0000
Message-Id: <1361997553-31058-18-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index d6c0af2..6c2610e 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -125,7 +125,7 @@ static const struct iio_info ad8366_info = {
 	.output = 1,					\
 	.indexed = 1,					\
 	.channel = _channel,				\
-	.info_mask = IIO_CHAN_INFO_HARDWAREGAIN_SEPARATE_BIT,\
+	.info_mask_separate = IIO_CHAN_INFO_HARDWAREGAIN,\
 }
 
 static const struct iio_chan_spec ad8366_channels[] = {
-- 
1.8.1.1

