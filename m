Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253F29D291
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776637946; cv=none; b=C+tfKTqdHpc+xLQihroOD2C+5YiEI6EA4A0+Yt62gfIEDpnAltuPU1Jb98JXTumrwswHWgpFj3TJrp3vG1E+/Dd+MtVjBfz460anYrh0eRvBCBDIqCdwNC62FiukUOHZUB9RMIPXZq+EASTBLGot9Q72rpNseFB2AiUb5Gf3O1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776637946; c=relaxed/simple;
	bh=ZX40nOmdosh30j8JKn07AId7zjSRWsfejIwjHicf/js=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MtWE3uW8CBuww9n6FUylss1IpvTs4E8FMIdmmutb/WJlLy9abJmctgEh75mba/dV6rQV97GbMP7EOxpki4T0qqaKsPA3E4IL9WfL8byG5+l4ssSkceBc6LmQaEb2HKauQyruQRD4W1kspCZsignLQKzLMyRqp14ZAKA6ND1WR6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ryCHp3cQ; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ryCHp3cQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1776637936; x=1776897136;
	bh=yewcempWra9PTACczzj66+6mEYEjWl4ln+wYMT9Dqfw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ryCHp3cQJO/iFYTcl3rtZ87BjO9CK1kREA8VclBgYt7fnGUmcQGI6mmeD1bALiymX
	 L3Ac5wHltdSsGBn48zAo9TZfQ3jkLghRHCdLppaG9Rf9Pa6lvnhd0ajS0xA5J8Eexi
	 WISBwQY2WZqt4+WMKVcQjbw2RUKQSFhZRPUqKFHpFJt2qjUFxFPOHOLjufsZ7FR1k+
	 quFTKNiiRJTLvIah5kPWwYIjly7DiM6WITxH/Y/m3iY7wHzF7sFZe45TDH3rmPQstl
	 agfSqT/nsJ2ilskjaRk6Az83zkrRQIc6J2jSkQv/ewfiiWYDBBn6tBeuPXLvVZOq/f
	 3gjKwslpsq6cA==
Date: Sun, 19 Apr 2026 22:32:09 +0000
To: gregkh@linuxfoundation.org, jic23@kernel.org
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com, krzk+dt@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, me@brighamcampbell.com, nuno.sa@analog.com, robh@kernel.org, skhan@linuxfoundation.org, Hardik Phalet <hardik.phalet@gmail.com>, Hardik Phalet <hardik.phalet@pm.me>
Subject: [PATCH v3 0/5] iio: magnetometer: add driver for QST QMC5883P
Message-ID: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: bf48b29d405f9162b8fd306c21a45ef4c1e8eed1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series adds an IIO driver for the QST QMC5883P, a 3-axis
anisotropic magneto-resistive (AMR) magnetometer with a 16-bit ADC,
communicating over I2C. To my knowledge there is no existing
upstream driver for this device (see "Prior-art register-map check"
below).

The driver supports:
  - Raw magnetic field readings on X, Y and Z axes
  - Four full-scale ranges (+/-2 G, +/-8 G, +/-12 G, +/-30 G),
    selectable via IIO_CHAN_INFO_SCALE
  - Four output data rates (10, 50, 100, 200 Hz), selectable via
    IIO_CHAN_INFO_SAMP_FREQ
  - Four oversampling ratios (1, 2, 4, 8), selectable via
    IIO_CHAN_INFO_OVERSAMPLING_RATIO
  - Runtime PM with a 2 s autosuspend delay
  - System suspend/resume delegated to the runtime callbacks

Regmap with an rbtree cache is used throughout. CTRL_1 and CTRL_2
bit fields are accessed via regmap_field to avoid read-modify-write
races. The STATUS register is marked precious so regmap never reads
it speculatively and clears the DRDY/OVFL bits unexpectedly.

The probe-time init sequence is: soft reset, wait 300 us for POR
to complete, deassert reset, drop the register cache so subsequent
RMW writes read fresh values, then enter normal mode. 300 us
comfortably covers the 250 us POR time given in the datasheet.

Patches:
  1/5 - dt-bindings: vendor-prefixes: Add QST Corporation
  2/5 - dt-bindings: iio: magnetometer: QSTCORP QMC5883P
  3/5 - iio: magnetometer: add driver for QST QMC5883P
  4/5 - iio: magnetometer: qmc5883p: add oversampling ratio support
  5/5 - iio: magnetometer: qmc5883p: add PM support

Patches 4 and 5 are split out from the main driver so that the core
(1-3) can be reviewed and picked independently, per review feedback
on v2. 4/5 exposes the CTRL_1 OSR field via
IIO_CHAN_INFO_OVERSAMPLING_RATIO. 5/5 adds runtime PM that puts the
chip into MODE_SUSPEND when idle and wakes it to MODE_NORMAL on
demand.

