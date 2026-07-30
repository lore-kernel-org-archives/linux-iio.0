Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3277431A3D;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421575; cv=none; b=bG9hlOBGZNbJ8TuiGl30MYwl4biABZQLKa+pJRpeGV7g2D/UUTSDK0wh93B3KY51jRIz63OjcIYSY0Dc216yaoXHyR2cgmZYJXmXWsCoUQi25bvoLUN2JRsnQqvyudf8napLY5vW8YxQtnSZRQwEeUJ1i3Kg5kOmnUB91pVbfb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421575; c=relaxed/simple;
	bh=8eLDnSsrFoObu1phrD3ek+MlSTDcuUW8I9hthmDzL+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mg9/u175s3aNyZIGkAHUmXYJYv9fY4UGChMTBzCTMxYHDMT116hlxCofMYJqM8HgWDqJRQptXCLIvBI9tZlJj2i2CHHQO18JyRlO7KuMLSSvdx8i8jXXcRSN2fsXaXF1S6O7XijpJklz+DQKgZ6D45hpZkiXqI/YuTCIP9u8aek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NogRhEYm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NogRhEYm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB28BC2BCFC;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785421574;
	bh=8eLDnSsrFoObu1phrD3ek+MlSTDcuUW8I9hthmDzL+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NogRhEYmgz0cY+L9eYA8xwCp+STHko0etUZwkUHBWqMKFrY6vDe5PjXFihsJmyA4o
	 qYzToEWc5m0d1rNjU+lcDpSqUsosKGV1yiKNupdhRwz/XHciY47nSICl9HgqQ+JghX
	 7WiqtvAebqvARUYE9HbiQAcqK7mh8M2X07IYgWBKZK8eLC+uHHbyfj8sNHBVHhJ0th
	 EPNwwfyRFKr/rJUZFIqfu1j2aBV7T3ViuZcizGKTG0kO4BMXYrPKMLflB8TY+pWo/e
	 USzi77uquC3I86FSb3et13n090wRT+fJJEYfiHkdfk3Bmec/JH6KxnmxJVfSm94Avv
	 27GJVbwQ5+YOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92937C55162;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 30 Jul 2026 15:23:10 +0100
Subject: [PATCH 3/9] dmaengine: dw-axi-dmac: Use bus width capability
 helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260730-dmaengine-support-wider-dma-masks-v1-3-3732f1f9d9ca@analog.com>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
In-Reply-To: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785421644; l=2812;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=CtfHeTPL3l5ggGTnR3rIf2HlipCZ085z2sQ79xZ6AtY=;
 b=JZ8iLx26tMe/HvMy975D47ENZY+mO7yPH3XZf4a9Z3KKuPCbuR3B9Ct2NUyy77VE1fnv7w2Ue
 kS26PMZvBzjABWePerSGbwOSuUkV6NG14mC1Ryvu9i+jjaLGBqLrKK1
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Advertise the supported bus widths through dma_set_src_bus_widths()
and dma_set_dst_bus_widths() instead of assigning the legacy u32 masks
directly. This keeps the driver using the new bitmap representation
while preserving legacy fields during the transition.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 39 +++++++++++++++-----------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index bcefaff03b5c..69cac7e3625f 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -33,20 +33,6 @@
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
-/*
- * The set of bus widths supported by the DMA controller. DW AXI DMAC supports
- * master data bus width up to 512 bits (for both AXI master interfaces), but
- * it depends on IP block configuration.
- */
-#define AXI_DMA_BUSWIDTHS		  \
-	(DMA_SLAVE_BUSWIDTH_1_BYTE	| \
-	DMA_SLAVE_BUSWIDTH_2_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_4_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_8_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_16_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_32_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_64_BYTES)
-
 #define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
 #define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
 #define AXI_DMA_FLAG_USE_CFG2		BIT(2)
@@ -1482,6 +1468,20 @@ static int dw_probe(struct platform_device *pdev)
 	unsigned int flags;
 	u32 i;
 	int ret;
+	/*
+	 * The set of bus widths supported by the DMA controller. DW AXI DMAC
+	 * supports master data bus width up to 512 bits (for both AXI master
+	 * interfaces), but it depends on IP block configuration.
+	 */
+	enum dma_slave_buswidth axi_dma_buswidths[] = {
+		DMA_SLAVE_BUSWIDTH_1_BYTE,
+		DMA_SLAVE_BUSWIDTH_2_BYTES,
+		DMA_SLAVE_BUSWIDTH_4_BYTES,
+		DMA_SLAVE_BUSWIDTH_8_BYTES,
+		DMA_SLAVE_BUSWIDTH_16_BYTES,
+		DMA_SLAVE_BUSWIDTH_32_BYTES,
+		DMA_SLAVE_BUSWIDTH_64_BYTES,
+	};
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -1565,8 +1565,15 @@ static int dw_probe(struct platform_device *pdev)
 
 	/* DMA capabilities */
 	dw->dma.max_burst = hdata->axi_rw_burst_len;
-	dw->dma.src_addr_widths = AXI_DMA_BUSWIDTHS;
-	dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
+	ret = dma_set_src_bus_widths(&dw->dma, axi_dma_buswidths,
+				     ARRAY_SIZE(axi_dma_buswidths));
+	if (ret)
+		return ret;
+
+	ret = dma_set_dst_bus_widths(&dw->dma, axi_dma_buswidths,
+				     ARRAY_SIZE(axi_dma_buswidths));
+	if (ret)
+		return ret;
 	dw->dma.directions = BIT(DMA_MEM_TO_MEM);
 	dw->dma.directions |= BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
 	dw->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;

-- 
2.55.0


