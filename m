Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59688 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab3LKSpv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2013 13:45:51 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, o.v.kravchenko@globallogic.com,
	stigge@antcom.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 17/24] iio:dac:ad5791 replaces IIO_ST macro with explicit entries to struct scan_type
Date: Wed, 11 Dec 2013 18:45:35 +0000
Message-Id: <1386787542-19666-18-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-1-git-send-email-jic23@kernel.org>
References: <1386787542-19666-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_ST is going away as it is a pain to maintain.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/dac/ad5791.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 79bf19945747..d4f64196d000 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -293,7 +293,7 @@ static const struct iio_chan_spec_ext_info ad5791_ext_info[] = {
 	{ },
 };
 
-#define AD5791_CHAN(bits, shift) {			\
+#define AD5791_CHAN(bits, _shift) {			\
 	.type = IIO_VOLTAGE,				\
 	.output = 1,					\
 	.indexed = 1,					\
@@ -302,7 +302,12 @@ static const struct iio_chan_spec_ext_info ad5791_ext_info[] = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
 		BIT(IIO_CHAN_INFO_OFFSET),		\
-	.scan_type = IIO_ST('u', bits, 24, shift),	\
+	.scan_type = {					\
+		.sign = 'u',				\
+		.realbits = (bits),			\
+		.storagebits = 24,			\
+		.shift = (_shift),			\
+		},					\
 	.ext_info = ad5791_ext_info,			\
 }
 
-- 
1.8.4.2

