Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013034.outbound.protection.outlook.com [40.107.162.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552252D7386;
	Thu, 13 Aug 2026 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786624670; cv=fail; b=If9c6NFCqPhRYb4ExZuMzSx52u1K7pJYcqdnKgVFKoUWfakQaKmOcunNP3bGExC9u9sXUxda2V3s/DkvVGNOPHmtFev14LxZnoq3NdceOcn/EjTDZE+Gb77pnG3pFaGryF7ttneco+c0ujKC4JNOrhsTPjgnwgSG7uCIUPSPoyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786624670; c=relaxed/simple;
	bh=589p88QEXqmNbmHbLnVEIOp01D65st/1zd+FZZmOGGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sx6yv3QbgiR5m0TI4KaMJOJyt3bz3MNHfN8OTXDpp3BVPDWOYGavk4kyu5qbryALUabxo6xrYWVjVwSKxWZzW8KXGjrIZyVNpPE58CNI8uT5DhMH1liLPOUFhaaaEbFb4Lr0f4kGvrDBEVC8J5ONAFtlHoPIR9UL8Joz/P75iG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=NEV+S1o6; arc=fail smtp.client-ip=40.107.162.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="NEV+S1o6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNC4/vNU9joNOOvp5+XWyOBU2tYX8C0fCKdV6A6Bujuzkw/muLhNjEyFHIKXY5OGZ7lWoVpOPLtOfya+J8ISLtPnL8R6bpXQtAS9/R/6UHDyz9yJRkmopoaMXi0p1ISHkKqO5mOYg8x0kRhOoMfd9QVUNsAH2odg01cw2QfNtrKYtBkFZWPDi6NRimlU58i+G251AflpmVctGBza3B4bclzmp/zhjlnUepvc4BKeihgXchYaJ21D9yvwa5/6h+XblvVedD3m7qrfdZq+ZLDV0W/tFOgYax8VnT0odzBLYEw7rQH/lUPTmJhM3jumGFYiFePp3PCKcJfhGJQ+3Uepdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=589p88QEXqmNbmHbLnVEIOp01D65st/1zd+FZZmOGGE=;
 b=BRL4sHNbfbgUxjLaRuf9oQcPTCl/H+7mZazccHOjiFubOOdgZ5iP1iGyCRiiwq33/QzwFJtm76uHxDghrJvUdivxKQ+JsjTzRaU/gdvwRWkRVhcnHGkLEiBL9cO+d9dlXPs5HRJ8QkNYnDTD8bKkweqc14nmpws0srSm9eiPQv0P7/e/JgUADJiuGs3xMy8VpLOFQASCD+z3rWGkL6iLB3y/fozxeZIgwMAJ/h/f9eKbot5oDcC+XtCZoCtXY2mxWxIF5K3mlEmcodGRmnFnnUwzcwGPHRZI2RTPaSk6kIzk7ctGSOne65IG4DcOgZe7/Jz1SDj7lMq1vUytMWDx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=589p88QEXqmNbmHbLnVEIOp01D65st/1zd+FZZmOGGE=;
 b=NEV+S1o6UHtkYsypGY4kkdN61h82LF4n7YHab3Y27WVgIRY8hpvvPl3azouyZBJBMI/xgnViw8CVtdW2tgm84NpxVAE3HdOG/39CR9qNITdb7HZOU+j+jk59ClEl5uD9D+0w8z+KFntiuaYpiEU47DqUWEe6cXgeK7PvpvcDC48=
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 (2603:10a6:10:43a::19) by AS8PR02MB9814.eurprd02.prod.outlook.com
 (2603:10a6:20b:61d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 12:37:45 +0000
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff]) by DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 12:37:45 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "joshua.crofts1@gmail.com" <joshua.crofts1@gmail.com>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>, Henrik Grimler
	<Henrik.Grimler@axis.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"jean-baptiste.maneyrol@tdk.com" <jean-baptiste.maneyrol@tdk.com>,
	"robh@kernel.org" <robh@kernel.org>, "jic23@kernel.org" <jic23@kernel.org>,
	"andy@kernel.org" <andy@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Kernel <Kernel@axis.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: accel: Add support for ICM42370P
