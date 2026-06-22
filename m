Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A03AFB11
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136505; cv=none; b=ihy/htz2xyMGh0PDZW9zxxUrvZH/iM9/Lu58qvoXRz9z+n6CXeKnmDpmZtKPenQ4PlOu+nspnqXHUe59g0VvC/DNTMc3myunSmYPwh6S4gKrQUDpLT7Pe4sMnJ9KmapOZTXdx+DGgs+A4FpPMYq+FtqZKVhHltbCgh4ToYZMM1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136505; c=relaxed/simple;
	bh=F7XgWmGDL57uyYW5zg/J1Ylcjm2e0uV/J9jDi+p/POY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N99Ptu9RgEjO3uSdjU07mfF0Ldd43sD9mFmo/iFctDUpug3DWb+CFoZADUpnmUC/KS8xO9wR7zpv473haVOCnfQgbYq2mq4G2qQHiFJoIyP4360KUyURI7Us3UCpkGlsvQAYuA62GswpoipN+mkeJOOZKGPLWBs15WC3g3Lgrxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hvpyWzC0; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hvpyWzC0"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-44755d837e8so1047395fac.3
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782136503; x=1782741303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6eEeMJPQKAtcX5MedkvnuksL17XF4JZiVXUHwmPZMc=;
        b=hvpyWzC0DRo/o95xtWQBJMmsAt2M3ls8Rf198nqZqThac9euigfbSD16wE44vNgyCM
         ZypKUZtUDYCmejZ8WKLu3rcUr35ifN1jfy9oZeovEH3g35KSn0646RxvDT5kq/ufVzsG
         yrQ6UgLJKbUToM36aWvHeAJiJIzlVn7w5USvsFdWD5w3SwrZri+0U95hJK8FPRrNxzPo
         Pii5X3b0RsIKktqvInaUx09LvXsuUswIx6uwN4n3Fp8bha9YhbjFrfJ9XKgMfWfdZ5nZ
         1OGnc1njslYOchJ3OIWlSGCXseT7cYDh+fV17/D2mvExo+znRfPoJum6IixCnYEuPHkj
         d7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782136503; x=1782741303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6eEeMJPQKAtcX5MedkvnuksL17XF4JZiVXUHwmPZMc=;
        b=WlMVIrUhsB9uNm+zlGa2m9Ug5jO8nRuWEWHBxmdYOsheaFTG+UMx0fvyBTLjWt8sSG
         K9rj1PIaSRTD84WBypsTFMnC1KBM3E+QcJm+JklGhJKPwny81oPSzho1CBMLgiGwH5TL
         rBIKhJ8/kj2LWIw5It5KVlTMgKFAg7RB3j/JXjdglrSr3URNY5oU2U+md644HHNWnD73
         L/ePTgyHShyE6NclbLy2sym9pn4BXYJrpXkZ6Zkcg+zJNxD/eMSD0kWWaBb9+ePhphMS
         4V6Z5OxTckBAW9N4IbzZOBX1RtzyCZQ8MMDwyoYnI3aYBw9vFnEltnqqPBfv3OUm2xKw
         xEUg==
X-Forwarded-Encrypted: i=1; AFNElJ8BJnD0vf/tm8shXdZfw8CSZJ4VgIGP1DzKM0NRw+3Il2UOdB62JaZ8S2Ty0Aulxb1tRbHE25NRRFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpUOKhy4r7iHWFp4JHEKZY2O072LpY+eIHQ8i2niJ5g05e0CP3
	IK5oxFAEJsOuASodJgR7pA0hzjPKHA/hg79wHW9NM6RumWNi3LExoQVank76aROsNnY=
X-Gm-Gg: AfdE7ck404y1tzKV6bGtKhfDZrAbfrjWRMREvg4DsHsb5OyLFZs0pHd8UYDnHw+jfY8
	542RJx/EUPGGbhvn/s1pb/s4Sv2dn37WoCijpxD3RtUA6/Tg30PJs1fkr+T7QDqliK+M8bFkhEH
	0qvV2UscTawOQfkvg9IpinKpFyWZd2f8StMWBW3BlgxC7w5NhS5XJVeFmDd63Nq1RLoAB2rrqI5
	AwuVpN7fFq5lGsmwjjg6GIFw5ZW/TBHPEkXQehmjD+OeoWh20KyS3dEizcJt03i1SV1wbeX7yfM
	6Cfmp2PZh4kk9pkJayrcHZpGSzg/HXrKxh4Ac5SWOfpxkGqz7p+x+g1J5Bv2YlOQiQc7kREoMRp
	4YJHioR1DFqnrGMUSWlSRGurk8YSQIO9+ldKbys0DBndCmzRgEOCUTW9fGNQfBmKied0W7d145h
	gezgHcweqLhmP5tzkXwFB8Gnm+GAgrms7yH9ScckPdcB7LNsEBF12I57am09b1j6w=
