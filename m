Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD7D39B965
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267144; cv=none; b=SxOMouCvfuFb4PzJsMkQUSATWLcabZEUXkVYv/5MraDtlQZ9HgxlUYOgipX2Vh8iCgReubl7sCravZBbs1zzArWM/Sv8rZc8GwAIKpHzD1y7OQaf4sTehq5wwRf+LpBknkYdiv2kzcy1ebS1bhSXEqNpXBvPr2WA8oMJp9M6TSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267144; c=relaxed/simple;
	bh=ELtImlRs/RlYTP+Zv0TOi4aJNiHzPqCPYyRyWRRAAK8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5GsfBmbDwaBdPErbRCzMnhwJr4poH07YEPO55tExBqZzyNyn1BdFix+eQGlarZgPrXzINfiDBJzm010WJrPozLxYdx11rREEsdmUGle3c1EEQZiMpI+fuV3ck5YJX4AIfv7k6MS7dUfwIZ9e+dOXEyc5Qq438d6Y2JxYyoPnoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+pEUPqk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+pEUPqk"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9358bc9c50so12271866b.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 04:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774267141; x=1774871941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RU6NYRz6AVXhi5ZvZvCh4JAOhWnWFdHOlwdskFh6xa4=;
        b=e+pEUPqkJf0PV9orarFsbxEOZl4avUX+L7fgplxP/WjHxt5CdG9TOREvZEjKodbrcm
         lL96qAT4L7JDKJg2X1cHhM9/B3pKrb+LIzpdTzgdlY9dqtvKkHY0V7DmD3ZBEelmTzc9
         8SKDueW4zwx3fz10TsTfbfdgu1uGkP/4avaOl50E88eK1mGrVyl/M931O1m6ctNaJLzM
         Xb+dqcM2UDO+YalCbloqc9/dc6VO5vIaTal3rPPtO989LpRD9VQhcdY9/8tu/fDORxb3
         hGHqgDXfTcjC9HQePN7kX3KXcu1q2kPp/aSogvPQBVLWC+KwNSVuoPrZXJLmyx5iyz3L
         dr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774267141; x=1774871941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RU6NYRz6AVXhi5ZvZvCh4JAOhWnWFdHOlwdskFh6xa4=;
        b=OT+R7eHkWYIyLcFEvA3IgxIqgZCQ80sC+kCV7rtU86zX05Kt9wUmgEI8Q3Dprn96h8
         Klu2TuMuDo3VTdjUFI4xrvVY/v+kIDsHIEOsRDMMonoJFv75jDcM7UI/lk2cc6M6NH5x
         HEyc/1ji4dceCR7YtCcMYTRtPlPwTZryRarJ8r6greqBa1drl2SQ7akgkV2fUobNRJ0X
         TXlXHLpaQKazt9Yo3WFkTcy0H9t5xtrRPg3yMi8vBIUaQG2Y+Jm4HyXgjxTqJVlxg7oT
         rD4IQpPpx5EljQzPWPe5KaggWCo61Ice3w+FPLiIk9PnXLaZTaSpBojApcqCk0ywpd6p
         Gbaw==
X-Forwarded-Encrypted: i=1; AJvYcCXoNPo6NpsYA2nKwX01Bxyr3wfZVT0hHxgcHkQyyPXmAQ5AQEKW9uR/BK4zZ/wXkLB/q7lFZCQvyM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYRJu+B9zPistd/yPVNP6XghRFlJ/9PTNmhQ87AudO0lNKf9cK
	Rti9hsb1NuacwzfXJBn6FTeg0NL++p0KkvM9kx1nL7uvkYgZ4e6koNID
X-Gm-Gg: ATEYQzxWk27tyuP8sNWAGMRPRd9if+RZgAcIh6q1coVMv1R8iSj3UtSv0MiCOo2A9Wa
	s0VXUemAqQXWfeA6j7AtiU8VNeXNBqg2TaH22poaquL+Fque0tno48J2FXhMi2V7saY1tK+59PQ
	Qu62effSpAVsmH0GvphNp+xJNLRKqL6R9XJBCigVxybN3PN/qA/9mlKxuv3DBDtyCCglaqvRrV0
	K8WuZz1sRAlVqKTKFmW816n2Oi2tzJj16PNMHa41vkP3ySN2mcOefPRdPvtJgih3iscnSQlnhJh
	VUNk9r+KFEpUeUXimbO3qS3EgXwqKsSJ6ej6vWWZMSJvOn4IuYpXAz7UAU1Gqgpmo+d52HcZH8H
	+b/uaQnlQ/GUMX8kQbIZvZGRlcloMO81oNJgV0FrMHtIxNmGJeWH3egVwlJP7aB/xzuqEJd0W9P
	+/kYBVp4Wg6oAVthzVj1a/Pr4Y1jEK8oQQDEA9HRGnnvHIijqWb7+vGGDhsxxS2nLV5Zt8hYuFS
	0i49QxpksgyZnaBistZcBzMOh3SiwB7JA+s4eLkCo7PzfKwJ3Y=
