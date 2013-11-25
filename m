Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/15] iio:ad5791: Mark transfer buffers as __be32
Date: Mon, 25 Nov 2013 13:41:58 +0100
Message-Id: <1385383327-28181-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-1-git-send-email-lars@metafoo.de>
References: <1385383327-28181-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Fixes the following warnings from sparse:
	drivers/iio/dac/ad5791.c:114:18: warning: incorrect type in assignment (different base types)
	drivers/iio/dac/ad5791.c:114:18:    expected unsigned int [unsigned] [usertype] d32
	drivers/iio/dac/ad5791.c:114:18:    got restricted __be32 [usertype] <noident>
	drivers/iio/dac/ad5791.c:142:21: warning: incorrect type in assignment (different base types)
	drivers/iio/dac/ad5791.c:142:21:    expected unsigned int [unsigned] [usertype] d32
	drivers/iio/dac/ad5791.c:142:21:    got restricted __be32 [usertype] <noident>
	drivers/iio/dac/ad5791.c:144:21: warning: incorrect type in assignment (different base types)
	drivers/iio/dac/ad5791.c:144:21:    expected unsigned int [unsigned] [usertype] d32
	drivers/iio/dac/ad5791.c:144:21:    got restricted __be32 [usertype] <noident>
	drivers/iio/dac/ad5791.c:148:16: warning: cast to restricted __be32
	drivers/iio/dac/ad5791.c:148:16: warning: cast to restricted __be32
	drivers/iio/dac/ad5791.c:148:16: warning: cast to restricted __be32
	drivers/iio/dac/ad5791.c:148:16: warning: cast to restricted __be32
	drivers/iio/dac/ad5791.c:148:16: warning: cast to restricted __be32
	drivers/iio/dac/ad5791.c:148:16: warning: cast to restricted __be32

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5791.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index d64acbd..1e7f4cd 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -107,7 +107,7 @@ enum ad5791_supported_device_ids {
 static int ad5791_spi_write(struct spi_device *spi, u8 addr, u32 val)
 {
 	union {
-		u32 d32;
+		__be32 d32;
 		u8 d8[4];
 	} data;
 
@@ -121,7 +121,7 @@ static int ad5791_spi_write(struct spi_device *spi, u8 addr, u32 val)
 static int ad5791_spi_read(struct spi_device *spi, u8 addr, u32 *val)
 {
 	union {
-		u32 d32;
+		__be32 d32;
 		u8 d8[4];
 	} data[3];
 	int ret;
-- 
1.8.0
