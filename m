Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7E5374E55
	for <linux-iio@vger.kernel.org>; Sat,  4 Apr 2026 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775318980; cv=none; b=amcWA60kYBH6CDMNg/wjyEsCsjJzmTWZiioB9NPI3EjrPK2lEFOdDqSHLMozIJ2ZqFxfC11EKNwU/i1mHRHLhuw21gPLM9BzzrNdZdH0M86JT/SyQ6vjmBLl5WzCY8giQ2q9m+LTefJXZ8eqdarZJthe5n5LfI2HIpoRMopbvKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775318980; c=relaxed/simple;
	bh=JOU1LTwsUnta1MJfUdd+hUfQ3DMQRLKNnniWlrdEPIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHz+gNxICWC2+/wfdW5cXDNLjv7+WD62hUhdBDAtAPOhQqUJAIlvURI9hvwTN7SwA269+lcSvrUMKzCTmRaLilna30EUXorg/2FE6nTkrFSTmTVkyXZ52LY3ia+qNd5QIU5t5iruBp6yBvhOCTVUEkNnlICuql0xDBJvGBWb/bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=C93pRVqk; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="C93pRVqk"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dbccb6ae20so244372a34.3
        for <linux-iio@vger.kernel.org>; Sat, 04 Apr 2026 09:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775318977; x=1775923777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oK8EAn+xj8lsBH2CI0DEhLX/gCoXHH2W/o+E54D//HE=;
        b=C93pRVqk9jnHKi+lefRxnSP65DpNYbOZKj/rpvWReD30q2tmuSF6ac5iQW8RBXkYbm
         KtDOYZi2Ka2S875UwnWTZEAeoSF9kKUuwenFOUzAyBeRet1avQYwUl0tN4GzIPJINFlL
         UR1Gx2g22RgcuBzwp0MUWmmmLp1XlQfezsPzz3Yt/TP90Ev3/tlmEkUnvE/GBFKgG5p6
         46m3iXtCkd+pDwVTVgLHE59eoq+pQjeQPNfsQgWxB3KN7hgY8ytM2cNK8YSQAuuzJ/Ui
         buoa3enFurvN3HATv8lwuKidTsz8vFHFR8IRH6iW2M9W/MPAD2M9G22Vr1abSarZSkmP
         7OLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775318977; x=1775923777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oK8EAn+xj8lsBH2CI0DEhLX/gCoXHH2W/o+E54D//HE=;
        b=SzCqxWlHC+xdUMyhZTvbKMDSicbNbLpQ0k+Vb4lkdz/tep76AZaFWkdW/GI+kxksps
         Q+p0teUdNfWGR3R3Ar1Brm09ixXAfEJ4ZxoZoRbfOd5yuflb1kjZrPJQ3dpddxXu9Vac
         UMkR335bvprSw9lZn38qWP26tH8MgkSnrVoDLXfemAEiTCkMWtb+GyahcmF+Eb3KPFko
         Um5t52oxtxo1qBoePKhyIyW2AtkXDMYTdx8WYB6QVKAOTUyNjMY9uqPMSmJ+0AGBZWqi
         L6DxI8kWz1IeLcyYbfn//4eB1ky+SKSqOkwxdOUCX+8uMwRslKa84Oo9ESDqnvv2dHMN
         uOAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUytWDy7R84JqtZHz2QUfOQwpv8bnrlPpSyPfUjYR+LcqRJpVPf0jgaXv8xhQ38DPXbWmyNZfFOZGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf26Lm6PnC4bM0rFlQ8fAPf8PdqjBaZo0z8wv15/tI5hM0yoEA
	IpZl4Nzv6xNL1dZIiVs/jqVsNvrQQJ6vfqzSEWcjPfeYbqd/uiA4IpE3aYXtvdJHoSY=
X-Gm-Gg: AeBDietzlwMs2E40Ns1fnKm3vuJCs8UlOq/MPfYOY9GUEdhNnLtGbv4l0zfiNm0SKj3
	O9Pr2spT2J4qNOxL4bhTnhU0p/JIFxe8ZEb+X6uo7d0US60RpK9CJByfbyCQNAao3JOgyYk3rS2
	UZjk2uqPjcVoG+2oCev0RZXRaa9KDkj6Q2dxSUIiI6oqgqyFbIqN3gGgC2uNsD3XQt6EJcGg1bL
	BoDWo72sJbNzBuHACFlWYH0A9Cf2QGR8eQYNsin4RywsgcZ3crnCuI0cQpnRICa72O4cHnR8tnO
	iDW6tF4MMgVxrwybdBoi+429SkMmkid+ZqQu9RJ+6EAqBeOtS1CSJIXU/jpk8qAvztVaFuQLbRw
	1E0chz6kpUCotAjQUS/p/u5ou24Qg0W0qcKaw7MlkG98FrAtwJzuWLw4fF73zSwE5SosAMoH2Yt
	kQoQcd7Y6dytdMsuo1lYtIZXQIxKoJhJWEELs+YcQasq86m3sStXRO8PbvQL0X1RYs+nI3IUd2O
	Q==
X-Received: by 2002:a05:6830:6184:b0:7d7:ecea:fd95 with SMTP id 46e09a7af769-7dbb7327a94mr4945760a34.7.1775318977642;
        Sat, 04 Apr 2026 09:09:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e14e:bcc6:3f95:26eb? ([2600:8803:e7e4:500:e14e:bcc6:3f95:26eb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbb6c02ffesm4093282a34.10.2026.04.04.09.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 09:09:37 -0700 (PDT)
Message-ID: <4e1d2bb8-50c3-4749-bf50-9cdf085e0583@baylibre.com>
Date: Sat, 4 Apr 2026 11:09:36 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] iio: adc: ad799x: convert to fully managed
 resources and drop remove()
To: Archit Anant <architanant5@gmail.com>, jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260403080614.14213-1-architanant5@gmail.com>
 <20260403080614.14213-6-architanant5@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260403080614.14213-6-architanant5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/26 3:06 AM, Archit Anant wrote:
> Convert the driver's remaining manual resource management to use the
> devm_ infrastructure, allowing for the complete removal of the
> ad799x_remove() function and the simplification of the probe error paths.
> 
> Specifically:
> - Initialize the mutex using devm_mutex_init() and move it to the top
>   of probe() (before IRQ registration) to prevent a race condition where
>   an interrupt could attempt to take an uninitialized lock.
> - Use devm_add_action_or_reset() to ensure that the VCC and VREF
>   regulators are disabled safely and in the correct order during driver
>   teardown or probe failure.
> - Refactor the optional VREF error handling path for better readability.
> - Convert iio_triggered_buffer_setup() and iio_device_register() to
>   their devm_ variants.
> 
> Because all resources are now managed by the devm core, the unwinding
> order is guaranteed to follow the reverse order of allocation. All manual
> error handling goto labels in ad799x_probe() have been removed.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Archit Anant <architanant5@gmail.com>
> ---
>  drivers/iio/adc/ad799x.c | 69 ++++++++++++++++------------------------
>  1 file changed, 28 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index e37bb64edd2b..9170109d64ef 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -775,6 +775,11 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
>  	},
>  };
>  
> +static void ad799x_reg_disable(void *reg)
> +{
> +	regulator_disable(reg);
> +}
> +
>  static int ad799x_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> @@ -793,6 +798,9 @@ static int ad799x_probe(struct i2c_client *client)
>  	st = iio_priv(indio_dev);
>  	/* this is only used for device removal purposes */
>  	i2c_set_clientdata(client, indio_dev);

Insert blank line here.

> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
>  
