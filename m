Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:56699 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755344Ab0IAOxW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2010 10:53:22 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/9] staging:iio: Remove long dead function definitions from headers
Date: Wed,  1 Sep 2010 15:57:58 +0100
Message-Id: <1283353083-31313-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
References: <1283353083-31313-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/chrdev.h |    2 -
 drivers/staging/iio/sysfs.h  |   76 ------------------------------------------
 2 files changed, 0 insertions(+), 78 deletions(-)

diff --git a/drivers/staging/iio/chrdev.h b/drivers/staging/iio/chrdev.h
index fd23bd1..98d1a2c 100644
--- a/drivers/staging/iio/chrdev.h
+++ b/drivers/staging/iio/chrdev.h
@@ -73,7 +73,6 @@ struct iio_shared_ev_pointer {
  * @det_events:		list of detected events
  * @max_events:		maximum number of events before new ones are dropped
  * @current_events:	number of events in detected list
- * @attr:		this chrdev's minor number sysfs attribute
  * @owner:		ensure the driver module owns the file, not iio
  * @private:		driver specific data
  * @_name:		used internally to store the sysfs name for minor id
@@ -88,7 +87,6 @@ struct iio_event_interface {
 	struct iio_detected_event_list		det_events;
 	int					max_events;
 	int					current_events;
-	struct iio_chrdev_minor_attr		attr;
 	struct module				*owner;
 	void					*private;
 	char					_name[35];
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index a4d4bb6..96cc3a7 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -30,27 +30,6 @@ struct iio_event_attr {
 	container_of(_dev_attr, struct iio_event_attr, dev_attr)
 
 /**
- * struct iio_chrdev_minor_attr - simple attribute to allow reading of chrdev
- *				minor number
- * @dev_attr:	underlying device attribute
- * @minor:	the minor number
- */
-struct iio_chrdev_minor_attr {
-	struct device_attribute dev_attr;
-	int minor;
-};
-
-void
-__init_iio_chrdev_minor_attr(struct iio_chrdev_minor_attr *minor_attr,
-			   const char *name,
-			   struct module *owner,
-			   int id);
-
-
-#define to_iio_chrdev_minor_attr(_dev_attr) \
-	container_of(_dev_attr, struct iio_chrdev_minor_attr, dev_attr);
-
-/**
  * struct iio_dev_attr - iio specific device attribute
  * @dev_attr:	underlying device attribute
  * @address:	associated register address
@@ -89,11 +68,6 @@ struct iio_const_attr {
 	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
 	  .address = _addr }
 
-#define IIO_ATTR_2(_name, _mode, _show, _store, _addr, _val2)	\
-	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
-			.address = _addr,			\
-			.val2 = _val2 }
-
 #define IIO_DEVICE_ATTR(_name, _mode, _show, _store, _addr)	\
 	struct iio_dev_attr iio_dev_attr_##_name		\
 	= IIO_ATTR(_name, _mode, _show, _store, _addr)
@@ -167,40 +141,6 @@ struct iio_const_attr {
 	IIO_CONST_ATTR(sampling_frequency_available, _string)
 
 /**
- * IIO_DEV_ATTR_SCAN_MODE - select a scan mode
- * @_mode: sysfs file mode/permissions
- * @_show: output method for the attribute
- * @_store: input method for the attribute
- *
- * This is used when only certain combinations of inputs may be read in one
- * scan.
- **/
-#define IIO_DEV_ATTR_SCAN_MODE(_mode, _show, _store)		\
-	IIO_DEVICE_ATTR(scan_mode, _mode, _show, _store, 0)
-
-/**
- * IIO_DEV_ATTR_AVAIL_SCAN_MODES - list available scan modes
- * @_show: output method for the attribute
- **/
-#define IIO_DEV_ATTR_AVAIL_SCAN_MODES(_show)				\
-	IIO_DEVICE_ATTR(available_scan_modes, S_IRUGO, _show, NULL, 0)
-
-/**
- * IIO_DEV_ATTR_SCAN - result of scan of multiple channels
- * @_show: output method for the attribute
- **/
-#define IIO_DEV_ATTR_SCAN(_show)		\
-	IIO_DEVICE_ATTR(scan, S_IRUGO, _show, NULL, 0);
-
-/**
- * IIO_DEV_ATTR_INPUT - direct read of a single input channel
- * @_number: input channel number
- * @_show: output method for the attribute
- **/
-#define IIO_DEV_ATTR_INPUT(_number, _show)				\
-	IIO_DEVICE_ATTR(in##_number, S_IRUGO, _show, NULL, _number)
-
-/**
  * IIO_DEV_ATTR_SW_RING_ENABLE - enable software ring buffer
  * @_show: output method for the attribute
  * @_store: input method for the attribute
@@ -222,22 +162,6 @@ struct iio_const_attr {
 	IIO_DEVICE_ATTR(hw_ring_enable, S_IRUGO | S_IWUSR, _show, _store, 0)
 
 /**
- * IIO_DEV_ATTR_BPSE - set number of bits per scan element
- * @_mode: sysfs file mode/permissions
- * @_show: output method for the attribute
- * @_store: input method for the attribute
- **/
-#define IIO_DEV_ATTR_BPSE(_mode, _show, _store)		\
-	IIO_DEVICE_ATTR(bpse, _mode, _show, _store, 0)
-
-/**
- * IIO_DEV_ATTR_BPSE_AVAILABLE - number of bits per scan element supported
- * @_show: output method for the attribute
- **/
-#define IIO_DEV_ATTR_BPSE_AVAILABLE(_show)				\
-	IIO_DEVICE_ATTR(bpse_available, S_IRUGO, _show, NULL, 0)
-
-/**
  * IIO_DEV_ATTR_TEMP - many sensors have auxiliary temperature sensors
  * @_show: output method for the attribute
  **/
-- 
1.7.1

