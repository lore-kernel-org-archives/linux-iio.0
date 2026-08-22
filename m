Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5913FEE
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787422061; cv=none; b=gKxf2yPaV7/jAGdxd5r30uYaF7iM99Qew9ISH1sOWR4vqAcrdJJLp5bO41a6tdr5BsfWGjGyq1XUg41iAh2jevyssu1pDkJWaDTPY/p4eT+WaVKcq/tpm4qFlJH1EpJcJjbClK4fmrX7LThYhHHT6L1JLlrwbyhlurrnPHqvQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787422061; c=relaxed/simple;
	bh=UyliAU/TWKdu2+QHcGCwgVVfJ/feY4c1ArC80AzL8kA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nq5uItJ68bRHFc2WixE3PsAc1O4+TbcC1nABdfcS5LSC5ZArci1IqT0V2o8mLDuS7KQZtpU01rYZwqCN47BB9FS2jp6lrrjMGoGSkuM1aZDwSqB90ULETQ1eV00fz/R+x+Tr7wnz1xp6/ETrH4UV9QPTLAmFv6su0KudY9MzEZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=JV1Nh/1h; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="JV1Nh/1h"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7eb787dec99so1912346a34.0
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787422058; x=1788026858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ai60m3gekOryvyzc2pj7qkarxcUivXM0zaXj5jwrC4=;
        b=JV1Nh/1hBJF3aZnYw0lbxVXRnxGnMY9MT2xMJp+qef7qIHPRZI6cEK16+RRatpuRGd
         TP5telnEmh5Uz5I+yf6jxzrQkAbttMd4kQVyj8RsFaxnq56+epvEeS4C/IqmfoXcY8j7
         40Ff7pTtMiVcS26W/MnB8oD0/HoA0fZuMkwFI7AFPriWUFAqew+OtSajd0YHQEJyvpcd
         OGtY9n8MgqBnIsnQzay1APklPXirzjfqQ5w0LXfopTiONsHsDwGHxX0IBDjIQPAty/5g
         VEt4tljYj5R/4ehDtjFKkdR46W2jiNoyvUn3Wzs02R2zcL2cKSBMCKrCxz1oWOEwfC/f
         1B9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787422058; x=1788026858;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ai60m3gekOryvyzc2pj7qkarxcUivXM0zaXj5jwrC4=;
        b=kpDLhA/0ejn/J7KoVgnjOUQo4MHWoYNaa4spSGFBdpJ4AjHOZAryKf+vjKfvEsgW3X
         6zmbxEAm7vuSps6OifFyyXOFsLKgYFpwSBapkrtofD6F8tO84m4GSlc7HnVSL6v1jxKa
         XibGsHxsY+3b9zl5FBHzEhDnDrkgm7FIYB1z5MW5oq3nAs02UXIxx0kQYFNITvoCQDvv
         gQzA1q0t7mQ/op3CNxfU5zNym1um+kmfBUIGFTjtkgcfNsHntQKqfveMakjKz0lUixf4
         pSOcwDFVzkBbdSSRxZG+yRaVQvnFt7xc1O4FNGLnus0A6B3Vdr/XsBBVJZysWStIT714
         68Aw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+WITK94PdGoI8eqXoEtqz7F7wHm+WYR4IbG5Yd2MecI3hlReAkJINy9d7jvzqRRIAu5RM863p23Q=@vger.kernel.org
X-Gm-Message-State: AFuF++k04VuDVNDobvvzDSI/BnA2D0hC1Oc+0Jh9oZCT3X2NnY7BJzxs
	nVt5bnWQ3+7ravhrq16oIzycp6n06oXWYx7/QUfA893yNM6pV4qICIbhsaK8fSpIbFw=
X-Gm-Gg: AR+sD12ycUByuN3ePzPi/lsvUORKzCVFKxuQ8Tij0xjDSGOJq3cpehcVglHzkh9vjBi
	oglpT4mfiT7mNeask9mSPUjwTSyqlpxTyeTQTPI1RdJzSeHSRKNihlurZ3fTE4gLDBFXt3e3dv1
	Hsjic+HhB2yxbTdaA/3TzJe7ZWsf09H5KqmVYD7kVKJ+C7R84dgGMdjycsWhVQXWgXEylb0dIAR
	1qxMCjER1ptgMrfEXrf4lWZ9Fs3XBrSx2No1nDWRHz1q7dhP7CvubaqTrgx7kQuRwABpFAr9M9n
	hpYFpNROpjiKKU1lM9fhoq+lVRYOjL7Qnl1+0ICcEVMena+KrblBQuDtE7QZGQOodisIJWb0UPS
	rhOUsKN+Sw5OyChY6MxToc7d+EKl9x5rBFbSkz12ASiSkCQTWJOolNxDLDC8ZDqaZbHYVrK2kUJ
	QG6QfnIpJLUK+4f8KaQrG6qrOHyKEPV2CDI4p0+Faoj6gLYouOHl2LJ2VQB3rI5UKo91LCKoeOA
	2ftWKm8kICLDFLXEvASt7D3hI2hXkkCY82a7js=
