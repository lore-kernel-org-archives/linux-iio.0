Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15E6330650
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781977727; cv=none; b=kG1i/7tiNJailVj7SKk7jBS/fA5OaFPqJRqsXrzlVnC7Q/zbJKixvG/x1VMbre+J8OZ8R3gPb3FVfQC3norWofo+tDDA5zt+q9zHCqzNRHTKv+ceElVlLnB4XGa1onomP/qdzXsVh1dzti8WUigF6pGjmi48WQi/W+gFdnJiVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781977727; c=relaxed/simple;
	bh=Yl43fJ+M2G/qfrX+KfbFEywxPQM4iuILGhuxCI2P3Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFn0gtJ9ePhx5VrWOnREiHZeKda65bUJnQ3Wr7g6lV4PYeJcJ8CcKM59GXUYuXd7KkOFZFE/unuq/zd+uzHT4/xAQRXCrO4+lJ4c4evB+IPvezE1noNC/PtWeDPtqvo9AtmpxUTUQKtPQGEO7rPkRLE3rCai8Gcw6HtKuCJWBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=claT63zZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="claT63zZ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37c5b9d42efso2090133a91.1
        for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 10:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781977726; x=1782582526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GQHd7wRPytVTo36B6mMnCcjncWbjB7P6uAbRfLAPmg=;
        b=claT63zZSvM4IdRzDzQnglr8Wlmsj3+/3BxjNuiJNT03DAa/utAldr3KPfmbKbbnGJ
         3sbl9F+3pQhXZ1dVodIRpsbSCSIu1UtWwq6ahJnoTTrt72GEfjuYlVSfHmYdBd5iPebW
         Hol7xhsDr0QSi03S1Uc5iGHOenRyp0c+FdD/thypCeNHAmtu0lXAB9W50PUctgWb1n8/
         rq/Y+5rWXxJSc06GMuEF0+iDv4O9EBXPCnSRTBHBi/6x6I6OFwQPqGNndQ1b6u6+t2pU
         Dg+A65b7VxjA/xe4xJVi3rqY0cNxBrpg5t3MRaK6qYjsX0SxVZsflaEOm1lePatatGbR
         Co4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781977726; x=1782582526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/GQHd7wRPytVTo36B6mMnCcjncWbjB7P6uAbRfLAPmg=;
        b=Gpa7eAWT5oldc3pwR4sNJXljEbrMsAOrSTzYxg5eLAFNocjuXYGxV+V42o9AbCZQnD
         YUNzLU3vJgSMQH0omMyYRbZ0HfExu3arxtsmy31dn9NTHikZrZo2eafrgvcCFYdQ5tpZ
         Ms+aT0lYHE16nVTEqfNZn04wGldapwAikXyAUkB9hKLnwSdVNXBbFft2Eq2wks62rFQd
         uBp+JVrwDuhrlO39F2ojmZvbZBVf2/YnBkqhdEDt5DQabtDelza/6y+iQJuVlL9v4uSE
         KcAoLC6PuGHXYTqducqGPCv+PdiNtFaK9ptunB/j7BbEnobFTT2trvcuUJSpPPvuZ22m
         2vWg==
X-Forwarded-Encrypted: i=1; AHgh+RpyJ43nPj2St/wO5pUasMuB7kI4KxG3y/HiK2NMGV/8s8Gv+81yXuqNzWaqMCJS5hcvq1LReoY2Tuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHq+e01ZpSnjtK7O7wvNBegl/GV3tK4GQAJXGFbb9zAvJEIp7J
	ha4Q5utbwsRl5GKqCUIMjpJ5x4eBlk8iyfUMar6dXfX3xNK6IUuTLR2s
X-Gm-Gg: AfdE7cn1cpJ0UYxoYTyxjJNpOjqPj15LKwnF5/35BWQUwZ9eBc9QCkrtT510vDVqj6c
	4HI2BdJd5g7GuSB8H8F/0cL/5nl9Ixf33pTAxcWXq13VDlwRQvUu/iQRCmo7ytFip7Uq8uKm6iq
	orjxSIoapiU37EqDzfVOPsqJLvPxN3mlOz9z3HniL7TRaKb7Q73qMju6/QPIJRB2YiVv8uzTh6h
	1NPOvVe5Ak6LIyxFgw+XSEA/Dn7AD++nxOSzeoITUB1tC34JNlJJI/2yiNbrYMDYMnpQjP3Dl/f
	V3lhx6NyWk4kIAi3+NApJY1KpYHww+/sTK2c1eLlCtW4QvdU26ftRrYY1VPC+PdNchUNI4ciOIF
	pwfqVK+XMUpGhuhJ8U0l81Mv0Rl2S6jwjaW5y/yOo76/TvWVW5lWkUxba7hDUShM7RlnR/ckUok
	Z0YvT69Xze1OgleCS4tavYuBSiIbrAOlY40HXDSof6yPYb2OSZvwg955c+wuZMjUfy+ip8YZvg/
	cdKjdh1
X-Received: by 2002:a17:90b:2d46:b0:36b:a162:a1be with SMTP id 98e67ed59e1d1-37d19ea7136mr5722066a91.4.1781977726049;
        Sat, 20 Jun 2026 10:48:46 -0700 (PDT)
Received: from thorfinn ([2401:4900:8836:4853:6bd2:aa0a:1945:47e2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1536b049sm6344222a91.2.2026.06.20.10.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 10:48:45 -0700 (PDT)
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
Subject: [PATCH v2 1/5] iio: adc: ti-adc081c: use dev_err_probe for probe time error
Date: Sat, 20 Jun 2026 23:10:53 +0530
Message-ID: <20260620174708.111470-2-prashantrahul23@gmail.com>
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
 drivers/iio/adc/ti-adc081c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 33f82bdfeb94..29dd7cf25f79 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -190,10 +190,8 @@ static int adc081c_probe(struct i2c_client *client)
 
 	err = devm_iio_triggered_buffer_setup(&client->dev, iio, NULL,
 					      adc081c_trigger_handler, NULL);
-	if (err < 0) {
-		dev_err(&client->dev, "iio triggered buffer setup failed\n");
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(&client->dev, err, "iio triggered buffer setup failed\n");
 
 	return devm_iio_device_register(&client->dev, iio);
 }
-- 
2.54.0

