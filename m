Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB831F9BC
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780857454; cv=none; b=YoRQvWGyXIE+uUtJWU7+vFh8ZFM88JdbMFy0hsyAArFQ4GPSJWuRy74/vLHg1MqmuXMYD28q7nT7tziEm8yCnrb++6yZCvgXJKnkzULFy2hCuryjw/JzGDXatnP4srbafzkrbCg5iBxv+Iw8/f9I9Yea5RDhFIUoTFbbf7SrKtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780857454; c=relaxed/simple;
	bh=U9etQDu2cHlAvrebLmic68W6Lpjpo0kHXWaG1/vMhe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFHd4Eo3voGtp5i7AvOldi/JUUhhVdcasQTiBnO2ucVXmv6hQMp8HOgWeAY6Xpbk/dzXz9IFSEuSG/u0mzLT22Dvaw84KKfVDLN4imuscG6yd/LO2o59ORLEeQ2dD/Wxz6BFlP4hMJrchiW+CNePxyt6ZFHin7h4eftNeoUmTQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGuPVmjb; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGuPVmjb"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa5e9a64b4so3795550e87.3
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 11:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780857451; x=1781462251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GS41SM5ONg/ebWQwreACsYq8O1fsTfsaNjMp6UVj45c=;
        b=QGuPVmjbZmNmGgnWwgFPSPWKhFWIPtzyWW+JTPiOZpHjLLXn3Spi2QWhw489SzqrvY
         80jkll21ENhAtKlzvmUKpQRGjaz7AlSvv0Vh55wCSXR9Uzs1pgQxhomwRJd6LPC/3Iwq
         laNWzuQKJgeh2kWqUWskT2tJDedby0pIzdE6dem2cLatZjjE6DGJcuoVq5jzhxsZWX9C
         WEyrJkYk1BxjTuSeeV5WENxQvKNNiJR2OAd0KYWRzBEdryYIVJdPiP8qJY73OpRwguTn
         4AMUkeahkGm8dm9DssvF9dvQjRtxonGSw0wbVyXa0r8vZHlNyTdEs5X4zINd0SmDAiY1
         ZRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780857451; x=1781462251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GS41SM5ONg/ebWQwreACsYq8O1fsTfsaNjMp6UVj45c=;
        b=UmXGm2kQzDkUouSumUzooyCWvZrtRV1CpHKhiEMaLtw1OPSGrA17b0b25BAUQODIVA
         PIRN3WQ7wU/yrijkIYlgpNl/CsF3GnsJbzfExemPzROZ7ks2ywO0DYIKz274fa2Fy0Y6
         n9z4G5GPluNlYxrW2PKLVp8JkVhaX/rpa9GsgkqwGOp+z8AEvWrkwwV9evJvkwWVfupA
         BdxCVyDJTYjVJaZRfTzq4xtRqV2ztDlYkZFHoKxiB7Ls8II/Nf7M18vJrEG6vRXQBAMX
         D9IAFhnBIFz1VrFDMRNM8hTSnJbucnFV2bv3C8CNl+fEJ/vYa4SAmHQVb/0sQ8pNKxIY
         sIoA==
X-Gm-Message-State: AOJu0YxxG4jLtc2MGYDb32VWuFegWQQKzbXeKu8RXLETBH6h6e3PSAQs
	4GfYtyTBiBptKlufT9ZTVztiSuw301lnXRfEnuvGHaxAMa7XEqM4Nz0ios4nMoZh
X-Gm-Gg: Acq92OECXKyek9tQsUxNFh1tw5Cg3vYXPQ6k05OeocqWM/LO0zdZQ5gwzdyqKm/BsWP
	vCWd2TWgIQgeoIB2bhyMuYQNmKdo/5QowVCspW/CaXBaRHGi0PvPZEWBmDzPJWrA8C/JwX03Pwo
	quZy511ReW+cEZXFqEh2BAhG/FGqn4G1NlzMQaOsRxQVfe8+k4fkTQunNv653JYHB3bwwLNNQ8l
	mEI/w5wEr7NWXt9OOmoPW2oY6LXWul8QOpGgDZeQJep7wU/Qni2uXnSP/LR7ZWb/RQV2IrNa7+a
	Nc/9/SRpOG1RWoBLbw0JcCKZjn2djafWOFOjbOANrmrKyTBFjZnytZuaTHz1R3BG+YExksaa2fZ
	qHewL2Fhhy/POAATQWKve1Lol+R5O4pSn0pcovphg0D2W3PVDtbrjriDqLv0jSCGUJwHFT+t3+c
	oQlENI8An/Yq/jvEz2co/eUmPD7GDP5tiNi5h38JgR6UVqghsusRBFEaBk3Gcv2OUKYPU=
X-Received: by 2002:ac2:43b3:0:b0:5aa:6301:846b with SMTP id 2adb3069b0e04-5aa87b8c393mr2592129e87.5.1780857450652;
        Sun, 07 Jun 2026 11:37:30 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:efe3:f920:63b7:5b7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fc426sm3240809e87.26.2026.06.07.11.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 11:37:28 -0700 (PDT)
From: Jakub Szczudlo <jakubszczudlo40@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mike.looijmans@topic.nl,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jorge.marques@analog.com,
	antoniu.miclaus@analog.com,
	mazziesaccount@gmail.com,
	jishnu.prakash@oss.qualcomm.com,
	duje@dujemihanovic.xyz,
	wens@kernel.org,
	sakari.ailus@linux.intel.com,
	linusw@kernel.org,
	jszczudlo <jakubszczudlo40@gmail.com>
Subject: [PATCH 2/3] iio: adc: Update Kconfig description for TI_ADS1100
Date: Sun,  7 Jun 2026 20:35:41 +0200
Message-ID: <20260607183542.368184-3-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
References: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: jszczudlo <jakubszczudlo40@gmail.com>

Add mention of ads1110 in Kconfig for TI_ADS1100

Signed-off-by: jszczudlo <jakubszczudlo40@gmail.com>
---
 drivers/iio/adc/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..ad2a276ce0f8 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1747,11 +1747,11 @@ config TI_ADS1018
          called ti-ads1018.
 
 config TI_ADS1100
-	tristate "Texas Instruments ADS1100 and ADS1000 ADC"
+	tristate "Texas Instruments ADS1100, ADS1000 and ADS1110 ADC"
 	depends on I2C
 	help
-	  If you say yes here you get support for Texas Instruments ADS1100 and
-	  ADS1000 ADC chips.
+	  If you say yes here you get support for Texas Instruments ADS1100,
+	  ADS1000 and ADS1110 ADC chips.
 
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1100.
-- 
2.47.3