Thread-Topic: [PATCH 2/3] iio: accel: Add support for ICM42370P
Thread-Index: AQHdJaGpkDBJeWC86ESJa7wUb7qbr7aSXnCAgAA7BgCACVxQAA==
Date: Thu, 13 Aug 2026 12:37:45 +0000
Message-ID: <aba48fde655c2f1c0a10c335dd50a07a8a52fb5d.camel@axis.com>
References: <20260806-b4-inv_icm42370p-v1-0-670837f5842f@axis.com>
	 <20260806-b4-inv_icm42370p-v1-2-670837f5842f@axis.com>
	 <20260807120937.00004e3c@gmail.com>
	 <ba866b98384dcd827d5a610de9f00386da5824e2.camel@axis.com>
In-Reply-To: <ba866b98384dcd827d5a610de9f00386da5824e2.camel@axis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR0202MB9129:EE_|AS8PR02MB9814:EE_
x-ms-office365-filtering-correlation-id: 6a4535cd-df23-43e8-473e-08def937ad13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|6049299003|18002099003|22082099003|56012099006|4053099003|38070700021|4013099003|6133799003|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info:
 aXSgp0LgHa2RrIyjk0o2mVHNoMWyrk1yPd1H+oe4boYnQ4P3GLf+MfGj/dRLjK6aPmySgDs8+Tu676kCw3DZlOxXaKSfGiL3Jjz3rcLiGURFl+ZMdvK937NjTkXbFgKG6I93JmSh9kA1oYzgT2en2QclaquCYoohutPI3HVgmcjpd9NnM6r1uL6vc06Z7ocowu5Roh4+L70MvqVyHBqtJ8/5jBBhDS1PY9rvEnlNFJtQ5I6i5cd43V0iT9H0g0yNgWSSZ58DDYKwcwZ9DLjIcZ/SjNtml9WOAfdePgTmJUW48MLhfzguZD2Dq9EvFss01Qc8zWcOzNkK+8tuoq1W2H65jxzpuU4jjfsxCxhiEt2zHnDbWX2uJDHmYf4G7nlSSR4ScajfrTvjD+Y4PfKn8xOcwuQFXUPO+GxL44VsxDEsFV18+2MxsfpXKL3Dn/b2mCW1tABU6dS8fJ1xnrbDliFOctNDj7vy7jleM+RbHdCFGyF+xDggQeO3hX3q2A6fR560SyXwF4axxYYe2yZ/kmyxORb+ppBiZcoHBXGZbRxMMDHlnvxg4l/GM0lhHsjkxQz3/1GTjt3dQZLf5SCR/JRONPmkZsUnypQJSE6945AjPeG/MKBZ9Ss7+rMcmq/J513ERzUNUOKggs13ydvyLKukP9T/5UZopBLyyIiNSXTsomhRMDv1o3DIHvBF1Le4UTReY7A/K+k6kxEajGdFXioL28lw0tYQiJRPZ9mVFOA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0202MB9129.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6049299003)(18002099003)(22082099003)(56012099006)(4053099003)(38070700021)(4013099003)(6133799003)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejFTRngrcmRzUDN3SUo2SE9KZVFqaVN5Mkd0cXhZdjUwN0FtdjZRNm1TQnB4?=
 =?utf-8?B?bWJCQ3Z2bVgvTHI5SDdYM0NPN2szSGlJRnlHVzFpdk0yRDFkeHdieHc0RVpY?=
 =?utf-8?B?ODdkd1hNTU95ZkQ1UnZ4NnlBMThDb3k2dVVrN0YybDFmM0dEYmNCT05rZnJs?=
 =?utf-8?B?TDJYUEIxVWk0c2NzOXRham5lbk5pbE4yT09wZTB0L2JGM2M2VXFTVWNMQzcr?=
 =?utf-8?B?MEF4SlQ3TUYzVGIybXZTclVFWWwrOEpUc0FWeSs4WTNNR3R1QlN0OUZnR3Fm?=
 =?utf-8?B?ZWw4emhRSitQNHFrZCtlUEtQQWN0dE5OS0tBZUU5eEgwZXdhWFF3YlZVSy9F?=
 =?utf-8?B?NjljazFnL2Q3RjB5YVBJYXhHRzRBVmdZT0VDbjV3emNJOXVQNVpFalROQ3Rs?=
 =?utf-8?B?R3hEdk5sSFpXYWdMMjhoQkxzOU9lck9RYXROekovelh1YjA4aS9lbFhYUmFS?=
 =?utf-8?B?dm90TS9PaFdTL2k4aU5jekpDK0NkVVVuaTE1T216MHJkVDZNZGdCd3htRUhI?=
 =?utf-8?B?YlBVK0poUXFZc0tPM3dJZ1FlNFJlYkxXNGkzN0UwMTdCQW5JRmxyeDBNL3RC?=
 =?utf-8?B?V3poeUdDd2Q3cEdTc29XellCVkttc284V2xCaDN6SEpxcHJYVlRQN2xPS3NH?=
 =?utf-8?B?TzVKWS9mU1Fra25GdHRRQjZiNU9XdHpjbko0UXVmdlZPK0d4WEtHL2swcGpP?=
 =?utf-8?B?UkNyQ1RLRHFFaE5HV1lETktWNTFYOWlidmtMQkFvNDhqeGpvUVZVSWVBVVU1?=
 =?utf-8?B?VzN2Uk1YZ3lPcSttNnRGMWZ2UHV0b2lzOWFjQmVUaGxUZGd3d1RDdjNwZENB?=
 =?utf-8?B?alVLWGxxVjZWOThVSyt0b09uZjJ6WTNZVklUdEozS08xNWZicEd5cFNWd3Fm?=
 =?utf-8?B?UURmeUZYaU9xRWNkTlFsUkkrd1cvSG4vNVBLWE5KVTBXM2h0ZjZCZXc3U1pN?=
 =?utf-8?B?R0ZpRzZ6OHF2MllFZGVYOC9nWmNMMDJxV0RSeTE2U3dWZENNK0JNbkZSaXZj?=
 =?utf-8?B?OEdMdVY1THc1R05nR3RkVnZKYjIrVDFiMHNLdFVMdmpBM1ZVbnB4NXBJWjZ6?=
 =?utf-8?B?SlIyVDJ0cE9tU3dnUDRvZUJkYVRvc3pIUHBCRDdBRStpTFg5WjhtdFM2cGk5?=
 =?utf-8?B?YS9yYVBPWE12RThJUFh2WG00N242WW9QQ09XcVI4L3VtMUpaZFdBQ3E5QVlL?=
 =?utf-8?B?NHFrZlkycW1JcFA0eE9VaWxIVlNQNjRRVEtaTWxtcS8yUW55dzA5eHFGNzhh?=
 =?utf-8?B?R0V5UVUwZThvVGRodmpGR2JpK010T1lpM0JQSTlRQ25aWnRUSGptZC85eGxV?=
 =?utf-8?B?WGlOZXVFN1JaT0FoMFRvdThVR0NIVE1DT0xPZnJrS1VERWd6dXZZaDl5a2xH?=
 =?utf-8?B?bXVkRUlUN1dsdFFickMwR0dWSy9UN1k1UThYZU9NREplR1EyNWdkazRqWnk3?=
 =?utf-8?B?VTNEZG94azUzVXRzc2JUVG9SanFaWjkvQ1pUMUlWRHN0aUdJdDNkTEdZK3ow?=
 =?utf-8?B?elI3emJhV2RmT0N4aXM5MitjTGxUMWF5a01lWlNEb2RKZ2pwOGxFVy9FK3ZT?=
 =?utf-8?B?emdOMnF4TEpPRlVZSmlHdHVPUjdOelNHKzJITHZvNkQyRjVMMCs1UVZnZVU2?=
 =?utf-8?B?TDd1TU1RdFAxZ0JJZXp5cHZ1TUpBYXlucmQvYU0rYWNScDhySy83SG1OQVNR?=
 =?utf-8?B?YVVZR3NJTUFXL0trTTNsbkU4UUJONnpSUm1rbkhZaTFleUdCQU50RG8rcThW?=
 =?utf-8?B?T05pY282UXFvdVdZb1FRMGIycEJOamM4cnUwTW5ldDNHZUQyOGx0cGpJQTFu?=
 =?utf-8?B?SDhoL2RQZmE0TzhreTBYakltb1FUZ0t5aTJZWWpOc3pTWTF2aXhaWDM0RlNQ?=
 =?utf-8?B?L2lpVDlBTW8xWG83WFdMbnZwYXZsMjJBSkRabnFld0NaZ0pXK3BTcVNveEcv?=
 =?utf-8?B?SXJBZnBod3UrQjdjekpvWk1qcG5rWGMvVEZSSU1Uby82ZytBWVNoM1FCa2dM?=
 =?utf-8?B?L0tjMnp5d3ZvRkNXaTFRMkFRRjdtbmIvc0pvdFhUTFhHT1dxMWpjQlpVTjJp?=
 =?utf-8?B?eHlRVTdDaXdaNkQrZXE4bTZwYVRScUVRbVdPYnVvMHdhOEJ3RndNV1RLdXhO?=
 =?utf-8?B?THdqOHp1WStEU29hZmhLOHJVckxVRjZodkhCbm9qTStvYXZtbnpwajBNaXk1?=
 =?utf-8?B?cnpLNDJMTVRiRlo3Tmt6K0xuZjlVQWd0RnRvSXFIeWJJNmt2M2dZL0ZqdzlQ?=
 =?utf-8?B?WVdYM1pwN2UxRzBZNjY0U0ZXcm9raUJwT3RHV0Nyb1NXbEpUQ3d2R0JHeFZC?=
 =?utf-8?B?b2VYZEtITHAyMTJDbjZiWDYyTWhzUTV6QlVYUk02empmOEVCTHUrZz09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-ZD8AQ7qluWOsFXoqFlm9"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0202MB9129.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4535cd-df23-43e8-473e-08def937ad13
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 12:37:45.4994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V//Wyk9T+WGDzk4C11KrOjcKULB/zBesvuHAQQ8/3sviviLsta687cgexofTrSzw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9814

