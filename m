Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33211 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbcHPNeI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2016 09:34:08 -0400
Received: by mail-qk0-f173.google.com with SMTP id z190so38586949qkc.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2016 06:34:07 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, stable@vger.kernel.org
Subject: [PATCH 02/17] iio: accel: kxsd9: Fix raw read return
Date: Tue, 16 Aug 2016 15:33:28 +0200
Message-Id: <1471354423-19186-3-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Any readings from the raw interface of the KXSD9 driver will
return an empty string, because it does not return
IIO_VAL_INT but rather some random value from the accelerometer
to the caller.

Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/kxsd9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 3a9f106787d2..da5fb67ecb34 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -160,6 +160,7 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			goto error_ret;
 		*val = ret;
+		ret = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
 		ret = spi_w8r8(st->us, KXSD9_READ(KXSD9_REG_CTRL_C));
-- 
2.7.4

