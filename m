Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067C044CF4A;
	Fri, 28 Aug 2026 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787920828; cv=fail; b=qmqOtCv9TK5LzERsPjiOz3QzpkJSUFAhQEN3D4f6TZyzVQTBDfPrTZrzKZsSkjso+XcDYt9sVu5SbPW7jtW6A65rhRe6cx5Za2gSB2Tq1O6MsTobkJmbJoQZLx+WhoDvWJWrZUJ5hzH1zYRIVpgr9Z86+VxKZ8lyEGz4J13Ffzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787920828; c=relaxed/simple;
	bh=WzCNX7c+iNTpbBXBJ0HDykZMHPkm+0DVmrgo+4u9Mpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l2eztl9o7VscRlC5vIcuWu03eH6PcXRVRDf88CzTEtUv792kYJHaKbydz9yO8S/pMbWqgMbZ0BE7o38VKPxM+Akkm2jrNLVnUGhald8zjXjJr+OiBU2wLjxPkCLw6eunGBq8AV5vFXv8roYyYl9IHgz2CaEtAzNkTYWGx+zMpvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MP7XZ9uL; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MP7XZ9uL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAYU/BE/r33NZ/tkFeRiMvz9ZEfiWk7LL+vmsKMIYE83SEMx/hCiT2Wf/A9GBQ91k4+a5YqNmYjSotSyOJlTu0i4AX/ENOrjrdlwKhbteAQRAx6BggtR46M6Ul0rBkt9l6O0fGKgX/gQuSA6CcO8RYNaDUyUZvxgqADqLvsMkK2URPzR/R8ocswysbAXzDbQoADwZGtOGdsi9XiemmRN0zeKIaorJMla0wUTrHLt+E9+PJWnwjw6ct/w56dXjYxyU6baL2ayi7s27H3nluEjRPITl9+8zZkzl6nUZqeo1kdSG/XLRdIcd+/3SjkwgnsU3m9ps9cbdpB/zgiSVc1jew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4Fxhss1JNO6PqQ5GDL5VDo+3QTXlZiRgvpe3nB6hcQ=;
 b=ChzHvw33FjdZeq3c1z6RYBxWy3yo7Os4wscGzEUzVPCvKGBSIeprjFPvHQgXh/6TbGzFsrIDWxZVD86nCKhcQiw/mlvKN0ffWcUaSACCVpfT5bQexMgotdrmnKUUQcK4lhKTMHHQFja9ws5xz8LwdsENduNZSDTrJE2GidCtn87qp2XDYyDZ46TMeXUpsVDVHQ+8iEtZ0jROmC/0yBO/0ar0xeDde35TNq+EFwNQom1QEuuNWui54PHrvm0t01UwpiQs2aUdQCUWRDRKGpMRP717aw9/RRxX07y1amFKFFXo4dzDt6xmOGq8iKJTOC4hW6dPAYG0eP2X6W05Bzp3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=analog.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4Fxhss1JNO6PqQ5GDL5VDo+3QTXlZiRgvpe3nB6hcQ=;
 b=MP7XZ9uLp42Lihru4RhE+3luBpzLkM4RpMlC9oSLCnASDEhZXX7BN7N+Zoh6zHSW18t1CHBUAmTYq0skL8xs6B3Whu59QG7kDHRd0/uPr5GT6PC3QNcqUWeBRhxNVOhNGIQ0AB1M5FrKJsnUqX8S9Ud/yvBMkvGnP7gQYOhcXXFHqYRRMskURwdifUYZdhzJUFGKJeIYetgE+HBy3jlWfgT38qMsiNinROgKolZmb5E0/bDD5aM8ead4CKNFXTfUpdSl5pWy6hJFn+8zKrkmjLBIUIyBg7RN9foocIyiS3kfOlyVTVs/bNwygSUdvLfZDWON6rAgu2Xltn0k6zrFdA==
