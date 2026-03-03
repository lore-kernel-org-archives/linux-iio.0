Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD936320CCF
	for <linux-iio@vger.kernel.org>; Tue,  3 Mar 2026 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538600; cv=none; b=U43tifu7SW6Ksvzk6VHVTuFuHSYs+PKAb7hmyF4u7gAlXRh8j4XjdBGxxYZ7EJV281sG5jF0K8TcxGZKoGm0bKcxRgo4tKyhvqHHmd/+o1D+iOHi/dp4OKSJxs2T7tR8tEP900u4VxJZfusEN+Iqw5T+xGDL+3CZoj/wAehkN/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538600; c=relaxed/simple;
	bh=Svustoin1+EgaXd/8ILGkfmXSMO9v7n6t4zmg0oUhZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ir0g1+Fc+TSB0iryLJPeZfE6gS2TWP1xQBqViZ/OVURn3EjdFiuqS4zNShg9Ysuq60U+Gw8GhfRm4G95cALhUrTWXjylgMgHimDBpS8HJ9ta147wkP/xLrI2AYjFYE4l6d4nx/D6U/ls5ccpWu/Zmuwdm/KOPq2n9Ws8z9OzlYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsKcsSiU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsKcsSiU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DAE3C116C6;
	Tue,  3 Mar 2026 11:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772538600;
	bh=Svustoin1+EgaXd/8ILGkfmXSMO9v7n6t4zmg0oUhZs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=JsKcsSiU3DNkltqL0A79a+1Vuc/czgZbzP2I2bxxxzA1q+mLNLiOZas5uZNwskaPJ
	 wjjpLF5Fp3ERVzmwyqaVELj9dA3/JWhinHL+4WaRtDSiXIriZyA/W+HxN9vHfUCvfv
	 osfEyL9LwXt3xBtsz6mpVkaPMTBLn0uuMnvlXz/FkJ4OyAz0WePpp3FE/9X79zkfT6
	 8C0Y6eLZLrQoEfID8+35a7cRy3OJK0gHhHNQ6XDuUlXp+b+zgO18krmCIkQuTnXHUu
	 eSWuSDTblewv2QEqQQq+l/1HNzWM13GNvq0NooVU4hKYUJmGqJ4cHnH4BDCJH3ZfLl
	 1FTwsY3xTjyng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667ABEC1421;
	Tue,  3 Mar 2026 11:50:00 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 03 Mar 2026 11:50:44 +0000
Subject: [PATCH] iio: buffer: hw-consumer: remove redundant scan_mask
 flexible array
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260303-iio-improve-hw-consumer-v1-1-1a19b41977b1@analog.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSQqAMAxA0atI1gbq0IpeRVw4pDYLW0lxAPHuF
 pdv8f8DkYQpQpc9IHRy5OATijyD2Y1+JeQlGUpVGlWpCpkD8rZLOAndhXPw8dhIULda28bWZmo
 LSPUuZPn+z/3wvh8j5hASaQAAAA==
X-Change-ID: 20260303-iio-improve-hw-consumer-5955f7f46b91
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772538644; l=2083;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Vra+JWgYqm9/EZduYD5+E8f+DHld6y8zoalqRBr7c9g=;
 b=ncbwgfMDfxa9sSOgqaivP4hoCsa4silS+6HmvP7GOtU8KV9ZfD6qzIvPBV6l+UzhVjXaqJjtn
 8pncFnsy88mCk5Qrp2NjvluYOzB4SyisQCSqCuUkC8uPUP6li9tfZ9W
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

The scan_mask flexible array member in hw_consumer_buffer duplicates
the scan_mask pointer already present in struct iio_buffer. Remove it
and allocate the bitmap directly with bitmap_zalloc(), assigning it to
buf->buffer.scan_mask. This simplifies the code and there's no need for
the flex array allocation.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-hw-consumer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index cb771ef8eeb3..24d7df603760 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -28,7 +28,6 @@ struct hw_consumer_buffer {
 	struct list_head head;
 	struct iio_dev *indio_dev;
 	struct iio_buffer buffer;
-	long scan_mask[];
 };
 
 static struct hw_consumer_buffer *iio_buffer_to_hw_consumer_buffer(
@@ -52,7 +51,6 @@ static const struct iio_buffer_access_funcs iio_hw_buf_access = {
 static struct hw_consumer_buffer *iio_hw_consumer_get_buffer(
 	struct iio_hw_consumer *hwc, struct iio_dev *indio_dev)
 {
-	unsigned int mask_longs = BITS_TO_LONGS(iio_get_masklength(indio_dev));
 	struct hw_consumer_buffer *buf;
 
 	list_for_each_entry(buf, &hwc->buffers, head) {
@@ -60,13 +58,18 @@ static struct hw_consumer_buffer *iio_hw_consumer_get_buffer(
 			return buf;
 	}
 
-	buf = kzalloc_flex(*buf, scan_mask, mask_longs);
+	buf = kzalloc_obj(*buf);
 	if (!buf)
 		return NULL;
 
 	buf->buffer.access = &iio_hw_buf_access;
 	buf->indio_dev = indio_dev;
-	buf->buffer.scan_mask = buf->scan_mask;
+	buf->buffer.scan_mask = bitmap_zalloc(iio_get_masklength(indio_dev),
+					      GFP_KERNEL);
+	if (!buf->buffer.scan_mask) {
+		kfree(buf);
+		return NULL;
+	}
 
 	iio_buffer_init(&buf->buffer);
 	list_add_tail(&buf->head, &hwc->buffers);

---
base-commit: cd04646c0f3eefdde87538f6ff932420cedc9ba0
change-id: 20260303-iio-improve-hw-consumer-5955f7f46b91
--

Thanks!
- Nuno Sá


