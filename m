Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046A22236F0
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787380062; cv=none; b=eGqdHNKpGaLv6UlVPK3Aebp2R3SD5RB+kH4kTiAJ54cgL2GaHjFx7BLQ0AvGXLtGbtqEzZLXwPRFrCQnNGi1cuQnOCCZXrCT1z7AswUEJMp3lodSAJ+mW4/Rl85lCT4GBU8gRb/6Y+C75E5yj8zBqjautrh/qH2UMHNAbCnE71I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787380062; c=relaxed/simple;
	bh=UjWbyXHf8YyJTPJ2ugbHAn7sPFM0wGw7PV7UgN4EkXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fCT/v1z1WcVH3gz5oZRIkwfTCdkq8XWBaIcvCSvmYM6CmmcNDrgabig08yH4E4ECu4CIACEUFy48h0Vm/A/1RYVX3grDuVCCTW07qrMY8uFFt8+DhsKv9G/D4K1DX0JkCN+nYiWpyu6ukNsehtn4M/yoD48G2tOeq91gRIZxRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeTgCLyU; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeTgCLyU"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1537849a91.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 23:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787380059; x=1787984859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GG8i1Pak1SZX3raZGB8JcbECAmyZD/k4P18si8HrgeM=;
        b=VeTgCLyUsH58npdiADeTiUV/Rlj2j07OKpQALG8cxgF9sqSUh3yFhJByMhDOV+pTPk
         /IBhHefrxgd6VdO12qcdy9T+okYZsiCRFm5saBFLRoqBE6aE/kZs9sBrBP2GIXKJ6md6
         veTbLElsnUHIoxIinf5pOMIeoL9BmZorZpaEZy22vsWFCDftHyXKHe5ZEig4NsJblp0p
         KP0a6+D2ksYtxLx4C8mAX2bY5qNiCPsMNKc3z4BBtdLRYOa+CfD4jCULGI4KTNgN5sFC
         sc2ohxxePDWxvCxwwHn3UNbTQk4Mm6nD9MqzdOZ3yWFojTTcl9oL3y6ZzGVS/2/iSf4t
         r4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787380059; x=1787984859;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GG8i1Pak1SZX3raZGB8JcbECAmyZD/k4P18si8HrgeM=;
        b=pWdOtkeqqd+nQ47lYlAn8+gE39aPqnqskcLC6X1OrfLmjExTlTJg9qlIZ+mzOR3q5O
         esqmuNl0SN3gFHbkXhO1741cEZQFKoa2kMhNtnfie5P2RRPNxZGUsLI/ONMv3Epd84AJ
         vBX8OqJKPQToLH0EIpFRVZIb83ajTaL5bk2efPSEwlz6+2APUG0MTq6KDqIVjTLENYGf
         A3OjZpNPiop9zY/csAdvyiM8cq2ziCIo2fBPmGyZpzM2QiObAeQUQ6dKEfhR76Qbp8D0
         hN5h6VWdScWO0j5axMgUNrxbdcC4ZaPi9MBnrRomNnEVGo0ryGUWMEUMeFSWO0IeVqg4
         wjbA==
X-Gm-Message-State: AFuF++l53unviAvN+teWxMPD+5rycKrAPQdiTBPDVWxj/I1RCclWoOKc
	Bo1KjBNrp3C8vK3EJE59l8lORJGZQJQsbFkUmLZfyit+AsXtWxJo2Smf
X-Gm-Gg: AR+sD10GuGkfqJjMTy5x6JWAjnbAsbxQfgYuroogZUQe10fLeviPtjsgsp/bXCgzldv
	3B2KpjfgcvDEg1kTXeRLpin7kBk3LtH9sLM/n1RWtd91wBryioRi/bVtwMoJSbuoisKu1IzSsg7
	gSyy5C1fpwOwH+vCqC2eKVYVg7venoaqUNsH8oYINk3sLZ2EO55zv5ivIHu1SBtY6KQGKZrxcI8
	TcYBGUiEGiB+Q7tx8WUk/stMwZb0J5vg9X2GfZFv7mc4+q5H8+RRv+cIGqv/MxqEYH80Cvm7jd7
	rMrMGWGIfOM3RJDtUmyah1ZBEraltM9lAAE5Fk6w5hqaLbAQveB0XPUz+PVzOcF0it8LVb+NSK0
	D4o4yY9iG4y9IdCbrqDbLqIyRTSsye0cA632BjOFT0ZjHKyvG8yczX6mxhgam3tYi8rTGMcyynI
	bWR7t5ERpDhccdYtMvtigWyRIP14f4xN3qKJHClRCsHYVTwktpUyRs/ozNb0WwWAfAfiyimXsAh
	m0EUi+Ex+HhFFqBd9Wn4OmpBHU=
