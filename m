Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795007869;
	b=DXsjXHGZtc1sZY+KFK5G1CE/52BooIqs/GKmeCGvBeuxsketr9um4jSIr5RJmFLyXvln
	 naZsCLNV6WO5FdrJxzupm1+RBvqiPRjsEOvo/YCbJiBlbsMyYoQSi0srni0MWfFLNIw7g
	 c4L6W071fgiFiLRxr+Hq/8wOKVwzwCoh0n9sI2xLWtGSk0YBMEr8kRg22fiGQvwDsk0W+
	 jLGOeSW/dWG9ltt7Cv21EPxFd7Vd8vLp3/JSbct6GL6BI3xWUSMir2X61fHAMreLSkNJI
	 VZ9katr42XgEDYXXFNYtXm/+PLhqp4BxzFMbhW6fPqm6m0eoOmJOIOZpc6RX6m7zmqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007869;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=WBz8lqMobjVQ4Mu2keHtQfZNmDkU6u4sAEu/s2N7UqU=;
	b=TaYokDcZSPLFrh2btAUs0YN3WVfFrVD+GdGx4MQZB0598hZLMv/795rXZps8ExzkS0rN
	 INz4BvCBeMIf0QFXa2fMYzjyhGZ0ZccSgvps+88fVMY9Ucu0qFRskJ+oqTyEMaQny5yUX
	 hTIHwWbPZRLYYgwzqOQp668vIf/d3GJTUPIAICvqE5sKAx9i5DdYUPLWCbWj0/Z0niE3f
	 EiR6oLaDkCA5d5fAk4n6zwWqFFl3bZRHYNJAJJRDULZMtwS5Fz4Zg5O7ofpp52By/mnhw
	 aLgUIiZqd1MyLLiymo70g8ZIZrGXIVAB0TxDNErRwvM26VYoIsWFGm2pFgSyAFoNiWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Um6il/di";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B14960A262F;
	Wed, 18 Nov 2026 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Um6il/di
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795007869;
	b=x1mhueK4rr0rmDCrPEm4Wv1ASrF2H0ToSSZeIy+iZ8Xt/7wem/P7+R3ERV6Ic9R5n+5e
	 0GW70i3DXdN6j6NotqK3X7RTTMLU8c1BStIlJgZHEuFLdRIKXFRTcDZUvl2y+Dkhi4+Qq
	 ric2ZQSdMN+CcW3qvO6/tHgzMYuijwVuDlLf3Zi0j6/2EBLML+ygSGvxiRUSslwdCRcSi
	 rZ3UtNK04bRpzdgQ+tUrJF6MSEKUwLf9LwE+XtTgp0jmJ0I2R6mm3hvE1vAdw+kcm6EQ0
	 gFy07GesVqRNITvVPhpPfhkVnbOzDoq7RmMfKLUnhnlPkSLcr5RtNxJ+CgrE6HMUNjQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007869;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=WBz8lqMobjVQ4Mu2keHtQfZNmDkU6u4sAEu/s2N7UqU=;
	b=zPWKoNgt/736enuzOixsdEtsUTNeeQusNZynY88XMYRxEAnNNG6w4QNF73GwUgD/fLH9
	 w0rzmeJmhJ14O4JTFd7VFqjrAbj6SLEAaPukIkOhwm+PPLykvb373K84YVs5R8wlVgJQf
	 U4uG+BZYFHuxD6lwnOUnZkPqjI3QF0ht1RpSwaDWFB+RA1W4ngbc2zXgyonxYjQn82tXY
	 hL1+V/zs7OpYOCI/cT3f7WkyJvKoCtjRCt89e3M/NWoFTTmrVtoiC95sG+t+8FI6MrBVO
	 UvSxTnldFHkQAj1CIGlupdSe3ip5srPkpWPmV+enHa71B2OtfUwd1Bu6snmN774Pf/A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CB0B01F000CB;
	Wed, 18 Nov 2026 13:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795007868;
	bh=WBz8lqMobjVQ4Mu2keHtQfZNmDkU6u4sAEu/s2N7UqU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Um6il/dirZca5J2zrJ9jMDI9J1/UZ7h2P+IEr6pBsKkOL+o9QcVPkZkVN4kMx3S6G
	 vnYQiKmogoU4wms3j+ZWOXVi7DfV/oXczIqZZV8eZbSGLnGE6JKosZpt+Kf4xYC519
	 1jjzzd5kke4qrnWYCMCrboukLc5DYDKum7+ipGB9oRIblIUWfxe7mKZj/6ySIZ1YfA
	 UKTFnSbEMdQAE0b/IbVu0hkdn5hwkehZuIdG26rZza9T5OTS0cvvbTyQbC4acuN/3f
	 iHgLdN2QpBlCxuBaBE38Z3TAFOR2nOH4/l9rPAS9TpbciHDYBxWFyF8TAy87GauM2q
	 I77v7YYWiFnYw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 26B6A4AD98;
	Wed, 18 Nov 2026 13:17:45 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Subject: [PATCH v7 0/7] iio: imu: Add support for the ADI ADIS16607
