Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1036D3D5255
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164939; cv=none; b=JdumxRDnlX8qzIBi6R+JPEskkbuBAVov2zFVruGAa3cysjKAZ9zNcAOiWeESMHT/JERU1GfDsmf9vj8+Csx15D7CKcGR+AYxU9Xf0NL29cvePT1MZcPlUWqV5rqUDueY5AUqLYZkMP59ioqDa/lEbcwLl557mqsI7GNNP21FU9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164939; c=relaxed/simple;
	bh=RwbHXRCoVmTWoeGYZD5/ykMLkxfjTwmcVo/8jjaLucI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bV2FW4OXm2MJydt/bJSbHd9KCKyMvvEXzRNL0EF4odbIKLiFfOid3Pu4G6oKvq/EOUMa+9d7EpVIi6HMq7yplbP3jk8Dd2Mj1ind5QXNqR3DgOGZPoH1xXHYtPYY4AbE48rUNLdq4zNYsEpvFrrWrN3GX5lN/gsjEfBOexlhUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MP1ZjwMk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MP1ZjwMk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso38756425e9.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 10:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773164934; x=1773769734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3ExWVYtTjOCeiXkdLArD0AHGSvrIoXmw1MBLiE6OHE=;
        b=MP1ZjwMkLhpKIMrUsE5TyKhpzwzbxU83503eEVGKSuaap6BuyNhsKSkK8dwQlSf9lz
         DI3unISjDRHmXaBp0HqSDvM7Jdp7QG3zCXDD4331upsEMQcp1PoNbXof1yXVao80p7o1
         970IiIfiwxxoYHvCCTJG/67NySbpAB45ZwHljGoaT72BM7ZLiPlsJe9tdlO4LbAIOsiT
         jDQUNPf695acW8LLfE79z/6JKYO5rFKpPvJVbC0t55aRqBytMmiBTM/c0TW6IoBRBAJO
         5ROKZ481TRJ8+5K7eerHRgZCUJ30C8MZKICIxYD5xoBeoT82SkVHKaPx1nksXe54diTa
         dvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773164934; x=1773769734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q3ExWVYtTjOCeiXkdLArD0AHGSvrIoXmw1MBLiE6OHE=;
        b=g7P8Ia8xb2Jqe+VJFXNBr5bx6+bp+C4BCvFT6BHYJ06oqS4vld+wmYYJ94jaK2zeP4
         QjT2p6h60g9Ptmy9qZPrAeLBM8Dqm5zCjt1D6Yc8fuY1Bmq+QLO6FgJrJKb6Z6H30Cb3
         7+YMan1ikQRGBsNSfYoBndwxXtmjmlWOCmWPyA/DlOX6w5S1GOqzr0ROb2c2FRoIXjfm
         Dc4jTD8wnDqXlj1ctJ5YYRtd9qV3S49TX6smsmv1IoJy20y0Mb+AnQQr06BleQPiuLCY
         pG3+fM7ZxVtFqhQLzUXO9aHSFASSl8Wcd00QBJKZrrPONpcCoYBgInlxT15xczYGxfhS
         Vizw==
X-Forwarded-Encrypted: i=1; AJvYcCVeu8SvB+XoB4XjsCW4gqy15RaWwl2ZGtzKyThNp1/UGoLzqOQN65NRk897pC8FDbmT5w+UY6xabmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQqRwJsiTKY4Cy6NwmNhJQH+aEPkY0NEBGroF3kJr3raLXa46C
	gkdi+/Z6+R3BOIxJGC657K5xmXkBHO+jF7b1jICnQZ9OJ7VmWpZCVYyi
X-Gm-Gg: ATEYQzzEA1ESkK/eUOPr49XoH6ymQn7d+sUyxkVLapE8HDYnGFWZXBCYDeru74qzlGd
	VBqG6VYORJJMm3ckEvkHR8bCBK7IO4tlM7inVEy6e4S/oV+XJq88RWAP5S007WF//32LU2tXKWV
	2PRYnB1z4BLXXEL7Hy39t7sYOyiijSFTrlC5O/ctBAS28hVOSHfAzR2OiwgFoYQWG0vRJo2nTn+
	ZWoZ1iwyYA6M6cvztHCyEWpegyOvySJLqCl6q7T30s+IMLMC4w2EX1aNVKmrjk2BrOvzY3DOQXn
	7SyttVIzNA1H5NRnZdVvmKvE0hICl42S260qM/XScm3JOM4MH3ZvN2jWAQ+Cbr6NgtAcFLwOI2D
	jT/s7SxSlY/2h21zMLChyJR3RP3XRPmCahOZhgxQajUO3htYnzhDzmQTnGRRfAOREqOqjl7BjuJ
	yHZ9dR9JvuUx5s86OZKR/kmoP0pifyhck2+y2bsBnYy7d3Pro28gVigU9akA==
X-Received: by 2002:a05:6000:2881:b0:437:711c:8754 with SMTP id ffacd0b85a97d-439da55541cmr29415959f8f.7.1773164933500;
        Tue, 10 Mar 2026 10:48:53 -0700 (PDT)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae45786sm42986166f8f.32.2026.03.10.10.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:48:52 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v2 5/5] iio: dac: ad5504: add optional GPIO control for CLR and LDAC
Date: Tue, 10 Mar 2026 17:48:35 +0000
Message-ID: <20260310174835.24209-6-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310174835.24209-1-0rayn.dev@gmail.com>
References: <20260310174835.24209-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the optional 'clear-gpios' and 'ldac-gpios' properties
defined in the device tree bindings.

Use devm_gpiod_get_optional() with GPIOD_OUT_LOW to ensure the pins are
initialized to their inactive state.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index cd563460fc0a..58538f5263fc 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -7,7 +7,9 @@
 
 #include <linux/bits.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
@@ -48,6 +50,8 @@
  * @vref_mv:		actual reference voltage used
  * @pwr_down_mask:	power down mask
  * @pwr_down_mode:	current power down mode
+ * @gpio_clear:	GPIO descriptor for the /CLR pin
+ * @gpio_ldac:		GPIO descriptor for the /LDAC pin
  * @data:		transfer buffer
  */
 struct ad5504_state {
@@ -56,6 +60,8 @@ struct ad5504_state {
 	unsigned short			vref_mv;
 	unsigned			pwr_down_mask;
 	unsigned			pwr_down_mode;
+	struct gpio_desc		*gpio_clear;
+	struct gpio_desc		*gpio_ldac;
 
 	__be16				data[2] __aligned(IIO_DMA_MINALIGN);
 };
@@ -299,6 +305,14 @@ static int ad5504_probe(struct spi_device *spi)
 	if (pdata && pdata->vref_mv)
 		st->vref_mv = pdata->vref_mv;
 
+	st->gpio_clear = devm_gpiod_get_optional(dev, "clear", GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_clear))
+		return PTR_ERR(st->gpio_clear);
+
+	st->gpio_ldac = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_ldac))
+		return PTR_ERR(st->gpio_ldac);
+
 	st->spi = spi;
 	indio_dev->name = spi_get_device_id(st->spi)->name;
 	indio_dev->info = &ad5504_info;
-- 
2.47.3

