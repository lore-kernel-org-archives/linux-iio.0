Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011062.outbound.protection.outlook.com [40.107.74.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EFD3932CE;
	Fri, 28 Aug 2026 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787909954; cv=fail; b=aDofp4b1cll6TUtX71ChjKH3y9M886BmWfeMU3DaIzpUUxxuSRBKloAxFm7/HX7l8At5XwsZERSCJlpL7FlohHXLnHQ5z5oojWFzVPp8g7vTh4U+tsZgrcLWbp69tDOr6TGnRzKkQVWPxiwWpxEjcBVUebO0+RwNq0n08dDskh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787909954; c=relaxed/simple;
	bh=vMOZ3fCLDQY0eoHKRFtwWw9vEOQLYs/0aacOwyJg22s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mWLb0S7J8BeIEShpXCXIXlzQPws1FpE/wOX0YGgQVdxVLHOAnzjbAqqg25Ici/bo+JfWuB7LPrRwRvqbQ9bzem5eIPoZ4j6uifydJDKaXhb8gwixZzitCpqeCo+T18sqQ5XHv8TGPisgvL+sJjgk3//L9FPPfXWskNzUKBQtbpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=pnVNzgmb; arc=fail smtp.client-ip=40.107.74.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="pnVNzgmb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5cp7dsHrV2eAU1dL6Xn6uLm7x1CdIKFyQ0wU2UVwmWvNU2JpKxSKYm2+y/ts6tp7kQpkyrqQ4BnsDs5CWkZu6ojExFp8q6RtaW3DoXnmSqIjSvWpfODGz2jS3VT4hduuhB0WfIM3N/sTx8/EYGCQDM7OMtUEONcU8RYHlqSjSuULt9pjylFs0deVEAZccrE3YS+ErVBHMFWniq3zWhjVWcLPOM8zCFA9rWHVBCljMfxIwDkZQQHBH9EtX97zPjf+lJbsYUUSmoAjK/KhVK1VhmJnmZ3se+fjHDh0s3Rb3jh4Cl0X0Or9+AF7iXmFZ0yrYHMCu+SySz4eOfh/Cursg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiD5nKTvg9t4w6GujMAnTTu75okoh38NnA6+bCQyzNU=;
 b=t7FQnT0ZRm0tuBRvsJNnQrMC3yHxhH04MwkU4BYwtNwi3Xf8H3yje+80dlXVmLzTrwMVU3+kHR33pc0d9wF1zUXUoVl7t0sdRjfGTzWDqwYrV91PubQgn0pDMr+eiCvxgEmEfPXP0g7FcDctqBi2JOSQxH2NHFKRu5I2Ux1OoZfP4ZcbUTyuzTwXWX6BnUsUb2oM8xDoy0TKoVqHErL/x3ZbsuLt36Dkg+xQ0YJoyLrAFuTg0D3BRA4yFoBBJqDp28XpVD8lidl/tz6cHMyjgJ7StzSuqFXASmQI/21pIDN0WsxZ9AaDiWrorvZ0aZO/sD0fFPwXtjTSLZml0SXMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiD5nKTvg9t4w6GujMAnTTu75okoh38NnA6+bCQyzNU=;
 b=pnVNzgmbpw+euVL5ER4xMOwFAIXeaVVeA1JZbYk899pbPG588q6IGJ9+QQUoIAZwTDVf0nSU1tTCM6VOxmIINqDijrb92GYi6nKv97K+h6uNR3NLnMnvmJ+gA4JxCHtz+Kk0ua1yOqhShLcXE0WSUtyTBcP06uIJs7M0IIszqtc=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TY1PR01MB10723.jpnprd01.prod.outlook.com (2603:1096:400:31c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 09:39:08 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:39:07 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Li Youhong <dayou5941@163.com>, "wbg@kernel.org" <wbg@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Li
 Youhong <liyouhong@kylinos.cn>
Subject: RE: [PATCH] counter: rz-mtu3-cnt: check clk_prepare_enable() return
 value
Thread-Topic: [PATCH] counter: rz-mtu3-cnt: check clk_prepare_enable() return
 value
Thread-Index: AQHdNrx3kQjs4CnEf0iwe1oHyY4MsLazMssQ
Date: Fri, 28 Aug 2026 09:39:07 +0000
Message-ID:
 <TYCPR01MB11332D67B5121D22F05E2CAEE86AC2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20260828071123.179670-1-dayou5941@163.com>
In-Reply-To: <20260828071123.179670-1-dayou5941@163.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TY1PR01MB10723:EE_
x-ms-office365-filtering-correlation-id: 2aae1409-f1f4-4ad0-518a-08df04e8350a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|10067099003|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 imMfV99+jJPdkspSAkm1eAqjiVMoBjo8pp5WVhHbEHkwvkf4PRJxMAC+OgagOgEYeDFF/SNpoTrLvAAt+NLisWJRxnLAnxHpKf/dDqtdc65d3f/GYvHgu3NOvtnTjXeUATnAoEX9RuEE9/v44faPnLKm8Idluzpgxzm1wTJaWIdNjFJYX3ejzYaIfu9eFtECCl5eBuHr0tWBfq7UUtghWJrJyCexDufRynaItpOjoIA/xzOfv07V4TREz8CiJDBtGNu4bfAqanTHXWBpFxn7LySdIVAG7DG7g2BblSAaW+B2ypw2iXT3Sd9Jl93V0TXurGjOlglBMJ4haXvHcipoWcjiwBQosuNWmvalm1FpEuvVj2xK3JFPB648Ba2z7d5DVCQd9GumwT1fijed+nxma50Olx7twA43oYlrYK63ewIRIpmfbdbgrL7eNCBj4S8LOU/jpAI/8JVrn1JfeKBlQ2GrwTImO7sF0I5EB7c4j57YMl9dpLU4dTgarvu5qbikvfD7K6MDx5TgraRJDnHU8MhszaB7wXdGi8lmbUnNKbJhWFmcYCP1w/JfCGtqFBLeZ0vM3mOWOe21qOOvpi3EY5r8fhxe8ZQ1byObMmDGqexBFQ3sHZ8Qyz1ymD5mMfCt8xiKtVbSs/O3gPQIVm8kSnua3uTwrdEcA22dwlhOhr2sXbSd9I22UzyQkIZc9mWhv3/GjEusKGTeWaXT8VIZaDf1MJkxbKWA/li9onxIV7Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9Uj73NTSOUJgI0SHtQFiN6FxLW7QDel1C21VNbY8ts7xrHMCfrZ1/wl7DO27?=
 =?us-ascii?Q?C0B5WGVPrixUDeSjMEFITDlsVi+RPsmZ3nOm8QpZ1tJBIviL+gj7bseTgdZ6?=
 =?us-ascii?Q?3DG6i+abG8b4SwaA2zbpI+QOSoBhhfHRCtISY6d9F70/BYanvnPijXXRCYli?=
 =?us-ascii?Q?7Qd3AUiHagaEHeZATpk328R+JrN59AcApXIlEsKnvrCJjTVJAEo9SlWS4TD/?=
 =?us-ascii?Q?pYPv8+Nvyk1Cuh4UhohmIOexuRCK+JCJLjn970h0eLa1EmD1yUbrr64xkI+N?=
 =?us-ascii?Q?hAMCwBHebMfPfJERSaFFqcgfj8O0+EeS+IaGacGyqUrkt21fgruMxa86XVJe?=
 =?us-ascii?Q?Ib7Q3/71v2siU8HxgnFoAoYZVjY/4mAvvLls3rUw7zQe/mUMPkv06Bkevbod?=
 =?us-ascii?Q?7VXwTnp1bkhSa02k8/SyM/JTAjyFD0GZz66npGD/qLqJnNDrfZabcHU8UDVs?=
 =?us-ascii?Q?MnU5l0Z6Ckm5pARvkoRQRdSKJSQ4z+Q29nfVPD0esr8/RmXJF6v7LUblF8PW?=
 =?us-ascii?Q?EXRFF4OfHOItwHeRxDBaqv7rrZRU1q41aJnbtLIk3XKkCEyP09IJetS3SMzr?=
 =?us-ascii?Q?D5v+suWgVRTQwvHcFvIhXxHwwQPErpXuI6wfjBT+8L7YtMTI47PRGVBSTKYf?=
 =?us-ascii?Q?VaG+DYzStXfXZTP5D7qRsNc8EoUXcC7kuuNwwoPcF3BM7UvhjMLIUXMFM9KL?=
 =?us-ascii?Q?a6mQlh06v56RrVZdQSdtsBrZ2vvT2ruDrfJgLlxQjvzZpi2G8Rb4TXg1oLa/?=
 =?us-ascii?Q?8AO8EvRTR1JcSslrA9ur31ZzX+Eqsjk4hlFItyVF13tZyVT/x1gKH9dc7lss?=
 =?us-ascii?Q?/nRb595BCroRZ0Sm8RvR7obBs/t4AMZmpt0zjPAcQiqq9c9+EyNyIha5H58U?=
 =?us-ascii?Q?fZMK64MZsOMExNjY11Baf1iaEEmXJ6cLWZSC/ToKEM2lP0y504TNuNM9cDrc?=
 =?us-ascii?Q?V2vDWts3X4mvD/mLq+YywWvp2/olVMNHPXdx87wb3WK+1StIx0JSCTy1qSHV?=
 =?us-ascii?Q?Wf9SJcDbHdD8IKgKU6nA85kx8r1Km9dU+KWYfRB8NilMqaF+KD785jClQ6Yj?=
 =?us-ascii?Q?V9a9Olz2ukv3CO3BXkWb4j7vzWVkl3UFvostEiisfLjSgr09w8Ya/Jfua7ie?=
 =?us-ascii?Q?8bZrhSWDU2taoGNns3CMdE1LjeWSh1SM6aRGNqj84R230m51MhUBs+9cKFF1?=
 =?us-ascii?Q?jroAV/ZowR5GepEqOUlDKZI9RhpvHeJ9/Uwpsmb65J5SznFbG5ZbAogVAm7m?=
 =?us-ascii?Q?JIe7ft9+rznObynwyU6kzf7D0er7WG2kf+tpTYpngqPUDevw5/moA8+gunFV?=
 =?us-ascii?Q?s2U86h6JW6NXdMaKDpdewg+STHxOji99fF+TG9YKbj9A5BWyEGbbNHdDJKmf?=
 =?us-ascii?Q?tsCGjc96sTA4CfBKO0B2Z2NZsigT/ZJAVBXjuoHRYx4cdGCpwSkMFV7lmH0x?=
 =?us-ascii?Q?HysjWHOvda7outV2dHrCtPUg05kClwLmgY/zxPWACc+3e8Zdvur2Fm0io2tT?=
 =?us-ascii?Q?XfdvuDkUe981mLvXLon0NfqgefkivqjVhQpEna09IhCsle0ELSI89aFOw0Ht?=
 =?us-ascii?Q?tGmzh9++m+XBiYR/Dakzs2X1eS9uSbdrAZN0O5auVVmliOYVrutuAvMgMEOL?=
 =?us-ascii?Q?yoKAe/RsO1sp2j5IsdbVuNJCixSUJZjvtm9uWbSEQMFJIlXyJyz6tqkyRihH?=
 =?us-ascii?Q?vCcR/mTyrjoVXWJU2OXkQWKKVwRnrgM3UiqNRRKaA3t7WsuPx8dJogNXDY5I?=
 =?us-ascii?Q?qyrBmG/gmA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aae1409-f1f4-4ad0-518a-08df04e8350a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 09:39:07.8070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWm6g0UphO7+7UVXdok8LkCAPX4+absAQ/3goLU42jm7SI1u26Awlx5k8JmL1dEriKtnO2zYu1ilt1jANDYOGlynmaPRN4SjCiNMKsLQ5yM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10723

Hi Li Youhong,

Thanks for the patch.

> -----Original Message-----
> From: Li Youhong <dayou5941@163.com>
> Sent: 28 August 2026 08:11
> Subject: [PATCH] counter: rz-mtu3-cnt: check clk_prepare_enable() return =
value
>=20
> From: Li Youhong <liyouhong@kylinos.cn>
>=20
> The driver ignored clk_prepare_enable() failures during probe and runtime=
 resume.  Propagate the error so
> probe does not continue with the clock disabled and resume does not repor=
t success falsely.
>=20
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> ---
>  drivers/counter/rz-mtu3-cnt.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.=
c index
> 7bfb6979193c..6f746cf598c0 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -817,9 +817,7 @@ static int rz_mtu3_cnt_pm_runtime_resume(struct devic=
e *dev)  {
>  	struct clk *const clk =3D dev_get_drvdata(dev);
>=20
> -	clk_prepare_enable(clk);
> -
> -	return 0;
> +	return clk_prepare_enable(clk);

Maybe also add similar error check in disable() for
Completeness.

>  }
>=20
>  static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_cnt_pm_ops,
> @@ -861,7 +859,10 @@ static int rz_mtu3_cnt_probe(struct platform_device =
*pdev)
>=20
>  	mutex_init(&priv->lock);
>  	platform_set_drvdata(pdev, priv->clk);
> -	clk_prepare_enable(priv->clk);
> +	ret =3D clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return ret;
> +
>  	pm_runtime_set_active(&pdev->dev);

This API can return error and same issue will happen.

Cheers,
Biju

>  	pm_runtime_enable(&pdev->dev);
>  	ret =3D devm_add_action_or_reset(&pdev->dev, rz_mtu3_cnt_pm_disable, de=
v);
> --
> 2.25.1

