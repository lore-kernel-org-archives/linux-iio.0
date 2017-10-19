Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:54068 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751833AbdJSUGh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Oct 2017 16:06:37 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 03/13] staging: iio: tsl2x7x: sort #includes
Date: Thu, 19 Oct 2017 16:06:22 -0400
Message-Id: <20171019200632.25820-4-masneyb@onstation.org>
In-Reply-To: <20171019200632.25820-1-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sort the #include statements for increased code readability.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 094ab76b5d60..d407c3ad7e2f 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -15,14 +15,14 @@
  * more details.
  */
 
-#include <linux/kernel.h>
-#include <linux/i2c.h>
-#include <linux/errno.h>
 #include <linux/delay.h>
-#include <linux/mutex.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/slab.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.13.6

