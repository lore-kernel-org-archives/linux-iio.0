Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E8F2E7361;
	Thu, 28 May 2026 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981965; cv=none; b=BWW+YQoSbPhBWIuzNAkMKxSQUOzJU3GnfgaKYU0AolFDpjIDaixiNxCZBJH8xg5WYAark20nWCYVOrh3c+BDKyx0rbe+7ppDlGP8T1nGqmmr1kR5SmXU4u2C0WYFhAgBKpa2AfJIOLSJo3pC1wVOayKj8S8jMRuZZCV9u7tro00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981965; c=relaxed/simple;
	bh=hV5ESbbfN2C9yKwrR6wN74BBZL60m4/YVGQ6Lehhn6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GuVdufffVWcqeY6Ntxyk4vJSvdkiXiAOg6lKJ8D1YLlkTxISZhWukItudJu9SilF4aUeeuuT9fy6mvhxnc7lGxx2wCQWHyeV6Txtycjaoytc0rUYqYZ4Ktb8TDdhxBmGVuiePMtMqwa6xcyVVNLWjt6ZNuVnhM8obOdyIjltIcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcZLSNGS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcZLSNGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D211F000E9;
	Thu, 28 May 2026 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779981964;
	bh=iXneU6x6vtq4war3d0IOyxMHkGNvXrgpSXCQBos2Ta0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jcZLSNGSp5Z6rsRDCW0FzB4FC1w9Nl00LIfoVGAcikCIlRLAwn2ddJtaOAMc7qFz7
	 ByWcM8qlga3Hm61VJ4+xIz87uJxocwEAihw+eqDJux6MygCvzJYFkyjUYwdhb8OBC/
	 drl2TI7fxiVItuZSmhrBkBH3jeG4aNcVHDVEoppEklMT9G13wFozgo6JkWBVyY9YYN
	 uAVlcBI60JM+SJzUJkQR+HpNV5wqfBI6QFDBv5ifIhgJYswAeMKdVw+doonLYg1fcK
	 BzN/icRAMTbzBebbKd4guhbERGN6SDb/kXrPyb4g09CLdqQWZWW6ByMHPV3zTttnhy
	 Kr9u7QH/8cYIg==
Date: Thu, 28 May 2026 16:25:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Igor Korotin
 <igor.korotin.linux@gmail.com>, Brandon Saint-John <branstj@gmail.com>
Subject: Re: [RFC PATCH v3 1/4] i2c: rust: implement kernel::io::Io trait
 for I2cClient
Message-ID: <20260528162557.2b0b28d9@jic23-huawei>
In-Reply-To: <20260524132824.54918-2-muchamadcoirulanwar@gmail.com>
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
	<20260524132824.54918-2-muchamadcoirulanwar@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 20:28:20 +0700
Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com> wrote:

> Implement the Io trait for I2cClient per the agreed-upon direction
> for I2C register access abstractions. This provides try_read8() and
> try_read16() with automatic offset validation via io_addr().
> 
> I2cClient now implements IoCapable<u8> and IoCapable<u16> with
> maxsize=256 (SMBus command byte range 0x00-0xFF).
> Link: https://lore.kernel.org/rust-for-linux/20260131-i2c-adapter-v1-4-5a436e34cd1a@gmail.com/
> Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>

