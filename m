Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDFF3FA5F9
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815317; cv=none; b=KasjxQBSBLn8Z5DzwPdC/oA1Qlo2wChZXfmufKSfKj9OvyAVKHiFQAS+Y9KD8BC+e3sZ+QQcbYJ9AG56y9XL9ftHcj05ivUeCtVYGmwTBLPVvWwWhXWL7wajCR0kXG3XbQgUxfP8ytCc5I4+Tn37o0fbhSiBnHp52MQ9cQ6FlY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815317; c=relaxed/simple;
	bh=NA27NN5p6I8UVFw/S+uheebpnwu8UHqFyN0ql1ewMQ0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKRjS5W9y4FjuCERuSt/wj9Eoq9vcU4e+V2eXa55YxbgJ/fMEdXz6ZeyUfEFhfBz73M5U3brzrOhIsRe4EEqwDAXQ+mdsDAtR478mFrqJUlHmjgtmCwQqmSoNg5+9IVtf5y2NKrNZkw/Xe9v3UEiT9tro9Ea3RiUMa8g1JuVS7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWfXZnOd; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWfXZnOd"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-516d61baff3so51602571cf.0
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 10:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779815315; x=1780420115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hqQXdsbWsKeHXeHKrmCU/WFpGzKvYZdLxIaZX6nvsjQ=;
        b=YWfXZnOdYjaEcYcg6vbpApiL2SCc0x6gh2tPaOSRmFr9sPMJiewhqe2WWm8lXvkF7p
         TWKMNVURRZ2Wh50qL6D7hnqYBE0itBgs057Y4S/fZgVqjcANnk55LZZub3KqXMm7o5AE
         SfW7VlrobGR7UbPS9asYnHQA6g16ppgoSaEl3AIMNn4sj3dHtngklmd0FBJLsDAxSQji
         6jVsO/pLyLoW+uluW+dcnlbOsajkxa/tteXqbZ6mzY58ikNjFTyDwFwbCKe0ASB12bDs
         qMAc8MzySFZMkNxPVB15gETScxfAR0OhRsMW9rMmsqbk3A4xtCkJp7OggrnCXZxbXUBS
         EycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779815315; x=1780420115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqQXdsbWsKeHXeHKrmCU/WFpGzKvYZdLxIaZX6nvsjQ=;
        b=ldDQztHnMsBkzwm3Pvi430A+sx1tSt5WaL3x2MxNm9T89J1BeTnY7nOiEaPO2cZJZd
         HS8erE9+O+XThOC6IpDA/QdKBJgXMWJZ37pl+yDMy7MiftghasZfdDzPeNVe3T0p/auc
         g7SP6fUJKkvRlWa6RsBCpz3NWfvspzqUaFZWRoYytS0RCaU7N8pMsRWmaCOFCSHTebd2
         D+XzyapCliq9zMgVKBwirTM/pVXCkmtWSzpBH5PGoP4vtK8qROMiZp4/85EgoG4QX1Ik
         kBttllGgkfPMHCu0NN7U1q7kml8OFAQp7Lkx2CN4RA3KcK1Aip2k+idyeKYSj4CSNrOa
         dREA==
X-Forwarded-Encrypted: i=1; AFNElJ+bCs5d0Vxdjh4C41xgcZp81eQizIPUOucj+WrOh925uV1HPCRo1oUqzjQY5G3EGTgdbpfUEI0BMBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/cfuSbquzFyf4Lfx+rVo8AFdKEcvhlhkalce30zmj4Or1+kpn
	RSEaxc9oCnsm1IUsCSDoUFVb0kjzerzdCb7oYYPjS1fHtLYckW0UoCz7
X-Gm-Gg: Acq92OGcaa2blsLvMGCvg1APtPZ2Zl5LbLtXXG7W7zU5FTvZAr5X2fOoal7DC7RbETO
	H8N2fX3sMvigsG9lBxQA+0OJ5B82rkiodcdII+YzEHYdVhvtMET7Q63F3s3MITfTIohsqYSd5FJ
	eWqOs068Qn/MElatx37BNIS0w7haIZD5K0pwfTKg6YT+c4u5yYSHakk+Rl6k2c7sEiGgAympQrX
	4EIglULrMMmCoo8Mdwrk+nNXclGeamz3egocAR7eep2qtyh9IqRu+UAUjMp/yHAs0k6sCS2Liqr
	fsFcL9cYaRjei6MzrI4ky/KhowilrEHnsz66imszyEImWWTfsWOclW4yDYxFajog0WLRs95/miz
	LcfGsri/nVhafo8fb/hi7AntSBHpwHX6b4LQGaQi3NeGwTjx8MMhMCWo/gbLVkPg2OrWpuQncsB
	8Iqgd1gaHickwGCB6+3JO00gbLXja/3+WLm7hRRqk5dkCB+lcfWp7DEL4TJ8g2aeqY3LozRYPEV
	BTyxNCAXVr3W8f0EzjnoAosUyZmpVQm7c5xwNFKtwNIHN8QSw==
X-Received: by 2002:a05:622a:2445:b0:516:dfc9:8449 with SMTP id d75a77b69052e-516dfc99abamr233404601cf.59.1779815314663;
        Tue, 26 May 2026 10:08:34 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517069f2d2fsm26751821cf.3.2026.05.26.10.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:08:33 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 26 May 2026 18:08:26 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v5 12/13] Documentation: ABI: testing: add docs for
 ad9910 sysfs entries
