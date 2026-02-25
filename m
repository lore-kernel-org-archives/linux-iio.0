Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6575E38B7D2
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020395; cv=none; b=qEdwjhdGy/Zxh2pb9XNiesoh6sL8UuYNCTMNx3tVP+mpInOZHjoOcl7Bf/lwTiH+1ohPIIOQM4Cj0fi6CQYxBD49mDtwXOrElK/n1ntj8+NHta10fESOVQSU4/KqTP+2vvv9Czy6qG0IBhRaRKtUCIXe62KxEWSoYWT1fC8I7a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020395; c=relaxed/simple;
	bh=sh6FsX3MrqmoO//15u8LRbMtPSpWvxXuMZmNPgwnx9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnLBRal0g/DphmmRZRW8uqkw4XBPWUTe4zDo5s8J/U0TDCUZi95pkhC2UPr111OWIL8aEGHG+Nc0nqiWtygbPLiffZmkMDcGLV5DWT0A+dJDAY+IozgN7lwJNQ/0irFFAwwE0XUfPNJCTKNRkHKRBAj1sDFaRJWMxU91afCbK7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnWdiHH1; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnWdiHH1"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-94acf9ce1b7so4178556241.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 03:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772020393; x=1772625193; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Dk1wH48ZkmimurzoISkjxeIEMiJosj6vNt+TZ2K13A=;
        b=bnWdiHH1nu/poHLob8txkwU57GrX5OJ6AKCf54qTvUc2uADXFsye7zk/oFzqxcuQV5
         tZv2dwRy9VVrufYR18Y8Zalnkb3IbPRZFwNVz5R4nzzEo2zJxEi1cJFCCpEbysdl2njx
         VSB5Dz+4v99FIvo+FQPnsFQhUjiujEqT5Q4/UJ+iS09M7y3yowUC+9q2hp2JfYt0mhaQ
         ebEUB6mfoc2RTB3LJZMAs7spmKcNSL2z8aA2LqGD0ydTKLKOsHjrS7iSoTW9gtLpd+Ai
         rrUBC9b57i/0iKi1rFFG+39kL42YsEZnGfKv0WctxVXF+bR7BMuV3MTqYds8PdNZKX+y
         i3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772020393; x=1772625193;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Dk1wH48ZkmimurzoISkjxeIEMiJosj6vNt+TZ2K13A=;
        b=uRzCWKusNUKzn0gXJM1x81j1tZt+gYIxoB8R3lcAc+71c6FAbK3qVY7Ejh976zg7LO
         2IkGv+I6Em9/z6Hfv0uuiS4RFHOey9lHYiR2OywqOOmNTT5+Og3TDk127IUypG64/Oh3
         oZI3XCk4f/D+dDPq9qp7I7fjddQY1+mUn364zrbr0eHyilRBSkyabqEvNLWe/mYvP1Tv
         G4M+RN+7CqF5pkMbBjZLIJ9pxMv8M2U8wtz2reJA2zTxqnvMotHtp0lnXgK/Y8pICW7b
         O61bbhi+3zwheA1qrKdMGmwBNBTH+LHFyzeQSolAfBrAhN69ouyp8YIZP4+QvejE3RlI
         iGKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUprzvDdNBcMTh8ZmvATR5kw0MW+7wcFTHnuA+AGxp4KXfWR34eUA3u3aoLT30zo1cRzupI7D3xgn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQcgcpr1LmjeDuuMegnG2QXTn/FkEdeIIn38XqjjunlOLkqVdw
	UMH3pDRM0NIkPSVZ7TWOKyVhB0hVc/0MTUWxVh+I100zy8TS7SDUm9JnawolbQ==
