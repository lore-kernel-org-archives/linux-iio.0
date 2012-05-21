Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/18] staging:iio:dac:ad5624r: Use strtobool for boolean values
Date: Mon, 21 May 2012 13:43:02 +0200
Message-Id: <1337600587-19848-13-git-send-email-lars@metafoo.de>
In-Reply-To: <1337600587-19848-1-git-send-email-lars@metafoo.de>
References: <1337600587-19848-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Use strtobool for parsing the powerdown value instead of strict_strtol, since
the powerdown attribute is a boolean value.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/dac/ad5624r_spi.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index 7524f96..6a7d6a4 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -132,20 +132,18 @@ static ssize_t ad5624r_write_dac_powerdown(struct iio_dev *indio_dev,
 	uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
 	size_t len)
 {
-	long readin;
+	bool pwr_down;
 	int ret;
 	struct ad5624r_state *st = iio_priv(indio_dev);
 
-	ret = strict_strtol(buf, 10, &readin);
+	ret = strtobool(buf, &pwr_down);
 	if (ret)
 		return ret;
 
-	if (readin == 1)
+	if (pwr_down)
 		st->pwr_down_mask |= (1 << chan->channel);
-	else if (!readin)
-		st->pwr_down_mask &= ~(1 << chan->channel);
 	else
-		ret = -EINVAL;
+		st->pwr_down_mask &= ~(1 << chan->channel);
 
 	ret = ad5624r_spi_write(st->us, AD5624R_CMD_POWERDOWN_DAC, 0,
 				(st->pwr_down_mode << 4) |
-- 
1.7.10
