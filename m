Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD343F0773;
	Mon, 24 Aug 2026 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787564316; cv=fail; b=j5wsKK2yBQSd1PTo50tIyegWUkkk9fJwIEkB25F+RAUQmS/QaBW5maa5QKHKU1TMAprxrmc1C5eJDL9ijXcv4NHCsMABoZh/5mNx7078jvd32I7YLjZVGQ8STetgOelJFnvseRZKV0nLWSmdVOrVbR24qwxLn1vTn4r18fH+IYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787564316; c=relaxed/simple;
	bh=aJU8ukRttjdi9lbZOoxf4JtgKywrmmHwrbb5pelXFtE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O7MPYfRWgGh+6J8+CO7NiXTfcm1mdjwLK3NjYjSd99EserIHNYD3qg76XnWiVdXVj6Zl27NFAygaGYCVfyDG+OIg/OtjIpRCrJfjsMKQKEJFd1Gowfdx45flh9vPNRq8jy+zwZVJfwPv37DIMeRDJddBfwT3upPePjP5nkBeXT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=gmIwZo0q; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="gmIwZo0q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfqkWJ/amiWshvcrD28ciYmsyhlm2s93NNfmdtcYih9miI1oLyuRnxFpd/K1xcRnvCgdckBoktWQ849rnPZwCiu24Xs+o0vJryMG3/VdDJGeTFX0shAJx2rAd51dHOasujdzNb1tj8lcgV8NVE83cqigkK5AAZ49QypOqixf/sKUiDMY+wSEbgrZSGnUlzRM+Bp3D8t4YTifF9o6qBpND8vE5iFZgrscZNxSj6q4mDDsyrMwmXrGmPxHw81Zb87cuV61WIRAZPk5rSMxSOmF8h/uhIBGjMZpgMa7QOuEbOULe5DT3z0ecpw5cbbibdV+HfF8JBcU9fhPEi1gXYmCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJU8ukRttjdi9lbZOoxf4JtgKywrmmHwrbb5pelXFtE=;
 b=DPB3HSHuTfjmPaMvp0pVJ0usvfxx15Wh+nZ6LcnXp3WzXlTqtnlxvVjOSn8qZHfadum1MSklq9i2Hx01cLHPPSXhR4QZpvvhHGgxB5vYmYvHxFI/ZF8brbC2xop0JBU3eOAB6rht+JqvI0mpr1Obncc734BKDAIjmCg91b3H8LdmopCiYqxDBOo9hOrE6RtbMQOCL3GuMcwSd+Ug2tzJbKBrANTGBMZj1V8etLStx9rZmrnra4Ilxg8XP/Rw2qvOkEy+8/kaSy8kp8A6FxBuNSn5qtBD7YctwDkBewClXmJJYEZpgUqz9ztB45NThjpsgGm4veuTpCwQDwa1E1E9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJU8ukRttjdi9lbZOoxf4JtgKywrmmHwrbb5pelXFtE=;
 b=gmIwZo0qgx0Y0E8GoqOvS5iHk1LwNCVZXGIFtrS+VTiI/dweLK1WQcL15yS1UV1GHI/ot9G5liFNuVWPlxWeQInChSXY2uW/yyEM4OoqWx6oyRjbK+H2edh29AwS9D0ew+d9Uu4q2PJrpR+t/qs9AQEspJBh5RNMOUmlBIOiD0Y=
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 (2603:10a6:10:43a::19) by GVXPR02MB11604.eurprd02.prod.outlook.com
 (2603:10a6:150:326::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:38:26 +0000
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff]) by DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:38:26 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "Jean-Baptiste.Maneyrol@tdk.com"
	<Jean-Baptiste.Maneyrol@tdk.com>, "robh@kernel.org" <robh@kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>, "andy@kernel.org" <andy@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Henrik Grimler <Henrik.Grimler@axis.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Kernel
	<Kernel@axis.com>
