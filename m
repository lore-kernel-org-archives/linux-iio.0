Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795197895;
	b=lnmx1GHR1p6DGqksLprgbj5Jex1iBaW5FLbnuT86/i8Ujjy2TEF50rAQT+MoahnKO+Z/
	 bFC8AkJuAgymrE2u1UBy++1PsUb9oIfOh1mW/xVExdLwYu+fuvTBde4R6Ov7p8z3sZ2IF
	 hVjjNhAZ5GI3chBmLGi8qjAWfjR07ol89yGkZZNXZT1Wb5IKKIMTDvn+/W8teEJ0diyIL
	 qNuylDeb2+InAFo0HkIr+E3PiDYSrv9Jjp9NtftSVO3/Hnqxuq3Li+SGlb2oyWaiwghSn
	 aT7T8BerhY0CbtPN9Q3B4E+MO9CPQsmfiCqIUwdNOdZ4W6iARGCjoiDmwE1ZgOF526g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197895;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PZM7oYzEYwdzU2au18qxONpg2XyJj1yftpo2bjWYQAs=;
	b=CtpgXYtkccjnuRAZ4VGeCRhpOHMlMdhwAJw9Kuav2vh8yzVvP9X9Tx487F3dWgjGp+Nr
	 Za279c1pZ0pWEw/2f0n1vln0cVyfPJeJJpWRwxnB2NyyBnFusJ7hEsRMXA84djCePrCfY
	 SX2w0hOAI3/BzI+uZ+I+OoOXxUSzWSyk1UIDYRU5g34d8g6BJmpt5SKUr4rGKyy4ydDjD
	 UzdTxFRMCeiQu4DwLb4pLUboUCqk1tQ0X3s2z/SXVRS6zMVYqnT1Jk411quMZuvjvvNA/
	 bI/0zFsjD2vzwh+Wu+l+efAqTPS6UJH1A2cy4yrBVkxJK1tu8glbHD2frasFZRTztRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0ZOSSiF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3F160A6F7F;
	Fri, 20 Nov 2026 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0ZOSSiF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795197894;
	b=Y+5D34uOlumZopG/dhsnWIAbv7ZlfP6uYcbkZSdyIi4DanvLacX8zVE5gbS3356waDgc
	 gkJUt0ksddQRn8RIfsDmd7oKTD2i7K/pDdbK0dpnXIL+9cpqgejjMQ8UiVM8O3nJkPZNJ
	 A14T33gwCLI8Ee2DFS8DXpPslEk6k/mc+iXswlgTiXWJSgyZMD52T5ZdpzvyfjFLVfaTl
	 D5OG+u96BERytB2BTNldGmw+mwnmDFF0m2n9jZcQuWbsGNvzSgslen+GudszlF4yp/FsZ
	 2EyJciCohROu/fGaVFPosSzRty0k5XWvj8HXDE5833p4W84vT6fnFWV+xK8YSBMgtrA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795197894;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PZM7oYzEYwdzU2au18qxONpg2XyJj1yftpo2bjWYQAs=;
	b=07Swk6xK8AHIFr8WJsY6YdsqCq5uKtakQa2Vq7jJdJkumCjxwAi58pBV48EUBT7i6HHG
	 U5GkDTcJvCCsrsqvV2Go4Q5zWVNH8t3C6mMip4umQXFZwvfN6JnHU8PcoN7wvsL7wxdYs
	 viIOg7e+FdoIQvN/JLRjtbC6FW9donF4DQoB9vvSSeJiSDI2VfJNYDJxh02eGPJ3UQQ5r
	 6t69L5ePuuGwK7cs1LfezX+vCKGI9w6nuNkTz3LpPy4Wsvx4XJceTVulSzGICxV82SJZc
	 qMamYNlYT2o8kCi2XMnBjlS6+Igza/Qu3FzbLGPNyBLT6aU/lhFuY6Zf+9RqfU5V4MA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AE5211F000C0;
	Fri, 20 Nov 2026 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795197894;
	bh=PZM7oYzEYwdzU2au18qxONpg2XyJj1yftpo2bjWYQAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=B0ZOSSiFzcuCNaXZlT8Ie1GHsY88C8llspR33bbSFM4Hm3j27da+XBHxP6m8wtxdR
	 DdBK08lM+WtaFFwDwdkq2mY05ORrL+oxi+3HYLzuLxWfZcWU1w7k6D+UF8MrP+JgLj
	 JGgSsklu6opgh23XpnW2teNvDUVJDjCVGk4/EESoVmro3NUMamHbalEdG150TXeO4Y
	 H1xCVYEyKYBAcHXS+uvbCfBDHXw1OsCZwpGLpqIHBgF7N5eDnmcLjHlgxLpByv/GpG
	 sXtBhoFThApOyUHe9/bHq5QRkbt9V1fi+VdKIv7f4BjB+7ujUDl4O93GDgmzszGwu/
	 BoOGRWuSVZdyg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 447124B8B4;
	Fri, 20 Nov 2026 18:04:43 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 20 Nov 2026 18:03:57 +0000
