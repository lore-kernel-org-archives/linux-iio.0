Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793464204;
	b=eIcADBCOSiQlSGhld9AoDs+wBx+Mpfup4F8GizCP/cfrGsdTP+SB8mtO7iXyIaznEvfb
	 H2//MXUuNvyt0WNI85fkA8Fatptq+cqmztTvTe5DtzfbZ0zSYkg+0Fvi/++12VOevwO2c
	 BYd0W3mncr8UGYYsWZsP757cNc+vAwa15M+IizwIe72RMxjGHma+QzpxQKjkdI/OMQw2L
	 7KpYFm8I7HmUuJgWyiMgQwiQz7wpZ4FSLKKjUXSdahiqf5llljWiPu1jwRwlj1Pd1060Q
	 Zcsmuy4J+ndOw5lUvFwLHd+c5Vzw7CSy9INJTqxp57cryNfjEVUqXUQtiNuV2neg+fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793464204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=EgmEJPMkjbYM4FRPkppwPSirxq+mxfkqTc2AOCI0TeY=;
	b=31c+SDRuIXvHJjoAW5bhVUlRWkN7u+YuKNmf7BfPhu98ahRdqjljC2c67lQYErcu567y
	 yQZ6+dCvVETY4KVhcC05Hy+r4axzotSMcO8kfcgPFnTQzp6Z3M264SZwXalSQ15twIJJp
	 R0ktRHputCPClKQDjCFS/2Jjdc+/eJTWUaK0HUSdU2BtOcSWrnVxXP0N0rItrr/ee1pnW
	 e0JZIppBcBai3bN+j14MBUsvJuXmJF/rwckZlzbnvo3T7H85Mxqo28niOUV2pE6yeYjUZ
	 QKdkZKDcCl/CW77zK7owP5Yw1wvBYPfWyF0PtaA0cL/Uv1dpsoDl1faxRc+rqH70NrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NaCaOq1I;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2B606A31E
	for <linux-iio@vger.kernel.org>; Sat, 31 Oct 2026 16:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47E2B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NaCaOq1I
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5c7d1fc8f9dso111726e0c.1
        for <linux-iio@vger.kernel.org>; Sat, 31 Oct 2026 09:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793464203; x=1794069003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EgmEJPMkjbYM4FRPkppwPSirxq+mxfkqTc2AOCI0TeY=;
        b=NaCaOq1IS4vwEHlRWQvnbsS9HsMF9dwaaD0vhkRKTrgIcVBZDkggWXU8/3tG46OTdm
         cpg6OM1czuebilGZOLupqWhc2EKGo3X/Gis5gz7rTdzJVzbdJIeV2LCJv1TWzJL5DEWN
         JxQeHBTv4vFWePfOxdUvRpDpzpHzgd+hrOSG3YEOlcvtJZa782VtaK0deY2K8j3uFQnW
         1XwmOXkCjWyWeI2h+QC3wE//RKwy9MhnGX1cOGQoLEfUxemm/XvK58do89hhvf6zn/eO
         gV/Uz0ZyhF7uGHPzptjbevWf6qPBT0ntpJg9jgGW0q1RNqoRMh4R/8+p5hkxDnnIkfuv
         8LHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793464203; x=1794069003;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EgmEJPMkjbYM4FRPkppwPSirxq+mxfkqTc2AOCI0TeY=;
        b=DIOwZ4gyLrKy0Xm+dWgxu4GFE8UNuwGwtE6EgW6LQLOixp78CCiLH3nnN+R7jmvQIR
         tsd7iGQIy2tV+ASz7Q6PqS4Di8bZzq1EBjiWFDuTcSZCUlKIfb86TWg01pIFNzMfdlGk
         bBlKpE0g6m7JVG08kBW5XnJdWnxZeRjhEh++rgwQS45aZhtJOiNRHbnHMFCcioD4XSam
         H2mJ5YOwV86URCzL+tpRg73aKo87bikYGku9AFRoE4E/08jCG2SlfPeHhw50or/VkeHx
         Q9anzoMu6VUO3uThOFQoIiMv3Rheb4hvL/ywMbVHR5CSFGcwPMJyFdhv/TRFpoMYas7U
         BvIQ==