X-Received: by 2002:a17:907:c789:b0:b88:6164:6421 with SMTP id a640c23a62f3a-b982f1f2b12mr865165466b.16.1774267140453;
        Mon, 23 Mar 2026 04:59:00 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b98416ac27asm362764166b.59.2026.03.23.04.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 04:58:59 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 23 Mar 2026 11:58:53 +0000
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH RFC v2 9/9] docs: iio: add documentation for ad9910 driver
Message-ID: <g57xnbhtvu25dvzy5b5pz76yzalpcjpnyclob6dy6j7fphxqle@5vww7psogbv3>
References: <20260318-ad9910-iio-driver-v2-0-e79f93becf11@analog.com>
 <20260318-ad9910-iio-driver-v2-9-e79f93becf11@analog.com>
 <20260322173434.23d2ee0d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322173434.23d2ee0d@jic23-huawei>

On 26/03/22 05:34PM, Jonathan Cameron wrote:
> On Wed, 18 Mar 2026 17:56:09 +0000
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add documentation for the AD9910 DDS IIO driver, which describes channels,
> > DDS modes, attributes and ABI usage examples.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

...

> > +Channel hierarchy
> > +=================
> > +
> > +The driver exposes the following IIO output channels, each identified by a
> > +unique channel number and a human-readable label:
> > +
> > +* ``out_altvoltage100``: ``phy``: Physical output: system clock and profile control
> > +
> > +  * ``out_altvoltage110``: ``single_tone``: Single tone mode: per-profile
> > +    frequency, phase, amplitude
> > +
> > +  * ``out_altvoltage120``: ``parallel_port``: Parallel port modulation: enable
> > +    and offset/scale parameters
> > +
> > +  * ``out_altvoltage130``: ``digital_ramp_generator``: DRG control: enable,
> > +    destination, operating mode
> > +
> > +    * ``out_altvoltage131``: ``digital_ramp_up``: DRG ramp-up parameters:
> > +      limits, step sizes, ramp rate
> > +    * ``out_altvoltage132``: ``digital_ramp_down``: DRG ramp-down parameters:
> > +      limits, step sizes, ramp rate
> > +
> > +  * ``out_altvoltage140``: ``ram_control``: RAM playback: enable, destination,
> > +    operating mode, address range
> > +
> > +  * ``out_altvoltage150``: ``output_shift_keying``: OSK: enable, amplitude
> > +    scale, ramp rate, auto/manual control
> > +
> > +The ``phy`` channel is the root of the hierarchy. Changing its
> > +``sampling_frequency`` reconfigures the system clock (SYSCLK) which affects all
> > +other channels. The ``profile`` attribute on this channel selects the active
> > +hardware profile (0-7) used by the single tone and RAM channels.
> I asked out this profile thing in one of the other patches.  Key to me is
> that how we write non active profiles?  The most similar thing we've seen
> in the past has been setting other frequencies for FSK or phases for PSK or
> more mundane DC DAC output that are symbol based. (often an external signal)

Yes, not allowing to configure a non-active profile at this point.
Initially was not seeing this as a problem, but would you think different
channels for each profiles should be created? e.g.:

- out_altvoltage111 ... out_altvoltage118 for single tone profiles; and
- out_altvoltage141 .. out_altvoltage148 for RAM profiles

That would not remove the need for something like the profile attribute.

> For those we have added an additional index so we can see which symbol we
> are changing parameters for.  Here it might need to be done in the channel
> numbering. I'm not sure.
> 
> > +
> > +All mode-specific channels (parallel port, DRG, RAM, OSK) have an ``enable``
> > +attribute. The DRG and RAM channels additionally have ``destination`` and
> > +``operating_mode`` attributes that configure which DDS core parameter is
> > +modulated and how.
> 
> I wonder if we flatten things out and have separate channels for each type
> of modulation. Might lead to a more standard looking interfaces. We don't really
> have a standard path to control one type of thing feeding another, whereas
> we do have simple 'enable' interfaces.

...

> > +RAM mode
> > +--------
> > +
> > +The AD9910 contains a 1024 x 32-bit RAM that can be loaded with waveform data
> > +and played back to modulate frequency, phase, amplitude, or polar (phase +
> > +amplitude) parameters.
> > +
> > +RAM control channel attributes
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +.. flat-table::
> > +   :header-rows: 1
> > +
> > +   * - Attribute
> > +     - Unit
> > +     - Description
> > +
> > +   * - ``out_altvoltage140_en``
> > +     - boolean
> > +     - Enable/disable RAM playback. Toggling swaps profile registers between
> > +       single tone and RAM configurations across all 8 profiles.

...

> > +   * - ``out_altvoltage140_address_start``
> Do we need this flexibility to set the start?  We needed a length, but
> if we want different effective start can just load a different image.

There is one image being loaded into the entire RAM and each profile may choose
from wich sample it starts and ends its address ramp.
The profiles can have those address ranges to overlap or not, then I suppose
considering different images would just complicate things.

> > +     - integer
> > +     - Start address for the active profile. Range [0, 1023]. Cannot be
> > +       changed while RAM mode is enabled. If set above current end address,
> > +       end address is automatically adjusted.
> > +

...

-- 
Kind regards,

Rodrigo Alencar
