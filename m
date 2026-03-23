Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8133B8BB2
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282094; cv=none; b=ndp/iebIxU4NxA/cxMPag82dgw3P4yuGTM2xOxBSmCT4wVF3R9ZVP3cIvaGSOhkyTHWtO0459awyMtw7uFyL9jvvOxZm1U8lmvG+X4mPbW26FUFZkgOBqzILQoweoleFHgibtiUPm6aJL2BdgWqpH59FUDP+IlJqA41VvsfoHQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282094; c=relaxed/simple;
	bh=o2DCwQCqpStVaX+n7FZYKQBtL2OGc+iF8tHcAp7A8DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cr5uFBeUcX3y96iAuSEkzHHpHYlPZXe1G9AQciOAZPUXUbEugBHxHSdwYXyhMK/AcsxlhCWDj2trxmmAgk7Sg3wzu8bgtEUTAGX11QxoXGwXC2Y3KbcykOI2PhWLcdArlNrjl1CFSFuCwybLSZ+uusGycPsqbu2t3luqY7zzvkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Z52zxUR/; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z52zxUR/"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-67df55bb1efso66256eaf.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 09:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774282086; x=1774886886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wyzGrNVisRoMpOWKYhySoLBPe/90QEbmgHqpo3IVsN4=;
        b=Z52zxUR/IBz7v+oXaimaZCu91W0Bnq9GPOANruxKsfoK9XiRJ1HkAdJxxxWNjd1A6s
         lTzSoY4hE1TnlVN6+6+vDdhHwdlZZreyCJ7GGUe8U5WerjxeFLuC/CKeVset+RT0MKSc
         fgFlD0rdJyVcT9PHeO57T6uLAl5QFTR/89Vo/WiZyjtIy64nfwGzgeSEddahXlM/LO9K
         gGRwLO+WwNDRGveKg8Ny5QOLzR7f9Z70S3Igz4Z46WUxjdJ1frUSXy943v8VcZjrROH2
         461O/D98Z3Yj6s1Q6JYK0vKLKwU8Wu4HnQaI8x07ijhAJItIV3iHcyK/oeLctLBnvgQO
         kPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774282086; x=1774886886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyzGrNVisRoMpOWKYhySoLBPe/90QEbmgHqpo3IVsN4=;
        b=HznC5q/1OTa2wGv40EMLKUp3Xwf79GpmMwyN+NUkpeP8myHqwSDj80jwQWmbw2qDwY
         EstADlc9FACV2c8r/s5MOTOJGdp2SYswa55L/zaMtvbk4y9WIUfSYhryKCDL2aGPPd0j
         4DGNwouWz1W+2fmoVidh1rPp9vJPA2h6DB+uxeTmB23qi1GnJKD+eIriRSG6OIasBwYn
         jCipCCTjyCMoJNhnAUPIiylfXOJghEo0Rk1zOw0QagxhjMLDb6JAnAtkonRI59hKqjDO
         V6nzYMawEnKon9raJWGvCegtgumrblo5v3GpR74anVwOhT2tPEQn/cyObG4cyIM4Ek1Y
         279Q==
X-Forwarded-Encrypted: i=1; AJvYcCUX0zuJg+lNdueGW5jeeHLyLLDCsyJt3lnYxU6l0II8cvUVuH7DARVZAWx9LX+J5lJh74WuDgKerKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBh+UJ9OKBTT5/in5kkHKeUjjnkPPxTQfdO8VnCY14fyzUYzl8
	7DYHdyRqMCkw1IVRdONsred3X7UwrPbhPBlfqE5O7PgAEDMasw2RcWIy5kjzXtUadBc=
X-Gm-Gg: ATEYQzzk2rw9dIx0ptWZfj/QyrWvAI/7wwc3mHFxuoE3Ug9ap80H60/ICXJpaYfeFhZ
	hVFZvXEsjN9Y9On81jLnT45Oj+i7x9smHfN0+fcQrO0/nBUQ5/ZcCtlkTDbbQ1GeCnXFSogSpj7
	Aipo6tO97WTETdYetxdZyhvzrHSiDMM8sZpqX3R8N7hyCLuemuM2w929xBYEveunK59QckObXgx
	peADu/3XtPkDRLukucjQKgHXSJWFZ4cHFNOPSmdb0wZ2Zi1ZV8shC54vb6R/dHxTXC0QAAYNFgI
	o99yWF/ayPzkJ73LhhfJH5b6pxDFHSlU5GvsBOeP9WJEdcXzhiF/qpskJ2lUQ80OapA+7J4cCvd
	wHRU+zVMpZ+s/7ZwFOxBWLdnwb+Np2nll6gPEY6m5D8uOXf7wz3+K83ft5z6r3GKdtvsc9R9iXY
	jvkqu/SnZM+uh7YLjnnE5jMO5/CsXEILrjrZpSfK4qGWEgNzLhB0GDW1Lx5V6mISsSHNoJErk=
