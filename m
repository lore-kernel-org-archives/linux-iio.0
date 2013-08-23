Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:59592 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454Ab3HWCrP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 22 Aug 2013 22:47:15 -0400
MIME-Version: 1.0
Date: Fri, 23 Aug 2013 10:47:13 +0800
Message-ID: <CAPgLHd_cnp+Gm8vSwhB+dmV+bk7Wz8Qh7VbJmY=KdrmfS55fNg@mail.gmail.com>
Subject: [PATCH -next] iio: adc: twl6030-gpadc: fix error return code in twl6030_gpadc_read_raw()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: jic23@cam.ac.uk, grant.likely@linaro.org, rob.herring@calxeda.com,
	oleksandr.kozaruk@ti.com, gg@slimlogic.co.uk, balajitk@ti.com
Cc: yongjun_wei@trendmicro.com.cn, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -EINTR in the error handling case instead
of 0 (ret is assigned after goto, which has no effect),
as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/iio/adc/twl6030-gpadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index a558516..0ea96c0 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -537,8 +537,8 @@ static int twl6030_gpadc_read_raw(struct iio_dev *indio_dev,
 		ret = -ETIMEDOUT;
 		goto err;
 	} else if (timeout < 0) {
-		goto err;
 		ret = -EINTR;
+		goto err;
 	}
 
 	switch (mask) {

