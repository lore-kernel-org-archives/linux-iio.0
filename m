Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4493EDAD5
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561206; cv=none; b=G4QDs8Gvk/BsewlIWrvcWeEOdbwi8WdM0CqF6yHjFaMNuwv24O7uXd1q0hxOpJ5PzuoiRFXPqdleIAOCBzjJqVp2S12xbFWFhWIu0nkt9vdMa6GgMwtfC+COyIFmYqDx04/8c8u1QWEOdejI185nhNRoiY0UZmPSJVd78gcZ0jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561206; c=relaxed/simple;
	bh=zS6C5rLYTQOpnkqjZ8ExmuX6e5wCjhU89cV0zgMWsQk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tq+Zjk5xpTfg0DJJVsUsrAkhw6BKbJOjrqAr9+bNE7kkLQhB8jZpddoP8VJc3oiduVs0S5CGZZ3+6immeMmdFr6gWer6NdudgreiOeb5VFFYrSmsp9g+xRs+szgnK4dHfWlkIw7QbRbW2OcXrS2S/HWWWr/S5QgjBdk7If3qruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJR1jJ7q; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJR1jJ7q"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf50c6f235so35571605ad.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 01:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787561199; x=1788165999; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vlSgnm3FhOzAAht+Hkm2mHyw+OMDSa/lqmLgUHp2Kgk=;
        b=gJR1jJ7qaaQxFAbLF5VVLIlJT+n17+sENsicj/fQp0riyxZMbhMz/4QUoLyx2Kle3d
         3pSJLKrKVG1Oudy9gZONRmWikCwAJWSu5xR3sH6ALcRqKhAvHaCAekhLkesXaOfp22yW
         kpARqJH1aOpLBz3kvJWmTAPYxFkb1E10r6V17PmRTyoUAu969rjCWsAXQZGL4o2s3QIz
         z++AHNR9hU4BqtLBducBXugzHwmAHew4NEUR0TslsMwtm4Yb5mjRjSqCuIYx7lelHlZm
         dtaiTijLYDx04dm5GJQTtuLkmJHtpxd90xH35/O/aNWhDzO+20B5m6FDUGF/QxqA2EQq
         nBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787561199; x=1788165999;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vlSgnm3FhOzAAht+Hkm2mHyw+OMDSa/lqmLgUHp2Kgk=;
        b=iAqIIvXKeotSpmryeHuOpVd9i81zJ1uCsTMFzSHYUAnMbeFE6RP+Bf3o1Ve/b1e7S0
         Ccdv8Tn5XIV4HlrztoJfES3m6F8J380st3si1meRN+mDb9Z4YhrvqZeD1R5cD7oaZ7do
         NVsQGkw7GqSMOqjH9JL7oRdmxfIFxCJk+n5Wo5LlPERmMApil4WNsvboD4QhfiaoP/4Q
         ZkJPY119u8hcwlL/I5Ygd+tVFpbQQwFogcoKGbL0vODR13xppjEr15qjoIltIFfVMpv0
         aWebhvc+H115w022soEeclhh5tqeIaWao36eutMcOXbHz3aqyfywh4w9i4CuUWG/x7MP
         gMPA==
X-Gm-Message-State: AFuF++l2xfUxsYThyx+VBvTsCg4h/Rk6ZrQsmWRoLLVhGJyHDSpQxhcq
	Z7edYnSdPzcCAPY10kpJOGWIUVZQIuLmN22MyRFO/CAmQ/5kIPJfK/5j
X-Gm-Gg: AR+sD12qkO7whvOq7QzalpIL9VCkv0BzfC9bKQWKRptvM9SKKyO0DXhsQ6X3TVKQ0CE
	iF9kn8IlnxVedOBGnTiL1ThhfXsRW75nyr0nHJtdARW4nAnOQv5kpG4CuAFORzE7OmQeb5RY/uv
	Hng1alPN4BM57p0uKYPS+C6nSAr53TmgIMuPiHBttbU7NNbf8giYTpqIRnLUyTVYiLZWEjcipcz
	hpsnsNe3OJ5v+hPJBv3Jy8HhBC0U8wEOuco0iIfWhZy/YitVg4VLEM6RjmssparsFKjBcByRmQM
	lh/eK+o+aSp0uQxq68Wg0DVA1lEKAkpyrb5c6JRCgVtdHTviUrwOXNiYsmYnGhz/LTV/i/MxGqU
	AoOlQZIG/xCDg4SK/A6kr5woieEgVPN6ljKVxJSgpKHCC+pyDdgcDfw+KHbgz+8hGAKSeXxcw/s
	GvLzXykAQ6oU0GQ7GoQDlTEQkjYfbmbXCVN7X6QyKPAwDGxURgvszsxpiPuTg8rXgU0Sthh3AkM
	X2O0sUN6BEWeQZt1lvyEA85Aq+n
