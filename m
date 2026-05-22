Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B96D386424
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484884; cv=none; b=u+s9NEOeraZiD9wVTwavzycnDeXZazFYKAlXpOx+qjkJHXwv+oEPFlPP8O917s2t1mg5wDZQtxM7wC0R9FAlDrDYii1FRjrj/iJ+ia1k19C9bAF6zS/WrgCJ0SfEEFZ57NctlbPnpTGqyhTDQQSX/X8tELzkQ7608Qhovmju62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484884; c=relaxed/simple;
	bh=BTzMq5e9Ct1iS05RorpLyh1aN78tCIlpP86CvhH3+is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YjMniOEQ3+oayxnk6sqnlFQ4Ck087JJCASDHPwGoaCmSIuB/p/skCNP82Z9nkKyQkBN9UY5ujbJ04hydKQLKgtoqygT8UITuRZIiuOSkq6CpLcWYjRb1Au5/chKs0JKLCao7Juogkw/NDicF3fCSv0sEmOULO9bSHhJPnaCUJBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fnTIxQhk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fnTIxQhk"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4903fd19957so17752405e9.1
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 14:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779484881; x=1780089681; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66sbIWl/UECZcngzqfN9gySpU5b7WSWy5FgqX8acPdE=;
        b=fnTIxQhkjj+8BzBV1fgiFthqluowcjjgnuyg+s5PxnRycn6uumlxC7TDzHxsqypo4e
         GqxU3HWIGzjoCUPUJJHs9DkhmevZO+/YTGY9pfzahv2S8IAC1ScApt7WLTZDhr8woyVl
         V7a0WZgqBVBqFYPPHMXHjYcBzf7k7a32ohZwmQ56PQnlnsiktjWSzTYLaIjoL/w4YXaC
         SwoFm0SYFgKMTiYysbrgMG5Rrl+9GM2fhRjQcVrosjhzb/WvlhEPX+xxNkuU3tDc+l6+
         6HxOYI2iTa9xtfBysUEj+e5943SovJ4hlaAwbiXIyn1YuDW1giNCX7NtSpP3sesBhulo
         1wcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779484881; x=1780089681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=66sbIWl/UECZcngzqfN9gySpU5b7WSWy5FgqX8acPdE=;
        b=sey71iPyJDbBOn2dISpkTXIIT/2Z9LhnF2Hz5uQwLREgkOoASiJIftuJENBl8DGv6O
         DBfh4lH+gzsaK8ANXY5XSVHyZmFCiYZzFquj4Ftxf/9loPdRz4IUw1wc+REsjMdZxzZD
         QHltgfTuDZ4vmT6Ao5GFWu7vPul1KCs8laoCk6D6zr2JxhZouZh9EwfTtxzQkfeb1caj
         mu4S59sqkaSlB8OniW8pVbto4waSuT3o1nzEAzEGx2gGmgNUEUutOFaPumDKTKYRkuoV
         IdhkWOZ0wpboNJ5ZCyZ6hjuHxxJlMm2MLwLH8A7SdvWOCWKLia//50sz52Y0KOjBgmul
         8hRw==
X-Forwarded-Encrypted: i=1; AFNElJ9c+xHt+kBgy6dnCrA+mJTLfPxI/oVAcW7TJarH9iUAW0dFGZnXfeFhKl51h/SIHXFdZer9TIj7lK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfzT9UkYw8fOtd3VcN3I2s1jwc/0NverbfNPOWzMPoDG66cbBU
	R2tGg+l3V0dOhuAfDwm1fVo9yBWGpznqda6dLgD30sb0FBlWMtYIPYs3vM2zJkSaBmA=
X-Gm-Gg: Acq92OGPTEKetI0Ycy9a9mc6aJIojJmpNAACrVh4A/3IxZLEn4THcfhe/WqK7PtlLS9
	royrmdc+RSnbv3f1wlAcyf4Hknj/o3X3FlXRiI42r+SdQAlofLzXgiAx6UJmvi1fTFHPgJOVsDh
	oJOw0O+L44XsTfZK1N0wAN2Waondla2I2In8xw1G51x2upod5L13vZ+EGOL05mSR9QrUcH3XDDC
	8axbw0EJ5SnWd18ebBE6IvOdkXbBHedP+ByP2vQBLRrwjiRRv9HBaz+onOQORckYCFp9kxeBBz1
	sASQnSrY4m8h50pGLhxXKju4itJOFKMPFfdc0kG9srV5dh2ZHrPY8bN3jr7DJ7qfHPB0a7HNeHz
	tdTlZ2GLyy0LuChBAMAL7aRHcf3WGpOasVIHtHuByE0Z8EzX6Nk+C52rmkw7m3hP1/LqtYmA2ED
	9n9QidraC9xvUAuHA1pmWnnWee5k475IA=
X-Received: by 2002:a05:600c:4ecc:b0:490:3a07:c467 with SMTP id 5b1f17b1804b1-490426cf642mr75196135e9.22.1779484881521;
        Fri, 22 May 2026 14:21:21 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b82sm73312225e9.9.2026.05.22.14.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:21:21 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 22 May 2026 23:20:33 +0200
Subject: [PATCH v3 05/11] m68k: add DAC modules base addresses
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-wip-stmark2-dac-v3-5-16be0ad35a67@baylibre.com>
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

Add DAC controller 0 and 1 base addresses.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 arch/m68k/include/asm/m5441xsim.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
index f48cf63bd782..f5acc962bb95 100644
--- a/arch/m68k/include/asm/m5441xsim.h
+++ b/arch/m68k/include/asm/m5441xsim.h
@@ -191,6 +191,11 @@
 #define MCFEPORT_EPPAR		0xfc090000
 #define MCFEPORT_EPIER		0xfc090003
 #define MCFEPORT_EPFR		0xfc090006
+/*
+ * DAC Modules.
+ */
+#define MCFDAC_BASE0		0xfc098000
+#define MCFDAC_BASE1		0xfc09c000
 /*
  *  RTC Module.
  */

-- 
2.54.0

