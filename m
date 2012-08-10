Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 14/22] staging:iio:ad7780: Mark channels as unsigned
Date: Fri, 10 Aug 2012 18:36:28 +0200
Message-Id: <1344616596-8026-14-git-send-email-lars@metafoo.de>
In-Reply-To: <1344616596-8026-1-git-send-email-lars@metafoo.de>
References: <1344616596-8026-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The values reported by the AD7780 are unsigned with a binary offset:

	0x000000 is negative fullscale
	0x800000 is zeroscale
	0xffffff is positive fullscale

So mark the channel in the channel spec as unsigned rather than signed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7780.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 1ece2ac..19ee49c 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -131,9 +131,10 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 			.indexed = 1,
 			.channel = 0,
 			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SHARED_BIT,
+			IIO_CHAN_INFO_SCALE_SHARED_BIT |
+			IIO_CHAN_INFO_OFFSET_SHARED_BIT,
 			.scan_type = {
-				.sign = 's',
+				.sign = 'u',
 				.realbits = 24,
 				.storagebits = 32,
 				.shift = 8,
@@ -146,9 +147,10 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 			.indexed = 1,
 			.channel = 0,
 			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SHARED_BIT,
+			IIO_CHAN_INFO_SCALE_SHARED_BIT |
+			IIO_CHAN_INFO_OFFSET_SHARED_BIT,
 			.scan_type = {
-				.sign = 's',
+				.sign = 'u',
 				.realbits = 20,
 				.storagebits = 32,
 				.shift = 12,
-- 
1.7.10.4
