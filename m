Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5850E28B4E1;
	Thu, 28 May 2026 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984577; cv=none; b=i6mYyhvS026ZD+YkKTiMG0p5sGqshbPp973bRUrWOUvpB1a/ZDq5nG98T9FXZq9WT9Z0oDIsdbMEVH1JcBDmxdpHTOFrnVc5tFT7DdTXLWNqpJmQOptZmjuQEir3SpVxwSEja5T3EPhAzckfxp6R6kHyDWzJnSsFBPBxFN+y3fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984577; c=relaxed/simple;
	bh=PRvgwLpJahh3/692h0WSvw1NNv9ReIvVb0uECWNLgyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwvw8xFCVpIlrVbb6sLdsdgOjKdlpBCeg0BMflQ5YRdEQBSaZJK2jh0+T8T62BdfRRJZKvG3J7Boxpr0zkevAD9YTv+jPQwB0nC/I8wT0gSRQeJ/+//UD1avqH3iS7FFOVilMykOnhmATxW+FE/Yn4w83SEVFt+NeRsURH2lwbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzRdWURX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzRdWURX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530BC1F000E9;
	Thu, 28 May 2026 16:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779984576;
	bh=atag5zf11UAqo/xFckeLUyhXGcLHIhyVkRll71xOmg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LzRdWURXbk65DLqqJSOWi4xElK2bKUru+1Va75VE2SD4PMIB2l2X19Ee/mCIqWGcA
	 EVsnwcDbV9LC4N9eN3OL8BbcSUMgyUe9OZalaW8NdVDVZZrMj9ToSCcReAs+K/nYwY
	 j/K2ZnK+RtLujCFgtry1ISXX1Nv2Un1+tBdU1lCBXlYqWJpuAfHVO5XbgTUDIjaZID
	 qmPLy1g/5bhNigCJhk88YyJfG2l7N2jy+/rLjzqH2cZajJn6DSvYLJNbZ0upJksrP4
	 HaRAI77+PBDpQ+zs9DumtiS5LfV7BImaB0kWSFq3ZzhHL5Yv1kgkPGzHjC8AYV447w
	 TwtHbz8+6gmnA==
Date: Thu, 28 May 2026 17:09:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Igor Korotin
 <igor.korotin.linux@gmail.com>, Brandon Saint-John <branstj@gmail.com>
Subject: Re: [RFC PATCH v3 2/4] rust: add minimal IIO subsystem abstractions
Message-ID: <20260528170927.65168836@jic23-huawei>
In-Reply-To: <20260524132824.54918-3-muchamadcoirulanwar@gmail.com>
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
	<20260524132824.54918-3-muchamadcoirulanwar@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 24 May 2026 20:28:21 +0700
Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com> wrote:

> Add safe Rust wrappers for the Linux IIO subsystem. Provides:
> - Device<T, State> with typestate pattern (Unregistered/Registered)
> - IioDriver trait with read_raw callback
> - DirectModeGuard RAII for iio_device_claim_direct

You'll need a lot more stuff before it makes any sense to be messing
with claims on the state.  They only come in once drivers are dealing
with buffers etc. I'd leave them until then.

> - IioVal enum with NonZeroI32 for division-by-zero prevention
> - PinnedDrop cleanup: unregister -> drop_in_place -> iio_device_free
>=20
> Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
> ---
>  rust/helpers/helpers.c |   1 +
>  rust/helpers/iio.c     |  24 +++
>  rust/kernel/iio.rs     | 341 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |   2 +
>  4 files changed, 368 insertions(+)
>  create mode 100644 rust/helpers/iio.c
>  create mode 100644 rust/kernel/iio.rs
>=20
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index a3c42e51f00a..c69a9a93367d 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -33,6 +33,7 @@
>  #include "irq.c"
>  #include "fs.c"
>  #include "io.c"
> +#include "iio.c"
>  #include "jump_label.c"
>  #include "kunit.c"
>  #include "maple_tree.c"
> diff --git a/rust/helpers/iio.c b/rust/helpers/iio.c
> new file mode 100644
> index 000000000000..a5402440583c
> --- /dev/null
> +++ b/rust/helpers/iio.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/iio/iio.h>
> +
> +/*
> + * iio_device_claim_direct() is a static inline in iio.h.
> + * This helper exports it as a callable symbol for Rust.
> + */
> +__rust_helper bool
> +rust_helper_iio_device_claim_direct(struct iio_dev *indio_dev)
> +{
> +	return iio_device_claim_direct(indio_dev);
> +}
> +
> +/*
> + * iio_device_release_direct() is a macro expanding to __iio_dev_mode_un=
lock().
> + * This helper exports it as a callable symbol for Rust.
> + */
> +__rust_helper void
> +rust_helper_iio_device_release_direct(struct iio_dev *indio_dev)
> +{
> +	iio_device_release_direct(indio_dev);
> +}

