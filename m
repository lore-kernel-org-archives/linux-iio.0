Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:61115 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752213AbdC0KIW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2017 06:08:22 -0400
Date: Mon, 27 Mar 2017 12:06:47 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linus.walleij@linaro.org, ddvlad@gmail.com,
        akinobu.mita@gmail.com, yongjun_wei@trendmicro.com.cn,
        a.mathur@samsung.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IIO: bmp280-core.c: fix error in humidity calculation
Message-ID: <20170327100646.GA8128@project>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

While calculating the compensation of the humidity there are negative
values interpreted as unsigned because of unsigned variables used.
These values need to be casted to signed as indicated by the documentation
of the sensor.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/pressure/bmp280-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 4d18826ac63c..73308f0ea260 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -177,9 +177,9 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
 
 	var = ((s32)data->t_fine) - 76800;
 	var = ((((adc_humidity << 14) - (H4 << 20) - (H5 * var)) + 16384) >> 15)
-		* (((((((var * H6) >> 10) * (((var * H3) >> 11) + 32768)) >> 10)
-		+ 2097152) * H2 + 8192) >> 14);
-	var -= ((((var >> 15) * (var >> 15)) >> 7) * H1) >> 4;
+		* (((((((var * H6) >> 10) * (((var * (s32)H3) >> 11) + 32768))
+		>> 10) + 2097152) * H2 + 8192) >> 14);
+	var -= ((((var >> 15) * (var >> 15)) >> 7) * (s32)H1) >> 4;
 
 	return var >> 12;
 };
-- 
2.1.4


-- 
