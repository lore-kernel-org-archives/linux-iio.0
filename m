Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF2B1F16B;
	Sun, 26 Apr 2026 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777213501; cv=none; b=ZUBdSoIakgo7mnOF6EViWfb3rTI62RxZCHXzalELOXtYwBaE153Sye4oXSUyrHngNb1KcplkV/EdrTPb7Sf9Ppbf0oAlcj/54vIaXP/0AuPuIhplwOphx1aPs64r02HC6Z1rxs17kkChBdy5OCfS21IosFU4k7AUbaaFEV8Gldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777213501; c=relaxed/simple;
	bh=Db00lDLkEdOzFIK2gBoViiKjH7v9RLXbcQ5lS/h8QXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4NofVCIR/783BVQd257ncX7Dfy/VshqhQk7sLu6PrlPwikrCnc1qxfItif3/o+6FSV+rfmPQL2Wx1bdu6aGGSKFdjfKRG+vB/c09F3uRwwcMYA7XPsjwX0VOo5/WMwBvZ+zU6h2Y7eb3dWXONx7q7DrMaG1ExmQUa68i4OKc4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlkwClip; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlkwClip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F94C2BCAF;
	Sun, 26 Apr 2026 14:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777213500;
	bh=Db00lDLkEdOzFIK2gBoViiKjH7v9RLXbcQ5lS/h8QXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OlkwClipLxzA3+irO1QpiNrf25uDWGdzYqLdhIAzGC04oFedza9J78Uu+t+E5P9xP
	 IvZqff6hpSQYlmQdutHUaI25T6WygmxI96HCivF1ZY1kWyEXVLiU4UY7dh4L0KEDMi
	 PLO54cx3J3HG8OGz6FwVDUUBvMXl/YtjZFGV4FjYkep3XRBOZdXZcBGKrB6zh4hitK
	 DvffQzF9trEBoqZcinQdmhxW8hsoLZYelUUOd5p8PDIPm2O7UkzzWXs3Gkrx20Nj8B
	 zbVHMrUJ08W1MckWQIlin3z6PNszj5lw1eZAzpip6RF420jENpB6lhuxWwtkZRkcwN
	 NLM7ZnioEPobg==
Date: Sun, 26 Apr 2026 15:24:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 mingo@kernel.org, christophe.jaillet@wanadoo.fr,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 kyungmin.park@samsung.com, k.wrona@samsung.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 8/9] iio: ssp_sensors: Use dev_err_probe
Message-ID: <20260426152451.7163c0d4@jic23-huawei>
In-Reply-To: <20260426091710.3722035-9-sanjayembedded@gmail.com>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
	<20260426091710.3722035-9-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 14:47:09 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> dev_err_probe() makes error code handling simpler and handle
> deferred probe nicely (avoid spamming logs).
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
> changes in v7:
> - Drop redundant else with refactor as guided by Andy
> - Add new change in series for local dev variable with input from Andy
> - v6 change: https://lore.kernel.org/all/20260415050749.3858046-7-sanjayembedded@gmail.com/
> ---
>  drivers/iio/common/ssp_sensors/ssp_dev.c | 38 +++++++++---------------
>  1 file changed, 14 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
> index 5415efc7bf48..22d26980baa2 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -517,25 +517,19 @@ static int ssp_probe(struct spi_device *spi)
>  	int ret, i;
>  
>  	data = ssp_parse_dt(dev);
> -	if (!data) {
> -		dev_err(dev, "Failed to find platform data\n");
> -		return -ENODEV;
> -	}
> +	if (!data)
> +		return dev_err_probe(dev, -ENODEV, "Failed to find platform data\n");
>  
> -	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> -				   sensorhub_sensor_devs,
> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, sensorhub_sensor_devs,

Unrelated change. Should not be in this patch.

>  				   ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
> -	if (ret < 0) {
> -		dev_err(dev, "mfd add devices fail\n");
> -		return ret;
> -	}
> +

Normal to not have a blank line between call and error check, so why one here?

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "mfd add devices fail\n");
>  
