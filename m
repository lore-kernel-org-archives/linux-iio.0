Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A833EA94B
	for <linux-iio@vger.kernel.org>; Tue,  7 Jul 2026 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437451; cv=none; b=cidnTptmHeIfCGrXavH7mzz6o9BMcxCy/EBHNJeh3tCgd2tN27DQnUWOYqTWClQEKv/WXfMXkjkV6NaajpF0lQ1hbYwPLSsWP7qdI5+0w1XumjAYbtQQhyDjVxndoDhExvnaIsY5TQuOyA5LGAv2nBF6bvuajV+DH2G13BXiu3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437451; c=relaxed/simple;
	bh=phjXPw5sq8NmvfiS+ILBNnHctkoZapjmR6LFt1HEUeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDvUkLF9CLgnH7LuXri0izIXwIpB+10PIBCUWfZ0HGmB8F+bsB2Fr/nKEp+aa/xkPcCdQJT7SmW82dNc0ub0xX2GgZX3VkBcJb0VZIJv1iwTaPQ5PTA2iWgoTUV3Yqfp76BErvlZZS3dASoZD74C8er4BRQ3d2tE+ftZq+lCd/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzO3Pip4; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzO3Pip4"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-847a483e344so994106b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 07 Jul 2026 08:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783437448; x=1784042248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lt/GKBSCg7GPfZqbv2Pd6qt53WTmWnuf3p+rueTgHV0=;
        b=kzO3Pip47Luvs61TIRODMMac1rb0PdTOgGUO8elCN4b+18RlGTsA5JqSJDk6eDJm5R
         8/Sy21R0xO9RESFtNFGjFhb8YHpYX8swb93ECXaNOjCqcJ5zyqOjimnR+L6zhj4e3FEG
         9gxAxP104+fzWa6F08pHah56VGxV6yYJdjskbxkGAOHyeu3ZUH64BtmKrcHTx7NGVcN0
         vF1XzAGJS1q5aI2XO+PMI7foGUwV1lDfjxTUGaf+SndoN8cUX+dvn5rsACHa0FkoRBG7
         XUQXxNhECHlP2XIzVRU4jpGNyKXEN9k+E2UtvOQ5uh7cM3rR8rqNCmTjwdZ60566HLcU
         oiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437448; x=1784042248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lt/GKBSCg7GPfZqbv2Pd6qt53WTmWnuf3p+rueTgHV0=;
        b=nUypp7w483BmO7VEjyW0ncjxI3lIOMUxJ/ke1mYkYtXrYt+NNqnGN/qiauWfg9wVal
         295ZKWch17+RfB3EREYpnI0qAMqS5MXXx0GPbCH7Kk6ZoXqA2q5o/lRjolxkF+2AEGzI
         EuFIelJJD7fUOpiMZNak7ZYxsWt2O6KAdp8tmkyRIh4ovqp8Uqc0pX42URMYpPEpUH7j
         WqziK1W8c+sqw7SI/6RCaIF4rORy/vw+ftHI2RsK/FMqkNCR68mXcQGrfB3OoZeZyy5A
         HouFTGYzOYbRP28T4CdzppMJXuLZzYnJc8Yb8IWW8gIIsvSuKm6CMB34uSZCkVNXlXAN
         piwg==
X-Gm-Message-State: AOJu0Yz3Ww0PkhvHdIXD7iy39MJSSZ2egDM/C+kU/L8LI+9OwsQY1rs9
	BOi985zMqQYwbYSUMVf5lr8TIfqihX5OLzNcorDDMSDEVu7x/MzPLfhL
X-Gm-Gg: AfdE7ckaMJst3muHY9/yUfu+7O5UZ0DH7HGDZOc/sRCqVZm7pxkEH7GUV62wBadjQ4o
	/vhNF7apD9XNzX/MP1Tonq0yrMM5MM/wAteLKYRr/7H2ilQdPOSqKKnInvmyMbistf4TpnfZu75
	7TkAqP4Eedt351wV4jzacBgew7/+yXfemK0WGrwVA/08oRpzwvPTk1xwW3Qe658H+skzQhzgnTL
	XIv7wYWvjrGC/VgoWiDFuVyE8KLFcJU/FTOw6aEs57b9hfjvVqWWOTwzSp2NSa/MVlDJG+RqwNh
	UQOtRcEKau61c64piaeoEtVozZQfERYl9lP/LYNeytdGxJjZbLFoz8S+Tkf61xyuSsWUcG2ayNe
	jheJvBkmEFmBPAdDBlZSMjRrMChz3XKAInLU3pT3maseWmvX+TH3w7kDcI9W+xX3JHkAL9HeUOo
	LipwrvgHy6NtVMoW9di25bGW2jB0827seYtTZ/015JkaHugDGdePCmcmEghuwbgtZlYg==
