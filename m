Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E2C4908D5;
	Sat, 25 Jul 2026 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785017095; cv=none; b=sVfPG/lGJEwUbpAQ9/SBVlfcVOZmYtRaqgDpWXCJ5xJPE3lPQP49/cOI/1RMxdSgGK/h/gQlSuaePtryFTcsF6vTjRaXQ3WLtXpMvmyf4JRiV52hFj3ar4hP8JuEIDyOZ8nj/7tIP8Cbah3sU/3jP6/DqbGJwsuhuDMFHCpdnJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785017095; c=relaxed/simple;
	bh=sBvP77nDqvs7b3/rasZlyhu8wl5UbFK1tgyQbe4JUlg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwZaQodcmfhfsh9RLpFHx7kIUisOZbmKV4ip9GR3vS7EkxyPrlueDD9wT7qU42P8a2trpo5+t7m99Xm5HQEZ0iqTSgTc2qKePj9VMyZ/6+dln+QL7Wjn9hZsp/ZlOtbsYkq1xr7qaJkkd3C5Ny8GBAbld7h0nwILz6Z9y/M+6W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kz1xxdVp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kz1xxdVp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E303E1F000E9;
	Sat, 25 Jul 2026 22:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785017094;
	bh=tsy/2HA8AH0lGrICc0FjsCAfMhHDa6b9pKycKEmlL4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kz1xxdVpFy6lwB7uwS/QxtM//bbPg4/mjyLDMKOi4z5DcqIVfIWJUawtBqyGKA+HQ
	 mbsfcLk4yh+kTDt3pUfn7x07hYBWkDu4wjF95/u0Lz0Kdors65DOUsQOr5qymNvqit
	 OYs131j+GzDQbdwEhgwlRXzqFf5ywAEkh8ppcJ4+6wBnt9bIVGHy6rCMJJ839K/d9J
	 McrF0tXUVwddQxR2ZmYNEjXoJE0YTH8RB7/LUYbFpgqtCrnVVADqAA8Vy5LuHZKe5H
	 N8rntdqOxKuWswOuRLg8T1fmgzx2qGDF5rP4w8fWW5RmoDH7Dp9A7jBSNCwjPFLtjF
	 30uN5+ws4nWAg==
Date: Sat, 25 Jul 2026 23:04:45 +0100
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
Subject: Re: [PATCH v7 1/7] spi: dt-bindings: Add spi-device-addr peripheral
 property
Message-ID: <20260725230445.60a445a0@jic23-huawei>
In-Reply-To: <e2118cfc-feef-4843-917f-844834ef4e60@baylibre.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
	<20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>
	<e2118cfc-feef-4843-917f-844834ef4e60@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Jul 2026 15:55:01 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/22/26 2:54 AM, Janani Sunil wrote:
> > Some SPI devices support sharing a single chip select across multiple
> > physical chips by encoding a device address in the SPI frame itself.
> > Add the generic spi-device-addr property for describing these hardware
> > addresses. The property is placed on the SPI peripheral node and may
> > contain multiple addresses.
> > 
> > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > index 880a9f624566..b59d047cf117 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > @@ -142,6 +142,13 @@ properties:
> >      minItems: 2
> >      maxItems: 4
> >  
> > +  spi-device-addr:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description:
> > +      Device addresses used when multiple peripherals share a single chip
> > +      select. The array allows one logical peripheral to comprise multiple
> > +      physical devices, with one address per device.  
> 
> "per physical device" for clarity.
> 

We may end up relaxing that again if multichip packages start doing this.
Fine to add that clarification for now. We can revisit when / if it ever
needs that relaxing.

> > +
> >    st,spi-midi-ns:
> >      deprecated: true
> >      description: |
> >   
> 
> If there is nothing useful the SPI core code can do with this information,
> I'm not entirely convinced that this needs to be a common property.

I think being common does make some sense from a standarization point of
view and it isn't obvious where to put it other than under spi.

> 
> And this only allows for one logical device. If we wanted to treat each
> address as a logical device (all with same CS), we would need #address-cells = <2>;
> instead where the DT "address" is two values, the CS and the device address.

Ah.  Good point for the adc@address or similar needing to match a combination
of CS and spi-device-addr.  Conor any thoughts on how this would be done?


Also feels like this series should update the one use of the microchip binding
in tree.

arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts

Jonathan
> 
> This isn't a nak or request for change - just putting my thoughts out there
> to make sure we considered it thoroughly.
> 
> 

