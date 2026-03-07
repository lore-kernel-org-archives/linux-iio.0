Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B77C32ED21
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772902221; cv=none; b=nbxs8lv+B6psLQtaci3mne6qOL4Q+gJchnRvuFFKB5miB4Xlfnip6INxVoFuhX+nff9j2AoyXQTFDFZG8UniM166NRsG8nNahjMLoIsxhSKmJ1PETGP+8Sfh21U4Epuj36LcJbxKddyvzDY15JTjbcb6YDQ/aBanHhXKbYZmWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772902221; c=relaxed/simple;
	bh=cNks/tp+AMRyN6sp5KytIVoOfz22YIR8StH2a4NjKG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkGlWkv7eyuj8dLvRElzcZj7DIDX/0s2Nt0StJ3aWQB95gbRkWzhxVhor6qO9qERucDbfLdDhL+L+zpGabLfQyDbruQtS4wfZl90Nj1Q2Qa+aO2EJrosVv4O4U/qWDZ80fQqs4I2Ja2LMsVC7T02IN1v5sA4VGPLTQg0xxtfWkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FcUn2hNM; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FcUn2hNM"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d4be94eeacso10703384a34.2
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 08:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772902216; x=1773507016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/82J0F6BsrTq+dl8XoJ9fpKY1YIojB94UrmWOeex5k=;
        b=FcUn2hNMuFw8q5cjDxl46XptIDKYrJsz8lJvkpzLyXPBSzXEjepT+vl4lxh80kZuFG
         vIRuNgk49nV7V+w2cctfLbM0adzyHL9AqKrxY7GsQlCtjKw4GA1vLigDcfB+7K9kUjbI
         2ibFfKxJJTp2uKuON9zgHww/JV4GzjnGd3E5UK7mpeoLVIyJ895K7kXaa+O3R0k5WObs
         3B7u9UiZhUqwPuiBXUEYDwdvtbfFkxuvrrmbh3gZUzA0BRXxjCNB9z2xkKvIfy8zqtx1
         48D4zCVAYhapqbIQa+GFWKVz5DaXvspgrAf0KP8PtpSYEifKaMK8k1yOs4ykYLdf5UCs
         dgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772902216; x=1773507016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/82J0F6BsrTq+dl8XoJ9fpKY1YIojB94UrmWOeex5k=;
        b=jxgLQzLssCs6z6Vzp0iq0Jo9DwUefOFRLPaWs1D7oKP/PCK778Dxh6wPyh2dmQZnI6
         UR5q3DHxJ3phNlHK4PB/EqkiSmFrpHiBvwOfTBDcfyQS6XzDr6CT+gv7IoEy/y/yi/J7
         LhbRruMvFfjlP50XMTuyGu/dxiwY9GJwxNh3oSRJihX/ik6tVvaL735CJGd7AazNy4Ir
         xIZthX2YnIhHWTJKp2EtFqGuv/MALopVckJjOoX1lr2+dfBW7T2NugmSXNGseVNIM9di
         2zYkLW5sEhi0HrpeoQ8sIQYwgoUDysTTgFbCO9eYmUyLPlTU7aPEad5gEiajEBl8GT/f
         BKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJwzC67HnXaAdfgpO66o0zBuBj/KzykbRfvRIWylDZiBbTPZ+MZs95FgxtFpPsQcUEKF/RmdOxgkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTCXdrJWHKxJ1nHjLledhbVwi/zZ4Q+DVf8zFihNNxpTD0b2dJ
	flfjUR5HdZXeLhSkPXmCBviN6tsIHIg+3El+ih3mHtdDMzW97cZtifR3YLKQ97P0yLb72I/dd3G
	a2ILU
X-Gm-Gg: ATEYQzz2vABzh0sAbTsParr/VFSCx/LEQsWwczF1rzEdlKZiywN6pu4XJIjDE8tHTx0
	b4AEAlc3HaI9E/XjT/AtDddUiE3oTBKt7LRHvD6xNNYWCS4MGJdAVHdFEj2BzkEprt5WmURMKLn
	rvqPGLZELLI+dkFkHZ7vGWKB+RL+AfWCtbfKWDONDIPQXrZnM6JMGDD2zPX/zlWzQuFxjXvHnlz
	EcG0KOoWGkv54eu71T54dS7oe5ud53DUAy926Eib2HRFeptFKUzz0/Pzl1K1pASV5qqBhEybyhU
	po5U5ESGOFMNRrEDwggRfgp4/UhsH7xOvYP8Od20ZSW8V026eDI0+Qo7+1pG1+sz+6J3rQWgVQM
	kQ34GR0HFxUUO91/1Sm9VN9UZ7CC9nQBhyjmGHtydS77J/UXieLJuHytOYQlmXzk4tfvfOla4sI
	OfOziQWXXb7P0efdemhXvEEaPZa50Nqd0cH/5tscLm9iFBbHCqTng+3kaXvyKbPK9Fsd74IhIsp
	zkYyopY37aF
