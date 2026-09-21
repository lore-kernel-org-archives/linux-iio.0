Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0B14915B4
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988526; cv=none; b=fwOwgkFx1PeU1uWySeICnykvIBpX+PGuhUEJD6pJTiVznVSivVnTQUjT4NSotiHdjJ+Z3UAQtgLpaJ3ULuNBVNk6wpqlwAI8rPAAe1rvKqgZRtV8UdNzFye20OYSWXbx4ZZC+CqSWA4jNpGw04dnJOMNUd1BNrbat1EgPUQm6Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988526; c=relaxed/simple;
	bh=El7Fck6y7ypxHU4T5nHt8VEDERbOkkCbpy9voDft7SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dg+uFlCRkcC7nPWoBE4wTNPCDVJG8/lVfr9xJbO8TOg2ap9uXV7acMMfBzGw19z6Kq3CUVqw3GpRNpNL7bZ3srXubzI7UApUpqZKpXl4q9NEjQ+Lu04GJkpwXioaVzEe0987yEv9KZidh5jIuPK5Rz96LiBpyG5kFiyJpbMLvwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqBoXwXW; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqBoXwXW"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so15527165e9.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 04:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789988517; x=1790593317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Egn531y6D5eia68zUO0Bjiv9ns5XoXFVaQXnVIjBldw=;
        b=eqBoXwXWuds2UhyGnuScSX/jJuBU8QBg4ccV8H1r0Ms3MVO1HuQ/GEzyhfg2PRjdlJ
         7i+JjNwbJIdSAl0+pGm3aQcXybtQH32nxsypDxCnZJeKKf6E8jvPp50mug89iMxuEj9y
         9mezbXYpwBUWZ69qnSsrNOcnK0xpV2vxZrh/R2IuS2um7LASuU3ZA6EbmXtNi057/VNZ
         eel27rMcM3XWgz4uW+NlNhPnMm21MhA99IprPtxnZ6+xJlAYqG6xfYpxFKnDHuPynvWr
         lk8uOyqJ8ImluEUxuyJRiZ30DjUHNV4J+81GgXY7+SP+JiMFd/N+aJ01cjd0hR10gnm4
         fEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988517; x=1790593317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Egn531y6D5eia68zUO0Bjiv9ns5XoXFVaQXnVIjBldw=;
        b=UoLUN5bjI9PnPHOGr45ujZ8uW/prMJkOC1NYgaG1tx86/e6ssmZHIU/TH8LQQT4e1n
         biLZA5Fa75AjnCen9PvodnY5D/NE+wcQoYX+sBAeyNWQ5afrdnuPDmNcucyNV9fbTK4J
         /g5kXST20WK0ZN+2e7+lJA5Re8Fiv3LELl/n3mKlvVyLpIaW5JbpFHiwP3+JTnubMW5s
         AVvFmO9nA4CcJ4X/WM0eTkQHci7Qs2d1XCba2y+qxEGFwXLQx8s09PXgcWThrtBIvfYe
         p18O3cKZyYMrRDp7PnQnhB8gLX5UHykuth4b7mYhcG56CWJNwl7lq+AssXNjj0eCNlxQ
         lltQ==
X-Gm-Message-State: AFuF++nYV7+etKg2JeTbp24Ap/ZRTE+euoinurEnlpEVwPpFNExl8Oqu
	O32TE82ubhKuhq5F7WG9aBMzlWj6Ximkd4UE1PDRn9Q7/8E92EPur2qi
X-Gm-Gg: AYBFou3WWDfglyLUN27pPg9VwGwJiKhnzHVn8lsg893oBR2JbdIo8mcpZfaIJasWdN3
	GvuICFa8LcIt+9N5NDJFGBG+CeRvTWtoE/uHdg0vpqs5z8BM3H5YieS3UAmggRHAFxpVyT8wguO
	70QL57cLyPxPha07rQfvi7M1p2q4IXtLDDb0umuced0NrDvTL3K0dLNgBcOqcx0hojHlY5D5d7d
	Y5f/2wDeWRuVcyYSefe7Thz7m7MoHVEo7PcYSN1B2mB2C9qao/ufzwmrCgQLyIn66Ouwnx4taMt
	Xw3aEL1+P61OGD0Hm0UCCPsY1sIKfZHsPH7IvlAgIFKmz6m8O2MpkeN1Phu4n7TiYZAkEt9F4En
	oyBooaQtp73jBbhaYbEmAR/3krG+uHW+gCrDigxo8GK3ensAjGfGuv7lY+Fxxm/T5UdWRzZNZGv
	/KqGP0E7ogYCvzKDAnUXGeDzExmAfHv+Ixt2lALpXprXuAb026CIRCHWCKFIM8xSisSEu6j0m20
	FBLuoys6hPGFNWhwoynOrWDrhhvFX6NjKlk/yI+/yOcjkTTtExjsxbvsiGuSwvMVxxTgK3eGRU2
	TkMqxsY=
X-Received: by 2002:a05:600c:8b24:b0:49f:ce78:3563 with SMTP id 5b1f17b1804b1-49fce78360emr88120395e9.20.1789988517491;
        Mon, 21 Sep 2026 04:01:57 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:856:ad4f:1ab5:71b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd07bc34sm214267425e9.10.2026.09.21.04.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:01:56 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/3] arm64: dts: renesas: r9a09g077: Drop unwired ADC interrupts
Date: Mon, 21 Sep 2026 12:01:43 +0100
Message-ID: <20260921110144.44425-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921110144.44425-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260921110144.44425-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Remove the compare match and compare mismatch interrupts from the ADC
device nodes, as these interrupts are not wired to the GIC according to
the hardware manual Rev.1.30.

Fixes: a82a42963c89 ("arm64: dts: renesas: r9a09g077: Add ADCs support")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index 486692bb84cf..674e35e4f242 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -1271,11 +1271,9 @@ adc0: adc@90014000 {
 				     <GIC_SPI 699 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 700 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 701 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 702 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 851 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 852 IRQ_TYPE_EDGE_RISING>;
+				     <GIC_SPI 702 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "adi", "gbadi", "gcadi",
-					  "cmpai", "cmpbi", "wcmpm", "wcmpum";
+					  "cmpai", "cmpbi";
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>,
 				 <&cpg CPG_MOD 206>;
 			clock-names = "adclk", "pclk";
@@ -1295,11 +1293,9 @@ adc1: adc@90014400 {
 				     <GIC_SPI 704 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 705 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 706 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 853 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 854 IRQ_TYPE_EDGE_RISING>;
+				     <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "adi", "gbadi", "gcadi",
-					  "cmpai", "cmpbi", "wcmpm", "wcmpum";
+					  "cmpai", "cmpbi";
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>,
 				 <&cpg CPG_MOD 207>;
 			clock-names = "adclk", "pclk";
@@ -1319,11 +1315,9 @@ adc2: adc@80008000 {
 				     <GIC_SPI 709 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 710 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 711 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 712 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 855 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 856 IRQ_TYPE_EDGE_RISING>;
+				     <GIC_SPI 712 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "adi", "gbadi", "gcadi",
-					  "cmpai", "cmpbi", "wcmpm", "wcmpum";
+					  "cmpai", "cmpbi";
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>,
 				 <&cpg CPG_MOD 225>;
 			clock-names = "adclk", "pclk";
-- 
2.55.0