Subject: Re: [PATCH v2 0/3] Add driver for Invensense ICM42370P accelerometer
Thread-Topic: [PATCH v2 0/3] Add driver for Invensense ICM42370P accelerometer
Thread-Index: AQHdKx765lvaKnsrHkSCQy5bP8bVVranGGuAgAXp9AA=
Date: Mon, 24 Aug 2026 09:38:25 +0000
Message-ID: <05bd4082e24ab94e43cb86d4981e0b9f63ac0036.camel@axis.com>
References: <20260813-b4-inv_icm42370p-v2-0-11aedfdf76d3@axis.com>
	 <BE1P281MB1426653200EC50B0266FE345CEA42@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To:
 <BE1P281MB1426653200EC50B0266FE345CEA42@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR0202MB9129:EE_|GVXPR02MB11604:EE_
x-ms-office365-filtering-correlation-id: bd21eb48-4cbe-4118-8b76-08df01c37268
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|3023799007|18002099003|22082099003|11063799006|4143699003|38070700021|4053099003;
x-microsoft-antispam-message-info:
 2rOCZ9FtNgMBAGmyiglifRX7K+Fwtf7iB/y4xh8z3TC+Qd8tNS5z2PnEyYn8FVhUvB62YuNyGt8Y0nWfHvg/3USgkLZhMqAPwv69co2FGpDV2L1MkrbXCFeTwZWvJrg7wlzDQ2irHZWAIbAl9GKndjS1Vc0PIN4Zx1YJIGUFyKGu6MzC/mEjLAqdeEuUjKZmIcZHahjDDtL+84TVIsgQc8RLBHdGymNKZl2KO3qbwmat1Tl5TPqXTN5U13pSSRZKw/YWGhqJhcr/c0fAJQ7Y5h7iXUfyOPlDwMaqNnuTBv47uqEevyG/zDju8ghLWbsex19TBuv8mi8sDVr4JJDGeFCwMU+ZSipfqwmvJLtZ91jZCVHV200B/4SKdg9H8iugEJr5dgmV7Mc2IrXU1ckQFbUKb0ltHBtJ9umdVR3JDK5p4c+WEJZOd2pcBLFY6CSOSRVJI3411XjIvQuZsa2EOdkil54O2zTe13kNUzMTiYmkuPOiyDON/U4kLubBQ4l4+S4oQ2tSNKeJdknZvdeQ083D3hs7Fit3PhRQK2U3KBCa8ANbqgnkvD08cuaTMk9FiwBbbM+6Y81RSJdt7sbpXiVPG2w0eGsfgYRSCzZy5eLxYhDkpKSc0AogHZBK+qK6aGrujxA/h+kuoQuExN6P4qXvJojf5Bl4zSfHD+SMIrp4r6z6j6EvPwL5kGVCSvn0RPbZvr2Sk3aX4Ue3BAGXY9nI0SipExqXoEKVAy4QcVU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0202MB9129.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDNEc3FFSHFwS3lUVnQ4OHlia2gwbEV3OVJxdkZ4eUc2Ymo1VHJXaStNb2RC?=
 =?utf-8?B?by9YN3dWMlRNK0RJUjBiYkI3YzhlQXQ1SldFUHY2SmFHZHlzeHBBZXdVTVdi?=
 =?utf-8?B?ODVYWW1ra2JSRGF0QXYvb1l0NEdQSDgyaThNcTNwaUFoazBRaGZMQVQrREZE?=
 =?utf-8?B?clpjZVFwNzNlOHM1TVgwU0dLZVJhRGtOS2NPMFRCY3h1MVZSVHlOcitQK3FK?=
 =?utf-8?B?bHhUYzhYQVlyVlJlMUFLMzZvTUdHR0RPYWsvUjQrRWxEOFlSNFVhSnM3RE56?=
 =?utf-8?B?dkdBVDJ6RmtESlltTW9OcnZ0K2VWSDdSU3N3REwzYXZCdVk2enpHdytOR2g0?=
 =?utf-8?B?SlcxUUJmRk9rU2VDY082RW0xbW5lMStVTU93aWxDQVdHNXcwY1BsdElKWk9z?=
 =?utf-8?B?V3A1akVQS1o3WEZMMnRNQlRpVWtzVUtmdEtFYWlFWWtBbUk3YkFZaUljOGk0?=
 =?utf-8?B?eUFVeG1xY2hZa0FoMm85MHkzZzh4SG82S3UrVVlCRE8zSk1ubDJ4SmVGMGhm?=
 =?utf-8?B?ZDV6cnhQQ0E3L3NQS3F0LytSdDZGUDhCczlSNDhCZ1RucFBLdDkvZ1BFTVZt?=
 =?utf-8?B?ejA4cVlybWhMTzN6YVgvT0RsZkU5ZGxTWDI1K2JDYms5dUM2a2lKdWN3RmV1?=
 =?utf-8?B?cnZtNHhzVFJsR3Z3TE90aDg1Vy9uVkFLMlh2cnVvMmNQc1JmSUFlY003UDJQ?=
 =?utf-8?B?VHdOa2UwVTd5dDM3UXo3N0NYNG82TDdtMmVNbWV6L3lHOEhnMVE0STgzYnRp?=
 =?utf-8?B?MnoxbmU5eUw5MHhxNkF1MWd1YXlGVklyVEJRMkxXVDZFVW9lRGdUSWx2T1B1?=
 =?utf-8?B?VW9xRVZYcW5FT0lONS9tZmUwT3JBckpyOTIvN0pyd3l0YTlkRVhQc1R2eFBR?=
 =?utf-8?B?YkNqalhJbVd3RDVBWmJzUU5QZEZudmRGYS9jalZkdEpBM2dFTzZGUCsvWUZK?=
 =?utf-8?B?eHJFRllqSXZKOHNwWTlKRUpYa1RDeEdOUkhvVWNMMkRoSzFVVzNwR3BRYXFv?=
 =?utf-8?B?QlorM0ZtZGVzTWN1Tzc4K0V1c3pUNXFCVW4xdTFKUy9ja2NGcUZzY0xDRnNy?=
 =?utf-8?B?Vmp1b1c0b1QyRlh1YndEK1ZDdFhzZU80eWpOaDN5dHk4ekQyejhwTkVZeGtO?=
 =?utf-8?B?YjlvdkFTV1RDRkY2cy9QRnJFc3BpOVpvT0pqZE9McmZlQ3dTWmdhbW5yTGN3?=
 =?utf-8?B?Zlppb1RxUkl0d2x1SE44YXFqYUFuNnc2QWppOHM0RUR5NHVHYVJSbzNYdTUr?=
 =?utf-8?B?VTd4NzYrOS9QTE81dXlIdVhGZ0NvWDJ1emdhMStBbVpGa3VvZjlFVnBLWk1v?=
 =?utf-8?B?UjdUemV5ZjQveXQ2NmxHTHBJbzliNitGVWt2QjNVZW9WN1dtbjRRMjhoL1di?=
 =?utf-8?B?blRqL0RYL2M4eEVCbnRSUkh3eW05VllWNHVIR1M0YlVOSCtsWitsU2NvQmN0?=
 =?utf-8?B?RCs4U29BZ2s4SXNUTldwUVI3b1VTaWM1RWFkVll4VEl5TkV3cVZic3NoSlFS?=
 =?utf-8?B?eDBDcU5PQklRZlorSW1JK05WL2ZwRjdTSm9HWEhHZjNvakZ0OEFHWWo4NGpN?=
 =?utf-8?B?b01STXI1eE1GeW5xdVNibU1uTDg0YTB3elllajh2cVltNDRBTVgrZHoxNjNi?=
 =?utf-8?B?Y1dXb2ZvY3FuNStJNDZHZDlheUZ5L0ovdXc2N3dmUHlIN0RLZDNBdTJ4SExK?=
 =?utf-8?B?dUIzNTBON0hJdWxDZkkwVVF5MTE3YXhPaW9MNmRqa09PQVMrTzE5WHlJQlk3?=
 =?utf-8?B?M0FOMmd1a0tadXk3VXVmTWpFcmNVS05CazhMK2hMLzBsRnBKWWRVSUw0azIz?=
 =?utf-8?B?MlNqTDUybnJCUUhTVUVuNlNvQ0N1RWYzNEFpMTBBbkRseTdoaVJBWHI1dXBy?=
 =?utf-8?B?ak5CUlVOZUEwWEROcExFMXNiMkpYelBHNnpqUmRKSHlYdWJodFVEdmhUUTVD?=
 =?utf-8?B?Zk03dC94bjRHaTA0TDYyMWs1T1QyNy96aTRVZnVjMytEUWNCai9QZnN1M1po?=
 =?utf-8?B?Slo1b3BPclBncUR5bW9mcklENDFDSDZleFZuNEZ3emlvOHoraW5UTU4xblB3?=
 =?utf-8?B?SlM3TDNteHl4NlhXTkJkSkVjWGd0cXJnNDdCZ2FueTZXUmxmNFJmS0JiRXB3?=
 =?utf-8?B?UzkzUmtINC9ERUNkMGJCZkgvMHRWM1hreGFPMlNsNk1XaVpZSUJOZFh4a2py?=
 =?utf-8?B?VHJRWHRVd1R0QmpLeFVoOWlEc3lpdHdsVDRZTmJxU2U1b244ZGEzc3VvZWls?=
 =?utf-8?B?L2I5MVR4K2wxVWNCUmcwS1VnTWNFUGF4ZzVDQUhaU3NBMkNPN2tSbGtDTk1q?=
 =?utf-8?B?RWt4aGtxN1BiNTlIOHJ0a1l3dlV6N0RvZi96QzNLSXUyRkNkUVlKUT09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-YzhQb6BRQwv2A+XPR8m6"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0202MB9129.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd21eb48-4cbe-4118-8b76-08df01c37268
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 09:38:25.9341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+9GVOD+BdjvWlid9Wp1LjZ9a70mQby/cTDnv11chX7HeRUEM8OiIP/f2Xz8ihLm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB11604

