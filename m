Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289F7385522
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773049986; cv=none; b=jl3GlxZdywkuuJ3osY73tPbqGq5KDHrgNkVgwh8m69aJautFTQro2UjSgzI7iQcqLuTTNX555V6XuVpPvGKlpJg15lNJrnhnoIEgss7rXtIAZ9KtPZftTfXEObQomQrzVzt776Zy5LqkCXkmJmQTWIYRxr35wvxytYplz5x1GuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773049986; c=relaxed/simple;
	bh=/5VN1F9S2L32gZPlc5C5S3KHeYNMyzOQh7KWGnCcLQc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEAo2nsQ0tvaOkaYytAoxpDAx923Te0shBSw2CYZXoa0uQeBx8nsAtec8XGeqgdG1ARD1Raic5qAYn14b6SSmVryNNdZKo9NGYqvZURwBR3dFggMxyJMu1BAvGZqTX/SoiTMA5X5fRHErktQ/QwCkhzQU7av3HN2mIR+9O/ajkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XS72XvKL; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS72XvKL"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3598df39444so4961749a91.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773049979; x=1773654779; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HtRTYnyFX0fSoLC5XC9JrdYAZCbOcOn4vu9sOfqB5uo=;
        b=XS72XvKLCkQ5LUZ9GytSIGHmDVwV0FNw5zxG6YPcMQp47zqP8GDm+SjZ3bsjjzeOOX
         o1HOGZSABm/3cuTbFVLRqMWUprKfobU1PUXIwHHdgV42DMp8UJnAyXJPMtU4595hDXgB
         nezgbKqcBVA/B9cDEUhcOCjHCQt21TYpCOZ8N7Vf9Bu83NPMnjiYM/ujuBHgO//OTnNF
         iDy+Bd8Mq/uhjt+gkhiMH/CLABC/iSUFpDGYkY7VmqZrGaLxf50yeiq5kbIQ2TaAHEgS
         O4/6qwb4zbCofj4m2VoEMqBilCH46RUmStFzi7slu5WNM4GbVP6qPIlzMlveNHChI8JA
         4LwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773049979; x=1773654779;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HtRTYnyFX0fSoLC5XC9JrdYAZCbOcOn4vu9sOfqB5uo=;
        b=kQ+2O1NSE8kn04Mhp7RkkdnlB3LNIAY3wPVZeaPuXLm5YWWneC+X7hsVzUWXY5iOH2
         1ybNp+0b5zMGcbXt58fQ933+db4Vm6f4lRWC33an1FRcvF6rZMFFHYp5oaUP8cFPyy1q
         eMKvQGEDjPHbPeBgBLZ9+sWQ0etKKVsDZIh2/g84p2CQj7u+XFgw7skmpScAQWrFNQpV
         NJyDckE2QGXTUnLoYLcGmqNguPHzxS0bIm4xnVE7jybh9kNji1ORCFu0xgyq1JtkXW+Y
         oDx+Wv/Bifuwd9DlTcb2LS9MhcR7V741Wr1s8+TDEF8GuKXu+Su6k4yPW973xkwRdOuI
         xNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSLotRrou1FfnUGx+ftWFeSAC2NMNK7o+8vlthukS9U6UPQ7CusZmNCtYHziQsyTtO66X2RcA6oG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3KE3CpLNdEZ8ZNwTHNkkDCTQ0lRUCZjtWX/qtNMLgFkS7P+0g
	9IkLEsNEZ6cTR2TttBjlpyn1m9vVttgdV6UJ2qJpefIWI4tJ7neVzT5R
X-Gm-Gg: ATEYQzzrmyNtWmx/j+7Pbc0kiYO91eTlXRMBXBG2p59yhEMQnh3snw/W/XrxAZ4MCon
	Z7iQCF429TAdOITlnczV4XdglLgvlik/udUzTH5QNsfOb+vr65hsTmoc7Orxx2MX+AsMDSESZvj
	B+Sj3NSqvsv7AlMbPYCJpq4v5DIefsiAgcWBKmaYw3PCHQiIG0miLQp++zInjWRLNtzDOXK/weq
	7nhOhKgHVBaljDf+EkFEHDelqKSUBbEynYm2LL7hcxxRCtGz8fypbns2Db99mC0bSQtnQosp7Ix
	ZEYPBB1cZIAJXGun/k53se/YrkvV6+B4ZFmCpsg7MzyfPT/HGkAv7h6goQ57DHdx2LcARY1pqD4
	CtT4ekWsTPM0667JhRQP/7+ovJIMi5c/J8OCy/QFb8GMAM09pfkJ1lFtwl5JfOCjQmffO3/KbQ8
	XL/4mWzEnddPV4RVnwj8ngVyYaKtK9x5KRai8vxHXCMA/y8IzXbENAopKwcd0Ilf1Fz6SI8Seq3
	zoJnG3YtnctVUd67emZd+tXfB0G3DSpXyq5m74vlnJGG1Pd/wrcGDJHcMkR/g==
