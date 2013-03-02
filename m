Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35731 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab3CBQRj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:39 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Roland Stigge <stigge@antcom.de>
Subject: [PATCH 30/67] iio:dac:max517 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:16:47 +0000
Message-Id: <1362241044-3534-31-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Roland Stigge <stigge@antcom.de>
---
 drivers/iio/dac/max517.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index 352abe2..ebfaa41 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -146,8 +146,8 @@ static const struct iio_info max517_info = {
 	.indexed = 1,					\
 	.output = 1,					\
 	.channel = (chan),				\
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |	\
-	IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+	BIT(IIO_CHAN_INFO_SCALE),			\
 	.scan_type = IIO_ST('u', 8, 8, 0),		\
 }
 
-- 
1.8.1.4

