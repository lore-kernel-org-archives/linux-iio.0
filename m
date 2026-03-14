Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68D5316189
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773530040; cv=none; b=TrIZDTSYpPMNHeRptn83eBsoH1+NQyP4kTtKCF6B2Gfy+h7nm3ZxoLgJ51bWZB80qzdmC9dvY6ferRH8l3xFCmPJuGXGUzFS/4T+3VutCbPkEq9EEwlSGF5JeEc0kJdj66jvBvtijTY7wZQyrdyq7pt+Q8Q/2aQWMxYe80S047s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773530040; c=relaxed/simple;
	bh=COCWeelnT8itjnfa5GDi1sW2UflUsRu+pObmqQtSlbs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=THASZeWItPz9ek/wUkI3/tmfwG6KXio4mjOATKq9hWw8jOcwVma5yPQ+Vm0yc0UgtZKxlqqmHaknccKudA0Navq4en/i6jyxtyfQPVegqMxa2KFA+R0ZgbUl2xlWhBEHFlBQwJTB9i0Hbf7woUXkGp8Mo9dx4gVsdqkVMkxgMGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YHYe40f3; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YHYe40f3"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-67bb87f866bso2194020eaf.2
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 16:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773530037; x=1774134837; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FkrV7jA5elfA5LjgsWiTcKeX0urwiD3k7miAScewWxc=;
        b=YHYe40f3pBrmlbzckL/bkUi7meDEsQbzWXnb2Qe1+ner00Dr4Qhn2vf4vvDIvIMw9E
         /pWF38Y0CX7YyAZxuWeFfB4JYpkMv1qGprF9emw7GQNnOwhn0bNgPvLi65S2kBgEFavy
         cvpyGCo19aph8wEsWGpuM6PTheq2rVfstNlaH8piKtegYouB4WBWsnMW2KFf74igmrhd
         Xgw99NzLARAODWAbBiIjJzRYJIYNMFNo9CmpAGdcCHoxUpPoDyQEtEJ70ANl7eaSvCFI
         MatLRtrBYUrBUODzRC44923y29URLO9PmSeqOTvRdGnfZaFOK+A2ISKLs5WDAoybpWhg
         bn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773530037; x=1774134837;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkrV7jA5elfA5LjgsWiTcKeX0urwiD3k7miAScewWxc=;
        b=KGMDFJpLsueIr4LfnchJL81NxRLp9E924th5yPNLEM8ZvVoOsyP9bH2T8gJ8+B/p4+
         qtpekTLlC0GNLtTR3RzAKxyr6Ga93Dz7HjFjbK9zIydp7YjQoUroifeDJiP/8RrKNcct
         Tw3ZpwVmUYk+8A6+tOKmSmYk3Ky8twM1Y8ooHllFNF/oY41sSe/ICMLmM/5VAuTvM0IW
         GLYjAfUSIsyy/RaIuY9yJ3VMspkO7s0qzJ3iIduYXVuHge1+MEiiQ5YUkAj3FRdzZAQF
         6VYnYUsm8dyavVJ6VJL6ZLavNY2pQiBpd5WVrPn06nQr0xUoC7SI6wYkXZMFozxWacXp
         e9pA==
X-Gm-Message-State: AOJu0YywPLN/jbQ8PdcTNKrAjO2BBa3Gc5gq0Ck6cmZj2uOsUR81qOiJ
	UXmjacIAMBruNkyQwB5QrXaglXM1kDUpP11ujw4xIH70dS+8WgnvfFq6NReLxwI8beA=
X-Gm-Gg: ATEYQzwYTJMmVwrOkv3BV0cCRylhPZQ8g8JVXyETkH1QfJV4BVkOWa3HTRnM1WdYD7U
	EEj311Sgj/evasgOelcb9ZMPhQwJm1thWtKYKZs6i95rqtJrKPhXrHvRQ8UHvCtIwpD1tAgUbCJ
	mE4wjkT+TBzA1v0UNHOOigI8xymOQsptw7jyTKbR9w07R0A6YeBiNK9l1E15szO5nKIPubixKcV
	jB+kmpwXmnBgh51ZgA1d5O+HwJO9CbEZLVV8q2XhxEyW2tVolFuvNCLPyv8cwyibJdpZmVvreof
	DyelPLnJqE7vNMFYAWkby7a+Mk0c/NPutsW4iIV2guQFPCNwVHczlAZoMpdxB0bsGjjsZstqEuq
	7VIINimJXt+yk2g689QoulfWkjMV2AspuHH1bF2xYtpiFTyVJFHB+sj0/TGxjvzVe8Y7gmj2LPq
	IUCc0GUoUmYstS1TXfKE9xZYQb+Jgn48c09ucH2+s=
X-Received: by 2002:a05:6820:f008:b0:67b:bd04:96df with SMTP id 006d021491bc7-67bda9c0c5cmr5306455eaf.27.1773530037653;
        Sat, 14 Mar 2026 16:13:57 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f27f:adf2:8637:6bb9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bc93279c6sm6850885eaf.12.2026.03.14.16.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 16:13:56 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] iio: adc: ti-adc161s626: fix scan buffer handling
Date: Sat, 14 Mar 2026 18:13:30 -0500
Message-Id: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-0-56243b11e87b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNywqDMBBFf0Vm3QEnarD9leIij0k7XcSS0VIQ/
 93Yri6HC+dsoFyEFW7NBoU/ojLnCnRpIDxdfjBKrAymNbbtqEeRGV0MuMg5ZEmtsZjkixpcRr8
 mZIqDv46dG8YEVfQuXP9f5D79WVf/4rCcZtj3A1AzpdmGAAAA
X-Change-ID: 20260314-iio-adc-ti-adc161s626-fix-scan-buf-e1d5b983a58f
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Matt Ranostay <mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=655; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=COCWeelnT8itjnfa5GDi1sW2UflUsRu+pObmqQtSlbs=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpteud3p6wNdI5q2rfZ5X31mwAEjhUl6uzgeToP
 OgiHgm/QfqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabXrnQAKCRDCzCAB/wGP
 wIbKB/wJT2UvMg3qfFXvPyaETQjbS9G1/gnRZCWUOchS5r3B9+RkYQpbqu9yx65wodufdIPwKHV
 Y14fQgWW6LKQ53pBxlNa8DBp00XagEnk6AO7zzvHJ9knQBBJ8i2w0lDH5ccHV6XVVGF5Qq9aK+8
 KVgvZXcIBH4QZG7vdcQEHCG5uJdGHp1AJnL1hDqRUyzFA6UJszG4iQQLzRBjB5h7qHfcjtTeEIu
 AA9JJ9Qvz4lSl8Rrk/gLQkNw/2EEGq/IKx0Xs6Lzco1Qugyc8sOwYo5iVCPa/ozV3WaZmgd60MV
 JpO4CSVjpY1G5a77jXkQIQFB8AWRHMB/efF01YWrWBxF+awY
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

While searching for odd-looking casts to int *, I found there was a bug
with that here and some deeper bugs as well.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      iio: adc: ti-adc161s626: fix buffer read on big-endian
      iio: adc: ti-adc161s626: use DMA-safe memory for spi_read()

 drivers/iio/adc/ti-adc161s626.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)
---
base-commit: ff0843ceb1fb11a6b73e0e77b932ef7967aecd4b
change-id: 20260314-iio-adc-ti-adc161s626-fix-scan-buf-e1d5b983a58f

Best regards,
--  
David Lechner <dlechner@baylibre.com>

