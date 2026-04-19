Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34402D839C
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776611619; cv=none; b=QE2lstBViDHTYa8Ia/0c7kAhuQ+VyPvxyqcmACR3qX0PM21IMvBeHD0nH4dhimKYmTjiGK9YU59xML03FZQc9RbLTla8hZSvn8uq3M88LUl3WLco1hX/x7J0O4cyc7Nu6djiKWQQkkxG+uIShCE/p2iWiGfqISFVqWyr4YsQg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776611619; c=relaxed/simple;
	bh=vDcIK+5js169U/jlxiXnZOwZX66iqRq/wHgzJ3IkbuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGR7Swa0YG6jvf3EKIGnaatlgIJ6CGA6zMLL2xKSgMX0cmm277XFKsShg3M4e3FGOkw6yMLY3ziKEw+pncGHHVxVQn3nNShsWLbHKnjzc/Ky7itYZA4H7jxwN144PsSQdQoQI0q05x08fvRq8Q/PtlmlfxMkOLC82YJUcIP6QXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MouLzqpU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MouLzqpU"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82d0b68837aso1349839b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776611617; x=1777216417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8fkjDIA2luV5mDODpq9a0VIYJU3zYUueNvtgaejrRgQ=;
        b=MouLzqpUvFJH28Dd30F15Pir5FXo2IPX8ie7hvIcKZaanuLxOMRo4Rmak4/diFmtPZ
         zLqWSeg8gzTplfIcnUeSpyHVIsQC+nnK+Rss6VJK1C1hrl/uuKIK57Z6pNai5xKG14dQ
         8b7N6P0OwA825FvD/L9C4GVGSYkW0Zpltlxr94tcjzBZ8/ef9Q6rvmFqU010djK2YEGT
         cLFSDueG6z0QyGzEB9A9UfzU0tb+moPHL6ZSO0IvbP5MP/xTbfwiwOpsNelz6uhDX4Xe
         AbRXiA/gSZK6l34E2DpKfBj8S8AN++QL3E4QQkzQXLWYjZlt8f3vEbrfxDQ9uqXzu5jD
         KbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776611617; x=1777216417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fkjDIA2luV5mDODpq9a0VIYJU3zYUueNvtgaejrRgQ=;
        b=ctfa40tyGc7gKN6OhfwcirNNFSCbolWSNgBANp6vkh8Ftk2zG+QkFSv5gnsSh7KhZH
         rI1dR0mdCHacyrOn2i5w/8JdXoHIuo6b+1pUIlP7S7odPfsFwJpT1COVa/WkEHg+ZLOY
         uU7fefiXtALR8BjLygpJ1c+xR36D+bKYgqGmQr9w5ueXHMFWovktRlthvmvGaERZUe8s
         1FQXF7zNINGrxVQjEEtBkuLoFt1q+2W+7ZhbKy21QPe4UOg8+aaa3e/8bFemPIeDmb8k
         Xd+sqbOifp5XXn7S02PkoWiTpDIVoiwJUqstAP921pcA0NjJWiyfIU7yrudcC+mZYHPG
         sbLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fuvaAIS8Uie5MqnqvrRYERexLZUrZAqoycXzDia+KFuMXZXt3yk8KUpcSTI6ihijbJXhU+P9GoL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwylhB3lkE8vRSTZA6qW9s2dC2DpMM+KuzFHNrhkAQdhgBY0K2s
	d/eKegWLinrEy6y/KDNU3jCvGPUdJNByAZBYhY1gso9t4yDDG0HEWNXS
X-Gm-Gg: AeBDietUqnVeN7krN2hb3fkCL4nO5ApVnPccEV+NXQMIVrvW0HU7A/Ig2I788RGY+a9
	JVjTYFW6CGEB3inOx78wzGWe82+sgkPBYnb84T8651BKfcraJ1Sz/HLs8TXLLiPGI4y1oqTARWw
	KHQhsIPW1x8NA3LafRLxruSDhMGeEVoPYBu0Z7PVJUrlypXUG80UOCPszi2GquXsycJMv9rewOP
	sjbY/ut+yDTMVu2lyMHVpLT2G1VAFUZWneF3lNOG5yRKwmYEJdT0Pa0++7B56B/QEEnC9Q+36BE
	3wN2OuUuQwNIzkmtWSbukm/qBwZFLxrSQWaU5an9XpzahCHvJbGGzTXYdqHQpXNSt3XzAzWOkya
	RGFfOa+NRQoAEN6IhduF5oiQ3OSw3vhfYd4wdjgffa43unxB8YhsInX8q1zTQYoKib805R4MzAS
	rsjK/elnFiERPNsM4tEaaL59kyt/nHJhWpCGp6cUNOsESylElZo9CkXXzRyIVwbvzxL5IGid+VV
	tE4fGGeiMPSSdM=
X-Received: by 2002:a05:6a00:c8b:b0:82c:ec1b:9e12 with SMTP id d2e1a72fcca58-82f8c849042mr10372913b3a.21.1776611617129;
        Sun, 19 Apr 2026 08:13:37 -0700 (PDT)
