Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F233123F
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781977747; cv=none; b=YI7VgklIMeny/7JIRFO8VRyUDyBZllqVqdfbYv8+BqP6x6G1MpMy9PLYCUTBsgPOfHaSd4pJaya35g673Cp4iy25gRQ1ojULmw2kEaiO6SaG2n+8q/5QhbhW1YOzvs/UJPSTF8osF3B13R2FEo2rMDYaU4JOhfaerEZWbGtBoGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781977747; c=relaxed/simple;
	bh=08OKc18r9CXgz6b6yf9/OSqnpT1r2NkykT91B1CcZQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ng1AwAh4iBWybI9GIyMVyjZ34V1P99S4Ypva190WN9w2buWmvHAhILtZ0Y4dn/vXCbshty49nLI/SNe3YPRCr9Bg0nf+og7REAFgqVuyFj6/U04GKqYYUcfhVckDWwGpeyMEn0k47kD8dgq2lge12dTvvkQ20sfqF3t/BaG/HZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pfHAdH4E; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfHAdH4E"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso1606266a91.1
        for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 10:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781977745; x=1782582545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqcmHkc09d/LVU+mcShRey1+Nw8pGbrp4LNtryqVc8U=;
        b=pfHAdH4EWjQqMXmocE8VfsX1BpmdIa/nQt7jUJ5B+Ib0kyEiflvyVNXdWHaOP1OsDs
         T5Wzn5r48zLczmMUcQXFXkUNdUpMgM+bV2N76B/X425DCywTcYaqY2/SfxfezvSzw64k
         4sxrYN+rFsFXuyakpsKYcoPxvJCrldFBJyRZKpyNV7IE6/NPp9eIbyG7cjAycWKRCbdw
         nbzgvgKOUUTYxvxm7QF9DIFWFWOKwzcia1vTw9kJheshxttcas+IwsZGOxDTxlJ/tt2Z
         8is2htKlwpOzmMezulWbjXgVx4H2iNG4LEvLTnWBFcJKSRX7HlvzjlDsMxFX3BtSxLOB
         P+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781977745; x=1782582545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wqcmHkc09d/LVU+mcShRey1+Nw8pGbrp4LNtryqVc8U=;
        b=m0q1HQLTrdH2wE2pIWxqsih7rt+igsptFxrLGWW7wuhncPhZBxVnYEnksXfKV3IQBd
         sbchb+rj/F16WPDZ0FblcRXC2wG1W9+Yc16W0Xy7UQ8sleOEppg6GTTWDcRMSzI2VKL8
         FciMTXU0Ms4rE4XZ6f6xyzeKQDuxpaBvYFQE7q70OZuVetRm6db8uSyHsoXKZzTQIF8u
         Xxkdo6n/SJLHBwO643p3l7a6f3FKmTl2nBxya8PVevV/x1qyTaSXKjGeIESCNgsC+GED
         PvPgSOrG83dowkx/QaIn9Gdkz44sZuZLGhzHZbGR23kZJRKkcIyX26q1GTHzht7wE2zR
         VwJA==
X-Forwarded-Encrypted: i=1; AHgh+RopGHT4TW4qFB6VKr40xloJB+t5koPsJ5JRL62fsnf4lyMQ3bpooVNMTzBgdcLCPP2aR4piIhONcxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOI1kDtZWRIJTW6lb3MV97lKaRf45u7vH7BsDKsLsQPtRhxvQy
	b9yxp7gI29Oh51dVDHSNDzxJJqsJCJ+PLW8g0e21+o70snY6e5mRiaBy
X-Gm-Gg: AfdE7cljobjFrcW7AjB6k+9KWkarykYYeQdKCQNaMaqao52fHMgKLmfetCApz3/qR4m
	T4dS5oUeYA9D9lfz5z88R28Q7C9jFRJRnKKWTdz2vPYFYr/Y3Mm17KTr0re+fJVmXYVFN7s6G53
	YbBTBC5g/QxcIwE1RbM20+LI6JD9dor8KmoC6slMg7X9LNOI3o6hyxCA4Lu8WDnWBLTaGcVyFrD
	WuomRENDprmDvzU0ENPFKvwdiYAfQjLb4It0/kvgKsdz3DfydOE7yhX8wENr+BNEmoidRhr5o3c
	idD8pLPqftQmxkp+OduD4FIPu719nJUdNmTbh3RqwIt7hOcBZCSh3I8tVJ2u3hMTEUenhxrjGvL
	M4mTDrEiOnuuoxqlhUqthkDT/pmNERyMnS9ezxobAVlLXiv7oSQ4Pm/6WkAX4tdZ4Kd9Q5YCtws
	eRkATI67lSbUVpVkzUyTGufwXpUt6Jl+b7PV8/C1rk/8Mb4+EBsC8I3dBAmDVtvyATcCUfLiMep
	y0gI2rg
X-Received: by 2002:a17:90b:2f05:b0:37c:8628:f79e with SMTP id 98e67ed59e1d1-37d161656fcmr8358014a91.16.1781977745406;
        Sat, 20 Jun 2026 10:49:05 -0700 (PDT)
Received: from thorfinn ([2401:4900:8836:4853:6bd2:aa0a:1945:47e2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1536b049sm6344222a91.2.2026.06.20.10.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 10:49:04 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] iio: adc: ti-adc0832: log buffer setup failure in probe
Date: Sat, 20 Jun 2026 23:10:57 +0530
Message-ID: <20260620174708.111470-6-prashantrahul23@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620174708.111470-1-prashantrahul23@gmail.com>
References: <20260620174708.111470-1-prashantrahul23@gmail.com>
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

