Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42E3328FD
	for <linux-iio@vger.kernel.org>; Fri, 13 Mar 2026 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401898; cv=none; b=toBU3GnIX85V+m3S5Wr2LTUBhwmLb33VSO2NyCXVOh2hmzgQsun+klql32IOZeIxzAnG2y5MBmlV4LQvDytWFyQpNmPMMv9le9NQT6tRlvp3/f1+qz5BKMXm4cwc0Ms7UTSnyyWWJq+NVvHLUvmzZI/Iwa4pSBbs1i0SZYV4hhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401898; c=relaxed/simple;
	bh=m4+7xMrfEGL9ZdDvO0N0T8EsF5PKxUkjMZrslxnTVAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9sqQShu6Kn0SSFNWeX5f7ZEAo1ma3oR6EsiJCuhl1UHYdaVAk0dRtmKRDdwfbChbyyHc5F/WKhFrotRd5+d1jNDLeqR/OjYfDDxdABMSd63vYiDzZvCKMZpckbLw1rJfbVg9+ADLTTKGINcsvwrvtQlX8DbMvoPf3eQ5++2usY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c73eeb28d06so122006a12.3
        for <linux-iio@vger.kernel.org>; Fri, 13 Mar 2026 04:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773401896; x=1774006696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Hu1+cqmmNQHQzQbURPkJOzHTpJUe4XVQu5K+hYLqDw=;
        b=Ijw2fVVsfmM9cGnwqfnCZMwOq1BpkeeKdQIO7N/uVh0/K5lJ7ND/9RL9DUrIIB6xWh
         NBDQ2Q5BPhNJcL00V6JYwN41e7+aj4bREA+vBsRCvef/sKAOTidP0JFvoMInFf2gXN6f
         YmCUGH2JKjyoA56JxtHlnJEsFxv1V3f9H6IR2Vz9qDlNydAfGmqOms8rYo/4XRF1bgab
         suajk7FrRtEQEqvqaZzccS2dP4JxfBGtUozb/a7YKk2sLjllKMXSmMDhCECYO0Xq+8rv
         PM6QXS+jLpa9tScAx6EQLFzocEAGoZOtz+0kQvsrgeffDQ1dA2warGs1MgzCb25CDQCi
         oo4g==
X-Gm-Message-State: AOJu0YzqXcN+rCIthA8VRzEFazLpTE/DV+12qnCW9EQJ7C7MrFjxOIKt
	5b9GucpGRF/8p9Z9EAJglTdRNXjjSfu6bTYaV27giRimCV9qNat12izctjOZLGfRDJUvpUho
X-Gm-Gg: ATEYQzyMIt6eG3EggElLxsNfHXWNjOH0frDUM4jT1rLqUDl8zMwNplfnTBh4TfeMmzC
	eC5m6Bsn2qAOiXtjm1J77jrq7NeVE+gF7JLnBBdwwAr+7B6rm/jpniyPXlPssVH3NzyQpHAqTLz
	0IlsUVRG96Q6ekL3KgzVCiwFXSlsdizJbsF3h8bXWzIY4RapeFIRkemqrZOARtdZcqH0KyjcBQt
	GI9EVA/LPgWCVWgXB+agPx5bsgjFTpaJbXLGUpCYH97hTDPYu7ITPDOCDBEAOx1uj0XDymVMdAg
	sdrp6C9kULD0jT9Vj3F764wuw7dIf0htCKrg8o52mc9625K8NxVBzLhat3ON0dkLlH4WglVGpX2
	lwVT9uutXVPymQQDlpvzv1FRdskuZfYGnc6bwjCXTfx5HXRkBx0QZ8QS91fvTASW/pF3PoXS47q
	K5qcNr+NDB3Bfz/XCPhsSVKdYmYg0Z46V7D872pNgMxXgHVZXPmJLrPHIStD6y8eiyylOULHJ4E
	G0=
X-Received: by 2002:a05:6a20:4321:b0:398:7086:7190 with SMTP id adf61e73a8af0-398ecad559cmr2643629637.22.1773401895892;
        Fri, 13 Mar 2026 04:38:15 -0700 (PDT)
Received: from archlinux ([103.135.252.26])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb75624sm1669419a12.24.2026.03.13.04.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 04:38:15 -0700 (PDT)
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
Subject: [PATCH v5 0/2] iio: proximity: add driver for ST VL53L1X ToF sensor
Date: Fri, 13 Mar 2026 17:37:16 +0600
Message-ID: <20260313113737.151881-1-email@sirat.me>
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
Changes in v5:
- Patch 1: No changes. Collected Reviewed-by tag from Krzysztof Kozlowski.
- Switch XSHUT pin handling from the GPIO consumer API to the Reset controller API.
- Drop <linux/gpio/consumer.h> and include <linux/reset.h>.


Changes in v4:
- Move i2c_check_functionality() to the top of probe before allocations.
- Use struct u32_fract for oscillator correction math.
- Explicitly set .cache_type = REGCACHE_NONE.
- Document intentional predisable drain
- Use dev_err_probe() for firmware boot timeout and remove duplicate IRQ request error message.
- Use sizeof() in regmap bulk read/writes instead of hardcoded lengths.
- Add missing headers (<linux/math.h>, <linux/time.h>, <asm/byteorder.h>).
- Various formatting cleanups per Andy's review.


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

Link to v4: https://lore.kernel.org/linux-iio/20260312183721.40482-1-email@sirat.me
Link to v3: https://lore.kernel.org/linux-iio/20260311224044.21480-1-email@sirat.me
Link to v2: https://lore.kernel.org/linux-iio/20260308113728.40860-1-email@sirat.me
Link to v1: https://lore.kernel.org/linux-iio/20260303090253.42076-1-email@sirat.me

Siratul Islam (2):
  dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
  iio: proximity: add driver for ST VL53L1X ToF sensor

 .../bindings/iio/proximity/st,vl53l0x.yaml    |   7 +-
 MAINTAINERS                                   |   7 +
 drivers/iio/proximity/Kconfig                 |  15 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/vl53l1x-i2c.c           | 777 ++++++++++++++++++
 5 files changed, 805 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/proximity/vl53l1x-i2c.c

--
2.53.0

