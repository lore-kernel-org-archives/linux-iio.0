Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8D1CAA78
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769929294; cv=pass; b=KkJBV7d4HgIxvSRs+feXmm3xkvntcB+ZuUbLUdadm9vgwHMe5lt7KbnK/JhM0YxkvpuNk8fx0x6jxyp5vEgC5KfPWT4czrk3wuTLtPTSeTn5mNwcjkEV1CtzG4yflFnQnr0LGJkLj3ez5oOv77aGS5kTu6B1zvo9V6a2cIISvb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769929294; c=relaxed/simple;
	bh=4lwxL+MX5lYgnvQjumgh4AurnaGrE32hCgCl0vhDOYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFChUnq132Exfi9v4Xqf2CE4+4jIXbAnMVnfx+iWHCK2mkoCQI3WURYOLJKr8DszZHnZQrZ3/SoQN4DndXrGYZJk1FdWArSfexNe5uIKIiRn/sNECN5kyYjbySvMp8JXlC85ig4IbRFmmSos6rA68D+jMCLNdw1296DSXXP1Qas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jn9EfSA6; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn9EfSA6"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43284ed32a0so1825551f8f.3
        for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 23:01:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769929290; cv=none;
        d=google.com; s=arc-20240605;
        b=PvCpo4Tv7xjqTb/wwlMCad0TMhaWFYnH/ohWZaT+Mr0wKniLZsae2zwz27bLkrz06V
         qza770pVsxnIpajAbhe0JAMMTTLJAcd2Wn3lOFVxdaqXEI94baEJY0u9qO6Rx5mA57LL
         +B2T33L6B7BhHwMnJQ6kgAq3mUXvF3qV/lv2NeCL7C7uHNlauxT4rruxER5vayvjRtlC
         W2IoIBer0zoa5jpTujiYSXqUXlKk9LUHuaan6JuS8hdYEZAxrza6Q2bIKVmXQhSiT4mT
         Vr3tPMkuq7jPwr4TgB4t4QPJuSS/AwtbZorNY7mSU3PGOAjqufRBNyJDquvcj5d9SHG1
         k4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ru6T+Kx+o+wF1O0sdT4WJIlvaSW/GAs5TSwcPEqdU2s=;
        fh=PRLP68bEZWIpMzF/DxeojG3h2xMU6B/LKkndbei2+AA=;
        b=J3vAhYTVUo9EpfIzJlWsdXRwRGQamYIM/kHZCVUGfcdqEpQ0ZwtqG8ALvmp1qWvPRG
         H2ujmgFL9ZMwTkkx1G2oNvNCNKmEQI8O5kwYD6cioSars4sUZunpBcnWUkFoC39QW/Yx
         H/dNrX1DjyuzlKavo8EMNCeSvBiXrxVQHVAdsTJUOpnfb1RnyBhPk1AA/MzQQFBooIp7
         NpPTeUWtsX42qTkTrLkgmZSSgCBXptIkx/ykhfiWYOe1kiDNsGygyBUVi6zRzNeBM9X/
         2hNX5Cu0av8BIAdSZnsVwAstILmufJ7Rfc8KLrcyB1mPBx9+jzThlDJWPpHSBN0wo8Pq
         mz7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769929290; x=1770534090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ru6T+Kx+o+wF1O0sdT4WJIlvaSW/GAs5TSwcPEqdU2s=;
        b=Jn9EfSA6fRuIVKLr4AaDLNSKBNL8pNLIzAn3ZvhMvVaTDKFsq+ipWeCMRNkekMrUgb
         A0Ln5mZ3LggiURzzV2WBXJxP6cuuWXb9TNIlrGVNUxwCIIaEem1gpptyrSPCZ5IlMDzt
         5fUbTS5GA6rBJL/oI1+pxmc1I/uBvhnJp+aO2sGBmNMcyl/Xyo7jAV9n5GbMdfk+o807
         NMKhRMYdWew37MtphMm6TqfcCIju0X+RKLvk8Vsd43Yo681J0zRY+sepZFOjGN7tkDRF
         PWC+YPRkx8zVPqfVGZwbFfwyirHPDJ+z/+3WyyRp0uY1XpuaRpWj7vuJVPrx6xv4dztz
         aa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769929290; x=1770534090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ru6T+Kx+o+wF1O0sdT4WJIlvaSW/GAs5TSwcPEqdU2s=;
        b=ZR2TxwRf8xQxAfJ7LCdDICDZDBp1J8YdDAFb4FHHoBwkXNY5meN+e73DVCcxdbhfKt
         D6if7RUecqUj10pLxm4JInTNFtFfzQi0kjqdV3KT/EeusOhzued3Ae5U/5/fHUytgQ/q
         knbP9GCHN6L5CekkbROQl6yXWCG+yo1pZknN/IKKxYe16DEamGxN7RhdRm/t9SxrBEfM
         14lg5SlCqcfF6k/v5ju2koQJHFyRf8KrVCZR0//fZLpLx6jTNXSIh1XA145W7G0pkEj/
         NMafNT/O0lh+sQe6BXw3ffzwqOORM+J+7vQEn00ETQMgGEWrVrzkx0MZVsp1jg9ufY9C
         YbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsciS0w9aQDV/W97yrHtMjuqoWILaRXbUWSkEl85EvFAnTTOrD23KygPwNMgVtStsVnbeAFryaLVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0hcufNpeHELhbUNgiGGQNADJGDFJfDG2gS09jcHhIu1Mo6LVj
	igcEAJITOagnHGPT2Mepqzg5R2eovMI3TdZwklf3u9aiqA7aULZ80497oCNMjI3cSOjDTeTaz3V
	4ha9iJJGiHGOrH4fDXjFH3GArEVh+GZw=
