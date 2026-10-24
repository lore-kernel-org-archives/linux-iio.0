Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792883649;
	b=tvIpnA2rKJYSlr9THZ7CE/WBMi3KzZMl++4n4vd66Hd8EL4+6MX0yixtuDR3AKaTl8Vm
	 IFy0RiZ2+n+hoq8CiaskdPouO/NyqyCPnrcHgnfNyKEk9vekM1UoftHgaean0Udr/Uqpw
	 smpfiEAsq5v9dzz/b+WF57L84ouhH/oR8Lzc7oMNewdrAzyHG/yx1mRQ0FAlaXuXAufnh
	 eAVfyjjZyocfEK3hw1zkLjJ61v95NaR2U6IqHzTKyENdOjsSkgCedyVixnQBFzgWto83Z
	 LyQLnybi+vRrEfQVK6a7cDg8/A5yFNn1RzDZ1f1hWm4tvutNRfgP+RtBKnwDeI6kIGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792883649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=s5r8P5PPgMGv0XEFAPf7N90jgdkZIp6hKa1+XNqtBTI=;
	b=nOmAGskukQ7sbYP+e3NIC20wpp8y0BxyvP8XMrEL1GTQAPcB/29egHVYdt7dajmPqJCo
	 1XGCkFjz1GmXPNOq/+aXQyqagdNRh5snF1719ZOBUA5UI0/yoh/dNBJu9+Kp1/FnslMgr
	 6bM7I9/rd4xYaFC7NONYw+XSYepNDVuGe1x4Eob96FsGXeRLjNPbeOQnwc9OVmj+4Rbu8
	 hRz8PtOmnkRPwwE98fb7JJPsIelJqD6/Wgjqo8UYnqbiXy3Olu4kYkxuOOSj76U8FY6rt
	 rvt6fyWdhUwlAhA+rhCaBnTU3fPX2Z0eKlPNs1PQI9yu/gUH+CoqO2s9PTu02SkxDJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C6TFmIlo;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A92606A324
	for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 23:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94A92606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C6TFmIlo
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7c03a445cb8so1281724137.0
        for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 16:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792883648; x=1793488448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s5r8P5PPgMGv0XEFAPf7N90jgdkZIp6hKa1+XNqtBTI=;
        b=C6TFmIlo4tzFwlOqjZlJ7PU2N1JOTqfZcINSpdz07QbbiJqKQYb9F+ClwbQIfbdcka
         EZF5TFJYPQwhAhxBN2pIakxIhyXxUAlaUIzOKon4nrHq4b1aNQc5NyBZHLokXg8e2AeZ
         KSWKdXDlv0ss8ugexmWbJkGcCJkzoHZnjE8NH/pIITcLxnj5EqV2fyTMjBPIJFOl9NK0
         2QMFHJX9oILbGanxGBHPj6D3T5NRq00P9lOznVv8vm05hfkk54cvIr2XB3czrt7KqSs5
         RDLEV0AU3bl1czE7ZvNBjB0hv24bYMDwT487S4XaEW5JR8ikfs7VDMO5oX1RiL1R6vp1
         lHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792883648; x=1793488448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s5r8P5PPgMGv0XEFAPf7N90jgdkZIp6hKa1+XNqtBTI=;
        b=0Mrh31LCylskOKgmIPCcD+tT5hfPW7Q1qgj9Xb5Eai/3qZkc40R+FjHRxKHDIi1GTW
         BgcpRfo3m0/LfVDIsspJt5NYJwIAHztD2K2U7I0cTH0IIp5G3VCYI55BCSIOhC8Ikf/6
         /NsfLkCAbbPhYVGGtKyKm65Q4lJ4JXIB+5uO1thZsvw5dwP7T+hleSU2NWnDkOEypxmp
         IOu5fXOQQJRguAHd7eKE9xKVOgKdWI1YL30Vnq0B1Hjrrda3XARpvtlVEWM5rn19zGxb
         Nt/HHjRetCHTPvvtLLpkITgT4zYGzD97+JzjNxC6e0RSmrSHwQd17PuZQlyyVjzeogKM
         Z8fA==
