Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D64279792
	for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976318; cv=none; b=NVCdlc5OkNLT15Zj4BEnoAn12n6ssU5/BUDzYPQxMHZdBdKzf2l51nYtgqlETP13+O4NbC/QHQBahIEzpuyJVF/n/pDr0XyQu9vDTUlI/VtY4xR5T42Un8GXibJOMx8n6yqMrhJyQnW5EqofFedj+TN0+gx+Lw4rnfbIGo7h1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976318; c=relaxed/simple;
	bh=bNI9riTSmou7+zW+mF5Zb+cHzMSVVsaXDh2lYEatQQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pl4FDrrdxm2+IsZSze6Srophd1e0abl0d2q+u8Yk22A4u/llGtxdAEsRt6Ci670zj45pE+bylyGHqk9bgcRvZ+XfNmDk0TAJ+GZn2DPJ4kq7aF/Q4drHsb0wCF7uiKgYdojBs6MgzFefwLvCDJdHeobNqGFr5ezPPMqkP9WgWts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agxcVUNo; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agxcVUNo"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bd124546379so1909905466b.3
        for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779976315; x=1780581115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqOemnD04LJjQnMzwMBgcGs6gZ1ngsn7g7S9Cna4sh0=;
        b=agxcVUNoXS0667varjCB/l8usoQRDYzC5dLGzKK+J++F3MLdH3t2wtlPsD1C/TbHAS
         /TCGKcXiNLUpQ+PR3hLQWgNmdtg098ZwoLI8VirthUFh5rPC+ztBSb83CAAwQcGvCf8/
         8jN7h4DoCd+jFMZ+lW9nWWro5/JbxgIOIlwGLU4qnPxLImT8MAq2CjTfpataX7fY110e
         FSO9WoKoWIiREo2/cbGbsE+NyVm1WYGmpAtjAj248lpbZVVCQUnyGMJSveeygShEgMeq
         7HtaQp7DiV7npQcVm7t+VGq7SxCa6XGp28tuZIxVv+onrZmVS01hxNb8inIuNLxDBVsF
         24lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779976315; x=1780581115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HqOemnD04LJjQnMzwMBgcGs6gZ1ngsn7g7S9Cna4sh0=;
        b=TANlz6VOKB0/N/9xznsB5GvUvkyy3R36PBsXUL2DIDRFebI1Q4OGvT0Kqje5HXlgSJ
         IZHGyObtec3UdWjN7TfoL6Z3RDhZuDTjJ27CiAYEbNGBevyCyjVQ43s7cAhIOpseLAwt
         fajg7QlwsfrJZufkRfnDgc+KomALdRzEaFGiSk2JjjDJu73ZLm2y8K6mat2pWY/tiLdR
         FuwhMqcphUZA8KoJFD+zNwXQbtYF49ITropmUwsPQdIjdAsqBp2kwqrQQ1R+MeZkGO9Y
         eeHDutXxQdPow+q7d/Z8K/Y5PjqOBqbFRrK8cDNh/GpfUgf+VRuc/O6ToVEIqiYGF5jV
         EYTA==
X-Forwarded-Encrypted: i=1; AFNElJ9H1Sik52kR0Q5bQF+tVo+Fuv+9MVlk2dI4Ac48ZM7grj07YTBeIY7NSgIbrIj1iELc+G+Caw3cgUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgl+TRCz/TjUtXN/42vsGmDDa/Q/RePA/PQ6qMDUCa4XFYuahd
	qwEPyfoexTrXnaqHNUz/C7JB2iTBxiOtNeehAaQmyQFT9tXqTo34eJBV
X-Gm-Gg: Acq92OH0lcu5LiTNXt8EjkmsSWKde9QVXcKD23Jl1CUfIGOiYL4R9srmHa5bAFW+iTU
	5LSuyHF3sq3ag2JPED71BB+AyciBVilQYklCTvYZABKyYupJKDu4WGaLG7QOhgOskGmx8e0wdry
	FX6GysVSRkonT8p58l8ahjhj96VnnQD3uJn6ymchn+fmNxu/ISN2w0uFbp1grwxN+7sDn91eb1c
	84mp0aq9gUASIVpI1cAmbey06Y/hQw3XGKzLUBRYdi/zHJDetaGeqsSoWqJahrKEIqrgYm9N2th
	r49SogDovquKl32gnP1uPLxo1xBpBHd0Q7oE0RD7cHQjWduzgbFQYO+/knsd+y7LciAU9gHQQQd
	p2phqpANG7bJXazu4/FwlWxqzLVbWQdlW0IvO57RPkWCEupyOo/Byw/RR4LPcJm3Ucm12z5eVz0
	p++54ON4cu9EidLweS5yqq27M=
X-Received: by 2002:a17:907:2665:b0:bd1:d549:decc with SMTP id a640c23a62f3a-bdd23af346bmr1376086666b.20.1779976314604;
        Thu, 28 May 2026 06:51:54 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc65da3bbsm723636566b.52.2026.05.28.06.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:51:54 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v2 4/6] mfd: lm3533: Set DMA mask
Date: Thu, 28 May 2026 16:51:21 +0300
Message-ID: <20260528135123.103745-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528135123.103745-1-clamor95@gmail.com>
References: <20260528135123.103745-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Missing coherent_dma_mask assigning triggers the following warning in
dmesg:

[    3.287872] platform lm3533-backlight.0: DMA mask not set

Since this warning might be elevated to an error in the future, set
coherent_dma_mask to zero because both the core and cells do not utilize
DMA.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 519f8c16a3f3..3cfdebf5fb52 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -526,6 +526,10 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 				   LM3533_BOOST_FREQ_MAX);
 	lm3533->boost_freq = lm3533->boost_freq / (500 * KILO) - 1;
 
+	/* LM3533 and child devices do not use DMA */
+	i2c->dev.coherent_dma_mask = 0;
+	i2c->dev.dma_mask = &i2c->dev.coherent_dma_mask;
+
 	return lm3533_device_init(lm3533);
 }
 
-- 
2.51.0

