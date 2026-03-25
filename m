Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F1355F30
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 06:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420400; cv=none; b=cogKYWlWIkVzn3jhlHBfnmJrciurRkql9alm4mJYNZAvSNvk20NOnkt90AyYKLJQVW/Nog6lRNHFbDl3dhtTDXNzua2rnB4ZfZ2bLMWtClgP3TceFbiDXE4LMH+fGB4USbbSdTOOdhfpa9UIsGeDAYqqLl/c5n3G/mT1xhexmFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420400; c=relaxed/simple;
	bh=uHir9CYrWEBi781+9y6gAhB+KAavpeSqcW3nrlXIWqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDd5/TmYtlpQ08muCKLN1pnldidZ5EvvfqwExSxVTMCrz3sjbSdFIiFNYoBX/+A7dGZhwLJt+Oh/70BWPwOU57AhnBaAs6EWSQ3L1qs97ACMBeyo0EIRQnZeMF63H0wS/YY2FcEUfnnwUdjNCzMBowXxuloAAn7/mOycw/kwcbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35b905a05a8so3683106a91.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 23:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420398; x=1775025198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3T22FtHj7PiVjh8CPSoc3ZFVw7lP3ieK+jLM3FL9ck=;
        b=UaLqiNSnE1ZfN0y6z8UQ2UhaosQg6vaFNFE+Tv6y7+AQyivpXBymXHvwulH7ElFlKn
         DqaSY8EYa0p4iFfi0fdttAPxX0i/fBE//RIAXkiJw6i1MIWjlx6GL9B0t0mLKCW3GItB
         LVSayZHHC4L1Rc5tgr5tx7w/DPNYIwpCEh/OJPrQ7fgF0iebUgnoaGZPsRnBzM0X7GUL
         agBaMk2R6UU4Gh9lajs7PesxGMG5Vv0F1Nvsap/PW2fsyHAHrSYOARS0rx3DeP1xtdo8
         R5Pt8dmlGquj1RdYH4DSndIyFFcOrD4Ys8GqT2/mr1uhdL0mm9KulbCNrCS9I//3p8BZ
         asGg==
X-Gm-Message-State: AOJu0YyFSHvM20c6nQ52vM+sYpLdLIOadXhtWaam4jeoiYytiJv+ZXqd
	V6ZX3siEin8N0YzutCVUz7CEnPMqtJjs4qzYQCs7oIMkxm2CUyr6GwgvFfQoIjWlZbU=
X-Gm-Gg: ATEYQzwOmC47MvxLvUnPSEGKkWeRs8iTQEgGoNBt6cOZtYbSPJeLc2NdBYH77KDSTU/
	NFkyoVs56sdfqlgW7cbHSq5tITYbYC6myk54ChrULsnRfIxhnk9tv7WIs+xiLedwApWK5fp6m9i
	B0R8741BbSJ2Fizfore7JwbtBnDcCz2LZSvedp6uxbwrlinfP8BzysifjHDtrzAP+eQGAtnL3cD
	J1xUpISXfXSf3twJ3w4LAWb/Op1ErdYpaqRKNy2sNgpsSfVQvdUpqWhCH2bpIlDu5Ae74YZcQFQ
	+dKT14YItHIVremZ4YjbD+gjDCm2q98CZYZzwfyuFMXLVYPsF4iutv5Hn1Eokj6jznxF7q6vrAT
	lIJtwXyJdGtj6cVQvdXc9GKsk+JDLqoB7d85CQv6SDNAfhK64TwXHx3zPIgc63dH43Q3qP1+ROj
	KaBXro1NuYJ/syjLqdEXNqQsHFR0MGm/fjzClV1zho53q4SXLggc4zv7hdFfQEkj/n52R/Zuyum
	wxvlV680PCLMTTrfg==
X-Received: by 2002:a17:90b:3c08:b0:35b:945d:752a with SMTP id 98e67ed59e1d1-35c0dd6b7bfmr2049677a91.17.1774420398092;
        Tue, 24 Mar 2026 23:33:18 -0700 (PDT)
Received: from archlinux ([103.135.252.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0e954ba9sm526854a91.5.2026.03.24.23.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 23:33:17 -0700 (PDT)
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
Subject: [PATCH v7 0/2] iio: proximity: add driver for ST VL53L1X ToF sensor
Date: Wed, 25 Mar 2026 12:32:21 +0600
Message-ID: <20260325063254.18062-1-email@sirat.me>
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
vdd-supply is now required. The VL53L0X required a physical
regulator, but it did not specify the requirement in the binding.
It should have always been there. The VL53L1X also requires it.
Hence I added the requirement.

---
Changes in v7:
- Add VL53L1X_REG_ prefix for register defines.
- Use iio_push_to_buffers_with_ts().
- Use continuous ranging and drop postenable/predisable.
- Add comments for XSHUT reset, default config values.
- Drop vdd-supply description in binding and comment in driver.
- Add ABI rationale for vdd-supply to commit message (per Krzysztof, Jonathan).


Changes in v6:
- Make vdd-supply required. Add descriptions to vdd-supply and reset-gpios (per Jonathan).
- Check reset_control_deassert() return value (per Andy).
- Use volatile table for result registers and caching for the rest. Also mark write-only registers.


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

Link to v6: https://lore.kernel.org/linux-iio/20260319190738.151614-1-email@sirat.me
Link to v5: https://lore.kernel.org/linux-iio/20260313113737.151881-1-email@sirat.me
Link to v4: https://lore.kernel.org/linux-iio/20260312183721.40482-1-email@sirat.me
Link to v3: https://lore.kernel.org/linux-iio/20260311224044.21480-1-email@sirat.me
Link to v2: https://lore.kernel.org/linux-iio/20260308113728.40860-1-email@sirat.me
Link to v1: https://lore.kernel.org/linux-iio/20260303090253.42076-1-email@sirat.me

Siratul Islam (2):
  dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
  iio: proximity: add driver for ST VL53L1X ToF sensor

 .../bindings/iio/proximity/st,vl53l0x.yaml    |  13 +-
 MAINTAINERS                                   |   7 +
 drivers/iio/proximity/Kconfig                 |  15 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/vl53l1x-i2c.c           | 795 ++++++++++++++++++
 5 files changed, 828 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iio/proximity/vl53l1x-i2c.c

--
2.53.0

