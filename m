Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3462E2852
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 03:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786590193; cv=none; b=uj3/LtkIZPj+n7kY3VwUIRCmhgr5hN/QJnTfbbaMgZb6jodwcLkkh2SpIkig5wYOIl4wfrTbhh4089furgUlsRWk6DQqXJws96y4SLVPOsvX096peCPrM7gV9c6T0d6M/rXf04M5ePOqcy3QRM1fjch15Iw4zYwSKW7PG3nEkBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786590193; c=relaxed/simple;
	bh=o6iwz9+QOQv0iQl0bwD9gd+/h8QZEQcsPlowUmEUjaI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n9gU/N2KuPkr+TP2JKR+ONt+LWcx8MwmfiunhmXo8VwDmYrKxIl3N2lZfnkNAo4FFefNaIO4zhQPqoyG3bcb1GTc06nyT/4oSSz3RlPXyTJO6P8vFd8pFQq4cIwvnMBMJZoj1PIi4zXgrDkS7vqC/ws/90gKW5awEkh4//UBaxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtyoclYE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtyoclYE"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e041ea211so1965461a91.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 20:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786590190; x=1787194990; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KyGCUEdENaUO5x8v3vZL0OLOUUVDYJpIzj/gJsQyRMc=;
        b=gtyoclYE7Zcgah3kDsfFy/QKckeY+gchAceJBNjZGKTyNsvMyDTer0r1IaPiNfFNpt
         pHqSiFkriPpfvxXtoEExga4f0bVr88c3Q6VTLj+/nvlPwRzeXpXYi5DCSbZlbAms1KsA
         TfoiMWvUuwd4M5bHV+5Uu6vOknLjsYHenHJGVHPotYmKEBIMFXmVjCmjQA5VQ7sc8cUt
         4ln0JZ/QFc+ERR3El6fGKlC8ICTwtmZEfywH501UmSAJIp2KVD/uKqGTj3dKTP6+zQOi
         +SBXdrouA6AlMlyZq3M+5KXj5u1e0NGEVS5c9Op2akJI4YFZmxF+9o9EPk8InQoDw1fM
         hQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786590190; x=1787194990;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KyGCUEdENaUO5x8v3vZL0OLOUUVDYJpIzj/gJsQyRMc=;
        b=KT4aOd0LtDiklPSP7W+j/SDT+0NtkxwP5IxDOojJkkWkbfNB28KKI50ZwWetwV5A2V
         QLvTw+n05WXszLisDZq+kf79bVCcPufuUbfTh9v47DX9Jp59ghIZwiKhysNv+P0v3A+U
         qSPX8cFrBMCH8pqed4C8WJdx71O0znVba99kfUxFbaVbQw3g/uX94kB5BzNeheI3Gchl
         Mj9UFeEzt4APmr2rHsdUmIBdg2BGqH8UMRVnqtNBie0rYKcjwOtqnsQU7yvvhHxGNhMr
         tHn28u/agwo8B1nMTjboFtdQ5afO52s6K4qaMMQVeHrK//KeumCOZNwCNHbTEpzmIcaO
         TxkQ==
X-Gm-Message-State: AOJu0YxI0zkr5ZMcceW0VuGLLRYNuIOXa5FuTAJGWqZ+gh95aJ6VVfCK
	d6rw4ch32lDx2LXZNjyNdVlcYnDtUmuvgWSP/4fx0XZr+D35ekvz1IHEEhJsYQ==
X-Gm-Gg: AR+sD10Y+IUtO5/G94VHdciwDYUNH6uWnLE8g1x98aa122E/Ri2l6CuW4q+dJtd8ddc
	kndoEzsN3PEaPy6q1fTPp2BFtUKW5sq0e7bssO9GTR4TuPRJIfyxj5V3E0hdSn0sj+DgONcGl5H
	ajouHbD3Hk9YdSNFRlWfGFmhi3FBaDKPEf9fv7BuV0XxnRAgz/0G2B2g7GTGAsf9ezmr8cnGORH
	QtY6ISd+P1C5L4vc1zuHMVeoKrr0CnAZcygNwwsf3gg0e6GKCdwBbTV4HG7wikYrq/VKV5z5DY7
	+hnISuhsrg1Pk0PEV+aMFg72H0GY3ihHTlvzXTRImlses7BCTFVf+nSzmU6FVzlvyKBL6Ustnuq
	1xwYBzzWscGoXGOUNfIzGbPW5sWs4RbTJQ2vehYCx/d74hS1+LWlnyj3JKJYNK7YswcmIYGViCX
	9iKUCYhxqMWAtIuCbiOfXG6sRIHlsMZGpcAaJOMLrpneakbWlffUh/vLAIUi/aEUc4bvDWyWWSW
	h0QqaxPzoreN2Ps6wDrAlTptSDAGYEjqaN4TCQA
X-Received: by 2002:a17:90b:3d86:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-3931e237c28mr3435326a91.15.1786590189821;
        Wed, 12 Aug 2026 20:03:09 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931d9dc198sm517931a91.1.2026.08.12.20.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 20:03:09 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH v5 0/2] iio: adc: Add support for Texas Instruments
 ADS112C04
