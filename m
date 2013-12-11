Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59696 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab3LKSpt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2013 13:45:49 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, o.v.kravchenko@globallogic.com,
	stigge@antcom.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 11/24] iio:dac:ad5449 replaces IIO_ST macro with explicit entries to struct scan_type
Date: Wed, 11 Dec 2013 18:45:29 +0000
Message-Id: <1386787542-19666-12-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-1-git-send-email-jic23@kernel.org>
References: <1386787542-19666-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_ST is going away as it is a pain to maintain.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/dac/ad5449.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
index 82e208f6cde2..49d8c4767309 100644
--- a/drivers/iio/dac/ad5449.c
+++ b/drivers/iio/dac/ad5449.c
@@ -204,7 +204,12 @@ static const struct iio_info ad5449_info = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
 		BIT(IIO_CHAN_INFO_SCALE),			\
 	.address = (chan),					\
-	.scan_type = IIO_ST('u', (bits), 16, 12 - (bits)),	\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = (bits),				\
+		.storagebits = 16,				\
+		.shift = 12 - (bits),				\
+		},					\
 }
 
 #define DECLARE_AD5449_CHANNELS(name, bits) \
-- 
1.8.4.2

