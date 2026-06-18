Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB483382CB
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781824604; cv=none; b=qwFyxiwBs7qryTb8VB4uHEifCi/rJywQIF8WcjO78S6hHaL2SbaglEs8nRARg0DNnqghJkyt54FcxkQaK6GskAAC4cdox7/iLlPTZfEGI0sRyQ1bIWFxyI4EY8h0nXOA1o7/6zYF1eloOQeH8l6HLvGteT8mdeAUtf8whFlu6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781824604; c=relaxed/simple;
	bh=Bqw8KWrYyc3Yhgy0YmpBeuKkRSmFMKVir1wSW1q7t+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R95NQrzj1AuSvPD8sqz13dp/m4eJxfCiBx4ql8nhS5r6F2XqIDYsRAeqyDssIojH2pptFT4hkKSRLesinH1ukLwkK3WWgu4A7Kqigdj2SqRLTPg2mBPGBA9OSkbGdGalpmUo4wCPs+XeHRfKNst4OUmYNR1esWSXkIrvZLrzXfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWaeDnBb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWaeDnBb"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-845537740ddso49749b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 16:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781824603; x=1782429403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdcSpVP7BtY37WaL5QfljTIb9tbE66I05Biy5Ue4eUs=;
        b=jWaeDnBbNPk0cfzWWVOKVzP7HLfU38dT5ef0QL+tCvAUnLJnqkTGrLI7oH+GJpr85N
         1tcgVoOLzU2GszHACC30zzVsHAN9hsjF1W5h/eTWm0j7vrdmoNZyn2cGbM5gCI5XbRyg
         X+1zc2/h7x/8jYnCbybTit2DQ8TclAcnl/6TiGu85keOXk2QTakQmvDWfrF4//2xJeTx
         zGsC2UEI4cDMgC9ydKU3EsCVOwnIxVuRqjDHsRJddr/Q8XTdcVAiunGQnf5/lxN9wLah
         27m6YfHKXAPPiXnM6lHYHkSIrGFfN3oYBqAskWt2mr0quLI6gqMsUIn1gCSXRzinbj1r
         2/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781824603; x=1782429403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FdcSpVP7BtY37WaL5QfljTIb9tbE66I05Biy5Ue4eUs=;
        b=afd6GJ5q3uFyVGzCrffsauKBKraR88yT5FZDnHIQXLGXBJjZf2OYRzD2qNKdrPjUSx
         cejzBt+NeoG6yeXLR2p1FpqV6V0aAHumTzzchnFzXm2voytaSV/zDpHaluj5GgE26S4f
         8B7b2gKsi3aE+gyBfwFLksEJqyYzpbXjscvyLrppJ7yQm7FvVXwgzTNtD5wZn5AzN6eE
         brbE5wLHAhXX8dpl9Ttm2IZT4O3FWAtCU1DA7vIp7Zo7FCJhztJ/8lVPGn7OfZQG29f3
         vE+jhxXJ0E7e79Q+Jgs5auOVYRQ4nxRn02lZT9khkwQBHGu9JJqNR/Q74HluL2lyofaT
         jqUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8i4Gdqxbbt0LuOAFpLKwCK5L2Agzuony3pOJtDg39ve8cviOSNlJTzcZRXvUkfHTqpUyzj+FKX/Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtXBV4LH6HZxRUVSoy71XGf3fINYB41ouUcHucJUmaBn85ttKl
	k2ph+OLct9GOmGWRyTtKpZ4glFhI5SxJplha7DOnh8fqdbZgArtM3D4K
X-Gm-Gg: AfdE7ckhx4ib41DdjBXhBY3o58IqG+o5JzWVons1SaLcfO94titppGrGfmAtbgRwBit
	3hKdlZ5sIkCKeJxuOyi36+/x4HgTT2cjad8vKCdlWkC+EeI1ahDF1svUrP1nJoNZR4cagMaabQW
	WDef3PCiNzRM97QA66wOFWiGSkOWWvu9RskI2613ic6SrDxQ0ITF4w8+rJStUMtfZCaDJcGylzy
	mYaLEcykpyBdDf4ZD8J9PDAtCnsXHklHfHnAejcuOm6/qiG2OXVOuciLc5+r7CaFFp4tY//zC1s
	F10JDe36l2/oqZbg1NjIZULv4c6UoihMT/C6z9LVG3QA/IqY+zcg6RpZXbjznYLUyydQd1XFVXb
	YflDtdgXr7gpebuBjFwJ0p9f7GWlRg+sGz7UkrB5cGfy17ineatEZRvXj9Hy28VZVb5pclqWSb8
	+DnTLa7QUVKxZzFUx7duf5UudAwi/uo3EfAdYV0MDqV7uw8/NRwa85bYu3FlfVsBQ2Nzc64qzne
	KmRC5Br
X-Received: by 2002:a05:6a00:2d98:b0:82c:d7c4:4c57 with SMTP id d2e1a72fcca58-845507f9e1emr1032294b3a.19.1781824603136;
        Thu, 18 Jun 2026 16:16:43 -0700 (PDT)
Received: from thorfinn ([2401:4900:8836:4853:aa0f:55df:e7d8:852f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845537fa3e9sm225135b3a.39.2026.06.18.16.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 16:16:42 -0700 (PDT)
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
Subject: [PATCH 4/5] iio: adc: ti-adc161s626: log buffer setup failure in probe
Date: Fri, 19 Jun 2026 04:44:37 +0530
Message-ID: <20260618231543.413771-5-prashantrahul23@gmail.com>
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