X-Received: by 2002:a17:90b:2e0c:b0:33b:a906:e40 with SMTP id 98e67ed59e1d1-359be21d409mr9470998a91.2.1773049979021;
        Mon, 09 Mar 2026 02:52:59 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d39238sm13583400a91.4.2026.03.09.02.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 02:52:58 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 9 Mar 2026 09:52:40 +0000
To: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, 
	Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 0/8] AD9910 Direct Digital Synthesizer
Message-ID: <ii3gz6t4ufaiznypykneeqrc2hgrrrea26pvyffhbr5ryx2u73@zar3awo4mvxh>
References: <bdc973e5-df74-48f2-8884-439b03565940@baylibre.com>
 <9392fea00a9c3b23d1bc9468faa1b3cc20904398.camel@gmail.com>
 <20260301133806.5e706756@jic23-huawei>
 <pohirub7gjqu7xtq5qakkmr3wlek2rgj6kdgltjvir6g4jwgbr@hmjflsplni4o>
 <20260307140953.46db3c19@jic23-huawei>
 <7cc67826-3a8a-4190-9447-62b7d68e4445@baylibre.com>
 <20260307165816.46a98d34@jic23-huawei>
 <zurbjiq5nqbcid5h6kfworkmhczigirkzsqqsczfkatpg3bbe3@t7ssv76d3t4a>
 <42fe94df-ff8c-49d2-9a03-7d00e48eb22b@baylibre.com>
 <20260308181234.2e7ac4b9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260308181234.2e7ac4b9@jic23-huawei>

On 26/03/08 06:12PM, Jonathan Cameron wrote:
> On Sat, 7 Mar 2026 14:01:14 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 3/7/26 12:54 PM, Rodrigo Alencar wrote:
> > > On 26/03/07 04:58PM, Jonathan Cameron wrote:  
> > >> On Sat, 7 Mar 2026 10:50:14 -0600
> > >> David Lechner <dlechner@baylibre.com> wrote:
> > >>  
> > >>> On 3/7/26 8:09 AM, Jonathan Cameron wrote:  
> > >>>> On Mon, 2 Mar 2026 10:22:47 +0000
> > >>>> Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> > >>>>     
> > >>>>> On 26/03/01 01:38PM, Jonathan Cameron wrote:    
> > >>>>>> On Mon, 23 Feb 2026 10:02:00 +0000
> > >>>>>> Nuno Sá <noname.nuno@gmail.com> wrote:
> > >>>>>>       
> > >>>>>>> On Sun, 2026-02-22 at 14:32 -0600, David Lechner wrote:      
> > >>>>>>>> On 2/22/26 4:01 AM, Rodrigo Alencar wrote:        
> > >>>>>>>>> On 26/02/21 02:16PM, David Lechner wrote:        
> > >>>>>>>>>> On 2/20/26 10:46 AM, Rodrigo Alencar via B4 Relay wrote:        
> > >>>>>>>>>>> This patch series adds support for the Analog Devices AD9910 DDS.
> > >>>>>>>>>>> This is an RFC so that we can agree/discuss on the design that follows:

...

> > >>>>>>>>>>> represents a distinct signal path into the DDS accumulator, so the driver
> > >>>>>>>>>>> models them as separate IIO output channels (all IIO_ALTVOLTAGE type).        
> > >>>>>>>>>>
> > >>>>>>>>>> Generally IIO channels represent the physical input/output, not the
> > >>>>>>>>>> internal channels.        
> > >>>>>>>>>
> > >>>>>>>>> That is part of the reason for this RFC. Dividing those top-level modes
> > >>>>>>>>> into channels allows for better organization, as they can operate together,
> > >>>>>>>>> i.e., phase or scale can be provided by single-tone profile, while
> > >>>>>>>>> frequency is controlled by the digital ramp generator (see Mode Priority
> > >>>>>>>>> section in the datasheet). Also, it allows to explore the most of standard
> > >>>>>>>>> ABIs like, scale, frequency, phase, sampling_frequency and enable.
> > >>>>>>>>> Putting everything into a single channel would make things a lot messy
> > >>>>>>>>> to interface with.

...

