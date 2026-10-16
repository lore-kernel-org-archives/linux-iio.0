Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC70B4EBAEE
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165735; cv=none; b=HJDz7qODXYa0lEthhB6jnweOeB0TZ21Q+teoLM16iUKuNOWYVRAO0+DKTL5tHXnyloaJOp7tWW+WuORVwhIRoNpWtstT2uGrPsgET+341ysFSx6qbILFOO6HGqoNC3GHt5upsL92Z6r+Oux4QgdItNz8cYxmV+x2VJTcwVvkg+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165735; c=relaxed/simple;
	bh=UG8Sh9Nc63LVOjvYQ7ahaUQhPa9WzXIdQFkymk3qm7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bv037OzMDisQyb6RdmkmSPKR9uIb4D3huNAx61enmVLMBRaKmmo5dvBYpJoPPxDisZ77sBzzBKMB/yuW3e5JmMjP+clmv6TIN86J2q+00FeJCHgJXFAXLoS568niMh3vu3/t2R0Zk/ulPYwc7jz4QQLJ119RKM96HFkCpZYZuUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sT6HuTbc; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sT6HuTbc"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ab43af5e97so1748277b3.1
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792165726; x=1792770526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vZUxOj08okgMT7INAIfWZyMWZfPfv49Hdq1zK+4ZM4Y=;
        b=sT6HuTbc1A+BaOIwgFQoy8j/jF22nMK1v+KZD9HNiMaBCrFd7y1FH1CbRgXyfyBURs
         5WUk9z7TM99BMLh+UOt6eDpcHg8gyiWTgLjb111FmS2pa9eKqyk3wJRc9LmRXqH5T/dN
         uUlFYJK1aOxG0dWDF0zo2Esy+nDyt7/3BpjLa8QeHNz35waQAGNSBxo8Ju6qxEFuD6KN
         QWdxfdPJqv1O4n+TB6Y1YvNDjnAqGDFyD6LJo6uO+XpKSe+2riHpqzsJvfYufDB0FE0T
         YV2JmbufiwV1w8tv3Iqk3RoQ4HjBnEeJ+cu5KY1zPOU7GIFzzKffas2IiSqVKwg+cbvx
         Y80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792165726; x=1792770526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vZUxOj08okgMT7INAIfWZyMWZfPfv49Hdq1zK+4ZM4Y=;
        b=Ta2syDsYy9b0QX2+zbnq3usPJQrVuNlbAz8CUsVUQiKleZW4g+RwTKlx5Z0x0uFwZb
         edu19uobmPvwRlK18FPRR4RgoS6HxKe8z6HqCf9aaYYP+/0/9D/bPnIpeBJHe/AYFUs2
         FFPKZiN2jH48vmD7pemqZ18FQupEkZ8Nem+GKwSHZDsrVIOvnwcwIZEAcQSYJBLWn7Jl
         oU/6apbmcy3Z0BzaGeEYVKTdKmw8L+9EmANtBeQFzP2K4dUpbrfL3FeZgaurUsPlCzT2
         R4stgmD20sfFBQkb7qYWLpyvYD8ilEl9qHP7YrO+baH9fMfdnC5eRmr8MZaB5FdsKR6K
         KiPQ==
X-Forwarded-Encrypted: i=1; AKwUvByhv4VOtBb7CsWg60Z1M52oD1rV2zLS5PWzHmtRIifw+iHjaDc6hIc7qXmlyDQHb5RoqXCq0GYg8Ew=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFONLsOHimfExbq82n41W/05XLK3YeB0bo9IZel1qk5/ZTT+qT
	qGeXf42IJz1biuBGkDmFMpR0KjH8OBXeI+TiWNlsFH6KqWBsxd2+i4JF
