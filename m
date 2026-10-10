Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011045.outbound.protection.outlook.com [52.101.65.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6231519F12D;
	Sat, 10 Oct 2026 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791600324; cv=fail; b=VKHZULBvy/NX2LBjI5XZaREdVU02RYcQxOQTEbqSPHfpBCOcnIdMIi3mwddAPKQkzqHAmkGuu20w3e9A1oT09Hh9BkVeYcFbNdvBQWmQCLhJab4qdxcMCXVKkn0KxpB18KZ0rkXg7jOyNDyuO0gHDIJw249qc5SnUCNGmZi5pOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791600324; c=relaxed/simple;
	bh=CKAa2exvzXQQ1oHH06nd2gbUYxwrbFv1VIlRM7zDBX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UvK3Ds1EAitX8LkSc09mLFpfZVE775N73GkVrsSVC4bH5mtUdjTGU3OaznxWZtdzohMiG/egXVo61kTJTdNORRzG4LLoJJLkN8g5JMjKNKvgwzqoIokDcB4rOOK/Mk7ohCjUB9TyGjBPTWDHPrmRo9nJH3iGNvs/D6mh//ZPe8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hPNYYNsf reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hPNYYNsf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+mObMe2OeyDTWte9tqJwCVK1JEbBj0V8oI8EcjZS7rAQc7JnD87P26eAgK25r2bb7xUtSVnyjQofndCfclp8Ip7b6/T6Y8Ce0sFYEStGx71UODXdZyqmOJeT35MG81uZ2f6VipyCmk2B9Ze831RlBbtT8lp5foABKWYE73+39lFHF8xoyUqWNFJYOCdU69cGgqkZ2V26tRl7FHqhaWUrAdG6xKP7BkZWOaLzq5y8tag0ckf0Y9KrToT/BvBTrpD86e00OHpjglHYKFYB0lSHB1SRaJtQt+AYJRnRB4jXcD9Y1eckoTLRsD1M0SHZ6cSw8fqK2CPSSTnqqxVVa59oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfU5+s/nyNTUbzmKmLkYcBIc2WVdwQLLCcaQZEv8WHU=;
 b=URGF/K19Jr6t/oJmkUZkFvEuUy7j0M69xMfjuVDyj1llsf5GV4/pWUfj3PSQdcwahdteG2bSyIbL/hhaP6WCe/F5gLyVgkene/eIgCsgKoKUIQ8laPWJTfZiL9W5kc2/KG5lOZhg/cOm+aRRT2SmVZzZbnO3mLBUK8trzAtiEO9Y36JKj6kP82CjcVWgB7ys/iGeWMzcBmiOFJRmGsw+p0dxyv/ed2dfSYBSe/Jy4ztVttDmZnGavfnjx4vGGLNqlU3Z9u3YXL0gtI37ZDDrwbVOa7a3K5dDswIbaVni+Wo1a8L/4kE85nw5wkYuFlnu/RSuuek0WI1BMThdSEUegg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfU5+s/nyNTUbzmKmLkYcBIc2WVdwQLLCcaQZEv8WHU=;
 b=hPNYYNsfzFY6Z3cs5BPHkeKrMnXJRE8rvISBUTWX6yRBVAFbxKHafD35Y9M/XIOD7Elc8owtyaI/6A8eyYFYe7yevfRcyL+8ueyNJBBkuSTxkdJ3x4/8969pXDoJ7X8efLy+MRQ0HVSaA59g7T5GsmwsGUea6OtmRivkt5qRSZHKQTiEsOxre9UzfwXVCwl6/nTGMPm83Ee3TyCyq4Z3HaXGWV7Yo1gkN818jKN2d6eEyywLBJvf2CqYqO4hQhoG4ugNTWdS5AksX9oM1Seu2njkGiXTfxKMGUwBXaHZ/DZL46EHOzFDRXxQS1hRcTpSrNaHwlcosAxRlfltMHl6Rw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB9589.eurprd04.prod.outlook.com (2603:10a6:102:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.18; Sat, 10 Oct
 2026 02:45:19 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 02:45:18 +0000
Date: Fri, 9 Oct 2026 21:45:06 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	=?iso-8859-1?Q?Am=E9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <asmmsoNxW-gfugXx@SMW015318>
References: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
 <20261009-dmaengine-support-wider-dma-masks-v5-1-4c4e63a7a1af@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261009-dmaengine-support-wider-dma-masks-v5-1-4c4e63a7a1af@analog.com>
X-ClientProxiedBy: FR0P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: 9589e2d0-d55f-40d1-622c-08df2678854a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|11063799006|261009223027099003|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	vyLLLN96zpRZUrxyyL/f2MDqlJzkTC0aC7Wkm5UrQQenyc7U2ng33KZfa57xL9PUNPmfn252hu1RozX4Sk25x1+rRMte0cu/DpfBid2mjriwT2plTBZYUUjZy7BqxPFrsNu6TMLzoZ6dNupbg+g2kRV1C/+KKAe0+6ZrNifuy6VMUSN1dSiBV0qa0LEiOk8pZnZCBiD/p72RQK2YSnNTLLlW80uMnjR27QVde9GVamE7V6VM3eoelXy7sOi8q/0WYG0H4dv8pIgXThi0+cwCQYzWHBXaf+wRqbO0rALekLRNdQcafdgxWnyVmuoICgpsARFzq+1RukQCtLdXOg9AKZip/sl9ZMQvD8LF5jrhf63UTR0ca566HW26y1CqmCMNx7Fnxf0VylDC1LAXaA9/tFMplz3F123Ivm2EnPtL1yF+a/mllE7vTTz+R9ajsQsiW5AtuLnMQ/3/PTYACpam83ibUo6KB1NkwQo6lKZbN4gnOQO4OoWsnLAiQ9n3MSDPsJUh9TS6rHEcoaoRRxeY1qO0jCp7AuAHOjzvujTSJgxQbGXxjl/yxLwYI15wk133zlVt24I6bO0JduaSbhj4Cwwq+hXT8suLO0eSjSRgnoMsydZNcUSVHom7lDRXA86KnKEr2kGiZHXXm2uWk8Pe5P7M0efZgEbsWW7kem1OdRI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(11063799006)(261009223027099003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?4nHVbjLyt+YgJVfbYVcfJgPyiWj0H0ICxt2qNUovIV6UBgek9ohiuoQyGT?=
 =?iso-8859-1?Q?t8/VnzRC5H5xG7a6G12755jNavyVtr1b+81tVHTfjM96IF6tYlQ0BzpTQQ?=
 =?iso-8859-1?Q?3m38niRV4QLp2a1WUx2l6jOO3O0qbLU2d3/8v7e4uyCCP12UlwIm/i1qpw?=
 =?iso-8859-1?Q?WsZKeVLhWd97f7n7FAF+Z7u9UDYE3/Y4RuIEQaRGGJ27wTtEJRYqMug1BR?=
 =?iso-8859-1?Q?dmnR92dIvCUX5y0iRcvnQ0Hk3EBr8ddEPTDnF1x6vWmGDk7fjyhNHAlRSy?=
 =?iso-8859-1?Q?NCciaN4AzgcaP6wTofWKTHYSzcPD+dFuNeTARi2l0KztYGSVpRFSXEe1Ci?=
 =?iso-8859-1?Q?t7NyiGFhoOFX8AfL1/2RJ2bDz6Z6SKGdAt2VQwzgpTncZLhzndxg5hZ2LP?=
 =?iso-8859-1?Q?nn0K+vFyowqDbNB58ZoEb5Wep0+PHUfLVYR+3f44NxcvxarypphNTLYEO9?=
 =?iso-8859-1?Q?qo5s34y/TXnF/R/O0N/XsZ8EheYZ1tgW8DVNu9BPk97j3/qvmSepAFjGED?=
 =?iso-8859-1?Q?ooa5CqEEcSQjIR8uyqy4AvMy+BEydfh0pG82CVnzBS4b/8YD5banGUncD3?=
 =?iso-8859-1?Q?Wh376neTv70SLGJLyi4FqkF5LT67atKnYeg0lPDb0oDcAULC6oJ5onClQ4?=
 =?iso-8859-1?Q?DTGedN1SH5ughagldWesdcHzVnTTQ6fUAnnHpTNwCUgcpCNBMZI6ojMTXz?=
 =?iso-8859-1?Q?xnuXSFO3PQCgVTnYqL3tNJCdkSv47R9eZw4U48d4wND8/d3AdtT2Xioc6J?=
 =?iso-8859-1?Q?qUA7DEiOIgkGODDjh1utPhpwfkSFijUkmMfvRDY01Ra/hcUqalXtC6DgWn?=
 =?iso-8859-1?Q?9ubHEoyR6nUDf4VbgXQICQAAn3pUIZVE7l1bK6UFeMHDKfNc2l5XbnB2/z?=
 =?iso-8859-1?Q?VrvT2z6Pd9ZyEZBCxUYlrt2n2n+nr8RbrNicOXSDkY2Zzg8l7YhQ6eV6Vd?=
 =?iso-8859-1?Q?WjOoI3h16SLXi4zL/+W0Tors5Rg8QYPswbZ3iBn2HEwFfTgPcsi7/knkr9?=
 =?iso-8859-1?Q?alsMFlQfRzJ08GLSfY0foWZnUQkFEOYAbk6Bp3NTaRrP57hZ1BtKyFaBtk?=
 =?iso-8859-1?Q?SHYpWNsdrbImYBvTnIawUcpH0bB0+KZE3agIGBc3y/UykBsLVfurT8P185?=
 =?iso-8859-1?Q?D9RQ6YhvDrwdByww8/TpJzqHibjjfBOv4cC/Bl44AZiFher3byKOzm6CNC?=
 =?iso-8859-1?Q?FmkNJB9Y5IqZWsuJJrYhXTgmBgiXtpUiPZtI8A0JeRGFYr9ji/FNmp11rh?=
 =?iso-8859-1?Q?c7C8c4FrKYLhCfM3lHTAxAuXxl+18SsuhP8Hi1gbU+psQsWholvP41m+0M?=
 =?iso-8859-1?Q?DTJ3ZoO6DC9zyLtLmLxYgDTtcCuTuqKVxZMYKMXoeVIrjsf80ateimMU1I?=
 =?iso-8859-1?Q?WbqhGZDunHbi9Vr6O2+U7l565CMRE8g2UQeddHT7rnhWUIKJtD2lpDlbSm?=
 =?iso-8859-1?Q?sT9xb2Zon1D6ZnEunkKlftmbKHY3gnzl5GbbtdLmpxZRw9zn6ptml73MgX?=
 =?iso-8859-1?Q?FtUsP3lUbvn8V7ITs8HdlidzsFpGzNS9I0qMbh7l7jMkj6ioKPdcI4vGjo?=
 =?iso-8859-1?Q?rDK/h7AEaHPAr3HYAOHpOsdfv/iTuYZy8IEZ/ZkX9o9rdmOv+snKPIOXVg?=
 =?iso-8859-1?Q?oo4QcejaR7ls3y0E5CxzvWswQGAbeWeCGo1ZVhNVDAJs7cw8xYXiXDNKAu?=
 =?iso-8859-1?Q?HKo6kX8ZmLxcgH2sslL/y3QrolVpEw+WtzAOWGjt744dtVvyAq/6hk52OW?=
 =?iso-8859-1?Q?tMahPdOOQRSrydnG3vqpOyAL6UHXJLFTX2dMd22HefSPBOoJ+eGarjkpXe?=
 =?iso-8859-1?Q?zfoGntH9KRVXysWUhPIi1EhOlOMuBlaDkX4V2ie28k0EkMS/lw6f?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9589e2d0-d55f-40d1-622c-08df2678854a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 02:45:18.5791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ke+BeKn7Hg2V53Da601Q2HBuK1epNiDWdJx2kjtrpPAjHtZ5YwT+0162yHKDxIl+JQUah0kWG/IervkbAGMThdcL0XBdYmqxsN2Z20KfKXAqv6q9CCXU/qpV7U5rvihn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9589

On Fri, Oct 09, 2026 at 04:52:53PM +0100, Nuno Sá wrote:
> The src_addr_widths and dst_addr_widths capability masks encode each
> supported width as a bit whose position equals the corresponding
> enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
> 4). As these masks are plain u32, widths of 32 bytes and above
> (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> be represented at all.
>
> Introduce bitmap-based bus width capabilities that span the full enum
> range, through a new dma_buswidth_mask_t type modeled after
> dma_cap_mask_t. To allow DMA controller drivers to be converted
> incrementally, the legacy dma_device u32 fields are kept alongside the
> new masks and the core folds a legacy-only driver's u32 into the mask
> when the device is registered, so consumers only ever have to look at
> the mask.
>
> The fold is bidirectional while both representations coexist. A driver
> that only fills in the legacy u32 gets its mask derived from it, so the
> consumers already converted see it. A driver that only fills in the mask
> gets its legacy u32 derived from the mask, so the consumers not
> converted yet, which read the legacy dma_slave_caps fields, keep working.
>
> On top of that, dma_get_slave_caps() derives the legacy dma_slave_caps
> masks from the new ones when a device_caps() callback adjusted them, so
> that a converted controller narrowing its per-channel capabilities is
> still seen by the consumers not converted yet, while a driver adjusting
> the legacy masks directly keeps working.
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
>
> ---
>
> Andy, did not take your tag given that you're the one asking for the
> split and since we ended up not doing it, not sure if the tag is
> to be kept :)
> ---
>  drivers/dma/dmaengine.c   |  51 +++++++++++-
>  include/linux/dmaengine.h | 208 +++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 246 insertions(+), 13 deletions(-)
>
...
>
>  	/* note: this only matters in the
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 71cde09ff240..eb68eea840b5 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -427,8 +427,179 @@ enum dma_slave_buswidth {
>  	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
>  	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
>  	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
> +	DMA_SLAVE_BUSWIDTH_MAX
>  };
>
...
> +/**
> + * dma_bus_width_min - get the smallest bus width of a bus width mask
> + * @mask: bus width mask
> + *
> + * Return: the smallest bus width set in @mask, or
> + * %DMA_SLAVE_BUSWIDTH_UNDEFINED if @mask is empty.
> + */
> +#define dma_bus_width_min(mask) __dma_bus_width_min(&(mask))
> +

We are working on make dma_device private. New API avoid direct use
dma_device field.

pass down dma_chan point, dma engine handle everything in core part.

> +static inline void __dma_bus_width_copy(dma_buswidth_mask_t *dst,
> +					const dma_buswidth_mask_t *src)
> +{
> +	bitmap_copy(dst->bits, src->bits, DMA_SLAVE_BUSWIDTH_MAX);
> +}
> +
> +/**
> + * dma_bus_width_copy - copy a bus width mask
> + * @dst: bus width mask to copy to
> + * @src: bus width mask to copy from
> + */
> +#define dma_bus_width_copy(dst, src) __dma_bus_width_copy(&(dst), &(src))
> +
> +static inline bool __dma_bus_width_and(dma_buswidth_mask_t *dst,
> +				       const dma_buswidth_mask_t *src1,
> +				       const dma_buswidth_mask_t *src2)
> +{
> +	return bitmap_and(dst->bits, src1->bits, src2->bits,
> +			  DMA_SLAVE_BUSWIDTH_MAX);
> +}
> +
> +/**
> + * dma_bus_width_and - intersect two bus width masks
> + * @dst: bus width mask to store the result in
> + * @src1: first bus width mask
> + * @src2: second bus width mask
> + *
> + * Return: true if @dst has at least one bus width set, false otherwise.
> + */
> +#define dma_bus_width_and(dst, src1, src2) \
> +	__dma_bus_width_and(&(dst), &(src1), &(src2))
> +

One thing I forget, new API should start from dmaengine_.

Frank
