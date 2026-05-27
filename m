Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E103B3D649C;
	Wed, 27 May 2026 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779906773; cv=none; b=HZ+xEloL1FB820mJ8PhU5nGjDoILXTkR5TphpHHLu2jHRFBDijaDhj5jHOqw22FRrfvZSSH53hcNA0ARd0TmFQgm4+mHiXSFesC/PHJ67/mDzrFKpm9FW2Cde18i1sXMhZsgOeSqDa+XpP6wnfeACrIg7GZSV5Q4cayBK3F42sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779906773; c=relaxed/simple;
	bh=3SmjBOjXXCuAaVGNMBKlr05T7DyebfqzBuFQEOibEbk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMZ6cwxLbZJH9jFvuRqldBC1J+UzGbXBz6R7ugW4Gd8r/QQJfIuVwXJLikjIzK0ANI42IB2cL8S9bnN+XZedtJDq9bIP+Rtlviz5a2pRAnOaV7n7gMCtOhdOZnzDLrZEz/xrH2upBtav88+EF6Oap1rfUO1S6uNn2Ue+s/DKFvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oc/9JH06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oc/9JH06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBCD1F000E9;
	Wed, 27 May 2026 18:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779906771;
	bh=AtkqO35UtTTwja2Dnv9yfIiRy6VHJUSdpTI3MAmFDm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oc/9JH06FTrPRFhmbAYT4+SaTepnzc/JwIZcXXgwyEZcqHCebfqufsPT8suc0b++k
	 tArO3sezCiW4YmEzQhTNmnHEK0ZQGZOM7xdoUqX0fMUaxjEarbBym3hkfqzBO/d8uS
	 fEsBmZ/vG8LP2MVsGfWU4z4Stmv7XxF9EHf26Plr8wRdVDUCu9CssD8FjNoExLXYQE
	 lNATDuXkvBEGbNMj8mxgd00uDQUtC7+RB+iJaoplX4jBShA9vMf9q0it+4eSHD7Z1m
	 peyxRCLclhAMT0ahQzCSRvFiEEQLrfbr6FdY1HZ/tVh0SoRA0dYiSHfcHHrm/LHmAb
	 k2cxbopdHA1BQ==
Date: Wed, 27 May 2026 19:32:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux@roeck-us.net, jdelvare@suse.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/4] iio: add Sensirion SLF3x liquid flow sensor
 support
Message-ID: <20260527193241.308f67b6@jic23-huawei>
In-Reply-To: <20260527143515.102794-1-wafgo01@gmail.com>
References: <20260524205112.26638-1-wafgo01@gmail.com>
	<20260526171214.750c2e25@jic23-huawei>
	<20260527143515.102794-1-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 16:34:58 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> On Tue, 26 May 2026 17:12:14 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > > 1. Subsystem.  Liquid-flow sensors don't seem to have a home in
> > >    mainline yet.  iio/ feels like the natural place for me, but
> > >    please correct me if hwmon (or somewhere else) is prefered.    
> > 
> > I'm fine with this type of sensor in IIO, but open to hear from others!  
> 
> Thanks - keeping it in iio/ for v2.
> 
> > > 2. Channel type.  IIO has no flow channel type so far.  The series
> > >    adds IIO_VOLUMEFLOW with _scale in litres per second per LSB,
> > >    so drivers reporting smaller units only need a fractional scale.
> > >    IIO_MASSFLOW (for gas-flow sensors) was left out on purpose --
> > >    happy to add it in the same series if that's more usefull.    
> > 
> > Would be good to have a little more detail on difference etc to have
> > that discussion.  Superficially I'm assuming this is a compressible vs
> > non compressible thing?  
> 
> Right - that was the distinction I had in mind:
> 
>   - IIO_VOLUMEFLOW: volumetric rate (m^3/s in SI, exposed as l/s),
>     well-defined for an incompressible fluid where the volume at the
>     sensor equals the volume delivered.  This matches all "liquid
>     flow" sensors I'm aware of (and the SLF3S family in particular).
> 
>   - IIO_MASSFLOW: mass rate (kg/s), the natural unit for gases because
>     the volumetric rate depends on temperature and pressure.  Most
>     "gas flow" parts on the market (Sensirion SFM3xxx, SFC, MFC
>     devices) actually report a "standard volume flow" (e.g. slm at
>     0 degC and 1013 mbar) which is just a fixed-density restatement
>     of mass flow.
Makes sense.
> 
> I left IIO_MASSFLOW out of this series because I don't have a driver
> needing it right now, but if you'd prefer I add it as a stub here
> (name + ABI entry) so the two siblings land together, I can fold that
> in for v2 -- happy either way.
> 

Nope. Good to discuss what it would look like in this over letter, but
the actual introduction needs to wait for a driver that uses it.

> > > 3. Subdirectory.  I put the driver in a new drivers/iio/flow/
> > >    since there is no flow subsytem in iio yet.  If colocating with
> > >    drivers/iio/pressure/ (next to sdp500) is preferred I'll respin.    
> > 
> > This is easy to change later if we make a wrong decision. For now I think
> > iio/flow is fine.  
> 
> Sticking with drivers/iio/flow/ for v2.
> 
> Thanks!
> 
> v2 is up, addressing the inline review feedback from you and Guenter.
> Dropping the RFC tag since the three high-level questions are
> answered.
> 
> Wadim

