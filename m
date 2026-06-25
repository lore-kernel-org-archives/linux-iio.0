Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B85A3271EA
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782416308; cv=none; b=DO8HJU8/O4rnjR9iVx3yCJwcoczglQtE2py2CYjx4jPvcvm7k/sxLj3Hu6xQ/AnExkPHvbJuadfybBtBGZz2fKgUSVdN7QH544iln//9S2qO6DDLm02rMKLlB2+ZW7GCfBRX6tPMmUCJ46xOlBXM6F/B8Oc7855oucElNoHyGfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782416308; c=relaxed/simple;
	bh=fmCNaOwS//nANUitaKoJGfH5+DKcGrJDIi0C7C6O6t8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YdFarQRk16sF+mdLXKrKBLUsgIEF8jMw51Y6yYiTTtPXXKfKsGqPX3N3FT2SposvNNJHqN0RXaFF7CklAyqu7rZ/SxfxcgxuGyu2KLNJXtG++GGCF7OPN4qYwn3A1CuJ7x52DIyzy5jhFhS0QjnPYNfbWYfWe9bxJcVCJbFZ8Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHWCWsyf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHWCWsyf"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-492329c5514so686525e9.1
        for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782416305; x=1783021105; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbzw89aYRuONK1zkaaAl7AejLkHUYL03CzgmTvQUOA0=;
        b=OHWCWsyf6MKkuYxwjAd+7azyUDA6aIYn1OfoGRqWF5e6kNhBmgIsk3Y9vSUEPlFCAX
         rF0dUcKUk4Q6NojPdlDHESHnf8EKpneppSAFXOx2C5Gzs0Kg27YW3h5vLpFgSLLVEvkA
         RqVVfa9ex4vXO21ntTeBVWrlpzMsA8WaKAlE5tVSpwu3VW+Z8H7qfehvWM0iMZW9GdZx
         b7HmBDgIb/Jn1PI3082neVPOfFwR1O2oUcrng1LjOKYXPYryrc+X/Oee9+66CzlIM9m0
         WI6NQZvksPu9EvmapclcvPlUaByAQnDiC2MR2MOjYExKCyJUh/TIdB2ZIlWmWMvcPVYn
         h/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782416305; x=1783021105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xbzw89aYRuONK1zkaaAl7AejLkHUYL03CzgmTvQUOA0=;
        b=ipE5JzNSbwGjKPyWm9zX8uXOXGchLG2/h6A3O1T/7a05qmVffEUobkAhUcv1Cv7e09
         PyoKwwiPzZHGBWlIWK1dfX5GLh4Xblq4lbkLssbHChLub/b8rfrPcFD5j18wpoSvqSTK
         hcy+XF/ZSIWY5UxQHSAYAgp0YxAsPsfOYkdDrJ6hC66xRu6eNEsdlwjE42/H8AEXCG46
         6jkpnbXrP/yRFzrpdTeotwuxeGLrcY8psxAu+hNug3vak72jwugEie8SjSkgXXAPqIry
         tYXQakGsI6iqbr4SByj6XJ/gHXI2a139MV386cci8ANuBk7OFSO4ZAh/5mP2k239yBl8
         9eSw==
X-Gm-Message-State: AOJu0Yyu+gQNCdA2dde/Mz+mKuyUARMt9coOd6Zvxzpx1DKXJBUYwbvC
	XdoR5zAVba6+1+JOvVdisLCVUQzyWOTSoZMvzI8NlNWB8/wVY7eEfFcl
X-Gm-Gg: AfdE7clNXCNCVBn4NE4KfuPYRht2rewsjxiSA6/+jRfHBxosWGBWv4HeHHdBVUIcjeY
	sf7wq06BO/45h/USl2Gg0MsclwoSrWERfYndgrOfwoFBz7IYORHLiiDxPxnn3hYwLKpqxWORkzX
	0JKrTLPiToXIPk7sT9RGjTj/mYiKPtifs0YrNz7ekcF424wy503jDf+EKWHSvS+1Xf0Cywu1tBr
	RT9OrQdm3E3Z8HVnwpyx3IKw9JzS4DLIhJxaGATIUU5u90l+xTPphlWHZuRVaCPpBSqrfUpBZmU
	ED9O+RJpa7N0vJ7tuNK1/0AbiAPN7lG2pCQVkaT3NaLxVxQiByV6zgFReE7o1bEfQxMyhIU/iyx
	cM/UxWZMzKRhFXEXJgNr23pW0QJEY8Hyjo9m20RqNxkOXajxq7pD2KwS9n9BVAuNqrIGy6RTYbH
	Mfnvntu/xaJ5x0F6wdiGzI9gN9LBj8faXz8x7/qV/8q6REaE+NNer4y/daTsl1b6pKPfBDCVkx3
	GBSYo0bfxQJ7dThus3Wr61PGFttddEGrjf7JfW3C7QTT5e6aGaTbeotaaw8fMQql23Wnq3Y6l76
	RzLP9uoS9Q==
X-Received: by 2002:a05:600c:4e0e:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-49266424176mr57772475e9.16.1782416305369;
        Thu, 25 Jun 2026 12:38:25 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690168d5sm28898945e9.14.2026.06.25.12.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 12:38:25 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 25 Jun 2026 21:38:08 +0200
Subject: [PATCH v2 1/3] iio: light: al3000a: add missing REGMAP_I2C to
 Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-fix-al3xxx-kconfig-v2-1-796cf8d7cc49@gmail.com>
References: <20260625-fix-al3xxx-kconfig-v2-0-796cf8d7cc49@gmail.com>
In-Reply-To: <20260625-fix-al3xxx-kconfig-v2-0-796cf8d7cc49@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782416304; l=715;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=fmCNaOwS//nANUitaKoJGfH5+DKcGrJDIi0C7C6O6t8=;
 b=T26101z0i8qezjkK0yUeySXY4Eu5oiBr8pdXbreTOq6blKhDLqO7nEWNvHq64pvWpp2q/L7J7
 tlchPl3ugGhAJfJjm3GDVlYdY9LyQi3oG8AdlKBjbyabHyIpwHl0zb5
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The KConfig entry for the al3000a is missing a `select REGMAP_I2C`,
causing build failures.

Fixes: d531b9f78949 ("iio: light: Add support for AL3000a illuminance sensor")
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index ef36824f312f..a33920568904 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -45,6 +45,7 @@ config ADUX1020
 
 config AL3000A
 	tristate "AL3000a ambient light sensor"
+	select REGMAP_I2C
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Dyna Image AL3000a

-- 
2.54.0

