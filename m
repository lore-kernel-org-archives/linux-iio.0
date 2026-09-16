Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B654A6CE9;
	Wed, 16 Sep 2026 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550614; cv=fail; b=tQYIjyqONbWm/m1R7up+Q5QAvVLtXr7fMB+1QZT3KHUGm78bVCTjWN80S3E+rEOdmSJ3UlpKypSYFej/fhtxtXXLa5VxV6OhEIWHxGbNNgjQyeWmQFMYo+UfdiMGxR17b9ibgXmQ+TKXfRQgTkBooazaCl5OPSdFOBJ1KBabxrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550614; c=relaxed/simple;
	bh=mVwJ0MA/uRI42LaqUoe5tL0U/CkUXP4P/dzj1eE3+d0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y9SegYxvLPUhH0KJ0RUWrtEjtRYXQyhRab0WSMWlZjsQ1hQC6+zxPEqf7Hw1fDwQQfQLjTS8v6KRQbIcv/KiYLDutyIjEyU3K7Ty5v40jpzL9Ykwc+Fi2iPqJ+ix1Q9luCApfs1ix9Z4aa3Vxx34Jbx+pY0g8yZ0wgXj3VU8g08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=K7riUvnO; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="K7riUvnO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pItpcqlYfSS4/tzcS2mnriXM/+ffkgSipwa/9IPI1PjKu8H3FfmL9A4T0J4qwcZRCZQaER1gI5d5Ac6OGwsyGli4ZpzkRm44e5JdCUtcj1hSa7kJVnymIe30xKbPEwtrPXNAOYfW4UPBPJ4w6PhPgIvqrixw/PeIR6KdO9jQL4fbBn/Hwz6bg1xU+wXQe+IdZXToSSl6XzPyiL4R6kLF3Akp6gKz3rAt9OG1D1BpevXOhip4VMRwlsDm83UaZ4MpDlZpi6ngHLSXyVt4OPvWS0RKk2rKSicZv27juA5ua/avNjMYudF3XaLx+4l1d7U27lFBKrvqjLjc4HOKE6k5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVwJ0MA/uRI42LaqUoe5tL0U/CkUXP4P/dzj1eE3+d0=;
 b=JWqG63mDdy7dMUPkWLlQKxcKmoJEvb5sp5CYlRQHN9e6z89qbr2KutFbNeuzCi1SkfthUB8l/QM7xaZaIppdBs1rVPtpew85/6PlJjRTxD+naXHFeO0EBHIV6EKXYYZV8Lmj+oDuEDJjMSGC4cV7X+n99k2Y7W598oPz1Cyk2VJIoX+B2mhkiqkqXBxX07xDnXGX96kUWlltWygexwznrawqT1ZrNfusqkvYwxH5wwr5X1xmhoOe5ByEJXRKxAtEO+18syY0S9GQsOMxbe0oOhEHGJKBN8/3fsG8g5sDgW74jXOQImnZYAlFx9EGifLuuWsBI0gSLa2Zf0hyDtP7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVwJ0MA/uRI42LaqUoe5tL0U/CkUXP4P/dzj1eE3+d0=;
 b=K7riUvnOAFXb8JcrX0+zBNbAeWNgxdSxW40o+9Yslwd6Sldt3Mh+HfA0Dx13FSslqANx7HYQ7xYhU+1VxrUWgmLEJQec1x7oqEsAyCRggbx4HOCT0eOZSL9pDfVkC0pa4EvarY39pEILSi0dIWvy/EQb4QBJ5K6iPnbwiB9j2zY=
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 (2603:10a6:10:43a::19) by VI6PPFCAAB91F31.eurprd02.prod.outlook.com
 (2603:10a6:808:1::31e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 09:23:10 +0000
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff]) by DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff%5]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 09:23:09 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "jic23@kernel.org" <jic23@kernel.org>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"joshua.crofts1@gmail.com" <joshua.crofts1@gmail.com>, Henrik Grimler
	<Henrik.Grimler@axis.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"jean-baptiste.maneyrol@tdk.com" <jean-baptiste.maneyrol@tdk.com>,
	"robh@kernel.org" <robh@kernel.org>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>, "andy@kernel.org" <andy@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Kernel <Kernel@axis.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 3/8] iio: imu: inv_icm42607: Update _odr_to_period_us
 formatting
Thread-Topic: [PATCH v3 3/8] iio: imu: inv_icm42607: Update _odr_to_period_us
 formatting
