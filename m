Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-106.synserver.de ([212.40.185.106]:1133 "EHLO
	smtp-out-098.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758451Ab2DYMQA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Apr 2012 08:16:00 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio: Streamline API function naming
Date: Wed, 25 Apr 2012 14:18:17 +0200
Message-Id: <1335356297-21035-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently we use two different naming schemes in the IIO API, iio_verb_object
and iio_object_verb. E.g iio_device_register and iio_allocate_device. This
patches renames instances of the later to the former. The patch also renames allocate to
alloc as this seems to be the preferred form throughout the kernel.

In particular the following renames are performed by the patch:
	iio_put_device -> iio_device_put
	iio_allocate_device -> iio_device_alloc
	iio_free_device -> iio_device_free
	iio_get_trigger -> iio_trigger_get
	iio_put_trigger -> iio_trigger_put
	iio_allocate_trigger -> iio_trigger_alloc
	iio_free_trigger -> iio_trigger_free

The conversion was done with the following coccinelle patch with manual fixes to
comments and documentation.

<smpl>
@@
@@
-iio_put_device
+iio_device_put
@@
@@
-iio_allocate_device
+iio_device_alloc
@@
@@
-iio_free_device
+iio_device_free
@@
@@
-iio_get_trigger
+iio_trigger_get
@@
@@
-iio_put_trigger
+iio_trigger_put
@@
@@
-iio_allocate_trigger
+iio_trigger_alloc
@@
@@
-iio_free_trigger
+iio_trigger_free
</smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
We talked about this some time back that we wanted to do this before moving out
of staging. Maybe it makes sense to carry it with you in your move iio out of
staging series.
---
 drivers/staging/iio/Documentation/device.txt       |    4 ++--
 drivers/staging/iio/Documentation/trigger.txt      |    2 +-
 drivers/staging/iio/accel/adis16201_core.c         |    6 +++---
 drivers/staging/iio/accel/adis16201_trigger.c      |    6 +++---
 drivers/staging/iio/accel/adis16203_core.c         |    6 +++---
 drivers/staging/iio/accel/adis16203_trigger.c      |    6 +++---
 drivers/staging/iio/accel/adis16204_core.c         |    6 +++---
 drivers/staging/iio/accel/adis16204_trigger.c      |    6 +++---
 drivers/staging/iio/accel/adis16209_core.c         |    6 +++---
 drivers/staging/iio/accel/adis16209_trigger.c      |    6 +++---
 drivers/staging/iio/accel/adis16220_core.c         |    6 +++---
 drivers/staging/iio/accel/adis16240_core.c         |    6 +++---
 drivers/staging/iio/accel/adis16240_trigger.c      |    6 +++---
 drivers/staging/iio/accel/kxsd9.c                  |    6 +++---
 drivers/staging/iio/accel/lis3l02dq_core.c         |    6 +++---
 drivers/staging/iio/accel/lis3l02dq_ring.c         |    6 +++---
 drivers/staging/iio/accel/sca3000_core.c           |    6 +++---
 drivers/staging/iio/adc/ad7192.c                   |   10 +++++-----
 drivers/staging/iio/adc/ad7280a.c                  |    6 +++---
 drivers/staging/iio/adc/ad7291.c                   |    6 +++---
 drivers/staging/iio/adc/ad7298_core.c              |    6 +++---
 drivers/staging/iio/adc/ad7476_core.c              |    6 +++---
 drivers/staging/iio/adc/ad7606_core.c              |    6 +++---
 drivers/staging/iio/adc/ad7780.c                   |    6 +++---
 drivers/staging/iio/adc/ad7793.c                   |   12 ++++++------
 drivers/staging/iio/adc/ad7816.c                   |    6 +++---
 drivers/staging/iio/adc/ad7887_core.c              |    6 +++---
 drivers/staging/iio/adc/ad799x_core.c              |    6 +++---
 drivers/staging/iio/adc/adt7310.c                  |    6 +++---
 drivers/staging/iio/adc/adt7410.c                  |    6 +++---
 drivers/staging/iio/adc/lpc32xx_adc.c              |    6 +++---
 drivers/staging/iio/adc/max1363_core.c             |    6 +++---
 drivers/staging/iio/adc/spear_adc.c                |    6 +++---
 drivers/staging/iio/addac/adt7316.c                |    6 +++---
 drivers/staging/iio/cdc/ad7150.c                   |    6 +++---
 drivers/staging/iio/cdc/ad7152.c                   |    6 +++---
 drivers/staging/iio/cdc/ad7746.c                   |    6 +++---
 drivers/staging/iio/dac/ad5064.c                   |    6 +++---
 drivers/staging/iio/dac/ad5360.c                   |    6 +++---
 drivers/staging/iio/dac/ad5380.c                   |    6 +++---
 drivers/staging/iio/dac/ad5421.c                   |    6 +++---
 drivers/staging/iio/dac/ad5446.c                   |    6 +++---
 drivers/staging/iio/dac/ad5504.c                   |    6 +++---
 drivers/staging/iio/dac/ad5624r_spi.c              |    6 +++---
 drivers/staging/iio/dac/ad5686.c                   |    6 +++---
 drivers/staging/iio/dac/ad5764.c                   |    6 +++---
 drivers/staging/iio/dac/ad5791.c                   |    6 +++---
 drivers/staging/iio/dac/max517.c                   |    6 +++---
 drivers/staging/iio/dds/ad5930.c                   |    6 +++---
 drivers/staging/iio/dds/ad9832.c                   |    6 +++---
 drivers/staging/iio/dds/ad9834.c                   |    6 +++---
 drivers/staging/iio/dds/ad9850.c                   |    6 +++---
 drivers/staging/iio/dds/ad9852.c                   |    6 +++---
 drivers/staging/iio/dds/ad9910.c                   |    6 +++---
 drivers/staging/iio/dds/ad9951.c                   |    6 +++---
 drivers/staging/iio/gyro/adis16060_core.c          |    6 +++---
 drivers/staging/iio/gyro/adis16080_core.c          |    6 +++---
 drivers/staging/iio/gyro/adis16130_core.c          |    6 +++---
 drivers/staging/iio/gyro/adis16260_core.c          |    6 +++---
 drivers/staging/iio/gyro/adis16260_trigger.c       |    6 +++---
 drivers/staging/iio/gyro/adxrs450_core.c           |    6 +++---
 drivers/staging/iio/iio.h                          |   12 ++++++------
 drivers/staging/iio/iio_simple_dummy.c             |    6 +++---
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    6 +++---
 drivers/staging/iio/imu/adis16400_core.c           |    6 +++---
 drivers/staging/iio/imu/adis16400_trigger.c        |    6 +++---
 drivers/staging/iio/industrialio-core.c            |    8 ++++----
 drivers/staging/iio/industrialio-trigger.c         |   14 +++++++-------
 drivers/staging/iio/light/isl29018.c               |    6 +++---
 drivers/staging/iio/light/isl29028.c               |    6 +++---
 drivers/staging/iio/light/tsl2563.c                |    6 +++---
 drivers/staging/iio/light/tsl2583.c                |    6 +++---
 drivers/staging/iio/light/tsl2x7x_core.c           |    6 +++---
 drivers/staging/iio/magnetometer/ak8975.c          |    6 +++---
 drivers/staging/iio/magnetometer/hmc5843.c         |    6 +++---
 drivers/staging/iio/meter/ade7753.c                |    6 +++---
 drivers/staging/iio/meter/ade7754.c                |    6 +++---
 drivers/staging/iio/meter/ade7758_core.c           |    6 +++---
 drivers/staging/iio/meter/ade7758_trigger.c        |    6 +++---
 drivers/staging/iio/meter/ade7759.c                |    6 +++---
 drivers/staging/iio/meter/ade7854-i2c.c            |    4 ++--
 drivers/staging/iio/meter/ade7854-spi.c            |    4 ++--
 drivers/staging/iio/meter/ade7854.c                |    4 ++--
 drivers/staging/iio/resolver/ad2s1200.c            |    6 +++---
 drivers/staging/iio/resolver/ad2s1210.c            |    6 +++---
 drivers/staging/iio/resolver/ad2s90.c              |    6 +++---
 drivers/staging/iio/trigger.h                      |    8 ++++----
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |    6 +++---
 drivers/staging/iio/trigger/iio-trig-gpio.c        |    6 +++---
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |    4 ++--
 drivers/staging/iio/trigger/iio-trig-sysfs.c       |    6 +++---
 91 files changed, 280 insertions(+), 280 deletions(-)

diff --git a/drivers/staging/iio/Documentation/device.txt b/drivers/staging/iio/Documentation/device.txt
index 8926f24..0338c7c 100644
--- a/drivers/staging/iio/Documentation/device.txt
+++ b/drivers/staging/iio/Documentation/device.txt
@@ -8,7 +8,7 @@ The crucial structure for device drivers in iio is iio_dev.
 
 First allocate one using:
 
-struct iio_dev *indio_dev = iio_allocate_device(sizeof(struct chip_state));
+struct iio_dev *indio_dev = iio_device_alloc(sizeof(struct chip_state));
 where chip_state is a structure of local state data for this instance of
 the chip.
 
@@ -78,4 +78,4 @@ be registered afterwards (otherwise the whole parentage of devices
 gets confused)
 
 On remove, iio_device_unregister(indio_dev) will remove the device from
-the core, and iio_free_device will clean up.
+the core, and iio_device_free will clean up.
diff --git a/drivers/staging/iio/Documentation/trigger.txt b/drivers/staging/iio/Documentation/trigger.txt
index fc2012e..75cc37f 100644
--- a/drivers/staging/iio/Documentation/trigger.txt
+++ b/drivers/staging/iio/Documentation/trigger.txt
@@ -5,7 +5,7 @@ an IIO device.  Whilst this can create device specific complexities
 such triggers are registered with the core in the same way as
 stand-alone triggers.
 
-struct iio_trig *trig = iio_allocate_trigger("<trigger format string>", ...);
+struct iio_trig *trig = iio_trigger_alloc("<trigger format string>", ...);
 
 allocates a trigger structure.  The key elements to then fill in within
 a driver are:
diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 8022bbd..613c5c6 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -532,7 +532,7 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -587,7 +587,7 @@ error_uninitialize_ring:
 error_unreg_ring_funcs:
 	adis16201_unconfigure_ring(indio_dev);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -600,7 +600,7 @@ static int adis16201_remove(struct spi_device *spi)
 	adis16201_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16201_unconfigure_ring(indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16201_trigger.c b/drivers/staging/iio/accel/adis16201_trigger.c
index bce505e..19503f2 100644
--- a/drivers/staging/iio/accel/adis16201_trigger.c
+++ b/drivers/staging/iio/accel/adis16201_trigger.c
@@ -29,7 +29,7 @@ int adis16201_probe_trigger(struct iio_dev *indio_dev)
 	int ret;
 	struct adis16201_state *st = iio_priv(indio_dev);
 
-	st->trig = iio_allocate_trigger("adis16201-dev%d", indio_dev->id);
+	st->trig = iio_trigger_alloc("adis16201-dev%d", indio_dev->id);
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -56,7 +56,7 @@ int adis16201_probe_trigger(struct iio_dev *indio_dev)
 error_free_irq:
 	free_irq(st->us->irq, st->trig);
 error_free_trig:
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 error_ret:
 	return ret;
 }
@@ -67,5 +67,5 @@ void adis16201_remove_trigger(struct iio_dev *indio_dev)
 
 	iio_trigger_unregister(state->trig);
 	free_irq(state->us->irq, state->trig);
-	iio_free_trigger(state->trig);
+	iio_trigger_free(state->trig);
 }
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index f23b7c5..b775041 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -469,7 +469,7 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 	struct adis16203_state *st;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -523,7 +523,7 @@ error_uninitialize_ring:
 error_unreg_ring_funcs:
 	adis16203_unconfigure_ring(indio_dev);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -536,7 +536,7 @@ static int adis16203_remove(struct spi_device *spi)
 	adis16203_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16203_unconfigure_ring(indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16203_trigger.c b/drivers/staging/iio/accel/adis16203_trigger.c
index 24bcb8e..3ce84ff 100644
--- a/drivers/staging/iio/accel/adis16203_trigger.c
+++ b/drivers/staging/iio/accel/adis16203_trigger.c
@@ -29,7 +29,7 @@ int adis16203_probe_trigger(struct iio_dev *indio_dev)
 	int ret;
 	struct adis16203_state *st = iio_priv(indio_dev);
 
-	st->trig = iio_allocate_trigger("adis16203-dev%d", indio_dev->id);
+	st->trig = iio_trigger_alloc("adis16203-dev%d", indio_dev->id);
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -58,7 +58,7 @@ int adis16203_probe_trigger(struct iio_dev *indio_dev)
 error_free_irq:
 	free_irq(st->us->irq, st->trig);
 error_free_trig:
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 error_ret:
 	return ret;
 }