X-Forwarded-Encrypted: i=1; AKwUvByuMDGc7oXgSt70iUHD6hjEmvheQePQ8Of2eGfI+HGQ8Z/hR1hvehs/sGgCbpYsMYTMc+iPW/1Bj9g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKx7Ha6IsKxfvsHXHoJC/GIW7TQOBYKr1vFvRCKFelJmmT6xgs2
	zhUS/xXl77o1zRfrq83nYuYpv64Nng9MCnlLoFRwMJR5FEQSr3Vv35X0
X-Gm-Gg: AYBFou3tnS5nq90uK8Zb/XSk9xKWeco+SoBGet01Rxjdx7CgDIzwI53rPPeB4om4by7
	EYlSCtiUfc+ywr2iwvXzRPZfExFs4B/ZuWCa6Mr1CEUq2A8/wlsNmoZj/3U8V/Fh8G7nfPz7jQP
	NeofuWVr621ACyk+8Uu7BcrkRq1j/ptfgYr/Q98cld/zLL+lTnhb/O0wPJmMJm/Nqu/bPzH8fpG
	Xk9mJv4VDnLX27E5FQIcNzF9VJsM4op8gOB588eD5XdgfRvCOtiLkYPgd0KOaOZppv8ZOKW+2x2
	2Qa+H9mJGiATtevRDvK8NQRU+w3Nk3wt6xeC0D2stkOIz2sa8g0X25NOE0E1q4bI5Mv/EVO6FDI
	WMI0xAWG99vKeWLn0MrFoslMtp/dH2d3FTlBUJhko84tUG9xJ4wOD6F5MoqN15U9jTJozWDnkJB
	9ak59zoHdjsEpwmCakIu/YAPOvld125k8c2IzH9vwMO1o177tKfcG74WLbLA7AO6Ut+KhOOyrej
	thKGov6OEKcJ+K2OGqBKJJSlS8L14EJjUpS7aouHz3V2X5NSRvpIGsISdqYPSIT9VNYn3Rd2sQw
	Pitw
X-Received: by 2002:a05:6102:5245:b0:7cc:3eb0:6ef4 with SMTP id ada2fe7eead31-7ce5cdfb267mr1031775137.29.1792883648516;
        Sat, 24 Oct 2026 16:14:08 -0700 (PDT)
Received: from stephan-Inspiron-15-3520.. ([2804:5d20:6009:6701:efc9:520c:e99d:e5ce])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910e7b8f0csm3775406241.5.2026.10.24.16.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 16:14:07 -0700 (PDT)
From: Stephan Costa Barros <stephanbrrs8@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] iio: adc: ti-ads1298: fix scale, ID check, regmap and Kconfig
Date: Sat, 24 Oct 2026 20:13:32 -0300
Message-ID: <20261024231335.280955-4-stephanbrrs8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024231335.280955-1-stephanbrrs8@gmail.com>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix four smaller issues:

- The scale divides the reference, in whole millivolts, by the gain
  before it is reported. With the internal 4 V reference, it is 0.099 %
  low at gain 6, 0.101 % at gain 12 and 0.025 % at gain 3. Report
  VREF / (gain * 2^23) as an IIO_VAL_FRACTIONAL; sysfs still shows it
  with nine decimals, now without the error.

- Only the channel codes 0, 1 and 2 of the ID register are defined; an
  ID of 0x93, for example, gives 10 channels. The IIO core then reads
  past ads1298_channels, and the RDATA transfer writes past rx_buffer.
  Refuse the reserved codes as an unknown ID.

- The driver uses regmap but does not select REGMAP, and fails to build
  where nothing else selects it, such as tinyconfig with SPI, IIO and
  TI_ADS1298 on x86_64.

- Bit 0 of CONFIG3 is a read-only status bit and the GPIO register
  reads the pins, but both are cached, so a read through debugfs returns
  a stale value; debugfs can also write ID, LOFF_STATP and LOFF_STATN.
  Mark CONFIG3 and GPIO volatile, and the other three not writeable.

The ID check was found by review and reproduced on an emulated device
only, where KASAN reports the read past ads1298_channels.

Fixes: 00ef7708fa60 ("iio: adc: ti-ads1298: Add driver")
Signed-off-by: Stephan Costa Barros <stephanbrrs8@gmail.com>
---
 drivers/iio/adc/Kconfig      |  1 +
 drivers/iio/adc/ti-ads1298.c | 29 ++++++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f32f678f7..a29ed8f45 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1924,6 +1924,7 @@ config TI_ADS1298
 	depends on SPI
 	select IIO_BUFFER
 	select IIO_KFIFO_BUF