X-Received: by 2002:a05:6830:410f:b0:7cf:dbb4:320a with SMTP id 46e09a7af769-7d726fe1a6bmr3617425a34.27.1772902216297;
        Sat, 07 Mar 2026 08:50:16 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cccf:5174:fa72:c520? ([2600:8803:e7e4:500:cccf:5174:fa72:c520])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d728c5b75csm3349388a34.2.2026.03.07.08.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 08:50:15 -0800 (PST)
Message-ID: <7cc67826-3a8a-4190-9447-62b7d68e4445@baylibre.com>
Date: Sat, 7 Mar 2026 10:50:14 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/8] AD9910 Direct Digital Synthesizer
To: Jonathan Cameron <jic23@kernel.org>,
 Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
 <a72b2d62-3b91-4789-a1b1-ff1429e80ed5@baylibre.com>
 <2k4ouimpaxjuhnk67qmrues2375zj43ehru7h5as6w6kf7yak3@2ndr72co5trh>
 <bdc973e5-df74-48f2-8884-439b03565940@baylibre.com>
 <9392fea00a9c3b23d1bc9468faa1b3cc20904398.camel@gmail.com>
 <20260301133806.5e706756@jic23-huawei>
 <pohirub7gjqu7xtq5qakkmr3wlek2rgj6kdgltjvir6g4jwgbr@hmjflsplni4o>
 <20260307140953.46db3c19@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260307140953.46db3c19@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/7/26 8:09 AM, Jonathan Cameron wrote:
