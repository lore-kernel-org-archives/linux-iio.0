Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011070.outbound.protection.outlook.com [40.107.130.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A04A843F;
	Wed, 16 Sep 2026 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551463; cv=fail; b=ltRAtiUjI5jDzMcXHKbrtDk+v2cY0IDkYUITQN+qp1XalHO0U89gg1BiyQ64VpAw8qHCkuEFvFADB9nvlyP9XpvAXK84AHskrpGcvN4CuLUnCE+5aIcI4w9GSGK1SYZi425aEd7q+6UfC7ulAJw9Q8BQAVQ+QVKSt45V4ZU+SpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551463; c=relaxed/simple;
	bh=ydPdMFXntLRyiKdR1j9GoB4q/sMlpW8PMdMFspaqXrc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i5Sefv67w8ZQDwnNV2tMXSIuQA27YTKbAqOVrlggLafQeJfWmEhhIsHP2NRd0vDZ2Ph9htZDSajYkOHnW5EAU2kSxrUjpjq47wI/P98Q4GW6RP05n5t/pVClu3RIVtiJpcRJV54g5qjLRLJJ+9Jkx6t9NzcCmuEhxMk1N7DMLww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=eC8bKX6/; arc=fail smtp.client-ip=40.107.130.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="eC8bKX6/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiFWFXKfI8ttvISdtKqliYx9iz6CW6e/VLsjVEi3f2ytnfr+jkQI3wIUmiZ3+Wuag3AV86sOFjjdBC2WwmjHzwxZ83FexSd9e8YbRoR5mNkaQQRZL6PEh1HNrOqrOG/MPC4U/KMRDQGIq3kUdcZu3ratrNua1lobUtlyjfduonqVpAFUjCgNLe6tlJSjlCAOUfRa9a9X6e52nOC9KIcFcaEx4xtKoQlfNuuiM5NX+HKF4yVq3HWnbEMnev4t4oIyhCSDc64vvmcYFBpwFpldxY7UHOLN2m6sf+TuWCh+4ceEk5hb4PceXK3tNh2uIbrGkVIFAZmZ3dSKjKsaHgwZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydPdMFXntLRyiKdR1j9GoB4q/sMlpW8PMdMFspaqXrc=;
 b=Io0/PPLeWTZVsrwhSLiT0jd4uRJPqazntHvuyfNqWSJoNsZUUOD6Bxwwfry0uq+20YJfZHzGtSMnhJQbodmltZWKOOLVZAXJypTRVnzi4OGaVfEUne/jdLwF8vaShB3VJOuSSo5rRe1e55iekPzmeDxp9OrgGQcogx1kPw4xaJVGVxRI8SEnwnOSVUlUJHI6UKQcH86kvNLIVbWbo2rv32B/57KI4FQGaJsIlk9//iLNBS4tWHs/w+Qn9m5//aN7yh0nIHvoAapBUhcdP2cfJvZGRKZfLtwWTm9PceTXz1mEEUvKIlvpcUtzlTjIbtx2raak3UlH5fp8M+U1OSUB0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydPdMFXntLRyiKdR1j9GoB4q/sMlpW8PMdMFspaqXrc=;
 b=eC8bKX6/9slNRm81p4BgaJ8aGs2MSlIHfryIwPYlaoaspPovYmR0w/dO7rowlPeCSBN/FtR3H+MkbDj+J3PucLxCxe6/LvdUqvUYgImazq9hKcSHl692/HgakG55qJNhvkJbKGH6dNL2PO2bWTVID5+dtgVGxUTsXAchQpt7Zk4=
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 (2603:10a6:10:43a::19) by AMBPR02MB131711.eurprd02.prod.outlook.com
 (2603:10a6:20b:78d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 09:37:32 +0000
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff]) by DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff%5]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 09:37:32 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"joshua.crofts1@gmail.com" <joshua.crofts1@gmail.com>, Henrik Grimler
	<Henrik.Grimler@axis.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"jean-baptiste.maneyrol@tdk.com" <jean-baptiste.maneyrol@tdk.com>,
	"robh@kernel.org" <robh@kernel.org>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>, "andy@kernel.org" <andy@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Kernel <Kernel@axis.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 7/8] iio: imu: inv_icm42607: Add accelerometer
 calibbias support
