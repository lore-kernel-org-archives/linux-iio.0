Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466163D47DC
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164936; cv=none; b=LtAyNeMC6ZLZvE6lfhiFaHerAoMBdtEDPi8D3XyKqyv7qC/QT6cMm5CS34EvJ+Ccn46KV7rEOgTPZ3yCsvSf+mOS1/SZ7lbdoAvITnp2LjP7a3wjRY9WkoQiem2S0D0UNKMw2xjwKs1P9Gehl9I7UaZoReI3pHgnh3LMsGA9Umo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164936; c=relaxed/simple;
	bh=xeXVTSZzQuuFD+lMKWTOiRIKsLFrz54VBr0660xK+CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOYTtoaMC7bMTgYZL5mmj6EPYwdt8VmZtciuR6+cVHpU/DgNdytHMktnySYkHwfcdq59jgU76lf1kjHIkhZy3Fxg/q1SGcLTHuFFK/q4MJp8ma9Rx6gFfPA8TlBpAA/hucnzgkmauIcF1qLncDfLqryhOGdeZAajZuit4EDTxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJRk7KuO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJRk7KuO"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439c944bb62so4806002f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 10:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773164932; x=1773769732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BslQrBMKlw57se9odRgPPZj4HtuVGPf12Q60E4FhFEw=;
        b=jJRk7KuOfLQOtFkoENv5UgV8Bzc0kQ3GSLDG+Br+orZehGkqgCPSNzWO7QKuXvefeb
         S+ES0XN7v0Dv8A753dNyxGJNITsdwBKVOiV/p8b4q3KRkcGkhsUdZHn0CWKD17pAjYDI
         SUtkmpWLamfIGMtux/ZYafXtBdfiD8Efl7ydzlTLYVRtQzzrdor0Y7uO8BQRYiuGWE+B
         bLA3fG+WJGu4WkZCSX32JO/IsUcDHoFtpQhrrUg2hUskrS5jvkQqTAkHi/2t86+flRJ8
         w8VXiOUE4ko/kXRwYQeTcUbGZ1rx2ApBomAjY86/wy/VOP7hk68UPR6bHBzhs104bp5h
         ijJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773164932; x=1773769732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BslQrBMKlw57se9odRgPPZj4HtuVGPf12Q60E4FhFEw=;
        b=vzCuB0N4+UT651VzR9np8C0M+mY2fsdQJ2krneKjmviGtUowqX753jvA1tc2QTpWwd
         jO/fS+C5JyZwVWKGiR0eCAGpFdOV2Lahh6vAj3e3z+8kBzgjehZxJgsU1gu9aVfCs+n1
         ZsjgrCxV3geQcrWICBu8zi+w3/Giiq4lp3oGhgH/zvFmxsQSSdWTsjpZvgvGH2GpNZJg
         xIpt7axdd+RPbjRQeCj+z6GBIVzUpK7lIyjaYCQVqEhTEP/6RhHQPvJyQcDWwTpTIvRf
         Rh8Nn2sWmsoFvSyh8IkRObZfItYmqjD8jLvqoMvGPrFYnrTXGZbrWdbK85Qbr+PV8ZVJ
         R/aw==
X-Forwarded-Encrypted: i=1; AJvYcCVhluNKvSoqYOQZnaQmqqw8xHRL5FDT8rB8EApiAkaWAq9/i6+PMmBBuSL/R3HgW/fssiV7c/ctZ/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvZFx9Dl+IVPHBs72fZ3OyjLUkGKZ+WuhfrbKS6A3lYl0JJ8xU
	jsVKjR1wF8Ml+IiPhjhdrYfqEzgoWBKED5bneWSB9pRX0Wi8dt8bHF5N
