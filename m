Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8503A175A99
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165738; cv=none; b=FCinbnMCNX2IxI3gqkLCs6QA56qQmpu31T0pygJIHcean8m5Bj2Qb1/U4cnMBk4PU4dNvbeI/1y1sgTD/0OIG7hKtl+VppvEPnX8PhSLYWGpd8GIZs3mtUUjToucqAEF4u4HnOMkuS7QGPKiAju2zCXCenyjCcpxQELIfvwpDj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165738; c=relaxed/simple;
	bh=ZOpuVxu/kULGJ+VOcTuckG//XM6UeL0Np1mFx6ntkGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZ3EuG3rYlhvBCl16ai0N0b/jJcgv7odcaYfirw83oKVIc2Mb8zfWvZOWHs0qDICoUvRm0bsEyippGzFgn6540AUW67qGqdkU1Nwf14xesMq1TQt3xme6YGPrOCLIFEofhacE0pxsloKt/KG+ODnrum479YUb1wwNI0vqrO/cFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuJJH64B; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuJJH64B"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b0d63f60bcso448457b3.3
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792165731; x=1792770531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yXO8Pfx1V/MvWfozdYJmpTkdBIQMuHsAurvABJvdB4c=;
        b=EuJJH64BceXP6y609JH8ti5wepSr6Gd9YlUOCFbn3ZDBJM0cqNReWAbyshtpaCMx1W
         Bk4fcLEDuTZ+8RsnUMnG38fJx8fo5E7Zaj5c8aeL+t2LbytDZp8+vf5cqKCut1nvQ+Kn
         eXzOD8EooSUnucW+eaDCFhbWuDcKpURo1glsyf1o7W7Cj7uxFk7FYHY+2/zUefstpRB/
         bn5PIgHoHpeP408fX7g9RpnBaa0X9vt7m1w7cYUGLijSGd4n8OFW3wyXuoOBUBZuj2gp
         GC2mj5sY4TQUqF6dcw/iCqY5GRuZwqQIFIQQMd8hMlujS3sHebCS2yw+if/IuVCRoIqo
         Ejig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792165731; x=1792770531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yXO8Pfx1V/MvWfozdYJmpTkdBIQMuHsAurvABJvdB4c=;
        b=EgfpnLN8xpcW7/E+mISvsUgRjEarHrLWG9TXZ2EI90Vt5MRZJoHpEUQpY5j6g7B5Mk
         0hw0a8GY6fMaT1t+djer47+WXPZN+VyQrsNwhia37IbsDcnEUHGG3G/17OnOWVt6fqxI
         vq7MOseAC7NllSyaMlJoO5cjvPm2d4EoxC4Zmq2neG+g8zhBpKxdwCkPKr4QXMk/zQjZ
         kPRtLxnYZ9aAAnvrxVcyVN6wAu36tHLWSExK8W6VvtW5yVy5Mp6+xV14hhxH8YPrvzzs
         RmUDv1FU+3H+X+V9gFN89olHDqiuJnQ9DpXjdxeyPuZp7BfAafQgvDkPiOxSvaBcHQwv
         n6uw==
X-Forwarded-Encrypted: i=1; AKwUvBzeGAyqASpRZ36naJMtP2Pj0GWaAcmcu7xrDXokOPHfeLz/rSkAkf4HrfDCTH+fWyCmDQ2OqHa49y8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBTgPmtn8r+bagCNkOQ/5QaBs2mFJhnv33tP7gSft868YCVbFu
	3XMLDm1cw6IMQ8GwsMGQHkvjj1XMKuxuC52SLciEAhjcZLifpyELF+UM
X-Gm-Gg: AYBFou2jB3h7AdMEIIkFKjfIkjbk+kuh5r4fEgGv+nyYs8aYsFNALfxLTqCzaCE9PhH
	cDm9NBwAcpocEXYJMXf4hzeACB4+5owlTZ6E2hYj6ASDZHCL0xlMQ3XsxrOU9rL4lPArxO5+Lih
	jldxvEzQU6oYCCIYVe9TI3n0F3+jICAUp9t3K9BSiRHWVFjZ0G3giVgxuK6UN54nq3IUDJZX3kA
	ugw1qH3woY/dHYPWpxXwu1g6Sg56GBxgkWnYe9CtsJdigBAyUOoXCg9eHswOyHNc/J1SBQiL3XQ
	L8S3zcftm3zN3zV8uQhsNR5yQ7GVgTXJcI4llLQNR5Yj2wq35Y5zlfxX4lgmrfXNKcRbrXUb1h+
	3HLu02bSP1UgVtxVovqFamfj7GKxBG934b3V9Ivoq/YcBEKMtw8vLYgDlQbNOJ6cLH76yGa7k/l
	zhLNeA+mteLXZoDEu/RnO8MRyXVjDUi7tLPbvq/M6DsxpkN8rfRSwg3pDghN2jEA5yhs6oomXau
	WvKk7AKdw78HIfpXvpJsWRy2VcZSLRn7dUeQUI=
X-Received: by 2002:a05:690c:89:b0:8b0:d75a:9cf8 with SMTP id 00721157ae682-8b0f21e08admr1721857b3.41.1792165731215;
        Fri, 16 Oct 2026 08:48:51 -0700 (PDT)
Received: from localhost.localdomain ([180.243.241.21])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e593c65bsm10882167b3.38.2026.10.16.08.48.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 08:48:50 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Mark Brown <broonie@kernel.org>,
	Brandon StJohn <branstj@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 4/4] iio: position: add Rust driver for ams AS5600
