Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5891328FFF6;
	Fri, 31 Jul 2026 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513095; cv=fail; b=Qwp8jKAKdakvv+CmTK3kWyeeW1Ll5KiG85cglcv0chHnJzVYcX0EZNO+0Q8Trv5xXKFHnSLqb0LIjDS1OWzbm98j7DseYoR5e+yOdlat+4fqRMxkL5SH9qvn3NhM8QGQ6se1+oQqqm8R8i75fKUwxR79UWp+pVP0SMrvWqIXQAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513095; c=relaxed/simple;
	bh=CLUse3WQaLafEDCoQnztFYyWe0G1IMWjSaVpIvnqv5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gNMA5tYelxl869xHEe9qw/RFkdscZ4BZKkbqYBN4Bz15ewvbX2A5PsDXudNVqVZFI7mnnJTpmOdq/1rKr5wNZX8/fOhziJ0tOR+Ddj/PSQMVyTKYMCjtppxc+LrOus4ba2nNBn45TRpqMeTVxEwPN+P0mYsaHiJxzBsbNBo0A9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=k33VRqrv reason="signature verification failed"; arc=fail smtp.client-ip=40.107.159.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="k33VRqrv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KT+DTT4XnXkkkjnkDFYJezQtwrTgiSsrRxNgB1/oS3DPis/7d+r0hHPOG3d5u5tADgx/MU0HWSwcsWd+TYgO9lyoDSY3M3luprneN3MwaziYw+xvssc6oM6F4RUn3ZjOk396CvaFgosk4nRaZWsl+Iui5mUEWZXEzdZ/sLOYTAs0/7Kl/vLDclXm4DNgCEWbnwGmPvjEnjOmp7lqj5o3wXI+02DbUlIUNnLXlrKev30glZJOkxCxaffApzQyhvyYEzQmcF7fd7kPfWQD6rkyhg9RDFHsqF0HOGWQ1ny41hD9hEmVIbcOsHWz0Xgij4dxWrcYicxtpNIJqi12PCNLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Plg5bErelqMD2TT8DLwiryk9wmEIIgL4Pt5gymw9G8=;
 b=iYqxx1vwn7TjOCoUUn+js26SgDvEUV0bNc0ki7g9nqTpBBmt1TE0PahbHQeMY4bwkGj4ie+y7tUcAZutC7cIiqnag+4xRFWKsrfanoEnVILwz0OmZJkw21MeeXp7vM1YPHCOWy7etcd4exaOqy5g+tsPTITPKw9hWIAWe6YJYAc34Yhh0F2xRYzADnTHLbn1Y87tLC94YSxQrcIfgCgYOThQ5hrKOldIvleeBL/k8kXG5UJOHuCC60AXVfISsrWLb/3CD7szZYKfAIOSwi1mmV6whixPohWMyJ9wB91I5MVuC4aM91QSaosJ2Alaeq8b8vXDCHr0JgA9oobXLje6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Plg5bErelqMD2TT8DLwiryk9wmEIIgL4Pt5gymw9G8=;
 b=k33VRqrvghRIpWx+l33wg+yGZDNiLTfEA+IvviLZH1bKiKM+HqVWKngljW6mBg4Z8QXZb8XyaG+xn8IVwRON6co7kS50BD3a3eOnipWQn3LFsaWamuBcy30LQZk38fpPXLYUSSvpD/duTxH4i+lekFQVJvWeXTsWCDMvu2M3BBOSxki7jkHH5vJdWE8JF2lTdhYO9+0SHb9o9W9P/wdG8wVyN3bmNPHHZMIIDUOxujSGTUUvOmZW4LH3np9gbJ78j+QTfJz2t10kv9ni4lxaeNItcTsSyO0iP8cUTPjDroU7QJ5hgS8b+1HaVdquieFuAdTADo+CBQbtaM6SRTgtOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB10970.eurprd04.prod.outlook.com (2603:10a6:150:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 15:51:28 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 15:51:28 +0000
Date: Fri, 31 Jul 2026 10:51:21 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, dmaengine@vger.kernel.org,
	linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 0/9] dmaengine: Support bus widths of 32 bytes and above
