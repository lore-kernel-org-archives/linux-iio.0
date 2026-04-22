Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D9139D
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776827422; cv=none; b=GRyQjf/S8EMoaV6DgqO8U9Ac/3NpvpbpBL0rsBzAWHDvdvSBJ1p13fq6EF9rmfP/KJp5RHp+dNTNq0hfpCWPnntjo3+INNm67uh46tXpx4nrj0UJGqlU4Y6ZXzqjbYgDMQY6hMVFmA5V0ouSt0b2alBQkmrt7e0Iv3kJYnDfRnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776827422; c=relaxed/simple;
	bh=vQRo955/6uDmNeunvjyPZG4rTix0A3zJuI/tzpW0pDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/ApS+8azIk1Cnqq8AKlDMNFjRc7Ehdg3zlszr9Dk2ly011+BOmKdDJo8tkPXttHwv6VrX7omyiiFsenAtcIxpJgjvF0mVpubZ6UZg5+nYXYJyUL0k3Gso3VQStbLGfokMZ4IHWiRloUmp161v8xZrZigjQ1taicdIL/cwFe1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=piToUXV7; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="piToUXV7"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12713e56abdso3400907c88.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 20:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776827413; x=1777432213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/jK58/KFNowOBvmaJr4lYMFBzU7R53LKylpRdkIi2Q=;
        b=piToUXV7THL0HghJ9SxszZvuSvBDD2XVINopExowgw9soY6b4vBmxQwUvg08Ng2rQt
         9vB7D/4ZWahT9P/Sju9Rc+MJ6FO5H9zksz8Pg/mlg7BRPCpD6VVNQffqCrZqqcg1Bqwo
         8b5p2e4kLFjNvVSHBjoflf8oCpiMNBfw4QI128FPoa3onhgnEAWW0uxxDHdqS/9bOJaT
         AAs4WlklkuCWhrmtZxF3IdwJeWGYSZrglCP6lqU1NcMa4oxVj4GxNh2oESq+Sa83yarW
         3ZogqTqup9jFkZuKG93QKf5zSQJFHfOIei5vpTdf598CoN2y2JfGa2qGXrJiNLrUaAlO
         o9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776827413; x=1777432213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/jK58/KFNowOBvmaJr4lYMFBzU7R53LKylpRdkIi2Q=;
        b=DkIXfzQ6yH4j9fh4WZWO7+96R1nW9swh5zD5RivwiBre08v4l1aj7bOU/gDSbLaBof
         9rjfM7A+Tz0NSMyFRWuv65Yk2MVk0D98UmyouoyjPln3nXVTGD1wIkidoBnTHIcjGFv5
         GmAFEc4yQ9OqUjDCKWoZmEkofnWc/elSIHDGPa80rkQwHBXhEIu2HGmwbLZUiVNWCG9A
         squxFhD1+NOfK9lK4ePve7cKak2cbuz4j72P7E0PgRCfCKYQRFlRVHj55iKCgtevF0sf
         g9/RTFATOytmmfEx1BNN7eiNYGe2O8eeE+6WdrCl6tV+T1ry/cgT20LK9aJsHmShcgyq
         r8Cw==
X-Forwarded-Encrypted: i=1; AFNElJ+I2BvF2Q4Y5JDstalsScbJGnoa5rpzYjzbyVVvyiw/5cxTM/PRsUoMp/6IhNGHo8gE/PDwCXxm7pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEJWsPPNR+Rw0dK9NAx1GNiL+PcqWdOI0yDGZY1jHdtfNbhsG8
	fxjJkWSmtmWkTkUHsKavFyePAZFNacX7L9YvDL+jawUIQja43iyYBHc/9AUW4o4chcQ=
X-Gm-Gg: AeBDieuc6Huq2a9NwFK251+zTgl+Aq5CWFz8HwNwPfJK0o5r+oxsgyWXrD6bA/ztz9p
	TC0Ta5FjulcNwNzis/GGvwU4WNWcfVv7TTHb92gVdA+gC8o0ez+w382yXrzOIuyOim13ecIbtbq
	AQ/8h5Zw+UgciVb8zE3hduGQsXcMF5ohBMgKnVd/7ERa1USI1QxbQttsK5SF06r/DcNQk9C574Y
	oCxxCB2oXvYflhIsR2tS3xu8FmNs4SdVhGW/ltje8us3QuUjM9ZZqeWcMZiMw2/TexJnBkWCGby
	vU2FA6mnR1Xf9WzZRm3LJW1JdAIWpSSPR2p1JYJPI+WUTDnMNZaenT+harn8ukuszTZLL01K9Kt
	VZOhqBz0fw07ZEiJeXV+Od+2I5GNChch2T42VJpg2VLtG6mp2ko81QXXi3z0f/w2k8EQJ9zD67k
	L8vekBzo7RlnZJQC9TmG7a3yGS1X/2H8Zyuq4h+SyLtvrQvT3pCAroHTZ4Gg==
