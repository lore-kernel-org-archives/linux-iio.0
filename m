Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E09357D18
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 04:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786681898; cv=none; b=pullpr9zzyJvEAcJpnNjwl9brUw/VQuDKh5RDNlycXZYWm4Ou8MfbJMTseG1SBLn5Lm+csO1XfITmb7rjRullhZTELpk61tR/p0Tci5AJxC7znVVUoaV9/vSZRXbm9dD6OWiAtWJknTUF75uMD6xsux/EAqISYRwdrdrKmQAUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786681898; c=relaxed/simple;
	bh=8tTN2YWDidBgtH90yYX7IX9VaZHEYI81ZwvokZk/tQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/Fj5Nl5YyNg1emfBpm2bPJTldVCo8myT42HS/8q/yrHkfiq6iWQpVyZREywdh++2MTxcns9c8bQGkfjzrRu7/xtGfFR8d39RsP0CrbCt1jqW0j1p6bGYmXm5pzh+4X3yfl3c/IgIfWfvQ+nxo8bh+7hFvxjnGvqNbLXXjvxx5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLazECS1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLazECS1"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d049069377so7130855ad.0
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 21:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786681896; x=1787286696; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SSZFZdRs0Q9xUsBAqsFjxC+3BHMpojfecr9pFfdVV8M=;
        b=fLazECS1sXInMLyWySMXyu5UbCJudHHM/BkxYjW4rIzxWFNPuM4T8Q93FVH/txbOyB
         +jFxLOokoEFkb4Dn+nZNVv0bqvaVz4sI8NOUqnQItFiu2LW/q1pnZ/pnx02wH11Ul0oQ
         XTDgU4m6bYKin6glwqsC8dewsoIY63e+84TsS4h5j6ERjYfXiqSdRScpqmjAErZXHFxG
         asCXIp+QD5yJUvU2mixcYFuJadcgYe5KAW4McFfNbvd6c3k6DrOl6YfiPxMsEH2bIvBc
         yfDJlzbGEsjIuW3MHV7Qv9sx4afHPU6nXrdkzAPbGve4n9IX30MUMv7Iwx8cYJKd0+oZ
         lesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786681896; x=1787286696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SSZFZdRs0Q9xUsBAqsFjxC+3BHMpojfecr9pFfdVV8M=;
        b=ORNeQ1tzjZJyKizgImBW1YHguqPIMxrUTAkTJTLcvV8H3uQG7WzJgoRJnqSpFatCFj
         BSqww6fNU2HUfoFgATGAzutmQW55Y1rArJqKtK210XWPCjXlVv4Dioavh+vHlyrPhCET
         SgSIfWQ8OzQ0eqV5nXtJTksIgLfEM8JtBvdjdsZpdFw5lBH05Sw50f/ONHVitvYTad1W
         igDvdzYP8UsBnNZJNlcPT0jIYO1yJIYRJCKnm6tD4KdFZDHDvE6U13sP6Hjn8/1op4D5
         jnUlhjRYudOcC3D2LC4p1urV9tcsRD/RcXPvMycvzj6mzDWynVU27pVGBesWW0wKtIw/
         HXlQ==
X-Gm-Message-State: AOJu0Yw5Yl5N9xXEg9mc/h74iZH3yO2ty9HZdZLA+LJVrUEmW/Zxo8w3
	17SYPg59b4OWaaLE5ZhyXPDT3lFAP3UoUl4GoTBH2X2plLHcV3AYcxOz
X-Gm-Gg: AR+sD13Tzck3VEy4BCZgkAH2trFuYjTA5izTCuxp+DhwKc3opP2v27Y47zDBbJbtdkm
	Qmq4WuFwCqQ8Eq7ENI14tOhJf/JzmKtqx9yPRczK+ivksTZ8mLj3h0LiGjI4jooEenFnIOJA8Hq
	ISWGL0zdm9tOYp3srea8EWvjXqfPZMHcjDRSS1YY4YqoNJzRfzOOhNj9FPR+xNC8FtMbVgRUt1B
	JSM0EeZMQ9DqEfy34nRwyU02YAUoWu9v5cyJ25bJ/9issRTCOW/fAbgTA6dhXE3bJ6od0Solnui
	Su0ambpW6qDrut2msizTypMQEuFDai7AsiPw+fStNtlpckiAHVlzpwFyBAZJyYfmZHjia4tAXK7
	QX0rlDykKKDIJZMghoXWSAmEddxNlXw19dxI0J6bQvWgNjtbR477r9jC46oy4/pmIKyGT3LaeSd
	jmQ7e1TFpV7206fJJbl8QaPznDxIIiiJ8Jg5CLubXzBVDRUIuxw76q27VsItWiohkyZHNohzNwb
	hqJAgi/QyO81Q23Xvs5y/tyj5/AWfz7GE5p0s+f
