Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7484E3126CA
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782416309; cv=none; b=ngThYTBgJQ212IXe2LG5jISmHTv8lhsLSXgcav/bpnv2QFmWozSslOliYVYL8nfzXx+MyeKtSAJgO6V7DLBSXOm5kTM09Lr5c80mbaiviWEGuSjErl7emYRW69JNVhFS5Z5hgZz52M8hd1qA592vkMiMYpCI9KEhfYxSSzMjsMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782416309; c=relaxed/simple;
	bh=y5CtAQtTVGLiQMURU2TcdkK/MXhuskY0uAwiDaasPVI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=flh61QgeXQwxa0Q+smvj/L4d6ub+kYpB98Hmz8wnx+JGBi9a6yYxHQFWR2Q2hWA4I21fgp1bi6nG3BOWv6OqOxD13oa+DpPM6/txEHrclevGAQVh8k8uC8sC5VZQjgU1rup9mQ07SOEk6FTCzd5YGcm4eN5bp9/dXdbdY/LjMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX1dR/Qc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX1dR/Qc"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b3637b90so1429985e9.3
        for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782416305; x=1783021105; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BS81ZRzLE+rOBytYqmcQM9bZUvRznCGjziJLWViXokk=;
        b=fX1dR/Qc2m7CO0olG6S9ywGTwYpvplHxCANDUSS4vk0iJfJrpL4m+h+MXWPyo9caHv
         f4y+6YRpF/74kgC9cB7x1TLVj81erIA6iN18HrJzKgCA2d1Jk5EHcOcTvlKWXGoiIW7w
         q9wQRovoO8Tl68chs9XtELusogXxVLX8h7zxuXAPl2cRr+Gk5eBkl/v56YQ7bbxuWndt
         AxiwVrQ3VkCncrQbkugk+oYhQY2Vra+8QYtqPeRILXjaBEp3oUeeeg+zMzXpK4tY54qo
         vXWCVVyw4s98Rqe5Wwerwcd1SiAePcIFdqLogs3A3zAHftwIQXRstYR5IPLs5htD6Vsf
         dsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782416305; x=1783021105;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BS81ZRzLE+rOBytYqmcQM9bZUvRznCGjziJLWViXokk=;
        b=e+Ldy+88FelQA2oZQ2ehQ6I26p/uZCQmYNjRrZQ3zA2Jb8slh+mKroOZbw+Q/ReKZe
         eKq6K8icv94DlO1tmm5U/TtAP0Z9/rT6hIWoVtRmWXVdPL1OmHUC5KgjFkzF/ZVpOz7+
         PClW8JyH0lgmK0lTezWL8sY5dlC33vZwL+uPYBOXm7LdQ1YMxs37BeRKZN1d9Hjm22gm
         rOZX72sPTsHFWXI4jmq3YTUqbpavC8dX2+qfksbdPK7qqR4O1mkbN43W4Uuydtej6oVE
         aCqQzZUBwdKQn9UF8eCSdRxjhffMyJ7AD5bnnmXbmmI8J06W2Znk3E22ikOZoy05DjPF
         51kg==
X-Gm-Message-State: AOJu0Yzq2kGoe9923pSghTPlJGxyX1ET07IquETyNBcbYP4QDw4tcADq
	tuS7KZa/sYTMPjTfE93tSBQPfbVk9udakZ4cjyGrRf3NG+TGg4x+0usN
X-Gm-Gg: AfdE7ck1FizNXbg6XYhilHJ3EQC1eGFF63VfcrSgg7uoeOw9oqUAAK3YdDyGrofsULO
	5u8Qa0I1CgXvIB95KHI+FSqrR6Z5+cIhXzl4dJFltoHuFKj8o/PBRliwzhuihG3XRYweW1KjDNN
	M/elQq26dfCf9SzvHY8sNWPOiv2i/ACMnXBhphzVYQfhB8c3OYNa2P7cs7Qqu2MwhjaOFDXxr7u
	Ve4ilHRuIZv6QXGY21aJ+rO8NKtfOc/HHtCeLlv31WlWvJUfrjELSHmsF+e0t7gQGcxkdd/Tn+C
	RcXpi0ESQ41MFy07pbYPBaLoVo+E8GgKN5Rks+3GtjzSaE72pjHVSYMocZOa0zQCrXz5Q7GFJRU
	h+1GlaAe3MmUhaqRwoHtOiEQW8zTKutVI00FOp+lUycp4x7AhrHyBsEVhUG0B7fdKeG3PrX82dS
	+gaFJ2lXLyn1GVmZQuZlStnLr1sizgBW4+JH2objDg51fBYKMjTvP5W2n2Ac95KN27kRsBs6PLZ
	dNmZlgqLTbp83QoDpRgJYE58T4bbWoYlZ7/yjbCUF0hzsQT0YOOIrkIWqCAkRDLtf7X8yPjlUqR
	AwLq0Yminik8sasJRY7U