Date: Wed, 18 Nov 2026 15:17:42 +0200
Message-Id: <20261118-adis16607-v7-0-707609737691@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHal/WoC/2XPTW7DIBCG4atErEvE8E9XuUfUBYYhQUrtykRWq
 sh378SbEnn5IZ4X8WQN54qNfR6ebMaltjqNNNzHgaVrHC/Ia6bNpJBWWHA85trAWuG48KGUZI1
 JODC6/zNjqY+tdf6ifa3tPs2/W3qB1+lWASGgqyzABQ/Jh4SoTDb2FMd4my7HNH2zV2aRPfU9l
 URdCjoXL7zzcUdVR8H0VBEtwcmssSB6s6O6o1L1VBONOhsNOJQMakfNPyXbU0NUl+AHkaWDmHb
 UdhTeXrVEVbHOOwhBy/e/ruv6B9pGv+DKAQAA
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Robert Budai <robert.budai@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Radu Sabau <radu.sabau@analog.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux@analog.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795007863; l=19372;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=ci/C9p/6PsbJnur7RgThdE24hoauOtJoWpe6W7W071I=;
 b=mXqh/MgLfV/inOKK9Qvn614HTpVKrg0M9Hd/uafnK6EV8wp86UHzbFoymoVyy5Ux2IQ+pz/CP
 bfYSYskgMrxAKQuG5bz6vPqBShNaA5mkRISFQkI33CHIWSSvPZpDJ9i
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com

This series adds support for the Analog Devices ADIS16607, a precision
MEMS IMU with triaxial gyroscope, triaxial accelerometer, and
temperature sensor, communicating over a non-standard SPI Half-Duplex
protocol.

This version no longer carries the buffered capture. Following the v6
review, the FIFO support is split out into a follow-up series, which
will first update adislib's has_fifo handling (keeping the existing
trigger/current_trigger interface in place) and the adis16475 FIFO
variants that use it, and then add the adis16607 FIFO on top. The
devicetree binding still describes the interrupt pin, as it is part of
the hardware and is what the follow-up uses.

Patch 1 fixes the reset dispatch: both __adis_initial_startup()'s reset
fallback and the public adis_reset() wrapper called __adis_reset()
directly instead of dispatching through adis->ops->reset(), so a
driver's custom reset op was silently ignored there. adis16550 already
provides one and is affected, as is this driver on any board without a
reset-gpios property. The settle-time sleep moves out of __adis_reset()
into both call sites, so it follows whichever reset op is used. Carries
a Fixes tag for the commit that added the reset callback to struct
adis_ops without wiring these two callers.

Patch 2 adds an optional self_test callback to adislib, for devices
whose self-test sequence doesn't fit the generic
mask-write/sleep/check-status pattern.

Patch 3 adds an optional init callback to adislib, for devices that
need extra device-specific bring-up between reset and self-test (SPI
mode locking, status/bootloader checks, pin or burst-mode
configuration, etc.) - not all ADIS devices need this, so it's only
called when set, same as self_test.

Patch 4 adds the devicetree binding.

Patches 5-7 add the driver in functional groupings, as requested in
v1 review:
 - Patch 5: base driver - probe, raw channel reads, decimation/sample
   frequency, startup and self-test via adislib, debugfs identity
   entries.
 - Patch 6: external clock sync support.
 - Patch 7: calibration bias support for gyro/accel.

