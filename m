Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239891;
	b=3QzPTJwH/uJX15S1oa9Bl/pij9ZKz+nXLJMwpgtg9Cqwonym34hhGktmTy3QPc5wpE16
	 oVDZyXpgk9r4LZTZ4Si2cecVQpuTh7VYP4V07mJx6ssBKEXI0MkLFJ/g1+CQg73C764fF
	 AROea6KVoGsLPLKpf/3ATvTtjOu0t64X+GGPdAzgoPpVPP7isvvdNNapi+svvbNTILE5M
	 BXrrWDKDEzYB32HcH4Xi6VGwtlxNG03JKRELy8ak/H292LtHWV96yHobP2HUkjWvhYyAh
	 AW1bPpbxRWc3DRI+ju5tQeWCqdNKKh6x/JCzhZiGIXb/4pYhY9o6p3/KCSOH2ZCQ6mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=A0e3aWt9/XeLQ8ZaY9RAcjDuS8LnExeE5CFr2AzDlxc=;
	b=z9B22xaC7hlDjPwo4JWfHhhUXu5jYoumRgZ+DmrOpfZsat3vHz+MDAllCCZuwSGyROw6
	 bbGNWMdZ1ugmQLERdDV6ISWDYVvXBi7ilzYSstktp7/SoFBPlQmI9FeNeGkzIcHREwDY7
	 a1UoBHE1YOoYuTQN7tbP5WSXPuW/pfm8K2o8JI7Xu1g+LWdawh91n6z1ibSFqNcMFx1+/
	 Jzot1EUQ4ngRWG32c/HfJR4OH3bfu2DXYWUFFpH4bX0Qd0zevXNatky6p1mL13uyuXxuY
	 cIlZ5FTvSbTS2OBCG6fS60t5Rl14NEqG/bccfOefpKfxR+o7rOdFkRO1+YW8ThDopwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aTNUlqrV;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A51C606EEA0
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 15:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A51C606EEA0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aTNUlqrV
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-14394530ec6so1455340c88.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 07:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239890; x=1794844690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A0e3aWt9/XeLQ8ZaY9RAcjDuS8LnExeE5CFr2AzDlxc=;
        b=aTNUlqrV4kxyktRy1aGltCk/fDtLtBSW6UXitr6C55os6pTdictNoH4KcfCNgu7PLh
         LagRnFbd80YT07n/J/tguTuaEy0rNPnc+7etwOoe/VSPC6G6JnXNUO3u1nihPyQ0NPYr
         Hdi8xkP8eHEOEJyC+Cq/+FQ3AcSb+9IOqvar/dVvHcC0WQD6khIUpq6OMSQ9IxwYG5b0
         9aJ7gbCrLV+gvu6kO3L9rOZOHWvSeDT5Dq/gu7v+aMpSPu5nQjG0n6pEXhMv87p3UY3a
         wFqbiemYEPH4CmWL8JTwjzCMFLQiwmQ4llXHxzLyxexCmlsEnmFTx8m16Pc8Fkg9dk8y
         1f4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239890; x=1794844690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A0e3aWt9/XeLQ8ZaY9RAcjDuS8LnExeE5CFr2AzDlxc=;
        b=cuxamfr1YXj/fET3a7zoIZsfhyTe65QdD74b/QA3HcrSR5z/aIyLbPNn83kwEPJbVw
         bDbIdPWOtXEPrJRih89zirtiOOIaMKmGf93CoFlD5unHeCQFDhwTnwqbWGlSUF0GH60n
         crlCMUmjiege67Ip1U9ePXs/sYBK71qxAIbmA6T2fpVD+Da9n/uwMNbzNdxrecIIKmPR
         Y1JBq7UOd7lDJWVHwI4zpOZtt1NJcxx0jmv8IrLgFKvac5ixqA2I+3hCSnNf9jQT7XJl
         Pcw7oz98vCDsCf0qCnwcutkrM1YS6r9RXtftnmeSCrYO8bFaUgMbzyLVca00ERC+TyyV
         u9Eg==
X-Forwarded-Encrypted: i=1; AL+hErEi88yNuOkT5ig0UIFnKQ7WIJEQrzPWazmuTG/XSj1Fr6/S7HwLDlX2jmiHhM0EzBJaKA4cJPGPEXg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2DtamslpXoq+opjoUU8odQ4bKDnSqeVfNW54bOKnQxBu6CG+t
	67Z3ZfTiH9VinEi0H8aQuOY8rNAkNfUuiwWUvuMFmtfZC4n4zmU3SLzF
X-Gm-Gg: AYBFou3BQUOKcL+p/rp709oxdIPRceXy/+esB06pljRROfzwRa7hen7fhy3R4tIFkxZ
	aq/oqbFyRhqFWlejoTGW2Abr06zDeB4/Nxw0NtxAlWJXXaWLE0XmChEux4Q+qrG0ymXQjCup7lb
	+X5GBkfyz/nZ4UorCD35UP+P6b0clymmIvymtFD6JzOv34Zo29hsHuZP4dOCd1RWGPSt0eqnay7
	ueTPkoB14pmT28gCYDMwnZjFgv+/R0GLN49q4OCWPM5cbqOiNIrVjV3By5DvQuZwBWGZ2lpU11l
	x6tZ9gbP89wUJ86v5dLWqy1ZSmW4b5xf1+EuE9T2jH8Dq7rHg7Tz7Hw999myOFEUUB4jlymeNyS
	Xs37pXxGD16b34eatw367+PD5RMrQlVJaTwDsHC+EF7/S8f9KO6BXw7A+FXu6hzA4KBtQ1vXv1o
	dGRd06pcr9zbeWu6uKWBRWP8SzOyO4vlMUUIvlKm/aiU0Pd/tkptF+FQU0FcopypDPa5bjWFLer
	o7cGgidh7RgvbpVSRZ1Tf9C49S4W1s4jQkXMOJHnUvfHmuJevJL9Gjbi0QotKQtnn8K6TLqoHVt
	YIYCdlFohBbdEKuUDpOljXb2fbIEwhKHo5lEzNNfQn0kLjSGs5o1cp9YTo43W07q6NIym+Y=
