Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD395448B99;
	Thu, 30 Jul 2026 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440114; cv=fail; b=Zegawx0yKggfZGEJpJZhhJRe6OjvRfizlUMOWwoONe3Gh2DQp8hQpsHg5O56wcT7xGFHdy/hOK43TgLO+6tCq536RBFQzfdRpmC85xUDsyzL+YxhGmP3yTDAe2Iv4zqxd/V10ATRegNKu2n4G2nVCkRbwaSKFhtvO0MoaImOdso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440114; c=relaxed/simple;
	bh=dPs/wG9L8emwfsRz6aS+FRFtt1TK8T4zd5hOfl6O3nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LGweSovDEY7dYDx9V6dHGyY/8DVftFZtEvjJfw56Tr5yEGuBZoUx29azqKRyf1S73fFgDQiX7wgiJ//5X6/fV8ih+Fzjk8MZsQtvOwjTUm54zLs/7HgpPHwsamTTOYaQ0F36LwUziAdgUsvphKX45lckmobsRPSP38GULGS9it4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XeyhVUZ5 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XeyhVUZ5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sehNhIrpbvQGNIgSRfXL8UVUkVvuxlIO+illldmAzKyMdw7LePfuyU9mR8QzBge5F1l0ceHVmQ3xqYiukTFpLp//AzczTaNJf/FRUX4zpKZcRbQdhZhgsrPDUq5lftjeGIMBLG80VpHRkFWLd3/GxUru6LE/UqrdhvOt5M6x9p8jvkG940PtX2UJpKYCISG6SsVbROtt420WlDNresvgtZy8fR86pHXHNTw/CYv7b9pmh2VNxHj42HuWnObEJ1EP2oBcui4IjfvDPacjELpnIJt8AjwA1Ty2SoKxhfZM+nuSJzlP1jA+C7PQ2Oq6RISiUSC9v8YC+IsCKFRpxVdA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JQfFbBcE1kdJPuy5SK24HdGM6Bpj3PDj83+i8yKPSA=;
 b=CeduCIjyQ0J1myrPsRb7T3RKt40A1R6HYP6XnNjGOZEIbN2cqF9eZ6z3N96MseT7wApyEooOez8Kxd1sjDFaLMxCZgAk/6oIjwnjKfJi3DbHQEYuOqa1i9nC+XTwuS+NYjGtmlfX7QU4WyMzaFLZjYGxC1ocQ9aYjvNotc0wF/mwGnGzEyu/LQa9n4x78sSXFt+yMQeURkYXIb2gxNzxxBThdipA0LrhBhInkzPoCTcNu8fUXVrhbj93Cy0qT1bQ6zM46J2Df6xLby3u+lq6q31uZfSDi1xoH7iVJKZYXwRShlwqygc6ozk1HupNRRMZm24JUgsYl3Awww+31IBNaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JQfFbBcE1kdJPuy5SK24HdGM6Bpj3PDj83+i8yKPSA=;
 b=XeyhVUZ5IsFKhDB14eXh+FYuMMNazKkZySUYEgGkvRRiLP3qN9WmkqmHk9vH34zx0U9LDU7UK77ndlJ3UH1/miyGI4Xge+nIRbfKzMQAJto5cupKNqQlvKJ/xTA2Ll2uFLgDWmuBtXsfOGg1RCabD1K/6HwUIpMr6e0p5U7rMIAJKmoEjdifPpziVijm5xEMgdIxkOycp1d8cgB6uWPKyOGl2Ul6zf8DzN+CIIcRYvYYyWPHwUqgag8fOhsE5Mo+sbO56stawjEpPEFKpd4sO74IyNenw2rDE4mOtASW4wYTjGDM0Ja4cLnASZI3MhqpXl7mfcMHJLysGThvM1jlcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB11847.eurprd04.prod.outlook.com (2603:10a6:10:622::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 19:34:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 19:34:58 +0000
Date: Thu, 30 Jul 2026 14:34:51 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: nuno.sa@analog.com
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 9/9] dmaengine: Drop legacy bus width fields from
 dma_slave_caps
