Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAAE332614
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782416308; cv=none; b=JbT8YGo6RvJfcb9iF72JHW8nOI1gYfqZoHB/6yzj09Z/kwO8+P7B93U9KHqqav2qFcQLcK8ZMTVBMbEM3fGhtGjfhZPiw3+bdoExZdLoLt8VAzoipOkYhffmr4daY7KgZAkbSY0DhEPkTV+sWl4Rg3+971d9OClTvDwq8rxCZvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782416308; c=relaxed/simple;
	bh=5Gu4W3zrjgoKQUZ3pJHy+bbfKXzVWB8CfB1etnmT698=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eltQDNnJavs672Xu5kc0OrY45fZLBVoRcOXoKW5J2mdbU2IdZdDkGchkxtzkXdESLcYdPaD3Q9zZGufFzObKL2gWUCKiiw8b3ssYSIa/ljfe0UIf9rugDS6SYqonzaE4KjRATMW/Y1peLOKTnxds2bJyI4hOXeOw4MKJeOtSlJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2IQgiGv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2IQgiGv"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b9318997so1711975e9.2
        for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 12:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782416306; x=1783021106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfnIHa0NSYLbSacnMlyO53wtjVphfvS4tcH4fkmTPFs=;
        b=D2IQgiGvqY2Kte1PaDZoRVuq5ESa7CCR/9yP40T0B+YuU9dseFt+cxpjiz+s/V7RDa
         XNlovIU+ZIYpnDi/0Geuh8uTF0Smh2a34hzao78aikjbV7FTalFVqVWjIrhOsBFncmkU
         5qz7t1YxERwdyKirKY/4bEVLOVh5/bwzuMYkVDsABHUgG0jy16NFV/JiQVg3E0CsMZVD
         PAU9RTN++bUcsZlaXXaHg4X4KgPUpkn+3wU3Y0TYh2RaJ0N0bPt9xlkPPnLchsa0pmTp
         8NiSKRDYS7Kbq6WH8Cn2mzFf2d5z6PQuACdyiG1TVRbcvwOaXo7Yeh6mli3uE4/FpWTs
         Psmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782416306; x=1783021106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RfnIHa0NSYLbSacnMlyO53wtjVphfvS4tcH4fkmTPFs=;
        b=ADPqtH7geTJTQZo+qMNLYtaNkJF+YNE+jaiU1s3kYx2tbEth1x4GqAazBfNYi62d/J
         fQyTW7fDeHL5Y8sk3ZwOJ5fGd0fFUw172PFUN1Oa+xLDotY8o+Bf2aBhj/d9DympJw/J
         nA/Ur8S9G+lMCJWy7DXUfuiwGOFlPvYkgj9i4o6q6oySwe6Y4BkroibYO1JUj2lbdfy5
         T82PsbW/HlGcJxQzAM6huECTYCHffc9QtoCM81Irg8giGcGk9KtAD+Rvfuh+0EQc1dCh
         5oqEm440ZDodvh/zZ67cIidEHYIlDd8xD/gawdLSf43pD5iI+Eezax7VnQGMuVXD4UDT
         2THw==
X-Gm-Message-State: AOJu0Yya/+byoPlsBqi0cB4dZ7XORkKhsr5Mc4b3ZhaoC2T/hi1HqSaJ
	HSa3hygoV90kqCSsQgRlUmMZqXmcohHEsuxw1c3ZTZggqyUP5eKMhnAE
X-Gm-Gg: AfdE7ckO3Ze+ctITmyQtgTFKg+D8h+wVsaOusR3BSE350dXjG9LvZ+lEHmYNR1l7ara
	gLZe5Z4W426YOuKO/UMlbIhPQvgr5IvAg3fVmN//QwgwUEgR/2Ter+QntstkdyQ0MxbBnFopPSL
	mwV6o1+13GxQPdnp/+K0+4axSLRMjiANYblDqfRnMXnEBR8MzZnskND3qZ+ArzkyAOlYbQkZMEg
	dKaWma9Yh+aim3pPnWclx45FSbOghoZqN+ArLgErEHcMXYcumJFbISlTMlroBgHYClsKlF7vYRf
	Dgy5rnjN4O4/yMk4QufCdWT1eaAuJkbdXyiQ6stSJjqxwdXwaGdMXIqvdpQ6Uhk6IEX9xe9abn0
	yPpk/ueU5fwwxDP2DNntfujg3Py0fshdO+aynd5oSc6j/Q92IAHnZVrIHcoQ4myIf9YLCUGjf8n
	mkHXsm6znQHZquNE4xuukT2U5Rp5Kl1tnlAE4cnOdg7ZGA3+Kz+rYivVEjbRQ6V0K0vVcPH+IfB
	8Iyo36zfeslbVXg1OcdDI9e+yrsokoB/igaWh2pe/mC/Spa8RzhTVLHnjP4fwEFJYLOXZVytdik
	bZaxClwPpQ==
X-Received: by 2002:a05:600c:6b70:b0:490:b06a:649e with SMTP id 5b1f17b1804b1-49266893253mr37928005e9.25.1782416306069;
        Thu, 25 Jun 2026 12:38:26 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690168d5sm28898945e9.14.2026.06.25.12.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 12:38:25 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 25 Jun 2026 21:38:09 +0200
Subject: [PATCH v2 2/3] iio: light: al3010: add missing REGMAP_I2C to
 Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-fix-al3xxx-kconfig-v2-2-796cf8d7cc49@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782416304; l=700;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=5Gu4W3zrjgoKQUZ3pJHy+bbfKXzVWB8CfB1etnmT698=;
 b=BU/D3SG5zfpHkhoo5W5CCN3xi07MW+NY1X/UrlTDvELmYGo0JGhj9GPRnVnEZxq6ntsSPRH9N
 cGvQafJrzaGAwg9LSzW609Ztn84PnQRz/kkDxud61L5Ign9IWqy08uh
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The KConfig entry for the AL3010 is missing a `select REGMAP_I2C`,
causing build failures.

Fixes: 0e5e21e23dd6 ("iio: light: al3010: Implement regmap support")
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index a33920568904..4ba3151ebea7 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -56,6 +56,7 @@ config AL3000A
 
 config AL3010
 	tristate "AL3010 ambient light sensor"
+	select REGMAP_I2C
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Dyna Image AL3010

-- 
2.54.0