Date: Fri, 16 Oct 2026 22:48:19 +0700
Message-ID: <20261016154819.17936-5-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20261016154819.17936-1-muchamadcoirulanwar@gmail.com>
References: <20261016154819.17936-1-muchamadcoirulanwar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Rust driver for the ams AS5600 12-bit magnetic rotary position
sensor.

Expose the raw angle and scale through the IIO sysfs interface in direct
mode. Read the status register before each angle sample and return
ENODATA when the magnet-detected bit is clear. Serialize the status and
angle transaction sequence with a mutex and propagate I2C transport
errors directly to userspace.

The AS5600 stores the raw angle with the high byte at register 0x0c.
Use the byte-swapped SMBus word helper and mask the result to 12 bits.

Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 drivers/iio/position/Kconfig   |  11 ++
 drivers/iio/position/Makefile  |   1 +
 drivers/iio/position/as5600.rs | 177 +++++++++++++++++++++++++++++++++
 rust/kernel/bits.rs            |  29 ++++++
 4 files changed, 218 insertions(+)
 create mode 100644 drivers/iio/position/as5600.rs

diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
index 1576a6380b53..14ed4bef82e1 100644
--- a/drivers/iio/position/Kconfig
+++ b/drivers/iio/position/Kconfig
@@ -6,6 +6,17 @@
 
 menu "Linear and angular position sensors"
 
+config AS5600
+	tristate "ams AS5600 magnetic rotary position sensor"
+	depends on I2C=y && RUST
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
index 000000000000..b72775241e81
--- /dev/null
+++ b/drivers/iio/position/as5600.rs
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2026 Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
+//! Driver for ams AS5600 12-bit magnetic rotary position sensor.
+//!
+//! Exposes `in_angl_raw` and `in_angl_scale` through the IIO sysfs interface
+//! in `INDIO_DIRECT_MODE`.
+//!
+//! Datasheet: AS5600, document DS000365.
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
+        IioVal, //
+    },
+    io::Io,
+    module_i2c_driver,
+    of,
+    of_device_table,
+    prelude::*,
+    sync::{
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
+// NULL - set via `zeroed()` and never reassigned - so no shared mutable
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
+    io_lock: Mutex<()>,
+}
+
+// SAFETY: AS5600_CHANNELS contains one valid, immutable IIO_ANGL channel
+// exposing only RAW and SCALE. It has no event or extension callbacks,
+// and all optional pointer fields are null.
+unsafe impl IioDriver for As5600Priv {
+    fn read_raw(
+        &self,
+        parent: &kernel::device::Device<Bound>,
+        _chan: *const iio_chan_spec,
+        info: IioChanInfo,
+    ) -> Result<IioVal> {
+        match info {
+            IioChanInfo::Raw => {
+                let _guard = self.io_lock.lock();
+                let client: &I2cClient<Bound> = parent.try_into()?;
+
+                let io = client.smbus_io();
+                // Read status register to verify magnet presence before
+                // reading the angle.
+                let status = io.try_read8(AS5600_REG_STATUS as usize)?;
+
+                if (status & AS5600_STATUS_MD) == 0 {
+                    return Err(ENODATA);
+                }
+
+                // Word read at register 0x0C returns big-endian data.
+                // smbus_read_word_swapped() handles the byte swap.
+                let raw = client.smbus_read_word_swapped(AS5600_REG_RAW_ANGLE_H)?;
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
+    _registration: (),
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
+            _registration: {
+                let priv_init = pin_init!(As5600Priv {
+                    io_lock <- new_mutex!(()),
+                });
+
+                Device::build_device(dev.as_ref(), c"as5600", INDIO_DIRECT_MODE, priv_init)?
+                    .register(&crate::THIS_MODULE)?;
+                dev_dbg!(dev.as_ref(), "AS5600 magnetic position sensor ready\n");
+            }
+        })
+    }
+}
diff --git a/rust/kernel/bits.rs b/rust/kernel/bits.rs
index 2daead125626..a6537a668dd6 100644
--- a/rust/kernel/bits.rs
+++ b/rust/kernel/bits.rs
@@ -41,6 +41,7 @@ pub const fn [<bit_ $ty>](n: u32) -> $ty {
 impl_bit_fn!(u32);
 impl_bit_fn!(u16);
 impl_bit_fn!(u8);
+impl_bit_fn!(usize);
 
 macro_rules! impl_genmask_fn {
     (
@@ -203,3 +204,31 @@ pub const fn [<genmask_ $ty>](range: RangeInclusive<u32>) -> $ty {
     /// assert_eq!(genmask_u8(0..=7), u8::MAX);
     /// ```
 );
+
+impl_genmask_fn!(
+    usize,
+    /// # Examples
+    ///
+    /// ```
+    /// # #![expect(clippy::reversed_empty_ranges)]
+    /// # use kernel::bits::genmask_checked_usize;
+    /// assert_eq!(genmask_checked_usize(0..=0), Some(0b1));
+    /// assert_eq!(genmask_checked_usize(0..=3), Some(0b1111));
+    /// assert_eq!(genmask_checked_usize(1..=3), Some(0b1110));
+    ///
+    /// // `200` is out of the supported bit range on all platforms.
+    /// assert_eq!(genmask_checked_usize(0..=200), None);
+    ///
+    /// // Invalid range where the start is bigger than the end.
+    /// assert_eq!(genmask_checked_usize(5..=2), None);
+    /// ```
+    ,
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::bits::genmask_usize;
+    /// assert_eq!(genmask_usize(0..=0), 0b1);
+    /// assert_eq!(genmask_usize(0..=3), 0b1111);
+    /// assert_eq!(genmask_usize(1..=3), 0b1110);
+    /// ```
+);
-- 
2.50.0

