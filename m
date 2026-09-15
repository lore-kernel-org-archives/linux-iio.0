Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C71D3976BA
	for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459229; cv=none; b=WicGfdFV9mFTlkFCZWg4FiQu4gLI8mOuMScH7GDyt7PnF5uE3wjqfgppMLMvdf7ZT2AHZhyHim0+wSHy4mOJ4Q+fhp8d6aPoZnzqEZ+f5R4vH0iqoIOWjUlsvzgPb2ro/oh6eeaQzmlCARFYLus3lyt39hmsvj7kdLUhxgdjVPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459229; c=relaxed/simple;
	bh=WWVcE57q2ujxsqolRC6ZoeQXUL6FEoBX5JlOVLcjvtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PC7/aI39xjt2SI6zsP2Uk070qFTnT2W4W/IU+e039FIB4pLHHVFWpfYMhZD32IW+gXrilY3fRVCyOgnYnNpYX+vkx7cGbJEypYuC9krBvKjye3+X5nPOoz8pVW1j1RdHF0ZbbMCdjh7PcrgdkC4vqIpG1ylIy8zTzxa+WCymBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzgKwrAu; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzgKwrAu"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so17467875e9.1
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 01:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789459226; x=1790064026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tXRYdo/Nw5o2tKXlPYpP0Bk1aAxSCNWraHSi1/LMRzI=;
        b=lzgKwrAua4xl0jKelAbKACV3Xjh+Jd86lqADk257AzRDxxb3cpQsEPMQmGmI+SsvgK
         9dSAHb/wT/WKjYGx3XGb8ItXaquEMVx4o1KvHL6KqfGOuEMfXTmgw7yVggMfh6LwSdKf
         8PEH/fOfFcuwAWZci9YXJpxjRvfQktOFqaLKBwaxaWheGy4odV8//UB4Nj9MsxJpO24o
         /sT5yrI1NASE5aIbPOIeqiWKOlB/Q/eF+cOldEhGD3BdzFVzC/zTEJXeysmcqaRSMfE+
         4BCchiqndVqlGJOqMGlrnhWxv8ujwMDfuM24sDgTAC3yLzYbxrFULgGVDQwKPcablQX2
         1Ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789459226; x=1790064026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tXRYdo/Nw5o2tKXlPYpP0Bk1aAxSCNWraHSi1/LMRzI=;
        b=1b4N/YckHUAIepHOYksn8025V60r523dAfFaObKP+UoowyAtyOTUst5K6iCZYSwOHI
         W2eG9+fiHBRgTAZcZtBqCA/Z9WZpyqPVxWeaBWEb63D7kGGE6OLd5lh0r1R9XkB0GTfL
         +XBvV37RXyEWDBGHPSs2Dq4OTJjSiA8E+JkZZ5SSgcqwES4jtkruhoD389WseFibRw66
         CL8lhNnnuTJDl9Jvcd/xmjRsJoAFvUpkPKpIINGw2KlTqML8Q+2ZGVFpuMPo7Ad3jKju
         3lDNKtikfkyF4zRG7QZTgzh6wV7dLhG+L0wAXWucOxi3GuctIlHeR/m9MPT7cOJdKTZc
         242Q==
X-Forwarded-Encrypted: i=1; AKwUvByshlJgiGeb6K24JbVGlfnebFHb7QFOxF4DVTJ3AuRmBfgM6elL0Lhe2o0pVnuvsJx4EqvkYUK6lqU=@vger.kernel.org
X-Gm-Message-State: AFuF++nyEHN7ZWO/oe1pEcqs3X0ziTeW6yj8h6jVaLzQafxP6iikZzjz
	yzXFX6ghZYCbKBxpJx+jtdKMMqUA31nWFJWfGxgkysbkPGAQhMraKKl5
