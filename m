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
Subject: [PATCH 4/6] iio: mxs-lradc: remove unnecessary header includes
Date: Sat, 18 Jul 2015 12:30:44 +0000
Message-Id: <1437222646-8742-5-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com>
References: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com>
List-ID: <linux-iio@vger.kernel.org>

This patch removes the unnecessary header includes.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/staging/iio/adc/mxs-lradc.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 763075b..21b0ccf 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -23,18 +23,13 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
-#include <linux/spinlock.h>
-#include <linux/wait.h>
-#include <linux/sched.h>
 #include <linux/stmp_device.h>
 #include <linux/bitops.h>
 #include <linux/completion.h>
-#include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/clk.h>
 
-- 
1.7.9.5
