Return-Path: <SRS0=Jzh+=HC=vanguardiasur.com.ar=hernan@kernel.org>
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 05/14] staging: iio: ad7746: Reorder includes alphabetically
Date: Fri, 13 Apr 2018 13:36:42 -0300
Message-Id: <1523637411-8531-6-git-send-email-hernan@vanguardiasur.com.ar>
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 82fac76..9ef476a 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -6,15 +6,15 @@
  * Licensed under the GPL-2.
  */
 
-#include <linux/interrupt.h>
+#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/i2c.h>
-#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/stat.h>
+#include <linux/sysfs.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.7.4
