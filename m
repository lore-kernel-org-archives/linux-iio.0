Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EE83FE35A
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468984; cv=none; b=DC1LAd4tJq4T29Gq8MBSdkejV7UdWS+LxRB6q7AhW0BeMPjAEeOTRGbTQbSM6+a3rEh64sKL5Ns3oNSQl4hwjVgT6ADb704vkdgBS39UdwPMlsPsDsLm95sY7CTVJ4xGg9xUviMqv/JjqZ6nvAEYygUkeh8ZBlJzzzphp65b5pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468984; c=relaxed/simple;
	bh=gczVuAShdEGpAOX27PF16GmBdqERLGb5Ax6/ItUK9YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuPpfl+NDcG+ey+/LeiMye7t000LFpmKuWjD9/FSHlN/s+JRuXm9S/t5ZPzyxtkgcXxlNKeX408i1RHlnT8rk57mk1X77vUmoSW6p40s5aFAr7Z8fgO8VNyMrMdVmavSvpL3KUeYfRTSpOhOsjtB/Ic9InkJKMipZGK9igfvmrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Acgbd25z; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Acgbd25z"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f33d28c1dso6959534b3a.3
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 06:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777468983; x=1778073783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zk/HPFBK4IBkCNGG/AGyeD13qmMu2NSM3WquJIJ4QH8=;
        b=Acgbd25zS4d6QKVVjX6aSYyMdu5Z7lO/fvh1ZPHuSoWXV1IMtEyNP8BHvmBKv/OJK+
         OWQtHYmmYHoDv9kdZgxjmWnAVoKqGRA0b9orlds63l/M2eTrgBgz5Z5OSf9r9+F2En2u
         Cdqgif7oOUFO+X5Z6ScF2yHBP5hjgUQA6Hj9/9MnEsNJcsC8dtHSLhuJE50V+HGK+Ec0
         NKX4wrIUP0zmdA0Yuq3JJCrU1gE8ZiVbMiZqqGtENEJf2oqbOqwU9d4W8OqCIECcoK/Y
         cYoP9Tz+VRc/x5fg1G0LikDJIu4wx3W2Ifd7430ZjBmCErSqufVOthg2Ky9dfGqPSfcM
         dJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468983; x=1778073783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zk/HPFBK4IBkCNGG/AGyeD13qmMu2NSM3WquJIJ4QH8=;
        b=YWE33hIOBhjUYGibboWyh+4rtI57c0PuKwefS5EO+wWLLCAVKV3cECCcNRi8I1GgI9
         K4Cwelu4UgnFbDNoEhBE7Nv50A2NsAnjEUVwKLqSkwZSOsWlU1BaSsnXiGflObORis/A
         we6KFp9/CzIdf7kYuU1jL26/ctPTFuo3KCzppI/RkdtmWi0y0kSmNqhlVWWUNYmKimRH
         CbZnRmvPrI3YeTOHpI1UnX4Vr7n3ouR1Icjr6ZgvFYaWg3Bt+Dm1kNSKWsJ4DardHxmS
         3fxtGZ5wI08bioVMS0XKpLmdisnOMlnQE9X1BKXZ8u2JLBIGXe2MxyrxqUUPeyv1ZV/O
         F/Ng==
X-Forwarded-Encrypted: i=1; AFNElJ+e+pftcKVbCBPFRn39h4OB412BGFm8zlT46g8gUOT3VU1EUPJWdlI+RQf7AGQcgEUFJ7IV7Z2W9sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygUhG8daY2Tus5ZO3b7VdboI0CETMkldva+qImMuOQrzwisg1L
	C+tkI87vBT+QD1pDrhBUPaKtQ3WIIo8KWfgh2OdIVytVOYUWLBmBiUS5
