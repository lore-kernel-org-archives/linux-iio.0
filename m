Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3DB373C0B
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772664946; cv=none; b=JS9zZ6EydUXLilAltG0ux4ArNT3Cq/jtZS83n+E9aUT7VFk37cBSImzSxwoNliZVN6VIcU42A/snUecapYGITpqYNFfs07ulg2qISCOCnICFEPFT4NtqUxPXYs51L6h14Em921ccTp649XYqvRN7XpO3Ec/0Xb+b8XjZK/MSu0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772664946; c=relaxed/simple;
	bh=8qlyvD5XDfMUAA6zmyrKLG7QhURU+8uccRHuRSqHzuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ApZIbwLefepiLUcdSFhaTVAdPWobFe9+DfO9MZ19Amh362bpLQQ8iJke+8GW1ZUNKLRq2+iVtb1bt7ZrlYHkJ0VQYHUXKvoW/7i1flmB+ZeyR3yY+Onqk8RdoNt9YijR9gnk6/A9oDlZ/AErfE6KstM5QHGesmEaydpcXtp4Chs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a5TzMh1M; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a5TzMh1M"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-464bba2db1aso2686870b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 14:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772664943; x=1773269743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b+2Q2TnBwC+gC1aFFNGwdS5pgVGKEvldXr6mdw0p25I=;
        b=a5TzMh1MBq5u/CaN3n7JZhnOAT/X4ZN2iUvlI6f+yxC43num+y1D3q7cDm5Liayqzi
         vWs+IuXATZdPGQnXtQYH5w/Si9mDm/zGBoJR0R/7FAA2QoiVnidoOvIW22fMS4zmgdLj
         wuhjNuOyPLrtbvw1G2z+tHyePr6lCR/DeYePzRizsUd+vLRixgwfBlF9iN317jhtglbQ
         wDMPF4KGbHrd0YCdeA8xt3sHXHW5WPi5a/iOp0qG+5ME0GNvii8QwH1RFpv4pFYss6Uq
         3tNiwDGT7fNpmCfhPcGDvFHNk2XeKZaVzVkHQqO7XdadFCYyVUzpvsNkeRwquglb6v4l
         2DQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772664943; x=1773269743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+2Q2TnBwC+gC1aFFNGwdS5pgVGKEvldXr6mdw0p25I=;
        b=KqvZCZIrSX9YiGVAnA9l8HHscUZ/AjlWJOnGEyOwDwmvvvc/VartF5BRuAWBNwtkx8
         iFLBk8zqGOXEbOdFd4qk6vL93u4kyp/MA1kJ1SCXNTBlG/wFUsQS3jtDdwcSGPW9VapE
         0O5sfr/hsMqHSDZLFlk/1LC10zRqaeyibL7/RAlcwWc3WbYKdSIYYwzMBMZFxuKrzoHm
         F88DsnTMGOmCGDIOOxCpDopF9eEazwcN71MqrEHwEKLrWra3FyFFFwKFK1u/LO0kvFmb
         qnJko27RlTvEN54nII4ojk5i2cl9G+eEo28JJqcdcPTe0Lpy7WzrPGY8a5ICHSku5pGw
         E7bQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0FRX8ZWp8+o8dHEQCHNmEccWUMZBoHaa9h4mc0r5SbsPHpOP/snMuh+3xqwtjOB5FQ5BPj2phdXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0PMF+/kXo0ENunzM0/BqD8F2Bgu4l/u1Yz6jUg0heiVmBNC5+
	qXXPuG0gnVjSO4tImyQ7Wp9ylrwrWHxBaLO4gki8VTCKnsVLiLm4W4tvrnki1U2VFLs=
