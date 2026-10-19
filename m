Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB3282F20;
	Mon, 19 Oct 2026 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792374281; cv=none; b=hQ0XOBspSy7LZhugv2buxeIbgRJjJPePwfp+q2I5XWFf5YPfaktd9zq/pEPwgtBgx/xvQ5ucyauCWZCwWIrQDQiOEL/cALsgOnjbdlJlpcJrCN2bSvsFilyld4KK6cbNn8NwC1he+HZSHHc9hJnDuEyGP+6SSIjoOIu2p+Y00qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792374281; c=relaxed/simple;
	bh=7eI3IaTypjjI9p6cXdcE5Bsew3K00VFP+zPqZIWWoTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaZ4EOLjta3XXWcsJClbuZ/3hSxg2GOgU3QAUbrWxi+yRrSzI6hP4fdFIx6emHuGX3oc4CGX5ftDLoyumM69Ud431QwVo5ZbJY3qt0bCW8+6Zl5gt74ODuAD/dAUFxpmfHfo6vEmuR9ZWFwliUPEm3f9xDAlQTXtuWzD2/2RDHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgrCItbL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgrCItbL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F531F000C4;
	Mon, 19 Oct 2026 01:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792374280;
	bh=ztfhN2Zgys+821X+EG35gcoSxytBIE2DIH6v1kD6QD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CgrCItbLPcJTPs5s1r5RBB/fe5NqVZk/CHecmXNwh2/RHobkS9UDmUDQNU6KcW3qu
	 cmFf6eVvwEKPBpjKcibAQRSjPZgcrPUfxDpxfQGDFtx9s7X+mgv72f40gAT2GUZF4e
	 v80goT7ZO10T/kYPV/WGSqrs2JiJzCN3W4QhBBGMgCb9IuWmlNOuyoXr3Dg0+I5DU5
	 wAxv425vlHTGDgAJ8RjMTPQR6IFcaCsAowfsbsURqQ4FOzUaawvPIFUXtQ/K+7byXc
	 poJEsW3s4qs33nnlKDkyzE5/eFO1HxAZg1w106Q33TU/cacbtNxgpbfYn8/Q8Hisaq
	 UA2fP6IxBjdMQ==
Date: Mon, 19 Oct 2026 02:44:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Archit Anant <architanant5@gmail.com>
Cc: dlechner@baylibre.com, andy@kernel.org, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/10] iio: adc: ti-ads1015: use
 DEFINE_RUNTIME_DEV_PM_OPS()
Message-ID: <20261019024435.0acdf067@jic23-hlaptop>
In-Reply-To: <20260930171204.12863-2-architanant5@gmail.com>
References: <20260930171204.12863-1-architanant5@gmail.com>
	<20260930171204.12863-2-architanant5@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 22:41:55 +0530
Archit Anant <architanant5@gmail.com> wrote:

> Replace the deprecated SET_RUNTIME_PM_OPS() with the modern
> DEFINE_RUNTIME_DEV_PM_OPS() macro. This allows for the removal of the
> macro automatically handles dropping unused functions when PM is
> disabled.

Hi Archit,


It does more than that...  Take a look at the definition of that
macro. Key is it also uses the runtime callbacks for suspend and
resume (the sleep PM operations).

That shouldn't be a problem but good to make it clear this is a functional
change and to have a good think about whether that matters.

Thanks,

Jonathan

> 
> Update the driver struct to use pm_ptr() to avoid unused variable
> warnings.
> 
> Signed-off-by: Archit Anant <architanant5@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1015.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 0fbfa4e499aa..93a165c5416a 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -1059,7 +1059,6 @@ static int ads1015_probe(struct i2c_client *client)
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
> -#ifdef CONFIG_PM
>  static int ads1015_runtime_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> @@ -1080,12 +1079,11 @@ static int ads1015_runtime_resume(struct device *dev)
>  
>  	return ret;
>  }
> -#endif
>  
> -static const struct dev_pm_ops ads1015_pm_ops = {
> -	SET_RUNTIME_PM_OPS(ads1015_runtime_suspend,
> -			   ads1015_runtime_resume, NULL)
> -};
> +static DEFINE_RUNTIME_DEV_PM_OPS(ads1015_pm_ops,
> +				 ads1015_runtime_suspend,
> +				 ads1015_runtime_resume,
> +				 NULL);
>  
>  static const struct ads1015_chip_data ads1015_data = {
>  	.channels	= ads1015_channels,
> @@ -1140,7 +1138,7 @@ static struct i2c_driver ads1015_driver = {
>  	.driver = {
>  		.name = ADS1015_DRV_NAME,
>  		.of_match_table = ads1015_of_match,
> -		.pm = &ads1015_pm_ops,
> +		.pm = pm_ptr(&ads1015_pm_ops),
>  	},
>  	.probe		= ads1015_probe,
>  	.id_table	= ads1015_id,