Date: Thu, 13 Aug 2026 11:06:01 +0800
Message-Id: <20260813-ti-ads112c04-driver-v5-0-79dff9e249cd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJk0fWoC/3XQ3WrDMAwF4Fcpvp6LZCuxs6u9x9iF4yitYG2KX
 cxGybvPKYz+LLs8An066KIyJ+GsXjcXlbhIlulYQ/OyUXEfjjvWMtSsDJgWnCF9Fh2GjGgikB6
 SFE66Z8e+A3Lekqqbp8SjfF3V94+a95LPU/q+Him4TH89v+oV1KDJNTwysemdf9sdgnxu43RQi
 1fMnWFx3TDVCKEHbH20EfDZsDfDQ7Nu2KVHN5Jtven4r0F3Bv7Tg5Ye7IBCxPrAB2Oe5x8tDMX
 bggEAAA==
X-Change-ID: 20260724-ti-ads112c04-driver-be7e89047834
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8463;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=o6iwz9+QOQv0iQl0bwD9gd+/h8QZEQcsPlowUmEUjaI=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqfTSfgA6PyOvPrwMlRjW6qKNY24Ijc+QOd//Wv
 9R/llTua3OJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCan00nwAKCRClg0K3CVbE
 gU5bB/9BShaNobgiiQeNfRFwvysry7xTvNKRHv9iqH1DA2tzqu9tmn8WAwUV4iUGF2yKkV0PFxw
 VzhAyGZXKlgevXEv05/rlS6enG2lBCM/NiGdQ9AWDbCowMY+eDdwmUYSSx0G8CHT1FaML8GSX5x
 h7FSRPfR/RBRaH0ItvDx5KCsk7vMDzSIJ+Xc+QlEOS7voNeegX4270B94ZIHL2J7swJR/+NC7MQ
 jjAcQ9t89XBlywVP7EGvlsp2s5KdlM5/e8d+J16CJAOya/Z76ZjOIjKA/0eAUIAqVR8Z6ZNl+bA
 OKcZ54Pzjn722LpudgM3dNxqYDZ+B7uW1J6yIAK13MNUHJS7
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

This patch series introduces support for the Texas Instruments ADS112C04
Analog-to-Digital Converters.

The ADS112C04 (16-bit) is precision, low-power, delta-sigma ADCs with
an I2C interface. They feature a flexible input multiplexer supporting
single-ended and differential measurements, a programmable gain amplifier,
and an internal voltage reference.

Note: While this chip shares similarities with the ADS112C14 (currently 
being upstreamed by David Lechner), the register maps and feature sets 
are sufficiently different to warrant a separate driver. However, the
DT bindings and channel parsing logic have been aligned with the
ADS112C14 conventions.

This initial submission provides a minimal feature set (single-shot 
conversions and basic DRDY interrupt) covering current use cases.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Changes in v5:
- Addressed several suggestions from v1-v4 that I had missed in earlier
  revisions. Apologies for the churn this caused; I went back through
  all four threads as David asked.

- dt-bindings: iio: adc: ti,ads112c04:
  - No changes. Picked up David's Reviewed-by and Conor's Acked-by.

- iio: adc: ti-ads112c04:
  - Made the reference voltage per-channel, following the ADS112C14
    driver: reference-sources is parsed with
    fwnode_property_match_property_string() and stored per channel, and
    the CONFIG1 VREF field is now updated together with the MUX before
    each conversion. avdd is read with
    devm_regulator_get_enable_read_voltage() when a channel uses it.
  - Organised the register field macros indented under their register,
    and shortened CONFIG to CONF in the field names.
  - Spelled out all CONFIG0/CONFIG1 fields explicitly with FIELD_PREP()
    when initialising, rather than relying on implicit zeros.
  - Moved the internal reference macro to the top of the file with the
    other defines and renamed it to ADS112C04_INT_REF_mV.
  - Dropped disable_irq_nosync(); the handler only calls complete(),
    which is safe in a normal IRQ handler, so a threaded IRQ isn't
    needed. The bare `0` flags argument is now packed with the
    other arguments.
  - Fixed word-read byte ordering by using
    i2c_smbus_read_word_swapped().
  - Dropped the has_refp state member; it is passed as a function
    argument instead.
  - Added a REVISIT comment on spec->type for when
    ti,refp-refn-resistor-ohms is implemented.
  - Reduced the power-on reset delay from 50ms to 500us, per the
    datasheet.
  - Replaced the diff-channels if-else chain with a 4x4 lookup table
    indexed by [AINP][AINN].
  - Used wait_for_completion_timeout() directly in the if condition,
    swapped err/ret in ads112c04_wait_for_data(), made the channel
    index unsigned int with the assignment split out, stopped reusing
    pair[0] for single-channel, and used ARRAY_SIZE(pair).
  - Added ADS112C04_MAX_CHANNELS and used it in the bounds check.
  - Split reference-sources parsing into a helper to keep the call
    within the line length limit.
  - Updated the commit message to describe per-channel reference
    selection; refn-supply remains unsupported.
  - Switched the hardware reset to the reset controller framework
    (devm_reset_control_get_optional_exclusive()), which works with the
    existing reset-gpios property via the reset-gpio driver. The binding
    is unchanged.