Received: from DUZPR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::8) by GV1PR10MB9159.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:1d6::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 12:40:08 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::43) by DUZPR01CA0002.outlook.office365.com
 (2603:10a6:10:3c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 12:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 28 Aug 2026 12:40:07 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 28 Aug
 2026 14:46:02 +0200
Received: from [10.48.87.20] (10.48.87.20) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 28 Aug
 2026 14:40:06 +0200
Message-ID: <286d173b-4fd4-475c-bc49-eb0c9047ca2f@foss.st.com>
Date: Fri, 28 Aug 2026 14:40:05 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] dmaengine: stm32-dma3: Use bus width capability
 helpers
To: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	<dmaengine@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Frank Li
	<Frank.Li@nxp.com>, "moderated list:ARM/STM32 ARCHITECTURE"
	<linux-stm32@st-md-mailman.stormreply.com>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
 <20260810-dmaengine-support-wider-dma-masks-v2-5-1f7b798d035f@analog.com>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20260810-dmaengine-support-wider-dma-masks-v2-5-1f7b798d035f@analog.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|GV1PR10MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c8d909-fb48-4a82-e5ab-08df05017de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|7416014|376014|10067099003|6133799003|22082099003|18002099003|11063799006|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	zcLLKFOQX2ZN7cOddsMMz/dTZhXuVzpOXVyyR0zHqvVBTjA4GKdBNaYTaYV+xRpJrYYzmJSqd7uVvuLKi2rXw516sf0Z7rUiiHf4YhrerkMectsIc0pej8T/NLyq+ZUukrcccNOO8tBPUkYbfdp7cYxAMbOb/gokcBOkAKVATxDYF/tWqtk6/wCp+XNYpy1CrfkeUkvLZiRKn4ZQ0/uIMVenymRX1Ji9WpxmTDfy1OQ0WEAIKIlcK5fyH3JSUBNMTltWpDwbMpkjnIyK7OVWzWcEpVh676itVzc6IhdQNaqx2ZM+BL7a/l4O6MzG7p7mYw8+eAAajmMfgkrdrTnCaFDo60AYRYyCQkuQofR754u0UQcCQAtlWTBNlIUHlrbkIUXKekyfBUfZQztcFULCjpM3DEXGjVmkG1YcEq0+eCswqVM3sUEmxIHpbR3SvTcy0aJ0itS4lwj6HyY2NJ+ScxfNxRaI1SzHwr6OCD93h98tc8VKD8OII6xm0jAiHo/sEzKLaa3u7HtRBpcchGmw2A/0L2eMsD1sFPyf8rCYE8VKjjpLbY/tl2lxiNSx9/zlADI/8fFkRNeHUTfkyhn8MxzIosDrfUe+PsFWtzOQkntidSgp9nsUICeLbyiUg1Tb8BtbJbqolQ6UGkm46CtKJG7h9DvCwkahhe8Jt9hkV9ONO8mkQaI30Su3Ev6UgQWElcaYLnTMIq6zo8Yl+Wy6YA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(7416014)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lHfCEB4ER9RaS+4TJ+kd2POrxgPlRMOKCmfURBYrxcHSN8Nx2zWb1K170US1dPRkNICbfy+Yos0eze5m+hwh16q9ydYElyQpDbHvFbNgZWnQBaTCszAi9gn2Z5Tq2M7v93cxdFsJATa9aQnK/vxs5JyTs5WhxQkMQdsKqfy39FmDiSICmCeBzeXRDjPIoV33HZAIXRcIb2QWfC5bYXCdI5zAVwP3IlKKoSnIlB6iOfeeT3mKYoKuZ1ROFDefKT42nOcfSjXmUmYcM2lD1LnugvH56+6EKbCvETsLs73hLqYMYTwwj8Rv1UsaCmlhlpB36YulyU9HX7zklMXcVbRvJqkdJRNhbc6aw59cJLv5jShiEyPr+p3FU4FdgDItc/6OxsbR5W5PtnaEzrHGgZ3TcwXMT1BE5j5QGlIE6tBIRn+UlOX4p1NBOAug9/2/OWe0
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 12:40:07.4026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c8d909-fb48-4a82-e5ab-08df05017de4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9159

