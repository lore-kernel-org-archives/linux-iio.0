Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160B33DEFA;
	Fri, 20 Feb 2026 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584677; cv=none; b=o1/Vzx6SuwR3V115WojrhK247gQ5yXLMUpGrDFRVdYl4I2gMVQ7ljy8j4bBm330+GWYE99rrGwVOjYC3aeVBRKC3iDG8Rw0rZNxxL8cDMGOhFB0SPsVJ+BiKcUyt8wTqFqi9+uz2xjRE5FPxvvABAAh1Vn7w+H9huh3DKZrOuK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584677; c=relaxed/simple;
	bh=JQBMZyX1vn8vTY4cAJ82bSj3kuQolH9qygZRULgtXKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ij65kQWMymFCdsJfGQf72buCvm0GTGF72elUXG52c3r+UJggmqsCnN6lQEGyy3sYY7ZY+pp70g1YjtiQVICJcWMtb5uLQqO3H0yVvOCufz7mVSYzBSG2mKIUyN/1fveOQyO77e3/Z3RORlKJRrRAsWZyGeHE+DG6TyjGTYFI2+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMX3pLcb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMX3pLcb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C25C116C6;
	Fri, 20 Feb 2026 10:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771584676;
	bh=JQBMZyX1vn8vTY4cAJ82bSj3kuQolH9qygZRULgtXKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jMX3pLcbqSCUXdIH+rJJLJ2mbzGFjjMk7krQtIwLLnrRyVuKIbg2ecIWorhCa/ovg
	 baAUFSGeqEB81spHkDoVYYTca/dRTmdFpOhcHnSum2AR8kOl9CKreZs/MT+ldgEd1g
	 /aJ4URoAUcqREzFYQ78tzVQoYwQtB02xQiNF06LDV5Kwu2aWqRO4PdALNYEQF5ywoI
	 5ZwaBmsOrBJUJNfZguOhjcodB80JB9/fkmxuzkyMmcy7ra/clJVKytcCTB6YQVDCcF
	 lnPN5s+HzHSs8ytGlgWDMc0rp3HqqmJAZLdX/2kBFmu7/gCpTdcRhx8luRYqpR7E8Q
	 KHZ6fFRsoC2cw==
Date: Fri, 20 Feb 2026 10:51:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Andrew Ijano <andrew.ijano@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH next v2] iio: sca3000: simplify with
 spi_get_device_match_data()
Message-ID: <20260220105001.7fce6c3c@jic23-huawei>
In-Reply-To: <20260216102453.1063866-1-harshit.m.mogalapalli@oracle.com>
References: <20260216102453.1063866-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 02:24:48 -0800
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> Refactor each sca3000 variant with it's own chip_info struct, update the
> sca3000_probe() to use spi_get_device_match_data().
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

I made a couple of white space tweaks whilst applying.

Applied to the testing branch of iio.git.  There was quite
a bit of fuzz (line changes) but was all straight forward.

thanks,

Jonathan

