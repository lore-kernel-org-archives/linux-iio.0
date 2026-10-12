Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013012.outbound.protection.outlook.com [52.101.72.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75CA3ACA5C;
	Mon, 12 Oct 2026 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791801791; cv=fail; b=Mxg2iTHhZxV9pb9XaONIc0DwCVgabFaTNK/qwshlKOYqAGg2IXGXEsJW4AbqSPPuEAJLZI2LczY9cUiKHcrvPRbk+cc/AQgmR5bvliojvssAofs3rFHNszBWkPuJQAhtu07RMeGgAvATM8UxRe+r8VZnwaqPVHgGGDWR9lQyw1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791801791; c=relaxed/simple;
	bh=PuSNO6AXk1np4exYuHjWcr453ur5GXWEVeV9JGf167k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZD5ukjjPBjLLogrugHqY3L2C1KRjuoUe2jhXuvx6tg4rtK4jxTy1HvZHWl4e03vj2daoiovMTmjyiZABB5vE7mHeO94N8d06Qx22g20Wx0P53vlDIPbtyTPZy1gw+pUokQ3n2C7TNr1LFvxdeXp9Y+DeTgRM+2cKcD0hmHasPqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=n5YAxpOc; arc=fail smtp.client-ip=52.101.72.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="n5YAxpOc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBl7VTrXSXO55P0TgZlHNfOcsCxY8QNvZvQfxHtb8Nx3GYOhleSSBzcsSQDsOGRD9mOdjYOqeDQrxTf68NpPHYuZcEzdW+K8Q9fl2YJYnt3zvehGesa8blDlIFTJFiM3f8AYJOibToLm8OrdtxCy2CGXFnR+nN0ujicy+5ytL9xgryVPZ5cCjq0a2wSOIuiGe09Zdj81pED8XyX1iupfX6Atxdtb9Qfqry1zSa1vWL2dR4V3OWXcUwq38SCh69h70UWAxEwZ3qlhCUjjztS1E/F6Rc/FZeoj/LdyHTITIVr3KH2MtQoAaqVJFRmkb8aH+TiIjMZpg1aClkQkFiJmpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuSNO6AXk1np4exYuHjWcr453ur5GXWEVeV9JGf167k=;
 b=kv0tA7KM6/PHoFh4Fe+oKwHaNi2vl5g5DuM2s1vIIXcBPuUTMsRU64Jk7YYQp6NZ9/BkjG3wjVZ4AdGKfAe+7BJHd0opcOi2J98TvjshuvtBxshKfvzwLRN3uZr5xJE6DthoDtBx/STMj5uPIlYf7Goo31UQ3jEsWPnSYGtJX9fO9O1fsEFaCYsRn4Xed0UPUnm4Nhrg6uCsGo5adKgIn2n2eq6vNUFLJtZP8oWtZH+HFgQ8BMikUjFwJacZkdzvxGzYykIrzD61aSrAcVKo6q5ssec38Hs9DVNCf+Ln8ZjP0vCgEaxFWKIrGyj3g4pPRRlr6grcM2p90ToY9cyQIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuSNO6AXk1np4exYuHjWcr453ur5GXWEVeV9JGf167k=;
 b=n5YAxpOch/+Q5WCjtNQIVJK9fj+nKhzK86vfqSf0be5KNUQHJtRAYPtIYnut2KTeNg6I6b1EcC2CizstS5WHLSvKwS0qG1KtGe/OW/VFqHvi6icgTWucuigZV5Qq02W8n5BZosA/tECyvZHciv29xR5gxa5C4zjbi2UG6/vJ5gU=
Received: from AM0PR02MB5281.eurprd02.prod.outlook.com (2603:10a6:208:101::12)
 by GV2PR02MB10379.eurprd02.prod.outlook.com (2603:10a6:150:b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Mon, 12 Oct
 2026 10:43:03 +0000
Received: from AM0PR02MB5281.eurprd02.prod.outlook.com
 ([fe80::bdd1:15c4:7979:b16f]) by AM0PR02MB5281.eurprd02.prod.outlook.com
 ([fe80::bdd1:15c4:7979:b16f%6]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 10:43:03 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: Kanak Shilledar <Kanak.Shilledar@axis.com>, "krzk@kernel.org"
	<krzk@kernel.org>
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
Subject: Re: [PATCH v6 1/6] dt-bindings: iio: imu: icm42600: Add ICM-42670-P
Thread-Topic: [PATCH v6 1/6] dt-bindings: iio: imu: icm42600: Add ICM-42670-P
Thread-Index: AQHdV/g5mhUaUBhwpEy4+0UjMNacsbb5n9OAgAAdGoA=
Date: Mon, 12 Oct 2026 10:43:03 +0000
Message-ID: <fd4181c7e2f48e3c64530340ae1a02adde1f342e.camel@axis.com>
References: <20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com>
	 <20261009-b4-inv_icm42370p-v6-1-e53884f185ff@axis.com>
	 <20261012-adventurous-corgi-of-fury-01219b@quoll>
In-Reply-To: <20261012-adventurous-corgi-of-fury-01219b@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB5281:EE_|GV2PR02MB10379:EE_
x-ms-office365-filtering-correlation-id: e383779d-f969-42da-3609-08df284d97c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|6049299003|23010399003|376014|366016|1800799024|5023799004|11063799006|38070700021|56012099006|4143699003|10067099003|18002099003|22082099003|4053099003;
x-microsoft-antispam-message-info:
 b2FUPi/XY0b8BYH8x5KizzGtjRc9GPkF1HBB3eNkSRTz7qBKGe8gVjvyOENMVKj6Bv5q60MUpUkzyt2l32U11LWEK6q4ClZ3MlD2M9V2enBrKq8KtSCJGib+7pVCMaHC6fwAIGs0abvVGp6uc/ZgTu+tHFatfG+Zfm68LLctq/GtHa3bv3Z3+xps8q4QJtDlMcasaj3xkiQFdlY0Avv9CMbtxAvNgoBOefdLAHcKmz0AbMyV3Rj8Fg3Vv5IOrb/+GjcIwHtT3Dc7T8Pl9YZAE3wORdMIopTsDbd/MSdrKpiCr4DrfoTKu7N8C2yF1DGTxPouY0SRQTwnBj+uPMGoD+Uqw8N/qCdzQKeR7KxCRUaCpudO7cyiURK/EVHzXSsncNky2LXyuWE29ZxDRp5yD2C54z2w4trPsIKJVWybpGA0eD3Vvs6Sv2Clbucr6RD9fh59jR1U47HSuvMfq8TxLrrPCv/kcre4CWD0B9SYs6Me1Aq8i8O9JhvI9Zd0njcIGMMYtjqTwc9RxSZdSfgPjh+WQ4pncLfxWn4Ol20GUK0PosEaO5wA6S7niT9gr4LMeAPVu5KRqOnNZlOnHIKEktSyunYhL3Wz2h33t8XWaz9w89VdxKK6vGnlifQ57yU43Z9xhXAVRV+HZ2g33ta6sJz9uY8TMhmfNs4XLFiIGOBTkwYgIh+TVZuduPx8XhhRENeZ3sXB20PQlbW86kW9MJaG5R3YcMJD8oef9s3TRDg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5281.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(6049299003)(23010399003)(376014)(366016)(1800799024)(5023799004)(11063799006)(38070700021)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0l3VmZPd0x0bVkxcnRnazlsTHZYNlBXWEg3YXFDOUNOeTJqdm0rNmZvNEc5?=
 =?utf-8?B?ZXRkSVczUC9xMWlrUUo1ZEo4Z0NtNFFDTkZtRjB0VWw0L0toTFBURXFXOEJp?=
 =?utf-8?B?d2VKZWo2bnMweTJrcU9IVXV2RW5ydjF3VTFOQmZkd3hpTWVESy9JcWp4MEhH?=
 =?utf-8?B?TWVLQWVvZmVLVWtuS2Z0RzUrQUl6VW1ESHhVaUI3YlpFZnFOOExZYUpNZ0Jj?=
 =?utf-8?B?Vk1OSWRxajZBZFpKTnZnRWh0dkdhSlY2dVZ2WnNIOVVkU0NZRXVwWEJDdWpt?=
 =?utf-8?B?Z0g1aTRQOGVTSk9yeVdZMWo0YmpDbW82TU0vOFNWelhRalpQMWVnVmFBcTRR?=
 =?utf-8?B?c0JOamFXV0loVUh1U1NTYWdHMWdPdG05NzVmWFg4dFpodUVESmZNcko2RVlZ?=
 =?utf-8?B?SVFzV3U0S2tYZlZZTWNxNmhCbmlVbytwZGRxY040YjQ1ZXFqbUNTMVVIYnU3?=
 =?utf-8?B?cTJVcWxNYU1UcnlHZFcxSG05bW0wKy9YV0FYQmRhSDQ5RG9vY1Eva25Fa1BW?=
 =?utf-8?B?ajdZSkF2U3BnUDcyaWdJdnByR2ZYbUFkQ2cyY1A3eDRuWTZiQktvemE3M2Vw?=
 =?utf-8?B?NFlKYUJWdXN5dkFRb0hiaFZGYzZ4SnRDVkZyWVR4bFNETWVkVU8xd1JKUDIv?=
 =?utf-8?B?R0dnV2VDc0g3SkxoMnFVYzdPVnc3eWVDNER1V0E0bFFtRnR3ODRSWnBEeExk?=
 =?utf-8?B?VE8zWENZZGw4bVNFbEszTlFiMm1aNHlkYVJIZ1QxTG5rRXJUTGppRnV1Y2dv?=
 =?utf-8?B?NVpWZnpKcUpFSVZLTm85K3Y4T2FvVGFLaDBCdmlHR1M0TGpXcm9pNnJYL2ZJ?=
 =?utf-8?B?SmIwYnVvYXd4RVR6U0xJWVpzYlpKeTgwdVlKdlVkT0FqVU1rdkp3N2lKcVUz?=
 =?utf-8?B?SkYrSGdBSWFEalVRbUNTblljNjlVdnFVR05ZeXlPcmExR2F5SkdRdVJSN3VW?=
 =?utf-8?B?a3YycEV5M0xrT3BobU5zNkdqanh6Tzc3S1dNZU9oT2hDcnFUWjJsNFFSeXVW?=
 =?utf-8?B?aEJvT25ZWEszVWdGd09hR1M4M1Z5VU93WXNlVG54NCsxOW84cUsrV1hLcnVM?=
 =?utf-8?B?TnNzeUh3Y3A5VmxrNE8yQktVTG5wbjU3b1FDcCtCOXpYdTZ3VVAvUzlJQU5Q?=
 =?utf-8?B?enVCZHdFUXhIc1hPcTJoeUJxVmdjcm9BRkZ1UndZeERKQmtqbVdXWWxZL3pL?=
 =?utf-8?B?WEdvN1U0ejZzaGgxN3YzR09CTEdoNnVQY1hURUlzd1pTY1RqZXp6ZUc1ZGhh?=
 =?utf-8?B?M1phWmN4cUFwazlVZkpmajhRYWRQK3RYTzU5S0RkaTZaa0wxV3ZFcEk3bUJE?=
 =?utf-8?B?bXdXWGxnN1dBdk82NUhwRUMrbC96UEl5K2pjK2kwWFQ3Tm5WVUdhSENrUUJB?=
 =?utf-8?B?MjRVTEFkYUhOS2IvZy9FMTFEN3dJeVpGcEtCSytBcnR4MkVmNll4MXRPVmtm?=
 =?utf-8?B?K2NreFk3Nk5VV2I1dENRUlQwZTF0NFExVFZYbnRuNHNsNWZHa25jU2V0ZGtU?=
 =?utf-8?B?a3RlN3c2V2poTkw3RDZhVk9EZHYzL1podmJBcXdiMXVVUEhabFgyNHhuN3hs?=
 =?utf-8?B?am55ZDc1RWlxd1ZZcGF2RnE4My9zOEFSSFZFeHlRaVZDVUllNUNoZFhVZExM?=
 =?utf-8?B?TFp3SjE1blFJOGVUSXBuSGRJdU9oSmI2OFIwTXV1c0NycXdDbS9oQUJlNVNS?=
 =?utf-8?B?RnJYVTdaM2hYUjZIbFFHVG9xb1dobCtOcXlUR1A2YTVxZ3JOSDdOUFhoSWhG?=
 =?utf-8?B?SkZCNHVWZi8vSkZYL2ZYdFJqQWg2aEJUTGlTMGs0NlBtbFVEcyt4Y0JDdFJZ?=
 =?utf-8?B?MzVGeCtnRHN1TkMwQll6RW1zUkNXN3pxQWtXc2FVMFBuamtWNkhrWFY2bGU1?=
 =?utf-8?B?T0VGZWErUyt4cHJvT2M4Rng1dnEyOEd2V2xabGl3b1BLRWZxbW4xRmpzSTF0?=
 =?utf-8?B?bTJSK25XY1B0d3YvUEx4YUZDN3hxajZ5djQzMVB4cXZNanVpWFpSRVQ2M2pF?=
 =?utf-8?B?WDdPR0tvckYySU16ZmJXNFVxTGlsRXFzTERlakpLSlpYMisvR0IwZnZYeXRj?=
 =?utf-8?B?ZmRjWGYyOUkxYUFaZncrWm5zUk51dmIzeEpCNW16OXRZb1pDOVpCK0RsVVlX?=
 =?utf-8?B?WmJ3MHdqTW1vWkIva1EzUUQ4SkkxWVg3Z3MrOGxxaldWU05mODJvWlRsOVhH?=
 =?utf-8?B?NHNVd0NzbWNlZFY0akpZcHNESHh5TG1GcXB3WWFURkRIYUZIZm9BWHRDQTlu?=
 =?utf-8?B?ZFNYVUcrZ250OGdyTTZkd2hsSEljN1NaenNMdmxlbGtHblprQk5pc2RaRDJh?=
 =?utf-8?Q?aRyLMjdDL/+pt6hCSj?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-+ahHyJ3WfPigtHnDSqrw"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5281.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e383779d-f969-42da-3609-08df284d97c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 10:43:03.3101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yI7fVfc1W5LSwEVN9kLcOjHsN0AjkG7Grpxo73y8dkgJo6CHzOKtVrPhHsDFfbNY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB10379

--=-+ahHyJ3WfPigtHnDSqrw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzystztof,

On Mon, 2026-10-12 at 10:58 +0200, Krzysztof Kozlowski wrote:
> On Fri, Oct 09, 2026 at 04:12:06PM +0200, Kanak Shilledar wrote:
> > =C2=A0=C2=A0 It has a configurable host interface that supports I3C, I2=
C and
> > SPI serial
> > -=C2=A0 communication, features a 2kB FIFO and 2 programmable interrupt=
s
> > with
> > +=C2=A0 communication, features up to 2.25kB FIFO and 2 programmable
> > interrupts with
> > =C2=A0=C2=A0 ultra-low-power wake-on-motion support to minimize system =
power
> > consumption.
> > =C2=A0
> > =C2=A0=C2=A0 Other industry-leading features include InvenSense on-chip=
 APEX
> > Motion
> > @@ -28,6 +29,7 @@ properties:
> > =C2=A0=C2=A0 compatible:
> > =C2=A0=C2=A0=C2=A0=C2=A0 oneOf:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - invensense,ic=
m42370p
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - invensen=
se,icm42600
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - invensen=
se,icm42602
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - invensen=
se,icm42605
>=20
> Why aren't the interrupts required?

The interrupts are only required if using the device is used in
buffered mode. Which will be added later and the dt-binding will be
updated when the buffer support is added. Currently, the device works
without any interrupts.

Thanks and Regards,
Kanak Shilledar

>=20
> >=20
> > --=20
> > 2.43.0
> >=20


--=-+ahHyJ3WfPigtHnDSqrw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTOMrdbv2P+LZwbQtLEY9j7t8KaZwUCasy5rgAKCRDEY9j7t8Ka
Z2AKAP9NqZ+77NS/956psneU76LRShkqZrxTRIJ0pCxa7WvVEQEA2uoJDEuwMNqI
kk86L2pnxuzeVoDEODnup9wIFJGSNQ8=
=Mzfi
-----END PGP SIGNATURE-----

--=-+ahHyJ3WfPigtHnDSqrw--
