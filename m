Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA212773FF
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 06:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837819; cv=pass; b=b92JDQWhGPUS/ptjrmhFEaxPURRMHyw19d/9jZLP4vMV9Fn7G0jEmaTg/m4ONNXAZJ/T4sFApfoTg34JXokCImXwygv+hKAdsYTQY7cDVdeW/HiCL2X3igUZKU8wDeNSZCu18IhG2aKuPotRSjvIonN6oHSxzukD7sRjPdGXAn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837819; c=relaxed/simple;
	bh=6sWDJlTFceEdRVEoarMvercv9/cC1/nvygnAF4UnHL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Br3mLysCU/0buFHST1rC8yUNuUmt0aeLOzp+Wc3fNG3bjf0ts66yBqRz4HQj7EOyvgoFKjx4vWVJw3YOvBygiJfo4YqoQ2AuiJs68evUNq32/3zw2mtgys7s7CJ6YoFvOO/7C4imjP0UCBHtxUDT/upVylbaZyzyLPmERXb4ots=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jt3i99YN; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt3i99YN"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a2c3dfb4a1so5267003e87.2
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 23:03:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776837816; cv=none;
        d=google.com; s=arc-20240605;
        b=PLK6/x147M7M2JcufdrqICcuoOtAY8ISofgarATyogvlrga2GskW8GEbsbl/1OKjxv
         X2Gqn1oIsEw7yP5CREGk+/m7gh7PIQdIVxc0kbXIOqwcAX1nXUA+vAD07H0+zBx3tXc4
         yezMk+U8DAA04MC5SQrm0HvhAULz6gWlGhBSUpSZL/zkfXKNA6VrsvemzlaZd/kkomPl
         r17SiZy9Z2IOHgJvEkinfLg6gSUOLLxX12LdY3Bvav4RqeVRAw4USaB6+FgZDl8OmFtr
         htUCSTgz/3S3a+amFmPDtXPYQ8cgeVqHyubuCNy5mY7Ba8b7LTEqX+m/v7bLy+UWBgRj
         Ek5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ksAPyr854BiSUiND8apwu6NWaUZWIiq5Sm9d7240T2Y=;
        fh=HpAE5Lnaro/jN1shNXvI8cTWH8XRRFe/IyTYKmBYRng=;
        b=eeQWD0BYmydenPAWqcSIE+nzjNXFQ+qsIWY+crqvOBb7OHqFcz9KlLJxfHyb8nzyGD
         RiOA/Ihc0VqdLb7o2IK5J1GWrcdfIOq4wD5sE0Xx0heqvKvbT0iapUSDXC71FxMZZYgB
         9c8uS9HwWRWMbqOZpuUNt0ZBqvS26+5AQYAAySN+HxwwHN22Nj6YPw6ljpAdVDM6LX27
         3T6NcFkaxHjBVNCVDYndZb0EqTAEL735lCFSPgY2y0c7kXmw9WAfDkQMrcnvqqgYkceX
         WgOl0nxiZwQJUfP4nYfD3Zl4fKHHSTiZxUFlADpaBmnw+KrRy7ZOm6NDuZRGs4hTJE/a
         ftAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776837816; x=1777442616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksAPyr854BiSUiND8apwu6NWaUZWIiq5Sm9d7240T2Y=;
        b=jt3i99YNk6HL2nSldG7W8X0ySoTttQDIHnvL+yaupRgPkhz2sx8KU8G8KlGnwojbon
         9zuJcpVYOHmfylu3H3UKLBMC2Juo6PALYfQRR8pyLW6Bt3nqJxAO9/5XxbwGIra+jk4v
         8I81GS6Poh6fOv/cJvFoun9k/AuTWIWdugfaYEXbyX7mQgQhGZ734Xs1LCoDgVnLUQPW
         Usxf1Qoh5D4LhL520OAAG55qF9fXKg1KXsgnPhb8r9WR6kmW/XhrIYxF9SBOjYsavvGK
         19vhSBpPYNAKuLMqHLcIwAILq03thOFdgLJDAJ9gCRhowFaLQXN5Y8x5d+pLfx5mdkfn
         xbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776837816; x=1777442616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ksAPyr854BiSUiND8apwu6NWaUZWIiq5Sm9d7240T2Y=;
        b=EdGi7OG/hwQuZ1ZTNW6esT1aHfVpGR4dZSOWCUYAVIEQwrvRNX/6yd2uCUZ5k6Vx7C
         LCenFas8nkiMOrqZeGrnjNnK7Bre0y36d7otRWMZhEnrzdOrQMhFAGNUWJbM9J4yAiq1
         FTjVQI8sFRTKcMuU1SyMmmX0C+HKO8wV8p/BeGWF3f+c3tPDi1lghf5hzY0S5WLzo2Mb
         yG0E7EXJ8h2YoKz7kArk8tgf6rA4JxdjK5VGDp6N0ho39RlF5N753kw/wlGrgqnre+PN
         CyFWzDWmhyZ2l3GxZ77oYIe11chWA31l+4la5VBshSLlZbLZDW8Ul21JTp2igj/hPaSF
         ZwNw==
