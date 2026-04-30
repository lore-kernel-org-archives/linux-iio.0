Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5846347DD6C
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576022; cv=none; b=SVJ2CUDvNLwjU3VktNDGht8cMZQ06Yj3dErxs6hTJPMaJ6vALmLjne8jwj/9SorVMLdVKymCEmg3+iLN2w5jKNsNPzpafBbSHaNzjpbwW2V1wtdK+9ZAX6fRNn4QTODb+hH8IfeE66i0tHR9zcQIUlM9PrvaiqO8kp66nixEZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576022; c=relaxed/simple;
	bh=on8rY6M8Ze5gBXgHbY2tQYWmu1oh3yHvg8kXWMkqx+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZG6lZn97fr8lDD/7sD4qoXmARPG1fIes3EB/ue5gNfNCXTi/NINbAPcX3Uol1HtAwwob93AxL+lZerAzb4JGSwtXqBftObonkdMfgibYsACXwHBSGcur8EU2jeQfAc8p/vfFersOpo+rwXUa2+m80J2nCBLhrE19i2fMMstats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDDlxsKh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDDlxsKh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2adbfab4501so5744955ad.2
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 12:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777576021; x=1778180821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsD2PkLQ50ZO3yWWZ560wIgWdjWwc4cb03biqdYs+Xk=;
        b=BDDlxsKhd+2UyIJoiDP5JuftyjIAtfACssAeZvdclskyaGnyRwyJNnv5PmmT8q82fo
         mfX4GT+iTrverwb5uIL86WxR6SWvCYj8cQVn0m6EzgR1/6MKtC5WM8TebHUd2HU0/sNP
         Vu9eU6mTd+HLsdrv8/xQRWLPsgyALGuPhsaFDlan3a40LAB6mF54KLPHZJXYpA8ONwjU
         Iq2A/7X97MCztp8q1KsLJImXRDpQI3D4qUO4yBgQUhXIASM5IMxq6G1/Z8onHtkaBWOx
         N9nijLVlrnfmO2zdFZenjSYSoWKbPJXop/PrdMPXIhAEV8hNPyLbBfJR5fJc9D3cbSq+
         3m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576021; x=1778180821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gsD2PkLQ50ZO3yWWZ560wIgWdjWwc4cb03biqdYs+Xk=;
        b=a9KPk3EWmzmjTrA0Jvo6yW5XndSucALXcIyiSbp9T8ftqZl4bYz4vEw2XU4jlFZM3a
         N3E9k8iwmpwDFoiKcK2dWtldYcmlt4Vzlz567ReHhqe8dcGCGtLmEBZZXfHt3Z2RuM34
         FsxuCBev+4i/cmo+rZmZXL13VJFq7n2dOJZhR+h6rI2i93GfNDGSJ8THf0IDqrFcZbvF
         WnuHXATE0h5+9TML4bP3GKYvRcmonmuF/sYa7SvpNWXq5wXyyR+0E73wR8roW+KM0v9c
         hGCne/F/r/kiCXr9QDPOw6dgjapjvPPJesG+TuBSEhdzwC8JVNZNJaolxgE9b4OIo0JY
         Xz6w==
X-Forwarded-Encrypted: i=1; AFNElJ/9F5cKVeLvkpc6lnMFAtg4Ntksq/ZSeIm2CFQkbiB/P4HbYvQEdDsJUZOui68/Hu08UBo0/+vBFUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn/Sx3LWl+7znV9q96SADajli6ZODX9668LV9RmcjG2BaPNjur
	AwtFuAZ+dpkhuytuAKq7LW0D2tT1VjepsEnvpe9S1DMMvRkdoUosEAsu
