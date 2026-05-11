Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B7043CEF7
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515277; cv=none; b=FKsraCURw8oIAVSD9adpKMB9BxYvwqK0fskb4iPqlFlQ6alexeEmeQGRRLSTIW0IUHDPBTDOfnnf6vEplOQeSQIUbfvNn9VML4I0xU6ikfZBPA172aV/VY1kZJ8ghz/oUVocNHZdqTOdM19qDstaV6KOa1LaFhy2+Yx4gKHawdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515277; c=relaxed/simple;
	bh=nl++y2pvb//UUvo8RmKvBN/IlF4N9wSAx9HwCsTdjHU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrbrvzE8JZJ2VMkxYlZ9T2CUhv916QvW1pPQoru4cK83HIMN/QkdUrnAw4vqfIaU+/06Xxbw6ge1QfTQgPbHjjLd1joOISFs2mbPbIN59Dd1YLLYlQWQuhk6pxDgY39BSXuTPlAxW4gVQx0KOTzDEQuGaT2dDzrx7qFd2y4hd7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPksM0KQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPksM0KQ"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bc66ad3742fso735981466b.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 09:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778515274; x=1779120074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dDajMNhsK8ctloggkRH1qn8pJypaS73T3qG8KCV509o=;
        b=EPksM0KQt1LbNCli2KGRcMuMkA457QfbDFvV/ouokqbTvVLlDeNC4BjfqamZe4gLIN
         4e1GRlwzM9d0fevf/fYhWuOuKPVph002ISnQrOiD9CVm7dY7dexk2yA7Enj49RHHMhxz
         dSF36mABiN9Ce76N4/Dhsc9V8K+O4+Gk8xcWnR15iyDFsM3/cr920kFh8lWPhoRSwTl4
         nsatV+VG3Mrvjy5q4Pzy7s9w+Uh/l49/Z47tkuXVNyqfNY7xqGgqoSbWF68+H/1EKEV1
         m5HuIJyOamWKBdYcOv2k+HMw9X1IeFOCgm7uCiluMVuQ75CJb47lDaQE7SPnT4axT3/z
         Dj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515274; x=1779120074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDajMNhsK8ctloggkRH1qn8pJypaS73T3qG8KCV509o=;
        b=bK2Ujqs7iOVPoswHRvVNcQr5+ulwKLDw0mgjM3c36l0q+zQ4iXuyu18IcmKrZiwfju
         cpBgqOZeNQg5ww931B3c0rKagG37W7k0BmwQEBdTMD+FVTPVdAIMpNdDhhLpM/Qp2loa
         abI8dvfUWG3YAFGWzK80bVrAa0LYJXFjtMPFwJB7hg+jqfvezboTDBJTzKpjy+ZObKSi
         1DFSbV0oWyvHFF7bQAXD0zO4U/rByreuI7WCSzTssTXktemFl0zQnk+Gq+Lwad01Ixwb
         6jWFCMnFpFNlLer6uXQsQjtlkHc0lN1p5g2ur8bYshyjWZK9E+0jUscOAJ61phrpWjJj
         jltA==
X-Forwarded-Encrypted: i=1; AFNElJ8AG4QNRyoOpHgRScP0nsX7WA7fmQ8YX+L67Po0mhGWO7Nxv9kLHEhNj8C27GBrXBMtbesod6USz1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YymnKhW3kP4DSv1uXffoCpMBaWdQVO9dlo+dKr5JzCkN2ZgWqqW
	DtSfusg+vsS8O1nDUbHsTLCs+kdkqIaoidBybJhNRQVV2kDtSIBn2iS2Tz0XxI6S
X-Gm-Gg: Acq92OEucZ8TGriWAy06ZbbQ1c4CKvajf4eIxQs+I/XMfXwfYtBYQ1AKnHZ9TMqjBlP
	3DqrD7indcO0cy+/16APGbumy9c44d3eqPHfp1lhVAHSlbT7/60e0s2AJt4xCBd3RIfJF+ZVfhg
	t4RTlOzFiIp3ahH7WcQn5Ifvvub9z1dayitM4xpcQRSvkmWDxKntOSpmc6pSQYDovSye9ixoDf2
	M2VEn5zR5A4bYvZLJ0jN9+rAycSdOzvMnt+CNIIvbfSNf7grTLHa+jfyBb5C4evVtZX12qjRX3W
	A2hUdI7K92FUz6APCx5URB2m5xtrKra64+ZnvQXYnJlrY54ON/YuKgfxAdGVrjgMbra4oC20wep
	8aTyQ19SlukFEbGAlA9MPlb+B93HgjpPKT5lr8j8Ws9lCAm1Y5Y/cn4TVCjZBZVgCMaF17leSxR
	2GR3TyeXOkQD6vnBqAqWIoiydFLXwp0txVHtRaoPLi6+lKl8R98lrDXojgdy3YIWErnkesmzS1e
	6uPAmUHIJf7sYgd4G2eL5JPwY7nWz8DqdIB0KhimwpNLAb0XA==
X-Received: by 2002:a17:907:849:b0:bab:1839:cc61 with SMTP id a640c23a62f3a-bcaacf2b3a8mr762286466b.40.1778515274081;
        Mon, 11 May 2026 09:01:14 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcd3cc282d3sm315940466b.4.2026.05.11.09.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:01:13 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 11 May 2026 17:01:05 +0100
