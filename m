Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7652931D4;
	Mon,  3 Aug 2026 01:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785719592; cv=none; b=k+8iFCyMHXVDTuVMMp5R1v4ITM4H/dDLdnffZq5abUU+hKz6IcjnbjOsrY95jWDHQO5DdpoCZ6g+M7SlQN6ON4PN6/00Io4h5nXxlTqsYKjjNs3zNAR6wQZ/+ihieXdKmItdK29BSdWXmNazYeqXZ0pHWgsFA2qk1ZgrU//OnFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785719592; c=relaxed/simple;
	bh=lVmxT0pAFAsCsai5FKJR15JLvLpZ01M4U2WuC5sXY+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iK+IZ4faGd/6jqPl7hV+fYjJ+8bHbTibqXH1cFkaVhuI/Vl3CGXFaXR7qQuhvDtrGpxQhKWzSiQSKp3kqYeShB74OmvSfyN+fpOFyyMNuazjM5PeMnNhbkcDr15isTZZoMVx39BOAAQJjpQshA0A3ixM+9YnWqCsliDR/w2NkJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqZ71gG4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqZ71gG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DB91F000E9;
	Mon,  3 Aug 2026 01:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785719590;
	bh=QxjCK4pz94P2OsuArexun9/Mm9WMkgus4hH+DceUtK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IqZ71gG4scwcNbxtf9RHYHwsIRxfkmZnNTk5GUQNCZriE8491j7tmdMOGuT3mOMjd
	 WECHTlAQXOToJYWszNEk/7vhMGYj2FEEGygBKhgEy4Bfoundpr+vrwppz1wIiDd6o+
	 VYEdtwwCWGxph+uD69t3ix0CO4NO142ynNakU3YsCJTXW66tcur/IIE2/RbxAAv2Ay
	 EDhhuuIIGhK0gGGOglsEv8BCMFzWyspylzl4db+pYFrOYlN+2IaDRFOQaHY55zJxZQ
	 NvGWmAE5VBs5YJWsFLxCnK4Ds2Po17S94f10SYzWflfi+IXnG1zyN8rBANNWrmhM4u
	 bh8JenFinIefg==
Date: Mon, 3 Aug 2026 02:13:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org,
 dakr@kernel.org, igor.korotin@linux.dev, branstj@gmail.com
Subject: Re: [RFC PATCH v4 3/3] iio: position: add Rust driver for ams
 AS5600
Message-ID: <20260803021304.60316f02@jic23-huawei>
In-Reply-To: <20260707151542.91997-4-muchamadcoirulanwar@gmail.com>
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
	<20260707151542.91997-4-muchamadcoirulanwar@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jul 2026 22:15:42 +0700
Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com> wrote:

> Add a Rust driver for the ams AS5600 12-bit magnetic rotary position
> sensor. The driver exposes in_angl_raw and in_angl_scale via the IIO
> sysfs interface.
> 
> Features:
> - ARef<I2cClient> for safe refcounted I2C client access
> - Mutex-serialized status + angle read sequence
> - Static channel spec (module-level const)
> - No magnet validation at probe (deferred to read_raw per IIO convention)
> - Error propagation via ? operator (no recovery state machine)
> 
> The byte order for the AS5600's big-endian registers is handled via
> swap_bytes() in-driver. This is equivalent to C's
> i2c_smbus_read_word_swapped(). The long-term solution is regmap-rs
> where endianness is configured once at the transport level.
> 
> Tested on BeagleBone Black (AM335x) with AS5600 on i2c-2 (0x36).
> 
> Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>

