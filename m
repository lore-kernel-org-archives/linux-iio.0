Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795197895;
	b=AH1ez1Sn/UN6JiVERtMqsL6f88POSis3b7Z56gaKmPm2EQVzDYri0OEMgNsn9RAWwWjg
	 4kmBJrGxmBsDo+0fRvAUJHFDSrkx6AhiLYNT7yX/WkOsnQX93QiTbdgLRZfYAwyxk8XYg
	 O58ha4lI/vVUlgPuFbZ7VPMYVBg2I8FbwSQW+MDINtFhYz/sqM603yAxBHYuG+DRlNa1I
	 FsT6rqFSMM69d+//r6yo23ZeFjQ+QVIKAMFmr0xtXhR7I59YBUzEayI4Rbe5cfzEjZ1Yj
	 4KO7N6n6U7DBdz3pzYND/wp9p6PdDjebGvCrynMTqG6TDZlU8gJN2vi/e+TMao1/srw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197895;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1W2pcxfnoracRWXlknxHHgdS3Y2NznHdZfViuP68nTA=;
	b=GX5ryFYAo0cgIJhJBWcpzwONFvaS3awhFbqMnTbM9H9SDIAyMrWuX9Ab8q7bBAeoUZI7
	 oRtWi73Z+d93gV9Fw/MrzrJ5+4LPwNNzP0FCZUNgleTP8HwwXLG+rL/bfTV1nEVlALUxO
	 32TSsXxiVw6viNFLOqmaNoYKeL1cBeDvS0N/QjJy7p6ovxFiDpo9ImIHQZBJrVS0wBS8+
	 YzBPZx+ImqOCUDS2Lv0gRFHhFCTTibmwtRdIFRgb0pbF43c9uwTSP8YitmbzsV0mbtX6J
	 b6nmYwikif0nsg+LYE5bLY5bRvXpxJjHTiS0/6vFSf7HiYp/ULuFPbSgoM64XQ5BmJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZ74gdlB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF77606A335;
	Fri, 20 Nov 2026 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GZ74gdlB
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795197895;
	b=My9xRiluBq53LkVo5aicyTpcLeRrpNySki3nEqkhl2hz96tc2onM5qNyL/TBYu2+xtz2
	 A2jyNf2EeicEB+I1bxWSVt/Ar7YkkUB4OK/ZaC8yb3Umr9ZIiay1BOBhZPA2/N0mpZBDw
	 1p6KdPG7xfhQpS5+2ual0iAhZY2PFo5n5cldrwJw+paVSdn1mMMa7L5O2B2DkJwmmxIx5
	 lMfULANUi6G7VxwdrTIrCXU91QaElZYI5kxMx0rBB5SwrgKL2Bmgua8Xfmh74VU0Xfta2
	 4XivBiAapMDzRMQ/aVY4wns2YLYCaXlG9lh+eoyD+mWxRgGSG9n0jAdEX9C4xeyuizQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795197895;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1W2pcxfnoracRWXlknxHHgdS3Y2NznHdZfViuP68nTA=;
	b=C1BQMxjYCMBNmmANQd5gjqeyvapQWnEni/JUDZ8oJ+RgasasAUuAIaRUryhJyP+4V/F5
	 sJdTJrmj8xpaRqbUtbnDklTB2kGiicryfY5exRdixX7eLeDoHM/lekQI6bt9E4VkLPUtd
	 a5V+fSkjD4bF1jaQL+1tdrKeAdx3O8VWCmIhiyIL0wsVmhgRV04l3j65eBHzErNy/BUOz
	 W4axABQyEjtY9aCBpkoIPcyamw5bpDGGipgGpDEkoMPhErHG7vRKtp8Se070KsleN3Nt+
	 zZDZNjpgSD6AB5DNq1tvgLyJGT81d0lblczUjWrOu6Z/YnbI3IQwZmv7Lnu1EDKR06w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 124EA1F000E0;
	Fri, 20 Nov 2026 18:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795197895;
	bh=1W2pcxfnoracRWXlknxHHgdS3Y2NznHdZfViuP68nTA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GZ74gdlBpp1z5OEF+sgtNhK7tNVfds6oRGVxPaJ3xsBhDKwB0k8uHwAJ2yxd42Wvj
	 U6205a5RzLuqH7DR03yl3FQ9jsNp8rZQQgZoTNGCXHZPbN8V0cA22zZRAe4Y1tuUh9
	 FGiOIPHLC357O1NLKnP36OPMbw9XPXFfGurrh5YFhfZ1QsMAyTiFnCZlLIisfftk1e
	 nMJ6xn+JYq8RsSW6ErCKbx9G8IK22w6W8IIuw+N8kdERl0AU6t0IJWe5jl8ZmlHQR0
	 tunJENasTR3B6yxawGb7yLc2FewGid4wof1J3Jl7hFY5syEzkBDz00N+Fm1PH3j0Qn
	 rlbGK1sgIMahA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9837A4B8BD;
	Fri, 20 Nov 2026 18:04:43 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 20 Nov 2026 18:04:00 +0000
Subject: [PATCH RFC 4/5] iio: buffer: add struct iio_buffer_attr
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
Message-Id: <20261120-iio-core-attr-review-v1-4-05b41f8133c2@analog.com>
References: <20261120-iio-core-attr-review-v1-0-05b41f8133c2@analog.com>
In-Reply-To: <20261120-iio-core-attr-review-v1-0-05b41f8133c2@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795197883; l=8179;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=ImAfRQLQu+XcD0pXeETlVY+2toE6tfBAgy/mqJnxBFA=;
 b=t8GOUBA9s+UVChnnXGlsHZmucGiKbSE+LGGHz22pixbDPA7sISovrPc1MSeddDKBVen2Hja7I
 YBXwHdI89YhAroZePs/KJtSwqwO2LGzdN8sKIP0ijYTV9xGCBNR4YNc
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

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-buffer.c | 63 +++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 48fdaed6d703..af5c9ecd1b3f 100644
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
@@ -1526,25 +1543,25 @@ static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
 					      struct attribute *attr)
 {
 	struct device_attribute *dattr = to_dev_attr(attr);
-	struct iio_chan_attr *chan_attr;
+	struct iio_buffer_attr *buf_attr;
 	struct iio_dev_attr *iio_attr;
 
-	chan_attr = kzalloc_obj(*chan_attr);
-	if (!chan_attr)
+	buf_attr = kzalloc_obj(*buf_attr);
+	if (!buf_attr)
 		return NULL;
 
-	iio_attr = &chan_attr->iio_attr;
-	iio_attr->buffer = buffer;
+	buf_attr->buffer = buffer;
+	iio_attr = &buf_attr->chan_attr.iio_attr;
 	memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
 	iio_attr->dev_attr.attr.name = kstrdup_const(attr->name, GFP_KERNEL);
 	if (!iio_attr->dev_attr.attr.name) {
-		kfree(chan_attr);
+		kfree(buf_attr);
 		return NULL;
 	}
 
 	sysfs_attr_init(&iio_attr->dev_attr.attr);
 
-	list_add(&chan_attr->l, &buffer->buffer_attr_list);
+	list_add(&buf_attr->chan_attr.l, &buffer->buffer_attr_list);
 
 	return &iio_attr->dev_attr.attr;
 }

-- 
2.43.0


