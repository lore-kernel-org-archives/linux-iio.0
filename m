Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F0F3C73F7
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698024; cv=none; b=C90Zutk9qBZzgfbHV0E099b+ydZckYDpOLVFFPHxBM/rQ72hM39Yo+TTCjy10vQXLnazXHieo2PmdXcrQtkm7siSPjNWasJeDQ8Nf1/s+d/k60gUWkEB+9Se2JfAzkxSR81AWBSAtJFuS3eS74fFk89maFy3+wyIcHYvdQYwV6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698024; c=relaxed/simple;
	bh=1otP8UYV9viBZZ+f8NwjITACufQDeLB/kdjE9I9R9IM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CUi+sMv9pFeDhHQza27natQ6Qzjmdf/5H1JygLXAPT6ziIdow/HSrzEuLyEj37j0hrk4wnij7OMXt73ea+rC85TrfBF6gKRpTgvI5jogasKYu81m0IS50gc1L4rVawXRwFyz1tGCFZW5BWSqE2IrwVOMrOtuCn9dCQax6qVo9mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmZgAq0h; arc=none smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmZgAq0h"
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4c3bb46aaf0so125467b6e.1
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 19:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789698015; x=1790302815; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=54xUl28tB3oyyAr/XFRTTgMHGsQTvwV3/5B41pgtCxk=;
        b=hmZgAq0hFCl4Fd5zm2GTghfOilvCvZLL6bR2TV5c2JXjjNHkbUgoPSULN17tzwf5dn
         7TuoJ7pmq4pnxGrlYx30/rXjRy086CypdtLnbqEYfp+bbWwqWrM1oTDCXOLeMftUOBDX
         bEKwHtHhkFgP1ohfu4FSHk88cM29yZBELBFMwtrXu2sATt+BdksQpiSLzcOQuSWJsupT
         V3aAl+nncjOXbNWVHX4tQ2GtG7tB1IyNZH4Nh7x+0JI9usZdaR/LKJSMtH7uu5opuk46
         7bN1yvzNCbr063i1RX4SEmfSyEUF7tQFeBAx+GQcjFRTalshZD62slsvILKk7T1lFaz2
         GsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789698015; x=1790302815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=54xUl28tB3oyyAr/XFRTTgMHGsQTvwV3/5B41pgtCxk=;
        b=NO547Mdnhjn9rB7ttKOsfqfqx18XxoWzA2+16cFM8wcooIB79TPl0ibAb+SZzgKq3c
         EjOBvg/L2wN4flYB/0PWWdCxMfF5aW3o3MvoX1yHB/qL5Mug3joiJ3MZUDaAo7gfFf97
         kEBtBZZhzFu6nUn064K310VRfHgTeMtU0mSFXZJkbueSwALniH9JPQYY0BKgc86Hmb5v
         WccNOKkz7hvayx5+9E+mW9uSsLRmF+OPy1OSno6InoBMUjOCwTU/XzBVPBJwKcjdPqEe
         Da/u0Mhz0mdEk1jpcJigoHwg7vztjw+j0mEwjzPSYfLa5TQznVoqep/RHfhOaNprarX/
         fEAQ==
X-Gm-Message-State: AFuF++n367/J9/eRrqWS2M+J4dFJuDaTIqiNoV/kPFHu44rC4MiP5L9e
	HEkVgU0w/UeDSy50x1GGEZP42hrZKrgdrIDB8YTBIlDRA6c3fq+ILWGU
X-Gm-Gg: AYBFou1rvUkCeSAJUUlfIstSAsae377vuJPepNMbfmsF+bZXqbSuu8CuoPbhu8BieBF
	VN1YpUoLxxAv99qvlWTa6JmRAd+XInbKg2pVso4TeE8IZ4y10+58xmr73UC5zLiDd7HYPUz9cMT
	usSfMez6HBenCg5upuQaWP+8LFMqxNWcziZwwthYfHiyjyjBw6mz5CE66Al+u0YuqVue4yD+1Ii
	waCP4pEPFvmJGN/MMkWatyrvYqlc2WnFdcmwMJgb0VlHXuWaa7ugUpMQvQ0jSWRDdDfycTM+3PH
	lHLjUqY1ytQ0/4uVB6SN2ie2cIGXDVa+KD9rvR+l8A8ECpp4pWaIlkIS3jzt/IaQIIJLJ3TNTj6
	/gzGLIXHcKYBDInEcQaipGnZr7bmpE4ti+4JCO7JCUkp0V3gQleLGdrnpVhCvCNJRKNpdyCmUMJ
	3sb8xyNknPC2L58ZuYVSc7hWtggXTb3H/Xr3BdqXcZZyp7Sirr1GvrzvpvdXx3xbMtGQ==
X-Received: by 2002:a05:6808:bc2:b0:4cb:f21b:6f98 with SMTP id 5614622812f47-4ccf9b8f79bmr1640523b6e.43.1789698015057;
        Thu, 17 Sep 2026 19:20:15 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80e5226786csm295476a34.22.2026.09.17.19.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 19:20:14 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Thu, 17 Sep 2026 21:19:52 -0500
Subject: [PATCH v2 3/3] mfd: mt6397-core: Add mt6397 AUXADC support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-rbrue-suez-upstreaming-mt6397-auxadc-v2-3-db35882a6080@gmail.com>
References: <20260917-rbrue-suez-upstreaming-mt6397-auxadc-v2-0-db35882a6080@gmail.com>
In-Reply-To: <20260917-rbrue-suez-upstreaming-mt6397-auxadc-v2-0-db35882a6080@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, mfd@lists.linux.dev, 
 Roman Vivchar <rva333@protonmail.com>, 
 Luca Leonardo Scorcia <l.scorcia@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789698008; l=822;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=1otP8UYV9viBZZ+f8NwjITACufQDeLB/kdjE9I9R9IM=;
 b=5AvlTzf3l8b4LLef4GkI1AU4KWt0gDt38qriJ2bzdYxbLUme++T/DOctXG9bxd6ylcEF2KKoj
 2xObESmwo23CDAaFIvEw6+yWIBFc38l1dxVsxUSc08ka11Xc1GqGfja
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The mt6397 PMIC includes an AUXADC. Register the AUXADC in the mt6397
devices array to allow the corresponding driver to probe using compatible
string.

Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/mfd/mt6397-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 9ec951996588..5d5f816492aa 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -261,6 +261,9 @@ static const struct mfd_cell mt6359_devs[] = {
 
 static const struct mfd_cell mt6397_devs[] = {
 	{
+		.name = "mt6397-auxadc",
+		.of_compatible = "mediatek,mt6397-auxadc",
+	}, {
 		.name = "mt6397-rtc",
 		.num_resources = ARRAY_SIZE(mt6397_rtc_resources),
 		.resources = mt6397_rtc_resources,

-- 
2.55.0

