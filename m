Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DE83F075E
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784794445; cv=none; b=kTwabyck/TeyzP185LYu8BQfu41M26ZqQG8f6JvRluAK53k1fza0SrbhhStTN+0hNNvYx+LxAMqGEyd0PhSTh4yjVL7iyS+QHM2N8Aq9HYMUADHsSJSzFJS4WzPvgIlA/SyCnRK1ON2sT9DY0K7Xg3qeMo9WH0cdT1QQzJ1wgQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784794445; c=relaxed/simple;
	bh=ISLsYJiL/67AfFmjcKz7YdESqyE7QAUlfd/yb4LqNzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1XMHGMpVorlQDXTNh/1k4z9jW9BfYp0vJ2F4J8LXM5ZPMYBzuCX2ogZzF3qCeGvLCo9JYgvZ51bocDcPdkCOn1m1nwoM6PwxJx08gD840+nCqt3YY+5mTtIRSF2AFClUxEEMkP8bnZoul384y+CnEHVFn+NxGXm4EdydNDXK44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAogqfv5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAogqfv5"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47df43bfb07so66244f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 01:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784794441; x=1785399241; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pn6G1rW8AyYA5lkxWJxsOAx4+gkV20aFWEjqPOavvWg=;
        b=QAogqfv5QCL6qnClmfF1+j7/7weBhZPgXeCxV0+XnNTKKwp6czdN5L4iyG8FEqXAob
         lAYG6ZV/8Q0FhrkIkY/PVxTACnSrbsAZ8a5ywlEeK66UiNXikNJXxmZyWQ1zk+G2r0zz
         XeLUAnTR6PbvK4lA/mJrvT1WbU+j0GSJfagxfrXe+b8UVHWRkpMPIVFgjnIcdKhZlCpO
         N4+AOsr+gmbWxENQ41gWIBJYSrBh5hCugH3A2s4zJXf/z418fkPpzNVxSuI5avePQbrb
         +GWT+uaz8U8UX/hUurc4q+EJCpHiH1HD5XrfSiqz7py8sgPMA5kfByJUGRYFjOBS6wXb
         tPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784794441; x=1785399241;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Pn6G1rW8AyYA5lkxWJxsOAx4+gkV20aFWEjqPOavvWg=;
        b=LQhDs7RfQpVMPKba+0QR63aCYfN5ZR7UdFpPNMPdJRupa0YcJWDzByLGJSIXmcBFaC
         JmL13oRmlnkXiN2/TvnVk7x0g65YaI5Egt/fZRC8j9P2dFNBPgOsukW7b0TPThbUQJoW
         Yrccu8h54X01Dy08ir7qPedT1FeMbTy2FjVJsiV3sWLdzNYjL9jQeT5O7pS2imV67ohn
         Z82utFIeqvC3WGuh0ksnh6vmbr5Vs5x2Es8jg7bvyfJcGgpvb1nfdUAfPPN9nHaZSme2
         NFNXKo3Lazs/mke156g2VtAtu5g8f/TTCRi4ZxJ7vRLUOgPIltnMXpZEC4I4wuPQxpzV
         l1gw==
X-Forwarded-Encrypted: i=1; AHgh+Rpliwc9YNOcPD2ZfzAKIR73t/pNsreN3BJLQCHBtu7VPu7FrkdcsH1Fri/gMFJ3qJ3tUk/usxrbz44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd3O4jCWJXJxZGSQMTWt38FPkjrFgBBnjRpqiJHNLaCQUsHzd5
	X270UtYpas2Fr+yzQWk3V1mKolNcqrfPABqxs1CPl/Q2Lb4mvJ25K4bh