Hi Nuno,

Thanks for the update to the stm32-dma3 driver. It's good to see that it 
helps demonstrate the dma_slave_caps_clear_xxx API.

For future patches touching STM32-related drivers, please CC the 
linux-stm32 mailing list, as this one went unnoticed on our side.

On 8/10/26 17:06, Nuno Sá wrote:
> Advertise the controller-wide bus width capabilities through the new
> dma_set_src_bus_widths() and dma_set_dst_bus_widths() helpers.
> 
> Also update the per-channel capability callback to clear unsupported
> widths through the dma_slave_caps helpers so the bitmap and
> transitional legacy fields stay in sync.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>   drivers/dma/stm32/stm32-dma3.c | 32 ++++++++++++++++++++------------
>   1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
> index 4724e7fa0008..f0781fb1b66f 100644
> --- a/drivers/dma/stm32/stm32-dma3.c
> +++ b/drivers/dma/stm32/stm32-dma3.c
> @@ -1469,14 +1469,14 @@ static void stm32_dma3_caps(struct dma_chan *c, struct dma_slave_caps *caps)
>   
>   	if (!chan->fifo_size) {
>   		caps->max_burst = 0;
> -		caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> -		caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> +		dma_slave_caps_clear_src_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
> +		dma_slave_caps_clear_dst_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
>   	} else {
>   		/* Burst transfer should not exceed half of the fifo size */
>   		caps->max_burst = chan->max_burst;
>   		if (caps->max_burst < DMA_SLAVE_BUSWIDTH_8_BYTES) {
> -			caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> -			caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> +			dma_slave_caps_clear_src_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
> +			dma_slave_caps_clear_dst_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
>   		}
>   	}
>   }
> @@ -1737,6 +1737,12 @@ static int stm32_dma3_probe(struct platform_device *pdev)
>   	u32 master_ports, chan_reserved, i, verr;
>   	u64 hwcfgr;
>   	int ret;
> +	enum dma_slave_buswidth stm32_dma3_buswidths[] = {
> +		DMA_SLAVE_BUSWIDTH_1_BYTE,
> +		DMA_SLAVE_BUSWIDTH_2_BYTES,
> +		DMA_SLAVE_BUSWIDTH_4_BYTES,
> +		DMA_SLAVE_BUSWIDTH_8_BYTES,
> +	};
>   

I'm not fond of having this large block after the "shortest" declaration 
(reversed christmas tree order), and since it is not a global variable, 
I think you can remove the `stm32_dma3` prefix.

By removing the `stm32_dma3` prefix, you could place it after the struct 
declarations, below struct dma_device *dma_dev;

>   	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
>   	if (!ddata)
> @@ -1775,14 +1781,16 @@ static int stm32_dma3_probe(struct platform_device *pdev)
>   	 * channel, and can only access address at even boundaries, multiple of the buswidth.
>   	 */
>   	dma_dev->copy_align = DMAENGINE_ALIGN_8_BYTES;
> -	dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> -				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> -				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> -				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> -	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> -				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> -				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> -				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> +	ret = dma_set_src_bus_widths(dma_dev, stm32_dma3_buswidths,
> +				     ARRAY_SIZE(stm32_dma3_buswidths));

By using `buswidths` instead of `stm32_dma3_buswidths`, this can fit on 
a single line.

> +	if (ret)
> +		goto err_clk_disable;
> +
> +	ret = dma_set_dst_bus_widths(dma_dev, stm32_dma3_buswidths,
> +				     ARRAY_SIZE(stm32_dma3_buswidths));

Ditto

> +	if (ret)
> +		goto err_clk_disable;
> +
>   	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) | BIT(DMA_MEM_TO_MEM);
>   
>   	dma_dev->descriptor_reuse = true;
> 

Regards,
Amelie
