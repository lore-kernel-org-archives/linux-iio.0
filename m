Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795772899;
	b=ny9Gp/X4uamUXE6BMnwDOZKD6JGq3R14ER12oS4RT8ekVeF7XsP0JrXNJz91udxM/LtN
	 whWvrk2BbfcsCOBFQ0F+8WT3bJFEIm0DDwGqwtrPu42xmVsSgGLEk6myGlLAOFZvQdPHG
	 onhPu1EjPvP9NwA1ZiCqvICm1dGu3WhdtMaSyctCBeCshE945E8wnu6uYdkFlLm2orgqM
	 5w7iKawMAJH9dIfW16K03HbozwKEdftLzRurPxo+UDbJBjZKeBf89cSdVOGsIjotFzvzx
	 PrPqBAAMtf08TDDkkbti4nPQ04XY4meZu3cbDNebomcr0jbp5gSIK5vAD4Jze7vZMyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772899;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XGHos7X/MvtmgH1X07rmX0KK3H+HrVT4JHuQJ+EOt7c=;
	b=dTeP2IrZsIDERaNEhXCbahzs4Sr6dfGaAm1uC0I0YwjrPcK+61T3xmeq/PKJ8mbZTwUS
	 Sp5bww6AuEmWeHv5tXMX+PfoWn6/vHv5L6Xik3B4Thm0lClB8SZw8HO4R7LyeYi5maSHq
	 LWAnbho1DI8FMRw2+H5MEfdpN1UN9YiKzsVnG/fUMAVd0UETPKoHOn9lXWIZk4ycvfh6/
	 hlbVW+oRU5bType//5sMTw6zS3HKsC+HubSP7GuqRrN+kipn0vnCNxmYNAiEBBvOglZBr
	 CfK8ulAIpeLLCRnQ47JpK/SP6imJ7/m+zMECHTZeJ67gn0/d0c9jf6yvAni4E/pgRvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EVbYGTrV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E58606A335;
	Fri, 27 Nov 2026 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EVbYGTrV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795772898;
	b=J8zcH+EtUe2Hcws58Yd/g7mB4wq/IaixQTWNhiRjKwrj3wPU1NWE5ssakbZXGQKsZrWq
	 UyRz07urDt3Yymd7lL9hCNS5iiH69xdhKZS1Io37coTVXAE38BmBdbLftLoaye0ZPtJoO
	 yy6jJ1SX5o7cLalG7a/JY5829Mj3Mr6V9FgdZCyZXzxF8zw+/UX9zHiZx8OIkvpVkOROP
	 UmOZ1mJYMIr6DMxCX83mGHsOlstKfnyasiCItA1lCY217YU4rTki7ReLR2minTK6jwoJY
	 eiwH7BizubJiqVNhqpUsi0rm+eCiZ4H1osSFhNwhj9YI6dLyO6qgRBmeVxorhcbnZuA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795772898;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XGHos7X/MvtmgH1X07rmX0KK3H+HrVT4JHuQJ+EOt7c=;
	b=dfqiRG6m2Yd8E3Ckhj2+mVuxXjfyjnRKkGj6t+ObEk9NKQuvbYR0zL4N19SOLY8Erg+8
	 OJEUCNWf/EUN3CsvaOiscx1MljcPCnleK1M2Kp5WWU3awd4eg7KJxGy/80Tfsn3ZXub+E
	 eku8xab8bgZF/PRVQIRlVSk9rhv0vCNf9IUQCCna6zWcGUZFP8f2++hGqu2gqXxcVqb69
	 WNkd1/3RSYtZH8WkJ3m+lHKOkymjtkeJEDOpTHj322ofjkbPdIb2jd6wgfRDg6oTYRgXZ
	 8SigOT7gjbA7MpIdvWyT3vtO0kyDblhfUndQV7tXOsMDBkQI/F5DNruxUN/WyAHD+Dg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E54901F00897;
	Fri, 27 Nov 2026 09:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795772898;
	bh=XGHos7X/MvtmgH1X07rmX0KK3H+HrVT4JHuQJ+EOt7c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EVbYGTrV0wRDoFLr1QunINcWpySuvKXEP27lluRIaBBaQSFCCArlIYltSVXHXpqb3
	 dRIyhtRW8sf49VQKKUUpqrrW/Mb0RgrotWZt8eQtDMhig0Qwc0ruMSIfJIgFP6k6oe
	 83mazMnkSmRbTvei8hudDYv1Mc/AQvPFhjdwP1K3spZsg6motrkrWfPGc0Yx2fmbB+
	 73IeJ5MzsgQFcLumnIpjcELlPJu0JY4HRW3KZAdxaa+Wp4hlIwU+EelcdDWsG57c5D
	 H3OPKJKi8TokAG2PzB7ORDriPA0zxN5BwDI2KezG1aDdkMwusHMhrA4XDdCvuEKyoB
	 BToiDm0yJazdA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D45274B6D5;
	Fri, 27 Nov 2026 09:47:56 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 27 Nov 2026 09:47:48 +0000
