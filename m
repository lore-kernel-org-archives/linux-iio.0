Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30BD38D40B;
	Fri,  4 Sep 2026 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551321; cv=none; b=Da1yvi3P1bW26oiFbH0omt3JLc2xJX0mhXJ1fAoLa4aEsrlEJUF3cDxj4rj4RWEFESh4JqBvFzlQje0xxeISoBEQE/9x7wOgb1zVpiaJDjFW8+5+0aFGRdaco24Kl+rB1KRLmpIsamV8Tp8c+HvQut4LM5wieWtmJ7Dhee2d4YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551321; c=relaxed/simple;
	bh=5Rb6Sj/nVoRHIVP6k78ZHmxTfvVInsbvAH61ygpg2mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h863YewKrT6ZdECz/DzOsq8FdWkvalFdHCygp4Ln0yopHyh7MSO3ZgQH4n+Tbug4jeBEKfB/6na16y+4U1HujBG/uwTdinkJPEcIEsNT9TzRhLq8wlQ5e4qLkfbFRDrS7m9ScJ2TjmOiI0sdZTjJ6ZqyF4dqPSqSzZP79sJJ2Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uni6GzY0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uni6GzY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07471F00A3D;
	Fri,  4 Sep 2026 19:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788551309;
	bh=3rGXF7xkn2fWGND9yOwWBRorbj7VYUIVinP8569hmjo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Uni6GzY0w1zhetr07x/F45bbQ4ExRj0HJReWU6ZAu02U1eQiyZXQuEWiQUIjnEGIx
	 Oqhx71HHvIJj5SFEsIeoepw0pAWv1n1TC7is++yEJ+IXjN2DOO4BJRFj7nzyyzok5m
	 zbheAdrehWMVqkLr3op+W5udSXi0oUnr8YYdp0Ynd5mwnupRntktJtrlrfUUfx+HbE
	 NUty/3+ojuY8zMvNajnCkOwEwVvDKWjfh8WAgy/dmsXRyzpx5Fy3yJLr8hByIpkYCV
	 Sz9DSdNrNHI+Me/dJrGbVIPRlGNN0Yl5jKrjS6HKFrFlxCuQZPCjLClcmLw1gnkgvl
	 gnp4LAiRDUhUQ==
Message-ID: <bdd9e2c0-ce13-422b-90ff-0311cc251b15@kernel.org>
Date: Fri, 4 Sep 2026 21:48:21 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: axp288: Add TS bias override for Haier HV103H
To: Vladyslav Ivashchenko <cactucatu4eckuu@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Chen-Yu Tsai <wens@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260904133155.51290-1-cactucatu4eckuu@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260904133155.51290-1-cactucatu4eckuu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4-Sep-26 3:31 PM, Vladyslav Ivashchenko wrote:
> The Haier HV103H firmware configures the AXP288 TS pin bias
> current to 60 uA. This causes the battery temperature reading to
> cross the charging temperature threshold under load, incorrectly
> stopping battery charging.
> 
> Setting the TS bias current to 80 uA fixes the temperature
> measurement and prevents charging from being incorrectly disabled.
> 
> Add a DMI quirk to use the 80 uA TS bias current on the Haier
> HV103H.
> 
> Signed-off-by: Vladyslav Ivashchenko <cactucatu4eckuu@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans


> ---
>  drivers/iio/adc/axp288_adc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
> index c8283279c47..c98863d612a 100644
> --- a/drivers/iio/adc/axp288_adc.c
> +++ b/drivers/iio/adc/axp288_adc.c
> @@ -207,6 +207,14 @@ static const struct dmi_system_id axp288_adc_ts_bias_override[] = {
>  		},
>  		.driver_data = (void *)(uintptr_t)AXP288_ADC_TS_BIAS_80UA,
>  	},
> +	{
> +		/* Haier HV103H */
> +		.matches = {
> +		  DMI_MATCH(DMI_SYS_VENDOR, "Haier"),
> +		  DMI_MATCH(DMI_PRODUCT_NAME, "HV103H"),
> +		},
> +		.driver_data = (void *)(uintptr_t)AXP288_ADC_TS_BIAS_80UA,
> +	},
>  	{ }
>  };
>  

