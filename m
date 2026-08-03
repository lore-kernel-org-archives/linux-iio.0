Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6813AE71C
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785744885; cv=pass; b=BF9SxHoVLfMG5m3w52MUA2OdQH3Rr9nQoMQB+5Kszsx4GxQoQiSs97k98bnqjDwoEHKcVXkkJrGPZvPSviGM5OmFHqtsg+pCp+Eu22BL4ExmZcbf/lCiUeo0hHlrqfMgYaUnff3QQ3hW8GXCV0GkkvRg2Swx+D4t/UCAGr8kxC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785744885; c=relaxed/simple;
	bh=3cqcNnVb2WyfB9PoSWTB60t1mDaBggOyQJRmUAGfheo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkNhCBHVX/dzYtARVIwIBskcQnbOnAcoTRldWr8r8I3L6Eme3ZMghUYHBbCPlCaESDE3K3Rm2RzqUDJKeiCCe2YEOWcFKuQ/mHgt1NGplmVelg4hTK+RBXg2o3HpG6y66aAho4WngHoPhpKSOfhLQ8WV1fY7DafK2Gr+kOyPsZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpe5eZce; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpe5eZce"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b15dcaca31so2945182e87.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 01:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785744882; cv=none;
        d=google.com; s=arc-20260327;
        b=qtk2b+teJuoSwb3ju6gByzptXfKlLqGF6QE0R+viBDQ3HFSh0MGi8k99LDMicFL4Mq
         s37gL6y0T3qN67UjnNlWPI4LnSs7ugNZB5PVPsAwtUTaQWhhFXAiUj7gySIXeXFJ7GVy
         bK6TDxfgmSBWvzjFfGnKQ3Oe/xuqKX1n1MTZgrW3uHSVF7pYB2bCooAAxpYcWqfsW6OL
         u21P9N0oYtmKjKxBB00K5Jtvh9HuwK4bRD1anQP0ueMPqxFsH5wi/VB2rPHVhmxJsV/o
         oVof08wDksFZseuTTYkhYVMFHSQs+/Z3z3AicMUKk1Nd3PD4incjSvDMaregpVJyMXJi
         ODYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1lH4VF2+CDVyt0vTT1JwRMkG4voqxUDw2iWfdZAsPUs=;
        fh=OAOw8tCo6dtfh57XJYMxwD5iHc0KAYElRMiMym92vc4=;
        b=J9P9DF0LNFAQhqp6ZKlvldLBb1Zamb/R9sQSBnpz0LWeXE4JNNuBLeJqg/AXyypmuM
         VuFxWYRH3Zrg0y2AMFum1Y2kycWn2Ux7brVtjyg2c7toDElawOd4Z5nZUs56EEExshMP
         1iULj3rIk4vPF9Kx5t6lrZBbJ/hbFfTiUvm2Ehlc0VqM86S8ajoLvWj94zmXL7gMqR9r
         ikgfVMmOEtheNJz3tXzApJ0Td/edawPdTEBH64hxPXxcMtTUBMlgq+wBtHyxUxyOkQ3W
         +lgAV+C24MG2HDltFCCdkUQqr+sNSg5yafgpvLfLOA1VLgoqTV8LrScJgg8fvnEUSret
         nN7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785744882; x=1786349682; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1lH4VF2+CDVyt0vTT1JwRMkG4voqxUDw2iWfdZAsPUs=;
        b=gpe5eZceLVOU41oiyNhrsF5dCxH28DjRPgZvBfCoUEzfSg5pDANkwScQZPRt66WhEm
         PBHvU4T9ebeuqIPBV1VGC2l9zplCaesNOChAWY8n82wbUI4ctsDpDQYTEik65PLGQu3+
         xAs8czo7b9JlZ+ENPYcrNRf7RI48fFV60yLsieDNcnonnfmKxGLqCQ2gXhmHNVcG/NID
         t/uhNXwtcEx3bD51ofGxks9aiPi6Vy3ktPCBGY/KfNEJjChB56/+Gnd4t8QqstsMP7vY
         e5S//msAyWRPmsItCl4PVNwn2910Vv+zVAVNh6BAK5O9O9+mV8j8pXBIYwY0TSdxHqYp
         pzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785744882; x=1786349682;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1lH4VF2+CDVyt0vTT1JwRMkG4voqxUDw2iWfdZAsPUs=;
        b=ILhUu3Fsydr56xPftYuntS0uNkqLwMEDNpAuk7cwsRybI8XA84lIGz0OzaHcMPTWWo
         clAjZ95x5eFzu9iZ81vBIMcQwK6+vY/XqEgFNkBif2TGfMHiliE7nqGb83JWqaGxAPaY
         bOObIuLceiEvH3lFTRfzjJI9oMIuGal2dsDw9QcSInIKkj/yOsAMX6AMmUS3SOKo3/Pn
         /FTWijI379s/ZPU52N3IOIo1ci6y4BSu1olCW+YY3fMBlOkUfjdES1ut8CYY5sazacGL
         Z8AtqSxRJzJR0/aDGJ8K0b7ZOXFiHvEPY78fghyeagtDN+xcrQaiLaJYCel23rSQlobX
         b3jg==
