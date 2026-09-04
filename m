Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1013F7AA8
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 22:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559555; cv=none; b=SV0xXN6Uvx9x6OG4K+Ib+5udit8ZBHcR2XsC4Q8JSr4IiNKvQM53qwp4XDq4rAw7nLSeWcGpieMInzkRMlGJ+YqnJ6a5Ju2BvbgRiX6pGrrgYe8Qm+Yq3rc7THyddK1PUnALBzvzTsp85yvnGVrEmlN6DBhoe94a4AKGEJdK5+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559555; c=relaxed/simple;
	bh=850zEUtf6eyvyz/n9N68rT2vZ1UP3UAE41iBMsS+5XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1jSe1wJUp9o0Yf/Xf80D2NM3k3UK7PMjYZEykW00d+ciKrPiggBKwnlnoZBi7I/0L4dRhg7HWUfk/eJOe22Q8e90cQTP2z1MyLCCvW5c7FuVTobyeT9qHxZwcb1yEKa+nkHasl3IRo+IcLSKtAePlIhAO+wwQbArWST8Ad4bC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD4ghcsh; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD4ghcsh"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-398b3d66515so1548785a91.0
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 15:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788559552; x=1789164352; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XIFIlwrf7HKsMVMmerm3tqy7zlt6phSJBKdQug2lmoM=;
        b=QD4ghcshkXXoJ8I2rBLxdX8vvh+Y+yJ063c/SOtvcdkzI9CEMdBp0Mtx7oFoiFjrDB
         JB2xTlfgJO1lP2ElAKRoKLiqMVlrIaGZK7FzA/LeEFTt8WiYjveUxj5D6l/jZl+33dUQ
         KviqxqbwWeTDWkUR+16EIvTF2NoZv52uUExcHa1L+h5niX1jvFj2/J3dIqYjqtTtw09j
         IwdYgElc56pPhfD6L7THN+4E/oDHh4KkeV6HN44ZXxKeklb6XeZW3FTARfCRy1HHZnza
         +l1vWuwDAZVIIYWsU+2JWNvzs+aDPkIbZxQzm+hXKhPGzDHkrmdGjFaciFW7gya+LGQa
         Sajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788559552; x=1789164352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XIFIlwrf7HKsMVMmerm3tqy7zlt6phSJBKdQug2lmoM=;
        b=SZ2rOv8jW7SZwKiagB5PWIMH7NjIzbYbRb80XrD1g00QeGOXmu7rdVOYErCApmZXbc
         s4/odr0LLOjX/Dj0VReuD8E0O143BJwivqdIXpnEL84G2LeuhASpgvMy+LDe9oPOFUfF
         zuuiI6fgPjNv5JQEFpD0Hs/Af6GNRG1ImJgRZ9aUtnxcLt5cUUy1wShAsBwtfZVWl2GX
         +MtxvRlUomlaqsvSPdx03K+8luLFLLOTICWTHf+pXJ5odS8+fwXAG/eEAOFjfDBQYCSi
         4VOZ46vVlj7FRhdooix9QqWV8ryJs4BTYZutc0BpRUtHIBelmyCISFfUsnORQg9MFt1g
         uJXg==
X-Forwarded-Encrypted: i=1; AKwUvBwpZbcGh847doONHdMtEF8oKAgaEQJ5vAPoLRNqBGcEoFMRARqsTQx53OMzhRia6vDNMk109CMdLME=@vger.kernel.org
X-Gm-Message-State: AFuF++ngv4qvb8002z5zcvjnjlTB5xlFmBwjd2c4EwXmDeaETsJHPRoa
	JUXyGWb0LOWCYHo3X+tZFQBxq6PTUIyTIJQxEJvx0MgBctlvwtFOXanM
X-Gm-Gg: AYBFou3xhiZZgqgAzxkBOIM0iBQHqwMX0AcBr0t3pDd9gSth8QZ7QDfK8t/HMK40/UV
	U8pOg7szSl/4LSU51sgFNSPt/N9oba07i4JuxZ/zn3QTmZFDYYwxywZukgQjSMxQYeF53A74pko
	zqFGVkcSvgYi5KlCOfFq1EG087Sl8tcP1k85zhWI3DSfYLHtSyr2dbWmhPabxMzYObngBQ4dzgL
	wCNKL4CsF/K/uWBlpk7XfsaR/De0cdSmbc20iqXlFI0FZ0/T2+xABoFrJpROk2SRHeXpjbVmCVf
	Bm5glDSwZyUQJLdP+H4r/oJw0tTJ2dml0LSMM5Bj04tdxam1UlqmGCNT+fMMunEko8Errvfvv0H
	k9PxqFslXHtKrIxmFN/rD9rkQCc7gwmzSo9yCx8nV2Lwnu0hPbRQdjoyeJqjmqQv98SgfM14IhB
	fT0tkpJbrhXFVpY7ybGWCi96dsNwhK/6B0GdEezzCw+6l0lfbbP/eDHUQ38kaIKSYYUefr
