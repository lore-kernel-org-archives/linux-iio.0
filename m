Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AC243387
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 00:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569622; cv=none; b=hc8ZYutparCeAKGXrbC+8SC0yzAvwt8T8kRnOYEScsCb/mKkczWXMUiZ9VwG1ag7R32F0BkCUw721DD+3SAA90zkcPfLXanF3VqFatLwXQHcLlh44gvj7JBWzftZiVOr+a0LVXVn+wes7RSpP8seRgzDdU9HKycqId7ua6wwF8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569622; c=relaxed/simple;
	bh=TlvQ6TWQDC0h9u5AhzR1LS2nuT5S4Kuk0wmOa5RVK2M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EpKpxYTYV27wrdxiBTiZmbkkstdKdPg97QobsO8MB2qQPU4bILkmMY5f2ItEkbat7R6jYmsS7e3WFbGLF3xOCD20DzsSgXpuLSC/AFGmTJfh85Mf7pbegCUU13rq6d6is8YhJqkoVzqc6DwznXy8+aDZ5YoOMVCUVB1vTBs/Xg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BW5npwju; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW5npwju"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-59c627b53a0so1532111e0c.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 17:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781569620; x=1782174420; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzXJ7drhdk4uL4tv4+kd791zCxP7yHUNQ4eUHxjRcf4=;
        b=BW5npwjuK/ZY89PtPHyRABTx83sAsekLhpttSb0dVcqdD5q/FdrtzTE7axDMDB/YO8
         q7PxtNRy0Qa/oZqTC4N+W0fnczeJm+xopkgJh800J7eQKo14W6lII6hGF9bUFUM7CzMA
         gwpIzfFR/Yiw9DjRXPdgS1Gi2mbPk86r/5HXAw/ACf7ZdojMdX516VOUgQKxqzI4U4er
         MhedBaCQJe90cmfchvelpXe7mUBxmsNhk5y93FGdR3IuWJo/BFB8ivdJ9u/F51OYcfNF
         W2WCMYT/piNwyp6qq5ARP4/tgFeWTfhMtWANXUh7usFVwiHOBdiG09TzHgRo8SCwgH+t
         3fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781569620; x=1782174420;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PzXJ7drhdk4uL4tv4+kd791zCxP7yHUNQ4eUHxjRcf4=;
        b=dIGjZmnciVXRciV7mbBf0zLjdqQ8mvIhrCibtkFskhBPciNYqfPoiVzeB7xZsdYF6G
         kb43px02+qTvZByrgd7TBeuFgQKyk0JJWaJhe8hpibY3GmFnc/jz/UNwqG1y2sDDqnii
         zpoCz2EqaIUEv2vJUXRgB51SGj4HtDlO+A53bledmFrzDHkdZuGfm8Huzy/bikosakkA
         iJUY98hds2Vc6iGZAYzULjnTxaYpjyI1SLzhMOTErwsZ8VAVI3rg6yaEZ4zdvKA4bUm5
         4TAmMLtZOqEL/JEs8AT+nbxWoQnmbLPqTALlG7v/Dp7/UD23sj/a4PLvrE+zwEvKxgrk
         H8hw==
X-Forwarded-Encrypted: i=1; AFNElJ+egTbsV777YiK8Oq4GVvOnPP9dHonHz6yIw1/6FQX9Drm4cu0O9Y+RG6jt+kuEJ1QQ7+myhmMMKgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf9/WTKsniQbzL5YqI15Hi5Hn3IqK5S/Jx9xWD0AP3gz+9gfiP
	wAHSFJwL2du0GZRnioGvDlpbJhmEaMHjmcKn2bTYnl3ILliX+zW75MJD
X-Gm-Gg: Acq92OGWaH6Ec25/+pIAEG4woqAK6ChszI4Tex8v10LrmyFwh4r97Q0RaqRYEfAN8qG
	bKwb1Rcc6JBZKgQKytRit+awtvdxZsmP/KQhDVWPJzknLQ2tvgkG3hVvhZOc7U7jZX4PmG2tb7g
	BHWrLjKOwvmFD3Ft0IYXbnqimlqbKLzrofXdC2IMhhN0tCFEZ/B1S5RfMnzSXHfgM6iOIrg8lnn
	8Gf16WmqbEDjsMRDP6Ls3Y6/MmTIqw26fdUD51w0t7mEIFjlpJxUtyMTcY7rNdRIyG1NzIEj78X
	EBKrPAk3aLrVe5cGTnvK8w/UKiWNf6GlOQk1datLL6JPB5/w2jH761jbEIWPOc8CL954tJMl34z
	2mDmkuvFesrxNHOVj3vrHilw3PcewhpkqSAFQlIBqIWxTF0Lu+HMhq0Tt9BozGYJSQPe3nN1evI
	b1BS64c4ElWrAmNQ==
