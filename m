Received: from mail.kernel-space.org (v2202511311555398556.powersrv.de [46.38.245.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E401D3E4C95;
	Mon,  4 May 2026 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.245.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915045; cv=none; b=OoBgHZlmnlCUHsTGZzrKkWIPCDXWJEaTo39umCG5VCtUGBJSwBcZOPpZ/KzbJT3szA2Wj6hQZ0Z4z/36P7GL4JJXSZBd1LMDCrCPXB7+4DHEit6qpF6luoypwoEWtcBfPBMnpG06OGiI188fpn6YUH1P0eyIMd3qKIJYjO1zHMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915045; c=relaxed/simple;
	bh=DdiJJP6JWxTYdbbRr6DCUunKojbBZ9SL5aGjDPR7h54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fcRb4ZwgV/BQkxVXBf4NV5G1FtHRybvquHrtNKqe0dyXvvh+zJn2oet87ZRsWobkTIuavOGPpCCpj2SxGgHropGdj2+8gg3OV6O4smDNX0Zpff+fMrrJLo6HiXUB2MZQSi/Wfcx5pHRkcKIFHVWE33Ql3eGmHvNqClyVOe/QW9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org; spf=pass smtp.mailfrom=kernel-space.org; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=AdIGNAC/; arc=none smtp.client-ip=46.38.245.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="AdIGNAC/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
	s=s1; t=1777915006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htwcYAHQIOqaxElDjDYg+njAl/ofitRP9nvq1PHSWrQ=;
	b=AdIGNAC/f8eX5Nk4/DYRKJ47wDOaG5+Tm6BE7r0ce9U566IdBy2yLs6p8pj3MvelWbnPLz
	7Eok+5yzAdilxJ2cWdXWxP3de5HbS4RP7rcRyCLLUWkjYv8xQ2o6d/rSHkh1zxK0TP8xd/
	4Dj3Hvu8ShfBwj6Cyg9g7ZITiB/Q0Jw=
Received: from [192.168.0.2] (<unknown> [2a07:7e81:7daa:0:62cf:84ff:feee:627])
	by oreshnik (OpenSMTPD) with ESMTPSA id 2d248f23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 May 2026 17:16:46 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
Date: Mon, 04 May 2026 19:16:46 +0200
Subject: [PATCH 08/10] m68k: stmark2: add mcf5441x DAC platform devices
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-wip-stmark2-dac-v1-8-874c36a4910d@baylibre.com>
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

Add mcf5441x DAC platform devices.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 arch/m68k/coldfire/stmark2.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/m68k/coldfire/stmark2.c b/arch/m68k/coldfire/stmark2.c
index 85502b81175e..30da9bcbfd63 100644
--- a/arch/m68k/coldfire/stmark2.c
+++ b/arch/m68k/coldfire/stmark2.c
@@ -94,8 +94,42 @@ static struct platform_device dspi_spi0_device = {
 	},
 };
 
+static struct resource dspi_dac0_resource[] = {
+	[0] = {
+		.start = MCFDAC_BASE0,
+		.end   = MCFDAC_BASE0 + 0xFF,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+/* DAC controller, id = bus number */
+static struct platform_device dac0_device = {
+	.name = "mcf54415_dac",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(dspi_dac0_resource),
+	.resource = dspi_dac0_resource,
+};
+
+static struct resource dspi_dac1_resource[] = {
+	[0] = {
+		.start = MCFDAC_BASE1,
+		.end   = MCFDAC_BASE1 + 0xFF,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+/* DAC controller, id = bus number */
+static struct platform_device dac1_device = {
+	.name = "mcf54415_dac",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(dspi_dac1_resource),
+	.resource = dspi_dac1_resource,
+};
+
 static struct platform_device *stmark2_devices[] __initdata = {
 	&dspi_spi0_device,
+	&dac0_device,
+	&dac1_device,
 };
 
 /*

-- 
2.54.0

