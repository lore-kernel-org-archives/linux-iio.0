Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6D40B360;
	Thu, 30 Jul 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421575; cv=none; b=kDhoKaQeMXPbpHcI29Yk9Wy2pFRQNXLhNDvVOECaDWmVKKtkrAwiqmNgH1/3zxeqypDo9HoeSD+eIp9puNpwaq8s8675/0RzHOnLyXnP18m1h0S7gp+iG3wqAMIGzwJnRCILQVkk40esst0dy/lIlSUhNJOL2sFWMtkcG8BlfOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421575; c=relaxed/simple;
	bh=WBm4shRjG88RQW0Ld/AlkK/DAXGllqvzcf2au4FwcWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iJp7W830ueTzrUJbFc4KnsG2dtV+9UI9r9l312cjd2iyzxcfHHtGPEVUg76XgC9BN4NXnsIFQLyEof7fon0PF/DehY19ykRmlhRnEuy4CJExTwiurcbzGMZnYN0K3yC/EDvaecg5hSUKaXowpZDnsZeI6i4UFPOzOPhPUtYADbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jko937Xo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jko937Xo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FB09C2BCF7;
	Thu, 30 Jul 2026 14:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785421575;
	bh=WBm4shRjG88RQW0Ld/AlkK/DAXGllqvzcf2au4FwcWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Jko937XoJkAvAGGzu3lGr2sDDWUzfoUi8DunsImTmY8CVDAN6wcrk0HWPBnUXjHPD
	 QZeOB+B70vnYYUQwwdfMT4qt+lmY4BlRuWoinM5ysAyqe/OxkpsR05BzbtB9IcrXaT
	 jzICboASfI16ziVNuv5q4raklDYwzEHQ2U3yayttNWdKL5kQLx/tGdtoj02MJXjn7d
	 AR67Av4F+Tthj4PF7nlvKcPCIceaCsRG5970kIVmww+vaBj+v76EhHJ53J+AoMHLWl
	 E9xJOgrJx5LUvnkEnFyStxsdtsZ6O4DgUHwfL9nDYfxslHyARItionZapVh6TcNT8g
	 JkfFxSKYvti/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0610C5516D;
	Thu, 30 Jul 2026 14:26:14 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 30 Jul 2026 15:23:15 +0100
Subject: [PATCH 8/9] spi: dw: Use dma_slave_caps bus width helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260730-dmaengine-support-wider-dma-masks-v1-8-3732f1f9d9ca@analog.com>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
In-Reply-To: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785421644; l=2124;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=xOfZPTRVqperUBS/PjyP6dyo86jTJj1kQ2OEqLzOYA4=;
 b=Oz3H58dUS3/UdN8cU0Fc5yd515ijLhxFdYHLsyQurpATZ2HI6jArioARnr2NcpKVACzIDPz8F
 2+sk1BLTYeWAHEdQVJZyIRL+uxEgabsiOX4J2eElT2thmXvZ4Dn1N8A
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Store the common TX destination and RX source bus widths in a
driver-owned DMA bus width bitmap and populate it through the
dma_slave_caps helper.

This avoids depending on the legacy src_addr_widths and dst_addr_widths
masks returned by dma_get_slave_caps().

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/spi/spi-dw-dma.c | 6 +++---
 drivers/spi/spi-dw.h     | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index fe726b9b1780..2e23ead4a94f 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -100,10 +100,10 @@ static int dw_spi_dma_caps_init(struct dw_spi *dws)
 
 	/*
 	 * Assuming both channels belong to the same DMA controller hence the
-	 * peripheral side address width capabilities most likely would be
+	 * peripheral side bus width capabilities most likely would be
 	 * the same.
 	 */
-	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
+	dma_slave_caps_intersect_widths(&tx, &rx, dws->dma_bus_widths);
 
 	return 0;
 }
@@ -253,7 +253,7 @@ static bool dw_spi_can_dma(struct spi_controller *ctlr,
 
 	dma_bus_width = dw_spi_dma_convert_width(dws->n_bytes);
 
-	return dws->dma_addr_widths & BIT(dma_bus_width);
+	return test_bit(dma_bus_width, dws->dma_bus_widths);
 }
 
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 9cc79c566a70..9111ffc5e9d7 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -10,6 +10,7 @@
 #include <linux/scatterlist.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/bitfield.h>
+#include <linux/dmaengine.h>
 
 /* Synopsys DW SSI IP-core virtual IDs */
 #define DW_PSSI_ID			0
@@ -190,7 +191,7 @@ struct dw_spi {
 	struct dma_chan		*rxchan;
 	u32			rxburst;
 	u32			dma_sg_burst;
-	u32			dma_addr_widths;
+	DECLARE_DMA_BUS_WIDTHS(dma_bus_widths);
 	unsigned long		dma_chan_busy;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
 	const struct dw_spi_dma_ops *dma_ops;

-- 
2.55.0


