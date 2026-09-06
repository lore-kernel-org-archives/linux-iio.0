Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B526F382F0F;
	Sun,  6 Sep 2026 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788722119; cv=none; b=G80tY3elR7HUMDbvB7J+DBHgJJKE25OBLYwKFcFs/hZOQc7mj2vtx44pOJ+W9mbX+t38SnMg4SEO2QkpQnaf/0X+yGrjJgSi0lopjilVVucT1ZEYsPk/6Kesbm3jijT0kme//YXg7nTWzY4+SUwYyrXLkSL5q+el4E5GWqFGfZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788722119; c=relaxed/simple;
	bh=kxQZ3Rthv1ensPTutVlNIwSBwZoEjRotnJDyRh91HaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5Yej4u7B1EsKhdMlWqbzpuNMwGxRMby3RHwEd9eMAKhbfxRbJEuvb4Jykb2dWZMr0wie1jQWcVN970dHz7gFJ6E1OpgdzugPDPsAF7RUIEsm+JAYvp9XZYkj5cFYk32ax1aOJGoxE8hBa+D0TTvFpnwAkA5jKXssoQO9ubeUjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LojaOUVo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LojaOUVo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881B01F00A3A;
	Sun,  6 Sep 2026 19:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788722118;
	bh=TU0T/yFo/yE1g8awt3EdtgGPNQ2JS65tA/n50gc+o2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LojaOUVozJ3bNO9JFrScRwnnV5zQGZVtsudtm/wgxv6iI0TvPwixwYjSt19qtBbJn
	 LI7sSSUDldqQ8Hv9PJ2tqX5alV/J1/hfczV3/tagkaHco+mHdgM7Xue3BjXhLWU6CK
	 TNxZ7qyYP7VlkieXIGENziD8/sVPIE5L5wVHtbtZP2iccsZeHL2SdA7ameRKwij+uo
	 SQgpQYur9xktM8bZLRWoD2I4JJ72HraN6A+4KUxwZu5XSB+d7XVZlqU38mkzFCVLns
	 /3KFgmeW4juFSX0Zz2N83Q1AK22J2Q8uP/uwPQreo2y2y+UaU7UvffFko6nyTH6wQT
	 SnIRKOZcImV0A==
Date: Sun, 6 Sep 2026 20:15:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
 nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org
Subject: Re: [PATCH v1 08/13] dt-bindings: iio: adc: adi,ad4134: Document
 SPI connection mode
Message-ID: <20260906201511.7ddbd0fc@jic23-huawei>
In-Reply-To: <apsufKf-EOvTfpwf@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
	<d9b759d29fa8ca12b6cf083e180b2556ca4533f0.1788368334.git.marcelo.schmitt@analog.com>
	<20260903-liquefy-prologue-9ec914cccf04@spud>
	<apsufKf-EOvTfpwf@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Sep 2026 17:47:56 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 09/03, Conor Dooley wrote:
> > On Wed, Sep 02, 2026 at 02:24:02PM -0300, Marcelo Schmitt wrote:  
> > > Document how AD4134 chips are connected to the host SPI controller
> > > according to different wiring configurations.
> > > 
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---
> > >  .../bindings/iio/adc/adi,ad4134.yaml          | 22 +++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > index ea6d7e026419..d843c02a394a 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > @@ -131,6 +131,28 @@ properties:
> > >      enum: [ free-running, gated ]
> > >      default: gated
> > >  
> > > +  adi,spi-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/string
> > > +    enum: [ no-cs, 4-wire, one-channel-chain, two-channel-chain ]
> > > +    description: |
> > > +      This property indicates the SPI wiring configuration.
> > > +
> > > +      When this property is omitted, it is assumed that the device is using
> > > +      'no-cs' wiring. When this property is present, it indicates that the
> > > +      device is using one of the following wiring configurations:  
> >   
> ...
> > I'd also really appreciate a dts example for a system
> > with one-channel-chain or two-channel-chain looks, given the second
> > device may require different supplies etc. I have no impression in my
> > head of how the dt would be constructed, so I'd like to see wht you have
> > in mind.  
> 
> I've added the daisy-chain modes for completeness. It has the same semantics of
> ad7944 (daisy-)chain, despite the wiring being different. It looks like the
> supplies for the chained devices are simply assumed to be there (unless I'm
> missing something?).

I think the only cases we ever had of this in the past either used always
on supplies or shared them.  That is a bit of an annoying limitation so if
we can work around that it would be good.

> Though, now that I'm checking how to configure AD4134
> for daisy-chain, I'm not sure how we could set them in dt. For 3 devices,
> we would have
> 
>     spi {
>         ...
>         adc@0 {
>             compatible = "adi,ad4134";
>             reg = <0>;
>             spi-rx-bus-width = <1>, <1>; /* 2 lanes of 1 bit each */
> 
>             <supplies, clock, and other properties ...> 
> 
>             #daisy-chained-devices = <2>;
> 
>             adi,spi-mode = "4-wire";
>         };
>     };
> 
> But, the peripheral needs a register write to set the DOUT lines to 2-line
> daisy-chain and it doesn't seem to have register access propagation. So, we
> would need

That lack of register access propagation I think is the difference here from
devices we have supported chaining on in the past.  To me it sounds fairly
fundamental to any generic solution.

> 
>     spi {
>         ...
>         adc@0 {
>             compatible = "adi,ad4134";
>             spi-rx-bus-width = <1>, <1>; /* 2 lanes of 1 bit each */
> 
>             <supplies, clock, and other properties ...> 
> 
>             #daisy-chained-devices = <2>;
> 
>             adi,spi-mode = "4-wire";
>         };
>         adc@1 {
>             compatible = "adi,ad4134";
>             <supplies, clock, and other properties ...> 
> 
>             adi,spi-mode = "4-wire";
>         };
>         adc@2 {
>             compatible = "adi,ad4134";
>             <supplies, clock, and other properties ...> 
> 
>             adi,spi-mode = "4-wire";
>         };
>     };
> with adc@1 and adc@2 only set for register access. Even if not a dt-doc issue,
> that might (probably) lead to interface issues. The top of the daisy-chain may
> want to read from the other ADCs, but those could also be requested by IIO sysfs
> operations.

I think this bit you rewrite in next mail so I'll ignore.

> 
> >   
> > > +
> > > +      * no-cs: The datasheet calls this "minimum I/O mode". In this mode, the CS
> > > +        line is not used (tied to GND).
> > > +      * 4-wire: Specifies a conventional SPI wiring configuration.
> > > +      * one-channel-chain: In this mode, the DOUT0 line of one chip is connected
> > > +        to DOUT2 of the next chip upstream in the chain. Only the data interface
> > > +        of the upmost device in the stream is in direct connection with the
> > > +        digital host.
> > > +      * two-channel-chain: In this mode, the DOUT0 and DOUT1 lines of one chip
> > > +        are respectively connected to DOUT2 and DOUT3 of the next chip upstream
> > > +        in the chain. Only the data interface of the upmost device in the stream
> > > +        is in direct connection with the digital host.
> > > +  
> 
> With best regards,
> Marcelo

