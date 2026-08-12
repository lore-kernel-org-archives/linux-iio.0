Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101DB4749C1
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786559106; cv=none; b=mmExP69Gsx9rbDqMxwC58pxJhhrOVCdI8/P1g6GVNAWxKGak9uSb2ITy2ytRsWTu8LBjm2p0hogSVhQ3kJheBk5qgK3jknbIpJNdMF/SQU/KfBSX3IsgIVkRATMaxc3JuIAyxos2w85zQEt15p50Fa+JIjNKYJOdEHi6P15a968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786559106; c=relaxed/simple;
	bh=rK+mXn7Ao2++xP76YmxA4SwjPDptQ817NOGwlmx4Iiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfABI/nQm7MkFEX1eZ+HzZ3QGm+cu3bnyqfUZerbqgNxrj6l764ZJFDuOwQXuFiXBj81J5wyvu8ZmVUCD5ardyvdoRg5HcCNqhWnQYzVkuTCAIMtF0s9oYJa5kwbw2wf3irp3CHL9l4jB7t8cpgjvU0B+TArx8EHOu2BuzlSsFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYgch8WT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYgch8WT"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso1532805b3a.2
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 11:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786559104; x=1787163904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Gu9W7rXgtb1+B1jXnvSAJ86MRbhcY3MT9l/KYXMDwQ=;
        b=FYgch8WT9xHF0j4jRRpGPAY7cV/uknv98wxLMvDaE5vExNbWAg+oB1b8eNpZ5xZZHg
         3Y1i+7flnWXyn1hN89L+V+N70VVqjZG+QsuT6JNKbulDI1a7/5E4ocA2porLtl9FReTr
         VVN8KKl12tOIzmeMIekk66FQHr0EWywiWE/MSIX0rSYMd4LvjU1yhNIPczudrAO7ab/f
         QHoa/0X+c/OC0WLeljwD91oYZB1ECiO0OE+6SwzgzrfB8W6c4+j/bM/GJ0jM0Kx2Fsmr
         SUhxYfm6xTn4rQaB5uOSsa7VHJ1iQ3FO3XmVyj1B/JUNGyFYG99gVJftWtLnP4nkX8np
         VrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786559104; x=1787163904;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Gu9W7rXgtb1+B1jXnvSAJ86MRbhcY3MT9l/KYXMDwQ=;
        b=Yr4X4svqG727OicXo0PcMTybC+DbBbpPsSdel+tF0VP7cMdYcjPpsgzKFme5zS9qoP
         Vzfk3B3qB35NTonOcYSCwAuAomiyhVctdbHKZcX3QujlScHFP1y6gSD1uzIqG/PxULxz
         PjRmHovMS+PPm/owm4PBiywS1RtN2uUnf+lbzdxgdlpxUvPnHlstOhxiIa2w6G76gvfo
         P++JIx9lLTNjD+/9jAQ0heLLx0HV05m8iykscaPNh3iL4ebk/hz/OysqiTn/nugqhB/3
         ttA+eDc034exq3tJJAP0ZTIw/+1LTDP2fUIkCwRg1Sp/ELHPVFqPI9eKDmqL6xaoXrDX
         wLjg==
X-Forwarded-Encrypted: i=1; AHgh+RoM5PPXY0r0+Ld/ISofVdz+I+5FqKGywHSh64r/ZdCxaEYWwz0kSN7Bi2G49zYfTc1J0FEnopFOXZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP/BFqW4NpZugb4GIMxTsRzfZdUujcXmhMXcDPYaiZxLeaXYR9
	QN2mYNtHTOvEghlYi3Q0dF+YMk+JuGFxxXrujgJ4Ipc76mn6m6k1AIii
X-Gm-Gg: AR+sD10mhAWRK8IlBHO12p9sTKpr8v/PV0spbKL8dfSLsEaT50hAfTqkRuLpBQBzjTy
	F8C+nGOP7s96fCSki9h9hVUuCKuufEsGM6UI4OEmbA82N6cZNVx8svpAEYzALsCgBqVLqD48WzG
	S/4hnkrDC0fZ0lIEyCCVqFz/mHEYrBFuO6oc8QQcgJV5RsHT7ciNJ+wl8WorIak4P2k62Wd/4MD
	8lQ3MGO8ns3p7i7ld7ZbZHIaeMJw9Ei4rKv1W21Gg5cm2aMVjvgRQD361boDdW+oNvD9j9eRjzE
	GXqZt8YFkGl6rkC5ch3Mnsdmg/ReYNu7SshgU/fqxk6WVEmJmAvTKM7M+OmLw4M7/Tg/JLh48Qn
	0myes+sonFhLq6JPc+u6IrUrs5983wesCuYnSM8UVrKRN+hwc6MTWBvb/IT9iHIfFWC0XWB7Qzk
	wRfvpwvTGOjJt+vtGcZS/+sV9NzmXjp6Ma4DVHkPzXG9adW1E3CGxE2EO0tMa+bBPTmLC8NQ==
