Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795197891;
	b=tu5cV2Z6n6U6lBByCU1p3hhWSS+SrVA9+zFoAJKjUDLZP01o0BWOJH4s4z2ZJK/6DKNN
	 lAPoqCwtC00JPuoqZd2m+NHu7+XICEcTeCFUMtCNjyHLY3yInouISWj01n60osLRPr1Dp
	 lkkQX3EYQX+vCA722zPa9B4KqQ6IlStB2rBTQt54R7+6v4u1QoepI4T5+gY/s4/6bizLA
	 g4JyHL22MXzm3k7+mHJWHPbTvaEiFISOpSErl8tELK8xIcZ1MSB/70VxGOnrbRS94sgvl
	 McY6W/BxzLyGIRs1LVe43J+FVgyLGQfRlLQXQwQ/IWcAQPpvJ2gE8r03uvGSk4C5K/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197891;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=t3mPvJqSE7LXHOFUTmX0cyml/DTyX3mUI2pndg6S5bQ=;
	b=fnwFOt9oKM1SYuAk9yuq2qawPqrJAnvQiBENh9Wa0ai9noLSq8/NWmYOQ9DP7FLPvsum
	 HMjaF1xUsT20ZbJ+8JkthvNb8iK7pQalV2kgxb+neC4QK+Nzd1kmeNb7TFOod/V6Vi0wJ
	 9mSeGJFz3lZUxcXeyqdYTVn6xZyxmkUyiNnfzL/+Avw6HM8dn1eYI14B8OHBmveFO6FhY
	 hV75RHjf6+aL1CfrEnQA7XeXvr3OZMY2WK0RxK2nYWBwMYwfMokIdxPSc+9NiuHXf3qsc
	 LIGpVLrS5+v8Gnv4fovrpUZIFlbVNIfNJBlZTARvMfBXwy/LQsTrVmsvCL+bF4JobVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZj2ZWKR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A32A60A262A;
	Fri, 20 Nov 2026 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZj2ZWKR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795197890;
	b=ndmE2qCRCKwPSu3UttamI87tKFt345nZKS0AbKLAAgGaqLkfakyeqzM1bzCLHsGiSR3C
	 DJlmj+MJGAe1+jOfJpgvCquy6NEKEkgVrfa1H3NC+nGpGrmvbFPaaBmY3zlPbJ+t5KT/d
	 D3n71uG/hMSlfYIaMhaObeBlE+mIMgSlSDDpl2oob5szU8yodij5N49JuQQTyQV3ZyROk
	 FE810aPQbBdOaA4Mh2xrixD+RY/2t3A4w4kOp3aqYJMNTsb4zbx3JNGjzLmoQgtDGcSGN
	 gDvSs4hxfsVKO9B7NxHzxAuyOSbx8YykyYsUHJ4VxKP6wSoEYkeERJ/eAAWZ+mYi6aQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795197890;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=t3mPvJqSE7LXHOFUTmX0cyml/DTyX3mUI2pndg6S5bQ=;
	b=ZvWZ/FPYwtCVuFtqSW41lY6kgK/OMGNZZj6/Xj8X3IMD9sTXFitKN1zmd1E6OX60HkMp
	 6956vveI4mOcZiBnjZvnkAUVk9V0DvKr6E4EFU2eLfeWd79/jHgHhYysGYn1zbdINNb04
	 I+UYHvtB2K8UvfalMifpQnBF0TzCM5VMnpdMcruZgjGL3TEo3Zkql9wTXcK4MyUPp3ERC
	 tZ13yD/kSg8p4uVmp0PS96mf/BEH1zNnSf01fqKOvYwrQLDgrK4WMss8dXfH+GCw3YhS1
	 HylBD0DRIrqVDBXOOojvfJaOiO1Lk5VP59iAVEI+A3CGLnp6UK7vpJcdKxtA+XMOeMQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EC5661F000C4;
	Fri, 20 Nov 2026 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795197890;
	bh=t3mPvJqSE7LXHOFUTmX0cyml/DTyX3mUI2pndg6S5bQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hZj2ZWKRnP+j3Pj5GsdnHTn0tqj26x2r/jPRnkAFzsOrB1b6TL82tvMhfwkyIl2cS
	 yOPzbW6s4c5HFlSstW53tPo82GCdl4hH+aClD0q/PB7FjbsuW4HMJj+XKEScywtdwH
	 87hVGXE54k1Nl8GjwxjcJuaQzIbXos4S0aj/HUOb6iGGNjfdmY9QdYY484WRfVQTUX
	 n1XsjVOJFf0mAtSITmXuAPHLFyg/BTz//Ep10D5QHnqZHcrApmuIKfe1JzWDaIN07N
	 gT4VyNof8k7XbSWXZj6dVadTR7C5lWdUYhVl0lbnidIbqpdtV0PpIb/Ntt45QYF2ac
	 emFQlfiOnkY2g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7ED5B4B8B9;
	Fri, 20 Nov 2026 18:04:43 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 20 Nov 2026 18:03:59 +0000
