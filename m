Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35825 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030356AbeE1PlW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 May 2018 11:41:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id o78-v6so33235707wmg.0
        for <linux-iio@vger.kernel.org>; Mon, 28 May 2018 08:41:21 -0700 (PDT)
From: Tomasz Duszynski <tduszyns@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, linus.walleij@linaro.org
Subject: [PATCH] iio: pressure: bmp280: fix relative humidity unit
Date: Mon, 28 May 2018 17:38:59 +0200
Message-Id: <20180528153859.813-1-tduszyns@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

According to IIO ABI relative humidity reading should be
returned in milli percent.

This patch addresses that by applying proper scaling and
returning integer instead of fractional format type specifier.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 5ec3e41b65f2..fe87d27779d9 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -415,10 +415,9 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	}
 	comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
 
-	*val = comp_humidity;
-	*val2 = 1024;
+	*val = comp_humidity * 1000 / 1024;
 
-	return IIO_VAL_FRACTIONAL;
+	return IIO_VAL_INT;
 }
 
 static int bmp280_read_raw(struct iio_dev *indio_dev,
-- 
2.17.0

