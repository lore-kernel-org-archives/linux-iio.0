Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918FE34B195
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769593160; cv=none; b=afGCU5ktjv6KDsck1dbnX7svZ0HefYQn7pOSVC4oeyAC3Qvi/nqD2V1pMv+23RDPnoWbXkktuaUjcc3Fx00xQwmNbM3HaCevdeSG8aqbfMamOc3SaMRiWq3eI9QSpfE4ZyzxP3/EfshnZzvtXkpkDRoGnogtghkJL5zPfWgQ2cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769593160; c=relaxed/simple;
	bh=820pRQvBOUdwrO9VFOFFKHDDQblAqy5yU34fM/4UmhM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDn1aqhcYcE+wbQ4EKHm0/5tXq72/iKoJ0YU5sHHv32T7Wtf+HYdWszZ2cpXBKFtf2RSCLp8P/zW7jsvfi4/3V2PtHQb1GSc0RJGBE88FZiUfi0DAAfxBTa/hqx8z1rTY4YVHNiwG9n70ZAk+toGkbICw85MBVDmxax3w+bxOFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPf7vn5I; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPf7vn5I"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-480142406b3so45222735e9.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 01:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769593157; x=1770197957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YsYt9EtdSjP81eOEg7+PTgUVAYz631PUhGc1E+G2uEY=;
        b=BPf7vn5ILMtu3IHSiTLh11soD+66YnO3diYCo1HfNGadq90VPZSz54rLAcTEnyns2d
         3EjAU9rAImZ3D4ibUiOxCFI0rhCJ0j2QwJD5af3Q2dnwBEY9RhmCBNDiIfOU7pWHBlaX
         1DgYu9dwHTZCmPVze+fhz4sw1wza8czmqpmqtNbjCYB2B0UJ4qBNXAxqoW6PDd3O4fkp
         mET0HyB87s7F6qfJzC1JLjiLh09A7sdSilbeTv52pyJ2F2Jq4DlpeWQfwD3SqNOSUge3
         79ARBSu/AzHaBKd2qo5KqhSFlue0HbznLX05hTAVVbaQ6tj1Ao8Cctbiy1u/mwDA0E35
         rOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769593157; x=1770197957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsYt9EtdSjP81eOEg7+PTgUVAYz631PUhGc1E+G2uEY=;
        b=SZKb/MVJg1xG0xHJ8254igukv9xs2Ku+YCpa48cVp2/on3eaO9f1aFPso/FDDBcqUC
         0YBMpDfgiAStMAioQ6ASeUmQmWRH0/Iex3TrA7jhTCmKu5HdJ6DdO51nVfo6FLOoUkWC
         ccEYTcClpmXskcb04Drb4UbMSTaIlzeOaQ7XNbuN+LU6asm4qkqybrGumYdnfP3T5jVc
         PVmKlf1GeHhee/KdrHtmzEPuRzaFdrXz2kT6+8aKQJcXN7kY+wESDaPdN9YpHyVrvwID
         kii8fiox0ClnavcOsGIFpzApPhCGIAxnNmjUFt7eaqsMZjpe+Jf2s+xMVDA4Ji0JLNte
         4+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVEcxH8FHTZAcHja7RuvgoWbh/nILk0pJqX1A83TLxFQQUO6ki4evVsB7r7C3IHh8U44GhEMq8EeBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHgHWmHpuVRfxm4MgENDTiNULneYkmCZDSV+Q/O0V63qz5OIvd
	m0KL4agUHIomd60kpsZrplZyzjihtzMvy7Qa0gCNAQpjlifFTFURIJ9pLivMqA==
X-Gm-Gg: AZuq6aK4enF4A3LLbgkJ2yBX7d0V+dQdSgXL157ZUha7wtOkceOGUE/ZFL4SznAa7bX
	GW82USkCPXON10aZL9LzRhf/Gk8ufNu+HHtRreJFS2IjgG8LaS8VX8D8GlCWiln2xdofsbTIQCz
	iTnqHkzefJ/pQ54y08KdAF5g0JLxsr4D8gjwABsB0yRacwvRlJzLUNIvkuXbi4N+IhQUcEjdNPi
	v2sWRxBrT+VexpvO2yIohWHvuc+NNOVRs2hx56AY+inK0DXWnhv6OM5st8z8PHlMyU3LY1cx/cr
	YLEu/0VhRPwwj+worW+XGswqP7l/dx6FmXOwmwKoUfPzOF4ILkkdNCYCSVk8RFGrUVyRgYfW/AF
	gW7t1oKXQ89slJhF1LKO9MyRxmYy8I3YplMWj+OdpfFJtc2cigZyYSsdSGPLCJ4+JE/tm5WXE/I
	mBXVEXaGgy316y0s1HVOGZNOglcSVfQBNtYHY9Orz7KnWYcv6wpMd9oIFb8dlQNVZZRtv2LMHag
	WMtcg2KNDkZwEo=
