Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649FB263C8C
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785686497; cv=none; b=TknqFZZhSXyz+UvvQNJAJlmOb3TwZrAqJ8lVIzHn8S7ZUdD4Y6LDuYLdVMDBRY6/kCVnQc0wJvh4sMwn7b6kRHMKrKNEh0ZUZGo25hMUoaYEYW34pXWf08siIRrJK98/7WG+oM5Gwsx1bEFQo8QmamJmOEY5lKHBu9b57HS5xNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785686497; c=relaxed/simple;
	bh=jatuBD+bPXjgYDgUm4cT+DleRbfJJnJoNvIuRMWW1VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxrIKnjMWlTZbnu4HBaDk9bsJdvO1S+HdhHBg3l+mJeJfQtw+LI58Dp0rkGJVqgz5z4mZZ/9qV7nkCuWoW5emmFKTX0O/AzhsdGdAbXk4jFwqKeXx7hLn2Cyu/C6vVcBkR+7k1cGwdwUK0sgD97mrFp9/VqeObPWTSAV15kfQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=E5jupX1/; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="E5jupX1/"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6ae409c13d5so972952eaf.3
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785686493; x=1786291293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=foh7gM8l446Brx2CHYzHFbFF7Zo+xXckH05CdcizIR4=;
        b=E5jupX1/U+//TX+qYoOXsIDDFRN4+bTdk9y+F+MDm2sPNxlkPjmiODqz3WGyljYT6J
         obfsoIevjvSaRoLTHSy87i9sX9Mkv1E3haEom5QiTFsUX9iYOmH4FKX0BvhYm+2fP6Qt
         D4fdweOy8GP5AJZZ8Sg4mspxHeuh31ziySTFhlatFnlNF/yHKixXPm0roPuzfF83uMeF
         V+EPiXAL10akvg70+H/o9oVZT1o1wYHTzpqZwlJINB8BxqHlBEhwsgPRxggt15OA6Rpg
         CQKJac5gHKjwbp/deR94dIOscPaNMpQn05odAzgLsp+WR4z6pTcKLr2DlQLe6EwnaO9Z
         NWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785686493; x=1786291293;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=foh7gM8l446Brx2CHYzHFbFF7Zo+xXckH05CdcizIR4=;
        b=WIcmYLaTUApxNG8eNmmQsrGMG1jfgsdNhDYH2dY+oheqc7utee0uaygR0XEbTvpO3U
         36h20dBRsUY79RmLkl64H4plx8B+IzzqjkdJ/2aKh54Hdt21MiVpfRiqG1nLrJbYqrjS
         e60WNiiIdgMcS22/m45ugrNOPBS9NWpprCxpWlCHOnR65itwxv4OUL4JLjJecuUN5fiD
         b13I6va5UwTioz4MOrzxGqqW3CMEEEFYdjPWNb6OmVTAiniQFYlwERMDPcUlz/Kk2noR
         7tnpPPDIcule2EDdwPoif10NtMJgQOsErFaEpeA4GAWqpIvP/t5Qy2+wtydqmHspacwY
         BPkA==
X-Gm-Message-State: AOJu0Ywjuv3EwUAqzd7f/OmrXxX7dwrw2/SR7nFm0p2dZ3P81kAEMXuj
	VeLUb/BhxDum2gpJ5nZGqrpwMiQiz+c/3UPjHds/sv7Nve0GhLELCG39U6ob3iySNKw=
X-Gm-Gg: AR+sD13AcUuHPz7m34IKUpOOgMQrxm3cBS1+OWVPMtYaOsAF8dl7NHYN9rk2WIGu5jy
	iUX+re8H3mQYub7gyIxUYA0paf8MYA7rbNzfB/1RxLLy63Qlv6ORn8Rcum8iAhx/lqgIeKZrwkm
	MfJDpfHVhPJiRLu0IkOu0+Z6WCtrO21h1KwvLe1sNVFTaFIjGlyYZ47YvVdkL2HB4nQin8ubRXE
	TRJHwJ4DJ+YMwJE/esQPSJ2aUrhkmQ8uw6s6N0AW7/uZoJ3mzrAs+EkUYcuH0SsnxxihwIfVaWn
	vTkkMzRh1UC6iEYMsBjEkxu4MMNGO+Z+Tk+UvAxjxRtD0fgYw7edLAcS+rYvZcYZzeYjZslxdCw
	+fWeJHtr845eKLaf2ocJtxSs2a1uHY3mxxy+Ac2JyIhPeNYdK55wu/pvJcai6Hxg8g9rsbW6P+k
	LoANHIXf/qEgnd1+DyTDZwQfkN3TBnDMgf9zEdhxjVObaVU8VFfPVcsy+eoICY18nHxuC7k5+u9
	d1X+upbvrslEFObid2A6ZhepDSIHNaDIR5CZtgIwsHMaigKcw==
