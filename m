Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C363FF1AF
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860043; cv=none; b=Sm1mGe8DuwmgbhHa4kYJx8/77CMtIdamXec77xBQ34Dl9GBpMl/jX5b+f55WrpXa0hYUdJhzGD3+6MXhOm1bwx3jyvHsBwCXMy8eS4awChHWufGs6zsoSXerpdo6LeKFUKgGsfb8/aRLss+c1keNF7MM8lephPEqQ4a52GB7ZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860043; c=relaxed/simple;
	bh=4x/tYI7wVE/dj5Xs9J1SD3ExCZzdqPFh+Ku4yirTTFs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBZAhUPWxYw+CqZ+olyVbwqBy8vrRwdvgp7l2N+NqiV6dYXYDz8SD0l4J3xXWpFgSvUApGbvXk0Wy1q8UJrbHsjgRO1fpXsk4wMDRmdHeoDtEB9QSL36+uhrWXMG35QEWW8wBK22nXrw3gT2W3yxk5eZ8m2FVZZTFXhFDfZt5NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdROLOAb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdROLOAb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso63963545e9.1
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 08:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778860040; x=1779464840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kCmxHgPSnL+/rrs2yz/09fkOkjHEfDbnI1nUCTxT6M4=;
        b=OdROLOAbhQC1x2aKNagUXyKkcOUaeFt3dh6rfWFk+JhvEXNVfLuXYEB4LmvHKOtIl3
         wHkiUugoUw6ZZUGVWFafFkgG41nxrXV00APqFBfGlHmfARrR4Ey9Cf0gWXEQ+xJfbAl/
         PicH9caMxkqNTXpsX6gHnS0qgsp+ggrrgfGw3VZzoTaV3+OTpJOJbqXEDx5SNlQvb9Zl
         EvNx0rNY3+PPGahRfqQKj3MiPOQFxlm302hupsC0Tn7iNhNtkxiY5TXjNT0CgCll4Czn
         hpoipp/355oLTdLxUJyTwyniJ5EauGdxPvfga2wUNFGpWWFwZo1PMrCQvNUQaHeJ3UxZ
         kfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778860040; x=1779464840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCmxHgPSnL+/rrs2yz/09fkOkjHEfDbnI1nUCTxT6M4=;
        b=MXUiJLzV7pI91fyVuK9hxWeV/hkHsiS+1Wmz41rS04uAhHRF5o6GuOCchJOGtE9eRq
         oKBwPnP/0ZxielxdgO8vL5PtxZz9TS2fij14UysBDAFG56NMlHY7tSLuNcnew6kpJWwv
         2DWTtqt6wIjkkIwNUiZGuBC056b+BzLOBrRHiG/T+torphg0ORsoOfCJxb/1ckOOjt09
         1S432ULAOHz4UEBjXEfIDp+lZpzB5yGn1TZH49CIm0bdssUsz94+obndujLSOe+0fuMS
         lc7sT6eJ+0XNCh5MjCFujOKeMyZk7TGj4QND49TTGjDgYbueZn63luxcJ38I8o28l2LI
         2n0A==
X-Forwarded-Encrypted: i=1; AFNElJ8t5iRsRBM2TdrGeArJzy10bQQfb9Y9KR/G/WbTzEWdOtGQLOsDrHAu0r/80C2s/ngdYwZp9ZEKyPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcSIvkJBXWALVjZT7H/hjsn0dF4ow3D8Z65bSMu97+GrviUbdU
	en3CyGvN12hu6EdHOT+k34jNtn5djBdrJbgLdSjVBEMLEgYYdTFoGhw2
