Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A3372696
	for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639997; cv=none; b=LtgT40L0T684/whffB3HgV0hWSuIusuG9B9G5PqFkmYxsgAB5fLitg/PIQzThQ3kk39qwLfW2SzOS7e7vQkoax7Clt7BMTiOLJ7DBgItZ2Nyw/RtzqDWKUn0Ttg6houLKOTD684PAq5jJ+0nfyB8xtlGQwJLXTRqEhs9YCJjGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639997; c=relaxed/simple;
	bh=7hRVs3BYbYMUWytBwA6CmbA7QnVq714J9oYUdi/KtgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UjezFhgZr8X3CXQEI/b5lU1mkTV4YwNyo2RhqImlafBNI+MeDf9pFw8/ZdNw6UYa0w+3rdEjSW7yYZd0UO2QbblWma8TWQB7skbrINZAh4GKumn/+Qkih1I291OTZjLpb0q5R2Pg1QTzkWH8cwjhsVh/kEJguDwZoJfsNBdLnj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=PBwgq+q+; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="PBwgq+q+"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4f58dce2ad9so520923b6e.1
        for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 06:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791639994; x=1792244794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JAKMj+KBQiZwjesAoVsZB7P+pgbWuimzGqrZ8oXnW4s=;
        b=PBwgq+q+VXb1e2UWSFncuuXX8zVzNA/LEnkjvGi2ozydiaSkf0Ea3M6MVyQ1gPHB2O
         eo0yJv5+UfD/xpLQ+rklosCEUCCTnEjBgLYQu4fRh4jHYDtwtXmjlsWyFIyq1XPyzdwB
         178+X2cIrbX1t42m6gqR9ttKhToEfj9BPqcCJredL2eZlSQFKK8x2bv1kmS6NxGmUaPU
         TnADhNLy4zBl9aDZKIGpoN5FYVz5Ijol0W0MqQ+T8Tq6LmpJry9KYbt22Xe6BJ9ZNTbb
         AkF31lkBzhrRAIFx7e0q/JFry5XT0Yhx1A9FUANilRyNCkyjNB9+O+mrwS1YHxRa6fTc
         KWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791639994; x=1792244794;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JAKMj+KBQiZwjesAoVsZB7P+pgbWuimzGqrZ8oXnW4s=;
        b=HMfO6mn0L11Kkumu+5laFiDVDjYqm5sr4AinbTaovLcVdLcfIwmi1PVpuXRKjTeXZK
         0ck7VdiRTjRCWjG9BcJmgPg/y68tS82GpmsGy9/UUSMXXEjPGDrZUzzlJFz+8x4wBPFY
         qnihLi4/zedKg1x5o0HBJxY2uBbcLgA5iOSTS5WMnbaZ9I7sn1lwafxE+1BS/82+pWTm
         onkeUi830+7IizX7aqKjOgfuwlLXX/4UPlu1OS4El0LVJDgkbOubsh6OQ8jubBe/NrEQ
         OrtEU12kHk0pYibR2eoU/e208VDE+CE7G6N/ZbXKLJqpp+ct0HMBO6aQNQ4hldJeZ51O
         Lr/g==
X-Gm-Message-State: AFq9FYKN0rxbt4lPGk4hvbpsNqiv+krnNRSJ8K82lcCx+AYbHeQSMMLI
	NX9XvsZuUTuskL3EcOZnxaR9MNmgH1H9cx4lY+4Oj6CrvQHlRY0SRccvMai/y5iOzpY=
X-Gm-Gg: AYBFou1j2EAr2Ip9Us6GLinfEqfr+M4Spf0tnjfJFLw8Ndn1/oHgfuiOPDVPfRe9O6C
	mpBnDAS9xsQiI8G8BN0qKMDV8nvxuhzXu4SVd+OMOmABDzRVv1E7DqkVX5L08DA3VcKAbWKiUL9
	2OWiKPSWsk3K0eYlWt1hANSX4FE5da8ADPdwrDCi3O9cASlj8OZDpZR+IiMhHT3csRVEumpckHv
	84frsXqQtrHVr7bNYqXjSnRz2U/LOrpkHFQPrdnVp2ODNC4DLz24XTwG5ly/9WhGWTWI1WYuyaI
	/M9bKV6XtTqMx9DRQ0Y9NmmWqJcwc2DW+1GECktMLdKe+MFid3zp0rZ6dyiXElE3i1YPP+D3FTa
	8HXLtjYtE0GrY9azYszLkYnmzG5io4V4ouR5/arAiRDrJqOiIsayq1qbqintS+x8tLJEmzcGUeS
	MAkfEkyHnGxaHdWJPEIm+AB3SqAQN4s0/PIPn1WdVUjBB2GqaA2kFaCPdUt62gEtg0tGXkfPn9o
	Qu4EvpgU/6nqewGQ/D4xXQVDi7g5NxeDKNw5EKeLxTs6uo7
X-Received: by 2002:a05:6808:4fde:b0:4f3:e98f:fa26 with SMTP id 5614622812f47-50c56deebe6mr4606369b6e.58.1791639994282;
        Sat, 10 Oct 2026 06:46:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3b8a:e2db:776f:80fd? ([2600:8803:e7e4:500:3b8a:e2db:776f:80fd])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1c120ae6sm4982338b6e.17.2026.10.10.06.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2026 06:46:32 -0700 (PDT)
Message-ID: <cde9d00a-bfe4-4093-b03d-f76a122e4ded@baylibre.com>
Date: Sat, 10 Oct 2026 08:46:30 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads112c14: add gpio support
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Chris Hall <c-hall@ti.com>,
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Linus Walleij <linusw@kernel.org>
References: <20261009-iio-adc-ti-ads112c14-gpio-v2-0-3231a795fa63@baylibre.com>
 <20261009-iio-adc-ti-ads112c14-gpio-v2-2-3231a795fa63@baylibre.com>
 <CAMRc=Mfn7+uQYvLjGLxU9wMOnRwx5pyPgaLp6oNx+ZcFXyXL=A@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAMRc=Mfn7+uQYvLjGLxU9wMOnRwx5pyPgaLp6oNx+ZcFXyXL=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/26 4:00 AM, Bartosz Golaszewski wrote:
> On Sat, 10 Oct 2026 01:25:52 +0200, "David Lechner (TI)"
> <dlechner@baylibre.com> said:
>> Add support for using the AIN4/GPIO0 to AIN7/GPIO3 pins as GPIOs when
>> the gpio-controller property is present.
>>

...

>> @@ -2574,6 +2726,12 @@ static int ads112c14_probe(struct i2c_client *client)
>>  	if (ret)
>>  		return ret;
>>
>> +	if (device_property_read_bool(dev, "gpio-controller")) {
> 
> I think the right one to use is device_property_present().

I thought this was the one case where device_property_read_bool() is
actually correct because gpio-controller property is a
/schemas/types.yaml#/definitions/flag.

Otherwise, we should just remove device_property_read_bool() from the tree
because there would never be a reason to use it.

My understanding is we should use device_property_present() for non-boolean
properties when we want to know if it is present or not before reading the
value of it.

> 
>> +		ret = ads112c14_gpio_init(indio_dev);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>  	return devm_iio_device_register(dev, indio_dev);
>>  }
>>
>>
>> --
>> 2.53.0
>>
>>
> 
> Bart

