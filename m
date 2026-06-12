Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658953988E1
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255500; cv=none; b=kBORCxVCzUcv8ayrBDX85Fa18dnmCaFL4rhqnvQc5CxuPAMBSDxNWxrcD0FNeiIbte65hZSCsBGTSVoeKuA/q0fTJp/H+NDSNWtt1F73cn9SXx8LDhuJstUxrw1aQIV5IHNLLGBUXIZYEnPSF0usUl+ko1EtXtLF3EpQeU8r0XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255500; c=relaxed/simple;
	bh=zGwXx7r0raUE81oCn824BrKeKDOdBBGsvz4O9QbLsMc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLP9yUwaX3trb5mQ65fHA4vBU9YoxQwEmVXb+o5zl89PgCXlipgwpjOv38kOooDX9jlYw4dY3YVoflFIhJJcjEObLFkIeyDpFi2XrWmcw7RvTsagnWN3JPVu8/WAiJqiUAt3wYAFeoSBg56bPMIPoUbjkZ2342izKOzoLvYnopI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rFCU/nUr; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFCU/nUr"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6924a68e3f3so1306786a12.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 02:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781255494; x=1781860294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jI8LnQZv8N81B+lAF6GsOhfvywQIVQpCH2REI+wbnnY=;
        b=rFCU/nUrlZTsDQVwtFOdGSCtPNdRlxqx0e0N9GR0nqkKMn/VjCJOzDgIlBglbnc1ZC
         HpZsSNccs4H8QfcEHsPwczRJukViMCg9ccMeZyICXFAkw4wvWiDVytyHtLqMQNtsDLVl
         72qD473YJzPiUJe7mXlsoSfl2VkyO7UCSA13Rnhm0i/eeXgzFzvbQHwDPopWi6jk/Nmv
         mmFZl2L3n4q52O+JYRVBNUIaYvLuzypO7q98OJeLjiDZWa4TtP147zknsU/A67h5W3Qm
         N3coJmJ/QZhwX3pnOIbHM4dlJ18YrjYSNh8CTvMKysjKawoflZhiXotbo1/jQq0viLWD
         1gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781255494; x=1781860294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jI8LnQZv8N81B+lAF6GsOhfvywQIVQpCH2REI+wbnnY=;
        b=C3BZ+fmpVoxN5YeIwbD5CoYok7mvP0hNbn/Khm89mvKN4mwJhq7fZkbyfcB2LfYT0g
         a5OY0vVP+hB8IK/9ZLoZoPCZeFgor9Fpw8SbYqukDHNG+a+v3PjEH2zucesdxbiUyeCl
         QWl2AdOAGcwc2pYSZBiP6PheWmZvEA9RkC3HSA4G9/Kks2Pk+VeMPCSCd/qOJe+o1UNl
         sjZNH9oSJ+AttWaLgrU7hMwFO0z3e9Jkry5RHMtsMPB0gWlBmo9zV+El4PebQMPM91HC
         n2iCMXKHR2RV8x7GOghepagQjocSxPUk/csP2yQC/u9FzuRbcxs1Jh8u4909s0iX/P/q
         GMUg==
X-Gm-Message-State: AOJu0Yz6CBfGV8l8sgigOhnIgzo8IRI1RfssbJjygnD5YfIk+M8YI4N8
	2DXVO9pjb596ei1AVdKC5eX3G8DIOdmotTO8NkRSQm8Bh4REwNm9/Za5
X-Gm-Gg: Acq92OE3Yt0CXtzNEry+cCuR/8TC6KtD6CYmpPUSIehxzbXoMsS3XWYoK53R6URmaBU
	tcLib/ARXCQRrLm/O+GPpq/+02WS+8Tdyu9/AhcursQgVJlS5lawCS+JxVxeIaKOs1O+chU/AhE
	1LejUBRQ/fdXMn6ftZc4R4SqGwg2B5YX31OsAjOYgTqCobjIREOWIgDe1Mg7XibuMxdFCYlvXAj
	c5lXtK/vjaQct6ac/Jep6/lGQ8VB80XLCHktlNpLE4n/l+s/yVkwHWXMVrc2cPxJd1TTdLdwrbr
	Gl3d2eoJoh7bm/iixNcP427DhAW1X638AXsjnDFV2S+1uLtNJqNJxJx0pvI7UFFE7/aGf29CCZo
	SIPBGhcSVyU7ZvGGhuVBcJshOX4CvFQa+IIi3k9+NhxjApCuiUkBF5pfMXvROXroRTD2ZGrEcbK
	4YbUyTCWFoBP/uc0eKhzRhdv0WBTjBuOBJh36q2mtNYK65/D0WCcEYj5Z9y0bj8VEgOtRqc0LVj
	4oYWiElHkaWuJ8XmQw+SHTDi+kHBC3HMnKuZ7g=
X-Received: by 2002:a05:6402:5d0:b0:67b:cd1f:9cc1 with SMTP id 4fb4d7f45d1cf-693784eab8cmr881007a12.6.1781255493455;
        Fri, 12 Jun 2026 02:11:33 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937938a3dbsm425280a12.16.2026.06.12.02.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:11:32 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 12 Jun 2026 10:11:25 +0100
To: Wadim Mueller <wafgo01@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Maxwell Doose <m32285159@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Subject: Re: [PATCH v4 3/4] iio: core: add IIO_VAL_DECIMAL64_FEMTO format type
Message-ID: <5zznk6hw5snapkpyftxqmmhqd4ih6y7it7v7yrnhgjbc5jk2ok@7bwn4xst5iwz>
References: <20260611132700.671322-1-wafgo01@gmail.com>
 <20260611132700.671322-4-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611132700.671322-4-wafgo01@gmail.com>

On 11/06/26 15:26, Wadim Mueller wrote:
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
> ---

Reviewed-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

>  drivers/iio/industrialio-core.c | 2 ++
>  include/linux/iio/types.h       | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 571b8ba4e..685661cd8 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -713,6 +713,7 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
>  	case IIO_VAL_DECIMAL64_MICRO:
>  	case IIO_VAL_DECIMAL64_NANO:
>  	case IIO_VAL_DECIMAL64_PICO:
> +	case IIO_VAL_DECIMAL64_FEMTO:
>  	{
>  		int scale = type - IIO_VAL_DECIMAL64_BASE;
>  		s64 frac;
> @@ -1030,6 +1031,7 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  		case IIO_VAL_DECIMAL64_MICRO:
>  		case IIO_VAL_DECIMAL64_NANO:
>  		case IIO_VAL_DECIMAL64_PICO:
> +		case IIO_VAL_DECIMAL64_FEMTO:
>  			dec_scale = type - IIO_VAL_DECIMAL64_BASE;
>  			fallthrough;
>  		case IIO_VAL_INT_64:
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 3b8a2d82f..1f2f03d5d 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -41,6 +41,7 @@ enum iio_event_info {
>  #define IIO_VAL_DECIMAL64_MICRO		(IIO_VAL_DECIMAL64_BASE + 6)
>  #define IIO_VAL_DECIMAL64_NANO		(IIO_VAL_DECIMAL64_BASE + 9)
>  #define IIO_VAL_DECIMAL64_PICO		(IIO_VAL_DECIMAL64_BASE + 12)
> +#define IIO_VAL_DECIMAL64_FEMTO		(IIO_VAL_DECIMAL64_BASE + 15)
>  
>  static inline s64 iio_val_s64_compose(s32 val0, s32 val1)
>  {
> -- 
> 2.52.0
> 
