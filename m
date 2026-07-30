Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3315143E07D;
	Thu, 30 Jul 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421575; cv=none; b=tFLBf5SrwzxDSI0qVvA/7lTsquFGR9FUMZ04XRBJ5ePafapYkeP+I6c6xhQ2ZBryZaQ1qlI8EVC0P2SKpV7dfQI7jq0/PN8dpLNkb4KaRq6qWcqSN9XdXqsqJX6/3uYxIkFvW1+klaFAfDdusgK2ZcCA/osxL3ZVWmACk0rc7EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421575; c=relaxed/simple;
	bh=JQOn8ei5JTP4eoYSYhk2I6dcSbPMkbs8NwMxksGSz6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I8fcDSupXlY64nLv4E6U3Dox8NZz4Q6RGn5/wBtbLBZJi77Ii2uWGvt58oWB236midSpRsiF8ECmsH+Jy0zOfNUVsqZCa0T1kSkXlYMWrTWz1+SZwoNpL+JdNeImt8BC/1ijAEAx91GAHawFaQcXl7FCgt2398jjU0iEqSTP3NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBLJE/Oi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBLJE/Oi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0C75C2BCFF;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785421575;
	bh=JQOn8ei5JTP4eoYSYhk2I6dcSbPMkbs8NwMxksGSz6U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DBLJE/OiOpUmAUvgPd4WzNHoYWOT17eDRiEejms8U+sTJ/YpfSxeCJPb2EG8sXRIq
	 8K1B8PyGLUJ8ku91xV/oOlApaxGmPEP/9MAnowTO0WCbZxmM83j6FBto1jJgkQxzSH
	 kppASCmWNETLO/TLRq0oMsTyDGOqiwZwc74nvrT2k2THgezqA3HHDUHf1wTZjuneAa
	 1ou2IdrVWVN9U7H2kp4mqkZdd3nlCl4eX0P8cz94gwTTXVigO5qdJDqQ65vM9eTqJ1
	 2xxGIdlgPhs4HG16f92S+AXKBPxXKHhI9Z7qVnfzhfmSQ5vxZBUAip6gE5beVgtc8V
	 N+BQIkDstBIqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAEDC55165;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 30 Jul 2026 15:23:14 +0100
Subject: [PATCH 7/9] ALSA: pcm_dmaengine: Use dma_slave_caps bus width
 helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260730-dmaengine-support-wider-dma-masks-v1-7-3732f1f9d9ca@analog.com>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
In-Reply-To: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785421644; l=1956;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=n/fiHizGGytrGMky+zm6a28M1rEvWtnfiQdy1LDRAco=;
 b=tO1aDn+ij/KiNvywdmFxw0Y3BU1eXHYMXTJCgJP1x9lzj1bjHmuj9bfMPuwB/3unZgmk0/p3D
 kzz13xd5gbBDB8EQFb5wN5qtpMlvs2o14Xw/MRjXpEgRfH1fd1kTz13
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Use the dma_slave_caps bus width helpers instead of reading the legacy
src_addr_widths and dst_addr_widths masks directly.

Keep the existing default assumption of 1, 2 and 4 byte widths when the
DMA channel does not report slave capabilities.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 sound/core/pcm_dmaengine.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 1306b04be171..37468f4643bc 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -409,15 +409,17 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 	struct dma_chan *chan)
 {
 	struct dma_slave_caps dma_caps;
-	u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-			  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-			  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	DECLARE_DMA_BUS_WIDTHS(bus_widths) = {};
 	snd_pcm_format_t i;
 	int ret = 0;
 
 	if (!hw || !chan || !dma_data)
 		return -EINVAL;
 
+	__set_bit(DMA_SLAVE_BUSWIDTH_1_BYTE, bus_widths);
+	__set_bit(DMA_SLAVE_BUSWIDTH_2_BYTES, bus_widths);
+	__set_bit(DMA_SLAVE_BUSWIDTH_4_BYTES, bus_widths);
+
 	ret = dma_get_slave_caps(chan, &dma_caps);
 	if (ret == 0) {
 		if (dma_caps.cmd_pause && dma_caps.cmd_resume)
@@ -426,9 +428,9 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 			hw->info |= SNDRV_PCM_INFO_BATCH;
 
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			addr_widths = dma_caps.dst_addr_widths;
+			dma_slave_caps_copy_dst_widths(&dma_caps, bus_widths);
 		else
-			addr_widths = dma_caps.src_addr_widths;
+			dma_slave_caps_copy_src_widths(&dma_caps, bus_widths);
 	}
 
 	/*
@@ -460,7 +462,7 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 			case 24:
 			case 32:
 			case 64:
-				if (addr_widths & (1 << (bits / 8)))
+				if (test_bit(bits / 8, bus_widths))
 					hw->formats |= pcm_format_to_bits(i);
 				break;
 			default:

-- 
2.55.0


