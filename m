Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BC0315775
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054882; cv=none; b=dL5JNzDW7QVWKdg9SchDWSEitJsfltlbHPb0baKr7mApSMQ4lf2Ea0D2aItwhENRnihBTXvyibpuLYMwQWZ9O8VPyTcnCIZye5BnzpMQ+IFBiMwCqb8CgrtHOHL2uXttICB8sKFcaHRdXG0b50i0LKm8oYqdUr2MwJYkeyENfZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054882; c=relaxed/simple;
	bh=qjrk/gpVIC1qKApvcZQJkb+2O/ErBj+6Q50wrK706PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUcxwYTZ4wsXNIrs8W4F5afWJTwgwBjaSLr8XLcx9eRM6OTu4lagMbdo6uHUfwpkjod59+CXkz5hpSyVVqAJiuGUHaDVKus2a9FOGELvSbANrCQAliri4WlHruV8/zlnnjNpNAQZq/ZXbnMG7yyDl4FEffbkdukI369RGPMYzEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zVFNrM6/; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zVFNrM6/"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4638e238094so101224b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 13:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772054878; x=1772659678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ppp+Wy9oVLyAcv92KWS/Xhqb10P6rmyhJHh80S79F44=;
        b=zVFNrM6/dL4RVlHdZshlXZedPF+Sqou81/Sq7A0ZCjiDZ7tfVk1EgwHCfOsrTxzeSH
         FpwwIwQ8zWvqPpAxNspF25xgKP5TDUyD1pJM3fD3gY3IDOuKjwXBkjH5l0fZ1zUUeZHm
         c5HRx6mgh2hZwornmLh3CjK4NibTfZ/VDFth8CSCG5PwGyxt3ZJQ4V1qh341VFL3LizR
         qG2H4yi21KcKfjCY7MF6S2OGLUWXEikGFrcW4Qwc6nlTwbmkaCs39YSyIq4wK6ymu7i2
         mXx2lM9bsF7BTIHyp7IaApmqtoAD0VhGrLQQBPc5IXWyCUeZ+j+pmr0rfmUFn37jkc8C
         GE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772054878; x=1772659678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppp+Wy9oVLyAcv92KWS/Xhqb10P6rmyhJHh80S79F44=;
        b=vhrnEVujJ2/sHdDOM3z6zqxESQqGW5pI14ibiNpkB+pg2xR+zeDLDhUYE2fub0kEm/
         iUlKNNaWgtP3sNwkO7NSvw+z/0Gp8vdKU0USnQvyZwEHk298YzjgVyD0Eia8ab/fsGEB
         zitMD++CpYUN6QCaufLzYK0yFBR9Uhm4cmFpG9gCAWE+8XoYSZqWV99N1lpBmLdQyQFQ
         rXZPqdd54eLVKQ6CFQWRctcSgEE6aoFx/+B7WVrsBpgRema+0tTNwikyCiluNape/P1F
         kMyLpXndXnC8zlpDReuH6Of4wnuIUNFa2oS6XiO3vhiXfyk8iIf38PfMvd+sKVTsi5kw
         +Y7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8cRSh1CeYGMhvf8NOoYgMGQ3lv1H+Rd8JZNCjBgk4pigsl3O99dVXOkJLl27nRnA4MOvqfUuD3uA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Xw9uXu9s/2Y9wWisDFWySwS0EusjMDqWqskQaat2vVLKTzDF
	/jPXIumXyuwTY7kwdkIQlLGOG7+7PXLf/nZD57fDc+9YsR9yLHL9XnGR+7/E/3qo8dJY4BbUK+w
	a+zO/
X-Gm-Gg: ATEYQzzAiE4Ua/48FgBJa+jxWZzacGFFsF7wd3BRaExNcJyLJYs/UsKK6pgrEgtqqQ9
	DOUTL1NnsBC/9txp0+V77IzKOX7PtJlOWrt5X7A2s/XH7JfwPQ8nwFmItVLXs7UHjqci5rX4RlS
	81mhPWWAvHeKQILbM3wn9Jx8EYXlHJRs7dCMMRp/fyU3DTDYEmmc1opmy0nMZlM0Vg1IXgOKn0x
	XbU4eORTlKGmQO0OMMvwskjZr0nXDI9eNSzVA3BzQX3wA38iye7U5WmZ8rGs1YVqmFRZ0vRkuiW
	FQmpIBRGRW+TN5tAKyBVJVxNmi5eXseC6p/aUdeX4ABD8rd/Vt4gCUdm3BnRJ+fLcD5ck3sB4Um
	rpwoSCzZ5E0p/7tFHqpNdJghg1281MRCrJdi+pkOfJINdb93whKgUvkuqk6rxiJB1GbzBjfrweG
	8jET8fVSoaghLNP20LfERr4TqxBmaX9PyzVEoey4xaaZp7Rqb4294SQkGQByA/BUleKGpIEIA=
X-Received: by 2002:a05:6808:6508:b0:45e:a52c:e4cd with SMTP id 5614622812f47-4649eef644amr1321892b6e.27.1772054878045;
        Wed, 25 Feb 2026 13:27:58 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:146:def2:caeb:cb1f? ([2600:8803:e7e4:500:146:def2:caeb:cb1f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4644a17aa52sm9783451b6e.10.2026.02.25.13.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 13:27:57 -0800 (PST)
Message-ID: <eeb28077-0886-42b4-b468-21f5c6a6444a@baylibre.com>
Date: Wed, 25 Feb 2026 15:27:55 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] iio: ABI: Add custom data type
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260225100421.2366864-1-flavra@baylibre.com>
 <20260225101806.2368391-1-flavra@baylibre.com>
 <aZ7gdO58NV6gjgWC@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aZ7gdO58NV6gjgWC@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/26 5:43 AM, Andy Shevchenko wrote:
> On Wed, Feb 25, 2026 at 11:18:06AM +0100, Francesco Lavra wrote:
>> This type is used when the data received from or sent to a device cannot be
>> identified with a standard type and must be processed by custom userspace.
>> Any driver using the custom type must provide a driver-specific document
>> that explains what the data represents and how it is to be interpreted by
>> userspace.
> 
> This rises the same Q as for other firmware-hidden algos, et cetera: How
> can we prevent the kernel from being just a simple proxy between HW and
> the userspace? What would be the point of having the "driver" in the kernel
> space?
> 

I tend to agree that this opens the door for misuse or an excuse to not
make the effort to develop something more generally useful on future drivers.

For this patch series, could we still use IIO_ROT and introduce a
new IIO_MOD_PARTIAL_QUATERNION that is defined according to the
description in the documentation patch in this series? This may be
the only driver that ever uses it, but it is still clearly defined.

Or perhaps we could even say that if a IIO_MOD_QUATERNION has
.repeat = 3 instead of .repeat = 4, then it should be interpreted
this way?



