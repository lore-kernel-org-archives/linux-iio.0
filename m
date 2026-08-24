Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780703A7848;
	Mon, 24 Aug 2026 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787564024; cv=fail; b=L6y0aNq747r15tj6n33S7UoatKhThUTDV4BFO/R41uLkSCappyWQw22EXtll59PJDhgsXJLA+DeN1PhK7g5stVyOKPwQ3vUWstmpt3i6csgUp0dKhBQl5WwV6EAD4tc64sx+t2emmuJsFI3cCRyYA1teqY7U9lbvv90MMy9S1fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787564024; c=relaxed/simple;
	bh=qdGJw9XiZoJAfu5UR/MrpPUVyhIE+w3Xn/lX0Ozy+88=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fd63Sj+fpfl1SeauMEBI0U3Och8CzsGj4XNEBfxmUFe3iZx6xNnNc0Jvrt/u3DaPdG5Xy2QTbYccc+zcReHNso5mSDFkefKLHl5VftgEJtAV45DC6wK7IKLtbIANnSPuxyWbTVwUiBtqYq3IqnNuqyr2o/42NZZYDhmsOsTDJb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Ss4vbB4t; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Ss4vbB4t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTVYvJgnhgJHG6h+kblY+FHhkPw1kjcEjAQatKj6eMaAXFMn1lGckSp4I31l0AfgqPS6Z7fNU1z6m0LYS7uIvyxR0lTooZAXEB+ErPGrcTNqjq8l9isFRbONZ2/ETt4ui6EPkvLNYjPxL0XvbkPNtTtgShHRXBkPVqVI59R6bAII4ZdFvkGpStt+W72C90uyczHmVAQBZTXcoXTmEutilq2fPW7btCVwoAZ05K97a06v5TrrvgvtT77c+WdyNdX6fOWEs070QwxWOHTPEWzi29NbRjX+zwzebCvulh7lb3p4EptI+7qsUx5cJWRyE2lA41a1Q8cQOgoc7ZZZE9uoiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdGJw9XiZoJAfu5UR/MrpPUVyhIE+w3Xn/lX0Ozy+88=;
 b=GZG3JX4996p2VHi7QUhEGi1t5TfnjdzYX/lJLOMkjrrK/y2nm2YYX6HIa1yjbPbDpMV5RXCsUdLPEesECavQhuCUWw2FOPD9OMUEXyAJcb8upQT6QoGiv2/xCFAUhYBeQB61M2YZHB2N4o55MP34BdNZ4F3HRhA4vwYiWZnCtVIWslwX4a3PtgnCv+/jwc0aMx70sGQ/HDIx3rXRZnJ/8dRrELS+SOLuevfc6kOcPcCuDkinrSaNXazuxIlbjQoswZcqwGGM/ue41zIBGpZYjLGyyo7pR8Xg+9KAHLuDjEY1wZNZzQvWZuXQgJx6j8dcYCXpNcbHvpTuAuyJacqgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdGJw9XiZoJAfu5UR/MrpPUVyhIE+w3Xn/lX0Ozy+88=;
 b=Ss4vbB4tgspnWlZmPpf2GILU3qO7NZSeb4idrT1/BMt3HkbCTGYfcEOf3G14uwQwOC93eH/IfIOCjmgV2WyjkGvFwjnpRYC7He0CvPmsnFiQ2lW/qONbfiiCNDUQApBglfi46/ZkOrx2k5jcqelmpl3h0ZIVCldWkiD8N+sicNM=
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 (2603:10a6:10:43a::19) by AS2PR02MB9581.eurprd02.prod.outlook.com
 (2603:10a6:20b:59a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:33:39 +0000
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff]) by DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:33:39 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "jean-baptiste.maneyrol@tdk.com"
	<jean-baptiste.maneyrol@tdk.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"andy@kernel.org" <andy@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel
	<Kernel@axis.com>, Henrik Grimler <Henrik.Grimler@axis.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: accel: Add support for ICM42370P
