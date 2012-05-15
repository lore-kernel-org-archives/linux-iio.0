Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] staging:iio:dac:ad5504: Use strtobool for boolean values
Date: Tue, 15 May 2012 09:52:43 +0200
Message-Id: <1337068365-23971-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Use strtobool for parsing the powerdown value instead of strict_strtol, since
the powerdown attribute is a boolean value.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5504.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index 25a04d3..6ccf178 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -147,20 +147,18 @@ static ssize_t ad5504_write_dac_powerdown(struct iio_dev *indio_dev,
 	uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
 	size_t len)
 {
-	long readin;
+	bool pwr_down;
 	int ret;
 	struct ad5504_state *st = iio_priv(indio_dev);
 
-	ret = strict_strtol(buf, 10, &readin);
+	ret = strtobool(buf, &pwr_down);
 	if (ret)
 		return ret;
 
-	if (readin == 0)
+	if (pwr_down)
 		st->pwr_down_mask |= (1 << chan->channel);
-	else if (readin == 1)
-		st->pwr_down_mask &= ~(1 << chan->channel);
 	else
-		ret = -EINVAL;
+		st->pwr_down_mask &= ~(1 << chan->channel);
 
 	ret = ad5504_spi_write(st->spi, AD5504_ADDR_CTRL,
 				AD5504_DAC_PWRDWN_MODE(st->pwr_down_mode) |
-- 
1.7.10
