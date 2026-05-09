Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7255C39A815
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778336564; cv=none; b=c4R3b6diB/xqBa2MXJ4uYPAFZwTt6zAtqxs12cUvTjV9fL0VwNcj0TKEDoLitcBr4GTUlqT6OaEi5jxBZg0VM7dZvju6hH3WHyKSwaEpqmtftW95lv8P9P4qmuKoE2gh2C2RX8VYXFDOnfk6XmbzS5ycc33bt0653nRuuO6m9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778336564; c=relaxed/simple;
	bh=bHsamKdNXaMj15lw5nYewmcYz2vhqiWqJ58ZKCBpukk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnH3xhRDL8PvWgQ0NWJCLePw9ikBG3pb8UOSxqrM4WagSdYD3oY5ntIAUScfhGAz2jaO00LLBkkDrHjoc3QB4eOMurWvy6DijqSDlaP2ek1zQRLEHb0e25bWlwpfghnxuQE8yZ7gdw7aB0EEBw2bJRRHcrFkvr7fr9BLn9NfOR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/nJE/AS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/nJE/AS"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d75312379so2521807f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778336562; x=1778941362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsAbPVJ/lQzgpp89tG6qinhr/xePS1xjYRlJbLcWEiY=;
        b=F/nJE/ASpW9Re5tQUy87kr26Tq0gozG6ug1aC962tijgRq4cXaPcDNDb1PcIQyj6v9
         xZ09yt/oQJNA1u8h5Bz54XCCdJvdSlapfe8Pd0Z/vjsKwTga0s7jVyY1FLLPe4QozSwg
         xqV0wDOcp6u6PwhO6Y5WvY+++jhJqsY1J26fYcaJUsG/2NP35wmxRos/j7nZ4wPG8W1Z
         g9826T4L/SsXRvWUALLEvrMnFVwGyDTLVGTCQh+b1NIpALM3TsxnNDIafK0gP4+gNgmt
         sc7v39FigwcMIoQIPL/XYhKek2D1njxPxTK6jFav7Hb9kExjf8X2kun4oK6nD5Aze+cf
         rxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778336562; x=1778941362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FsAbPVJ/lQzgpp89tG6qinhr/xePS1xjYRlJbLcWEiY=;
        b=H/i4PogKXvoftjGspDF4jk7g+gth36EzFbfW+r9UA1ODEItXx5g8MJykr8xV4diaM2
         A67xTGCmwyS8WPfUKl3FOzSqN44EkWkGjIoYHRji36njQKRBah0ELsSPoolW4G19jFlu
         /LN9HXeyF2xT6xqmzBzYQeYSW58RcDaXVVXotSZ831nn53q/9+cezg75oAWoTaNht89M
         C9JYwMr4dGjUy6iYDcLdVlbNXVZflQ/wh8VN0oGc6krAy3VcIiIEcTbFpYqNfGEP7QSf
         A9Sxar1OkxRJev9M9XSWJOuDagNnoCcUBBkUIl6jd6AjiMKluLrjwjZw4CN4y/geW5ny
         Olfg==
X-Forwarded-Encrypted: i=1; AFNElJ/v5/zNKoa3fEkdk82kiEAibj4z/sjJ44DaGx64uOsfu63wYAO+mVyFxGPaEeLOTiw5jufhL+mzi60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7fMF7vLh4b/uo1MelI/Ffg08MrLAnksxsTli8dhQugdv2cc1g
	PGPRSWtAZgb/yJS7e9Te1ssTeOrv19I6hlWhbt1an/qHMGT0DiBS0V7c
X-Gm-Gg: Acq92OFLSxjfdRL9KFDp3qxyty5gPi9IxDyPJgFZO6XXSo5JFU0t8kiBWZb82AkGGE5
	0NmnGemtfYMWmKih5TTNOhPhD+0mqkJOgqO2NtvS9yA4N8HPHcIMLD9gbuboERN4Wgh3Vf6q+tC
	cbDhjIA+KrmoSX0tLUaURMk/HcP4UKF35xCOGmIcRgXqr860j/bRYOy32/b7U+Q9Qe56vBJvOqg
	UX9m8K6d65wXuhXPr3jV/rPc839dcUenUKgXUpcDIRY2ONT+fgPWHGpwYFGSw9tU8+XTBeUz1St
	GRPEECfrBglhKB04TZbHBdYd14sWY+rWczdj/ZBerSVzmFfADZ4X5YxskceL2ZvlF7LBjO54fVX
	GtnGOo7Erq0wlwhzsLE8AXShIGJ8Ti11tjyKVNoEd4fZcgzaI7vXTbg92/1YODcD37Ayxh4lj1d
	mfdLm0/W5UJ3P3gc+VBETdxiZxqBH3NCAFKaTURitSrPb8tvuDqip5kEtBQA==
X-Received: by 2002:adf:fa0c:0:b0:451:b3ca:674f with SMTP id ffacd0b85a97d-452e78b3e99mr13844456f8f.1.1778336561766;
        Sat, 09 May 2026 07:22:41 -0700 (PDT)
Received: from DB-07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45492271510sm15127763f8f.37.2026.05.09.07.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 07:22:41 -0700 (PDT)
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
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v3 5/5] iio: dac: ad5504: fix scale via output-range-microvolt
Date: Sat,  9 May 2026 15:20:43 +0100
Message-ID: <20260509142047.30302-6-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260509142047.30302-1-0rayn.dev@gmail.com>
References: <20260509142047.30302-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD5504 full-scale range is hardware-determined by the R_SEL pin,
not the VCC supply voltage.

Fix the scaling logic by reading the standard 'output-range-microvolt'
property from the device tree instead of querying the VCC regulator or
relying on legacy platform data (pdata).

As a result of this transition:
- The 'vcc' regulator is now only enabled, not read.
- Legacy pdata support is removed, as it is no longer required for
  fallback voltage calculations.
- Strict array bounds checking is added for the DT property.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 9e95da6e49d6..040f580b8282 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -14,10 +14,12 @@
 #include <linux/kstrtox.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include <linux/iio/dac/ad5504.h>
 #include <linux/iio/events.h>
@@ -274,9 +276,9 @@ static const struct iio_chan_spec ad5504_channels[] = {
 static int ad5504_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
-	const struct ad5504_platform_data *pdata = dev_get_platdata(dev);
 	struct iio_dev *indio_dev;
 	struct ad5504_state *st;
+	u32 range[2];
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -285,16 +287,19 @@ static int ad5504_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
-	if (ret < 0 && ret != -ENODEV)
+	ret = devm_regulator_get_enable(dev, "vcc");
+	if (ret && ret != -ENODEV)
 		return ret;
-	if (ret == -ENODEV) {
-		if (pdata->vref_mv)
-			st->vref_mv = pdata->vref_mv;
-		else
-			dev_warn(dev, "reference voltage unspecified\n");
-	} else {
-		st->vref_mv = ret / 1000;
+
+	st->vref_mv = 60 * MILLI;
+	ret = device_property_read_u32_array(dev, "output-range-microvolt",
+					     range, ARRAY_SIZE(range));
+	if (!ret) {
+		if (range[0] != 0 || (range[1] != 30 * MICRO && range[1] != 60 * MICRO))
+			return -EINVAL;
+
+		if (range[1] == 30 * MICRO)
+			st->vref_mv = 30 * MILLI;
 	}
 
 	st->spi = spi;
-- 
2.47.3

