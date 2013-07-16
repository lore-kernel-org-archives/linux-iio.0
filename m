Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-236.synserver.de ([212.40.185.236]:1196 "EHLO
	smtp-out-236.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab3GPPHX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 11:07:23 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] iio: Remove IIO_DEV_ATTR_RESET macro
Date: Tue, 16 Jul 2013 17:08:03 +0200
Message-Id: <1373987283-32657-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1373987283-32657-1-git-send-email-lars@metafoo.de>
References: <1373987283-32657-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There are no users of this macro left and we have come to the conclusion that it
is not a good idea to expose the raw chip reset to userspace so the macro is
very unlikely to be used in new drivers.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/iio/sysfs.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index b7a934b..2958c96 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -73,11 +73,6 @@ struct iio_const_attr {
 	    .dev_attr = __ATTR(_name, S_IRUGO, iio_read_const_attr, NULL)}
 
 /* Generic attributes of onetype or another */
-/**
- * IIO_DEV_ATTR_RESET: resets the device
- **/
-#define IIO_DEV_ATTR_RESET(_store)			\
-	IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, _store, 0)
 
 /**
  * IIO_DEV_ATTR_SAMP_FREQ - sets any internal clock frequency
-- 
1.8.0

