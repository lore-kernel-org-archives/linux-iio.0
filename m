Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794924359;
	b=aJqbgFI4wwyp52HmKQcvSgnWJRxOY3Ui5M5F/9KLF4s4K2GQM1h5X4p34EGTJdfeSYUA
	 ty2tckWwgEAG98mD/AlNhSyHR2fvyBQPUnuUiLlOwHg+YiNpfgzi0gVK9d40XmkFh0AdQ
	 ipKr1eT5EHKJQvGO4C6nEc0ekXqHBfjrgvE6z2ikV04TREDDSbiOt2mYsv2KsCt+vL+35
	 zztc7LiUZQfb/OvocirRC4//WkoLOmQSbSsVhZudcdIiJSfVDRekZsgsh8CYAQqQxPfIg
	 DIy2zXTgcM3ATVCvVVagWJb9wedSY7unwcvTIlBQXncGSirFCdO9vxgNGj1SVIgbKJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924359;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3T08mIJn1vfbW1o6/EYLIzv5b+NBNiNXoVvG7DrEVio=;
	b=WnbGOuGvbjGQwhLF90A+UIvSZCHksAWOu6Tj3NmetG7UaEYKPzo23qxNrrCgwbbkhRJG
	 lsnpsM5W5EWRVssuAsyIfWYsoMth4w2CGloS8ZEJkPab53eFdCPWNF+9UHqrGp3rn1Z0G
	 As6z1AbH9v3ljLMrf9tIMX6y9ZqaV7VggTIRoUvOxxBj7rS/bRX6GWkkNY4pQJriZvku7
	 6FkAz+8+BU2EPx0HKdRGSz44ZmSx+6+bFnGrvmrEBrHRUX5CAUhM6BYR7tFyrIjzv76SU
	 FOXBnui+lSwbiPZeebhauj2c5mg20Q0SyPRFaXJ5v+b8c3xMZP9eqiLGf4JfuJm239w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=NUqzJIYS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.49
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011049.outbound.protection.outlook.com [40.107.74.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5D8606A334;
	Tue, 17 Nov 2026 14:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A5D8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=NUqzJIYS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnxG0KU4p4skq/9/5wHtt6z9KNTK8GwFxs/LrdVfLM6fldJskWsfHpM1JCDIvhP9GTSyZB9HunUdvphTAt2Q+YvkpDBDaipYzayHfz0blLW1dLA9ZBfpnQquJHzK1JUdy515jR05eIxgFbwBArUUGi1SeHd9tDTBvFcKOKY0GarWQn0om0b+u/03NHiTt3tbvXbdGUr077JbyXjlM5gKA3MwVZEvkU+w0ulXvBTzJR8Jd31dYQdDWA9cY7+KI4UQ/OMVDdPQEsfTznzxK6u30nh38Fcpmdv8nI86ipGIBUAYj4ypfUv5Q8Tci6nejsYWB7F7huNSMokFUfPrOJ7LCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3T08mIJn1vfbW1o6/EYLIzv5b+NBNiNXoVvG7DrEVio=;
 b=u3aqmjdXO9KK6l4qnsCGqsz6ZaZOjBKKrEMSHkNN1C4+A9RiYWd7gg6DmBrnWDOB8XaLWTLCXOB9WNwR6VQ1rMh5jFMofnytUlhXeuPQtbczh57y8xZjH9h6iu3IcifA1IliGMUwZPbW/AxKY56hLa4NFwT5f6LzEvRs6XViRqyd3G/OZ8Cnxupu59Or+2SztXKnkB5of/nvkWL+22XVVD8ExVfyB+0rKS7Ifd8f9fBDGLvkoNPVdt8juXkpZV04z/txJnoajS4VeZ4WLYju/ZVT5jtUXdFMYx98IsjVxh9PS1aVtmU2y/sFBrAOrJfCTqjO8AOJnfOThXWKw7sfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T08mIJn1vfbW1o6/EYLIzv5b+NBNiNXoVvG7DrEVio=;
 b=NUqzJIYSZUXJl9wmOQcwWNnpHNVFhp+EWWMgE5bXAuvb8o/ahhy+zAoD3pHomyNJtHVh1BGcTv4Z+9mLdDEOkYEw209Bxt3QdMQPyuRR97y2ceRTYMm0uoIpFxTCHHFef7gF9UioRZyeMc9gYhBGuEnN7a+a87t/MJARTairo+g=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TYYPR01MB6553.jpnprd01.prod.outlook.com (2603:1096:400:ca::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:05:57 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:05:57 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, William
 Breathitt Gray <wbg@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cosmin-Gabriel
 Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: RE: [PATCH v3 05/14] counter: rz-mtu3-cnt: disable channel before
 releasing
Thread-Topic: [PATCH v3 05/14] counter: rz-mtu3-cnt: disable channel before
 releasing
Thread-Index: AQHddn5AP7gm0QbjrkSoec36e+oU07cyTHkw
Date: Tue, 17 Nov 2026 14:05:57 +0000
Message-ID:
 <TYYPR01MB6603156B41CBC5C854A78280867B2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261117102607.2504551-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20261117102607.2504551-6-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20261117102607.2504551-6-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TYYPR01MB6553:EE_
x-ms-office365-filtering-correlation-id: 8cd141bc-a789-4f41-8c73-08df44b3e6e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261021123027099003|261028144727099003|261026140227099003|38070700021|261021121427099003|261022105027099003;
x-microsoft-antispam-message-info:
 alnQ4YAEfkEmRJhTBlEin1Pqm5ZhTFTPENoFmsjl9WcHd3D42wRhFH6Ca/XZ8IwzdtV02oNXoB0KCNHnoWkD8t8pBsu/67t/j8kcQpQqPoKhREj4tVyHKJIK2oJOmLAEjKIbRJKCGoPXfm8BAMF2VymHOatl6TN+/cil3TYIO2OZepwm6+26iNLT/RXOsY0bTzNmozOmt8UTMaBCOGBv5DfyYDxL4/pPa7eWVnUKcftPTnpRJfKGHYxXdczK6G9EzfTkn2dqc9lvJCyn0RBNiPOyprtaATM4t65+gqc98kGTQTpqcR7qTKwOO8Ti9dpsGXZFIuzBNx9rFrbWZzwmbfYscr4OyM4YTwmDbDBE5FJpqjHs45SgsQngk64oBncgIVJFK2GcP426W2F88E4s6bErG2Ki+EdWETXGhb+QNgzCjus947SjesAdVv8Jt0cggG0HUXfcckQFtBzU/oFCLXab4n+9ZyFDYsnbKLkP8DQpQhjKKSBP6PIC0s2m9mImiGYY3DfeFxN20RRGo8EP6of8GMzHMJnePTbjzkpcjqUur4pbtSTBprPpK/DCAHH0QyEvhv4wQQ7JXxSCLAkOZd0lKn0OEbVG0OAhWqv/jtGX3dpYK7YP3mCDVL9mPiCvb7RBg0+c0aTpXYJXTRXyxrh0sUH9Axn+KJn1zjPARyi1tvtyR1HXR4SwR1Jhk2hVfz3X5plzfoljR7kxk5elBXxVefd7MnFHR4Hl7F5yefA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261021123027099003)(261028144727099003)(261026140227099003)(38070700021)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3IxsL/07n5WLXXuMpA0TwYWClHx67crBeTyqve0FC9aHh34cmR7JcVbnoghQ?=
 =?us-ascii?Q?bJSdhWxM0uR6Q0yc0YOltKXvNg8b4C8RqDs7LqkfsR48mYi7BnL4vlkGW7Yi?=
 =?us-ascii?Q?0OM6CJtZE/JShy2kJcDSlSsMiiQ5b1MOoeV72SV9xFSo+uoelR8uF5mGmNeK?=
 =?us-ascii?Q?K+kFkGgtORJA7LmHgiUy0ua3yxMOxAhDn5NXbxeaEqJfG3OUT83R98ABmoYw?=
 =?us-ascii?Q?Y+wDsAxOLyxXmo6yzw2e69fASG1KxjwgbBQbCnhRO20nM01BimMp5mkHRQPs?=
 =?us-ascii?Q?nwAU8FBaKk7vnhsiQFjaTqElcmKBNnF599wW1Dcd/YDgU5XudxWklhGfUIpz?=
 =?us-ascii?Q?0nxjMh8cV/b/S6QtmhxbQi7qYff+klCIM6WiZru8Ufo5KcIEuHyABNAfHrpd?=
 =?us-ascii?Q?wB88q+eDqe7RWs6iHUfUzS2plYM+B/vQbexsL4TFdqoj3fWXuC1ItyQL/766?=
 =?us-ascii?Q?hbif6rZtpQIOnvqidZwT0YstXTBi5XbKuHNOYzaYbwGru68DgMZmPG2tyDfY?=
 =?us-ascii?Q?AdoNElL8XzHMc6RMHUSjTyvUg0+rXpsBA50Td1I10nZ+mzZ3cp5OLew3LgkW?=
 =?us-ascii?Q?U8FWG1n6j3WdQUdYwTmkajy8Z2tdfHbrfldU0LgxA2Yu7mCqyYIDs1uFQ/Wj?=
 =?us-ascii?Q?OS3Y0oimKq52dRQv4OUoPCDS9GAlg8TKDJ7Ks0DY5HvXVVrvHi4UjsAOwY+A?=
 =?us-ascii?Q?a/m+V+YgVBpoT9oCu3Zy/Ji5fF3X5YA67bfrhnrqzAthYiC6vAI0WXxrKNTa?=
 =?us-ascii?Q?HcwyZ3y04g91mpGJqGnD10MQlEeVPNF1xmHvuJhxoaaZmQ7CFTJE2YyF9xPy?=
 =?us-ascii?Q?GJ7XrRMJ5CLymHjfAihriOOYbg4YSxK2U7YSaTRJqlxvnHveNbMt+/JYk+aE?=
 =?us-ascii?Q?nfNwH2Lao5dYGw9jyYGzhtZ/QuFunvs+sCqgC7hn9tfQ6z6Su+fNq5B4oSfI?=
 =?us-ascii?Q?6tYzEU0IurhiSCbpUd+lFw4woBgn0atWQpRMVAJT9efQK44k+LD5L9+QBjSL?=
 =?us-ascii?Q?d95KF3Oq5ZX/dVD4CdTQqOhEoq08LuNc9SJ1CgI9K9xKBAaSD/gcFYDz2+K5?=
 =?us-ascii?Q?xgml+cGB/Hu5PNITmjssBxBiYV+nynBQnmQ33MprTCZsDkhHQWhcZ208kIY8?=
 =?us-ascii?Q?P8cP468foZi1E2m5fZTRV7wCUT1EbiI3DGvuZBfghOCrADkhR40K3VE7qdr2?=
 =?us-ascii?Q?4/BRSLBzOZ9jff8ItMMPfNkXnMTyC5hbk1SRZflg9R3GnmrctgzQySTJE0w7?=
 =?us-ascii?Q?g+l9EHMKxIufM+hxWCDSwPrx4r6iK7F6alg/NaU0RvSKFRH6AdMVg3rvG9mY?=
 =?us-ascii?Q?5SqWuxVz4Y2HqsUMsVjHZYfgk28baZ7XtvO3y43MN1z8PuQBAagOQ2FB+J4x?=
 =?us-ascii?Q?3xMtf3M7GYs0dT4Cb8jAFwFM6wtmaJXWwEh5oJSdg/UUcK8A8CGUv+KrPRcm?=
 =?us-ascii?Q?PcHZ4a78EAVZ28eEtiFCTG8MTz6JL+ePmhta/54P/bYfJ9/lcbroH7QKsUwc?=
 =?us-ascii?Q?lOqTZD861AT6ZlUQ6SsNa9RRYAvivf8ejx1Dm1uQrYSYWrDnnDOimyi29sY+?=
 =?us-ascii?Q?fXxcccRUOWZ2A+s/GkzI7y5/ufJ/BlhYZZWdcLvQzqeW0niF7HFkCN2UyEIF?=
 =?us-ascii?Q?/v1imAs/ayZiTvqRcJeChhCabGAIV5K0E83mAKEuhjob64lmw+v5mvUtgDVU?=
 =?us-ascii?Q?RzNE+Of8rDoABjoPc9BNtzmm3NvYFZ/93V1Kv3lKFMws+6q3Q73yOW9vtQ3e?=
 =?us-ascii?Q?YiPTV0zr0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd141bc-a789-4f41-8c73-08df44b3e6e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 14:05:57.3696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJyFuiwhtOnKgITOwORecjABdKSBbWj+BroIscNPFJ0MNoYXPUIPdbi3LES4ARoroKaJT3/1Cl9iOvWW4617mpg80kyR2Oe8tdacWhz4/Rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6553


> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: 17 November 2026 10:26
> Subject: [PATCH v3 05/14] counter: rz-mtu3-cnt: disable channel before re=
leasing
>=20
> Releasing a channel marks it as not busy, allowing other threads to claim=
 it. With the current logic,
> it is possible for another thread to claim the channel before disable is =
called, since we release the
> channel before we disable it, causing the channel to possibly remain disa=
bled while it should have
> been enabled.
>=20
> Disable the channel before releasing it.
>=20
> Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

> ---
>=20
> V3:
>  * no changes
>=20
> V2:
>  * no changes
>=20
>  drivers/counter/rz-mtu3-cnt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.=
c index
> db30470215c2..23dbca3b5cfb 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -456,13 +456,13 @@ static void rz_mtu3_terminate_counter(struct counte=
r_device *counter, int id)
>  	struct rz_mtu3_channel *const ch2 =3D rz_mtu3_get_ch(counter, 1);
>=20
>  	if (id =3D=3D RZ_MTU3_32_BIT_CH) {
> -		rz_mtu3_release_channel(ch2);
> -		rz_mtu3_release_channel(ch1);
>  		rz_mtu3_disable(ch2);
>  		rz_mtu3_disable(ch1);
> +		rz_mtu3_release_channel(ch2);
> +		rz_mtu3_release_channel(ch1);
>  	} else {
> -		rz_mtu3_release_channel(ch);
>  		rz_mtu3_disable(ch);
> +		rz_mtu3_release_channel(ch);
>  	}
>  }
>=20
> --
> 2.56.0
