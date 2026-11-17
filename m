Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794935077;
	b=vdI1BA3Mp4w1RwyNb91mBpBmLYQchY0vW+vJak5FDH64EZHbXkaMGpB//+3YxpbuHdW/
	 Q+0w29j9TiUQhCu9Q/JLKpJ29NnEnuDEzihnXvL+P4u6EwQ5A7EROjxtMw+/e8op1AecR
	 WtG9+ORVEBdk/AsvJXCftcgO1991EzSEy76/admSngTXBWB7RUiPNJ1B0z+23MQ3IY2na
	 MBEDintWyvUKUxHFVC4xIYXlDlQCZE7mKc7+ebNzKPq1fNfygVGVU8/K1ed+5n+IkvVVX
	 epsdpyk9XYuPgRTE8kfZDk3DQOgPRz7omDIyQslupQKLXEfxTbkOYtTK8gzo9ruPuuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935077;
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
	bh=vlx8q83J8Kwacblf/cl2Q9yd1hhr5TbWjk/j1Y+Kh/Q=;
	b=AkX/XVkzQ64FX8KclP44iopGOWm+KgtfSCG5gZkUte3692Rl0dVNgTn9BtCCO32TAM41
	 bslBqVl/wpr3h8UuJaKPkMsBsWtga3UUmb6IyzDJgykslhZapByEGL/nNUlG53euuPu3q
	 1MfyaFk8EyC+oHdh7mmmNF7fzBbsiGbCYFHlao6h0+LlTuNshvh6tk1rvRg04XmF4+aFR
	 Kx2PtN1K267c/bCr0FQ426+LBeCoL/x9bVt8E61pMmzG++SNP9/pLpbKP4IvBDvpSdytC
	 YK7lfAeMT/cZEUjtQC4RSaNMWAtSlQGFFkLUpMGIu2WS375MNstSXlTjHny18zb2WWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=FJuYgv5Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.27
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010027.outbound.protection.outlook.com [52.101.229.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62647606A32A;
	Tue, 17 Nov 2026 17:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62647606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=FJuYgv5Y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lk/KRfjFnbo4FGQtnv1sjx+g16bMdGw2gwsVLqqz4Aw9PUz8DBdu092LcVFlRvtooJXKfsdMAb1H28sQww66KFkHs2Ap69XHQsJ+lgjLNaaFnxgxoSKKxiX5ABOGC1QCauTF4rSnHCeU1lpBjgyAuN71qiHKPNLuThdZY8/qlIGoG4HU4RH2iz7SQYtN1uZvP2n5K+YsGP5I1972h/HGXJ/bvXwySP6lG8V4QqK74soo20ueEBFIMTWKQ5cAsVjE4N7hp77f79Gm5RceSm5GAaEl/edwkUjI/BIpK6J4DKf8q2dvBS3mukUSjq48Oa8VLoCyB7PldLGtvFs5F9MxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlx8q83J8Kwacblf/cl2Q9yd1hhr5TbWjk/j1Y+Kh/Q=;
 b=sTNuNOIv9lQdD1aDb1QFv9junbdy+wthXHmLwiPt41qXVvXvwKuSiuhgwa/5amR3a1AzmMPWbq69qwAsVYFjuD/YJBebiNPQydkhf2Iy+Y4XAejM2WodabgXr/dum+iwEccWqEXIYolb3Dq/4cGV9WSIcQ43r/FVnz9otSB2ZvrYFF7GVSVwy9tkAaHBBeoUaeiuGvsKuE2AYGmCU3olUpKfJANZOnkUmTs+p0FMQytL+ffBico68k/YDEkPfFWUvoUwSY7kfbo135Ozfs4bNrwewdPzFf9RpykhtO6iyz4E9jkxE6MkusmWev0S4j/AqrjtnDTG2NEsxvvdvuR6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlx8q83J8Kwacblf/cl2Q9yd1hhr5TbWjk/j1Y+Kh/Q=;
 b=FJuYgv5YT0Zf5aIgLpBvHn8aHE8AgPQfLl4g8gASxfSAMg+MbklWwBdJS/tAnP28jzGmDFxhISQgi0tMt6JaasA2oP0ftIYh15KSfrPvh119GQEWylJQ0JxEWp5TpVGAaqlgqyQfss2sO6xbcpy/WIAI8JQ4vmAcX0/lmUUwU0E=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TYCPR01MB6915.jpnprd01.prod.outlook.com (2603:1096:400:ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 17:04:33 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 17:04:33 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, William
 Breathitt Gray <wbg@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cosmin-Gabriel
 Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: RE: [PATCH v3 14/14] counter: rz-mtu3-cnt: use
 pm_runtime_resume_and_get()
Thread-Topic: [PATCH v3 14/14] counter: rz-mtu3-cnt: use
 pm_runtime_resume_and_get()
Thread-Index: AQHddn5Q/LfJcQj7q0qQhnTNKXdA67cyfiSw
Date: Tue, 17 Nov 2026 17:04:32 +0000
Message-ID:
 <TYYPR01MB6603F1D1A85AB4D5B6C53272867B2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261117102607.2504551-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20261117102607.2504551-15-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To:
 <20261117102607.2504551-15-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TYCPR01MB6915:EE_
x-ms-office365-filtering-correlation-id: 20e20b80-1bb3-4d79-4c2f-08df44ccda01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|56012099006|261021121427099003|11063799006|4143699003|261028144727099003|261021123027099003|261022105027099003|261102123227099003|261026140227099003|261009223027099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 E2X3u41ZEbrqJLQ//xvnh7ItCFMFV6bxSC6pOJVpjrkSjcVnt9WMBslTGZvvsceV+NRT+79Gp6Hjiil5EOrjlQGhBtcxEsVvXNqItLiRirEQvRCGa1Id03YQnk/gK3Swj7hd0JlZNeoYfbzTB3yfqS5yWLI79vMrw0aI+6asBjANlqFcTBVAQ3bqvJiADOet9PjVqTWoNkAbcXQB5WMJ+E2UDj9n5Ay1HnNbgPECVRbHEZMbOE7lBe20OgVTZ59nJbEml0+k9fLIWWCv7x/6bAC984IczXUurss2RmuFqVMk4lM6ECSPvJ8a38iJJBFy0UNv6gJ9f64xGRNM4Du6koGg89NSd2GKWCVSe/QB99eTu6JgY4Si0Fz1sbTO6KivXCuw8qACajMADvtHisZztzixZJQzxb44LFHDk8uDGKaFDcPEz4KOO+iKDw7vh/QxEyx+ru1l54+twyJmPamNv1M/HMZV9YJyXql+HXfmL4KtWFqigGU18gSp/velvh0FLxpJoMDZ8bjZtbZHLYe2/PkKtqUUa9WiCGNKQyAJQFaKbUIM9CDfO/HW6IoxZT7oV49YZgsvp1Ysuc9/XYmeqSakU7plMaPGyj2kBldXjlAUrEdCS1xqgWV5KpFjrXC/aCMu2ujeaKEqLf7SD9A7vCDr+fOmPj0y+hzFmqVKs03nEYnF3rC+HL3R7qbtkIgAFuOXDc1bft1zJyp7V1KfaSWsZQsj1/a3/OFX6KPSIhA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(261021121427099003)(11063799006)(4143699003)(261028144727099003)(261021123027099003)(261022105027099003)(261102123227099003)(261026140227099003)(261009223027099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ol5qIvMrdzOKPOhBY/zxjcE1v3LEOf9ZOjIGts6aiLWqk8Kz4Zgd1zkK8pah?=
 =?us-ascii?Q?O+ZaRuZ5y2kmieOBIf08CRDx5eg88P7JTvxO3/Dn2IGDieyn+Tw58s+fy5uj?=
 =?us-ascii?Q?BuTpodq4xpiwrU57Y4lkSD8bSp/BlAuVyEGKdKg8U7I29S48Tq1NtBz+ceqb?=
 =?us-ascii?Q?BXPFVRKArnnbUqWsbyQzcyeomZeGkLiUNqvi50gs6a9soh7juwdFkWi11+4f?=
 =?us-ascii?Q?wUC27/YQ7kZcxW/kde+kYqTY3PrWfOH1dNCnR0xT+2IWrPVTR64b20KPUfxU?=
 =?us-ascii?Q?Xet/fGcGnFMVvJ8pQuYxttOxm+8PITi+Y+4sGMWF050th1E5OVrUtFNRSL9S?=
 =?us-ascii?Q?RGed5II2JC2XOUfuIW4YFSVYIuZCiJ3KiId0dZLULjrax8RYPWg5M9rwzqj4?=
 =?us-ascii?Q?vN7yFuza5L+qFeLDtTC0v/YJSIvvMIYIPtpHTmCIr20PUbSZBxEcOlWuEBF/?=
 =?us-ascii?Q?MKJ36T+IRYD5u5hDYPg5GFTrg6ptu0Ds8MY9p3ZF/NddNY0FbjvwHdVuOXjw?=
 =?us-ascii?Q?iDQm/ePtM+hJ9kMTcVZhqsOAJVw8jb6ghvKqzK+FyrHquN7yH1NAZHQbyYsF?=
 =?us-ascii?Q?pd84+BEj47/aDlvPd5F5fQ+uLemS7Xn5024raIE6mR64RsDt5DXQYXTMw/Ln?=
 =?us-ascii?Q?vhKhn2P5X/pVZaa+wkrMDKQ/LHT7OJQeMqhB09occCxQdu/FMXF0oRUIBtt0?=
 =?us-ascii?Q?Jev/mf7ya3+nSXvriwjVNH8irVJxOk0E2ixwxeeoYzJ6C9tveLgPbudZkC/a?=
 =?us-ascii?Q?htAu2cCeYj2FnAQcBhNoUeKkvuPhww1+tcqQH7+zznpcCnGJtFYqRgVoamCQ?=
 =?us-ascii?Q?R5hY3OwnlHRu+iB+22PvaN3IUjkIhZoWU0h1T0To5BBgp/OLVY/umn5x3Eth?=
 =?us-ascii?Q?zPbfADyfzE0a1PYlH8SmwXaVHu74jZBE+yw8MYkA24LXx9Sc7/cy4JHLUQKX?=
 =?us-ascii?Q?tU0JA0pkwECHQ63dYlw/BHtwNk+bOalSdIS8gbC6qeKeViNxVEoItZG736ic?=
 =?us-ascii?Q?jniZWgIrhXpjNxSjDm0x9aal1AU9NYbQu3xZQ498Bl0TjUNKcIyf780Twydh?=
 =?us-ascii?Q?WTu8HuIJhYhP5e0nVbssWIvc28qlcOCs0DilqHs7TKtAga5Tovv/0wnxK8C9?=
 =?us-ascii?Q?fex3Fb5BieKbU1JWahyQg9/28IYfaqXH+qiSrvhX9NA7MiWdGrS/ODtIX+dg?=
 =?us-ascii?Q?qPeUri/FgUkcg7mGeFmP8zuhisJK34cHYYO+mnXrW+2MRhKQhh0t04463GwU?=
 =?us-ascii?Q?6M+39wqOTIHMETFctigZ6Qzms0aiSkWfFX/ea2x3laiBtFr9uH+RqzLE5QjO?=
 =?us-ascii?Q?O398G422fl6Hi4p18Mm03kBOYobRsvZ7H71IpD4SuNhoi6K4Pnv9HIYQ9WOr?=
 =?us-ascii?Q?DYoN6ae57M8KYE1c2SCsyWuso3U/H1I+e9WFlL3GmvC1z6c9niR2jmOk86+w?=
 =?us-ascii?Q?5/ttu0gW8mtrsDRBV+LY3lKPiotz0LZPHJ1RkcfumTMu1yb5tXj9oE3qj1V1?=
 =?us-ascii?Q?ttLYWKu1JPnC0rp7rQ++4KOSrMkqUHU2kVeLDbuG4eBB8cKIknliSdvFlJYn?=
 =?us-ascii?Q?OYLCTc8xhUzEnUKTupUn7SELCFyoazSXMLAd4sti7UifHpXGD5eiQVYKuLLb?=
 =?us-ascii?Q?2cVg3Lp/1YS0rP1zmWnrcVHeOyD07DAGSmsSyc3yjftvRp6u7Ww2qfXY6Gda?=
 =?us-ascii?Q?a3TC/qOBRt12QcVHdCAD/ahYZNtnrIb7E9m+Q7LZI8CPS9JJOz6gSZUMDgeV?=
 =?us-ascii?Q?zdkFnBeq/Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e20b80-1bb3-4d79-4c2f-08df44ccda01
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 17:04:33.1128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWO9RCxTdoaMOL3G9gTOo7XS7AyhlOMxLNEdzKy+q60qKgm6r3jEWogowfcSUhmupvn/12nG3+Bv0fFJjeo6KJ/YEo19bZ0ZITMdNSFuiAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6915



> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: 17 November 2026 10:26
> Subject: [PATCH v3 14/14] counter: rz-mtu3-cnt: use pm_runtime_resume_and=
_get()
>=20
> pm_runtime_get_sync() may increment the runtime PM usage count even if th=
e resume fails, which
> requires an explicit pm_runtime_put_noidle() to balance it.
>=20
> This driver ignores the return value of pm_runtime_get_sync(), risking ac=
cessing device registers even
> if resume failed.
>=20
> Replace it with pm_runtime_resume_and_get() and handle errors properly.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>


Maybe fixes tag as it fixes a kernel crash in case of error??

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

> ---
>=20
> V3:
>  * no changes
>=20
> V2:
>  * no changes
>=20
>  drivers/counter/rz-mtu3-cnt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.=
c index
> 8252dee6d04d..1426d15f0ccc 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -435,7 +435,10 @@ static int rz_mtu3_count_enable_write(struct counter=
_device *counter,
>  		return 0;
>=20
>  	if (enable) {
> -		pm_runtime_get_sync(counter->parent);
> +		ret =3D pm_runtime_resume_and_get(counter->parent);
> +		if (ret)
> +			return ret;
> +
>  		ret =3D rz_mtu3_initialize_counter(counter, count->id);
>  		if (ret < 0) {
>  			pm_runtime_put(counter->parent);
> --
> 2.56.0
