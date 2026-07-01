Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF84047F2C1
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918829; cv=none; b=aFWPja1UUmicUd46hnh68M1kD590VdmIHm0gOD1R4a6PQ1q8EL6EuinA4XhSNTJMDUrl02xvHa9uVIo7IIBN7vo34ERSWYKuJdUGHY22ljN8qVpzxLqNuOrIT9acKmYueIgZJAbqXJeNwp2QkGK/6JvcVaebMqFL2kMFicZtHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918829; c=relaxed/simple;
	bh=Rff2bZQFjZVj010r87RNwMO2EYMnoJ06cDGhDRMaVjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeJT5WF5wEKegAv9/93cYUswVs6PZFOX6F0NbmSjkWhsAsOnzDBQ2NtIqXItZl6egwWGWuGJ9INz16xC8YinkmLq9kI3BAMeTU9xmK3NUWeUvSwEZx+RuVH0DhZqkbU9uJ0Ww7aayCA2WO2MNNCJNceaMvpz/qUm/9mdR/MW6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROlxpmB/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROlxpmB/"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so5044825e9.1
        for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2026 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782918824; x=1783523624; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hih0KiOWnFEJdhJRq530df2fzJs3Ws8Ka8yqQHFWY28=;
        b=ROlxpmB/imliKVCf7coV0xe2CoWxhw2UZ4aYBp6YXe0cq1z+YyQsf6sAj1dfS74F0W
         616AJo3F71tH1I7gctK4mFuNsDIVRY+ikVyjtaW8TFJxOXPi7ofgspAyyXdZN6O91zvs
         DSCiBHqiQA+JinPrb3+R9Uv31kp4gx6mIXYjK0jS5Oa4oOpgTsFXQf6z3zYozgLqCM/U
         UkGFqjdgAZMVyiW9eYsu6nnTxtV2aO8Y79FuwvF78AnTQTVA+yb6F0jno1H9R2c9e/gh
         uOVhVsw7kgHm5LcZHq5z4cS2BeOTnFvgPSSHzGBaHbKddRQgcHgO8BNiuMfhVhAtx9pE
         hYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782918824; x=1783523624;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hih0KiOWnFEJdhJRq530df2fzJs3Ws8Ka8yqQHFWY28=;
        b=gLpqWjuS+cRbqWk8iv5cLg2Cv14G98JiQxs3kvsBpNDhlhpUBw2HqhxnLonV5Ihar8
         +Wdp+3DNIbtZGyXDT4i6UtB8GhXxaZ7p9yppayyYg/5jBNpnJKsfwpMJg2XOQsuda3wq
         R9iRL8As40QW8uhtw0rPnD8XPxGEqhGY+9rrHg+x0ocmBuhYMicDFyfzwl0JIr6vGcoo
         Ak4kmOdJcc6SrQzE130qZnqyBwwn28gzfukpUmkj+ot0v7i29BNuOLkbS5TqOuzsoBf5
         nH+z+3jQLjFo0VgQRS/0aD3D0RS+qU57/3+R5cCIFX85hoee7ynC2uy2WXSQsB9c0ot4
         wfNA==
X-Forwarded-Encrypted: i=1; AFNElJ9nN4eNU8I8HoMVz4l3MC/REBZuUboVvzQBhUTSBviaUeYtl/2ITW+69fHbNC/OMFMkVudhHCvw3VU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx81fJ5klCxnl60RWIb0pcTXWN0qCgikurZLxHkoKo9JZCRzVjl
	/yWmvnzKyZX8srvPWsxtvm72/UKDWuuNw8BOI5zhfaQg6PRGZBs4FwTZ
X-Gm-Gg: AfdE7cmA6dOq3HCgx2AL0x5rjsB45h2FQ3YTXUtexGAiiDCQBdjbbNy2kXjK3yXj3ZW
	muepeDmK8BEnYVPnzwm3uh7QDp6Jx+nhLvPnPGj9akwu6JQwf6BmYhWVhRd6hwiKQEHINciSpjU
	bprp9RYJzMsf39yEW307KLQzhMFBzhT7fxHE2hnfp3GZTcJ+9ps+Piz7Y6/bKfL1H70x1vCRmta
	jXR1RwrYpP74N3Pty3LkwoloDRCDzvFlTC79OMwGDYJEc5k2kK0fHhCaI0fUYSH1VVkl2HvNVcV
	DZPlb1pJh/f08OJJuki6wehEJY/ctGWG+u4E5f4O9po3XXe+VzDmqa4tRkkdW0FoBY2Kt4ENxJJ
	rHaBpIrzV8Y6439tRxSgdjKM2hDSn4/apWPC3lVwRLya6kFHxeTiVM8c1g2UzZVc0qWWkW3Sp8J
	ngADqa