Thread-Topic: [PATCH v3 7/8] iio: imu: inv_icm42607: Add accelerometer
 calibbias support
Thread-Index: AQHdOh88BMzhlSng1EGhR8lSUpATibbCY36AgA6mQIA=
Date: Wed, 16 Sep 2026 09:37:32 +0000
Message-ID: <b58448efafcd27ceb2c924139ea97201b349b534.camel@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
	 <20260901-b4-inv_icm42370p-v3-7-77cc31642115@axis.com>
	 <178874609182.3402141.6437933635539106261.b4-review@b4>
In-Reply-To: <178874609182.3402141.6437933635539106261.b4-review@b4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR0202MB9129:EE_|AMBPR02MB131711:EE_
x-ms-office365-filtering-correlation-id: ada5fcdd-f2b2-40a4-1da6-08df13d62231
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|6049299003|1800799024|38070700021|3613699012|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003|4053099003;
x-microsoft-antispam-message-info:
 Cs0ISZTT0foD5T1wscJO0ujPwIN9KHcTggFDGfAJcVqJ40dMSuawaLLY7yh638K4JsnKJ7G3V70+z9iJmojQD4NUmHOJ/b1hH5xtOWfndzLQa922uRlGbtyNNZMrUFShosvNuGoixKv+4eChOHbqqjZEV+JaKdJhs+VSIlGADFk8QtG/1jqfEPENMZDkywy/OFlm+3K20pc+d2Ws38h5jUchMcN5HRVsIpFDlpui5FTonlt3khWXXrWHqn3QpTzsqWb5pdq//w0XIKuKpWTS5bVYVJv311BWQrejUN8lu59KW8saVncT1kPpoyaOS9Hc6CbOr4LUqBXxGQ4fVZ+5XTfbgcnVOoU6Pgbgas4xMn3tPAL93x9EPs+W6c0hPlllswaRJxxz6AcoL+hinLh2m8iF3AaRy6SSQScKkD2ywFcqruccl0MTr6La9hXZu5YJYLZlMppex2mI7H6E6qowtU3IQiL/AcJL87bkcnc8r+3zHiwTqgOA6zmrZAxQjIbkqdLAmlf0IXyfGaoUEy9/FmH8CNV3lwrhUi8DfT0jAlMhY/Fa0Wj8cOJRgUt3R/om99qsezb16RR2/T8/OiQG0NoAajBuXi0WhDKAZu9M5QDaHfjmHeJXFOXaNOkJvzmgFNpH0LY01xO3j1UwIkZRNWp8CS0unHdRrE9MJwQimgdCnRzlchiYyN5n4v5aFNGwEazSuYJjML/Y9MO76plm/Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0202MB9129.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(6049299003)(1800799024)(38070700021)(3613699012)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bUZ5SDhxODBEYnVub1poSm1Jb2M0S3hOS2I4algwSUU5bFcwdWJoTmN6N1Nj?=
 =?utf-8?B?SnJqUVhjVExYejhsMXIyQ2pJcmIyUjVxUGU5MnE2bGpYRVRIMXNEMFhYeHJt?=
 =?utf-8?B?YnRBd25oTUpZNUNzd1lQR2J0SHNkQXA5TGNNWnA0WjJqNEVLMjAvM3M3QnFB?=
 =?utf-8?B?dExxWk9aV3VJSGtOWk1aUjRHcGpEYXpkQVJMOEMwRklqdmhpRHFrc0hJUmc5?=
 =?utf-8?B?TEJsN1lWTm5KVGcvVWp2Nk1RS2FxMHhBa0xYWEg4bHZXb2Myc1U1ckowK3FM?=
 =?utf-8?B?QTdlNVZpelhIQjNweVVDclQrQklMRXlvZmNmaDlEckR1d1dNN3pHSnlCS3Nz?=
 =?utf-8?B?dEJxYktBR3NLUzBDMnRNL1o0K29KZzVrdXdpdDVTYkVHOEVodGNLOTNCOWdD?=
 =?utf-8?B?VnlaZXpXZUdwcWZ6MjVheW1lT3pvOFIvMjUybnVLYlFnU2Z1VXFYM1RuMExh?=
 =?utf-8?B?QlVRa0ovREhwbG5GRUk5bzd2Tm9ZSlhDdjRlMys4MzgycUxYOHIzWDQvWTN0?=
 =?utf-8?B?QmQ0ZXlnamg3WUVXNmZ0QkFGNFJrN3RVUGlkelQvSXhFWm4xMmg3V3l1ZUZu?=
 =?utf-8?B?dWR4YzdtUEhuUnV6MUxZR3hrTWVpeWRBaTFjZmNpZjA5NWw5TkZmc2xoZjBE?=
 =?utf-8?B?TzNpUWlPWkZZc3Q1OG9pczYwQUx6a05NaGtPMVgwZmZLY09icnRRanM0RzA3?=
 =?utf-8?B?d0dCM0U1aUNmS0JwMm5tRjJXRExVQWtWbGVwTmFub2NDVStBakxOQkV5bXJR?=
 =?utf-8?B?bDdFNXNOV1c2d01JT0h4SGtVTTBhQm90aDd0SWtaZFZtWUdvMmxiNTlvaVhm?=
 =?utf-8?B?VlNQOGhZZzNlOXFPTW1MMWpRd0tQTDNicit4amtSQkM1aVl5aUYvR3dpTWJi?=
 =?utf-8?B?L2NBSUYwaStvSXdEVlJlUWFkaW41S3ZOdXY0TDJHQ1NrUkRpbzZRdWJFRDVO?=
 =?utf-8?B?Yk9OcURhcTNlT0xTaFVsUk1rdW0yRlcxUWdGbXVPZHRVb3VIVEl3alIvL09u?=
 =?utf-8?B?OXRORzZqQnROWDJZSUpBbHVtVjAzRWNyck5aV0pGUUV6K2xiTXlnSmJXOVNO?=
 =?utf-8?B?OHE2Y1NYMHNKVkptYVYrakZpQU1CZ0huMWZlSktHQ0ZyZnBvTzcwNWZnbllU?=
 =?utf-8?B?bHA5YkFyL1prNmJNMnFjcWdrTmhTdG9VNG9UemNpZVFIdDVJUXZwWXMwV1c0?=
 =?utf-8?B?dmNRUjdiMzlpVW94cXJDaHBLUldOdUpyV2lEYTBMZzZ0ZUJZT2huSlBrd3dO?=
 =?utf-8?B?cG14ZHVtN3oreTFmeE1PRjhTWHBwNEROeVJkM0dLS1JvYzMxQ2pYSENnZmpQ?=
 =?utf-8?B?UjFsWG8zdnlNdVNOTzNYRUxGNi9WUXU5cHE1QVlxMVVZeUtnRDI4M2JHNmtr?=
 =?utf-8?B?aVVvb1pENnExQndOYWpoK3EyRkJkQnF0ZDkzSUpYRlkvL2Qrd2N6ZHc5aTVK?=
 =?utf-8?B?MWJkK1A4YnVyU1NDdUxNakFVdk5uQ2M4Vk5sK1Y2VTdQemtBcFZLS2swZGtq?=
 =?utf-8?B?S0sxWUZmdUZUYXVjZjlBUitXVVUrdUVjK09EbEs1d21JQkFJbDlCTmJ5TjhI?=
 =?utf-8?B?VkcvZ2NOU096RGVYaGdJTXVBTlc2RktlTUM3a2RlbDV1VDBmTngyYnRsbXpl?=
 =?utf-8?B?R2VDWWQ2cS9pb0dOR2hhVnY4TzRwVU9Vbk9BQU5XK1ZOWlNKUjllclh2blBj?=
 =?utf-8?B?RW9ra2tmSk9ReW1JQ3kxWWhjNTZNNjFMVUIyKzQ2bUNlOTBjZCtWRjc0dWRZ?=
 =?utf-8?B?dHZmV294WU9ybjJPeDV5L2JZZDQzZ1JoejJ5Q2F3RjdoUkVESkphNjhVSzZW?=
 =?utf-8?B?NTVuZ3dBN1ZuV3lVci9DbE5SNUNEQ0h3VERZeGpwSFRCcEcrR3J2VDJzOHBh?=
 =?utf-8?B?VUhLUkx3ZDRUbHhiOXpDdno0SkFGUXl1VmtlNUNEdEpjS0VDZ2RpQUNGeXlu?=
 =?utf-8?B?US9vNzZkZ0cxQlc4dTc0OVJNZ1pYQnBjZGs3TjBwckJSaTdmMHJjOHJRdjgv?=
 =?utf-8?B?elU0b1JXb2VZa1ZBa2NjNHBMTE9zYkk2RGZGa0NPM0hUdlNVdzFhalUxQkti?=
 =?utf-8?B?M3kzbGpoQTlTcGpLekpMb1paMzlOeU9lb2JhSkliSFpKTVlXbTh5dWNCVEJl?=
 =?utf-8?B?M1hjZGQ5ZVdpRGJlVWp1Q2p5NGpnemJNek13dVRzeEpSUDE0SEhHSzJNQkw0?=
 =?utf-8?B?ZlJvYWNrWW4zT0tSaGUwaTdpRzNXRmtGYVNpanNwM3FMWXZoSjVVamFnSzQv?=
 =?utf-8?B?QnNYM3FJbXZwbXowZ24ybm42MDlzNEpGRUcrdGh2NlRZYVFRMlJxOS9oalo5?=
 =?utf-8?B?RnRTTGdtcktYekVGOU9Pc3BycHFYUTV1K240UVNHd2M2d1ljQ0hHZz09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-qzSuFjs5Ohro8rco8Vti"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0202MB9129.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada5fcdd-f2b2-40a4-1da6-08df13d62231
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 09:37:32.7310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PhB5kW+lVXk/gzTa5FWjEBSUaRHzlqW/WGusjjWTyZijX+nlrmYjj9BhdX+JL42H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR02MB131711