Usual thing that I have near zero rust experience :(
So this is vary superficial..

My main concern is this currently takes away the clarity off smbus
naming and replaces it with the impression this is how i2c reads and writes
are done in general.  How will this support other forms of access?

How do we have lots of different types of i2c supported?  Simplest being
the ones regmap supports today. There are 7ish in drivers/base/regmap-i2c.c

Or if the plan is to only support register style interfaces why not only
allow for use of regmap?

One other comment inline. I'm seeing what looks to be a check for an 8 bit
address whereas smbus is 7 bit addressing.
	
Jonathan



> ---
>  rust/kernel/i2c.rs | 76 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 51 insertions(+), 25 deletions(-)
> 
> diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> index 6eaea1158fda..cdbef6cfa344 100644
> --- a/rust/kernel/i2c.rs
> +++ b/rust/kernel/i2c.rs
> @@ -14,6 +14,7 @@
>      devres::Devres,
>      driver,
>      error::*,
> +    io::{Io, IoCapable},
>      of,
>      prelude::*,
>      sync::aref::{
> @@ -477,30 +478,6 @@ impl<Ctx: device::DeviceContext> I2cClient<Ctx> {
>      fn as_raw(&self) -> *mut bindings::i2c_client {
>          self.0.get()
>      }
> -
> -    /// Reads a single byte from a register via SMBus.
> -    pub fn smbus_read_byte_data(&self, reg: u8) -> Result<u8> {
> -        // SAFETY: `self.as_raw()` is a valid pointer to a `struct i2c_client`
> -        // by the type invariant of `I2cClient`.
> -        let ret = unsafe { bindings::i2c_smbus_read_byte_data(self.as_raw(), reg) };
> -        if ret < 0 {
> -            Err(Error::from_errno(ret))
> -        } else {
> -            Ok(ret as u8)
> -        }
> -    }
> -
> -    /// Reads a 16-bit word from a register via SMBus.
> -    pub fn smbus_read_word_data(&self, reg: u8) -> Result<u16> {
> -        // SAFETY: `self.as_raw()` is a valid pointer to a `struct i2c_client`
> -        // by the type invariant of `I2cClient`.
> -        let ret = unsafe { bindings::i2c_smbus_read_word_data(self.as_raw(), reg) };
> -        if ret < 0 {
> -            Err(Error::from_errno(ret))
> -        } else {
> -            Ok(ret as u16)
> -        }
> -    }
>  }
>  
>  // SAFETY: `I2cClient` is a transparent wrapper of `struct i2c_client`.
> @@ -614,5 +591,54 @@ fn drop(&mut self) {
>  unsafe impl Send for Registration {}
>  
>  // SAFETY: `Registration` offers no interior mutability (no mutation through &self
> -// and no mutable access is exposed)
> +// and no mutable access is exposed).

Unrelated change.

>  unsafe impl Sync for Registration {}
> +
> +impl<Ctx: device::DeviceContext> IoCapable<u8> for I2cClient<Ctx> {}
> +impl<Ctx: device::DeviceContext> IoCapable<u16> for I2cClient<Ctx> {}
> +
> +impl<Ctx: device::DeviceContext> Io for I2cClient<Ctx> {
> +    #[inline]
> +    fn addr(&self) -> usize {
> +        0
> +    }
> +
> +    #[inline]
> +    fn maxsize(&self) -> usize {
> +        256
> +    }
> +
> +    #[inline]
> +    fn try_read8(&self, offset: usize) -> Result<u8>
> +    where
> +        Self: IoCapable<u8>,
> +    {
> +        let reg = self.io_addr::<u8>(offset)? as u8;
> +        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct i2c_client`
> +        // as guaranteed by the type invariant of `I2cClient`. `reg` is bounds-checked
> +        // by `io_addr()` above (offset + 1 <= 256).

Except smbus standard addressing is 7 bit.
Need space for the read / write bit. https://docs.kernel.org/i2c/smbus-protocol.html

> +        let ret = unsafe { bindings::i2c_smbus_read_byte_data(self.as_raw(), reg) };
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(ret as u8)
> +        }
> +    }
> +
> +    #[inline]
> +    fn try_read16(&self, offset: usize) -> Result<u16>
> +    where
> +        Self: IoCapable<u16>,
> +    {
> +        let reg = self.io_addr::<u16>(offset)? as u8;
> +        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct i2c_client`
> +        // as guaranteed by the type invariant of `I2cClient`. `reg` is bounds-checked
> +        // by `io_addr()` above (offset + 2 <= 256).
> +        let ret = unsafe { bindings::i2c_smbus_read_word_data(self.as_raw(), reg) };
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(ret as u16)
> +        }
> +    }
> +}

