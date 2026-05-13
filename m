Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A773C4547
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663692; cv=none; b=LuUeO+1x8bjQUu/93qy50o5lms01MgSOLNdykamR42/qZEExRZDaf3cZKCZaqw/WBH282dJDelhtS8lekLnN5drWrLMcIojjPs+vwoaIvo+yeFizIdDVmQzUbr/b5VpvniacL7/bgC3P+3Re42SOkMsoTqjslsUrK6qpr1TW85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663692; c=relaxed/simple;
	bh=75fCaSjU8+i1CPGSdebVDw+f11JzpvCORP++yWtAblw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P85sY2gJymgc2GHUfzXkMRfcCr8xIN2Q+mMVf/zPIwxEyXewblrnfD794kmNl6/6SyWpPNUTJ0TnkhP9zFUtCj39AdCsBomhG2eK0cdgVpZ514QrEuAQurfS00BxLqpdNqDPM918Mv/MI1teNXpD22vIW6+l3AJmJI2FH3glovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=iMrhS/GP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="iMrhS/GP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso40634605e9.3
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 02:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778663689; x=1779268489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lE9EKx1/wkTsoQUzPsz6//nDZdCFOzQbMRqAhJ3rRGg=;
        b=iMrhS/GPk5GaDq2frzLn/QV7xNFMfZ/dU5TtJQmnWkNmnzr9RZoV54qBi5bYIIPJO9
         rQ2LM6ACP+01PkmEnraL02hY0p7jFxWYm5XcJKVkOA0x6uC7Kyvzsm/GxfpyIDFufqs3
         gs61DkyHUQye4QUUnkat1Lf4U2TPbDgDACjZ+9yPe3qERmoiZvOTkuNbTgjU/9A/l/F5
         lLEDPXcERkbOc4WqsLzyL6WZllteVoJ77JMM/40RKMoJ6G2LvzakXqZeKk7iXclf/6Cj
         sZ1rx1lwsQoGcFjEwocLv+Cs/jRchNYJMs1yTVwwoDdZBNyKPawut7MBXwYjri4Zfg5h
         EY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663689; x=1779268489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lE9EKx1/wkTsoQUzPsz6//nDZdCFOzQbMRqAhJ3rRGg=;
        b=jAu+h+p62S49+eD262C69UOy4ui6/1vsUwIzYxKU6QWKEqBLCN3UclAWgx4LFX41z6
         pn/PlJt44xDH4hDTyi+Qv5rf9gu669MnNbi35cVJWdso7yXsAwcL3xI9y+F6DtiDrPUB
         5zhlVYD3gPXvTdE7EcxxnrkrfRUx4Fq8efSk2c5O+orjt9kURvEdCiiFKa64hVAfeYRl
         pBkBWfdJAUx1jlMTZ8wjk2e7yvR+sT0M1pdNnUToOaURc6V1EM3BID+/iKbMrrCgSgvj
         0QgD5fmaondaTUWIVY5yilmgx5yAXS8eVftUrJ8KjnMJL0NfMcopQRHM1DvQqqArKO8s
         xdZw==
X-Forwarded-Encrypted: i=1; AFNElJ89PlUPSKXdZ5Y8E7rmDz1j3YRI0CQJ3qROB2X316DVNK1cxJJJ/pU1Nm1ISs4PjCW7Zto3E0vy2pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFKIBAyE+Q0/w/1M9B7qpp+Shdt4BlSpuoN7yNxJrooCkYgmST
	2Y1teIJuH/wMleikoNSyyliqWXp9dzFCSEmcPcZjLhvH2HsUmDkIqnQIHBztZeAsGro=
X-Gm-Gg: Acq92OHDxXUgpOKOnkcuvxPgjV1zjjizCtSWdDoREX255H+XiSAReu3+wNix43shfhd
	iCaOQGF4C4ib6wl/j4trIlvvEYWJ4cCv+mDgp4QxaeMJNwxlAto7AoGyJLEX4QMoJMx5UcT7rfM
	0CddQkZ8d5x0vfqD0giIFEMHWZiKqn4dfAj0fCWjzKo3P773kOUk/ziwB83D1Uuhq+Fr2KwEILZ
	5uPyp9eGiu/3nw8W2A8qMU5ttgn8TEsmnZ04xNfAXwnx84tVbOU441VHMMMZ9SxAsgd+1l9dbHW
	EbmATNXJkEN7A33UBx7xvL/lFrFwr3UahY8YDdQ+T+PanvLMt/8H9twKr8VvZ7TsWDamWUBj/g4
	d+0YL7hGYzr0VoAjBGsGC8ef7s0GO8U2M4Ue4152aEHvyQ1wCPMFnfyRoaNg2tYFP2+YUj2fFr7
	W8KYxFziJdSyhGSoa76CSb604Tbt6hrNQ=
X-Received: by 2002:a05:600c:6096:b0:48a:592c:e63d with SMTP id 5b1f17b1804b1-48fc9a30d10mr33302395e9.14.1778663688627;
        Wed, 13 May 2026 02:14:48 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm34590821f8f.4.2026.05.13.02.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:14:48 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 13 May 2026 11:14:32 +0200
Subject: [PATCH v2 08/11] m68k: stmark2: add mcf5441x DAC platform devices
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-wip-stmark2-dac-v2-8-fcdae50cf51a@baylibre.com>
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

Add mcf5441x DAC platform devices.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- fix copy-paste error on naming
- use DEFINE_RES()
---
 arch/m68k/coldfire/stmark2.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/m68k/coldfire/stmark2.c b/arch/m68k/coldfire/stmark2.c
index 9263b77bd09a..aa2b4d2a8a64 100644
--- a/arch/m68k/coldfire/stmark2.c
+++ b/arch/m68k/coldfire/stmark2.c
@@ -8,6 +8,7 @@
  * for more details.
  */
 
+#include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/partitions.h>
 #include <linux/spi/spi.h>
@@ -94,8 +95,32 @@ static struct platform_device dspi_spi0_device = {
 	},
 };
 
+static struct resource dac0_resource[] = {
+	DEFINE_RES_MEM(MCFDAC_BASE0, 0x100),
+};
+
+static struct platform_device dac0_device = {
+	.name = "mcf54415_dac",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(dac0_resource),
+	.resource = dac0_resource,
+};
+
+static struct resource dac1_resource[] = {
+	DEFINE_RES_MEM(MCFDAC_BASE1, 0x100),
+};
+
+static struct platform_device dac1_device = {
+	.name = "mcf54415_dac",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(dac1_resource),
+	.resource = dac1_resource,
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

