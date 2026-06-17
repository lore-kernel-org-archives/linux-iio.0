Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017E3D301F
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683268; cv=none; b=Dx1QJF/5Vh64IU0FEsC6H8vAp45kPobfmoiIiM+ft0z+eTlnR19lq1wjzdhfMGK9UcnGJe6QESz2qLXCTlu7cYq1f4X4Y6TMOsUr4VzAzNhrToTNCFt3pFDI0PS/vNZCUbJHVUpAl3MD0/Y4Kpq6yZ491rNvpaFoaoKEvfjVMm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683268; c=relaxed/simple;
	bh=Gwi2SEZRxxZPvrxGh5xpiGuXapIPqlS3eMFp/EcaCRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sO0PbN/6ZMXQmb+FNdBWX6BOdUrgFGdWNQ7ybluK8lNgZ7+vUfz0bcRjnZJotXk0h5l/KVdTJjuYIYcf2EYDprz1UxhnvKzOu3JcZVOAFA5uK9pU2Gsg0x1qVrhgnJd+Dh+QlasNhyeqUImXCunkeJy07azooD3+je6rXfuuL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIQvHTqP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIQvHTqP"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bed2b9bfa02so707966266b.1
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 01:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781683257; x=1782288057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BStSfLs2cVd2uwZhDXiQO2uYMri4qNRZ0wt5dxl+TLw=;
        b=kIQvHTqPC5VkRUDrpLCtRDZpUvjzaV9nTZdILVN2cxG1d6Oyz9pmvLEnPozk2o1wZo
         h474uWl/pxK41XGij4r2JYew0UA6KoyoxQyE/39flbfeBxwMwXhYAEAHsyC3c9bNRhP1
         hRr3qJGbvH9zCnmKdb3R9hNRrpLxPW/VacDkgecOxXmZSBQ8kPoudHAR/EX9uG1CyiS6
         NJk6FGJaTTV2K/HnXKVsolYx0wJUUfT8zwDCCs+ywLPBRJoikv2gWxnYjkov7uKaoG1/
         hM5lhI8hzdqZfKo+c6549baqe6L7LV1jel4GgJ+pMV1Q2AF3z9JapDJG+5i7dDswNJkF
         cUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683257; x=1782288057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BStSfLs2cVd2uwZhDXiQO2uYMri4qNRZ0wt5dxl+TLw=;
        b=geEKBlVhUYSLjbNSx4FslR0qlunGih//dNhRzTXEVzzvDOBBK9qnn4vyjZy620rAWx
         SUI+2mF7JaTE1v5AFiXG5AIHERWqP+msFHklQTFomHvbinldmUzIDn8jJCse19o32P+p
         DRWk5GGoafeCIMue2B7TbYjMjJLtlmnKL5g80VQ25C81rFn8FZanjPyxGGqnk7m2Egfy
         VlITTtOj7BrYCISl9uP3tOWN521r928aGuzsQqle/94bJO4wAqIH2i5kjxnNN9zKkozO
         OnnDj6HaQwDA8tKgHhgZZHreL8EbOP7UR93c+sAQBu4mGEhydyk+0b9ySB35ul3eE7EN
         QEAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+i9NhVB4w2pV5oWKrpkhQGQCYzQjEQpGWSPnaZVwujvCyw1ff81/nFU9byBHiHf+E8MXuftKNkhD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YziNEvWQm1f2cbBwxZy5S4MQVHBeQHibJWPrMkD7s6uTQA5H3H5
	9eUCa2jmn4qNjWWddkYT2LBtoqV1tin2CLf9TpK5wz9XZkqPRU+NEo+k
X-Gm-Gg: AfdE7ckbQ1POTZH4jIH6Ks8k73JXuC9aPuBDWag3eKxUkjQ/8y5igOSUJmMT2bWWtO3
	CYrFGNYevV0NNt3PQiV1voidgEsy8zi5nCwM5zk7T6I9g0afRnOp5lPJeUy6cVjzUkopplho+5x
	EPeQ1iX5wcEE6PB/yoqT+JjmF/EZTlB3KDZ/eD98yVgBhz1C+wvRFCBwRJ+c/62XoGqNfV8UL14
	K4Bt9d9JryzfS5456HVFsFzuLi4OKoK3GdWLs8PexxS7OUiOmhTD61pN9RGgr/TQ82bHBT7a38U
	nYMH4tsy2TNVPddrO1jO6C1cactAMSkDcUINGEXuQfK76AKJ20yMIZYsiRqpF1cqI/4+HRBWjAR
	CPfNOHCOtWc2lYRCN/F7ejz0BBOWolzTAQ1goTFPUr/+MEQrUoYZM6J5+9AXNenrTFGhUK1R+IA
	bZ7A==
X-Received: by 2002:a17:907:928d:b0:bd5:405c:7964 with SMTP id a640c23a62f3a-c05a5219b56mr201079366b.48.1781683256443;
        Wed, 17 Jun 2026 01:00:56 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:00:56 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v5 10/14] mfd: lm3533: Set DMA mask
Date: Wed, 17 Jun 2026 11:00:27 +0300
Message-ID: <20260617080031.99156-11-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617080031.99156-1-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Missing coherent_dma_mask assigning triggers the following warning in
dmesg:

[    3.287872] platform lm3533-backlight.0: DMA mask not set

Since this warning might be elevated to an error in the future, set
coherent_dma_mask to zero because both the core and cells do not utilize
DMA.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 4b5d94e9ed27..db8581d1b073 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -480,6 +480,10 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 				   LM3533_BOOST_FREQ_MAX);
 	lm3533->boost_freq = lm3533->boost_freq / (500 * KILO) - 1;
 
+	/* LM3533 and child devices do not use DMA */
+	i2c->dev.coherent_dma_mask = 0;
+	i2c->dev.dma_mask = &i2c->dev.coherent_dma_mask;
+
 	return lm3533_device_init(lm3533);
 }
 
-- 
2.53.0

