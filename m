Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160741A9F8C;
	Sat, 14 Feb 2026 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771095632; cv=none; b=bKGxIbM0nyUMxSPfHWvrZ8xEPSKP54dSsGkYUNWBeNWjsYFpFR+IyVLA333O3ufFIPHcmgdur1nCyelvAjW2Mj+QuNBaOcEBWaQPjVO0pJXo3ySpINcFaA/5Y3ZYxiwybkSyA7vXZOvvQMe1i4hYoyTiRqYXtzlojzDJBcxgNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771095632; c=relaxed/simple;
	bh=7c8YLKG3qB8xEe1XLsCiICry3oBIBZOxGSzsjU6Ey3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyZ14kVlKh+nXAkC4xsOjmUfwTpsmQNEZSmuW8xL6+wwIDs5XtAj4Gge+XrZZ3CD8wbPTbVcBOQOCV3TVDTLxEZEKA+Z1UlDEMGvNOtU/Akt/STALxoFavAOhh2j1GdVRbDI7eStqw4OVCG5stl1P+0DIfGp7MrzQGJX2BABQ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIAgU+kq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIAgU+kq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E80C19421;
	Sat, 14 Feb 2026 19:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771095631;
	bh=7c8YLKG3qB8xEe1XLsCiICry3oBIBZOxGSzsjU6Ey3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hIAgU+kqiF87iW6PgYL53WvGZsvy1JZ+f3r9YN6xIeAERx6iZMl8F1TGiIHuqm0Gj
	 caHHT1RD/c3e8/1N02gPFwbTGB+LOC2qw6mWstn0c7kOICvkzjmDuLHJbr7MiV1NBt
	 iTvoYfzkAT2Ynk5q16KGqSchfoz+rl+/Bz7DYDRfBQM+LRYnwdx+TyNfKYzm6da+d7
	 cT2fCgBtQ9u2RGNHwmq9XJW0aVTJoNDdn1oDHG0G5IzKZIBA5jaShPZa1NUtGMFGt1
	 aU1H96bMakOS7+aFgCUrRapbEPg5ZO/1ZfxAWesHiJ1RZdIlxAylrAs4UyIgGOqjEh
	 aByYS+o+RQ1Kw==
Date: Sat, 14 Feb 2026 19:00:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 09/11] iio: amplifiers: ad8366: add device tree
 support
Message-ID: <20260214190021.4eee6215@jic23-huawei>
In-Reply-To: <20260210-iio-ad8366-update-v4-9-15505f7b15b4@analog.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
	<20260210-iio-ad8366-update-v4-9-15505f7b15b4@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 19:42:09 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Drop the enum ID, split chip info table into per-device structs
> and add of_match_table.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Hi Rodrigo

A few more related things to update whilst you are doing this.
In general looks good.

Thanks

Jonathan

> +
> +static const struct ad8366_info hmc1119_chip_info = {
> +	.gain_min = -31750,
As below. Add
	.name = hmc1119,
and similar to all of these.
> +	.gain_max = 0,
> +	.gain_step = -250,
> +	.num_channels = 1,
>  };
>  
>  static int ad8366_write_code(struct ad8366_state *st)
> @@ -229,7 +224,7 @@ static int ad8366_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, ret, "Failed to get regulator\n");
>  
>  	st->spi = spi;
> -	st->info = &ad8366_infos[spi_get_device_id(spi)->driver_data];
> +	st->info = spi_get_device_match_data(spi);

Also drop the remaining use of spi_get_device_id() in setting the
name. There are fun issues that arise with using spi_get_device_id() at all
when fallback compatibles are a possibility (which they always are) and
so we are much better off just having the name strings also in the 
ad8366_info structures.

>  
>  	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
>  	if (IS_ERR(rstc))
> @@ -250,18 +245,29 @@ static int ad8366_probe(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id ad8366_id[] = {
> -	{"ad8366",  ID_AD8366},
> -	{"ada4961", ID_ADA4961},
> -	{"adl5240", ID_ADL5240},
> -	{"hmc792a", ID_HMC792},
> -	{"hmc1119", ID_HMC1119},
> +	{"ad8366", (kernel_ulong_t)&ad8366_chip_info},
Given you are touching it anyway can you add space after { and before }
Thanks!
> +	{"ada4961", (kernel_ulong_t)&ada4961_chip_info},
> +	{"adl5240", (kernel_ulong_t)&adl5240_chip_info},
> +	{"hmc792a", (kernel_ulong_t)&hmc792_chip_info},
> +	{"hmc1119", (kernel_ulong_t)&hmc1119_chip_info},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ad8366_id);
>  
> +static const struct of_device_id ad8366_of_match[] = {
> +	{ .compatible = "adi,ad8366", .data = &ad8366_chip_info },
> +	{ .compatible = "adi,ada4961", .data = &ada4961_chip_info },
> +	{ .compatible = "adi,adl5240", .data = &adl5240_chip_info },
> +	{ .compatible = "adi,hmc792a", .data = &hmc792_chip_info },
> +	{ .compatible = "adi,hmc1119", .data = &hmc1119_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad8366_of_match);
> +
>  static struct spi_driver ad8366_driver = {
>  	.driver = {
> -		.name	= KBUILD_MODNAME,
> +		.name		= KBUILD_MODNAME,
> +		.of_match_table	= ad8366_of_match,
>  	},
>  	.probe		= ad8366_probe,
>  	.id_table	= ad8366_id,
> 

