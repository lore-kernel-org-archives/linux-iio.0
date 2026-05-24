Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2615D25B085
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779629318; cv=none; b=SWWyiQGxr2cp9ehPWOrdWJnaxIlP4vJJYQVYht4ePnDVuGO0SRY48YCenHdoIZIUkjPe7mXmnjWTiS1KvmIOFEL/gz++KzcIbmzeHXG5ZNFSabz5/vQROI53CU0Lu5YPiaHES5S2S7pKsgoNhKdHtu/qNsMPjJk1csn+wddbnrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779629318; c=relaxed/simple;
	bh=3q207eS6dCqJNKqB5QVhq1jVHtsV7i21U4XVOuv4HEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uvcqTrypVezf9hCgmFhtrLEHlfa6QJVmKYNA+4RVtn9BqsK4QBYNbLIl5blGFqwwl4COGS2lnT2zLqQ7M2E5A7eLXQHraEWQ/9fHrtlU4gStjgiWOHGZAgsGNw+prYgU6S1hBeLBMMSkPZmda9VFcfCmEsZ9bszbVp6Hqwwh+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKd69Sma; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKd69Sma"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba4a1a0325so58745735ad.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779629316; x=1780234116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LQAAigvKk7VrCY4yeKb/jsgJGHBeLc/nxmf8jeBuDRo=;
        b=QKd69SmaVDVyKyuex/sZGxmOW8LWGkeWgJNeSIzMqkgMi4FNF/+3myaio8nO+oc0Zn
         1aVQ+H1gS3AxhI+KkxIPOZXW6dx8cdk9hDmGMFz++23CtV2UDuTwWkMVgzchpMnEhpDa
         o9nKzEGhOv82UycJO4S+J/Wziq54o6NEH+lQjAR1RAhW57qXb0PxnRqoSfSzUhIWmt2N
         +EsgM2UHcfkEArpOhS7KMNkr8AOCbm+aJt6tOvIS5eXA7RmzReUOob2UXlCFH0XqfX/Z
         oPIgVeGfZmSLUJCuX3hBf69i/3T9fdfDq0xBdYVSiTP8rIjcUlwrGSoRfgige/2GJ87b
         RV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779629316; x=1780234116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQAAigvKk7VrCY4yeKb/jsgJGHBeLc/nxmf8jeBuDRo=;
        b=EI6o5A8vhN6uOqVspXUL5192+Mv1IUJnFv3oifZvlbHPLrGat8B3XJr5q6n+Gpwv9p
         mZnjbFIlO39QmVsfNhZr+zGRpLtd5PquX8Oj0jBjjERInrTcC1pGArVrIyl3Uc26e7HD
         JsSGlr8Y5xvVX1WAvqJfAMp2guhJgiZQv7pMQH0ToGo1GETT5BdbsMEiGtO5T4PqkamK
         X7BhqnARTVesH77aoDLkuRnWFMC7/k4yo7l3GsqPc+Ju3YaZ/5O8C6fbGzCzoSZI2eQ0
         HyzjqEXQFAan6XvZamq2i0Su4ISxvsyoQCvDfqHdrI4Z9DqV9zTsCkUdRLlfGYDqIdzk
         kuPg==
X-Gm-Message-State: AOJu0YxPw0nUNki1GDz+6WVt3TbFUcsj9lqWjTwFNBYh6mxuC5zT8LO2
	/+UkV6INzMvpTI2oljF2faOKcmZs6cwPAvpT0Th2dqY0YbKuck78yIop
