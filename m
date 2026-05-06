Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8844BCAD6
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091319; cv=none; b=H4sZAA9k+vCAtyWz7dccXQqtBMxLfWD23bYu65KQ0OOvLUWcEbJPE9yFcqAcjhR/1dJrUcUqV57JiWAcTUcmisIaGvTqkBMmflJN47BYTBS40VlrBbByxaDbMrF9d3nZZ8KOYIOJTzYTC+aRj0DSTS70srctRBmXdNDl1Wut57E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091319; c=relaxed/simple;
	bh=H08BrTRalR0jUvy/90S50ZaX5dzgHvM0nJcBr5ocsmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzJ2daGcoQNBXcgk4yAaI7WJy76VrBf10m86QjQOATFbVDx8cNqfSh4sy4dOiw9GyDX98Ki2EW9ZKdoNt3F+gCOzOLWFznk/65f17Br7aVYKVQIL8Rx+CRcVaKVamEhJXN6j88pZGjIYqfXGP/z9v80OVJL2RcgHdW+wTsqviYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I98m1bsn; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I98m1bsn"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso6892598e87.1
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 11:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778091316; x=1778696116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnRfUwgP4GDJT73gEU34kWTDXjMinDYaY8kcXfNdp88=;
        b=I98m1bsnN0jPkv+hXiOKZjFQA0kPFIVmmNGbQYRE4alFU7AirdbrpkMiRspfNugF/0
         syFF8Yw7Jl3YAm2SsiwrKDFxj329V5/GEZ6TPocGyCxUmWAPHoQkUfPUYuiqURxWOldh
         yE412fvgho1eXgXTdJGEol5dmwSiXXbOthBTDr8FZxdowx2iWYxmDEL+WEM0A856PIHc
         tIBpYw0i0EA54hLoNRJ8NxAFrybJCKgOoyLGAxHlhHPf4kad1ZWZO4BSguQEMRn3VPZx
         WC87Aq1XK/MVMoFPGre/RcVajJNPJBeamoxxfLjUKkjgk3mMI8xLPBD8taIdaFClOuWK
         TLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091316; x=1778696116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qnRfUwgP4GDJT73gEU34kWTDXjMinDYaY8kcXfNdp88=;
        b=DaQmCcpYV/EhYYTRCjwPKoBaXfkGJZpQsLa3KGlvHKeXn1wDGsP7zd/Gq6ZNEQVd6s
         kie932BgnDtoJn7hVmndSaSV6ALcJUou33uxpsKBewoLE5EXhgNn+AYxuO8QKDmWs0SP
         ZFE6FPA0K6NCsxyqlLfEKGh4rx1g2P6JK4dwc0Z0eN38Y6yH/6ZX1nEvDsckFi5RDNrn
         Hosi4Gg9pOOsRvlDP2N2BORnxH/Y9pwMplFe2j9EI1NZ+k1gtdcTu55YoLp9OKO7FYXY
         ouRfm4CVvUrxsJ6wTDNp3t7Yyg0YF6cGauW9+6z0jhoh5aVmnvOVnmtvDexqk/MkD26L
         CVDg==
X-Gm-Message-State: AOJu0YwbhRhPxqLL9ow+Z2htNv1qJNl1WBon8VmSqyVfEOY5WZAZLE96
	9JM/oApAl2yawHsiof860ZMQ59Cdm8fJxq+w+1r5B9nHkz7Kes3hf/8EPhXcuc/w
X-Gm-Gg: AeBDietWOaaWHVH4PdAB5wEy1NTxnIdIfhp7dyaweZ9fvC2z5MEFy2WjRAuZbxfVe/c
	UEHGrgnm/zoj2VEkA2sgAWDHsaTwJNTkrsE02I2Xzw5W6AE9p+bac5iPu79C/6KY95KrWVEiT0H
	/hnoOQbdTQwlcZnOCffNDGGnLLLiVc3z1GwqFd/5H8w07nBrAKojeJdiHLJFfwj62YatABJiZPA
	zVq2SFAB0ZmFpqhs4EdDw+2jzw/Lzu0N0EQGLyMqZ2vjCJmtVGGf94Q+NWBM2/ztncrpoDy5/xk
	hEx4kn7DxZNTnZ0n3MeT6WMdpEUlXD+jRA7bAElvfpe/3L0NFD10p9oplG2T4VD1bDncMc21ruk
	k2hTUYYLramruqiYd3k7FAjRtTwn2a07zJTt5nUof/33qqExmgpn1tNYX35d7Mgfc58nnqqIFg7
	jJIlPOoNzKL3AeblrmmvjT4dAQvFWZ20b4USK5V2IPoqYlFGODYIkEVXYYwArg8UIzeTCFHX3Y0
	0c=
X-Received: by 2002:a05:6512:1150:b0:5a8:9672:e297 with SMTP id 2adb3069b0e04-5a89672e381mr124583e87.26.1778091315947;
        Wed, 06 May 2026 11:15:15 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c341848sm5037123e87.65.2026.05.06.11.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:15:14 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	mike.looijmans@topic.nl
Subject: [PATCH 1/3] iio: adc: ti-ads1298: Add parentheses around macro parameter
Date: Wed,  6 May 2026 21:15:04 +0300
Message-ID: <20260506181508.6813-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260506181508.6813-1-shofiqtest@gmail.com>
References: <20260506181508.6813-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ADS1298_REG_CHnSET() is missing parentheses around the parameter 'n'.
Add them to follow kernel macro coding style and prevent potential
operator precedence issues if the argument is an expression.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/adc/ti-ads1298.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index ae30b47e45..cf5f954206 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -66,7 +66,7 @@
 #define ADS1298_MASK_CONFIG3_VREF_4V		BIT(5)
 
 #define ADS1298_REG_LOFF	0x04
-#define ADS1298_REG_CHnSET(n)	(0x05 + n)
+#define ADS1298_REG_CHnSET(n)	(0x05 + (n))
 #define ADS1298_MASK_CH_PD		BIT(7)
 #define ADS1298_MASK_CH_PGA		GENMASK(6, 4)
 #define ADS1298_MASK_CH_MUX		GENMASK(2, 0)
-- 
2.54.0.windows.1

