Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010069.outbound.protection.outlook.com [52.101.84.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FEB39150A;
	Thu, 30 Jul 2026 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438355; cv=fail; b=nM2YwEuOEyffW0Bcr3K1P1xFgHMMDzfZvbRmtu00ChdmyObL6Aw8HY3AXI2xHKkK9BS2ulqeejedRQ70mJxdghe0hByNX2hXzKt2Xd/z/d0yLjza8vdr2IfOF8NnPCYVSOQi0qJ2AZbXyjdM4TDK1S1mfRGPuK6tk0tSgLKTnSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438355; c=relaxed/simple;
	bh=Btx7yBbLA6Fwjj86sGOm10U5KYAUYs/rrAQ1fF/yDdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k7ljqzK2ImPpH7MHuXs4cORrXLr94L9pVVSsgO7iQKzjRY7uHuiErw+s1lURrF0z2WU8KPDSh/ySMbgU1CTZST69P7gkdcJULXGucQCMsW2k9Ac/iHSiO8vV65Mav4h1abjBclVlN6BfQBS4Gho8nSwDXu9gvLeG+Mf+csLqKVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OMjMxzy5 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.84.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OMjMxzy5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mG4ZCeeBvT1kAHpWLtuZf4S5UCWzUR6S+k8btUzRQTDfKXRIs4xPg5X+4RTcaYaFEB+q5Z/nZT/pD6wnrdvsF2EkhpXex3dcQxSPjzSIPsJubmuQjH1GPSygsgAT0lR38popmZFxMJVXpfQYd9fKR7KB9OCsx5UNF8HcbnvJd9UyA8MCrQMJTFvU0CQP0iwWUKuc0rECAQMDV/2LZ6ivb4kzTNAvE5iFtxBzr2Ei7PP5h2Ik7R4cLLDZlKontgY3hLTNyzCPAwS/pryxjDuYy0IFgQWn1mGw0t5cBDWt9xijS5bclCAvae4LhdqlpvfmWAMzDm2f01Tif3PWZizyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmdCBNTQjWSFi7YCGoRi1aePDMjhJH9ejhIjorYJOQ4=;
 b=BVqqIZKqi+ixebUaxPORuqpG37WZdbN4PMavS4hOE2JsnOALCWoBzEK7oWQn/eg+7Exra5uuicy1fICiHy/UqiUufIZmS+gDdGX2Yy/oYFYo+aA6qdG/UV8q3u0V15WugnJhEchK38/MD2XwBejgykjEYJyj4n5NhgDgKuIbfcTUG7Z38RqlTGab5nH8aFprX26NSHu8suVRLWceYIbp1v80x1+MJ06Hip0xxcD2BWAE51RvOeyWliHbFLhDY2LCXce7e31hZaJ+O/OXNbHrJw8XMe28GfU4jM6DG8h+mQC0Rdeg9KfzBsS0pTwZuxZAbO1qAeJw6WZeOPcHo83bTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmdCBNTQjWSFi7YCGoRi1aePDMjhJH9ejhIjorYJOQ4=;
 b=OMjMxzy5AdkIjL/VLcnm9qUxqiHKq/frZ2X7ymo6jCqOtAj2MkEkgKzudX1aoY2amGJ9fIm9Sn1wXaF1RiPObwf+iryBi6G/gDxMVkj21moK83WsTH2oiFHlY1hEDxKOKrtzwK9WUte+obTdZ3Z3m/MwBmrQFxnEOKmG7VekaragdRCFXq96P7hnA9Dn/whgqLSEWva1wF1brBJankGF61mrZYN3qFLhedsSVPEiZZ57vscprLAer/OAwiqQa++0pxf7RfFNho1bSWm4J7HzlphOWpTb38wefecyR+e4PDUVyesvaZP/i2rDY2Nu0lE73vhqNgvkYITN0BK687z7Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB9776.eurprd04.prod.outlook.com (2603:10a6:10:4f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 19:05:51 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 19:05:50 +0000
Date: Thu, 30 Jul 2026 14:05:43 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: nuno.sa@analog.com
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 0/9] dmaengine: Support bus widths of 32 bytes and above
Message-ID: <amugh4vtD4BIl3mQ@SMW015318>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
X-ClientProxiedBy: SA9PR13CA0114.namprd13.prod.outlook.com
 (2603:10b6:806:24::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB9776:EE_
X-MS-Office365-Filtering-Correlation-Id: 639b3b97-c056-49b5-413b-08deee6d9245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|19092799006|10067099003|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1oqkyMWuOjEh3OHHya75ES5U5yRqW3oVXw48iO6vCjZvKyjL5SMc9U5/LYGpjPwkafKx6yKRU2zI3xmHVJexlk+/stsn1fduoqJ8pFayMU1BSPPya7KAKsERTMcE0npo/uq9+IlGdBLNbNsSrAmAKdsCJM7MmHK/BtEcCiGg9Ui8ySNZN2nK5Ek5v2WJI50C1S7U32/Af2rP/PEZfYWiAEZxFZEwR1ASTuGEc9CUPHLl9osO7nOelrmKM3El1m177d1PCuWJgw9vdhoG43fJRT7eKPUdn7gjvtBu5oadb9VF5j26i63+K9SlR2V22rsu0IhqOdOImNjTmwcL22/MGV/i0tnSUxquCkbKxnlOSB+k8yolsGqnaCah5utqnbdOdM2wWPT+LWb5QUr3dbSFkqiaLz3pbhvi0UXe8/71JLbhe2rCdfcsx0gxgNZmouA6t+X+kXa1/sW0wF06l/FH2rqI/8RYZuH0X+0eFB7ZFYvdUh6aoL4jY/nI5DDGweXes+hyw7s2lA7w4qavNlvn7H/qXv9wvl3VIJK8S1rDAmGb1XVOCNw53J+Zh3z0VfPEmCRGVI8nJuHpZFnl90mnsg1Gasv2JOKG74VrVh/Hcv8swKoXdQgaDImdhwPJM26hOj6BsY+qlAXicORzuQ2NTURRMCVkfjMrUpPtmsBXmQI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(10067099003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?v5CQVuYKYS66ZgOfcQ3uCEYM7K35ARQ4dnL7y+5ohN/hxxM7RPCWX2f8vu?=
 =?iso-8859-1?Q?YpjKBhVZIAr7luxgaLf6JMESAstt4oGi/u6dT6179bTHx1+TvI42Sxn3Kr?=
 =?iso-8859-1?Q?eZVfpQkulgqgGYF5xK0nlqMX0yYhTLdla4wmPQ7cELBC58UnvHB1wMqSmt?=
 =?iso-8859-1?Q?iX1Uh2M9cE/lDNZeDOACac2kLv9WykOyYMSyxU0C4+W+evJqOxPQRBuz1N?=
 =?iso-8859-1?Q?nMx3nGJTEoY8BMS/oem6547vVCvQAChPTd8EtuuWf1rBfAGXlBjQrS293b?=
 =?iso-8859-1?Q?HXxHYiWrh/B7794Hm3n4k3av33zdJ+ZzMErwlGcBKy2RmL0HH8Sef6Yav+?=
 =?iso-8859-1?Q?1WC44qMVsqaZ7wSKZzGL6dv7BlRsPNMTENTthXpmeil/YVHRgZ+j6KF6Gx?=
 =?iso-8859-1?Q?UMcYpAhBq9oVaYjHLw6Jmy5EoV5mpHgIISAEUzOdfMIYW5qIckiwOpUod2?=
 =?iso-8859-1?Q?7FW8vOKqerI3Q94AkeLrUtL4hK0CZ4WlJI60Z6xVScGFRNOy3UDddyfLMS?=
 =?iso-8859-1?Q?mUI9TeuhTu0p08jPt1XZl8nF9+OtxZwHRDnnjFZBbym8eBPCZdcr190GO/?=
 =?iso-8859-1?Q?aOt6r0SxzRk1XtymXAnO8iYY1bkOfCaV7pS1LKMo98oC7n4Vuj3BtJVDqd?=
 =?iso-8859-1?Q?a+qGUM19kw25ubd3zdApVAEe2gevOqZdDakJBLCg3sQGghId+PrkYMt1X0?=
 =?iso-8859-1?Q?M7LFj7pV2eUPTPE3tui6JFR8K1scmFRWKKwKArhO/ZAB42fcBAprnSkbzK?=
 =?iso-8859-1?Q?5KhzFIeCSqa0HFr/a1SqFfpkQZK7sa+wYI2gV0si2tOynwNKg5cmdvQt6x?=
 =?iso-8859-1?Q?vnzzPzNP29+kswUKpWmknXCT/pbCd1nhueyHDlaRas3/88Gr84CS6BiEfy?=
 =?iso-8859-1?Q?FrSi+QDdgFAknZYzXspDh5PloST8y80U7xnToHwCFgVw8aFnboBOZ9huh3?=
 =?iso-8859-1?Q?WCLwsoC4WbAad5D/4zroQklgIKaeuub08HwgznTuS0gNrQ5QUWlQwqb8LO?=
 =?iso-8859-1?Q?+SvhZ5knAkNzC+41XoHEHX18ms1E6DdjQ2fnMHde1xW6V+VIpYZ/fNCnWb?=
 =?iso-8859-1?Q?1mMrbxasUZC6IdadlTWhnTj1A8Fv7XtIMctkTamBgk937H/tQmD9HM8DcP?=
 =?iso-8859-1?Q?HsVeyF/SNNTXMdSQUuyUWes6YyzXCN9N5ucGpeJ1v0lrhW+brCYJ30wpLA?=
 =?iso-8859-1?Q?TRM3qPH3QPfHUdsmxR0i9JWdzrUVAoFC38jeqLptNxt03nUU+gk7VjXTUV?=
 =?iso-8859-1?Q?mDED1vHGN9S5U5gDYVm1El1Z91rWKu2ijnoLNHuEyitPva70tY1iDJQToT?=
 =?iso-8859-1?Q?aB/pWFO8UGmyIQGcSWtvJ2lDaMRHGxALKlmHlszbDG5mXEUSTq0j+pfLHh?=
 =?iso-8859-1?Q?ie/Whh2t/vowredg+kBN6EfKzvWMh/OqXaVl4Qzzw76IGmUc4c8PkTViKQ?=
 =?iso-8859-1?Q?doVdTanbr1IMiwWVKoIgzF67lTlOrqUo94jwrsWN2uNHGW1hARPDa1wsVv?=
 =?iso-8859-1?Q?PnEM+DRb7NaWLsTGNCdT3NWf+GQgsKxyFMTieZEyOfYfTcBAWAq7S+9JtA?=
 =?iso-8859-1?Q?sHsrkDU/0NZps07uP15p8STN6kH0lXX3c/yvioQLSjUlaal6r43341xjMm?=
 =?iso-8859-1?Q?9oUXMqfMfE+EbZI6BBM5IfnoZZ209Y+s5q+QlE6Dm0AIfHWwCAma/jvlVT?=
 =?iso-8859-1?Q?GkSC+djl3vZPJNRrAaKfdETeFUb61ypSUNMHMKoS9+kZDl5f5FQifqzKg1?=
 =?iso-8859-1?Q?82Sh1LFo0WIJfTWCj0qb0uwk3rQjYgea8d6xUxjrp8Z0GtA4yqz31CesGX?=
 =?iso-8859-1?Q?xXnNpgPkVTWDCo9k5Lyp8+007zZwR9/3rkW+lACy8DI1rV1ACItd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639b3b97-c056-49b5-413b-08deee6d9245
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 19:05:50.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zimWF1qSplGg6b8DOecHu1rGXkD9r1WdaIjIPxQvT4iu3UkKkBeAwdMbJXb96TH5m/Epb4y4lJW/A0gkdrNq5I4LGx/hb8KLitNI86pVIM5xhnQRqxW7iMH0xLYZAh3Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9776

On Thu, Jul 30, 2026 at 03:23:07PM +0100, Nuno Sá via B4 Relay wrote:
> [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> The DMA engine slave capabilities advertise the supported source and
> destination bus widths through src_addr_widths / dst_addr_widths. These
> are plain u32 bitmasks where a set bit's position equals the
> corresponding enum dma_slave_buswidth value, e.g.
> DMA_SLAVE_BUSWIDTH_4_BYTES sets bit 4.
>
> The consequence is that widths of 32 bytes and above cannot be
> represented at all: DMA_SLAVE_BUSWIDTH_32/64/128_BYTES would need bits
> 32, 64 and 128, which do not fit in a u32. Hardware with wider data
> paths is becoming common, so add a representation that can express these
> widths while still using enum dma_slave_buswidth.
>
> This series switches consumers and a small set of producers to bitmap
> based bus width capabilities. The legacy dma_device u32 fields are kept
> for now so the remaining DMA controller drivers can be converted
> incrementally. dma_get_slave_caps() folds legacy producer masks into the
> new bitmap representation returned to consumers.
>
> Once the remaining producers are converted, the legacy dma_device
> src/dst_addr_widths fields can be removed as a final cleanup.
>
> This issue was discussed before here:
>
> https://lore.kernel.org/dmaengine/abkoXXbaxaiqbBuX@vaman/
>
> ---
> Changes in v1:

this should be v2, RFC is v1

Frank
> - Drop RFC tag.
> - Rename the new capability representation and helpers from address
>   width terminology to bus width terminology.
> - Convert all current dma_get_slave_caps() consumers that used the
>   legacy src/dst_addr_widths fields.
> - Convert a small set of DMA controller producers and the stm32-dma3
>   per-channel capability callback.
> - Add helper documentation for the new public API.
> - Link to RFC: https://lore.kernel.org/dmaengine/20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com/
>
> ---
> Nuno Sá (9):
>       dmaengine: Support bus widths of 32 bytes and above
>       dmaengine: dma-axi-dmac: Use bus width capability helpers
>       dmaengine: dw-axi-dmac: Use bus width capability helpers
>       dmaengine: qcom: gpi: Use bus width capability helpers
>       dmaengine: stm32-dma3: Use bus width capability helpers
>       iio: buffer-dmaengine: Use dma_slave_caps bus width accessors
>       ALSA: pcm_dmaengine: Use dma_slave_caps bus width helpers
>       spi: dw: Use dma_slave_caps bus width helpers
>       dmaengine: Drop legacy bus width fields from dma_slave_caps
>
>  drivers/dma/dma-axi-dmac.c                         |  13 +-
>  drivers/dma/dmaengine.c                            |  20 +-
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  39 ++--
>  drivers/dma/qcom/gpi.c                             |  11 +-
>  drivers/dma/stm32/stm32-dma3.c                     |  32 +--
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c |  15 +-
>  drivers/spi/spi-dw-dma.c                           |   6 +-
>  drivers/spi/spi-dw.h                               |   3 +-
>  include/linux/dmaengine.h                          | 234 ++++++++++++++++++++-
>  sound/core/pcm_dmaengine.c                         |  14 +-
>  10 files changed, 323 insertions(+), 64 deletions(-)
> ---
> base-commit: 7524fe142b5a772f8421aeee2132cf7e21a00103
> change-id: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
> --
>
> Thanks!
> - Nuno Sá
>
>
