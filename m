Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49906175A7D;
	Mon,  3 Aug 2026 00:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785718407; cv=none; b=HifvgF6STTSri0ss/AEdLDmgAlp6RCCyO4FCDejKygk1qH7beugafgHXfrlu0kPRH4xcqvGa8PPcL5n2aLBRuprsHFKCu9AmVxYHJl4O1ZPwVT0S46YkI3mD3gS39EfIRh9kLCsv9zx3mF/HixFvZzxDfVdVZjzpfyXb2H5s8nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785718407; c=relaxed/simple;
	bh=9V//NmRFwRKBLXHc9+H0ZSvrT0HtSSugns2fKNHTWzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjIOXrBEcZKvSZSPCKHaw9zQCs1PkGZ1GsG7TtqWhl/NWN8gD48ScQHGkFQhKf5hhCCKUclshb3kVhCvnnrgjcbj+sT/xH7nKHmrIsiYz6tuDyeCCWQ8q+mOqtl5Gl4sYOXXYSEm4rpwGVqU9mB0r+Gmq8EZEckXpFjGk/UHe+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7mJrZKX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7mJrZKX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D737A1F000E9;
	Mon,  3 Aug 2026 00:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785718406;
	bh=XO32AQekCdUC/EOxX8KSnMxmMUi0yMYJUwfTRHLhhNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y7mJrZKXaXHIw7dLkYlu7xO0lN8cvQ5QzVQyj/bmfRvTKC9u5pQD/oDbEKpiCRH6u
	 rsHzXZUQpclJSKBTXScLxREqJcQP6s4UlURTIw7F0TXMWuqksDP1d75+YRK2BtwhPa
	 rz9V/GVesCOO7T8wdvv4Ihs+qNEOtV3JnEntmLuIW/0GWEuRXanFAcSdM/ANb+e5Zy
	 BS6Ta0MXXrpGiuZzPGqBOXvM58q6oWYZa8BW+7AKGneK4w8iQR7F7gkWi03XfKls+m
	 ygK4Kctlg8ldlawGLxjrA+IEGdFWpE9UXmep/lLJO5npogPLez+RuFj1csiMMo/p3e
	 VxQXyFjftD+pA==
Date: Mon, 3 Aug 2026 01:53:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org,
 dakr@kernel.org, igor.korotin@linux.dev, branstj@gmail.com
Subject: Re: [RFC PATCH v4 1/3] i2c: rust: implement SMBus read abstraction
 via kernel::io::Io for I2cClient
Message-ID: <20260803015321.07dc16d1@jic23-huawei>
In-Reply-To: <20260707151542.91997-2-muchamadcoirulanwar@gmail.com>
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
	<20260707151542.91997-2-muchamadcoirulanwar@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jul 2026 22:15:40 +0700
Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com> wrote:

> Implement the Io trait for I2cClient, providing SMBus byte and word
> read/write operations with automatic offset validation via io_addr().
> 
> I2cClient implements the generic Io trait rather than exposing
> standalone SMBus methods, following the direction established in [1]
> and [2]. The underlying calls are still i2c_smbus_read_byte_data and
> i2c_smbus_read_word_data.
> 
> I2cClient now implements IoCapable<u8> and IoCapable<u16> with
> maxsize=256 (SMBus command byte range 0x00-0xFF, not the 7-bit
> device address which is handled by the I2C core at adapter level).
> 
> Link: https://lore.kernel.org/rust-for-linux/20260131-i2c-adapter-v1-4-5a436e34cd1a@gmail.com/
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/commit/?h=driver-core-testing&id=121d87b28e1d9061d3aaa156c43a627d3cb5e620
> Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>

Just to make sure it doesn't get lost across versions - I'll repeat
briefly what concerns me here.  I'm also interested to hear Wolfram's
view on this as well as Wolfram has probably seen more weird
i2c devices than anyone else.

I2C isn't one nice set of here is how you read a byte and here is how
you read a u16.  Even smbus effectively has 2 options given the large
number of devices with the bytes flipped.  Those exist because
they weren't designed against the smbus spec (very few datasheets
even mention smbus) but rather the less constrained definitions of
the i2c spec and under that there is no concept of a word so ordering
is whatever the hardware fancies (wonderfully we even have devices that
aren't consistent in ordering register pairs but let's ignore those).

So maybe introduce this as smbus as long as we can chase it with smbus_swapped
for the byte swapped version.  Or don't introduce smbus at all
because if this limited subset of smbus applies, then maybe just jumping
directly to regmap is the right way to go.

Calling this i2c and provide these interfaces is to me giving the
wrong impressions of what it is.

Jonathan
 
> ---
>  rust/kernel/i2c.rs | 89 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> index 624b971ca8b0..31c7216d0299 100644
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
> @@ -601,3 +602,91 @@ unsafe impl Send for Registration {}
>  // SAFETY: `Registration` offers no interior mutability (no mutation through &self
>  // and no mutable access is exposed)
>  unsafe impl Sync for Registration {}
> +
> +impl<Ctx: device::DeviceContext> IoCapable<u8> for I2cClient<Ctx> {
> +    unsafe fn io_read(&self, address: usize) -> u8 {
> +        // SAFETY: `self.as_raw()` returns a valid `struct i2c_client` pointer
> +        // (type invariant). `address` was pre-validated by io_addr() before
> +        // this function is called (trait contract).
> +        let ret = unsafe { bindings::i2c_smbus_read_byte_data(self.as_raw(), address as u8) };
> +
> +        // NOTE: Error is lost here. This is only called via try_read() which
> +        // first validates bounds via io_addr(). For I2C, the caller should
> +        // always use try_read8() which provides proper error handling.
> +        ret as u8
> +    }
> +
> +    unsafe fn io_write(&self, value: u8, address: usize) {
> +        // SAFETY: `self.as_raw()` returns a valid `struct i2c_client` pointer.
> +        // `address` pre-validated by io_addr().
> +        unsafe { bindings::i2c_smbus_write_byte_data(self.as_raw(), address as u8, value) };
> +        // NOTE: Return value is ignored. `IoCapable` trait signature does not
> +        // support error returns. Use with caution.
> +    }
> +}
> +
> +impl<Ctx: device::DeviceContext> IoCapable<u16> for I2cClient<Ctx> {
> +    unsafe fn io_read(&self, address: usize) -> u16 {
> +        // SAFETY: `self.as_raw()` returns a valid `struct i2c_client` pointer.
> +        // `address` pre-validated by io_addr().
> +        let ret = unsafe { bindings::i2c_smbus_read_word_data(self.as_raw(), address as u8) };
> +
> +        // NOTE: Error is lost here. See u8 implementation note.
> +        ret as u16
> +    }
> +
> +    unsafe fn io_write(&self, value: u16, address: usize) {
> +        // SAFETY: `self.as_raw()` returns a valid `struct i2c_client` pointer.
> +        // `address` pre-validated by io_addr().
> +        unsafe { bindings::i2c_smbus_write_word_data(self.as_raw(), address as u8, value) };
> +        // NOTE: Return value is ignored.
> +    }
> +}
> +
> +impl<Ctx: device::DeviceContext> Io for I2cClient<Ctx> {
> +    #[inline]
> +    fn addr(&self) -> usize {
> +        0
> +    }
> +
> +    /// SMBus command byte range: 0x00-0xFF (256 possible register addresses).
> +    /// This is NOT the 7-bit device address; that is handled by the I2C core.
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

