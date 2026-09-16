Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011018.outbound.protection.outlook.com [52.101.125.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F79943BDB8;
	Wed, 16 Sep 2026 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560903; cv=fail; b=F5Q6C/3ww7twHdKOV1YxiIEuUmsE5ZgU6pioY+8VlvW95/M7NQhBgk64KkRNIywysH/J6oth1fscNCePhCGIsrEkWaM+nqJ7HgcnrwVJqNGQW9+3BR1dWhOqnE6Q1qPNsIux3BExT/pAfdO5kol4660m5b/4Duau5+JB0GDnA0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560903; c=relaxed/simple;
	bh=gnzVNp2E6yQnVci5jaz9JLGwbUqdk3YxWimqrhbk28U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DC3HTUlvVfYsNKK2MLkQdPJGuDibXOI0BFIlmmJZ8IpABTM+RClQ71Fwiqxq9QJUcBak4pWGKZqNnCrJkNP5nAov51+Mt83bld1Z5LbTu7dpToWVKw77vFNqIPYgvYR4SkSxa5+Nreja7Rk42/gWy1FN/gHpzMnflFInbnR6PF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=TsAoTx1c; arc=fail smtp.client-ip=52.101.125.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="TsAoTx1c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WitiDQoHP8t/rDRXYVmfvLIteq5Ew2qv9gBbQJhQVaS4BrXoC1OHV7HK5f20XsvsRJt5S3897PZQjLwOGBrkvVMEYsMw/Qmbvbk8mpjfGgHtyFLgVA76IkjX9fD/QYvk8VIQfHnZf6WpkoWDtJ9g3K/DbJoLQJWoGPNrTtpvF56JpeA6BAIAUyclyIUj6weOBmcguR4bug6E7UW7d0YZrZR6QQgsca1GdyuM9jQLrdnb1f3p7g75DwvP4LJXcJbSSCkFPoDdYXer/pWt1szsR9AGtEOVY61OUHew7DmiYNbqRKi6fCdBuAG0l3oLmo134rDs6xwEqhxL/hhkpgxfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhospl1tTfwyBR8W7dUQC0oGZbsvss5RqsjRNOsqWHM=;
 b=sy9JmSK3yADZmT3eJrDpKQtJMDpOo9KSOmfLMItLAfvZZBn9GCXMV8MxK15nVE1GX7hI1cBy042fQt1WPrArbpB+ITolsWrnVvPHPsHLVDnUCIDN2s85Fk0AKeRd039g4dO5N9nxqsKDx/h7PMejOseBXsI93aG/SWEJzbmvwR1sgXFFS7sWD/eRzG5R4yvQ4RMzRV4ZZRwppXVTT+TtkREd3zOm2t0EDAQR0icBZG2AxXhfV6/bYmZ4qd3Tys7eALLu0M5Q2q+2GxB9YO0hLWeGfv9XIy/rUpohsJvKRar5NWfrm/MaoIvaEfvc1D4ApMfjE2ECpXTWLyAuQl4R7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhospl1tTfwyBR8W7dUQC0oGZbsvss5RqsjRNOsqWHM=;
 b=TsAoTx1c24Ftnwsxl/7dN6ldpnwd8hUsPDz9mRX/g0RiUvMT5Docx2Cs64Ey/4R1xRVt3Vw6LcepDSj2GrMbb3RqYNE8QokvErBAkU8r2QvwxpvTyAyEtqIwxGOakDvmZ+H+8cT0PDUbcmBTTgqy1GY4LWXIFKwcFL6eRnrbnFc=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by TYRPR01MB14208.jpnprd01.prod.outlook.com
 (2603:1096:405:222::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Wed, 16 Sep
 2026 12:14:49 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4%3]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 12:14:49 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Lee Jones <lee@kernel.org>
CC: Biju Das <biju.das.jz@bp.renesas.com>, William Breathitt Gray
	<wbg@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 00/15] MTU3 counter fixes and improvements
Thread-Topic: [PATCH 00/15] MTU3 counter fixes and improvements
Thread-Index: AQHdRIjS7Lvm+Cb8w0OeeEmukuza6LbRChoAgAAV1dA=
Date: Wed, 16 Sep 2026 12:14:49 +0000
Message-ID:
 <TYRPR01MB15619A6CE19EA46C5BE9A41AE85B92@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20260914203614.2035277-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260916105320.GP11487@google.com>
