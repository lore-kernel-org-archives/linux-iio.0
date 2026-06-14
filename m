Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4832F3C37;
	Sun, 14 Jun 2026 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781454904; cv=none; b=bnKYkneBRMnf85Cz/VoPIrF6vCnJ7MYzwJ9B5JCsWAmOGy4CPfHkp6gS3m6MLsXOQloxS0FgYpwIxwV8RHne9lx1sac6cXCsvrSICmGnzru0j0BaeOMZVGlkUrTGHfGjAFd0I6ENQpVbAXTZkoYCtHx6RV0LBEXgFa73WzBbCag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781454904; c=relaxed/simple;
	bh=Wu/RmZC3h2lCsa7pOcbEM1+r8DClzSk6d127sxlLH2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGsA7P8qJwJTOI8vhy9u+ROe96aFd9tg8+uqRQIG/nRcNVlIOjMXfFhybSlZ2yFcTAtXxGhyM5WbpetMEwj+NslKi2oJHtbbmsc3X50T/pKzMDbvtRGUN2+OuV8xeRCUCzFolbgWeF57yls00+BaSMs2TMhOsLWsYjLhXjdMXAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vnf08imH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vnf08imH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3881F000E9;
	Sun, 14 Jun 2026 16:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781454903;
	bh=idYHJBBU/SGZVcFt0UoqqHmT+v7vxO/szRsvlKZMY08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vnf08imHxkrAx5spB3j0OrCVRmU6tnfytvx6wYMbEc4PAO6RK6v4DqaFH7yLGtSjD
	 pMuS/clZUsNSJg8H2sYDoQGCakIN5Ye0XYdBhc1e8T3kEpRoVK+K88ac4sWMvAjU6S
	 /KEhbXsoFdsL782CUAimrE80NKOcuQ9dvXS0W5fHnHEqmRfkp7sOqfJaguAXYCwk7X
	 IYePgX6mol6cfcDMc9MZXg66CYcZOdQMDwUsQ4BaGoxApQOBtW8IfG+EkSAr8yFifm
	 BYAxGE81oy3a2y+/TyB3pAW5qf4UWklvdHv6IoCiFGU3xFj+l84WFrrROLfDfVLTz+
	 3DhJ7fQl97jAw==
Date: Sun, 14 Jun 2026 17:34:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V12 6/9] iio: imu: inv_icm42607: Add Temp Support in
 icm42607
Message-ID: <20260614173453.0db01d3f@jic23-huawei>
In-Reply-To: <20260611202607.85376-7-macroalpha82@gmail.com>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
	<20260611202607.85376-7-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 15:26:03 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add functions for reading temperature sensor data.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
The buffer isn't safe for use for DMA.  See below.
I'm not sure I'd have noticed. This used to be a common bug but not seen it that
often recently for some reason!

Jonathan

  
> ---
>  drivers/iio/imu/inv_icm42607/Makefile         |  1 +
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  5 ++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 18 +++++
>  .../iio/imu/inv_icm42607/inv_icm42607_temp.c  | 76 +++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_temp.h  | 37 +++++++++
>  5 files changed, 137 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
> 
> diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_icm42607/Makefile
> index be109102e203..c04953ed42ce 100644
> --- a/drivers/iio/imu/inv_icm42607/Makefile
> +++ b/drivers/iio/imu/inv_icm42607/Makefile
> @@ -2,6 +2,7 @@
>  
>  obj-$(CONFIG_INV_ICM42607) += inv-icm42607.o
>  inv-icm42607-y += inv_icm42607_core.o
> +inv-icm42607-y += inv_icm42607_temp.o
>  
>  obj-$(CONFIG_INV_ICM42607_I2C) += inv-icm42607-i2c.o
>  inv-icm42607-i2c-y += inv_icm42607_i2c.o
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> index 28edc12d5373..53dd23509a53 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> @@ -114,6 +114,7 @@ struct inv_icm42607_suspended {
>  
>  /**
>   *  struct inv_icm42607_state - driver state variables
> + *  @buffer:		data transfer buffer aligned for DMA.
>   *  @hw:		Hardware specific data.
>   *  @map:		regmap pointer.
>   *  @vddio_supply:	I/O voltage regulator for the chip.
> @@ -124,6 +125,7 @@ struct inv_icm42607_suspended {
>   *  @orientation:	sensor chip orientation relative to main hardware.
>   */
>  struct inv_icm42607_state {
> +	__be16 buffer[3] __aligned(IIO_DMA_MINALIGN);

Look in more depth at what this does.   Key thing is there is a reason
this should always be at the end of the iio_priv() structure.

(Sashiko caught this btw)

>  	const struct inv_icm42607_hw *hw;
>  	struct regmap *map;
>  	struct regulator *vddio_supply;
> @@ -363,6 +365,9 @@ extern const struct inv_icm42607_hw inv_icm42607_hw_data;
>  extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
>  extern const struct dev_pm_ops inv_icm42607_pm_ops;
>  


