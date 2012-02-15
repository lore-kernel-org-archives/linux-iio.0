Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: greg@kroah.com,
	guenter.roeck@ericsson.com,
	khali@linux-fr.org,
	dmitry.torokhov@gmail.com,
	broonie@opensource.wolfsonmicro.com,
	alan@lxorguk.ukuu.org.uk,
	arnd@arndb.de,
	linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com,
	zdevai@gmail.com,
	w.sang@pengutronix.de,
	marek.vasut@gmail.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 5.5/6] staging:iio:max1363 enable use with inkernel interfaces.
Date: Wed, 15 Feb 2012 21:11:59 +0000
Message-Id: <1329340319-3569-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1329335285-31006-1-git-send-email-jic23@kernel.org>
References: <1329335285-31006-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
Oops patch 6 doesn't make much sense without this driver support.

 drivers/staging/iio/adc/max1363_core.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 3a5bd20..29ab0aa 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -36,6 +36,7 @@
 #include "../sysfs.h"
 #include "../events.h"
 #include "../buffer.h"
+#include "../driver.h"
 
 #include "max1363.h"
 
@@ -1268,6 +1269,9 @@ static int __devinit max1363_probe(struct i2c_client *client,
 		ret = -ENOMEM;
 		goto error_disable_reg;
 	}
+	ret = iio_map_array_register(indio_dev, client->dev.platform_data);
+	if (ret < 0)
+		goto error_free_device;
 	st = iio_priv(indio_dev);
 	st->reg = reg;
 	/* this is only used for device removal purposes */
@@ -1281,7 +1285,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 			  (st->chip_info->num_modes + 1), GFP_KERNEL);
 	if (!indio_dev->available_scan_masks) {
 		ret = -ENOMEM;
-		goto error_free_device;
+		goto error_unregister_map;
 	}
 
 	for (i = 0; i < st->chip_info->num_modes; i++)
@@ -1337,6 +1341,8 @@ error_cleanup_ring:
 	max1363_ring_cleanup(indio_dev);
 error_free_available_scan_masks:
 	kfree(indio_dev->available_scan_masks);
+error_unregister_map:
+	iio_map_array_unregister(indio_dev, client->dev.platform_data);
 error_free_device:
 	iio_free_device(indio_dev);
 error_disable_reg:
@@ -1363,6 +1369,7 @@ static int max1363_remove(struct i2c_client *client)
 		regulator_disable(reg);
 		regulator_put(reg);
 	}
+	iio_map_array_unregister(indio_dev, client->dev.platform_data);
 	iio_free_device(indio_dev);
 
 	return 0;
-- 
1.7.8.4
