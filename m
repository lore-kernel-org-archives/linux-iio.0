Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD76397E64
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933717; cv=none; b=fs810vEA4tM0RwVleSVQFaUJjplWE8pDykw0Rfe6b0SSiowoNC6QSCGBxcorYk4nE/sENoOLX1cY9veOw0Symrjcg0XDrrjGiPmCSKnkLvq/59VLjG+FvOkLlqnEBmyy8JYUhs8iDpcuUQIieW1FmIDhZ3qu7/XGUvRwDvdO0m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933717; c=relaxed/simple;
	bh=ZrVUK7Zj6N1KP1R23c6/0Wh1JaKWO2Kf2XCkb8zt+wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sTp3SJnPBisC3oKR1zzCrF0VyMk8ouUHzNkMkQiMSLoE5wWz7bvQhEneXsoHGU3tFF/GROnIR2gJ6RS+61EEKHXBwerniRkHqXmMVkk6sr+Oe9EpLLUyhk8gBOhxrPu5kbsCTws6SdBVzbMm3igv2nnHh+3o38En6/+uIoPFEKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSvbwzhz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSvbwzhz"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-476d8e647e9so976480f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2026 12:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782933713; x=1783538513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfXtv/qlJgM1lCGYWsyy+YR9eQYYd+6+L4VNCpJsbs8=;
        b=PSvbwzhzx40+qCg/wa/eCNCqYT5VU+Rh0/xraRwm/3oronlgYatYP7RseGsDU4vKDt
         a+hkXXsUF1ywqk38guliDfRLiDwdWEOLGXuU77f7fpONl5Oy8Es1bIv5NeEPadBeuSZX
         t8khTy+lJlgNI21g/LhHyrMEjnGsCRTAwrRRaGilMmBs91UauWDDlFZ4wmDdfjylf5HW
         XqQEO0hMRU5Qmu7YGxnQzNJT8vDc3tgvqtlmeZ7r2MAqxx5/+JqfxdgUSXa+9Hsd7HOe
         2ahQlS4c7b178iBrtjjJF48vb64qFnRCwakhXjUjN5nvPiv1M2VU3Tu/jBzNvDcm6qFn
         11Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782933713; x=1783538513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LfXtv/qlJgM1lCGYWsyy+YR9eQYYd+6+L4VNCpJsbs8=;
        b=hxCgkERixDWoJMbEltSyj7sBFkaxCxQ+82FPpUXa9YmpQuJtuZkPHfRrI8oK097NTk
         ERBtlfI70vLnFaxKXKykVYmyF5y6tp0TJDHKAjYbxWsTi6726mFkdqz3qmJVWJeVg/xE
         LhrvL+EdiRSVZz+zx/FTvkz8/cjL5fUga0RDg76dBUy+fi+aguaWid/0UYi8vqSn7SlR
         pi1poePwi/4tvqNC4v3z44dtKpUWL8aj/2w4OJO4yGikvll59BSlfJ74FWVpXDPYH6J5
         5PVXy33w3wLq6fyIkznAo5vx5jEgXy32CkTn5WDf9qR/1dl518bnH/qhL4+BUcHz/d+O
         W11A==
X-Gm-Message-State: AOJu0YzWgNFOU5DJMUj8qER/V+flVsBK97igsoptBjrtUjhqAuws/uZz
	QSFZaJPnxLyXM+mQmZVpXvmcVhgiolAar8FCX84T+gQV4Wz9k1WHeBej
X-Gm-Gg: AfdE7cldqD/DgdX0V7l23oj9eLf9AB87RkropESUZTkdVRdlUfyYoUlQgpnsBYwkKXP
	WnI3QsTD1JmQZ/M+0S1t0ntNaEZjTA78bnNWDESt6DiYWgEJ/y+wBQ83YS+Gg4nMVt4nVfizTak
	SLUckJ7KsHebtLpsM3VlsBwRD8xBmbZkZEmYwheAy36YT76ovGBqdoUyXGy5QaQr4aH0gEf+VKl
	gzzVVW+xPFBsWrBUchx7Gu2dIDIEWl/7Nl+71OfRsQdBv04SMVOs8yBdD3kwaKi0xS8h5h9CsYR
	N7K8nhe0z4CAHrA4oRXIaGIwTV3b2AGpORLH6LFsPdPvk8vY4Qugj+vtxxNrkDSPQECw9w8qgdV
	KdlUwb5BP9oRyPhAA8d7fy/JzUgXtLGob9wV/KDGhxo8dsod0vLbQo+qRc9JwUQEQjkXZqsCYFn
	DveqAFCWBd9wpbXmsig6fdwOCyRYF6/KbrKXLYyxZKdK6n+RXHqLc9gFfOW39WorgJnvdPQjeGB
	MlOmGvDFPYGIsJIrMT3xvzN09fvD05BA0obbutAZdebXM3EobqNrtFST/0y4oAN1p6+ujoWT4dT
	aTGG9sge1mrim+Exh1srdvbayaZ1cDX9qwi9OJku1+K9hbG4l4H9USs=
X-Received: by 2002:adf:ea82:0:b0:475:a4ae:e630 with SMTP id ffacd0b85a97d-4775be03177mr3789033f8f.37.1782933713282;
        Wed, 01 Jul 2026 12:21:53 -0700 (PDT)
Received: from [192.168.71.52] (cst2-160-240.cust.vodafone.cz. [31.30.160.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dbe617b1sm2081838f8f.16.2026.07.01.12.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 12:21:52 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 01 Jul 2026 21:21:47 +0200
Subject: [PATCH 2/2] iio: adc: ad7779: add missing 'select
 IIO_TRIGGERED_BUFFER' to Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-add-adc-kconfig-deps-v1-2-b9708d74f426@gmail.com>
References: <20260701-add-adc-kconfig-deps-v1-0-b9708d74f426@gmail.com>
In-Reply-To: <20260701-add-adc-kconfig-deps-v1-0-b9708d74f426@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Jonathan Santos <Jonathan.Santos@analog.com>, 
 Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782933709; l=746;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=ZrVUK7Zj6N1KP1R23c6/0Wh1JaKWO2Kf2XCkb8zt+wE=;
 b=Ji9u+4oeSNAFqIlJi4djVclgX7CYD/lSiKslgxHIBpV/TPmePB3TOA7Y26HQRA38NC0dJzRTR
 AihUhHpsaHZDfN6qqYXFe6NsLniKV/iyfv+2XzPAX93SS6vT/R0lC+E
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The Kconfig entry for the AD7779 is missing a
'select IIO_TRIGGERED_BUFFER' parameter, causing build failures.

Fixes: c9a3f8c7bfcb ("drivers: iio: adc: add support for ad777x family")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index b1437e6b02fd..878f8145406f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -454,6 +454,7 @@ config AD7779
 	depends on SPI
 	select CRC8
 	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	select IIO_BACKEND
 	help
 	  Say yes here to build support for Analog Devices AD777X family

-- 
2.54.0

