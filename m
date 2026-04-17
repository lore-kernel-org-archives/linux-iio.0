Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F9E3203B6
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776445107; cv=none; b=u3RsQaI3x4HhKJ3VgT+w4egSRRd8+KEYW5h4qodrux2OUH3VAqmAYCX7zWfnmQZ9AWBLfbaEpazz4ohMO3hdBP1Ladx46kTp7FSGblo2rKE2GDbZxIxCM0YwEsu91aaP5HZE3ofVbgs2sS0hPuqFVKV8JaOSDAcuIFcJU5wmees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776445107; c=relaxed/simple;
	bh=e767eEyLtpD4IOpVpeRRyV8aLB0LkdaxSRk6vG3ieIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O6NI2NvNUZr/g4H3RoXgSW1+rpTbWAdLyhwVf1TXGYdO84yMvp4iu7a2daV0obGLSVOtoYd7uviH47843kpOWLYk1SL/7ngNU4WnvVYP+cSMNv+GSFZK+qaBAVbNeBtvKj4+W7XcsOerh+Z9UFGXTHhKgcAJ5OTgMSu00J3o0ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=N+bWc7P7; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="N+bWc7P7"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5673804da95so344637e0c.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 09:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776445105; x=1777049905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSEfN+zML0hlR/TJbxrlDksQ/6hse9WpXW7D8grrihw=;
        b=N+bWc7P7DIl7jeNGxDvQOfkJdGJ8iEFIJCbKSDNYMY674JCvD3WXVLd05fkAVxosVF
         93S5e6ZQcSOnxC7+eBqVeMBd8wwmAUBZ1P3q0OIKC0stqlQJBnoujr8YSJGaG9fiGBbD
         iDPy2SH1O4U6+Aq3omm8QakPuuvSfw8PJR6NV2ExwCAnMWu2IwyJWaBk3foSTWqT4CVZ
         AzcYsfsWNmMf/TndtQCUtYSUzG9yoarJ4fT+8L7E/wm1r1aDldPElZyknznZNm2lqVMB
         J5cD0pOvVv/zbWGc+YyIPKE7+0i9ggzQtAXtqMOGgjXhuQmaw9Nw3B+LI8W8stDVZc9d
         WVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776445105; x=1777049905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jSEfN+zML0hlR/TJbxrlDksQ/6hse9WpXW7D8grrihw=;
        b=eMe+1XYkpEQPIou/ltTwR7dwnI576sA3pAQYRuFEBPqoEuytsZr6c9xClzeEsUqASt
         RZoFg26UbNYnwCZcLRuaJ1M7jlJ9heP2J0goaGAZ3KmwnQGl47V3RuQ61XBvzOG8Z/mF
         /0VHH8QX26ZS58vIbYyuhYGrAqyNsxoJ2IHRuDKkxqxBNd7ZI3IA0C8ZJPZeKkCR8qvg
         9BhI/PhB3g4uphuVNhOekgQi7iAH3bXo28HwrQ6kX+/KXieVyZhGePzfu9rRzZr7AXB2
         sYXu9O+zui8e6DkxRseA4D4h5N0NbyohvIUsWtwxzOpOON0za8Zop77V7S4tNGYi8g21
         uquw==
X-Forwarded-Encrypted: i=1; AFNElJ/PiTok45IV/AapE0HL7BVnBd4kog1IWKkMy9F5ETMXL6BEonLiqkUoZcwJh43N1n0Ze0gZKNWr9oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/a+EghfQz7fxEzjcxfVnct8JTBjpsuieUMe3Nz3I/HKTV/8g
	XhiGT87n34BLdeinkgDAnuEqYIilONnFoB6hz0RAXwD9afuYN3zANwUrB+a8ennk8Zs=
X-Gm-Gg: AeBDies3LBz+jZV5sgYFFV8Mt1cfMzEkroG8WQUSchloqGrZFEaYPdqR2zdJytQ0hJa
	DNsXD+qc1xpM17s6aq881Km0USyQFxhO5wYW+wVjzxSdDWYfPo95qVRRy8o4hrgaOE0HEbgdlI1
	1SxCR54yLwJgv4ewn1nQOfP2vsEbcb/25xz5gEUHlquevRM7W+Mz+fLhfDesQCuiouVfckgTISX
	jfP+9F/9qgnrp2/xZHlX/r7gxhbxbtzb35w/tq6sDcYnVgpxZ3eioaAvmFdFpQZD0q8ZUvl1J75
	H4Supa771yOq7lxdvXFBIMCO6h24GMHwyw3JGxZpHNyjChrI/XVrEhT8Q+WsJR6QY4seibYV7V0
	JewH49DjbXFMmNcDp0U5WAUUqVBNscMaZYEpl8ShMbEAK6qFlgtR+1w5ts4gIu4tZ/zHMB+IwRs
	DEkkWgO7f0QMI/LkLg940C96sbsySjEB3P/XpBtkJqTHU2IOa0PU1apw==
