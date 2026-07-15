Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533E3CF212
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114697; cv=none; b=WIBWsPb6JAo+y7SfSvOP6rM0NkKQFwY8jdzoo01qEoR9Ec76Jn1HdNpK+MHPUECAqRiBWswJqKMD/R450mSHs02kGU8k1TFAVtta9JpPw6LRwrcLhN72ZCHuEOsFvaNbCG3bvwtL1gMTqubave6O278mAfJXbSBZAQ24NidtgDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114697; c=relaxed/simple;
	bh=hCrW/Dv6FJNsxjMykWEld2019VKb/9YWyYT8Xvk5Rgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cv8BX7X0PFK71RWtjgToRUj72GxSNk/466sRWUgjMtv/qK687mB/8pk7DX3OOs3aOcH+iD5Hf5fzrf0RYAtnQu169CxvAbsFuv+6IIy6O6Kbi7rb5nLY+e0pFLmIq8clXmn6TyBuDqaEzARL4C1hxT1qgwhoGB4/MNkxJLksiE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAal7bAu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAal7bAu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B68A5C2BCB7;
	Wed, 15 Jul 2026 11:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784114696;
	bh=hCrW/Dv6FJNsxjMykWEld2019VKb/9YWyYT8Xvk5Rgo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=kAal7bAu+eszPxPRePxG3v8JmUCTPEiPqAuBtYjhhtYIzfwXc+O0GGJXQLuuOUSeD
	 Wd3+PVUc3UNsrB8NZXXJLqmh+rojAkbkygRvfqjAFUFh+2OFFmlNiXOzoMCcHm948h
	 okqnWmo6XM6MwfOwxSOmAhiUpR6Pw/dQBGx+I1gegaYDvjirruuT9kVXK4FImCTOX+
	 gAHyrHi5clRyLR3VFSO0+78BpghkKbfPKjaUaZ8ld9aNecFyknr3a9sRUvd3KmrAMk
	 +CFJ22f9C0YstM3HfD73CfI5K7S4+F2TC46A9s/XfqYtBowbrZyuAcR7ojXW2EdKcc
	 qZKeozgrhd23A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F62C44507;
	Wed, 15 Jul 2026 11:24:56 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 15 Jul 2026 13:24:53 +0200
Subject: [PATCH v2] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260715-iio-dma-cyclic-v2-1-268a3a28ff84@analog.com>
X-B4-Tracking: v=1; b=H4sIAARuV2oC/x3MMQqAMAxA0atIZgM1iAWvIg4ljRrQVloQRXp3i
 +Mb/n8hS1LJMDYvJLk0awwV1DbAmwuroPpqIEODsV2PqhH94ZAf3pXRkPPWMjH3Bmp0Jln0/of
 TXMoH+FQcMWAAAAA=
X-Change-ID: 20260714-iio-dma-cyclic-02ad77c2cc40
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.15-dev-52d38
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784114695; l=4101;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=h1rRMQmOttcGtDUJBsj6Y7Srh7vH59QdLhE14FvpwAY=;
 b=e/ZqMawUYSHQVv0VUyVqjyOddHRt7/VQ1Rp9pGm3ujx55M+VB8g9ceJ7JrWlbyMsZ03Jl5m5G
 cNYLjGPgfKSA9VJtik5rbR//N2ou5daLKeQsrbeMXo+t5HzwLkmhICU
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Allow buffer blocks flagged as cyclic to be submitted as repeating DMA
transfers. For cyclic blocks, use DMA_PREP_REPEAT so the engine keeps
replaying the descriptor.

This is useful for output buffers where the same data should be driven
continuously without userspace having to requeue it. Examples include
continuous RF transmit paths replaying a calibration, test or beacon
pattern.

Skip installing the completion callback for cyclic blocks. Since the
transfer is continuously replayed, the callback would fire on every
period, throwing off the block refcount.

Because nothing prevents a new cyclic transfer from replacing an
already active cyclic one, always set DMA_PREP_LOAD_EOT so the engine
correctly terminates the active transfer before loading the new
descriptor.

Limit the DMA buffer queue to one cyclic DMABUF at a time. There is
currently no known use case for queueing multiple cyclic blocks, and
cyclic blocks stay referenced until the buffer is disabled.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Changes in v2:
* Improved commit message for usecase;
* Safety cap cyclic transfers to one  (see v1 for context).
* Link to v1: https://lore.kernel.org/linux-iio/20260611-iio-dma-cyclic-buffer-support-v1-1-bcf00e8d802c@analog.com/
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 41 ++++++++++++++++++++--
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 98acce909854..639bac135539 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -56,6 +56,23 @@ static void iio_dmaengine_buffer_block_done(void *data,
 	iio_dma_buffer_block_done(block);
 }
 
+/*
+ * Cyclic transfers run until abort. Cap active cyclic blocks to one until there
+ * is a use case for more.
+ */
+static bool iio_dmaengine_buffer_has_active_cyclic(struct dmaengine_buffer *dmaengine_buffer)
+{
+	struct iio_dma_buffer_block *block;
+
+	guard(spinlock_irqsave)(&dmaengine_buffer->queue.list_lock);
+	list_for_each_entry(block, &dmaengine_buffer->active, head) {
+		if (block->cyclic)
+			return true;
+	}
+
+	return false;
+}
+
 static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 					     struct iio_dma_buffer_block *block)
 {
@@ -79,7 +96,14 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 	else
 		dma_dir = DMA_MEM_TO_DEV;
 
+	if (block->cyclic && iio_dmaengine_buffer_has_active_cyclic(dmaengine_buffer)) {
+		dev_err(queue->dev, "cyclic DMA transfer already active\n");
+		return -EBUSY;
+	}
+
 	if (block->sg_table) {
+		unsigned long flags;
+
 		sgl = block->sg_table->sgl;
 		nents = sg_nents_for_len(sgl, block->bytes_used);
 		if (nents < 0)
@@ -99,9 +123,18 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 			sgl = sg_next(sgl);
 		}
 
+		if (block->cyclic)
+			flags = DMA_PREP_REPEAT;
+		else
+			flags = DMA_PREP_INTERRUPT;
+
+		/*
+		 * A new transfer may need to end an already active cyclic transfer
+		 * before it can run, so always set the EOT flag.
+		 */
 		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
 							 vecs, nents, dma_dir,
-							 DMA_PREP_INTERRUPT);
+							 flags | DMA_PREP_LOAD_EOT);
 		kfree(vecs);
 	} else {
 		max_size = min(block->size, dmaengine_buffer->max_size);
@@ -122,8 +155,10 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 	if (!desc)
 		return -ENOMEM;
 
-	desc->callback_result = iio_dmaengine_buffer_block_done;
-	desc->callback_param = block;
+	if (!block->cyclic) {
+		desc->callback_result = iio_dmaengine_buffer_block_done;
+		desc->callback_param = block;
+	}
 
 	cookie = dmaengine_submit(desc);
 	if (dma_submit_error(cookie))

---
base-commit: aa58ecc73466d0cb8c418de98e2225490bf600e3
change-id: 20260714-iio-dma-cyclic-02ad77c2cc40
--

Thanks!
- Nuno Sá


