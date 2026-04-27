Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2618B2D8DDB
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777329411; cv=pass; b=c+gmJRtSqzLhwD/mX12eELyvxLOVztCXJRQoovF3BiANtKdLOaStGiouWf4CfrKl6zb9VSPndXOcXgdPvR5yQ2UWHB+B/1e3ePPGcA9atajA18HjDLA+srgRhq2A0l1NODPFCIEBLvc3ekcNbQ66BnQP74l7pbg2wLu3jgEFLUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777329411; c=relaxed/simple;
	bh=KU+H8n+k3fh/vRzWZNdtPrnyyVuczsKwihEjQNWxkp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3H37HUVAz9DY5HT1xaITe8Z93AKmWXHi/eRraglK6Ge+pbjXM/hpFlvYoe2QAzp9fRhkufOMoW9oyl6dTKmyuvFu96kQarnvHoiRzHGCrbLhGRu2caP18LV5UjOSD/Tv+/LSfp1bXTjMDe4okI4bC3RCLdzjB9sWaAJKQxbTNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHajpzPL; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHajpzPL"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38e7b0903cdso96322911fa.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 15:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777329407; cv=none;
        d=google.com; s=arc-20240605;
        b=SXfR+1X6cC9vTpmNIgcG0hkvgQxZnOSIOt7vE93k7kpDc2ZBejdUxmIo+dnlIzJT4c
         pcsctaRvzkem5tKy8+dnzxrl4Kcx85W+h57JZXaamvejuUZhaJM5/uUJlsuFTcvPjqYW
         gxtOKHFdOZjAK8TTnWN7K/zE2Rwa4JBDjPZg0QfsXZNYZbn4qj4gnMMnsMwkydvJRp8F
         N8sYB0qTlqq8edCX9RqbVQxTFVHuCQxOoQq/N8insYChRj/hhfInuE0h6CBS3e7ZxDlE
         iSv/e0VqmCn2J4XxcSDs6VJxyc2oZeGBeDP/8ifU0wydmMyp58y3qPy1Jh26hxvzpK3v
         Rf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WO9kHGE+hekdYqyvMyL0grB4aNKxPDxwjf+xYVdptx8=;
        fh=b+/ZHWus9ck9cHpB+55iFc3u7IM6YH1L8bhkrhtEB94=;
        b=T+CHVevLTWbuCu0jTsSVa723wiZQgzoQw7lSxxgtiNONrojUtvmUyGPgEl1p/wH612
         aS8NeOQ9kN/er7aDXqGx4hUx+vPHySnDXGUIXSFVZKWhOJ/SamzhbJSMpBjL0+0XmM/A
         ZeXm5xmmb2cF45j38eru5Bkd2ipK924FOiZcI5qVskkafnN3/SSPCATUGcEu/YuMnlFS
         M8EHc3tb12OF0PpLMZLirjWk0xLyKkZpc6O5XkBiwlk+qILVcfm3i7uq12WtdscFJbSz
         0SKEwW7LKWFwp9B3W5RVYkj70ULh+HSuJPhdrf3IOQii64Mx9kp5ikmrSt9kCrfFINRD
         755Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777329407; x=1777934207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WO9kHGE+hekdYqyvMyL0grB4aNKxPDxwjf+xYVdptx8=;
        b=lHajpzPLVrDmpD0n8RzykwPiHrz/kTN7bTK7j0FHXzR9g/sCzp1Vy9qyoayW+8aoyM
         uvINEIThYBog5GcC3ESMrbdiXyd9IVNhnhYMPPoLmEr0CH6zo7xlGilc2kn8zktbjo2s
         W78MTHw8YhXomqC3V/IKNAp33hOzJXM3/mW7zENuPZdkIQNnvsm2eEoOyTlBQuIFn11W
         Bb3WSyBiUEbR/P33MhNqCrbNn2PUS4Uz9DXo3eEpKj506XjLDfdOMEYHh09LiECmM5ag
         wOEehoggCK6ervQU8YlGnp12Qh1E8guZRNWIiK67mdaBNB2tuzmaRd1Z1OWMVgTlDoJl
         VYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777329407; x=1777934207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WO9kHGE+hekdYqyvMyL0grB4aNKxPDxwjf+xYVdptx8=;
        b=C4vBRPloERzJCfNzr5EVnBHgeWUy80C+//Ok6hsV3qKVZXH4DSmSuWsSDTX+uhBOnp
         1dP2tQfoFNRM913a8LpiA+bPo7MHLVzviely7wGKx7Iht+WKeaAvN4uyStYA4QqLTUE4
         xNGqG9sHtQPVGkZzIdceBJfLdHRU7QBIOZUT/y6cD2w7OW8cCeD+7/Wy29SlNgk3gx1l
         ZgWj4H8VQn3jnKjNTX0VroMprI2uJxCCnDcWeSqBv3mSIQF5+Dt73ebakRg9p1VmIMMo
         vk+hJu61EIps/JvhjVZeKQ5Z3BkMyTPC6o1ZsCUVIo1i0G/Ohi3nCJneov6BqxBtAmha
         5Uaw==
