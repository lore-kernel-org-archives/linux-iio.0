Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035B236897F;
	Mon, 29 Jun 2026 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736496; cv=fail; b=CWI3ux4607DzlijWeif8wdpviXp56jF/U/Cxuhx3xv9B/3oqiwqQjR87IJcnU2yJVtVnakb3mCpF012AHZBYxx+cyx8OHIpPJGcmhy+dZSflwLq/LYYVonL+87nKwPnXl0vNN+Lq4MfL59quHZA2eD3WiwCDjBKG2ENDzKmJwjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736496; c=relaxed/simple;
	bh=2bu38LPGRqCYEorGYGiFv3M5WDqv/9knazy0gj2Giro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uwIbmwel+9xiRwkESxEmP+5SSK/n2/N+2aDWpSH8QRc0lrbTNFIoPfwx8X38+c/3Ow7GqcwYR/UoCJMqaX9CR57n+5AUhGOSt4WXGla7gSYX8800H4zXQe7jt6o24nl188K2XOit50eUDKzWRC5g7XW3OZDr9nR1lQ50WdxVN+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WNtVCTkA; arc=fail smtp.client-ip=52.101.56.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WNtVCTkA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEj7D87cdyztg1uULciDrsdmDmcDfdn4AHsNCotgFcvCqrCo8NrOy0Ph+WIGraNyXiUWs3aCGSMN75YrNmMuUeOLmrH+3GW5EOevMaeQofRXO5n5kgjBknzXJfwe4vU6zYYZV5v2E4Eanm/DmiTTtlUlcUZcC+TjRfeTIVms8zY9o+pxPatz+LUvb0wYU8bfEzHPh/Rhmv017fxtRqBYnLJymOlVAmgovCWN4MgfW/Fu7zmXajaevPghMRLSrft8GZRu70+Y0ekrbNMGBzpqMVbYIR/TvomZXvcvqVjxnllalXtl1bfgyiIr2yOShuawjSXRiicKyojYMPoBFy81Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKBH9rwvBB+mC1Rv6MMAzmHOc8TFl/pAYu5g6cuHSmg=;
 b=DzQtTin2Q/63T4/667ikVhe0o83p9YrNyxGX5XYw6zDWkQKwKwEroE7Sl8jOFZeJiMZD33tAjDtRrCZFAHdvW4MuU8UoRT/37qxnsTiJ3GikSqtowfT+0ScZ/aqcFcEIQptR5edtwviwP5Ik+x9yeyMfxUwqrp2o2y6XvikdseYVPIGlzbsyrUUl74vyyZs7ZpXjuXGmlJsC1Y+U6r4LeIzFva3dN3JybLtb+IE5psr4+O8LvKb4oeH1lOL7HIfVpAdwd5jvk9inM6GAvwYQfX8OYZxi2+khQMnXoMYCZydOInr6H86ygSK6xQeD142tYO30xPySMrg3XaBQkbixHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKBH9rwvBB+mC1Rv6MMAzmHOc8TFl/pAYu5g6cuHSmg=;
 b=WNtVCTkA4E1m/UfdcsNqRRPxdkcfaE7eQo5L66y31piZriD2gB7FWhabqqpXuqqq5usGfKXaXpLdTI6YMGjth+HpCdcNakvj+sV+qZe5dfNG3YGSuq/pvlAbySRKVPAbj3ypPi0LEPxzZ964vH9Y0wHap/NWNadQBlFFr6uohB8=
Received: from MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Mon, 29 Jun
 2026 12:34:51 +0000
