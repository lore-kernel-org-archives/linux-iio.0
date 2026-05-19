Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2109.outbound.protection.partner.outlook.cn [139.219.146.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA244BC87;
	Tue, 19 May 2026 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183717; cv=fail; b=nPM5lfZm+/ieyiTDvW9XjFExESv8qus9glVHFDtdNlZt6m0uz62yus9XlMl9uTtNx+FLY/sumNuCBgXo5OwJdoCRRdJXqJYZ9nEPRoOkgWXZcyiBZuwg5BNTSm3bZpSRGVeluGDRHo5VqcN3d3hgayv4XGkW+PpuqALcRQQQPFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183717; c=relaxed/simple;
	bh=ZA/ngvh83zW9AY+QF1moXlGE+JsTRfqWxUAeWVyKpQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SzWIN32YQa3FBVikJhYRxeOxxQX6iUcpf2XqlDhsqu0qvdbC31XHDcTecZSG6G5RvjTnsAqoHk5h/Al7hUcGcY1WGfJyLYgxqXYja+lKx6pumGCD/xF1ivespPtCGkbdoHVJ/bXXhbsen/ILQurct7PFpHn/I/Y1yl8K9a7AGnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlDZaS+q3ixtml/7u5/5by2+8DDBMh1Jaa88MhEcnWIfMhJLzXDDxDFDOLtl0R1BlXma3QGd1wvoVPZP/tg7tmX5/iTTLKyx/tQziVnz/ksh89g5hgPvz+ah/gL6S4QKG8TNE83oh9TfkcqG+omnhwMxFUMRLkV8ASGOo6Ubk0LpM+HBeVIzYm80B2XMmO0M7ZKjhg1kKtRHBZoFaxSPI/qwiPEPDac9GHxVe8ZGapXTtAb8KcZRMSUmN2K+tLwcDqL1DhJMnG+GHvr/sBFgIkTg0c7+Dg9PYRsj3g+iHYKZTINYr/1Cmbw7ZONt3RLFPnFIu1dwsnbhzWWXhAPmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R15vZSfZa2+Vlod42+lBxtDMV0z08t8Im0Fwunue2Ck=;
 b=ILRVtAVJbvHlZ/N9vU1qRC7IYYg5+RszBfk7grie+5WQggpY5H5y+0pzxWr08I+yO1ZcLTbS/JwlVfG/V044OVNFO/TYVktztMQr+vxNJ1e2E9DAxhDmNq0K1UqFuHtutjKkKnIczLTH8AQCBFr0eUsV65/eSAbKZIVtjUb9LNxvciWUz8Ea4OCXNWfg8oJPs+Ne2fCLQI2+/RzFTWXrIW+2wH8jK5i7l7EVU+5XveIwNMHsmWrzIB3e9JO6f7TUJM1ARQ3r16i7LQaxrSLhlDGlGauw+Bcllm0gDYIrb2DIaPAaHsEvfHIZ7higr+Txesiv6ytfAYDaZ7iYMEzKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1131.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:26:03 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::d8e2:3f39:6ae7:bdf2]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::d8e2:3f39:6ae7:bdf2%6])
 with mapi id 15.21.0025.023; Tue, 19 May 2026 09:26:03 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] bindings: iio: adc: Add StarFive JHB100 SARADC
Thread-Topic: [PATCH v1 1/2] bindings: iio: adc: Add StarFive JHB100 SARADC
Thread-Index: AQHc5p77jQOM2JwohkK7qO7svRU7q7YT+EcAgAEVtmA=
Date: Tue, 19 May 2026 09:26:03 +0000
Message-ID:
 <NTZPR01MB095679F35A873BBBA304655F9F002@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
 <20260518081852.116909-2-xingyu.wu@starfivetech.com>
 <20260518-elderly-barman-2b1abfc3755c@spud>
