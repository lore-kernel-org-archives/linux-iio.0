Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C83988FF
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779267385; cv=none; b=A6mUbNw8+JbeNTcDiF0LP+iPXuXJW++mGery6GDBXkhNSNzRCvPSWPqEEB6TIlHPg8K5sqg47ZOS3nxUmgg5Ra3JQe+p5JVBzdmsUFi+HIB3OBYSoIIwBD/Dv0OyeJKuYLPTpMLokS3i61D7ucH9SJy/DOjpdoddpsAUg1u4amw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779267385; c=relaxed/simple;
	bh=h2twtrvSw/ZLNACakCMYgiogsUQfuClwdgax8uZCdBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjXHHw18/LrIQaD0/PEWUV+YuiJhwm6BUQYk35JBXG+EcJihKMjCSp/+5gSPtCiNXv02I48q/64pwS4x0pxdpuF4x/iDcu0BX1cwy5CADp+0y22NaI8CqP7a8CuHLxchD8oqOgoXbJz5D6/IbNo3azJQUkT9G0SqtyVGy4X/+Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQoD7gD8; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQoD7gD8"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bd6460b0d11so842340566b.1
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 01:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779267382; x=1779872182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rUCdm1gmpZgWGg+Rje5CZp5EuHl/OpSitT/+cJx5sMA=;
        b=PQoD7gD8rYLVeSzGyKG86FY5dawrkpIwontDn6zTXASH6ETj8qWkrGtZVrIoGToPwI
         gdkuHrREEH3l9ROwu+qvqowG+f2YqgZ0HdVXosaWqn1JZZQep3XlTpSYnRdEovd4i6he
         x89tkmrjW9FZvEbJHHOSll+4vhAcUMVZK5AYWqc6S96thX27a6BzCngS00VCeV4JPV2s
         MY8DVR4eJxOTs2DYhZvfue2NM6OhF8P+eW0hp3Wg7m5T6ArumpKSUSbWZyjv0VHuZYC+
         mEATRSOCFfmyiiHIttFdmlSKzFKswoYUH91xVsgrZLRiKIK3ZeCXALdF3GlmYHbpMbh8
         nVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779267382; x=1779872182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUCdm1gmpZgWGg+Rje5CZp5EuHl/OpSitT/+cJx5sMA=;
        b=PmpOJqmDsH92xecKeTmvBd2XWDg43dTysxYtJkudebrrtLYkL5SHXmfLnqz51i9XE8
         ppydmVvpNnx6OOGCpaTVUEn3Xf2whY/spJPmH8Y64BbiMM1CBQw15riNrs01U/s/w5a1
         rMStRdnCq8OUkKztpXYkLOecgk8PUKgem0dHI64dogPvwZmGdhq7BSKFdFv5t18hsZKW
         lP8Y4oZesKrFbC1WDL5tork+QSTk44nmHYMjBkpI9ENX9WqL1BiAopWuSb4kZLniPn9x
         3f4LWbP1AdPhqgRMISHPXBPqu/7ILAIvYeZH7hi2H8LJreEoLmIQz8dfgb632SwMNk4X
         /UjQ==
X-Gm-Message-State: AOJu0Yyz9ZzSPgmCYFoBgnylZmOcvlAubnb23zKaA/Slp6GRj1Btu2o2
	JGBpYUrE9lvgu0slL/Qvn87HGBHyhJpE7/qBIG3K4NInAkaXrdHNaEpp
X-Gm-Gg: Acq92OGs/6mLcZoWpfixMIumMD5B0w8/DkH0TGWo8HMLvAoL3Am8dTKzg77RKUOfUg+
	gBMR+jM7ph0mS6yNDCCQtMHLPXKYqQIpItJChvkdcOdW6pO184MQEbDDydivczM2LDNzVdhAhLS
	R0G/ZThxYs++W/T3xFlyc/2ZiXFHJTCSvTqNRmyFZj747t/6UwVYOlpH3BnYWK5UFNGObAWOPVx
	CGiDA5MLDpHlK6EDxw5cWHSFihfLOvecMfvHWOjHeA14Vxdr1lAdVEDNTsVRZH62nlG5yZpBGU0
	rQjflAiUrqwNRvfvGWEFv6S5BQ3hQpuZB85fxJluVOX4PtHAslEQ2u3jwQqj8wrUNX1V9GRVv5O
	8jyRWuU1qBZsZB+xY/56LrJLIyngOJODK7tTjNJQ50vrSS6zWf02WeptssdNUBIrYcYjcxSXM6t
	R6EGwfcDbrtfU+EhUeb3wVLpmKjxE=
