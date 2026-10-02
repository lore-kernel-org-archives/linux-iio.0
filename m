Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386443ECBCD;
	Fri,  2 Oct 2026 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949843; cv=fail; b=QQCuh49htZGB71SjJuIh28F3DvMH9ZC//qiUDhi079rVVWlE4Fttz/v8DbEGvSLhYCytnKbHQTOMy2MK1Lq00xaE4a0ShbJL1WRXlYKARQWazwjsYYARnVGwMUqkv+Bx5QzdUNp4Ksv9nRsbBOSE4jxW5WcmIp8Hdkr2h5czwv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949843; c=relaxed/simple;
	bh=2CEEbJ8PsdqZZnhEFljk+Wod8dt0qRygsP37fIcg+yc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PowMcLQW7LhWowCSy1K+ldfnCEgNWEAg+MgOJJiMfIGUpYuejPTwF/EtPpafTeq5puhQArAynyRU+Ocn/yez7huGE2fQe3iDN3ATZf9tOfksDYxFi35FJ71rNIR1ElzroaWzjFLDFJpccXUvGXzozsXENRNvbB3fnnRoxO/gbDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=bAYfaasV; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="bAYfaasV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJhFvukpZMtr/C+blQ2u/i3giaDk+4/XvGsvBRtcuI132XlpjA6FlYEKys1lqF0jHJopCZIRHXmPY4WgrJUK4huOFxtftrYtiUE4KnTZD80sstkgH4rOZF7oX0CXL7W7pvZEEn5gfUfj0Gciaf6aEUW15+CQqtK5u0d9OP7MxvBPHLhXa6o5XM62YN8bt4l4P1wKMH49OwYHrxOfSe/GiDLNaIKmwjusjFJdGT8IAdCuYYTfpHNSKXap4BNq0BShO4PAIWub7+5HogHBq/I6OtN5R6BACPoObcMJhjydVrXrXD9hsfa8r2mGalkcUH3h3B7EqT74woiuz5GpcK1YvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbEZzWF14GNNco446KEf1xKqbEnnXxxLSEk1JG1XADI=;
 b=V36LIjE8PhaYUG4c5qbMfjODrt3Yrt7HeG9TFuJVTv839d9D/1bsRLqCNHl7gnfMpT5Zw20pdlKt/CzNKboSQ6O7YngRaEhrUuY59vlvxbb/wDR4HPTr1ynNPWPnwvnyXP4v/sDUjBo9IRk4+JpBAZCoXp6eAyhL9HjXsvLQGCw3LZtIsUq2qYR4oVghoaO1Qry1vj5JMdLnH5g5oLmwowH+awz0E/UQQMSM0B0mHXgefqBgQviSxEPo8+CEy9TYN9KpMZ4g9r4usZzgRWM/Da3ZuKowtXojbu60MpU5lABYFdCU+XLPNg2mQ3e2I91gx0Rv8bWc68EpAFBC1zquzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbEZzWF14GNNco446KEf1xKqbEnnXxxLSEk1JG1XADI=;
 b=bAYfaasVOjhfI0YitkWx9PdAeADZUObhEv2yp+3X0idIOSOwOm5g7/WdQ9e0ydLzW/BWugAMm6EuSHFCN9PMm/7lfR681x68AQfrqumoh60QX/xCt+SkTJvAF03rauQXLgVwCkLH+pjEaRc+hVHN8+tOUD4EpDkZPvo9XNaLy3g=
