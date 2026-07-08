Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A63BD237
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 05:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488863; cv=none; b=O62c2NveDTXQmbkJs3kFLD39HUy0azN0B6snuaSLvE54rpb+V7+Pfr4QPmYPLDw8SxH07gbftBO5xVhkHzqKzpbGjw9kWPiyjekZiHl2o2BPAgPDDjrwUm6WxZcxDH9XC5SmestzLJuQSm/HtojNsTsHrxexkYbPzYihEMRdhak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488863; c=relaxed/simple;
	bh=Wvm14ICRY3tGMcTOudxl7SG7ZN7GahnxQ61kGAZZKnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nMF8MSS0nga1kAsDslqmtZmcCzlGQdyTQCE+rzTR6SgRZ2U4r2XNjSDfBOorfzeZpVmoriDvc6pQv6WPyTxjuhcKrU2S8suNrlQvVDyAMJn5c2zDrXNRTd0vEPx4LE5QT4Z3KSxU+PKmyW1OY/IWL1Fk8c09KYukOM+mbSDZtF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHi2C57R; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHi2C57R"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b7612475so1373415e9.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Jul 2026 22:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783488861; x=1784093661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VRg5snqRHpxfliVTmuxHIvtVqYppv3cSAQZZHGthKzM=;
        b=lHi2C57RJm53G+VOvmOTM6a+iceO+Kc4fy1eCggbkhEC9ATenyD/JPo/qzEwE1gtBP
         pDLkqDf3lUOSwR/SHd9dOz1efe8NhnGjwwswRJsV569KEfJKjVXmMQgQQ7RUaWjjuhY+
         oLGGs+MGJ8gCwLtB3UMjzrED2wHrugupAGXe5x7LkpHF4hsPBa4/hT+2B6UIrzHUBBwy
         bNicMxpboJQkJ1zXhxqhewtg+CE4rWr+Pjsd4831dFf8HB4/Os4Hmsy5QPx0dse/jGAj
         qWiYZix0InNJ+TkQ8zJfq9toeR3s9VzqAt2vzOpPIVsVMnR/SJJAO6MWFF+n98o5Ngsy
         KubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783488861; x=1784093661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VRg5snqRHpxfliVTmuxHIvtVqYppv3cSAQZZHGthKzM=;
        b=US9R7cPknnQdoTSTsojUTXm02PVqXXl5AB8tMVeU0Q3QfI9mL8gupwA8XoN+vyh3mh
         s4BNoYh48nGE/rV0xf8l3IJRhbNSjVvZOiSqsXiy+RjWnKrCCG3MrEe2Vjlhr5ZnNJYF
         CzmXK7UdhBMdgfQsJAVgNHXJrTvLSmXdbkyvvgbWmhcTe0b0qEUFjnGMmIsoNiXfnFTR
         IaYFrV87BTIwe18p54dx8ma25zZ4r1QNfT4FrkrQ2h9vSWqMrdtihy5olJvwy3HVsUAj
         V9VWhqYy5OUx6U48T1FzemjUAuXk8UoKTHvDbWuEy4N8Gmkx+APHkaSncerHs/hyyVkk
         dZYQ==
X-Gm-Message-State: AOJu0YzkyBvlYprsfPaVMTLsoj4xbEGyHA+go+AOAI+R3GGgJKFyt2Dw
	L2CoRZvUTWDWwBEoAZGu++z3FOCd4qpThEi7a/kLQqORYW+w0FC2yLPv
X-Gm-Gg: AfdE7cl9ou8bi55440N4ZeTIcdOJZAFmfIfY9BZ1EBA7+GYPBRQg2GCf4jk+BxVYwZ8
	IOdR0YP1rBo6c3qAweTmOSwE0odUGpn5kA3rg2m/wgZGTwNj6+5pCTe4aNMLpzFb9qyMN913cpk
	BNr6gacGjYRurIQtxauivjXHC7+GXEoH015UwHVX7P23mgpJj6hBF5xCKoE3dsr0oo4Mran5qsa
	dgwn8uhZ7sBP6l8WdnLcPO8udtizxaylYm/5AU5WHPyeWAIuBYudab1L9p6XolANaxeRj6l8NXz
	PUPvmW+QVLXF5PLeIAiVjshZ8RyUoGlg/mFn+m2UV4RRxewEiu41Jz0zMFfudsLpsv44ECPoog3
	R2rtSqwpssBqe9DNYmNf2vZ6jpymfyF4Fk6a8BfuyIzK7Ygt+iBXzOFK+wGV5tPDeQc0A6AMlbk
	plUpt1Ngohv53V+bvN4yb/tC8J9fFGZ1tQwAkc9IvfIhXf7ktyWOAvv2ym4BjNwT4+SpS83oBsE
	jSFVm4LYvJnHTFH1CJMklyu5H/V9QRMzxRRAwY1YokhLR39RSz1kCm01kKCisvCoPPV1EZWBaNS
	XyuKRp87tktqVAE5qok+mzY1FTc9GYjOv1+/F3gqo6LNwQDJF2TvPQ==
X-Received: by 2002:a05:600c:8284:b0:493:c8cf:27bd with SMTP id 5b1f17b1804b1-493e68642c1mr7934015e9.19.1783488860542;
        Tue, 07 Jul 2026 22:34:20 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e544837dsm35528415e9.0.2026.07.07.22.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:34:20 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 08 Jul 2026 07:34:12 +0200
Subject: [PATCH 1/3] iio: adc: ad7380: add missing 'select REGMAP' to
 Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-add-missing-regmap-v1-1-6d424322e3d4@gmail.com>
References: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
In-Reply-To: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Stefan Popa <stefan.popa@analog.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Ivan Mikhaylov <fr0st61te@gmail.com>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>, 
 Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783488858; l=732;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=Wvm14ICRY3tGMcTOudxl7SG7ZN7GahnxQ61kGAZZKnQ=;
 b=NTxPOJACqxCNNWhj7RGjox7Xl0AS4tyu1m6x8yUMHnkebuqHTDrot3a/Vcb4HbFcD8NporuHI
 xaNHxFYh5WFDRCYwcyxc/tov87rTwEovaUFsiMj5KOIi8WSnHwQiFYD
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The Kconfig entry for the AD7380 is missing a 'select REGMAP'
parameter, causing build failures.

Fixes: b095217c104b ("iio: adc: ad7380: new driver for AD7380 ADCs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d1b198cb8a80..6d1170bc4c7c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -330,6 +330,7 @@ config AD7380
 	tristate "Analog Devices AD7380 ADC driver"
 	depends on SPI_MASTER
 	select SPI_OFFLOAD
+	select REGMAP
 	select IIO_BUFFER
 	select IIO_BUFFER_DMAENGINE
 	select IIO_TRIGGER

-- 
2.54.0

