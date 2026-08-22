Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A966330D3E5
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787380109; cv=none; b=Ts6BFDQiatURjSsFjluHDpgaRQN89dQ8jJd/xL97IfXOQPovKhFqNv7OlTjn5uHaC8PtYG7wBmI0UyKO0IEYoVg1qMou6iDvWPntTDNK5mlPBU3gsj3Hx3ALzcsquf6/cp93xAxiAO+hKmKwPMtrxyFl+XfljimrOxCq6bhWkgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787380109; c=relaxed/simple;
	bh=uAwhE2kHU9mqidDO2nmljYr7WfPvu+fcYAQliNjCrVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oznwAalfki6XN/gAarqO62dL2jaz+d5INdRgxU2bM8q07ALpr0bQxB9hgSwPHLWU3Nvj0e9gdbeb9gupfrkEU8gy9KDQ1FTttsqNyvlYbmm2hiB+USzMeAUfF4E4TD7tynD6dyDSaXHymwFfNmUqbpJ83J+2ZqqYKJ1eG4WJ7Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLu2HBcf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLu2HBcf"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ccf2360620so15580355ad.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 23:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787380107; x=1787984907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tag2M6Utu+miagcXfcnjHgNWD2M3eOPe/bDAJrnpofs=;
        b=LLu2HBcfTONpKF0U/j/TXldTT3zAAQ9YNHx7z3SI9+fiYQNIdREQW58kQ+HjQ+cTO8
         RDshN2FAwnmTagyxN+6jF0HKt6rwgKfxd3QokkCMi6l1k+c+GGomUdoOXtEXIIhZ4okL
         A1VlbtquYPKwDHRppkvPTDZVzFLvAuDlML8n0XmA1XtdEfeAGVixjHgFwvmjYeUdTV8n
         KBB7rBwmM/eoFbvwh0Hn1B/SNVNbrcvDioDnuQtgxnN/by6rgc787BL6ARh5wTL5elRI
         BVH9i1tYpscLZdEGq3EE1c9ubBfiTpYMx/xD0J6psJXkJrpCFLG4MZhCZEMD95RXU2bN
         w71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787380107; x=1787984907;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tag2M6Utu+miagcXfcnjHgNWD2M3eOPe/bDAJrnpofs=;
        b=G5RULfSk+Ip7E9xn1NfbOEW1h2/HwxKNbLeahcKxsfjKqiWk1Lq4ipdcLnkPWf3QA4
         9piVkH7wTGW1AEIkFUAJuAG8BBYNSS/MpVxvQN6J+kg85rsd5fQx48h8GcAixWqtm+H+
         1DeZVcIXWLIZT3KTH5Pxd0YFr/pZYJThfm48vV1F8OZh0CxGFMOWHKrngic8v6+JMzzu
         wp1OmPoARt3mkSfrkVun51vBkzmmG/rsVfxiaeOCey2FOyyB9cZ3pcTBcct3N2k2tvS/
         UFYc9IXfNaTa/9WIxSvallyBt6w3nB1hgzihIjjBypWUogydtIbyrSrbD2lnl/3CoY1o
         j4rQ==
X-Gm-Message-State: AFuF++nZ0Uvt7VWVhyxgA+YncULjcsbTTU/PcIvvXX0co05QFm9t0jHB
	o3SVssPRMNk3Z6Tkw15efTkeFF8S/dZTZy0TknPj9ISTUwhVs2lSMJS2
