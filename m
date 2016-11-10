Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:50662 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754540AbcKJJ03 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Nov 2016 04:26:29 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v3 27/28] staging: iio: tsl2583: add copyright and MODULE_AUTHOR
Date: Thu, 10 Nov 2016 04:26:03 -0500
Message-Id: <1478769964-7065-28-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add Brian Masney's copyright to the header and to the MODULE_AUTHOR
for all of the staging cleanups that has been done to this driver.

The original MODULE_AUTHOR() did not have a space between his name and
email address. This patch also adds the missing space.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 13cf88a..b6da79b 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -3,6 +3,7 @@
  * within the TAOS tsl258x family of devices (tsl2580, tsl2581, tsl2583).
  *
  * Copyright (c) 2011, TAOS Corporation.
+ * Copyright (c) 2016 Brian Masney <masneyb@onstation.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -902,6 +903,7 @@ static struct i2c_driver tsl2583_driver = {
 };
 module_i2c_driver(tsl2583_driver);
 
-MODULE_AUTHOR("J. August Brenner<jbrenner@taosinc.com>");
+MODULE_AUTHOR("J. August Brenner <jbrenner@taosinc.com>");
+MODULE_AUTHOR("Brian Masney <masneyb@onstation.org>");
 MODULE_DESCRIPTION("TAOS tsl2583 ambient light sensor driver");
 MODULE_LICENSE("GPL");
-- 
2.7.4

