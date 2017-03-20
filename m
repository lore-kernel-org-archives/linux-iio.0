Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49270 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753082AbdCTLeR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2017 07:34:17 -0400
Subject: Re: [PATCH v4 00/18] add support for AXP20X and AXP22X power supply
 drivers
To: Sebastian Reichel <sre@kernel.org>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315121450.bl5dxdjzazwsrvni@dell>
 <bc829791-c543-220a-8c42-1023b1a82963@free-electrons.com>
 <20170315224647.suhnptpczykuoffd@earth>
Cc: mark.rutland@arm.com, thomas.petazzoni@free-electrons.com,
        lars@metafoo.de, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, liam@networkimprov.net,
        icenowy@aosc.xyz, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        bonbons@linux-vserver.org, Lee Jones <lee.jones@linaro.org>,
        jic23@kernel.org, linux-arm-kernel@lists.infradead.org
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <949439a1-2f66-bdb7-04ae-ff88cb388809@free-electrons.com>
Date: Mon, 20 Mar 2017 12:34:03 +0100
MIME-Version: 1.0
In-Reply-To: <20170315224647.suhnptpczykuoffd@earth>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pE3kLq2VUmLKRXlDBcl5wqJVt3Ww75cs9"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pE3kLq2VUmLKRXlDBcl5wqJVt3Ww75cs9
Content-Type: multipart/mixed; boundary="6meQQ7dbmtxsCQ0fNBMeQMXM8homfNm16";
 protected-headers="v1"
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: mark.rutland@arm.com, thomas.petazzoni@free-electrons.com,
 lars@metafoo.de, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
 liam@networkimprov.net, icenowy@aosc.xyz, pmeerw@pmeerw.net,
 knaack.h@gmx.de, linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
 bonbons@linux-vserver.org, Lee Jones <lee.jones@linaro.org>,
 jic23@kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <949439a1-2f66-bdb7-04ae-ff88cb388809@free-electrons.com>
Subject: Re: [PATCH v4 00/18] add support for AXP20X and AXP22X power supply
 drivers
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315121450.bl5dxdjzazwsrvni@dell>
 <bc829791-c543-220a-8c42-1023b1a82963@free-electrons.com>
 <20170315224647.suhnptpczykuoffd@earth>
In-Reply-To: <20170315224647.suhnptpczykuoffd@earth>

--6meQQ7dbmtxsCQ0fNBMeQMXM8homfNm16
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Sebastian and Liam,

On 15/03/2017 23:46, Sebastian Reichel wrote:
> On Wed, Mar 15, 2017 at 02:18:56PM +0100, Quentin Schulz wrote:
>> Hi Lee,
>>
>> On 15/03/2017 13:14, Lee Jones wrote:
>>> On Wed, 15 Mar 2017, Quentin Schulz wrote:
>>>
>>>> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose=

>>>> information and data of the various power supplies they support such=
 as
>>>> ACIN, battery and VBUS. For example, they expose the current battery=

>>>> voltage, charge or discharge, as well as ACIN and VBUS current volta=
ges
>>>> and currents, internal PMIC temperature and ADC on 2 different GPIOs=

>>>> when in the right mode (for the AXP209 only).
>>>
>>> What are you missing from this set now?  What Acks etc?  And what's
>>> the plan with regards to route to Mainline?  Where are the dependenci=
es
>>> etc?
>>>
>>
>> Basically, a consensus on how we should named the DT property I added =
in
>> patch 01 and 02 (which is used afterwards in battery driver). All othe=
r
>> patches have ACKs.
>>
>> I added some logic to the battery driver so if anyone wants to review
>> that you're welcome. I already got several ACKs from the v3 though.
>>
>> No dependencies except for the battery driver (and the first two
>> patches) which needs the battery "framework" in the Power Supply
>> subsystem. A v9 of this framework has been sent a little bit more than=
 a
>> week ago, I need this to be merged first or the battery driver will ju=
st
>> not compile. I think the other patches are ready to be merged.
>=20
> FWIW I expect, that the axp battery patches go through my tree, since
> there doesn't seem to be a compile time dependency to the other
> patches from this series nor vice versa. I'm aware of the dependency
> to the bq27xxx series of course.
>=20

As there are still some discussion going on Liam's patch series on which
my patch series depends, I propose to wait for it to be merged and then
I'll rework these battery driver patches. Is there anything I can do to
help the merging of Liam's patch series?

Could you ping me when it is merged? The easiest way would be to Cc me
to the next version though so I can follow the discussion :)

Thanks,
Quentin

--=20
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com


--6meQQ7dbmtxsCQ0fNBMeQMXM8homfNm16--

--pE3kLq2VUmLKRXlDBcl5wqJVt3Ww75cs9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYz74rAAoJEIS4mnU+4PGjP6IP/0x8dMVIw2/rteKsRldh1jmR
I3//Gtvg1oFYfV4CrFPRcNKZ/sBb3c14BYOJiT/Bubx1LxUXxcQ5tvHBBEF7t++A
6XZnOVrqR/vnEgOHbwHQO4k87SSqFgN1Tbetxwe4FCZrKovnzbMEmSYEYqZRNbB1
W4sd9tQS43ZIsquT0GDBvsvGMgDqB3YXM/ulwUnuPHlRwq2nF1CYTEL1CltEvjFa
z7iifoKF/2wMgx1zFwCUgis1e2VXrP4lkXswm+Cg5BOR23Q8Q71DJVe6GPAglqSN
ZYt2gQgyl1BpMXvQUIX3OE7ImnNIfEk+jNCiosyke68pI/ShPg0SEd2/4Eyu68ZR
kCQ7wTW2bcJl8yo3TmNWvHYID4ZJzFx9MXgKuuN2PU4BWObc3pGFrVdTEzvv3GZl
9ZAGU5sk8aop4e8W+L+JnUPlL3TJ0ryCmyDapT02b3y27xeL8gibdeRZhcRpcyLo
eiVzjGbJizIowCdlJHir3feBFqdamwcAuBbGTk0uvokPnMoVunFORduhxROJoyk1
2Ywin7pTbzlfUsXPLARQvLpi5hmKO6Fn/r1xeGR4Ti86niGMLMO2cL2JyvcPOEgW
2ajtbIYO5F5Zd8d8KfS9NnCy1Sq+rgNzBQyMU5zT0yxEn9TDToBzJdIdIUmlKN2J
j/dhMzBCGnYsUa6g+eeH
=yPq1
-----END PGP SIGNATURE-----

--pE3kLq2VUmLKRXlDBcl5wqJVt3Ww75cs9--
