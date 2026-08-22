Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80628360EF5
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 06:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787380090; cv=none; b=Kth7gj8Gt5N1broDJJAtV3XRqfXuJ6VW6ffP98mx+eCcu57qrPONnC1cx2MUATAr6oZaWXC4iI+GgfPSNlPO4FI43PC9KkmX4xk/rouvfGLY1Bxrjs9fjCG0bglPs2A0YT5fxhkpqXYofyIkdYepMj5dbu8ptG6ZJRkjhUdLqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787380090; c=relaxed/simple;
	bh=LeFmW1bluMMHtZuqzUzuWC1/AbiAuVOUNqu80b8ZZpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDBhwgsD2gzzqzmg0eqg4aGC5Rh9XX72FYBf9i/vljYK8oLYDB7ec/KGHEqQu+juYH2V14xOGobF7TNqjRQ53KWtoVNomowVfz9QQuT4VkeGJ3qHkmki0ynqPblY4RmLBcO9w49WWISVKYpyLEEk5z84Zq8hs/LXWAz9HuFANAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otqZrXMs; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otqZrXMs"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dcbade417so1929042a91.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 23:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787380087; x=1787984887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8lBFakgLXC0ohAGK9NN6FmmM+xAFSCRw3E7XUA+x/pY=;
        b=otqZrXMsKcb5WbMMLN52REd3J05PMB8/b+vjle7hUcZceSVasLj/u/R2dgPJxdYBUY
         r4+6IeYiGwkwqS0WOCtixTQVYaj8WV1KPLQIgnK7MZCXwWwCE+as602rIZQgW7X06Baq
         7K8kZzl5MS13TcuDeH287WxUY6RtJx8UnucoMIjPDtkLP8HYdp3iTa1eTQhIOZI7m111
         DdhCMlMMZmSsnG4Xe9kKrAfTWwx9HycaqlZGB40n6XyqsEc0pL1++77qEFTTCm/8ZMEw
         XTYtIR2Z34C20f7/m8xzznBaSlvABpwTOaytUcR9hvCVIkJssjYB7zkhIoYG6c/OnsRq
         Xgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787380087; x=1787984887;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8lBFakgLXC0ohAGK9NN6FmmM+xAFSCRw3E7XUA+x/pY=;
        b=r6TVdde4qyzc2MtZvNTvp0SNDB1Js7P6QSy06m56piT8ZeaHAkZf/w0oh8iT888NqP
         lZiJw9H81JYDUMFNA9PfCfIpa25PSZh5E21P5Ks1ZLqQK4YVzvREC/tGOXG/xJUj/ex8
         ss6igYLG437K1dJRUahrhxNhIfNTGawR2BhBhvt1VvLy3aLnJKQg6teRu0F3PoVBRcL4
         Sb3Jamreh5rsUeRJMK3TCGUpNStLk6ztcWihbpNAzFjGiRBAirCZ37J1/Vupk77DHKPi
         4YsoNAYO7AWitIFebf8SvTETHEXHHPtmcBrHeBOgi/cAm+sdpwyc3Vzsqy96TV/ECGKe
         Y1pA==
X-Gm-Message-State: AFuF++kI4Q6M/Y8kGLWuD4ZLJeL/iq1DhgjiKEVzSwQIEK8imxE9rkx0
	QOgAKfhcZdExlUzvXZ6XP6HxWXgtNtAuubwZddh9eTnTpEDo9CMWMqoL
