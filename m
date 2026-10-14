Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013035.outbound.protection.outlook.com [52.101.83.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D95737E310;
	Wed, 14 Oct 2026 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991699; cv=fail; b=aEceWGp6qBhEkEJ6ODH7PmHB2cedFI3xvNKicWER7yik/0+QE1PTzgxm5QSSSrnS1fqO2gUctM1qtutKr4c9XNo3lugG7z6/kQjBsEuqRa6ECFt/yWKxkti8f3b4fyhyzKyYwixgduXBkBfkTCPKc4Wv2U60ntY1qVLCQza4NiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991699; c=relaxed/simple;
	bh=w3iULvwhbdXS5BuHBwo7svxDf4mjDFpO36WFK5F2cc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=caHbqP2Yhv7Fvml1yQ6zGhtPjlzNw+PEbto+O6X4HD6pgiaa1lcoPomcYn6mfb4w/aBrzJq1wIMxVyB4jf/stqD8kbbdFP5dZr0S8PghrDnclwb+Os9/8Y88aayi4eyVPAHPrfmSmc0x6jVP6ik5V0yYD1ZXG48BjmjgmlZaP68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=d3dDPx1G reason="signature verification failed"; arc=fail smtp.client-ip=52.101.83.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="d3dDPx1G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcZMaX6pO8v/6KoBdJ1HzbTx0oC+0VWBEfsaM4Ns6JGeHM6VqBfro0F25PfENBwyyWJWEhQhjWsJ97MDFWam2H/WmV3IJwtsJNW4vzScz2tvtR6f2UyqLcwAaUGxCZNEjsQIw0IDMl7Sc0GJe3IlGDx5LNl0xLfq1YJpteHpznPozTXirGIi/H/mkGMGWVZuC6hJibV6xbLzVQzT3JWwBrp2TS6KdFr/vq/nGu0H2TeFoCM1451/RN2LGF9ZlIcCdvkvuj3zlhmvgqmMn4uo3z6ilThxrAw8EyE5huBh9KKIeq3/pWURJifnBKpeqkosMUosXl4aSEgaQE3bZ5BREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvZiuJlLyJMZNhrU/0/s4O8Xbj/s5OzNh5T5i6+MhTY=;
 b=MEiP39YFmD7s66mcdm0ZevBToxBVsWxpooM36qT3GWgwpCZ3HcNVzxd6VibzSTtE/6smBUoFJJgYXvkQnMs7MIxPyiVybhU5FlZ5x5trAP8WypKpHzwZ5kOA+46vmMGC+IQ2xmqX441JxPklD1IR+zwPnerS+GVAo/cx/2t5Iqvg+k20P6N0Cssk+JFvlckKvA8XZZkaIy4nkulvLa50wDFj84btos03t84Cv+gKjbR2UCUwfqipFgLyDiHKLhL2dfar8pa281WQej8ex6T8+BAAybo7BOKCdVZCHEFnlkQ4JhaDej/IJNI5vGq+8Bs/RZkBlq1ygxKXAy000tMWrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvZiuJlLyJMZNhrU/0/s4O8Xbj/s5OzNh5T5i6+MhTY=;
 b=d3dDPx1GrRkgFZIXqKdXPxugTRNAnBhrmfULjqZcY75GbNo3V6P5GNEorcA9iDq0/zDac4222EqmKDLKiFffjL/ytBv4mjzuLEXq6V4Nmmm/jufjVBpIBBCmkTROX6mfzg3oCKH6dfUHc0tpwzduBt7Aiu0bzOp4YbvJF8sbG1vkqoEHAWgkLIQG/PgivFFnelW4QPrsMbPNc97ssfYnVsfsvwWSa6t5wvPV+xCWV9PVly/36XzxOzcW0zFylXVtPOULZjiqzKznrEu5eJac2fEKdDyO3ArojmXeaifaVWuQsQefkmd51EyOBtYx0ZElVtIjfwjobEq/FNwU3YGsSw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBAPR04MB7272.eurprd04.prod.outlook.com (2603:10a6:10:1ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 14 Oct
 2026 15:28:12 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 15:28:12 +0000
Date: Wed, 14 Oct 2026 10:28:00 -0500
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
Subject: Re: [PATCH v6 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <as-fgDViIz4oSap7@SMW015318>
References: <20261014-dmaengine-support-wider-dma-masks-v6-0-5b3ffdef8191@analog.com>
 <20261014-dmaengine-support-wider-dma-masks-v6-1-5b3ffdef8191@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261014-dmaengine-support-wider-dma-masks-v6-1-5b3ffdef8191@analog.com>
X-ClientProxiedBy: CY5PR15CA0103.namprd15.prod.outlook.com
 (2603:10b6:930:7::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBAPR04MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 72145781-cc5c-4e62-af1f-08df2a07c1ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|366016|23010399003|376014|10067099003|11063799006|3023799007|6133799003|56012099006|5023799004|4143699003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	TMGWcJOF56+yvnztEmXK7vRS6NBT3gQiozorXthh6HuCAju+Ou1bprVadiEH+bg1CYmWMdG62a6wXLsaa5mGUKnF8jA7Cs94B5B+CNGW1vOmTCPIPXAyDx/ghCdbUg/eShe2uTJuqbc9lKbXvFdTbToxArE3rpAxK/+a2CKeNI7pT/asFr1/PFhWsfiqQb8/+cRvF+VaP807cM9WBkP+qp01Ip2wLZ9UC2YOf5+0poA1sLFXSIjfdH1LWxvPC+azb3avwscbj6qAIUBCsCsj9jw/pOBoHBHxQVyAscotF9q68BpPN18I7QGvkeTi1kuiFgRGW7S/kSOECzQ2mfSacENdhqw+0liq+xirHkr0a8jfwfbY/0rABFbIq5vB+ahrmIT/vjCSFbsGBG3pxIafJbNyuKtQazwL5k4LRnwuVJCKdIrmiHk1ma0zvbdZRNDmSCxcswdK4NCy5S+2CM7A7I+XFIVQfnreQWn4+XCsEqOZK9VIy0aT83tk1gBAZ4sumYyvoorJlDPtEbfCpGygUUac4sy1X2Boc6XnBrlnOv9IJ9iXN4gC9l/EaZYLUI1CPEAwNSnumA/Wzw62nMV603vmoZvXw7NtdURk7zljcaLJPb2f2xC3jni4f4m98UYI+80SWNJ+TqiqVxhJlyw2eLU9vCO8Xy/KtZHXBU///M8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(366016)(23010399003)(376014)(10067099003)(11063799006)(3023799007)(6133799003)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?ci/tS1L58AELlfCgQHNRqjjyI8p2lBNkOT+Oh4wowoGBNl2OioW05pEHvw?=
 =?iso-8859-1?Q?F/QY4HhPawoGb2CtIFmdlVjjkvD7zc5eX0mQ9dvbAC8M/TGmHr7HdSI4SP?=
 =?iso-8859-1?Q?AGvDpLedeSw/aHr80EES4u7xixa9Q0SzdiQ8BkjaW5C1M2pvWQG1wP5Bgv?=
 =?iso-8859-1?Q?uzk92DQMcRzflcI3slrs4K8qJVuMRtUzT1n83qmHCIVLl/o8lIybfSF1OZ?=
 =?iso-8859-1?Q?wD4YCFIIwNw8V70HdExr4bmmUtbcpxHdlKmLRhkQ3avvHCBey1+xl7co/s?=
 =?iso-8859-1?Q?5y1rcVBCBzncYllvX78B66LEUHYer6DhLY7kLkRyCmTMxBf6/7Ga4hOBLz?=
 =?iso-8859-1?Q?kVDLlqpxYttF2+yVvdofIMpuSQSzsdyutALJX4UQtM9P5s6I/7bGFTD9oV?=
 =?iso-8859-1?Q?AA/SlSVScwMNWAPTQLpSytfa3Dug2CsVBr5UdKfKHzopEDZEwyTRD5XLeV?=
 =?iso-8859-1?Q?cJttppUadsi+SLH5iQqGcPBlDPlJO2I3FjZltgdGznBsEviqy1KlZG1tG1?=
 =?iso-8859-1?Q?6XSSbTfKg5ne3Be/Jiyyl3HwEi1npQ4DvoocU2HgCJ5gYjgbD8fzAuFE6y?=
 =?iso-8859-1?Q?7Weyg9/aPNHajLf7YB9o6ZwzWAHRl70Fz6P+SuUj+T4hAX94Fc+Ezn1zJc?=
 =?iso-8859-1?Q?od4/tCQEOu4+sci/F4misEY7cXnI0CUugQeYjUtvHN3ThF11LaKL3tA7AM?=
 =?iso-8859-1?Q?qZ4t0zlrlg4N0z0RrOhLnjr+PjGQ7cOxz29PGlxtGBAKzSn5TwVtkzvv9o?=
 =?iso-8859-1?Q?sJuJjYZw7ke43rZCXqu5dY8E7f7G8wuJg8vdrwniV+DvDyEATsFUS/Fdbd?=
 =?iso-8859-1?Q?Hm4rOpvfyB39KH/LrV0oiPhB5kKMdFo0kaZ8eNgA/VZMfSed7q0/G3mCFp?=
 =?iso-8859-1?Q?yJRsh1aNJgzRt/2tW2N7y56cymxyp0C8lmP6jYSXCCfEorDVb/kkIDP9l3?=
 =?iso-8859-1?Q?FJQ0WZq238gXn33tmPmZoALro1eoNQPJZOU+KRDj95DgaXRNAD/qrbMNoJ?=
 =?iso-8859-1?Q?zPpqkfOUpJxdq10kBKrZpLAk6AZ1vYwvwlM17RIyCwY6zN1lyO8XY/YyOM?=
 =?iso-8859-1?Q?1iINXIuVU7hT91VQedakm+nCRCHT1D01BZTBYKwBh9CkLaVeAw9bp4nUFa?=
 =?iso-8859-1?Q?5O6ddRt9+E9riP2yeKrxePhQP+Sy/uq2a5zTIauEHwjgd5E+rUE8QSf0hh?=
 =?iso-8859-1?Q?KeDXI7D/dZD4Emc27NPNPgdPc9z2eTPckq3hb1woYpiyeICcPjB5wdfwMH?=
 =?iso-8859-1?Q?3sJBfbjQ/4KW4syTDXVszRUKqrbLzOqrvcYDF3Jr82LyeQ6pvCtbmrRVn0?=
 =?iso-8859-1?Q?AP8TVbr8WR9E2CZzHCTd14gmMunBH1M+grDJUkXgQh8r0VDEKNSfPSQKm7?=
 =?iso-8859-1?Q?WH6J+nFej7lw808ZClqqpqt5lHMbOMVi5YtYCRK7S+NzGspMnXObjk9kqc?=
 =?iso-8859-1?Q?ureWoWI6nDi3FRfor1FwKUwLMadtfXs52iKLB4SbogvXXkYILg0U1rXBlm?=
 =?iso-8859-1?Q?VsJ2NWu0nFAqbjYmUChAA6sdxxlOJUCFmftMj9rHOKpeBTA/pxGfAUuIgl?=
 =?iso-8859-1?Q?/p1vdj9wU2YPec4OukLY/rH4iCT/Nv4H0arc8qhi8hi8elGmmm7Zm4zH1/?=
 =?iso-8859-1?Q?etxAyIHj5QqJ+mPZWwHVF/pycBKLAU82Ksok0avp+JvnBIie6Xr3Ok/C27?=
 =?iso-8859-1?Q?lIVh12f2DgqxOD7L3LiARrJm3WALdSTutO/oYrm/ITh6p5rhU9p/quWqpM?=
 =?iso-8859-1?Q?J+BVaCXFzQespO9mgwtHWhQymHuRGxemfDLOqRCVyv2kPr8viBGRu6QuJG?=
 =?iso-8859-1?Q?g83Hf/qe1NxWh60QZY8wVsIbF44fvZJxNJQYrazatkE9Ya1+r8eH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72145781-cc5c-4e62-af1f-08df2a07c1ec
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:28:11.9477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p85uaN9XZFIQiu8rLttWGj3bj/XezkUVQgUyzmKQ9JRjXYuDRGYacsM/BWa/5SX/G2PtfH7gj26trEAMpUKTOZXt6ZQeLmToaub2/z0vl74oC1OYAkiO9IpUSYWrez6F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7272

On Wed, Oct 14, 2026 at 03:19:11PM +0100, Nuno Sá wrote:
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Andy, did not take your tag given that you're the one asking for the
> split and since we ended up not doing it, not sure if the tag is
> to be kept :)
> ---
>  drivers/dma/dmaengine.c   |  50 +++++++++++-
>  include/linux/dmaengine.h | 197 +++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 234 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index c5fef57b5adf..b47008595332 100644
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
> @@ -592,6 +593,8 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>  	if (!device->directions)
>  		return -ENXIO;
>
> +	dmaengine_bus_width_copy(&caps->src_bus_widths, &device->src_bus_widths);
> +	dmaengine_bus_width_copy(&caps->dst_bus_widths, &device->dst_bus_widths);
>  	caps->src_addr_widths = device->src_addr_widths;
>  	caps->dst_addr_widths = device->dst_addr_widths;
>  	caps->directions = device->directions;
> @@ -611,9 +614,31 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>  	 * callback to override the generic capabilities with
>  	 * channel-specific ones.
>  	 */
> -	if (device->device_caps)
> +	if (device->device_caps) {
>  		device->device_caps(chan, caps);
>
> +		/*
> +		 * A driver already converted to the bus width interface
> +		 * adjusts the masks, so derive the legacy capabilities from
> +		 * them for the consumers not converted yet. Drivers not
> +		 * converted adjust the legacy capabilities directly, in which
> +		 * case there is nothing to do.
> +		 *
> +		 * Goes away with the legacy dma_slave_caps fields.
> +		 */
> +		if (!bitmap_equal(caps->src_bus_widths.bits,
> +				  device->src_bus_widths.bits,
> +				  DMA_SLAVE_BUSWIDTH_MAX))
> +			caps->src_addr_widths = bitmap_read(caps->src_bus_widths.bits,
> +							    0, 32);
> +
> +		if (!bitmap_equal(caps->dst_bus_widths.bits,
> +				  device->dst_bus_widths.bits,
> +				  DMA_SLAVE_BUSWIDTH_MAX))
> +			caps->dst_addr_widths = bitmap_read(caps->dst_bus_widths.bits,
> +							    0, 32);
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dma_get_slave_caps);
> @@ -1173,6 +1198,27 @@ void dma_async_device_channel_unregister(struct dma_device *device,
>  }
>  EXPORT_SYMBOL_GPL(dma_async_device_channel_unregister);
>
> +/*
> + * DMA controller drivers not converted to the bus width helpers only fill in
> + * the legacy u32 masks, which cannot hold widths of 32 bytes and above. Fold
> + * them into the mask so that consumers only ever have to look at the mask.
> + *
> + * Goes away with the legacy dma_device fields.
> + */
> +static void dma_device_fold_legacy_bus_widths(struct dma_device *device)
> +{
> +	if (bitmap_empty(device->src_bus_widths.bits, DMA_SLAVE_BUSWIDTH_MAX))
> +		bitmap_from_arr32(device->src_bus_widths.bits, &device->src_addr_widths, 32);
> +	/* consumers not converted yet still read the legacy caps */
> +	else if (!device->src_addr_widths)
> +		device->src_addr_widths = bitmap_read(device->src_bus_widths.bits, 0, 32);
> +
> +	if (bitmap_empty(device->dst_bus_widths.bits, DMA_SLAVE_BUSWIDTH_MAX))
> +		bitmap_from_arr32(device->dst_bus_widths.bits, &device->dst_addr_widths, 32);
> +	else if (!device->dst_addr_widths)
> +		device->dst_addr_widths = bitmap_read(device->dst_bus_widths.bits, 0, 32);
> +}
> +
>  /**
>   * dma_async_device_register - registers DMA devices found
>   * @device:	pointer to &struct dma_device
> @@ -1234,6 +1280,8 @@ int dma_async_device_register(struct dma_device *device)
>  		dev_dbg(device->dev,
>  			 "WARN: Device release is not defined so it is not safe to unbind this driver while in use\n");
>
> +	dma_device_fold_legacy_bus_widths(device);
> +
>  	kref_init(&device->ref);
>
>  	/* note: this only matters in the
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 71cde09ff240..b190bfb42df3 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -427,8 +427,168 @@ enum dma_slave_buswidth {
>  	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
>  	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
>  	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
> +	DMA_SLAVE_BUSWIDTH_MAX
>  };
>
> +/**
> + * typedef dma_buswidth_mask_t - bus width capabilities bitmap modeled after
> + * dma_cap_mask_t.
> + *
> + * Each supported bus width is represented by the bit whose position equals the
> + * corresponding enum dma_slave_buswidth value, e.g. a device supporting a bus
> + * width of 4 bytes has bit 4 set.
> + */
> +typedef struct {
> +	DECLARE_BITMAP(bits, DMA_SLAVE_BUSWIDTH_MAX);
> +} dma_buswidth_mask_t;
> +
> +/**
> + * dmaengine_bus_width_valid - test if a bus width is a valid one
> + * @width: bus width to validate
> + *
> + * Return: true if @width is a valid &enum dma_slave_buswidth, false otherwise.
> + */
> +static inline bool dmaengine_bus_width_valid(enum dma_slave_buswidth width)
> +{
> +	switch (width) {
> +	case DMA_SLAVE_BUSWIDTH_UNDEFINED:
> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +	case DMA_SLAVE_BUSWIDTH_3_BYTES:
> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +	case DMA_SLAVE_BUSWIDTH_8_BYTES:
> +	case DMA_SLAVE_BUSWIDTH_16_BYTES:
> +	case DMA_SLAVE_BUSWIDTH_32_BYTES:
> +	case DMA_SLAVE_BUSWIDTH_64_BYTES:
> +	case DMA_SLAVE_BUSWIDTH_128_BYTES:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +/**
> + * dmaengine_bus_width_set_many - set the supported bus widths
> + * @mask: bus width mask
> + * @widths: array of supported bus widths
> + * @n_widths: number of entries in @widths
> + *
> + * Like __set_bit(), the widths are added to @mask and the bits already set in it
> + * are left untouched, so @mask must be initialized by the caller.
> + *
> + * Return: 0 on success, -EINVAL if @widths contains an invalid bus width. Note
> + * that the bus widths validated before the failing one are still set.
> + */
> +static inline int dmaengine_bus_width_set_many(dma_buswidth_mask_t *mask,
> +					       const enum dma_slave_buswidth *widths,
> +					       unsigned int n_widths)
> +{
> +	for (unsigned int i = 0; i < n_widths; i++) {
> +		if (!dmaengine_bus_width_valid(widths[i]))
> +			return -EINVAL;
> +
> +		__set_bit(widths[i], mask->bits);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * dmaengine_bus_width_set - set a single supported bus width
> + * @mask: bus width mask
> + * @width: supported bus width
> + *
> + * Like __set_bit(), @width is added to @mask and the bits already set in it are
> + * left untouched, so @mask must be initialized by the caller.
> + *
> + * Return: 0 on success, -EINVAL if @width is invalid.
> + */
> +static inline int dmaengine_bus_width_set(dma_buswidth_mask_t *mask,
> +					  enum dma_slave_buswidth width)
> +{
> +	return dmaengine_bus_width_set_many(mask, &width, 1);
> +}
> +
> +/**
> + * dmaengine_bus_width_clear - remove a bus width from a bus width mask
> + * @mask: bus width mask
> + * @width: bus width to clear
> + *
> + * Return: 0 on success, -EINVAL if @width is invalid.
> + */
> +static inline int dmaengine_bus_width_clear(dma_buswidth_mask_t *mask,
> +					    enum dma_slave_buswidth width)
> +{
> +	if (!dmaengine_bus_width_valid(width))
> +		return -EINVAL;
> +
> +	__clear_bit(width, mask->bits);
> +
> +	return 0;
> +}
> +
> +/**
> + * dmaengine_bus_width_test - test if a bus width is part of a bus width mask
> + * @mask: bus width mask
> + * @width: bus width to test
> + *
> + * Return: true if @width is set in @mask, false otherwise.
> + */
> +static inline bool dmaengine_bus_width_test(const dma_buswidth_mask_t *mask,
> +					    enum dma_slave_buswidth width)
> +{
> +	if (!dmaengine_bus_width_valid(width))
> +		return false;
> +
> +	return test_bit(width, mask->bits);
> +}
> +
> +/**
> + * dmaengine_bus_width_min - get the smallest bus width of a bus width mask
> + * @mask: bus width mask
> + *
> + * Return: the smallest bus width set in @mask, or
> + * %DMA_SLAVE_BUSWIDTH_UNDEFINED if @mask is empty.
> + */
> +static inline enum dma_slave_buswidth
> +dmaengine_bus_width_min(const dma_buswidth_mask_t *mask)
> +{
> +	enum dma_slave_buswidth width;
> +
> +	width = find_first_bit(mask->bits, DMA_SLAVE_BUSWIDTH_MAX);
> +	if (width == DMA_SLAVE_BUSWIDTH_MAX)
> +		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> +
> +	return width;
> +}
> +
> +/**
> + * dmaengine_bus_width_copy - copy a bus width mask
> + * @dst: bus width mask to copy to
> + * @src: bus width mask to copy from
> + */
> +static inline void dmaengine_bus_width_copy(dma_buswidth_mask_t *dst,
> +					    const dma_buswidth_mask_t *src)
> +{
> +	bitmap_copy(dst->bits, src->bits, DMA_SLAVE_BUSWIDTH_MAX);
> +}
> +
> +/**
> + * dmaengine_bus_width_and - intersect two bus width masks
> + * @dst: bus width mask to store the result in
> + * @src1: first bus width mask
> + * @src2: second bus width mask
> + *
> + * Return: true if @dst has at least one bus width set, false otherwise.
> + */
> +static inline bool dmaengine_bus_width_and(dma_buswidth_mask_t *dst,
> +					   const dma_buswidth_mask_t *src1,
> +					   const dma_buswidth_mask_t *src2)
> +{
> +	return bitmap_and(dst->bits, src1->bits, src2->bits,
> +			  DMA_SLAVE_BUSWIDTH_MAX);
> +}
> +
>  /**
>   * struct dma_slave_config - dma slave channel runtime config
>   * @direction: whether the data shall go in or out on this slave
> @@ -523,10 +683,11 @@ enum dma_residue_granularity {
>
>  /**
>   * struct dma_slave_caps - expose capabilities of a slave channel only
> - * @src_addr_widths: bit mask of src addr widths the channel supports.
> - *	Width is specified in bytes, e.g. for a channel supporting
> - *	a width of 4 the mask should have BIT(4) set.
> - * @dst_addr_widths: bit mask of dst addr widths the channel supports
> + * @src_bus_widths: mask of source bus widths the channel supports.
> + * @src_addr_widths: legacy bit mask of source bus widths the channel supports.
> + * @dst_bus_widths: mask of destination bus widths the channel supports.
> + * @dst_addr_widths: legacy bit mask of destination bus widths the channel
> + *	supports.
>   * @directions: bit mask of slave directions the channel supports.
>   *	Since the enum dma_transfer_direction is not defined as bit flag for
>   *	each type, the dma controller should set BIT(<TYPE>) and same
> @@ -545,8 +706,14 @@ enum dma_residue_granularity {
>   * resubmitted multiple times
>   */
>  struct dma_slave_caps {
> -	u32 src_addr_widths;
> -	u32 dst_addr_widths;
> +	struct {
> +		dma_buswidth_mask_t src_bus_widths;
> +		u32 src_addr_widths;
> +	};
> +	struct {
> +		dma_buswidth_mask_t dst_bus_widths;
> +		u32 dst_addr_widths;
> +	};
>  	u32 directions;
>  	u32 min_burst;
>  	u32 max_burst;
> @@ -839,10 +1006,10 @@ struct dma_filter {
>   * @dev: struct device reference for dma mapping api
>   * @owner: owner module (automatically set based on the provided dev)
>   * @chan_ida: unique channel ID
> - * @src_addr_widths: bit mask of src addr widths the device supports
> - *	Width is specified in bytes, e.g. for a device supporting
> - *	a width of 4 the mask should have BIT(4) set.
> - * @dst_addr_widths: bit mask of dst addr widths the device supports
> + * @src_bus_widths: mask of source bus widths the device supports.
> + * @src_addr_widths: legacy bit mask of source bus widths the device supports.
> + * @dst_bus_widths: mask of destination bus widths the device supports.
> + * @dst_addr_widths: legacy bit mask of destination bus widths the device supports.
>   * @directions: bit mask of slave directions the device supports.
>   *	Since the enum dma_transfer_direction is not defined as bit flag for
>   *	each type, the dma controller should set BIT(<TYPE>) and same
> @@ -924,8 +1091,14 @@ struct dma_device {
>  	struct module *owner;
>  	struct ida chan_ida;
>
> -	u32 src_addr_widths;
> -	u32 dst_addr_widths;
> +	struct {
> +		dma_buswidth_mask_t src_bus_widths;
> +		u32 src_addr_widths;
> +	};
> +	struct {
> +		dma_buswidth_mask_t dst_bus_widths;
> +		u32 dst_addr_widths;
> +	};
>  	u32 directions;
>  	u32 min_burst;
>  	u32 max_burst;
>
> --
> 2.56.0
>
