Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1BF2E8DFC
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241170; cv=none; b=ua264KRtwj6yZUs8oOo73Mkl7Pl18NvUILhmscLKvTOV0rJT2v9eWeAUCqpSmskDY37sF908ND9wKpE/dYG0Y5SjiMCiGMxiasnLQb3o8hVM9jWX10VFLMCoUCPJptWqvGfaV5/cmY4Dk7OutPhsWT4um6sYSJnUaK2rvmTlCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241170; c=relaxed/simple;
	bh=8RKxR0hxfr6wm13GbICX0czxMc/i5q+wZsMjKm9dQKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qn57efF4mwwvlVLV0NO2oA6OMC7oG52g6atmiF62pCBIW/QYRya/MQj65Z7vuzMtumzU8sdqjifXCPB3yH5skSA8B2gOZ65WypVCeFTi5fNgmOzlpt8K9uYPPdrBzfUINBdgLA4FIfFHU4Q/x/SriUIQxIDH24iko/KbzZBE5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=OMz3TDYG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="OMz3TDYG"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45eedcdaeaaso2169485f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780241166; x=1780845966; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3Dc6zoyWnXEvMeETDcz4Z1/oT967FAbFkpJkYlcBjs=;
        b=OMz3TDYG+0hpBnJJwuxc7R0a4ePm+uQx9Tox+Z5aCAFK2qUM6QJSX6QVJtNR+Elfco
         UGhQdGYopCQL11xxy27EXLoSF8CZPMrI7XBVNLs3U8ZcZReOGzOm4z4w6WUoS0MfoA8E
         0ySYRRtejcLOu4+N3kEMbNf8V06zQGpUhX8mesmVZ9uJjr7EYypB+0TvWbhKCNeXbPxf
         /JcUluESyO0cZtGeycX5fj0s/x081iSkXEhXXW4Nu+qXqp11QNuZgpYG4YN7CxKkrotV
         uOFNLHjirS3ozvjIuzjQW8Wemw+MwHhUOcAZyZT4/FgdcDxj43VMQE1qBHgYN6Z1f5ZI
         l3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241166; x=1780845966;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l3Dc6zoyWnXEvMeETDcz4Z1/oT967FAbFkpJkYlcBjs=;
        b=YrUpdwWDcJ6tw8AqQ8HZCaXu8NytTnBbLNqasB2qSuALfvrw3EYqPejwt67g1wCBmo
         +XWfTwPLgRAIlFO8HEwSWu5boEAkLxakPyJ+AqFI28BORd4Y5x21SbjOQXpmRNCxndvM
         0RTyc02H7P7rsdn8AFeBevmPkqhyKSd1kqhrSOfZcgQI5pLmH+1vL9sUHpQWGd8q6qiE
         x+MXzRL3IBdFazxTDXmF9Dz50TccwA+uhdcHerGoJUvimKDbFUP9KZlxc+RrQneHGRar
         zia/ooVp80Y5xIiGtE1EGnsVBfdRqlrrCDnA6wKQJpyww7bK4EKhzXRBaQ2J+VIV7yT6
         nftw==
X-Forwarded-Encrypted: i=1; AFNElJ+WboYnC42SfwRljIegBxOm5wj5wllYxz3wRx/MQH3we/lt0x8hGVWYvmS0B6l2o/CnlGq+S/uHcOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTn14AvE2YG3EQe3Y0RHqemFMbP3Mycf5UOg2JsXKtEAT3gLh+
	EBuii9x0OD5ZUSYPnbM5LLLROWRix/ezaVR2dNHauyB7snetok4cT6LJEbF2KE3nrsc=
X-Gm-Gg: Acq92OE8RCthIrE42hsaQmelJoZAyplyhwnxW21rdO2MLVSwXALZT9sWtCyAta3IQRA
	3eKxr1OX0W4x6iOmUNyS+JcLemvpzzdtkmHHFMSnwgz2E0X4sWPWSh/sVnTDtEHPO7bQcVQOLWr
	IYI0ec1syYntS2YnDHuL7+YY5fxt90BClW3sR1g82KyqEAst+Enp5hjRLhigVPvPXwovGCgkxWy
	5g5esPXPpIT+yYuOOCJNOv7ix/loEiMSEFhczk5UhJFRYVhG/Z4WJ7frJHNoktIXpP9KXnWGTy7
	pESznkycuzU/oTL384bYOowb1V0Fw2Q8DcPWwc8yEAu0DKsV1kJsjQhkNGEyGjor03fhXjHNpYI
	30zgttylXDF7tbgS9ezohMwVlr/lkhYHs9GJKpl2QNvVIeOeRheVvcajPtfVStpBb4pX44/24DL
	mk9BQbC1RfQGSWlFJhhGY6DhS/JohxkJpFxHaxjoNnhA==
X-Received: by 2002:a05:6000:4b08:b0:45e:fa17:a1d5 with SMTP id ffacd0b85a97d-45efa17a416mr12030094f8f.33.1780241165693;
        Sun, 31 May 2026 08:26:05 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cf0dsm18526622f8f.17.2026.05.31.08.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:26:05 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Sun, 31 May 2026 17:26:00 +0200
Subject: [PATCH v4 07/11] m68k: mcf5441x: add CCR MISCCR2 bitfields
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-wip-stmark2-dac-v4-7-7e65ab4215dd@baylibre.com>
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

Add CCR MISCCR2 register bitfields.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- add "iwyu" include for BIT and GENMASK
- fix MCF_CCM_MISCCR2_PLL_MODE bitfield
---
 arch/m68k/include/asm/m5441xsim.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
index 9ce2cbb05316..ea01c7753b7b 100644
--- a/arch/m68k/include/asm/m5441xsim.h
+++ b/arch/m68k/include/asm/m5441xsim.h
@@ -8,6 +8,8 @@
 #ifndef m5441xsim_h
 #define m5441xsim_h
 
+#include <linux/bits.h>
+
 #define CPU_NAME		"COLDFIRE(m5441x)"
 #define CPU_INSTR_PER_JIFFY	2
 #define MCF_BUSCLK		(MCF_CLK / 2)
@@ -145,6 +147,21 @@
 #define MCF_CCM_SBFCR		0xec090022
 #define MCF_CCM_FNACR		0xec090024
 
+/* Bit definitions and macros for MCF_CCM_MISCCR2 */
+#define MCF_CCM_MISCCR2_ULPI		BIT(0)
+#define MCF_CCM_MISCCR2_FB_HALF		BIT(1)
+#define MCF_CCM_MISCCR2_ADC3_EN		BIT(2)
+#define MCF_CCM_MISCCR2_ADC7_EN		BIT(3)
+#define MCF_CCM_MISCCR2_ADC_EN		BIT(4)
+#define MCF_CCM_MISCCR2_DAC0_SEL	BIT(5)
+#define MCF_CCM_MISCCR2_DAC1_SEL	BIT(6)
+#define MCF_CCM_MISCCR2_DCC_BYP		BIT(7)
+#define MCF_CCM_MISCCR2_PLL_MODE	GENMASK(10, 8)
+#define MCF_CCM_MISCCR2_SWT_SCR		BIT(12)
+#define MCF_CCM_MISCCR2_RGPIO_HALF	BIT(13)
+#define MCF_CCM_MISCCR2_DDR2_CLK	BIT(14)
+#define MCF_CCM_MISCCR2_EXTCLK_BYP	BIT(15)
+
 /*
  *  UART module.
  */

-- 
2.54.0