Thread-Topic: [PATCH v2 2/3] iio: accel: Add support for ICM42370P
Thread-Index: AQHdKx75Am9VUxIwQESw7+lTV7Qul7agAGOAgA0AmwA=
Date: Mon, 24 Aug 2026 09:33:39 +0000
Message-ID: <751ab6d68a10ce896e99f213810dc6ffef131516.camel@axis.com>
References: <20260813-b4-inv_icm42370p-v2-0-11aedfdf76d3@axis.com>
	 <20260813-b4-inv_icm42370p-v2-2-11aedfdf76d3@axis.com>
	 <20260816035955.61e4c805@jic23-huawei>
In-Reply-To: <20260816035955.61e4c805@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR0202MB9129:EE_|AS2PR02MB9581:EE_
x-ms-office365-filtering-correlation-id: c9e6bf01-1333-4b18-e4b9-08df01c2c777
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|6049299003|1800799024|366016|4053099003|38070700021|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 oPiXagQhrj4+DgXrOgtZgMD2hTsKSBn9waELncLZjdwpscc0iVvxo/GkfRPIQOdOuOhf5z0UHyaYs+MOUS6C+m0zyQRPRctICrC8MZfi8ERiAMi/NuiQReOgfGQeX8j84OV3mWMLvgHGQHgXA7BLH+eNqCR+QgQIIk7e8/1wo9OaKF83qbps09o1mR5Fdqm5NcITLJh7BBppSsnzKhrRJs4m7bmhKIE9MhnKs46f4C2LREw2r0rhB6I0ZxGA9myQ2Z3dHT/hlK59QMjb1bxMf589YhJ/vkkl/rub06jBhyvxTYAbvXfaWaDu2fESjcWBHvVk6lVSFFBuife3htSnUprprIxYIA0kuxNZaxTdcKKGLqLFJGclIy3LNvzFW0U4H/lRGpP6xbB6tlesu+I7pMiUHQY+iaR2NbQQTnYpdqOuChMIuXjg9vLo6XRQRBjs6Ed/+dKsr/AE6kDNnkfnQs/5pgHgP3Z7Xq4oSA6f6JrzGpd3wgMuB2PlhzLoQjW3e9uf6tkGjc0oEdxbNwRwkYPxmUqC8BprcIXMy4TRMYP1ij043nqcWL0JAvu67x9+PfFEN80Yoj1y6c0MkW32QtJf8GQNFirLJbQ+VcIcXBxxcNczb7tg/5gfeXSKMIqOtByBOGMKMVTPqDDW2zQ7KgnVuTmGMBBjnl3agQuWxWp52kRJNL0uCzKPRtKb4DWAmYAVDzACMHDlrq5QqLrmgEoAjG0wqGNG67FSaErIntk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0202MB9129.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(6049299003)(1800799024)(366016)(4053099003)(38070700021)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajAzdVk5K01lUjZzL1RpQ2Rrdlo3RmpSSUo0U01pMU5ha2RzZWltSDI4aDFJ?=
 =?utf-8?B?R2xiQlJiRE5vcStrMHBxNGJnaE9jdjRVMFdJTHFaZWVSM0dQa29YZHpodWJK?=
 =?utf-8?B?dkxQWWVSV0hGUEZ3emZKcG8zRHhHNDd3YTdHeVR2VlVnZ1kyMjlkVmJqY1Jp?=
 =?utf-8?B?eWVzQVp5RnphaHlQVXFmcUlHT2ZRUXpVNjBoMlNjV3pJZnFINFRDYS9ETitS?=
 =?utf-8?B?bWdhazdLdFhxQmlIU2xFZ3FjOFJHNnRqR0ZvaE5UTjRIbk9GV3VxYldjazda?=
 =?utf-8?B?NXNYY09lOGN3amRlUkszempHWmtpeUN2Vk5YS3BDbjZxcHllTjlZNkJGVGhN?=
 =?utf-8?B?MGRZbUJUUW50ZjhQNXRDeEdLWkQ0aXFHVGFPZGU2K0dBWEdkT3JtQS9OeXF6?=
 =?utf-8?B?ZHFkTWtUL0t1UnNzWTNWQXJRSUdXbGJEanl6bDdaZGVpdk1mZldldVl2TVVi?=
 =?utf-8?B?V3dRSE9KbkNXUFh3T3QrOTkrUXI5MDVyV1oySzZJWFh0Zy9DeW5Ec2x3WWYz?=
 =?utf-8?B?WkI4WHdtSTRPcFNHOS9EaVgyLzJNSU5qVmM4MjRKaUdWWVlwY2J3NTVDTHVD?=
 =?utf-8?B?T0hNbFFDcnNCNUVZREdrbkhKQUFZamZCcVpKbDFJS2RGNFJyRHFJRzlPZ3BT?=
 =?utf-8?B?QU1iVzRDQU54TlptY09QNXF0dEJEUDJBR04zRXdscHFidkE4eHJwUFF0QVcr?=
 =?utf-8?B?R1VQRHF3bk1WQ1dHWmkrT0Q1VjFmamp4YUcrZWozeW5Rc0RPUllGQmZPTWJG?=
 =?utf-8?B?NmZmTGU5bHNDaEx6cjRGMmM4aFVwR3JEa2tobWZGc0ZzT0VMTkd2Z3JuNlM5?=
 =?utf-8?B?d3lWKzF3TXRaUlp0VVBQVXUwZStiRWdvbUs0YXRVVWtLeGlqRjlhK2paZEpH?=
 =?utf-8?B?aithc3pQczlmcmh3OXkyamV0dGRodm1JbFV5VVZENUgxZVBOSUxSZU1pQmx6?=
 =?utf-8?B?UzluMjFiOWtyb1I2bmJiMEg0dEZ0aTBlUlVUa0tvZUVwdmQrMklrajJOMzc3?=
 =?utf-8?B?aHpVenRiTTh2WGVRT3BXc1prM0xnM28vZ2ROLy9DUGM1VU1iNFNYUHhPd0s1?=
 =?utf-8?B?ajRwNXB0c3Q2NTEzMTNHZjlEcWJ3anl0RHRreTRlc2pxcVBNUXNBN0I1U0Q1?=
 =?utf-8?B?azFERjhTWXo4V0dQSmJrODBGaTg2cFpyV2tBYSs4TnR2RlFMZkg3Q09EVDZk?=
 =?utf-8?B?WnhKdkxjZ3EwS2Y1TkUwMTBHR2YrR0l2NFArbXlYMXRHS1ArYTRjdDRmOGhi?=
 =?utf-8?B?ZkpNN2l1SzVYQm56OS83UEJOOHZQVkNCWkZSeVdlZTVvWDkrQkliU1puQ2J4?=
 =?utf-8?B?V2dJbnRUTEVjbm5WanQ2TGlnWUJKMWN2NUI2RWJYNkNEdlpXSlZaUWxtbEdO?=
 =?utf-8?B?NWdBbUMva1ZDRkhUNWtTb20yd1dRV0VXL0F6ZHNva0svb1NQUnVuMXBra200?=
 =?utf-8?B?R1NZSTlLOVNjaU1nQ2xIN09ZWHk0QWpJRFlWUTFDbkdPRjR4NTBWOHdIbDFH?=
 =?utf-8?B?ZXEyL1pzakkwbXJ1cXlzWk9YZkdaeldWQURoTVRlU1ZGSDRkUHdGNHBQMHht?=
 =?utf-8?B?ZnU4am5xeWhCT3F2ODVRckZzRXg1WjkrOEZ4dGNaMnhBWmsyMmRza0pnekI2?=
 =?utf-8?B?V1pXRlE3Sms3cm5Mb3JnQzRaZkdRamFYN0F1Yk9TeHN3RVkxMWNRbmx4ZTB5?=
 =?utf-8?B?SjNRWVhianM0TTYrdE9YYmY4eGU2M3ZSZk5xaTVLa1ZhM3NmcGFMYnRzRFBl?=
 =?utf-8?B?bUFocnBSZkd1aE45Y25vWHhsSCtQUVg2SHh1SWdyMzJPMUM4aW4yWDl6T1Iz?=
 =?utf-8?B?azJJL0NzRnZQZ1dsWGVyUG1mcVdZaGlmNldHYnhXWFQzMDg5Q203amNIUDJ1?=
 =?utf-8?B?dmVMYTZnR3JoZlJneWtmYVYrZ2ZOUGpxcWpVeTNwSDcrdXlMYS9zMitCYms0?=
 =?utf-8?B?RVptcHBUTGRoN3pnVTB2d1A3MGp2dDV6a3lwZThMNlBLZWV6eTR4dTdZcmZ2?=
 =?utf-8?B?T2JsMmZMemgzNllRYWJNdjZvRDZXU2Vudm42bklSOWpWdy9PK2xjQ3dqcy92?=
 =?utf-8?B?QlhIVzRTNlMvQ1ZvK3NMRWszQ2ZoV2RteVZDckFNT2tCUnlrWWREckZIODVC?=
 =?utf-8?B?UzBzSSs2em9RUHFKdkxQQ1BHU0lWYjk1cDhjeHNWNjN3VWFNVnUwUmpZdUFr?=
 =?utf-8?B?TE5jdEQ4RXdvODBnQmpKOGZxVG1qbEhpS2RvVVdlQzZ2bVlJRW1Zd2pMbTFF?=
 =?utf-8?B?VG56d2RMVTJtUll5RS9oVFZLeHVseVVSaVArMitmd1VoTG9jc0puNjl2bUsv?=
 =?utf-8?B?Szc2cDUzcDVoU0lsaDZMNFF1dWZqdERidmllTklIQnV1d0VhY25rZz09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-sg0bqBwIDmXs9Z1lxDxY"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0202MB9129.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e6bf01-1333-4b18-e4b9-08df01c2c777
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 09:33:39.1583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WtECKTD1kYqrDJZY2CHU+GTPpGETqtVbPVH38cy/T3BJpCY/mk72qm4QIylGCyi6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9581

