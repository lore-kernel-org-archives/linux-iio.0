Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794924301;
	b=a0v+Snvp9Q+MWSbGdxY+Rqu6j+KpG9CqLdkuvvCPdIL2/JT5nxPS/MewPQMfEkRNSGgN
	 rYfhMO/lGzIA970MpnPERiY5MviNQCjwM4TJAJWDXSSEzugBgqilFWMIbtCqK386ms5ls
	 2cKqRfGQuO/WxPgBbHS4IGQjcdVTXG+UQQqdw7+6QTTkp1cCqnWT/iz9+HeMlVDf7Y7ky
	 Z0GvACywCXI9zgJGKJ5k1KW8MdZpaQFyheHG/1s0yzHCbwMopoDeQhA5N0jdqhDIO+PFS
	 2b3EM3R/Rley9H7pEKOt9FMkbXEbOxMJD1S8o+IJnRHr1DAa2PnaTDumCEPR4ld1TAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924301;
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
	bh=YjfxJ+4Gmeadi9bfFLiwu8F1GbM37d85p9khpfq6Pbw=;
	b=yoYpP8nIykHnpe7pCUzIFWeFvRE4faU5qDhlO/IYieYKe1UCEwjN50RCxKtCaRFvMARF
	 OCiWOtV1UFGAlzr4PgbkkqnVjUySpNIOBgcgGYUSiB/jCi/pHFAc/HJhTNRxQuyE4GAb3
	 75ZMD9ONgGnjGkXTs+jCI1dUXKWQGo2BI2wQ89TV7O25KRSgBqCL973k1M4BX3r+Z9rmD
	 1lffAtL6lw4WpoTIeLqDtlnoA6V3SnpLFZG+9+HXQ8YaR0QQB6ogAJpNqIYrt5Qi4kRn/
	 P3eAnuo8bour0YWAhbchHSj1Fyh5yrd8078j9nzy2w390lbrGrafJgdl8Eb3G5hDYig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=CVQMlUNN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.17
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011017.outbound.protection.outlook.com [52.101.125.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8761606A331;
	Tue, 17 Nov 2026 14:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8761606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=CVQMlUNN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aubGF0BgudOLyQJ4N34fGlwoI741Y261URixAYo5gRWmK4TKXHRTgfXyVj0Zv1ZKxYTYeru5Wtv/zLOkV/q0AYdW/xLkswI9tLvbGl/noH/CYiYUQidscffK0Ogc4Tjd/vBBxTJ6wemsU5t9QdpoGOgV+oEBs6/QPNPfKgqPZGV1irnyReFIidV/YkTI9p/c4q1jC6EN0lPjrxNqUGKWG4OmDskwAMI2mdhIovkJo+e0Oc/FTQRFSzz7cfp+F0NuOwKVf8lhvuYkaKqeXHXcPEaszMaBNDsWq5oIGouFA3igZo+zCUDX7tsp2LeBlLOCFLTrKs1RI6iHwkKZnqbC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjfxJ+4Gmeadi9bfFLiwu8F1GbM37d85p9khpfq6Pbw=;
 b=smwrtdSGteG9qsGOEMRGFHgh5Z15cL/TIfypMkPmvAHKMFT3sO5I5mY+a3LzSZg+l9vtmKVAw9n/fKtS6vd+vPxkcV9Ib7HhIIpboINf9UtzS1+7h0jrXoCsn4uSQOuZFGmOug1WEt3lMYE05etUveetac5H65G/YVDCDwPgh05Q/G0SJXACE14GGjQxXV8GqWWBLslWQbgPIt1+Zo8I2C4aE1Nr6hp9K/bV1gPOf59cu7i8yjSQpGMU8lytLxMNk0A6kms3wXIHk4MIa4EGUEY66HfytTSt0Fu8wE8qpSlLFDvYFjTPUGaTlIUrBUI00KzgIZx4xClEv0Q8S4jNtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjfxJ+4Gmeadi9bfFLiwu8F1GbM37d85p9khpfq6Pbw=;
 b=CVQMlUNN+S6ky8rKKJZA0NMQ9X0SXEKXLj6v7wYF/QOMWAPGc9u3fgvK0Iy3EWcyomWXcQFYqcITy7oKs9Cn8n7yq69ReqYELwogVnykWZtoj1rF1M95Tfgw+jY0i8mWK8KSqVcJcapwUujkTpcAVl94ljW1TfoUvDiVJGUnX4w=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TYYPR01MB6553.jpnprd01.prod.outlook.com (2603:1096:400:ca::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:04:59 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:04:58 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, William
 Breathitt Gray <wbg@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cosmin-Gabriel
 Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: RE: [PATCH v3 02/14] counter: rz-mtu3-cnt: remove manual runtime PM
 handling
Thread-Topic: [PATCH v3 02/14] counter: rz-mtu3-cnt: remove manual runtime PM
 handling
Thread-Index: AQHddn46PXocpzCnQkmU5cQOE9kdtbcyTDHg
Date: Tue, 17 Nov 2026 14:04:58 +0000
Message-ID:
 <TYYPR01MB660313E0E9F9527B795266B6867B2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261117102607.2504551-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20261117102607.2504551-3-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20261117102607.2504551-3-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TYYPR01MB6553:EE_
x-ms-office365-filtering-correlation-id: 79190b73-cdb6-4f53-7ce7-08df44b3c40c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|261009221727099003|261009223327099003|261009223027099003|261009221227099003|261009220027099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261021123027099003|261028144727099003|261026140227099003|261026121527099003|261021135927099003|261022075727099003|261022113327099003|38070700021|261021121427099003|261022105027099003;
x-microsoft-antispam-message-info:
 WmoUYLO6f/oRKFmKNibAp5aXTV30YN1za+f1WVZLiowR/LMNeL4p0tqcqipQNM/fLBZ96OMOrF1ixlvtAcZireEBHMuk91YHG5f/rRV4b4Oxsg8fGL6J3fx2AeoQ2TG93tzf2maxGW44j22ZBigtFpWH7wwo82ZT/fjijUkhxquuwTrRDOGCilEyK5xvCt64+6otnsTh+5m1ncQuBtjnSvnoZzKjT00OHNBpDSTPcI5OrWXvprp4l0ekl/7hxsxQUWUtrVKphro1aKSQF6NLxNtsaSGinUaAiUgqyjcFetMIqD53Mhcb3XrLS5xHDUD9ZGkaOvA6RJgDvl2vnTFgcRLIIewHDcfYihrtlxiLQcIsvY8v7nNPl/b70RD+1vmK8VTwRajKMhYO/a8Veh0QtlLmM/49CW5GxygRPLA2OMtA0Vhz3+tRccIc1BDtwCVtaiAEhjyLjTcEMZy2yzBs67BjQB3SHA+KJDIfKebAgnZf6M21UQN7oHl81nVJJnWKhRHmzv9Et08VDJqTc8VH23S3NrlgTZrlKI0wBxF/w3FrU3dp34XhYzTrkXmLV3Rrh8/iJd1EJ1nfOCcurel23pY1ZpM8Lf8VI05e649xXRlhZqikn9jlk6iWZ8wqJFSW7AatUyc5clV3H6ipag9Y6aKDP2AQbzEIAZkPZHP0xfDQ3YZv4Mbr1Dctx3jqmceHRLXSGmqbnMjmqa8Z9aIPvdrMevgo/NANUJGxm2wpHHE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6603.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(261009221727099003)(261009223327099003)(261009223027099003)(261009221227099003)(261009220027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261021123027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021135927099003)(261022075727099003)(261022113327099003)(38070700021)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Fsb5n4XlQ3d1vMONRfVauEibBzquQOcmT//VMEgQSIjs0w0p6HnDdS/qY+VS?=
 =?us-ascii?Q?IxNNwfIRaDsHRuX/QiUXG9Z7xO7w3CKq9wqaz3XTGAAHSc/VvTAZTjoraali?=
 =?us-ascii?Q?TcJt/KvvPt/PF6ln7rgjwvmVmNakgbgYEXPlfAkPs6MzioSsW+pd1pQ+MEhN?=
 =?us-ascii?Q?apc9WoxswPSJkAFQAEaxzeOfaHZOWRBrnVlBi9Uzmfi0jncO33i2C/r3GgmB?=
 =?us-ascii?Q?7YCoIM6Hp0SwXz5I476Zv0CHCXbbyDvuAyV19Mhm9pyQCjCVQNuvvia6u1U5?=
 =?us-ascii?Q?ngwYYfHoMnrYFero6jo6yCcNMlXbF4djweX0X1DwzV1BVq7FcJmD7vRSAaph?=
 =?us-ascii?Q?hu2E2xKwnJ3pVDCP5jcvtCRFYEBE8owolsITlYea4/1PQdfuKkmIocjUpUJt?=
 =?us-ascii?Q?pMQ42Gztcvy8MSbGyUUDnT3IGJSQskc47tiLlhJBRkLHWe0Axo2NxlLTdwcw?=
 =?us-ascii?Q?QQgaMpOSqTPSXfKxWeURshGJiC21QwR2bUThFVRj/Fs2nMVXX3znTGGuYH62?=
 =?us-ascii?Q?lq+Sps44kD61KDEEp8rrXfP9K3JGxtdk9NBxijYIH6b8qU9X/FOfLf+jy/4c?=
 =?us-ascii?Q?qBGJw4btIK+7G3BGndpDckWxqRZBbXrDq0X8aQ4ASv6ZaIZHfMO4yrGml8w3?=
 =?us-ascii?Q?j+q+VIpdO4cjV84LyeaQ8c6OU7NWNUD8ZfEqOKYYw5p8Ik7HwN08vl8uqFEx?=
 =?us-ascii?Q?vw8SCpZhE0NwxRj2azVhriM0P22XOneIYoA85jlCUYIRfTCGSfXjjiDVdyZy?=
 =?us-ascii?Q?coJaT0r5wnzAEVamv5YCFiGG3Ozc8nDavHAIV9JJD7F5LUWUeKum9UKAL7VC?=
 =?us-ascii?Q?d/dja2d5Yy7Y3/W9U1nig0ovBRJLLVNJS7Um0c1FEAN+Rjjmf0B/M08xJFFT?=
 =?us-ascii?Q?76mJpTjT15RmteekWCnkfZDghqPFxcNULBC+ReoAWl8CRwpxmpB4cXk/Mgai?=
 =?us-ascii?Q?ao+yrCKQKmrv6ZyFI2gTIf5TwTBHUSZlOby6aBFlt8Hkq2RQbP2qzhTEXQfq?=
 =?us-ascii?Q?r/I/34LSJS4rkFVNxT5K8zV09JVKtemDNaBR+UmOGkf6bRmKgF5h2kA41J6Z?=
 =?us-ascii?Q?4An3NCIR8Oc2r1LIeVD//D/dxrVWxjq3FTiQzcZnh/M0qukTRmmpTTZHBQki?=
 =?us-ascii?Q?SXlN/jvS6tN+l1SDUr95G6110R6BDvEobWATiLddV589Jl8U6LfZBA3hItL+?=
 =?us-ascii?Q?iikRPdx3YdOQUbeLIW1QsD788eOB2Ow5oArvRvB6eykafbi/5fiubbRZIim8?=
 =?us-ascii?Q?JUAWzrv6M2w/x/I0rLX8nrpe4+ZPLuGsUStEWXRqTvw1fTl0hP7mtu7+JNce?=
 =?us-ascii?Q?4OrYXCjTqTua7q//GsTPAziiag9Ya542YUj44MhjOy2mzEQCb3da9rbM9nm6?=
 =?us-ascii?Q?v0iTw8DNzf/J6fI6NGR/B8hkqlt5H5BS2kiCsmQxD3i26ityoKNaArTs6zT+?=
 =?us-ascii?Q?4lY/pc4u19RT9huBSpMpV1RDWl/X5eoeXGdZ0knsL2Ea3jWNjRxkwLMTNIHc?=
 =?us-ascii?Q?jakoG34z3ZjeBmeQvkky0i7g+CZfMlg5EzyiLNYYjgEkDNBmhzniXZeLe8es?=
 =?us-ascii?Q?1axaHMJgHoKDIf06wZuvKhMrc95s0HftI6MJkhJE2ZbWWBlVc5QQRIG4ciUC?=
 =?us-ascii?Q?Gtypa3WndJbWzaUhE+tdkn4hYZA3cJsY2XaKLVmygJpTef+FhOxNEHEmuLCq?=
 =?us-ascii?Q?fW1LjCOvtobruietNBqq/lBKxp3rZx2PUQIgkwlzzLHpTvIHzYDEFcD0rZ2d?=
 =?us-ascii?Q?a45GbvYTOw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 79190b73-cdb6-4f53-7ce7-08df44b3c40c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 14:04:58.8552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XQEjB6PrAG0DBTEr6nfD/FXRiMdmf3KuVGtQMM4eApawPvbbou5YZgxdYPFZdbudrC9/WFTGWvmOyDz0gFpt32WYG28TUPK3eGci+eCnkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6553



> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: 17 November 2026 10:26
> Subject: [PATCH v3 02/14] counter: rz-mtu3-cnt: remove manual runtime PM =
handling
>=20
> The clock is already managed by the CPG power domain attached to the pare=
nt device for all supported
> SoCs.
>=20
> When runtime PM is enabled on the parent device, __device_attach() tempor=
arily resumes the parent for
> the duration of the child's probe and drops the runtime PM reference afte=
rwards. Runtime PM usage by
> the child device also keeps the parent device active.
>=20
> As a result, explicit runtime PM handling in the counter driver is not ne=
cessary. Remove it.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

> ---
>=20
> V3:
>  * no changes
>=20
> V2:
>  * remove struct rz_mtu3_cnt::clk documentation
>  * remove clk.h include
>=20
>  drivers/counter/rz-mtu3-cnt.c | 44 +++--------------------------------
>  1 file changed, 3 insertions(+), 41 deletions(-)
>=20
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.=
c index
> bafb8ef82afb..d8f13c5ac525 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2022 Renesas Electronics Corporation
>   */
>=20
> -#include <linux/clk.h>
>  #include <linux/counter.h>
>  #include <linux/mfd/rz-mtu3.h>
>  #include <linux/module.h>
> @@ -65,7 +64,6 @@
>  /**
>   * struct rz_mtu3_cnt - MTU3 counter private data
>   *
> - * @clk: MTU3 module clock
>   * @lock: Lock to prevent concurrent access for ceiling and count
>   * @ch: HW channels for the counters
>   * @count_is_enabled: Enabled state of Counter value channel @@ -73,7 +7=
1,6 @@
>   * @mtu_32bit_max: Cache for 32-bit counters
>   */
>  struct rz_mtu3_cnt {
> -	struct clk *clk;
>  	struct mutex lock;
>  	struct rz_mtu3_channel *ch;
>  	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
> @@ -807,34 +804,11 @@ static struct counter_comp rz_mtu3_device_ext[] =3D=
 {
>  				 rz_mtu3_ext_input_phase_clock_select_enum),
>  };
>=20
> -static int rz_mtu3_cnt_pm_runtime_suspend(struct device *dev) -{
> -	struct clk *const clk =3D dev_get_drvdata(dev);
> -
> -	clk_disable_unprepare(clk);
> -
> -	return 0;
> -}
> -
> -static int rz_mtu3_cnt_pm_runtime_resume(struct device *dev) -{
> -	struct clk *const clk =3D dev_get_drvdata(dev);
> -
> -	clk_prepare_enable(clk);
> -
> -	return 0;
> -}
> -
> -static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_cnt_pm_ops,
> -				 rz_mtu3_cnt_pm_runtime_suspend,
> -				 rz_mtu3_cnt_pm_runtime_resume, NULL);
> -
>  static void rz_mtu3_cnt_pm_disable(void *data)  {
>  	struct device *dev =3D data;
>=20
>  	pm_runtime_disable(dev);
> -	pm_runtime_set_suspended(dev);
>  }
>=20
>  static int rz_mtu3_cnt_probe(struct platform_device *pdev) @@ -851,20 +8=
25,16 @@ static int
> rz_mtu3_cnt_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>=20
>  	priv =3D counter_priv(counter);
> -	priv->clk =3D ddata->clk;
>  	priv->mtu_32bit_max =3D U32_MAX;
>  	priv->ch =3D &ddata->channels[RZ_MTU3_CHAN_1];
>  	for (i =3D 0; i < RZ_MTU3_MAX_HW_CNTR_CHANNELS; i++)
>  		priv->mtu_16bit_max[i] =3D U16_MAX;
>=20
>  	mutex_init(&priv->lock);
> -	platform_set_drvdata(pdev, priv->clk);
> -	clk_prepare_enable(priv->clk);
> -	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>  	ret =3D devm_add_action_or_reset(&pdev->dev, rz_mtu3_cnt_pm_disable, de=
v);
>  	if (ret < 0)
> -		goto disable_clock;
> +		return ret;
>=20
>  	counter->name =3D dev_name(dev);
>  	counter->parent =3D dev;
> @@ -878,24 +848,16 @@ static int rz_mtu3_cnt_probe(struct platform_device=
 *pdev)
>=20
>  	/* Register Counter device */
>  	ret =3D devm_counter_add(dev, counter);
> -	if (ret < 0) {
> -		dev_err_probe(dev, ret, "Failed to add counter\n");
> -		goto disable_clock;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to add counter\n");
>=20
>  	return 0;
> -
> -disable_clock:
> -	clk_disable_unprepare(priv->clk);
> -
> -	return ret;
>  }
>=20
>  static struct platform_driver rz_mtu3_cnt_driver =3D {
>  	.probe =3D rz_mtu3_cnt_probe,
>  	.driver =3D {
>  		.name =3D "rz-mtu3-counter",
> -		.pm =3D pm_ptr(&rz_mtu3_cnt_pm_ops),
>  	},
>  };
>  module_platform_driver(rz_mtu3_cnt_driver);
> --
> 2.56.0