X-Received: by 2002:a05:6122:288b:b0:5b5:b0ad:543a with SMTP id 71dfb90a1353d-5bb79b71f97mr5438432e0c.7.1781569620480;
        Mon, 15 Jun 2026 17:27:00 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb8ff95f5bsm5242303e0c.4.2026.06.15.17.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 17:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 19:26:53 -0500
Message-Id: <DJA1PXNS9SFP.VAURJH1MR9BK@gmail.com>
Cc: "Kurt Borja" <kuurtb@gmail.com>, "Nguyen Minh Tien"
 <zizuzacker@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: add ti,ads122c14
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>, "Jonathan Cameron"
 <jic23@kernel.org>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <20260615-iio-adc-ti-ads122c14-v1-1-e6bdadf7cb2b@baylibre.com>
In-Reply-To: <20260615-iio-adc-ti-ads122c14-v1-1-e6bdadf7cb2b@baylibre.com>

On Mon Jun 15, 2026 at 4:59 PM -05, David Lechner (TI) wrote:
> Add new bindings for ti,ads122c14 and similar devices.
>
> This is an ADC that is primarily intended for use with temperature
> sensors. There are a few unusual properties because of this. In
> particular, the reference voltage source and current output requirements
> can be different for each measurement, so these are included in the
> channel bindings.
>
> The REFP/REFN reference voltage is usually just connected to a resistor
> that is being driven by the ADC's current outputs, so there is special
> property for this case rather than requiring a regulator to be defined
> to represent that.
>
> ti,vref-source is reused from ti,tlv320adcx140.yaml (otherwise might
> have preferred an enum of strings).
>
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  | 224 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   7 +
>  include/dt-bindings/iio/adc/ti,ads112c14.h         |  11 +
>  3 files changed, 242 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml =
b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
> new file mode 100644
> index 000000000000..dc7f37cad772
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
> @@ -0,0 +1,224 @@

[...]

> +patternProperties:
> +  ^channel@[0-7]$:
> +    $ref: adc.yaml
> +
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        maximum: 16 # arbitrary limit, channel@ can be any combination o=
f AIN0-AIN7
> +
> +      single-channel:
> +        maximum: 7
> +
> +      diff-channels:
> +        items:
> +          maximum: 7
> +
> +      bipolar:
> +        description:
> +          Set this flag if the differential input can be negative.
> +
> +      excitation-channels:

I noticed this doesn't have the "ti," prefix. Is your plan to add this
to adc.yaml?

Also, do you think excitation-pins might be a better name?

> +        description: AINx pins used as current output.
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 1
> +        maxItems: 2
> +        items:
> +          maximum: 7
> +
> +      excitation-current-microamp:
> +        description: The current output of the excitation channels in mi=
croamps.
> +        minimum: 1
> +        maximum: 1000
> +
> +      current-chopping:

If you agree with the above comment, I think this too should be added.
In that case, can we call this something like
excitation-current-rotation for less ambiguity?

I say this because my device has an "IDAC rotation mode", but it also has
a "Chop Mode" which rotates analog inputs and averages consecutive
conversions.

> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          If provided, the two excitation channels are to be used with c=
urrent
> +          chopping enabled.
> +
> +      ti,vref-source:
> +        description: |
> +          Indicates the source for the reference voltage for this channe=
l.
> +          0 - Internal 2.5V reference
> +          1 - Internal 1.25V reference
> +          2 - External reference (REFP-REFN)
> +          3 - AVDD as reference
> +
> +          For convenience, macros for these values are available in
> +          dt-bindings/iio/adc/ti,ads112c14.h.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        maximum: 3
> +        default: 0
> +
> +    dependencies:
> +      excitation-channels: [ excitation-current-microamp ]
> +      excitation-current-microamp: [ excitation-channels ]
> +      current-chopping: [ excitation-channels ]
> +
> +    oneOf:
> +      - required: [ single-channel ]
> +      - required: [ diff-channels ]

[...]

--=20
Thanks,
 ~ Kurt
