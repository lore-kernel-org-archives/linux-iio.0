Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36512 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbcFQNWe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2016 09:22:34 -0400
Received: by mail-lf0-f45.google.com with SMTP id q132so60238629lfe.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2016 06:22:33 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: accel: kxsd9: fix the usage of spi_w8r8()
Date: Fri, 17 Jun 2016 15:22:24 +0200
Message-Id: <1466169744-23214-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These two spi_w8r8() calls return a value with is used by the code
following the error check. The dubious use was caused by a cleanup
patch.

Fixes: d34dbee8ac8e ("staging:iio:accel:kxsd9 cleanup and conversion to iio_chan_spec.")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Jonathan: I suspect the driver was never tested after the cleanup?
I'm trying to use the driver to bolt on I2C support, but I'm a bit
suspicious that it's not really working for SPI even.
---
 drivers/iio/accel/kxsd9.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 923f56598d4b..3a9f106787d2 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -81,7 +81,7 @@ static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
 
 	mutex_lock(&st->buf_lock);
 	ret = spi_w8r8(st->us, KXSD9_READ(KXSD9_REG_CTRL_C));
-	if (ret)
+	if (ret < 0)
 		goto error_ret;
 	st->tx[0] = KXSD9_WRITE(KXSD9_REG_CTRL_C);
 	st->tx[1] = (ret & ~KXSD9_FS_MASK) | i;
@@ -163,7 +163,7 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
 		break;
 	case IIO_CHAN_INFO_SCALE:
 		ret = spi_w8r8(st->us, KXSD9_READ(KXSD9_REG_CTRL_C));
-		if (ret)
+		if (ret < 0)
 			goto error_ret;
 		*val2 = kxsd9_micro_scales[ret & KXSD9_FS_MASK];
 		ret = IIO_VAL_INT_PLUS_MICRO;
-- 
2.4.11