X-Received: by 2002:a05:600c:6087:b0:492:1eed:3e67 with SMTP id 5b1f17b1804b1-493c2b96d7emr34623915e9.26.1782918823652;
        Wed, 01 Jul 2026 08:13:43 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4da247sm80377005e9.7.2026.07.01.08.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 08:13:43 -0700 (PDT)
Date: Wed, 1 Jul 2026 16:14:47 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: imu: adis16550: Simplify device abstraction
Message-ID: <akUuypU25OtpCFWF@nsa>
References: <cover.1782833415.git.u.kleine-koenig@baylibre.com>
 <f9c18b3c1ee486341704f917e06b91f7a39119ec.1782833415.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9c18b3c1ee486341704f917e06b91f7a39119ec.1782833415.git.u.kleine-koenig@baylibre.com>

On Tue, Jun 30, 2026 at 05:35:35PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> The driver supports a single chip variant only. Simplify the driver by
> hard-coding the device properties instead of using the id_table's
> abstraction for a single chip type and a lookup in a table with only one
> entry.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---

LGTM

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/imu/adis16550.c | 89 +++++++++++--------------------------
>  1 file changed, 26 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
> index 75679612052f..fe0034964408 100644
> --- a/drivers/iio/imu/adis16550.c
> +++ b/drivers/iio/imu/adis16550.c
> @@ -89,25 +89,7 @@ struct adis16550_sync {
>  	u16 max_rate;
>  };
>  
> -struct adis16550_chip_info {
> -	const struct iio_chan_spec *channels;
> -	const struct adis16550_sync *sync_mode;
> -	char *name;
> -	u32 num_channels;
> -	u32 gyro_max_val;
> -	u32 gyro_max_scale;
> -	u32 accel_max_val;
> -	u32 accel_max_scale;
> -	u32 temp_scale;
> -	u32 deltang_max_val;
> -	u32 deltvel_max_val;
> -	u32 int_clk;
> -	u16 max_dec;
> -	u16 num_sync;
> -};
> -
>  struct adis16550 {
> -	const struct adis16550_chip_info *info;
>  	struct adis adis;
>  	unsigned long clk_freq_hz;
>  	u32 sync_mode;
> @@ -450,8 +432,8 @@ static int adis16550_set_freq_hz(struct adis16550 *st, u32 freq_hz)
>  	 * The optimal sample rate for the supported IMUs is between
>  	 * int_clk - 1000 and int_clk + 500.
>  	 */
> -	u32 max_sample_rate = st->info->int_clk * 1000 + 500000;
> -	u32 min_sample_rate = st->info->int_clk * 1000 - 1000000;
> +	u32 max_sample_rate = 4000 * 1000 + 500000;
> +	u32 min_sample_rate = 4000 * 1000 - 1000000;
>  
>  	if (!freq_hz)
>  		return -EINVAL;
> @@ -484,7 +466,7 @@ static int adis16550_set_freq_hz(struct adis16550 *st, u32 freq_hz)
>  	if (dec)
>  		dec--;
>  
> -	dec = min(dec, st->info->max_dec);
> +	dec = min(dec, 4095);
>  
>  	return __adis_write_reg_16(&st->adis, ADIS16550_REG_DEC_RATE, dec);
>  }
> @@ -592,30 +574,30 @@ static int adis16550_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_ANGL_VEL:
> -			*val = st->info->gyro_max_val;
> -			*val2 = st->info->gyro_max_scale;
> +			*val = 1;
> +			*val2 = IIO_RAD_TO_DEGREE(80 << 16);
>  			return IIO_VAL_FRACTIONAL;
>  		case IIO_ACCEL:
> -			*val = st->info->accel_max_val;
> -			*val2 = st->info->accel_max_scale;
> +			*val = 1;
> +			*val2 = IIO_M_S_2_TO_G(102400000);
>  			return IIO_VAL_FRACTIONAL;
>  		case IIO_TEMP:
> -			*val = st->info->temp_scale;
> +			*val = 4;
>  			return IIO_VAL_INT;
>  		case IIO_DELTA_ANGL:
> -			*val = st->info->deltang_max_val;
> +			*val = IIO_DEGREE_TO_RAD(720);
>  			*val2 = 31;
>  			return IIO_VAL_FRACTIONAL_LOG2;
>  		case IIO_DELTA_VELOCITY:
> -			*val = st->info->deltvel_max_val;
> +			*val = 125;
>  			*val2 = 31;
>  			return IIO_VAL_FRACTIONAL_LOG2;
>  		default:
>  			return -EINVAL;
>  		}
>  	case IIO_CHAN_INFO_OFFSET:
> -		/* temperature centered at 25°C */
> -		*val = DIV_ROUND_CLOSEST(25000, st->info->temp_scale);
> +		/* temperature centered at 25°C divided by temp scale */
> +		*val = 25000 / 4;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		ret = adis_read_reg_32(&st->adis,
> @@ -793,23 +775,6 @@ static const struct adis16550_sync adis16550_sync_modes[] = {
>  	{ ADIS16550_SYNC_MODE_SCALED, 1, 128 },
>  };
>  
> -static const struct adis16550_chip_info adis16550_chip_info = {
> -	.num_channels = ARRAY_SIZE(adis16550_channels),
> -	.channels = adis16550_channels,
> -	.name = "adis16550",
> -	.gyro_max_val = 1,
> -	.gyro_max_scale = IIO_RAD_TO_DEGREE(80 << 16),
> -	.accel_max_val = 1,
> -	.accel_max_scale = IIO_M_S_2_TO_G(102400000),
> -	.temp_scale = 4,
> -	.deltang_max_val = IIO_DEGREE_TO_RAD(720),
> -	.deltvel_max_val = 125,
> -	.int_clk = 4000,
> -	.max_dec = 4095,
> -	.sync_mode = adis16550_sync_modes,
> -	.num_sync = ARRAY_SIZE(adis16550_sync_modes),
> -};
> -
>  static u32 adis16550_validate_crc(__be32 *buffer, const u8 n_elem)
>  {
>  	int i;
> @@ -918,21 +883,21 @@ static int adis16550_config_sync(struct adis16550 *st)
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
>  	if (!clk) {
> -		st->clk_freq_hz = st->info->int_clk * 1000;
> +		st->clk_freq_hz = 4000000;
>  		return 0;
>  	}
>  
>  	st->clk_freq_hz = clk_get_rate(clk);
>  
> -	for (i = 0; i < st->info->num_sync; i++) {
> -		if (st->clk_freq_hz >= st->info->sync_mode[i].min_rate &&
> -		    st->clk_freq_hz <= st->info->sync_mode[i].max_rate) {
> -			sync_mode_data = &st->info->sync_mode[i];
> +	for (i = 0; i < ARRAY_SIZE(adis16550_sync_modes); i++) {
> +		if (st->clk_freq_hz >= adis16550_sync_modes[i].min_rate &&
> +		    st->clk_freq_hz <= adis16550_sync_modes[i].max_rate) {
> +			sync_mode_data = &adis16550_sync_modes[i];
>  			break;
>  		}
>  	}
>  
> -	if (i == st->info->num_sync)
> +	if (i == ARRAY_SIZE(adis16550_sync_modes))
>  		return dev_err_probe(dev, -EINVAL, "Clk rate: %lu not in a valid range",
>  				     st->clk_freq_hz);
>  
> @@ -943,7 +908,7 @@ static int adis16550_config_sync(struct adis16550 *st)
>  		 * of [3000 4500].
>  		 */
>  
> -		sync_scale = DIV_ROUND_CLOSEST(st->info->int_clk, st->clk_freq_hz);
> +		sync_scale = DIV_ROUND_CLOSEST(4000, st->clk_freq_hz);
>  
>  		if (3000 > sync_scale || 4500 < sync_scale)
>  			return dev_err_probe(dev, -EINVAL,
> @@ -955,7 +920,7 @@ static int adis16550_config_sync(struct adis16550 *st)
>  		if (ret)
>  			return ret;
>  
> -		st->clk_freq_hz = st->info->int_clk;
> +		st->clk_freq_hz = 4000;
>  	}
>  
>  	st->clk_freq_hz *= 1000;
> @@ -1064,13 +1029,11 @@ static int adis16550_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -	st->info = spi_get_device_match_data(spi);
> -	if (!st->info)
> -		return -EINVAL;
> +
>  	adis = &st->adis;
> -	indio_dev->name = st->info->name;
> -	indio_dev->channels = st->info->channels;
> -	indio_dev->num_channels = st->info->num_channels;
> +	indio_dev->name = "adis16550";
> +	indio_dev->channels = adis16550_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adis16550_channels);
>  	indio_dev->available_scan_masks = adis16550_channel_masks;
>  	indio_dev->info = &adis16550_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -1117,13 +1080,13 @@ static int adis16550_probe(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id adis16550_id[] = {
> -	{ "adis16550",  (kernel_ulong_t)&adis16550_chip_info},
> +	{ .name = "adis16550" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, adis16550_id);
>  
>  static const struct of_device_id adis16550_of_match[] = {
> -	{ .compatible = "adi,adis16550", .data = &adis16550_chip_info },
> +	{ .compatible = "adi,adis16550" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, adis16550_of_match);
> -- 
> 2.47.3
> 
