Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:45637 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab2K2C12 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Nov 2012 21:27:28 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so10373868qcr.19
        for <linux-iio@vger.kernel.org>; Wed, 28 Nov 2012 18:27:27 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 28 Nov 2012 21:27:27 -0500
Message-ID: <CAPgLHd_faAe1PsFWX9pF91YCZ8p37b39JJ8sP7bFDX0JhODm1A@mail.gmail.com>
Subject: [PATCH -next] iio: gyro: adis16136: remove duplicated include from adis16136.c
From: Wei Yongjun <weiyj.lk@gmail.com>
To: jic23@cam.ac.uk
Cc: yongjun_wei@trendmicro.com.cn, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/iio/gyro/adis16136.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index 05486df..4d60643 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -22,7 +22,6 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/imu/adis.h>
 
-#include <linux/iio/iio.h>
 #include <linux/debugfs.h>
 
 #define ADIS16136_REG_FLASH_CNT		0x00