Notable points for reviewers:

 - The device does not implement the standard ADIS SPI protocol used
   by other parts in the family; reads/writes are done over a custom
   Half-Duplex sequence (see adis16607_spi_read()/adis16607_spi_write()
   and the adis_ops overrides).

 - Startup is split across the two new adislib callbacks rather than a
   driver-private initial_startup(): adis16607_init() does SPI
   Half-Duplex locking, dev_id verification and the bootloader-busy
   check; adis16607_self_test() does the actual per-axis delta-check,
   clearing the SELF_TEST register on every exit path (not just
   success) so a failure doesn't leave the sensor sitting in its
   self-test/force state.

 - GPIO0's reset-pin routing (RESET_GPIO_MASK in USER_GPIO_CFG) is
   runtime-writable on this part, so a prior write (bug, firmware,
   direct register access) could leave it de-routed, silently
   defeating reset-gpios. Patch 5's probe() forces it back to the
   reset function over SPI before relying on toggling the pin -
   warning rather than erroring out on failure, so a still-responsive
   device still gets a real chance at reset.

 - An optional external clock (clocks property) selects between
   SYNC_DIRECT and SYNC_SCALED modes depending on the supplied
   frequency, with the internal clock used as the default when no
   clock is provided (adis16607_config_clk()). The clock rate is
   requested as exclusive. In scaled mode the sync scale is picked
   when sampling_frequency is set.

This has been tested on a Raspberry Pi 4 (arm64) with the device wired
over SPI.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>

Changes in v7:
- Split the FIFO buffered capture out of this series. It follows as a
  separate series once the adislib has_fifo handling is reworked, so
  that the adis16475 FIFO variants and the adis16607 share it without
  changing their user-visible interface (Jonathan, Andy). Patches 1-4
  are unchanged.
- Base driver: the channel spec carries only what the raw reads need.
  scan_index, scan_type and the soft timestamp channel moved out with
  the buffered capture, and the raw read now sets the sample width and
  sign itself (Jonathan). The commit message describes what the patch
  does.
- External clock sync: dropped the sync-lost and PLL-unlocked
  warnings, which were reported from the FIFO interrupt handler.
  They come back with the FIFO.
- Link to v6: https://lore.kernel.org/r/20261113-adis16607-v6-0-3f678719942a@analog.com

Changes in v6:
- Reset dispatch fix: corrected the Fixes tag to the commit that added
  the reset callback to struct adis_ops, and rewrote the commit message.
  It described a sleep-only-for-custom-ops case that was never in the
  baseline and called the bug invisible to existing drivers, which is
  not true: adis16550 already has a custom reset op (Sashiko). The code
  is unchanged, so Nuno's Reviewed-by is kept.
- FIFO: dropped the IIO trigger. Samples now go to a kfifo buffer from
  a threaded, oneshot, level-high interrupt that is enabled together
  with the buffer, and the timestamp is taken in the handler. This
  removes the line being unmasked before the drain and the hardirq-only
  trigger helper being called from an IRQ thread (Sashiko, Jonathan).
  On hardware the interrupt rate goes from about one per sample to one
  per watermark batch. The probe-time interrupt type check is gone, as
  the polarity is fixed in the request, and the patch is retitled "Add
  FIFO-based buffered capture". adislib's has_fifo path is untouched.
- FIFO: reworded the comment on why the interrupt is level-triggered
  (Jonathan) and placed the "Check if FIFO threshold is met" comment
  where the sync patch leaves it.
- Base and sync: the decimation is kept in the driver state and the
  sample period is derived where it is used, instead of being cached.
  get_freq() takes the lock and reads that state, and set_freq()
  updates it after each successful write, so a failed write cannot
  leave a stale period or a mismatched clock (Sashiko).
- Moved changes that belonged in earlier patches out of the sync patch
  to avoid churn, and dropped the trailing comma after the terminating
  ADIS16607_SCAN_MAX entry (Jonathan).
- Kconfig: the base patch no longer selects the unused adislib buffer
  library or includes iio/buffer.h; the FIFO patch selects IIO_BUFFER
  and IIO_KFIFO_BUF.