X-Received: by 2002:a17:90b:1a8f:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-39b2612ed35mr12168805a91.7.1788559551701;
        Fri, 04 Sep 2026 15:05:51 -0700 (PDT)
Received: from localhost ([2804:30c:94d:7300:da0f:c2c1:1aa6:43da])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a62be87sm8280458eec.6.2026.09.04.15.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 15:05:51 -0700 (PDT)
Date: Fri, 4 Sep 2026 19:06:44 -0300
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
Message-ID: <aptA9HP82-ss45JF@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <d9b759d29fa8ca12b6cf083e180b2556ca4533f0.1788368334.git.marcelo.schmitt@analog.com>
 <20260903-liquefy-prologue-9ec914cccf04@spud>
 <apsufKf-EOvTfpwf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apsufKf-EOvTfpwf@debian-BULLSEYE-live-builder-AMD64>

On 09/04, Marcelo Schmitt wrote:
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
...

Realized what I said doesn't make much sense. The peripherals can all have
the same configuration and thus share CS, SCLK, and controller SDO. The wiring
would be like the following

::

  +-----------------------+                               +-----------------+
  |         AD4134        |                               | SPI Controller  |
  |                       |                               |                 |
  |                       |                               |                 |
  | SPI interface    SCLK |<--------------------+---------| SCLK            |
  | for register       CS |<--------------------|-+-------| CS              |
  | access            SDI |<--------------------|-|-+-----| SDO             |
  |                   SDO |------->|¯¯¯¯\       | | |     |                 |
  |                       |        |MUX  >------|-|-|---->| SDI0            |
  | Data interface  DOUT0 |------->|____/<------|-|-|---- | GPIO            |
  | for ADC sample  DOUT1 |---------------------|-|-|---->| SDI1            |
  | data read        DCLK |<-------------+------|-|-|-----| DCLK            |
  |                 DOUT2 |<-+           |      | | |     |                 |
  |                 DOUT3 |<-|-+         |      | | |     |                 |
  |                   ODR |<-|-|---------|--+   | | |  +->| Offload Trigger |
  +-----------------------+  | |         |  |   | | |  |  +-----------------+
                             | |         |  |   | | |  +--| PWM1            |
                             | |         |  +---| | | ----| PWM0            |
                             | |         |  |   | | |    +-----------------+
                             | |         |  |   | | |
  +-----------------------+  | |         |  |   | | |
  |         AD4134        |  | |         |  |   | | |
  |                       |  | |         |  |   | | |
  | SPI interface         |  | |         |  |   | | |
  | for register     SCLK |<-|-|---------|--|---+ | |
  | access             CS |<-|-|---------|--|---|-+ |
  |                   SDI |<-|-|---------|--|---|-|-+
  |                   SDO |  | |         |  |   | | |
  | Data interface        |  | |         |  |   | | |
  | for ADC sample  DOUT0 |--+ |         |  |   | | |
  | data read       DOUT1 |----+         |  |   | | |
  |                 DOUT2 |<-+           |  |   | | |
  |                 DOUT3 |<-|-+         |  |   | | |
  |                  DCLK |<-|-|---------+  |   | | |
  |                   ODR |<-|-|---------|--+   | | |
  +-----------------------+  | |         |  |   | | |
                             | |         |  |   | | |
                             | |         |  |   | | |
                             | |         |  |   | | |
  +-----------------------+  | |         |  |   | | |
  |         AD4134        |  | |         |  |   | | |
  |                       |  | |         |  |   | | |
  |                       |  | |         |  |   | | |
  | SPI interface    SCLK |<-|-|---------|--|---+ | |
  | for register       CS |<-|-|---------|--|-----+ |
  | access            SDI |<-|-|---------|--|-------+
  |                       |  | |         |  |
  | Data interface        |  | |         |  |
  | for ADC sample  DOUT0 |--+ |         |  |
  | data read       DOUT1 |----+         |  |
  |                 DOUT2 |              |  |
  |                 DOUT3 |              |  |
  |                  DCLK |<-------------+  |
  |                   ODR |<----------------+
  +-----------------------+


So we would set them as only one daisy-chained device.

    spi {
        ...
        adc@0 {
            compatible = "adi,ad4134";
            reg = <0>;
            spi-rx-bus-width = <1>, <1>; /* 2 lanes of 1 bit each */

            <supplies, clock, and other properties ...> 

            #daisy-chained-devices = <2>;

            adi,spi-mode = "two-channel-chain";
        };
    };

Thanks,
Marcelo