X-Gm-Gg: ATEYQzwn7HpzYIWGJIo5FzFufPzHP/L2xLsrRj70tLgHsvSp6QSb5r3YodSxcdmiF4r
	TYt81kv3abVFQByOew+QgxnUjb6otCIG9VkQO0Rd1NuvJLtJtLqGyZib8M0nDVZVlBMhVW2PFtX
	51Fa1YVx4JefzC7/p86/p6C3MgMJT6rkHhZDhGn/r1oHU2RXgH8k+ZoFUiC9WAlJkD3o9PvOJsN
	abOm9OjnMia79+m8fUscNMOrav8L7eJTAra0eNG98llior8uZeVeH027KE2wgi9ueKUW1lT+DEO
	/kwvjNCl1BlzPXGOaa3tkF9sHr5nj81RqRoBvSBleS/J43HiTCkUCLJbqSWMu4JHtcesp/Bkfc1
	x6YFfpd8bp0Hf7B/nIht6wYoscubOzw4TEpD2bmwz1VGJst/6polE1MIRmwWwa5kTlErENWD82Z
	3bJ01W1Wmh8Lyyq32I5639T+LpnVuCPWKs4LCyGNN+PC5xVaj073PzSThKVn5BDwAY2OJaqkkGz
	moYm3/FMp64
X-Received: by 2002:a05:6808:1693:b0:45e:e07d:4eff with SMTP id 5614622812f47-4651ab996camr1955205b6e.21.1772664943498;
        Wed, 04 Mar 2026 14:55:43 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d719:8353:352f:b2e0? ([2600:8803:e7e4:500:d719:8353:352f:b2e0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb5e0b64sm12432933b6e.15.2026.03.04.14.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 14:55:43 -0800 (PST)
Message-ID: <2110d3be-b55d-4b39-a8f4-ebf1312ada96@baylibre.com>
Date: Wed, 4 Mar 2026 16:55:42 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/6] iio: Replace 'sign' field with union in struct
 iio_scan_type
To: Francesco Lavra <flavra@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20260304080519.2844101-1-flavra@baylibre.com>
 <20260304080640.2844366-1-flavra@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260304080640.2844366-1-flavra@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/26 2:06 AM, Francesco Lavra wrote:
> This field is used to differentiate between signed and unsigned integers.
> A following commit will extend its use in order to add support for non-
> integer scan elements; therefore, replace it with a union that contains a
> more generic 'format' field. This union will be dropped when all drivers
> are changed to use the format field.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  Documentation/driver-api/iio/buffers.rst | 4 ++--
>  include/linux/iio/iio.h                  | 7 +++++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/driver-api/iio/buffers.rst b/Documentation/driver-api/iio/buffers.rst
> index 63f364e862d1..f36e6d00173f 100644
> --- a/Documentation/driver-api/iio/buffers.rst
> +++ b/Documentation/driver-api/iio/buffers.rst
> @@ -78,7 +78,7 @@ fields in iio_chan_spec definition::
>     /* other members */
>             int scan_index
>             struct {
> -                   char sign;
> +                   char format;
>                     u8 realbits;
>                     u8 storagebits;
>                     u8 shift;
> @@ -98,7 +98,7 @@ following channel definition::
>  		   /* other stuff here */
>  		   .scan_index = 0,
>  		   .scan_type = {
> -		           .sign = 's',
> +		           .format = 's',
>  			   .realbits = 12,
>  			   .storagebits = 16,
>  			   .shift = 4,
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index a9ecff191bd9..61f1dfc14e02 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -178,7 +178,7 @@ struct iio_event_spec {
>  
>  /**
>   * struct iio_scan_type - specification for channel data format in buffer
> - * @sign:		's' or 'u' to specify signed or unsigned
> + * @format:		(signed or unsigned) integer, or floating point

We should keep the list of valid values here.

>   * @realbits:		Number of valid bits of data
>   * @storagebits:	Realbits + padding
>   * @shift:		Shift right by this before masking out realbits.
> @@ -189,7 +189,10 @@ struct iio_event_spec {
>   * @endianness:		little or big endian
>   */
>  struct iio_scan_type {
> -	char	sign;
> +	union {
> +		char sign;
> +		char format;

Could add some comments here to say that format should be used
in new code and sign will be removed eventually.

> +	};
>  	u8	realbits;
>  	u8	storagebits;
>  	u8	shift;