Received: from GV2PR02MB8434.eurprd02.prod.outlook.com (2603:10a6:150:ab::8)
 by PAVPR02MB8965.eurprd02.prod.outlook.com (2603:10a6:102:322::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 14:03:56 +0000
Received: from GV2PR02MB8434.eurprd02.prod.outlook.com
 ([fe80::a2fa:a7a3:b6ad:9e4d]) by GV2PR02MB8434.eurprd02.prod.outlook.com
 ([fe80::a2fa:a7a3:b6ad:9e4d%5]) with mapi id 15.21.0451.026; Fri, 2 Oct 2026
 14:03:56 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
CC: "andy@kernel.org" <andy@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	Kernel <Kernel@axis.com>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joshua.crofts1@gmail.com" <joshua.crofts1@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"jean-baptiste.maneyrol@tdk.com" <jean-baptiste.maneyrol@tdk.com>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>, Henrik Grimler <Henrik.Grimler@axis.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 6/6] iio: imu: inv_icm42607: Add accelerometer
 calibbias support
Thread-Topic: [PATCH v5 6/6] iio: imu: inv_icm42607: Add accelerometer
 calibbias support
Thread-Index: AQHdUmTXbofSJYrnjkmW+UQhjA540bbqPCkAgAAMxQA=
Date: Fri, 2 Oct 2026 14:03:56 +0000
Message-ID: <6996d6084e7d346fda57b7995005d8eb6a583244.camel@axis.com>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
	 <20261002-b4-inv_icm42370p-v5-6-c65281b745c9@axis.com>
	 <ar-vFLFy1JhquDga@ashevche-desk.local>
In-Reply-To: <ar-vFLFy1JhquDga@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR02MB8434:EE_|PAVPR02MB8965:EE_
x-ms-office365-filtering-correlation-id: 7f12e344-f29d-4e14-2c90-08df208dffb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|6049299003|7416014|376014|1800799024|10067099003|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003|38070700021|4053099003|3613699012;
x-microsoft-antispam-message-info:
 8olxDDdIm3bztY54tQ7hodwJi2BQNaG2L5Y2KSXNHe3PzMoM0pPL6f3pw7zbTYcTchOtI6ZO3YCKAqXTb6VGK6/Q8/tCon5AC1wp2LvUpur/wWojSb0NpCwIA2WWj3KaZQQuytxR3hBAouGv3eadNzthvAsoKm/0oHXTXcNl0dLWjjEx4yrbgfA2LhvohA3gN7JFUv97vcao7mDEkQoii5KPAIGHOJ+o/DU0CvxirmPP7K45goaAde11pd22WM9xhK+GCG9RG65i904equvBFKpVr6X5b8Iu6pPTiZzeUR54UZxwk/8EXpACHih0aHQt3usPP8WJqRqro06GmtM6SPC1RaWHmWF8LOjiysscX0yp7ZjJD7TSNCX/9Ob/lN/pUJOkcLZCr0SlI7JqgIzutqKPYQEGSTo8H9yPmJdkAXP1YuNugL1gsYGQzqC+wTm3A0U5AptZgRADf277sImOL2+8alHGdrHXtsDLHTQ+KDm+8Ez0LzcLeNQseOhQvrNwJruVb8HEtixIqdYv1r5cJ2X2XVD0WlFuVaQtO5WvaLn8APq04E6YS9WGUxqcDf9VIV6aC/9WjBJ9l9DLGqOiqzBM/XwIXxUcfaFam7WpKbJqmOpJBJjKiTDlBzd77nqkUkc6O3S0dNyNsXL+7EmWy4cXsXvEvRIqRkicylstQCgGVnu7jq89Bnre6Ro5h3bPsaRTV7BTWGqMn5/g0O6hYQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR02MB8434.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(6049299003)(7416014)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003)(38070700021)(4053099003)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVYwMnNGdGlaMkgyUjI3OW9jZzByb0dIbWRmcXJPdE1vMWRmMzVqN1pxcXJS?=
 =?utf-8?B?U296L1owbWMvRTNkOXdUS3IwV1NtQkpDSUUrNjA0M3pybm80bU43YlJCNU1H?=
 =?utf-8?B?UXFybHRZYzN6S29YUkRDb1pHWHM2VkJRR2hUTzNVS00zaEJsTjZGandWTjd2?=
 =?utf-8?B?bG96bDhYcU1nNlc5UDgwQzBJVkdwNW1nblhyZmNNRFlTVGxrVnZNTTVJWndk?=
 =?utf-8?B?cXdFbTJFWWpxeDhOWi9jd1d3bXFENTdLaXQxVzN6RndHb2NDLzVnVGlkaTNl?=
 =?utf-8?B?WnV2Umx0UGprZnZmSDZpSmJjdmw4UWQrQUdXdGF2UVM3bktOVFptVTE5MVlz?=
 =?utf-8?B?ZlVKUU92SGhxSG9vNkgvTS8ybU1YNkxaUDZDZVpYbDJCaFltejlSQWlhRFNv?=
 =?utf-8?B?ZENjbWEwWWczTG1MQTVrT0VRYlVKSEhpUjZCc3FlSTdxME8ra0luQjIzM0ds?=
 =?utf-8?B?N3EzNzR5TlgwaGVVd1A2SlJ4M0pINlNxZm1EVFpZY3NFaFlUTUNFSGRoZllm?=
 =?utf-8?B?VnI5ck5HTnZxZ0Q3UVJxcDI3NU14V0lGWWprbm9yaE9KNU9CNi8vcXc1eER2?=
 =?utf-8?B?bVBEZ3RyVEpqRFY0L0RxOHQ1NVlJQWo1WlkvUEFLRmtTYnV6UFRHRUxZSEZv?=
 =?utf-8?B?NDA1VU83amZFSlczcTl6YVlaTjJyWGhoUU9nVXFESnB3Z1ZuU3M1T0NQc0gz?=
 =?utf-8?B?akJNVDZNNG5jVE16aFptdVkrbU9ySVBuM1VzdWkzd0oyMTh1ZWlWMjhOTFpa?=
 =?utf-8?B?L3IvSXE4dHZ0b2tCTkJ0dDljazRvZUJxajMxTVNubjFMM1VjcUExK1dTSkZS?=
 =?utf-8?B?TldXeFRYMFo2TEIxRG5qNi9rcnY0Sk1Fd2F5ckdkYXRvUTZWUmVFMWtLY3pO?=
 =?utf-8?B?RW5rR2lUN3I5MWRLVGo4VEM3eDYzQlZXUUMxQ3lFYWhKNzNyRGlmTVJHd1BU?=
 =?utf-8?B?cStwbytnMUh0QmlIcC9nRXBvb3B1a1hkMjhNZXBUdGxMcE8yWktSUDFNRG83?=
 =?utf-8?B?RjNOa2xNL1ZZZzB2eHRYUFpEWEUxR1FEZ2Fvb0hsQUdLM0Zjd2tYTVhMdDN2?=
 =?utf-8?B?RXYzbk40Q0FBazJyaHVRdnViVGJ0Wk1oUlNZS25UU3NhQ1hsaGtyVVpCalgx?=
 =?utf-8?B?RTRERWJqVzFHQ09LMmp5NU1hY0NJY1pWZENHbnBSTXg4a2IwSi9kcTFZVGIw?=
 =?utf-8?B?U09hK0wyM0N2VHRkK3pKWHU0ekxWZUVWaHVxTkxRc2tiaXdLaTF5MXVwMDJt?=
 =?utf-8?B?U2NqZFZXd2JJY0ZoSytKWlRIcExTSk1WbUVIZFA4NXVLcGJyWXZIWUpMMGJ5?=
 =?utf-8?B?OTZLeWtEM3ZrajVyS1NPWndpMDJTV2tOcldIZi9nTW9GVFFMczJDRkdNa2JC?=
 =?utf-8?B?KzVvTEdzS0V0TUlWYlVra0QrV3JtRTMrcHd5eFRkNGZYSHMvR0JUMk9hOUQz?=
 =?utf-8?B?dThXbWkrUkl1aHFDanZwWFRaRDZySzFJZ3BZMUdaSUVabUpnSWFYTEJyU1pJ?=
 =?utf-8?B?dXhCOTVYb3lKWVlUQUhoRC9nUXVacHo2clR5elhNd2thWFNSYlBHbVhJakRa?=
 =?utf-8?B?R3ZqNzZsOWpDUnBDNGs4OW93dEgzekEyMnU4cFRWdmhXL1RKVmxZMDYreEVm?=
 =?utf-8?B?Q3FJMkVJZm1zZ0FkWDBpWjNxMHJteHZYamZuR0J0cGlCcEx2U2xOMmcrendY?=
 =?utf-8?B?NUNjNDVZWEc1a0szQ1pJWEJzeWlMUldtaXFpT25VTG1PTkc0dmkyM1ZsMzRV?=
 =?utf-8?B?aUhadFJ6VW5kM3NwWEV5SVhBNWlBZHFGeFZHQURrNTBuNU0xUit5dVhWZVVP?=
 =?utf-8?B?eitEZkdrQzhDaXFDbCtxRmZrNzZYY0wyNzFLbjU0THIydmtyQ2lDRHljZlFI?=
 =?utf-8?B?STRTemdqcjR2ckJkUVF4L0dibGc5cVkxaVRUcGdRYVg5WC9OTTAzdXUvbXlt?=
 =?utf-8?B?bzVCdDVORTFIUFNsaDhBR1JINFdTZzdieVhmMGwyVGlreHVrL2xEeFYyNmE5?=
 =?utf-8?B?QVZkVVhRWk1aWnFjcE5qTmprdXNhWWVZazhsRTJ6WG03OXRLTDRSRGEzY3c5?=
 =?utf-8?B?VDk4V1lETHZBODlzOWdBSjVFSGE0aVBWMjh5Sm94MlMwWVQ4L1pGWEsvQUd1?=
 =?utf-8?B?S1hRd1d1TUE0em1Ha3llV1h1NzZIMEpNcklsR0VOR2pOWG5PejNMUU95WTRM?=
 =?utf-8?B?eUpxRDlrWGR0c0NDM0d5YklFRWNaSXQvZGdNSjRlUm43MHRlZExrcXM0RzR1?=
 =?utf-8?B?blVXN2lOdm5MWHE0Q3FhVUg0SVFidHE3QWd3bUNFc0lheEJTSVNZZ0VtRDJ1?=
 =?utf-8?B?QmVyaGhyeFppM1JnVk1kMHRKRjZEVENzemN1RGk5MVV1MVNCYS9GQT09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-b8KyIkqEXEcxRNS1lko7"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR02MB8434.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f12e344-f29d-4e14-2c90-08df208dffb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 14:03:56.1848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ro80hDT2u/g1v6Zgb0C1Go9r/1tGWxV35gUk9Bkb/adW3cnTUYFpnAL7uUJYGsm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB8965

