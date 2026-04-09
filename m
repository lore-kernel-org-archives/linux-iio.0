Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E12FA0C6;
	Thu,  9 Apr 2026 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775768847; cv=none; b=gj9v5SiOoQLx1ASTyOCPQ3YYtPIIsWFi0CpXf6XAMpLBWdy1fFGpcvV8TuEX/94PbV8Jf8/p5Qr4yIRpgmVxiFQ27tWsj90MlQqFaixjfhk88OZJOYPmiDFDejKSisuw2+lrUE41TyiA35zuIy/SCW1kjPaw6sRIehMkpE1AnVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775768847; c=relaxed/simple;
	bh=A4vYpJR4R1Zfcc5UPKnQUIvd3DYx+20Qbl7bkyBWwXQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WzyaB1Lnj7Sm30egjObs1aWyQZ188SBjPL+KHcR/l5kldy0pH/U5bJhCz5fWicfj7m+mHkxCJ5SplYuC4xCWv6LoNEPOVeavBQnfEg/BB+Z0bNa9NlRfSpMiN9A0MMiO+xSRxk1No94eHH+IJmvgfWiS3l22LWQyfGfDPchFP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=DWpeyYh4; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="DWpeyYh4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1775768838; x=1776028038;
	bh=dsuOl6TYFl20q1OWDoSsPgAQVgUgCF0ZcayvS81OW6A=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DWpeyYh4is+jDCZ/f3kXmHzSsvX+f7TMh8HV5E4EkI1EmpliZAQiykqTTz5hmSdwD
	 PV3+09FuT1Iuj7Ah6PAgqfBW05HiTegC3poGpAClPGAYykSfFdwmRY2tFF0opVToch
	 aSO0cTtgaDZ6kIpMsA+vK8ODIg1JDBohy6r3bd/uJn3Qk9hxNq6h+abZIp+tCAi1R2
	 ParJwKuoVFQOPV+zqfU0zRo9f0oKk/SfZz0lyYKCr3B/abbAhOnD8JcHFDQXx5GOhU
	 ORRTc6vd5E1aCVz3utz09dgIcY3mGoYae1tu+HBCAulth694afP9x+wA77LQTXhxn6
	 Xssg4utbq+6Uw==
Date: Thu, 09 Apr 2026 21:07:11 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, Hardik Phalet <hardik.phalet@pm.me>
Subject: [PATCH v2 0/4] Add QST QMC5883P magnetometer driver
Message-ID: <20260409210639.3197576-1-hardik.phalet@pm.me>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: fa4a78a46b0fe775bce56ef0e13b802b4195cc89
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series adds initial Linux support for the QST QMC5883P, a 3-axis
anisotropic magneto-resistive (AMR) magnetometer with a 16-bit ADC that
communicates over I2C. To my knowledge there is no existing upstream
driver for this device.

The driver supports:
  - Raw magnetic field readings on X, Y, and Z axes
  - Four selectable full-scale ranges (=C2=B12 G, =C2=B18 G, =C2=B112 G, =
=C2=B130 G)
  - Configurable output data rate (10, 50, 100, 200 Hz)
  - Configurable oversampling ratio (1, 2, 4, 8)
  - Configurable downsampling ratio (1, 2, 4, 8) via a custom sysfs
    attribute
  - Runtime PM with a 2 s autosuspend delay
  - System suspend/resume via pm_runtime_force_suspend/resume

Regmap with an rbtree cache is used throughout. CTRL_1 and CTRL_2
bit fields are accessed via regmap_field to avoid read-modify-write
races. The STATUS register is marked precious so regmap never reads
it speculatively and clears the DRDY/OVFL bits unexpectedly.

The init sequence on probe is: soft reset =E2=86=92 wait 1 ms =E2=86=92 dea=
ssert
reset =E2=86=92 configure SET/RESET control =E2=86=92 apply default ODR/OSR=
/DSR/RNG
=E2=86=92 enter normal mode. This ordering was determined empirically on
hardware to produce reliable, non-zero axis readings.

The driver is placed under drivers/staging/iio/magnetometer/ with a
TODO file tracking the remaining work before it can graduate:
  - Triggered buffer support (iio_triggered_buffer_setup)
  - DRDY interrupt support
  - Self-test implementation

Patches:
  1/4 - dt-bindings: vendor-prefixes: Add 'qst' for QST Corporation
  2/4 - dt-bindings: iio: magnetometer: Add binding for QST QMC5883P
  3/4 - staging: iio: magnetometer: Add QST QMC5883P driver
  4/4 - MAINTAINERS: Add entry for QST QMC5883P magnetometer driver

