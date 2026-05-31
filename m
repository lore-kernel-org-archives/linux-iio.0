Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245334B1A6
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780247097; cv=pass; b=AwWgqlXNhAsyK5oAoL5veXfA+uuj8SVnPYFv9OuIjIbR1be3CxpzyJ4LC3JIuLMwQOGZVD8q21CFWQCRiWejolcjcrG7kpIXgI6+xNQwY0BcLHdP5+NkmZwEQ3ZSxfX5ma4Tchb4QlxvYVlwmfoGwv05EXEHxenVywFIUH1nbpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780247097; c=relaxed/simple;
	bh=H7QItvga5a9vyjSKr/kFCcz+smthy3VXYyuQRBz+Wa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGvC3J4z3VSAV2tLBq8xe1bZtUPRPczlKvwisb2TDRlbpgx8sG2Vtb9+UKRh4m9Lixyu13cL8f+i5nLHAQzTxwdFtstBpv8uSD6TsHQ6lmRYgMfLJFGqxvJReyrs0ggyn8WfqsOMiNbogOsOpSy2phKyicbl6UIGlgf3RdCEe3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kor9FMS1; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kor9FMS1"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68b3a28da7eso495110a12.2
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 10:04:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780247094; cv=none;
        d=google.com; s=arc-20240605;
        b=Kf32SvgKKMY3W3oWskKbcdKlG8efQjtkdjgdBnnG6ERMv0F5IoRjXKKkN5EO3/ZRMY
         fbbZnx67AY10HSfnP7exr1lVPQA+nPw4UMC2OQW+eVvbDQUoxQDsNxPPPhP+JnJQKChO
         xI1xF0bt4XkwNbyG+Q52l1aT/7Bx0n6ZXRvU6ag/SYAE5BjMiDD1hJe+GimxuMmMH4sL
         KK/qlfwR8WtyK916IgLlpj6HZTCxwH3nS6fix2Flj0eDo5HznKz50cRO8XDsc/yxhxDl
         0VbZtl2F5H9FtnENe61iUKZhQVFYig9zjCAaYRBoiW28x8sPqRhU8Aem2PLtadiKPDRd
         izQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2blOXQVLbvhazc/BACOMVu6tNFxD3c2S1a/BDqNp1cQ=;
        fh=zntq+ZPObtiCe1HV5HpWawS0gr0a0BPBdfJEA29YdbE=;
        b=LJrBKIBHPfopB0ZaW2PO2FNL30X7G/GJbnStHwKw5Uzg7ou4t78NPqNJ/4VB4hDuhf
         lA4tdpjjIHVx7MKsVpiQVihGdyK2FG6iPe2BCl4OrsX19mrRXK+VOX2KyUl9NI7q9km0
         oaey0vwT2YIOGScJT3FLOBX6qxgHG7DcsJ6ZNCRHCo5z3K4tF6hPyXs9S323weHBSs9u
         Kk27QuuuIkwYg5pSf2+ycKCg9EJDSCk1KB/VN+XpA0Aq3CB/oqL1Wo75Ye6kL7OWXezS
         /1Rz1s01l8D3CZV1I+29aIQ8S1rUr5xH4D8k4f+Sk6bZt2BxmYkUxrO6a8ig4GwiBDWE
         Y7TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780247094; x=1780851894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2blOXQVLbvhazc/BACOMVu6tNFxD3c2S1a/BDqNp1cQ=;
        b=kor9FMS1h6crulNlqo2Lpsj+ffbiP+OSxI+MDHQm07y6oLf8SUn4+CmqxRPlp6g+Te
         Q/DersFVULs2hcleIoXLLASGyfLdldRST0p2YoyKzj90nObvJlqXvaLvFbc0Ig2yfuZm
         ui0YGsr5F+g2xD+Ax80CMv/ZgqbJ+aR/vDVzOt1+hPHZ6Axgx98nSZbU4v0hZv9OBLK+
         45ls3UugvIOI3U3H+bqvxXxb54Y7NePMABl8lodpYQNovqWUoYYfLBNc8Tu+K9r4ujBQ
         ifZlY/i0xE5SW3+d3Tg/OFlUGmO69ddPZ1fRMRTX+JkQR9ZNJJSGoMUZtU02nd4w+8VG
         1Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780247094; x=1780851894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2blOXQVLbvhazc/BACOMVu6tNFxD3c2S1a/BDqNp1cQ=;
        b=XDXhbTaGvw+H/7/80yEhnJwbTIvzexmMP2RziGqIYDDkVwVDdDHV0hJTk0ghBvdNxq
         FVtIpEto1Y81m+LVXeb0Xnh5XqBLC6UHtXeINlljn4jWOjjioICGqFjrJjmRtKfXqcZN
         WYbbYMdj2p6awDNXELjxSL42Q5fZJ4tO+IrSxKzeW2/L4XBnb8DccSuB7tNtxzaGxiNx
         XnmYY8p2AV1agq3TxnBXZ/KSBSwkyP3Uq8u+y/eTPQqxE6e6EVuSyCUGW6t8FCx9HCpA
         oHglPDKLI8aD41G4FCctrKOrkHLvse3waB2FBjQnokZMDYXK1azV0fuKRWJsKmfcqjWk
         qy8g==
