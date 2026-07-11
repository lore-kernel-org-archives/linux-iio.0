Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27EE284690;
	Sat, 11 Jul 2026 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783771511; cv=none; b=K7CzuPnfani3BnjRa8L5BuxD6tVaC+3z7d8YMYzfOj6E6IL5byW4/pUSAG/1+6jFjqkHvaA9Ov14kkU7XCmUSEBtEfAP+7HtO1W07d9t0D2jqtKtaQlIpl0yO1tOYZDwb5o1h2omFkp5cEsby2xkHDTqu4PaTfaXdmGiBUACL00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783771511; c=relaxed/simple;
	bh=9FNHew7TQl+z47xLw1XGH03834X5HAl0D93EsZ+emS8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=dW0rK0nJ9YmC3ZYJTn55N1MCq0cmh5ZJa61ZlmQSf7gSS/z22tLto33pnyGDr7+IJUsVZgzLaFy3DhKBJeXo6FWnoZ3SaCoNC0xa3CN5fXbZFtFGZfBCpwpiyuOeq2KDU6k9k45wNffZAZimXVXN5ZFCgYAIk/onqIducPN2Nfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5k7NTmF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5k7NTmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1CA1F00A3A;
	Sat, 11 Jul 2026 12:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783771509;
	bh=ZpHlyDMjqQkbH+/rmqAOFSI05a1VBfaY7T9lPbgj598=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=c5k7NTmFQtvvbl3DvbAhY7Nnt2kKiFNpeisbhlJ4skgwJ1FoCH3VfcZ3e4S+m/aQ5
	 v7/rDEESeKvtZnbQ6xLKEwAVyIwF+dlGTsdV9HMy70HAjEnOZN4CuNlI9D7KGWL+BC
	 kp1PVkOEc8jOjH8BQuGjd8FjCWSRRSGDUsvB2tCKRWRyfWB3EY9YH6NtZNkV+wlcTZ
	 krI0vdWsGrIdGIC11ONd/wB8tcUuqaQjtfmCLkqbA2zIZJFoHoEDN3vssRlq2RtU1i
	 9tpWnuMAjTSRcIKo0iRTt98sWPjJdoRTgX15tGBS+vy5tHBw0o1oLn0mztwHmFMphE
	 ycIGk4ZnkYQ5g==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jul 2026 14:05:05 +0200
Message-Id: <DJVQ852J7SOH.26YBIJTQ9B66G@kernel.org>
Cc: <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
 <andi.shyti@kernel.org>, <wsa+renesas@sang-engineering.com>,
 <ojeda@kernel.org>, <branstj@gmail.com>, "Muchamad Coirul Anwar"
 <muchamadcoirulanwar@gmail.com>
To: "Igor Korotin" <igor.korotin@linux.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [RFC PATCH v4 1/3] i2c: rust: implement SMBus read abstraction
 via kernel::io::Io for I2cClient
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-2-muchamadcoirulanwar@gmail.com>
 <178376430529.16552.7043868463863908196@linux.dev>
In-Reply-To: <178376430529.16552.7043868463863908196@linux.dev>

On Sat Jul 11, 2026 at 12:05 PM CEST, Igor Korotin wrote:
> Thanks for reworking this to use `Io` as agreed -- the direction is right=
.
> But I think the fix is incomplete, and it points at something I'd like
> Danilo's take on.

The reason this should go through the generic I/O backend infrastructure is=
 that
we want this to be able take advantage of the register!() framework.

You are right that currently fallible I/O is not supported. However, this s=
hould
easily be fixable by rebasing on top of the latest I/O work [1], plus the
adjustments in [2].

With this, the posted code becomes something like this:

	pub struct I2cBackend;
=09
	pub struct I2cView<'a, T: ?Sized> {
	    client: &'a I2cClient<Bound>,
	    ptr: *mut T,
	}
=09
	impl<T: ?Sized> Copy for I2cView<'_, T> {}
=09
	impl<T: ?Sized> Clone for I2cView<'_, T> { ... }
=09
	impl IoBackend for I2cBackend {
	    type View<'a, T: ?Sized + KnownSize> =3D I2cView<'a, T>;
=09
	    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut =
T {
	        view.ptr  // fake pointer for the register offset
	    }
=09
	    unsafe fn project_view<'a, T, U>(
	        view: Self::View<'a, T>,
	        ptr: *mut U,
	    ) -> Self::View<'a, U> {
	        I2cView { client: view.client, ptr }
	    }
	}
=09
	impl FallibleIoCapable<u8> for I2cBackend {
	    fn io_try_read<'a>(view: I2cView<'a, u8>) -> Result<u8> {
	        ...
	        view.client.smbus_read_byte_data(offset)
	    }
=09
	    fn io_try_write<'a>(view: I2cView<'a, u8>, value: u8) -> Result {
	        ...
	        view.client.smbus_write_byte_data(offset, value)
	    }
	}

[1] https://lore.kernel.org/driver-core/20260706-io_projection-v6-0-72cd5d0=
55d54@garyguo.net/
[2] FallibleIoCapable:

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 7c9f7b85bca3..d97f58c968e7 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -275,6 +276,36 @@ pub trait IoCapable<T>: IoBackend {
     fn io_write<'a>(view: Self::View<'a, T>, value: T);
 }

+/// Fallible counterpart of [`IoCapable`] for I/O backends where operation=
s can fail at the
+/// transport level (e.g. I2C, SPI).
+///
+/// Infallible backends ([`IoCapable`] implementors) get this for free via=
 blanket implementation.