X-Received: by 2002:a05:6820:28c7:b0:6b1:5637:e10b with SMTP id 006d021491bc7-6b16b2f5fddmr5652737eaf.7.1787422057715;
        Sat, 22 Aug 2026 11:07:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e0ca:316a:4629:d835? ([2600:8803:e7e4:500:e0ca:316a:4629:d835])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13cb557c1sm12256661eaf.2.2026.08.22.11.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 11:07:37 -0700 (PDT)
Message-ID: <32545533-b792-41a9-91e0-5353112cbb62@baylibre.com>
Date: Sat, 22 Aug 2026 13:07:36 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: iio: Correct ADXL380 filter descriptions
To: Randy Dunlap <rdunlap@infradead.org>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260822073653.54545-1-kmehltretter@gmail.com>
 <a1eb791e-64b5-4602-8b5f-afe1ac15b7db@infradead.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a1eb791e-64b5-4602-8b5f-afe1ac15b7db@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/26 12:00 PM, Randy Dunlap wrote:
> Hi,
> 
> On 8/22/26 12:36 AM, Karl Mehltretter wrote:
>> The high-pass attributes were described as low-pass filters and vice
>> versa. Correct all four descriptions.
>>
>> Fixes: b6a097a9af00 ("docs: iio: add documentation for adxl380 driver")
>> Assisted-by: Codex:gpt-5.6-sol
>> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
>> ---
>>  Documentation/iio/adxl380.rst | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/iio/adxl380.rst b/Documentation/iio/adxl380.rst
>> index 654d4c0e84a19..a1c249dc2e51c 100644
>> --- a/Documentation/iio/adxl380.rst
>> +++ b/Documentation/iio/adxl380.rst
>> @@ -39,13 +39,13 @@ specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
>>  +---------------------------------------------------+----------------------------------------------------------+
>>  | in_accel_scale                                    | Scale for the accelerometer channels.                    |
>>  +---------------------------------------------------+----------------------------------------------------------+
>> -| in_accel_filter_high_pass_3db_frequency           | Low pass filter bandwidth.                               |
>> +| in_accel_filter_high_pass_3db_frequency           | High pass filter bandwidth.                              |
>>  +---------------------------------------------------+----------------------------------------------------------+
>> -| in_accel_filter_high_pass_3db_frequency_available | Available low pass filter bandwidth configurations.      |
>> +| in_accel_filter_high_pass_3db_frequency_available | Available high pass filter bandwidth configurations.     |
>>  +---------------------------------------------------+----------------------------------------------------------+
>> -| in_accel_filter_low_pass_3db_frequency            | High pass filter bandwidth.                              |
>> +| in_accel_filter_low_pass_3db_frequency            | Low pass filter bandwidth.                               |
>>  +---------------------------------------------------+----------------------------------------------------------+
>> -| in_accel_filter_low_pass_3db_frequency_available  | Available high pass filter bandwidth configurations.     |
>> +| in_accel_filter_low_pass_3db_frequency_available  | Available low pass filter bandwidth configurations.      |
>>  +---------------------------------------------------+----------------------------------------------------------+
>>  | in_accel_x_calibbias                              | Calibration offset for the X-axis accelerometer channel. |
>>  +---------------------------------------------------+----------------------------------------------------------+
> 
> These changes LGTM. Thanks.
> 
> Although I am a bit confused. When I look at the adxl380 driver,
> I don't see any of these device attributes.
> The attributes with these names are in other drivers/iio/accel/
> drivers: bma180.c, mma8452.c, and sca3000.c
> Can someone try to explain this, please?
> thanks.
> 

The attributes come from:

	.info_mask_shared_by_type =					\
		BIT(IIO_CHAN_INFO_SCALE) |				\
		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |	\
		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
	.info_mask_shared_by_type_available =				\
		BIT(IIO_CHAN_INFO_SCALE) |				\
		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |	\
		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\

in adxl380.c