X-Received: by 2002:a05:6a20:e196:b0:3bc:5284:5445 with SMTP id adf61e73a8af0-3cc553180c7mr484009637.21.1786559103989;
        Wed, 12 Aug 2026 11:25:03 -0700 (PDT)
Received: from localhost ([2804:30c:4018:dc00:8be4:f5b8:4af1:4728])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31d6aec3947sm10639103eec.17.2026.08.12.11.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 11:25:02 -0700 (PDT)
Date: Wed, 12 Aug 2026 15:25:41 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, julianbraha@gmail.com
Subject: Re: [PATCH v9 6/6] iio: ABI: Encourage differential voltage ABI usage
Message-ID: <any6pe6PBSR1uCZV@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1785186980.git.marcelo.schmitt@analog.com>
 <959734dd1111f76c5928515b82dd17f3a9dff5c8.1785186980.git.marcelo.schmitt@analog.com>
 <20260812050051.4313cd91@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812050051.4313cd91@jic23-huawei>

On 08/12, Jonathan Cameron wrote:
> On Mon, 27 Jul 2026 18:32:18 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > So far, parts that could only do differential voltage measurements were
> > only required to have a consistent labeling of their channels by complying
> > either to voltageY or to voltageY-voltageZ ABI. Over time, code maintainers
> > came to the conclusion that the voltageY-voltageZ ABI is better suited for
> > differential-only chips as it provides a simple indication to users that
> > the channels measure the difference of two inputs.
> > 
> > Adjust the ABI documentation to recommend using the voltageY-voltageZ ABI
> > for chips that do only differential voltage measurements.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Hi Marcelo
> 
> Whilst looking at another series, I noticed we did something different
> again in the devicetree bindings for those devices that have
> restrictive muxes that means the positive and negative lines
> always change together.  For those we let
> 
> diff-channels = <1 1> 
> which tends to map to
> 
> in_voltageX-voltageX_raw

Hmm, that sounds awesome. Probably a much more accurate way of presenting the
channel(s) to user space. Wish I had realized that earlier.

> 
> I'm not sure if we want to explicitly call that out as an option.
> There is nothing in your new text saying we can't do that.

I'd say probably best to mention the voltageX-X case. These fully differential
inputs (that have the positive and negative lines changing together) are not uncommon.
Sure, let me write something more comprehensive.

It would also be best to use that notation for ltc2378. IIRC, it's okay to not
specify the ADC channels in dt if all channels have the same properties so no
need to update the dt-doc. For the IIO driver, we have the channel sysfs entries
changing name. Will send v10 in case there's still any chance to get it updated.
Also okay to wait for the next release cycle if possible.

> 
> Worth also noting there are short circuit parts where you
> really do connect both ends of the differential ADC to the
> same input pin. I think it can be useful for testing / calibration?
> 
> Jonathan
> 

Thanks,
Marcelo

> 
> > ---
> > No changes in v9.
> > 
> >  Documentation/ABI/testing/sysfs-bus-iio | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 5cc2e82c4997..7446e07b9ab2 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -162,10 +162,11 @@ Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		Raw (unscaled) differential voltage measurement equivalent to
> >  		channel Y - channel Z where these channel numbers apply to the
> > -		physically equivalent inputs when non differential readings are
> > -		separately available. In differential only parts, then all that
> > -		is required is a consistent labeling.  Units after application
> > -		of scale and offset are millivolts.
> > +		physically equivalent inputs when non-differential readings are
> > +		separately available. Even though differential-only parts had
> > +		been merely required to have consistent channel labeling, this
> > +		ABI is preferred over the non-differential one for those chips.
> > +		Units after application of scale and offset are millivolts.
> >  
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_rms_raw
> >  KernelVersion:	6.18
> 
