Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0813644DE
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776896827; cv=none; b=oYTC5sNBo6Og3zaY0EUfQbDiKZd7OmO1il6/Lw1cXaoMDL0Kxw8GZPIcL9k1AN0g0KThxbjW3jyP+MsaVKKHBm3hKOlchMMPGr+k5lS2fbkN2O7xR2cHl2+E15s6Y6JlzNxiCR1K8u7W2GiOg8sGUcLVX9pJlzVIKPc/rbXUoFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776896827; c=relaxed/simple;
	bh=eaCxG8SgmUQSpvNRctUno+Gw8GheuKX8N13RrYq3nc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVxgYxKEWcV+lJEUza3M0mcckc0UZ53p3b9jcTHiHj/Fu7fcxxWUVS3j18cfkJfiRhAHndLmfnAPa+EDKcgUPig67gMIv1GAnzSwHcB+IRrPCGnYCtfVFQPavvDIlAY8jJB4ysDDvOo0nW51oBEJH72ASUGu/3g98ooQu3UD/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=vnEXxhp7; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="vnEXxhp7"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12dbd0f8063so2393347c88.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 15:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776896824; x=1777501624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4hqzeKA0O3ZFuxHzGa4rvgRiaeuj0MO205Rf22UDFg=;
        b=vnEXxhp7mr20jZchbvb03mjT7NdNCipipORpsEYifODWmkMp78TXVmOlN3nqzXpP7+
         ZpxqB8MI1j1DAiMqHyGhpIMC69gmZIkZ24lM17jn05j3gJwlC6VFjwI4tH2Nj13vxzrj
         lH7DUBEsH4r+d9gGiGiab8+pyS7+CWvF128YZ6jij0J+5FV74R+GmNHgO75s2s2IxmHF
         yTBsZFzqFDmZdHKc4UoQfl/w5EbQYNEdJgY2RO4JDmwfKy6BOu+Pf7xaEu+ohm6BxjUs
         gySMO8sqIEXoDMc4dZxvHcxK+70UN609QHt0jEAmsfEuE/znMddWXrbRsURYGX97YpTl
         eMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776896824; x=1777501624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w4hqzeKA0O3ZFuxHzGa4rvgRiaeuj0MO205Rf22UDFg=;
        b=SMAAT5IH5UuEh/9FCdWHKsI3OKSOQSZheBO6GHSUy7Dm/32SkFP8INlvTv9TJBTAAb
         QJi8HTx0pzxc+H6uiCJWgSYJRLX32F6mbdMBx8ejLZwnVApyKlTO+xO/bZQO/w8EG3+A
         Cu5SHn/tc7UQ6iuQfc0sIkYv9yAw7PqoeletbYIq7lulf+rI295JBTyhBbH9f5npZSXP
         WXW0GHjGcdYhs1LDFW/7UwpP561S9rRumCPewy5V5rGwlR+anzq7x96GpCRbjgDCEuhU
         fHQQdgqkbVpochBebWk/XWKW3WbICDT2AziDIkN+7dQoHHYtrhPDdnF9SMDSEUPz1I8i
         T7CQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zVhwWHUk4TGLdTb9Xn/2iLicfskp0Gv9GD1beXmiFJSHOtmYU5wHC2+v7v2A2ygtkxiR8Mv7gudg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzutvNPOO7z6CBVBOvgPUVXVu1RFBNfPdP7iEsHT0CF8QAYonLq
	22BCv83jry0kN6/y7QlrQi5fTJmrCGL1Ujhs1crl2LSgbBsWFMEJqapxWeI+q+gbC0U=
X-Gm-Gg: AeBDiesTXC+d8ACZcD2rKs0Es7acvx8E34GAdXFdE89JHsHY9s+S5nxFZO7gGp/+WgN
	zwykOmRh3JKl5AdwXHZXk19ujDxQo3ErAIGWyHuXk+BZI6NbeVmgTFkMhHT7AGs8XrtNZl20GLk
	menj9r/fl2Q63IK9BjqsP0BxA9cJYPLo3GHZsTUEp8Cy73iJd2rEldamLAlUhHAxrBV3AWU6fj1
	pYspC/1EbzSF5/+31fTa/gFPzrFYDLTzCSNqN7HFoIu8w+KvXIkMv0E5eK4u208JfaVj/usokCV
	n7QNDZh1ipDi9KGv+8gjwyatEWpK4c99vn5GypUAaAc7q1QYLvayHgM9K+zscpgDiPGl5ytXuXQ
	UqIvUjWdZbAtSCn26xn6hLgNFaxh8pMdmfiqqyJMigREzH73aBDEGIe2FudGOC8buJbns4IEGIn
	bDtlisqLS+4psGfsduOe1nPS83od5H7rtHc5UD/hVpG3CKs1tLpUAA5X7Y
