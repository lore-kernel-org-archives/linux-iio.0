Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DB148A2DF
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123719; cv=none; b=YL4irG0csxm/U5JYIk0b62MVb7Pt1PNdmFBYIUtGrxAnrohg3V6WLotlv8ro95OjNXJUJWtc/Pbj8nqMaoESz39qJ25Q6/wq3DMUb4nA0+DxO7Q+pjGEgWy5Or/TKjQLH9cURk3t1McRksmDPmlDnx9Evlmm6QS8qmA4RuuYQLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123719; c=relaxed/simple;
	bh=8RKxR0hxfr6wm13GbICX0czxMc/i5q+wZsMjKm9dQKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vFPsdm5UNEjNvvCU2RRiCMqXFBJnyr7Dq/LLLjlYMtaDmYMwd9VcrzMg7o2LkF7RYPsDoGxPfQLQBy7BazDv0g/XrRyK4VyixDKlLZukkb/xGT3SQ4FiASgAUwYoBgCZ9TgE3bafwDKenCkzlDFq+IXhY/lUlifL60iFZ7jGbhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=pLk4Mefo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="pLk4Mefo"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b613a17bso70915215e9.3
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781123716; x=1781728516; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3Dc6zoyWnXEvMeETDcz4Z1/oT967FAbFkpJkYlcBjs=;
        b=pLk4MefoWK3I3VxmE1f9jdfB0MkhTnrJGmPk1kTOIfAE+tXid2/dzInwhyHOvrwV8t
         4ihIQc5KW/G2q2Btmrzh9nRAwa3Dx7aGFxInYglZMA8g8Ku0MECUbEY7IONeTuZzO1qP
         kqvUpwXylBFuS1oGV+aCmHAxZmlzfhSsfwpkUpAJ1okWQ+iFQXIcv3jxSAEnChazzBeI
         qX62yDkDGpdiNivTARuSxaZE3eiLaK20B+m7ajW33bHmk+XOjMczIDSdtsleOvPBpm21
         kUELPTRjw2n9ORSn8F7mM0gsy3d1j2/r6W+SnUrXcrORgCq7KZYCncCO06rPdS8sHqqg
         QjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781123716; x=1781728516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l3Dc6zoyWnXEvMeETDcz4Z1/oT967FAbFkpJkYlcBjs=;
        b=B+iSSL6BItgFzzqmPnWxsSuNqSYDO8v6XPntqTyB+0ox/faAObUJtHKBvfW/zy/K96
         Hr/R7xV/xfQ/0pXXRkls/g3r01JPDlber6C3efwU7s8ZVvs3t71FyOH7+OckfoYRUcGL
         7VYGKhXEtLfpbR/WmLcOT9xNtRrE3HShZJvnUJixZH+8+qqt/bTcYeSXU0gCWzg7sEyN
         ndWqmunCxLEoPxnmzg/FcEUJwkodYXJ0L3U+91br5sD78nGeY+uQ5K0oQLtbkndlxi1n
         QzO27c76Zb8LE2cgLdhv5WIq4TFKQk3s+YcdFb0/hzu+YmhFXM7jO8STw5/kOYLYkCgI
         1PSg==
X-Forwarded-Encrypted: i=1; AFNElJ/Ubm54U9iQ8QzfyeQLotgekSvOwFIaV9Xi7Lx1VMCa9wIpKHQLp5LwO10DQGSPjDV94F3nRsxRGEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi6RqpnJJJQLJx4Hy0GGNyY29T0TyTPEaPTd4nPEHbWEw/3wpC
	dmY/kPtHVobDKUdzA2ENLY/vWiQHrcVYuZHlXzrvbcI+l4jZ6wSP+vZXd7kof9DYa+Q=
X-Gm-Gg: Acq92OFDygFVqtq045kdgwOYnDX4P+j4NeExfla8C+aZc359uFQNWW9GR412D3lo93O
	d+qxq445uYu5fI/bBfXrO0IsjCs4EBrHynEMKA7fHuQ1HRX25BDI/vrLlcIStUYxRsR9YBNYKAL
	sKjZkpjQSIzd0YGakMEmt84T/8CfrZWSvKTRNZrmLyZPgcUtqDE4IjCnwFdAel7WTMF8MN21CSN
	DLRmOtYih/KnfoO7dzVUe2c+SrTrDFgzV9vULf71itelHEc26MukRmCJiM2yhjuyTZnQiLWmmiR
	MNZkwqJkDIPB5ut5eW5gqk952jGWPkQbx0z7YOgdesEie6dGNDCa1Q+lOkDcuZsguW1qwgPWN/B
	XadZd4Oe2dEjRHPno1Ce6RwcFuEiPy+Fa36T2vnce9BCE2wAu4SJ0C4z/xSzK9VpdrUfizJvUFs
	I0sihhyyPU5PRzXaFmNN/aGPJDzLu/rdJ3wJmj3KUnyw==
X-Received: by 2002:a05:600c:620b:b0:490:b9c3:6c48 with SMTP id 5b1f17b1804b1-490d7234fffmr107606225e9.29.1781123716245;
        Wed, 10 Jun 2026 13:35:16 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dc4715e4sm62390975e9.0.2026.06.10.13.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 13:35:15 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 10 Jun 2026 22:35:10 +0200
Subject: [PATCH v5 05/10] m68k: mcf5441x: add CCR MISCCR2 bitfields
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-wip-stmark2-dac-v5-5-b76b83366d5c@baylibre.com>
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