X-Forwarded-Encrypted: i=1; AKwUvBykSU6iZ6JKxsNLGxVESCdwFvaGJ4nU6o+1kPKD+Tmw2lW+xJpcdP5QF9akrRAf0TvluZq0ghXFa8Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxuSmCPP0iE5mWZH6/4UZm+azSJIkAGdjjeWBua9Pm32bPdLLf
	KpOjYqSzyZ2Wwt3iF8a91HmWAR46Pd/an6BzDY9ES5V/s3NHrhxYM+z0W5ABgyUe
X-Gm-Gg: AYBFou0ObCIwAH0/iXSnMF6a2rmbbm1BKWZqlqy9ZFoVzWd/pFPjGZawZhBNkShLQyw
	DvyibKe+OAAfh/yTscqATbFyFS+9GX1iBKPt8XOKalWaUXYMR1w+flaz1X1GjScV5+RdaFw4LpO
	VQRl36HNt2Y6+n/M+dDL51DYHPA46eOngvy9c/xKVzJ3cJ7PMTn2amRkhUntgmRcVVqirmzcRDM
	c/6/gLqZLgJKp4BJiDsW7Vlz7GGFqXJcFjU/QBLnwD9GBca/ivfEWWK625M85NxEaTXfeI1PuqC
	b6qC7UA9FwPAGHphUO6V5d2mTE+1ehfcBpw//TWULxQPOLllUQ8O+zAfqVg2Z2DL6kOCNGECD9/
	i1HN8E9WARS8zQexHVfcKGu+d94Iw2cL16KNnmITnHYu1rYzIDRRomBT08BDQ6ZMw9DFTTi2gre
	UbiraAJsbqyQ1lljNxriOK4V7Ko7keJ5HbijmK9gn9xS3ha0FgfKSw35Ick5dVlQA8vtn1ob2e6
	LURiv3Let03hPe/w/0+7ulavNFwLORcWUBy4Wa+iZ6FRpRPmqqjEvNQiOShNOeYDhXT/bx59tP3
	XqlpYe6RmR96qF05ehs7KXmDHVestpYOO0R6/blBHU/Ay7d5/5VTnYMtTqVZAOKjLVn9zLN0
X-Received: by 2002:a05:6122:12b4:b0:5e9:2e3c:2f5 with SMTP id 71dfb90a1353d-5ec685631b9mr2836551e0c.2.1793464203129;
        Sat, 31 Oct 2026 09:30:03 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([177.112.152.97])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69caeccdsm6020716e0c.16.2026.10.31.09.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 09:30:02 -0700 (PDT)
Date: Sat, 31 Oct 2026 03:20:26 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux@analog.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	Michael.Hennerich@analog.com, nuno.sa@analog.com,
	dlechner@baylibre.com, andriy.shevchenko@intel.com
Subject: Re: [PATCH v4 1/9] spi: dt-bindings: Add spi-cs-composite property
Message-ID: <auWIqpIaegH+AWV4@JSANTO12-L01.ad.analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
 <e9308680e7b45ecf9ef2b6b2a752ffdd4d23b80c.1792435248.git.Jonathan.Santos@analog.com>
 <20261026020003.3f3fbe86@jic23-hlaptop>
 <20261027-colonize-primer-f994b88171a6@spud>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-colonize-primer-f994b88171a6@spud>

On 10/27, Conor Dooley wrote:
> On Mon, Oct 26, 2026 at 02:00:03AM +0000, Jonathan Cameron wrote:
> > On Tue, 20 Oct 2026 22:56:41 -0300
> > Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> > 
> > > Some setups combine several SPI devices into one logical device, with
> > > each chip on its own CS line. All of those CS lines must be asserted at
> > > the same time, so that one transfer reaches every chip.
> > > 
> > > Add the 'spi-cs-composite' boolean property. When it is set, every chip
> > > select listed in 'reg' is asserted together on each transfer.
> > 
> > To me it feels inevitable that we will see a device / combination of
> > devices that want groups of CS lines together and others independent.
> > 
> > Seems less likely we'll see more than one set of composite entrees.
> > Maybe this should be an array of values that match with specific
> > entrees in reg?
> > 
> > I'm not sure though.  Conor, Kryzsztof or Rob, any thoughts on this
> > or similar things that have arisen elsewhere?
> 
> Why does the property actually exist in the first place? Does the device
> driver not know how each CS should be treated?
>

