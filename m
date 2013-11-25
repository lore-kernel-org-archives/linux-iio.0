Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/15] iio:ad5504: Mark transfer buffers as __be16
Date: Mon, 25 Nov 2013 13:41:53 +0100
Message-Id: <1385383327-28181-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Fixes the following warnings from sparse:
	drivers/iio/dac/ad5504.c:71:19: warning: incorrect type in initializer (different base types)
	drivers/iio/dac/ad5504.c:71:19:    expected unsigned short [unsigned] [usertype] tmp
	drivers/iio/dac/ad5504.c:71:19:    got restricted __be16 [usertype] <noident>
	drivers/iio/dac/ad5504.c:80:19: warning: incorrect type in initializer (different base types)
	drivers/iio/dac/ad5504.c:80:19:    expected unsigned short [unsigned] [usertype] tmp
	drivers/iio/dac/ad5504.c:80:19:    got restricted __be16 [usertype] <noident>
	drivers/iio/dac/ad5504.c:93:16: warning: cast to restricted __be16
	drivers/iio/dac/ad5504.c:93:16: warning: cast to restricted __be16
	drivers/iio/dac/ad5504.c:93:16: warning: cast to restricted __be16
	drivers/iio/dac/ad5504.c:93:16: warning: cast to restricted __be16

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5504.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index c0957a9..6cd0dd6 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -68,7 +68,7 @@ enum ad5504_supported_device_ids {
 
 static int ad5504_spi_write(struct spi_device *spi, u8 addr, u16 val)
 {
-	u16 tmp = cpu_to_be16(AD5504_CMD_WRITE |
+	__be16 tmp = cpu_to_be16(AD5504_CMD_WRITE |
 			      AD5504_ADDR(addr) |
 			      (val & AD5504_RES_MASK));
 
@@ -77,8 +77,8 @@ static int ad5504_spi_write(struct spi_device *spi, u8 addr, u16 val)
 
 static int ad5504_spi_read(struct spi_device *spi, u8 addr)
 {
-	u16 tmp = cpu_to_be16(AD5504_CMD_READ | AD5504_ADDR(addr));
-	u16 val;
+	__be16 tmp = cpu_to_be16(AD5504_CMD_READ | AD5504_ADDR(addr));
+	__be16 val;
 	int ret;
 	struct spi_transfer	t = {
 			.tx_buf		= &tmp,
-- 
1.8.0
