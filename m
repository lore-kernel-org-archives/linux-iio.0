Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A041E279DB6
	for <linux-iio@vger.kernel.org>; Wed,  9 Sep 2026 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967006; cv=none; b=J/WtH4b5uiB7IX7yJOwa/hZorotzTyDrdCC0G38hXA6UfR2dEogaoFOAWQLN3a7iuOe600vHbZuTcIbBBll2lzstQKCOqFQUo4FlTKx3usqoxOSL//511zhCACxCZh8/uZBua/NC67z0dwRJFLqk2CIYRhVpHVnub/+PJ4SKWUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967006; c=relaxed/simple;
	bh=B7yOS7AFBCg3al6xums4bDAZ9Ty0QaL4mBmh7fVXyGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtXmgN+riIBfBliVYDgToUYLpEN3mxsunX3C/ewIHbSgyOClEIrLQoyTey7VTSDLwI0GxPc27+uZgjBSMO7uU1f2J3LCtebzbloJwQY+EyH7G42zRQVY4+IWYS575NY+sw99deJI/1gjxcmYZeLgslxTsIKAHwv2iw+xDJacF4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFGozpJ9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFGozpJ9"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso6733031a12.3
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2026 08:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788967003; x=1789571803; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+mIv+3jvWNAwAJUgF1+CeaZ3tliEDl+/j1MWKvc5mi4=;
        b=nFGozpJ9Rpai0Y5Ckt6UjRKRifvuwMcfiSWQBF3pJ+V2Ofw0nNn//phat3fpJeAh63
         75gggud1a3Ro8Omtxbe0PfNljYT2MajXd2XLiVZwqbYrdrFhzX6bzzI5cHHjL/Mrpnke
         TtlcN40LXbnzUq8gdWRd7f6xl+RE+o7z4jmEZokKN4TK2I7fcymnsN26IAgmycQusKcl
         qb/VCNjFUQMKdeEnNygGcYpVVVCcwmL/YKOYWeC9wwj/yD9w2fOpbS+Y7xdUfkuk+JOe
         VMCqBxO1sDciNNsOLnoC4KmvGYkKpySYx7skPGoiKB0IhW61Bwk7hAwK/weFgEW+e0wp
         ngSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788967003; x=1789571803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+mIv+3jvWNAwAJUgF1+CeaZ3tliEDl+/j1MWKvc5mi4=;
        b=CStXROH0awq5Cvg6/WL93UClDUv0dps+FV22lWo/6Qx7jhoqEsRcrgMP+GN4VlCiI/
         IURqf7ygJxGPykjGxN6rydIV7Rf8oyNo/BdT4AHQpZ2O8TDvsVrlL1nyR87/HiW//MOL
         HYO66IodjmK/6l77CvXjUuAUAIjDe5peYxoc4V0/Hjas0h91pPJcmU3/vx7ONJbJ2r2/
         zcFld/YNRXq4zbU4wkaENzRauus3aSwAz8Ga/0KasApfUm4wFrIzVT2Pa9xqhzBGaRfE
         Bk17KdFqyX4DJudHEFO3h1Dcwy2FoWcj+S106ZfK3Y2r9lKspAMggrGohXGLY2DVAJOa
         pV9w==
X-Forwarded-Encrypted: i=1; AKwUvBzXghvWPCuA1TLtyKO8625Ms/r+Qu3J++n4Yj7ONP/bQSlA1F8h9WzccPQe4npverWc4n9gurl/nho=@vger.kernel.org
X-Gm-Message-State: AFuF++k8wpeFesjVobIAJtH4uZdTAVdlPE9VFnDJvcKF/erhpZgoSPk+
	JlTRiwgVvH8B6VDkaNlNbBl27fN0T9QiN5lEmvuYsyJBSDeu1k34Z4wb
X-Gm-Gg: AYBFou1PllRfztDoVxd23g8QPHyM8dd+i0swaqzcCanrjQuA1A7uyqDnCzpMfs/THMJ
	IXxzUHXyDdL4y5lACylGTndBydyH3IdnhS9idAC20YQIPnCH8aAbfnzhRIylpLHQBi4fiQqmnht
	fgLwW4ogiDNlbLuLS5DvWRzXDuU5oNFKF2yDKzdzdKfP0Jg2z+r5NyycsfX27m8e19JsEgRAiPO
	nzGZfq/y4cfmVoZ/T60LwbwHFGQnMDzjs5Uw/RLe44zaoIBFsD5kRK+cndHpD3B/hejtWaNNGS/
	jnL4JKPsEiZbB4ObSX9c/rV1Q0S1rtJSjba+RonJ1JLtiVR2XsGGlrJd+Ddxc4srbTkqxX5sbLa
	+GnSC9xpd9NGrgIeWccJMSZG8c4QugyUWTl1lzuiZbCRYTz1vFW+wuM8LCFHTcXJkzpivP48ExN
	I6RLi4ABmag3QHcUNS7Bgcb0awGi4YgE3C7To+LZC2DF1llN5ffFbEEO+g/V/U/+J8Y/xMSxeQO
	ZbC6A==
