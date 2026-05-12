Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171383812F1
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598673; cv=none; b=DQ3OYAGXy7lRsGcdXReY8/VcMEjoDfbYOzUalrFzRIfxr3giROIEXjHxcW0KjTRTA0nTBAaIg5Yxe9z4CuaEs3CoT00cKGTWGHWgMsSkE4UKP/BjA4dvBrdDVFFfzi3MVX2qZTuYSbVczZPiZ33iMJeZ88CsYcwaiAfyEHpdh+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598673; c=relaxed/simple;
	bh=M/OlBy2UYV0O2v6kUD7jaAhw2kmLfUEuTpihKtR1EGM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8EqeiEgI9jsQgrjbm4lsYkooEnKlpzTqWWPHGgJ1P5ucsfyCQXdgrM5oGiwqTLXgU/fQkcqRhESjFfBCNh++llfWjYz2ubiuYmn2RVvxX/kCcQCqaZdthBJqWmtZpChaE5apr1g9gpIrXmzdvUgPTpegAmt6Gwycj1hjfijicU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5njw/Nn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5njw/Nn"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so96010755e9.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778598670; x=1779203470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UrqeEwK16SbblcIoUInFb1Z7JZt5ZrtLnMUbnKHgFh8=;
        b=Q5njw/NnlA5G/sXqqLMuTYRrslCdTtVBrO1pg+SAiC4c+f6rM0EuNfWBxEY8bp7J3k
         3dPR0A1sF6VfMw0i5XXydbo5F7gGB9S47oxkN092GOFPa1RJqzXaPU2VjMSnhDN5wMNM
         Y9cdDWBuBRCcl+zQlhV9v3zYGoKMhHsmcB6REfANtX1iRaozcQkFbuYcJ6WgorA1FPnL
         pE6tSfC/DcUyLYsW1m+RYDTASIYi/JRU+Jzwh5TBImQiiHKxUr+qyeFTAUvosAlj3/hk
         qUTgvRQj4nDIdIBqIde8s7MOzL6KKtbYSQOPv1uKZ8YuFja6SY+qBziDNwwEXilmw/sm
         5Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778598670; x=1779203470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrqeEwK16SbblcIoUInFb1Z7JZt5ZrtLnMUbnKHgFh8=;
        b=GLc8v7rx7LJ4yKBGxoqUlBaXROdHdc4Zap7oww50ZHlnRzDCbYN+C+LzdN8r9a1o8Q
         m4yPkKOrOCqLeMQUQ6opxYDv4mgyzBaDTwi036j5iQQ9Xzq+RkyRB7AeIDAedYSWxnqU
         4iSdkay15+N7sHyLcb17LDtypGi5mMgGUfo8eppXo1xUjzvidyQA/wY1dHksuhUs5B3l
         uR257Ik03gVx1/lG3BwQj/T9N1KyCJxovCF/W8yvtvDOA6KiPBDUr05muS1NIflWNL1Q
         EP9rPfh8i6AyhKcXrNlKVIhTynM+nhXuLuzfoLU/QAHi4SgxUthAVJnyuH1BIdF/TYpP
         i/TQ==
X-Forwarded-Encrypted: i=1; AFNElJ9FEJvaBfGgs1QDS2DjrWVnLCYhTdQnIYcxF0AEsBaOgsoV4Tsjcm3AvL2o2/lFhX8ey1NKTOAeoOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGDnK7cXVtVRo/vr9CSmBFYPk4WY5zoGnunt6L1wgemEl5hmbH
	LUiFDmdY20FNsKsDQ8ZoMO7tIC+GaVJ+QWvdGGr+kuQdhMM7u/mqd5Sy
X-Gm-Gg: Acq92OExAyRvzFqcsd4jgFSfCximhGHPfDrkQrauvRNPGlUnl8lv+j8fYJg+Y4XODsd
	RQfSmlWTlFYmlOG7xqipPUMuuxV9hX0XG9gNOBxgIAmSESFti4kNU3Q3C8fJPCUFDev7V9/QfvH
	Rnaeg+ICb+JChCUhhafKW/53CrKA4HCGkeKWWfrpS4kUX7XEvNA8hnxVm0R0FAqG+P6lEwdeaZb
	WlthEaZdGfz8pj4qkSfu1USJLA5MffumdMMBj4OlhQ4HO/O8MI0ZtYanqelGhXQdF6lWiwJ+mUA
	iTkqNN0awkXkRUT72xaUuYUNpzNdZedfJbiphqlA8+J4VIfceMYx/7UWCHTLa6vv9KuY2Eo3Rxc
	v6xZZSuT4XdRi8ars1bIMz3iVV1wa44FS7zCDCKLylBQy5b5+stB6BckzZhleUO4lWz82IX6ok5
	6flkZYNJMpQxtbZcBLZJdrh9+c1Kln1/kmv8mdrDTjBUDITh9uZBTPug7e5JWqRZPdROlx6Z/aB
	QEaenPNzyW+RD2eJS6KMaqFG5JfF35COPySA/LSrLML7Ly49g==
