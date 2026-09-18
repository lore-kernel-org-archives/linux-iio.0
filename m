Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010001.outbound.protection.outlook.com [52.101.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB4C39EF20;
	Fri, 18 Sep 2026 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725252; cv=fail; b=NLDSbjT1LPYA9dY+JcnHqkTVbaUoVrytCfttAEnwqWkkNuzsC2G1JZFwmGNaKXlJuUPJS2JilsJnHV0zIGRGYidOoYUT3hSionhQ8mY5MMPKwbN9/Ys4S87AFjxock/eP9DvYomEhHXNXuHDdMG0fgORwc3Ag/+S5sG7D/KFSjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725252; c=relaxed/simple;
	bh=0qzL8lhSZIkZ2ZmP+to5U1NnFAGBaR7jhAsDoc8fb24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FV7DMPxQDsiArHjy64qoDYVmUN6aoU6bWZi09wzxF/OkgeE5g/amudCyCegUMhYdzDmaK4afi2CRzYP9tlITdDf4w/5doa41zkugxECid1lsOoPzzOrOOnJgWGi7rxOntDWB7Az8lj0MY6JmAKSYrnQBErVjixzdUznc9cKF/2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=dhPETL97; arc=fail smtp.client-ip=52.101.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="dhPETL97"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mV4twlkfXAyCEZwPoTNWh+WnAfOYQwxP34fqKYoqk3+C9LXxI0ZBnlkdw4XBZVp8XjeYHBPVGYbtplNzvHG5ymW/CIK3nVvT2b9YZ4yg3ZeXrtz98idQJ7SsB+B5T15qiEaPsYdbSHpMNNMQxcW+lZ4/m8L08Rj3FgzrgCXIwb2jN6o7GJlP76qzzm8kO0JKW39JldxWFUU1d9aGpbTN0DD0Q3nLYhQM8tmqdhJsdeHjXBl0VPxmB4jIZ8bdyRlJRHr5NW60RRdeJGOIaMF7fVDoMNoKRHybPNSLsDo0YbShTbLhcMTN8dXRG2yu5j6DUYnXqzS1OBh83F9xBVTEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGdFU/WomBle4SBe7tYbKyWMu9AidM4ynkSz5nJraqg=;
 b=urS/i8MXSUDx0eM3T27et+VfmPrU0QGg9trofWn4xNLAVXQNux2ANa9KAlP8gZuS3MFRcLk+EXDL/JOjiuG1qTfwuT59dOFBaUYzpzWrJ1aL0+QJ88vsdRIIuC8Z2DJmpiEGD2qrBqf8vzNYAV1zxR8O07yO63bZL+8ChP5ljIf53RGW8lo3O+9lPDCsFDZE/P8qkUJ3JdXOBHAf5rjJKZ3Cjg0aUbFp2jJLE2tXA8DKfiuroIyUvpTQyFibEAMhllqsnCJwcjHy8ILid21xq6gLfnK5QHOxJfVKeHPQbzrpP/J3GuuOy0B4ObalQf4PnTGESk5N8gK3MtcZXDFpuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGdFU/WomBle4SBe7tYbKyWMu9AidM4ynkSz5nJraqg=;
 b=dhPETL97vOgDBmujDk8jdywmkifUwOpZhRhOiHtnXhdNm1TcLJJM9sfJhw3E4imztnOkeSYPg4fmqJSEWn2ZDSjeYx0WTeTmazXV3DeAcX2pG4PcWoh94Q4/U0hcVkf7yLXa1H5qkdh51JadZug5ZjlXrTX3hdQcQAxAPGnlzss=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB13746.jpnprd01.prod.outlook.com (2603:1096:405:1eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 09:54:07 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 09:54:07 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, "magnus.damm"
	<magnus.damm@gmail.com>, David Lechner <dlechner@baylibre.com>,
	=?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Chris Paterson <Chris.Paterson2@renesas.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH 3/5] iio: adc: rzg2l_adc: Add RZ/G3L ADC support for TSU
Thread-Topic: [PATCH 3/5] iio: adc: rzg2l_adc: Add RZ/G3L ADC support for TSU
Thread-Index: AQHdQfKyH3QDIaefZEmsHwzdPHvAJLbL3OOAgAhFmQA=
Date: Fri, 18 Sep 2026 09:54:07 +0000
Message-ID:
 <TY3PR01MB11346BD0DE3188458BE96B84A86872@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260911133653.115553-1-biju.das.jz@bp.renesas.com>
	<20260911133653.115553-4-biju.das.jz@bp.renesas.com>
 <20260913043141.1e50ae3b@jic23-hlaptop>
In-Reply-To: <20260913043141.1e50ae3b@jic23-hlaptop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB13746:EE_
x-ms-office365-filtering-correlation-id: cf0fd082-d463-4f9b-401a-08df156ac7c8
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|11063799006|3023799007|18002099003|22082099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 pGjCcGt5Y8KV1dswxcR6ygwZZUNNouzrnQGVpDj/uc+6dDVg1wC4qARw8A6XxqOaUSLNRrwSt5RTW4dKqju1Jsmo+MIXa1gWPGR8gzgLFDPzkmWzfcEhoDbYzosAbDqaW2qYMTbMUKZc/P3bFjAv6vGsuLie5oY6YjlRCzoY0r4KRgSUwBkWWJOnAETB4vmA3wN2DAuOWnBBc4CQQiG37Va0niI3i86XixcJhMsgjAEPwqK/NfKnOnaTxchX8AHL9QI4C2pHZqqv02+XbSH62AThddL5OmlOXsC1TE4+Oi35Br3TZ6ANbm+cGrxjBW3+i7fQ9bJmz6ZUHJBvERDUOrMpUAohUBC39zWkjCE8ieIb3eDAIwXPLNSq2yXm43jrzsVO7+XHbxTI7v9FeXYjl10sxLuUkJwgyUBpUs5najPLYiB6ZxjKlFR0xbgaBmcMOTtQLVPyh7f/J0Ttun5TbvP0drKASxbnLQZQYA2aJjXxw4EqJaLPAIRcjeqlqhelPGXMH+qqU0F+6uuyjON5BxlYf/Ayl4++roNERk7Hu4vUyuZbeHAZghINZkTWen9F19z+hovFb9nBxJ7GjEDNtr5c4k1TAlGO2O7fmJkk0qA2pxjSpZFqqPdok4Scsk9CFcqQuTpeJ4eb6UV6btHJiLUbx8uWOH4HZU+MBBRdivHk+j2JpKxwnX18LyoJtHG8mZ5le7gxrKELqvJyeLIlG4D5QvbrQl+TQtEsAPEaI9w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bxso98td8eAfTSHG4iNynnYUvBmzmvlITZjxNcD+EEF+GQwb2P4F/sKxTe?=
 =?iso-8859-1?Q?lBLYJqkh93My4dTX520Jc1jg34V6zfryUq4txb2hrR1bK8aFbZiUJfWeSe?=
 =?iso-8859-1?Q?HHFE38aXOkCc9B3jPwKpni7ShwYC08WB6f+ZjsNdlUxth2qzqF3Wm1K6sR?=
 =?iso-8859-1?Q?lmDtL1rxgHE702KXG0BHDWoZzY5n513QGDEGwu95fyhGLCwt9tMhBY3re7?=
 =?iso-8859-1?Q?SBC94Xxg5H+lo9V2GOLGCMVGE2BuYHTLCzrjZkfEVPMI5QBgR6q61G9fy7?=
 =?iso-8859-1?Q?TTS0h2Opw94zPcCZE/HHjiWA0MAX3kufmiRZrR/lRlW1GzxI5x4wJazANe?=
 =?iso-8859-1?Q?cWQbYYLQs8Vz7uHy97XznknKmKWDmCUAZs5EeyQJSrx1WgSsLFL0/bFYpr?=
 =?iso-8859-1?Q?luBdSQv1A7aRC/QniAUoxbr+MGh8u6U3g4BeL49g7iOoVv7AE7s9ZzSAv0?=
 =?iso-8859-1?Q?ol4S2oz/TokmqJM/tM+rCD09BSU/zQ7hyEcRStYXHagYZorNWug7pevdOA?=
 =?iso-8859-1?Q?fUEzIEv5vWW728fnc0tijtTsvBJHWjb1SYc+4X8VWmSCyp1dJ/CCoMDUET?=
 =?iso-8859-1?Q?RCo9HtD38UPOnH+RBO4cUS/mo/7Y6i4VORnUo4+E1bzDCoFe+1BtDJTcR3?=
 =?iso-8859-1?Q?91BQ8c9R0utB5H9wOW/5K6HcCZQiHhzL1jo8oB6bNghBI8S8M/6CR2ts1m?=
 =?iso-8859-1?Q?ErcgqUBTTdmDgKctJytxGAzOMQte/gqq6yXu0rqP05qGkS3w4g3x/siS96?=
 =?iso-8859-1?Q?oiCYg080rXtadGIt+96VUFGiaCKNjAEmuge1Q/i5BK3v41jWCa2SLy02ck?=
 =?iso-8859-1?Q?fxDwrtFFctu0W4KXQwVONC/vnnWZReJfBVVa4C91kLiE7oK70B7Q6Vd5uU?=
 =?iso-8859-1?Q?XhIByPB5P2q1vEQFeHIVDyefbbnuFS2sOMaKgdO2oQkqzJAfKKfRDJBFBm?=
 =?iso-8859-1?Q?6VTl385TEDxyJ7aqHNqztbfQ1MCPgljxxNKyOICzVyjaOQ8DSAOOoB7v7J?=
 =?iso-8859-1?Q?Gs3DN5o8QRBYR2674IQ/9f/5tzB7SL3PPbz3kRGll8MWFI5cbVpMqzjvWl?=
 =?iso-8859-1?Q?qj8dmSHBPMRMau02osnWri0DGFleARn4zX7AhhlUSEVDPH1UXtYryjlfJI?=
 =?iso-8859-1?Q?qYoq7bcf/dimdiRHHE8wuqFBi7CCZmCUC2G+F1jXmVIF+KllfWxdmPl6vF?=
 =?iso-8859-1?Q?dxHKC2ZZzrJQFh2mIrbSJ+Nv+Z6vAAuit4zxpkbH0s9RMe8+t5PnRmwGs+?=
 =?iso-8859-1?Q?isOLCjOZ9wiAYa/xgQhVOVBQ8KyChJRHBlZxYgPbytbJIKWHafSpLsNRwF?=
 =?iso-8859-1?Q?RAI/n6aABSyQB1erH4lafomamSyU73r8R23fkCG0sNlKnOaoQBZTMhuXOx?=
 =?iso-8859-1?Q?2uWvKqYk4lMA8mbXA/iNXKbL3/npDjbBBj64MGQJOJovD9fDqjmWlHtZn1?=
 =?iso-8859-1?Q?I8E07P5fawpBsDzlcI8DlmfollhdNh3clS/r2I4UfiPgCa0GrkmAMC9wxY?=
 =?iso-8859-1?Q?dMQwxDaW/Y3nPJaVGgbZIIoL7IZ9N9KYejrcDaTk7xlyzJeXqH6vAOb9ec?=
 =?iso-8859-1?Q?nadyW4X1esvCZuwXSqI6mw4QK4x9jdZObtNiUirE7QsW7KS7hzpFtd3yxq?=
 =?iso-8859-1?Q?CfLNKpOuegKjGW1t9RBYidhHnq0NSqedMOZUX9kH2weX1CKxMkoOIoSj+w?=
 =?iso-8859-1?Q?YDhqVyW54T6zyFVwlr4n0ab9Cd5xbWSn9eVxsiKt1eIdMDt4m9mwDBQvJN?=
 =?iso-8859-1?Q?fgfJL3ZR5dfVM2BWL0jpe9s7Idpid1jZSObMfAEouXznr9ISe6jy9av6l9?=
 =?iso-8859-1?Q?X927SCSRyA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0fd082-d463-4f9b-401a-08df156ac7c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 09:54:07.1930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DODXeSHJ5yizu2ApBrmCA/RuNE8CMsq5nwmTpx0Qw4IcHiovoiJiJLR4tmbQaABhdyIMWVc5FWoQJ0ImBl+MQpdfb+6Eg+A++ZKEgiAZOBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13746

Hi Jonathan,

Thanks for the feedback.

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: 13 September 2026 04:32
> Subject: Re: [PATCH 3/5] iio: adc: rzg2l_adc: Add RZ/G3L ADC support for =
TSU
>=20
> On Fri, 11 Sep 2026 14:36:46 +0100
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>=20
> > Add renesas,r9a08g046-adc1 compatible string and its hardware
> > parameters for the ADC1 IP on RZ/G3L, which is dedicated to the
> > on-chip TSU (thermal sensor unit).
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> I'm in general fine with patches 1-3. If you respin, send the whole serie=
s to everyone. It's not big
> enough to need messing around with who gets what and the real DT example =
is patch 5.

Ok will merge Thermal sensor unit + ADC1 patches together and send
next version.

Cheers,
Biju



>=20
>=20
> > ---
> >  drivers/iio/adc/rzg2l_adc.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> > index 408fbf8c29cc..35eaebfbdd77 100644
> > --- a/drivers/iio/adc/rzg2l_adc.c
> > +++ b/drivers/iio/adc/rzg2l_adc.c
> > @@ -500,8 +500,17 @@ static const struct rzg2l_adc_hw_params rzg3s_hw_p=
arams =3D {
> >  	.adint_inten_mask =3D GENMASK(11, 0),
> >  };
> >
> > +static const struct rzg2l_adc_hw_params rzg3l_adc1_hw_params =3D {
> > +	.num_channels =3D 9,
> > +	.default_adcmp =3D 0x1d,
> > +	.default_adsmp =3D { 0x7f, 0xff },
> > +	.adsmp_mask =3D GENMASK(7, 0),
> > +	.adint_inten_mask =3D BIT(8),
> > +};
> > +
> >  static const struct of_device_id rzg2l_adc_match[] =3D {
> >  	{ .compatible =3D "renesas,r9a08g045-adc", .data =3D &rzg3s_hw_params=
 },
> > +	{ .compatible =3D "renesas,r9a08g046-adc1", .data =3D
> > +&rzg3l_adc1_hw_params },
> >  	{ .compatible =3D "renesas,rzg2l-adc", .data =3D &rzg2l_hw_params },
> >  	{ }
> >  };

