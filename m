Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB41374E73
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787389152; cv=none; b=PFhTn6D+cOFT/y7l9R/dgs0sA45QZg/0g27QMT5iWbz5wq8USRfQ+nlx/acMgy5hK/dHMKITajOMgBBfKVGeHwlEE6ZfyzOT0Vf0FZ+wB3CBMmCg5p6zLtGvAzUF95n4qUZNKTRJVB7d9r0rXL16GLeibCNqHq/SDqv3IzrxbM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787389152; c=relaxed/simple;
	bh=HCZVOF8T9m7E1Gm3Iq+tZImcQ0gw7AQRtwevkDBWDd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcTiqBbxTUTEVt+dA555hBxuEp82sMtAPxDV5LxLarPCMis2cZ2FI2dALxJ0y3VSpPmkM16VKDdk7xxTzFZBA12JvzgZN/SXvF4Z3zd1EHOfpDyASA4JdZWbeF7CzTCeLCIezmv9t2B/YCWXgZI30q0mqMLyaiOfYU4LTPenHXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpVO4Ppa; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpVO4Ppa"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso1482119f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787389149; x=1787993949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0dWiifvCNQ6/1XjQKOnLCIy+9xjui2vS7wMw6DuKzck=;
        b=CpVO4PpaADFUYZb9BdHz57T/9zlRaUoBDVipDhuy6607AqDegFbjE2NxH1KkdF6vsp
         XTqryFL1Y2rf5ejiYpe7rGDux2wRu3sbivQIvcHbCKo5e4nynSHQuoAhZXHg95svE2iC
         wKvS800DqoqInTYMk++f2TiHcEnJ+G3740Nu4BPxwpyMgbD2r115CLHOhSqJ0FNxgpyY
         6/rxlXw7Jgk/yca09cs0QzaowYOzy4YdMledBbN/HAb3Vhebv5y//AmQMZwzFQrzJKsq
         LFFuLr1P8je950f7gDTc6ypMo0f82hGCuvI1CPw+arnzuqqZnlai63OLHNKIR4jaZW38
         gGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787389149; x=1787993949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0dWiifvCNQ6/1XjQKOnLCIy+9xjui2vS7wMw6DuKzck=;
        b=PW1wzxVQUM0nmhcLJVjUqvYmIVRZcKEyzHcX07fpv3cjx59S+FQ7PW/YfzN0ZL5gjp
         oXC33V2T+QDSUV4Ac4EE64xByEHkv4gsrTzo/5NOawFNDsyjjIARsLg/OnnuQGBQwoNx
         7h7p0xsX75iBN85tY3tXxiqPNUPy5Zu66bTmPAuMUG9r2yEOY6LZ38303JrxGkFXgdjd
         O3JPDe7rKwlWhH8JfM8u8lwmsEDgQL3fX3Omwd6Ey8ymrpuEj3acKgeydGC/f0hWipYX
         V/2bm2S4ZBAukbYcengu2qaWo2acDGSfRnQWX4U1zNc2j8Mfx0kL3QxodsqR23KDRdMU
         uBdg==
X-Forwarded-Encrypted: i=1; AHgh+RqNDxlPE8oNOH0JMjrhnQXRIMktMOUU9YDQG5YpzLxe94hNEeu3+9HDGcBpi77Thkf6kZl7ZmJX9xo=@vger.kernel.org
X-Gm-Message-State: AFuF++lwMPpia0BqBIvXKd/jYvD7oNDvVc51t+QyjnGbl7LJ6edMnH2w
	UbvkFFhwNJlp9u9yoBal3/72BhVYnHob+U0gZ7icBzD4KOGi4pz27zzk
