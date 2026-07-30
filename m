Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364F9463B8C;
	Thu, 30 Jul 2026 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439580; cv=fail; b=CWzu4opdykZTjzznfL81vd5QMahED5Z9+HwDlvCM4jQ3X67iZH6GC116Ul5KT58WX6UuAVEAfmvQ0MIYC3hTFrltmhd8sxFSFut5mRTXntzzM/xYgrNkWo3vo79n/54j+NX46xFQfMZANvjEdtzMrXh4Yr5T+LbGDlyUcIFqUg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439580; c=relaxed/simple;
	bh=z+QY7fIpyy8TmaOTTY/yujnIeXXwzN6ho5OODVjya54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lxhNEHYAmxxEughnNB34VWlKe/ksgihOcWBdX22Df33NuWpZleVauy+ARbGSBp36L0MqIzojsPkZioVeUeTscX1xWK+uVbaYNx/GSYkchpWQB0PQ0frnjZssUA20BHJ61RGBPNwo1giqgYtOdfEPxdRuIlFOfuTMpo7ND//iQ8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uE8OloG7 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uE8OloG7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHLcMjJWnyWMDBf4I9dQMBDOR8GKjsp0Eu/ezbYUrYKJar5Q/Qq3CdTJEMw8gXLAoWGtbQ5NNJTiwpeiXusSg/4jr2QrVl28O8vQidHGYDFN0cm0q2gR8WnGZkQUWb7WyfkbM/evsWZwFsRMuCCeVqKRJWLEdoa9kfxhAHWdKIPvAdOpUtyIVhQALDbmLOg7BrRfQKJ11Xsu9p/6pZAYdmTJGr2q5FIagkOf9ZhI3if+QFPSfo2FEAjbeBpyAF1N9RpzIQjyntE4/GR8/7d6Au19Qfx9qN/0NZn1gD8bW5JogV9bUPJww/3gAxgw7YiSQGlfPK0GiEZVxPKxUyj1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wM9s1da5jitvsDF1h8HXYpmarndyg9WKGzlGGmtx8Ac=;
 b=irXu4/ClPfdOCQ3ONNB38BBFQ6C27hbzygIBdGh2aLLWxc4Hr6lPBfA0lDPYnaO2F3X2QXQ1YT93EHj8iojkHM8w/7bkR+JPnGBbx4zNTlsZwLvJKHGInDKNPDxsPZA3mQLubd3zjHttQL84UXQwo1OKvudLOVwMsmfMBoxCKMLbx3FyI/tZ7RUNfgslBzSr0y7wEyKwftn5M6kPsumxtCYP8mpVnJ2WJNEg+lPaYafnbKrNUPvIXiD4fihv/5UluXMdFnMGwwTxby60V0bZHYXDIDykrLWBNFacclbr1LpHpToeSS28dVbmVGoQkOgRqLzdZkHbwlvrV86irqHs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wM9s1da5jitvsDF1h8HXYpmarndyg9WKGzlGGmtx8Ac=;
 b=uE8OloG7zDsT9Udb5bRk8B9ssDnZX+NpmUDU5WmbnANnUiVKmy1lVmLyCMpasmby84jdoA7xS7BjGo+22K7hiGfd4vuqeKVgXmoHQFSh9zb3tFbRULdiHzkgqCmeLV5WVbFgnryTemlKIFFePVHH058m1X6H17zUoWzcDwFxM4IvSsQ7JmvrwlvkreMjoS+YK3O4aP61tbgslOIBlXPd/9d4estr/ujPy4Sy8cYvjUV87ZCVVmU+ftiMF3ORUBmYUZjK5dNklxs0uG80T6G3cIJPe1U4B4YnOD3K6LiHIoSJW+yr7EWY6ZfUsTu9efHpZIdNgJNOMGdOVJjZQzbRTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB10955.eurprd04.prod.outlook.com (2603:10a6:800:27c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 19:26:10 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 19:26:10 +0000
Date: Thu, 30 Jul 2026 14:26:02 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: nuno.sa@analog.com
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 5/9] dmaengine: stm32-dma3: Use bus width capability
 helpers
Message-ID: <amulSmk87kV8hHzW@SMW015318>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
 <20260730-dmaengine-support-wider-dma-masks-v1-5-3732f1f9d9ca@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730-dmaengine-support-wider-dma-masks-v1-5-3732f1f9d9ca@analog.com>
