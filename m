Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 10/16] staging:iio:sca3000 event attribute name updates
Date: Mon,  4 Oct 2010 16:57:59 +0100
Message-Id: <1286207885-26689-11-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
References: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/sca3000_core.c |   43 +++++++++++++++++------------
 drivers/staging/iio/sysfs.h              |    4 +++
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index b5fa51f..5b06dea 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -774,19 +774,19 @@ static ssize_t sca3000_write_thresh(struct device *dev,
 	return ret ? ret : len;
 }
 
-static IIO_DEVICE_ATTR(accel_x_mag_either_rising_value,
+static IIO_DEVICE_ATTR(accel_x_raw_mag_rising_value,
 		S_IRUGO | S_IWUSR,
 		sca3000_show_thresh,
 		sca3000_write_thresh,
 		SCA3000_REG_CTRL_SEL_MD_X_TH);
 
-static IIO_DEVICE_ATTR(accel_y_mag_either_rising_value,
+static IIO_DEVICE_ATTR(accel_y_raw_mag_rising_value,
 		S_IRUGO | S_IWUSR,
 		sca3000_show_thresh,
 		sca3000_write_thresh,
 		SCA3000_REG_CTRL_SEL_MD_Y_TH);
 
-static IIO_DEVICE_ATTR(accel_z_mag_either_rising_value,
+static IIO_DEVICE_ATTR(accel_z_raw_mag_rising_value,
 		S_IRUGO | S_IWUSR,
 		sca3000_show_thresh,
 		sca3000_write_thresh,
@@ -1172,25 +1172,31 @@ exit_point:
 IIO_EVENT_SH(all, &sca3000_handler_th);
 
 /* Free fall detector related event attribute */
-IIO_EVENT_ATTR_FREE_FALL_DETECT_SH(iio_event_all,
-				   sca3000_query_free_fall_mode,
-				   sca3000_set_free_fall_mode,
-				   0)
+IIO_EVENT_ATTR_NAMED_SH(accel_xayaz_mag_falling_en,
+			accel_x&y&z_mag_falling_en,
+			iio_event_all,
+			sca3000_query_free_fall_mode,
+			sca3000_set_free_fall_mode,
+			0);
+
+IIO_CONST_ATTR_NAMED(accel_xayaz_mag_falling_period,
+		     accel_x&y&z_mag_falling_period,
+		     "0.226");
 
 /* Motion detector related event attributes */
-IIO_EVENT_ATTR_SH(accel_x_mag_either_rising_en,
+IIO_EVENT_ATTR_SH(accel_x_mag_rising_en,
 		  iio_event_all,
 		  sca3000_query_mo_det,
 		  sca3000_set_mo_det,
 		  SCA3000_MD_CTRL_OR_X);
 
-IIO_EVENT_ATTR_SH(accel_y_mag_either_rising_en,
+IIO_EVENT_ATTR_SH(accel_y_mag_rising_en,
 		  iio_event_all,
 		  sca3000_query_mo_det,
 		  sca3000_set_mo_det,
 		  SCA3000_MD_CTRL_OR_Y);
 
-IIO_EVENT_ATTR_SH(accel_z_mag_either_rising_en,
+IIO_EVENT_ATTR_SH(accel_z_mag_rising_en,
 		  iio_event_all,
 		  sca3000_query_mo_det,
 		  sca3000_set_mo_det,
@@ -1208,15 +1214,16 @@ IIO_EVENT_ATTR_RING_75_FULL_SH(iio_event_all,
 			       SCA3000_INT_MASK_RING_THREE_QUARTER);
 
 static struct attribute *sca3000_event_attributes[] = {
-	&iio_event_attr_free_fall.dev_attr.attr,
-	&iio_event_attr_accel_x_mag_either_rising_en.dev_attr.attr,
-	&iio_event_attr_accel_y_mag_either_rising_en.dev_attr.attr,
-	&iio_event_attr_accel_z_mag_either_rising_en.dev_attr.attr,
+	&iio_event_attr_accel_xayaz_mag_falling_en.dev_attr.attr,
+	&iio_const_attr_accel_xayaz_mag_falling_period.dev_attr.attr,
+	&iio_event_attr_accel_x_mag_rising_en.dev_attr.attr,
+	&iio_dev_attr_accel_x_raw_mag_rising_value.dev_attr.attr,
+	&iio_event_attr_accel_y_mag_rising_en.dev_attr.attr,
+	&iio_dev_attr_accel_y_raw_mag_rising_value.dev_attr.attr,
+	&iio_event_attr_accel_z_mag_rising_en.dev_attr.attr,
+	&iio_dev_attr_accel_z_raw_mag_rising_value.dev_attr.attr,
 	&iio_event_attr_ring_50_full.dev_attr.attr,
 	&iio_event_attr_ring_75_full.dev_attr.attr,
-	&iio_dev_attr_accel_x_mag_either_rising_value.dev_attr.attr,
-	&iio_dev_attr_accel_y_mag_either_rising_value.dev_attr.attr,
-	&iio_dev_attr_accel_z_mag_either_rising_value.dev_attr.attr,
 	NULL,
 };
 
@@ -1374,7 +1381,7 @@ static int __devinit __sca3000_probe(struct spi_device *spi,
 		 * might be worthwhile.
 		 */
 		iio_add_event_to_list(
-			iio_event_attr_accel_z_mag_either_rising_en.listel,
+			iio_event_attr_accel_z_mag_rising_en.listel,
 			&st->indio_dev
 			->interrupts[0]->ev_list);
 	}
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 5da6ca6..ee91a95 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -85,6 +85,10 @@ struct iio_const_attr {
 	= { .string = _string,						\
 	    .dev_attr = __ATTR(_name, S_IRUGO, iio_read_const_attr, NULL)}
 
+#define IIO_CONST_ATTR_NAMED(_vname, _name, _string)			\
+	struct iio_const_attr iio_const_attr_##_vname			\
+	= { .string = _string,						\
+	    .dev_attr = __ATTR(_name, S_IRUGO, iio_read_const_attr, NULL)}
 /* Generic attributes of onetype or another */
 
 /**
-- 
1.7.2.2
