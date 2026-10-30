Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793359317;
	b=5XgnxXyPQOEmkSE+36kptBAJ2oM4OvH/p8TuRdiFmaB0DV/ya3Fpsrbnn2JDKPBPmi2K
	 RhSlL+JO8/LL5dFCoZJt2Yj2zbu6uwaZI7BU/6jvJvNctzdIK2HsFhJAhf5VYTVSkrm0D
	 7tZC8b1X8siPreM1uWAG4jzzUJs99SngeMq6VGoHJwULRobNCvlaCJFU+ciq1KrfBwWwB
	 o89IDm+EEraMNnqkvjtyzybHqRp4P/vpPSQkn4BATPVc7TGMZF+zmJx308bY+Vm1HawKF
	 7TUcwnu18xFzYBB2uZKyl4bwoScsgm0uUZUTsf+SxIPBaieT7IOWmf/+NjtccW4rMMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359317;
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
	bh=2BJaCi+D2hZcczG0x4VhOzIjyohDj1Agw6yfXWvba9A=;
	b=Bh175XrrT6EagstusMHnp6ix7xpYIlb8nEMNcJHPGKKycROQ3o9cnZB5EnOqXCxl5YHU
	 yEGfnsvtBtJjf2s/vUBGZglDBV1HmkynIrxa1sPQHhLMPru43/HQ0NwSlSL2SVQqia+ip
	 2jwImcSBamgDNmoo3yM508YTj2Zll7bkr63aOOoABQTt28MMNSWHvrJCasK5sa9ZBO23L
	 PxJ7M5vlXF9gPllW+zDnDYgQDthZEq05U2vM97ZsSzFKJGdDyWCJGN0ygrjoeFLSgzOS2
	 t2XjhUNkkGUyW+wCkoSy66z3LYDZKeK1yOZle4mjMG78NERIp1ELBMzd7RsEt1vXxtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=gQrhHd+F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.66
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011066.outbound.protection.outlook.com [52.101.125.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B6606A320;
	Fri, 30 Oct 2026 11:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D9B6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=gQrhHd+F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emGPm4yAu48k/TlkoWysQwg8umercaNC95dOnDTeg+IlPO3GLRtHqpjqTiyLLCxBx/p2BL2L4iF9C9cZqR51qAtHV23SsoVL6aC9kXnzsROygEASBLbSJIIuUujkmgj78QkDiNk+eUQGpP5g/5bFuLEU9Y5mL1h7x2+R3Wy6zarsO6vQjBkkBqh6QKDu4RepZcNop4O6U2oi7jVHiNfbeYSvdpadWu55+qOX2ZGi28INwsQAgchHtB3ONPFPDm4ZvHO8UloiiUQlqC3m8UUH4gKgwLdycpCdGiLSdFJGLCm8L+ubeqjwKdEFvqXDzq0SkcsVnP/87odVzVrcVcOUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BJaCi+D2hZcczG0x4VhOzIjyohDj1Agw6yfXWvba9A=;
 b=gUxMqi6FAo6jgnU9pftVEw5FyTVF2M3/gmTcO6Hlkp81A4akc38UDdjw6U/SmmqiqElv4z/NgtEbuF8K8+1BlHPsunfMzG5AoMJhF5duNuEBo9zwrUJhTK/B6gKHNhjYZNUTFds+OJ2fTNnyc10+zlPrn2ic6uRzz0DwYgNOEkcFNCWC31+gIMQPZmBd2TtET37V6JEZTy5pCKqdRLV52jYg3tHPHqIXBHS8Ufos9+DM3a2ymysfWKpVyTx70dNHIACI/3MEDz7cp9R1Wly8GwjnrMK1DhMkN9BHefnmpqVK25Yt0XEFWeY2by1uueOclgWIVDOcLKn2Wkkf3fZoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BJaCi+D2hZcczG0x4VhOzIjyohDj1Agw6yfXWvba9A=;
 b=gQrhHd+F7xXXyPnxeDarXuIT7j3HSqnvFaNGOc2cDeLPbysj0y00St4ixeGmFpnDhObJAPt0jYNlnId+WhLVx9MgI1QZshc0FC3PXpjT86/Mi5CXitcYitcAKIBzUtoanOeFWSAPQvvtHB5ifDKOzgT5o2fXAnLSOtugI9/yp7k=
Received: from OS3PR01MB8667.jpnprd01.prod.outlook.com (2603:1096:604:19b::10)
 by TY7PR01MB14594.jpnprd01.prod.outlook.com (2603:1096:405:240::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 11:21:52 +0000
Received: from OS3PR01MB8667.jpnprd01.prod.outlook.com
 ([fe80::a7ca:1a29:beab:1921]) by OS3PR01MB8667.jpnprd01.prod.outlook.com
 ([fe80::a7ca:1a29:beab:1921%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 11:21:44 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Li Youhong <dayou5941@163.com>, Biju Das <biju.das.jz@bp.renesas.com>,
	"wbg@kernel.org" <wbg@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Li Youhong
	<liyouhong@kylinos.cn>
Subject: RE: [PATCH] counter: rz-mtu3-cnt: put runtime PM ref if counter init
 fails
Thread-Topic: [PATCH] counter: rz-mtu3-cnt: put runtime PM ref if counter init
 fails
Thread-Index: AQHdaF9oYh5OyXjmQkykjYtP08YTxbcV8O0A
Date: Fri, 30 Oct 2026 11:21:44 +0000
Message-ID:
 <OS3PR01MB86679508062A5C22122BED81856D2@OS3PR01MB8667.jpnprd01.prod.outlook.com>
References: <20261008020506.211566-1-dayou5941@163.com>
In-Reply-To: <20261008020506.211566-1-dayou5941@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8667:EE_|TY7PR01MB14594:EE_
x-ms-office365-filtering-correlation-id: 7ac8312d-ba82-4380-c2fe-08df3677faba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261026140227099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|261009223027099003|38070700021;
x-microsoft-antispam-message-info:
 cb91d4O5NNdjwARt6Od8lS98mk/vKcy4xTGdKT6xmv1txVG8B/TBCsae5uBmxPzq2Cy6/booI6psuu9bPjEOvanNVcmdHWpqRQzHWa1RaSOrnluu7AJtYd2FEcfOt/KozhTuVuhsP0w3XrNDEGciCe+lh9zIFLDaaE2y/i/fynq+d4n8BhqBzbJ+txs6x8hQNsvAJCOhPKnEXEzfakaf+dkSgwdK7t94TwFF+m1rjUULRMmgrhJmEyRu6Af0JXaBiGomR7E8g/HUWWrwEU1Cvk8GcJnDrQMznpzLv5hsZPM1sdqUSunqEEU70+4rcNLOILEj9jvbeemHsWK+A8QDp7TEcnH7Ts2gHo7sjD1iufFkD8bcXKxgg8jPIloWOS+7T0fUsWU/l6lIxvUKvhE3952rD6yozf2EMpkhxnl6bZzqmiK+kKuDS5Y8/J8NMVg5tn6w6rPb/qk65b7zbY/4vvUcQPkBbN/Flwx6Ib70d5G+E+e9Sju6I78x0KJUqa+03onl9vyetta/GyMcS9X8GSxnCgmQwzcbrXpow9p8EhDQPKkibLpjw7wdXxhzkxrhRz+wghnxUGIqQbv/b46rDRTevLprpFz40XymQFuWLTkkfrMBP++NtYal3fWDXj/WXhZP+OqlBmIJnljz1H5R77JAbfjgfDh9C8PqBnYFjWc0sDtZHGdZtTZUYODHQVt21omGTP4AdhFwhgby9u3GuPBIIVcfwEZGfPgjRCorkbU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8667.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261009223027099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?97iWODCF/MbDo08FKqbxph9gqXDq+ky934WWImG6TpwiwSuJEdwbXN7C7I6r?=
 =?us-ascii?Q?l1VtgF3MC+kOvMRFYfbEWLgXMUPzDDryOGN4YAM+D0cwMRQA5B3/w2I9Aw+p?=
 =?us-ascii?Q?hEO+fW7vLOJ20k4Ok/8stFCfhOsTp62YH9+pW2l5BEgf+3wBZepvI7q9bHdH?=
 =?us-ascii?Q?gASFqMoCQZ6ytNYWI1rA5MeMKkH8xmRSqF8gUtOgkBkpqmVVlbzvk3GWUwsz?=
 =?us-ascii?Q?mnS2GQJqUOfN63ym5kMG1O5zF+72Wg+FSpbPVizf4ibJ/uidFfTtFoBOg+fo?=
 =?us-ascii?Q?aMEZXqnLsfAtwuYzMzTbUEf1mJ5Y4Hfm1FgWpPP5X5ohNgMVehbMOJHrGKdm?=
 =?us-ascii?Q?56p02FdNhHSne9PHBclzNejKzh+BnCPsUS8QsWPPbd0ZkNPiurnwGNZggnXY?=
 =?us-ascii?Q?McAVWCVnOP/v3dfx+c1/Bb70uUhPLj3zdGT2GUiB2DZZfUzGMN0Dl5sFNMuo?=
 =?us-ascii?Q?trb59o2QO2eOkw3IySi18m81+U8WblEtFzTjztxyaMVPeN8CI3DJU0LJChUb?=
 =?us-ascii?Q?1yKcdvIDIIN1KGaG3QTREUFUnI5tnHq00wh1S6G8xd/obRgrtVPNlYNN7pov?=
 =?us-ascii?Q?9GVzPpcs7TrrC/Cc00OMAqFp8UgUbyXzr3q5Kxo9DkLMFbVQybs+lH6jSAtj?=
 =?us-ascii?Q?Nn8IrAxJ5hm9TMOXOL4FajwfOpFG0TSPkPzeHrlF8q+EB3RvcLczThUpZyvq?=
 =?us-ascii?Q?nPPbwWgK8p+RY2MLKP2RhjumdjbgiTbt0WTUJzS+r0C0tgDAF56/D7osZiDU?=
 =?us-ascii?Q?ybHUeF8TpEahM4b8oyX8O9fwPseYW0dDpIYvJZYVD76gZCK2qE3n6NRjolNv?=
 =?us-ascii?Q?EFA/cbKIziEp1K0/U20dcs9ieRdcOzkflqFcmtrvxccr3mSxIDZkzw2Mj443?=
 =?us-ascii?Q?GAaqa4WXtTld2Pu+cJqy23NP9rS6q33lNP2KTpSrGOKKpzbnvSKFz3mA2Qp/?=
 =?us-ascii?Q?ngTdiYonc118Y7eYebwFAUWYoATOJ43wt1VDu+QeTTsu7lUOQieKGe8ND1z6?=
 =?us-ascii?Q?IF6b2od0bYWFalaTv6rNNP4C+f/ALYOBQNk939MMQn/fZKDhb8cqHq2UawDP?=
 =?us-ascii?Q?ZZln6KrlQ1D5OafW6DrewnRZxlJAKIB3v5h9/wzGr3VbnCkjXMqb+7Ad+Z67?=
 =?us-ascii?Q?67UNpEOhHX6SVXwaY9pxWKTY//6VGgu3cHTXRDSBDqidUjNlxcgvyPq2QNfv?=
 =?us-ascii?Q?c+aSQZIav6AouTjpaG5kv5Rok2Pshqx7Ps8zHENR2c+SeSloxP8/hsu5cB4g?=
 =?us-ascii?Q?ALNH8LXnwZVULCv6CGH4FWxLrQ4XE2pAebdN1k6H3PfmXu5czO1KrL40wja4?=
 =?us-ascii?Q?QgzvTAlcq/dEs1V+gnT5AKOA6aVoJ+1jGqVNY8Wn0/JsTv0p4QZD021/AhjY?=
 =?us-ascii?Q?l8ecN2Z7kR0gZemcd6GeLGF+Y6v4o/zDB92TtRpA6p4dZtZbqQU7q6r3NoJb?=
 =?us-ascii?Q?Uhn6c69P7Gh1ZT0w/UdMAGWMZboxKcp587kqApqp372OUlI2NZR+N2MvmZaG?=
 =?us-ascii?Q?qujV2/DgmcMjkGnJwoCQqqblOYKZiNMz/5KEcUXuvdsHJjTHzrsqngQTK3TF?=
 =?us-ascii?Q?f7qTQhpWgx9LlJpZidJt+3yCQXxioYN6Wb3/bFct07OzV9hDcBuTxqUB0XBD?=
 =?us-ascii?Q?XqvAiGSlBcq6c2h+H7N5qlxmqomYLMTOSD1Ovgj14sdX6YHTbvqM9ehyh88r?=
 =?us-ascii?Q?/JNo1YLwPtRSTi7bPN4lbYUHrrgputCwI+4oTpG8i5eqaMu0MMHefxLbchgn?=
 =?us-ascii?Q?+b00Ac6FV2nm2+WQ4M99aD726pJbnLv0LPJXNprU5R0CNBBKtc1R?=
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
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8667.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac8312d-ba82-4380-c2fe-08df3677faba
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 11:21:44.4693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xErYTAzkWcgVWbYoFbbM6vqBRLLKOv+Al2Yo+0LI7P1KvHPsceGTRGG6BBDyY+TkJuRC4+W/CKXxNoKBVxiuva4MAclfqQyBI3SsWHS8LjXN3c5GqVw3vXqyV1Ueb6Zq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14594

> From: Li Youhong <dayou5941@163.com>
> Sent: Thursday, October 8, 2026 5:05 AM
>=20
> From: Li Youhong <liyouhong@kylinos.cn>
>=20
> Counter enable takes a runtime PM reference before initialization but
> only puts it on disable. Drop the reference if initialization fails.
>=20
> Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>

Missing Cc to stable.

Otherwise, this looks good.

Reviewed-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

> ---
>  drivers/counter/rz-mtu3-cnt.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.=
c
> index 7bfb6979193c..61fbeb122851 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -506,8 +506,11 @@ static int rz_mtu3_count_enable_write(struct counter=
_device *counter,
>  	if (enable) {
>  		pm_runtime_get_sync(counter->parent);
>  		ret =3D rz_mtu3_initialize_counter(counter, count->id);
> -		if (ret =3D=3D 0)
> -			priv->count_is_enabled[count->id] =3D true;
> +		if (ret < 0) {
> +			pm_runtime_put(counter->parent);
> +			goto exit;
> +		}
> +		priv->count_is_enabled[count->id] =3D true;
>  	} else {
>  		rz_mtu3_terminate_counter(counter, count->id);
>  		priv->count_is_enabled[count->id] =3D false;
> --
> 2.25.1
>=20

