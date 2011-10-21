Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio: header reorganization
Date: Fri, 21 Oct 2011 10:09:08 +0100
Message-Id: <1319188148-32349-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <4EA13439.8060504@cam.ac.uk>
References: <4EA13439.8060504@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Issue brought up by Lars-Peter Clausen. This is a varient of what
he suggested.

io/iio.h for driver stuff (has to include types.h)
	Sub files for the bits drivers may or may not use
	iio/sysfs.h
	iio/buffer.h (contents of current buffer_generic.h)
	(obviously anything offering events will need events.h as well)
iio/types.h for the enums that matter to both
	iio_chan_type, iio_modifier
iio/events.h for the event code stuff
	IIO_EVENT_CODE and friends.  + everything in chrdev.h  So this
	is the stuff that userspace cares about.
	Also include iio_event_type, iio_event_direction

Thus iio drivers include iio.h + as required
events.h
sysfs.h
buffer.h

in kernel users (once that interface is merged) will need inkern.h
which will pull in types.h

Userspace will need just events.h (which pulls in types.h) to get
everything they need to know about.  Buffer userspace access doesn't
currently need any core defines. All information about the data
format is passed through sysfs.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_core.c      |    2 +-
 drivers/staging/iio/accel/adis16203_core.c      |    2 +-
 drivers/staging/iio/accel/adis16204_core.c      |    2 +-
 drivers/staging/iio/accel/adis16209_core.c      |    2 +-
 drivers/staging/iio/accel/adis16240_core.c      |    2 +-
 drivers/staging/iio/accel/lis3l02dq_core.c      |    3 +-
 drivers/staging/iio/accel/sca3000_core.c        |    3 +-
 drivers/staging/iio/accel/sca3000_ring.c        |    2 +-
 drivers/staging/iio/adc/ad7150.c                |    2 +-
 drivers/staging/iio/adc/ad7192.c                |    2 +-
 drivers/staging/iio/adc/ad7280a.c               |    1 +
 drivers/staging/iio/adc/ad7291.c                |    1 +
 drivers/staging/iio/adc/ad7298_core.c           |    2 +-
 drivers/staging/iio/adc/ad7298_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7476_core.c           |    2 +-
 drivers/staging/iio/adc/ad7476_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7606_core.c           |    2 +-
 drivers/staging/iio/adc/ad7606_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7793.c                |    2 +-
 drivers/staging/iio/adc/ad7816.c                |    1 +
 drivers/staging/iio/adc/ad7887_core.c           |    2 +-
 drivers/staging/iio/adc/ad7887_ring.c           |    2 +-
 drivers/staging/iio/adc/ad799x_core.c           |    3 +-
 drivers/staging/iio/adc/ad799x_ring.c           |    2 +-
 drivers/staging/iio/adc/adt7310.c               |    2 +-
 drivers/staging/iio/adc/adt7410.c               |    1 +
 drivers/staging/iio/adc/adt75.c                 |    2 +-
 drivers/staging/iio/adc/max1363_core.c          |    3 +-
 drivers/staging/iio/adc/max1363_ring.c          |    2 +-
 drivers/staging/iio/addac/adt7316.c             |    1 +
 drivers/staging/iio/buffer.h                    |  242 ++++++++++++++++++++++
 drivers/staging/iio/buffer_generic.h            |  243 -----------------------
 drivers/staging/iio/chrdev.h                    |   25 ---
 drivers/staging/iio/dac/ad5504.c                |    1 +
 drivers/staging/iio/events.h                    |   71 +++++++
 drivers/staging/iio/gyro/adis16260_core.c       |    2 +-
 drivers/staging/iio/iio.h                       |   38 +----
 drivers/staging/iio/iio_simple_dummy.c          |    3 +-
 drivers/staging/iio/iio_simple_dummy_events.c   |    1 +
 drivers/staging/iio/impedance-analyzer/ad5933.c |    2 +-
 drivers/staging/iio/imu/adis16400_core.c        |    2 +-
 drivers/staging/iio/industrialio-buffer.c       |    2 +-
 drivers/staging/iio/industrialio-core.c         |    2 +-
 drivers/staging/iio/kfifo_buf.h                 |    2 +-
 drivers/staging/iio/light/tsl2563.c             |    1 +
 drivers/staging/iio/meter/ade7758_core.c        |    2 +-
 drivers/staging/iio/ring_sw.h                   |    2 +-
 drivers/staging/iio/sysfs.h                     |   43 ----
 drivers/staging/iio/types.h                     |   49 +++++
 49 files changed, 410 insertions(+), 382 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 1c5dad5..1283519 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -17,7 +17,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 
 #include "adis16201.h"
 
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 8a33374..5483b59 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -17,7 +17,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 
 #include "adis16203.h"
 
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index cc6eb26..0ae5706 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -21,7 +21,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 
 #include "adis16204.h"
 
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 0a8571b..827499f 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -18,7 +18,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 
 #include "adis16209.h"
 
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index b8be292..8123fe3 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -21,7 +21,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 
 #include "adis16240.h"
 
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 559545a..358a9f6 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -25,7 +25,8 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../events.h"
+#include "../buffer.h"
 
 #include "lis3l02dq.h"
 
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 62cdef4..5f7bed6 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -21,7 +21,8 @@
 #include <linux/module.h>
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../events.h"
+#include "../buffer.h"
 
 #include "sca3000.h"
 
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 4a9a01d..685ded8 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -20,7 +20,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 #include "../ring_hw.h"
 #include "sca3000.h"
 
diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index e185f0e..6de884b 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -15,7 +15,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-
+#include "../events.h"
 /*
  * AD7150 registers definition
  */
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 31c376b..b16130b 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -19,7 +19,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
 #include "../trigger_consumer.h"
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 372d059..5ccda4b 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -18,6 +18,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
+#include "../events.h"
 
 #include "ad7280a.h"
 
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 10e79e8..e5f352b 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -19,6 +19,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
+#include "../events.h"
 
 /*
  * Simplified handling
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index c1de73a..445b071 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -18,7 +18,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 
 #include "ad7298.h"
 
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index 47630d5..192328e 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -12,7 +12,7 @@
 #include <linux/spi/spi.h>
 
 #include "../iio.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 #include "../ring_sw.h"
 #include "../trigger_consumer.h"
 
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index fd79fac..1347313 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -17,7 +17,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 
 #include "ad7476.h"
 
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index e82c1a4..0961887 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -14,7 +14,7 @@
 #include <linux/spi/spi.h>
 
 #include "../iio.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 #include "../ring_sw.h"
 #include "../trigger_consumer.h"
 
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 54423ab..5317483 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -20,7 +20,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 
 #include "ad7606.h"
 
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 20927fd..af6780a 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -12,7 +12,7 @@
 #include <linux/slab.h>
 
 #include "../iio.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 #include "../ring_sw.h"
 #include "../trigger_consumer.h"
 
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index a831b92..7d3a5af 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -19,7 +19,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 #include "../ring_sw.h"
 #include "../trigger.h"
 #include "../trigger_consumer.h"
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index bdb9049..7a344a2 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -18,6 +18,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
+#include "../events.h"
 
 /*
  * AD7816 config masks
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 609dcd5..a7baa9b 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -17,7 +17,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 
 
 #include "ad7887.h"
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index cb74cad..fbe21b5 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -13,7 +13,7 @@
 #include <linux/spi/spi.h>
 
 #include "../iio.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 #include "../ring_sw.h"
 #include "../trigger_consumer.h"
 
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index ee6cd79..64ac316 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -35,7 +35,8 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../events.h"
+#include "../buffer.h"
 
 #include "ad799x.h"
 
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index e3f4698..b215a1f 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -17,7 +17,7 @@
 #include <linux/bitops.h>
 
 #include "../iio.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 #include "../ring_sw.h"
 #include "../trigger_consumer.h"
 
diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index c9e0be3..c937ac1 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -17,7 +17,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-
+#include "../events.h"
 /*
  * ADT7310 registers definition
  */
diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index a289e42..16467a7 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -17,6 +17,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
+#include "../events.h"
 
 /*
  * ADT7410 registers definition
diff --git a/drivers/staging/iio/adc/adt75.c b/drivers/staging/iio/adc/adt75.c
index a677cfc..8d4eb98 100644
--- a/drivers/staging/iio/adc/adt75.c
+++ b/drivers/staging/iio/adc/adt75.c
@@ -16,7 +16,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-
+#include "../events.h"
 /*
  * ADT75 registers definition
  */
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 8f19d2d..56783d6 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -34,7 +34,8 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../events.h"
+#include "../buffer.h"
 
 #include "max1363.h"
 
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 294dec9..317d8ac 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -15,7 +15,7 @@
 #include <linux/bitops.h>
 
 #include "../iio.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 #include "../ring_sw.h"
 #include "../trigger_consumer.h"
 
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 8df2470..13c3929 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 
 #include "../iio.h"
+#include "../events.h"
 #include "../sysfs.h"
 #include "adt7316.h"
 
diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
new file mode 100644
index 0000000..8d5505eb
--- /dev/null
+++ b/drivers/staging/iio/buffer.h
@@ -0,0 +1,242 @@
+/* The industrial I/O core - generic buffer interfaces.
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
+
+#ifdef CONFIG_IIO_BUFFER
+
+struct iio_buffer;
+
+/**
+ * struct iio_buffer_access_funcs - access functions for buffers.
+ * @mark_in_use:	reference counting, typically to prevent module removal
+ * @unmark_in_use:	reduce reference count when no longer using buffer
+ * @store_to:		actually store stuff to the buffer
+ * @read_last:		get the last element stored
+ * @read_first_n:	try to get a specified number of elements (must exist)
+ * @mark_param_change:	notify buffer that some relevant parameter has changed
+ *			Often this means the underlying storage may need to
+ *			change.
+ * @request_update:	if a parameter change has been marked, update underlying
+ *			storage.
+ * @get_bytes_per_datum:get current bytes per datum
+ * @set_bytes_per_datum:set number of bytes per datum
+ * @get_length:		get number of datums in buffer
+ * @set_length:		set number of datums in buffer
+ * @is_enabled:		query if buffer is currently being used
+ * @enable:		enable the buffer
+ *
+ * The purpose of this structure is to make the buffer element
+ * modular as event for a given driver, different usecases may require
+ * different buffer designs (space efficiency vs speed for example).
+ *
+ * It is worth noting that a given buffer implementation may only support a
+ * small proportion of these functions.  The core code 'should' cope fine with
+ * any of them not existing.
+ **/
+struct iio_buffer_access_funcs {
+	void (*mark_in_use)(struct iio_buffer *buffer);
+	void (*unmark_in_use)(struct iio_buffer *buffer);
+
+	int (*store_to)(struct iio_buffer *buffer, u8 *data, s64 timestamp);
+	int (*read_last)(struct iio_buffer *buffer, u8 *data);
+	int (*read_first_n)(struct iio_buffer *buffer,
+			    size_t n,
+			    char __user *buf);
+
+	int (*mark_param_change)(struct iio_buffer *buffer);
+	int (*request_update)(struct iio_buffer *buffer);
+
+	int (*get_bytes_per_datum)(struct iio_buffer *buffer);
+	int (*set_bytes_per_datum)(struct iio_buffer *buffer, size_t bpd);
+	int (*get_length)(struct iio_buffer *buffer);
+	int (*set_length)(struct iio_buffer *buffer, int length);
+
+	int (*is_enabled)(struct iio_buffer *buffer);
+	int (*enable)(struct iio_buffer *buffer);
+};
+
+/**
+ * struct iio_buffer_setup_ops - buffer setup related callbacks
+ * @preenable:		[DRIVER] function to run prior to marking buffer enabled
+ * @postenable:		[DRIVER] function to run after marking buffer enabled
+ * @predisable:		[DRIVER] function to run prior to marking buffer
+ *			disabled
+ * @postdisable:	[DRIVER] function to run after marking buffer disabled
+ */
+struct iio_buffer_setup_ops {
+	int				(*preenable)(struct iio_dev *);
+	int				(*postenable)(struct iio_dev *);
+	int				(*predisable)(struct iio_dev *);
+	int				(*postdisable)(struct iio_dev *);
+};
+
+/**
+ * struct iio_buffer - general buffer structure
+ * @indio_dev:		industrial I/O device structure
+ * @owner:		module that owns the buffer (for ref counting)
+ * @length:		[DEVICE] number of datums in buffer
+ * @bytes_per_datum:	[DEVICE] size of individual datum including timestamp
+ * @bpe:		[DEVICE] size of individual channel value
+ * @scan_el_attrs:	[DRIVER] control of scan elements if that scan mode
+ *			control method is used
+ * @scan_count:	[INTERN] the number of elements in the current scan mode
+ * @scan_mask:		[INTERN] bitmask used in masking scan mode elements
+ * @scan_timestamp:	[INTERN] does the scan mode include a timestamp
+ * @access:		[DRIVER] buffer access functions associated with the
+ *			implementation.
+ * @flags:		[INTERN] file ops related flags including busy flag.
+ * @demux_list:		[INTERN] list of operations required to demux the scan.
+ * @demux_bounce:	[INTERN] buffer for doing gather from incoming scan.
+ **/
+struct iio_buffer {
+	struct iio_dev				*indio_dev;
+	struct module				*owner;
+	int					length;
+	int					bytes_per_datum;
+	int					bpe;
+	struct attribute_group			*scan_el_attrs;
+	int					scan_count;
+	long					*scan_mask;
+	bool					scan_timestamp;
+	const struct iio_buffer_access_funcs	*access;
+	const struct iio_buffer_setup_ops		*setup_ops;
+	struct list_head			scan_el_dev_attr_list;
+	struct attribute_group			scan_el_group;
+	wait_queue_head_t			pollq;
+	bool					stufftoread;
+	unsigned long				flags;
+	const struct attribute_group *attrs;
+	struct list_head			demux_list;
+	unsigned char				*demux_bounce;
+};
+
+/**
+ * iio_buffer_init() - Initialize the buffer structure
+ * @buffer: buffer to be initialized
+ * @indio_dev: the iio device the buffer is assocated with
+ **/
+void iio_buffer_init(struct iio_buffer *buffer,
+			  struct iio_dev *indio_dev);
+
+void iio_buffer_deinit(struct iio_buffer *buffer);
+
+/**
+ * __iio_update_buffer() - update common elements of buffers
+ * @buffer:		buffer that is the event source
+ * @bytes_per_datum:	size of individual datum including timestamp
+ * @length:		number of datums in buffer
+ **/
+static inline void __iio_update_buffer(struct iio_buffer *buffer,
+				       int bytes_per_datum, int length)
+{
+	buffer->bytes_per_datum = bytes_per_datum;
+	buffer->length = length;
+}
+
+int iio_scan_mask_query(struct iio_buffer *buffer, int bit);
+
+/**
+ * iio_scan_mask_set() - set particular bit in the scan mask
+ * @buffer: the buffer whose scan mask we are interested in
+ * @bit: the bit to be set.
+ **/
+int iio_scan_mask_set(struct iio_buffer *buffer, int bit);
+
+#define to_iio_buffer(d)				\
+	container_of(d, struct iio_buffer, dev)
+
+/**
+ * iio_push_to_buffer() - push to a registered buffer.
+ * @buffer:		IIO buffer structure for device
+ * @scan:		Full scan.
+ * @timestamp:
+ */
+int iio_push_to_buffer(struct iio_buffer *buffer, unsigned char *data,
+		       s64 timestamp);
+
+int iio_update_demux(struct iio_dev *indio_dev);
+
+/**
+ * iio_buffer_register() - register the buffer with IIO core
+ * @indio_dev: device with the buffer to be registered
+ **/
+int iio_buffer_register(struct iio_dev *indio_dev,
+			const struct iio_chan_spec *channels,
+			int num_channels);
+
+/**
+ * iio_buffer_unregister() - unregister the buffer from IIO core
+ * @indio_dev: the device with the buffer to be unregistered
+ **/
+void iio_buffer_unregister(struct iio_dev *indio_dev);
+
+/**
+ * iio_buffer_read_length() - attr func to get number of datums in the buffer
+ **/
+ssize_t iio_buffer_read_length(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf);
+/**
+ * iio_buffer_write_length() - attr func to set number of datums in the buffer
+ **/
+ssize_t iio_buffer_write_length(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf,
+			      size_t len);
+/**
+ * iio_buffer_read_bytes_per_datum() - attr for number of bytes in whole datum
+ **/
+ssize_t iio_buffer_read_bytes_per_datum(struct device *dev,
+					struct device_attribute *attr,
+					char *buf);
+/**
+ * iio_buffer_store_enable() - attr to turn the buffer on
+ **/
+ssize_t iio_buffer_store_enable(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t len);
+/**
+ * iio_buffer_show_enable() - attr to see if the buffer is on
+ **/
+ssize_t iio_buffer_show_enable(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf);
+#define IIO_BUFFER_LENGTH_ATTR DEVICE_ATTR(length, S_IRUGO | S_IWUSR,	\
+					   iio_buffer_read_length,	\
+					   iio_buffer_write_length)
+#define IIO_BUFFER_BYTES_PER_DATUM_ATTR					\
+	DEVICE_ATTR(bytes_per_datum, S_IRUGO | S_IWUSR,			\
+		    iio_buffer_read_bytes_per_datum, NULL)
+
+#define IIO_BUFFER_ENABLE_ATTR DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,	\
+					   iio_buffer_show_enable,	\
+					   iio_buffer_store_enable)
+
+int iio_sw_buffer_preenable(struct iio_dev *indio_dev);
+
+#else /* CONFIG_IIO_BUFFER */
+
+static inline int iio_buffer_register(struct iio_dev *indio_dev,
+					   struct iio_chan_spec *channels,
+					   int num_channels)
+{
+	return 0;
+}
+
+static inline void iio_buffer_unregister(struct iio_dev *indio_dev)
+{};
+
+#endif /* CONFIG_IIO_BUFFER */
+
+#endif /* _IIO_BUFFER_GENERIC_H_ */
diff --git a/drivers/staging/iio/buffer_generic.h b/drivers/staging/iio/buffer_generic.h
deleted file mode 100644
index 1b0e781..0000000
--- a/drivers/staging/iio/buffer_generic.h
+++ /dev/null
@@ -1,243 +0,0 @@
-/* The industrial I/O core - generic buffer interfaces.
- *
- * Copyright (c) 2008 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-
-#ifndef _IIO_BUFFER_GENERIC_H_
-#define _IIO_BUFFER_GENERIC_H_
-#include <linux/sysfs.h>
-#include "iio.h"
-#include "chrdev.h"
-
-#ifdef CONFIG_IIO_BUFFER
-
-struct iio_buffer;
-
-/**
- * struct iio_buffer_access_funcs - access functions for buffers.
- * @mark_in_use:	reference counting, typically to prevent module removal
- * @unmark_in_use:	reduce reference count when no longer using buffer
- * @store_to:		actually store stuff to the buffer
- * @read_last:		get the last element stored
- * @read_first_n:	try to get a specified number of elements (must exist)
- * @mark_param_change:	notify buffer that some relevant parameter has changed
- *			Often this means the underlying storage may need to
- *			change.
- * @request_update:	if a parameter change has been marked, update underlying
- *			storage.
- * @get_bytes_per_datum:get current bytes per datum
- * @set_bytes_per_datum:set number of bytes per datum
- * @get_length:		get number of datums in buffer
- * @set_length:		set number of datums in buffer
- * @is_enabled:		query if buffer is currently being used
- * @enable:		enable the buffer
- *
- * The purpose of this structure is to make the buffer element
- * modular as event for a given driver, different usecases may require
- * different buffer designs (space efficiency vs speed for example).
- *
- * It is worth noting that a given buffer implementation may only support a
- * small proportion of these functions.  The core code 'should' cope fine with
- * any of them not existing.
- **/
-struct iio_buffer_access_funcs {
-	void (*mark_in_use)(struct iio_buffer *buffer);
-	void (*unmark_in_use)(struct iio_buffer *buffer);
-
-	int (*store_to)(struct iio_buffer *buffer, u8 *data, s64 timestamp);
-	int (*read_last)(struct iio_buffer *buffer, u8 *data);
-	int (*read_first_n)(struct iio_buffer *buffer,
-			    size_t n,
-			    char __user *buf);
-
-	int (*mark_param_change)(struct iio_buffer *buffer);
-	int (*request_update)(struct iio_buffer *buffer);
-
-	int (*get_bytes_per_datum)(struct iio_buffer *buffer);
-	int (*set_bytes_per_datum)(struct iio_buffer *buffer, size_t bpd);
-	int (*get_length)(struct iio_buffer *buffer);
-	int (*set_length)(struct iio_buffer *buffer, int length);
-
-	int (*is_enabled)(struct iio_buffer *buffer);
-	int (*enable)(struct iio_buffer *buffer);
-};
-
-/**
- * struct iio_buffer_setup_ops - buffer setup related callbacks
- * @preenable:		[DRIVER] function to run prior to marking buffer enabled
- * @postenable:		[DRIVER] function to run after marking buffer enabled
- * @predisable:		[DRIVER] function to run prior to marking buffer
- *			disabled
- * @postdisable:	[DRIVER] function to run after marking buffer disabled
- */
-struct iio_buffer_setup_ops {
-	int				(*preenable)(struct iio_dev *);
-	int				(*postenable)(struct iio_dev *);
-	int				(*predisable)(struct iio_dev *);
-	int				(*postdisable)(struct iio_dev *);
-};
-
-/**
- * struct iio_buffer - general buffer structure
- * @indio_dev:		industrial I/O device structure
- * @owner:		module that owns the buffer (for ref counting)
- * @length:		[DEVICE] number of datums in buffer
- * @bytes_per_datum:	[DEVICE] size of individual datum including timestamp
- * @bpe:		[DEVICE] size of individual channel value
- * @scan_el_attrs:	[DRIVER] control of scan elements if that scan mode
- *			control method is used
- * @scan_count:	[INTERN] the number of elements in the current scan mode
- * @scan_mask:		[INTERN] bitmask used in masking scan mode elements
- * @scan_timestamp:	[INTERN] does the scan mode include a timestamp
- * @access:		[DRIVER] buffer access functions associated with the
- *			implementation.
- * @flags:		[INTERN] file ops related flags including busy flag.
- * @demux_list:		[INTERN] list of operations required to demux the scan.
- * @demux_bounce:	[INTERN] buffer for doing gather from incoming scan.
- **/
-struct iio_buffer {
-	struct iio_dev				*indio_dev;
-	struct module				*owner;
-	int					length;
-	int					bytes_per_datum;
-	int					bpe;
-	struct attribute_group			*scan_el_attrs;
-	int					scan_count;
-	long					*scan_mask;
-	bool					scan_timestamp;
-	const struct iio_buffer_access_funcs	*access;
-	const struct iio_buffer_setup_ops		*setup_ops;
-	struct list_head			scan_el_dev_attr_list;
-	struct attribute_group			scan_el_group;
-	wait_queue_head_t			pollq;
-	bool					stufftoread;
-	unsigned long				flags;
-	const struct attribute_group *attrs;
-	struct list_head			demux_list;
-	unsigned char				*demux_bounce;
-};
-
-/**
- * iio_buffer_init() - Initialize the buffer structure
- * @buffer: buffer to be initialized
- * @indio_dev: the iio device the buffer is assocated with
- **/
-void iio_buffer_init(struct iio_buffer *buffer,
-			  struct iio_dev *indio_dev);
-
-void iio_buffer_deinit(struct iio_buffer *buffer);
-
-/**
- * __iio_update_buffer() - update common elements of buffers
- * @buffer:		buffer that is the event source
- * @bytes_per_datum:	size of individual datum including timestamp
- * @length:		number of datums in buffer
- **/
-static inline void __iio_update_buffer(struct iio_buffer *buffer,
-				       int bytes_per_datum, int length)
-{
-	buffer->bytes_per_datum = bytes_per_datum;
-	buffer->length = length;
-}
-
-int iio_scan_mask_query(struct iio_buffer *buffer, int bit);
-
-/**
- * iio_scan_mask_set() - set particular bit in the scan mask
- * @buffer: the buffer whose scan mask we are interested in
- * @bit: the bit to be set.
- **/
-int iio_scan_mask_set(struct iio_buffer *buffer, int bit);
-
-#define to_iio_buffer(d)				\
-	container_of(d, struct iio_buffer, dev)
-
-/**
- * iio_push_to_buffer() - push to a registered buffer.
- * @buffer:		IIO buffer structure for device
- * @scan:		Full scan.
- * @timestamp:
- */
-int iio_push_to_buffer(struct iio_buffer *buffer, unsigned char *data,
-		       s64 timestamp);
-
-int iio_update_demux(struct iio_dev *indio_dev);
-
-/**
- * iio_buffer_register() - register the buffer with IIO core
- * @indio_dev: device with the buffer to be registered
- **/
-int iio_buffer_register(struct iio_dev *indio_dev,
-			const struct iio_chan_spec *channels,
-			int num_channels);
-
-/**
- * iio_buffer_unregister() - unregister the buffer from IIO core
- * @indio_dev: the device with the buffer to be unregistered
- **/
-void iio_buffer_unregister(struct iio_dev *indio_dev);
-
-/**
- * iio_buffer_read_length() - attr func to get number of datums in the buffer
- **/
-ssize_t iio_buffer_read_length(struct device *dev,
-			       struct device_attribute *attr,
-			       char *buf);
-/**
- * iio_buffer_write_length() - attr func to set number of datums in the buffer
- **/
-ssize_t iio_buffer_write_length(struct device *dev,
-			      struct device_attribute *attr,
-			      const char *buf,
-			      size_t len);
-/**
- * iio_buffer_read_bytes_per_datum() - attr for number of bytes in whole datum
- **/
-ssize_t iio_buffer_read_bytes_per_datum(struct device *dev,
-					struct device_attribute *attr,
-					char *buf);
-/**
- * iio_buffer_store_enable() - attr to turn the buffer on
- **/
-ssize_t iio_buffer_store_enable(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf,
-				size_t len);
-/**
- * iio_buffer_show_enable() - attr to see if the buffer is on
- **/
-ssize_t iio_buffer_show_enable(struct device *dev,
-			       struct device_attribute *attr,
-			       char *buf);
-#define IIO_BUFFER_LENGTH_ATTR DEVICE_ATTR(length, S_IRUGO | S_IWUSR,	\
-					   iio_buffer_read_length,	\
-					   iio_buffer_write_length)
-#define IIO_BUFFER_BYTES_PER_DATUM_ATTR					\
-	DEVICE_ATTR(bytes_per_datum, S_IRUGO | S_IWUSR,			\
-		    iio_buffer_read_bytes_per_datum, NULL)
-
-#define IIO_BUFFER_ENABLE_ATTR DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,	\
-					   iio_buffer_show_enable,	\
-					   iio_buffer_store_enable)
-
-int iio_sw_buffer_preenable(struct iio_dev *indio_dev);
-
-#else /* CONFIG_IIO_BUFFER */
-
-static inline int iio_buffer_register(struct iio_dev *indio_dev,
-					   struct iio_chan_spec *channels,
-					   int num_channels)
-{
-	return 0;
-}
-
-static inline void iio_buffer_unregister(struct iio_dev *indio_dev)
-{};
-
-#endif /* CONFIG_IIO_BUFFER */
-
-#endif /* _IIO_BUFFER_GENERIC_H_ */
diff --git a/drivers/staging/iio/chrdev.h b/drivers/staging/iio/chrdev.h
deleted file mode 100644
index d8e736f..0000000
--- a/drivers/staging/iio/chrdev.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* The industrial I/O core - character device related
- *
- * Copyright (c) 2008 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-
-#ifndef _IIO_CHRDEV_H_
-#define _IIO_CHRDEV_H_
-
-/**
- * struct iio_event_data - The actual event being pushed to userspace
- * @id:		event identifier
- * @timestamp:	best estimate of time of event occurrence (often from
- *		the interrupt handler)
- */
-struct iio_event_data {
-	u64	id;
-	s64	timestamp;
-};
-
-#define IIO_GET_EVENT_FD_IOCTL _IOR('i', 0x90, int)
-#endif
diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index a0be132..5b3a244 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -19,6 +19,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
+#include "../events.h"
 #include "dac.h"
 #include "ad5504.h"
 
diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
new file mode 100644
index 0000000..6867894
--- /dev/null
+++ b/drivers/staging/iio/events.h
@@ -0,0 +1,71 @@
+/* The industrial I/O - event passing to userspace
+ *
+ * Copyright (c) 2008-2011 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+#include "types.h"
+
+#ifndef _IIO_EVENTS_H_
+#define _IIO_EVENTS_H_
+
+/**
+ * struct iio_event_data - The actual event being pushed to userspace
+ * @id:		event identifier
+ * @timestamp:	best estimate of time of event occurrence (often from
+ *		the interrupt handler)
+ */
+struct iio_event_data {
+	u64	id;
+	s64	timestamp;
+};
+
+#define IIO_GET_EVENT_FD_IOCTL _IOR('i', 0x90, int)
+
+enum iio_event_type {
+	IIO_EV_TYPE_THRESH,
+	IIO_EV_TYPE_MAG,
+	IIO_EV_TYPE_ROC,
+	IIO_EV_TYPE_THRESH_ADAPTIVE,
+	IIO_EV_TYPE_MAG_ADAPTIVE,
+};
+
+enum iio_event_direction {
+	IIO_EV_DIR_EITHER,
+	IIO_EV_DIR_RISING,
+	IIO_EV_DIR_FALLING,
+};
+
+#define IIO_EVENT_CODE(chan_type, diff, modifier, direction,		\
+		       type, chan, chan1, chan2)			\
+	(((u64)type << 56) | ((u64)diff << 55) |			\
+	 ((u64)direction << 48) | ((u64)modifier << 40) |		\
+	 ((u64)chan_type << 32) | (chan2 << 16) | chan1 | chan)
+
+
+#define IIO_EV_DIR_MAX 4
+#define IIO_EV_BIT(type, direction)			\
+	(1 << (type*IIO_EV_DIR_MAX + direction))
+
+#define IIO_MOD_EVENT_CODE(channelclass, number, modifier,		\
+			   type, direction)				\
+	IIO_EVENT_CODE(channelclass, 0, modifier, direction, type, number, 0, 0)
+
+#define IIO_UNMOD_EVENT_CODE(channelclass, number, type, direction)	\
+	IIO_EVENT_CODE(channelclass, 0, 0, direction, type, number, 0, 0)
+
+#define IIO_EVENT_CODE_EXTRACT_TYPE(mask) ((mask >> 56) & 0xFF)
+
+#define IIO_EVENT_CODE_EXTRACT_DIR(mask) ((mask >> 48) & 0xCF)
+
+#define IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(mask) ((mask >> 32) & 0xFF)
+
+/* Event code number extraction depends on which type of event we have.
+ * Perhaps review this function in the future*/
+#define IIO_EVENT_CODE_EXTRACT_NUM(mask) (mask & 0xFFFF)
+
+#define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 40) & 0xFF)
+
+#endif
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index d37fae7..8051bed 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -21,7 +21,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 
 #include "adis16260.h"
 
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 429589f..339b609 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -7,7 +7,7 @@
  * under the terms of the GNU General Public License version 2 as published by
  * the Free Software Foundation.
  */
