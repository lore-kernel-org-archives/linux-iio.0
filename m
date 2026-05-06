Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9BB481A88
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078674; cv=none; b=bpFBMHJ+cU4bNNZ/V8fz/CV69Yw+AAYz89TryqjqKT3qEK+iK0adFg6OjE+Vr0xX9lIH5PPG+tDSatxwkC1bPsRAWRDS+rPyQT2UNkdWNYbHmj2ikIxSaah7KYlIf9Hbf1WUsNwCXDyuDCIzLF2rW0XpZbh55RarcLRCIMRLWlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078674; c=relaxed/simple;
	bh=wBFD+oIHujxWpM0Pl9v/V3zAmsyb5b5tc0fKebUHdCg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f35+1GN36P+EaEwhBwbyT1b1+pk1Fxa6iOT4DHFu9fpNEoTuyCTRnrobHWdwn/WuFQb4QtJUe+U9U22mZu9Runp3s04A0NapSAG+OfkhiIcX6rBMzBlkCq4sA53hWau7+Bz4BD2yIKgJmDw4/PggjWMozvB6S5RqmlEaqwDf/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=iwm6IgkI; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="iwm6IgkI"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b4520f6b32so10152389eec.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 07:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778078669; x=1778683469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wwWphopB1wMyI3qcas3sYQPbCwL79i1pmGvMvg6lYkA=;
        b=iwm6IgkIT8KuqZ4CjqXLUgj0LTpnSN61SegrewkLTKuSm0Y23piQTGNEAzZSLKb4rl
         tVnVCH2+rIHhX4JUjTWp9ml7H2sIci0ioJOJ9BdqR62M4ufsXyfqkTODS1/aC7UqtnT7
         pPa0WnoO+bg+j1FKvcgMGqN6dFOY4Q7rYs/fWrWZD71eyTsUN+wGdxryIQLzE8ugEKSe
         rD+4VXM/cP55wEHkWrqVUPcFzru2+c9fLe9TAgBM85qi78Lu9dVZEO1s8kDz+dFEkB6i
         6L4mS3Fy992R7ahFNn7SQr9cz64lk8AQu/nXIbRuLNJ7otMqyRo1/VVANUfzBYpgIH+y
         uXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778078669; x=1778683469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwWphopB1wMyI3qcas3sYQPbCwL79i1pmGvMvg6lYkA=;
        b=jjgeV8ls3OAEb9ESnzRbHCnkOZ6UupnPYfCvgaRaoj5nmWx5/MDoPkMZTk1lDInaIS
         N1Q6TQFPritBWaXwAOJF6Z0Svblc7grIpuSWjFFtleLQTv3wxnCvE3x/51OX1JvgzOzM
         fi2tCloO4UDmuJpGZZG0ONy3m7EwI3I4zCmHxC+dPYUbd6bXIFJ9KtxZ11eXakhTJ0tz
         uNRumS6HAgUxrze26m3Ruh09+L9BnLjWoFcN0YB5/2I7PWRNOvMYIfx0qcyKGEgb5fU6
         ecuamOeC14P1QzMaHMFtg88uXw/EeJoRVq4B1v7RtpYuTiMlY9w9O/sbErPnKRo+8GnK
         EgDw==
X-Forwarded-Encrypted: i=1; AFNElJ+E6izYJDZky1OaJGDpUAdEKHqhm+rEr7dgSIF6oQnonRt+ENLEU7s5TbJ58/rUWbAoPsF6Yq0m5dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSYPN8HCukcANWvfqQIOmfvK8Ey+GO6TcRtx2dI56ORW+HNQtF
	rFfYDyP53/veMAnGEaaPpQzoXg97SYcSjzZArHuGjZM/ptM02dkQyGJQP4oSjgz1pns=
