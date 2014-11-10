Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:64846 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbaKJIEL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Nov 2014 03:04:11 -0500
Received: by mail-pd0-f177.google.com with SMTP id v10so7331277pde.36
        for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2014 00:04:11 -0800 (PST)
Message-ID: <1415606646.23695.0.camel@phoenix>
Subject: [PATCH] iio: adc: men_z188_adc: Add terminating entry for
 men_z188_ids
From: Axel Lin <axel.lin@ingics.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Johannes Thumshirn <johannes.thumshirn@men.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Mon, 10 Nov 2014 16:04:06 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The mcb_device_id table is supposed to be zero-terminated.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/iio/adc/men_z188_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
index b58d630..d095efe 100644
--- a/drivers/iio/adc/men_z188_adc.c
+++ b/drivers/iio/adc/men_z188_adc.c
@@ -152,6 +152,7 @@ static void men_z188_remove(struct mcb_device *dev)
 
 static const struct mcb_device_id men_z188_ids[] = {
 	{ .device = 0xbc },
+	{ }
 };
 MODULE_DEVICE_TABLE(mcb, men_z188_ids);
 
-- 
1.9.1



