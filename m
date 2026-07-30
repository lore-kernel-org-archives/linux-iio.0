Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBE235E92F;
	Thu, 30 Jul 2026 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439006; cv=fail; b=QME2/tenlScxi7UtbGwEFS8DVPRSPPebar/gS+xoG+F0whIGYatz2YxkySfpZbfl8Khanogcl1mbfgroO610fShi40wthxFTJiHDzsUoUhQFlpTJ3iwWZEZqo0xMhTOxGVombsLNMz9z+xrasrevyYTGR+y8ycni0pdPVxKDfPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439006; c=relaxed/simple;
	bh=fgPOI+KNX2FBvW9CFG2vRF/pt5ot79AvOBE6xu+zcUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lE1hyNNEWrf28bRFkoXEDqwzMjq9VILvRC1c5Mp987LdoHiFTeqaPMN60N61dDuxjM9PnL+EN2lWsBhEVyL07TBKRQlOz4VK2B7cDfBZNI/r4XG73qApIiW4zVfoy4lPizb0BJJCRgeGmkhfhtPNhhIeQP25yLXid1SzcuRVkk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dvrneQ3b reason="signature verification failed"; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dvrneQ3b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0h/yAH/v6WrGw0QkitvIj8KvHf3Vx+Rx5hOjxaX9tMMGn6AFOFoJYl8OzINOkDGJ+Oz6V5DOvIgVODjuAWNGnm7+KXLEFR4GvdctgdgSvHWmb6QOgdyVYZyiC08wEzb+4pL6GEmb5rywr3GEicGtSKm8Ncbvg7DsfrMH903ClKHbvgb5Zk8RN+Z+J9PAvxdzcSAaGfZhNfADvHaA0UPbwyQaGzbgaC+b4tiHE3MwAElEFoyyD+SDDPfgut+8ixmzcv7WWRJmkDO9LXw0/4x5W21v6dlK+K3paci/U8dLgVhncQ3L8R1fFW+T7EkUJaXMJ8d56fhZOASwTCxBzpOrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=192YU7MduHXMHyhfv0IOM4RBQYAnbFz6tJRyUJ9HFUc=;
 b=mvdqV9P15/IySiXU2h+r6KzXiBqxx0mzi815wQXhExepLyqHvSne0VPU2Cy0saY74ww4r9a3x3Lsbka21HeekEmjHCdjzjxS9Bzury4YsP9MyI+XzN0PKbniytlloZaoD7+oWJcYXNIsZcEORa8eeSSJUr34RYtf7btYQq2ngFBTEmNSigxPF6IfPI2VPV62bUKBxmYXr0f8Un0Y4EY159IoQdnFA/wiLqRZAmEKBkPeLAN4/SDj238NhjKHAvr49d2iyhaBdJqcb99rmzU3pv1GctF2QnvAyVx8Ik2fmcrrUYi6eQjPifM/rFXRa2L/I11H9PYbs7SJayy9g6Ay5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=192YU7MduHXMHyhfv0IOM4RBQYAnbFz6tJRyUJ9HFUc=;
 b=dvrneQ3bXWaZcXHUnTAizUnh2I4YYVpMT4d7rduKFYQfd0gPVDA+UO82sWoKvvEsK+nTrOfvr5LbdlYUB4yZqJ3fPI9DGGRrWMrJbjsAwnLTX5f63MTMasR0vtLGC++1rFqqc7A07wIE3flxJyQqVFtLywVcxhYoxZQoQQDdUnSLiPnB7PGBD3/jPblZa8pL76sqUnYdFEG5c9+BXdlPvJG53Dsdo+CWZ4Ry6Sh01FyVJItVeXoIIWED6CtZ5AXYl2hv1B4y+PMG0JmUQa4nzdiohWAaoqeNzg15nylljOu4ns2Q1fq1R8eDlC/sgdOUN8T3GxOirw1tYVkaopLoWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB9317.eurprd04.prod.outlook.com (2603:10a6:102:2a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 19:16:38 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 19:16:38 +0000
Date: Thu, 30 Jul 2026 14:16:30 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: nuno.sa@analog.com
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 1/9] dmaengine: Support bus widths of 32 bytes and above
Message-ID: <amujDsVXJQ8gaCvw@SMW015318>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
 <20260730-dmaengine-support-wider-dma-masks-v1-1-3732f1f9d9ca@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730-dmaengine-support-wider-dma-masks-v1-1-3732f1f9d9ca@analog.com>
