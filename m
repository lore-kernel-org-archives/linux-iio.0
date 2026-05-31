Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B7E390CAA
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241173; cv=none; b=SHKlUJrVAbKb29LZjL9vARwhzN2WSDsVY0i581cFHiJJfVf4ooYiUWVOPqd+x1fPwZcN8xkzgW2U5vuRDNAT+R06k562C+2bI10h9/41RFyFlI97L0Ov5LIegbdJ0awE51YY0yjEmKCAiMOAlcrBELoSKDJVosJqG1mdFHSdgiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241173; c=relaxed/simple;
	bh=fG9dTQd6OKY4ybUsIIQRbILKv3sfqdu7vBpdDFZ8pvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajokkhfJT6+LmAqjzADFeGnO19OQJevLrH428xlE0gcT+T9m+0Y/wtA4rZhboqWG3TMIVa3H4eSb8CDtOttdT6Sp28IGMK/VTdiLr5fRiC5kmJHlwJvYB2rV6zHz97en5fdDtXuagCHmTEZmPcSFI6DUtd9wbfxVED+Hx/1mfkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Xy2jWL1R; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Xy2jWL1R"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45fe59255beso283622f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780241169; x=1780845969; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vo148tLRdvHB4Hf8KQfkCKci/SYla3jkLQmLRXKSwIw=;
        b=Xy2jWL1RMoIUktqE8G3cRBaw0Xo7/aJGyzb59awCV9oK2n1kNR0PNOInhw8HQV6AEE
         Za75/r37WY+c8V+P7K0OaIutvUMnTCFel4Gz6HMnI/14LXroYOerF3C3z+DoqRMOFuZY
         /Q8qRowzVcjs1k6WZ6ntkMVFGbyESjmrKxRftzbc4Z63afTBIjD5J7Sinz8Cv1ze+gah
         rnZ1usRYTivMjgrBbZoN6Iegg1adAUg/5sdNqCpesGJROZvEctHlcFWVr7R691IBEGB+
         q0Rbpuk3yRZf0QItqgdHARKM/jXCi7UA5LmxMLPBfGbkTXgMMh0h+ubHCVSvt+eSM7nM
         WKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241169; x=1780845969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vo148tLRdvHB4Hf8KQfkCKci/SYla3jkLQmLRXKSwIw=;
        b=CQhHDTHKdSI8quxAy7yi1gQehi4NKLOVEw2bTW1ycY6Gk35UO6394/xl2gtWg4VIiK
         n3MrbjQDptlbsRo2Tj9cOxpCL5gpG1IBVMAHJ0/5fseBcgmVTtGsilfDCzi3tlKhsRnj
         NlcPaVnKd2Jcr+AVaSDvhdZn1PGqhISg61BbedpveO9OOuZkV/KoQURWwlNOPdkkJgF7
         tYLz433scMlDXKBsyVZQCHJpjijeKiHMXDHBOpyBBHVGZat/00cavpNY8HWFi722YbLa
         IYmB6qwdno+nik7Fu7t7c43P53Fndz8ClLN3O6PTBGhSodyLJFvrcoCPgd8SAYF9alO5
         oRIg==
X-Forwarded-Encrypted: i=1; AFNElJ+hb3kSrKIzznwGwZbm8GzRw5xLnjZSbMDkXepMe8W2gUyFhlhDypeTTYbBGOxlVLwzo1Q/S4PMuzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5gshMkNHhC5CiLH/NuuWQ7mgOyX0ZmNYkCbLmf0wmLW8yCetI
	DFpu7lALSTHRJ0aoOMWizIRMw8shJFXKRvGsb6faukDZVW32MFda+U6SIzUOK/pSNz0=
X-Gm-Gg: Acq92OFLZw8gE8f4XPjPNhqrlAVhNHzWJaKZ8vr5pizZpL2v4kBUViKrGSULrqTNi3V
	lLgIzVBezrJHu+TRvOCMqyGpf6kmUaQnWNnJjDqCTpw4ah3fDh8Zslrt+AyXqT5FtnFmLL4g8On
	B8R6EyU1c+3eboZVcqNxbllM2Y5VmXvnBjfr0P272SrhfVWL5YZ8wyzw3Div0gxcUcZH/jA5ZNF
	itcpQUdoAS5F1m8nWnL8+QmWUwqbwDPIsRFaXGU4PT1iLXwY95yS7KOY95avPJ6B9vAh38e5Ytg
	eyBZlursi06UQSYoUFohY3/OE429AEqb4rj6efX/2V0Xh0JH9jMXWO9iQTPibyzHuDHBPshmMZN
	7TAEQYWCXWgu0dt36EGJpWrbcmMwngE4INIkiP+5Ee/olQZDAH1dFd8128tP9ragwLP7iULUhsG
	jQ9bcn3Yu+IZaf8ZXkwivVDeGhVADJl73B+LSoHDEKlg==
X-Received: by 2002:adf:f690:0:b0:45e:ed10:8dff with SMTP id ffacd0b85a97d-45ef6b7fe7dmr10702843f8f.24.1780241168825;
        Sun, 31 May 2026 08:26:08 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cf0dsm18526622f8f.17.2026.05.31.08.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:26:08 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Sun, 31 May 2026 17:26:03 +0200
Subject: [PATCH v4 10/11] m68k: stmark2: enable DACs outputs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-wip-stmark2-dac-v4-10-7e65ab4215dd@baylibre.com>
References: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
In-Reply-To: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
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
index d3be4b2953fd..8aa9286e85d2 100644
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