X-Gm-Gg: Acq92OENrY7scv/H7uGFGhBFLPi/BTEsDmJ6BeCJ/xZTG2skuNv288lk52YD9bCrFcW
	cNVq3+vV/8T6vjPcehyscVSzTuRcOSD0W3F5SuYKSAI8AbrPAD0mvsgGAe8Dsk47zvUm4YIABkT
	v3gQzBYZd71aAYnznuHg75Y5mUZcCKhbLVO4kmVzZELBT8KidImqIK9SvMzInxnWOCMAAQyeRgb
	Czk/yYx9gs9NSUKbSpbpmyL6g9iENnxp3FIpAqC5sOcJwzEMEx1VUaVQ9bl1UUTfXWRcCBnE1Gj
	FLjFMb1ryluuoU+wDFAjd4Xi3X3BRRgSgl/qaFCanZg/y2HA7nz8PlZ7Aqox/rL1WJ4PQxpnSb9
	cJ6utV9HOckZXM/Z8AS4T4xHze7Ny+j1C8IZ7tDWUKOQnDNlCMr6JFRd24M6aptu2Erwu5SxIdo
	qKtvrWVg6epQPr1tr7ihq7hz0HGBXT3LdxoHclndVouLk32j8Qad5eZmXMrTu/pw==
X-Received: by 2002:a17:903:41ca:b0:2b7:aba0:ac10 with SMTP id d9443c01a7336-2beb066295cmr127842145ad.11.1779629316231;
        Sun, 24 May 2026 06:28:36 -0700 (PDT)