X-Forwarded-Encrypted: i=1; AFNElJ9Mh7s856sSAZSE/I/eFsM3yj7CNWRUuFvKX8wRWpyAUTlRimNsWK9LmFAojxv2r/noCuteZvHamn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyLTKZg+bJoPI5nV2QNBIooB/SmYyDdKH5IFZDrbbmrUBquM02
	SsMituNCuobqOx910i+wDpLnBvVzSfvlC10AgD4OyXcjF60BmmHyTtahwzZn63PxZuhTEnt0fVO
	gf00qHhUNJv2JQmAqCPuZ9mFRoSF0EC4=
X-Gm-Gg: AeBDieuW2yHfpEwk225Tqemw/Gay4nZq4tbox3x/HG7Gr6iGS3A1eKHWPuZZojh0ftV
	+BM4YuySCftgou7mENS/M8p29ovh71fiPX2wvsl+YXzZCm02/78LB3zj4Mf+IHJXoPU5JDbxO4e
	FagUU18bGChpS8q1JD7IJ3CuwxWZGIOL8kpUwUn7SZaDQuYKVZNw8Uwo1kD/zx5f2aKUJMgBswj
	orLySg1iw4OajA1xT6GVj5km9elMwvlYNnlh9e9ENCaN6fa0FFdIygAfzfg6GDi9Uf+IDw6uwAJ
	DQnHcAkx3Aj4HuTc8P1aWe4rb661TQoNIvUoLy16wKx+KQqhVH7Gr1PzakUXq6D3Gyjtdn8EVq0
	z+qw=
X-Received: by 2002:a2e:a994:0:b0:38e:9277:6990 with SMTP id
 38308e7fff4ca-39241005c6dmr1031461fa.30.1777329406920; Mon, 27 Apr 2026
 15:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
 <20260427100950.33936-2-piyushpatle228@gmail.com> <93a7ca0d-46a1-4b14-8f49-348018c4158b@baylibre.com>
