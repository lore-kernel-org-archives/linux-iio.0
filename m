Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CB2233922
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781977732; cv=none; b=mxFvlFJUNtF7GgNEbFLYZmxmVZKnvT1gQ4eIzkRF8cshI44S5MagAdj3fMBprjDSOO08Lhtjpll1q4hyzVy1mmpkYHy/dK9wlbEK8OWfWsuJyqiZNtTPv9Z6rHQkl1Lm4tMY0YgKCgwmYmi1l1tliel7L5/jRjgG7VrU+a224Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781977732; c=relaxed/simple;
	bh=U0ol8M7MlQ6ddKGwEI+qqdztih/6bYefeO87FGJIRTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnKNgO0JUXvHpnb5C2gUVy5ZX1IWExhslbsu7xMjGiqUCExKQlE8m1oGEjFkT9Gg63fQBDZSY0w3WdOYrCF7RjaReZnuoC1b5590oS6ygr7saSmBw2d6Qs9XLgScv5ojfrE5FRMh0+5bHtW/i/nLegJ3n0bspoeHmNFmmFpZqZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rScImOPX; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rScImOPX"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36d6bb38b44so1918918a91.0
        for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781977731; x=1782582531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmzDcj3m3a56iL87dLXydya4MHMnnAuEbZmbbAHEr1I=;
        b=rScImOPXuE/aVL76ms/BaCHAn3VdBJO4GbrLz76uEgAND9kt3/6OECnvGrliFcf4PQ
         V7MevSCr91GkZfIH3UHmt06yTw2riYCR+qVvWpyUwks4VpUYeZOZsRHh8u1FbHo6Vu6s
         dDQRPFpHG3OzAS156agE/hVHQtmOvu57GnEBEojkZIjUN91JZv5J/1qWRkuwQimL4tda
         0u0JUqXbvpLmfzUwDnWa0nziwmUaLzI7RqECqyLLOI1+Q8GsmBGUT/0n4/64oSucrQVX
         PDPkMHJYW2xnavHnhzJQeLgTCQxJZKg1bvi3RDJ19vvh2auT5N8HagEq3KC05LwcuPJG
         XAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781977731; x=1782582531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zmzDcj3m3a56iL87dLXydya4MHMnnAuEbZmbbAHEr1I=;
        b=BFeR4GtG5fNySxXv45CX3l7Qas/k1+SyHbxhgZJWtNqQvRxZvyDu4eXYDOa42PzpDe
         JOWnCCMVkSO7agwrai1jE43O+FhoEM1JjWpaXS6W2rRwdsaD/a84iQsOPOn3ZpFJ1P2y
         AwoIQNPfv6g6SowTjyqCi8hpixX8lZvBrRQeUVTN0y+tR9jM9FPtsY2V3nAfKkMBLPts
         jDH9GoLL/9aHRA05CG0I/C+6Avvgp5kJ19odhWu/Rh+uQ3PC+Bh6GoXnG6UVMO0EchMn
         wGUtlctA2HLMkfVGtCe90HekGD0mFB1OSoglti1HLlVOH9Dhm2VV17MkW9YhNZLYPYlZ
         lsDQ==
X-Forwarded-Encrypted: i=1; AHgh+RpO2dATJL1QbqyyJgO3zQ0Ufrewi/yK2ZKGEmbVypBcTshFMP8URaQmgy/UDgYiu4bK3KtiA4MPrQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySMb6L73tzBcVwHLrgZa2sGH948UOC6aawtSrWyRaCcc/5qvoH
	PPsPioks4Wm97O2CBmC0JOFS7y+AbArCIx/8LlDv/qjzZV0UYlzIX9Qc
X-Gm-Gg: AfdE7cmWMYPKeF43QJ/Jzl0Vl2gnJ15I9TULm9ZGNBxui9YOEG2fR4ELb7Gw6rrVnJ1
	87T3LK5iW3kDJGEq3A8B+SF7HrWNfqctRo2uX9N1rtbI0NXlM57efsX8w6LUVRgeKCfU54NdhAA
	s85jJ3x3iP0Q8tXcX6TNE33H8OXsgZ0VGCtevpadn5fdhgbrjJxR32lm5bEEnc6wbON3NTHB+IF
	o6fXINgE8sAqePruj/oJN/n1IG8HJVtXt8i2KEOweKKx8RLNiWtsgQaaBCY/7x4pox2X+cwSBl1
	Lm8tWrNn3IyxhlXxr3L9FMqxGxGAnRMG6EAt0AsmqjeyKPdWqfy/bINwTjFT0U0JW52yZ9oK0tD
	wxi7gPxQygzD8OT1JsfVp762Hzt62RGzk9qGEwab9XO7HKsOG7WchQ7TbLaFmwvChpcZCxh9mXy
	+DG9KszBqP7z4r9lf6swjz0KmzpQVQVTeEAAJTVuhn+f1OrjS8t/PU3i5/MIAey2k2Hd7701tTl
	UB/smr4
X-Received: by 2002:a17:90b:3a05:b0:36d:df4f:ab2 with SMTP id 98e67ed59e1d1-37d160a030cmr8200824a91.13.1781977731049;
        Sat, 20 Jun 2026 10:48:51 -0700 (PDT)
Received: from thorfinn ([2401:4900:8836:4853:6bd2:aa0a:1945:47e2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1536b049sm6344222a91.2.2026.06.20.10.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 10:48:50 -0700 (PDT)
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
Subject: [PATCH v2 2/5] iio: adc: ti-adc084s021: use dev_err_probe for probe time error
Date: Sat, 20 Jun 2026 23:10:54 +0530
Message-ID: <20260620174708.111470-3-prashantrahul23@gmail.com>
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

This simplifies error handling and ensures consistent error reporting.

Signed-off-by: Prashant Rahul <prashantrahul23@gmail.com>
---
 drivers/iio/adc/ti-adc084s021.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index a100f770fa1c..2b4bd223d816 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -229,10 +229,8 @@ static int adc084s021_probe(struct spi_device *spi)
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
 					    adc084s021_buffer_trigger_handler,
 					    &adc084s021_buffer_setup_ops);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to setup triggered buffer\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Failed to setup triggered buffer\n");
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
-- 
2.54.0

