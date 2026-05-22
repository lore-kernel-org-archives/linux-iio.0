Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAC238888B
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 21:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484882; cv=none; b=eRzOIDVtGsrVcWa1LfzbdHvLhVuHi7kEJEPRwIQM/Twe8iIrXf++lrYhc7rzQXRLeMP7LblBMICyxsT08D5/Qio1VyXpm7hwoiwrGpuUk+oM2MNrUI2Az4MeEN1Wsdu76jL5B6oBR3rDN5yEFfXfg5astLbCKirb1OHLbmnVh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484882; c=relaxed/simple;
	bh=ryo7ah0jlufiyE4iotFulcpPYAtwtOR7H6GU73oSvhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxlNAyKpz1h7rYc5cl7IN8cLcrDKhGlr2KrCHeAw7xXhshZ/gzTuzGeaGVmKLwGIcTckhRvp8m/fMV+byhSunSNxrRPqT9B75ajG5AVAMzGAtnNRbWi/1gBDiyzWBR/hz9kJrG8mLDGf7sOOWgWAmMU5JacsztBdPaeb50P57u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fkH45qt0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fkH45qt0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso68030565e9.2
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 14:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779484879; x=1780089679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glJxT588UgnMfOXSLSAgwe+j1CYbc1X+ny/bK5Tp2LU=;
        b=fkH45qt07bdGYkt7GR13jafG/qC+HSu7PqSBf0TGeicg5nhY1d3UEcSLpS5B8Wn09m
         UgWY88jaHSWteZQo5vQZ/u2YYgwIQrODCqduk0lcVfIGU8R1R3VB46ss8jiDtkvClOH7
         UvkzXb+hOtnkHeVsnITP7ZmroaUFPdjARkzplpPXcsFvGWrETUI11Ytp9gcbsEVeB1Jj
         77ZpkSw/2IQdbkunZJGNjeAyUMhYcpCE262oqU//TTqsPa0qzfUBzKDPJWi3MsZBmFTq
         XF7U1W2sLqsP0+kRA35PSVT3ZcXLcBJsFYih4RVtwbeLHlv3tNVH52ur4NpqAHtdyXvc
         mtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779484879; x=1780089679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=glJxT588UgnMfOXSLSAgwe+j1CYbc1X+ny/bK5Tp2LU=;
        b=Y8JTXA9QwUa7rofarh0N3DAwrynyqByTlmjLUBTEnSGgLTPjW2AI1NlB8jCeacd+Sm
         VpuUqIRMgFM66RIQnbC+nK0uosXDNGNMViN9isvjCdVgCb77J76vfvDJ3nl904zQUqhx
         tmXQTVZauSf2JSSRN5qL/dYMgJQaSnl8+bTqBLr0dVKIRIMGTTHj5/BdZ0atFHB5e0R0
         s8FELknmsAlDjbuKr2Z/XsAgOCcNtorX+iyJG07Pf1+jcieIxvAmvD23BAKOCnrSeqpa
         MANOkb63Xjznbtv1zAb7C0R/zkXcbh3ATPq6DDCQytqrJq11Cagd6kpVomYpwdCLmUC6
         9IVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8KjXCzNE6feJFBDIqb9yi4Q0r7cX4yNu4DPBfx7CJ3FtbOVfogGBwRQcgmPwt83vqlEPyATRCKne4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVYCwJTkJnF9mkkaWrrPwsBuv8qACKEeI0xmwIijxoRLGYu8oE
	zycXwrXEnGZUJQbg5h3nNB/tqR3fO/tqodoSUwv7cgdS+GPvHeGncPZk9WIsdxlGQsA=
X-Gm-Gg: Acq92OFTj8VCKuLdOLUDkVJ6vF2ft4hfnT1f7rmAGTLRQCRJCOemMPyZGQooyWI0uAa
	6haBbuB2dMYvR9ATf1llFQxfUEs6c8X2yZDjhzFLOLjUNcZaA9Bq6fZKYKeEpUfdcIpCivtW2C3
	l6Hybrgz0nOFvKZGvwoiuACqR1xRi5P+a9CI3JZtgpfFUBAyfm8w2e5euUMaXdig81lYEQpy+zs
	tJD98zn7RKZrenu7BMkxXAsKaQACy2zgEpbCEenxkBkrKlA7Gegg01tpjuPM+hfK3LNv+toaTyX
	YTLuto4ItFgItAhHuzB6gGrLcJKsCpxECeYWj8GmgL8mPpAtlZqnAcnZNTa6pvoZyf3eQX9vyzo
	sAYVdA6Uo9PRvQ2KTtaiWsGP1C97DzHfirKq7Tjja2sxDAm2nZ7C6wm5ecqLduoHJsY0+qLg1+F
	ANBYcRc1IAVy5K8wmfxh7Z3t3JdwSWQFk=
X-Received: by 2002:a05:600c:a106:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-490424a0d41mr53927465e9.2.1779484878961;
        Fri, 22 May 2026 14:21:18 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b82sm73312225e9.9.2026.05.22.14.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:21:18 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 22 May 2026 23:20:31 +0200
Subject: [PATCH v3 03/11] m68k: mcf5441x: initialize DAC clocks by iio DAC
 driver name
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-wip-stmark2-dac-v3-3-16be0ad35a67@baylibre.com>
References: <20260522-wip-stmark2-dac-v3-0-16be0ad35a67@baylibre.com>
In-Reply-To: <20260522-wip-stmark2-dac-v3-0-16be0ad35a67@baylibre.com>
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

Later in this patchset, the mcf54415 DAC driver is added.
Considering some other different ColdFire cpu DACs exists, the DAC driver
is named as "mcf54415_dac", related to the mcf5441x family SoCs with
DACs (mcf54415/6/7/8).

So updating DAC CLKDEDV_INIT with proper driver name.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- none
Changes in v3
- roll back clock names as they was originally
---
 arch/m68k/coldfire/m5441x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
index 5b5e09ecf487..b02ca2eb55a4 100644
--- a/arch/m68k/coldfire/m5441x.c
+++ b/arch/m68k/coldfire/m5441x.c
@@ -106,8 +106,8 @@ static struct clk_lookup m5411x_clk_lookup[] = {
 	CLKDEV_INIT("mcfpit.3", NULL, &__clk_0_35),
 	CLKDEV_INIT("mcfeport.0", NULL, &__clk_0_36),
 	CLKDEV_INIT("mcfadc.0", NULL, &__clk_0_37),
-	CLKDEV_INIT("mcfdac.0", NULL, &__clk_0_38),
-	CLKDEV_INIT("mcfdac.1", NULL, &__clk_0_39),
+	CLKDEV_INIT("mcf54415_dac.0", NULL, &__clk_0_38),
+	CLKDEV_INIT("mcf54415_dac.1", NULL, &__clk_0_39),
 	CLKDEV_INIT("mcfrtc.0", NULL, &__clk_0_42),
 	CLKDEV_INIT("mcfsim.0", NULL, &__clk_0_43),
 	CLKDEV_INIT("mcfusb-otg.0", NULL, &__clk_0_44),

-- 
2.54.0

