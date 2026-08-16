Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DE8217704;
	Sun, 16 Aug 2026 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786911979; cv=none; b=OkwTGbDpOvMzysxDyVl20l9MDpLrRBXfqWiA4ediVlirVg0dfy3yasYfMCMBGQNzcjb5imzLDcOatU7HOi/k3tjJ/vU5lerqs+QBpoHAzmG0LeEGSpSKD5sakP6r+hchWXDrtkR/LeQaDAq8NU0hcKIFjhYRjf7uijtM5tW77p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786911979; c=relaxed/simple;
	bh=S1/dh9mswyDvENoNz2djJZQCJVtqOAKGy+m1sUK1dFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLZhtV1HvOzJs6K7pKkj3azdDV9kbB5ygD6Dru/PmH9vZRMS7JyJSMHMrJtIc8QuL4Qi0JOcxpPnIByjW0o1h9pl/CyrwGiWA6haBazzcXpGdmXYS5sP7/MlZh//RVMQ4zPysVsgX+cSJAwM5NA88hUq9wPABzyD4GOstxmowI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3dLN3G7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3dLN3G7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E851F000E9;
	Sun, 16 Aug 2026 20:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786911978;
	bh=IeBVEWU8Il3pmisz3zcoFiY0oKD1GxYmwHcLWT+EDFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X3dLN3G7ot9xlXwANeiHRGPr4YvChLJRrSRKuWRfTxKPVNpW0JAnRVTFcukryRY75
	 1RuRn6y1P+uRLq9ovcNRakZXCXFHBXZjVunlptjm1wiuIPYibz0CiFltk9d8iKOeZP
	 qgCWcLAl+P6rVsaIPfXgbzH+Z+K+aVxONqb04UNaBfUAMqmaP2OXttVaVelJ7v7TcW
	 B8dGgzqUlANRphJrGxINM+WwS4eER2K/fVQa80XoXJAVq+3tniwNok7TWho7JKTf/1
	 LReErAsx9Q0YyMUvURCDlraEhKwO7JczoNyctHntrwC2LjCd33IYZetkXk6kKUbRsv
	 FUmVmHW8ImBxg==
Date: Sun, 16 Aug 2026 21:26:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: adc: ti-ads112c14: add continuous mode
 support
Message-ID: <20260816212612.4512d694@jic23-huawei>
In-Reply-To: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-3-76e0d30e6c6b@baylibre.com>
References: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-0-76e0d30e6c6b@baylibre.com>
	<20260807-iio-adc-ti-ads112c14-continuous-mode-v3-3-76e0d30e6c6b@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Aug 2026 16:19:48 -0500
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

regmap_assign_bits() usage here is a bit odd.
It is just a bool taking wrapper around set_bits and clear_bits.

It 'works' here because the values are 0 and 1.
There isn't a natural bool for these two modes, so to make this look right
you'd end up with something like:

ADS112C14_DEVICE_CFG_CONV_MODE_SINGLE_NOT_CONT 
and that is horrible. So I'd just use FIELD_PREP() and definitions
for the two values.


Otherwise looks fine to me.

J
> +
> +static int ads112c14_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!ads112c14_using_drdy_trigger(indio_dev))
> +		return 0;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
> +			   ADS112C14_CONVERSION_CTRL_STOP);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_assign_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
> +				  ADS112C14_DEVICE_CFG_CONV_MODE,
> +				  ADS112C14_DEVICE_CFG_CONV_MODE_SINGLE_SHOT);

This looks odd as last parameter that takes is a boolean.
I think you just want an update_bits + appropriate FIELD_PREP()


> +}
> +
> +static const struct iio_buffer_setup_ops ads112c14_buffer_setup_ops = {
> +	.postenable = ads112c14_buffer_postenable,
> +	.predisable = ads112c14_buffer_predisable,
> +	.validate_scan_mask = ads112c14_validate_scan_mask,
> +};
> +
>  static int ads112c14_populate_idac_mag(u32 current_nA, u8 *idac_mag)
>  {
>  	u32 current_uA = current_nA / (NANO / MICRO);
> @@ -1480,6 +1594,19 @@ static int ads112c14_probe(struct i2c_client *client)
>  				       0, dev_name(dev), indio_dev);
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
>  	}
>  
>  	ads112c14_populate_tables(data);
> @@ -1490,7 +1617,8 @@ static int ads112c14_probe(struct i2c_client *client)
>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  					      iio_pollfunc_store_time,
> -					      ads112c14_trigger_handler, NULL);
> +					      ads112c14_trigger_handler,
> +					      &ads112c14_buffer_setup_ops);
>  	if (ret)
>  		return ret;
>  
> 

