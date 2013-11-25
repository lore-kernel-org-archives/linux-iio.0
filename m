Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 15/15] staging:iio:ad9834: Mark transfer buffers as __b16
Date: Mon, 25 Nov 2013 13:42:07 +0100
Message-Id: <1385383327-28181-15-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-1-git-send-email-lars@metafoo.de>
References: <1385383327-28181-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Fixes the following warnings from sparse:
	drivers/staging/iio/frequency/ad9834.c:45:26: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9834.c:45:26:    expected unsigned short [unsigned] [short] <noident>
	drivers/staging/iio/frequency/ad9834.c:45:26:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9834.c:47:26: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9834.c:47:26:    expected unsigned short [unsigned] [short] <noident>
	drivers/staging/iio/frequency/ad9834.c:47:26:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9834.c:59:18: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9834.c:59:18:    expected unsigned short [unsigned] data
	drivers/staging/iio/frequency/ad9834.c:59:18:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9834.c:100:26: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9834.c:100:26:    expected unsigned short [unsigned] data
	drivers/staging/iio/frequency/ad9834.c:100:26:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9834.c:108:26: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9834.c:108:26:    expected unsigned short [unsigned] data
	drivers/staging/iio/frequency/ad9834.c:108:26:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9834.c:122:26: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9834.c:122:26:    expected unsigned short [unsigned] data
	drivers/staging/iio/frequency/ad9834.c:122:26:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9834.c:131:26: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9834.c:131:26:    expected unsigned short [unsigned] data
	drivers/staging/iio/frequency/ad9834.c:131:26:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9834.c:194:26: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9834.c:194:26:    expected unsigned short [unsigned] data
	drivers/staging/iio/frequency/ad9834.c:194:26:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9834.c:387:18: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9834.c:387:18:    expected unsigned short [unsigned] data
	drivers/staging/iio/frequency/ad9834.c:387:18:    got restricted __be16 [usertype] <noident>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/frequency/ad9834.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.h b/drivers/staging/iio/frequency/ad9834.h
index ed5ed8d..8ca6e52 100644
--- a/drivers/staging/iio/frequency/ad9834.h
+++ b/drivers/staging/iio/frequency/ad9834.h
@@ -65,8 +65,8 @@ struct ad9834_state {
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
 	 */
-	unsigned short			data ____cacheline_aligned;
-	unsigned short			freq_data[2] ;
+	__be16				data ____cacheline_aligned;
+	__be16				freq_data[2];
 };
 
 
-- 
1.8.0
