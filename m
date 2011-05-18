Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 078/111] staging:iio: rip out scan_el attributes. Now handled as iio_dev_attrs like everything else.
Date: Wed, 18 May 2011 14:42:08 +0100
Message-Id: <1305726161-5606-79-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Drivers have no need to use this functionality any more and we save a lot of
code by getting rid of it.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-ring.c |  101 ++++++++---------------------
 drivers/staging/iio/ring_generic.h      |  108 -------------------------------
 2 files changed, 26 insertions(+), 183 deletions(-)

diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index 4497a50..853ebe9 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -193,53 +193,6 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 		       this_attr->c->scan_type.shift);
 }
 
-static int __iio_add_chan_scan_elattr(const char *postfix,
-				      const char *group,
-				      const struct iio_chan_spec *chan,
-				      struct device *dev,
-				      struct list_head *attr_list)
-{
-	int ret;
-	struct iio_scan_el *scan_el;
-
-	scan_el = kzalloc(sizeof *scan_el, GFP_KERNEL);
-	if (scan_el == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	if (chan->type != IIO_TIMESTAMP)
-		ret = __iio_device_attr_init(&scan_el->dev_attr, postfix, chan,
-					     iio_scan_el_show,
-					     iio_scan_el_store, 0);
-	else /*
-	      * Timestamp handled separately because it simplifies a lot of
-	      * drivers by ensuring they don't have to know its magic index
-	      */
-		ret = __iio_device_attr_init(&scan_el->dev_attr, postfix, chan,
-					     iio_scan_el_ts_show,
-					     iio_scan_el_ts_store, 0);
-	if (ret)
-		goto error_free_scan_el;
-
-	scan_el->number = chan->scan_index;
-
-	ret = sysfs_add_file_to_group(&dev->kobj,
-				      &scan_el->dev_attr.attr,
-				      group);
-	if (ret < 0)
-		goto error_device_attr_deinit;
-
-	list_add(&scan_el->l, attr_list);
-
-	return 0;
-error_device_attr_deinit:
-	__iio_device_attr_deinit(&scan_el->dev_attr);
-error_free_scan_el:
-	kfree(scan_el);
-error_ret:
-	return ret;
-}
-
 static int iio_ring_add_channel_sysfs(struct iio_ring_buffer *ring,
 				      const struct iio_chan_spec *chan)
 {
@@ -268,23 +221,28 @@ static int iio_ring_add_channel_sysfs(struct iio_ring_buffer *ring,
 	if (ret)
 		goto error_ret;
 
-	ret = __iio_add_chan_scan_elattr("en", "scan_elements",
-					 chan, &ring->dev,
-					 &ring->scan_el_en_attr_list);
-
+	if (chan->type != IIO_TIMESTAMP)
+		ret = __iio_add_chan_devattr("en", "scan_elements",
+					     chan,
+					     &iio_scan_el_show,
+					     &iio_scan_el_store,
+					     chan->scan_index,
+					     0,
+					     &ring->dev,
+					     &ring->scan_el_dev_attr_list);
+	else
+		ret = __iio_add_chan_devattr("en", "scan_elements",
+					     chan,
+					     &iio_scan_el_ts_show,
+					     &iio_scan_el_ts_store,
+					     chan->scan_index,
+					     0,
+					     &ring->dev,
+					     &ring->scan_el_dev_attr_list);
 error_ret:
 	return ret;
 }
 
-static void iio_ring_remove_and_free_scan_el_attr(struct iio_ring_buffer *ring,
-						  struct iio_scan_el *p)
-{
-	sysfs_remove_file_from_group(&ring->dev.kobj,
-				     &p->dev_attr.attr, "scan_elements");
-	kfree(p->dev_attr.attr.name);
-	kfree(p);
-}
-
 static void iio_ring_remove_and_free_scan_dev_attr(struct iio_ring_buffer *ring,
 						   struct iio_dev_attr *p)
 {
@@ -306,15 +264,10 @@ static struct attribute_group iio_scan_el_dummy_group = {
 static void __iio_ring_attr_cleanup(struct iio_ring_buffer *ring)
 {
 	struct iio_dev_attr *p, *n;
-	struct iio_scan_el *q, *m;
-	int anydynamic = !(list_empty(&ring->scan_el_dev_attr_list) &&
-			   list_empty(&ring->scan_el_en_attr_list));
+	int anydynamic = !list_empty(&ring->scan_el_dev_attr_list);
 	list_for_each_entry_safe(p, n,
 				 &ring->scan_el_dev_attr_list, l)
 		iio_ring_remove_and_free_scan_dev_attr(ring, p);
-	list_for_each_entry_safe(q, m,
-				 &ring->scan_el_en_attr_list, l)
-		iio_ring_remove_and_free_scan_el_attr(ring, q);
 
 	if (ring->scan_el_attrs)
 		sysfs_remove_group(&ring->dev.kobj,
@@ -352,7 +305,6 @@ int iio_ring_buffer_register_ex(struct iio_ring_buffer *ring, int id,
 	}
 
 	INIT_LIST_HEAD(&ring->scan_el_dev_attr_list);
-	INIT_LIST_HEAD(&ring->scan_el_en_attr_list);
 	if (channels) {
 		/* new magic */
 		for (i = 0; i < num_channels; i++) {
@@ -554,9 +506,9 @@ ssize_t iio_scan_el_show(struct device *dev,
 {
 	int ret;
 	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_scan_el *this_el = to_iio_scan_el(attr);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
-	ret = iio_scan_mask_query(ring, this_el->number);
+	ret = iio_scan_mask_query(ring, this_attr->address);
 	if (ret < 0)
 		return ret;
 	return sprintf(buf, "%d\n", ret);
@@ -572,7 +524,7 @@ ssize_t iio_scan_el_store(struct device *dev,
 	bool state;
 	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
 	struct iio_dev *indio_dev = ring->indio_dev;
-	struct iio_scan_el *this_el = to_iio_scan_el(attr);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	state = !(buf[0] == '0');
 	mutex_lock(&indio_dev->mlock);
@@ -580,20 +532,19 @@ ssize_t iio_scan_el_store(struct device *dev,
 		ret = -EBUSY;
 		goto error_ret;
 	}
-	ret = iio_scan_mask_query(ring, this_el->number);
+	ret = iio_scan_mask_query(ring, this_attr->address);
 	if (ret < 0)
 		goto error_ret;
 	if (!state && ret) {
-		ret = iio_scan_mask_clear(ring, this_el->number);
+		ret = iio_scan_mask_clear(ring, this_attr->address);
 		if (ret)
 			goto error_ret;
 	} else if (state && !ret) {
-		ret = iio_scan_mask_set(ring, this_el->number);
+		ret = iio_scan_mask_set(ring, this_attr->address);
 		if (ret)
 			goto error_ret;
 	}
-	if (this_el->set_state)
-		ret = this_el->set_state(this_el, indio_dev, state);
+
 error_ret:
 	mutex_unlock(&indio_dev->mlock);
 
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 671e9fd..15d15a4 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -108,7 +108,6 @@ struct iio_ring_buffer {
 	int				(*postdisable)(struct iio_dev *);
 
 	struct list_head scan_el_dev_attr_list;
-	struct list_head scan_el_en_attr_list;
 
 	wait_queue_head_t pollq;
 	bool stufftoread;
@@ -137,29 +136,6 @@ static inline void __iio_update_ring_buffer(struct iio_ring_buffer *ring,
 }
 
 /**
- * struct iio_scan_el - an individual element of a scan
- * @dev_attr:		control attribute (if directly controllable)
- * @number:		unique identifier of element (used for bit mask)
- * @label:		useful data for the scan el (often reg address)
- * @set_state:		for some devices datardy signals are generated
- *			for any enabled lines.  This allows unwanted lines
- *			to be disabled and hence not get in the way.
- **/
-struct iio_scan_el {
-	struct device_attribute		dev_attr;
-	unsigned int			number;
-	unsigned int			label;
-	struct list_head l;
-
-	int (*set_state)(struct iio_scan_el *scanel,
-			 struct iio_dev *dev_info,
-			 bool state);
-};
-
-#define to_iio_scan_el(_dev_attr)				\
-	container_of(_dev_attr, struct iio_scan_el, dev_attr);
-
-/**
  * iio_scan_el_store() - sysfs scan element selection interface
  * @dev: the target device
  * @attr: the device attribute that is being processed
@@ -197,90 +173,6 @@ ssize_t iio_scan_el_ts_store(struct device *dev, struct device_attribute *attr,
  **/
 ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
 			    char *buf);
-/**
- * IIO_SCAN_EL_C - declare and initialize a scan element with a control func
- *
- * @_name:	identifying name. Resulting struct is iio_scan_el_##_name,
- *		sysfs element, _name##_en.
- * @_number:	unique id number for the scan element.
- *		length devices).
- * @_label:	indentification variable used by drivers.  Often a reg address.
- * @_controlfunc: function used to notify hardware of whether state changes
- **/
-#define __IIO_SCAN_EL_C(_name, _number, _label, _controlfunc)	\
-	struct iio_scan_el iio_scan_el_##_name = {			\
-		.dev_attr = __ATTR(_name##_en,				\
-				   S_IRUGO | S_IWUSR,			\
-				   iio_scan_el_show,			\
-				   iio_scan_el_store),			\
-		.number =  _number,					\
-		.label = _label,					\
-		.set_state = _controlfunc,				\
-	};								\
-	static IIO_CONST_ATTR(_name##_index, #_number)
-
-#define IIO_SCAN_EL_C(_name, _number, _label, _controlfunc)	\
-	__IIO_SCAN_EL_C(_name, _number, _label, _controlfunc)
-
-#define __IIO_SCAN_NAMED_EL_C(_name, _string, _number, _label, _cf)	\
-	struct iio_scan_el iio_scan_el_##_name = {			\
-		.dev_attr = __ATTR(_string##_en,			\
-				   S_IRUGO | S_IWUSR,			\
-				   iio_scan_el_show,			\
-				   iio_scan_el_store),			\
-		.number =  _number,					\
-		.label = _label,					\
-		.set_state = _cf,					\
-	};								\
-	static struct iio_const_attr iio_const_attr_##_name##_index = {	\
-		.string = #_number,					\
-		.dev_attr = __ATTR(_string##_index,			\
-				   S_IRUGO, iio_read_const_attr, NULL)	\
-	}
-
-
-#define IIO_SCAN_NAMED_EL_C(_name, _string, _number, _label, _cf) \
-	__IIO_SCAN_NAMED_EL_C(_name, _string, _number, _label, _cf)
-/**
- * IIO_SCAN_EL_TIMESTAMP - declare a special scan element for timestamps
- * @number: specify where in the scan order this is stored.
- *
- * Odd one out. Handled slightly differently from other scan elements.
- **/
-#define IIO_SCAN_EL_TIMESTAMP(number)				\
-	struct iio_scan_el iio_scan_el_timestamp = {		\
-		.dev_attr = __ATTR(timestamp_en,		\
-				   S_IRUGO | S_IWUSR,		\
-				   iio_scan_el_ts_show,		\
-				   iio_scan_el_ts_store),	\
-	};							\
-	static IIO_CONST_ATTR(timestamp_index, #number)
-
-/**
- * IIO_CONST_ATTR_SCAN_EL_TYPE - attr to specify the data format of a scan el
- * @name: the scan el name (may be more general and cover a set of scan elements
- * @_sign: either s or u for signed or unsigned
- * @_bits: number of actual bits occuplied by the value
- * @_storagebits: number of bits _bits is padded to when read out of buffer
- **/
-#define IIO_CONST_ATTR_SCAN_EL_TYPE(_name, _sign, _bits, _storagebits) \
-	IIO_CONST_ATTR(_name##_type, #_sign#_bits"/"#_storagebits);
-
-/**
- * IIO_CONST_ATTR_SCAN_EL_TYPE_WITH_SHIFT - attr to specify the data format of a scan el
- * @name: the scan el name (may be more general and cover a set of scan elements
- * @_sign: either s or u for signed or unsigned
- * @_bits: number of actual bits occuplied by the value
- * @_storagebits: number of bits _bits is padded to when read out of buffer
- * @_shiftbits: number of bits _shiftbits the result must be shifted
- **/
-#define IIO_CONST_ATTR_SCAN_EL_TYPE_WITH_SHIFT(_name, _sign, _bits, \
-					       _storagebits, _shiftbits) \
-	IIO_CONST_ATTR(_name##_type, #_sign#_bits"/"#_storagebits \
-		       ">>"#_shiftbits);
-
-#define IIO_SCAN_EL_TYPE_SIGNED         's'
-#define IIO_SCAN_EL_TYPE_UNSIGNED       'u'
 
 /*
  * These are mainly provided to allow for a change of implementation if a device
-- 
1.7.3.4
