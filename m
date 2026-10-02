Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0C2FE07D;
	Fri,  2 Oct 2026 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951154; cv=fail; b=PG4kKnaE+j/+JZwoqpcYKYeAVI9S9ye94mj9RgGAiDkiYZ/KYd6tV8GK1djQc+a5ht4LERRqI0xmj4ln3lH9aXTvZxR+fDXKyM9lCiikaFwhKOEm86M7jUtsA7s2U3LcwZewbL5skpTW2rzRVcAzuzKCtq+m+Jp1B9BXUluOVk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951154; c=relaxed/simple;
	bh=mfQRN1tXbHMSJclKLV2jI9ox/3P6h9bV4/UDwh56/f8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KGvhjwgoj+XJD2Qz/+z2RECsJK48l530Zc/XtsnATYL7wlJ0GiAG+fT6Cdxhtwi0RiaDCYS/z8LCbU4WSKwSou9RL+KErg+u28FbADzBT4sGe/wEKnv9EZOyv9q/3SdCH5x7G6gayRkWjUIEfFt08bs2VkSOfucqgSHqkf85fIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ZCaKGdyg; arc=fail smtp.client-ip=52.101.66.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ZCaKGdyg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLmQ7VwaqCWo1SWDvoFahtcN9qntJrLuiWMokpucxJgKVzHSqCItTiQGB61wbk8TPFsWQIGNZ/sFuwGjkHz2pigP8uARCcpZXITXq16ghrB2ltwWj+jmajKLoRstcuDyXtl/8gNBhkJhMIRnJWzp+Di32odd9ssYsj9xo7fQFX5tJSuUYCiEnpQgyZ7t7eSQwDOjQVNwbHQ160WaOtTNKpFdn9EB4mQzwe2hSZLDnysvfB+PB2UZo0uxK39OKhh12Qbx9XiziFotst0k2bZ6n957iD5SITRD2bd0JWCetXrVyE96h2mWsqfxgiI2vnRyrsJSMpth7+vpGgwHkR2PBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBau+dsBfpgI2xWyB11JRtreScDJCKLR46vLBdfJAHk=;
 b=tRKXN3j3vrSTMMQGVymUK5XubolCWjtBAY+IFLEvjoFPf9sKINvL9Ahvkn2fI/uQPvQEVwACoGPydvP+cN36n29M2vu/NZBvLnMEhHgzlhUqZeTIkgNU9ol0EyCgMMoN4cDFYAPwAttDmZLspFY6D5YQXWoEHHW5j+IZlmGlL7/k976wlBsXZ9gtAPW5u2nQaX7SI0lb6RZpeCVZcXKt8oVcRdL2SG5UjAa3s4uGr/49wM7VYQqMryqoPzDxAa1K0urMAZwezGr5aWW7mSGlgL/mJKHxppX+0WovXU6NT+lN6uyQmzsj1Ews69JN/hI1ZXrt2hb8/HftSar6fEbIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBau+dsBfpgI2xWyB11JRtreScDJCKLR46vLBdfJAHk=;
 b=ZCaKGdygtY36EXocjKQypgr3FrFoXfb/ypBxUm8yzWOaiFcg/tW7LtbTwKvjrshaNPzfjIZ9XhXMtN0pYOB4UWGeBTSI9vji7/dcHWHByyi86k4RJJytTmM4PLBER4ydb/XujmylPJIGQJRh/W3zBTmsqztESMYarUmRAEFcuG0=
