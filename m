Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A5D40DB5D
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158164; cv=none; b=UIMpBgL8Od/kNWHgPlIlmJWp3fZktnJffm9vbkX4jyJC+BRlzUFSjMoGLIv++nbBosLnb0eNAgH3AtKs69TVSuR3HgvTNmESsjSKzWCcw0mT1vJKpY2OaLhLwgbafmNlORB6yhkLJdAnGbKGgKLk1GAjmkPIzXnIRZYWV36WH+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158164; c=relaxed/simple;
	bh=vZMr9iQgTrhaW6/vjBCqkFmJh4apidKCCeVtFnDugBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uk49DkJLRybCAw3l/Ia8unFIxyu+757woxDrp7B8iw1gRrPcAiYEW3pRYyqer+V4Zo1sngPDbYzcWUkt2quojcybV2pZ134iSAhcb6BnEJm9a3e1GfBNuEWw0gMvCxYY8hT/OKqDV7t2Nl9hGqrVdt/4RJf5OE2DwF93NX1hh4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=F6Uc/SaZ; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="F6Uc/SaZ"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4560d6f82edso1325525fac.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785158161; x=1785762961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HNKl3M/VR9azOE61YALP3ovVcBBley/hBZMseKoNWEk=;
        b=F6Uc/SaZl0xa0Op9WTO6bpIjncl3rnWFp8nnYzyqT6M2bCjcKenEzM2cz4hYi5I7AC
         Kf7DrLdDA8lp4Si6T4MwOiDubA7oFsOPO243UuhcvfE/5w+jrJiqovzBWblDL/Epa2Cq
         oX9JwAxV5onys7UhWFtkeDollbrwDSjV4sOeVS2qfCAg1vmEytDzfxmW8jtR7q+kKJRa
         HmzpihZOJe9zNWl2bEi59Eugu1kctJF0jFBQ+Z5gQCvI1PBYfyIhLYjEEiuDbNItC2je
         j7dlcObDHn0zJ/rd8S29XpX1hVp8RptLYV3mS96KfqQBuhmVpD53afKDFkwNnw6I53ZU
         S62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785158161; x=1785762961;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HNKl3M/VR9azOE61YALP3ovVcBBley/hBZMseKoNWEk=;
        b=OQVAt+uZNr2Rfq/+/7KrOPsGKOxO5NzkaFlIW8X+wuvIS+0QVP7KC2v+fURjTNpLOy
         fU/bo3vBiWT+eIvTBf74W3OfW86wmQ8WbRiv+baYtZJuFGe4oZZEuR1YT1OyXDIqkHDo
         L5LhithWcOgS9NEHJLyjkTYzYzOAKCUCuNLyYnZ8+f8oJ5Iz9RhVHhWiHcq71rSxHrgt
         8r2+bhpk+qxPLmoKUg7TvywcimuLfR2Q6PYIGXu0ZR+8ouJDmspZd3X1U7R9xvg9vtlj
         nO7kh2iPX21t1SfCq2hmHKXZ92MMFcQTx0lyBaB3/gbZxQYTlZOp/HUJXR6d+1FYzMJC
         9GRw==
X-Forwarded-Encrypted: i=1; AHgh+RoWIASk9vZTA/vXVYnmHnTRL+EU7m5a3yA2bDrbgULJKDkXQ20sG2VLbaWGms/apKMYai9P6IHEHjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/TqGTzeshTuXAqpqUal5w2k69uNmlj6CpZz5KpeeCESR1ngQP
	4pH5p3bR3Vkn5LQmyYeQhqmZ3lGFUrIJ0XrcwRp8CfcGIZJ8ctJLDF6gVKn+6GtVPKk=
X-Gm-Gg: AR+sD10nVUXYCy23r6yfniTf2SAUweoUU31m2VixgxmMc/DeXTd4FwT1SMOqVc7s86S
	a08Q+twPbA/0UGgzgivY3zJXxZy34/0G/Nc9rjjm3Mdp2NtIBOyAZNTN2XID+6VEcsnE/83V+HV
	iYkKAD8DKLodS8sRvaAhNZSNYzBAtYt6cb91ep0ni/2rjeHG0lG2jy1nGboTgFuLfPRPlLmNmCb
	7QUroDlAFzfyAFdk1c5gGPLbtmwD08ZMLP7TFYU8g84HFiqHKB3Es/ua76YN7AI/8IRuZ1WAMa6
	T2X9ezL3E2krj2yq0/sevq7ERB6d5drCS4lsJvEDXWN2totUIWGx+C1Zb0JmXkwtnUtWkuW2bvA
	XYqs12Hc+JAXGjOAZrh2YrdeUFeb5+w9MIWk4BiooksN3Vj1FwhT7O0R6S3zPp4mV6uGyFnrlma
	AScC8D8P3yt3X0LVbTSm4VWhgZSodne6upzPuxTAnwiP+NLcXqLp2jbCFM+B2c0LM=
X-Received: by 2002:a05:6871:e3:b0:456:6097:168e with SMTP id 586e51a60fabf-457f2523691mr7195035fac.19.1785158161327;
        Mon, 27 Jul 2026 06:16:01 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:41b4:f2ef:8a0a:2104? ([2600:8803:e7e4:500:41b4:f2ef:8a0a:2104])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4581ac3f9e5sm4462997fac.6.2026.07.27.06.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 06:16:00 -0700 (PDT)
Message-ID: <90018da7-8d84-4bfd-b2e1-f832ca03f764@baylibre.com>
Date: Mon, 27 Jul 2026 08:15:59 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: veml3328: remove redundant cast in read_avail
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 joshua.crofts1@gmail.com, jic23@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
References: <20260727112726.211344-1-giorgitchankvetadze1997@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260727112726.211344-1-giorgitchankvetadze1997@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/26 6:27 AM, Giorgi Tchankvetadze wrote:
> From: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
> 
> veml3328_scale_vals is declared as a const int array, so
> veml3328_scale_vals[it_inx] already decays to const int *,
> matching the type of *vals. The explicit (const int *) cast
> is therefore redundant and can be dropped.
> 
> No functional change.
> 
> Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
> ---
>  drivers/iio/light/veml3328.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/veml3328.c b/drivers/iio/light/veml3328.c
> index 7ff1753925c4..a3c49beee93a 100644
> --- a/drivers/iio/light/veml3328.c
> +++ b/drivers/iio/light/veml3328.c
> @@ -228,7 +228,7 @@ static int veml3328_read_avail(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  
>  		*length = 8;
> -		*vals = (const int *)veml3328_scale_vals[it_inx];
> +		*vals = veml3328_scale_vals[it_inx];
>  		*type = IIO_VAL_INT_PLUS_MICRO;
>  		return IIO_AVAIL_LIST;
>  	}

We'll see if there are other opinions (before sending a v2)...

Usually, we would declare the array like:

static const int veml3328_scale_vals[4][4][2] ...

in which case this cast would be needed.


Currently, it is `static const int veml3328_scale_vals[4][8]` and
accessed like:

	/* Stride by 2 through the flattened array to match (val, val2) */
	*val = veml3328_scale_vals[it_inx][gain_inx * 2];
	*val2 = veml3328_scale_vals[it_inx][gain_inx * 2 + 1];

Normally, we would do that like:

	*val = veml3328_scale_vals[it_inx][gain_inx][0];
	*val2 = veml3328_scale_vals[it_inx][gain_inx][1];