X-Received: by 2002:a05:701b:221a:b0:1a0:e3e2:22a3 with SMTP id a92af1059eb24-1b39feef1fbmr6370365c88.31.1794239889337;
        Mon, 09 Nov 2026 07:58:09 -0800 (PST)
Received: from localhost.localdomain ([125.166.179.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3757214cbsm13020828c88.13.2026.11.09.07.58.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 07:58:08 -0800 (PST)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	Danilo Krummrich <dakr@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Shuai Liu <847807867@qq.com>,
	linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v7 4/4] iio: position: add Rust driver for ams AS5600
Date: Mon,  9 Nov 2026 22:57:43 +0700
Message-ID: <20261109155743.83740-5-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20261109155743.83740-1-muchamadcoirulanwar@gmail.com>
References: <20261109155743.83740-1-muchamadcoirulanwar@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Rust driver for the ams AS5600 12-bit magnetic rotary position
sensor.

Expose the raw angle and scale through the IIO sysfs interface in direct
mode. Read the status register before each angle sample and return
ENODATA when the magnet-detected bit is clear. Serialize the status and
angle transaction sequence with a mutex and propagate I2C transport
errors directly to userspace.

Capture a bound I2C client reference during probe and store it in the
IIO private data. The registered IIO device carries the same bound
lifetime, keeping the client valid throughout read_raw callbacks.

The AS5600 stores the raw angle with the high byte at register 0x0c.
Use the byte-swapped SMBus word helper and mask the result to 12 bits.

Add usize bit and mask helpers for constructing the IIO channel
information mask.

The registered-device ownership and stored bound-client reference are
based on Igor Korotin's rework.
Link: https://lore.kernel.org/all/179286358623.55649.5397316745104390556@linux.dev/

Suggested-by: Shuai Liu <847807867@qq.com>
Link: https://lore.kernel.org/all/tencent_173B7731E90B9624F9F82613DC3031B70907@qq.com/
Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 drivers/iio/position/Kconfig   |  11 ++
 drivers/iio/position/Makefile  |   1 +
 drivers/iio/position/as5600.rs | 186 +++++++++++++++++++++++++++++++++
 rust/kernel/bits.rs            |  29 +++++
 4 files changed, 227 insertions(+)
 create mode 100644 drivers/iio/position/as5600.rs

diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
index 1576a6380b53..7c278f82f53d 100644
--- a/drivers/iio/position/Kconfig
+++ b/drivers/iio/position/Kconfig
@@ -6,6 +6,17 @@
 
 menu "Linear and angular position sensors"
 
+config AS5600
+	tristate "ams AS5600 magnetic rotary position sensor"
+	depends on IIO=y && I2C=y && RUST
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
index 000000000000..d5716501d48d
--- /dev/null
+++ b/drivers/iio/position/as5600.rs
@@ -0,0 +1,186 @@
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
+        IioVal,
+        Registered, //
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
+    <As5600 as Driver>::IdInfo,
+    [(DeviceId::new(c"as5600"), ())]
+);
+
+of_device_table!(
+    OF_TABLE,
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
+struct As5600Priv<'a> {
+    client: &'a I2cClient<Bound>,
+    #[pin]
+    io_lock: Mutex<()>,
+}
+
+// SAFETY: I2C core serializes transfers, and the bound client remains valid
+// for the lifetime of the registered device and its callbacks.
+unsafe impl Send for As5600Priv<'_> {}
+// SAFETY: I2C core serializes transfers through the shared bound client.
+unsafe impl Sync for As5600Priv<'_> {}
+
+// SAFETY: AS5600_CHANNELS contains one valid, immutable IIO_ANGL channel
+// exposing only RAW and SCALE. It has no event or extension callbacks,
+// and all optional pointer fields are null.
+unsafe impl IioDriver for As5600Priv<'_> {
+    fn read_raw(&self, _chan: *const iio_chan_spec, info: IioChanInfo) -> Result<IioVal> {
+        match info {
+            IioChanInfo::Raw => {
+                let _guard = self.io_lock.lock();
+                let client = self.client;
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
+                Ok(IioVal::Int(i32::from(angle)))
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
+struct As5600;
+
+#[pin_data]
+struct As5600Data<'bound> {
+    #[pin]
+    _iio_dev: Device<As5600Priv<'bound>, Registered>,
+}
+
+impl Driver for As5600 {
+    type IdInfo = ();
+    type Data<'bound> = As5600Data<'bound>;
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
+        try_pin_init!(As5600Data {
+            _iio_dev: {
+                // Deref coercion: I2cClient<Core<'_>> -> I2cClient<Bound>.
+                let client: &'bound I2cClient<Bound> = dev;
+
+                let priv_init = pin_init!(As5600Priv {
+                    client,
+                    io_lock <- new_mutex!(()),
+                });
+
+                let unregistered =
+                    Device::build_device(dev.as_ref(), c"as5600", INDIO_DIRECT_MODE, priv_init)?;
+
+                unregistered.register(kernel::module::this_module::<crate::LocalModule>())?
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
