Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86923BCD32
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 05:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488863; cv=none; b=KKgZ0M8S/ll2iRIQdds+YqiTwn4HlbOQl7UAONoMTUW5qPsIBgPqq+iOE6dhEuZhOnGB2sZaLC5YlNsyABL/vC3FOdPBgTCREqaTacmttPe6d3i5gM38pFzB/Qo511rrJaPL83HvdHcRZTrGvQhD6AZjUT+diXZDJfivpdxI+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488863; c=relaxed/simple;
	bh=YHDLftGTXkviSiCuA++kFBxR6Qc7YkPsAi1+MB3+5Kg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m37mdTfvSfSg0SCh5QfiVBVpUs+xMSM5RkoKDGUT09+aY89dF88/IHoIMI7ogSLGn0rwRjPtiGemLfcp7yLLzdjo+rWMP1IZJzZbJT0G9FyWQXtPk6kTh706mhUf1AK+exQysevg9R1zL8DjGMsM2CvSnhavQRlaKX0CPPhez2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHPlu4xJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHPlu4xJ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493c7902f47so1259045e9.1
        for <linux-iio@vger.kernel.org>; Tue, 07 Jul 2026 22:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783488860; x=1784093660; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hP4GuqRT5FtMAFHBUjU6kmy4KMyxCZiL8K3lKmV8f6g=;
        b=hHPlu4xJmZn/PeJoRHc//CvBkbul392JKMmJVzP/SdOEeUm1pulBYxMQhFnZ2YDDxq
         TmdEzINeB71gYIPi/HaLDLoFwt+o2xGNI3Wvj3gL7TWb2YZmN8mFy5BCDODiQvfb1wZV
         XYEMe+YygIWarhR/3y6+QUHp1TKwZBrHNjTZX0699jzDyfUqsmk/+uZ4Fb+gJpDii0cb
         EHo3WlE36JRYKgY+e4CU/rih1vkVJdzFffDz1dFxWHedubKq5n+EtkIRhHuYH6P0cqGa
         dZ+DOqX6Fnr+v1UtSBv3rHBRUnqOgFv9HAa6iksPKIkKLANq7wxxsXpMV7SdHmq4xRnd
         EkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783488860; x=1784093660;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP4GuqRT5FtMAFHBUjU6kmy4KMyxCZiL8K3lKmV8f6g=;
        b=sFDFo1imx8aDrRkA2ofGpHouhOocUESE0lVSkRovyyjuYbLau6IUSS9zK4OavxtOL8
         cJMSOV7S2DhOQFCG1b8FAHc7UBd3XVQWDbhUmltWTu+jX6VXIAXaGQT62WgQ/VAE2zZw
         aVuCLn4AdsoeqU4FwGEZOvMgKi58YtEkIkmTDza/N8Z26ktg6Wj8T8ryZp4NkQo1kqpJ
         VGSuoqdMTNyMmfCR5mXwVaP+vqMD10by+N7H9Y1UxIpNbOGT3YIs/xSrs9YfmwqseGm7
         TJ8GoA3QyHqxb1Q3vucCCfiEKL1arLnmVCRQbf6Di+bAxAOhsJgBAWZBhgRreLD5YJ6i
         OLHA==
X-Gm-Message-State: AOJu0YzdIO0/5cp3f+VSULf0vUJnzxAyrfCwgdpqizG1EBEYG8KN6Zlu
	FVg9u6eo8KfKM86iewUKKT5Jl7a5EJ9p/44VgzVYY/n5nDMbk9O3U/TJwQ8zlvZ/cTY=
X-Gm-Gg: AfdE7clpCXyzkgY4k/dJehh3KhnLOBldR81B1W0qnCXbBUZty+Xt7Dw1TNHTEH/ougx
	d7WO8dgSN6rtVyjjZpuQW2B1q66YoSYklbvFuOzhj3YYXaWuvyA2ireOkEaKaXKKXUgpwJ4dTLE
	3u0lggug+zb3KPrpkh4FTiLCQ2/NAG/XT2xqxMwRSNkqXzKjcf4FuSJgNu4nNAxms8ykwXDM0DD
	e9aeSzhf51bQqtPd7kKUY9hvBLBdWhqz7SATvmECwolcw9xGKypB9SGOEsWx9d3VN8/Rav8Nu9V
	pBGy8PhWDQqK+N8ezQghVnSv3JpXodgzCJMMhxuVaklpGZ52br7+dPiRcmEVnBZc2o43zzU+ZSG
	Zx4/l5taPqgxFj6YR9PhlRUJhqXkVxriQiAIP444mhQ9w/mXUTKKCFArjpN59UhMKw7jh3hNJiA
	MUO2uE3SYwFHysOQVxqhKqbTr+guWEBB0V4ROseErWj8bNev/DrFuPzwabM0sbIKOn8Q/RR5AGV
	I5eCS6LUSYiYZQyE6g63pGFRUYFrRDfQyyc5GuHtzoY0g+nSvtUcAVpVXagDUTQVKLjbj7+/3nD
	kT7KtHuoOtApafMXEpHKzKRIUoMJtQmmYZk3dJOog2VVd5ekXzbbpw==
X-Received: by 2002:a05:600c:8b34:b0:493:b03c:5650 with SMTP id 5b1f17b1804b1-493e685f1dbmr7597595e9.19.1783488859746;
        Tue, 07 Jul 2026 22:34:19 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e544837dsm35528415e9.0.2026.07.07.22.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:34:19 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 0/3] iio: adc: add missing 'select REGMAP' to Kconfig
Date: Wed, 08 Jul 2026 07:34:11 +0200
Message-Id: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBuwIMOuEi1MR5uFFg5EIN09a
 fkW/1cQKkwCS1eh0M3CZ24Y+g7cYXMkZN8Moxq1mtWM1ntMLMI5YqGY7IW7doMxdnJBB2jhVSj
 w80/X7X0/iHqVj2QAAAA=
X-Change-ID: 20260707-add-missing-regmap-b6c199a5cf6f
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783488858; l=882;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=YHDLftGTXkviSiCuA++kFBxR6Qc7YkPsAi1+MB3+5Kg=;
 b=RGlh604wq8PDBvBXVLlP7OCpvztabJpNoNEs1/AR+UrZOVteZ2j5DyI1tw5nznqdMKV6XTi1X
 zLp4zZNBqtdD0pAqtW47dOnjBO8uSl4kVY9oy7nWTlX4lR7w+FvW19w
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

This series adds missing `select REGMAP` and `select REGMAP_I2C` to the
AD7380/MAX34408/MAX14001 Kconfig entries. Without these, some builds
may result in a failure.

Steps to reproduce build failure:
1. Run `make allnoconfig`.
2. Run `make menuconfig` and select I2C/SPI, IIO and any of said drivers.
3. Run `make .` and make will end with regmap-related errors.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Joshua Crofts (3):
      iio: adc: ad7380: add missing 'select REGMAP' to Kconfig
      iio: adc: max34408: add missing 'select REGMAP_I2C' to Kconfig
      iio: adc: max14001: add missing 'select REGMAP' to Kconfig

 drivers/iio/adc/Kconfig | 3 +++
 1 file changed, 3 insertions(+)
---
base-commit: 093239070573637ad2b4cb56abc9c4c7ee109294
change-id: 20260707-add-missing-regmap-b6c199a5cf6f

Best regards,
-- 
Kind regards

CJD

