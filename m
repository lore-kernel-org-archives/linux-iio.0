Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 3/6] IIO-work: meter: ade7758: Fix return value of ade7758_write_reset
Date: Wed, 11 May 2011 16:26:57 +0200
Message-ID: <1305124020-2526-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1305124020-2526-1-git-send-email-michael.hennerich@analog.com>
References: <1305124020-2526-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Update file comment/license header.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
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
1.6.0.2
