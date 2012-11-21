Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-222.synserver.de ([212.40.185.222]:1060 "EHLO
	smtp-out-222.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228Ab2KUQ1T (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Nov 2012 11:27:19 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/11] staging:iio:ad7793: Fix temperature scale
Date: Wed, 21 Nov 2012 17:27:07 +0100
Message-Id: <1353515236-21843-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1353515236-21843-1-git-send-email-lars@metafoo.de>
References: <1353515236-21843-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The temperature scale was off by a factor of 1000.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7793.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index a6ea4d2..965e6ae 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -297,7 +297,7 @@ static int ad7793_read_raw(struct iio_dev *indio_dev,
 			break;
 		case IIO_TEMP:
 				/* 1170mV / 0.81 mV/C / 2^23 */
-				scale_uv = 1444444444444ULL;
+				scale_uv = 1444444444444444ULL;
 			break;
 		default:
 			return -EINVAL;
-- 
1.8.0

