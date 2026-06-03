Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE3D40C5B0
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474429; cv=none; b=lRKExT9gUmTiKhnDrH5+xH7n1aL8+aFdHpKZa99S/oWCn592a8UK9vWXPWJjFkYEUf1vz8sDex4m4POPFYkoIM0QSFYQXpL5HB69b6WXRkwFHSAOV9Cbd3q7v4mi5BaaUkEu9AIrizwrwl2+sVsBIvl6X/q4ctD7q8Yg4BzakBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474429; c=relaxed/simple;
	bh=FJbjdDCgaz9ThG5AIOCKtVF9e5PDmn7FiKLUisj471c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMPQptmk34aFpmkPpFOtzCCQb8cBga0SyEFoLDKHCyNVDXA2xBZbsP3OM/tJf8LYiCFCmhnXv/aECSCthUniEp8mb3407usKe8YQ8Tko+M345htUntCFRI9yv8VE8aLQY9Fe9Sta2uN/9BXj4F2frZWnyTbPrlT87PcWqGQXQPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEdyFirA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEdyFirA"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bec449d0af2so427861266b.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 01:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780474424; x=1781079224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xwS//BfQZMZSUJ4QkYWaPU16T3KOhO8xHKdF5NSDqLA=;
        b=YEdyFirA1vPXjXkUIwrd9jrCUuqT2DS93le57nqSAvF0y0fWHgZJSf5MVjqAH866ry
         +i22r6bjgaQe+OI/ObTlA4+kQBlAIleBzeblRwy2bVsZFZWWsImY1ouj6NZmlC5h3dyR
         l3+WLEQhqKvNHgV89SaIWxX4rTXXiGEavH//Y1Yar8eFo0xeGzc0DePGTHe2YGz8m49f
         ODZlrKEOoROzjfuVRSme3vMXCjhNkDwaMaoaNUkzDUvmolV7rm9fGVmP51tipkVSoqO3
         dcQmOnwilXHFfPibq31S0F8lPzSr+lgUrIMkWt2wKelbLnfzEPZ/Gq2zWArKut03n+zO
         2dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780474424; x=1781079224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwS//BfQZMZSUJ4QkYWaPU16T3KOhO8xHKdF5NSDqLA=;
        b=V7PRig+sA0ab49tWD3Vy5cvk2AAtVxvhS3Bpo7i4xeZvbDfHAxhR8WUKMNnw0F8KxH
         gTYIx63/c8XD7QiW3mykmyCpx0ChniFmJvWzrnWMypp1JcPDm559hs5lMJxKU52H3IdJ
         X/wCZvzvIEW0zQvvUBoXfZsS+cylyrVzp0Qh9yjHtstInvQOVm2Cc95U/JF0EWGLkyLr
         Ag/fz91grVrlO+q/OP3jhrQyikg+tqPVgVrpZkH4lJXtkCHMMvcYJhKSTG+7beUzosM8
         jMVDy01kKqT8eq+tkWjjD+pgHZmgeANOOelOnAyTFu/GHQTumd2E3dNeroSEGseLde7f
         NdNg==
X-Forwarded-Encrypted: i=1; AFNElJ9ggDyelm+j+ZFGySQvvhOv6i5PHnYAt8b+ilxhEp4WUoBWdhDk+IvX5DAK2hxUcZLvqpdnJ40qK0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvralI2Wc3cR3nhP7rvn+6+P5Fd5rZ9/3IikCH+6xgWVp/bY/l
	JBiCrDaG1FObZNQt65ydcLcnvdgl1Jy21CxAhYORNriMtbx85E+QJFanZiMrk7u8
X-Gm-Gg: Acq92OHdkOhs0DS7ewCx1D00yL6YJCnbGG39KN/MKrSEi/+KGMTHtpeQ2Jq1bs9xBPA
	aSh6iQKv/8vJev24UqNY3sJGHARSVoQvWtaSIPMIvXtJdz+NmYbhJW3dDSBnRS7gUMwOymXiYOh
	JE746jdrAcNT+96Ehdb5ZdmrYPECYP7TnVGEKucVeK59cgHtMJPBDXoNz+pQKgeS3G0g0uQLIQy
	AK+wi//YmxXGE5I/E22wBHiUqJE10C0by12LBOs75R9JyOnKL+S2F6pcNPY5bkZKQBjyuBb+YxN
	KAopflA1HqnJN4q5PdqE6oi/UoFBctuMREwXpnKlUTF28xVvVjgIWXBHUg8I/feQJbT5ofgVsjA
	DqA4iptHWda7R2UI++NIpKOV4IiKQmKZC1JzvHF/zWC6JPeTMCWzSHIw4ogMUtzgLvG1nPWONJ7
	9ChE+ken+Lbb0MppGI4KBt+DPFRpsCM8VDc8eCpSDyn8QTlHKwKDbGgpyfrggasf6cqAkNaTq5V
	AOaT4/v8yKGKOV76lBfc+qwcj2hasKEWoxd4A5fQ/GCS3BHow==
X-Received: by 2002:a17:907:d40b:b0:bd4:7bed:512a with SMTP id a640c23a62f3a-bf0ae6ff2c1mr116707866b.30.1780474423976;
        Wed, 03 Jun 2026 01:13:43 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051d82a31sm109856166b.19.2026.06.03.01.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 01:13:43 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 3 Jun 2026 09:13:40 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v15 03/12] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <etbgk2eap5w2db36kqoze7qehp2jmydc5a7stfymqowsqukf45@g2w4zew2zhic>
References: <20260531-adf41513-iio-driver-v15-0-da09adf1c0dd@analog.com>
 <20260531-adf41513-iio-driver-v15-3-da09adf1c0dd@analog.com>
 <ah9EXNnutqk1FoV2@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah9EXNnutqk1FoV2@ashevche-desk.local>

On 26/06/03 12:00AM, Andy Shevchenko wrote:
> On Sun, May 31, 2026 at 09:30:46AM +0100, Rodrigo Alencar via B4 Relay wrote:
> > 
> > Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> > point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> > precision). After the decimal point, digits beyond the specified scale
> > are ignored.
> 
> ...
> 
> > +static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
> > +{
> > +	u64 _res = 0;
> > +	unsigned int rv_int, rv_frac;
> > +
> > +	rv_int = _parse_integer(s, 10, &_res);
> > +	if (rv_int & KSTRTOX_OVERFLOW)
> > +		return -ERANGE;
> > +	s += rv_int;
> > +
> > +	if (*s == '.')
> > +		s++; /* skip decimal point */
> > +
> > +	rv_frac = _parse_integer_limit_init(s, 10, _res, &_res, scale);
> > +	if (rv_frac & KSTRTOX_OVERFLOW)
> > +		return -ERANGE;
> > +	s += rv_frac;
> 
> > +	if (!rv_int && !rv_frac && !isdigit(*s))
> 
> Do we care about isdigit() here? Why?

The check here validates the presence of digits, and
this is to cover a corner case with scale = 0 and s = ".5",
which is considered a valid input and leads to rv_int = 0 and
rv_frac = 0, outputing res = 0
 
-- 
Kind regards,

Rodrigo Alencar