X-Forwarded-Encrypted: i=1; AFNElJ+tJBdaA4vXL/RSR3bSUfG7M+i32b6IL/WWmEKbDEd/dNFRr4CqXvtSEPFRPqB7hkfcgZa7ncJdcto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoBAqpuS/V3iBnZ++/f6APb0mlmJDWyIhH9ZvlmyjVw5pp2nqu
	Chmad1/CKm1TUUBqdHTsTHm0TO0q9hVcDCVS2Bpk+13f6R6hEKyf3gRLhTUtCUCHFSp7n1vIUWR
	e3zLkJVck015wbkgCReqtSoKCJA0v7V4=
X-Gm-Gg: Acq92OGXoLAHKGEXS7kIGCcsiIJnrfgz3R6sWn81u7JX9P2GMzTeoV4fCAlheDXboZf
	FeMuzYJq+cljQDWVTOepseDauqjGwuC7vIWpQd8hiT01rAN02kF5Fu6DWumpqIhgE1EU4BXBhkY
	3SnTa7L61SI5TAioxgOWB/iRSQJn7dQCJqtDFvrZkFJuxlOrgTaBSP9x8fSOQYbnjX3fIpEXDjn
	wUqG3KRGzjnoaN3Aj9JcwkZpmrUxN1jsIMQN7YtxIvnfxcn4hwCurpnnYvSfLWWrR7nbwvVDT3d
	wjRNt2BYFzyI7cX9cj+iX5ctVnslKw==
X-Received: by 2002:a05:6402:2112:b0:680:ddba:c435 with SMTP id
 4fb4d7f45d1cf-68c8ac28ca9mr1633355a12.8.1780247094217; Sun, 31 May 2026
 10:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530165917.55767-1-tahanarimani3443@gmail.com> <20260531154153.2b77a407@jic23-huawei>
In-Reply-To: <20260531154153.2b77a407@jic23-huawei>
From: Taha Narimani <tahanarimani3443@gmail.com>
Date: Sun, 31 May 2026 20:34:41 +0330
X-Gm-Features: AVHnY4JCcWEV7vljfej8qjqDgTJSY6f0xryHUy16PiHo_9FHD-hnTSLx2MrcHj8
Message-ID: <CAEsNvj-9ApXwx1HO9kwfSNBESQRSTcLmUYm_DnziaC6v1zzfdQ@mail.gmail.com>
Subject: Re: [PATCH v3 RFC v3] dt-bindings: iio: adc: add ad7816/7/8 digital
 temperature sensor / ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thank you for your patience and the detailed review of v2. I apologize
for rushing the v3 submission and omitting the changelog. I am still
familiarizing myself with the kernel mailing list etiquette, and I
will certainly slow down and allow at least a week for future patch
revisions to ensure proper discussion time.

As you recommended, I took a step back and thoroughly read the
AD7816/7/8 datasheets. That was a great learning point=E2=80=94it helped me
realize that the AD7816 (8-pin) completely lacks a BUSY pin, which the
current staging driver incorrectly requests unconditionally. I also
mapped out the missing power supplies and OTI interrupts based on the
datasheet specifications to make the binding complete.

Here is the requested changelog for this version:

Changes in v3:
- Updated the patch title and marked it explicitly as an RFC, noting
the driver's staging status.
- Added `spi-max-frequency` with a maximum limit of 12.5MHz based on
the datasheet.
- Added `vdd-supply` and `vref-supply` properties (making vref-supply
optional where an internal reference exists).
- Implemented conditional schema logic: restricted `busy-gpios`
exclusively to the `adi,ad7817` variant and disallowed `vref-supply`
for `adi,ad7818`.
- Documented the `interrupts` property for the OTI pin (Active low) to
resolve the validation error in the v2 example.
- Modified the example block to use `adi,ad7817` to correctly align
with the `busy-gpios` requirement.

