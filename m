Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785819;
	b=yyRpxhw99EnS7SxPj/IHKFq9Wyx0E1brp+ODmfUVpwi4Tr3wPUKFP4UqEL85lrAcbjvL
	 0sOWv99Dr+uEgMlVNA9LYLGd7YSh0rnT6GNb8LuKTjiOyAfR89bss+8Ahmcnzo7YqInTT
	 4ItGr18I8vkGJ5COO6x4lhnb1znNPdRi6JxW9ID0G5jG60AYVr51yKvRwXTYLt+38BxMh
	 vHLNBaoC8xQAZbNpEHY/W082+PccR2f3sW89CKPChvQQdbxQk/F0v4D4bwrTp48OmIu9n
	 Y/BWIyk657MIUgy037lqO3pRIiSIgucz1YlhewxoSm5N1EDPPHDQHOeSIzODIl7gFCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:Message-ID:To:Cc;
	bh=z9ahkQoGqY4LXm5ulXS80YZleTn1KGfrTqpEsVzzvjo=;
	b=abAItcUv25hNn36iNQm7r3skyQmu71cklqsEGYxG1xOje6Gwx2TKi/kQq4FszyFxt1rR
	 p/9tN+U3eC59Un7JdQYxpMpnDRv1HKb0t+OOPpC8gVC3j6jwSmcjSJ2zYxnVLjGjerecn
	 Dtu7vW5x9zioHXFJbcWc/bWj4lJmN8cy3ebzIoU+eIbnTkMiPvnrjoK5BzVWXoQ85S+Px
	 Y9mj3KlhMAsXmApv/1LqRYK1tpFQIUs2I3WVW0J2z27OKw7onyK77EerugVp+Q3nU9LQc
	 gW9eknIBSob1jwwmjnbUvppiydm9ijy5mtL8E+sUKfxC3jdI1P5eKN+vx8qdkdj15ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R7Wx2uuD;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBC8606A31B
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 09:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DBC8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R7Wx2uuD
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36cad25b8b0so700031eec.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 01:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793785818; x=1794390618; darn=vger.kernel.org;
        h=cc:to:message-id:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z9ahkQoGqY4LXm5ulXS80YZleTn1KGfrTqpEsVzzvjo=;
        b=R7Wx2uuDBgNls+XoNlqzt23IZkEGWU94ycKy8gvIwI2P7FjUK+MliwC8wupB57/+Z6
         rxW63Y/2vd+FDslj3mXWEG/NS2i4RuWieP1lCxwwlTTlXi8luo7EUzSPzvmWgukGHNre
         iUOuC0b216RNvkQDZgKhrIkJaxmQLvRmXKaX082SNqWiyXkDFIE3aOZiP6698LOem09T
         CVjuaPJgXj5XIxn7MwqGT0St47QT8uoDIc5Cq6ZdrWBV/p5LM9zFR+Or3YvapelgtbQL
         Xz8SypqHeP+IEcgZHTSdyMKDMpV0lfzGqAj095SFAOYDmmmAy6Igqb60WbJPseV7TBQ+
         INaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793785818; x=1794390618;
        h=cc:to:message-id:subject:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z9ahkQoGqY4LXm5ulXS80YZleTn1KGfrTqpEsVzzvjo=;
        b=SkvgWz9Rd/V2dTuFstI8btILRI1hSobmpgdOivBv5tNjwd0fyG3xyFeU+qNbKrHJrG
         tu610io4yxJf3PWPr5PjE0pN92I/gKVy8LnnabqyzxrFz+AId/Tw7EUcP/ld20YDnId0
         dIJqHD5vEUxyCo5Hk+BAKN2keWZNVKuPg89dIZAbGZRM4T84ziQmBswgzw4iuy3nBCBo
         Ry3ddsIAtmo9kSCe3ce+7bd9axmfhmwrhMULo3MqASZLS9TGv3QPKCdsOMKiFFj3Ysmb
         kf3ZCDwS/qJmWlpMqtTefAetbu2NCei9s0Qta5NNGacixLBLxN0PBp3+ZsElbcJf27wV
         IqHA==
X-Forwarded-Encrypted: i=1; AKwUvBx6scg2MjKMLGBFBC8EUGzuunhk7IYtZPUaXW8oczHr5fs6Fp0ZwSEfYN1MlnFwN4OVbX6IDDSvFPw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8drl1T5leR4DaRoQS3yKurQ+AQ+5RgZCbGQvubbPt9MyRRXTJE
	3lO0kqvaF53lQYkoNWg5vSyhUbL4boVZYUsBXN0z7EU8YO5SVVewD7uM
