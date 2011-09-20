Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:43199 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab1ITQLR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2011 12:11:17 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org, greg@kroah.com
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 06/14] staging:iio: tree wide IIO_RING_TRIGGERED -> IIO_BUFFER_TRIGGERED
Date: Tue, 20 Sep 2011 17:11:05 +0100
Message-Id: <1316535073-21444-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316535073-21444-1-git-send-email-jic23@cam.ac.uk>
References: <1316535073-21444-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

also, IIO_RING_HARDWARE_BUFFER -> IIO_BUFFER_HARDWARE

These aren't always rings so the naming should not imply that.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_ring.c      |    2 +-
 drivers/staging/iio/accel/adis16203_ring.c      |    2 +-
 drivers/staging/iio/accel/adis16204_ring.c      |    2 +-
 drivers/staging/iio/accel/adis16209_ring.c      |    2 +-
 drivers/staging/iio/accel/adis16240_ring.c      |    2 +-
 drivers/staging/iio/accel/lis3l02dq_core.c      |    4 ++--
 drivers/staging/iio/accel/lis3l02dq_ring.c      |    2 +-
 drivers/staging/iio/accel/sca3000_ring.c        |    2 +-
 drivers/staging/iio/adc/ad7192.c                |    2 +-
 drivers/staging/iio/adc/ad7298_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7476_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7606_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7793.c                |    2 +-
 drivers/staging/iio/adc/ad7887_ring.c           |    2 +-
 drivers/staging/iio/adc/ad799x_ring.c           |    2 +-
 drivers/staging/iio/adc/max1363_ring.c          |    2 +-
 drivers/staging/iio/gyro/adis16260_ring.c       |    2 +-
 drivers/staging/iio/iio.h                       |   10 +++++-----
 drivers/staging/iio/impedance-analyzer/ad5933.c |    2 +-
 drivers/staging/iio/imu/adis16400_core.c        |    2 +-
 drivers/staging/iio/imu/adis16400_ring.c        |    2 +-
 drivers/staging/iio/industrialio-core.c         |    4 ++--
 drivers/staging/iio/industrialio-ring.c         |   16 ++++++++--------
 drivers/staging/iio/industrialio-trigger.c      |    2 +-
 drivers/staging/iio/meter/ade7758_core.c        |    2 +-
 drivers/staging/iio/meter/ade7758_ring.c        |    2 +-
 26 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 47be20a..52679b9 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -132,7 +132,7 @@ int adis16201_configure_ring(struct iio_dev *indio_dev)
 		goto error_iio_sw_rb_free;
 	}
 
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index d86f86d..c694e87 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -134,7 +134,7 @@ int adis16203_configure_ring(struct iio_dev *indio_dev)
 		goto error_iio_sw_rb_free;
 	}
 
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_iio_sw_rb_free:
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index 8cc1499..8e2a976 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -130,7 +130,7 @@ int adis16204_configure_ring(struct iio_dev *indio_dev)
 		goto error_iio_sw_rb_free;
 	}
 
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_iio_sw_rb_free:
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 941fc5a..ca2c281 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -130,7 +130,7 @@ int adis16209_configure_ring(struct iio_dev *indio_dev)
 		goto error_iio_sw_rb_free;
 	}
 
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_iio_sw_rb_free:
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index e52ad2e..6119f4b 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -127,7 +127,7 @@ int adis16240_configure_ring(struct iio_dev *indio_dev)
 		goto error_iio_sw_rb_free;
 	}
 
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_iio_sw_rb_free:
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index ee91cc7..52b3a12 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -259,7 +259,7 @@ static int lis3l02dq_read_raw(struct iio_dev *indio_dev,
 	case 0:
 		/* Take the iio_dev status lock */
 		mutex_lock(&indio_dev->mlock);
-		if (indio_dev->currentmode == INDIO_RING_TRIGGERED)
+		if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
 			ret = lis3l02dq_read_accel_from_ring(indio_dev->ring,
 							     chan->scan_index,
 							     val);
@@ -725,7 +725,7 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	return 0;
 
 error_remove_trigger:
-	if (indio_dev->modes & INDIO_RING_TRIGGERED)
+	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
 		lis3l02dq_remove_trigger(indio_dev);
 error_free_interrupt:
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index eaecda4..1f35fdc 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -455,7 +455,7 @@ int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 		goto error_iio_sw_rb_free;
 	}
 
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_iio_sw_rb_free:
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 996b01e..2a83e8a 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -290,7 +290,7 @@ int sca3000_configure_ring(struct iio_dev *indio_dev)
 	indio_dev->ring = sca3000_rb_allocate(indio_dev);
 	if (indio_dev->ring == NULL)
 		return -ENOMEM;
