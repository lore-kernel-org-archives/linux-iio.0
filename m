Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E50381AF1
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787389155; cv=none; b=Gb7XzhC1enOdFk72RRPrARsL6y7stOnahEoAORnNrpll1ppq6iCUHetGB5jbje806BN39FeBAC0x0c5YTgb/i19aBKVnpeTA9pbP/Pjtn9CxgHsQel/VZZ0X172kzu1OIL50IOeGVVasheFW65QSc9mkiVnVWLgCehlZePgJkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787389155; c=relaxed/simple;
	bh=GrjWD/fHDSl39omfPPPA6fY82p2QrwPspwwKONWixLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fi9h4g4qmycHLM4bjGqlRWcJhQK6+JiIB424YEk+thg7Ax1/PVNYXMpp/DeZ80TP4wDJmxTbUhy31Zwh02TeiNsp7mnaDpmCDXFTwdLvFif5+Do6KmICGA2W8bVnladooDGMHufZCdwddaZGU5u3Gsbs9FPASLiiocTcDYvcUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD7CUfgc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD7CUfgc"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so15754845e9.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787389152; x=1787993952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=luQR8xYtWNjcIKjnua7+NMXDIf2qqWk1d+lbBj05x0Q=;
        b=kD7CUfgcAdxfIqWoJWbLxfAn9h+Q4Z7UCv9VgUO2mfgDSasF7IQQ8/QqUzi2oDE5kU
         jMd2V5hkODd6P3fGom8qC8SUqfpViayyzMOc9XSn9tjdQWIuWjGAQ2pUN/H0hj0NsbLU
         VQgFsQZ65Ae1LJr6qGTAucb/Eu23GWpDW5x7ejrSH/1cvQdbXTvhOS2aduC/9ZUCZEOb
         TQyzHdhtC531HxwK7aXoqXhCUbsAarQtSZE22cyTFYssbrKSfzSmNDH/gxuEsGvpPBEC
         iNGIW353j2jCCJ6VqpI0ZKSn7iPZSe28V+R184ZyvxzM5+TlbY+ISgjl9M7xPrVTzjbh
         twzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787389152; x=1787993952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=luQR8xYtWNjcIKjnua7+NMXDIf2qqWk1d+lbBj05x0Q=;
        b=YPLJUeG0CUgIXzVo5R9+BZgJr5ksHozX2pj5bAO3dwmDo5LNTwEP7rVV08XH15Ejbj
         k+8wrYj8pnysPxbRyZDua3O+w/uqUf8JLWPybKOYNQY68FisJ0namvMaAyC/dYRDxqAX
         P3iiWw30YOOf5G5hifLAwPMCbtfyJp6IMtOMI5BZDbDro15XbplRa3h6q+al+zMQZokG
         QMM3T4IQsDEYAoMRIb0KFRWxtjrQTI5uBKTczmY9uM5dZHw+jkXCNdIH3ewg9BnsyWMT
         sSFPdyleQCLBuU2T2IcEO/bXlgoAt3ujOfIweV5zLAecGXVTzmV0ELYwKtAKYh5+xl/Y
         i7xQ==
X-Forwarded-Encrypted: i=1; AHgh+RpeYXmA70sBbfADS20ODBk5nXhVglTh7aKUJBq/y0nEffuzefnNhDmlEZpBD2XvKpd/H1WWt/GgR1o=@vger.kernel.org
X-Gm-Message-State: AFuF++kfdRq6vuuprSvAmynJpFcCpvv+txC1oAQ61L7i/+/3H/w//+CN
	t+zF19PoAeP0ZqPgYNeGIwd8G5/YX313m/25xBEzFVb8559ydyqq/ITd
