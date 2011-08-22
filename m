Return-Path: <maxin.john@gmail.com>
Date: Mon, 22 Aug 2011 13:08:24 +0300
From: "Maxin B. John" <maxin.john@gmail.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	Bryan Freed <bfreed@chromium.org>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: industrialio-core: Fix compiler warning
Message-ID: <20110822100824.GA6671@maxin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

drivers/staging/iio/industrialio-core.c: In function
'iio_device_add_event_sysfs':
drivers/staging/iio/industrialio-core.c:914: warning: 'mask' may be
used uninitialized in this function

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
---
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 19819e7..83b5953 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -911,7 +911,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 				      struct iio_chan_spec const *chan)
 {
 
-	int ret = 0, i, mask;
+	int ret = 0, i, mask = 0;
 	char *postfix;
 	if (!chan->event_mask)
 		return 0;
@@ -944,6 +944,8 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 			break;
 		default:
 			printk(KERN_INFO "currently unhandled type of event\n");
+			ret = -EINVAL;
+			goto error_ret;
 		}
 		ret = __iio_add_chan_devattr(postfix,
 					     NULL,