X-Received: by 2002:a05:6808:1183:b0:48b:4218:9326 with SMTP id 5614622812f47-48b42189df5mr7464007b6e.34.1782136502396;
        Mon, 22 Jun 2026 06:55:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b69c:5a77:b8fb:a5cf? ([2600:8803:e7e4:500:b69c:5a77:b8fb:a5cf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e944296d7asm6353944a34.19.2026.06.22.06.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 06:55:01 -0700 (PDT)
Message-ID: <c7478348-452b-4659-a2f2-a8a2700c29dd@baylibre.com>
Date: Mon, 22 Jun 2026 08:55:01 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] iio: dac: ad5686: implement new sync() op for
 the spi bus
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-9-f829fb7e9262@analog.com>
 <50a7e765-ba20-45c0-8a13-5e672413b600@baylibre.com>
 <3i3fdq6qjd2h4o4wwicl4zlpzyggzb7gljm2acwz33k75ds57k@7mdevoavx3ao>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <3i3fdq6qjd2h4o4wwicl4zlpzyggzb7gljm2acwz33k75ds57k@7mdevoavx3ao>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/26 3:50 AM, Rodrigo Alencar wrote:
> On 20/06/26 11:33, David Lechner wrote:
>> On 6/16/26 3:21 AM, Rodrigo Alencar via B4 Relay wrote:
>>> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>>>
>>> Use of local SPI bus data to manage a collection of SPI transfers and
>>> flush them to the SPI platform driver with the sync() operation. This
>>> allows for faster handling of multiple channel DAC writes, avoiding kernel
>>> overhead per spi_sync() call, which will be helpful when enabling
>>> triggered buffer support.
> 
> ...
> 
>>> +/**
>>> + * struct ad5686_spi_data - SPI bus specific data
>>> + * @msg: SPI message used for transfers
>>> + * @size: number of transfers currently in the message
>>> + * @capacity: maximum number of transfers that can be added to the message
>>> + * @xfers: array of SPI transfers, allocated with the provided capacity
>>> + */
>>> +struct ad5686_spi_data {
>>> +	struct spi_message msg;
>>> +	unsigned int size;
>>> +	unsigned int capacity;
>>> +	struct spi_transfer xfers[] __counted_by(capacity);
>>> +};
>>> +
>>>  static int ad5686_spi_write(struct ad5686_state *st,
>>>  			    u8 cmd, u8 addr, u16 val)
>>>  {
>>> -	struct spi_device *spi = to_spi_device(st->dev);
>>> -	u8 tx_len, *buf;
>>> +	struct ad5686_spi_data *bus_data = st->bus_data;
>>> +	struct spi_transfer *xfer;
>>>  
>>> +	if (bus_data->size >= bus_data->capacity)
>>> +		return -E2BIG;
>>> +
>>> +	if (bus_data->size)
>>> +		bus_data->xfers[bus_data->size - 1].cs_change = 1;
>>> +	else
>>> +		spi_message_init(&bus_data->msg);
>>
>> Seems odd that spi_message_init() is called conditionally. What
>> prevents spi_message_add_tail() from growing the message unbounded
>> on repeated calls?
> 
> The "size >= capacity" check right above this.

OK, but it could still grow to capacity, adding one xfer each
time this function is called with bus_data->size > 0, right?

> 
>>
>>> +
>>> +	xfer = &bus_data->xfers[bus_data->size];
>>>  	switch (st->chip_info->regmap_type) {
>>>  	case AD5310_REGMAP:
>>> -		st->data[0].d16 = cpu_to_be16(AD5310_CMD(cmd) |
>>> -					      val);
>>> -		buf = &st->data[0].d8[0];
>>> -		tx_len = 2;
>>> +		st->data[bus_data->size].d16 =
>>> +			cpu_to_be16(AD5310_CMD(cmd) | val);
>>> +		*xfer = (struct spi_transfer) {
>>> +			.tx_buf = &st->data[bus_data->size].d16,
>>> +			.len = sizeof(st->data[bus_data->size].d16),
>>> +		};
>>>  		break;
>>>  	case AD5683_REGMAP:
>>> -		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
>>> -					      AD5683_DATA(val));
>>> -		buf = &st->data[0].d8[1];
>>> -		tx_len = 3;
>>> +		st->data[bus_data->size].d32 =
>>> +			cpu_to_be32(AD5686_CMD(cmd) | AD5683_DATA(val));
>>> +		*xfer = (struct spi_transfer) {
>>> +			.tx_buf = &st->data[bus_data->size].d8[1],
>>> +			.len = sizeof(st->data[bus_data->size].d32) - 1,
>>> +		};
>>>  		break;
>>>  	case AD5686_REGMAP:
>>> -		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
>>> -					      AD5686_ADDR(addr) |
>>> -					      val);
>>> -		buf = &st->data[0].d8[1];
>>> -		tx_len = 3;
>>> +		st->data[bus_data->size].d32 =
>>> +			cpu_to_be32(AD5686_CMD(cmd) | AD5686_ADDR(addr) | val);
>>> +		*xfer = (struct spi_transfer) {
>>> +			.tx_buf = &st->data[bus_data->size].d8[1],
>>> +			.len = sizeof(st->data[bus_data->size].d32) - 1,
>>> +		};
>>>  		break;
>>>  	default:
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> -	return spi_write(spi, buf, tx_len);
>>
>> If this function no longer writes, should we change the name of
>> the function to something like ad5686_spi_write_prepare_msg()?
>>
>>> +	spi_message_add_tail(xfer, &bus_data->msg);
>>> +	bus_data->size++;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int ad5686_spi_sync(struct ad5686_state *st)
>>> +{
>>> +	struct spi_device *spi = to_spi_device(st->dev);
>>> +	struct ad5686_spi_data *bus_data = st->bus_data;
>>> +
>>> +	bus_data->size = 0; /* always reset, even on sync failure */
>>> +	return spi_sync(spi, &bus_data->msg);
>>>  }
>>>  
>>>  static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
>>>  {
>>> -	struct spi_transfer t[] = {
>>> -		{
>>> -			.tx_buf = &st->data[0].d8[1],
>>> -			.len = 3,
>>> -			.cs_change = 1,
>>> -		}, {
>>> -			.tx_buf = &st->data[1].d8[1],
>>> -			.rx_buf = &st->data[2].d8[1],
>>> -			.len = 3,
>>> -		},
>>> -	};
>>>  	struct spi_device *spi = to_spi_device(st->dev);
>>> +	struct ad5686_spi_data *bus_data = st->bus_data;
>>> +	struct spi_transfer *xfer = &bus_data->xfers[0];
>>>  	u8 cmd = 0;
>>>  	int ret;
>>>  
>>> @@ -85,8 +117,21 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
>>>  				      AD5686_ADDR(addr));
>>>  	st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
>>>  
>>> -	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
>>> -	if (ret < 0)
>>> +	xfer[0] = (struct spi_transfer) {
>>> +		.tx_buf = &st->data[0].d8[1],
>>> +		.len = sizeof(st->data[0].d32) - 1,
>>
>> Would make more sense to say `sizeof(st->data[0].d8) - 1` since
>> the buffer is  &st->data[0].d8[1].
> 
> the buffer is d8[1], d8[2] and d8[3], skipping d8[0], for a len = 3.

Yes, I see that. This is why I suggested that it should be based on
sizeof(...d8) - 1 rather than sizeof(...d32) - 1. It makes more sense
to use the same field for both the size and the buffer pointer.

> 
>>> +		.cs_change = 1,
>>> +	};
>>> +	xfer[1] = (struct spi_transfer) {
>>> +		.tx_buf = &st->data[1].d8[1],
>>> +		.rx_buf = &st->data[2].d8[1],
>>> +		.len = sizeof(st->data[1].d32) - 1,
>>
>> And here.
>>
>>> +	};
>>> +
>>> +	spi_message_init_with_transfers(&bus_data->msg, xfer, 2);
>>> +
>>> +	ret = spi_sync(spi, &bus_data->msg);
>>> +	if (ret)
>>>  		return ret;
>>>  
>>>  	return be32_to_cpu(st->data[2].d32);
>>> @@ -95,12 +140,26 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
>>>  static const struct ad5686_bus_ops ad5686_spi_ops = {
>>>  	.write = ad5686_spi_write,
>>>  	.read = ad5686_spi_read,
>>> +	.sync = ad5686_spi_sync,
>>>  };
>>>  
> 

