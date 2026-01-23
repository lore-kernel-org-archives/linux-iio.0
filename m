Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F2A2F39DD
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200739; cv=none; b=F+Spm59tC6hksPPf32RO6mx9QY2O+DZTZfoVXkK0+EYHkTHv6bVa6YRl+VZJ+3SHkZjjlTo1ErdJiGbeB8LJf0/CGUW0Ns9TCBYlxpWCE1CsyiltTJxeT3clatqbOaveBi/5RPMmDR1WN+wezNBsubCYTVxkLEXn298qaW0WPxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200739; c=relaxed/simple;
	bh=KnZDb1RT6NWWOFZ3HvXqvyGhNXZq7ggnEolsCRzgZd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VU5zjRSZpLDFpTu7joIAK3rwxnaw12uOJzlyLFxNr0GGtvgDLtigYyVxdUtCi2m8Sgl8AF0D+aawHFaDC4kFHx50pjhe1nn4G1D7LQfks332y9cAbkfAmsQ4T9LQ22e75XmLvSRpr6yXezmjPms9hc5y20XXcQvTV/ILqVfztSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UKKFdWCc; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UKKFdWCc"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3f9ebb269c3so1208270fac.3
        for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 12:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769200734; x=1769805534; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6K91l2e5Ibh1D1gRXzP9yxJZxobSqKsfm22dEUOsBxU=;
        b=UKKFdWCcqo9qNTWGH0Z9Mvb8AlYfo1ngO7P1ST2yj3geHOZ9cDtFZe+d46q3aoGver
         h4uEkpvGvLqOM1BK3Vw+tAEUOUOPNtmPRXwxFVTsRDODr01GNCcWrpP6dQtQqUSuXif1
         TRwYkLUAsR1p29/+V5WpwXVjBLtClOSWwKloA0Ry7txw5LDb+NPJSFYGKEIYeYerCyGn
         /wI0+fshCIVqjE3iWm9QaqmbFeH8UDLj0SUFj4L7XZkAM1sXX0Tr0WIFw6LeIIo1Faqj
         RFNRUJ8LzAib/w97dH3DFDtc5mU5K9Fy/I11yhN4v/OLDajDiz2ZYXSl8EiTs1NG6ZYx
         6ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769200734; x=1769805534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6K91l2e5Ibh1D1gRXzP9yxJZxobSqKsfm22dEUOsBxU=;
        b=aAEVNh1wgT0a+417ZT3DS7KfkC1mMMzOr3M3k4ehOdwzllOrYlZCctSLC1u7Tc96fh
         4yB1ruc6Y4pOrIufVqNTst7I+zNSr/k9npWTf8LghOzsPMgDRBVjHgcuhThPhlJt6Fac
         jqHr45syRB8Dh2MHs60uJyS8Q2PaxyupaoOEzkBPOCO9EzNOZv1VmhS351tiyX56ORbU
         KcxDSjObLv37ehX9fg1uoiVn4wnFwp0Zkmds+hBUbOKV8MeFudRPC1i0xwtR1lOmUOY3
         SEAYTSbuvfVwaU9+EvPL69JuLAoyDBzkx8nhCd7FS/SK+GjiAbsTVNdkK1cJQKlPkcSJ
         6w/g==
X-Forwarded-Encrypted: i=1; AJvYcCUCHOSVMJ2VTxj6g2KjaoStw92tt/sKmVauwQBXW1BCxvDBXbMV0LqiOvOBko/LWP2vaJUQL1vwxoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdYfSVsMGBlPOYv4uQRq43o8+zngE0Uz5iX59drHLUSOCWh1hT
	WK4mss8z+HQnXzLs30mt6XxeACyLC1plZchv8PTu17jlcG0CvDfxrNFL3PupCpsH3BM=
X-Gm-Gg: AZuq6aIeNtYPQt8gVfr/gq/iY9Ag++peXBx1AahvNGsHyuQf2I/xKk9pUB1sckEw0j7
	b0Ortn3RMaSX+FiXi2rHerL493pApB6ICi1NUZMkvPbS7hNeP2kgz2zXfKVmdpMKf51NWD5NyKT
	Gqmh1Y82pLWVqmrEsaLc9d6CE1v4i4DpjvHOPu0VvVeUnOxrIAOwVQGVvU+Yf+4QZDsz4jV5juO
	V4z10ob4/ceEJhOZEGO8L7idQgXs62pMEhlE/S3z/oaBvbZXCB7wU2AEVISRzQAdzapWcg3wdR3
	8MuwrGXB0EE/HlsRy/k5sVMLRq+lChyrMAfNYk+bRw5noBKctI9O4ufKPisYywpOl8NuUEI5oJd
	79NK6BwJzEqi4Gd9PW5hBW85yDILVgn7p2zzrDqfqQxUZ9hYxE8B/a/9YF6/yIIe3DCuhTSko6q
	QrQM55XZcYzafu9dNpi4xwFMgW
