Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792808933;
	b=lmShpk5NAtefTLrNbXFvidWnqw0fafPvwdch4HQz0aO5rVZnD/EonvHvYexsQ5m5Wi1Q
	 BBjAtcsVRofduPusH+ENxcB880mUPpnrD4EI2Ann8t78YeoMyPqHIBxczQ2/2qe0JRAAn
	 FMvd/5RH6q/KFi18SoEw5GlnCvAuNSuDs/JkUN95XQuwpuuuNVlbd0auw6kmcXg3ZPSBU
	 aQF1zOQtGFipNigNUZY5gvdibL4Q4QWcfbo5cXAc5HOcdz45ENsCi4W6Bu8Sw9Y8T5Owl
	 +RCn4XRyZlYNs1R3UOXJvaFof+R5ORefeP5LxG3mg8xG5GMGO80UOm4V+SDBDA5oVpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792808933;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jDykHkr6tOhRuUWTmpi5zfGasj4fVNM/1U6BQikHSBI=;
	b=GaMAhusLNSu0HKylIjPes2xxrNl9n/cVK/wEy/DAuW9LITdQ2pljo22EvClzydXRue5p
	 bSvwc5hIjyBbC2eQY3lkQCKC2kbmwHdCdjardzpik1EoAMHoUpTIUbsSByUbRGWvNxncX
	 flvSwbolLDkf19MGUsP5mr4n//bAJ0CK/9BTbElgBDSnnzCGRnUV0Ybuzew3cuohMjOBf
	 N/bA2fmnNjw21Np5vGgY8FC1Y/Cp7i+pLmYndmji97EXj+FLVqyQKHYnQWB1hUCqL54ax
	 Rff1nlA2MknsQI8jcZiem/u4eZ2zKZKPMJwBe7lQLpm9HgI8BoyE+7kVeh0R3RwE4tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JcaI0f+B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431D6606A31A;
	Sat, 24 Oct 2026 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JcaI0f+B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AD21F01825;
	Sat, 24 Oct 2026 02:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792808932;
	bh=jDykHkr6tOhRuUWTmpi5zfGasj4fVNM/1U6BQikHSBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JcaI0f+B/E91v0gnvoY3Jw+JahkcOmJ+e73lvrzMxD9/8PnKq8iQXuFYnDtnuPSst
	 vj/GFPYotKWRv9OGA87pEZ+iQ+fKw+5XBMSrHHNV/hWHzEfBLKW5PNPSGfmv55rT6b
	 xdrzWB2Kq/mFLxMEhqr9+MJzEc4cFBZF1F85JemP6m56/HpOyhO8giBYRFxXiCNLpv
	 FcpGQdc/RfVqSi/c9CZzbHToGk9JzKp0nqR9M3eMxdGBIBNQmgOk9fmoGzhnlG0P8d
	 gA0HvWBC1BO/Np9HfayFFWGcPRoYPdMUIRLSafJSzRkKG1rwEcKEKrmasCluTalsZQ
	 V4kqrs+udTkmw==
Date: Sat, 24 Oct 2026 03:28:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <20261024032844.0d6210d9@jic23-hlaptop>
In-Reply-To: <SN1PR12MB25283EB260FD897BFE29C603A5632@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
	<SN1PR12MB25288BF227D6555AEE60DF73A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
	<20261023040143.2e7043bc@jic23-hlaptop>
	<SN1PR12MB25283EB260FD897BFE29C603A5632@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Oct 2026 00:13:08 +0000
Victor Chernyakin <chernyakin.victor.j@outlook.com> wrote:

> Anything I don't reply to I've addressed in v2.
> 
> 
> > Given offset is applied prior to scale. Is this in appropriate
> > units?  I'm not following that description.  
> 
> I believe the units are correct, but I've changed the wording so
> it's hopefully more clear what's going on.
> 
> > common convention to add the error condition to the exit one rather than do it
> > in here.  Then check ret after the exit from teh poll.
> > Tends to give nice code to read.  
> 
> I think I understand the change you want, but please check v2 to make sure.
> 
> > For a capacitance channel I'm going to guess that expectation is
> > wiring is such that only a subset of channels matter for a given
> > configuration?  It may be more user friendly to put that in
> > dt (see how we do it in adc/adc.yaml for instance).  
> 
> Does it buy us much to not expose disconnected channels? Whatever code is
> reading from the sensor presumably has knowledge of the configuration
> anyway (otherwise, how would it know what "channel 1" even represents?), so
> does it need to be protected from reading the disconnected channels?
> 

That was the argument behind exposing all channels in early drivers like
the max1363.  In general it seems to be more convenient to limit
to what makes sense, but it isn't an ABI requirement so if you prefer
it like this fair enough.

> > Interesting that you have these only for the single ends.  I guess they
> > are tweaks on the analog side?  
> 
> Well, the sensor doesn't allow you to set calibration values on
> a differential channel, only separately on the two channels involved.
> 
> > Putting that aside, the base unit of capacitance in the ABI
> > is a nano farad. The part is documented at 0.5 femto farad
> > resolution so I'd kind of expect a scale of only 0.5e-6.
> >
> > Perhaps the issue here is desire for a very high degree of
> > precision on the scale factors?  I don't mind that if it
> > is useful but with a documented 0.2% gain error I'm not
> > sure it is.  For next version add some reasoning for
> > why such high precision is useful.
> >
> > We frequently round scale factors as often they are swamped
> > by error / noise.  Perhaps that doesn't apply here.  
> 
> I think you're right that in this case the extra precision doesn't really
> make a practical difference, but does it hurt? We have to use *some* unit,
> so why not just use one that doesn't introduce rounding? To me, that seems
> like the default choice. It's rounding that I would expect to require
> special justification (like what you're doing by citing the resolution and
> error values).
> 
> Even if we decide that a given amount of rounding is okay for *this*
> sensor, imagine TI releases a new one that's a drop-in replacement but
> with better precision. We can't be sure that the rounding is still okay
> for this new sensor, unless we don't do any rounding in the first place.

There are sensors with that sort of level of precision, I'm just not
convinced they are ever going to get there for capacitance sensors.

The burden ends up on whether userspace code runs into any problems
with high numbers of digits. I don't mind them being long if not.

> 
> > I'd look at using regmap even though you only have a single bus. It provides
> > a rich set of helpers and the caching functionality that will save a bunch
> > of bus traffic.  
> 
> Ah... is that a strong preference in new drivers? That would be quite
> a bit of rewrite work...

Tends to end up cleaner and not really be that hard to do in a register
based driver.  I don't mind that much though if you prefer to not do
so.

Jonathan
