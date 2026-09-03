Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011032.outbound.protection.outlook.com [40.107.74.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8763CB572;
	Thu,  3 Sep 2026 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418410; cv=fail; b=OS8bPnwXItfoZhPN+fWpOFvXqA+/zI726EuSrUBljBSY5RJr+1iDAALKGc6CKFHZzmTRYvfZWJeu19fh6xmBu/CKqmbjIDcqc6mYX3152WjIhunC38r77uL28kLYQhXjXVcXzsHd7rkmMttgwohNjETDIpgp74PEOefO9TqYM+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418410; c=relaxed/simple;
	bh=R+7ZPnYQcXce8ZpkdY4x0CJdetcqEt/+Ryjg1pBNTl4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fGVZpe0ug0lj48FM/1udZxtCKVpMnLKdmk9IpYimRLfZSZ64yWJ+V8DVq02cIK9JonJxH3Pko9AXvcDsm743pe9/CGM68vy+K5bMSBJc1mvQ7io7GuNAUSjx8Dt6tYE6v8/jMa4UXe204Dgh4FYbJPfGKANIu51hNEum1HtQyM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=FB2cmxcQ; arc=fail smtp.client-ip=40.107.74.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="FB2cmxcQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5xfBeOFshfPPrGWm8qP+cYaUcMS7oYcHd0o3LURhzf4UXz246ngFhzyCB6jD+R+dzRMT6fsU0dJxlAtwCtQYUOMbjtugqQ8drwvtU8O8fmd+DYTVhuXevehSwi+/2Y1BDIXRsY0qB+2qMI3QH3IK+BsOksgQJtl9MNAHE31rsadrFQnx8F0PGmQJrf6aGxeqBQdVRcKERf9dqpOaRSJglMpxRiWv3FNoisNoWX3N3wvxk6Xwjk4d9f8CrQA+olGRv3a0n/ep7a7QDYmp9/7Wre8wF5gf0sqrt52dXpSMXIHMxhpoVu0coLzXh+F7OEAZKr7FsU1ZuadYg6v37r1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkiMxO+VWXPG0t0wYz0KUM83U1jRVNNr3/qSG6HEuZ8=;
 b=Ch1fIJiIaOe6ea3YuQHV98PM0D6aRtEZLXyItR4uzO+UKl7GX7DMTrP4LQ55Iq50UHsdLIh89gnguKJnVbLndsnNK/gDGZHppCFeLhcz6MCbwN2LQlHKNC5UNtEbT3BQUv8osrm3UWKS6gurEk13wmQF86Kdx9XDzu+uSsqhK5S5Ou/J6vzt7ggJ8N5XtjyLYdXAL+7VMj6aD00zMKGwiMdZfW6D9/TLKErDmR3oE+qG6qGhbFPiLoOINwxk9WYTo+qYwmXdhDO8MfQ/IB11TeyMvkdVP/6Jjj40w2dImflihVcAuDnLImCLLI38Ekiq8j413K5G9erCHWbyCq356A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkiMxO+VWXPG0t0wYz0KUM83U1jRVNNr3/qSG6HEuZ8=;
 b=FB2cmxcQsVdGorvDNKPwajGWluubx9GNIcfXNhLXlopNSF5Wn4GNbr+lWxgOkCvKDqkJPW5x5aAsDDjteK/sEPeUZ68/0eVgVTwLuRgV6h4uBj5SINme2OJmGc0Hoquuvqv0vIUg3uRTZanK9wMURTgZtT7AobfXa0sI7kGNILo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB7163.jpnprd01.prod.outlook.com (2603:1096:400:f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 06:53:24 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 06:53:24 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Li Youhong <dayou5941@163.com>, "wbg@kernel.org" <wbg@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Li
 Youhong <liyouhong@kylinos.cn>
Subject: RE: [PATCH v2 2/3] counter: rz-mtu3-cnt: check pm_runtime_get_sync()
 return values
Thread-Topic: [PATCH v2 2/3] counter: rz-mtu3-cnt: check pm_runtime_get_sync()
 return values
Thread-Index: AQHdOQvGz3tF1g+6rk2DANd6PRDbkra8br7w
Date: Thu, 3 Sep 2026 06:53:24 +0000
Message-ID:
 <TY3PR01MB1134649222A8DFA98891DCF1086B62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260831054407.1695146-1-dayou5941@163.com>
 <20260831054407.1695146-3-dayou5941@163.com>
In-Reply-To: <20260831054407.1695146-3-dayou5941@163.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB7163:EE_
x-ms-office365-filtering-correlation-id: 53c4a5c6-9f03-422f-bf77-08df09880c8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 eu65o8w5MLwe4ILQ3brc2pTRU9gAeD0QeXnbMkPJoFzdJdbYg3o4lpI/Goueeqs6rEUnksSSlo0Ig2CwHoMc0us1UugUAiklwpUCcomlyYFm/H5Wr7TOVQ7pdjt23Zbsf3sw4S8vmwaSuBmBjWnx35c2VeQs1WW45kVWJGysC0Y624/GM9DDI+AwOS1uPvlK4cWiUmlTKt1EAv9I4RUqaojmmQKgz43+jTW3XKwRo9D/08uBj5rwMTll/VVHbbxRcoUQr2lL+vzhpaxzl9BwN5sKtB4XYM5od79ULUE6Xt468yQjjubtMg9riQNiJwse7sTPIY6JdHoaw70Wb5bgShgs/qwIQVesgVzXpoJ1HexvxAUAZKYSTzZUyLmERI0ePqhMENOyUTnssJWTNxQGE5aQ1aYwEwtNz9kRjuTGUYYF7PB8xWryWClx6lyZxlvqSHmXhadZjEoLRXKwmZDg2y7RO44g/T3BHbodyzhuYr/jD1DkpA4Dfo/Cvj/8NYihDn1HQ6qN93S5PBm6wJPCCkIJ5wpEBSGEZC53ZK1/dwHv+FYLrxJTNQtc6ajtk86oLBKPKFy6TPtQNSYZmmx8jxLHMQsq6dHM8ebIyrWbJhwHI/zU4kXc3D33DTUYji09I7iG6p4zVJkIq93b45DWAPpSw+VywKiU0RmP4lo+cP93xBHnh5Zg6ZReIKFW2vClAtWYL4AtNxp1oAQvdqyO75IzXikrCiD+YUwxV/JHfCQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NruaJ/GeLviQ0xifvXwDZoUsN++DZZzXPEIa3YgGZy7NL4Vuu+zx228afLN7?=
 =?us-ascii?Q?Pd3WMdoRUenpYjlxlkyfnXKQIeIb5k5HDQ+0U5Ya8h87xXZ+KYvWAfIE7bTa?=
 =?us-ascii?Q?9h6uxbtirE8qQvZxH7jmjTUjQ7CozcH+x5tVVVwZUjPWWWo9cBBjaTcrt7AU?=
 =?us-ascii?Q?9bqgB9QtxcKZOaDM7LbmYCqMgumRmQi2Zgi4LGDiYIU0KvBiih1r28rY84R3?=
 =?us-ascii?Q?ov5vXdXiwrr24A6D+E5Dtw7dSb5JsjkcGkNMxiZ6MVfPqhYUlIua8sYXTXMM?=
 =?us-ascii?Q?xhqs2xziKby6lKczjRpAPbTC/YiQUY72IXWgf4r9vqMapOlq/3/B6nUzqf68?=
 =?us-ascii?Q?qRdFfzNIm9yfs9omJDACOF7hAtlZx8NFeGIomnBivCjac26e8blV1NGIb0xz?=
 =?us-ascii?Q?cj6zTosl2PTg/DAGO/mefyZp4NHmHjqLH07RqVT2IRoa5Hfi+8TL7z+XSiFT?=
 =?us-ascii?Q?0BWQrs+zXjDIqV1bk9xboxuD4l0Smwa/q2bQ/oSenzBK2y4h0+dqa31hiTPU?=
 =?us-ascii?Q?urYdIhP6Ase/Bti3i8A3tSW12mH/XUOre4deW1Yqk05GncAkuJIAPXU90nLb?=
 =?us-ascii?Q?z6yiFNhuf+PkXmsajjeRZwcQRAobrWgOtKBI5UGlDN22GcPmiAU2OniibKIn?=
 =?us-ascii?Q?zFL/6QHhPEA++xFkN/yEPrBmF6gLZXEtOB6iRe48illx/2ZmqXD8MEvkjEjg?=
 =?us-ascii?Q?oePDOuyEuRqkANwWHDrXC25XGCtSqHlJSWmJQkg6dv0eGLrNh14uE2LqGYln?=
 =?us-ascii?Q?tnrIwWBqa8LbZoERqO4n5fkvxx/X+a4iHCBfZz72jKippfS4rL/T4L7eR3hS?=
 =?us-ascii?Q?/jBpB0xCEp99Jt4iiHF76jNLqlyq6JkxHIERN6mUUfK8qnZj8Uuy5MAi+c7h?=
 =?us-ascii?Q?fnmwf1v3EZL8gSU64ormxYTD+FHWfiUkBW4jpf/aQMKIBALOJjGm0grFOpkL?=
 =?us-ascii?Q?k8GGIlW9k+fgdtjLgY0KyjV9rFkxf0sD3oslujZ3qHUdYbcdX9+zvDIH/fWY?=
 =?us-ascii?Q?peCmhunwv3AMxaz4vcbVR66BwQ+FZtz9VCy8IUwUhPy7799X/0WhwiK42euv?=
 =?us-ascii?Q?dpZzPR9V8EmzW1PBpMDAAsLsx8Y5BwDnBWRj+x8kPAbzqErg0gd3N/piDfWR?=
 =?us-ascii?Q?V1KbVgOPAx7AjaLb4BHRMEF7zwspGqnb9+otretmsRT640bbVDvvLvU1bHiE?=
 =?us-ascii?Q?z6pzE5eQ47v2BaosI3K8CedjPJeNkUpFVKSp0s8piifCjTO8sz2IuV2gGaHc?=
 =?us-ascii?Q?Nrk6ylpMzkOW2834WrqJNjn+wD028K6yGwv8jSQqHWICllk4o+kdfeNjHDLj?=
 =?us-ascii?Q?v2MfQDTvrCzIl5bwf1saodwfhtkww2c7Rm/wc6KZTYuE9dKmOKvRs1p80Bil?=
 =?us-ascii?Q?wxG2HdDT9hNyWIj7QD2O01n+uXPo37z+tgbT9/QUAFesPxAQQrIt/UQnUW2L?=
 =?us-ascii?Q?ib1jVDysR4Fq8WDnUyDLE7FsbyhGbd57suBqwpcJwcxYdOkX4U+6v4RLtHgn?=
 =?us-ascii?Q?LGCJ7MHZY1NkblChI5iC7QPiWtP18er4vBfdeIUgygMCYr5hTI0uF2xpXkBo?=
 =?us-ascii?Q?kqe/cB4QQIXBfdwLVp6mgLnAuTpWRPGPKrgkfa5M1F2Wn6GmdsDklXEtaP9r?=
 =?us-ascii?Q?nkwIpRpKQrOtBsiiIJQkMQ0v74rHy4jIkEKpWKkk0qxFtIt2bbPOD+k6oqYB?=
 =?us-ascii?Q?6a+I8ChS9nE+J/ibep0jkuBQmVqteFAHk6PeaCMNfZzutIgB/jwd2C/Cg9Rf?=
 =?us-ascii?Q?9POq3Cfz/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c4a5c6-9f03-422f-bf77-08df09880c8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 06:53:24.0604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7k+dxagQ+gr4N+jv8SG1rXmSybLHmqsoJJAxUTKFXrc2MpZ+7ObRBTYxhzo2Fjk5CNwuor6C/At8okiFDCfJD8PqtA9OFy+rn9NdCP0ez4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7163

Hi Li Youhong,

> -----Original Message-----
> From: Li Youhong <dayou5941@163.com>
> Sent: 31 August 2026 06:44
> Subject: [PATCH v2 2/3] counter: rz-mtu3-cnt: check pm_runtime_get_sync()=
 return values
>=20
> From: Li Youhong <liyouhong@kylinos.cn>
>=20
> The driver ignored pm_runtime_get_sync() return values. When runtime resu=
me fails, pm_runtime_get_sync()
> returns a negative error code, but the driver continued with register acc=
esses anyway. Check all call
> sites and propagate the error to the caller.
>=20
> Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> ---
>  drivers/counter/rz-mtu3-cnt.c | 98 ++++++++++++++++++++++++++++-------
>  1 file changed, 80 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.=
c index
> 3654e0fdab20..17912491e522 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -102,22 +102,27 @@ static inline struct rz_mtu3_channel *rz_mtu3_get_c=
h(struct counter_device *coun
>  	return &priv->ch[ch_id];
>  }
>=20
> -static bool rz_mtu3_is_counter_invalid(struct counter_device *counter, i=
nt id)
> +static int rz_mtu3_validate_counter(struct counter_device *counter, int
> +id)
>  {
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
>  	unsigned long tmdr;
> +	int ret;
>=20
> -	pm_runtime_get_sync(counter->parent);
> +	ret =3D pm_runtime_get_sync(counter->parent);

There is a better API for error check, pm_runtime_resume_and_get()
Which will avoid code duplication below.

Can you please switch to this API?

Cheers,
Biju


> +	if (ret < 0) {
> +		pm_runtime_put_noidle(counter->parent);
> +		return ret;
> +	}
>  	tmdr =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
>  	pm_runtime_put(counter->parent);
>=20
>  	if (id =3D=3D RZ_MTU3_32_BIT_CH && test_bit(RZ_MTU3_TMDR3_LWA, &tmdr))
> -		return false;
> +		return 0;
>=20
>  	if (id !=3D RZ_MTU3_32_BIT_CH && !test_bit(RZ_MTU3_TMDR3_LWA, &tmdr))
> -		return false;
> +		return 0;
>=20
> -	return true;
> +	return -EBUSY;
>  }
>=20
>  static int rz_mtu3_lock_if_counter_is_valid(struct counter_device *count=
er, @@ -125,6 +130,8 @@ static
> int rz_mtu3_lock_if_counter_is_valid(struct counter_device *counter,
>  					    struct rz_mtu3_cnt *const priv,
>  					    int id)
>  {
> +	int ret;
> +
>  	mutex_lock(&priv->lock);
>=20
>  	if (ch->is_busy && !priv->count_is_enabled[id]) { @@ -132,9 +139,10 @@ =
static int
> rz_mtu3_lock_if_counter_is_valid(struct counter_device *counter,
>  		return -EINVAL;
>  	}
>=20
> -	if (rz_mtu3_is_counter_invalid(counter, id)) {
> +	ret =3D rz_mtu3_validate_counter(counter, id);
> +	if (ret) {
>  		mutex_unlock(&priv->lock);
> -		return -EBUSY;
> +		return ret;
>  	}
>=20
>  	return 0;
> @@ -165,7 +173,12 @@ static int rz_mtu3_count_read(struct counter_device =
*counter,
>  	if (ret)
>  		return ret;
>=20
> -	pm_runtime_get_sync(counter->parent);
> +	ret =3D pm_runtime_get_sync(counter->parent);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(counter->parent);
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
>  	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
>  		*val =3D rz_mtu3_32bit_ch_read(ch, RZ_MTU3_TCNTLW);
>  	else
> @@ -187,7 +200,12 @@ static int rz_mtu3_count_write(struct counter_device=
 *counter,
>  	if (ret)
>  		return ret;
>=20
> -	pm_runtime_get_sync(counter->parent);
> +	ret =3D pm_runtime_get_sync(counter->parent);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(counter->parent);
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
>  	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
>  		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TCNTLW, val);
>  	else
> @@ -203,8 +221,13 @@ static int rz_mtu3_count_function_read_helper(struct=
 rz_mtu3_channel *const ch,
>  					      enum counter_function *function)  {
>  	u8 timer_mode;
> +	int ret;
>=20
> -	pm_runtime_get_sync(counter->parent);
> +	ret =3D pm_runtime_get_sync(counter->parent);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(counter->parent);
> +		return ret;
> +	}
>  	timer_mode =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TMDR1);
>  	pm_runtime_put(counter->parent);
>=20
> @@ -279,7 +302,12 @@ static int rz_mtu3_count_function_write(struct count=
er_device *counter,
>  		return -EINVAL;
>  	}
>=20
> -	pm_runtime_get_sync(counter->parent);
> +	ret =3D pm_runtime_get_sync(counter->parent);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(counter->parent);
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
>  	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, timer_mode);
>  	pm_runtime_put(counter->parent);
>  	mutex_unlock(&priv->lock);
> @@ -300,7 +328,12 @@ static int rz_mtu3_count_direction_read(struct count=
er_device *counter,
>  	if (ret)
>  		return ret;
>=20
> -	pm_runtime_get_sync(counter->parent);
> +	ret =3D pm_runtime_get_sync(counter->parent);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(counter->parent);
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
>  	tsr =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TSR);
>  	pm_runtime_put(counter->parent);
>=20
> @@ -377,7 +410,12 @@ static int rz_mtu3_count_ceiling_write(struct counte=
r_device *counter,
>  		return -EINVAL;
>  	}
>=20
> -	pm_runtime_get_sync(counter->parent);
> +	ret =3D pm_runtime_get_sync(counter->parent);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(counter->parent);
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
>  	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
>  		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TGRALW, ceiling);
>  	else
> @@ -504,7 +542,11 @@ static int rz_mtu3_count_enable_write(struct counter=
_device *counter,
>  		goto exit;
>=20
>  	if (enable) {
> -		pm_runtime_get_sync(counter->parent);
> +		ret =3D pm_runtime_get_sync(counter->parent);
> +		if (ret < 0) {
> +			pm_runtime_put_noidle(counter->parent);
> +			goto exit;
> +		}
>  		ret =3D rz_mtu3_initialize_counter(counter, count->id);
>  		if (ret =3D=3D 0)
>  			priv->count_is_enabled[count->id] =3D true; @@ -543,7 +585,12 @@ stat=
ic int
> rz_mtu3_cascade_counts_enable_get(struct counter_device *counter,
>  	if (ret)
>  		return ret;
>=20
> -	pm_runtime_get_sync(counter->parent);
> +	ret =3D pm_runtime_get_sync(counter->parent);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(counter->parent);
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
>  	tmdr =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
>  	pm_runtime_put(counter->parent);
>  	*cascade_enable =3D test_bit(RZ_MTU3_TMDR3_LWA, &tmdr); @@ -562,7 +609,=
12 @@ static int
> rz_mtu3_cascade_counts_enable_set(struct counter_device *counter,
>  	if (ret)
>  		return ret;
>=20
> -	pm_runtime_get_sync(counter->parent);
> +	ret =3D pm_runtime_get_sync(counter->parent);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(counter->parent);
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
>  	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
>  				      RZ_MTU3_TMDR3_LWA, cascade_enable);
>  	pm_runtime_put(counter->parent);
> @@ -582,7 +634,12 @@ static int rz_mtu3_ext_input_phase_clock_select_get(=
struct counter_device *count
>  	if (ret)
>  		return ret;
>=20
> -	pm_runtime_get_sync(counter->parent);
> +	ret =3D pm_runtime_get_sync(counter->parent);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(counter->parent);
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
>  	tmdr =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
>  	pm_runtime_put(counter->parent);
>  	*ext_input_phase_clock_select =3D test_bit(RZ_MTU3_TMDR3_PHCKSEL, &tmdr=
); @@ -601,7 +658,12 @@
> static int rz_mtu3_ext_input_phase_clock_select_set(struct counter_device=
 *count
>  	if (ret)
>  		return ret;
>=20
> -	pm_runtime_get_sync(counter->parent);
> +	ret =3D pm_runtime_get_sync(counter->parent);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(counter->parent);
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
>  	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
>  				      RZ_MTU3_TMDR3_PHCKSEL,
>  				      ext_input_phase_clock_select);
> --
> 2.25.1