X-Received: by 2002:a05:6a00:1ca3:b0:845:d2e3:b9c8 with SMTP id d2e1a72fcca58-8482f52ae5emr2852664b3a.28.1783437448167;
        Tue, 07 Jul 2026 08:17:28 -0700 (PDT)
Received: from localhost.localdomain ([2001:448a:2003:63bf:6d1c:a790:1205:96eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4e741sm5724397b3a.28.2026.07.07.08.17.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 08:17:27 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com,
	ojeda@kernel.org,
	dakr@kernel.org,
	igor.korotin@linux.dev,
	branstj@gmail.com,
	Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Subject: [RFC PATCH v4 0/3] iio: position: add Rust driver for ams AS5600
Date: Tue,  7 Jul 2026 22:15:39 +0700
Message-ID: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v4 of the Rust driver for the ams AS5600 12-bit magnetic rotary
position sensor. v3 hardened the IIO abstraction layer and introduced
kernel synchronisation primitives. This revision simplifies the driver
substantially based on review feedback, removes components that were
over-engineered for a single-bus 12-bit sensor, and validates the result
with comprehensive hardware testing.

Apologies for the delay.

Link: https://lore.kernel.org/linux-iio/20260419151327.26306-1-muchamadcoirulanwar@gmail.com/

Changes since RFC v3:

  IIO abstraction (rust/kernel/iio.rs):
  - Removed DirectModeGuard entirely (struct, C helpers, binding file)
    per Jonathan's review of patch 2. This driver operates in
    INDIO_DIRECT_MODE only and has no buffer or trigger support, so
    claiming direct mode is redundant. If buffer support is added later,
    the guard can be reintroduced at the driver level rather than the
    trampoline.
  - Deleted rust/helpers/iio.c (no remaining consumers).
  - Fixed SAFETY comment: iio_device_alloc uses kzalloc internally, so
    priv_ points to zeroed memory, not uninitialised memory as the
    previous comment stated.
  - Added i32::try_from(size_of::<T>()) guard to prevent silent
    truncation when passing priv_size to iio_device_alloc.
  - No other functional changes to the abstraction.

  I2C abstraction (rust/kernel/i2c.rs):
  - Provided full io_read/io_write method bodies for IoCapable<u8> and
    IoCapable<u16> per Brandon's note that IoCapable is no longer a
    marker trait on current tree. The empty impls from v3 would not
    compile.
  - Added clarifying comment on maxsize(): this is the SMBus command
    byte range (0x00-0xFF), not the 7-bit I2C device address.

  Driver (drivers/iio/position/as5600.rs):
  - Removed circuit breaker (DeviceState enum, handle_io_error) per
    Jonathan's review of patch 3. The AS5600 sits on a short local bus
    with no hot-plug; if the bus fails, propagating the error directly
    is simpler and more predictable than internal state machines.
  - Replaced As5600Io(*mut i2c_client) with ARef<I2cClient> per
    Brandon's suggestion. This eliminates manual unsafe Send/Sync impls;
    ARef provides proper reference counting and the compiler can verify
    the bounds itself.
  - Removed the generic type parameter from As5600Priv and As5600HwState
    per Brandon's feedback. A concrete type is sufficient for a
    single-bus sensor.
  - Moved channel spec from KBox<[iio_chan_spec; 1]> (heap) to a module-
    level static per Jonathan's review of patch 2, matching what all C
    IIO drivers do and eliminating the KBox lifetime concern noted in v3.
  - Replaced two sequential try_read8 calls (high byte + low byte) with
    a single try_read16 word read followed by swap_bytes() per
    Jonathan's review of patch 3. The AS5600 stores angle big-endian
    across 0x0C-0x0D; SMBus word reads return little-endian, so a byte
    swap recovers the correct value.
    In my v3 reply I said I would use i2c_smbus_read_word_swapped. I
    apologise for not following through. Adding a standalone swapped
    method alongside the Io trait felt premature while the question of
    whether this driver should use regmap-rs instead remains open. For
    this RFC with a single word read, the in-driver swap is retained
    with a TODO comment. Happy to add the wrapper in v5 if preferred.
  - Added AS5600_RAW_ANGLE_MASK via genmask_u16(0..=11) for 12-bit
    angle extraction.
  - Updated datasheet URL to ams-osram.com per Brandon's note (old link
    broken).
  - Added depends on IIO to Kconfig (won't link without it).
  - Kconfig and Makefile entries merged into driver patch per Jonathan's
    review of patch 4.

  Known limitations (to be addressed before mainline):
  - No power management (suspend/resume) hooks.
  - write_raw and buffer/trigger support deferred to future work.
  - No i2c_smbus_read_word_swapped wrapper yet (see above).

Changes since RFC v2:
  (see v3 cover letter for full changelog)

Changes since RFC v1:
  - Moved magnet validation from probe() to read_raw().
  - Added minimal Rust IIO abstractions.
  - Added OF device table for devicetree matching.

Design notes:

  The IIO abstraction does NOT use devres (devm_iio_device_alloc). The
  Rust Drop implementation controls the cleanup sequence directly:
  iio_device_unregister -> drop_in_place(T) -> iio_device_free. This
  avoids ordering conflicts between Rust ownership semantics and the C
  devres teardown sequence.

  Module ownership is enforced via the second parameter of
  __iio_device_register(indio_dev, module), not via iio_info.owner.

Muchamad Coirul Anwar (3):
  i2c: rust: implement SMBus read abstraction via kernel::io::Io for
    I2cClient
  rust: add minimal IIO subsystem abstractions
  iio: position: add Rust driver for ams AS5600

 drivers/iio/position/Kconfig    |  14 ++
 drivers/iio/position/Makefile   |   1 +
 drivers/iio/position/as5600.rs  | 181 ++++++++++++++++++++
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/error.rs            |   1 +
 rust/kernel/i2c.rs              |  89 ++++++++++
 rust/kernel/iio.rs              | 295 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 8 files changed, 585 insertions(+)
 create mode 100644 drivers/iio/position/as5600.rs
 create mode 100644 rust/kernel/iio.rs

Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
Tested on BeagleBone Black (AM335x), kernel 7.1.0-g97e88f52769a (build
88), AS5600 on i2c-2 (0x36) at 3.3V, 6mm diametric neodymium magnet.
Full test session: 2026-06-30 12:00 UTC.

Build: make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- modules
       (zero warnings, zero errors)
       Module size: 15108 bytes (as5600.ko)

Functional tests:

  1. Probe and registration:
     $ sudo insmod as5600.ko
     $ echo "as5600 0x36" > /sys/bus/i2c/devices/i2c-2/new_device
     $ cat /sys/bus/iio/devices/iio:device0/name
     as5600
     $ ls /sys/bus/i2c/devices/2-0036/driver
     2-0036  bind  module  uevent  unbind

  2. Raw angle and scale (magnet present, rotated by hand):
     $ cat /sys/bus/iio/devices/iio:device0/in_angl_raw
     233
     $ cat /sys/bus/iio/devices/iio:device0/in_angl_scale
     0.001533981
     Multiple reads while rotating: 233, 898, 1873, 1543, 468, 63, 252
     All values within expected 0-4095 range (12-bit).
     Computed: 898 * 0.001533981 = 1.378 rad, about 78.9 degrees.

  3. Magnet removed (MD bit clear, error propagation without circuit
     breaker):
     $ cat /sys/bus/iio/devices/iio:device0/in_angl_raw
     cat: '/sys/.../in_angl_raw': No data available
     Driver reads STATUS, finds MD=0, returns -ENODATA directly. No
     internal state machine. Next read with magnet present succeeds
     immediately without recovery sequence.

  4. Unbind/rebind lifecycle (PinnedDrop with ARef cleanup):
     $ echo "2-0036" > /sys/bus/i2c/devices/2-0036/driver/unbind
     $ ls /sys/bus/iio/devices/iio:device0
     ls: cannot access '...': No such file or directory
     $ echo "2-0036" > /sys/bus/i2c/drivers/as5600/bind
     dmesg confirms full PinnedDrop sequence on unbind:
       iio_device_unregister -> drop_in_place(Mutex<ARef>) -> iio_device_free
     Re-probe succeeds, device functional again.
     $ dmesg | grep -i "oops\|panic\|bug:"
     (empty)

  5. Concurrent stress (Mutex serialization under contention):
     $ for i in $(seq 1 10); do
         timeout 10 sh -c 'while true; do
           cat .../in_angl_raw > /dev/null 2>&1; done' &
       done; wait
     10 parallel readers hammering in_angl_raw for 10 seconds.
     All workers exit cleanly via timeout (exit 124).
     Repeated 3 times, same result each time.
     $ dmesg | grep -i "oops\|panic\|bug:\|rcu"
     (empty, only boot-time RCU init messages present)
     No corrupted values, no races, no use-after-free.

  6. Unbind/rebind race (concurrent I/O during device removal):
     Terminal 1: continuous cat .../in_angl_raw in background
     Terminal 2: 20x unbind/bind cycle with 100ms sleep between
     This exercises the iio_device_unregister drain path. The IIO core
     waits for in-flight read_raw callbacks to complete before
     PinnedDrop proceeds with drop_in_place.
     $ dmesg | grep -i "oops\|panic\|bug:"
     (empty, all 20 cycles complete without crash)

  7. Lifecycle stress (20x probe/remove under I/O load):
     20 complete insmod/new_device/delete_device/rmmod cycles with 10
     concurrent readers active during each cycle. Each cycle allocates
     a new iio_dev (confirmed by unique indio_dev addresses in dmesg)
     and frees it via PinnedDrop. No memory leaks, no KASAN reports,
     no dangling pointers.

-- 
2.50.0