--=-sg0bqBwIDmXs9Z1lxDxY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sun, 2026-08-16 at 03:59 +0100, Jonathan Cameron wrote:
> On Thu, 13 Aug 2026 14:26:11 +0200
> Kanak Shilledar <kanak.shilledar@axis.com> wrote:
>=20
> > Add support for the Invensense ICM42370P MEMS MotionTracking 3-axis
> > accelerometer with a built-in temperature sensor. Compared to other
> > sensors from the same vendor ICM42370 uses a different way of
> > handling
> > register banks. Although the device supports I2C, SPI, and I3C,
> > implement only I2C support.=C2=A0 Provide basic support for raw sensor
> > reads and a sysfs interface for setting the calibration bias. Keep
> > the
> > embedded temperature sensor enabled because the device design does
> > not
> > allow it to be turned off.
> >=20
> > Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> Hi Kanak
>=20
> Welcome to IIO. Various comments below.

Thanks for reviewing the code. As per the response from @Jean, I will
drop this new file, and improve upon the existing Invensense, ICM42607
driver. While at it I will try to keep your comments in mind before
sending out the v3.
>=20
> > diff --git a/drivers/iio/accel/inv_icm42370.h
> > b/drivers/iio/accel/inv_icm42370.h
> > new file mode 100644
> > index 0000000000000..a4a822f04355f
> > --- /dev/null
> > +++ b/drivers/iio/accel/inv_icm42370.h

Best Regards,
Kanak Shilledar

--=-sg0bqBwIDmXs9Z1lxDxY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRZbIB7R61KYt5yWsuslrbqDH4eIAUCaowP6AAKCRCslrbqDH4e
IMRZAP0bg+7OkjXHQWjk7opmWiIEJdZBjH5jXaRzC3YPN5YT4QD6Ail2qNmDrAh3
efyqFCoRfUhln6qkHQY84gqrmCYgngY=
=DKCA
-----END PGP SIGNATURE-----

--=-sg0bqBwIDmXs9Z1lxDxY--