X-Forwarded-Encrypted: i=1; AHgh+RpYvXDMMIpYrklXpxlMDQp4LeuOVKpxf73LlXmnkotWQoszqZu0pUtfaZOrVXskgg+49ljUEPEyCUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW5I3VC0BqnjQAsj4PK3qlgVdeHcUejlSkuWYUhrnd/QlUKMXp
	VMamcKYj7dlL0qWTKRJRlo2bXdOPZoNSObjMkmw87KtFWtzfblXXAWr6F2/xDn5tRrE5RZxoxgk
	YgyRabWCx+53qLd8dPwb+oESjJCg/yWc=
X-Gm-Gg: AR+sD10Lj/6CE+tFGypN98v7tdH+v5u/WB4PiRRz89bEkXg88RRlt/J9IsBidYNWlm+
	edOG5E5nUw/eYP1AHO5VjceW1Bvn5nvcoyKRxn644G3YhHgoEO0F4Ft56KacpnBbih1MutwuwX1
	+gbpNVCZVB+/DZFrWOAT8gPwaKhJSAr+u7VORx5HKP6eRsXEO8eicRb0qEEEnNirQNLb79O9uCy
	z5kNE82ntxGYrzy/LNFSkI/UHWcnQK1WTY6bZ3mecrRBay+5Y240cPQTOu0BHBtqPhnytT9pGbs
	8+eO1OxHMWVdfnMsLsUKHvOd9sEd25EEJBTUFOfaDh1Nvp6LwO6Nmu9ueA==
X-Received: by 2002:ac2:5618:0:b0:5aa:6c98:a090 with SMTP id
 2adb3069b0e04-5b2e4f7337cmr1226857e87.34.1785744881794; Mon, 03 Aug 2026
 01:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-2-muchamadcoirulanwar@gmail.com> <20260803015321.07dc16d1@jic23-huawei>
In-Reply-To: <20260803015321.07dc16d1@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Mon, 3 Aug 2026 15:14:30 +0700
X-Gm-Features: AUfX_mzKoYx4jmKNOBGEKJP7Fj6qvyJ2JbJwMv9MKw9z722A2a-xmz-sO398Fuo
Message-ID: <CAO26r3TrJaa2EVrnv8ZuqR8QR2=Z+Z6e-hHEAwb5MSv8Cc3w3g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/3] i2c: rust: implement SMBus read abstraction
 via kernel::io::Io for I2cClient
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, andi.shyti@kernel.org, 
	wsa+renesas@sang-engineering.com, ojeda@kernel.org, dakr@kernel.org, 
	igor.korotin@linux.dev, branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Aug 2026 at 07:53, Jonathan Cameron <jic23@kernel.org> wrote:

