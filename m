Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5112A361DBF
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214509; cv=none; b=Nzfw39q3l4MUWSuOHC6bn/O7PT+zwKgEqzoB7fsRpJu8MrxaeWOGhz30lMURsS0GGaX+IHz+5P09FCfO7ICrqPaash4uO9PiLSdmu/V7UgYcdjJyB/XPHm1Ntf5krMVwLblB8KmRNP1Gf+z5QIx+KX/CZDd1+6k5FdNF4JoWRj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214509; c=relaxed/simple;
	bh=fYBB6kRmAGnbgbA2q/i2t8FDHy8spPFfyQB8yM9qEnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V3W57rdJoJAscyxbUTyXCbaIte+vhzGaMKvfp5ujNNaHj9gmjisSaiywM/h0AiAaJHfm2ygkZZrTkJxY4ZdqEpjT8nKws0OLtbTHkEkwtIQRHbEGLDi3haRgLjGQZjQeHrk3XH5Kddi/TM74Ys0p904vgwW4wN/8GkY1pZJRFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCkYs0wd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCkYs0wd"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-827307b12dfso1320278b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 09:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772214506; x=1772819306; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P4WAxFBvj2ysX6PUHYN7YZk0O6Gg1g5MJN3wh2hsv1o=;
        b=GCkYs0wdcNj/ORVx3YcLuSfgoUOHyyrOhC0SGVFvHb6PYrS6Dwmsijpc09B2Lhjdba
         LAzy/NKI7gd1cW1GLQ3wVyN0BBbdZmCq+fwIfzU0G/c7zJPORMeiRQXVoi1//XldqrnP
         8XwaO0uiY6ygkJ179d99PttrEzk5TVSqcDtEKmPv9XX3zKGzG8KAeprsSvzEavTPnsSt
         IDMyP5Y0OKXxfT11yLBMVeMhaCRKv9W4Qmw9N9YQ9E00MEEG457Vwsjy/VHg93j+VpK4
         lktNyqdphnYX2e7Iupk8BNJy+HVgpKioJbWrRnM9CZAJdshrMF31jfmpXgVhYHwbhNOW
         XyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772214506; x=1772819306;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4WAxFBvj2ysX6PUHYN7YZk0O6Gg1g5MJN3wh2hsv1o=;
        b=vkt44YnX3GSfZ8fbsC2rwx9rUlNrJhni88RzvSJWM1HxQSbEPyVrtwvCZRAb+dug3e
         gY4OwuMpM5xHlFVdwcqKqu/xIMh14SlFTY+8nCNFkEHunGk6dweluCwj7i71T9NcMIbE
         DWAj9M17y4eB2O5vKPpqZmmMfTCtaU7aFL2Qtd/CTz3tf88mgbQvm5BXScOno/F/6wQm
         mo6zie2W2ms4MzmBM1rm1JCz0szm56XoBt2a7Az9HWm5jXNS07TcGRLJ8LnXJwgirYtn
         KFf1fFcSq/P1W8ztocuZhjDJQJvY1/2cwaR0GRUBzijLyllN02uCdh/29xMxkSi74x3A
         iNzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKwGIp3FppEGllaF/dlAi24UZ2C4Xery3it68AG8XozySXdYkw6Y6Hd2UWZQ4xQ3ilM9t+EZ184oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6rC2SkdLry460e63YA1VCCm2kk1X4cjAl7yjeU5VYr9aKKVhy
	0CEi2R0hlVY8GGNfOgayLYTD9c4zH8IrbfkuqjJenrE4B0sG6jqQI/MU
X-Gm-Gg: ATEYQzz77/rMpHRE4HFKnxQokr1uL/5pr9XeoQsEdI3rkMWsae+J0KeqmtXFZ943Doi
	lpQFnxSgDSJIvnNFXaVP26vQEJStmDkl7h2CEXPc+oiru9/7i5XCkjHjNHndnm25LE3NEPdlXxZ
	hDEbntvkO8vWuu5QteCvcuk0XXV+H+25OVjlGBlcotq1ZRnEXWy4IIXyQ1RRBmbGv9orSzuzMwj
	vdVk7mck4PYzdXPekPTFxR5ZG14y5y8Vn6959T8TK5SsDwPMG0PCeyLGEHHBxc1DYbHaCiXgh0g
	pNBniWC7xEF16xPy46L2b1kMIH9LNfDt8npOtbX4TfU+Wlz+xTlxB0jqRBxMrWgo9DWamJ5Zlpi
	2yaaxCbLOwKEFCMQBtJ1RyCKST9ybgH/rLmAKD73Dx0c6rKjDANPszLbDzeUGGkjscUovmPTA01
	p2qZHJj24+glFzVISmJr+2iee23DXWEMX9O7ScirhrX5OxvHM=
X-Received: by 2002:a05:6a21:9ccb:b0:394:782c:a5bf with SMTP id adf61e73a8af0-395c4729c5dmr3432374637.16.1772214506443;
        Fri, 27 Feb 2026 09:48:26 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:acea:5ed1:6337:b523])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5ea093sm5671207a12.1.2026.02.27.09.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 09:48:25 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 28 Feb 2026 01:48:19 +0800
Subject: [PATCH] iio: adc: ti-ads1119: Fix unbalanced pm reference count in
 ds1119_single_conversion()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-ads1119-v1-1-e16825ce34af@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOLYoWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyML3cSUYkNDQ0tdM7MkUyNzw9Q0CyNzJaDqgqLUtMwKsEnRsbW1ALq
 w3iVZAAAA
X-Change-ID: 20260228-ads1119-66b5271ef827
To: Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772214501; l=1125;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=fYBB6kRmAGnbgbA2q/i2t8FDHy8spPFfyQB8yM9qEnA=;
 b=2Pakxc7tZmIi2idIwywDBgrjk/8A7ZvbMh5t6BiHsyu5svf3IGxQU8mqR+VJW4LFPqpR8fefp
 xy0tfDxcVlDDIxKlW7nBJ2yWxgQQFBICokb2fOYcnRxj5eUi3fYn+pl
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In ads1119_single_conversion(), if pm_runtime_resume_and_get() fails,
the code jumps to the pdown label, which calls
pm_runtime_put_autosuspend().

Since pm_runtime_resume_and_get() automatically decrements the usage
counter on failure, the subsequent call to pm_runtime_put_autosuspend()
causes an unbalanced reference counter.

Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/iio/adc/ti-ads1119.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index c9cedc59cdcd..4454f28b2b58 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -274,7 +274,7 @@ static int ads1119_single_conversion(struct ads1119_state *st,
 
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
-		goto pdown;
+		return ret;
 
 	ret = ads1119_configure_channel(st, mux, gain, datarate);
 	if (ret)

---
base-commit: 7d6661873f6b54c75195780a40d66bad3d482d8f
change-id: 20260228-ads1119-66b5271ef827

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