X-Received: by 2002:a4a:e90f:0:b0:67b:c368:136b with SMTP id 006d021491bc7-67c22ef5124mr8523215eaf.29.1774282085727;
        Mon, 23 Mar 2026 09:08:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:964:f712:dbc7:4119? ([2600:8803:e7e4:500:964:f712:dbc7:4119])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c252fe793sm6809434eaf.8.2026.03.23.09.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 09:08:05 -0700 (PDT)
Message-ID: <1272b66f-2d7e-4f18-bf00-f49b3c02213e@baylibre.com>
Date: Mon, 23 Mar 2026 11:08:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/6] iio: Replace 'sign' field with union in struct
 iio_scan_type
To: Francesco Lavra <flavra@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20260317150316.3878107-1-flavra@baylibre.com>
 <20260317150401.3878294-1-flavra@baylibre.com>
 <4723284d-1e18-4a13-9ec1-878220af257e@baylibre.com>
 <af2128c68d2a14e1eb664ce9dc075ed02b640407.camel@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <af2128c68d2a14e1eb664ce9dc075ed02b640407.camel@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/23/26 11:04 AM, Francesco Lavra wrote:
> On Sat, 2026-03-21 at 12:22 -0500, David Lechner wrote:
>> On 3/17/26 10:04 AM, Francesco Lavra wrote:
>>> This field is used to differentiate between signed and unsigned
>>> integers.
>>> A following commit will extend its use in order to add support for non-
>>> integer scan elements; therefore, replace it with a union that contains
>>> a
>>> more generic 'format' field. This union will be dropped when all
>>> drivers
>>> are changed to use the format field.
>>> Opportunistically replace character literals with symbolic constants
>>> that
>>> represent the set of allowed values for the format field.
>>>
>>> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
>>> ---
>>>  Documentation/driver-api/iio/buffers.rst |  4 ++--
>>>  include/linux/iio/iio.h                  | 17 +++++++++++++++--
>>>  2 files changed, 17 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/driver-api/iio/buffers.rst
>>> b/Documentation/driver-api/iio/buffers.rst
>>> index 63f364e862d1..e16abaf826fe 100644
>>> --- a/Documentation/driver-api/iio/buffers.rst
>>> +++ b/Documentation/driver-api/iio/buffers.rst
>>> @@ -78,7 +78,7 @@ fields in iio_chan_spec definition::
>>>     /* other members */
>>>             int scan_index
>>>             struct {
>>> -                   char sign;
>>> +                   char format;
>>>                     u8 realbits;
>>>                     u8 storagebits;
>>>                     u8 shift;
>>> @@ -98,7 +98,7 @@ following channel definition::
>>>                    /* other stuff here */
>>>                    .scan_index = 0,
>>>                    .scan_type = {
>>> -                          .sign = 's',
>>> +                          .format = IIO_SCAN_FORMAT_SIGNED_INT,
>>>                            .realbits = 12,
>>>                            .storagebits = 16,
>>>                            .shift = 4,
>>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>>> index a9ecff191bd9..d48a0ab01b8d 100644
>>> --- a/include/linux/iio/iio.h
>>> +++ b/include/linux/iio/iio.h
>>> @@ -176,9 +176,19 @@ struct iio_event_spec {
>>>         unsigned long mask_shared_by_all;
>>>  };
>>>  
>>> +/*
>>> + * Format values in scan type
>>> + * @IIO_SCAN_FORMAT_SIGNED_INT: Signed integer (two's complement).
>>> + * @IIO_SCAN_FORMAT_UNSIGNED_INT: Unsigned integer.
>>> + */
>>
>> We could make this proper kernel doc format with one comment per macro.
> 
> Actually, a set of related #defines can be documented with a single
> comment. I see a few examples doing that in include/linux/gfp_types.h and
> include/linux/fpga/fpga-mgr.h

Fancy. Although, IDEs tend to be able to handle doc comments better
if they are not combined (i.e. getting the docs when you hold the
mouse over an identifier).

> 
> 
>>> +#define IIO_SCAN_FORMAT_SIGNED_INT     's'
>>> +#define IIO_SCAN_FORMAT_UNSIGNED_INT   'u'
>>> +
> 

