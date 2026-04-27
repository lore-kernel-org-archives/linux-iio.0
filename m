Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098A3EE1F8
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777316939; cv=none; b=jWVXDdtJAroZypD3yDN1FLH7AcNdWshY2DxyqmWZAVwTnsNi9t4eNvzF3+Cx9KJxzpxy2hHQVc11e4XrCn4V6YpUyHqwlrj/0ruCnyuC3P2ZypSYJ3FYonXvUac22h4QDOiDKYSRPhTG6+9ZF+nFWS0LgL9CwwKL6pFHtWJEhr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777316939; c=relaxed/simple;
	bh=Akn3iB4bFuxCQFbqQ3c7B3zgWSwIMH4AiVxTuqgmFQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LCg2FZCViT6EOrTxPBtgdpgYKCQpzTH2WilmPmMI1Y0Y2sS8NbFeuNjpinJKh0vRe4sE5tZ/nzcfrwywGBYSjbkPUrZziiTKFm3IldShBpyT8C4nygFH5HwcO4ykgxr1Lgu/ASw80CzC1mmoX1aHBwL8hVDNQLyad1m187o5uug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSo0dq2y; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSo0dq2y"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4411e1eba51so7287426f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777316937; x=1777921737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FwBDxvhhf1dytDgVC9wEZNucPdGR8g31jisecswPi0k=;
        b=mSo0dq2y4O+zbkz381eVub+nFrNinNY9tnpG8s8zlCfMDgUlDyzqVhbQLD9vY/PIiy
         K8Korm9+8YMxTsYVjCHOhiv1PQIYCFjjfvZvI24W4EOqVJ/GZTRtqKUncbTHMTwlclUm
         9xfGFOKom96a/qvHOGYWnCpZK0M7J7tQ5ctl4qO42NXcmLN+TFOjg5V1RMf10Bt8Lduq
         Vsprg3muGW6BfInz2+wdXYza+mAxh3ydgvk+pgyz46U5mi+oz71dF8wZtgUqGoG4ARqC
         lcCxrPGNFf0li1m0FZSCAF+rwYld5YAnCagwkmnpwogD/V5JUNQVxHjXKMRIMxRhCs8J
         AS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777316937; x=1777921737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwBDxvhhf1dytDgVC9wEZNucPdGR8g31jisecswPi0k=;
        b=ZWJeB7RJjAlg14XyCNyjtwSzwxg7N4Q9pRNsTPocx8r4pHaGZClF1AmcJhMcUbC4F6
         EpjtUnM3T9nE0JdhxYb8B43QCzHWOoqibHF+7VhfCqhzAvvtMuufcdc/5VUGkQaVixSm
         /nEwHFnG6aI/zWEVKAeLVEZ8wavoYmjpMCdn7R1V2vW3CT6tdTo41GEizXDJ2S9n7E14
         NrkpNVJI4IFYdBh9erL8oUv/JjsnIAi/e7ocWlCnich3cLn/Aikg7dJVcj+Nh495Hp4G
         d46DFPpBMokkQMBpOsta0n1nrf77KFUSMF5ZSOxFAV7cJwJ8RLDlWUw7McX738XTa9YZ
         FDtw==
X-Gm-Message-State: AOJu0Yzmz21MGnQR+GSsDmHkzG+P6c3X+AcfUSj7JMSxBORHRAcgnNpo
	v0jr/D0PPE/8ycBYQxCCtUl3L3xd6jn+8yXfdDEPmGqmUO2LTvui/LU5
X-Gm-Gg: AeBDietONJuxSPa23/iQTx9FWz9RIQp97AVJrGZ0BHRdOat1oMtttScMYBnFDcRLZlz
	+kGoS84zlzHG/OIG8etUD7idFmpXH339yOfLiBA3hLJNxWOTh+tZCMLE+eOfPMyoDEPZtBDS0zx
	skN2Ri0jxsD8/cVPkUw5yKw3B0myoqpl8a8smVgYAEIDf1sQfO+cChTsTWvqWwsguXpMI32G1G/
	FSDkNSm21o55DdIRR90EZtXZ/Im2Zh7GmV7dzpRHG0gGSx5hnu0DG0c9AhM1E/Jy9KGEoemRLdz
	l51OkjNqqlv0W7rRpkLnLWY15QqpbKOINnE+hR11k/07WfypdOXhKbI3yltk3nn7pfvLhUgm10M
	Zgd209xIRftpKahqsQIO67WgE3IX7V9kpAFqFPvFyATwkHh/wh64/CqomtodMZJP0fge7oLY/Ac
	Lb+1zW5296xp2mB226fIflUW5gfyfqal26/OkFJgyWjx5ACDDN
X-Received: by 2002:a05:6000:240e:b0:43d:6fb7:fee1 with SMTP id ffacd0b85a97d-4464aced261mr153573f8f.46.1777316936724;
        Mon, 27 Apr 2026 12:08:56 -0700 (PDT)
Received: from localhost.localdomain ([196.235.239.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463cb59d5esm504286f8f.7.2026.04.27.12.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 12:08:56 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v3] iio: adc: mt6359: fix unchecked return value in mt6358_read_imp
Date: Mon, 27 Apr 2026 20:08:49 +0100
Message-ID: <20260427190849.14963-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mt6358_read_imp(), the variable val_v is passed to regmap_read()
but the return value is not checked. If the read fails, val_v remains
uninitialized and its random stack content is subsequently reported
as a measurement result.

Initialize val_v to zero to ensure a predictable value is reported
in case of bus failure and to prevent potential stack data leakage.
This also satisfies static analyzers that might otherwise flag the
variable as used uninitialized.

Fixes: 3587914bf61 ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v3:
- Initialize val_v to zero at declaration instead of checking regmap_read()
  return value, as suggested by Jonathan Cameron and Andy Shevchenko.
- Update commit message to reflect this new approach

Changes in v2:
- Added Fixes tag.
- Re-examined the entire driver for unchecked regmap operations.
  While several regmap_write() and regmap_set_bits() calls also ignore
  return values, I focused on this specific regmap_read() in
  mt6358_read_imp() because it leads to an uninitialized variable usage
  (val_v). This makes this fix critical for reporting correct data
  to userspace

 drivers/iio/adc/mt6359-auxadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index 6b9ed9b1fde2..0e52effa55db 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -489,7 +489,7 @@ static int mt6358_read_imp(struct mt6359_auxadc *adc_dev,
 	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
 	struct regmap *regmap = adc_dev->regmap;
 	u16 reg_adc0 = cinfo->regs[PMIC_AUXADC_ADC0];
-	u32 val_v;
+	u32 val_v = 0;
 	int ret;
 
 	ret = mt6358_start_imp_conv(adc_dev, chan);
-- 
2.43.0