Received: from MN0PR12MB5980.namprd12.prod.outlook.com
 ([fe80::bf53:5255:50a2:a6fc]) by MN0PR12MB5980.namprd12.prod.outlook.com
 ([fe80::bf53:5255:50a2:a6fc%2]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:34:51 +0000
From: "O'Griofa, Conall" <conall.ogriofa@amd.com>
To: "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>, Jonathan Cameron
	<jic23@kernel.org>, "Simek, Michal" <michal.simek@amd.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Potthuri, Sai Krishna"
	<sai.krishna.potthuri@amd.com>
Subject: RE: [PATCH] MAINTAINERS: Add Sai Krishna Potthuri to Xilinx AMS
 driver
Thread-Topic: [PATCH] MAINTAINERS: Add Sai Krishna Potthuri to Xilinx AMS
 driver
Thread-Index: AQHdB71EK9STnxhSAkmpBr5+JvDZnLZVd7zw
Date: Mon, 29 Jun 2026 12:34:51 +0000
Message-ID:
 <MN0PR12MB5980FA3666BCFCFF2C359AB48BE82@MN0PR12MB5980.namprd12.prod.outlook.com>
References: <20260629114754.203415-1-sai.krishna.potthuri@amd.com>
In-Reply-To: <20260629114754.203415-1-sai.krishna.potthuri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-29T12:34:19.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5980:EE_|BL1PR12MB5755:EE_
x-ms-office365-filtering-correlation-id: d09aca95-f8af-4581-3081-08ded5dad0de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 qcXijEEygFv9jwKz91BG+gDMoiqKGPNOLVfPFnhAhX/kzQmbBXlgLwyzvKfFHsazvBHlLhhvq/AJO9/eDfEUWuwyvxW6VOtOqEINu/4vNdDsxvaIBkUdf0fIstuCewf8dxstkx/JYpETJH0ItIn/6BwwNlxewRQtnzlTZ6D4hadz641Z8SVzfw4yygjgeAEHSeax9TbUnmaaDpMAIL6V6Naa01lMaF/QQybmRWWoR72w/s8abjyhfe9Svw4R6X19H8TkMBN0632XBl0zmUn2n0XfpsLt396kFKohhowLviPYNsMbL62sOkKgMWhXYwjm9df3sq8TVPys1BMK8z5RtGscHyTvCeJhZ4qA2XCcdeejfqs8cnKfGpl/QVOaekbYY1XpYGlYlk0/qDLSRtOFcbnLbFrAHK2J6/03I8J/jJQva+Ne0IWR2hfyRkt4efIsDy5weNbI8ITJfcsxbxLspoj6IG9H87pPf1yeKJNWbb2znN/BLAB0g6+KWP4685gJqFEwG5qnuTCN6cpyRx2BY3Vlv2meiVNB5YX+6RKdW9z+1hJIH3kuesf2GPgwQrRGTGa88jEGmGjKudURaNGNlmvQTkIAhw4KHpSytKg2WhEYBtRUXXvo7+NA303+lVU41eZF9xmGezoFPhU/e84xY3v56on7DRrdX5hRHVGOWyJ9espOesI6giPv11so3Hbj3kwTLN7FyGhsJwwCSuC78AnjZyOCSgw7TMjnRwaWaQs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5980.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?p8HO8nglfzEbIuupTsKqd/9PEvswF3p+F60u4/TGqsbNHxjFNiTbbeQF1Ew4?=
 =?us-ascii?Q?OAycZXrTkOhIwd8cujzrpu6p4ORC11Mw4Nf2BLDT+kZRd0Ez9odwXjZXFAG1?=
 =?us-ascii?Q?mGAOoG5HguzlaeKlh3GMAOaFp7TAHL1yPClgievhQd8M6EXuTzmRLFwfaRku?=
 =?us-ascii?Q?sfkffpwsJX3yNIwjgFVLi+GoiNrjwIUcNJpcWOXcqxy3nHmC58ISnonm0ZFu?=
 =?us-ascii?Q?2gQyRBoajkJFlDUygg66XH1nD15cJIQViZ+EHWioCGXiaES9rZX33rvfkJDf?=
 =?us-ascii?Q?C480c1s3R/HxIsyH3xDhc5UwSebktdWSR5fg1+oB1lLDQGqTD0v8rkvjRm1d?=
 =?us-ascii?Q?9FaIQbZsnEaf9KErWaOtx5owFvRQ5weaPPrVZ5T/HyLARBugZVcNL4VDFEZM?=
 =?us-ascii?Q?rLB6woMJLs5JRKVmy6F2IzwlZ7fuFpK8UDLCHRCanM6oqmKHPSPuJy7Og44v?=
 =?us-ascii?Q?xd2yzcHtpyDBBp/xMJ6oqEOTRjWbSiYsrnLOuLIdMfzHi5qqp1HLH/6Sy2hY?=
 =?us-ascii?Q?B4Q9UrBYr2gGObBsJQynetC8w6LSS2aKOhmV3+z6NV0cw0e0NsoTukfkRD/V?=
 =?us-ascii?Q?jW8LPZNpjzgPhYz9G5YwHvpsAZTdPRmorBAKPx44SSW9tLVJYVqSOE6HIlRl?=
 =?us-ascii?Q?+bBdrMWqBelp2zu40yUyF/UalJ7OQFPpDOiZxLRaRVzTPD93L8fOXNV84H/S?=
 =?us-ascii?Q?BBD8ZH5YuPsgMfwYl6e6aQp8g8VuCV6xmAa99IIkfttbCYbXILRYihGTDpol?=
 =?us-ascii?Q?l6V/t0KTENiKqOf2fSvF6YmJ1+3VHdBSLOMDAJi+YeyMby+Wzf9Ghg9fQDq+?=
 =?us-ascii?Q?CbIgz02K4YcYGjeDh8PnBwhzP1Q6FmmZyEDkepHjnDuU22/G73YEQIcVJ4+M?=
 =?us-ascii?Q?aUkBYOc3pJikvgvbZyeMOq1GcAAG3ruopvsJ4tQ40PzNlS3r+vsISkB6ywWm?=
 =?us-ascii?Q?7oUwpbvWdymN3DLj7cRq0Bf7N+wIYHjU4TFC8IA4TKTwIO8Wm+C+sVZ6oW2W?=
 =?us-ascii?Q?xCgQ5pujVXuOY5oAZkDNdEo1Eye/qspfivYuiikeaxsk2ZU0ktlNJQSkdWyL?=
 =?us-ascii?Q?b5AQTsXPZZzcg4ndYl8uG5L3dRE74j2pi9EeDBa6ClNeN6xH1C1VzLxfKyhQ?=
 =?us-ascii?Q?q8fhRA9azdDubs6gP5FDBL8kg46S9PVtMH1wXCK3Gn87G80Q1wrA8eKsZPGp?=
 =?us-ascii?Q?vw11fXdRxLh8K2rhTzCIVd1Se3R4xraeMuDhBn57bfybSdRugVi4HkTpyjoS?=
 =?us-ascii?Q?FpJYUxF41XS/Bf8YNI3GvNZBD4U8jC7ca0yGNmULIwm246/vAfPVu8MG88Cr?=
 =?us-ascii?Q?O9a2sUcgIT/UTLfGy2ZQN7rgTkZL37XoHZpZejsfx6UzIzi6IPN/s6KWuNi2?=
 =?us-ascii?Q?+jxWcA6gQxu4iO14nZUrp8EKxlRaQ3OcwDDhVD7IdxS9gYxrSQ18dVUv+qq3?=
 =?us-ascii?Q?Evm69M6mO/POEiZxQzEm04daAcIR5qS8LQIcntpK/0tFFdI2rM1K1qopfTCO?=
 =?us-ascii?Q?yXKfH7b1rfIgAugN7bIIgZBWaFK3Jvx4ff+RtbUyoYrFsKlXOS41hInEFnMe?=
 =?us-ascii?Q?YPAjSgbRnOYRLZMH074xNN9pumrIL4yIfRcD5iqr3YCyDK+AmjUEBqpi/1DE?=
 =?us-ascii?Q?HlOSPhMp2BNpMXGCW+/zfrk0VVVZCZD+jiMvegZznGYZb5dMssjuRoU7hLJa?=
 =?us-ascii?Q?MivwZDhoBG56zI+KBVz+ecqfc2MH4EpcuyTqFmMZu2DB6QhS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5980.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09aca95-f8af-4581-3081-08ded5dad0de
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 12:34:51.6586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hlCA2vomhof/Am7GN+nikyXl86nxHsIggSv8d6owKIdaKpBIZvXMNaGevk9RQG7E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

AMD General

Acked-by: O'Griofa, Conall <conall.ogriofa@amd.com>

> -----Original Message-----
> From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Sent: 29 June 2026 12:48
> To: O'Griofa, Conall <conall.ogriofa@amd.com>; Jonathan Cameron
> <jic23@kernel.org>; Simek, Michal <michal.simek@amd.com>
> Cc: linux-iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linu=
x-
> kernel@vger.kernel.org; Potthuri, Sai Krishna <sai.krishna.potthuri@amd.c=
om>
> Subject: [PATCH] MAINTAINERS: Add Sai Krishna Potthuri to Xilinx AMS driv=
er
>
> Add Sai Krishna Potthuri as a maintainer for the Xilinx AMS driver for co=
ntinued
> development and maintenance.
>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6b4560681b51..924e004a8a5e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -29460,6 +29460,7 @@ F:    include/uapi/linux/fsmap.h
>  XILINX AMS DRIVER
>  M:   Salih Erim <salih.erim@amd.com>
>  M:   Conall O'Griofa <conall.ogriofa@amd.com>
> +M:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
>  L:   linux-iio@vger.kernel.org
>  S:   Maintained
>  F:   Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> --
> 2.25.1

