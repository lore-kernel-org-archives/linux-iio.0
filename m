Return-Path: <k.wrona@samsung.com>
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>,
 Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH v2 1/3] iio: kfifo: Remove unused argument in iio_kfifo_allocate
Date: Fri, 19 Dec 2014 18:39:24 +0100
Message-id: <1419010766-13557-2-git-send-email-k.wrona@samsung.com>
In-reply-to: <1419010766-13557-1-git-send-email-k.wrona@samsung.com>
References: <1419010766-13557-1-git-send-email-k.wrona@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

indio_dev was unused in function body plus some small style fix - add new
lines after "if(sth) return sth" and before the last return statement.

The argument was removed also in its client.

Signed-off-by: Karol Wrona <k.wrona@samsung.com>
---
 drivers/iio/adc/ti_am335x_adc.c                 |    2 +-
 drivers/iio/industrialio-triggered-buffer.c     |    2 +-
 drivers/iio/kfifo_buf.c                         |    6 ++++--
 drivers/staging/iio/accel/lis3l02dq_ring.c      |    2 +-
 drivers/staging/iio/iio_simple_dummy_buffer.c   |    2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |    2 +-
 drivers/staging/iio/meter/ade7758_ring.c        |    2 +-
 include/linux/iio/kfifo_buf.h                   |    2 +-
 8 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index b730864..bf87993 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -250,7 +250,7 @@ static int tiadc_iio_buffered_hardware_setup(struct iio_dev *indio_dev,
 	struct iio_buffer *buffer;
 	int ret;
 
-	buffer = iio_kfifo_allocate(indio_dev);
+	buffer = iio_kfifo_allocate();
 	if (!buffer)
 		return -ENOMEM;
 
diff --git a/drivers/iio/industrialio-triggered-buffer.c b/drivers/iio/industrialio-triggered-buffer.c
index d6f54930..6c6307a 100644
--- a/drivers/iio/industrialio-triggered-buffer.c
+++ b/drivers/iio/industrialio-triggered-buffer.c
@@ -49,7 +49,7 @@ int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
 	struct iio_buffer *buffer;
 	int ret;
 
-	buffer = iio_kfifo_allocate(indio_dev);
+	buffer = iio_kfifo_allocate();
 	if (!buffer) {
 		ret = -ENOMEM;
 		goto error_ret;
diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index 7134e8a..a383291 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -166,19 +166,21 @@ static const struct iio_buffer_access_funcs kfifo_access_funcs = {
 	.release = &iio_kfifo_buffer_release,
 };
 
-struct iio_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
+struct iio_buffer *iio_kfifo_allocate(void)
 {
 	struct iio_kfifo *kf;
 
-	kf = kzalloc(sizeof *kf, GFP_KERNEL);
+	kf = kzalloc(sizeof(*kf), GFP_KERNEL);
 	if (!kf)
 		return NULL;
+
 	kf->update_needed = true;
 	iio_buffer_init(&kf->buffer);
 	kf->buffer.attrs = &iio_kfifo_attribute_group;
 	kf->buffer.access = &kfifo_access_funcs;
 	kf->buffer.length = 2;
 	mutex_init(&kf->user_lock);
+
 	return &kf->buffer;
 }
 EXPORT_SYMBOL(iio_kfifo_allocate);
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 9efc77b..1fd9009 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -393,7 +393,7 @@ int lis3l02dq_configure_buffer(struct iio_dev *indio_dev)
 	int ret;
 	struct iio_buffer *buffer;
 
-	buffer = iio_kfifo_allocate(indio_dev);
+	buffer = iio_kfifo_allocate();
 	if (!buffer)
 		return -ENOMEM;
 
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index fd74f91..df765c9 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -122,7 +122,7 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev,
 	struct iio_buffer *buffer;
 
 	/* Allocate a buffer to use - here a kfifo */
-	buffer = iio_kfifo_allocate(indio_dev);
+	buffer = iio_kfifo_allocate();
 	if (buffer == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index b6bd609..ace9ef8 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -626,7 +626,7 @@ static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
 	struct iio_buffer *buffer;
 
-	buffer = iio_kfifo_allocate(indio_dev);
+	buffer = iio_kfifo_allocate();
 	if (!buffer)
 		return -ENOMEM;
 
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 6e90064..31d2cf3 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -118,7 +118,7 @@ int ade7758_configure_ring(struct iio_dev *indio_dev)
 	struct iio_buffer *buffer;
 	int ret = 0;
 
-	buffer = iio_kfifo_allocate(indio_dev);
+	buffer = iio_kfifo_allocate();
 	if (!buffer) {
 		ret = -ENOMEM;
 		return ret;
diff --git a/include/linux/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
index 25eeac7..1a8d57a 100644
--- a/include/linux/iio/kfifo_buf.h
+++ b/include/linux/iio/kfifo_buf.h
@@ -5,7 +5,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 
-struct iio_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev);
+struct iio_buffer *iio_kfifo_allocate(void);
 void iio_kfifo_free(struct iio_buffer *r);
 
 #endif
-- 
1.7.9.5
