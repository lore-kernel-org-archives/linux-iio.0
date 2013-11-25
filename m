Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 14/15] staging:iio:ad9832: Mark transfer buffers as __be16
Date: Mon, 25 Nov 2013 13:42:06 +0100
Message-Id: <1385383327-28181-14-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-1-git-send-email-lars@metafoo.de>
References: <1385383327-28181-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Fixes the following warnings from sparse:
	drivers/staging/iio/frequency/ad9832.c:43:26: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9832.c:43:26:    expected unsigned short [unsigned] [short] <noident>
	drivers/staging/iio/frequency/ad9832.c:43:26:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9832.c:46:26: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9832.c:46:26:    expected unsigned short [unsigned] [short] <noident>
	drivers/staging/iio/frequency/ad9832.c:46:26:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9832.c:49:26: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9832.c:49:26:    expected unsigned short [unsigned] [short] <noident>
	drivers/staging/iio/frequency/ad9832.c:49:26:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9832.c:52:26: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9832.c:52:26:    expected unsigned short [unsigned] [short] <noident>
	drivers/staging/iio/frequency/ad9832.c:52:26:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9832.c:65:27: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9832.c:65:27:    expected unsigned short [unsigned] [short] <noident>
	drivers/staging/iio/frequency/ad9832.c:65:27:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9832.c:68:27: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9832.c:68:27:    expected unsigned short [unsigned] [short] <noident>
	drivers/staging/iio/frequency/ad9832.c:68:27:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9832.c:107:26: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9832.c:107:26:    expected unsigned short [unsigned] data
	drivers/staging/iio/frequency/ad9832.c:107:26:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9832.c:120:26: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9832.c:120:26:    expected unsigned short [unsigned] data
	drivers/staging/iio/frequency/ad9832.c:120:26:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9832.c:133:26: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9832.c:133:26:    expected unsigned short [unsigned] data
	drivers/staging/iio/frequency/ad9832.c:133:26:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9832.c:144:26: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9832.c:144:26:    expected unsigned short [unsigned] data
	drivers/staging/iio/frequency/ad9832.c:144:26:    got restricted __be16 [usertype] <noident>
	drivers/staging/iio/frequency/ad9832.c:277:18: warning: incorrect type in assignment (different base types)
	drivers/staging/iio/frequency/ad9832.c:277:18:    expected unsigned short [unsigned] data
	drivers/staging/iio/frequency/ad9832.c:277:18:    got restricted __be16 [usertype] <noident>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/frequency/ad9832.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
index c5b701f..386f4dc 100644
--- a/drivers/staging/iio/frequency/ad9832.h
+++ b/drivers/staging/iio/frequency/ad9832.h
@@ -92,9 +92,9 @@ struct ad9832_state {
 	 * transfer buffers to live in their own cache lines.
 	 */
 	union {
-		unsigned short		freq_data[4]____cacheline_aligned;
-		unsigned short		phase_data[2];
-		unsigned short		data;
+		__be16			freq_data[4]____cacheline_aligned;
+		__be16			phase_data[2];
+		__be16			data;
 	};
 };
 
-- 
1.8.0
