Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010051.outbound.protection.outlook.com [52.101.229.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D454641BA61;
	Mon,  5 Oct 2026 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791200838; cv=fail; b=HhaHdZsVioTofL90DQL+lzqbCXSGtVlfF3W34crkyp+k/8klfVVCQZ03i0x2rLunZ+qp+Klf3P5BYc1hijXXxMClxWehQmppF+ig//kVcLSfv5aSPPJAgQRHzFbeIZ6xLi9BXr9rQ19cMLOiqTyWGHVj0F3yqcoSSTq0mFomWJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791200838; c=relaxed/simple;
	bh=JiQ5T7NKKSQqazszfFpus/CV7VBQ8djYjxgMX9aktQM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pFKm8XLTCIHjYaiHiH/Wbi7cZdcF62ku62rozcMOyzqjKV7ltT4xsMLVV8EMv+XaQkHNDo93t/QM1BEzreutYdlcMfIMUKYb9Tup4z3l/6iT27SnAG9RNOCXLY3EvhzbyXvKpeciN/Fbatwndn9PvtACvXUKCSDOjidtx+afGBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=dJBYvUTH; arc=fail smtp.client-ip=52.101.229.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="dJBYvUTH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aM1YPg2qhx4ezNag0oIdcoFglsVXvdBDnFzKSjlOifpLdzDsCLTRa+otvQwKjUR7d+ARXQEWKsFin2zBuUOwV7WrsB9SFmDY2rD/gcKVwQrDy3JQdrLPZZvYYtx2wHk++wM4Rno/eOrEXc2+Iwg2ER4Q90n/wSgAERnySgXeHS9+KQSIs+RJAaWBLGEHWEzmdmAKIuwzbL4lw6p0awa1qJ1Yra7YoLGxC++OEBHr7Y5/NoSRlEXInCCQyDDqY3nof/1WToyA8LVahfE7YftLavMisdNUx08IV7YXEVMUBh3eSG3+RFoAc59vEdqPxzURcbK9GDpc1mW92sob1sq9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiQ5T7NKKSQqazszfFpus/CV7VBQ8djYjxgMX9aktQM=;
 b=lwmWkTBSe+jPi6uSrZVyBPCY/MbNK3+J/SNUQqsSDgsUpOw9Bxyp8fJkgTGTdM297Fe6TjwB5bwSykvP++eRB7QN6j0nYl43/4vswu38vXda1skBfCMUydQAQK6UTq0CIEROok26xzOE1W2NyiQmtcou4C/adDOMeubvuUvGCn1tAl+YlKjtrsDqstMkqKH/GbCktwYOFRDNYuypdvUoek668FaNAcnSSV/m1TxagBDaAGB031GuWFWdVyK6sNmsTsRnkrGA5YdiHmaP37XqRlpk6LPYMBuGwU/TKHHV0yT2EUXBcmB9FUlq8DX7gOQyPn4U7pQitDL18pK2oZqvbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiQ5T7NKKSQqazszfFpus/CV7VBQ8djYjxgMX9aktQM=;
 b=dJBYvUTHqLRd2WwtGJ7GuF6/OgnnQ2Nx74TEfRAdAZo4zWO7abiC5XpL11xqeP9DVTxAVfyFjkbwxU0lMjmhm3mBLCYqU/PX87P2MEk58g+roulTop5iA8HCCy8IruaVTpeAQnsNvmjx2MbLQKpzB267X3OvlTNWqIoT+64nqjc=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by TYRPR01MB16231.jpnprd01.prod.outlook.com
 (2603:1096:405:2e8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 11:47:13 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 11:47:04 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, William Breathitt Gray
	<wbg@kernel.org>, "liyouhong@kylinos.cn" <liyouhong@kylinos.cn>,
	"dayou5941@163.com" <dayou5941@163.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 00/15] MTU3 counter fixes and improvements
Thread-Topic: [PATCH v2 00/15] MTU3 counter fixes and improvements
Thread-Index: AQHdVCieIpLZmXJmUkCGpiK8a4VTHbbuo1iAgAARenA=
Date: Mon, 5 Oct 2026 11:47:04 +0000
Message-ID:
 <TYRPR01MB15619D1AC671680E50A8EF92585962@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20261004174752.507499-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <TY3PR01MB113462D03DD936D3A21D13A2486962@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB113462D03DD936D3A21D13A2486962@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|TYRPR01MB16231:EE_
x-ms-office365-filtering-correlation-id: 1e32ddc2-d334-4dee-f06f-08df22d66092
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|11063799006|5023799004|56012099006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 0hjZLn7HQqtV/ViudvRz2YQfoxNqySyZ/hwRHrbdbfY7n58XXR/65sYzfqUsdNdhlMepd7tM+l8bDkOwBpjdFI2h28ZfRgwce8og783aoudVh3xykmnO7GzH5jHUNoJaIiowIaJOb15uxeQ/0lU0ITJspZasGmpTpy8CqqF86ios7gHT6OzWFfmOUR0ZidATzIgdcFDKfqOkD+xIqSePaEZe4PCYH6bB3RbOhB9V0RKE/VvQxWxsDeSApFt2WNErEi7nF015KpAX4fgsC8YbOVqq4wfB/oHkqHj76+J4dWKtNZznyrhi8mAFM/UoD0MS2SU1d7avb7PXVhi8U10Sn4FfM9ewE7CTzhSenQxyi0qmM9Rm4XHe6+xgCTiDT1KsePZhErGqtmGM8EQ8arhODYY/y66Gk0PUol/25/YUzIAguo6h4u3cqXcbYQvQ0Jyif+J2SZmTWWnuTzeSudU0A1Ls2luJAYP9bTFSpEOQN0sJI4vGQ5hISV0gFMZiOPN82rb+omWcXBdOpyLv+agZ1YM3kVA6mT9K5+mT0H29abnvX0wKj4OZZIZnWfzsp8E5OmiJw14dcsuEQGXGZEr3T8NezXdhs9kdQNhHVarHiqfu36cSvya8rTHwJtD3JlDX67pFwJ50lowgbfaYqIQtVC+6uK1S98+TllQpJSNod5+QyWdS684N4LClyoxcMk1GfX1x4WfId8ID90ljjyby4YxMeosnK3Wchsvy2GuYaO4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qFViG9k4vkV5pZmPvIaBth+2Yd7+J+P0hz6vRSiAHQcfyuH8oBYHza3d4dpn?=
 =?us-ascii?Q?PzkAZUe3gVvQDWGelCyMguj/f9UctRgp03nxe5bCaqG1xTv7yFID3cMNzSia?=
 =?us-ascii?Q?E9OS+QwlxQwC+GUp1B+WV/AHOup3FDDBR3b6d6VT7t1daN5fbSHYuLHReLoa?=
 =?us-ascii?Q?pSALgmmMKlM/KoRpkaXNQi0lB2QKXfFfa2VgB01lbiJDyQmZf5e7m0LoDEWC?=
 =?us-ascii?Q?tAxnP6RGpOjzncwcsOX+RVcBsmPX0zes3UqinVjcIMZdmP6GoYNHbkrVSUza?=
 =?us-ascii?Q?kQHcdzAJx5ZS8vNGKN18muT+snf5S2GEYEycpjNGkZNytsplf9FDoLZiuYKl?=
 =?us-ascii?Q?+riDyXWl4pyjQKkYuK4P3UVH34YxH3IfrjPidW/jzf8s0XgqHRm8aTJ5v6uJ?=
 =?us-ascii?Q?u3ukbpxZ3M0tNed5K6V1IaoizVaP1fdc3qqbA5kIpNfu5pyJIe0reJsTomXg?=
 =?us-ascii?Q?Nya6hwARaSeyhT+EUUiV+u9uTCWJFVRwLjjuvSnHNYf66WeSxI2sZaJMZ6LA?=
 =?us-ascii?Q?cgzW68xXtBM/B14jukYJpZZUFq707yRTJgO5CZpuV7tJ/LdoKTHJnaZhgEiZ?=
 =?us-ascii?Q?EDx+y6fqdAcqfQJvxZR3vo1QwiZrWeEdv/+OCRXlj1A1bUu7boEHGUWbR3gd?=
 =?us-ascii?Q?N1GRbDbIvwZ4geoLKCJIIP+UY+Q/kkFe1kW6V/vAughkaJhlFYsJMLha6Nzh?=
 =?us-ascii?Q?fdY3Mts9vCf8fzQL1ihcgdJQ6Ng9DBj42HcTdAFCmtzAULFFrQrV/Ro4W74w?=
 =?us-ascii?Q?R0YVPVmQNOIPYrKdYcGzSC6DlZ/kLFRbzASCIqNCRvZYJiu4TQym5mesMTKt?=
 =?us-ascii?Q?g3m0gu94w60LFpL65Res0uYS40zK7TwcMV66GR4dAyhxubyLVDOkbsr0A7fG?=
 =?us-ascii?Q?3eC971AkuIGWC3G1hEp/1uXNrOXZxvEu4z7iEA+3eTJSR1Ks1IREAz4Q+fFs?=
 =?us-ascii?Q?k59CNw6CPVQW+US59iLasicmp4vCj2vE7nDjk8hMA7Z1KElt47yp9zC8bZuh?=
 =?us-ascii?Q?4NjJs9b0Tk8wNYyzBeecw2ymHPaJ9UBGrAEJoWPMF9WMSXLr5h3I0WsNEBO4?=
 =?us-ascii?Q?0yJVYz1Y/r1QHySuskvFYgx4gQcEiP7HiNc5HkVV/ToFD2UEhqJPjVyAsDSM?=
 =?us-ascii?Q?yIldct/Ucgufvh1TysHl8rYdBsctIZ2HCkLSuUbDw15xc3rJFmTX0MRt/rQP?=
 =?us-ascii?Q?LOeuvCkrxSxQV/CgYEMFF/xpI+0x3grR/9ZlTjXU8E3PJAPAdkCiLT6K0jzp?=
 =?us-ascii?Q?ZHgiljfSrZ7pDhm6No4aSM9ClTvI2LKlNinygh7lhq+xj0zkihNt1ksmZZ1s?=
 =?us-ascii?Q?E9E+fyhN4kGN3LDGc2V7d43mOgYpV0wSRF3Q5oL8f0OEypAC52TFfmEvoFdk?=
 =?us-ascii?Q?m6EjDggFTHSooRllGwT+hLAplGriWRyn/dpbS+t5ni+QexJ9BAl7LiLZ/QTB?=
 =?us-ascii?Q?qQCLYcUXuu1J6/GQnlfgRwAlHvXwpJywMgRtyRWaPdPW+VeSntsMKtmFZ5xC?=
 =?us-ascii?Q?9AuYfKkFMv0Od934JciO+RrzP2LAKk500mBYcebpZdpCpZ/jVFnSeig1egRV?=
 =?us-ascii?Q?Nr0fSqZ/peRoXaiphWezTvyBnZMS9fPCMZ4CFJux6YPc+H6hHYEBNlWIibQS?=
 =?us-ascii?Q?hutxqdMiQhCuTOcESg9zhJ3RbIhzSlWk5of00UxxpSSKn5BQLt7XHrO57xKN?=
 =?us-ascii?Q?xBm1o8u7mTkjdRNTpyWq3UttsL+u/tR3nyeKFk6pJY2xIDt1WUlUtQEj7/q6?=
 =?us-ascii?Q?vdEE/opAw0IUKVDUc4APsqdC2ctL96Va+PNsm64+mdvTHI9Z1Gvk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15619.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e32ddc2-d334-4dee-f06f-08df22d66092
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 11:47:04.8401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veGntpgzhFJkWmxCCKacJZKzHVgjvSgVNzN1PiT92bHx6ZBZEv4j5UZFeg3VXrml1/RGjgwX+2nRNLgBU3wXkgIMZPfF3hMYPcryv5KiYddPm+sZd8BVI2iO68RsSgf9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16231

> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Monday, October 5, 2026 11:45 AM
>=20
> Hi Cosmin,
>=20
> Thanks for the series.
>=20
> > -----Original Message-----
> > From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > Sent: 04 October 2026 18:48
> > Subject: [PATCH v2 00/15] MTU3 counter fixes and improvements
> >
> > This series does some code quality improvements to the MTU3 counter sub=
driver, while also fixing
> bugs and
> > adding caching support so that registers are not touched when the count=
er is disabled, as there is
> no
> > request API.
>=20
> I believe you need to rebase this series on top of[1].
>=20
> Since this patch series is caching userspace values in memory,
> It can support suspend to RAM as well as in suspend to RAM,we lose
> the register contents, this patch series can address that limitation.
> Can you also please prepare a follow up patches for STR support?
>=20
> [1] https://lore.kernel.org/all/20260903090719.3498955-1-dayou5941@163.co=
m/
>=20

Hi Biju.

The changes from patch 1 of Li's series will simply be dropped by us if
I rebase on top of it.

The changes from patch 2 of Li's series are superseded by our cleanups.

The changes from patch 3 of Li's series depend on his patch 2 changes,
and are equivalent to our patch 1.

I think it would be best if Li re-submitted just patch 3 alone without
any dependencies, so that it can be accepted, since he also submitted
it before we did and we duplicated his work accidentally.

After his patch is accepted I will re-submit this series without patch
1.

What do you think, William, Li?

