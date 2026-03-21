Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7241D2D238F;
	Sat, 21 Mar 2026 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774091896; cv=none; b=ObsNrlSPeQc8WjyXWDOSrMa3umuHrQzWtXeyAxdgatSpHcVNeZ+4HR94PvUMxyjZP4p+S0MPbyUy77Ib5/Y952MIDpoTi+lWC/Iv4NrdweC4UPA+0SwFlFEohSgzZnqk9cRAF16EKtvWzEMPo3xhiBi2Y57XebhSRgw8AlGNWg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774091896; c=relaxed/simple;
	bh=qbYquSJfO9VMqn9CRha7gwGHpjSWth4q692EvWenxlg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fllTgoByL8wdCmUJjuTCfRHuqDRc45nR/tRtxiA0ZmyVyb7/UvlwiGk9BGi/1peza8FockHww+ip1s4Mq8LR+PqcTudrBr3ecmfGFIgFtonSQuRMhx7L8bIvmlmhGUwtN/6aoKDu6wvM1aHda5yu2/1V6Pcnus0nphJ8Ba9RwYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jihw5ck/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jihw5ck/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71AFC19421;
	Sat, 21 Mar 2026 11:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774091896;
	bh=qbYquSJfO9VMqn9CRha7gwGHpjSWth4q692EvWenxlg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jihw5ck/wlYr3GVKEJJcAFT8LbWB5N3xvwM2grtT+2mSXdc6Yw3p/FhIZ+98A7aks
	 5rP9NIS5wj2q3pIU4p1iYebV05OC3oxukRJJ5O7HUTn4v1WH1mOmcUKXAdQx+N/PuB
	 RWkZePMZ/2sWnGLL9cXfIvi3ELMduOxIYJRWgVKC047ZIAYGk95QR4NsQvJR/DvExc
	 WhEFJ00vtBwRbFEKs3ErSEUmF2NIefNz0NZM7TH7hnktMmdW9xmQ01Z0GJFtdq6KuN
	 plKtJ2cGtKzm9/E+c5yX13xqo1LwSFfLpjCpr/sJm0gf/SNGxxv47WnD0ZLkx2Jn0r
	 uVuscLg+cv1wQ==
Date: Sat, 21 Mar 2026 11:18:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Petre Rodan
 <petre.rodan@subdimension.ro>, Jorge Marques <jorge.marques@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] iio: accel: adxl372: factor out buffer and
 trigger setup
Message-ID: <20260321111805.0acc00c6@jic23-huawei>
In-Reply-To: <20260321100729.2440-4-antoniu.miclaus@analog.com>
References: <20260321100729.2440-1-antoniu.miclaus@analog.com>
	<20260321100729.2440-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Mar 2026 12:04:58 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Extract the triggered buffer, trigger allocation, and IRQ request
> logic from adxl372_probe() into a dedicated adxl372_buffer_setup()
> helper. This reduces the probe function complexity and prepares for
> conditionally disabling buffer support on device variants with
> known FIFO issues.
> 
> No functional change intended.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
A couple of comments, but all about stuff you've simply moved, so not
asking for changes (though if you respin for other reasons, good
to tidy up the line wrap).

Jonathan

