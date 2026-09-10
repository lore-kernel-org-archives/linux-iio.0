Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D134F3AB496
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078690; cv=none; b=PDnrdIkTblj3flamtyQuBSwG8Ql5zRXTF8D8PCgKR9rUCerYdTYHJ0jXPMx1EpVtYYS6ckjkp3mCCP0yxacQkIQAqmiIMPrH+IeY7Vz/rDrsHgNGzoTc4nt9GKmhEXGY9lCB74S408Tq3xIUeoop7afHlp5FY6AXU/XqPTvEykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078690; c=relaxed/simple;
	bh=FpkQO46f/bUSNGTI5DtlovFLfVgBaVyf5ToZTa2Ns8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mu0SNEJJgcExlFJ2pDf1oFPWvowrzBM1C5+CsPqKNeFPqxEiLtQlJsuYqd33VBC+h7FhL19ji8vby69jlQaj14359SQ10f/qKqnCPAkj2C6STxbRBM0k1Zq4v6TB4HVeD+8MKfAhZOQDEwVht0hZfZ1rrYL+muZ6U10M3NkAA4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePo1guo0; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePo1guo0"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c7f4976d90so286126e0c.2
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789078688; x=1789683488; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7KhBqil+DvS5mAyeDQEIkthurB0wyhst9lKXAhOY2nc=;
        b=ePo1guo0LEwPc3anfuRADIHK6lye/xl3JcOzV/J09RRnBfWtYh0h7BY/pXpbkkpYp0
         IgWslCTeBffgP/fEg8JahiazBHAF273bpDrbBpBG6nFIZ1GmXw8NgRT9QtexZ55zvj64
         lfnjLWmxTtjVw39HJ5Qq+2jUP2qRF5tzI9EZ4ruQW8W4gDJkVoUhGRsW6GFz9JzokBu8
         72qM33gkVc3joniS0cNi+ZdTIz88Ch2lcZRR6ZQ65kuePJy0hdN6XqVU37iYtmJnurnZ
         bHl6rFzgJjKoPqdAJSfzJ4b0OPad6s9R1Ne91NX1BxyXR4GHFMYy2HT25Jjgqu7+LKsN
         DoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789078688; x=1789683488;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7KhBqil+DvS5mAyeDQEIkthurB0wyhst9lKXAhOY2nc=;
        b=CR245xTBvMut1U1D+df9YP8jN3zV2FLXve3xAs1FxP5W9FXbuTH/rx8zzyFmVEx3iE
         FqRrcQPr1hnxU/tGdQ6R5Srh3WpCrsSfCcfahVz3DMjTlOVaGcOJdZHzuxTo4PedTpdc
         UhjEHGCPzTiRi5IfspEb5jQ0cjzVGUrWQWpOUnObkZrH2PZV1vUnX16e1W676gBD61a5
         Ky3lzpP7UiUvAu+79ny1PrW8QbjXrIXa0kAMs5jgMjvhwFzDrMY5I7PN77zq40B9NQoW
         ViooJaEs0kiVUqI//jGVAO7CNokOlzUcx0TcHYDrhhGcKRDshn7FKuk+sPp4ZLkHd96i
         Vr/A==
X-Forwarded-Encrypted: i=1; AKwUvByAOkPH7u0OBI3EEt6qandVCcVX/HDA6KLeuynnXndRW8mEzE6SEZXRNYgB455q2P3iH3eDjfV/CRM=@vger.kernel.org
X-Gm-Message-State: AFuF++kQ3niuMT1OAe+0aO4zugHAwXvyZZPFrr66bjUKFNje5N+JpyIf
	ijLPKC+Vp0EfxPVSKfKLJD0ZAbuyvhhLYEvkWX2MhbCSwldt658jO2OZ
