Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0136.outbound.protection.outlook.com ([104.47.2.136]:64100
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S938515AbcKPXtJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Nov 2016 18:49:09 -0500
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [RFC PATCH 3/7] iio: inkern: api for manipulating ext_info of iio channels
Date: Thu, 17 Nov 2016 00:48:27 +0100
Message-ID: <1479340111-1259-4-git-send-email-peda@axentia.se>
In-Reply-To: <1479340111-1259-1-git-send-email-peda@axentia.se>
References: <1479340111-1259-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Extend the inkern api with functions for reading and writing ext_info
of iio channels.
---
 drivers/iio/inkern.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/iio/consumer.h |  5 +++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index cfca17ba2535..5348735281ee 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -850,3 +850,43 @@ int iio_write_channel_raw(struct iio_channel *chan, int val)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iio_write_channel_raw);
+
+int iio_read_channel_ext_info(struct iio_channel *chan,
+			      const char *attr, char *buf)
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
+int iio_write_channel_ext_info(struct iio_channel *chan,
+			       const char *attr, const char *buf, size_t len)
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
index 9a4f336d8b4a..3859981cea0a 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -299,4 +299,9 @@ int iio_read_channel_scale(struct iio_channel *chan, int *val,
 int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
 	int *processed, unsigned int scale);
 
+int iio_read_channel_ext_info(struct iio_channel *chan,
+			      const char *attr, char *buf);
+int iio_write_channel_ext_info(struct iio_channel *chan,
+			       const char *attr, const char *buf, size_t len);
+
 #endif
-- 
2.1.4

