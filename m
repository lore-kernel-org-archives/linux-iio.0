Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013045.outbound.protection.outlook.com [40.107.159.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A13822B4;
	Thu, 30 Jul 2026 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439475; cv=fail; b=QpLcgcYboh2/icchZoC5qVPsOBDpDZCeXrAsd/RF+pWMgQD9QBs9CydNQ67FmVWzST9MYxT7v3BvkH85ZyXkOJz5KBp3m0B1wERqtl0HprWzQmBV2o/SQ5SjR+I07y1iyPFv1Muay15lv5Kv+3b4IXwaknzD+O+0dZ2B1oJWr2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439475; c=relaxed/simple;
	bh=E7Y3Hkv+LXQi9bO+dRXh3uysd1el1kEUeJRwNufhJjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dec4GWELiuruPzjFoQqI10wbCLY1gHmYdXrOZIOExK5iB8pSJ+u1ORgjXz3rDT0mqopVYZVFzwY3baGqvB3zYLeE5Tj8um6wL6gwIDninXFuFxVjqwh3fEc55mVbJkCX0y3qIImxOcFszYMSq+upGLf/Yq7fPGms4m4Zfx1K07o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=t3NbaAef reason="signature verification failed"; arc=fail smtp.client-ip=40.107.159.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t3NbaAef"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wig6aswmuPmw79XWJtfvwtVH11JygWaRZgC2aUo7MyG8Vjigo6Of38e9F5gpI4lQAzrdMTDC4Ptv1sYmdU68HSn8rC7QSigX6CPfHxBkV0IC99z383A4z+IH2ICt+KYcxSlIkRMWvRJ0m7FFLf4gof9MTUMIoFpLnvrZLwrPQpS8ulrN6RjDSbu2M8M00RC0J1hqfHWac67YJiVkQY2o/xrPVCDjbn39O2+6eQR/VQ/X6NfRDDvDEvH/YxwDHMXbKhopOsnKyzEvjzh7NWX+Oi0WYXoZMoDM8ji4v8PaKYed/fRNK0vpF274Tl+7NqN86cV1yguys8NxaGSAKSE98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dL2IXE56h+7NgIATzk1He7LYwgDgUL1nXBBuOe+OuY8=;
 b=mL6e27huzjRDFvU/qPgn7BNPQtbkVb5mSwdz1Xx+SqNTXJRgWNeuazRTE94aozJ9HLtIfEz55ynvOjdhtQONL/fz9E7Im3+V97s1lD7Uh950lCtFw/sgah+xeTvABw86YgGoKgN3nnHrP8GEz07Mqw6SSVn4g/3WTLL9BFkGX0x8TilCp83VhAVOkccbqATe6ecbT8Mdx5pqlhFWeZZe0EopqSoIeUGT7AKh5zPZZ6ygDMKRU9HqjW7OOpQneuOq1Y9wMhSwkmztkY62meGinI22jvhIVSx2aa592uC2pq5KwqvKZd2LXTVzqKTWjto7wXVWduoXFkXORR0v11JbjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dL2IXE56h+7NgIATzk1He7LYwgDgUL1nXBBuOe+OuY8=;
 b=t3NbaAefj50snoVtgQMfSfbmELteFNEk91rmmDpsNlTkGWSeGFDm6aWCG0K/4zvUgvolKo3Ba57MToB8i3RqLg/E8JwTXqBlQqDfi4sGuPtMq5GKDVTq0+62raHjHORB1mc/cEABuF3qrHGb0Ysz9vtFfIayjF/TiLTJWTgpC6to6qBamo6ulncTfIh8yQQyln6YAG5IJUonRVEgFGMDI/lq7u13MTJ9cooGrBVGcfFJ1O8zuKGwo0mmUGs/vaG27pY0NOMioYzVNOWeHKrQM9KwLSdEjOQ5rBFf+Zgy4eoKjgGJHCJTMOG3dZGU97atI8qC27mzVnYZaBMUy0tnrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB9317.eurprd04.prod.outlook.com (2603:10a6:102:2a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 19:24:30 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 19:24:30 +0000
Date: Thu, 30 Jul 2026 14:24:22 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: nuno.sa@analog.com
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 3/9] dmaengine: dw-axi-dmac: Use bus width capability
 helpers
Message-ID: <amuk5ic1FdzX49Of@SMW015318>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
 <20260730-dmaengine-support-wider-dma-masks-v1-3-3732f1f9d9ca@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730-dmaengine-support-wider-dma-masks-v1-3-3732f1f9d9ca@analog.com>
X-ClientProxiedBy: PH7P220CA0063.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::30) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: ea7a2849-29dc-4717-ec29-08deee702d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|376014|22082099003|18002099003|56012099006|11063799006|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	uVMmDznTHZrpEW+FGRrFJvZWfx8yNq85DOgFfhK2tShPDcRDyYWNsXG0gg1gArw2YhJ0pBEV1n3cyqAdJbbkx7jsCibA3p7KnhybIuz6R74ELXEeEMkPvITEWhAKvylYnJPbps1dC3mXKey59EThETLM9CaLn2b2wKW1rOu+eCWrJW0VOreW8E4adfe0BYJLri91KG/17NYh2YKBnwSCGg6l02GWbessqMNndejNojzXwO9izxd32lWE9h7BfCAfjWOxg9zNDAq1mZvsVpGb/HDBKpYomUohodWPL81fWVQv/4HHq6rrSxzn3tqCRlWowvdOcNh6aqW0pdCgpFL/4IM7KhhLrHHHZHstC/LA7yflDnvfLU22vZrVtS57S19NI+Dcfnl64GPJO7EQz7BgXDndHqB76S5f4ObW3l4/pCPEewpL6KMmshILTJ4Eb7W9hNlxdVeW+v8VMfiLBj5KDH0uKuVTM0bAYXYCmqCz/2Y80e6QrO35s5CIOXE/K98bptOYJYjxOyax7huJlNxbQiHPaEnZ/ZpRvQ4u7vBd0iqhJYXMG1X7vMJ+p/6xiLg9qYcu892Aci/kzBwVcZ56pc50ttJC+z51YRDPNlgk85HplULWA3QB+7++GeP0K5Pop2uIdQhv1VVbt2VwGQafkiq+MVudsMr2UVkeSwtumHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?SZosWCrhVX4IqT0n/K3CStD8ivL5+nmtjaP1W+l/PPZARmQSv2HMX/JXQE?=
 =?iso-8859-1?Q?fQVDV0OXgJyDmu1RaDUCmF1DCeOXCWpJsRogL91YVRjanudUl0rPfIi5HM?=
 =?iso-8859-1?Q?U6hvlje612BWWYoM/ujP+yZ2Yk0Cj/AAxQOaj0Mphkb4on9l78cQWWbFgC?=
 =?iso-8859-1?Q?2A6zmFxGAUyc4F1UfX/6TomullQCzk8885Jog6h3w4k4epXp4xr54DojDC?=
 =?iso-8859-1?Q?Ua6WtOw3oeC3J7oZ77dWxzEJcfMVEBN2iQ5R57tF2qjoVE1GwFS+H4/1yc?=
 =?iso-8859-1?Q?pDRg5QHM8TqbYIH7O+IIQNv+Vq/4qmWubtXkJQ0UmW+tR0ZVKVnOkPfHuL?=
 =?iso-8859-1?Q?IGNsBTn8idxHb+YGXTwlBykuI/A3y5SBwdJWJNLErIOeKWp1P7lcn4LvFl?=
 =?iso-8859-1?Q?FYm+j7iWaBYltMSfGjU7JDyu2rdKT1QpKPT1j+DNoL9niHjFhh5ZNHVRfl?=
 =?iso-8859-1?Q?J/pjs+xfj3jHGoYtSn+it6jMch1ydw4NpRK9SPomuhGJkzpjHzBTfPQkrU?=
 =?iso-8859-1?Q?0Bn2xS1mTWt+L0vzekiR8A6tR6YUrkrO3frOXnsGG6FQiNNZUwBpIDn7Dl?=
 =?iso-8859-1?Q?1B+i+WymlU7ytv9wVIrFIAuhUvMpJmhhXu7je8feL/DrDokiTDLhB1M4wq?=
 =?iso-8859-1?Q?zHEf3VuHbNHgKQy8UIrwk2yrJGnTfNFx9DNWp30yTS33lHE5TWtPTLYgJO?=
 =?iso-8859-1?Q?bi0K99YUOYhs/J0yS/29q9rfsEsUvmxn6GXZOqAb1Z6tnxOcbPhmCgHvGL?=
 =?iso-8859-1?Q?bP2xp7NRFigEYI9QeTI1g9BTdvL8RPREypVu/pcjAWW5o8NT2ZqFZC++lQ?=
 =?iso-8859-1?Q?4qh3C47jUffwn3bAQk9ocYX56T3klWBSIijzlXFta3Y68FCdJ69Zk+TdvY?=
 =?iso-8859-1?Q?ml92CH8CCN8sftSbTcZ48r25vOcVnMo+ts02qjwm8ix4PTrY+qcTHq1E9/?=
 =?iso-8859-1?Q?2ZCY0O0KOAlfhQ74q6RrT0HI7qktH9tQACsm5D4hrt4JvwZpxMsGMg8CNZ?=
 =?iso-8859-1?Q?KnSD8d6hjxNE+Y2fAol5VjDrI66VDNIqztxqXJ7e+Tv7jhg+LoXSQFAjRF?=
 =?iso-8859-1?Q?LJNgr9j11dKdcJ44h4oetFTeD+UO3WGXAgfVhd8ci6oMMbKX6c3rdsdYkf?=
 =?iso-8859-1?Q?bQLkpEnBkumX6R3sYIU5sdSjLTJjNEM4gW5H9WkgdNbUMwgahLCD749eZQ?=
 =?iso-8859-1?Q?NjMt1TRnP5btkBvlJTITD0A7Uwy+NtkLR7WQ0WlMPYIEQu0r2oz4Miyy7P?=
 =?iso-8859-1?Q?kbn0KH7piZ7T9yBAePS40g4/Rfz3ar53+zGyKMi9tNmF9OkkZCiNSDLpbM?=
 =?iso-8859-1?Q?V6HqWEvrnnlqFlATtq6jSDXNAZ/y2BkkjG48mS/TvlpRXfxG8sq3b0Ik0u?=
 =?iso-8859-1?Q?Iwppvgn/pN8hXxLrauXYBC8IFltPugQMNY/lFrk6XYLJWxuM/w0eTCUaXF?=
 =?iso-8859-1?Q?iw1S4xgOQ3BGPFRHihJUpfF56hicAvAj9HHak2mWkHNn+LxwpJap7QL8jg?=
 =?iso-8859-1?Q?MKVOFih990PeGOw4scDe49s3jRjmWxnf1XrUDH01F3hm+JJq23cO97n+QB?=
 =?iso-8859-1?Q?WopHsw+TXpbZxkjNnTJqmhMxPuV7YQ9+0MwrW1c63EMk3apLVxebM9KsxB?=
 =?iso-8859-1?Q?ToFTs8yivuDhOHbltl9rrI/Czi6aVV9fbmPElrs9E4Ey+nUNF12Hxg9KJF?=
 =?iso-8859-1?Q?9woB4bMEm3DWsSZvUzhx0gfeEvRtIefhtjBfY9liDDe0aDnaKoqGpnj7Sf?=
 =?iso-8859-1?Q?RCLuBcX2uq8GsT498DC51wdBZXxt4iXGunZCQDcLO6ejn2QCP1MeCWtf3Z?=
 =?iso-8859-1?Q?uNt0WyUZCk5yH4a50KAUa5hAOS2/VtnZ83MA216cBjBSLfyAF3fo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7a2849-29dc-4717-ec29-08deee702d82
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 19:24:30.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlaHXWFcKrVCY9ciFGxmQ/EIh1lQ5d0uHIRDRodjsqx1OxkW4XrYQdIuGLW/urNVPe4zD43Ol+MhtLswWD449FsUSczRayrwsKFwKq9Upc2HYASjbVkxr0gTOr9HNfUk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9317