X-Received: by 2002:a05:600c:4ba6:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-48e51f4bab4mr273241975e9.25.1778598670135;
        Tue, 12 May 2026 08:11:10 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d19974sm3567075e9.2.2026.05.12.08.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:11:09 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 12 May 2026 16:11:07 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>, rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v12 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <ur6brs3yjzyb4mtelabmcglxjltddqvjxtgl3lkdkmbjlkmnsq@bwd6rz7gided>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-2-34af2ed2779f@analog.com>
 <20260512123953.40d80bc9@jic23-huawei>
 <agMnWzMjW1LwCSyT@ashevche-desk.local>
 <sj6cpjhakyfvv6rgox6cnhl2u2tgaecugcok6fw2l7zgku5wtc@aqx3ul72vgca>
 <agMvlS3-0wvGmBwh@ashevche-desk.local>
 <dxjg2sdyxb7ieb4abmeyyye7qok6cczrxabpsjyjhcbehwoec3@sbbqoo4wmzre>
 <agM8pWrM6j_XksvN@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agM8pWrM6j_XksvN@ashevche-desk.local>

On 26/05/12 05:43PM, Andy Shevchenko wrote:
> On Tue, May 12, 2026 at 03:12:24PM +0100, Rodrigo Alencar wrote:
> > On 26/05/12 04:48PM, Andy Shevchenko wrote:
> > > On Tue, May 12, 2026 at 02:21:14PM +0100, Rodrigo Alencar wrote:
> > > > On 26/05/12 04:12PM, Andy Shevchenko wrote:
> > > > > On Tue, May 12, 2026 at 12:39:53PM +0100, Jonathan Cameron wrote:
> > > > > > On Sun, 10 May 2026 13:42:20 +0100
> > > > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > > > > 
> > > > > > > Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> > > > > > > point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> > > > > > > precision). After the decimal point, digits beyond the specified scale
> > > > > > > are ignored.
> > > > > > 
> > > > > > Whilst Rodrigo has already replied to say there will be another version
> > > > > > I'd like to request final feedback from those who were involved in the parser
> > > > > > discussions.  
> > > > > > 
> > > > > > They got very involved and I'm far from an expert in the right way to do
> > > > > > this stuff.  
> > > > > > 
> > > > > > I don't think David Laight was +CC so I've added that.
> > > > > > David, Andy - I think you two were most involved in that discussion:
> > > > > > Any objections to the end result? 
> > > > > 
> > > > > I already said a few times about the naming. I do not like the kstrto*()
> > > > > be semantically different on how they treat the input. Second point is
> > > > > to avoid code duplication, but this one is less of a concern since the
> > > > > new code is in the library close to the other potentially duplicate code
> > > > > piece and hence can be addressed later.
> > > > 
> > > > I suppose I reached into kstrtodec64() and kstrtoudec64() because it aligns
> > > > with your expectations for kstrto*() semantics, no? Those include:
> > > >  - overflow check;
> > > >  - extensive input validation;
> > > >  - optional '\n' in the end;
> > > >  - mandatory nul-termination.
> > > > 
> > > > am I missing anything?
> > > 
> > > When we add scale we basically make that not true. Moreover the code in this
> > > patch makes scale == number_of_characters which I think a bit fragile, however
> > > it's about the fractional part when the amount of digits is equal to scale.
> > 
> > That is not really the case. It is being set as a limit, so it does check for
> > truncation and zero-padding.
> 
> I do not see it happens in _parse_integer_limit(). It doesn't try to parse more
> characters than it's requested in max_chars. It doesn't check if there are more
> character nor their converted values.
> 
> > > To make this work as expected we need to add an additional call like
> > > kstrtoull() (and perhaps drop that \n and NUL-terminator checks) and see
> > > if that overflows or not. Since it's a fractional part it must have less
> > > than 20 (decimal) digits there, so we check the rv (or how many digits
> > > were parsed successfully) and compare to 20. If it's more, we got too many
> > > decimal digits.
> > 
> > For overflow it checks the KSTRTOX_OVERFLOW flag and leverages check_mul_overflow()
> > and check_add_overflow() when combining fractional and integer parts. The amount
> > of characters is not really important there. The scale cannot be bigger than 19 and
> > that makes sure that int_pow() does not overflow. The code uses _parse_integer_limit()
> > due to the nature of input and to avoid 64-bit division, kstrtoull() at any point
> > (parsing integer or fractional parts) does not make much sense.
> 
> Under 'like kstrotoull()' I meant something that repeats needed functionality.
> I believe it's parse_integer() (without limit).

I think we are going in circles here and we could look at the code instead:
- integer parsing with _parse_integer()
	- overflow check and validation of the return value
- fractional parsing with _parse_integer_limit()
	- overflow check and validation of the return value
	- extra scaling and truncation happening outside if needed.
- check for input termination
- combination of integer and fractional parts with check_mul_overflow() and check_add_overflow() 

> > > Maybe I'm missing these checks already performed?
> > > 
> > > > > Having the test cases is a big benefit, and that part I like the most.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Kind regards,

Rodrigo Alencar