X-Gm-Gg: Acq92OFcpLqWvwHurSpxO14Q1hdrS90H/yoN3xro+YoEZVVTC0Ng2Bjvv0A0Hz5eqyu
	TXb1H1wV/jRJWOKL7LEhgfxYos2ecDtu3fzHlziwVDZpcIEgQwuInVoQ0uGqvz5BbCsjEnrMvju
	57aPe9s6r8Hh9c7GqTndVwgSnOZR71WgrPqAk9NgS4FtEaEg/pCqhnXs/ivfv4YhfJIuKZKJlRT
	pgYo8msesDMxCNkz3PFSkl5xMxk6cRWETjCIMW5PmgTzjhLIO9HYnocy3OKfvX7AvT50PpuA8X0
	+Fmya5e9L6zMk6JnPE4QfvMdvPts4+mjImwNQZ2R2sPGyOIsUH9LIo8dClQjAY58BVyDFIFVRM0
	+UBGVGdLg78NSxV4sw8pxupq21g0+b1GW7SgCDSrBRwT25DeDeZfab6FvHxKrSo1kXQtK2d82Pd
	jgF/n0D7Df/tlTZQMR+BXRZFmxBGgRlHzgoaFukjL49SlYHB4K5vw1s6GJMYNphfDVb6LdIiP7A
	5k8KqdhkghGAhalTGEprwSVxZ28q0tnEUKMHZOxX1GPHzrhPw==
X-Received: by 2002:a05:600c:3b28:b0:48f:e230:80a0 with SMTP id 5b1f17b1804b1-48fe63267bdmr65802875e9.30.1778860039835;
        Fri, 15 May 2026 08:47:19 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57944c1sm80081305e9.7.2026.05.15.08.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:47:18 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 15 May 2026 16:47:12 +0100
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
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
Message-ID: <csqudninfd5g3vkrzu45mfsbunxygwymlycwijgwvvpfbqhatr@fzib4gvhqc4o>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
 <20260508-ad9910-iio-driver-v4-10-d26bfd20ee3d@analog.com>
 <b8f9a174-f3d0-4cb8-a571-605be79165d6@baylibre.com>
 <zvulxrrvg4sf7m5pjfpfucg7yssgallfu6zi6mcyblu2qy24hn@wdzs7h77vkoz>
 <18c2eab9-c0c7-4e93-b4e8-73b18531e784@baylibre.com>
 <uphcx5zr4lmukuom75g66hp4agurty7yq6mo6ri6otrsscqfek@tn3u5jjszaoy>
 <5bce7868-feca-4c54-a14d-ad4bf4072c29@baylibre.com>
 <wpoiyqezs6lus5o7smlibbxrxqudvijgqh3gwgft2xjpiirwa4@xtdwe3kzleku>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wpoiyqezs6lus5o7smlibbxrxqudvijgqh3gwgft2xjpiirwa4@xtdwe3kzleku>

On 26/05/11 05:01PM, Rodrigo Alencar wrote:
> On 26/05/11 10:23AM, David Lechner wrote:
> > On 5/11/26 10:02 AM, Rodrigo Alencar wrote:
> > > On 26/05/11 09:46AM, David Lechner wrote:
> > >> On 5/10/26 4:30 AM, Rodrigo Alencar wrote:
> > >>> On 26/05/09 06:42PM, David Lechner wrote:
> > >>>> On 5/8/26 12:00 PM, Rodrigo Alencar via B4 Relay wrote:
> > >>>>> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > >>>>>
> > >>>>> Add documentation for the AD9910 DDS IIO driver, which describes channels,
> > >>>>> DDS modes, attributes and ABI usage examples.

...

