Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2B730CD89;
	Sat,  1 Aug 2026 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785609561; cv=none; b=KIxldGpvsiWpLHcMDEqZGapQGxJ3UueMyZYKP2dQjL1iKCsdiYPls+K9dq+RCUqmPanRgIi+znsWOW8RFxIf0ueMKQUclXiOWzNnbQMOYu3j2SDl48AmtYDGVmfcakYoppfRHWnLBoLaXrY9Gq/W1GKd3YwBhHiS2yJyuczomGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785609561; c=relaxed/simple;
	bh=fR/YmPqkekz6fT1brEG7EZV8IXKsOH5+oTpZLJV9GHU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e60j7Gmvt7Zlj/G3Ig3a61Xh6n40AREaCa47M3NQbkm76wOL6gMPJM8Q5Zf+MTi2UXRLa12lLfhBxBw2YY/BHSRUe0aR392hln3lY2E3Lwbycu/CFfmClq6tGBfclVdTXRf+JBi+vR6wDy5m8lMF3MsfiOfHh7U57Eg5XSkH8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpvAuBPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpvAuBPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60611F00AC4;
	Sat,  1 Aug 2026 18:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785609560;
	bh=ND+nRpKvPEK+U0Iu6h+0hru0ayZpKw5B5obwQxfYiK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mpvAuBPJX5CzbKdVXhuJTI0VQLWLzrpTkF3439pdcZJOEedKh6M98j04LT44G5Jut
	 LtuHraaItUScnVtsHQuwqllx7LIQ/0v4Yj/CyMu318J1GApiSe2RbaY5aulNjdOZa0
	 bbCvQm3ld8awabf/QOavGvyuquy8Cp8uVcn257xmZRZvDpzp1LLsZ70Qztz/annTAN
	 ADVSjIpxbBMbS+g/kPIAnDgTcCXrNUnF6xd0RtE8AGM4hPNdJw9HT+fuHvyHy9I1pW
	 TCFbj5wHrEVwimq82hdAxVEG26LMQthgBaRDupwL+k0g2zpgnjjwN+NmQ9D6T6deSZ
	 b3/vvVRJhIBGA==
Date: Sat, 1 Aug 2026 19:39:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Archit Anant <architanant5@gmail.com>
Cc: dlechner@baylibre.com, andy@kernel.org, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: adc: ti-ads1015: use dev_err_probe() for
 error handling
Message-ID: <20260801193916.442d08d4@jic23-huawei>
In-Reply-To: <20260727192102.37968-6-architanant5@gmail.com>
References: <20260727192102.37968-1-architanant5@gmail.com>
	<20260727192102.37968-6-architanant5@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 00:51:01 +0530
Archit Anant <architanant5@gmail.com> wrote:

> Simplify the error handling paths in ads1015_probe() and
> ads1015_client_get_channels_config()  by converting dev_err()
> calls that are immediately followed by a return statement
> over to the modern dev_err_probe() helper.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Archit Anant <architanant5@gmail.com>

Ah. This doesn't pick up all the places I was expecting when reviewing
previous patch.  It should definitely include the dev_err_probe()
for iio_device_register() - that won't be change just because
you move to devm_iio_device_register() in the next patch.

> ---
>  drivers/iio/adc/ti-ads1015.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 59ce2f89daeb..a8dba4e5aed3 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -883,18 +883,16 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
>  
>  		if (!fwnode_property_read_u32(node, "ti,gain", &pval)) {
>  			pga = pval;
> -			if (pga > 5) {
> -				dev_err(dev, "invalid gain on %pfw\n", node);
> -				return -EINVAL;
> -			}
> +			if (pga > 5)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "invalid gain on %pfw\n", node);
>  		}
>  
>  		if (!fwnode_property_read_u32(node, "ti,datarate", &pval)) {
>  			data_rate = pval;
> -			if (data_rate > 7) {
> -				dev_err(dev, "invalid data_rate on %pfw\n", node);
> -				return -EINVAL;
> -			}
> +			if (data_rate > 7)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "invalid data_rate on %pfw\n", node);
>  		}
>  
>  		data->channel_data[channel].pga = pga;
> @@ -978,18 +976,16 @@ static int ads1015_probe(struct i2c_client *client)
>  	data->regmap = devm_regmap_init_i2c(client, chip->has_comparator ?
>  					    &ads1015_regmap_config :
>  					    &tla2024_regmap_config);
> -	if (IS_ERR(data->regmap)) {
> -		dev_err(dev, "Failed to allocate register map\n");
> -		return PTR_ERR(data->regmap);
> -	}
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "Failed to allocate register map\n");
>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
>  					      ads1015_trigger_handler,
>  					      &ads1015_buffer_setup_ops);
> -	if (ret < 0) {
> -		dev_err(dev, "iio triggered buffer setup failed\n");

Leave the switch from client->dev for this patch then we don't end up changing
same line twice.  Just add a brief comment to say you are taking advantage
of the now available local dev pointer.

> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "iio triggered buffer setup failed\n");
>  
>  	if (client->irq && chip->has_comparator) {
>  		unsigned long irq_trig = irq_get_trigger_type(client->irq);

