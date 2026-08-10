Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4C42C4FF;
	Mon, 10 Aug 2026 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381035; cv=fail; b=RRztHvteUeCrDJnE+JvFa0h0aFrY+xbd9+Pzp8ijfT2ewNIsbCxrfBQsTb3LPJrb7Auk0/qOGb0s2W1GEhMI7moNC1NeYxXxnhWOAOKwhGnQZErNJNuI9GTGmXB4mLSOCJGr0+naXr/Q2T1DclXUu9KZojBCn6r2ebPI6t4tW0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381035; c=relaxed/simple;
	bh=Ai9ylBXQnfTvNP8Vb5bfkyAcJXXfCkG9Q9+2t8lEurc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BXExSvJNcUhXP6eHSU8ijoZZz1hBAtXK6cP476kMNb4p7G9Om59t6/Bnfak91NO/2SVGsaKv4JitvqY7Ib1u/z9pZ3p2eF2bODngR3ztJBOYpYlzQMuY07/adTAtY5XLaWHZ8fV9ciSjKGnVnbbcOVUasQn/6HpWwU7FlMEUYeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Fj2eK1KC reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Fj2eK1KC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sj22qgseRckWBzpLl1QqvuNpCPOzCaaAou34qQ/tjZtWVOGvS5HQXrXeM5DQGv8/rJhYej7hZ+khqO1rth4af2t02ffpcorrFdOt9qNjoiewIBQeex5YiyoxBEfZR7WsI4fcob5jeQw2f2H1anyii5QRoOEPhWDOJ2we+dOk8UFPbvdVmPQaNaTVflt66Z6nwHdUjtRAnUAS6EyExUUqg+eZ3TIKkL+R0ogLjqqoalWsQzheOOCM+D9j7ic2RysoYBfpEaD7bYYyhYRthN2n555Ij/FHaD54ULo4Jk/q5CZJAJyzAySYB5vL0KPYMAuPJYKtgn/Z2esh1g9TKdrxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZSvomQRrCEbVQcXVx4n1GE3TRWv1gonGhkfRUuewf8=;
 b=MMRcGrp0+Ro0H4/+okMOCnBmc4C/64XfAGphcbd2wRwd7t/uF6IGXsEo0DKNUYNDdcJ5QL1dIlAoCM/i0yUwXR7JswiLk3ZFBC5jlInqcqUkmgx81g7xiukI4yAqps3REmWsvz27mpIihjjF52/1dxUgJoVBm4eM37L+M9mlTY4/pxWspCHUTwRw8pa1DHilyMcFk5qvYAwvVyuPwypds97ipbcZEdlp5/RBynIQCbWgpmZFpfTPjvQ42hBuISdOnOGwCtCkH5lBftVuliuJXoDFKVCz8zBE4ysyeQ4aM2wtHoYQEyfMtwZjB4jjI37tHY3C1zfuxrMY73x6n2zZbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZSvomQRrCEbVQcXVx4n1GE3TRWv1gonGhkfRUuewf8=;
 b=Fj2eK1KCqR62hpHEwxmxUd2+BW6r6gKQ+sTx4anWlJocwdKhmI9wsCIlUCivP1ge7Q2IMBhDAlv4cPyE1YhLf5pWIS0pkdJHrLSY30an2lXgoB07KB4rKhnkMVSKb4DpXFUx9tJVgOHb7FK7ZiqUqcA/qAIT+4qYwAefa8qiim+yXxaOD51B/5/WqG5lATR263yFuHj018wVH7yn0HS49kxcEbqSha/2KlQV+aRmHamwHGeY1tyx4SMfTUYw4wxHL78WkjoiUFjbQNamc1OFeiqpEmO1zhmn+XNKdKX4is6IXw2G+5yyiGWZkVtxwm7W8rR15BLi++7tLQSeF9D5jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB9016.eurprd04.prod.outlook.com (2603:10a6:20b:40a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:57:06 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:57:06 +0000
Date: Mon, 10 Aug 2026 11:56:58 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 9/9] dmaengine: Drop legacy bus width fields from
 dma_slave_caps
