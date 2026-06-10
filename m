Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC7A4921B4
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123722; cv=none; b=rYVF1YajPtciZS/NNd092+6r836sH0M6hhIDjkg0pNq8F49hgA4H0kiPh4qs7fOrJ4oCe/kISR53lzxFj1MKn8WxmrLUfKvfydm7Xti7fJhFxNp8q8mnesD8guF1OHuAhAyZHSu+YzRGbKdle7+ntyEzWxAZkZhQrxge+uHtRf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123722; c=relaxed/simple;
	bh=vZ/qSwgZaeGKIkwuebGoICNFAldlYX5GSoxxjgASp5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MvBtZ1Q63FNaxeJoectrZDBRLMRW4ypQsoUsk/iw1D1ccENryz2/c+2svyZhUcxz7xMEDqud58hOhNOLyy9AA+JZ8yUeItGhf3Wke9itBWt3vqm948sC0nrvlOFeZ0LQIBHH8r648stOYs6JespKetx7WoQsjkiYIxB7HIZLOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Nq0RblO/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Nq0RblO/"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso83592855e9.2
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781123719; x=1781728519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwc20oinFS38+HtcTxr0JzZGF6h7M1rDzYuEvdtO6Lo=;
        b=Nq0RblO/EWeJqMpByCkEky5yHnh/OoEJUP2/zr7iABmhgkSFS/LiC1B2HZM9n+oAaW
         0CwrxlM4nqPri5OR4h2oX/wMxntMXHKxvaIbtH4hBNvkSZJrPHS8XiWGY0H//s9jSFNL
         jnJg5loJw2iVFB2rIkFtsHRQ/p3z3rlgnPpN0q0783NI8EPbje3WbhSWonUeJRslAu7n
         LmYsL/7oLrbGUj22L+XGUBTWTf5Czjs4/lbPxZGT/k93vsXw6VR/omMg3P3dyiKsO8zb
         qMweO9kG5nj+3eMMoFASGG4BWFGsfoneglX1b2ugg93+4yg767/rRtj3LIZYTEsC8K2A
         Oq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781123719; x=1781728519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pwc20oinFS38+HtcTxr0JzZGF6h7M1rDzYuEvdtO6Lo=;
        b=e5nQeeGq19bSmLZsLMitNl3lKKJpcvw+zZmoP1icT7NfzUqFhT350S35GlVdfpSbft
         p6JEAZiE3HdU5NQWC5wPb34VjDLXWGV2pdO4PE7NHt3gAEyoaj8hAfiBvPD3yUKgpTts
         CUBng/7biwp77qPrTuayryQnC4DULoh6fSh6Co2bMzgS7A8mC70VJ+sIJLSvhPTxVnUH
         JuO0qhPO2qIqXBuBlcjErh5ic3LDjiPsQJUeaq+rJqFNzVW/vqjVQYOYFAWq178rryf/
         0iSyVu6cNj+46i5vxpNp6WIXDIP5tMJfx+6eJTrCVNSgAhTuNFT83+A3LBldxksLIpAs
         1dgw==
X-Forwarded-Encrypted: i=1; AFNElJ+HiMMzfGLsuIyQwmjKEkP4QmLJ+0/EAUruF02qrdvkoUKNRnxG0QJWRZWvMzF0r509ll76YN3UKYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxImm5JP4VbDFP2oavQFIStCtdQ5Xze/fFg1e0FE9ikf2umm9zq
	IFO/OwY1tEWnMV6kn8NbfJpbwyGj4hQonffNtHjSklWI4r3fU3oO3iw7rxGh7wpwtRA=
X-Gm-Gg: Acq92OH6cHaOJbBBqVf/lK4eJaXOAr7s3NJRiSGxQwDP1hzhr6fphxrGREye9cYevRY
	Ogoi/JDAUWdJiIn6CFpMSAU0GfMZ+jSv+RIfWXu0saR0nvgs2Mm0vqxQW1DUlXCKAJ1Rfd+Kxc9
	R4n0yAyaJuYCTKGtOQeQwarFBdsakwbdXc5PhgHiPUM7EPbiFOPD0/9M1NZEwIax1LdUz+/eqIb
	nVyC7TViH3B3oyVL3azhKMOKF075HDIpRw0FcDs0MezdJETX5lYeFYrRXtaJWst9ihjiGz89R+E
	e5TV8zgVDY21tuiRC9Cu43qWP3FGr0ZS3ilFHgK5hhP8JTx+BQ903evSUbhlqhp4Wk1ain6fZY/
	FqoP7DXk4y2F8GzSdKGs3d3l/IG16M6HhGSRJyNNO7oyesmnWZK7J9YpT+j3eh0ZP7LOjGfaQ7m
	QQ+TCzOOQ3ct6b0/+cR3Tvgy7TjTtevpGhs9rXay8LmA==
X-Received: by 2002:a05:600c:6792:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-490c25ee920mr437886825e9.24.1781123718858;
        Wed, 10 Jun 2026 13:35:18 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dc4715e4sm62390975e9.0.2026.06.10.13.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 13:35:18 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 10 Jun 2026 22:35:12 +0200
Subject: [PATCH v5 07/10] m68k: stmark2: add mcf5441x DAC platform devices
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-wip-stmark2-dac-v5-7-b76b83366d5c@baylibre.com>
References: <20260610-wip-stmark2-dac-v5-0-b76b83366d5c@baylibre.com>
In-Reply-To: <20260610-wip-stmark2-dac-v5-0-b76b83366d5c@baylibre.com>
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

Add mcf5441x DAC platform devices.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- fix copy-paste error on naming
- use DEFINE_RES()
Changes in v3:
- simplified DACs as single resource entries in place of an array
Changes in v5:
- move include <linux/ioport.h> in previous patch
- use predefined "mcfdac" clock/device names
---
 arch/m68k/coldfire/stmark2.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/m68k/coldfire/stmark2.c b/arch/m68k/coldfire/stmark2.c
index 7eed6097f501..a6f9eb3a75d8 100644
--- a/arch/m68k/coldfire/stmark2.c
+++ b/arch/m68k/coldfire/stmark2.c
@@ -84,8 +84,28 @@ static struct platform_device dspi_spi0_device = {
 	},
 };
 
+static struct resource dac0_resource = DEFINE_RES_MEM(MCFDAC_BASE0, 0x100);
+
+static struct platform_device dac0_device = {
+	.name = "mcfdac",
+	.id = 0,
+	.num_resources = 1,
+	.resource = &dac0_resource,
+};
+
+static struct resource dac1_resource = DEFINE_RES_MEM(MCFDAC_BASE1, 0x100);
+
+static struct platform_device dac1_device = {
+	.name = "mcfdac",
+	.id = 1,
+	.num_resources = 1,
+	.resource = &dac1_resource,
+};
+
 static struct platform_device *stmark2_devices[] __initdata = {
 	&dspi_spi0_device,
+	&dac0_device,
+	&dac1_device,
 };
 
 /*

-- 
2.54.0

