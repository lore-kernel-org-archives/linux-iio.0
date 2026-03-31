Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D2B371040
	for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955043; cv=none; b=Uh2J4U+srEhiJ4atC2tR+w3Tst1o6xKoGm2Gxd/JVhrryN3CwwPRKC+1Nl+LtnMoXnBssOz3sNKz/uN6Kr+mc4Xyvaq07CV9r+xgJIluDwmlmt0HbUV0D0fN/hQtufDD2yghPy8OEcKmJK7ZfPKKtQPdrziEUL1MBQUDvK0gbDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955043; c=relaxed/simple;
	bh=o6J6JFFbLSv5bzDuGKHxPeFhIoN+onbpICBZDXTsU0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LanVdz1bLLqgcZBJJi8yP69ZzsZn8aLu29CeClwuWTpvlWmzsw+hJu0FXZU/U7IJT19hc+YQr3hU2gkK6iHc1zKoRKSyC/6PpM3LOHK04ltkfvbQ2GWEziPeWaA0QeGmC/TetORslkAIPafpe4bW9pe/yuMFsvBw4bEnYh41wIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2n3dubN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2n3dubN"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so50666455e9.1
        for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 04:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774955041; x=1775559841; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lMu59Mf1OIiQSxY9jKt8XokJMKLdFw3mxtyDk4rmb6w=;
        b=R2n3dubNoJEIleUG63I+d3I/lMwblLxVzU5wUX5xPhZT5gXXzvmIC0OKlwnlVxKcR+
         r4lW55jvWe4NBqu68JvcZm0JHUpx3rU5Sy4VbjaVXo+qJD+QI+0QtRokVaeYgS4gNbGv
         yMBED/R1sbZEKq5w4NFmk766+B+shZHCanZGDHX7Rp3IpdRVy1zPBu8C4jj9eU0OP246
         mdf3YFThIDNrBZhvy0Stn0xjJ2YMiBdpeYOqvqUdQD5sk7l45ju8zQEZtQP8XJODsqOW
         ZQhB7mTovRf7thyz/tmj69DhJ6RNTgnKdu9RXoyKyma7x+cCLTeGpfgmpINNN4DLXFLB
         cBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774955041; x=1775559841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMu59Mf1OIiQSxY9jKt8XokJMKLdFw3mxtyDk4rmb6w=;
        b=HEdIVp/oCIAYUt/xEY64CRsG+ofxiit/gdiKIP0n84Np/RD6curgRtRCzwGMSka1iR
         r0dVHtoMymfX1+H59+z1UH8VZnS1OPJmA7D3Y4Mn3bxRmwHnXjIXbWIIZegLbmrt+nCM
         fOojA0SNLTId9TcjREF1G5e8kP+egLG1ybRUbmNG5JaTFppJSRp6coW6xr/EwhD+Wh3k
         FR9DBq63r626LENvmhzsVUBr5PFotYDFG1L/xTrWOyBfv4L55ad1C0yVNqILdYCI2COI
         LaEiq/ErNyyOf3t9bJrkLSFCDH3rdHCnPNh6f/W4IoX+YTTUsEiHIngqfK5W3bMYURIH
         ZMPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhvkVZBAYg6nDEv+PDxFTr+wkQ6/HANMIm8UTEboJiBDHxFxlizX9roSblnRiXdt8RNmXFDUhhdWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQk33gwzPego3FCI5ZXO4N9E0OBITBwF2XDGfRInfdKkGUYugK
	XhWujZw0gWm1v3jXVlEm+v0N6Vy/DZ3HDp2t13IG5ExLQUf/3JMc2odq
X-Gm-Gg: ATEYQzwChONYqaVxDgU1C2oHLUVRfF5VDyIDE2AJVT52x6HbLTZH6kmp3YzWuP9heDw
	Sik1/NYh6JUu7wfg2PFta95sEMZlUxZOkmQXeNCcj0U2mY9DnkVZAe6gmPRjYqJfhEKGxAAu3qx
	dRoS2oxl1yCW/FprionrZqhDJ4bCa6bVieSpRk0NPMa+vRua2zwriZlSsNZr7y2btA0usnzWfSk
	P+EdGkInvT9nffU8T5lq/oS2wmAirvlIk9NObk5zjf6dxGynJ4Vifp+bpu/kw+gAHSYW4wZzG/m
	/bIjHSOEijyPWjwnTEme3VzMb12l6gwRd/Q/A7MCEeeyLo83D2geISmqnOIfQDigQlesPOl6zgm
	xt6yqKbQ+vIJvx4rNxK/DY4Kv0GyqHCR12SHp6/yW+YUXC/YcgHET6Yl4EQHFXorroEK70CcYo5
	z/LnuL3Ig4HpK3x0nCLe5D7bg=
X-Received: by 2002:a05:600c:c493:b0:485:3f41:e113 with SMTP id 5b1f17b1804b1-48727ef5530mr259166095e9.1.1774955040638;
        Tue, 31 Mar 2026 04:04:00 -0700 (PDT)
Received: from nsa ([185.128.9.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c883ef4sm12586105e9.14.2026.03.31.04.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 04:04:00 -0700 (PDT)
Date: Tue, 31 Mar 2026 12:04:45 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Greg Kroah-Hartman <gregkh@suse.de>, Barry Song <Barry.Song@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: adis16260: fix division by zero in write_raw
Message-ID: <acuqM42TLd4edTWZ@nsa>
References: <20260331101300.15853-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260331101300.15853-1-antoniu.miclaus@analog.com>

On Tue, Mar 31, 2026 at 01:13:00PM +0300, Antoniu Miclaus wrote:
> Add a validation check for the sampling frequency value before using it
> as a divisor. A user writing zero to the sampling_frequency sysfs
> attribute triggers a division by zero in the kernel.
> 
> Fixes: 089a41985c6c ("staging: iio: adis16260 digital gyro driver")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/gyro/adis16260.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
> index 586e6cfa14a9..91b9c5f18ec4 100644
> --- a/drivers/iio/gyro/adis16260.c
> +++ b/drivers/iio/gyro/adis16260.c
> @@ -287,6 +287,9 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
>  		addr = adis16260_addresses[chan->scan_index][1];
>  		return adis_write_reg_16(adis, addr, val);
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val <= 0)
> +			return -EINVAL;
> +
>  		if (spi_get_device_id(adis->spi)->driver_data)
>  			t = 256 / val;
>  		else
> -- 
> 2.43.0
> 