X-ClientProxiedBy: PH7PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:510:174::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB10955:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7285c3-c0a8-44c4-2c23-08deee70692f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|23010399003|366016|1800799024|6133799003|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+Vk+PQZ1/gQqZnNwqZ7E5tNknrF4tgwVzXtBmrybKS26M0WXbgzlF2i2oy6K1CR271S1doX5FSDmF3seppazN+ATohoyBLpNtPzrEn/LQTfG03qdWq/zRDSm3I585vM1nr79NEDk/z93ot4Buq3Cl6FwIddiduiWBZQ3ZELsQbyigOHqssHrfOd64GfNxYATbBao/GRUh90rirSZaST9aPj/E4wZ6ohK8Mr3XzFCG/PrQAKzkO2HpobWHEENDeYL99JqHgRp6MtYtxLYpa84o6j57n8KzBlh2DM8X6l5Pr2gpjl0Ts5mif3RR8Kq68bCP/fG+jdG9L3VB20FYn7NOXI7Bx66G+U/iDKcL2EwX5eoGGlnr61zpd6At4GHCmL/tjX1gQ4unLDMq33wPCVLIDOryMqDwbwuORntDT88U014D3q6kv1I8CldX8GxmYR2X7VIJYTgIY8RbeYjdadQt69Opr9iAdI53iTPgjT5Yp//qdY/J6xDwd0DKsOlYKd43hc8G5bjOmS+czF1ePiQhwscrrabiI4y93Ci4ehaBIUnE1g7Gmin2WdBx5SbmkZPg4u1Co5HPKTGxm6TpzaF3af70vZ2MxDQuft3J+yMugA4PEwL4XziK7cl4nH8+wzedmLJ/BUfxjGqkdixXAaQMW/VsCTFaO4n3NW6v9L3Rss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?56lo9txBL6EvRMg0O97ZxGSJYxxwKI3mn59hkwewrJ0DRQp3l1vwGEMm8O?=
 =?iso-8859-1?Q?jFbsAy12lvB2DzPbsXxRoGYQYUM4Rs8aSNfrA2a2vygqPfS31aQCeneGaY?=
 =?iso-8859-1?Q?3a4w+vZHlR4s4yUTwuw9pECvir3BRlEGC8qnvLQ0oZJlpSBp0ze3+e3ORo?=
 =?iso-8859-1?Q?MKvtgoQDFQ0qUI55Iv03W/dYPkfVeJZEvX/V8Cl9zU6xxIK1YKI6X/BjK6?=
 =?iso-8859-1?Q?0fBy/uifZt9vWpAl5gGPfG2Z1j9r0lmzEUmpeibKXtNtHDnWB4zN31+4Bk?=
 =?iso-8859-1?Q?B7OrtzH/ij1IYpzPu2pcUP2x0wVHnuRVedwPi9rpPuQc7rAqE+t3LMhY6M?=
 =?iso-8859-1?Q?6mPlB7yLaIe5Fn4WFi1hlv7wNuVoKI6tm/lGBkbazGbYYCxgLTx3UDj8lt?=
 =?iso-8859-1?Q?nGH6agzfCH34RLUzqRvUP+CFOkeIlPAtLhfum4AmhSFN/lE5DPlcwNdE4C?=
 =?iso-8859-1?Q?8+skcQjM905cHDaBFO4UtjxUUqImo0/pcBqp6cQmpxuTfjY5ta0eqKEBSW?=
 =?iso-8859-1?Q?KoNgLFJeZXYV1O3kyHfOglODvQJ+7d6HlgZD4mDylJujJPiO4DZRD1wlCm?=
 =?iso-8859-1?Q?BQWhG0e4U/QzEwBfHSNH5HuTmysgTxNcgJnvDKGMVwMykKSU3LyhDmif2u?=
 =?iso-8859-1?Q?et//5ihgmwnEbXgNCVz94K7MdKELd+qCgaJxELcZf0PVCcNviXDR103Ttk?=
 =?iso-8859-1?Q?cSr0kz6tVWbIWWmYnDyAw2R9WnlFw9INh7nOKv3WKLFqG5v6CMCfH+Serh?=
 =?iso-8859-1?Q?A7TKy3TFDQ58dWdy8VPnke3mt8+sy22sTYcSxZsk9vFPD94gn6Qrh9ND+B?=
 =?iso-8859-1?Q?eEZxaCAb43hX8E59rLwGYGfsG/4p7iYtX+btSrjjUmZzWEm1q4hGbWjzqI?=
 =?iso-8859-1?Q?wYQbCNCwaA5sBGa1yT14o8ROW91HjrWXW56VDWr/jmgN3OurJjg6rUxxWZ?=
 =?iso-8859-1?Q?Tczrur8XPKL1bMUGznf5tr9eOKHnkByle4jouaEIu/xvzNf2nPSXFaIftK?=
 =?iso-8859-1?Q?eGCPtjPW6GMO0pmd8aNiZJM8UChZY5oswKeJmin4C9IEuCfbTEBZS7JxD/?=
 =?iso-8859-1?Q?Qbr/0pFLwmxcuZYkgQmvfp+EJh4b1fit9ke8CSuUi4qJv4GBkOUfQRqK0n?=
 =?iso-8859-1?Q?IyufsDSumJRYTwUdcckfmwJVz2tm8V6VJJuLJ0hNORcng5YC17pB5C1WI1?=
 =?iso-8859-1?Q?A0rLVNJfJrikgVwmJde92wtBFLvILOGKIRsqFm2rfmy0rJ5AcHU/SgPBKr?=
 =?iso-8859-1?Q?RNll393xECEfSD7zTIeO8QCm1ddsp1eYMtqnS0pDKZ5B9w8MR4HbA8wq64?=
 =?iso-8859-1?Q?ycMHSu9M3t80n3jZBzRxo2bIy7kOYHteVMp4fpItRQ50fvjPi2W72lPFS5?=
 =?iso-8859-1?Q?7CXgm2WIChoMNRuNPu8t6UZ+v+u183JpBJGS5fKLg2kn2qQswKwC8UoFAm?=
 =?iso-8859-1?Q?MDD/qdMGsxNK/H3mhzG6269v09Z91Hnbj0d/ctwAWoOep+o1OtCdlHss96?=
 =?iso-8859-1?Q?Mq4vN/okGv/jzN4pnjwZaJa6aoN/8lXQPocqZeQ6uUPyB+M+3gj14Yy/TZ?=
 =?iso-8859-1?Q?eIKaMzLr5bKWGpR3nytZhMTezBZS4ebQXRxv78yeLejFDV1ZJQOUW2H00v?=
 =?iso-8859-1?Q?E5Hhh9b6OQkIVl1hlIVSGZzBHClkS2bPs/GVZZv3Ix3YxTfkQamlmepbxB?=
 =?iso-8859-1?Q?CT9wxGMTT3ZJkxf+0HKcjB3eV1azd/sk9J/FkwChmsopqgGexHMAa35hky?=
 =?iso-8859-1?Q?P+5Wwy74lj4TYLpGcyT8Z7pjS00Db+pmKi1jSGbBEMQ2Xf4g+uI9tZix8o?=
 =?iso-8859-1?Q?8svXNtQPrKE6+tnH/oyuig5pPbLZkp2O2XuCb4hmhZqn4R858qCF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7285c3-c0a8-44c4-2c23-08deee70692f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 19:26:10.4693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20t2tDe3zZFT+roq7N3J3NNKJNR3B7aQUppcTQuzqoSClDDfLdTYf7txJstRkbJEJxEgtOX6Fx+ip7hQuHco575MQf963ofFIbI1xJz9DQ27cMkoZxYhxzOEusrWNp/k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10955

