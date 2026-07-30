Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4109343E4BA;
	Thu, 30 Jul 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421575; cv=none; b=R3KsWBSDlCIJye7VwpqFrQs4hidK+dHpB+wRmInASk1KTbuC7qc6zysrMZTOVP8VpM3Jb4IqxpVQPsUQVZeIMbOAFFuInm5cXa21UEDQaxuE9t1S1nU9VIHt+3XguAVf3mD29oDYHZF2DzGxeKEjUyP7fAqpBDvBQP944MtUgxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421575; c=relaxed/simple;
	bh=WJdEBf6sTD0QgzIHsTE1L9mzK/q55x9OzWifGRQlJOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bS2MxzUwJkWQD/TlwA9cFDubq8F3NiaRQhyby6alqMOQZ09TOCK4zsAAT4c12pH1C/ydwYpGps7Ma4CbbJqZecjHCR7VXcWKoHikmd1ZE2oG9YB35Egm2yIoMPegnFFBK8lU8Bf3B7G8DQfwGZRXc6niTWSDfDg64o20alnVtro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMlqhw7p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMlqhw7p"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9FC7C2BD05;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785421574;
	bh=WJdEBf6sTD0QgzIHsTE1L9mzK/q55x9OzWifGRQlJOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lMlqhw7ptz5PSjqYQAGUZ4uF5Gp3VLnSmFc/G+GZyir7OwG2iE7xdMVhTUonu8d40
	 HyVTszA4HEd67oGG8zGIno92MmkTo6jaM3onywKaHYUiQPBgFsEaXIUu2SPSeGkRWj
	 un8LezXhb1rIyrGO20VO/iIBC4o/p254rJwiUlzT+UqjzDcEUPJwFOp57g3jNvWQRh
	 19FJCv+cIxRtRrEcVJ65yDUHSh4uFjtpGcYcqTDyL9CxzwcR8msHg6AVT2E7DkAcn3
	 O+BgPHCfcOMoRtuBhgoDAc5MGWwUnZK1e5g1X0dV8408Abpb1e1bP+37ARu9moJYur
	 zSLGso63j/KxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA360C55167;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 30 Jul 2026 15:23:13 +0100
Subject: [PATCH 6/9] iio: buffer-dmaengine: Use dma_slave_caps bus width
 accessors
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260730-dmaengine-support-wider-dma-masks-v1-6-3732f1f9d9ca@analog.com>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
In-Reply-To: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785421644; l=1553;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JvMCDDYBnfyjKcLChBKWpQIo1PWEIQSo/otzGS4zHaw=;
 b=aAGuVxTk2Z5WizW2pcrAAWRDjddWOAymTX4rQ60Rdl1x4O003mYkk0+HUF9QGSW60b8VGJVIN
 DvySoI/kB7nDvZEM3Sh2DFL7MaLOJVj3l5fjRFMDZ1IFJj1X+lW325I
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Query the minimum supported source and destination bus widths through
the new dma_slave_caps_get_{src,dst}_width_min() helpers rather than
decoding the raw legacy u32 width masks. This keeps the buffer working
with DMA controllers that advertise bus widths via the new bitmap
representation.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 98acce909854..855e3662cd3d 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -229,14 +229,13 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct dma_chan *chan)
 		return ERR_PTR(-ENOMEM);
 
 	/* Needs to be aligned to the maximum of the minimums */
-	if (caps.src_addr_widths)
-		src_width = __ffs(caps.src_addr_widths);
-	else
-		src_width = 1;
-	if (caps.dst_addr_widths)
-		dest_width = __ffs(caps.dst_addr_widths);
-	else
-		dest_width = 1;
+	src_width = dma_slave_caps_get_src_width_min(&caps);
+	if (src_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		src_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dest_width = dma_slave_caps_get_dst_width_min(&caps);
+	if (dest_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		dest_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+
 	width = max(src_width, dest_width);
 
 	INIT_LIST_HEAD(&dmaengine_buffer->active);

-- 
2.55.0


