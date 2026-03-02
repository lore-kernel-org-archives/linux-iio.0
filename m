Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB4A39FCB2;
	Mon,  2 Mar 2026 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483809; cv=none; b=PfsPUeCmo9BV7W3r5NdN0wHY645ubj4ejKzPyTTfGe23knwSPEdmwd48tSfc3h5lym5ykULniWvOa9+uWnuW8XgkIbQt827s1vtSKzpOv/FayAXJwrAtYDQnWL9pMUPOSl8L2qnblL1j+h870TQk+pteJw/zxUbdnXQmGDN4Ptk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483809; c=relaxed/simple;
	bh=PD5DFa8i5X5/nP8y7O1qKeKc96AFlt8mvgh/gSZz72U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PsbnFuqMNL9N2/e8tPfVS+65giJoD37bHLj5tlnpXD3px4b8ixqaie7gRE8rjGRhDvQnR5D2+dYjLbnrEXITw71wxIHwaURGpHa3+2pk+N76ilVXuDW9MdWVJ0dpODYcdHBVR8wu7zC3wBW+S41Y/jnTTeof0MrnBky+6H4mCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD7YMhMr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD7YMhMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C20C19423;
	Mon,  2 Mar 2026 20:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772483809;
	bh=PD5DFa8i5X5/nP8y7O1qKeKc96AFlt8mvgh/gSZz72U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CD7YMhMrlTqxc1hvPQy2J2I725MolzFjbolfs/Zjf/xMKljWzmn2xviKExmUrR25b
	 joCIAe0vWYJvrfT5uoMctXnpZ0joUQS5c9Ya5iaHjtvjF4kD/Qf633uqabTn5QemTB
	 jjmtrsXZi+qihD6XWid+G57WPW0betj5Ba9dA8kDf2w9NQLvbgRg9fvZwwuXuTM12n
	 Pzl1XxrBo9fP60D0e91KPgn8M8fGEZLBEdTmyn5NPHDqcoTbufigBu/HbzzE3dRNQ/
	 Lojs3JGUlMuft41VVu8czExNs5/zu9QHr1Ef6sRO8JMoSI3FjGPToYDXAa8OKrSEdA
	 TEqgrJun7Jd8g==
Date: Mon, 2 Mar 2026 20:36:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 "David Lechner" <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 "Rob Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, Petre Rodan
 <petre.rodan@subdimension.ro>, Jorge Marques <jorge.marques@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: accel: adxl372: add support for ADXL371
Message-ID: <20260302203639.1fcec771@jic23-huawei>
In-Reply-To: <20260302122116.1282-4-antoniu.miclaus@analog.com>
References: <20260302122116.1282-1-antoniu.miclaus@analog.com>
	<20260302122116.1282-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Mar 2026 14:20:59 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the Analog Devices ADXL371, a +-200g 3-axis MEMS
> accelerometer sharing the same register map as the ADXL372 but with
> different ODR values (320/640/1280/2560/5120 Hz vs 400/800/1600/3200/
> 6400 Hz), different bandwidth values, and different timer scale
> factors for activity/inactivity detection.
> 
> Due to a silicon anomaly (er001) causing FIFO data misalignment on
> all current ADXL371 silicon, FIFO and triggered buffer support is
> disabled for the ADXL371 - only direct mode reads are supported.

Ouch.

> 

> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index d1f957adea64..10eb5bf14dad 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * ADXL372 3-Axis Digital Accelerometer core driver
> + * ADXL371/ADXL372 3-Axis Digital Accelerometer core driver
>   *
>   * Copyright 2018 Analog Devices Inc.
>   */
> @@ -182,6 +182,14 @@ enum adxl372_odr {
>  	ADXL372_ODR_6400HZ,
>  };
>  
> +enum adxl371_odr {
> +	ADXL371_ODR_320HZ,
> +	ADXL371_ODR_640HZ,
> +	ADXL371_ODR_1280HZ,
> +	ADXL371_ODR_2560HZ,
> +	ADXL371_ODR_5120HZ,
> +};
> +
>  enum adxl372_bandwidth {
>  	ADXL372_BW_200HZ,
>  	ADXL372_BW_400HZ,
> @@ -222,6 +230,29 @@ static const int adxl372_bw_freq_tbl[5] = {
>  	200, 400, 800, 1600, 3200,
>  };
>  
> +static const int adxl371_samp_freq_tbl[5] = {
> +	320, 640, 1280, 2560, 5120,
It might be a good idea to make the association of ordering an element
explicit via
	[ADXL371_ODR_320HZ] = 320,
etc

> +};
> +
> +static const int adxl371_bw_freq_tbl[5] = {

I assume these are indexed off the odr enum. If so then
	[ADXL371_ODR_320HZ] = 160, 
etc here may make sense as well.

> +	160, 320, 640, 1280, 2560,
> +};

> +		if (st->irq) {
It might be worth factoring out this block (maybe the earlier bit as well)
as a helper function in a precursor patch.  
The indent is getting rather large for such long lines.

> +			st->dready_trig = devm_iio_trigger_alloc(dev,
> +								 "%s-dev%d",
> +								 indio_dev->name,
> +								 iio_device_id(indio_dev));
> +			if (!st->dready_trig)
> +				return -ENOMEM;
> +
> +			st->peak_datardy_trig = devm_iio_trigger_alloc(dev,
> +								       "%s-dev%d-peak",
> +								       indio_dev->name,
> +								       iio_device_id(indio_dev));
> +			if (!st->peak_datardy_trig)
> +				return -ENOMEM;
> +
> +			st->dready_trig->ops = &adxl372_trigger_ops;
> +			st->peak_datardy_trig->ops = &adxl372_peak_data_trigger_ops;
> +			iio_trigger_set_drvdata(st->dready_trig, indio_dev);
> +			iio_trigger_set_drvdata(st->peak_datardy_trig, indio_dev);
> +			ret = devm_iio_trigger_register(dev, st->dready_trig);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = devm_iio_trigger_register(dev, st->peak_datardy_trig);
> +			if (ret < 0)
> +				return ret;
>  
> -		indio_dev->trig = iio_trigger_get(st->dready_trig);
> +			indio_dev->trig = iio_trigger_get(st->dready_trig);
>  
> -		ret = devm_request_irq(dev, st->irq,
> -				       iio_trigger_generic_data_rdy_poll,
> -				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> -				       indio_dev->name, st->dready_trig);
> -		if (ret < 0)
> -			return ret;
> +			ret = devm_request_irq(dev, st->irq,
> +					       iio_trigger_generic_data_rdy_poll,
> +					       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> +					       indio_dev->name, st->dready_trig);
> +			if (ret < 0)
> +				return ret;
> +		}
>  	}
>  
>  	return devm_iio_device_register(dev, indio_dev);