On Thu, Jul 30, 2026 at 03:23:12PM +0100, Nuno Sá via B4 Relay wrote:
> [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Nuno Sá <nuno.sa@analog.com>
>
> Advertise the controller-wide bus width capabilities through the new
> dma_set_src_bus_widths() and dma_set_dst_bus_widths() helpers.
>
> Also update the per-channel capability callback to clear unsupported
> widths through the dma_slave_caps helpers so the bitmap and
> transitional legacy fields stay in sync.
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/stm32/stm32-dma3.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
> index 4724e7fa0008..b0365a5b341d 100644
> --- a/drivers/dma/stm32/stm32-dma3.c
> +++ b/drivers/dma/stm32/stm32-dma3.c
> @@ -1469,14 +1469,14 @@ static void stm32_dma3_caps(struct dma_chan *c, struct dma_slave_caps *caps)
>
>         if (!chan->fifo_size) {
>                 caps->max_burst = 0;
> -               caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> -               caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> +               dma_slave_caps_clear_src_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
> +               dma_slave_caps_clear_dst_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
>         } else {
>                 /* Burst transfer should not exceed half of the fifo size */
>                 caps->max_burst = chan->max_burst;
>                 if (caps->max_burst < DMA_SLAVE_BUSWIDTH_8_BYTES) {
> -                       caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> -                       caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> +                       dma_slave_caps_clear_src_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
> +                       dma_slave_caps_clear_dst_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
>                 }
>         }
>  }
> @@ -1737,6 +1737,12 @@ static int stm32_dma3_probe(struct platform_device *pdev)
>         u32 master_ports, chan_reserved, i, verr;
>         u64 hwcfgr;
>         int ret;
> +       enum dma_slave_buswidth stm32_dma3_buswidths[] = {
> +               DMA_SLAVE_BUSWIDTH_1_BYTE,
> +               DMA_SLAVE_BUSWIDTH_2_BYTES,
> +               DMA_SLAVE_BUSWIDTH_4_BYTES,
> +               DMA_SLAVE_BUSWIDTH_8_BYTES,
> +       };
>
>         ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
>         if (!ddata)
> @@ -1775,14 +1781,16 @@ static int stm32_dma3_probe(struct platform_device *pdev)
>          * channel, and can only access address at even boundaries, multiple of the buswidth.
>          */
>         dma_dev->copy_align = DMAENGINE_ALIGN_8_BYTES;
> -       dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> -                                  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> -                                  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> -                                  BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> -       dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> -                                  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> -                                  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> -                                  BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> +       ret = dma_set_src_bus_widths(dma_dev, stm32_dma3_buswidths,
> +                                    ARRAY_SIZE(stm32_dma3_buswidths));
> +       if (ret)
> +               return ret;
> +
> +       ret = dma_set_dst_bus_widths(dma_dev, stm32_dma3_buswidths,
> +                                    ARRAY_SIZE(stm32_dma3_buswidths));
> +       if (ret)
> +               return ret;
> +
>         dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) | BIT(DMA_MEM_TO_MEM);
>
>         dma_dev->descriptor_reuse = true;
>
> --
> 2.55.0
>
>
