Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/8] staging:iio: Drop buffer mark_param_change callback
Date: Fri, 16 Dec 2011 11:19:49 +0100
Message-ID: <1324030791-17983-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1324030791-17983-1-git-send-email-lars@metafoo.de>
References: <1324030791-17983-1-git-send-email-lars@metafoo.de>
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

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/Documentation/ring.txt |    2 --
 drivers/staging/iio/buffer.h               |    4 ----
 drivers/staging/iio/industrialio-buffer.c  |    5 +----
 drivers/staging/iio/kfifo_buf.c            |   21 ++++++++++-----------
 drivers/staging/iio/ring_sw.c              |   21 ++++++++++-----------
 5 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/iio/Documentation/ring.txt b/drivers/staging/iio/Documentation/ring.txt
index 7e99ef2..5134fd9 100644
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
index eb4938c..208c471 100644
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
@@ -51,7 +48,6 @@ struct iio_buffer_access_funcs {
 			    size_t n,
 			    char __user *buf);
 
-	int (*mark_param_change)(struct iio_buffer *buffer);
 	int (*request_update)(struct iio_buffer *buffer);
 
 	int (*get_bytes_per_datum)(struct iio_buffer *buffer);
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index f0a7044..adf6d35 100644
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
index b69cca5..33d9202 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -109,29 +109,29 @@ static int iio_get_bytes_per_datum_kfifo(struct iio_buffer *r)
 	return r->bytes_per_datum;
 }
 
+static int iio_mark_update_needed_kfifo(struct iio_buffer *r)
+{
+	struct iio_kfifo *kf = iio_to_kfifo(r);
+	kf->update_needed = true;
+	return 0;
+}
+
 static int iio_set_bytes_per_datum_kfifo(struct iio_buffer *r, size_t bpd)
 {
 	if (r->bytes_per_datum != bpd) {
 		r->bytes_per_datum = bpd;
-		if (r->access->mark_param_change)
-			r->access->mark_param_change(r);
+		iio_mark_update_needed_kfifo(r);
 	}
 	return 0;
 }
 
-static int iio_mark_update_needed_kfifo(struct iio_buffer *r)
-{
-	struct iio_kfifo *kf = iio_to_kfifo(r);
-	kf->update_needed = true;
-	return 0;
-}
+
 
 static int iio_set_length_kfifo(struct iio_buffer *r, int length)
 {
 	if (r->length != length) {
 		r->length = length;
-		if (r->access->mark_param_change)
-			r->access->mark_param_change(r);
+		iio_mark_update_needed_kfifo(r);
 	}
 	return 0;
 }
@@ -174,7 +174,6 @@ const struct iio_buffer_access_funcs kfifo_access_funcs = {
 	.unmark_in_use = &iio_unmark_kfifo_in_use,
 	.store_to = &iio_store_to_kfifo,
 	.read_first_n = &iio_read_first_n_kfifo,
-	.mark_param_change = &iio_mark_update_needed_kfifo,
 	.request_update = &iio_request_update_kfifo,
 	.get_bytes_per_datum = &iio_get_bytes_per_datum_kfifo,
 	.set_bytes_per_datum = &iio_set_bytes_per_datum_kfifo,
diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index 4c15cc8..03eae3a 100644
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
@@ -335,18 +341,12 @@ static int iio_set_length_sw_rb(struct iio_buffer *r, int length)
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
+
 
 static IIO_BUFFER_ENABLE_ATTR;
 static IIO_BUFFER_LENGTH_ATTR;
@@ -392,7 +392,6 @@ const struct iio_buffer_access_funcs ring_sw_access_funcs = {
 	.unmark_in_use = &iio_unmark_sw_rb_in_use,
 	.store_to = &iio_store_to_sw_rb,
 	.read_first_n = &iio_read_first_n_sw_rb,
-	.mark_param_change = &iio_mark_update_needed_sw_rb,
 	.request_update = &iio_request_update_sw_rb,
 	.get_bytes_per_datum = &iio_get_bytes_per_datum_sw_rb,
 	.set_bytes_per_datum = &iio_set_bytes_per_datum_sw_rb,
-- 
1.7.7.3