X-Gm-Gg: AR+sD11TWwLFQ/Kd/Lm5Xqq1w+FDhJkcq2sIzG4mzqDRADD2dPIwu3n7ryWr4EXBkRo
	5XmYAxfQgg6yUY54RVSn0UPeDA/UlVqxEhzp3t+rJ4E/C5N27R2LLvxhwHHut1jO9h6URguwhJq
	hUP0UwonGOPXl0YlVZTuP2tBNidpoVFbWsFxQfNh6ux0HV24tMSgBLQ01J3YcF5vqym31uAPTSk
	zkYezrNoUd5DXBClM3hb4m6DNM+BhQk99wFcTAD7QqELZQGJ2krurpglqNUZRmGyXw7OkPabVSq
	Iqk5GAfbYwZnysx7ZADTnPdyFe+wYwUa8hb4MzX1TwsBPnqSoGkPhm62JHGUlN39Z+5rfN3H267
	2aWEjoqIL2Cnr6rsjF+5mOFp0WPjzaNzbiG77MLPY/Pa5f9t9xbVzARNltKelFk8n1lBNUQ==
X-Received: by 2002:a05:6000:25c3:b0:475:f0f0:9ef7 with SMTP id ffacd0b85a97d-47f8d76ee04mr2371195f8f.60.1784794440915;
        Thu, 23 Jul 2026 01:14:00 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c63bd3sm12591725f8f.27.2026.07.23.01.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 01:14:00 -0700 (PDT)
Date: Thu, 23 Jul 2026 09:15:08 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Janani Sunil <jananisunil.dev@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, Janani Sunil <janani.sunil@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: iio: adc: Add AD7768
Message-ID: <amHLZK46lxqSZIC8@nsa>
References: <20260709-ad7768-driver-v1-0-44e1194fd96a@analog.com>
 <20260709-ad7768-driver-v1-1-44e1194fd96a@analog.com>
 <36df7c4f-82ea-4ed5-a4f9-3a29c75dc99a@baylibre.com>
 <9dd16bb5-7a30-4024-88a7-4a4bf47c35e8@gmail.com>
 <e791f4f9-63dd-40f5-aec4-5b540bcee5ff@baylibre.com>
 <d159cae0-b11e-49e9-a546-023ed61b900e@gmail.com>
 <20260722025853.6ca3961d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722025853.6ca3961d@jic23-huawei>

