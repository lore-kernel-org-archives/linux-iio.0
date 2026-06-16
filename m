Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F343385B9
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618655; cv=none; b=ZzofBojsWP5EERkcteWpWeBI1fuepStrKzcWeBNtbPOtmRYzpgIgKDTrS+UttX6xwTOWzBx274AL3EN4O8rRxFlMTAJhGuQ+RpET4fVRtwjF/ju8ayYHhWYG5p5F1wx+U0UwN5IgjpKM72FyE9L4SkaouWSe1pfBZKJ7LbKRrT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618655; c=relaxed/simple;
	bh=aHRpwy+EAF3xTCyfACBtdq+MbNPIl2cnmy723dQYE8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehy4li26iCu/qmChnVxLnYE1nDyBXLtdF3fQzJ6eTrpyD5dC6XkS+mct+wRE+Vi42R3Fm0gAerADKD5lQzFk6petJNiJEBsScVlIKhHZgP2Xm2U/04YIHzkcy4fylmUdXhCzKJNOBPxcW2wc2NOSLwWWuHDhbl0Elt/Uz31tMn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Y3LzmORL; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Y3LzmORL"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4866834f8deso1762965b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 07:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781618652; x=1782223452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xr4xaFxz+eK1eveJR03WaFSuuQiuLngSW1aqKxuBcYE=;
        b=Y3LzmORLSb2wv3e5zgwWNlSKlTzDwai9o1A2Z0PdrVBcfMpcL5VkFuTcarULEvkIZr
         OFvveS1H95g7EWs5IZ+ICojuBt0QP09T70I2axyY28i+48K2kWibu2RskKtcAWodLYwK
         pdSkT3a8NkxtsYicavEpteOWmqNa7LwCphl2edYce/SPQLAIEZBqDP8PzvQmavz6k7RT
         clcL65p0E9+8gF77x0mg5ew360B8fnqWHYS2iURr6rxS4hRAUkWIypy61Y51dEKtqf3+
         S2kWV5wE8UaJ/+1S5QBbS8RZzDm/3yTvky6GchgwgrYH5DB9ruHm+3EGozh7jXVILF4C
         dFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781618652; x=1782223452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xr4xaFxz+eK1eveJR03WaFSuuQiuLngSW1aqKxuBcYE=;
        b=KR7AU1jO78i5G7FrdfGRbhYMKQL1lJyYBj9/Pqs7qeTw+DmXseqEg4w+ImvvwWidYi
         bknr4zzkfC3te9BFDeiKLuIFszQm49DId100erZTA9U1E6+jEazV8sQ82RDguUXw4Pgc
         zO2cMImjNgF7nQ4ta1DLxeAr0hVVcQq/fgwoNxZhFgXhLVEu5pfSJCMdI6l/koBPUk2u
         jtjbiWuD2Ch+yzWN7SZcI42eTdgzhW3DHSUWPpdHLtQZNOtIG0rV6P959KQvGFPbOZUI
         /qJxT/Z8lYA65EYIq3u4cDzTNmpeGAk5vjGgXreuf6uUYT6yP2WuUVFvQ6oUJz3FnXrI
         F1Rg==
X-Forwarded-Encrypted: i=1; AFNElJ+gSPhpZaCrR1I0oZHDlSCyuTnH5XmHcwZXXoyfVC4WAJZUUf4o1H/TJSLcicqtDrPtpivezCHAqIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0rFczbusN+07qIljF+G4+ldXie7XgYQ04sUiuFlFkPR5KTFY8
	KfDo3D6Fhpb1EQheaRwNFIBgj0tz9nfBE4umWmP0eObL9+dSOsPoxpV9Qnvu6CSm904=
