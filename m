Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5504733ADB1;
	Mon, 27 Jul 2026 01:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116764; cv=none; b=DuWu+cRiTHOlEpt9MlPetUSEj37ezPTTzXPJNXS/vA9ODSrD4pkUNRyCPOF2VtHyfMzsQz2D6WsCfGzE/fHQzFxxpydRLpdS/6/62sYq3ivLok/B6NT+UcYSc3n9swQ3SDTMCFyi+ZEtZn2753A2pj0BWbm+Ni1Dg2V2F1/epwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116764; c=relaxed/simple;
	bh=s5zOV5CbczTTzCmwMgSgMBvGNpBUPaZBkHglSJ3YwVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NK97rBzZZ0xGJ+A5XWZ9xzsDRe1AuzLoOV3g0M05vZ6zjjSfFItit2zMNd1uXBSIXlhSswDgd0zMIr6ZZJ4W6Tw45I1fcsD3kQQ620coM0096+O7r01mRBnvJgjQNxyPIcvftfUT2vwQnWkTOR5HXoykbQkeTtXZtV5p83HZ91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn/awESS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn/awESS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AE61F000E9;
	Mon, 27 Jul 2026 01:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785116763;
	bh=3li6Efk2sZd8J9S8K0f9OT2XOnS7tf2E5RfjGWbWKTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Dn/awESSO7SLWJV2ibUJVFfC7Rd5EnENHh70uFWL0UYk4CrHLhDWwBbhRwgXWlYjO
	 hGHl1/yU4HYITf2iiCI0cqN3wohmtE0B9M/UmXYzaXXWLeBQ/0DhrGm6M6jXbcOsyG
	 jyEUZO3kzHLzfeZXh4giClmwLq2mcSstRzN08lmGOWv+Brm5yevc3CO5ljid2upSwv
	 AOZnxM2u7EuJJT4LaCTIYNElzDDzIsY/zCNXUR+6mZbaYB/e091TzBPiLe4We0ez1f
	 Z4ldbBm/LVkUtnPi+93lbonM+Ai5ITX28/UQNpKas24eWwB9jJKwOyOgKRYmy1rMSH
	 Ij2R6/jiFZLeg==
Date: Mon, 27 Jul 2026 02:45:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-ads112c14: add continuous mode support
Message-ID: <20260727024559.513fadff@jic23-huawei>
In-Reply-To: <20260724-iio-adc-ti-ads112c14-continuous-mode-v1-2-9eb0b7a4f020@baylibre.com>
References: <20260724-iio-adc-ti-ads112c14-continuous-mode-v1-0-9eb0b7a4f020@baylibre.com>
	<20260724-iio-adc-ti-ads112c14-continuous-mode-v1-2-9eb0b7a4f020@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 15:13:11 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add support for continuous mode in the TI ADS112C14 ADC driver. In this
> mode the ADC itself is starting each conversion, so we add a trigger
> based on the DRDY interrupt to read each sample. This mode is also
> limited in that only one channel can be enabled at a time since the
> chip does not have a sequencer or simultaneous sampling capability.
> Continuous mode will only be used when this new trigger is the current
> trigger.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
Hi David,

A few comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads112c14.c | 200 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 178 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index 57e301c15314..f3a2eba55362 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c

> @@ -601,6 +625,32 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
>  	return 0;
>  }
>  
> +static int ads112c14_prepare_channel(struct ads112c14_data *data,
> +				     const struct iio_chan_spec *chan)
> +{
> +	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE)
> +		return ads112c14_prepare_measurement_channel(data, chan);
> +
> +	return ads112c14_prepare_sys_mon_channel(data, chan);
> +}

Left these visible as referred to below.

