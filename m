Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 08/14] staging:iio: rename ring_generic.h -> buffer_generic.h
Date: Wed, 21 Sep 2011 11:15:56 +0100
Message-Id: <1316600162-15581-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316600162-15581-1-git-send-email-jic23@cam.ac.uk>
References: <1316600162-15581-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Nothing in this file is specific to RING buffers so rename it.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_core.c      |    2 +-
 drivers/staging/iio/accel/adis16203_core.c      |    2 +-
 drivers/staging/iio/accel/adis16204_core.c      |    2 +-
 drivers/staging/iio/accel/adis16209_core.c      |    2 +-
 drivers/staging/iio/accel/adis16240_core.c      |    2 +-
 drivers/staging/iio/accel/lis3l02dq_core.c      |    2 +-
 drivers/staging/iio/accel/sca3000_core.c        |    2 +-
 drivers/staging/iio/accel/sca3000_ring.c        |    2 +-
 drivers/staging/iio/adc/ad7192.c                |    2 +-
 drivers/staging/iio/adc/ad7298_core.c           |    2 +-
 drivers/staging/iio/adc/ad7298_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7476_core.c           |    2 +-
 drivers/staging/iio/adc/ad7476_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7606_core.c           |    2 +-
 drivers/staging/iio/adc/ad7606_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7780.c                |    1 -
 drivers/staging/iio/adc/ad7793.c                |    2 +-
 drivers/staging/iio/adc/ad7887_core.c           |    2 +-
 drivers/staging/iio/adc/ad7887_ring.c           |    2 +-
 drivers/staging/iio/adc/ad799x_core.c           |    2 +-
 drivers/staging/iio/adc/ad799x_ring.c           |    2 +-
 drivers/staging/iio/adc/max1363_core.c          |    2 +-
 drivers/staging/iio/adc/max1363_ring.c          |    2 +-
 drivers/staging/iio/buffer_generic.h            |  226 +++++++++++++++++++++++
 drivers/staging/iio/gyro/adis16260_core.c       |    2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |    2 +-
 drivers/staging/iio/imu/adis16400_core.c        |    2 +-
 drivers/staging/iio/industrialio-ring.c         |    2 +-
 drivers/staging/iio/kfifo_buf.h                 |    2 +-
 drivers/staging/iio/meter/ade7758_core.c        |    2 +-
 drivers/staging/iio/ring_generic.h              |  226 -----------------------
 drivers/staging/iio/ring_sw.h                   |    2 +-
 32 files changed, 255 insertions(+), 256 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 2785460..eb6a1a8 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -17,7 +17,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 
 #include "adis16201.h"
 
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 27079a9..561e7a9 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -17,7 +17,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 
 #include "adis16203.h"
 
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index b0d6a2e..507f282 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -21,7 +21,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 
 #include "adis16204.h"
 
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 97dca88..2dd24c3 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -18,7 +18,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 
 #include "adis16209.h"
 
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 282a746..10e0249 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -21,7 +21,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 
 #include "adis16240.h"
 
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 6d600f6..fd53fd5 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -25,7 +25,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 
 #include "lis3l02dq.h"
 
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 394b04e..2fe3578 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -21,7 +21,7 @@
 #include <linux/module.h>
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 
 #include "sca3000.h"
 
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 2a83e8a..f519857 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -20,7 +20,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 #include "../ring_hw.h"
 #include "sca3000.h"
 
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 4b56490..8d080ab 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -19,7 +19,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
 #include "../trigger_consumer.h"
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index a627bfe..cf91ccd 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -18,7 +18,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 
 #include "ad7298.h"
 
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index 2315ee9..1cd5f61 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -12,7 +12,7 @@
 #include <linux/spi/spi.h>
 
 #include "../iio.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 #include "../ring_sw.h"
 #include "../trigger_consumer.h"
 
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index edf25ce..d574a2e 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -17,7 +17,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 
 #include "ad7476.h"
 
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index e48181a..854d949 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -14,7 +14,7 @@
 #include <linux/spi/spi.h>
 
 #include "../iio.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 #include "../ring_sw.h"
 #include "../trigger_consumer.h"
 
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index f22f668..f8eba67 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -20,7 +20,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 
 #include "ad7606.h"
 
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 15bdec6..20afb3e 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -12,7 +12,7 @@
 #include <linux/slab.h>
 
 #include "../iio.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 #include "../ring_sw.h"
 #include "../trigger_consumer.h"
 
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 46d1f8f..4b6f8c6 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -20,7 +20,6 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
 
 #include "ad7780.h"
 
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index e21593d..11ba79e 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -19,7 +19,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
 #include "../trigger_consumer.h"
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index cdd7c13..4a8ffb5 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -17,7 +17,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 
 
 #include "ad7887.h"
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index 678c877..96274d6 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -13,7 +13,7 @@
 #include <linux/spi/spi.h>
 
 #include "../iio.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 #include "../ring_sw.h"
 #include "../trigger_consumer.h"
 
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index ae64ee9..d5fbda7 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -35,7 +35,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 
 #include "ad799x.h"
 
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 8177de5..c1d38c5 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -17,7 +17,7 @@
 #include <linux/bitops.h>
 
 #include "../iio.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 #include "../ring_sw.h"
 #include "../trigger_consumer.h"
 
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index b7c46ae..e0f8791 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -34,7 +34,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 
 #include "max1363.h"
 
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 570c686..91e29c5 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -15,7 +15,7 @@
 #include <linux/bitops.h>
 
 #include "../iio.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 #include "../ring_sw.h"
 #include "../trigger_consumer.h"
 