-	indio_dev->modes |= INDIO_RING_HARDWARE_BUFFER;
+	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
 
 	indio_dev->ring->access = &sca3000_ring_access_funcs;
 
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 3f4e911..4b56490 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -595,7 +595,7 @@ static int ad7192_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->ring->setup_ops = &ad7192_ring_setup_ops;
 
 	/* Flag that polled ring buffering is possible */
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_deallocate_sw_rb:
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index 9c5ac9d..2315ee9 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -178,7 +178,7 @@ int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->ring->scan_timestamp = true;
 
 	/* Flag that polled ring buffering is possible */
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_deallocate_sw_rb:
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index 3cc673c..e48181a 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -141,7 +141,7 @@ int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->ring->scan_timestamp = true;
 
 	/* Flag that polled ring buffering is possible */
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_deallocate_sw_rb:
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 320ec68..15bdec6 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -186,7 +186,7 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
 
 	/* Flag that polled ring buffering is possible */
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_deallocate_sw_rb:
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 565199d..e21593d 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -461,7 +461,7 @@ static int ad7793_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->ring->setup_ops = &ad7793_ring_setup_ops;
 
 	/* Flag that polled ring buffering is possible */
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_deallocate_sw_rb:
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index 159aeb1..678c877 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -179,7 +179,7 @@ int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->ring->setup_ops = &ad7887_ring_setup_ops;
 
 	/* Flag that polled ring buffering is possible */
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_deallocate_sw_rb:
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 7b6488d..8177de5 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -187,7 +187,7 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->ring->scan_timestamp = true;
 
 	/* Flag that polled ring buffering is possible */
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_deallocate_sw_rb:
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index ef1c95f..570c686 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -182,7 +182,7 @@ int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->ring->setup_ops = &max1363_ring_setup_ops;
 
 	/* Flag that polled ring buffering is possible */
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 
 	return 0;
 
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 2b1c65a..7169d92 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -131,7 +131,7 @@ int adis16260_configure_ring(struct iio_dev *indio_dev)
 		goto error_iio_sw_rb_free;
 	}
 
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 
 error_iio_sw_rb_free:
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 8ef04f8..0f657c7 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -189,10 +189,11 @@ static inline s64 iio_get_time_ns(void)
 
 /* Device operating modes */
 #define INDIO_DIRECT_MODE		0x01
-#define INDIO_RING_TRIGGERED		0x02
-#define INDIO_RING_HARDWARE_BUFFER	0x08
+#define INDIO_BUFFER_TRIGGERED		0x02
+#define INDIO_BUFFER_HARDWARE		0x08
 
-#define INDIO_ALL_RING_MODES (INDIO_RING_TRIGGERED | INDIO_RING_HARDWARE_BUFFER)
+#define INDIO_ALL_BUFFER_MODES					\
+	(INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE)
 
 /* Vast majority of this is set by the industrialio subsystem on a
  * call to iio_device_register. */
@@ -388,8 +389,7 @@ void iio_free_device(struct iio_dev *dev);
 static inline bool iio_ring_enabled(struct iio_dev *dev_info)
 {
 	return dev_info->currentmode
-		& (INDIO_RING_TRIGGERED
-		   | INDIO_RING_HARDWARE_BUFFER);
+		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE);
 };
 
 #endif /* _INDUSTRIAL_IO_H_ */
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 6d1086b..25223d8 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -612,7 +612,7 @@ static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	/* Ring buffer functions - here trigger setup related */
 	indio_dev->ring->setup_ops = &ad5933_ring_setup_ops;
 
-	indio_dev->modes |= INDIO_RING_HARDWARE_BUFFER;
+	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
 
 	return 0;
 }
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index b6d824f..19dacfb 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -1070,7 +1070,7 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 	return 0;
 
 error_remove_trigger:
-	if (indio_dev->modes & INDIO_RING_TRIGGERED)
+	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
 		adis16400_remove_trigger(indio_dev);
 error_uninitialize_ring:
 	iio_ring_buffer_unregister(indio_dev);
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 421a9fa..a97e1e3 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -203,7 +203,7 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 		goto error_iio_sw_rb_free;
 	}
 
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 	return 0;
 error_iio_sw_rb_free:
 	iio_sw_rb_free(indio_dev->ring);
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 8eba592..bfbfcdd 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -998,7 +998,7 @@ static void iio_dev_release(struct device *device)
 {
 	struct iio_dev *dev_info = container_of(device, struct iio_dev, dev);
 	cdev_del(&dev_info->chrdev);
-	if (dev_info->modes & INDIO_RING_TRIGGERED)
+	if (dev_info->modes & INDIO_BUFFER_TRIGGERED)
 		iio_device_unregister_trigger_consumer(dev_info);
 	iio_device_unregister_eventset(dev_info);
 	iio_device_unregister_sysfs(dev_info);
@@ -1126,7 +1126,7 @@ int iio_device_register(struct iio_dev *dev_info)
 			"Failed to register event set\n");
 		goto error_free_sysfs;
 	}