> > Implement the Io trait for I2cClient, providing SMBus byte and word
> > read/write operations with automatic offset validation via io_addr().
> >
> > I2cClient implements the generic Io trait rather than exposing
> > standalone SMBus methods, following the direction established in [1]
> > and [2]. The underlying calls are still i2c_smbus_read_byte_data and
> > i2c_smbus_read_word_data.
> >
> > I2cClient now implements IoCapable<u8> and IoCapable<u16> with
> > maxsize=256 (SMBus command byte range 0x00-0xFF, not the 7-bit
> > device address which is handled by the I2C core at adapter level).

> Just to make sure it doesn't get lost across versions - I'll repeat
> briefly what concerns me here.  I'm also interested to hear Wolfram's
> view on this as well as Wolfram has probably seen more weird
> i2c devices than anyone else.
>
> I2C isn't one nice set of here is how you read a byte and here is how
> you read a u16.  Even smbus effectively has 2 options given the large
> number of devices with the bytes flipped.  Those exist because
> they weren't designed against the smbus spec (very few datasheets
> even mention smbus) but rather the less constrained definitions of
> the i2c spec and under that there is no concept of a word so ordering
> is whatever the hardware fancies (wonderfully we even have devices that
> aren't consistent in ordering register pairs but let's ignore those).

Thanks for the feedback, Jonathan.

That's a fair point on naming. The underlying calls are
i2c_smbus_read_word_data and i2c_smbus_write_word_data, so the
interface really is SMBus, not raw I2C.

On smbus_swapped, AS5600 is actually big-endian and currently I handle
swap_bytes() manually in the driver as a workaround. The reason I
didn't add a swapped variant yet is that in v4, the I2C bindings still
followed the MMIO pattern (IoCapable), which is infallible. Adding
smbus_swapped on top of that felt premature when the foundation itself
wasn't right for a bus that can NACK or timeout.

> So maybe introduce this as smbus as long as we can chase it with smbus_swapped
> for the byte swapped version.  Or don't introduce smbus at all
> because if this limited subset of smbus applies, then maybe just jumping
> directly to regmap is the right way to go.
>
> Calling this i2c and provide these interfaces is to me giving the
> wrong impressions of what it is.

In v5 I switched to FallibleIoCapable, which was proposed by Danilo
specifically for fallible transports like I2C. With that
foundation in place, adding a smbus_swapped backend is straightforward
and I can include it in this version if that's the preferred direction.

