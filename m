Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A137B3FD
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166209; cv=none; b=ZnVDq0Opfr4t/X/OCi/6Wo0qT1hKBJzIoBDHUm2HcIN42ejSckpqlxCBMxcx+Y7FbRlZE9X3yFPLZBM3xbZ+mP5kxeJp8qhKImE9q6U1dCpvBO3K04gXkqkaSJFVyXkFXS6Zn0zTwe5PZh2rPWXTiyJYtiUtkirOj2pJWw4DEgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166209; c=relaxed/simple;
	bh=eF6DOhr9R/kbAhqoRAr20LgZj0cKaF3L3xNG6aRyDrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/thdy3Dh6F9/a8I5CosrQOAr5CiwZmTV83edAVuEFc8qDfNqbH9QZDzWfRlwlK+eS1G2jaxVsZPZY0yTg05vrLIsSc9MuL61Zk2UnE42vDwkOXVsOsedWoEti9BtGXHlm1Dtl3EPt57V2Stsl46nXqp8v5jPPoFpYlJNSZLhXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qOA+Mf3Z; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOA+Mf3Z"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so157802866b.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 12:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787166206; x=1787771006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kcdJEbsAXCgqYzikpa/oPevcoLYRNQJiwxMx00ysvSg=;
        b=qOA+Mf3ZnEBeqa4k49vt7kVRz08wNl0lPwba0x22KFTJyzZ1LbN3um7u89Tdb/C77d
         pndxlpToIMZecjhkWPOhwC57alxEMWvzCi29epsmyrTZH9GUluF3qEGVpNmVl+eiD7Il
         RkUoBDsGoeqGmeRjXcxwhY6qYPw5MXC18eYzcCFawBZkmoV7/Tgz8efl/N0Y3N3wyBQB
         DujINyiCIq1y81ypZWjAv5hiPzApdXkwGuVXAxDi6hFDpCp4dThfk32dEhT8ky7wtai5
         Z1Ou9FmIWD/a/bwWjQzxYCBnODB2zcAvIsUqHIm061L+Yx+NQSrPb4N58YDUKJSEK3gA
         A7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787166206; x=1787771006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kcdJEbsAXCgqYzikpa/oPevcoLYRNQJiwxMx00ysvSg=;
        b=KZb48LLyJFkqGrGmkalOBUrBd+9AcTme/wOT5t6JlaUVGtUeUYC36Yxz+i8+ZBngk3
         g8KvgKwmeyDTubQ8GWmIqWUzrYG7XAau4rRJMA25iBrAlCcmN6qyfzadnGMC4od9DVr3
         NqBE1encNyrn9cJ66HaSME9SBEvkA046mmVskjAaOlYNBexxbc/25RPOmE9botqlBQcs
         hX8/0I8L9LeZirT2E1ggx4P1v2ga6YvJquvVloot3SRuw/1qV8Ezb7smIwLE7nJYbtlX
         K5zY5tbVjE+g30pRwuTk0/vwgwQw4HjUZXj1olaMyZdoIsbwm5teft93+gQRVPn2GqNJ
         1luA==
X-Gm-Message-State: AOJu0Yxj9YG3F1E0KTtHrwW3wwwKDf60GkhpSt1ocF1Ec3NhQHDxl5af
	fI3JimfrH1psc93CQElvcphR2A/LOOKckGGuQaXZY5iSFFgcDU4Mog3+
X-Gm-Gg: AR+sD13Ee2FfQ1IFFJGyuAZIITQqpkQwc5xUbd701jFKBBFLQi0MAwJKkhc1+/MEGeS
	wpcL8SPb/E1+kn30kFw+nI7qXTl0JqNdTjRWfVZkdTL7VXqWrFvl43y86IdQdtkfFD/YvTu7DtB
	uozAdGmWVP/ynIj4XOUinGoP5jDrTJSFfRzuRczKC/7NWFBGNtqvM+TcFQnSKfy5BY+iDiAkMoi
	NvXxZXjXdAtkRRVuJXyO1HkczpSi84LAHe1kPS+r6nLwsCyz77mKnwzs2Lzq2tLxInePHL71Vxl
	T1t2ybn+DMPjqYk4d82Buk1gwpx/KGI5yzz8U+VwNrPX+vJRd0vOpZ32KZ3CYacQuSb1loAAjgy
	IXkjTBElNbQyE0ZwyoIqTK/d1iRCvkRE9fSTWfv0VwAOAv0d9h7uhiunA0qrHIkg7vaAOoHyb+W
	APZtogH24Hr6fqkOmYtewLfn91p2fh/xZuVI6FRui13UyyFQ5t2z8MGjcS49W12OqCFItPUSngi
	Q==
X-Received: by 2002:a17:906:9fc1:b0:c1f:e9d9:64d4 with SMTP id a640c23a62f3a-c23f93055e1mr448979566b.11.1787166205673;
        Wed, 19 Aug 2026 12:03:25 -0700 (PDT)
Received: from localhost.localdomain ([165.51.35.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c27742asm118087366b.52.2026.08.19.12.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 12:03:23 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: proximity: srf04: fix error handling in srf04_probe()
Date: Wed, 19 Aug 2026 20:03:17 +0100
Message-ID: <20260819190317.8745-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If pm_runtime_set_active() fails during srf04_probe(),
iio_device_unregister() is called to cleanup, but the driver continues to
execute pm_runtime_enable() and pm_runtime_idle() instead of aborting
probe.

Fix this by returning 'ret' immediately inside the error path if
pm_runtime_set_active() fails, preventing invalid runtime PM operations on
an unregistered device.

Fixes: 2251157b335b ("iio: srf04: add power management feature")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/proximity/srf04.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 7be50bdebfcb..e03f3f0dee04 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -330,6 +330,7 @@ static int srf04_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(data->dev, "pm_runtime_set_active: %d\n", ret);
 			iio_device_unregister(indio_dev);
+			return ret;
 		}
 
 		pm_runtime_enable(data->dev);
-- 
2.43.0