X-Received: by 2002:a05:6820:1693:b0:6a1:363d:bc42 with SMTP id 006d021491bc7-6ae432d60f9mr8461678eaf.15.1785686493213;
        Sun, 02 Aug 2026 09:01:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5487:2b6e:1057:d3d3? ([2600:8803:e7e4:500:5487:2b6e:1057:d3d3])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae3a319d0dsm5050615eaf.13.2026.08.02.09.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 09:01:30 -0700 (PDT)
Message-ID: <cfb955b4-0843-48aa-b201-fa60aceb03f9@baylibre.com>
Date: Sun, 2 Aug 2026 11:01:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] iio: core: add IIO_VAL_DECIMAL64_FEMTO format type
To: Wadim Mueller <wafgo01@gmail.com>, jonathan.cameron@oss.qualcomm.com,
 krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, maxwell@maxwelld.cc
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt1@gmail.com,
 455.rodrigo.alencar@gmail.com, Rodrigo Alencar <rodrigo.alencar@analog.com>
References: <20260728214943.29820-1-wafgo01@gmail.com>
 <20260728214943.29820-4-wafgo01@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260728214943.29820-4-wafgo01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 4:49 PM, Wadim Mueller wrote:
> Extend the IIO_VAL_DECIMAL64_* family with a femto-scaled variant
> (scale 15), following the existing MILLI/MICRO/NANO/PICO pattern. Both
> the read formatting path in __iio_format_value() and the write parsing
> path in iio_write_channel_info() (via kstrtodec64()) already derive
> their scale from "type - IIO_VAL_DECIMAL64_BASE", so the new type only
> needs to be added to the respective switch cases.
> 
> This is needed by drivers reporting very small SI quantities where the
> existing pico scale loses precision. For example the Sensirion SLF3S
> liquid flow sensor reports its volume-flow scale in m^3/s, where the
> SLF3S-0600F scale is ~1.667e-12 m^3/s: at pico scale only a single
> significant digit survives, whereas femto scale preserves the full
> sensor resolution.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> Reviewed-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 2 ++
>  include/linux/iio/types.h       | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 37cf2817b3d0..767a7794624a 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -715,6 +715,7 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
>  	case IIO_VAL_DECIMAL64_MICRO:
>  	case IIO_VAL_DECIMAL64_NANO:
>  	case IIO_VAL_DECIMAL64_PICO:
> +	case IIO_VAL_DECIMAL64_FEMTO:
>  	{
>  		int scale = type - IIO_VAL_DECIMAL64_BASE;
>  		s64 frac;
> @@ -1032,6 +1033,7 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  		case IIO_VAL_DECIMAL64_MICRO:
>  		case IIO_VAL_DECIMAL64_NANO:
>  		case IIO_VAL_DECIMAL64_PICO:
> +		case IIO_VAL_DECIMAL64_FEMTO:
>  			dec_scale = type - IIO_VAL_DECIMAL64_BASE;
>  			fallthrough;
>  		case IIO_VAL_INT_64:
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 924ac9dc6893..d8944c9e5e90 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -42,6 +42,7 @@ enum iio_event_info {
>  #define IIO_VAL_DECIMAL64_MICRO		(IIO_VAL_DECIMAL64_BASE + 6)
>  #define IIO_VAL_DECIMAL64_NANO		(IIO_VAL_DECIMAL64_BASE + 9)
>  #define IIO_VAL_DECIMAL64_PICO		(IIO_VAL_DECIMAL64_BASE + 12)
> +#define IIO_VAL_DECIMAL64_FEMTO		(IIO_VAL_DECIMAL64_BASE + 15)
>  
>  static inline s64 iio_val_s64_compose(s32 val0, s32 val1)
>  {

Would be nice to add this to drivers/iio/test/iio-test-format.c too.