Message-ID: <amunW2XsMCC3GmeK@SMW015318>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
 <20260730-dmaengine-support-wider-dma-masks-v1-9-3732f1f9d9ca@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730-dmaengine-support-wider-dma-masks-v1-9-3732f1f9d9ca@analog.com>
X-ClientProxiedBy: SA9PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:21::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB11847:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6d5c72-b49e-4bf0-b282-08deee71a3df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|23010399003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	bXyQHBpJBidyPi/k8HYSaX98bZyf3qOIDlzV7TN4RNn1+/Y+l1VVRzr4dHXfSXwvyQnZVWA/I4k4Fn9jYwXqkrHhI6SDb+TArQfe0SGsoGl/NvCXfDOOp2YSTFynYTZZrh4DO52Iq7LnnfuRRaRHV4ioONWWlJeDRzYjUb/U0aGFtNJwEY9Nm1WY3KDcTtzPd7AfM0xHW/PWxXmNezKZuREh/7IQafF+5Sf+AA2Qt7rZgsLBhe4EstLvY3aeWQ8lFJOWGWx6eDezzwAhwF29Aol9FPeFW47i3aTopd5o/KDQ4OQc+ubUH3JQw6CUtN3YlL21PQWZm5eaM0eXRNYRhp1ZVYPvPl1K8fl5Tqm1Ly6VyAbpmTCIfK3c5HeRwZXIuTX/lKlKWJf37ifQV8sMTuB6iJwPrYR42LuKxtJeIqcqjh0AyJwSfykbMYCGosfIKGSCpy6tTxTQHbdZGN8I15Kmo0mgPyWa7vbdNkQYnPX6hdi+XoBFP5yCDTCwEh2pBOZWsn99fYoz3xLw83pASBLxWX1zz6cCulqnqViD+uq6DlRf3u4kjOLsjlNtOhFYFW00Rjuj+j2wUpDUDJ2b+wm+2GcOGJijGUZXDouIeuFic8LliYpg+fS0v2Q6zjQInh1CyeFe8oZrm8N4OTzt+soC8x1SxNJrwutg+evjc+U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?snXkQY8imiXaYBiLAldGD7HUwyWSyVVLR6rMVPoGIU358Yq5VpokZ5Qyir?=
 =?iso-8859-1?Q?RpzuYq4onavj3gLDsUzxWczFVwcoWlVjJeOBtau+OXEELShwEPdjoNsNl6?=
 =?iso-8859-1?Q?aVC6J8AvzSSGpsHQFOT6PugxnoHBVGdvVYakPeIdTnJwxnF4UY/NE2y7LC?=
 =?iso-8859-1?Q?rX1yS0CQ/ezHMqiX7sRp1oQK+KOJvnuqY3N3cMJn/jrf4XDbSA6cIaIUZy?=
 =?iso-8859-1?Q?Gp4MefOLwAAj9OOX+44uSqaYnNbQOrzvyV/ACIqkHPwGmnBT6o2cBSXfwl?=
 =?iso-8859-1?Q?FL0WCkRrVL/RUR4StS7IpjS/dA/tJbyZbFip6Ccd8ycCRcnwEW7vmHGemE?=
 =?iso-8859-1?Q?B7kWbUrKMDoZt0yG5cVbBA0s8S/FQJWYqQmBQz3mySXncQaQA24jQMh2ax?=
 =?iso-8859-1?Q?NLZ1dBqwB/YIh51OxenL6h3YHZuCMTmeQ0qdymzTSTpEyvVjfgOnOmZE0h?=
 =?iso-8859-1?Q?bpv9XoG5NPE/A6ToWHT12NICfGeBcng4ZQwljJHc1F9l7VwS9EP3ZKM8P4?=
 =?iso-8859-1?Q?VQsLOgnb/2AbFHhvW+/1kc6wXlyAIPypJcAgNSfGlDTJJvraI2nu9VPLI0?=
 =?iso-8859-1?Q?OdfiINIo6kJ0CI6NBruyn6C8mPRBVUtjqKOw5QV46xin6F6Gukaei9J0qk?=
 =?iso-8859-1?Q?khJApSE/HU4iuUAz/TjH+MnWxzn9YoJ8aKu3+yef68cYECHK2eu87PXSPF?=
 =?iso-8859-1?Q?ZzH4/tle6EIqdrdOCnt+3UH5KYWiLfpZloACGF+SOKJO51+LXx+AUudSz3?=
 =?iso-8859-1?Q?QCADPE+jKN1lXY/O2pvuoT0SfGQmKJtOYl6cV+7UjaVV3tfbjgXMAWreJ7?=
 =?iso-8859-1?Q?GFNGcFjPOYxzkEjo9mtMfu0lBvhAYa1R0HDlU3tsw288rB1BYbKAkTtgiX?=
 =?iso-8859-1?Q?mMFsRdcQPqrdDu/xejAFHHWiEiA4JiZGkzDcv32kFsgI8EdYyIZc2tbknh?=
 =?iso-8859-1?Q?b5pNLFgv/q8Wv/YfBvS54baXwuVyCw8/m5ASp/NxGrlkoOpgGsK4MxpQzz?=
 =?iso-8859-1?Q?lrgRbU7X7GZEGymqPDMz4E/D3yZKzjOyQE+qjb1x+5lxaWV7AXB8PyuoT2?=
 =?iso-8859-1?Q?NueN2L7EvW7XIP+Egav4Ddr5P1Qg49gzyzv2xhR/SbSI5fNVX0/YYmVuRO?=
 =?iso-8859-1?Q?eFsENwffp/YG8WBofEXeEeHlHNjQ4QGvEIc+dfJB7MYFzW+Fvexyj+Hp3H?=
 =?iso-8859-1?Q?/3OG/1Blgss/6Rn1uAEzmvK0F1uSoVyT0LS4Fs5hQbMRG90ZiHxfTBpPjC?=
 =?iso-8859-1?Q?SkaBC7kRUwtWWn+c5YGKVgh0vBqZOCk0XyyK1+uAAlGLUxSoTJNYKMhDYj?=
 =?iso-8859-1?Q?674jznJGMguAbROpli3JbQv/26QU2bSAYpYC/4oG3YIZgMXJADnDIS0d0U?=
 =?iso-8859-1?Q?Zhtvg6FG+AToZfF1E6e/QtdykfJWgdx2bs6y2lR454U5aU4ylyuCPL1YU8?=
 =?iso-8859-1?Q?h9I/yx0ePhAGZK/Gzg7kNmfYbzQvZUa6DaOhZinCWqOmr0PO7eKvSdY17y?=
 =?iso-8859-1?Q?8PmuNkdJjOdy4Kqg5nL4dXWIibzvcFw01zNXELRg8aBlHB8NAFJH33gtKx?=
 =?iso-8859-1?Q?zWKQsrv/rSms+0USODZ0FqVw56aTQC8QuWPQbNRtjRAoQiW6KMkd2fqXHZ?=
 =?iso-8859-1?Q?bfBOSdC+IjAhFya14g9e2MgOpiZXzewpDaGRbLqmNWjp7Y1dIb1JXJf9Qz?=
 =?iso-8859-1?Q?UaybnCm97E3GnX1iEIu0WPt4Emiia5aiZAnupiAuAFoLSgdb7jZ73LyFLV?=
 =?iso-8859-1?Q?iaetK4+gkS3noHO2ExjFyy3Lb6Xlgf9uKgRuxfS2psxIIUsGijwKZ8OVAL?=
 =?iso-8859-1?Q?tHtT30Ify9grBQZawzzfFXNLKodk2BDuY3/fjoDPz1p0zhnL5gUi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6d5c72-b49e-4bf0-b282-08deee71a3df
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 19:34:58.3971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Hf1XsY+QawjoPja3GWGxl0IELvzvfKjudRu/AOC8xCTw2d7E05cSGVqZ5hDMXgvS7zYLcV/DfLrWmNqBffUo1H/82ojXCFPf6xSUVC0Lqy0R06zlFqfOOI/1N9L9vBY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11847

