Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932BD2FD665
	for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772297404; cv=none; b=UppIuHhZB1aGhGcyIwzrsCLT+kAsjV5pxJ11ybTYNwOt+TQJdsVyYiZ6BX0AXuzJeS8WBIzPfwW+gTDcaHdpd0OZtnXCfZgzWorVKc0J50U39aA5Q9EXPs6yJ3DGu6SAbXZvt/yxSO7ewgHjGoV9p40gvZ+j9QfePa7NkA2lYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772297404; c=relaxed/simple;
	bh=l8EH17lWrfvjOatQpXujT58XPwHIhCRA7xEfz2ukHkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O1R8tjeA1FTGFmgZyG4W/gCQ0Rm1e19B1MSICZQclic1e4tNuDzrDLLiOJ6EzlZ15bq7LVTdDNXl3uCpNGsipTE26+ZwNma/dHj6iciF8R5VXPsA2ZF9UPNWbxSSb1K9DrzUR0bvAD3LvgrXnUs69ShWl2qQFUZDvbjl3iEHDG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p5C/D4l6; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p5C/D4l6"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4638e6bb8a5so1279306b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 08:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772297401; x=1772902201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uuk0Fk7x52M96YnEPuk+cTgxxh8er/i4OgmVOBy10Ow=;
        b=p5C/D4l6uzn3OEeqriyPknESdUlhhWnC+sUfI5UFaSpqpObGdzvcqXJIJQxVzB/Y7w
         82p4PAicJ79lbvaxmrE6l+bSz8IIiXU3ozc+GmULrM8ZQLuXjtPXlwRSWPC4cVjnK71b
         unDNCkVBk3bYwQ5Vl3pvMxFvrKKDZBKnKPINdOwuJH/lg2VymtwcXrsKlcpowRujvuAO
         /z5dWacWukoHL0kZ3jr6VMcU0gXcadKWFP5ab/7Vmyqc2S0TL7Wi8ku3Z8r0Ds7EYFUB
         MHB0tlOUPI6N9YXICsqhxmHNrSf6KqUJ8qHx8Dz+C/FumtxvWJH89NJiCgjWsJ8gTFzd
         OKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772297401; x=1772902201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uuk0Fk7x52M96YnEPuk+cTgxxh8er/i4OgmVOBy10Ow=;
        b=PmWoOmMhS3TN36QltQVhWUKGi4O/GgJsj3vBsjLi86p60PO/cZRsUnpN6z3BRA9lXk
         qzMnAFYZXZL04V6hWAwi5A8bjwXzxqW42d6yIGcAfL8HgDfMnAsOI0lcAyyWiUVHxKet
         aM6O07jUjJ2XIpVl8bpFEzCvrdtFvn55J1qo2/UKe4eUaJ1ePS1woihRuqXeCrkC+BNT
         38LN0fcYvaN6jozgs4Ni58/ahMEJgVBEZQWmeToZRUpNpVl6haER9/hJW5Dfx5NsTBuy
         KfmwRcMaJe629JWG6dt/Z9sjRGJB6mgaUzwbF4bog9BQNWqq1+tyGRGy2PR7wcf/nw+l
         lFDA==
X-Forwarded-Encrypted: i=1; AJvYcCVFPNpW/W+pL7ZHzpsrKOwxyZd9SSXQYRxoW0Jh9EsDdT4BJiJeVGGGRoG9dxRBKq5Pip2UplYtmYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzybVCsXguFOChvR8MoyhP+SvKsTuACie+uG1UVzwA+vCm7weYH
	/7pl7duLDOCFuNwBg4QyxHixIaZSCMFK89PZRTXW227/2NPYg9R452crZpSr/ZbP5Og=
X-Gm-Gg: ATEYQzyDPYXHO5ryUKhzXfGJHSR15Kg1uSc3fLlqtdUhArJ5PFLt5BuErniOD+xdAOT
	FQTcUY16MGb2pKZJr5XL4YvqGRsp67TlBfJaST1fJrAphS+JjqaYv88x+SbIoTZy0GBN8iTnKJd
	YO/GDwRmBXQNWjX8laFzG5bAoVjua+YMQiVaPlb78zNJ3D8HSqb8a9rzXoaFt1WJt3+2eXCCiQB
	VuVwjYqgS8VG+KVOYJuOEXTvV1zxY1rvWZ3R78fsaM3K3NNw47bwOKWy9SGZ6VvWXsPidU9fSXC
	88aJ2uo1YgpNxbio5e52cFlr7mZjCOpAIZk6GTLApoNyhQwCHAA+VVotdwpSs6qK83lGyGxd9/+
	qaDPeByVpIZAc9/6F/J0CmqcCtN5bIrvyLpGvS2xuZLzDEqbokHoouUUBBEl5Hu2eScFQ3ECcHW
	zp06Ye5j8NGGtHF8V5hNU4ljWqKLxq/bEMYY0GoeNWX1/m0o1FFzauIsrf+bBkTj7pm+yc0veNi
	g==
X-Received: by 2002:a05:6808:67c8:b0:44f:e954:ba44 with SMTP id 5614622812f47-464bea2890bmr4199475b6e.28.1772297401404;
        Sat, 28 Feb 2026 08:50:01 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1031:c44e:9f1f:17c1? ([2600:8803:e7e4:500:1031:c44e:9f1f:17c1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d26d20asm6907738fac.15.2026.02.28.08.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 08:50:01 -0800 (PST)
Message-ID: <84fae6b8-d188-4e5c-af06-b342f3d27514@baylibre.com>
Date: Sat, 28 Feb 2026 10:50:00 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: adxl380: fix FIFO watermark bit 8 always
 written as 0
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260227124305.55271-1-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260227124305.55271-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/26 6:43 AM, Antoniu Miclaus wrote:
> FIELD_PREP(BIT(0), fifo_samples & BIT(8)) produces either 0 or 256,
> and since FIELD_PREP masks to bit 0, 256 & 1 evaluates to 0. Use !!
> to convert the result to a proper 0-or-1 value.
> 
> Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/accel/adxl380.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> index 8fab2fdbe147..a51d1d61c412 100644
> --- a/drivers/iio/accel/adxl380.c
> +++ b/drivers/iio/accel/adxl380.c
> @@ -877,7 +877,7 @@ static int adxl380_set_fifo_samples(struct adxl380_state *st)

Some relevant context...

	u16 fifo_samples = st->watermark * st->fifo_set_size;

>  	ret = regmap_update_bits(st->regmap, ADXL380_FIFO_CONFIG_0_REG,
>  				 ADXL380_FIFO_SAMPLES_8_MSK,
>  				 FIELD_PREP(ADXL380_FIFO_SAMPLES_8_MSK,
> -					    (fifo_samples & BIT(8))));
> +					    !!(fifo_samples & BIT(8))));

Technically, this works, but in terms of understanding the code I think
fifo_samples >= BIT(8) would make more sense.

fifo_samples is a count, not bit flags.


>  	if (ret)
>  		return ret;
>  

