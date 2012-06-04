Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/18] staging:iio:dac:ad5504: Use strtobool for boolean values
Date: Mon,  4 Jun 2012 11:36:22 +0200
Message-Id: <1338802588-10585-12-git-send-email-lars@metafoo.de>
In-Reply-To: <1338802588-10585-1-git-send-email-lars@metafoo.de>
References: <1338802588-10585-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Use strtobool for parsing the powerdown value instead of strict_strtol, since
the powerdown attribute is a boolean value.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/dac/ad5504.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index 331b536..220150d 100644
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