X-Received: by 2002:a05:6300:2289:b0:3cb:e8b4:f03b with SMTP id adf61e73a8af0-3cc71ca5ad5mr3339618637.17.1786681896264;
        Thu, 13 Aug 2026 21:31:36 -0700 (PDT)
Received: from [192.168.20.42] (115-70-157-242.ip4.superloop.au. [115.70.157.242])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413887ee65sm4238288c88.10.2026.08.13.21.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 21:31:35 -0700 (PDT)
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
X-Google-Original-From: Tsz Shan Chan <tchan@jacques.com.au>
Date: Fri, 14 Aug 2026 14:30:43 +1000
Subject: [PATCH v2 2/2] iio: light: vcnl4000: add shared IRQ support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-vcnl4000-v2-2-9b771290cc1d@jacques.com.au>
References: <20260814-vcnl4000-v2-0-9b771290cc1d@jacques.com.au>
In-Reply-To: <20260814-vcnl4000-v2-0-9b771290cc1d@jacques.com.au>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tsz Shan Chan <tchan@jacques.com.au>
X-Mailer: b4 0.14.3

The INT output of vcnl4010/4020 and vcnl4040/4200 is open drain active
low which can be shared with other devices.
Add IRQF_SHARED and switch the trigger type from IRQF_TRIGGER_FALLING to
IRQF_TRIGGER_LOW. Edge triggering can miss interrupts on a shared line.

Return IRQ_NONE from the irq handler when read fails or when none of the
interrupt source bits handled by the driver are set. This prevents
claiming interrupts from other devices on a shared line.

Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
---
 drivers/iio/light/vcnl4000.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 663e623da833..8a723eaadbb6 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1470,7 +1470,11 @@ static irqreturn_t vcnl4040_irq_thread(int irq, void *p)
 
 	ret = i2c_smbus_read_word_data(data->client, data->chip_spec->int_reg);
 	if (ret < 0)
-		return IRQ_HANDLED;
+		return IRQ_NONE;
+
+	if (!(ret & (VCNL4040_PS_IF_CLOSE | VCNL4040_PS_IF_AWAY |
+		     VCNL4040_ALS_FALLING | VCNL4040_ALS_RISING)))
+		return IRQ_NONE;
 
 	if (ret & VCNL4040_PS_IF_CLOSE) {
 		iio_push_event(indio_dev,
@@ -1526,7 +1530,10 @@ static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
 
 	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
 	if (ret < 0)
-		goto end;
+		return IRQ_NONE;
+
+	if (!(ret & (VCNL4010_INT_THR | VCNL4010_INT_DRDY)))
+		return IRQ_NONE;
 
 	isr = ret;
 
@@ -1558,7 +1565,6 @@ static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
 	if (isr & VCNL4010_INT_DRDY && iio_buffer_enabled(indio_dev))
 		iio_trigger_poll_nested(indio_dev->trig);
 
-end:
 	return IRQ_HANDLED;
 }
 
@@ -1981,8 +1987,8 @@ static int vcnl4000_probe(struct i2c_client *client)
 	if (client->irq && data->chip_spec->irq_thread) {
 		ret = devm_request_threaded_irq(dev, client->irq, NULL,
 						data->chip_spec->irq_thread,
-						IRQF_TRIGGER_FALLING |
-						IRQF_ONESHOT,
+						IRQF_TRIGGER_LOW |
+						IRQF_ONESHOT | IRQF_SHARED,
 						"vcnl4000_irq",
 						indio_dev);
 		if (ret < 0)

-- 
2.55.0