Received: from GV2PR02MB8434.eurprd02.prod.outlook.com (2603:10a6:150:ab::8)
 by DB9PR02MB6633.eurprd02.prod.outlook.com (2603:10a6:10:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 14:25:48 +0000
Received: from GV2PR02MB8434.eurprd02.prod.outlook.com
 ([fe80::a2fa:a7a3:b6ad:9e4d]) by GV2PR02MB8434.eurprd02.prod.outlook.com
 ([fe80::a2fa:a7a3:b6ad:9e4d%5]) with mapi id 15.21.0451.026; Fri, 2 Oct 2026
 14:25:48 +0000
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
Subject: Re: [PATCH v5 5/6] iio: imu: inv_icm42607: Implement MREGx register
 access
Thread-Topic: [PATCH v5 5/6] iio: imu: inv_icm42607: Implement MREGx register
 access
Thread-Index: AQHdUmTXDYhkjTmAnE2JhwSJk6qTNrbqOnUAgAAUloA=
Date: Fri, 2 Oct 2026 14:25:48 +0000
Message-ID: <afde7beb4019d8090d3df30bb4e0a1b7ca00ad4a.camel@axis.com>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
	 <20261002-b4-inv_icm42370p-v5-5-c65281b745c9@axis.com>
	 <ar-tpjenoxMloYq1@ashevche-desk.local>
In-Reply-To: <ar-tpjenoxMloYq1@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR02MB8434:EE_|DB9PR02MB6633:EE_
x-ms-office365-filtering-correlation-id: 048030f8-b6af-46ff-96ae-08df20910df4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|6049299003|22082099003|18002099003|4053099003|3613699012|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 yPlhjYRwxhan6r8cCM5Nzk650tOWInqSOmMdF+o/bSj9tD6jxwJMoa+kH3H9WFsmWf+mP0m+NCk93sQvhjhCKuZatxOKygM/O5BGUZ+UUUhb9Dj9Uw58M/N2Jhc7V5wbAvKDC1lrLZOAUsUwzsu3zeGFMdI7UFJRIdQyfveeh/ZGPKe6Ob/N5n+FnqS+33s31zpLLqyAs/wAT8W/NbYCBAI08rbVIf5lsC4uNUt6WzoTyDqiEcVNHoR82vCdMoKSjfpE7LM3amj9k0t152CnaB7DuuoceIIY5iEEa49KXo/n27b5g3XZsP6spwdvK/GLSFTbCw/ZC7quhK6xmgP4v/naAuOQSNvpVxQOBgSoAQIFT6N+hnXdKFeI0+fXckQrc4oXlvtO+letAb7i8RM7Ebyoo4AcJzgrR4YZ9LZlWEQop8fBtOvXD6Lgg6tdqgFhfWfWrfiXkPxV41rQjJqexSPjR54eaZL5VvdfQUt5g/L3iKm5cpAr/vA+x0pBGJTvXfBf9exBLNSFs/QtY+mQWSf2TwlN1Cr6TvKOJs1d1ga3uJ7LUDtidctOeVBdO4AGR0dI1hp6/6f33N2IvJd3nhQwLo60JXzg3V2OgUVSaJvzUohSx7tTANuGglKxRdZbmFvWkeABK55DhI2UuuwhjP33d+4I26y6EK6kLE5FyYy1Ydm7uwfLBxx0o8oE+b5mndoIxjuCi6YtACRfAUgCHQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR02MB8434.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(6049299003)(22082099003)(18002099003)(4053099003)(3613699012)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVdYd245MWxtZ0grZXVCa2VETWxNYlM3ZnoyVk9tcS9LY001MzlrVHd3WVVh?=
 =?utf-8?B?SU9aTS8rZ25lODlCUzlUalUvOUJGL0hZUkJ1QUlLSmZlZCtLWHl5UDBEekxl?=
 =?utf-8?B?SGQ4bENDaFZ1MTAvcmgycTRCanJ6K0J0eGNPUGxCUDUzZnRaeDE3TkRreU9R?=
 =?utf-8?B?Y3BQVGF6MHFOeHQwbFZKNHo5Q3UxSmRJZVJMcXlUS0JqNHp3dDJFRUlpbWtM?=
 =?utf-8?B?RW9XQkNWb2NwRnVOejdKM3MzZzZ6VlA2a251VVVKN0dlZTdtN3JYUDExWkpO?=
 =?utf-8?B?aWVob1U5UHdVbVdKalVvWitOTG9GNWFROWRXNjBBOGl3bGYzR2JjRFBUMkt2?=
 =?utf-8?B?M0x3RGFmVkVnUjh1RGZHV2dqb2R5UnJoZmNOVldPM2hvNjM5dU9ZRjN3RmRr?=
 =?utf-8?B?V2JQUWRoL0VIUGZlNU44NGlqMlhuZHZ2QXZ6d2lOcEkzU1R5Q2ZRTHpIMWR6?=
 =?utf-8?B?WDFDb2JSdVk0ckRCTDNEYXpnN3NGTEU2ZlpncnJYMm1Bd1RTd1VyWGtrZGl3?=
 =?utf-8?B?R3Y3MUlGam83REpuTnVoLzRiRVIwb0o4MU00WWh2NXo3SW9ZdzhFU1FNRnhT?=
 =?utf-8?B?Szk3U0NwelpocS9pMU1pOTdHM0t0aHVvVjNyZHV5V1IycUtaN2RuWnRWcS8y?=
 =?utf-8?B?NjhwNXFycGhRbllGSHB1Tlgwam5neEFDOTZmREtFS08wbU4rQ3Ixb2dYT3VV?=
 =?utf-8?B?b0FrUTB3ZzA0R0ZoOTlBMDZONXlaVjFEWmZhV1JiVk5uSWk1VUdTeURTcnUr?=
 =?utf-8?B?emZQMTRkVC93b0I0dGdVRmU4YU5oQ2Z0dWJ5aUpnMmFjZFY5Q2trTzlRMHBW?=
 =?utf-8?B?UlNFUnd4Y091enFvWnkrZ2JxSWIrYlRsRUY4SVVDOVEzM2E1UUlCMUJGQjJz?=
 =?utf-8?B?NW5vaDRhNGdUbU92MnIwUjVGRkZPWnlQTGkxdWxJSERlSFIvWVVrNCsvSHVY?=
 =?utf-8?B?U2hKVmVWc3haRHNaTHJaNkpJaDhvbk9mUTQ3UkR4cnBHTzJsc1FoTG1yNWV3?=
 =?utf-8?B?a1BJcUd6UjlXaTA3bDlkY0NscmVSZ2FBQnNEc2k0OEhDYmxCMjFMczFkczV6?=
 =?utf-8?B?dmxucnVuMy8vYTJjWTJRbVYrR0RNbSs3UEVDd2N1Yy9PRmZ5bHJXa3lGR0pt?=
 =?utf-8?B?NXlsT3NkekdUUU0rTUNhUkttQVloYVJCTXZJYnlKV3cwOGdvOUtBZk1KZ0Qx?=
 =?utf-8?B?ZStEL1htYWR3ZSs4aVFZS3R6WW9KY2dOK2lQcXpZVHN2V05EM1lGeXNkOUt4?=
 =?utf-8?B?V2NDUmlWcGxQUTZWYldLb3RuUEJZM2VldDBzQm1KNlJZakFUL2dKV3ZYMU40?=
 =?utf-8?B?SHBXSGJjbStsRHU5YVV0c0Q1VmZseUhLTExYSHQydHVqbERHYkd3U3ZWYnFP?=
 =?utf-8?B?Zmo5NXhBa3hxQVBEYlI5QkowaVYzZ0IreVd3ZzlpREZaa2EyNTdrYldYMW82?=
 =?utf-8?B?Mkt0OVNEbEU2RmhmbTZWVUtYRkRuaFVDSk42T1AxQTV1dlZ1eEhsMi9uT0dq?=
 =?utf-8?B?SGpFOVJHU04vRzVFY0pWYnk1UUIxN2xxa09hbVZLN2hkWk10Y002U2EyZU5U?=
 =?utf-8?B?STVPMnpEWmFzYkhaQ1k1eUNHb0NPc2FxSGw1YWQ2RmFDSURIcDE4RDJ6YUhh?=
 =?utf-8?B?dWgyWCtkZG1FRGRkOHd4NmJZQ0F4cDgrR1hCTERtZ2pDMmR5V2RqS2M1Q244?=
 =?utf-8?B?ZDNJUm5tdGV6Ry9nZjVLMEtUMWdwRHRITllJWElqM3ZaeVBVU0o5emYxVVFY?=
 =?utf-8?B?SVA3S2RocERkOEVIVnd0S2FqMUEvUlphRk8zVHFJdWgvaitTWVdTaUh5T0J4?=
 =?utf-8?B?WEp3Yyt0c053b1ZQaHR2WTViaENVUWFXS2pTZUdWRGVsQkNUYUpMTU4yMGFR?=
 =?utf-8?B?Zm94L0pkcDVHZkVYcnVhYktQbVR0bDkyRmxIakFubDBoVTlyOXQzVDgvcHRv?=
 =?utf-8?B?TUUvcWdWKzBiSFZyVHhvM0xZS0dXK1BDcy9veW50T1NBMS8xRDhJV1o2TE5j?=
 =?utf-8?B?ZVlkZEdsOFgya3lFalZXbUhHWDQyOVVxVmNOd25sNWs1UGxGRk9GWXQvd0hD?=
 =?utf-8?B?cjhOQk1CbUpkN1BCYzBycmM4MGxITSt5dUd5dHRaaGJvNVhPUmJZU3JGWjRk?=
 =?utf-8?B?WFdrdk1RbVJYVUVTOVY0RE84RVozTGN4b0plY3RyS2dOVEFPcHZxTVY1Q1pP?=
 =?utf-8?B?RUR2RUhDVEpaVjJBN3lCWWUreXNwaGFHb09hMW1yb3ZxZjJzeXFLV0RSRTRr?=
 =?utf-8?B?Y0FSVWM2RGp4aHZuajFPcmg1Q3BoZDgyMWpXdDZtc1dKNDVnaVhRcWNTWXVq?=
 =?utf-8?B?eElZcS80d1dpdU01dHRCbDVjN3N4UXpqNlpqaGJtZnc3eCtVZDhZUT09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-5rs8WIjgleGIDKVjfbSU"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR02MB8434.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048030f8-b6af-46ff-96ae-08df20910df4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 14:25:48.6363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mX9MCEpOqnP/YNgsodpCiJEk5Nf+1kKlHP2xEGy+aV6BwtnGsWO8GDEi7CCwxxei
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6633

--=-5rs8WIjgleGIDKVjfbSU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Fri, 2026-10-02 at 16:12 +0300, Andy Shevchenko wrote:
> On Fri, Oct 02, 2026 at 01:54:29PM +0200, Kanak Shilledar wrote:
> > The device supports indirect register access to different banks. A
> > specific routine needs to be followed when accessing the registers
> > in
> > another bank as documented in the datasheet (section 13). This is
> > required for accessing registers configured via the user and
> > implementing buffer support. The implementation is inspired from
> > the
> > icm45600 driver. The banks are defined based on their initial bank
> > access code which are written to the BLK_SEL_* regs. However, there
> > is a
> > variation for MREG1 as User Bank 0 and MREG1 both share the same
> > 0x00,
> > so User Bank 1 has 0x00 and MREG1 has 0x01. When MREG1 register is
> > accessed, then BLK_SEL_* is written with 0x00 instead of 0x01. All
> > the
> > register access goes through the 16 bit virtual regmap layered on
> > top of
> > the 8bit bus regmap. Bank id in the upper byte and the register
> > address
> > in the lower byte. Bank 0 accesses are forwarded to the bus regmap
> > with
> > the bank field stripped, while MREG accesses are forwarded to bank
> > switching sequence.
>=20
> ...
>=20
> > +	unsigned int val;
> > +	int ret, ret2;
> > +
> > +	*idle_set =3D false;
> > +
> > +	ret =3D regmap_read(map, INV_ICM42607_REG_MCLK_RDY, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (val & INV_ICM42607_MCLK_RDY_BIT)
> > +		return 0;
>=20
> Why not regmap_test_bits()?

I will fix it.

> > +	/*
> > +	 * Clock isn't running: we're either in Sleep mode or in
> > Accel LP mode
> > +	 * running on WUOSC. Force the RC oscillator on via IDLE
> > and wait for
> > +	 * MCLK_RDY. Datasheet gives 10us (accel startup) to 200us
> > (accel
> > +	 * transition from OFF) for this to complete.
> > +	 */
> > +	ret =3D regmap_set_bits(map, INV_ICM42607_REG_PWR_MGMT0,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42607_PWR_MGMT0_IDLE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*idle_set =3D true;
> > +
> > +	ret =3D regmap_read_poll_timeout(map,
> > INV_ICM42607_REG_MCLK_RDY, val,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val &
> > INV_ICM42607_MCLK_RDY_BIT, 10, 200);
> > +	if (ret) {
> > +		ret2 =3D regmap_clear_bits(map,
> > INV_ICM42607_REG_PWR_MGMT0,
> > +				=09
> > INV_ICM42607_PWR_MGMT0_IDLE);
> > +		if (ret2)
> > +			dev_err(regmap_get_device(map),
> > +					"failed to clear IDLE
> > after MCLK timeout: %d\n", ret2);
>=20
> Broken indentation.
> Is it really important message?

It is useful for indicating failure in MCLK, but I will lower the
priority to either _info or _debug and fix the indentation.

> > +		else
> > +			*idle_set =3D false;
> > =C2=A0	}
>=20
> ...
>=20
> > +static void inv_icm42607_mclk_put(struct regmap *map, bool
> > idle_set)
> > =C2=A0{
> > +	if (idle_set)
> > +		regmap_clear_bits(map, INV_ICM42607_REG_PWR_MGMT0,
> > +				=C2=A0 INV_ICM42607_PWR_MGMT0_IDLE);
> > +}
>=20
> What about
>=20
> 	if (!idle_set)
> 		return;
>=20
> 	regmap_clear_bits(map, INV_ICM42607_REG_PWR_MGMT0,
> INV_ICM42607_PWR_MGMT0_IDLE);
>=20
> ?

Will incorporate the suggestion.

> ...
>=20
> > +static int inv_icm42607_mreg_read(struct regmap *map, unsigned int
> > reg,
> > +				=C2=A0 u8 *data, size_t count)
> > +{
> > +	unsigned int val;
> > +	bool idle_set;
> > +	u8 blk_sel;
> > +	int ret;
> > +
> > +	/* MREG access is one byte per transaction, no burst
> > support. */
> > +	if (count !=3D 1)
> > +		return -EINVAL;
> > +
> > +	ret =3D inv_icm42607_blk_sel(reg, &blk_sel);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D inv_icm42607_mclk_get(map, &idle_set);
> > +	if (ret)
> > +		return ret;
>=20
> > +	ret =3D regmap_write(map, INV_ICM42607_REG_BLK_SEL_R,
> > blk_sel);
> > +	if (ret)
> > +		goto out;
>=20
> So, can we use regmap ranges instead?

We can't use regmap ranges because the register accesses for different
banks guarded by a specific routine of writing the bank selector, the
address pointer and then finally accessing the value along with
checking for timings and clocks. There is also a limitation that,
accessing the registers in banks other than USER BANK 0 can only be
done serially. It doesn't support bulk reads. This is documented in
section 13 of the datasheet [1].

> > +	ret =3D regmap_write(map, INV_ICM42607_REG_MADDR_R,
> > +			=C2=A0=C2=A0 FIELD_GET(INV_ICM42607_REG_ADDR_MASK,
> > reg));
> > +	if (ret)
> > +		goto out;
> > +
> > +	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
> > +
> > +	ret =3D regmap_read(map, INV_ICM42607_REG_M_R, &val);
> > +	if (ret)
> > +		goto out;
> > +
> > +	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
> > +
> > +	*data =3D val;
> > +out:
> > +	/* Restore direct access. */
> > +	ret =3D regmap_write(map, INV_ICM42607_REG_BLK_SEL_R, 0);
> > +	inv_icm42607_mclk_put(map, idle_set);
> > +
> > +	return ret;
> > =C2=A0}
>=20
> ...
>=20
> > +static const struct regmap_config inv_icm42607_regmap_config =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
>=20
> No cache? Why?
As the virtual regmap config has some caching for USER BANK 0 registers
only. The indirect banks doesn't support caching [1].

> > +};
>=20
> ...
>=20
> > +static const struct regmap_config inv_icm42607_regmap_config =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +};
>=20
> Ditto. And why they can't be deduplicated?

I will remove the duplication of these regmap_configs.

Thanks and Regards,
Kanak Shilledar

[1] Datasheet: https://www.lcsc.com/product-detail/C5129967.html

--=-5rs8WIjgleGIDKVjfbSU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTOMrdbv2P+LZwbQtLEY9j7t8KaZwUCar++6wAKCRDEY9j7t8Ka
Z5K6AQCWuRH3ximHlV4phQARVedlNj7QQ6RsSZogI1HAWV8qPQEA6lbi1w9OmI/r
E8Ro1Kc8JUzo8HRT5R/dZ54vdAZEAg4=
=iIXP
-----END PGP SIGNATURE-----

--=-5rs8WIjgleGIDKVjfbSU--
