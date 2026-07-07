Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35B83EFD3D
	for <linux-iio@vger.kernel.org>; Tue,  7 Jul 2026 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437472; cv=none; b=KWIJcIr9K2iG7OiJEFhVeOjX5vcHgg1NSpByTX2n5yyzNkFFcb2O8QXY9ZpNMDGKjBNT1PT549HtX/tH8Eb6iHcEBboXGIGIQHG6VP8WxDTAt5fjeRksI7AHEIBkVbJTHrlg8HZfkaR5dlRHjOiWl41KFOoa+m4SplCIa2bzMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437472; c=relaxed/simple;
	bh=7oQefJ0ulRQ3S0RvYANI5C/ft8yNRikNyd0MmgFG930=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwZaSTNqolJVyMOuJht0pKrFQ7VJ2akNbhOWtE7iwMqMLqZuY7qUx+7hovaoPETOYOwhXcdU2bHN/8IjkpnmRuua1uQLI8S5KTcIsB65i6bUJMv0Od2UElTPV2bGehoCfw88zPlndsPagRyUm7pPZKJGI7k0tQdmNFnWgTHnxJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imELo3gt; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imELo3gt"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-847a69ba83dso3467591b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Jul 2026 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783437470; x=1784042270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liHI0+CrwsSas0MnF/7DvCYOlTgIsB2dmJi+jwKZ64o=;
        b=imELo3gtjTmAfW5j3dGecXSwdZgopQdTnbtXcPHsBTVsoXSaes0oiDOx4N9jOLOveg
         h7LKg+NTtHGXhWLTovHu7xcCVreJE2HFC40wUg4pD5sT41a6oL2LpWRzWkOOI29V0Mlk
         t+eeW/yG0eqmH0Lio0JWh7RzBoD0kZY6O4IOZ8axzIuD0OLr+PJre4xEnvSXh8GvHWmp
         I0Y3z/ZcSjiFFx55Lrqll3h91JsdzDcxKV6gywC6qKJX3FEfPlbN49ISf5mxWAA4ex3D
         ybh8PEhXvzMjzsE+MOKGrGNbwHrDK6DUUf4oIJQqwOJlnfInYH/Abk9l8MML/AbxRGix
         SjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437470; x=1784042270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=liHI0+CrwsSas0MnF/7DvCYOlTgIsB2dmJi+jwKZ64o=;
        b=JOvWzfi59PgIIzgIdTixTpNCR5+y/6ahIxfUMoDXqg3tB9Z2YBJTz3yr5oOlPhnjrz
         tO6VmBcZ8cP6ojS3Egvj+6bylwLh3ZkmLpawy7gS+vS4K/tZ8BpnSMWkS7FYoF0zmKhV
         8E7BXB7pS37ZA9CAzxenpTTlYaxY3XZGxVhoStBsHPmvALRe34418h/KftAI+0zXGvWa
         vmLxrwIfdSBe5CZMV6dp/9qqA7yvyjNFyVNczWOgATSLCDvNutxTONzWL9a4dhEg/iKE
         ysgBZlK0N9VQiNWRmF4XCmEF4eKjmefFhsHKBfW/ZUjgesnovv4xVnk6oZB9G5zQEIkn
         dYWQ==
X-Gm-Message-State: AOJu0Yw6DJcYAV/VSPksuCgeUssB99+hzegfBCmKhFKy+hrJHjuIWH4z
	ys+yuRJjM33hLL57PMa+j0HQAlyKk51nkYnWrdBxSuihMVoojp96SNYp