On Thu, Jul 30, 2026 at 03:23:16PM +0100, Nuno Sá via B4 Relay wrote:
> [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Nuno Sá <nuno.sa@analog.com>
>
> All users of dma_get_slave_caps() that inspect bus width capabilities
> now use bitmap helpers.
>
> Remove the legacy fields from struct dma_slave_caps and stop copying the
> dma_device legacy masks into them.
>
> Keep folding legacy dma_device masks into the returned bitmaps so
> unconverted DMA controller producers continue to work during the
> transition.

which one you kept?

Frank

>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/dma/dmaengine.c   |  2 --
>  include/linux/dmaengine.h | 16 ++--------------
>  2 files changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 7be23ba769d0..ee0b8bfc7c97 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -592,7 +592,6 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>         if (!device->directions)
>                 return -ENXIO;
>
> -       caps->src_addr_widths = device->src_addr_widths;
>         if (bitmap_empty(device->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX)) {
>                 bitmap_zero(caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
>                 bitmap_from_arr32(caps->src_bus_widths,
> @@ -602,7 +601,6 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>                             DMA_SLAVE_BUSWIDTH_MAX);
>         }
>
> -       caps->dst_addr_widths = device->dst_addr_widths;
>         if (bitmap_empty(device->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX)) {
>                 bitmap_zero(caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
>                 bitmap_from_arr32(caps->dst_bus_widths,
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index cea57b166dcb..f37a0559ec5f 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -495,9 +495,7 @@ enum dma_residue_granularity {
>   * @src_bus_widths: bitmap of source bus widths the channel supports.
>   *     Width is specified in bytes, e.g. for a channel supporting
>   *     a width of 4 the bitmap should have bit 4 set.
> - * @src_addr_widths: legacy bit mask of source bus widths the channel supports.
>   * @dst_bus_widths: bitmap of destination bus widths the channel supports.
> - * @dst_addr_widths: legacy bit mask of destination bus widths the channel supports.
>   * @directions: bit mask of slave directions the channel supports.
>   *     Since the enum dma_transfer_direction is not defined as bit flag for
>   *     each type, the dma controller should set BIT(<TYPE>) and same
> @@ -516,14 +514,8 @@ enum dma_residue_granularity {
>   * resubmitted multiple times
>   */
>  struct dma_slave_caps {
> -       struct {
> -               DECLARE_DMA_BUS_WIDTHS(src_bus_widths);
> -               u32 src_addr_widths;
> -       };
> -       struct {
> -               DECLARE_DMA_BUS_WIDTHS(dst_bus_widths);
> -               u32 dst_addr_widths;
> -       };
> +       DECLARE_DMA_BUS_WIDTHS(src_bus_widths);
> +       DECLARE_DMA_BUS_WIDTHS(dst_bus_widths);
>         u32 directions;
>         u32 min_burst;
>         u32 max_burst;
> @@ -1789,8 +1781,6 @@ dma_slave_caps_clear_src_width(struct dma_slave_caps *caps,
>                                enum dma_slave_buswidth width)
>  {
>         __clear_bit(width, caps->src_bus_widths);
> -       if (width < DMA_SLAVE_BUSWIDTH_32_BYTES)
> -               caps->src_addr_widths &= ~BIT(width);
>  }
>
>  /**
> @@ -1803,8 +1793,6 @@ dma_slave_caps_clear_dst_width(struct dma_slave_caps *caps,
>                                enum dma_slave_buswidth width)
>  {
>         __clear_bit(width, caps->dst_bus_widths);
> -       if (width < DMA_SLAVE_BUSWIDTH_32_BYTES)
> -               caps->dst_addr_widths &= ~BIT(width);
>  }
>
>  static inline int __dma_set_bus_widths(unsigned long *bus_widths,
>
> --
> 2.55.0
>
>