In-Reply-To: <20260518-elderly-barman-2b1abfc3755c@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1131:EE_
x-ms-office365-filtering-correlation-id: 585f2391-fb3e-4bc1-b93e-08deb588a5d1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003|3023799003|4143699003;
x-microsoft-antispam-message-info:
 ZMUgHka1OmvYiPlamKe0+lhSNFA7MFIKfjAg2F1dJRssucSgmGxqakar40X9wa6hfVgIQ/QloGuc7wKXS5uA29gECPWRbHJmVpjbeGvY/w8NNde40eN10BzVqwxVaTs5UHr/Xp728sETj8Py0Boqa1I5N9LbOw3JG5zuS3FhWQUhybaaq4xiZ9x8avhqztSUbLxCJjuMVxM/g7Upn6LaF+h43Mm17rrW5lBfHeoRJ7DdTxZSU4lRTOAJaD+S8x3yvbYemaSl10pakgKVFporDae+9fhuXJgG8aoxVNhwCH3JWKaOvh/0Q1uwnVSTp1FFq22jq9EB8vGhWuHsEbvYMwtlM2F2YOjfmTNMl8qoY/hVDlZaxUJoPw63OehAG848IufzlR7/DAnmfglvwI6AtmMv137PtofkvTjXySAHwq8NcSIUK+ziiOswlrSCiXCj8QxdH/PHoqAEw4pwqLnhFqS4BogSIULIrkTv9jt2wDEKt3pL9W3a1r8OCTBFxNWi6xzG4LzoevM37yq3F/0PfVETXf9a/QhxCb+j0L0ID4rILPFtZA+EhzyogAJqrNBc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003)(3023799003)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?69eyczeGgiYcuoNSPZftT2m/jJ/qYgaWn5bjmrizHZ+firkaKHAYNdPOvH?=
 =?iso-8859-1?Q?wUvwWKQhaNKMTbPpSGseTylwnA7u/0w7tWSRLz3VmgMcG062Xu747qxGXT?=
 =?iso-8859-1?Q?a6myA02+Rt/A/WEx5+bEQS2vpFK2Wp55k/NbnxaQAmz2sVDdXkutL1I6Xo?=
 =?iso-8859-1?Q?gqskAsOHW0M83H3RCVTyIj0TZD9VvSPM6+OX5zQP9JyiPQndc26M64PWql?=
 =?iso-8859-1?Q?vSEWV87QfSTEy74tWEFujwtirs0ARlkb1YGTfnYdWDMLgtc4q5qzaEJyy8?=
 =?iso-8859-1?Q?PnOC96x2BlN7iDxn2OI3QUf8mloHKYNiKiksZhlt52CpI+nknYI99zv7Me?=
 =?iso-8859-1?Q?Z2s5bsYchjg0bByKerpjynYQlfKql0Rx4j5aPA4OqkYiWMAmPeYzgR8FYl?=
 =?iso-8859-1?Q?Ll5bIuOwOJluylYU3Qf8LVDAY8l+3XFn/3Gc+dfsxswfoa518f072ksMnp?=
 =?iso-8859-1?Q?udCzYPEv5guxN28AV3DoRPdZYjlQWlOI7X/TYLluM0Qh7xgEAxioV1Fjtf?=
 =?iso-8859-1?Q?Uy8Myoe0PMQGYMN3zmfN75FoLRTxqWMChGIRaiEweIEKalcO7lMomXLEEa?=
 =?iso-8859-1?Q?Su4w31ZiasxfIo6IHcWXXhrPrkGb8pIzQ34YuzjOUf4wb2cZYW4XFWBqVK?=
 =?iso-8859-1?Q?pYVV4tNM4MZTxAv08qY1Ga8+Ft1b1wQEUs6j7HvDbEfvPUg4+GJrv/7Z8A?=
 =?iso-8859-1?Q?E3FWz1g8TQdWTrQuCezX3wgxcnYZ6X11g9yCgq+h3VG/4aXaGSFfDCI3Xr?=
 =?iso-8859-1?Q?vbp5LCnFeqegOdvzbfEbqcToY3ky70Ra9M2nOPprEb9RX1JCUtlvOTQtq+?=
 =?iso-8859-1?Q?o3aMBJzrvw04e0NafBOuysXIRgMDihCrHxuJxPakKHo1QFFAxkol86/Jxl?=
 =?iso-8859-1?Q?k3AbU0dakrNXz7KNDV1CLehw4SgFt6gyLKwZGRf1p+z8bc1ys5cZ2iWuR+?=
 =?iso-8859-1?Q?nr0DbbilQ7Y1tcxieCFViMEHA2yhM8AUzNu590B+3ghbGtxoQrfn0TBU+h?=
 =?iso-8859-1?Q?TL0uea0v5hnPkdavEqMSEmunfmUVPQM2OGZ5VjEItGE91pryjYiPpCm3Wx?=
 =?iso-8859-1?Q?l6tZ8Fa4z7tclvtPZYDQ/cQkZQWE3BaQ4J7S4m43s0TrJTJUfblq4SM9fY?=
 =?iso-8859-1?Q?MUTHa4gU4r157Dur9HTwB388QiSiSvIFZQOoECuOUSOJu3wEcBFtlicr+S?=
 =?iso-8859-1?Q?cpuc9YN3sCQdn/VTqWKwb2UV2Pua0kUofFlsybeZ90B/SnruULAu8A9ycV?=
 =?iso-8859-1?Q?r9sZxd+Enzpvf3DP1g3YLgiYFiiqsiz5isfL6rKtAt4VHAyNb2t5wQeFMR?=
 =?iso-8859-1?Q?dOYIxMdsSZm93DBTJXzS6VJdGOiO+Xz6w5aJnp0/mqTTCqq8HhZym3tG6Q?=
 =?iso-8859-1?Q?WFlPnEB1n5lhzpB/xY8CkYDe5qJLz9Rtp2J7MFWeHdfTQ7BmNDV9yLLDQd?=
 =?iso-8859-1?Q?5/arqOsb6X8XMsPPEL2ZX3aBANJKb68j/MojtDTTGv186Zw42OYd78Yt9u?=
 =?iso-8859-1?Q?b3yd0hCmTNiUbbwWgrQUsTrxLwAqt//wfsvKdKGDczNPgLbH4XH02UIOKA?=
 =?iso-8859-1?Q?PIsLNWY9bnyHtIqWliCUyE3dtAO4pre5tNxduc16jgwOFMgdPGR2Rfgyi2?=
 =?iso-8859-1?Q?Y2NL8Xtr9vA/wqLiRDX1LCGkJ1fbWj9gJ7kUq7TSXB0kjeL/9rdCACpy5R?=
 =?iso-8859-1?Q?Hs5z2BA2E6RIJRSNz9iw82pk5nADTuZbEVFBOpmEFAkKu0LeRZN1/8f6ZB?=
 =?iso-8859-1?Q?Xix42RK15o/AMh5Xidq0u7e4sm3j8V4P3SuaTOGEE+eLa4Kv1wWVht5WF0?=
 =?iso-8859-1?Q?0rJZxALXxw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 585f2391-fb3e-4bc1-b93e-08deb588a5d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 09:26:03.5183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vmyRnpAYZ/COrar7aQTF24C5ufeidj+BivrnrVYTQ8gERurgneDxakEBZvu8Rb1Bnuih33YuNQJODx8suIZI3KQFLG+36hIAma9IiHA+Niw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1131

