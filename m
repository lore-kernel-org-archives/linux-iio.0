Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/15] iio:ad5421: Mark transfer buffer as __be32
Date: Mon, 25 Nov 2013 13:41:55 +0100
Message-Id: <1385383327-28181-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-1-git-send-email-lars@metafoo.de>
References: <1385383327-28181-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Fixes the following warnings from sparse:
	drivers/iio/dac/ad5421.c:134:25: warning: incorrect type in assignment (different base types)
	drivers/iio/dac/ad5421.c:134:25:    expected unsigned int [unsigned] [usertype] d32
	drivers/iio/dac/ad5421.c:134:25:    got restricted __be32 [usertype] <noident>
	drivers/iio/dac/ad5421.c:168:25: warning: incorrect type in assignment (different base types)
	drivers/iio/dac/ad5421.c:168:25:    expected unsigned int [unsigned] [usertype] d32
	drivers/iio/dac/ad5421.c:168:25:    got restricted __be32 [usertype] <noident>
	drivers/iio/dac/ad5421.c:172:23: warning: cast to restricted __be32
	drivers/iio/dac/ad5421.c:172:23: warning: cast to restricted __be32
	drivers/iio/dac/ad5421.c:172:23: warning: cast to restricted __be32
	drivers/iio/dac/ad5421.c:172:23: warning: cast to restricted __be32
	drivers/iio/dac/ad5421.c:172:23: warning: cast to restricted __be32
	drivers/iio/dac/ad5421.c:172:23: warning: cast to restricted __be32

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5421.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index 3eeaa82..fcb599c 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -75,7 +75,7 @@ struct ad5421_state {
 	 * transfer buffers to live in their own cache lines.
 	 */
 	union {
-		u32 d32;
+		__be32 d32;
 		u8 d8[4];
 	} data[2] ____cacheline_aligned;
 };
-- 
1.8.0
