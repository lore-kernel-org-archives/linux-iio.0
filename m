Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 104/111] staging:iio: ring core cleanups + check if read_last available in lis3l02dq
Date: Wed, 18 May 2011 14:42:34 +0100
Message-Id: <1305726161-5606-105-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c |    7 +-
 drivers/staging/iio/industrialio-ring.c    |  237 +++++++++++++---------------
 drivers/staging/iio/ring_generic.h         |  125 ++-------------
 3 files changed, 136 insertions(+), 233 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 5029c51..c8f29bc 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -50,9 +50,13 @@ ssize_t lis3l02dq_read_accel_from_ring(struct iio_ring_buffer *ring,
 {
 	int ret;
 	s16 *data;
+
 	if (!iio_scan_mask_query(ring, index))
 		return -EINVAL;
 
+	if (!ring->access->read_last)
+		return -EBUSY;
+
 	data = kmalloc(ring->access->get_bytes_per_datum(ring),
 		       GFP_KERNEL);
 	if (data == NULL)
@@ -61,9 +65,10 @@ ssize_t lis3l02dq_read_accel_from_ring(struct iio_ring_buffer *ring,
 	ret = ring->access->read_last(ring, (u8 *)data);
 	if (ret)
 		goto error_free_data;
-	*val = data[iio_scan_mask_count_to_right(ring, index)];
+	*val = data[bitmap_weight(&ring->scan_mask, index)];
 error_free_data:
 	kfree(data);
+
 	return ret;
 }
 
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index 050f9f9..843eb82 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -71,14 +71,10 @@ static ssize_t iio_ring_read_first_n_outer(struct file *filp, char __user *buf,
 				  size_t n, loff_t *f_ps)
 {
 	struct iio_ring_buffer *rb = filp->private_data;
-	int ret;
 
-	/* rip lots must exist. */
 	if (!rb->access->read_first_n)
 		return -EINVAL;
-	ret = rb->access->read_first_n(rb, n, buf);
-
-	return ret;
+	return rb->access->read_first_n(rb, n, buf);
 }
 
 /**
@@ -88,13 +84,12 @@ static unsigned int iio_ring_poll(struct file *filp,
 				  struct poll_table_struct *wait)
 {
 	struct iio_ring_buffer *rb = filp->private_data;
-	int ret = 0;
 
 	poll_wait(filp, &rb->pollq, wait);
 	if (rb->stufftoread)
 		return POLLIN | POLLRDNORM;
 	/* need a way of knowing if there may be enough data... */
-	return ret;
+	return 0;
 }
 
 static const struct file_operations iio_ring_fileops = {
@@ -117,24 +112,23 @@ EXPORT_SYMBOL(iio_ring_access_release);
 
 static inline int
 __iio_request_ring_buffer_chrdev(struct iio_ring_buffer *buf,
-					struct module *owner)
+				 struct module *owner,
+				 int id)
 {
-	int ret, minor;
+	int ret;
 
 	buf->access_handler.flags = 0;
-
 	buf->dev.bus = &iio_bus_type;
 	device_initialize(&buf->dev);
 
-	minor = iio_device_get_chrdev_minor();
-	if (minor < 0) {
-		ret = minor;
+	ret = iio_device_get_chrdev_minor();
+	if (ret < 0)
 		goto error_device_put;
-	}
-	buf->dev.devt = MKDEV(MAJOR(iio_devt), minor);
+
+	buf->dev.devt = MKDEV(MAJOR(iio_devt), ret);
 	dev_set_name(&buf->dev, "%s:buffer%d",
 		     dev_name(buf->dev.parent),
-		     buf->id);
+		     id);
 	ret = device_add(&buf->dev);
 	if (ret < 0) {
 		printk(KERN_ERR "failed to add the ring dev\n");
@@ -172,11 +166,10 @@ void iio_ring_buffer_init(struct iio_ring_buffer *ring,
 EXPORT_SYMBOL(iio_ring_buffer_init);
 
 static ssize_t iio_show_scan_index(struct device *dev,
-				  struct device_attribute *attr,
-				  char *buf)
+				   struct device_attribute *attr,
+				   char *buf)
 {
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	return sprintf(buf, "%u\n", this_attr->c->scan_index);
+	return sprintf(buf, "%u\n", to_iio_dev_attr(attr)->c->scan_index);
 }
 
 static ssize_t iio_show_fixed_type(struct device *dev,
@@ -191,6 +184,95 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 		       this_attr->c->scan_type.shift);
 }
 
+static ssize_t iio_scan_el_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	int ret;
+	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+
+	ret = iio_scan_mask_query(ring, to_iio_dev_attr(attr)->address);
+	if (ret < 0)
+		return ret;
+	return sprintf(buf, "%d\n", ret);
+}
+
+static int iio_scan_mask_clear(struct iio_ring_buffer *ring, int bit)
+{
+	if (bit > IIO_MAX_SCAN_LENGTH)
+		return -EINVAL;
+	ring->scan_mask &= ~(1 << bit);
+	ring->scan_count--;
+	return 0;
+}
+
+static ssize_t iio_scan_el_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t len)
+{
+	int ret = 0;
+	bool state;
+	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = ring->indio_dev;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	state = !(buf[0] == '0');
+	mutex_lock(&indio_dev->mlock);
+	if (indio_dev->currentmode == INDIO_RING_TRIGGERED) {
+		ret = -EBUSY;
+		goto error_ret;
+	}
+	ret = iio_scan_mask_query(ring, this_attr->address);
+	if (ret < 0)
+		goto error_ret;
+	if (!state && ret) {
+		ret = iio_scan_mask_clear(ring, this_attr->address);
+		if (ret)
+			goto error_ret;
+	} else if (state && !ret) {
+		ret = iio_scan_mask_set(ring, this_attr->address);
+		if (ret)
+			goto error_ret;
+	}
+
+error_ret:
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret ? ret : len;
+
+}
+
+static ssize_t iio_scan_el_ts_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n", ring->scan_timestamp);
+}
+
+static ssize_t iio_scan_el_ts_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf,
+				    size_t len)
+{
+	int ret = 0;
+	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = ring->indio_dev;
+	bool state;
+	state = !(buf[0] == '0');
+	mutex_lock(&indio_dev->mlock);
+	if (indio_dev->currentmode == INDIO_RING_TRIGGERED) {
+		ret = -EBUSY;
+		goto error_ret;
+	}
+	ring->scan_timestamp = state;
+error_ret:
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret ? ret : len;
+}
+
 static int iio_ring_add_channel_sysfs(struct iio_ring_buffer *ring,
 				      const struct iio_chan_spec *chan)
 {
@@ -215,7 +297,6 @@ static int iio_ring_add_channel_sysfs(struct iio_ring_buffer *ring,
 				     0,
 				     &ring->dev,
 				     &ring->scan_el_dev_attr_list);
-
 	if (ret)
 		goto error_ret;
 
@@ -281,12 +362,10 @@ int iio_ring_buffer_register_ex(struct iio_ring_buffer *ring, int id,
 {
 	int ret, i;
 
-	ring->id = id;
-
-	ret = __iio_request_ring_buffer_chrdev(ring, ring->owner);
-
+	ret = __iio_request_ring_buffer_chrdev(ring, ring->owner, id);
 	if (ret)
 		goto error_ret;
+
 	if (ring->scan_el_attrs) {
 		ret = sysfs_create_group(&ring->dev.kobj,
 					 ring->scan_el_attrs);
@@ -322,12 +401,6 @@ error_ret:
 }
 EXPORT_SYMBOL(iio_ring_buffer_register_ex);
 
-int iio_ring_buffer_register(struct iio_ring_buffer *ring, int id)
-{
-	return iio_ring_buffer_register_ex(ring, id, NULL, 0);
-}
-EXPORT_SYMBOL(iio_ring_buffer_register);
-
 void iio_ring_buffer_unregister(struct iio_ring_buffer *ring)
 {
 	__iio_ring_attr_cleanup(ring);
@@ -339,14 +412,13 @@ ssize_t iio_read_ring_length(struct device *dev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	int len = 0;
 	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
 
 	if (ring->access->get_length)
-		len = sprintf(buf, "%d\n",
-			      ring->access->get_length(ring));
+		return sprintf(buf, "%d\n",
+			       ring->access->get_length(ring));
 
-	return len;
+	return 0;
 }
 EXPORT_SYMBOL(iio_read_ring_length);
 
@@ -358,6 +430,7 @@ ssize_t iio_write_ring_length(struct device *dev,
 	int ret;
 	ulong val;
 	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+
 	ret = strict_strtoul(buf, 10, &val);
 	if (ret)
 		return ret;
@@ -380,14 +453,13 @@ ssize_t iio_read_ring_bytes_per_datum(struct device *dev,
 			  struct device_attribute *attr,
 			  char *buf)
 {
-	int len = 0;
 	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
 
 	if (ring->access->get_bytes_per_datum)
-		len = sprintf(buf, "%d\n",
-			      ring->access->get_bytes_per_datum(ring));
+		return sprintf(buf, "%d\n",
+			       ring->access->get_bytes_per_datum(ring));
 
-	return len;
+	return 0;
 }
 EXPORT_SYMBOL(iio_read_ring_bytes_per_datum);
 
@@ -450,7 +522,6 @@ ssize_t iio_store_ring_enable(struct device *dev,
 		}
 
 		if (ring->setup_ops->postenable) {
-
 			ret = ring->setup_ops->postenable(dev_info);
 			if (ret) {
 				printk(KERN_INFO
@@ -488,6 +559,7 @@ error_ret:
 	return ret;
 }
 EXPORT_SYMBOL(iio_store_ring_enable);
+
 ssize_t iio_show_ring_enable(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
@@ -498,91 +570,6 @@ ssize_t iio_show_ring_enable(struct device *dev,
 }
 EXPORT_SYMBOL(iio_show_ring_enable);
 
-ssize_t iio_scan_el_show(struct device *dev,
-			 struct device_attribute *attr,
-			 char *buf)
-{
-	int ret;
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	ret = iio_scan_mask_query(ring, this_attr->address);
-	if (ret < 0)
-		return ret;
-	return sprintf(buf, "%d\n", ret);
-}
-EXPORT_SYMBOL(iio_scan_el_show);
-
-ssize_t iio_scan_el_store(struct device *dev,
-			  struct device_attribute *attr,
-			  const char *buf,
-			  size_t len)
-{
-	int ret = 0;
-	bool state;
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = ring->indio_dev;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	state = !(buf[0] == '0');
-	mutex_lock(&indio_dev->mlock);
-	if (indio_dev->currentmode == INDIO_RING_TRIGGERED) {
-		ret = -EBUSY;
-		goto error_ret;
-	}
-	ret = iio_scan_mask_query(ring, this_attr->address);
-	if (ret < 0)
-		goto error_ret;
-	if (!state && ret) {
-		ret = iio_scan_mask_clear(ring, this_attr->address);
-		if (ret)
-			goto error_ret;
-	} else if (state && !ret) {
-		ret = iio_scan_mask_set(ring, this_attr->address);
-		if (ret)
-			goto error_ret;
-	}
-
-error_ret:
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret ? ret : len;
-
-}
-EXPORT_SYMBOL(iio_scan_el_store);
-
-ssize_t iio_scan_el_ts_show(struct device *dev,
-			    struct device_attribute *attr,
-			    char *buf)
-{
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", ring->scan_timestamp);
-}
-EXPORT_SYMBOL(iio_scan_el_ts_show);
-
-ssize_t iio_scan_el_ts_store(struct device *dev,
-			     struct device_attribute *attr,
-			     const char *buf,
-			     size_t len)
-{
-	int ret = 0;
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = ring->indio_dev;
-	bool state;
-	state = !(buf[0] == '0');
-	mutex_lock(&indio_dev->mlock);
-	if (indio_dev->currentmode == INDIO_RING_TRIGGERED) {
-		ret = -EBUSY;
-		goto error_ret;
-	}
-	ring->scan_timestamp = state;
-error_ret:
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret ? ret : len;
-}
-EXPORT_SYMBOL(iio_scan_el_ts_store);
-
 int iio_sw_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct iio_ring_buffer *ring = indio_dev->ring;
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 3349676..3f26f71 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -76,11 +76,9 @@ struct iio_ring_setup_ops {
  * @dev:		ring buffer device struct
  * @indio_dev:		industrial I/O device structure
  * @owner:		module that owns the ring buffer (for ref counting)
- * @id:			unique id number
  * @length:		[DEVICE] number of datums in ring
  * @bytes_per_datum:	[DEVICE] size of individual datum including timestamp
  * @bpe:		[DEVICE] size of individual channel value
- * @loopcount:		[INTERN] number of times the ring has looped
  * @scan_el_attrs:	[DRIVER] control of scan elements if that scan mode
  *			control method is used
  * @scan_count:	[INTERN] the number of elements in the current scan mode
@@ -93,27 +91,25 @@ struct iio_ring_setup_ops {
  * @postenable:		[DRIVER] function to run after marking ring enabled
  * @predisable:		[DRIVER] function to run prior to marking ring disabled
  * @postdisable:	[DRIVER] function to run after marking ring disabled
-  **/
+ **/
 struct iio_ring_buffer {
-	struct device dev;
-	struct iio_dev *indio_dev;
-	struct module *owner;
-	int				id;
-	int				length;
-	int				bytes_per_datum;
-	int				bpe;
-	int				loopcount;
-	struct attribute_group		*scan_el_attrs;
-	int				scan_count;
-	u32				scan_mask;
-	bool				scan_timestamp;
-	struct iio_handler		access_handler;
+	struct device				dev;
+	struct iio_dev				*indio_dev;
+	struct module				*owner;
+	int					length;
+	int					bytes_per_datum;
+	int					bpe;
+	struct attribute_group			*scan_el_attrs;
+	int					scan_count;
+	unsigned long				scan_mask;
+	bool					scan_timestamp;
+	struct iio_handler			access_handler;
 	const struct iio_ring_access_funcs	*access;
-	const struct iio_ring_setup_ops	*setup_ops;
-	struct list_head scan_el_dev_attr_list;
+	const struct iio_ring_setup_ops		*setup_ops;
+	struct list_head			scan_el_dev_attr_list;
 
-	wait_queue_head_t pollq;
-	bool stufftoread;
+	wait_queue_head_t			pollq;
+	bool					stufftoread;
 };
 
 /**
@@ -135,48 +131,8 @@ static inline void __iio_update_ring_buffer(struct iio_ring_buffer *ring,
 {
 	ring->bytes_per_datum = bytes_per_datum;
 	ring->length = length;
-	ring->loopcount = 0;
 }
 
-/**
- * iio_scan_el_store() - sysfs scan element selection interface
- * @dev: the target device
- * @attr: the device attribute that is being processed
- * @buf: input from userspace
- * @len: length of input
- *
- * A generic function used to enable various scan elements.  In some
- * devices explicit read commands for each channel mean this is merely
- * a software switch.  In others this must actively disable the channel.
- * Complexities occur when this interacts with data ready type triggers
- * which may not reset unless every channel that is enabled is explicitly
- * read.
- **/
-ssize_t iio_scan_el_store(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t len);
-/**
- * iio_scan_el_show() -	sysfs interface to query whether a scan element
- *			is enabled or not
- * @dev: the target device
- * @attr: the device attribute that is being processed
- * @buf: output buffer
- **/
-ssize_t iio_scan_el_show(struct device *dev, struct device_attribute *attr,
-			 char *buf);
-
-/**
- * iio_scan_el_ts_store() - sysfs interface to set whether a timestamp is included
- *			    in the scan.
- **/
-ssize_t iio_scan_el_ts_store(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t len);
-/**
- * iio_scan_el_ts_show() - sysfs interface to query if a timestamp is included
- *			   in the scan.
- **/
-ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
-			    char *buf);
-
 /*
  * These are mainly provided to allow for a change of implementation if a device
  * has a large number of scan elements
@@ -243,41 +199,6 @@ static inline int iio_scan_mask_set(struct iio_ring_buffer *ring, int bit)
 };
 
 /**
- * iio_scan_mask_clear() - clear a particular element from the scan mask
- * @ring: the ring buffer whose scan mask we are interested in
- * @bit: the bit to clear
- **/
-static inline int iio_scan_mask_clear(struct iio_ring_buffer *ring, int bit)
-{
-	if (bit > IIO_MAX_SCAN_LENGTH)
-		return -EINVAL;
-	ring->scan_mask &= ~(1 << bit);
-	ring->scan_count--;
-	return 0;
-};
-
-/**
- * iio_scan_mask_count_to_right() - how many scan elements occur before here
- * @ring: the ring buffer whose scan mask we interested in
- * @bit: which number scan element is this
- **/
-static inline int iio_scan_mask_count_to_right(struct iio_ring_buffer *ring,
-						int bit)
-{
-	int count = 0;
-	int mask = (1 << bit);
-	if (bit > IIO_MAX_SCAN_LENGTH)
-		return -EINVAL;
-	while (mask) {
-		mask >>= 1;
-		if (mask & ring->scan_mask)
-			count++;
-	}
-
-	return count;
-}
-
-/**
  * iio_put_ring_buffer() - notify done with buffer
  * @ring: the buffer we are done with.
  **/
@@ -286,17 +207,11 @@ static inline void iio_put_ring_buffer(struct iio_ring_buffer *ring)
 	put_device(&ring->dev);
 };
 
-#define to_iio_ring_buffer(d)			\
+#define to_iio_ring_buffer(d)				\
 	container_of(d, struct iio_ring_buffer, dev)
 
 /**
- * iio_ring_buffer_register() - register the buffer with IIO core
- * @ring: the buffer to be registered
- * @id: the id of the buffer (typically 0)
- **/
-int iio_ring_buffer_register(struct iio_ring_buffer *ring, int id);
-
-/** iio_ring_buffer_register_ex() - register the buffer with IIO core
+ * iio_ring_buffer_register_ex() - register the buffer with IIO core
  * @ring: the buffer to be registered
  * @id: the id of the buffer (typically 0)
  **/
@@ -356,10 +271,6 @@ ssize_t iio_show_ring_enable(struct device *dev,
 int iio_sw_ring_preenable(struct iio_dev *indio_dev);
 
 #else /* CONFIG_IIO_RING_BUFFER */
-static inline int iio_ring_buffer_register(struct iio_ring_buffer *ring, int id)
-{
-	return 0;
-};
 
 static inline int iio_ring_buffer_register_ex(struct iio_ring_buffer *ring,
 					      int id,
-- 
1.7.3.4