--=-YzhQb6BRQwv2A+XPR8m6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean-Baptiste,

On Thu, 2026-08-20 at 15:19 +0000, Jean-Baptiste Maneyrol wrote:
> >=20
> > ________________________________________
> > From: Kanak Shilledar <kanak.shilledar@axis.com>
> > Sent: Thursday, August 13, 2026 14:26
> > To: Jonathan Cameron; David Lechner; Nuno S=C3=A1; Andy Shevchenko; Rob
> > Herring; Krzysztof Kozlowski; Conor Dooley; Henrik Grimler; Jean-
> > Baptiste Maneyrol
> > Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kernel@axis.com; Kanak Shilledar
> > Subject: [PATCH v2 0/3] Add driver for Invensense ICM42370P
> > accelerometer
> >=20
> > Invensense ICM42370P is a high performance MEMS MotionTracking 3-
> > axis accelerometer. It supports I2C, I3C and SPI protocols. It has
> > a 2.=E2=80=8A25kB FIFO and two programmable interrupts with support for
>=20
> Hello Kanak,
>=20
> ICM-42370-P is completely similar to ICM-42607, except that it is
> accelerometer
> only. There is no need to write a completely new driver, you can add
> support
> of ICM-42370-P inside the existing inv_icm42607 driver.
>=20
> inv_icm42607 driver is lacking a lot of functionalities, like buffer
> support.
> It explains why there is no support for MREG registers.
>=20
> I recommend you add first basic support of ICM-42370-P inside
> existing inv_icm42607
> driver, and then add new functionalities like buffer support in this
> driver.
> There is really no need to write a new driver here. For MREG
> registers support, you
> can have a look inside inv_icm45600 that is using the same mechanism.
>=20
> Thanks,
> JB

Thanks for going through the code. I didn't notice the ICM42607 in the
mailing list. I will add support for ICM42370 to that driver instead of
creating a new driver. I will have a patchset for basic support and
then incremental patches for implementing more features (like buffer).

Thanks and Regards,
Kanak Shilledar


--=-YzhQb6BRQwv2A+XPR8m6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRZbIB7R61KYt5yWsuslrbqDH4eIAUCaowREAAKCRCslrbqDH4e
IMG2AP9QSn81O6+TISP0Kxj18CozIDNq4Uo+es8w81V7HiLpZAD/TrqK0rZkqZxt
Vn2DdtwPJS70HlUHuzPH2ueEdUi7dAM=
=zJDr
-----END PGP SIGNATURE-----

--=-YzhQb6BRQwv2A+XPR8m6--
