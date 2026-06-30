Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CBA285CB6;
	Tue, 30 Jun 2026 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860995; cv=none; b=LUc+cEWSulF8M6QQOBizuP8n5aK9JvlVLop2xFHbOdAM2S0w69g6g7/rabfNBdhEnv1UkgWGekb/MjbGwyIytq0ZFstDXUa5+VBLwgLiQqLp4+TvWxStPaBKhqFiCLlaOK87qfNRIRAgSqVMrsY1Oc56Z4hAxJmiUYrmCie5pdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860995; c=relaxed/simple;
	bh=4upup8/90HB9b49IMubNK2bKo7r0baY79mUp/NLGHwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEnQrqNVpI8lrHsaMMp7zq3780M/INnFuiizGx1M9evkC9kw1opYDfgmH5x/QUDxgLhUDwUNLuIZayy22wtrtPUTB5C/OTVSSxgFnKMpulRnRD3YEU/M6WjIJeO4gPGG+HBaaCid5/DkpExSJADh6aVLWrQ5x7DLcwd4ROOcCGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNkd7QaT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNkd7QaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2AD1F000E9;
	Tue, 30 Jun 2026 23:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782860993;
	bh=Jv3D2dY4+ZP7tjeSFc05wmRI3UgQrFQWTg6yJfMf/uQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DNkd7QaTL/toA4veUtGErEjS5yujcVH5jwDooswig9ldpUdWs/TUyO/OIv/LFF2k3
	 K/Gl17KztCqLSm1F1QY66CdQUak0gDOzPSSYsq+8wEtwAG7zIUpyBAL3+DVK+dzqby
	 ejn6S3xajWm4aOaE6fjrQ39dQyQQ9ezJ9zhm3uNFF8EVhjrJ8lCBEePZhJbTIV0Jo1
	 O1Xl16ZgjnxSN7DmTbvDbdqEDEnjdoLBSHOO2hVphkRoN9kIU2GhjbrcfkfZ82YTU8
	 NjtBAOdPBEM0LmI9iFANH4X2p9Gcs/litWZCFaN6rwNri56T7DOSjjzoNlrshnvyFM
	 P9cSddnWbsvXw==
Date: Wed, 1 Jul 2026 00:09:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mike.looijmans@topic.nl, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ti,ads1298: add ADS1299 EEG
 ADC variants
Message-ID: <20260701000947.3cc1a06c@jic23-huawei>
In-Reply-To: <a64fd56f-6e4b-4e19-9804-ce7a96f14973@baylibre.com>
References: <20260630140311.1473031-1-shofiqtest@gmail.com>
	<a64fd56f-6e4b-4e19-9804-ce7a96f14973@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 10:24:19 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/30/26 9:03 AM, Md Shofiqul Islam wrote:
> > The ADS1299, ADS1299-4, and ADS1299-6 share the same SPI interface
> > and register map as the ADS1298 ECG ADC family but are designed for
> > EEG and biopotential measurement.  Key differences from ADS1298:
> > - PGA gain up to 24x (vs 12x for ADS1298)
> > - Internal reference is always 2.4V (no 4V option)
> > 
> > Add compatible strings and update the vref-supply description to
> > document the ADS1299 reference voltage behaviour.
> > 
> > Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> > ---
> >  .../bindings/iio/adc/ti,ads1298.yaml          | 31 ++++++++++++++++---
> >  1 file changed, 26 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> > index 71f9f9b745cb..82c5181126df 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> > @@ -4,11 +4,16 @@
> >  $id: http://devicetree.org/schemas/iio/adc/ti,ads1298.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  
> > -title: Texas Instruments' ads1298 medical ADC chips
> > +title: Texas Instruments ADS1298/ADS1299 biopotential ADC chips
> >  
> >  description: |
> > -  Datasheet at: https://www.ti.com/product/ADS1298
> > -  Bindings for this chip aren't complete.
> > +  ADS1298/ADS1298R: 8-channel, 24-bit ECG ADC.
> > +  Datasheet: https://www.ti.com/product/ADS1298
> > +
> > +  ADS1299/ADS1299-4/ADS1299-6: 8/4/6-channel, 24-bit EEG/biopotential ADC.
> > +  Identical SPI interface and register map to the ADS1298 family, but with
> > +  a higher maximum PGA gain (24x vs 12x) and fixed 2.4V internal reference.
> > +  Datasheet: https://www.ti.com/product/ADS1299
Further to David's comment below about not caring about the internal reference
details, I'd drop that bit from here as well.

If you want to differentiate the parts (I'm not sure it's necessary) then say
what each one does as that will be more extensible than starting from a base
then expanding.

Something like:
ADS1298/ADS1298R: 8-channel, 24-bit ECG ADC. Max 12x PGA gain.
Datasheet: https://www.ti.com/product/ADS1298

ADS1299/ADS1299-4/ADS1299-6: 8/4/6-channel, 24-bit EEG/biopotential ADC.
Max 24x PGA gain.
Datasheet: https://www.ti.com/product/ADS1299

(check how that gets formatted and edit as appropriate)

> >  
> >  maintainers:
> >    - Mike Looijmans <mike.looijmans@topic.nl>
> > @@ -17,6 +22,9 @@ properties:
> >    compatible:
> >      enum:
> >        - ti,ads1298
> > +      - ti,ads1299
> > +      - ti,ads1299-4
> > +      - ti,ads1299-6
> >  
> >    reg:
> >      maxItems: 1
> > @@ -33,8 +41,10 @@ properties:
> >  
> >    vref-supply:
> >      description:
> > -      Optional reference voltage. If omitted, internal reference is used,
> > -      which is 2.4V when analog supply is below 4.4V, 4V otherwise.
> > +      Optional reference voltage. If omitted, internal reference is used.
> > +      For ADS1298, the internal reference is 2.4V when analog supply is
> > +      below 4.4V, 4V otherwise. For ADS1299, the internal reference is
> > +      always 2.4V.  
> 
> Not sure the dt-bindings care about the internal reference. It should
> just be a driver implementation detail.
> 
> So I would just trim this down to:
> 
> 	Optional reference voltage. If omitted, internal reference is used.
> 
> >  
> >    clocks:
> >      description: Optional 2.048 MHz external source clock on CLK pin
> > @@ -75,5 +85,16 @@ examples:
> >            spi-max-frequency = <20000000>;
> >            spi-cpha;
> >          };
> > +
> > +        adc@2 {
> > +          reg = <2>;
> > +          compatible = "ti,ads1299";
> > +          label = "ads1299-1-eeg";
> > +          avdd-supply = <&reg_iso_5v_a>;
> > +          interrupt-parent = <&gpio0>;
> > +          interrupts = <79 IRQ_TYPE_EDGE_FALLING>;
> > +          spi-max-frequency = <20000000>;
> > +          spi-cpha;
> > +        };  
> 
> Since the chips are nearly identical, not sure a 2nd example is
> particularly useful.
> 
> >      };
> >  ...  
> 