Thread-Index: AQHdOh8+vJmnkD0Wck+bckYe0CECObbCY36AgA2VWgCAAQzZgA==
Date: Wed, 16 Sep 2026 09:23:09 +0000
Message-ID: <0eff05d9e2769d44f1cea8c874d2d0e39df1b2e5.camel@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
	 <20260901-b4-inv_icm42370p-v3-3-77cc31642115@axis.com>
	 <178874609181.3402141.11177384276502703798.b4-review@b4>
	 <PH0PR19MB997338A79A8E6DEE464AC775E3A5BA2@PH0PR19MB997338.namprd19.prod.outlook.com>
In-Reply-To:
 <PH0PR19MB997338A79A8E6DEE464AC775E3A5BA2@PH0PR19MB997338.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR0202MB9129:EE_|VI6PPFCAAB91F31:EE_
x-ms-office365-filtering-correlation-id: 0787a173-d578-4ea0-5ae2-08df13d41f8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|6049299003|4053099003|3613699012|38070700021|10067099003|56012099006|11063799006|4143699003|22082099003|10063799003|18002099003;
x-microsoft-antispam-message-info:
 nfeliCy49TM7CnVRvMDb1/cRCesLwFCYtYCdnrmkXPq7jn9hr6U+lg9LavcxN6D8HQuAtkbJqFnKWyvsg3s1QsWeXkob2v2i4rpMASqWzSrGHcnvEPfLh+DBPbtHMUa2ii1zhNEB5+AgSidWVE+siEK0mdoeXl5M2cjzOrlJjWSfTzU12C9xFnzZVOLE3c4meDv6uq6GUYX+RPvvpBwD6wV3FI5f6+Iz4ms6d3AL3lsX4itHLaloJYVAef5Uexg9Ua4QGft05z5YKQoKbL62We9Ys2N3MfxBvHxkmLMXORXdwaiL/v2blG7ORNm1mgZilfIoONiaR3TyjRG/SfYHG3A4ezCiafdTQ8wEUNFVvH6IdwJOOPsCgQULphvSkw16OtqqQ781KxV3lQy7RSxiT6WwbQ8fw0pK/q4K0lNAkxwPPp6Q+hjUorCrBBFBU6EruAVQGUK7swf95T+j6a+94qzpd+5m7Lfc6qaozf76N0jkeZcEtzZkTNRayXyxgSC5cNX2+myL7s1YPbcFNkgueAHP/icq6I+Wp6dwl8bsGnFiw2qHOUxigQtr2HRZYByf0CVYBBYkFFGcVnEfNNHCsIk2bO5jPFE+EbcV/pCvHjZD2HRKKldB1HQOEYEbogqX3N3ddpUiyTfC33kkOQv/FTiWlAMKAD0Qksjj3Kvt0Rr93jTdxrApVZS3SUBH5Qb88/Fgn8paCCSUq1QVx0SaTsZ3K+UaRNmAjRhftHAzSlYAvxbsPWTNS7SG2+YkDvsW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0202MB9129.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(6049299003)(4053099003)(3613699012)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(10063799003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmMwNmZPRlY4dzNrWGZ2TFVyRWFGdmkxd2ZUMlBCYnp5dVFLSDMzaENIWFJp?=
 =?utf-8?B?Wm9aNElqY3RZMklOdU9vMkJ2Nkg0dEFIb0JSTWNhSUxwMFZ2QW94c0FLV2FZ?=
 =?utf-8?B?OFRjRFc5clRxaEQwR0wxY1pacTdWcmxONkxTTndhOWE2ZzlPUzF1ZGFUOE5B?=
 =?utf-8?B?dVFGZHpBMStZTzZvUkdYdEdTZTJuWUE1aXh3NUpKWlExTFJsMGVLMmxkdnIv?=
 =?utf-8?B?bkpsVTA1eXdSdnNaajMvRS9mQ3hTUzhjTHRKeVd2U2NCMFRiNFVJcUtoZUo2?=
 =?utf-8?B?UWg1L3JOZFNBVGJMV295SFAyK3NwWERnbUsva080Y3dDUjczamFLRnNwUW5h?=
 =?utf-8?B?NDc4NXhxQjR1K0c0NVNRRUVPV1I2MzBrOG92UXRtWUc1aDFpUk9xMWFkditV?=
 =?utf-8?B?WkN0V3JpSWVZZFFVUENDcEFuNjZ3Q244U1RyQjdUbUhDajBJZlhiSll3TnZs?=
 =?utf-8?B?TzBkL0dUOU1ZOWEvY2Vhek9JY0hJTlUyUU9rSzRFMjMrNys5UUpvZXNmdjYx?=
 =?utf-8?B?aFhEelVKMTdETDR3RWhuUVNSZGE5ak1MeE9maUlzUmZXYUVCaEk1OEJPTVF1?=
 =?utf-8?B?cm9Dd1oveFRSQ0hhQ3dmTTM2Qm51QVNQelpVVmpNcDV4Vkowbm5VUFV4Uklr?=
 =?utf-8?B?OUhka3R5cVRRY1hmMGcreHc2S2gwNThQbkt0QmVoMHZKNnI5ZGdFbWNIOUEx?=
 =?utf-8?B?NTBCQWNBa3hLVGlWazNjN1BLUFNzRzhSMys3ZjRRR0tsMWJ6Z3dZQi9EVHlR?=
 =?utf-8?B?bGZvbXJQNXpxQ0d3UjgrTjhLUkVrM20zMGw4V2VxdldubHk2NVlsVUhFWXBk?=
 =?utf-8?B?ZlNjWFNNSnVzOUROSmdXSm5VbUJHNk8yRnhLdDlMWUh3Nktya0tkUWIxaEFV?=
 =?utf-8?B?Z3dmdFg4ZGs0a2xRNzJWemZ1VERCaUpvTGl2d3ZRWlBLQUZDNDdrQWIxa09U?=
 =?utf-8?B?ZnJiRkduZEhFajhhNjlwamJUQTZBSlEzNzVDNmQ0QVJJUVdSdThZMjUxM29y?=
 =?utf-8?B?QlZ3UUkvVW9SV1N5YlRRc3NJNUpDRkVMR1crM0xFcC8vaG1pa25HRkpYazMx?=
 =?utf-8?B?NUxsZzRCTVZMQWN4R3Z2ZjNvUFAvTEFuVzJOaDZHSXFONkhOTTQ2ZW1UMWdt?=
 =?utf-8?B?R2R4V0FMZWRwaXlFNlRSNi9aMlRiTEtvakZRZHJOUkx5QUNxZXEvaENiNERx?=
 =?utf-8?B?dXJwdEdMVFR6MlNIcUVHbjJxdXhVUHNCVHZTeWFYdkVTRS9NeVZXMHF0M29x?=
 =?utf-8?B?b25TYU1Nd1hoWUZOOStldENFYThqZE12TXpMZDVqeUZXMlZoamNkaXFhbUJT?=
 =?utf-8?B?VDh4a1IrdkkxRFRSYWdEVUdUSlhrb0tvekphMkIzMmZBek02WXd6R2diQWY0?=
 =?utf-8?B?bkhBUHdMNEdNWlcrVmowTDJJSVRwVUJjT08rbnRtU2FJVkxwUktNZCtEaElD?=
 =?utf-8?B?Yk5BaUtMc2RNVVM3bDQzb3ZsR0Q3QzRWMlNSd002WUc3cmhwV09DN0lIUGdC?=
 =?utf-8?B?UzdhZm96ZEZDSThCMHdHakZON2ovaENpNXZQVDgzTng3WVQvbmpIbTI1WHVp?=
 =?utf-8?B?YXpZTDZjUC9xbFYwd3FJUjhBV3BSanplWjQ0SnJVUUdKY2NITWVQV2hscE9E?=
 =?utf-8?B?eWJ4Zk81U3lxLzBHQlNNVlRURVlIY3lERytRODdINUFPQUFOeTlFQ2NzUEJ3?=
 =?utf-8?B?YzRkSzdZSnBmV3lUc2tMcDBsUWx3QlIxSlo0ZUl3WkZ5VmpZVFlWU25hMGlv?=
 =?utf-8?B?WGd0YTFYNllRVXlTYzF6RUtZM2lQclFVU2FCUGk0NzZvcU5UOGNOY0E1RkJy?=
 =?utf-8?B?UHNQMXJPU2poanREais5QkF1b2twWGZwS25IclhsSGhaZkN0TG12UG1yVHZ5?=
 =?utf-8?B?VjNLMUYvZE83cEVPbS9xTVEvcmhIRFhBMnJtWjNrc3FETEFKRGQ1NDVGZXJ1?=
 =?utf-8?B?N1A1eS9TaGdyd2xhT2dKTFpZMm5GRXJndmN4OW03bzgxVGVrYnZ6N29zSUdt?=
 =?utf-8?B?RzRaeGFCZFV2L0Z1QzFZVmVXeTdHdnJqY3RLTVVDYno1L2JKRkV5aXFZZTVk?=
 =?utf-8?B?cVlhTkVYTUNjU0ZMY0ppZFJaOFd1Umd2TjE2VzJ1blhTNzdIWmpHczR1blVM?=
 =?utf-8?B?WnFZU0s1d0RQTkFxaklrTnkzbWUwVG9ZV1VzcXczUUk0WkcvZkg2RVlNME01?=
 =?utf-8?B?RzliV1BPVjB0cnZ0a1d3WkxUeEM5V29yVHlhcnJBWmhQQk1scVZwbUNLSnV0?=
 =?utf-8?B?RXZGZisyMGpoRHdhY1MyTldIaFVhN3RScGxIaWFJL1FiekpGK1VHajdCdWF4?=
 =?utf-8?B?S3M3Wmp3Y2J5dTN1bFlNQ25WUHRCYjRrMEdqcmpzTTM3ZlVaZWh6dz09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-c3w1G4RVxugM7B4qQq6A"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0202MB9129.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0787a173-d578-4ea0-5ae2-08df13d41f8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 09:23:09.2674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTLzw5dg/ghVhYcCiwgGqdmG7Jh6wbU8jDOkDPwj8Q3sBH3XLNhFIv8oMpXvfVfT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPFCAAB91F31

--=-c3w1G4RVxugM7B4qQq6A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Tue, 2026-09-15 at 12:20 -0500, Chris Morgan wrote:
> [Some people who received this message don't often get email from
> macromorgan@hotmail.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification=C2=A0]
>=20
> On Mon, Sep 07, 2026 at 02:54:51AM +0100, Jonathan Cameron wrote:
> > > Update the function formatting for the
> > > inv_icm42607_odr_to_period_us
> > > function. This enhances the readability of the function and drop
> > > the
> > > unnecessary comments in the array elements.
> > The description doesn't mention the change I don't think is
> > beneficial.=C2=A0 Which makes it even easier to drop that change.
> >=20
> > Thanks,
> >=20
> > Jonathan
> >=20
> > >=20
> > > Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> > >=20
> > > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > > b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > > index 4d51b0da1aa1..fa85cf738cc0 100644
> > > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > > @@ -62,16 +62,16 @@ enum inv_icm42607_accel_fs {
> > > =C2=A0/* ODR values=C2=A0 - Note Gyro does not support ODR less than =
12.5Hz
> > > */
> > > =C2=A0enum inv_icm42607_odr {
> > > =C2=A0=C2=A0=C2=A0 INV_ICM42607_ODR_1600HZ =3D 5,
> > > -=C2=A0=C2=A0 INV_ICM42607_ODR_800HZ =3D 6,
> > > -=C2=A0=C2=A0 INV_ICM42607_ODR_400HZ =3D 7,
> > > -=C2=A0=C2=A0 INV_ICM42607_ODR_200HZ =3D 8,
> > > -=C2=A0=C2=A0 INV_ICM42607_ODR_100HZ =3D 9,
> > > -=C2=A0=C2=A0 INV_ICM42607_ODR_50HZ =3D 10,
> > > -=C2=A0=C2=A0 INV_ICM42607_ODR_25HZ =3D 11,
> > > -=C2=A0=C2=A0 INV_ICM42607_ODR_12_5HZ =3D 12,
> > > -=C2=A0=C2=A0 INV_ICM42607_ODR_6_25HZ_LP =3D 13,
> > > -=C2=A0=C2=A0 INV_ICM42607_ODR_3_125HZ_LP =3D 14,
> > > -=C2=A0=C2=A0 INV_ICM42607_ODR_1_5625HZ_LP =3D 15,
> >=20
> > Why?=C2=A0 We often put all the values when they are mapping to hardwar=
e
> > register values simply because it makes them easier to compare to
> > a datasheet.
> >=20
> > --
> > Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>=20
> Just to provide context, the only reason I chose the byte order I did
> is because that's how the existing icm42600 driver did it. I'm not
> opposed to changing it especially if it simplifies things or makes
> sense, but if we're going to do it now's the time (as the only
> current
> consumer of this driver is the rk3568 based anbernic-rg-ds and the
> rk3576 based anbernic-vita-pro).

I have dropped this change in my upcoming v4 of this patchset. It can
be fixed, but I think it should done be in a separate patch not part of
this series.

Thanks and Regards,
Kanak Shilledar


--=-c3w1G4RVxugM7B4qQq6A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTOMrdbv2P+LZwbQtLEY9j7t8KaZwUCaqpf9QAKCRDEY9j7t8Ka
ZwzdAQCR7aY9mvMJd0YkZ7BAIiAUu4VSdgkikPEIq0vQS7izoQEA2/XAA7XsVfVw
zveZaFjLa4wWS4pMFFwjfhgxB6zsxAQ=
=SglO
-----END PGP SIGNATURE-----

--=-c3w1G4RVxugM7B4qQq6A--