X-Received: by 2002:a05:6122:169b:b0:56e:e33f:2ffd with SMTP id 71dfb90a1353d-56fa5a48b02mr1718917e0c.14.1776445104744;
        Fri, 17 Apr 2026 09:58:24 -0700 (PDT)
Received: from avocado.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91bf90fsm1195622e0c.1.2026.04.17.09.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 09:58:24 -0700 (PDT)
From: Marcelo Machado Lage <marcelomlage@usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: Marcelo Machado Lage <marcelomlage@usp.br>,
	Vinicius Lira <vinilira@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 2/2] iio: adc: mcp3422: write bit operations with bitfield macros
Date: Fri, 17 Apr 2026 13:57:47 -0300
Message-Id: <20260417165747.507487-3-marcelomlage@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417165747.507487-1-marcelomlage@usp.br>
References: <20260417165747.507487-1-marcelomlage@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual bit manipulations with FIELD_GET(), FIELD_PREP() and
FIELD_MODIFY() calls. The resulting code is more readable and
maintainable, and 6 macros previously defined in the header are not
needed anymore.

Following a request by Jonathan Cameron, this version of the patch
has 3 less macros than v1, now replaced by inline calls of FIELD_GET().
Thanks, Jonathan! 

Signed-off-by: Marcelo Machado Lage <marcelomlage@usp.br>
Co-developed-by: Vinicius Lira <vinilira@usp.br>
Signed-off-by: Vinicius Lira <vinilira@usp.br>
---
 drivers/iio/adc/mcp3422.c | 51 +++++++++++++++------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 59bf73304588..a2a7a850a825 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -13,6 +13,7 @@
  * voltage unit is nV.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -39,14 +40,6 @@
 #define MCP3422_PGA_8	3
 #define MCP3422_CONT_SAMPLING	BIT(4)
 