+/// Fallible-only backends implement this trait directly without implement=
ing [`IoCapable`]; the
+/// infallible [`Io::read`], [`Io::write`], and [`Io::update`] methods wil=
l then be unavailable,
+/// enforcing that callers use the `try_*` variants instead.
+pub trait FallibleIoCapable<T>: IoBackend {
+    /// Performs an I/O read of type `T` at `view` and returns the result,=
 or an error if the
+    /// transport-level operation fails.
+    fn io_try_read<'a>(view: Self::View<'a, T>) -> Result<T>;
+
+    /// Performs an I/O write of `value` at `view`, or returns an error if=
 the transport-level
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
@@ -644,7 +675,7 @@ fn copy_to_slice(self, data: &mut [u8])
     fn try_read8(self, offset: usize) -> Result<u8>
     where
         usize: IoLoc<Self::Target, u8, IoType =3D u8>,
-        Self::Backend: IoCapable<u8>,
+        Self::Backend: FallibleIoCapable<u8>,
     {
         self.try_read(offset)
     }
@@ -654,7 +685,7 @@ fn try_read8(self, offset: usize) -> Result<u8>
     fn try_read16(self, offset: usize) -> Result<u16>
     where
         usize: IoLoc<Self::Target, u16, IoType =3D u16>,
-        Self::Backend: IoCapable<u16>,
+        Self::Backend: FallibleIoCapable<u16>,
     {
         self.try_read(offset)
     }
@@ -664,7 +695,7 @@ fn try_read16(self, offset: usize) -> Result<u16>
     fn try_read32(self, offset: usize) -> Result<u32>
     where
         usize: IoLoc<Self::Target, u32, IoType =3D u32>,
-        Self::Backend: IoCapable<u32>,
+        Self::Backend: FallibleIoCapable<u32>,
     {
         self.try_read(offset)
     }
@@ -674,7 +705,7 @@ fn try_read32(self, offset: usize) -> Result<u32>
     fn try_read64(self, offset: usize) -> Result<u64>
     where
         usize: IoLoc<Self::Target, u64, IoType =3D u64>,
-        Self::Backend: IoCapable<u64>,
+        Self::Backend: FallibleIoCapable<u64>,
     {
         self.try_read(offset)
     }
@@ -684,7 +715,7 @@ fn try_read64(self, offset: usize) -> Result<u64>
     fn try_write8(self, value: u8, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u8, IoType =3D u8>,
-        Self::Backend: IoCapable<u8>,
+        Self::Backend: FallibleIoCapable<u8>,
     {
         self.try_write(offset, value)
     }
@@ -694,7 +725,7 @@ fn try_write8(self, value: u8, offset: usize) -> Result
     fn try_write16(self, value: u16, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u16, IoType =3D u16>,
-        Self::Backend: IoCapable<u16>,
+        Self::Backend: FallibleIoCapable<u16>,
     {
         self.try_write(offset, value)
     }
@@ -704,7 +735,7 @@ fn try_write16(self, value: u16, offset: usize) -> Resu=
lt
     fn try_write32(self, value: u32, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u32, IoType =3D u32>,
-        Self::Backend: IoCapable<u32>,
+        Self::Backend: FallibleIoCapable<u32>,
     {
         self.try_write(offset, value)
     }
@@ -714,7 +745,7 @@ fn try_write32(self, value: u32, offset: usize) -> Resu=
lt
     fn try_write64(self, value: u64, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u64, IoType =3D u64>,
-        Self::Backend: IoCapable<u64>,
+        Self::Backend: FallibleIoCapable<u64>,
     {
         self.try_write(offset, value)
     }
@@ -826,10 +857,10 @@ fn write64(self, value: u64, offset: usize)
     fn try_read<T, L>(self, location: L) -> Result<T>
     where
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: FallibleIoCapable<L::IoType>,
     {
         let view =3D io_view::<Self, L::IoType>(self, location.offset())?;
-        Ok(Self::Backend::io_read(view).into())
+        Ok(Self::Backend::io_try_read(view)?.into())
     }

     /// Generic fallible write with runtime bounds check.
@@ -859,12 +890,11 @@ fn try_read<T, L>(self, location: L) -> Result<T>
     fn try_write<T, L>(self, location: L, value: T) -> Result
     where
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: FallibleIoCapable<L::IoType>,
     {
         let view =3D io_view::<Self, L::IoType>(self, location.offset())?;
         let io_value =3D value.into();
-        Self::Backend::io_write(view, io_value);
-        Ok(())
+        Self::Backend::io_try_write(view, io_value)
     }

     /// Generic fallible write of a fully-located register value.
@@ -904,7 +934,7 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     where
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location =3D L, Value =3D T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: FallibleIoCapable<L::IoType>,
     {
         let (location, value) =3D value.into_io_op();

@@ -937,16 +967,14 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     fn try_update<T, L, F>(self, location: L, f: F) -> Result
     where
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: FallibleIoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
         let view =3D io_view::<Self, L::IoType>(self, location.offset())?;

-        let value: T =3D Self::Backend::io_read(view).into();
+        let value: T =3D Self::Backend::io_try_read(view)?.into();
         let io_value =3D f(value).into();
-        Self::Backend::io_write(view, io_value);
-
-        Ok(())
+        Self::Backend::io_try_write(view, io_value)
     }

     /// Generic infallible read with compile-time bounds check.