--=-b8KyIkqEXEcxRNS1lko7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thanks for going through the patches.

On Fri, 2026-10-02 at 16:18 +0300, Andy Shevchenko wrote:
> On Fri, Oct 02, 2026 at 01:54:30PM +0200, Kanak Shilledar wrote:
> > Expose IIO_CHAN_INFO_CALIBBIAS on the accelerometer channels. The
> > registers are stored in MREG1. The calibration bias is written to
> > OFFSET_USER4 to OFFSET_USER8 registers in MREG1. Reject the out of
> > limit calibbias values instead of clamping it.
> >=20
> > Note: The accelerometer functionality is tested with Invensense,
> > ICM42370-P development board.
>=20
> ...
>=20
> > +	case IIO_MOD_X:
> > +	case IIO_MOD_Z:
> > +		offset =3D sign_extend32(((lo_val & 0xF0) << 4) |
> > hi_val, 11);
> > +		break;
> > +	case IIO_MOD_Y:
> > +		offset =3D sign_extend32(((hi_val & 0x0F) << 8) |
> > lo_val, 11);
> > +		break;
>=20
> Why do we have hi/lo and not proper __le16 or __be16 type for that to
> begin
> with?

The reason for having hi/lo is because the actual offset values are
split between two registers, as described in the section 16.33 to
section 16.37 of the datasheet [1].

