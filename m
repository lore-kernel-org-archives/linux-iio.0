Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59701 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab3LKSpv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2013 13:45:51 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, o.v.kravchenko@globallogic.com,
	stigge@antcom.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 16/24] iio:dac:ad5764 replaces IIO_ST macro with explicit entries to struct scan_type
Date: Wed, 11 Dec 2013 18:45:34 +0000
Message-Id: <1386787542-19666-17-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-1-git-send-email-jic23@kernel.org>
References: <1386787542-19666-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_ST is going away as it is a pain to maintain.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/dac/ad5764.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
index a8ff5b2ed13e..efc1472a4116 100644
--- a/drivers/iio/dac/ad5764.c
+++ b/drivers/iio/dac/ad5764.c
@@ -83,7 +83,12 @@ enum ad5764_type {
 		BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
 		BIT(IIO_CHAN_INFO_CALIBBIAS),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET),	\
-	.scan_type = IIO_ST('u', (_bits), 16, 16 - (_bits))	\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = (_bits),				\
+		.storagebits = 16,				\
+		.shift = 16 - (_bits),				\
+		},						\
 }
 
 #define DECLARE_AD5764_CHANNELS(_name, _bits) \
-- 
1.8.4.2

