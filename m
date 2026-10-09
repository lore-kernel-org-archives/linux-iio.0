Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7124E9C31;
	Fri,  9 Oct 2026 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574403; cv=fail; b=biHfU6/7lcrDVi2oxHoxNWCabY+DON4gfBjG/f06jrZTdEH0UHrRVZ3Z39K1ExB8AUIVRLc91uVYd2Ac6KINoYCLW4FXl3k3yNEsEQaalpjQnWU+Z5NBHKBjUBrN+gpsZWao0oeFNAdnJqawU+RM9D2kuXlMI2Jau2mzdDYHARc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574403; c=relaxed/simple;
	bh=dCAn+uKTesZpJGE2e/yQchdSQ6FzITBo7RsT/QNX5nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p/eApieeQQZUD89KJkPcG16CrvG3Zp2fSO3CC/jGJwiIFq9y1cuJHNVaF+5bDvWvmxxFQvLrVkhoNd4ygQcnsFkS91mXH3KwLZan1o6oHLje+O+qyxIejrnce1uRUvDtyfi1cF9ChJLcP+YGilGwVCad9yU7QMMWCZXZGKF5uY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HT6N4JxW reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HT6N4JxW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFkmcGum8kkrUuJ9J/GkzkTHu6zP5sk05QuINvRW4/N0JGscERi39AV3fcqTqY2EMl+hLUqmZjMsvcmAdiA7q+geJN9ubyZuYdjnGbZOh800KJr4laZh8BY0xHIoIXx97Yf7wlOBcw+3GHAB9i0X2MLKwCQYpp36zqa5PbecLv3GkrcOTeBgAD6l56V76mPBNjrS9oxt/XEoyYq7L+9V2UydecxkwDZGrc16XN7oEx/kr7mZrOQagskSaaai3dICANX9Cenev4thruZyEn+55x0UWE0xkyaLbAzC11VBPIWAdc31y/dggYz/9bv160yM6R/H1edi8wQ4zuTx7W7c3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mv3ZfKEa/696EuHZvpJ9JRc3tb+gbMi7JMluqaPVEHQ=;
 b=fZI9AyzRJV7DALaLzj7KkD5y/3BB4fZU2Ylx7cU+Pnbskzafdni/52vGjLo6s0xAUFI8IbOOxrM4mYTWcd6a2oUx1f4F7XuAZdjrtWb+LwIrVtjr//QE4OP5zuP1BQqpwc1v2omx0iVh1sS+7RquZWFz97ll96DvYuCIlpKHMqsSKm2ar0OFgDPL6spJb3SxoXztGvW2Y2OZUASxq6i3/rFrZsvBIdnC+EfMKDjaNSrX51MJucspxXTcOD4nKVm6TtagBpYsv/qsntrKJvmuxjCqIJkF/05ejzFoRE9tZciqTimEbaJqwK8Z8mgDdjMWyJ0guLECwqDDMD98RlbFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv3ZfKEa/696EuHZvpJ9JRc3tb+gbMi7JMluqaPVEHQ=;
 b=HT6N4JxWzEuGBNLcr6aRTHGrlgjLtbFLer2dG7iT/hlBMSA+q/jmGjEeVfC1XoQz7KY6b9urSUy9X8YxeiPeK+u6BYJUTgq+NQ3PK1V8T7j0TtmX7rHJUdIbzJPsAcqFU1CyECCxy/IdmVCSGltF3GR8IKoT2toTijvGoFCjkXiSt+RxPlI7YG4R6rPhX6kH2XRUlxHEpcaR/cMUoy5QaNm9ylv2qSAweXLU2/tU8j1AyfsDVxEZ+fUA0MGGTiA52CALZHKTMetYqYq7OlSG9rNFdaVCEvkFj3xl4uiYAx6tWuCC1g/chg+BmysVp2FpOFg8NWPlNQjktLpcBMpG2w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8544.eurprd04.prod.outlook.com (2603:10a6:102:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 19:33:15 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 19:33:14 +0000
Date: Fri, 9 Oct 2026 14:33:09 -0500
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
Message-ID: <aslBdT8XqNW3L_WO@SMW015318>
References: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
 <20261009-dmaengine-support-wider-dma-masks-v5-1-4c4e63a7a1af@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261009-dmaengine-support-wider-dma-masks-v5-1-4c4e63a7a1af@analog.com>
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dae3e61-aafb-49b4-4128-08df263c297d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|23010399003|3023799007|10067099003|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V7wQQMw4EoypR/jbom9EXRL/w618m5MF1ucq9PWFyS8dPoWcEtgRpVtJM5OTi8m+gfZYS96kqVpKzRRZh+zbVjfXsLfXSSfCCNThLAdXzeNt80DWP8TkhfASZFwwKX4bxDpPdLHZU9EpWLtSnUenR7nbXt0sHt3DWWnjQQJDUyzEtkFhQg/na61WTIxQnCumvCZSau8a1WJaw7Z/nDPFOVUqnW9fjqZULqNAqiu5lShF/sjn1whX0IbBYyT0r4HHUdAfSqU0syzkvKajnwIdoGxWFlZgvbPeHKoBdIUXsydotnu0jCANuNn82szyjoeUY1ooFNpQibZQcBvhtCyqRr7e2FB0zku89fUE6v8g+83K9ZFwXswzmfG5ZWLPOTdYY7j21kmeMV7IpwLd30BMVuYsMAf6iYcA6PMsZcfgm1kjOziyOaW1laxIUT6feMNziZqpkFz2NkSIE7UJ8RbfQGJeShNv60Uaucc6p6Chj4ELbciSgkEr5jVBwWND2Ljt5AoU9wanSuOU/6cM+buFIzdLOlydDUhnNoSJzAfOrrLVe6LALUql2z8HMsk+ik/lt9zFJLywWPsNqBt8X3aSa0q9NqYk1PYYywygasXOjezD3zgYlQ4Y/rRn7+JaWemoD2pGAFltzLYnXOjl4sMjmhPCjVPorZJ03payzUxsPuw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(23010399003)(3023799007)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?zZ0bhll+G6V5dyMmW24a63A6MVTqa2gCek4f5zH3cHP1YsaTlH8TBZUq+F?=
 =?iso-8859-1?Q?999akmtB/NMbMYwIBuC//dwSaiw0uC53O4NLWBMFriv8xQStCDv57JgXVS?=
 =?iso-8859-1?Q?lrwzyJF805/67yU7g1pRYsOE4/WVxjbCDdbyImvtFEQ15a1KIhn01jaKL7?=
 =?iso-8859-1?Q?PHru+unS8RVstTbyrEMHEOEbhxmqmCdDO8ZSuqnehUadmEGBpzlOwt0n/f?=
 =?iso-8859-1?Q?cPAOuMqKB0ighshrE/gTSRU8C7GvshlwUE+khNYLA7b5AKMK/5IHI7153U?=
 =?iso-8859-1?Q?3knG7Tbz4uzP2KvSjdUdaa3G8eIRePW9wQEN74eu640xzU4+24eXult5h0?=
 =?iso-8859-1?Q?aLtl00ACO1jQl2YfkM6ZKULYt6i9hSRfxNdHjqx99TrwqCIlrLAlBPMDjo?=
 =?iso-8859-1?Q?KsvulGDbthJ1dXmtF9ozJACHziM3F1mtgx2OwFRG1cwio2bGQoLtsg2m1G?=
 =?iso-8859-1?Q?6uWGxax7BJAdAJx5KevrPgbPjEMh9V0zndwgO/sH/bm5YwVYAyh3Odcf8V?=
 =?iso-8859-1?Q?A/LvO7eihNRmMMGh3y10iEOncRLkZpZGXsjcYRfcKUVkBAExlEHvGhwF1c?=
 =?iso-8859-1?Q?qMnsMcp4xDTpG6rMpyBuoHVIVSkaewEkIE/x8ROWxPUPnmTYt76rdcc0lX?=
 =?iso-8859-1?Q?fDZkIb5U91oxR4TN5jmX9y1vUOlV4FhCw1YZnQciosx8+AK+r0p1FlsRuk?=
 =?iso-8859-1?Q?2D7m1hm4WgFVIYqPA1UGNUME9wrq7BBj3/1hV7vAZTfkcBhtpBYibp1PX/?=
 =?iso-8859-1?Q?Uah5up7/RAwYlpSW4RMkgUrvZ0vGnC1lsN9TKMZswTwSXhZpuTeM4995IF?=
 =?iso-8859-1?Q?rkASu63TDaC+LnrIZGOuSvpsLC7Bs0UtGqS2BCJGJ3GLvUUlXcXhwHkZNs?=
 =?iso-8859-1?Q?D/TD1Cvw3gPaxB17iC64NcTPwotjjnEcc08MyQvRdTBknUVtNmE81K4DaJ?=
 =?iso-8859-1?Q?HfE2th1j9KWyn/XLECDtz3ldLsx3XYz6Lm5tFHKVdHRJ6AFi5UKo5BasVN?=
 =?iso-8859-1?Q?wJANQzD/N2gU77ntjvXaWi33cuo+Yom4T9ylFA0hE4TRMm4fyKHOsOMTH8?=
 =?iso-8859-1?Q?LOP9Fs7HYKBGXLpOA4xQos1wL0XLZBDZYNoe28gkzic6Y2u0jj/ChF9n/3?=
 =?iso-8859-1?Q?+CG1s9YT+ODEwshkLjrzrEmiMF6cvKgSAvSOc/YhAhJ07tGqJ+3ZjYO9Rn?=
 =?iso-8859-1?Q?PjrYFwucymR1EKFW8938zZc1EWAa2twUiGv8Wtg4nTa74t2tdkQlnAkoi0?=
 =?iso-8859-1?Q?sfdz6DVLyZM6KiV7e9DljWwDQA8eAZIociEDmSvxvuQecDh+HMwLa4pNoj?=
 =?iso-8859-1?Q?1+tK+XEhGTsDltAzhftfnjDEOaE0bA8XR4M1TaAKgRUflVT8wT6C0z7qZw?=
 =?iso-8859-1?Q?uLcFCEk90xejnx0o2nGp33jFIVA/op5cT2kMORYdepeTs6uzlr3zPnjm6r?=
 =?iso-8859-1?Q?LewQ4V2lWi4lhGvFCe9qqTiYkRSAXxnEFyHD8iUC+qcKtTHjxWPJyD5xOA?=
 =?iso-8859-1?Q?IqLeVTwWVP1sT9YCr8iSck4NltmMQnzKg+5kBCe7zJoVWA5xKeWWUSorsY?=
 =?iso-8859-1?Q?HrnWPbX7q2yWim3irYOpcHwhVEcaC4NxAaQ86I1koOfVVhtaGvg6bUFTfq?=
 =?iso-8859-1?Q?gJKWok8nzIjByQ0pkZaEYR39Trr9AhPNC2Rnkjye4ghbgeZzp+Vmd8Dgrs?=
 =?iso-8859-1?Q?jgHHa3LyZbOtpqc0vhA2J85sDYFD2PnN8cUjUZf4MuZB13PC0U7j6WcAJj?=
 =?iso-8859-1?Q?ui5bRRv7Y8YSGYgayRTxie0rPZCvGuusnHfjnh3U3kViRIi5KsFIA+COxa?=
 =?iso-8859-1?Q?hlWSYjLnDC8Jx76RkOBFOraFUvLbcmghIJ2HcXQ913X+MKTXdaGs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dae3e61-aafb-49b4-4128-08df263c297d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 19:33:14.8175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvSIYN8cZW2dO2cm6huggCrMEzpXAsTs9v1/8arHtlmYXBQC6mDFm1qirBwrTSxFve4z7+NHK3PXuFU16KUJ+Ggk1EW0FWNXDi/gk7wXwGFDzxbvpFHvlkjlS29ixJd3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8544

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
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index c5fef57b5adf..4ba9d6c7448a 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -33,6 +33,7 @@
>
>  #include <linux/acpi.h>
>  #include <linux/acpi_dma.h>
> +#include <linux/bitmap.h>
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
> @@ -592,8 +593,11 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>  	if (!device->directions)
>  		return -ENXIO;
>
> +	dma_bus_width_copy(caps->src_bus_widths, device->src_bus_widths);
> +	dma_bus_width_copy(caps->dst_bus_widths, device->dst_bus_widths);
>  	caps->src_addr_widths = device->src_addr_widths;
>  	caps->dst_addr_widths = device->dst_addr_widths;
> +

Remove this empty change.

>  	caps->directions = device->directions;
>  	caps->min_burst = device->min_burst;
>  	caps->max_burst = device->max_burst;
> @@ -611,9 +615,31 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>  	 * callback to override the generic capabilities with
>  	 * channel-specific ones.
>  	 */
> -	if (device->device_caps)
> +	if (device->device_caps) {
>  		device->device_caps(chan, caps);
...
> + * Return: 0 on success, -EINVAL if @widths contains an invalid bus width. Note
> + * that the bus widths validated before the failing one are still set.
> + */
> +#define dma_bus_width_set_many(mask, widths, n_widths) \
> +	__dma_bus_width_set_many(&(mask), (widths), (n_widths))

This is not good to get first argument pointer here, which will cause
confused. check others.

#define dma_bus_width_set_many(mask, widths, n_widths) \
	 __dma_bus_width_set_many((mask), (widths), (n_widths))

Frank