-#define MCP3422_CHANNEL(config)	(((config) & MCP3422_CHANNEL_MASK) >> 5)
-#define MCP3422_PGA(config)	((config) & MCP3422_PGA_MASK)
-#define MCP3422_SAMPLE_RATE(config)	(((config) & MCP3422_SRATE_MASK) >> 2)
-
-#define MCP3422_CHANNEL_VALUE(value) (((value) << 5) & MCP3422_CHANNEL_MASK)
-#define MCP3422_PGA_VALUE(value) ((value) & MCP3422_PGA_MASK)
-#define MCP3422_SAMPLE_RATE_VALUE(value) ((value << 2) & MCP3422_SRATE_MASK)
-
 #define MCP3422_CHAN(_index) \
 	{ \
 		.type = IIO_VOLTAGE, \
@@ -109,7 +102,7 @@ static int mcp3422_update_config(struct mcp3422 *adc, u8 newconfig)
 static int mcp3422_read(struct mcp3422 *adc, int *value, u8 *config)
 {
 	int ret = 0;
-	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
+	u8 sample_rate = FIELD_GET(MCP3422_SRATE_MASK, adc->config);
 	u8 buf[4] = {0, 0, 0, 0};
 	u32 temp;
 
@@ -137,18 +130,18 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
 
 	mutex_lock(&adc->lock);
 
-	if (req_channel != MCP3422_CHANNEL(adc->config)) {
+	if (req_channel != FIELD_GET(MCP3422_CHANNEL_MASK, adc->config)) {
 		config = adc->config;
-		config &= ~MCP3422_CHANNEL_MASK;
-		config |= MCP3422_CHANNEL_VALUE(req_channel);
-		config &= ~MCP3422_PGA_MASK;
-		config |= MCP3422_PGA_VALUE(adc->pga[req_channel]);
+
+		FIELD_MODIFY(MCP3422_CHANNEL_MASK, &config, req_channel);
+		FIELD_MODIFY(MCP3422_PGA_MASK, &config, adc->pga[req_channel]);
+
 		ret = mcp3422_update_config(adc, config);
 		if (ret < 0) {
 			mutex_unlock(&adc->lock);
 			return ret;
 		}
-		msleep(mcp3422_read_times[MCP3422_SAMPLE_RATE(adc->config)]);
+		msleep(mcp3422_read_times[FIELD_GET(MCP3422_SRATE_MASK, adc->config)]);
 	}
 
 	ret = mcp3422_read(adc, value, &config);
@@ -165,8 +158,8 @@ static int mcp3422_read_raw(struct iio_dev *iio,
 	struct mcp3422 *adc = iio_priv(iio);
 	int err;
 
-	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
-	u8 pga		 = MCP3422_PGA(adc->config);
+	u8 sample_rate = FIELD_GET(MCP3422_SRATE_MASK, adc->config);
+	u8 pga		 = FIELD_GET(MCP3422_PGA_MASK, adc->config);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -182,7 +175,7 @@ static int mcp3422_read_raw(struct iio_dev *iio,
 		return IIO_VAL_INT_PLUS_NANO;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val1 = mcp3422_sample_rates[MCP3422_SAMPLE_RATE(adc->config)];
+		*val1 = mcp3422_sample_rates[FIELD_GET(MCP3422_SRATE_MASK, adc->config)];
 		return IIO_VAL_INT;
 
 	default:
@@ -200,7 +193,7 @@ static int mcp3422_write_raw(struct iio_dev *iio,
 	u8 temp;
 	u8 config = adc->config;
 	u8 req_channel = channel->channel;
-	u8 sample_rate = MCP3422_SAMPLE_RATE(config);
+	u8 sample_rate = FIELD_GET(MCP3422_SRATE_MASK, config);
 	u8 i;
 
 	switch (mask) {
@@ -212,10 +205,8 @@ static int mcp3422_write_raw(struct iio_dev *iio,
 			if (val2 == mcp3422_scales[sample_rate][i]) {
 				adc->pga[req_channel] = i;
 
-				config &= ~MCP3422_CHANNEL_MASK;
-				config |= MCP3422_CHANNEL_VALUE(req_channel);
-				config &= ~MCP3422_PGA_MASK;
-				config |= MCP3422_PGA_VALUE(adc->pga[req_channel]);
+				FIELD_MODIFY(MCP3422_CHANNEL_MASK, &config, req_channel);
+				FIELD_MODIFY(MCP3422_PGA_MASK, &config, adc->pga[req_channel]);
 
 				return mcp3422_update_config(adc, config);
 			}
@@ -242,10 +233,8 @@ static int mcp3422_write_raw(struct iio_dev *iio,
 			return -EINVAL;
 		}
 
-		config &= ~MCP3422_CHANNEL_MASK;
-		config |= MCP3422_CHANNEL_VALUE(req_channel);
-		config &= ~MCP3422_SRATE_MASK;
-		config |= MCP3422_SAMPLE_RATE_VALUE(temp);
+		FIELD_MODIFY(MCP3422_CHANNEL_MASK, &config, req_channel);
+		FIELD_MODIFY(MCP3422_SRATE_MASK, &config, temp);
 
 		return mcp3422_update_config(adc, config);
 
@@ -284,7 +273,7 @@ static ssize_t mcp3422_show_scales(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct mcp3422 *adc = iio_priv(dev_to_iio_dev(dev));
-	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
+	u8 sample_rate = FIELD_GET(MCP3422_SRATE_MASK, adc->config);
 
 	return sprintf(buf, "0.%09u 0.%09u 0.%09u 0.%09u\n",
 		mcp3422_scales[sample_rate][0],
@@ -378,9 +367,9 @@ static int mcp3422_probe(struct i2c_client *client)
 
 	/* meaningful default configuration */
 	config = (MCP3422_CONT_SAMPLING
-		| MCP3422_CHANNEL_VALUE(0)
-		| MCP3422_PGA_VALUE(MCP3422_PGA_1)
-		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
+		| FIELD_PREP(MCP3422_CHANNEL_MASK, 0)
+		| FIELD_PREP(MCP3422_PGA_MASK, MCP3422_PGA_1)
+		| FIELD_PREP(MCP3422_SRATE_MASK, MCP3422_SRATE_240));
 	err = mcp3422_update_config(adc, config);
 	if (err < 0)
 		return err;
-- 
2.34.1

