Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478542248A5
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771088975; cv=none; b=tGF/LlVejY4UuNvUYVNSe8MkY3VewSZewq0quQJFMeKQGu+DDCxJ0J53QdH2P//LfxumJg/yaUgdBBG0q63D18Twlsho/gGl4T7k0O2MuBgoopml4BvrB+X8Hqg5DWDkS+xe3mD71te60x6cxkqZAMneFiPTfCQOKhzz2635C7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771088975; c=relaxed/simple;
	bh=dbIKZyx1wqWvoVfET5QSbDQ7g8Bez4WCJlHr4gZEjwM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kTOKuMQGW5e8DhPVgROVijZfPlxqGLN4ZUfUgtqvF4+NbamZdN/nMeJ5fyOX8yWpic9mudr0sDDcCSUq/GvBGbjVkKmAbEJeD9T/3Peb2Rf5Ec+Dcud9FY8wuuZTykZbU3nxEqDHnCZxI3FZRCqxAR/W53iHnaBtYzZ2iEKwr8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0N5rAGIr; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0N5rAGIr"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-662f9aeb765so614228eaf.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 09:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771088972; x=1771693772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6IUlnbhB2kMGCrw14cml/lzwiGDaGw9e5IGUkFOP+xk=;
        b=0N5rAGIrGOcKVwjXTha4ASNMw6z2IFmQf+O0TH+62PaPP4V4iUB+dMZIPgOrwul2iZ
         QdAcXAU4CZa1EEteyfTVEqqu5djv7PSoxmRbSsuJLyaGLr8wa1ldcS63aBRVI9vw9BPh
         seJh5nK25DyyyowVi7Ve42CNIFahxXEl5xHaIpqJIk5gchnb5pdv/T+s+/oPidb62c8z
         5ZOgIUKA15FpOZjSu77a9VEta+Uwr4hV/ONE7SKzFf/FJAW9fNk2yK8nvbUXXdmRJx1z
         cCqriKI17yrKhkv0kKzoJ16L0uy3vnlg+CZzEvRCuYsAwk4IE1GE63/bHIpcPVLyltLD
         tLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771088972; x=1771693772;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IUlnbhB2kMGCrw14cml/lzwiGDaGw9e5IGUkFOP+xk=;
        b=dWdVHOkoo9r5MGtfEJl03zpnBdlwoMT+8bj0J3eiy2RHd5txk85JPjdfnUHYkGdqbi
         wVM6tCOoxwCcRkaD0JVoxeBa+CJGqN2nb5PfOM+304yMgL5ll24kUTTSYVHNlikYyWdN
         jhG4dK0QwmZ9ANaFXB1UbcDEOd52mNBU/lvlJlIFBYYubFA86h0Irwy42YNb45C/Kjio
         z7w4P8T5i1Wp957Oh4aZoapv+/xGnm7yfTKP1C8+oBJtjVxW5u0Qlq/4BwWq7zcDzL8k
         2sb+65QmHNijJ/AtmQdhfp5RjveIc6ZIavJstAuELSz7Xr5W3pw6LiCTjdozzVMiIYbM
         GL7g==
X-Forwarded-Encrypted: i=1; AJvYcCWkxQt/gQZMy4u+40nf45ZwyYpt2OUxEQAlSqc0+KA8dIMEgo3NNfnjUM53ckwk1+HtFteHSoLs208=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw73BLDxsHvrRY+g4tjPuzsGgfgDipYu2scx/pPipHBoRlzq0Jj
	5QHN5PsYMmCftiGrv0arghaO3QI3f7YFmgMS20fS1SfW5YA1Q3jcnKBFeH9cw8lOcmU=
X-Gm-Gg: AZuq6aIh26QjYZZOVP6m73poB7EiGMzyMsX6c2XdlUpVWZy2/rTKKIJG1KEPkO8kcSZ
	Xs4fiWQTGVFjrEY+jBKbKX26H+QP9tSGpChzlNiHACstbjFluOoW7TUv0/wj8gC1jJGtMNWXuMB
	uueO856iv1pfRAQX657IlQI5BZO/Ur1aQXvQDEaHjNSMRIVXVlVHhC03F8npieJkpUVI+4+EFfh
	/8zFlCT0hrjYrLaL/tYxvcutURFGp9mtIYlfzNGHkW/amOnUFQ9CtY4suKy535Ga3G7sIuPCCSp
	NMmacgWGt+n9NJLxN4nERKVXmqF4Nv14HKpNZ/1Ygxd00oAdIMEHx5/k8+0GuwL/K+R0jd8EYMY
	0Mp6naZv7qrnNqmFBXd4Hpimn2ENnauBthDdbIWfKyv3AFZQ58MaM8wk3OY+6LtnwHln6zifOr3
	UT/bg16fZNheaV5PRk5tXLai6pxyVXK4bCFRnmNJjnHEkQDF0yS6evhvEOdi23L9z2BvJqpg==
X-Received: by 2002:a05:6820:80f:b0:676:96fa:299f with SMTP id 006d021491bc7-6776748602bmr2433820eaf.34.1771088972181;
        Sat, 14 Feb 2026 09:09:32 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:109:393c:254e:962e? ([2600:8803:e7e4:500:109:393c:254e:962e])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6772583294bsm3334429eaf.14.2026.02.14.09.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 09:09:30 -0800 (PST)
Message-ID: <40a0d410-731a-43e0-9078-bc8190ccba87@baylibre.com>
Date: Sat, 14 Feb 2026 11:09:28 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] iio: accel: adxl345: Implement event scaling for
 ABI compliance
From: David Lechner <dlechner@baylibre.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>, jic23@kernel.org
Cc: rdunlap@infradead.org, skhan@linuxfoundation.org,
 linux-kernel-mentees-archive@lists.linuxfoundation.org, nuno.sa@analog.com,
 andy@kernel.org, corbet@lwn.net, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260208150515.14798-1-0rayn.dev@gmail.com>
 <20260208150515.14798-4-0rayn.dev@gmail.com>
 <af774bb9-817d-4d88-9fe3-54468949ea54@baylibre.com>
Content-Language: en-US
In-Reply-To: <af774bb9-817d-4d88-9fe3-54468949ea54@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/26 11:02 AM, David Lechner wrote:
> On 2/8/26 9:05 AM, Taha Ed-Dafili wrote:
>> The ADXL345 uses a fixed threshold resolution of 62.5 mg/LSB for
>> event-related registers. Previously, the driver reported raw
>> values without a scale factor.
>>
>> Implement IIO_EV_INFO_SCALE for all event types to provide the
>> conversion factor (0.612915 m/s^2) as required by the IIO ABI.
>>
>> Suggested-by: Jonathan Cameron <jic23@kernel.org>
>> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
>> ---
>>  drivers/iio/accel/adxl345_core.c | 28 ++++++++++++++++++++++------
>>  1 file changed, 22 insertions(+), 6 deletions(-)
>>

...

>> @@ -228,15 +230,19 @@ static const struct iio_event_spec adxl345_events[] = {
>>  		.type = IIO_EV_TYPE_GESTURE,
>>  		.dir = IIO_EV_DIR_SINGLETAP,
>>  		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
>> -		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
>> +		.mask_shared_by_type =
>> +			BIT(IIO_EV_INFO_VALUE)	|
>> +			BIT(IIO_EV_INFO_SCALE)	|
> 
> What is the units for gesture that we are scaling to?

After looking at the docs, I understand this now, so no need
to reply.

> 
>>  			BIT(IIO_EV_INFO_TIMEOUT),
>>  	},