Received: from localhost.localdomain ([2001:448a:2002:a699:c062:7e7a:5ea3:cd14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ea02ef7sm7175560b3a.25.2026.04.19.08.13.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Apr 2026 08:13:36 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Frank Zago <frank@zago.net>,
	linux-iio@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Subject: [RFC PATCH] [RFC PATCH] iio: position: rust: add initial AS5600 driver
Date: Sun, 19 Apr 2026 22:13:27 +0700
Message-ID: <20260419151327.26306-1-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC introduces an initial Rust implementation for the ams OSRAM AS5600 magnetic rotary position sensor. The current scope covers I2C communication, device probing, and strict parsing of the AGC (Automatic Gain Control) hardware status.

For context, a C-based driver was proposed by Frank Zago in 2021 (Link: https://lore.kernel.org/linux-iio/20211216202651.120172-1-frank@zago.net/), but it was not merged. This fresh Rust implementation takes a stricter approach to probing by enforcing mandatory validation of the STATUS (0x0B) register. It gracefully aborts with -ENODEV if a valid diametrical magnet is not detected.

I have intentionally deferred exposing the IIO channels (in_angl_raw and scale) to avoid writing raw unsafe C FFI bindings. Full sysfs support will be added in a V2 once the safe Rust IIO abstractions land upstream.

Testing was performed on kernel v7.0.0-rc3 using a BeagleBone Black (AM335x) on i2c-2 (0x36) operating at 3.3V.

Testing logs verifying probe behavior and AGC logic via sysfs bind/unbind:

No magnet or magnetic field out of range:
$ echo 2-0036 > /sys/bus/i2c/drivers/as5600/bind
[ 1928.138249] as5600 2-0036: AS5600: No magnet detected

(Probe aborted, safely returns -ENODEV)
Magnet pushed too far (weak field):
$ echo 2-0036 > /sys/bus/i2c/drivers/as5600/bind
[ 1966.130616] as5600 2-0036: AS5600: Magnet too weak
[ 1966.135628] as5600 2-0036: AS5600: Sensor probed, driver ready

Magnet placed too close (strong field):
$ echo 2-0036 > /sys/bus/i2c/drivers/as5600/bind
[ 1988.541979] as5600 2-0036: AS5600: Magnet too strong
[ 1988.547183] as5600 2-0036: AS5600: Sensor probed, driver ready

Optimal diametrical spot:
$ echo 2-0036 > /sys/bus/i2c/drivers/as5600/bind
[ 1977.527490] as5600 2-0036: AS5600: Sensor probed, driver ready

Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 drivers/iio/position/Kconfig   | 13 +++++++
 drivers/iio/position/Makefile  |  1 +
 drivers/iio/position/as5600.rs | 64 ++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 drivers/iio/position/as5600.rs

diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
index 1576a6380b53..9d2611a71e33 100644
--- a/drivers/iio/position/Kconfig
+++ b/drivers/iio/position/Kconfig
@@ -6,6 +6,19 @@
 
 menu "Linear and angular position sensors"
 
+config AS5600
+	tristate "ams AS5600 magnetic rotary position sensor"
+	depends on I2C && RUST
+	help	  
+	  Say Y here to build support for the ams AS5600 12-bit
+	  magnetic rotary position sensor.
+
+	  This driver provides hardware validation and I2C probing
+	  in Rust for the AS5600.
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
index 000000000000..c5aab2230acf
--- /dev/null
+++ b/drivers/iio/position/as5600.rs
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2026 Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
+//! Driver for ams AS5600 12-bit magnetic rotary position sensor.
+//!
+//! Datasheet: https://ams.com/documents/20143/36005/AS5600_DS000365_5-00.pdf
+
+use kernel::device::Core;
+use kernel::i2c;
+use kernel::module_i2c_driver;
+use kernel::prelude::*;
+
+// AS5600 register addresses (from datasheet v1.06)
+const AS5600_REG_STATUS: u8 = 0x0B;
+const AS5600_REG_RAW_ANGLE_H: u8 = 0x0C; // High nibble [11:8] in bits [3:0]
+const AS5600_REG_RAW_ANGLE_L: u8 = 0x0D; // Low byte [7:0]
+
+// STATUS register bit masks
+const AS5600_STATUS_MH: u8 = 0x08; // Magnet too strong (AGC minimum gain overflow)
+const AS5600_STATUS_ML: u8 = 0x10; // Magnet too weak (AGC maximum gain overflow)
+const AS5600_STATUS_MD: u8 = 0x20; // Magnet detected
+
+module_i2c_driver! {
+    type: As5600,
+    name: "as5600",
+    authors: ["Muchamad Coirul Anwar"],
+    description: "I2C Driver for ams OSRAM AS5600 Magnetic Rotary Position Sensor",
+    license: "GPL",
+}
+
+kernel::i2c_device_table!(
+    I2C_TABLE,
+    MODULE_I2C_TABLE,
+    <As5600 as i2c::Driver>::IdInfo,
+    [(i2c::DeviceId::new(c"as5600"), ())]
+);
+
+struct As5600 {}
+
+impl i2c::Driver for As5600 {
+    type IdInfo = ();
+    const I2C_ID_TABLE: Option<i2c::IdTable<Self::IdInfo>> = Some(&I2C_TABLE);
+
+    fn probe(
+        dev: &i2c::I2cClient<Core>,
+        _id_info: Option<&Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> {
+        let status = dev.smbus_read_byte_data(AS5600_REG_STATUS)?;
+        if (status & AS5600_STATUS_MD) == 0 {
+            dev_err!(dev.as_ref(), "AS5600: No magnet detected\n");
+            return Err(ENODEV);
+        } else if (status & AS5600_STATUS_MH) != 0 {
+            dev_warn!(dev.as_ref(), "AS5600: Magnet too strong\n");
+        } else if (status & AS5600_STATUS_ML) != 0 {
+            dev_warn!(dev.as_ref(), "AS5600: Magnet too weak\n");
+        }
+
+        dev_info!(dev.as_ref(), "AS5600: Sensor probed, driver ready\n");
+        Ok::<_, Error>(As5600 {})
+    }
+
+    fn unbind(dev: &i2c::I2cClient<Core>, _this: Pin<&Self>) {
+        dev_info!(dev.as_ref(), "AS5600 Sensor Driver Unbound\n");
+    }
+}
-- 
2.50.0