> ---
> Only compile tested.
> 
> v1->v2: Andy suggested we drop a NULL check on
> spi_get_device_match_data() failure. Also added Andy's RB.
> ---
>  drivers/iio/accel/sca3000.c | 127 +++++++++++++++++-------------------
>  1 file changed, 59 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index d4c117f54a07..eeb313056259 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -172,6 +172,7 @@ struct sca3000_state {
>  
>  /**
>   * struct sca3000_chip_info - model dependent parameters
> + * @name:			name of the chip
>   * @scale:			scale * 10^-6
>   * @temp_output:		some devices have temperature sensors.
>   * @measurement_mode_freq:	normal mode sampling frequency
> @@ -194,6 +195,7 @@ struct sca3000_state {
>   * sca3000 variant.
>   **/
>  struct sca3000_chip_info {
> +	const char		*name;
>  	unsigned int		scale;
>  	bool			temp_output;
>  	int			measurement_mode_freq;
> @@ -208,69 +210,59 @@ struct sca3000_chip_info {
>  	int			mot_det_mult_y[7];
>  };
>  
> -enum sca3000_variant {
> -	d01,
> -	e02,
> -	e04,
> -	e05,
> +static const struct sca3000_chip_info sca3000_chip_info_d01 = {
> +	.name = "sca3000_d01",
> +	.scale = 7357,
> +	.temp_output = true,
> +	.measurement_mode_freq = 250,
> +	.measurement_mode_3db_freq = 45,
> +	.option_mode_1 = SCA3000_OP_MODE_BYPASS,
> +	.option_mode_1_freq = 250,
> +	.option_mode_1_3db_freq = 70,
> +	.mot_det_mult_xz = {50, 100, 200, 350, 650, 1300},

Trivial but whilst we are here, lets add spaces after { and before }

> +	.mot_det_mult_y = {50, 100, 150, 250, 450, 850, 1750},
>  };
>  
> -/*
> - * Note where option modes are not defined, the chip simply does not
> - * support any.
> - * Other chips in the sca3000 series use i2c and are not included here.
> - *
> - * Some of these devices are only listed in the family data sheet and
> - * do not actually appear to be available.
> - */
> -static const struct sca3000_chip_info sca3000_spi_chip_info_tbl[] = {
> -	[d01] = {
> -		.scale = 7357,
> -		.temp_output = true,
> -		.measurement_mode_freq = 250,
> -		.measurement_mode_3db_freq = 45,
> -		.option_mode_1 = SCA3000_OP_MODE_BYPASS,
> -		.option_mode_1_freq = 250,
> -		.option_mode_1_3db_freq = 70,
> -		.mot_det_mult_xz = {50, 100, 200, 350, 650, 1300},
> -		.mot_det_mult_y = {50, 100, 150, 250, 450, 850, 1750},
> -	},
> -	[e02] = {
> -		.scale = 9810,
> -		.measurement_mode_freq = 125,
> -		.measurement_mode_3db_freq = 40,
> -		.option_mode_1 = SCA3000_OP_MODE_NARROW,
> -		.option_mode_1_freq = 63,
> -		.option_mode_1_3db_freq = 11,
> -		.mot_det_mult_xz = {100, 150, 300, 550, 1050, 2050},
> -		.mot_det_mult_y = {50, 100, 200, 350, 700, 1350, 2700},
> -	},
> -	[e04] = {
> -		.scale = 19620,
> -		.measurement_mode_freq = 100,
> -		.measurement_mode_3db_freq = 38,
> -		.option_mode_1 = SCA3000_OP_MODE_NARROW,
> -		.option_mode_1_freq = 50,
> -		.option_mode_1_3db_freq = 9,
> -		.option_mode_2 = SCA3000_OP_MODE_WIDE,
> -		.option_mode_2_freq = 400,
> -		.option_mode_2_3db_freq = 70,
> -		.mot_det_mult_xz = {200, 300, 600, 1100, 2100, 4100},
> -		.mot_det_mult_y = {100, 200, 400, 7000, 1400, 2700, 54000},
> -	},
> -	[e05] = {
> -		.scale = 61313,
> -		.measurement_mode_freq = 200,
> -		.measurement_mode_3db_freq = 60,
> -		.option_mode_1 = SCA3000_OP_MODE_NARROW,
> -		.option_mode_1_freq = 50,
> -		.option_mode_1_3db_freq = 9,
> -		.option_mode_2 = SCA3000_OP_MODE_WIDE,
> -		.option_mode_2_freq = 400,
> -		.option_mode_2_3db_freq = 75,
> -		.mot_det_mult_xz = {600, 900, 1700, 3200, 6100, 11900},
> -		.mot_det_mult_y = {300, 600, 1200, 2000, 4100, 7800, 15600},
> -	},
> +static const struct sca3000_chip_info sca3000_chip_info_e02 = {
> +	.name = "sca3000_e02",
> +	.scale = 9810,
> +	.measurement_mode_freq = 125,
> +	.measurement_mode_3db_freq = 40,
> +	.option_mode_1 = SCA3000_OP_MODE_NARROW,
> +	.option_mode_1_freq = 63,
> +	.option_mode_1_3db_freq = 11,
> +	.mot_det_mult_xz = {100, 150, 300, 550, 1050, 2050},
> +	.mot_det_mult_y = {50, 100, 200, 350, 700, 1350, 2700},
> +};
> +
> +static const struct sca3000_chip_info sca3000_chip_info_e04 = {
> +	.name = "sca3000_e04",
> +	.scale = 19620,
> +	.measurement_mode_freq = 100,
> +	.measurement_mode_3db_freq = 38,
> +	.option_mode_1 = SCA3000_OP_MODE_NARROW,
> +	.option_mode_1_freq = 50,
> +	.option_mode_1_3db_freq = 9,
> +	.option_mode_2 = SCA3000_OP_MODE_WIDE,
> +	.option_mode_2_freq = 400,
> +	.option_mode_2_3db_freq = 70,
> +	.mot_det_mult_xz = {200, 300, 600, 1100, 2100, 4100},
> +	.mot_det_mult_y = {100, 200, 400, 7000, 1400, 2700, 54000},
> +};
> +
> +static const struct sca3000_chip_info sca3000_chip_info_e05 = {
> +	.name = "sca3000_e05",
> +	.scale = 61313,
> +	.measurement_mode_freq = 200,
> +	.measurement_mode_3db_freq = 60,
> +	.option_mode_1 = SCA3000_OP_MODE_NARROW,
> +	.option_mode_1_freq = 50,
> +	.option_mode_1_3db_freq = 9,
> +	.option_mode_2 = SCA3000_OP_MODE_WIDE,
> +	.option_mode_2_freq = 400,
> +	.option_mode_2_3db_freq = 75,
> +	.mot_det_mult_xz = {600, 900, 1700, 3200, 6100, 11900},
> +	.mot_det_mult_y = {300, 600, 1200, 2000, 4100, 7800, 15600},
>  };
>  
>  static int sca3000_write_reg(struct sca3000_state *st, u8 address, u8 val)
> @@ -1469,10 +1461,9 @@ static int sca3000_probe(struct spi_device *spi)
>  	st = iio_priv(indio_dev);
>  	st->us = spi;
>  	mutex_init(&st->lock);
> -	st->info = &sca3000_spi_chip_info_tbl[spi_get_device_id(spi)
> -					      ->driver_data];  
> +	st->info = spi_get_device_match_data(spi);
>  
> -	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->name = st->info->name;
>  	indio_dev->info = &sca3000_info;
>  	if (st->info->temp_output) {
>  		indio_dev->channels = sca3000_channels_with_temp;
> @@ -1513,10 +1504,10 @@ static int sca3000_probe(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id sca3000_id[] = {
> -	{"sca3000_d01", d01},
> -	{"sca3000_e02", e02},
> -	{"sca3000_e04", e04},
> -	{"sca3000_e05", e05},
> +	{"sca3000_d01", (kernel_ulong_t)&sca3000_chip_info_d01},
> +	{"sca3000_e02", (kernel_ulong_t)&sca3000_chip_info_e02},
> +	{"sca3000_e04", (kernel_ulong_t)&sca3000_chip_info_e04},
> +	{"sca3000_e05", (kernel_ulong_t)&sca3000_chip_info_e05},
Similarly let's add some spaces to these.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, sca3000_id);

