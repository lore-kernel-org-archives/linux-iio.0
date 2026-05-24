Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6111CA9
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779629327; cv=none; b=jEVwQNVrUiiuTyiU/UTi61y629yYbARFL3iezLOCW/kK5ST71LR+cfUR7ehtPfFL7ayklgGqeYmoot6pcLq5F+Cc/98V1G8uc4BFTzWW+meQLzOAeVNm074QkjtIVxjYSgkrhuqsw0rED21Woo6rqAqu7nCTpYsPLaqs5iG7Nfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779629327; c=relaxed/simple;
	bh=rxRCYggfaZEdwDkyjmmeZlht5i9m1vYJe2tzRUy9TFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+oMO+J/wiEUNpdNII8BmuM5EkwjH7thzbYbbVHQXIJ+ccJW+PuE39uJ8MvIGYH8pE+SPUY0NMTx4Q4VW6l+couuDUpdekjpdKgk4wP9ijFuLewJXyLMyAKWxfgkxZ26dAkU0FUWkDSssjwPt4AA/T7QcAV23VpNna35a2TjMZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGDCA/g0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGDCA/g0"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bea7176c72so25976505ad.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779629325; x=1780234125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWMN4P/wUAQ6ZB9Etc8PQC9btGokL5vUI0KZKUAzrPg=;
        b=DGDCA/g0Y0R0Dx7181vZWZHrZFesnsuhk6CuHiJL88zIIkrxb0LmeAAU1i6mzfVA0+
         a5rsHPGnFD/YAxEEUl5ph73Xe9Ymgkj/xF7fyJwFBbctAWZd9ao15iGA2Td2MepUVc/u
         9aAdfo4lqQhNuxRuJwoqra9TM1nXeTlKipb7QUz78383RSnvIFZKPPeOaizqLbH7lFhU
         qofrzDDpscqJ5ZW0Fbs7Ux7kDCIsaKKHci/QcoV/4JVJ2DM/sOrtP/kAXBn8/z4mDhLx
         PryBOckqhzmFEWcQBPjGhS0TeTUtrOnj+mEHxbbL0E8EFZq0z74Ic8hgTRl1mP9Aft+H
         G0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779629325; x=1780234125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TWMN4P/wUAQ6ZB9Etc8PQC9btGokL5vUI0KZKUAzrPg=;
        b=R6npph4ChRJSYZJmPsOfllrhcUZOlZVsvIRUsrBi1Dd2VmDhf2QR4jxH20EUXytUCd
         Sg0FON83JOQQs5ErmyZDrp69AUIty40XBzHmgsr+ocpepx+P6EqY0qc7xrviYAXt9BEP
         ZuzGqnT2VQxQHvOTHLkY4y7FdrGc1bfWe1bMnRFFa2gGOrN/J+lZqbE0Kch9+jjP1moD
         EHS1ncaQ8YY29m0qOrAmtLt2xvrXgh85k0tGbnYlPJxVgX4SYW0BFtR9VKyqIGPNNoO7
         ccdABd7tr3n+HUftJVj3VDcMduHINil5Ay6kbVEJ2OjbxRw420rXsqFrPER7Rqgqpodp
         KTIg==
X-Gm-Message-State: AOJu0YwKowsRKo2wqWsGUFLwe5nmOalqL2fiCLRFwPd5dHU4NDhPpNDK
	wbUe3+TdPoCah1hodtBX+VLbQL1gzLR2QWvhn0auKAniRjBvVAbkdraZ
X-Gm-Gg: Acq92OGTcSjWgmi5EgLmEftTXqojFS2LCSgtEr99jHpwbzzrjlRa6TNJFyqkZlvRmSI
	7c2gp9Ufz/Csub2jRJHJqeWyf1UzTiunaAO/OBJwLNCwL01TFz1xyT+5wwlpVSq1RaUoX1P59C6
	WsSItFXk6wDV9wxH/g2qdR7WlyiEsNCHmyMBkYsdSO8/sMGKBbjtXGtqDFvyAb3F0iKk/BNYJqO
	KhcI+yqOioJKA9qFC0ZzZBe1Auw6+ixqP2IizcKZK3SEtDLPfh+PGgyGgyyBqr+oKIhh1cjnB0n
	mheADGif37fKSXb5IovY0+1E2pniZyIKgkB9hWEDie3T/xGK2cMRW2uhLrFIimrUwFwdX1tJuCq
	L7v5gL5SV6ngrPGqzdtjr1kdOkXR2EFJLFksEuek7fhqd8OALa/DkTE1076puCm9D58bWj++cQP
	JXTfgvum/FM6lvh23msKtuNQCh6RXOdxdP8l1agEkcqRQjOJyHJQuXdWHjXfa04g==