X-ClientProxiedBy: SN6PR2101CA0006.namprd21.prod.outlook.com
 (2603:10b6:805:106::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: fef9cec0-9d6b-40af-e664-08deee6f1411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|19092799006|366016|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KCVQgRPWShbR38A7/au1OAWYliM2UVZcbTQMTEVI4rMRgufPTfFYKooV86eFdTNsk2Pe0oRDmTzDWlMfqjq2MraX525qKh659lBkvsvMZajpLf7CfN2OuNisd4I3aZwtKOf9ZE7IFGYjt2lJiBrIRvZIpFzmcCwNPi7DQRjQ0WH0nugyFiRsvrMhAD0JVDGapaEchKxyQha8dVu1ZgMRuMZ6GBG1AEvu8LRQeB+AcAV+Qpl4l+cZ0/C2wg+TDWGdWRia7FiBJ80TM0syAZ/W5ZRbFJCobehzfeF30TfH5eyjio3iyifs3EeGHm4XeBsVZ+jVkYqsWVb7dwmA52q9ERMYHRx9vBFNjf0dt8PouDza2Ia0W18aDx6HVgAnjhflTdIuMgGTC8lQS+944OexyE/9n4cZ+dxOZDILPTmiWlbrMykY9xh9YL32CPa18utyoPw1c0kjalXowqCql79NcyR3NTK0h3WX1e84AYsdfrD5/looplZVGM98KcsG17avTGiNtKR4W8uWqP4xfIztWqAazkLJ9/WqzM0Xtu3A816JORmVHz2KwTbivql0p+KfsIB5yjFH4vmPOAID+rrKqZsFVecgGnwh8ApHPxzsLXpRk8NuanSPPVsGKvHu3JEaDSMg5ZLbmBEPPp1+axzflRlTh+G+FiunEYJzZTwo8P0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(19092799006)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?LvDw1qEryFHAeaywziK3Fw3zXGETFjd7JuFtH+iM9qsi4yXLgFhHCiEbMW?=
 =?iso-8859-1?Q?l4tHrRyVk/0JIuaPne0dIjfxnh+rPhA56OG4NDQdi3yWjAV0Z4MNM7b34l?=
 =?iso-8859-1?Q?uf8F+LLV+8qmQVrY0lmfYQjt5kV+Sm8lJQCcesqezhzys+BHvPh4TR0Pxp?=
 =?iso-8859-1?Q?f7SQM3u/vEmmIGNIKk4gyjjVOxLISiUlE7O+tRAqCCMUaTlydNyO/jdhYB?=
 =?iso-8859-1?Q?2k9eCtlWLEEmOTp+tQ6b/UgaBf8uqlLX76Rv4cNMTiF6GvctPbyb53dU4t?=
 =?iso-8859-1?Q?yV3MYZEFemYFit9BRjegdrzdl2bTKdqqpPipBkXHcyBrjrTJLZ2sqS2RDD?=
 =?iso-8859-1?Q?CfNg6xhbOHRIRpsj1qFfDlJm/+nrUKHaNHD14lXgCnCbKth4uDZ08bNabw?=
 =?iso-8859-1?Q?Rn1G3taV34QicbNI1+vtlhksFak46sPEvCQilES6zgOszWNwZxp8xA9RYW?=
 =?iso-8859-1?Q?G4qVI8lB5y8bNuZDC692z7m3YZJIdPrjnEJl9qnVmSQloblVK8WMcWQCu6?=
 =?iso-8859-1?Q?CN1wDXiNFrTyyI9gBl78ZXiiPCa5qUoCWJdeNuLLzXq5rDIjlrb66M/Tfs?=
 =?iso-8859-1?Q?0zKmKWrnvpT6IJCBJSicUuk/jVDmjxxsXH0TPr1isYwdidgFrcHfyxKz2s?=
 =?iso-8859-1?Q?l67xcmNGnjxwh3esskvjoqHADu9ZFW9X5YJ8vljhuxmJc85TJZJLvCYSjg?=
 =?iso-8859-1?Q?2NldxF5DfXY1ZcrhZ0h0kXUKlr2vRDb/bNjx+fGY0iL01Tvd5+RZH/deI0?=
 =?iso-8859-1?Q?yGjWBiLIFAU+SK33w51YWLXDk5/ieWT4rGPXqjk6yUf/J5LbxC62RokC58?=
 =?iso-8859-1?Q?SdKCHTcO2fJ45k+mJ0d+SCzzwSej8sUR0H2BuzWH6jd3ZPs8a7RJcFy6N7?=
 =?iso-8859-1?Q?OG/mp7AX5yoYe4+T7HuAvIa9cXOkPnUxRDiN/+woI2Nn1IVAsfB1Rgz7Zs?=
 =?iso-8859-1?Q?6ItHWNGCuN+pVM5/EcWDF17KZ07b1KODI6tHzAC/ssW2qI5ce7jMT28Q1P?=
 =?iso-8859-1?Q?T4ZPx3W3u0ABHfLvBkDK/Hc82nwlX3WaSDlOkkNjrhYv7DBfCfjvRbbs6p?=
 =?iso-8859-1?Q?HSDpmYcSUO78jIhSg+2zrEBe5UA4X1a5PRNxKZyXc74pvh9BQ7APhYsOME?=
 =?iso-8859-1?Q?FVslevLJBHDUlojucs/7AZD6E7+m31Gzax1UPXcI8PTGFuB/jkqTbMWG2B?=
 =?iso-8859-1?Q?FGj7fkskQ7lTcM5EZz7Tx4v050R5a/7NhpF8bXpggNqbc/jXTCJc/jGpLT?=
 =?iso-8859-1?Q?9Dl8VJrnaLrMAcUvTgi4RJau5XtJ3NOltcgiYAmymjPWHG3OlPlvoyP+JR?=
 =?iso-8859-1?Q?T10flSpngxFSZIOxVCZbV3MJ+kXtEhKO9Vrvs3nw7Hu1cEfW/V1av85Lhv?=
 =?iso-8859-1?Q?OKrTfcpPsN2CPOsqYPByiWLkMUnaJcUO1gXZYIsSVo7sEQXBorIJjye0s1?=
 =?iso-8859-1?Q?AuUq5P+HoKoJ57lCwcNm/KsIlj7ThhnKH2kejqq6dCwZf0RsNUCa8oIO/n?=
 =?iso-8859-1?Q?JZ324XvSmlDx8+65pgpCFVuIQc8Dithdaj1Lo+Osf3GIiwlchSm5BjgSuf?=
 =?iso-8859-1?Q?eafC784/5vYIt9vVLp/AdVB5Zd8+jHspRxhy7BgFfcbygjOMIN9PC3+8Qn?=
 =?iso-8859-1?Q?peur7+HS51rWEa+gNo47ZJvkuRetVRXOogLAmi4Q7tHMoiqPus9rJrjYqp?=
 =?iso-8859-1?Q?BZix9jsEGbOax2Ip5NBlnnKfECiH/g2BF6AMG+ypvZHPhgPRgr5lb+37gf?=
 =?iso-8859-1?Q?nn75f0eu8PLki4DUEJm5pPZ7hLG8yt2N+BhdKu7ALjUCUnTHASf5Z9qDfy?=
 =?iso-8859-1?Q?oa4v1mvfUjKxhhV/nGJQE+lQm932Sd5U3v4ij1zTJn22GFHo1IYQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef9cec0-9d6b-40af-e664-08deee6f1411
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 19:16:38.0849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbJVVeFCoUcEMOdhi0uoskoSc9p/ZdSxQhO6STRsHpAWvDg0Jgj+jrE2k+2Raprj94znScOcO7z8f3Bck22x143PnyVCx86yKzvx2yqNctFZlQES2JnsbUCEXV7BQYhB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9317

On Thu, Jul 30, 2026 at 03:23:08PM +0100, Nuno Sá via B4 Relay wrote:
> [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Nuno Sá <nuno.sa@analog.com>
>
> The src_addr_widths and dst_addr_widths capability masks encode each
> supported width as a bit whose position equals the corresponding
> enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
> 4). As these masks are plain u32, widths of 32 bytes and above
> (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> be represented at all.
>
> Introduce bitmap-based bus width capabilities that span the full enum
> range. To allow DMA controller producers to be converted incrementally,
> keep the legacy dma_device u32 fields alongside the new bitmaps:
> producers using the new helpers populate the bitmap and mirror the low
> 32 bits back into the legacy field, while dma_get_slave_caps() folds a
> legacy-only producer's u32 into the returned bitmap.
>
> Add helpers for producers and consumers so users do not need to depend
> on the bitmap layout directly. Once the remaining producers are
> converted, the legacy dma_device u32 fields can be dropped.
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dmaengine.c   |  18 ++++
>  include/linux/dmaengine.h | 246 ++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 254 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 9049171df857..7be23ba769d0 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -593,7 +593,25 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>                 return -ENXIO;
>
>         caps->src_addr_widths = device->src_addr_widths;
> +       if (bitmap_empty(device->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX)) {
> +               bitmap_zero(caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
> +               bitmap_from_arr32(caps->src_bus_widths,
> +                                 &device->src_addr_widths, 32);
> +       } else {
> +               bitmap_copy(caps->src_bus_widths, device->src_bus_widths,
> +                           DMA_SLAVE_BUSWIDTH_MAX);
> +       }
> +
>         caps->dst_addr_widths = device->dst_addr_widths;
> +       if (bitmap_empty(device->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX)) {
> +               bitmap_zero(caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
> +               bitmap_from_arr32(caps->dst_bus_widths,
> +                                 &device->dst_addr_widths, 32);
> +       } else {
> +               bitmap_copy(caps->dst_bus_widths, device->dst_bus_widths,
> +                           DMA_SLAVE_BUSWIDTH_MAX);
> +       }
> +
>         caps->directions = device->directions;
>         caps->min_burst = device->min_burst;
>         caps->max_burst = device->max_burst;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index b3d251c9734e..cea57b166dcb 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -5,6 +5,7 @@
>  #ifndef LINUX_DMAENGINE_H
>  #define LINUX_DMAENGINE_H
>
> +#include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/uio.h>
> @@ -391,8 +392,12 @@ enum dma_slave_buswidth {
>         DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
>         DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
>         DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
> +       DMA_SLAVE_BUSWIDTH_MAX
>  };
>
> +#define DECLARE_DMA_BUS_WIDTHS(name) \
> +       DECLARE_BITMAP(name, DMA_SLAVE_BUSWIDTH_MAX)
> +
>  /**
>   * struct dma_slave_config - dma slave channel runtime config
>   * @direction: whether the data shall go in or out on this slave
> @@ -487,10 +492,12 @@ enum dma_residue_granularity {
>
>  /**
>   * struct dma_slave_caps - expose capabilities of a slave channel only
> - * @src_addr_widths: bit mask of src addr widths the channel supports.
> + * @src_bus_widths: bitmap of source bus widths the channel supports.
>   *     Width is specified in bytes, e.g. for a channel supporting
> - *     a width of 4 the mask should have BIT(4) set.
> - * @dst_addr_widths: bit mask of dst addr widths the channel supports
> + *     a width of 4 the bitmap should have bit 4 set.
> + * @src_addr_widths: legacy bit mask of source bus widths the channel supports.
> + * @dst_bus_widths: bitmap of destination bus widths the channel supports.
> + * @dst_addr_widths: legacy bit mask of destination bus widths the channel supports.
>   * @directions: bit mask of slave directions the channel supports.
>   *     Since the enum dma_transfer_direction is not defined as bit flag for
>   *     each type, the dma controller should set BIT(<TYPE>) and same
> @@ -509,8 +516,14 @@ enum dma_residue_granularity {
>   * resubmitted multiple times
>   */
>  struct dma_slave_caps {
> -       u32 src_addr_widths;
> -       u32 dst_addr_widths;
> +       struct {
> +               DECLARE_DMA_BUS_WIDTHS(src_bus_widths);
> +               u32 src_addr_widths;
> +       };
> +       struct {
> +               DECLARE_DMA_BUS_WIDTHS(dst_bus_widths);
> +               u32 dst_addr_widths;
> +       };
>         u32 directions;
>         u32 min_burst;
>         u32 max_burst;
> @@ -803,10 +816,12 @@ struct dma_filter {
>   * @dev: struct device reference for dma mapping api
>   * @owner: owner module (automatically set based on the provided dev)
>   * @chan_ida: unique channel ID
> - * @src_addr_widths: bit mask of src addr widths the device supports
> + * @src_bus_widths: bitmap of source bus widths the device supports.
>   *     Width is specified in bytes, e.g. for a device supporting
> - *     a width of 4 the mask should have BIT(4) set.
> - * @dst_addr_widths: bit mask of dst addr widths the device supports
> + *     a width of 4 the bitmap should have bit 4 set.
> + * @src_addr_widths: legacy bit mask of source bus widths the device supports.
> + * @dst_bus_widths: bitmap of destination bus widths the device supports.
> + * @dst_addr_widths: legacy bit mask of destination bus widths the device supports.
>   * @directions: bit mask of slave directions the device supports.
>   *     Since the enum dma_transfer_direction is not defined as bit flag for
>   *     each type, the dma controller should set BIT(<TYPE>) and same
> @@ -887,8 +902,14 @@ struct dma_device {
>         struct module *owner;
>         struct ida chan_ida;
>
> -       u32 src_addr_widths;
> -       u32 dst_addr_widths;
> +       struct {
> +               DECLARE_DMA_BUS_WIDTHS(src_bus_widths);
> +               u32 src_addr_widths;
> +       };
> +       struct {
> +               DECLARE_DMA_BUS_WIDTHS(dst_bus_widths);
> +               u32 dst_addr_widths;
> +       };
>         u32 directions;
>         u32 min_burst;
>         u32 max_burst;
> @@ -1678,4 +1699,209 @@ static inline struct device *dmaengine_get_dma_device(struct dma_chan *chan)
>         return chan->device->dev;
>  }
>
> +static inline enum dma_slave_buswidth
> +__dma_slave_caps_get_width_min(const unsigned long *bus_widths)
> +{
> +       enum dma_slave_buswidth width = find_first_bit(bus_widths,
> +                                                      DMA_SLAVE_BUSWIDTH_MAX);
> +
> +       if (width == DMA_SLAVE_BUSWIDTH_MAX)
> +               return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> +
> +       return width;
> +}
> +
> +/**
> + * dma_slave_caps_get_src_width_min - get the minimum source bus width
> + * @caps: DMA slave capabilities
> + *
> + * Return: the minimum supported source bus width, or
> + * %DMA_SLAVE_BUSWIDTH_UNDEFINED if no source bus width is advertised.
> + */
> +static inline enum dma_slave_buswidth
> +dma_slave_caps_get_src_width_min(const struct dma_slave_caps *caps)
> +{
> +       return __dma_slave_caps_get_width_min(caps->src_bus_widths);
> +}
> +
> +/**
> + * dma_slave_caps_get_dst_width_min - get the minimum destination bus width
> + * @caps: DMA slave capabilities
> + *
> + * Return: the minimum supported destination bus width, or
> + * %DMA_SLAVE_BUSWIDTH_UNDEFINED if no destination bus width is advertised.
> + */
> +static inline enum dma_slave_buswidth
> +dma_slave_caps_get_dst_width_min(const struct dma_slave_caps *caps)
> +{
> +       return __dma_slave_caps_get_width_min(caps->dst_bus_widths);
> +}
> +
> +/**
> + * dma_slave_caps_copy_src_widths - copy source bus width capabilities
> + * @caps: DMA slave capabilities
> + * @bus_widths: destination bitmap declared with DECLARE_DMA_BUS_WIDTHS()
> + */
> +static inline void
> +dma_slave_caps_copy_src_widths(const struct dma_slave_caps *caps,
> +                              unsigned long *bus_widths)
> +{
> +       bitmap_copy(bus_widths, caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
> +}
> +
> +/**
> + * dma_slave_caps_copy_dst_widths - copy destination bus width capabilities
> + * @caps: DMA slave capabilities
> + * @bus_widths: destination bitmap declared with DECLARE_DMA_BUS_WIDTHS()
> + */
> +static inline void
> +dma_slave_caps_copy_dst_widths(const struct dma_slave_caps *caps,
> +                              unsigned long *bus_widths)
> +{
> +       bitmap_copy(bus_widths, caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
> +}
> +
> +/**
> + * dma_slave_caps_intersect_widths - intersect destination and source widths
> + * @dst_caps: DMA slave capabilities providing destination bus widths
> + * @src_caps: DMA slave capabilities providing source bus widths
> + * @bus_widths: destination bitmap declared with DECLARE_DMA_BUS_WIDTHS()
> + *
> + * Return: true if the resulting bitmap contains at least one common bus width,
> + * false otherwise.
> + */
> +static inline bool
> +dma_slave_caps_intersect_widths(const struct dma_slave_caps *dst_caps,
> +                               const struct dma_slave_caps *src_caps,
> +                               unsigned long *bus_widths)
> +{
> +       return bitmap_and(bus_widths, dst_caps->dst_bus_widths,
> +                         src_caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
> +}
> +
> +/**
> + * dma_slave_caps_clear_src_width - clear a source bus width capability
> + * @caps: DMA slave capabilities
> + * @width: source bus width to clear
> + */
> +static inline void
> +dma_slave_caps_clear_src_width(struct dma_slave_caps *caps,
> +                              enum dma_slave_buswidth width)
> +{
> +       __clear_bit(width, caps->src_bus_widths);
> +       if (width < DMA_SLAVE_BUSWIDTH_32_BYTES)
> +               caps->src_addr_widths &= ~BIT(width);
> +}
> +
> +/**
> + * dma_slave_caps_clear_dst_width - clear a destination bus width capability
> + * @caps: DMA slave capabilities
> + * @width: destination bus width to clear
> + */
> +static inline void
> +dma_slave_caps_clear_dst_width(struct dma_slave_caps *caps,
> +                              enum dma_slave_buswidth width)
> +{
> +       __clear_bit(width, caps->dst_bus_widths);
> +       if (width < DMA_SLAVE_BUSWIDTH_32_BYTES)
> +               caps->dst_addr_widths &= ~BIT(width);
> +}
> +
> +static inline int __dma_set_bus_widths(unsigned long *bus_widths,
> +                                      const enum dma_slave_buswidth *widths,
> +                                      unsigned int n_widths)
> +{
> +       for (unsigned int i = 0; i < n_widths; i++) {
> +               switch (widths[i]) {
> +               case DMA_SLAVE_BUSWIDTH_UNDEFINED:
> +               case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +               case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +               case DMA_SLAVE_BUSWIDTH_3_BYTES:
> +               case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +               case DMA_SLAVE_BUSWIDTH_8_BYTES:
> +               case DMA_SLAVE_BUSWIDTH_16_BYTES:
> +               case DMA_SLAVE_BUSWIDTH_32_BYTES:
> +               case DMA_SLAVE_BUSWIDTH_64_BYTES:
> +               case DMA_SLAVE_BUSWIDTH_128_BYTES:
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +
> +               __set_bit(widths[i], bus_widths);
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * dma_set_src_bus_widths - set supported source bus widths for a DMA device
> + * @device: DMA device
> + * @widths: array of supported source bus widths
> + * @n_widths: number of entries in @widths
> + *
> + * Return: 0 on success, -EINVAL if @widths contains an invalid bus width.
> + */
> +static inline int dma_set_src_bus_widths(struct dma_device *device,
> +                                        const enum dma_slave_buswidth *widths,
> +                                        unsigned int n_widths)
> +{
> +       int ret;
> +
> +       ret = __dma_set_bus_widths(device->src_bus_widths, widths, n_widths);
> +       if (ret)
> +               return ret;
> +
> +       device->src_addr_widths = bitmap_read(device->src_bus_widths, 0, 32);
> +       return 0;
> +}
> +
> +/**
> + * dma_set_dst_bus_widths - set supported destination bus widths for a DMA device
> + * @device: DMA device
> + * @widths: array of supported destination bus widths
> + * @n_widths: number of entries in @widths
> + *
> + * Return: 0 on success, -EINVAL if @widths contains an invalid bus width.
> + */
> +static inline int dma_set_dst_bus_widths(struct dma_device *device,
> +                                        const enum dma_slave_buswidth *widths,
> +                                        unsigned int n_widths)
> +{
> +       int ret;
> +
> +       ret = __dma_set_bus_widths(device->dst_bus_widths, widths, n_widths);
> +       if (ret)
> +               return ret;
> +
> +       device->dst_addr_widths = bitmap_read(device->dst_bus_widths, 0, 32);
> +       return 0;
> +}
> +
> +/**
> + * dma_set_src_bus_width - set a single supported source bus width
> + * @device: DMA device
> + * @width: supported source bus width
> + *
> + * Return: 0 on success, -EINVAL if @width is invalid.
> + */
> +static inline int dma_set_src_bus_width(struct dma_device *device,
> +                                       enum dma_slave_buswidth width)
> +{
> +       return dma_set_src_bus_widths(device, &width, 1);
> +}
> +
> +/**
> + * dma_set_dst_bus_width - set a single supported destination bus width
> + * @device: DMA device
> + * @width: supported destination bus width
> + *
> + * Return: 0 on success, -EINVAL if @width is invalid.
> + */
> +static inline int dma_set_dst_bus_width(struct dma_device *device,
> +                                       enum dma_slave_buswidth width)
> +{
> +       return dma_set_dst_bus_widths(device, &width, 1);
> +}
> +
>  #endif /* DMAENGINE_H */
>
> --
> 2.55.0
>
>
