Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E222E7F39
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776721841; cv=none; b=mqzYuCAic1DJIwhteSrUVM0xRauBe9IxX899BI5IMlx9ZAy/tFjLBLXLLTf8dLCo1wIPog6JIZkGWA4asN3TqZKuLTNqincdVFsvCNNiKM+wLG20kpCjCsarNXqmgmiXb8PLfGPN3HUvDMMDLKRvjyru7K7L571wcYddka9pyFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776721841; c=relaxed/simple;
	bh=YEl54vqHTAaczVa7q87j1DtnYpMxlzP86X/iTlUa8zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HL80I8u5ySI1wOEHbgb2gCHhTtQyMgzVIIPiJpYpptxWU9Lzvq5vosqCIJbUOKky1B1bPROGtYiBFuBnSIsrHsPV18PG3ql9Nwi3Ne1lxgqzI9gWye4ZWTGQ4+ulBCEEAy6pvVYEJquAzoLMmEc+kYPnaTmBdQPMfGtSZ8PSu14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Y4lu0x2O; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Y4lu0x2O"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1279eced0b9so5150953c88.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 14:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776721838; x=1777326638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nbL57stPwR16oPpmLMsV/qMQhFFKmTDRsvi5/awaCW0=;
        b=Y4lu0x2OzvqG9dUv53vuJQU3dxLB/E3uqHk2gFnr1T74LEWuEkRn6s/NG3pil38rFJ
         hYMkF9JL21xD0UPc7uYNq4JFZqBkj1x/DX/bGM3CQqr1yNzl6F0lRZcwyLhsRUZkV204
         k6WntJviFtVdCwT/byHAmKeUvtlRWaeIF4zeqQ6t/0Sf6enMRXRBtx5m0+73pluro7Lm
         TyHS7NbXQ0M7uMIeneVrZW6HWi2wowegdWwM/x0BWagftrUxxYEg4fYW+/y27TY2NQuU
         fLbwux4SOdNLqZ4azNNu0rp7psFptH0Louc0kFp5duU1ju2SDg3C0Vt23EbMit4m5uvb
         0PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776721838; x=1777326638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbL57stPwR16oPpmLMsV/qMQhFFKmTDRsvi5/awaCW0=;
        b=NHiaUQFt8+Qu7X/MWTBWlneW7mnmMuOVYoiCdrZrIVKCMJQE+wVvZ1qalP5mTFlRG9
         RfUUg2JGKgaECyjwdyjMXPppteecMeynem8KNMe3aj5pbXviv28ZgTdd+qveHc+0Ypjn
         39RtV0uDBavjKKVO88fT2K9iIoj20GOmbWtdn7IHwkBBFPD0Zh6PiD4vEc27dOOzOGAt
         Gb3Cv3w6v7f+lAbsalCBzbZVg9Rr6iodW2QreZb1be6NS6uug19tAec92uzpnawKswOa
         CaE+sZqxROG2Kp49SnyiH/531LN2jO4nqzxf/+Rx1hFvjIB6rp6vQqmqPMKVmq/g3pbi
         s6TQ==
X-Forwarded-Encrypted: i=1; AFNElJ96VC4pY++PRs2TwJd1Yq18FxjVT9sgvHcpK5dRDY7eY3+VwYYbRT7ylOyao8Da+qVK3DPrmZUghW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhM8j7Eo0qF1k01utd9K2iKLRvc6Q1D9h/wUZ9yymWFULe0P8c
	W3YQRK92iRHkVg7tIuOkJAHM9UloIwEYcHEUMN8nnDpIYlIPU2AT5eok71caAeTtJ1M=
X-Gm-Gg: AeBDietqsWMkk1erLQ+wGpqLDJJFmffrx5jh4FSOX1VBymorEkgfLMPWdYSSeAghxZG
	5h0+hwVJURKBCIMzCu8vXRfKdwHEduqI+tjPhNJ4P+uuPnqOjVBXQaNEjcsMmuf0mToJcWNl3bS
	u1LDou1/5bS86ICAPVaOwdtNvvu63uWUO+D1MLwmNf0HtE4KLTkr25Nyl3WtPfqfmdht53TbTO5
	fNdgVhEPwhKjZe792fC4HaEl3zh/ax4MT/Og6izlxTgn0y2XX4uWcZLDIXZMsNbfQy4ZL5VJGHR
	1l6vY/UFYr/kvY7OY574YCRFyjkAxvshbarnZJ2I7oTHRf74UThxGpKgUrpURzaynekqLaEN1YO
	NQcc6CVhHKBKg+yS8I/ZD+csrfzdfFmddkD4lpfD8jkoseIrBkaNH4OFcoGr2xPtZy9jBOHYdUc
	t+J/Pvfp/lebpeYHiKCXxO1l7BK+8XNkYVPU/+Cst9b8H7WMOT/N7HoH/69M0=
X-Received: by 2002:a05:7022:6b97:b0:11a:342e:8a98 with SMTP id a92af1059eb24-12c73e2ad32mr7992640c88.0.1776721837882;
        Mon, 20 Apr 2026 14:50:37 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:190:8d7a:86f3:7ac8:d737:1a02])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c837f7feasm14403351c88.0.2026.04.20.14.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 14:50:37 -0700 (PDT)
From: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>,
	Eduardo Augusto <eduardoaugustoabc@ime.usp.br>,
	Christian Barry <christian.barry@ime.usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: mcp320x: refactor driver to use bitfield API
Date: Mon, 20 Apr 2026 18:49:18 -0300
Message-ID: <20260420215021.14112-1-gustavo.pagnotta@ime.usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the mcp320x driver to use the standard Linux bitfield
API (<linux/bitfield.h>) instead of manual bitwise shifts and masks.

This replaces the hardcoded shift operations in the TX data
preparation (mcp320x_channel_to_tx_data) with FIELD_PREP()
and replaces the manual masking in the RX data extraction
(mcp320x_adc_conversion) with FIELD_GET(). Explicit masks
using GENMASK() and BIT() were also introduced for both transmit
configurations and receive extractions.

Signed-off-by: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
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