Subject: [PATCH RFC 1/5] iio: buffer: add iio_attr_to_buffer() helper
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
Message-Id: <20261120-iio-core-attr-review-v1-1-05b41f8133c2@analog.com>
References: <20261120-iio-core-attr-review-v1-0-05b41f8133c2@analog.com>
In-Reply-To: <20261120-iio-core-attr-review-v1-0-05b41f8133c2@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795197883; l=3151;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=z0/ZhH1JujFCeJIP+q1ZFyWSGE6ClMob85zW1bLHCIE=;
 b=EqozodOK61CCRpUR7I5AmUZvkpvSMyIjLg+2qwcU/EgW2wLh3nGnJmIsL8I8Pc17hwjGiYuHv
 jbZTsvYe9GcDRVXOH+9B14AYVHvWd5Z2Rg5UU4xQG832ImUgQZuYBVQ
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Buffer implementations providing their own attributes through
struct iio_buffer::attrs need to find the buffer an attribute belongs
to. The DMAengine buffer does that with to_iio_dev_attr(attr)->buffer,
which depends on the IIO buffer core wrapping those attributes into its
own copies and on the layout of struct iio_dev_attr.

Add iio_attr_to_buffer(), so buffer implementations no longer depend on
how the IIO core keeps track of the buffer, and use it in the DMAengine
buffer.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  2 +-
 drivers/iio/industrialio-buffer.c                  | 15 +++++++++++++++
 include/linux/iio/buffer_impl.h                    |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 7ecb9d875b8e..2e04cd5e3411 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -226,7 +226,7 @@ static const struct iio_dma_buffer_ops iio_dmaengine_default_ops = {
 static ssize_t iio_dmaengine_buffer_get_length_align(struct device *dev,
 						     struct device_attribute *attr, char *buf)
 {
-	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
+	struct iio_buffer *buffer = iio_attr_to_buffer(attr);
 	struct dmaengine_buffer *dmaengine_buffer =
 		iio_buffer_to_dmaengine_buffer(buffer);
 
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 4294101810fd..2d7759325eb3 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -69,6 +69,21 @@ static const char * const iio_endian_prefix[] = {
 	[IIO_LE] = "le",
 };
 
+/**
+ * iio_attr_to_buffer() - Get the IIO buffer a buffer attribute belongs to
+ * @attr: Device attribute of the buffer, as passed to its show/store callbacks
+ *
+ * Only valid for attributes registered through &struct iio_buffer.attrs or
+ * created by the IIO buffer core.
+ *
+ * Returns: Pointer to the IIO buffer.
+ */
+struct iio_buffer *iio_attr_to_buffer(struct device_attribute *attr)
+{
+	return to_iio_dev_attr(attr)->buffer;
+}
+EXPORT_SYMBOL_GPL(iio_attr_to_buffer);
+
 static bool iio_buffer_is_active(struct iio_buffer *buf)
 {
 	return !list_empty(&buf->buffer_list);
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 9442c165561a..c259dfdf46a2 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -9,6 +9,7 @@
 #include <uapi/linux/iio/buffer.h>
 #include <linux/iio/buffer.h>
 
+struct device_attribute;
 struct dma_buf_attachment;
 struct dma_fence;
 struct iio_dev;
@@ -197,6 +198,8 @@ void iio_buffer_put(struct iio_buffer *buffer);
 
 void iio_buffer_signal_dmabuf_done(struct dma_fence *fence, int ret);
 
+struct iio_buffer *iio_attr_to_buffer(struct device_attribute *attr);
+
 #else /* CONFIG_IIO_BUFFER */
 
 static inline void iio_buffer_get(struct iio_buffer *buffer) {}

-- 
2.43.0


