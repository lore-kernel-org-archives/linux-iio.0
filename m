Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794925684;
	b=kZsYRHge8KeJRBLcG3oOXso1IjDHNIO3icZCqeAa76BdXuBFYUWCWXet7Su+uisefRXB
	 qguAWYUzePtUa10a5zGZf5SnjVmyjXZN5Q3uE9cKLoIg/xx5rrf8OXICZ0urPOMi5jygU
	 B0WxDbiu7S2uaqpESLPWYFxw5dsyqQtUm5etN7JkLAraxnE6z0Nzuy0UGLfNb7JnP+WNg
	 fCIWDueviv719gJkoI0ZBNHF6ZmpTHFzvxzYuuOQvlGcUURPEbu9ZtHtmE2IsKODcP151
	 bm1W/EXgoh1hzKRlGc5ykDuqTfeZeVmQBS0gVJ7QG5N8CV1ldL56T4eZ/BEwLeB5+KQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925684;
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
	bh=cBA2UNhpA/A/hKxoOAI4eSAcMtv12QYzX87xrmPfU+g=;
	b=5J7N474NzZaF+xs51AvaVZS9H12mPSI2v127FiV5jjgdnHfseyBcCYkd2Cds8yoN6KSf
	 0EVaS2gFzJSy42lOU8FPEtTlUJxpcXok+mF1zsITm41Lrg4UEQFkuFywimNF10TKV9xG+
	 HtRrPvFfkGXC/GdRcj9OLgIzrR32mOD26Q4SK6ylKaQS7sQ0TJATfi8SbHFYo4FrX2nB8
	 Ix7H10k4z/x/re0o9CfV1q1ajxd6I1Vog9M/VjsYK4UZQ6SCLAz7gkrxJif24TriRn7Rb
	 0CrC62EQLH0TZUMfQwXNAVZ7fZxGVw/X6NdWs+adKA0jezvzMCkTD+wPSlkjtMGeBZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=eOtzmi5B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.19
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010019.outbound.protection.outlook.com [52.101.228.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCAA606A32A;
	Tue, 17 Nov 2026 14:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECCAA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=eOtzmi5B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=se1hoZZl8V9RLop3/LCaUarH/EVBtiDosZ40s/s1/HtvRjeJ2sca/9Av4IBEGDqOvv37Dkr8SGaM5jPmyBZ7wI+eJyUNQHVPfZGw//HqmKyH2o2PzS+mdAVhLa2ezhJJpgwYuvh+XpH8zp7B+wTwGxzL5rtPG5M1h+wgmpHd4bbDK54C6vvLahgoKE4DFWZLwhsIxdP+JGGhoqk94bbo6/mPq41qVX0YnO1F9DUZSrIjzZZ9wPtIBZ7sO6a00HJnq7uBvcVo7mSbXeZnmCyxCFicNwEU0mH/y+ZBAWAyNiBomVqYfL/7ninh7eUb4JqdbC53N5yf5h3L0UqueUlfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBA2UNhpA/A/hKxoOAI4eSAcMtv12QYzX87xrmPfU+g=;
 b=ROBgrGU5zrQC6akOC4A3IWui+4zPEzdWgEgY4Pjgc9+rUsUFg9oVNC2kV+5pYvOhLKwctZ5y6DfIhRctb/5uTBu4Hmk1CvLLNfhPDmc/WtvuYD7YMjq7uZYgRyP66FgPhF1cC3nYYfY4HAqSZGHDmQA4LvZgnClnuFQx0BoAuEwUY+JjruE0Gon1UqsNQdbw4imiTkbvq4JP1dLjhwDp0QE2+L3KB0s4TGfitIu1LeAfX/BTwCh6vv6nszOyluNu3iefLzrWkFnkpgheRH9otRzcOEZkOeQf42e9OezS8poSdn2DB2b6+3cBYiQ9r8IgiyZrebfFLx8azZkKq/Bbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBA2UNhpA/A/hKxoOAI4eSAcMtv12QYzX87xrmPfU+g=;
 b=eOtzmi5Bb13hes+2dn10ExK3ZOTXaqchFhATUAXvkYAEO90gJWTufFrKoFW4Cd1Mw8ImADhNV58SiEWpPr8UPlozBtqXCu10UqhDPhYwM1PkhHzftsdYRGEmKVi+LnHnnuolvRQfZ32+jgJwjOPjxy3edSo60Xg1T2bW/YB6N/I=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TYWPR01MB9724.jpnprd01.prod.outlook.com (2603:1096:400:231::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:28:00 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:28:00 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, William
 Breathitt Gray <wbg@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cosmin-Gabriel
 Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: RE: [PATCH v3 12/14] counter: rz-mtu3-cnt: keep cascade_counts_enable
 in sync with usage
Thread-Topic: [PATCH v3 12/14] counter: rz-mtu3-cnt: keep
 cascade_counts_enable in sync with usage
Thread-Index: AQHddn5NlZzj1PXiu0Wo1oyncwbEpLcyUbLA
Date: Tue, 17 Nov 2026 14:28:00 +0000
Message-ID:
 <TYYPR01MB6603AC9AD34C12A598166EC8867B2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261117102607.2504551-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20261117102607.2504551-13-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To:
 <20261117102607.2504551-13-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TYWPR01MB9724:EE_
x-ms-office365-filtering-correlation-id: 1f4cb4f6-96f9-45c9-ff20-08df44b6fb59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|6133799003|22082099003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261021123027099003|261028144727099003|261026140227099003|261026121527099003|261022075727099003|38070700021|261021121427099003|261022105027099003;
x-microsoft-antispam-message-info:
 hQcRliz8nzEIQaR0/tsRa0/1mVtoxyrGBVmJmCTC0Qw/pMQcTZ/8dinbCuhQDnHatdBRA+LdBlUewLgGL7+ZgFSnFR3a1fyWnaIk9E0d4nA8kD7V9lvtXz1t5E12wn5WazrFtF50/FmCqSbUXx49L4tyV60yvTDhd56/4V/djZ217JC3273lPJkeqkoly7KFUe7QIdf39i51zPQGp0oZIxN0IxSrwnQLzlJiSNOLH79grWmVKwMGJqOBmk6mUpAkZ2GTrDvgt0jlZxx9YI7XtuIAuJ9ZFLgr5ok3F2zQetVWhl1wjnT48QE4q5/Ea6LxTQKS6hIb7nVNEHvvELUwO6TK++UqBJjlVuxM+lanJLXIWQAl/pun1y+aVSFsNh4g4nwIBBM1MoO27QQBEs7BU2GZWfzAv9xYYLbwihfIpQPxaBK9xmIOqnMt1CLOowtTIsDP8fVjUcUOhjVpFsgMQN6MI6f0YhteLjdeYHPkXGBtj8Stn/B4G4AlQ468kMDYcJW0guw1HPuRuz0EipBFJQIjkTxjTpEQow9s+1catS3+1t/GskbggWqrboPDUwcHTL98OxqEpu3nlFHCyq1ZzRck71ebQvk2rT8J5vWLo0MBUdBEzh5RFlhfVfDEbpZb3CxlTPGaxsCbiwGA0YUFV5KuI7HUsKUhnVDGkZeGrItZ9tYPiSFUSY93zK31mWKHvFxxn6C8eT3UMPCjPMccv98DucY9LwEvG6sFruBDJM0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(6133799003)(22082099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261021123027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022075727099003)(38070700021)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6o9EZYTFFXPxhhWixVh/SXQG2ja4Vu/f8VmCjErZNX0r9cNPskn+NlNK0x?=
 =?iso-8859-1?Q?HPiv5zBh2MmS9/ysQ22IAo9SomkrRwFqYyrnOKWTfRmyASFCirMh/FYteE?=
 =?iso-8859-1?Q?TH2eZpPwZWFVnN08cH0zOltklXxaq9IUbOKvRH9bJwr+wFKRlxwwg3Y46Q?=
 =?iso-8859-1?Q?HnYdH6J9pwe/sz97W7n/6YSTuJ6hol/r0YH1PX+6dODSWxRVcPY6jIfb1X?=
 =?iso-8859-1?Q?CI28mbPg4Y2Y+ACe3gUZS39QEciLR3yVku3gFCS605Aa/ysNsA55w32fz2?=
 =?iso-8859-1?Q?KVrBj97r24m19lLplulUpoWNgRIaogGKLCe9QmrFT1Us/xRiIdlGH3KOO8?=
 =?iso-8859-1?Q?eeKxTS2B+5WzxsfOuoRw5ADOvbt295fitR8oT7wyolxud3uGeRVh8Y+zd8?=
 =?iso-8859-1?Q?SdNPMjrmV+v4JawKj+sVgg+DnYrYDiQ1DbQBm6lp7S+55ZCOPwSB7eJpkA?=
 =?iso-8859-1?Q?iM9WN2uMy292ZEFGGBJ4kZ4exX7LQbeiub8nzbGmmhEtn9E2O7D2zThOh2?=
 =?iso-8859-1?Q?6EG9UCRqsroMTU8c6zycvJNQbRvA5ObtJCjECqPYLwaLXecniEYhlWjedJ?=
 =?iso-8859-1?Q?PvXRSRoGxx+74pO5yV85myYVKlEXVMY8py1waZ+vjJXHWomZyiC+KVlgmG?=
 =?iso-8859-1?Q?ayr0gPCHcYRFln52yoXNaMzPzJ/qmTxHojFw9/plYB/Ei6jPTDF06+Y8EP?=
 =?iso-8859-1?Q?X09rMsA9NfWTVapSYx/PF+fIIUNgaWgsW5+cm8Siks6SWMNl2gs5FKwGIz?=
 =?iso-8859-1?Q?uge3DjsvoIo4TR1CakkM+BPFDmWO+jzbSITo+AEHdbD7KXb6Hg6GJgEhw2?=
 =?iso-8859-1?Q?4XF9vAQ0GDcU9ZBB1ZjR8k0qxD4W7oxjQIqF2f/M6L8+v5uzr8iXf1DFZB?=
 =?iso-8859-1?Q?c99j0V8ZGk2m32yJG9hVXrwOtMk1/rPLRYxFkpdkb+LnZ/W/FdjbkASPy2?=
 =?iso-8859-1?Q?gjeVGUvPCWBTKk3W2afNU58S4UibMVK1mq6RI3xspETf2jntPoWJWWEgee?=
 =?iso-8859-1?Q?x6uCuv9gDJsG94mihD3gHW8+jizqtRJoBeGEQwQoQYBuRfAwgdWcg0UZfz?=
 =?iso-8859-1?Q?HJoVX23fcD6Zy44iJLadcC0Trutq7vW5Vah50Aasn0GX/UvtNXZHIGXg2L?=
 =?iso-8859-1?Q?OA8N3nDSv2x+N5K74/lU3BXgeP15OcTt0YZ5o8mlE3qscY4xEmKRdoCoV3?=
 =?iso-8859-1?Q?fqPgzi7WstxUFLUermDuohbFP6OGto2J60WTTHwhHhZ8nx/PROqGJszT1j?=
 =?iso-8859-1?Q?nzwHipYPJ33qbzgSihtfZC2/YlHSqla3eGkMaNc0exUy5tY0n2qTn6C/wt?=
 =?iso-8859-1?Q?mSQLN0UiS39aDUkeupfnyTujlm5dUrr/pWvfDmSHdZJ3b7VhYcQ4Ov/U5y?=
 =?iso-8859-1?Q?bxHEhsaMcDgiYhNu7wiq+/BxYD5AGAeW4yxw8mvtcwTzCmWHbGfOS9FgxN?=
 =?iso-8859-1?Q?/KB3TARf23mr+PLBOZ2Ztp0P2X1DpbRTsiuQzhns1kEuVC/6m8CtfXuNMg?=
 =?iso-8859-1?Q?8sUFt/LnMxhlZOIswJqs88m+tVW8cz/9TMeMVmze9zaOY429aQQDgVULuT?=
 =?iso-8859-1?Q?yTT8F4Sg5W+Bsx6ttGaPNGWAh3tu7MwJDB948diJ9GjtX+sllPHSjH6hWV?=
 =?iso-8859-1?Q?sx4ztofSYySUCyFn/etVJYnwcuWIpL5HrcwyUc6kGIyTpXT8+La8fnLHxe?=
 =?iso-8859-1?Q?B7f1PaAnCJ+f6fSmFsxfn/oMJQKavf9O70alGi9DaxBLR7gBC6YZJgoW4v?=
 =?iso-8859-1?Q?vkp+eFlgoBLqoiicT5SqJjCLbI0gh2SnDfYMnoj8lnNF5W7ExCHshnC3WO?=
 =?iso-8859-1?Q?hJW7Fv96rA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4cb4f6-96f9-45c9-ff20-08df44b6fb59
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 14:28:00.1019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YS4mbStRVOT/iykVw5gxXi4ALVDl4yOFX7Fpv6eD/RJ4ykmlrhN4V5BlzH9jSVwH9gLgcUkO8F39o2NXEiDk5s4Y1vVXVbc1w4eBpaydvwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9724

Hi Cosmin,

Thanks for the patch.

> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: 17 November 2026 10:26
> Subject: [PATCH v3 12/14] counter: rz-mtu3-cnt: keep cascade_counts_enabl=
e in sync with usage
>=20
> LWA is enabled/disabled by writing 1/0 to the cascade_counts_enable sysfs=
 entry.
>=20
> The 32-bit channel cannot function without LWA being enabled, and the 16-=
bit channels cannot function
> with LWA enabled.
>=20
> PWM mode cannot function with LWA enabled.
>=20
> It is possible to accidentally leave LWA enabled while trying to use PWM =
mode, leading to unintended
> access to the TGRA or TGRB registers of
> MTU1 and MTU2, which should not be accessed while LWA is enabled.
>=20
> It is also possible to toggle LWA while PWM is enabled on MTU2, as the ch=
ecks inside
> rz_mtu3_lock_if_ch0_is_enabled() do not check if MTU2 is busy, even if th=
is setting affects MTU2.
>=20
> To handle this, write 1 to the LWA bit when enabling the 32-bit channel, =
and automatically write 0 to
> it when disabling the 32-bit channel, to ensure that LWA is always in the=
 correct state for any
> possible usage.
>=20
> Remove rz_mtu3_is_counter_invalid() checks as it is now guaranteed that L=
WA has the proper value if a
> count is enabled.
>=20
> This also drops the busy check that rz_mtu3_lock_if_counter_is_valid()
> carried. A count cannot be enabled without the underlying MTU channel bei=
ng claimed as busy by the
> count driver itself, so the check is redundant.
>=20
> Keep the cascade_counts_enable sysfs entry for ABI compatibility.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>=20
> V3:
>  * no changes
>=20
> V2:
>  * add struct rz_mtu3_cnt::cascade_counts_enable documentation
>  * move rz_mtu3_set_lwa() call after rz_mtu3_disable()
>  * mention the removed busy check in the message
>=20
>  drivers/counter/rz-mtu3-cnt.c | 95 +++++++----------------------------
>  1 file changed, 18 insertions(+), 77 deletions(-)
>=20
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.=
c index
> e3578850f024..07dd7f588911 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -71,6 +71,7 @@
>   * @timer_mode: Cache for timer mode values
>   * @mtclkc_mtclkd: Cache for external input phase clock select value
>   * @direction: Cache for direction values
> + * @cascade_enable: Cache for cascade_counts_enable value
>   */
>  struct rz_mtu3_cnt {
>  	struct mutex lock;
> @@ -81,6 +82,7 @@ struct rz_mtu3_cnt {
>  	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
>  	bool direction[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
>  	bool mtclkc_mtclkd;
> +	bool cascade_enable;
>  };
>=20
>  static const enum counter_function rz_mtu3_count_functions[] =3D { @@ -1=
02,44 +104,6 @@ static inline
> struct rz_mtu3_channel *rz_mtu3_get_ch(struct counter_device *coun
>  	return &priv->ch[ch_id];
>  }
>=20
> -static bool rz_mtu3_is_counter_invalid(struct counter_device *counter, i=
nt id) -{
> -	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> -	unsigned long tmdr;
> -
> -	pm_runtime_get_sync(counter->parent);
> -	tmdr =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> -	pm_runtime_put(counter->parent);
> -
> -	if (id =3D=3D RZ_MTU3_32_BIT_CH && test_bit(RZ_MTU3_TMDR3_LWA, &tmdr))
> -		return false;
> -
> -	if (id !=3D RZ_MTU3_32_BIT_CH && !test_bit(RZ_MTU3_TMDR3_LWA, &tmdr))
> -		return false;
> -
> -	return true;
> -}
> -
> -static int rz_mtu3_lock_if_counter_is_valid(struct counter_device *count=
er,
> -					    struct rz_mtu3_channel *const ch,
> -					    struct rz_mtu3_cnt *const priv,
> -					    int id)
> -{
> -	mutex_lock(&priv->lock);
> -
> -	if (ch->is_busy && !priv->count_is_enabled[id]) {
> -		mutex_unlock(&priv->lock);
> -		return -EINVAL;
> -	}
> -
> -	if (rz_mtu3_is_counter_invalid(counter, id)) {
> -		mutex_unlock(&priv->lock);
> -		return -EBUSY;
> -	}
> -
> -	return 0;
> -}
> -
>  static int rz_mtu3_lock_if_count_is_enabled(struct rz_mtu3_channel *cons=
t ch,
>  					    struct rz_mtu3_cnt *const priv,
>  					    int id)
> @@ -195,17 +159,19 @@ static bool rz_mtu3_get_direction(struct rz_mtu3_ch=
annel *const ch)
>  	return !!(tsr & RZ_MTU3_TSR_TCFD);
>  }
>=20
> +static void rz_mtu3_set_lwa(struct rz_mtu3_channel *const ch, bool
> +enable) {
> +	rz_mtu3_shared_reg_update_bit(ch, RZ_MTU3_TMDR3, RZ_MTU3_TMDR3_LWA,
> +				      enable);
> +}
> +
>  static int rz_mtu3_count_read(struct counter_device *counter,
>  			      struct counter_count *count, u64 *val)  {
>  	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id)=
;
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> -	int ret;
> -
> -	ret =3D rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
> -	if (ret)
> -		return ret;
>=20
> +	mutex_lock(&priv->lock);
>  	if (priv->count_is_enabled[count->id])
>  		priv->count[count->id] =3D rz_mtu3_get_count(ch, count->id);
>  	*val =3D priv->count[count->id];
> @@ -220,15 +186,11 @@ static int rz_mtu3_count_write(struct counter_devic=
e *counter,
>  	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id)=
;
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
>  	u32 count_val =3D val;
> -	int ret;
>=20
>  	if (count->id !=3D RZ_MTU3_32_BIT_CH)
>  		count_val &=3D U16_MAX;
>=20
> -	ret =3D rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
> -	if (ret)
> -		return ret;
> -
> +	mutex_lock(&priv->lock);
>  	if (priv->count_is_enabled[count->id])
>  		rz_mtu3_set_count(ch, count->id, count_val);
>  	priv->count[count->id] =3D count_val;
> @@ -347,14 +309,9 @@ static int rz_mtu3_count_ceiling_read(struct counter=
_device *counter,
>  				      struct counter_count *count,
>  				      u64 *ceiling)
>  {
> -	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id)=
;
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> -	int ret;
> -
> -	ret =3D rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
> -	if (ret)
> -		return ret;
>=20
> +	mutex_lock(&priv->lock);
>  	*ceiling =3D priv->ceiling[count->id];
>  	mutex_unlock(&priv->lock);
>  	return 0;
> @@ -366,11 +323,8 @@ static int rz_mtu3_count_ceiling_write(struct counte=
r_device *counter,  {
>  	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id)=
;
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> -	int ret;
>=20
> -	ret =3D rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
> -	if (ret)
> -		return ret;
> +	mutex_lock(&priv->lock);
>=20
>  	switch (count->id) {
>  	case RZ_MTU3_16_BIT_MTU1_CH:
> @@ -407,6 +361,7 @@ static void rz_mtu3_32bit_cnt_setting(struct counter_=
device *counter)
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
>=20
>  	rz_mtu3_set_phcksel(priv->ch, priv->mtclkc_mtclkd);
> +	rz_mtu3_set_lwa(ch1, true);
>=20
>  	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1,
>  			      priv->timer_mode[RZ_MTU3_32_BIT_CH]);
> @@ -485,6 +440,7 @@ static void rz_mtu3_terminate_counter(struct counter_=
device *counter, int id)
>  	if (id =3D=3D RZ_MTU3_32_BIT_CH) {
>  		rz_mtu3_disable(ch2);
>  		rz_mtu3_disable(ch1);
> +		rz_mtu3_set_lwa(ch1, false);
>  		rz_mtu3_release_channel(ch2);
>  		rz_mtu3_release_channel(ch1);
>  	} else {
> @@ -552,17 +508,9 @@ static int rz_mtu3_cascade_counts_enable_get(struct =
counter_device *counter,
>  					     u8 *cascade_enable)
>  {
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> -	unsigned long tmdr;
> -	int ret;
>=20
> -	ret =3D rz_mtu3_lock_if_ch0_is_enabled(priv);
> -	if (ret)
> -		return ret;
> -
> -	pm_runtime_get_sync(counter->parent);
> -	tmdr =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> -	pm_runtime_put(counter->parent);
> -	*cascade_enable =3D test_bit(RZ_MTU3_TMDR3_LWA, &tmdr);
> +	mutex_lock(&priv->lock);
> +	*cascade_enable =3D priv->cascade_enable;


priv->cascade_enable=A0is never consumed, so setting this value to 0 and 32=
-bit count enabling
still set LWA=3D1 may be return error value for this scenario.

Cheers,
Biju


>  	mutex_unlock(&priv->lock);
>=20
>  	return 0;
> @@ -572,16 +520,9 @@ static int rz_mtu3_cascade_counts_enable_set(struct =
counter_device *counter,
>  					     u8 cascade_enable)
>  {
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> -	int ret;
>=20
> -	ret =3D rz_mtu3_lock_if_ch0_is_enabled(priv);
> -	if (ret)
> -		return ret;
> -
> -	pm_runtime_get_sync(counter->parent);
> -	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
> -				      RZ_MTU3_TMDR3_LWA, cascade_enable);
> -	pm_runtime_put(counter->parent);
> +	mutex_lock(&priv->lock);
> +	priv->cascade_enable =3D cascade_enable;
>  	mutex_unlock(&priv->lock);
>=20
>  	return 0;
> --
> 2.56.0
