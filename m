Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6383CF67F;
	Sun, 17 May 2026 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043096; cv=none; b=ZHP1dZ5uhU7b0a9NYs7oojbewHQ2M4ZwfOqKIgRwiZMkR3MuzUwMJhZ0YCbiqgSaNXqNL0idTWWZpnk2V0oWYZL93vWMjAJW4rPAoBrWfxqh3cRayowJmB0G6pNLHNohQzavXXcfcnETdMxlBbNAwcmJ8uuOPfqVk5tR8gIRDgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043096; c=relaxed/simple;
	bh=uSGL8dMbIPWbCHilTKkbyu1O1HC9fYsQy2nXzCbqsRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uFwmczMj1/uRpGjqlxRFqT3BRD/7kGITVPAmhlNI0T01aq7yV0lt1joEtsD7mpmGCmi9mALtPenvFv+/mLO+OzM4MgQihtijOi0MERQbjpweFr+bbDe5TYmpdrl549RPUUoqzIIBFqDa6YgomOMYm2vAaToTqUR+N+ss/1XeCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln83ZWhJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln83ZWhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F8A9C2BCFD;
	Sun, 17 May 2026 18:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779043096;
	bh=uSGL8dMbIPWbCHilTKkbyu1O1HC9fYsQy2nXzCbqsRA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ln83ZWhJtVD82v89MPR1kcP+HU1Yv5SG1jkVdwfKXiZ6Xd6dCYwxQ3mBTcaTeC94h
	 T6Rqp6i9NFgX5DCXWkSKT9CC9G1fZ4gR8ZLRdxkZewpV+3V+acg6TjAv+2i8UyQjJh
	 s8AU+GCTcVHDvWLtJiRs1I33UcJU8ScdNIp3DoE9eBOPf5KQn8Ov58yD0KDLf5rAj1
	 D34qU3bD/lRgcyx39nwUcHOD0ob7Stdclw5Nhg6KvIVZ8V0JNIy8mFaqDgFN1rel+6
	 IouTzxK9l9Hots5+RxWslfiyZgrY/VyEZMUdiN7XCuk1Ojkc7029KN2mPol8nrRgaG
	 UExtKmbF/lSIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EFACD4F3D;
	Sun, 17 May 2026 18:38:16 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 17 May 2026 19:37:47 +0100
Subject: [PATCH v5 03/13] iio: core: add hierarchical channel relationships
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-ad9910-iio-driver-v5-3-31599c88314a@analog.com>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
In-Reply-To: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779043094; l=3380;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=A7fhI4etUphuvUOLbYT+tvvvSQiaXddEibbLDuTWMKQ=;
 b=O166oJxTAzSETzOt/aK2ziw8mQeBeTOK5BgBoxWQh9PTsv+5c8xmim0lhMPYWXWmqwJ3rwPtr
 R2rn8X3X8VmDxfHjtsa4meQ9o7lZHkZGYcPqwyIIh6w4TSiSHScY2vg
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add parent-child relationship between iio channels by creating a parent
pointer field in iio_chan_spec struct and exposing a sysfs attribute that
returns the parent channel label.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-core.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |  5 +++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 5c8404efd0a5..348ac7a59738 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -776,6 +776,14 @@ static ssize_t iio_read_channel_label(struct device *dev,
 					 to_iio_dev_attr(attr)->c, buf);
 }
 
+static ssize_t iio_read_channel_parent(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	return do_iio_read_channel_label(dev_to_iio_dev(dev),
+					 to_iio_dev_attr(attr)->c->parent, buf);
+}
+
 static ssize_t iio_read_channel_info(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -1263,6 +1271,31 @@ static int iio_device_add_channel_label(struct iio_dev *indio_dev,
 	return 1;
 }
 
+static int iio_device_add_channel_parent(struct iio_dev *indio_dev,
+					 struct iio_chan_spec const *chan)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	int ret;
+
+	if (!chan->parent || (!indio_dev->info->read_label &&
+			      !chan->parent->extend_name))
+		return 0;
+
+	ret = __iio_add_chan_devattr("parent",
+				     chan,
+				     &iio_read_channel_parent,
+				     NULL,
+				     0,
+				     IIO_SEPARATE,
+				     &indio_dev->dev,
+				     NULL,
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
@@ -1401,6 +1434,11 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 		return ret;
 	attrcount += ret;
 
+	ret = iio_device_add_channel_parent(indio_dev, chan);
+	if (ret < 0)
+		return ret;
+	attrcount += ret;
+
 	if (chan->ext_info) {
 		unsigned int i = 0;
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 86d17ee69e05..09a97518e4bd 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -258,6 +258,10 @@ struct iio_scan_type {
  *			by all channels.
  * @info_mask_shared_by_all_available: What availability information is to be
  *			exported that is shared by all channels.
+ * @parent:		Optional pointer to the parent channel spec for
+ *			hierarchical channel relationships. When set, a read-only
+ *			"parent" sysfs attribute is created containing the
+ *			parent channel's label.
  * @event_spec:		Array of events which should be registered for this
  *			channel.
  * @num_event_specs:	Size of the event_spec array.
@@ -306,6 +310,7 @@ struct iio_chan_spec {
 	unsigned long			info_mask_shared_by_dir_available;
 	unsigned long			info_mask_shared_by_all;
 	unsigned long			info_mask_shared_by_all_available;
+	const struct iio_chan_spec *parent;
 	const struct iio_event_spec *event_spec;
 	unsigned int		num_event_specs;
 	const struct iio_chan_spec_ext_info *ext_info;

-- 
2.43.0