X-Received: by 2002:a17:902:ebc2:b0:2bd:83e1:5613 with SMTP id d9443c01a7336-2beb067468dmr111156065ad.20.1779629325058;
        Sun, 24 May 2026 06:28:45 -0700 (PDT)
Received: from 192.168.1.3 ([2001:448a:2003:4286:c553:4edf:bb9:bbd2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56f4343sm91197175ad.36.2026.05.24.06.28.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 May 2026 06:28:44 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Igor Korotin <igor.korotin.linux@gmail.com>,
	Brandon Saint-John <branstj@gmail.com>,
	Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Subject: [RFC PATCH v3 2/4] rust: add minimal IIO subsystem abstractions
Date: Sun, 24 May 2026 20:28:21 +0700
Message-ID: <20260524132824.54918-3-muchamadcoirulanwar@gmail.com>
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

Add safe Rust wrappers for the Linux IIO subsystem. Provides:
- Device<T, State> with typestate pattern (Unregistered/Registered)
- IioDriver trait with read_raw callback
- DirectModeGuard RAII for iio_device_claim_direct
- IioVal enum with NonZeroI32 for division-by-zero prevention
- PinnedDrop cleanup: unregister -> drop_in_place -> iio_device_free

Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 rust/helpers/helpers.c |   1 +
 rust/helpers/iio.c     |  24 +++
 rust/kernel/iio.rs     | 341 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   2 +
 4 files changed, 368 insertions(+)
 create mode 100644 rust/helpers/iio.c
 create mode 100644 rust/kernel/iio.rs

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index a3c42e51f00a..c69a9a93367d 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -33,6 +33,7 @@
 #include "irq.c"
 #include "fs.c"
 #include "io.c"
+#include "iio.c"
 #include "jump_label.c"
 #include "kunit.c"
 #include "maple_tree.c"
diff --git a/rust/helpers/iio.c b/rust/helpers/iio.c
new file mode 100644
index 000000000000..a5402440583c
--- /dev/null
+++ b/rust/helpers/iio.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/iio/iio.h>
+
+/*
+ * iio_device_claim_direct() is a static inline in iio.h.
+ * This helper exports it as a callable symbol for Rust.
+ */
+__rust_helper bool
+rust_helper_iio_device_claim_direct(struct iio_dev *indio_dev)
+{
+	return iio_device_claim_direct(indio_dev);
+}
+
+/*
+ * iio_device_release_direct() is a macro expanding to __iio_dev_mode_unlock().
+ * This helper exports it as a callable symbol for Rust.
+ */
+__rust_helper void
+rust_helper_iio_device_release_direct(struct iio_dev *indio_dev)
+{
+	iio_device_release_direct(indio_dev);
+}
diff --git a/rust/kernel/iio.rs b/rust/kernel/iio.rs
new file mode 100644
index 000000000000..bbd34f1c819a
--- /dev/null
+++ b/rust/kernel/iio.rs
@@ -0,0 +1,341 @@
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
+        iio_info,
+        INDIO_DIRECT_MODE, //
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
+use pin_init::{pin_data, pinned_drop};
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
+///
+/// The `Send + Sync` bounds ensure the compiler rejects driver types with
+/// thread-unsafe interior mutability (e.g. `Cell`), since the IIO core may
+/// invoke `read_raw` concurrently from multiple sysfs readers.
+pub trait IioDriver: Send + Sync {
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
+// ---------------------------------------------------------------------------
+// DirectModeGuard — RAII claim on IIO direct mode
+// ---------------------------------------------------------------------------
+
+/// RAII guard that claims IIO direct mode on construction and releases it on drop.
+///
+/// This prevents concurrent access conflicts between sysfs reads and
+/// buffer/trigger operations.
+struct DirectModeGuard(*mut iio_dev);
+
+impl DirectModeGuard {
+    fn new(indio_dev: *mut iio_dev) -> Result<Self> {
+        // SAFETY: `indio_dev` is a valid pointer to a fully initialized `iio_dev`
+        // allocated by `iio_device_alloc`. `iio_device_claim_direct` returns `true`
+        // if the device is in direct mode (success), `false` if buffer mode is active.
+        let claimed = unsafe { crate::bindings::iio_device_claim_direct(indio_dev) };
+        if claimed {
+            Ok(Self(indio_dev))
+        } else {
+            Err(EBUSY)
+        }
+    }
+}
+
+impl Drop for DirectModeGuard {
+    fn drop(&mut self) {
+        // SAFETY: `self.0` was successfully claimed in `new()`. Releasing it
+        // unlocks the IIO mode lock acquired during claim.
+        unsafe {
+            crate::bindings::iio_device_release_direct(self.0);
+        }
+    }
+}
+
+// ---------------------------------------------------------------------------
+// read_raw_callback — C-to-Rust FFI trampoline
+// ---------------------------------------------------------------------------
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
+    // private data area. The `priv_` field was initialized in `Device::build_device()`.
+    let priv_ptr = unsafe { (*indio_dev).priv_ as *mut T };
+    // SAFETY: `priv_ptr` points to a valid, initialized instance of `T` that
+    // lives as long as the `iio_dev` allocation.
+    let driver = unsafe { &*priv_ptr };
+
+    // Claim direct mode via RAII guard. If the device is in buffer mode,
+    // return -EBUSY to userspace immediately.
+    let _guard = match DirectModeGuard::new(indio_dev) {
+        Ok(g) => g,
+        Err(e) => return e.to_errno(),
+    };
+
+    match driver.read_raw(chan, mask) {
+        Ok(IioVal::Int(v)) => {
+            // SAFETY: `val` is a valid pointer provided by the IIO core.
+            unsafe {
+                *val = v;
+            }
+            IIO_VAL_INT
+        }
+        Ok(IioVal::Fractional(v, v2)) => {
+            // SAFETY: `val` and `val2` are valid pointers provided by the IIO core.
+            unsafe {
+                *val = v;
+                *val2 = v2.get();
+            }
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
+// ---------------------------------------------------------------------------
+// Device — IIO device wrapper with typestate
+// ---------------------------------------------------------------------------
+
+/// Marker type for an unregistered IIO device.
+pub struct Unregistered;
+/// Marker type for a registered IIO device.
+pub struct Registered;
+
+/// A wrapped IIO device managing its C `struct iio_dev` lifetime.
+///
+/// Uses `iio_device_alloc` for allocation (no devres involvement) and
+/// manual cleanup via `Drop`: `iio_device_unregister` → `drop_in_place`
+/// for `T` → `iio_device_free`.
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
+            // SAFETY: The device was successfully registered via
+            // `__iio_device_register`. Unregistering drains all pending
+            // callbacks, ensuring no `read_raw` is in flight after this.
+            unsafe { iio_device_unregister(self.indio_dev) };
+        }
+
+        // SAFETY: `priv_` was fully initialized in `build_device` via
+        // `init.__pinned_init(priv_ptr)`. `drop_in_place` runs `T`'s destructor
+        // (including any pinned fields like Mutex). After that, `iio_device_free`
+        // calls `put_device` which decrements the kref — the underlying `iio_dev`
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
+    /// Uses `iio_device_alloc` (not `devm_*`) so that the Rust `Drop`
+    /// implementation has full control over the cleanup sequence.
+    /// The device is not yet registered; call [`register`](Self::register)
+    /// to make it visible to userspace.
+    pub fn build_device<E>(
+        dev: &device::Device,
+        name: &'static CStr,
+        init: impl PinInit<T, E>,
+    ) -> Result<Self>
+    where
+        Error: From<E>,
+    {
+        let priv_size = size_of::<T>();
+
+        // SAFETY: `dev.as_raw()` returns a valid `struct device` pointer.
+        // `iio_device_alloc` allocates an `iio_dev` with `sizeof(T)` bytes of
+        // private data. Returns NULL on failure.
+        let indio_dev = unsafe { iio_device_alloc(dev.as_raw(), priv_size as i32) };
+        if indio_dev.is_null() {
+            return Err(ENOMEM);
+        }
+
+        // SAFETY: `indio_dev` is valid and freshly allocated. `priv_` points
+        // to uninitialized memory of `sizeof(T)` bytes. `PinInit::__pinned_init`
+        // initializes `priv_` in place without reading the previous
+        // (uninitialized) contents.
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
+        // - `channels()` returns a reference to data owned by `T` in `priv_`,
+        //   which remains at a fixed address because `priv_` is heap-allocated
+        //   inside `iio_dev`.
+        unsafe {
+            (*indio_dev).name = name.as_char_ptr();
+            (*indio_dev).info = &Self::VTABLE;
+
+            let chans = (*priv_ptr).channels();
+            (*indio_dev).channels = chans.as_ptr();
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
+        // Prevent `self`'s Drop from running — ownership of `indio_dev`
+        // has been transferred to `registered_dev`.
+        forget(self);
+        Ok(registered_dev)
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

