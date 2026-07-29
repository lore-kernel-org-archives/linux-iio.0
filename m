Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9231C43E07D;
	Wed, 29 Jul 2026 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785313632; cv=none; b=uy+7fYWos+WNBb3QkIGhVSSJHTDVgLHbEED3X4Lf4f7UiHqEXVc4t+qXNlA5v8uwUmNn/ZnpgJtkdO7YcvrzTwefHhwPRhBDFdbSz5GibPrPHYx2fMpfVz3JC+5mhs2oB1/4EzzC7Ba7pyla3yd7wn1cUyvZdIuM0sXH66Zo3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785313632; c=relaxed/simple;
	bh=2e9Fq3vnYtN5nxI+1TZm5IPTilXrSlP6NXrSkfDXosw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E0YAgP+zT/3jMIqtlh6WOLZeQuHWDlADQ+dgHN9I7V6jLnWqTE+ZMQiUaThCAUVilXOOQtLOmYbzvq8fXX9Z29Qq4UkCpL13WYxzYENBqegvfOVdfck4AmFn19UIvT8YdENWOz+cUvVzQ+XB3nXcwAORH+ZnHIAg4N+6KeOu6UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPNPp97X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPNPp97X"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A427C4AF10;
	Wed, 29 Jul 2026 08:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785313629;
	bh=2e9Fq3vnYtN5nxI+1TZm5IPTilXrSlP6NXrSkfDXosw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TPNPp97XNekr9tXnd/J7FsF9DrG/llS1pDX83/P74LASDPB3U6hhNpK+HQXVPJ56Y
	 jRmcaWkMzNhflZzJz4satqLFOLsZce2I30wGDz8tqMB0YJdfKcuSR+1inXjKwjMcV0
	 36/zxscOlFMS0+EwL8yIaNPnHW/GXg0j11BCQYEaAM3YLV0e7QueZSnvEp/h/JHiDY
	 hGUx4w2lWkIdEIzS54EZLbCBzJtnWsRGi3+E6dfY1/DzRY8ewuGSVyZZiBU9tD750F
	 YE0nV+Q9m4kzzImsXIXHZyrsS+pyMyrN8345+gcZqRWzJ90SzC1J7M5ghy1lA63U9B
	 J6XtvLyEZUXpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1746CC53200;
	Wed, 29 Jul 2026 08:27:09 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 29 Jul 2026 09:25:35 +0100
Subject: [PATCH v10 08/17] iio: core: add hierarchical channel
 relationships
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-ad9910-iio-driver-v10-8-aa1f6167729e@analog.com>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
In-Reply-To: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785313627; l=3411;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=5ZzIW7BwmQd5Kfh+FyVpgmpwgXoh15JQvTTrszWario=;
 b=BZ5IJNGDrubFhlxqwBlD6V/EpHKk18c0xlrlEPSLcE3kHqkrUX7kyw5KaK5W9JMu+KzQKy+2R
 HhiOhXZElnwD4Q0tSTmhdyK8IOy6V8x0GCWPaJcaaHlfMwdU/0jZYmz
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
 drivers/iio/industrialio-core.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |  5 +++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index aa9d6474edd9..36f072ccba27 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -856,6 +856,20 @@ static ssize_t iio_read_channel_label(struct device *dev,
 					 to_iio_dev_attr(attr)->c, buf);
 }
 
+static ssize_t iio_read_channel_parent(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	const struct iio_chan_spec *chan = to_iio_dev_attr(attr)->c->parent;
+	ssize_t len;
+
+	len = __iio_chan_prefix_emit(dev, chan, IIO_SEPARATE, buf, PAGE_SIZE - 1);
+	if (len < 0)
+		return len;
+
+	return len + sysfs_emit_at(buf, len, "\n");
+}
+
 static ssize_t iio_read_channel_info(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -1269,6 +1283,25 @@ static int iio_device_add_channel_label(struct iio_dev *indio_dev,
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
@@ -1407,6 +1440,11 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
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