X-Received: by 2002:a05:7022:4199:b0:12c:8b9:71db with SMTP id a92af1059eb24-12c73f97587mr13686082c88.21.1776896824283;
        Wed, 22 Apr 2026 15:27:04 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:190:8d7a:cdbd:474a:802:34b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c837f7feasm26293952c88.0.2026.04.22.15.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 15:27:03 -0700 (PDT)
From: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>,
	Eduardo Augusto <eduardoaugustoabc@ime.usp.br>,
	Christian Barry <christian.barry@ime.usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 2/2] iio: adc: mcp320x: refactor driver to use bitfield API
Date: Wed, 22 Apr 2026 19:14:13 -0300
Message-ID: <20260422222553.67660-3-gustavo.pagnotta@ime.usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422222553.67660-1-gustavo.pagnotta@ime.usp.br>
References: <20260422222553.67660-1-gustavo.pagnotta@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the mcp320x driver to use the standard Linux
bitfield API (<linux/bitfield.h>) instead of manual
bitwise shifts and masks.

This replaces the hardcoded shift operations in the TX
data preparation (mcp320x_channel_to_tx_data) with FIELD_PREP()
and replaces the manual masking in the RX data extraction
(mcp320x_adc_conversion) with FIELD_GET(). Explicit masks using
GENMASK() and BIT() were also introduced for both transmit
configurations and receive extractions.

