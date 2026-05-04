Received: from mail.kernel-space.org (v2202511311555398556.powersrv.de [46.38.245.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD4D3E2745;
	Mon,  4 May 2026 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.245.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915031; cv=none; b=fSmWkSQc/m5YELYDdAIdWmLhDPjC5Od3M+6XBPnSHq5DJmoDRbc9yva6wrVHGpnl5/cOqhqHaIiV9otWbXOD+Y5sJvVdIIBQNa5B62dblpdeWgDRh6NwSLTV+OMwFShYmJtTKGAkxNJ+EBUQWUNUoxvkIbS1R3E+3HeJx6ff3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915031; c=relaxed/simple;
	bh=XK4gbLCyPxDWg3kaxQ80NPr0aOIc2JZzkkU8Yu7ETVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bpX8UQWv0zY7mEfof0YKkbz8pqdEWbom1AQ8bUrqCwZhmIdlD0h+p2SVfAFHbnwRqg32DhAketmaQ8Cmc0ZP49O2JjZ8+nQ2nnTeT7z6kOZDFpopPlZc40o6b3flgYjbcbkT1ndwKkrUAhwwmO5pVaie7Gi80DBefK9aJoWEu9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org; spf=pass smtp.mailfrom=kernel-space.org; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=vqktDZFo; arc=none smtp.client-ip=46.38.245.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="vqktDZFo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
	s=s1; t=1777915003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9fbcKoaqme5Vz1fCTzuqtyu8Za4tl10mh+oXgKUmQo=;
	b=vqktDZFoJYnKsBv7Qg3+jR2KORdYcXNDAAApS5NXnpUaTfHbLvr8OfuEzxzckPuibuLM5u
	eaFoMh+hPSMYYR8kKZoNrCBtFIhAgqK7d/m6cjzE/ccJGbTgGKxse//ia/IZKONSmkl/3g
	60Rhk+UlCDDKSdYz0PKhuwt/S+WP+L4=
Received: from [192.168.0.2] (<unknown> [2a07:7e81:7daa:0:62cf:84ff:feee:627])
	by oreshnik (OpenSMTPD) with ESMTPSA id 2e036497 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 May 2026 17:16:43 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
Date: Mon, 04 May 2026 19:16:41 +0200
Subject: [PATCH 03/10] m68k: mcf5441x: setup DAC clock name as per driver
 name
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-wip-stmark2-dac-v1-3-874c36a4910d@baylibre.com>
References: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>
In-Reply-To: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>
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
index 5c33d3896cf7..b21638844fd4 100644
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

