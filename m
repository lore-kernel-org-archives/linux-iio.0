Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36A34657C6;
	Tue, 16 Jun 2026 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624393; cv=none; b=MpsBddId6uM6uPu0ZnJ52NC1nIXLYVwZw3hpwuH+eWWWtfg5ylLyCXLVcDdCXsKnF/69e2VlpA8cvzUhLbqfsycw4q5pOJYSVNOQQIlnKZXt75oJIMCrCnlcsceKQ8uzrYSaAVYGWBRD3LAhXOpRVoTEwuzkhUErL+ien5O2AsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624393; c=relaxed/simple;
	bh=Wnp9piMlO5OAZAbBTVybG9dtEHUdg3c2HZTfJKpmak0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mf6iiMUS2U/qeRGHyDEXkHzqDDTiJIEVjOx1ynnqfcC996KX64jRr7p9rEQDpSU+S2aEwVJjA9RiOrdbEuvelvvel1I+HL72yPu9+qZuCuTt/z9BJFgqvfMqXcPNPixHK8nxOpJWmVo2QRgmMulVoF2R5a6w9Sa0lEtgPRgdNso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACcMwRvT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACcMwRvT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55410C4AF17;
	Tue, 16 Jun 2026 15:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781624393;
	bh=Wnp9piMlO5OAZAbBTVybG9dtEHUdg3c2HZTfJKpmak0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ACcMwRvTlnyWfTCpsuYYwZw4dSa48/CayVi4J61pteQzaxGfftCb9f+dApylTCb1B
	 G6Tot3YeCg3QrYVkF6stX+zuUFYf7aDHHUctL+KIH28d62pTo9WUovBkMIAOJ5ZPqT
	 eFpETPw8xidLYwsR+HIeGuarINyiOjf42jsUfeb3uaF5+HmhtXHv7+3QGnpefmYDlp
	 FMFIOOKuqxkMxNNV+oNFiwNcaqn0z51/Qea53q/G95Yl82DXJ7boaplOYM/WBTrCnn
	 zPQ+ywGIj4OxrDWAjgtBOTVNX3EDm2DOeOFlGJiAMVkoUaDq3Q5Aw80wOTn/J3Wsak
	 aS37CcSBIj7UQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484A5CD98E3;
	Tue, 16 Jun 2026 15:39:53 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 16 Jun 2026 16:40:54 +0100
Subject: [PATCH RFC 3/3] iio: buffer-dmaengine: Use dma_slave_caps width
 accessors
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-dmaengine-support-wider-dma-masks-v1-3-da23a8dcb756@analog.com>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
In-Reply-To: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781624455; l=1551;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=QtAaBj5IiTLwKtTN3HesIDUPe7Uel9cOrCjCQDh1rWE=;
 b=wmLYH3IjTtB5fB/lI0nvvH46rs++csjFw06DdqM8gZAMWEDNdgaE5vyaWtOTXZ0F2MjlrBcPx
 3ROqfkigDj9A8mXvq9LpgGtPp7gKjhWFIADJhvS5BLtfXEcN6BQqlFQ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Query the minimum supported source and destination widths through the
new dma_slave_caps_get_{src,dst}_width_min() helpers rather than
decoding the raw u32 width mask. This keeps the buffer working with DMA
controllers that advertise their address widths via the new bitmap
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
2.54.0


