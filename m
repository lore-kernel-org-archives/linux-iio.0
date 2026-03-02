Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD6421F14
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470135; cv=none; b=bis70hSMonqBuPdmKTq7h9j4hlPSupUygj0yeO/P73mHGHKjYmKDKJ/7aZfFwpKJ8KZ6T+N2lKidtHFEbBtCepqrq1Ll+kbNObdtCbhhYEc7K0KWAMpzgXwGy89+/ESkkdYObpW+3zPyuVFEajMcq13aWWJ7f/nrE4eav8mn1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470135; c=relaxed/simple;
	bh=gKm440SgNerZmvPNnlS2Mmv9ijDProXMeYZKywgDquo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=grl3E75CeUtisHPQoGCSbVlDhi+WxfZ8L2n6ZDyAudgD+KALGMCoTlNYSubioKFecg7aIKxdIJXbox/BMPP4VY3G4Xhn12z1xT8yaJfoanwmdA66B7g6iafWXLfJcdQ9un/qVLIPQM1soZpnvi99aY5c6xm+g2HKzs+hchxxt4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FObIG3BZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FObIG3BZ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aaf5d53eaaso32557285ad.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 08:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772470132; x=1773074932; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3YUL2/3JN30HqoOnta2IrWd9LKn7ZLVCcdhgSHz+4ck=;
        b=FObIG3BZ/Z51HjZZuVS8gmRuJk6I7Y9kHACXWiM7MkP1A/x9kcBsB7eWT442SMmA+p
         RPOWEyUqtyKaHkid193WnpnV5NvGChfekGxZiIoa0MaOM164Q0S6yWhn/jJ8Il7cZ1oe
         B0dSVPQ8H2Zlg5LbORW6Fl1SYY/pxDDknibY0ZXOtDDLaUbl+dHMuAzWVqWICO/mviuu
         I3d3PBu9JIbTFcdPuNGUUfjjuXg+HGzdsO0VeJZ9wWcBw8LaaFVWN1hmBUVWg8zy1owl
         TGq8dJfjWUgQxdFet63iRiU3L2YcqAzZ/mM56cFW4ITfPHS0Wbgs0kzjoSspcVh7K+XD
         yYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772470132; x=1773074932;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YUL2/3JN30HqoOnta2IrWd9LKn7ZLVCcdhgSHz+4ck=;
        b=X60DF6ngbl4RHiLE3E3cmOxnkX2zZYwKbkWPqYyDl96qh2iGPAHTww2kuykJo4BQ7F
         vxPv2R0dBXkrM31CE87bCUWe/3APzJNPkqqrigPtYFvCwPHoGSSVzLYVfG50TNmtQ3iG
         1of+EVNdDyNzZ3XyF6KpQhxU2uFJi6eJUTGw8xhdN818jxjEfpKAJXueS1PznZOBX8cb
         3RviUukPvlHB3e3sM8jx0HM/y4CJiyStt+03mZJ+e70sQRJalehMYEQ9LWlEmJw9Sn74
         wqJEUjq5P/udg7IVCIcr7AuiQFO0vhSw/0enJ1aQv6Gwp9I5PAWvu8qCrT2sh6tzNwbl
         TjFg==
X-Forwarded-Encrypted: i=1; AJvYcCU006JE5z4ZWsNUY+79RfpWgKG29LQQSFhq4EEhJXPWT9VfAycsdp24kjoKBHDItfModdNRHtBKEeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE2RpsGI96d7deEKWrrXW8Rv+f/RdiQouFT9kzsW1ZTFHKf4KS
	5ET6u+w5jaCVEXzTRTdJAb8vCzZ2heMEfWzKyuqRYJS9aJxQXnW05mLz
X-Gm-Gg: ATEYQzwp6RPvL41RLo7p68yOVmpJnBr1rBiGEs2IXK8Py8Dolq1YCYAtyP9ebzQxT9a
	jqL+psvpcD4ZxEx/kONSvUYVROcPEUSEJbTzT/6VhHOFykdPON1jX/uOrM9KzJDVRg/EEVWQtOX
	3j+iGf8qCoXCFd/Fxp3yfOwfT678rYbsJYF4j/4SFZnr5pHjOr3H5EufG8H/qK4BzXEnesXoKXk
	WHGveHAzndky9CxR/pqtlhQEG5LgDPkKEzOiyTS8KKYBGWKUt1xduy8XupeA6gg1BnGXLS54xeO
	cICt0+iII0TsDeeQ5tbhYgGfuibX5bR9qAZQI8mlhco0JCeOJ2TcnvdOzEqolRN6UH9OHOuz8c3
	S5GEbaNbWsGcD78KA3866HMWOWhfvRK5ZrE0Gfs8V02RLrQ2mE9Rtokvklu0gxo/uGJrFpMZ/hb
	dasKSUdmcVIfffpXfC+CJkqW13RQ/HlV/8DmPt
X-Received: by 2002:a17:902:da8f:b0:2ad:6e26:abbb with SMTP id d9443c01a7336-2ae2e4f7481mr131112075ad.54.1772470132356;
        Mon, 02 Mar 2026 08:48:52 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:4c92:fc5c:54e5:712e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1ca9sm12989131b3a.36.2026.03.02.08.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:48:52 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 03 Mar 2026 00:48:45 +0800
Subject: [PATCH] iio: adc: ti-ads1119: Reinit completion before
 wait_for_completion_timeout()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-ti-ads1119-1-v1-1-e3fced089a44@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGy/pWkC/x3MQQqAIBBA0avErBtwFMy6SrQQnWo2FhoRSHdPW
 r7F/xUKZ+ECU1ch8y1FjtRAfQdh92ljlNgMWmmrjDJ4CfpYiGhEwhCsYxMUDc5AS87Mqzz/bl7
 e9wM3yd7kXgAAAA==
X-Change-ID: 20260303-ti-ads1119-1-cc68e3c01783
To: Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772470127; l=970;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=gKm440SgNerZmvPNnlS2Mmv9ijDProXMeYZKywgDquo=;
 b=RO3fr3iCgEBzczA6xeNsvCu+F8sCK1JUI94fpU1MqdtdZlr92P/7gZduQkmf57Xyu5kYQyaSR
 Pt2sJQ6tIycD2EOEe4WcyvvzpUTYZo+ybJowR0we2NyI1ag0VYuLaX2
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The completion is not reinit before wait_for_completion_timeout(),
so wait_for_completion_timeout() will return immediately after
the first successful completion.

Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/iio/adc/ti-ads1119.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index c9cedc59cdcd..75dbb469fa27 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -276,6 +276,9 @@ static int ads1119_single_conversion(struct ads1119_state *st,
 	if (ret)
 		goto pdown;
 
+	if (st->client->irq)
+		reinit_completion(&st->completion);
+
 	ret = ads1119_configure_channel(st, mux, gain, datarate);
 	if (ret)
 		goto pdown;

---
base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
change-id: 20260303-ti-ads1119-1-cc68e3c01783

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

