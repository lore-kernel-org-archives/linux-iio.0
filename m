Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793884783;
	b=b8Sx9yqSXwHCFSa5T+ESYjFGdes/ORainSPQaXG48QnxVwUdJkSdIinwY5FJ7aajrUT4
	 JNXjRYjw/YhMIay+IM1+/EeDoaeyoJaUIUFzEdGiGJaic2xem1/PvdPcmbPxgPhGZG3O5
	 N5UCpEzqKFXfJfsSbH7nZjmVBYksr5DXoZDX+C9mSomVH8v1egjj9fzwxzxY13OrYfMc+
	 RtiPUl6/VeTLAbg6/NcFDqPczFb7OU2/3ax7uaZq1zgL5Rr/BlMNkQpJ93x3Dmq6MLBTh
	 NGhrkvcGNEmG5FpAd/dPXQDo+RmmEvFDDX17BcVtLM2U6ThrUo/nCZ8fQUpDoOZEvIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884783;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=X3HsR7cVgu3ipBSTvvqrABHt1wBQEWRLRrgvsHdFKuQ=;
	b=IsLveEqp3x1gMM4pxoppkMFQCHBw/CG3CsJVR65EyOri9wRjNWXk3TGe/cj6V45UlL31
	 2p8va/AeC3bhPqTJmoqYKwMdj08uF51UmV/cnyvosSeDdL3YQ2ilTvItNny2QBgFXc2lX
	 gw3j/SwJ5+x3qvKyy80QiFJuvQkJz7G1tMNoa9zhRMXVJ992PyKtN6Lo/I4JFvXy2AP+3
	 5qzOnHjhVQqs+B07xtRs33VH87cyRU8jkzTvf6RoTqOarpmobuVMUeMDCRwtAvIuJqYas
	 9Xteo8AbhTtVoNVQxXGB9uWdXWZa2DOuoNOo1on21ToG4noGfW6OoncsHKv52uClRAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=QNG8Ji3o;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="/RUgeeYo";
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.51
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8F4606A328;
	Thu,  5 Nov 2026 13:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED8F4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=QNG8Ji3o;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=/RUgeeYo
ARC-Seal: i=1; a=rsa-sha256; t=1793884770; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XZ/4lDAgqQ98Y53SaAfy9KBA+Nwn+VMONigDqGjJ0S73ok+wELw/hIiwJp/XE4Mb03
    uvLHOWakjTKPKKphQHfFuswZcS2P1wIU7UWFfqXohwT8gzt+XMZeOEYcF0m4KFT+EcCF
    UTKz8g6zw0ZXv4GueSrFK+gyhCMBl0zOD6VNVy/sPtntZki44PJbklHvn7SC7lZqrYA3
    wosPhBQWtIpihuGn9WC7Ziw0uS+fnqE4DU1OyLbcSUFSyFAvgUDORjNmgpvUaHh2brBc
    byUXurR2XOLYr45xf7WRJOhssm+evhonwr6q0eftNwfxyNo858r/tiMbobk5UdYLh3JU
    rmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793884770;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=X3HsR7cVgu3ipBSTvvqrABHt1wBQEWRLRrgvsHdFKuQ=;
    b=LPIYOGg/MfbPCRD+IMyeKfEy09tckkFPjeDJSi7KSUv7f07OZgd2Ly/1FnvjDaCKvT
    4gD+U+V54qy9qhwoTEzs02mtiUo/btjlkVnRbNN0z5DsO1GukkcJ6ZkVwfujHQzwJeZu
    3Aq7ZnRaHTvvEfSuIFgTzBhfyr9xP/poZXNrKm9fsyOJKYACOMVsE9Yf9rM1heGvzbr+
    rMGS7d8lScyACYkB0aAQal+zDgQ0DGdC5L42KCcASi23sL+2+Q/rLdvw3tU2h2C8kq5x
    h0VZ89FU02oFhyn0XOvUfcZCOcCweJMU5lFSV/g0joujpDsWh6QIML1w5G3J1WrPyTIC
    2rtQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793884770;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=X3HsR7cVgu3ipBSTvvqrABHt1wBQEWRLRrgvsHdFKuQ=;
    b=QNG8Ji3oZZA6c760+KacT+2g4xj9m1teecPkuV/o0VkN5hc83k9Cjqc4NiF7E3Wzdb
    yL56644pyqVUx+m0nj5b47xEuGnPuhmgyhezYtgHwdBRjLbB/QC1HnZ8VEOixPUIogIQ
    utegApBvyT2FLVDYgG43Z3q+HQKo/OEnFoEuJoOcAd3uWAgFKEKQ18i1rmtd7c8nJoca
    x/15JtOo48seBdDeMepJkspdp8C3Bdk8sa2CD2lxWLhmssh7tAT55z0Yo9SfqE8ywRvJ
    H0zNHNbgpnrA6z37pwVYAr4uHNaIwmy+CbDtnFYvPCgy/qampxmPZz1lpMOTch9+b4sG
    +dYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793884770;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=X3HsR7cVgu3ipBSTvvqrABHt1wBQEWRLRrgvsHdFKuQ=;
    b=/RUgeeYoheTfss6h70YIM2WvebI+oIU0dG2IAfl9WmCIuva0Lk069hkMvWVlR5zlld
    VnVInAMW9+gXqKuURKCQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV25oGlMiNUOZNJoYXSTSpu/Ae46f1NE9YxyvD"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22A5DJUj9n
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 5 Nov 2026 14:19:30 +0100 (CET)
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
In-Reply-To: <C0C6F46A-45B7-4B1E-9398-71CD8A26FBD5@goldelico.com>
Date: Thu, 5 Nov 2026 14:18:59 +0100
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
Message-Id: <06B5F20D-1FFA-49B6-9688-4DDE68356BCE@goldelico.com>
References: <20261102201155.10948-1-olivier@mgcrea.io>
 <20261102201155.10948-2-olivier@mgcrea.io>
 <20261102-salute-cylinder-22c9a8896ca9@spud>
 <C0C6F46A-45B7-4B1E-9398-71CD8A26FBD5@goldelico.com>