Message-ID: <tdhw4z6gsuwdgg4olw5tipgqip7rtdzrl72divxvnwkc2mmpfo@7r4aceyvjvqm>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
 <20260517-ad9910-iio-driver-v5-12-31599c88314a@analog.com>
 <vqqvn2cgs3fbp5mq6xfac7iyosaqfrvgngqur4x355a3at7slo@ylrtd6fhi33a>
 <20260522192040.4e6b11eb@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522192040.4e6b11eb@jic23-huawei>

On 26/05/22 07:20PM, Jonathan Cameron wrote:
> On Wed, 20 May 2026 19:47:25 +0100
> Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> 
> > On 26/05/17 07:37PM, Rodrigo Alencar via B4 Relay wrote:
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Add custom ABI documentation file for the DDS AD9910 with sysfs entries to
> > > control Parallel Port, Digital Ramp Generator and OSK parameters.  
> > 
> > ...

> > This will become just offset with altcurrent channels. I noticed we have a IIO_PHASE
> > iio_chan_type, could we have a IIO_FREQUENCY too? Parallel port needs actual raw
> > frequency values in that case to be written to the dma buffer.
> > 
> Sure to IIO_FREQUENCY.  I thought we already did but seems not!
> The Phase one is a bit special given it's use in resolvers and distance sensors
> but perhaps it is the right solution here.
> 
> 
> > Then we may have buffer capable channels for the parallel port:
> > 
> > out_altcurrent120
> > 	offset
> 
> So that's the amplitude envelope control.
> 
> > out_phase120
> > 	offset
> 
> So this is the phase adjustment being controlled. 
> 
> > out_frequency120
> 
> And this is the frequency being controlled.
> 
> > 	scale
> > 	offset
> 
> > 
> > Problem is that the math for the actual frequency output is:
> > 
> > 	f_OUT = f_FTW + (f_RAW * FM)
> > 
> > where f_FTW is a base frequency (already scaled), FM is a
> > modulation gain and f_RAW is the contribution from the parallel
> > port, which is the already scaled:
> > 
> > 	f_RAW = RAW * f_SYSCLK / 2^32
> > 	f_FTW = FTW * f_SYSCLK / 2^32
> > 
> > so the above becomes:
> > 
> > 	f_OUT = (FTW * f_SYSCLK / 2^32) + (RAW * f_SYSCLK / 2^32) * FM
> > 	f_OUT = (FTW/FM + RAW) * f_SYSCLK * FM / 2^32
> > 
> > if I make:
> > 
> > 	SCALE = f_SYSCLK * FM / 2^32
> > 	OFFSET = FTW/FM
> > 	f_OUT = (OFFSET + RAW) * SCALE
> > 
> > That would work for a IIO_FREQUENCY channel type, problem is that both
> > scale and offset would depend on the modulation gain (FM)... I suppose
> > scale should be setting that and offset assumes it is constant to act
> > only on FTW.
> 
> I'm not that concerned about the coupling - it's a bit of a useability 
> issue I guess as not obvious which should be the fixed one.  Can we do
> cache written values and try and compensate to get a pair that is nearest
> to whatever we try to drive (in either order of setting them?)

Yeah.. or just document a proper sequence to write things, and indicate that
writing has side effects and one may read the other attributes to assert
the desired configuration. See that f_SYSCLK is also another configurable
variable. Maybe it is not really practical to cache all user choices and derive
all the other configurations as one changes.

> > 
> > I suppose we can keep altcurrent for other modes as phase and frequency
> > can be attributes (knobs) for them. However, in parallel mode we are effectively
> > pushing frequency, phase or amplitude values into the buffer.
> 
> Given that's the thing we are controlling. My Friday evening tired brain agrees
> that it makes sense to use channel types rather than adjustments on something else.
> 
> I'll think some more on this.  We've never had continuous (well digital
> so near continous) control of either phase or frequency before - it's just
> be symbol stuff with a couple of points to set.
> 
> 
> > 
> > The polar destination is a corner case, but can be solved when both
> > phase and altcurrent channels are enabled. When that happens we can
> > change the scan_type with has_ext_scan_type = 1, so the 16-bit data
> > bus is split between the two.
> > 
> For now I'll just nod at that!

I took a look at get_current_scan_type() and I faced the issue:

	user checks the scan format type before enabling the buffers

In this case I have a scan type that changes with the scan mask:

	altcurrent and phase both selected for buffer transmission would
	have the scan type changed so that the 16-bit data bus is split
	between 2 8-bit chunks.

That may also get confusing values for offset and scale. Then I decided
to have 5 parallel port channels with fixed scan_type:

	0. out_altcurrent120 - amplitude destination (16-bits)
	1. out_phase120 - phase destination (16-bits)
	2. out_frequency120 - frequency destination (16-bits)
	3. out_altcurrent121 - polar destination (8-bits)
	4. out_phase121 - polar destination (8-bits)

with the possible scan masks:

	0x01: amplitude
	0x02: phase
	0x04: frequency
	0x18: polar

-- 
Kind regards,

Rodrigo Alencar
