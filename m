Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54880 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757250Ab3EGLv5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 7 May 2013 07:51:57 -0400
Received: by mail-bk0-f46.google.com with SMTP id w5so237888bku.5
        for <linux-iio@vger.kernel.org>; Tue, 07 May 2013 04:51:56 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 7 May 2013 19:51:56 +0800
Message-ID: <CAPgLHd-yecqmE_v5oawQ_K_7e-em=369G7VYjPi-v3bREnwWHA@mail.gmail.com>
Subject: [PATCH] staging:iio:light:tsl2x7x: fix the error handling in tsl2x7x_probe()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: jic23@cam.ac.uk, gregkh@linuxfoundation.org, lars@metafoo.de,
	wfp5p@virginia.edu, pmeerw@pmeerw.net
Cc: yongjun_wei@trendmicro.com.cn, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -EINVAL in the i2c device found error handling
case instead of 0, as done elsewhere in this function.
And also correct the fail1 and fail2 lable to do the right thing.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/staging/iio/light/tsl2x7x_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index d060f25..c99f890 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -1869,6 +1869,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 		dev_info(&chip->client->dev,
 				"%s: i2c device found does not match expected id\n",
 				__func__);
+		ret = -EINVAL;
 		goto fail1;
 	}
 
@@ -1907,7 +1908,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 		if (ret) {
 			dev_err(&clientp->dev,
 				"%s: irq request failed", __func__);
-			goto fail2;
+			goto fail1;
 		}
 	}
 
@@ -1920,17 +1921,17 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
 	if (ret) {
 		dev_err(&clientp->dev,
 			"%s: iio registration failed\n", __func__);
-		goto fail1;
+		goto fail2;
 	}
 
 	dev_info(&clientp->dev, "%s Light sensor found.\n", id->name);
 
 	return 0;
 
-fail1:
+fail2:
 	if (clientp->irq)
 		free_irq(clientp->irq, indio_dev);
-fail2:
+fail1:
 	iio_device_free(indio_dev);
 
 	return ret;