Subject: [PATCH RFC 3/5] iio: event: add struct iio_event_attr
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-iio-core-attr-review-v1-3-05b41f8133c2@analog.com>
References: <20261120-iio-core-attr-review-v1-0-05b41f8133c2@analog.com>
In-Reply-To: <20261120-iio-core-attr-review-v1-0-05b41f8133c2@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795197883; l=7028;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=NnM8uAIs95unllidYtNAMgDZ5VgVeGY7qa5DNOWWAJM=;
 b=woHvty774OY6NZO+n5Xd0CJ9A00D8NWV6mHfhrXkdYBm/9aVzm7OHCioxK5NvC7yVC8/i69Ft
 KFSZtObnsIxCWQTvFN0pdcQwSq0xl0sJ6tUTB85iGn7Z1HJeYUkHGMC
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Event attributes encode both the index of their struct iio_event_spec
and the event info into the attribute address, as
(info << 16) | spec_index, and look the event spec up through the
channel on every access.

Add struct iio_event_attr, extending struct iio_chan_attr with a pointer
to the event spec. The address now only holds the event info, and the
event type and direction are read directly from the spec.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-event.c | 63 +++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index e72b665cc79b..e6a404642417 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -258,19 +258,35 @@ static const char * const iio_ev_info_text[] = {
 	[IIO_EV_INFO_SCALE] = "scale",
 };
 
-static enum iio_event_direction iio_ev_attr_dir(struct iio_chan_attr *attr)
+/**
+ * struct iio_event_attr - IIO event attribute
+ * @chan_attr:	underlying IIO channel attribute, its address holds the
+ *		event info
+ * @spec:	event specification the attribute belongs to
+ */
+struct iio_event_attr {
+	struct iio_chan_attr chan_attr;
+	const struct iio_event_spec *spec;
+};
+
+static_assert(offsetof(struct iio_event_attr, chan_attr) == 0);
+
+#define to_iio_event_attr(_dev_attr)					\
+	container_of(to_iio_chan_attr(_dev_attr), struct iio_event_attr, chan_attr)
+
+static enum iio_event_direction iio_ev_attr_dir(struct iio_event_attr *attr)
 {
-	return attr->c->event_spec[attr->iio_attr.address & 0xffff].dir;
+	return attr->spec->dir;
 }
 
-static enum iio_event_type iio_ev_attr_type(struct iio_chan_attr *attr)
+static enum iio_event_type iio_ev_attr_type(struct iio_event_attr *attr)
 {
-	return attr->c->event_spec[attr->iio_attr.address & 0xffff].type;
+	return attr->spec->type;
 }
 
