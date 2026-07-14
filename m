Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A9937F8B3;
	Tue, 14 Jul 2026 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026974; cv=none; b=kRN/8sm2nu1+o4r/NrN8fFiWEtWiJRgqmk72oid6ki46+1MG3uxML1N47b1dpenH4d3sPpyhxGJ3PQVB4uZIq1Y5LrHDrCLTDulGh9Plri4p/Nltu41bYMm7gyuPf39cwPGl+mUUGh8rFUCBP83kVdFiAPRWb/x7ac/qGz96DX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026974; c=relaxed/simple;
	bh=hCIe40KJp0DVG0loqRy/4JNLZyr3rW4LLxYL/bwapJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IAjumK4tq1M0hc3ThgAT7PuntVJZmjHNaOliIMgCaskq9bMi6Ic8GiIm7Zmbt2Uy99IDCkrkPsgB7UCnGvx2f4ZfuERQ6hCnLqkOryrdKX8ES9JuzMDD8i9KMQcMKZB1EGtlI2L1oIf/WPREZjkd2Sak1E24rLt0eeGQfSqNMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIVFp9xR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIVFp9xR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DB5BC2BD01;
	Tue, 14 Jul 2026 11:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784026973;
	bh=hCIe40KJp0DVG0loqRy/4JNLZyr3rW4LLxYL/bwapJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tIVFp9xRUjz24rtjBVFkBemL9XVikjWD0kNEayYQ/Neml4i4Bxerml1p+YflEvpKo
	 +lrQCOIbPsM1O5d5tDrSNtnokFdB6aVWWPj8vzJAQ201r4wWmhja6YAgG5DDGghX8p
	 exTc6gEdXjA/JD80dA4qow93pidVSJOmKv6DoZXSBsk24W5llHaXDqUv2OzwDY9UVc
	 6nXnqGzOSoazIU6UyfpeYekoay32DRCE5rurq0fgtQIsbHva3QuKR9OID2K1M7q6cv
	 sdCel+1iZZSLnDLVJGtSRFqq+/vivnv/stqa2T+zDUzgnuQkuCvC1KDK61cr+DZc/3
	 xDBCRvti5AbCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07525C44501;
	Tue, 14 Jul 2026 11:02:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 14 Jul 2026 12:02:48 +0100
Subject: [PATCH v8 08/17] iio: core: add hierarchical channel relationships
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-ad9910-iio-driver-v8-8-36939c3c07d2@analog.com>
References: <20260714-ad9910-iio-driver-v8-0-36939c3c07d2@analog.com>
In-Reply-To: <20260714-ad9910-iio-driver-v8-0-36939c3c07d2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784026971; l=3402;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=x2FDIaEA9EK129rBESxX3qw+hnanTxkIq1mgZqUl04g=;
 b=t5cyglnEOhY1/cCW2Jfa7WgdzDm43mqBGThJJtysyulDgVUDzutnKIFphWvjH/NMcSIDvfy8/
 67r+w5N1BpQC0tVRT+CyqwanDSUjD6v2OeGfPI7N2QjilJmvaU0VNGp
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
index 3909255212f5..5e28b50f143d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -846,6 +846,22 @@ static ssize_t iio_read_channel_label(struct device *dev,
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
@@ -1259,6 +1275,25 @@ static int iio_device_add_channel_label(struct iio_dev *indio_dev,
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
@@ -1397,6 +1432,11 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
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


