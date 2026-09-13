Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A81DD0EF;
	Sun, 13 Sep 2026 02:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267896; cv=none; b=KhDNFvqsMt7rvHtL54nxmcFdnoMuYNY2InaKne635k/azQZMdDHq6lm/rffxHYj7oix5ddR5Rj215CAA9ch4HmJ4xye33nOVkf0SGwasjv00c402CeUjgiEdJRCA5WaAJsZ9SRG+dsx15K5zXsveqLqCMF+N60k/FMAOrc3H/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267896; c=relaxed/simple;
	bh=odRcFUf8WOt2n1xjeZqHL3deYBqqqBZIorReFaAbSXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPQiOeS/iLTYfsKvYFLliTEYChbugzCN4co+AWdO64Mc9A/00D6gMu/DbnTjSjfWKsJZXv4TwlGhmSet0qz22g9ejdvjkRODMS+b4GoquLYzar5Rwuz+auy4UpzmfL0yYc5PnX2k4/RvLcMmF4hID29BV3myVb/gKRLmOEuRljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+6nKiT0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+6nKiT0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FA21F000FF;
	Sun, 13 Sep 2026 02:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789267895;
	bh=69FABYPOsdqsJNrLJcIOfj7YCLyrYCIw0DIwc2sain4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Z+6nKiT0K1LpLMqP9RvAlqZbbkRXX3zY+FuH/raaT05s8wuzNQPQwa6HpitqC7Ra/
	 C5tYAF/Mx0nWikfbHiuwMm/X4K9W72Z6K/tix5oJo7twR2XOanw3rFWayP+pdLzrGl
	 nZY9Kmb9Kp8s1u6ZKY4qqwc5LJnM4167OB+DD9Q8By6OR34/3YIWx4N9nfi0KAvxWJ
	 gpYQp3VtxMsACJyk4DIflk3QG+PG/1GX3NOqboHifKyKyXFe1NQi86O5MQs7lqFDUV
	 q0YbEdmJ8cjuS/JM9m/hlZkdMrVcmTgNY+/su8fXwjnjSBxjXHyGi1/y/vt4ikqoBd
	 yv9Py0iOPIVmw==
Date: Sun, 13 Sep 2026 03:51:32 +0100
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
Message-ID: <20260913035132.1fb50e6e@jic23-hlaptop>
In-Reply-To: <aqX90oniPRdsu5jp@gmail.com>
References: <20260912013912.51887-1-marcus.yu.56@gmail.com>
	<20260912013912.51887-2-marcus.yu.56@gmail.com>
	<20260913015652.029475d2@jic23-hlaptop>
	<aqX90oniPRdsu5jp@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 18:35:14 -0700
Chang Yu <marcus.yu.56@gmail.com> wrote:

> Hi Jonathan,
> 
> A quick comment inline.
> 
> On Sun, Sep 13, 2026 at 01:56:52AM +0100, Jonathan Cameron wrote:
> > On Fri, 11 Sep 2026 18:39:11 -0700
> > Chang Yu <marcus.yu.56@gmail.com> wrote:
> >   
> > > +    description:
> > > +      The driver current for the external LED connected to the LDR pin.
> > > +    minimum: 4000
> > > +    maximum: 258000
> > > +    multipleOf: 2000
> > > +    default: 12000
> > > +
> > > +  sync-gpios:
> > > +    description: |
> > > +      Optional GPIO pin that can be used either as a synchronization input to
> > > +      start/stop measurement or as an external start/stop signal for
> > > +      synchronizing with the connected LED.  
> > 
> > So the datasheet starts referring to using this for some level of sync
> > but then only actually treats it as as a gpio (maybe I'm missing something).
> > Any idea what that stuff about start/stop is talking about?
> > 
> > The only thing I can find about this is the device diagram in figure 13 that has the GPIO
> > wired to the led driver and the automatic measurement engine.
> >   
> That's what I got from the datasheet as well. They don't describe how to
> use the GPIO pin to perform synchronizations at all.
> 
> The adafruit arduino driver
> (https://github.com/adafruit/Adafruit_AS7343/blob/main/Adafruit_AS7343.cpp)
> is slightly more helpful - the GPIO in output mode signals when the
> spectral measurement starts. Unfortunately no information about input
> mode.

There is no separate control?  If so we can't use it as a GPIO as whilst
there is a control to set the state it will randomly get overwritten if
we do such a read. So to me sounds like that is there for testing the
connection and similar usecases only and we should not expose this as
a GPIO. Maybe input is possible but that may also have side effects.
So I'd be tempted to drop it from the binding - with some description
of why it is not there in the patch description.

> 
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - vdd-supply
> > > +
> > > +additionalProperties: false  
> > 
> >   
> 

