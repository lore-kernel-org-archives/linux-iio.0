Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793872727;
	b=pPMx8wcREH02fTMMxgqmBTB9DH3VFO/YaT8FsD9YkwLP4NhxGhKyOTGSJ1GTOkRjA7jW
	 DADpOE7lSOfxQP//GbigkEDeuLwZTvZOFj6rDUL3YEJj0l3ac+X8VzEygKRSY9tdHGSqA
	 0uRvdwJ8Qs26Ed/14CvT9+kWfELtB6DK3Iae6NPzF2t17a3JTWJGH7zqJxxdoHHrK7skf
	 WX14h2pvOwzun2+GftDAUH1h2bzfVEj8kgxhcrcEspiB/FScJj8+pI1R0OEtEd1ElG7qW
	 eioogIqactd7+IgMYo2gSDHBkUrsHB0PtZCyQZGB5UyFNuJZIBJtnhSyUXHrU3v/tqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872727;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=etX0oM+NPUcyBj4GYfCMypykgn7tdOqFDk42EcZaMdU=;
	b=gKIzWPgcjAzj/l+sKeyLrbt6qe6+UcQLLVS0oEuTJRaTodtNhODSQBAgv3qBx39CbRyJ
	 HTOxm7qNukExMa9LoZkzOhpnbhT8VuncO++lFH2ImYAj2B6SjGo2/zI0rurH+i7bW/w61
	 J+0F0pnQhnMvEFQVTI6xcLBgPgi29KmyKNJg5uh07cHcl804PBPl4kFpb4yu9bT6X9nzf
	 uMqg4fAV5BvSf84Yg1J+Ca8l5rb8CaCdlNbAtTgORmjH+mDiiCPzZ5ZbuvSD6xMc8vLzD
	 LkCwwaunVQhDfa2qXWlfo2Rdx4k5edu/NXEDPlF6HlLwehUg1MzoJhn8Jo7b+g5Og3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=MuwPLE0E;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=2C0YJTtJ;
	arc=fail smtp.remote-ip=85.215.255.83
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0652E606A31B;
	Thu,  5 Nov 2026 09:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0652E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=MuwPLE0E;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=2C0YJTtJ
ARC-Seal: i=1; a=rsa-sha256; t=1793872709; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UAU7tFL6ASXSY5WfQoE+EY69DFAylUSfjkk6FFe9/YueQKCpKq/39gu1XrB5rHzij+
    08joy3O1CPyI3+LkEO8nba02voBPS5BufTkj+wEJBIHmNfcdILnrAo3A8t2Pa/rmNHpR
    6ncPrFH0RwQ2mTNcJiPoGuYXtEzaatAfizzbRWNOxMwIy1KL+MWbihquB05Qdgn8uRAT
    p2HNMa7cgWBVpO+U0BQ+tYRho9AhIk5cAYlyOqUHf8ougnGWJ+5VieW5JSVk9DqLy34I
    F+929gQIsvIZrDISCuQWSTf9UWQNAKNjdqwXUhzWEvUqrNUeIOo6I48UCNuwNIuXGqR+
    FkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793872709;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=etX0oM+NPUcyBj4GYfCMypykgn7tdOqFDk42EcZaMdU=;
    b=IyjgxLGHzWWsmhCtwfV0KSOWsqLb+VSKBTqivf7eXIpIyqH9NePtH/ciY79w8cPuuN
    L9PgtkLcwlNqHuAdTlE2gE0kcJFuvXg/ZfGcBwlHd+mxZ9Qdvrrn8qYc7ZMpDcbwRGKZ
    KV3iwZUT1TRtJz4fykc/Rxnv6q8T80sPn7gsl3M2/NW6G+sLh+xCIQD6NWPCiuhAjxR/
    k6qz4kGKDB0gLDwq8RnEmyDoUSfmYrMuqcqOAMxtQ7/HokbVqpFrP4u+Q5TZMKPoABWC
    CDXOhzmwEXmSEh9DL83GTRqNOyAZLIMJwHq7qqFca9NeRdkrAafukCkg0qxNJQ2U9LZp
    ngKA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793872709;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=etX0oM+NPUcyBj4GYfCMypykgn7tdOqFDk42EcZaMdU=;
    b=MuwPLE0EP7Q+7BN6r8irxnxS+h8RNDUOmjqEy2bWkl5ebfyFrpO6PSLLZN4xruoShZ
    Z9uZmrGWCk2Lh1z4xsv0UubYeucolyNWk6QABsM9DspFfcnFprbDH1QL4JJfzwEW7+74
    qhffCfjCcbV+dJASNNDvBMN39PbINcxkQWQkAUfL4rxjtqdS+YzZsmHU4Z0Gr8cFOuyr
    0dpVkxdrXNWLyT9tXj/iuG41ufCxTDQnWRVdcky/zpzrH6zPGczLrqWvtiTr2D86HKOd
    zKc9lpDQ9s0vhTDv0ce+G0sktilgPJiGrwHlZ3bHq9SUm79ie6BZPtOX0rImsiCyMGE9
    /YuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793872709;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=etX0oM+NPUcyBj4GYfCMypykgn7tdOqFDk42EcZaMdU=;
    b=2C0YJTtJ/OA1gU/RHPMXBtj7uxP9l+gu9vAVdXPPxKeDcMj02c3xpiqN9+Uf5S0nDA
    RYCFZvcmV6xuVwnWHVBQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV25oGlMiNUOZNJoYXSTSpu/Ae46f1NE9YxyvD"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22A59wSi3s
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 5 Nov 2026 10:58:28 +0100 (CET)
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
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261102-salute-cylinder-22c9a8896ca9@spud>
Date: Thu, 5 Nov 2026 10:57:58 +0100
Cc: Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Joshua Crofts <joshua.crofts1@gmail.com>,
 linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C0C6F46A-45B7-4B1E-9398-71CD8A26FBD5@goldelico.com>
