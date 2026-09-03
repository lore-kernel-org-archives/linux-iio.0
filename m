Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833893876B3
	for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2026 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411274; cv=none; b=WH2u2xoIm3B+7ymWr/zXxw7+9Zng+w7pWhN79yg62SnyLogmJ6cnVy+aByLrwWBgT2vUhxbckw0Nh7ni0ymPoB5f8GfnG5lVkYtKWzzaf8DArKDxrJLivlmCt2yAM1rX/W1Z0EXSEHcwbj/R/MF9nR4Yi41aGKzGENkgnElM56M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411274; c=relaxed/simple;
	bh=+OR1gTWNrzIqf2xISmhfp+s65tbaKQebpLjqZ8qvz7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWJZWGQoSiEcVQrHPv5AmsjkWftbN4wFNV5kBXsX2CybVQjbS/O5M0K2DATnzrkPFcSsMnYxagHrFC6rWsxoKzeuJYn/KeNGd1XyXwJ/DZ6dJPAyRPaUzLWaxZOrMPPV3N5JLCHim5iFA23SSSq3Aai4ZzieZnfHycnFUAwJyHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeszYdF5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeszYdF5"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-39682983a0fso2496166a91.3
        for <linux-iio@vger.kernel.org>; Wed, 02 Sep 2026 21:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788411273; x=1789016073; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Xrkf+M7d/buQlEiH9zes2PfuHopkhsev9Nl4qDT6q8=;
        b=aeszYdF5zN9myhXKyD64ceUy5VOAs1Zj4Dpcvvn1oyWymgj3HtU6MhTDn0YZmmOVVO
         2PirmwuvcC29z7xwOnUvqDlEZ7rXOJuTq/Ngf5xY4hGb4otMK6V+8Vl1OWpqLtXsCDAJ
         BVZKQLJ5s042evNClEGPMVquawI3voDFr5D8NVv0BVQ+5YGacexPXGoIg70zyb4w2YPX
         pYqTiDLkN4yYofIPs3qSFhikFQuWsGGpNlQwHTi+3TbDLUDh9lZ8QtKca6Eie2q3IPHm
         gZU++9B0Ws0NsMy03xi2qVIAZQDNlfDOyv1pzthaS9fF5ShkVtHEZK2MnrModCmeOTVE
         FlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788411273; x=1789016073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Xrkf+M7d/buQlEiH9zes2PfuHopkhsev9Nl4qDT6q8=;
        b=oggipIVHMpLFtWORucJtm23azAbh5pVFAEvIRRZqbPFf07ITHGvGJcknoIwQ7TX/S4
         iVG/mG5CimxzVd47gv5ERobt8XRqZPj87VqMrd9LzHoRQR74++YCDDkTTgd/1taBVAHB
         YnQQVdEkY3kkhvpHLdFPAOSgq91KjFdxKjOlg0JUCRqx5gPLU5y9tPkXXcqw3XirKGrV
         OBLoVySS16uw1zdvE0BbXgf4dQn2mqqcWWBmBmtHFsZxEgo+5NnUHCahW29vt5HD90Re
         My/WM1aA9u6qoqOKSGQCVOeiYtjtm9w1+oEmHnFCLXZuSj3coP37QdHDiYDs26Q4nul4
         aftg==
X-Gm-Message-State: AFuF++kPlVXHVZyl+wAHXWsTQLNsrh3ojYWPVC5/ZwxCaMaOgmZ72Ua3
	1bHQsgOG4b37Td0i8sOXnYeJHTL1Ap7cECiPeDs8tP92K0sVE45LdvmA
X-Gm-Gg: AYBFou0OggR2CkV55KtrYVaUhHb/Sp1Ey5/HYtm3lU038u+1WTaUNg4LH/AkJHDEYHp
	P1iFaOW5ebzQEncQ7vZCc4vkjNU16SIC1rWWxqA6PsbBqwGkuh6jw+eGP7T50wLr5TPht4cX0LH
	TGbnOwFbcMfWbHy8AWrJE9lUZKe+dcD/mMMw3Tl46OpMF961I3/Rq6Ayv8eAAzFZfkPdcZT4dMr
	++MC34qQNsZCLJ9xYYSr491eWVZqzMAQJRQVctUcheye24LeUf9yjF0LzssMHRIjQ/6OgRWqABB
	vG+auFjTr0rSeRPNhc9VDA17luDQqrN+bObkKeEd4pzG6yJIZBzeRC/+cqLD43QxCM9Md8oEBnU
	RQyt7zDyKk1kn2r+ZXrtJSzaPuL215u73PUcA9ug3CQ5xH+m6UJYmYD5HdS24OCkfO1T6uCzFM2
	lm3AVLiesjij60Edf6ZBOmWeWb38Imx7lSdmEQAgbJg1suDAakOYEqK0PuyyH+92wRGA==
X-Received: by 2002:a17:90b:4c0b:b0:398:9bd5:490e with SMTP id 98e67ed59e1d1-39aee1427e6mr14134517a91.21.1788411272765;
        Wed, 02 Sep 2026 21:54:32 -0700 (PDT)
Received: from [192.168.20.42] ([115.70.157.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8f1cf6dsm2300801a91.3.2026.09.02.21.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 21:54:32 -0700 (PDT)
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
X-Google-Original-From: Tsz Shan Chan <tchan@jacques.com.au>
Date: Thu, 03 Sep 2026 14:53:50 +1000
Subject: [PATCH v3 5/5] iio: light: vcnl4000: add shared IRQ support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-vcnl4000-v3-5-5e69c2e715a8@jacques.com.au>
References: <20260903-vcnl4000-v3-0-5e69c2e715a8@jacques.com.au>
In-Reply-To: <20260903-vcnl4000-v3-0-5e69c2e715a8@jacques.com.au>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tsz Shan Chan <tchan@jacques.com.au>
X-Mailer: b4 0.14.3

Change the interrupt trigger to IRQF_TRIGGER_LOW and add IRQF_SHARED to
allow the sensor to share an interrupt line.

Return IRQ_NONE from the irq handler when read fails or when none of the
interrupt source bits handled by the driver are set. This prevents
claiming interrupts from other devices on a shared line.

The datasheets confirm that the INT pin is open drain active low, and
the interrupts are latched:
- vcnl4010/4020: The INT pin is open drain. It is pulled low
  while a status bit is 1, and it stays low until the driver writes
  a 1 to clear it.
- vcnl4040/4200: The INT pin is pulled low when a flag triggers. It
  resets to high only after the driver reads the INT_Flag register.

Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
---
 drivers/iio/light/vcnl4000.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index df929eab2bef..9855c2954429 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1517,7 +1517,11 @@ static irqreturn_t vcnl4040_irq_thread(int irq, void *p)
 
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
@@ -1573,7 +1577,10 @@ static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
 
 	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
 	if (ret < 0)
-		goto end;
+		return IRQ_NONE;
+
+	if (!(ret & (VCNL4010_INT_THR | VCNL4010_INT_DRDY)))
+		return IRQ_NONE;
 
 	isr = ret;
 
@@ -1610,7 +1617,6 @@ static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
 						  isr & VCNL4010_INT_DRDY);
 	}
 
-end:
 	return IRQ_HANDLED;
 }
 
@@ -2047,8 +2053,8 @@ static int vcnl4000_probe(struct i2c_client *client)
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

