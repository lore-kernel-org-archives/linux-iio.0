Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795772889;
	b=BHpswR6vlYHvez8hTteZou8/O43RA14bUbyQVL5R4pamPlYPQb5bhr5wT40cDo5a6NmN
	 ir8lpKzMoVITzDha6doUWcqDubHIgE97dxoxuATCvrM0XUlDAtE2dQ3e09CGQITQfA/nO
	 Sz4YOrP4bneEWhREbwprgmCQ8PhWhA3KXL/xKRjYAR2xBmaxjRotmRsL3yNfKrFbr8fRo
	 R2dHyGai3EGNnhtJM7rUDbOes1xT04JRdVa0KjoPARH/ug5XoyDVsXNx6IsnenkyxsVbW
	 Z3lJIArQqAir/SDPtJZDT/mOcoOySa3u/PukJ6k+YhIxDOIF6PUXecn5682zxrmtpsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772889;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PZM7oYzEYwdzU2au18qxONpg2XyJj1yftpo2bjWYQAs=;
	b=kRVZkPyE4koGc0+VzebKGvsXjJxUC8iw/nNrGyJJdwIPwVJo+qRFwqW7/SD+2anEL3lJ
	 j0lbQatEcHsMoUb4B9O84BMzr2iPL4PESEFdP5H8Zf5x4X0zBF46jD6FXAL95QZDQyQxw
	 AIzilspfMnUvgzm9mA1j9lB71tYqOpY/PzazxkKxdz7OWzJ5JPL+L+eqvcw4ayinBuSFH
	 8345osOThkSh56Gur+ZrmtKLKkLcl5WffKqSrJD7/UZXDvjfwC8xyDMq/KtQ5jor9IH2n
	 9DZD2Vq1rGKRbg/X49EcZCQOYQ46dDNPaR8tQ8CuRYzFnKYOSAvczqU2T9LgN8oSMTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXx0RluR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59960606A33A;
	Fri, 27 Nov 2026 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXx0RluR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795772888;
	b=mbf638isd9WZRZC9lHuTpiA1KWebOZiqNgEPtLg3k9HAL8Vw/9ki1NNX6+ye6tinwvcY
	 hhX1LujMXgdVo2cDES26qZt5HcG+K7olEXfjpfjmZvWkBdNXFF/afls1JJsQ9AFGA+B0M
	 /6IKomoqgqed7Au2dOvERi9yCQaRXFasuu+ZoTZx56J7ve1CjVZZ3BorHXRPOIpBY68mh
	 F5JgJG1MPOypMNfa87bueJv5pF9vD6qUPZ8EFxwLGdMgwpGrUSmMmujuXAVbW9dYFSN32
	 sIIAodq16+hCGSW8X/mEn/r4syIz25I68CrzBZQ9Q4/1jZd0woQZJxWaPXwJtTVURqQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795772888;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PZM7oYzEYwdzU2au18qxONpg2XyJj1yftpo2bjWYQAs=;
	b=0r7aaP5Fg7sMwx+TIli1y3tIS/aIbV22S9J8zeQsIrve3+vZ+nw+I+wSsX/jYPksyx72
	 FtAPc8/SjE24u67q1cKZsKgVLP08/rmZ76zYaNQ64M2XSkoUUkwosGXk25EZlmYjGXz1P
	 4Y9XMf7yaC+/FQQflxs56IW2vGeN8kAu9dTv8160fHpqCetTCARa40EThRDrD3FQCxy/B
	 2E+Rg3kppxahdQbmJ7FZuae7UR8jNloyV7eftoGfOOiRrNfmCTZsOfsl80HByIYSY+oYu
	 sp9bAdW7BYKMVENy88EBELXg1prGazlkYTR7z6teV1MLzHZ8u2lHK5sttAQOGr27AEA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EBB651F00899;
	Fri, 27 Nov 2026 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795772888;
	bh=PZM7oYzEYwdzU2au18qxONpg2XyJj1yftpo2bjWYQAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hXx0RluRoIOsH92W/+efRqX44PGYFQIeKTmOS9JgjAhZIYdIVLsRxyO17M850GjZf
	 O5SbGYM6vokP/xFlCuWIEbgrWtcHllloGyHOapmYIb0nyJLPnt8+ugL4YaZh1wBWhW
	 nFNafjOFb5pWaJihbgQTyNW5ryOVJ6/2nDkQy0VSVfd6AdzuNJCBqvp8UkA28c8I3C
	 uhC/yYwSnDtW4bF73xFg2rbPlhLpbNyrG32IYeYV0N8GYz9oq1JHR+PScPizYdjbYb
	 dUOVN48KUnFimlDJeZaVigb5Wkmq9a0n55bOf8IKAQvAImnLUaGEydCFAkBf1FiTYU
	 90AbPIf3qDQkA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 76CAB4B6C9;
	Fri, 27 Nov 2026 09:47:56 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 27 Nov 2026 09:47:45 +0000
Subject: [PATCH v2 2/5] iio: buffer: add iio_attr_to_buffer() helper
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
Message-Id: <20261127-iio-core-attr-review-v2-2-e0aed1e8a81c@analog.com>
References: <20261127-iio-core-attr-review-v2-0-e0aed1e8a81c@analog.com>
In-Reply-To: <20261127-iio-core-attr-review-v2-0-e0aed1e8a81c@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795772875; l=3151;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=z0/ZhH1JujFCeJIP+q1ZFyWSGE6ClMob85zW1bLHCIE=;
 b=X3Kdpmm5PWlbvnczml4Fu50JOjG2krSo/JGxluHrFfmaGvtyoRkkFoUGz9M3aFuEUMY4qxslo
 TxUhnWPnbQcAs/BibMdXRwL9Tu5kXysKXV37CsXZMkbc47WcdBRaD2f
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


