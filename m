Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F7249363B
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787380077; cv=none; b=Mfu0vxIJtWvuxxCNV02Asw+nj1ldMyPIn1rXmttaJhBv03HzAoXHFAgwzJEJbhbBrtcg9l7P+ijyZNm59y+8PQhON1sTA4GxFXlBV+qqCnDEso9I6EAmKgRO7cLMoU0H04YaBzto3LPkIlrqy8DXKy2RneaYz3kbmFzIDr2+iMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787380077; c=relaxed/simple;
	bh=vjRqYYnhcfNgjItxrYT6am9JhPP/wKbR3RjqpN/iHak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFY6bIRgwU3oW77bde90kPI3r+OZO2rwdJ6LGdR3N/ihwNZrXPtN6eAnC7se9HKXTydqR+ddqhQK0l5gX9aaJKHeohKc0s3ECEucAd45e7Ye2sEQ99p4E4QUqiey7zL4IqFySSX9TrEw+TQrhsKfYtZwRxe4WmpdwGR53vXKO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJXvpweB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJXvpweB"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1846173a91.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 23:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787380074; x=1787984874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mTH0bdFu9fBUipWB3iUqAsha3nAp1jMUuHB4uD0PsvQ=;
        b=cJXvpweBVWdXNJTW0GLXY922GvBVyX9nxgT7/DEK5zVw94K4zCkFbTi/mxuKoVaETP
         l6O7N32wN6bdCb226RlKOV6urgHL2KdPEL1CFGWzq9vSfmcgMHYUoS78SB42AHIwmsdD
         UpJ6w9f1QdYm5eE27rtzOKvPBgdCe6/j+Vt2e00jl5gMCDBh8reMTXOuUbJnd1DmC1dK
         +PlCtWCsZzcA+cErpW8UPHJ2SuMz9bImSlET1jCGSOSIKY66Viy66GcMcxFID2UZsJhB
         XkSYZ6mMU8WFE4QOTVeMQdYueAquLvo1JTipe8NO7VpJs8USY64T0FW3JKWIwvvG8IXI
         df9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787380074; x=1787984874;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mTH0bdFu9fBUipWB3iUqAsha3nAp1jMUuHB4uD0PsvQ=;
        b=nPDN2UXeb0hsy4m3sx+ATcWmB/ywLTkOZkAt7MnTRxny8qr2Q5e+CG8wF4daJUA7Rh
         DNsmeYnhnxRn+JrGIDBCVHE/dtv32/gDx2Z8bS4AFb0r5zgTUgjq1Y+bph/MyfpOGUvE
         pRRVWgTyvHi0OXMY/SvP4gV5Bcgiqz6Z1CLcUTZAKIPpwdjj/qiKuGQk7uu60zH1H5fr
         FF/CJQEhUOIjNIYALEZcsMStKKKYvPl6DwBhVSSkPq/iTDMILt/UycW+xblNoAAHf7lQ
         OkfC6G9qPhOPWJCrsKYaSzv8fGF31iWCTVjYsQXdhYd/S8q443oW/zDrz5NYnD+uNZPA
         63OQ==
X-Gm-Message-State: AFuF++nCwtKMxavRtNNJaVz/xYFoV3u1FXe5Osamr70hI5DYi0i6YD6F
	+oXIwQj+jRmRQrTaoOeQx0dsHIajYZkzVjhIaB3kFmFz5A16XBfsP3sd
X-Gm-Gg: AR+sD11GtG+aN4mvbYm6wb00jahNc6pn+KFo2U2v/bSGJoHReBj6tJRByEivq7WR7D9
	IagDvooMd5JkWAo3n2u6njxFj4rG37Gbqr0Ck6fHfHyrCQeqfZzzoIGd2XIHyXcYLob2WJZKa7T
	mVvWw1sh9mhUSTF/6b/D4i5XRwnkLg3PGuVdMwOYk8kGuAsZMknQETdJgc4zZOMqYvEGBovm27i
	mOPkh1FeipRHoonzXcUqtcN5sH0ChYcVKh8lSx8t7Gz73sbamUpjcLyLxdk29nNmf4l9aAYhZEf
	+r1Stu39HG4/lPYhkia+YV6sQLMo2NbX1CXbHZgZT0LiKFH/7+b+sOF1S1SsMdX785bP1yxcNIv
	iiX5pBbkAWnWhYxluYkNtwal6y/w1WNifmmDVSu8OwXhXIeuRQQySkMNKjiBm5IAbE+pIVTZwg4
	HOBCJE1KuFOKJSqtutkQCV4T6Wyn0QWPBi6UZrbf5uZKQdWxyCDpILucGuxhGbu2G6ohzRBTCI4
	QTHvLCtoqvMgqvO9L5zR0iqxpL7EtYf7DEs+w==