> > >>>>>>>> Looking at Table 5 in the datasheet really helped me understand this better.
> > >>>>>>>> I think this series could benefit from a documentation patch that explains
> > >>>>>>>> more about how the driver works with some diagrams.
> > >>>>>>>>
> > >>>>>>>> So really what we have here are a bunch of digital data generators rather
> > >>>>>>>> than a bunch of altvotlage output channels. And the same data channels can be
> > >>>>>>>> mixed and match as the source for up to 3 different components of the output
> > >>>>>>>> (frequency, phase, amplitude) depending on the priority rules defined in
> > >>>>>>>> Table 5.        
> > >>>>>>>
> > >>>>>>> More bellow... But note that all of the (or most of it) generators are going to
> > >>>>>>> be feed into a DAC. Your output is altvoltage but maybe we can treat the
> > >>>>>>> internals as voltage. Not sure.
> > >>>>>>>        
> > >>>>>>>>
> > >>>>>>>> Digital data sources are really more like a buffer in IIO terms than a
> > >>>>>>>> channel. And before we added the IIO backend stuff, there wasn't really
> > >>>>>>>> any other digital data source/sink that I am aware of other than buffers
> > >>>>>>>> (but there are certainly a lot of odd corners of IIO that I haven't explored
> > >>>>>>>> yet, so maybe I missed some).
> > >>>>>>>>
> > >>>>>>>> In a recent discussion, the idea of possibly needing a way to provide
> > >>>>>>>> some userspace interface to be able to tweak knobs of an IIO backend
> > >>>>>>>> was also brought up.
> > >>>>>>>>
> > >>>>>>>> Putting those ideas together, I'm wondering if we need some new channel
> > >>>>>>>> type or even a whole new interface (e.g. a new sysfs directory like buffers
> > >>>>>>>> and events) for managing these digital data sources/sinks that are not an
> > >>>>>>>> IIO buffer.
> > >>>>>>>>         
> > >>>>>>>
> > >>>>>>> But what would be that channel? In the end of the day, we typically have voltage or
> > >>>>>>> current DACs and a DDS primary function is indeed to generate alternating waveforms
> > >>>>>>> that you then typically feed into a DAC (and in some cases from the DAC into a
> > >>>>>>> power amplifier). So the DDS is just part of the data/signal path. Anyways, not sure
> > >>>>>>> on the new type and I think we already have the "blocks" in IIO for dealing with this:
> > >>>>>>>
> > >>>>>>> . frequency
> > >>>>>>> . phase
> > >>>>>>> . amplitude (raw + scale + offset)
> > >>>>>>>
> > >>>>>>> But you're right that maybe it's time to think in a better way to fit them together. 
> > >>>>>>> Maybe a new type (as buffers or events) can make sense where the above are treated as, example, scan
> > >>>>>>> elements. Maybe it's overcomplicating, not sure. It surely needs  discussion and thinking :).

...