X-Received: by 2002:a05:6871:ca:b0:404:36c7:47a8 with SMTP id 586e51a60fabf-408ab884bc3mr1997005fac.59.1769200729510;
        Fri, 23 Jan 2026 12:38:49 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af888da1sm2167805fac.6.2026.01.23.12.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 12:38:49 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Jan 2026 14:37:30 -0600
Subject: [PATCH v6 7/9] spi: axi-spi-engine: support
 SPI_MULTI_LANE_MODE_STRIPE
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-spi-add-multi-bus-support-v6-7-12af183c06eb@baylibre.com>
References: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
In-Reply-To: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12230;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=KnZDb1RT6NWWOFZ3HvXqvyGhNXZq7ggnEolsCRzgZd8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpc9w3w+rob1cYM3ya/aXzmF6/hqjR5jF5SAisO
 D0rFB65fUyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaXPcNwAKCRDCzCAB/wGP
 wCCfCACQKv+wxM+iVegq9HcWOCvP8OMxcbrXoW/iCNIV3yuDR5/51Xqgjq+Rmw+Em9v2Gc5lvCA
 R+rjeI+hqt3B3Pq3gi7Db8yLk3vCXofhxlMimAHciEWbmZbsj1Mf2YyBdx4bB3eFgYZQkTeNrdr
 KlQH2AV0UQynE/5uIHQ0N0pUJn9cpQxaoRhCD24fudUocq5Xd45RZ5t2rqbI8ndPvgyTtqFlEzn
 nMIE3QN7PdiuRH8h4Tj4/QHLTgaPe3vLuUuw59YIx7fnY/A2+DowUBJqRYlCsYvDfJ5umTDq24b
 MNXCY+06X1TMG4cBAx34it+NQyP5J0vGrNzzFRsuflhuz1lP
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for SPI_MULTI_LANE_MODE_STRIPE to the AXI SPI engine driver.

The v2.0.0 version of the AXI SPI Engine IP core supports multiple
lanes. This can be used with SPI_MULTI_LANE_MODE_STRIPE to support
reading from simultaneous sampling ADCs that have a separate SDO line
for each analog channel. This allows reading all channels at the same
time to increase throughput.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes: none

v5 changes: none

v4 changes:
* Update for core SPI API changes.

v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.

v2 changes:
* Fixed off-by-one in SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK GENMASK
---
 drivers/spi/spi-axi-spi-engine.c | 145 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 141 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 91805eae9263..c75e8da049f7 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -23,6 +23,9 @@
 #include <linux/spi/spi.h>
 #include <trace/events/spi.h>
 
+#define SPI_ENGINE_REG_DATA_WIDTH		0x0C
+#define   SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK	GENMASK(23, 16)
+#define   SPI_ENGINE_REG_DATA_WIDTH_MASK		GENMASK(15, 0)
 #define SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH	0x10
 #define SPI_ENGINE_REG_RESET			0x40
 
@@ -75,6 +78,8 @@
 #define SPI_ENGINE_CMD_REG_CLK_DIV		0x0
 #define SPI_ENGINE_CMD_REG_CONFIG		0x1
 #define SPI_ENGINE_CMD_REG_XFER_BITS		0x2
+#define SPI_ENGINE_CMD_REG_SDI_MASK		0x3
+#define SPI_ENGINE_CMD_REG_SDO_MASK		0x4
 
 #define SPI_ENGINE_MISC_SYNC			0x0
 #define SPI_ENGINE_MISC_SLEEP			0x1
@@ -105,6 +110,10 @@
 #define SPI_ENGINE_OFFLOAD_CMD_FIFO_SIZE	16
 #define SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE	16
 
