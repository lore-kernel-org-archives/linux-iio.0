Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863013264F6
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772664339; cv=none; b=elIdVgXVsXWYji3sG0SrM9t8nADsfFqtRMUHRNDlX6To4A4HV7FWkjsn3IcJiSPw3gAZlz/pPduOJ163zokTkZqd4Ug+Z7mVxxOsK/Sr9E1atNtdb3f2/ljOkFv+IjbTAeUusishMAv/sReji6D1iL2n74xRiFPkCMydoISgpK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772664339; c=relaxed/simple;
	bh=8y0AY7pdxF3ZXmno3d6a1Z5FLbl7EiDCsNEdPAYxEaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m32FxyclNOAeBK8BInPimwLoPDNFsXAdTN0Kb8GyOkBWmBnePxfrHcbPJ4T3UVs5TcP9/MxgYHFPOzQnjqScR7qHSo5/tf8QMBLyrbknG+TYQ0XFrWlc8YQlSedhWL4HgeLKIMMldj3x7q1jOmoRLz3INwJQh80kRAeK5bZxbAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2B9LJhDG; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2B9LJhDG"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6799774d0fcso4962553eaf.3
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 14:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772664337; x=1773269137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zoM9auab0e4iB9I2DJCod95IuvSIckvHaF9+CeqFu54=;
        b=2B9LJhDGgt6X+2BIjREDLxJWz6cud0LC5cmM9CLWENS31rZEZmH38Pm60H6AY5cU10
         SooEd6MQcakVsCMUpWqFrOo8N9bs4/HkkBuV88Ddele2nHXqJjwO9pAtnFzIb7gTVyQl
         KenJiDQutwP5DB11ua6qpt+x9YaypR3ONBtk3kJ5KWuVT5SR5YndRsBnoX3qdmEYBv7t
         CLaC/h6od5yT+YZ29hcrd51NieXPjO25OtTeTt01hPXUPW6nqxggqfgyEE+dqiNI+jhk
         EB3bnKVYWZ3sGXkB0xJZjNOeHS/uEDnyfEONTcjfEi11Nl6JOY5qh6RL4ijdvxOu8Lg0
         YHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772664337; x=1773269137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zoM9auab0e4iB9I2DJCod95IuvSIckvHaF9+CeqFu54=;
        b=YU5t7J8TP1lwrgK1P7ueoqYOFipfEcwp8b0BejfSDq5Dq8nIUuSXls1s35sco6RAjo
         FXE2as5DBzEMQHFjJWPtORLSpE6WTcnuaYWEI/3671a+PflgJLno7o5lVcMFEEYhxdmQ
         0qnEtSRSVaADO79Mhdn6JbM8BpHvGSKKmExcOGsGTKCItswI8p4mS2r95Yur/NC5Eoay
         pqUda2XYYPVu8AE3k6QBYAMq9P8ChGTwvgnR6d9XJf0PQC3sEAtETg5Vj4KGvs9OXHkX
         6kLflmf+2aIb3w2rHErS8Hh7n4oncGQBdihLPgZ2XYuoc3XGyRcdKf51YRjoHELljTg6
         Cc8w==
X-Forwarded-Encrypted: i=1; AJvYcCXeYM0Ol+lFq8iS5NQ9Na9YLln6znAnOcHN+gue76m5QwcAqBrlyrL4Q/T31agcTLOXqgslAYHHh2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCTO2UTwrB5HEVX5lIGHFCd2iOInVmo+KYjG6wuI3KQ0mOLXAK
	9KgBs9C/124YlPUFnh4Wt2+8IxUukEFYiH9JwZQlKBjsvmXMrN/th/kfJk9YgXVpJAfPYS/9OxJ
	o0/2e
