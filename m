Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3BC202C46;
	Thu, 28 May 2026 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984530; cv=none; b=Povz5eoEiyIjvNIEX9QzSNMojOdX8x1f0wiIAI1RRSC7Ls9NhYSdaaIaiAUNF01tIHldEv2H94oZ7g04a9JDOqWG/YX0wKozIB13QuzxxWVSi9Q0gF3+RqVnVMPggAAnFduX8N2dS6IYpPdaRLzws44q545mDFTyrLFs44avFi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984530; c=relaxed/simple;
	bh=enMxOz63Dd6NrMxBXU172zxwm9UgMr8zeu7UzU/M7Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fN4aPEgG9z8y+i+pvOv/uETYwv9QDdXgWYi6YOJxpXBQZlEK8d6b3wjA/bA0utJOOvqarCT8/xHjol3K/lTPFK6vruzvZwWL4tkhah2vZY1eg5dw1LNDf/aCozePuE/jhi3s3M2GRYZf9Rz5JbKEzmBLCwZU5r3ZlN8RMPGqvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiOlNKU5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiOlNKU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48DC1F000E9;
	Thu, 28 May 2026 16:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779984528;
	bh=MFSHwcEVQxPrQTpdfLudFzsdzndjH/QPjGHpAmxyfh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BiOlNKU54CbrRGz1i3oAkr3kfg7i7tdKoI0SiDeEKGWqtSaP8imikcY/gLx6PZ6ns
	 A+HrRzehSgpPbIONwHm49IAAjU6ARBc9zOwyid3hXpxdKyYSaVYyf42Q6CbW8dPJU9
	 hJZAl/Q9sWUtGl8NwTKwsn7UF7P995/kyJBzFkbwjKyKJQylXGGlZGwWfrPIWZhvCR
	 v/aSiBMIBqHkS++xzGoMyNCWx2ZFV+an+/dR78Z/RvySpRLUfBKyEucPz02/zAUkNs
	 6zMn4qzToQC9PlX5CZ9Xp3OXyQ3ZDMKqJ/BaPQHVPlSnJ3Ol5gDuC+a42vnG5cjDZ9
	 +FJ18veaj4JAg==
Date: Thu, 28 May 2026 17:08:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Igor Korotin
 <igor.korotin.linux@gmail.com>, Brandon Saint-John <branstj@gmail.com>
Subject: Re: [RFC PATCH v3 3/4] iio: position: add Rust driver for ams
 AS5600
Message-ID: <20260528170840.54173bb7@jic23-huawei>
In-Reply-To: <20260524132824.54918-4-muchamadcoirulanwar@gmail.com>
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
	<20260524132824.54918-4-muchamadcoirulanwar@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 24 May 2026 20:28:22 +0700
Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com> wrote:

> Add a Rust driver for the ams AS5600 12-bit magnetic rotary position
> sensor. The driver exposes in_angl_raw and in_angl_scale via the IIO
> sysfs interface.
>=20
> Features:
> - Circuit breaker pattern for I/O error resilience

I'm not sure why this is particularly useful, but maybe I'm missing somethi=
ng.

> - Mutex-serialized multi-byte angle read sequence
> - Automatic recovery from bus failures (Poisoned -> Normal)

I mention this below - it works (sort of) because right now you just
do reads with no state changes.  In general device recovery is way
more complex than what you do.

Various other comments inline. Some are wish list things that may
or may not have rust equivalents of what we'd do in C.

> - No magnet validation at probe time (deferred to read_raw)
>=20
> Tested on BeagleBone Black (AM335x) with AS5600 on i2c-2 (0x36).
>=20
> Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
> ---
>  drivers/iio/position/as5600.rs | 289 +++++++++++++++++++++++++++++++++
>  1 file changed, 289 insertions(+)
>  create mode 100644 drivers/iio/position/as5600.rs

> +
> +#[derive(Clone, Copy)]
> +struct As5600Io(*mut i2c_client);
> +
> +/// Tracks the health state of the hardware bus to prevent I/O storms.
I think we need a separate discussion on how to do device recovery.
It is at best a black art and very device specific if bus corruption occurr=
ed.
On a read you can maybe get away with this but on a write we have no idea
if it wrote or not and that write may or may not have had side effects.

If you lose a write, the only always correct thing to do is a device
reset.  Other stuff is very device specific.