--=-ZD8AQ7qluWOsFXoqFlm9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joshua!
On Fri, 2026-08-07 at 15:40 +0200, Kanak Shilledar wrote:
> Hi Joshua,
>=20
> On Fri, 2026-08-07 at 12:09 +0200, Joshua Crofts wrote:
> > [You don't often get email from joshua.crofts1@gmail.com. Learn why
> > this is important at
> > https://aka.ms/LearnAboutSenderIdentification=C2=A0]
> >=20
> > On Thu, 6 Aug 2026 14:46:28 +0200
> > Kanak Shilledar <kanak.shilledar@axis.com> wrote:
> >=20
> > > Add support for the Invensense ICM42370P MEMS MotionTracking 3-
> > > axis
> > > accelerometer with a built-in temperature sensor. Compared to
> > > other
> > > sensors from the same vendor ICM42370 uses a different way of
> > > handling
> > > register banks. Although the device supports I2C, SPI, and I3C,
> > > implement only I2C support.=C2=A0 Provide basic support for raw senso=
r
> > > reads and a sysfs interface for setting the calibration bias.
> > > Keep
> > >=20
[snip]
> > > +static irqreturn_t inv_icm42370_irq_timestamp(int irq, void
> > > *_data)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42370_data *dev_data =3D _dat=
a;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 dev_data->timestamp =3D iio_get_time_ns(dev=
_data-
> > > >indio_accel);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return IRQ_WAKE_THREAD;
> > > +}
> > > +
> > > +static irqreturn_t inv_icm42370_irq_handler(int irq, void
> > > *_data)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42370_data *dev_data =3D _dat=
a;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int status;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&dev_data->lock);
> >=20
> > Use guard(mutex) from cleanup.h, it eliminates the need to use
> > gotos
> > and
> > labels for cleaning up functions (a lot of examples in IIO for
> > this).
>=20
> Will convert all instances of mutex operations with a guard(mutex).
>=20
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_read(dev_data->map,
> > > INV_ICM42370_REG_INT_STATUS,
> > > &status);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out_unlock;
> > > +
> > > +out_unlock:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&dev_data->lock);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return IRQ_HANDLED;
> >=20
> > Not sure, but is it okay to always return IRQ_HANDLED, even on
> > regmap
> > failure?
>=20
> From some reference drivers it seems to be common, but we will
> investigate this.

To conclude this thread, I went through the drivers and there are only
3 return values (c.f. linux/irqreturn.h) and interrupt is caused by the
device which is not shared by any other driver, thus we should mark the
interrupt as handled even on failure.
>=20
> >=20
> > >=20
Thanks and Regards,
Kanak Shilledar

--=-ZD8AQ7qluWOsFXoqFlm9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRZbIB7R61KYt5yWsuslrbqDH4eIAUCan26kAAKCRCslrbqDH4e
IOIAAP48VXNtMPwc/vHLJpePr1UD6kSoLkff1XOd3fn/Vwco7wEA1Apf0PlT2NLu
tI+soFH8XPgkJLaUSF4ZhG0jSR/AnAk=
=cQ1c
-----END PGP SIGNATURE-----

--=-ZD8AQ7qluWOsFXoqFlm9--