X-Gm-Gg: AR+sD110QJoFdruozD6mphwaEuOonaT4YKBURXYone4sM9nh+fdKxrnBB9/b9SnkCxd
	kD+RKQd7rCsFEaHah+53aew6V5cSO3324vuFuFQM54YubZbh6vHsye2DodCR/UyoHwMuDwps1/J
	w/3091g4uFgCk1PFxKE8enIDsT/YuMpyEM99Zj6/WuBurl63RG9ff3nbeEeYEga+R3i+eCBTJ9p
	+kWFoovgFOMRkG3dm5dtGR4BYWhmhBMVdLu4vB3sICJpPO/LC5jOvAZb68QbAOCttMbYWM7fzmI
	RfTAKjYLjlfdu33IfIkVvUY4QhBTcLYjO73nIR1jPYH3i98H57whLkt0WosGA9MK+FA8kOz/3b9
	9Nhtwo2058HEe9QvWN49PBJfEGtXhchXgXHtvSsZkc4mizg+4zeIuzTu9pHZ4Wdr3wSTSBVmzdu
	6fOAZdRbozVVc/lJBbRWRXiHRk9/jLnwdv1KgVxdIgVclncdTHMn7LSRfqshSqdKgNFqtfYMKDJ
	v9lUcMvZG+7GcNujtLoOhC63UOVN5PAveqhow==
X-Received: by 2002:a17:90b:528f:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-395c35636acmr21996808a91.7.1787380106743;
        Fri, 21 Aug 2026 23:28:26 -0700 (PDT)
