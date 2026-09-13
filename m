Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E96372B57;
	Sun, 13 Sep 2026 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319705; cv=none; b=HtFHqg8mkX50MhJDqW71IpFqhbb+JHslJpRlvBcE+GhwWRd80Nmw77o4riFfpWVEZbmWRNmrL1dEGmnTHo3Kk4+/zXxhr2vvxM+3EcPL1VXNUrrue793AUFXYjIhZInkRZEFnCjq6thHo9+F07nG4UEvi7h3tGfwuhc8BtDohz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319705; c=relaxed/simple;
	bh=VMXd+8O+nrJIrt1DXeop6McgNG1S6nCLtX13sL5fG/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e57sSRSevNDBVM9s7ERMuShCX9UPDUQf9I9iRGIuSVgwI/LtmT2+0nnjrMVSWBOaPdrI8DbMUeqalFwzx0FmRJR6XkltxXHR++Ig3rdQuMxsLvvnskJg0UvTvpm1gn7ZLNFc5Whq9ADdjQzuEIRXvUykSEW4+cSCYoGyQUke83c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfZ8pjri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfZ8pjri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F50C1F000FF;
	Sun, 13 Sep 2026 17:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319703;
	bh=4gHBDOzcBkUXQHNg33c8Xf79lj4KhzckDilx8uOCLas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QfZ8pjri5eg5Pi0N5v72ZSxX1L9IWTm7IGidM5eID6l3k7oxSz2fBUW8C2sXmm43t
	 Y0KGg2cgqgg7lAhCq4HIf4XnqVvPQp+9uosRB+y9VCFhi7/569z1qklqjQJJfn3Ohl
	 shbtWRlcjgEehwjhvcMwMOD4jJ8fy9wzNB3ueZom4HLr2NFsXRE1Rc6i59fXsi2dTE
	 2YJefEY+xRHCSFFX3RzUWsr5pQR7OEvzzvvK4YdEIf/YPKYxfP8V7j7qRjvGJPHmEy
	 jKduIsII+P1T2oim/tUZkZnZqExgacVbP0bUkcTP++/hTUKZe/btnrI7ifFaik8Z7Y
	 9kPyz3x8nJ9dw==
Date: Sun, 13 Sep 2026 18:14:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Shi Hao <i.shihao.999@gmail.com>, "Jose A.
 Perez de Azpillaga" <azpijr@gmail.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: add as7343
Message-ID: <20260913181457.4bb2ebbc@jic23-hlaptop>
In-Reply-To: <aqYWbWoBYaDJA9h-@gmail.com>
References: <20260912013912.51887-1-marcus.yu.56@gmail.com>
	<20260912013912.51887-2-marcus.yu.56@gmail.com>
	<20260913015652.029475d2@jic23-hlaptop>
	<aqX90oniPRdsu5jp@gmail.com>
	<20260913035132.1fb50e6e@jic23-hlaptop>
	<aqYWbWoBYaDJA9h-@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 20:20:13 -0700
Chang Yu <marcus.yu.56@gmail.com> wrote:

> On Sun, Sep 13, 2026 at 03:51:32AM +0100, Jonathan Cameron wrote:
> > On Sat, 12 Sep 2026 18:35:14 -0700
> > Chang Yu <marcus.yu.56@gmail.com> wrote:
> >   
> > > Hi Jonathan,
> > > 
> > > A quick comment inline.
> > > 
> > > On Sun, Sep 13, 2026 at 01:56:52AM +0100, Jonathan Cameron wrote:  
> > > > On Fri, 11 Sep 2026 18:39:11 -0700
> > > > Chang Yu <marcus.yu.56@gmail.com> wrote:
> > > >     
> > > > > +    description:
> > > > > +      The driver current for the external LED connected to the LDR pin.
> > > > > +    minimum: 4000
> > > > > +    maximum: 258000
> > > > > +    multipleOf: 2000
> > > > > +    default: 12000
> > > > > +
> > > > > +  sync-gpios:
> > > > > +    description: |
> > > > > +      Optional GPIO pin that can be used either as a synchronization input to
> > > > > +      start/stop measurement or as an external start/stop signal for
> > > > > +      synchronizing with the connected LED.    
> > > > 
> > > > So the datasheet starts referring to using this for some level of sync
> > > > but then only actually treats it as as a gpio (maybe I'm missing something).
> > > > Any idea what that stuff about start/stop is talking about?
> > > > 
> > > > The only thing I can find about this is the device diagram in figure 13 that has the GPIO
> > > > wired to the led driver and the automatic measurement engine.
> > > >     
> > > That's what I got from the datasheet as well. They don't describe how to
> > > use the GPIO pin to perform synchronizations at all.
> > > 
> > > The adafruit arduino driver
> > > (https://github.com/adafruit/Adafruit_AS7343/blob/main/Adafruit_AS7343.cpp)
> > > is slightly more helpful - the GPIO in output mode signals when the
> > > spectral measurement starts. Unfortunately no information about input
> > > mode.  
> > 
> > There is no separate control?  If so we can't use it as a GPIO as whilst
> > there is a control to set the state it will randomly get overwritten if
> > we do such a read. So to me sounds like that is there for testing the
> > connection and similar usecases only and we should not expose this as
> > a GPIO. Maybe input is possible but that may also have side effects.
> > So I'd be tempted to drop it from the binding - with some description
> > of why it is not there in the patch description.
> >   
> 
> Agreed. What does this mean for the LED then? For all intents and purposes
> it's controlled by only 1 register. It may have some interactions with the
> GPIO but since they are completely undocumented so we might as well consider
> them non-existent. IMO it probably doesn't warrant a LED subnode and
> led-max-microamp is enough. Maybe DT folks can also comment on that.

Agreed, given software is controlling the current we need that and there
isn't a lot more we can do.  I guess you have the Adafruit board. Are the
pins wired out so you can perhaps see what happens in practice?

> 
> > >   
> > > > > +    maxItems: 1
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +  - vdd-supply
> > > > > +
> > > > > +additionalProperties: false    
> > > > 
> > > >     
> > >   
> >   

