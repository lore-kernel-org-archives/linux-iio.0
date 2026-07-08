Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5131A682C
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 01:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474150; cv=none; b=a9fF1TrHIkzzc6XS9q+fl2ujnfrPpKFDxIHPIyeMlFh9ZM9I3Xq5BFqkR0S13zzu/qeeKUCezec/sYoF23QbNrpUPAu+GJoHFm2IDjdHnGXo+r7ICRIMzHJpZt7nxj35EHtpLQU3UroMCpVpOYwa6TBkNP+MpXSVJ3hPOVHJ7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474150; c=relaxed/simple;
	bh=vLt/OK+Qt+XWikZ8IIBaJavNRNdKtQ+6qmVXNRWT9aE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gC3JqFpAJBLk6fmVGGNOvXK6kd4gCOD5w0ksiEmW/xl41xURSW+yjGno31ij15akP5ry5Ne6PRfLtgYD1pkr9m65w7LZfG14AVb3njqxTxzmtJWUNhc7zlK+H+jQycUH44uAp4NRrfZuHHQReiwnmLXxzHJYUmaZQgKZceMCAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=ehWpVG84; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="ehWpVG84"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cad8076b01so2062695ad.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Jul 2026 18:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1783474146; x=1784078946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LzX0H/mTvlZzHZblvop+b0eamhhavNSpPvDSZ253a2E=;
        b=ehWpVG84JUpPfzEqQK/o/oOnHZ8s30DU2ahHlk2BGl3D9xWjgzBu8jXW36DMZ1gkFU
         dwKaankJBQAmGe0D1HxbhDdDQ4QtzY8gL7casYCHygUdbZBp0L3zur3hhmRRVRdSAQbv
         8gKwJbOy/zsdZUNxEjX8VnVZWK5hGQF+NP2IBNYFuUAUqBIAD64OlGdXNtabcRuxVkko
         OxKPWh3PtI1ZdAprc2aZhTwfhZbk63vk85nGsVf1mWcClB4wu46UFwgaSqeBy7trZMmJ
         evdeCwrL9rjHr0UVgKNH3ZRrkKpTWtyCUprapOVN/lRwFka49XDDOp33hTXZFJ6LJyXs
         AIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783474146; x=1784078946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzX0H/mTvlZzHZblvop+b0eamhhavNSpPvDSZ253a2E=;
        b=GFXTrFhMXRsw/Q4JNEGSJGSfosI9s2KcHt8QZO5+Bps9l4zbqKU3hfkYqfWMcEc49O
         VzDunDR78neVsN4j2adhO0Js5R4yRh0FffzLIstyjQkXzoxNkPgkZdq8sbQu5KewYI/H
         OHs9/x51Znkci1uea7IAjMP1vLLLc0y/lycslyogl10mAPgEnImgAxwhmfOgWbgFHGU2
         69o6pvxVcShLqrT3wrejO/VMxFzmKiOsre48X44vNn1ApjTn6udIqBGZta+2Ops2grPI
         liETu+MkPDzORb7AvYIEkM0SGkJ8zsFFYnmcBrO5VkayiawwCvMc1s2V9rNyiRFzjKuH
         7kAA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2nHf3KqHesyS0M/AjH9alJK2mUgLtNtoCROfF/njURaHIPtfb4Wm3fSE8s34yss/MbG+CSaUJbs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX7uzNXbeO3K2kDsdY0xWfc23vT3N61k+IYToUtOTOVzBzr3rv
	12H2YWu0qLvFZTVofqwzD47rDel2Bg3gJC3a8awF5qu+DdfyIG6vSru7nPRBBZsF4Lo=
X-Gm-Gg: AfdE7cnAiSOsM2wgMdXHMFEpTmTNyyUBZp+POoaKgyjKf3wbSSn6G0CLDUFPs5x8lDN
	tz8RKdqqH2kcRhJLjyznsxI/xGLdlFkmz9vZ1pAuN1ssGKTxaoHfjPxegx/XefFahvTDygbWept
	w8zzMcnKO3JkJ8yvp8/DzDx5eY8BHkFU5kS67d6Iw0PMBYGMxBuckCeyP4+m1FLKkxMGm4tYenp
	izvKr8oD9AUB9Lu5vOQuLD0Cq8cqNjKm+7YpW9MMXYCP1wuM6UsSHuyFJq9fmE8TLFhJqD7UPDV
	CBm64/cl7neEBeJGiqLzveZXm6mkzGR2oVZw+GiLCVdxpqB63qy3mvAniFlchG4hwE7PLUPzIAm
	sSgfbraXSuHi0AhRv4wGH6vrC/bSXm3pC99bA90c6e5lwjpYpyK+K3fYL69lyYGa2g0lsztXLet
	QMduSCWAR5
X-Received: by 2002:a05:6a21:4cc5:b0:3c0:9c1a:8944 with SMTP id adf61e73a8af0-3c0bcd77b5bmr171685637.76.1783474146640;
        Tue, 07 Jul 2026 18:29:06 -0700 (PDT)
Received: from CaxaCaio.localdomain ([187.35.188.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm21357725c88.14.2026.07.07.18.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 18:29:06 -0700 (PDT)
From: Caio Groff <caio.groff@usp.br>
X-Google-Original-From: Caio Groff
To: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com,
	antoniu.miclaus@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org
Cc: Caio Groff <caio.groff@usp.br>,
	linux@analog.com,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: accel: adxl372: replace manual bitfield ops with FIELD_GET()
Date: Tue,  7 Jul 2026 22:29:27 -0300
Message-ID: <20260708013002.1377142-1-caio.groff@usp.br>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Caio Groff <caio.groff@usp.br>

Replace manual bit shifting and masking with FIELD_GET()
macros for clarity and consistency with kernel coding style.

Signed-off-by: Caio Groff <caio.groff@usp.br>
---
 drivers/iio/accel/adxl372.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index e375d068a3f5..fb985bfeb19f 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -150,6 +150,11 @@
 #define ADXL372_Y_AXIS_EN(x)			((x) & BIT(1))
 #define ADXL372_Z_AXIS_EN(x)			((x) & BIT(2))
 
+/* ADXL372_TIME_INACT */
+#define ADXL372_TIME_INACT_MASK_H  GENMASK(15, 8)
+#define ADXL372_TIME_INACT_MASK_L  GENMASK(7, 0)
+
+
 /*
  * At +/- 200g with 12-bit resolution, scale is computed as:
  * (200 + 200) * 9.81 / (2^12 - 1) = 0.958241
@@ -577,9 +582,8 @@ static int adxl372_set_inactivity_time_ms(struct adxl372_state *st,
 		scale_factor = st->chip_info->inact_time_scale_low_ms;
 
 	res = DIV_ROUND_CLOSEST(inact_time_ms, scale_factor);
-	reg_val_h = (res >> 8) & 0xFF;
-	reg_val_l = res & 0xFF;
-
+	reg_val_h = FIELD_GET(ADXL372_TIME_INACT_MASK_H, res);
+	reg_val_l = FIELD_GET(ADXL372_TIME_INACT_MASK_L, res);
 	ret = regmap_write(st->regmap, ADXL372_TIME_INACT_H, reg_val_h);
 	if (ret < 0)
 		return ret;
-- 
2.53.0

