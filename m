Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618722D7B9;
	Sun, 12 Jul 2026 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783866431; cv=none; b=MRHgDuuZCvN1qOUzXVrbed0KC1Zi+WFViUvnS/ncqE5VYGAP5AyS0HKNcnCw25oO2ZZzZvPqpNZu6sZcc1aRtOKv1BtSv/aD9LnoqwujpvqKHuyyPBq2Ez2LHp0SBWBUHfjvvlXxqBMNDb0226AWEX+v/L+UTGBnWe1WT7wR/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783866431; c=relaxed/simple;
	bh=fGCVD2fRX5DByIsQjUn3IuwPOBVulJRbW+OEnGKOixY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEOrp5n3L+ahBGlPcHjijjwkJGSQcNseVudZVsZXiHth5GQ4gx+lU0qC/qGlwJzU78H5zaU3cGbukN8JajzigpHlNrKS82HuuIPB1F8s8nzBxfLertFzn/3lVcPSVMn3e2V25yJ2l2OZ87j/3lO2iITPICuMWuNstPMwQXYscHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PY4zP43v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PY4zP43v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378281F000E9;
	Sun, 12 Jul 2026 14:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783866429;
	bh=3NAz3dHzXcZmkGlx+4kD/u7CF+TFx1/WRrl93R3R1QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PY4zP43vdgb56WoThBIgD8tyjm7/+j59UMx6waeHMIR30pta6xVqxj3A17movP7pg
	 e1o8ktlntWpUlPzSUi5pdMvN3O/WIFC3i4YLLrHc6xkKAx8nIJ0E/SV9KwV6eL+YeN
	 kAqGoO/Aruk4pMWrfR73/vgOvjaXsrotIVh8JwBM=
Date: Sun, 12 Jul 2026 16:25:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dylan Liu <pxyforeverlove1314@gmail.com>
Cc: Dylan Liu <dylanliu050903@protonmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Signed-off-by: Dylan Liu <dylanliu050903@protonmail.com>
Message-ID: <2026071227-unspoiled-blatancy-0809@gregkh>
References: <20260712141928.559844-1-dylanliu050903@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712141928.559844-1-dylanliu050903@protonmail.com>

On Sun, Jul 12, 2026 at 10:19:20PM +0800, Dylan Liu wrote:
> staging: iio: adt7316: Fix CamelCase naming for sysfs attributes
> 
> Fix multiple checkpatch.pl warnings complaining about CamelCase
> variable and function names.
> 
> In order to comply with standard Linux coding style and IIO ABI
> conventions, convert all uppercase abbreviations (AIN, DAC, Vref)
> in the adt7316 driver to lowercase snake_case.
> 
> Note that this patch changes the sysfs ABI for this driver, as
> the device attributes exposed to userspace are now lowercase
> (e.g., from 'AIN_internal_Vref' to 'ain_internal_vref'). This is
> necessary to bring the staging driver in line with the official
> IIO ABI.
> 
> Signed-off-by: Dylan Liu <dylanliu050903@protonmail.com>
> ---
>  drivers/staging/iio/addac/adt7316.c | 228 ++++++++++++++--------------
>  1 file changed, 114 insertions(+), 114 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 59fb3bd26bc1..845d79591128 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -663,7 +663,7 @@ static IIO_DEVICE_ATTR(da_high_resolution, 0644,
>  		adt7316_store_da_high_resolution,
>  		0);
>  
> -static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
> +static ssize_t adt7316_show_ain_internal_vref(struct device *dev,
>  					      struct device_attribute *attr,
>  					      char *buf)
>  {
> @@ -677,7 +677,7 @@ static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
>  		!!(chip->config3 & ADT7516_AIN_IN_VREF));
>  }
>  
> -static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
> +static ssize_t adt7316_store_ain_internal_vref(struct device *dev,
>  					       struct device_attribute *attr,
>  					       const char *buf,
>  					       size_t len)
> @@ -704,12 +704,12 @@ static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(AIN_internal_Vref, 0644,
> -		adt7316_show_AIN_internal_Vref,
> -		adt7316_store_AIN_internal_Vref,
> +static IIO_DEVICE_ATTR(ain_internal_vref, 0644,
> +		adt7316_show_ain_internal_vref,
> +		adt7316_store_ain_internal_vref,
>  		0);

You just changed the user/kernel api, right?  Are you sure this is ok to
do?

thanks,

greg k-h