-static enum iio_event_info iio_ev_attr_info(struct iio_chan_attr *attr)
+static enum iio_event_info iio_ev_attr_info(struct iio_event_attr *attr)
 {
-	return (attr->iio_attr.address >> 16) & 0xffff;
+	return attr->chan_attr.iio_attr.address;
 }
 
 static ssize_t iio_ev_state_store(struct device *dev,
@@ -279,7 +295,7 @@ static ssize_t iio_ev_state_store(struct device *dev,
 				  size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_chan_attr *this_attr = to_iio_chan_attr(attr);
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
 	int ret;
 	bool val;
 
@@ -291,7 +307,7 @@ static ssize_t iio_ev_state_store(struct device *dev,
 		return -EINVAL;
 
 	ret = indio_dev->info->write_event_config(indio_dev,
-		this_attr->c, iio_ev_attr_type(this_attr),
+		this_attr->chan_attr.c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), val);
 
 	return (ret < 0) ? ret : len;
@@ -302,14 +318,14 @@ static ssize_t iio_ev_state_show(struct device *dev,
 				 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_chan_attr *this_attr = to_iio_chan_attr(attr);
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
 	int val;
 
 	if (!indio_dev->info->read_event_config)
 		return -EINVAL;
 
 	val = indio_dev->info->read_event_config(indio_dev,
-		this_attr->c, iio_ev_attr_type(this_attr),
+		this_attr->chan_attr.c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr));
 	if (val < 0)
 		return val;
@@ -322,7 +338,7 @@ static ssize_t iio_ev_value_show(struct device *dev,
 				 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_chan_attr *this_attr = to_iio_chan_attr(attr);
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
 	int val, val2, val_arr[2];
 	int ret;
 
@@ -330,7 +346,7 @@ static ssize_t iio_ev_value_show(struct device *dev,
 		return -EINVAL;
 
 	ret = indio_dev->info->read_event_value(indio_dev,
-		this_attr->c, iio_ev_attr_type(this_attr),
+		this_attr->chan_attr.c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
 		&val, &val2);
 	if (ret < 0)
@@ -346,7 +362,7 @@ static ssize_t iio_ev_value_store(struct device *dev,
 				  size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_chan_attr *this_attr = to_iio_chan_attr(attr);
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
 	int val, val2;
 	int ret;
 
@@ -357,7 +373,7 @@ static ssize_t iio_ev_value_store(struct device *dev,
 	if (ret)
 		return ret;
 	ret = indio_dev->info->write_event_value(indio_dev,
-		this_attr->c, iio_ev_attr_type(this_attr),
+		this_attr->chan_attr.c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
 		val, val2);
 	if (ret < 0)
@@ -371,11 +387,11 @@ static ssize_t iio_ev_label_show(struct device *dev,
 				 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_chan_attr *this_attr = to_iio_chan_attr(attr);
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
 
 	if (indio_dev->info->read_event_label)
 		return indio_dev->info->read_event_label(indio_dev,
-				 this_attr->c, iio_ev_attr_type(this_attr),
+				 this_attr->chan_attr.c, iio_ev_attr_type(this_attr),
 				 iio_ev_attr_dir(this_attr), buf);
 
 	return -EINVAL;
@@ -384,13 +400,14 @@ static ssize_t iio_ev_label_show(struct device *dev,
 static int iio_device_add_event_attr(struct iio_dev *indio_dev,
 				     const char *postfix,
 				     const struct iio_chan_spec *chan,
+				     unsigned int spec_index,
 				     iio_attr_show_t show,
 				     iio_attr_store_t store,
-				     u64 mask,
+				     enum iio_event_info info,
 				     enum iio_shared_by shared_by)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	struct iio_chan_attr *ev_attr;
+	struct iio_event_attr *ev_attr;
 	struct iio_chan_attr_ctx ctx;
 	int ret;
 
@@ -404,7 +421,8 @@ static int iio_device_add_event_attr(struct iio_dev *indio_dev,
 	if (!ev_attr)
 		return -ENOMEM;
 
-	ret = iio_chan_attr_add(&ctx, ev_attr, show, store, mask);
+	ev_attr->spec = &chan->event_spec[spec_index];
+	ret = iio_chan_attr_add(&ctx, &ev_attr->chan_attr, show, store, info);
 	if (ret)
 		kfree(ev_attr);
 
@@ -449,8 +467,7 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
 		}
 
 		ret = iio_device_add_event_attr(indio_dev, postfix, chan,
-						show, store,
-						(i << 16) | spec_index,
+						spec_index, show, store, i,
 						shared_by);
 		kfree(postfix);
 
@@ -488,8 +505,8 @@ static int iio_device_add_event_label(struct iio_dev *indio_dev,
 	if (postfix == NULL)
 		return -ENOMEM;
 
-	ret = iio_device_add_event_attr(indio_dev, postfix, chan,
-					&iio_ev_label_show, NULL, spec_index,
+	ret = iio_device_add_event_attr(indio_dev, postfix, chan, spec_index,
+					&iio_ev_label_show, NULL, 0,
 					IIO_SEPARATE);
 
 	kfree(postfix);

-- 
2.43.0


