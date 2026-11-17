Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794924340;
	b=2fbfcObb+Pet4wbdFJxP8feq83rrCJkq+Qw0uPVz81xj5Q64wHaHQ+fN2135efKFJk0N
	 8GuTVTUkqxT90KMKEEYMUiipUc74QK/HyRQwDHUcC0wkgEz+6GNp9G2Vm1xmWd/VRMPQj
	 TVeMbU0XHxXBwCzoL7yDXKty6I55v/1yvMmDkDwrVOMx+Oap0EIp4a5Mx75J7UfrCtfrx
	 au6yL0xsZlfgag0uLZiNfgEWBsYpiSXzOzoLPfOrXCms8Gp40GEbcvT8heYcHCX7Ah8+0
	 Zs1AjeKjsHpA+9DxBzqYlP73facptIbJrWJaAUk/pVfS2BFOFE+BCPYF1LhObr6itzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924340;
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
	bh=ee5Tk6lgAcCkLjzs6U3Anf5SSsQsGAjfR2RzEkIfrMY=;
	b=LDUoEErRF+LUE2u4Oydsa4v+1KH1BJ/ck/PUph6TFx9CqFnEKDzwalLwJPTZY7qsVk+n
	 a0mDSIANTiosltUfPjl8sY17oy8JvGwtcbZdABqhq/LtHQ0c/NTps1MN1Au4gKcnPzb+q
	 Zp3bNHgYCcXPwEjvEOTkkLs4PsF6TEbbLItztDzTyUMMLKnqa5fhW/NofwR37cxx6aBbg
	 Y31kKfI/igAXw8NRTheHBFtfOh0KHMWDimI5KpRxJ+rnALnyU86Fols1QSo/xzKznFxKw
	 YZGIaIkaQaIJN0f3O7FPE/HfC9KcZQwRgtEd14M9/XcKGGRK6gJ3G7Tr80ocOyYyILA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Dbsc4ftn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.22
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011022.outbound.protection.outlook.com [40.107.74.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62981606A33F;
	Tue, 17 Nov 2026 14:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62981606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Dbsc4ftn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHlFbQgemv4sqweBr5mWBA0zncUmJ8u+ZvB1fE3Dq4QfKVdkbbZk/3PYO1PEFS2P4rMovPjqbJaAQb1KU8l/XXBRqghsz2XTRjqfBtOdRCboCnxLk/2CrWcCVZMsIdxeEoNBs1MI5D72orLOOfxKt92rETEhp4nKEsH5+1aahi2fkIw+MdT2c/MWzuqxZJSGA7D0a+zSKfdTHOlgoSVpBiQIDARZjVNfqxMsF+alZ9M9K3RosEx0RrpxpJSqQTJf/lYjp0Br+Hd9ML4qgdHDIzvGpZ/lydjmvGqkoz8GEadadKFb4Nk2ImLPrx2o0BcqaDNvD2iXUV29WPmbXOMTUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ee5Tk6lgAcCkLjzs6U3Anf5SSsQsGAjfR2RzEkIfrMY=;
 b=vNH6vlSwIy1qaj1FwVJ/oA4pte/N6N725Yi5dDuZzsNULD6u+8wh4vTv9hgBP5+KsUkrrLV83koimcJNZJTJdeaehoOJRPEyniVEPH9UPWUYEUDJtyjgjgUMzhXv+sZBdvoRABWpsHCCuuBjP8jPbhdtcFcJSBGVbxl90A0WLX2hc0of2ei3ZvGjnjtBRCzffMH8dgZFJpxq5VTy7h+OKrCK0tuL1XOAzkEdesHjxn4hP0l1SMbKtAr1igjeU1KTwnq5taB3Tg3Lqb4eRgsDh5Ii62p28jkRCeQf4r/2lwsl2T24JPKOFFUoo/t/p4zdk7vklWA+wu3+Gc9QwEr46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee5Tk6lgAcCkLjzs6U3Anf5SSsQsGAjfR2RzEkIfrMY=;
 b=Dbsc4ftnVapBZ6clb/Rnk5I547fQ6tZfxcPpRSrtgiYmawQZXz9Uq+SsTrEAFHgCDpvXHto6Xtv//9OqV3gUHC2qi78B0qezYS7J6tHMeNCtXY6q9a27VUsktDBKhKshcMAREUhRrJLVLH7I9kHT5nyRzzYSyIVyB3xsswMI+Uw=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TYYPR01MB6553.jpnprd01.prod.outlook.com (2603:1096:400:ca::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:05:38 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:05:37 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, William
 Breathitt Gray <wbg@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cosmin-Gabriel
 Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: RE: [PATCH v3 04/14] counter: rz-mtu3-cnt: read enable value from
 cache
Thread-Topic: [PATCH v3 04/14] counter: rz-mtu3-cnt: read enable value from
 cache
Thread-Index: AQHddn4+JwgwfOFRY0eCjN7ncTdpPbcyTGMA
Date: Tue, 17 Nov 2026 14:05:37 +0000
Message-ID:
 <TYYPR01MB6603A6B6F2DB198791D2848D867B2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261117102607.2504551-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20261117102607.2504551-5-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20261117102607.2504551-5-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TYYPR01MB6553:EE_
x-ms-office365-filtering-correlation-id: 3e25e4f3-4a23-474b-3462-08df44b3db54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261021123027099003|261028144727099003|261026140227099003|38070700021|261021121427099003|261022105027099003;
x-microsoft-antispam-message-info:
 twsroE5JOvEVlLNHjYONYH7X2JTI0n8I3Gt4gUd++ZwHTZ9j/+N9ajhzTbmS+sh1Wyud3Ov2gIsXO1pALu66MtDKoDpzQrP7pdFEkVrvrq29BrRkMC28RKAz1Va2nx4VdK76lVd4AwBY8kseAjBaj10HM11GBiUALyfiDq3mtLu/w0y4LAomjCGStuTL5gsqOv3pNTnggw1qsZ0y38lfjN8y4cx1VF80x3j3vjg7KlYE2glaDxmTDnGrmXDEbdGCdD6R/us0Ktb+3XrzQc2ZXS1n77fbAM2/GXEhikmnQeStKKq4Adj3sVMnVGCnUCYV6KlPHdlnTLui6xba/NFyz1X8NZxKMl3DTuw4al0gGZ1gviHsYNMWdBVdnJq6LjtgJg0snXlAQUqKEHs9Za+yb7BpgCxyGyBItgIVWzwmj2I4wZVId5qhiwgR6maVlY8ZNZwxUgmaclPqUDaRqxlPDCi083KL44uNa13osC9s+deBYk9e4KMfCkIEwZW+vEAM0gDLrcmnvHNguM9aOGxQDRy5dSzVVko9Qa4HphNY3p7KhodfxVSWy6S49yiNAAoOMdfLOm5IptKzAk/h6c3v2SLa32tBWTPwxIrZIeAT3iOLJrhi7JVV61IA/tQJddYbVlezEpeRxA0KZpq6VB0WGrh+6/9d/26pOuoUCiTHP45nXR/C7cC8dWrTsgXX4xlUm1tYeqcHxY6rfoNt2v0F/0lq42EtM7Q6ONQjfm56HCM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261021123027099003)(261028144727099003)(261026140227099003)(38070700021)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eRD6CLBB1xm3tE9ZH6MfwONZQw9G83P8ciEuHenbBTqWjbVhTSeKU3hgapIc?=
 =?us-ascii?Q?BHIs4gs4HXnheRw0Lr13yQPvuRnJEUGscpMV0PGLqRMVcxY8I32N/7rrcAtK?=
 =?us-ascii?Q?jIuOzmu6qt0ovT9Swh0vFEZWDLaE3hrez06Oim5QxccSoC/vF+O5GrW7UHRN?=
 =?us-ascii?Q?cWGeP3dxRVsaRFHQimJyiaQpQ4nhClew/AJiYAZY5vAybMdUAM5XYuuveELW?=
 =?us-ascii?Q?W6Xat4mMn63zyJWYYFkdmLuWXkQg8IhvjLI8Xa53V9cqZCZxVoARVqYsa5vm?=
 =?us-ascii?Q?4ZUzgQySdB8jaf5OD8O7TuGt+ZDphgzmXxXIlTCk8hNvGJ+tM/20lO/yoTXT?=
 =?us-ascii?Q?UsAvSRmXzyJI9NM447gZpSbQsxmRYjlYweSH/pyy90EAQ3hkbKKioGALxDYf?=
 =?us-ascii?Q?sXGZaW0Aa3l2Ia91pkZv8yuCzGCuCifjmUrgLCe8famahqsDKJaoxVIQK9k4?=
 =?us-ascii?Q?tXxUFWQewOuzvJeIhU43612w1Y3RmNw94RnzctjWEej968I57hD+h06BtRM9?=
 =?us-ascii?Q?JXo3Z825gR4/obhgkbNDuIptfEdr7MmGCQj0kISMJa7B8BVB/wDwvnmI2RP6?=
 =?us-ascii?Q?17cvgdmKxTNHGksS//n8mHYic/Xm3ETjHc4S6Zpi9Zkszjj+rzG16/5HSmJT?=
 =?us-ascii?Q?xcDyrTENKAcS8jwayXP7Wx1T3AyyewdQLyXdkfKzuOdqoxHIc36ngmql5qcb?=
 =?us-ascii?Q?cZZchNs5QiADTLwD/dhIHWXWkkL53IT0ryn+v/lG/9VT3CXVULCxv8WaaAIF?=
 =?us-ascii?Q?se2kKIZO48zVs1X+t6b4SBl8g6Zoqsp4mNVn/TlC+u268yinAiCJWr5fZ6+a?=
 =?us-ascii?Q?2lwNxjiqmBPxAqmcwxscwTkGGDwvVv74d0lMjVnJhQgM9m9tVN+XA07i69Sv?=
 =?us-ascii?Q?v6kzQEvyrOoKXOJ4VTtxTlkhox/kFrRM+kEopjfuOxUq7TxCTCvpb62sxjhn?=
 =?us-ascii?Q?XVnJo0aDNo6VKey7em08aRL4+du4/YBRDde3SHhRsYuQjMtdFYRyz67Nk9OM?=
 =?us-ascii?Q?UpDGaYFDv5FnKEYJoGGaLmSIDrNbqsACYEeetqI/XIAZu3akSNqvoSJGJ6XJ?=
 =?us-ascii?Q?/4jWukmNbq7FqOk057eWMeQ0W4/RMwxuITwMeDlExX2bDNQNWrA+mbI9KPLJ?=
 =?us-ascii?Q?6nAMmyfmCELUKwK4Da+PMsNDwFD5AAKbD3tXKIIk5Lwp7jU2bLSvKKSJm7cz?=
 =?us-ascii?Q?+WpVTVfVNR3Kj0vPPi9nzmnlM8qZK9YGsWE3xmyBbbvn5tQZPtJ12u3DZgub?=
 =?us-ascii?Q?y9dZFIivGGuMAOy/3U1edas1dJiOVtVfORkKPZH0QDiCypT0x+rOH3IWnCFU?=
 =?us-ascii?Q?2iirpzytG3udSPW3mbc/ALlq/u9EO9ujsX/mx9qK4psivhkCnrWY2AyO6Dmy?=
 =?us-ascii?Q?roxGU/mijsELFw966frB0++pUxbKizjA9qI/YURuH+xUO6B4CmLHafc8caYz?=
 =?us-ascii?Q?o/1QyNF4cbHWPVeO32E0y+9c1o6bDG5aim+avs21O8Iw+cGf74RyYprLxASt?=
 =?us-ascii?Q?zwjPCHE0EEi5V6KnmiLeENVYjtrTpt9doyrDpNhsDFIHlHnJebAKZcjvm8B2?=
 =?us-ascii?Q?OAEq4wI4dK9fURJW+dYYyjO97WdUeXOv/Y3G0e+UUrwmTQ8uZsdS8HuJ7Edc?=
 =?us-ascii?Q?LHyks9P+dph5KE4uLpVwmkR2sL/Wds3gawLamG5llwNKOZ/r3KrZcqk2zs5j?=
 =?us-ascii?Q?fU+4eXjeE1Gpk9Debd4DqEQlJqou5wbc8B5XYXY9qX935P4kJhP7rMs6ZZe2?=
 =?us-ascii?Q?8MyhWGLdaw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e25e4f3-4a23-474b-3462-08df44b3db54
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 14:05:37.9030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7G+SKcxbdJAMM25bNidhHt0jzkYvRN8I6XR913MmNbmCG1R7cc3HCYLna2NaqKJZOqe7q5ja0555sGRllBq+rBk+GvnY+8iwoUH01n+3eWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6553



> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: 17 November 2026 10:26
> Subject: [PATCH v3 04/14] counter: rz-mtu3-cnt: read enable value from ca=
che
>=20
> Reading the enable value when PWM is in use returns -EINVAL because of th=
e checks inside
> rz_mtu3_lock_if_count_is_enabled(). Reading the enable value should not b=
e an issue even if PWM on
> that specific MTU channel is enabled.
>=20
> There is no need to check whether the underlying MTU3 channel is enabled =
when determining whether a
> count is enabled, as we have a local count_is_enabled array containing ex=
actly that information, which
> cannot be wrong.
>=20
> Use the information in the local count_is_enabled array and allow reading=
 it even if PWM is in use.
>=20
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
>  drivers/counter/rz-mtu3-cnt.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.=
c index
> b1848a0b17e5..db30470215c2 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -469,21 +469,10 @@ static void rz_mtu3_terminate_counter(struct counte=
r_device *counter, int id)
> static int rz_mtu3_count_enable_read(struct counter_device *counter,
>  				     struct counter_count *count, u8 *enable)  {
> -	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id)=
;
> -	struct rz_mtu3_channel *const ch1 =3D rz_mtu3_get_ch(counter, 0);
> -	struct rz_mtu3_channel *const ch2 =3D rz_mtu3_get_ch(counter, 1);
>  	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> -	int ret;
> -
> -	ret =3D rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
> -	if (ret)
> -		return ret;
> -
> -	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> -		*enable =3D rz_mtu3_is_enabled(ch1) && rz_mtu3_is_enabled(ch2);
> -	else
> -		*enable =3D rz_mtu3_is_enabled(ch);
>=20
> +	mutex_lock(&priv->lock);
> +	*enable =3D priv->count_is_enabled[count->id];
>  	mutex_unlock(&priv->lock);
>=20
>  	return 0;
> --
> 2.56.0