> On Mon, 2 Mar 2026 10:22:47 +0000
> Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> 
>> On 26/03/01 01:38PM, Jonathan Cameron wrote:
>>> On Mon, 23 Feb 2026 10:02:00 +0000
>>> Nuno Sá <noname.nuno@gmail.com> wrote:
>>>   
>>>> On Sun, 2026-02-22 at 14:32 -0600, David Lechner wrote:  
>>>>> On 2/22/26 4:01 AM, Rodrigo Alencar wrote:    
>>>>>> On 26/02/21 02:16PM, David Lechner wrote:    
>>>>>>> On 2/20/26 10:46 AM, Rodrigo Alencar via B4 Relay wrote:    
>>>>>>>> This patch series adds support for the Analog Devices AD9910 DDS.
>>>>>>>> This is an RFC so that we can agree/discuss on the design that follows:
>>>>>>>>     
>>>>>
>>>>> ...
>>>>>     
>>>>>>>> represents a distinct signal path into the DDS accumulator, so the driver
>>>>>>>> models them as separate IIO output channels (all IIO_ALTVOLTAGE type).    
>>>>>>>
>>>>>>> Generally IIO channels represent the physical input/output, not the
>>>>>>> internal channels.    
>>>>>>
>>>>>> That is part of the reason for this RFC. Dividing those top-level modes
>>>>>> into channels allows for better organization, as they can operate together,
>>>>>> i.e., phase or scale can be provided by single-tone profile, while
>>>>>> frequency is controlled by the digital ramp generator (see Mode Priority
>>>>>> section in the datasheet). Also, it allows to explore the most of standard
>>>>>> ABIs like, scale, frequency, phase, sampling_frequency and enable.
>>>>>> Putting everything into a single channel would make things a lot messy
>>>>>> to interface with.
>>>>>>     
>>>>>>> Ideally we would just have the one channel here with a mode selection
>>>>>>> attribute. Documentation can tell us which modes use which attributes.
>>>>>>>     
>>>>>>>> This per-channel separation allows userspace to configure each mode
>>>>>>>> independently through its own set of sysfs attributes, and to
>>>>>>>> enable/disable modes individually via IIO_CHAN_INFO_ENABLE, relying on
>>>>>>>> the hardware's own mode selection architecture.
>>>>>>>>     
>>>>>
>>>>> Looking at Table 5 in the datasheet really helped me understand this better.
>>>>> I think this series could benefit from a documentation patch that explains
>>>>> more about how the driver works with some diagrams.
>>>>>
>>>>> So really what we have here are a bunch of digital data generators rather
>>>>> than a bunch of altvotlage output channels. And the same data channels can be
>>>>> mixed and match as the source for up to 3 different components of the output
>>>>> (frequency, phase, amplitude) depending on the priority rules defined in
>>>>> Table 5.    
>>>>
>>>> More bellow... But note that all of the (or most of it) generators are going to
>>>> be feed into a DAC. Your output is altvoltage but maybe we can treat the
>>>> internals as voltage. Not sure.
>>>>    
>>>>>
>>>>> Digital data sources are really more like a buffer in IIO terms than a
>>>>> channel. And before we added the IIO backend stuff, there wasn't really
>>>>> any other digital data source/sink that I am aware of other than buffers
>>>>> (but there are certainly a lot of odd corners of IIO that I haven't explored
>>>>> yet, so maybe I missed some).
>>>>>
>>>>> In a recent discussion, the idea of possibly needing a way to provide
>>>>> some userspace interface to be able to tweak knobs of an IIO backend
>>>>> was also brought up.
>>>>>
>>>>> Putting those ideas together, I'm wondering if we need some new channel
>>>>> type or even a whole new interface (e.g. a new sysfs directory like buffers
>>>>> and events) for managing these digital data sources/sinks that are not an
>>>>> IIO buffer.
>>>>>     
>>>>
>>>> But what would be that channel? In the end of the day, we typically have voltage or
>>>> current DACs and a DDS primary function is indeed to generate alternating waveforms
>>>> that you then typically feed into a DAC (and in some cases from the DAC into a
>>>> power amplifier). So the DDS is just part of the data/signal path. Anyways, not sure
>>>> on the new type and I think we already have the "blocks" in IIO for dealing with this:
>>>>
>>>> . frequency
>>>> . phase
>>>> . amplitude (raw + scale + offset)
>>>>
>>>> But you're right that maybe it's time to think in a better way to fit them together. 
>>>> Maybe a new type (as buffers or events) can make sense where the above are treated as, example, scan
>>>> elements. Maybe it's overcomplicating, not sure. It surely needs  discussion and thinking :).
>>>>
>>>> And spoiler alert, as you might have guessed already, the parallel port stuff is to be
>>>> used with DMA buffers (and IIO backends). At least, that was the plan IIRC. But Rodrigo
>>>> can confirm it.
>>>>   
>>>>> I think we've seen enough of these already to know that things like a
>>>>> "tone generator" and a "ramp generator" are going to be common and could
>>>>> share some standard attributes. 
>>>>>     
>>>>
>>>> I tend to agree. For example, there already some DACs (with dithering) that make use of a similar
>>>> interface (but with a custom prefix). Though the end goal is different, the interface is not that
>>>> far off:
>>>>
>>>>
>>>> https://elixir.bootlin.com/linux/v6.19.3/source/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
>>>>
>>>> Anyways, I knew this one would be an interesting one for upstream :)  
>>>
>>> For history buffs, we had a bunch of DDS chips in staging at one point and never
>>> manage to figure out the questions being raised here :(  They are complex
>>> beasts.  Clarity of ABI proposal and documentation is going to be key to driving
>>> this series forwards. In a sense the code is the easy part.  
>>
>> Does that mean that once good documentation is provided, the presented design can
>> be accepted? Even though data generators/sources might not be interpreted as
>> altvoltage channels?
> 
> I'm not sure yet :(  It's a pretty complex design and we haven't really come to a conclusion
> on how to handle this channel 'mixing' case.
> 
> If we did go this way, we'd need to figure out a way to describe the mixing part.
> So either we describe it as one channel (which is going to be really complex)
> or we describe it as multiple channels but add extra ABI to make it clear they
> are mixed into a single 'physical' channel.
> 
> Jonathan
> 
>>
> 

Some ideas have crossed my mind, like adding new option to the in_/out_
prefix for "internal" channels. But I it would take a long time to teach
existing generic userspace libraries/tools about this.

What has popped into my head just now is that perhaps we could do like
Rodrigo is proposing here reusing existing channels and standard attributes
as much as possible and add a new "subcomponent_of" attribute to provide
the link, similar to "current_trigger" for triggers.

This way, it would still work with existing userspace tools (even if it
looks a bit confusing). And userspace tools could eventually be taught
to present the channels as a tree-like structure with the main channel
and subcomponents nested under it.

We would want to spell out up front what all of the anticipated ways of
using it are. For example, I suspect eventually someone will want this
attribute to be writeable to assign a specific limited resource to a
specific channel. An I expect that we would eventually see something were
a single subcomponent is shared between multiple physical channels. In
this case, we would want the value of the "subcomponent_of" attribute to
be able to be a list.

