Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404F2F8EA6
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 05:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364851; cv=none; b=jDD4eQ9iFNdl3XwEEUG/joKceN3vOMPTOvQIEgfqaRiOg0DF4GQV/uZCPXr0kmnUviRU3PKKoZ8ICw0MsiYMVV5ECHVGHehABur4Yv2cT0/m1Q+ESjrHZ8lANbyDIsHpg1BiDTv+oPc6ltxU4S851RWS0zsYq8ccvXXqdDfuyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364851; c=relaxed/simple;
	bh=Jj8ts83JTuXTlp5vQ93hdLFbahKywNOKuJLxpmnwTp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q24PCWu/JdXkFxOn6d8qCTHD65BfPo5WIHS0WhnZLOA5kyDZi0xulUrRbsQSaXdJTO2A5SzPslPppjwn3CGNYIGNpGDn71fZyu/VIjwpGGHgv52v+QJqHH9jEcxs6KKSi8pstHlSedjXP491spxR+zyDXC80Ma5FkQfFiulj2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ip0QOFyT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip0QOFyT"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49241896317so7881495e9.3
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 22:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782364846; x=1782969646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrXAs21n6EaT8qBeZaN6mSvvLhz55cBY8Q75bhViKh8=;
        b=Ip0QOFyTV7R4oUgdrzwC80El7uB6t3ZFYSK/mU8PSuU8EHjq5azNgJWiEwzSUrf5qF
         gUAdCzLvJOU/TRhiLNUO58p11Mk9lWbUSjdhvYKhy22fLoPQ8LAXm5vFyMGT8PqLgdF+
         4RIJUKQv/XcdU3NwMhAgzjIM5ottuIvsSOXB+jcCmd0UmBtJrNX3wkCtHq5W/XZHAKa/
         ukrOTFn4r6GKOzNJfiB8ZFGq0xNSypJm+9KAgkbM6PpnNRUVXMv8cD0qEv1Rwa1sJOiD
         S/vJxp6UheKsONWqSgC9RzAYY+YkQEBDrKhM7IcHNHWYZuf/Wtw5msqtcE4avtYelKGs
         jDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782364846; x=1782969646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OrXAs21n6EaT8qBeZaN6mSvvLhz55cBY8Q75bhViKh8=;
        b=SvpRsvdUgaiyZLHTNEAyaZfrvwwoqbHxXrfGYC86XIn2Ve1N/vuvc+UVwZza9A2tv1
         RSUHq1u2kPP8AgRWpAv8qyAXCfzc3vtVhhnuqzCyMzm7wwpL6KkmyESdk4sw0HDSaGR6
         zz7ZRzuBg8GeSm/Wa3TbzP+jC3iZWHlJm92kMSUR4aSPakNfUOV/6s8lEXNK8MR5D14z
         FWl9iMHfYeQEz9kJJQmy/J8BL1L1Jec7KotCEEE3K6TiRgcdRChgO2+e2R1fqOEv7WxB
         dPSdhjI3isTBkM1d6eCd9rQwNdRRJZGIAw7Rx7uu8CLGEsTmTMf+XbCt1uoyOM7kY5LQ
         JkGw==
X-Gm-Message-State: AOJu0YzS5T4YQtq1aQRSvw0i7HGOsniI6yyylzZ6RO6yldI3P4giZKqM
	rW2kdC2sEOT+AwWjS/qXi2xmNVoTSJ7C9VnyH7oQ2ZOut4ywWWB9iFswfY/IpQ==
X-Gm-Gg: AfdE7clMcCAZXeCPU+AS507yAo2HEDK69gXsBp8PFlypw20yoARUW3KhMycE5d9wUKm
	+//KLqFd1bdcuIK4dWkGYUo/6g7Zmuh9yWnEJUfvjoIdnwVgkEq+XTfIi9YVIJAN06GBmnb7LLZ
	YTSW+AOWAjoH5Fy3wv8DVW3B9mBVe6PCNlDaZKN97vkXNWcW/MGoVbFnBoWj3hGh3wzT6RLtyJw
	NOt4kHBG9Dx1v7GGDptC5Wsiq1s5o1TKU7/Cy/llV5pDN2yJd6lw8mYzYPBxlozKTBKtsB+o/eb
	zhPe/N7O8ZbsepG4GJSTqIq8xYb0WRIaEbvlZLKnJdBjjVPGfHoiFylTEv+zSSmFOPMJqIBrqR8
	qO0gB5tl0i1Z6b9n841vXwxxwTQbvhSDfH1148I1N9mgWxRLrWk2+khrm7JYpckrjFHwYc27KUI
	HP8DUIY1X2SFjsI6gF8mAGWd6FvK2fAkZ5vQ6nRMuToSo/CgltkGaw0+14htthqJAKZF09T1Bt9
	GWNQU/BhRvEVdHi+hh8wyEhq4fJntZuZJmO0bOdSJlxWxYzsUkBVOaoRBgHY2S1+AFtVE4Ujmrq
	SckTkPgiiQ==
X-Received: by 2002:a05:600c:3143:b0:492:4cce:53e2 with SMTP id 5b1f17b1804b1-4926683b1a2mr8439585e9.3.1782364846490;
        Wed, 24 Jun 2026 22:20:46 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660a32ddsm24966165e9.1.2026.06.24.22.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 22:20:46 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 25 Jun 2026 07:20:43 +0200
Subject: [PATCH 1/3] iio: light: al3000a: add missing REGMAP_I2C to Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-fix-al3xxx-kconfig-v1-1-d41cbc0c3cf4@gmail.com>
References: <20260625-fix-al3xxx-kconfig-v1-0-d41cbc0c3cf4@gmail.com>
In-Reply-To: <20260625-fix-al3xxx-kconfig-v1-0-d41cbc0c3cf4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782364844; l=715;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=Jj8ts83JTuXTlp5vQ93hdLFbahKywNOKuJLxpmnwTp8=;
 b=pTWuedd5AsJjiKAf/Opu70f83IPSsqpxeUNsZgglOqzu3WWHb1N6CVD5oKhSOVv+mO9tR9lnx
 Ybak84wdTj/DfcM/henPNq9iKHWmm2JBouP4QXIPgJUeJPpy834Z7p6
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The KConfig entry for the al3000a is missing a `SELECT REGMAP_I2C`,
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

