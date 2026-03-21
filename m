Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58F82D877A;
	Sat, 21 Mar 2026 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774119074; cv=none; b=qalvQHSYuDrQ/dZ1HuzgjJrEp8oQYoH5RkbzbE0jcEeiOydzFwHWLUTyBMFY3Sm1p5I19qSFBIKYU6LtvypSK22Z/7aYOT+NkHZ1CJkNmtEbQP8vksD6LcyytOlW7RCJDihXSA7ofdM+fGOWhgfHGOkk0A67ZwZnODcXyvETN6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774119074; c=relaxed/simple;
	bh=YuMI4YpxPSV2VAMyw84jvK453KirgJfQdkXYVCybHBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8pBLzoemESdZIYHNiPC70pGoiHz09fqylNUYbt7KwrmO91Pt2bmt9vQx/LHUL2oKTYnHeR7IpXdBL7fLbV2ArqpeTF09qgXRr6oOiHunrL9q1sLHtSAzSJZczbPIz3HpgtPqKBhT7mVCtNYckwfSa4+0SKeg+uO+JXLz4V0YXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QibhUtGm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QibhUtGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6383CC19421;
	Sat, 21 Mar 2026 18:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774119074;
	bh=YuMI4YpxPSV2VAMyw84jvK453KirgJfQdkXYVCybHBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QibhUtGmjfZfxiHIho2FeL7oKeDwpDOUizttTKkShMZZSKv+/4EoOpBw9bR7ma5kt
	 UblmTlbJ8pJXiaQO6OjCTKRoXG5skwfsjalZSsmaYxQW80ReujdT1e99CP7iQEX223
	 buqQ54HVRdjTbbeTu0o7k7TMSGa4YwFMzdyIuWC4vZrQE2WYiCDDy4tau9FLPLj0sP
	 85yjpC0Zh7iacfbcoHAvgSYNdJYcAd+Q2NtcGCZMdxxr4D+kH7ZqJqOhFxjH8V05Wk
	 B97Lr3WnMAvBXv3bIMNYMZs+2aP0l3PsAcYIQK6Q8qNrwp08Jtz58yXE8D4Eb1DU8q
	 uHJl9kLw7wBSQ==
Date: Sat, 21 Mar 2026 18:51:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v8 6/6] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
Message-ID: <20260321185106.01fc730b@jic23-huawei>
In-Reply-To: <20260317150427.3878450-1-flavra@baylibre.com>
References: <20260317150316.3878107-1-flavra@baylibre.com>
	<20260317150427.3878450-1-flavra@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 16:04:26 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> Some IMU chips in the LSM6DSX family have sensor fusion features that
> combine data from the accelerometer and gyroscope. One of these features
> generates rotation vector data and makes it available in the hardware
> FIFO as a quaternion (more specifically, the X, Y and Z components of the
> quaternion vector, expressed as 16-bit half-precision floating-point
> numbers).
> 
> Add support for a new sensor instance that allows receiving sensor fusion
> data, by defining a new struct st_lsm6dsx_fusion_settings (which contains
> chip-specific details for the sensor fusion functionality), and adding this
> struct as a new field in struct st_lsm6dsx_settings. In st_lsm6dsx_core.c,
> populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add the
> logic to initialize an additional IIO device if this struct is populated
> for the hardware type being probed.
> Note: a new IIO device is being defined (as opposed to adding channels to
> an existing device) because the rate at which sensor fusion data is
> generated may not match the data rate from any of the existing devices.
> 
> Tested on LSMDSV16X.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Hi Francesco

Just a few really minor last (hopefully!) things from me. On the whole
this set is looking very nice.

Jonathan

> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 450cb5b47346..160cc6551853 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c

> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> new file mode 100644
> index 000000000000..74a2cc5cab12
> --- /dev/null
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> @@ -0,0 +1,235 @@

> +
> +int st_lsm6dsx_fusion_set_odr(struct st_lsm6dsx_sensor *sensor, bool enable)
> +{
> +	const struct st_lsm6dsx_fusion_settings *settings;
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	u8 data;
> +	int err;
> +
> +	guard(mutex)(&hw->page_lock);

I missed this before, but mixing cleanup and gotos is generally not
seen in a good light even when it doesn't introduce bugs.  See the comments in
cleanup.h  Easiest solution here is probably a helper function doing
the stuff after the fusion page is enabled.  That can return directly
and we can then handle any error out here.

> +
> +	err = st_lsm6dsx_fusion_page_enable(hw);
> +	if (err)
> +		return err;
> +
> +	settings = &hw->settings->fusion_settings;
> +	if (enable) {
> +		const struct st_lsm6dsx_reg *reg = &settings->odr_reg;
> +		u8 odr_val;
> +
> +		st_lsm6dsx_fusion_get_odr_val(settings, sensor->hwfifo_odr_mHz,
> +					      &odr_val);
> +		data = ST_LSM6DSX_SHIFT_VAL(odr_val, reg->mask);
> +		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> +					 data);
> +		if (err)
> +			goto out;
> +	}
> +
> +	err = regmap_assign_bits(hw->regmap, settings->fifo_enable.addr,
> +				 settings->fifo_enable.mask, enable);
> +	if (err)
> +		goto out;
> +
> +	return st_lsm6dsx_fusion_page_disable(hw);
> +
> +out:
> +	st_lsm6dsx_fusion_page_disable(hw);
> +
> +	return err;
> +}

> +int st_lsm6dsx_fusion_probe(struct st_lsm6dsx_hw *hw, const char *name)
> +{

> +
> +	/*
> +	 *  Put the IIO device pointer in the iio_devs array so that the caller

Really minor but why the leading double spaces?  1 should be enough I think.

> +	 *  can set up a buffer and register this IIO device.
> +	 */
> +	hw->iio_devs[ST_LSM6DSX_ID_FUSION] = iio_dev;
> +
> +	return 0;
> +}

