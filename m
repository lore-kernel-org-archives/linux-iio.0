Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1E43DA5C;
	Thu, 30 Jul 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421575; cv=none; b=XHtN0R5BCs8i1uU0wQfdRrnDVX7dAx7zs+RrgA264ZY96+4YnrXk9HsjvzAAxHPY3EIKGIMOza+viPNlu9tvJdtuz08GICRpxLQUMbmuhJvA0DeIggcJ0nEx9F7OSVhceSuxDRRUf9Q3BsI26hBrUExd+Y06WJfvjE4qEmHoNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421575; c=relaxed/simple;
	bh=Wjc10zsvUaobD0rqNHgGPX1Q9pasWT6FecRa/87WNOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lA1w935Yg3aWTNvlFb00fiRBmfnhvcEBhhjzr7m3MuRIHWbtlZlcgnwOl5E8JIauIE7D+qS3lc0Yc0pkk/ItuVM35Kwmqf6t3z54BJgwXWrRFDVjq3ayrWlLtxW00twai+VU9pEn4CoCJtO9W6WU/XwJQwKd4E1Zb3Xw82g1aLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjWrFOiI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjWrFOiI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB821C2BCFA;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785421574;
	bh=Wjc10zsvUaobD0rqNHgGPX1Q9pasWT6FecRa/87WNOY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bjWrFOiIs2857M5+7T5B/B/swql32pfL1ij9GsCq8k/wPgG1i7G28QEeUn/Y4mC7a
	 rg6/49hgO5a8i4YQZ9T5DIXy+RDj2hkVgOY8id+RyF95tt0xx9XwcmtF7FtsS7Dg3s
	 gnGBs11BsRq3iRBakBV1HORn4bF/NtV7N/qJHyuLtNHGL3ORQ4SrK5xj2QS4V0OIG3
	 aYSSzNqp4NtLb0fErFHBAEC907QZrHObXGupuEsV7o7aaMW28XE0a2db7VvWjR5nmn
	 MfnTZnztUh/cxPnec5kYGKP9jvR/TWaC/Bg3rlVwgoU8L5FAxR9g7kBMdN2Zh9hpWR
	 7HMJrakt/kbPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DFCC55160;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 30 Jul 2026 15:23:12 +0100
Subject: [PATCH 5/9] dmaengine: stm32-dma3: Use bus width capability
 helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260730-dmaengine-support-wider-dma-masks-v1-5-3732f1f9d9ca@analog.com>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
In-Reply-To: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785421644; l=3022;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=SrN6pXKgJjq+fgxX4MgjxgcirodN9CnJGtz7jAOK/OY=;
 b=v7caWRFl4Ub8kTpVPnVN/3TThYbAzokjyKWpzDqQCyK7xAwJjpqxiGaiKfESL94wMGOw/18kz
 O9qO6GDTCiSAwD6hXFdCOLS0DvJfa3womydBE4ZQOEoGPHQ0agwD24u
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Advertise the controller-wide bus width capabilities through the new
dma_set_src_bus_widths() and dma_set_dst_bus_widths() helpers.

Also update the per-channel capability callback to clear unsupported
widths through the dma_slave_caps helpers so the bitmap and
transitional legacy fields stay in sync.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/stm32/stm32-dma3.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 4724e7fa0008..b0365a5b341d 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1469,14 +1469,14 @@ static void stm32_dma3_caps(struct dma_chan *c, struct dma_slave_caps *caps)
 
 	if (!chan->fifo_size) {
 		caps->max_burst = 0;
-		caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-		caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+		dma_slave_caps_clear_src_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
+		dma_slave_caps_clear_dst_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
 	} else {
 		/* Burst transfer should not exceed half of the fifo size */
 		caps->max_burst = chan->max_burst;
 		if (caps->max_burst < DMA_SLAVE_BUSWIDTH_8_BYTES) {
-			caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-			caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+			dma_slave_caps_clear_src_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
+			dma_slave_caps_clear_dst_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
 		}
 	}
 }
@@ -1737,6 +1737,12 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	u32 master_ports, chan_reserved, i, verr;
 	u64 hwcfgr;
 	int ret;
+	enum dma_slave_buswidth stm32_dma3_buswidths[] = {
+		DMA_SLAVE_BUSWIDTH_1_BYTE,
+		DMA_SLAVE_BUSWIDTH_2_BYTES,
+		DMA_SLAVE_BUSWIDTH_4_BYTES,
+		DMA_SLAVE_BUSWIDTH_8_BYTES,
+	};
 
 	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
@@ -1775,14 +1781,16 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	 * channel, and can only access address at even boundaries, multiple of the buswidth.
 	 */
 	dma_dev->copy_align = DMAENGINE_ALIGN_8_BYTES;
-	dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+	ret = dma_set_src_bus_widths(dma_dev, stm32_dma3_buswidths,
+				     ARRAY_SIZE(stm32_dma3_buswidths));
+	if (ret)
+		return ret;
+
+	ret = dma_set_dst_bus_widths(dma_dev, stm32_dma3_buswidths,
+				     ARRAY_SIZE(stm32_dma3_buswidths));
+	if (ret)
+		return ret;
+
 	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) | BIT(DMA_MEM_TO_MEM);
 
 	dma_dev->descriptor_reuse = true;

-- 
2.55.0


