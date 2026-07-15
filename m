Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E622C15BB
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.137.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131700; cv=none; b=PLvY4iJdRkUzAdzB5LhUxAzsziKHeiNw4HTpOX0dRWjSnAgsYx73C0Z9zYTnjV291p3Kc4yBd8gfBGWTpGeZVqufE4og8dU5gTh+dwAq8EuwcUJ8sS2xVW8u68gtObgRGVPetKatW88D0Eh73W/UckY/mKB8R82GbMLJbpx81xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131700; c=relaxed/simple;
	bh=b9FBsxNqG7mMqFGh30EgIZD/E8QyqGoZ32+Gwk3tiK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQJAEsCg1CnVFXpkjedbHz+eXaxnG6wBRrM8z8vTjyiVy1/UnZ+7s5bFphNKRG+JhJm2OU3bn9VigauPfO/Fo7vBYB3/xHS44Lf+vYk7k2dGZAKULXYpKxMDCSpftxoCeCTm20Q32DiI7tkQdn4v/ctT9YwNaLJMReZIYOgO6+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de; spf=pass smtp.mailfrom=metafoo.de; dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b=Mhn3lqRA; arc=none smtp.client-ip=78.46.137.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metafoo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="Mhn3lqRA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
	s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6tJpVckYpHfdzXVdA52mZwOtcKu9CjVTLSu3u2sGXbM=; b=Mhn3lqRAiKbRa/1TxuZgWAwsEn
	Df5SwGakjUyUt06FWDUIKg6DfPrgwh078XxWmmxnKIs0eENherhhdK3CrRwekjDzYiy/VK/QcLCtj
	1zmgwiY6+dNxGqKhywSlD1bWvJkWAbeH4agvCGiqHi3waSjBj1LHorUCNBzQHzCb0bjx49nDIluMh
	xmUTDr0rQMGeIgAQrSntQHYInwcJEYVMG14EjCZXW/y7rD6mqxyCl9iLYCavPCwviCCFJwstuVBXE
	PvE8CaZ+gA6wLbrwKx/zzMsYiezdW1XFnEjEmXKi5Uw0KlPLEBzpsc9hFFCYwQFhU5Nz0EbVKJAJv
	UwYYZ0fQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <lars@metafoo.de>)
	id 1wk1lx-0001Ql-1B;
	Wed, 15 Jul 2026 17:43:45 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lars@metafoo.de>)
	id 1wk1lw-000DNF-15;
	Wed, 15 Jul 2026 17:43:45 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] iio: buffer: Tie IIO dma fence lock lifetime to the fence
Date: Wed, 15 Jul 2026 08:42:44 -0700
Message-ID: <20260715154245.3814378-2-lars@metafoo.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260715154245.3814378-1-lars@metafoo.de>
References: <20260715154245.3814378-1-lars@metafoo.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28061/Wed Jul 15 08:25:10 2026)

The `iio_dma_fence` implementation currently uses a lock embedded in the
`iio_dmabuf_priv`. But the `iio_dma_fence` can outlive the
`iio_dmabuf_priv`, which can cause a use-after-free.

Tie the lifetime of the lock to the lifetime of the fence by embedding them
in the same struct.

We can't just hold a reference to the `iio_dmabuf_priv` from the
`iio_dma_fence` since `iio_buffer_dmabuf_release()` might sleep and the
fence release callback is not allowed to sleep.

Note that the `dma_fence` framework now has an internal lock that gets used
when the passing `NULL` for `lock` in `dma_fence_init()`, but in order to
allow this patch to be backportable use an external lock.

Reported-by: codex:gpt-5.6
Fixes: 3e26d9f08fbe ("iio: core: Add new DMABUF interface infrastructure")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 04b3916f89e2d..31c06bffdce8a 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -47,9 +47,6 @@ struct iio_dmabuf_priv {
 
 	u64 context;
 
-	/* Spinlock used for locking the dma_fence */
-	spinlock_t lock;
-
 	struct dma_buf_attachment *attach;
 	struct sg_table *sgt;
 	enum dma_data_direction dir;
@@ -58,6 +55,7 @@ struct iio_dmabuf_priv {
 
 struct iio_dma_fence {
 	struct dma_fence base;
+	spinlock_t lock; /* protects base */
 	struct iio_dmabuf_priv *priv;
 	struct work_struct work;
 };
@@ -1706,7 +1704,6 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
 	if (!priv)
 		return -ENOMEM;
 
-	spin_lock_init(&priv->lock);
 	priv->context = dma_fence_context_alloc(1);
 
 	dmabuf = dma_buf_get(fd);
@@ -1896,6 +1893,8 @@ static int iio_buffer_enqueue_dmabuf(struct iio_dev_buffer_pair *ib,
 		goto err_attachment_put;
 	}
 
+	spin_lock_init(&fence->lock);
+
 	fence->priv = priv;
 
 	seqno = atomic_add_return(1, &priv->seqno);
@@ -1906,7 +1905,7 @@ static int iio_buffer_enqueue_dmabuf(struct iio_dev_buffer_pair *ib,
 	 * the dma_fence.
 	 */
 	dma_fence_init(&fence->base, &iio_buffer_dma_fence_ops,
-		       &priv->lock, priv->context, seqno);
+		       &fence->lock, priv->context, seqno);
 
 	ret = iio_dma_resv_lock(dmabuf, nonblock);
 	if (ret)
-- 
2.47.3

