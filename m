Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AB0126BF7
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779629335; cv=none; b=d4bK9ti7qS0veF4vgop/Ovy2PDKu/H3EuJsZ+GtlIhPjwB1SW5fHZaIU7UAIDCQxV4NOWa+RRC6clOqrm5qmNX7kzU+ZLqng4CLRm99VmtIIByHwZXMOqhFaDJRJS5i7Bai9grYdd6fpgs753gsLlntdW75T8Dz42kNIgIRZBRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779629335; c=relaxed/simple;
	bh=sCPRa+Pg6iqOf8JJkDf2nkLCIFCgH9NKdJKw4TM4vwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1Win122ZwVderkMxNxKAQ++kWsdxqUp1Er3oGDjB0rlMOBQRwBk5e6fGuUsafCk7re2kWitFT0t2ogIg2fiAynTjzADsMf9GfJPls3LSxgScavOGEDUXsP52zd4SyMFNT/W47wCkaMLketB8z/DhucRiPbdRaOHP3FyWDrjybU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BI5x5GtG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI5x5GtG"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bdeed4f717so45503235ad.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779629333; x=1780234133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVuOrsHgj0yEZq2/rleCfYS+yYI4maV483S6Tokx11g=;
        b=BI5x5GtGots6fwUKcpewsEcPHsIHPyQgMWyro8awez8COSreITBfdqaMB0hp2VPt8S
         yeIZPFyP9Vk918NudFhE7ZpSYF/gDhhkFn8wpIX6OYTL+bOVbQKxo4toRRv+SRzJhPBB
         1QdYX5KJdX8bWHm7IcEFYjg2mT8zqH8VJwi/uAC8aKhZBWfGvdjWskkMXwmlTSVsFpAO
         sgriWZaAPVc1aemvcHyQRMVWOgILCvNCK+/9eeKJeAyCnekjSaSjdMAIQFMjF90qlXZX
         r5saWV5hmqGOyeu30KAmPRTP4tFMnVCpFLdwer/lQY6IGHqndBke4yuD0Q0maePFAb4N
         b4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779629333; x=1780234133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uVuOrsHgj0yEZq2/rleCfYS+yYI4maV483S6Tokx11g=;
        b=s5X4tZrUPSQ6u51Sv+TSTzx2qe8VbQs/QRlfahWL2ai0flpizH8Y4AeI4Oao0l/Zp/
         haD99S6aCq2psLe3wxGCTBBiBf83kS/I9iIR4JUNAtE0RtdIHuNLkpRikfb3Agr9QMQ+
         osBMa3L88RzmRyYWMhej/OFerelCWRdOesS9iP22oqEEqQm1EPjg27V0KRt/MsU9Zmyz
         cm2eQSL+XpDkqAvFjsZ4/HExTQILjRPwRB0MfzJNwUn6T0/LfBTuAUpW6xvTpakSzw5O
         k90J4GL999osw3+4xZ1eC/hFVN5q/GjseGuJM/8xoP3tO67WGLngfTp5qj1sz6ee+p3T
         GEiA==
X-Gm-Message-State: AOJu0YxlECegZ/syr5f8fqCKuXKjPEiDP7j7eF7NEpOVfA0+Cpnr73Qp
	TTfwl25XdEu/qiCTXHYMW85+foF9oWyrqQHx6XOCguxu9iv0eaZW8jG3
X-Gm-Gg: Acq92OHiE2Dtb4nUxdevPj/KAk3lIUdJ38hQwn8N8YRvOJVHJRoOG+D2L87jkoZHBUl
	IpRG43PoAlms93/gYSLdBFVMfvbQKIjgLBJ8p3qa2w7urJrhnpy9WKhXEF2U4ehzKDNwum2LAFv
	yDR7nhEaMmE4FcWlcmwG0Bi0kMupEsKxK7RlYZilcpu5mGGF4d4+hwbU4S76vvnr8NPsAgql0Qu
	ECvWt94/BOryoyfB87cEsxXoK2bMhRVZz8F6VdZfHrhxn0qVjumKTdXkjsix1RU5hxxTVmzYMc7
	k0gPYcfUnf6w+r3MY25/abxphR/0jjqK2KMbBGodIVf7vTmf7R0vLYsxRHfQ3wWd6bkrefXimlH
	XFskVIsCGj5Na0kBixdcomTLPiqIt6SMd9JCQpBqXaU09P++bIdtpd+yY9jqm084ERTDpywRuk2
	XsARchP0qkMiGF8wzDSIxX5ybWpnlnp64Bf8UwJ5RYuczsv8+G1pNoJLREa+muWw==
