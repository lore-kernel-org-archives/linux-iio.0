Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DEB3D47A0
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663691; cv=none; b=l6IRleWoIiOO1FSEacFCG0h8PBk25t1tMJW+m7lAJnYln/VmXVIYVTEuNNQVdY8ACvG9Nf1RDUU2eIOFif64rjmVPNDTEssxBkZYy180+1w5/L79Sq+FK8R3mH1X7uerdFrPHURtJ7/tjLpDaM7sIRZz9uNNQWCvjDbB4tj9+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663691; c=relaxed/simple;
	bh=8RKxR0hxfr6wm13GbICX0czxMc/i5q+wZsMjKm9dQKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHTYzNH+aIEDE9P54er8UGUADQnh364RyJENJxLsiMO0dK6S98a61srSqeBZmn6VKer9TSMPqwnRyuLtlgKRrYTKOt0cVCrqvEBQEbnzPLk9UZN7asVraVAvFeAxzx+TbX/rIBubuQVBDve2ZuZq7GxYQHY8vT+MI95D3WUJAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=qQI3iwxR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="qQI3iwxR"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48896199cbaso57493275e9.1
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778663688; x=1779268488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3Dc6zoyWnXEvMeETDcz4Z1/oT967FAbFkpJkYlcBjs=;
        b=qQI3iwxR78BMBkm0iYS/Purn9br7iaDP3sbyvNjQusfGTxcfBD94ZX3Eb5iKszGcyi
         2HM0qw1hz5pJF5QJiFKbh/ZzuCGAX74f4RQtRKE1Ub+y3PXFIghkcUSyyguMw9u2b0cz
         0++o/MvmDjMGmNzLbKMOn/9CbJiHBTEvyQ0ES7nuWtJdODBoJISww8jPx91RGjOa1Zr9
         NWHdlxMZ0o3MvB7fmeT8cbZ3fl2yOkA6UVfNyrxBfbSaybbFYW9A6bXBb4qP3gnp1xqo
         zPV1CIwZlZbEWwAd3SPkRr8ZP/0fKeF0LFAQIyRvh+a4nsnuS9lRXUZqkPLKYzWHspwg
         hfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663688; x=1779268488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l3Dc6zoyWnXEvMeETDcz4Z1/oT967FAbFkpJkYlcBjs=;
        b=Xs2on2FtaZNJfTRh+N3BJROvfnjQD8Q62HAZVvMI0PVEDK+2GYLFhOT8HbZe/hOlU6
         hQ2zmc2Puc53yecyeUH+RpR/5p+G+mpe95df3al8d2aFo9BbqGi4Pv0NBvGlnCQvWcjL
         OcHpRDvucJWrybiBda7/xm+ane/6xHdvcaPKNIbSrkRfkY/bzvgddHr4pLZ5V0WRkDLk
         PJWEJdsyU/eYcQDIHaeC7hqSHFBWf8bPm8dgxxH/XJV4qUVfXM+KmvgD+mJE9Zzvdi59
         QqQ/w/5pu3QsUa1XebT17roI7s7XpBgjubYh2LNp2otNO+9aPJYs6MvZakcMZW7X/f4X
         QqZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8B0rYPL4Yso/DvYkKw0X94rmh4jxkjbdqR7QspgZSeLjGA7MR5+ABNx7gczFHQGuZT9PQ4WcFeex0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB9X3vKfdQAHTouqjayefPLyDD1HDtzK8Czn3ELhGLODNwf/+A
	A6B4MzUGk4bULmFIVlmy3Ue8HAKS5pXGhxt9H8Y9YPil78x+UfxrikNLX0JOngeRQPs=
X-Gm-Gg: Acq92OF+Ul4UovaUmpgly4AzwbpFhsMM/BoPQkWokSVmcOXCK6n8vVTOkI+FjUIP1uT
	Jxk72Jmz7AjUoPI6mr0L9SxvUh4aQ7KEx+L+BF5ODcQv+R6MLPdMPUM+vFnaTEp3KXPBW2wOo9n
	ilDACoCgYw843hXrce6e/cbq+aEhVKBF8FNbAoS0L3p6WbU364L5VPaJ8pnaotEOgXirHQyRnmM
	6b7q0gNJmuB1eYEB9esucrgkF5pbHwhh0YD3auaejRLtYP6dFGp1fByWyz97TktXW+UNWCbpXCp
	dOtW9I5tkcVCTdbI1tvtkSpTjvERDybwPP6r6vakeYgZzA6cVjoN/xAHu7eX35UtQDSW0taEbU5
	F8sG9tnYmcS1yHjok8FEHMqAyy9EHhFD8VEoUSnP/fIozdnONOTm8+gk8eXJnP0Btt7jrdbnGBp
	qA2kFv4tgT8ruWMbWcUbngukC+5rG2+Sw=
X-Received: by 2002:a05:600c:190f:b0:487:1fb4:7e1 with SMTP id 5b1f17b1804b1-48fc9a4480emr35035905e9.22.1778663687681;
        Wed, 13 May 2026 02:14:47 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm34590821f8f.4.2026.05.13.02.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:14:47 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 13 May 2026 11:14:31 +0200
Subject: [PATCH v2 07/11] m68k: mcf5441x: add CCR MISCCR2 bitfields
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-wip-stmark2-dac-v2-7-fcdae50cf51a@baylibre.com>
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

