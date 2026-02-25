Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB6731283E
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054828; cv=none; b=srhGpJBczdLfDJ7TQrw9RIIKDrWq0xIQ+9uoQ4uQvDjZeELoEKK4kYHR5kGfyAgtZSUKxpD+ZACTXPSop7FhPTFurdXPNvewl5ava9ZhlDOzWAcDkyBJI2tdYCrp5eMbATQebPxWADkWRL6UYIpS82iZit1kkoT7HgROXkTC9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054828; c=relaxed/simple;
	bh=mh7qnXYQkA7Ahj7W/PrVnNLs2LTGDLU5gA4Glh8Uqq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qNmfhCMqg4X7g0qyIIoRPWlLuzEVXnadGDKnAGFjE00wK3x5IxTwSrOSRIb3pSjiB/CeDNJAJr7wjR6Iu2h6Dnka/uWVEWDOD8x1ALoL8/q+ViP8Mf2Ux2JPBnQ72qQJKXr3S2z7LdMUzRVItryQWhJChIONv2gwE39yfSQ+UyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RUVhRHfi; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RUVhRHfi"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d4beaf25deso1069115a34.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 13:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772054826; x=1772659626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UbuookLTgSsWfKX0tCmhPtZVpYMExZUrx5/0NdEq/IM=;
        b=RUVhRHfia93HZfa9g1+zkbL4Qiik6Ub8KzGhSdJl0oq6lAudLwDOS3kc1VL9hshREV
         H5uJq/UeKWbxxh/miIWx0papVf1+ZsjXamQunOfnO/JUpoyT6L5acKbvq00OlbdbxF8C
         r+g5pJmthh888OeJXX6RdbRzu7vPzD0eueZRJyl3AZWBaUv0BidvtcMOumUUVBm0EX+L
         JKefV51DezaKZaD0SnnvMpb8qXDaeU+KxRaLSVTdmIUeU6EtlUnESjxM0DdTYwqk3dR9
         y1f2yec4qA0Gd4U6bA6JqaHcYlZpeDsYqUwSkVBCIG+5MSiM/Sx4nFY3/MEh9Uyh5yOz
         43jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772054826; x=1772659626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbuookLTgSsWfKX0tCmhPtZVpYMExZUrx5/0NdEq/IM=;
        b=c8UYTFHrIuVhUPpLa3Gca5o/E35ns0KhnCN2zkeOy7C9DcE1ufoxoYWt3KMi/RMO56
         TBKakUFkFS9BmcEUmmmLgMrAmhKe8Hmb7WlfOe6TCA7/UO6+C/tyaxj2AnK6LMqpY/eM
         SGm9G1zVfU1//bBFVGUu5uDGwOwTdu4c0adRbMjB0Hm1xTTAfOW2qZYwSYdCOHL0o2t9
         307HYTWr9WlodsT5ErPGidFHfjJU47FgU+u/YGBslv72hq6LshTAEsl8OIzEfxX+AIel
         idZc5eddrawTVd+spETvrJ7fwQECbzvftubceED4LQ5FuHAqsQbLriQztfWi3+KyRHuR
         eAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHsO0Sb4revR0WM0r4kB3gkIASkWc1Q3WBaSyQw+T1x5Z/6usNH5lk+UVSQuY/ZDC2YSv9+NCR2FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnElEakCIZDPt2mjZZgDvHEREheSbIxCAtCQtGpSVrmNeO9rjW
	d8k8bN4w2VX8Q0FTS3Fi8rwz0XSpBjGmtNp1XJmaVy6w4MrZEfEclC6p8hoJWB0Z3xA=
X-Gm-Gg: ATEYQzx17Yqg7wxBEh1ZqMMFDTXGmwmcF0wbjR89fv2I6KNANR1FoEfn2gt/JTqjj2E
	yRc74pfscpZh0pobMCz2JwCdilt0Lu6xKurqXphEfda5Pb0DpyjIZoVN1kAsDYvquNALgpw76Ph
	rDLegWNHbe6UL/9JoMDlsUfvT8gapXpzO8w5zS9X0Jdbc48O67QjDBoXyc2NHtklQjjibD6ZkBJ
	Eb90SqqTILr/BsxCEJaEOedl7LWB/28jsWvU6BQDt0Vovq0LYrJIkD6uSU+vHC4+d876sAXFZ7y
	MoutExWWt0yySkBC0qQUs+1NWlnX54l83z5qF2c3iX/Y1oLtbZL8WypYHriQyC6xtcVenOGXfOL
	oSyQVngxhRzjEJHCpyiQXQlZdzBsLGh4MSzwlPcww8H2lP5L5z3uxiRjBf/rtv+nvkXItCAV1Wn
	IjPvB9xEXZap4CybuCmzE1CAMzmm0j301i52SVeLdLlY5SoY8gWTXxXwVD0GuUtuK1tMYTx3A=
X-Received: by 2002:a05:6870:e310:b0:3d2:e6a7:e938 with SMTP id 586e51a60fabf-41609ea9226mr370316fac.15.1772054825834;
        Wed, 25 Feb 2026 13:27:05 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:146:def2:caeb:cb1f? ([2600:8803:e7e4:500:146:def2:caeb:cb1f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf2572bsm64198fac.2.2026.02.25.13.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 13:27:05 -0800 (PST)
Message-ID: <9c0d071c-b842-47e8-87bd-4e06afec57ef@baylibre.com>
Date: Wed, 25 Feb 2026 15:27:03 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] iio: ABI: Add support for floating-point numbers
 in buffer scan elements
To: Francesco Lavra <flavra@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260225100421.2366864-1-flavra@baylibre.com>
 <20260225101748.2368295-1-flavra@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260225101748.2368295-1-flavra@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/26 4:17 AM, Francesco Lavra wrote:
> In the data storage description of a scan element, the first character
> after the colon can have the values 's' and 'u' to specify signed and
> unsigned integers, respectively.
> Add 'f' as an allowed value to specify floating-point numbers formatted
> according to the IEEE 754 standard.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio  | 33 +++++++++++++-----------
>  Documentation/driver-api/iio/buffers.rst |  5 ++--
>  Documentation/iio/iio_devbuf.rst         |  3 ++-
>  3 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 5f87dcee78f7..61961bca4dce 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1510,21 +1510,24 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Description of the scan element data storage within the buffer
>  		and hence the form in which it is read from user-space.
> -		Form is [be|le]:[s|u]bits/storagebits[>>shift].
> -		be or le specifies big or little endian. s or u specifies if
> -		signed (2's complement) or unsigned. bits is the number of bits
> -		of data and storagebits is the space (after padding) that it
> -		occupies in the buffer. shift if specified, is the shift that
> -		needs to be applied prior to masking out unused bits. Some
> -		devices put their data in the middle of the transferred elements
> -		with additional information on both sides.  Note that some
> -		devices will have additional information in the unused bits
> -		so to get a clean value, the bits value must be used to mask
> -		the buffer output value appropriately.  The storagebits value
> -		also specifies the data alignment.  So s48/64>>2 will be a
> -		signed 48 bit integer stored in a 64 bit location aligned to
> -		a 64 bit boundary. To obtain the clean value, shift right 2
> -		and apply a mask to zero the top 16 bits of the result.
> +		Form is [be|le]:[s|u|f]bits/storagebits[>>shift].

Not related to this patch, but I notice that this is missing "repeat".
\
