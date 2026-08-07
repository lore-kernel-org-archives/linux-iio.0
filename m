Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013054.outbound.protection.outlook.com [52.101.72.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5550347A0DB;
	Fri,  7 Aug 2026 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108309; cv=fail; b=JmLGYscolq7DnvhYUV/YsZ3fnJcp9I7h9qMRoFWDyB3kFtLcBkHQaj8vDquUmcGxe/GeQ1p1lFy1eTOLLYVGHGtXdT6OAoiQfKi8bcbCZepryMPdcLITwVZZCts0sPY0TnklrqxOLuf/qXFQeKKz7N+yIwhIXMn/ISHHC/m1COM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108309; c=relaxed/simple;
	bh=YNbvuLlCAC0jDW+iWVYwj9Gtun6HuruJ8v5pABmjOCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DNKx1RucO05lWHAYX65nxF68wilNE5DwENuH3REd7vbDxTNvQ287TCz1hAXAjtZVXzeKvhsotkO0uiPhuuMqBRxpgGQhRXFpFXWYUf+K6H2Cm0DVpYrM6F3tzoAGfpB4yg8r3FZBfXHgINBQf+WCfESnVH9KVZQDazNYQBGFK3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=AAQQ8FlO; arc=fail smtp.client-ip=52.101.72.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="AAQQ8FlO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxXogjRBcaOUuHn3m4FB6+dfUWaOr6hrRN4MGsYv2PGjSvKDN8x4lr+vaTdazMtcm8Cgs2d3mP32QE3Cs0zQx5x8npFXQe7VCxdYFAjX9ui9YCZTXL9Pp+tmnWt3vVwftsQMbQgyfqpiXFNq04l5TiPPGTbsnXHz8m7Hyez9JUQYP/v9YP0Ub31OzZu4MVzDExLUwU78PaYKSHrR/SbGzoDqvZZmS4NXL8+qK5xwzzfHz3eqDDMyYp8LUdo0f+JQyHq6V79yJ9sqaGHEwY0V0JuaoU/+vlic/2IH5i8OheiB6bqtluin9GZpcMeKi6wy0pKf5K/tkEeZn0vIkgHX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFRsMQmq85SiY351TcnnNnQFjnzSBEsCmU8kweoTeA4=;
 b=wYNnATet//3+rfm2xUNPSZQMdYAiz7AnWqgeBeiazlcl9Qt8rtdDji5dEKuhxmUHsyKGH7/8Wss94nh+qjM5o7TfS0awdYjOjtNcrky4+yYGAcf5A7LgeM7fuxDsEZENCzz+5axPfnGfO/14ImXG14FGPlp6362yrzw6RkYv11fYK4I8FyJLTlcrTtfoC0UU2zHzIpaPSUEnKbNLUntHOtuvCpKM1zXI3ECsmCkOBNL2hw5SiOzI/MKgV2u9CWb5XcWjhGreIdfB8d8elpN4Z4/wHtihNmusP1FNyKRuoiU9g8V7Ou/aYCbqdz2eJ++UFYWyvVbCs+lbJvC+mhtO0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFRsMQmq85SiY351TcnnNnQFjnzSBEsCmU8kweoTeA4=;
 b=AAQQ8FlOsoAK43nD6fwnVnDpyl6HMCYsAzyXeq3GVp/P87QSU94cfrCrvD7kTyNqJBFULMijluasPPCktEopMFepl3MZ27EzdoCkO92HTO4i04JMyy5Vfc2RlPkIU4U0SBDMqLM2yVj8PrzUCZbDjBdnQHcnhmGJ2UgCUkkopfc=
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 (2603:10a6:10:43a::19) by GVXPR02MB11015.eurprd02.prod.outlook.com
 (2603:10a6:150:217::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 13:11:28 +0000
Received: from DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff]) by DB3PR0202MB9129.eurprd02.prod.outlook.com
 ([fe80::7510:e8c3:db37:47ff%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 13:11:28 +0000
From: Kanak Shilledar <Kanak.Shilledar@axis.com>
To: "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>
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
Thread-Index: AQHdJaGpkDBJeWC86ESJa7wUb7qbr7aSJyAAgABqHQA=
Date: Fri, 7 Aug 2026 13:11:27 +0000
Message-ID: <0470d70cd9d3787b5759b00f424b06f58830c094.camel@axis.com>
References: <20260806-b4-inv_icm42370p-v1-0-670837f5842f@axis.com>
	 <20260806-b4-inv_icm42370p-v1-2-670837f5842f@axis.com>
	 <anV_NpsTKyQN26ip@monoceros>
In-Reply-To: <anV_NpsTKyQN26ip@monoceros>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR0202MB9129:EE_|GVXPR02MB11015:EE_
x-ms-office365-filtering-correlation-id: c3e7b36b-b85e-4ed4-f1fa-08def485640d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|6049299003|7416014|376014|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|38070700021|4053099003;
x-microsoft-antispam-message-info:
 gv+LKLWm4Iii2tHr6vStjLJftONdTie5pa4AVvX8A7RHJ6ECoO3HwI5IOwsuEdiUaXeJbZKZwpGW0Ph1uU4IHTUlFdAeTeHV0rVO/+FMHs/EdRKuxaxZ1K292WCP6bpCCiftIVIbhEV+Z6NvUgfqc99VKAcBuZDs1v5xzgtnVNZB+DYYkdBpHNjJqcafouyliVx90JUN9zuVDMf/qoReG9WFIWBSPW/eX4V5H6d0PU5zFvOZ2tLTDvS0HDZxZVQkQuAkIXTrUsQiFtkS7S7vLu8tGz1oCD+SJLAQERf3eiOUMQYEXx7cUjTAMbwSll+gkcJq71aaCHaQTwzkxZwvcr86etSRYQk2UzdYcA0YhSCaBcBT3RbMN0oR82pia8U3glhpVnsjB1CmxWOQlDOp9xQrnsomqKdlWo+nRFq8RuAWEB6Km7WJnemYvKnT7JW84kclRlD3P2ywynAUxDsXYvLmUTdWrCiFjZQSCk9bN3yPo9CuFh5CH04fc98/JWTZG/q7EOAmyY8BzfZVYxkdS5LsegAIQV9yx0PXYopW7iLroyoW6fT4/7+I3FND8pbOiY6KCHFkrvHk7pKqLNypxHxwrGxFbf/w7rGTD7yW8CpGzS5FUyx+w9WvwqG7/ZTkbvmUml1cEs0E4iYCzeuH7tht5ChN8jjAaQM9gxclYHXdCrlgakvbUps51oHrrtoc2M/eCfVDuI5EOrrEtOd4N2C+wIF6lee1YKIGt3lK48o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0202MB9129.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(6049299003)(7416014)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFF4TnhPa2ZzZjlIZTJFT0dFVjlLZlJaRjhidHQ0cVRRdklNTzh4RG13dUJG?=
 =?utf-8?B?Z0V1ODlacWpzem5sRExrTjJsWEZRMnZYM2lBdmFybUxMQzlZOUtxcjRkcFlP?=
 =?utf-8?B?ZXNtTkVlYjlZckJSTzgxSk01WEU0Mm1yV3FoL1NqWkszYjJOaEFwNFBNMEw4?=
 =?utf-8?B?ZWt3dXEwdUxybW5PMG1SUnlxYVBPTlEzREY0Nk1VTHZFVGFpTm9URTNwTU9O?=
 =?utf-8?B?aGVqRlRscmh6OEp2QmNoaFprRmVUY21ycDFXVGhXK1M2R1hkOXNyTFFCK2cr?=
 =?utf-8?B?S213dnV6QnlFYjhmYnVZWVVnc0E0VEZHRit1RkhRbmFpSldEcTJoaHRUNDNR?=
 =?utf-8?B?eFNTZWNvTk9KUUxQclJ2UmgxQm5idFB1NVBOSFR2aFNHTlJDa0pSU3VjdkFv?=
 =?utf-8?B?dUIyVlNXR3M1OUgycGJyZnZEMFByZERhV1FOTVZzaHpQV3Fwb3UwejJsbTd0?=
 =?utf-8?B?QVl6TmFZQUJzTE5GbXUwVDQyVHV6SzRnNWI5UVEwVER5RmtERS9SOU05MTRB?=
 =?utf-8?B?c0xieGVXL1lKYUUzbUtoMG1PdTE3QUNmdU04L3hZVTZYRDBESi9DVjJwby9Q?=
 =?utf-8?B?SVBwRUM2T2tZNTkvK0RDRDdVamY5RkRjSElyWVZVaUl5R1hRT3BqRGI5Zmlm?=
 =?utf-8?B?dE5PTnpPdjlXUERMS0tDSDFWa2JCanNLNitrUkh2WG9NaFhFb1ZlOHZtQnM2?=
 =?utf-8?B?T3YzdUlnNVJ5SkFkWW1uSGJTQ2lhVDhYUkdrSUE2VlgveXpROWVuUFdQY0la?=
 =?utf-8?B?VjF3SFZlUklicUJQdXJ0Z2V4S0tIOTNjNmdhY0ZWVzFnRUcvaXc0cWg0Uml0?=
 =?utf-8?B?UnpPbkdGMlBEdWsrbFcwVkRVRWdxSG1oS2dzM2NQQzBPdUJXVUVlWGduVnpQ?=
 =?utf-8?B?QWdjNWlkVXVBZGFNRVg3OUp5bE1yM2hTRUVUSUF1MFdsdXJMV2VIaCtqUjFT?=
 =?utf-8?B?UmJiSWplSTNkcEs5UjZjRUVXYTVXdm9HRmRVVGQ4ZGFvbzNCOFRnK0pTQ3Jv?=
 =?utf-8?B?ZklzTzYxeG5YdkRqSmZYYWJZNHkzWjRwVmhPYXBWaXdpekh3TTVia1Q3OTlo?=
 =?utf-8?B?SUlCdUZwQm80a1JvQkJlajNLemlQOXJlOWpvMkNBV2ljb3pYL2pOTzZ3cmdm?=
 =?utf-8?B?T2NMd3dObUc2TmhEYXpFVXo1SEhJS2NMakgwVTNiZXdId3QwMmJ6dk9Ld2tO?=
 =?utf-8?B?OHNDR0diWjFpSXpoaVZ1Y1BKL3hIUSthdmxJZ29yaXhoaW40dENmd29KUTgv?=
 =?utf-8?B?bmlPV2pTMktLZC94ZE9sdlZvWXVQVkQ5Y0x0RkxBYndqN2pVV1F6a0RuRzg1?=
 =?utf-8?B?QjlOY0JQOW0yMHFWYUp1c2VCSEZPZTRYK3lEQWJlbUxxRGc1cFVGSUh2MGtB?=
 =?utf-8?B?SDZoU0poZk1tYS9YK3EvNWZXczhnb1dGWVhvWE9KUFZGVVpra3hXSWZFNmlS?=
 =?utf-8?B?MGZFcmU0eGN2dzRCdXlZUjBjYkprOXUveDZsWmN6SUJmUWc2WmtHenNmbkNa?=
 =?utf-8?B?TndKZ0Y0WHVGM1Z3SmJwTWkyWWRhTTNyZHJLZWp0TFV0VFNDNXNPbituRllq?=
 =?utf-8?B?c2hnVm9kVE5YRzErait6SXh0U0ZCY3hYZ3o2bUY2eUZ2NFpvdGpyNFhRdGJx?=
 =?utf-8?B?cTZxaUZQS2J3NGY0OVJnM01ESlRNWmlnT0tiSHUrRHJ4aHBTblRRTks2ekZM?=
 =?utf-8?B?aWJUWWk1M3NHblJGRGdnVjhhYU0vaWU0eXZMUmxVYWJpTjlTcVE5SUhQOTNk?=
 =?utf-8?B?eHRwb3FoUkRVOFhkVlNyWHAvRVU4c0JGQkw0WW1hdDRnakJvSVpramwxaisx?=
 =?utf-8?B?ZVd3T0JUNGRxTXNoWm1WN3Y3MjRGSTVPOHFiWVdmcDNlMXBrM0ZzMVRVRHpY?=
 =?utf-8?B?V1VXbjBSZ3JWeEdkVThJbWVBNU9TT1Bpc1hCUmJiUENNTFM1K1k5YkhIaVgr?=
 =?utf-8?B?MFlqK0N5ZUMxYXdwcFgwMXlxM2ZlN2lTTW1KcnZ5WmdmSmNnQXVnYzExWVRj?=
 =?utf-8?B?c3NvL1F4aVQ3U2hCU3dNc3gzT1BnTS9Ta1RVNUN5aEtEVG8vV3oxTXUwN0VK?=
 =?utf-8?B?dXhTdjgwUFZZMnZxYUJuSVlpYk9IZ2RNb1luMU41aDVRVDJvSzJXVHp1SzlJ?=
 =?utf-8?B?Q2VKZ2ZRUUNhR2lPZW1qWlRkeGJhanBWNllzMThTVDFnM05FV0xlQTc4VjN4?=
 =?utf-8?B?U3JQWlU4aWdIQldlUkNwekJyZ1pZVm5uODlqSDR0SmhUUG9zSFRmMmYwNzBh?=
 =?utf-8?B?dzNDRTBxVU1iZEp5M0JlaXFuZVFtQ0x3SExNS2UvV1pKcTJsTVY1RThjMXd2?=
 =?utf-8?B?QWNtUEFWcUNROG5rUzZhM0lORFJZU0F0MGhVLzM3dDJCUyt1VjVOZz09?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-tMDPN8eTWxQL2DYQNFKU"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0202MB9129.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e7b36b-b85e-4ed4-f1fa-08def485640d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 13:11:27.9121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHTwSTK7yExwcLIPaaXiM3GymGtmuhmondWoHIpiAuyDi5zYIdADz5BLjteT3ke3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB11015

--=-tMDPN8eTWxQL2DYQNFKU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

Thanks for reviewing the code.

On Fri, 2026-08-07 at 08:51 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Thu, Aug 06, 2026 at 02:46:28PM +0200, Kanak Shilledar wrote:
> > diff --git a/drivers/iio/accel/inv_icm42370_core.c
> > b/drivers/iio/accel/inv_icm42370_core.c
> > new file mode 100644
> > index 0000000000000..9f6c302e6f331
> > --- /dev/null
> > +++ b/drivers/iio/accel/inv_icm42370_core.c
> > @@ -0,0 +1,1251 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2020 Invensense, Inc.
> > + * Copyright (C) 2026 Axis Communications AB
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/i2c.h>
> > +#include <linux/irq.h>
> > +#include <linux/slab.h>
> > +#include <linux/mod_devicetable.h>
>=20
> <linux/i2c.h> already provides structs i2c_device_id and
> of_device_id.
> So please drop the explicit include for <linux/mod_devicetable.h>, as
> this will go away soon.

Will fix them.

> > +#include <linux/module.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +
> > +#include <linux/iio/common/inv_sensors_timestamp.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > [...]
> > +static const struct i2c_device_id inv_icm42370_id[] =3D { {
> > "icm42370",
> > + =C2=A0 INV_CHIP_ICM42370 },
> > + {} };
>=20
> Please use named initializers and saner code style. I suggest:
>=20
>  static const struct i2c_device_id inv_icm42370_id[] =3D {
>  { .name =3D "icm42370", .driver_data =3D INV_CHIP_ICM42370 },
>  { }
>  };


Thanks for the suggestion. Will fix the formatting.

> > +MODULE_DEVICE_TABLE(i2c, inv_icm42370_id);
> > +
> > +/**
> > + * inv_icm42370_of_matches - struct for all the compatibe strings
> > + *
> > + */
> > +static const struct of_device_id inv_icm42370_of_matches[] =3D {
> > + {
> > + .compatible =3D "invensense,icm42370",
> > + .data =3D (void *)INV_CHIP_ICM42370,
> > + },
> > + {}
>=20
> { } please

Here as well.

>=20
> > +};
> > +MODULE_DEVICE_TABLE(of, inv_icm42370_of_matches);
> > +
> > +static struct i2c_driver inv_icm42370_driver =3D {
> > + .driver =3D {
> > + .name =3D "inv-icm42370-i2c",
> > + .of_match_table =3D inv_icm42370_of_matches,
> > + },
> > + .probe =3D inv_icm42370_probe,
>=20
>  .id_table =3D inv_icm42370_id,

Will add the property.


> > +};
> > +module_i2c_driver(inv_icm42370_driver);
> > +
> > +MODULE_AUTHOR("Kanak Shilledar <kanak.shilledar@axis.com>");
> > +MODULE_AUTHOR("Henrik Grimler <henrik.grimler@axis.com>");
> > +MODULE_DESCRIPTION("InvenSense ICM-42370P I2C driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_IMPORT_NS("IIO_ICM42370");
>=20
> Best regards
> Uwe

Thanks and Regards,
Kanak Shilledar


--=-tMDPN8eTWxQL2DYQNFKU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRZbIB7R61KYt5yWsuslrbqDH4eIAUCanXZfgAKCRCslrbqDH4e
INUZAQCawRAvGLsTWntqQZ+HsgFTA+X5cKLIWAvT9GYI4RYIwwEAk+UV4s5WWIch
oHcmlyPNJ/SjHaayiGd/mzgn6FIGcAA=
=aDvx
-----END PGP SIGNATURE-----

--=-tMDPN8eTWxQL2DYQNFKU--
