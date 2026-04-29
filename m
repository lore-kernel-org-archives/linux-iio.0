Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0A839D6D3
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777502681; cv=none; b=sTeNl32wtjXZWbYML/bHAhfbv4asAX6lVQHpHuMtobjFZwI/sAdG8PPPQwHrRQk1X4YO+5eSP08D5X2kXyHIhX+XLvPnk59SgGCyFJ/jXlXzdYRZkKohmIbKKY3nGO2GXHzMi8oOVRnXXzkmdld2sZPRIwjkXUADlArQsCc/r18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777502681; c=relaxed/simple;
	bh=MeKpeZc+1N+EZyFHY1Sc1VSWM8G2RZ2MydPcRuFGx2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L73pgcLDYnHITahDEdixU8lwCIU+qGGKoYN89rFuO1NXbjmjLg7TFhebXHMPw01VXMG+rVrgtJr59T7eQl2D2a4kt0yzlRObp3nPBfXXVzUOpXh56nXSZ8M/jU4kzjQQlWa6zCzGP085KYowuUpcLKpmvCKGWHp6a1BlJDJ2AmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=OFXrJ5h7; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="OFXrJ5h7"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c15849aa2cso495917eec.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 15:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777502679; x=1778107479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwEYc8pMtmTricQrr3wsTXrOaKncEaUO8uYy+/UQj3M=;
        b=OFXrJ5h7ZVIWf3LCLZa7FmA0qB0w8S9/ZMwl/o2ZHrXNVY6yT3MHksX8a09a69Ht85
         7YfiYA71qJB5h4ZGVjmrtZV0RfObKQIiPrpUj0FRbHuwlSiydyNdPacA6Kl73cDPSwCp
         GNe8AXZOYedoRUnCq77Ef7LqJXW/ZmV+CH3OpIMVPu/CWioMkqW0HsGJbk/biUyptHy0
         PeZ+knisaeS3GwVGRN7CWTHb5zElLWzbJBJjY+nfWHP/IhsY4ZNcW3bH1Fonn9VDrbVZ
         YpPUiqWGYOgGMofyW92XNQT24NXE6LEUn+INP0QryXJdMRt7Qd9rhpY6alZu8Fw74hhv
         lLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777502679; x=1778107479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lwEYc8pMtmTricQrr3wsTXrOaKncEaUO8uYy+/UQj3M=;
        b=a4A/V1a85R+/JGvDQlDVZvB9A35r6ovD+jOVyo/qsJIKpWLEsBB/JWyRe12cqA+b4B
         NGWptFxrgGJVkX+zsHzkeDP4svgrTIs3dKmwMx5CpJLKgY9M2DSSlRhTuRduwhB/tF32
         Dp6sJCUhdLmb0d4cXRebfVATGChXHxxRtuMmH9RoFj1Bn96JvABMjh7HLobZNUiar1f8
         j510NNFjZ5KUnWMjP1/5UDCwZ4gUOZheued4q/Y/pZOuyNg45qzHLOTCGDobp9zaPfV6
         Ddjycu+Lvk5COQF2VfFnhihYYZTlS/nO2jE0HOiQ0tzCBx5/axYOeZpQWN4ga1L0Nz2q
         wuYA==
X-Forwarded-Encrypted: i=1; AFNElJ+ETLw0BR3qI96VMpAFFB6dGVhgxq7VSkdoPgEFxWxzycS9XnGAcTVpTr6VP65XUy7N+EOJYX4QGwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuY1QB08c2QClH7TocU3zi5EEwOpO2fqGJT7YluZMaM+PtWZp6
	EalMdKCo54gM2iFOvT8wU6ma5rTgV9yF4UpE4RLHeXSTa42T4hnkA1N0nJ3r6d8G+40=
X-Gm-Gg: AeBDiet15dhP/30p7wVazecB8l6VNfEpx/4TQdUIQagwLwv02CPIVPVAFTIwtCs0sUG
	M3DLK1EbQtpOoqcw52JzZaOVFOaEBzCBnPK0TZC+K6jvkLykA/hvS2e0FHHpR8Iy6BSlPBnfbl6
	qvij/Gt9Bm+etQKW9SHP9UD8oFso+IVIRgpzgzgUVtZsZk4hMPFPHmllAvhgtf3ttd+pc63cSKD
	lScY2FMapj//t2X/VM4LE/yXdyK/aP4MLdlOpZjTWbIgL3e8m99D0G2swWfpcfWX6JWbqtB6sow
	APPp+1v8jfOc17KvAzGHxqUd/LWZVROjviskiO+5SoxHJh71wCEKjAV+vBVqr2aWUnESll6BR98
	NqvRbgiS0trKouHlc0wgDjk/AzbVouqh5T4Qeu2kE9/RdYbZVdoZ+ex0p03ISPaPF2ZTDBy09/8
	Fe7tBGJsppgwVlrAaXxgCrDgO7NM4T1tJLzrrHeiY1k5RwYtuKTSocL53oplk5
X-Received: by 2002:a05:7300:e2cb:b0:2ed:e14:42e7 with SMTP id 5a478bee46e88-2ed3fe5adddmr106827eec.32.1777502678618;
        Wed, 29 Apr 2026 15:44:38 -0700 (PDT)
Received: from avocado.. (mvx-177-92-77-170.mundivox.com. [177.92.77.170])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1bf6d263sm4238222eec.5.2026.04.29.15.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 15:44:38 -0700 (PDT)
From: Marcelo Machado Lage <marcelomlage@usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: Marcelo Machado Lage <marcelomlage@usp.br>,
	Vinicius Lira <vinilira@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 2/2] iio: adc: mcp3422: write bit operations using bitfield.h APIs
Date: Wed, 29 Apr 2026 19:44:01 -0300
Message-Id: <20260429224401.11818-3-marcelomlage@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429224401.11818-1-marcelomlage@usp.br>
References: <20260429224401.11818-1-marcelomlage@usp.br>
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
v3 -> v4:
 - Fix operator style in line breaks inside mcp3422_probe(), following a request by Andy Shevchenko

v1: https://lore.kernel.org/linux-iio/20260417005041.484742-1-marcelomlage@usp.br/
v2: https://lore.kernel.org/linux-iio/20260417165747.507487-1-marcelomlage@usp.br/
v3: https://lore.kernel.org/linux-iio/20260420191455.529923-1-marcelomlage@usp.br/

 drivers/iio/adc/mcp3422.c | 54 +++++++++++++++------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 0cd0e7d39e39..0cbd7a874798 100644
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
@@ -377,10 +365,10 @@ static int mcp3422_probe(struct i2c_client *client)
 	}
 
 	/* meaningful default configuration */
-	config = (MCP3422_CONT_SAMPLING
-		| MCP3422_CHANNEL_VALUE(0)
-		| MCP3422_PGA_VALUE(MCP3422_PGA_1)
-		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
+	config = MCP3422_CONT_SAMPLING |
+		 FIELD_PREP(MCP3422_CHANNEL_MASK, 0) |
+		 FIELD_PREP(MCP3422_PGA_MASK, MCP3422_PGA_1) |
+		 FIELD_PREP(MCP3422_SRATE_MASK, MCP3422_SRATE_240);
 	err = mcp3422_update_config(adc, config);
 	if (err < 0)
 		return err;
-- 
2.34.1

