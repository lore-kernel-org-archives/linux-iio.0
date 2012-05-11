Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] staging:iio:dac: Remove dac.h
Date: Fri, 11 May 2012 19:04:22 +0200
Message-Id: <1336755862-24184-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1336755862-24184-1-git-send-email-lars@metafoo.de>
References: <1336755862-24184-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Now that all drivers have been converted to channel spec, we can finally remove
the dac.h file since it is no longer used.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/dac.h |    6 ------
 1 file changed, 6 deletions(-)
 delete mode 100644 drivers/staging/iio/dac/dac.h

diff --git a/drivers/staging/iio/dac/dac.h b/drivers/staging/iio/dac/dac.h
deleted file mode 100644
index 0754d71..0000000
--- a/drivers/staging/iio/dac/dac.h
+++ /dev/null
@@ -1,6 +0,0 @@
-/*
- * dac.h - sysfs attributes associated with DACs
- */
-
-#define IIO_DEV_ATTR_OUT_RAW(_num, _store, _addr)				\
-	IIO_DEVICE_ATTR(out_voltage##_num##_raw, S_IWUSR, NULL, _store, _addr)
-- 
1.7.10
