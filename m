Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA81A3BADA3;
	Thu, 11 Jun 2026 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176195; cv=none; b=m4wyYWPkpwvYzA9PdkwZkZE1gkIqPiDMeu2O3/kEEgIdY8QQh13VGM3NFs7NMce/JIvoqbnYJmNiKvU5P4vvpaSLAfIJfsCJNAndO2YzkRAiReFRJ51J8AKBkxc0gzoiSWKqQ2qOprF0kmqs6MjEeLsDVc7OKBZgn0+7KZhMIb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176195; c=relaxed/simple;
	bh=itLVSm2W7R8yOV2NlMFcuZs6y+SGuautcp9cqW7TxHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEGUqvj0YfpuIg8lpVFgNa504mDhGwIkQXbnldD+NphC127eFZaeDNKuE9DCs/wJbdPFZVc6Q786EkIPer2wgyutSD/TNNOcsOOzPBZcnvoI1B1gEO/qCtGnuVt3bCXwIem1GPBS7cF0QNCcphPfGTM0Al3YI7QVJPXyZMrT2Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdTCuzN5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdTCuzN5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594111F00893;
	Thu, 11 Jun 2026 11:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781176193;
	bh=tS8DXhwxmaccMQjwqWlj292n7pGBGI0J7sHdCd7uLnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NdTCuzN5QGv3VfbmVBkIOeiKmJQ1wKm012MQ2vEgKUDdXZU23egcEG3zVAIcwWc0Q
	 2uKBwzLYLsM79zaIVSwQiQUrZ8N6YitxpD8KjJHLkZVE5Eu5Pejw/WN1t/UWk6FeGF
	 y12fLLt6uanVniwl729QZMl3/Kk7LALJMlB9iLa0f+GosYPZd/Y4s+fqGVFuPnKLS0
	 gGUOAz9i3IJ761+1EfN9m1R3ypIIfPBHOjciWlvQBNYYmLh6eGAkK50arxPqptaWJY
	 jCfQeZjPvj+2fXYlV8sb/0KC18BxgM2UR+q3MSB0qWya6hIXxQloTQrhNe6MXUnfgK
	 g5Mt3JMNocLlg==
Date: Thu, 11 Jun 2026 12:09:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V11 3/9] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID: <20260611120943.7119975b@jic23-huawei>
In-Reply-To: <20260610175455.19006-4-macroalpha82@gmail.com>
References: <20260610175455.19006-1-macroalpha82@gmail.com>
	<20260610175455.19006-4-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 12:54:47 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the core component of a new inv_icm42607 driver. This includes
> a few setup functions and the full register definition in the
> header file.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Hi Chris,

A couple more minor things from a fresh read.

Thanks

Jonathan

> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 334 ++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 197 +++++++++++
>  2 files changed, 531 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> new file mode 100644
> index 000000000000..716fc0f1c3fd
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> new file mode 100644
> index 000000000000..334264120b42
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c

> +
> +static int inv_icm42607_setup(struct inv_icm42607_state *st,
> +			      inv_icm42607_bus_setup inv_icm42607_bus_setup)
> +{
> +	const struct device *dev = regmap_get_device(st->map);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(st->map, INV_ICM42607_REG_WHOAMI, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Warn, but don't fail. */
> +	if (val != st->hw->whoami)
> +		dev_warn(dev, "Unknown whoami %#02x expected %#02x (%s)\n",
> +			 val, st->hw->whoami, st->hw->name);
> +
> +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> +			   INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(INV_ICM42607_RESET_TIME_MS * USEC_PER_MSEC);
> +
> +	/*
> +	 * No polling interval specified in datasheet, so use reset time as
> +	 * polling interval and 10x reset time as timeout period.
> +	 */
> +	ret = regmap_read_poll_timeout(st->map, INV_ICM42607_REG_INT_STATUS,
> +				       val, val & INV_ICM42607_INT_STATUS_RESET_DONE,
> +				       (INV_ICM42607_RESET_TIME_MS * USEC_PER_MSEC),
> +				       (INV_ICM42607_RESET_TIME_MS * USEC_PER_MSEC * 10));
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "reset error, reset done bit not set\n");
> +
> +	/* Sync the regcache again after a reset. */
> +	regcache_mark_dirty(st->map);
> +	ret = regcache_sync(st->map);

Sashiko raised the point that you don't have a writeable register list for the regmap
and so potentially we at very least write a bunch of stuff that isn't needed.
I doubt it's actually a problem or you would have seen it, but nice little optimization
to reduce what is written.

> +	if (ret)
> +		return ret;
> +
> +	ret = inv_icm42607_bus_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
> +			      INV_ICM42607_INTF_CONFIG0_SENSOR_DATA_ENDIAN);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
> +				 INV_ICM42607_INTF_CONFIG1_CLKSEL_MASK,
> +				 INV_ICM42607_INTF_CONFIG1_CLKSEL_PLL);

That should have a FIELD_PREP() to save us having to got check that
the MASK includes the LSB.  

> +	if (ret)
> +		return ret;
> +
> +	return inv_icm42607_set_conf(st, st->hw->conf);
> +}

> +
> +MODULE_AUTHOR("InvenSense, Inc.");
> +MODULE_DESCRIPTION("InvenSense ICM-42607x device driver");

Why does it have a trailing x?  Whilst a wild card is less harmful
here than in many places I'd still drop it.

> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_INV_SENSORS_TIMESTAMP");

Do we need this yet?  I think it only gets used later, in which case
move it to the first patch that needs this.