@@ -69,5 +69,5 @@ void adis16203_remove_trigger(struct iio_dev *indio_dev)
 
 	iio_trigger_unregister(st->trig);
 	free_irq(st->us->irq, st->trig);
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 }
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index bffbbe8..a8a1c31 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -545,7 +545,7 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -598,7 +598,7 @@ error_uninitialize_ring:
 error_unreg_ring_funcs:
 	adis16204_unconfigure_ring(indio_dev);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -611,7 +611,7 @@ static int adis16204_remove(struct spi_device *spi)
 	adis16204_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16204_unconfigure_ring(indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16204_trigger.c b/drivers/staging/iio/accel/adis16204_trigger.c
index 6e542af..4f1e568 100644
--- a/drivers/staging/iio/accel/adis16204_trigger.c
+++ b/drivers/staging/iio/accel/adis16204_trigger.c
@@ -29,7 +29,7 @@ int adis16204_probe_trigger(struct iio_dev *indio_dev)
 	int ret;
 	struct adis16204_state *st = iio_priv(indio_dev);
 
-	st->trig = iio_allocate_trigger("adis16204-dev%d", indio_dev->id);
+	st->trig = iio_trigger_alloc("adis16204-dev%d", indio_dev->id);
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -58,7 +58,7 @@ int adis16204_probe_trigger(struct iio_dev *indio_dev)
 error_free_irq:
 	free_irq(st->us->irq, st->trig);
 error_free_trig:
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 error_ret:
 	return ret;
 }
@@ -69,5 +69,5 @@ void adis16204_remove_trigger(struct iio_dev *indio_dev)
 
 	iio_trigger_unregister(state->trig);
 	free_irq(state->us->irq, state->trig);
-	iio_free_trigger(state->trig);
+	iio_trigger_free(state->trig);
 }
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index b1fbf19..4e4cd17 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -544,7 +544,7 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -597,7 +597,7 @@ error_uninitialize_ring:
 error_unreg_ring_funcs:
 	adis16209_unconfigure_ring(indio_dev);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -612,7 +612,7 @@ static int adis16209_remove(struct spi_device *spi)
 	adis16209_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16209_unconfigure_ring(indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/staging/iio/accel/adis16209_trigger.c
index c5d82c1..756c92b 100644
--- a/drivers/staging/iio/accel/adis16209_trigger.c
+++ b/drivers/staging/iio/accel/adis16209_trigger.c
@@ -38,7 +38,7 @@ int adis16209_probe_trigger(struct iio_dev *indio_dev)
 	int ret;
 	struct adis16209_state *st = iio_priv(indio_dev);
 
-	st->trig = iio_allocate_trigger("adis16209-dev%d", indio_dev->id);
+	st->trig = iio_trigger_alloc("adis16209-dev%d", indio_dev->id);
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -66,7 +66,7 @@ int adis16209_probe_trigger(struct iio_dev *indio_dev)
 error_free_irq:
 	free_irq(st->us->irq, st->trig);
 error_free_trig:
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 error_ret:
 	return ret;
 }
@@ -77,5 +77,5 @@ void adis16209_remove_trigger(struct iio_dev *indio_dev)
 
 	iio_trigger_unregister(st->trig);
 	free_irq(st->us->irq, st->trig);
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 }
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 2740c8e..6bf7a75 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -634,7 +634,7 @@ static int __devinit adis16220_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -685,7 +685,7 @@ error_rm_accel_bin:
 error_unregister_dev:
 	iio_device_unregister(indio_dev);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -700,7 +700,7 @@ static int adis16220_remove(struct spi_device *spi)
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc1_bin);
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &accel_bin);
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 18ed396..58a4909 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -578,7 +578,7 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -631,7 +631,7 @@ error_uninitialize_ring:
 error_unreg_ring_funcs:
 	adis16240_unconfigure_ring(indio_dev);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -647,7 +647,7 @@ static int adis16240_remove(struct spi_device *spi)
 	adis16240_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16240_unconfigure_ring(indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16240_trigger.c b/drivers/staging/iio/accel/adis16240_trigger.c
index 8e0ce56..2ca586d 100644
--- a/drivers/staging/iio/accel/adis16240_trigger.c
+++ b/drivers/staging/iio/accel/adis16240_trigger.c
@@ -38,7 +38,7 @@ int adis16240_probe_trigger(struct iio_dev *indio_dev)
 	int ret;
 	struct adis16240_state *st = iio_priv(indio_dev);
 
-	st->trig = iio_allocate_trigger("adis16240-dev%d", indio_dev->id);
+	st->trig = iio_trigger_alloc("adis16240-dev%d", indio_dev->id);
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -67,7 +67,7 @@ int adis16240_probe_trigger(struct iio_dev *indio_dev)
 error_free_irq:
 	free_irq(st->us->irq, st->trig);
 error_free_trig:
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 error_ret:
 	return ret;
 }
@@ -78,5 +78,5 @@ void adis16240_remove_trigger(struct iio_dev *indio_dev)
 
 	iio_trigger_unregister(st->trig);
 	free_irq(st->us->irq, st->trig);
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 }
diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index 601da28..c176b1e 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -228,7 +228,7 @@ static int __devinit kxsd9_probe(struct spi_device *spi)
 	struct kxsd9_state *st;
 	int ret = 0;
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -256,7 +256,7 @@ static int __devinit kxsd9_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -264,7 +264,7 @@ error_ret:
 static int __devexit kxsd9_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
