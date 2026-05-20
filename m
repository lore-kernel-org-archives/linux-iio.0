Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2093.outbound.protection.partner.outlook.cn [139.219.17.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A9D3B3890;
	Wed, 20 May 2026 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270199; cv=fail; b=ubcpQwQQHpxTC+oKvN0EY84wOWroj2MbXvDcum3OODjdq9F8FhAs3rwzYj0N0sMonIkh+cTsb5dXPm6wuoy3mpZX2cyMWVpxBC2yBDrJPnKRvp66KxqIJZWcE31kBYl4LYA5cjziOmZyM6cfzGbzi/haPJoyHgTkQP6HTcpvkYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270199; c=relaxed/simple;
	bh=JKT6iFwCoMlnBhsn0DGGNVBl3RzdNo95TQMhYHWZRCk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uOFanTtdcPYgeG9IroOLezakjwYWmafm20ym1un7ffFjVVZL7U8YlW6CRokwFhtwt4Jxml6IhFBUWKq49ujtevrziLNK/ZuF426hmbnVX7fnFjhtY9LlIB6+Z0+NPX9T1l6IyY58IVnLT/BUPG+pDAsQeKyIF6j/R7gzwgW/oRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXCh1J3scJYf9zCPNXjje2IYYw693/SglDZc5p6FVhveCLv+xUszEpeTJ6oaLMjqSL67gDFp4isCEVDfqQ42TrltW+X5q6vhrtzGrNQB9u3BoE6SFLMoixIZEm8L3PLP5cZkdMpVqxhNBFMv7UZ7eZi0Z9h/wpb6eAVToz2C4lQjUETQKc7u8TMuh4wNC3NfhOezEnpkJGpffz67nHJuvR+Ky9NBYBiQwzlGe+tp0lLG/8OawE0guIAuDjZFvDR326EKy40VfQo6fGXwlXHOrpsPxfE1ZC1sIVp5BWstAjvj51DD9enwjGQ2gr5yQ1VpBvbbjNRgw/ZZmwgxxvAuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tbg8AUv3/JyYucfyPeKMp3PnrQ+8s38w2VG4Myh+Za8=;
 b=OkxYBTK+XFl1fD6qw0ZZO/uGQPaMDVsQ+sFHfPc1yq/uFhx6uq2tc6ry4KndJ+QQWatL5/ipE+NLHm286xEk3NKVSw/hyy6b26gEQe24pj9hkq22/yV4ydxdpA40y4rIJW+0NJx0wnOJ750waBRmr+hDo3NUgC9mfjeIBDSkjYi2qDJjyLL1kRxMDM2Nq3VYwF9NTaEMuoCL1XL7LSLE+GT+xJ3K8Cs8aEh3mHLJBuHAy5N403Xg4Gh45jA/XUy8Bji1yJH9xjfOY7kHe+tnXspU6rV9Hs066DP0gdLKIdgUzwV33Vd0LdW7rtLgQPLr1LuOTVGZtQ1ss1imgRUyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1131.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.15; Wed, 20 May
 2026 09:43:02 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::d8e2:3f39:6ae7:bdf2]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::d8e2:3f39:6ae7:bdf2%6])
 with mapi id 15.21.0025.023; Wed, 20 May 2026 09:43:02 +0000
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
Thread-Index: AQHc5p77jQOM2JwohkK7qO7svRU7q7YT+EcAgAEVtmCAABFGgIABhc1A
Date: Wed, 20 May 2026 09:43:02 +0000
Message-ID:
 <NTZPR01MB095657AA216608109BEF9CBA9F012@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
 <20260518081852.116909-2-xingyu.wu@starfivetech.com>
 <20260518-elderly-barman-2b1abfc3755c@spud>
 <NTZPR01MB095679F35A873BBBA304655F9F002@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20260519-undoing-ambitious-012d608ebd7f@spud>
