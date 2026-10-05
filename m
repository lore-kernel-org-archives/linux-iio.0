Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010006.outbound.protection.outlook.com [52.101.229.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B9D40961C;
	Mon,  5 Oct 2026 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189918; cv=fail; b=es1drXxeVdicUY1JnWHZaMalKqtNo9UA5ushQtVACVi8AR5G+H8+qIbOtXPOPBHR6ft9LoV9ebp/VsYt4USjOH5AIdp7l0zrv5GliXkyhQ6f1ZH4/oAWe6WRJK95AjXvoxzxxA6kEiSXVmIR2wNteE++uXwZq4yHdEbkllpzH8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189918; c=relaxed/simple;
	bh=yHrGHTgEgpFi168T2xdTYawgXsHZgjfsWZGixDrGA9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tp6UNIJnJ9wWNF0qeF3U9TSfYQawAHSbnxAqXg89Xl56+y91/X5ztrgKngxFRSig/vaLr/6EzGqgDQGLFKU4ot96L7zZkBHmNpWIYTHPfvFdnkn4HK90pK2c+/Oh5/tpTxTwlUoFhy/T8fIhDGhcMUGiH3jKtLFPUurR14RBVsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=CptfAii2; arc=fail smtp.client-ip=52.101.229.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="CptfAii2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4rZvm5MhQuP4BNxj66nXdeyq/qfgYtJbFZY2XG6TbshMHu0jXqMtPR+8ajpTRAMgkZ771eTWXtqTjy31QmxBPka2SRr+nv+T9fumcW4IuNUx39prSNDtIToEsvFOOOg83UveVnwt5VFNZsYpjs2fOGWmQ8TwSgkoZTvoglenlL5CYJOYZZgXr2jYpecwS3ZUErv/AWr8J6huBsfwM0yOFQAYJOskkYPEC9Gv2U06prAsUL+xTPZjuC3FkPzkBd59X8OJdtcnWwvvsBo1yfqT6/sdn+UhEuJ3+yI62ElQnE9d5QtPpjx2IpUcidAOV0QHYZ1Mjr5sFDcL2b8DJPKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4cFHJywyYRFae3yjiyK6gbL72Xxr/EMumf65Nq3Xzs=;
 b=E53CDJ2TVlGotK8tKLPP2ZILSiH/RFW34GMgRqmjt+MJ02Q+X8orTDSw6kyyYi77F/NHu48/LBgQkHDRTjBQcqlQrvqmyShXEDime4P7CJAUnaFgQlU57cF2h9CJal1UgxAmJF1P2wTghNdjEcm9kYWTYSUpdyR16QnQeOQ9Bhsr/GEvpgOc/C+50ue6ed7WSIOvE4A95rrYgRuy5lka4GVP8LtP0SWiAvYDGhe7dNkyCJYQEewiAdzlB0rX6yBB9EP44JW6z+ZSbAWIAKO25CrheY+OpslcW4VSNKq4iFpweoN8EZf+vv6j1sWV8VVQKdHDA9pjSclb+4hs6abBZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4cFHJywyYRFae3yjiyK6gbL72Xxr/EMumf65Nq3Xzs=;
 b=CptfAii2bIJCEXODVbUI2w7MHEooNDPZtizf4T8Qw7BxVfZrQ4v7oazvfOEM1AH7OUB0itTimnctWqlj/ZAOVPSMA8NCbKGLKBvjuSjOMVU3uI/rd2uIA+lx65iJwyFg2TIEeEMgjCeiji8Ynrby3Jlmmpz7MlcaZNKJPNnqjlA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB12431.jpnprd01.prod.outlook.com (2603:1096:405:103::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 08:45:11 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.026; Mon, 5 Oct 2026
 08:45:11 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, William
 Breathitt Gray <wbg@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cosmin-Gabriel
 Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: RE: [PATCH v2 00/15] MTU3 counter fixes and improvements
Thread-Topic: [PATCH v2 00/15] MTU3 counter fixes and improvements
Thread-Index: AQHdVCieg51++XX0QUuJ0VVqajBbRLbuodBQ
Date: Mon, 5 Oct 2026 08:45:11 +0000
Message-ID:
 <TY3PR01MB113462D03DD936D3A21D13A2486962@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261004174752.507499-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20261004174752.507499-1-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB12431:EE_
x-ms-office365-filtering-correlation-id: 213ac51c-299e-41f3-e04e-08df22bcf799
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|38070700021|6133799003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 Lo3KTJ+Rgci+RJD2g8oIa3tS2pqELxvy0YNvyblxX8cI+wJ05Mnr1iBBBUrXIZ2Q/D5X7ygKWGP94I0R3z1sgvYAQZ6n6qGaSacHaeHqYC1fGg08HvSRoVq+ZpNOW0v6F7bjITTW2SQqICmvGeg4ZBkDBj4Cs6kz44nHa6pGSznPJkODk0VnzRrpexTEXFMj0haHFkpJw/d59GzztfBdbCwXxLRG5oveMKBSBx6jr44uH2I0dOFixCM7mXoAs5pQftrKOyVd5znm4JcPDOdTEyMdQH5L3JVFqeCYgreqVct4gTnVlyByS+rdsW/pFovUfWlhiys25JO5OQu/ktBTunzc+prFUsFzD2/1kRpePblarie1MIJ7EDQ64u/Njpg9PDS4m14ddO8oIHWWeJO6Z2V3Q4aPox0wIlPcoNyhgahG2uMjos4fVyfgp8F1TUd3zEzPkvgn+q8JV04iSeg2D+F+Apd/crPvfIrPHyfLior4nAY1Rkc6q5WKDp9o0niMytlfQt0ZhNiEQQDF5apRkbhU+GSF9E1bKATVRCyTmc3aXzfvD5IV7Pzv76DcZyGNEvC9/iASMwc4yjLYsDaSL4U6Ipv8f8r7NhaGrXwCH0tTMnYL8tm0aJqf2yUFGo1hGJ1GzZebYcEo9oHTQZRkrE5e5wgBLIxlbeEbNeyJunBLZ6BFDXEhhKTbWjBSVjGfoemcx776drvpfOjpXnt5tYelIB7ehPAhWN2CGcDnqa8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QUEVv80Y5WsZhjJ4DkWVIUMW+8lBKeDeUbS3+31IVX+0qrAhEIssIB4hL19E?=
 =?us-ascii?Q?9+GJ8XRcc4rQiQDoJ4fi/IflYnnhpMuHhh5XGYu8fm/Sq3+FMNb69f8JGCo7?=
 =?us-ascii?Q?XUOSC3at9KDiYuMmTM4XNNAycs0tYn+YL+roiRnOV2mJOnF9sAz3K3ph8o9Z?=
 =?us-ascii?Q?vYbeebh5k2dpBQyLVqhPB/iMPE78YUMkq6LmVTUJ89PdUFR2ry9hL01jBHnb?=
 =?us-ascii?Q?sMwa+ZBymafzxgbOz72CKGaG3sgtN5MLTgpxGz7/pacYaBm6U5bE8TVpc2Du?=
 =?us-ascii?Q?ClrSFD6Tmlb6XWvvQt+wBmJCW7sZ+0LPM4aTpYd9qR0V3KA45Dw4D4SX5V+0?=
 =?us-ascii?Q?HccKpI5G80hjQUQwCaCRqDL3m6gM79aKFMA8KAEcNgxsmd7O2VJdGRIULM+4?=
 =?us-ascii?Q?T9DaOg23NiBxvy1NdF0cIVxSO3g2IuEx/W+CA0Xx+ZLTQgmftpYicfQt2vbF?=
 =?us-ascii?Q?kOHCR4ItPccub3RAv1oFu96OACcxayUT82bykPfsLINJ9SUbmCkroEenvheM?=
 =?us-ascii?Q?pClOGOWyRjuucpNJz9Gi2Nx+Fxtx41jFbhtuG8IeIBz2Nrwz10yVip1CeUAE?=
 =?us-ascii?Q?bW/7uQZDZJWy/q0GHcDtCUVBZcdvJ/fhOdxXm1M+QCyCMY+LDnFts1wkDDx7?=
 =?us-ascii?Q?tkaJ/yRZuuQ2e7qZTi8yWUAOi+qvxTBm5qTHUzgW6imCPyReiN6Gh9s9Y2yY?=
 =?us-ascii?Q?A1KgpqLcrREeFO2F0Jicnc5U3RWPM4HK/TD2Zk/a0vly4n1s+rUcKAjC8R+A?=
 =?us-ascii?Q?sqkATTHy6sn4YcwRsiKkFgaHdz89TY0cZGlRwO00Zw7yttO6JTA+MWVphgWf?=
 =?us-ascii?Q?0x+Q+fbp8al9IwhSqophcPT/NagFObiAFRUQPQmvTO2Eeikm2WazYZziFv7J?=
 =?us-ascii?Q?Ba/yhhzWGIwvRTCBqYvSC+DJLg99sX2i2Dy4+oBBd6sf1wtz2fjHgNE2F0VC?=
 =?us-ascii?Q?r3sMH+O93fnJuVAR8urfOivJkFNVGuWR/Zw2UWI1J7e2VOXtVZYsg1SL3l9R?=
 =?us-ascii?Q?hUrdIqTKSJV0V+xTFbOPB3CVyi8HxK9h4pEbonYUvEzEfOKmNNMj3sG3ogOP?=
 =?us-ascii?Q?9GQVZtnFANA9L+MVIVsPeadHvVlaOZZeUmQsYruK/j2XwHd8OQnhFy8Etj8H?=
 =?us-ascii?Q?AFlCLY42laO/97/zR7aOaW0R3YFfMJWIDKRA9owQWhYwsNNa/Ypfjm5sgDb6?=
 =?us-ascii?Q?mSB4cCQZz7ZHldDERbXTHM5l7opoDS5pRlmaXnzWIRUUeEvvErvy7Kpbo5aS?=
 =?us-ascii?Q?gbo05dc7X3HAtRNdUAaqBepxangIj78A5c69MB1RdSvgWnmt2BB4sAF71lEv?=
 =?us-ascii?Q?m0jFWWMAWA0DFrEzh3ZgCMWhNzcEqb7vd36pR1Hpz4JcVYK5aAcZRlTL/pGt?=
 =?us-ascii?Q?YQDLsZgDhQB2BUDI30Oeuyf+fHicOpGOPPYweDIsRQznERJ23mjYzGH3+ZDh?=
 =?us-ascii?Q?TwCg+1HWV/uwb+kujAPeWJf4/vUk97JdeDTG2HzognW+Ov9oVaXFbElDxiwC?=
 =?us-ascii?Q?CEnLnv0eyd8awI7Mbcz/T9ncfganCP20SOnBQ/8Yz0No8BQEDgSJTQmoci4M?=
 =?us-ascii?Q?pJ8slgXeLOtEzqQiRxndgazpdbZNBA5NIhzQnKz02fLMXupT+wTp4+PGWFCE?=
 =?us-ascii?Q?U8N3WqVGa9MPHWCb3cqtYZuEVcvEbjc4OQ6vsBb/u2BFnK1Txss7WUAgZIqJ?=
 =?us-ascii?Q?LLMFGJVfqXyqgFP2Z1vNr5rLSItNlTX6b/7QBgSWLs6xkZAIQQQfHgmdIpc/?=
 =?us-ascii?Q?VOI/EpFAww=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 213ac51c-299e-41f3-e04e-08df22bcf799
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 08:45:11.2560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVoxt+VA8Gyso1rxUh2iJ4067pL0qiUb8YUMNaz/+6Fq+kKZd7obOf9Yvs1qo9SDeh3LNMrMBQiPsiLWnKSUk0OPUGdpBFmxpV0/6F9W0d0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12431

Hi Cosmin,

Thanks for the series.

> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: 04 October 2026 18:48
> Subject: [PATCH v2 00/15] MTU3 counter fixes and improvements
>=20
> This series does some code quality improvements to the MTU3 counter subdr=
iver, while also fixing bugs and
> adding caching support so that registers are not touched when the counter=
 is disabled, as there is no
> request API.

I believe you need to rebase this series on top of[1].

Since this patch series is caching userspace values in memory,=20
It can support suspend to RAM as well as in suspend to RAM,we lose
the register contents, this patch series can address that limitation.
Can you also please prepare a follow up patches for STR support?

[1] https://lore.kernel.org/all/20260903090719.3498955-1-dayou5941@163.com/

Cheers,
Biju

>=20
> Patch 3 relies on the following series to enable runtime PM on the parent=
 device so that the PM domain
> handles it automatically.
>=20
> https://lore.kernel.org/lkml/20261004174024.502949-1-cosmin-gabriel.tanis=
lav.xa@renesas.com
>=20
> V2:
>  * remove clk.h include
>  * remove struct rz_mtu3_cnt::clk documentation
>  * fix struct rz_mtu3_cnt::ceiling documentation
>  * add struct rz_mtu3_cnt::count documentation
>  * add struct rz_mtu3_cnt::timer_mode documentation
>  * add struct rz_mtu3_cnt::mtclkc_mtclkd documentation
>  * add struct rz_mtu3_cnt::direction documentation
>  * add struct rz_mtu3_cnt::cascade_counts_enable documentation
>  * remove now-unused RZ_MTU3_MAX_HW_CNTR_CHANNELS macro
>  * move rz_mtu3_set_lwa() call after rz_mtu3_disable()
>  * mention the removed busy check
>  * mask 16-bit counter value to preserve behavior
>=20
> Cosmin Tanislav (15):
>   counter: rz-mtu3-cnt: put runtime PM on initialization error path
>   counter: rz-mtu3-cnt: do not assign struct rz_mtu3_channel::dev
>   counter: rz-mtu3-cnt: remove manual runtime PM handling
>   counter: rz-mtu3-cnt: use device-managed pm_runtime_enable()
>   counter: rz-mtu3-cnt: read enable value from cache
>   counter: rz-mtu3-cnt: disable channel before releasing
>   counter: rz-mtu3-cnt: unify ceiling values
>   counter: rz-mtu3-cnt: cache ceiling values
>   counter: rz-mtu3-cnt: cache count values
>   counter: rz-mtu3-cnt: cache function values
>   counter: rz-mtu3-cnt: cache external input phase clock value
>   counter: rz-mtu3-cnt: cache direction values
>   counter: rz-mtu3-cnt: keep cascade_counts_enable in sync with usage
>   counter: rz-mtu3-cnt: drop conditional locks
>   counter: rz-mtu3-cnt: use pm_runtime_resume_and_get()
>=20
>  drivers/counter/rz-mtu3-cnt.c | 458 +++++++++++-----------------------
>  1 file changed, 149 insertions(+), 309 deletions(-)
>=20
> --
> 2.55.0

