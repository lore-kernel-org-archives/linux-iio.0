Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich
	<michael.hennerich@analog.com>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/8] staging:iio: Drop buffer mark_param_change callback
Date: Mon, 19 Dec 2011 15:23:48 +0100
Message-ID: <1324304629-24720-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1324304629-24720-1-git-send-email-lars@metafoo.de>
References: <1324304629-24720-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Right now we have a mark_param_change callback in the buffer access
functions struct, which should be called whenever the parameters (length,
bytes per datum) of the buffer change. But it is only called when the user
changes the buffer size, not when the bytes per datum change. Additionally each
buffer implementation already keeps track internally whether its parameters
have changed, making the call to mark_param_change after changing the buffer
length redundant. Since each buffer implementation knows best when one of its
parameters has changed just make tracking of this internal and drop the
mark_param_change callback.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/Documentation/ring.txt |    2 --
 drivers/staging/iio/buffer.h               |    4 ----
 drivers/staging/iio/industrialio-buffer.c  |    5 +----
 drivers/staging/iio/kfifo_buf.c            |   21 +++++++++------------
 drivers/staging/iio/ring_sw.c              |   21 +++++++++------------
 5 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/iio/Documentation/ring.txt b/drivers/staging/iio/Documentation/ring.txt
index 1b77aee..0f21479 100644
--- a/drivers/staging/iio/Documentation/ring.txt
+++ b/drivers/staging/iio/Documentation/ring.txt
@@ -39,8 +39,6 @@ rip_first_n
   The primary buffer reading function. Note that it may well not return
   as much data as requested.
 
-mark_param_changed
-  Used to indicate that something has changed. Used in conjunction with
 request_update
   If parameters have changed that require reinitialization or configuration of
   the buffer this will trigger it.
diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index b0e04df..ea42b5d 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -22,9 +22,6 @@ struct iio_buffer;
  * @unmark_in_use:	reduce reference count when no longer using buffer
  * @store_to:		actually store stuff to the buffer
  * @read_first_n:	try to get a specified number of bytes (must exist)
- * @mark_param_change:	notify buffer that some relevant parameter has changed
- *			Often this means the underlying storage may need to
- *			change.
  * @request_update:	if a parameter change has been marked, update underlying
  *			storage.
  * @get_bytes_per_datum:get current bytes per datum
@@ -49,7 +46,6 @@ struct iio_buffer_access_funcs {
 			    size_t n,
 			    char __user *buf);
 
-	int (*mark_param_change)(struct iio_buffer *buffer);
 	int (*request_update)(struct iio_buffer *buffer);
 
 	int (*get_bytes_per_datum)(struct iio_buffer *buffer);
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index 4c6d183..d2858ff 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -399,11 +399,8 @@ ssize_t iio_buffer_write_length(struct device *dev,
 	if (iio_buffer_enabled(indio_dev)) {
 		ret = -EBUSY;
 	} else {
-		if (buffer->access->set_length) {
+		if (buffer->access->set_length)
 			buffer->access->set_length(buffer, val);
-			if (buffer->access->mark_param_change)
-				buffer->access->mark_param_change(buffer);
-		}
 		ret = 0;
 	}
 	mutex_unlock(&indio_dev->mlock);
diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index b69cca5..bae4caf 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -109,20 +109,19 @@ static int iio_get_bytes_per_datum_kfifo(struct iio_buffer *r)
 	return r->bytes_per_datum;
 }
 
-static int iio_set_bytes_per_datum_kfifo(struct iio_buffer *r, size_t bpd)
+static int iio_mark_update_needed_kfifo(struct iio_buffer *r)
 {
-	if (r->bytes_per_datum != bpd) {
-		r->bytes_per_datum = bpd;
-		if (r->access->mark_param_change)
-			r->access->mark_param_change(r);
-	}
+	struct iio_kfifo *kf = iio_to_kfifo(r);
+	kf->update_needed = true;
 	return 0;
 }
 
-static int iio_mark_update_needed_kfifo(struct iio_buffer *r)
+static int iio_set_bytes_per_datum_kfifo(struct iio_buffer *r, size_t bpd)
 {
-	struct iio_kfifo *kf = iio_to_kfifo(r);
-	kf->update_needed = true;
+	if (r->bytes_per_datum != bpd) {
+		r->bytes_per_datum = bpd;
+		iio_mark_update_needed_kfifo(r);
+	}
 	return 0;
 }
 
@@ -130,8 +129,7 @@ static int iio_set_length_kfifo(struct iio_buffer *r, int length)
 {
 	if (r->length != length) {
 		r->length = length;
-		if (r->access->mark_param_change)
-			r->access->mark_param_change(r);
+		iio_mark_update_needed_kfifo(r);
 	}
 	return 0;
 }
@@ -174,7 +172,6 @@ const struct iio_buffer_access_funcs kfifo_access_funcs = {
 	.unmark_in_use = &iio_unmark_kfifo_in_use,
 	.store_to = &iio_store_to_kfifo,
 	.read_first_n = &iio_read_first_n_kfifo,
-	.mark_param_change = &iio_mark_update_needed_kfifo,
 	.request_update = &iio_request_update_kfifo,
 	.get_bytes_per_datum = &iio_get_bytes_per_datum_kfifo,
 	.set_bytes_per_datum = &iio_set_bytes_per_datum_kfifo,
diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 4c15cc8..c239fd3 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -316,12 +316,18 @@ static int iio_get_bytes_per_datum_sw_rb(struct iio_buffer *r)
 	return ring->buf.bytes_per_datum;
 }
 
+static int iio_mark_update_needed_sw_rb(struct iio_buffer *r)
+{
+	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
+	ring->update_needed = true;
+	return 0;
+}
+
 static int iio_set_bytes_per_datum_sw_rb(struct iio_buffer *r, size_t bpd)
 {
 	if (r->bytes_per_datum != bpd) {
 		r->bytes_per_datum = bpd;
-		if (r->access->mark_param_change)
-			r->access->mark_param_change(r);
+		iio_mark_update_needed_sw_rb(r);
 	}
 	return 0;
 }
@@ -335,19 +341,11 @@ static int iio_set_length_sw_rb(struct iio_buffer *r, int length)
 {
 	if (r->length != length) {
 		r->length = length;
-		if (r->access->mark_param_change)
-			r->access->mark_param_change(r);
+		iio_mark_update_needed_sw_rb(r);
 	}
 	return 0;
 }
 
-static int iio_mark_update_needed_sw_rb(struct iio_buffer *r)
-{
-	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(r);
-	ring->update_needed = true;
-	return 0;
-}
-
 static IIO_BUFFER_ENABLE_ATTR;
 static IIO_BUFFER_LENGTH_ATTR;
 
@@ -392,7 +390,6 @@ const struct iio_buffer_access_funcs ring_sw_access_funcs = {
 	.unmark_in_use = &iio_unmark_sw_rb_in_use,
 	.store_to = &iio_store_to_sw_rb,
 	.read_first_n = &iio_read_first_n_sw_rb,
-	.mark_param_change = &iio_mark_update_needed_sw_rb,
 	.request_update = &iio_request_update_sw_rb,
 	.get_bytes_per_datum = &iio_get_bytes_per_datum_sw_rb,
 	.set_bytes_per_datum = &iio_set_bytes_per_datum_sw_rb,
-- 
1.7.7.3
