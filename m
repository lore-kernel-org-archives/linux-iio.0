Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5029235A925
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776720318; cv=none; b=kM/gEtN/5Nhhj36ASELcUr2/xMpLtuRH8WhAUuweS2QFYY7OgZGXopmQtnCBMag2OQtV5AtMB5TTrX4hyvI77xpVIrJ53y/PvfAkpqB/4NaEyyFHuPLCwPLipSomLR4jjJWWfNnA18F+ZOf9rUTYbLXzcwFmNjYfp+wOc+veiR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776720318; c=relaxed/simple;
	bh=k3wWhO1OkFuqlVr0NRYtiAKhJRQAkfvzr3hIyRnAXzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k1+EruD/OLmTr+QOEmCLsR7i1HXdVBYoxfieNmM9VO7T9RpoG7L+6a/8Qe0oEwGhjj7Zd43Bvf63MyX8t6Cu8GFOw6JLF4auOE7af/4TTM5BlyiexXiI9ShwyT5N0DtaUgam31guuXO9v+NopBStjodVuJY8tg0LBne2Tln8kOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=kX24MVY4; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="kX24MVY4"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c45281a06so4637861c88.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 14:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776720313; x=1777325113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7yOBRqIXNGraVLHUEBXwwEDYRVvousxME4ehp+RqjG0=;
        b=kX24MVY4iW2iU20/WjWN3/ZXGFIIPQG/6PZ/4eR7GKEmEpt+toAGQYidTe5X360YQ9
         hfetod41UJvtiPljrsk8axSysRBwtvQ6MgAyB9AZNZSInCNWWh2bVh8f6XvE1hL9xRiX
         25yF+77dwe4qeoxGxqELV5lp8S4exiH/seKazTt6xHunylbmFZ3c2smbMt1Vys2E/Rh2
         GfWRJ530NSCRlwQ/C7rDdqAwzRiYB5JcCVq1rkAq52sYGojf0ctc/hU6lh8bxQv47toK
         FFx8ksf2hzCk7hIJz82M2u44FhvGf9LZVlV1JzupsErVFyQMR0OUo7cyXCe+XmdLko0Y
         W2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776720313; x=1777325113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yOBRqIXNGraVLHUEBXwwEDYRVvousxME4ehp+RqjG0=;
        b=XrRtiKKV/wlqUNMLUi/ISu0rByBNazxHivowXM1WYF6/VKBE/fhVsE/SJYH3BO+kT3
         /rNMOUPowbkeV+czU2xm/GzW2MRquGjXbj4cmEkGapRtGQPad5rGHbCQDhmqR1EsUQm1
         NlXDzvxukorxOg7zBp8tviNAE9u2QfZxu7BeGsVVlNZA8I68d4hAx6QYnFK5PoIYURl+
         ettepPa6dJ+k5Vo+8jJEHrT8lXg/ckCXIpuonpzDPS7S11zxOFsb0B79KILxiJKK97ov
         JH6xvJBSZ8fUnt7sZ41IzCgpzgVzEowYFEaKVmGrQOg5FCth+PnaYRCCFGw3VspjHk5w
         ALVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8JeqDMK4S/HMNVK+//RoGvZp1WK8FamfgBBv3OZ5UEASSY1BT2/7m6q/EKHQn4D/djyv0/tswQZ4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Z34niFgFculMXDnnejeTzGo2r+svooxtkNcAMZtBQeamcr/q
	GgiJVq645w33X1+xqfRIqlSXmNxGMBGx62/a1u7MUjvfHTRmzXH+9V5wW0kM6JboIis=
