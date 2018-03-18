Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52541 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752372AbeCRNe0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Mar 2018 09:34:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id l9so1593906wmh.2
        for <linux-iio@vger.kernel.org>; Sun, 18 Mar 2018 06:34:25 -0700 (PDT)
Date: Sun, 18 Mar 2018 14:34:22 +0100
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 01/11] staging: iio: ad2s1200: Sort includes alphabetically
Message-ID: <6b1856cf986b94edc3c330a46295edad303f02ce.1521379685.git.davidjulianveenstra@gmail.com>
References: <cover.1521379685.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521379685.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patches sorts all the includes in alphabetic order.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1200.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index aa62c64e9bc4..7a5b2d1927d6 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -9,16 +9,16 @@
  * published by the Free Software Foundation.
  *
  */
-#include <linux/types.h>
-#include <linux/mutex.h>
-#include <linux/device.h>
-#include <linux/spi/spi.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
-#include <linux/bitops.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.16.2