- Link to v5: https://lore.kernel.org/r/20261102-adis16607-v5-0-4f98b0d271ac@analog.com

Changes in v5:
- Reordered the adislib patches so the reset-dispatch fix comes first
  and the self_test callback second (Nuno).
- Renamed the post_reset_setup callback to init (Jonathan).
- Dropped Rob Herring's Reviewed-by tag on the dt-bindings patch - the
  binding's GPIO-handling description changed substantially since v3
  (Jonathan).
- Base driver: unit-aware names (int_clk_Hz, clk_freq_mHz) and
  MILLIHZ_PER_HZ/MICROHZ_PER_HZ instead of bare 1000s; the sample
  period is now computed through a u64 temporary, so it stays correct
  on 32-bit; GENMASK()/FIELD_PREP()/FIELD_GET() in the register
  accessors, with a firmware revision struct and a shift-accumulated
  serial number; unsigned loop counters scoped to their loops;
  MODULE_DESCRIPTION() matching Kconfig; reworked channel macro
  indentation and wrapped over-long comments (Andy).
- Base driver: dev_err_probe() for probe-only errors, dropped the log
  lines duplicating what __adis_check_status() already prints, min()
  instead of min_t(), removed stray blank lines in read_raw(), dropped
  the protocol comment above adis16607_spi_read() and the redundant
  bits_per_word/tx zeroing, get_freq() uses the locked helper and
  set_freq() takes the lock only around the register writes (Nuno).
- Base driver: a negative sampling_frequency is now rejected instead
  of wrapping around (Sashiko).
- Base driver: channel .address is now an index into a per-channel
  register table instead of a raw register number, with a
  static_assert() against the channel enum; the calibration bias patch
  extends the same table instead of indexing by scan_index (Jonathan).
- Base driver: DEC_RATE is reset to 0 before a new value is written,
  as the datasheet recommends.
- FIFO: iio_for_each_active_channel() instead of reading the mask
  directly (Nuno, Jonathan, Sashiko); the scan buffer is sized with
  IIO_DECLARE_BUFFER_WITH_TS() and pushed with
  iio_push_to_buffers_with_ts() (Jonathan); the trigger handler uses
  the locking helper (Nuno).
- FIFO: the interrupt type is validated at probe and irq_flag is set
  to level-high, which was never set before (Sashiko); the FIFO is
  flushed and DIAG_STAT cleared when the buffer is disabled, so a
  stale session can't leak into the next (Sashiko).
- FIFO: fixed the FIFO_DATA transfer, whose header is 2 bytes and not
  4; samples were read 2 bytes late. Writing sampling_frequency while
  the buffer is enabled now returns -EBUSY.
- Sync: requested an exclusive clock rate instead of a notifier
  (Nuno), which also covers a controllable clock (Jonathan); the sync
  scale is now picked per requested sampling frequency (Nuno).
- Sync: corrected the accepted external clock ranges to the datasheet
  (direct 1 kHz to 8 kHz, scaled up to 400 Hz); the initial scale now
  keeps the multiplied clock at or below the internal rate; loss of
  sync or PLL lock is warned about from the trigger handler. Reverse
  xmas tree declarations and a loop-scoped unsigned counter
  (Jonathan).
- Link to v4: https://lore.kernel.org/r/20261023-adis16607-v4-0-a4d541ebfd13@analog.com

Changes in v4:
- Split the combined adislib commit into three: self_test callback,
  the reset-dispatch fix, and post_reset_setup callback, each its own
  patch - the original bundled all three under one "Also..." (Jonathan).
- Simplified the reset-dispatch fix: removed the internal settle-time
  sleep from __adis_reset() entirely and made both call sites
  (__adis_initial_startup(), adis_reset()) sleep unconditionally after
  dispatching through adis->ops->reset() - no more comparing against
  __adis_reset() to decide whether to sleep (Jonathan).
- dt-bindings: commit message now states how adis16607-2/-3 actually
  differ (gyro full-scale range only) instead of just asserting two
  variants exist (Jonathan). Narrowed reset-gpios's description to
  just itself, and expanded the top-level description to explain the
  device's five GPIO pins and where each one's function is actually
  modeled (clocks, interrupts, or not exposed) (Jonathan).
