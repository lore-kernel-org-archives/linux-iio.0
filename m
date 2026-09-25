Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011046.outbound.protection.outlook.com [52.101.125.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BEA149C7B;
	Fri, 25 Sep 2026 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790297261; cv=fail; b=cAadaWJbADrJZO0kYKZxKBrjMs7rhYS73mJosrfxSmXQWboKyyNlNRlQTdMmHsjE5D2b42FPFnNbPvNIRS06ESUDiZvtq5yA7KZm8FfBTuuOsBTXzgw7Q+qk4FXshjtyXcdbOE7+aEQXtqihkJ+QOGpTuvx1uSMdMxw331mp0cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790297261; c=relaxed/simple;
	bh=/0k0myJoH+QhJfYvreYJa4z6yrsM+D9KR1yh8k2aXfM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HwLwAYqFjdBUcJ2wvcnib9DK9OZ+wdNcETTUC9PYOwRZsGS3BX5mp8g+zAU9QDoEJNJ4zd71z1lNSK6vjdOUtYPQeI0pYeEwRweNrEVv6P8WgOk3UzjChxaCgLYIsI7c6yy+a83e6xClbA+d6x/mCKqfnxSCI/SmYbIO8oqNQJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=vzZysf4S; arc=fail smtp.client-ip=52.101.125.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="vzZysf4S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWqWPqCOUlJeWtrfmGqnLB13/zgTz/Lp+lVi9gIPaWRKahzI+rwvn+jqb6c5nSkPMDwSZsmDsf3RLB33cLE7MHLFyVfXoFIY3R2zUBqXRAMbh0XHMPtF2rPFZ2YDUKVjJS9gGhPCMsZVXRbE95GMv5bSkyK1k6UqP+Gf3yZ0Zc8b78sg4+pPkCIxjf/FbPw7cmNyNkSHP+CzQfSQtaJlGG/NfV9eVaGVenbsIBLgc3hEh340G+ORyiNMiAApepPWqmCEs89awlyoSCt84QhbapX+klXs5aXMKwGrw5eybN5owmfddcSBOCvOwbNwqcKwn512ZNSSj5PLSRVhYPT+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWZ6XJMsGk66Rz4ZEfKLQu3rqodJMy/rLC9yZix4c3g=;
 b=QVDJw7o6dpBHZetzyflMbsiZQrZx01rF54v0rt2UA7ME9iwSvO+8PciAWE/Ei/3FyWQkNz17WlO24mTxQ9s0MosJRPGw43/gNd2dvehuJ35H8YraSSrVq1f8OSI1dDU05pdOHaa2hj5PiQNfvasQFTTaMotouFERtFzx3QLYB15TjIruERopMTvarWQyF/3zijl5DDKkg5KtwJm7cCd8zo8RiYK/VUCq4E1QvldaKD07QSPhp9g3SsMzL1BsuOEUbNTZiIBSX1fRcWSziH8uy7GBNqBIToOt2I9BoNjHOpcu8F3DituXU8EICaZ0bxgc4cdDwy8t3CUQTAZiyZEoZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWZ6XJMsGk66Rz4ZEfKLQu3rqodJMy/rLC9yZix4c3g=;
 b=vzZysf4SdoZnjZfzeqvKorEjEgl+i/7+sL50wLvh0CWnS7M5c50mBExHWSMvrL0qpIgD2GDD72cG+1r4AZGXjL+mcurO7D5xAKP6RQxNGFplnX3UZHPd0ptu0WAT7YrzMjhamcPGxl3PzH6XUo8iDs4+VSKLNRZ8JBINWPa8Jmg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB15565.jpnprd01.prod.outlook.com (2603:1096:405:29c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 00:47:36 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 00:47:33 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>, Daniel Lezcano
	<daniel.lezcano@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "magnus.damm" <magnus.damm@gmail.com>, Jonathan
 Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 2/5] dt-bindings: iio: adc: renesas,rzg2l-adc: Document
 RZ/G3L ADC for TSU
Thread-Topic: [PATCH 2/5] dt-bindings: iio: adc: renesas,rzg2l-adc: Document
 RZ/G3L ADC for TSU
Thread-Index: AQHdQfKvR1i035ppmE+HfuMiYuG4Y7bd4UyAgACmbUA=
Date: Fri, 25 Sep 2026 00:47:33 +0000
Message-ID:
 <TY3PR01MB11346568D44110BCA1CDD146D86802@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260911133653.115553-1-biju.das.jz@bp.renesas.com>
 <20260911133653.115553-3-biju.das.jz@bp.renesas.com>
 <179026080913.4146821.390521831954658305.robh@kernel.org>
In-Reply-To: <179026080913.4146821.390521831954658305.robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB15565:EE_
x-ms-office365-filtering-correlation-id: 182cfe5e-5ed3-4475-ca8a-08df1a9e95cf
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|4143699003|38070700021|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 THVopqP6x/mFtLcvTJRkFsQJ0Vd0C4q2ENjSpB7b8x8fX8wu6CK4krYZx4kGTbgTte4h9IW7sHS0J1AwFjK3oWDrL0lH/KNEvYr2BvL77D+suz2LzUHMNnmuHfs65h/sl1e/MMgiwxcxpk2aNu5G04OrLs8L/QiAEhIbMcmyJtFiq8KvL8nCbElplH5Oqw7s+01PFITeKWdSr/I6uBr8OgqGxuiFEcWC31UDIQ3gMcCOJsj1UMl7s1VPS0iW9EBnl/BEF99anWeLy8RC/h/agxbDDbCN2O+HdsXuGZLVEmXGrNCDxE4VeaBlBrZTqUrCEpyJ7V58poigge4RXRWhPD+ajxrB/uFIB/F4dj7MDpSZWnmnYcUF3L1LreT+pKkgUZSN0Uc4uoKg2LuRUjhhNZYOirbBM1uGi7gHuELeAyhPcYLwcDpmjrbuDbv0kKWOhoP1WMOjRXMZ18J9e9B698Ehp0d0Sg1jHGxB5u87NSwMrF6I1TviUlk/7svm559MRQUmoMnlDDIdwOtHc5NjL7UEkg2gH8/ZNvGVzma1MStnwTwbdUMzA5TpVhjFJLfzhTIjuY0ws+I6die2hnzBO8N9M0Wpm3ohVGCEfo6GxdPbTRjJ1dJBrrFHpfSAiHgQrBRyj0SVA7AOGmUgxczWi/Mq9blDS8wsPHpCk7RWxG8Y18skxtHtO51q9pjh51s+LxACcF+xMatMSP5q02VP9PMWGmhokmr3bIGMjPal6Lc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(38070700021)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+AFrI7ipA74MG3rgM+n7j91uQf66Ihc8kN/8Wb3naZZ7pF2LbuVbz5fPVq?=
 =?iso-8859-1?Q?w9tRNxSEbgkwE+bKPcPhWjyeloFdKTtOZH6E4x+slM0ggAn4icY69WkUof?=
 =?iso-8859-1?Q?Cl4rDj52Xt532vo0aZaSt29N/ED7eDGcluPt0Le/j+fGDEJS5wgoODIGKb?=
 =?iso-8859-1?Q?rhIvvICpPCCr0gjdm461iP3ZiqQyHHam8B8Jo0qpqSyZQNq+gzooq2ORDe?=
 =?iso-8859-1?Q?Hpqdn4/RXwBVWBhRpej86RIbuIfi6wa0J+Wu/e/cz+s0baFjg1FevZpEX+?=
 =?iso-8859-1?Q?mGYmsd5Vu3hqVL+lzU7AX5WjGUmvSxdjDIc7nuSG+6gg48ChnlKODzoWbQ?=
 =?iso-8859-1?Q?5ECE6fj3ZV4xCy28s0QVVSRRsitznxxAsAQvm/mHGt++0Xhue7OE9VQasv?=
 =?iso-8859-1?Q?mdCeHtUuxa4v6AygvrWVo3/AfvUzknXkrbI6m85x9IgfLiZxU54ICR5zwW?=
 =?iso-8859-1?Q?1vLkBkG7IfgMQJxUdOla+UlXSXVt4ckecYgf/CZ0NzslAiqIBn47e/ET9J?=
 =?iso-8859-1?Q?4kTFQcZgIJIJaxPGu5K3PR9UUUlDXDENVkHHdrVh9yssS/3bqCe/2+tS0E?=
 =?iso-8859-1?Q?xmHegd8cF2xQpxDBHo5Xtb0aBIbW2WSAR3cjTDcayeKdNsFAt52S2Kcinq?=
 =?iso-8859-1?Q?c2zYUq1NptrjNXIqyDoL5z5l9Om9oJU6N7avntvKykDww5qSPyaL9RP9el?=
 =?iso-8859-1?Q?76PnWm8mICHnUjFZugG0FLvfxM5104QLtNbHAMpTc+IEsP66Vyq/mo8sRk?=
 =?iso-8859-1?Q?Yo5Yubt+Kfcvf4+zvhehUPR7Zv17Q9C2RyiIYp3lTfygITiMbTasNvylbF?=
 =?iso-8859-1?Q?a8TJJiNVEfAj+gdz0RJ0lkkUYmxdk0c7NHxSii2LMBktpHOW6vFPQzYmUu?=
 =?iso-8859-1?Q?MzhTQbGN5BMY2XK5eTPbwgYjGUdSGtdAaLHnekZsLVaiZh7i4ZhW8tcbBB?=
 =?iso-8859-1?Q?ElvOdLaaB2Mc3dJH6OBz74xaDv0lOQNCHdsFwgKLtsiOFnAV/kO0czn4m1?=
 =?iso-8859-1?Q?yFnU4qVqQkzWUcXfWpn4uvdu1ziRj+0xGMBTtQIH+ymwWBqfuHYvkdCNHx?=
 =?iso-8859-1?Q?KmwXlOJB6JILKKWOgN9uwv6f0lJxo6c1nXTe5gKJFyESWCzVjPmGzK8ePB?=
 =?iso-8859-1?Q?1/yNqyF0AXBFdtXb/XJk6QQz1d52q691C0YtmE0XUzdKhpXT/g16/us797?=
 =?iso-8859-1?Q?l5Y9vquxMZbhbpnwHRyPP2cjo3tKIPMqN73M1bZDi1uhdST5tr7DVE2c7K?=
 =?iso-8859-1?Q?uNYC9dWodj0WxvQTmwwiTeY69fdOQfwBnSGj/SCLkVI3qSQYXpZsaK2pJT?=
 =?iso-8859-1?Q?nXFGwzIOrhPLe1zB4oEMsMxEF8gMiegaNxu4bN18lKKiagQ3ZHcTAtfVFx?=
 =?iso-8859-1?Q?XEyRfcYoldtJXl4UrUrOuH+1SIPw2PKwRbSr2UxryDmZz0mjHNNO7mokQK?=
 =?iso-8859-1?Q?QrK4Nz6qBbVzP8zmPCcFTecfNcDFZe2qj6s2oDd5mNWlKTRO20aJS6Pvzq?=
 =?iso-8859-1?Q?nq/yWY21p0YCMwIZ/lpHG+hL7PdnhIW0u5ONrPnvlOGlNbOQDcrfXKVjwP?=
 =?iso-8859-1?Q?HbUSdWoiX5rqEqnyVIoTNxTY5zpA7yOCJmWTaEZK1xxGhIIkS9uBrHR5Qy?=
 =?iso-8859-1?Q?5nYGmxDdUBuCJXpb7I9o+7nG4X5/3VufrTLKsr8Oj8CQE5934qWMq7/XVM?=
 =?iso-8859-1?Q?yxxg+BvAAmEcl8uZyet1YGUFFT2aFv9vLMAX+pmmzLDPu+b6p0qoc87ODQ?=
 =?iso-8859-1?Q?50MmxZQtenJBtKYePXekrDL8nin/M8pBTFIEg9gsYM7clqmwaCi6cJBcjL?=
 =?iso-8859-1?Q?cyQ/AlsvmQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 182cfe5e-5ed3-4475-ca8a-08df1a9e95cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 00:47:33.0292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmpnexWOJl2bhMfFwjV3J12JUDkpiVwGvMw6O1RXZp47DF8Vfm69MZT5ClDSsHRUautPgwFlzLG/s8ii+SMixNyaaOvhf/nm039fEbevz3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15565

Hi Rob,

> -----Original Message-----
> From: Rob Herring (Arm) <robh@kernel.org>
> Sent: 24 September 2026 15:40
> Subject: Re: [PATCH 2/5] dt-bindings: iio: adc: renesas,rzg2l-adc: Docume=
nt RZ/G3L ADC for TSU
>=20
>=20
> On Fri, 11 Sep 2026 14:36:45 +0100, Biju Das wrote:
> > Add the renesas,r9a08g046-adc1 compatible string for the ADC1 instance
> > on RZ/G3L, which is dedicated to the on-chip TSU (thermal sensor
> > unit). Unlike the other ADC instances, this one only exposes a single
> > channel (channel@8), so restrict the allowed channel nodes
> > accordingly.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 21 +++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Based on the feedback from Jonathan[1], I have removed the=20
required property of '#io-channel-cells' as there is only single channel [2=
].
Since it is a trivial change, I will keep your tag. Please let me know if y=
ou
think otherwise.

[1] https://lore.kernel.org/all/20260921042936.548630f3@jic23-hlaptop/
[2] https://lore.kernel.org/all/20260922042707.116378-6-biju.das.jz@bp.rene=
sas.com/

Cheers,
Biju
