Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61353EBF20
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663694; cv=none; b=biK3tDQUJ9ZyYviOkyTJgjhx/8ypYPBJBIdukNCHcN02tKNDDJ5PBwG8V8nKAN006vzb6+YuNVRK2D0ZwqDe1KC3ODGxcIhDYAY8FznAFONn4X6wW7ChcIIKsFh3KZA5IMb8c1AyOa7tUT9BklYIxOT1aqxIlNx8Htxot1gY8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663694; c=relaxed/simple;
	bh=tEtX8XXlTS2MqEgJr5MBxmS+I62Ko0qVZDquyT1rVu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lqB0GehuhemuJjg/eStxBl1FLTD3Ma6qjmup+/KNCNc1cB26hZS3UjCRTjlDqKiS6Du2TPRpuSP1Rsg9NFoDbtmygJHIGWiw0UGDnEZjtV7eLZva4Fy59ZeLmBL/mUYybnwMGmn9LyR4gxKj9VtPYyXegJq+oTWoDfBmSpMsoaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Kzno1qd6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Kzno1qd6"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d734223e4so4005132f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 02:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778663689; x=1779268489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2w9rjHTs0iet/rZ6jwqd03mVv1gF87Jcorfz748ksg=;
        b=Kzno1qd6jYjo2ep91fjbwKqRkJ+WzgINpQ28QK5utCYgSxw8gP3EsqpA7moGKjhMAS
         EXV690DfCrfbKnC0mR5yCqCQnidPXm5FUT71rBqxDqKzrWXgHjhLg8JpQcuRrzEyaShQ
         F9BGoMVLGddRQ0DOWuBBnMKMPcLjK/aYRXb1Bmgz2uDZV/wI9R0/z/gPiYuAQGYC1cht
         t7NfQM1fO2LMy+gylnTgeD5B2CsXiW2lL82YRplpxW4B585ufgRr8+4J7ePfqYqf/2Zz
         CxjryjnzNVPlJgSCY3GGeMqIwF4TjsD99HT6SZ6j0rifhAFlg5YrlBMWqueFmsZ5KLLP
         K++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663689; x=1779268489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n2w9rjHTs0iet/rZ6jwqd03mVv1gF87Jcorfz748ksg=;
        b=RdNbdVQVak8qNM3KyL5xI+PCT+q5QSo8LZtO4UcF9mPKkBVSD8hahYefLAMM4Rw7nJ
         jQH9sjKhLnN17uDuz5P2lHbKg2/7fjAF37RTdlovpmf5Lkx3YpUuTbaDs1XGjaJhOOUj
         N24MDijwJaS4/RfnZhav4/9OevGO37h4fAIvNAEPR+o7W7ZiwXUVoZsIeAj1t2F/i/Ri
         8Xvau9twKeSpDRsQ8vxFsS5499HR0wOWOzywmGuh5glKXP1qzSRrcZTMFnXRwE6JaY5M
         qo+pWd6yuclYfsG4ZFBDPGrHuvGdCjXNV1TC/SPmdMe09/cgCIP5+3ixjWLMZLvzfibL
         +ziQ==
X-Forwarded-Encrypted: i=1; AFNElJ+t85ahtY6JuZ+Qk1GT2H5Al2NxHQy2AumFdx6yR/It6Aa99GWN2B6OtORdZcNd6dcIIaBKNrwkn3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfmtmdzyV83nJ8PXqhRdS/Ni7nh99CBxyoYSzzZA11pvgp5U0A
	+tKqiBUzzJfnu+FN2/yGFVefYNuUHyMYUdJlCOed1+Su+MrOsg9Khqt8DbyJtqEZW80=
X-Gm-Gg: Acq92OEgjROCUCftrvPQfCWYiAo73Hfamt9v6GIPG5tJ8rC647PkCoa8PpXMTr8J1z4
	R25Zz8zFDcsQ2LhX3WbgK4Dgkou74ry7e2Y06XgwXL3tcdI9vpfpdWyCdPBy0nO88nJYBkKuXSy
	ErKQbndYnQMINsrYhIXdQ5yRc4ppFFKtHmmSY47Uk4qXx/hHhH61aANXl0zPF8dENoSS8nGx8ph
	cbLptD+OYh9kGbJohMoMMT/ZWBfm1LU/8joUddNcBVIUrwDIFcvMSWfwveoNMxeVR1Ds+KUzpST
	fQB3zo+c/I49XZPZg6FY0E4KhrzOaxHQsyfaQj0ZQI79wwIkC6bR70MsLiCdMus32CfsvIJZ3bN
	pd6yWZ6TNnjIhH7IDMdy54RO2KjkRFhGX5kloyI9cOoBtiFa+SvxSaZqCGtpuOMO7H3gBma0V9T
	eGoJNS4pnXQJ8selPRyLXw5xNlFD+lU2Y=
X-Received: by 2002:a05:6000:2289:b0:43e:b0f8:e019 with SMTP id ffacd0b85a97d-45c440bcda9mr4275393f8f.7.1778663689569;
        Wed, 13 May 2026 02:14:49 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm34590821f8f.4.2026.05.13.02.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:14:49 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 13 May 2026 11:14:33 +0200
Subject: [PATCH v2 09/11] m68k: stmark2: use ioport.h macros for resources
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-wip-stmark2-dac-v2-9-fcdae50cf51a@baylibre.com>
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
In-Reply-To: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
To: Greg Ungerer <gerg@linux-m68k.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, 
 Arnd Bergmann <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.15.2

From: Angelo Dureghello <adureghello@baylibre.com>

Align also other resource declaration using DEFINE_RES_.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 arch/m68k/coldfire/stmark2.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/m68k/coldfire/stmark2.c b/arch/m68k/coldfire/stmark2.c
index aa2b4d2a8a64..a5b36af8e70a 100644
--- a/arch/m68k/coldfire/stmark2.c
+++ b/arch/m68k/coldfire/stmark2.c
@@ -63,21 +63,10 @@ static struct fsl_dspi_platform_data dspi_spi0_info = {
 };
 
 static struct resource dspi_spi0_resource[] = {
-	[0] = {
-		.start = MCFDSPI_BASE0,
-		.end   = MCFDSPI_BASE0 + 0xFF,
-		.flags = IORESOURCE_MEM,
-		},
-	[1] = {
-		.start = 12,
-		.end   = 13,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = MCF_IRQ_DSPI0,
-		.end   = MCF_IRQ_DSPI0,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_MEM(MCFDSPI_BASE0, 0x100),
+	DEFINE_RES_DMA(12),
+	DEFINE_RES_DMA(13),
+	DEFINE_RES_IRQ(MCF_IRQ_DSPI0),
 };
 
 static u64 stmark2_dspi_mask = DMA_BIT_MASK(32);

-- 
2.54.0

