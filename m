Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:54084 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933239Ab1ERNkH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2011 09:40:07 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 075/111] iio:staging:meter:ade7758: Fix return value of ade7758_write_reset
Date: Wed, 18 May 2011 14:42:05 +0100
Message-Id: <1305726161-5606-76-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Update file comment/license header.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/meter/ade7758_core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 8cfb617..971b247 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -1,9 +1,9 @@
 /*
- * ADE7758 Polyphase Multifunction Energy Metering IC Driver
+ * ADE7758 Poly Phase Multifunction Energy Metering IC driver
  *
- * Copyright 2010 Analog Devices Inc.
+ * Copyright 2010-2011 Analog Devices Inc.
  *
- * Licensed under the GPL-2 or later.
+ * Licensed under the GPL-2.
  */
 
 #include <linux/interrupt.h>
@@ -342,7 +342,7 @@ static ssize_t ade7758_write_reset(struct device *dev,
 	case 'Y':
 		return ade7758_reset(dev);
 	}
-	return -1;
+	return len;
 }
 
 static IIO_DEV_ATTR_VPEAK(S_IWUSR | S_IRUGO,
-- 
1.7.3.4