X-Gm-Gg: AYBFou26jYeyX2u4R0CFGxz8bstPXTNZ30QTDzv/cYgu6GAIcRMZkZo+aT19QCRxmhy
	WywJn8buq8pUOKRfp4oj0cGMNk+loks2wGJvoYByLtWTXVRV5X79iKKfKH6CD1wOEu745oEEV4y
	0ObEimezOVL4e+1m1P5RV+yQmnUmHByw8/5p0dx2MX7FAx9Yyas+ToyR06rDv4xGiCMmCPptBdc
	kXUKK8NmT0xSL2KrEYy3WIv5nKJA0pJKLXAyEvN0AJoEa73qOuftIGvAXkL9Gw9Z/NSk0NAE1xb
	w3KPHz124McVeoSGU4icUMRpH9g/gAySe0Kn4s6/1YG7MTd3ISpQWz38YTznYmSgHFTXPlAMgQt
	pYThQ4MhgofhtQeWGneCR/5wB0bnnPqWuDUpqg+NJRqjQra1Jyk/5UvjmwE/CXEr1RtkU9+pGKZ
	y5or+MYftoJweZhAUR8NOgc2dZKulnVzWLlPhfS+xh9zsq0Ma6GIY+1qLVtgsDDnEo2hQBEQp2t
	+kCdlqY23PBWsuVVXMHPE8zNqYAVAU6PaKnENXcOo8fpyNUk8T5WTwEVGHJeON1sNd7Lm3L+M9t
	gcfyvz6ufjZndJyyneyA9qCs1qw55r/leL5r+IiL+jMOIDIpIRgPhIqugCzfzPGsfJHKY3wjRPn
	CVYZWYrpqk3Je
X-Received: by 2002:a05:7300:c01c:10b0:36a:50ec:db3f with SMTP id 5a478bee46e88-36a50ecdd21mr22929780eec.7.1793785817978;
        Wed, 04 Nov 2026 01:50:17 -0800 (PST)
Received: from [127.0.1.1] ([23.247.137.158])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca362f38asm7068083eec.0.2026.11.04.01.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:50:17 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
Date: Wed, 04 Nov 2026 17:50:01 +0800
Subject: [PATCH] iio: buffer: hold a reference while DMA-BUF is attached
Message-ID: <179378580164.73301.2666197876060323279@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 paul@crapouillou.net, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list

iio_buffer_attach_dmabuf() stores an IIO buffer pointer in the DMA-BUF
attachment without taking a buffer reference. A delayed DMA fence
completion can release the attachment after the IIO device has been
unbound and its buffer freed. The release callback then dereferences
the stale buffer while detaching the DMA-BUF.

Take a reference when storing the buffer in the attachment, and drop
it after the final detach or when the attach operation fails. This
keeps the buffer alive for the asynchronous completion path.

A KASAN-enabled test with a DMA-BUF-capable IIO test device reproduced
the use-after-free on the unmodified kernel. The same delayed
completion sequence produced no report with the change applied.

Fixes: 3e26d9f08fbe0 ("iio: core: Add new DMABUF interface infrastructure")
Assisted-by: ZCode:GLM-4
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
 drivers/iio/industrialio-buffer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 4294101810fd7..bfa6d19471126 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1597,6 +1597,8 @@ static void iio_buffer_dmabuf_release(struct kref *ref)
 
 	buffer->access->detach_dmabuf(buffer, priv->block);
 
+	iio_buffer_put(buffer);
+
 	dma_buf_detach(attach->dmabuf, attach);
 	dma_buf_put(dmabuf);
 	kfree(priv);
@@ -1741,7 +1743,13 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
 	}
 
 	kref_init(&priv->ref);
-	priv->buffer = buffer;
+	/*
+	 * Hold a reference for the asynchronous dmabuf completion path
+	 * (iio_buffer_cleanup() -> iio_buffer_dmabuf_put() may run from a
+	 * work item after the device has been unbound); released in
+	 * iio_buffer_dmabuf_release().
+	 */
+	priv->buffer = iio_buffer_get(buffer);
 	priv->attach = attach;
 	attach->importer_priv = priv;
 
@@ -1789,6 +1797,7 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
 err_dmabuf_put:
 	dma_buf_put(dmabuf);
 err_free_priv:
+	iio_buffer_put(priv->buffer);
 	kfree(priv);
 
 	return err;
-- 
2.34.1

