Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.84
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792862278;
	b=aPdYXm6HYvA9JqlwRgx2AyJ1iNsmEjRZOZaBrk4dfInBY29AxGybGmWnHu9taoxwxjxf
	 4kHpmm15Zj0Hw5j8ReIPFNc7Pjxf5ayAtylq2uXnQFassH1QEeaBxM/4qLK/3S9hU0JGa
	 SBTm63Eg+o1aAsp2qsh6h5ontv6+zvdiSdTlEidSJTRZQZxnTmbTgyIO+8S+56v6htCg2
	 xzicRA1EKDo0D81kOALJVpip6O4uUQ2GzfjAki56oXZ/pEDqLUmudZWp2xbE3obh7p57Y
	 I0xjX8YwRuoOueHX8zjYXSHuPAM6P5TMh3fHa1wnoq4FKAiDJysmEMWKTpOENmd8kcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792862278;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=/QR3du3ZR7TxGnSlzBaOHpre8JHaWwlpkdHwAjzsG0E=;
	b=FVp7QKTLQVTReQ2DanX8aNchQ7ifG23f28BzGBa+k0wB94mTfXMQlu1apYPSmizOL9e3
	 C08EhlFj31pWAf1Qbrgv6jpBgHW74mmAbYSQRvoe7jo8imxUfxqImL0cmXN0CiVtWB9a7
	 rbEWG7O6PWiEf5LsUcTgT8pDVSkBgoZCMcmrIwLKBVDnFMYo28FTxz0/nNFqSuOq5G31+
	 HVCX5anf9iWkde98MMKCTbRRMODIW+rE5O7js9u+/NCN48E5YjmYRPqUJrz/rZRJNd9rf
	 v30XnxaaC3lJyL6Q1PQCtTNlzHiYBV66wyrIXEU0T3ivZi1Yg6shWIvwcgqSz+dW9sQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=VV3BUSos;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9w+QXjID;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.84
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D876D606A31A;
	Sat, 24 Oct 2026 17:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D876D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=VV3BUSos;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9w+QXjID
