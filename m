Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794935405;
	b=nMJqTeGyjRo7K9VEBN5MBwudtBpwQ3Hb4aa7g2yEJhI52BOw9wO24TSSgbv3akbniZB5
	 RkqWfdfNpo5jWKwC/C+zrYwMHfNGmlVeAhVVwNvvMrB9ziGxVWSCrKuvI4G1nEIMKFCqc
	 pEGxELEOnm/1bXftUbW8BpkaYSzJb2go1mVL5GedHOjqlxZes4cXjbhhBgcFqt4wP/5rD
	 9h9XeguEDlrj7JnOVvqK98OYLMvyhojkQprKX7ePBlbLjaoFj35NFwN2gwhUMAslQczVs
	 eedhiP5JFXuUUJy4T1YdHSQSK14VrteEA/nJkJ4oTMKjlH8coWyRVeji7+X0tLzLkyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935405;
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
	bh=APj75ImibQFBJ1EgKVxp8kfWwGl2hy1xjW3Um/gt3Cc=;
	b=tV3caG1Wo9+ueMSWiboQlDTSFot3/FHlZBhU2hAF3eUhnluDx/32InHHwQP6GC+wRrTZ
	 1u/LrgK5r2eVfxx7EMdO8uxiaEjE49z2ul2AFUSYmfen3ejhdn+ycfJWrOvP8EbqQCLlN
	 GX7BiCO6DYCR7XnTYAiPG4MOjyxiecrNZXRVkUiFiRzKiLn6DubmYdYCBHGpuzahKnr9/
	 lLiGPyRLCP09/7pEmLxbYGeKUdB6UaaNhCRV/wROTAgy1nhuw3GXkK5qOd9CzAUfR6BYs
	 XB0XDTQ3Q1953OYWSJOiAf0jpXGKaE5NLzstLoXE4//8whKZ59UtnapMJaOGdnaL1sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=g3WOmTGg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.17
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010017.outbound.protection.outlook.com [52.101.229.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B659606A31C;
	Tue, 17 Nov 2026 17:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B659606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=g3WOmTGg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbq3de0+7xo1K7UcsK1tSrT6r+pogqwfPKWesLGGSDwn1IvbCOvsoujhviUitkSc+WaGI4vIfTiPBWUn9n33REFCLyZ8UdbIGW5SZaf6/D1oJREspglyE4jDOyo5BRSU8PWGKKZDcm1MLhfdoByLFoVMdXWRbNRbvtxfbEqIdLcMra1BrEZEMSOEUBtVAm/sRxJk0AkNVw1eggtankJAhkM1bfbhBTF6SEC6qVl8xG017ScwbSe5IL5tcNOXG14v/DAG82AwKgPhyGft1Qlg3K1xErtDrixkk27V9hlGDWFawcOHeMKR5MQhWHwL7kUE2e3bPR2UkokhkYqFchgdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APj75ImibQFBJ1EgKVxp8kfWwGl2hy1xjW3Um/gt3Cc=;
 b=BtRDCaTdHY13QbW+o9+6Fd+rwHpZRXEWPatwsRZR1NmtKfAIafxP21T1IjkMep46jKX2r2BU+R0z8Ttjf26kYDlCU2dgnrxcY05eq9n3fsy3lBU6VpdERJItPl+6RSMZ7WvEMScFR+tNOPzXdAoaIshvh7E6ItWezEpS0g8f7XZCY4VuLI7K/F3FWEgfeFz2SWIqFc+vfJQsRtEsRcrXP+Uor9V+kFhAoKxCdC+0pDHS9Qgf/Wrz69V2sJEs6wBvYPB4tv4sHpeyLgSyVsR6c1ng8YnZ1qBxczwIM6a6ArPl3tyTa2TJWWXIoVyBdBdlQqHpsc3h+GgYIeTpXiYwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APj75ImibQFBJ1EgKVxp8kfWwGl2hy1xjW3Um/gt3Cc=;
 b=g3WOmTGgUuq8M5qFa/ctiR3JM76EvrDypUAbNT/Cp6LkqvKVYP62r97lKYCjYsh8b/ll6D6nJOEYg10G5ISPjQ3DwcQYGKBMXsl3G/QcfgOUhXU4UoWICcMT4Xoa/xO1Od6dUjMkYxk5Xcq4aJh/mP91rjJF1Ek8EPn8I/vQCmw=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TYCPR01MB6915.jpnprd01.prod.outlook.com (2603:1096:400:ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 17:10:01 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 17:10:01 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, William
 Breathitt Gray <wbg@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cosmin-Gabriel
 Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: RE: [PATCH v3 13/14] counter: rz-mtu3-cnt: drop conditional locks
Thread-Topic: [PATCH v3 13/14] counter: rz-mtu3-cnt: drop conditional locks
Thread-Index: AQHddn5OGcIFrH65l0yXcpoEEA8IrLcyfnbw
Date: Tue, 17 Nov 2026 17:10:01 +0000
Message-ID:
 <TYYPR01MB66031E5A1F98AA055EF02665867B2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261117102607.2504551-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20261117102607.2504551-14-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To:
 <20261117102607.2504551-14-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TYCPR01MB6915:EE_
x-ms-office365-filtering-correlation-id: cf07c1af-4619-4a92-6d21-08df44cd9dec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|6133799003|56012099006|261021121427099003|11063799006|4143699003|261028144727099003|261021123027099003|261022105027099003|261102123227099003|261026140227099003|261009223027099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 E+AjijHypX4lkYnz2bdc5R+u/IrQmkLRCW3t3LbVYZ6iKbIR6s8aZTjg8+5I/knNOXl7KHFsDbGuyKyO0ousq6O0GpnxYqxgMvytwsNWr+lFM7bIays0B/f7tUs1gWqTQ85w92CFlxBBvspPxMgj3JTiy2NUk283aOpbF9AZFs/zneOv2JJY6TEJat9YkGQe5W4b4RocAqr+XXNWRx65dKd/KVe+/NFF3TdnIh1sF1ssR3oxzYl8XxEsBARO7tLPTuJXmVpUQbVOaUIxt2tqK11AXxT9q1TQ6oAGW1s9iMe10xvuyjz6lefCVoYm8BpuRCGD5/OqtYa6YSblsVRvbQ7Ion2z9Hnzf0cSl5PBXBONcQ+UBuQGdE3OKi5QB+BkSUDOE2YkPn4tCFiCvWA02hNBfVj6xx+QUalS48VE1l2U2KrrJsly0rPsQiJQFtS9hPT7j8s6eihaiCC7yviXfWis5X5sLViV+3fBIZ+/WJ3Xx/rfNT2EDPMSAGkiHEtFxDiUD66ujomTPF02+K+K+bA8i4WM0bDNyQgYO1yfs565AG6tO+oukEx4nPtnqz9XvWGLKeXCxVZc32VHnX/N94OwveuFvclzsP8wYctgp9iIDgwjPvdvdxDI7+VJPeaUbXr7V854cnsqtqjiNeLyGhK7BlZgc/BrJ0oZ8Dg1HauSKCIqKUekvFSU/PeQj3D+XO66jovGIf3hcX+JlsFvgWtj6382tD8IUJRO6f8ZdOs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006)(261021121427099003)(11063799006)(4143699003)(261028144727099003)(261021123027099003)(261022105027099003)(261102123227099003)(261026140227099003)(261009223027099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eAwBj7OnISs0mmri/L2rEflwu6MCGLLIjt9lWE1pyck2XgrhFbRsy9QdcpPe?=
 =?us-ascii?Q?qBrjCHVJognbWodN0b40E0SFUn2TG3Tm4BKaN/XeyI/HFYOy4Drkmkqe5cMu?=
 =?us-ascii?Q?6q4C6WvcrKIQgAiRJ5BluGD27V5GT6TJ4tgpF+EQ/KQD6LT2axr0a3fxpjyQ?=
 =?us-ascii?Q?wM3MrK+MvQXTzdu2ja/OnzMacbWAiXqDQ43ebi9N/MdbRl+YEL75ehVxw/PP?=
 =?us-ascii?Q?QXyeXPARd6XVvXq1rv92bcryyRrQHfJrM48k0TIUZhgBrcQ7PPnSHjtAuEoD?=
 =?us-ascii?Q?zqbnugqkJ+WPUa2NPEc/BJjUJyomf0HpRElPyM5UhVrnxoTtwxEBtaPJQHws?=
 =?us-ascii?Q?97joPYkbCqOVRvjshoztHh7YSLatSM4KUVwV0rHuLx2bdey5+wF3gUvuTxtO?=
 =?us-ascii?Q?i17zFnBxsmxElFvkGsXiAAvnPeLQUw8Cl27rogB4WdZv3GNLtHRU76RrKtmX?=
 =?us-ascii?Q?Ql7Tt28kPUG7KptEPQEIAgrAWxP7/5wnKTXd5PUYatgYKCV2yI6Twpu4tLRJ?=
 =?us-ascii?Q?vaAecJvYzT1Tzzy90FLhbSEmdyxJe/yZ1V/LmZJreNnzY0O/RnXEF234IcvN?=
 =?us-ascii?Q?uFP2cF6C8AHdGrMsca3zPAeCvYp6Eo9deeEQwbsG2qkckdjpNUaEwwZqccUF?=
 =?us-ascii?Q?2dbu55gSDhFuk03yTd4D/mLiQ8pcG2OFiZJZEqRAzotkv/E0R+zhSA0lhcFi?=
 =?us-ascii?Q?c8S7eoAVfkpaeS1AleiWTJBhPSNlmJd55gjoLNwLJrH1I8C1zQ6cbwhRfKbo?=
 =?us-ascii?Q?cE6xe4TAIhZzdLDnstb3ppGuNkXvhyrtl4RrU2hUa0g9zBJ+QENo+yuDjiSV?=
 =?us-ascii?Q?Z+f/zBjU6rJIPRV55w0SMZGxqvlWSCv8oAXVGBVNmkFvA/TOfay9axU+9Che?=
 =?us-ascii?Q?35hvH82gSEHil68pyhS9nFhj37lLKgvxvF75e0GQz2P3GzVzNwPsLFPOry3F?=
 =?us-ascii?Q?CQcJwEKWIJ2gzWeCyI3pL5eGZBDmc1YJi9eBJ8LUNaHtyW+V/IhN1JqfztGB?=
 =?us-ascii?Q?cEjqbb/an9TvWZk3v1hA2FIaOlJSXtXIGEY5i6Lc8ch7MYtOBOH07jLMy/BZ?=
 =?us-ascii?Q?UFk06ngStzMAr8XGtyhu9pp/4UDebYuNyh794FmHWsvAnNlsoW+NgUVl/jUY?=
 =?us-ascii?Q?4q3fWLOKhRycRvmx4HyhXkz+0/D8Tm+mT/+6hWbKNermq9uicPLGFuUhjEuI?=
 =?us-ascii?Q?ETJp6XNAixAuNp2SX1WOFPrdHA9kE2yHF9tgCWwL/B/oNHsGbnAPyhXUKNCf?=
 =?us-ascii?Q?UFF8YNjFPUoeDiq+i4iWnAHqCqFQ1KN/hDMCzIZcs7SM8jIJ2P1VLST1aNrg?=
 =?us-ascii?Q?fxAt5zu0oIQMkEJxazaWVE50ZrwpIAGs38hiDXu9aQ9CjnRLA0ze+kcrkujF?=
 =?us-ascii?Q?nPGY2ZuKNwPtc9PoGHugMN3nJW+IWPR4CgWH6cLl8MLp1IXh4sI6eyJUxRY8?=
 =?us-ascii?Q?xh0ldhei4J6K4JtfBJqLmx39tRe6zOD1AJNuRGSQwvckq94YCzfu+nSwSzuX?=
 =?us-ascii?Q?uEkhXLwDem6qXWWeVfEjc6SgT5AYWRX6mEZ98BrNJQHqcYgfO8HK2Lp0gBq5?=
 =?us-ascii?Q?U2uF8bSdVysCPIFQFLplAPoNdaj9x339hMY5vqHh4jJ8z8SKFEXfSmyHNwze?=
 =?us-ascii?Q?jXI873BlVy2yeSbZprMkZIiXyFWhLBJIAHcspEN0V/tCulePuhWc51obJHho?=
 =?us-ascii?Q?unMAr5v8eZfdKYmBdo7Qt/9wIJJVK7sn976Nl3JORmYUptvra0yS07xIFFQC?=
 =?us-ascii?Q?gh05VqX/OA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf07c1af-4619-4a92-6d21-08df44cd9dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 17:10:01.8214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /EL7b7wqRWSNMO129JRrH6EhgDULX+B/jTMot3pn2lTqnPR5DMPYG9+ZCUPTUhzi+ghYwYj9WDPbDGAVQi+Cy6UyM85QElWKUrdSf+mDq8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6915



> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: 17 November 2026 10:26
> Subject: [PATCH v3 13/14] counter: rz-mtu3-cnt: drop conditional locks
>=20
> All read and write operations now only access the hardware if the respect=
ive count is enabled.
>=20
> As a count cannot be enabled without the underlying MTU channel(s) being =
claimed as busy by the count
> driver, drop conditional locks and replace them with simple locks.
>=20
> Use guard() where possible.
>=20
> Remove the conditional locking functions as there are no users left.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

> ---
>=20
> V3:
>  * adapt to "put runtime PM ref if counter init fails" changes
>=20
> V2:
>  * no changes
>=20
>  drivers/counter/rz-mtu3-cnt.c | 120 ++++++++--------------------------
>  1 file changed, 26 insertions(+), 94 deletions(-)
>=20
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.=
c index
> 07dd7f588911..8252dee6d04d 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -104,20 +104,6 @@ static inline struct rz_mtu3_channel *rz_mtu3_get_ch=
(struct counter_device *coun
>  	return &priv->ch[ch_id];
>  }
>=20
> -static int rz_mtu3_lock_if_count_is_enabled(struct rz_mtu3_channel *cons=
t ch,
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
> -	return 0;
> -}
> -
>  static void rz_mtu3_set_ceiling(struct rz_mtu3_channel *const ch, int id=
,
>  				u64 ceiling)
>  {
> @@ -171,11 +157,11 @@ static int rz_mtu3_count_read(struct counter_device=
 *counter,
>  	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id)=
;
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
>=20
> -	mutex_lock(&priv->lock);
> +	guard(mutex)(&priv->lock);
> +
>  	if (priv->count_is_enabled[count->id])
>  		priv->count[count->id] =3D rz_mtu3_get_count(ch, count->id);
>  	*val =3D priv->count[count->id];
> -	mutex_unlock(&priv->lock);
>=20
>  	return 0;
>  }
> @@ -190,11 +176,11 @@ static int rz_mtu3_count_write(struct counter_devic=
e *counter,
>  	if (count->id !=3D RZ_MTU3_32_BIT_CH)
>  		count_val &=3D U16_MAX;
>=20
> -	mutex_lock(&priv->lock);
> +	guard(mutex)(&priv->lock);
> +
>  	if (priv->count_is_enabled[count->id])
>  		rz_mtu3_set_count(ch, count->id, count_val);
>  	priv->count[count->id] =3D count_val;
> -	mutex_unlock(&priv->lock);
>=20
>  	return 0;
>  }
> @@ -227,18 +213,11 @@ static int rz_mtu3_count_function_read(struct count=
er_device *counter,
>  				       struct counter_count *count,
>  				       enum counter_function *function)  {
> -	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id)=
;
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> -	int ret;
>=20
> -	ret =3D rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
> -	if (ret)
> -		return ret;
> +	guard(mutex)(&priv->lock);
>=20
> -	ret =3D rz_mtu3_count_function_read_helper(priv, count->id, function);
> -	mutex_unlock(&priv->lock);
> -
> -	return ret;
> +	return rz_mtu3_count_function_read_helper(priv, count->id, function);
>  }
>=20
>  static int rz_mtu3_count_function_write(struct counter_device *counter, =
@@ -248,11 +227,6 @@ static
> int rz_mtu3_count_function_write(struct counter_device *counter,
>  	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id)=
;
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
>  	u8 timer_mode;
> -	int ret;
> -
> -	ret =3D rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
> -	if (ret)
> -		return ret;
>=20
>  	switch (function) {
>  	case COUNTER_FUNCTION_QUADRATURE_X4:
> @@ -270,14 +244,14 @@ static int rz_mtu3_count_function_write(struct coun=
ter_device *counter,
>  		 *  - need to add RZ_MTU3_TMDR1_PH_CNT_MODE_3
>  		 *  - need to add RZ_MTU3_TMDR1_PH_CNT_MODE_5
>  		 */
> -		mutex_unlock(&priv->lock);
>  		return -EINVAL;
>  	}
>=20
> +	guard(mutex)(&priv->lock);
> +
>  	if (priv->count_is_enabled[count->id])
>  		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, timer_mode);
>  	priv->timer_mode[count->id] =3D timer_mode;
> -	mutex_unlock(&priv->lock);
>=20
>  	return 0;
>  }
> @@ -288,11 +262,8 @@ static int rz_mtu3_count_direction_read(struct count=
er_device *counter,  {
>  	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id)=
;
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> -	int ret;
>=20
> -	ret =3D rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
> -	if (ret)
> -		return ret;
> +	guard(mutex)(&priv->lock);
>=20
>  	if (priv->count_is_enabled[count->id])
>  		priv->direction[count->id] =3D rz_mtu3_get_direction(ch); @@ -300,8 +2=
71,6 @@ static int
> rz_mtu3_count_direction_read(struct counter_device *counter,
>  	*direction =3D priv->direction[count->id] ?
>  		COUNTER_COUNT_DIRECTION_FORWARD : COUNTER_COUNT_DIRECTION_BACKWARD;
>=20
> -	mutex_unlock(&priv->lock);
> -
>  	return 0;
>  }
>=20
> @@ -311,9 +280,9 @@ static int rz_mtu3_count_ceiling_read(struct counter_=
device *counter,  {
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
>=20
> -	mutex_lock(&priv->lock);
> +	guard(mutex)(&priv->lock);
>  	*ceiling =3D priv->ceiling[count->id];
> -	mutex_unlock(&priv->lock);
> +
>  	return 0;
>  }
>=20
> @@ -324,32 +293,26 @@ static int rz_mtu3_count_ceiling_write(struct count=
er_device *counter,
>  	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id)=
;
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
>=20
> -	mutex_lock(&priv->lock);
> -
>  	switch (count->id) {
>  	case RZ_MTU3_16_BIT_MTU1_CH:
>  	case RZ_MTU3_16_BIT_MTU2_CH:
> -		if (ceiling > U16_MAX) {
> -			mutex_unlock(&priv->lock);
> +		if (ceiling > U16_MAX)
>  			return -ERANGE;
> -		}
>  		break;
>  	case RZ_MTU3_32_BIT_CH:
> -		if (ceiling > U32_MAX) {
> -			mutex_unlock(&priv->lock);
> +		if (ceiling > U32_MAX)
>  			return -ERANGE;
> -		}
>  		break;
>  	default:
>  		/* should never reach this path */
> -		mutex_unlock(&priv->lock);
>  		return -EINVAL;
>  	}
>=20
> +	guard(mutex)(&priv->lock);
> +
>  	if (priv->count_is_enabled[count->id])
>  		rz_mtu3_set_ceiling(ch, count->id, ceiling);
>  	priv->ceiling[count->id] =3D ceiling;
> -	mutex_unlock(&priv->lock);
>=20
>  	return 0;
>  }
> @@ -454,9 +417,8 @@ static int rz_mtu3_count_enable_read(struct counter_d=
evice *counter,  {
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
>=20
> -	mutex_lock(&priv->lock);
> +	guard(mutex)(&priv->lock);
>  	*enable =3D priv->count_is_enabled[count->id];
> -	mutex_unlock(&priv->lock);
>=20
>  	return 0;
>  }
> @@ -467,17 +429,17 @@ static int rz_mtu3_count_enable_write(struct counte=
r_device *counter,
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
>  	int ret =3D 0;
>=20
> -	mutex_lock(&priv->lock);
> +	guard(mutex)(&priv->lock);
>=20
>  	if (priv->count_is_enabled[count->id] =3D=3D enable)
> -		goto exit;
> +		return 0;
>=20
>  	if (enable) {
>  		pm_runtime_get_sync(counter->parent);
>  		ret =3D rz_mtu3_initialize_counter(counter, count->id);
>  		if (ret < 0) {
>  			pm_runtime_put(counter->parent);
> -			goto exit;
> +			return ret;
>  		}
>  	} else {
>  		rz_mtu3_terminate_counter(counter, count->id); @@ -486,32 +448,16 @@ s=
tatic int
> rz_mtu3_count_enable_write(struct counter_device *counter,
>=20
>  	priv->count_is_enabled[count->id] =3D enable;
>=20
> -exit:
> -	mutex_unlock(&priv->lock);
> -
>  	return ret;
>  }
>=20
> -static int rz_mtu3_lock_if_ch0_is_enabled(struct rz_mtu3_cnt *const priv=
) -{
> -	mutex_lock(&priv->lock);
> -	if (priv->ch->is_busy && !(priv->count_is_enabled[RZ_MTU3_16_BIT_MTU1_C=
H] ||
> -				   priv->count_is_enabled[RZ_MTU3_32_BIT_CH])) {
> -		mutex_unlock(&priv->lock);
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>  static int rz_mtu3_cascade_counts_enable_get(struct counter_device *coun=
ter,
>  					     u8 *cascade_enable)
>  {
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
>=20
> -	mutex_lock(&priv->lock);
> +	guard(mutex)(&priv->lock);
>  	*cascade_enable =3D priv->cascade_enable;
> -	mutex_unlock(&priv->lock);
>=20
>  	return 0;
>  }
> @@ -521,9 +467,8 @@ static int rz_mtu3_cascade_counts_enable_set(struct c=
ounter_device *counter,  {
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
>=20
> -	mutex_lock(&priv->lock);
> +	guard(mutex)(&priv->lock);
>  	priv->cascade_enable =3D cascade_enable;
> -	mutex_unlock(&priv->lock);
>=20
>  	return 0;
>  }
> @@ -532,14 +477,9 @@ static int rz_mtu3_ext_input_phase_clock_select_get(=
struct counter_device *count
>  						    u32 *ext_input_phase_clock_select)  {
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> -	int ret;
> -
> -	ret =3D rz_mtu3_lock_if_ch0_is_enabled(priv);
> -	if (ret)
> -		return ret;
>=20
> +	guard(mutex)(&priv->lock);
>  	*ext_input_phase_clock_select =3D priv->mtclkc_mtclkd;
> -	mutex_unlock(&priv->lock);
>=20
>  	return 0;
>  }
> @@ -548,17 +488,13 @@ static int rz_mtu3_ext_input_phase_clock_select_set=
(struct counter_device *count
>  						    u32 ext_input_phase_clock_select)  {
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> -	int ret;
>=20
> -	ret =3D rz_mtu3_lock_if_ch0_is_enabled(priv);
> -	if (ret)
> -		return ret;
> +	guard(mutex)(&priv->lock);
>=20
>  	if (priv->count_is_enabled[RZ_MTU3_16_BIT_MTU2_CH] ||
>  	    priv->count_is_enabled[RZ_MTU3_32_BIT_CH])
>  		rz_mtu3_set_phcksel(priv->ch, ext_input_phase_clock_select);
>  	priv->mtclkc_mtclkd =3D ext_input_phase_clock_select;
> -	mutex_unlock(&priv->lock);
>=20
>  	return 0;
>  }
> @@ -584,14 +520,11 @@ static int rz_mtu3_action_read(struct counter_devic=
e *counter,  {
>  	const bool is_signal_ab =3D (synapse->signal->id =3D=3D SIGNAL_A_ID) ||
>  				  (synapse->signal->id =3D=3D SIGNAL_B_ID);
> -	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id)=
;
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
>  	enum counter_function function;
>  	int ret;
>=20
> -	ret =3D rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
> -	if (ret)
> -		return ret;
> +	mutex_lock(&priv->lock);
>=20
>  	ret =3D rz_mtu3_count_function_read_helper(priv, count->id, &function);
>  	if (ret) {
> @@ -610,6 +543,8 @@ static int rz_mtu3_action_read(struct counter_device =
*counter,
>  		}
>  	}
>=20
> +	mutex_unlock(&priv->lock);
> +
>  	switch (function) {
>  	case COUNTER_FUNCTION_PULSE_DIRECTION:
>  		/*
> @@ -636,12 +571,9 @@ static int rz_mtu3_action_read(struct counter_device=
 *counter,
>  		break;
>  	default:
>  		/* should never reach this path */
> -		mutex_unlock(&priv->lock);
>  		return -EINVAL;
>  	}
>=20
> -	mutex_unlock(&priv->lock);
> -
>  	return 0;
>  }
>=20
> --
> 2.56.0
