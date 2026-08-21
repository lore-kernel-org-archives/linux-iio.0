Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6064766BC
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307922; cv=none; b=aaFL4QTZlYEuhERmG0nydVk9+Y9U8X6WT3V6/4KP5avBZJrOY1VF/kROVanWwdW9yD1qIucVfRoOv/OgsAIMl+ZsvVRaTxPfp+iYrehgWXpKbvz7JxfZHAjhjcHGrcUmfDaiViOhBeQQwfYgzRN9FEfqXNU1hBWw1PvJ1aQ/dbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307922; c=relaxed/simple;
	bh=qh4p6NiaYYKZWRo5SdC+29bJh1njzkmd5IdAQaiKg10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAzlk/+hOvyl9h9BOBvJ3Sa3pptpw+pnsZabPqUidTc1v1lYuiNPLvj6DGfkLsZVkAsZq5plgwUGjF/nwCY9sEEM/MuKo3pi5lIzqyEgesCLlbPhwNEd3ELqmk3w2mTh7eRcWSW0FeEQOFlsNQfcETGkbVHmq6Uriu+LHQBN2XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwmKueW8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwmKueW8"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47fd4531020so491360f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 03:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787307911; x=1787912711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XsQREIODkCao/QDK0V814PCMzSICvR9cgatjnm3y9Ns=;
        b=QwmKueW8i3NewAouoHlS1hrLhhNRGwI78Scj5VmDnm1ASoYnMgXDG15HIN2cOIVxCz
         mi59CO1xr9c6JtjXPgftU/f9kbaP8zNNjsp/oIJ+5X5vxniZDKFyNDITl2JivjhUS9wV
         D76OrnMiEOnF8HZP1aI4TiEGSC7Ihapj8JofYEe55D7B2quA0wtAu+ZwlwOAg54ArZqt
         HtDVUJQ8qN7VQIS7AWzxDHt6u0jEBeg/+7IJIgjH55xJeIctl2ugmCtNH1LBydEtkj8e
         80nthjybcL50DdYNH5SdX9uy5zy1xjdW+rXH/cjaX3jxjJnahXMWRVG4L3hVmhNZ7RpW
         vFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787307911; x=1787912711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XsQREIODkCao/QDK0V814PCMzSICvR9cgatjnm3y9Ns=;
        b=R6WPygW8or2O3YoE/3OISDIImEVJFGGtftAwJv2eZwgoECyX0oIa7BgxtPWFNAFvPF
         BiiX32+pzrBCI0MnI2fX/SLbWYZ2BhTnk/bc1UTIB+mjBp9bFC4i8A+ihGV3hddHD65F
         T/pg9Rb1mS2gRHMFzlfOoQeiU1W5YvEq+QO2KIkp3opGNPdZYXXov9pjSFvDbntILknM
         +CSl5tyhFGiRz77uuUlD76ylTY9zeL0r5tF+duBlL4P6YfUXziwxonKSHRdElqZLFs4J
         3lsFjCSE5KFH81q1cMgulTQLh9Pxii/NpNJe+HlJzJ4bBg/5FQT7kioOuzXcYAxvjgC0
         TwjQ==
X-Forwarded-Encrypted: i=1; AHgh+Rps3dUUAVrUo3DZ+Bjy/j0RJIzX829gLQDpT17+vwDmYGmPCIFsZQSmAZ4D9/p/uqlE9cuCLy5IKdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfpfRs1BZnAvpAAHrtW0qzxqYgHjquGKjr7h9mThVsQI97d11u
	bAa9uit4kdRIqXzY3XXdJtre0pg1vSTeseaCePf5s4eajWv7CM/HQ6ce