On 2026/5/19 00:24, Conor Dooley wrote:
>=20
> On Mon, May 18, 2026 at 04:18:51PM +0800, Xingyu Wu wrote:
> > Add the new documentation of SAR-ADC for the StarFive JHB100 SoC.
> >
> > Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> > ---
> >  .../iio/adc/starfive,jhb100-saradc.yaml       | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.yam
> > l
> > b/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.yam
> > l
> > new file mode 100644
> > index 000000000000..ba8e19b72ad7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc
> > +++ .yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +http://devicetree.org/schemas/iio/adc/starfive,jhb100-saradc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Successive Approximation Register (SAR) A/D converter for the
> > +StarFive JHB100 SoC
> > +
> > +maintainers:
> > +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: starfive,jhb100-saradc
> > +
> > +  reg:
> > +    maxItem: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 2
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +  upper-bound-mv:
> > +    description: The upper bound voltage value of the monitor.
> > +    $ref: /schemas/types.yaml#/definitions/uint16
> > +
> > +  lower-bound-mv:
> > +    description: The lower bound voltage value of the monitor.
> > +    $ref: /schemas/types.yaml#/definitions/uint16
> > +
> > +  scan-freq:
> > +    description: Number of the scan cycle interval.
> > +    $ref: /schemas/types.yaml#/definitions/uint16
>=20
> Can you explain why any of these three properties are something that shou=
ld be in
> the devicetree rather than software controlled?

My intention is to be able to obtain the initial values from the devicetree=
 during probe and preset them.
Do I need to drop them and just set them through sysfs?

>=20
> How are the bounds calculated?

The measurement range of this ADC hardware is from 0 to 1800 mV. This set v=
alue cannot exceed it. This explanation will be added later.

Best regards,
Xingyu Wu

