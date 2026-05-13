Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D873E5A17
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663687; cv=none; b=hukj9oMHY4ebv2DVaefW37uCCwmmSM58Gbi8UPBQo7/GA5Zu98JFUT0EqfTVcaayHULg230/BuqIpHnztZGS0TAJaFNWW2Q2nHMZDvzD3CgwlnlzW6uIfrYUGEQaExKyh3Ri4xx5fJZ3MojlvIvoRoG7LNo6Iwg2B3l22TfWoGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663687; c=relaxed/simple;
	bh=cCfgqnRnFnpsCU7wcsZn8o9ArxI6gMZX+08aJp/mfDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XX6E2/wagRkV1NHg39KTXEz8xUVXStvgklVbQLDi8kdORlJqLUX9FPAOpPP/J8wcVKiqqmiiCWrDUKLw71zXwxPyTCBTj1VnFR3LAGgQ1Gh/HAbLiVQVL00ym6zt27INA9UC3jR1KvFJjjxxZYUlC1jyu/IctRtgbF/NS/+cs5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=GlGvNwlr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="GlGvNwlr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891b0786beso41509785e9.1
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 02:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778663684; x=1779268484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VB4PgcZ01Fib8r6PBjxZYMBn+UiSZUTB5bok31SdtI=;
        b=GlGvNwlrV9kUU8Rqf/tzHxKDFbLjmRH8Ucphfv2FeMH1keM7DF65ooL9m+pcIrFM9S
         tZ1N7mT6fGLaEz00upjdZZan4ojO/9n1aT6j6/6VJ3pLf2NAlLSkREYTXRN8usKRJiw7
         TUqS31RfPfIS5bM3ZABXRCdYWyOqy+E9cF6h67lYvUAXRJdYukZuSGWISizqTEKbyLa7
         yB8Ak1TJTudIbobplqv+nTxX3oIo29d6tL/h0RaT4fAUpb1JCFzkbRigVUJqVzfaKUUv
         k4elUms+1OBZWa8vn6DPLbojS0nGCMlbp20dxhzGfBH8VtsK+Nmi5Y52DCSIbkJNod4A
         2wGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663684; x=1779268484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7VB4PgcZ01Fib8r6PBjxZYMBn+UiSZUTB5bok31SdtI=;
        b=K+zt8Ce9nFxI6uWs+DixML/r6pXh2EFegZVRNfAWhEpzjgksRLRHcrrmEScj8aw4fZ
         Du5S5MJsRvC3rPRichzUngiDUjPF//golrTnp5vSeCoUvAt8JaWQW8pUvVfGtZ4Q6pb+
         IL6OhO/LNW0FxG+OITHfZCNmFTIGg1BNLrUTe0QhstwlN85STRe/Rw0wBpclLjve/JTb
         mWbGulhdD3dcEQv/V1lFL6UlWPY3yvQTw9DRCOmHjTDlNg8eNZ7Vb+IaOQHZRlkx5EOj
         WAB+PjmwnmM7eHd7/TSmQRHmexzQe4mgHcdJSQQXJojmmOe3X5yP38dgX6zxGp2NNFOs
         isOA==
X-Forwarded-Encrypted: i=1; AFNElJ+Kr8qGwMgqLOffyl5tS74cPwVlFBsvEKObFQqNq4MxbzbcKtMYnVtgZ0e5v0Bol3CLqVwG9z3eU9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX8oYSsQettx3diqIXShK0RgSRNBcad1uYvazkkwtE0evPn4HJ
	DVZgJ1CQrWtXgwtjAMLx7FUtpZqUnQaVkdtJXsXr3fb3zOKpmQM+8LYupxkRv3YdErYhG1LSRds
	9Ewv49LI=
X-Gm-Gg: Acq92OFfSHLesoTjFoAvD3m/FyJlVVwKJ8BBlDemBcFNZ1KxmWXJHBxQPIresHPBlL7
	MSVhpFAC/44+HxxTsGrzhg1/z2mGZCMPdDlJSc4hlDFYI7n9gyIMBSKYBVseZbU2S8qI9SFlacW
	AuMIyEub9t/zC2C+SKITdFVWP4Gz/QDI8PEhjgezpKU5t9gcryXjYRA0dcv/7GPzQfHg+QJcnI4
	Ol3ZVIhLeYKKhU9fliUzW+nYVgRyePAz74ZgyaA3Xt04906dQKU/wMPGvxgalAIs9ePreMXuEp/
	RIWxfxrG0WVoAITCK2tsB0QfZCY5iWZg6qu2n1UMr1u9nC3sPfwELQj+Eo8X24M23I5dCpWYrrf
	8v/m0dSCku+zQ33wmd+puPW7XJAfY/mTTiJRsi6oBuJVdeXQEVLjZqL5dd/u1aFvIwwqJc+0gj1
	xzH6QNU/qPnb0/NHjznKU9/UQEb5C59eY=
X-Received: by 2002:a05:600c:19ca:b0:48d:46a:6e5b with SMTP id 5b1f17b1804b1-48fce9b9fb4mr24088665e9.7.1778663683583;
        Wed, 13 May 2026 02:14:43 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm34590821f8f.4.2026.05.13.02.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:14:43 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 13 May 2026 11:14:27 +0200
Subject: [PATCH v2 03/11] m68k: mcf5441x: setup DAC clock name as per
 driver name
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-wip-stmark2-dac-v2-3-fcdae50cf51a@baylibre.com>
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

Later in this patchset, the mcf54415 DAC driver is added.
Considering some other different ColdFire cpu DACs exists, the DAC driver
is named as "mcf54415_dac", related to the mcf5441x family SoCs with
DACs (mcf54415/6/7/8).

So updating DAC clock names to bind with proper driver name.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 arch/m68k/coldfire/m5441x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
index 5b5e09ecf487..b724d7fc1a08 100644
--- a/arch/m68k/coldfire/m5441x.c
+++ b/arch/m68k/coldfire/m5441x.c
@@ -43,8 +43,8 @@ DEFINE_CLK(0, "mcfpit.2", 34, MCF_BUSCLK);
 DEFINE_CLK(0, "mcfpit.3", 35, MCF_BUSCLK);
 DEFINE_CLK(0, "mcfeport.0", 36, MCF_CLK);
 DEFINE_CLK(0, "mcfadc.0", 37, MCF_CLK);
-DEFINE_CLK(0, "mcfdac.0", 38, MCF_CLK);
-DEFINE_CLK(0, "mcfdac.1", 39, MCF_CLK);
+DEFINE_CLK(0, "mcf54415_dac.0", 38, MCF_CLK);
+DEFINE_CLK(0, "mcf54415_dac.1", 39, MCF_CLK);
 DEFINE_CLK(0, "mcfrtc.0", 42, MCF_CLK);
 DEFINE_CLK(0, "mcfsim.0", 43, MCF_CLK);
 DEFINE_CLK(0, "mcfusb-otg.0", 44, MCF_CLK);
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

