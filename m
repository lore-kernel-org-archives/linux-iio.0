Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7712E3515FC;
	Wed, 22 Jul 2026 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735458; cv=none; b=gn66PqwhMh7h42aeMUPF1Ci7mDKvKloEAG2Qak4Y1KiX9efDUBcr3JFcFOCeQ3nxkV7I30nCEwjJSfgKlngMzI7U4tJDtsWIa+pOYYccAlbotvpTMe8BRitiT+qEY9Gla2BUYqKWgEtoAY+ArbrcOF9FXOIrvf6T4OoxcwEQrL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735458; c=relaxed/simple;
	bh=Pf0sgnB2zRgSmd8CaEG1hcLLHpnKDmh2Do5uEum+5Zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OTDMFUlavmMAySVXDRaadEhiwPrUy4OWxgFP3KLXT5SmvJ71m2mEadOUOlGcLoaB/W3g/h1IXn6Lts0zZQjGnJe9m/hoB0QHSCMwge4aNuji6OHKsFOLIJUObbmBXH+YqE4msyD5ZSap2h1mzyg+dOAsCTifwEsJVNC69uqiF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGLYeJvi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGLYeJvi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39228C4AF0F;
	Wed, 22 Jul 2026 15:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784735458;
	bh=Pf0sgnB2zRgSmd8CaEG1hcLLHpnKDmh2Do5uEum+5Zg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MGLYeJviBN6H6t9vu3P9LT6e3fuXTGC2hiS81vmys2xSrybR9AqQHmT02m0ZLSL/h
	 Nh0arHlsAB0LIUKukxRoFG2M+c9uYPhtezbvogWUypbZvTNJNhNKbwsmRpB5b/4MkJ
	 yFwJmn6NexmlKcO70As3sSzQfar2fABY7XNDTrdz7xTDzuZDDjw/JhPIaUpiOGfVeE
	 S8I8RGzNg1+twwpSHdXOKc3nfijUKqdEaOb6mslazCphwqVimTn7Bb8GU8qmSF/hRt
	 h2feLppZSm3Z3/FT1UZSurEyRYcyFetKy66szczmqmE8MTV8DRfJQp6ffdo1db77m5
	 ds+Z/Bp03Gpxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242AEC4453E;
	Wed, 22 Jul 2026 15:50:58 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Jul 2026 16:50:17 +0100
Subject: [PATCH v9 08/17] iio: core: add hierarchical channel relationships
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-ad9910-iio-driver-v9-8-459d1df5ac56@analog.com>
References: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
In-Reply-To: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784735456; l=3402;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=njI4C72Gs2/a1BSXycY8GevO618GmzzAWx+9MSybKW8=;
 b=WYp/6SYNpCU1qgW2E8EkvCT7BGOOgp0k52+CapOMorpLFL0sdvWcsQLWSPkaXaQNNhr/iCUWx
 g9ncui9Gj1TDuAZ9f5qSNC1Ym/k0LNyp7WUqCEPoFhfuW7yMTF4FW7G
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
index aa9d6474edd9..f7e3048354b9 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -856,6 +856,22 @@ static ssize_t iio_read_channel_label(struct device *dev,
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
+	buf[len++] = '\n';
+
+	return len;
+}
+
 static ssize_t iio_read_channel_info(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -1269,6 +1285,25 @@ static int iio_device_add_channel_label(struct iio_dev *indio_dev,
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
@@ -1407,6 +1442,11 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
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


