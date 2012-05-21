Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-046.synserver.de ([212.40.185.46]:1049 "EHLO
	smtp-out-044.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753036Ab2EULkU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 May 2012 07:40:20 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/18] staging:iio:dac: Remove dac.h
Date: Mon, 21 May 2012 13:43:00 +0200
Message-Id: <1337600587-19848-11-git-send-email-lars@metafoo.de>
In-Reply-To: <1337600587-19848-1-git-send-email-lars@metafoo.de>
References: <1337600587-19848-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Now that all drivers have been converted to channel spec, we can finally remove
the dac.h file since it is no longer used.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
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

