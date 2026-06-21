Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B62E3C07A;
	Sun, 21 Jun 2026 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782068912; cv=none; b=PGtTqis7iQLDmM9KhYATzgTDWepNMorHQHhlxr/PPHNsFEgfrgBHaUXe8CJ+WdFG0iT7/Gj1jR+nWuyqcdi7vR+ZlWvT4ioVMohNw350yXiX8ac4F4fcXTRIoYhe9l3vO78/Jny82NMww1KH1bE1Wz3+bHrLEt6VD9EXhojv5ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782068912; c=relaxed/simple;
	bh=hwHHg1nhNiMst2GmjecjJ837/XjDteatYFWHQFqzlB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLTOX2veYN2SLRy7y80dlS/f+e8Ttdr/dHClRTEA3DS7eWPC9JrkuOkUcuwiZrCMLPTaOnIkytSFDwNm6x4m3t+WMYlRq4Z7uy+eYSfy2gXlggGvj3jwPQYvVTaYR6GNgikGEnFeaNzdvZU06nktUuhGGHUalarli/lvXDQGbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvVhAf+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvVhAf+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE231F000E9;
	Sun, 21 Jun 2026 19:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782068911;
	bh=w5a1BQF4sDXeIpCf+et312iRiceYeZ/DOjps9vQmPoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jvVhAf+Jbrl/EDHHAJDanJ/ucUZyFSOeCrNJe2TawXGpOHz/Q61zdJnUxnTIAOB6m
	 dQW7XO54uRZD1Ha4hUwa8O5tFLi+cTIuFGEDr8lBZUNqN79yHg6SaM2XVW2uWmsryn
	 cs/fDtNH5A/b5heRSDHLOBvmZQpKRPAFT1TDjCMC5NsHo1EUG6kubQX+Nx+2Js8a8h
	 2xQjm8M0rY1i2gJT+DDU73xDWrZv6hcRwaVZrZk7uHZ5rEG41u0SV7k4G9rw3YNz3+
	 nPXGoZ6JXdiEfK0DZ12OiEgKMR2kPsgJkhvqYjAsrdFTBrIrcgefXR/ZxwV8X/Q39D
	 LmvWZYtlK9wTQ==
Date: Sun, 21 Jun 2026 20:08:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kurt Borja
 <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: adc: ti-ads112c14: add measurement channel
 support
Message-ID: <20260621200821.0cfffe34@jic23-huawei>
In-Reply-To: <20260615-iio-adc-ti-ads122c14-v1-4-e6bdadf7cb2b@baylibre.com>
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
	<20260615-iio-adc-ti-ads122c14-v1-4-e6bdadf7cb2b@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 17:00:02 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add support for parsing devicetree properties for measurement channels
> and doing direct reads on these.
> 
> There are quite a lot of conditions that have to be met for each
> measurement to be made, so quite a bit of state and algorithms are
> required to handle it.
> 
> Channels are created dynamically since the number of possibilities is
> unreasonably large.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
Trivial stuff. Seems the bulk of discussion here is in the dt vs
channel mappings area. I'll probably reply to that in a few mins.

> @@ -449,25 +599,31 @@ static int ads112c14_write_raw(struct iio_dev *indio_dev,
>  			       int val2, long mask)
>  {
>  	struct ads112c14_data *data = iio_priv(indio_dev);
> +	const int (*scale_avail)[2];
> +	u8 *gain_val;
> +
> +	if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
> +		scale_avail = data->sys_mon_chan_short_scale_available;
> +		gain_val = &data->sys_mon_chan_short_gain_val;
> +	} else if (chan->channel < 100) {
> +		scale_avail = data->measurements[chan->scan_index].scale_available;
> +		gain_val = &data->measurements[chan->scan_index].gain_val;
> +	} else {
> +		return -EINVAL;
> +	}
>  
> -	switch (chan->channel) {
> -	case ADS112C14_SYS_MON_CHANNEL_SHORT: {
> -		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> -		if (IIO_DEV_ACQUIRE_FAILED(claim))
> -			return -EBUSY;
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
Anything stop you doing this in the earlier patch?

>  
> -		for (u32 i = 0; i < ARRAY_SIZE(data->sys_mon_chan_short_scale_available); i++) {
> -			if (val == data->sys_mon_chan_short_scale_available[i][0] &&
> -			    val2 == data->sys_mon_chan_short_scale_available[i][1]) {
> -				data->sys_mon_chan_short_gain_val = i;
> -				return 0;
> -			}
> +	for (u32 i = 0; i < ARRAY_SIZE(ads112c14_pga_gains_x10); i++) {
> +		if (val == scale_avail[i][0] && val2 == scale_avail[i][1]) {
> +			*gain_val = i;
> +			return 0;
>  		}
> -		return -EINVAL;
> -	}
> -	default:
> -		return -EINVAL;
>  	}
> +
> +	return -EINVAL;
>  }
>

>  
>  static int ads112c14_probe(struct i2c_client *client)
> @@ -547,6 +876,9 @@ static int ads112c14_probe(struct i2c_client *client)
>  	const struct ads112c14_chip_info *info;
>  	struct iio_dev *indio_dev;
>  	struct ads112c14_data *data;
> +	bool need_avdd_ref, need_ext_ref;
> +	u32 refp_uV = 0;
> +	u32 refn_uV = 0;
>  	u32 reg_val;
>  	int ret;
>  
>
> +	if (device_property_present(dev, "refp-supply")) {
> +		ret = devm_regulator_get_enable_read_voltage(&client->dev, "refp");
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to get refp voltage\n");
> +
> +		refp_uV = ret;
> +
> +		struct fwnode_handle *refp_fwnode __free(fwnode_handle) =
> +			fwnode_find_reference(dev->fwnode, "refp-supply", 0);
> +		if (IS_ERR(refp_fwnode))
> +			return dev_err_probe(dev, PTR_ERR(refp_fwnode),
> +					     "failed to get refp fwnode\n");
> +
> +		struct fwnode_handle *avdd_fwnode __free(fwnode_handle) =
> +			fwnode_find_reference(dev->fwnode, "avdd-supply", 0);
> +		if (IS_ERR(avdd_fwnode))
> +			return dev_err_probe(dev, PTR_ERR(avdd_fwnode),
> +					     "failed to get avdd fwnode\n");
> +
> +		data->refp_is_avdd = refp_fwnode == avdd_fwnode;

Add a comment somewhere on why we care.  I wonder how common this is. Maybe
a generic helper? Even if it isn't common lets have a helper here!
fwnode_same_reference() or something like that.

 
> +	}
> +
> +	if (device_property_present(dev, "refn-supply")) {
> +		ret = devm_regulator_get_enable_read_voltage(&client->dev, "refn");
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to get refn voltage\n");
> +
> +		refn_uV = ret;
> +	} else {
> +		data->refn_is_gnd = true;
> +	}
> +
> +	data->ext_ref_uV = refp_uV - refn_uV;
> +
> +	if (device_property_present(dev, "refp-refn-resistor-ohms")) {
> +		if (refp_uV != 0 || refn_uV != 0)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "refp-refn-resistor-ohms property should not be present when refp-supply or refn-supply is present\n");
> +
> +		ret = device_property_read_u32(dev, "refp-refn-resistor-ohms",
> +					       &data->ext_ref_ohms);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to read refp-refn-resistor-ohms property\n");
> +	} else {
> +		if (need_ext_ref && data->ext_ref_uV == 0)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "external reference measurements require either refp-supply or refp-refn-resistor-ohms property\n");

> +	}

