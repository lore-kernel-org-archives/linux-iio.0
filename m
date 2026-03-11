Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3F3DE420
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230237; cv=none; b=qwp7kBy79tmipGhAjEwhvw2fVkwKJpppbWQY/C7Pg08KGag0CgnM2pBn4yec5CRVAwQUgbeyslpWBjkT3HRL6ntkA52S2oB2mtJ62HRm/yjNI9Ck7W+PbTYdwbcau0mMPZfnPZ+AC/C+kfc3kkut8f/IfCUTIOgde/AzEDszN6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230237; c=relaxed/simple;
	bh=zqt1TJo6M5ytVgoiQO4PNEkMGsD06msQOJ67zLe/YZQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i5IOUkvK2mYgmJNdpsyvZr7tgmqxoy1qt11qphdzjZiFo9AW25DAcLXY9FgiKCp6I+F3ZQsuz/urS+NBxI1Ag1huJU71nLB1ncOiALUz0yF+z8cVkETc4JR/QqrHNJuTPrvi7eEh2vN3p1y7nAClntz7mAKC9a/Al+JCcDDqxEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUz3g2Ju; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUz3g2Ju"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso26517785e9.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773230233; x=1773835033; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zqt1TJo6M5ytVgoiQO4PNEkMGsD06msQOJ67zLe/YZQ=;
        b=SUz3g2JuSj0UmQYfQ/A0s/awEkP9EdpgvhQLowuko5kEM5/Slvj1nvL3Q9ELk3EMVg
         oZN773twe147kv2CTAmGXNnqkBhSk4Auvu0TISOdj0PAoLrBdEwpF4apQ1LSnvxTSDOM
         7GHbrp15fjBnAFwQqOP20qeTFRhjrC6pzp0t1sl9SLbWt7kAIvQ44T6xhGlzfL6gFkie
         p+NZuCOf+lAGx3P50QrTg+6epXqClY+Z5U1INaCsI5ZTZaL1EPg8OR7K4cT1XtUKfheS
         AudaosZG9M8ESGBW8fjnyXEhnXhy6CduMTxara3s10NwI7NRCgMc821iUAqnasn8Rqqo
         WflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230233; x=1773835033;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqt1TJo6M5ytVgoiQO4PNEkMGsD06msQOJ67zLe/YZQ=;
        b=kp+dFjjpMQ3vZ7FDymGT+/xG8TcKcX9xu+WaTcaXctKSv3FL0PphBLxYznPAAyQzA5
         sF0A3wj0uM8I5KB6DDN5XMRfZKIUMASUU9DP1kiaJnZYP/sNXYdGHSJCaTIkXnG+ck4b
         IjyX5B/1viOni0ZwDNvTxBdeQt6uGI2xTqnzp8WwABPLLFtrKst6r8e6UlY3PgvU19YS
         UNsCreqWtfmpo3oAIv8uicUmyEZkNVmeZKNrJGQau3m0AAAujVt/Wt2e/ZaR3ld3V0//
         VAXK4k476jxwTSiFNrT86MsfeXEiGbbKOZTjvBm6vkSMJxMfuXA86b/E6p69n9ZL/GX+
         AkGA==
X-Forwarded-Encrypted: i=1; AJvYcCU6So1GCEF0MWQVGhFLwuOumpCIQJIeTODhSTWDHuZtsDZy4AyXWAoOG1pbceejJOc8vPbzsD49PuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMZXWoW3B8mw+OB8r3ZtcyDpih1HPjhBnlu4tjV2L1p6/ZXItr
	y29BmjjQj4CerMRiAENrS8gPZLix8iUKFsa1jaOz/+NplpINVxX4HpCN
X-Gm-Gg: ATEYQzwgagFUDGJzw5MWQSU9f0v/HfVVdXkHsq9IAa6lySJqW0RxYwP6GQIzp8MwaIk
	vFHr+9/ngLvFECVeW+i6zgvxYXyeprbC9ujF06ih4zA7efbQ0W9WpWcurcuuuysktVZHx8cNtKP
	Sqj+y8gFjUPe5iiaa4Cd1ZeTCromEK1yzFR55rdYzb8MaM/HOkhxhXow5L00nfKF5N1uLvOCKBx
	li/azPqNAhLOGrs5iyscKGNVavBbRjVAjABCSrRVv8MaH3mahFL0754hyborKf4e+SpfsT59mu0
	K4T9l6DOOPTLCETS3FXAfD6nMaQFtPsZCV7latdiiolVBGQS8HQazCD0DJ5eIz5cXCWgt4rBgL1
	61ngAOpjC6OppylzEh2f3Rdn4VxthgZD5RmlsYUAh9dOC+ay/vAOBML/Tm/R4/cMdbOfa+7QRVN
	b4+7LZBmLO/kuqwHCMhLonbnnbMlqpIF4=