In-Reply-To: <20260916105320.GP11487@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|TYRPR01MB14208:EE_
x-ms-office365-filtering-correlation-id: 1b0d17be-b78b-4cf6-bf63-08df13ec1ada
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|10067099003|38070700021|4143699003;
x-microsoft-antispam-message-info:
 9VcPnJeIBmQi8WS+k+W6ps47VLRGvvCeCz/OzVbQnZkd2KmghpPP8PNq/cuzo26iMLNuuMl5ksnVkdOts4bwtD6gThGU4U+HLGJEmaB2ISct1jHIXYcWHnLRYQm3xD7+coT4gIrWCfWAJjKa+QakgNC8jJXUhYEDNq+3Quuf8+3mNYsw7Jcip3ckmHADasH25gH2WTNV12/IykkQmehcw/haHxfVMkqBI210mBhb5S/hJ3dUC4vzhFepTJ+XDqvL4RO154NXwzmjgyCQxiB3nfScrEn6U/Tm39iizAwfiBpz3xaglCUiGkcNTdJvHC/UQd6iyVp0tmbNgvdskF+SrBfp6mwqR/VQ4tWlNJvY1S1ZxzqlUldlZIDrDiJoMIr8klDE3QEvOgI14a+e4nKWryEgTOTwy+XokSdfo5Vn9Pr8lf1HIf4s34JHa2Elpy+iUbjEthCbMztYaTYqxi6r3kUQRNsP+H+Dqu1BYGrXEl5o7yLB7E3TIN6nQTeWr18dE798mj1/niOn/3Nus78XYW3eQs9oaZfTslk9eDFutmltggoxfxEgKQUGiPh2dbvm+gmIZbnaOSwiMYdg40UVU7FAilWBHvFw0hs70J/ltgiPKafupb3mOD9JitlS1Uz2sRv7YTyHycC21Do+W0THcBsvIe0tFrD9wPMaW7VZCG1wuOV/LtPejrwTN1gaMhnFLhLl/hbk9g2gBn/sBi2PBpJJ4lcKrWaY5OauMZLf2wk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(38070700021)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Lv4K36JG38a/CCIcl+Sg2nAbgA+mcoX5GrC+xe+j1YxliHBb3vcaHD8BP1NY?=
 =?us-ascii?Q?jdKmS/GzfxBC2r3gqJUYg77kGAIWQGoHHSWE29UFCvkP4KlaL4oqXsMtz9C7?=
 =?us-ascii?Q?1zp/Pq7ZJRu0sbihm1HaFIxtYlXaQChpVHu5/CxvLPx7CxVobBjRtfbqdDF6?=
 =?us-ascii?Q?a+VeJxSRlYo5w7OKJLtxH7Xi+dlHpL95ljzJ+hb8xfslIVbD08G61/WoFG8g?=
 =?us-ascii?Q?A5TrAASF8Nv+49j9sdIsGqMh83yLhyAXBSbuXRm1lsW+Tjd+nlUQpllP2iCX?=
 =?us-ascii?Q?e0zJeBKLVVJH8AUoEhWx+y8TP6in98hWRIssjusrmUHtz94qh3/IzfEtex3f?=
 =?us-ascii?Q?Yvpn8+zVB67754dNz8Ck5Mb7fYuq6sopqxuKx29kOmAMJp9fNXeTA1PvRs30?=
 =?us-ascii?Q?cOMj2rmQTMx2Jywj79HBnie4xWEKqY/iebYQmmPtQdBtisBUcK2iSTWNcLnu?=
 =?us-ascii?Q?Md9YUTzJmlfDWRRBdQc1Ze/iX1UCpPlOaPczR06jh88CgvnBt4FtI2jkzcx1?=
 =?us-ascii?Q?+zIhrkT8wUfO9tEJTXJbX8AWr4iOzKPLrfq3f8I58bGIgfYqILWn802n3rbg?=
 =?us-ascii?Q?PwRU/xfu7Dy0WbNEfeUvfK7YU/rPyDfb7PhuSneR7YQWS2rEgkaLtGceCf3B?=
 =?us-ascii?Q?TS8h2e7hZZEvI4yi5f7gUGungxePd3QimyAEWRi5DsmCh8YsYkq7v9Sa/DuC?=
 =?us-ascii?Q?a8ar532M3ccCTv03wkO3tohExM8fUtNQEL3RWSGowWk62IGssN3VlrENZwjh?=
 =?us-ascii?Q?Qg2gTd/reVWL8RiX+KXxltVC0xy8ugoUNhBplqm4zWx+BmYEoOal66AaRMiB?=
 =?us-ascii?Q?zMoNFQxHmeQYSG8G5dB0/nx5zEeyUtlcbQ2a1w0jiIjH6ALiXP7EcXpPTtzu?=
 =?us-ascii?Q?tZrCvVIiIrjSQwwFKABGQxHDqNR2uvqzt0urTv4ZJfrtLdZ170nQO3/ZTgT3?=
 =?us-ascii?Q?QIz6Up/xNEKqTlk/Qq7Yf/9JICMXX/eNCTmh9Cus9xBxiHnErf1wJI39f6wJ?=
 =?us-ascii?Q?a0x8HpFyoJ3nBkB8tEMsR48o643WjarUeKk+u9LDkA24x0zYsalrhC5CjxkM?=
 =?us-ascii?Q?zVlbpHaHXl9yufpqcFQsPpU5BlSZf6v6Xw8cX85bWn5QDZ/VM/6HVNWLYh9v?=
 =?us-ascii?Q?yIMJgEJ65WnPxTi59l0Tpg9JsT6V6wfYLiFDEUlGB3eJvHWqQyxh5bZaHSJr?=
 =?us-ascii?Q?a6VCM2Iy4k70Vs6Plfo0Nhf69r6giQQtVGxWWmJT3rS0hB0gm90slzbcfd/O?=
 =?us-ascii?Q?8dq1IgLcBchaIgkFWqgmTG0TlsXAkudu3bofMOlmXiqnnA5xllVQGj4vzmRS?=
 =?us-ascii?Q?vmvN59Y0B2AQzVKfZnfytkZxnbOnl0SOoqMQW2VtdDruQEDqnlhtbLUPrHgS?=
 =?us-ascii?Q?TyAzNWYOlMYoMTgTAQ7eyq9zcse3SNt+mCOm7q7uEw+bVf54GJS9F1X9jP2f?=
 =?us-ascii?Q?ku4lINRVlqjMmWPqmc9X9dBZgNK3o+Srlz4aZtDlcqfjtUTPsQIOBgF8i6X2?=
 =?us-ascii?Q?PvlNfcIXBJX+mLbWIxin4JHfdlgOBialjq3P4H836l482HeDJc4gKuGUEGbr?=
 =?us-ascii?Q?bypc07sjIARmBp3PaCjAsxXS+UHLlU7M3yovzBRscmY/ew4WbKut0G6iRbMh?=
 =?us-ascii?Q?8dBTX6FH/JeJl9mpjskT1t6hKxqj6oePyXxTFIQExoJGFsap4twpi+TI2nEd?=
 =?us-ascii?Q?83LatOuARSkDbvdSsdLiJDHcu0lB3bTo2a/EcSmQGnrtpU6BS6vREcMBmsX8?=
 =?us-ascii?Q?dRpJ48yeKvlWVXkrThcZLEloT9r5sTcPm7Ody6wK/CG9qahEa5DO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0d17be-b78b-4cf6-bf63-08df13ec1ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 12:14:49.3176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FFPIicArooSWobPocXtnYno5Hi6GPNW0qt+U7aSkse17RjOwFe6dptyMhYne3qqlq6iDn10jWJRBCO6v1adGZDxVlSSFAQ9kLWl+UwUbyZ57l/t8zdWbfl/SOq/3/zba
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14208

