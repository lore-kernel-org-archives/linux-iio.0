Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF85C39936E;
	Mon, 20 Apr 2026 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710008; cv=none; b=bx7ZVUPDv23QOy/H7h+Prorwy0PjSmHUm2LbZnCW3FofIohiGcMNwhhetajKRfpAYBsyhzY3h0RCsPH90Ayf2SEsWbnawyZbWLGju2qbcCDfWPQyA4NCnFbgHfALm8PnelgiMSNx6BkDQRLp4orzLQtPsdSJ72LOj0eD8ghd6d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710008; c=relaxed/simple;
	bh=/JagEYFNKC8pvLEu9Ba4PrB+iGyBKPFAdy075EBuiNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjjOWRAW5gVkMeMu0RF1x7htNN95oUeCJkqmF/p1ibIpB+d9ad/8ZorFX16C0jv74v37aqK8nGeze0fL0gkGyizZlMi1zQEQ9Y+KCuEETACDSRYt4FGvAbSDp+jY3CVJBm2BZRM1D6uKRNYd0wPnfwCGiB9tNXDxebSUY+jOL9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sh0pCZq/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh0pCZq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0DAC19425;
	Mon, 20 Apr 2026 18:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776710008;
	bh=/JagEYFNKC8pvLEu9Ba4PrB+iGyBKPFAdy075EBuiNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sh0pCZq/Z/6C483pjLgQfWEEQ93mcS5nYSV4EkvZFGEEb0QPAhILt2yQ8wM2g/yTM
	 g8h1YPfkmsxCkDi7pm2vYkNmkS/BhRK/khZPrlaxya3sshgZJ5cYa06nAJXXN4Dkj9
	 hDV1db2kfLDVaZrjDLmxjzMMMIVDn/ZxrqQ40ep+Rtvi3FxcttkQQzIBPRwd+hVzCH
	 nucrk5ps9qapiwJ7uzqBRydiDz7TeVEoik9VhfMW+H0JbdBJ135mcTyUG9h8ufc/3o
	 3lQltwPBLuTN6NPwLgHGD2rSov0WcKdB0Isq263BaCtS+G18vgW0pUeC4WSKL55T5Z
	 hHUTaF8LDu1Qg==
Date: Mon, 20 Apr 2026 19:33:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Miguel Ojeda <ojeda@kernel.org>,
 Frank Zago <frank@zago.net>, linux-iio@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] [RFC PATCH] iio: position: rust: add initial AS5600
 driver
Message-ID: <20260420193320.22df4979@jic23-huawei>
In-Reply-To: <20260419151327.26306-1-muchamadcoirulanwar@gmail.com>
References: <20260419151327.26306-1-muchamadcoirulanwar@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Apr 2026 22:13:27 +0700
Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com> wrote:

> This RFC introduces an initial Rust implementation for the ams OSRAM AS5600 magnetic rotary position sensor. The current scope covers I2C communication, device probing, and strict parsing of the AGC (Automatic Gain Control) hardware status.
> 
> For context, a C-based driver was proposed by Frank Zago in 2021 (Link: https://lore.kernel.org/linux-iio/20211216202651.120172-1-frank@zago.net/), but it was not merged. This fresh Rust implementation takes a stricter approach to probing by enforcing mandatory validation of the STATUS (0x0B) register. It gracefully aborts with -ENODEV if a valid diametrical magnet is not detected.
> 
> I have intentionally deferred exposing the IIO channels (in_angl_raw and scale) to avoid writing raw unsafe C FFI bindings. Full sysfs support will be added in a V2 once the safe Rust IIO abstractions land upstream.

Have those been posted anywhere? Or are you working on them?
I've kind of been wondering if anyone was interested in rust bindings
for IIO drivers (and dreaming of having the time to write them), so
this suggests that you are at least.

In the mean time this stub of a driver isn't particularly interesting
to review.  My concern is the common one on whether we will have enough
folk familiar with both rust and IIO to review drivers.  Hopefully we
will but my recent experience with trying to get some other rust code
reviewed hasn't been that great (that one needed rust and crypto protocols).

A few really minor things inline..
>
> Testing was performed on kernel v7.0.0-rc3 using a BeagleBone Black (AM335x) on i2c-2 (0x36) operating at 3.3V.
> 
> Testing logs verifying probe behavior and AGC logic via sysfs bind/unbind:
> 
> No magnet or magnetic field out of range:
> $ echo 2-0036 > /sys/bus/i2c/drivers/as5600/bind
> [ 1928.138249] as5600 2-0036: AS5600: No magnet detected
> 
> (Probe aborted, safely returns -ENODEV)
> Magnet pushed too far (weak field):
> $ echo 2-0036 > /sys/bus/i2c/drivers/as5600/bind
> [ 1966.130616] as5600 2-0036: AS5600: Magnet too weak
> [ 1966.135628] as5600 2-0036: AS5600: Sensor probed, driver ready
> 
> Magnet placed too close (strong field):
> $ echo 2-0036 > /sys/bus/i2c/drivers/as5600/bind
> [ 1988.541979] as5600 2-0036: AS5600: Magnet too strong
> [ 1988.547183] as5600 2-0036: AS5600: Sensor probed, driver ready
> 
> Optimal diametrical spot:
> $ echo 2-0036 > /sys/bus/i2c/drivers/as5600/bind
> [ 1977.527490] as5600 2-0036: AS5600: Sensor probed, driver ready
Push testing logs into a cover letter or under the --- so there is no
chance we end up with them in the git log where they are too verbose.
> 
> Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
> ---
>  drivers/iio/position/Kconfig   | 13 +++++++
>  drivers/iio/position/Makefile  |  1 +
>  drivers/iio/position/as5600.rs | 64 ++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)
>  create mode 100644 drivers/iio/position/as5600.rs
> 
> diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
> index 1576a6380b53..9d2611a71e33 100644
> --- a/drivers/iio/position/Kconfig
> +++ b/drivers/iio/position/Kconfig
> @@ -6,6 +6,19 @@
>  
>  menu "Linear and angular position sensors"
>  
> +config AS5600
> +	tristate "ams AS5600 magnetic rotary position sensor"
> +	depends on I2C && RUST
> +	help	  
> +	  Say Y here to build support for the ams AS5600 12-bit
> +	  magnetic rotary position sensor.
> +
> +	  This driver provides hardware validation and I2C probing
> +	  in Rust for the AS5600.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called as5600.
> +
>  config IQS624_POS
>  	tristate "Azoteq IQS624/625 angular position sensors"
>  	depends on MFD_IQS62X || COMPILE_TEST
> diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
> index d70902f2979d..2d26f6d6ace3 100644
> --- a/drivers/iio/position/Makefile
> +++ b/drivers/iio/position/Makefile
> @@ -4,5 +4,6 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  
> +obj-$(CONFIG_AS5600) += as5600.o
>  obj-$(CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE) += hid-sensor-custom-intel-hinge.o
>  obj-$(CONFIG_IQS624_POS)	+= iqs624-pos.o
> diff --git a/drivers/iio/position/as5600.rs b/drivers/iio/position/as5600.rs
> new file mode 100644
> index 000000000000..c5aab2230acf
> --- /dev/null
> +++ b/drivers/iio/position/as5600.rs
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (C) 2026 Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
> +//! Driver for ams AS5600 12-bit magnetic rotary position sensor.
> +//!
> +//! Datasheet: https://ams.com/documents/20143/36005/AS5600_DS000365_5-00.pdf
> +
> +use kernel::device::Core;
> +use kernel::i2c;
> +use kernel::module_i2c_driver;
> +use kernel::prelude::*;
> +
> +// AS5600 register addresses (from datasheet v1.06)
> +const AS5600_REG_STATUS: u8 = 0x0B;
> +const AS5600_REG_RAW_ANGLE_H: u8 = 0x0C; // High nibble [11:8] in bits [3:0]
> +const AS5600_REG_RAW_ANGLE_L: u8 = 0x0D; // Low byte [7:0]