X-Gm-Gg: AR+sD11x0RhPT6GMD+BSc/aSoVc4awEexkUocNPoTtJEd5diS9JecbamhKYZ840aYuE
	9zynbSpakLIOEhSoeAwfITQia7+D6kO3iagQ+lNIlYJV8ddLno03mW55JDXUo7LK7UAl3ME0IMx
	Y07TVR+IuOR+2kanGCdhbWAyUT/zlIGc6Vg9U7NKIaOTn/6iJkzAFS2/OpI2bLtaojprUM6t1ca
	5UuN0V3jjkQUr92RKalBY0mLaRETLSj/mh49Xk/0xWufHPVTZCQAKzHbyJSHLf2QlIkNmiZX25h
	Fo9OQCsGRT4S7P/ZalwMljlHyrHqZSYtjrxbd9EgOGkqOg8u1m5+2lBySxI+/e/Rypm5Tf7xGEQ
	d4ZluoAPMU6WLXVJKRCSaFMFl/PQqe6A8N1DynAMiel/0iep6lCwbUUGlxgJ/SVjgqgd7dv1e4K
	+Ofr24SqZ0kn/YkcCFA5rhz1qetTDVyeNvx/RTUd8WHpCYNL9Px9tbM3eWo5jxirCi6twINpnqv
	5Hq8yuetrytfQ==
X-Received: by 2002:a05:600c:3550:b0:499:8777:ccba with SMTP id 5b1f17b1804b1-499b830156bmr76380145e9.12.1787307911253;
        Fri, 21 Aug 2026 03:25:11 -0700 (PDT)
Received: from fedora ([105.74.130.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9ba5139sm11663155e9.2.2026.08.21.03.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:25:11 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v5 3/6] iio: dac: ad5504: separate ACPI and DT paths
Date: Fri, 21 Aug 2026 06:24:45 -0400
Message-ID: <20260821102452.37407-4-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821102452.37407-1-0rayn.dev@gmail.com>
References: <20260821102452.37407-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver relied on a fragile -ENODEV check from the regulator
framework to bypass voltage configuration on ACPI platforms, sharing
the same fallback path as legacy pdata.

Fork probe on is_acpi_device_node() to explicitly handle each path.
On ACPI, skip the regulator and use a fixed 60V default via
AD5504_VREF_ACPI_DEFAULT_mV. The pdata fallback remains for non-ACPI
systems in this commit; it is removed in the next.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 5c9c66b04154..6f70c57c7a82 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -5,6 +5,7 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
+#include <linux/acpi.h>
 #include <linux/array_size.h>
 #include <linux/bits.h>
 #include <linux/dev_printk.h>
@@ -12,10 +13,12 @@
 #include <linux/interrupt.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include <linux/iio/dac/ad5504.h>
 #include <linux/iio/events.h>
@@ -24,6 +27,10 @@
 
 #include <asm/byteorder.h>
 
+/*
+ * In case of ACPI, we use the 60 V as default voltage reference.
+ */
+#define AD5504_VREF_ACPI_DEFAULT_mV	(60 * MILLI)
 #define AD5504_RES_MASK			GENMASK(11, 0)
 #define AD5504_CMD_READ			BIT(15)
 #define AD5504_CMD_WRITE		0
@@ -285,16 +292,20 @@ static int ad5504_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
-	if (ret < 0 && ret != -ENODEV)
-		return ret;
-	if (ret == -ENODEV) {
-		if (pdata->vref_mv)
-			st->vref_mv = pdata->vref_mv;
-		else
-			dev_warn(dev, "reference voltage unspecified\n");
+	if (is_acpi_device_node(dev_fwnode(dev))) {
+		st->vref_mv = AD5504_VREF_ACPI_DEFAULT_mV;
 	} else {
-		st->vref_mv = ret / 1000;
+		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
+		if (ret < 0 && ret != -ENODEV)
+			return ret;
+		if (ret == -ENODEV) {
+			if (pdata->vref_mv)
+				st->vref_mv = pdata->vref_mv;
+			else
+				dev_warn(dev, "reference voltage unspecified\n");
+		} else {
+			st->vref_mv = ret / 1000;
+		}
 	}
 
 	st->spi = spi;
-- 
2.55.0