X-Gm-Gg: AYBFou2tepsnYN0e+rG+8giKofp+vT611Mgp6cTQrLPS7rcFZGUnTs0GjfQy9mu5qOQ
	gMcE2Ne/mbOneprCAEbeWqsQUbS0XFzYrdvtwfgrcWFv/VuyyoEM2gxhUSpdaxvM5Exe2hoF3XP
	pAWQeYaKpBmp35Z0wMM6hz062lxoh2Dl+5P9aHHMHvzv0hCu0Fpd2oHwCrBugGyJzNXLK9ev2d2
	ZPj3wcu2jPIlQlEJ7Yaz87rW0GeYPj4NIZ7kdTzCKB+YaRiyhtwHqcwJWqtBN0yNjTNDi5+n7JD
	SCk2uUiT/bBqSjiTHOpOlJ1fDNHJpWpvuPxKImVPZmplrxWitVuZ2pGUF1XCXLtrvDNJ0wc7Yib
	Q1RbyRtj9vqXTS3hv3MH0SRWIZvigWEv78TeD1z6qumyk/iT5BbmYXRi63Vx9s7E7z+YhKEPl7Y
	hCTKN4hKMGG34adBoNP7O4NVHagG+KnkzLKg4l3TQk+MGE6lUWyzJJb0owmugxtmcl4oJnropuM
	lEBcSmGNMZ7ZoTtkB+HBnajrCXNNA==
X-Received: by 2002:a05:600c:8716:b0:49e:6692:27fd with SMTP id 5b1f17b1804b1-49e7a657f9dmr165235115e9.2.1789459221055;
        Tue, 15 Sep 2026 01:00:21 -0700 (PDT)
Received: from fedora ([154.182.99.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d6bf4desm64112155e9.15.2026.09.15.01.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:00:20 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v7 2/3] staging: iio: adc: ad7816: Serialize SPI operations
Date: Tue, 15 Sep 2026 10:59:38 +0300
Message-ID: <20260915075939.18180-3-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260915075939.18180-1-abdelnasserhussein11@gmail.com>
References: <20260915075939.18180-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ad7816_spi_read() and ad7816_spi_write() functions perform a
sequence of GPIO state changes followed by an SPI transfer. If multiple
operations occur simultaneously, the GPIO state could be changed by one
thread while another is in the middle of a transfer, leading to a race
condition.

Introduce a mutex to serialize the operations, ensuring that the GPIO
toggling and the SPI transfer are treated as a single atomic operation.
The mutex is placed right after the pointers in the device state
structure to avoid padding holes.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 9e43ce83e071..c18093ca8a82 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -5,12 +5,14 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
@@ -47,6 +49,7 @@ struct ad7816_chip_info {
 	struct gpio_desc *rdwr_pin;
 	struct gpio_desc *convert_pin;
 	struct gpio_desc *busy_pin;
+	struct mutex lock; /* protect device state during SPI transfers */
 	u8  oti_data[AD7816_CS_MAX + 1];
 	u8  channel_id;	/* 0 always be temperature */
 	u8  mode;
@@ -67,6 +70,8 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 	int ret;
 	__be16 buf;
 
+	guard(mutex)(&chip->lock);
+
 	gpiod_set_value(chip->rdwr_pin, 1);
 	gpiod_set_value(chip->rdwr_pin, 0);
 	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
@@ -107,6 +112,8 @@ static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
 	struct spi_device *spi_dev = chip->spi_dev;
 	int ret;
 
+	guard(mutex)(&chip->lock);
+
 	gpiod_set_value(chip->rdwr_pin, 1);
 	gpiod_set_value(chip->rdwr_pin, 0);
 	ret = spi_write(spi_dev, &data, sizeof(data));
@@ -360,6 +367,10 @@ static int ad7816_probe(struct spi_device *spi_dev)
 		return -ENOMEM;
 	chip = iio_priv(indio_dev);
 
+	ret = devm_mutex_init(&spi_dev->dev, &chip->lock);
+	if (ret)
+		return ret;
+
 	chip->spi_dev = spi_dev;
 	for (i = 0; i <= AD7816_CS_MAX; i++)
 		chip->oti_data[i] = 203;
-- 
2.54.0