X-Received: by 2002:a17:90b:1a85:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-395c3aa9e26mr20558507a91.16.1787380059291;
        Fri, 21 Aug 2026 23:27:39 -0700 (PDT)
Received: from 192.168.1.20 ([2402:8780:104c:d93:50df:47ce:56b8:7bd1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c9128498sm1788519a91.2.2026.08.21.23.27.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 23:27:38 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com,
	ojeda@kernel.org,
	dakr@kernel.org,
	igor.korotin@linux.dev,
	branstj@gmail.com,
	brucer42@gmail.com,
	Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Subject: [RFC PATCH v5 0/3] iio: position: add Rust driver for ams AS5600
Date: Sat, 22 Aug 2026 14:26:55 +0800
Message-ID: <20260822062725.60519-1-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v5 of the Rust driver for the ams AS5600 12-bit magnetic rotary
position sensor.

Link: https://lore.kernel.org/linux-iio/20260707151542.91997-1-muchamadcoirulanwar@gmail.com/

Base tree and dependencies:

  This series is based on driver-core-testing [1], not vanilla rust-next.
  It depends on Gary Guo's io_projection-v6 [2] for IoBackend, IoBase,
  Region, and KnownSize.

  FallibleIoCapable is included in patch 1/3 following Danilo's
  suggestion [3] to carry it as a prerequisite until it lands upstream.

  [1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/log/?h=driver-core-testing
  [2] https://lore.kernel.org/driver-core/20260706-io_projection-v6-0-72cd5d055d54@garyguo.net/
  [3] https://lore.kernel.org/all/DJVQ852J7SOH.26YBIJTQ9B66G@kernel.org/

Changes since RFC v4:

  I2C abstraction:
  - Switch to FallibleIoCapable — IoCapable is infallible by design,
    but I2C can fail at transport level (Igor)
  - Restrict I/O ops to I2cClient<Bound> (Danilo)
  - Add smbus_read_word() and smbus_read_word_swapped() for odd offsets
  - Add FallibleIoCapable trait to io.rs with blanket impl
  - Add bit_usize() to bits.rs

  IIO abstraction:
  - Replace raw isize mask with IioChanInfo enum (Nuno)
  - Expand PinnedDrop SAFETY comment re: kernfs_drain() (Danilo)
  - build_device() takes modes parameter instead of hardcoding
  - channels() now returns &'static slice

  Driver:
  - Use smbus_read_word_swapped() instead of manual swap_bytes()
  - Use ARef<I2cClient<Bound>> (Danilo)
  - Drop pr_info! debug logging
  - Kconfig cleanup (Jonathan)

  Known limitations (unchanged):
  - No power management
  - No write_raw, buffer, or trigger support

Design notes:

  The IIO abstraction uses iio_device_alloc (not devm_*) so the Rust
  Drop controls cleanup ordering: unregister, drop driver data, then
  free iio_dev.

  iio_device_unregister() drains in-flight sysfs reads via kernfs_drain().
  This is sufficient for INDIO_DIRECT_MODE without buffer/trigger.
  Character device paths need separate analysis.

  Module ownership via __iio_device_register(), not iio_info.owner.

Muchamad Coirul Anwar (3):
  i2c: rust: implement SMBus access via IoBackend and FallibleIoCapable
  rust: add minimal IIO subsystem abstractions
  iio: position: add Rust driver for ams AS5600

 drivers/iio/position/Kconfig    |  11 +
 drivers/iio/position/Makefile   |   1 +
 drivers/iio/position/as5600.rs  | 189 +++++++++++++++++
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/bits.rs             |  29 +++
 rust/kernel/error.rs            |   1 +
 rust/kernel/i2c.rs              | 302 +++++++++++++++++++++++++++
 rust/kernel/iio.rs              | 384 +++++++++++++++++++++++++++++++++++
 rust/kernel/io.rs               |  66 ++++--
 rust/kernel/lib.rs              |   2 +
 10 files changed, 967 insertions(+), 20 deletions(-)
 create mode 100644 drivers/iio/position/as5600.rs
 create mode 100644 rust/kernel/iio.rs

---
Tested on BeagleBone Black (AM335x), kernel 7.2.0-rc1+,
AS5600 on i2c-2 (0x36) at 3.3V, 6mm diametric neodymium magnet.
Full test session: 2026-08-17.

Build: make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- modules
       (zero warnings, zero errors)

Functional tests:

  1. Probe and registration:
     $ sudo insmod as5600.ko
     $ echo "as5600 0x36" > /sys/bus/i2c/devices/i2c-2/new_device
     $ cat /sys/bus/iio/devices/iio:device0/name
     as5600
     $ ls /sys/bus/i2c/devices/2-0036/driver
     2-0036  bind  module  uevent  unbind

  2. Raw angle and scale (magnet present):
     $ cat /sys/bus/iio/devices/iio:device0/in_angl_raw
     3366
     $ cat /sys/bus/iio/devices/iio:device0/in_angl_scale
     0.001533981
     20 consecutive reads, all within 0-4095.
     Computed: 3366 * 0.001533981 = 5.163 rad (~295.9 degrees).

  3. Unbind/rebind lifecycle (PinnedDrop with ARef cleanup):
     $ echo "2-0036" > /sys/bus/i2c/devices/2-0036/driver/unbind
     $ ls /sys/bus/iio/devices/iio:device0 2>&1
     ls: cannot access '...': No such file or directory
     $ echo "2-0036" > /sys/bus/i2c/drivers/as5600/bind
     $ cat /sys/bus/iio/devices/iio:device0/name
     as5600
     $ dmesg | grep -i "oops\|panic\|bug:"
     (empty)

  4. Concurrent stress (Mutex serialization under contention):
     10 parallel readers hammering in_angl_raw for 5 seconds.
     Repeated as 20-cycle unbind/rebind loop with readers active
     throughout (8 seconds total).
     $ dmesg | grep -i "oops\|panic\|bug:\|rcu"
     (empty)

  5. Module removal under active I/O:
     a) rmmod while flood readers are running — no crash.
        iio_device_unregister() drains in-flight read_raw callbacks
        before PinnedDrop proceeds; subsequent reads return ENOENT.
     b) rmmod while a sysfs fd is held open — no crash.
        iio_dev kref not released until fd is closed.
     $ dmesg | grep -i "oops\|panic\|bug:"
     (empty)

  6. Lifecycle stress:
     50x rapid unbind/rebind — no crash, device functional after all
     cycles.
     50x insmod/rmmod — no crash.
     $ dmesg | grep -i "oops\|panic\|bug:"
     (empty)

  7. I2C bus disconnect:
     SCL/SDA physically pulled while read loop is running. Driver
     returns "Remote I/O error" immediately on each failed transfer;
     no hang, no internal retry loop. Cable reconnected — reads resume
     from the next iteration without rmmod (about 2 seconds downtime).
     rmmod issued while bus still in error state — exits cleanly.
     ARef<I2cClient> drop is put_device() only, no bus transaction.
     $ dmesg | grep -i "oops\|panic\|bug:"
     (empty)

  8. Memory and locking:
     dmesg contains no strings matching "KASAN:" or "possible deadlock".
     The test kernel was not built with CONFIG_KASAN or CONFIG_PROVE_LOCKING;
     the above is a pattern match against kernel log output, not sanitizer
     or lockdep instrumentation.
     kmemleak not available (CONFIG_DEBUG_KMEMLEAK not set).

-- 
2.50.0