On Thu, Jul 30, 2026 at 03:23:10PM +0100, Nuno Sá via B4 Relay wrote:
> [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Nuno Sá <nuno.sa@analog.com>
>
> Advertise the supported bus widths through dma_set_src_bus_widths()
> and dma_set_dst_bus_widths() instead of assigning the legacy u32 masks
> directly. This keeps the driver using the new bitmap representation
> while preserving legacy fields during the transition.
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 39 +++++++++++++++-----------
>  1 file changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index bcefaff03b5c..69cac7e3625f 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -33,20 +33,6 @@
>  #include "../dmaengine.h"
>  #include "../virt-dma.h"
>
> -/*
> - * The set of bus widths supported by the DMA controller. DW AXI DMAC supports
> - * master data bus width up to 512 bits (for both AXI master interfaces), but
> - * it depends on IP block configuration.
> - */
> -#define AXI_DMA_BUSWIDTHS                \
> -       (DMA_SLAVE_BUSWIDTH_1_BYTE      | \
> -       DMA_SLAVE_BUSWIDTH_2_BYTES      | \
> -       DMA_SLAVE_BUSWIDTH_4_BYTES      | \
> -       DMA_SLAVE_BUSWIDTH_8_BYTES      | \
> -       DMA_SLAVE_BUSWIDTH_16_BYTES     | \
> -       DMA_SLAVE_BUSWIDTH_32_BYTES     | \
> -       DMA_SLAVE_BUSWIDTH_64_BYTES)
> -
>  #define AXI_DMA_FLAG_HAS_APB_REGS      BIT(0)
>  #define AXI_DMA_FLAG_HAS_RESETS                BIT(1)
>  #define AXI_DMA_FLAG_USE_CFG2          BIT(2)
> @@ -1482,6 +1468,20 @@ static int dw_probe(struct platform_device *pdev)
>         unsigned int flags;
>         u32 i;
>         int ret;
> +       /*
> +        * The set of bus widths supported by the DMA controller. DW AXI DMAC
> +        * supports master data bus width up to 512 bits (for both AXI master
> +        * interfaces), but it depends on IP block configuration.
> +        */
> +       enum dma_slave_buswidth axi_dma_buswidths[] = {
> +               DMA_SLAVE_BUSWIDTH_1_BYTE,
> +               DMA_SLAVE_BUSWIDTH_2_BYTES,
> +               DMA_SLAVE_BUSWIDTH_4_BYTES,
> +               DMA_SLAVE_BUSWIDTH_8_BYTES,
> +               DMA_SLAVE_BUSWIDTH_16_BYTES,
> +               DMA_SLAVE_BUSWIDTH_32_BYTES,
> +               DMA_SLAVE_BUSWIDTH_64_BYTES,
> +       };
>
>         chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
>         if (!chip)
> @@ -1565,8 +1565,15 @@ static int dw_probe(struct platform_device *pdev)
>
>         /* DMA capabilities */
>         dw->dma.max_burst = hdata->axi_rw_burst_len;
> -       dw->dma.src_addr_widths = AXI_DMA_BUSWIDTHS;
> -       dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
> +       ret = dma_set_src_bus_widths(&dw->dma, axi_dma_buswidths,
> +                                    ARRAY_SIZE(axi_dma_buswidths));
> +       if (ret)
> +               return ret;
> +
> +       ret = dma_set_dst_bus_widths(&dw->dma, axi_dma_buswidths,
> +                                    ARRAY_SIZE(axi_dma_buswidths));
> +       if (ret)
> +               return ret;
>         dw->dma.directions = BIT(DMA_MEM_TO_MEM);
>         dw->dma.directions |= BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
>         dw->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>
> --
> 2.55.0
>
>
