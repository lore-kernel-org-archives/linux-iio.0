Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117960;
	b=ms+0WQldvcuXBeJUSu32TKPo8kjURcE9EljJ4PV9MiwjJYZsGOkV0lUMqQnmtJ96YNXV
	 iWp3buuZP+o8qTZbqG2ouaIr++5y3XIMhjEkE5lpylnIMoWeFPsgn1ar+TkK2fRvWiNPl
	 0xsy1m4EZo7NcdBAWR4vHy0Q9emYqOdB4nCAAfa65FYBjnPkq1rqcdyAN/cQ0Bpo6F3Y+
	 xKjq7eQ+OlzVe6NauFtfs+taosR9eFLNtDnuawZqn8TIN/EYpy7g8DfwhhBo5HV74zr0k
	 +Z+m+/76DToFYwEPtzgA2sumai2aJWPdXTjgm7YUCRZbWlmaYBX01tH+sVBC3xZslxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117960;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/wLPb9PfAFAy2ZbQqw47GmjjeAH0wYB/Gm2STHbMAyo=;
	b=yICMmv3T5LQR7KdkBfw7uvwGcGZxLEsTqRr5gi5LfPMOWPK686tIC0L9Kn3Acj+Eog1s
	 LvOjdzsluSKPv5WmrhMoTs0QpX+7DXUYTQ74cHpNeWjezQ4gMpUswBuzh7W+YVRMRkArl
	 LGSBvJxbEFu3hJ1PJKDeHKl4pMC0SJ/BR02psuL2n1Mca+iS3fOrLW0hba3ovSLUncL+c
	 9X50791Qspv7td3rMY1ZloZEq2fxmU5Mp371MxPKBjjabWdzZcbcu7Y0kNOfZtT6mID7r
	 edkk8kNXwA0HQn9PnJTyvKI7QS/0mWv/SqRaCMfcFao3dgJGh5wyyCOhwGU48JrUcVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fvPmirpR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77CA606A32F;
	Tue, 27 Oct 2026 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=fvPmirpR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDC41F01825;
	Tue, 27 Oct 2026 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793117959;
	bh=/wLPb9PfAFAy2ZbQqw47GmjjeAH0wYB/Gm2STHbMAyo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fvPmirpRhxTLs11cQ+Z8DHe97ysLxOGXVW021exqKe7eL9keCsph/d0Q3VfoF2zvL
	 B36XipRTqVGPbG7UpgxSY/st/t5gocPJ50kNhgjVrOFR1SM3QSTHBe8mHxTWrrqDtb
	 eovo5/DeAYBeY3J6I3C0U89BC5quVBjf6TJev8Y4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 17:19:05 +0100
Subject: [PATCH 01/15] iio: buffer: let the block keep its DMA fence
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-llm-char-misc-iio-v1-1-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
In-Reply-To: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Paul Cercueil <paul@crapouillou.net>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=3272;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=04EnRnuQyvsC83Md9scsmp4FsWr/PThr0g/22Jd9nDI=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPzjPNr9jvniCzVPNeOtetW9dXPqw12XI4+Nbe4r2JG
 ZneN3+/6ohlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJXORmWDDnxyLRbIY9nkG9
 JyvL1RTlU85232BYsFsgsDu3wd3v92KrfVuVb++Wq75uAwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

iio_buffer_enqueue_dmabuf() hands a plain pointer to the fence to the
buffer implementation, which keeps it in block->fence, and since the fix
for the fence leak it drops the initial reference right after
dma_resv_add_fence(). The only reference left is the one of the
reservation object.

That one does not last until the fence is signalled. dma_resv_add_fence()
replaces and puts a fence as soon as a later fence of the same context and
the same usage is added. All the fences of an attachment share a context,
and an enqueue on an output buffer only waits for the writers, not for the
read fence of the enqueue before it. A second IIO_BUFFER_DMABUF_ENQUEUE of
a buffer which is still queued is refused by iio_dma_can_enqueue_block(),
but by then its fence has taken the place of the first one. When the DMA
is done, iio_buffer_signal_dmabuf_done() signals a fence which has been
freed and schedules the work item in it.

The leak came from the reference which iio_buffer_signal_dmabuf_done()
takes and iio_buffer_cleanup() drops: with it nobody dropped the initial
one. Do not take it, and leave the initial reference to the block until
the cleanup.

Fixes: a09399935508 ("iio: buffer: Fix DMA fence leak in iio_buffer_enqueue_dmabuf()")
Cc: stable <stable@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: "Benoît Monin" <benoit.monin@bootlin.com>
Cc: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/industrialio-buffer.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 4294101810fd..a2386dba497c 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1931,9 +1931,14 @@ static int iio_buffer_enqueue_dmabuf(struct iio_dev_buffer_pair *ib,
 	if (ret)
 		goto err_queue_unlock;
 
+	/*
+	 * The reservation object takes a reference of its own, and drops it as
+	 * soon as a later fence of this attachment takes the place of this
+	 * one. The initial reference stays with the block, which points to the
+	 * fence until iio_buffer_cleanup() has run.
+	 */
 	dma_resv_add_fence(dmabuf->resv, &fence->base,
 			   dma_to_ram ? DMA_RESV_USAGE_WRITE : DMA_RESV_USAGE_READ);
-	dma_fence_put(&fence->base);
 	dma_resv_unlock(dmabuf->resv);
 
 	cookie = dma_fence_begin_signalling();
@@ -1989,18 +1994,12 @@ void iio_buffer_signal_dmabuf_done(struct dma_fence *fence, int ret)
 		container_of(fence, struct iio_dma_fence, base);
 	bool cookie = dma_fence_begin_signalling();
 
-	/*
-	 * Get a reference to the fence, so that it's not freed as soon as
-	 * it's signaled.
-	 */
-	dma_fence_get(fence);
-
 	fence->error = ret;
 	dma_fence_signal(fence);
 	dma_fence_end_signalling(cookie);
 
 	/*
-	 * The fence will be unref'd in iio_buffer_cleanup.
+	 * The reference of the block will be dropped in iio_buffer_cleanup.
 	 * It can't be done here, as the unref functions might try to lock the
 	 * resv object, which can deadlock.
 	 */

-- 
2.56.0

