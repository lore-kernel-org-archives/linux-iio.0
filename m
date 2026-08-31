Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013031.outbound.protection.outlook.com [52.101.72.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446C652ED46;
	Mon, 31 Aug 2026 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184897; cv=fail; b=XdMF2iOodEyVy3dAaJsqC+NaRQJwv8+1PU0QHjSKsymTacIBpxN8mM3jKJC8HPwjUXmR8ZjNkoT+1lDagSydMUiZ2wOv84yib4/Q8itNFe833JplTIb6JDccPnel/A9HHWq+O5yZH18hY6KRmllRMCpFBF7wH1D5QghGS1y0/MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184897; c=relaxed/simple;
	bh=8pey+3pSmgTA0ZLiJO0GucuKnLOyGboFVHSgeGfUzLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JZGPb798reuA/uZYBzC6MJGQDXrAKH+5iF/1uSmAU7yfy8F3NbeXtmprv0GWMwGcMRAi//fPcDb/gupzDXpjmGaLxgvaIk5oZRIPMCk9tgSADwuXI34EwHi2WKQEtmnW72TT7wUa3eyEHLDGwzlEu9sjWKEt5Vh8wojndqJH11g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=bZHvh3Rw; arc=fail smtp.client-ip=52.101.72.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="bZHvh3Rw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTxXdwfaix5jI4RAv4vWsQ1K5me2W4vt7TbdJqyetfJWyo6UounxgZWtZ09M487RQ19kspib0sn81cbFwqTboPQ5KVNOcSUkVJApGnAphk7rmLZJ+x/hXXbbJG9jKClGgewvgLLyd27nLpIiHZDjsY4iZ1iSWoesASJuRB5GxDAmoHt2CL5wC824+rEnpi7GuKP0nPtlf7S4eVpQ68Q7RIJLXn2K+tzdNtJ3wc/Ws46ehdnovdOiOxxOXlANc9vpyDAzunL5Sl6KRRLPPb17q5p+VGqE3u2IVuwNHOg/XiE/hKUT8/n07EseDaTRGkpy4Iiuf558yigAsKTe6dThDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5j6cX9aQpWckUrkXpGzk+3puZNHRCaENq65S6Hd53k=;
 b=wpttS1v9Um4Btifbqg8LedJcwx7ENLtZxkNB+jFIL6ZKz/U88h66VBuCjd9pf4gAyGkifI3R2o2cMGP8S7kxgi0Vy/Cg2bd22Dc85jgXsQjQ+GGruFutA9PIPIiVYN4RyYhgu1gzh8pWmls9riJBtut4GGTOGUzWeOfJAUvhdh2JsA7HJgCoMJObbuLaZS+4j1UeT+zG5RtC7yzIQrFdJv6yFVP2MSA1k+w/P6KIGOCqp+VwzCOesKRMYpz+ibSQaC5g9zAa6QsAKdRXvCJhKNWkmGUcJtgU6/tvf3R0I1gIzN09mmj+cqj+Y9RLLPXWL/LixNGWWsHXAvyPSdLmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.87) smtp.rcpttodomain=analog.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5j6cX9aQpWckUrkXpGzk+3puZNHRCaENq65S6Hd53k=;
 b=bZHvh3Rwx4uTs0sNaUlPfPRXrcBSxlN7XPziAiJKwRbatJHAK9JqKMka8GPwVF6krhdh9aHCwyF8BsDbWGsC6dvkYnJ+g+radCTbQogbxJzLWuWYicXvvWA72O873qSLwupDSklFUbcdrq1lkDLx2b+t2NvnxBH4/Iy5rENkYhsW/9QNbfLUVJoNiDSoq1olVDv0Z0jBFmTJP6mQ6ppRw2pr5fjieFekbwkNaQHO8RAloeWHEhBGylF6M4Pxj7et/k2Y0Ns6hQrha0Oa9tbAKxPSGn8s6UAN/WPjHcnVuIslE7NAo8jVVZaawrHP6c6q5Rjy3GE6vGExTU/+79sqNQ==
Received: from DB9PR02CA0013.eurprd02.prod.outlook.com (2603:10a6:10:1d9::18)
 by VI0PR10MB8762.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:234::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:01:27 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::73) by DB9PR02CA0013.outlook.office365.com
 (2603:10a6:10:1d9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 14:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.87)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.87; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.87) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 31 Aug 2026 14:01:26 +0000
