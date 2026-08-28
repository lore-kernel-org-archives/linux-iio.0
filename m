Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED0391E51
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787897436; cv=pass; b=sfH18GZuu11YRnFEnku7Nex0dXHvgEqEGo8FDlfOMERoQ37ztcuvYqT7EDU3l9fCtmjXDUu/szXhmgUz5UVmy5sXGFtVSTyQeqEvujA96b7+qoG0BZXVZlVPdS+TBcFji0x6jBx6wP/UKA1KnCq0Ir546ehiWk6B1qzNJBA/TJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787897436; c=relaxed/simple;
	bh=Ue0T1iUVz3epLV1GAr355iUH4SyixiHlgovA41xr+ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5/T+06Qy34k9f9G/SCEzxRhNs17X0habMym4wb5ljFheKndqZebTZG+vDm/wtBkEwobxwzCB6s7ypQ6H9220zaQ86cu0tGKH8EmfCjkPSpKb/Zcq4Rgqz9M3xdB+kSAVnGFp/Z1vDLH6h55fsdhAoMK4gMPdBDecA4tdXlojSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKAK2Cq2; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKAK2Cq2"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b4ae0b3308so488560e87.3
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 23:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787897432; cv=none;
        d=google.com; s=arc-20260327;
        b=IbLsevjRfThU/1zAXQfGSiWb1AO+grs8YVszWoF0IrXPNSqxNTGlCyyla6kYLItbui
         jXaRsEWrFwnrwZqZRJYyglVpA9XkMYhw9chi0Wh7vLJ/GBeOmK+R2oAI6GGU0h1HJUK7
         ICu49mtSMuOvIN1jonsxb6jzyj2U1Q3L374txrC4rb3qEoS9sRS239D41kI7WcXUBV9W
         dVngOmq4YUEfFLniccD54LuTHk2k//tmt/nD0H1c+SIwMgEp1Iekm8pZR24bqgeUY1fP
         aP8SwnxI8DA0uUK65lLfmLOy8gCQUOd35zSibcRWSWIcOQHVnNEs6ZyH/H3hL651Quhf
         jSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j/crMht1+yXjpzwQZ3OMn5JiyeMwenvsHnVlTSZgTfE=;
        fh=LMLMEUSIe+rNwU2HlCnXjjNlSw327I0YCBE6pKB7huk=;
        b=iXYEQ6f6FzINa7IstJYTX7c9ack/VwoU1za8jTB1eUukqeSMfhh6ifK398tRN2djp7
         DeqzUOSJ+vkW//v3F6Xkf9oy0MYEobkKlbusPe+tjkf3rcz3GzBmNQfh+ECwh5jFwkv8
         zbk+OgIzBA/TneRV1yNhfXR3yV6nwDkPBD/IwJadCxiondKhEaP+IgN+hzod/0S365R/
         mKZuQRTyUI7z3JlcWXX7VlvjrLKsZkZ3GrfWL+SPg4+M6vV4uGC61k8nnFCY8yXVRs+y
         RRQBEIkbOOkTguZNa7KM5PhVTiwyMhLRfRWof06ldoDz+yzPJElePWYrkDD4MENz6i7r
         e4ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787897432; x=1788502232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j/crMht1+yXjpzwQZ3OMn5JiyeMwenvsHnVlTSZgTfE=;
        b=NKAK2Cq2DYFivXO0yww7+3C9Z6P+uoM0KGZ3DKLFhugbnP11ZSAB3qh194Nx5rThpS
         XQPYwvnOv2g7DyVGy6xAUdFGwinC51IeOX8fuMZifT4T3OeVoyAT3G2/u34aafp2vZBm
         ygTBrjlX6z+lFIAff7k3etpikcuLRWg5k40n0yc/oYvtDoenJ3GrugBvtYRXHsFsKzER
         9V9kW+kmSURknCdozZ8jow23SEWH9/u1t+vSkwvWU+ChFXE8iKqjF5k8QUNXaMeBAXVN
         25JQ7vzO5kgIQTYyvtQRB9jxYiLX269pwCxCavGKaCjMU5v1oizKpTmMygAMVdu5GE/R
         hF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787897432; x=1788502232;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j/crMht1+yXjpzwQZ3OMn5JiyeMwenvsHnVlTSZgTfE=;
        b=pbYH+fX09+ai0tyRztCacpOWSNTWuflZ7nAQ9SYBeKxmx7AuUy67udS2e+D+bTtjXy
         DafAA3NkePjwPGitIU8e7C8Kv0yOHYT9l/ZIiEWn0t3y6YeLz3c5LcmMVvLHbiv0JLve
         ylTRyWEZK9wjbbHlmB85uGLkuR2YR2Crm7wq6pHnl2HH2SbnC1Mk0viS6D2CxlEdIVF3
         GDI43sskWTIp52BXS9DHTBlY8Mk4SZQh3xEtxxzHNvNgiTB0cOBV0yHW7W7dbzRi0bD5
         ir8slGevJ+qvDGe9BuI4mFdqqI1NA9Xcrte4r32KDXFZVk6n73N3VqEyZRw7kIlDiVU4
         OpMw==