X-Received: by 2002:a05:600c:4b9a:b0:490:c2a3:23d3 with SMTP id 5b1f17b1804b1-4926689acf5mr40858655e9.35.1782416304752;
        Thu, 25 Jun 2026 12:38:24 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690168d5sm28898945e9.14.2026.06.25.12.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 12:38:24 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v2 0/3] iio: light: al3xxx: add missing REGMAP_I2C to
 Kconfig entries
Date: Thu, 25 Jun 2026 21:38:07 +0200
Message-Id: <20260625-fix-al3xxx-kconfig-v2-0-796cf8d7cc49@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NOw6DMBBEr4K2zka2ARepco+Iwqw/rAI4siPkC
 HH3OBwg5RvNvNkhu8Quw63ZIbmNM8e1gro0QJNZg0O2lUEJpYVWPXouaOa2lIJPiqvngNaO0gt
 hlJY91OErudo6pY+h8sT5HdPn/NjkL/2r2yQKtJ2kkQS15Lt7WAzPV4oLDMdxfAER2o5BtAAAA
 A==
X-Change-ID: 20260625-fix-al3xxx-kconfig-ddb1f00a2615
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782416304; l=2077;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=y5CtAQtTVGLiQMURU2TcdkK/MXhuskY0uAwiDaasPVI=;
 b=KPP0tBavKBldZuyp4EFVT0YCo1iluWhNOTWx7WoVh56t13WtmPWGKrjKQYzP8ktJurb1Udtst
 MefVDiIIyzuAOc3Y9ZZDaHUuZxBHqmP8c9TS1Wclz6gMSayX1TcUwgs
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

This series adds REGMAP_I2C support to three AL3xxx ambient light
sensors that were previously missing this dependency, causing build
failures.

To reproduce the build failure, run `make allnoconfig` and `make menuconfig`
in which you select IIO, I2C and any AL3xxx sensor and `make .` will
fail with errors such as:

drivers/iio/light/al3010.c: In function ‘al3010_probe’:
drivers/iio/light/al3010.c:185:24: error: implicit declaration of function ‘devm_regmap_init_i2c’ [-Wimplicit-function-declaration]
  185 |         data->regmap = devm_regmap_init_i2c(client, &al3010_regmap_config);
      |                        ^~~~~~~~~~~~~~~~~~~~
drivers/iio/light/al3010.c:185:22: error: assignment to ‘struct regmap *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
  185 |         data->regmap = devm_regmap_init_i2c(client, &al3010_regmap_config);
      |                      ^
drivers/iio/light/al3010.c: At top level:
drivers/iio/light/al3010.c:48:35: error: storage size of ‘al3010_regmap_config’ isn’t known
   48 | static const struct regmap_config al3010_regmap_config = {
      |                                   ^~~~~~~~~~~~~~~~~~~~

I made a separate commit for each driver, to ensure a proper Fixes:
tag is appended for easy backporting. Let me know if you prefer
squashing!

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v2:
- Change select keyword in commit message to lowercase
- Add example steps to reproduce build failure
- Link to v1: https://lore.kernel.org/r/20260625-fix-al3xxx-kconfig-v1-0-d41cbc0c3cf4@gmail.com

---
Joshua Crofts (3):
      iio: light: al3000a: add missing REGMAP_I2C to Kconfig
      iio: light: al3010: add missing REGMAP_I2C to Kconfig
      iio: light: al3320a: add missing REGMAP_I2C to Kconfig

 drivers/iio/light/Kconfig | 3 +++
 1 file changed, 3 insertions(+)
---
base-commit: 7667a80340e99fd45357d0c90ae05813b01bbfef
change-id: 20260625-fix-al3xxx-kconfig-ddb1f00a2615

Best regards,
-- 
Kind regards

CJD

