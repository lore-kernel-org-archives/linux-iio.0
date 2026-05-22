Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77C8387372
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484890; cv=none; b=pC3ANRCiEA+MaSq23ZENU4jWroHeBdMAjDY9jccn83lThMCPuaBM9IiAYBLK/63INU3UnZW8iGh8CV1eIleFbVCI2mve+3xJvIfENE4CUsN9G1Hoh5bkD4Q1HpBAdSZL4I8TOgntyVxjUfJSKbfR/QYwzGfZNNSgu3fNIGxKTh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484890; c=relaxed/simple;
	bh=fG9dTQd6OKY4ybUsIIQRbILKv3sfqdu7vBpdDFZ8pvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fFOEfBjy6fHWYgFbyaD4y02waXFG5LSNjHn2ItRY6N4zsqwcPAhBbPki7yNv4PBIs6rm3mWFCtbVB09O2fxpOq6RIycXc2FVzOq/JiflsE1y8P8FYqXON/utyTUbEiTmmiZZmU4mh1ZUL5dB2fiEaAPQEWa3AgAjvqp7WfG13lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZvAt1WnN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZvAt1WnN"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48d146705b4so82890055e9.3
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779484887; x=1780089687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vo148tLRdvHB4Hf8KQfkCKci/SYla3jkLQmLRXKSwIw=;
        b=ZvAt1WnN1OLnAn4yQDxL7xpoThAt6re2WkSSD2z0I8uadl9edgW3PFbzAPrP88xEUF
         cQqgWnJQcFcS+H/vy3NgEg/3oSUnHUuJxBF5aWm1wcPnTVKo/+Syws26dQEqBZTvwHG+
         hIW6o2Tpz7MxbV7FLwo+x41tPzWtR6eSjsXYK25ykrzvoh3x/0NkUYBpIhcIkDciyGVM
         5WF9TkXsEdPvHXiXGfnUzLwQQ3bHGQJT5tVtuwLCyTZ7iLSv0eoAmq46JJWJNxl57x41
         7zPqCUVEjdKbf/iyq2906m+UaRgbCx+b9txHIOFRssjs7ViQzuzlwIz9OxBM1OpWhjBM
         Y1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779484887; x=1780089687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vo148tLRdvHB4Hf8KQfkCKci/SYla3jkLQmLRXKSwIw=;
        b=UN3qNHoP4UvXKFReZsv94QXRN4ZVHkDMpg2trpQOGlZooU197y7aqKy9O8Wh/4imsi
         U4fxeFSsSCdms+ZmDyO16w278031WTXps9cariUNRq5gxAh6AZ7CqutMI3PIMjCf3J4y
         4wHv1/Uog0IxB4UU5CCLieW/sQFVTRdiy0XAbItKhhSc63MKR/tHszP0U4b9Iq7d01Ix
         601dWFb0Mhujjfaais+D8hooObPVr585ZX8ARAQQJQW7QIz1iJL7ZlIYJLhe20UH1/7N
         yAcJRZZ2CvibWXtlyJ4wWjgw7xU/ssJxjhvOZAEqMPcEnCXCZKSXJb6Kuqf2RlyA9UHN
         0J3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8r65mv1a6NgZZFsxcLpX73qA1vBtqEpgLwpRjjqGuWHKxrWOjmb34Vy0N4QreJIplJSNC86IL1Whs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyYCMDm52iNnLAy7d0i4J/BURW8u3Trjf9iD04Cj2ak5hX2b1x
	DzXl1R0PJwSaCm7beXGN0V14LtZOJr8a9R2sT0YVb2ysLc7qtGyxT6+YpLvXx1W4s04=
X-Gm-Gg: Acq92OGmKlwEvTBFvmkDiEQWW1daswtt6NHD4bRxheFDaB9yiiapQTCvEk55oZ3fJ9Q
	UA8xvkx+RZ8MsqINlCFOApZQmWXhnIhFmBWsY5pFLGHHamiJj8FJOZdg3SVd7pOW4GU2aXGN13g
	xJWFWYIzq4RxICcRQl/ImDEJLYyqdUMvQEQylH5rU8pEEZsze5Jw7N5jjKMMUAPsM6r/k8QABWM
	YK4p6Hz6/tREFy+EbeJdsIWWKU9w+sqmRF5M46jahU3JSmxX9c0/u4sd9ju9uIVu4x6tE1c/9vx
	OJKLVd7ItqrOWq/dro5R3RITIiuQWfqxqY864vhTkngn7YxglN0I52fttH7WmNblsZrqBvmdpA7
	4dVdqUi2qbnK/VmM9+x0ernKhpzQlvdQeTty13kgfcJK9ePAC7nDstzwlevP86RI94Zjyf6wXM+
	52l05oiCFNvzX0zhBBF+zMk9hXDzx6iwlH7sjPB/AVwA==
X-Received: by 2002:a05:600c:3e88:b0:490:4ee0:82ff with SMTP id 5b1f17b1804b1-4904ee086a2mr18391895e9.27.1779484887170;
        Fri, 22 May 2026 14:21:27 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b82sm73312225e9.9.2026.05.22.14.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:21:26 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 22 May 2026 23:20:38 +0200
Subject: [PATCH v3 10/11] m68k: stmark2: enable DACs outputs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-wip-stmark2-dac-v3-10-16be0ad35a67@baylibre.com>
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