X-Gm-Gg: Acq92OFxd3nBPNNeB+SA6mxRU6PRhoigTYz3GG0u36kB5laTfsa41gT/7D1uMaZ86eb
	eo2agABtE7nrjNSHZt3emBC9buuj0BD7PUBqPN831WKT+6fmQtRIkG+VlyG3JiUkqKILtH2pSgW
	m+rlXVldYyD726dY6bCcWMHc6EM+c5OOUfXsCKygOIfUvFZoijqCI8Tlp3x5aQkdeCtTGlCT74l
	iLyhFbS16yrgrpnOjfKMBiqxq3DoW1jxVrdpc4KMMmpbmLCsP5tcnT0eF1M69DPm7pFn99XK4U0
	4qokHZ+h/2RR5hhnE3/6kbyjAxZ3THIwX38t2/N8oKAJBs9sgxWHG63qkvJ6Lskv+0aXc1c4FSx
	n8HKqBbb22ESdlgVzL9/BZnv4dBjghWwdiIREWDkt2sjXNPKeYGsfBkG0WO4JiKfAA7R+xUCwNa
	Lb3Fm+kD2pHsKJGEffVnyt2kxtdiXtXSXsEfO7gPK9s3HjYNutEEQZVpd8QBf5Tmzk7PO0St3HN
	Hzzwdvg2D0N
X-Received: by 2002:a05:6808:30a6:b0:486:89d8:6d57 with SMTP id 5614622812f47-4872f353fc2mr12652737b6e.8.1781618616673;
        Tue, 16 Jun 2026 07:03:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:16b0:5133:47b1:a939? ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875dfb4574sm4543917b6e.16.2026.06.16.07.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 07:03:35 -0700 (PDT)
Message-ID: <f3165ebd-c359-49dc-a46a-0edacedf52d7@baylibre.com>
Date: Tue, 16 Jun 2026 09:03:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ti-adc*: use dev_err_probe for probe time
 errors
To: Prashant Rahul <prashantrahul23@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Shuah Khan <shuahkhan@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Petr Mladek <pmladek@suse.com>,
 Oleg Nesterov <oleg@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, John Ogness <john.ogness@linutronix.de>,
 Dixit Parmar <dixitparmar19@gmail.com>, linux-kernel@vger.kernel.org
References: <20260616130612.73122-1-prashantrahul23@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260616130612.73122-1-prashantrahul23@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 8:05 AM, Prashant Rahul wrote:
> This simplifies error handling and ensures consistent error reporting.
> Also add missing error messages in a few probe paths where failures were
> previously returned without any diagnostics.
> 
> Signed-off-by: Prashant Rahul <prashantrahul23@gmail.com>
> ---
>  drivers/iio/adc/ti-adc081c.c    | 10 ++++------
>  drivers/iio/adc/ti-adc0832.c    |  6 +++---
>  drivers/iio/adc/ti-adc084s021.c |  3 +--
>  drivers/iio/adc/ti-adc108s102.c |  2 +-
>  drivers/iio/adc/ti-adc128s052.c |  2 +-
>  drivers/iio/adc/ti-adc161s626.c |  6 +++---
>  6 files changed, 13 insertions(+), 16 deletions(-)

Please make one patch per file.

> 
> diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> index 33f82bdfeb94..f6ce23975b80 100644
> --- a/drivers/iio/adc/ti-adc081c.c
> +++ b/drivers/iio/adc/ti-adc081c.c
> @@ -174,26 +174,24 @@ static int adc081c_probe(struct i2c_client *client)
> 
>  	err = regulator_enable(adc->ref);
>  	if (err < 0)
> -		return err;
> +		return dev_err_probe(&client->dev, err, "failed to enable regulator\n");
> 
>  	err = devm_add_action_or_reset(&client->dev, adc081c_reg_disable,
>  				       adc->ref);
>  	if (err)
> -		return err;
> +		return dev_err_probe(&client->dev, err, "failed to register cleanup action\n");

Please don't add new error messages. If there is a really good
reason to, please do that in a separate patch with a justification
as to why it is needed.

In this particular case, the only error is -ENOMEM, which we never
have an error message for.

Above, for regulator_enable(), an error is already printed in many cases
when it fails, so needing to add an additional error message is questionable.

The same comments apply to the rest of the changes as well. Unless you actually
hit one of these errors and found it difficult to troubleshoot without an
additional message, then it probably isn't an improvement.

