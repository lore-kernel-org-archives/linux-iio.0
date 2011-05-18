Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:54043 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933224Ab1ERNkG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2011 09:40:06 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 061/111] staging:iio:adc:ad7887: Use private data space from iio_allocate_device
Date: Wed, 18 May 2011 14:41:51 +0100
Message-Id: <1305726161-5606-62-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7887.h      |    1 -
 drivers/staging/iio/adc/ad7887_core.c |   83 ++++++++++++++------------------
 drivers/staging/iio/adc/ad7887_ring.c |    5 +--
 3 files changed, 37 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7887.h b/drivers/staging/iio/adc/ad7887.h
index a0c3742..837046c 100644
--- a/drivers/staging/iio/adc/ad7887.h
+++ b/drivers/staging/iio/adc/ad7887.h
@@ -60,7 +60,6 @@ struct ad7887_chip_info {
 };
 
 struct ad7887_state {
-	struct iio_dev			*indio_dev;
 	struct spi_device		*spi;
 	const struct ad7887_chip_info	*chip_info;
 	struct regulator		*reg;
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index f394215..6773fe1 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -6,13 +6,10 @@
  * Licensed under the GPL-2.
  */
 
-#include <linux/interrupt.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
@@ -90,13 +87,13 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 {
 	struct ad7887_platform_data *pdata = spi->dev.platform_data;
 	struct ad7887_state *st;
-	int ret, voltage_uv = 0;
+	int ret, voltage_uv = 0, regdone = 0;
+	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
 
-	st = kzalloc(sizeof(*st), GFP_KERNEL);
-	if (st == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	if (indio_dev == NULL)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
 
 	st->reg = regulator_get(&spi->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
@@ -110,26 +107,16 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 	st->chip_info =
 		&ad7887_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
-	spi_set_drvdata(spi, st);
-
+	spi_set_drvdata(spi, indio_dev);
 	st->spi = spi;
 
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_disable_reg;
-	}
-
 	/* Estabilish that the iio_dev is a child of the spi device */
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->name = spi_get_device_id(spi)->name;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->channels = st->chip_info->channel;
-	st->indio_dev->num_channels = 3;
-	st->indio_dev->read_raw = &ad7887_read_raw;
-
-	st->indio_dev->driver_module = THIS_MODULE;
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->dev_data = (void *)(st);
+	indio_dev->read_raw = &ad7887_read_raw;
+	indio_dev->driver_module = THIS_MODULE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Setup default message */
 
@@ -180,8 +167,8 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 		else
 			dev_warn(&spi->dev, "reference voltage unspecified\n");
 
-		st->indio_dev->channels = st->chip_info->channel;
-		st->indio_dev->num_channels = 3;
+		indio_dev->channels = st->chip_info->channel;
+		indio_dev->num_channels = 3;
 	} else {
 		if (pdata && pdata->vref_mv)
 			st->int_vref_mv = pdata->vref_mv;
@@ -190,53 +177,55 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 		else
 			dev_warn(&spi->dev, "reference voltage unspecified\n");
 
-		st->indio_dev->channels = &st->chip_info->channel[1];
-		st->indio_dev->num_channels = 2;
+		indio_dev->channels = &st->chip_info->channel[1];
+		indio_dev->num_channels = 2;
 	}
 
-	ret = ad7887_register_ring_funcs_and_init(st->indio_dev);
+	ret = ad7887_register_ring_funcs_and_init(indio_dev);
 	if (ret)
-		goto error_free_device;
+		goto error_disable_reg;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_device;
+		goto error_disable_reg;
+	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
-					  st->indio_dev->channels,
-					  st->indio_dev->num_channels);
+	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+					  indio_dev->channels,
+					  indio_dev->num_channels);
 	if (ret)
 		goto error_cleanup_ring;
 	return 0;
 
 error_cleanup_ring:
-	ad7887_ring_cleanup(st->indio_dev);
-	iio_device_unregister(st->indio_dev);
-error_free_device:
-	iio_free_device(st->indio_dev);
+	ad7887_ring_cleanup(indio_dev);
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-	kfree(st);
-error_ret:
+	if (regdone)
+		iio_device_unregister(indio_dev);
+	else
+		iio_free_device(indio_dev);
+
 	return ret;
 }
 
 static int ad7887_remove(struct spi_device *spi)
 {
-	struct ad7887_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad7887_state *st = iio_priv(indio_dev);
+
 	iio_ring_buffer_unregister(indio_dev->ring);
 	ad7887_ring_cleanup(indio_dev);
-	iio_device_unregister(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	kfree(st);
+	iio_device_unregister(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index fa9ea73..113e97e 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -8,13 +8,10 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/spi/spi.h>
 
 #include "../iio.h"
@@ -27,7 +24,7 @@
 
 int ad7887_scan_from_ring(struct ad7887_state *st, long mask)
 {
-	struct iio_ring_buffer *ring = st->indio_dev->ring;
+	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
 	int count = 0, ret;
 	u16 *ring_data;
 
-- 
1.7.3.4