Signed-off-by: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
Co-developed-by: Eduardo Augusto <eduardoaugustoabc@ime.usp.br>
Signed-off-by: Eduardo Augusto <eduardoaugustoabc@ime.usp.br>
Co-developed-by: Christian Barry <christian.barry@ime.usp.br>
Signed-off-by: Christian Barry <christian.barry@ime.usp.br>
---
 drivers/iio/adc/mcp320x.c | 81 +++++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index d011f1732bd7..454494a6edd2 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -37,6 +37,8 @@
  * http://ww1.microchip.com/downloads/en/DeviceDoc/21950D.pdf  mcp3550/1/3
  */
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/iio/iio.h>
@@ -44,6 +46,37 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/unaligned.h>
+
+/* MCP3002 Tx Data configuration */
+#define MCP3002_START_BIT	BIT(4)
+#define MCP3002_SGL_DIFF	BIT(3)
+#define MCP3002_CH_MASK		BIT(2)
+
+/* MCP3004 Tx Data configuration */
+#define MCP3004_START_BIT	BIT(6)
+#define MCP3004_SGL_DIFF	BIT(5)
+#define MCP3004_CH_MASK		GENMASK(3, 2)
+
+/* MCP3008 Tx Data configuration */
+#define MCP3008_START_BIT	BIT(6)
+#define MCP3008_SGL_DIFF	BIT(5)
+#define MCP3008_CH_MASK		GENMASK(4, 2)
+
+/* MCP Rx Data extraction masks */
+#define MCP3001_DATA_MASK	GENMASK(12, 3)
+#define MCP3002_DATA_MASK	GENMASK(15, 6)
+#define MCP3201_DATA_MASK	GENMASK(12, 1)
+#define MCP3202_DATA_MASK	GENMASK(15, 4)
+#define MCP3301_DATA_MASK	GENMASK(12, 0)
+
+/*
+ * MCP3550 Data and Status bits
+ * See mcp320x_adc_conversion() for details on when these are used.
+ */
+#define MCP3550_DATA_MASK	GENMASK(31, 8)
+#define MCP3550_SGN		BIT(23)
+#define MCP3550_OVR		BIT(22)
 
 enum {
 	mcp3001,
@@ -99,19 +132,22 @@ struct mcp320x {
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
+		return FIELD_PREP(MCP3002_START_BIT, 1) |
+		       FIELD_PREP(MCP3002_SGL_DIFF, differential ? 0 : 1) |
+		       FIELD_PREP(MCP3002_CH_MASK, channel);
 	case mcp3004:
 	case mcp3204:
+		return FIELD_PREP(MCP3004_START_BIT, 1) |
+		       FIELD_PREP(MCP3004_SGL_DIFF, differential ? 0 : 1) |
+		       FIELD_PREP(MCP3004_CH_MASK, channel);
 	case mcp3008:
 	case mcp3208:
-		return ((start_bit << 6) | (!differential << 5) |
-							(channel << 2));
+		return FIELD_PREP(MCP3008_START_BIT, 1) |
+		       FIELD_PREP(MCP3008_SGL_DIFF, differential ? 0 : 1) |
+		       FIELD_PREP(MCP3008_CH_MASK, channel);
 	default:
 		return -EINVAL;
 	}
@@ -142,45 +178,50 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
 
 	switch (device_index) {
 	case mcp3001:
-		*val = (adc->rx_buf[0] << 5 | adc->rx_buf[1] >> 3);
+		*val = FIELD_GET(MCP3001_DATA_MASK, get_unaligned_be16(adc->rx_buf));
 		return 0;
 	case mcp3002:
 	case mcp3004:
 	case mcp3008:
-		*val = (adc->rx_buf[0] << 2 | adc->rx_buf[1] >> 6);
+		*val = FIELD_GET(MCP3002_DATA_MASK, get_unaligned_be16(adc->rx_buf));
 		return 0;
 	case mcp3201:
-		*val = (adc->rx_buf[0] << 7 | adc->rx_buf[1] >> 1);
+		*val = FIELD_GET(MCP3201_DATA_MASK, get_unaligned_be16(adc->rx_buf));
 		return 0;
 	case mcp3202:
 	case mcp3204:
 	case mcp3208:
-		*val = (adc->rx_buf[0] << 4 | adc->rx_buf[1] >> 4);
+		*val = FIELD_GET(MCP3202_DATA_MASK, get_unaligned_be16(adc->rx_buf));
 		return 0;
-	case mcp3301:
-		*val = sign_extend32((adc->rx_buf[0] & 0x1f) << 8
-				    | adc->rx_buf[1], 12);
+	case mcp3301: {
+		u16 rx_val = get_unaligned_be16(adc->rx_buf);
+		u16 raw = FIELD_GET(MCP3301_DATA_MASK, rx_val);
+
+		*val = sign_extend32(raw, 12);
 		return 0;
+		}
 	case mcp3550_50:
 	case mcp3550_60:
 	case mcp3551:
 	case mcp3553: {
-		u32 raw = be32_to_cpup((__be32 *)adc->rx_buf);
+		u32 rx_val = get_unaligned_be32(adc->rx_buf);
+		u32 raw;
 
 		if (!(adc->spi->mode & SPI_CPOL))
-			raw <<= 1; /* strip Data Ready bit in SPI mode 0,0 */
+			rx_val <<= 1; /* strip Data Ready bit in SPI mode 0,0 */
 
 		/*
 		 * If the input is within -vref and vref, bit 21 is the sign.
 		 * Up to 12% overrange or underrange are allowed, in which case
 		 * bit 23 is the sign and bit 0 to 21 is the value.
 		 */
-		raw >>= 8;
-		if (raw & BIT(22) && raw & BIT(23))
+		raw = FIELD_GET(MCP3550_DATA_MASK, rx_val);
+
+		if ((raw & MCP3550_OVR) && (raw & MCP3550_SGN))
 			return -EIO; /* cannot have overrange AND underrange */
-		else if (raw & BIT(22))
-			raw &= ~BIT(22); /* overrange */
-		else if (raw & BIT(23) || raw & BIT(21))
+		else if (raw & MCP3550_OVR)
+			raw &= ~MCP3550_OVR; /* overrange */
+		else if ((raw & MCP3550_SGN) || (raw & BIT(21)))
 			raw |= GENMASK(31, 22); /* underrange or negative */
 
 		*val = (s32)raw;
-- 
2.43.0