In-Reply-To: <20260519-undoing-ambitious-012d608ebd7f@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1131:EE_
x-ms-office365-filtering-correlation-id: 3e5c7ed3-97f3-4f5e-e71a-08deb6542fa5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003|38070700021|4143699003|3023799007;
x-microsoft-antispam-message-info:
 Dr+L/V0p2s8kqo1Qf+SWEB2er6bfWRmCL0cMRvQQ7D53DMFl2/xsEAVMa5qcm+o2uQLskBhxq9QklyOK5oswnrm+nZWhqkTMs5ekXLskWaFrt8Q46IvzyP47GuX5NEMQRceXT0RHam9EcvIBSVFKTlqDxe09qVirCRsQsdhk+a9dPHp4kk/uqSakJoGpth1Z44Brrvixpavi0v0qqbezwJCD/ev+VCqogYSfni6alBha0DtuQduqgsRADUB6CFc/62zc3U6S00JrHPIl07e8XCHbvhaqbbZD5L4FIM1g34KtM0qCr0vnR7SIWWZSAf655dxkl8JgwvT9DaIXolBOz+CF4okEZOnnrvIf6ZgxF5BRYfiygf3fXS82aLX/0v0VIe4ir17OyEzFemS2wyykfRwV5/hYAOYDfpUk7BgjSPvlqs0tv7ALMCF86o15++BqPLA/kFCZqI1vWxqCG95alSwvmERm7gcA3eIl+SIoIslW/EHNKDI082ZTy8GVhzzefEQ9f2Q386r0WiuZt5v9Ntz4bYSQnu3qeBKMEtSP9jBdfyFI9L4nED9nDdngGu8l
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021)(4143699003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?S21sWxl8HylSIpSVybq9OvKDJiMa8rGrQbdIUHCbz01WunrH5jjsT7PotQ?=
 =?iso-8859-1?Q?Ti6LVWO8dAQtdONNyf70eZgYqWma47WoAQv/7aUGT3S9RGPfZfC3yO/znr?=
 =?iso-8859-1?Q?zy57x0mIOhzxWVb5TERAEAfA04QixoSS6zWi38ScjLX/m+xxCWBG2VD3Pp?=
 =?iso-8859-1?Q?292NkaddslZrASaKQ6G8htvPyxzzhSsLpPzpqrAfDk4S5CILgNWPOyA03k?=
 =?iso-8859-1?Q?34kr70BF7KnjRUtMEGWTvYLYSt0/ZwhEQObnoDVzIell9PYarDJJew7SPZ?=
 =?iso-8859-1?Q?EW4W+ikivyBIrr9KOGf7C8QYfTtUyWNk19bccBnqsYKtAPp987K+T8lVs/?=
 =?iso-8859-1?Q?+wXI/B6gyT0QYzqzISg6ZuqTEoKJZP4W8qtdMieLBnQBfkNAseHT955ecg?=
 =?iso-8859-1?Q?TJB3/0hixUGUTvEiExEVl/7mWPi27qxmWK+R0J/6Yr8HEw1t+4/qrxoSzn?=
 =?iso-8859-1?Q?hlz4qqB5Os9W1JCJCYOwOLqDg9tGhqAGXac4q6T8x4ck94oldhUCSAPIG9?=
 =?iso-8859-1?Q?534khaD3AxTpqcYf8cdqLI6LByGUmF1xcIY79v3LQyWJ4s+3OF2JAT9q5y?=
 =?iso-8859-1?Q?MNuo157or+H7nHTpgTw8FZkJGwrmCMA6DoSTTCm8VdZJJ11W5ZF+WJSa+g?=
 =?iso-8859-1?Q?vF2DAkqK8v9DgdwDvClTON0pKJkabANufIGpTxOVHqXtQd9rXKyXd7s+ET?=
 =?iso-8859-1?Q?3fBk9DUwS1YCT4KZnQj9zHfnBeoAt0k4MC/SX8wvRzw28dCg+e4lAGYYWP?=
 =?iso-8859-1?Q?6Ou4M4qJO4A8QHJU1GOKjJfFoshMUmgCDP+ThdIu98Kg5Au4HewYaAsbYD?=
 =?iso-8859-1?Q?2OidBEoNpQXodhLfoGcl4E1/iRuR3s4cFs6oSrlA6A6fiD2yrMMwTM6Ueg?=
 =?iso-8859-1?Q?K9q0vPH3JT7R8jCa+Zl/0XMGQFFBOFsYrZI/MkWrPqndouLF2ttkw8VqbE?=
 =?iso-8859-1?Q?H047Y+HxA0RtIEGK/5rmVeQuVHueLzkbrbdyA6wPRIq5NAsl/F/7r2xaae?=
 =?iso-8859-1?Q?VAvBwKOWcnb/SkNnZs51F5J2BpWjDnZRv4GuU+qUSRZmbFSIBTmg4s+UFj?=
 =?iso-8859-1?Q?bqiIHlm/VJrDTC5wwdrTfJSVFn8oOr8igduUb5/PLsqz0IwDYvdo8YPZNB?=
 =?iso-8859-1?Q?WnEn7iLFmJGeZwmiNnxglgFD5OOrBZnbACIsi9CxOe1PTjRx+fNCLE3XO7?=
 =?iso-8859-1?Q?6UR1bg/a9MZpS4on9QnaytsEaWbwytNilF94NZ8L1c9QclpG8vXFcfpWcR?=
 =?iso-8859-1?Q?gLKU5tAQhoKDn7kMBjdvD4fMVcoAP49gHO7k5XlzxivO+dbumqLHD04en9?=
 =?iso-8859-1?Q?DeB5Q5uBNKElI2UNVuZacH4zTD+fKVWqkQx7Cr11YR8H8/dhZNymwPhia9?=
 =?iso-8859-1?Q?lcaXhoDMsDLOtc5AG2xHLtlNYr0z6uPbWryowRHbjExDvKqAe4OvSXimOV?=
 =?iso-8859-1?Q?Di19JsCntHGqRmMXfHxcwfpwKg8Hsl08Kbh4o+idJWR3oFGCSBHpeo4vGX?=
 =?iso-8859-1?Q?4VD0gK256tApGNExg3efbNkXlC56/snlIPqLLiK0EHvxcvTFWcpn5uU5I3?=
 =?iso-8859-1?Q?ul0CfhNE8DVFr1bBO+/b9KWLe7zXf+2F0beCdmL1oZcD3VnA46qKjeWJoN?=
 =?iso-8859-1?Q?Y8A/sk1wh6xk8Hhcas+WCJhoFpydUdsUwa5WDFmRCoLzUja185yn4SROF0?=
 =?iso-8859-1?Q?wuPyNP3yK0gbuKpL3WYeOnJpwtbA3iKciIlKaj/kGMQqwDTOAZo8MFRfdc?=
 =?iso-8859-1?Q?NV+UUwNVWmo/TxGOyqfz4rLTYIpM1fs1W7NRY87iLycc9bLLPXwhFyx8o6?=
 =?iso-8859-1?Q?ByYER5Ti4g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5c7ed3-97f3-4f5e-e71a-08deb6542fa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 09:43:02.5682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eqZRAqrV5G2i57hIumdxbmaAFvYeRXpujb7zfbQdF+edZGVEJ7gyzBYDy6TFH5y4A5JIiK/1CjVfxcCVNNL+6oNopjnOgVJ32QD6wvTSIJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1131

On 2026/5/19 18:00, Conor Dooley wrote:
>=20
> On Tue, May 19, 2026 at 09:26:03AM +0000, Xingyu Wu wrote:
> > On 2026/5/19 00:24, Conor Dooley wrote:
> > >
> > > On Mon, May 18, 2026 at 04:18:51PM +0800, Xingyu Wu wrote:
> > > > Add the new documentation of SAR-ADC for the StarFive JHB100 SoC.
> > > >
> > > > Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > ---
> > > >  .../iio/adc/starfive,jhb100-saradc.yaml       | 62 +++++++++++++++=
++++
> > > >  1 file changed, 62 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.y
> > > > aml
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc
> > > > .yam
> > > > l
> > > > b/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc
> > > > .yam
> > > > l
> > > > new file mode 100644
> > > > index 000000000000..ba8e19b72ad7
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-sa
> > > > +++ radc
> > > > +++ .yaml
> > > > @@ -0,0 +1,62 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > > > +---
> > > > +$id:
> > > > +http://devicetree.org/schemas/iio/adc/starfive,jhb100-saradc.yaml
> > > > +#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Successive Approximation Register (SAR) A/D converter for
> > > > +the StarFive JHB100 SoC
> > > > +
> > > > +maintainers:
> > > > +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: starfive,jhb100-saradc
> > > > +
> > > > +  reg:
> > > > +    maxItem: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    maxItems: 1
> > > > +
> > > > +  resets:
> > > > +    maxItems: 2
> > > > +
> > > > +  "#io-channel-cells":
> > > > +    const: 1
> > > > +
> > > > +  upper-bound-mv:
> > > > +    description: The upper bound voltage value of the monitor.
> > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > > +
> > > > +  lower-bound-mv:
> > > > +    description: The lower bound voltage value of the monitor.
> > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > > +
> > > > +  scan-freq:
> > > > +    description: Number of the scan cycle interval.
> > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > >
> > > Can you explain why any of these three properties are something that
> > > should be in the devicetree rather than software controlled?
> >
> > My intention is to be able to obtain the initial values from the device=
tree during
> probe and preset them.
> > Do I need to drop them and just set them through sysfs?
>=20
> Unless the hardware configuration determines the values (which I can't re=
ally see
> being the case for scan-freq at least) then yes, you need to drop and set=
 them via
> sysfs.

The ADC hardware can be set the scan-freq register to determine how frequen=
t it should scan its inputs.
The calculation is:
	frequency =3D 100/((register value) + 5) MHz, The register value should >=
=3D 15.
The maximum allowable scan frequency is 5MHz.=20

>=20
> > > How are the bounds calculated?
> >
> > The measurement range of this ADC hardware is from 0 to 1800 mV. This s=
et
> value cannot exceed it. This explanation will be added later.
>=20
> I'm asking how this is calculated so that I can tell if you the property =
is permitted or
> not.

The calculation of bound is:
bound-mv =3D 1800mv * (register value) / 0xFFF

Best regards,
Xingyu Wu
