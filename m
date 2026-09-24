Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011010.outbound.protection.outlook.com [40.107.74.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB5D4A3F1A;
	Thu, 24 Sep 2026 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264672; cv=fail; b=GYxB3Os//dZ2FpWebd4JKlp0yLpCJdxwJSVqu2+cuQedK9cI852XASrMMJ3fl1l0dBJjIp3E47tPZ5KA7PqUhRWEyUmZpJe/TbhzLMANvacE1zxu5sY9S9rSKZCsWk8ndYOhTiKNEoQZL+zmAUQ1/+JPhTLKW8vpWrc2vqKYXV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264672; c=relaxed/simple;
	bh=dkozKl6LKsvrj9oF3faPIpXLO5nx+QIzkd0xEP8ZCJE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eOjxhRyODZ2DQ9LN97PuV2AMove00WgjJcWj5QqCc+31To4b8BXfhBuzoQfAQqTSEYpLneb693wpITu51EQrMr79CMTeHtUc3NOc5ahxSbVpDYonP0sCribPymZ+XtKPAjxsS8Bb+slrc+4DTHs9Os5wv9clxx6Qot7550pChVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Arlm0qD1; arc=fail smtp.client-ip=40.107.74.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Arlm0qD1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXBXnSkizVECIX1nb/F1k3wzxg4LABxmMhFr2MdxSkqfO/SsKr2uQRtDXyAoI7ttx20xTyLQsEKi1Y3FEKl2Bk8XONlYZ0bimOy2iDYeYVMSm9IxW63njNukLT/UauHUrqv4j5N47sbSL40hbzcstt00YHMO1LOacACCjaR7/rv2Abinava90NSZkucLAiKK/kbJmgjsQuhcEZwq9IIOgoA9eKrVHhafb/mos5JCH5Nbumr/kZk69T8Ev/7jTs214mYQUE74dOJrCkPmHEuj6I9q95L+E9BjZ1euMGjgeCLdbtltH91yKOksr8KnHkE9R6hWqMIAdywnsDnBTQ/tmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoDCSWWaXuE0DuPknrlAs5JuA/j1ymYFNYaVpED6eYI=;
 b=bKfA8P8h5u9m39rgK+wI6TQkbps4XWAcaokdnZFoUta0qrfw6CmqxFcHOSi93IxD4op6pcCtP/nBTEqyq/XM4BtVNH5hZj9iPXIIgWO1FwavWwrcubqkCX2zKqR+BerHKdcUNfqZ3GoDbMM6BSuHuk/yPAhK02/xUBB8kfeyNdRsHddsDAFlZhdYgmARslGLzJql3ubFzZkiXal4Cep2C2CpBn7e+tVWGSpzkRyjIy9UoY9Z+eYwrdVlcof9mCqK8Kjr4Csf/3rE1a1W8qy/iLod/caTvQNlk7pRh/B0f2JZ3UfWejL0obZ45WvmK575/jWoqxB2cq0mx6QTV0i3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoDCSWWaXuE0DuPknrlAs5JuA/j1ymYFNYaVpED6eYI=;
 b=Arlm0qD11e53w5VLRJpYozHgR0GU9mFbQTf9ukwmUs0uWdMwC54R4vVpOdSzsHLUmSBqtXJ5Xzv3SrjB40jFztA64nxGLzci5znHziONioa5ND/eD3GlmhhKztqqqfN/1QTdgRPxF6u2VjiFXC3uOOzTLzG+6b42mKQzvcBRWCw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB13159.jpnprd01.prod.outlook.com (2603:1096:405:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 15:44:26 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 15:44:26 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, "magnus.damm"
	<magnus.damm@gmail.com>, =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Daniel Lezcano
	<daniel.lezcano@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley
	<conor+dt@kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Andy Shevchenko <andy@kernel.org>, Jonathan
 Cameron <jic23@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/5] dt-bindings: iio: adc: renesas,rzg2l-adc: Make
 '#io-channel-cells' required for R9A08G045
Thread-Topic: [PATCH 1/5] dt-bindings: iio: adc: renesas,rzg2l-adc: Make
 '#io-channel-cells' required for R9A08G045
Thread-Index: AQHdQfKpN0srkdh5g0qZfnrr+gnEIrbd4MKAgAAPSBA=
Date: Thu, 24 Sep 2026 15:44:26 +0000
Message-ID:
 <TY3PR01MB11346A76E670D32167AB8606186812@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260911133653.115553-1-biju.das.jz@bp.renesas.com>
 <20260911133653.115553-2-biju.das.jz@bp.renesas.com>
 <179026069285.4124788.11493153710746349553.robh@kernel.org>
In-Reply-To: <179026069285.4124788.11493153710746349553.robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB13159:EE_
x-ms-office365-filtering-correlation-id: ac736e04-82a6-44de-815b-08df1a52b6a1
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|4143699003|3023799007|38070700021|10063799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Mvl3qN0PzV0JUKBkArhWc7Y+QROyhAquQ8hIFRLh0v81J4UYQ3BS8062Gu0ZoYEIftEOUHAjHdDZWNngRBRwCH5v6w3ilUVvScUIM9ayBmYETc5sOYzc5ra9AlfJyguVnzGJx9LiU0qmZw3NrbE7hf90qZUi43Y3Gpixf3mYnHTClw2LhmD4abaw1TzE7zL7PBSeXzlu2wXAFv9q36hJsEBJrzw450zhBUqpSOz8nULngP4yv+NCwu1fp4j3lQHeCjxZ3ZMSXdRPx/FL5QBzpZ2/AmWd46nru+xyN684aOHyg3iLTHd1uUrmG6GCo4NAZmJmPDEoKJqdM6groCsfsVCWiREYzo9esyv3N0iJrkIHYlq7vnJVD+bgNTbEWjTn+AItf4HCDIS5Kx8wndqVlZ5xPsfZRMStXfsb7qMwf+v894Qu6QCu34TaUokmyWjVvGfNbQYmzwN/675gV1eaDLnBUAQehSepBZH0bhiFI4OHvOVidgGsVBCgPxo9MAgaosINi+u/YeN6Cuv3SAeDpVwNUCFI0aS1dHf1vmCibXdHE/KlhuJU2QJgfDD1BDiHwMuNNkXeGyr7HzZPtyMk043dYGcbpG4TTeOw+OndSirmKLdNzheC9kxIEfL4iN/HSKguVrQAtpXPGomU3JG5XJYVatQFobm1kuGxK5gw18MZ+ct9QSyUQiyRjkean/xdfVB3Xwb1/XrnI8/28AVc8D5mMrbZIIswKlnTXjwAOiw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(3023799007)(38070700021)(10063799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?P2kENuJMZOcTUxbLP8VnEYmpMQKlHjsNTsnmDiq1K0K84QY/UEwbUA/lPP?=
 =?iso-8859-1?Q?5pS7Ap44/sChU2UJmNDtoLyZaILICKLP3JH+XZh1/iYnW4fTfOk8yUYP7i?=
 =?iso-8859-1?Q?/kmR/QEgF8/aD4XAYcnBk1KgneyhUXC+PSKlj6Hrr+dPTB0GFsGvUwi8KT?=
 =?iso-8859-1?Q?t6kdnYQEoVRLQ4iZYbBI7oAsGVVr23YawvyGyH28fDDqmU/tatU5uRW81v?=
 =?iso-8859-1?Q?Rmv1Ib73k0tI7CBd3IGZBWZhNr+ViKbiJ/WrjUeMogsNv0dw99W1XjG9Cr?=
 =?iso-8859-1?Q?DV3ExzLMHTIDQf3HalUQ3xitNSos3WVbfcuGYsdON6iOQDuRnu4EbiOGtj?=
 =?iso-8859-1?Q?hqe9wCxHmxRYuCrIKCTQSvuxRGo9i210O6VD6xRvKLY/iqGy019tZvuNr9?=
 =?iso-8859-1?Q?dkIvopP6kM4qnKXLljsd6zNrqWBwIrQFKN5imOmmJXNMBspFHEl3opIjft?=
 =?iso-8859-1?Q?qgG/KXoRJ4f2ojPTFoH69+/ixqXZ4QcvdVGiVOK0gcBloWrmnTFlUawaJI?=
 =?iso-8859-1?Q?tY0kwvE80nZ6YsqH4EoEwdZZ8Yi85f9zj8R2n62I0CXtuaUG6VQQ9Y4alP?=
 =?iso-8859-1?Q?0pH29H7tcTTgCHTq0IITPfnGQU805yfUimFaxIs/AARL6d7h/uUjJHleQM?=
 =?iso-8859-1?Q?0Ohnpx0mb0VWMUt65QFfC2eoWLz+cVb8MUkjCmMdwFILLUJKbI05rm3BYW?=
 =?iso-8859-1?Q?I+W0lDWLPV8xrPf/MXOeViFYsaDFNpiJ6/DM1mulhg8bY/YehTVsvD/v4p?=
 =?iso-8859-1?Q?Yhs1+QboBO6YIKTLxkbQf4IC6ctMvo9L+VIlBTU16Gvvt+xj9JsPek7Doc?=
 =?iso-8859-1?Q?2Kf6SgcPusHQ3KO9hPsVQpgyAM1C5zC3/hrqnELj/PZQD7QrZJqaHSCJjY?=
 =?iso-8859-1?Q?LqD5zP7YcCEkdejF+p+gbZpNGJ1U4Hv3qo56UegDekz+0ufL5eRPAkeQZf?=
 =?iso-8859-1?Q?LJiYZ161vSTSLoAoiBBkBfoTZ50evG5pblQQbYfFgdR658EZSIZe2koaGb?=
 =?iso-8859-1?Q?+jdhJhMPa41V2WQsT6HnTqPAnRqp1JdKpfrbeBx28vA9Ss/iMm/+51ig8h?=
 =?iso-8859-1?Q?XTbWq0UqzjxoY4x4BfMshxvwWNMTqli9vwlQjSAp2u8HTA7Qy/OAYQzIBl?=
 =?iso-8859-1?Q?25mtc9imgjaI2jaIZC2vRiew37Z1tV0mFS//1m5t4Piw2onOM1p5zrKVZn?=
 =?iso-8859-1?Q?iJg1TnooMiOy7kdf29D7AH62EQYYhOfbF7N/9iGeHuQxo82tnSzdhDQUkU?=
 =?iso-8859-1?Q?63e7S8HFBAdeEDvnNCGm5m5txLG0faREEbpaCwyWR7NXp0Zw2WCL2p8Uhj?=
 =?iso-8859-1?Q?a/GTrCdp251rA1h+SpyiZ/clVurNfiMapq8xkgSL8VCvKKrVbehQ38/T4U?=
 =?iso-8859-1?Q?vnfRabp5/d8J2rd3mq2lk03jYokHpAN127Np0Xs1csPQguQozgag/AHoeO?=
 =?iso-8859-1?Q?sP7APWjrvaUMgoJcLNCL6tHv1l5t/s049J+Svi3jMGBeeoWwQEn3TAnEaF?=
 =?iso-8859-1?Q?2iJXVPkuQVSQFR+FQkbFb/5RosJTBayjNCJrb/fLMQTwI7Jkocrs2LvaGb?=
 =?iso-8859-1?Q?f41UVwE4GnMLkjDRDNhbW4Dph57HxkolzE2gq34SDEU3a6nbbrpW3u0ngi?=
 =?iso-8859-1?Q?MdQF32uE1XW8vpQj0/uBy/0Z/x6wRtGCgAQ3A8v0RySNKsIG92jiED/mMW?=
 =?iso-8859-1?Q?lf/4HALE9kFf7zLhUkkmvf9CZCQ9dhuMZXCoYC5DoSsp+3Cq9KdPDFiNMN?=
 =?iso-8859-1?Q?Q7NtUKjp9gRvO3G+a7gnROnbkPiNe9t1M30yVCEB5pRbDUom0y64fugwIe?=
 =?iso-8859-1?Q?FVGyoAVBUQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ac736e04-82a6-44de-815b-08df1a52b6a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 15:44:26.3392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YlSGpG33y9ledno2CpDTjrLuIC2bQ7egA5T0wJFjFl+ef3nmXXJV1w28HLNYcdOZrY0a2hHEAb3jYno13I9FgpMP449wwIPzqtNSC4yzGWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13159

Hi Rob,

Thanks for the review.

> -----Original Message-----
> From: Rob Herring (Arm) <robh@kernel.org>
> Sent: 24 September 2026 15:38
> Subject: Re: [PATCH 1/5] dt-bindings: iio: adc: renesas,rzg2l-adc: Make '=
#io-channel-cells' required for
> R9A08G045
>=20
>=20
> On Fri, 11 Sep 2026 14:36:44 +0100, Biju Das wrote:
> > Add a conditional schema constraint so that '#io-channel-cells' is
> > required when the compatible string is "renesas,r9a08g045-adc".
> >
> > This is required because the R9A08G045 ADC serves as an IIO provider,
> > allowing external hardware consumer nodes (such as the TSU) to
> > reference its individual channels. The '#io-channel-cells' property
> > must be present so consumers can correctly specify the channel index in=
 their 'io-channels'
> > phandle property.
> >
> > Fixes: a3152e5c742c ("dt-bindings: thermal: r9a08g045-tsu: Document
> > the TSU unit")
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  .../devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml   | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

FYI, I Dropped this patch in v3 based on the feedback from Jonathan [1].
Hope you are ok with it.

[1] https://lore.kernel.org/all/20260921042809.4eb4b952@jic23-hlaptop/

Cheers,
Biju
