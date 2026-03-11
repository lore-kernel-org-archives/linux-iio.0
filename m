Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6688E36A03F
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 22:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268924; cv=none; b=Iz0rdWM45Hx/mcb3S/6AI0XEsgELFTsno6mqzjbrJ4Vwwa70xVYYNduijVE2I1K7GfgV5ehQf38T5xw8Jtk1X6CSmSt6vnCO1mV0hiAsoh81r+txqfRjDxEQxizHLiw6cpKv9cEEA3DZ0iN+A+CBZZfuaoZq6EUIRZkN2x1MByM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268924; c=relaxed/simple;
	bh=2j1cpITxnYiUxed8qCEHQ/UCint47S1M4TXHNtCpqOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFBfx0c/vl8Jsp09ZqyziN14tJFIQAD4vtumlMKbn0Y8jT8PyvAP792S4oi9vbQmO09P9CsaGxs+cYoA1K08C+DhlSqgGaAdQwDqJRGiRl58cS41FbamALNfh0YmW19Ec0W5YhLuxEIE5qO7kBJ+jiUs2tGx5exlngAxaz9XAYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aae146b604so2953545ad.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 15:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773268923; x=1773873723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCi4OyQ+FJJiiBErv6cFAwHqHFdsy9nwyy/hORJpyfc=;
        b=sgWna1xunReSBmEyHPZh4mXLAbKm24l0ONjxdA0HmBktOYTc9c9eVkEouCArhed39E
         nTtGvYO3T1QB3RDni7rfH9fGLdTOXxStCpIbJ/XyvxAFWIwT4+AAcg5Aq3Y9A1lT2KU3
         fkhNIRKR7l73jnDTbqY6hO8Sk/m2AQd0w0zCSP2dG7/sjfI5zo1tuju4S1rM1OSZTdqn
         W3VBIBykOCmoDtOQCu5EWFtJRfl+qvz2Q4EP5qc4QHMuNKv7XRnjw9dvzZ9FAd9Ix7qS
         9OG1h9Xm8DLCvAwzf+0I8IlH6JdUbthJsaQS70OUMWq2nJNI3mWh49aAxg7EYjlI3mko
         IbHg==
X-Gm-Message-State: AOJu0Ywk6bVMXJlad1c4LFpBPBuKs3VsJ7Qf4UIRmPRiix8fiDeFs8zG
	vfmA3Kl6XH8f4tpPHfMnPCJ7u8KQJMnwv/JC8cCTXD50KM+8xbWOLoJ6RkFKBeURAbo=
X-Gm-Gg: ATEYQzy3uHTnAPulnA8c2Nd/DOTnsidalQX6c9umsHFQAhnedb2bbAZm3qgcParNhLm
	+iAXyZ0EPRAM88MSV8M3/J7Tabxxu+e9xbbobwZA2lR+RVRYHpIyjKMzWCzhg8s0qD/M1dikSG5
	G6Rn9mZhMVlZaR3p0dXhi7IjJdC7r2px5Kn4kMAJ2x/VemU1gOUQON3TXy+lGcfJOu0o9jI3xnv
	93SVjO/+1/GjehhNibYuX9wBX4N3vHK8weoHHuzWK0Co+tvVq8/dmjnf4dKqy1lwywJk7b+4p6E
	9Jsb1xvs6DvCYg9Y9TPpnD3sN6KIUobtIMgb+OGTYkQn2e4ai9fdLAmw6SeA5OwmKTYVq/COZ4Z
	qcv7ES/9l5Uh6WTbfiWlDRCJQiB7cC+T5YUn1DyVa1lBUfqgJ+3G60YszZgR4QhOqNWXPfsVsb+
	46PAfdfweP/GXQlILu4B1g9jW/sImsthFM7mFXqqI=
X-Received: by 2002:a17:902:ea0e:b0:2a9:622e:fd46 with SMTP id d9443c01a7336-2aeae65194dmr44250475ad.0.1773268922415;
        Wed, 11 Mar 2026 15:42:02 -0700 (PDT)
Received: from archlinux.www.tp-link.com ([103.135.252.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae35ef5asm32854975ad.65.2026.03.11.15.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 15:42:02 -0700 (PDT)
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
Subject: [PATCH v3 0/2] iio: proximity: add driver for ST VL53L1X ToF sensor
Date: Thu, 12 Mar 2026 04:40:35 +0600
Message-ID: <20260311224044.21480-1-email@sirat.me>
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

Why a separate driver is needed (instead of extending vl53l0x-i2c.c):
The VL53L1X is fundamentally different from the VL53L0X despite the
similar naming. Extending the existing driver would require rewriting
the majority of it.

Key differences include:
- A different register map (16-bit addresses vs. 8-bit addresses).
- Requires a 91-byte firmware configuration blob to be loaded at boot.
- Requires a VHV calibration cycle.
- Has distance mode and timing budget configurations.
- Uses the regmap API rather than raw i2c_smbus calls.

I also reviewed other drivers in drivers/iio/proximity/ and can
confirm this IP block does not appear to be shared by any other
existing driver.

Tested on Raspberry Pi 5 with a VL53L1X breakout board.

Note on vdd-supply:
In v2, I added vdd-supply as required. Since I'm using the
shared st,vl53l0x.yaml binding now, I had to drop that requirement
to avoid breaking backward compatibility for existing st,vl53l0x
devicetrees. The driver itself still uses non-optional
devm_regulator_get() so no change there.

---
Changes in v3:
- Merge DT binding into existing st,vl53l0x.yaml (per Krzysztof).
- Use "reset-gpios" in the binding but xshut_gpio in the driver since that's the actual pin name.
- Replace manual polling loops in chip_init and read_proximity with regmap_read_poll_timeout().
- Remove irq_get_trigger_type() and pass IRQF_NO_THREAD directly (per Andy).
- Drop struct i2c_client from private data and store irq as int instead. Derive struct device from regmap where needed.
- Add dev_err_probe() to first devm_request_irq() error path.
- Replace linux/device.h with linux/dev_printk.h, add linux/array_size.h, linux/err.h, linux/types.h (per Andy).
- Use USEC_PER_MSEC for poll timeouts.
- Remove unnecessary casts.
- Divide long config blob to 8 values per line.
- Rename goto label to notify_and_clear_irq and drop unused dev_dbg.
- Add datasheet section reference for boot delay comment.
- vdd-supply no longer required in shared binding to avoid breaking existing st,vl53l0x devicetrees.


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

Link to v2: https://lore.kernel.org/linux-iio/20260308113728.40860-1-email@sirat.me
Link to v1: https://lore.kernel.org/linux-iio/20260303090253.42076-1-email@sirat.me

Siratul Islam (2):
  dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
  iio: proximity: add driver for ST VL53L1X ToF sensor

 .../bindings/iio/proximity/st,vl53l0x.yaml    |   7 +-
 MAINTAINERS                                   |   7 +
 drivers/iio/proximity/Kconfig                 |  14 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/vl53l1x-i2c.c           | 782 ++++++++++++++++++
 5 files changed, 809 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/proximity/vl53l1x-i2c.c

--
2.53.0

