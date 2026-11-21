Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795289094;
	b=U2dlBW6J2TLwGOBq+2WmLsvO69roSsyoVuTk9FsJD5zk108oaFMZ9JaXpBI/ol2uk5/G
	 3827XoW54i7akm0jMANKX4OTgXalha54H3zNIdsRQsGPjj2tT/Q3eMWR0E0YNxcaZWdDS
	 C3SaiC8K5M0QeZYf7XflYI1kRLVwOWkwhkHZsyAJ/jMEhOske4gU7FPC/ydoX5w4JDBV/
	 5IfHT9v/fg4cjKHtmlEQfauQsIR2bfGhLWDzCDsNkXnOzEHOUd1HcVa03f+Gs/MubaWeS
	 sMgcq+Jui+z9DRecY5fRMexokbOQvvO6Z5JKRR5ps3BezCOx4ExfDqmSaQ3cDXbZVwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795289094;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9Upa2rDL0IbqUOOoHVhvAzVcvXqcJkxpHOm0IGBGtQk=;
	b=bleT0ZMeJCJlma7SrOQozpErMjCRphSnTdSiP+K6ZR6PUEbyqmyONEY5AcNdSj0h020d
	 uC0+SiXCkycXU8MIWBCjj33jmmaVMpYEVhHNEUVR5bTboV5+sxf0dVdEMdW4Zr20GGmvp
	 6xQTcF6lDBxeSgJvHVhNJEl2c+SUMumUybn3s9Q1kvoShSMejcYHLNRVCrRSOBVciLbsG
	 d5PKCMDSaszKdH0BxqW5iRwu+gVZaqmB/L6NQwwN8VgrNgwRK5QwqcRMTLqzTKRf60rwn
	 KDA2/OG8eqd4+UN4L3bH0BHxyqqBvFp/+OVwh7GJezjauXfIXiB1Cg7s246fugd3ZDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDbz26tZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD8E606A320
	for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDbz26tZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA061F000C0;
	Sat, 21 Nov 2026 19:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795289094;
	bh=9Upa2rDL0IbqUOOoHVhvAzVcvXqcJkxpHOm0IGBGtQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XDbz26tZ3VW1bGp60G49FO/R1UMD13gcyihsJ6RpcVgDJO84BaZDTkkNEf7Bky06s
	 NXVJslCsnDPgdLU5Zy4hZRdxQr+LN8Lw/jKo0cQ5Ucz4hLD0C5i5ZcAiiZKGxS+vJA
	 cPF7CKGTLS1U/u9L2eIG4xUmfpgYgjTuO0S4VL0GwmbK5htBDLKCvDWwwJaSlFTf3e
	 bAZYLnW9Hgxe5NBfY8o+AiGOQiSiAzW8PhyUGOfkq7yRQwk8aw7ZIMmulQLxmf0EJE
	 xuy+I98KLCi6Byw8SFTadoOAWKFiHO59xwWhsoFDopYnPEtUi+L1d2sGd8wYFzaxg7
	 PXZOUDdJm3+8A==
Date: Sat, 21 Nov 2026 19:24:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Wanhui Fu <fuwh1120@163.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 dakr@kernel.org, kees+treewide@kernel.org,
 giorgitchankvetadze1997@gmail.com, u.kleine-koenig@baylibre.com,
 linux-iio@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] iio: twl6030-gpadc: Add error handling path in
 twl6030_gpadc_probe()
Message-ID: <20261121192448.78041532@jic23-hlaptop>
In-Reply-To: <20261121082419.376423-1-fuwh1120@163.com>
References: <20261121082419.376423-1-fuwh1120@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Nov 2026 16:24:19 +0800
Wanhui Fu <fuwh1120@163.com> wrote:

> Add an error handling path to call twl6030_gpadc_disable_irq(),
> as twl6030_gpadc_remove() does.
> 
> Signed-off-by: Wanhui Fu <fuwh1120@163.com>
Fix is fine, but I'd rather not make already ugly code uglier.
There is an oddity in here though that makes a simple cleanup trickier.

Why is in remove is the interrupt disabled before the userspace interfaces
are removed?  Looking back at the history (lore search for the
disable function) it seems that the driver was way off on ordering,
most of it got fixed up back 2013 but this one didn't.
https://lore.kernel.org/all/1376910580-7545-1-git-send-email-oleksandr.kozaruk@ti.com/

Given how old it was I doubt this ordering was intentional.

So...  Lets do the more significant cleanup.

First add a devm_add_action_or_reset() to remove the manual handling
of the interrupt disable (which is equivalent of this fix) then convert
the only remaining call to devm_iio_device_register() in a follow up
patch.

Long shot, but last real change to this driver was in 2022 by Andreas
so if anyone is likely to have hardware to test probably Andreas.
+CC.  Given it's remove path anyway and that would be rarely used
for a soc ADC driver, I'm not that concerned if we can't test this
change.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/twl6030-gpadc.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index e7fd371b3404..8dae7561320f 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -931,19 +931,19 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
>  					TWL6030_REG_TOGGLE1);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to enable GPADC module\n");
> -		return ret;
> +		goto err_disable;
>  	}
>  
>  	ret = twl_i2c_write_u8(TWL_MODULE_USB, VBUS_MEAS, USB_VBUS_CTRL_SET);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to wire up inputs\n");
> -		return ret;
> +		goto err_disable;
>  	}
>  
>  	ret = twl_i2c_write_u8(TWL_MODULE_USB, ID_MEAS, USB_ID_CTRL_SET);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to wire up inputs\n");
> -		return ret;
> +		goto err_disable;
>  	}
>  
>  	ret = twl_i2c_write_u8(TWL6030_MODULE_ID0,
> @@ -951,7 +951,7 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
>  				TWL6030_MISC1);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to wire up inputs\n");
> -		return ret;
> +		goto err_disable;
>  	}
>  
>  	indio_dev->name = DRIVER_NAME;
> @@ -960,7 +960,17 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
>  	indio_dev->channels = pdata->iio_channels;
>  	indio_dev->num_channels = pdata->nchannels;
>  
> -	return iio_device_register(indio_dev);
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register iio device\n");
> +		goto err_disable;
> +	}
> +
> +	return 0;
> +
> +err_disable:
> +	twl6030_gpadc_disable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
> +	return ret;
>  }
>  
>  static void twl6030_gpadc_remove(struct platform_device *pdev)

