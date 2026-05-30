Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992B4348452
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780111227; cv=none; b=K/NLym4aCFDC15NlC8UdFOOz0lDRhwlpyRCgrVN0BwszcOnB7LB4U0yK6xqqC4UrKf/gr8A3qTHhk9flxwM+NAyJEcoIAQfwnbzg3cYBixEf5wSrFxE25buksMeulgKomwe2VGn7yL48Wir2UdRrdc84xxbwTO6fFMRUJu5H+JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780111227; c=relaxed/simple;
	bh=wpVIjSW73Tqy3CtyfM/2p3sMOt1ZtfwlpoHVfMdMOOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9kWhYZaN0FRSEAPGOf0RfeEme53C9I3xwCkDyDR2WPzsAq8w4oPcUydiIch4OEhZxT6sN5/TXhaBrYy7sqdk16DwbMzo7XqTc64BkYTRwoWliF3Gd9SIvrhjhrHf+sR3SsQyzSbKUYbVZTs6eAFQIm7/ArqA/ZC67gVa0N4koQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2HSiD99; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2HSiD99"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69d7aa0ac14so5286363eaf.3
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 20:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780111225; x=1780716025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkQGFdPkGtJ/r5yX8xazHT/KTEybpcr8RzLV0lxcFoU=;
        b=G2HSiD99kv5M+uucV3gDAQ6P0rAed/HaUFbN1gQlxPCyoKR2GheEQVkAl1a/o/06fr
         Yd8sPOQBAc7CQX0DDazCDbBL7cfxiV4+y1pC7zbsRXOQebL+HeHjVAHLjbkqIEJ2fL8x
         APK/0vEhDKw2tTwL0U6MKDareJG8Wx9u9h+WjKqn/P5SPektglu+PNPoAzi5mrCQRcOQ
         C1nOsAYnMYqyyed5fEIXi7InxJ/6pPxP7/mC9LN/fa/xRNxkMv8/dnEzc8Sh9VAx9Xg+
         +5CXOihQcJNVXr2Z1YAmyjhcjH2FWyKi/azsP6/dW0D4dGjdjJosjgNWnPmaXTaHh8c0
         1h5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780111225; x=1780716025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kkQGFdPkGtJ/r5yX8xazHT/KTEybpcr8RzLV0lxcFoU=;
        b=HnU8F7OBPlRO5cEEc1lqi9lgm7cOoEzTnJ4HRviLg+dTb55zV2D36dW4KASKukM318
         l9169O7nNfZbgNT75yHrj4u74UE23zalqNT+GlDS/1OzBJHrsSn7SeWCdXEjs6InA57h
         gfUs7O/fYDyyQjhJCcF7fM7+WezqjTLnH98BwHl5cYiJX4LBy3sjVqLFUtdHSti90fCJ
         i4PlYrcrVrWgLj9HK7Gtg1tBOdwpHTISwmnKLZVF78dSpR4dyqyB9x75L20fVjAq3YFh
         NWCLRo3QKIr+AuI25Ix7UDV3CnmZ7C2IpMjNWZ2g9lUrwJODxa2m8TWRW0VS9juh4oI5
         6mQw==
X-Gm-Message-State: AOJu0Yw1NyGO6rAymvjv25oxAhU8xLXFt03Yy1RgTM714yhbHrkmgptH
	3w+PmlsXBGPnkOKH8Tw+nmCtJh9e6RRt5VM6UEmGnjNcSM8vdDYLvP4wO842PdfW
X-Gm-Gg: Acq92OHFJN4i3kH4SwlbmtXLTIxMHADkGpprHyzh6/Nj0dvnIUOFkTiifvIKRAE6Me5
	S0NznUFhvk2LSh3z2u/ff9a9dSx9Sidw+AYw8sfFYCpVbIa8QRzu3dbSF21diVlVo/VJ3mYClKC
	FT+fOV8BdT/Vi/HDp5gK8exbXEqtXjEuep5Q5/wdzEAaPiZYwdypdDVjU7BOJzstj5Wu4ZC14fh
	rrhhd20bQnysFLtmeW1iqIpDNbDTGlDt7AZYEUQetiUthBMYlPDBwQ9ycT8V2OoLv2ptj/IUlbN
	GGrycFE7kNiVmruupqF1y0HBOWf1V3tJH0H/E+TpvYhX/XJUFGnNu7G9TEffzQYdz2VGkB+VhwL
	r0r1XEmWf3jEgUuAtb1nml6PD+vsRZ1ZHMtR1kSporkFp47J/neoJDiRNOSkBh/8gYHtgjGLqwq
	Toot5SBQaOFNSAgYjqW2h5btH3QGInPm8=
