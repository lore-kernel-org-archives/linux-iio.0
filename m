Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7249F33065C
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781977742; cv=none; b=KCbub4SwO7iixXg2nm25Vvv1pishbE/2MM3OJVAsbZ4rESPiBMj0AOLBcf1dpz88IwjZqZMx8QUJF8/vv4ePaZHnjYwNLUqB7RXuAVUy4Rsqi6gnuGfzYkR6Zr4g1UHIpuMrqPMtuBVXOAnbVwg0YAegsbnEFHbyfvaSYklX8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781977742; c=relaxed/simple;
	bh=Bqw8KWrYyc3Yhgy0YmpBeuKkRSmFMKVir1wSW1q7t+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kA6avKdmFNE+Tq55xhO+gLmBy8/pUCW6N/bP5bMT+sCLnHmVMF/KhS8fi1NRDQ0uhPIsP8ZIGspb12T26BfOvPLuZuO8USpKzV/IPvS5fPE1vx0J1Gm3jsdKTsKONdD+v1XOfhrFtnaPTjH+PUCc6PkVt7jstdhdqzfiywRBzbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQlwbJvq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQlwbJvq"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37cbcf49deaso1516909a91.1
        for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781977741; x=1782582541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdcSpVP7BtY37WaL5QfljTIb9tbE66I05Biy5Ue4eUs=;
        b=ZQlwbJvq+JxgMpNC/gv+vSXZqy+Zov5AtwJZ6xpWBgREhc3CKmEC02OsJl3Jn9h1QE
         I5kg5o+agtAdlVXDVleJfBS7LfCDLoe3lIVL2RJ9ROs9E+NYfmcuRPpZeNQkkGzCNzIb
         eyHeC6FekIVJFInrLFlCQUKg1b0FC06t7dAtXmZyu9TpEcOGOBMkhvmFkUN92EE/jrne
         TXQ3TxhPv6wPSrLVU6fxd5V/BxScd1PKNZWE2rH79Ja7Jur89mZaAh3y6yenOKHBDjHs
         qk74EeySOZg6fDRludb/rBjJZh2qwCPn07L6PuQT1GDLeNoRTIF4nVICxhpte9R27hoL
         hi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781977741; x=1782582541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FdcSpVP7BtY37WaL5QfljTIb9tbE66I05Biy5Ue4eUs=;
        b=l3cYphtDl/OxCRRlimaueECpkGeywlmbDKTeN7wUg4MmTRFsVi7MYLq1tSvLZacIvI
         hoy9e7CKWb3gpR+Jl4g+xf72EyqFLPssaurCLQRarlNDwmNg9rY9oGdxg46VTGp/Qc30
         q71TiCWHyXI3B3BHOm5jhLnjol85/xVaC8NLoM2VBqDjeG1IkDro1vE79VJGEVJFuZlh
         L9VWdJB5C+AfMQ4J1PtCnhKjZskMyuLo9kAg5OXiDYJ+ZCIG5VgVKiss+H2OhWP55/p9
         ODIf5+79oq2PPcj0SXyns6u8HeLd/ZVfdNon4lD2qaPmkKE3CkczPrUC+L/a6jOVILOd
         vlYA==
X-Forwarded-Encrypted: i=1; AHgh+RreQzvsN82uGlXrDQ9M/mu84ZQSPQbA0geix2HxClA3lzMnK2vj9U3UiCCURmuH4Owq7HcDo33Hnc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV+1pTghDjj3n5yO7skgoFCrcGqOW+KL0jsB/CMVtq6weLzTtl
	n72HTTEyUFpQs7ZJA3BCavm5FjuXdfXt32IKvYrG72oeSQy29DH8xQPR
X-Gm-Gg: AfdE7clvAZTUW9tmunU6SlR02/hls4VG29R7i0ysMuKc0Pf1W1yuSL92ocbblIlwX6T
	5MZg7urPDfSxbwE1jX8YxWRRmp74Z4Yv6LANSVBYDtBfTjHBNisbN5Yyot8sE/jRps8et7z4Bmf
	FiXfObizKY0cRC+Gdxkl2fE7yfuYQNJmhMAlAx2mMJPeEnwxzZXWaQzXMyRQzdOVbn85ywlyDQv
	l6rdHx0+I/bMp2VPL9q5bZttI0hHC4PSwhAvGMycCfa4VCOCU5cjkwbvg3Y7tOCOUBKDZlOuv+R
	Kgs47TrtXnYAdJPU4Jl9LgGVHWRpenRYdrqQIr82k+TnIMqx887pj5Ou7zZ5xhPodZfmGf6GcLh
	z5DCVNrze6/zaipHQ3rU7/JhIwjvIHTyMs8LSrq/FGm0lBov86MpNB5qbnceZBBmAe4Uehfl/MV
	vga5paTnVUvycGsSUYz+swPBPUwY6lEN3p5S/yfazKXWBT2SVyVAarfuYgIIPTF4hJwLulD+hdo
	gVsgYqB
X-Received: by 2002:a17:90b:350a:b0:36b:71e6:3df1 with SMTP id 98e67ed59e1d1-37d15689097mr8398461a91.3.1781977740680;
        Sat, 20 Jun 2026 10:49:00 -0700 (PDT)
Received: from thorfinn ([2401:4900:8836:4853:6bd2:aa0a:1945:47e2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1536b049sm6344222a91.2.2026.06.20.10.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 10:49:00 -0700 (PDT)
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
Subject: [PATCH v2 4/5] iio: adc: ti-adc161s626: log buffer setup failure in probe
Date: Sat, 20 Jun 2026 23:10:56 +0530
Message-ID: <20260620174708.111470-5-prashantrahul23@gmail.com>
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
 drivers/iio/adc/ti-adc161s626.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index be1cc2e77862..f83073280c9c 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -217,7 +217,7 @@ static int ti_adc_probe(struct spi_device *spi)
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
 					      ti_adc_trigger_handler, NULL);
 	if (ret)
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "iio triggered buffer setup failed\n");
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
-- 
2.54.0

