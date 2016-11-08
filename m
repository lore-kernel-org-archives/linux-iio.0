Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47268 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753106AbcKHK1P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Nov 2016 05:27:15 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v2 22/23] staging: iio: tsl2583: updated copyright and MODULE_AUTHOR
Date: Tue,  8 Nov 2016 05:16:47 -0500
Message-Id: <1478600208-21153-23-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
References: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added Brian Masney's copyright to the header and to the MODULE_AUTHOR
for all of the staging cleanups that has been done to this driver.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 013e7f6..5cb4ae3 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -3,6 +3,7 @@
  * within the TAOS tsl258x family of devices (tsl2580, tsl2581).
  *
  * Copyright (c) 2011, TAOS Corporation.
+ * Copyright (c) 2016 Brian Masney <masneyb@onstation.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -910,6 +911,6 @@ static struct i2c_driver tsl2583_driver = {
 };
 module_i2c_driver(tsl2583_driver);
 
-MODULE_AUTHOR("J. August Brenner<jbrenner@taosinc.com>");
+MODULE_AUTHOR("J. August Brenner <jbrenner@taosinc.com> and Brian Masney <masneyb@onstation.org>");
 MODULE_DESCRIPTION("TAOS tsl2583 ambient light sensor driver");
 MODULE_LICENSE("GPL");
-- 
2.7.4