X-Gm-Gg: AeBDievSiZjOrXuMR+4HJVOQoONKkAVb9LFxPhHQKGZtvN3DCwQJBVGrnGmiV7Xxyzp
	9c711KxKHFDJiS5mZ0U2hkOaVAcCSVPHlQ4dSVtnZeBfgqZLZvj+dbBxjukMuFJxBd/sX3UQJka
	eoLcDkGTFhEOxgf35yeXP092INbk8JSR9fwFXjEr4h4QcDnEKSQOg4Gc28uQx6t/WzSvlvSB3CV
	DFfVDod24FD2zbP4ZJIH2wEHxLKcIvFTv+d+naIdtC8SWKP6hBAkLnAsBUXdr6uUen9m5768rNH
	RDT6sa3yIqqx4A9twgci+5KDNDDAmVGQsJ/Xz7Aj6BHUzu+wqYPHC9nvERYoyKjTAWsfgGWgxrI
	lurtU+gQpXyFu0H7pij03DyJe0/9hW2vE0zB0QS7XuVnR7EjEW59x47WN612w9ibDAPNWJTckSb
	jnOO0poMucbOfAtEBxDaltlRvfPHRa3wXsEBMTfYz/dNp8/he93Q==
X-Received: by 2002:a05:7022:672c:b0:12d:de3f:f3e7 with SMTP id a92af1059eb24-131a69f32d3mr1807468c88.39.1778078669266;
        Wed, 06 May 2026 07:44:29 -0700 (PDT)
Received: from noteducg.tailba73d2.ts.net ([189.98.252.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-131f968cad4sm3365749c88.6.2026.05.06.07.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:44:28 -0700 (PDT)
From: Educg550 <educg550@usp.br>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	antoniu.miclaus@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: educg550@usp.br,
	Lucca Ciriac <luccaciriac@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: frequency: adf4377: replace mutex_lock/unlock with guard and scoped_guard
Date: Wed,  6 May 2026 11:43:59 -0300
Message-Id: <20260506144359.16744-1-educg550@usp.br>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduardo Guedes <educg550@usp.br>

Replace manual mutex_lock()/mutex_unlock() calls with guard(mutex) and
scoped_guard(mutex) from cleanup.h.

Using guard(mutex) and scoped_guard(mutex) from cleanup.h allows the
compiler to enforce lock release on every exit path, eliminating the
error-prone manual lock/unlock pattern and the goto-based exit labels
that existed in adf4377_get_freq() and adf4377_set_freq(). This reduces
the chance of lock imbalance bugs.

Signed-off-by: Eduardo Guedes <educg550@usp.br>
Co-developed-by: Lucca Ciriac <luccaciriac@usp.br>
Signed-off-by: Lucca Ciriac <luccaciriac@usp.br>
---
 drivers/iio/frequency/adf4377.c | 80 +++++++++++++++------------------
 1 file changed, 35 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index ff6077e29..f91b9c6e2 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
@@ -518,14 +519,15 @@ static int adf4377_get_freq(struct adf4377_state *st, u64 *freq)
 	u64 clkin_freq;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = regmap_read(st->regmap, 0x12, &ref_div_factor);
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = regmap_bulk_read(st->regmap, 0x10, st->buf, sizeof(st->buf));
 	if (ret)
-		goto exit;
+		return ret;
 
 	clkin_freq = clk_get_rate(st->clkin);
 	ref_div_factor = FIELD_GET(ADF4377_0012_R_DIV_MSK, ref_div_factor);
@@ -533,10 +535,8 @@ static int adf4377_get_freq(struct adf4377_state *st, u64 *freq)
 			  get_unaligned_le16(&st->buf));
 
 	*freq = div_u64(clkin_freq, ref_div_factor) * n_int;
-exit:
-	mutex_unlock(&st->lock);
 
-	return ret;
+	return 0;
 }
 
 static int adf4377_set_freq(struct adf4377_state *st, u64 freq)
