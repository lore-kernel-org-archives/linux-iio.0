Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 03/16] staging:iio:adc:ad799x fix incorrect setting of configuration register on single channel read.
Date: Fri, 23 Sep 2011 13:01:29 +0100
Message-Id: <1316779302-12357-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

It is a bit mask whereas current code treats it as a straight value.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad799x_core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 975a3f7..3b5f8be 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -123,7 +123,8 @@ static int ad799x_scan_direct(struct ad799x_state *st, unsigned ch)
 		break;
 	case ad7997:
 	case ad7998:
-		cmd = (ch << AD799X_CHANNEL_SHIFT) | AD7997_8_READ_SINGLE;
+		cmd = ((1 << ch) << AD799X_CHANNEL_SHIFT) |
+			AD7997_8_READ_SINGLE;
 		break;
 	default:
 		return -EINVAL;
-- 
1.7.3.4