Received: from ENXDAG1NODE4.st.com (10.75.129.197) by smtpo365.st.com
 (10.250.44.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 31 Aug
 2026 16:03:24 +0200
Received: from [10.48.87.20] (10.48.87.20) by ENXDAG1NODE4.st.com
 (10.75.129.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 31 Aug
 2026 16:01:24 +0200
Message-ID: <eb9fa2ed-e59d-4ad4-9218-f7473ceb9f9b@foss.st.com>
Date: Mon, 31 Aug 2026 16:01:24 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] dmaengine: stm32-dma3: Use bus width capability
 helpers
To: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
	"Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mark Brown
	<broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
 <20260831-dmaengine-support-wider-dma-masks-v3-5-507d97496f2d@analog.com>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20260831-dmaengine-support-wider-dma-masks-v3-5-507d97496f2d@analog.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To ENXDAG1NODE4.st.com
 (10.75.129.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EB:EE_|VI0PR10MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: eb58c925-3e9f-4bab-47dd-08df07685954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|7416014|376014|10067099003|6133799003|22082099003|56012099006|4143699003|5023799004|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	pIJ/rHjc4eUp3uziMcdO0FED3+SEBVMVBHuANIHEff2xvTSpOhXC6jUVqbkwVVn+8chEixyYuPywRZZv75AcVXXbKRFfBwc3uRgQPJThxtEA+xMQ3jh0demRQlTriEXszYJUlWEijyY/6MrKUEYYWbh5YYdBbuG/fP3C7+XevjM4VeZymNwDd6q/TPgKbAJs1uQcMT90dHmlkp0EAfyqDbyU17JoHtcndyP1aFlhkh2NUD8XRXiTqplvsWB0mkXnOT5UaBHI59tqeJ7gpvHTRhzMAVc7cF6xifczOQbMlYFGrPWdtH94yfsuCGPZkAT/ezp3ThsZJ32y6EIfpyJ5FIDKbb8jK9aA0PBpOxdRZOTL1swdDdjEqfFBNvnnxtLOVCW3dAde4Q/ovi3zi4RQ4m866qbuFDdKT1PDf/rV5j3a8PnzEhVwj5K2tMPnO/6E9kjbrRscKlN9zdoWYt7ipKbbqzKY9gUcwdFD6p3lRPZBx7uVF9CsCIo+uv86yNKYtxr1LA5m0rbrSKdZ90eiaO/oxKtL+1mdkN+jIz9C9q9z+FzvXK1Z/Sp2afUQlHQAqMo6o7SgS9tJeY9h2rSCmE+W5BDdJR8ByOiO1QFMnfOMYEB8C19jt3ecZ017tP8NlIoerrFqLTK7WrdF/mQRbXabLN//LPKql3KIXXkmVXJE1tjzrorIZCYLc+59n9KzL0g5OZebBUNAXw7qRKlVeg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.87;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(22082099003)(56012099006)(4143699003)(5023799004)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lQ5J6/XuSl7bmwg0CHTWGaAPqk1Ep5MrJV83Qsav5vUkYbJtdaNgX8BxntTyF56qX66/6CT5vY1IZtHQ7OPQTT0w05dndPXd6AfNlWHQNWcRjc2BDb0ruFPHJOREIhDlHK0dqPGbNGhuUrEU9fNfEcw0tlD5WCFINXLu77x8Zl2CY0rGciNMilxv3tO4z0FOVvl1EkuLhnfB0hxflEhyvX1AhsoehU7r3bTyzWITfNlFVn6GCQenJD+2HKodzShO2nbJstIxHJcdgCeLr3O3so6aCrzinDxJk9MrDuUBp14ssuKfDwEXGLEXtCg8oJRL2TgwrlqMoR8n0lI4eGAVYNJBwB/8AlIXXxxrEPeZA4U6gfErrH2nruqsAglOaM0mIZ9aXFs05XuRRQKyaJigu59N6swGhJNCXX+vLyVx6PSg1AYWWyzUy2TojL+nQv0a
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:01:26.5344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb58c925-3e9f-4bab-47dd-08df07685954
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.87];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8762

Hi,

Thanks for the updates!

On 8/31/26 13:46, Nuno Sá wrote:
> Advertise the controller-wide bus width capabilities through the new
> dma_bus_width_set_many() helper and clear the per-channel unsupported
> widths through dma_bus_width_clear().
> 
> While at it, validate the requested transfer bus widths against the new
> capability mask instead of the legacy u32 one. Besides not depending on
> the legacy field anymore, this also stops BIT() from being fed a bus
> width coming from the device tree without any bound check.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>   drivers/dma/stm32/stm32-dma3.c | 34 +++++++++++++++++++++-------------
>   1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
> index 4724e7fa0008..0689aeb7cff5 100644
> --- a/drivers/dma/stm32/stm32-dma3.c
> +++ b/drivers/dma/stm32/stm32-dma3.c
> @@ -9,6 +9,7 @@
>   #include <linux/bitfield.h>
>   #include <linux/clk.h>
>   #include <linux/dma-mapping.h>
> +#include <linux/dma/engine/widthmask.h>
>   #include <linux/dmaengine.h>
>   #include <linux/dmapool.h>
>   #include <linux/init.h>
> @@ -588,7 +589,8 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
>   	dbl_max = chan->dma_config.dst_maxburst ? : 1;
>   
>   	/* Following conditions would raise User Setting Error interrupt */
> -	if (!(dma_device.src_addr_widths & BIT(sdw)) || !(dma_device.dst_addr_widths & BIT(ddw))) {
> +	if (!dma_bus_width_test(dma_device.src_bus_widths, sdw) ||
> +	    !dma_bus_width_test(dma_device.dst_bus_widths, ddw)) {

Just to come back to one point you mentioned in your cover letter, "this 
stops BIT() from being fed an unvalidated device tree bus width". Here, 
sdw and ddw are set either by dma_config.[src|dst]_addr_width, or forced 
to DMA_SLAVE_BUSWIDTH_4_BYTES or DMA_SLAVE_BUSWIDTH_8_BYTES depending on 
the channel capabilities. So, unless I'm missing something, they do not 
come from an "unvalidated *device tree* bus width".

Anyway, it's great to see another use of the new API.


>   		dev_err(chan2dev(chan), "Bus width (src=%u, dst=%u) not supported\n", sdw, ddw);
>   		return -EINVAL;
>   	}
> @@ -1469,14 +1471,14 @@ static void stm32_dma3_caps(struct dma_chan *c, struct dma_slave_caps *caps)
>   
>   	if (!chan->fifo_size) {
>   		caps->max_burst = 0;
> -		caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> -		caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> +		dma_bus_width_clear(caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
> +		dma_bus_width_clear(caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
>   	} else {
>   		/* Burst transfer should not exceed half of the fifo size */
>   		caps->max_burst = chan->max_burst;
>   		if (caps->max_burst < DMA_SLAVE_BUSWIDTH_8_BYTES) {
> -			caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> -			caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> +			dma_bus_width_clear(caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
> +			dma_bus_width_clear(caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
>   		}
>   	}
>   }
> @@ -1734,6 +1736,12 @@ static int stm32_dma3_probe(struct platform_device *pdev)
>   	struct reset_control *reset;
>   	struct stm32_dma3_chan *chan;
>   	struct dma_device *dma_dev;
> +	enum dma_slave_buswidth buswidths[] = {
> +		DMA_SLAVE_BUSWIDTH_1_BYTE,
> +		DMA_SLAVE_BUSWIDTH_2_BYTES,
> +		DMA_SLAVE_BUSWIDTH_4_BYTES,
> +		DMA_SLAVE_BUSWIDTH_8_BYTES,
> +	};
>   	u32 master_ports, chan_reserved, i, verr;
>   	u64 hwcfgr;
>   	int ret;
> @@ -1775,14 +1783,14 @@ static int stm32_dma3_probe(struct platform_device *pdev)
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
> +	ret = dma_bus_width_set_many(dma_dev->src_bus_widths, buswidths, ARRAY_SIZE(buswidths));
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	ret = dma_bus_width_set_many(dma_dev->dst_bus_widths, buswidths, ARRAY_SIZE(buswidths));
> +	if (ret)
> +		goto err_clk_disable;
> +
>   	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) | BIT(DMA_MEM_TO_MEM);
>   
>   	dma_dev->descriptor_reuse = true;
> 

It looks nicer this way. Thanks!

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

Regards,
Amelie