> > >>>>> +Digital ramp generator (DRG)
> > >>>>> +----------------------------
> > >>>>> +
> > >>>>> +The DRG produces linear frequency, phase or amplitude sweeps using dedicated
> > >>>>> +hardware. It is controlled through three channels: a parent control channel
> > >>>>> +(``digital_ramp_generator``) and two child ramp channels
> > >>>>> +(``digital_ramp_up``, ``digital_ramp_down``). DRG destination is set when
> > >>>>> +ramp attributes are written, i.e. writing to ``frequency`` or ``frequency_roc``
> > >>>>> +sets the destination to frequency.
> > >>>>
> > >>>> Would it be better to say that the destination is set when the the
> > >>>> value is non-zero? Otherwise, how would one change the destination
> > >>>> once set?
> > >>>
> > >>> Destination is only one, so you just need to write phase or phase_roc, if you want
> > >>> to target phase then. Does that not sound intuitive?
> > >>
> > >> I was thinking about if you needed to change the configuration.
> > >> If you set it to phase, then want to change it to frequency, how
> > >> could you do that if 0 is a valid value for phase?
> > >>
> > >> Also how could you know which is selected by reading back the
> > >> values if 0 is a valid value?
> > > 
> > > This is where Jonathan raised some concerns, so it is a good oportunity for you
> > > to provide your inputs! Right now, I am returning -EBUSY on read of an attribute
> > > where its destination is not selected. As pointed out, the destination selection
> > > is happening when writting to the attribute. In the previous patch, Jonathan
> > > suggested frequency_active, phase_active and scale_active to track mode priority,
> > > and It could be leveraged here for DRG destination selection. I havent gone for
> > > that because I was not willing to add that to all the channels given that it is
> > > mostly used for debugging, so I added frequency_source, phase_source and
> > > amplitude_source to debugfs instead.
> > 
> > The "last write wins" with the others changing to EBUSY makes more sense to
> > me now. If the docs said that, I missed it. Otherwise, that would be a helpful
> > thing to add to the docs here.
> > 
> > > 
> > > Destination selection for RAM mode is firmware based at this point.
> > 
> > Seems reasonable.
> > 
> > > Destination selection for Parallel mode is still not clear... could use
> > > those *_active attributes or separate channels.
> > 
> > Since there are _offset attributes proposed for parallel input already,
> > could we just make it the same where you have to write one of those
> > attributes?
> 
> Different from the DRG, both RAM and Parallel mode has this extra polar
> destination, which targets both amplitude and phase at the same time.
> 
> For parallel mode I have the attributes:
> - frequency_scale: applied when destination is frequency
> - frequency_offset: applied when destination is frequency
> - scale_offset: applied when destination is polar
> - phase_offset: applied when destination is polar
> 
> In parallel mode, there aren't knobs like those for amplitude and phase
> destinations. With the *_active thing or similar, polar can be both
> phase_active and scale_active enabled at the same time. However, this
> would not behave the same way Jonathan suggested, i.e. to be used for
> mode priority indication... it would be used for destination configuration
> instead.

I was thinking, and it might be good to define this now because of the
fact I might need to create other 3 channels for the parallel mode (Maybe
that is fine and we can create them later if needed).

One thing to note is that in parallel mode, although the format pins (F0, F1)
that defines the parallel destination are synchronized with PDCLK (parallel port
clock), we cannot really send multiple formats in a single session, so we
cannot interleave destinations. Then, if having separate channels we would need
to contraint that (only one destination works at a time) with the available
scan masks.

Now, also related to the IIO backend support but for the DRG channel...
Anticipating new ABI for the IIO backend, currently I have the following to
expose ramp control from the FPGA IP:
- toggle_en: To allow the backend to control DRCTL pin, toggling it in response
	     to DROVER, according to the configured dwell modes.
- ramp_delay: the delay between ramp sweeps in seconds
- burst_count: amount of ramps in a burst of ramps
- burst_delay: delay between bursts in seconds (valid when burst_count > 0)

Would also be good if I can get a comment on those! Maybe toggle_en can be
removed as the other ones only make sense when there is dwell and when this
toggle is enabled. So toggle enabled can be set by default whenever we are
not in bidirectional continuous, i.e., we are dwelling at either max or min
limits (or both).

Just to summarize the motivation for those attributes... the idea to create
those ramp patterns is to allow a receiver that performs stretch processing
to assemble a "radar data cube" of data, where FFT applied to each dimension
gives different insights on the detected object: range, velocity and direction.
Each ramp would give a row, a burst gives a matrix, and with multiple antennas
one gets a 3D block of data.

...

-- 
Kind regards,

Rodrigo Alencar