On Wed, Jul 22, 2026 at 02:58:53AM +0100, Jonathan Cameron wrote:
> On Tue, 21 Jul 2026 10:03:26 +0200
> Janani Sunil <jananisunil.dev@gmail.com> wrote:
> 
> > On 7/21/26 03:39, David Lechner wrote:
> > > On 7/20/26 9:00 AM, Janani Sunil wrote:  
> > >> On 7/9/26 17:43, David Lechner wrote:  
> > >>> On 7/9/26 3:50 AM, Janani Sunil wrote:  
> > >>>> Devicetree Bindings for AD7768-4 (4 channel) and AD7768 (8
> > >>>> channel) simultaneous sampling ADC
> > >>>>
> > >>>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > >>>> ---
> > >>>>   
> > >>>> +
> > >>>> +  adi,power-mode:
> > >>>> +    $ref: /schemas/types.yaml#/definitions/string
> > >>>> +    enum:
> > >>>> +      - low
> > >>>> +      - median
> > >>>> +      - fast
> > >>>> +    description:
> > >>>> +      Power mode selection.  
> > >>> Unless there are pins that control this, it seems like it should
> > >>> be left up to the driver to decide how to set this.
> > >>>
> > >>> In this case, it looks like the power mode also influences sample
> > >>> rate which is normally something controlled at runtime.  
> > > Looking at this again, there is also an MCLK divider that influences
> > > sample rate, so sampling_frequency to power mode is not
> > > straight-forward anyway.
> > >  
> > >> Hi David,
> > >>
> > >> The reason we'd like to retain power mode control is that certain
> > >> ODRs are supported across all three power modes (low/median/fast),
> > >> and the RMS noise and power consumption differ significantly
> > >> between them at the same ODR.
> > >>
> > >> The higher the power mode, the better the noise performance, but
> > >> power consumption nearly doubles for every ~3 dB improvement in
> > >> dynamic range. Silently selecting one power mode in the driver
> > >> would remove a meaningful hardware tradeoff from the user.
> > >>
> > >> We'd like to propose the following instead:
> > >> - Remove adi,power-mode from the DT as suggested.
> > >> - Expose power mode as a per-device sysfs attribute.
> > >> - in_voltage<N>_sampling_frequency_available dynamically reflects
> > >> only the ODRs valid for the currently selected power mode.
> > >>
> > >> This keeps the DT clean while still giving the user explicit
> > >> control over the noise versus power trade off. Would this approach
> > >> be acceptable?
> > >>
> > >> Thanks,
> > >> Jan
> > >>
> > >>  
> > > Jonathan usually pushes back against userspace power controls. We
> > > do have this for accelerometers, but not ADCs currently.
> > >
> > > If we can't think of anything better, maybe we could use this. It
> > > only has low_noise and low_power options though, so the driver
> > > would still need to chose the best power mode of the 3 based on the
> > > other requested parameters. E.g. always make all sampling_frequency
> > > available  and just pick the highest power or lowest power mode
> > > that can provide that rate based on the power_mode attribute.
> > >
> > > I wanted to suggest maybe adding some kind of noise attribute
> > > instead, but I'm not sure how we could do that in a way using SI
> > > units since the value would depend on so many things (at least
> > > V_REF voltage, filter type, temperature and even the physical
> > > input).  
> > 
> > We considered the low_power/balanced/low_noise approach, but the
> > customers typically use the datasheet alongside the driver and the
> > datasheet explicitly uses the terms "low power", "median" and "fast"
> > for the three modes. Abstracting them with different names in the
> > sysfs attribute would create a confusion- the users would have to
> > mentally translate between the two naming conventions. The noise
> > attribute would not actually configure anything on a register level-
> > it would purely be informational. Furthermore, noise performance is
> > not solely determined by the power mode. There are other parameters
> > (eg. filter mode) that has a significant impact. A power_mode
> > attribute directly configures the hardware register and has a
> > deterministic effect on the device.
> > 
> > Jonathan, could we keep the power_mode as an attribute in this case?
> 
> My really strong resistance to 'mode' type controls is they are
> meaningless to general purpose software.  It has no idea how to
> set them correctly. The purpose of IIO is to provide general abstractions
> and power modes are never that.
> 

Unfortunately lot's of apps engineers for these parts just like to
control it all and don't care about generic interfaces (given typically
these the devices are the only ones they care). So we also have some pain
trying to explain all of the advantages :).

> Hence we put a lot of effort into mapping them to controls or measures
> that have precise meaning.
> 
> I can't remember how I got talked into allowing the accelerometer
> ones either :(  It was way back in 2013 and we have only one user.
> I should shift that ABI doc to a driver specific one so as not tempt
> more users.
> 
> To give a firmer opinion I guess I'll go read the datasheet at somepoint
> but it's not a small one so that may take a little while.  I do see
> that there is a recommendation for each power setting to only cover
> one range of f_mod.  Maybe that gives us a route to a control that
> it at least numerically meaningful (For those who know what effect
> the modulator frequency has in a sigma delta modulator! Which
> doesn't include me ;()
> 
> Any chance we can kick this into the future and get a useful base
> driver ready for upstream?  It is a lot easier to have these discussions
> when they are the only topic related to a thread.  One path to move
> on would be to decide to default (only option for now) to the
> best noise option.  Later we can add controls that result in that
> initial default changing,

Yeah, those were my internal 2 cents. Not sure if this is exactly what
you're proposing but what also came to my mind was to have a RMS lookup
table (same as in DS) and for the overlapping frequencies, just go with
the one with better RMS figure. My assumptions is that most users will
prefer that. If not else better comes, we can have a driver argument to
override the prefered mode (same way we do for some ADIS IMU devices).
And yes, I know module arguments are not very encouraged...

Or given this also looks like a system level decision (I don't think this
is something one wants to change at runtime) maybe DT (acting as an override)
would not be off the table.

- Nuno Sá

> 
> Jonathan
> 
> 
> 
> > 
> 