X-Gm-Gg: AeBDiesw5WyRGcovKkyn501E5Q0XG+PC/epZn8bZ0GFsmvs3thj99xxJP3L7yIaubVg
	KmDrntL+7JuIl8siMBmsqMGmGg16BJmu+eftAa1WlbAALEfUjeDE9nTIYf4NLPakifEQaV3n92D
	yTRAtIHcH3Yo/6zpqcxseZ+GKeqL9fZ6L+7clwfSALp7FXHnb5LVLpBM5Ajndgf4J+YYDk/DOML
	g3aWJcZv6X+kO5hY2nEqEFn6uLyQq94AGw/npPjV0JJIy5XS9BrV4omwKRdYykzgOwud3WUvMD8
	aAD+KOC5180aMME4+aKu6VoC7Cl5gSq2UBbj4fRJSQWsXU/MQyDbxJT5R9G7vUJbfRdfVnwNqjN
	20EObxCKxzhddspeV9RcXagg8PJwDGQV6ZPxHVqPBSzhVVCIiEZztOa1Z9j1TB1FJabBlu68B7W
	ClJBy2GxwGrBKQET0tezbj79NY/ByVdPRHeaY2n0Vzh71lTyP+ND8JzuA8xvlgt1zNkNE4KVJOF
	pictf62flgFMfiffynE3J+EcQ==
X-Received: by 2002:a05:6a00:849:b0:82f:238f:b5a8 with SMTP id d2e1a72fcca58-834ddae11cfmr7829325b3a.9.1777468982443;
        Wed, 29 Apr 2026 06:23:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:448a:2002:4381:3859:fd0d:505e:362c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5cd407sm2091372b3a.13.2026.04.29.06.22.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Apr 2026 06:23:01 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: branstj@gmail.com,
	lars@metafoo.de,
	ojeda@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	igor.korotin.linux@gmail.com,
	linux-kernel@vger.kernel.org,
	Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Subject: [RFC PATCH v2 2/4] rust: add minimal IIO subsystem abstractions
Date: Wed, 29 Apr 2026 20:22:28 +0700
Message-ID: <20260429132234.30514-3-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260429132234.30514-1-muchamadcoirulanwar@gmail.com>
References: <20260429132234.30514-1-muchamadcoirulanwar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/iio.rs              | 224 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 3 files changed, 228 insertions(+)
 create mode 100644 rust/kernel/iio.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 083cc44aa952..e732ee19b90c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -58,6 +58,8 @@
 #include <linux/firmware.h>
 #include <linux/fs.h>
 #include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
 #include <linux/ioport.h>
