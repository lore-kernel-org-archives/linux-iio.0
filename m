Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59696 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab3LKSps (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2013 13:45:48 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, o.v.kravchenko@globallogic.com,
	stigge@antcom.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 07/24] iio:dac:ad5360 replaces IIO_ST macro with explicit entries to struct scan_type
Date: Wed, 11 Dec 2013 18:45:25 +0000
Message-Id: <1386787542-19666-8-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-1-git-send-email-jic23@kernel.org>
References: <1386787542-19666-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_ST is going away as it is a pain to maintain.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/dac/ad5360.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index b968af50db0a..92b92bcdf86d 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -107,7 +107,12 @@ enum ad5360_type {
 		BIT(IIO_CHAN_INFO_OFFSET) |				\
 		BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
 		BIT(IIO_CHAN_INFO_CALIBBIAS),			\
-	.scan_type = IIO_ST('u', (bits), 16, 16 - (bits))	\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = (bits),				\
+		.storagebits = 16,				\
+		.shift = 16 - (bits),				\
+		},						\
 }
 
 static const struct ad5360_chip_info ad5360_chip_info_tbl[] = {
-- 
1.8.4.2

