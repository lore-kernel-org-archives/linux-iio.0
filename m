Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org,
	gregkh@linuxfoundation.org,
	jic23@cam.ac.uk,
	sachin.kamat@linaro.org,
	patches@linaro.org
Subject: [PATCH] staging: iio: Remove version.h header file inclusion
Date: Mon,  4 Jun 2012 11:34:49 +0530
Message-Id: <1338789889-14049-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

version.h header file is no longer required.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/light/tsl2x7x_core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index c3b05a1..040da4a 100755
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -27,7 +27,6 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
1.7.4.1