Subject: [PATCH v2 5/5] iio: buffer: add struct iio_buffer_attr
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
Message-Id: <20261127-iio-core-attr-review-v2-5-e0aed1e8a81c@analog.com>
References: <20261127-iio-core-attr-review-v2-0-e0aed1e8a81c@analog.com>
In-Reply-To: <20261127-iio-core-attr-review-v2-0-e0aed1e8a81c@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795772875; l=9239;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=AjefUpsQT2H2WqYhIME2iAOH/52Q2zSYZTt5ZE8OoKs=;
 b=QcR3EFN05p3M4mUwwtEWLUxtnqyvqVr7NhREt0RrcpoMjO2TPU5flGuZmN3BCjEvM3fgeRcMd
 8BFG2VteZM/Am+1R7AAasuRLlqsL0B8k1OuiUjwLsW4vO7kE+K61g5D
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Buffer attributes find their buffer through the buffer field of
struct iio_dev_attr, which is unused by every other attribute.

Add struct iio_buffer_attr, extending struct iio_chan_attr with the
buffer the attribute belongs to, and use it both for the scan element
attributes and for the buffer attributes wrapped by the buffer core.
iio_attr_to_buffer() now resolves the buffer through it.

The buffer pointer was the last core-only field of struct iio_dev_attr,
so remove it. On 64-bit, without lockdep, struct iio_dev_attr is now 40
bytes instead of 72, which every attribute declared through
IIO_DEVICE_ATTR*() and friends benefits from.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-buffer.c | 57 +++++++++++++++++++++++++--------------
 include/linux/iio/sysfs.h         |  4 ---
 2 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 52025d60052b..16629344410e 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -69,6 +69,22 @@ static const char * const iio_endian_prefix[] = {
 	[IIO_LE] = "le",
 };
 
+/**
+ * struct iio_buffer_attr - IIO buffer attribute
+ * @chan_attr:	underlying IIO channel attribute (channel is NULL for buffer
+ *		wide attributes)
+ * @buffer:	the IIO buffer to which this attribute belongs to
+ */
+struct iio_buffer_attr {
+	struct iio_chan_attr chan_attr;
+	struct iio_buffer *buffer;
+};
+
+static_assert(offsetof(struct iio_buffer_attr, chan_attr) == 0);
+
+#define to_iio_buffer_attr(_dev_attr)					\
+	container_of(to_iio_chan_attr(_dev_attr), struct iio_buffer_attr, chan_attr)
+
 /**
  * iio_attr_to_buffer() - Get the IIO buffer a buffer attribute belongs to
  * @attr: Device attribute of the buffer, as passed to its show/store callbacks
@@ -80,7 +96,7 @@ static const char * const iio_endian_prefix[] = {
  */
 struct iio_buffer *iio_attr_to_buffer(struct device_attribute *attr)
 {
-	return to_iio_dev_attr(attr)->buffer;
+	return to_iio_buffer_attr(attr)->buffer;
 }
 EXPORT_SYMBOL_GPL(iio_attr_to_buffer);
 