- Base driver: moved the RESET_GPIO_MASK force-write from after reset
  to before it, in probe() - a previously-defeated reset-pin routing
  (buggy driver, direct reg access) now gets a chance to be corrected
  before relying on the GPIO toggle, instead of too late to matter;
  only warns rather than erroring out on failure, so a still-live
  device keeps its chance at a real reset (Jonathan). Removed the
  now-redundant duplicate of that same write from
  adis16607_post_reset_setup() (Andy).
- Base driver: large style/cleanup batch - dropped an unneeded
  <linux/kernel.h> include, reordered struct adis16607 so struct adis
  is first (cheaper container_of(), measured -0.41% code size via
  bloat-o-meter), use spi_message_init_with_transfers() instead of
  repeated spi_message_add_tail(), ARRAY_SIZE() instead of hardcoded
  loop bounds, put_unaligned_be16(), combined the firmware/revision
  debugfs files into one "major.minor"-formatted entry, dropped an
  unnecessary #ifdef CONFIG_DEBUG_FS wrapper, guard()/
  adis_dev_auto_lock() instead of manual mutex lock/unlock, -ENODATA
  instead of -EINVAL for an unmatched chip_info, unit-suffixed
  clk_freq_mhz/int_clk_hz field names with MILLI from <linux/units.h>
  instead of a bare magic 1000, de-duplicated/inlined several
  single- or two-use macros (Andy, Jonathan).
- Base driver: the self-test startup delay now cites the actual
  datasheet value (Inertial Settling Time, 40ms) instead of an
  unexplained 100ms that didn't match anything in the datasheet
  (Andy). Self-test now clears the SELF_TEST register on every
  failure path, not just on success (Sashiko AI).
- FIFO: dropped disabling the FIFO before draining and the
  flush-and-re-enable afterward entirely - the datasheet confirms
  overflow-only overwrite (not overwrite-during-read) and a dual-port
  architecture with no read/write contention, so there was nothing
  for the disable step to protect against, and it was costing real
  samples during its own disabled window (Jonathan). fifo_buf is now
  a fixed-size array instead of a heap allocation reallocated on
  every scan-mode change; deleted the now-unnecessary
  update_scan_mode() and its devm cleanup entirely (Jonathan).
  guard()/adis_dev_auto_lock() and direct returns in buffer
  postenable/postdisable (Jonathan). clamp() instead of clamp_t() -
  confirmed by building that the forced cast wasn't needed (Jonathan).
- Sync: adis16607_config_clk() now reads DEC_RATE live instead of
  assuming it's 0 after reset, the same way adis16607_get_freq()
  already does - consistent with how USER_SYNC is already written
  explicitly rather than relying on its own reset default (Jonathan).
- Link to v3: https://lore.kernel.org/r/20261015-adis16607-v3-0-f972d4efee85@a

Changes in v3:
- Fixed the public adis_reset() wrapper (adis.h) to also dispatch
  through adis->ops->reset() instead of hardcoding __adis_reset() -
  the same bug class as the v2 __adis_initial_startup() fix, just a
  second call site that was missed. Switched both checks from
  comparing against adis_default_ops to adis->ops->reset != __adis_reset,
  which also works from the header, where adis_default_ops isn't
  visible (Sashiko).
- Fixed dt-binding wording: dropped "compatible" from the variant
  description (reads as a DT compatible-string fallback claim, which
  doesn't exist here - the two variants aren't interchangeable) and
  dropped a Linux-driver-specific sentence from reset-gpios's
  description (Conor); removed a stale commit-message bullet claiming
  a FIFO watermark property that was never in the binding (Sashiko).
- Dropped a redundant <linux/mod_devicetable.h> include -
  <linux/spi/spi.h> already provides it (Uwe, Andy); switched
  adis16607_id[] to named initializers (Uwe).
- Fixed FIFO sample timestamps: they were projected forward from the
  IRQ-fire time instead of back-dated, so the newest sample in a batch
  ended up timestamped in the future. Now back-dated so the newest
  sample lands on the IRQ-fire time and earlier ones count back from
  it (Sashiko).
- Added a comment explaining why disabling the FIFO during drain, and
  the flush afterward, don't lose in-flight samples - no new samples
  are enqueued at all while disabled, so nothing can arrive in that
  window for the flush to drop (Sashiko asked twice, independently).
