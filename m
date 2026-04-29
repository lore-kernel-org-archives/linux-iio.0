Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A8B2E175F
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494224; cv=none; b=tbyhW2TlHt8gk8n4mUmMr7pTq1U+IysaY5Ti/C5CCaDh+oCl5jiQbnBe/mNeVqOxIotv0c4NbyuwgpMDS7oWU3OVK6qRbL9zAwPitjt7cEGi3JhCYaFk5goPVcvdFB/Dym8NjA+iS1Z4zn9xwDdEJRVH4eOgtD/E3ZNN3To8wSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494224; c=relaxed/simple;
	bh=c815y4BhIE0nDp7Y/Vvf4QIB47StqGCLELEdDNa82bo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=okFuSCw8Ky9H1AGD/06NWGD8BEPYPz+QGpVPkuHApPfdYnYZ+Agrf5u1vvjv5UJlFTK8AD/G+Jvy1vzEUkjnWKBjO3HjN811csAooRYqAn/Tq7q8R6U9JUdHFf980fimTwO39gbh5hZeDvLpFbZelPFo1dfvVBrTberqzUloaV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=OXGfvRob; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="OXGfvRob"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2d9916deb14so395581eec.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 13:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777494220; x=1778099020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8oLfHh4ZAwMjKoOaZe7Ln1qurpiLRfZnVBdkwDiWqpg=;
        b=OXGfvRob9M2L3hjuRfE8IGRF6C+Xp1JKBNDTrzrFYC2fb6dCV1r+qAxA9FSm8JN84I
         HCkw7j6Xl6ZlnM1xBqLQiifM45ks4iTZqHtXfTPr8HC7GdsYOcm8u9Qes5iE8DBE9d2w
         ZhWsB9L4w3JtznCA0+mQuHzAAKeBq4iEiYNTqoqP8AVnt3XwwEbnGPGr5+CiIYxaC7Cx
         BTYmlCLh2k2qIUQEipaaQWSuFol4wXlKrCuajBKQgBZk01OKd+6M9LSU4fObEEnSP53Z
         LVRkQiiuNVsomaARcwgaAvjxMwOQgDHP2kj+PUr8RAAxBAPy2L6DQum11kzGCGzLla1m
         Xzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777494220; x=1778099020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oLfHh4ZAwMjKoOaZe7Ln1qurpiLRfZnVBdkwDiWqpg=;
        b=jnfkKQqVvqXs+mLxxgUeM6xNdfVpCLI6vcrMo6UlCJX8ksfKTAhvSdNxcYvUqzz32e
         uejy8qQfcKQVu8keCQZe2FvvXW/VcSwXF/722wCyS3sbM8SbvH1NCMeqZUjjY2ub6/c1
         6vvj6mCqT8QXoU9aogiX5myhUDZwpsv4g6q+nuOKGqgKJIYub2U1s3xk6RedMIzyZ13G
         a77vepwtHbR0Qz/otvFwgIuc1/LIUcteXrNyF/ut4e0MwGrOr3ADTXoLniOK90+JDv66
         T+RzIyalY7aF9f3PCS9oYPMd/6+8XNQKBiTRMzzTJwcCqgl2IChpmH6rrItMkglUwUoi
         +QUg==
X-Forwarded-Encrypted: i=1; AFNElJ+YzwIKLLEfHNh66jsb7C8Rnwtgdt8eMT4TIAFUommEz4GSxrvdeKLr7TzQWspPpb4B0mScYnwEdl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnYi87nNJdSCHaplzz9AksUVNaXZHEocCae3Qou3W0rK9DcPZz
	JSr1WnJqNTDRt6CcFVdumn55bFqxWH0v2CS3DiV5p18L/xWLAjW0MQf/W++ED0Ec+i8=
X-Gm-Gg: AeBDieu0zB1G0bu+xrxSEtB5KE8IFRmM3LdElB180vUx6YOjeSwpZFb04KCDRRhP2U2
	8c8XLBFeJh9qlGLvxNdecTIRKv5ArVBVHfDvR/PDlVkuaP73onFAOuhiGog0go1EGwxR0HjVVsq
	Ol6N2mahyqVdYebb+GFQterszmw1yBjQnxSpWUaS59Tx3y+suS3wH9ktCnCEZ+8fvTTTKU/Lr91
	EBmH+RM3vVdSm3bELxmGJ3nNyXOgjnrILKbjA4XEnkpGux2CBQr/vr63PXHM6oPAwT21qk7Zq2z
	DwpzJAcSXlExNICeAPdJWqJEwTkf4ctovSLG7wHp4tJfRow+15C+PNbCrGc6T+XHTnunY16fnWW
	JhiniHQV+5GW2NEcexqoP0bKW3sezSb0M+fB2J31Vkaq0CwG1pQtY1nIPkK/7yxKGU+xpCaht3a
	yBZoh4QpB5qxebd45yJUYDVUAkt4uDdHK5l3hYvH/vRrLG7WHu
X-Received: by 2002:a05:7300:fb95:b0:2ed:e17:d50c with SMTP id 5a478bee46e88-2ed0e17d711mr4096395eec.31.1777494220082;
        Wed, 29 Apr 2026 13:23:40 -0700 (PDT)
Received: from noteducg.tailba73d2.ts.net ([189.121.202.171])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1bf8e281sm3761492eec.9.2026.04.29.13.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 13:23:39 -0700 (PDT)
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
Date: Wed, 29 Apr 2026 17:23:04 -0300
Message-Id: <20260429202304.25308-1-educg550@usp.br>
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

Signed-off-by: Eduardo Guedes <educg550@usp.br>
Co-developed-by: Lucca Ciriac <luccaciriac@usp.br>
Signed-off-by: Lucca Ciriac <luccaciriac@usp.br>
---
 drivers/iio/frequency/adf4377.c | 80 +++++++++++++++------------------
 1 file changed, 35 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index ff6077e29..461eada66 100644
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
+		scoped_guard(mutex, &st->lock)
+			return notifier_from_errno(adf4377_init(st));
 	}
 
 	return NOTIFY_OK;
-- 
2.39.5

