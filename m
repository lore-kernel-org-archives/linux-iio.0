Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5393134E744
	for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2026 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791587068; cv=none; b=IA0Z86o5ssNK4WN7dipDkxocP/GayYo/yjcBgc1jo2NSYSI6ZeW70idC0Eq4oEBN9iGXn18RQUTszhgSVWXKfH/0LF0TrGF9v54LGG0+IspBkIc6oBwfw8DQx8bNgHI/XvldajPWAyP7ucRYJLKhsgOH/GByGgEEDguDPP4J9hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791587068; c=relaxed/simple;
	bh=A1bnVPrO1LobryWZt/XSqr54LwFNVj9TQ6RlEKGXcHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A45AJmA9D7q0I6XD+KOXdwVA6NMSjP6+AUpbvqrS9zK8zvEA/kYw/oBuVQArG7jGVpobcT3BMnqWxPEmwOZQKZTfkbah9KGvpMLdBNdXIPOCFkdB4cUyudqxIhMtVlFu+Ur6YI6OGCsy49gNcgxwmipVAe9M5QA9sxZFCFAzMKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=FiIFvUXu; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="FiIFvUXu"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-490d838b425so187283fac.3
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 16:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791587065; x=1792191865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/XrFhk/iW0YvLVnmZlrjKuBDyhEpQEu44sD2YgKjqq4=;
        b=FiIFvUXuUYuNT9wRiU6KHmKsErg4aP+r8uqGMD+hf/B7LKij/Geritg3YjohkvDyN/
         E9V64qmhGyr0+GCjfdEtRvQEI/M3t/Xg2mRldp2JJ7KKWPN/Z0seYWcfD3r57cDKMDMV
         YNOVxWOrg+TFmXXEpbL4dI6a21skHNl+nGfAZT0+4eEIS+gjsyobHoM3T9jEDDRlpBYi
         dgQXe0VKCuDTvF1HxMZ9P8hK5b2FPnvn9gNIKQb8zTL608NqsVXtF3FMLe1y7F5VvzB8
         yvScKfGfGk6T6rWB1yBR4wJmLwxvVksmVEFFIOzp2lmLw0FA4irB1cT0e5UTJsgm5pfD
         wj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791587065; x=1792191865;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/XrFhk/iW0YvLVnmZlrjKuBDyhEpQEu44sD2YgKjqq4=;
        b=Ee1pBQ4TNCfTpfyZEYiIQWYsCmerZ4/z3X9rbk25C9PPI9nq+vwiBSvZYm9mJEBM99
         dYE+UP9BNWb0ramujF4+/1r8eT7MK9yi/xAubT+duhIbUfZ1SIQlTUd89VnbNNmSLeou
         9G19M+B8yZQF9X3l8z198q+vbWHcFH8CZqYrqwnr109ES0kupcsrSEf1G4G2w/sOhSSm
         36DsSS1YmnQNeblGdqwUGzjOS4SBB7L2c5//ElziCWy0DPsqgMbuU7rtHvcTymcNr8UG
         ediyV7cDQCZcipWKwBLwARLPh9WyvQHzj1iydlzSwRupavgNgwKOXg0iELJDo46nLgSJ
         MDXQ==
X-Forwarded-Encrypted: i=1; AKwUvBw0GePKoEkhrpw0n9KTmDt7D3nSqTjGmStEp08z5TU0BxDvAxvo2wdHRF0ZfdcHv1Ce87DV3MmKkyA=@vger.kernel.org
X-Gm-Message-State: AFuF++ngvvDhhrAQHA0erCZmBZiq/3g6CuA6pnChOdNW/klrn/Cjp/Fl
	mcF9RxZH8DKTwd2jusuRZg1Upz47qgvYWvmnW2evdU6bT8yzwwQS1fUpGuD+tCZfPd0=
