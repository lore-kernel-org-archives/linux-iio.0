Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2131.outbound.protection.partner.outlook.cn [139.219.146.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376C937F8C9;
	Thu, 21 May 2026 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357283; cv=fail; b=IsbqEBShaERGzMvL4FVsxwNOjurZAd7k2+w9ICDtaJllEHd9bO8TwfbyrA27uOnUDM9kn3x1aVL0z43DyQ7QWzZgluQDeCfEUaal6coSuGo3QA+EpRqNZZPlqkBZsaRyNoSsegMgNK9b+oNmxg51Ot5buYmdyfNz3h9YFS/yKzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357283; c=relaxed/simple;
	bh=qknMe+0aFj3E/msjzSMVKzgfXUIhACrLr9ZkLV3hA+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OqVMZj1tN6dOQFM+9QkigfbyPO3aSbljUS3nAOnJ98OSjSkpD4b1hwprFtvmIgdht58hk6t64YEERf2eW+Y71DvPZFICTdCZerSf17LZpSNzmtjHLpydGQCcVyRT93YLr6IUXY9ij9baXeotKleKftLt65APpoQsy6Dw9/dQ3LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlVhDmEmPKwgZ59qq1bEsopbQPbie6HuZOmtPonxhgNBAS5+FYeY89uCLdsH6Gv+Pd23iO+7QXkUQGTtvznhO0Lq8vzCJW84/eiIyZGn0ZweOAD+UmKtQ7xVjIgekGf12PBgyn1JS3UdGeJg7ofNj9IawX/hKPfrIHTj9U7EGA8E0mR85Pof+GF1Ph6hqjVh0p1l3bDQs0UwBzBzjz/43obsvTs3hr76hkRhSpZ2Vx+z4jqy9U5fb886zpeOQj/ynJtrLQIh1EycE1TqPWdWi8Ro1TxIHnmUIMkcwHaa+LI66VX+pMX3x7E8DIFSjKPkHAIxg536n5UixkawmWlkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qh7tFLkzgfgpa+93JnjE3i9XpzaqT3Dn/HStU3Isqlc=;
 b=Hjcnj4Mut4Nflz+6uwoDq64YRqtJG4skqZ/CeLnaiBHXeVNZpcaa/d1DdccuQZbuzuEoJNC/ODCWuoCk7NjwRcUPg9Ll+9tkobMSB3vejPzKFr3nvX4XMR9CtzFtEuiGfYQ7dN8wlOWktsHrqDWCgoOSeho0H09PA1sqrpTEWdSIQU7ah48o4Ko6Uq8Fj90DAWdu/PDs++aSTQvInEsZhbqKiDDd+/TG2UoQaJjrmJzH5483WR+zsRy1bo3nm9mC0IvsTpWiki0SuKQXTDa/SfSqWpuMjLMMJWvGbEEqzf3wVSnk6QQzXXqZ89Qknykw1RBpFtQx8IW5FHepe+FG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 09:54:27 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::d8e2:3f39:6ae7:bdf2]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::d8e2:3f39:6ae7:bdf2%6])
 with mapi id 15.21.0048.016; Thu, 21 May 2026 09:54:27 +0000
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
Thread-Index:
 AQHc5p77jQOM2JwohkK7qO7svRU7q7YT+EcAgAEVtmCAABFGgIABhc1AgABkbYCAATcuwA==
Date: Thu, 21 May 2026 09:54:27 +0000
Message-ID:
 <NTZPR01MB0956DC43B5D6E6EBB4F457129F0E2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
 <20260518081852.116909-2-xingyu.wu@starfivetech.com>
 <20260518-elderly-barman-2b1abfc3755c@spud>
 <NTZPR01MB095679F35A873BBBA304655F9F002@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20260519-undoing-ambitious-012d608ebd7f@spud>
 <NTZPR01MB095657AA216608109BEF9CBA9F012@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20260520-relic-chloride-c5cdb96696ce@spud>