diff --git a/rust/kernel/iio.rs b/rust/kernel/iio.rs
new file mode 100644
index 000000000000..ee27d928e803
--- /dev/null
+++ b/rust/kernel/iio.rs
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
+//! IIO subsystem abstractions.
+//!
+//! Minimal safe Rust wrappers for the Linux IIO (Industrial I/O) subsystem.
+//! Provides [`Device`] for allocating and registering an IIO device, and the
+//! [`IioDriver`] trait for implementing `read_raw` callbacks in safe Rust.
+
+use crate::{
+    bindings::{
+        __iio_device_register, iio_chan_spec, iio_dev, iio_device_alloc, iio_device_free,
+        iio_device_unregister, iio_info, INDIO_DIRECT_MODE,
+    },
+    device,
+    error::{code::*, to_result, Result},
+    prelude::*,
+    ThisModule,
+};
+use core::{
+    ffi::c_int,
+    marker::PhantomData,
+    mem::{size_of, zeroed},
+    ptr::{drop_in_place, write},
+};
+use pin_init::{pin_data, pinned_drop};
+/// IIO value type: single integer (`IIO_VAL_INT`).
+pub const IIO_VAL_INT: c_int = crate::bindings::IIO_VAL_INT as c_int;
+/// IIO value type: integer plus micro part (`IIO_VAL_INT_PLUS_MICRO`).
+pub const IIO_VAL_INT_PLUS_MICRO: c_int = crate::bindings::IIO_VAL_INT_PLUS_MICRO as c_int;
+/// IIO value type: integer plus nano part (`IIO_VAL_INT_PLUS_NANO`).
+pub const IIO_VAL_INT_PLUS_NANO: c_int = crate::bindings::IIO_VAL_INT_PLUS_NANO as c_int;
+/// IIO value type: fractional (`IIO_VAL_FRACTIONAL`).
+pub const IIO_VAL_FRACTIONAL: c_int = crate::bindings::IIO_VAL_FRACTIONAL as c_int;
+
+/// Represents the return value of a `read_raw` operation.
+///
+/// Each variant corresponds to an `IIO_VAL_*` constant and tells the
+/// IIO core how to format `val` and `val2` for userspace.
+pub enum IioVal {
+    /// A single integer value.
+    Int(i32),
+    /// A fractional value represented as `val / val2`.
+    Fractional(i32, i32),
+    /// An integer plus a micro (10⁻⁶) fractional part: `val.val2`.
+    IntPlusMicro(i32, i32),
+    /// An integer plus a nano (10⁻⁹) fractional part: `val.val2`.
+    IntPlusNano(i32, i32),
+}
+
+/// Trait to be implemented by IIO driver private data.
+///
+/// Implementors supply the `read_raw` callback invoked by the IIO core
+/// when userspace reads a channel attribute (e.g. `in_angl_raw`).
+pub trait IioDriver {
+    /// Called by the IIO core when userspace reads a channel attribute.
+    ///
+    /// `chan` is the channel being read; `mask` selects the attribute
+    /// (e.g. `IIO_CHAN_INFO_RAW`, `IIO_CHAN_INFO_SCALE`).
+    fn read_raw(&self, chan: *const iio_chan_spec, mask: isize) -> Result<IioVal>;
+
+    /// Returns the channel specifications for this driver.
+    ///
+    /// The default implementation returns an empty slice.
+    fn channels(&self) -> &[iio_chan_spec] {
+        &[]
+    }
+}
+
+/// C-compatible trampoline for the `iio_info.read_raw` callback.
+///
+/// # Safety
+///
+/// This function is only called by the IIO core with valid pointers:
+/// - `indio_dev` is a valid `iio_dev` allocated by `iio_device_alloc`.
+/// - `chan` points to a valid channel spec from the device's channel array.
+/// - `val` and `val2` are valid pointers for writing the result.
+unsafe extern "C" fn read_raw_callback<T: IioDriver>(
+    indio_dev: *mut iio_dev,
+    chan: *const iio_chan_spec,
+    val: *mut c_int,
+    val2: *mut c_int,
+    mask: isize,
+) -> c_int {
+    // SAFETY: `indio_dev` is valid and was allocated with space for `T` in its
+    // private data area. The `priv_` field was initialized in `Device::new()`.
+    let priv_ptr = unsafe { (*indio_dev).priv_ as *mut T };
+    // SAFETY: `priv_ptr` points to a valid, initialized instance of `T` that
+    // lives as long as the `iio_dev` allocation.
+    let driver = unsafe { &*priv_ptr };
+
+    match driver.read_raw(chan, mask) {
+        Ok(IioVal::Int(v)) => {
+            // SAFETY: `val` is a valid pointer provided by the IIO core.
+            unsafe { *val = v };
+            IIO_VAL_INT
+        }
+        Ok(IioVal::Fractional(v, v2)) => {
+            // SAFETY: `val` and `val2` are valid pointers provided by the IIO core.
+            unsafe {
+                *val = v;
+                *val2 = v2;
+            };
+            IIO_VAL_FRACTIONAL
+        }
+        Ok(IioVal::IntPlusMicro(v, v2)) => {
+            // SAFETY: `val` and `val2` are valid pointers provided by the IIO core.
+            unsafe {
+                *val = v;
+                *val2 = v2;
+            }
+            IIO_VAL_INT_PLUS_MICRO
+        }
+        Ok(IioVal::IntPlusNano(v, v2)) => {
+            // SAFETY: `val` and `val2` are valid pointers provided by the IIO core.
+            unsafe {
+                *val = v;
+                *val2 = v2;
+            }
+            IIO_VAL_INT_PLUS_NANO
+        }
+        Err(e) => e.to_errno(),
+    }
+}
+
+/// A registered IIO device.
+///
+/// Wraps a C `struct iio_dev` and manages its lifetime. On drop the
+/// device is unregistered (if registered) and its memory freed.
+#[pin_data(PinnedDrop)]
+pub struct Device<T: IioDriver> {
+    indio_dev: *mut iio_dev,
+    registered: bool,
+    _p: PhantomData<T>,
+}
+
+// SAFETY: `Device` only contains a raw pointer to a kernel-managed `iio_dev`.
+// The IIO core serializes access to the device, and `T` is required to be `Send`.
+unsafe impl<T: IioDriver + Send> Send for Device<T> {}
+// SAFETY: All `&self` access to the `iio_dev` is read-only or goes through the
+// IIO core which provides its own synchronization. `T` is required to be `Sync`.
+unsafe impl<T: IioDriver + Sync> Sync for Device<T> {}
+
+#[pinned_drop]
+impl<T: IioDriver> PinnedDrop for Device<T> {
+    // SAFETY: `self.indio_dev` was allocated by `iio_device_alloc` in `new()`
+    // and is valid for the lifetime of this struct. We unregister first (if
+    // registered), then drop the private data, then free the `iio_dev`.
+    // This ordering is critical: unregister ensures no more callbacks can
+    // fire before we drop the driver data they reference.
+    fn drop(self: Pin<&mut Self>) {
+        unsafe {
+            if self.registered {
+                iio_device_unregister(self.indio_dev);
+            }
+            let priv_ptr = (*self.indio_dev).priv_ as *mut T;
+            drop_in_place(priv_ptr);
+            iio_device_free(self.indio_dev);
+        }
+    }
+}
+
+impl<T: IioDriver> Device<T> {
+    // SAFETY: The remaining fields of `iio_info` are pointers and function
+    // pointers. Zeroed values are NULL, and the IIO core checks for NULL
+    // before invoking callbacks or dereferencing attribute group pointers.
+    const VTABLE: iio_info = iio_info {
+        read_raw: Some(read_raw_callback::<T>),
+        ..unsafe { zeroed() }
+    };
+
+    /// Allocates a new IIO device with the given driver data.
+    ///
+    /// The device is not yet registered; call [`register`](Self::register)
+    /// to make it visible to userspace.
+    pub fn new(dev: &device::Device, data: T, name: &'static CStr) -> Result<Self> {
+        // SAFETY: `dev.as_raw()` returns a valid `struct device` pointer.
+        // `iio_device_alloc` allocates an `iio_dev` with `sizeof(T)` bytes of
+        // private data. Returns NULL on failure.
+        let indio_dev = unsafe { iio_device_alloc(dev.as_raw(), size_of::<T>() as _) };
+        if indio_dev.is_null() {
+            return Err(ENOMEM);
+        }
+
+        // SAFETY: `indio_dev` is a valid, newly allocated `iio_dev`.
+        // - `priv_` points to an uninitialized area of `sizeof(T)` bytes.
+        // - `core::ptr::write` initializes it without reading the old value.
+        // - `name` is a `'static` C string that outlives the device.
+        // - `VTABLE` is a `'static` const and outlives the device.
+        // - `channels()` returns a reference to data owned by `T` in `priv_`,
+        //   which remains at a fixed address for the lifetime of `indio_dev`
+        //   because `priv_` is heap-allocated by `iio_device_alloc`.
+        unsafe {
+            let priv_ptr = (*indio_dev).priv_ as *mut T;
+            write(priv_ptr, data);
+            (*indio_dev).name = name.as_char_ptr();
+            (*indio_dev).info = &Self::VTABLE;
+
+            let chans = (*priv_ptr).channels();
+            (*indio_dev).channels = chans.as_ptr() as *const iio_chan_spec;
+            (*indio_dev).num_channels = chans.len() as _;
+            (*indio_dev).modes = INDIO_DIRECT_MODE as i32;
+        }
+
+        Ok(Self {
+            indio_dev,
+            registered: false,
+            _p: PhantomData,
+        })
+    }
+
+    /// Registers the IIO device, making it visible to userspace via sysfs.
+    ///
+    /// On success, channel attributes like `in_angl_raw` become readable.
+    /// On failure the device stays unregistered and will be freed when
+    /// this [`Device`] is dropped.
+    pub fn register(&mut self, _dev: &device::Device, module: &'static ThisModule) -> Result {
+        // SAFETY: `self.indio_dev` is a valid, fully initialized `iio_dev`.
+        // `module.as_ptr()` provides the module owner for proper refcounting.
+        let ret = unsafe { __iio_device_register(self.indio_dev, module.as_ptr()) };
+        to_result(ret)?;
+        self.registered = true;
+        Ok(())
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 138d846f798d..ec6eb4dbdb6a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -99,6 +99,8 @@
 #[cfg(CONFIG_I2C = "y")]
 pub mod i2c;
 pub mod id_pool;
+#[cfg(CONFIG_IIO)]
+pub mod iio;
 #[doc(hidden)]
 pub mod impl_flags;
 pub mod init;
-- 
2.50.0

