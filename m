Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:50299 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758Ab3GFEUc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Jul 2013 00:20:32 -0400
Received: by mail-bk0-f44.google.com with SMTP id 6so1267659bkj.31
        for <linux-iio@vger.kernel.org>; Fri, 05 Jul 2013 21:20:30 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 6 Jul 2013 12:20:30 +0800
Message-ID: <CAPgLHd-Y35AOCRLcjdFfoNrK9v6n7Th_gjB-GAPpwoAe81H63w@mail.gmail.com>
Subject: [PATCH] iio: ti_am335x_adc: add missing .driver_module to struct iio_info
From: Wei Yongjun <weiyj.lk@gmail.com>
To: jic23@cam.ac.uk, gregkh@linuxfoundation.org, sameo@linux.intel.com,
	rachna@ti.com, bigeasy@linutronix.de
Cc: yongjun_wei@trendmicro.com.cn, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add missing .driver_module of struct iio_info. This prevents the
module from being removed from underneath its users.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/iio/adc/ti_am335x_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 5f9a7e7..985f588 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -134,6 +134,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info tiadc_info = {
 	.read_raw = &tiadc_read_raw,
+	.driver_module = THIS_MODULE,
 };
 
 static int tiadc_probe(struct platform_device *pdev)

