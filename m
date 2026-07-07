Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD94396B98;
	Tue,  7 Jul 2026 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433068; cv=none; b=F9JmGx697WVZSqKEn3mgkFMoD+D1JuOO2ZnQE13vVAm1FA1FME98wDub9MGl8juHt/ivvYv+2JziGwlGTzYOCumF25NOIKLbFCxKx2vJB/qpS7FgM7dQK4Z+RB86yLaPuvYqW2t7TR+keH1F2ypJYIubfWLtbs4B6pQ0B5gLVEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433068; c=relaxed/simple;
	bh=0g0a4oQTywb6pFKTjDfQyRGVrlz5LWlh+N7mqoiez5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WVZtnjry79yvBpRD/DxfMCpvDQT+nvU0vqO+6Hxt8GrvqAvl+JWm88hc3VkTb+WXvVmCSf2G3HvHDkk1Mc4neiOO/RdNv5J62ZZc2NYmDj7vFgeD6Hu5IBYBfPSepiY0lD754kGZgQK062gkNkdfC6K+hGGcLkUcH9zvnY/+GgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuqvIjEB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuqvIjEB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E73AEC4AF48;
	Tue,  7 Jul 2026 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783433068;
	bh=0g0a4oQTywb6pFKTjDfQyRGVrlz5LWlh+N7mqoiez5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BuqvIjEBOXAPQav5desL7DW12Lpzn7YZ05PSVIh05J9CX98AG6kIVLTRsm3tFQPBK
	 rPrZrdCfdc8GqrHDfC1dBwG/kODVrvoUUIm3vEz5k7zWBB2NYrKeN+Q8Y5EdfRkymj
	 K3RzVP94uvSDA5geIZOUlXOqaz4e6zv7Lffu5uQf/33QNC4sxbEGvyBzKoqjF9307L
	 5DE6stAhwK4HNuzKnwLdYhwXEUYDFiq57CHLU4KdaQA3SyuXCsBWKev0p8tyTs/UD6
	 b96XWNYzuv9RfPQgsqvphhy5F2qUIZtTNvnQacM0Rs8DIl+ogDD3UDp2hY7cec+LvL
	 KvApfPv44A0aQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D19C44502;
	Tue,  7 Jul 2026 14:04:27 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 07 Jul 2026 15:04:29 +0100
Subject: [PATCH v7 08/17] iio: core: add hierarchical channel relationships
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-ad9910-iio-driver-v7-8-a4ec30f63700@analog.com>
References: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
In-Reply-To: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783433065; l=3404;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=FIoUcGo06SAFyypreQoQ6SpLK6ZouvA9PpUnxHlFbGo=;
 b=3CN6Op2JybeyQgMbSBtVrEzH4FXkHl90Kt+BAUNiFfocxJSZSdpwnrEDNQwKFT33t/+IDtt7B
 88mBKSYNJmHAVy5OhC9yDFrgPRM/gF8teLSDMTdyrxQIfKP0lf+crVJ
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add parent-child relationship between iio channels by creating a parent
pointer field in iio_chan_spec struct and exposing a sysfs attribute that
returns the parent channel prefix.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-core.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |  5 +++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 78a3c27d17a1..36a05fd77d47 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -848,6 +848,22 @@ static ssize_t iio_read_channel_label(struct device *dev,
 					 to_iio_dev_attr(attr)->c, buf);
 }
 
+static ssize_t iio_read_channel_parent(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	const struct iio_chan_spec *chan = to_iio_dev_attr(attr)->c->parent;
+	ssize_t len;
+
+	len = __iio_chan_prefix_emit(dev, chan, IIO_SEPARATE, buf, PAGE_SIZE);
+	if (len < 0)
+		return len;
+
+	buf[len] = '\n';
+
+	return len + 1;
+}
+
 static ssize_t iio_read_channel_info(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -1261,6 +1277,25 @@ static int iio_device_add_channel_label(struct iio_dev *indio_dev,
 	return 1;
 }
 
+static int iio_device_add_channel_parent_attr(struct iio_dev *indio_dev,
+					      struct iio_chan_spec const *chan)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	int ret;
+
+	if (!chan->parent)
+		return 0;
+
+	ret = __iio_add_chan_devattr("parent", chan,
+				     &iio_read_channel_parent, NULL,
+				     0, IIO_SEPARATE, &indio_dev->dev, NULL,
+				     &iio_dev_opaque->channel_attr_list);
+	if (ret < 0)
+		return ret;
+
+	return 1;
+}
+
 static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
 					 struct iio_chan_spec const *chan,
 					 enum iio_shared_by shared_by,
@@ -1399,6 +1434,11 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 		return ret;
 	attrcount += ret;
 
+	ret = iio_device_add_channel_parent_attr(indio_dev, chan);
+	if (ret < 0)
+		return ret;
+	attrcount += ret;
+
 	if (chan->ext_info) {
 		unsigned int i = 0;
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index cd17703274a6..0f006b8ad555 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -264,6 +264,10 @@ struct iio_scan_type {
  * @ext_info:		Array of extended info attributes for this channel.
  *			The array is NULL terminated, the last element should
  *			have its name field set to NULL.
+ * @parent:		Optional pointer to the parent channel spec for
+ *			hierarchical channel relationships. When set, a read-only
+ *			"parent" sysfs attribute is created containing the
+ *			parent channel's sysfs name prefix (e.g. "in_voltage0").
  * @extend_name:	Allows labeling of channel attributes with an
  *			informative name. Note this has no effect codes etc,
  *			unlike modifiers.
@@ -309,6 +313,7 @@ struct iio_chan_spec {
 	const struct iio_event_spec *event_spec;
 	unsigned int		num_event_specs;
 	const struct iio_chan_spec_ext_info *ext_info;
+	const struct iio_chan_spec *parent;
 	const char		*extend_name;
 	const char		*datasheet_name;
 	unsigned int		modified:1;

-- 
2.43.0


