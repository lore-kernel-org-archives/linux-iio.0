Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013038.outbound.protection.outlook.com [52.101.72.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B49391E44;
	Thu, 30 Jul 2026 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439517; cv=fail; b=Z7B+saELnCHB16tfiobt8NbxKHQB9JmG7yJXvQ6VNmId72pAX12zoBJbRiIkoxoB5cvAZKzen9WoWFYZhinMFqRvu/dAKBiaUupEuBB3d3FxKKMzPWFf3B8B94yCuZcN36i+Lk9Z+mM5lujNDAhtkJ6JuZ7NVcjkDiMWqLGp+8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439517; c=relaxed/simple;
	bh=haJ0vLTQ4Db4KSa0BsoV3zJ22l2u9Y/4SWeSx7Vpt2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IX1bc1Y5RVMlTwQ0L4FhDfgjBZqJn/svYB5Qb7QCgzq5x/rv2hcDhMjGBn5er6BgYMpRavSt7Q0siwOLOdWGJ2os4XrgiNJScbXEfLXjRCL8O49xDXi+GmJE7/csOotjGieD0nzyXZsUFv8++pC/+hN/jsIyPpTzuCxRPYigRrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WMiCn1Ud reason="signature verification failed"; arc=fail smtp.client-ip=52.101.72.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WMiCn1Ud"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xenIvaBJcE7eAhiedoxCw5Ic2Ve1P+hORmrCy4kn9YUNfR9Q+p1PPLclhL4qNUW2hHtqocHhWCt2w0iD6OUHrCZa+hUmzTvg8tc4aEU4ORkfpYWTfjBipRMlFx/2xG/wAX5R1+i3ZWCrdqg4eo6cyWNmug7btUGmR6FPbseCpJLHo+9FlNfKK00p8YI9mH4TH77sGo2Nkw2V/+3FoEwEe5mCnItA93FeMjdK1O89l5GZENwHctnLYHRi3Q4hb+xKVwiYIHN5ED0pbNHnD2bFsi5m21hxhBvnz9647BQne0LcoMiE6+5/V1V+7kYwI00I0Y3SQazzkE3NsDvtja3whQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAsaA/OwMRmkf5lOSjIifaXw68qVWiSNgr29Gu5W674=;
 b=tNOY7vMarkK0sI7xwTLhtn6DzfzckSlgPLr/I2Hzw1QoMi9YIe086B/rrPdLJJcKeo86kVEC9MFTkaUcZorbX0aM61LzMV3nuL4eji+QpV9JiSz1mIJain9Yql2VHHUYp5263qk78zg39Qi2jWw+kYuET1Fhemtp50xraW8fLaQ7qZ/VLj9tcVe/2oVTK6Jl2GLkXAsr+iiI+igTYvPEF2TwhcqkVRF/i/pexwWErH65jrVDlhQp+b2ztveF8hoBNqh/SYq1H/1IJEmr0ovjqpqOYY0rPkpw5PWxIDqjccCPOSiz8hg+D/+EgfkHVf+BPeElr2m03H+Th54XholApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAsaA/OwMRmkf5lOSjIifaXw68qVWiSNgr29Gu5W674=;
 b=WMiCn1UdL1ygxMG9Y1BPT4IYeVULq1zHTYu5W4dkWu/EetaoDH3WbeqicHb44tWNieOvv6Bn+7NRQc+CjnE13mI9jj25tSCchUZGbsaFZdON4Y1jgTw80i1UvyQjhIsx7lsO6aWP7OcUGeBZ9oZ75hj9iEN8waKqKlPReoYal8kaLVComUcdDnfhQJbUZ1coaKi8/3LkC4/1mvgO50E6VtB9bWoJ47FJIPkhBrcvpW7zblSwZCURcizlHjIXyKEUqH4xNIu6izCBqrf1qVCsQzg6nbBFlPM9D9xGhybdDqbP8o/DPa4Wo0yAOGDxepqPlyV9am0GxaHo5ENRDgRceQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB9317.eurprd04.prod.outlook.com (2603:10a6:102:2a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 19:25:12 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 19:25:12 +0000
Date: Thu, 30 Jul 2026 14:25:05 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: nuno.sa@analog.com
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 4/9] dmaengine: qcom: gpi: Use bus width capability
 helpers
Message-ID: <amulES1UetwSfWJ_@SMW015318>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
 <20260730-dmaengine-support-wider-dma-masks-v1-4-3732f1f9d9ca@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730-dmaengine-support-wider-dma-masks-v1-4-3732f1f9d9ca@analog.com>
X-ClientProxiedBy: SA1P222CA0148.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: df5b920e-11dd-4198-fff6-08deee7046bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|376014|22082099003|18002099003|56012099006|11063799006|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	r0PKVvRD8fFnq59VuacLxdHg/KzqTQL9HzPBdIzcy1hELikdKwLzjnkGEKv0pGVy2rv9Q0lHx6sd9W88XndC/wWWCUeOnH4sKz9D00X0xH1N5k+bA5via6J/OwY0vyTyJdS3ZLKi8V+Lv3OIjYA6Ta71YpXoQupq3xN6yi0D2yDS9GcV3EU0Ql1Xc8pAbEepRjvtaavdqv6u8cgpf0YyGYjKdeiFqYery1Axp8lRmXk/CmTab/BN5ilJuD41TJK/TeMtKat+y/D1fIonqIUS1Gy++zGaYvzOftkwRUTQWu3Pnj6AhLVWO54SwfyPpe8Vr1d1QG3m4Ha93I8bcRMlaJHpMGvCho2te/V2u5lPGAiUwW4lAZyz6ucYKq3KBR1wOytDa1c4rUmQ9FUWXyjYfoXjCfS0psnrT7RP+j75U8/QzR8ZAVKHnJgfb7nry7ouq+s2OTtsHWpca+EBX7nWRvHOEhoCjOW2AHNR8PlZyyhsrc+Pn1LSZdg4E9E/V9IDA7+isiJ2eElzwizIjP6bUoF68qEeaTZL9kNnJZS1QEpR54gSp9SoIEwLIjVEZ8lXkHY2RYf1KjdZvrVpIujEFQru3jEHunqIIuR6gUQGUIIdhGes4wTkqNg1zTKXLIgLGs2BdHmw4Tdv17da1s/9boHuw7dfJkZ0Y1GWSTo4x8k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?RVtiQmqnCUx1xwUDe97k4EUbFghCgKvc6dwKPdGqV7gNF27AJUKuojU6lo?=
 =?iso-8859-1?Q?ZzG+b4MGRsQ2JcLeZqkGgACqyAIt0MYOvfefUKYKSu02Ewg9sMZ4GcU6xb?=
 =?iso-8859-1?Q?D2CZ+6Xe/LOdT8uI/hhJ6wvNHh7u0JyhTsddfPgT4UYUW9kNWY48PdNH9f?=
 =?iso-8859-1?Q?hZalttdOJITQTjyBSCRQfw9/xm4suVtbVKFxmZwmDmwNyB2+aZXmI2VpL7?=
 =?iso-8859-1?Q?Xlw+k1Tp/Kl3BlVpiiFSrW9ejl+3ii+SJc5FYl5t6Sy2KM5NY/qW8PaSvp?=
 =?iso-8859-1?Q?SRhi7NMkwQY8h9wQfX78mmW2/V/NSyuaaL6MvPe/6Fg12ddZ2YuamdQPmO?=
 =?iso-8859-1?Q?U9cB5iRmseFDkHypkorPjnjww/gjtvpTUhF+u1UuRaMvLn3qbfIJt+ptjU?=
 =?iso-8859-1?Q?5G01Sd8FQ53TWcnFcULCDJnTbw7mLF9rDTKgDG0BwD75IiNhi/Bw+CqLWa?=
 =?iso-8859-1?Q?7f/1V3I35f/c5B4zZtA1jhjMw/Gd4hnfY6dpth7qwdrNZ+PxhBbkRaQyk+?=
 =?iso-8859-1?Q?3zaLtN8vw35qe5wL+a3pO7npq3pv9f9BVNC+GVhVL1WJznC9JYcI4TXVge?=
 =?iso-8859-1?Q?T9q5SfxZLjuiE1alOLNHsVhYuHhj7FJpK4EkK8AGFWeLl7OmwySc3IELqk?=
 =?iso-8859-1?Q?GOv4fEW2LRTQqIkiS+ZnD//l3AW1W9s4cL9jtOYROXwyLqC+V9P9G5wm6x?=
 =?iso-8859-1?Q?xkiRMsy8M52PNG8oueVgy+69UfJG5dcBRYxNO0bKyK71FHGqRiA93sWJR1?=
 =?iso-8859-1?Q?lsAlcMMOgDiC38uQyNSCWPZf1h1vPK2+nZcUd+KCMBPjHbFh575xzF2hW5?=
 =?iso-8859-1?Q?4Dntp9B61OJfMHhThwpNIKLa30/5bnshqmQ4CKXFv+lzkJzMW271phEcmv?=
 =?iso-8859-1?Q?IHI+Dkjz1/DMfPayrt8y4cKiHPqtYSEms+f+sxG4GWz+Ra7xkLTanlmAwQ?=
 =?iso-8859-1?Q?vZ4c/mLO9PPxappVJVoBIp9cD/HZHtqAUKuDh2ybKMrurFaW8BFObY8oZx?=
 =?iso-8859-1?Q?QpTLZYIyRMaNem4nqmJOvhhe8x6bM6mjR/szU5nfGaOyb23wmuxffM6lwB?=
 =?iso-8859-1?Q?Qm0SNOz/FNAOPN05m/9o/7S79/D1QBChUwHkEjRfh9VQeWmuxfUY5pulwr?=
 =?iso-8859-1?Q?xDhhUbmhIqbYJfh8xcv2BVWCnSzlsDOOMDnwLQqsUgeMmcMw4ind6hIrrg?=
 =?iso-8859-1?Q?HPPSPumorR2wgr5GiTux+rFUBIzmdSM3ziUMdkLp9ykVSlYmp049xPbAW3?=
 =?iso-8859-1?Q?IHn3S9Vfa+2vKjE7KQ0a2TwSai1i+1p2LJlcORDIya6fNtKp9KCo07i3gN?=
 =?iso-8859-1?Q?11JuaajAFc0VIq4iNf8e1nt8OvuBbhi7SktwR0VjgjRSWHBbSViVbn4rtK?=
 =?iso-8859-1?Q?l/tAJzS1G4RKD41w1KV4+us3ru4Ly7nWQLCXY23teMV2iiPytKy/lzFJOi?=
 =?iso-8859-1?Q?BUGifT2lQWGslgYutwRC6oJstoP6rhj1cyHbEWUqyKeOKVSCe7HHnHvC/v?=
 =?iso-8859-1?Q?nwTGAXGVCGOtlP+aJ767+1bZ9XrKiNz1D9SmlbuyrGGxvIa2HqJEvJjF1b?=
 =?iso-8859-1?Q?S9qazvY6iHdHAtd2Wi2jOQwXlHLxOIAeAzrwct9tv55XhB3Y4S7EFkbvxF?=
 =?iso-8859-1?Q?YtE6PFUNu/Gf8qGdXd/ULJCTFbybiAngKnsvW6z/vZEeyJSvny+94NIM3R?=
 =?iso-8859-1?Q?X0XXqdT6rWsEhNgiYt1Ppr9v5cYtAzQyl2O7tFTVM97F11mCVakWZsxToE?=
 =?iso-8859-1?Q?/uxCnKzOlaR1+AYhIt1LyICbiUBB/NNwVTJLHu9tHZA8bM5KTg1lVWUIgq?=
 =?iso-8859-1?Q?E6yjvqLi9Z+qjlqIqUUZjqIoEGsoojwwflKTiDRhqyvA4V2qCFgH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df5b920e-11dd-4198-fff6-08deee7046bb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 19:25:12.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXHUkiWXwtQostfPd2nCjzVgu6KVmeUiYP32JxEEcNVeDJsKCF9ZhQ6OLYpJtOXO96X1BD372w4zMoi64VQwtvaec9NuUhPdCCHocJY+/aGycuSNACuVsQm8/Hp8vqCY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9317

On Thu, Jul 30, 2026 at 03:23:11PM +0100, Nuno Sá via B4 Relay wrote:
> [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Nuno Sá <nuno.sa@analog.com>
>
> Advertise the single supported source and destination bus width through
> the new dma_set_src_bus_width() and dma_set_dst_bus_width() helpers
> instead of assigning the legacy u32 fields directly.
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/qcom/gpi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index a5055a6273af..fd45cadce91f 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -2265,8 +2265,15 @@ static int gpi_probe(struct platform_device *pdev)
>         /* configure dmaengine apis */
>         gpi_dev->dma_device.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>         gpi_dev->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> -       gpi_dev->dma_device.src_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
> -       gpi_dev->dma_device.dst_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
> +       ret = dma_set_src_bus_width(&gpi_dev->dma_device,
> +                                   DMA_SLAVE_BUSWIDTH_8_BYTES);
> +       if (ret)
> +               return ret;
> +
> +       ret = dma_set_dst_bus_width(&gpi_dev->dma_device,
> +                                   DMA_SLAVE_BUSWIDTH_8_BYTES);
> +       if (ret)
> +               return ret;
>         gpi_dev->dma_device.device_alloc_chan_resources = gpi_alloc_chan_resources;
>         gpi_dev->dma_device.device_free_chan_resources = gpi_free_chan_resources;
>         gpi_dev->dma_device.device_tx_status = dma_cookie_status;
>
> --
> 2.55.0
>
>