-	iio_free_device(spi_get_drvdata(spi));
+	iio_device_free(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index ee8ad3a..6e52cd8 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -680,7 +680,7 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	struct lis3l02dq_state *st;
 	struct iio_dev *indio_dev;
 
-	indio_dev = iio_allocate_device(sizeof *st);
+	indio_dev = iio_device_alloc(sizeof *st);
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -748,7 +748,7 @@ error_uninitialize_buffer:
 error_unreg_buffer_funcs:
 	lis3l02dq_unconfigure_buffer(indio_dev);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -803,7 +803,7 @@ static int lis3l02dq_remove(struct spi_device *spi)
 	iio_buffer_unregister(indio_dev);
 	lis3l02dq_unconfigure_buffer(indio_dev);
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 err_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index ebd5b4d..28aef84 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -286,7 +286,7 @@ int lis3l02dq_probe_trigger(struct iio_dev *indio_dev)
 	int ret;
 	struct lis3l02dq_state *st = iio_priv(indio_dev);
 
-	st->trig = iio_allocate_trigger("lis3l02dq-dev%d", indio_dev->id);
+	st->trig = iio_trigger_alloc("lis3l02dq-dev%d", indio_dev->id);
 	if (!st->trig) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -302,7 +302,7 @@ int lis3l02dq_probe_trigger(struct iio_dev *indio_dev)
 	return 0;
 
 error_free_trig:
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 error_ret:
 	return ret;
 }
@@ -312,7 +312,7 @@ void lis3l02dq_remove_trigger(struct iio_dev *indio_dev)
 	struct lis3l02dq_state *st = iio_priv(indio_dev);
 
 	iio_trigger_unregister(st->trig);
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 }
 
 void lis3l02dq_unconfigure_buffer(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 646e05c..d8f1397 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1145,7 +1145,7 @@ static int __devinit sca3000_probe(struct spi_device *spi)
 	struct sca3000_state *st;
 	struct iio_dev *indio_dev;
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -1209,7 +1209,7 @@ error_unregister_ring:
 error_unregister_dev:
 	iio_device_unregister(indio_dev);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 error_ret:
 	return ret;
@@ -1247,7 +1247,7 @@ static int sca3000_remove(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	sca3000_unconfigure_ring(indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 5d31685..57e41d6 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -604,7 +604,7 @@ static int ad7192_probe_trigger(struct iio_dev *indio_dev)
 	struct ad7192_state *st = iio_priv(indio_dev);
 	int ret;
 
-	st->trig = iio_allocate_trigger("%s-dev%d",
+	st->trig = iio_trigger_alloc("%s-dev%d",
 					spi_get_device_id(st->spi)->name,
 					indio_dev->id);
 	if (st->trig == NULL) {
@@ -637,7 +637,7 @@ static int ad7192_probe_trigger(struct iio_dev *indio_dev)
 error_free_irq:
 	free_irq(st->spi->irq, indio_dev);
 error_free_trig:
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 error_ret:
 	return ret;
 }
@@ -648,7 +648,7 @@ static void ad7192_remove_trigger(struct iio_dev *indio_dev)
 
 	iio_trigger_unregister(st->trig);
 	free_irq(st->spi->irq, indio_dev);
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 }
 
 static ssize_t ad7192_read_frequency(struct device *dev,
@@ -1024,7 +1024,7 @@ static int __devinit ad7192_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -1105,7 +1105,7 @@ error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return ret;
 }
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index f0c0c72..08f42f6 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -839,7 +839,7 @@ static int __devinit ad7280_probe(struct spi_device *spi)
 	int ret;
 	const unsigned short tACQ_ns[4] = {465, 1010, 1460, 1890};
 	const unsigned short nAVG[4] = {1, 2, 4, 8};
-	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
+	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
 
 	if (indio_dev == NULL)
 		return -ENOMEM;
@@ -945,7 +945,7 @@ error_free_channels:
 	kfree(st->channels);
 
 error_free_device:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -964,7 +964,7 @@ static int __devexit ad7280_remove(struct spi_device *spi)
 
 	kfree(st->channels);
 	kfree(st->iio_attr);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 298249f..407e973 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -587,7 +587,7 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int ret = 0, voltage_uv = 0;
 
-	indio_dev = iio_allocate_device(sizeof(*chip));
+	indio_dev = iio_device_alloc(sizeof(*chip));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -669,7 +669,7 @@ error_put_reg:
 	if (!IS_ERR(chip->reg))
 		regulator_put(chip->reg);
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -689,7 +689,7 @@ static int __devexit ad7291_remove(struct i2c_client *client)
 		regulator_put(chip->reg);
 	}
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 5d54a79..7310f7a 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -179,7 +179,7 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 	struct ad7298_platform_data *pdata = spi->dev.platform_data;
 	struct ad7298_state *st;
 	int ret;
-	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
+	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
 
 	if (indio_dev == NULL)
 		return -ENOMEM;
@@ -252,7 +252,7 @@ error_disable_reg:
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -269,7 +269,7 @@ static int __devexit ad7298_remove(struct spi_device *spi)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index ce71522..9df75d2 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -128,7 +128,7 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	int ret, voltage_uv = 0;
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -198,7 +198,7 @@ error_disable_reg:
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 error_ret:
 	return ret;
@@ -216,7 +216,7 @@ static int ad7476_remove(struct spi_device *spi)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 802cdaf..d84d0ad 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -461,7 +461,7 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 	struct ad7606_platform_data *pdata = dev->platform_data;
 	struct ad7606_state *st;
 	int ret;
-	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
+	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
 
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
@@ -560,7 +560,7 @@ error_disable_reg:
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ERR_PTR(ret);
 }
@@ -580,7 +580,7 @@ int ad7606_remove(struct iio_dev *indio_dev, int irq)
 	}
 
 	ad7606_free_gpios(st);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index eeedbdb..ed63330 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -187,7 +187,7 @@ static int __devinit ad7780_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -265,7 +265,7 @@ error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -282,7 +282,7 @@ static int ad7780_remove(struct spi_device *spi)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 7f68c7c..6eca68d 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -469,7 +469,7 @@ static int ad7793_probe_trigger(struct iio_dev *indio_dev)
 	struct ad7793_state *st = iio_priv(indio_dev);
 	int ret;
 
-	st->trig = iio_allocate_trigger("%s-dev%d",
+	st->trig = iio_trigger_alloc("%s-dev%d",
 					spi_get_device_id(st->spi)->name,
 					indio_dev->id);
 	if (st->trig == NULL) {
@@ -503,7 +503,7 @@ static int ad7793_probe_trigger(struct iio_dev *indio_dev)
 error_free_irq:
 	free_irq(st->spi->irq, indio_dev);
 error_free_trig:
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 error_ret:
 	return ret;
 }
@@ -514,7 +514,7 @@ static void ad7793_remove_trigger(struct iio_dev *indio_dev)
 
 	iio_trigger_unregister(st->trig);
 	free_irq(st->spi->irq, indio_dev);
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 }
 
 static const u16 sample_freq_avail[16] = {0, 470, 242, 123, 62, 50, 39, 33, 19,
@@ -904,7 +904,7 @@ static int __devinit ad7793_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -988,7 +988,7 @@ error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -1008,7 +1008,7 @@ static int ad7793_remove(struct spi_device *spi)
 		regulator_put(st->reg);
 	}
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 52b720e..d58b24d 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -354,7 +354,7 @@ static int __devinit ad7816_probe(struct spi_device *spi_dev)
 		return -EINVAL;
 	}
 
-	indio_dev = iio_allocate_device(sizeof(*chip));
+	indio_dev = iio_device_alloc(sizeof(*chip));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -426,7 +426,7 @@ error_free_gpio_convert:
 error_free_gpio_rdwr:
 	gpio_free(chip->rdwr_pin);
 error_free_device:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -443,7 +443,7 @@ static int __devexit ad7816_remove(struct spi_device *spi_dev)
 	gpio_free(chip->busy_pin);
 	gpio_free(chip->convert_pin);
 	gpio_free(chip->rdwr_pin);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 2cce09f..e05b212 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -106,7 +106,7 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 	struct ad7887_platform_data *pdata = spi->dev.platform_data;
 	struct ad7887_state *st;
 	int ret, voltage_uv = 0;
-	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
+	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
 
 	if (indio_dev == NULL)
 		return -ENOMEM;
@@ -222,7 +222,7 @@ error_disable_reg:
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -239,7 +239,7 @@ static int ad7887_remove(struct spi_device *spi)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 429fb41..669d757 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -847,7 +847,7 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 	int ret;
 	struct ad799x_platform_data *pdata = client->dev.platform_data;
 	struct ad799x_state *st;
-	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
+	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
 
 	if (indio_dev == NULL)
 		return -ENOMEM;
@@ -920,7 +920,7 @@ error_disable_reg:
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -940,7 +940,7 @@ static __devexit int ad799x_remove(struct i2c_client *client)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index caf57c1..15eaf32 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -753,7 +753,7 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 	unsigned long *adt7310_platform_data = spi_dev->dev.platform_data;
 	unsigned long irq_flags;
 
