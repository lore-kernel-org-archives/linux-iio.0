Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59693 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab3LKSpt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2013 13:45:49 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, o.v.kravchenko@globallogic.com,
	stigge@antcom.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 10/24] iio:dac:ad5446 replaces IIO_ST macro with explicit entries to struct scan_type
Date: Wed, 11 Dec 2013 18:45:28 +0000
Message-Id: <1386787542-19666-11-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-1-git-send-email-jic23@kernel.org>
References: <1386787542-19666-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_ST is going away as it is a pain to maintain.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/dac/ad5446.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 1263b0e5ad84..46bb62a5c1d4 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -139,14 +139,19 @@ static const struct iio_chan_spec_ext_info ad5446_ext_info_powerdown[] = {
 	{ },
 };
 
-#define _AD5446_CHANNEL(bits, storage, shift, ext) { \
+#define _AD5446_CHANNEL(bits, storage, _shift, ext) { \
 	.type = IIO_VOLTAGE, \
 	.indexed = 1, \
 	.output = 1, \
 	.channel = 0, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
-	.scan_type = IIO_ST('u', (bits), (storage), (shift)), \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = (bits), \
+		.storagebits = (storage), \
+		.shift = (_shift), \
+		}, \
 	.ext_info = (ext), \
 }
 
-- 
1.8.4.2

