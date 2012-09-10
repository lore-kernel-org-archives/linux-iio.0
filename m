Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-022.synserver.de ([212.40.185.22]:1336 "EHLO
	smtp-out-022.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab2IJIeM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Sep 2012 04:34:12 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 01/10] staging:iio:ad7476: Fix off by one error for channel shift
Date: Mon, 10 Sep 2012 10:34:32 +0200
Message-Id: <1347266081-6045-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The datasheet is a bit confusing about this. It says that a dataword has 4
leading zeros, but the first zero is already put on the bus when CS is pulled
low and the second zero is put on the bus on the first leading edge of SCLK, so
when the first bit is sampled on the first trailing edge it will sample what the
datasheet refers to as the second leading zero. Subsequently we only see 3
leading zeros in the 16 bit dataword and the result we get is shifted to the
left by one bit. Fix this by adjusting the channel shift by 1.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7476_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 4f6d59e..33435ed 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -76,7 +76,7 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 		.sign = 'u',					\
 		.realbits = bits,				\
 		.storagebits = 16,				\
-		.shift = 12 - bits,				\
+		.shift = 13 - bits,				\
 	},							\
 }
 
-- 
1.7.10.4