Hi Conor, Jonathan,

Thanks for the feedback.

The problem we are addressing now: today the SPI core gives a driver very 
little control over chip selects. The main spi_device only drives the first
'reg' entry and the only way a driver can use the other CS lines is through
ancillary devices, but for individual access only. For aggregated chips 
(AD7768-1 in this case) we need all CS lines asserted at the same time, and 
nothing in the core lets the driver ask for that AFAIK.

In v1 I added a CS mask to struct spi_transfer, but that also needed a
lane mask to work, and after the feedback we agreed it was too flexible
and too easy to get wrong. In v2 and v3 I switched to ancillary devices
(each with a lane attached) for single-CS access. That covered
individual access, but there was still no way to assert all the CS lines
at once. The spi-cs-composite property in v4 was my way around that, 
letting the main device be the aggregator and using the ancillaries for
single access.

David also suggested two alternatives before that don't need any DT changes:

 a) Add a CS description to struct spi_transfer or spi_message, e.g.
    passing the ancillary devices whose CS should be asserted. This also
    allows dynamic CS selection within the main device. And since the
    ancillary devices are already bound to a lane, this is less prone to
    errors than the approach on v1.

 b) Add a new "composite" spi device, so a driver would have the main
    device, ancillaries for individual access, and a composite device
    for simultaneous access. The issue I saw is that the ancillary and
    composite devices are siblings and their CS lines would conflict in
    the core's CS check, so only one kind could exist for a given
    device, not both (without some more complex logic in the spi cs check).

I like the (b) approach, but we would have to bypass that sibling problem.
The (a) looks less harmful to existing projects, if everyone agrees I can
implement it on v5. Also with (a) I think we can drop the spi device
name for now (or not?).

Best regards,
Jonathan Santos

> > 
> > The most general case would (subject to it not working) smell like
> > 
> > reg = < <0x1 0x4 0x5> <0x2> >
> > 
> > Where intent is that 1 4 and 5 are meant to switch together and
> > 2 is separate.
> 
> I would expect that for this kind of device, the driver should know that
> the first 3 CS are switched together and the 4th is not. I'm not really
> sure what the internal representation should be, because if someone can
> make a device like this, they could surely also make a device where (to
> borrow your format) it behaves like
> 
> | reg = < <0x1 0x4> <0x5 0x2> >
> 
> and so on. But if those devices don't actually exist at the moment, and
> everything is either all together or all seperate, the API for this
> stuff in the SPI core doesn't have to solve that until a device actually
> shows up.
> 

Yes, this is a bit out of the scope and kind of complex.

> Worst case is something where there's a variable grouping of chip
> selects, e.g.
> 
> | reg = < <0x1 0x4 0x5> <0x2> >
> 
> or
> 
> | reg = < <0x1 0x4> <0x2> >
> 
> but maybe if that happens the thing to do is permit reg-names for that
> device, and again store the relationships in the driver rather than
> try to convey it via DT.
> 
> Cheers,
> Conor.
> 
> > 
> > How to do lookup on something like this is another question.
> > 
> > Jonathan
> > 
> > 
> > > 
> > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > ---
> > > Changes in v4:
> > > * New patch. This has been included because without an explicit property,
> > >   every device with more than one 'reg' entry would have all its chip
> > >   selects asserted together. That breaks devices that use ancillary
> > >   devices for the extra CS lines, so the composite behavior is now opt-in.
> > > ---
> > >  .../devicetree/bindings/spi/spi-peripheral-props.yaml     | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > > index 4894196c8f9c..456cb9095632 100644
> > > --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > > +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > > @@ -60,6 +60,14 @@ properties:
> > >        Delay in nanoseconds to be introduced by the controller after CS is
> > >        de-asserted.
> > >  
> > > +  spi-cs-composite:
> > > +    description: Some SPI devices can be aggregated into a single logical
> > > +      device by asserting all their chip selects simultaneously. When this
> > > +      property is present, all chip selects listed in the 'reg' property are
> > > +      asserted together on every transfer, treating the group as one composite
> > > +      device.
> > > +    type: boolean
> > > +
> > >    spi-rx-bus-width:
> > >      description:
> > >        Bus width to the SPI bus used for read transfers.
> > 