@@ -459,7 +475,7 @@ static ssize_t iio_scan_el_show(struct device *dev,
 				char *buf)
 {
 	int ret;
-	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
+	struct iio_buffer *buffer = to_iio_buffer_attr(attr)->buffer;
 
 	/* Ensure ret is 0 or 1. */
 	ret = !!test_bit(to_iio_dev_attr(attr)->address,
@@ -591,7 +607,7 @@ static ssize_t iio_scan_el_store(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	struct iio_buffer *buffer = this_attr->buffer;
+	struct iio_buffer *buffer = to_iio_buffer_attr(attr)->buffer;
 
 	ret = kstrtobool(buf, &state);
 	if (ret < 0)
@@ -622,7 +638,7 @@ static ssize_t iio_scan_el_ts_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
+	struct iio_buffer *buffer = to_iio_buffer_attr(attr)->buffer;
 
 	return sysfs_emit(buf, "%d\n", buffer->scan_timestamp);
 }
@@ -635,7 +651,7 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
+	struct iio_buffer *buffer = to_iio_buffer_attr(attr)->buffer;
 	bool state;
 
 	ret = kstrtobool(buf, &state);
@@ -659,7 +675,7 @@ static int iio_buffer_add_chan_devattr(struct iio_dev *indio_dev,
 				       iio_attr_store_t writefunc,
 				       u64 mask)
 {
-	struct iio_chan_attr *buf_attr;
+	struct iio_buffer_attr *buf_attr;
 	struct iio_chan_attr_ctx ctx;
 	int ret;
 
@@ -672,8 +688,9 @@ static int iio_buffer_add_chan_devattr(struct iio_dev *indio_dev,
 	if (!buf_attr)
 		return -ENOMEM;
 
-	buf_attr->iio_attr.buffer = buffer;
-	ret = iio_chan_attr_add(&ctx, buf_attr, readfunc, writefunc, mask);
+	buf_attr->buffer = buffer;
+	ret = iio_chan_attr_add(&ctx, &buf_attr->chan_attr, readfunc, writefunc,
+				mask);
 	if (ret)
 		kfree(buf_attr);
 
@@ -716,7 +733,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
 static ssize_t length_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
-	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
+	struct iio_buffer *buffer = to_iio_buffer_attr(attr)->buffer;
 
 	return sysfs_emit(buf, "%d\n", buffer->length);
 }
@@ -726,7 +743,7 @@ static ssize_t length_store(struct device *dev, struct device_attribute *attr,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
+	struct iio_buffer *buffer = to_iio_buffer_attr(attr)->buffer;
 	unsigned int val;
 	int ret;
 
@@ -752,7 +769,7 @@ static ssize_t length_store(struct device *dev, struct device_attribute *attr,
 static ssize_t enable_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
-	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
+	struct iio_buffer *buffer = to_iio_buffer_attr(attr)->buffer;
 
 	return sysfs_emit(buf, "%d\n", iio_buffer_is_active(buffer));
 }
@@ -1412,7 +1429,7 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 	bool requested_state;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
+	struct iio_buffer *buffer = to_iio_buffer_attr(attr)->buffer;
 	bool inlist;
 
 	ret = kstrtobool(buf, &requested_state);
@@ -1440,7 +1457,7 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 static ssize_t watermark_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
-	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
+	struct iio_buffer *buffer = to_iio_buffer_attr(attr)->buffer;
 
 	return sysfs_emit(buf, "%u\n", buffer->watermark);
 }
@@ -1451,7 +1468,7 @@ static ssize_t watermark_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
+	struct iio_buffer *buffer = to_iio_buffer_attr(attr)->buffer;
 	unsigned int val;
 	int ret;
 
@@ -1477,7 +1494,7 @@ static ssize_t watermark_store(struct device *dev,
 static ssize_t data_available_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
+	struct iio_buffer *buffer = to_iio_buffer_attr(attr)->buffer;
 
 	return sysfs_emit(buf, "%zu\n", iio_buffer_data_available(buffer));
 }
@@ -1486,7 +1503,7 @@ static ssize_t direction_show(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
+	struct iio_buffer *buffer = to_iio_buffer_attr(attr)->buffer;
 
 	switch (buffer->direction) {
 	case IIO_BUFFER_DIRECTION_IN:
@@ -1525,15 +1542,15 @@ static struct attribute *iio_buffer_attrs[] = {
 static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
 					      struct attribute *attr)
 {
-	struct iio_chan_attr *buf_attr __free(kfree) = kzalloc_obj(*buf_attr);
+	struct iio_buffer_attr *buf_attr __free(kfree) = kzalloc_obj(*buf_attr);
 	struct device_attribute *dattr = to_dev_attr(attr);
 	struct iio_dev_attr *iio_attr;
 
 	if (!buf_attr)
 		return NULL;
 
-	iio_attr = &buf_attr->iio_attr;
-	iio_attr->buffer = buffer;
+	buf_attr->buffer = buffer;
+	iio_attr = &buf_attr->chan_attr.iio_attr;
 	memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
 	iio_attr->dev_attr.attr.name = kstrdup_const(attr->name, GFP_KERNEL);
 	if (!iio_attr->dev_attr.attr.name)
@@ -1541,7 +1558,7 @@ static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
 
 	sysfs_attr_init(&iio_attr->dev_attr.attr);
 
-	list_add(&no_free_ptr(buf_attr)->l, &buffer->buffer_attr_list);
+	list_add(&no_free_ptr(buf_attr)->chan_attr.l, &buffer->buffer_attr_list);
 
 	return &iio_attr->dev_attr.attr;
 }
diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index 26c88767afe6..1e4122b8c13a 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -9,18 +9,14 @@
 #ifndef _INDUSTRIAL_IO_SYSFS_H_
 #define _INDUSTRIAL_IO_SYSFS_H_
 
-struct iio_buffer;
-
 /**
  * struct iio_dev_attr - iio specific device attribute
  * @dev_attr:	underlying device attribute
  * @address:	associated register address
- * @buffer:	the IIO buffer to which this attribute belongs to (if any)
  */
 struct iio_dev_attr {
 	struct device_attribute dev_attr;
 	u64 address;
-	struct iio_buffer *buffer;
 };
 
 #define to_iio_dev_attr(_dev_attr)				\

-- 
2.43.0


