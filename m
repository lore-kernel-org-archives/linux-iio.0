Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/22] staging:iio:ad7192: Add missing break in switch statement
Date: Fri, 10 Aug 2012 18:36:22 +0200
Message-Id: <1344616596-8026-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1344616596-8026-1-git-send-email-lars@metafoo.de>
References: <1344616596-8026-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Without the break statement we fall right through to the default case and return
an error value.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7192.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index e381d4b..d65feda 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -890,7 +890,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 				}
 				ret = 0;
 			}
-
+		break;
 	default:
 		ret = -EINVAL;
 	}
-- 
1.7.10.4
