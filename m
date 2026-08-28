Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010049.outbound.protection.outlook.com [52.101.228.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D4374E67;
	Fri, 28 Aug 2026 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787910195; cv=fail; b=pU9gnH5uKUvr/ev5T/3+bnRMB/bC964SDAiyzYzJN/YfQgf3Q+vULp70XcvT/amKCy9/p2ip+YzuMZ76S5/dKEo5aT96zJuWl8EoG8nT3vnudxDAQJrvLBQ0/x5uT1Qrv+kvX3O4OhQrI9aqkQfLl5KQB+7F+TezlBBUWeGHo2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787910195; c=relaxed/simple;
	bh=vuwByGvhuT8Q34Ao6o+8OxxFgPYoXfabLneCONDyLCQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G3C56E1EOl70Rj9RvFGWCwt6Q3ze4qrSRQr4pSjpiXdvqVkjYj1IizxEiKT0WqnEYiAXw2Qrvw/RhI6t73PVcjXcP73mRgPMLj7Lz7Izq2fu0zpPdnexu7yPkZZ4BZQurKgHmm4nMXsvRq7MbND3pSxkyERIpjc8WSG5rJWbQXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Hdk9tvlX; arc=fail smtp.client-ip=52.101.228.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Hdk9tvlX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsaqbdI+VcMnXsBzgtVUMRRfgL0EMMeCQ4r1a9yDRoECs57KrzgxLIchxm+5QYEck/O1CiX/o1JSE5smVrS+JtsUfrXCVEcxlSiD6gIRsSzMd6tmGAqT7pp3JgmfPdur6na2iyBmaGh1G4ZwkL1vyQ1ZBSzdBMaybCqrt7QabUxHWgGvqwdzwsh1C+sbOJ7jvRyWHjvLSxWPmnP0C3YBkFKpxLWwDHcY9NbU509xUW6czsBZq+rNG0ecMN2rmEe0KoCcsSK26MbvZZTLNeO7qu2Tb5ZMQKNEnLqcYW55Hw846xd+yLvw7O1csEaJGalMphM890pXBgoPFL8/FX0udQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DH45T02ZbYg+NANXqfaBM1G0fVtzRwdcUlmQ/PgLjuI=;
 b=ymvAQaDU+t8b3hbXqYmcgHzyF7Hbp3n5hgd6vFkZ+wRMQs8t6N40/mnwzUzgTKR2rk8L9C85XAqY/tkD6V1DpQJAu7s9N+/U1Ez5zZCbqiPJKRy9bu9r6eZV5k0Ltx9dExuy0DUzXOXik4L7vjzVqMvZv+mP28dryToz+GYFL3QOqRzCsrxmnG5i5Qjuet1jryVPwLamOzXzw/SZvum4DpLHw3VU6RtP+qhVtWQHCcriNT8n/M4H0QhGcjxHXZkVjbMno3MsYekThO+QDBs8sNLIO+C1uRKVGVa1RZHH+H1ZAsA4sLCxqn03ll1WwGfMjFwGHc4e04YocLEoKE0vYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DH45T02ZbYg+NANXqfaBM1G0fVtzRwdcUlmQ/PgLjuI=;
 b=Hdk9tvlXViwOX33ma1tUBpBRtPlJ9m5B6rDw+JqhJcQ8kVTFjHLwajedhVyTcQ9VVsRwQeerOoFh6rmR+8yTzmjV6e2TX3vLR1+vegLZMgvFG2ZHpGNReW3QkMEz2XKvOEazqrwz2oQ9rb4RP6OV/0q1XvO0CL38SjuJPR3/1iY=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TY1PR01MB10723.jpnprd01.prod.outlook.com (2603:1096:400:31c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 09:43:10 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:43:10 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, Li Youhong <dayou5941@163.com>,
	"wbg@kernel.org" <wbg@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Li
 Youhong <liyouhong@kylinos.cn>
Subject: RE: [PATCH] counter: rz-mtu3-cnt: check clk_prepare_enable() return
 value
Thread-Topic: [PATCH] counter: rz-mtu3-cnt: check clk_prepare_enable() return
 value
Thread-Index: AQHdNrx3kQjs4CnEf0iwe1oHyY4MsLazMssQgAACyUA=
Date: Fri, 28 Aug 2026 09:43:10 +0000
Message-ID:
 <TYCPR01MB11332985B47AC5410D4D02F1286AC2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20260828071123.179670-1-dayou5941@163.com>
 <TYCPR01MB11332D67B5121D22F05E2CAEE86AC2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB11332D67B5121D22F05E2CAEE86AC2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TY1PR01MB10723:EE_
x-ms-office365-filtering-correlation-id: 0bae56f1-cff5-4d18-f462-08df04e8c5ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|10067099003|22082099003|18002099003|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 B8x4EYBBtMs9O6PaaNx46SvVLlkFer2lhUNs5qyt2xP5PFM2gvFUSkytC2ji/poDx4a5cQi9fmKetarOK5K/S79NKg7j1S4ZjVFMWegzmecZ4fwfoent/XiMu7xWCFyW+Wu8m+3adjD2ruomwpYhRDZFRO2hjJ/YvHv0EBwH8FWVIMaLC8aQCiYI2NTKZ4OEh/t5L4vVv2GPPLB77b4JaQY/Pl0Hy29wcoedrRSwl/NE5awJxFfcTUBAW0cN9pKGWZHIM5842FSibAyeB9k+J6eYnMymr23JS91zqGTB8PCNUeodCYf7lPlryBg29cPyrUEvMpRKTZw2j8Jjc5AOmSdyt+4k02lE4FvcMsFpSjlYlTv88QNENN6tAvhUDE0z4ZYseU40dXfW0d5vb1tZzExZnZbFXqqtBHs2FW1dNsACQOMEBXx7F8qZQlLEI/K1KpHghgYWS7hlg5fwqRIKA8KI7YTRXq8thhI6rkAtuCjEFXq+Fl36MDBXtQgFFlkP0dcWvAbzkwVUd4YwaLiILNtKShYiWjc746pmoCEH93G35eMBC0fhSQ2/lInd0U4x2/TeSJyY75tREqsnaNqyY0RJlh0WXktljAJi/P4/bjKx3JhFLDcF2jNBxfoS4S1WkTLEJTXSnzKzE85zcLTMusqmWv2DXgIOGXmYhW0NQ89vzwAi/z8oGSku+nqvR5saOsVo9lcIp3bxCZ8rPWpFimwTG3T0ZNJOwuDhjqh7aZ0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eK0gLz3KBhYtMxmM7ITmKL6JP3L2vImVZQPpOry6f6C30pZo/kDkTqnXfdFi?=
 =?us-ascii?Q?sgp0nR0pucpcAqKbU8E6VWlvR7Sq8m9poy+b1u0j7Pj9/OBinwABmQOT8bC0?=
 =?us-ascii?Q?kxRXP8OKLAC9v0GA/HzcUZnCZTNnAtVmNw16HWQfz7tULhpaaQOIAR9ATu70?=
 =?us-ascii?Q?3MeswF/AoFqvX6q/7mxQhIA27eaDi4Pp2bRy6C+4+42kQBzGyijEsFHUkwK2?=
 =?us-ascii?Q?XFk2/vEkXVGa91mzpo+HhXMnmQTny0Teh0YNJrlBfj3q7/ySatT4+imVbWsF?=
 =?us-ascii?Q?GQIs5FI8J14vR3v6f7yud1sG1qoXqUPcpbM0nyXRb2HAgMBytAMtOzxGCrwj?=
 =?us-ascii?Q?zmSZWaz4qi11MfVVvxqr84Y3mxzNHzwAZc7SBgR0Fb86kbbVLu+nYTqsfLrY?=
 =?us-ascii?Q?PGCZVu3aGHHeT+pC+Lke8t58oGpyAXiQ5rBI+7x82Ji/GIgJ7h2QchfAEkdy?=
 =?us-ascii?Q?uWJd9Qtz1Q90eXMaA4cjVmSpl+aQ15bZOrTyIbBEcwBGKnG7THJD2rb4PJ0W?=
 =?us-ascii?Q?2mEdSKdQB3tdEV/ytGFXQtH89msEjiJLHAZMv52C3W8is1XVjaVz463m2S92?=
 =?us-ascii?Q?t2V4XJVbLDkaY6Kwzh9EKcanMixj/yjmcU+1Rh5I5xbSYqsYqZzRMQeOJa8L?=
 =?us-ascii?Q?eQmJuRMCWP+YCCBgi5musJOwEiv97ueiKyFlTkJGjZ0ECiaK5F1mtQ2BXgbX?=
 =?us-ascii?Q?WaQG0Le3Rgp6Mplk5JQslnRtrmUOxdCY9nPpvUZH22aMcNAiAJdnyY3LnD25?=
 =?us-ascii?Q?i+TG0fQeNJtSJ7KUbKMIWIE9OjnEWj7jbQfnSwX/YY/KiD8nEuGAfjkqOOtC?=
 =?us-ascii?Q?yE1CLUUeRlTYJMldjpGQ2OBr8ynv74I5ksEf9hnaBWQ0QeK/StAOSsJ0ZiYT?=
 =?us-ascii?Q?aJi50sWglMfymPqDjLAMwQc179B+tkYV17h+XNsR3DnBjdxTlkVlAlfd5Kv0?=
 =?us-ascii?Q?oJE+lN+/b9pCXdAfD/qT3Jt0SRKgw02dsrKc7XqpZ/y+7mTpT0CDqB5bsse6?=
 =?us-ascii?Q?d7kw+uXGfD7MIz7x488Rb8RQSx06QJc5DqFal2SIbp6aUDwlGOMk0Mrf5rkp?=
 =?us-ascii?Q?beSbTJd0MpZSCRAZykg+xymQPQKn+irkml5KBViLUVYR2RTJxPcv+xSPk07N?=
 =?us-ascii?Q?JkN/wZhlYSPY8fp41Qdm4zVqQqk2mYwwiE9oSU92eyDH9fiUOgAl7rUO9CES?=
 =?us-ascii?Q?2vDKD0p8PBZ0CCIDhq5YcwdssM4UsUAJ1RiwQuq8lKKgMEa7odEpft0iw4+c?=
 =?us-ascii?Q?D6rHC2atLbQFMEXL53e4uBMbDFo/QTN4R3835plQtGeTzJjClgNTCRROh1Cy?=
 =?us-ascii?Q?kaRPG1zk6W0+00mPYz799XLB3OYGCfV0eq8kJ3XtTkPQkkVRPrssFKY5hZiO?=
 =?us-ascii?Q?fhZs5Fh7A+yc4/VR5PMdYRPQkM8zlWLaUOD3lpy4YTlc7fARqVmMGR6do/ln?=
 =?us-ascii?Q?SUxyaiG0frZPMIpf2xVQd/UF4NWyqTuiSb7u4g0iZC2j6b55AnxIN3bpOLzV?=
 =?us-ascii?Q?ZvW11PyQGnBty49HVTVQtXH1GeU8njhmZLhLybzgQDUq1EZE9Vu83PnMJNyg?=
 =?us-ascii?Q?AXWxor4o6TVTg9KWcu7ield+EraqCF1a4Gy/Je3SlJhXkZmndn1AEskuqPrE?=
 =?us-ascii?Q?phd0ksDTEx3wVydAOh2XPP/sAAraddADX2h1YMY/opxuX+NXsSivAD1aFvkA?=
 =?us-ascii?Q?pvvAnzP/ewDMDEmLz+qLxlu7o4Qb1RbDg6o6myLy6zMmWDZDQahj/oF+XtPm?=
 =?us-ascii?Q?Yi0xoJsfyw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bae56f1-cff5-4d18-f462-08df04e8c5ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 09:43:10.4916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63Ht3mzK/2c15Ta1xR7OM2F1R54WTewzNukRAVLoj7xe0xkjehNw91wsD2s6VchE2vL3urgrzlJBBBRznM+NPSH4yFMOshbS6dWO6DzM3rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10723



> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 28 August 2026 10:39
> To: Li Youhong <dayou5941@163.com>; wbg@kernel.org
> Cc: linux-iio@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Li Youh=
ong <liyouhong@kylinos.cn>
> Subject: RE: [PATCH] counter: rz-mtu3-cnt: check clk_prepare_enable() ret=
urn value
>=20
> Hi Li Youhong,
>=20
> Thanks for the patch.
>=20
> > -----Original Message-----
> > From: Li Youhong <dayou5941@163.com>
> > Sent: 28 August 2026 08:11
> > Subject: [PATCH] counter: rz-mtu3-cnt: check clk_prepare_enable()
> > return value
> >
> > From: Li Youhong <liyouhong@kylinos.cn>
> >
> > The driver ignored clk_prepare_enable() failures during probe and
> > runtime resume.  Propagate the error so probe does not continue with th=
e clock disabled and resume does
> not report success falsely.
> >
> > Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> > ---
> >  drivers/counter/rz-mtu3-cnt.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/counter/rz-mtu3-cnt.c
> > b/drivers/counter/rz-mtu3-cnt.c index
> > 7bfb6979193c..6f746cf598c0 100644
> > --- a/drivers/counter/rz-mtu3-cnt.c
> > +++ b/drivers/counter/rz-mtu3-cnt.c
> > @@ -817,9 +817,7 @@ static int rz_mtu3_cnt_pm_runtime_resume(struct dev=
ice *dev)  {
> >  	struct clk *const clk =3D dev_get_drvdata(dev);
> >
> > -	clk_prepare_enable(clk);
> > -
> > -	return 0;
> > +	return clk_prepare_enable(clk);
>=20
> Maybe also add similar error check in disable() for Completeness.

Oops ignore me, disable is void function

Cheers,
Biju
