Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546D2253EE;
	Sat, 31 Jan 2026 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769876896; cv=none; b=uO6vN6neLeLW6AXMj+dmWAAbA7p3Tpc7h1rzEAGomQtF0NXrbu0US2PJssp5Hzlu6W2aCYu0Mn5aM5cwEqizSAbYSYYrAcUJkFnq0HpATPDKsD2qAkckvWgFYLOF8I05OWftxUE5B5bWaYunMiMwuUl/rDZagAjiGjWgh5YVldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769876896; c=relaxed/simple;
	bh=BEtBRfTit4dIELcxbKHdR2TWAhT9f10WCj8gNS10tk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9D1ZfxeDW0rFebTbG6D0ghBJ061meAnwhGgBYWGATh+fpEAbiuFxs6oX9xGMwldQ14VMjdWhq8CKTZL9wjLUdv49mPhCXgGzAk79qb2agzQteMQRBJJkSabkajDmHcFK8rzrySzUnecGQS2GlaTTbbV6EB5ww0oL62qA69hEpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umsIXOJ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umsIXOJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3E9C4CEF1;
	Sat, 31 Jan 2026 16:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769876895;
	bh=BEtBRfTit4dIELcxbKHdR2TWAhT9f10WCj8gNS10tk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=umsIXOJ1gso9gHpoD5de8wAE+UnRgRoCTf5u00CVKCrzE+jMUmD9it+IR3epwtjJD
	 GEtKpOCX4qutWejQHug4omdBT0r1WUrTYJRpgfnCkFWunaMniHY5WGC3A03zYZUeZW
	 K72b+FQvMcf+YwQvbx+gJucQp79op08/Zzyi31J2hgOebkd/SeogwvTnFemUk+Ow/T
	 tHWpmGxKTP6dFrq4dktET3WW9FagYOCyftq26CjtgnqNIs5JFgPzJeQ+II8+VKZGmE
	 uxM06rsqGcGHyOr28MssaHgW2GIQH0SjQaguy+S7ATYiVWvlOwY3B9H272WNnRK57d
	 /5nCf7XlCME8g==
Date: Sat, 31 Jan 2026 16:28:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andrew Ijano
 <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org (open list:IIO
 SUBSYSTEM AND DRIVERS), linux-kernel@vger.kernel.org (open list),
 kernel-janitors@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH next 1/4] iio: sca3000: cache SPI device ID in probe
Message-ID: <20260131162807.137bb92a@jic23-huawei>
In-Reply-To: <20260130214323.236389-2-harshit.m.mogalapalli@oracle.com>
References: <20260130214323.236389-1-harshit.m.mogalapalli@oracle.com>
	<20260130214323.236389-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 13:43:08 -0800
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> Store the spi_device_id at probe entry and reuse it for the name and
> chip info instead of calling spi_get_device_id() repeatedly.
> 
> Reuse the local dev pointer for resource managed helpers. While at it,
> reshuffle variable list in a reverse Christmas tree order.
> 
> No functional change intended.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Hi Harshit,

A few comments inline but they are all about extra things to do rather
than really being comments on this patch which is fine as a starting point.

> ---
>  drivers/iio/accel/sca3000.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 9ef4d6e27466..afe6ef61a53b 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -1439,11 +1439,13 @@ static const struct iio_info sca3000_info = {
>  
>  static int sca3000_probe(struct spi_device *spi)
>  {
> -	int ret;
> +	const struct spi_device_id *id = spi_get_device_id(spi);

This is probably ok as an intermediate step, but ultimately we
shouldn't be using the spi_device_id at all.

id->driver_data should be a pointer to a named (not in array)
sca3000_chip_info structure and so should the data in the of_match_id
table etc.

Then we use spi_get_device_match_data() which prefers the of_device_id
table entry (which would needed adding).


> +	struct device *dev = &spi->dev;
>  	struct sca3000_state *st;
>  	struct iio_dev *indio_dev;
> +	int ret;
>  
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> @@ -1451,10 +1453,9 @@ static int sca3000_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, indio_dev);
>  	st->us = spi;
>  	mutex_init(&st->lock);
> -	st->info = &sca3000_spi_chip_info_tbl[spi_get_device_id(spi)
> -					      ->driver_data];  
> +	st->info = &sca3000_spi_chip_info_tbl[id->driver_data];
>  
> -	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->name = id->name;

This also needs an update to make it get the name from within the
chip_info structure.  Whilst this works today it can be fragile
if we have dt compatibles that don't match exactly with the spi_device_id
table entries.

>  	indio_dev->info = &sca3000_info;
>  	if (st->info->temp_output) {
>  		indio_dev->channels = sca3000_channels_with_temp;
> @@ -1466,7 +1467,7 @@ static int sca3000_probe(struct spi_device *spi)
>  	}
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = devm_iio_kfifo_buffer_setup(&spi->dev, indio_dev,
> +	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
>  					  &sca3000_ring_setup_ops);
>  	if (ret)
>  		return ret;