X-Received: by 2002:a05:600c:138a:b0:485:40c6:f507 with SMTP id 5b1f17b1804b1-4854b136ac7mr38643825e9.30.1773230232448;
        Wed, 11 Mar 2026 04:57:12 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0d4977sm17543575e9.19.2026.03.11.04.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:57:12 -0700 (PDT)
Message-ID: <a79296dc96215a579c29c5c9eda464f818f050d6.camel@gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: dac: ad5504: add output-range
 and missing gpios
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	skhan@linuxfoundation.org, me@brighamcampbell.com,
 linux-iio@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski	 <krzk@kernel.org>
Date: Wed, 11 Mar 2026 11:57:56 +0000
In-Reply-To: <20260310174835.24209-2-0rayn.dev@gmail.com>
References: <20260310174835.24209-1-0rayn.dev@gmail.com>
	 <20260310174835.24209-2-0rayn.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-10 at 17:48 +0000, Taha Ed-Dafili wrote:
> The AD5504 output range (0-30V or 0-60V) is determined by the R_SEL pin.
>=20
> Use standard output-range-microvolt and range-sel-gpios properties to
> describe the hardware configuration of the R_SEL pin. Ensure mutual
> exclusivity using the not/required logic. Additionally, add missing
> vlogic-supply, clear-gpios, ldac-gpios and datasheet links, and provide
> a complete usage example.
>=20
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
> ---
> =C2=A0.../bindings/iio/dac/adi,ad5504.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 40 ++++++++++++++++++-
> =C2=A01 file changed, 39 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
> b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
> index 9c2c038683b4..c0b2d470949a 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
> @@ -10,8 +10,10 @@ maintainers:
> =C2=A0=C2=A0 - Lars-Peter Clausen <lars@metafoo.de>
> =C2=A0=C2=A0 - Jonathan Cameron <jic23@kernel.org>
> =C2=A0
> -description:
> +description: |
> =C2=A0=C2=A0 High voltage (up to 60V) DACs with temperature sensor alarm =
function
> +=C2=A0 https://www.analog.com/media/en/technical-documentation/data-shee=
ts/ad5504.pdf
> +=C2=A0 https://www.analog.com/media/en/technical-documentation/data-shee=
ts/ad5501.pdf
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> @@ -27,16 +29,48 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> =C2=A0
> =C2=A0=C2=A0 vcc-supply: true
> +=C2=A0 vlogic-supply: true
> +
> +=C2=A0 output-range-microvolt:
> +=C2=A0=C2=A0=C2=A0 description: |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Specify the channel output full scale ran=
ge. The R_SEL pin
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 determines if the range is 0-30V or 0-60V=
.
> +=C2=A0=C2=A0=C2=A0 items:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: 0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum: [30000000, 60000000]
> +=C2=A0=C2=A0=C2=A0 default: [0, 60000000]
> +
> +=C2=A0 range-sel-gpios:
> +=C2=A0=C2=A0=C2=A0 description:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GPIO connected to the R_SEL pin to select=
 the output voltage range.
> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> +
> +=C2=A0 clear-gpios:

I would match the datasheet name. So clr.

- Nuno S=C3=A1
> +=C2=A0=C2=A0=C2=A0 description: GPIO that controls the /CLR pin (active =
low).
> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> +
> +=C2=A0 ldac-gpios:
> +=C2=A0=C2=A0=C2=A0 description: GPIO that controls the /LDAC pin (active=
 low).
> +=C2=A0=C2=A0=C2=A0 maxItems: 1
> =C2=A0
> =C2=A0additionalProperties: false
> =C2=A0
> =C2=A0required:
> =C2=A0=C2=A0 - compatible
> =C2=A0=C2=A0 - reg
> +=C2=A0 - vcc-supply
> +
> +allOf:
> +=C2=A0 - not:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 required:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - range-sel-gpios
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - output-range-microvolt
> =C2=A0
> =C2=A0examples:
> =C2=A0=C2=A0 - |
> =C2=A0=C2=A0=C2=A0=C2=A0 #include <dt-bindings/interrupt-controller/irq.h=
>
> +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/gpio/gpio.h>
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 spi {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> @@ -45,6 +79,10 @@ examples:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
compatible =3D "adi,ad5504";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
vcc-supply =3D <&dac_vcc>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
interrupts =3D <55 IRQ_TYPE_EDGE_FALLING>;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 outpu=
t-range-microvolt =3D <0 60000000>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clear=
-gpios =3D <&gpio 4 GPIO_ACTIVE_LOW>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ldac-=
gpios =3D <&gpio 5 GPIO_ACTIVE_LOW>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> =C2=A0=C2=A0=C2=A0=C2=A0 };
> =C2=A0...
