Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-he1eur01on0135.outbound.protection.outlook.com ([104.47.0.135]:45334
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751320AbcKRGTS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Nov 2016 01:19:18 -0500
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [RFC PATCH v2 3/7] iio: inkern: api for manipulating ext_info of iio channels
Date: Thu, 17 Nov 2016 22:48:05 +0100
Message-ID: <1479419289-17553-4-git-send-email-peda@axentia.se>
In-Reply-To: <1479419289-17553-1-git-send-email-peda@axentia.se>
References: <1479419289-17553-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Extend the inkern api with functions for reading and writing ext_info
of iio channels.
---
 drivers/iio/inkern.c         | 55 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iio/consumer.h |  6 +++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index cfca17ba2535..a8099b164222 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -850,3 +850,58 @@ int iio_write_channel_raw(struct iio_channel *chan, int val)
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
index 9a4f336d8b4a..471dece8729a 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -299,4 +299,10 @@ int iio_read_channel_scale(struct iio_channel *chan, int *val,
 int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
 	int *processed, unsigned int scale);
 
+int iio_get_channel_ext_info_count(struct iio_channel *chan);
+ssize_t iio_read_channel_ext_info(struct iio_channel *chan,
+				  const char *attr, char *buf);
+ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
+				   const char *buf, size_t len);
+
 #endif
-- 
2.1.4

