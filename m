Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 04/11] staging:iio:kxsd9 remove unnecessary includes
Date: Mon, 24 May 2010 22:02:49 +0100
Message-Id: <1274734976-7941-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
References: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/kxsd9.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index ae7ffe1..79f5795 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -16,17 +16,11 @@
  *		heavily optimized ring buffer access function.
  */
 
-#include <linux/interrupt.h>
-#include <linux/gpio.h>
-#include <linux/fs.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
-#include <linux/rtc.h>
-#include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/string.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
-- 
1.7.0.4