X-Gm-Gg: AYBFou3Z+sTy55ZnjovwRnRtjnFQGCNo+65rejRccPkzSPsmtaED7pa7VkKuGUP2r7u
	GF4ztTpopX3s1yy0Z6fp+AYIU/rN5sWQLvZSiw9p4mmgT3GDvevBHJ9+BfnrCnNgxoLnIpk9XjJ
	Hh0A49DCFq0AQSY8HSBRSf+KoYwJ7yCAWRVsRTpV8WAZmI5AsBk0YruIp3XWFuyPhUV4uJP8qjO
	Ra6Da0k9jML6A76yIRK/iTPC62EQ6KD+J6RJi0/CSLNM5EZPwoUQxwGLyXXam8aEpqJHfH/sFum
	KR5bt0HwBqv6OcTQsq1qgMO8R284BhDfJn2c57K6L0sTTMwNx1ZJoCv95QQ8dmvQvmlF8aRmmxo
	TDBOcbf2CUp0YJWN8v1r2fAc3RmfimWWBxNTK2gdAKC05sKd4fcjpn2/GdLxrR6nhlQFrBIRrc6
	c9NMDfWz9JaxnD2xykSek79f8r2M8q9T5gZIZ9sc56K0LdJ+M/90JLkSqYmG7SMffJq3YrzYwtx
	cAWCV7TvYVGCCTh4/wFyXDViSgJLwvgG2L7oZDVCucso1rC
X-Received: by 2002:a05:6808:1183:b0:4f7:d324:bc36 with SMTP id 5614622812f47-50c574a3113mr2833212b6e.43.1791587064925;
        Fri, 09 Oct 2026 16:04:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:29bd:56f6:5ae7:35d2? ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1815e5aasm3402365b6e.8.2026.10.09.16.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 16:04:23 -0700 (PDT)
Message-ID: <f4ddbc02-1fdd-4205-b511-fb39329fa5f3@baylibre.com>
Date: Fri, 9 Oct 2026 18:04:21 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ti-ads112c14: add gpio support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Chris Hall <c-hall@ti.com>,
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>
References: <20260925-iio-adc-ti-ads112c14-gpio-v1-1-2a2b218ebf3a@baylibre.com>
 <arom9T0azKX9jV5m@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <arom9T0azKX9jV5m@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/28/26 3:36 AM, Andy Shevchenko wrote:
> On Fri, Sep 25, 2026 at 04:50:47PM -0500, David Lechner (TI) wrote:
>> Add support for using the AIN4/GPIO0 to AIN7/GPIO3 pins as GPIOs when
>> the gpio-controller property is present.
>>
>> Pins that are already used for something else according to the
>> devicetree are excluded from the valid GPIO mask. This includes analog
>> inputs and excitation current outputs used by channels, REFP/REFN when
>> an external reference is used, the /FAULT and /DRDY interrupts and the
>> external clock input.
>>
>> The per-pin register field macros are replaced with parameterized ones
>> so that they can be used with the GPIO offset.
> 
> ...
> 
>> +	DECLARE_BITMAP(gpio_reserved_mask, ADS112C14_NUM_GPIO);
> 
> Why not use valid_mask in GPIO chip directly?

Because gc.valid_mask doesn't exist until gpiochip_add_data(). So we would
need to track other things longer or read the firmware properties twice. I
went with Jonathan's suggestion to do it where the pins are parsed instead.


>> +static int ads112c14_gpio_init(struct iio_dev *indio_dev)
>> +{
>> +	struct ads112c14_data *data = iio_priv(indio_dev);
>> +	struct device *dev = indio_dev->dev.parent;
>> +
>> +	for (unsigned int i = 0; i < ADS112C14_NUM_GPIO; i++) {
>> +		data->gpio_names[i] = devm_kasprintf(dev, GFP_KERNEL, "%s:GPIO%u",
>> +						     dev_name(&indio_dev->dev), i);
>> +		if (!data->gpio_names[i])
>> +			return -ENOMEM;
> 
> Wondering if you can utilise devm_kasprintf_strarray().
> 
That uses "%s-%zu" internally, so would add a "-" where I don't want it.