-
+#include "types.h"
 #ifndef _INDUSTRIAL_IO_H_
 #define _INDUSTRIAL_IO_H_
 
@@ -25,42 +25,6 @@ enum iio_data_type {
 	IIO_PROCESSED,
 };
 
-enum iio_chan_type {
-	/* real channel types */
-	IIO_VOLTAGE,
-	IIO_CURRENT,
-	IIO_POWER,
-	IIO_ACCEL,
-	IIO_ANGL_VEL,
-	IIO_MAGN,
-	IIO_LIGHT,
-	IIO_INTENSITY,
-	IIO_PROXIMITY,
-	IIO_TEMP,
-	IIO_INCLI,
-	IIO_ROT,
-	IIO_ANGL,
-	IIO_TIMESTAMP,
-	IIO_CAPACITANCE,
-};
-
-enum iio_modifier {
-	IIO_NO_MOD,
-	IIO_MOD_X,
-	IIO_MOD_Y,
-	IIO_MOD_Z,
-	IIO_MOD_X_AND_Y,
-	IIO_MOD_X_ANX_Z,
-	IIO_MOD_Y_AND_Z,
-	IIO_MOD_X_AND_Y_AND_Z,
-	IIO_MOD_X_OR_Y,
-	IIO_MOD_X_OR_Z,
-	IIO_MOD_Y_OR_Z,
-	IIO_MOD_X_OR_Y_OR_Z,
-	IIO_MOD_LIGHT_BOTH,
-	IIO_MOD_LIGHT_IR,
-};
-
 /* Could add the raw attributes as well - allowing buffer only devices */
 enum iio_chan_info_enum {
 	IIO_CHAN_INFO_SCALE_SHARED,
diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index af0c992..06c022e 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -21,7 +21,8 @@
 
 #include "iio.h"
 #include "sysfs.h"
-#include "buffer_generic.h"
+#include "events.h"
+#include "buffer.h"
 #include "iio_simple_dummy.h"
 
 /*
diff --git a/drivers/staging/iio/iio_simple_dummy_events.c b/drivers/staging/iio/iio_simple_dummy_events.c
index 9f00cff..449c7a5 100644
--- a/drivers/staging/iio/iio_simple_dummy_events.c
+++ b/drivers/staging/iio/iio_simple_dummy_events.c
@@ -14,6 +14,7 @@
 
 #include "iio.h"
 #include "sysfs.h"
+#include "events.h"
 #include "iio_simple_dummy.h"
 
 /* Evgen 'fakes' interrupt events for this example */
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 1086e0b..1f495da 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -21,7 +21,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 #include "../ring_sw.h"
 
 #include "ad5933.h"
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index d082a37..e6df4921 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -28,7 +28,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 #include "adis16400.h"
 
 enum adis16400_chip_variant {
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index bac672d..cb0fea0 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -23,7 +23,7 @@
 #include "iio.h"
 #include "iio_core.h"
 #include "sysfs.h"
-#include "buffer_generic.h"
+#include "buffer.h"
 
 static const char * const iio_endian_prefix[] = {
 	[IIO_BE] = "be",
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 00ef005..3b03a97 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -25,8 +25,8 @@
 #include "iio.h"
 #include "iio_core.h"
 #include "iio_core_trigger.h"
-#include "chrdev.h"
 #include "sysfs.h"
+#include "events.h"
 
 /* IDA to assign each registered device a unique id*/
 static DEFINE_IDA(iio_ida);
diff --git a/drivers/staging/iio/kfifo_buf.h b/drivers/staging/iio/kfifo_buf.h
index a15598b..cc2bd9a 100644
--- a/drivers/staging/iio/kfifo_buf.h
+++ b/drivers/staging/iio/kfifo_buf.h
@@ -1,7 +1,7 @@
 
 #include <linux/kfifo.h>
 #include "iio.h"
-#include "buffer_generic.h"
+#include "buffer.h"
 
 extern const struct iio_buffer_access_funcs kfifo_access_funcs;
 
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 7e984bc..e69387a 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -37,6 +37,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
+#include "../events.h"
 #include "tsl2563.h"
 
 /* Use this many bits for fraction part. */
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 7d66343..a601b64 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -21,7 +21,7 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../buffer_generic.h"
+#include "../buffer.h"
 #include "meter.h"
 #include "ade7758.h"
 
diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.h
index a3e1578..e6a6e2c 100644
--- a/drivers/staging/iio/ring_sw.h
+++ b/drivers/staging/iio/ring_sw.h
@@ -23,7 +23,7 @@
 
 #ifndef _IIO_RING_SW_H_
 #define _IIO_RING_SW_H_
-#include "buffer_generic.h"
+#include "buffer.h"
 
 /**
  * ring_sw_access_funcs - access functions for a software ring buffer
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 868952b..bfedb73 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -114,47 +114,4 @@ struct iio_const_attr {
 #define IIO_CONST_ATTR_TEMP_SCALE(_string)		\
 	IIO_CONST_ATTR(in_temp_scale, _string)
 
-enum iio_event_type {
-	IIO_EV_TYPE_THRESH,
-	IIO_EV_TYPE_MAG,
-	IIO_EV_TYPE_ROC,
-	IIO_EV_TYPE_THRESH_ADAPTIVE,
-	IIO_EV_TYPE_MAG_ADAPTIVE,
-};
-
-enum iio_event_direction {
-	IIO_EV_DIR_EITHER,
-	IIO_EV_DIR_RISING,
-	IIO_EV_DIR_FALLING,
-};
-
-#define IIO_EVENT_CODE(chan_type, diff, modifier, direction,		\
-		       type, chan, chan1, chan2)			\
-	(((u64)type << 56) | ((u64)diff << 55) |			\
-	 ((u64)direction << 48) | ((u64)modifier << 40) |		\
-	 ((u64)chan_type << 32) | (chan2 << 16) | chan1 | chan)
-
-#define IIO_EV_DIR_MAX 4
-#define IIO_EV_BIT(type, direction)			\
-	(1 << (type*IIO_EV_DIR_MAX + direction))
-
-#define IIO_MOD_EVENT_CODE(channelclass, number, modifier,		\
-			   type, direction)				\
-	IIO_EVENT_CODE(channelclass, 0, modifier, direction, type, number, 0, 0)
-
-#define IIO_UNMOD_EVENT_CODE(channelclass, number, type, direction)	\
-	IIO_EVENT_CODE(channelclass, 0, 0, direction, type, number, 0, 0)
-
-#define IIO_EVENT_CODE_EXTRACT_TYPE(mask) ((mask >> 56) & 0xFF)
-
-#define IIO_EVENT_CODE_EXTRACT_DIR(mask) ((mask >> 48) & 0xCF)
-
-#define IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(mask) ((mask >> 32) & 0xFF)
-
-/* Event code number extraction depends on which type of event we have.
- * Perhaps review this function in the future*/
-#define IIO_EVENT_CODE_EXTRACT_NUM(mask) (mask & 0xFFFF)
-
-#define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 40) & 0xFF)
-
 #endif /* _INDUSTRIAL_IO_SYSFS_H_ */
diff --git a/drivers/staging/iio/types.h b/drivers/staging/iio/types.h
new file mode 100644
index 0000000..f1f5ca2
--- /dev/null
+++ b/drivers/staging/iio/types.h
@@ -0,0 +1,49 @@
+/* industrial I/O data types needed both in and out of kernel
+ *
+ * Copyright (c) 2008 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef _IIO_TYPES_H_
+#define _IIO_TYPES_H_
+
+enum iio_chan_type {
+	/* real channel types */
+	IIO_VOLTAGE,
+	IIO_CURRENT,
+	IIO_POWER,
+	IIO_ACCEL,
+	IIO_ANGL_VEL,
+	IIO_MAGN,
+	IIO_LIGHT,
+	IIO_INTENSITY,
+	IIO_PROXIMITY,
+	IIO_TEMP,
+	IIO_INCLI,
+	IIO_ROT,
+	IIO_ANGL,
+	IIO_TIMESTAMP,
+	IIO_CAPACITANCE,
+};
+
+enum iio_modifier {
+	IIO_NO_MOD,
+	IIO_MOD_X,
+	IIO_MOD_Y,
+	IIO_MOD_Z,
+	IIO_MOD_X_AND_Y,
+	IIO_MOD_X_ANX_Z,
+	IIO_MOD_Y_AND_Z,
+	IIO_MOD_X_AND_Y_AND_Z,
+	IIO_MOD_X_OR_Y,
+	IIO_MOD_X_OR_Z,
+	IIO_MOD_Y_OR_Z,
+	IIO_MOD_X_OR_Y_OR_Z,
+	IIO_MOD_LIGHT_BOTH,
+	IIO_MOD_LIGHT_IR,
+};
+
+#endif /* _IIO_TYPES_H_ */
-- 
1.7.7