+	select REGMAP
 	help
 	  If you say yes here you get support for Texas Instruments ADS1298
 	  medical ADC chips
diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index f5965b994..b390c13ae 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -75,6 +75,7 @@
 
 #define ADS1298_REG_LOFF_STATP	0x12
 #define ADS1298_REG_LOFF_STATN	0x13
+#define ADS1298_REG_GPIO	0x14
 #define ADS1298_REG_CONFIG4	0x17
 #define ADS1298_MASK_CONFIG4_SINGLE_SHOT	BIT(3)
 
@@ -373,11 +374,10 @@ static int ads1298_get_scale(struct ads1298_private *priv,
 		return -EINVAL;
 
 	gain = ads1298_pga_settings[pga_idx];
-	*val /= gain; /* Full scale is VREF / gain */
+	/* Full scale is VREF / gain, signed, hence the -1 */
+	*val2 = gain << (ADS1298_BITS_PER_SAMPLE - 1);
 
-	*val2 = ADS1298_BITS_PER_SAMPLE - 1; /* Signed, hence the -1 */
-
-	return IIO_VAL_FRACTIONAL_LOG2;
+	return IIO_VAL_FRACTIONAL;
 }
 
 static int ads1298_read_raw(struct iio_dev *indio_dev,
@@ -680,8 +680,11 @@ static void ads1298_quiesce(void *data)
 	ads1298_wait_rdata_idle(priv);
 }
 
+/* CONFIG3 holds the read-only RLD_STAT; GPIO reads the pins */
 static const struct regmap_range ads1298_regmap_volatile_range[] = {
+	regmap_reg_range(ADS1298_REG_CONFIG3, ADS1298_REG_CONFIG3),
 	regmap_reg_range(ADS1298_REG_LOFF_STATP, ADS1298_REG_LOFF_STATN),
+	regmap_reg_range(ADS1298_REG_GPIO, ADS1298_REG_GPIO),
 };
 
 static const struct regmap_access_table ads1298_regmap_volatile = {
@@ -689,12 +692,23 @@ static const struct regmap_access_table ads1298_regmap_volatile = {
 	.n_yes_ranges = ARRAY_SIZE(ads1298_regmap_volatile_range),
 };
 
+static const struct regmap_range ads1298_regmap_read_only_range[] = {
+	regmap_reg_range(ADS1298_REG_ID, ADS1298_REG_ID),
+	regmap_reg_range(ADS1298_REG_LOFF_STATP, ADS1298_REG_LOFF_STATN),
+};
+
+static const struct regmap_access_table ads1298_regmap_writeable = {
+	.no_ranges = ads1298_regmap_read_only_range,
+	.n_no_ranges = ARRAY_SIZE(ads1298_regmap_read_only_range),
+};
+
 static const struct regmap_config ads1298_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.reg_read = ads1298_reg_read,
 	.reg_write = ads1298_reg_write,
 	.max_register = ADS1298_REG_WCT2,
+	.wr_table = &ads1298_regmap_writeable,
 	.volatile_table = &ads1298_regmap_volatile,
 	.cache_type = REGCACHE_MAPLE,
 };
@@ -704,6 +718,7 @@ static int ads1298_init(struct iio_dev *indio_dev)
 	struct ads1298_private *priv = iio_priv(indio_dev);
 	struct device *dev = &priv->spi->dev;
 	const char *suffix;
+	unsigned int nu_ch;
 	unsigned int val;
 	int ret;
 
@@ -717,7 +732,11 @@ static int ads1298_init(struct iio_dev *indio_dev)
 		return ret;
 
 	/* Fill in name and channel count based on what the chip told us */
-	indio_dev->num_channels = 4 + 2 * (val & ADS1298_MASK_ID_CHANNELS);
+	nu_ch = FIELD_GET(ADS1298_MASK_ID_CHANNELS, val);
+	/* 0, 1 and 2 are 4, 6 and 8 channels; the other codes are reserved */
+	if (nu_ch > 2)
+		return dev_err_probe(dev, -ENODEV, "Unknown ID: 0x%x\n", val);
+	indio_dev->num_channels = 4 + 2 * nu_ch;
 	switch (val & ADS1298_MASK_ID_FAMILY) {
 	case ADS1298_ID_FAMILY_ADS129X:
 		suffix = "";
-- 
2.43.0

