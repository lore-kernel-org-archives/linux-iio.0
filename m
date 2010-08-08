Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: vapier@gentoo.org
Cc: barry.song@analog.com,
	uclinux-dist-devel@blackfin.uclinux.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/3] staging:iio:adis16203 update driver to compile with mainline abi.
Date: Sun,  8 Aug 2010 16:08:17 +0100
Message-Id: <1281280098-11111-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1281280098-11111-1-git-send-email-jic23@cam.ac.uk>
References: <1281280098-11111-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16203.h         |    2 --
 drivers/staging/iio/accel/adis16203_core.c    |   19 +++++++++----------
 drivers/staging/iio/accel/adis16203_ring.c    |    4 ++--
 drivers/staging/iio/accel/adis16203_trigger.c |   10 ++++------
 4 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.h b/drivers/staging/iio/accel/adis16203.h
index c2b702a..f0a1d01 100644
--- a/drivers/staging/iio/accel/adis16203.h
+++ b/drivers/staging/iio/accel/adis16203.h
@@ -60,7 +60,6 @@
  * struct adis16203_state - device instance specific data
  * @us:			actual spi_device
  * @work_trigger_to_ring: bh for triggered event handling
- * @work_cont_thresh: CLEAN
  * @inter:		used to check if new interrupt has been triggered
  * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
@@ -72,7 +71,6 @@
 struct adis16203_state {
 	struct spi_device		*us;
 	struct work_struct		work_trigger_to_ring;
-	struct iio_work_cont		work_cont_thresh;
 	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
 	struct iio_trigger		*trig;
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 9ff6bb9..81eeb05 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -22,7 +22,6 @@
 #include "../sysfs.h"
 #include "accel.h"
 #include "inclinometer.h"
-#include "../imu/volt.h"
 #include "../gyro/gyro.h"
 #include "../adc/adc.h"
 
@@ -370,12 +369,12 @@ err_ret:
 	return ret;
 }
 
-static IIO_DEV_ATTR_VOLT(supply, adis16203_read_12bit_unsigned,
+static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16203_read_12bit_unsigned,
 		ADIS16203_SUPPLY_OUT);
-static IIO_CONST_ATTR(volt_supply_scale, "0.00122");
-static IIO_DEV_ATTR_VOLT(aux, adis16203_read_12bit_unsigned,
+static IIO_CONST_ATTR(in_supply_scale, "0.00122");
+static IIO_DEV_ATTR_IN_RAW(0, adis16203_read_12bit_unsigned,
 		ADIS16203_AUX_ADC);
-static IIO_CONST_ATTR(volt_aux_scale, "0.00061");
+static IIO_CONST_ATTR(in0_scale, "0.00061");
 
 static IIO_DEV_ATTR_INCLI_X(adis16203_read_14bit_signed,
 		ADIS16203_XINCL_OUT);
@@ -391,7 +390,7 @@ static IIO_DEV_ATTR_TEMP(adis16203_read_temp);
 static IIO_CONST_ATTR(temp_offset, "25");
 static IIO_CONST_ATTR(temp_scale, "-0.47");
 
-static IIO_DEV_ATTR_RESET(adis16203_write_reset);
+static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16203_write_reset, 0);
 
 static IIO_CONST_ATTR(name, "adis16203");
 
@@ -404,15 +403,15 @@ static struct attribute_group adis16203_event_attribute_group = {
 };
 
 static struct attribute *adis16203_attributes[] = {
-	&iio_dev_attr_volt_supply.dev_attr.attr,
-	&iio_const_attr_volt_supply_scale.dev_attr.attr,
+	&iio_dev_attr_in_supply_raw.dev_attr.attr,
+	&iio_const_attr_in_supply_scale.dev_attr.attr,
 	&iio_dev_attr_temp.dev_attr.attr,
 	&iio_const_attr_temp_offset.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_const_attr_name.dev_attr.attr,
-	&iio_dev_attr_volt_aux.dev_attr.attr,
-	&iio_const_attr_volt_aux_scale.dev_attr.attr,
+	&iio_dev_attr_in0_raw.dev_attr.attr,
+	&iio_const_attr_in0_scale.dev_attr.attr,
 	&iio_dev_attr_incli_x_raw.dev_attr.attr,
 	&iio_dev_attr_incli_y_raw.dev_attr.attr,
 	&iio_dev_attr_incli_x_offset.dev_attr.attr,
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index 6eea34d..77166a0 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -59,10 +59,10 @@ static struct attribute_group adis16203_scan_el_group = {
  * adis16203_poll_func_th() top half interrupt handler called by trigger
  * @private_data:	iio_dev
  **/
-static void adis16203_poll_func_th(struct iio_dev *indio_dev)
+static void adis16203_poll_func_th(struct iio_dev *indio_dev, s64 timestamp)
 {
 	struct adis16203_state *st = iio_dev_get_devdata(indio_dev);
-	st->last_timestamp = indio_dev->trig->timestamp;
+	st->last_timestamp = timestamp;
 	schedule_work(&st->work_trigger_to_ring);
 }
 
diff --git a/drivers/staging/iio/accel/adis16203_trigger.c b/drivers/staging/iio/accel/adis16203_trigger.c
index 8b36ada..50be51c 100644
--- a/drivers/staging/iio/accel/adis16203_trigger.c
+++ b/drivers/staging/iio/accel/adis16203_trigger.c
@@ -23,8 +23,7 @@ static int adis16203_data_rdy_trig_poll(struct iio_dev *dev_info,
 	struct adis16203_state *st = iio_dev_get_devdata(dev_info);
 	struct iio_trigger *trig = st->trig;
 
-	trig->timestamp = timestamp;
-	iio_trigger_poll(trig);
+	iio_trigger_poll(trig, timestamp);
 
 	return IRQ_HANDLED;
 }
@@ -83,14 +82,13 @@ int adis16203_probe_trigger(struct iio_dev *indio_dev)
 	struct adis16203_state *st = indio_dev->dev_data;
 
 	st->trig = iio_allocate_trigger();
-	st->trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
+	st->trig->name = kasprintf(GFP_KERNEL,
+				"adis16203-dev%d",
+				indio_dev->id);
 	if (!st->trig->name) {
 		ret = -ENOMEM;
 		goto error_free_trig;
 	}
-	snprintf((char *)st->trig->name,
-		 IIO_TRIGGER_NAME_LENGTH,
-		 "adis16203-dev%d", indio_dev->id);
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
-- 
1.7.0.4