In-Reply-To: <20260520-relic-chloride-c5cdb96696ce@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1004:EE_
x-ms-office365-filtering-correlation-id: ffc1eeae-425b-4a37-f46d-08deb71ef262
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|18002099003|56012099003|22082099003|4143699003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 0Kt7ouh6B1w4r3G7kYcTD0QOZq7ghl4pBY5ein/Sd6SteII16AXyoqTFJwirio8y2aRYIp5yi1hU5o4+lr0eJ+pCuLjxO/Xar7aSz0rw9WBulRg51vS7Uks3zC5rLlzajqiydWK1dOFgDVda30iHft+hq7kSu/zJwalYlRZxt6IKaLwvSZNZQXLeBlRwQSgcRmQCphS7tgVn5+PRBW2gWXLoCf1tve91GwEOE0d8P8zpmfkhPoVrBeYXGq05+nYRMkr6FyFy/3vcYxu2tJpaZXosFZPazUSO2aUTV9IKcvT9gTQVIpDWnC/tB6hZvg+ON07gC7WUDMp97Qok3izKd8Kw5is1Mudf7ul9zh60UUGmnpdNK9Y7gBGaxsl0tDt3CtopQYIeqlNqOU3uftXL1F2BT2tkjvu88UbAT8UJpfl+gWf8maGnizA1cUFiuNWXiqcR+7lVMuF+WGgp49HJzWFF9V/yp0osLt8CIzFOKIOkl+V3fTT6swRMA52BASrv1CbLdbnvJMkiFbsxmDMmL0FF+iLZ3ixwzIaMA9t+9OjNdAiQnpsozjxUTcqtXIw0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(18002099003)(56012099003)(22082099003)(4143699003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OIJ+YA7jQ4DIvK9XWzXIQVo65wmfdcOpFhSGnygPONrLR5ZE0fyQV9zAdC?=
 =?iso-8859-1?Q?oCWww9hF3JJA/Bvo8TpayvTiyhp9np94F6V4YVjOjoCre0m7QYLRnDiDX0?=
 =?iso-8859-1?Q?T13EII+J+b17flqVFY4V55RmdTU/QsAZQUK4kmhkkQgeYV/9cm/bNSsZ9E?=
 =?iso-8859-1?Q?ZnFzqlyu/SUihjSnAH8sWMY385Yqg+RVKImtyLDKMn2WVk/syg49yyIEkH?=
 =?iso-8859-1?Q?2qJKfBBoB2HQr6yxmH7LuAvuPu5KqLr5Ki//aRwSqRnNCYSsOsn61q/TOI?=
 =?iso-8859-1?Q?ihho1F2Q0FcvW31nJ9i7Q1x71XSvfX5WwDy1ppMptM61hphiosZKJGfDxN?=
 =?iso-8859-1?Q?9p/GwSGOwyTtvxmt9L+Y9c7GIJw6ZWo59iNgatVNzECW9rj4dBcMo1bra7?=
 =?iso-8859-1?Q?jc1tbqV2ahID083zxtqfFciqvIEtZ0B/DmkPtb8P6FNOiTTypuv06grCIH?=
 =?iso-8859-1?Q?Jv2fXNIQzfckRjGMHCElEM2CrEPFN9lzvqBexbxQqZF+3Zulrv88YH/3EY?=
 =?iso-8859-1?Q?/IE3BpGgb84GYn7W+SL69nAc4ZMiJnmbA6mGxeItm1yEboddmx04Nb+5Be?=
 =?iso-8859-1?Q?48SHs9eoyfITbBsD0rNaKW4IAXVMuoRtLwXvygY1HrSDxbvYNtjT1nevYn?=
 =?iso-8859-1?Q?fsv4JF9btzIpM+L0DELrj0NDfGOOPKqb5DyafJU/FaZO8Dw26QLDNLFjzx?=
 =?iso-8859-1?Q?00aSuaNcAGIwo8pn9pTekmSAy1tYEXfA1EYkIbp8CifUOBqmtG4jqoUT8h?=
 =?iso-8859-1?Q?pOS3m/RCjVI3Fll8Hd9Bxfios2Za7tcZ2c5ErqM4eyMoYIYKdOzTIkZ8LZ?=
 =?iso-8859-1?Q?4WpFHUz8H1ZvXJuT5O9kVzKvO4aTL57wLj7O52ttCs82TgjNLZeVEdFCVp?=
 =?iso-8859-1?Q?fxCXJ6B+Ajqe6NCd0o2VuO8w6pu5DpcpFr7ZXEr+Vgdqf45gLx43fyNb9T?=
 =?iso-8859-1?Q?UCKitpao9UVgBJrDstNDg0yxc02sw89VTNHC+QW84BR2hgVmA6gynCaXrZ?=
 =?iso-8859-1?Q?aUKWgk2lM1WhgkIDpBj1kacWd/XIzuvyB3/fiiV96PXt/fhCucbe199kg7?=
 =?iso-8859-1?Q?W10nIEDI0JNfJd0BqhUaRZXCLbWlJ8s1WZh5wopNOFqwdigo/+rGPlgYm1?=
 =?iso-8859-1?Q?BW5M3qxqbEqWn0jsoN2Vm9W3h7A+dmEl3/iJaoFG8sClpLuCWEmyMA4Wsg?=
 =?iso-8859-1?Q?ltA6DNd+2uU9CZKDHVcgPuJ/72drGBNx001uXgQRU6Kc+D4Uo8DU+dAzYE?=
 =?iso-8859-1?Q?pyA3yyDefs0+KZXhrQneMn/kTkOMoMVnOdJUIjTi8NB5xzdrSiqTtx+vZc?=
 =?iso-8859-1?Q?mHrh9iekciHIuJShGoEm6VIrLqLXnSgg+pH3Re53aHZC8wfDKAwsObaeA7?=
 =?iso-8859-1?Q?9Tbkoc+I/zBkClnrnK46L+nbOtuiPvnuDP8QJoRky4ISE3QtEpvdgFPbKS?=
 =?iso-8859-1?Q?4ay/bcWmZFga84KEe8+9vwuNTUBf2BWdRKZSg7QZ0adU9ulHnV1JSiTJuQ?=
 =?iso-8859-1?Q?LJkMD8jzxyMDS3o0kaw5SVbvCYWzMT1AzpiiAlBc7Um/rlpK6l+QOm4SEs?=
 =?iso-8859-1?Q?RNHMqZ4MxYqW0ijFJLZ/FIU9+PqbEqXevpFWByZuzZK8ivGW3I4QPRyUzw?=
 =?iso-8859-1?Q?pCoGKA1i0NAL58+qX7WECDnjZ0SNgL/WrF9qpirmmtbA/lMBmo9CWYGDfZ?=
 =?iso-8859-1?Q?2SxGAZrBxN5FOaBjaEUUu1+luwU9yqZbw74qR++peANXClMXhzpgSp6qD2?=
 =?iso-8859-1?Q?KtcA7jLDEyJuoZYeIJrXaYasKMEeVfP4rGVJUFEBMMHw5MG7xc8M/CrxVy?=
 =?iso-8859-1?Q?sZAyXsHA/A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc1eeae-425b-4a37-f46d-08deb71ef262
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 09:54:27.6040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HX5phvgDa3YQ1l6m4hp27y/vBaNXtMTNNJcaXmrf/3wIcv8PC/m6ckQ/IlTR92o1Y+83FQnTVedUNgXsHU017sV1pLcVfDJ353ikYC0suvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1004

On 2026/5/20 23:15, Conor Dooley wrote:
>=20
> On Wed, May 20, 2026 at 09:43:02AM +0000, Xingyu Wu wrote:
> > On 2026/5/19 18:00, Conor Dooley wrote:
> > >
> > > On Tue, May 19, 2026 at 09:26:03AM +0000, Xingyu Wu wrote:
> > > > On 2026/5/19 00:24, Conor Dooley wrote:
> > > > >
> > > > > On Mon, May 18, 2026 at 04:18:51PM +0800, Xingyu Wu wrote:
> > > > > > Add the new documentation of SAR-ADC for the StarFive JHB100 So=
C.
> > > > > >
> > > > > > Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > > > ---
> > > > > >  .../iio/adc/starfive,jhb100-saradc.yaml       | 62 +++++++++++=
++++++++
> > > > > >  1 file changed, 62 insertions(+)  create mode 100644
> > > > > > Documentation/devicetree/bindings/iio/adc/starfive,jhb100-sara
> > > > > > dc.y
> > > > > > aml
> > > > > >
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-sa
> > > > > > radc
> > > > > > .yam
> > > > > > l
> > > > > > b/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-sa
> > > > > > radc
> > > > > > .yam
> > > > > > l
> > > > > > new file mode 100644
> > > > > > index 000000000000..ba8e19b72ad7
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/starfive,jhb10
> > > > > > +++ 0-sa
> > > > > > +++ radc
> > > > > > +++ .yaml
> > > > > > @@ -0,0 +1,62 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML
> > > > > > +1.2
> > > > > > +---
> > > > > > +$id:
> > > > > > +http://devicetree.org/schemas/iio/adc/starfive,jhb100-saradc.
> > > > > > +yaml
> > > > > > +#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: Successive Approximation Register (SAR) A/D converter
> > > > > > +for the StarFive JHB100 SoC
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    const: starfive,jhb100-saradc
> > > > > > +
> > > > > > +  reg:
> > > > > > +    maxItem: 1
> > > > > > +
> > > > > > +  interrupts:
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  clocks:
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  resets:
> > > > > > +    maxItems: 2
> > > > > > +
> > > > > > +  "#io-channel-cells":
> > > > > > +    const: 1
> > > > > > +
> > > > > > +  upper-bound-mv:
> > > > > > +    description: The upper bound voltage value of the monitor.
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > > > > +
> > > > > > +  lower-bound-mv:
> > > > > > +    description: The lower bound voltage value of the monitor.
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > > > > +
> > > > > > +  scan-freq:
> > > > > > +    description: Number of the scan cycle interval.
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > > >
> > > > > Can you explain why any of these three properties are something
> > > > > that should be in the devicetree rather than software controlled?
> > > >
> > > > My intention is to be able to obtain the initial values from the
> > > > devicetree during
> > > probe and preset them.
> > > > Do I need to drop them and just set them through sysfs?
> > >
> > > Unless the hardware configuration determines the values (which I
> > > can't really see being the case for scan-freq at least) then yes,
> > > you need to drop and set them via sysfs.
> >
> > The ADC hardware can be set the scan-freq register to determine how fre=
quent it
> should scan its inputs.
> > The calculation is:
> > 	frequency =3D 100/((register value) + 5) MHz, The register value shoul=
d >=3D 15.
> > The maximum allowable scan frequency is 5MHz.
> >
> > >
> > > > > How are the bounds calculated?
> > > >
> > > > The measurement range of this ADC hardware is from 0 to 1800 mV.
> > > > This set
> > > value cannot exceed it. This explanation will be added later.
> > >
> > > I'm asking how this is calculated so that I can tell if you the
> > > property is permitted or not.
> >
> > The calculation of bound is:
> > bound-mv =3D 1800mv * (register value) / 0xFFF
>=20
> These are the formulas, but how does someone know what the value for boun=
d-
> mv needs to be? Why would someone not just want to always use 1800mv?
>=20

Can I add the 'maximum' and ' minimum' to provide clarification? And the dr=
iver will also check.

Best regards,
Xingyu Wu
