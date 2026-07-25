Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A14945039;
	Sat, 25 Jul 2026 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785017268; cv=none; b=fojDvDx+ensG77AdB6EpD1Qt5jBibzgpPDVfNjd9x4IUrqREbXao37EvQ750K67aMXVJkMAfMR0S88MdzpTPkM5skHZuVdnDRSIKP5Nt68IIFrz94NuoWlInLQ5E4ix2IiKFr/aKh+thWdEIHTzOv3FGFWk5+A6ES3X/IOUtivY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785017268; c=relaxed/simple;
	bh=9hoBPLWjtW8H6/G9SFcJCKiStKt1yPcHqg7PfWX0t0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsEYY4riab2zyw5UUuENkgm9UNvzrnvpd5k53n8OHmm4nypthWDG7vBJbpVuv8Rs4UdwZ3xB2VgHbICHNZ5CVoiL0RHJIAWZQfxWWRog0WHfcVgF0IiNgA1nQjrp58nAxUuueuATPv3V9Owo8ONzJBgTtG8AipA/VS826DVp71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGCgcseY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGCgcseY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE75A1F000E9;
	Sat, 25 Jul 2026 22:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785017267;
	bh=Cv/aYRG/taYJih8iMhkHPxpMiNDEpXM4DMRQI2zjEUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cGCgcseYNOov8g8Z8+k9oG+97EsclrawqMLIDMamVf0YR0v4M6QLv8vit/hZg+gIs
	 XAq8xz5BfhgYtfEOrLm3I33WGN2kl8obaH0ATj5emNv4gI+wWGqy5YBqvgWMnvWQL2
	 /tVtNDr9SJJZJCnWMzY7wdwv3G4TW0vHAAzFKK3IaZGrCvTOWqJ59RfY9VknHJPSFs
	 kmSl50Pg0Fb7BkCz/jqiuJK6r6X9zZMNvvcNiV6sYTdEng3jTEaT45RgnB9TKB5nTS
	 CKxmRxQkZIrkI4tcsKSmjH79bvrpS/i/pkghq+YVsUNHyfD/84BJzvO5SLfVk53L/L
	 yi9z8wdRJiJ4w==
Date: Sat, 25 Jul 2026 23:07:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Janani Sunil <janani.sunil@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, Marius Cristea
 <marius.cristea@microchip.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Janani Sunil
 <jan.sun97@gmail.com>, linux-spi@vger.kernel.org, Kent Gustavsson
 <nedo80@gmail.com>
Subject: Re: [PATCH v7 2/7] dt-bindings: iio: adc: microchip,mcp3564: Add
 spi-device-addr
Message-ID: <20260725230739.63ff7000@jic23-huawei>
In-Reply-To: <cb4098c1-4bad-4a11-9a6f-a833e554f197@baylibre.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
	<20260722-ad5529r-driver-v7-2-7781cd74ad75@analog.com>
	<cb4098c1-4bad-4a11-9a6f-a833e554f197@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Jul 2026 15:57:07 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/22/26 2:54 AM, Janani Sunil wrote:
> > Add the generic spi-device-addr property to the binding and deprecate
> > the existing vendor specific microchip,hw-device-address property.
> > 
> > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > ---
> >  .../devicetree/bindings/iio/adc/microchip,mcp3564.yaml         | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > index 675319276197..de1ea289e7f5 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > @@ -80,6 +80,7 @@ properties:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      minimum: 0
> >      maximum: 3
> > +    deprecated: true
> >      description:
> >        The address is set on a per-device basis by fuses in the factory,
> >        configured on request. If not requested, the fuses are set for 0x1.
> > @@ -91,6 +92,12 @@ properties:
> >        clocking of the device address (BITS[7:6] - top two bits of COMMAND BYTE
> >        which is first one on the wire).
> >  
> > +  spi-device-addr:
> > +    maxItems: 1  
> 
> Does it not make sense to all for more than once device connected
> to the same CS here? I would expect maxItems to be 4 to match the
> number of possible addresses.
> 

I think for this part their isn't a reason to aggregate.
No magic accesses that touch them all at once.  So this hits
exactly the point you raised about how we set the address for
more than one of them.

Jonathan

> > +    items:
> > +      enum: [0, 1, 2, 3]
> > +    default: [1]
> > +
> >    "#io-channel-cells":
> >      const: 1
> >  
> > @@ -123,7 +130,6 @@ dependencies:
> >  required:
> >    - compatible
> >    - reg
> > -  - microchip,hw-device-address
> >    - spi-max-frequency
> >  
> >  allOf:
> > @@ -159,7 +165,7 @@ examples:
> >              spi-cpha;
> >              spi-cpol;
> >              spi-max-frequency = <10000000>;
> > -            microchip,hw-device-address = <1>;
> > +            spi-device-addr = <1>;
> >  
> >              #address-cells = <1>;
> >              #size-cells = <0>;
> >   
> 

