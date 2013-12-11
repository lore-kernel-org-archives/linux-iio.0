Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59693 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab3LKSpu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2013 13:45:50 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, o.v.kravchenko@globallogic.com,
	stigge@antcom.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 14/24] iio:dac:ad5686 replaces IIO_ST macro with explicit entries to struct scan_type
Date: Wed, 11 Dec 2013 18:45:32 +0000
Message-Id: <1386787542-19666-15-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-1-git-send-email-jic23@kernel.org>
References: <1386787542-19666-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_ST is going away as it is a pain to maintain.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/dac/ad5686.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index e56ec0abb509..faf363f45675 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -267,7 +267,7 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 	{ },
 };
 
-#define AD5868_CHANNEL(chan, bits, shift) {			\
+#define AD5868_CHANNEL(chan, bits, _shift) {			\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
 		.output = 1,					\
@@ -275,7 +275,12 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
 		.address = AD5686_ADDR_DAC(chan),		\
-		.scan_type = IIO_ST('u', bits, 16, shift),	\
+		.scan_type = {					\
+			.sign = 'u',				\
+			.realbits = (bits),			\
+			.storagebits = 16,			\
+			.shift = (_shift),			\
+			},					\
 		.ext_info = ad5686_ext_info,			\
 }
 
-- 
1.8.4.2