@@ -545,26 +545,24 @@ static int adf4377_set_freq(struct adf4377_state *st, u64 freq)
 	u64 f_vco;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
-	if (freq > ADF4377_MAX_CLKPN_FREQ || freq < ADF4377_MIN_CLKPN_FREQ) {
-		ret = -EINVAL;
-		goto exit;
-	}
+	if (freq > ADF4377_MAX_CLKPN_FREQ || freq < ADF4377_MIN_CLKPN_FREQ)
+		return -EINVAL;
 
 	ret = regmap_update_bits(st->regmap, 0x1C, ADF4377_001C_EN_DNCLK_MSK |
 				 ADF4377_001C_EN_DRCLK_MSK,
 				 FIELD_PREP(ADF4377_001C_EN_DNCLK_MSK, 1) |
 				 FIELD_PREP(ADF4377_001C_EN_DRCLK_MSK, 1));
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = regmap_update_bits(st->regmap, 0x11, ADF4377_0011_EN_AUTOCAL_MSK |
 				 ADF4377_0011_DCLK_DIV2_MSK,
 				 FIELD_PREP(ADF4377_0011_EN_AUTOCAL_MSK, 1) |
 				 FIELD_PREP(ADF4377_0011_DCLK_DIV2_MSK, st->dclk_div2));
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = regmap_update_bits(st->regmap, 0x2E, ADF4377_002E_EN_ADC_CNV_MSK |
 				 ADF4377_002E_EN_ADC_MSK |
@@ -574,56 +572,56 @@ static int adf4377_set_freq(struct adf4377_state *st, u64 freq)
 				 FIELD_PREP(ADF4377_002E_ADC_A_CONV_MSK,
 					    ADF4377_002E_ADC_A_CONV_VCO_CALIB));
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = regmap_update_bits(st->regmap, 0x20, ADF4377_0020_EN_ADC_CLK_MSK,
 				 FIELD_PREP(ADF4377_0020_EN_ADC_CLK_MSK, 1));
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = regmap_update_bits(st->regmap, 0x2F, ADF4377_002F_DCLK_DIV1_MSK,
 				 FIELD_PREP(ADF4377_002F_DCLK_DIV1_MSK, st->dclk_div1));
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = regmap_update_bits(st->regmap, 0x24, ADF4377_0024_DCLK_MODE_MSK,
 				 FIELD_PREP(ADF4377_0024_DCLK_MODE_MSK, st->dclk_mode));
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = regmap_write(st->regmap, 0x27,
 			   FIELD_PREP(ADF4377_0027_SYNTH_LOCK_TO_LSB_MSK,
 				      st->synth_lock_timeout));
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = regmap_update_bits(st->regmap, 0x28, ADF4377_0028_SYNTH_LOCK_TO_MSB_MSK,
 				 FIELD_PREP(ADF4377_0028_SYNTH_LOCK_TO_MSB_MSK,
 					    st->synth_lock_timeout >> 8));
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = regmap_write(st->regmap, 0x29,
 			   FIELD_PREP(ADF4377_0029_VCO_ALC_TO_LSB_MSK,
 				      st->vco_alc_timeout));
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = regmap_update_bits(st->regmap, 0x2A, ADF4377_002A_VCO_ALC_TO_MSB_MSK,
 				 FIELD_PREP(ADF4377_002A_VCO_ALC_TO_MSB_MSK,
 					    st->vco_alc_timeout >> 8));
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = regmap_write(st->regmap, 0x26,
 			   FIELD_PREP(ADF4377_0026_VCO_BAND_DIV_MSK, st->vco_band_div));
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = regmap_write(st->regmap, 0x2D,
 			   FIELD_PREP(ADF4377_002D_ADC_CLK_DIV_MSK, st->adc_clk_div));
 	if (ret)
-		goto exit;
+		return ret;
 
 	st->clkout_div_sel = 0;
 
