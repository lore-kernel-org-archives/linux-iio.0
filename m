Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 04/11] staging:iio:dac:ad5446: Remove unused struct field
Date: Tue, 24 Apr 2012 18:49:34 +0200
Message-Id: <1335286181-20474-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1335286181-20474-1-git-send-email-lars@metafoo.de>
References: <1335286181-20474-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Remove the unused "poll_work" field from the ad5446_state struct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/dac/ad5446.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
index f9fff71..29aa0dc 100644
--- a/drivers/staging/iio/dac/ad5446.h
+++ b/drivers/staging/iio/dac/ad5446.h
@@ -34,7 +34,6 @@
  * @spi:		spi_device
  * @chip_info:		chip model specific constants, available modes etc
  * @reg:		supply regulator
- * @poll_work:		bottom half of polling interrupt handler
  * @vref_mv:		actual reference voltage used
  */
 
@@ -42,7 +41,6 @@ struct ad5446_state {
 	struct spi_device		*spi;
 	const struct ad5446_chip_info	*chip_info;
 	struct regulator		*reg;
-	struct work_struct		poll_work;
 	unsigned short			vref_mv;
 	unsigned			cached_val;
 	unsigned			pwr_down_mode;
-- 
1.7.9.5