X-Gm-Gg: ATEYQzyo4oc2LX+uu18RWbk2TRb1gAInjDBw5S5SHsCvV+/ReJ1oIJIpb06Asu3O5dk
	xwWcJpPZTM1epMu+QXoFvhAYKyLKqUunrnIiB8zAhml2vuWCr1wDAD2jXNoV2JTXhWVPkC3I918
	xMu3bu+k9D5AOxQBChiqco7T2pHnH4uI/Ok4UZCT4BgqNSYEkvuqIBZ4RGeLhQflCb4qxwYgd1L
	ts5MOMbQX1+gzYjEAY6l9IlOwsuMf3wMzBx8rVmp270k5BLA1b4xq4ukSeKjmx80FfMevXGSf+V
	EHpOWhTMB4cHbQfK123QtvLk1Hgb37pH2Y9oMR5yHGFIRBo/rNUF5Do3qHQ7z01wTlYxg8qwzSu
	7l89/WYprGVUzaZcrdm2xR2h06uBX6KOeklAfqTGU2R7zsL1wYfyb7FnBZd45hhvUOEF8/1+XPk
	ND+UgwmdmI4oSZrvdq/0i4I7kqNqC5VPXWfPl/4zIdsZsN3WSitwAAWnRUHA==
X-Received: by 2002:adf:e802:0:b0:439:f61a:e005 with SMTP id ffacd0b85a97d-439f61ae05emr1742261f8f.32.1773164931625;
        Tue, 10 Mar 2026 10:48:51 -0700 (PDT)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae45786sm42986166f8f.32.2026.03.10.10.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:48:51 -0700 (PDT)
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
Subject: [PATCH v2 4/5] iio: dac: ad5504: fix scale via output-range-microvolt
Date: Tue, 10 Mar 2026 17:48:34 +0000
Message-ID: <20260310174835.24209-5-0rayn.dev@gmail.com>
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

The AD5504 full-scale range is hardware-determined by the
R_SEL pin (0-30V or 0-60V). Previously, the driver incorrectly used the
VCC regulator voltage to calculate the scale.

Update the probe function to read the standard "output-range-microvolt"
property as a two-element array to determine the correct full-scale range.
Use the MILLI macro for clearer millivolt assignments and simplify the
probe logic using a local device pointer.

Suggested-by: David Lechner <dlechner@baylibre.com>
Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 43 ++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index e71218c44982..cd563460fc0a 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -12,10 +12,12 @@
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -271,28 +273,31 @@ static const struct iio_chan_spec ad5504_channels[] = {
 
 static int ad5504_probe(struct spi_device *spi)
 {
-	const struct ad5504_platform_data *pdata = dev_get_platdata(&spi->dev);
+	struct device *dev = &spi->dev;
+	const struct ad5504_platform_data *pdata = dev_get_platdata(dev);
 	struct iio_dev *indio_dev;
 	struct ad5504_state *st;
 	int ret;
+	u32 range[2];
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
 
-	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
-	if (ret < 0 && ret != -ENODEV)
+	ret = devm_regulator_get_enable(dev, "vcc");
+	if (ret)
 		return ret;
-	if (ret == -ENODEV) {
-		if (pdata->vref_mv)
-			st->vref_mv = pdata->vref_mv;
-		else
-			dev_warn(&spi->dev, "reference voltage unspecified\n");
-	} else {
-		st->vref_mv = ret / 1000;
-	}
+
+	st->vref_mv = 60 * MILLI;
+	ret = device_property_read_u32_array(dev, "output-range-microvolt",
+					     range, 2);
+	if (!ret && range[1] == 30 * MICRO)
+		st->vref_mv = 30 * MILLI;
+
+	if (pdata && pdata->vref_mv)
+		st->vref_mv = pdata->vref_mv;
 
 	st->spi = spi;
 	indio_dev->name = spi_get_device_id(st->spi)->name;
@@ -305,17 +310,17 @@ static int ad5504_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (spi->irq) {
-		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
-					   NULL,
-					   &ad5504_event_handler,
-					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					   spi_get_device_id(st->spi)->name,
-					   indio_dev);
+		ret = devm_request_threaded_irq(dev, spi->irq,
+						NULL,
+						&ad5504_event_handler,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						spi_get_device_id(st->spi)->name,
+						indio_dev);
 		if (ret)
 			return ret;
 	}
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id ad5504_id[] = {
-- 
2.47.3

