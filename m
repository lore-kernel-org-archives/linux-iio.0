Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6DB2628D;
	Sun, 19 Apr 2026 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776599230; cv=none; b=cSdMw/CxlpcU82Xvhmp+LRVWVIpRJeXXHG/EuytxKqJfqqbO0e25TzCTBMAT4JGEds7Iq+f/WNFixmZan9VM3HaDKDwa0F/DVp6S/mNuq5EIymdeKwKAYYNokZ0LskhvNdWJFYwp/M3zevGqrGGOdTyqkp+SZH/7hCVHc70uV+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776599230; c=relaxed/simple;
	bh=p8PjFK4m/ZNB+eG85BhAL7e42OvxjRbIgvS/IEZAL8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqp1d5JJAWIIAwSMjqhbxEQwyS0akZ5KYMmIM15ETqsHg7h/UDBLrgAl0c8jtIYBmg6lg+ERMz0DxC0gwhIkA1Z1oOrRwJaVdISqSfvdAyuViNtfnDJ/Ae6Jejg0fXik/dNorWNXdle4sZni56M6er2olouqoWp5ho9Ydy8Bjxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olUQvuQM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olUQvuQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6FDC2BCAF;
	Sun, 19 Apr 2026 11:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776599229;
	bh=p8PjFK4m/ZNB+eG85BhAL7e42OvxjRbIgvS/IEZAL8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=olUQvuQMishHCAxCFtC83e7ipQgNJLTqtBu/yfkNkfOxz9b8i5OVnVBF1NA3ZGjRo
	 ofqBpMx6Xaw1nRqQ/g7e7QqVlAxLilHXv+Y/M/zeuvIfsj/rrXVHvg7wfUT84jfb2q
	 kZ5iD2B2q2sw2IrT3nOQ1m0DChwlra3BcTE2D/EFAdv/kvSJ7Sk5zB11loBYp/Aww7
	 UGA3F1T2AJjKNOGrVecH3Mw/CDa94+sNH1YQnYfIbSZ43lqb3Oquir+s0sbfBFP7J9
	 nMYaPXGBVIK2jp1PCzE4QjUIpuOGgyoNTX4KoMZSKuLRL7h66SOK94TQ+2cqdy4GMD
	 RxZppjsNjR0HQ==
Date: Sun, 19 Apr 2026 12:47:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: David Lechner <dlechner@baylibre.com>, Piyush Patle
 <piyushpatle228@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: avia-hx711: add
 avia,hx710b compatible
Message-ID: <20260419124700.69c262b7@jic23-huawei>
In-Reply-To: <aeRlftUuHrTgz9OF@mail.your-server.de>
References: <20260418170549.312446-1-piyushpatle228@gmail.com>
	<23a00548-feac-4ce6-9a71-509b7636b372@baylibre.com>
	<aeRlftUuHrTgz9OF@mail.your-server.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Apr 2026 07:17:50 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Hi,
> 
> David Lechner <dlechner@baylibre.com> schrieb am Sa, 18. Apr 16:46:
> > On 4/18/26 12:05 PM, Piyush Patle wrote:  
> 
> [...]
> 
> > >  
> > >    Specifications about the driver can be found at:
> > >    http://www.aviaic.com/ENProducts.aspx
> > > @@ -23,11 +33,12 @@ properties:
> > >    compatible:
> > >      enum:
> > >        - avia,hx711
> > > +      - avia,hx710b
> > >  
> > >    sck-gpios:
> > >      description:
> > >        Definition of the GPIO for the clock (output). In the datasheet it is
> > > -      named PD_SCK
> > > +      named PD_SCK.  
> > 
> > Save the cleanups for a separate patch to keep the adding HX710B changes clear.
> > 
> > I'm guessing the existing binding for HX711 is quite old because it is quite
> > incomplete.
> > 
> > It has avdd-supply, but is missing vsup-supply and dvdd-supply.
> > 
> > It should probably also have a way to describe how the rate pin is wired.
> > 
> > And it should have a clocks property instead of clock-frequency.  
> 
> The real meaning is a wait time until the DOUT is stable. As a submitted the
> driver many years ago my suggestion of a wait time property was not accepted
> because it would have introduced a new property which didn't exit in those days.
> The suggestion was to name it clock-frequency because it already existed. This
> clock-frequency made the driver also a little bit more complicated because at
> the end we needed a waiting time and not a frequency.
> 
> Today i see there is as "wait-delay" property already introduced at other
> bindings. This would also simplify the driver a bit.
> 
> @robh@kernel.org, @krzk+dt@kernel.org, @conor+dt@kernel.org:
> Would this change in the binding be acceptable?
> 
> If yes, i could prepare a driver and binding patch separate of this patchset to
> clean it up.

You would need to maintain backwards compatiblity with the old binding.
Might be fine to deprecate it.

Jonathan

> 
> > It would make sense to have two clocks, on for XI/XO and one for PD_SCK.
> > The second one being optional because of sck-gpios.
> > 
> > HX710B has many fewer pins, so we will need an:
> > 
> > allOf:
> >   - if:
> >       properties:
> > 	compatible:
> > 	  const: avia,hx710b
> > 
> > section that sets anything for pins that chip doesn't have to false, like
> > vsup-supply.
> > 
> > HX710B also has a vref-supply that HX711 doesn't have. (Unless these are the
> > same thing by a different name?)
> > 
> >   
> > >      maxItems: 1
> > >  
> > >    dout-gpios:
> > > @@ -43,6 +54,9 @@ properties:
> > >        Definition of the regulator used as analog supply
> > >  
> > >    clock-frequency:
> > > +    description:
> > > +      Bit-bang clock frequency on PD_SCK. Keep the PD_SCK high time below
> > > +      the chip power-down threshold.  
> > 
> > I suspect that this was meant to be the crystal frequency (XI/XO), not PD_SCK
> > since sck-gpios already exists for PD_SCK  
> 
> see above
> 
> [...]
> 
> Best regards,
> 
> Andreas
> 

