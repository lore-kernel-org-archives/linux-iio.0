Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/15] iio:ad5686: Mark transfer buffer as __be32
Date: Mon, 25 Nov 2013 13:41:56 +0100
Message-Id: <1385383327-28181-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-1-git-send-email-lars@metafoo.de>
References: <1385383327-28181-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Fixes the following warnings from sparse:
	drivers/iio/dac/ad5686.c:100:25: warning: incorrect type in assignment (different base types)
	drivers/iio/dac/ad5686.c:100:25:    expected unsigned int [unsigned] [usertype] d32
	drivers/iio/dac/ad5686.c:100:25:    got restricted __be32 [usertype] <noident>
	drivers/iio/dac/ad5686.c:122:25: warning: incorrect type in assignment (different base types)
	drivers/iio/dac/ad5686.c:122:25:    expected unsigned int [unsigned] [usertype] d32
	drivers/iio/dac/ad5686.c:122:25:    got restricted __be32 [usertype] <noident>
	drivers/iio/dac/ad5686.c:124:25: warning: incorrect type in assignment (different base types)
	drivers/iio/dac/ad5686.c:124:25:    expected unsigned int [unsigned] [usertype] d32
	drivers/iio/dac/ad5686.c:124:25:    got restricted __be32 [usertype] <noident>
	drivers/iio/dac/ad5686.c:130:16: warning: cast to restricted __be32
	drivers/iio/dac/ad5686.c:130:16: warning: cast to restricted __be32
	drivers/iio/dac/ad5686.c:130:16: warning: cast to restricted __be32
	drivers/iio/dac/ad5686.c:130:16: warning: cast to restricted __be32
	drivers/iio/dac/ad5686.c:130:16: warning: cast to restricted __be32
	drivers/iio/dac/ad5686.c:130:16: warning: cast to restricted __be32

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5686.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 30e506e..e56ec0a 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -78,7 +78,7 @@ struct ad5686_state {
 	 */
 
 	union {
-		u32 d32;
+		__be32 d32;
 		u8 d8[4];
 	} data[3] ____cacheline_aligned;
 };
-- 
1.8.0
