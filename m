Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF2638E8A4
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484888; cv=none; b=hYOGSp5SU1IEIWQEAHSSISygbLONWDT+y1st9VmqzqwnvZ2g7jlisk44KKm7aOKtolLH2X1mY/Vs2VMm51B6rbhN3pCzgWyWIogcegcXViICD9u+CdJ5IuAPtBeWwQ+W4z95OMJdvQiGFHeHRttAYXvdFjUAH/w1IIXtHmYL9+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484888; c=relaxed/simple;
	bh=iFBnWNy9SV4SAcwunY1yH81YlisibbWmCe18BpxZkj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hO/Jz+528BeIRKkWSiMeOYcGHnRXPQLhlwbYzizC3lmql1HCbQ2MSRhaK7exo2ii29eyZQAK0f/XLt7d1IvUyWOyfMWDYx81HOrDCoukE+B3O7fcM6tzk2fb/ovG3QVZICPthmzd6azPbLNOYPDpJRfWRR2UBBhQxUqOxiLMVJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=NryQe9/F; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="NryQe9/F"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4903974854dso20818055e9.3
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779484885; x=1780089685; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VkH/fl0oDwirECp71YLEqMq9AkaqaSB6/Kul4n+Czac=;
        b=NryQe9/FCCPDbGIc1BJ3d/fCYHiuc/EkuJSCLuY2sq2z8H73qfJ5OmBp00PKGiC8z7
         VNso/TEDTUy/5ger+U/BNxQ6Lf+k7MZp4U1FbBcrfns4pFEIY/15ydIvhVOe1smS6R+5
         TKyyHTAzUQxYpv+U3RI6Y0gNdCwSKzyEN2Ymk19NshMigYqMh+ilrGuN8E83B/fAzWAz
         ZQbCVWFXXR5wbgVwnU0IAP5sriU2tyC1NCe+yERXPdrux80cOR0xPb+cnvRW5qTva4oY
         jYfYKI/Z8019trD1E8uZUCoW7wpo1un8vUy0AWMe5jvrXMmgdm4dsrChEDYjCqml2mQh
         KRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779484885; x=1780089685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VkH/fl0oDwirECp71YLEqMq9AkaqaSB6/Kul4n+Czac=;
        b=qalYc7kfxINMWwmLme3xUJRvHGqeTIbsYZi3KL8Z8DA8L8agdOBrUgHDSyWNqAwSCU
         j00g6hFe8z7JYjRxXTvIJt4CeLxjMTWaggmPt5Xe1wgoxuoCPC8pZtbj631+RvqlYh03
         CQIBm6w9QQWToIxCZuOV6KC6AgNOrnJs6oM/Tqe02qFoA/7NmJFAh+hAxlHlynBd4bNn
         jkZmx70NpEIkmw3QlwTY0hc7lpSEp3GP+JfPV02Va3PTJVk4ZvjNJK116L0EpfhN9aIe
         uYrS41xYNpk8K8pb6kSS6vliJGTunPrBDdsOLbaYJBQk1b/A5SZ+gSBp04Kt8bYs3WoN
         ho9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+jhbeBUw2ZBOQx6ObpnVUE9fHbyfM7JA3pv1hEXqsLRh27q/F/dccNrLU6vsIaE8aw+k8MSXt+DJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHPnA6S6kDwRyRtAyUUBYuAFeiAHbLkHAC5gA3XnWcbK8nSxAS
	c5JXmkze6K76QYoqfxW+ItN8snsNBbnRSLiIMNfdTp/PtV1pQ579V8wmySooUV2/u2k=
X-Gm-Gg: Acq92OGa9TmK2ck531dlTcBS+gZ6FYWWZTq7SwbV2zDc06fhJs6PGlRoTaI6GykBVW+
	RVYFxU84xc1YG8PBOmeMM5BsJKnDvV+ExMYi005/KmYyE1vQmEIu8WgkjmgW+g/ueMK6B6+82LF
	dG2JT6BZj3rERplHZlYsdxHnrqhXJgpmetbTP06GIEroB1YsqNxMiz+6B81OdzHtxBbYgCKtE7v
	1F6Kd4da66dMiVFYppiYsziFYbIPrQThlmpncpJOc3Ku9t2jaXf19yuX8mvZ0LAKhBfj42zfBZB
	I3Tov+IyRmkeD6eXR2UF98gVIX0i8b2zw6lJR1uGvs4EN9yWCjfLOLSv7XbQUHrREsoqR1U8RkI
	ep6GbLo7BwVGEx/OIvgjKOa0s+DD3MzP6L97yWn9YkzOTEevpsS4OkD0l3aePKEwRGqIx/c4NZ5
	JoD8R6ceIGr20cKBQV3JjNVdvX01CL+D8=
X-Received: by 2002:a05:600c:1c0b:b0:490:44eb:c1dc with SMTP id 5b1f17b1804b1-49044ebc2e0mr79758455e9.20.1779484884911;
        Fri, 22 May 2026 14:21:24 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b82sm73312225e9.9.2026.05.22.14.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:21:24 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 22 May 2026 23:20:36 +0200
Subject: [PATCH v3 08/11] m68k: stmark2: use ioport.h macros for resources
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-wip-stmark2-dac-v3-8-16be0ad35a67@baylibre.com>
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