> From: Lee Jones <lee@kernel.org>
> Sent: Wednesday, September 16, 2026 1:53 PM
>=20
> On Mon, 14 Sep 2026, Cosmin Tanislav wrote:
>=20
> > This series does some code quality improvements to the MTU3 counter
> > subdriver, while also fixing bugs and adding caching support so that
> > registers are not touched when the counter is disabled, as there is no
> > request API.
> >
> > Patch 3 relies on the following series to enable runtime PM on the
> > parent device so that the PM domain handles it automatically.
> >
> > https://lore.kernel.org/lkml/20260914201456.2018403-1-cosmin-gabriel.ta=
nislav.xa@renesas.com/
> >
> > Cosmin Tanislav (15):
> >   counter: rz-mtu3-cnt: put runtime PM on initialization error path
> >   counter: rz-mtu3-cnt: do not assign struct rz_mtu3_channel::dev
> >   counter: rz-mtu3-cnt: remove manual runtime PM handling
> >   counter: rz-mtu3-cnt: use device-managed pm_runtime_enable()
> >   counter: rz-mtu3-cnt: read enable value from cache
> >   counter: rz-mtu3-cnt: disable channel before releasing
> >   counter: rz-mtu3-cnt: unify ceiling values
> >   counter: rz-mtu3-cnt: cache ceiling values
> >   counter: rz-mtu3-cnt: cache count values
> >   counter: rz-mtu3-cnt: cache function values
> >   counter: rz-mtu3-cnt: cache external input phase clock value
> >   counter: rz-mtu3-cnt: cache direction values
> >   counter: rz-mtu3-cnt: keep cascade_counts_enable in sync with usage
> >   counter: rz-mtu3-cnt: drop conditional locks
> >   counter: rz-mtu3-cnt: use pm_runtime_resume_and_get()
> >
> >  drivers/counter/rz-mtu3-cnt.c | 443 +++++++++++-----------------------
> >  1 file changed, 139 insertions(+), 304 deletions(-)
>=20
> And these 16 emails are in my inbox because ... ?
>=20

This series has a Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L
MTU3a counter driver") patch. get_maintainer.pl's blamed_fixes picked
you up based on your Signed-off-by on that commit and I forgot to trim
the results manually.

Sorry about that. I'll trim it from now on.