X-Received: by 2002:a17:90b:560e:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-395df617b34mr7689355a91.13.1787380074009;
        Fri, 21 Aug 2026 23:27:54 -0700 (PDT)
Received: from 192.168.1.20 ([2402:8780:104c:d93:50df:47ce:56b8:7bd1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c9128498sm1788519a91.2.2026.08.21.23.27.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 23:27:53 -0700 (PDT)
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
Subject: [RFC PATCH v5 1/3] i2c: rust: implement SMBus access via IoBackend and FallibleIoCapable
Date: Sat, 22 Aug 2026 14:26:56 +0800
Message-ID: <20260822062725.60519-2-muchamadcoirulanwar@gmail.com>
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

Implement SMBus byte and word read/write operations for I2cClient using
the FallibleIoCapable trait from the generic I/O backend infrastructure.

I2cClient now exposes an I2cBackend that implements FallibleIoCapable<u8>
and FallibleIoCapable<u16>, replacing the previous IoCapable approach.
I2C/SMBus bus transactions are inherently fallible (NACK, arbitration
loss, timeout), so the infallible IoCapable is not appropriate here.
FallibleIoCapable carries the errno from i2c_smbus_read_byte_data and
i2c_smbus_read_word_data directly to the caller via Result<T>.

The implementation is restricted to I2cClient<Bound> as I/O operations
require a live device context.

I2cClient<Bound>::smbus_io() returns an I2cView handle for use with the
generic try_read8/try_read16 methods. Two standalone methods are also
provided for odd-offset word access that bypasses the alignment check
in the Io trait:

  smbus_read_word()        - CPU-native byte order (SMBus LE wire format)
  smbus_read_word_swapped() - byte-swapped result for big-endian devices

maxsize is 256, covering the SMBus command byte range 0x00-0xFF. This
is the command byte space, not the 7-bit device address which is handled
by the I2C core at adapter level.

Link: https://lore.kernel.org/rust-for-linux/20260131-i2c-adapter-v1-4-5a436e34cd1a@gmail.com/
Link: https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/commit/?h=driver-core-testing&id=121d87b28e1d9061d3aaa156c43a627d3cb5e620
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 rust/kernel/bits.rs |  29 +++++
 rust/kernel/i2c.rs  | 302 ++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/io.rs   |  66 +++++++---
 3 files changed, 377 insertions(+), 20 deletions(-)

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
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 624b971ca8b0..f939907573a6 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -14,8 +14,15 @@
     devres::Devres,
     driver,
     error::*,
+    io::{
+        FallibleIoCapable,
+        IoBackend,
+        IoBase,
+        Region, //
+    },
     of,
     prelude::*,
+    ptr::KnownSize,
     sync::aref::{
         ARef,
         AlwaysRefCounted, //
@@ -601,3 +608,298 @@ unsafe impl Send for Registration {}
 // SAFETY: `Registration` offers no interior mutability (no mutation through &self
 // and no mutable access is exposed)
 unsafe impl Sync for Registration {}
+
+// SAFETY: `I2cClient<Bound>` wraps a kernel `struct i2c_client`. The I2C core
+// and bus locking mechanisms ensure that the underlying client structure can
+// be safely transferred between threads.
+unsafe impl Send for I2cClient<device::Bound> {}
+
+// SAFETY: `I2cClient<Bound>` wraps a kernel `struct i2c_client`. All methods
+// that access the client go through kernel I2C core functions that provide
+// their own synchronization. No &self method exposes interior mutability.
+unsafe impl Sync for I2cClient<device::Bound> {}
+
+// SAFETY: `I2cClient<Bound>` is always reference-counted via the embedded
+// `struct device`. `get_device`/`put_device` increment and decrement the
+// device refcount atomically. A separate impl is needed for `I2cClient<Bound>`
+// because `AlwaysRefCounted` is not implemented generically over all
+// `DeviceContext`s — only the specific contexts that are safe to refcount
+// from arbitrary threads.
+unsafe impl AlwaysRefCounted for I2cClient<device::Bound> {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
+        unsafe { bindings::get_device(self.as_ref().as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::put_device(&raw mut (*obj.as_ref().as_raw()).dev) }
+    }
+}
+
+/// I/O backend for SMBus register access via I2C.
+///
+/// This backend implements only [`FallibleIoCapable`] and not [`IoCapable`],
+/// because I2C/SMBus bus transactions are inherently fallible — NACK,
+/// arbitration loss, and timeout can occur regardless of address validity.
+/// The infallible [`Io::read`], [`Io::write`], and [`Io::update`] methods
+/// are therefore compile-time unavailable for this backend.
+pub struct I2cBackend;
+
+/// View type for [`I2cBackend`], carrying a reference to an I2C client and
+/// a fake pointer that encodes the register offset and address-space size
+/// as fat-pointer metadata.
+///
+/// The pointer field is never dereferenced. After [`IoBackend::project_view`]
+/// projects an offset into the pointer, `addr()` yields that offset as the
+/// SMBus command byte. [`KnownSize::size()`] reads the fat-pointer metadata
+/// length (256 for the SMBus command space).
+///
+/// # Invariants
+///
+/// `ptr` is a non-dereferenceable fat pointer. Its address component encodes
+/// the SMBus register offset (0..=255) after [`IoBackend::project_view`]
+/// projection; its length metadata is 256 (the SMBus command byte address
+/// space). `client` points to a valid `I2cClient<Bound>` that remains live
+/// for `'a`.
+pub struct I2cView<'a, T: ?Sized> {
+    client: &'a I2cClient<device::Bound>,
+    ptr: *mut T,
+}
+
+impl<T: ?Sized> Copy for I2cView<'_, T> {}
+
+impl<T: ?Sized> Clone for I2cView<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl IoBackend for I2cBackend {
+    type View<'a, T: ?Sized + KnownSize> = I2cView<'a, T>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        view.ptr
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        // INVARIANT: Per safety requirement.
+        I2cView {
+            client: view.client,
+            ptr,
+        }
+    }
+}
+
+impl FallibleIoCapable<u8> for I2cBackend {
+    #[inline]
+    fn io_try_read<'a>(view: I2cView<'a, u8>) -> Result<u8> {
+        // `io_view()` ensures `offset + 1 <= 256`, so `addr()` is at most 255;
+        // the `as u8` cast below is therefore lossless.
+        let reg = Self::as_ptr(view).addr() as u8;
+        // SAFETY: `view.client.as_raw()` returns a valid `*mut struct i2c_client`
+        // pointer as guaranteed by the type invariant of `I2cClient`.
+        // `i2c_smbus_read_byte_data` is safe to call with any valid client pointer
+        // and any u8 command byte.
+        let ret = unsafe { bindings::i2c_smbus_read_byte_data(view.client.as_raw(), reg) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u8)
+        }
+    }
+
+    #[inline]
+    fn io_try_write<'a>(view: I2cView<'a, u8>, value: u8) -> Result {
+        // `io_view()` ensures `offset + 1 <= 256`, so `addr()` is at most 255;
+        // the `as u8` cast below is therefore lossless.
+        let reg = Self::as_ptr(view).addr() as u8;
+        // SAFETY: `view.client.as_raw()` returns a valid `*mut struct i2c_client`
+        // pointer as guaranteed by the type invariant of `I2cClient`.
+        // `i2c_smbus_write_byte_data` is safe to call with any valid client pointer
+        // and any u8 command byte and value.
+        let ret = unsafe { bindings::i2c_smbus_write_byte_data(view.client.as_raw(), reg, value) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
+}
+
+impl FallibleIoCapable<u16> for I2cBackend {
+    #[inline]
+    fn io_try_read<'a>(view: I2cView<'a, u16>) -> Result<u16> {
+        // `io_view()` ensures `offset + 2 <= 256`, so `addr()` is at most 254;
+        // the `as u8` cast below is therefore lossless.
+        let reg = Self::as_ptr(view).addr() as u8;
+        // SAFETY: `view.client.as_raw()` returns a valid `*mut struct i2c_client`
+        // pointer as guaranteed by the type invariant of `I2cClient`.
+        // `i2c_smbus_read_word_data` is safe to call with any valid client pointer
+        // and any u8 command byte.
+        let ret = unsafe { bindings::i2c_smbus_read_word_data(view.client.as_raw(), reg) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u16)
+        }
+    }
+
+    #[inline]
+    fn io_try_write<'a>(view: I2cView<'a, u16>, value: u16) -> Result {
+        // `io_view()` ensures `offset + 2 <= 256`, so `addr()` is at most 254;
+        // the `as u8` cast below is therefore lossless.
+        let reg = Self::as_ptr(view).addr() as u8;
+        // SAFETY: `view.client.as_raw()` returns a valid `*mut struct i2c_client`
+        // pointer as guaranteed by the type invariant of `I2cClient`.
+        // `i2c_smbus_write_word_data` is safe to call with any valid client pointer
+        // and any u8 command byte and u16 value.
+        let ret = unsafe { bindings::i2c_smbus_write_word_data(view.client.as_raw(), reg, value) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for I2cView<'a, T> {
+    type Backend = I2cBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> I2cView<'a, T> {
+        self
+    }
+}
+
+// SAFETY: `I2cView` contains `&'a I2cClient<Bound>` (which is `Send` because
+// `I2cClient<Bound>: Sync`) and `*mut T`. The raw pointer is never
+// dereferenced — it only encodes the SMBus register offset as its address.
+// With `T: Sync`, moving the view to another thread cannot cause data races.
+unsafe impl<T: ?Sized + Sync> Send for I2cView<'_, T> {}
+
+// SAFETY: `I2cView` contains `&'a I2cClient<Bound>` (which is `Sync`) and
+// `*mut T`. The raw pointer is never dereferenced; sharing an `&I2cView`
+// across threads is equivalent to sharing `&I2cClient<Bound>` and a
+// read-only address value. `T: Sync` ensures the addressed data is
+// safe to access from multiple threads.
+unsafe impl<T: ?Sized + Sync> Sync for I2cView<'_, T> {}
+
+impl I2cClient<device::Bound> {
+    /// Returns an I/O handle for SMBus register access on this I2C client.
+    ///
+    /// The returned handle provides fallible read/write methods for the
+    /// 256-byte SMBus command address space (0x00–0xFF). This is the SMBus
+    /// command byte range, NOT the 7-bit device address, which is handled
+    /// by the I2C core at the adapter level.
+    ///
+    /// Note: [`Io::try_read16`] and [`Io::try_write16`] on the returned handle
+    /// reject odd offsets. The underlying [`Region`] base address is 0, so
+    /// [`offset_valid`] checks `(0 + offset) % 2 == 0` — only even offsets
+    /// pass. For word-sized access to odd-offset registers use
+    /// [`smbus_read_word`] or [`smbus_read_word_swapped`] instead.
+    ///
+    /// The underlying pointer in the returned [`I2cView`] is never
+    /// dereferenced; it encodes the register address space size as
+    /// fat-pointer metadata and the register offset as the pointer address.
+    ///
+    /// [`smbus_read_word`]: Self::smbus_read_word
+    /// [`smbus_read_word_swapped`]: Self::smbus_read_word_swapped
+    #[inline]
+    pub fn smbus_io(&self) -> I2cView<'_, Region<256>> {
+        // INVARIANT: `client` is `self`, a valid `I2cClient<Bound>`.
+        //
+        // `ptr` is a "fake pointer" — it is constructed solely to carry two
+        // pieces of metadata through the `IoBase` machinery:
+        //   - address component: 0 initially; after each `project_view` call,
+        //     this becomes the register offset (the SMBus command byte).
+        //   - length metadata: 256, encoding the SMBus command address space
+        //     size so `io_view()` can bounds-check offsets.
+        //
+        // `without_provenance_mut(0)` produces a pointer with no memory
+        // provenance — it cannot be used to read or write memory. This is safe
+        // because `I2cBackend::as_ptr()` extracts the address as a `usize`
+        // offset and passes it to `i2c_smbus_*` functions, never dereferencing
+        // the pointer itself. Using a provenance-free base avoids accidentally
+        // creating a pointer that appears to alias real memory.
+        I2cView {
+            client: self,
+            ptr: Region::<256>::ptr_from_raw_parts_mut(core::ptr::without_provenance_mut(0), 256),
+        }
+    }
+
+    /// Reads a 16-bit word from an SMBus register in CPU-native byte order.
+    ///
+    /// Wraps `i2c_smbus_read_word_data`. The `reg` parameter is the SMBus
+    /// command byte (0x00–0xFF) — an instruction sent to the device over the
+    /// serial bus, not a memory address. There is no alignment requirement:
+    /// any command byte value is valid regardless of whether it is odd or even.
+    ///
+    /// SMBus transmits the low byte first (little-endian on the wire), and this
+    /// method returns the value in CPU-native byte order without further
+    /// conversion. Use [`Self::smbus_read_word_swapped`] for devices that store
+    /// multi-byte registers in big-endian (MSB-first) format.
+    ///
+    /// Returns `Err` if the bus transaction fails (e.g. NACK, arbitration loss,
+    /// or timeout).
+    #[inline]
+    pub fn smbus_read_word(&self, reg: u8) -> Result<u16> {
+        // SAFETY: `self.as_raw()` returns a valid `*mut struct i2c_client`
+        // pointer as guaranteed by the type invariant of `I2cClient`.
+        // `i2c_smbus_read_word_data` is safe to call with any valid client
+        // pointer and any u8 command byte.
+        let ret = unsafe { bindings::i2c_smbus_read_word_data(self.as_raw(), reg) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u16)
+        }
+    }
+
+    /// Reads a 16-bit word from an SMBus register with bytes unconditionally
+    /// swapped.
+    ///
+    /// Wraps `i2c_smbus_read_word_data` and applies [`u16::swap_bytes`] to the
+    /// result. Use this for devices that store multi-byte registers in
+    /// big-endian (MSB-first) format, which is common among I2C sensors whose
+    /// datasheets do not reference the SMBus specification.
+    ///
+    /// The swap is **unconditional** — it is not equivalent to `be16_to_cpu`.
+    /// On a big-endian CPU, `be16_to_cpu` would be a no-op, but this method
+    /// still swaps. The reason: SMBus always transmits the low byte first, so
+    /// the driver always receives data in little-endian wire order regardless
+    /// of CPU endianness. The swap corrects for the device's wire-level byte
+    /// order, not the CPU's native order.
+    ///
+    /// The `reg` parameter is the SMBus command byte (0x00–0xFF). There is no
+    /// alignment requirement; any command byte value is valid.
+    ///
+    /// Returns `Err` if the bus transaction fails (e.g. NACK, arbitration loss,
+    /// or timeout).
+    ///
+    /// # Example
+    ///
+    /// ```ignore
+    /// // AS5600 stores the 12-bit raw angle big-endian at register 0x0C.
+    /// let raw = client.smbus_read_word_swapped(0x0C)?;
+    /// let angle = raw & 0x0FFF;
+    /// ```
+    #[inline]
+    pub fn smbus_read_word_swapped(&self, reg: u8) -> Result<u16> {
+        // SAFETY: `self.as_raw()` returns a valid `*mut struct i2c_client`
+        // pointer as guaranteed by the type invariant of `I2cClient`.
+        let ret = unsafe { bindings::i2c_smbus_read_word_data(self.as_raw(), reg) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok((ret as u16).swap_bytes())
+        }
+    }
+}
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 95f46bb75f9e..516895ca2082 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -276,6 +276,36 @@ pub trait IoCapable<T>: IoBackend {
     fn io_write<'a>(view: Self::View<'a, T>, value: T);
 }
 
