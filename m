Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239886;
	b=hLp599+zB/GP+U2zsUv2aNie8c6Lh7LdkOuU4WExYXeS36nmKjj8y+kl00mTV5sY7ar0
	 n9yDjvq0Xc0FYJHZ/Xan5UxOYg0fDACCZoIZxKH1zt7BxnAkb3K6KbRqsn6w6KAQthWBW
	 x9bZMOgYGNgV5s19XaYSqNhwLDf5f7ajeRoBZVXUAcHtwcRMorkZg58WPLRpfWq5VuzZq
	 u5rD4KO+VHKnz/uxrGYlCnLCGeRrU6u/twvDbW/CCIj9MdikPuOPH5CboI07s9b7noYMY
	 LkObai3PQ05urLUWJH/W+cidWXlmQRlBf8ac3UjssruJ1yLDxIPU0zSPSdJLwNupSFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jGfuhn/5tnyoSv44dvWh4ZEhzqKE79bI1dn8Un7FDkU=;
	b=14lN8bap7QiUVcdm7liZOGUz98dHRUpIPZ0hV/aAj+Nv3EpSCkH7m0vWLHY2cDm7oErN
	 8ylCmKZvVgCyQM/PfRuXALy85AI32fW0E+ao8dxtgGltV29rJqfllEg4uZr8a1HcvTV7b
	 qXbWvBnyNYiWMHtRk50e2aSmC/MdMgaLNrRJESnhutJ7ZUDrqg6TZbGX4EZ5sybSdLSDX
	 SneFm1vmob0M6O99G+sK02IHB0i3BjAcf9KHRqe1VKosC2iMfaZUwu781idi7KRPRXZFw
	 2cov+T5LMca2WJQfdffxhSBFsuJw5pTZ8AeYn47jQb4/PbJLqi/2bcnXj6KLrscVjOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="JauFfX2/";
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D3606EE89
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 15:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D2D3606EE89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JauFfX2/
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15dd124bbe7so721653c88.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 07:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239885; x=1794844685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jGfuhn/5tnyoSv44dvWh4ZEhzqKE79bI1dn8Un7FDkU=;
        b=JauFfX2/kPwXo/3TGPnFd3DqgGyJgQVbytT2cNQaq/Jekjc/nysHnfTs3LMjfBWEj1
         RUI2XRbXSlccMsPHtabv3BOkK4nS/aE9rkIm5vkQE21ZRK+98LS6tXooP9ufQe7Xch2h
         OJ/LISyib4xQOueQXWeC1oXSuAFt8bFNjk360B4D+PFezNKJhuvKiZHIEZcIqAOH9Fzo
         TaDj/o8ymr8wKOU1oXmZhYCsxMr4ycFnG9UwKyJbsMi+96nVt6YSFxR3bvDmNyBRAH8M
         ISJo/jVFvlOWtiPjhwmz8Lhk9saX57LcazyRfaBixMH6ZMBhEjFIZd74haYUuuPdAFHi
         GN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239885; x=1794844685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jGfuhn/5tnyoSv44dvWh4ZEhzqKE79bI1dn8Un7FDkU=;
        b=yo3YDKaewZSSK97dKZxy2MV+vsfhwKUaMrI4/1pfjxa9uvQjlAKcXSd6PNsINqKD1J
         yhL32q8C0NV/s4BEgqmGzbV/DuUtyoMZsTCl7yj5RPNChxCwAsNSnoIhuJYLgESBLlOa
         r+7JMYxFMMHNzAhT8mUyaC1saBx9nw8F9CQtzRgMhvNUAdMm6V51/4Mea5YbIj3MJSqy
         sEJslruQYy2/I4/6gzXRAOo3cSkoHV4fJ+2ND8SXpOz6KIOef7laotqCqJcyWyEKb36J
         ZX56OUIoiCv8iDYA52ZaBwbOPRVCIqcjzjmL79QWOYayu/4zDGqeekyBUK4KJ8XyUu7G
         OcMQ==
X-Forwarded-Encrypted: i=1; AL+hErH0wF/yMog6BBNf7Idb73tle6U+ut5XvRPjitDt+ukx25Izzz4WymxZEt8Q93dTzdAPhdITCb+4720=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uGRWkLhp8xTtwb/mjP3vvsOqjYSpxSgCjUlYwKkISdwCZ/Ke3
	yt5+1Q7Uh8SuD7aZJIsQ4f/Z4Ay3NV5GiF69s9LMpROvd9xZjAhNESNB
X-Gm-Gg: AYBFou01tcni7CUbeZwO+NKfcX+32wundInPRBgHlfE7F24COyfQUt40URY3gDrW+LH
	u2gB4URARQoEcGlkez1764Az33eopeA2mwEXn3LVXvEUdE0HDiUVsnDvAz5a7dv2FiLZTgU6nza
	0g4ZEE5Rkf+UapqiYd/J7QGogqmZwkmxoRoMtnGez4SOsgmzniH1vvaRHTX7zqVC/4dsu4V3YmN
	VGkXjtJEQx1M50FxCg/x2W/x5rW1bNyWabioeEPpDOq3s2m6/PyhVoLvrl2b07AKoh6cx3H2heM
	hL/4iqnoaQhzdkX3dKo4imftTWPg+dUO7l8LqtAhCY7Q7kNAZb10pKBwUE+8yaNTOwa3qfkRAMd
	1S4iXOTrsOUuxAN99V9ET+EgAA5N5LArIoZvGQsgQdmXRp44qTdknCaC6N4CJ8j5FSaLMqdM64x
	l8ikeHZXDxu9czxFODcHNvFTOV1hvvjt9eb6w4o5MvrgN0zlrN0+APxd9QcpeQ5ZxGGpxu8FFhM
	yCMia7GSgtvV7DSs66xYOAz+CFDs724g6RDzsVbAScUafr80bVtxpgbkbSGhx/JNk6wGmTBIzlx
	IuCNUf2O2xSfipT1/umj7sZQhG1D5EY/5AjtlW5mCqLqe98bzzsKpNRWRyV6yajVTq3bSQ4=
