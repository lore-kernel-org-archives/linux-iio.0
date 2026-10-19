Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261234CF490;
	Mon, 19 Oct 2026 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375653; cv=none; b=PBUIqAPDStTXHc1CGp2jD3Jq5D8T50i/zcDyq9mj4fhInKcVU9+MuqTlNHmjsMhJDi1njO9VuKzlrHMVx7x+w9UKUBl67aUVieNJDzj4jU/YjChmwOL6etnALhCk/0S+blEak6FYemkOWRqrkpEmbjzqRgD+Bj8Fh13wYMyivDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375653; c=relaxed/simple;
	bh=A86l9dEsEPatM7NXqHEAD95dwG+3AkAV6PzK+X64M7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sojx1cYGUtS0oI8w7RtYUSOhZiYcOsxCqltKdTY5AS7EfV4NI5TOHUl0GzsCSMJAauYdgqXZobIo4JacrfqRhuvQxaI7gvviL1wStj0/ncSKYIdXWNdLIIewcSkDcL6+Msp6HXX8Sm1yuNo800Ba506YEmdhFFvIEYysWz6UnAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLpv3oET; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLpv3oET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA961F000C4;
	Mon, 19 Oct 2026 02:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792375651;
	bh=8ip6f8qGfEHT4Vcgxv8eqcl4CD3K4VIOqut2jNShi5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FLpv3oETC5nlyi4gad6kHpR/KcWu4jo85cyE2PGVkuYS2vHs52yNtvyhmcnAYBX1b
	 JRPdbJNLMaBrcz0VUnP1twH4zz9n7CwqE5XxWVTNV4AIiz6WOGaXTeOj3vLhWlETm6
	 ijkw7wI33jIjGVaRm7py1abdxBRN0HwgNjvHFQCfh0Uyjyg7LlOOlhGM1HGtlJn23G
	 qxgSKW1emTGqUcRK5br5jqTwV1Xh2rz0+zCCiXKTpnrXPelQP/ieXduohcEA0y+I5l
	 biWOMTAL8/yogP/LfuwwOpAFVrVDoUQlqq2ifAITRXafj+kRV/+MgFMtSsOm8BOCo8
	 RwhBTWfATsD2g==
Date: Mon, 19 Oct 2026 03:07:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jared Wuerzburger <jwuerz@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: imu: st_lsm6dsx: Add ACPI ID SMOCF05 for
 LSM6DS3TR-C
Message-ID: <20261019030725.72670a4f@jic23-hlaptop>
In-Reply-To: <20260928210648.17166-3-jwuerz@gmail.com>
References: <20260928210648.17166-1-jwuerz@gmail.com>
	<20260928210648.17166-3-jwuerz@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 16:06:48 -0500
Jared Wuerzburger <jwuerz@gmail.com> wrote:

> From: Samuel Dionne-Riel <samuel@dionne-riel.com>
> 
> The Minisforum V3 and V3 SE tablets declare their ST LSM6DS3TR-C IMU in
> the DSDT with the hardware ID SMOCF05 instead of SMO8B30, so the driver
> never binds and the accelerometer and gyroscope are missing. The
> Windows driver (version 1.0.4.3) binds the LSM6DS3TR-C to both IDs.
> 
> The device has two I2C resources for the same address; the I2C core
> uses the first one.
> 
> The vendor-specific SLA0/SLG0 matrix methods in the DSDT are not parsed,
> because SLA0 is not usable as a mount matrix as it is. Its X and Y signs
> are right, but it also negates Z. It follows the Windows sensor
> convention, which reports Z = -1g with the screen facing up, while
> iio-sensor-proxy uses the same X and Y signs but expects Z = +1g in that
> posture. Applied as a mount matrix, SLA0 gives correct screen rotation,
> but iio-sensor-proxy reports the tilt inverted. The actual mounting is a
> plain 180 degree rotation about Z (-1 0 0; 0 -1 0; 0 0 1), with which
> orientation and tilt are both right. As for SMOCF00, the matrix is
> therefore provided by the systemd hwdb instead.
> 
> Tested on:
>  - V3 SE (Ryzen 7 7735U, BIOS 1.03) with this change.
>  - V3 (Ryzen 7 8840U, BIOS 1.06), kernel 7.2.7, with this change and
>    the stock firmware tables. The driver binds to i2c-SMOCF05:00, the
>    WHO_AM_I check passes (0x6a), and both lsm6ds3tr-c_accel and
>    lsm6ds3tr-c_gyro are registered. Screen auto-rotation and tilt work
>    with iio-sensor-proxy and the matrix above (checked with the device
>    renamed to SMO8B30 via a DSDT override, i.e. the same
>    ST_LSM6DS3TRC_ID driver data).
> 
> Closes: https://github.com/mudkipme/awesome-minisforum-v3/issues/2
> Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
> [Jared Wuerzburger: rewrote the changelog with test results and the
>  mount matrix rationale, converted the entry to C99 initializers,
>  dropped the mount matrix patch]
> Assisted-by: LLM
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Jared Wuerzburger <jwuerz@gmail.com>
> ---
> 
> Notes:
>     Jonathan, the full DSDT excerpt is in the cover letter; a Link: to the
>     series (or b4 shazam -M) would keep it reachable from the commit.

Ah. I was working backwards in time today and applied a patch equivalent
to your patch 1 from someone else.  So just this one applied on top
of that.

Sorry about that!  I tend to work backwards when I'm way behind as
a lot of older threads have already resolved themselves :)

Thanks,

Jonathan

> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> index c4097ce2bf..11e5ec3798 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -145,6 +145,7 @@ MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
>  static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
>  	{ .id = "SMO8B30", .driver_data = ST_LSM6DS3TRC_ID },
>  	{ .id = "SMOCF00", .driver_data = ST_LSM6DSO_ID },
> +	{ .id = "SMOCF05", .driver_data = ST_LSM6DS3TRC_ID },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, st_lsm6dsx_i2c_acpi_match);