No writes in here yet which helps ;)

> +#[derive(Clone, Copy, PartialEq, Eq)]
> +enum DeviceState {
> +    Normal,
> +    Poisoned,
> +}


> +
> +impl<T: Io + IoCapable<u8>> As5600HwState<T> {
> +    /// Performs a dummy read to probe bus health after an I/O failure.

If you got a write failure, this recovers the bus but leaves you not knowing
if the write succeeded or not. I'm not sure how helpful it is.

> +    ///
> +    /// Returns `EIO` in all cases =E2=80=94 the caller should always pr=
opagate the error.
> +    /// The side effect determines recovery behavior:
> +    /// - If the dummy read **succeeds**: state is reset to `Normal`, me=
aning the
> +    ///   next `read_raw` call will attempt normal operation directly.
> +    /// - If the dummy read **fails**: state is set to `Poisoned`, meani=
ng the
> +    ///   next `read_raw` call will attempt recovery before normal opera=
tion.
> +    fn handle_io_error(&mut self) -> Error {
> +        match self.io.try_read8(AS5600_REG_STATUS as usize) {
> +            Ok(_) =3D> {
> +                self.state =3D DeviceState::Normal;
> +                EIO
> +            }
> +            Err(_) =3D> {
> +                self.state =3D DeviceState::Poisoned;
> +                EIO
> +            }
> +        }
> +    }
> +}
> +
> +// SAFETY: `As5600Priv<T>` is `Send` and `Sync` because:
> +// - `T: IoCapable<u8>` is a marker trait with no interior mutability.
> +//   The underlying `As5600Io` wrapper's Send/Sync is guaranteed by its
> +//   manual impls (serialized via Mutex + I2C adapter lock).
> +// - `channels` is a heap-allocated array (`KBox`) with no interior muta=
bility.
> +// - `io_lock: Mutex<As5600HwState<T>>` provides synchronized interior m=
utability.
> +// - `DeviceState` is a plain enum without interior mutability (Send + S=
ync
> +//   implicitly).
> +// All concurrent access to hardware goes through the `Mutex` guard.
> +// The `Unpin` bound is strictly required because `kernel::sync::lock::G=
uard`
> +// only implements `DerefMut` for `T: Unpin`. Without it, state mutation=
 fails.
> +unsafe impl<T: IoCapable<u8> + Unpin> Send for As5600Priv<T> {}
> +unsafe impl<T: IoCapable<u8> + Unpin> Sync for As5600Priv<T> {}
> +
> +impl<T: Io + IoCapable<u8> + Unpin> IioDriver for As5600Priv<T> {
> +    fn read_raw(&self, _chan: *const iio_chan_spec, mask: isize) -> Resu=
lt<IioVal> {
> +        match mask {
> +            // IIO_CHAN_INFO_RAW =E2=80=94 read the 12-bit raw angle val=
ue.
> +            m if m =3D=3D iio_chan_info_enum_IIO_CHAN_INFO_RAW as isize =
=3D> {
> +                let mut hw_guard =3D self.io_lock.lock();
> +
> +                // If the bus was previously poisoned, attempt a single =
recovery
> +                // read before proceeding with normal operation.
> +                let status =3D if hw_guard.state =3D=3D DeviceState::Poi=
soned {
> +                    match hw_guard.io.try_read8(AS5600_REG_STATUS as usi=
ze) {
> +                        Ok(s) =3D> {
> +                            hw_guard.state =3D DeviceState::Normal;
> +                            s
> +                        }
> +                        Err(_) =3D> return Err(EIO),
> +                    }
> +                } else {
> +                    match hw_guard.io.try_read8(AS5600_REG_STATUS as usi=
ze) {
> +                        Ok(s) =3D> s,
> +                        Err(_) =3D> return Err(hw_guard.handle_io_error(=
)),
> +                    }
> +                };
> +
> +                // Check magnet presence (MD bit). Without a magnet the =
angle
> +                // register contains stale/invalid data.
> +                if (status & AS5600_STATUS_MD) =3D=3D 0 {
> +                    return Err(err_enodata());
> +                }
> +
> +                // Read the 12-bit angle as two bytes. The AS5600 hardwa=
re
> +                // freezes the internal angle value on reading the high =
byte
> +                // until the low byte is read =E2=80=94 the Mutex ensure=
s this
> +                // sequence is not interleaved by concurrent readers.

Would be very unusual if the device does this but doesn't support some form=
 of larger
read. Would be nice to be able to do that in a rust driver.

> +                let angle_h =3D match hw_guard.io.try_read8(AS5600_REG_R=
AW_ANGLE_H as usize) {
> +                    Ok(v) =3D> v as u16,
> +                    Err(_) =3D> return Err(hw_guard.handle_io_error()),
> +                };
> +                let angle_l =3D match hw_guard.io.try_read8(AS5600_REG_R=
AW_ANGLE_L as usize) {
> +                    Ok(v) =3D> v as u16,
> +                    Err(_) =3D> return Err(hw_guard.handle_io_error()),
> +                };
> +
> +                let angle =3D (angle_h << 8 | angle_l) & 0x0FFF;

This is the sort of thing we'd never do in a C driver because we have well =
defined meaningful
functions / macros for doing this.  I'd like to see something equivalent in=
 the rust code of.

   Bulk read int a two byte array. i2c_smbus_read_word_data() or swapped va=
riant.
   Unaligned endian read  get_unaligned_be16()
   Masking to extract the 12 bits that are valid. FIELD_GET() whatever.

Might not matter in this driver but once you get 24bit reads or bigger doin=
g open coded
version is not particularly readable.

> +                Ok(IioVal::Int(angle as i32))
> +            }
> +            // IIO_CHAN_INFO_SCALE =E2=80=94 radians per LSB: 2=CF=80 / =
4096 =E2=89=88 0.001533981.
> +            m if m =3D=3D iio_chan_info_enum_IIO_CHAN_INFO_SCALE as isiz=
e =3D> {
> +                Ok(IioVal::IntPlusNano(0, 1533981))
> +            }
> +            _ =3D> Err(kernel::error::code::EINVAL),
> +        }
> +    }
> +
> +    fn channels(&self) -> &[iio_chan_spec] {
> +        &self.channels[..]
> +    }
> +}
> +
> +struct As5600 {
> +    _iio_dev: Device<As5600Priv<As5600Io>, Registered>,
> +}
> +
> +impl Driver for As5600 {
> +    type IdInfo =3D ();
> +    const I2C_ID_TABLE: Option<IdTable<Self::IdInfo>> =3D Some(&I2C_TABL=
E);
> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D Some(&OF_TA=
BLE);
> +
> +    #[allow(refining_impl_trait)]
> +    fn probe(dev: &I2cClient<Core>, _id_info: Option<&Self::IdInfo>) -> =
Result<Self> {
> +        // SAFETY: `iio_chan_spec` is a C struct whose fields are all in=
tegers
> +        // and pointers. Zero is a valid initialization for all of them.
> +        let mut channels_alloc =3D kernel::alloc::KBox::new(
> +            [unsafe { core::mem::zeroed::<iio_chan_spec>() }],
> +            kernel::alloc::flags::GFP_KERNEL,
> +        )?;
> +
> +        channels_alloc[0].info_mask_separate =3D (1 << iio_chan_info_enu=
m_IIO_CHAN_INFO_RAW)
> +            | (1 << iio_chan_info_enum_IIO_CHAN_INFO_SCALE);

I believe there is a kernel rust equivalent of BIT(). Can you use that here.

> +        channels_alloc[0].type_ =3D iio_chan_type_IIO_ANGL;
> +
> +        let client_ptr =3D dev as *const _ as *mut i2c_client;
> +
> +        let priv_init =3D pin_init!(As5600Priv {
> +            io_lock <- new_mutex!(As5600HwState {
> +                io: As5600Io(client_ptr),
> +                state: DeviceState::Normal,
> +            }),
> +            channels: channels_alloc,
> +        });
> +
> +        let iio_dev =3D Device::build_device(dev.as_ref(), c"as5600", pr=
iv_init)?;
> +        let iio_dev_registered =3D iio_dev.register(&crate::THIS_MODULE)=
?;
> +
> +        dev_info!(dev.as_ref(), "AS5600 magnetic position sensor ready\n=
");

Too noisy. dev_dbg() at most.

> +        Ok(As5600 {
> +            _iio_dev: iio_dev_registered,
> +        })
> +    }
> +}

