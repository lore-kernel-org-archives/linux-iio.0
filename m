Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7637D385D81
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484881; cv=none; b=YWHyQ/55DvzmyAmt2DTKJff+8gr9uqicfvu5IAz0NJw+n+V2FQLT99NrHP46SbmmA2J5z3acna6JHU5K7OFpdKM2atJJt9f4iy2jMLCKMgNz670ZQfUjSwcIYuvlYonbPxNClB/+cPJYP2qpM/QjVXLOcF3cvt/nl7r7MgSDLXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484881; c=relaxed/simple;
	bh=AIY4P522I6mAiy1VKzYtffjJj8yluqaVUv3znf+Q8Qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tLIx7X5jDofhsAGoKHHdHOKbJvHG9kSG0wHaeeb0OHuohbb/ZiZFPhgZuoSBrgStg5RqMaIUthUGWCE2F3vYzwdiBSw7fIt8xGv4PeR5bbz0/MRzSFNUF/xMgTik8C02Ggj2Z1CkQ/MgV8yVliopr3a88aB6xtngc4m7A234ZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ibbu5ekU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ibbu5ekU"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4903974854dso20817605e9.3
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779484878; x=1780089678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/JC/lCvJB29DmlH+qRhnlQ7JKVcjCcbMoFC+b+6/88=;
        b=ibbu5ekUvGFxOpDZUD6sJ5qVwXSA5ZtlylRkOk/lcoSvL3KbySytvh3yEd0fthua3P
         8GXhIKy4/v9wwth0l6lBO8eFa5dQ744jHw/1nzDxw9wq2YL4pDpCKY9WArGoxIaZgF8u
         XiuUhDb5lDtQtChCbVwxkLT+z0DgOptp7vDbS/D/UtNQw7oUIqb9y2Lmcdr7UUYnQOtT
         ihw7d/EFLhtRgxjia7J4K0DS4ks/fX7PFxUUaY5j6dH4qkAjPpg5S3gQgkow3S0YEHJZ
         e5GT7PqnJ/+sK0sPPuVJk+/jfmCb7B1ylf1G+KTNa5hDxSytr3ZuDxdY4jmr8Dvvbd3C
         ApmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779484878; x=1780089678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h/JC/lCvJB29DmlH+qRhnlQ7JKVcjCcbMoFC+b+6/88=;
        b=LZ9ek3Z/dTP6uR8bIRRfSO6Wn02kWO3gWbPAt5H5RWBzTS+8hzKk3HErTnB/sconHk
         CbaI1/tOaqkTSOQ8C72OpoPwRFVZms0HiD3G0kTqMCqDddpOpJU6WdGdg9PidasPGSyY
         LWjw1d7GB/lPCbCG4B6H1LSjazEsSCPt9024kWcTqTVqZ3mz7428CDLkr85XYrKAVBae
         8I+DG4Q1C4N4/sfbTcZPSBUNAFTfcbUZ0t1Rk+wwmpxciFTSz40aUf3Z5+X6mBO4izuU
         LICbnywdGIyf2ueXdyiPGEF5WiaQOzjCHNzYhbEtCb0jL5CxaCPMcJkE8MuYexHGKJFf
         LkLw==
X-Forwarded-Encrypted: i=1; AFNElJ9oVLGeVgOzPK0IVFpPCTv+crfQNtWWrxQPsiF0uJANKz/J/cptSlankxb71qt+x97BAp+PCXMg1o8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZW3lNogx9I8D1bXdbklceYNvM+XDisWkLhFXgZTVUqlP7YzTr
	EM8/+MnIoQL6D4tTnhttyFiJoI4MdHyALKb+K7WTagozAFTigzdl64rWA3OwpsamxFk=
X-Gm-Gg: Acq92OGbLjO/oZg4OMGrOtZ8reMwPLpD9vRCzmi7fREnxtbvf3f71d7AGNtSd8KgoE8
	uRVBFSTZKOP6q0fnrPczrFAuzO06GdgmwPjsXFR7NRiw2QrIHp8Ec8Xa74xg3uiTGMh8lz4+83X
	lxqfPYTfkrDZszlI6Ij4CzCHskNxcOrUo1u3tVv1a6FgaFxPowKO+pQEx/H/5zxp+VW28FifBwM
	CcwZKtyI8bk8jvEX/23wsP1U5m4TVENu/Xjkpm3OzLw9kSrWN2ETsAAmaNykgIxyuGGtbwKrR5Z
	rFOLA9I8MPp1lbvBF3NJaEDZIFM+pdNCp0rmCLqeD6Qa4RxYyX/GgrlvYZ+Z+P8IA94kLbhloa6
	wOa09fvRC8kb8AUdZlDLpGn/Szt4Lwn/U0MsHFLoWz4wlN03eC4Z+5x1Q3Wq6G1aZFIHS3+rBZ5
	PU7bWmhYQVR1wLUbLVuyAglFgBZ9S7UwA=
X-Received: by 2002:a05:600c:5298:b0:48e:7854:1608 with SMTP id 5b1f17b1804b1-490428dd523mr79562455e9.25.1779484877951;
        Fri, 22 May 2026 14:21:17 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b82sm73312225e9.9.2026.05.22.14.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:21:17 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 22 May 2026 23:20:30 +0200
Subject: [PATCH v3 02/11] m68k: mcf5441x: add clock for DAC channel 1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-wip-stmark2-dac-v3-2-16be0ad35a67@baylibre.com>
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

Add missing clock for mcf5441x DAC channel 1.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 arch/m68k/coldfire/m5441x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
index 613b0275d9d8..5b5e09ecf487 100644
--- a/arch/m68k/coldfire/m5441x.c
+++ b/arch/m68k/coldfire/m5441x.c
@@ -44,6 +44,7 @@ DEFINE_CLK(0, "mcfpit.3", 35, MCF_BUSCLK);
 DEFINE_CLK(0, "mcfeport.0", 36, MCF_CLK);
 DEFINE_CLK(0, "mcfadc.0", 37, MCF_CLK);
 DEFINE_CLK(0, "mcfdac.0", 38, MCF_CLK);
+DEFINE_CLK(0, "mcfdac.1", 39, MCF_CLK);
 DEFINE_CLK(0, "mcfrtc.0", 42, MCF_CLK);
 DEFINE_CLK(0, "mcfsim.0", 43, MCF_CLK);
 DEFINE_CLK(0, "mcfusb-otg.0", 44, MCF_CLK);
@@ -106,6 +107,7 @@ static struct clk_lookup m5411x_clk_lookup[] = {
 	CLKDEV_INIT("mcfeport.0", NULL, &__clk_0_36),
 	CLKDEV_INIT("mcfadc.0", NULL, &__clk_0_37),
 	CLKDEV_INIT("mcfdac.0", NULL, &__clk_0_38),
+	CLKDEV_INIT("mcfdac.1", NULL, &__clk_0_39),
 	CLKDEV_INIT("mcfrtc.0", NULL, &__clk_0_42),
 	CLKDEV_INIT("mcfsim.0", NULL, &__clk_0_43),
 	CLKDEV_INIT("mcfusb-otg.0", NULL, &__clk_0_44),
@@ -176,6 +178,7 @@ static struct clk * const disable_clks[] __initconst = {
 	&__clk_0_35, /* pit.3 */
 	&__clk_0_37, /* adc */
 	&__clk_0_38, /* dac.0 */
+	&__clk_0_39, /* dac.1 */
 	&__clk_0_44, /* usb otg */
 	&__clk_0_45, /* usb host */
 	&__clk_0_47, /* ssi.0 */

-- 
2.54.0