X-Received: by 2002:a05:600c:8b30:b0:480:1e8f:d15f with SMTP id 5b1f17b1804b1-48069bfaa0bmr55650235e9.2.1769593156788;
        Wed, 28 Jan 2026 01:39:16 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322eefsm5572266f8f.30.2026.01.28.01.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:39:16 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 28 Jan 2026 09:39:12 +0000
To: Conor Dooley <conor@kernel.org>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: iio: amplifiers: Add AD8366 support
Message-ID: <4dkomm5sskte4olhvjtkuae2t34qim5alp6ptsn3a2m6cyqqrt@kemulszlm3ta>
References: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
 <20260126-iio-ad8366-update-v2-2-c9a4d31aeb01@analog.com>
 <20260126-porous-hurdle-bfc510f113bb@spud>
 <rzco2g6psoblzaaqrdnmpmhs44hl7kqusa2kuafpkjx635dug2@rtwebhwztfkd>
 <20260127-goes-grandpa-891eb0dc413a@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-goes-grandpa-891eb0dc413a@spud>

On 26/01/27 07:38PM, Conor Dooley wrote:
> On Tue, Jan 27, 2026 at 11:37:52AM +0000, Rodrigo Alencar wrote:
> > On 26/01/26 08:11PM, Conor Dooley wrote:
> > > On Mon, Jan 26, 2026 at 01:51:03PM +0000, Rodrigo Alencar via B4 Relay wrote:
> > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > 
> > > > Add device tree binding documentation for amplifiers and digital
> > > > attenuators. This covers different device variants with similar
> > > > SPI control.
> > 
> > ...
> > 
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - adi,ad8366
> > > > +      - adi,ada4961
> > > > +      - adi,adl5240
> > > > +      - adi,adrf5720
> > > > +      - adi,adrf5730
> > > > +      - adi,adrf5731
> > > > +      - adi,hmc271a
> > > > +      - adi,hmc792a
> > > > +      - adi,hmc1018a
> > > > +      - adi,hmc1019a
> > > > +      - adi,hmc1119
> > > 
> > > Why do none of these devices use fallback compatibles? Please put the
> > > rationale in the commit message.
> > 
> > Will do. Each device has their own gain range/step. 
> > 
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  vcc-supply:
> > > > +    description: Regulator that provides power to the device.
> > > > +
> > > > +  reset-gpios:
> > > > +    maxItems: 1
> > > > +
> > > > +  enable-gpios:
> > > > +    maxItems: 1
> > > 
> > > How come enable-gpios is optional? Is it optional on all devices?
> > > Do all devices support enable-gpios and/or reset-gpios?
> > 
> > Board designs often hardwire powerup or serial mode enable signals
> > to high voltage level, so there will not be a reason to add the
> > enable-gpio.
> 
> I don't see anything about all devices supporting enable-gpios, adl5240
> doesn't appear to have one? I'm not going to check all of the datasheets
> to see about the others, but you should disallow the property on devices
> that don't have an enable pin.

Understood. I will prepare the following for v3:

allOf:
  - $ref: /schemas/spi/spi-peripheral-props.yaml#
  - if:
      properties:
        compatible:
          contains:
            const: adi,hmc271a
    then:
      properties:
        reset-gpios:
          maxItems: 1
  - if:
      properties:
        compatible:
          contains:
            anyOf:
              - const: adi,ad8366
              - const: adi,ada4961
              - const: adi,adrf5720
              - const: adi,adrf5730
              - const: adi,adrf5731
              - const: adi,hmc792a
              - const: adi,hmc1018a
              - const: adi,hmc1019a
              - const: adi,hmc1119
    then:
      properties:
        enable-gpios:
          maxItems: 1
          description: Power-up or Serial Mode Enable GPIO.

> > I went over the device datasheets and I could not find the
> > reason for the reset gpio. I left it there because it was being used
> > in the current driver implementation, and I would not like to
> > invalidate designs that might be currently using it. I will ask around.
> 
> If none of the devices have a reset pin, then you should delete the
> property from the binding and the driver. Not like you're going to break
> something if none of the supported devices even have the pin!

The pin might have been there due to an old revision of the ada4961 device
(the reset_gpio was added to the code when ada4961 support was included)
which I can't find related documentation. However, it turns out that
hmc271a contains a reset pin, as you can see above.

-- 
Kind regards,

Rodrigo Alencar