X-Gm-Gg: AR+sD135Rr29iu1WH8PakI5LWqr3QdIo+jIxHoUUdcOxxxf6DlSk7OAxRnw2gRUF1Nu
	E3rW88l9Es1fwMXzmBSO95y3jpKWGTZ9uoIc9SxVrMfMSps+fQqwRE64vmDkKNPv27+CFXMFn0N
	MfAGX8L2A3OT3vEe44CXKO8b1Rgy1KKtJxvgUggE2j64TnP1gYQDALne0g5sS1LXXaWhC31NzRG
	kzQPyauYC5nQuyS3yLx01qdlKM7A6PwqZVK4q/bp3NQaUV+g8NQ1iu9cW15RVqgiFkxFsvYKnN5
	h3xarGiw1F+mFeN0NozGtPTyB0hPobdQrJD8WbCpZqheuQz3HoY6WmHvWU9022QVi8cu95uxnhk
	IhhQOJLSCWyKMM1okTgZpct5IiIc5rVF107Nv4K+zU/HNYVH34FiVmZTkoNFjcI3hO09QNrcZ/G
	i6wt++crgDrJhRioKY1HVZaWXvAHehd3LGJ3BdXQtBI8iiqq75FldEn2Da/v+XIH9EnhxK54bWF
	+ulDUv4Vb3ndyTlhponJAc4lcU=
X-Received: by 2002:a17:90b:55cc:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-395c334042emr23712958a91.1.1787380086618;
        Fri, 21 Aug 2026 23:28:06 -0700 (PDT)
