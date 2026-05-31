Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B6D3909A3
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241172; cv=none; b=IHgI4QZHucxJ0EXqcbRd79P+6nUXjsHbphLP+mV1RiWgEG6ZA5dHfBLe1AG0f96B3zXMuhNslV0Vr8ZkW9HxcNDSqIeT7Ck/9NCyZN8ykTq8rG2nAomfYZlHZdPDtHFfYhW0bjno45LHn371vwVDwM+xgwmrOqjqNlKA4ivvAMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241172; c=relaxed/simple;
	bh=iFBnWNy9SV4SAcwunY1yH81YlisibbWmCe18BpxZkj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ba0n70gXtKNJ1lB1K0ir4c8PqU5OS2oJtuqPeJXjjSOdFKEIidvLHj627F4dVUCA1xcFbPwX4D5b7D8lk0TP1ozfIqLNQPFsQ1Zug11pqsMu+ev5ABOUvuy/P/S4JFs7FYhkNoKAPLnJRxGlPHFm5s8fIZkUXMoJglji9p5VrcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Uwc2+oAg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Uwc2+oAg"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ee6d32402so1751794f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780241167; x=1780845967; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VkH/fl0oDwirECp71YLEqMq9AkaqaSB6/Kul4n+Czac=;
        b=Uwc2+oAgHNpCVhLbTHVnPXHFzYwgPmE9ORl6Dc1stJA5mXB82qJpUp5271hD2Psshd
         Qq0cex1iKadtFaZcFRE3MxutqO21Dm+YTRHddDMCEkVNLv6SWBnsj5RlfDnxpjyKz6Ak
         89Yx/mEycXdQQIVtmu5OoeGWXPhJwsA7nqRExYGlMh97rqRx24Jlt24aZlXXK1STcwsH
         kgu4ejrcRf7eB3VvD/qgLdtHyMYhus1T/qvDdGGYLeDkea2TKF684Jo1EpkRs3qijYFP
         LKxSj82rfg0Lyek+01D6opXabPql4B+v0sCi2CN6uHrVOwj3VSDgbkVKcYTgoaNrqTIR
         nvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241167; x=1780845967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VkH/fl0oDwirECp71YLEqMq9AkaqaSB6/Kul4n+Czac=;
        b=fFwUH9SiIGyCC6AtKbaO9Bm9a7moSOR7bV39lC8+1e07LtNv5KFGXRx9oicuIEVzGw
         Fxkq+j+IDjdnFbXywKAulgIKV5AcKd9qOj0GFnkuBNXnDx1DwEKYcvLfERhJhW89c4MY
         xfTqxTOj5EYaHJalFt7qEorM8rnL7gfkrH5jEZWxJNX7GbgVb6a38jtfGxds29f0x3at
         wpS97fTenzDTHq65IsYR2goHYQJdpMFHdDgTVJaZ27wY8VUhPXTvnX3ZhTpbIV87wGPp
         yvwM3L3yGWZ1V2LsBfouUN5kxoOIIIBfMs3nrl0n+59KavLrmqVuB8xKZlulWpZIDmnt
         Yz4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Dgz8kBLKX+aEjKEhX45kCFtI6TvVhFfeE6yg90LvOZINgC2wE3PRvIMrU5ZENXWgahKMbEhHU05U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv0XorNewTiHYCVI/csI2K19HDRAjZ8nfOmrDGKL6tiy9ML9fd
	nxGyUQv1eNC0g2warzQZ+HV332Pd+rsV5q4AWnx0uug6AC0+FDd0lICrZNk/VGfKSLE=
X-Gm-Gg: Acq92OEqbpyd2lLNsLu4UoViCGxU7+GuxagTKvjU+a5+PUXAGYhQDdu2s7J9+AKDtD6
	XTfpNFK1O65k/VHhh18M4z43M0nVUCDES6jKA7LWj17myEUb9sj1JGUWWWGRtfBWLzA0WLC1ALz
	OllFjGJv132QjrwDbJygOxLPhkfTQyII3MvO6EM6ry2e6O2ysRMMyZs66d+Eh4AlxQXlBeBdaTN
	9fDO2+wJJRHKhmur4V+nDj3DrIMGnlIsvS/vbybLBdfwDVGAWkn12ZyfX0Tw7OeUaZk5ilywDB+
	RQABgqWQCTZSawq51p940g7cMdgyVzKvlM/CMEsAevuvt5oS1IlEeUSzMV4t2ioPJ0XKTdoLUJw
	duiidlbwl7+/3GdOo1UahIgtZCjnksEaeuCjfPB8vA/O9gWRJ5zedHBoonY6VKmmGLGuHW3b6Re
	m/fXIrI0ngKlIrn0XPg7A4+Kr9MdzGzqv1Z7w9CrhsYA==
X-Received: by 2002:a05:6000:4284:b0:45f:f142:d56c with SMTP id ffacd0b85a97d-45ff142d715mr7307074f8f.16.1780241166806;
        Sun, 31 May 2026 08:26:06 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cf0dsm18526622f8f.17.2026.05.31.08.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:26:06 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Sun, 31 May 2026 17:26:01 +0200
Subject: [PATCH v4 08/11] m68k: stmark2: use ioport.h macros for resources
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-wip-stmark2-dac-v4-8-7e65ab4215dd@baylibre.com>
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

Change resource declaration using DEFINE_RES_*() macros.
DEFINE_DMA_RES() is for a single dma channel, not a range, so used twice.

Also, some drivers assume IRQ resources are from index 1, so just to stay
uniform, moved IRQ resource at index 1.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- none
Changes in v3:
- moved this patch (cleanup) before adding new resources
- moved IRQ resource to index pos 1
---
 arch/m68k/coldfire/stmark2.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/m68k/coldfire/stmark2.c b/arch/m68k/coldfire/stmark2.c
index 9263b77bd09a..536252ccb87e 100644
--- a/arch/m68k/coldfire/stmark2.c
+++ b/arch/m68k/coldfire/stmark2.c
@@ -62,21 +62,10 @@ static struct fsl_dspi_platform_data dspi_spi0_info = {
 };
 
 static struct resource dspi_spi0_resource[] = {
-	[0] = {
-		.start = MCFDSPI_BASE0,
-		.end   = MCFDSPI_BASE0 + 0xFF,
-		.flags = IORESOURCE_MEM,
-		},
-	[1] = {
-		.start = 12,
-		.end   = 13,
-		.flags = IORESOURCE_DMA,
-	},
-	[2] = {
-		.start = MCF_IRQ_DSPI0,
-		.end   = MCF_IRQ_DSPI0,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_MEM(MCFDSPI_BASE0, 0x100),
+	DEFINE_RES_IRQ(MCF_IRQ_DSPI0),
+	DEFINE_RES_DMA(12),
+	DEFINE_RES_DMA(13),
 };
 
 static u64 stmark2_dspi_mask = DMA_BIT_MASK(32);

-- 
2.54.0

