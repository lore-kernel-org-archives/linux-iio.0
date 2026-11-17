Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794924279;
	b=VPEZUb4kahu+WBi2Ni+NrdqJBuHR7+cMPY02ghCe5XFs03C0ivgIrB5a7Y0dqnv+yQuG
	 aimMToqmk6442LSP4Jn1H8SlDhnALPdp1yPe8ikDhJsWvCFNG0Q0h3ccoKUXNzA3K/rMd
	 Qy6Nb6QdBhDJX8m1CVWzO45TC8TE+kxhmI4rf3fEOBJ6s+wPk5WcYewixvf0n55RgwlI4
	 5lpLnJS1DyTORML/a99/jwvmscZM0VOHSojn8HnmKN+mKNiOrNZuTy79IF5fO479aRehK
	 oNufnfgAxAP9m+TSx1za8a/dVR3g170iNRmk7awz8e7qnKQx5/DXcnrKJmrKvrcTtTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924279;
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
	bh=g37K8joTEcdV0Lhw+y8yxCKJX5YyXREm6njxHZujLMw=;
	b=iEtpEOsB5IMYOVcHD3MzaG8OdOA8iK9U6W9lSG88npuq4NBsGHDs94h9klWhu4Vo5p0G
	 lIaTfUPQpg6AV0h/L6Rgg8WmPNKbiG+v3AMUaitg8YETGTrmRnegDzrIjsKu7KiHwCt8+
	 47slPTmmb0T0MViG4vnni5qMtjiPySd8UAx3h2H/smOOmQ3CEswKdnVM0GCD5E9lmO22b
	 7cEdk2fHQ0dJ5TBl6Ngp9YuCTBq1pSALxzRvBebFncWrIVjdx7MxUc3g7s9+Mpcqw2r+f
	 WE+5PN73dlTvn5GIKQThysKkY2B9z6nvyZRFkntvWu6v6SDx9YNyyN2gx6rD4c3yDoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=YWJkc2NO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.19
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011019.outbound.protection.outlook.com [52.101.125.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D5F606A336;
	Tue, 17 Nov 2026 14:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61D5F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=YWJkc2NO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDIR1CRM+UqVghIrxq0UbXWxMw4JWeZHPR+CumZNVQK8foRnObB+9mTRg+nPkqdZ72jEb5R24HgVLPLbYw+niWVHZrb76hBR4OUv2Xvt8CzLN4wrq5Ky04cTAclh77KhmPH88N8XFvgs3fG05k1s3oGr7cS4f545fLj4flmkL9wCctp2l38JaiHUzFTCSI8eZrqOL8ggJydrSRz4I8sWFz/hk46mIt0sf41gs1TGZjc/tSd9wENb5rSkqyaAtBrBwJFXtTPYzU2IqFXwDW8hYkiYuVjq+U6VPef2w2Ee3rsck7hZtkf6o4j5kpufRlBTAvkpa5h3kprHc+cYdBzhIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g37K8joTEcdV0Lhw+y8yxCKJX5YyXREm6njxHZujLMw=;
 b=s0N3qT8/M0Fgw3Mct/GdCIlHUInwtLQGaF72sxk2SfN2qNfB0r2szGrkm1ZuIfU1wonS1a1HztmrWpibdrCdcfoQgVg/cHtmhckEIfepGZ0yIrn7qqHuBov8TRF2qziHs2DG/rRkXM/prthZffNHAnhqiygiyooxW2Vskf11pTam01yta/UaLNzwkwYQWGREEQYInUa5QYdAZb/k244MAbmXyKJ0nYTi4zttdt9uGSrmSMJ0C53HybCe1G9M7KTYccslK8RN37XO4OahwFVgTd18U4+MlMddoon5Jx4gqoSBhupWf6WT8+NC2hSBaMiLQ81caEja/udZOaw4lZuSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g37K8joTEcdV0Lhw+y8yxCKJX5YyXREm6njxHZujLMw=;
 b=YWJkc2NO6b2fWQuNQNvbZJBCkM8QzjXbFyqSlyUfTdAadT9pi3R/wnYcZIjXYPhoQYoBofJ0yj0Qr7Sa7VeWRueb7aOPxPlQYi1adBdIRBkoTS+5fCKR3fTUnaHUu1hPCk+xCXY/oTl51OuqdgdvmVgdOSRC9tmgjBGwBzJ9bag=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TYYPR01MB6553.jpnprd01.prod.outlook.com (2603:1096:400:ca::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:04:36 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:04:36 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, William
 Breathitt Gray <wbg@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cosmin-Gabriel
 Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: RE: [PATCH v3 01/14] counter: rz-mtu3-cnt: do not assign struct
 rz_mtu3_channel::dev
Thread-Topic: [PATCH v3 01/14] counter: rz-mtu3-cnt: do not assign struct
 rz_mtu3_channel::dev
Thread-Index: AQHddn454WaZ/VYdckCYW9W4dR5ghLcyS/+A
Date: Tue, 17 Nov 2026 14:04:36 +0000
Message-ID:
 <TYYPR01MB6603829DE278F797852ACF48867B2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261117102607.2504551-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20261117102607.2504551-2-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20261117102607.2504551-2-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TYYPR01MB6553:EE_
x-ms-office365-filtering-correlation-id: 0a2ebb29-ca03-4068-8d08-08df44b3b6a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|261009223027099003|7136999003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261021123027099003|261026121527099003|38070700021|261021121427099003;
x-microsoft-antispam-message-info:
 0zVtkuQIBIoQ31yeiSTN97vddFtG8aI0wxZlMC25YmtUL+CGNZWvCrVZ8BPIb7C7jA3ovoNHbMU8JwHfu/0GwPR+Uwq9QRhIlK+id5rpkMoy9//8fSydo9omSDsgmp5G8SwJECPmsy7P1MOTuvjPE0b36b7SFTFlNUDro+KKzVZkVZV/Kdqd2RBxavJCfmC9E2Uqx9Rn2dthkS+q4XDKgEgQw7z7yF8F7BYeq1tdp8QrIkm7JsuLR3Rcd4hbcIPGrzq7EryOkMSS650MlttP6Xq7QpVXSZQ8aGOtHQMtr+ZJ40kvNQ8v0d3AYaYV4KzNAEpCzyzpFX1k4dx+NvxM1TQbugRRkZ3ygUoOxcCvtx6Z/dPbtvQlP+lZXDuEvnl0ZfQPIpc/J9G345/FPTeTPDBRN0hkSgF6iXhfHiOKrbHGjvo5UfsTaSklXL1m+JX3ZUCFQzMnLzrW1ir5kHupIzAxRotCFdfksftmbw7MPrD0iaRoQoF7cIyXceoyl2gTGiSN+/dXfyb0mjf4gb6uenLuKRqI8mUQwct21FQNwvzT+0f7nR/AW3Wp6NvFtRJEN9bqKowWNien4t8m0D1/Eo/dcEFs7bMu3cQu2MnxCLp7tGjwHBDGr3JFIvbyjH90aF4KDc11fBMCzHDKw3qkV9/WcIrUydkSlvl2DRaJ1CbdlWuE+QjSWeFBMje+r8BSXqHaGm+2CNj8SGTSSU7AJfIcb3w5m+usZ6yXCMmPq80=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(261009223027099003)(7136999003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261021123027099003)(261026121527099003)(38070700021)(261021121427099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Xh0Q+nggtIU3PMm6intkN+HcYkyKUtNUtRg7QRpkJ6vAgWNv9wNB0NlNw2Gp?=
 =?us-ascii?Q?eHrggnQ6McJmJs70Qm4gHE9qhBPrEiVQ8lQcJP8fDD16o/eQ8/rnXwnv+Hye?=
 =?us-ascii?Q?c0qB31vFsOlQciMjkNJpkuhryepBnCCBNJHYPxuIBnZtzvezxVSbQt+b+vd6?=
 =?us-ascii?Q?vjq1+Jbuog1lINai2o9BVJwSpc2lvMuHtCTHISkN2GATvUkw9LD6n4Nivhgx?=
 =?us-ascii?Q?oOOmFyDyDQjXhTQwztM87/XnRXls23GHnTL2wQSMAJ3Q0KsoREWbv1g3R1uH?=
 =?us-ascii?Q?16mErGlNY6f9pm9VHYlPbcx5pg8uOBSbGhjr3tFsqaQgLhhpg/fdmsk7Salv?=
 =?us-ascii?Q?kKfz7DhqTMSt+AN3MNobXG6ScC6TJ6gmU+0koW9aziDrxWdyZR1ZTHxaKYX4?=
 =?us-ascii?Q?qlbSHYXTcSBY0UlhlcXBAT2+f10E97y2MfkgRaovDywFtzEqXUDj94Vwox6W?=
 =?us-ascii?Q?hiwwal+KgNyHjf81wubxFu7xyKdBsVSdHaicBLkEPvzBqJJQvvogamGqJB3D?=
 =?us-ascii?Q?SfE+KIIH3gBMV7s2Yrn0xH+OYgaeF2HLNaIPzNig9dNGBd2SOy9bu3MsiOST?=
 =?us-ascii?Q?juYCjGF5Tv2WtfjzVWrpq9vYOUPrtZQMpPKHn93QYigcMIv8bn+i2f3c8UPe?=
 =?us-ascii?Q?QsruMSwaYLcms8jSlUC2WNP4EQgWBGS03qWnW2Fx71NimYn/W9x36EyqPUDk?=
 =?us-ascii?Q?IA0LoANR8kRoJO/Ppgruu8mmUQPAtmnDtJ2HqjROMNp9lSVVFcokcgxEtkzd?=
 =?us-ascii?Q?qJ69ajpIAq/SXYUsSlweR+lR3MjbzJrL16Xmg30eG/+p7vfu78vD066YnFtC?=
 =?us-ascii?Q?WE/orDQzj1h+sMcg//MZThzYjrdBpWZNtbbL3GWRWwDNWTY1LfXnExQEnxcm?=
 =?us-ascii?Q?c4Ap3XljkIxJDqhxdBPelPmUQRTwAgn8UeG5fUgN7BXyxMqot7dL0RnoktOa?=
 =?us-ascii?Q?T71w9h5cxwo7vd7iK7naxF4nDrCvdOMBqFro40UIN8AKBPHv4o23yN200ENL?=
 =?us-ascii?Q?iu6U0D2eXgDkcwpQkzbs/SrV+qEycYh8UKdlYLGzYeO/Rl4qxhHD7OvbHbhj?=
 =?us-ascii?Q?S5y2i4Z5MoJFEep7jSnifihBIR8dRIlT5DWcwhA4vtuyHgfNpx20M/5RQ0M/?=
 =?us-ascii?Q?HSr3IcG9P8b6/USvJZEr/JNGh2gwg9wwRJb1rcFqDVE2BjFRV/bP78X9Qtcg?=
 =?us-ascii?Q?IFw2lSIcKt9wxc0/lTkJ2byAXAsBaURCFwskH6sQr+SkDwREh1U1jZzu8dWg?=
 =?us-ascii?Q?VUMC3kzMYfxzf3C/R0UXirdvEvQOEne+KnbCM1VTWbzlhG4blPjnNPZIPJC9?=
 =?us-ascii?Q?YAXuDklwMHXbpSpLrF3DGYFFxf4+xca61Nr1edcb2QgrInD7X6/ywYqr1aRo?=
 =?us-ascii?Q?kk0WpbIJUTVUIJLsvBOUeC4YUTQIiSd1NjBd7ZLVinv77Sc3TnU8l9E3+QP/?=
 =?us-ascii?Q?L9/4yfPXZhZ0HNZSUapQTM/hYtCfDTA9FaB/S6QFpI3mvUj/UHBfAhaUiFfJ?=
 =?us-ascii?Q?vP9JkF8FDyeIGc0+b9H1IdoxVGZE6Jykuvrrgwhaa/E19w5luZnRmKMcdhWm?=
 =?us-ascii?Q?QKYl9bKC+F9VVOSXqq+r2whfaUdQ9/k9aHn16BczKMJgvUyk/kzlmXUIdaBH?=
 =?us-ascii?Q?nbjit5TvRLK1gKHRwFTcQdgg2VzgD+9D4jUc7bux2Qt+s1eDTrYp3lz/EVyM?=
 =?us-ascii?Q?F6pYh5Ntsdd7S1QkwIv+7G5rdEVZaq8NYOiI0KyZkeAh5iLLpqwd1+ai/+ad?=
 =?us-ascii?Q?2FXysJ2KWA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2ebb29-ca03-4068-8d08-08df44b3b6a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 14:04:36.3563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8YU/nWtLbwuyfwt9N2BG5WDDpRH753Hgi2IauNxRzHWbZpfPsJ8/P8f7LJumjojbhX8GVBZWFxPIgxz874dA8Gn6HnPJW1qSd2+ngTrnk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6553

> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: 17 November 2026 10:26
> Subject: [PATCH v3 01/14] counter: rz-mtu3-cnt: do not assign struct rz_m=
tu3_channel::dev
>=20
> struct rz_mtu3_channel::dev is now unused. Remove the assignment to prepa=
re for removing it entirely.
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
>  drivers/counter/rz-mtu3-cnt.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.=
c index
> e7fe8bf45164..bafb8ef82afb 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -842,7 +842,6 @@ static int rz_mtu3_cnt_probe(struct platform_device *=
pdev)
>  	struct rz_mtu3 *ddata =3D dev_get_drvdata(pdev->dev.parent);
>  	struct device *dev =3D &pdev->dev;
>  	struct counter_device *counter;
> -	struct rz_mtu3_channel *ch;
>  	struct rz_mtu3_cnt *priv;
>  	unsigned int i;
>  	int ret;
> @@ -855,12 +854,8 @@ static int rz_mtu3_cnt_probe(struct platform_device =
*pdev)
>  	priv->clk =3D ddata->clk;
>  	priv->mtu_32bit_max =3D U32_MAX;
>  	priv->ch =3D &ddata->channels[RZ_MTU3_CHAN_1];
> -	ch =3D &priv->ch[0];
> -	for (i =3D 0; i < RZ_MTU3_MAX_HW_CNTR_CHANNELS; i++) {
> -		ch->dev =3D dev;
> +	for (i =3D 0; i < RZ_MTU3_MAX_HW_CNTR_CHANNELS; i++)
>  		priv->mtu_16bit_max[i] =3D U16_MAX;
> -		ch++;
> -	}
>=20
>  	mutex_init(&priv->lock);
>  	platform_set_drvdata(pdev, priv->clk);
> --
> 2.56.0
