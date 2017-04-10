Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:53633 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932795AbdDJRAo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Apr 2017 13:00:44 -0400
Date: Mon, 10 Apr 2017 19:00:01 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: Jonathan Cameron <jic23@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Vlad Dogaru <ddvlad@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        Aniroop Mathur <a.mathur@samsung.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] IIO: bmp280-core.c: fix error in humidity calculation
Message-ID: <20170410170001.GA2524@project>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

While calculating the compensation of the humidity there are negative values
interpreted as unsigned because of unsigned variables used.  These values as
well as the constants need to be casted to signed as indicated by the
documentation of the sensor.

Changes in v2:
- cast also constants to signed; otherwise calculation is not correct

I removed the Acked-By of Linus Walleij because of another change in the
calculation. Don't know how it should be treated.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/pressure/bmp280-core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 4d18826ac63c..d82b788374b6 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -175,11 +175,12 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
 	}
 	H6 = sign_extend32(tmp, 7);
 
-	var = ((s32)data->t_fine) - 76800;
-	var = ((((adc_humidity << 14) - (H4 << 20) - (H5 * var)) + 16384) >> 15)
-		* (((((((var * H6) >> 10) * (((var * H3) >> 11) + 32768)) >> 10)
-		+ 2097152) * H2 + 8192) >> 14);
-	var -= ((((var >> 15) * (var >> 15)) >> 7) * H1) >> 4;
+	var = ((s32)data->t_fine) - (s32)76800;
+	var = ((((adc_humidity << 14) - (H4 << 20) - (H5 * var))
+		+ (s32)16384) >> 15) * (((((((var * H6) >> 10)
+		* (((var * (s32)H3) >> 11) + (s32)32768)) >> 10)
+		+ (s32)2097152) * H2 + 8192) >> 14);
+	var -= ((((var >> 15) * (var >> 15)) >> 7) * (s32)H1) >> 4;
 
 	return var >> 12;
 };
-- 
2.1.4


-- 
