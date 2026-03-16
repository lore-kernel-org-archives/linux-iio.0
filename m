Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB69329E44
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682122; cv=none; b=bf8qqe+awOCirNae9SDaVH50t4Iqd0mnyEK51NtdgVb0zH2FYXdCZmUqpsaclogDjYGPO0xaBeO99YUDWW2Efr4hIP8Q1D2F8EnRM1V1cx8prJIPGs066BhKNPdeRecAs90bdtzDQtu5gX+xJL+Ic3sIi1a7Ou/ILZi1bPvjSc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682122; c=relaxed/simple;
	bh=jusAWDD/dCvVFHlaRwClIg0xBgPydnyMki++a81hXC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDLKLC/ql73hUuOvbdGEwOOoZymvCNBFqsZsxk6VF7M8+nEYkIZkMhy9tvK7IF9UumoJ0wSWwmPhlydSykVkprDpVAmasl1roZbL9L3g8vwEqOkMghnvtWRzqjzDNiswrjeWxHKQ6W3cJWPRENw/QWl5nOWlul7/3uGqJGIu5mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWFL4fa1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWFL4fa1"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-829a27414a3so2898017b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773682121; x=1774286921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9t8K/5F6ETm5bz9GgqOFGirePxN7gXdE8nQoem0lgNA=;
        b=QWFL4fa1uNl7rqpd2TGqbvByTTQra7h2g1eYAwi1w9uJkY5/ExG3UyBHjAsMQf+r62
         xcTO70M0hHq5o9/yA7IxmUFYZGugdZ9pm10iGwkDvSeGhDmaE7PIcLQFBzn3LM5yISlk
         cZuIQ2HjJM9BIsYbGa1YG2stBoeGsmZ0MAZ8xuTXBGly9MorxXyn3A93vCxfIenp5m8e
         ymw/dDuTfACJdie62/+I+LR355Vten1bLOt6ZHk1bRonBjJQPP9ptoS2YF7oMwflufNk
         mi10CtA9Fz91FeuNWM52rPCpnJiQmTaSWbHau+w41glF+mEAOT9pv8dbHXEI4kl60OdC
         TdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773682121; x=1774286921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9t8K/5F6ETm5bz9GgqOFGirePxN7gXdE8nQoem0lgNA=;
        b=TR7RmHG1g1ENQ7OUUXZ/ZkIOgzuBClDQXKVyyIfTzXpbNq0f4DFZLslAR/vaJ/xlM/
         dJjGCfx5vjkLb6ngl7O1lB/86KnwRUymh7hxIzOtIzoXWwPy0Pj68DeI8BeyY3mBTEBC
         4I/1hthU/yJyiqBuYP2w5SdCZIH7Ei5LVIZZt3XX22gpRuouuRodfWspMgda5gLQuiHY
         9P1j99fWvFA3OCArPXj6t3bY4Yf5qgVI9Mfu9szPdPwV5vspzKr+tBGlAzf4lrT1D+TG
         GNdOFXriZt7smS+LDDio/O+NZ37mUqUaLAkCiEOiNvhueCBHJnkyreAXTnE7ZR2VJp02
         pPdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjXrX1TP7H6KA4PKgUVeaXX0lZO+X0xoeeIYltCyWnAZpJBWvKVtM+9BYFH+0668CXU79A/915u9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoSIOtDY4Tsuc6vmTOSbDXKOjT5w7ANim+u06IdjoJvbYibyDN
	6QCnc/MDffAApSInBo6b1RzN80NomevCXuh7FWk3EsWsABXYw9OFW/7B
X-Gm-Gg: ATEYQzwkyKzvlXSPLTJZaCaCmBmu9p7Eq530FRpLbDxrdInhvPgRUBFPXI9S/L0/sbs
	zO6htw94vLmCBV3DZUqlyFHNWBRcRODQl4hwjlwxLG2kJ5YAlp5kRMIa98U0REM3f3UMMw7vBro
	tcqhgqG5WL83iI2h93ZIuQMCW0E0EU4xR13z55+4kk9MVg0RhA3PSSU/FqvGxd1Gzkav6iZ5VJA
	vzqea0KgZG5WY+jeyOCdWnsarfCiDaK+iLmRkus03SSN0W7kC0WBT+WA3+blLa/yZ/oUf18/olH
	Bw/jloZJBvUeoGunWQM9Tb19vev8fUHg0hOxy6A+pb4GNwIjM1gP36M1UrzEH/rkhG8zI956s4x
	x9uJ8TGMdo8tezBtNUyPcGH3efGbz+6xk7C+BrAezQu49LnVYXRxUIlPWK0Q7kzcsua+gNBAciQ
	zewJDMvwq9BpAC93swZVMgUsjmEAKyASq7UXpBkYnKl6ihiWgOjPbTTK6PVB79t0zfmMPZiljAh
	GsU
X-Received: by 2002:a05:6a00:1a8b:b0:822:682d:2c5f with SMTP id d2e1a72fcca58-82a1970a57emr11004929b3a.28.1773682120884;
        Mon, 16 Mar 2026 10:28:40 -0700 (PDT)
Received: from atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx.. ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07341986sm14016183b3a.32.2026.03.16.10.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:28:40 -0700 (PDT)
From: Atharv Dubey <atharvd440@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atharv Dubey <atharvd440@gmail.com>
Subject: [PATCH 05/11] iio: adc : ad7887 : replace deprecated iio_push_to_buffers_with_timestamp()
Date: Mon, 16 Mar 2026 22:57:31 +0530
Message-ID: <20260316172735.11430-7-atharvd440@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316172735.11430-1-atharvd440@gmail.com>
References: <20260316172735.11430-1-atharvd440@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iio_push_to_buffers_with_timestamp() is deprecated. Replace it with
iio_push_to_buffers_with_ts(), which takes the buffer size as an
argument and helps avoid potential buffer overflows.

Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
---
 drivers/iio/adc/ad7887.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 87ff95643794..dfc8b1f71c86 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -119,8 +119,8 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 	if (b_sent)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
-		iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, st->data,
+		sizeof(st->data), iio_get_time_ns(indio_dev));
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.43.0