X-Gm-Gg: ATEYQzzW8FPOe+ZOL3UgRdY4PBWiTvI/dS7/2qmoW3/QO+XDGkRuxMy/M7LtRlK7jms
	P1h1DO+GYMUixSE/Dy/TZ1WOS+GoaKBF5eDTSyjQbpKeNkBzRpXMB70GYr5Nmjz/K3IAk1ZrRbB
	Y1HemSuWhKIje6Wy/mkq7emA/wIm43kCCX5arZjSIUpZGiS2Osfb+hoK6oK33M3qcGqwgdm+bnB
	QPn9MhtAXYMkIUlwiZvnsRLiBu2TNp4wu65Rlb2LQj73es4CiDkiEqKRk3HjDdxwsGGLAwUVMg+
	Mo+5iXqfKnmfl6L5DkLBW1uv9VDYlLSJTCaGns4j0xRcFAzPbGKL93gLSbLCQ3h8Ux71A1DR/R3
	40AvxUToKitmxw4QczV7GeBE/EoIyBz1+Uj/cIHzpDo2l8EYakJaVG8Ww/yBgN3dYCMgAYuyEnH
	dihjBvUef3IsdwFwoUojZInQZhH/q1ByTv5b9F56hpC8+hGY9RF052C00yKKVBT12hXcIvCE+gF
	Q==
X-Received: by 2002:a05:6820:987:b0:679:e59a:8b8c with SMTP id 006d021491bc7-67b176f9d8dmr2082246eaf.26.1772664337436;
        Wed, 04 Mar 2026 14:45:37 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d719:8353:352f:b2e0? ([2600:8803:e7e4:500:d719:8353:352f:b2e0])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d84dacsm13903905eaf.9.2026.03.04.14.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 14:45:37 -0800 (PST)
Message-ID: <70f25902-5c79-46f9-8c67-99633b22b5ac@baylibre.com>
Date: Wed, 4 Mar 2026 16:45:36 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/6] iio: ABI: Add support for floating-point numbers
 in buffer scan elements
To: Francesco Lavra <flavra@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260304080519.2844101-1-flavra@baylibre.com>
 <20260304080658.2844434-1-flavra@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260304080658.2844434-1-flavra@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/26 2:06 AM, Francesco Lavra wrote:
> In the data storage description of a scan element, the first character
> after the colon can have the values 's' and 'u' to specify signed and
> unsigned integers, respectively.
> Add 'f' as an allowed value to specify floating-point numbers formatted
> according to the IEEE 754 standard.
> 
...

> diff --git a/Documentation/driver-api/iio/buffers.rst b/Documentation/driver-api/iio/buffers.rst
> index f36e6d00173f..2fc9c2951a9d 100644
> --- a/Documentation/driver-api/iio/buffers.rst
> +++ b/Documentation/driver-api/iio/buffers.rst
> @@ -37,9 +37,10 @@ directory contains attributes of the following form:
>  * :file:`index`, the scan_index of the channel.
>  * :file:`type`, description of the scan element data storage within the buffer
>    and hence the form in which it is read from user space.
> -  Format is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift] .
> +  Format is [be|le]:[f|s|u]bits/storagebits[Xrepeat][>>shift] .
>  
>    * *be* or *le*, specifies big or little endian.
> +  * *f*, specifies if floating-point.
>    * *s* or *u*, specifies if signed (2's complement) or unsigned.

I would keep all of the format options on one bullet point.

>    * *bits*, is the number of valid data bits.
>    * *storagebits*, is the number of bits (after padding) that it occupies in the
> diff --git a/Documentation/iio/iio_devbuf.rst b/Documentation/iio/iio_devbuf.rst
> index dca1f0200b0d..e91730fa3cea 100644
> --- a/Documentation/iio/iio_devbuf.rst
> +++ b/Documentation/iio/iio_devbuf.rst
> @@ -83,9 +83,10 @@ and the relevant _type attributes to establish the data storage format.
>  
>  Read-only attribute containing the description of the scan element data storage
>  within the buffer and hence the form in which it is read from userspace. Format
> -is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift], where:
> +is [be|le]:[f|s|u]bits/storagebits[Xrepeat][>>shift], where:
>  
>  - **be** or **le** specifies big or little-endian.
> +- **f** specifies if floating-point.
>  - **s** or **u** specifies if signed (2's complement) or unsigned.

same here

>  - **bits** is the number of valid data bits.
>  - **storagebits** is the number of bits (after padding) that it occupies in the