X-Gm-Gg: AfdE7ckm6SX4ahEGFXyiPelo7BXamhLMkpCVTLiksUJopCpXcFWeOCfpLzJSlqxPSt3
	Z7+5qYS1vD4iQQhgDUjI/xWaDgEvsCwG/jFvlmppIm9LGFQ/yXydL4IkKpjSSHxTTHv5/az8fx2
	6vNLWplAVJOElTcsX41ci6ptt5C1bazwhOYRg33nSn6o7lf3fGQmjcETjnrpchZ5aQw9jNII/if
	ZJfNberrgszv63FXNlveIjoFJBfq3UcUJenJnKFh44dGP8Vg2r4fIhTVHmIs7KoHGv9lh7EHfT3
	Gd8DnsGDITt3W2ZepYLifg+8jzw4IQF5//3MxaC4qQZU2REwyme/53TBMxE5MSs+gTo4Px76557
	kSVwpwP6A03DmyRfozWivpt0ShrNkXAdPWd5vXxXWn44fpa26tKYffeIp04IbjqoUDXSKBF7oKS
	BqIMUoKjeXoB9HkD41mnAlPYMDsgvlvt6UkDHmgEt0K7iRpbnh2sRRa1dHvX5TlViEHnfF04+5l
	sFi
X-Received: by 2002:a05:6a00:1bc7:b0:847:980b:f299 with SMTP id d2e1a72fcca58-84826bb460bmr5573283b3a.4.1783437469993;
        Tue, 07 Jul 2026 08:17:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:448a:2003:63bf:6d1c:a790:1205:96eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4e741sm5724397b3a.28.2026.07.07.08.17.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 08:17:49 -0700 (PDT)
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
Subject: [RFC PATCH v4 3/3] iio: position: add Rust driver for ams AS5600
Date: Tue,  7 Jul 2026 22:15:42 +0700
Message-ID: <20260707151542.91997-4-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Rust driver for the ams AS5600 12-bit magnetic rotary position
sensor. The driver exposes in_angl_raw and in_angl_scale via the IIO
sysfs interface.

Features:
- ARef<I2cClient> for safe refcounted I2C client access
- Mutex-serialized status + angle read sequence
- Static channel spec (module-level const)
- No magnet validation at probe (deferred to read_raw per IIO convention)
- Error propagation via ? operator (no recovery state machine)

The byte order for the AS5600's big-endian registers is handled via
swap_bytes() in-driver. This is equivalent to C's
i2c_smbus_read_word_swapped(). The long-term solution is regmap-rs
where endianness is configured once at the transport level.

Tested on BeagleBone Black (AM335x) with AS5600 on i2c-2 (0x36).

Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 drivers/iio/position/Kconfig   |  14 +++
 drivers/iio/position/Makefile  |   1 +
 drivers/iio/position/as5600.rs | 181 +++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)
 create mode 100644 drivers/iio/position/as5600.rs

diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
index 1576a6380b53..573d241676bf 100644
--- a/drivers/iio/position/Kconfig
+++ b/drivers/iio/position/Kconfig
@@ -6,6 +6,20 @@
 
 menu "Linear and angular position sensors"
 
