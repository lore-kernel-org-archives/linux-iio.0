Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC412DAFDD
	for <linux-iio@vger.kernel.org>; Sun,  8 Mar 2026 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772969991; cv=none; b=O9dC0wkyrQ+YOrOgwJU0ORQrDVDOfAEO9m8a0VXRbAD1J+qnsqKgwWllHB+Am/47naZkbYAJibaKK78+LElVZ4pA9we4WQdo2PFnpFj9TIk/A9rMl6uwCW1TV5mQi9ocbdUg2YzQlcpQNqQ1Lalus4ktNpL3M8TWQ3M43uJn/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772969991; c=relaxed/simple;
	bh=yI8bfDMx/Z63T+/yVkbejQlnh7XwP6Hsx4c68fkA1ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VD5CGqatLJtbgL+ozDZneFDdi0QcXmoZXk2DedXUF77map3c4fcVtK21eDwkyBYAB0mUDqlJc0nIWArSCM80CGGk41i0+wH36bwixWSZXEcduPQWCx/nvjVW9Kryif8cnhkqrN9EimMtoTDsuN143a3sc/vd23SzLzbIEJ8R3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-829ac8d56c5so1683903b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 04:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772969990; x=1773574790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxVDaap99T3jnlrvfxzeEz0s1DNltbeqL5PwkokGy6U=;
        b=wixaMNPMAHTCnUgNQFoeW/dYKC2F+rWrPHuyg3i2cPtVQujuHbaL4N3gBsF6nndTUK
         +JQ9aAFpAZqRUalxVHnOSIhKBgSUqiFajUC6IcO1dipSiR/fIYiKzAy0pDDflquVnPEU
         rhhAr1gJK7hpBN8SAXAOQ2ov+4ArniaO79Z4q+slQENSnjrMNatCo7wVIC5vtRQNDQCW
         8RRTkgejYRm1YAp67NxCCrfHUYs/kDHIHYq/aU9t/0i5Ce8izPaEbSCmRWKmQwr5nzbc
         Mfkc7KuSj2M86P0y1weVmim8AmHBxKXcWqvluvWlxgFp3etmqF0wGzZCKBXgXo11wOqM
         nABw==
X-Gm-Message-State: AOJu0YzyitSQprcAoFJAGM1t4I747+L8o5NfLXgX5fhshwDmoDFWYzYL
	m0VFWzWh81N1kvompr+tZDmPaTakR8Grt4UEUbKESCTdqiy7TqIKMYL/QjXjBYVjJtAodQ==
X-Gm-Gg: ATEYQzz5IcbhPh3S68WRKEUOYEqKK9wqdRxRcBPK1+7Rj0FpHz9O84YCKFS21Fk/T/o
	8IKLYH9A1UHoDCn5TxJ0YLzOPA85Cju0L2ZRFZ/KuXkgcZfJBr2UsP2f8OLwZw3x6LE78YfX+SK
	d50FuY6IoJOfFolNTmqaBwecBwrLuUdu99IgX55tzawBneesxCm83zYYzq44HGi/7wzLlqIKPw3
	+2j2IrUQtjpRZRjea+c8YUzeK6YwctHchtSo7jhUmRUnL5AccSEucBLaLE7+b/KurjW4Z2BnXdp
	iLd9UdzzmhAWIdm31NOf9AAQXnQXPD5BfrCmMMouBLWOuth+XQbwPkmPuUBiILtziyMkLHfAmsU
	wE6BtKOiXS9j29sk5PnvrZe17X7zoZyS6aiL/9p/k/fIm6gEO6oAtT8+5XAe47uhzkPIp2kN5bA
	w+VmoXEB7YJlkcmErz
X-Received: by 2002:a05:6a00:2d1e:b0:827:2ce5:d762 with SMTP id d2e1a72fcca58-829a2f314d2mr6338259b3a.50.1772969989728;
        Sun, 08 Mar 2026 04:39:49 -0700 (PDT)
Received: from archlinux ([59.152.111.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48d372esm7063721b3a.61.2026.03.08.04.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 04:39:49 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>
Subject: [PATCH v2 0/2] iio: proximity: add driver for ST VL53L1X ToF sensor
Date: Sun,  8 Mar 2026 17:37:26 +0600
Message-ID: <20260308113728.40860-1-email@sirat.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the STMicroelectronics VL53L1X
Time-of-Flight ranging sensor.

The VL53L1X is a ToF laser-ranging sensor with I2C interface,
capable of measuring distances up to 4 meters. The driver
supports both interrupt-driven and polled operation.

Tested on Raspberry Pi 5 with a VL53L1X breakout board.

---
Changes in v2:
- Skip software reset in chip_init when xshut GPIO is available, since the device was already hardware-reset during power-on.
- Rename "reset" GPIO to "xshut" to match the datasheet pin name and updated DT binding accordingly.
- Make vdd-supply required in DT binding.
- Use reg_sequence arrays and regmap_multi_reg_write() for distance mode configuration.
- Switch to a hardirq handler with iio_trigger_poll() and IRQF_NO_THREAD instead of a threaded handler.
- Drop IRQF_TRIGGER_FALLING fallback. Leave trigger type to firmware/DT.
- Use iio_validate_own_trigger() instead of a custom validate_trigger, drop trig pointer from driver data.
- Switch usleep_range() to fsleep() throughout and add comments for sleep values.
- Don't fail probe on unknown model ID, just log with dev_info().
- Split stop_ranging cleanup into its own devm action, separate from power_off.
- Add missing includes: device.h, bitfield.h, completion.h, mod_devicetable.h.
- Use FIELD_GET() for range status checks.
- Move configure_irq() closer to probe(), use dev_err_probe() for its error paths.
- Fix buffer ops symmetry: postdisable -> predisable.
- Drop reg_format_endian from regmap config.
- Various alignment and formatting fixes.

Link to v1: https://lore.kernel.org/linux-iio/20260303090253.42076-1-email@sirat.me

Siratul Islam (2):
  dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
  iio: proximity: add driver for ST VL53L1X ToF sensor

 .../bindings/iio/proximity/st,vl53l1x.yaml    |  50 +
 MAINTAINERS                                   |   7 +
 drivers/iio/proximity/Kconfig                 |  14 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/vl53l1x-i2c.c           | 871 ++++++++++++++++++
 5 files changed, 943 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml
 create mode 100644 drivers/iio/proximity/vl53l1x-i2c.c

--
2.53.0

