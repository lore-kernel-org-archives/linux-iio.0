Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-046.synserver.de ([212.40.185.46]:1126 "EHLO
	smtp-out-044.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751829Ab2EULkY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 May 2012 07:40:24 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 14/18] staging:iio:dac:ad5791: Use strtobool for boolean values
Date: Mon, 21 May 2012 13:43:03 +0200
Message-Id: <1337600587-19848-14-git-send-email-lars@metafoo.de>
In-Reply-To: <1337600587-19848-1-git-send-email-lars@metafoo.de>
References: <1337600587-19848-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