X-Forwarded-Encrypted: i=1; AHgh+RpH7oAydj3sc8LmlbpSTwYACLvjoT50LHxlo+laC5mNm+jxFvYkHeeXqegqmkqVft4XcoHwtMwbTuI=@vger.kernel.org
X-Gm-Message-State: AFuF++nTkJMSHDi+HuRc0aylZ6cjfNz0fhjKL2z3EBRqkbyx4GvIE3eR
	jrUV7tn1vb3L5Wts+VTNeNkELIjqtdEBgHmvT/MBjbw2qJFEYqfBCr/cron9Si+25H0CK5Ovq3n
	LsAYFJI/IBTHxm7vYkT4eK/s5UAGwK6lccDn7
X-Gm-Gg: AR+sD11VqyqRINmqib+cVXXk/5IcH4shQWSS1zLtoK8ZtMd0ktiFKJo66S81OwTsQj0
	OR4bJrfhf81YYaBWKsA3kFtatbDpr0OuMaE87s76xmX6WS4XYBEJ6Df83sp+iDhJO+/qDTKRuzm
	wj8nshR777OPq/cErnXRgW7G+yGFHf1+yTFzXNgHmGruvB5FCiLchWYAUYBxjl7LLRd8uvgUFup
	zB3cEjOLRBn3syWGGSe90gzQTOP940qpb+Zr2CaLsUbMiPsmb6GZBohiT7kZc1oSk6QuaoFmuxs
	cR6g+H+9jOdAftewwRpsBYzEYeMdsIykqeJHoD+vvGldoMrILM/QSliiTA==
X-Received: by 2002:a05:651c:b0e:b0:39c:93ff:3672 with SMTP id
 38308e7fff4ca-3a301cba101mr5891681fa.9.1787897431442; Thu, 27 Aug 2026
 23:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822062725.60519-1-muchamadcoirulanwar@gmail.com>
 <20260822062725.60519-2-muchamadcoirulanwar@gmail.com> <20260824004103.54eb2f7b@jic23-huawei>
In-Reply-To: <20260824004103.54eb2f7b@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Fri, 28 Aug 2026 13:10:18 +0700
X-Gm-Features: AcwNN1VV1s3tyuVu3cfKHp_QLidwwjT9lqnRfpLo9WEnVspfAOn8t2Jxrz9UaO0
Message-ID: <CAO26r3QwUZ1QeO3PYNPoYQrbKpzfhttYAi0kNNB+QumAN=vZkQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/3] i2c: rust: implement SMBus access via
 IoBackend and FallibleIoCapable
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andi.shyti@kernel.org, 
	wsa+renesas@sang-engineering.com, ojeda@kernel.org, dakr@kernel.org, 
	igor.korotin@linux.dev, branstj@gmail.com, brucer42@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thanks for the detailed review and for CC-ing Mark.

On Mon, 24 Aug 2026 at 06:41, Jonathan Cameron <jic23@kernel.org> wrote:

> > I2cClient<Bound>::smbus_io() returns an I2cView handle for use with the
> > generic try_read8/try_read16 methods. Two standalone methods are also
> > provided for odd-offset word access that bypasses the alignment check
> > in the Io trait:
>
> Given some devices implement auto address increment and others decrement
> even in aligned byte pairs it seems you will see things that 'smell' like
> they are unaligned.
>
> I'd forgotten this fun corner of smbus like i2c devices!

The standalone smbus_read_word() and smbus_read_word_swapped()
methods exist for odd-offset access, but I didn't document that
try_read16 and try_write16 reject odd offsets and that auto-increment
devices may need to use them. I'll add that to smbus_io()'s doc comment
in v6.


> Just to repeat myself (and I appreciate the challenges that exist for
> rust support in general and that it may be easier to look at the
> i2c layer) I think that if it we are looking at bindings that are
> register like then regmap is the way to go.  The space of what you can
> build that is register based and uses these i2c_smbus commands is a lot
> richer than you might think.  Either you end up reinventing all the
> infrastructure regmap has to handle these, or you just use regmap.

Agreed. regmap-rs is the correct long-term path. This series uses the
IoBackend/SMBus route because regmap-rs does not yet exist, and the
scope is intentionally minimal: byte and word reads only. I should have
stated this in the cover letter from the start. I'll fix that in v6.

Mark, if you have a view on whether this stepping-stone approach is
acceptable or the series should wait, I'd appreciate your view.


> There are mixed devices where register stuff is used alongside other acce=
sses,
> however for those I'm not sure it is worth doing anything other than
> wrapping the raw bus access functions.
>
> A few more references to the real variations we have to cope with inline.

Agreed. smbus_read_word() and smbus_read_word_swapped() on
I2cClient<Bound> are exactly that: thin wrappers over the raw bus
functions. For mixed devices that don't fit the register model, those
standalone methods are the intended path, not the IoBackend machinery.