Received: from 192.168.1.20 ([2402:8780:104c:d93:50df:47ce:56b8:7bd1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c9128498sm1788519a91.2.2026.08.21.23.28.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 23:28:06 -0700 (PDT)
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
Subject: [RFC PATCH v5 2/3] rust: add minimal IIO subsystem abstractions
Date: Sat, 22 Aug 2026 14:26:57 +0800
Message-ID: <20260822062725.60519-3-muchamadcoirulanwar@gmail.com>
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

Add safe Rust wrappers for the Linux IIO (Industrial I/O) subsystem:

- IioChanInfo enum wrapping iio_chan_info_enum, with TryFrom<u32> for
  type-safe dispatch in read_raw. The compiler enforces match
  exhaustiveness, replacing the previous raw isize approach.
- IioVal enum with NonZeroI32 for division-by-zero prevention on
  IIO_VAL_FRACTIONAL.
- IioDriver trait with read_raw callback (requires Send + Sync).
- Device<T, State> with typestate (Unregistered -> Registered) to
  prevent double-registration at compile time.
- PinnedDrop for guaranteed cleanup sequence:
    iio_device_unregister -> drop_in_place(T) -> iio_device_free
  iio_device_unregister() calls cdev_device_del() which drains the
  kernfs workqueue before returning. All in-flight read_raw callbacks
  (which go through kernfs sysfs reads) complete before drop_in_place
  proceeds. This covers the sysfs read path used by this driver.
- Compile-time const VTABLE (iio_info).
- C-to-Rust FFI trampoline for read_raw dispatch.

The abstraction uses iio_device_alloc (not devm_*) so that the Rust
Drop implementation has full control over the cleanup sequence.
Module ownership is enforced via __iio_device_register(indio_dev, module).

Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/error.rs            |   1 +
 rust/kernel/iio.rs              | 384 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 4 files changed, 389 insertions(+)
 create mode 100644 rust/kernel/iio.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 1124785e210b..f311959bab18 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -62,6 +62,8 @@
 #include <linux/firmware.h>
 #include <linux/fs.h>
 #include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
 #include <linux/ioport.h>
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index a56ba6309594..5dc917d92151 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -86,6 +86,7 @@ macro_rules! declare_err {
     declare_err!(EIOCBQUEUED, "iocb queued, will get completion event.");
     declare_err!(ERECALLCONFLICT, "Conflict with recalled state.");
     declare_err!(ENOGRACE, "NFS file lock reclaim refused.");
+    declare_err!(ENODATA, "No data available.");
 }
 
 /// Generic integer kernel error.
diff --git a/rust/kernel/iio.rs b/rust/kernel/iio.rs
new file mode 100644
index 000000000000..f1638160fed1
--- /dev/null
+++ b/rust/kernel/iio.rs
@@ -0,0 +1,384 @@
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
+        __iio_device_register,
+        iio_chan_spec,
+        iio_dev,
+        iio_device_alloc,
+        iio_device_free,
+        iio_device_unregister,
+        iio_info, //
+    },
+    device,
+    error::{
+        code::*,
+        to_result,
+        Result, //
+    },
+    prelude::*,
+    ThisModule, //
+};
+
+use core::{
+    ffi::c_int,
+    marker::PhantomData,
+    mem::{
+        forget,
+        size_of,
+        zeroed, //
+    },
+    num::NonZeroI32,
+    pin::Pin,
+    ptr::drop_in_place, //
+};
+
+use pin_init::{
+    pin_data,
+    pinned_drop, //
+};
+
+/// IIO value type: single integer (`IIO_VAL_INT`).
+pub const IIO_VAL_INT: c_int = crate::bindings::IIO_VAL_INT as c_int;
+/// IIO value type: integer plus micro part (`IIO_VAL_INT_PLUS_MICRO`).
+pub const IIO_VAL_INT_PLUS_MICRO: c_int = crate::bindings::IIO_VAL_INT_PLUS_MICRO as c_int;
+/// IIO value type: integer plus nano part (`IIO_VAL_INT_PLUS_NANO`).
+pub const IIO_VAL_INT_PLUS_NANO: c_int = crate::bindings::IIO_VAL_INT_PLUS_NANO as c_int;
+/// IIO value type: fractional (`IIO_VAL_FRACTIONAL`).
+pub const IIO_VAL_FRACTIONAL: c_int = crate::bindings::IIO_VAL_FRACTIONAL as c_int;
+
+/// Generates a Rust enum wrapper for C `enum iio_chan_info_enum`.
+///
+/// This macro creates a type-safe enum with automatic `TryFrom<u32>`
+/// conversion. Drivers match directly on `IioChanInfo` variants in
+/// `read_raw`, and the compiler enforces match exhaustiveness.
+/// Additional variants can be added as drivers require them.
+macro_rules! build_iio_enum {
+    (
+        $(
+            $(#[$meta:meta])*
+            $rust_name:ident = $c_const:ident
+        ),* $(,)?
+    ) => {
+        /// Channel info attribute selector for [`IioDriver::read_raw`].
+        ///
+        /// Wraps C `enum iio_chan_info_enum` values. The IIO core passes this
+        /// to `read_raw` to indicate which attribute userspace is reading
+        /// (e.g., raw value, scale factor, offset).
+        ///
+        /// Currently covers the subset needed by in-tree Rust drivers.
+        /// Additional variants from `include/linux/iio/types.h` can be
+        /// added as needed.
+        #[repr(u32)]
+        #[derive(Debug, Clone, Copy, PartialEq, Eq)]
+        pub enum IioChanInfo {
+            $(
+                $(#[$meta])*
+                $rust_name = bindings::$c_const,
+            )*
+        }
+        impl TryFrom<u32> for IioChanInfo {
+            type Error = Error;
+            fn try_from(value: u32) -> Result<Self, Self::Error> {
+                match value {
+                    $( bindings::$c_const => Ok(IioChanInfo::$rust_name), )*
+                    _ => Err(EINVAL),
+                }
+            }
+        }
+    };
+}
+
+build_iio_enum! {
+    /// Raw unprocessed value from the channel (`IIO_CHAN_INFO_RAW`).
+    ///
+    /// For sensors, this is typically the ADC reading or register value
+    /// before any scaling or offset correction.
+    Raw = iio_chan_info_enum_IIO_CHAN_INFO_RAW,
+    /// Scale factor to convert raw values to SI units (`IIO_CHAN_INFO_SCALE`).
+    ///
+    /// The processed value is `raw * scale`. The unit depends on the channel
+    /// type (e.g. V for voltage, m/s² for acceleration, rad for angle).
+    Scale = iio_chan_info_enum_IIO_CHAN_INFO_SCALE,
+}
+
+/// Represents the return value of a `read_raw` operation.
+///
+/// Each variant corresponds to an `IIO_VAL_*` constant and tells the
+/// IIO core how to format `val` and `val2` for userspace.
+pub enum IioVal {
+    /// A single integer value.
+    Int(i32),
+    /// A fractional value represented as `val / val2`.
+    /// The denominator is `NonZeroI32` to prevent division-by-zero in
+    /// `iio_format_value()`.
+    Fractional(i32, NonZeroI32),
+    /// An integer plus a micro (1e-6) fractional part: `val.val2`.
+    IntPlusMicro(i32, i32),
+    /// An integer plus a nano (1e-9) fractional part: `val.val2`.
+    IntPlusNano(i32, i32),
+}
+
+/// Trait to be implemented by IIO driver private data.
+///
+/// Implementors supply the `read_raw` callback invoked by the IIO core
+/// when userspace reads a channel attribute (e.g. `in_angl_raw`).
+///
+/// The `Send + Sync` bounds ensure the compiler rejects driver types with
+/// thread-unsafe interior mutability (e.g. `Cell`), since the IIO core may
+/// invoke `read_raw` concurrently from multiple sysfs readers.
+pub trait IioDriver: Send + Sync {
+    /// Called by the IIO core when userspace reads a channel attribute.
+    ///
+    /// `chan` is the channel being read; `info` selects the attribute
+    /// (e.g. `IIO_CHAN_INFO_RAW`, `IIO_CHAN_INFO_SCALE`).
+    fn read_raw(&self, chan: *const iio_chan_spec, info: IioChanInfo) -> Result<IioVal>;
+
+    /// Returns the channel specifications for this driver.
+    ///
+    /// The default implementation returns an empty slice.
+    fn channels(&self) -> &'static [iio_chan_spec] {
+        &[]
+    }
+}
+
+/// C-compatible trampoline for the `iio_info.read_raw` callback.
+///
+/// # Safety
+///
+/// This function is only called by the IIO core via the `read_raw` function
+/// pointer in `iio_info`. The IIO core guarantees:
+/// - `indio_dev` is a valid `iio_dev` allocated by `iio_device_alloc`.
+/// - `chan` points to a valid channel spec from the device's channel array.
+/// - `val` is a valid non-null pointer to a writable `int`.
+/// - `val2` is a valid non-null pointer to a writable `int`. The IIO core
+///   always passes stack-allocated storage for both, regardless of whether
+///   the driver uses `val2` (e.g. `IIO_VAL_INT` only writes `val`; `val2`
+///   is provided but left unread by the caller for that return type).
+unsafe extern "C" fn read_raw_callback<T: IioDriver>(
+    indio_dev: *mut iio_dev,
+    chan: *const iio_chan_spec,
+    val: *mut c_int,
+    val2: *mut c_int,
+    info: isize,
+) -> c_int {
+    // SAFETY: `indio_dev` is valid and was allocated with space for `T` in its
+    // private data area. The `priv_` field was initialized in `Device::build_device()`.
+    let priv_ptr = unsafe { (*indio_dev).priv_ as *mut T };
+    // SAFETY: `priv_ptr` points to a valid, initialized instance of `T` that
+    // lives as long as the `iio_dev` allocation.
+    let driver = unsafe { &*priv_ptr };
+
+    let info_enum = match IioChanInfo::try_from(info as u32) {
+        Ok(valid) => valid,
+        Err(e) => return e.to_errno(),
+    };
+
+    match driver.read_raw(chan, info_enum) {
+        Ok(IioVal::Int(v)) => {
+            // SAFETY: `val` is valid per the function's Safety contract above.
+            // `val2` is not written; `IIO_VAL_INT` signals to the IIO core
+            // that only `val` carries meaningful data.
+            unsafe {
+                *val = v;
+            }
+            IIO_VAL_INT
+        }
+        Ok(IioVal::Fractional(v, v2)) => {
+            // SAFETY: both `val` and `val2` are valid per the Safety contract.
+            unsafe {
+                *val = v;
+                *val2 = v2.get();
+            }
+            IIO_VAL_FRACTIONAL
+        }
+        Ok(IioVal::IntPlusMicro(v, v2)) => {
+            // SAFETY: both `val` and `val2` are valid per the Safety contract.
+            unsafe {
+                *val = v;
+                *val2 = v2;
+            }
+            IIO_VAL_INT_PLUS_MICRO
+        }
+        Ok(IioVal::IntPlusNano(v, v2)) => {
+            // SAFETY: both `val` and `val2` are valid per the Safety contract.
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
+// Device<T, State>: IIO device wrapper with typestate.
+
+/// Marker type for an unregistered IIO device.
+pub struct Unregistered;
+/// Marker type for a registered IIO device.
+pub struct Registered;
+
+/// A wrapped IIO device managing its C `struct iio_dev` lifetime.
+///
+/// Uses `iio_device_alloc` for allocation (not devres) and manual cleanup
+/// via `Drop`: `iio_device_unregister` -> `drop_in_place` for `T` ->
+/// `iio_device_free`.
+///
+/// # Invariants
+///
+/// - `indio_dev` is a valid pointer to an `iio_dev` allocated by `iio_device_alloc`.
+/// - If `registered` is true, the device was successfully registered via
+///   `__iio_device_register`.
+#[pin_data(PinnedDrop)]
+pub struct Device<T: IioDriver, State = Unregistered> {
+    indio_dev: *mut iio_dev,
+    registered: bool,
+    _p: PhantomData<(T, State)>,
+}
+
+// SAFETY: `Device` only contains a raw pointer to a kernel-managed `iio_dev`.
+// The IIO core serializes access to the device, and `T` is required to be `Send`.
+unsafe impl<T: IioDriver, S> Send for Device<T, S> {}
+// SAFETY: All `&self` access to the `iio_dev` is read-only or goes through the
+// IIO core which provides its own synchronization. `T` is required to be `Sync`.
+unsafe impl<T: IioDriver, S> Sync for Device<T, S> {}
+
+#[pinned_drop]
+impl<T: IioDriver, S> PinnedDrop for Device<T, S> {
+    fn drop(self: Pin<&mut Self>) {
+        if self.registered {
+            // SAFETY: `__iio_device_register` succeeded.
+            //
+            // iio_device_unregister() removes sysfs entries via kernfs, which
+            // calls kernfs_drain() to wait for all in-flight sysfs attribute
+            // reads to complete before returning. Drivers that only use sysfs
+            // access paths (INDIO_DIRECT_MODE without buffer/trigger) are
+            // guaranteed that no read_raw callback is in flight after this.
+            //
+            // For drivers with buffer support, additional synchronization
+            // analysis is required for character device paths, which are NOT
+            // covered by kernfs_drain().
+            unsafe { iio_device_unregister(self.indio_dev) };
+        }
+
+        // SAFETY: `priv_` was fully initialized in `build_device` via
+        // `init.__pinned_init(priv_ptr)`. `drop_in_place` runs `T`'s destructor
+        // (including any pinned fields like Mutex). After that, `iio_device_free`
+        // calls `put_device` which decrements the kref. The underlying `iio_dev`
+        // memory is only freed when kref reaches 0.
+        unsafe {
+            let priv_ptr = (*self.indio_dev).priv_ as *mut T;
+            drop_in_place(priv_ptr);
+            iio_device_free(self.indio_dev);
+        }
+    }
+}
+
+impl<T: IioDriver> Device<T> {
+    // SAFETY:
+    // - `read_raw_callback::<T>` is a valid function pointer whose signature
+    //   matches the IIO core's `read_raw` contract.
+    // - All remaining fields are pointers or function pointers; zeroed values
+    //   are NULL, and the IIO core checks for NULL before invoking any optional
+    //   callback or dereferencing any optional attribute group.
+    const VTABLE: iio_info = iio_info {
+        read_raw: Some(read_raw_callback::<T>),
+        ..unsafe { zeroed() }
+    };
+
+    /// Allocates a new IIO device with the given driver data.
+    ///
+    /// Uses `iio_device_alloc` (not `devm_*`) so that the Rust `Drop`
+    /// implementation has full control over the cleanup sequence.
+    /// The device is not yet registered; call [`register`](Self::register)
+    /// to make it visible to userspace.
+    pub fn build_device<E>(
+        dev: &device::Device,
+        name: &'static CStr,
+        modes: u32,
+        init: impl PinInit<T, E>,
+    ) -> Result<Self>
+    where
+        Error: From<E>,
+    {
+        let priv_size = i32::try_from(size_of::<T>()).map_err(|_| EINVAL)?;
+
+        // SAFETY: `dev.as_raw()` returns a valid `struct device` pointer.
+        // `iio_device_alloc` allocates an `iio_dev` with `sizeof(T)` bytes of
+        // private data. Returns NULL on failure.
+        let indio_dev = unsafe { iio_device_alloc(dev.as_raw(), priv_size) };
+        if indio_dev.is_null() {
+            return Err(ENOMEM);
+        }
+
+        // SAFETY: `indio_dev` is valid and freshly allocated. `priv_` points to
+        // zeroed memory (kzalloc'd by iio_device_alloc). `PinInit::__pinned_init`
+        // overwrites it in place without reading previous contents.
+        let priv_ptr = unsafe { (*indio_dev).priv_ as *mut T };
+        let init_result = unsafe { init.__pinned_init(priv_ptr) };
+        if let Err(e) = init_result {
+            // SAFETY: `pin_init` guarantees partial-init rollback internally.
+            // `priv_` memory was not fully initialized, so we only free the
+            // container without running `T`'s destructor.
+            unsafe { iio_device_free(indio_dev) };
+            return Err(Error::from(e));
+        }
+
+        // SAFETY: `priv_ptr` is now fully initialized. We set up the IIO
+        // device fields:
+        // - `name` is a `'static` C string that outlives the device.
+        // - `VTABLE` is a `'static` const and outlives the device.
+        // - `channels()` is required to return a `'static` slice (trait
+        //   contract). The pointer stored in `indio_dev.channels` therefore
+        //   remains valid for the entire lifetime of the `iio_dev` allocation
+        //   (until `iio_device_free`), because static data outlives any
+        //   allocation.
+        // - `modes` is passed by the caller and stored as-is.
+        unsafe {
+            (*indio_dev).name = name.as_char_ptr();
+            (*indio_dev).info = &Self::VTABLE;
+
+            let chans = (*priv_ptr).channels();
+            (*indio_dev).channels = chans.as_ptr();
+            (*indio_dev).num_channels = chans.len() as _;
+            (*indio_dev).modes = modes as i32;
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
+    #[inline]
+    pub fn register(self, module: &'static ThisModule) -> Result<Device<T, Registered>> {
+        // SAFETY: `self.indio_dev` is a valid, fully initialized `iio_dev`.
+        // `module.as_ptr()` provides the module owner for proper refcounting.
+        let ret = unsafe { __iio_device_register(self.indio_dev, module.as_ptr()) };
+        to_result(ret)?;
+
+        let registered_dev = Device {
+            indio_dev: self.indio_dev,
+            registered: true,
+            _p: PhantomData,
+        };
+
+        // Prevent `self`'s Drop from running. Ownership of `indio_dev`
+        // has been transferred to `registered_dev`.
+        forget(self);
+        Ok(registered_dev)
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 68f4d9a3425d..726a23e2d579 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -81,6 +81,8 @@
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

