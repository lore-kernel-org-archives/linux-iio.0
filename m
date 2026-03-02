Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ED1421EF6
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469472; cv=none; b=eQtpoC8k17Z4RdAgL7r8c4DMVo9KcLLZ7IfDMXhTV1z7Ejq+xrRvFp1bNIH/C0N0q6f8fW+IfzdTs5c9gRyIUe5j9+/PnNSu4Fn58xFV/Hz38N4dCoaUVLUpqygpfaP9+vZ7Ou87bCXruQrzfRo543lQXPPAfcBTdQBbbtZK+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469472; c=relaxed/simple;
	bh=ykMkC9YqfTuzviXpOcOVFaMTvIEjFj3vSKG49Rvv/3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSgyyGiUj3CtkrP9g+6gYVBzg0I4JUUB6BJRYrxm1Z2cRi8uyMkdy0hRhvgw5cXJrVxnt7XNO1lswlbYOTUUEixp2I7ianeyfAzjLVsWydcSocXB7uMZFMOyaCsAe6hGZQ3Q94zBExiyrWiX0AxYr6Wz/ggFYQAw81XKkSlXJOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JWOF6qti; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JWOF6qti"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45effa36208so3263529b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 08:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772469468; x=1773074268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pk8NJyq+o1G5+FfQKTAplUbfGHDKqbnJEUobZnnfqv8=;
        b=JWOF6qtifweAUEzObgZEXwt8eBbxXee8KBct0a+z5yZSHE9o1iEgBCHhW7ISrhl3S2
         9mJlQZRddkFVe5TryZRss9HM09cvRzsiB2qhcGEKgWTP7MnU3gCIRaLzfwep78ZM1ym2
         4xTToepG9Tg5brBS+lWFtKuS/dr5WkSbNdl9WBL3165lZ4joa5n6cE4sEYfMTECP5H9t
         +ZQSsCUlaKWZjJBtnl1A1UrPjP7PWF9WSUz2cSgMIOYcP3nZmXl9C/bzvU4LTMPgPa3t
         8H0GKIODIqBmvjDDOmIn9zFRgyt58HsGSDnETlWOP/xipFVdb2+MYGRJfLX8N83C62yl
         j1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772469468; x=1773074268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pk8NJyq+o1G5+FfQKTAplUbfGHDKqbnJEUobZnnfqv8=;
        b=Z7FDsnmORz8V8HFqdh58oJhsPFUUly1fdjixg04jffO3H8z51zze0KNbTYMMXN4i4b
         G89cFlSUAKEZZLPH8Bv12oWiybTIrFPm4dlLNGHRlkARpOeETTsXkpbNJYlpFI9muyhl
         Zwn0fR5YaYQ6SztCIVy7+2JHj6XrhJzsLhpBIuIQOZK41CWHndXHGjy0BdR+lgPIJKfP
         C+/Qe7N8ns2LsWH6dktRpcjf42zA7CuAVVxs1SQvDidoMpnOGJ/oodJGH30F8hiFVcAm
         pd5wm/n62vxvnc2+MSDyjwMhSjGCYKQi0QTADfkRpP7guoDFmES2Ycua1VA7pKLes3FV
         a9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXiqZF9We5NRQc3wIGB3ZBgD7E9uQ/so38D+/4nyQteX0xrIoI3cs3wAnF9/VyJV9iGW57/wM43HBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe3r8E1ezB6Vm5A9Y6DSHw608BlD7v8iG/s3TRFDPSLMW9DNCC
	2/HvhGceRD67Xre85EGDKkMC0SNKPBI53PuwGC1MGzwlpWET94L3jOjpJlEcK96wGqE=
X-Gm-Gg: ATEYQzzstTkrKERmCEaTtxOrD66JskQfLkYkb9Oy9dkYcNx4VIeIIZDx4D8wFSPYKJo
	fHiOPGs2VYkowptJFU96v6o350bA71jaRfLooXsTgoEjYIIAL530wNb51Nfs/Cq3zGp+Q0GQefs
	rKsaqj/emDUo91gJtbj7sTGPcTlhYmt4QyRIf5vtczs1Seu0KzQ2Aa0UhKWOF7//XgKbvYxn2oq
	Cs66pcLFok1XIniXnrgkFDEgmzCq1O9JRjJSri6ehdKTVuad/ENam2fenFoZB2iy3R8SgVERr6M
	sD2geDCqASCaEY6wgL9Cv7j28VqXXxRWinbgWEUSSh2O8xQaC4dANeEwUsKgXmAF2WT5km5YSCL
	KfZ1295AM2qc7V8sG+vCTm66Wy4T0vgSjoSICDDZFlmBxYbFm3f+/q/2U+yZNxQEZpsT64Eu7jF
	9yIZM2TWr3ffCelBiHN8ToMye7Hkr5XoRZJ1v0F/22lIAI7HVlTmHh1Tvh+nBhCCnALrTK8UfMs
	g==
X-Received: by 2002:a05:6808:30a5:b0:455:f0e4:4f89 with SMTP id 5614622812f47-464bea4145cmr5801292b6e.3.1772469467762;
        Mon, 02 Mar 2026 08:37:47 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7? ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59b66fsm7836943b6e.10.2026.03.02.08.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 08:37:47 -0800 (PST)
Message-ID: <6b6684d8-180c-49c2-9bce-e9b9f246fae4@baylibre.com>
Date: Mon, 2 Mar 2026 10:37:46 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] iio: adc: ad799x: cache regulator voltages during
 probe
To: Archit Anant <architanant5@gmail.com>, jic23@kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260302130632.29144-1-architanant5@gmail.com>
 <20260302130632.29144-3-architanant5@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260302130632.29144-3-architanant5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/26 7:06 AM, Archit Anant wrote:
> Reading the regulator voltage via regulator_get_voltage() can be a slow
> operation. Since the reference voltages for this ADC are not expected to
> change at runtime, it is inefficient to query the regulator API every
> time userspace reads the IIO_CHAN_INFO_SCALE attribute.
> 
> Cache the VCC and VREF voltages in the state structure during probe().
> This improves the performance of ad799x_read_raw() and removes the
> dependency on the regulator pointers during fast-path reads.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Archit Anant <architanant5@gmail.com>
> ---
>  drivers/iio/adc/ad799x.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 7775be874081..35e0589428d0 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -135,6 +135,10 @@ struct ad799x_state {
>  	u16				config;
>  
>  	unsigned int			transfer_size;
> +
> +	int				vcc_uv;
> +	int				vref_uv;
> +
>  	IIO_DECLARE_DMA_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
>  };
>  
> @@ -303,9 +307,9 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		if (st->vref)
> -			ret = regulator_get_voltage(st->vref);
> +			ret = st->vref_uv;
>  		else
> -			ret = regulator_get_voltage(st->reg);
> +			ret = st->vcc_uv;
>  
>  		if (ret < 0)
>  			return ret;

This can be simplified even more. See reply to v2.

We could even move the if statement to probe and only
add one state variable.

