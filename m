Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4187256C61;
	Sun, 14 Jun 2026 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781448548; cv=none; b=jZiPqGoFTUVGOEUbkglxcJfDUYc21gJ6RZsdbSlyEbNByHEqOm6G6UC+cqEWjNLrlCoU8lmk1miEHITv6lHeV6CdEY+A0Mpo3py2nSg9yLeK1g4nAXSnVoC/zQRsjs2p3ylXWPFLY+gTdpSEwxKTFnhIFUJNjVzyN1yX93nNj7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781448548; c=relaxed/simple;
	bh=9HNhS0Wr07mVvaWL+DZO9QP8Czcm4BKRR1KCuC0D+6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QB5zYEFgE2p/bjAVFGRNACKzVjiMvlmU7t1wIVClpm9QOiO6UvUEJLUuEzDVGDibWm0h6KeYqPcrHdiZOmI8VqseZbCkef6xVB2RJc4H0++uL4vbKHqtYBSeATrTLbISwRqNtVWxuOARjws7sbOVisKqV+xDcbjFnRo5fck6ICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyj5aKZK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyj5aKZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BEA1F000E9;
	Sun, 14 Jun 2026 14:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781448547;
	bh=K181SurXMOCKnbDeZLwM6hC2gj+SqOl7Sd4if4LutGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oyj5aKZKEUPLlZqNuzzbUN1vEAuiP16w+GUo97O6bPXMyJYH6mpBu5TDo9z4nDO7V
	 h+OfXgEde7hnMBqDzF5HFMDBerPku1Cz4a+ToylJG2uJZ/1I5PY18/E04eglUCgbcU
	 TABbsIkqs6GjWvkWBwVxpannLAeSYrLCM4Mha0YjBZ3A/oN3BLyWDse0t325RFODO5
	 YBgEIysdIQk/+8A1cwEqpK2vV4VlPc8QHQQKhGyI5srjhwxwd2eU0mARZqaR7RsyCc
	 5C9MT2naZ1x6Nl03yTvV9dOELNs0cu1o+2daK4nsv+aHeVqFUIc50vvlVIS0qFn/gT
	 UG/KHZ3anXhbw==
Date: Sun, 14 Jun 2026 15:48:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, antoniu.miclaus@analog.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com,
 duje@dujemihanovic.xyz, jishnu.prakash@oss.qualcomm.com,
 jorge.marques@analog.com, krzk+dt@kernel.org, linusw@kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com,
 mazziesaccount@gmail.com, mike.looijmans@topic.nl, nuno.sa@analog.com,
 robh@kernel.org, sakari.ailus@linux.intel.com, wens@kernel.org,
 joshua.crofts1@gmail.com
Subject: Re: [PATCH v3 2/3] iio: adc: Add ti-ads1110 support to ti-ads1100
 driver
Message-ID: <20260614154854.6b8ea2db@jic23-huawei>
In-Reply-To: <20260613190957.654798-3-jakubszczudlo40@gmail.com>
References: <20260613190957.654798-1-jakubszczudlo40@gmail.com>
	<20260613190957.654798-3-jakubszczudlo40@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026 21:09:56 +0200
Jakub Szczudlo <jakubszczudlo40@gmail.com> wrote:

> Add ADS1110 support that have faster datarate than ADS1100, it also uses
> internal voltage reference of 2.048V for measurement.
> 
> Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Hi Jakub

A few minor things spotted on a fresh read,

Thanks,

Jonathan
> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
> index aa8946063c7d..76de2466dc53 100644
> --- a/drivers/iio/adc/ti-ads1100.c
> +++ b/drivers/iio/adc/ti-ads1100.c

>  static int ads1100_data_bits(struct ads1100_data *data)
>  {
>  	return ads1100_data_rate_bits[FIELD_GET(ADS1100_DR_MASK, data->config)];
> @@ -107,9 +145,9 @@ static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
>  
>  	pm_runtime_put_autosuspend(&data->client->dev);
>  
> -	if (ret < 0) {
> +	if (ret < 2) {

If ret < 0 we don't want to eat the error value. So normally these have some dance
like
	if (ret < 0) {
		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
		return ret;
	} else if (reg < 2) {
		dev_err(&data->client->dev, "Short I2C read\n");
		return -EIO;
	}

>  		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> -		return ret;
> +		return -EIO;
>  	}

...

> @@ -338,6 +371,12 @@ static int ads1100_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	model = device_get_match_data(dev);
> +	if (!model)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Can't get device data from firmware\n");
> +
> +	data->ads_config = (struct ads1100_config *)model;

Why is the cast needed?   If you find yourself casting away a const
it normally implies there should be a const somewhere else.
In this case I think the pointer in the structure should simply be const.

>  	ret = ads1100_setup(data);
>  	if (ret)
>  		return dev_err_probe(dev, ret,