Received: from 192.168.1.20 ([2402:8780:104c:d93:50df:47ce:56b8:7bd1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c9128498sm1788519a91.2.2026.08.21.23.28.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 23:28:26 -0700 (PDT)
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
Subject: [RFC PATCH v5 3/3] iio: position: add Rust driver for ams AS5600
Date: Sat, 22 Aug 2026 14:26:58 +0800
Message-ID: <20260822062725.60519-4-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260822062725.60519-1-muchamadcoirulanwar@gmail.com>
References: <20260822062725.60519-1-muchamadcoirulanwar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a Rust driver for the ams AS5600 12-bit magnetic rotary position
sensor. The driver exposes in_angl_raw and in_angl_scale via the IIO
sysfs interface.

Features:
- ARef<I2cClient<Bound>> for safe refcounted I2C client access
- Mutex-serialized status + angle read sequence
- Static channel spec (module-level const)
- No magnet validation at probe (deferred to read_raw per IIO convention)
- Error propagation via ? operator (no recovery state machine)
- Type-safe IioChanInfo enum dispatch in read_raw

The AS5600 stores the 12-bit raw angle big-endian across registers
0x0C-0x0D. smbus_read_word_swapped() handles the byte swap: SMBus
always transmits the low byte first (little-endian wire), so an
unconditional byte swap recovers the correct value regardless of CPU
endianness. The long-term solution is regmap-rs where endianness is
configured once at the transport level.

This driver uses INDIO_DIRECT_MODE without buffer or trigger support.
All userspace access is through sysfs attributes, which ensures safe
cleanup via kernfs_drain() synchronization in the IIO abstraction's
PinnedDrop. See the module-level doc comment for details.

Tested on BeagleBone Black (AM335x) with AS5600 on i2c-2 (0x36).

Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 drivers/iio/position/Kconfig   |  11 ++
 drivers/iio/position/Makefile  |   1 +
 drivers/iio/position/as5600.rs | 189 +++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 drivers/iio/position/as5600.rs

diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
index 1576a6380b53..ac4f19d61ff6 100644
--- a/drivers/iio/position/Kconfig
+++ b/drivers/iio/position/Kconfig
@@ -6,6 +6,17 @@
 
 menu "Linear and angular position sensors"
 
+config AS5600
+	tristate "ams AS5600 magnetic rotary position sensor"
+	depends on I2C && RUST
+	help
+	  Support for the ams OSRAM AS5600 12-bit magnetic rotary
+	  position sensor. Provides in_angl_raw (0-4095) and
+	  in_angl_scale (radians per LSB) via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called as5600.
+
 config IQS624_POS
 	tristate "Azoteq IQS624/625 angular position sensors"
 	depends on MFD_IQS62X || COMPILE_TEST
diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
index d70902f2979d..2d26f6d6ace3 100644
--- a/drivers/iio/position/Makefile
+++ b/drivers/iio/position/Makefile
@@ -4,5 +4,6 @@
 
 # When adding new entries keep the list in alphabetical order
 
+obj-$(CONFIG_AS5600) += as5600.o
 obj-$(CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE) += hid-sensor-custom-intel-hinge.o
 obj-$(CONFIG_IQS624_POS)	+= iqs624-pos.o
diff --git a/drivers/iio/position/as5600.rs b/drivers/iio/position/as5600.rs
new file mode 100644
index 000000000000..8f2ea20a0645
--- /dev/null
+++ b/drivers/iio/position/as5600.rs
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2026 Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
+//! Driver for ams AS5600 12-bit magnetic rotary position sensor.
+//!
+//! This driver uses `INDIO_DIRECT_MODE` without buffer or trigger support.
+//! All userspace access is through sysfs attributes (`in_angl_raw`,
+//! `in_angl_scale`), which ensures safe cleanup via `kernfs_drain()`
+//! synchronization in the IIO abstraction's `PinnedDrop`.
+//!
+//! Datasheet: https://look.ams-osram.com/m/7059eac7531a86fd/original/AS5600-DS000365.pdf
+
+use kernel::{
+    bindings::{
+        iio_chan_info_enum_IIO_CHAN_INFO_RAW,
+        iio_chan_info_enum_IIO_CHAN_INFO_SCALE,
+        iio_chan_spec,
+        iio_chan_type_IIO_ANGL,
+        INDIO_DIRECT_MODE, //
+    },
+    bits::{
+        bit_u8,
+        bit_usize,
+        genmask_u16, //
+    },
+    device::{
+        Bound,
+        Core, //
+    },
+    error::code::ENODATA,
+    i2c::{
+        DeviceId,
+        Driver,
+        I2cClient,
+        IdTable, //
+    },
+    i2c_device_table,
+    iio::{
+        Device,
+        IioChanInfo,
+        IioDriver,
+        IioVal,
+        Registered, //
+    },
+    io::Io,
+    module_i2c_driver,
+    of,
+    of_device_table,
+    prelude::*,
+    sync::{
+        aref::ARef,
+        new_mutex,
+        Mutex, //
+    }, //
+};
+
+const AS5600_REG_STATUS: u8 = 0x0B;
+const AS5600_REG_RAW_ANGLE_H: u8 = 0x0C;
+
+const AS5600_STATUS_MD: u8 = bit_u8(5);
+const AS5600_RAW_ANGLE_MASK: u16 = genmask_u16(0..=11);
+
+module_i2c_driver! {
+    type: As5600,
+    name: "as5600",
+    authors: ["Muchamad Coirul Anwar"],
+    description: "I2C Driver for ams OSRAM AS5600 Magnetic Rotary Position Sensor",
+    license: "GPL",
+}
+
+i2c_device_table!(
+    I2C_TABLE,
+    MODULE_I2C_TABLE,
+    <As5600 as Driver>::IdInfo,
+    [(DeviceId::new(c"as5600"), ())]
+);
+
+of_device_table!(
+    OF_TABLE,
+    MODULE_OF_TABLE,
+    <As5600 as Driver>::IdInfo,
+    [(of::DeviceId::new(c"ams,as5600"), ())]
+);
+
+struct As5600Channels([iio_chan_spec; 1]);
+
+// SAFETY: `iio_chan_spec` is a plain C struct with no interior mutability.
+// All pointer fields (`event_spec`, `ext_info`, `extend_name`, etc.) are
+// NULL — set via `zeroed()` and never reassigned — so no shared mutable
+// state exists behind them. The static is a compile-time constant with no
+// `&mut` access path, making concurrent shared access safe.
+unsafe impl Sync for As5600Channels {}
+
+static AS5600_CHANNELS: As5600Channels = As5600Channels({
+    // SAFETY: `iio_chan_spec` is a repr(C) struct where all-zeroes is valid
+    // (integers default to 0, pointers to NULL).
+    let mut chan: iio_chan_spec = unsafe { core::mem::zeroed() };
+    chan.type_ = iio_chan_type_IIO_ANGL;
+    chan.info_mask_separate = bit_usize(iio_chan_info_enum_IIO_CHAN_INFO_RAW)
+        | bit_usize(iio_chan_info_enum_IIO_CHAN_INFO_SCALE);
+    [chan]
+});
+
+#[pin_data]
+struct As5600Priv {
+    #[pin]
+    io_lock: Mutex<As5600HwState>,
+}
+
+struct As5600HwState {
+    client: ARef<I2cClient<Bound>>,
+}
+
+impl IioDriver for As5600Priv {
+    fn read_raw(&self, _chan: *const iio_chan_spec, info: IioChanInfo) -> Result<IioVal> {
+        match info {
+            IioChanInfo::Raw => {
+                let hw = self.io_lock.lock();
+                let io = hw.client.smbus_io();
+                // Read status register to verify magnet presence before
+                // reading the angle.
+                let status = io.try_read8(AS5600_REG_STATUS as usize)?;
+
+                // Check magnet presence (MD bit). Without a magnet the angle
+                // register contains stale/invalid data.
+                if (status & AS5600_STATUS_MD) == 0 {
+                    return Err(ENODATA);
+                }
+
+                // Word read at register 0x0C returns big-endian data.
+                // smbus_read_word_swapped() handles the byte swap.
+                // Mutex ensures status + angle read is atomic.
+                let raw = hw.client.smbus_read_word_swapped(AS5600_REG_RAW_ANGLE_H)?;
+                let angle = raw & AS5600_RAW_ANGLE_MASK;
+                Ok(IioVal::Int(angle as i32))
+            }
+            // Scale factor: radians per LSB = 2*pi / 4096 ~= 0.001533981
+            IioChanInfo::Scale => Ok(IioVal::IntPlusNano(0, 1533981)),
+        }
+    }
+
+    fn channels(&self) -> &'static [iio_chan_spec] {
+        &AS5600_CHANNELS.0
+    }
+}
+
+#[pin_data]
+struct As5600 {
+    #[pin]
+    _iio_dev: Device<As5600Priv, Registered>,
+}
+
+impl Driver for As5600 {
+    type IdInfo = ();
+    type Data<'bound> = As5600;
+
+    const I2C_ID_TABLE: Option<IdTable<Self::IdInfo>> = Some(&I2C_TABLE);
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+
+    // `try_pin_init!` returns a concrete anonymous type that may expose more
+    // bounds than the trait signature declares (e.g. auto-traits like `Send`).
+    // This refinement of the RPITIT return type is intentional.
+    #[allow(refining_impl_trait)]
+    fn probe<'bound>(
+        dev: &'bound I2cClient<Core<'_>>,
+        _id_info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        try_pin_init!(As5600 {
+            _iio_dev: {
+                // Deref coercion: I2cClient<Core<'_>> -> I2cClient<Bound>.
+                // We capture the Bound context to call smbus_read_word_swapped()
+                // and try_read8(), which require Bound.
+                let bound: &I2cClient<Bound> = dev;
+                let client: ARef<I2cClient<Bound>> = ARef::from(bound);
+
+                let priv_init = pin_init!(As5600Priv {
+                    io_lock <- new_mutex!(As5600HwState {
+                       client
+                    }),
+                });
+
+                let iio_dev =
+                    Device::build_device(dev.as_ref(), c"as5600", INDIO_DIRECT_MODE, priv_init)?;
+                let registered = iio_dev.register(&crate::THIS_MODULE)?;
+                dev_dbg!(dev.as_ref(), "AS5600 magnetic position sensor ready\n");
+                registered
+            }
+        })
+    }
+}
-- 
2.50.0