-	indio_dev = iio_allocate_device(sizeof(*chip));
+	indio_dev = iio_device_alloc(sizeof(*chip));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -833,7 +833,7 @@ error_unreg_int_irq:
 error_unreg_ct_irq:
 	free_irq(spi_dev->irq, indio_dev);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -849,7 +849,7 @@ static int __devexit adt7310_remove(struct spi_device *spi_dev)
 		free_irq(adt7310_platform_data[0], indio_dev);
 	if (spi_dev->irq)
 		free_irq(spi_dev->irq, indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index dff3e8c..61498ac 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -721,7 +721,7 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 	int ret = 0;
 	unsigned long *adt7410_platform_data = client->dev.platform_data;
 
-	indio_dev = iio_allocate_device(sizeof(*chip));
+	indio_dev = iio_device_alloc(sizeof(*chip));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -797,7 +797,7 @@ error_unreg_int_irq:
 error_unreg_ct_irq:
 	free_irq(client->irq, indio_dev);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -812,7 +812,7 @@ static int __devexit adt7410_remove(struct i2c_client *client)
 		free_irq(adt7410_platform_data[0], indio_dev);
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
index d7f4fe4..4ec20ea 100644
--- a/drivers/staging/iio/adc/lpc32xx_adc.c
+++ b/drivers/staging/iio/adc/lpc32xx_adc.c
@@ -141,7 +141,7 @@ static int __devinit lpc32xx_adc_probe(struct platform_device *pdev)
 		goto errout1;
 	}
 
-	iodev = iio_allocate_device(sizeof(struct lpc32xx_adc_info));
+	iodev = iio_device_alloc(sizeof(struct lpc32xx_adc_info));
 	if (!iodev) {
 		dev_err(&pdev->dev, "failed allocating iio device\n");
 		retval = -ENOMEM;
@@ -202,7 +202,7 @@ errout4:
 errout3:
 	iounmap(info->adc_base);
 errout2:
-	iio_free_device(iodev);
+	iio_device_free(iodev);
 errout1:
 	return retval;
 }
@@ -218,7 +218,7 @@ static int __devexit lpc32xx_adc_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 	clk_put(info->clk);
 	iounmap(info->adc_base);
-	iio_free_device(iodev);
+	iio_device_free(iodev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 1a7a027..a127f77 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -1287,7 +1287,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	if (ret)
 		goto error_put_reg;
 
-	indio_dev = iio_allocate_device(sizeof(struct max1363_state));
+	indio_dev = iio_device_alloc(sizeof(struct max1363_state));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
@@ -1358,7 +1358,7 @@ error_free_available_scan_masks:
 error_unregister_map:
 	iio_map_array_unregister(indio_dev, client->dev.platform_data);
 error_free_device:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_disable_reg:
 	regulator_disable(reg);
 error_put_reg:
@@ -1384,7 +1384,7 @@ static int max1363_remove(struct i2c_client *client)
 		regulator_put(reg);
 	}
 	iio_map_array_unregister(indio_dev, client->dev.platform_data);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index 3ca5cc9..f5f7bda 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -300,7 +300,7 @@ static int __devinit spear_adc_probe(struct platform_device *pdev)
 	int ret = -ENODEV;
 	int irq;
 
-	iodev = iio_allocate_device(sizeof(struct spear_adc_info));
+	iodev = iio_device_alloc(sizeof(struct spear_adc_info));
 	if (!iodev) {
 		dev_err(dev, "failed allocating iio device\n");
 		ret = -ENOMEM;
@@ -404,7 +404,7 @@ errout4:
 errout3:
 	iounmap(info->adc_base_spear6xx);
 errout2:
-	iio_free_device(iodev);
+	iio_device_free(iodev);
 errout1:
 	return ret;
 }
@@ -420,7 +420,7 @@ static int __devexit spear_adc_remove(struct platform_device *pdev)
 	clk_unprepare(info->clk);
 	clk_put(info->clk);
 	iounmap(info->adc_base_spear6xx);