X-Forwarded-Encrypted: i=1; AFNElJ8BH9YEq2cHJeVQuZ/eQTvU1v82GWgWLaHEbxe2Ss5AL6968vJVSKcWaIAzaHCOQGGuCHWbEtMyj4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjM+gU2/Xv3la4FQ/BSz/K2cn1PYxnNGQAwWbEsHEKCXbiPrik
	UuaJi2DD8OAhGClPat0MaSxMbJ7cqRZNtQg7A0KzZiT9hZySXys1D0+f0E+LNZBcNedpZPpow7t
	EkgsICRUuY4lPTxZmQgP742/AHaC4klE=
X-Gm-Gg: AeBDietDpxfFsSWU35yfvRs1MkqrlMMei3hpet+CaMdwUg22aZ0YL4By5f/oIfwTWWa
	xaR5Lb8DAiW1bLM4H3YM+JFjMCOI+GCAPGyfE5oX3WDoun4MJ94ZqiNk6795yYehi/jxWP59LpF
	I2wAvzRG+sKf4xUkSvMAuQ6enx/JqSgZhDD9Qv/8xMD5TFRHdtXh+sTiY+HIlVmNTqO/v8U5pVx
	kkRulZNJ919hd07ovNWRleGjgFY3SyoZkcv/m4FeX6qJFVuBUfHiftKvfTJ7211xP/j++lnPnUZ
	6+3/a9SNhfmxFc/usAntx0UOGXZJLhE0U70I/mZSM6JWO2nQmWd0Xu8VX7OA
X-Received: by 2002:a05:6512:3b83:b0:5a2:bacd:21bb with SMTP id
 2adb3069b0e04-5a4172be0dbmr5592111e87.3.1776837813705; Tue, 21 Apr 2026
 23:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419174654.683692-1-piyushpatle228@gmail.com>
 <20260419174654.683692-2-piyushpatle228@gmail.com> <20260421-heavy-amigurumi-badger-c7ef9f@quoll>
In-Reply-To: <20260421-heavy-amigurumi-badger-c7ef9f@quoll>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Wed, 22 Apr 2026 11:32:56 +0530
X-Gm-Features: AQROBzBtUydG2-0a3leX_Vqb9F9Z8tRdTaZjG2TQIRosPYbTf2zD8AObJrx7LSE
Message-ID: <CAMB+xkZ_FypL9_pYiE9nEoyaGxzc7_vdAzb-FgKEeXok0_fi1w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: avia-hx711: add avia,hx710b compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, ak@it-klinger.de, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 1:53=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Sun, Apr 19, 2026 at 11:16:39PM +0530, Piyush Patle wrote:
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
> > +  The HX710B is a 24-bit ADC with fixed gain of 128. Channel 0 is the
> > +  differential input and channel 1 measures the DVDD-AVDD supply
> > +  voltage difference.
> >
> >  properties:
> >    compatible:
> >      enum:
> > +      - avia,hx710b
> >        - avia,hx711
> >
> >    sck-gpios:
> > @@ -40,13 +40,45 @@ properties:
> >
> >    avdd-supply:
> >      description:
> > -      Definition of the regulator used as analog supply
> > +      Analog supply voltage (AVDD). Also serves as the voltage referen=
ce on
> > +      both chips; no separate vref-supply is required.
>
> There is no such thing as vref-supply.
>
> > +
> > +  dvdd-supply:
> > +    description:
> > +      Digital supply voltage (DVDD). HX711 only.
> > +
> > +  vsup-supply:
> > +    description:
> > +      Supply voltage for the on-chip regulator (VSUP). HX711 only.
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
> > +      avoid triggering chip power-down mode. Defaults to 400 kHz if no=
t
> > +      specified.
>
> Don't repeat constraints in free form text. Drop last sentence.
>
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
> > +        dvdd-supply: false
> > +        rate-gpios: false
> > +
> >  required:
> >    - compatible
> >    - sck-gpios
> > @@ -58,10 +90,19 @@ additionalProperties: false
> >  examples:
> >    - |
> >      #include <dt-bindings/gpio/gpio.h>
> > -    weight {
> > +    weight0 {
>
> Don't change the node names.
>
> >          compatible =3D "avia,hx711";
> >          sck-gpios =3D <&gpio3 10 GPIO_ACTIVE_HIGH>;
> >          dout-gpios =3D <&gpio0 7 GPIO_ACTIVE_HIGH>;
> > +        rate-gpios =3D <&gpio0 9 GPIO_ACTIVE_HIGH>;
> >          avdd-supply =3D <&avdd>;
> >          clock-frequency =3D <100000>;
> >      };
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    weight1 {
> > +        compatible =3D "avia,hx710b";
> > +        sck-gpios =3D <&gpio3 11 GPIO_ACTIVE_HIGH>;
> > +        dout-gpios =3D <&gpio0 8 GPIO_ACTIVE_HIGH>;
> > +        avdd-supply =3D <&avdd>;
>
> Why no clock-frequency? So basically difference is one property? Then no
> need for new example, less code to maintain.
>
> But OTOH, where is vsup and dvdd?

dvdd-supply and vsup-supply are optional HX711 properties and
arenot present on all boards (e.g. DVDD tied to AVDD or use of the
on-chip regulator without a separate supply node).
The example shows a minimal working configuration.

I will remove the example for HX710B.
>
> > +    };
> > --
> > 2.43.0
> >

Thanks for the review.

I'll fix the schema issues you pointed out in v3
Will share v3 shortly

Regards
Piyush Patle
