Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A803DF76;
	Mon, 24 Aug 2026 00:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787530054; cv=none; b=P7hd4XLl8t+YFFk/1nb+IzWihrLQBOJXjjCs2UbfzJSmuUkE4XDCGW6PlaGr6d8/xiNtLdZcQ9TNWgm4yalpij/pnifJGb7krT2cr1il17uy592Hm/owQyueq9WHVTNbgcuk2z4eWoKduo9HIIv808DVPCuwGElIHxGg9xobbdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787530054; c=relaxed/simple;
	bh=u6MYngMtg59j9D+fhbxmaNqsX4UNDmi8PisEJXEEKSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dn+IW7hFW9bWljfHYlbFmnrZ8N2L/MPASeCLfEntOTIovljUry4B+boj5WgHSJSSlBdu+SQCdKG/rnCeH2DrXm2aNQ+uBiCY/OIRgHcUw0Wsql5mf+WhFQSbI9dP036ozVlyISxVCfBjLiUhAiikSvfoKuQkLSoAx+luDyRAApY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNLUCoDl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNLUCoDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504001F000E9;
	Mon, 24 Aug 2026 00:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787530052;
	bh=3AztEcJfA05nCHG23feWH7TcWlPBdtIX/lJZUDQMn1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GNLUCoDluOWO4Waycb250Z1DHJwUAdqNHmDby+DJKNeEySW6loY/h5Br6Xql+iFDL
	 8IXCTZXbfUAb/Dfxct9Ayz5gfSLHEEkUEe5WOAAmskNewrlut4edGvs+S3P+cOY0Cl
	 N7kFL1o+oeMBGyvM6cWyF+wpkjC5C7kkpN7cu77lkWzxfrkAyB6OImMacmrLWdF9SI
	 fgWtHCYsoVzluYL7r6BhefIndhMOMQQPsOButuxwqsAR658lobPZYQq2UbYoHX29od
	 HNVAT/GrmQ4PTWf2SiVqCrn9AbIDLwg7oXfCVLvqH6UO6nGCeZ8+sW2AcLb9CLgBkh
	 i1Ra87u+rejdA==
Date: Mon, 24 Aug 2026 01:07:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andi.shyti@kernel.org,
 wsa+renesas@sang-engineering.com, ojeda@kernel.org, dakr@kernel.org,
 igor.korotin@linux.dev, branstj@gmail.com, brucer42@gmail.com
Subject: Re: [RFC PATCH v5 2/3] rust: add minimal IIO subsystem abstractions
Message-ID: <20260824010726.2849f3d8@jic23-huawei>
In-Reply-To: <20260822062725.60519-3-muchamadcoirulanwar@gmail.com>
References: <20260822062725.60519-1-muchamadcoirulanwar@gmail.com>
	<20260822062725.60519-3-muchamadcoirulanwar@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 22 Aug 2026 14:26:57 +0800
Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com> wrote:

> Add safe Rust wrappers for the Linux IIO (Industrial I/O) subsystem:
>=20
> - IioChanInfo enum wrapping iio_chan_info_enum, with TryFrom<u32> for
>   type-safe dispatch in read_raw. The compiler enforces match
>   exhaustiveness, replacing the previous raw isize approach.
> - IioVal enum with NonZeroI32 for division-by-zero prevention on
>   IIO_VAL_FRACTIONAL.
> - IioDriver trait with read_raw callback (requires Send + Sync).
> - Device<T, State> with typestate (Unregistered -> Registered) to
>   prevent double-registration at compile time.
> - PinnedDrop for guaranteed cleanup sequence:
>     iio_device_unregister -> drop_in_place(T) -> iio_device_free
>   iio_device_unregister() calls cdev_device_del() which drains the
>   kernfs workqueue before returning. All in-flight read_raw callbacks
>   (which go through kernfs sysfs reads) complete before drop_in_place
>   proceeds. This covers the sysfs read path used by this driver.
> - Compile-time const VTABLE (iio_info).
> - C-to-Rust FFI trampoline for read_raw dispatch.
>=20
> The abstraction uses iio_device_alloc (not devm_*) so that the Rust
> Drop implementation has full control over the cleanup sequence.
> Module ownership is enforced via __iio_device_register(indio_dev, module).
>=20
> Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>

Hi Muchamad

This looks fine to me subject to a few little things - see inline.

However I didn't take the time to decode every line of rust today so there =
were bits
I simply didn't understand yet.  So for this to be able to move forward I'm=
 going
to need reviews from rust experts!

Jonathan

> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index a56ba6309594..5dc917d92151 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -86,6 +86,7 @@ macro_rules! declare_err {
>      declare_err!(EIOCBQUEUED, "iocb queued, will get completion event.");
>      declare_err!(ERECALLCONFLICT, "Conflict with recalled state.");
>      declare_err!(ENOGRACE, "NFS file lock reclaim refused.");
> +    declare_err!(ENODATA, "No data available.");

Do we have something says there must be a user in the same patch?
A really generic thing like this in C would definitely be a patch on its
own so that folk who care about maintaining a given file can easily see
it without reviewing the rest of the series.

So unless you can't do otherwise, break this out as a precursor patch.

>  }
> =20
>  /// Generic integer kernel error.
> diff --git a/rust/kernel/iio.rs b/rust/kernel/iio.rs
> new file mode 100644
> index 000000000000..f1638160fed1
> --- /dev/null
> +++ b/rust/kernel/iio.rs
...

> +
> +build_iio_enum! {
> +    /// Raw unprocessed value from the channel (`IIO_CHAN_INFO_RAW`).
> +    ///
> +    /// For sensors, this is typically the ADC reading or register value
> +    /// before any scaling or offset correction.
> +    Raw =3D iio_chan_info_enum_IIO_CHAN_INFO_RAW,

I guess there may be a rust convention for this but from a human trying to
read the code point of view this need a blank line here and in similar plac=
es
where you have docs / thing documented repeated back to back.

> +    /// Scale factor to convert raw values to SI units (`IIO_CHAN_INFO_S=
CALE`).
> +    ///
> +    /// The processed value is `raw * scale`. The unit depends on the ch=
annel
> +    /// type (e.g. V for voltage, m/s=C2=B2 for acceleration, rad for an=
gle).
> +    Scale =3D iio_chan_info_enum_IIO_CHAN_INFO_SCALE,
> +}


> +
> +/// C-compatible trampoline for the `iio_info.read_raw` callback.
> +///
> +/// # Safety
> +///
> +/// This function is only called by the IIO core via the `read_raw` func=
tion
> +/// pointer in `iio_info`. The IIO core guarantees:
> +/// - `indio_dev` is a valid `iio_dev` allocated by `iio_device_alloc`.
> +/// - `chan` points to a valid channel spec from the device's channel ar=
ray.
> +/// - `val` is a valid non-null pointer to a writable `int`.
> +/// - `val2` is a valid non-null pointer to a writable `int`. The IIO co=
re
> +///   always passes stack-allocated storage for both, regardless of whet=
her
> +///   the driver uses `val2` (e.g. `IIO_VAL_INT` only writes `val`; `val=
2`

That val2 is always a valid pointer smells a bit like the c interface leaki=
ng
into the rust.  I'm not necessarily against that being a constraint we take
on but I'm not sure how we document that. Probably add something to the C d=
ocs.
Any C driver relying on this today is probably buggy for other reasons.


> +///   is provided but left unread by the caller for that return type).
> +unsafe extern "C" fn read_raw_callback<T: IioDriver>(
> +    indio_dev: *mut iio_dev,
> +    chan: *const iio_chan_spec,
> +    val: *mut c_int,
> +    val2: *mut c_int,
> +    info: isize,
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
> +    let info_enum =3D match IioChanInfo::try_from(info as u32) {
> +        Ok(valid) =3D> valid,
> +        Err(e) =3D> return e.to_errno(),
> +    };
> +
> +    match driver.read_raw(chan, info_enum) {
> +        Ok(IioVal::Int(v)) =3D> {
> +            // SAFETY: `val` is valid per the function's Safety contract=
 above.
> +            // `val2` is not written; `IIO_VAL_INT` signals to the IIO c=
ore
> +            // that only `val` carries meaningful data.
> +            unsafe {
> +                *val =3D v;
> +            }
> +            IIO_VAL_INT
> +        }
> +        Ok(IioVal::Fractional(v, v2)) =3D> {
> +            // SAFETY: both `val` and `val2` are valid per the Safety co=
ntract.
> +            unsafe {
> +                *val =3D v;
> +                *val2 =3D v2.get();

Why get in some places and not others?  May well be a gap in my really limi=
ted
rust knowledge.

> +            }
> +            IIO_VAL_FRACTIONAL
> +        }
> +        Ok(IioVal::IntPlusMicro(v, v2)) =3D> {
> +            // SAFETY: both `val` and `val2` are valid per the Safety co=
ntract.
> +            unsafe {
> +                *val =3D v;
> +                *val2 =3D v2;
> +            }
> +            IIO_VAL_INT_PLUS_MICRO
> +        }
> +        Ok(IioVal::IntPlusNano(v, v2)) =3D> {
> +            // SAFETY: both `val` and `val2` are valid per the Safety co=
ntract.
> +            unsafe {
> +                *val =3D v;
> +                *val2 =3D v2;
> +            }
> +            IIO_VAL_INT_PLUS_NANO
> +        }
> +        Err(e) =3D> e.to_errno(),
> +    }
> +}