Wolfram is on the CC list. He's no longer listed as I2C subsystem
maintainer in MAINTAINERS (that's now Andi Shyti) but I agree his
experience with I2C devices would be valuable here.

On regmap, I noted in the driver comment that regmap-rs with
val_format_endian=Big would handle the endianness more cleanly. That
would be the better path if the Rust bindings exist or are close. Since
they don't yet, I went with the SMBus approach as a practical stepping
stone. Happy to revisit once regmap-rs is available.

Coirul


> > ---
> >  rust/kernel/i2c.rs | 89 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 89 insertions(+)
> >
> > diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> > index 624b971ca8b0..31c7216d0299 100644
> > --- a/rust/kernel/i2c.rs
> > +++ b/rust/kernel/i2c.rs
> > @@ -14,6 +14,7 @@
> >      devres::Devres,
> >      driver,
> >      error::*,
> > +    io::{Io, IoCapable},
> >      of,
> >      prelude::*,
> >      sync::aref::{
> > @@ -601,3 +602,91 @@ unsafe impl Send for Registration {}
> >  // SAFETY: `Registration` offers no interior mutability (no mutation through &self
> >  // and no mutable access is exposed)
> >  unsafe impl Sync for Registration {}
> > +
> > +impl<Ctx: device::DeviceContext> IoCapable<u8> for I2cClient<Ctx> {
> > +    unsafe fn io_read(&self, address: usize) -> u8 {
> > +        // SAFETY: `self.as_raw()` returns a valid `struct i2c_client` pointer
> > +        // (type invariant). `address` was pre-validated by io_addr() before
> > +        // this function is called (trait contract).
> > +        let ret = unsafe { bindings::i2c_smbus_read_byte_data(self.as_raw(), address as u8) };
> > +
> > +        // NOTE: Error is lost here. This is only called via try_read() which
> > +        // first validates bounds via io_addr(). For I2C, the caller should
> > +        // always use try_read8() which provides proper error handling.
> > +        ret as u8
> > +    }
> > +
> > +    unsafe fn io_write(&self, value: u8, address: usize) {
> > +        // SAFETY: `self.as_raw()` returns a valid `struct i2c_client` pointer.
> > +        // `address` pre-validated by io_addr().
> > +        unsafe { bindings::i2c_smbus_write_byte_data(self.as_raw(), address as u8, value) };
> > +        // NOTE: Return value is ignored. `IoCapable` trait signature does not
> > +        // support error returns. Use with caution.
> > +    }
> > +}
> > +
> > +impl<Ctx: device::DeviceContext> IoCapable<u16> for I2cClient<Ctx> {
> > +    unsafe fn io_read(&self, address: usize) -> u16 {
> > +        // SAFETY: `self.as_raw()` returns a valid `struct i2c_client` pointer.
> > +        // `address` pre-validated by io_addr().
> > +        let ret = unsafe { bindings::i2c_smbus_read_word_data(self.as_raw(), address as u8) };
> > +
> > +        // NOTE: Error is lost here. See u8 implementation note.
> > +        ret as u16
> > +    }
> > +
> > +    unsafe fn io_write(&self, value: u16, address: usize) {
> > +        // SAFETY: `self.as_raw()` returns a valid `struct i2c_client` pointer.
> > +        // `address` pre-validated by io_addr().
> > +        unsafe { bindings::i2c_smbus_write_word_data(self.as_raw(), address as u8, value) };
> > +        // NOTE: Return value is ignored.
> > +    }
> > +}
> > +
> > +impl<Ctx: device::DeviceContext> Io for I2cClient<Ctx> {
> > +    #[inline]
> > +    fn addr(&self) -> usize {
> > +        0
> > +    }
> > +
> > +    /// SMBus command byte range: 0x00-0xFF (256 possible register addresses).
> > +    /// This is NOT the 7-bit device address; that is handled by the I2C core.
> > +    #[inline]
> > +    fn maxsize(&self) -> usize {
> > +        256
> > +    }
> > +
> > +    #[inline]
> > +    fn try_read8(&self, offset: usize) -> Result<u8>
> > +    where
> > +        Self: IoCapable<u8>,
> > +    {
> > +        let reg = self.io_addr::<u8>(offset)? as u8;
> > +        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct i2c_client`
> > +        // as guaranteed by the type invariant of `I2cClient`. `reg` is bounds-checked
> > +        // by `io_addr()` above (offset + 1 <= 256).
> > +        let ret = unsafe { bindings::i2c_smbus_read_byte_data(self.as_raw(), reg) };
> > +        if ret < 0 {
> > +            Err(Error::from_errno(ret))
> > +        } else {
> > +            Ok(ret as u8)
> > +        }
> > +    }
> > +
> > +    #[inline]
> > +    fn try_read16(&self, offset: usize) -> Result<u16>
> > +    where
> > +        Self: IoCapable<u16>,
> > +    {
> > +        let reg = self.io_addr::<u16>(offset)? as u8;
> > +        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct i2c_client`
> > +        // as guaranteed by the type invariant of `I2cClient`. `reg` is bounds-checked
> > +        // by `io_addr()` above (offset + 2 <= 256).
> > +        let ret = unsafe { bindings::i2c_smbus_read_word_data(self.as_raw(), reg) };
> > +        if ret < 0 {
> > +            Err(Error::from_errno(ret))
> > +        } else {
> > +            Ok(ret as u16)
> > +        }
> > +    }
> > +}
>