+/// Fallible counterpart of [`IoCapable`] for I/O backends where operations can fail at the
+/// transport level (e.g. I2C, SPI).
+///
+/// Infallible backends ([`IoCapable`] implementors) get this for free via blanket implementation.
+/// Fallible-only backends implement this trait directly without implementing [`IoCapable`]; the
+/// infallible [`Io::read`], [`Io::write`], and [`Io::update`] methods will then be unavailable,
+/// enforcing that callers use the `try_*` variants instead.
+pub trait FallibleIoCapable<T>: IoBackend {
+    /// Performs an I/O read of type `T` at `view` and returns the result, or an error if the
+    /// transport-level operation fails.
+    fn io_try_read<'a>(view: Self::View<'a, T>) -> Result<T>;
+
+    /// Performs an I/O write of `value` at `view`, or returns an error if the transport-level
+    /// operation fails.
+    fn io_try_write<'a>(view: Self::View<'a, T>, value: T) -> Result;
+}
+
+impl<B: IoCapable<T>, T> FallibleIoCapable<T> for B {
+    #[inline(always)]
+    fn io_try_read<'a>(view: Self::View<'a, T>) -> Result<T> {
+        Ok(Self::io_read(view))
+    }
+
+    #[inline(always)]
+    fn io_try_write<'a>(view: Self::View<'a, T>, value: T) -> Result {
+        Self::io_write(view, value);
+        Ok(())
+    }
+}
+
 /// Trait indicating that an I/O backend supports memory copy operations.
 pub trait IoCopyable: IoBackend {
     /// Copy contents of `view` to `buffer`.
@@ -645,7 +675,7 @@ fn copy_to_slice(self, data: &mut [u8])
     fn try_read8(self, offset: usize) -> Result<u8>
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
-        Self::Backend: IoCapable<u8>,
+        Self::Backend: FallibleIoCapable<u8>,
     {
         self.try_read(offset)
     }
@@ -655,7 +685,7 @@ fn try_read8(self, offset: usize) -> Result<u8>
     fn try_read16(self, offset: usize) -> Result<u16>
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
-        Self::Backend: IoCapable<u16>,
+        Self::Backend: FallibleIoCapable<u16>,
     {
         self.try_read(offset)
     }
@@ -665,7 +695,7 @@ fn try_read16(self, offset: usize) -> Result<u16>
     fn try_read32(self, offset: usize) -> Result<u32>
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
-        Self::Backend: IoCapable<u32>,
+        Self::Backend: FallibleIoCapable<u32>,
     {
         self.try_read(offset)
     }
@@ -675,7 +705,7 @@ fn try_read32(self, offset: usize) -> Result<u32>
     fn try_read64(self, offset: usize) -> Result<u64>
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
-        Self::Backend: IoCapable<u64>,
+        Self::Backend: FallibleIoCapable<u64>,
     {
         self.try_read(offset)
     }
@@ -685,7 +715,7 @@ fn try_read64(self, offset: usize) -> Result<u64>
     fn try_write8(self, value: u8, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
-        Self::Backend: IoCapable<u8>,
+        Self::Backend: FallibleIoCapable<u8>,
     {
         self.try_write(offset, value)
     }
@@ -695,7 +725,7 @@ fn try_write8(self, value: u8, offset: usize) -> Result
     fn try_write16(self, value: u16, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
-        Self::Backend: IoCapable<u16>,
+        Self::Backend: FallibleIoCapable<u16>,
     {
         self.try_write(offset, value)
     }
@@ -705,7 +735,7 @@ fn try_write16(self, value: u16, offset: usize) -> Result
     fn try_write32(self, value: u32, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
-        Self::Backend: IoCapable<u32>,
+        Self::Backend: FallibleIoCapable<u32>,
     {
         self.try_write(offset, value)
     }
@@ -715,7 +745,7 @@ fn try_write32(self, value: u32, offset: usize) -> Result
     fn try_write64(self, value: u64, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
-        Self::Backend: IoCapable<u64>,
+        Self::Backend: FallibleIoCapable<u64>,
     {
         self.try_write(offset, value)
     }
@@ -827,10 +857,10 @@ fn write64(self, value: u64, offset: usize)
     fn try_read<T, L>(self, location: L) -> Result<T>
     where
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: FallibleIoCapable<L::IoType>,
     {
         let view = io_view::<Self, L::IoType>(self, location.offset())?;
-        Ok(Self::Backend::io_read(view).into())
+        Ok(Self::Backend::io_try_read(view)?.into())
     }
 
     /// Generic fallible write with runtime bounds check.
@@ -860,12 +890,11 @@ fn try_read<T, L>(self, location: L) -> Result<T>
     fn try_write<T, L>(self, location: L, value: T) -> Result
     where
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: FallibleIoCapable<L::IoType>,
     {
         let view = io_view::<Self, L::IoType>(self, location.offset())?;
         let io_value = value.into();
-        Self::Backend::io_write(view, io_value);
-        Ok(())
+        Self::Backend::io_try_write(view, io_value)
     }
 
     /// Generic fallible write of a fully-located register value.
@@ -905,7 +934,7 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     where
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: FallibleIoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
 
@@ -938,16 +967,13 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     fn try_update<T, L, F>(self, location: L, f: F) -> Result
     where
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: FallibleIoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
         let view = io_view::<Self, L::IoType>(self, location.offset())?;
-
-        let value: T = Self::Backend::io_read(view).into();
+        let value: T = Self::Backend::io_try_read(view)?.into();
         let io_value = f(value).into();
-        Self::Backend::io_write(view, io_value);
-
-        Ok(())
+        Self::Backend::io_try_write(view, io_value)
     }
 
     /// Generic infallible read with compile-time bounds check.
-- 
2.50.0

