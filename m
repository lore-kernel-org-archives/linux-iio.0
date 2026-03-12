Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413F93DA7E3
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773340664; cv=none; b=dOqet1yYW8qmk1Kr2ZLTiGQEI2QVJECp8Kiqa2hEMsIiVpTTW1NUS4Zdzj4m3oVp1h0cYIQVtXJzblvGQPnLdqx5OAiC4AzZBda1p4bTUC9MumotLi7fX+GTGCG6a++WRSyj7BsR2VSDe29kg44qCvlyNRukbLl799Bfo+z/g/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773340664; c=relaxed/simple;
	bh=Xw0WVoosWLYpbM1/x8e92YC5jyk7O2KzJM+Ej989dU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dMkGGk6rP0mP5VDxpkJLLFQeydUNynL2H/MlG01qOgKd5xdMVMELaFNNHM/pYg6Kq1va8uUpMNtENW9dI8rxK8pz8NA662IVG7f45viFmZPltCG62Yn59iB7//Es0tF9ZSWYE0D893UzsxqeVO1oR+pjLlgFBsxsXSc0SgFGjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-356337f058aso905725a91.2
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 11:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773340662; x=1773945462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmEeYUDMPwe+39ZrokxzR6qEPglt+cTqXM1Wv6voWxA=;
        b=Hf3nSqsKghdYivXGu0nEotmUe+44dp3Ye+6MFjTttNXZSsJCe/fx/AK6MJLCYZnfyQ
         iOkHZxaU4WEKIANcBA0C+M45bCYXfVIS/G1slZ5N5hRrNLFTi+BYkCs8rkz8Y/NPdZG/
         BpoDIn9s0jZYM4HlGFz4e1zwhT7H1plR+9Clzq4MRy29p2Skc0nRrTrLT1CpJ+tujmZo
         mvTrIsVkb+lb2bQfew+6UzdMRRJ9uS4hL2P1fQZrFvxqx0Fp+APxJ5tUsAkpnDxZYap9
         AWBYEvv9eTRLoFFwbXUaGapXatxguZrDLMCfGR1zCjBKNpwQyK72bD9SUZC0AEuX2kYo
         ckzw==
X-Gm-Message-State: AOJu0YyAdvMhEVvHN3QFrxKHEx/nMWRZWJGOM6ok+8soh7kcn0y04fhY
	XYTCoa8VvwLFcczsbyT2nqBKOZ1/FaLY/fuFS2JRCLu39HH8eU0BJR9Zu467n1HbVTPyIyMz
X-Gm-Gg: ATEYQzws8BMZyw+kVm9ZONCIAxU7ZotkHajrIt4pKVUIOS17L+aFC2ON3pdUbMiuhj5
	FXnF4U0cqFt563V3jKHSlaz4aiv6PC2SjDizaJJ4xlEgkRjU7mN8sM+46eaYKpgtk8xp7M8U20E
	4RaVUy+kpXkn/S1pAwRwemyPB8kDG8FgXu34FIQx8dLFsAPj/9P1141k082sGc17wSd6d+FP16f
	djWevpEtsI7NWfx68LlaIo0tIjJLGLyH/QFS2lp+RcT9Y1gkfZ0RA758sj7W8uqcBqxYqaBzXqD
	vLPeuEJrejOqYD4BhRYDoRpxrjdwg8lEJVOqWgts49GzCxi7gEFKzUTcdOLeMaRCkhaJvvEBlP9
	ssnov/KQ5QemidpUjkuAkAGDqYaiDQmWFJeiRHc44T6/3zV1IVeKxgrp3xfX6jE5CWX163B/yzH
	lRR2Htfc0Fbs8J3w==
X-Received: by 2002:a17:90b:1c0b:b0:359:f5f4:773a with SMTP id 98e67ed59e1d1-35a21f339b3mr610906a91.8.1773340662179;
        Thu, 12 Mar 2026 11:37:42 -0700 (PDT)
Received: from archlinux ([103.135.252.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a11b42ce4sm3645612a91.6.2026.03.12.11.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 11:37:41 -0700 (PDT)
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
Subject: [PATCH v4 0/2] iio: proximity: add driver for ST VL53L1X ToF sensor
Date: Fri, 13 Mar 2026 00:37:16 +0600
Message-ID: <20260312183721.40482-1-email@sirat.me>
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

Link to v3: https://lore.kernel.org/linux-iio/20260311224044.21480-1-email@sirat.me
Link to v2: https://lore.kernel.org/linux-iio/20260308113728.40860-1-email@sirat.me
Link to v1: https://lore.kernel.org/linux-iio/20260303090253.42076-1-email@sirat.me

Siratul Islam (2):
  dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
  iio: proximity: add driver for ST VL53L1X ToF sensor

 .../bindings/iio/proximity/st,vl53l0x.yaml    |   7 +-
 MAINTAINERS                                   |   7 +
 drivers/iio/proximity/Kconfig                 |  14 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/vl53l1x-i2c.c           | 774 ++++++++++++++++++
 5 files changed, 801 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/proximity/vl53l1x-i2c.c

--
2.53.0

