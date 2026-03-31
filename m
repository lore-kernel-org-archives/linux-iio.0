Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CFF40FDB2
	for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970800; cv=none; b=H75f5oQVHvtnNZfsk27hF+SOA7PfGJwjr77gIslHAnR7N2VrsoxRUcGDtT8ftmlUbHsdE3btq3+nSOMGusnFQcTBCRCxna3WhNv6/uYU1rV+0MarNa3+zKIJ5JWA++ODlQ8kA0aaC0rYLOgXtKtQFxGxFoFsmCea0qX9nsieIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970800; c=relaxed/simple;
	bh=2lcMVU8JNhR0Rzve2wLo96oqxT19Z5alWu7tDoe1xKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kre3BAc05S8y6znaP+2EHGiCeex7WqFCRtJPM10pxjh0Q29Q6OWSwrNpmr25tEpb8UAaOSbUUAFy6nRPJAI8AAsegccgqPSUcTdWyyLi9VlvhExyCVkhMr+4k/KwOeb4mdm8kUSTFTAB7QXz149rY+sTFc2qLn4qbpgLwxN2ntY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUdHl5Oi; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUdHl5Oi"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cfd96354aso1513798f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774970797; x=1775575597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO5FPDdY/LQ+4ZadBlm+77MhRqH3b4TUifZXGA4guso=;
        b=FUdHl5OikCI/hacFGfex0H0mwCbAFtiTz04Y+tvRDzL+m92M7NQ35fH+kn1aZ65yXR
         e3pe6AQcxGomklpYfg7E7qfppqypETXtmAQOs6G9eIIIDCZOrPI9aH/r1cUPDmTDpOjQ
         uYoQmWtXb5dDISY/ygGV1hnx+taAG9qJyh4YY1T88HF6sTU7Vmw1U2Ya1syBTizDqBAW
         l4So11v4GQIkdLjDNxQ2aXP01AdkhOrFOM668F8qv4nD0NbTOJmSutHeVFTEKuJOo/hZ
         4FeG/+xFGLo/yn1BvVME8M5RlxONDutmHho0MVO0v90s8j117qy/g06Q6BeX0NxpeQqN
         0ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970797; x=1775575597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MO5FPDdY/LQ+4ZadBlm+77MhRqH3b4TUifZXGA4guso=;
        b=sKy7NrpAI8dvPu8SWE6RcXseMmDQRMz7wWzd3MEnXpRa+A3DFUL/t7PPw2Js87a+Et
         R+aSjH+YE157Kf/ZvvUXyofbHbI5n8HpnoAfpL1N0rDFnx+7OrwKkAlzOesbqFGkkN8v
         kXmbSECj/UAZbyfzD3n5JoZiC6pQ40YN6ei+PvXF/v4/nXrwehEo/kcYi2sSG2mV/PYi
         RpiC5Yx7502krzVwDi5E9IGsLLFYqQRGeix84AMBMvuiJBX5igMQL1L/TKAZYLMxPNPe
         nckXsYq4OnAcxrqI3K03SBWCMPVYkhnNkG12QyI7nQcfaIfbj1tNQtQbTiifAGVr3Txh
         v8kg==
X-Forwarded-Encrypted: i=1; AJvYcCXdPREfVm7c8gae8FVyMVoQbaXSpOWE3pW0PWZ0z1jlWu+Z49KcmNGgnDpHU91CuuMXRMv0/dPJXn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1buGrcWq51kcy8QYGvgcYmlqfPan2zIzGaRIXjbjAMAdffSaK
	+IPKt2rjFF/rvOf/HBtEHp+uU3/Lmvpu7T9xAeJUetSuO/rWpDaezVxc