Message-ID: <anoC2nCE2wjYBKYL@SMW015318>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
 <20260810-dmaengine-support-wider-dma-masks-v2-9-1f7b798d035f@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810-dmaengine-support-wider-dma-masks-v2-9-1f7b798d035f@analog.com>
X-ClientProxiedBy: SA0PR11CA0007.namprd11.prod.outlook.com
 (2603:10b6:806:d3::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: c84dc7da-ba87-4b74-9cfd-08def7006871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|19092799006|6133799003|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9OEQWdrUYqF9uArihdoLR6+KZVuqxkXifrIVHpuX0gR0Tw88nMwTHpLILLPgV3J/DtE4iLhuk4kMFGSo7qnjBWuw7YMs8j/3naLusPOvVBxsbH/lvVtKhMn8M4urdz245OnrzxVB+fJgSS0XhKF3LLu/D6zZLrFWJnul8NQlW0fOpUn5WqNDOdQWsesHSpV9tvLcTPzpfktMJpIzNAk/06cc9CTKzGxLfTaKiO7S+9hbYOn/JCtfusOlu3fmRd61tDq9nzmCyuaQYuJd9DH8JXJsI4cTW5K/zvXaUnsqa7emtIyb74fdQWz45o9EGOyENqMHkaZ1etKlw2nau5vjm2wwALsDeWQ1N/8kMgib2DEeBQSTMbiy9x5l0ghtG16Bh5sDN/+lTaC2TVzherR67tzrXNI7qIqMh0CUlog/8hXZR1KTbaCF4Kocvc+GoMWGqf7DffYRdUD6FUHCJ72mAfAH1xtZvY+x07zDMkQRelp2XtTNNhovQ2sClSkUjovMtAHrVOWjrNfa+6miM0snRtQiBuYzft4iGi5VJUb7D3epvdm3OBErEDau79oCkM4ms2+VJKq+vfibjDxNb0kPMTl7J7uKT6/IVD3qvznhmP369azID4URDgCoqgUkyjc9GApBZLgI4wJSQWIajheZRLqoLgZJ9lX4klC5CVzla8I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(19092799006)(6133799003)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?kUyjCknH4r8P8gyiXbe0R4Zu78uw7cGdGyzz4hjmWbeBI75NIkuYgt9KRD?=
 =?iso-8859-1?Q?KDs6NItxuiVD84/c9etpdP7U8IvS6SpQFEFtM0PsTxdL8Sv1/BkinvMIb4?=
 =?iso-8859-1?Q?HqY6nBWf2wLHDZy4b3hh3dXbeT5FoIZetERFQX5P2mQ0Jwlk9bkIpgo89H?=
 =?iso-8859-1?Q?k3lkzj8XGO3W1paHiiYyD5OOgh5xUCmW6A3+NQ0avXUPx9XXMPcDfxyvP0?=
 =?iso-8859-1?Q?ciY12hdbz0bmGDj9RLnJ6tKjq2Akycl1s2lTGxKAMLlorISGYcqqKZk7bI?=
 =?iso-8859-1?Q?j3pYycJrFX1UwoDbxarMH2/SjjPrm65xvyZsJQCId3POOXrLgtDZVL8VC7?=
 =?iso-8859-1?Q?pgWrXS7DQQiginVtXGydlayU9ENNT31iqHw5aURZqNTzNbL+SoD+jbhXZd?=
 =?iso-8859-1?Q?uR4BjzKIQxKsP+jShyv4+pbJqC3I9j4nwCK3C04dpr+EHK3b7IfC/7PNai?=
 =?iso-8859-1?Q?q+6LU11+UQICVdx+97Ch4Jp9opDjAxHNHCnY4u4+V42IdznDvWCc791LoQ?=
 =?iso-8859-1?Q?ruEM2W/RcA7ugebka/2ZX9cr5kYDLiWzkXjgm/PEs1JKCNGEwjENYzfVYz?=
 =?iso-8859-1?Q?UzJReVTXHmff1CodF0qAt4XnZayGxe623uKnqWa7uNDCTHd65nM4WW2vi3?=
 =?iso-8859-1?Q?WtZBxHL5HoY+buRX1PU7Co2WkiBTfxxPu1v7Btl2BqYOPRkSxVL4cgHZnj?=
 =?iso-8859-1?Q?j5AN0xF7bOlCTmKRnno5PZ2PbgTGCOxb1KbCH9oUBMkQ+E0M89PFkYJwJz?=
 =?iso-8859-1?Q?shoGfND3AFQ5XCvXLZstw3Yeuv6K/zfVa4vEOWNnyHwgr+Q0nkTpWiQXyK?=
 =?iso-8859-1?Q?h+IP7QA+8ouMxlcCQzFkcyARwNfLqLXYENOkri5JaRPIV8KoLLBX04ju9U?=
 =?iso-8859-1?Q?FrvIMZCt3ssR719MzAujtrD/h8ext+HnWvnO5TNHJfzyTQFaqKXzeXo2Vh?=
 =?iso-8859-1?Q?LuS84TfdzdLVaJXzgtY9k4ln61xLhUwcaAI9eoVBMT+nnB6ZoBVRwwqQe8?=
 =?iso-8859-1?Q?Z8TBI5T6HmVzImEpiKWtdqiymGeJ06qpnf6WFkW646r3xvbRTPAO1iaLtI?=
 =?iso-8859-1?Q?mwWBBwIqS96CSV1tYzdfx33TcIBVmg2oVhLlPryvv+Z5iB8WoIbtss1hpw?=
 =?iso-8859-1?Q?8BAre7k707QKD3tnS5dEt63r/BBxDBgRseqlizD91AP8riBi9cQxl8JJUz?=
 =?iso-8859-1?Q?u/+46E+F6wF8BdoL6QjY/94hvqBJSwLOdkJZvZA2C5Rd8w16e2ZK0jA8di?=
 =?iso-8859-1?Q?EljqbUMz18qVePPf5Hg5a1dMuazMXssjabbz7pimQpNrzfEBLFEbdTkiv7?=
 =?iso-8859-1?Q?ECTnA+p1Mu0aOonIJSDzAx9Bs0kZT0ETwngkW1DLMWxmn8A5W9BN+ildw8?=
 =?iso-8859-1?Q?JZMOX41xOy1HO/8X98AfONrtJYSAzlxC9xgYgq0GxopTLKZ6gPhyS4v4Ro?=
 =?iso-8859-1?Q?BxqJaiKCllv1oTOfL+4JgFabMbKlk9KNNenMpMxhrpJopZ/eMjdqeJK+ul?=
 =?iso-8859-1?Q?oZa+Di0ksfLUuVckkHyA8vORUs1PIrI3t+1pbf+oha+Xcb2BrfUXy103lj?=
 =?iso-8859-1?Q?fj+a5Rn+h2iJYXv6E45fsIlsWNVRnBEj22Jw+dMNlanMIVvXuAc0So0EFB?=
 =?iso-8859-1?Q?ZudvmRRj3YmMYRLQjKV0BaXgRpWOF5HUIKIRrFlEFMOCCZdML9zSTjkEeO?=
 =?iso-8859-1?Q?l7ziu5pgAuDEKcZNqCOy6kZrGL1WtvAbomSBDFHcBMdn3O8HHme3xkFpUF?=
 =?iso-8859-1?Q?EbrM+MLl3wT+ZRVBQT72fE1Y4uwqZNOv//ZgaeyXWBj/G5XjMPU7awPTbR?=
 =?iso-8859-1?Q?n4jJSX/Tmloy33Kz0U1dcfGUBCDi0N6hc+4LzomlbHO+V5cXDnFJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84dc7da-ba87-4b74-9cfd-08def7006871
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:57:06.0480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkyMeOdnFrMQVVHVRMo/jnQr2FO17sAn8SLAfAGXXcFhSvu/UKrSSqbwRkXmO0WI9sFGj/h+V+xWVz2C67fNTmhktRssiwgYtx7IHkHYAlf6cAZOWjr3wyNC8Yx7+0rc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9016

On Mon, Aug 10, 2026 at 04:06:50PM +0100, Nuno Sá wrote:
> All users of dma_get_slave_caps() that inspect bus width capabilities now
> use the bitmap helpers.
>
> Hence, remove the legacy u32 src_addr_widths and dst_addr_widths fields
> from struct dma_slave_caps and stop copying the dma_device masks into
> them.
>
> Note the legacy u32 src_addr_widths and dst_addr_widths fields in struct
> dma_device are kept for now as every DMA controller driver setting them
> still has to be converted to the new helpers. dma_get_slave_caps() keeps
> folding those masks into the bitmaps it returns so unconverted producers
> continue to work during the transition.
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dmaengine.c   |  2 --
>  include/linux/dmaengine.h | 16 ++--------------
>  2 files changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index a80a84cf87eb..36e9b6ddd88d 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -592,7 +592,6 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>  	if (!device->directions)
>  		return -ENXIO;
>
> -	caps->src_addr_widths = device->src_addr_widths;
>  	if (bitmap_empty(device->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX)) {
>  		bitmap_zero(caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
>  		bitmap_from_arr32(caps->src_bus_widths,
> @@ -602,7 +601,6 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>  			    DMA_SLAVE_BUSWIDTH_MAX);
>  	}
>
> -	caps->dst_addr_widths = device->dst_addr_widths;
>  	if (bitmap_empty(device->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX)) {
>  		bitmap_zero(caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
>  		bitmap_from_arr32(caps->dst_bus_widths,
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 8697583e2ed3..4efaa27e9f7e 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -503,9 +503,7 @@ enum dma_residue_granularity {
>   * @src_bus_widths: bitmap of source bus widths the channel supports.
>   *	Width is specified in bytes, e.g. for a channel supporting
>   *	a width of 4 the bitmap should have bit 4 set.
> - * @src_addr_widths: legacy bit mask of source bus widths the channel supports.
>   * @dst_bus_widths: bitmap of destination bus widths the channel supports.
> - * @dst_addr_widths: legacy bit mask of destination bus widths the channel supports.
>   * @directions: bit mask of slave directions the channel supports.
>   *	Since the enum dma_transfer_direction is not defined as bit flag for
>   *	each type, the dma controller should set BIT(<TYPE>) and same
> @@ -524,14 +522,8 @@ enum dma_residue_granularity {
>   * resubmitted multiple times
>   */
>  struct dma_slave_caps {
> -	struct {
> -		DECLARE_DMA_BUS_WIDTHS(src_bus_widths);
> -		u32 src_addr_widths;
> -	};
> -	struct {
> -		DECLARE_DMA_BUS_WIDTHS(dst_bus_widths);
> -		u32 dst_addr_widths;
> -	};
> +	DECLARE_DMA_BUS_WIDTHS(src_bus_widths);
> +	DECLARE_DMA_BUS_WIDTHS(dst_bus_widths);
>  	u32 directions;
>  	u32 min_burst;
>  	u32 max_burst;
> @@ -1922,8 +1914,6 @@ dma_slave_caps_clear_src_width(struct dma_slave_caps *caps,
>  			       enum dma_slave_buswidth width)
>  {
>  	__clear_bit(width, caps->src_bus_widths);
> -	if (width < DMA_SLAVE_BUSWIDTH_32_BYTES)
> -		caps->src_addr_widths &= ~BIT(width);
>  }
>
>  /**
> @@ -1936,8 +1926,6 @@ dma_slave_caps_clear_dst_width(struct dma_slave_caps *caps,
>  			       enum dma_slave_buswidth width)
>  {
>  	__clear_bit(width, caps->dst_bus_widths);
> -	if (width < DMA_SLAVE_BUSWIDTH_32_BYTES)
> -		caps->dst_addr_widths &= ~BIT(width);
>  }
>
>  static inline int __dma_set_bus_widths(unsigned long *bus_widths,
>
> --
> 2.55.0
>
