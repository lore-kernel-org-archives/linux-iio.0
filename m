Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:36277 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756466Ab2DJULR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:11:17 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4/6] staging:iio:max1363 enable use with inkernel interfaces.
Date: Tue, 10 Apr 2012 21:11:07 +0100
Message-Id: <1334088669-21032-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1334088669-21032-1-git-send-email-jic23@kernel.org>
References: <1334088669-21032-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/max1363_core.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 2536b63..9d7db7f 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -36,6 +36,7 @@
 #include "../sysfs.h"
 #include "../events.h"
 #include "../buffer.h"
+#include "../driver.h"
 
 #include "max1363.h"
 
@@ -1290,6 +1291,9 @@ static int __devinit max1363_probe(struct i2c_client *client,
 		ret = -ENOMEM;
 		goto error_disable_reg;
 	}
+	ret = iio_map_array_register(indio_dev, client->dev.platform_data);
+	if (ret < 0)
+		goto error_free_device;
 	st = iio_priv(indio_dev);
 	st->reg = reg;
 	/* this is only used for device removal purposes */
@@ -1300,7 +1304,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 
 	ret = max1363_alloc_scan_masks(indio_dev);
 	if (ret)
-		goto error_free_device;
+		goto error_unregister_map;
 
 	/* Estabilish that the iio_dev is a child of the i2c device */
 	indio_dev->dev.parent = &client->dev;
@@ -1350,6 +1354,8 @@ error_cleanup_ring:
 	max1363_ring_cleanup(indio_dev);
 error_free_available_scan_masks:
 	kfree(indio_dev->available_scan_masks);
+error_unregister_map:
+	iio_map_array_unregister(indio_dev, client->dev.platform_data);
 error_free_device:
 	iio_free_device(indio_dev);
 error_disable_reg:
@@ -1376,6 +1382,7 @@ static int max1363_remove(struct i2c_client *client)
 		regulator_disable(reg);
 		regulator_put(reg);
 	}
+	iio_map_array_unregister(indio_dev, client->dev.platform_data);
 	iio_free_device(indio_dev);
 
 	return 0;
-- 
1.7.9.4

