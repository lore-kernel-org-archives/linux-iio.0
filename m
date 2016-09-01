Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34723 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbcIAJo4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Sep 2016 05:44:56 -0400
Received: by mail-lf0-f52.google.com with SMTP id p41so37727348lfi.1
        for <linux-iio@vger.kernel.org>; Thu, 01 Sep 2016 02:44:56 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, stable@vger.kernel.org
Subject: [PATCH 01/15 v2] iio: accel: kxsd9: Fix scaling bug
Date: Thu,  1 Sep 2016 11:44:35 +0200
Message-Id: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

All the scaling of the KXSD9 involves multiplication with a
fraction number < 1.

However the scaling value returned from IIO_INFO_SCALE was
unpredictable as only the micros of the value was assigned, and
not the integer part, resulting in scaling like this:

$cat in_accel_scale
-1057462640.011978

Fix this by assigning zero to the integer part.

Cc: stable@vger.kernel.org
Tested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Move this first in the series as Jonathan's request.
---
 drivers/iio/accel/kxsd9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index da5fb67ecb34..9d72d4bcf5e9 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -166,6 +166,7 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
 		ret = spi_w8r8(st->us, KXSD9_READ(KXSD9_REG_CTRL_C));
 		if (ret < 0)
 			goto error_ret;
+		*val = 0;
 		*val2 = kxsd9_micro_scales[ret & KXSD9_FS_MASK];
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
-- 
2.7.4