X-Gm-Gg: ATEYQzzKJ9RTHBCc3uNMI9tEzwZuuURogJrFndB4StBGZYYR2zDl6erDOXaqU7d3l8q
	YS34QgTua1ufcqDDmUKIctGfQArcSWNIcc+es/DdagiPn2aQU2phd6ZWmfelDdHhRGvXYZ8qSnL
	LaFLviGqTiHKfQ1iQ2FB/rLzHdXjn5QEIvM0eO+ZdY/G6qtPbyyRjRbmNNgTrSDl+r0mpfNyZzg
	Jbm0w70nYrBG7RK2zCXWiPyDJnRNWyBP8SiG5yXp/5R0L7eAADKX/YXgVQg/yrmDa4o3jfNlIxk
	XaFWgAbhzZnkH6xs+Cua4TweRigg6DF9jhsp+cAf0XfifCTN9bymz/le1czD/hp3M0VXEqcAt1R
	1+cGKlG4Il6nx0CiNeoyzTijRqq82g0E3osi477sBSBTTjDt6xpxRDz5+14qVFQqeguNvMXo4Id
	o8DCST1JKC7QMqsE2pzGi3TP+85p+i1dll9c27G50Umx31+So0bP9O53b/4ZTF
X-Received: by 2002:a05:6000:1a8c:b0:43b:43ae:8c2e with SMTP id ffacd0b85a97d-43d1512fc2amr5749f8f.51.1774970796917;
        Tue, 31 Mar 2026 08:26:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e265fsm29303248f8f.1.2026.03.31.08.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:26:36 -0700 (PDT)
Date: Tue, 31 Mar 2026 16:26:35 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Hans de Goede <hansg@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: inkern: Avoid risky abs() usage in
 iio_multiply_value()
Message-ID: <20260331162635.2d8c7f70@pumpkin>
In-Reply-To: <acuT8oTnaYujC0k6@ashevche-desk.local>
References: <20260331-iio-multiply-abs-usage-v1-1-2ae8063e80e4@bootlin.com>
	<acuT8oTnaYujC0k6@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 12:29:22 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Mar 31, 2026 at 10:49:59AM +0200, Romain Gantois wrote:
> > iio_multiply_value() passes integers val and val2 directly to abs(). This
> > is problematic because if a signed argument to abs is the lowest value for
> > its type, then the result is undefined due to overflow.
> > 
> > Cast val and val2 to s64 before passing them to abs() to avoid this issue.  
> 
> ...
> 
> > Fixes: 0f85406bf830 ("iio: consumers: Fix handling of negative channel scale in iio_convert_raw_to_processed()")  
> 
> Doesn't fix any know issue for now.
> 
> ...
> 
> > -		*result = multiplier * abs(val);
> > -		*result += div_s64(multiplier * abs(val2), denominator);
> > +		*result = multiplier * abs((s64)val);
> > +		*result += div_s64(multiplier * abs((s64)val2), denominator);  
> 
> Right, but here we get val and val2 from either static values from the driver
> (when it is SCALE channel), or when channel has PROCESSED support.
> In the latter one it might theoretically be possible to go till the INT_MIN,
> but practically I don't know how, except for the broken driver code in the
> first place. With that being said, I think it's better to validate somewhere
> the multipliers (when it's SCALE or PROCESSED channel). I also noted that
> for the _PROCESSED some drivers keep a garbage in val2. That probably needs
> to be addressed as well (exempli gratia: bmi270_read_raw() does that).
> 

I've just looked at the 'work of art' that is abs().
What is wrong with:
#define abs(x) (sizeof(x) == sizeof(long long) ? __abs(long long, x) : \
		__abs(int, x))
#define __abs(type, x) \
	({ type __abs_x = (x); __abs_x < 0 ? -__abs_x : __abs_x;})

It is just as broken for u128.
It will use the correct signedness for char (but it is unsigned now).
It doesn't cast back to char, but that is entirely pointless unless code
looks at the type of the expression, the return value itself is always
promoted to int before being used.

Actually replace the -__abs_x (UB for INT_MIN) with the safe:
	(unsigned type)-(__abs_x + 1) + 1
and the return type will be unsigned with a correct value for -INT_MIN.
(Oh and the compiler sees through the mess.)

	David

