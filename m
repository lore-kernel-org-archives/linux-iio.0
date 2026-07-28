Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707DF409635;
	Tue, 28 Jul 2026 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273446; cv=none; b=ga5bfaycRuWokyza0mn/iPK68k/E6V9/UsjbH1YNbLvMn4SCbpKJh8iGWOOgRz5EjaqW3iNY/0zie06P1TA5t47ewZL5fhB3lr3dKa9viEqqVs6p1qmWrD2V+etZy5TNstTA6Ba/xb7JQNwGtKgQjecu2hJNhGrQJ4O8pHyxBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273446; c=relaxed/simple;
	bh=72f8biyVUgH335xMxu6GsNjwxPf4qtOV1/vFiyhG41w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HD+T1b56C9bxe82AlRIDyanHeXNyz6UCyizvqsynI4/8WM/PZ5aBbCl2uSGBK0Z6ZNN+1OKOdcknNycGbL0oOw7ynqp0JCSSdTx/XQodnPATFxKBGGJNpCn+zcVYx7d8baDudSwwDJ3AvZ2L3ZtfP0LZBHCkRxMG5dNTqff8xj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ga2S1uTO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ga2S1uTO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844401F000E9;
	Tue, 28 Jul 2026 21:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785273445;
	bh=RPYyzEACWXmL3B1yuWD9+3WsAbReeEdqc/tsPpB+Cz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ga2S1uTOGLy3klZKkkmwDKmf82X4HWiqyRgsDOjF7WDZFcYZhh4ME6B+Ts/Yhb9J/
	 GObH1TwC9F/3c6RLD/nCeGyaH6m0Xh4J+T5A1TomNDkk+ZHBiP8+ReNXGkNblMKXpi
	 yMNYfuIorUmEXBt/9b9ImwbwrIeqX0ybORU2LMs1fqXU6I4j1TJILZPtAhUZffBFET
	 C5vcZrunFh4NvOk3ROBZ91KqVRzGdmAloUdKR0LIQ4tpnIyAM6PgrTbJm64CvpEVrd
	 sGpbzpGAzmuGMircFkRwv7JZ+mKcjNskIjfEM5UBwGSQSLPQX1kPe+Rjvr3/18OV9C
	 /GOZKbJhaCwIg==
Date: Tue, 28 Jul 2026 22:17:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Janani Sunil
 <janani.sunil@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Mark Brown
 <broonie@kernel.org>, Marius Cristea <marius.cristea@microchip.com>, Marcus
 Folkesson <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Janani Sunil
 <jan.sun97@gmail.com>, linux-spi@vger.kernel.org, Kent Gustavsson
 <nedo80@gmail.com>
Subject: Re: [PATCH v7 2/7] dt-bindings: iio: adc: microchip,mcp3564: Add
 spi-device-addr
Message-ID: <20260728221719.7f668a73@jic23-huawei>
In-Reply-To: <20260728-patronize-thwarting-56fab2e11077@spud>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
	<20260722-ad5529r-driver-v7-2-7781cd74ad75@analog.com>
	<cb4098c1-4bad-4a11-9a6f-a833e554f197@baylibre.com>
	<20260725230739.63ff7000@jic23-huawei>
	<20260728-patronize-thwarting-56fab2e11077@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 17:00:55 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Sat, Jul 25, 2026 at 11:07:39PM +0100, Jonathan Cameron wrote:
> > On Sat, 25 Jul 2026 15:57:07 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> > > On 7/22/26 2:54 AM, Janani Sunil wrote:  
> > > > Add the generic spi-device-addr property to the binding and deprecate
> > > > the existing vendor specific microchip,hw-device-address property.
> > > > 
> > > > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > > > ---
> > > >  .../devicetree/bindings/iio/adc/microchip,mcp3564.yaml         | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > > > index 675319276197..de1ea289e7f5 100644
> > > > --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > > > @@ -80,6 +80,7 @@ properties:
> > > >      $ref: /schemas/types.yaml#/definitions/uint32
> > > >      minimum: 0
> > > >      maximum: 3
> > > > +    deprecated: true
> > > >      description:
> > > >        The address is set on a per-device basis by fuses in the factory,
> > > >        configured on request. If not requested, the fuses are set for 0x1.
> > > > @@ -91,6 +92,12 @@ properties:
> > > >        clocking of the device address (BITS[7:6] - top two bits of COMMAND BYTE
> > > >        which is first one on the wire).
> > > >  
> > > > +  spi-device-addr:
> > > > +    maxItems: 1    
> > > 
> > > Does it not make sense to all for more than once device connected
> > > to the same CS here? I would expect maxItems to be 4 to match the
> > > number of possible addresses.
> > >   
> > 
> > I think for this part their isn't a reason to aggregate.
> > No magic accesses that touch them all at once.  So this hits
> > exactly the point you raised about how we set the address for
> > more than one of them.  
> 
> No David is actually right here, and maxitems should be 4.
> Setting the address for multiple was already discussed I thought, with
> the property being an array and each compatible being used to determine
> the "stride" between entries based on the number of supported channels?

I don't think that applies for this device or at least to do so
is a major driver rewrite, not a simple binding change.  Probably we'd
just add a bus and hang the 4 instances off it. They are running on own
timing etc so we can't grab data across all of them in any sort of
synchronous way - the clocks will probably drift over time etc.

They are independent devices (think of them using spi-device-address
like an i2c address) -  so why have one DT node for up to 4 of
them?  Note this is different from the AD5529R where the design
is intended for them to operate as one single larger device.

Jonathan

> 
> > 
> > Jonathan
> >   
> > > > +    items:
> > > > +      enum: [0, 1, 2, 3]
> > > > +    default: [1]
> > > > +
> > > >    "#io-channel-cells":
> > > >      const: 1
> > > >  
> > > > @@ -123,7 +130,6 @@ dependencies:
> > > >  required:
> > > >    - compatible
> > > >    - reg
> > > > -  - microchip,hw-device-address
> > > >    - spi-max-frequency
> > > >  
> > > >  allOf:
> > > > @@ -159,7 +165,7 @@ examples:
> > > >              spi-cpha;
> > > >              spi-cpol;
> > > >              spi-max-frequency = <10000000>;
> > > > -            microchip,hw-device-address = <1>;
> > > > +            spi-device-addr = <1>;
> > > >  
> > > >              #address-cells = <1>;
> > > >              #size-cells = <0>;
> > > >     
> > >   
> >   