References: <20261102201155.10948-1-olivier@mgcrea.io>
 <20261102201155.10948-2-olivier@mgcrea.io>
 <20261102-salute-cylinder-22c9a8896ca9@spud>
To: Olivier Louvignes <olivier@mgcrea.io>,
 Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.10)

Hi Olivier, Conor,

> Am 02.11.2026 um 21:48 schrieb Conor Dooley <conor@kernel.org>:
>=20
> On Mon, Nov 02, 2026 at 09:11:54PM +0100, Olivier Louvignes wrote:
>> The X1600's SAR ADC has four auxiliary channels and none of the
>> touchscreen or battery engines of the JZ47xx ADCs in =
ingenic,adc.yaml,
>> so it gets a binding of its own.
>>=20
>> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
>> ---
>> .../bindings/iio/adc/ingenic,x1600-adc.yaml   | 53 =
+++++++++++++++++++
>> MAINTAINERS                                   |  5 ++
>> 2 files changed, 58 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
>>=20
>> diff --git =
a/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml =
b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
>> new file mode 100644
>> index 000000000000..f6356ea97980
>> --- /dev/null
>> +++ =
b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/ingenic,x1600-adc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Ingenic X1600 ADC
>> +
>> +maintainers:
>> +  - Olivier Louvignes <olivier@mgcrea.io>
>> +
>> +description:
>> +  The SAR ADC of the Ingenic X1600 SoC, with four auxiliary input =
channels
>> +  measured against a 3.3 V reference.
>=20
> The wording here makes me wonder if a 3v3 supply is missing here? Or =
is
> this some internal supply on the soc?

It is an external SADC_VREFP input pin (ball P12) which is usually =
connected to
the 3v3 supply. But it is specified to be min=3D0V .. typical=3D3.3V ... =
max=3DVADC
voltage levels.

VADC is indeed the power supply for the SADC on a separate ball. It must
be in the range of 2.97V .. 3.3V .. 3.63V so that it is extremely likely =
to be
connected to the system 3.3V rail.

Therefore I do not see a necessity to require a separate regulator =
reference here.

I would suggest:

  The SAR ADC of the Ingenic X1600 SoC, with four auxiliary input =
channels
  measured against an external SADC_VREFP reference (typically 3.3 V).

>=20
> Otherwise, this looks fine really.
>=20
>> +
>> +properties:
>> +  compatible:
>> +    const: ingenic,x1600-adc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  '#io-channel-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - interrupts
>> +  - '#io-channel-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    adc@10070000 {
>> +        compatible =3D "ingenic,x1600-adc";
>> +        reg =3D <0x10070000 0x30>;
>=20
> That said, the 0x30 looks suspiciously small - but the region is =
aligned
> neatly so I suppose it's probably not problematic..
>=20
> Cheers,
> Conor.
>=20
>> +
>> +        clocks =3D <&cgu 28>;
>> +
>> +        interrupt-parent =3D <&intc>;
>> +        interrupts =3D <11>;
>> +
>> +        #io-channel-cells =3D <1>;
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ecc22d1149d1..fd4bb5c6bf16 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12925,6 +12925,11 @@ F: include/linux/mfd/ingenic-tcu.h
>> F: sound/soc/codecs/jz47*
>> F: sound/soc/jz4740/
>>=20
>> +INGENIC X1600 ADC DRIVER
>> +M: Olivier Louvignes <olivier@mgcrea.io>
>> +S: Maintained
>> +F: Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
>> +
>> INJOINIC IP5xxx POWER BANK IC DRIVER
>> M: Samuel Holland <samuel@sholland.org>
>> S: Maintained
>> --=20
>> 2.54.0
>>=20

BR and thanks,
Nikolaus