> p.s. One day the rust driver in IIO won't be the bottom of my 'to review'
> list :(
>

> > +impl FallibleIoCapable<u16> for I2cBackend {
> > +    #[inline]
> > +    fn io_try_read<'a>(view: I2cView<'a, u16>) -> Result<u16> {
> > +        // `io_view()` ensures `offset + 2 <=3D 256`, so `addr()` is a=
t most 254;
> > +        // the `as u8` cast below is therefore lossless.
> > +        let reg =3D Self::as_ptr(view).addr() as u8;
> > +        // SAFETY: `view.client.as_raw()` returns a valid `*mut struct=
 i2c_client`
> > +        // pointer as guaranteed by the type invariant of `I2cClient`.
> > +        // `i2c_smbus_read_word_data` is safe to call with any valid c=
lient pointer
> > +        // and any u8 command byte.
> > +        let ret =3D unsafe { bindings::i2c_smbus_read_word_data(view.c=
lient.as_raw(), reg) };
> > +        if ret < 0 {
> > +            Err(Error::from_errno(ret))
> > +        } else {
> > +            Ok(ret as u16)
> > +        }
> > +    }
> > +
> > +    #[inline]
> > +    fn io_try_write<'a>(view: I2cView<'a, u16>, value: u16) -> Result =
{
> > +        // `io_view()` ensures `offset + 2 <=3D 256`, so `addr()` is a=
t most 254;
>
> There are smbus devices that have fully 2 byte registers.  For those you'=
d
> need to divide this by 2 and the range would go up to 510
> E.g. drivers/light/cm32181.c (though that doesn't have that many register=
s).

Understood. The current maxsize=3D256 works for AS5600 but doesn't cover
devices where all 256 command bytes address 16-bit registers; for those
the range would need to go up to 510. I'll note this as a limitation
in v6.


> > +impl I2cClient<device::Bound> {
> > +    /// Returns an I/O handle for SMBus register access on this I2C cl=
ient.
> > +    ///
> > +    /// The returned handle provides fallible read/write methods for t=
he
> > +    /// 256-byte SMBus command address space (0x00=E2=80=930xFF). This=
 is the SMBus
> > +    /// command byte range, NOT the 7-bit device address, which is han=
dled
> > +    /// by the I2C core at the adapter level.
>
> That rather feels like you are correcting my confusion in the earlier ver=
sion!
> I'd assume people are more awake than me and skip the NOT part ;)

Sorry for the tone. I didn't mean to correct you. I'll drop that line.


> > +    /// Reads a 16-bit word from an SMBus register in CPU-native byte =
order.
> > +    ///
> > +    /// Wraps `i2c_smbus_read_word_data`. The `reg` parameter is the S=
MBus
> > +    /// command byte (0x00=E2=80=930xFF) =E2=80=94 an instruction sent=
 to the device over the
> > +    /// serial bus, not a memory address. There is no alignment requir=
ement:
> > +    /// any command byte value is valid regardless of whether it is od=
d or even.
>
> It might be a memory address, could be almost anything.  Maybe 'not neces=
sarily'
> a memory address.
> The kernel docs have it as:
> "Command byte, a data byte which often selects a register on the device"

I'll use the kernel-standard phrasing


> > +    /// Reads a 16-bit word from an SMBus register with bytes uncondit=
ionally
> > +    /// swapped.
> > +    ///
> > +    /// Wraps `i2c_smbus_read_word_data` and applies [`u16::swap_bytes=
`] to the
> > +    /// result. Use this for devices that store multi-byte registers i=
n
> > +    /// big-endian (MSB-first) format, which is common among I2C senso=
rs whose
> > +    /// datasheets do not reference the SMBus specification.
>
> This last bit feels like cover letter, patch description material.
> I wouldn't normally expect function documentation to justify how useful
> a function is!

Fair point. I'll remove it.

> > +    ///
> > +    /// The swap is **unconditional** =E2=80=94 it is not equivalent t=
o `be16_to_cpu`.
> > +    /// On a big-endian CPU, `be16_to_cpu` would be a no-op, but this =
method
> > +    /// still swaps. The reason: SMBus always transmits the low byte f=
irst, so
> > +    /// the driver always receives data in little-endian wire order re=
gardless
> > +    /// of CPU endianness. The swap corrects for the device's wire-lev=
el byte
> > +    /// order, not the CPU's native order.
>
> This feels like we are justifying why it isn't a different implementation=
.
> Can we rewrite to not need that reference to what else it isn't.

Agreed. I was over-explaining in the doc. I'll rewrite to describe
only what the function does.

> > +    ///
> > +    /// The `reg` parameter is the SMBus command byte (0x00=E2=80=930x=
FF). There is no
> > +    /// alignment requirement; any command byte value is valid.
>
> What would an alignment requirement mean here?

Right, it doesn't apply here. I'll drop that sentence.

> > +    ///
> > +    /// Returns `Err` if the bus transaction fails (e.g. NACK, arbitra=
tion loss,
> > +    /// or timeout).
> > +    ///
> > +    /// # Example
> > +    ///
> > +    /// ```ignore
> > +    /// // AS5600 stores the 12-bit raw angle big-endian at register 0=
x0C.
> > +    /// let raw =3D client.smbus_read_word_swapped(0x0C)?;
> > +    /// let angle =3D raw & 0x0FFF;
> > +    /// ```
> > +    #[inline]
> > +    pub fn smbus_read_word_swapped(&self, reg: u8) -> Result<u16> {
> > +        // SAFETY: `self.as_raw()` returns a valid `*mut struct i2c_cl=
ient`
> > +        // pointer as guaranteed by the type invariant of `I2cClient`.
> > +        let ret =3D unsafe { bindings::i2c_smbus_read_word_data(self.a=
s_raw(), reg) };
> > +        if ret < 0 {
> > +            Err(Error::from_errno(ret))
> > +        } else {
> > +            Ok((ret as u16).swap_bytes())
> > +        }
> > +    }
> > +}
> > diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> > index 95f46bb75f9e..516895ca2082 100644
> > --- a/rust/kernel/io.rs
> > +++ b/rust/kernel/io.rs
> > @@ -276,6 +276,36 @@ pub trait IoCapable<T>: IoBackend {
> >      fn io_write<'a>(view: Self::View<'a, T>, value: T);
> >  }
> >
> > +/// Fallible counterpart of [`IoCapable`] for I/O backends where opera=
tions can fail at the
> > +/// transport level (e.g. I2C, SPI).
> > +///
>
> Why is this part in the patch adding the i2c specific use case?
> I'd expect it to be a precursor patch.

I'll move FallibleIoCapable to a separate prerequisite patch in v6.

> > +/// Infallible backends ([`IoCapable`] implementors) get this for free=
 via blanket implementation.
> > +/// Fallible-only backends implement this trait directly without imple=
menting [`IoCapable`]; the
> > +/// infallible [`Io::read`], [`Io::write`], and [`Io::update`] methods=
 will then be unavailable,
> > +/// enforcing that callers use the `try_*` variants instead.
> > +pub trait FallibleIoCapable<T>: IoBackend {
> > +    /// Performs an I/O read of type `T` at `view` and returns the res=
ult, or an error if the
> > +    /// transport-level operation fails.
> > +    fn io_try_read<'a>(view: Self::View<'a, T>) -> Result<T>;
> > +
> > +    /// Performs an I/O write of `value` at `view`, or returns an erro=
r if the transport-level
> > +    /// operation fails.
> > +    fn io_try_write<'a>(view: Self::View<'a, T>, value: T) -> Result;
> > +}
> > +
> > +impl<B: IoCapable<T>, T> FallibleIoCapable<T> for B {
> > +    #[inline(always)]
> > +    fn io_try_read<'a>(view: Self::View<'a, T>) -> Result<T> {
> > +        Ok(Self::io_read(view))
> > +    }
> > +
> > +    #[inline(always)]
> > +    fn io_try_write<'a>(view: Self::View<'a, T>, value: T) -> Result {
> > +        Self::io_write(view, value);
> > +        Ok(())
> > +    }
> > +}
> > +
> >  /// Trait indicating that an I/O backend supports memory copy operatio=
ns.
> >  pub trait IoCopyable: IoBackend {
> >      /// Copy contents of `view` to `buffer`.
> > @@ -645,7 +675,7 @@ fn copy_to_slice(self, data: &mut [u8])
> >      fn try_read8(self, offset: usize) -> Result<u8>
> >      where
> >          usize: IoLoc<Self::Target, u8, IoType =3D u8>,
> > -        Self::Backend: IoCapable<u8>,
> > +        Self::Backend: FallibleIoCapable<u8>,
> >      {
> >          self.try_read(offset)
> >      }
> > @@ -655,7 +685,7 @@ fn try_read8(self, offset: usize) -> Result<u8>
> >      fn try_read16(self, offset: usize) -> Result<u16>
> >      where
> >          usize: IoLoc<Self::Target, u16, IoType =3D u16>,
> > -        Self::Backend: IoCapable<u16>,
> > +        Self::Backend: FallibleIoCapable<u16>,
> >      {
> >          self.try_read(offset)
> >      }
> > @@ -665,7 +695,7 @@ fn try_read16(self, offset: usize) -> Result<u16>
> >      fn try_read32(self, offset: usize) -> Result<u32>
> >      where
> >          usize: IoLoc<Self::Target, u32, IoType =3D u32>,
> > -        Self::Backend: IoCapable<u32>,
> > +        Self::Backend: FallibleIoCapable<u32>,
> >      {
> >          self.try_read(offset)
> >      }
> > @@ -675,7 +705,7 @@ fn try_read32(self, offset: usize) -> Result<u32>
> >      fn try_read64(self, offset: usize) -> Result<u64>
> >      where
> >          usize: IoLoc<Self::Target, u64, IoType =3D u64>,
> > -        Self::Backend: IoCapable<u64>,
> > +        Self::Backend: FallibleIoCapable<u64>,
> >      {
> >          self.try_read(offset)
> >      }
> > @@ -685,7 +715,7 @@ fn try_read64(self, offset: usize) -> Result<u64>
> >      fn try_write8(self, value: u8, offset: usize) -> Result
> >      where
> >          usize: IoLoc<Self::Target, u8, IoType =3D u8>,
> > -        Self::Backend: IoCapable<u8>,
> > +        Self::Backend: FallibleIoCapable<u8>,
> >      {
> >          self.try_write(offset, value)
> >      }
> > @@ -695,7 +725,7 @@ fn try_write8(self, value: u8, offset: usize) -> Re=
sult
> >      fn try_write16(self, value: u16, offset: usize) -> Result
> >      where
> >          usize: IoLoc<Self::Target, u16, IoType =3D u16>,
> > -        Self::Backend: IoCapable<u16>,
> > +        Self::Backend: FallibleIoCapable<u16>,
> >      {
> >          self.try_write(offset, value)
> >      }
> > @@ -705,7 +735,7 @@ fn try_write16(self, value: u16, offset: usize) -> =
Result
> >      fn try_write32(self, value: u32, offset: usize) -> Result
> >      where
> >          usize: IoLoc<Self::Target, u32, IoType =3D u32>,
> > -        Self::Backend: IoCapable<u32>,
> > +        Self::Backend: FallibleIoCapable<u32>,
> >      {
> >          self.try_write(offset, value)
> >      }
> > @@ -715,7 +745,7 @@ fn try_write32(self, value: u32, offset: usize) -> =
Result
> >      fn try_write64(self, value: u64, offset: usize) -> Result
> >      where
> >          usize: IoLoc<Self::Target, u64, IoType =3D u64>,
> > -        Self::Backend: IoCapable<u64>,
> > +        Self::Backend: FallibleIoCapable<u64>,
> >      {
> >          self.try_write(offset, value)
> >      }
> > @@ -827,10 +857,10 @@ fn write64(self, value: u64, offset: usize)
> >      fn try_read<T, L>(self, location: L) -> Result<T>
> >      where
> >          L: IoLoc<Self::Target, T>,
> > -        Self::Backend: IoCapable<L::IoType>,
> > +        Self::Backend: FallibleIoCapable<L::IoType>,
> >      {
> >          let view =3D io_view::<Self, L::IoType>(self, location.offset(=
))?;
> > -        Ok(Self::Backend::io_read(view).into())
> > +        Ok(Self::Backend::io_try_read(view)?.into())
> >      }
> >
> >      /// Generic fallible write with runtime bounds check.
> > @@ -860,12 +890,11 @@ fn try_read<T, L>(self, location: L) -> Result<T>
> >      fn try_write<T, L>(self, location: L, value: T) -> Result
> >      where
> >          L: IoLoc<Self::Target, T>,
> > -        Self::Backend: IoCapable<L::IoType>,
> > +        Self::Backend: FallibleIoCapable<L::IoType>,
> >      {
> >          let view =3D io_view::<Self, L::IoType>(self, location.offset(=
))?;
> >          let io_value =3D value.into();
> > -        Self::Backend::io_write(view, io_value);
> > -        Ok(())
> > +        Self::Backend::io_try_write(view, io_value)
> >      }
> >
> >      /// Generic fallible write of a fully-located register value.
> > @@ -905,7 +934,7 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
> >      where
> >          L: IoLoc<Self::Target, T>,
> >          V: LocatedRegister<Self::Target, Location =3D L, Value =3D T>,
> > -        Self::Backend: IoCapable<L::IoType>,
> > +        Self::Backend: FallibleIoCapable<L::IoType>,
> >      {
> >          let (location, value) =3D value.into_io_op();
> >
> > @@ -938,16 +967,13 @@ fn try_write_reg<T, L, V>(self, value: V) -> Resu=
lt
> >      fn try_update<T, L, F>(self, location: L, f: F) -> Result
> >      where
> >          L: IoLoc<Self::Target, T>,
> > -        Self::Backend: IoCapable<L::IoType>,
> > +        Self::Backend: FallibleIoCapable<L::IoType>,
> >          F: FnOnce(T) -> T,
> >      {
> >          let view =3D io_view::<Self, L::IoType>(self, location.offset(=
))?;
> > -
> > -        let value: T =3D Self::Backend::io_read(view).into();
> > +        let value: T =3D Self::Backend::io_try_read(view)?.into();
> >          let io_value =3D f(value).into();
> > -        Self::Backend::io_write(view, io_value);
> > -
> > -        Ok(())
> > +        Self::Backend::io_try_write(view, io_value)
> >      }
> >
> >      /// Generic infallible read with compile-time bounds check.
>
