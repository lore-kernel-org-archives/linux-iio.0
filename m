Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9AE48BD30
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 20:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123720; cv=none; b=uocSwO4LSxZMOHlQoh87m4G2d0BoAiLuxGoukF5B6F7oH2AfVM9wH6IhFLN00OeAmj1WsmnCFc1tKX6tSVFl+cDoFbwQiDT8AEb2bDn92yT6jfD+xnvxMsKsUx+oe8ADoSPmKG+ED18iYFTILZqHrWveSr1gmbKXmsQq3bN2Uqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123720; c=relaxed/simple;
	bh=dJzedjeiVUZZvYyRePQXz5ymJdk0khsi+RzoqP6SPL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EugdEX+vUElR46SvaiDKws8kde0wBOYQwXjKeIlPGcGzxlLLFlIa0qW8FKuOQ32sQbb7pjxNcK2kSSZ3IE2FYCOTEXQg/8P70QHflJpm7wWC2U5zv5cMJBBMo1CNYOpCNL/Ng/BwNuZlhYzSCi/TpatsTyva3xxNG8oPGm5pDus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TJglTSWU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TJglTSWU"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490af320e2aso79400455e9.2
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781123717; x=1781728517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqvGT8nRbToe2huAj1fjYmy1gzrEv650bTAoZQ7pGZY=;
        b=TJglTSWUj92aK+ce+VTj9qddwrF7mfVtlFpZtvOq9FwVbcXwYaRpDgl15Ey0BSf+rq
         WeS8U5CI6VFpeIjoob3zNPCoPHm1Yf82Y7G0qiU6bKgwZv1fJymO+0JxPkUOf0VIe3va
         1N7qeDuQghvEOaY6XNEV/jn8GnZ1esua+nV18Wv5X4JL67pwfgoU3OJOSVUGYkwF1pvs
         IYgL3awk5pnFwLKoATzSBdg0d+9dqCQgX9b3VwUYdXyLvzfw9RNScFcGh8jGEcOdW7Jf
         +bA34lJcMH1/rLVvtK2IfDMOCFTSAOcN8maOQoPrM2K5DP/I13CEfMIbA5Ark4Q/Bgf8
         Zvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781123717; x=1781728517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fqvGT8nRbToe2huAj1fjYmy1gzrEv650bTAoZQ7pGZY=;
        b=bijim6bR9Ner7SXoj0gVxKedFMAw+lv9bjNDZQTxFS8KNWA+i31CYAM6JZQonGkBZy
         GpIWhwb6JfqQil9OxYWyObEXs9ikfUUMn0i98zHqGAUIOuI7MoY0Ta+BXB6lcTHTxqm0
         ljvXsQWGSrIq/GuIBoosSqVRWhlK5qELBQWY9WYW+n9cppOeyOGTQudRfnyOiioQ7Mh7
         ftYkJan3/8L4HGcDODKQitQXr5Cli9NBnqun1OAN5GYkZIDrzN6VxAFM/59qJAdATScW
         CN01DhUbXdowSziNU36xLtzOPpofTTsuH+IuYTJ+GhLdZqDy8f/PFkiIapxjawZ5AI0W
         rSqw==
X-Forwarded-Encrypted: i=1; AFNElJ8obNSWUnOECgwnKQg0wv8ehcomLqA7tQ1Gg5HyK9YnshG3Gj7aMQqq6bShCK3qb7SLAXvXPGTp2Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+hoI4Vv5w986mrOaLc9JloIzPezp7I1nSAu6UUed6YaGq20G
	18gGCXCCXCnRSIeQQnfRvpzKqVkIMVY4yWt9mpt5vtwdtgJ7yk1XaHyozWc43HFNELU=
X-Gm-Gg: Acq92OGYwxEjEZdws4nBb11hl5peAezAuzq0/6m3wr8ixzWNI1jcLNy4HOIwXvE7zYX
	tmZ7wHI8zHNHG5Im0OMY649C7/wgBrnaljEDOcuq2OMrichNNnmaCzC5AUc5o3U79/QSVrQQcUy
	8+9oM7G+Yv05PRfJeojOZRK50tRMUwMCAedF6QjXHLe0j6ckqSEd/bVV1c70Y9PPrOSZM/tyGBx
	cUgyJqfcC1BCq7byQkhZ8Rd/CSspY/zdS0kgDisLkpyX8Wg4N5/6mhk53HzBgkw3nNAvfsjBt0S
	YZnBZoEh9z6DeKE4QDxcw9gGoLyIUxAYGi78irD0efCjGLWOqmiqXUa7YYbhPWAHg5U9j9v054x
	5QHSyQ6lYkbDV2nLq+aP+KmvSTk8t2Nl3IQ6KC0d4e/rm4gjcZThD0tj+UBju20Y56/yNNa7V4k
	Qn78pjAOfkde15jRspP2p7MyZn9ZyRIxEmLMrAD9kVZA==
X-Received: by 2002:a05:600c:35d4:b0:490:b8d3:5dcc with SMTP id 5b1f17b1804b1-490c25e4634mr451218185e9.19.1781123717535;
        Wed, 10 Jun 2026 13:35:17 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dc4715e4sm62390975e9.0.2026.06.10.13.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 13:35:17 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 10 Jun 2026 22:35:11 +0200
Subject: [PATCH v5 06/10] m68k: stmark2: use ioport.h macros for resources
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-wip-stmark2-dac-v5-6-b76b83366d5c@baylibre.com>
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
Changes in v5:
- add linux/ioport.h include here
---
 arch/m68k/coldfire/stmark2.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/m68k/coldfire/stmark2.c b/arch/m68k/coldfire/stmark2.c
index 9263b77bd09a..7eed6097f501 100644
--- a/arch/m68k/coldfire/stmark2.c
+++ b/arch/m68k/coldfire/stmark2.c
@@ -8,6 +8,7 @@
  * for more details.
  */
 
+#include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/partitions.h>
 #include <linux/spi/spi.h>
@@ -62,21 +63,10 @@ static struct fsl_dspi_platform_data dspi_spi0_info = {
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