X-Gm-Gg: ATEYQzw3mbH8IxPh2NWcK3uPQBH6DZ+P9yY9uXIIRfV+E0fdOMLygNJRLxQ2NfoJVOW
	SOToOdP6B128ShD1WOfb1XaFcr88EaKZ1Dhqt8791IbsmwPVetHyCbop2Raovs6NOWcqweee9gA
	AGeVTYqGaelIrfzi908cTXgJ8TjZFtJlszr7tmPTQVklgEQVgK5m7IKrltt+TN17wIaD5xVsLgl
	thWMOjpmzhQrTVk8jgvU7SSswtEU562tO4lRqRVG9s6o9Y6sN9sSmOAQxyVAf+Kmwz2Wz3A1EZO
	ZSO6qAnSED3jZGoxZD2d/11MlFqJc0mmXVoSrSfi8qFf3FLLTFXSLMBkQux5+iv8zFhiZqBksU/
	Ynt6V7JXnpvCdS2B6VcGZkeIAWrDhszj2mztUUFZj5GMKKtY9TVYRaaCnJH1bbcEGhoO+m1ZxeD
	9Q1z4UZshhWLbfOchV/E8b4lBTS5ZxUdg=
X-Received: by 2002:a67:ffcd:0:b0:5ff:a34:6ce8 with SMTP id ada2fe7eead31-5ff0a347f36mr521168137.20.1772020393171;
        Wed, 25 Feb 2026 03:53:13 -0800 (PST)
Received: from localhost ([2804:30c:966:7b00:fd18:61b8:43a7:4049])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da8d07574sm11955373241.14.2026.02.25.03.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 03:53:12 -0800 (PST)
Date: Wed, 25 Feb 2026 08:53:44 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iio: adc: ad4030: fix calibscale read/write unit
 mismatch
Message-ID: <aZ7iyJ2CdNB3L6ON@debian-BULLSEYE-live-builder-AMD64>
References: <20260225113102.84568-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225113102.84568-2-giorgitchankvetadze1997@gmail.com>

On 02/25, Giorgi Tchankvetadze wrote:
> The read path returns calibscale in IIO_VAL_INT_PLUS_NANO but the write
> path treats it as MICRO. Since no write_raw_get_fmt is provided, the
> IIO core defaults to MICRO when parsing userspace input.
> 
> This means reading calibscale and writing it back results in a ~1000x
> gain error.
> 
> Change the read path and available range to use MICRO to match the
> write path.

The updates to ad4030 driver will add write_raw_get_fmt() [1].
[1]: https://lore.kernel.org/linux-iio/516cccc47e917bd26be29b016907f50a244a68b9.1771865684.git.marcelo.schmitt@analog.com/

At first glance, I think this could instead add a case to write_raw_get_fmt(),
keeping calibscale nano precision (unless nano precision doesn't make sense
for ad4030 calibscale (don't recall from top of my mind)).

> 
> Fixes: 0cb8b324852f ("iio: adc: ad4030: add driver for ad4030-24")
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> ---
>  drivers/iio/adc/ad4030.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index def3e1d01ceb..3d823648371d 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -423,10 +423,10 @@ static int ad4030_get_chan_calibscale(struct iio_dev *indio_dev,
>  
>  	/* From datasheet: multiplied output = input × gain word/0x8000 */
>  	*val = gain / AD4030_GAIN_MIDLE_POINT;
> -	*val2 = mul_u64_u32_div(gain % AD4030_GAIN_MIDLE_POINT, NANO,
> +	*val2 = mul_u64_u32_div(gain % AD4030_GAIN_MIDLE_POINT, MICRO,
>  				AD4030_GAIN_MIDLE_POINT);
>  
> -	return IIO_VAL_INT_PLUS_NANO;
> +	return IIO_VAL_INT_PLUS_MICRO;
>  }
>  
>  /* Returns the offset where 1 LSB = (VREF/2^precision_bits - 1)/gain */
> @@ -720,8 +720,8 @@ static irqreturn_t ad4030_trigger_handler(int irq, void *p)
>  
>  static const int ad4030_gain_avail[3][2] = {
>  	{ 0, 0 },
> -	{ 0, 30518 },
> -	{ 1, 999969482 },
> +	{ 0, 30 },
> +	{ 1, 999969 },
>  };
>  
>  static int ad4030_read_avail(struct iio_dev *indio_dev,
> @@ -739,7 +739,7 @@ static int ad4030_read_avail(struct iio_dev *indio_dev,
>  
>  	case IIO_CHAN_INFO_CALIBSCALE:
>  		*vals = (void *)ad4030_gain_avail;
> -		*type = IIO_VAL_INT_PLUS_NANO;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
>  		return IIO_AVAIL_RANGE;
>  
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -- 
> 2.52.0
> 
> 