X-Received: by 2002:a05:7022:ef07:b0:1b2:5128:df1b with SMTP id a92af1059eb24-1b39fed20f3mr7173796c88.45.1794239884680;
        Mon, 09 Nov 2026 07:58:04 -0800 (PST)
Received: from localhost.localdomain ([125.166.179.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3757214cbsm13020828c88.13.2026.11.09.07.58.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 07:58:04 -0800 (PST)
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
Subject: [RFC PATCH v7 3/4] rust: add minimal IIO subsystem abstractions
Date: Mon,  9 Nov 2026 22:57:42 +0700
Message-ID: <20261109155743.83740-4-muchamadcoirulanwar@gmail.com>
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

Add minimal Rust abstractions needed to register direct-mode IIO
devices exposing read_raw channel information.

Provide a type-safe IioChanInfo selector, IioVal return types, and an
IioDriver trait. Add a C callback trampoline that validates the channel
information selector, invokes the Rust driver, and converts IioVal into
the representation expected by the IIO core.

Use typestate to distinguish unregistered and registered devices.
Registration returns an owned registered device whose destructor
unregisters it before destroying its Rust private data and releasing
the allocation reference.

Allow private data to borrow resources tied to the bound parent
lifetime. This lets drivers capture bus-specific resources during probe
and use them directly from subsystem callbacks without recovering them
from a generic parent device.

Support read_raw in INDIO_DIRECT_MODE only. Buffers, triggers, events,
and write operations are not supported.

The registration ownership and bound-parent lifetimes are based on
Igor Korotin's rework.
Link: https://lore.kernel.org/all/179286358623.55649.5397316745104390556@linux.dev/

Suggested-by: Shuai Liu <847807867@qq.com>
Link: https://lore.kernel.org/all/tencent_173B7731E90B9624F9F82613DC3031B70907@qq.com/
Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 include/linux/iio/iio.h         |   6 +-
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/iio.rs              | 463 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 4 files changed, 471 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/iio.rs

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 9b63785d5aec..e2ffb2b35126 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -450,8 +450,10 @@ struct iio_trigger; /* forward declaration */
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
index 3791af0aadc7..c2e2fb32ebe3 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -64,6 +64,8 @@
 #include <linux/fwctl.h>
 #include <linux/fs.h>
 #include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
 #include <linux/ioport.h>
diff --git a/rust/kernel/iio.rs b/rust/kernel/iio.rs
new file mode 100644
index 000000000000..cd62b765b050
--- /dev/null
+++ b/rust/kernel/iio.rs
@@ -0,0 +1,463 @@
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
+    /// `chan` identifies the channel, and `info` selects the requested
+    /// information, such as its raw value or scale. Implementors must
+    /// capture bus-specific resources during initialization rather than
+    /// deriving them from a generic parent reference.
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
+    let priv_ptr = unsafe { (*indio_dev).priv_.cast::<T>() };
+    // SAFETY: The callback contract guarantees that `priv_ptr` points to an
+    // initialized `T` that remains valid for the duration of this callback.
+    let driver = unsafe { &*priv_ptr };
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
+
+/// Marker type for a registered IIO device.
+pub struct Registered;
+
+/// An initialized IIO device awaiting registration.
+pub struct UnregisteredDevice<T: IioDriver> {
+    device: Device<T>,
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
+        // `pin_init::raw_try_init`. `drop_in_place` runs `T`'s destructor
+        // (including any pinned fields like Mutex). After that, `iio_device_free`
+        // calls `put_device` which decrements the kref. The underlying `iio_dev`
+        // memory is only freed when kref reaches 0.
+        unsafe {
+            let priv_ptr = (*self.indio_dev).priv_.cast::<T>();
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
+    pub fn build_device<E>(
+        parent: &device::Device<Bound>,
+        name: &'static CStr,
+        modes: u32,
+        init: impl PinInit<T, E>,
+    ) -> Result<UnregisteredDevice<T>>
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
+        let priv_ptr = unsafe { (*indio_dev).priv_.cast::<T>() };
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
+        let init_result = unsafe { pin_init::raw_try_init(priv_ptr, init) };
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
+        Ok(UnregisteredDevice { device })
+    }
+}
+
+impl<T: IioDriver> UnregisteredDevice<T> {
+    /// Registers the IIO device.
+    ///
+    /// The caller owns the returned [`Device<T, Registered>`] and must keep it
+    /// alive while the registration should remain visible. Dropping it
+    /// unregisters the device and tears down the private data.
+    ///
+    /// On failure, the device is released and any successful registration is
+    /// undone.
+    #[inline]
+    pub fn register(self, module: &'static ThisModule) -> Result<Device<T, Registered>> {
+        let Self { device } = self;
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
+        Ok(registered)
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 1ab41129d557..dd883c1b374e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -85,6 +85,8 @@
 #[cfg(CONFIG_I2C = "y")]
 pub mod i2c;
 pub mod id_pool;
+#[cfg(CONFIG_IIO)]
+pub mod iio;
 #[doc(hidden)]
 pub mod impl_flags;
 pub mod init;
