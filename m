Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-222.synserver.de ([212.40.185.222]:1058 "EHLO
	smtp-out-222.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211Ab2KUQ1T (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Nov 2012 11:27:19 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/11] staging:iio:ad7793: Fix VDD monitor scale
Date: Wed, 21 Nov 2012 17:27:06 +0100
Message-Id: <1353515236-21843-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The VDD monitor scale was off by a factor of 10.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Last series before 3.8-rc1, I promise ;)
---
 drivers/staging/iio/adc/ad7793.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 691a7be..a6ea4d2 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -292,7 +292,7 @@ static int ad7793_read_raw(struct iio_dev *indio_dev,
 				return IIO_VAL_INT_PLUS_NANO;
 			} else {
 				/* 1170mV / 2^23 * 6 */
-				scale_uv = (1170ULL * 100000000ULL * 6ULL);
+				scale_uv = (1170ULL * 1000000000ULL * 6ULL);
 			}
 			break;
 		case IIO_TEMP:
-- 
1.8.0

