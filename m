Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011053.outbound.protection.outlook.com [40.107.130.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E855377034;
	Thu, 30 Jul 2026 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439670; cv=fail; b=L0je4+RNzwNGA6WBncoJBGxEc7J1cbfFn6Sam9mAaVprLyYUb5gOB8vDo3iF2l5FJcBWV2s+C/RPIzVWUmqYFELczxfXuReAr8x5iBMy9z9PBU8d3f+ip1EHIApo4eWyqSflAWCJFT4T5l68vxp7GQg9kUdT046lqbVnUvPUVJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439670; c=relaxed/simple;
	bh=Amett9EN/ZlynyT+AK8C0S3tMAm9d5lM8q4WTGlndyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e7hhvIT1v/eZgV5WhoJEG7d16y0sXiDsUuhtkS+NXB2354aYCIIsV7INFqXuxhC4uAv50NROksdieHm1Awnz1xx7KDE+NjZ0bS5E9s3VlHevWLdAxqLu0Im8qtdDAuTMN4ke16KOgbwVf07KyBH4Sy/6q8CESnK8LMWLE6RrsWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bWFESyuE reason="signature verification failed"; arc=fail smtp.client-ip=40.107.130.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bWFESyuE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enms1qQ5+lU6pePxeGmqNljcNgtn2ctpA4fjOaSKGuyPkusltKQm9uytXkLzlmmtYK4Hln9DfD6XWNlviWHUbAzRiFmKGyHhpw7RtiPwyL+ByS0NuGcMAAYVBQmjgMrcELqt0xkQlcNjI0R62s2DGj9Q3a2qzjTM1eqA4I2v9wNrdYO5Z6XNV0MCQR3yN0mvp8vH3bOcgTQ3qYE4ABz6HurMxG3GaFuBbCMi8pMACwgmpklQbT60pkrSGCTgwtsM/Z2FitumN1+fbCJYTubivzVMvy+B+pWL1JJHXHKVDUBOxcIeElFtHjXgBf85cV77L6Jj+7eq2UshEkuAs94FqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5e7atf0PhAT7/BlRtKWkqKk8KpgpbiLfLvdw2fp7vNs=;
 b=eR82+mwmpU8ln74zjVhJcfynCG3NHA+AugXBN9ExnfNj9msQBwxG0EMqXPBUlmTz9eELzzIc7g66o8UGRldRSs6huSKGM0Py3AN4T8nnsagX427fhLqrNIIlnKV4O3kTLwXX08e31Hb0ZMHcM0AiP4EXpVsYb2r69E9OOlRfDi9+I4bpaca8UfBbTfF/ai0HA1/7AWN0pkGP4bUtJQA2VI3+dVVXHH+qW6Nm/TGOlvxc9P8oJBaVlU3FR4TrxPs2ljjEbhBzkT99FXE/iJOxpe9kQWGNJVcyZbDZqhcKKIyhAI/ViuC3x3hTfGFSd+bCxvm0NkjRNvW4gMzcvKMRXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5e7atf0PhAT7/BlRtKWkqKk8KpgpbiLfLvdw2fp7vNs=;
 b=bWFESyuEJubpi+tIH39zw503mInxaYPLdgEzUhhf1FJ8vSEL5KaUZ8NNKj4R7cQUPlDsQXQr/LzQw0Thtvy1+Vgmp3/bpEP2CrJRLwfycGFvqrRO1wqJgh2OaKLvRjl2eGVJizpEfmcJHeDfhucKbcg5Y/SX4WzvdWdU2TAaXOocJ+Y5+pAc5kXCe1/DSpFCqy2lujM9zYaMpVPshiRdm3CycMsfTEcJ1TyErazL15WhezUR7UIHJCyXItlKXGbWFeSBWmCVDpEcmNPENOlndRdUadedVzk+rmus7Lddu/qAWfIlXToDgCoIpbSr1W42BQVMUHc3qS3T/s+4WMtNIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB11398.eurprd04.prod.outlook.com (2603:10a6:150:2ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 19:27:41 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 19:27:41 +0000
Date: Thu, 30 Jul 2026 14:27:33 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: nuno.sa@analog.com
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 6/9] iio: buffer-dmaengine: Use dma_slave_caps bus width
 accessors
Message-ID: <amulpUfc-vL2xBf0@SMW015318>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
 <20260730-dmaengine-support-wider-dma-masks-v1-6-3732f1f9d9ca@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730-dmaengine-support-wider-dma-masks-v1-6-3732f1f9d9ca@analog.com>
X-ClientProxiedBy: PH7P221CA0082.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB11398:EE_
X-MS-Office365-Filtering-Correlation-Id: 89db8d2a-7f68-44c1-4ebc-08deee709f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|19092799006|10067099003|4143699003|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qmUQikgzPomh96rRQ/gCDGRdi6vAuAFniZ6PCCDQ86qGthE9v/Kfd9fpMGobsXOmcxIseom4mc1vbg+0oRLMVxYeA3oYbuvNTPQWZAyMg0nvUslKpXeCclnPXuFZAwFYpQ3Uv4+4t2A0lKXGkryXBzP7B2U8D3adzz19fQEQb/sAT9ac4wO4VXMQBW+cB/3jAz9zw+anCez8iv1mR6NpIxJCgyUzyDwk/r2Tjfjgr0gKW64No7CGrq3xXg903H6DgMS4Rf39OBskPOT75eNd6TW02WNgwXo9/49mLC57Flo7ng8oxIwTb4kUWLrMX+1UbximL3BWjYgEUYRXqWjfQvtn+W3thV66ROBkZeXnSxS2RP/o6adM5TNlNLnO5hQ/mjwAC7YV6QXLeF9NmVO4IOyAYpiBx8oraOdKANYSXKVBb7eu6LzQRitFuf9EaA4kWZ0Y/4CLMAIoSjTt4JUpcMVPJXJAv7rgdNxxZAnWHAg/FqtC2j5ryFD9qX1WZyK0RXM6xcFaXsPQ1n6IZoaRP9SbX3ZYmFIS2PZt3ckae0QFd/g823QhYjYnH+6pJhxAJ9VD6LFvb7oGQQrzeOfCT47kZ4vHOWuZP8mTqRPPPcPy+FeOa3H+SVic6KISq9Ms5rmakTlab+yqJuuDdvzrytgJb9NXlxkEsTflZ5L+lWM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(10067099003)(4143699003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?LZ9jqeKbtTZKJSyRt50oB3wXQn3GHBnrIFyjLmH9+YfCHTZpWVBVyR16lE?=
 =?iso-8859-1?Q?ipkqcoXEM24GhgIGpGJctY8RMYA57adxfromsdjEL+xywdbl/mEJ0rjOs5?=
 =?iso-8859-1?Q?rhqupQREGu7Q5sdpHzHACnzLD1RXtbiq+CIEag0NkIlAZzxvvLMyrXQRKW?=
 =?iso-8859-1?Q?+GOxwh7YbUBFI/63vGFpRIpACYMBv3LxaN169w0m6ndRe7cw7qg/3xGVfG?=
 =?iso-8859-1?Q?T1LBA/hGrFirRR7+t3p0/RrNEzpTUC7kVBKpLhg93xqdH32ysL08KGFYZx?=
 =?iso-8859-1?Q?8KGhf7ITuRZ6jQoT1OBygcLMZN6vxUQsYWIuL8+8iWzHRnBQ86CQmvgY5Q?=
 =?iso-8859-1?Q?UM4nKjsHVMtcwIVC3lJtWpYLiLQr56dRqhF626xTT8A1iO4txhAKtncpc5?=
 =?iso-8859-1?Q?8D4SzSVaq1mROqW6SkFxtJGtwvG4j1EXmaxJGMXaiscd8sBEkJdbWeT++h?=
 =?iso-8859-1?Q?3CArAusNSzSG8ZwoURKKVGhvRAVR/hqu7Hytr4t7RCl4BBPEyTf3NVMlXs?=
 =?iso-8859-1?Q?3vqcFb1JwnNcknjjYD2/WpttYcMI3+CGChuLr34xDmWg4wG0JM260Eg6Yb?=
 =?iso-8859-1?Q?Reqo1YXQ6gZj7nL++Kp2UTBTmqh86kJpSYXazFvJXdVnoOv1I8j/IT6Xp+?=
 =?iso-8859-1?Q?rp5uVruGa7l1WVVCXLQ4L2pQnd2Eq/OB0K80428vchC+UU59NNc+xciVuh?=
 =?iso-8859-1?Q?tXmUn+dtziLcD66PLKKpDoXVf+Ht12p9vPDXTRX76fUsj5PVzrNSfxwrxN?=
 =?iso-8859-1?Q?IRnysVXw9tpQmNuG5DwByTXYZJaUKKGRKSO2JNvA6gG2mIk24fuxhYF7g6?=
 =?iso-8859-1?Q?CauLuRhqyn8iEkQvFB29OPqj6ydspDceS6/e8bOn5rlz4bTv66xLMOp1nC?=
 =?iso-8859-1?Q?uvVvhZYeNm/5vCZJA59QvZOtYTbVn7PkfZRP1wDW58iNWKHj6Wk7YK8Ock?=
 =?iso-8859-1?Q?/OId/Aa8hbDWJ1U1xefSUK2ehxy6/zdQ1mCao4S3HBL3FRdjDJF5wtLKo4?=
 =?iso-8859-1?Q?MIVf/xQwJesBrI0W+mD9y93+M77F7UOdTHIUpQc4weIR6KBadTCRdVj5JD?=
 =?iso-8859-1?Q?o9HX8FCu9jERLcuVoWFvEPffN79rVBvUmx4BjeYvujmLJkbDY7i/WaxNhk?=
 =?iso-8859-1?Q?txRTYscmZMrjs2tBsGm4cPYPW2ZHS82vb7sZOwm25D2GA401w8bfFLzf6g?=
 =?iso-8859-1?Q?oMzHfsuOBJQAPCFGs7c1muFILnUAt4mGpVhhQsQZ9IiVbaWnjEuf7i0YhM?=
 =?iso-8859-1?Q?3Kt5aEiiS/JbdZmsswP9+b+z8NaSMpNvMldHFKNZ/xF+y5eQc8G0dZhUBY?=
 =?iso-8859-1?Q?vFRQnqINLRaGN2HuDjQVmfpW15Y3aKAgwqH4Sy+gP6xGx8lE1A3sH9mQpv?=
 =?iso-8859-1?Q?2S2zEV4xOZShzla4sMNnXBLbcfoouDJ3W6ZiYh8XtaPYNa3T+u++EJogmJ?=
 =?iso-8859-1?Q?4o+y+4o07d8SVt1CYaG2ebwN5F8r7SYmIFntM/ugiDV275et4t73HMXafz?=
 =?iso-8859-1?Q?MJP5AmYY7V4fMo+dDDYvIYcr88IVWMEvTPuzHbgBn9gH4///cAqI2m48L1?=
 =?iso-8859-1?Q?unkyGTrC1KIjgcRAqi5o7CUN82dvUKjNgsI8pm+N76SHyn3FX0Mdtg0Za6?=
 =?iso-8859-1?Q?3cBu0TWgAhvjHc5D9s8BFvjJ5510YuKhHTNx4gP9a/5uzg01KMb3wMv/GB?=
 =?iso-8859-1?Q?Tljwz8Seu3BGU4MDEr+xAsm2Ajoogbgpgp2LRhnafwad1xj04C1wTfh8gr?=
 =?iso-8859-1?Q?T2s5pYo7mt0RBPr29yc6v9weky0qDdVLR3s3kb+Ioyl4jxqvgMNFW+EV0E?=
 =?iso-8859-1?Q?Cc6aRWgBKDjH7jGxMxTUp1g00zJOrb9kUdJX3pEeRdxpzyIEh5mN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89db8d2a-7f68-44c1-4ebc-08deee709f5d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 19:27:41.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xdnEZo1Mm8TkScJlX2ST0luScP2vKGqabiQT4FTrfMLoFTKqkUcoBTKnvSgmdZ4lf+O1fA+6XIGyYnROtIdHzXlqXt6TakrP+mo6FePDk+JIBiZj3yE8Qam8sj2ZisL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11398

On Thu, Jul 30, 2026 at 03:23:13PM +0100, Nuno Sá via B4 Relay wrote:
> [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Nuno Sá <nuno.sa@analog.com>
>
> Query the minimum supported source and destination bus widths through
> the new dma_slave_caps_get_{src,dst}_width_min() helpers rather than
> decoding the raw legacy u32 width masks. This keeps the buffer working
> with DMA controllers that advertise bus widths via the new bitmap
> representation.
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 98acce909854..855e3662cd3d 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -229,14 +229,13 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct dma_chan *chan)
>                 return ERR_PTR(-ENOMEM);
>
>         /* Needs to be aligned to the maximum of the minimums */
> -       if (caps.src_addr_widths)
> -               src_width = __ffs(caps.src_addr_widths);
> -       else
> -               src_width = 1;
> -       if (caps.dst_addr_widths)
> -               dest_width = __ffs(caps.dst_addr_widths);
> -       else
> -               dest_width = 1;
> +       src_width = dma_slave_caps_get_src_width_min(&caps);
> +       if (src_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> +               src_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +       dest_width = dma_slave_caps_get_dst_width_min(&caps);
> +       if (dest_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> +               dest_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> +
>         width = max(src_width, dest_width);
>
>         INIT_LIST_HEAD(&dmaengine_buffer->active);
>
> --
> 2.55.0
>
>
