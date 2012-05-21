Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/18] iio: Add helper functions for enum style channel attributes
Date: Mon, 21 May 2012 13:42:50 +0200
Message-Id: <1337600587-19848-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

We often have the case were we do have a enum style channel attribute. These
attributes have in common that they are a list of string values which usually
map in a 1-to-1 fashion to integer values.

This patch implements some common helper code for implementing enum style
channel attributes using extended channel attributes. The helper functions take
care of converting between the string and integer values, as well providing a
function for "_available" attributes which list all available enum items.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
Changes since v1:
	* Add documentation for struct iio_enum, IIO_ENUM and IIO_ENUM_AVAILABLE.
	* Make set and get callbacks optional

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c |   63 ++++++++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |   64 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 1ddd886..56a3c0b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -289,6 +289,69 @@ static ssize_t iio_write_channel_ext_info(struct device *dev,
 			       this_attr->c, buf, len);
 }
 
+ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
+	uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
+{
+	const struct iio_enum *e = (const struct iio_enum *)priv;
+	unsigned int i;
+	size_t len = 0;
+
+	if (!e->num_items)
+		return 0;
+
+	for (i = 0; i < e->num_items; ++i)
+		len += snprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
+
+	/* replace last space with a newline */
+	buf[len - 1] = '\n';
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(iio_enum_available_read);
+
+ssize_t iio_enum_read(struct iio_dev *indio_dev,
+	uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
+{
+	const struct iio_enum *e = (const struct iio_enum *)priv;
+	int i;
+
+	if (!e->get)
+		return -EINVAL;
+
+	i = e->get(indio_dev, chan);
+	if (i < 0)
+		return i;
+	else if (i >= e->num_items)
+		return -EINVAL;
+
+	return sprintf(buf, "%s\n", e->items[i]);
+}
+EXPORT_SYMBOL_GPL(iio_enum_read);
+
+ssize_t iio_enum_write(struct iio_dev *indio_dev,
+	uintptr_t priv, const struct iio_chan_spec *chan, const char *buf,
+	size_t len)
+{
+	const struct iio_enum *e = (const struct iio_enum *)priv;
+	unsigned int i;
+	int ret;
+
+	if (!e->set)
+		return -EINVAL;
+
+	for (i = 0; i < e->num_items; i++) {
+		if (sysfs_streq(buf, e->items[i]))
+			break;
+	}
+
+	if (i == e->num_items)
+		return -EINVAL;
+
+	ret = e->set(indio_dev, chan, i);
+	return ret ? ret : len;
+}
+EXPORT_SYMBOL_GPL(iio_enum_write);
+
 static ssize_t iio_read_channel_info(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 3a4f6a3..7378bbd 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -130,6 +130,70 @@ struct iio_chan_spec_ext_info {
 };
 
 /**
+ * struct iio_enum - Enum channel info attribute
+ * items: A array of strings.
+ * num_items: Length of the item array.
+ * set: Set callback function, may be NULL.
+ * get: Get callback function, may be NULL.
+ *
+ * The iio_enum struct can be used to implement enum style channel attributes.
+ * Enum style attributes are those which have a set of strings which map to
+ * integer values. The IIO enum helper code takes care of mapping between the
+ * integer and string values as well as generating a "_available" file which
+ * contains a list of all available items. The set callback will be called when
+ * the attribute is updated. The last parameter is the index to the newly
+ * activated item. The get callback will be used to query the currently active
+ * item and is supposed to return the index for it.
+ */
+struct iio_enum {
+	const char * const *items;
+	unsigned int num_items;
+	int (*set)(struct iio_dev *, const struct iio_chan_spec *, unsigned int);
+	int (*get)(struct iio_dev *, const struct iio_chan_spec *);
+};
+
+ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
+	uintptr_t priv, const struct iio_chan_spec *chan, char *buf);
+ssize_t iio_enum_read(struct iio_dev *indio_dev,
+	uintptr_t priv, const struct iio_chan_spec *chan, char *buf);
+ssize_t iio_enum_write(struct iio_dev *indio_dev,
+	uintptr_t priv, const struct iio_chan_spec *chan, const char *buf,
+	size_t len);
+
+/**
+ * IIO_ENUM() - Initialize enum extended channel attribute
+ * @_name: Attribute name
+ * @_shared: Whether the attribute is shared between all channels
+ * @_e: Pointer to a iio_enum struct
+ *
+ * This should usually be used together with IIO_ENUM_AVAILABLE()
+ */
+#define IIO_ENUM(_name, _shared, _e) \
+{ \
+	.name = (_name), \
+	.shared = (_shared), \
+	.read = iio_enum_read, \
+	.write = iio_enum_write, \
+	.private = (uintptr_t)(_e), \
+}
+
+/**
+ * IIO_ENUM_AVAILABLE() - Initialize enum available extended channel attribute
+ * @_name: Attribute name ("_available" will be appended to the name)
+ * @_e: Pointer to a iio_enum struct
+ *
+ * Creates a read only attribute which list all the available enum items in a
+ * space separated list. This should usually be used together with IIO_ENUM()
+ */
+#define IIO_ENUM_AVAILABLE(_name, _e) \
+{ \
+	.name = (_name "_available"), \
+	.shared = true, \
+	.read = iio_enum_available_read, \
+	.private = (uintptr_t)(_e), \
+}
+
+/**
  * struct iio_chan_spec - specification of a single channel
  * @type:		What type of measurement is the channel making.
  * @channel:		What number or name do we wish to assign the channel.
-- 
1.7.10
