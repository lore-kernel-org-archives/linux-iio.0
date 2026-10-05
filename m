Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784154BB5A8;
	Mon,  5 Oct 2026 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212579; cv=fail; b=Wa5YIP9ItHVLYqjfUpYUvlwWHrTvCH+bummR0KgSOIhgaPfpvbeVTZBPztaiEeeJvtMNZCIca3jsbVCLFgIoTq5vYeMvwffJPX/AxM2bC9WLom5JEgPmd3P5z0fvtITkExezW2uHP1dJSoVyJJn1dk8RkjS+q31jZbOTI7Mdh0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212579; c=relaxed/simple;
	bh=9WAeR9NY6zHuY+aqpG63QzHyt9kXdHKjzC0uqatlkSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YiV2g3Jq/25c3uJiEOA5S1C6aoqCpw0iqQE3iDUMYwbPo4peA5Cwzm8YWQ5ITK7/7DNOnxsy4fUgaTMAKPvrd8nfYmfRZVvCYbPGeDaAyMzJRiee1RIRwW8F5KVqjBZOIOTwAQDZmbwC3GrBJI4DT6lfW0iHWKiZUn+W87TOmnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=d690+N3w; arc=fail smtp.client-ip=52.101.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="d690+N3w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYVJXLZVLKPCrE+QolcWfkvDFhdd7BXjkLvc5VIZHz5El/Lc0WEpgq+2FVuOjKSMefghMlXClxji9U2z/GJEjwPrM5rmGBy7c3TeYPzd89bzDQvmkANEKEPedbjj0m3Sps9+AeZWUMD0chcMsdUOvI3CH8X0g+HJ6nR+YMS5SabY8ThlnRLzzLnPZGpJY2WFYVA3AZeMjxAdPXFmqse6R3WprYa7KT+O3mW4A5k3uyD9fcg3WYOM6b96mUaJTkZWgrP++4848smgh+9fZw2ydfUu2kHc8ZO1CLDleksC+z1o3m6vKkZUVHFaEeDvBJYsZHdFwqOu3VC64uPydTQ+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/bAtXn8yfdchV/cL2a9YSKk0oE+h8APnUrqvd5bRtE=;
 b=A2UWGwAEXN10VYgfZ83AM3/AO1+re5u2XxEpIcJtG3+6UnvL2R6WpjN4uCMuzmnYBej7nKW1581QcqY8kv1QL3rP51+8UYoA5TRPe1Y0heiEuJcgnntnJBdwd9XZK79DUSxpV6adQpUf9lDm9iu2klL+jiAX2M2XBlEtd1IEZt/xRvygWZ2lWtvjLzc19BKjumk5ZGtRNA0lUQ9YIgxM+Ty8Xa8y20TBC3M7GN2FV6+wv+1o1+D2HIr+GEPCAPKRISBlnMEBaz7dBupzyHHUAQGcxgUBOxYggHEFNn4iJwV/6tINkeai/BjMxl6tcVbqxQ+KrEYqWHW9RnG+qvMIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/bAtXn8yfdchV/cL2a9YSKk0oE+h8APnUrqvd5bRtE=;
 b=d690+N3wTkFf/GVR+er+zEulfHouw8LtMeN3hBlp11r+z+NBJxUjfklzNoxGZj0MpqWdjlujTWvRB/P7MLSqDLTgR2UdVz7Do7m7e7vqT3QeiLt+YdJu7DXQD1336HodGParbnRSboAZSnVKkpik6PheC+wreP6uZ1xogzszO/8=
