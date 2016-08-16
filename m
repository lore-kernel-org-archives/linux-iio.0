Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35829 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684AbcHPNel (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2016 09:34:41 -0400
Received: by mail-qk0-f173.google.com with SMTP id v123so70414982qkh.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2016 06:34:40 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 10/17] iio: accel: kxsd9: Fix scaling bug
Date: Tue, 16 Aug 2016 15:33:36 +0200
Message-Id: <1471354423-19186-11-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
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

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/kxsd9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index a8ee041dd4e4..14d949a4caf9 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -146,6 +146,7 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
 				  &regval);
 		if (ret < 0)
 			goto error_ret;
+		*val = 0;
 		*val2 = kxsd9_micro_scales[regval & KXSD9_FS_MASK];
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
-- 
2.7.4

