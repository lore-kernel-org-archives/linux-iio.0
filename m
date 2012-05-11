Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [RFC 1/8] iio: Add helper functions for enum style channel attributes
Date: Fri, 11 May 2012 17:53:48 +0200
Message-Id: <1336751635-7934-1-git-send-email-lars@metafoo.de>
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
 drivers/iio/industrialio-core.c |   57 +++++++++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |   32 ++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index b39a587..241be03 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -288,6 +288,63 @@ static ssize_t iio_write_channel_ext_info(struct device *dev,
 			       this_attr->c, buf, len);
 }
 
+ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
+	uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
+{
+	const struct iio_enum *e = (const struct iio_enum *)priv;
+	char *tmp = buf;
+	unsigned int i;
+
+	if (!e->num_items)
+		return 0;
+
+	for (i = 0; i < e->num_items; ++i)
+		tmp += sprintf(tmp, "%s ", e->items[i]);
+
+	/* replace last space with a newline */
+	*(tmp - 1) = '\n';
+
+	return tmp - buf;
+}
+EXPORT_SYMBOL_GPL(iio_enum_available_read);
+
+ssize_t iio_enum_read(struct iio_dev *indio_dev,
+	uintptr_t priv, const struct iio_chan_spec *chan, char *buf)
+{
+	const struct iio_enum *e = (const struct iio_enum *)priv;
+	int i;
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
index 6fdbdb8..602f118 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -124,6 +124,38 @@ struct iio_chan_spec_ext_info {
 	uintptr_t private;
 };
 
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
+#define IIO_ENUM(_name, _shared, _e) \
+{ \
+	.name = (_name), \
+	.shared = (_shared), \
+	.read = iio_enum_read, \
+	.write = iio_enum_write, \
+	.private = (uintptr_t)(_e), \
+}
+
+#define IIO_ENUM_AVAILABLE(_name, _e) \
+{ \
+	.name = (_name "_available"), \
+	.shared = true, \
+	.read = iio_enum_available_read, \
+	.private = (uintptr_t)(_e), \
+}
+
 /**
  * struct iio_chan_spec - specification of a single channel
  * @type:		What type of measurement is the channel making.
-- 
1.7.10
