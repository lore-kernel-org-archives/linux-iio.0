Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB8432E65;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421575; cv=none; b=U/sXufS2Rlz7aUfHsIhh84j3SlKpi5WHoHjGHYpxaZi1I8B8Q5a6JGeaz0eb8Qw+RgIUBa39AzV2u/5DtkVe0jcsehDKtYeeMlofHUCxkGTwm7RoqIYPG0H7li8rvTjtx7f+oKICDPr9ubMWNp2u761ySV3jJFbIpliL+/zoTp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421575; c=relaxed/simple;
	bh=pVWG0d2CH+hymp8PpAipS7Eom7czTchJR3IlmtQAX24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e1x2qDwFLs6yoQlpbkkwVFAZFX0Z+exYmZvKxjrxF+6R01oqvq8g8ftsplNo07sgbhNF3g+2QWwXrjEdqTLJG9H2UimaMnlMeCBWzcuk32qlnR2epfKIQxU2U+KzrI+O0ZORfYbdYL5525Cl1+CSVVrG6J5rD7p04kJciNnaMRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNBNDj0P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNBNDj0P"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA364C2BCFB;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785421574;
	bh=pVWG0d2CH+hymp8PpAipS7Eom7czTchJR3IlmtQAX24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kNBNDj0PAZpA/4ys6yRVqwT5anD1l3zs8sB/W8BNhsL4OYmBpGeW/q5nYB4olDsrZ
	 izE4/QSsYZanoZmtK/FqSE1bnsUTNU00KRTkJ/qO+MLanvIFRYqnEvvyyfx/fmt+0Y
	 QLWJPUGdYVwuoXVug83fAJ2fNOZ6+kRqfqkJ+VVda1pzMfDISKfD/sKjBuaKpmW5Yr
	 Ve6R/cdCMk7ez1uFUhw8b7vFkXSK4GEuZ0HPxIpTQr0zlrLuOC6O4ysM8DH2C60Sbb
	 ewzvnKel91Iubo9pXhK8b8DNTlfKrHC7F/dgn5LydOy0VO1CeDYOud07cevmDoP+oS
	 i8m3tux7u/AaA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A430DC55168;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 30 Jul 2026 15:23:11 +0100
Subject: [PATCH 4/9] dmaengine: qcom: gpi: Use bus width capability helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260730-dmaengine-support-wider-dma-masks-v1-4-3732f1f9d9ca@analog.com>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
In-Reply-To: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785421644; l=1388;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=tNg7tfwKVDF87kBthXLxn0NRVZu5IQgbMepYE1EpLBw=;
 b=ACaF+uQw0XfqhtfHOaeUxJJuuSdrLwUkV6liD/9lutr/Lvqa3ksVN0cUiNSiHwr6WD0p6hfms
 ODk96OkM2tlDeCtvWbfnkOJ8cd9rHgrsyBmcxAaOav/U9wPLBZZ8wpc
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Advertise the single supported source and destination bus width through
the new dma_set_src_bus_width() and dma_set_dst_bus_width() helpers
instead of assigning the legacy u32 fields directly.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/qcom/gpi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index a5055a6273af..fd45cadce91f 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2265,8 +2265,15 @@ static int gpi_probe(struct platform_device *pdev)
 	/* configure dmaengine apis */
 	gpi_dev->dma_device.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	gpi_dev->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
-	gpi_dev->dma_device.src_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
-	gpi_dev->dma_device.dst_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
+	ret = dma_set_src_bus_width(&gpi_dev->dma_device,
+				    DMA_SLAVE_BUSWIDTH_8_BYTES);
+	if (ret)
+		return ret;
+
+	ret = dma_set_dst_bus_width(&gpi_dev->dma_device,
+				    DMA_SLAVE_BUSWIDTH_8_BYTES);
+	if (ret)
+		return ret;
 	gpi_dev->dma_device.device_alloc_chan_resources = gpi_alloc_chan_resources;
 	gpi_dev->dma_device.device_free_chan_resources = gpi_free_chan_resources;
 	gpi_dev->dma_device.device_tx_status = dma_cookie_status;

-- 
2.55.0


