Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94573BF675;
	Mon, 11 May 2026 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520526; cv=none; b=Mlm+BFHE8wDrTyBJXcUxUR3586y/uDwKwuaeXoDcUO1vdMUOl5Zcjppo8rIHfx6xaMp6Swqbi4cve4UtCtf19mgZLxgKRJIihIdyG2JnEgN+nboq3mhZ+fTxETfoJzp3AepWI0/9CijWjFaSSPqbJWRCsZHfhek6hoeqtIqeCmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520526; c=relaxed/simple;
	bh=/7lcKVtHcO2bade24O1Ns8KyvOdt6ALKGo8fUbFVtN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdO1TyiTf58PbY/207D00Ei4nLWGZ6l+nzohJngrC95NJJcrjObPIpBr9bEG+CcGRVp2xCkuBA9/Racq7XXGqcB4AxPDiFTQkrtW0Wd/Z0SJeB1Rktksn59XQU6jCDduivMs8nA4bibtF99NCYFqtwi+O0wD7Z8TWz3ZuPBzQsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTtvDwwI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTtvDwwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B30C2BCB0;
	Mon, 11 May 2026 17:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778520525;
	bh=/7lcKVtHcO2bade24O1Ns8KyvOdt6ALKGo8fUbFVtN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XTtvDwwI79E4njgtXHfNOGBpIzWYX0SBy1hs4DHwer35jw3Gn2GCI8USWitGgTbp+
	 S0qkO1LX5z3i78TNeAwvJHokU9IpGH7L2IYPrpZ5OouVJtihV35sgoPNj5yo9IUVed
	 Ge5rJ2QAw9QOIBrt9eXFaxCKvonam4Z3NWzTSlUY8XR28N8KaEKBLOQBrD+Y4w0KhC
	 fmmsZ+u9VrzUsQrj1odv0pGaxCnFCf7Fwoj2cSrjukGRrbWtOK5JBn0K4oLEOyjWCC
	 PgFe4Vc9835XliGjND/gyc/bgXFFxM6KK+sp2jX8rjz8EtK5+W5M+PH6QnxfvyHbo7
	 9WrS+GBMI008w==
Date: Mon, 11 May 2026 18:28:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V5 03/11] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID: <20260511182835.3754c543@jic23-huawei>
In-Reply-To: <20260509191907.24734-4-macroalpha82@gmail.com>
References: <20260509191907.24734-1-macroalpha82@gmail.com>
	<20260509191907.24734-4-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 May 2026 14:18:57 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the core component of a new inv_icm42607 driver. This includes
> a few setup functions and the full register definition in the
> header file.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Hi Chris

The sashiko bot has taken a look and had some comments
and one in this patch is valid.

https://sashiko.dev/#/patchset/20260509191907.24734-1-macroalpha82%40gmail.com

It's minor though so if everything else looks good I might
just tweak whilst applying.


> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 332 ++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 210 +++++++++++
>  2 files changed, 542 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> new file mode 100644
> index 000000000000..10dcd3473e9c
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> new file mode 100644
> index 000000000000..e84e84416dab
> --- /dev/null
> +/**
> + *  inv_icm42607_setup() - check and setup chip
> + *  @st:	driver internal state
> + *  @bus_setup:	callback for setting up bus specific registers
> + *
> + *  Returns 0 on success, a negative error code otherwise.
> + */
> +static int inv_icm42607_setup(struct inv_icm42607_state *st,
> +			      inv_icm42607_bus_setup bus_setup)
> +{
> +	const struct device *dev = regmap_get_device(st->map);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(st->map, INV_ICM42607_REG_WHOAMI, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != st->hw->whoami)
> +		dev_warn_probe(dev, -ENODEV,
> +			       "invalid whoami %#02x expected %#02x (%s)\n",
> +			       val, st->hw->whoami, st->hw->name);
Sashiko correctly called this out as a bit nonsensical.
dev_warn_probe() is useful for dealing with deferral or that can't happen
with allowing a return dev_warn_probe() type call.

In this particular case it brings us nothing over dev_warn() so better
to just use that.

> +
> +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> +			   INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET);
> +	if (ret)
> +		return ret;


