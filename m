Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CC13C2769
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776712540; cv=none; b=Z60ANWaibw89jtBWtzi/zX3jWILsZ19H9VQufVCls+mJh7TBaRBE8/utm6sO+GGC7hVyKkSpXI+DL9SVvLYEnXXlMMdpuvuaW137ukJZRh5lqP5xTvXfUArexfgOfnXSCOz+QIfqn0Ptf2wx6g8U2rXQexmc+WptziwrThLzZ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776712540; c=relaxed/simple;
	bh=RW/km90z6FNQmceZdxU/MQac5vfuDkv8GRYONfZKQms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ELXCaxVz0TKr+A73Qhhu7zCnx9JK8ZvOpQ98XF8YnG4rAT2U6hijJEhzXLprOOq01eekhV0O1ssWlD6w4M0FqaDy1IuomXp6GG2006iSJeogAUG7jw0b/yhp9xQAfdb2yExRE1ZIlPJ747RRLQB/NBUQKbUhtKg/ev5mQ/BDrG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=O4551Q2e; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="O4551Q2e"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c8f9846c8so1677882c88.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776712538; x=1777317338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWS3y/798vUgqOIoqq531PTYwrTPfmiXoJJTIAe2/y8=;
        b=O4551Q2e1KCE3ymOsEsEmayNakkBlwHn4HhBVgYfKHAm18EgbYrnUszKpqL2SBaqfR
         jJWl3LNFIFLYSt6pcbWqFfM7wxa3/q3qwfGA8ZU0g6zMH/K38c8ez1zBH2aqtSuDlZMS
         ZtaTaRj/Z1Yr5lfD726UZThDSQT6iE38Lhhd2S5xS8iKyByN1BVvZqbZu4icVBYDZP7E
         z6dgEsTYPbPf2Ew3oj1/EW8mZVaql+7iSX8mHJY53xCuMv/VKycGPfQ0gBUZxeXF6/lW
         1zvs4f5TlkGopRuJZxlryiL31LtzbrPG6IsX849KKL1/IQJTb8TUhFT7Iz2jGYBPDAw3
         qmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776712538; x=1777317338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EWS3y/798vUgqOIoqq531PTYwrTPfmiXoJJTIAe2/y8=;
        b=K/KxDOaX5/8+ntq0B8zjEt+4NrHvQjBKc1jpBAUg3jGGpxWQDKsbwiHL+DjEvgBD6L
         i6IpQ+JlSR44k89zfAtY9/xFvFHfCZBpwAqXJ1U4sxq8bFs5I8yurV8WwWyGxlPrXxuW
         T14xQ5XmPnrIf42wBHoZ7lzs8etW89fQPYNWnJDvII/xO03Kb3rWofKN2CW5sIaISV9a
         KYw9eSFfjudBd/tpwFJvh32nLowOtn7Wkc06QpvS8M7FujZvIar1Vm165bl9YTXgNX5W
         BAOyvkw/Fu0JxlwOR3BQANuIL1bubeUdU+t5zeemwbSG5xgQ8MXOoOb5hrgeqhfYrJBr
         DNnw==
X-Forwarded-Encrypted: i=1; AFNElJ9wuSRUV0Ud5bFcjkJD+i3qEa7yWhaa3ZV6mAK+6cVB3WDArJ76xl3/Z21OkxCedh95ZY76UJpg2i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKtyUDmOI8gvduK1z9sL2IcezkG9B9+aoXSu3XoBMuGf1nzw79
	zuJeF87lg4fOQ6CZ5U2YJpDLr7Zsz8JCYnOfy1gI5+qekvMR1vhcNB5fv2JRyUVGnvU=
X-Gm-Gg: AeBDiev7tmfKs5ZN7JD+GqK8kxjpwFjtSVtRXzCHDmRh8T1PzbQcG7Zs/0p6hPiG5k2
	QNWISgozMX9+Vm2eUiNuQ1DCnz71v2mdiWfvnMKm9wymnIJORpHjvV8ZPNj6fc0/wsC17Ogz3OQ
	JpeI6lk9C9xIxS4AcBVdvVpjRiawT8hWueEX3KCjY0cDTlutHyGIERSljiM1FUncYq3V0sJxiEj
	jU0qDCp6SlaSHreaCHwFhBom0oQMk/4UkKkwcUVcWqeCh8tX8jep8aHCM7bD00LvYdpeWeBvqal
	juX9Ei+kHfacNbGAuIh8Ubu1SP4cRnQxInCNRa63+A/RC7bE3XLjgytIKnw+fXvYfBgBuLDv9l8
	4VXkcheTd71Y8/FpPbLiM6KZTbP+AIb1j3iWLijVKru/bIF2cRSrPXlHitYPRjKVZ1MQC9uNicd
	49dpbSePO1HWkHrTi3EnZ9lfGMxZKBVHfj/Ot3LwORMFnHOL1G7muVQFiO/zV7
