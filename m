Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 12/14] staging:iio:light:tsl2563 remove unused headers.
Date: Fri, 26 Aug 2011 11:05:46 +0100
Message-Id: <1314353148-6670-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353148-6670-1-git-send-email-jic23@cam.ac.uk>
References: <1314353148-6670-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Guessing this is some ancient cut and paste issue.

Signed-off-by: Jonathan Cammeron <jic23@cam.ac.uk>
---
 drivers/staging/iio/light/tsl2563.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 3493d93..2d01738 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -31,9 +31,7 @@
 #include <linux/sched.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
-#include <linux/platform_device.h>
 #include <linux/pm.h>
-#include <linux/hwmon.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 
-- 
1.7.3.4
