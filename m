Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 76/99] staging:iio:core clean out unused elements.
Date: Wed,  4 May 2011 12:58:48 +0100
Message-Id: <1304510351-10922-77-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Trivial cleanup of things that have fallen by the way.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |   13 --------
 drivers/staging/iio/industrialio-core.c |   47 +-----------------------------
 2 files changed, 2 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index ebf8bae..7e09d70 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -25,8 +25,6 @@
 /* Event interface flags */
 #define IIO_BUSY_BIT_POS 1
 
-struct iio_dev;
-
 /* naughty temporary hack to match these against the event version
    - need to flattern these together */
 enum iio_chan_type {
@@ -218,7 +216,6 @@ static inline s64 iio_get_time_ns(void)
  *			ownership of chrdevs etc
  * @num_interrupt_lines:[DRIVER] number of physical interrupt lines from device
  * @event_attrs:	[DRIVER] event control attributes
- * @event_conf_attrs:	[DRIVER] event configuration attributes
  * @event_interfaces:	[INTERN] event chrdevs associated with interrupt lines
  * @ring:		[DRIVER] any ring buffer present
  * @mlock:		[INTERN] lock used to prevent simultaneous device state
@@ -238,8 +235,6 @@ struct iio_dev {
 
 	int				num_interrupt_lines;
 	struct attribute_group		*event_attrs;
-	struct attribute_group		*event_conf_attrs;
-
 	struct iio_event_interface	*event_interfaces;
 
 	struct iio_ring_buffer		*ring;
@@ -305,14 +300,6 @@ int iio_push_event(struct iio_dev *dev_info,
 		  int ev_code,
 		  s64 timestamp);
 
-/**
- * iio_allocate_chrdev() - Allocate a chrdev
- * @handler:	struct that contains relevant file handling for chrdev
- * @dev_info:	iio_dev for which chrdev is being created
- **/
-int iio_allocate_chrdev(struct iio_handler *handler, struct iio_dev *dev_info);
-void iio_deallocate_chrdev(struct iio_handler *handler);
-
 /* Used to distinguish between bipolar and unipolar scan elemenents.
  * Whilst this may seem obvious, we may well want to change the representation
  * in the future!*/
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index e3582c9..7952195 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -996,21 +996,6 @@ static inline int __iio_add_event_config_attrs(struct iio_dev *dev_info, int i)
 {
 	int j;
 	int ret;
-	struct attribute **attrp, **attrq;
-
-	if (dev_info->event_conf_attrs && dev_info->event_conf_attrs[i].attrs) {
-		attrp = dev_info->event_conf_attrs[i].attrs;
-		while (*attrp) {
-			ret =  sysfs_add_file_to_group(&dev_info
-						       ->event_interfaces[0]
-						       .dev.kobj,
-						       *attrp,
-						       NULL);
-			if (ret)
-				goto error_ret;
-			attrp++;
-		}
-	}
 	INIT_LIST_HEAD(&dev_info->event_interfaces[0].dev_attr_list);
 	/* Dynically created from the channels array */
 	if (dev_info->channels) {
@@ -1025,19 +1010,7 @@ static inline int __iio_add_event_config_attrs(struct iio_dev *dev_info, int i)
 	return 0;
 
 error_clear_attrs:
-	__iio_remove_all_event_sysfs(dev_info,
-				     NULL,
-				     i);
-error_ret:
-	attrq = dev_info->event_conf_attrs[i].attrs;
-	while (attrq != attrp) {
-			sysfs_remove_file_from_group(&dev_info
-						     ->event_interfaces[0]
-						     .dev.kobj,
-						     *attrq,
-						     NULL);
-		attrq++;
-	}
+	__iio_remove_all_event_sysfs(dev_info, NULL, i);
 
 	return ret;
 }
@@ -1045,23 +1018,7 @@ error_ret:
 static inline int __iio_remove_event_config_attrs(struct iio_dev *dev_info,
 						  int i)
 {
-	struct attribute **attrq;
-	__iio_remove_all_event_sysfs(dev_info,
-				     NULL,
-				     i);
-	if (dev_info->event_conf_attrs
-		&& dev_info->event_conf_attrs[i].attrs) {
-		attrq = dev_info->event_conf_attrs[i].attrs;
-		while (*attrq) {
-			sysfs_remove_file_from_group(&dev_info
-						     ->event_interfaces[0]
-						     .dev.kobj,
-						     *attrq,
-						     NULL);
-			attrq++;
-		}
-	}
-
+	__iio_remove_all_event_sysfs(dev_info, NULL, i);
 	return 0;
 }
 
-- 
1.7.3.4