X-Gm-Gg: AeBDiet5Op6Mvb6LnnuON8qaV8USNA8LdHB4Y1Bz8TcLCg8egOPQhuXVCYPVVqOr21Z
	rYU4XzFCoGRTULCUIn93HXytp2wDi8yRGy9Kbb2WrUOUOSJVg/6yN2x5qSMLOi6lAy8o0fKZgth
	mfn7x654hYdE2IDaIyLFwQjuBXZHr8TgWzLmzpNN8uWBKhlT5mcee7Tz3SgzHtoLZWUgDT2KICD
	Wkch1YOfMpXFMrj0VCZoTLIysVI81kejcLk/ECCPbQE5mbLRze/LXvTixPm9G6ql+WW8t1+jeoP
	z6PhSWbTXKP/VUAAo5504KTAtdqS9swiC7u/X2y6AjjhW4DzMQzTMeHa0+ChZDf+AjnNPuzLGpt
	A3dYiPDEyKghdTVbJGkvmvzq4abVlXVEep6dU+RqQlvKXTdRy/C+l+Ph677qwjkQoGfKYwFafLR
	9YuN20uIun/u0uLmyzFdaXmibPxvL5mbb/o7nRD/qVnXTnhEuc6BpC1rhjrWo=
X-Received: by 2002:a17:902:ebca:b0:2b4:7b57:5d77 with SMTP id d9443c01a7336-2b9a24b5eb5mr43603705ad.26.1777576020403;
        Thu, 30 Apr 2026 12:07:00 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae16067sm3332185ad.40.2026.04.30.12.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:07:00 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	lars@metafoo.de,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] MAINTAINERS: iio: adi: consolidate entries
Date: Fri,  1 May 2026 00:36:41 +0530
Message-Id: <20260430190642.3434650-5-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430190642.3434650-1-sanjayembedded@gmail.com>
References: <20260430190642.3434650-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Remove redundant per-driver entries already covered by wildcard paths
under ANALOG DEVICES INC IIO DRIVERS for frequency, accel adi driver(s).

Keep entries where specific maintainers exist.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 MAINTAINERS | 71 -----------------------------------------------------
 1 file changed, 71 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f07175ef8fe..fe50ca0c24d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -599,37 +599,6 @@ F:	drivers/iio/accel/adxl355_core.c
 F:	drivers/iio/accel/adxl355_i2c.c
 F:	drivers/iio/accel/adxl355_spi.c
 
-ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
-F:	drivers/iio/accel/adxl367*
-
-ADXL371/ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
-M:	Michael Hennerich <michael.hennerich@analog.com>
-M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
-M:	Nuno Sá <nuno.sa@analog.com>
-M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
-F:	drivers/iio/accel/adxl372.c
-F:	drivers/iio/accel/adxl372_i2c.c
-F:	drivers/iio/accel/adxl372_spi.c
-
-ADXL380 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
-M:	Ramona Gradinariu <ramona.gradinariu@analog.com>
-M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
-F:	drivers/iio/accel/adxl380.c
-F:	drivers/iio/accel/adxl380.h
-F:	drivers/iio/accel/adxl380_i2c.c
-F:	drivers/iio/accel/adxl380_spi.c
-
 AEONSEMI PHY DRIVER
 M:	Christian Marangi <ansuelsmth@gmail.com>
 L:	netdev@vger.kernel.org
@@ -1446,14 +1415,6 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
 F:	drivers/iio/amplifiers/ada4250.c
 
-ANALOG DEVICES INC ADF4377 DRIVER
-M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
-F:	drivers/iio/frequency/adf4377.c
-
 ANALOG DEVICES INC ADGS1408 DRIVER
 M:	Mircea Caprioru <mircea.caprioru@analog.com>
 S:	Supported
@@ -1519,30 +1480,6 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
 F:	drivers/hwmon/adm1177.c
 
-ANALOG DEVICES INC ADMFM2000 DRIVER
-M:	Kim Seer Paller <kimseer.paller@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
-F:	drivers/iio/frequency/admfm2000.c
-
-ANALOG DEVICES INC ADMV1013 DRIVER
-M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
-F:	drivers/iio/frequency/admv1013.c
-
-ANALOG DEVICES INC ADMV1014 DRIVER
-M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
-F:	drivers/iio/frequency/admv1014.c
-
 ANALOG DEVICES INC ADMV8818 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org
@@ -1565,14 +1502,6 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/power/supply/adp5061.c
 
-ANALOG DEVICES INC ADRF6780 DRIVER
-M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-W:	https://ez.analog.com/linux-software-drivers
-F:	Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
-F:	drivers/iio/frequency/adrf6780.c
-
 ANALOG DEVICES INC ADV7180 DRIVER
 M:	Lars-Peter Clausen <lars@metafoo.de>
 L:	linux-media@vger.kernel.org
-- 
2.34.1