- Reworked external clock sync configuration (adis16607_config_clk())
  so every mode (default/direct/scaled) explicitly writes its own
  complete SYNC_GPIO_MASK/USER_SYNC state, instead of only writing
  conditionally when enabling non-default sync (Sashiko x2); switched
  the sync scale factor from truncating to rounding division (Sashiko);
  fixed a real bug where SCALED mode's effective clock was hardcoded
  to the nominal internal rate instead of the actual achieved rate
  (ext_clk_hz * sync_scale), which would have caused FIFO timestamps
  to drift whenever the external clock didn't divide the internal
  clock exactly (Sashiko).
- Added range validation before writing calibration bias - out-of-
  range values were silently truncated to 16 bits instead of being
  rejected (Sashiko).
- Link to v2: https://lore.kernel.org/r/20261008-adis16607-v2-0-7c94df80878a@analog.com

Changes in v2:
- Split the driver commit into functional groupings per review:
  base, FIFO, external clock sync, calibration bias (Nuno).
- Added adis_data.self_test and adis_data.post_reset_setup callbacks
  to adislib instead of duplicating startup/self-test logic in the
  driver (Nuno). post_reset_setup is a second, honestly-named hook
  added after review feedback that overloading self_test to also mean
  "everything else the device needs at startup" was misleading.
- Fixed __adis_initial_startup()'s reset fallback to dispatch through
  adis->ops->reset() instead of a hardcoded __adis_reset() call -
  found while wiring up this driver's custom reset op. Added a Fixes
  tag for the originating commit.
- Removed the direct single-sample burst-read capture path entirely;
  the hardware FIFO is now the only buffered capture mode. Dropped
  adi,fifo-enable from the binding accordingly.
- Fixed FIFO-threshold interrupt wiring: set has_fifo on adis_data and
  switch the DT interrupt type from edge to level, matching the
  DEV_NOK signal this now uses (previously only the data-ready pulse
  was wired, which never actually generated a FIFO interrupt).
- Moved the optional reset-status GPIO output into the base driver
  patch (where it conceptually belongs) instead of bundling it into
  the FIFO patch's USER_GPIO_CFG write; the FIFO patch now updates
  that register with a read-modify-write instead of a blind write.
- Fixed cover letter: "Three compatible variants (-1, -2, -3)" was
  wrong, there are only two (-2, -3); "configurable data-ready
  interrupt pin (DIO1-4)" was wrong, there's a single fixed pin.
- Corrected spi-max-frequency to 10 MHz (datasheet maximum), from
  15 MHz.
- Renamed ADIS16607_REG_SW_RES to ADIS16607_REG_SOFT_RESET to match
  the datasheet's register name; renamed burst_buf to fifo_buf and
  dropped the redundant "fifo_" prefix from the buffer postenable/
  postdisable/ops names, since FIFO is the only capture mode and
  "burst" no longer described what that scratch buffer is used for.
- Link to v1: https://lore.kernel.org/r/20261001-adis16607-v1-0-9c89cee35d56@analog.com

---
Radu Sabau (7):
      iio: imu: adis: Fix custom reset dispatch in adislib
      iio: imu: adis: Add optional self_test callback
      iio: imu: adis: Add optional init callback
      dt-bindings: iio: imu: Add bindings for ADI ADIS16607
      iio: imu: Add driver for the ADI ADIS16607
      iio: imu: adis16607: Add external clock sync support
      iio: imu: adis16607: Add calibration bias support for gyro/accel

 .../devicetree/bindings/iio/imu/adi,adis16607.yaml |   94 ++
 MAINTAINERS                                        |    8 +
 drivers/iio/imu/Kconfig                            |   12 +
 drivers/iio/imu/Makefile                           |    1 +
 drivers/iio/imu/adis.c                             |   15 +-
 drivers/iio/imu/adis16607.c                        | 1049 ++++++++++++++++++++
 include/linux/iio/imu/adis.h                       |   26 +-
 7 files changed, 1200 insertions(+), 5 deletions(-)
---
base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
change-id: 20260617-adis16607-089ffc655ceb

Best regards,
-- 
Radu Sabau <radu.sabau@analog.com>


