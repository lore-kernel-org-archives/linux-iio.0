Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F7A3A7F6F
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786214448; cv=none; b=ZxSXsRFplKDjhin47l6bIq0fVjXFVGymggGwEB7721mK0T+APSaGSS1xYlwquvsZao+WsXegynkdcKNOslRvE2+yjf8H8BDNdUsI2+NfjZJbKcXIKoPlt3bGJ8L8PS7ZFiqtNl3FYnkwQp7Jlx5rf6T+lddVclC2xB2jyF9jMlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786214448; c=relaxed/simple;
	bh=FoVSqAX9Cubv9+S4g1XZ9guo+pxeW6BoILi4tAxvEN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNHhNQeJT2nYVKkYk4l+x0Xp6yNBPcq6zQ6YhmIsm06eQ/atpVR07OUpJwkovXizK8dX1sNmLfVN0BixeHJNzOkSeVGXKrCqHpDrPEQu9pJ/ojY6JSd07ogQwHlHnFTA1y80gJc6aXvSGGAr8b37/3yW2QTt4aOscZzlBEhInvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BOmOJtfW; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BOmOJtfW"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6aae90e595fso230205eaf.1
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786214446; x=1786819246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=55sctIR2HSJQXFMzWfmfJXeh2M58cCZiDe00f0EVIXw=;
        b=BOmOJtfW9Iegj5XVZLiC+C0xTbSG+FQnQv8iVBlNmOUTPceXTfKmfyi8p7fTz7qdkg
         GzdEhZZxrMQmB9+NPwX8EsHNilV0JLOiUAXx+n+LTN4ZdxOurefwYSDOIVc+HH2B9U3c
         lemCJ1PUc8xI2AC7QzCudWJyyJweXK7rFpFfUYfva976wgibKn2+7LTOpihtk6WX4P1D
         IjQ1sBXr7CESg5SELqr1V7fcyFp4nLilaKHX9SruTs1/iCoPztvXkcfwgGoFOqMYsZ9E
         sS39ZNrw6T16gi738aiUkVmnXj2vbbQCytLL6kFykTN2OueNtbP4BXsIs0TLui2sZP9a
         ng7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786214446; x=1786819246;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=55sctIR2HSJQXFMzWfmfJXeh2M58cCZiDe00f0EVIXw=;
        b=T0ouDFD9ZhtbWFp+FMGMsE44TSsY64EciJOg/O1WD6f7nMgSFVnHRHgSRmbhpx6V+h
         5y48AajDqxF5VvAKJihVd1zA9y8JTB9ytWw9dXHV/zZ8flLOrdeISIoaGi+mIruziW3K
         zrQrQZviZLbedN/talsTYFQVx0o0p31cnTfOGKyiUndP0+4/6fjasJJxpIUvVsAyAJlV
         6cZyGTb4KN3siUU6LLXSSavXeUbMBeHCpLHu9pcsjEgELw/3Ptp00O9sKdkR0pv2WyGo
         0h0dVux0/gCzdMsfbUjSYHj4nz5x/AAGF/Ghqqioe3dton/IJNjl0ChupYooJ9JzcaCj
         wFZw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0nRoNBa92dZceW8HO6CVas4fKOyDWB4tqbHA8uB+FNDHyqndYDgsKWVUcZDsJbomShum3eHXLJEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlIRFLvqo3AMvINZeO1GqmIUS4zJkrPwULW28qQgsAR5lyzIwx
	SFfz3KRirPqEY7BBGkvpfCy+ebHSf0qu8XKcyOWwrrMylrJBcg4WfPlRpaYyRxgyY5E=
X-Gm-Gg: AR+sD11hWx8XTjPa7HXBEQGxztdTUKuH71Ivva5w4oMlRMSGUxb+t+SEOhq1dCbBFMA
	rPp54Z3p9DEr3OpgcaU7d3I/yw5fuWeijjMM0J/inFfQFvyEj1cKyvuEKqZblI15EnDq43E14ko
	xvzGy2tnhH8OuDEncy9wtC96vDf+CLWAwuOuhwbCf1uKRBnFsf2swfi2AGpx30K9kaQb/Dfxwll
	yzDicmt/4HdoLhHjzl1+/OfukNDK3XN+p4ar4NX7rHCqODJJw5ZwP0LjgLIAefnxoOMSRS86Cmn
	nL/E6+tSFJlkHCWePIUeuESvAsNAxqMlHLjca0sMHsWoDk4GKdulaXtgnjsvKtnTfxY8fSkBBNJ
	Si0R9pLguz06pnewQLNu34Yyar291j+OqAMpaB45zBAUADMbiYdw88djs+OLXA4KXcxWlsVBCAe
	Iz6do9wPdVE1MZoxS81e4ze8QlTkPholFcxgMasVpqlgSRvrAyBrePpfz4qdSeIK4++Pf8kro3X
	/ey7l174/CPGlnib8bjkYTR+yrH0PP9FzXuxPA=
X-Received: by 2002:a05:6820:81d0:b0:6aa:fac5:a3af with SMTP id 006d021491bc7-6ae96d12cfbmr16069294eaf.16.1786214445838;
        Sat, 08 Aug 2026 11:40:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:99c2:f16e:201c:3bb5? ([2600:8803:e7e4:500:99c2:f16e:201c:3bb5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02bc2e840sm5607169eaf.6.2026.08.08.11.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2026 11:40:45 -0700 (PDT)
Message-ID: <b760633d-a9af-4dc1-be6d-496b7a19e847@baylibre.com>
Date: Sat, 8 Aug 2026 13:40:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] iio: adc: ti-ads1262: support common mode supplies
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-9-f89925d72792@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260807-ads126x-v3-9-f89925d72792@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/26 10:58 PM, Kurt Borja wrote:
> Enable common mode regulators. The usual configuration is to have our
> own 'vbias' regulator connected internally as common mode voltage on the
> AINCOM pin.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1262.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
> index 533574169b04..238d803abc50 100644
> --- a/drivers/iio/adc/ti-ads1262.c
> +++ b/drivers/iio/adc/ti-ads1262.c
> @@ -962,6 +962,27 @@ static irqreturn_t ads1262_irq_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static int ads1262_common_mode_setup(struct ads1262 *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	char name[sizeof("aincom")];
> +	int ret;
> +
> +	for (unsigned int i = 0; i <= ADS1262_INPMUX_AINCOM; i++) {
> +		if (i < ADS1262_INPMUX_AINCOM)
> +			scnprintf(name, sizeof(name), "ain%u", i);
> +		else
> +			scnprintf(name, sizeof(name), "aincom");
> +
> +		ret = devm_regulator_get_enable_optional(dev, name);

We need to get the voltage which is then used to provide an offset
(IIO_CHAN_INFO_OFFSET) for the channel.

> +		if (ret < 0 && ret != -ENODEV)
> +			return dev_err_probe(dev, ret,
> +					     "failed to get common mode supply: %s\n", name);
> +	}
> +
> +	return 0;
> +}
> +
>  static int ads1262_regulator_enable(struct regulator_dev *rdev)
>  {
>  	struct ads1262 *st = rdev_get_drvdata(rdev);
> @@ -1797,6 +1818,10 @@ static int ads1262_spi_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	ret = ads1262_common_mode_setup(st);
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  					      iio_pollfunc_store_time,
>  					      ads1262_trigger_handler,
> 

