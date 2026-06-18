Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBEE3385AA
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 23:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781824609; cv=none; b=VBym1hwv0ZKJoxivl+ypAvlrE1BtQ2wx+QyEGcORHDAjq4l8DDQ3qzubTCo4YmLXrl8705CGtOiTBxiO2E7bSXY10rUdcFj1LOVL0sig4YWHxXnq2YlN0Q77WsA6UGVd8EVf1FWDxsUnPUnVSP6wQ88qmwiPCL0Ydrn/oOHZ4vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781824609; c=relaxed/simple;
	bh=08OKc18r9CXgz6b6yf9/OSqnpT1r2NkykT91B1CcZQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbzwZyoidjRlf8iWYSc+7U8Bi1z0Vm4uJXH5taXt7ExKW+N4JrLsr0hlIq4Rv4CUBpaU3uOvlVCwjIhrUrzk0jOL2ckp1GftwH01+JX1grNIP5XFSTRj6KhagxNEGOIq8dPHZXCuhkkoLajkr/2QM6ZvJ7Z1lbi+wEAaPJ1yrwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lskt0vst; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lskt0vst"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84536e2857eso1062041b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 16:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781824608; x=1782429408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqcmHkc09d/LVU+mcShRey1+Nw8pGbrp4LNtryqVc8U=;
        b=Lskt0vstRwKYublgU5Gy99vH+zpzswYyvJAVwJNge6GKEY+HyvNw5tNmxeeh7fOspI
         MaDNMxPQGo+kChDz8TQKR5Zfsz21vLzhOF5Afxk6nLXFzB4SeIQvJs26f1qf7euwcE4l
         jxmQMZvzcuAJz4aJmvYKLDnhIwaxoNIJcFNb8yeAUNlDYg41GWA8qSY0XRHp26YT1a+L
         fUJkopx9JSkUNuHyXw5J4K1ZE0Yzoxd5rKTcOoDgwsIb2yYjYVAf4yCXPCcSqoFJ5Cqd
         cBWfXhYQuOMBOLP4/oGXJru93VjpwgXhSF3mzNfeNv0tMc0D6GepGRw2MRTcgygVE2zO
         7HKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781824608; x=1782429408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wqcmHkc09d/LVU+mcShRey1+Nw8pGbrp4LNtryqVc8U=;
        b=GPolD2xhfNfG3cH0ra/QB1WRhcD1lLK+sQeJJ7In7ctAu+x4OO9mJu/4hELVDLLRK6
         xB0ltA8UKYEeESMA05cOqttx/dSBBlNZksNNZrfBzMk6VGY2Nk1n1NZcgD1pSDhanW7S
         ejukJua4eFdQYdLFXWm3D0KkWayv9y4zx1/0fkLCkYJptTDmgipryaCeUZcV+X+zW20U
         YeOOW6+ajZNqovrNSIRetBjTcLt5IBnceNlndyUzVRd5PJB1aqc9VOJNRrmJbbH+SmOV
         jwAIugyRq55ySu8S9GWdR5q0vyr1bu7InM2S72mTzP4gPVKc2oM1NhduDDzMBwaO63Dv
         i6Lg==
X-Forwarded-Encrypted: i=1; AFNElJ83TivKXgiLrI0ienVD8gI7e6K0LgaNlgc/sznfmsapD8/6veEi56X1J7PN1KqAyHJaQ8Tr6hGifRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUENUZbjmbLRONj6f/5aLbQOB6IWAJtIMSapnlXFzhYBnjNQQx
	sNpZytFxxSJLhCZl4VYNCo9O+J6Tx73pI9MBh2aHWKOjfzPOAz/MDR5u
X-Gm-Gg: AfdE7cnS8hFUy2A206OaEtun33BUQxOWftb7HoLMGNdQryiGhKfg5ZGDC2m7w6IJcM/
	dH64Tj4wOBQX8zCPsHU11QslZ0/cIap7s1oeOcGChmJIaiJRkmkjfD9mWqmF3LKSoWt4P5v9H5N
	oSULTzta7nM1hpeakLEdp8Mfh26efcX8aUK3FjPsjU35GyIdQWnKLpwMsl+6bzVXCObb3Y1BPot
	H6sZegNUHLJjlpz3BEC2WiYy56SVqoET1hOVgm820nIkKf8kM/YjZSq8W0rc1sHy91ozqaBq3sd
	gb6mR7pAOa/XS7qmbtvWmShh6XSrgby/osF2T2JtEvNNemIQM8Tgw7jKB9cLyqqoXY/8uTqi13K
	ZtyoY2Wf7T5zISx/gPQ5cc1N9O7pilZ+uFOxWxw/H0Kc6IzC6hBoOG/gbKKBwgwgymYXzuIra0v
	r1r07CODIoVRzxfBFcKvMWTPo55R6tG8J1icL53Oms/YYMrzsR6Wsp7lfwpQaDKW6aahNKPR57q
	1AOy1xJ
X-Received: by 2002:a05:6a00:9515:b0:822:6830:5900 with SMTP id d2e1a72fcca58-84550785d61mr1028705b3a.6.1781824607891;
        Thu, 18 Jun 2026 16:16:47 -0700 (PDT)
Received: from thorfinn ([2401:4900:8836:4853:aa0f:55df:e7d8:852f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845537fa3e9sm225135b3a.39.2026.06.18.16.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 16:16:47 -0700 (PDT)
From: Prashant Rahul <prashantrahul23@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Shuah Khan <shuahkhan@gmail.com>,
	Prashant Rahul <prashantrahul23@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.or
Subject: [PATCH 5/5] iio: adc: ti-adc0832: log buffer setup failure in probe
Date: Fri, 19 Jun 2026 04:44:38 +0530
Message-ID: <20260618231543.413771-6-prashantrahul23@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618231543.413771-1-prashantrahul23@gmail.com>
References: <20260616130612.73122-1-prashantrahul23@gmail.com>
 <20260618231543.413771-1-prashantrahul23@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Errors are logged when enabling the regulator or adding the cleanup
action fails, but not when buffer setup fails. Log the error returned by
the buffer setup path as well.

Signed-off-by: Prashant Rahul <prashantrahul23@gmail.com>
---
 drivers/iio/adc/ti-adc0832.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
index cfcdafbe284b..417e54223092 100644
--- a/drivers/iio/adc/ti-adc0832.c
+++ b/drivers/iio/adc/ti-adc0832.c
@@ -299,7 +299,7 @@ static int adc0832_probe(struct spi_device *spi)
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
 					      adc0832_trigger_handler, NULL);
 	if (ret)
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "iio triggered buffer setup failed\n");
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
-- 
2.54.0

