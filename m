Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com [209.85.217.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594B930BF6D
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097852; cv=none; b=C3UsAOP9rPAXpxdUei2S2oEMsY+x/XAv45rhl2zoTzqKV1DzvkjjrJG02p1rekQtQnXY6Tlun/x0NjPZ9HXOWhSXRiRU28YIlW6EVO5po1Rzry7AjMGOlJwUG+hD8/wSdMqLXppaTAA0/RmrCzpAgmEl/fZVbQWNoW4ETvWdho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097852; c=relaxed/simple;
	bh=rIIBjxC0V7PFsI/L5nqxO/KRhyeqyPuBi0gscWQQDKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c6mrnxdKyGmNzIJ5esUHaGYrWslrhCpfcCb22dJUXkfZMzbhB1fYTjYxIm0n0aKvupWtGl2ICIo2p3VqnW3cpXPzWwJ494C3bJj1jf27h3qLyZCFgmSlG/e5xW5gEFCIVDpLX6Y0jdWxThN5uj/RDjI1NNqIYGSuKWyHjPthV64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=bzjGhQxk; arc=none smtp.client-ip=209.85.217.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="bzjGhQxk"
Received: by mail-vs1-f68.google.com with SMTP id ada2fe7eead31-6c534af2470so4418497137.3
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 06:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1781097846; x=1781702646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E+Pb0mON6Tueej+gVGierd5Xw+ll2+irQvcmDkpt5l8=;
        b=bzjGhQxkeRrQJTQWo4doXyvj1fkg2rsqfLZoaFyUs6rz+5yfROYS+dUbCnsbgvMNNv
         aZ1HtjjmxZtM39/fSWDWAHv/yxNzJWYoJTOjtfEBqDBlocX3Z/02jEGu8eFoC8eMqc2Q
         xHe0PZBTkAXi1hzNn/+FsJa4GjmfTi89TFipyOum8Ua1YnkNhGAtkYoanG/HThFPUPxO
         cuaPPTOOdABmSccLKCpG/fvLuOl/ZO6wMCR2QqezOJ/HzVH5keIFQ0oHVKGi26uwbKp6
         nu2znN4iXRH2Hz3HeVNkkdml1CooRAcvYwpzC4b0I6s4gcPUopXd4Ej+dtfV2IFaHVQC
         TwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781097846; x=1781702646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+Pb0mON6Tueej+gVGierd5Xw+ll2+irQvcmDkpt5l8=;
        b=AVVYRvRfFVkRsU3SBJdL4uV16CxonxN7cPtXxx7wtLLyTwxftVET2Xc5Xv+6rE7Rws
         qXsoeJPo6tzu1Apj32YAkBXudje70zOobJpftst1g3+qAvJmE/kctLfH/podNZ8Uf17E
         UHJ8ExHW/vM2K9x14ElQy6t3oyHNhBfEh2aYSKBiYKscsTPuNspJ0m9p1+WCM2i8fla6
         VwKkrdpDJ4fqsgurpgiCe30TW2cHRUyNquTJaiH8lsFiv7sW/QvmUCPKBWIh+IODIdlS
         CAmZIuHMWGDG46Y0j2S+ZpbLHAig/tDjWxSt7h78rCawpI7jk17wCJLjm9aH2MsIBSJ8
         9nag==
X-Forwarded-Encrypted: i=1; AFNElJ+5i4xFP5BFnRwTDW2m0XuG3Hc9v3OWzIfjZ9GX+xHm6on8zzSnidoxjY2JYN+gc74wTMdbWzPQcrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaOxrOZC0+GKZzk4bhp4uTejXILADbzzFacxcC6hjcILf8u9Ap
	gRSB7SKA1hj8X/d2Ai9rWAxXKVPRGqKm9baV5mkT+5/iVXUpZusznktR0xIA1u7r65M=
X-Gm-Gg: Acq92OEm5ZwPwmXxhsAujIuUh97lfuW9uqYAMzKMf1gtmZdwTALOOgs9VsbmjGl5saC
	6sD2Xoov1afMMYL0D4Izy0P5l2x+ohJm4i6z0wkQE+1mdIXeWVDqkpWSDgnu2D9+eRu0s0FM7ld
	Oq2cy/HMcSQVGzoGGVpB7XmSO4DAFWwuY4oEIek8zyUNkg2c6rzRy6rj9UbcE50t7PxvZj23cPS
	ICLOrOoSwS7g5cqvnH3LV9SiET+j0utGMNKmMrEK5ZfjHOs7ubq95AB3nkobc5gq/xbDCH3qV7L
	2LdGB7W6GkyUiyiLX/GDlPlYtJBqKRdm8FTYU9WEsJ3GfK6SmuBzzjLeYvhxMpxtfU54Kmr4jVr
	5i0lXlESCHjSBqleqRNW23fSwAqU/W4bvCm7ggf58499raTokOSWdm9PJZ0HWXW/vaZ+XKJxnaG
	Ac5QKXy4bJ6I0Q8cUl4lIqcNyQ0RKWgzouILOcHQ==
X-Received: by 2002:a05:6102:54ac:b0:6c5:d55d:c093 with SMTP id ada2fe7eead31-6feef48d084mr14683708137.8.1781097846241;
        Wed, 10 Jun 2026 06:24:06 -0700 (PDT)
Received: from localhost.localdomain ([189.33.66.35])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6eb36325d59sm20501551137.0.2026.06.10.06.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:24:05 -0700 (PDT)
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
Subject: [PATCH v3] iio: frequency: adf4377: replace mutex_lock/unlock with guard(mutex)()
Date: Wed, 10 Jun 2026 10:23:37 -0300
Message-Id: <20260610132337.229687-1-educg550@usp.br>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduardo Guedes <educg550@usp.br>

Replace manual mutex_lock()/mutex_unlock() calls with guard(mutex)() from
cleanup.h.

Using guard(mutex)() from cleanup.h allows the compiler to enforce lock
release on every exit path, eliminating the error-prone manual lock/unlock
pattern and the goto-based exit labels that existed in adf4377_get_freq()
and adf4377_set_freq(). This reduces the chance of lock imbalance bugs.

Signed-off-by: Eduardo Guedes <educg550@usp.br>
Co-developed-by: Lucca Ciriac <luccaciriac@usp.br>
Signed-off-by: Lucca Ciriac <luccaciriac@usp.br>
---
  V2 -> V3:
  - Drop the scoped_guard(mutex, ...) references from the commit message;
    adf4377_freq_change() was converted to guard(mutex)() in v2, so
    scoped_guard() is no longer used anywhere in the patch.
  - Add a blank line after guard(mutex)(&st->lock) in adf4377_freq_change().

  V1 -> V2:
  - Replace scoped_guard(mutex, ...) with guard(mutex)() in
    adf4377_freq_change(); nothing runs between taking the lock and the
    return, so guard(mutex)() reads more clearly.
  - Expand the commit message to explain the motivation for the conversion.

  - Replace scoped_guard(mutex, ...) with guard(mutex)() in
    adf4377_freq_change(); nothing runs between taking the lock and the
    return, so guard(mutex)() reads more clearly.
  - Expand the commit message to explain the motivation for the conversion.

v2: https://lore.kernel.org/linux-iio/20260506144359.16744-1-educg550@usp.br/
v1: https://lore.kernel.org/linux-iio/20260429202304.25308-1-educg550@usp.br/

 drivers/iio/frequency/adf4377.c | 81 +++++++++++++++------------------
 1 file changed, 36 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index ff6077e29c739..bb11ae1b89047 100644
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
@@ -919,13 +912,11 @@ static int adf4377_properties_parse(struct adf4377_state *st)
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
+
+		return notifier_from_errno(adf4377_init(st));
 	}
 
 	return NOTIFY_OK;
-- 
2.39.5