X-Received: by 2002:a17:903:2b0e:b0:2bc:7c62:187 with SMTP id d9443c01a7336-2beb06133f5mr125142545ad.29.1779629333392;
        Sun, 24 May 2026 06:28:53 -0700 (PDT)
Received: from 192.168.1.3 ([2001:448a:2003:4286:c553:4edf:bb9:bbd2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56f4343sm91197175ad.36.2026.05.24.06.28.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 May 2026 06:28:52 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Igor Korotin <igor.korotin.linux@gmail.com>,
	Brandon Saint-John <branstj@gmail.com>,
	Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Subject: [RFC PATCH v3 3/4] iio: position: add Rust driver for ams AS5600
Date: Sun, 24 May 2026 20:28:22 +0700
Message-ID: <20260524132824.54918-4-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
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
- Circuit breaker pattern for I/O error resilience
- Mutex-serialized multi-byte angle read sequence
- Automatic recovery from bus failures (Poisoned -> Normal)
- No magnet validation at probe time (deferred to read_raw)

Tested on BeagleBone Black (AM335x) with AS5600 on i2c-2 (0x36).

Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 drivers/iio/position/as5600.rs | 289 +++++++++++++++++++++++++++++++++
 1 file changed, 289 insertions(+)
 create mode 100644 drivers/iio/position/as5600.rs

diff --git a/drivers/iio/position/as5600.rs b/drivers/iio/position/as5600.rs
new file mode 100644
index 000000000000..f87df650a91d
--- /dev/null
+++ b/drivers/iio/position/as5600.rs
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2026 Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
+//! Driver for ams AS5600 12-bit magnetic rotary position sensor.
+//!
+//! Datasheet: https://ams.com/documents/20143/36005/AS5600_DS000365_5-00.pdf
+
+use kernel::{
+    alloc::KBox,
+    bindings::{
+        i2c_client,
+        iio_chan_info_enum_IIO_CHAN_INFO_RAW,
+        iio_chan_info_enum_IIO_CHAN_INFO_SCALE,
+        iio_chan_spec,
+        iio_chan_type_IIO_ANGL,
+        ENODATA, //
+    },
+    bits::bit_u8,
+    device::Core,
+    error::{code::EIO, Error},
+    i2c::{
+        DeviceId,
+        Driver,
+        I2cClient,
+        IdTable, //
+    },
+    i2c_device_table,
+    iio::{
+        Device,
+        IioDriver,
+        IioVal,
+        Registered, //
+    },
+    io::{Io, IoCapable},
+    module_i2c_driver, of, of_device_table,
+    prelude::*,
+    sync::{
+        new_mutex,
+        Mutex, //
+    },
+};
+
+const AS5600_REG_STATUS: u8 = 0x0B;
+const AS5600_REG_RAW_ANGLE_H: u8 = 0x0C;
+const AS5600_REG_RAW_ANGLE_L: u8 = 0x0D;
+
+const AS5600_STATUS_MD: u8 = bit_u8(5);
+
+/// Returns kernel error `ENODATA`.
+///
+/// Helper needed because `Error::from_errno` is not `const fn` and `ENODATA`
+/// is only available as a raw `u32` binding, not as a wrapped `kernel::error::code`.
+#[inline(always)]
+fn err_enodata() -> Error {
+    Error::from_errno(-(ENODATA as i32))
+}
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
+#[derive(Clone, Copy)]
+struct As5600Io(*mut i2c_client);
+
+/// Tracks the health state of the hardware bus to prevent I/O storms.
+#[derive(Clone, Copy, PartialEq, Eq)]
+enum DeviceState {
+    Normal,
+    Poisoned,
+}
+
+// SAFETY: `As5600Io` wraps a raw pointer to `i2c_client`. This is `Send`
+// and `Sync` because:
+// - The I2C subsystem guarantees the `i2c_client` (parent) outlives the
+//   IIO device (child) via the Linux Device Model unbind ordering.
+// - All hardware access is serialized through `Mutex<As5600HwState<As5600Io>>`
+//   (`io_lock`), and individual SMBus transactions are serialized by the I2C
+//   adapter lock.
+unsafe impl Send for As5600Io {}
+unsafe impl Sync for As5600Io {}
+
+impl IoCapable<u8> for As5600Io {}
+impl IoCapable<u16> for As5600Io {}
+
+impl Io for As5600Io {
+    #[inline]
+    fn addr(&self) -> usize {
+        0
+    }
+
+    #[inline]
+    fn maxsize(&self) -> usize {
+        256
+    }
+
+    #[inline]
+    fn try_read8(&self, offset: usize) -> Result<u8>
+    where
+        Self: IoCapable<u8>,
+    {
+        // SAFETY: `self.0` points to a valid `i2c_client` guaranteed by the
+        // Device Model lifetime hierarchy (parent outlives child). The cast is
+        // valid because `I2cClient` is `#[repr(transparent)]` over `i2c_client`.
+        let client = unsafe { &*(self.0 as *const I2cClient<Core>) };
+        client.try_read8(offset)
+    }
+
+    #[inline]
+    fn try_read16(&self, offset: usize) -> Result<u16>
+    where
+        Self: IoCapable<u16>,
+    {
+        // SAFETY: `self.0` points to a valid `i2c_client` guaranteed by the
+        // Device Model lifetime hierarchy (parent outlives child). The cast is
+        // valid because `I2cClient` is `#[repr(transparent)]` over `i2c_client`.
+        let client = unsafe { &*(self.0 as *const I2cClient<Core>) };
+        client.try_read16(offset)
+    }
+}
+
+#[pin_data]
+struct As5600Priv<T> {
+    #[pin]
+    io_lock: Mutex<As5600HwState<T>>,
+    channels: KBox<[iio_chan_spec; 1]>,
+}
+
+/// Encapsulates the I/O interface and its runtime health state.
+///
+/// This prevents operations on a known-dead bus (Circuit Breaker pattern).
+struct As5600HwState<T> {
+    io: T,
+    state: DeviceState,
+}
+
+impl<T: Io + IoCapable<u8>> As5600HwState<T> {
+    /// Performs a dummy read to probe bus health after an I/O failure.
+    ///
+    /// Returns `EIO` in all cases — the caller should always propagate the error.
+    /// The side effect determines recovery behavior:
+    /// - If the dummy read **succeeds**: state is reset to `Normal`, meaning the
+    ///   next `read_raw` call will attempt normal operation directly.
+    /// - If the dummy read **fails**: state is set to `Poisoned`, meaning the
+    ///   next `read_raw` call will attempt recovery before normal operation.
+    fn handle_io_error(&mut self) -> Error {
+        match self.io.try_read8(AS5600_REG_STATUS as usize) {
+            Ok(_) => {
+                self.state = DeviceState::Normal;
+                EIO
+            }
+            Err(_) => {
+                self.state = DeviceState::Poisoned;
+                EIO
+            }
+        }
+    }
+}
+
+// SAFETY: `As5600Priv<T>` is `Send` and `Sync` because:
+// - `T: IoCapable<u8>` is a marker trait with no interior mutability.
+//   The underlying `As5600Io` wrapper's Send/Sync is guaranteed by its
+//   manual impls (serialized via Mutex + I2C adapter lock).
+// - `channels` is a heap-allocated array (`KBox`) with no interior mutability.
+// - `io_lock: Mutex<As5600HwState<T>>` provides synchronized interior mutability.
+// - `DeviceState` is a plain enum without interior mutability (Send + Sync
+//   implicitly).
+// All concurrent access to hardware goes through the `Mutex` guard.
+// The `Unpin` bound is strictly required because `kernel::sync::lock::Guard`
+// only implements `DerefMut` for `T: Unpin`. Without it, state mutation fails.
+unsafe impl<T: IoCapable<u8> + Unpin> Send for As5600Priv<T> {}
+unsafe impl<T: IoCapable<u8> + Unpin> Sync for As5600Priv<T> {}
+
+impl<T: Io + IoCapable<u8> + Unpin> IioDriver for As5600Priv<T> {
+    fn read_raw(&self, _chan: *const iio_chan_spec, mask: isize) -> Result<IioVal> {
+        match mask {
+            // IIO_CHAN_INFO_RAW — read the 12-bit raw angle value.
+            m if m == iio_chan_info_enum_IIO_CHAN_INFO_RAW as isize => {
+                let mut hw_guard = self.io_lock.lock();
+
+                // If the bus was previously poisoned, attempt a single recovery
+                // read before proceeding with normal operation.
+                let status = if hw_guard.state == DeviceState::Poisoned {
+                    match hw_guard.io.try_read8(AS5600_REG_STATUS as usize) {
+                        Ok(s) => {
+                            hw_guard.state = DeviceState::Normal;
+                            s
+                        }
+                        Err(_) => return Err(EIO),
+                    }
+                } else {
+                    match hw_guard.io.try_read8(AS5600_REG_STATUS as usize) {
+                        Ok(s) => s,
+                        Err(_) => return Err(hw_guard.handle_io_error()),
+                    }
+                };
+
+                // Check magnet presence (MD bit). Without a magnet the angle
+                // register contains stale/invalid data.
+                if (status & AS5600_STATUS_MD) == 0 {
+                    return Err(err_enodata());
+                }
+
+                // Read the 12-bit angle as two bytes. The AS5600 hardware
+                // freezes the internal angle value on reading the high byte
+                // until the low byte is read — the Mutex ensures this
+                // sequence is not interleaved by concurrent readers.
+                let angle_h = match hw_guard.io.try_read8(AS5600_REG_RAW_ANGLE_H as usize) {
+                    Ok(v) => v as u16,
+                    Err(_) => return Err(hw_guard.handle_io_error()),
+                };
+                let angle_l = match hw_guard.io.try_read8(AS5600_REG_RAW_ANGLE_L as usize) {
+                    Ok(v) => v as u16,
+                    Err(_) => return Err(hw_guard.handle_io_error()),
+                };
+
+                let angle = (angle_h << 8 | angle_l) & 0x0FFF;
+                Ok(IioVal::Int(angle as i32))
+            }
+            // IIO_CHAN_INFO_SCALE — radians per LSB: 2π / 4096 ≈ 0.001533981.
+            m if m == iio_chan_info_enum_IIO_CHAN_INFO_SCALE as isize => {
+                Ok(IioVal::IntPlusNano(0, 1533981))
+            }
+            _ => Err(kernel::error::code::EINVAL),
+        }
+    }
+
+    fn channels(&self) -> &[iio_chan_spec] {
+        &self.channels[..]
+    }
+}
+
+struct As5600 {
+    _iio_dev: Device<As5600Priv<As5600Io>, Registered>,
+}
+
+impl Driver for As5600 {
+    type IdInfo = ();
+    const I2C_ID_TABLE: Option<IdTable<Self::IdInfo>> = Some(&I2C_TABLE);
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+
+    #[allow(refining_impl_trait)]
+    fn probe(dev: &I2cClient<Core>, _id_info: Option<&Self::IdInfo>) -> Result<Self> {
+        // SAFETY: `iio_chan_spec` is a C struct whose fields are all integers
+        // and pointers. Zero is a valid initialization for all of them.
+        let mut channels_alloc = kernel::alloc::KBox::new(
+            [unsafe { core::mem::zeroed::<iio_chan_spec>() }],
+            kernel::alloc::flags::GFP_KERNEL,
+        )?;
+
+        channels_alloc[0].info_mask_separate = (1 << iio_chan_info_enum_IIO_CHAN_INFO_RAW)
+            | (1 << iio_chan_info_enum_IIO_CHAN_INFO_SCALE);
+        channels_alloc[0].type_ = iio_chan_type_IIO_ANGL;
+
+        let client_ptr = dev as *const _ as *mut i2c_client;
+
+        let priv_init = pin_init!(As5600Priv {
+            io_lock <- new_mutex!(As5600HwState {
+                io: As5600Io(client_ptr),
+                state: DeviceState::Normal,
+            }),
+            channels: channels_alloc,
+        });
+
+        let iio_dev = Device::build_device(dev.as_ref(), c"as5600", priv_init)?;
+        let iio_dev_registered = iio_dev.register(&crate::THIS_MODULE)?;
+
+        dev_info!(dev.as_ref(), "AS5600 magnetic position sensor ready\n");
+        Ok(As5600 {
+            _iio_dev: iio_dev_registered,
+        })
+    }
+}
-- 
2.50.0