> > >>>>>> For history buffs, we had a bunch of DDS chips in staging at one point and never
> > >>>>>> manage to figure out the questions being raised here :(  They are complex
> > >>>>>> beasts.  Clarity of ABI proposal and documentation is going to be key to driving
> > >>>>>> this series forwards. In a sense the code is the easy part.      
> > >>>>>
> > >>>>> Does that mean that once good documentation is provided, the presented design can
> > >>>>> be accepted? Even though data generators/sources might not be interpreted as
> > >>>>> altvoltage channels?    
> > >>>>
> > >>>> I'm not sure yet :(  It's a pretty complex design and we haven't really come to a conclusion
> > >>>> on how to handle this channel 'mixing' case.
> > >>>>
> > >>>> If we did go this way, we'd need to figure out a way to describe the mixing part.
> > >>>> So either we describe it as one channel (which is going to be really complex)
> > >>>> or we describe it as multiple channels but add extra ABI to make it clear they
> > >>>> are mixed into a single 'physical' channel.
> > >>>>

...

> > >>> Some ideas have crossed my mind, like adding new option to the in_/out_
> > >>> prefix for "internal" channels. But I it would take a long time to teach
> > >>> existing generic userspace libraries/tools about this.
> > >>>
> > >>> What has popped into my head just now is that perhaps we could do like
> > >>> Rodrigo is proposing here reusing existing channels and standard attributes
> > >>> as much as possible and add a new "subcomponent_of" attribute to provide
> > >>> the link, similar to "current_trigger" for triggers.
> > >>>
> > >>> This way, it would still work with existing userspace tools (even if it
> > >>> looks a bit confusing). And userspace tools could eventually be taught
> > >>> to present the channels as a tree-like structure with the main channel
> > >>> and subcomponents nested under it.
> > >>>
> > >>> We would want to spell out up front what all of the anticipated ways of
> > >>> using it are. For example, I suspect eventually someone will want this
> > >>> attribute to be writeable to assign a specific limited resource to a
> > >>> specific channel. An I expect that we would eventually see something were
> > >>> a single subcomponent is shared between multiple physical channels. In
> > >>> this case, we would want the value of the "subcomponent_of" attribute to
> > >>> be able to be a list.  
> > >>
> > >> Something along those lines might work. I'd not thought about the case
> > >> of one 'internal' going to multiple 'external'.  Otherwise I was wondering
> > >> if something informal related to labels would work.  We've done that where
> > >> we've been associating things like voltage and power measurement from a single
> > >> pin.  It's rather adhoc though.  Possibly we could roll it into a newer
> > >> more general scheme.  
> > 
> > Hmm... in this case, it sounds more flat where there isn't a clear channel
> > that would be the "root" of a tree relation.
> > 
> > >>
> > >> If the association is done as meta data attributes alongside existing
> > >> channels then as you say existing tools will kind of work, just need some
> > >> human understanding of what is actually being controlled until they catch
> > >> up with the newer schemes.
> > >>
> > >> Lots of ways we could actually represent the graphs.  Going to take some
> > >> figuring out!  
> > > 
> > > I like the idea of subchannels to create logical tree-structures. It opens
> > > up for other possibilities.
> > > 
> > > I wonder if the varying channel index would still confuse a user, even
> > > with this metadata attribute, like:
> > > - out_altvoltage0
> > > - out_altvoltage1
> > > 	- out_altvoltage1_subcomponent_of = out_altvoltage0
> > > 
> > > would there be a different way to name the full_postfix in
> > > __iio_device_attr_init() that would allow to keep channel index the same
> > > (e.g. altvoltage0 for multiple internal sub-channel) and still be
> > > compatible with userspace tools? I don't know, something like:
> > > - out_altvoltage0
> > > - out_altvoltage0_0
> > > - out_altvoltage0_1
> > > - out_altvoltage0_2
> > > 
> > > userspace tools would understand out_altvoltage0_0_frequency as:
> > > - direction: out
> > > - type: altvoltage
> > > - channel idx: 0
> > > - attr name: 0_frequency
> > > 
> > > and that would be a problem?
> > >   
> > 
> > I have a feeling that could be problematic for existing attribute
> > parsers.
> 
> Agreed.  This smells like extend_name and that caused all sorts
> of annoying problems for the userspace folk.
> 
> > 
> > How about using higher numbered channel indexes instead?
> > 
> > out_altvoltage100_* = physical channel
> > 
> > out_altvoltage101_* = subcomponent
> > out_altvoltage102_* = subcomponent
> > ...
> Have to be careful we don't run out of space for events.
> #define IIO_EVENT_CODE_EXTRACT_CHAN(mask) ((__s16)(mask & 0xFFFF))
> So we do have 16 bits hence this might work.
> 
> I'm not sure we want to make rules around this though.

Ok, I think we are reaching an agreement. With this, I think there
is room for a small redesign, i.e., having a root channel to represent
the physical DAC and child channels as follows (* on custom ABI):
- out_altvoltage100: root/physical channel
	- profile*: for profile selection
	- sampling_frequency: sysclk frequency value
	- out_altvoltage110: single tone channel
		- frequency: single tone profile FTW
		- phase: single tone profile POW
		- scale: single tone profile ASF
	- out_altvoltage120: parallel port channel
		- en
		- frequency_scale* or frequency_gain*: for FM gain 
		- frequency or frequency_offset*
		- phase or phase_offset*
		- scale or scale_offset*
	- out_altvoltage130: drg channel
		- en
		- destination*
		- operating_mode*
		- out_altvoltage131: drg upper limit channel
			- frequency
			- frequency_step*
			- phase
			- phase_step*
			- scale
			- scale_step*
			- sampling_frequency
		- out_altvoltage132: drg lower limit channel
			- frequency
			- frequency_step*
			- phase
			- phase_step*
			- scale
			- scale_step*
			- sampling_frequency
	- out_altvoltage140: ram channel
		- en
		- frequency: global FTW
		- phase: global POW
		- sampling_frequency
		- destination*
		- operating_mode*
		- address_start*
		- address_end*
	- out_altvoltage150: osk channel
		- en
		- scale: global ASF
		- scale_step*
		- sampling_frequency
		- pinctrl_en*

so I ended up with 8 channels (rather than the initial 5). Breaking up the
DRG channel, following the tree structure allows to explore more of the
standard ABI. I suppose that even with this, documentation is no less
important. How does it look?

-- 
Kind regards,

Rodrigo Alencar