+config AS5600
+	tristate "ams AS5600 magnetic rotary position sensor"
+	depends on I2C && IIO && RUST
+	help
+	  Say Y here to build support for the ams AS5600 12-bit
+	  magnetic rotary position sensor with IIO channel support
+	  (in_angl_raw and in_angl_scale).
+
+	  This is a Rust driver that exposes the 12-bit raw angle
+	  and radian scale via the IIO subsystem.
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
index 000000000000..7445398c86b9
--- /dev/null
+++ b/drivers/iio/position/as5600.rs
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2026 Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
+//! Driver for ams AS5600 12-bit magnetic rotary position sensor.
+//!
+//! Datasheet: https://look.ams-osram.com/m/7059eac7531a86fd/original/AS5600-DS000365.pdf
+
+use kernel::{
+    bindings::{
+        iio_chan_info_enum_IIO_CHAN_INFO_RAW,
+        iio_chan_info_enum_IIO_CHAN_INFO_SCALE,
+        iio_chan_spec,
+        iio_chan_type_IIO_ANGL, //
+    },
+    bits::{
+        bit_u8,
+        genmask_u16, //
+    },
+    device::Core,
+    error::code::{
+        EINVAL,
+        ENODATA, //
+    },
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
+    io::Io,
+    module_i2c_driver,
+    of,
+    of_device_table,
+    prelude::*, //
+    sync::{
+        aref::ARef,
+        new_mutex,
+        Mutex, //
+    },
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
+// SAFETY: `iio_chan_spec` is a plain C struct (all fields are integers/pointers)
+// with no interior mutability. The static is only read after initialization,
+// making shared access safe.
+unsafe impl Sync for As5600Channels {}
+
+static AS5600_CHANNELS: As5600Channels = As5600Channels({
+    // SAFETY: `iio_chan_spec` is a repr(C) struct where all-zeroes is valid
+    // (integers default to 0, pointers to NULL).
+    let mut chan: iio_chan_spec = unsafe { core::mem::zeroed() };
+    chan.type_ = iio_chan_type_IIO_ANGL;
+    // TODO: Use kernel::bits equivalent once bit_usize exists
+    chan.info_mask_separate = (1usize << iio_chan_info_enum_IIO_CHAN_INFO_RAW)
+        | (1usize << iio_chan_info_enum_IIO_CHAN_INFO_SCALE);
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
+    client: ARef<I2cClient>,
+}
+
+impl IioDriver for As5600Priv {
+    fn read_raw(&self, _chan: *const iio_chan_spec, mask: isize) -> Result<IioVal> {
+        const INFO_RAW: isize = iio_chan_info_enum_IIO_CHAN_INFO_RAW as isize;
+        const INFO_SCALE: isize = iio_chan_info_enum_IIO_CHAN_INFO_SCALE as isize;
+        match mask {
+            // IIO_CHAN_INFO_RAW: read the 12-bit raw angle value.
+            INFO_RAW => {
+                let hw = self.io_lock.lock();
+
+                // Read status register to verify magnet presence before
+                // reading the angle.
+                let status = hw.client.try_read8(AS5600_REG_STATUS as usize)?;
+
+                // Check magnet presence (MD bit). Without a magnet the angle
+                // register contains stale/invalid data.
+                if (status & AS5600_STATUS_MD) == 0 {
+                    return Err(ENODATA);
+                }
+
+                // Word read at register 0x0C: SMBus read_word_data returns LE,
+                // AS5600 stores angle big-endian, so swap_bytes() is needed.
+                // Mutex ensures status + angle read is atomic.
+                // NOTE: Equivalent to C's i2c_smbus_read_word_swapped().
+                // Long-term, regmap-rs with val_format_endian=Big handles
+                // this transparently at configuration level.
+                let raw = hw.client.try_read16(AS5600_REG_RAW_ANGLE_H as usize)?;
+                let angle = raw.swap_bytes() & AS5600_RAW_ANGLE_MASK;
+                Ok(IioVal::Int(angle as i32))
+            }
+            // IIO_CHAN_INFO_SCALE: radians per LSB, 2*pi / 4096 = 0.001533981.
+            INFO_SCALE => {
+                Ok(IioVal::IntPlusNano(0, 1533981))
+            }
+            _ => Err(EINVAL),
+        }
+    }
+
+    fn channels(&self) -> &[iio_chan_spec] {
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
+    #[allow(refining_impl_trait)]
+    fn probe<'bound>(
+        dev: &'bound I2cClient<Core<'_>>,
+        _id_info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        try_pin_init!(As5600 {
+            _iio_dev: {
+                let client: ARef<I2cClient> = dev.into();
+
+                let priv_init = pin_init!(As5600Priv {
+                    io_lock <- new_mutex!(As5600HwState {
+                       client
+                    }),
+                });
+
+                let iio_dev = Device::build_device(dev.as_ref(), c"as5600", priv_init)?;
+                let registered = iio_dev.register(&crate::THIS_MODULE)?;
+                dev_dbg!(dev.as_ref(), "AS5600 magnetic position sensor ready\n");
+                registered
+            }
+        })
+    }
+}
-- 
2.50.0