If the detail in the comments is useful, I'd suggest some consts for masks
to extract the appropriate bits (from the _H register anyway)
I'd rather see a definition we can use than a comment telling us where things are.

> +
> +// STATUS register bit masks
> +const AS5600_STATUS_MH: u8 = 0x08; // Magnet too strong (AGC minimum gain overflow)
> +const AS5600_STATUS_ML: u8 = 0x10; // Magnet too weak (AGC maximum gain overflow)
> +const AS5600_STATUS_MD: u8 = 0x20; // Magnet detected

Do we have a rust equivalent of BIT()?  That tends to be easier to compare with
datasheets that don't use hex for this.

> +
> +module_i2c_driver! {
> +    type: As5600,
> +    name: "as5600",
> +    authors: ["Muchamad Coirul Anwar"],
> +    description: "I2C Driver for ams OSRAM AS5600 Magnetic Rotary Position Sensor",
> +    license: "GPL",
> +}
> +
> +kernel::i2c_device_table!(
> +    I2C_TABLE,
> +    MODULE_I2C_TABLE,
> +    <As5600 as i2c::Driver>::IdInfo,
> +    [(i2c::DeviceId::new(c"as5600"), ())]
> +);
> +
> +struct As5600 {}
> +
> +impl i2c::Driver for As5600 {
> +    type IdInfo = ();
> +    const I2C_ID_TABLE: Option<i2c::IdTable<Self::IdInfo>> = Some(&I2C_TABLE);
> +
> +    fn probe(
> +        dev: &i2c::I2cClient<Core>,
> +        _id_info: Option<&Self::IdInfo>,
> +    ) -> impl PinInit<Self, Error> {
> +        let status = dev.smbus_read_byte_data(AS5600_REG_STATUS)?;
> +        if (status & AS5600_STATUS_MD) == 0 {
> +            dev_err!(dev.as_ref(), "AS5600: No magnet detected\n");
> +            return Err(ENODEV);

ENODEV seems a bit too much of an indication the device is missing rather than
the magnet.  From my vague understanding of how these are used, the
magnet may not always be present so perhaps failing on this at probe is too strong?
If it does make sense to fail, then fail on the strong / weak as well if
that means the outputs are useless.

> +        } else if (status & AS5600_STATUS_MH) != 0 {
> +            dev_warn!(dev.as_ref(), "AS5600: Magnet too strong\n");
> +        } else if (status & AS5600_STATUS_ML) != 0 {
> +            dev_warn!(dev.as_ref(), "AS5600: Magnet too weak\n");
> +        }
> +
> +        dev_info!(dev.as_ref(), "AS5600: Sensor probed, driver ready\n");

Too noisy. dev_dbg!() at most even when doing development (assuming that exists
- this is only the second bit of rust I've ever reviewed ;)

> +        Ok::<_, Error>(As5600 {})
> +    }
> +
> +    fn unbind(dev: &i2c::I2cClient<Core>, _this: Pin<&Self>) {
> +        dev_info!(dev.as_ref(), "AS5600 Sensor Driver Unbound\n");
Definitely not, even in an RFC patch. These sorts of things can end up
making it all the way to the upstream driver so dev_dbg!() only.

> +    }
> +}