In-Reply-To: <93a7ca0d-46a1-4b14-8f49-348018c4158b@baylibre.com>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Tue, 28 Apr 2026 04:06:09 +0530
X-Gm-Features: AVHnY4IsI2yvvegTbDUOQtSlGuLVE1gCectp15dfz7NDja_TYvYprrvJaurSLjY
Message-ID: <CAMB+xkbh0V-qnxq94r6aefJscVwqh-8XfnKUR5mFPTsyz023JQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: iio: adc: avia-hx711: add avia,hx710b compatible
To: David Lechner <dlechner@baylibre.com>
Cc: ak@it-klinger.de, jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 8:59=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 4/27/26 5:09 AM, Piyush Patle wrote:
> > The HX710B shares the same two-wire interface as the HX711 but differs
> > in its channel and gain model: gain is fixed at 128 and the number of
> > trailing PD_SCK pulses selects the input channel rather than the gain.
> >
> > Add avia,hx710b to the compatible enum. Document the chip differences
> > in the description and add chip-specific supply properties (dvdd-supply=
,
> > vsup-supply, vref-supply) and a rate-gpios property for the HX711 RATE
> > pin. Add allOf constraints that forbid HX711-only properties on HX710B
> > nodes and vice versa. Clarify the clock-frequency description to
> > reflect its actual purpose: controlling the SCK bit-bang timing.
>
> Krzysztof gave a Reviewed-by on the last revision [1], so you need to
> include that here or explain why you didn't pick it up. If you just make
> a trivial change, you can still pick it up. In this case though, I think
> that enough changes were made that it is worth having a DT maintainer hav=
e
> another look.
>
> https://lore.kernel.org/linux-iio/20260423-famous-tody-of-opposition-73c8=
af@quoll/
>

I did not carry the Reviewed-by because the binding changed majorly
in v4 (vref-supply added, dvdd-supply removed from the HX710B forbidden
list, new allOf block forbidding vref-supply on HX711).
I should have mentioned that in the cover letter; I=E2=80=99ll do that in v=
5.

> >
> > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> > ---
> > Changes in v4:
> > - Add vref-supply for the HX710B VREF reference voltage pin.
> > - Remove dvdd-supply from the HX710B forbidden properties list; the
> >   HX710B has a DVDD supply and the DVDD-AVDD channel relies on it.
> > - Add allOf block forbidding vref-supply on HX711 nodes.
> > - Add an HX710B example showing vref-supply.
> > - Update description: avoid specific channel-number references in
> >   hardware text.
> >
> > Changes in v3:
> > - Drop the vref-supply mention from avdd-supply; no such binding
> >   property exists.
> > - Drop the clock-frequency sentence that repeated the schema default.
> > - Restore the example node name to weight.
> > - Remove the separate HX710B example.
> >
> > Changes in v2:
> > - Remove driver implementation details from the description and describ=
e
> >   hardware behaviour only.
> > - Drop unrelated punctuation cleanup.
> > - Add dvdd-supply and vsup-supply optional properties for HX711.
> > - Add rate-gpios optional property for the HX711 RATE pin and forbid it
> >   on HX710B.
> > - Add the allOf if/then block forbidding HX711-only properties on
> >   HX710B nodes.
> > - Clarify clock-frequency as SCK bit-bang timing, not a crystal or
> >   external clock input.
> > - Sort compatible enum alphabetically.
> > - Remove redundant example comments.
> > - Update the HX711 example to exercise rate-gpios.
> > ---
> >  .../bindings/iio/adc/avia-hx711.yaml          | 82 +++++++++++++++----
> >  1 file changed, 67 insertions(+), 15 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml =
b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> > index 9c57eb13f892..fddd296bfaca 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> > @@ -4,49 +4,91 @@
> >  $id: http://devicetree.org/schemas/iio/adc/avia-hx711.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >
> > -title: AVIA HX711 ADC chip for weight cells
> > +title: AVIA HX711 and HX710B ADCs
> >
> >  maintainers:
> >    - Andreas Klinger <ak@it-klinger.de>
> >
> >  description: |
> > -  Bit-banging driver using two GPIOs:
> > -  - sck-gpio gives a clock to the sensor with 24 cycles for data retri=
eval
> > -    and up to 3 cycles for selection of the input channel and gain for=
 the