+/* Extending SPI_MULTI_LANE_MODE values for optimizing messages. */
+#define SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN	-1
+#define SPI_ENGINE_MULTI_BUS_MODE_CONFLICTING	-2
+
 struct spi_engine_program {
 	unsigned int length;
 	uint16_t instructions[] __counted_by(length);
@@ -142,6 +151,11 @@ struct spi_engine_offload {
 	unsigned long flags;
 	unsigned int offload_num;
 	unsigned int spi_mode_config;
+	unsigned int multi_lane_mode;
+	u8 rx_primary_lane_mask;
+	u8 tx_primary_lane_mask;
+	u8 rx_all_lanes_mask;
+	u8 tx_all_lanes_mask;
 	u8 bits_per_word;
 };
 
@@ -165,6 +179,25 @@ struct spi_engine {
 	bool offload_requires_sync;
 };
 
+static void spi_engine_primary_lane_flag(struct spi_device *spi,
+					 u8 *rx_lane_flags, u8 *tx_lane_flags)
+{
+	*rx_lane_flags = BIT(spi->rx_lane_map[0]);
+	*tx_lane_flags = BIT(spi->tx_lane_map[0]);
+}
+
+static void spi_engine_all_lanes_flags(struct spi_device *spi,
+				       u8 *rx_lane_flags, u8 *tx_lane_flags)
+{
+	int i;
+
+	for (i = 0; i < spi->num_rx_lanes; i++)
+		*rx_lane_flags |= BIT(spi->rx_lane_map[i]);
+
+	for (i = 0; i < spi->num_tx_lanes; i++)
+		*tx_lane_flags |= BIT(spi->tx_lane_map[i]);
+}
+
 static void spi_engine_program_add_cmd(struct spi_engine_program *p,
 	bool dry, uint16_t cmd)
 {
@@ -193,7 +226,7 @@ static unsigned int spi_engine_get_config(struct spi_device *spi)
 }
 
 static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
-	struct spi_transfer *xfer)
+				struct spi_transfer *xfer, u32 num_lanes)
 {
 	unsigned int len;
 
@@ -204,6 +237,9 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 	else
 		len = xfer->len / 4;
 
+	if (xfer->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE)
+		len /= num_lanes;
+
 	while (len) {
 		unsigned int n = min(len, 256U);
 		unsigned int flags = 0;
@@ -269,6 +305,7 @@ static int spi_engine_precompile_message(struct spi_message *msg)
 {
 	unsigned int clk_div, max_hz = msg->spi->controller->max_speed_hz;
 	struct spi_transfer *xfer;
+	int multi_lane_mode = SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN;
 	u8 min_bits_per_word = U8_MAX;
 	u8 max_bits_per_word = 0;
 
@@ -284,6 +321,24 @@ static int spi_engine_precompile_message(struct spi_message *msg)
 			min_bits_per_word = min(min_bits_per_word, xfer->bits_per_word);
 			max_bits_per_word = max(max_bits_per_word, xfer->bits_per_word);
 		}
+
+		if (xfer->rx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM ||
+		    xfer->tx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_TX_STREAM) {
+			switch (xfer->multi_lane_mode) {
+			case SPI_MULTI_LANE_MODE_SINGLE:
+			case SPI_MULTI_LANE_MODE_STRIPE:
+				break;
+			default:
+				/* Other modes, like mirror not supported */
+				return -EINVAL;
+			}
+
+			/* If all xfers have the same multi-lane mode, we can optimize. */
+			if (multi_lane_mode == SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN)
+				multi_lane_mode = xfer->multi_lane_mode;
+			else if (multi_lane_mode != xfer->multi_lane_mode)
+				multi_lane_mode = SPI_ENGINE_MULTI_BUS_MODE_CONFLICTING;
+		}
 	}
 
 	/*
@@ -297,6 +352,14 @@ static int spi_engine_precompile_message(struct spi_message *msg)
 			priv->bits_per_word = min_bits_per_word;
 		else
 			priv->bits_per_word = 0;
+
+		priv->multi_lane_mode = multi_lane_mode;
+		spi_engine_primary_lane_flag(msg->spi,
+					     &priv->rx_primary_lane_mask,
+					     &priv->tx_primary_lane_mask);
+		spi_engine_all_lanes_flags(msg->spi,
+					   &priv->rx_all_lanes_mask,
+					   &priv->tx_all_lanes_mask);
 	}
 
 	return 0;
@@ -310,6 +373,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	struct spi_engine_offload *priv;
 	struct spi_transfer *xfer;
 	int clk_div, new_clk_div, inst_ns;
+	int prev_multi_lane_mode = SPI_MULTI_LANE_MODE_SINGLE;
 	bool keep_cs = false;
 	u8 bits_per_word = 0;
 
@@ -334,6 +398,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 		 * in the same way.
 		 */
 		bits_per_word = priv->bits_per_word;
+		prev_multi_lane_mode = priv->multi_lane_mode;
 	} else {
 		spi_engine_program_add_cmd(p, dry,
 			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
@@ -344,6 +409,28 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	spi_engine_gen_cs(p, dry, spi, !xfer->cs_off);
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (xfer->rx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM ||
+		    xfer->tx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_TX_STREAM) {
+			if (xfer->multi_lane_mode != prev_multi_lane_mode) {
+				u8 tx_lane_flags, rx_lane_flags;
+
+				if (xfer->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE)
+					spi_engine_all_lanes_flags(spi, &rx_lane_flags,
+								   &tx_lane_flags);
+				else
+					spi_engine_primary_lane_flag(spi, &rx_lane_flags,
+								     &tx_lane_flags);
+
+				spi_engine_program_add_cmd(p, dry,
+					SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
+							     rx_lane_flags));
+				spi_engine_program_add_cmd(p, dry,
+					SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
+							     tx_lane_flags));
+			}
+			prev_multi_lane_mode = xfer->multi_lane_mode;
+		}
+
 		new_clk_div = host->max_speed_hz / xfer->effective_speed_hz;
 		if (new_clk_div != clk_div) {
 			clk_div = new_clk_div;
@@ -360,7 +447,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 					bits_per_word));
 		}
 
