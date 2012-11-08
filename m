Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:43844 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab2KHJFY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 8 Nov 2012 04:05:24 -0500
Received: by mail-qa0-f53.google.com with SMTP id k31so1114458qat.19
        for <linux-iio@vger.kernel.org>; Thu, 08 Nov 2012 01:05:23 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 8 Nov 2012 17:05:23 +0800
Message-ID: <CAPgLHd873xAvToL7reBbxmS-iEoJ9OqvjEoXf8RsG2esbTyo1A@mail.gmail.com>
Subject: [PATCH -next] iio: isl29018: fix to return error or 0 in isl29018_write_raw()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: jic23@cam.ac.uk, gregkh@linuxfoundation.org,
	grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

We had assigned the return value to 'ret' but ignored it when
return from isl29018_write_raw(), it's better to return 'ret'
instead of 0.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/staging/iio/light/isl29018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 3b03f6f..1d5b294 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -356,7 +356,7 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
 	}
 	mutex_unlock(&chip->lock);
 
-	return 0;
+	return ret;
 }
 
 static int isl29018_read_raw(struct iio_dev *indio_dev,