> > -    next measurement
> > -  - dout-gpio is the sensor data the sensor responds to the clock
> > +  The HX711 is a 24-bit ADC with selectable gain (32/64/128) and two
> > +  differential input channels. Channel A supports gain 64 and 128;
> > +  channel B supports gain 32.
> >
> > -  Specifications about the driver can be found at:
> > -  http://www.aviaic.com/ENProducts.aspx
> > +  The HX710B is a 24-bit ADC with fixed gain of 128. One input measure=
s
> > +  the differential voltage between the two input pins; a second measur=
es
> > +  the DVDD-AVDD supply voltage difference for battery level detection.
> >
> >  properties:
> >    compatible:
> >      enum:
> > +      - avia,hx710b
> >        - avia,hx711
> >
> >    sck-gpios:
> >      description:
> > -      Definition of the GPIO for the clock (output). In the datasheet =
it is
> > -      named PD_SCK
> > +      GPIO for the clock output (PD_SCK in the datasheet).
> >      maxItems: 1
> >
> >    dout-gpios:
> >      description:
> > -      Definition of the GPIO for the data-out sent by the sensor in
> > -      response to the clock (input).
> > -      See Documentation/devicetree/bindings/gpio/gpio.txt for informat=
ion
> > -      on how to specify a consumer gpio.
> > +      GPIO for the data output from the sensor (DOUT in the datasheet)=
.
> >      maxItems: 1
> >
> >    avdd-supply:
> >      description:
> > -      Definition of the regulator used as analog supply
> > +      Analog supply voltage (AVDD). Also serves as the voltage referen=
ce on
> > +      both chips.
> > +
> > +  dvdd-supply:
> > +    description:
> > +      Digital supply voltage (DVDD). For the HX710B, DVDD must be grea=
ter
> > +      than or equal to AVDD. When DVDD is a battery rail and AVDD is a
> > +      regulated supply, one channel monitors the DVDD-AVDD difference =
for
> > +      battery level detection.
> > +
> > +  vsup-supply:
> > +    description:
> > +      Supply voltage for the on-chip regulator (VSUP). HX711 only.
> > +
> > +  vref-supply:
> > +    description:
> > +      Reference voltage input (VREF). HX710B only. When omitted, the d=
river
> > +      assumes VREF is tied to AVDD on the board.
> > +
> > +  rate-gpios:
> > +    description:
> > +      GPIO connected to the RATE pin (HX711 only). When driven low the
> > +      output data rate is 10 SPS; when driven high it is 80 SPS. If
> > +      omitted the RATE pin state is determined by the board wiring.
> > +    maxItems: 1
> >
> >    clock-frequency:
> > +    description:
> > +      Controls the SCK bit-bang timing. The value is used to derive th=
e
> > +      delay between SCK edges; keep the SCK high time below 60 us to
> > +      avoid triggering chip power-down mode.
> >      minimum: 20000
> >      maximum: 2500000
> >      default: 400000
> >
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          const: avia,hx710b
> > +    then:
> > +      properties:
> > +        vsup-supply: false
> > +        rate-gpios: false
> > +
> > +  - if:
>
> Could just be else:
>
> Probably OK either way though.
>
Will switch the second allOf block to `else:` in v5.

> > +      properties:
> > +        compatible:
> > +          const: avia,hx711
> > +    then:
> > +      properties:
> > +        vref-supply: false
> > +
> >  required:
> >    - compatible
> >    - sck-gpios
> > @@ -62,6 +104,16 @@ examples:
> >          compatible =3D "avia,hx711";
> >          sck-gpios =3D <&gpio3 10 GPIO_ACTIVE_HIGH>;
> >          dout-gpios =3D <&gpio0 7 GPIO_ACTIVE_HIGH>;
> > +        rate-gpios =3D <&gpio0 9 GPIO_ACTIVE_HIGH>;
> >          avdd-supply =3D <&avdd>;
> >          clock-frequency =3D <100000>;
> >      };
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    weight {
> > +        compatible =3D "avia,hx710b";
> > +        sck-gpios =3D <&gpio3 10 GPIO_ACTIVE_HIGH>;
> > +        dout-gpios =3D <&gpio0 7 GPIO_ACTIVE_HIGH>;
> > +        avdd-supply =3D <&avdd>;
> > +        vref-supply =3D <&vref>;
> > +    };
>