Sadly my rust remains very limited :(  So you both end up at the back
of my review queue and I can't provide much useful review!

> ---
>  drivers/iio/position/Kconfig   |  14 +++
>  drivers/iio/position/Makefile  |   1 +
>  drivers/iio/position/as5600.rs | 181 +++++++++++++++++++++++++++++++++
>  3 files changed, 196 insertions(+)
>  create mode 100644 drivers/iio/position/as5600.rs
> 
> diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
> index 1576a6380b53..573d241676bf 100644
> --- a/drivers/iio/position/Kconfig
> +++ b/drivers/iio/position/Kconfig
> @@ -6,6 +6,20 @@
>  
>  menu "Linear and angular position sensors"
>  
> +config AS5600
> +	tristate "ams AS5600 magnetic rotary position sensor"
> +	depends on I2C && IIO && RUST

The IIO dependence should be implicit given it is buried
deep in a menu gated on that.

> +	help
> +	  Say Y here to build support for the ams AS5600 12-bit

This Say Y language is odd as it sort of disagrees with the M
section below.  Start off with what it is then finish up with
any suggestions on Y vs M.

> +	  magnetic rotary position sensor with IIO channel support
> +	  (in_angl_raw and in_angl_scale).
> +
> +	  This is a Rust driver that exposes the 12-bit raw angle

I think the aim is that no one configuring the kernel should even
know what the language used.

> +	  and radian scale via the IIO subsystem.

I'd skip the IIO reference here given to get to this help typically
someone already navigated down into the IIO menus.

> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called as5600.
> +
>  config IQS624_POS
>  	tristate "Azoteq IQS624/625 angular position sensors"
>  	depends on MFD_IQS62X || COMPILE_TEST


> diff --git a/drivers/iio/position/as5600.rs b/drivers/iio/position/as5600.rs
> new file mode 100644
> index 000000000000..7445398c86b9
> --- /dev/null
> +++ b/drivers/iio/position/as5600.rs

> +
> +static AS5600_CHANNELS: As5600Channels = As5600Channels({
> +    // SAFETY: `iio_chan_spec` is a repr(C) struct where all-zeroes is valid
> +    // (integers default to 0, pointers to NULL).
> +    let mut chan: iio_chan_spec = unsafe { core::mem::zeroed() };
> +    chan.type_ = iio_chan_type_IIO_ANGL;
> +    // TODO: Use kernel::bits equivalent once bit_usize exists
> +    chan.info_mask_separate = (1usize << iio_chan_info_enum_IIO_CHAN_INFO_RAW)
> +        | (1usize << iio_chan_info_enum_IIO_CHAN_INFO_SCALE);

No nice BIT() equivalent?   Those names end up rather repetitive with
most of it coming twice.

I don't suppose there is any way to avoid that?

> +    [chan]
> +});
> +
> +impl IioDriver for As5600Priv {
> +    fn read_raw(&self, _chan: *const iio_chan_spec, mask: isize) -> Result<IioVal> {
> +        const INFO_RAW: isize = iio_chan_info_enum_IIO_CHAN_INFO_RAW as isize;
> +        const INFO_SCALE: isize = iio_chan_info_enum_IIO_CHAN_INFO_SCALE as isize;
> +        match mask {
> +            // IIO_CHAN_INFO_RAW: read the 12-bit raw angle value.
> +            INFO_RAW => {
> +                let hw = self.io_lock.lock();
> +
> +                // Read status register to verify magnet presence before
> +                // reading the angle.
> +                let status = hw.client.try_read8(AS5600_REG_STATUS as usize)?;
> +
> +                // Check magnet presence (MD bit). Without a magnet the angle
> +                // register contains stale/invalid data.
> +                if (status & AS5600_STATUS_MD) == 0 {
> +                    return Err(ENODATA);
> +                }
> +
> +                // Word read at register 0x0C: SMBus read_word_data returns LE,

That seems wrong.  It assumes LE data on the wire, but should return in
the CPU endianness.  Hence it's a swap in all cases, rather than an be16_to_cpu()
which would get it backwards on a big endian platform.


> +                // AS5600 stores angle big-endian, so swap_bytes() is needed.
> +                // Mutex ensures status + angle read is atomic.
> +                // NOTE: Equivalent to C's i2c_smbus_read_word_swapped().
> +                // Long-term, regmap-rs with val_format_endian=Big handles
> +                // this transparently at configuration level.
> +                let raw = hw.client.try_read16(AS5600_REG_RAW_ANGLE_H as usize)?;
> +                let angle = raw.swap_bytes() & AS5600_RAW_ANGLE_MASK;
> +                Ok(IioVal::Int(angle as i32))
> +            }
> +            // IIO_CHAN_INFO_SCALE: radians per LSB, 2*pi / 4096 = 0.001533981.
> +            INFO_SCALE => {
> +                Ok(IioVal::IntPlusNano(0, 1533981))
> +            }
> +            _ => Err(EINVAL),
> +        }
> +    }
> +
> +    fn channels(&self) -> &[iio_chan_spec] {
> +        &AS5600_CHANNELS.0
> +    }
> +}