X-Received: by 2002:a05:7022:6981:b0:128:d29a:3d45 with SMTP id a92af1059eb24-12c73f9ad6bmr7242334c88.22.1776712537438;
        Mon, 20 Apr 2026 12:15:37 -0700 (PDT)
Received: from avocado.. (mvx-177-92-77-170.mundivox.com. [177.92.77.170])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a2ac32sm16106846c88.15.2026.04.20.12.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:15:36 -0700 (PDT)
From: Marcelo Machado Lage <marcelomlage@usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: Marcelo Machado Lage <marcelomlage@usp.br>,
	Vinicius Lira <vinilira@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 2/2] iio: adc: mcp3422: write bit operations with bitfield.h macros
Date: Mon, 20 Apr 2026 16:14:55 -0300
Message-Id: <20260420191455.529923-3-marcelomlage@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420191455.529923-1-marcelomlage@usp.br>
References: <20260420191455.529923-1-marcelomlage@usp.br>
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

Signed-off-by: Marcelo Machado Lage <marcelomlage@usp.br>
Co-developed-by: Vinicius Lira <vinilira@usp.br>
Signed-off-by: Vinicius Lira <vinilira@usp.br>
---

v1 -> v2:
 - Remove 3 further macros still present in v1 and replace their usages by inline calls to FIELD_GET(), following a request by Jonathan Comeron
v2 -> v3:
 - Apply stylistic changes to the definition block inside mcp3422_read_raw(), following a request by Andy Shevchenko

v1: https://lore.kernel.org/linux-iio/20260417005041.484742-1-marcelomlage@usp.br/
v2: https://lore.kernel.org/linux-iio/20260417165747.507487-1-marcelomlage@usp.br/

 drivers/iio/adc/mcp3422.c | 52 +++++++++++++++------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 0cd0e7d39e39..24906f152c56 100644
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
@@ -164,9 +157,8 @@ static int mcp3422_read_raw(struct iio_dev *iio,
 {
 	struct mcp3422 *adc = iio_priv(iio);
 	int err;
-
-	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
-	u8 pga		 = MCP3422_PGA(adc->config);
+	u8 sample_rate = FIELD_GET(MCP3422_SRATE_MASK, adc->config);
+	u8 pga = FIELD_GET(MCP3422_PGA_MASK, adc->config);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -182,7 +174,7 @@ static int mcp3422_read_raw(struct iio_dev *iio,
 		return IIO_VAL_INT_PLUS_NANO;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val1 = mcp3422_sample_rates[MCP3422_SAMPLE_RATE(adc->config)];
+		*val1 = mcp3422_sample_rates[FIELD_GET(MCP3422_SRATE_MASK, adc->config)];
 		return IIO_VAL_INT;
 
 	default:
@@ -200,7 +192,7 @@ static int mcp3422_write_raw(struct iio_dev *iio,
 	u8 temp;
 	u8 config = adc->config;
 	u8 req_channel = channel->channel;
-	u8 sample_rate = MCP3422_SAMPLE_RATE(config);
+	u8 sample_rate = FIELD_GET(MCP3422_SRATE_MASK, config);
 	u8 i;
 
 	switch (mask) {
@@ -212,10 +204,8 @@ static int mcp3422_write_raw(struct iio_dev *iio,
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
@@ -242,10 +232,8 @@ static int mcp3422_write_raw(struct iio_dev *iio,
 			return -EINVAL;
 		}
 
-		config &= ~MCP3422_CHANNEL_MASK;
-		config |= MCP3422_CHANNEL_VALUE(req_channel);
-		config &= ~MCP3422_SRATE_MASK;
-		config |= MCP3422_SAMPLE_RATE_VALUE(temp);
+		FIELD_MODIFY(MCP3422_CHANNEL_MASK, &config, req_channel);
+		FIELD_MODIFY(MCP3422_SRATE_MASK, &config, temp);
 
 		return mcp3422_update_config(adc, config);
 
@@ -284,7 +272,7 @@ static ssize_t mcp3422_show_scales(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct mcp3422 *adc = iio_priv(dev_to_iio_dev(dev));
-	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
+	u8 sample_rate = FIELD_GET(MCP3422_SRATE_MASK, adc->config);
 
 	return sprintf(buf, "0.%09u 0.%09u 0.%09u 0.%09u\n",
 		mcp3422_scales[sample_rate][0],
@@ -378,9 +366,9 @@ static int mcp3422_probe(struct i2c_client *client)
 
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