Changes in v3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Addressing review feedback on v2:

  - Moved the driver out of staging and into drivers/iio/magnetometer/
    (Greg Kroah-Hartman).

  - Changed the vendor prefix from "qst" to "qstcorp" to match the
    manufacturer's domain (qstcorp.com) (Krzysztof Kozlowski).

  - Subject of the binding patch no longer says "Add binding for";
    "dt-bindings:" already conveys that (Krzysztof Kozlowski).

  - Dropped the redundant last sentence of the binding commit message
    (Krzysztof Kozlowski).

  - VDD supply is now made required (Krzysztof Kozlowski).

  - Split runtime PM + system sleep handling out of the core driver
    patch into its own patch (5/5), so the core driver can be reviewed
    independently (David Lechner).

  - Split oversampling-ratio support out into its own patch (4/5)
    (David Lechner).

  - Dropped the custom downsampling_ratio sysfs attribute entirely.
    The datasheet describes OSR2 only as "another filter ... depth can
    be adjusted through OSR2", with no further characterisation, and
    no application note clarifying it. Without a precise definition
    of what the filter actually does it is not possible to map OSR2
    to any existing IIO ABI, so support for it is dropped from this
    series (David Lechner).

  - qmc5883p_verify_chip_id() -> qmc5883p_read_chip_id() no longer
    treats an ID mismatch as a probe failure; the chip-ID check is
    informational only (David Lechner).

  - qmc5883p_chip_init() no longer programs driver-chosen defaults
    for RNG/OSR/DSR/ODR. The hardware defaults are sufficient and the
    explicit writes were a development artifact (David Lechner).

  - Post-reset delay in qmc5883p_chip_init() uses fsleep() with a
    comment citing the 250 us POR time from the datasheet
    (David Lechner).

  - Timeout in regmap_read_poll_timeout() written as
    150 * (MICRO / MILLI) instead of 150000 (David Lechner).

  - Channel spec duplication collapsed behind a QMC5883P_CHAN(ch)
    macro (David Lechner).

  - qmc5883p_rf_init() moved up in probe, before the regulator and
    chip-ID reads, so the regmap fields are available by the time
    they are needed (David Lechner).

  - Trailing comma and extra whitespace in the of_device_id and
    i2c_device_id sentinel entries cleaned up (David Lechner).

  - Verified that there is no existing driver in drivers/iio/,
    drivers/hwmon/, drivers/input/, drivers/staging/iio/ or
    drivers/misc/ that matches the QMC5883P register map. Summary
    of candidates inspected is included in the "Testing" section
    below (Andy Shevchenko).

  - Waited ~10 days before sending v3 to allow time for review
    (Andy Shevchenko).

Additional v3 changes not directly from review:

  - Scale encoding changed from IIO_VAL_FRACTIONAL to
    IIO_VAL_INT_PLUS_NANO with a matching write_raw_get_fmt(),
    because the IIO core defaults sysfs writes to
    IIO_VAL_INT_PLUS_MICRO and was silently truncating nano-precision
    writes. The truncation on the 8 G and 2 G entries is documented
    in a comment above the scale table.

  - STATUS register marked precious (in addition to volatile) so
    regmap never reads it speculatively and clears DRDY/OVFL.

  - Added regcache_drop_region() after the soft-reset deassert, so
    subsequent RMW writes read fresh values rather than cached
    pre-reset values.

Changes in v2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  - Use get_unaligned_le16() from <linux/unaligned.h> instead of
    manual byte-shifting for deserialising axis data (review feedback).
  - Fix pm_runtime_* calls in downsampling_ratio_store() to use
    data->dev (the i2c parent device) instead of dev (the iio
    device), avoiding PM refcount imbalances (review feedback).
  - Replace manual pm_runtime_disable() devm action with
    devm_pm_runtime_enable(), which avoids a kcfi-violating function
    pointer cast (review feedback).
  - Move chip suspend into a devm action (qmc5883p_suspend_action)
    registered before devm_iio_device_register() so that devres LIFO
    ordering guarantees the IIO interface is fully unregistered
    before the hardware is put to sleep, closing a race window on
    removal (review feedback).
  - Drop qmc5883p_remove() and the .remove hook entirely, as the
    above devm action subsumes it (review feedback).
  - Remove the empty qmc5883p_runtime_idle() stub; passing NULL in
    RUNTIME_PM_OPS already provides the correct default behaviour.
  - Add regulator support: use devm_regulator_get_enable_optional()
    for the vdd-supply documented in the dt-binding, with a 50 ms
    post-enable delay per datasheet section 5.3 (PSUP ramp + POR
    time) (review feedback).
  - Reinitialise the chip in qmc5883p_system_resume() via
    qmc5883p_chip_init() followed by regcache_mark_dirty() +
    regcache_sync(), so that the driver recovers correctly if the
    regulator was physically cut during system suspend and POR
    reset all registers (review feedback).

Links
=3D=3D=3D=3D=3D
  v1: https://lore.kernel.org/all/20260409162308.2590385-1-hardik.phalet@pm=
.me/
  v2: https://lore.kernel.org/all/20260409210639.3197576-1-hardik.phalet@pm=