X-Gm-Gg: AeBDievc5p5qlp4l8fd8EkQFu6QlQq2KS0xH795NbEa9Hk1oQxpJ8W0McI9lDOQZ1SG
	kRHDEC9Wz2qkD2wt5FpCGzKn5QHgtmh2Iuet+Wfuw6pt4NAR9bHQNe3+OyfFykYaKGJFJAc5kuk
	0HcoKA+pNJLF2hcv5cfAjpD5F+njVvANlH0x3oOlNB3PG52f5DOu4LZBRSCPNbTTA2eROJ5Ui19
	ERr86KfmBUaDS5IedpVJPedyNbgNmSuSQWntah1lBaInyeNd4MzO9YV7bYWUp46BCQlgMx/WmFh
	LjI5ckV96K7uu3c7+7z+DF2QMMC9suO6BuaEcoZQOeI+T3M5Gdlyr2e4X/69Drve8Qjb0oPl/nz
	vsm6cr4yLBJbGxd1KoXjYJP0G3HtkMkMSRgLJ9WieHlO2zdyLbZuStir6c5zr+6f7dEfX9KY2DV
	NPEPxl5lR81l5pW9lysc/5ShZKqqC3icDKYGgOQT9AR6IMKLmx4H0TVZHdPf89QMHp6ZRY4A==
X-Received: by 2002:a05:7022:6728:b0:128:cf5c:535a with SMTP id a92af1059eb24-12c73f7595emr8841885c88.11.1776720313150;
        Mon, 20 Apr 2026 14:25:13 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:190:8d7a:86f3:7ac8:d737:1a02])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c749d29cdsm16890469c88.6.2026.04.20.14.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 14:25:12 -0700 (PDT)
From: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Gustavo Pagnotta Faria <gustavo.pangotta@ime.usp.br>,
	Eduardo Augusto <eduardoaugustoabc@ime.usp.br>,
	Christian Barry <christian.barry@ime.usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: mcp320x: refactor driver to use bitfield API
Date: Mon, 20 Apr 2026 18:23:47 -0300
Message-ID: <20260420212405.11789-1-gustavo.pagnotta@ime.usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gustavo Pagnotta Faria <gustavo.pangotta@ime.usp.br>

Update the mcp320x driver to use the standard Linux bitfield
API (<linux/bitfield.h>) instead of manual bitwise shifts and masks.

This replaces the hardcoded shift operations in the TX data
preparation (mcp320x_channel_to_tx_data) with FIELD_PREP()
and replaces the manual masking in the RX data extraction
(mcp320x_adc_conversion) with FIELD_GET(). Explicit masks
using GENMASK() and BIT() were also introduced for both transmit
configurations and receive extractions.

Signed-off-by: Gustavo Pagnotta Faria <gustavo.pangotta@ime.usp.br>
Co-developed-by: Eduardo Augusto <eduardoaugustoabc@ime.usp.br>
Signed-off-by: Eduardo Augusto <eduardoaugustoabc@ime.usp.br>
Co-developed-by: Christian Barry <christian.barry@ime.usp.br>
Signed-off-by: Christian Barry <christian.barry@ime.usp.br>
---
 drivers/iio/adc/mcp320x.c | 58 +++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 57cff3772ebe..b7523e5ea903 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -44,6 +44,29 @@
 #include <linux/mod_devicetable.h>
 #include <linux/iio/iio.h>
 #include <linux/regulator/consumer.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+