MREG1 register     Contents
--------------     --------------------------------
OFFSET_USER4       X[11:8] | other bits
OFFSET_USER5       X[7:0]

OFFSET_USER6       Y[7:0]
OFFSET_USER7       Z[11:8] | Y[11:8]

OFFSET_USER8       Z[7:0]

> ...
>=20
> > +	val64 =3D (s64)offset * 5LL * 9806650LL;
> > +	/* For rounding, add + or - divisor (10000) divided by 2
> > */
> > +	if (val64 >=3D 0)
> > +		val64 +=3D 10000LL / 2LL;
> > +	else
> > +		val64 -=3D 10000LL / 2LL;
> > +
> > +	bias =3D div_s64(val64, 10000L);
>=20
> We have DIV_S64_ROUND_CLOSEST().

I will replace it with the suggested one.


> ...
>=20
> Overall, the feeling is that this is cumbersome change and may be
> split to
> smaller and more isolated logical updates.

Do you have any advice on how to split this patch series?

Thanks and Regards,
Kanak Shilledar

[1] https://www.lcsc.com/product-detail/C5129967.html

--=-b8KyIkqEXEcxRNS1lko7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTOMrdbv2P+LZwbQtLEY9j7t8KaZwUCar+5ygAKCRDEY9j7t8Ka
Z1qzAQCWZFLzumDd5o1T/ZtKAUfWA7FTwvDLlBHMKLtSYL3oWwD+Mx0PTtCPAXt4
CPTUEDLwVwBClX+UF3nhxPnfhHIZiAU=
=HvKB
-----END PGP SIGNATURE-----

--=-b8KyIkqEXEcxRNS1lko7--
