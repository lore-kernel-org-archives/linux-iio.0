Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD01A9FBD;
	Sun, 13 Sep 2026 00:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789259067; cv=none; b=a0d735epVj9rzf/elSjshngpeIybkz9TFLS0ctytlYV/L9QORt9G9ca5+uKdzxZZO+qQmBJFQUMoLNPYrfGz5a40e3/yPgpp7bE5oSXLKW6rvHyox3UzJSrugKlejCOzEpK60l1yitTXwWgIoLClZ+IDXtad0+cPmvN+C+x45HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789259067; c=relaxed/simple;
	bh=cvzD4MHZVLuOKbb1NoxjC11FDZuTEBD0KDPBQEN6q08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Abj2RmikPLF6QcvClOUav1cjIhsJcYtzxW/qrlQpln0l9bG/4j1mCxCi0cNlAs/t6/sNixe1PObmvdZcdIzRr2oKm+z4l0/fag7vZgMzI98QRuvHHxVEN79ANmkDA85uikxyAtqzOAoV/OjzeyKBdwwYOlU0+lG35agb8SjqXLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ca8uzHRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ca8uzHRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B4A1F000FF;
	Sun, 13 Sep 2026 00:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789259066;
	bh=vF7Pz5geNKTrwe6MQe3Rpj1h2B4b6zWqQLr6eJLHVsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ca8uzHRHXYg6Xhz5oSUYO2NLCSNe73W6xG4/iyI9nBowK/XeiKRRF1/tFZQa4RIcn
	 GpmMvf26YSI29hIfkdef++czx9owykFFnUalViGOUeAMesJ4d4tGXd2rOGqzHEghib
	 9xuTroM1DFCuN0eHBSt+Nnlj9WldRcpmv/hjZVWmGFt9j3ETiNKIy3nJYxLxjRwBPS
	 eMQ016L1a+i+LvMAUGMPF8BfCDmIr6PPOmCgDX3bwW0bxzXCzUa8YzIPAS8tNj4xMc
	 ezJUMgM5NosfGcU/SudNvIHmKtY9iWtUkM2nscfbr5qBa8ilA5zpZfE6tFDtEJJqiI
	 ZLl0j9aeUVpaA==
Date: Sun, 13 Sep 2026 01:24:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
Cc: linux-i3c@lists.infradead.org, alexandre.belloni@bootlin.com,
 vitor.soares@toradex.com, samagazaryan@google.com,
 gregkh@linuxfoundation.org, arnd@arndb.de, boris.brezillon@collabora.com,
 oleksandr.shulzhenko.viktorovych@intel.com, tgopinath@linux.microsoft.com,
 corbet@lwn.net, skhan@linuxfoundation.org, linux@roeck-us.net,
 Frank.Li@nxp.com, jorge.marques@analog.com, pgaj@cadence.com,
 wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
 nuno.sa@analog.com, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 andy@kernel.org, lorenzo@kernel.org, enelsonmoore@gmail.com,
 rppt@kernel.org, pratyush@kernel.org, giovanni.cabiddu@intel.com,
 gabewhigham@gmail.com, haren@linux.ibm.com, pasha.tatashin@soleen.com,
 jirislaby@kernel.org, adrian.ho.yin.ng@altera.com, ustc.gu@gmail.com,
 jszhang@kernel.org, adrian.hunter@intel.com, akhilrajeev@nvidia.com,
 tze.yee.ng@altera.com, manikanta.guntupalli@amd.com,
 shubhrajyoti.datta@amd.com, jarkko.nikula@linux.intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] i3c: master: enable driver_override for I3C
Message-ID: <20260913012416.165c5886@jic23-hlaptop>
In-Reply-To: <20260911210935.1353126-2-meaganlloyd@linux.microsoft.com>
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
	<20260911210935.1353126-2-meaganlloyd@linux.microsoft.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 14:09:33 -0700
Meagan Lloyd <meaganlloyd@linux.microsoft.com> wrote:

> Opt-in to driver_override sysfs functionality for I3C subsystem.
> 
> Update some I3C drivers that are assuming that if their .probe is
> invoked that the bus match function already checked the ID table. Go
> ahead and verify in .probe that i3c_device_match_id() returns a valid
> match before using the i3c_device_id pointer.
> 
> Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
> Assisted-by: Claude:claude-opus-4.8 copilot

Along with splitting these up as this is the sort of change that
will sometimes need backporting in individual drivers because we are
layering something on top, I'd look at adding some helpers to skip
the id as that isn't much used and get the specific fields people
want.

> diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
> index 1c4a58855e2d..98076ae8dce8 100644
> --- a/drivers/hwmon/tmp108.c
> +++ b/drivers/hwmon/tmp108.c
> @@ -581,6 +581,8 @@ static int p3t1085_i3c_probe(struct i3c_device *i3cdev)
>  				     "Failed to register i3c regmap\n");
>  
>  	id = i3c_device_match_id(i3cdev, p3t1085_i3c_ids);
> +	if (!id)
> +		return -ENODEV;
>  
>  	return tmp108_common_probe(dev, regmap, "p3t1085_i3c", id->data);

Similar to below, jumping directly to an i3c_device_match_data() helper
in this series would avoid getting and id that these drivers don't
need access to.

>  }

> diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
> index 8e5984055b15..f28b503d16eb 100644
> --- a/drivers/iio/adc/ad4062.c
> +++ b/drivers/iio/adc/ad4062.c
> @@ -1482,14 +1482,20 @@ MODULE_DEVICE_TABLE(i3c, ad4062_id_table);
>  
>  static int ad4062_probe(struct i3c_device *i3cdev)
>  {
> -	const struct i3c_device_id *id = i3c_device_match_id(i3cdev, ad4062_id_table);
> -	const struct ad4062_chip_info *chip = id->data;
> +	const struct i3c_device_id *id;
> +	const struct ad4062_chip_info *chip;
>  	struct device *dev = &i3cdev->dev;
>  	struct iio_dev *indio_dev;
>  	struct ad4062_state *st;
>  	bool ref_sel;
>  	int ret;
>  
> +	id = i3c_device_match_id(i3cdev, ad4062_id_table);
> +	if (!id)
> +		return -ENODEV;
> +
> +	chip = id->data;

This might be a good opportunity to introduce

i3c_device_match_data() as in many drivers we don't actually care about
access to the id itself.

> +
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> index cb5c5d7e1f3d..153a03e06801 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> @@ -32,6 +32,9 @@ static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
>  	struct device *dev = i3cdev_to_dev(i3cdev);
>  	struct regmap *regmap;
>  

Please bring the assignment down to above the check so

	id = i3c_device_match_id(i3cdev,st_lsm6dsx_i3c_ids);

Which is what you did in the previous driver...
> +	if (!id)
> +		return -ENODEV;
> +
>  	regmap = devm_regmap_init_i3c(i3cdev, &st_lsm6dsx_i3c_regmap_config);
>  	if (IS_ERR(regmap)) {
>  		dev_err(dev, "Failed to register i3c regmap %ld\n", PTR_ERR(regmap));