.me/

Testing
=3D=3D=3D=3D=3D=3D=3D
Hardware
  A GY-271 HM-246 breakout (this board is a QMC5883P, not a QMC5883L,
  despite what some vendors put on the silkscreen), connected over
  I2C bus 1 to a Raspberry Pi 4B running a mainline aarch64 kernel.
  The chip enumerates at address 0x2C via i2cdetect, and CHIP_ID
  (register 0x00) reads back 0x80 as expected.

Prior-art register-map check (for Andy)
  I grepped drivers/iio/magnetometer/, drivers/hwmon/,
  drivers/input/misc/, drivers/staging/iio/ and drivers/misc/ for
  the distinctive offsets 0x09 (STATUS) and 0x0A (CTRL_1), narrowed
  to files containing both, and manually compared each candidate's
  register layout and control-bit encoding against the QMC5883P.

  Closest candidates:
    ak8975.c    - four register offsets coincide (0x00, 0x09, 0x0A,
                  0x0B) but the data registers sit at 0x03-0x08
                  (shifted +2 vs QMC5883P's 0x01-0x06), DRDY is in
                  ST1 at 0x02 rather than STATUS at 0x09, and CNTL
                  encodes a 4-bit mode only - no packed ODR/OSR/range
                  fields.
    hmc5843.c   - STATUS matches at 0x09, but 0x0A is a read-only ID
                  register, configuration spans 0x00-0x02 rather than
                  a single CTRL_1 byte, and data is MSB-first at 0x03
                  in X/Z/Y order.
    af8133j.c   - 0x0A and 0x0B carry mode and range, but STATUS is
                  at 0x02, data starts at 0x03, and the mode field is
                  2-valued (standby/work) rather than 4-valued.
    mmc35240.c  - data at 0x00-0x05 overlaps, but STATUS and control
                  land at 0x06-0x08.

  No overlap worth discussing: mmc5633, mag3110, tlv493d, tmag5273,
  bmc150_magn, rm3100, yamaha-yas530, st_magn, si7210, als31300. No
  magnetometer driver under drivers/hwmon/, drivers/input/misc/ or
  drivers/staging/.

  Conclusion: no existing driver can be extended to cover the
  QMC5883P without restructuring its register addressing and
  control-bit model. A new driver is warranted.

Functional testing on v3
  - Chip ID read: 0x80 (matches datasheet).
  - Raw axis reads: in_magn_{x,y,z}_raw return stable s16 values
    and track manual reorientation of the board.
  - Scale: all four ranges (+/-2/8/12/30 G) selectable via
    in_magn_scale; in_magn_scale_available lists all four; sysfs
    write-back round-trips cleanly at nano precision.
  - Sampling frequency: 10/50/100/200 Hz all selectable via
    in_magn_sampling_frequency; _available lists all four.
  - Oversampling ratio (patch 4): 1/2/4/8 selectable via
    in_magn_oversampling_ratio; _available lists all four.
  - DRDY polling: verified STATUS.DRDY asserts and clears on read,
    and that OVFL is captured in the same read as DRDY.
  - Soft reset: register state after qmc5883p_chip_init() matches
    the datasheet defaults; regcache_drop_region() confirmed by
    observing fresh values being read on the first post-reset RMW.
  - Runtime PM (patch 5): power/runtime_status transitions to
    "suspended" after the 2 s autosuspend delay (MODE_SUSPEND on
    the wire, verified by i2cdump); next sysfs read resumes the
    device and returns valid data.
  - System sleep: echo mem > /sys/power/state (s2idle on the Pi)
    followed by wake; readings are valid after resume.
  - Unbind: echo <dev> > /sys/bus/i2c/drivers/qmc5883p/unbind
    leaves the chip in MODE_SUSPEND, confirming the devm LIFO
    teardown order.
  - Build: CONFIG_QMC5883P=3Dy and =3Dm both clean; W=3D1 clean on
    aarch64; sparse clean; checkpatch --strict clean.
  - dt_binding_check: passes for patch 2/5.

Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
---
Hardik Phalet (5):
      dt-bindings: vendor-prefixes: Add QST Corporation
      dt-bindings: iio: magnetometer: QSTCORP QMC5883P
      iio: magnetometer: add driver for QST QMC5883P
      iio: magnetometer: qmc5883p: add oversampling ratio support
      iio: magnetometer: qmc5883p: add PM support

 .../iio/magnetometer/qstcorp,qmc5883p.yaml         |  48 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   7 +
 drivers/iio/magnetometer/Kconfig                   |  11 +
 drivers/iio/magnetometer/Makefile                  |   2 +
 drivers/iio/magnetometer/qmc5883p.c                | 673 +++++++++++++++++=
++++
 6 files changed, 743 insertions(+)
---
base-commit: d2a4ec19d2a2e54c23b5180e939994d3da4a6b91
change-id: 20260418-qmc5883p-driver-dcc74bd4a789

Best regards,
-- =20
Hardik Phalet <hardik.phalet@pm.me>