+/* MCP3x02/04/08 Tx Data configuration */
+#define MCP3X02_START_BIT	BIT(4)
+#define MCP3X02_SGL_DIFF	BIT(3)
+#define MCP3X02_CH_MASK		BIT(2)
+
+#define MCP3X04_08_START_BIT	BIT(6)
+#define MCP3X04_08_SGL_DIFF	BIT(5)
+#define MCP3X04_08_CH_MASK	GENMASK(4, 2)
+
+/* MCP Rx Data extraction masks */
+#define MCP3001_DATA_MASK	GENMASK(12, 3)
+#define MCP300X_DATA_MASK	GENMASK(15, 6)
+#define MCP3201_DATA_MASK	GENMASK(12, 1)
+#define MCP320X_DATA_MASK	GENMASK(15, 4)
+#define MCP3301_DATA_MASK	GENMASK(12, 0)
+
+/* MCP355X Data and Status bits */
+#define MCP355X_DATA_MASK	GENMASK(31, 8)
+#define MCP355X_SGN		BIT(23)
+#define MCP355X_OVR		BIT(22)
 
 enum {
 	mcp3001,
@@ -99,19 +122,19 @@ struct mcp320x {
 static int mcp320x_channel_to_tx_data(int device_index,
 			const unsigned int channel, bool differential)
 {
-	int start_bit = 1;
-
 	switch (device_index) {
 	case mcp3002:
 	case mcp3202:
-		return ((start_bit << 4) | (!differential << 3) |
-							(channel << 2));
+		return FIELD_PREP(MCP3X02_START_BIT, 1) |
+		       FIELD_PREP(MCP3X02_SGL_DIFF, !differential) |
+		       FIELD_PREP(MCP3X02_CH_MASK, channel);
 	case mcp3004:
 	case mcp3204:
 	case mcp3008:
 	case mcp3208:
-		return ((start_bit << 6) | (!differential << 5) |
-							(channel << 2));
+		return FIELD_PREP(MCP3X04_08_START_BIT, 1) |
+		       FIELD_PREP(MCP3X04_08_SGL_DIFF, !differential) |
+		       FIELD_PREP(MCP3X04_08_CH_MASK, channel);
 	default:
 		return -EINVAL;
 	}
@@ -140,26 +163,27 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
 	if (ret < 0)
 		return ret;
 
+	u16 raw16 = be16_to_cpup((__be16 *)adc->rx_buf);
+
 	switch (device_index) {
 	case mcp3001:
-		*val = (adc->rx_buf[0] << 5 | adc->rx_buf[1] >> 3);
+		*val = FIELD_GET(MCP3001_DATA_MASK, raw16);
 		return 0;
 	case mcp3002:
 	case mcp3004:
 	case mcp3008:
-		*val = (adc->rx_buf[0] << 2 | adc->rx_buf[1] >> 6);
+		*val = FIELD_GET(MCP300X_DATA_MASK, raw16);
 		return 0;
 	case mcp3201:
-		*val = (adc->rx_buf[0] << 7 | adc->rx_buf[1] >> 1);
+		*val = FIELD_GET(MCP3201_DATA_MASK, raw16);
 		return 0;
 	case mcp3202:
 	case mcp3204:
 	case mcp3208:
-		*val = (adc->rx_buf[0] << 4 | adc->rx_buf[1] >> 4);
+		*val = FIELD_GET(MCP320X_DATA_MASK, raw16);
 		return 0;
 	case mcp3301:
-		*val = sign_extend32((adc->rx_buf[0] & 0x1f) << 8
-				    | adc->rx_buf[1], 12);
+		*val = sign_extend32(FIELD_GET(MCP3301_DATA_MASK, raw16), 12);
 		return 0;
 	case mcp3550_50:
 	case mcp3550_60:
@@ -170,17 +194,17 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
 		if (!(adc->spi->mode & SPI_CPOL))
 			raw <<= 1; /* strip Data Ready bit in SPI mode 0,0 */
 
+		raw = FIELD_GET(MCP355X_DATA_MASK, raw);
 		/*
 		 * If the input is within -vref and vref, bit 21 is the sign.
 		 * Up to 12% overrange or underrange are allowed, in which case
 		 * bit 23 is the sign and bit 0 to 21 is the value.
 		 */
-		raw >>= 8;
-		if (raw & BIT(22) && raw & BIT(23))
+		if ((raw & MCP355X_OVR) && (raw & MCP355X_SGN))
 			return -EIO; /* cannot have overrange AND underrange */
-		else if (raw & BIT(22))
-			raw &= ~BIT(22); /* overrange */
-		else if (raw & BIT(23) || raw & BIT(21))
+		else if (raw & MCP355X_OVR)
+			raw &= MCP355X_OVR; /* overrange */
+		else if ((raw & MCP355X_SGN) || (raw & BIT(21)))
 			raw |= GENMASK(31, 22); /* underrange or negative */
 
 		*val = (s32)raw;
-- 
2.43.0

