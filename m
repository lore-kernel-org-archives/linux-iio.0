Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E315E413D8F;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421575; cv=none; b=FSv8i6MoEfZquCq4MdA97nt8vpUE0SwzxoxQdu/nA03mJ9UjbDiaIdr+Xi1FEVfhN510DnHt9Ft4IPXOP3aUXvTLT+bz9vlAzvt8SE+LEfPMKLNWVErnviRMpxI1xV7po9m7emw6Q8itDDcb4iY5kboPLhhobd23ik5Yo3mtyOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421575; c=relaxed/simple;
	bh=oXxOL+Jaq4b5OT+39yLZ8jJS2sv7ofIGT50m387iTMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pe5GCM+0l4E3cybuU+xn/UjCeb5rE7k0BT0SF6r5/d7j5HO7zQnN0Ry2WOCSLDUPdBwbpZvvOtc9s/Z9EOtWUMQhkISw4uQwRRSNK4v3XQtqJafPzd8E/phiIWisIYb1pgnEUv8gFY1RPW78Q6zgu8tB9r+q0YaT3vXEzBDBaV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpejnSlU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpejnSlU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C84BC2BCF7;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785421574;
	bh=oXxOL+Jaq4b5OT+39yLZ8jJS2sv7ofIGT50m387iTMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TpejnSlUedhNhBCyd/rqDO73AAkkzuzFHSe58EgtMNQVhap28cghePRLi7L0q0Ca+
	 CwAbmLVpgRPA7Oj5m1CqiEz13OBzBz7nSg9nfsfEnmYRzjZ6JZ9YWkK+WP4LNSM+Tj
	 STSIfp0AqXKSFqqTFi2VHDtuDsK1Srv62AU9aYA/LfdprG0k8jpsnBgesFppMOA66y
	 QGPyTlQe714Vc0cDQabh4z5rh9R/SzNHpCUhe7s1xt37Q8GJUfYGGtrzCXAWRjp8qQ
	 kF4RGypixBZWQuDPjM+u4OfGP1hZTumxU0NEKC0/Z0k2cvuJ2J687yiDwZk4amyRbl
	 axqCQtBHuQkVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F60CC55167;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 30 Jul 2026 15:23:09 +0100
Subject: [PATCH 2/9] dmaengine: dma-axi-dmac: Use bus width capability
 helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260730-dmaengine-support-wider-dma-masks-v1-2-3732f1f9d9ca@analog.com>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
In-Reply-To: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785421644; l=1775;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Txyotztee4S7xByVBUq+B8C7FRRwoyJEz0zwGOLefOI=;
 b=Slps3CuudlGcc77f8ylxIijEbhRMHRZisX8r6i+/H5XfAuJdI1RaCvk1ZZ12pY0B4F1/eUunI
 hklWEx5QLi7B3y3o2rhgVPPNvgz+vsjhyBGrm9PK4ZDrDPEgyRwGQxy
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Advertise the source and destination bus widths through the new
dma_set_{src,dst}_bus_width() helpers instead of open-coding the legacy
BIT() mask. This moves the driver onto the representation that can
express widths of 32 bytes and above while keeping the legacy u32 fields
populated during the transition.

While at it, give the channel width members their proper
enum dma_slave_buswidth type.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index d47ff27e1408..26912330e3c8 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -152,8 +152,8 @@ struct axi_dmac_chan {
 	struct list_head active_descs;
 	enum dma_transfer_direction direction;
 
-	unsigned int src_width;
-	unsigned int dest_width;
+	enum dma_slave_buswidth src_width;
+	enum dma_slave_buswidth dest_width;
 	unsigned int src_type;
 	unsigned int dest_type;
 
@@ -1262,8 +1262,13 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dma_dev->device_terminate_all = axi_dmac_terminate_all;
 	dma_dev->device_synchronize = axi_dmac_synchronize;
 	dma_dev->dev = &pdev->dev;
-	dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
-	dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
+	ret = dma_set_src_bus_width(dma_dev, dmac->chan.src_width);
+	if (ret)
+		return ret;
+
+	ret = dma_set_dst_bus_width(dma_dev, dmac->chan.dest_width);
+	if (ret)
+		return ret;
 	dma_dev->directions = BIT(dmac->chan.direction);
 	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 	dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */

-- 
2.55.0