X-Received: by 2002:a17:903:b07:b0:2d0:cc92:f7a3 with SMTP id d9443c01a7336-2d64ada8eb8mr485122995ad.2.1787561199041;
        Mon, 24 Aug 2026 01:46:39 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768e9ebbsm15343265ad.80.2026.08.24.01.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:46:38 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH v7 0/2] iio: adc: Add support for Texas Instruments
 ADS112C04
Date: Mon, 24 Aug 2026 16:49:37 +0800
Message-Id: <20260824-ti-ads112c04-driver-v7-0-6b3c9c87d0e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKEFjGoC/3XQwWrDMAwG4FcpPs9DlpXY3mnvMXZwHLk1rM2wS
 2gpefc5hTHTZsdfoE8/uonCOXERb7ubyDynkqZTDeZlJ8LBn/Ys01izQMAeDJI8J+nHohQGIDn
 mNHOWAxu2DshYTaJufmeO6XJXPz5rPqRynvL1fmRW6/TXs5verCRIMh1HJsbB2Pf90aev1zAdx
 erN2BhabRtYDe8HUL0NOoB6NPSfYaHbNvTaw0XSvUXHzwY1hvqnB6092AD5oOoDn4yuNfS20VX
 DuDFGx0gujI9G3xgI20ZfDWAbwfsQ2A2tsSzLD7W4LrQKAgAA
X-Change-ID: 20260724-ti-ads112c04-driver-be7e89047834
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10696;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=zS6C5rLYTQOpnkqjZ8ExmuX6e5wCjhU89cV0zgMWsQk=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqjAWkw4ITKgcYzufEL9kO0GiO2/RfHLZOqyxFO
 Hs3MF516s+JATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaowFpAAKCRClg0K3CVbE
 ga52B/0QR74s76En8I8h0L6VI27+Z7BI4I6eYVA6DPmMwEAmHlPsio/EVWFgsjl8U1nGfaaNTTk
 uh9X8/6fpxbKDgqQcsIoDV/ShuZOyVcv3OoeLpAiTKb4P8HgF4UgtUfoDiBpP19ob3Au8HCW71Z
 oe0Zps0YjX4m8k8/BSzk5T3KMgf/LaNVQy9oCY6p+CmcOxwTwMyRbrnBShvR0csnCOd0JjXanLq
 i3Y29nFlre2MUM4xVE3Zurpts+Rt4G1IC7WE9hAG07PoZrW2UpFv1tO04GMR1Pp/p6JWJN12jac
 FPUcGLoJaCDzt3xz9pqL1xJijg/+2ItgIFtL51bTktKeDcC8
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
Changes in v7:
- dt-bindings: iio: adc: ti,ads112c04:
  - Documented that DRDY is a pulse and an edge trigger should be used,
    per Jonathan Cameron.
  - Kept David's Reviewed-by and Conor's Acked-by: the change is a
    description-only addition. Happy to drop the tags if either would
    prefer to re-review.

- iio: adc: ti-ads112c04:
  - Dropped Andy's Reviewed-by since the reset handling and channel
    parsing changed in this revision.
  - Reduced the post-reset delay to fsleep(1); the datasheet's
    td(RSSTA) is 100ns, so the previous 1ms was far longer than needed.
  - Renamed the property name variables to s_chan and d_chan.
  - Dropped the duplicated fwnode_property_present() check for
    reference-sources, since ads112c04_parse_vref_source() already
    handles the absent case.
  - Assign need_ext_ref/need_avdd_ref directly rather than with an if.
    Used |= rather than = so the flags accumulate across channels.
  - reset-gpio already asserts the reset when the control is acquired,
    so wait tw(RSL) and call reset_control_deassert() instead of
    reset_control_reset().
- Link to v6: https://lore.kernel.org/r/20260820-ti-ads112c04-driver-v6-0-0e8f0aacce9b@gmail.com

Changes in v6:
- dt-bindings: iio: adc: ti,ads112c04:
  - Dropped the redundant 'items' wrapper from
    excitation-current-nanoamp and burn-out-current-nanoamp.
  - Moved reference-sources' default to the property level.
  - Kept David's Reviewed-by and Conor's Acked-by: the changes are schema
    syntax only, with no change to the accepted values or semantics.
    Happy to drop the tags if either would prefer to re-review.

- iio: adc: ti-ads112c04:
  - Split the read_poll_timeout() arguments logically and dropped the
    redundant outer parentheses.
  - Added ADS112C04_RESOLUTION_BITS and used it for both the
    sign_extend32() bit index and the scale exponent.
  - Added the missing <linux/array_size.h> include.
  - Used local variables for the single-channel/diff-channels property
    names so the error messages stay in sync.
  - Added a comment for the post-reset delay.
- Link to v5: https://lore.kernel.org/r/20260813-ti-ads112c04-driver-v5-0-79dff9e249cd@gmail.com

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

 .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  | 149 ++++++
 MAINTAINERS                                        |   7 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-ads112c04.c                     | 524 +++++++++++++++++++++
 5 files changed, 691 insertions(+)
---
base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
change-id: 20260724-ti-ads112c04-driver-be7e89047834

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>

