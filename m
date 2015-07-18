Return-Path: <stefan.wahren@i2se.com>
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@gmail.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 3/6] iio: mxs-lradc: add missing include
Date: Sat, 18 Jul 2015 12:30:43 +0000
Message-Id: <1437222646-8742-4-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com>
References: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds the missing include for mutex handling.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/staging/iio/adc/mxs-lradc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 386a44d..763075b 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -26,6 +26,7 @@
 #include <linux/list.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
-- 
1.7.9.5
