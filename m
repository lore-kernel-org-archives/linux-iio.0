Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747903E5A2A
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663690; cv=none; b=oFU73KyK49s9AG3Lm2M319w92NPe+a8gzLj/aHgL3Lpv/iRqVMuSq/Ux8S73phklJDgy0/f9LobWv9VsVUi6CBGL9jBfYEDRl8XAhimG0/MPo/4mibI7G9SMbakfCTSlkDQqu02Qg6aN24nFBKjoHzOtFH2Phhr6rA2hAi9+Otg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663690; c=relaxed/simple;
	bh=n0b364dDBrWM4RGQrGIAbMsbTV+2t0ZGtLdE7nGAO9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LIJjyKR603+ypbUklCWP8QpJ819CHCGKy6HClB3tcJBp981tYKthmOIPzpoAenVajwfhLIWuGn/rzDhk6VlvKF4VzgJ7/9YphiGxwNwkx/mdsvd76JKJ70R9FNgMfp6M+BA57pw8Z3NV7YMwfPrCNONKUYXe3FrqXepD9Qt9EFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=hdLRik+t; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="hdLRik+t"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43eb05b1875so3869661f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 02:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778663687; x=1779268487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqVoCiMOeXwzd334lL+Kbbn+xeppyD+CHd7jRk3nty8=;
        b=hdLRik+tFwFVSOyMhVxObLEqdRjHOHNE64L2YJCgnztbAj0f6le9orXRMzvnN+cKUW
         UM5n8hEdGV5pn+++4RIwh51O9g32X7lDpoAfPGzjvVdmGDFRGMBb4d4ByuPbNb8nBB3x
         y0k14duyw6+vAPKCrAk7jRgUsHZ3lgmipEeDf1OF62pTFA/TCgmzlNZ/vA8Q1Gmb8R8I
         TtofpvcWkyRL84zThlK3Unubjd0GzXbxT6AFraiWT0s3PoYr0635g6OLEdL2dN0/ORGA
         BW8AAzIFVbYswy8zE3t28iECQkGkSbsNOIRrdov/XIQ1I97C0Zd8Pd2eVA5pEMcbNU+I
         o9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663687; x=1779268487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mqVoCiMOeXwzd334lL+Kbbn+xeppyD+CHd7jRk3nty8=;
        b=St8hMk8u3CoYr4OP3aMNs8sd4jrahwfXIgv25PYx3fMEB0tonBPN/o6Wx3HLpmgNk6
         Kc//IcMxvi+PTXIvs1CUcMOv01B5eVbYdoVp1eKzoMKfXz6Dhjc2O2y6irOAzXggx8Ea
         3y9K9xS7wU3kBHq1HHl0t2e17OqbaTLsDOKGmypyMPCyQ/kU3+PQau4j+aSu1BHtjQts
         9/bzaiPFi4kDwW0y+jxEpmcPWYb8PtMeHt+FJTCt7Ma8Q3s9TXZVfhxpkcTyqtFs37Dm
         oTzBlWoa6Rb8+mEGSfdS1KvpDo20fkwkmYOsSW4kocWZ1jlOZrGYcfcfS8vc9DUboWQD
         ASig==
X-Forwarded-Encrypted: i=1; AFNElJ9TOz3XwjyF8kgdUXfj7my6oxehP0b2yb/gQuTZQWakHRrTGj+wXl7XwcmnjKBk4zi0LLkioPAlmo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaRzQye2ei9GAYkfe1oJvMcB/RiiJwqv83XZKkCYVAu/Bb5XgN
	rxdSeo8RHCieBDXmkTjDwvXLai7yaqRw/d0eatVo6zahILsrlbTpl24MSEvQYUVI2MI=
X-Gm-Gg: Acq92OFRggNbfXOGVLcE4tK+Zt9SYOI26FmB9FYGJ1lNFmxKQbAStKNWiOyAZbGgCmC
	nY5ZR4OGZ0OUZTnYtesWPtAkXxCigspKnhkrf66c2Cq5ZlTOohVNPDdSnw83K8rw2jPrAyF+WAb
	nmp24+8+lO/QTUNQw/8SordjWqI5q0XMHlAcWr3Dlsp1VEZQWsybN+6WABW0Z3CU2OfI0wle7IK
	TiTt32jIwlknXBWHO5O/SW5Lc1vx1MR9OWAQkmaXejTLk0LTGyjkMZutjl6eDVUdsjOI768qrpk
	JRKeUjNtvDIAW20ZNnJ6qeLMp0UvqVEo8Ha8lzYV+6hUd1C/FeuJQ5ybe6xF0QKTlDhftp6Ipsn
	bYfA8RnBMjCEPSdX7JDnxZGJCLH/IukR9J5KGXOJ2hMKRvR68G5YJZlukTt7bt4qh5ywPEZ2e0K
	JeU+IFlzsb4F1DgFnDIMUCYMpTfNaGNLo=
X-Received: by 2002:a05:6000:3109:b0:43e:aa88:f1a1 with SMTP id ffacd0b85a97d-45c59702ee1mr3542834f8f.30.1778663686628;
        Wed, 13 May 2026 02:14:46 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm34590821f8f.4.2026.05.13.02.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:14:46 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 13 May 2026 11:14:30 +0200
Subject: [PATCH v2 06/11] m68k: mcf5441x: add CCM registers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-wip-stmark2-dac-v2-6-fcdae50cf51a@baylibre.com>
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

Add CCM module register offsets.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 arch/m68k/include/asm/m5441xsim.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
index f5acc962bb95..9ce2cbb05316 100644
--- a/arch/m68k/include/asm/m5441xsim.h
+++ b/arch/m68k/include/asm/m5441xsim.h
@@ -125,6 +125,26 @@
 #define MCFPM_PPMHR1		0xfc040038
 #define MCFPM_PPMLR1		0xfc04003c
 #define MCFPM_LPCR		0xec090007
+
+/*
+ * Chip Configuration Module (CCM).
+ */
+#define MCF_CCM_CCR		0xec090004
+#define MCF_CCM_RCON		0xec090008
+#define MCF_CCM_CIR		0xec09000a
+#define MCF_CCM_MISCCR		0xec09000e
+#define MCF_CCM_CDRH		0xec090010
+#define MCF_CCM_CDRL		0xec090012
+#define MCF_CCM_UOCSR		0xec090014
+#define MCF_CCM_UHCSR		0xec090016
+#define MCF_CCM_MISCCR3		0xec090018
+#define MCF_CCM_MISCCR2		0xec09001a
+#define MCF_CCM_ADCTSR		0xec09001c
+#define MCF_CCM_DACTSR		0xec09001e
+#define MCF_CCM_SBFSR		0xec090020
+#define MCF_CCM_SBFCR		0xec090022
+#define MCF_CCM_FNACR		0xec090024
+
 /*
  *  UART module.
  */

-- 
2.54.0

