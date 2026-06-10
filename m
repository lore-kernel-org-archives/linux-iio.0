Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9C1481FD1
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123718; cv=none; b=VHh+cqT+A7SJo+fR6FQcr+Y8mXdxOpDBYnyoeqTjfWxbqwRNhkuGd9t9Tc5eOdwz7JTDnFZ9UkiDT6ayl3yp0w8naUvYCzY9IvBjnmoFyeoq4mLxeY08NRnc97dp1bFhjSgXN0HVnHvi5hjKgZ2dU8hvXe+snRdOGrBlwtdUzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123718; c=relaxed/simple;
	bh=n0b364dDBrWM4RGQrGIAbMsbTV+2t0ZGtLdE7nGAO9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DMnJBFIFP3XaREUHDyFtaOZgOy/r7zaMeeYMrl2DFO5RHfuheeON1RwgADknzv86N0UC3IYnsLHm4wiWQN3uXf9N3HCqQXwVQ5n9oP+V8ZyubMlu/4AtGCf/uqcyiG5ihjY1UuH0IwrbmOo0TmEfC44C89DBdqVhvlEs48Lgm6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=AEiOD+JR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="AEiOD+JR"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso60513735e9.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781123715; x=1781728515; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqVoCiMOeXwzd334lL+Kbbn+xeppyD+CHd7jRk3nty8=;
        b=AEiOD+JRKCvs/2U5obBl6aOBk55BYLUSXUJOoKQjwazwa74ceFbSekKKtY9LSjRFld
         2wgommY9IiKJbvdhSUG/rd5VfGuTxoTu4CstsRF0KV4OA2UapYeZc6c1K7SEiQ0JiZjL
         rYFPVN0jxyJv22NvgA0lq3AnNZ5wy2mSJq6QepYAZ014u0JmSjcwdgQhsX8W2IK0zmsk
         /YZ04pCBAosa3R85FyF4kr2bZxMrDGXgpL2ulirNGrEfFGdJMZm9bRdH9DWEXwL7E4lq
         yuESW4YEATuwM6RHjJiFFWyuzxbrOhzMXslxQYU6RBGWn8yQ9glTRXWzSTNoT7rAoEfo
         dXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781123715; x=1781728515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mqVoCiMOeXwzd334lL+Kbbn+xeppyD+CHd7jRk3nty8=;
        b=RGAN7Psko1NJYbda+AhnIA8jMLjMKLpxTvuEdi9Oobtr6cf2sX7RMoKnSZzlOE4Ajs
         C4Yppdgg1Mf1VvOUUAnY1TEnYzw3gh1T7Z+1f4ZhxGu4j/hBF+ECj2HFbC4bLIpGeInv
         xGYa9nSXYp5Z3W4Am+weBZfR4oxOCoYPta1eRxD8EoxheO9nX+LZ92wtx2RJK2MyfIeI
         SlLmVb8ccUJuU3JQMs7/RzDA6tCS5Y/jHUPQbMnkO8OJQd9uS3yRtjvt30gROrDOxn84
         QiQP/NVLvoUziXR0C2L+dErOZ3ezWfLOQciDAxExfJpkZ6KAuEHXYv0b/t1yA4JBzlbh
         Z8xw==
X-Forwarded-Encrypted: i=1; AFNElJ/HvUtJjA6bpr11ir8Czk/R6Ckgl+T+bi/UFIjGmWKmmibnUI1CIA2iY99RuL2XQ1hGy1EpcePJ/zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxUvTWToDLIk4AZPbxZkQWESnTiN2iLX+RA9uHdByX+78mgeh1
	2o0sP/nYvKflhJaVH6a49QDtPpe0ctoLhiMXirgMrHAS0kK/W6pndQ37PfhPoPCcSzA=
X-Gm-Gg: Acq92OFBexR1Xjc7zguDKULLp6hW4T5CaPqE4cFJxGIkR87bywGzO7Nb9DSJAuUbM3y
	9d3hDvGGvTzL8dZmFIlZQK3EQIqtH/fPU2Jfcn3Hx10r+XtkTMIzlWUhim6118OYOeB44SUDuy2
	G4hwKsQPIk89RimSa9RGLlSsr2E3PYKHOajQa9hZmxqFgOXcwVkNZVt+9ea2hnOWV/T/Ft0+NxN
	gZFGPYI1w9+Ct4gUoZK0XvO8pTPjjwF8RJeCkGSwr/XEBmCqZ4ox2zech6hU6n+Z25TcjOnq/Re
	Nlr7SOYFwAhsY+eG6NjmnBRC3ZtdA5TcSJnNUMmyLtnx3tcjgxs+aLEQXckX6/Rf5CnYQETTJZS
	cACbTFpvi0XQYOhQ4/JoMe0TmlCv0NoLKAMC0hLfzVpN/6EUxwo0v5eTNLv+lwh41Aor84q8b66
	5R8ZTRAaRVRZauKJbTkgsRMpYF3Zvh7Bxdeg9pGBDeHw==
X-Received: by 2002:a05:600c:3e0f:b0:490:ce99:d2ee with SMTP id 5b1f17b1804b1-490d72058b7mr116681095e9.15.1781123714768;
        Wed, 10 Jun 2026 13:35:14 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dc4715e4sm62390975e9.0.2026.06.10.13.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 13:35:14 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 10 Jun 2026 22:35:09 +0200
Subject: [PATCH v5 04/10] m68k: mcf5441x: add CCM registers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-wip-stmark2-dac-v5-4-b76b83366d5c@baylibre.com>
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