- Link to v4: https://lore.kernel.org/r/20260811-ti-ads112c04-driver-v4-0-ae704ac17241@gmail.com

Changes in v4:
- dt-bindings: iio: adc: ti,ads112c04:
  - Fixed excitation-current-nanoamp to use single-entry list syntax
    (items: - enum: [...]) instead of combining maxItems: 1 with a
    mapping-style items, which failed dt_binding_check.
  - Widened excitation-channels to maximum: 5 to account for IDAC1/
    IDAC2 also being routable to REFP0/REFN0, and documented the
    mapping, per David Lechner.
  - Reduced excitation-current-nanoamp to a single entry, since the
    two IDAC outputs share one current setting, per David Lechner.
  - Changed burn-out-current-nanoamp to use `const: 10000`, per David
    Lechner.
  - Renamed reference-sources' internal enum value to "internal"
    (dropped voltage suffix, since there is only one internal
    reference), per David Lechner.

- iio: adc: ti-ads112c04:
  - Fixed word-read byte ordering by switching to
    i2c_smbus_read_word_swapped(), addressing a big-endian data
    corruption issue flagged by Sashiko AI review.
  - Masked the DRDY interrupt in the hardirq handler
    (disable_irq_nosync()) and re-enabled it once the conversion data
    is read, to avoid an interrupt storm on level-triggered DRDY
    configurations, without hardcoding the trigger type.
  - Reworked reference-sources handling in parse_channels(): it is now
    validated against the actually-selected refp-supply instead of
    being unconditionally rejected, per David Lechner.
  - Simplified regulator handling in probe() using
    devm_regulator_get_enable_read_voltage(), dropping the now-unused
    vref_reg field, per David Lechner.
  - Corrected the commit message to no longer claim refn-supply
    support, since it remains explicitly unsupported in probe().
- Added a MAINTAINERS entry for the new binding and driver.
- Link to v3: https://lore.kernel.org/r/20260805-ti-ads112c04-driver-v3-0-49f436829e01@gmail.com

Changes in v3:
- dt-bindings: iio: adc: ti,ads112c04:
  - Resolved dt_binding_check errors by removing redundant $ref for
    standard unit suffixes and fixing YAML array syntax.
  - Added full hardware capability descriptions (excitation-channels,
    excitation-current-nanoamp, burn-out-current-nanoamp,
    reference-sources) as suggested by David Lechner.
  - Restricted the reg maximum to 11 and updated the regex to
    ^channel@[0-9a-b]$ to accurately reflect the 12 possible MUX
    combinations.

- iio: adc: ti-ads112c04:
  - Transitioned all I2C read/write wrappers to use SMBus APIs
    (i2c_smbus_read_byte_data, i2c_smbus_read_word_data, etc.) to
    gracefully handle I2C errors, NACKs, and Repeated Starts, addressing
    feedback from Joshua Crofts and Jonathan Cameron.
  - Added forward compatibility checks in probe() and parse_channels()
    using dev_err_probe() to return -EOPNOTSUPP for unimplemented DT
    properties.
  - Reverted devm_request_irq() flags to 0 to let the driver inherit the
    trigger type strictly from the DT, per Jonathan Cameron's advice.
  - Reduced the data wait timeout to 100ms, reflecting the chip's slowest
    data rate of 20 SPS.
  - Fixed #include alphabetical sorting, grouped <linux/iio/*> headers,
    and added missing headers.
  - Fixed variable declaration ordering (reverse xmas tree) and updated
    variable naming to vref_mV (SI unit exception).
  - Optimized GPIO reset logic using GPIOD_OUT_HIGH.
- Link to v2: https://lore.kernel.org/r/20260731-ti-ads112c04-driver-v2-0-aab0168c3c01@gmail.com

Changes in v2:
- Replaced `vref-supply` with `refp-supply` and `refn-supply` to accurately reflect hardware.
- Refactored the driver to dynamically parse channel configurations and routing from DT child nodes.
- Modernized the driver using kernel macros.
- Handled endianness elegantly.
- Added hardware reset fallback logic.
- Inherited IRQ trigger type from device tree instead of hardcoding.
- Fixed a bug where the MUX software cache could desync from hardware if the I2C write failed.
- Added strict return value checking for all I2C writes during probe.
- Updated the `i2c_device_id` array to use C99 named initializers.
- Link to v1: https://lore.kernel.org/r/20260728-ti-ads112c04-driver-v1-0-475efe4e2b78@gmail.com

---
Kyle Hsieh (2):
      dt-bindings: iio: adc: ti,ads112c04: Add binding for ADS112C04
      iio: adc: ti-ads112c04: Add support for TI ADS112C04

 .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  | 148 ++++++
 MAINTAINERS                                        |   7 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-ads112c04.c                     | 525 +++++++++++++++++++++
 5 files changed, 691 insertions(+)
---
base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
change-id: 20260724-ti-ads112c04-driver-be7e89047834

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>