As above with the level of bindings you are doing so far, neither of these
should ever be called.  They are not for use by drivers simply wanting
to serialize things but about controlling the ability of the IIO core to
change the fundamental data flow from simple polling to streaming data to
userspace accessible kfifos.


> diff --git a/rust/kernel/iio.rs b/rust/kernel/iio.rs
> new file mode 100644
> index 000000000000..bbd34f1c819a
> --- /dev/null
> +++ b/rust/kernel/iio.rs


> +// ---------------------------------------------------------------------=
------
> +// DirectModeGuard =E2=80=94 RAII claim on IIO direct mode
> +// ---------------------------------------------------------------------=
------
> +
> +/// RAII guard that claims IIO direct mode on construction and releases =
it on drop.
> +///
> +/// This prevents concurrent access conflicts between sysfs reads and
> +/// buffer/trigger operations.

Sort of. It ensures the state doesn't change.  Given buffer/trigger operati=
ons only
occur when in a buffer state it sort of of prevents their operations. That'=
s not
including stuff like setting up buffers though - just the data streaming.
Anyhow, kick it in the long grass (drop for now) given you don't support bu=
ffer state.

Good to see what this probably looks like though.


> +struct DirectModeGuard(*mut iio_dev);
> +
> +impl DirectModeGuard {
> +    fn new(indio_dev: *mut iio_dev) -> Result<Self> {
> +        // SAFETY: `indio_dev` is a valid pointer to a fully initialized=
 `iio_dev`
> +        // allocated by `iio_device_alloc`. `iio_device_claim_direct` re=
turns `true`
> +        // if the device is in direct mode (success), `false` if buffer =
mode is active.
> +        let claimed =3D unsafe { crate::bindings::iio_device_claim_direc=
t(indio_dev) };
> +        if claimed {
> +            Ok(Self(indio_dev))
> +        } else {
> +            Err(EBUSY)
> +        }
> +    }
> +}
> +
> +impl Drop for DirectModeGuard {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.0` was successfully claimed in `new()`. Releasi=
ng it
> +        // unlocks the IIO mode lock acquired during claim.
> +        unsafe {
> +            crate::bindings::iio_device_release_direct(self.0);
> +        }
> +    }
> +}
> +
> +// ---------------------------------------------------------------------=
------
> +// read_raw_callback =E2=80=94 C-to-Rust FFI trampoline
> +// ---------------------------------------------------------------------=
------
> +
> +/// C-compatible trampoline for the `iio_info.read_raw` callback.
> +///
> +/// # Safety
> +///
> +/// This function is only called by the IIO core with valid pointers:
> +/// - `indio_dev` is a valid `iio_dev` allocated by `iio_device_alloc`.
> +/// - `chan` points to a valid channel spec from the device's channel ar=
ray.
> +/// - `val` and `val2` are valid pointers for writing the result.
> +unsafe extern "C" fn read_raw_callback<T: IioDriver>(
> +    indio_dev: *mut iio_dev,
> +    chan: *const iio_chan_spec,
> +    val: *mut c_int,
> +    val2: *mut c_int,
> +    mask: isize,
> +) -> c_int {
> +    // SAFETY: `indio_dev` is valid and was allocated with space for `T`=
 in its
> +    // private data area. The `priv_` field was initialized in `Device::=
build_device()`.
> +    let priv_ptr =3D unsafe { (*indio_dev).priv_ as *mut T };
> +    // SAFETY: `priv_ptr` points to a valid, initialized instance of `T`=
 that
> +    // lives as long as the `iio_dev` allocation.
> +    let driver =3D unsafe { &*priv_ptr };
> +
> +    // Claim direct mode via RAII guard. If the device is in buffer mode,
> +    // return -EBUSY to userspace immediately.

We only need to do this if the particular device the driver is supporting
needs for the specific operation to ensure that that no accesses occur to t=
he
device.   We should not do this for reading stuff back that is cached in the
driver for instance.  In many cases devices have interfaces where absolutely
anything is safe in buffer modes.

This is unfortunately going to be hard to do other than in specific drivers
that know those rules. + doesn't belong here at all yet as a rust driver
can't get into a state where this fails and should never be relying on this
for it's own sychronization (e.g. between concurrent calls of read_raw()).

> +    let _guard =3D match DirectModeGuard::new(indio_dev) {
> +        Ok(g) =3D> g,
> +        Err(e) =3D> return e.to_errno(),
> +    };
> +
> +    match driver.read_raw(chan, mask) {
> +        Ok(IioVal::Int(v)) =3D> {
> +            // SAFETY: `val` is a valid pointer provided by the IIO core.
> +            unsafe {
> +                *val =3D v;
> +            }
> +            IIO_VAL_INT
> +        }
> +        Ok(IioVal::Fractional(v, v2)) =3D> {
> +            // SAFETY: `val` and `val2` are valid pointers provided by t=
he IIO core.
> +            unsafe {
> +                *val =3D v;
> +                *val2 =3D v2.get();

why .get() for this one.

> +            }
> +            IIO_VAL_FRACTIONAL
> +        }
> +        Ok(IioVal::IntPlusMicro(v, v2)) =3D> {
> +            // SAFETY: `val` and `val2` are valid pointers provided by t=
he IIO core.
> +            unsafe {
> +                *val =3D v;
> +                *val2 =3D v2;
> +            }
> +            IIO_VAL_INT_PLUS_MICRO
> +        }
> +        Ok(IioVal::IntPlusNano(v, v2)) =3D> {
> +            // SAFETY: `val` and `val2` are valid pointers provided by t=
he IIO core.
> +            unsafe {
> +                *val =3D v;
> +                *val2 =3D v2;
> +            }
> +            IIO_VAL_INT_PLUS_NANO
> +        }
> +        Err(e) =3D> e.to_errno(),
> +    }
> +}

> +
> +impl<T: IioDriver> Device<T> {

> +    /// Allocates a new IIO device with the given driver data.
> +    ///
> +    /// Uses `iio_device_alloc` (not `devm_*`) so that the Rust `Drop`
> +    /// implementation has full control over the cleanup sequence.
> +    /// The device is not yet registered; call [`register`](Self::regist=
er)
> +    /// to make it visible to userspace.
> +    pub fn build_device<E>(
> +        dev: &device::Device,
> +        name: &'static CStr,
> +        init: impl PinInit<T, E>,
> +    ) -> Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        let priv_size =3D size_of::<T>();
> +
> +        // SAFETY: `dev.as_raw()` returns a valid `struct device` pointe=
r.
> +        // `iio_device_alloc` allocates an `iio_dev` with `sizeof(T)` by=
tes of
> +        // private data. Returns NULL on failure.
> +        let indio_dev =3D unsafe { iio_device_alloc(dev.as_raw(), priv_s=
ize as i32) };
> +        if indio_dev.is_null() {
> +            return Err(ENOMEM);
> +        }
> +
> +        // SAFETY: `indio_dev` is valid and freshly allocated. `priv_` p=
oints
> +        // to uninitialized memory of `sizeof(T)` bytes. `PinInit::__pin=
ned_init`

The data accessed in c by iio_priv() is zeroed, not uninitialized but
I'm not sure that's what you are referring to.

> +        // initializes `priv_` in place without reading the previous
> +        // (uninitialized) contents.
> +        let priv_ptr =3D unsafe { (*indio_dev).priv_ as *mut T };
> +        let init_result =3D unsafe { init.__pinned_init(priv_ptr) };
> +        if let Err(e) =3D init_result {
> +            // SAFETY: `pin_init` guarantees partial-init rollback inter=
nally.
> +            // `priv_` memory was not fully initialized, so we only free=
 the
> +            // container without running `T`'s destructor.
> +            unsafe { iio_device_free(indio_dev) };
> +            return Err(Error::from(e));
> +        }
> +
> +        // SAFETY: `priv_ptr` is now fully initialized. We set up the IIO
> +        // device fields:
> +        // - `name` is a `'static` C string that outlives the device.
> +        // - `VTABLE` is a `'static` const and outlives the device.
> +        // - `channels()` returns a reference to data owned by `T` in `p=
riv_`,
> +        //   which remains at a fixed address because `priv_` is heap-al=
located
> +        //   inside `iio_dev`.

Can channels be static const?  It is in most IIO drivers written in C.

> +        unsafe {
> +            (*indio_dev).name =3D name.as_char_ptr();
> +            (*indio_dev).info =3D &Self::VTABLE;
> +
> +            let chans =3D (*priv_ptr).channels();
> +            (*indio_dev).channels =3D chans.as_ptr();
> +            (*indio_dev).num_channels =3D chans.len() as _;
> +            (*indio_dev).modes =3D INDIO_DIRECT_MODE as i32;
> +        }
> +
> +        Ok(Self {
> +            indio_dev,
> +            registered: false,
> +            _p: PhantomData,
> +        })
> +    }
> +

> +}
