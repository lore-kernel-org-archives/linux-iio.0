Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59693 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab3LKSpx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2013 13:45:53 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, o.v.kravchenko@globallogic.com,
	stigge@antcom.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 22/24] staging:iio:ad7606 replaces IIO_ST macro with explicit entries to struct scan_type
Date: Wed, 11 Dec 2013 18:45:40 +0000
Message-Id: <1386787542-19666-23-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-1-git-send-email-jic23@kernel.org>
References: <1386787542-19666-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_ST is going away as it is a pain to maintain. Note that this driver
currently ensures all fields are converted to the native endianness
to keep things consistent across the different bus types.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/ad7606_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 2083673a79ca..7a83cc5eef4c 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -239,7 +239,12 @@ static const struct attribute_group ad7606_attribute_group_range = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
 		.scan_index = num,				\
-		.scan_type = IIO_ST('s', 16, 16, 0),		\
+		.scan_type = {					\
+			.sign = 's',				\
+			.realbits = 16,			\
+			.storagebits = 16,			\
+			.endianness = IIO_CPU,			\
+			},					\
 	}
 
 static const struct iio_chan_spec ad7606_8_channels[] = {
-- 
1.8.4.2

