Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011054.outbound.protection.outlook.com [40.107.130.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7213B9DAC;
	Thu, 30 Jul 2026 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439917; cv=fail; b=fuze5DPw4VrmCagdeyu7+upMWxCwMqFnjOR34lXGUf5cUZPLoyGvRkqchV4m66YGt5oxPBLxD6WA4Ci7Q7A9i4FFPooKjUcpXqjHpF8Pv7TmUgi+WPyIMfvZ8/npu0iKp7CCRqMrXYIEOlw64NFC55HP4IlShBlpm5NJRaBNVIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439917; c=relaxed/simple;
	bh=9Yg+ih//g/M9jLQdE3MebJWD1bz0wvDVgn3GZ7TAbSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WezUxprf/3TOP1FdARb57h3zpF4y3MVCoKHtyulayAKL5g+2Z3PCylU50a4l9EZGZxEJqwz7S7fTaarCdt4VYRrlk9gvjt3AS7ZztY/7xbAp3oLm+Op5QGAVTIbVzk+mr7b+MYjX+VvaIBrTw5N/4Qqf1SbS3CyDdKFOQPjCX2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uz935CVg reason="signature verification failed"; arc=fail smtp.client-ip=40.107.130.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uz935CVg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOMmd/fKKC/0IxvrmperXpVHRJtJi2IRXWQ8qDm0b5cSN57F+jVjLDs1/uLdYdbw/y3iqg3HF/O10Dm17TYwPlvxSjY/WOFtj1HuQI9RBRWtkpBlu+fGTHrOnjJSlPNkHcuyDla5nWqhx/QTB8KvMjZY6Pf4CsiNYaNNn4VlOLvpGjECqYSBg/5CTvrYv2AkEr4GB6dZ6umVeU+ZUma7fUnht9itGD0gnHSMWhT8sLmhxMOuU5N001WTeaFqrQIkLdoArsIiW15Q49JgOxMsr8F9kFTGEbnucixjpX8Bv62ozva25+7Fp5ddcObCO7RxR1VvJrp3NP9/KlPLuZw8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voa/wKB5+8H2t9UAGlUFl/aIe9wTHGbyuryz22rmjKI=;
 b=Da5VtrZjihRNXLde/moKB9DOp1QC9Ce504aq+ziP1E+qQMakZN/zSFX0S3eoS05wzzrDVKeGZo8ajSxu9RDKJUjdLazOgpD1/Z2+VZ/cPz7pr5lR2j+1ERi4Yjeg+fOXJehEPViQowfBFgaVWE+t0EuP4cks+SLaKQsIeHcsFv633FyIUzZohHkjxmOe1Mh9PZgCtH2szCioesbvxsvlW3qRF4LXkqc+PapfUCCOl/7pBte9iYXXhKnnLNQMSEryOOPKaWE0o7XY/5mN1a0en9MCpPvvpa2J65FvdaZ1MzMy3A4gDTefiepdIb0WLHI+s23LGIHuywW98O5ZVjAOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voa/wKB5+8H2t9UAGlUFl/aIe9wTHGbyuryz22rmjKI=;
 b=uz935CVgAvCgE74lC9ShouFGFtf6Jk+Smf85jiPRdoxHWrht0zODU32CdTEaevWARUZKRSMJ4biZXuU9JvnFXdxi8yNjI9TocHpwhMb8tDpG884Pwnlbd6KQBSuM/mlQLWBNjRyQQ3hpvFhZdExaPsb7nPnJWcT6dGb6tDgx4spmZ2EBXPYKFC33QCyyCxzsBVOPZmHl8MPIqPEwSu6H5ukDNPuRzQ6menrvakwuCwRSuJ3WjEDycXOYHQsPJOQ1zWFY9zhAIZf4XlWFjLheoZPHEWPf9Oy/I0gyuBxNGhVAGnQSHeWlPSY3yiuSNWwKWFYzpkkri77YhlGRpiiN8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB10955.eurprd04.prod.outlook.com (2603:10a6:800:27c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 19:31:51 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 19:31:50 +0000
Date: Thu, 30 Jul 2026 14:31:43 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: nuno.sa@analog.com
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 8/9] spi: dw: Use dma_slave_caps bus width helpers
Message-ID: <amumn1HJAcxVEWt5@SMW015318>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
 <20260730-dmaengine-support-wider-dma-masks-v1-8-3732f1f9d9ca@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730-dmaengine-support-wider-dma-masks-v1-8-3732f1f9d9ca@analog.com>
X-ClientProxiedBy: SA1P222CA0175.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB10955:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a451cd-e9a0-4481-ca8a-08deee713414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|19092799006|10067099003|4143699003|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ikFTVV5GpK5yYjKahk0o0XsjJz0if6FzV3l54X5Tia+Ybr59NbGXpCzVVbxvtkJDf5udCUZrnSq8zQQ5blKCm2xtLasnbFDB2W5MosDfrr5ZRmQkUWlotugx1h2p6LSDB3E3LQnLHSphshaVx75AIZpundcKmMzmPUwqgX2lREfBHry6X4+/zH+Bjhs4Jd6BoGwBqEb1oQusob+BYD0sO2dCgEtIQm6ICiVXOfNeC19z++gc67v1hYr9Azu5/+SMBeRrUE21J5lLPMoxdjJfCNi8zHohdHIX+8UZw4CS9KYsi1GgQtKCfwcDUzbQ4jtmSg5eodtMLkvvTh4pHt5PIKgNl3RoZuenBnzTDOTtitFaEwiaQt4VKML63YSg30GTFVCEmqA1YEvzetyRfELiYDo2/fI8sktrrlqsuLajR+PFMJwZwiox2Bb2k1pVH86AIRRMpoLEv3gsz16rhhNw7uLodOvOyXITRbwZI7GMwbZrRFTSzUhRdvl2c0hIg1OFvD8T1n1lgNniJoHRI2t+LI6PP4/B6fV6f9jzYcPQOG87hqauSAdWeqj1tMPuxNsYpwtkg0YCtMrRt2Rn5HV+TqYZGw4MghEM5shxIBzXvWLbIWrURJnFBPSsQINq9hirkqid75imUGOC1McS2B/yJw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(10067099003)(4143699003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?WjEFSFm42ycuqUMY1cKvsHvQEB+Z1mlL77fXDh3APZmoEwU8Mg+aET8Hdn?=
 =?iso-8859-1?Q?yyrMfoxv4VjkEParo6wfEhHSY3yPIhbYoON/YF0QDUDE9kLFvWsjOlet17?=
 =?iso-8859-1?Q?2vN7uhrbYcRBJRJEQwGB5yHIl35CkUUeHWrW6BcNiqaI9+4HPQ81GeysKh?=
 =?iso-8859-1?Q?L1p70q2pFDtjB7DvbgnVx3SLH+9WHfewWNZ0MpgspAdQoyrQvDMV5oeb1P?=
 =?iso-8859-1?Q?X1VhifjDNgUIiIf8GIiYhngdwG+Es9sjlXZ8+sw8PM3LePTw/B1sb/Xrb5?=
 =?iso-8859-1?Q?PXmeXOsrXIpaWSNdBWz7oEtQFxav375XTVFOhtXUUi8xnPbZaEBykmpLJA?=
 =?iso-8859-1?Q?VUUuzjq0No7inogWdkRhRJvgMBHqXEcmtx4D+/veKIo0C1xlMB/cHdDJ2i?=
 =?iso-8859-1?Q?geto6gFG2Ha6bxoUasR1FsAm37UmccCPDVa6uqO7PYevRMDJzkjbDvYlAg?=
 =?iso-8859-1?Q?KndKSZyOxJ3AjHaulFo+D4ffHe2Dg4JMuJ35MphlxAgBeDOm7XTVOVI2Nr?=
 =?iso-8859-1?Q?06t5Ywl6sDM6itbfW7cWZT82ESOpuq4E4NZjIPxopdeMygjbwQf9Unvq0Q?=
 =?iso-8859-1?Q?sfNTEonK+8zSYopSBMdtfmuNI60PeiNAabrpo8yxBKR6KJB83G/hLhoyL0?=
 =?iso-8859-1?Q?VAdFq4993SM3/xErn3A2ylvY1F2P9pzu5N1EbdSGt85D8+rPau3BIqUoCc?=
 =?iso-8859-1?Q?woi7wpy3EsRIXyT43XqONMPrYC0G6VROAnGsedA0UPq+d5Va0SrqIHkOwM?=
 =?iso-8859-1?Q?C6/MNYnicb4Amgp+i3opyr71Kipbg01R7ur3eqpe0I5tROefFPDCLm7AQI?=
 =?iso-8859-1?Q?SIP0OPXO2nvhLcM1OJa6nRdIlq2VcxyyOJwp8HDovdSRQ0AtPQZ+OvCtgJ?=
 =?iso-8859-1?Q?No0irWw5zru1ERYUEkvpmCLxCgU1zeFHEAeVepV+oUk9MSsi0/GM1YrA/9?=
 =?iso-8859-1?Q?mCQh7rmFjP0vv7x41JvpqCH9jzo3D3aynF/zp4qyP94NMfxgzeNpkdmp3N?=
 =?iso-8859-1?Q?msMzhScBevG70Hmu/ZTz6pOqitezBu9lNP8yhp/lh5zrlvwAaW4LQ1tJP0?=
 =?iso-8859-1?Q?s4rtplar9/scdbu9Ht4FCQlgWFaUE41EX6ZygLjLg7Oul5CRI7rVCNsm2P?=
 =?iso-8859-1?Q?T2p+TLiJUyrFbF4aCwKc/WielbdLBr3IQprkJgJnahiMll0flrhUBgjxTk?=
 =?iso-8859-1?Q?d/1CTBiMClNtBaBaPMtIgc43oZxdxIb0K7UAWCBr1XLBBouAProO1mzVG3?=
 =?iso-8859-1?Q?nB3HnJ8IsAQm8ut4r9LjYGOF8s9nNlTrVknkiZS86dEANURj2blcMiHy/J?=
 =?iso-8859-1?Q?GT1rahb3+kBXVwARABP3aCucFmu6JKatb+u7hYkNWarYPZ/NxFlXFB/baC?=
 =?iso-8859-1?Q?aoTZd8TitBQnQUU8fSqtcN4gKLmKOUzqcRVxkjiclRWEXamuxAfyIW6XEr?=
 =?iso-8859-1?Q?wDiT7HGmGDNKuLOPlxoZfAIdTOZcLoYJ2xsq3lwSlR3k7la+5mAAyJc7cx?=
 =?iso-8859-1?Q?R3R3kwh6GrwWnCQEhiZY67nrvx5IqksJO3qlyuW25ENZ1jy5Sj0IWU3M8t?=
 =?iso-8859-1?Q?QH+cYceEwOHsCRI7+ROyMVym0TK4aTRb0i5uXk41/6GaGQttY6E5zxz14R?=
 =?iso-8859-1?Q?5Qp+j4MauoFXTMK/64ybzX74bCG2vxfuoClxDAWtRDpaRTFYD2yT8tmaZJ?=
 =?iso-8859-1?Q?rLpW7V/NNZsQxpzFTRMkaEBGA7lx7PAvbJYt+0t9psRp9CGJ1hkCWdulBt?=
 =?iso-8859-1?Q?+Hddtht/q2JbqQh9xKHDrXQ4ZQmkjUi0oFagi2mFJHHPwI7PuhJOdgGgaZ?=
 =?iso-8859-1?Q?BVwoUEBTiCONVSsLyoVXvRf1ZuNx+dFTjdqBVZOAfvWm7OiGJ9SB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a451cd-e9a0-4481-ca8a-08deee713414
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 19:31:50.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+BoB+APohyZAMu8Xu2dWLVgK++/fTd+phVRpib8Kp0dvzlC8WCTtL1klJiIn3B8/aJ0L0+YLeJbd59zk0CfGLHSDre+Sa5cfc6wEhJiguQhP0ockFDPzWdPKLHk/e5d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10955

On Thu, Jul 30, 2026 at 03:23:15PM +0100, Nuno Sá via B4 Relay wrote:
> [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Nuno Sá <nuno.sa@analog.com>
>
> Store the common TX destination and RX source bus widths in a
> driver-owned DMA bus width bitmap and populate it through the
> dma_slave_caps helper.
>
> This avoids depending on the legacy src_addr_widths and dst_addr_widths
> masks returned by dma_get_slave_caps().
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-dw-dma.c | 6 +++---
>  drivers/spi/spi-dw.h     | 3 ++-
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> index fe726b9b1780..2e23ead4a94f 100644
> --- a/drivers/spi/spi-dw-dma.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -100,10 +100,10 @@ static int dw_spi_dma_caps_init(struct dw_spi *dws)
>
>         /*
>          * Assuming both channels belong to the same DMA controller hence the
> -        * peripheral side address width capabilities most likely would be
> +        * peripheral side bus width capabilities most likely would be
>          * the same.
>          */
> -       dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
> +       dma_slave_caps_intersect_widths(&tx, &rx, dws->dma_bus_widths);
>
>         return 0;
>  }
> @@ -253,7 +253,7 @@ static bool dw_spi_can_dma(struct spi_controller *ctlr,
>
>         dma_bus_width = dw_spi_dma_convert_width(dws->n_bytes);
>
> -       return dws->dma_addr_widths & BIT(dma_bus_width);
> +       return test_bit(dma_bus_width, dws->dma_bus_widths);
>  }
>
>  static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 9cc79c566a70..9111ffc5e9d7 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -10,6 +10,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/spi/spi-mem.h>
>  #include <linux/bitfield.h>
> +#include <linux/dmaengine.h>
>
>  /* Synopsys DW SSI IP-core virtual IDs */
>  #define DW_PSSI_ID                     0
> @@ -190,7 +191,7 @@ struct dw_spi {
>         struct dma_chan         *rxchan;
>         u32                     rxburst;
>         u32                     dma_sg_burst;
> -       u32                     dma_addr_widths;
> +       DECLARE_DMA_BUS_WIDTHS(dma_bus_widths);
>         unsigned long           dma_chan_busy;
>         dma_addr_t              dma_addr; /* phy address of the Data register */
>         const struct dw_spi_dma_ops *dma_ops;
>
> --
> 2.55.0
>
>
