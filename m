Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FEB2E091B
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153536; cv=none; b=VX9HZooASNIbTespiKrc7/fePKlqc/Ju0WGKyWk5nFIrLXOcOfHVFjR8OUvwNExw9+y9jZYfDFamFhpSoLXnEFxUr9XebEdMTK3bhERGxNzheuEeDjtfyn8m+Mz3GIaQqHQ/RWY8ljJ4EtrCdBnqh/OZ82C79cUoITm0W6UGsLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153536; c=relaxed/simple;
	bh=AvFivWHR6AnBEng6tYufmh/r4xxaaTDjy8KAOiceg0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPuQ7PVwxksjLW8aUrAakW2righwaYmqbVPJ1LUdovJX8dUz14MqhzNRNNOBPyGDt3gtPs9nR5tj1HJHTynbk1nSw6psXz0n39Yo+PRvrkiqdOaHRa02b7SWSL5+CJOOqMNtgWt9uKFHNtC19XmOMUYt5+U6Ti4Q+82EIJe0LoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6yhLrzW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6yhLrzW"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439c43992ffso390371f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773153533; x=1773758333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f1J+bRUFK3Q26QD6HRU4/njBTw/ikUzFk2xKndnAo4E=;
        b=l6yhLrzW4JFT5dFNb4x30P1jsdy0wR42Pqm6H2VzkvYzeEVrLoxjk0BgYBaLWKWQNj
         Ej5EwP4UfXUrQSKiBog2pnrxIivM5MZ64pp8c1put0BiOGQyocCs890GXlrm9hSiDPt+
         l666cE8sFEFZ8Tb8UTg8vlENITrLN0ug8uNvelOSknaEioNK0gusWUBMMHshqHtWxPw9
         q2aK/wLPvqaqJv0o1jhLmNhq64LHOiyJgbYTutmirn/oUiPrfnk8cFYZr1G8WS3xdrBF
         rDQalT/VRoJiRwyevi5dlwiqDqdZ2cFlDMX/hxhnX6wgNYdo7Ifj3wQuCXqxNO8vCsp3
         ojjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153533; x=1773758333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1J+bRUFK3Q26QD6HRU4/njBTw/ikUzFk2xKndnAo4E=;
        b=qhvPeHz/dk4TAg8ai0cqEYE3L92eiwgWGxvvjoZXuHzWNXu3flIEPjiCjo3Rui6gsy
         9aOuAeeSjQTJ3BEJlEiqcCYYht264LpR0S4xN27iUWbw8MDbcWHOdxJKhRZOwaRN6cgl
         QNnnUQvJxXBHGn9Ol10Scs9z/vTozXt6ETMC5u6bTI315j8CvuHwA7n6Zq2YjUnURCb6
         +DgoQLz39lSnfgYAnAMib+4g65dPfZC/5ZnMrIRyZEJT9jgvXskYvECGjZfA3WlikTrk
         ++zoyjMfmGnFompu6IDYwUtC+p3mjvmRJaldk4DfQ9uy9qAc2ZlSc490v/M+svzUN8k9
         znIg==
X-Forwarded-Encrypted: i=1; AJvYcCV64JTwaKoncmKs8+m6EYkJirMDsD8XSkuD3VHPu5YuAJqnYLL3yjvzdV4M8a7+KqtwSB3qfjOrsj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrACiYV9ljpv9gZjoaggu0jNA09CVVYAz4eG4zqItnOxf5AgWn
	nNIDNE7qBWO43JT61oHymn8ItDsuIYYzpm+N09CmzHqOsq4DuJMt+gzT
X-Gm-Gg: ATEYQzy3rL/4Elj1BvJRwokydA9MLzB8IHCIUB/J2s6dNjHrZFn6Mwv6ZCIOZC5DCFe
	/YtAsmVh/KNEY8H7bIsbJ8BuGVwan/fnOv4a+Pyfa5r/zT6eG0k4YvDFHcDyyx8b5481CaPBqND
	m9Sk/jygKMoXAXriAEKznXeALwmhFMurxUQgop5YJJzD7pkoM/XWxxwpnW5n8ZNo/M7932ifrOQ
	eE33x4ph2wh+/9FxHDWXSun88HoQwQl/xh9jKcHvtx3mW0/YOKc7KZALeB6ughrHm69nOrqZERj
	OofL3AaX1qjtFmDj76oik24hSZ+hBp8/p+FtmWf9ivADn158aa4ngboI+87CxAnIQu3pTwV7uGW
	pNX6DgPH7vYB65m9Jypx5DI0InqqjZnzimfLFqdALAkNkSCt4Jwbx5sxs/lb3aUH4DcUSPCT9pA
	l2BS+utWn7z1R7fhfwMPxF7EF35lbnQTcMpcvPmJV2npMi63Tvp5yn9pvusGHOlIF4mvQhLcglj
	nKq8juSxlgl29pcEdHFfMEX95kos/DHurFfRjerNF25hQm9Fr6vcto/dMjMQAg=
X-Received: by 2002:a5d:5d0f:0:b0:439:bdd7:4258 with SMTP id ffacd0b85a97d-439da8a0481mr15127077f8f.7.1773153533171;
        Tue, 10 Mar 2026 07:38:53 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dadac2a7sm37671323f8f.15.2026.03.10.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:38:52 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: adc: mt6359-auxadc: Fix comma spacing
Date: Tue, 10 Mar 2026 18:38:10 +0400
Message-ID: <20260310143809.83126-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect whitespace around comma on line 325 to comply with
kernel coding style. This silences checkpatch errors "ERROR: space
prohibited before that ','" and "ERROR: space required after that ','".
No functional change.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/mt6359-auxadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index f426a289e867..6b9ed9b1fde2 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -322,7 +322,7 @@ static const struct mtk_pmic_auxadc_chan mt6359_auxadc_ch_desc[] = {
 	MTK_PMIC_ADC_CHAN(BATADC, PMIC_AUXADC_RQST0, 0, PMIC_AUXADC_IMP1, 15, 128, 7, 2),
 	MTK_PMIC_ADC_CHAN(BAT_TEMP, PMIC_AUXADC_RQST0, 3, PMIC_AUXADC_IMP1, 15, 8, 5, 2),
 	MTK_PMIC_ADC_CHAN(CHIP_TEMP, PMIC_AUXADC_RQST0, 4, PMIC_AUXADC_IMP1, 15, 8, 1, 1),
-	MTK_PMIC_ADC_CHAN(ACCDET, PMIC_AUXADC_RQST0, 5, PMIC_AUXADC_IMP1, 15 ,8, 1, 1),
+	MTK_PMIC_ADC_CHAN(ACCDET, PMIC_AUXADC_RQST0, 5, PMIC_AUXADC_IMP1, 15, 8, 1, 1),
 	MTK_PMIC_ADC_CHAN(VDCXO, PMIC_AUXADC_RQST0, 6, PMIC_AUXADC_IMP1, 15, 8, 3, 2),
 	MTK_PMIC_ADC_CHAN(TSX_TEMP, PMIC_AUXADC_RQST0, 7, PMIC_AUXADC_IMP1, 15, 128, 1, 1),
 	MTK_PMIC_ADC_CHAN(HPOFS_CAL, PMIC_AUXADC_RQST0, 9, PMIC_AUXADC_IMP1, 15, 256, 1, 1),
-- 
2.52.0

