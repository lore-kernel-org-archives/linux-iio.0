Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6727F36895F
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124240; cv=none; b=BhSjLlbz+tF6sRZ68S9Imj4r4CS3KUUf647f2B+uW5D5cohd0KIFCcV2xEHoK3WUFTe2rGc0HELSPqjCDnzWaFcB5AqRaf3oWp7waH5p6oJL1Fyp1fcPEUbiMZTC2IpjnRrF4XGY2/PDkpu5QBKnvkY0cHY0tmzLDhEROqdMGiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124240; c=relaxed/simple;
	bh=bVzUIf0vDumSqfzAvMw34LiV1trSBAWr8LifxdiecRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zjr0Xy7KZ+xS7pOsHnUxfundl69oV9OXO5Fmsun55kEhongUOHwNFkdMqEXBmoopNcG4RisXb8LvFVbuXBueZyqMb/w+1j2M/iaSbz6KSJv7Wf9n7aZfG7Ie/KPTfHQTwWeVgAJ/zvdXE/g9muYC9IZscl5yTi9se84qjhjsjvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/HAd4Lw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/HAd4Lw"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a962230847so10333575ad.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 08:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772124238; x=1772729038; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jmkHW0X9WlzYxdcGY/O8+LzsHyuZnIHd7V90obvknNc=;
        b=e/HAd4LwyyvIGH3YNbA8Uy86Nog545cyr7CBOe9vojb053Yelzwjy5sygdbPOM7sWv
         hCreKzo7OMj8bpkXYm+C5pSpcMNfhuDGFZRybYfh7m56Z/FHZUYMCXZCyLkXDXoG3xnR
         jIAJhmrR5m6wM5WYhAvsg8wj2FgCrVKToINzLi6YH/Fw54Jr5V20ODgqTl0myB/d2UwN
         Ar1NIqzruSsKBMxyjF05Xs8K3RUy683Z8upqRV2OlCfySWV+oI1zsneVqAY3XlI97J9b
         UmDGqUTS1yrgZt+ZGLgO3CScDP4GixiMQcQKviRIf/lRxIuccxOXeZie/sSrsJqiN3sf
         Yt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772124238; x=1772729038;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmkHW0X9WlzYxdcGY/O8+LzsHyuZnIHd7V90obvknNc=;
        b=Ibm282bleM9KnqaPRcMhTX/CFLeZ2ZN8nOhZwKxneUTTjq8EhlqWOgWc/ouq5PnHze
         LsDW7qRmzfDk1iMceHyPcoiAo9G5DpksCkjecIVy4+X8/guG0ibdyQqR/BUAYuxhLBrr
         JMrrQsTTyc+FWjm098AUvskZAhPoGXdEDVoh5XfSZ71V3Cy8oz6MHcnxgTN3CKsztM7S
         sM7AROWmpOG4wWIf2tyjYr2AwUoDxvdzy04fA0007MzrRViTwt818ro6zSXiACKrqR5y
         qj+XDI+QKcprUM3GXHEt7NdA8YvxSjdDwHtU51NwG/rMvavSuEqIW/ENxZAFOguswssy
         fouA==
X-Forwarded-Encrypted: i=1; AJvYcCXwqhXooYYJbm4VmEk9lCU8z99kCmTDdvxUKhcdB6/pX2Gll7cW163Si/DyqdwiiQulnO6caTi0+Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySbSN4lXhL/nu+kRucS0CTrh5doM0V7xvKBMOE7kW7EcbnLAu2
	u7RKCyvVDcG0B9uejvvHRlDk9v8o8EXenSfQnd63gLOMvblOLKN5EwLA
X-Gm-Gg: ATEYQzxTY+nkoui51Mj4r0TSh5XZBvpr6iJTlDObqERekeDeSomK7aMfDJx5VxQJf2h
	cGpdjQTi/CRf5Wpetr34mYjhi454LB4Euccs6h1JsBCe9jQlw68A85w4TVgcG9s3l9syUntkgy9
	rWIwjLhF1PRCSDJ+FcqfowDztYeSX0s3HkPq/njvW7mE2iE5jHQC9hNlml0itrwD9ijhCnelZ4O
	rV6vcvcHzhZzWggg8XfUKqjfYX9964KJ8l7alrvcsbs6ME/i2OtMbRduDeDIBul9OUShazKOwqg
	9m+bLFdGPn4RMfpdpCAOjSdxqTNENCq/dH95/104RnYTwUgooSmXe3TbrKu9/CnW4JEmhi+DrHE
	zQtcT2YmChiLFBbLTVXYmfV/SzqOlpHZq9IulBL4m5Ps3iZuMZOf8BfN8aYqGj/J5YoOc+tZN1G
	7T2ZFLhXC7i6px1WSp5sMJH0BDmtsI7DmQXXE=
X-Received: by 2002:a17:902:da8e:b0:2a0:c5a6:c8df with SMTP id d9443c01a7336-2ae030521camr26876525ad.21.1772124237645;
        Thu, 26 Feb 2026 08:43:57 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:5925:5b4a:a4af:8ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b2309sm31066945ad.19.2026.02.26.08.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 08:43:57 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Fri, 27 Feb 2026 00:43:51 +0800
Subject: [PATCH] iio: pressure: abp2030pa: Replace IRQF_ONESHOT with
 IRQF_NO_THREAD
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-abp-v1-1-b6fed0545852@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEZ4oGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyNz3cSkAl0DQ7NEAwPzxCQLQ3MloMqCotS0zAqwKdGxtbUAGYnqJFU
 AAAA=
X-Change-ID: 20260227-abp-016a007ab817
To: Petre Rodan <petre.rodan@subdimension.ro>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772124234; l=1220;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=bVzUIf0vDumSqfzAvMw34LiV1trSBAWr8LifxdiecRU=;
 b=wQxuGJzUxGbasqol8SzsbwISlzFDy4bajvkF9Xp+j5gloBqgh/ZYCQ/Yap7//doBNAyaokeFo
 B8xa4qdW0/cAfghiiBsPBFId8m+1hERfgzGUqsQYac3LXrsppd6GQt0
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Since commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT
without a threaded handler"), the IRQ core checks IRQF_ONESHOT flag
in IRQ request and gives a warning if there is no threaded handler.

Replace IRQF_ONESHOT with IRQF_NO_THREAD.

Fixes: 47d323ce1e89 ("iio: pressure: add Honeywell ABP2 driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/iio/pressure/abp2030pa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/abp2030pa.c b/drivers/iio/pressure/abp2030pa.c
index 4ca056a73cef..858e13e02bb4 100644
--- a/drivers/iio/pressure/abp2030pa.c
+++ b/drivers/iio/pressure/abp2030pa.c
@@ -520,7 +520,7 @@ int abp2_common_probe(struct device *dev, const struct abp2_ops *ops, int irq)
 	data->p_offset = div_s64(odelta * data->pmin, pdelta) - data->outmin;
 
 	if (data->irq > 0) {
-		ret = devm_request_irq(dev, irq, abp2_eoc_handler, IRQF_ONESHOT,
+		ret = devm_request_irq(dev, irq, abp2_eoc_handler, IRQF_NO_THREAD,
 				       dev_name(dev), data);
 		if (ret)
 			return ret;

---
base-commit: 7d6661873f6b54c75195780a40d66bad3d482d8f
change-id: 20260227-abp-016a007ab817

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

