Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio: AD5638: Fix channel address
Date: Thu,  6 Oct 2011 15:19:07 +0200
Message-Id: <1317907147-15677-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Commit c6fc806247 ("staging:iio: ABI rework - add in_ or out_ prefix to
channnels") added the AD5868_CHANNEL macro to simplify channel initialization.
Unfortunately the macro hardcodes the channel's address to AD5686_ADDR_DAC0. As
a result writing to any of the channels will change the value of the first
channel.

This patch fixes the issue by calculating the channel address based on the
channel number.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5686.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
index b55ef42..adf898f 100644
--- a/drivers/staging/iio/dac/ad5686.c
+++ b/drivers/staging/iio/dac/ad5686.c
@@ -26,10 +26,7 @@
 #define AD5686_ADDR(x)				((x) << 16)
 #define AD5686_CMD(x)				((x) << 20)
 
-#define AD5686_ADDR_DAC0			0x1
-#define AD5686_ADDR_DAC1			0x2
-#define AD5686_ADDR_DAC2			0x4
-#define AD5686_ADDR_DAC3			0x8
+#define AD5686_ADDR_DAC(chan)		(0x1 << (chan))
 #define AD5686_ADDR_ALL_DAC			0xF
 
 #define AD5686_CMD_NOOP				0x0
@@ -103,7 +100,7 @@ enum ad5686_supported_device_ids {
 		.output = 1,					\
 		.channel = chan,				\
 		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),	\
-		.address = AD5686_ADDR_DAC0,			\
+		.address = AD5686_ADDR_DAC(chan),			\
 		.scan_type = IIO_ST('u', bits, 16, shift)	\
 }
 static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
-- 
1.7.2.5