X-Gm-Gg: AZuq6aLLE79eSmyZ3U1hV/9P81/QCn+kLGXtDwbsJntqpAsl/6EiZGpL2VKCnZw9EKh
	VkbHlar5Yg6BtWg4ReHjgD6kf1fz+P2s899kcl+hqNQFXZizfl8xGbYaI95bOWFN6MRB6ga7XiW
	m6tqBQ6LfvOsUhQ45SR36r/h6SsfFII74iEDP5CceapjMQXNvDnqdIkENl2H+f66cF+iagbjTe1
	QK8jcIn8iopG1akRAfMG+xRLo8FgQ1uqEvfrlEWH3cpol4sO6hG0X0Wk3oEtUDVggXZr+Bw
X-Received: by 2002:a5d:5f54:0:b0:435:693e:c03e with SMTP id
 ffacd0b85a97d-435f3a7e60emr11130004f8f.19.1769929289499; Sat, 31 Jan 2026
 23:01:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125134302.45958-1-clamor95@gmail.com> <20260125134302.45958-2-clamor95@gmail.com>
 <d7938728-fded-4d5e-b23d-a8346e3fab46@baylibre.com>
In-Reply-To: <d7938728-fded-4d5e-b23d-a8346e3fab46@baylibre.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 1 Feb 2026 09:01:18 +0200
X-Gm-Features: AZwV_QgtHi-_En-5pR0mvFW293XW7g0IV-2szoIz-T-UyTapQDFggPFL8QY1fqE
Message-ID: <CAPVz0n205rKSAq2Jbtahn6xW2MYgSm61qxjRbsSs_4RBSEs34Q@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] dt-bindings: regulator: cpcap-regulator: convert
 to schema
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Dixit Parmar <dixitparmar19@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 31 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 21:46 Davi=
d Lechner <dlechner@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
> > Convert devicetree bindings for the Motorola CPCAP MFD regulator subnod=
e
> > from TXT to YAML format. Main functionality preserved and added compati=
ble
> > for CPCAP regulator set found in the Mot board.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/regulator/cpcap-regulator.txt    | 35 -------------
> >  .../regulator/motorola,cpcap-regulator.yaml   | 51 +++++++++++++++++++
> >  2 files changed, 51 insertions(+), 35 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/regulator/cpcap-r=
egulator.txt
> >  create mode 100644 Documentation/devicetree/bindings/regulator/motorol=
a,cpcap-regulator.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/cpcap-regulato=
r.txt b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> > deleted file mode 100644
> > index 36f5e2f5cc0f..000000000000
> > --- a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
> > +++ /dev/null
> > @@ -1,35 +0,0 @@
> > -Motorola CPCAP PMIC voltage regulators
> > -------------------------------------
> > -
> > -Requires node properties:
> > -- "compatible" value one of:
> > -    "motorola,cpcap-regulator"
> > -    "motorola,mapphone-cpcap-regulator"
> > -    "motorola,xoom-cpcap-regulator"
> > -
> > -Required regulator properties:
> > -- "regulator-name"
> > -- "regulator-enable-ramp-delay"
> > -- "regulator-min-microvolt"
> > -- "regulator-max-microvolt"
> > -
> > -Optional regulator properties:
> > -- "regulator-boot-on"
> > -
> > -See Documentation/devicetree/bindings/regulator/regulator.txt
> > -for more details about the regulator properties.
> > -
> > -Example:
> > -
> > -cpcap_regulator: regulator {
> > -     compatible =3D "motorola,cpcap-regulator";
> > -
> > -     cpcap_regulators: regulators {
> > -             sw5: SW5 {
>
> Old example is missing the required regulator-names property.
>
> > -                     regulator-min-microvolt =3D <5050000>;
> > -                     regulator-max-microvolt =3D <5050000>;
> > -                     regulator-enable-ramp-delay =3D <50000>;
> > -                     regulator-boot-on;
> > -             };
> > -     };
> > -};
> > diff --git a/Documentation/devicetree/bindings/regulator/motorola,cpcap=
-regulator.yaml b/Documentation/devicetree/bindings/regulator/motorola,cpca=
p-regulator.yaml
> > new file mode 100644
> > index 000000000000..b73d32a86904
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/motorola,cpcap-regula=
tor.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/motorola,cpcap-regulator.=
yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Motorola CPCAP PMIC regulators
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +description:
> > +  This module is part of the Motorola CPCAP MFD device. For more detai=
ls
> > +  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. The
> > +  regulator controller is represented as a sub-node of the PMIC node
> > +  on the device tree.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - motorola,cpcap-regulator
> > +      - motorola,mapphone-cpcap-regulator
> > +      - motorola,mot-cpcap-regulator
> > +      - motorola,xoom-cpcap-regulator
> > +
> > +  regulators:
> > +    type: object
> > +
> > +    patternProperties:
> > +      "$[A-Z0-9]+^":
>
> Why not put the valid names here? Or does the node name not actually matt=
er?
> (in which case lower case could be allowed too.)
>
>          "^(SW1|SW2|...)$":
>
> And $,^ are swapped.
>

This is an interesting suggestion, maybe schema maintainers can
suggest how to approach this? Node name and case matters, list of
possible names is in the description.

> > +        $ref: /schemas/regulator/regulator.yaml#
> > +        type: object
> > +        description:
> > +          Valid regulator names are SW1, SW2, SW3, SW4, SW5, VCAM, VCS=
I,
> > +          VDAC, VDIG, VFUSE, VHVIO, VSDIO, VPLL, VRF1, VRF2, VRFREF, V=
WLAN1,
> > +          VWLAN2, VSIM, VSIMCARD, VVIB, VUSB, VAUDIO
> > +
>
> If these apply to the regulator-name property, it can be written instead =
as:
>

Regulator name does not matter, any name is acceptible.

>   properties:
>     regulator-name:
>       enum:
>         - SW1
>         - SW2
>         ...
>
>
> Not sure if it is strictly needed, but this would document the optional
> property:
>
>     regulator-boot-on: true
>

this is covered by common regulator schema, along with other possible
regulator properties

> > +        required:
> > +          - regulator-name
> > +          - regulator-enable-ramp-delay
> > +          - regulator-min-microvolt
> > +          - regulator-max-microvolt
> > +
> > +        unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
>
> Example should go here.
>
> > +...
>