-		spi_engine_gen_xfer(p, dry, xfer);
+		spi_engine_gen_xfer(p, dry, xfer, spi->num_rx_lanes);
 		spi_engine_gen_sleep(p, dry, spi_delay_to_ns(&xfer->delay, xfer),
 				     inst_ns, xfer->effective_speed_hz);
 
@@ -394,6 +481,19 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	if (clk_div != 1)
 		spi_engine_program_add_cmd(p, dry,
 			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CLK_DIV, 0));
+
+	/* Restore single lane mode unless offload disable will restore it later. */
+	if (prev_multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE &&
+	    (!msg->offload || priv->multi_lane_mode != SPI_MULTI_LANE_MODE_STRIPE)) {
+		u8 rx_lane_flags, tx_lane_flags;
+
+		spi_engine_primary_lane_flag(spi, &rx_lane_flags, &tx_lane_flags);
+
+		spi_engine_program_add_cmd(p, dry,
+			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK, rx_lane_flags));
+		spi_engine_program_add_cmd(p, dry,
+			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK, tx_lane_flags));
+	}
 }
 
 static void spi_engine_xfer_next(struct spi_message *msg,
@@ -799,6 +899,19 @@ static int spi_engine_setup(struct spi_device *device)
 	writel_relaxed(SPI_ENGINE_CMD_CS_INV(spi_engine->cs_inv),
 		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
+	if (host->num_data_lanes > 1) {
+		u8 rx_lane_flags, tx_lane_flags;
+
+		spi_engine_primary_lane_flag(device, &rx_lane_flags, &tx_lane_flags);
+
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
+						    rx_lane_flags),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
+						    tx_lane_flags),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+	}
+
 	/*
 	 * In addition to setting the flags, we have to do a CS assert command
 	 * to make the new setting actually take effect.
@@ -902,6 +1015,15 @@ static int spi_engine_trigger_enable(struct spi_offload *offload)
 						    priv->bits_per_word),
 			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
+	if (priv->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE) {
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
+						    priv->rx_all_lanes_mask),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
+						    priv->tx_all_lanes_mask),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+	}
+
 	writel_relaxed(SPI_ENGINE_CMD_SYNC(1),
 		spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
@@ -929,6 +1051,16 @@ static void spi_engine_trigger_disable(struct spi_offload *offload)
 	reg &= ~SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
 	writel_relaxed(reg, spi_engine->base +
 			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
+
+	/* Restore single-lane mode. */
+	if (priv->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE) {
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
+						    priv->rx_primary_lane_mask),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
+						    priv->tx_primary_lane_mask),
+			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
+	}
 }
 
 static struct dma_chan
@@ -973,7 +1105,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 {
 	struct spi_engine *spi_engine;
 	struct spi_controller *host;
-	unsigned int version;
+	unsigned int version, data_width_reg_val;
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
@@ -1042,7 +1174,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 		return PTR_ERR(spi_engine->base);
 
 	version = readl(spi_engine->base + ADI_AXI_REG_VERSION);
-	if (ADI_AXI_PCORE_VER_MAJOR(version) != 1) {
+	if (ADI_AXI_PCORE_VER_MAJOR(version) > 2) {
 		dev_err(&pdev->dev, "Unsupported peripheral version %u.%u.%u\n",
 			ADI_AXI_PCORE_VER_MAJOR(version),
 			ADI_AXI_PCORE_VER_MINOR(version),
@@ -1050,6 +1182,8 @@ static int spi_engine_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	data_width_reg_val = readl(spi_engine->base + SPI_ENGINE_REG_DATA_WIDTH);
+
 	if (adi_axi_pcore_ver_gteq(version, 1, 1)) {
 		unsigned int sizes = readl(spi_engine->base +
 				SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH);
@@ -1096,6 +1230,9 @@ static int spi_engine_probe(struct platform_device *pdev)
 	}
 	if (adi_axi_pcore_ver_gteq(version, 1, 3))
 		host->mode_bits |= SPI_MOSI_IDLE_LOW | SPI_MOSI_IDLE_HIGH;
+	if (adi_axi_pcore_ver_gteq(version, 2, 0))
+		host->num_data_lanes = FIELD_GET(SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK,
+						 data_width_reg_val);
 
 	if (host->max_speed_hz == 0)
 		return dev_err_probe(&pdev->dev, -EINVAL, "spi_clk rate is 0");

-- 
2.43.0