X-Gm-Gg: AR+sD12B95TvNTJo3/9H35ePUP3wp3iLO0ezX67iBehedYso/J/IicDucFqlGrybZ1D
	/LkpYuV740LSwdjZ/ef9J/oK+Wfgc4s0sns0a2DqYWj/PAfU2jid1K8KeHtOJwgIA9giaW/CsRr
	jaJEyLRtiVMyHpu7J72banMNpjaY3AVP0lFdA0qbQ6ZHpOTf2zgunAzyH0/W581uAttiuu/O3n4
	3BYR1GYyYjT445s8/JbwTHyGR/7OnShw5i5wh/wIeI4DCb8ILx8FA/MRT0MTG9xsEjkcanewGM7
	foWfdLQlTxWCtNqtBskKIhjmtF6A1FkXPTDYNUE586vMTvCjk89kVGBOR4MVoCts+5aBjJXMWyV
	wZDWLwELZMrx4tLOz5LDsaOpIT7QBXksfmtZIwuDzgp93yDgs0sbyNfSOUBJhw4pggaf8oO3rrG
	XTgHDFlYIfW0DDLNHlvsUVKRZyPyWxyKO+B/+TmXp/SOh5OYjKP8LEVmGuHDb4ri0DtCPruqGGC
	yrph0oObFU=
X-Received: by 2002:a05:600c:4e4e:b0:499:b01e:911c with SMTP id 5b1f17b1804b1-499b830d697mr175513185e9.2.1787389149299;
        Sat, 22 Aug 2026 01:59:09 -0700 (PDT)
Received: from fedora ([105.74.72.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c359b9fcsm13596635e9.9.2026.08.22.01.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:59:09 -0700 (PDT)
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
Subject: [PATCH v6 4/6] iio: dac: ad5504: remove legacy platform data support
Date: Sat, 22 Aug 2026 04:56:51 -0400
Message-ID: <20260822085850.17527-5-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822085850.17527-1-0rayn.dev@gmail.com>
References: <20260822085850.17527-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD5504 driver has no in-tree users of its legacy platform data
support. Now that ACPI has its own explicit path, non-ACPI systems can
safely treat the vcc regulator as mandatory.

Drop the ad5504_platform_data structure, remove the fallback logic
from probe, and delete include/linux/iio/dac/ad5504.h.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c       | 17 +++++------------
 include/linux/iio/dac/ad5504.h | 15 ---------------
 2 files changed, 5 insertions(+), 27 deletions(-)
 delete mode 100644 include/linux/iio/dac/ad5504.h

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 6f70c57c7a82..799726eafdf2 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -20,7 +20,6 @@
 #include <linux/types.h>
 #include <linux/units.h>
 
-#include <linux/iio/dac/ad5504.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -281,7 +280,6 @@ static const struct iio_chan_spec ad5504_channels[] = {
 static int ad5504_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
-	const struct ad5504_platform_data *pdata = dev_get_platdata(dev);
 	struct iio_dev *indio_dev;
 	struct ad5504_state *st;
 	int ret;
@@ -296,16 +294,11 @@ static int ad5504_probe(struct spi_device *spi)
 		st->vref_mv = AD5504_VREF_ACPI_DEFAULT_mV;
 	} else {
 		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
-		if (ret < 0 && ret != -ENODEV)
-			return ret;
-		if (ret == -ENODEV) {
-			if (pdata->vref_mv)
-				st->vref_mv = pdata->vref_mv;
-			else
-				dev_warn(dev, "reference voltage unspecified\n");
-		} else {
-			st->vref_mv = ret / 1000;
-		}
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "Failed to get vcc regulator\n");
+
+		st->vref_mv = ret / 1000;
 	}
 
 	st->spi = spi;
diff --git a/include/linux/iio/dac/ad5504.h b/include/linux/iio/dac/ad5504.h
deleted file mode 100644
index 9f23c90486ee..000000000000
--- a/include/linux/iio/dac/ad5504.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * AD5504 SPI DAC driver
- *
- * Copyright 2011 Analog Devices Inc.
- */
-
-#ifndef SPI_AD5504_H_
-#define SPI_AD5504_H_
-
-struct ad5504_platform_data {
-	u16				vref_mv;
-};
-
-#endif /* SPI_AD5504_H_ */
-- 
2.55.0

