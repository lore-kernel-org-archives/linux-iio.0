Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:33124 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab3JLGqR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 02:46:17 -0400
Received: by mail-bk0-f42.google.com with SMTP id my10so1901647bkb.15
        for <linux-iio@vger.kernel.org>; Fri, 11 Oct 2013 23:46:15 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 12 Oct 2013 14:46:15 +0800
Message-ID: <CAPgLHd_jFVRUj4RYUi_Z-bw=+zM+YrKbvRPz-Dhiw0eCuQXKDw@mail.gmail.com>
Subject: [PATCH] iio: frequency: adf4350: add missing clk_disable_unprepare()
 on error in adf4350_probe()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: jic23@cam.ac.uk, lars@metafoo.de, michael.hennerich@analog.com,
	gregkh@linuxfoundation.org, sachin.kamat@linaro.org
Cc: yongjun_wei@trendmicro.com.cn, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing clk_disable_unprepare() before return
from adf4350_probe() in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/iio/frequency/adf4350.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index a7b30be..52605c0 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -525,8 +525,10 @@ static int adf4350_probe(struct spi_device *spi)
 	}
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (indio_dev == NULL)
-		return -ENOMEM;
+	if (indio_dev == NULL) {
+		ret =  -ENOMEM;
+		goto error_disable_clk;
+	}
 
 	st = iio_priv(indio_dev);
 