> +
> +static int ads112c14_scan_read(struct ads112c14_data *data, u8 *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(regmap_get_device(data->regmap));
> +	int ret;
> +	u8 len;
> +
> +	len = BITS_TO_BYTES(data->chip_info->resolution_bits);
> +	if (data->i2c_crc_enabled)
> +		len += 1;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA, len, buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static int ads112c14_single_conversion(struct ads112c14_data *data,
>  				       const struct iio_chan_spec *chan,
>  				       u8 *buf, bool for_scan)
> @@ -611,15 +661,9 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
>  
>  	guard(mutex)(&data->lock);
>  
> -	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
> -		ret = ads112c14_prepare_measurement_channel(data, chan);
> -		if (ret)
> -			return ret;
> -	} else {
> -		ret = ads112c14_prepare_sys_mon_channel(data, chan);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = ads112c14_prepare_channel(data, chan);

Minor obviously but maybe have these factoring out changes (to enable reuse
in the new code) as a precursor step?

> +	if (ret)
> +		return ret;
>  
>  	if (data->drdy_irq) {
>  		reinit_completion(&data->drdy_completion);
> @@ -655,17 +699,8 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
>  	 * with CRC errors, but rather leave it to userspace to decide what to
>  	 * do.
>  	 */
> -	if (for_scan) {
> -		u8 len = BITS_TO_BYTES(data->chip_info->resolution_bits) +
> -			 (data->i2c_crc_enabled ? 1 : 0);
> -
> -		ret = i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA,
> -						    len, buf);
> -		if (ret < 0)
> -			return ret;
> -
> -		return 0;
> -	}
> +	if (for_scan)
> +		return ads112c14_scan_read(data, buf);

Similar on perhaps factoring this out prior to the main change here

> +static bool ads112c14_validate_scan_mask(struct iio_dev *indio_dev,
> +					 const unsigned long *mask)
> +{
> +	if (!ads112c14_using_drdy_trigger(indio_dev))
> +		return true;
> +
> +	return bitmap_weight(mask, iio_get_masklength(indio_dev)) == 1;

Maybe use iio_validate_mask_onehot() as a kind of really obvious documentation
of this final line?

> +}
> +
> +static int ads112c14_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +	unsigned int scan_mask_len = iio_get_masklength(indio_dev);
> +	unsigned int i;
> +	const struct iio_chan_spec *chan;
> +	int ret;

Might as well target reverse xmas tree where you can.

> +
> +	if (!ads112c14_using_drdy_trigger(indio_dev))
> +		return 0;
> +
> +	i = find_first_bit(indio_dev->active_scan_mask, scan_mask_len);
> +	if (i >= scan_mask_len)
> +		return -EINVAL;

> +
> +static int ads112c14_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +	int ret, ret2;
> +
> +	if (!ads112c14_using_drdy_trigger(indio_dev))
> +		return 0;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
> +			   ADS112C14_CONVERSION_CTRL_STOP);
> +	ret2 = regmap_assign_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
> +				  ADS112C14_DEVICE_CFG_CONV_MODE,
> +				  ADS112C14_DEVICE_CFG_CONV_MODE_SINGLE_SHOT);

This is odd looking code. Needs comments on why we should prefer returning
the error for the second call over that for the first.

> +	if (ret2)
> +		return ret2;
> +
> +	return ret;
> +}


>  static int ads112c14_populate_idac_mag(u32 current_nA, u8 *idac_mag)
>  {
>  	u32 current_uA = current_nA / (NANO / MICRO);
> @@ -1458,6 +1598,21 @@ static int ads112c14_probe(struct i2c_client *client)
>  				       IRQF_NO_AUTOEN, dev_name(dev), indio_dev);
>  		if (ret)
>  			return ret;
> +
> +		data->drdy_trig = devm_iio_trigger_alloc(dev, "%s-dev%d-drdy",
> +							 info->name,
> +							 iio_device_id(indio_dev));
> +		if (!data->drdy_trig)
> +			return -ENOMEM;
> +
> +		data->drdy_trig->ops = &ads112c14_trigger_ops;
> +		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
> +
> +		ret = devm_iio_trigger_register(dev, data->drdy_trig);
> +		if (ret)
> +			return ret;
> +
> +		indio_dev->trig = iio_trigger_get(data->drdy_trig);

Given you are intending to let the trigger choice select behaviour, I'd
not have any default trigger. It's not obvious that the devices own trigger
is the right 'default' given the limitations around its use!

Jonathan

>  	}
