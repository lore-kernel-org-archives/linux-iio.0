Return-Path: <peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, "Rob
 Herring" <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Jonathan
 Cameron" <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <linux-i2c@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
Subject: [PATCH v3 3/7] iio: inkern: api for manipulating ext_info of iio channels
Date: Mon, 21 Nov 2016 14:17:11 +0100
Message-ID: <1479734235-18837-4-git-send-email-peda@axentia.se>
In-Reply-To: <1479734235-18837-1-git-send-email-peda@axentia.se>
References: <1479734235-18837-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Extend the inkern api with functions for reading and writing ext_info
of iio channels.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/inkern.c         | 55 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iio/consumer.h | 37 +++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index c4757e6367e7..efe418282cc3 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -746,3 +746,58 @@ int iio_write_channel_raw(struct iio_channel *chan, int val)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iio_write_channel_raw);
+
+int iio_get_channel_ext_info_count(struct iio_channel *chan)
+{
+	const struct iio_chan_spec_ext_info *ext_info;
+	unsigned int i = 0;
+
+	if (!chan->channel->ext_info)
+		return i;
+
+	for (ext_info = chan->channel->ext_info; ext_info->name; ext_info++)
+		++i;
+
+	return i;
+}
+EXPORT_SYMBOL_GPL(iio_get_channel_ext_info_count);
+
+ssize_t iio_read_channel_ext_info(struct iio_channel *chan,
+				  const char *attr, char *buf)
+{
+	const struct iio_chan_spec_ext_info *ext_info;
+
+	if (!chan->channel->ext_info)
+		return -EINVAL;
+
+	for (ext_info = chan->channel->ext_info; ext_info->name; ++ext_info) {
+		if (strcmp(attr, ext_info->name))
+			continue;
+
+		return ext_info->read(chan->indio_dev, ext_info->private,
+				      chan->channel, buf);
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(iio_read_channel_ext_info);
+
+ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
+				   const char *buf, size_t len)
+{
+	const struct iio_chan_spec_ext_info *ext_info;
+
+	if (!chan->channel->ext_info)
+		return -EINVAL;
+
+	for (ext_info = chan->channel->ext_info; ext_info->name; ++ext_info) {
+		if (strcmp(attr, ext_info->name))
+			continue;
+
+		return ext_info->write(chan->indio_dev, ext_info->private,
+				       chan->channel, buf, len);
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(iio_write_channel_ext_info);
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 9edccfba1ffb..1e908ccb11f0 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -271,4 +271,41 @@ int iio_read_channel_scale(struct iio_channel *chan, int *val,
 int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
 	int *processed, unsigned int scale);
 
+/**
+ * iio_get_channel_ext_info_count() - get number of ext_info attributes
+ *				      connected to the channel.
+ * @chan:		The channel being queried
+ *
+ * Returns the number of ext_info attributes
+ */
+int iio_get_channel_ext_info_count(struct iio_channel *chan);
+
+/**
+ * iio_read_channel_ext_info() - read ext_info attribute from a given channel
+ * @chan:		The channel being queried.
+ * @attr:		The ext_info attribute to read.
+ * @buf:		Where to store the attribute value. Assumed to hold
+ *			at least PAGE_SIZE bytes.
+ *
+ * Returns the number of bytes written to buf (perhaps w/o zero termination;
+ * it need not even be a string), or an error code.
+ */
+ssize_t iio_read_channel_ext_info(struct iio_channel *chan,
+				  const char *attr, char *buf);
+
+/**
+ * iio_write_channel_ext_info() - write ext_info attribute from a given channel
+ * @chan:		The channel being queried.
+ * @attr:		The ext_info attribute to read.
+ * @buf:		The new attribute value. Strings needs to be zero-
+ *			terminated, but the terminator should not be included
+ *			in the below len.
+ * @len:		The size of the new attribute value.
+ *
+ * Returns the number of accepted bytes, which should be the same as len.
+ * An error code can also be returned.
+ */
+ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
+				   const char *buf, size_t len);
+
 #endif
-- 
2.1.4
