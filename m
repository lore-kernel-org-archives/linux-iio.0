Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 14/18] staging:iio:dac:ad5791: Use strtobool for boolean values
Date: Mon,  4 Jun 2012 11:36:24 +0200
Message-Id: <1338802588-10585-14-git-send-email-lars@metafoo.de>
In-Reply-To: <1338802588-10585-1-git-send-email-lars@metafoo.de>
References: <1338802588-10585-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Use strtobool for parsing the powerdown value instead of strict_strtol, since
the powerdown attribute is a boolean value.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/dac/ad5791.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index 4e955ed..82b51a7 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -114,25 +114,23 @@ static ssize_t ad5791_write_dac_powerdown(struct iio_dev *indio_dev,
 	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
 	 size_t len)
 {
-	long readin;
+	bool pwr_down;
 	int ret;
 	struct ad5791_state *st = iio_priv(indio_dev);
 
-	ret = strict_strtol(buf, 10, &readin);
+	ret = strtobool(buf, &pwr_down);
 	if (ret)
 		return ret;
 
-	if (readin == 0) {
-		st->pwr_down = false;
+	if (!pwr_down) {
 		st->ctrl &= ~(AD5791_CTRL_OPGND | AD5791_CTRL_DACTRI);
-	} else if (readin == 1) {
-		st->pwr_down = true;
+	} else {
 		if (st->pwr_down_mode == AD5791_DAC_PWRDN_6K)
 			st->ctrl |= AD5791_CTRL_OPGND;
 		else if (st->pwr_down_mode == AD5791_DAC_PWRDN_3STATE)
 			st->ctrl |= AD5791_CTRL_DACTRI;
-	} else
-		ret = -EINVAL;
+	}
+	st->pwr_down = pwr_down;
 
 	ret = ad5791_spi_write(st->spi, AD5791_ADDR_CTRL, st->ctrl);
 
-- 
1.7.10