X-Received: by 2002:a17:90b:274e:b0:398:b1eb:136c with SMTP id 98e67ed59e1d1-39b2610fe62mr53548577a91.9.1788967002671;
        Wed, 09 Sep 2026 08:16:42 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b123731sm42144403eec.18.2026.09.09.08.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:16:40 -0700 (PDT)
Date: Wed, 9 Sep 2026 12:17:37 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org
Subject: Re: [PATCH v1 08/13] dt-bindings: iio: adc: adi,ad4134: Document SPI
 connection mode
Message-ID: <aqF4kfOCKcZhDZui@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <d9b759d29fa8ca12b6cf083e180b2556ca4533f0.1788368334.git.marcelo.schmitt@analog.com>
 <20260903-liquefy-prologue-9ec914cccf04@spud>
 <apsufKf-EOvTfpwf@debian-BULLSEYE-live-builder-AMD64>
 <aptA9HP82-ss45JF@debian-BULLSEYE-live-builder-AMD64>
 <20260906202630.64d8fa75@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260906202630.64d8fa75@jic23-huawei>

On 09/06, Jonathan Cameron wrote:
> On Fri, 4 Sep 2026 19:06:44 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > On 09/04, Marcelo Schmitt wrote:
> > > On 09/03, Conor Dooley wrote:  
> > > > On Wed, Sep 02, 2026 at 02:24:02PM -0300, Marcelo Schmitt wrote:  
> > > > > Document how AD4134 chips are connected to the host SPI controller
> > > > > according to different wiring configurations.
> > > > > 
> > > > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > > > ---
> > > > >  .../bindings/iio/adc/adi,ad4134.yaml          | 22 +++++++++++++++++++
> > > > >  1 file changed, 22 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > > > index ea6d7e026419..d843c02a394a 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > > > @@ -131,6 +131,28 @@ properties:
> > > > >      enum: [ free-running, gated ]
> > > > >      default: gated
> > > > >  
> > > > > +  adi,spi-mode:
> > > > > +    $ref: /schemas/types.yaml#/definitions/string
> > > > > +    enum: [ no-cs, 4-wire, one-channel-chain, two-channel-chain ]
> > > > > +    description: |
> > > > > +      This property indicates the SPI wiring configuration.
> > > > > +
> > > > > +      When this property is omitted, it is assumed that the device is using
> > > > > +      'no-cs' wiring. When this property is present, it indicates that the
> > > > > +      device is using one of the following wiring configurations:  
> > > ...  
> > > > I'd also really appreciate a dts example for a system
> > > > with one-channel-chain or two-channel-chain looks, given the second
> > > > device may require different supplies etc. I have no impression in my
> > > > head of how the dt would be constructed, so I'd like to see wht you have
> > > > in mind.  
> > >   
> > ...
> > 
> > Realized what I said doesn't make much sense. The peripherals can all have
> > the same configuration and thus share CS, SCLK, and controller SDO. The wiring
> > would be like the following
> 
> That mux in the middle is controlled how?

The mux is controlled by a GPIO. I ended up drawing the GPIO among SPI lines in the
connection diagram but the mux controll signal is not part of the SPI controller.

> I'd assume we still have separate chip selects and SDO/SDI shared. So I'd expect
> those to be on one SPI bus and the data to be going into separate buses
> (maybe all that can be hidden in the backend, not sure).
> 
> Or are you suggesting we are just letting all the chained devices see the
> same register writes?  That might work I guess with no ability to read any register
> state back other than for first device.
Correct, that's the proposed configuration for daisy-chaining. Since all
peripherals will receive the same write commands they shall all retain the same
register configurations (except maybe for error indication registers). Reading
from the topmost device in the chain would be enough to figure out the status
of the other chained devices.

> If you want to do the
> mux magic below you are going to need to treat it as an SPI mux - just with
> some lines shared. That means this device ends up split into multiple device
> (even if only one ad4134 which is messy).
You mean spi-mux.yaml/spi-mux.c? So the goal/intent would be to have one IIO
device for each peripheral in the chain? I think that would also work. Though,
the only device bringing ADC sample data is the topmost one so that would be
the only one buffer capable.

> 
> So to me this has a simple SPI bus, potentially connected to multiple devices
> and an IIO backend that deals with DOUT0 etc and the chaining.
Yeah, the benefit of having the mux is being able to connect both AD4134
interfaces to a single bus while being able to have ADC sample data on all SDI
lines as the diagrams in patch 13.