X-Gm-Gg: AR+sD10nI3L3p5u3o2VGGKZi7mvrj7Mdwj1bOurcSyDLp+jGtry8sDe9KUdu+p2WjYw
	wUahvkqQp0IchpWpywRbfUbx1wR8DIGejxR7yPpe0OCukuOsocp5UEbb4hQImJdUs/1L2/JymMJ
	0KFNlKFIYFPnEz8JSuaZdUGicIhaGGgsO4AouF6zn5/5jBkDkeiFeZDmEzXBY0L9o5Auyap+e5e
	/L4oRFNwN+BXYKPzr/zUti+vW/IkVCOePxacJTB3F9i21F80+9qGXjQQ9gSGJZSx/DSgl4FoZGA
	sSPREP3eugm2X2tmfGOhPmrD3lJ4ICGGTn9UpGhHRmflNJo7dAKiAsQZpJBkyIcNzaPtjAQZ8On
	x45YQ4BVyZLZDbxgDibXjUhSc77RWo5n+iXNhN/mmP+/1zRRn14lFT/3uXRnclQge1htk1AyS2E
	JStD7BxxOct4WL8+7bMnbrY81Oq3cm72faEZCmdma/cY9mJgfJv69KHXiKzfkXAfvPTgj02/JRN
	FPknphUxP0=
X-Received: by 2002:a05:600c:83ce:b0:493:a966:d5b5 with SMTP id 5b1f17b1804b1-499c19adad0mr42586245e9.2.1787389152523;
        Sat, 22 Aug 2026 01:59:12 -0700 (PDT)
Received: from fedora ([105.74.72.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c359b9fcsm13596635e9.9.2026.08.22.01.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:59:11 -0700 (PDT)
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
Subject: [PATCH v6 5/6] iio: dac: ad5504: introduce local lock to protect state and spi transfers
Date: Sat, 22 Aug 2026 04:56:52 -0400
Message-ID: <20260822085850.17527-6-0rayn.dev@gmail.com>
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

The driver lacks locking, exposing concurrent access to the shared DMA
SPI buffers, the non-atomic CTRL+NOOP write sequence in powerdown, and
the pwr_down_mask/pwr_down_mode state variables.

Introduce a mutex via devm_mutex_init() and guard(mutex) at the IIO
callbacks to serialize access. In read_raw() and write_raw(), scope the
lock to IIO_CHAN_INFO_RAW only since IIO_CHAN_INFO_SCALE reads vref_mv
which is immutable after probe.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 799726eafdf2..74679feea385 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -8,11 +8,13 @@
 #include <linux/acpi.h>
 #include <linux/array_size.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/dev_printk.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
@@ -55,10 +57,12 @@
  * @pwr_down_mask:	power down mask
  * @pwr_down_mode:	current power down mode
  * @data:		transfer buffer
+ * @lock:		lock to protect state and spi transfers
  */
 struct ad5504_state {
 	struct spi_device		*spi;
 	struct regulator		*reg;
+	struct mutex			lock;
 	unsigned short			vref_mv;
 	unsigned			pwr_down_mask;
 	unsigned			pwr_down_mode;
@@ -109,7 +113,9 @@ static int ad5504_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (m) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&st->lock);
+
 		ret = ad5504_spi_read(st, chan->address);
 		if (ret < 0)
 			return ret;
@@ -117,6 +123,7 @@ static int ad5504_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_mv;
 		*val2 = chan->scan_type.realbits;
@@ -134,11 +141,14 @@ static int ad5504_write_raw(struct iio_dev *indio_dev,
 	struct ad5504_state *st = iio_priv(indio_dev);
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&st->lock);
+
 		if (val >= (1 << chan->scan_type.realbits) || val < 0)
 			return -EINVAL;
 
 		return ad5504_spi_write(st, chan->address, val);
+	}
 	default:
 		return -EINVAL;
 	}
@@ -154,6 +164,8 @@ static int ad5504_get_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct ad5504_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	return st->pwr_down_mode;
 }
 
@@ -162,6 +174,8 @@ static int ad5504_set_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct ad5504_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	st->pwr_down_mode = mode;
 
 	return 0;
@@ -179,6 +193,8 @@ static ssize_t ad5504_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5504_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	return sysfs_emit(buf, "%d\n",
 			  !(st->pwr_down_mask & (1 << chan->channel)));
 }
@@ -195,6 +211,8 @@ static ssize_t ad5504_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	guard(mutex)(&st->lock);
+
 	if (pwr_down)
 		st->pwr_down_mask &= ~(1 << chan->channel);
 	else
@@ -290,6 +308,10 @@ static int ad5504_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	if (is_acpi_device_node(dev_fwnode(dev))) {
 		st->vref_mv = AD5504_VREF_ACPI_DEFAULT_mV;
 	} else {
-- 
2.55.0