Received: from GV2PR02MB8434.eurprd02.prod.outlook.com (2603:10a6:150:ab::8)
 by DBAPR02MB6021.eurprd02.prod.outlook.com (2603:10a6:10:18d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 15:02:54 +0000
Received: from GV2PR02MB8434.eurprd02.prod.outlook.com
 ([fe80::a2fa:a7a3:b6ad:9e4d]) by GV2PR02MB8434.eurprd02.prod.outlook.com
 ([fe80::a2fa:a7a3:b6ad:9e4d%5]) with mapi id 15.21.0451.026; Mon, 5 Oct 2026
 15:02:53 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
CC: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "andy@kernel.org" <andy@kernel.org>, Kernel
	<Kernel@axis.com>, "macromorgan@hotmail.com" <macromorgan@hotmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joshua.crofts1@gmail.com"
	<joshua.crofts1@gmail.com>, "jean-baptiste.maneyrol@tdk.com"
	<jean-baptiste.maneyrol@tdk.com>, "dlechner@baylibre.com"
	<dlechner@baylibre.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>, "jic23@kernel.org"
	<jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Henrik Grimler <Henrik.Grimler@axis.com>
Subject: Re: [PATCH v5 5/6] iio: imu: inv_icm42607: Implement MREGx register
 access
Thread-Topic: [PATCH v5 5/6] iio: imu: inv_icm42607: Implement MREGx register
 access
Thread-Index: AQHdUmTXDYhkjTmAnE2JhwSJk6qTNrbqOnUAgAAUloCAAZyBAIADJNmA
Date: Mon, 5 Oct 2026 15:02:53 +0000
Message-ID: <b9f2af54922a988483a6188f0119ec5622cf4f6d.camel@axis.com>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
	 <20261002-b4-inv_icm42370p-v5-5-c65281b745c9@axis.com>
	 <ar-tpjenoxMloYq1@ashevche-desk.local>
	 <afde7beb4019d8090d3df30bb4e0a1b7ca00ad4a.camel@axis.com>
	 <asEY9DHDisqVcQ5D@ashevche-desk.local>
In-Reply-To: <asEY9DHDisqVcQ5D@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR02MB8434:EE_|DBAPR02MB6021:EE_
x-ms-office365-filtering-correlation-id: 5aaa5744-70a2-4c2b-109a-08df22f1bb54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|6049299003|376014|7416014|23010399003|3613699012|38070700021|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|4053099003|4013099003;
x-microsoft-antispam-message-info:
 QkHvhLDFSJg/fszn3bScU5FcE0ECdl6yXzXkgcba/dWNoNJYNzpaJmJr+tQjEWjw2JG8hJAVQVwKPDVUKnSZccioe8XgRrnpUXCbAQBmJXMG6PDeFF+rwVqQPcNU0aGtgqZp/5ebYkQQShUWv5b7O3SRZmsur7i9HHjQrhFkrf1ucm9qVXoqIHMF+xNTvAT8VjwVGZeYeHWnzdf5gzkA5HQxNnUQgZ7yRanzLLPtfBneR00izrvznf27SiZ0xrlgXl0e2wZSExfXTh9Uvli1ibGXX7ET3hMFund+A7uUy0Qwq9JMMK9SksGb7L+1iQA6amUSACoNfNcKSQyxxaT9FjszMPvXcOcNPuOHAR8IBj26y/M+ZaMz9C5c2Yu12kgdTlHn4tTZi9d/wUTJmGwdRcGVIZ5z8vyB09GmkStwKZUa5BapRd2R81Sa/y4egBnrx5y8qoYKJHkoWZpIKUN1ZXE2PS8fbGjOmf+iZ5zhKMKuYOF6/+FQckI1wpCRAZu/AzDQz5sf8v9Eul580o1uiQtl9A5TQW/uzFt73EHZoyhy2gonnTbMERPH+6EgjLx6bxpjraFUeouYcAyZ3CAfBQ801ptWiR4ZHOlXXHB+nmhVur7rh5n09syAISDaiPyDtj84aqY9MVU61k1i+IPid6JsFYjtDPqiF8n7THqLMg7hcTYIoyb22rO8zThGuGLclvztOtahqI6wAqnguhUnEg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR02MB8434.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(6049299003)(376014)(7416014)(23010399003)(3613699012)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(4053099003)(4013099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmErNTI3YjMvaEcxK2JOU1lJV2FiZkkvZ0h4RWFQWlh1eDg2TlpPcTdwd1Ix?=
 =?utf-8?B?N0QrUWNKbjBLTSthdFJNdHZzY1RYekV6VFR5WXhSekxsNi9qcndiUGE3NEQ5?=
 =?utf-8?B?MGFSa2xCVDg2Y1ZoeWdaYmkvYVM1REhwSS9Rc1hrT2U5bk5RaUV0dUQ2c0xC?=
 =?utf-8?B?YU52SEdzczd4UWRDQmhxVHRQMjRzYVNGcWgzWEdrZEYvWEx5RndwcC8rQi9H?=
 =?utf-8?B?NTVkYnBKaE9aVWtzeGhOcm03bFdTTGZRVGpna1lSZ1FwWE00cVBuMWcyaDdY?=
 =?utf-8?B?dWN4Ti9nVGxVbGdOQzNqVjJGbjVVRzZqMjBUYXRxcnc0Q29ybWFZSzBRQloz?=
 =?utf-8?B?TDZuZmJ6WGVETzFmdGN5eVp4M2RtS0llUm9SVTlFVE1Jc3dIdHErK3NBbTE0?=
 =?utf-8?B?ajRhZ29DM3U3S3NNT3VRaUNsUHVaVkppSWZRMEJRbHNHeEdnbm9PdC9ETEZP?=
 =?utf-8?B?Y2FOcktPRklpb3FJaVg3VllreWhzTWc0QTE3UWVuNE0wUFJNbzlmSllZOTND?=
 =?utf-8?B?dWdzOHZxK1B6SUhXS2VIOHZTL0s3ZzJDL1BWR21LeE81OW5GcW9EemU1R245?=
 =?utf-8?B?R2htdVNSUmUxTERYT3R3bWZFaW1LejBaR1FKV2crYkczZTZtYmt3a3l5MkIr?=
 =?utf-8?B?ZG1nQUdna0N3NWFiejVUNkVXSHJxalpHc0ZGZ05NV0FGNXRBQ2hNRkwyZGIz?=
 =?utf-8?B?TVQ0K0xmcVZ2a1UxS3NyemxkVEZyUUF0NGE3bG5FQ1M4THpwWHVWUE1UaEVS?=
 =?utf-8?B?S2haL1VKRmVlbUdybWhXWUxVYVUxWllNTlc4YnlIV01aOHZkamNoNTBMcEIz?=
 =?utf-8?B?NkE5RTBOK1RPUmhxRGUvL1NkdXptL1dncUZ0RUJYZTZJUWdreTBObndlZWdE?=
 =?utf-8?B?TkRzK2tSVUdDNndHRTFaYmZVYXRDNytWYVBCL3dkQ1BhREJJdzVaNDFZNlVC?=
 =?utf-8?B?bGpFYUZjUVhVYkZIZ3hCZmpqQkUyS2ozN3NsNkpxOHJuRXRxQUxTVVhpYXFq?=
 =?utf-8?B?STAxTXJNbGw2bFdQVVVYZkk1TVlJdGZ6Rjg4cTRERllxelJJbDZmcUxRdjBn?=
 =?utf-8?B?VU5jeWh2YytTcXpNWHFNS3Q3RlRmd0xmcVBVTUFObVVxZTFkRUM4WFh3S0NP?=
 =?utf-8?B?QzRsYjBzbUdKKy84VGM5RVVIVFF1L2k5K3paaUFhM3ZiQ0N4dUlpNkJoSGx5?=
 =?utf-8?B?ek8yS3NHaGFidFg5Qi9wSkhmaGhqS1ptNTRzYkROZnk2czJFaDJDclZXSmps?=
 =?utf-8?B?Ykl6eStDVjNpbmNINFpxMXRHUUFGc0VrRnY1RSs1ZWxvZmxBamY4WDUyalM0?=
 =?utf-8?B?M2NXaFFVVEYzUUYxdlZxSEdRM2NaTXlQbTY1a2pxVmdFM2kxcGQyM0NsRnVR?=
 =?utf-8?B?Q1JXVzU0OWlEaG0yNkNmRVVXN2pXOUhINEVINlNwNW5UdkdXaE85V0FIQWRw?=
 =?utf-8?B?VjZKVTR0VytaRkl2TnhrRkZtSkF5bDhNRkFtc1ZTQ0FUWGpucEQwVnYrV2Fv?=
 =?utf-8?B?NDBZcmFsSmR3ZEpKdmNlNlZIK1BRbFNzczl4R2ZEeUJUaWFQL2s3eDM4WkpR?=
 =?utf-8?B?YTh2NWU5c3duakk5OVQxTEpxT0E2MUFsU3hKNS9RODJ2eGJpalpONU1tbHNh?=
 =?utf-8?B?Zjhhb0s0V2M4MDRralpOWkxJbVloWGlneTg1VXgvNFRCN1dIY1E4bm5mcGt0?=
 =?utf-8?B?YTc1UVpEWDhYNTVmczBkOVdmZ0VBNjEvSEdxZ3Zaa3VtcGl4S09IOW1yTUpR?=
 =?utf-8?B?aEdPbnVoNDRvOFliUnE5MWh6WjMwUEVJNncxVXFvMXUvNmoreWhibFkxS25n?=
 =?utf-8?B?WCthajhzbjhoYnhKMWRMTmVqNUtTMnFqVnphenMvRzFrdk1xc2ErUkI4UGZa?=
 =?utf-8?B?RG8wODZxSEtNZkxlMzFKK1Q5M3RIdy9scVNiTlR2bWJiSmF0alI4dTBXSjJD?=
 =?utf-8?B?bFlyYkhyWUhTQVdZd3h4T1VqOER6QldLaWZGZzM1VWx3ekNXZ0piclRDSmxj?=
 =?utf-8?B?akVva1JXRWVBNlRMMHVBZ0lUZnZPRjg0ZEVrQWszSk9iNTVwNklBek9JSS96?=
 =?utf-8?B?aGNaMkJvOUJFR0NsWmRiYjEyWjVWbW41ZzFhR2JqQUVraWhQT1k4RHJhaUdm?=
 =?utf-8?B?MzNKTUc1b2hEZldHMjNXMDQ2Z2FtbTlodkRVNHVVYldzSnRHL0p3dG5oQmdt?=
 =?utf-8?B?eXFCSm9CRDRpcjRNdUU5NWRyb0Q1WkJVWmVVbXdlRUxsZ0FBOEdLdjZ3MDdm?=
 =?utf-8?B?MHJrQ1g1Y0FjTTZKR2pzY2RmVnpLMmFXSENrM29JellxTCtCeVNaWWRheFJw?=
 =?utf-8?B?amhqbjlOZm1nWmNjNmtWN2JvRWJsYXlPQTFZVnFDMTVjMUZSQUYwUT09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-XM3erh92RLIAuvrENta7"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR02MB8434.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aaa5744-70a2-4c2b-109a-08df22f1bb54
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 15:02:53.4605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsoScU6bfOjnu5T/UmOejJ/pcRDfT4FAFzjbA/8ltBRrFPXTllMJew5sojcmTgu4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6021

--=-XM3erh92RLIAuvrENta7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


Hi Andy,
On Sat, 2026-10-03 at 18:02 +0300, andriy.shevchenko@intel.com wrote:
> On Fri, Oct 02, 2026 at 02:25:48PM +0000, Kanak Shilledar wrote:
>=20
> > On Fri, 2026-10-02 at 16:12 +0300, Andy Shevchenko wrote:
> > > On Fri, Oct 02, 2026 at 01:54:29PM +0200, Kanak Shilledar wrote:
>=20
> ...
>=20
> > > > +static int inv_icm42607_mreg_read(struct regmap *map, unsigned
> > > > int
> > > > reg,
> > > > +				=C2=A0 u8 *data, size_t count)
> > > > +{
> > > > +	unsigned int val;
> > > > +	bool idle_set;
> > > >=20
...
> > > > +
> > > > +	return ret;
> > > > =C2=A0}
>=20
> ...
>=20
> > > > +static const struct regmap_config inv_icm42607_regmap_config =3D
> > > > {
> > > > +	.reg_bits =3D 8,
> > > > +	.val_bits =3D 8,
> > >=20
> > > No cache? Why?
> > As the virtual regmap config has some caching for USER BANK 0
> > registers
> > only. The indirect banks doesn't support caching [1].
>=20
> This is strange. You mean they are volatile by definition (HW)?
> Otherwise if it's just a software issue, it can still be done,
> for regcache there is no difference if the offset is real or paged.

Sorry, I was not very clear in the explanation about caches. Only some
specific MREGx registers are volatile and I am not using those yet. I
have removed the MREGx registers from the _is_volatile_reg function.

In this 8-bit transport regmap I am not using any caching because the
16-bit virtual regmap (in _core.c) already knows all the registers
(readable/writeable/volatile) and also contains a cache. Everything
which reaches the transport regmap is either a write or read which was
missed in the virtual cache or an access to the bank switching
registers which should always reach the hardware. I tried adding
REGCACHE_MAPLE in the transport regmap, but accessing registers in
MREG1 then timed out due to stale cached values.

> > >=20
> > [1] Datasheet: https://www.lcsc.com/product-detail/C5129967.html

Thanks and Regards,
Kanak Shilledar

--=-XM3erh92RLIAuvrENta7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTOMrdbv2P+LZwbQtLEY9j7t8KaZwUCasO8GwAKCRDEY9j7t8Ka
Z6bUAP9KosDIvgBW+cAT+z3UnmLdTLaZKTr0o/rLuuQwDny33gEAyaHuOVXpXK6/
Qa6t907KPTcePARzH35XeRk4/eHTdwI=
=q/2n
-----END PGP SIGNATURE-----

--=-XM3erh92RLIAuvrENta7--