ARC-Seal: i=1; a=rsa-sha256; t=1792862257; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UpSOIFOuxxGSTuyq2/HHSepdOQXpQIdcCTw9aH6aChtN4C5AnbXAohQstrSpRxBnAr
    4mn/wEwWUQaPIbazOTwlk+AKpU8TI1HoAiemJNRzNMFxxgginBzS7BP9gvToBwTg0Hzv
    tocFd5e+zLFQmd/7BjgX9zh0wZ9gjm+vgtzpvE/vZqBIhpTSYO/2qaQ0EGNKxk3YfJFn
    l33R2Af2C16PokJ3jMqgpEgMYMaeHIMcq6iBvMpXpzFnJtXRbW5gOdN4S3Tx5uwMihb1
    R7vpZPZUVMPLDQ6tYY8Gl9AW9r6Nq9ziekX9sWBsJd7LkGqLxs/cF6B2Ul+PrQEkgYby
    udpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792862257;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=/QR3du3ZR7TxGnSlzBaOHpre8JHaWwlpkdHwAjzsG0E=;
    b=ZEWXGFrLNUN/s+PNjo2ZbhUe1KPCORZ1Dj7n0GocL/zmsIlgRv5UGyAQa+Gr30Yw7v
    mD0OsIUtY2CH5ramvrmL8K+92co+RmgZ8TJXcqiw4kk6hzXapbHQhglFCw5j5ZAuAbEQ
    uAQJb3nAih2grlFcbg3kyxoyHCw0VEVUSMCgv4jkMH33CnvGawYVw1LX1UjQKHzgEs7n
    IfYUzpTxPqz46GwvY0xDBt8D0d7KrzC8zcc6uDaT+lh5B05JInkRkSdOyoigjxA+cGf+
    vYtZznIpE+a9ijkWJft2c4YPZF6hgydEpEC4dp8RhIpHSAUP4rHKeeXXbJrReApLrrsq
    zhkQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792862257;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=/QR3du3ZR7TxGnSlzBaOHpre8JHaWwlpkdHwAjzsG0E=;
    b=VV3BUSosD9xeDwCmwJgmrIpUdpc4TFkNnBYcv9H0vDvYGgIi5EhzEW9gq+zh6X+gVh
    WvXsnyjB+KB4XKQg7g/FxK4e4wRrZdQ3fIUdVyQDTDjj0XrEc6W4NKlkeORpZA5Ot+2K
    sHzZuOh0OPDV+oRVcEliOMiTHV73mMh0FvoVW+kWFQt6g4Es9DiNcYhz3NKX2ymSUGbm
    bOQWx5XfhOgwp/L8LHS1gGLui2Yg2n6Uac/Z3HZZV0CtSveGbOoMX0WNGj1cso1v1zAr
    Z3nF9j2oCugE/eZF4/bjadO5xno8kc/gVPUUR6QsNDVq4kYrQ8PXZ9AMjaTW+voxgA/6
    Qiaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792862257;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=/QR3du3ZR7TxGnSlzBaOHpre8JHaWwlpkdHwAjzsG0E=;
    b=9w+QXjIDX9jonH63ES/LXLFQ5VZBz9i0tdYw7MSrvIN/8ehBsVHr20OqeP6hlAXvp+
    +RCLQBtQqmXmJhMSvxCw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV2poKzsiNzptYNlV1C1yk7253raiyx+O3Hxli"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a229OHHbwpq
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Sat, 24 Oct 2026 19:17:37 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.10\))
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261023204209.48556-1-olivier@mgcrea.io>
Date: Sat, 24 Oct 2026 19:17:07 +0200
Cc: Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 Paul Boddie <paul@boddie.org.uk>,
 Andreas Kemnade <akemnade@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <998458A1-5304-40B1-947D-C268AA8C067A@goldelico.com>
References: <20261023204209.48556-1-olivier@mgcrea.io>
To: Olivier Louvignes <olivier@mgcrea.io>
X-Mailer: Apple Mail (2.3826.700.81.1.10)

HI,

> Am 23.10.2026 um 22:42 schrieb Olivier Louvignes <olivier@mgcrea.io>:
>=20
> The X1600's SAR ADC has four auxiliary channels and none of the
> touchscreen or battery engines of the JZ47xx ADCs in
> ingenic,adc.yaml, so it gets a binding of its own.
>=20
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
> .../bindings/iio/adc/ingenic,x1600-adc.yaml   | 60 +++++++++++++++++++
> 1 file changed, 60 insertions(+)
> create mode 100644 =
Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
>=20
> diff --git =
a/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml =
b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
> new file mode 100644
> index 000000000000..7886836b10c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ingenic,x1600-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ingenic X1600 ADC
> +
> +maintainers:
> +  - Olivier Louvignes <olivier@mgcrea.io>
> +
> +description:
> +  The SAR ADC of the Ingenic X1600 SoC, with four auxiliary input =
channels
> +  measured against a 3.3 V reference. Its clients select a channel by =
index
> +  through "io-channels".
> +
> +properties:
> +  compatible:
> +    const: ingenic,x1600-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: adc
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - '#io-channel-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    adc@10070000 {
> +        compatible =3D "ingenic,x1600-adc";
> +        reg =3D <0x10070000 0x30>;
> +
> +        clocks =3D <&cgu 28>;
> +        clock-names =3D "adc";
> +
> +        interrupt-parent =3D <&intc>;
> +        interrupts =3D <11>;
> +
> +        #io-channel-cells =3D <1>;
> +    };
>=20
> base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
> --=20
> 2.39.5
>=20
>=20

Good to get such a driver. Thanks.

BR, H. Nikolaus Schaller <hns@goldelico.com>


