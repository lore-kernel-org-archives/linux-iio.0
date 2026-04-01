Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7436F36AB5E
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057133; cv=none; b=JPPgrbFpV4u74cre9YcJTnKNuvI/t8rb8xKbUf09tIgpi7NlpD8LGzyu4U+1LzXOBGHTWY+Bs9v7XQ3ao01rCfbzYsmlXkDkl9jYVj+eUxX10eaoJ8+j2cjVWsRV3UB7j2UzbQlkvcoxIYhEBukQjyH1jl17RuZ2OeisfP/obT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057133; c=relaxed/simple;
	bh=SRw5GADO3IOoyzHSN3n1koW1j26645CVh4z99hWUrxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W1yO5uxE79EZf9mbfWIa+uWRs4Fu7BlAqL4SXSe24CfLqFnLJH+f5b6sNbu6jtMOkrhUMqZsQyQ/DobtWhTO4Q9NbhgoAAvpmd92fZUSHGEfJfX1tHzguhXXijZopfy6QrJwL0M81W1LkwQ3tMZ3J97bGcGAbGlwf7paHiHBIhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PrKCaGmZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PrKCaGmZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0B3F61A309F;
	Wed,  1 Apr 2026 15:25:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CCD24602BF;
	Wed,  1 Apr 2026 15:25:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B07710450346;
	Wed,  1 Apr 2026 17:25:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775057128; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=/E0rCk8Mn+Lt+NuMlf3Rt8SdSgB7FbxJcFreMo15xpE=;
	b=PrKCaGmZDE3xCt1GYg2FsjEH5BTK6efWLMV1+IofrDELAL3iiYPEk7dU2iYECiNm6uOPeH
	h8gXB5wbWHfkMdNmMxInTnEB/WeLgZYYLZ05NjwVws5ensLinPOxF6leE/W3f8jA9191u4
	S6WhMDv99IuOl8wTLF/4iGEbu50lYooxMcoEHXdJE5WluxLDctwNsLdSLW6kxC8ookLUw6
	wks+/8PHc6JACazqknNyIiIi4QEbG0YCqgCVyuYLnWQsidkOl4iw+06y/80ukFaxiRT9lW
	zrf6FBIzmJVouCTrRetho6ECiH9Jut23efQOO1kZ7l4NTwJo97GhnMGu1JC6Fw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Wed, 01 Apr 2026 17:24:58 +0200
Subject: [PATCH] iio: buffer: Fix DMA fence leak in
 iio_buffer_enqueue_dmabuf()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260401-iio-dma-fence-v1-1-40993adbfa96@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAMk4zWkC/yXMQQqDMBBG4avIrB3IiHbhVUoXMfljR2gsSSuCe
 HejLr/FextlJEWmvtooYdGscyyQuiL3tnEEqy+mxjQP0xph1Zn9x3JAdOAuiMNgRRA6Ks03Ieh
 6/Z6v2/k/THC/c0L7fgBwPJUVcQAAAA==
X-Change-ID: 20260401-iio-dma-fence-5f1ceba11ef5
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Paul Cercueil <paul@crapouillou.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Nuss <jamesnuss@nanometrics.ca>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.15.1
X-Last-TLS-Session-Version: TLSv1.3

iio_buffer_enqueue_dmabuf() allocates a struct iio_dma_fence (104 bytes,
kmalloc-128) via kmalloc_obj()+dma_fence_init(), which sets the initial
kref to 1.  It then calls dma_resv_add_fence() which takes a second
reference (kref=2), and stores a raw pointer in block->fence.

On the success path the function returns without calling dma_fence_put()
to release the initial reference, so every buffer enqueue permanently
leaks one kmalloc-128 allocation.

The iio_buffer_cleanup() work item only releases the temporary reference
taken during completion signalling by iio_buffer_signal_dmabuf_done();
the initial reference from dma_fence_init() is never released.

With four iio_rwdev instances at 240kHz and 512 samples per buffer,
this produces ~1875 kmalloc-128 allocations per second matching the
observed slab growth exactly. A test with ftrace confirmed that the
dma_fence_destroy event was never triggered.

Fix by calling dma_fence_put() after dma_resv_add_fence(), transferring
ownership of the fence to the DMA reservation object. The DMA fence then
gets properly discarded after being signalled.

Fixes: 3e26d9f08fbe0 ("iio: core: Add new DMABUF interface infrastructure")
Originally-by: James Nuss <jamesnuss@nanometrics.ca>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/iio/industrialio-buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 46f36a6ed271..5c3df993bea2 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1909,6 +1909,7 @@ static int iio_buffer_enqueue_dmabuf(struct iio_dev_buffer_pair *ib,
 
 	dma_resv_add_fence(dmabuf->resv, &fence->base,
 			   dma_to_ram ? DMA_RESV_USAGE_WRITE : DMA_RESV_USAGE_READ);
+	dma_fence_put(&fence->base);
 	dma_resv_unlock(dmabuf->resv);
 
 	cookie = dma_fence_begin_signalling();

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260401-iio-dma-fence-5f1ceba11ef5

Best regards,
--  
Benoît Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