Best regards,
Taha Narimani


On Sun, May 31, 2026 at 6:12=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 30 May 2026 16:59:15 +0000
> Taha Narimani <tahanarimani3443@gmail.com> wrote:
>
> > Document the Analog Devices AD7816, AD7817, and AD7818 digital
> > temperature sensor and ADC bindings in YAML format.
> >
> > Please note that the driver for this device is currently in drivers/sta=
ging.
> > This patch is sent as an RFC to clean up and standardize the device tre=
e
> > bindings prior to any major driver refactoring.
> >
> > While reviewing the AD7816/7/8 datasheet to correctly document the prop=
erties,
> > it was noted that the current staging driver attempts to request a 'bus=
y' GPIO
> > for both AD7816 and AD7817. However, the AD7816 is an 8-pin device and =
does
> > not possess a BUSY pin (only the 16-pin AD7817 has it). Therefore, in t=
his
> > binding, busy-gpios is strictly limited to adi,ad7817.
> >
> > This resolves the checkpatch.pl warnings regarding undocumented DT
> > compatible strings.
> >
> > Signed-off-by: Taha Narimani <tahanarimani3443@gmail.com>
> > ---
> Hi Taha,
>
> There should be a change log here. Please reply to this thread with that =
for
> this version.
>
> Also, slow down.  For any patch allow at least 24 hours unless a maintain=
er
> specifically requests it faster. For most stuff a week. That way any ongo=
ing
> discussion can finish and additional reviewers have time to take a look.
>
>
> >  .../bindings/iio/adc/adi,ad7816.yaml          | 105 ++++++++++++++++++
> >  1 file changed, 105 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad781=
6.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
> > new file mode 100644
> > index 0000000..48563e4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
> > @@ -0,0 +1,105 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7816.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD7816/7/8 digital temperature sensor / ADC
> > +
> > +maintainers:
> > +  - Taha Narimani <tahanarimani3443@gmail.com>
> > +
> > +description: |
> > +  Analog Devices AD7816, AD7817, and AD7818 10-Bit general purpose ADC=
 and
> > +  temperature sensor. The device communicates via an SPI interface.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad7816
> > +      - adi,ad7817
> > +      - adi,ad7818
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 12500000
> > +
> > +  vdd-supply:
> > +    description: Main power supply.
> > +
> > +  vref-supply:
> > +    description: |
> > +      Optional external reference voltage supply. If not provided, the
> > +      internal reference is used. Applicable for AD7816 and AD7817.
> > +
> > +  rdwr-gpios:
> > +    maxItems: 1
> > +    description: GPIO connected to the RD/WR pin.
> > +
> > +  convert-gpios:
> > +    maxItems: 1
> > +    description: GPIO connected to the CONVST (Convert Start) pin.
> > +
> > +  busy-gpios:
> > +    maxItems: 1
> > +    description: GPIO connected to the BUSY pin. Only applicable for A=
D7817.
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: OTI (Over Temperature Indicator) interrupt. Active lo=
w.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdd-supply
> > +  - rdwr-gpios
> > +  - convert-gpios
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: adi,ad7817
> > +    then:
> > +      required:
> > +        - busy-gpios
> > +    else:
> > +      properties:
> > +        busy-gpios: false
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: adi,ad7818
> > +    then:
> > +      properties:
> > +        vref-supply: false
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        adc@0 {
> > +            compatible =3D "adi,ad7817";
> > +            reg =3D <0>;
> > +            spi-max-frequency =3D <1000000>;
> > +            vdd-supply =3D <&vcc>;
> > +            vref-supply =3D <&vref>;
> > +            rdwr-gpios =3D <&gpio 5 GPIO_ACTIVE_HIGH>;
> > +            convert-gpios =3D <&gpio 6 GPIO_ACTIVE_HIGH>;
> > +            busy-gpios =3D <&gpio 7 GPIO_ACTIVE_HIGH>;
> > +            interrupts =3D <20 IRQ_TYPE_LEVEL_LOW>;
> > +            interrupt-parent =3D <&gpio>;
> > +        };
> > +    };
>