--=-qzSuFjs5Ohro8rco8Vti
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Mon, 2026-09-07 at 02:54 +0100, Jonathan Cameron wrote:
> > Expose IIO_CHAN_INFO_CALIBBIAS on the accelerometer channels. The
> > registers are stored in MREG1, which can be accessed by the
> > mreg_read
> > and mreg_write routines. The calibration bias is written to
> > OFFSET_USER4
> > to OFFSET_USER8 registers in MREG1.
> >=20
> > Note: The accelerometer functionality is tested with Invensense,
> > ICM42370-P development board.
> >=20
> > Datasheet:
> > https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> > Datasheet: https://www.lcsc.com/product-detail/C5129967.html
> > Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
>=20
> Various things inline.
>=20
> Thanks
>=20
> Jonathan

I will fix these issues.
Thanks and Regards,
Kanak Shilledar

--=-qzSuFjs5Ohro8rco8Vti
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTOMrdbv2P+LZwbQtLEY9j7t8KaZwUCaqpjWwAKCRDEY9j7t8Ka
Z4PpAP9PIxvrVo74bCZWv1izqREPF+P48mu5Gf7xFeCSp7Z4oQEA1idglH++t+kt
tj29KxEt7mxv2l9kSnSFvD973ZLcBwY=
=MZ/1
-----END PGP SIGNATURE-----

--=-qzSuFjs5Ohro8rco8Vti--