Message-ID: <amzEeR4A-py0E6Fj@SMW015318>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
 <amugh4vtD4BIl3mQ@SMW015318>
 <amzASrOOjJjFun3M@nsa>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amzASrOOjJjFun3M@nsa>
X-ClientProxiedBy: SA0PR11CA0080.namprd11.prod.outlook.com
 (2603:10b6:806:d2::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB10970:EE_
X-MS-Office365-Filtering-Correlation-Id: be9edb23-81aa-40ba-8f6d-08deef1b9578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|19092799006|366016|4143699003|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9Qn4zWgRgO3cf30LvwpZJ6wgtb9ehJr9i8rv6b62AjV5Hh6Erv3bkELyq63AZZ72D2QoeunUM4wSlgYLuNL8tmrKs2UDyGHq/AtDA5FqMrFAC2sZ5l5wQPhHVlp0gA4807aYDIkVRxxyC//3NmBdC1A0nQ6DXEO14bXuyy5zWBpb54+9bwEzhL5RrR+vy5YtX94oU7B02kuNOJwLET10LJXHN8ANqje/vrXvVpWwigHQGdZWS4LH8l/vnQLar25iLhV5J6uy9INxhba+5vHxw6uCDny+rvymyTKTXM99XaAKM2bPeZmJvouM23HiQRQKXgfZgBWd/LUz1QOkyi/klfdVvy3amzyXAQhk17MdsC6v6cxTKvp53Oezj3wh9xfAiMzK9MgrkI7FmO5AF8QFeER5M+5icDxmpxaVbGEpcBUeNJb+0ioyPjNFG/916PtD5sjLXUe3uMlcXdHEpgc4k+80mhLm+6B54ujs/I3Hqwv21Yr0fI6PYGAPZ/AfpkmkbBuwc7bPWFzwo9pJqEe2kK9zb/Fx360jfMXPFWz1+M1hkkNA2etNdTfUehSA1Gka+qDjIpJ3BhvVW+lwB3cqy7Tl/uENB77zlmQZJB857aroRk43Pnr+UHlnSeX1+07BxDz8kdsqIXftGQ0OGkm+YS1G40kkrMxJLMDSkjeqxHQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(19092799006)(366016)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?2fqeIsICZwYXpORTopJWCQyDb3s1hdy/piVcA8iNRUBG6GMAgqSXpJ7cPD?=
 =?iso-8859-1?Q?PTk/ZRe4Z2UIL/VQ5lL1UjDEQuUjZ7UkMOTjCI22C+fzIg1aWcbZK9TpII?=
 =?iso-8859-1?Q?BqI9mYq1qcDMgmYw03tnjVhquUw6hBUmJ2tbqVl4jdG9Lk3RPtuvcGjVXc?=
 =?iso-8859-1?Q?WgJ61Qmq3ZOsmwAnvTUSD6T4V3qcabJ36ZsI4LsxzQp4TuO5Yg7QZ1OzRR?=
 =?iso-8859-1?Q?WqiNuCSMW0YJKCpgOktLSarJmToUBJJbP2bym2d9hzzOEaVKL4KYl5vrhs?=
 =?iso-8859-1?Q?T3Fnv7DPN99S1psXDoGRqNQla4tw9LtT+VOvpw1TSkJyUEiy4qsCVOvO0H?=
 =?iso-8859-1?Q?eGyi7Op8Dk83zZ9GegGSKerIGpPmEbXN4JxWaPMX6xp6rJ/WfiChi6McHZ?=
 =?iso-8859-1?Q?MyfFfkXEEKqHtfEbNUVSI2R5CQqAlNA0/jePRq2M+/OgaAyzPhgw8qOMFF?=
 =?iso-8859-1?Q?YfcRgrBgvZIPoxC3nK0vSpWnYpFt+VtywXiruWQEnBQzJ4x2i9YV9w1bn/?=
 =?iso-8859-1?Q?ayRYPp5e34SMR/oknK7TWJkrMYOUz3LQSL6dAnDJF72LfpEP8O2xnsGvDo?=
 =?iso-8859-1?Q?E8j38celGoftOJj0gMk20U4YRhLBn4/lSZLqqLLqgiyeK8OZX6s/WMpT0I?=
 =?iso-8859-1?Q?KZnC1huAL3P+Z+gNvYwnNgOGAsW8jK3hwB8YsrqO+IM3i9JPakLJjZnERU?=
 =?iso-8859-1?Q?V9DnWeWZ3va4YML95ezdiQywyXm5tTjwxFCfGV+iaxKhemIpmyBY19rqFj?=
 =?iso-8859-1?Q?5yuWro8QFKh863f1XgHlK8ZVuEscPLQUoHYIq6oL25z0+8SXPCY9Ne+zYN?=
 =?iso-8859-1?Q?6cl1AutaTwRJDL9YiLDfqmDSbfltzeTicW0PFZI1xwtLBk3pNgizT002uv?=
 =?iso-8859-1?Q?Wt/4hZFU6TbXVcv0mao8/8Vu0CDLIyQ3c0GCU71PekD+NjQGMt1iIyL4Aq?=
 =?iso-8859-1?Q?RkVt0jIQjVGiZ3xAPcZ+NOPPS3DEcsq4MB/cCx7z/+/GoFTtTo3QNtvHqu?=
 =?iso-8859-1?Q?38rfUqzW/ivkCUbD9o4bVweW4vYsTuuA+skE7bPkIYTeiqWbHKfyNrG5Fv?=
 =?iso-8859-1?Q?DMyzq2MwMmhSS1cshUv/yjSgrZ103AV7NFVxOOzpiCnOVVLXYrlrHVCy2y?=
 =?iso-8859-1?Q?vTAIJl4HFflEP/lGy+mn/U2P/tCrTWarGigU+vn8WVzOBZavyBDgFYaiVe?=
 =?iso-8859-1?Q?Ymt6FApX/D8X3Sc06qSln7U0zjCPUhiwlQN8DVF4PkeBObnZ28FjR0RxJ2?=
 =?iso-8859-1?Q?1LHi+LO821/kVDU7RVjRnIerYo/QdXiw5GZRbcWhMSqqWFjQXstugXjduN?=
 =?iso-8859-1?Q?egedOyEpnXw6HSmzJs/7VpCzKXK3ebNIecwMD1GtHHB1EADpzXwp+M2VC/?=
 =?iso-8859-1?Q?pqwIPCYIs0ha9WGKc3X2EKBSTpM1Y2zr1S5viYoBaJgEDs/cTVTst7/hme?=
 =?iso-8859-1?Q?ZK58g2QN16mjQ4RC1Ui1cq8NNvp91e6At20fGVJncc8FM8YeEXUVkcOjqZ?=
 =?iso-8859-1?Q?dfmvelMo2oyHCkR8DU7AzaFHz5DVdT3WU1Kw2f6I9BKvgl8XSp9QkSNDXx?=
 =?iso-8859-1?Q?hjjwqPnbEU9xICTqyrk2tzO7gjQ4U5fIfqI5Mh67FCAfwosHhRRmmOWDiV?=
 =?iso-8859-1?Q?G3Vdl/D/fcYorsgPEEqw6vn61FInBaQBhdiDvWZgdwkPf0sTbDGI5CGynm?=
 =?iso-8859-1?Q?jrWlPHq2DamfkFwL/Vh3fypx4IoJzSIyiBXm/++4pdg5msg0D2z20BgeZN?=
 =?iso-8859-1?Q?nsLZG8T6Vow0HCmecmKGYu4kjKo6kbKAtDmblukcq9d4sLF51El2C8zYnt?=
 =?iso-8859-1?Q?XG/9IKaBd8ItzONBd8ZtiI2hfdnSBznpz5c3bHMRNl4esdqYUjWo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9edb23-81aa-40ba-8f6d-08deef1b9578
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 15:51:28.6960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6epbQ7VyOOlGpWEyypUIUNj/4t8FLR6yTQOdZNptd9sOTpFlTb9ZGwjhn01d3RfC5dpKMXTMTBCPExXDpYTQi5JSYB0sUN2lpDqggmosJWC4Cd9DG9M3ZoqJqsnu1WnO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10970

On Fri, Jul 31, 2026 at 04:34:16PM +0100, Nuno Sá wrote:
> On Thu, Jul 30, 2026 at 02:05:43PM -0500, Frank Li wrote:
> > On Thu, Jul 30, 2026 at 03:23:07PM +0100, Nuno Sá via B4 Relay wrote:
> > > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > The DMA engine slave capabilities advertise the supported source and
> > > destination bus widths through src_addr_widths / dst_addr_widths. These
> > > are plain u32 bitmasks where a set bit's position equals the
> > > corresponding enum dma_slave_buswidth value, e.g.
> > > DMA_SLAVE_BUSWIDTH_4_BYTES sets bit 4.
> > >
> > > The consequence is that widths of 32 bytes and above cannot be
> > > represented at all: DMA_SLAVE_BUSWIDTH_32/64/128_BYTES would need bits
> > > 32, 64 and 128, which do not fit in a u32. Hardware with wider data
> > > paths is becoming common, so add a representation that can express these
> > > widths while still using enum dma_slave_buswidth.
> > >
> > > This series switches consumers and a small set of producers to bitmap
> > > based bus width capabilities. The legacy dma_device u32 fields are kept
> > > for now so the remaining DMA controller drivers can be converted
> > > incrementally. dma_get_slave_caps() folds legacy producer masks into the
> > > new bitmap representation returned to consumers.
> > >
> > > Once the remaining producers are converted, the legacy dma_device
> > > src/dst_addr_widths fields can be removed as a final cleanup.
> > >
> > > This issue was discussed before here:
> > >
> > > https://lore.kernel.org/dmaengine/abkoXXbaxaiqbBuX@vaman/
> > >
> > > ---
> > > Changes in v1:
> >
> > this should be v2, RFC is v1
>
> Ups! Sorry about that! But I guess now we keep this path? I mean, I
> should not bump to v3 next right?

Needn't bump now. wait for other persion's review.

Frank

>
> - Nuno Sá
>
> >
> > Frank
> > > - Drop RFC tag.
> > > - Rename the new capability representation and helpers from address
> > >   width terminology to bus width terminology.
> > > - Convert all current dma_get_slave_caps() consumers that used the
> > >   legacy src/dst_addr_widths fields.
> > > - Convert a small set of DMA controller producers and the stm32-dma3
> > >   per-channel capability callback.
> > > - Add helper documentation for the new public API.
> > > - Link to RFC: https://lore.kernel.org/dmaengine/20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com/
> > >
> > > ---
> > > Nuno Sá (9):
> > >       dmaengine: Support bus widths of 32 bytes and above
> > >       dmaengine: dma-axi-dmac: Use bus width capability helpers
> > >       dmaengine: dw-axi-dmac: Use bus width capability helpers
> > >       dmaengine: qcom: gpi: Use bus width capability helpers
> > >       dmaengine: stm32-dma3: Use bus width capability helpers
> > >       iio: buffer-dmaengine: Use dma_slave_caps bus width accessors
> > >       ALSA: pcm_dmaengine: Use dma_slave_caps bus width helpers
> > >       spi: dw: Use dma_slave_caps bus width helpers
> > >       dmaengine: Drop legacy bus width fields from dma_slave_caps
> > >
> > >  drivers/dma/dma-axi-dmac.c                         |  13 +-
> > >  drivers/dma/dmaengine.c                            |  20 +-
> > >  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  39 ++--
> > >  drivers/dma/qcom/gpi.c                             |  11 +-
> > >  drivers/dma/stm32/stm32-dma3.c                     |  32 +--
> > >  drivers/iio/buffer/industrialio-buffer-dmaengine.c |  15 +-
> > >  drivers/spi/spi-dw-dma.c                           |   6 +-
> > >  drivers/spi/spi-dw.h                               |   3 +-
> > >  include/linux/dmaengine.h                          | 234 ++++++++++++++++++++-
> > >  sound/core/pcm_dmaengine.c                         |  14 +-
> > >  10 files changed, 323 insertions(+), 64 deletions(-)
> > > ---
> > > base-commit: 7524fe142b5a772f8421aeee2132cf7e21a00103
> > > change-id: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
> > > --
> > >
> > > Thanks!
> > > - Nuno Sá
> > >
> > >