X-Gm-Gg: AYBFou0Zcj0P4W0W0HamIgY//i1X6EPcqB6Hn8d3n0ipuPLkC9GgoAHQzIdqjWL/P4d
	PzimIEghq+07TLB0vYFWlCH9I/wu3zWY/pcDNtXO1du/GSuNdKuzW9G36LEsXckxMYnyX/s4QdB
	gTJ5rtA29TT4X2zTxGEeuCZMqdS5rhYKklJ6b2a2H3aDpTmSRgve4xyY8fBr+L4+Pt/1zJSr3s0
	f1ilRmCZlgfmBA9G2E85l+QusqmXuwA8z6W+ypwPtzzy1QGgTYCPv39lx9exNlYffbPIPuKp4fh
	VXXNEmtNQU7GnmQx+2MsEKFrFLwJAOdhOZ/+MUS3fu1jVq+bRq4auM7K8876LE7uTVQSqrcXS89
	mjWzlz3wzYvPjp1Beq0gTWGfnohj0kk7FdeUMFXAm0CDDtJIIMVSFZBdJugiznz2+2wEPX/84g1
	8vjST823hjl8ul8X7kQuA2YAfpXJuZm36dYULK85PGOHs1piU/G0g2wzUMGqyk2amwgwdII0Wua
	HZEEyAtf9Xew0QuBTrRdxZxeGANsm4UKGlorIG3
X-Received: by 2002:a05:690c:60c6:b0:8b0:a01e:2cd4 with SMTP id 00721157ae682-8b0e2e248b7mr13327947b3.31.1792165725870;
        Fri, 16 Oct 2026 08:48:45 -0700 (PDT)
Received: from localhost.localdomain ([180.243.241.21])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e593c65bsm10882167b3.38.2026.10.16.08.48.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 08:48:45 -0700 (PDT)
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
Subject: [RFC PATCH v6 3/4] rust: add minimal IIO subsystem abstractions
Date: Fri, 16 Oct 2026 22:48:18 +0700
Message-ID: <20261016154819.17936-4-muchamadcoirulanwar@gmail.com>
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

Add minimal Rust abstractions needed to register direct-mode IIO
devices exposing read_raw channel information.

Provide a type-safe IioChanInfo selector, IioVal return types, and an
IioDriver trait. Add a C callback trampoline that validates the channel
information selector, invokes the Rust driver, and converts IioVal into
the representation expected by the IIO core.

Use typestate to distinguish unregistered and registered devices.
The unregistered builder borrows the bound parent. After successful
registration, transfer ownership to parent devres so that the IIO device
is unregistered during parent resource teardown, before destroying the
Rust private data and releasing the allocation reference.

Keep allocation and private-data destruction under Rust ownership;
parent devres owns the registration wrapper rather than managing the
allocation through devm_iio_device_alloc().

Accept only INDIO_DIRECT_MODE. Triggered modes require additional C-side
state that this abstraction does not initialize. In particular,
INDIO_EVENT_TRIGGERED exposes trigger selection that requires a valid
pollfunc_event.

The initial abstraction intentionally supports read_raw only. It does
not expose write_raw, buffers, triggers, events, extended attributes, or
available-value attributes.

Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 include/linux/iio/iio.h         |   6 +-
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/iio.rs              | 480 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 4 files changed, 488 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/iio.rs

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 711c00f67371..512b1829f661 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -445,8 +445,10 @@ struct iio_trigger; /* forward declaration */
  * @read_raw:		function to request a value from the device.
  *			mask specifies which value. Note 0 means a reading of
  *			the channel in question.  Return value will specify the