To: David Lechner <dlechner@baylibre.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v4 10/10] docs: iio: add documentation for ad9910
 driver
Message-ID: <wpoiyqezs6lus5o7smlibbxrxqudvijgqh3gwgft2xjpiirwa4@xtdwe3kzleku>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
 <20260508-ad9910-iio-driver-v4-10-d26bfd20ee3d@analog.com>
 <b8f9a174-f3d0-4cb8-a571-605be79165d6@baylibre.com>
 <zvulxrrvg4sf7m5pjfpfucg7yssgallfu6zi6mcyblu2qy24hn@wdzs7h77vkoz>
 <18c2eab9-c0c7-4e93-b4e8-73b18531e784@baylibre.com>
 <uphcx5zr4lmukuom75g66hp4agurty7yq6mo6ri6otrsscqfek@tn3u5jjszaoy>
 <5bce7868-feca-4c54-a14d-ad4bf4072c29@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bce7868-feca-4c54-a14d-ad4bf4072c29@baylibre.com>

On 26/05/11 10:23AM, David Lechner wrote:
> On 5/11/26 10:02 AM, Rodrigo Alencar wrote:
> > On 26/05/11 09:46AM, David Lechner wrote:
> >> On 5/10/26 4:30 AM, Rodrigo Alencar wrote:
> >>> On 26/05/09 06:42PM, David Lechner wrote:
> >>>> On 5/8/26 12:00 PM, Rodrigo Alencar via B4 Relay wrote:
> >>>>> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> >>>>>
> >>>>> Add documentation for the AD9910 DDS IIO driver, which describes channels,
> >>>>> DDS modes, attributes and ABI usage examples.

...

> >>>> And a practical note, they should be "frequencyscale". I don't like that it is
> >>>> harder to read, but it is easier for a machine to parse.
> >>>
> >>> Parsers like the ones in libiio is not having problems with that.
> >>>
> >>>>> +Usage examples
> >>>>> +^^^^^^^^^^^^^^
> >>>>> +
> >>>>> +Set parallel port frequency modulation with a scale of 16 and a 50 MHz
> >>>>> +offset:
> >>>>> +
> >>>>> +.. code-block:: bash
> >>>>> +
> >>>>> +  echo 16 > /sys/bus/iio/devices/iio:device0/out_altvoltage113_frequency_scale
> >>>>> +  echo 50000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage113_frequency_offset
> >>>>> +
> >>>>> +Digital ramp generator (DRG)
> >>>>> +----------------------------
> >>>>> +
> >>>>> +The DRG produces linear frequency, phase or amplitude sweeps using dedicated
> >>>>> +hardware. It is controlled through three channels: a parent control channel
> >>>>> +(``digital_ramp_generator``) and two child ramp channels
> >>>>> +(``digital_ramp_up``, ``digital_ramp_down``). DRG destination is set when
> >>>>> +ramp attributes are written, i.e. writing to ``frequency`` or ``frequency_roc``
> >>>>> +sets the destination to frequency.
> >>>>
> >>>> Would it be better to say that the destination is set when the the
> >>>> value is non-zero? Otherwise, how would one change the destination
> >>>> once set?
> >>>
> >>> Destination is only one, so you just need to write phase or phase_roc, if you want
> >>> to target phase then. Does that not sound intuitive?
> >>
> >> I was thinking about if you needed to change the configuration.
> >> If you set it to phase, then want to change it to frequency, how
> >> could you do that if 0 is a valid value for phase?
> >>
> >> Also how could you know which is selected by reading back the
> >> values if 0 is a valid value?
> > 
> > This is where Jonathan raised some concerns, so it is a good oportunity for you
> > to provide your inputs! Right now, I am returning -EBUSY on read of an attribute
> > where its destination is not selected. As pointed out, the destination selection
> > is happening when writting to the attribute. In the previous patch, Jonathan
> > suggested frequency_active, phase_active and scale_active to track mode priority,
> > and It could be leveraged here for DRG destination selection. I havent gone for
> > that because I was not willing to add that to all the channels given that it is
> > mostly used for debugging, so I added frequency_source, phase_source and
> > amplitude_source to debugfs instead.
> 
> The "last write wins" with the others changing to EBUSY makes more sense to
> me now. If the docs said that, I missed it. Otherwise, that would be a helpful
> thing to add to the docs here.
> 
> > 
> > Destination selection for RAM mode is firmware based at this point.
> 
> Seems reasonable.
> 
> > Destination selection for Parallel mode is still not clear... could use
> > those *_active attributes or separate channels.
> 
> Since there are _offset attributes proposed for parallel input already,
> could we just make it the same where you have to write one of those
> attributes?

Different from the DRG, both RAM and Parallel mode has this extra polar
destination, which targets both amplitude and phase at the same time.

For parallel mode I have the attributes:
- frequency_scale: applied when destination is frequency
- frequency_offset: applied when destination is frequency
- scale_offset: applied when destination is polar
- phase_offset: applied when destination is polar

In parallel mode, there aren't knobs like those for amplitude and phase
destinations. With the *_active thing or similar, polar can be both
phase_active and scale_active enabled at the same time. However, this
would not behave the same way Jonathan suggested, i.e. to be used for
mode priority indication... it would be used for destination configuration
instead.

> 
> > 
> >>>
> >>> Zero is a valid value to be written.
> >>>
> >>>>
> > 
> 

-- 
Kind regards,

Rodrigo Alencar