diff --git a/drivers/staging/iio/buffer_generic.h b/drivers/staging/iio/buffer_generic.h
new file mode 100644
index 0000000..a1256c1
--- /dev/null
+++ b/drivers/staging/iio/buffer_generic.h
@@ -0,0 +1,226 @@
+/* The industrial I/O core - generic ring buffer interfaces.
+ *
+ * Copyright (c) 2008 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef _IIO_BUFFER_GENERIC_H_
+#define _IIO_BUFFER_GENERIC_H_
+#include <linux/sysfs.h>
+#include "iio.h"
+#include "chrdev.h"
+
+#ifdef CONFIG_IIO_BUFFER
+
+struct iio_ring_buffer;
+
+/**
+ * struct iio_ring_access_funcs - access functions for ring buffers.
+ * @mark_in_use:	reference counting, typically to prevent module removal
+ * @unmark_in_use:	reduce reference count when no longer using ring buffer
+ * @store_to:		actually store stuff to the ring buffer
+ * @read_last:		get the last element stored
+ * @read_first_n:	try to get a specified number of elements (must exist)
+ * @mark_param_change:	notify ring that some relevant parameter has changed
+ *			Often this means the underlying storage may need to
+ *			change.
+ * @request_update:	if a parameter change has been marked, update underlying
+ *			storage.
+ * @get_bytes_per_datum:get current bytes per datum
+ * @set_bytes_per_datum:set number of bytes per datum
+ * @get_length:		get number of datums in ring
+ * @set_length:		set number of datums in ring
+ * @is_enabled:		query if ring is currently being used
+ * @enable:		enable the ring
+ *
+ * The purpose of this structure is to make the ring buffer element
+ * modular as event for a given driver, different usecases may require
+ * different ring designs (space efficiency vs speed for example).
+ *
+ * It is worth noting that a given ring implementation may only support a small
+ * proportion of these functions.  The core code 'should' cope fine with any of
+ * them not existing.
+ **/
+struct iio_ring_access_funcs {
+	void (*mark_in_use)(struct iio_ring_buffer *ring);
+	void (*unmark_in_use)(struct iio_ring_buffer *ring);
+
+	int (*store_to)(struct iio_ring_buffer *ring, u8 *data, s64 timestamp);
+	int (*read_last)(struct iio_ring_buffer *ring, u8 *data);
+	int (*read_first_n)(struct iio_ring_buffer *ring,
+			    size_t n,
+			    char __user *buf);
+
+	int (*mark_param_change)(struct iio_ring_buffer *ring);
+	int (*request_update)(struct iio_ring_buffer *ring);
+
+	int (*get_bytes_per_datum)(struct iio_ring_buffer *ring);
+	int (*set_bytes_per_datum)(struct iio_ring_buffer *ring, size_t bpd);
+	int (*get_length)(struct iio_ring_buffer *ring);
+	int (*set_length)(struct iio_ring_buffer *ring, int length);
+
+	int (*is_enabled)(struct iio_ring_buffer *ring);
+	int (*enable)(struct iio_ring_buffer *ring);
+};
+
+/**
+ * struct iio_ring_setup_ops - buffer setup related callbacks
+ * @preenable:		[DRIVER] function to run prior to marking ring enabled
+ * @postenable:		[DRIVER] function to run after marking ring enabled
+ * @predisable:		[DRIVER] function to run prior to marking ring disabled
+ * @postdisable:	[DRIVER] function to run after marking ring disabled
+ */
+struct iio_ring_setup_ops {
+	int				(*preenable)(struct iio_dev *);
+	int				(*postenable)(struct iio_dev *);
+	int				(*predisable)(struct iio_dev *);
+	int				(*postdisable)(struct iio_dev *);
+};
+
+/**
+ * struct iio_ring_buffer - general ring buffer structure
+ * @dev:		ring buffer device struct
+ * @indio_dev:		industrial I/O device structure
+ * @owner:		module that owns the ring buffer (for ref counting)
+ * @length:		[DEVICE] number of datums in ring
+ * @bytes_per_datum:	[DEVICE] size of individual datum including timestamp
+ * @bpe:		[DEVICE] size of individual channel value
+ * @scan_el_attrs:	[DRIVER] control of scan elements if that scan mode
+ *			control method is used
+ * @scan_count:	[INTERN] the number of elements in the current scan mode
+ * @scan_mask:		[INTERN] bitmask used in masking scan mode elements
+ * @scan_timestamp:	[INTERN] does the scan mode include a timestamp
+ * @access:		[DRIVER] ring access functions associated with the
+ *			implementation.
+ * @flags:		[INTERN] file ops related flags including busy flag.
+ **/
+struct iio_ring_buffer {
+	struct iio_dev				*indio_dev;
+	struct module				*owner;
+	int					length;
+	int					bytes_per_datum;
+	int					bpe;
+	struct attribute_group			*scan_el_attrs;
+	int					scan_count;
+	long					*scan_mask;
+	bool					scan_timestamp;
+	const struct iio_ring_access_funcs	*access;
+	const struct iio_ring_setup_ops		*setup_ops;
+	struct list_head			scan_el_dev_attr_list;
+	struct attribute_group			scan_el_group;
+	wait_queue_head_t			pollq;
+	bool					stufftoread;
+	unsigned long				flags;
+	const struct attribute_group *attrs;
+};
+
+/**
+ * iio_ring_buffer_init() - Initialize the buffer structure
+ * @ring: buffer to be initialized
+ * @dev_info: the iio device the buffer is assocated with
+ **/
+void iio_ring_buffer_init(struct iio_ring_buffer *ring,
+			  struct iio_dev *dev_info);
+
+void iio_ring_buffer_deinit(struct iio_ring_buffer *ring);
+
+/**
+ * __iio_update_ring_buffer() - update common elements of ring buffers
+ * @ring:		ring buffer that is the event source
+ * @bytes_per_datum:	size of individual datum including timestamp
+ * @length:		number of datums in ring
+ **/
+static inline void __iio_update_ring_buffer(struct iio_ring_buffer *ring,
+					    int bytes_per_datum, int length)
+{
+	ring->bytes_per_datum = bytes_per_datum;
+	ring->length = length;
+}
+
+int iio_scan_mask_query(struct iio_ring_buffer *ring, int bit);
+
+/**
+ * iio_scan_mask_set() - set particular bit in the scan mask
+ * @ring: the ring buffer whose scan mask we are interested in
+ * @bit: the bit to be set.
+ **/
+int iio_scan_mask_set(struct iio_ring_buffer *ring, int bit);
+
+#define to_iio_ring_buffer(d)				\
+	container_of(d, struct iio_ring_buffer, dev)
+
+/**
+ * iio_ring_buffer_register() - register the buffer with IIO core
+ * @indio_dev: device with the buffer to be registered
+ **/
+int iio_ring_buffer_register(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *channels,
+			     int num_channels);
+
+/**
+ * iio_ring_buffer_unregister() - unregister the buffer from IIO core
+ * @indio_dev: the device with the buffer to be unregistered
+ **/
+void iio_ring_buffer_unregister(struct iio_dev *indio_dev);
+
+/**
+ * iio_read_ring_length() - attr func to get number of datums in the buffer
+ **/
+ssize_t iio_read_ring_length(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf);
+/**
+ * iio_write_ring_length() - attr func to set number of datums in the buffer
+ **/
+ssize_t iio_write_ring_length(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf,
+			      size_t len);
+/**
+ * iio_read_ring_bytes_per_datum() - attr for number of bytes in whole datum
+ **/
+ssize_t iio_read_ring_bytes_per_datum(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf);
+/**
+ * iio_store_ring_enable() - attr to turn the buffer on
+ **/
+ssize_t iio_store_ring_enable(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf,
+			      size_t len);
+/**
+ * iio_show_ring_enable() - attr to see if the buffer is on
+ **/
+ssize_t iio_show_ring_enable(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf);
+#define IIO_RING_LENGTH_ATTR DEVICE_ATTR(length, S_IRUGO | S_IWUSR,	\
+					 iio_read_ring_length,		\
+					 iio_write_ring_length)
+#define IIO_RING_BYTES_PER_DATUM_ATTR DEVICE_ATTR(bytes_per_datum, S_IRUGO | S_IWUSR,	\
+				      iio_read_ring_bytes_per_datum, NULL)
+#define IIO_RING_ENABLE_ATTR DEVICE_ATTR(enable, S_IRUGO | S_IWUSR, \
+					 iio_show_ring_enable,		\
+					 iio_store_ring_enable)
+
+int iio_sw_ring_preenable(struct iio_dev *indio_dev);
+
+#else /* CONFIG_IIO_BUFFER */
+
+static inline int iio_ring_buffer_register(struct iio_dev *indio_dev,
+					   struct iio_chan_spec *channels,
+					   int num_channels)
+{
+	return 0;
+}
+
+static inline void iio_ring_buffer_unregister(struct iio_dev *indio_dev)
+{};
+
+#endif /* CONFIG_IIO_BUFFER */
+
+#endif /* _IIO_BUFFER_GENERIC_H_ */
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 73157b2..8058d66 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -21,7 +21,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 
 #include "adis16260.h"
 
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 25223d8..fb83161 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -20,7 +20,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 #include "../ring_sw.h"
 
 #include "ad5933.h"
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 19dacfb..b041b46 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -28,7 +28,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 #include "adis16400.h"
 
 enum adis16400_chip_variant {
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index e048d34..6f9d9e7 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -23,7 +23,7 @@
 #include "iio.h"
 #include "iio_core.h"
 #include "sysfs.h"
-#include "ring_generic.h"
+#include "buffer_generic.h"
 
 static const char * const iio_endian_prefix[] = {
 	[IIO_BE] = "be",
diff --git a/drivers/staging/iio/kfifo_buf.h b/drivers/staging/iio/kfifo_buf.h
index fb48523..66a80c6 100644
--- a/drivers/staging/iio/kfifo_buf.h
+++ b/drivers/staging/iio/kfifo_buf.h
@@ -1,7 +1,7 @@
 
 #include <linux/kfifo.h>
 #include "iio.h"
-#include "ring_generic.h"
+#include "buffer_generic.h"
 
 extern const struct iio_ring_access_funcs kfifo_access_funcs;
 
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 1661f31..9a0dc1e 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -21,7 +21,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../ring_generic.h"
+#include "../buffer_generic.h"
 #include "meter.h"
 #include "ade7758.h"
 
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
deleted file mode 100644
index 6a89ec0..0000000
--- a/drivers/staging/iio/ring_generic.h
+++ /dev/null
@@ -1,226 +0,0 @@
-/* The industrial I/O core - generic ring buffer interfaces.
- *
- * Copyright (c) 2008 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-
-#ifndef _IIO_RING_GENERIC_H_
-#define _IIO_RING_GENERIC_H_
-#include <linux/sysfs.h>
-#include "iio.h"
-#include "chrdev.h"
-
-#ifdef CONFIG_IIO_BUFFER
-
-struct iio_ring_buffer;
-
-/**
- * struct iio_ring_access_funcs - access functions for ring buffers.
- * @mark_in_use:	reference counting, typically to prevent module removal
- * @unmark_in_use:	reduce reference count when no longer using ring buffer
- * @store_to:		actually store stuff to the ring buffer
- * @read_last:		get the last element stored
- * @read_first_n:	try to get a specified number of elements (must exist)
- * @mark_param_change:	notify ring that some relevant parameter has changed
- *			Often this means the underlying storage may need to
- *			change.
- * @request_update:	if a parameter change has been marked, update underlying
- *			storage.
- * @get_bytes_per_datum:get current bytes per datum
- * @set_bytes_per_datum:set number of bytes per datum
- * @get_length:		get number of datums in ring
- * @set_length:		set number of datums in ring
- * @is_enabled:		query if ring is currently being used
- * @enable:		enable the ring
- *
- * The purpose of this structure is to make the ring buffer element
- * modular as event for a given driver, different usecases may require
- * different ring designs (space efficiency vs speed for example).
- *
- * It is worth noting that a given ring implementation may only support a small
- * proportion of these functions.  The core code 'should' cope fine with any of
- * them not existing.
- **/
-struct iio_ring_access_funcs {
-	void (*mark_in_use)(struct iio_ring_buffer *ring);
-	void (*unmark_in_use)(struct iio_ring_buffer *ring);
-
-	int (*store_to)(struct iio_ring_buffer *ring, u8 *data, s64 timestamp);
-	int (*read_last)(struct iio_ring_buffer *ring, u8 *data);
-	int (*read_first_n)(struct iio_ring_buffer *ring,
-			    size_t n,
-			    char __user *buf);
-
-	int (*mark_param_change)(struct iio_ring_buffer *ring);
-	int (*request_update)(struct iio_ring_buffer *ring);
-
-	int (*get_bytes_per_datum)(struct iio_ring_buffer *ring);
-	int (*set_bytes_per_datum)(struct iio_ring_buffer *ring, size_t bpd);
-	int (*get_length)(struct iio_ring_buffer *ring);
-	int (*set_length)(struct iio_ring_buffer *ring, int length);
-
-	int (*is_enabled)(struct iio_ring_buffer *ring);
-	int (*enable)(struct iio_ring_buffer *ring);
-};
-
-/**
- * struct iio_ring_setup_ops - buffer setup related callbacks
- * @preenable:		[DRIVER] function to run prior to marking ring enabled
- * @postenable:		[DRIVER] function to run after marking ring enabled
- * @predisable:		[DRIVER] function to run prior to marking ring disabled
- * @postdisable:	[DRIVER] function to run after marking ring disabled
- */
-struct iio_ring_setup_ops {
-	int				(*preenable)(struct iio_dev *);
-	int				(*postenable)(struct iio_dev *);
-	int				(*predisable)(struct iio_dev *);
-	int				(*postdisable)(struct iio_dev *);
-};
-
-/**
- * struct iio_ring_buffer - general ring buffer structure
- * @dev:		ring buffer device struct
- * @indio_dev:		industrial I/O device structure
- * @owner:		module that owns the ring buffer (for ref counting)
- * @length:		[DEVICE] number of datums in ring
- * @bytes_per_datum:	[DEVICE] size of individual datum including timestamp
- * @bpe:		[DEVICE] size of individual channel value
- * @scan_el_attrs:	[DRIVER] control of scan elements if that scan mode
- *			control method is used
- * @scan_count:	[INTERN] the number of elements in the current scan mode
- * @scan_mask:		[INTERN] bitmask used in masking scan mode elements
- * @scan_timestamp:	[INTERN] does the scan mode include a timestamp
- * @access:		[DRIVER] ring access functions associated with the
- *			implementation.
- * @flags:		[INTERN] file ops related flags including busy flag.
- **/
-struct iio_ring_buffer {
-	struct iio_dev				*indio_dev;
-	struct module				*owner;
-	int					length;
-	int					bytes_per_datum;
-	int					bpe;
-	struct attribute_group			*scan_el_attrs;
-	int					scan_count;
-	long					*scan_mask;
-	bool					scan_timestamp;
-	const struct iio_ring_access_funcs	*access;
-	const struct iio_ring_setup_ops		*setup_ops;
-	struct list_head			scan_el_dev_attr_list;
-	struct attribute_group			scan_el_group;
-	wait_queue_head_t			pollq;
-	bool					stufftoread;
-	unsigned long				flags;
-	const struct attribute_group *attrs;
-};
-
-/**
- * iio_ring_buffer_init() - Initialize the buffer structure
- * @ring: buffer to be initialized
- * @dev_info: the iio device the buffer is assocated with
- **/
-void iio_ring_buffer_init(struct iio_ring_buffer *ring,
-			  struct iio_dev *dev_info);
-
-void iio_ring_buffer_deinit(struct iio_ring_buffer *ring);
-
-/**
- * __iio_update_ring_buffer() - update common elements of ring buffers
- * @ring:		ring buffer that is the event source
- * @bytes_per_datum:	size of individual datum including timestamp
- * @length:		number of datums in ring
- **/
-static inline void __iio_update_ring_buffer(struct iio_ring_buffer *ring,
-					    int bytes_per_datum, int length)
-{
-	ring->bytes_per_datum = bytes_per_datum;
-	ring->length = length;
-}
-
-int iio_scan_mask_query(struct iio_ring_buffer *ring, int bit);
-
-/**
- * iio_scan_mask_set() - set particular bit in the scan mask
- * @ring: the ring buffer whose scan mask we are interested in
- * @bit: the bit to be set.
- **/
-int iio_scan_mask_set(struct iio_ring_buffer *ring, int bit);
-
-#define to_iio_ring_buffer(d)				\
-	container_of(d, struct iio_ring_buffer, dev)
-
-/**
- * iio_ring_buffer_register() - register the buffer with IIO core
- * @indio_dev: device with the buffer to be registered
- **/
-int iio_ring_buffer_register(struct iio_dev *indio_dev,
-			     const struct iio_chan_spec *channels,
-			     int num_channels);
-
-/**
- * iio_ring_buffer_unregister() - unregister the buffer from IIO core
- * @indio_dev: the device with the buffer to be unregistered
- **/
-void iio_ring_buffer_unregister(struct iio_dev *indio_dev);
-
-/**
- * iio_read_ring_length() - attr func to get number of datums in the buffer
- **/
-ssize_t iio_read_ring_length(struct device *dev,
-			     struct device_attribute *attr,
-			     char *buf);
-/**
- * iio_write_ring_length() - attr func to set number of datums in the buffer
- **/
-ssize_t iio_write_ring_length(struct device *dev,
-			      struct device_attribute *attr,
-			      const char *buf,
-			      size_t len);
-/**
- * iio_read_ring_bytes_per_datum() - attr for number of bytes in whole datum
- **/
-ssize_t iio_read_ring_bytes_per_datum(struct device *dev,
-			  struct device_attribute *attr,
-			  char *buf);
-/**
- * iio_store_ring_enable() - attr to turn the buffer on
- **/
-ssize_t iio_store_ring_enable(struct device *dev,
-			      struct device_attribute *attr,
-			      const char *buf,
-			      size_t len);
-/**
- * iio_show_ring_enable() - attr to see if the buffer is on
- **/
-ssize_t iio_show_ring_enable(struct device *dev,
-			     struct device_attribute *attr,
-			     char *buf);
-#define IIO_RING_LENGTH_ATTR DEVICE_ATTR(length, S_IRUGO | S_IWUSR,	\
-					 iio_read_ring_length,		\
-					 iio_write_ring_length)
-#define IIO_RING_BYTES_PER_DATUM_ATTR DEVICE_ATTR(bytes_per_datum, S_IRUGO | S_IWUSR,	\
-				      iio_read_ring_bytes_per_datum, NULL)
-#define IIO_RING_ENABLE_ATTR DEVICE_ATTR(enable, S_IRUGO | S_IWUSR, \
-					 iio_show_ring_enable,		\
-					 iio_store_ring_enable)
-
-int iio_sw_ring_preenable(struct iio_dev *indio_dev);
-
-#else /* CONFIG_IIO_BUFFER */
-
-static inline int iio_ring_buffer_register(struct iio_dev *indio_dev,
-					   struct iio_chan_spec *channels,
-					   int num_channels)
-{
-	return 0;
-}
-
-static inline void iio_ring_buffer_unregister(struct iio_dev *indio_dev)
-{};
-
-#endif /* CONFIG_IIO_BUFFER */
-
-#endif /* _IIO_RING_GENERIC_H_ */
diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.h
index 1527163..2835c99 100644
--- a/drivers/staging/iio/ring_sw.h
+++ b/drivers/staging/iio/ring_sw.h
@@ -23,7 +23,7 @@
 
 #ifndef _IIO_RING_SW_H_
 #define _IIO_RING_SW_H_
-#include "ring_generic.h"
+#include "buffer_generic.h"
 
 /**
  * ring_sw_access_funcs - access functions for a software ring buffer
-- 
1.7.3.4
