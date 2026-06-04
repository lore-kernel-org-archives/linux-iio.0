Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87675394786
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567778; cv=none; b=T+3rVaiRvxwqaZVFTrmEm0K7I0ODqQbitw3t/B8FyuJ8gBKXtXA5Jax+I99C0+uKioIS3/HnGNniuvbo+p+QTCGasuPzQ+JvgjJn/Ns0J7b5O+cCr6qRCviEzM66p7AlZBUeJtzG3uXC42/r8CYHrlqPBoqbl6s8oKrQzxNEkS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567778; c=relaxed/simple;
	bh=B2CnKvGteEd3Ogga1Fg7bneFO20MG2+ueysH7w2tBBY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdZ1zZ4/yvy7hX8RIi3Hysp/3wbLjFbrdxE6oTc14RIozsU9TRIHOjmefcqYZP+gyCFF+lkgtyhuXk8N6x3VDEFyT1YlCmPhSteqKOFxDUzdRNw9cSedenrAWUyICQppJzqGhHWtJM4ipbvoQOFGh5UI+JfF4cCAT/woI6cdC8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JY4tSe/2; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JY4tSe/2"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6870ad8072eso457233a12.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 03:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780567776; x=1781172576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3GPJ5N+yj+5C24kf/hzt0wYoGPWLbKx8pufh7NjXz1U=;
        b=JY4tSe/246+USi8aySI278Od4y/o+RB8O057qGMWXJZKZiq7d+4sA7niTg7Fcv2FrQ
         hPdsB677cImBHagtDXv+0xLl/x7t1VCMRJOTEB9MVe8pIiE533+VF9yzjJ/9Zelmp1bT
         zVvUELeDW2aHV7/OrfHHqZ5qjS7fRdpfmvDo9wYUuRjzYITAV4lVZ/s/05S5R8LcqVZr
         usA0gR+BqYWcSUvIxksSPbeqIagDL03hHr/UjZyjV2PuFeclfv12Wfz4G47hxd/Vacv8
         dYaq+37yP7pPK/8bAsZIDsQYSKWk6B2bVsuPEYB/Fe6eFkhKCmMZOkMFe+R3T/M6Jjce
         umNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780567776; x=1781172576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GPJ5N+yj+5C24kf/hzt0wYoGPWLbKx8pufh7NjXz1U=;
        b=L0PtOoCeEGQWmljE3A5gY/FwfVVmNVIUH73Tbtus2yG1Cg1fkC04FqAEOb+D/WjxFD
         KlInA81j+6IYX9jNMvgdpfaatRAWmT8SICmxSe9zvXksBLSLCrvBRyOrccuGtyqax8uM
         DrcsCTwRqGsgfdyYUFoxVw2F04aAMfCEngazQtsi4l+7SGLQ8U/e33dGBie0LisFn0gu
         uoy/9FjMngPOe7HXCoP3u+6+rf4f2StrwTGszI1Q718UxlVjOzveRA+ARInwmPjBWiIC
         JGs1CdJWWH7gx/TeKPOKOBON5X7lH2edRv/tBhnJhAV8Asf7BhM7+mr6664Aq4oDqIUz
         2V9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8WvVXpvPdTfmoVw522C2f+hBjG/QqXEzBFSuhrx7X57xa5fLjn6wZ2G1n6APTtFBLl+nGrCfLBhkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4TQdp2rH2Q8VKrDLkz2CrYv5YpgmT6XRCA5WLRQzIEe8m0cfH
	glHNbsAt81pW0VI0sjzhKEQSLDV+SC6mXR6kySwMWLHm+BPABMaUdzAi
X-Gm-Gg: Acq92OEsIbmsJjedShTMdkrVhQgA+WgdIRF63zJhjBAdMx6Co880m4yhj+M2iTlRsGc
	kCuJlFO+bL75HBmiguDwxosxwpGeJYZULmIePSs7JKPWG3g0l4D4ZHdGw0MIl/wk8bf6jTuTi/U
	NrAQuP5S7aeH84YYpwKy3pfX6lBPkgClHsMK8LdoFpsFzTdfFayhoxvVSTEeaOJZPCcuUyyWDRr
	K+G7IBR6sz42uKjhXwCXicElk8c+gJvrpFWaR3U1RljcDBMjt87LwwNMm1rLeNxNT5U63R2pTl9
	X685eYnhRS7pYHOOoDb5qWwlIfoGS9+dhUjdbs9tTtzZl5TPq5+b5pPXLYrLFrt+dwgT3nA2loH
	gEQ5U0HGOtwFz42pGLcucdkrlfxdRt2cIfu+a5Ch5IcoxyUFjRo5RHm5NSX0sJ3LU+2ltuh1Ju0
	sqTHceLEP/1TQujjQbg1tOsAheCYGZy1pVM2LJWDSXFUEjiH2jlHjUQNDtepX9hOlUAs2kmVKHe
	VE4/rJJzxXOTHtUcdzVuS29frjkwJOvP3Jsv27rx0sRo43cjA==
X-Received: by 2002:a05:6402:5d85:b0:67c:34bb:1bd1 with SMTP id 4fb4d7f45d1cf-68f0edd16c2mr1002189a12.1.1780567775983;
        Thu, 04 Jun 2026 03:09:35 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65851786sm2239274a12.17.2026.06.04.03.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:09:34 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Thu, 4 Jun 2026 11:09:33 +0100
To: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v16 04/14] lib: kstrtox: add initial value to
 _parse_integer_limit()
Message-ID: <rvx36i2ydmwhbbkdgbvh26uqchyoptzuu7tleuyarqn2skzkxz@owzwp62mzkdo>
References: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
 <20260604-adf41513-iio-driver-v16-4-1a7d09143bc2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-adf41513-iio-driver-v16-4-1a7d09143bc2@analog.com>

On 26/06/04 10:58AM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add init parameter to _parse_integer_limit() that defines an initial
> value for the accumulated result when parsing an 64-bit integer. The
> new function prototype is adjusted so that the _parse_integer() macros
> stay consistent allowing for one more argument, which defaults to 0.

...

>  noinline
>  unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned long long *p,
> -				  size_t max_chars)
> +				  size_t max_chars, unsigned long long init)
>  {
>  	unsigned long long res;
>  	unsigned int rv;
>  
> -	res = 0;
> +	res = init;

This might generate conflict, as the code around have changed in linux-next.
It is an easy fix though.

>  	rv = 0;
>  	while (max_chars--) {
>  		unsigned int c = *s;

-- 
Kind regards,

Rodrigo Alencar