> ---
> Changes in v4:
>  - Use 'if (ret)' instead of 'if (ret < 0)' for
>    devm_iio_trigger_register() and devm_iio_triggered_buffer_setup_ext()
>    return checks in adxl372_buffer_setup().
> 
>  drivers/iio/accel/adxl372.c | 94 ++++++++++++++++++++-----------------
>  1 file changed, 51 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index b34b91cae753..6fd4fe0ec1d9 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -1193,6 +1193,56 @@ bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg)
>  }
>  EXPORT_SYMBOL_NS_GPL(adxl372_readable_noinc_reg, "IIO_ADXL372");
>  
> +static int adxl372_buffer_setup(struct iio_dev *indio_dev)
> +{
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +	struct device *dev = st->dev;
> +	int ret;
> +
> +	ret = devm_iio_triggered_buffer_setup_ext(dev,
> +						  indio_dev, NULL,
Not sure why this wrapping (was in original code too)
I might move these two up a line whilst applying.

> +						  adxl372_trigger_handler,
> +						  IIO_BUFFER_DIRECTION_IN,
> +						  &adxl372_buffer_ops,
> +						  adxl372_fifo_attributes);
> +	if (ret)
> +		return ret;
> +
> +	if (!st->irq)
> +		return 0;
> +
> +	st->dready_trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						 indio_dev->name,
> +						 iio_device_id(indio_dev));
> +	if (!st->dready_trig)
> +		return -ENOMEM;
> +
> +	st->peak_datardy_trig = devm_iio_trigger_alloc(dev, "%s-dev%d-peak",
> +						       indio_dev->name,
> +						       iio_device_id(indio_dev));
> +	if (!st->peak_datardy_trig)
> +		return -ENOMEM;
> +
> +	st->dready_trig->ops = &adxl372_trigger_ops;
> +	st->peak_datardy_trig->ops = &adxl372_peak_data_trigger_ops;

In original code so not something to fix in this patch, but odd mix
of dready and datardy naming. I think they are both related to data
being ready.  Either form is fine, but having both used in adjacent
lines of code not so much!  If you have time to make that consistent
in a follow up series that would be good.

> +	iio_trigger_set_drvdata(st->dready_trig, indio_dev);
> +	iio_trigger_set_drvdata(st->peak_datardy_trig, indio_dev);
> +	ret = devm_iio_trigger_register(dev, st->dready_trig);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_trigger_register(dev, st->peak_datardy_trig);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(st->dready_trig);
> +
> +	return devm_request_irq(dev, st->irq,
> +				iio_trigger_generic_data_rdy_poll,
> +				IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> +				indio_dev->name, st->dready_trig);
> +}
> +
>  int adxl372_probe(struct device *dev, struct regmap *regmap,
>  		  int irq, const struct adxl372_chip_info *chip_info)
>  {
> @@ -1227,52 +1277,10 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
>  		return ret;
>  	}
>  
> -	ret = devm_iio_triggered_buffer_setup_ext(dev,
> -						  indio_dev, NULL,
> -						  adxl372_trigger_handler,
> -						  IIO_BUFFER_DIRECTION_IN,
> -						  &adxl372_buffer_ops,
> -						  adxl372_fifo_attributes);
> +	ret = adxl372_buffer_setup(indio_dev);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (st->irq) {
> -		st->dready_trig = devm_iio_trigger_alloc(dev,
> -							 "%s-dev%d",
> -							 indio_dev->name,
> -							 iio_device_id(indio_dev));
> -		if (st->dready_trig == NULL)
> -			return -ENOMEM;
> -
> -		st->peak_datardy_trig = devm_iio_trigger_alloc(dev,
> -							       "%s-dev%d-peak",
> -							       indio_dev->name,
> -							       iio_device_id(indio_dev));
> -		if (!st->peak_datardy_trig)
> -			return -ENOMEM;
> -
> -		st->dready_trig->ops = &adxl372_trigger_ops;
> -		st->peak_datardy_trig->ops = &adxl372_peak_data_trigger_ops;
> -		iio_trigger_set_drvdata(st->dready_trig, indio_dev);
> -		iio_trigger_set_drvdata(st->peak_datardy_trig, indio_dev);
> -		ret = devm_iio_trigger_register(dev, st->dready_trig);
> -		if (ret < 0)
> -			return ret;
> -
> -		ret = devm_iio_trigger_register(dev, st->peak_datardy_trig);
> -		if (ret < 0)
> -			return ret;
> -
> -		indio_dev->trig = iio_trigger_get(st->dready_trig);
> -
> -		ret = devm_request_irq(dev, st->irq,
> -				       iio_trigger_generic_data_rdy_poll,
> -				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> -				       indio_dev->name, st->dready_trig);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(adxl372_probe, "IIO_ADXL372");

