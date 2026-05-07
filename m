Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022124.outbound.protection.outlook.com [52.101.66.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687131B78F3;
	Thu,  7 May 2026 05:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778131324; cv=fail; b=hUE7r1IKricr248vVJN/ZOds7TbZsW+ECiaUvcIFee2UyUBXePKkjeyR1BwEi4s6F8Lw2wkpo5VOIraaz7K4EV0TID/dhZlRqu8AaY1oNOjCr4B9Xg5fMknP9N8vhgZFIa7ldadQvzUt/Wf6plrgM4eMW74mkU1pLDWhT+8wYaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778131324; c=relaxed/simple;
	bh=XilvwuUq49nXV8iBL4I23BLei4Mr3O/IgErr2VoJMt8=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sb1RH9WeXAUetl5sqNluqC0e1Rw1y87BD5oKEMxIJmwBK41EmeIay7CVtEF7L8BGeYyn+wPniyXayIRsGENMbnFS1jtozmSh9ZPpf/AP4ycKd8hVoHplk9XjZr6nDaT+0p/9+xfx0QBZv27lPoKdLaOwUCys4+RIQt3duX5a9JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=Anq0KrJ5; arc=fail smtp.client-ip=52.101.66.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="Anq0KrJ5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJuFzueUl0j0egTdVnOXKGnTnTTb+ij9GNskuCaUDymeqr5Nq+0NzA1bLlhzsR4hdoArbvqNzf+Dpf6cMBZtI2u2iIpdTKukIMky08wm1F8hwaDo9Bn7t1kPjb1rQXhKuwvANH6odpOUeHv69mMZEMHEe4LrjFf+P8nvZuWcPL1snRv+Wnk4tqD8N8fvQb8iuMj1fXP7r+PWVsmml42YfMDLsFz6eN9rXsMGrxoVuUN3nCRwNHc7wm28O2LhzoJbjZWDXdkZ25Hd/y9K5fyUGcUwFIhuecSvpgXV8Ny533d5O4OLE3ERGYlhocnVt16NxXk3hPeN/lzk3WiESN4mRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynZVeN25/JE0egHtZ3Kw00zDGBv7HZER25nFJQEzZ9g=;
 b=B/FYyJUuSf4nrmnyNpZ/7T1+IKop10ArY3Egy2PHCWtvk3S1KdBj1/w6zZpGTWWbNN+2Yoa0c9nCwqAF3fTGyzKJKkA7J214p4eFU58Atm6UfhIKWksWFLwjizpxFEN+HcFXZbYw5MsAe1aLpXbGyYVZdhDqZlXWsL3hzqa7dxIDM15cnzuGxZ1TR1thYo0bpIBdPyf/z2gSfj8OrP1xme00c1Ob+jpiFNTYrEFfBfao1ijdH1Puhy4HFdM9HK0GiCdPtKy8b5wgNGVKnzMb+bfoVW4F6ks1deUc4X3X1Of0k1htGL9hqmh9Mdrqgr9rCwfDULAHMs3A+MwvWURFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=gmail.com smtp.mailfrom=topic.nl; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynZVeN25/JE0egHtZ3Kw00zDGBv7HZER25nFJQEzZ9g=;
 b=Anq0KrJ5KajZESgf5UL89ogDu2gBOhxauzaCMqP5mc19kkNrebnwr11Xo5xQQVpBV7ELwkbekkDBA9XoO/zTQDrqGvyVn3bdfmRmrJRrCIZu1j0ra6QB/XlqXInb/cxqxxrnIXT5xIs7hqQWHZQj7E2lcXu6r4f4W2vWG+FDAAm6jBYYJnkTHrQUDV9VGyvaGlN86EBlY5LzjCTl6TPoBDD/KxklBhbPdstn6BHyanrAW78ZsqRRodcpxVO2u+cTCCQ6+wZ3k0vWx7OSX0388GPq1W0Oi2MzNXw3g3enTlWjQiqILll3asaqc30QHW2izn+rHMIL9dHWyHGgyx4SxQ==
Received: from DU2PR04CA0346.eurprd04.prod.outlook.com (2603:10a6:10:2b4::33)
 by VI1PR04MB6878.eurprd04.prod.outlook.com (2603:10a6:803:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 05:21:57 +0000
Received: from DU2PEPF00028D12.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::a2) by DU2PR04CA0346.outlook.office365.com
 (2603:10a6:10:2b4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 05:21:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU2PEPF00028D12.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 7 May 2026 05:21:57 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (40.93.65.49) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 07 May 2026 05:21:56 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by DUZPR04MB9821.eurprd04.prod.outlook.com
 (2603:10a6:10:4b1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 05:21:55 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%5]) with mapi id 15.20.9818.031; Thu, 7 May 2026
 05:21:54 +0000
Message-ID: <9ba5ec6a-5b82-41d5-8b65-f2f3c10fd387@topic.nl>
Date: Thu, 7 May 2026 07:21:53 +0200
User-Agent: Mozilla Thunderbird
From: <mike.looijmans@topic.nl>
Subject: Re: [PATCH 1/3] iio: adc: ti-ads1298: Add parentheses around macro
 parameter
To: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org
References: <20260506181508.6813-1-shofiqtest@gmail.com>
 <20260506181508.6813-2-shofiqtest@gmail.com>
Content-Language: nl, en-US
Organization: TOPIC
In-Reply-To: <20260506181508.6813-2-shofiqtest@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0P309CA0010.EURP309.PROD.OUTLOOK.COM
 (2603:10a6:20b:28f::17) To VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR04MB12030:EE_|DUZPR04MB9821:EE_|DU2PEPF00028D12:EE_|VI1PR04MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c2338b-598c-419a-8293-08deabf88f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 KaQcgkCL0RGUTmBjcY5P7OFbYb+Kaba3O3hcH1sZWJTH3Tu15okSrXtWgB74gyLVVSlFQUkz8WXz962o2Fi77yGXG+RVvh3L5VMLMttJ4Zf5zfbqG+vpo6+yYQkXEq7YMnNw0aWEE10UEwoh6w9UW9W+R63PR4Zit1kn/UaraNEmS4q2j2d7VvVeaDv4l3BDMs03D6vRRKCdVM4plK+e/tpzBZ4mwqB6nAGpjG69reizd392sSfByiTkI9tF+1BUXGqXMnItdFIPorV7jKdTW3bmuM9Xp9gMojnWFsaphVUgvtLkENN8fQopjepUaK2IGZXr9j4CZEbOeEcbtIvZRNEM/8o8sydycmF3clwWW+VSfMetZqwFz05rl7vEVQIRjpPAo89IT9lsjB+qqK1gjrRVtfa67zxiJOwevSDDAhft5zS8Zl6hE5gUCD4H32lhc6eVJjMAsu3HIMVZWUpLrlYTqEHMF6L/spHSplOSrmAcgMHGIWjc2wiSyHR8TCRxu/+iFfRYSRsSOIdsVNYkMxqZzfKorCANwUOIOLTX2xfqt2pezk9w8zjaDZbZCNDLsEdORlttMxFzJoA17aqeAho8fPu1lDTmHGvHPDtYCDZ4jbmcTDckmKE8LlcGiyunidIb0sk/FVnstW6YyG/VtQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12030.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: pMmS/qz5/dMnLwZ2CWZtYMtoCTgmXNi3CeMLNP36sM6NiHg9/vjcT2R5ppHzQXBkGluooUrk0PwtcGXY141Ilborksp1pZTkNw52zcWhMKomtK8IQbBw3lbkK2aKEbte2PPgCyS8FImCqlXjonWWA4hCl1e4VVpEvltiayqy4lRAgUFwMRePEsLB/G6qoaZXYdq5UZYUGfMaRZiz6OGfTnKdd9JPfXBmvQFezO2xOyaoKvjOz61mMWQy7s+SANpbGuy6DyYNkpw+1XMMCCTYZCNQSRlLalVHpUFDSR3UwGigMgV0YdnLGAbF+h+9/1ZR7NuHWnEyi4jkBY6mdGuXbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9821
X-CodeTwo-MessageID: 35b4878f-cf17-4205-accc-717d3793cf37.20260507052156@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	763ec110-2924-4c56-76fa-08deabf88d71
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|14060799003|35042699022|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	CuN2Wad3+ML89pOlBYv7S+GiDT8d9s0pe5KIK2EjMR0AeLzi8wgkmDI3hh9LKsuUoi70fIQwUPlBoY0GB5qgUmZU5Uv/UcKpYjca4Ws11ai/uhgs9BJuHahQx7108t1QwlC8FNdMUeq+922/blvdyagBZ4ZEoYKjlthwBNZ3Y3DIVLT1KwKO5TPyykmPjuvs1lG4HbhxBZNIsRFLYQ9K8y2pd/l0nb11Wr2fqxue1eXu7eElGbJtgeEoD7NZO3i+QEU+Sst6FM39Gq78JUWDs3htzfBG59L8ZGsHm/DRuo1tF4NiVommBFBF5PSRe7uApopQqC6KOW+kgeN8rO6z5akOqrnjR9YBLYxYQ7IBB3dRiPgTyBqy8HuIqrgJgvhi8SrGJVyEpczAlnU1G8hUCcTuVKcs/wlW4TxhjbT+GmI4MfmPWvwYZpSG4h99DkizCHc8mY1k0h0lHpkVEtCVqBzOFCzFkLEqKOvjLGDNRnETxIbBhIXiU17wPLezsvu11hU9Jado4P5G/K4aBUC7TdV+EvkDMODek1QsNuzzVa64UAavpmwn2/XhLRTOnXn8+wpZfyMznNkoeZOAePjs/veBqUEn3neU7BceGT95970F3qdccwZp6Fow/C7yG9FN5FNQ9w3XFsolw8T1EQgL+ZMwCXDsB4Nn9c4OS6GVUxRoy8SMchcLe+Sj9GmyD6dV
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(14060799003)(35042699022)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vbgsVaq7mvzw1C9HlhbY/ran9Dk4nZi2lR91rzPuyjsB2ZEQibV6Ndi6sI2x0QPFGVFJycOj0IpROLw2jj/9vgSMl97wruKWzub1lSgU0dvYW8jTHof39AR+b4H+lgasv4UzVoZZpx0Srmcie5KCsooExzW5SvPKBySFoy0VaRhPsyGUcII3Qn8QDQsAXLzE1Xplp8fctRMHdHYfrKqfMqOyihSWWBU4YKQ5uDbRMlh8dtDh69sPgxEeI9clOpKeT/ajWyyldRoUdq7LtmbPRz/Evjq9iva5U5O1Ie7P3SH3Kgl1lh0NqV3v2ISU3ioiPLlk+ckDLq7pHIcyuOPW31DLIRaxBU/nsvpfj9cbmrBmdyD1ZGHyXWuOa8ISHZZnqXNUuCboMVHlz89Dma/X8A/Dl68yX9EsZW/kkYQs12UIdCc7ganEYgg1PMxReyNa
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 05:21:57.6684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c2338b-598c-419a-8293-08deabf88f53
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6878

On 5/6/26 20:15, Md Shofiqul Islam wrote:
> ADS1298_REG_CHnSET() is missing parentheses around the parameter 'n'.
> Add them to follow kernel macro coding style and prevent potential
> operator precedence issues if the argument is an expression.

Acked-by: Mike Looijmans<mike.looijmans@topic.nl>


>
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>   drivers/iio/adc/ti-ads1298.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index ae30b47e45..cf5f954206 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -66,7 +66,7 @@
>   #define ADS1298_MASK_CONFIG3_VREF_4V		BIT(5)
>  =20
>   #define ADS1298_REG_LOFF	0x04
> -#define ADS1298_REG_CHnSET(n)	(0x05 + n)
> +#define ADS1298_REG_CHnSET(n)	(0x05 + (n))
>   #define ADS1298_MASK_CH_PD		BIT(7)
>   #define ADS1298_MASK_CH_PGA		GENMASK(6, 4)
>   #define ADS1298_MASK_CH_MUX		GENMASK(2, 0)


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



