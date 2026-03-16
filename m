Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFC729BDA2
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671877; cv=none; b=DRFNOxbBDFs5UhBBFjtJYYh63oOLW4ncCZNi6px5tLWwwHo0iE54Hiyz4kI1u507RNhijlvQOXxzd8peT/xTmo5xK3s1BYzAxG/10ZTYgMqeJ/intfvkNN3EjAOSofEybutZ+Fofu4xla31/y2Bf2vjqJz3Y213Ev2MmF1eE0E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671877; c=relaxed/simple;
	bh=QEkZDrKDOWeWiXzxMJUSgOrMeqvxwgbypS9dfwiP3KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8K2ggFnK/izVTHwNJV3O6monIHbhqMpVWuiaVd+ueKDEyL8uOP4013HWYhtiify3A9/go3SRLMaciTF6hr9WBOZWRjgCxfBcmpDvaafRAszw7YkBY0BhCAdpi/+USohw/kQRCr7IcPk7b/oCGcBjP0GDT10T3/rES2cxvkpJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ErKaFLE3; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ErKaFLE3"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d75ed779bfso4696586a34.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773671874; x=1774276674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iwDEjP2RxHALBhf33ZG8/cVMn/100Eoi1woGk3UdmcU=;
        b=ErKaFLE3cpw6l5AJhfx9+wc+b+0VXESMG9rRmNfhlXxJcYD3RbLntqe330Sj8rORW7
         cKdqLp+PPsH26xNIjlyh6F/tbP2evBNWwoC1+fquFA7HrDXDM3kkt7S/C/4jIU+XZYBY
         RRddlzzGuDlImjNORy9XG34gZRho3DmPX3/A5m1aMDPoIJ9bFMq7QXQ6+axdBCGe9KzC
         wtsk1HcmGa4w+RJRsn0xXnZhGG0HfwlKzZLJztX89DgUsOgqDfWZAIen4KFAwH5xchqd
         VdtLRNkT/x4Wa9+QbTMrxGCZiKQhMxMUQYLnx67cmLmT73vlgVFtm872pf7UCRBNplWL
         fHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773671874; x=1774276674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwDEjP2RxHALBhf33ZG8/cVMn/100Eoi1woGk3UdmcU=;
        b=BTXZSSyI0k3K/mlWU7OyWARSqzAEPGzEzFAkzz3q+wf9Zt8jeTc5kZ6gP0iibjxoSU
         IyETX3Fhp74YdPk9L+bZ8Fecsj3DK5Hz1UZgwzk6BYDzpGGblRkhTq9WcNh5/uNR1MtZ
         B+DBJnpymmPQEl4RcV8kU6gV4FZBNuS+XcWKhUp96/plQNyPSNcKtmvEJt+Gan4SR7VK
         KLRn4p6knEm0lMeV+5Q+dKE4eLGjuHzdHIbOeR8QnMM94xmrWe7gW4sRGnNJe9OQiMhh
         7a4wc45inLJ/QV6yL+bbIaPca7j/86LrUadt/Yk6jlki/o+SBbW4vxHb1V8kkwD5h8Af
         +Log==
X-Forwarded-Encrypted: i=1; AJvYcCWS1Tx6WtmyMIkhbnsdtyFBIOpAG/rqMWoOn9uMJ6LikVS1KEyco9ZdjwXbfthbvPF0hqdffgy7P2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+TmIKAm9q0OxOXUBgBbwoWz887x7qqOIr5E5v0eDdsYDvqOaO
	jcbcBaL9wDLiaez9xvr40dVaa2g2Zh3nuBTyIbEP0a+rRL2Op4lXncjTtm9jjtdj3Mg=
X-Gm-Gg: ATEYQzwJnyGfYswzpvYrDke6TtrJn5ajukygwoVvw4zrT2vSfyp8GtXjN0noOqFGU89
	Vse8ZN5VqFjHmByW96+uERnjmPb4H2KrfSxnaWftn8vjcHWRelrTVGYF7xdqYZrCaAvgmOmBwWa
	Sl9h6ieIP4ZMefgmmyjJCIzQ9eUo3BDsDwoRgL4J+ZJrCys20XGaFV1O3Ip6L0i3NAJ4W1Idp6O
	NesH0+QfNV7nN0+3a/DzleHj5FKZ1vbXx3O+lMtemiqTBKPEqE9IY5UejJyXNz6fAnt8rsmDc13
	C3dkDbx7IXOywIxchTcV4/1UbV7v4PrC2V1eVvZitAS2g2fjB/bAzzOH4b/NVmTMMyfTkvJcKJa
	1s523k6u2TZDOBQrOVycoq9gY3yXlyxTdpq2x6njAtbI5ESDjSUv/MYBCXtCy00+1uZwNeDNnrJ
	P/e60FQpgZTSzVzaSrXQiUG5JsYYCXnUDEgu4DvJfwPglHFk577TFVA8zCZjt5cNDNDGZsOKGzU
	RJFUAWaZXvv
X-Received: by 2002:a05:6830:7002:b0:7d7:5c30:a80b with SMTP id 46e09a7af769-7d782435d06mr8614692a34.4.1773671874450;
        Mon, 16 Mar 2026 07:37:54 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e504:a034:1152:a664? ([2600:8803:e7e4:500:e504:a034:1152:a664])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ae90586sm13230271a34.22.2026.03.16.07.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 07:37:53 -0700 (PDT)
Message-ID: <b8ed1390-7bd5-4f6f-8975-5aceb72cde0b@baylibre.com>
Date: Mon, 16 Mar 2026 09:37:53 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: vcnl4035: fix scan buffer on big-endian
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Parthiban Nallathambi <pn@denx.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260314-iio-light-vcnl4035c-clean-up-scan-buf-v1-1-400d273eb026@baylibre.com>
 <abfYN9gszSSb83J9@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <abfYN9gszSSb83J9@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 5:15 AM, Andy Shevchenko wrote:
> On Sat, Mar 14, 2026 at 05:18:10PM -0500, David Lechner wrote:
>> Rework vcnl4035_trigger_consumer_handler() so that we are not passing
>> what should be a u16 value as an int * to regmap_read(). This won't
>> work on bit endian systems.
>>
>> Instead, add a new unsigned int variable to pass to regmap_read(). Then
>> copy that value into the buffer struct.
>>
>> The buffer array is replaced with a struct since there is only one value
>> being read. This allows us to use the correct u16 data type and has a
>> side-effect of simplifying the alignment specification.
>>
>> Also fix the endianness of the scan format from little-endian to CPU
>> endianness. Since we are using regmap to read the value, it will be
>> CPU-endian.
> 
> ...
> 
>> -	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
>> -					iio_get_time_ns(indio_dev));
>> +
>> +	buffer.als_data = val;
>> +	iio_push_to_buffers_with_timestamp(indio_dev, &buffer,
>> +					   iio_get_time_ns(indio_dev));
> 
> Do you have plans to drop this old API as well?
> 

Eventually, yes. My plan is to wait for fixes to go through first.