X-Received: by 2002:a05:7022:e20:b0:12d:31cb:b806 with SMTP id a92af1059eb24-12d31cbbb35mr3958686c88.26.1776827413109;
        Tue, 21 Apr 2026 20:10:13 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:190:8d7a:82e2:3eb2:7d54:139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20eb5sm27450210c88.14.2026.04.21.20.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:10:12 -0700 (PDT)
From: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>,
	Eduardo Augusto <eduardoaugustoabc@ime.usp.br>,
	Christian Barry <christian.barry@ime.usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3] iio: adc: mcp320x: refactor driver to use bitfield API
Date: Tue, 21 Apr 2026 23:56:54 -0300
Message-ID: <20260422030846.45317-1-gustavo.pagnotta@ime.usp.br>
X-Mailer: git-send-email 2.43.0
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
v2 -> v3:
 - Removed wildcard 'X' from all macros (including MCP355X -> MCP3550),
using lowest part number instead.
 - Separated Tx channel masks for 4-channel (MCP3004) and
8-channel (MCP3008).
 - Added comment explaining MCP3550 Data and Status bits usage.
 - Replaced be16_to_cpup() and be32_to_cpup() with get_unaligned_be16()
and get_unaligned_be32(), moving them inside the relevant switch cases.
 - Fixed accidental removal of '~' operator in MCP3550 overrange clearing.

v1 -> v2:
 - Sent previously as an unversioned reply to the v1 thread.
 - Fixed typo in author's email address.
---
 drivers/iio/adc/mcp320x.c | 70 +++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 57cff3772ebe..e7146c6af4f9 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -44,6 +44,38 @@
 #include <linux/mod_devicetable.h>
 #include <linux/iio/iio.h>
 #include <linux/regulator/consumer.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
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
+/* * MCP3550 Data and Status bits
+ * See mcp320x_adc_conversion() for details on when these are used.
+ */
+#define MCP3550_DATA_MASK	GENMASK(31, 8)
+#define MCP3550_SGN		BIT(23)
+#define MCP3550_OVR		BIT(22)
 
 enum {
 	mcp3001,
@@ -99,19 +131,22 @@ struct mcp320x {
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
+		       FIELD_PREP(MCP3002_SGL_DIFF, !differential) |
+		       FIELD_PREP(MCP3002_CH_MASK, channel);
 	case mcp3004:
 	case mcp3204:
+		return FIELD_PREP(MCP3004_START_BIT, 1) |
+		       FIELD_PREP(MCP3004_SGL_DIFF, !differential) |
+		       FIELD_PREP(MCP3004_CH_MASK, channel);
 	case mcp3008:
 	case mcp3208:
-		return ((start_bit << 6) | (!differential << 5) |
-							(channel << 2));
+		return FIELD_PREP(MCP3008_START_BIT, 1) |
+		       FIELD_PREP(MCP3008_SGL_DIFF, !differential) |
+		       FIELD_PREP(MCP3008_CH_MASK, channel);
 	default:
 		return -EINVAL;
 	}
@@ -142,45 +177,44 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
 
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
 	case mcp3301:
-		*val = sign_extend32((adc->rx_buf[0] & 0x1f) << 8
-				    | adc->rx_buf[1], 12);
+		*val = sign_extend32(FIELD_GET(MCP3301_DATA_MASK, get_unaligned_be16(adc->rx_buf)), 12);
 		return 0;
 	case mcp3550_50:
 	case mcp3550_60:
 	case mcp3551:
 	case mcp3553: {
-		u32 raw = be32_to_cpup((__be32 *)adc->rx_buf);
+		u32 raw = get_unaligned_be32(adc->rx_buf);
 
 		if (!(adc->spi->mode & SPI_CPOL))
 			raw <<= 1; /* strip Data Ready bit in SPI mode 0,0 */
 
+		raw = FIELD_GET(MCP3550_DATA_MASK, raw);
 		/*
 		 * If the input is within -vref and vref, bit 21 is the sign.
 		 * Up to 12% overrange or underrange are allowed, in which case
 		 * bit 23 is the sign and bit 0 to 21 is the value.
 		 */
-		raw >>= 8;
-		if (raw & BIT(22) && raw & BIT(23))
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

