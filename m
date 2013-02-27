Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59134 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759174Ab3B0UkR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:17 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Roland Stigge <stigge@antcom.de>
Subject: [PATCH 30/67] iio:dac:max517 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:36 +0000
Message-Id: <1361997553-31058-31-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Roland Stigge <stigge@antcom.de>
---
 drivers/iio/dac/max517.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index 352abe2..877053c 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -146,8 +146,8 @@ static const struct iio_info max517_info = {
 	.indexed = 1,					\
 	.output = 1,					\
 	.channel = (chan),				\
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |	\
-	IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
+	.info_mask_separate = IIO_CHAN_INFO_RAW |	\
+	IIO_CHAN_INFO_SCALE,				\
 	.scan_type = IIO_ST('u', 8, 8, 0),		\
 }
 
-- 
1.8.1.1