X-Received: by 2002:a05:6820:2219:b0:69d:9547:c963 with SMTP id 006d021491bc7-69e102e3a3fmr1135487eaf.27.1780111225660;
        Fri, 29 May 2026 20:20:25 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e067e911csm2130737eaf.5.2026.05.29.20.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 20:20:25 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V9 09/11] iio: imu: inv_icm42607: Add IRQ for icm42607
Date: Fri, 29 May 2026 22:17:36 -0500
Message-ID: <20260530031739.109063-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530031739.109063-1-macroalpha82@gmail.com>
References: <20260530031739.109063-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add IRQ support for the icm42607 driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 97 ++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 6b623fb679f3..3c91623dffb2 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -331,6 +331,91 @@ static int inv_icm42607_setup(struct inv_icm42607_state *st,
 	return inv_icm42607_set_conf(st, st->hw->conf);
 }
 
+static irqreturn_t inv_icm42607_irq_timestamp(int irq, void *_data)
+{
+	struct inv_icm42607_state *st = _data;
+
+	st->timestamp.accel = iio_get_time_ns(st->indio_accel);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t inv_icm42607_irq_handler(int irq, void *_data)
+{
+	struct inv_icm42607_state *st = _data;
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int status;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = regmap_read(st->map, INV_ICM42607_REG_INT_STATUS, &status);
+	if (ret) {
+		dev_err(dev, "Interrut status read error %d\n", ret);
+		goto out_unlock;
+	}
+
+	if (status & INV_ICM42607_INT_STATUS_FIFO_FULL)
+		dev_warn(dev, "FIFO full data lost!\n");
+
+	if (status & INV_ICM42607_INT_STATUS_FIFO_THS) {
+		mutex_unlock(&st->lock);
+		ret = inv_icm42607_buffer_fifo_read(st, 0);
+		if (ret) {
+			dev_err(dev, "FIFO read error %d\n", ret);
+			goto out_unlock;
+		}
+
+		mutex_lock(&st->lock);
+		ret = inv_icm42607_buffer_fifo_parse(st);
+		if (ret)
+			dev_err(dev, "FIFO parsing error %d\n", ret);
+	}
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	return IRQ_HANDLED;
+}
+
+static int inv_icm42607_irq_init(struct inv_icm42607_state *st, int irq,
+				 int irq_type, bool open_drain)
+{
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int val = 0;
+	int ret;
+
+	switch (irq_type) {
+	case IRQF_TRIGGER_RISING:
+	case IRQF_TRIGGER_HIGH:
+		val = INV_ICM42607_INT_CONFIG_INT1_ACTIVE_HIGH;
+		break;
+	default:
+		val = INV_ICM42607_INT_CONFIG_INT1_ACTIVE_LOW;
+		break;
+	}
+
+	switch (irq_type) {
+	case IRQF_TRIGGER_LOW:
+	case IRQF_TRIGGER_HIGH:
+		val |= INV_ICM42607_INT_CONFIG_INT1_LATCHED;
+		break;
+	default:
+		break;
+	}
+
+	if (!open_drain)
+		val |= INV_ICM42607_INT_CONFIG_INT1_PUSH_PULL;
+
+	ret = regmap_write(st->map, INV_ICM42607_REG_INT_CONFIG, val);
+	if (ret)
+		return ret;
+
+	irq_type |= IRQF_ONESHOT;
+	return devm_request_threaded_irq(dev, irq, inv_icm42607_irq_timestamp,
+					 inv_icm42607_irq_handler, irq_type,
+					 st->hw->name, st);
+}
+
 static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
 {
 	int ret;
@@ -367,13 +452,18 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 {
 	struct device *dev = regmap_get_device(regmap);
 	struct inv_icm42607_state *st;
-	int irq;
+	int irq, irq_type;
+	bool open_drain;
 	int ret;
 
 	irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
 	if (irq < 0)
 		return dev_err_probe(dev, irq, "Unable to get INT1 interrupt\n");
 
+	irq_type = irq_get_trigger_type(irq);
+
+	open_drain = device_property_read_bool(dev, "drive-open-drain");
+
 	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return -ENOMEM;
@@ -433,6 +523,11 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 	if (IS_ERR(st->indio_accel))
 		return PTR_ERR(st->indio_accel);
 
+	/* Initialize interrupt handling */
+	ret = inv_icm42607_irq_init(st, irq, irq_type, open_drain);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");
-- 
2.43.0

