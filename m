Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5EA388881
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484887; cv=none; b=nyhcySb4eTu9GUbVSMCAJBb4Mp/wSsj9P/63+iCta7grkPFZnRJb7EtsS/iMT0KfnF2K1Q36q5xTrK9QimRmluyeIGcLU8196TFHmk6xEcPTEmnQrSNPr803CGtZW/lt62InTtnxivtMwb5UV7C8zllwrED+EmXocUXbtxnr+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484887; c=relaxed/simple;
	bh=8RKxR0hxfr6wm13GbICX0czxMc/i5q+wZsMjKm9dQKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LH3mIp31hGGtDJM0D43yS4U588W3l3vCTVup/y41njFeGlvxNpuR7U0/7jk8OPTgjJ0bMeZLbDnzlLMv2ec6iF37N5XgPjh2iASh5SzMxpUW1M+WPbaSfNS2ATLdrjDu6mH4rHth5QNswtRMcH7WwOMfK/QDwxcB5woMAM1fGG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SyHsTxuc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SyHsTxuc"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso41001295e9.0
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779484884; x=1780089684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3Dc6zoyWnXEvMeETDcz4Z1/oT967FAbFkpJkYlcBjs=;
        b=SyHsTxucb8hjB7ZXidvxS75EpgwnwtGRw6DhoR7n9e8H8A5GkcYNDhBcDfzPfqiDHB
         +yEFbjw97i8i016uuYFFDTEl35Fd6qWe8Dp9JRwjzzDOw0Yg6d9yhUWMUMDeYc3atIC2
         FdLxpPKARuKYioJO72hxSym4BYWPu0U4Z1eceZKyPIvglVjsDfB5ndlTmPxoHfbMSZQ+
         ugf0tWFGLOWnm1V38NREVOfLtjM2Uo2kfXX8s16zbNWLom5eVlGjvJspTcrymOg5vcWm
         tEhh67c6/LArRv9PL+SDWef0dhvsKwJOIf56OibrB/dDoLm+8PrltwNWGP6Ds603eI0u
         jSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779484884; x=1780089684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l3Dc6zoyWnXEvMeETDcz4Z1/oT967FAbFkpJkYlcBjs=;
        b=fbw6BNE2TiM6l/Dnma/2obdGQlXN9omCrg0I5a4GzuWtH6fXo8fQu5voMYnu2AqskC
         uTcch/dRP8eVrbqahgMsZQOqhll1wFVRPdXLCCKQRY0CRyaq+o/37GEoGJOPsCAc44ts
         f7dbNmbnlVTh2AZ6Lp69oBCZBCbl5eBLHXZsBhBxuYwm6VbQqJe5MZtDijyR/ISr7lQG
         VvhVkYt9F1T6Pk6N2/FkKIq5uWNSouqd5Lkv54WxXjcioCgQBiU+dDgJv+ip8e4nAtq4
         7X/07YiyXGi0OTpJ9/0gI0Gnq8wB3Q4u9G7d1k44QarekvM5hfD5swJBTp5CzrQHqeAR
         UynA==
X-Forwarded-Encrypted: i=1; AFNElJ8PKsWDMtUeXidO1y8FZmxEqoPwjFnMgsFd1uEN4ZXgzb6zHQKlDeZhyypnjnvheJJ+qqKXom5cTAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+jQgD2U1Zmnv3POIWQ8kwWrE+N9TfcVXOgwSdDdwdV61zrfN9
	+9VoAWbgYJ8l1xRjWx2CxCmo+Qe572+Vfjxw/RPEFtVj9adL29X/xhE/umUmPasYS84=
X-Gm-Gg: Acq92OEd2ZtKiRswtjbQdgGnqz6ufzjbxLd1uADTb8I2FYlINw6YTVtsQZa9iUc2BaP
	gBQ0zrLYX4U2A6HXD7wHp26zyWsMlFUgJDSJ2EiLz0VxQMsyayoAL99ocUhAWpA1vA4KnOJYDvH
	c1WvUjMw5MC8lu8Hwaqc14LIFnEyIC7bvAtSa9hyfuAbg4Q858KNxzizfUwfFvPPtyhDK8efNlg
	R+q0957sGS5MRM70vCge60Tk2HionrcEu85JFmzKSIkyGmJkOd32LQnhbfUN9S30Yw2N+lZRzb0
	JKpujdRJ3jHyjVq0resiklsyo+1uqIzLNHH+FoJWPBtsCchYWVfgccWU2Bv6hg4GeYldALcFGBA
	go5jWa4ATXNQvgBNfOUZUq9K8tTex1Whix2+DR3BGjJY/7i0zS/Jn1Se4ytSTifu4p+SCCOgnuB
	R4uNVk/9iqfu6HR56Kg7EfLP1P2+lHsa8=
X-Received: by 2002:a05:600c:a402:b0:490:4033:d3df with SMTP id 5b1f17b1804b1-490426d7223mr56354025e9.23.1779484883834;
        Fri, 22 May 2026 14:21:23 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b82sm73312225e9.9.2026.05.22.14.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:21:23 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 22 May 2026 23:20:35 +0200
Subject: [PATCH v3 07/11] m68k: mcf5441x: add CCR MISCCR2 bitfields
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-wip-stmark2-dac-v3-7-16be0ad35a67@baylibre.com>
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