Received: from 192.168.1.3 ([2001:448a:2003:4286:c553:4edf:bb9:bbd2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56f4343sm91197175ad.36.2026.05.24.06.28.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 May 2026 06:28:35 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Igor Korotin <igor.korotin.linux@gmail.com>,
	Brandon Saint-John <branstj@gmail.com>,
	Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Subject: [RFC PATCH v3 0/4] iio: position: add Rust driver for ams AS5600
Date: Sun, 24 May 2026 20:28:19 +0700
Message-ID: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3 of the Rust driver for the ams AS5600 12-bit magnetic rotary
position sensor. v2 introduced minimal IIO abstractions and exposed
in_angl_raw and in_angl_scale via sysfs. This revision addresses all
soundness and correctness issues identified during review of v2.

The primary focus of v3 is hardening the IIO abstraction layer against
undefined behaviour reachable from safe Rust, and restructuring the
driver to use proper kernel synchronisation primitives.

Link: https://lore.kernel.org/linux-iio/20260419151327.26306-1-muchamadcoirulanwar@gmail.com/

Changes since RFC v2:

  IIO abstraction (rust/kernel/iio.rs):
  - Eliminated division-by-zero via IioVal::Fractional(i32, NonZeroI32).
    The denominator is now core::num::NonZeroI32, making it impossible
    to construct a zero value that would trigger div_s64(x, 0) inside
    iio_format_value() in the C IIO core.
  - Added Send + Sync bounds on the IioDriver trait. Without these, a
    driver could use thread-unsafe interior mutability (e.g. Cell) in
    its private data while the IIO core invokes read_raw concurrently
    from multiple sysfs readers.
  - Device::build_device() now accepts `impl PinInit<T, E>` instead of
    taking T by value. This allows drivers to use kernel synchronisation
    primitives (Mutex, SpinLock) that require in-place initialisation
    via PinInit and cannot be moved after construction.
  - Introduced typestate pattern (Unregistered -> Registered) for
    Device<T, State>. register() consumes Device<T, Unregistered> and
    returns Device<T, Registered>, making double-registration a
    compile-time error rather than a runtime corruption of cdev/kobject
    state.
  - Added DirectModeGuard RAII type in the read_raw trampoline. Claims
    iio_device_claim_direct() on entry and releases on drop, preventing
    concurrent access conflicts between sysfs reads and buffer/trigger
    operations.
  - iio_info vtable is now a compile-time const with only read_raw set;
    remaining fields are zeroed (NULL-checked by IIO core before use).
  - Added #[inline] to Device::register() per Rust subsystem guidelines
    for small abstraction methods that forward to C bindings.
  - Cleanup uses iio_device_free() (= put_device, kref-based) rather
    than direct kfree, ensuring in-kernel consumers holding a reference
    do not trigger use-after-free on the iio_dev allocation itself.

  I2C abstraction (rust/kernel/i2c.rs):
  - Implemented the kernel::io::Io trait for I2cClient, per Igor
    Korotin's feedback. This aligns with the agreed-upon direction for
    I2C register access abstractions and provides runtime bounds checking
    via io_addr() for free.
  - I2cClient now implements IoCapable<u8> and IoCapable<u16>, exposing
    try_read8() and try_read16() with automatic offset validation
    (maxsize=256 for SMBus command byte range).
  - Added #[inline] to all Io trait method implementations per Rust
    subsystem guidelines for thin forwarding wrappers.

  Driver (drivers/iio/position/as5600.rs):
  - Added kernel::sync::Mutex<As5600HwState> to serialize the multi-byte
    angle read sequence. The AS5600 hardware freezes the internal angle
    value on reading the high byte until the low byte is read; without a
    driver-level lock, concurrent sysfs reads interleave and corrupt the
    hardware latch mechanism, producing mismatched high/low halves.
  - Mutex is initialized in-place via pin_init!/new_mutex! macros,
    leveraging the PinInit-based Device::build_device() API.
  - probe() now returns Result<Self> with #[allow(refining_impl_trait)]
    instead of attempting to return impl PinInit<Self, Error> directly.
    This compiles correctly because Result<T, E> implements PinInit<T, E>.
  - Implemented circuit breaker pattern (DeviceState::Normal/Poisoned)
    for I/O error resilience. After a bus failure, the driver marks the
    device as Poisoned and attempts a recovery read on the next call,
    preventing I/O storms on a dead bus while allowing automatic recovery
    when the bus comes back.
  - Fixed import formatting to follow vertical style (one item per line)
    per kernel Rust coding guidelines.
  - Channel spec allocated via KBox (heap) rather than stack, ensuring
    the pointer stored in indio_dev->channels remains valid for the
    lifetime of the IIO device.

  Known limitations (to be addressed before mainline):
  - channels[] is heap-allocated via KBox inside As5600Priv (in
    iio_dev->priv_). If an in-kernel consumer holds a reference via
    iio_channel_get() and the driver unbinds, drop_in_place(T) frees
    the KBox while indio_dev->channels still points to it. Fix: use a
    static const channel spec or tie the allocation lifetime to iio_dev
    itself. This is acceptable for RFC since the AS5600 has no known
    in-kernel consumers.
  - No power management (suspend/resume) hooks yet.
  - write_raw and buffer/trigger support deferred to future work.

Changes since RFC v1:
  - Moved magnet validation from probe() to read_raw() (Jonathan's
    feedback). probe() now only verifies I2C communication.
  - Added minimal Rust IIO abstractions (rust/kernel/iio.rs).
  - Added OF device table for devicetree matching (ams,as5600).
  - Replaced hex bit masks with kernel::bits::bit_u8() (Miguel's
    pointer).
  - Downgraded log messages to dev_dbg!(), removed unbind noise.
  - iio_info vtable is now a compile-time const.

Design notes:

  The IIO abstraction does NOT use devres (devm_iio_device_alloc). The
  Rust Drop implementation has full control over the cleanup sequence:
  iio_device_unregister -> drop_in_place(T) -> iio_device_free. This
  avoids lifetime conflicts between Rust ownership and the C devres
  teardown ordering.

  The mask parameter in read_raw uses `isize`, which is identical to
  `ffi::c_long` in the kernel (rust/ffi.rs defines c_long = isize on
  all supported architectures). No type mismatch exists.

  Module ownership is enforced via the second parameter of
  __iio_device_register(indio_dev, module), not via iio_info.owner.

The IIO abstraction is intentionally minimal: it supports read_raw with
IIO_VAL_INT, IIO_VAL_INT_PLUS_NANO, IIO_VAL_INT_PLUS_MICRO, and
IIO_VAL_FRACTIONAL. write_raw and buffer support are left for future
work.

The IIO abstraction design was informed by earlier unpublished work from
Brandon Saint-John.

Muchamad Coirul Anwar (4):
  i2c: rust: implement kernel::io::Io trait for I2cClient
  rust: add minimal IIO subsystem abstractions
  iio: position: add Rust driver for ams AS5600
  iio: position: as5600: add Kconfig and Makefile entries

 drivers/iio/position/Kconfig   |  14 ++
 drivers/iio/position/Makefile  |   1 +
 drivers/iio/position/as5600.rs | 289 ++++++++++++++++++++++++++++
 rust/helpers/helpers.c         |   1 +
 rust/helpers/iio.c             |  24 +++
 rust/kernel/i2c.rs             |  76 +++++---
 rust/kernel/iio.rs             | 341 +++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs             |   2 +
 8 files changed, 723 insertions(+), 25 deletions(-)
 create mode 100644 drivers/iio/position/as5600.rs
 create mode 100644 rust/helpers/iio.c
 create mode 100644 rust/kernel/iio.rs

Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
Testing performed on BeagleBone Black (AM335x), kernel v7.0.0-rc3,
AS5600 on i2c-2 (0x36) at 3.3V, 6mm diametric neodymium magnet.

Build: make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- M=drivers/iio/position
       (zero warnings, zero errors)

Functional tests:

  1. Probe & registration:
  $ echo "as5600 0x36" > /sys/bus/i2c/devices/i2c-2/new_device
  $ cat /sys/bus/iio/devices/iio:device0/name
  as5600

  2. Scale attribute:
  $ cat /sys/bus/iio/devices/iio:device0/in_angl_scale
  0.001533981

  3. Raw angle reads (magnet present, rotated by hand):
  $ cat /sys/bus/iio/devices/iio:device0/in_angl_raw
  576
  $ cat /sys/bus/iio/devices/iio:device0/in_angl_raw
  3758
  $ cat /sys/bus/iio/devices/iio:device0/in_angl_raw
  3115
  (multiple reads across 0-4095 range confirmed)

  4. Magnet removed (MD bit clear -> ENODATA):
  $ cat /sys/bus/iio/devices/iio:device0/in_angl_raw
  cat: '/sys/bus/iio/devices/iio:device0/in_angl_raw': No data available

  5. Transient bus error (glitch -> EIO, auto-recovery on next read):
  read_raw: STATUS read failed -> handle_io_error()
  handle_io_error: dummy read OK -> state stays Normal
  Next read: succeeds immediately

  6. Circuit breaker (bus disconnected -> Poisoned -> reconnected):
  read_raw: STATUS read failed -> handle_io_error()
  handle_io_error: dummy read failed -> state=Poisoned, return EIO
  Next read: state=Poisoned, recovery read failed -> stay Poisoned
  (reconnect bus)
  Next read: state=Poisoned, recovery read OK -> state=Normal
  Immediate angle read succeeds (no double-read, result used directly)
  Full cycle verified twice: Normal -> Poisoned -> Poisoned -> Normal

  7. Concurrent stress test (10 parallel readers, 10 seconds):
  $ for i in $(seq 1 10); do
      (while true; do cat .../in_angl_raw > /dev/null 2>&1; done) &
    done; sleep 10; kill $(jobs -p)
  $ dmesg | grep -i "oops\|panic\|bug\|rcu"
  (empty -- no kernel issues, no corrupted values)

  8. Unbind/rebind race (concurrent read + 20 lifecycle cycles):
  Terminal 1: while true; do cat .../in_angl_raw 2>/dev/null; done &
  Terminal 2: for i in {1..20}; do unbind; sleep 0.1; bind; sleep 0.1; done
  $ dmesg | grep -i "oops\|panic\|bug:"
  (empty -- iio_device_unregister drains callbacks before teardown)

  9. PinnedDrop cleanup verified via dmesg:
  iio_device_unregister -> drop_in_place(Mutex+KBox) -> iio_device_free

-- 
2.50.0