Alternatively, we could have something like

                                                              +-------------+
  +----------------------+                                    |  DATA HOST  |
  |       AD4134         |                                    |             |
  |                      |                                    |             |
  |Data interface  DOUT0 |----------------------------------->| SDI1        |
  |for ADC data    DOUT1 |----------------------------------->| SDI2        |
  |sample read     DOUT2 |----------------------------------->| SDI3        |
  |                DOUT3 |----------------------------------->| SDI4        |
  |                DCLK  |<--------------+        +---------->| CS          |
  |                ODR   |<------------+ |        | +-------->| SCLK        |
  |                      |             | |        | | +------>| SDO         |
  |                      |             | |        | | | +---->| SDI         |
  | SPI interface   CS   |<-------+    | +--------|-|-|-|-----| DCLK        |
  | for register    SCLK |<-----+ |    |          | | | |     |             |
  | access          SDI  |<---+ | |    |          | | | |     | TRIGGER     |
  |                 SDO  |--+ | | |    |          | | | |     +-------------+
  +----------------------+  | | | |    +----------|-|-|-|---------+
                            | | | +---------------+ | | |
                            | | +-------------------+ | |
                            | +-----------------------+ |
                            +---------------------------+

The downside of the above is we would need an SPI_MULTI_LANE_MODE_STRIPE to read
only from SDI1 to SDI4.

> 
> Jonathan
> 
> > 
> > ::
> > 
> >   +-----------------------+                               +-----------------+
> >   |         AD4134        |                               | SPI Controller  |
> >   |                       |                               |                 |
> >   |                       |                               |                 |
> >   | SPI interface    SCLK |<--------------------+---------| SCLK            |
> >   | for register       CS |<--------------------|-+-------| CS              |
> >   | access            SDI |<--------------------|-|-+-----| SDO             |
> >   |                   SDO |------->|¯¯¯¯\       | | |     |                 |
> >   |                       |        |MUX  >------|-|-|---->| SDI0            |
> >   | Data interface  DOUT0 |------->|____/<------|-|-|---- | GPIO            |
> >   | for ADC sample  DOUT1 |---------------------|-|-|---->| SDI1            |
> >   | data read        DCLK |<-------------+------|-|-|-----| DCLK            |
> >   |                 DOUT2 |<-+           |      | | |     |                 |
> >   |                 DOUT3 |<-|-+         |      | | |     |                 |
> >   |                   ODR |<-|-|---------|--+   | | |  +->| Offload Trigger |
> >   +-----------------------+  | |         |  |   | | |  |  +-----------------+
> >                              | |         |  |   | | |  +--| PWM1            |
> >                              | |         |  +---| | | ----| PWM0            |
> >                              | |         |  |   | | |    +-----------------+
> >                              | |         |  |   | | |
> >   +-----------------------+  | |         |  |   | | |
> >   |         AD4134        |  | |         |  |   | | |
> >   |                       |  | |         |  |   | | |
> >   | SPI interface         |  | |         |  |   | | |
> >   | for register     SCLK |<-|-|---------|--|---+ | |
> >   | access             CS |<-|-|---------|--|---|-+ |
> >   |                   SDI |<-|-|---------|--|---|-|-+
> >   |                   SDO |  | |         |  |   | | |
> >   | Data interface        |  | |         |  |   | | |
> >   | for ADC sample  DOUT0 |--+ |         |  |   | | |
> >   | data read       DOUT1 |----+         |  |   | | |
> >   |                 DOUT2 |<-+           |  |   | | |
> >   |                 DOUT3 |<-|-+         |  |   | | |
> >   |                  DCLK |<-|-|---------+  |   | | |
> >   |                   ODR |<-|-|---------|--+   | | |
> >   +-----------------------+  | |         |  |   | | |
> >                              | |         |  |   | | |
> >                              | |         |  |   | | |
> >                              | |         |  |   | | |
> >   +-----------------------+  | |         |  |   | | |
> >   |         AD4134        |  | |         |  |   | | |
> >   |                       |  | |         |  |   | | |
> >   |                       |  | |         |  |   | | |
> >   | SPI interface    SCLK |<-|-|---------|--|---+ | |
> >   | for register       CS |<-|-|---------|--|-----+ |
> >   | access            SDI |<-|-|---------|--|-------+
> >   |                       |  | |         |  |
> >   | Data interface        |  | |         |  |
> >   | for ADC sample  DOUT0 |--+ |         |  |
> >   | data read       DOUT1 |----+         |  |
> >   |                 DOUT2 |              |  |
> >   |                 DOUT3 |              |  |
> >   |                  DCLK |<-------------+  |
> >   |                   ODR |<----------------+
> >   +-----------------------+
> > 
> > 
> > So we would set them as only one daisy-chained device.
> > 
> >     spi {
> >         ...
> >         adc@0 {
> >             compatible = "adi,ad4134";
> >             reg = <0>;
> >             spi-rx-bus-width = <1>, <1>; /* 2 lanes of 1 bit each */
> > 
> >             <supplies, clock, and other properties ...> 
> > 
> >             #daisy-chained-devices = <2>;
> > 
> >             adi,spi-mode = "two-channel-chain";
> >         };
> >     };
> > 
> > Thanks,
> > Marcelo
> 
