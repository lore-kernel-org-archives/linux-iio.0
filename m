Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28C6340283;
	Thu, 17 Sep 2026 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789615848; cv=none; b=bHTOlJNVim+dMINaFyIiuYT+kKdugdN49fbCehUOapoFlKyx8/nr19iK2P9O1Ey9bpvsCcePU9LFr8NxMrPr3mRnzqeOZYQhKjb4XRIiOkzJnzCKX0HB6btLyZ64YrLhFNzMufoG59EuRU/tNHvH1X3N2GpRbbgkPRialoIGmiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789615848; c=relaxed/simple;
	bh=Dn6E2yBK7kEygIb9Qi0GhSlfOkGfB/GdvTVUFJBqowI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cc6McErKS6g182AANZfNgyJf6DrCPtpaGuk0F1Jjj5af88cLVdj+KqJrTpuDjmOk6P9UbWgqk4hXlRtmZiFMkZeAI/9DXhEE21vyXr3WYZ/ek6lKn9D6s+j+yoS2SY4Bz8BjnLxBD/0cZdXUAQsWuAJk0HDmowcRTfSW+Mib4BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiRlGO2B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiRlGO2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221101F00893;
	Thu, 17 Sep 2026 03:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789615846;
	bh=N8InjZ6/ORC11SBQj7YIuoYb2957bHwGRZbEOmovL64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jiRlGO2BuJXDM67CWFuhWoX5LjEC+2xbYhDxYi04aMChwy50nQi9HCMeQQW6eh+LZ
	 iHTRmYN8isMAuJNdf6DJ9g/ibGLSmo7RljB1mklRjbclTyoNCE58HG7WoyD+ZVTnq9
	 QPLpAZ7vU2gh7Mt9o5VgxOK+7RqsyZFbb1wbSPzmlJb5K2X3n3y99d+ogPZZubugfS
	 ZOhLhy+1qL34upB7mWrxRylSoq3pZxUa5F39Q8civyfnYWLU4NsdJTq3SRLge8ujJ8
	 JW56EsDimNJVfL+UomAbnySI1L1QQ3lwoL/ABkwfTUhWdAs1+LFXAFN7Yw0L2M2Ans
	 EczZblmwGdz8g==
Date: Thu, 17 Sep 2026 04:30:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
 nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
 Michael.Hennerich@analog.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 09/15] dt-bindings: iio: adc: adi,ad4134: Document
 SPI connection mode
Message-ID: <20260917043039.6b9fc505@jic23-hlaptop>
In-Reply-To: <20260916160025.GA382310-robh@kernel.org>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
	<304d10f12a3418fbd5598160609a6eda09ed4100.1789494473.git.marcelo.schmitt@analog.com>
	<20260916160025.GA382310-robh@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 11:00:25 -0500
Rob Herring <robh@kernel.org> wrote:

> On Tue, Sep 15, 2026 at 04:14:44PM -0300, Marcelo Schmitt wrote:
> > Document how AD4134 chips are connected to the host SPI controller
> > according to different wiring configurations.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > Change log v1 -> v2:
> > - Set default for adi,spi-mode property.
> > - Added '#daisy-chained-devices' property.
> > - Documented constraints for adi,spi-mode + #daisy-chained-devices combinations.
> > 
> >  .../bindings/iio/adc/adi,ad4134.yaml          | 51 ++++++++++++++++---
> >  1 file changed, 44 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > index ea6d7e026419..012e09decf7a 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > @@ -131,6 +131,26 @@ properties:
> >      enum: [ free-running, gated ]
> >      default: gated
> >  
> > +  adi,spi-mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [ no-cs, 4-wire, one-channel-chain, two-channel-chain ]
> > +    default: no-cs
> > +    description: |
> > +      This property indicates the SPI wiring configuration.
> > +      * no-cs: The datasheet calls this "minimum I/O mode". In this mode, the CS
> > +        line is not used (tied to GND).
> > +      * 4-wire: Specifies a conventional SPI wiring configuration.  
> 
> Absence of this property should be conventional mode.
Hi Rob,

Unfortunately we missed this in the binding originally so we are left with the default
of what the driver did at the time.

I wouldn't be against merging a change in that default as a fix though if we
don't think this is yet in heavy use (merged in 7.0, but given not a complete
feature set yet, maybe?)

Jonathan

> 
> > +      * one-channel-chain: In this mode, the DOUT0 line of one chip is connected
> > +        to DOUT2 of the next chip upstream in the chain. Only the data interface
> > +        of the upmost device in the stream is in direct connection with the
> > +        digital host.
> > +      * two-channel-chain: In this mode, the DOUT0 and DOUT1 lines of one chip
> > +        are respectively connected to DOUT2 and DOUT3 of the next chip upstream
> > +        in the chain. Only the data interface of the upmost device in the stream
> > +        is in direct connection with the digital host.  