X-Gm-Gg: AYBFou1VT+cOjgGieCzMAWWa5uB1Gzl3KkEQFWBLtql/Git0t0HJFeRYk/hzyYrTXry
	p1MwUZ0qk0eRUSLN9OOtdcBiI91MgqaMFxC7OSuoLNrYY08iNJfda80oUO93wbH4xOI+wEFAWqF
	EZ3amv4t28gYS2Yo9sh4SkGAmywchsEdZhQ/wvQG59LikQkWYnxLyPEffGcYJ3ezYUgkxK058Z1
	iwv6IHZ9ort8OZFyLB5HNOOSB+LsLMAyMqhNeMm2xCzmGC9qY5Xhwj6Qvn8go+VwNld+pWB83EB
	BRTh40vU50jKceiooWMqn69/jWCaf4vh36ODtQ6oAmF8XoOd7ojV8Ft3pdkoG65in6aGue+aW/g
	SLbmiX7oxUFmwA1jjl38RASdG8OQK3+e/WNLf9LmhPtRaMWLT5nr6W5QlBQTCFa9cw0FVC7CQq1
	mEefLj5tIh8OVvH8tv4bpQBDhXJlS3CvcKphPBdunBG8QNg5Jm53l3a/Diso9bdFqkQ+UddeOAa
	ry86g==
X-Received: by 2002:a05:6122:3787:b0:5c6:7f44:b001 with SMTP id 71dfb90a1353d-5c845d638e3mr1353063e0c.0.1789078687632;
        Thu, 10 Sep 2026 15:18:07 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c8470e7ef4sm827546e0c.9.2026.09.10.15.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 15:18:06 -0700 (PDT)
Date: Thu, 10 Sep 2026 19:19:04 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@analog.com, jic23@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org
Subject: Re: [PATCH v1 08/13] dt-bindings: iio: adc: adi,ad4134: Document SPI
 connection mode
Message-ID: <aqMs2CbWbhzCoDOB@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <d9b759d29fa8ca12b6cf083e180b2556ca4533f0.1788368334.git.marcelo.schmitt@analog.com>
 <20260903-liquefy-prologue-9ec914cccf04@spud>
 <apsufKf-EOvTfpwf@debian-BULLSEYE-live-builder-AMD64>
 <aptA9HP82-ss45JF@debian-BULLSEYE-live-builder-AMD64>
 <20260907-spectator-venomous-7528abe370d8@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907-spectator-venomous-7528abe370d8@spud>

Hello Conor, sorry for delayed reply.

On 09/07, Conor Dooley wrote:
> On Fri, Sep 04, 2026 at 07:06:44PM -0300, Marcelo Schmitt wrote:
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
> > > > 
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
> 
> Does this property actually provide value here? I assume it does because
> otherwise you don't know how many devices there are.

Yes, the number of daisy-chained-devices is needed to determine how much data
to transfer on ADC sample read. We already have some documentation in
Documentation/devicetree/bindings/common-properties.txt

> 
> >             adi,spi-mode = "two-channel-chain";
> 
> How does this interact with spi-rx-bus-width? Is the value of this
> consistent with adi,spi-mode? IOW, for adi,spi-mode = "one.." will there
> only ever be Dout0 connected to the host and for adi,spi-mode = "two.."
> will Dout1 and Dout0 both be connected?

For this particular ADC design, yes.
adi,spi-mode = "one-channel-chain" always expects spi-rx-bus-width = <1> (only DOUT0) and
adi,spi-mode = "two-channel-chain" always expects spi-rx-bus-width = <1>, <1> (DOUT0, DOOUT1).
Though, it is possible to have spi-rx-bus-width = <1> and
spi-rx-bus-width = <1>, <1> in non-chained setups.

Will make the constraints explicit on v2.
allOf:
  ...
  - oneOf:
      - required: [adi,spi-mode, '#daisy-chained-devices']
        properties:
          adi,spi-mode:
            const: one-channel-chain
          spi-rx-bus-width:
            maxItems: 1
      - required: [adi,spi-mode, '#daisy-chained-devices']
        properties:
          adi,spi-mode:
            const: two-channel-chain
          spi-rx-bus-width:
            minItems: 2
            maxItems: 2
      - properties:
          '#daisy-chained-devices': false


Best regards,
Marcelo
