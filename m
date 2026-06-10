Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4A5481248
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123723; cv=none; b=RaQJt9hx4v5SLtdzG4KdirfsvU3xrM1UCIcWKMWBL2k+tlBml5x+0rzNPpFEsPTVrDoFG//xV+TjQdt8nfaMlM7dY7fWvDlu6B4P3xa8s3GaYH8eWL1hx8i76KYeNKCbmqHzKNYmeOLw4DjK5MdFzi0ZugDqQfEX6gvqXmEqN1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123723; c=relaxed/simple;
	bh=YWCo0UPczhvIV2SL2MXAUbqXZZjhlakNrPODxWaLZ98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=urzJtzi26i8Ect9wJKIUxieFgmFYqPdaPeyg50Qvq5O3L5tpKponVMq/IGe+va2F7Aa2MVWFtq5QyfrdHVlLryLKUYlYLVXXetXinFvFrFp3yLxKWbs/EMfk+ZMxnyE1cS6jtKX4kNixim2GkQSuHlYMMnIFi/4CsSOjLDXk47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LDbKTzM/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LDbKTzM/"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4908b92904fso82825855e9.0
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781123720; x=1781728520; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KL7s4MPM/6KRRYwpVkRdhAUbHaRI876v8WnTKEx4jhw=;
        b=LDbKTzM/SNawXiR04ccOCA5FvBGuUhFbLWVXoJh+b6rT3Mcxyk7lP9f686M3qSv82K
         /kJ6DCFUJCCw5oETJAEs1XtPStkhB33cNvOdV4ADmVtn+W+hVtA/iTf0DA3GN9lilCN4
         kLFdSO3Wmvui69oB4PuUPKGKKg6gTZDJkunfAVDI0W5h5yeSkcC6A/f4CnmeEEy9lrH1
         kgC4snIfQLHMZM/E0SBQygjhlShCcTEezro33O+PBbQlPnX9sOkWZM5+4gjw3pjjMqP6
         TYyqHhJmxvVyvEqD+p+p1OoqSIuD0ckQmUgdsM2RUT+6DsdCF1ApUdROvWOwMVnX8goW
         VOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781123720; x=1781728520;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KL7s4MPM/6KRRYwpVkRdhAUbHaRI876v8WnTKEx4jhw=;
        b=e/SbYDytcDeinWpMti05xsp1095rv1gOVVU2+jqCNjqTzY/14SetOQokpwWOmxvOq5
         MF3cBLrepxDnXFAeMgvu6/yZ/Xk2Gc4mPa1WqYwkTqVHhXbSjA/8edP7Aa2wl5/6/sYg
         Xe6yYh/CKuJHwvDjxaNXKv+cuOJrJR6u+SHVDMpuYHJ4g1KNu3M/agc+xWwS+UpNHgoC
         RaLnkupo8snZtuw2XWn7m8jc+g8TDoA0+jYuh9hunxTpAm2rQUb2TUB8Zz+rVZM0bNf7
         rR/9d4NfpjWqUEDk+/BPWyOCnYeFUzLmnlfu5AY151SIYzLrIBb5+GXpHODr9YFFob+Q
         QJmw==
X-Forwarded-Encrypted: i=1; AFNElJ9s1UTDj11/QWfLGKqxdyDEgLy6Zq9sC4b2nKspiXbods2jEQ/syPOaqkZrFF/ywKILUpFBnmEBN90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdNrPQVq7d5GFSg4ThNuCiT9oQdRC9sMhhfWCH84wKEluW03vu
	bkr9/nMb/pAoiazAAp3IkO6Umeb4VeEQt191qZ3ZJs58LqC41XyOj7IeCP7qlFYJuGw=
X-Gm-Gg: Acq92OF7N97rZDuzjyxt2dHa/gZd+hrwfNyFmcXRJH6V6J/pVzYkWEVpm9H76YbrRbI
	9BSfalXMaIC5izbZAICTvx2yPJtrgxD9nAIxZRH7ghAqv0ZZmMX5aM2dj+ZSLQbtcijkFfUrncY
	/tM5H8XY8XhKN2azG2AnzvKuRHbxgZ3FkxTBOZv/Mjbj4CsD3K/amDhBX9RPmEeS5JT4S8DfrVt
	tAJ/ixOezeqmnLTaL6w2KW7KlPQA7i+7DiJIDht5Ch95ErWvHcnXCsN6XUrBSfguH3cY558gYQZ
	NL1D/g1VBSLeZmtWW992KKuSDMaYkje4J0DlSrPZAtkhKk3g/agp9ApaIFv14UE52jMai2FJWeo
	FkiiC8+yIw+Auqc5EUP4mQu5VmiW05NMnD/aE3d2WinnP9sBa51JVpYsrury7V/fmhWq+M5qv7F
	wQwd5s2yGS/EaNNK/54ctOikWhYjd+eAC1fKhYWYSEyw==
X-Received: by 2002:a05:600c:1d99:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-490e2e58474mr5692325e9.19.1781123720314;
        Wed, 10 Jun 2026 13:35:20 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dc4715e4sm62390975e9.0.2026.06.10.13.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 13:35:19 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 10 Jun 2026 22:35:13 +0200
Subject: [PATCH v5 08/10] m68k: stmark2: enable DACs outputs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-wip-stmark2-dac-v5-8-b76b83366d5c@baylibre.com>
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

Enabled DAC0 and DAC1 outpus disabling shared ADC inputs on ADC3 and ADC7.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- using mcf_read16/mcf_write16
- remove unuseful comment
---
 arch/m68k/coldfire/stmark2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/m68k/coldfire/stmark2.c b/arch/m68k/coldfire/stmark2.c
index a6f9eb3a75d8..25452079056b 100644
--- a/arch/m68k/coldfire/stmark2.c
+++ b/arch/m68k/coldfire/stmark2.c
@@ -113,6 +113,8 @@ static struct platform_device *stmark2_devices[] __initdata = {
  */
 static int __init init_stmark2(void)
 {
+	u16 val;
+
 	/* DSPI0, all pins as DSPI, and using CS1 */
 	mcf_write8(0x80, MCFGPIO_PAR_DSPIOWL);
 	mcf_write8(0xfc, MCFGPIO_PAR_DSPIOWH);
@@ -125,6 +127,11 @@ static int __init init_stmark2(void)
 	/* CAN pads */
 	mcf_write8(0x50, MCFGPIO_PAR_CANI2C);
 
+	val = mcf_read16(MCF_CCM_MISCCR2);
+	val &= ~(MCF_CCM_MISCCR2_ADC3_EN | MCF_CCM_MISCCR2_ADC7_EN);
+	val |= MCF_CCM_MISCCR2_DAC0_SEL | MCF_CCM_MISCCR2_DAC1_SEL;
+	mcf_write16(val, MCF_CCM_MISCCR2);
+
 	platform_add_devices(stmark2_devices, ARRAY_SIZE(stmark2_devices));
 
 	spi_register_board_info(stmark2_board_info,

-- 
2.54.0