-	iio_free_device(iodev);
+	iio_device_free(iodev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index fd6a454..fb920e5 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2133,7 +2133,7 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	unsigned short *adt7316_platform_data = dev->platform_data;
 	int ret = 0;
 
-	indio_dev = iio_allocate_device(sizeof(*chip));
+	indio_dev = iio_device_alloc(sizeof(*chip));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -2210,7 +2210,7 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 error_unreg_irq:
 	free_irq(chip->bus.irq, indio_dev);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -2224,7 +2224,7 @@ int __devexit adt7316_remove(struct device *dev)
 	iio_device_unregister(indio_dev);
 	if (chip->bus.irq)
 		free_irq(chip->bus.irq, indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 116e6c2..707a61e 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -558,7 +558,7 @@ static int __devinit ad7150_probe(struct i2c_client *client,
 	struct ad7150_chip_info *chip;
 	struct iio_dev *indio_dev;
 
-	indio_dev = iio_allocate_device(sizeof(*chip));
+	indio_dev = iio_device_alloc(sizeof(*chip));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -621,7 +621,7 @@ error_free_irq:
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -637,7 +637,7 @@ static int __devexit ad7150_remove(struct i2c_client *client)
 	if (client->dev.platform_data)
 		free_irq(*(unsigned int *)client->dev.platform_data, indio_dev);
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 1067ce5..e71a6ff 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -481,7 +481,7 @@ static int __devinit ad7152_probe(struct i2c_client *client,
 	struct ad7152_chip_info *chip;
 	struct iio_dev *indio_dev;
 
-	indio_dev = iio_allocate_device(sizeof(*chip));
+	indio_dev = iio_device_alloc(sizeof(*chip));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -513,7 +513,7 @@ static int __devinit ad7152_probe(struct i2c_client *client,
 	return 0;
 
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -523,7 +523,7 @@ static int __devexit ad7152_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 750bf4b..232511a 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -703,7 +703,7 @@ static int __devinit ad7746_probe(struct i2c_client *client,
 	int ret = 0;
 	unsigned char regval = 0;
 
-	indio_dev = iio_allocate_device(sizeof(*chip));
+	indio_dev = iio_device_alloc(sizeof(*chip));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -763,7 +763,7 @@ static int __devinit ad7746_probe(struct i2c_client *client,
 	return 0;
 
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -773,7 +773,7 @@ static int __devexit ad7746_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
index 21893ed..db72d8e 100644
--- a/drivers/staging/iio/dac/ad5064.c
+++ b/drivers/staging/iio/dac/ad5064.c
@@ -443,7 +443,7 @@ static int __devinit ad5064_probe(struct spi_device *spi)
 	unsigned int i;
 	int ret;
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL)
 		return  -ENOMEM;
 
@@ -500,7 +500,7 @@ error_free_reg:
 	if (!st->use_internal_vref)
 		regulator_bulk_free(ad5064_num_vref(st), st->vref_reg);
 error_free:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -518,7 +518,7 @@ static int __devexit ad5064_remove(struct spi_device *spi)
 		regulator_bulk_free(ad5064_num_vref(st), st->vref_reg);
 	}
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5360.c b/drivers/staging/iio/dac/ad5360.c
index cb6160d..7f48e24 100644
--- a/drivers/staging/iio/dac/ad5360.c
+++ b/drivers/staging/iio/dac/ad5360.c
@@ -465,7 +465,7 @@ static int __devinit ad5360_probe(struct spi_device *spi)
 	unsigned int i;
 	int ret;
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		dev_err(&spi->dev, "Failed to allocate iio device\n");
 		return  -ENOMEM;
@@ -520,7 +520,7 @@ error_free_reg:
 error_free_channels:
 	kfree(indio_dev->channels);
 error_free:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -537,7 +537,7 @@ static int __devexit ad5360_remove(struct spi_device *spi)
 	regulator_bulk_disable(st->chip_info->num_vrefs, st->vref_reg);
 	regulator_bulk_free(st->chip_info->num_vrefs, st->vref_reg);
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5380.c b/drivers/staging/iio/dac/ad5380.c
index 1d384f0..ac6a05e 100644
--- a/drivers/staging/iio/dac/ad5380.c
+++ b/drivers/staging/iio/dac/ad5380.c
@@ -389,7 +389,7 @@ static int __devinit ad5380_probe(struct device *dev, struct regmap *regmap,
 	unsigned int ctrl = 0;
 	int ret;
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		dev_err(dev, "Failed to allocate iio device\n");
 		ret = -ENOMEM;
@@ -455,7 +455,7 @@ error_free_reg:
 
 	kfree(indio_dev->channels);
 error_free:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_regmap_exit:
 	regmap_exit(regmap);
 
@@ -477,7 +477,7 @@ static int __devexit ad5380_remove(struct device *dev)
 	}
 
 	regmap_exit(st->regmap);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5421.c b/drivers/staging/iio/dac/ad5421.c
index a8b5211..775403e 100644
--- a/drivers/staging/iio/dac/ad5421.c
+++ b/drivers/staging/iio/dac/ad5421.c
@@ -457,7 +457,7 @@ static int __devinit ad5421_probe(struct spi_device *spi)
 	struct ad5421_state *st;
 	int ret;
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		dev_err(&spi->dev, "Failed to allocate iio device\n");
 		return  -ENOMEM;
@@ -512,7 +512,7 @@ error_free_irq:
 	if (spi->irq)
 		free_irq(spi->irq, indio_dev);
 error_free:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -524,7 +524,7 @@ static int __devexit ad5421_remove(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 	if (spi->irq)
 		free_irq(spi->irq, indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index ec6968b..173b238 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -322,7 +322,7 @@ static int __devinit ad5446_probe(struct spi_device *spi)
 		voltage_uv = regulator_get_voltage(reg);
 	}
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
@@ -378,7 +378,7 @@ static int __devinit ad5446_probe(struct spi_device *spi)
 	return 0;
 
 error_free_device:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_disable_reg:
 	if (!IS_ERR(reg))
 		regulator_disable(reg);
@@ -399,7 +399,7 @@ static int ad5446_remove(struct spi_device *spi)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index 796691e..1965b89 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -288,7 +288,7 @@ static int __devinit ad5504_probe(struct spi_device *spi)
 	struct regulator *reg;
 	int ret, voltage_uv = 0;
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -351,7 +351,7 @@ error_put_reg:
 	if (!IS_ERR(reg))
 		regulator_put(reg);
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -369,7 +369,7 @@ static int __devexit ad5504_remove(struct spi_device *spi)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index 74eb889..fa7a27c 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -256,7 +256,7 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	int ret, voltage_uv = 0;
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -306,7 +306,7 @@ error_disable_reg:
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 
 	return ret;
@@ -322,7 +322,7 @@ static int __devexit ad5624r_remove(struct spi_device *spi)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
index b8acd7e..7688638 100644
--- a/drivers/staging/iio/dac/ad5686.c
+++ b/drivers/staging/iio/dac/ad5686.c
@@ -359,7 +359,7 @@ static int __devinit ad5686_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	int ret, regdone = 0, voltage_uv = 0;
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL)
 		return  -ENOMEM;
 
@@ -411,7 +411,7 @@ error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -426,7 +426,7 @@ static int __devexit ad5686_remove(struct spi_device *spi)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5764.c b/drivers/staging/iio/dac/ad5764.c
index 1c9ff4fc..7d31d70 100644
--- a/drivers/staging/iio/dac/ad5764.c
+++ b/drivers/staging/iio/dac/ad5764.c
@@ -281,7 +281,7 @@ static int __devinit ad5764_probe(struct spi_device *spi)
 	struct ad5764_state *st;
 	int ret;
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		dev_err(&spi->dev, "Failed to allocate iio device\n");
 		return -ENOMEM;
@@ -336,7 +336,7 @@ error_free_reg:
 	if (st->chip_info->int_vref == 0)
 		regulator_bulk_free(ARRAY_SIZE(st->vref_reg), st->vref_reg);
 error_free:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -353,7 +353,7 @@ static int __devexit ad5764_remove(struct spi_device *spi)
 		regulator_bulk_free(ARRAY_SIZE(st->vref_reg), st->vref_reg);
 	}
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index cdb7b10..6b676f4 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -289,7 +289,7 @@ static int __devinit ad5791_probe(struct spi_device *spi)
 	struct ad5791_state *st;
 	int ret, pos_voltage_uv = 0, neg_voltage_uv = 0;
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -369,7 +369,7 @@ error_put_reg_neg:
 error_put_reg_pos:
 	if (!IS_ERR(st->reg_vdd))
 		regulator_put(st->reg_vdd);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 
 	return ret;
@@ -390,7 +390,7 @@ static int __devexit ad5791_remove(struct spi_device *spi)
 		regulator_disable(st->reg_vss);
 		regulator_put(st->reg_vss);
 	}
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
index 41483c7..196527c 100644
--- a/drivers/staging/iio/dac/max517.c
+++ b/drivers/staging/iio/dac/max517.c
@@ -218,7 +218,7 @@ static int max517_probe(struct i2c_client *client,
 	struct max517_platform_data *platform_data = client->dev.platform_data;
 	int err;
 
-	indio_dev = iio_allocate_device(sizeof(*data));
+	indio_dev = iio_device_alloc(sizeof(*data));
 	if (indio_dev == NULL) {
 		err = -ENOMEM;
 		goto exit;
@@ -257,14 +257,14 @@ static int max517_probe(struct i2c_client *client,
 	return 0;
 
 exit_free_device:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 exit:
 	return err;
 }
 
 static int max517_remove(struct i2c_client *client)
 {
-	iio_free_device(i2c_get_clientdata(client));
+	iio_device_free(i2c_get_clientdata(client));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dds/ad5930.c b/drivers/staging/iio/dds/ad5930.c
index 9c32d1b..b044300 100644
--- a/drivers/staging/iio/dds/ad5930.c
+++ b/drivers/staging/iio/dds/ad5930.c
@@ -97,7 +97,7 @@ static int __devinit ad5930_probe(struct spi_device *spi)
 	struct iio_dev *idev;
 	int ret = 0;
 
-	idev = iio_allocate_device(sizeof(*st));
+	idev = iio_device_alloc(sizeof(*st));
 	if (idev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -122,7 +122,7 @@ static int __devinit ad5930_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(idev);
+	iio_device_free(idev);
 error_ret:
 	return ret;
 }
@@ -130,7 +130,7 @@ error_ret:
 static int __devexit ad5930_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
-	iio_free_device(spi_get_drvdata(spi));
+	iio_device_free(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dds/ad9832.c b/drivers/staging/iio/dds/ad9832.c
index 2ccf25d..7c08f1a 100644
--- a/drivers/staging/iio/dds/ad9832.c
+++ b/drivers/staging/iio/dds/ad9832.c
@@ -221,7 +221,7 @@ static int __devinit ad9832_probe(struct spi_device *spi)
 			goto error_put_reg;
 	}
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
@@ -313,7 +313,7 @@ static int __devinit ad9832_probe(struct spi_device *spi)
 	return 0;
 
 error_free_device:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_disable_reg:
 	if (!IS_ERR(reg))
 		regulator_disable(reg);
@@ -334,7 +334,7 @@ static int __devexit ad9832_remove(struct spi_device *spi)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
index 38a2de0..f1ab7f4 100644
--- a/drivers/staging/iio/dds/ad9834.c
+++ b/drivers/staging/iio/dds/ad9834.c
@@ -334,7 +334,7 @@ static int __devinit ad9834_probe(struct spi_device *spi)
 			goto error_put_reg;
 	}
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
@@ -414,7 +414,7 @@ static int __devinit ad9834_probe(struct spi_device *spi)
 	return 0;
 
 error_free_device:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_disable_reg:
 	if (!IS_ERR(reg))
 		regulator_disable(reg);
@@ -434,7 +434,7 @@ static int __devexit ad9834_remove(struct spi_device *spi)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dds/ad9850.c b/drivers/staging/iio/dds/ad9850.c
index f4f731b..9c5095d 100644
--- a/drivers/staging/iio/dds/ad9850.c
+++ b/drivers/staging/iio/dds/ad9850.c
@@ -83,7 +83,7 @@ static int __devinit ad9850_probe(struct spi_device *spi)
 	struct iio_dev *idev;
 	int ret = 0;
 
-	idev = iio_allocate_device(sizeof(*st));
+	idev = iio_device_alloc(sizeof(*st));
 	if (idev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -108,7 +108,7 @@ static int __devinit ad9850_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(idev);
+	iio_device_free(idev);
 error_ret:
 	return ret;
 }
@@ -116,7 +116,7 @@ error_ret:
 static int __devexit ad9850_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
-	iio_free_device(spi_get_drvdata(spi));
+	iio_device_free(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dds/ad9852.c b/drivers/staging/iio/dds/ad9852.c
index 554266c..2581685 100644
--- a/drivers/staging/iio/dds/ad9852.c
+++ b/drivers/staging/iio/dds/ad9852.c
@@ -232,7 +232,7 @@ static int __devinit ad9852_probe(struct spi_device *spi)
 	struct iio_dev *idev;
 	int ret = 0;
 
-	idev = iio_allocate_device(sizeof(*st));
+	idev = iio_device_alloc(sizeof(*st));
 	if (idev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -258,7 +258,7 @@ static int __devinit ad9852_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(idev);
+	iio_device_free(idev);
 
 error_ret:
 	return ret;
@@ -267,7 +267,7 @@ error_ret:
 static int __devexit ad9852_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
-	iio_free_device(spi_get_drvdata(spi));
+	iio_device_free(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dds/ad9910.c b/drivers/staging/iio/dds/ad9910.c
index 3985766..9cfc13d 100644
--- a/drivers/staging/iio/dds/ad9910.c
+++ b/drivers/staging/iio/dds/ad9910.c
@@ -367,7 +367,7 @@ static int __devinit ad9910_probe(struct spi_device *spi)
 	struct iio_dev *idev;
 	int ret = 0;
 
-	idev = iio_allocate_device(sizeof(*st));
+	idev = iio_device_alloc(sizeof(*st));
 	if (idev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -392,7 +392,7 @@ static int __devinit ad9910_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(idev);
+	iio_device_free(idev);
 error_ret:
 	return ret;
 }
@@ -400,7 +400,7 @@ error_ret:
 static int __devexit ad9910_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
-	iio_free_device(spi_get_drvdata(spi));
+	iio_device_free(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dds/ad9951.c b/drivers/staging/iio/dds/ad9951.c
index 4d15004..1e31758 100644
--- a/drivers/staging/iio/dds/ad9951.c
+++ b/drivers/staging/iio/dds/ad9951.c
@@ -176,7 +176,7 @@ static int __devinit ad9951_probe(struct spi_device *spi)
 	struct iio_dev *idev;
 	int ret = 0;
 
-	idev = iio_allocate_device(sizeof(*st));
+	idev = iio_device_alloc(sizeof(*st));
 	if (idev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -202,7 +202,7 @@ static int __devinit ad9951_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(idev);
+	iio_device_free(idev);
 
 error_ret:
 	return ret;
@@ -211,7 +211,7 @@ error_ret:
 static int __devexit ad9951_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
-	iio_free_device(spi_get_drvdata(spi));
+	iio_device_free(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 2f841cb..3933a96 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -152,7 +152,7 @@ static int __devinit adis16060_r_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -178,7 +178,7 @@ static int __devinit adis16060_r_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -187,7 +187,7 @@ error_ret:
 static int adis16060_r_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
-	iio_free_device(spi_get_drvdata(spi));
+	iio_device_free(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index 608b93d..975043f 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -145,7 +145,7 @@ static int __devinit adis16080_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -171,7 +171,7 @@ static int __devinit adis16080_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -180,7 +180,7 @@ error_ret:
 static int adis16080_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
-	iio_free_device(spi_get_drvdata(spi));
+	iio_device_free(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index 257bdf2..26ed4a6 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -123,7 +123,7 @@ static int __devinit adis16130_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -147,7 +147,7 @@ static int __devinit adis16130_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 error_ret:
 	return ret;
@@ -157,7 +157,7 @@ error_ret:
 static int adis16130_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
-	iio_free_device(spi_get_drvdata(spi));
+	iio_device_free(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index bb23018..f12bd36 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -627,7 +627,7 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -712,7 +712,7 @@ error_uninitialize_ring:
 error_unreg_ring_funcs:
 	adis16260_unconfigure_ring(indio_dev);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -733,7 +733,7 @@ static int adis16260_remove(struct spi_device *spi)
 	adis16260_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16260_unconfigure_ring(indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 err_ret:
 	return ret;
diff --git a/drivers/staging/iio/gyro/adis16260_trigger.c b/drivers/staging/iio/gyro/adis16260_trigger.c
index 8299cd1..963c950 100644
--- a/drivers/staging/iio/gyro/adis16260_trigger.c
+++ b/drivers/staging/iio/gyro/adis16260_trigger.c
@@ -29,7 +29,7 @@ int adis16260_probe_trigger(struct iio_dev *indio_dev)
 	int ret;
 	struct adis16260_state *st = iio_priv(indio_dev);
 
-	st->trig = iio_allocate_trigger("%s-dev%d",
+	st->trig = iio_trigger_alloc("%s-dev%d",
 					spi_get_device_id(st->us)->name,
 					indio_dev->id);
 	if (st->trig == NULL) {
@@ -60,7 +60,7 @@ int adis16260_probe_trigger(struct iio_dev *indio_dev)
 error_free_irq:
 	free_irq(st->us->irq, st->trig);
 error_free_trig:
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 error_ret:
 	return ret;
 }
@@ -71,5 +71,5 @@ void adis16260_remove_trigger(struct iio_dev *indio_dev)
 
 	iio_trigger_unregister(st->trig);
 	free_irq(st->us->irq, st->trig);
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 }
diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 1293505..c5c14eb 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -372,7 +372,7 @@ static int __devinit adxrs450_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -403,7 +403,7 @@ static int __devinit adxrs450_probe(struct spi_device *spi)
 error_initial:
 	iio_device_unregister(indio_dev);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 error_ret:
 	return ret;
@@ -412,7 +412,7 @@ error_ret:
 static int adxrs450_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
-	iio_free_device(spi_get_drvdata(spi));
+	iio_device_free(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 0770340..3153f4d 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -400,10 +400,10 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
 extern struct bus_type iio_bus_type;
 
 /**
- * iio_put_device() - reference counted deallocation of struct device
+ * iio_device_put() - reference counted deallocation of struct device
  * @dev: the iio_device containing the device
  **/
-static inline void iio_put_device(struct iio_dev *indio_dev)
+static inline void iio_device_put(struct iio_dev *indio_dev)
 {
 	if (indio_dev)
 		put_device(&indio_dev->dev);
@@ -412,10 +412,10 @@ static inline void iio_put_device(struct iio_dev *indio_dev)
 /* Can we make this smaller? */
 #define IIO_ALIGN L1_CACHE_BYTES
 /**
- * iio_allocate_device() - allocate an iio_dev from a driver
+ * iio_device_alloc() - allocate an iio_dev from a driver
  * @sizeof_priv: Space to allocate for private structure.
  **/
-struct iio_dev *iio_allocate_device(int sizeof_priv);
+struct iio_dev *iio_device_alloc(int sizeof_priv);
 
 static inline void *iio_priv(const struct iio_dev *indio_dev)
 {
@@ -429,10 +429,10 @@ static inline struct iio_dev *iio_priv_to_dev(void *priv)
 }
 
 /**
- * iio_free_device() - free an iio_dev from a driver
+ * iio_device_free() - free an iio_dev from a driver
  * @dev: the iio_dev associated with the device
  **/
-void iio_free_device(struct iio_dev *indio_dev);
+void iio_device_free(struct iio_dev *indio_dev);
 
 /**
  * iio_buffer_enabled() - helper function to test if the buffer is enabled
diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index dbeb04c..31c5135 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -392,7 +392,7 @@ static int __devinit iio_dummy_probe(int index)
 	 * It also has a region (accessed by iio_priv()
 	 * for chip specific state information.
 	 */
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -472,7 +472,7 @@ error_unregister_events:
 error_free_device:
 	/* Note free device should only be called, before registration
 	 * has succeeded. */
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -509,7 +509,7 @@ static int iio_dummy_remove(int index)
 		goto error_ret;
 
 	/* Free all structures */
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 error_ret:
 	return ret;
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 8a0485e..b189273 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -705,7 +705,7 @@ static int __devinit ad5933_probe(struct i2c_client *client,
 	int ret, voltage_uv = 0;
 	struct ad5933_platform_data *pdata = client->dev.platform_data;
 	struct ad5933_state *st;
-	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
+	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -784,7 +784,7 @@ error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -801,7 +801,7 @@ static __devexit int ad5933_remove(struct i2c_client *client)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 58a150c..e9245d3 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -1161,7 +1161,7 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 {
 	int ret;
 	struct adis16400_state *st;
-	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
+	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret =  -ENOMEM;
 		goto error_ret;
@@ -1218,7 +1218,7 @@ error_uninitialize_ring:
 error_unreg_ring_funcs:
 	adis16400_unconfigure_ring(indio_dev);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -1237,7 +1237,7 @@ static int adis16400_remove(struct spi_device *spi)
 	adis16400_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16400_unconfigure_ring(indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 
diff --git a/drivers/staging/iio/imu/adis16400_trigger.c b/drivers/staging/iio/imu/adis16400_trigger.c
index 5bf0007..2e40bb9 100644
--- a/drivers/staging/iio/imu/adis16400_trigger.c
+++ b/drivers/staging/iio/imu/adis16400_trigger.c
@@ -29,7 +29,7 @@ int adis16400_probe_trigger(struct iio_dev *indio_dev)
 	int ret;
 	struct adis16400_state *st = iio_priv(indio_dev);
 
-	st->trig = iio_allocate_trigger("%s-dev%d",
+	st->trig = iio_trigger_alloc("%s-dev%d",
 					indio_dev->name,
 					indio_dev->id);
 	if (st->trig == NULL) {
@@ -59,7 +59,7 @@ int adis16400_probe_trigger(struct iio_dev *indio_dev)
 error_free_irq:
 	free_irq(st->us->irq, st->trig);
 error_free_trig:
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 error_ret:
 	return ret;
 }
@@ -70,5 +70,5 @@ void adis16400_remove_trigger(struct iio_dev *indio_dev)
 
 	iio_trigger_unregister(st->trig);
 	free_irq(st->us->irq, st->trig);
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 }
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index db55b81..4adae9c 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -737,7 +737,7 @@ static struct device_type iio_dev_type = {
 	.release = iio_dev_release,
 };
 
-struct iio_dev *iio_allocate_device(int sizeof_priv)
+struct iio_dev *iio_device_alloc(int sizeof_priv)
 {
 	struct iio_dev *dev;
 	size_t alloc_size;
@@ -773,16 +773,16 @@ struct iio_dev *iio_allocate_device(int sizeof_priv)
 
 	return dev;
 }
-EXPORT_SYMBOL(iio_allocate_device);
+EXPORT_SYMBOL(iio_device_alloc);
 
-void iio_free_device(struct iio_dev *dev)
+void iio_device_free(struct iio_dev *dev)
 {
 	if (dev) {
 		ida_simple_remove(&iio_ida, dev->id);
 		kfree(dev);
 	}
 }
-EXPORT_SYMBOL(iio_free_device);
+EXPORT_SYMBOL(iio_device_free);
 
 /**
  * iio_chrdev_open() - chrdev file open for buffer access and ioctls
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 47ecadd..c21b624 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -360,9 +360,9 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 	indio_dev->trig = trig;
 
 	if (oldtrig && indio_dev->trig != oldtrig)
-		iio_put_trigger(oldtrig);
+		iio_trigger_put(oldtrig);
 	if (indio_dev->trig)
-		iio_get_trigger(indio_dev->trig);
+		iio_trigger_get(indio_dev->trig);
 
 	return len;
 }
@@ -426,7 +426,7 @@ static void iio_trig_subirqunmask(struct irq_data *d)
 	trig->subirqs[d->irq - trig->subirq_base].enabled = true;
 }
 
-struct iio_trigger *iio_allocate_trigger(const char *fmt, ...)
+struct iio_trigger *iio_trigger_alloc(const char *fmt, ...)
 {
 	va_list vargs;
 	struct iio_trigger *trig;
@@ -472,14 +472,14 @@ struct iio_trigger *iio_allocate_trigger(const char *fmt, ...)
 	}
 	return trig;
 }
-EXPORT_SYMBOL(iio_allocate_trigger);
+EXPORT_SYMBOL(iio_trigger_alloc);
 
-void iio_free_trigger(struct iio_trigger *trig)
+void iio_trigger_free(struct iio_trigger *trig)
 {
 	if (trig)
 		put_device(&trig->dev);
 }
-EXPORT_SYMBOL(iio_free_trigger);
+EXPORT_SYMBOL(iio_trigger_free);
 
 void iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
 {
@@ -491,7 +491,7 @@ void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
 {
 	/* Clean up and associated but not attached triggers references */
 	if (indio_dev->trig)
-		iio_put_trigger(indio_dev->trig);
+		iio_trigger_put(indio_dev->trig);
 }
 
 int iio_triggered_buffer_postenable(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 2c894a6..028bed8 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -532,7 +532,7 @@ static int __devinit isl29018_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int err;
 
-	indio_dev = iio_allocate_device(sizeof(*chip));
+	indio_dev = iio_device_alloc(sizeof(*chip));
 	if (indio_dev == NULL) {
 		dev_err(&client->dev, "iio allocation fails\n");
 		err = -ENOMEM;
@@ -574,7 +574,7 @@ static int __devinit isl29018_probe(struct i2c_client *client,
 
 	return 0;
 exit_iio_free:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 exit:
 	return err;
 }
@@ -585,7 +585,7 @@ static int __devexit isl29018_remove(struct i2c_client *client)
 
 	dev_dbg(&client->dev, "%s()\n", __func__);
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 7057d9b..768d818 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -482,7 +482,7 @@ static int __devinit isl29028_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = iio_allocate_device(sizeof(*chip));
+	indio_dev = iio_device_alloc(sizeof(*chip));
 	if (!indio_dev) {
 		dev_err(&client->dev, "iio allocation fails\n");
 		return -ENOMEM;
@@ -522,7 +522,7 @@ static int __devinit isl29028_probe(struct i2c_client *client,
 	return 0;
 
 exit_iio_free:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 	return ret;
 }
 
@@ -531,7 +531,7 @@ static int __devexit isl29028_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 	return 0;
 }
 
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index a1e5cbe..2fac0c4 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -714,7 +714,7 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 	int err = 0;
 	u8 id = 0;
 
-	indio_dev = iio_allocate_device(sizeof(*chip));
+	indio_dev = iio_device_alloc(sizeof(*chip));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -801,7 +801,7 @@ fail2:
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
 fail1:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 	return err;
 }
 
@@ -822,7 +822,7 @@ static int tsl2563_remove(struct i2c_client *client)
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 8671d98..c63619b 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -815,7 +815,7 @@ static int __devinit taos_probe(struct i2c_client *clientp,
 		return -EOPNOTSUPP;
 	}
 
-	indio_dev = iio_allocate_device(sizeof(*chip));
+	indio_dev = iio_device_alloc(sizeof(*chip));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		dev_err(&clientp->dev, "iio allocation failed\n");
@@ -879,7 +879,7 @@ static int __devinit taos_probe(struct i2c_client *clientp,
 	dev_info(&clientp->dev, "Light sensor found.\n");
 	return 0;
 fail1:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 fail2:
 	return ret;
 }
@@ -926,7 +926,7 @@ static SIMPLE_DEV_PM_OPS(taos_pm_ops, taos_suspend, taos_resume);
 static int __devexit taos_remove(struct i2c_client *client)
 {
 	iio_device_unregister(i2c_get_clientdata(client));
-	iio_free_device(i2c_get_clientdata(client));
+	iio_device_free(i2c_get_clientdata(client));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index f3fc85a..dc91240 100755
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -1906,7 +1906,7 @@ static int __devinit tsl2x7x_probe(struct i2c_client *clientp,
 	struct iio_dev *indio_dev;
 	struct tsl2X7X_chip *chip;
 
-	indio_dev = iio_allocate_device(sizeof(*chip));
+	indio_dev = iio_device_alloc(sizeof(*chip));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1986,7 +1986,7 @@ fail1:
 	if (clientp->irq)
 		free_irq(clientp->irq, indio_dev);
 fail2:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -2038,7 +2038,7 @@ static int __devexit tsl2x7x_remove(struct i2c_client *client)
 	if (client->irq)
 		free_irq(client->irq, chip->client->name);
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 000886f..987cb8f 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -504,7 +504,7 @@ static int ak8975_probe(struct i2c_client *client,
 	}
 
 	/* Register with IIO */
-	indio_dev = iio_allocate_device(sizeof(*data));
+	indio_dev = iio_device_alloc(sizeof(*data));
 	if (indio_dev == NULL) {
 		err = -ENOMEM;
 		goto exit_gpio;
@@ -535,7 +535,7 @@ static int ak8975_probe(struct i2c_client *client,
 	return 0;
 
 exit_free_iio:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 exit_gpio:
 	if (gpio_is_valid(eoc_gpio))
 		gpio_free(eoc_gpio);
@@ -553,7 +553,7 @@ static int ak8975_remove(struct i2c_client *client)
 	if (gpio_is_valid(data->eoc_gpio))
 		gpio_free(data->eoc_gpio);
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 27c2629..37f1f8f 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -544,7 +544,7 @@ static int hmc5843_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int err = 0;
 
-	indio_dev = iio_allocate_device(sizeof(*data));
+	indio_dev = iio_device_alloc(sizeof(*data));
 	if (indio_dev == NULL) {
 		err = -ENOMEM;
 		goto exit;
@@ -572,7 +572,7 @@ static int hmc5843_probe(struct i2c_client *client,
 		goto exit_free2;
 	return 0;
 exit_free2:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 exit:
 	return err;
 }
@@ -584,7 +584,7 @@ static int hmc5843_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 	 /*  sleep mode to save power */
 	hmc5843_configure(client, MODE_SLEEP);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 57baac6..230789a 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -517,7 +517,7 @@ static int __devinit ade7753_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -546,7 +546,7 @@ static int __devinit ade7753_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 error_ret:
 	return ret;
@@ -564,7 +564,7 @@ static int ade7753_remove(struct spi_device *spi)
 	if (ret)
 		goto err_ret;
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 err_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 8d81c92..169d7df 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -540,7 +540,7 @@ static int __devinit ade7754_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -568,7 +568,7 @@ static int __devinit ade7754_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 error_ret:
 	return ret;
@@ -585,7 +585,7 @@ static int ade7754_remove(struct spi_device *spi)
 	if (ret)
 		goto err_ret;
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 err_ret:
 	return ret;
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 729c033..01fc41e 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -885,7 +885,7 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 {
 	int i, ret;
 	struct ade7758_state *st;
-	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
+	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
 
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
@@ -962,7 +962,7 @@ error_free_tx:
 error_free_rx:
 	kfree(st->rx);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -984,7 +984,7 @@ static int ade7758_remove(struct spi_device *spi)
 	kfree(st->tx);
 	kfree(st->rx);
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 err_ret:
 	return ret;
diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
index b6569c7..670013b 100644
--- a/drivers/staging/iio/meter/ade7758_trigger.c
+++ b/drivers/staging/iio/meter/ade7758_trigger.c
@@ -63,7 +63,7 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
 	struct ade7758_state *st = iio_priv(indio_dev);
 	int ret;
 
-	st->trig = iio_allocate_trigger("%s-dev%d",
+	st->trig = iio_trigger_alloc("%s-dev%d",
 					spi_get_device_id(st->us)->name,
 					indio_dev->id);
 	if (st->trig == NULL) {
@@ -94,7 +94,7 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
 error_free_irq:
 	free_irq(st->us->irq, st->trig);
 error_free_trig:
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 error_ret:
 	return ret;
 }
@@ -105,5 +105,5 @@ void ade7758_remove_trigger(struct iio_dev *indio_dev)
 
 	iio_trigger_unregister(st->trig);
 	free_irq(st->us->irq, st->trig);
-	iio_free_trigger(st->trig);
+	iio_trigger_free(st->trig);
 }
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 0beab47..29ec265 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -463,7 +463,7 @@ static int __devinit ade7759_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -491,7 +491,7 @@ static int __devinit ade7759_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -507,7 +507,7 @@ static int ade7759_remove(struct spi_device *spi)
 	if (ret)
 		goto err_ret;
 
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 err_ret:
 	return ret;
diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 1e1faa0..1273c22 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -208,7 +208,7 @@ static int __devinit ade7854_i2c_probe(struct i2c_client *client,
 	struct ade7854_state *st;
 	struct iio_dev *indio_dev;
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
@@ -226,7 +226,7 @@ static int __devinit ade7854_i2c_probe(struct i2c_client *client,
 
 	ret = ade7854_probe(indio_dev, &client->dev);
 	if (ret)
-		iio_free_device(indio_dev);
+		iio_device_free(indio_dev);
 
 	return ret;
 }
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 8112186..f292e2f 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -306,7 +306,7 @@ static int __devinit ade7854_spi_probe(struct spi_device *spi)
 	struct ade7854_state *st;
 	struct iio_dev *indio_dev;
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
@@ -325,7 +325,7 @@ static int __devinit ade7854_spi_probe(struct spi_device *spi)
 
 	ret = ade7854_probe(indio_dev, &spi->dev);
 	if (ret)
-		iio_free_device(indio_dev);
+		iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 49c01c5..21260ea 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -581,7 +581,7 @@ int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)
 error_unreg_dev:
 	iio_device_unregister(indio_dev);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -590,7 +590,7 @@ EXPORT_SYMBOL(ade7854_probe);
 int ade7854_remove(struct iio_dev *indio_dev)
 {
 	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 0465e5d..0c56a34 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -112,7 +112,7 @@ static int __devinit ad2s1200_probe(struct spi_device *spi)
 						DRV_NAME, pins[pn]);
 			goto error_ret;
 		}
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -142,7 +142,7 @@ static int __devinit ad2s1200_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	for (--pn; pn >= 0; pn--)
 		gpio_free(pins[pn]);
@@ -152,7 +152,7 @@ error_ret:
 static int __devexit ad2s1200_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
-	iio_free_device(spi_get_drvdata(spi));
+	iio_device_free(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index c6ced16..e8bf7f6 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -690,7 +690,7 @@ static int __devinit ad2s1210_probe(struct spi_device *spi)
 	if (spi->dev.platform_data == NULL)
 		return -EINVAL;
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -731,7 +731,7 @@ static int __devinit ad2s1210_probe(struct spi_device *spi)
 error_free_gpios:
 	ad2s1210_free_gpios(st);
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -742,7 +742,7 @@ static int __devexit ad2s1210_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 	ad2s1210_free_gpios(iio_priv(indio_dev));
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 20ca529..94b5bd0 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -64,7 +64,7 @@ static int __devinit ad2s90_probe(struct spi_device *spi)
 	struct ad2s90_state *st;
 	int ret = 0;
 
-	indio_dev = iio_allocate_device(sizeof(*st));
+	indio_dev = iio_device_alloc(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -93,7 +93,7 @@ static int __devinit ad2s90_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(indio_dev);
+	iio_device_free(indio_dev);
 error_ret:
 	return ret;
 }
@@ -101,7 +101,7 @@ error_ret:
 static int __devexit ad2s90_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
-	iio_free_device(spi_get_drvdata(spi));
+	iio_device_free(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
index 1cfca23..a981994 100644
--- a/drivers/staging/iio/trigger.h
+++ b/drivers/staging/iio/trigger.h
@@ -78,13 +78,13 @@ static inline struct iio_trigger *to_iio_trigger(struct device *d)
 	return container_of(d, struct iio_trigger, dev);
 };
 
-static inline void iio_put_trigger(struct iio_trigger *trig)
+static inline void iio_trigger_put(struct iio_trigger *trig)
 {
 	module_put(trig->ops->owner);
 	put_device(&trig->dev);
 };
 
-static inline void iio_get_trigger(struct iio_trigger *trig)
+static inline void iio_trigger_get(struct iio_trigger *trig)
 {
 	get_device(&trig->dev);
 	__module_get(trig->ops->owner);
@@ -113,7 +113,7 @@ void iio_trigger_poll_chained(struct iio_trigger *trig, s64 time);
 
 irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private);
 
-__printf(1, 2) struct iio_trigger *iio_allocate_trigger(const char *fmt, ...);
-void iio_free_trigger(struct iio_trigger *trig);
+__printf(1, 2) struct iio_trigger *iio_trigger_alloc(const char *fmt, ...);
+void iio_trigger_free(struct iio_trigger *trig);
 
 #endif /* _IIO_TRIGGER_H_ */
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 665653d..6e9804b 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -172,7 +172,7 @@ static int __devinit iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
 	st->timer_num = ret;
 	st->t = &iio_bfin_timer_code[st->timer_num];
 
-	st->trig = iio_allocate_trigger("bfintmr%d", st->timer_num);
+	st->trig = iio_trigger_alloc("bfintmr%d", st->timer_num);
 	if (!st->trig) {
 		ret = -ENOMEM;
 		goto out1;
@@ -203,7 +203,7 @@ static int __devinit iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
 out4:
 	iio_trigger_unregister(st->trig);
 out2:
-	iio_put_trigger(st->trig);
+	iio_trigger_put(st->trig);
 out1:
 	kfree(st);
 out:
@@ -217,7 +217,7 @@ static int __devexit iio_bfin_tmr_trigger_remove(struct platform_device *pdev)
 	disable_gptimers(st->t->bit);
 	free_irq(st->irq, st);
 	iio_trigger_unregister(st->trig);
-	iio_put_trigger(st->trig);
+	iio_trigger_put(st->trig);
 	kfree(st);
 
 	return 0;
diff --git a/drivers/staging/iio/trigger/iio-trig-gpio.c b/drivers/staging/iio/trigger/iio-trig-gpio.c
index a346594..8683e70 100644
--- a/drivers/staging/iio/trigger/iio-trig-gpio.c
+++ b/drivers/staging/iio/trigger/iio-trig-gpio.c
@@ -72,7 +72,7 @@ static int iio_gpio_trigger_probe(struct platform_device *pdev)
 
 		for (irq = irq_res->start; irq <= irq_res->end; irq++) {
 
-			trig = iio_allocate_trigger("irqtrig%d", irq);
+			trig = iio_trigger_alloc("irqtrig%d", irq);
 			if (!trig) {
 				ret = -ENOMEM;
 				goto error_free_completed_registrations;
@@ -114,7 +114,7 @@ error_release_irq:
 error_free_trig_info:
 	kfree(trig_info);
 error_put_trigger:
-	iio_put_trigger(trig);
+	iio_trigger_put(trig);
 error_free_completed_registrations:
 	/* The rest should have been added to the iio_gpio_trigger_list */
 	list_for_each_entry_safe(trig,
@@ -144,7 +144,7 @@ static int iio_gpio_trigger_remove(struct platform_device *pdev)
 		iio_trigger_unregister(trig);
 		free_irq(trig_info->irq, trig);
 		kfree(trig_info);
-		iio_put_trigger(trig);
+		iio_trigger_put(trig);
 	}
 	mutex_unlock(&iio_gpio_trigger_list_lock);
 
diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index a80cf67..902cf7f 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -112,7 +112,7 @@ static int iio_trig_periodic_rtc_probe(struct platform_device *dev)
 	for (i = 0;; i++) {
 		if (pdata[i] == NULL)
 			break;
-		trig = iio_allocate_trigger("periodic%s", pdata[i]);
+		trig = iio_trigger_alloc("periodic%s", pdata[i]);
 		if (!trig) {
 			ret = -ENOMEM;
 			goto error_free_completed_registrations;
@@ -152,7 +152,7 @@ error_free_trig_info:
 	kfree(trig_info);
 error_put_trigger_and_remove_from_list:
 	list_del(&trig->alloc_list);
-	iio_put_trigger(trig);
+	iio_trigger_put(trig);
 error_free_completed_registrations:
 	list_for_each_entry_safe(trig,
 				 trig2,
diff --git a/drivers/staging/iio/trigger/iio-trig-sysfs.c b/drivers/staging/iio/trigger/iio-trig-sysfs.c
index 174dc65..65f06a9 100644
--- a/drivers/staging/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/staging/iio/trigger/iio-trig-sysfs.c
@@ -139,7 +139,7 @@ static int iio_sysfs_trigger_probe(int id)
 		goto out1;
 	}
 	t->id = id;
-	t->trig = iio_allocate_trigger("sysfstrig%d", id);
+	t->trig = iio_trigger_alloc("sysfstrig%d", id);
 	if (!t->trig) {
 		ret = -ENOMEM;
 		goto free_t;
@@ -158,7 +158,7 @@ static int iio_sysfs_trigger_probe(int id)
 	return 0;
 
 out2:
-	iio_put_trigger(t->trig);
+	iio_trigger_put(t->trig);
 free_t:
 	kfree(t);
 out1:
@@ -182,7 +182,7 @@ static int iio_sysfs_trigger_remove(int id)
 	}
 
 	iio_trigger_unregister(t->trig);
-	iio_free_trigger(t->trig);
+	iio_trigger_free(t->trig);
 
 	list_del(&t->l);
 	kfree(t);
-- 
1.7.9.5