Testing
-------
Tested on a Raspberry Pi 4B running a mainline kernel (aarch64) with a
GY-271 HM-246 board connected via I2C bus 1. The chip was confirmed to
enumerate at address 0x2C via i2cdetect.

The driver was cross-compiled from Fedora (x86_64) targeting aarch64
and loaded as a module (qmc5883p.ko) with the Device Tree overlay
pointing at i2c1:0x2c.

Verification steps performed:
  - Chip ID register (0x00) reads back 0x80 on probe, confirming the
    correct device is present
  - All three axes (in_magn_x_raw, in_magn_y_raw, in_magn_z_raw) return
    non-zero, stable values when the board is held still and change
    appropriately when the board is rotated
  - in_magn_x_scale (and Y, Z) returns the expected fractional value for
    the default =C2=B18 G range (1/37500000)
  - in_magn_sampling_frequency / _available, in_magn_oversampling_ratio /
    _available, and downsampling_ratio / downsampling_ratio_available all
    read and write correctly; the chip responds without error to each
    valid setting
  - Runtime PM: after 2 s of inactivity the device enters suspend mode
    (MODE =3D 0x00 confirmed via i2cdump); the next sysfs read correctly
    resumes the device and returns valid data
  - System suspend/resume (echo mem > /sys/power/state) leaves the
    driver in a consistent state; readings remain valid after resume
  - dt_binding_check passes for patch 2/4
  - Kernel builds cleanly with W=3D1 and no new warnings

Changes in v2:
  - Use get_unaligned_le16() from <linux/unaligned.h> instead of manual
    byte-shifting for deserialising axis data (review feedback)
  - Fix pm_runtime_* calls in downsampling_ratio_store() to use
    data->dev (the i2c parent device) instead of dev (the iio device),
    avoiding PM refcount imbalances (review feedback)
  - Replace manual pm_runtime_disable() devm action with
    devm_pm_runtime_enable(), which avoids a kcfi-violating function
    pointer cast (review feedback)
  - Move chip suspend into a devm action (qmc5883p_suspend_action)
    registered before devm_iio_device_register() so that devres LIFO
    ordering guarantees the IIO interface is fully unregistered before
    the hardware is put to sleep, closing a race window on removal
    (review feedback)
  - Drop qmc5883p_remove() and the .remove hook entirely, as the above
    devm action subsumes it (review feedback)
  - Remove the empty qmc5883p_runtime_idle() stub; passing NULL in
    RUNTIME_PM_OPS already provides the correct default behaviour
  - Add regulator support: use devm_regulator_get_enable_optional() for
    the vdd-supply documented in the dt-binding, with a 50 ms post-enable
    delay per datasheet section 5.3 (PSUP ramp + POR time) (review
    feedback)
  - Reinitialise the chip in qmc5883p_system_resume() via
    qmc5883p_chip_init() followed by regcache_mark_dirty() +
    regcache_sync(), so that the driver recovers correctly if the
    regulator was physically cut during system suspend and POR reset all
    registers (review feedback)

v1: https://lore.kernel.org/all/20260409162308.2590385-1-hardik.phalet@pm.m=
e/

Hardik Phalet (4):
  dt-bindings: vendor-prefixes: Add QST Corporation
  dt-bindings: iio: magnetometer: Add binding for QST QMC5883P
  staging: iio: magnetometer: Add QST QMC5883P driver
  MAINTAINERS: Add entry for QST QMC5883P magnetometer driver

 .../iio/magnetometer/qst,qmc5883p.yaml        |  48 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/staging/iio/Kconfig                   |   1 +
 drivers/staging/iio/Makefile                  |   1 +
 drivers/staging/iio/magnetometer/Kconfig      |  20 +
 drivers/staging/iio/magnetometer/Makefile     |   7 +
 drivers/staging/iio/magnetometer/TODO         |   5 +
 drivers/staging/iio/magnetometer/qmc5883p.c   | 830 ++++++++++++++++++
 9 files changed, 921 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/qst,=
qmc5883p.yaml
 create mode 100644 drivers/staging/iio/magnetometer/Kconfig
 create mode 100644 drivers/staging/iio/magnetometer/Makefile
 create mode 100644 drivers/staging/iio/magnetometer/TODO
 create mode 100644 drivers/staging/iio/magnetometer/qmc5883p.c

--=20
2.53.0


