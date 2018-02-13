Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50180 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965935AbeBMWiC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Feb 2018 17:38:02 -0500
Received: by mail-wm0-f68.google.com with SMTP id k87so1154946wmi.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2018 14:38:01 -0800 (PST)
From: Richard Lai <richard@richardman.com>
Cc: richard@richardman.com, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: chemical: ccs811: Typo correction in HW_ID_VALUE constant define naming
Date: Tue, 13 Feb 2018 22:36:57 +0000
Message-Id: <1518561421-11736-1-git-send-email-richard@richardman.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This particular constant was named with prefix "CCS881", which should be
"CCS811" instead, just like the rest of constant names in the file, as this
driver implementation is for AMS CCS811 sensor. "CCS881" could literally be
referring to another sensor product unrelated to AMS CCS811 sensor.

Signed-off-by: Richard Lai <richard@richardman.com>
---
 drivers/iio/chemical/ccs811.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 840a6cb..8e8beb7 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -31,7 +31,7 @@
 #define CCS811_ALG_RESULT_DATA	0x02
 #define CCS811_RAW_DATA		0x03
 #define CCS811_HW_ID		0x20
-#define CCS881_HW_ID_VALUE	0x81
+#define CCS811_HW_ID_VALUE	0x81
 #define CCS811_HW_VERSION	0x21
 #define CCS811_HW_VERSION_VALUE	0x10
 #define CCS811_HW_VERSION_MASK	0xF0
@@ -315,7 +315,7 @@ static int ccs811_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	if (ret != CCS881_HW_ID_VALUE) {
+	if (ret != CCS811_HW_ID_VALUE) {
 		dev_err(&client->dev, "hardware id doesn't match CCS81x\n");
 		return -ENODEV;
 	}
-- 
2.7.4

