Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0BB3EBF0C;
	Sun, 25 Jan 2026 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769336536; cv=none; b=m27PMsXM8otb47UEE0qcBBC8IywjpXA4Ol1h8nNy6yQOGjdsN/bvFPAWH3DS5dmtGEXfWDIihLEY5d/D+cseanF4uWR+4AxAPppoS6HCLNom2790HvAe/edEjlojdYHBOoI2i4JC0suqGVw3ybhOre2PiFg4yyCBCrnIQsb4U0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769336536; c=relaxed/simple;
	bh=kPcLWa/o3rjsJMhWGoaV5KilA7EaTEWHRAIvHjLome4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxrMiB0BKsppbFLGYkjavLUwyaDAgRa+2cKw9oIWVnZWbTf2eJG4B27SsvWeYoOz5cDAVPZ0tvtAT0ZXCAHXXatpIdzi+yaIhofGKNauUcmEvDUWwwCSZQgsq6c2q/a+gFe/G3pzPsWB9nP1rxL9sb1o5VlcYPzZpeozOpcbHho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7mVYeeq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7mVYeeq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C3FC4CEF1;
	Sun, 25 Jan 2026 10:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769336535;
	bh=kPcLWa/o3rjsJMhWGoaV5KilA7EaTEWHRAIvHjLome4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q7mVYeeqOJ8GuQi3cJbvxZy3DkaOJA+wUm3UfAdnn2WCOOsq9sDMODT3gHaZKV8Vn
	 jXOy+X4bket6JZG4yDp7hM7haqKXrFh9QSPnxq96IqZtcGjCj1K7aUYkUgE+cdiuzM
	 PlWiEU0D79UB/Rp+kEN4S4aNsuAq0sqBynnfgKlfQWR+0rC17uVRhtMeYobV3J/6fC
	 AgI12ZoXqQnvzILuv0MOgnSAVVJTnb03fnfQUMw7vxQ60VpNktfOFuB8Them2KUpaV
	 hurCNCz4YMl2DAhWOkJBkjHGm/45roAaGHcokhE13pSJr7YMjYT/Jf/JoxT55omw5V
	 CLofBM5M0IWqQ==
Date: Sun, 25 Jan 2026 10:22:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 2/8] dt-bindings: iio: dac: maxim,ds4424: add
 maxim,rfs-ohms property
Message-ID: <20260125102207.37ce3501@jic23-huawei>
In-Reply-To: <aXNHeq9Fi1Ldf-oE@pengutronix.de>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
	<20260119182424.1660601-3-o.rempel@pengutronix.de>
	<20260119-turbine-feminize-9dcd5c86feec@spud>
	<20260123092819.6ae81211@jic23-huawei>
	<aXNHeq9Fi1Ldf-oE@pengutronix.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jan 2026 11:03:38 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Fri, Jan 23, 2026 at 09:28:19AM +0000, Jonathan Cameron wrote:
> > On Mon, 19 Jan 2026 18:27:52 +0000
> > Conor Dooley <conor@kernel.org> wrote:
> >   
> > > On Mon, Jan 19, 2026 at 07:24:18PM +0100, Oleksij Rempel wrote:  
> > > > Introduce the 'maxim,rfs-ohms' property. The full-scale output current
> > > > of these DACs is determined by external resistors (Rfs) connected to
> > > > the FS pins. The driver requires the physical resistance values to
> > > > calculate the correct current scale (Amps per step) for the IIO
> > > > subsystem.
> > > > 
> > > > Keep it optional to avoid forcing updates of existing DTs; without it
> > > > the driver cannot derive a correct IIO scale.    
> > > 
> > > I don't really follow the logic here, if the driver doesn't work
> > > properly without it, shouldn't it be a required property even if that
> > > means existing devicetrees get new warnings? Warnings are preferable to
> > > the drivers malfunctioning on those devices, after all!  
> > 
> > Agreed. The driver can paper over holes or I guess we could provide a default
> > if the datasheet has some reference value or similar?    
> 
> No, this DAC controls the current. The current range is application specific and
> defined by the load resistors. Is it better to not provide scale if this
> information not available, guessing it will make things worse and
> potentially damage some HW.
> 
Then does this need to be a fix on the driver side?
Or are you just suggesting not proving the scale if we don't have enough info?
That's fine if so.

> > DT binding should require it.  
> 
> ACK