@@ -641,24 +639,24 @@ static int adf4377_set_freq(struct adf4377_state *st, u64 freq)
 				 FIELD_PREP(ADF4377_0011_EN_RDBLR_MSK, 0) |
 				 FIELD_PREP(ADF4377_0011_N_INT_MSB_MSK, st->n_int >> 8));
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = regmap_update_bits(st->regmap, 0x12, ADF4377_0012_R_DIV_MSK |
 				 ADF4377_0012_CLKOUT_DIV_MSK,
 				 FIELD_PREP(ADF4377_0012_CLKOUT_DIV_MSK, st->clkout_div_sel) |
 				 FIELD_PREP(ADF4377_0012_R_DIV_MSK, st->ref_div_factor));
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = regmap_write(st->regmap, 0x10,
 			   FIELD_PREP(ADF4377_0010_N_INT_LSB_MSK, st->n_int));
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = regmap_read_poll_timeout(st->regmap, 0x49, read_val,
 				       !(read_val & (ADF4377_0049_FSM_BUSY_MSK)), 200, 200 * 100);
 	if (ret)
-		goto exit;
+		return ret;
 
 	/* Disable EN_DNCLK, EN_DRCLK */
 	ret = regmap_update_bits(st->regmap, 0x1C, ADF4377_001C_EN_DNCLK_MSK |
@@ -666,26 +664,21 @@ static int adf4377_set_freq(struct adf4377_state *st, u64 freq)
 				 FIELD_PREP(ADF4377_001C_EN_DNCLK_MSK, 0) |
 				 FIELD_PREP(ADF4377_001C_EN_DRCLK_MSK, 0));
 	if (ret)
-		goto exit;
+		return ret;
 
 	/* Disable EN_ADC_CLK */
 	ret = regmap_update_bits(st->regmap, 0x20, ADF4377_0020_EN_ADC_CLK_MSK,
 				 FIELD_PREP(ADF4377_0020_EN_ADC_CLK_MSK, 0));
 	if (ret)
-		goto exit;
+		return ret;
 
 	/* Set output Amplitude */
-	ret = regmap_update_bits(st->regmap, 0x19, ADF4377_0019_CLKOUT2_OP_MSK |
-				 ADF4377_0019_CLKOUT1_OP_MSK,
-				 FIELD_PREP(ADF4377_0019_CLKOUT1_OP_MSK,
-					    ADF4377_0019_CLKOUT_420MV) |
-				 FIELD_PREP(ADF4377_0019_CLKOUT2_OP_MSK,
-					    ADF4377_0019_CLKOUT_420MV));
-
-exit:
-	mutex_unlock(&st->lock);
-
-	return ret;
+	return regmap_update_bits(st->regmap, 0x19, ADF4377_0019_CLKOUT2_OP_MSK |
+				  ADF4377_0019_CLKOUT1_OP_MSK,
+				  FIELD_PREP(ADF4377_0019_CLKOUT1_OP_MSK,
+					     ADF4377_0019_CLKOUT_420MV) |
+				  FIELD_PREP(ADF4377_0019_CLKOUT2_OP_MSK,
+					     ADF4377_0019_CLKOUT_420MV));
 }
 
 static void adf4377_gpio_init(struct adf4377_state *st)
@@ -919,13 +912,10 @@ static int adf4377_properties_parse(struct adf4377_state *st)
 static int adf4377_freq_change(struct notifier_block *nb, unsigned long action, void *data)
 {
 	struct adf4377_state *st = container_of(nb, struct adf4377_state, nb);
-	int ret;
 
 	if (action == POST_RATE_CHANGE) {
-		mutex_lock(&st->lock);
-		ret = notifier_from_errno(adf4377_init(st));
-		mutex_unlock(&st->lock);
-		return ret;
+		guard(mutex)(&st->lock);
+		return notifier_from_errno(adf4377_init(st));
 	}
 
 	return NOTIFY_OK;
-- 
2.39.5