To: Olivier Louvignes <olivier@mgcrea.io>,
 Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.10)



> Am 05.11.2026 um 10:57 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Hi Olivier, Conor,
>=20
>> Am 02.11.2026 um 21:48 schrieb Conor Dooley <conor@kernel.org>:
>>=20
>> On Mon, Nov 02, 2026 at 09:11:54PM +0100, Olivier Louvignes wrote:
>>> The X1600's SAR ADC has four auxiliary channels and none of the
>>> touchscreen or battery engines of the JZ47xx ADCs in =
ingenic,adc.yaml,
>>> so it gets a binding of its own.
>>>=20
>>> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
>>> ---
>>> .../bindings/iio/adc/ingenic,x1600-adc.yaml   | 53 =
+++++++++++++++++++
>>> MAINTAINERS                                   |  5 ++
>>> 2 files changed, 58 insertions(+)
>>> create mode 100644 =
Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml

one more:

why not call it x1600-sadc as in the documentation of the chip vendor?

>>>=20
>>> diff --git =
a/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml =
b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
>>> new file mode 100644
>>> index 000000000000..f6356ea97980
>>> --- /dev/null
>>> +++ =
b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
>>> @@ -0,0 +1,53 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/adc/ingenic,x1600-adc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Ingenic X1600 ADC
>>> +
>>> +maintainers:
>>> +  - Olivier Louvignes <olivier@mgcrea.io>
>>> +
>>> +description:
>>> +  The SAR ADC of the Ingenic X1600 SoC, with four auxiliary input =
channels
>>> +  measured against a 3.3 V reference.
>>=20
>> The wording here makes me wonder if a 3v3 supply is missing here? Or =
is
>> this some internal supply on the soc?
>=20
> It is an external SADC_VREFP input pin (ball P12) which is usually =
connected to
> the 3v3 supply. But it is specified to be min=3D0V .. typical=3D3.3V =
... max=3DVADC
> voltage levels.
>=20
> VADC is indeed the power supply for the SADC on a separate ball. It =
must
> be in the range of 2.97V .. 3.3V .. 3.63V so that it is extremely =
likely to be
> connected to the system 3.3V rail.
>=20
> Therefore I do not see a necessity to require a separate regulator =
reference here.
>=20
> I would suggest:
>=20
>  The SAR ADC of the Ingenic X1600 SoC, with four auxiliary input =
channels
>  measured against an external SADC_VREFP reference (typically 3.3 V).
>=20
>>=20
>> Otherwise, this looks fine really.
>>=20
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: ingenic,x1600-adc

same here.

>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  '#io-channel-cells':
>>> +    const: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - clocks
>>> +  - interrupts
>>> +  - '#io-channel-cells'
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    adc@10070000 {
>>> +        compatible =3D "ingenic,x1600-adc";
>>> +        reg =3D <0x10070000 0x30>;
>>=20
>> That said, the 0x30 looks suspiciously small - but the region is =
aligned
>> neatly so I suppose it's probably not problematic..

The last register offset used is ADRETM at base + 0x0028. So it will =
fit.

On the other hand the programming manual defines

1.3 IO Devices Physical Memory Map
Module  Start Addr End Address Description
SADC    0x10070000 0x10070FFFSAR A/D Controller

>>=20
>> Cheers,
>> Conor.
>>=20
>>> +
>>> +        clocks =3D <&cgu 28>;
>>> +
>>> +        interrupt-parent =3D <&intc>;
>>> +        interrupts =3D <11>;
>>> +
>>> +        #io-channel-cells =3D <1>;
>>> +    };
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index ecc22d1149d1..fd4bb5c6bf16 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -12925,6 +12925,11 @@ F: include/linux/mfd/ingenic-tcu.h
>>> F: sound/soc/codecs/jz47*
>>> F: sound/soc/jz4740/
>>>=20
>>> +INGENIC X1600 ADC DRIVER
>>> +M: Olivier Louvignes <olivier@mgcrea.io>
>>> +S: Maintained
>>> +F: Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
>>> +
>>> INJOINIC IP5xxx POWER BANK IC DRIVER
>>> M: Samuel Holland <samuel@sholland.org>
>>> S: Maintained
>>> --=20
>>> 2.54.0
>>>=20
>=20
> BR and thanks,
> Nikolaus