- *			type of value returned by the device. val and val2 will
- *			contain the elements making up the returned value.
+ *			type of value returned by the device. val and val2
+ *			point to writable integer storage valid for the
+ *			duration of the callback. The return value determines
+ *			which outputs contain meaningful data.
  * @read_raw_multi:	function to return values from the device.
  *			mask specifies which value. Note 0 means a reading of
  *			the channel in question.  Return value will specify the
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
diff --git a/rust/kernel/iio.rs b/rust/kernel/iio.rs
new file mode 100644
index 000000000000..9ad2f50948de
--- /dev/null
+++ b/rust/kernel/iio.rs
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
+//! IIO subsystem abstractions.
+//!
+//! Provides [`Device`] for allocating and registering an IIO device, and
+//! [`IioDriver`] for implementing `read_raw` callbacks. Implementing the
+//! trait requires validating the raw channel specifications.
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
+    device::{
+        self,
+        Bound, //
+    },
+    devres,
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
+
+/// IIO value type: integer plus micro part (`IIO_VAL_INT_PLUS_MICRO`).
+pub const IIO_VAL_INT_PLUS_MICRO: c_int = crate::bindings::IIO_VAL_INT_PLUS_MICRO as c_int;
+
+/// IIO value type: integer plus nano part (`IIO_VAL_INT_PLUS_NANO`).
+pub const IIO_VAL_INT_PLUS_NANO: c_int = crate::bindings::IIO_VAL_INT_PLUS_NANO as c_int;
+
+/// IIO value type: fractional (`IIO_VAL_FRACTIONAL`).
+pub const IIO_VAL_FRACTIONAL: c_int = crate::bindings::IIO_VAL_FRACTIONAL as c_int;
+
+/// Generates a Rust enum wrapper for C `enum iio_chan_info_enum`.
+///
+/// This macro creates a type-safe enum with automatic `TryFrom<u32>`
+/// conversion. Drivers match directly on `IioChanInfo` variants in
+/// `read_raw`, and the compiler enforces match exhaustiveness.
+/// Additional variants can be added as drivers require them.
+macro_rules! build_iio_chan_info_enum {
+    (
+        $(
+            $(#[$meta:meta])*
+            $rust_name:ident = $c_const:ident
+        ),* $(,)?
+    ) => {
+        /// Channel information selector for [`IioDriver::read_raw`].
+        ///
+        /// Wraps supported C `enum iio_chan_info_enum` values identifying
+        /// the requested channel information.
+        ///
+        /// Conversion from an unsupported value returns `EINVAL`.
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
+build_iio_chan_info_enum! {
+    /// Raw unprocessed value from the channel (`IIO_CHAN_INFO_RAW`).
+    ///
+    /// For sensors, this is typically the ADC reading or register value
+    /// before any scaling or offset correction.
+    Raw = iio_chan_info_enum_IIO_CHAN_INFO_RAW,
+
+    /// Scale factor for converting raw values to channel units
+    /// (`IIO_CHAN_INFO_SCALE`).
+    ///
+    /// Apply any offset before scaling: `(raw + offset) * scale`.
+    /// The unit is defined by the IIO ABI for the channel type.
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
+
+    /// A fractional value represented as `val / val2`.
+    /// The denominator is `NonZeroI32` to prevent division-by-zero in
+    /// `iio_format_value()`.
+    Fractional(i32, NonZeroI32),
+
+    /// An integer part and a fractional part in millionths
+    /// (`IIO_VAL_INT_PLUS_MICRO`).
+    ///
+    /// For negative values, put the sign on the integer part, or on the
+    /// fractional part when the integer part is zero. For example,
+    /// `IntPlusMicro(-1, 500_000)` represents -1.5, and
+    /// `IntPlusMicro(0, -500_000)` represents -0.5.
+    IntPlusMicro(i32, i32),
+
+    /// An integer part and a fractional part in billionths
+    /// (`IIO_VAL_INT_PLUS_NANO`).
+    ///
+    /// Uses the same sign convention as [`IioVal::IntPlusMicro`].
+    IntPlusNano(i32, i32),
+}
+
+/// Trait implemented by IIO driver private data.
+///
+/// # Safety
+///
+/// The channel specifications returned by `channels()` must satisfy the
+/// IIO core's requirements. Channel types, modifiers, strings, and
+/// pointer/count pairs must be valid. Referenced storage must remain
+/// valid for every access by the IIO core.
+///
+/// Channels must not expose events, buffers, extended attributes, or
+/// available-value attributes. This abstraction currently supports only
+/// channel information handled by its `read_raw` callback.
+pub unsafe trait IioDriver: Send + Sync {
+    /// Called by the IIO core to read channel information.
+    ///
+    /// `parent` is the parent device supplied to [`Device::build_device`].
+    /// `chan` identifies the channel, and `info` selects the requested
+    /// information, such as its raw value or scale.
+    fn read_raw(
+        &self,
+        parent: &device::Device<Bound>,
+        chan: *const iio_chan_spec,
+        info: IioChanInfo,
+    ) -> Result<IioVal>;
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
+/// Callers must ensure that:
+/// - `indio_dev` points to a valid `iio_dev` allocated with space for `T`.
+///   Its private data contains an initialized `T` that remains valid and
+///   may be shared for the duration of this callback.
+/// - `chan` points to a valid channel specification for `indio_dev`.
+/// - `val` and `val2` are non-null, properly aligned pointers to writable
+///   `c_int` storage valid for the duration of this callback.
+/// - The parent of `indio_dev` remains bound for the entire callback.
+///   Registration ownership and callback teardown must enforce this.
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
+    // SAFETY: The callback contract guarantees that `priv_ptr` points to an
+    // initialized `T` that remains valid for the duration of this callback.
+    let driver = unsafe { &*priv_ptr };
+
+    // SAFETY: `indio_dev` is valid by the callback contract. Its parent
+    // was supplied as a bound device to `build_device`.
+    //
+    // During registration, the builder holds that bound parent borrow.
+    // After ownership is transferred, parent devres runs the registered
+    // device's destructor, which unregisters the IIO device and drains
+    // the supported read_raw paths before destroying the private data.
+    // The parent therefore remains bound throughout this callback.
+    let parent = unsafe { device::Device::<Bound>::from_raw((*indio_dev).dev.parent) };
+
+    // `info` is `long` from C. Negative values and values > u32::MAX
+    // are unsupported iio_chan_info variants; both map to EINVAL.
+    let info_enum = match u32::try_from(info)
+        .ok()
+        .and_then(|value| IioChanInfo::try_from(value).ok())
+    {
+        Some(info) => info,
+        None => return EINVAL.to_errno(),
+    };
+
+    match driver.read_raw(parent, chan, info_enum) {
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
+
+/// Marker type for a registered IIO device.
+pub struct Registered;
+
+/// An initialized IIO device awaiting registration.
+///
+/// The parent remains bound until this builder is consumed or dropped.
+pub struct UnregisteredDevice<'a, T: IioDriver> {
+    device: Device<T>,
+    parent: &'a device::Device<Bound>,
+}
+
+/// An owned IIO device with in-place initialized driver data.
+///
+/// Dropping a registered device unregisters it before destroying the driver
+/// data. Dropping either state then releases the allocation reference with
+/// `iio_device_free`.
+///
+/// # Invariants
+///
+/// - `indio_dev` points to an `iio_dev` allocated by `iio_device_alloc`,
+///   and this wrapper owns its allocation reference.
+/// - Its private data contains an initialized `T` that remains at a fixed
+///   address until it is destroyed.
+/// - `registered` is true exactly when this wrapper owns a successful
+///   registration that has not yet been undone.
+#[pin_data(PinnedDrop)]
+pub struct Device<T: IioDriver, State = Unregistered> {
+    indio_dev: *mut iio_dev,
+    registered: bool,
+    _p: PhantomData<(T, State)>,
+}
+
+// SAFETY: Moving the wrapper transfers ownership without moving the separately
+// allocated `iio_dev` or its private data. `T: Send` permits transferring the
+// private data to another thread.
+unsafe impl<T: IioDriver, State> Send for Device<T, State> {}
+
+// SAFETY: All `&self` access to the `iio_dev` is read-only or goes through the
+// IIO core which provides its own synchronization. `T` is required to be `Sync`.
+unsafe impl<T: IioDriver, State> Sync for Device<T, State> {}
+
+#[pinned_drop]
+impl<T: IioDriver, State> PinnedDrop for Device<T, State> {
+    fn drop(self: Pin<&mut Self>) {
+        if self.registered {
+            // SAFETY: `__iio_device_register` succeeded.
+            //
+            // iio_device_unregister() deletes the character device, disables
+            // buffers, clears `info` while holding `info_exist_lock`, and removes
+            // the remaining buffer sysfs state. Device removal also removes and
+            // drains its sysfs files. In-kernel read helpers that use
+            // `info_exist_lock` cannot race this `info` teardown.
+            //
+            // Any callback path not covered by those mechanisms requires a
+            // separate teardown proof before this abstraction can expose it.
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
+    /// Allocates an unregistered IIO device and initializes its driver data
+    /// in place.
+    ///
+    /// `parent` becomes the IIO device's parent. `name` supplies its name.
+    /// Only `INDIO_DIRECT_MODE` is supported.
+    ///
+    /// Returns `EINVAL` if `modes` is not `INDIO_DIRECT_MODE`, if the
+    /// private-data size or channel count cannot be represented by the
+    /// corresponding C type, if `T` is zero-sized, or if the private
+    /// storage is not suitably aligned.
+    /// Allocation and initialization errors are propagated.
+    ///
+    /// Call [`UnregisteredDevice::register`] to register the device.
+    pub fn build_device<'a, E>(
+        parent: &'a device::Device<Bound>,
+        name: &'static CStr,
+        modes: u32,
+        init: impl PinInit<T, E>,
+    ) -> Result<UnregisteredDevice<'a, T>>
+    where
+        Error: From<E>,
+    {
+        if modes != INDIO_DIRECT_MODE {
+            return Err(EINVAL);
+        }
+
+        let modes = c_int::try_from(modes).map_err(|_| EINVAL)?;
+
+        let priv_size = i32::try_from(size_of::<T>()).map_err(|_| EINVAL)?;
+        if priv_size == 0 {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: `parent.as_raw()` returns a valid `struct device` pointer.
+        // `iio_device_alloc` allocates an `iio_dev` with `sizeof(T)` bytes of
+        // private data. Returns NULL on failure.
+        let indio_dev = unsafe { iio_device_alloc(parent.as_raw(), priv_size) };
+        if indio_dev.is_null() {
+            return Err(ENOMEM);
+        }
+
+        // SAFETY: `indio_dev` is non-null and was just successfully allocated by
+        // `iio_device_alloc`. Accessing `priv_` yields a pointer to zeroed
+        // memory (kzalloc'd) sized for `T`.
+        let priv_ptr = unsafe { (*indio_dev).priv_ as *mut T };
+        if !priv_ptr.is_aligned() {
+            // SAFETY: `indio_dev` was allocated by `iio_device_alloc` and `priv_`
+            // has not been initialized, so no destructor needs to run.
+            unsafe { iio_device_free(indio_dev) };
+            return Err(EINVAL);
+        }
+
+        // SAFETY: `priv_ptr` is aligned and points to exclusively owned storage
+        // large enough for `T`. The private data remains at a fixed address in
+        // the separate IIO allocation until it is dropped. On initialization
+        // failure, the error path only frees the allocation.
+        let init_result = unsafe { init.__pinned_init(priv_ptr) };
+        if let Err(e) = init_result {
+            // SAFETY: `pin_init` guarantees partial-init rollback internally.
+            // `priv_` memory was not fully initialized, so we only free the
+            // container without running `T`'s destructor.
+            unsafe { iio_device_free(indio_dev) };
+            return Err(Error::from(e));
+        }
+
+        let device = Self {
+            indio_dev,
+            registered: false,
+            _p: PhantomData,
+        };
+
+        // SAFETY: `priv_ptr` points to the initialized `T` owned by `device`.
+        // It remains valid for this shared borrow.
+        let channels = unsafe { (&*priv_ptr).channels() };
+        let num_channels = c_int::try_from(channels.len()).map_err(|_| EINVAL)?;
+
+        // SAFETY: `priv_ptr` is now fully initialized. We set up the IIO
+        // device fields:
+        // - `name` is a `'static` C string that outlives the device.
+        // - The reference to `VTABLE` is promoted to static storage.
+        // - `channels()` returns a static slice, so its backing storage
+        //   outlives the `iio_dev` allocation.
+        // - `modes` was checked to be `INDIO_DIRECT_MODE`, so registration
+        //   does not expose unsupported buffer or trigger paths.
+        // - `T`'s `IioDriver` safety contract guarantees that the channel
+        //   specifications and their referenced storage satisfy the IIO
+        //   core's requirements.
+
+        unsafe {
+            (*indio_dev).name = name.as_char_ptr();
+            (*indio_dev).info = &Self::VTABLE;
+            (*indio_dev).channels = channels.as_ptr();
+            (*indio_dev).num_channels = num_channels;
+            (*indio_dev).modes = modes;
+        }
+
+        Ok(UnregisteredDevice { device, parent })
+    }
+}
+
+impl<T: IioDriver + 'static> UnregisteredDevice<'_, T> {
+    /// Registers the IIO device and transfers ownership to parent devres.
+    ///
+    /// Parent resource teardown unregisters the device and completes its
+    /// supported `read_raw` callbacks before destroying the private data.
+    ///
+    /// On failure, the device is released and any successful registration is
+    /// undone.
+    #[inline]
+    pub fn register(self, module: &'static ThisModule) -> Result {
+        let Self { device, parent } = self;
+
+        // SAFETY: `device.indio_dev` is a valid, fully-initialized `iio_dev`
+        // allocated by `iio_device_alloc` with its name, info vtable, channels,
+        // modes, and private data all set. `module.as_ptr()` provides the owning
+        // module for proper reference counting.
+        to_result(unsafe { __iio_device_register(device.indio_dev, module.as_ptr()) })?;
+
+        let registered: Device<T, Registered> = Device {
+            indio_dev: device.indio_dev,
+            registered: true,
+            _p: PhantomData,
+        };
+        forget(device);
+
+        devres::register(parent, registered, GFP_KERNEL)
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