-	if (dev_info->modes & INDIO_RING_TRIGGERED)
+	if (dev_info->modes & INDIO_BUFFER_TRIGGERED)
 		iio_device_register_trigger_consumer(dev_info);
 
 	ret = device_add(&dev_info->dev);
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index 7a95fbe..e048d34 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -150,7 +150,7 @@ static ssize_t iio_scan_el_store(struct device *dev,
 
 	state = !(buf[0] == '0');
 	mutex_lock(&indio_dev->mlock);
-	if (indio_dev->currentmode == INDIO_RING_TRIGGERED) {
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -193,7 +193,7 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 
 	state = !(buf[0] == '0');
 	mutex_lock(&indio_dev->mlock);
-	if (indio_dev->currentmode == INDIO_RING_TRIGGERED) {
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -430,7 +430,7 @@ ssize_t iio_store_ring_enable(struct device *dev,
 	mutex_lock(&dev_info->mlock);
 	previous_mode = dev_info->currentmode;
 	requested_state = !(buf[0] == '0');
-	current_state = !!(previous_mode & INDIO_ALL_RING_MODES);
+	current_state = !!(previous_mode & INDIO_ALL_BUFFER_MODES);
 	if (current_state == requested_state) {
 		printk(KERN_INFO "iio-ring, current state requested again\n");
 		goto done;
@@ -457,7 +457,7 @@ ssize_t iio_store_ring_enable(struct device *dev,
 		if (ring->access->mark_in_use)
 			ring->access->mark_in_use(ring);
 		/* Definitely possible for devices to support both of these.*/
-		if (dev_info->modes & INDIO_RING_TRIGGERED) {
+		if (dev_info->modes & INDIO_BUFFER_TRIGGERED) {
 			if (!dev_info->trig) {
 				printk(KERN_INFO
 				       "Buffer not started: no trigger\n");
@@ -466,9 +466,9 @@ ssize_t iio_store_ring_enable(struct device *dev,
 					ring->access->unmark_in_use(ring);
 				goto error_ret;
 			}
-			dev_info->currentmode = INDIO_RING_TRIGGERED;
-		} else if (dev_info->modes & INDIO_RING_HARDWARE_BUFFER)
-			dev_info->currentmode = INDIO_RING_HARDWARE_BUFFER;
+			dev_info->currentmode = INDIO_BUFFER_TRIGGERED;
+		} else if (dev_info->modes & INDIO_BUFFER_HARDWARE)
+			dev_info->currentmode = INDIO_BUFFER_HARDWARE;
 		else { /* should never be reached */
 			ret = -EINVAL;
 			goto error_ret;
@@ -519,7 +519,7 @@ ssize_t iio_show_ring_enable(struct device *dev,
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", !!(dev_info->currentmode
-				       & INDIO_ALL_RING_MODES));
+				       & INDIO_ALL_BUFFER_MODES));
 }
 EXPORT_SYMBOL(iio_show_ring_enable);
 
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 00d0e0c..3926649 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -329,7 +329,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 	int ret;
 
 	mutex_lock(&dev_info->mlock);
-	if (dev_info->currentmode == INDIO_RING_TRIGGERED) {
+	if (dev_info->currentmode == INDIO_BUFFER_TRIGGERED) {
 		mutex_unlock(&dev_info->mlock);
 		return -EBUSY;
 	}
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 6507875..1661f31 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -801,7 +801,7 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 	return 0;
 
 error_remove_trigger:
-	if (indio_dev->modes & INDIO_RING_TRIGGERED)
+	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
 		ade7758_remove_trigger(indio_dev);
 error_uninitialize_ring:
 	ade7758_uninitialize_ring(indio_dev);
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index ece2a40..8c7541e 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -158,7 +158,7 @@ int ade7758_configure_ring(struct iio_dev *indio_dev)
 		goto error_iio_sw_rb_free;
 	}
 
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 
 	st->tx_buf[0] = ADE7758_READ_REG(ADE7758_RSTATUS);
 	st->tx_buf[1] = 0;
-- 
1.7.3.4