X-Received: by 2002:a17:907:7b82:b0:bd4:c66e:9889 with SMTP id a640c23a62f3a-bd51790b3d5mr1249519366b.24.1779267381888;
        Wed, 20 May 2026 01:56:21 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ec000csm833929766b.60.2026.05.20.01.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:56:21 -0700 (PDT)
Date: Wed, 20 May 2026 10:56:19 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: light: add Broadcom APDS9999
Message-ID: <ag123fx0az4B83-l@gmail.com>
References: <cover.1779181370.git.azpijr@gmail.com>
 <12b145839a1a9c5381946a9e5237bfe6fe0ae9a7.1779181370.git.azpijr@gmail.com>
 <20260519-overdrawn-cofounder-59752aa87d4f@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-overdrawn-cofounder-59752aa87d4f@spud>

On Tue, May 19, 2026 at 06:30:20PM +0100, Conor Dooley wrote:
> On Tue, May 19, 2026 at 11:23:13AM +0200, Jose A. Perez de Azpillaga wrote:
> > Add Device Tree binding for the Broadcom APDS9999 ambient light
> > and proximity sensor. A separate binding file is used rather
> > than merging with avago,apds9300.yaml because the APDS9999
> > has an additional vled-supply for the VCSEL.
> >
> > The APDS9999 features individual R, G, B, and IR channels with
> > a green channel that uses optical coating to approximate the
> > human eye spectral response for ALS/lux measurements. Calibrated
> > RGB color sensing is not yet implemented in the driver.
> >
> > Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> > ---
> >  .../bindings/iio/light/brcm,apds9999.yaml     | 54 +++++++++++++++++++
> >  MAINTAINERS                                   |  6 +++
> >  2 files changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
> > new file mode 100644
> > index 000000000000..4d9e9aff8894
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/light/brcm,apds9999.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +title: Broadcom APDS-9999 Digital Proximity and RGB Sensor
> > +
> > +maintainers:
> > +  - Jose A. Perez de Azpillaga <azpijr@gmail.com>
> > +
> > +description: |
> > +  Broadcom APDS-9999 is a digital proximity and RGB sensor with
> > +  ambient light sensing (ALS) capability. The device uses individual
> > +  R, G, B, and IR channels plus a Vertical Cavity Surface Emitting
> > +  Laser (VCSEL) for proximity detection.
> > +
> > +  Datasheet: https://docs.broadcom.com/docs/APDS-9999-DS
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - brcm,apds9999
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vdd-supply: true
> > +
> > +  vled-supply:
> > +    description: VCSEL power supply
>
> Why does the name in the description disagree with the name in the
> property? If the pin is called vcsel, please call the property that.
>

will rename to vcsel-supply in v4.

> Cheers,
> Conor.
>
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdd-supply
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        light-sensor@52 {
> > +            compatible = "brcm,apds9999";
> > +            reg = <0x52>;
> > +            vdd-supply = <&vdd_reg>;
> > +            vled-supply = <&vled_reg>;
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1aa9c989973f..2d8d4e2eab6e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5000,6 +5000,12 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> >  F:	drivers/iio/light/apds9160.c
> >
> > +BROADCOM APDS9999 AMBIENT LIGHT SENSOR DRIVER
> > +M:	Jose A. Perez de Azpillaga <azpijr@gmail.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
> > +
> >  BROADCOM ASP 2.0 ETHERNET DRIVER
> >  M:	Justin Chen <justin.chen@broadcom.com>
> >  M:	Florian Fainelli <florian.fainelli@broadcom.com>
> >
> >
>
> pw-bot: changes-requested

--
jose a. p-a
