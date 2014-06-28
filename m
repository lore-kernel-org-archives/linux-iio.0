Return-Path: <guillaume@morinfr.org>
From: Guillaume Morin <guillaume@morinfr.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sachin Kamat <sachin.kamat@linaro.org>
Cc: Guillaume Morin <guillaume@morinfr.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] staging: iio: ad9850.c: fix checkpatch.pl error
Date: Sat, 28 Jun 2014 03:27:38 +0200
Message-Id: <4d0e6b74dcc10ef5d60c9cab4f2df886782fb3c3.1403918673.git.guillaume@morinfr.org>
List-ID: <linux-iio@vger.kernel.org>


diff --git a/drivers/staging/iio/frequency/ad9850.c b/drivers/staging/iio/frequency/ad9850.c
index af877ff..6183670 100644
--- a/drivers/staging/iio/frequency/ad9850.c
+++ b/drivers/staging/iio/frequency/ad9850.c
@@ -21,7 +21,7 @@
 
 #define DRV_NAME "ad9850"
 
-#define value_mask (u16)0xf000
+#define value_mask ((u16)0xf000)
 #define addr_shift 12
 
 /* Register format: 4 bits addr + 12 bits value */
-- 
1.7.10.4
