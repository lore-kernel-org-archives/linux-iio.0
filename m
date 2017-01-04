Return-Path: <SRS0=tr1Y=YS=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Wolfram Sang <wsa@the-dreams.de>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v7 06/12] iio: inkern: api for manipulating ext_info of iio channels
Date: Wed,  4 Jan 2017 13:16:21 +0100
Message-Id: <1483532187-28494-7-git-send-email-peda@axentia.se>
In-Reply-To: <1483532187-28494-1-git-send-email-peda@axentia.se>
References: <1483532187-28494-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Extend the inkern api with functions for reading and writing ext_info
of iio channels.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/inkern.c         | 60 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iio/consumer.h | 37 +++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index b0f4630a163f..4848b8129e6c 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -863,3 +863,63 @@ int iio_write_channel_raw(struct iio_channel *chan, int val)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iio_write_channel_raw);
+
+unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
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
+static const struct iio_chan_spec_ext_info *iio_lookup_ext_info(
+						const struct iio_channel *chan,
+						const char *attr)
+{
+	const struct iio_chan_spec_ext_info *ext_info;
+
+	if (!chan->channel->ext_info)
+		return NULL;
+
+	for (ext_info = chan->channel->ext_info; ext_info->name; ++ext_info) {
+		if (!strcmp(attr, ext_info->name))
+			return ext_info;
+	}
+
+	return NULL;
+}
+
+ssize_t iio_read_channel_ext_info(struct iio_channel *chan,
+				  const char *attr, char *buf)
+{
+	const struct iio_chan_spec_ext_info *ext_info;
+
+	ext_info = iio_lookup_ext_info(chan, attr);
+	if (!ext_info)
+		return -EINVAL;
+
+	return ext_info->read(chan->indio_dev, ext_info->private,
+			      chan->channel, buf);
+}
+EXPORT_SYMBOL_GPL(iio_read_channel_ext_info);
+
+ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
+				   const char *buf, size_t len)
+{
+	const struct iio_chan_spec_ext_info *ext_info;
+
+	ext_info = iio_lookup_ext_info(chan, attr);
+	if (!ext_info)
+		return -EINVAL;
+
+	return ext_info->write(chan->indio_dev, ext_info->private,
+			       chan->channel, buf, len);
+}
+EXPORT_SYMBOL_GPL(iio_write_channel_ext_info);
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 47eeec3218b5..5e347a9805fd 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -312,4 +312,41 @@ int iio_read_channel_scale(struct iio_channel *chan, int *val,
 int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
 	int *processed, unsigned int scale);
 
+/**
+ * iio_get_channel_ext_info_count() - get number of ext_info attributes
+ *				      connected to the channel.
+ * @chan:		The channel being queried
+ *
+ * Returns the number of ext_info attributes
+ */
+unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan);
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
