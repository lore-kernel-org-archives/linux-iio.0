Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4617A3B7B68;
	Thu, 30 Jul 2026 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439836; cv=fail; b=At9Y65Bf8A/veeFISL8iHVmelfL9gk4/Z3UWaehMSdTpghbaSwAOEzLxUaveN840y8FuKcUjnO95pn4zGQaeF3KtQv6Xu8CNnP8SnPyUJziNOU0oI1hAhABLRtqWYOdn79gUxGTeJGCcXSNYWxw+/lQfmNCO+pvVDJ8j82I20p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439836; c=relaxed/simple;
	bh=RvhZEX1dGVEYpof+EvgqhgEMR/i+nUS5ZmyB5iPz5Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uURkG8dyD5ZKco65BFtnoF1t79CJxMIFrmbhpWN3XLu8h2a9fJYHfwPXedylhOCVFqD4NJi30T9raxcQBd62KZz8JxctGGDG3p5OCOVrxSIRrFRsVzcEFps5D5RmkNN4Ckw/usgPl3YaYv//QxjpFrWAxRJY55VZhj4Y5WKNzTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Dj1Cr0Ci reason="signature verification failed"; arc=fail smtp.client-ip=40.107.159.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Dj1Cr0Ci"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEnh527BXrA8cK9W909VBOVthO77jAFHLKjhgEINGCc+RELn62lcxTPrb9t9dVN8RHYRDUPj+nUULFajDTce9oCJct5ORhO41sLC2DRBf8eUYDR/RZv7kZiJuh0MeweOP3z6GYXxTP81RLXfjO+k73d9zo8rRDNaM0QP8rwaB/R3rcx0IfxYd2VRhrLBB7GvX8xCFxMoN2GO0bh7RqkEMxpZxIu6pw5TOmwIeO4s+f8Jm0mDN/SoF52AxtCZoP9BBkz3vGGtugYK4bRrrgLJKJ/Uy73yiEcB2zgn4cEzPFsjQwNkAUOoV6MEA1+mk347Afy2HaJT05A1GJy4TepJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=burWcKbmVQgIFFkfKpikbvTwJvY/XdiDz94ITFPYYzg=;
 b=lRhqy7XOJmlRi2aBunDHliUtC8O7iCWPbEsZB4Hqzn3reMfeSPY9WYN93aNEDdp8AdQTzUXA3HXlJ11YJKwwYm2TdRqTkUQxEXdEVkLxA79LIYKPFcdHkUOeHvoYBhTW0UqWjqA9GttiPznV8bmS3nNqVZWwS3J+u/KJgpUGATzjuMrK1ve9LJSi8IfUBB2hNiWXHyQUkh1rGab0aS1sAV2ybuMf4Ujgab2CKOlX2xAQTgGqb52KB1/XsTpIGQtKG5TnzP2rPjr0hwysibB57PDYgrcgzxk+biS/xqaW50WATEWZ14M/3GRQ33uAAw8xX4swu1hPDA1yvzCXBex8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=burWcKbmVQgIFFkfKpikbvTwJvY/XdiDz94ITFPYYzg=;
 b=Dj1Cr0Cid4Z/P7RhxjrefYX6stxyJ50osIDU4SqPINoTzuAca7Zl1mA40UD02bnp+0Y2+bcK+ExjDChXK+rGJh93iw8RNwgZr1QFfRolNfsPGFAWMwNI8aPCnDWCKZ+vKkBbYJdUrfaLEEIzcv1vuZ4Afu+pv16Lk/0N44mXyUoCsspUjTA4rXoMbWLl/HBBxrlrSuiifIXmnhdx7K/1TxBDbIsR/TdwK9tDF8ahIvgG1ZJelF9DRgtG8vJ0Qel1/Dr9zI8a2OSeOuvioS4XHY+VZkm3rg2yIkxFaAN/WAmD2i6Zaf6mhcEiOcvdhRk/hHsqHnXHRkhe98QzVkLBvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB10955.eurprd04.prod.outlook.com (2603:10a6:800:27c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 19:30:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 19:30:24 +0000
Date: Thu, 30 Jul 2026 14:30:17 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: nuno.sa@analog.com
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 7/9] ALSA: pcm_dmaengine: Use dma_slave_caps bus width
 helpers
Message-ID: <amumSQ6dUoWnkg_Z@SMW015318>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
 <20260730-dmaengine-support-wider-dma-masks-v1-7-3732f1f9d9ca@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730-dmaengine-support-wider-dma-masks-v1-7-3732f1f9d9ca@analog.com>
X-ClientProxiedBy: SA9P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB10955:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b2c8ac-1849-46db-ee5b-08deee7100ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|19092799006|10067099003|4143699003|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	X1l72ga+wgDFjdsJLMjp38oDE6p2ISiGYiqbfrASAcafDKWdZvDsaluAr9jv/gElibIggFPkPWP9N1vTsvfSedAr+sK/Z/3DbS2QppqhnnZXvOc+M1GK1s7G35a6gVgOuk1AOHORBG673sCRP8XCe0ILxZW2f4gxClmCc+ZpboeL6hpNzmC2xGIjJ6vlwY4GiwYRx64KQ0zbM/hz/6YK/dsUQimqRgPs5nBjt+ESaQkJEGSV7F23AzTLitGPMt5XwVVFeMBKSoeVT/8/eTgxDzunI6Rm1ux1wazOGWrV6CHaelqDCif7ETD7VX6m7O5K02mrvEhrvn5z93/DI/aoHPrOlZwxEGui9ABBr2rhT0xt3LMJqGVIadGmKLjdQBcFPEXHVtJftIjlJbfCqqZMPOj04jcH5LZitS6xTjyrhCfJ22rQMZMLGMxOex3TJm0d50Q+iYM9qbNtBln0sT9MXagNcpF//NQAcUJJnyE8SpyOVO1S9F4Ky7LflYikLmualRs9oOU6VZiYIKFEcdpnMr9Sb7lc3+VRN9cAcAbNgYdHfiLMPaUUOansDZSBXJ8ZmI696hTg0gIhZCvpZNv75qD5Q11zXhmXYh26UYEbGpTnmdL51dDZdHUPrjzP1gXgim7eIDb+WyJjK0ryejl0LwSglCZLjdvG6pRSTgqvkhs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(10067099003)(4143699003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?mg01y1WrNkw/uhEi6WTFhGHOkVfskiidjSTKFowkrlNDYJleE+kCROgQEJ?=
 =?iso-8859-1?Q?QCiCY77tJy7vv6XBWGuVi9sGA10XhBP1bmlUF6TJso/obtiUC2AIOZCNeo?=
 =?iso-8859-1?Q?BtD0xD+ijAMR3D2GY1R9XHjBbejKCAMHyCyjWWmKoewaYg1YvWTjDaq6km?=
 =?iso-8859-1?Q?T72WNRSIIstgTgxSbQZcp+/DRWEV6VRTyvUHK7eRWxfG8sLLk3vyJHB4s6?=
 =?iso-8859-1?Q?X5Rf4160dWT5SWJNjoZ5X5murxyybJ/jpSBRf5BdhUoQB1j3Auvd446LKV?=
 =?iso-8859-1?Q?xGQqNb3nUt0KBFV7ICO57Z91QnPQ35y+nxVNvAx8Ch2PccqBPMaIMNffi9?=
 =?iso-8859-1?Q?RZglk6HEhoFyD/isttibyRJzyPiMkKTFAi+ZbzhAV7jFhgNZ5/ZndGJjmV?=
 =?iso-8859-1?Q?0JVfJ99SWBzjlguhDFByRnhsANaIVyxUBctpvCetT18OEd5S60D2PWFIjr?=
 =?iso-8859-1?Q?sahQMncilb/1z8nXRFLVwF3txYjHq5BCwPUdNDTY+UZYyMsRLJ8QyTzOSr?=
 =?iso-8859-1?Q?tWmsfj1xFUAntSVWlNLuWKlqHpiDB7CD7c8NZ2redQCHrpPnt3gJE7MIie?=
 =?iso-8859-1?Q?qxa18+TauF7w+Q5pqT+WrgwBbllss3bCVHsU8o9TaUyQUHNkgG7Vd9GkQ7?=
 =?iso-8859-1?Q?xAcGYK+N9/Y/XB7LFxJNySzqq1sxVPY+2ZUeKPnAPaA9rgM/ncG/yV6LiS?=
 =?iso-8859-1?Q?Owm2EKBL57vriwA5HRjq4sPbFye724dqsLxgik+GPnMUkMlUxb1yz4xT5M?=
 =?iso-8859-1?Q?qCV8xRajhZ0vIVnMleCj9iwufj1O+DK4UEFYElca1AMKKj7EX/2HTxxjMf?=
 =?iso-8859-1?Q?1QEs/TKjgG581RwQOEgJk6OSXccsummLxrvkthVE2io6dWIYY/aH3t+9Sz?=
 =?iso-8859-1?Q?4l+UnEAmXdXRvNa8O7kvWYxefzPP05XCmSog6y/Ylv4o4o/KxMPv9j53TQ?=
 =?iso-8859-1?Q?8dGRhLyeDXatz/4IdttpoY6tAuZnO5oZWecX2zAqnOLJ3SYDM3sa4szI6N?=
 =?iso-8859-1?Q?T42MTlCh5fiVtR3xLj8whnKAY7mZmJ1OsSZHMRymc9vImGOmVOOgUOQv+c?=
 =?iso-8859-1?Q?LbXj6HOUlhk8NjN+Fo12MHa/cdFubevsj/VBSe652Z7r/q0nKDkOm+BU3u?=
 =?iso-8859-1?Q?BEofjf1DFd2PEnjQXuudyJ6octcZmyGBrCpNNNhdjiCpPrUrEl/LyqncBa?=
 =?iso-8859-1?Q?uDeIVDc4d8uCq89pry/NL/XsnIgmaYaexZTG5l1Z0zcKtLG4qosupA16OR?=
 =?iso-8859-1?Q?fKd65Gw2AQvFLOPTojj5cMfgr19DhcOs7vHJ5/3hu9UMj+48uzNt9CjQOX?=
 =?iso-8859-1?Q?6EHUrd1+ByQ+YLmjXsvrHejrtQT4u7QXSwhSVwNz+RuXdcMzHLeqPQuNlN?=
 =?iso-8859-1?Q?F+roonc/eO6Uzbp9WUNAeRfRKt2Sf2DCX4xlkogwjy2UzxrRFU9XtfaKyb?=
 =?iso-8859-1?Q?66bwCNO0QyobLNKcjJ9TUheLpQs7N7Ar7SAzar9+bwp7/I6qsw/Fd3Ypfn?=
 =?iso-8859-1?Q?aMn5/pdcETEdKdTybumRgO2xID8ViSl3Az8a1q7XfnIBLYGUh0zM3iK6+2?=
 =?iso-8859-1?Q?18w4z1h3sESaKXSPOuZ+qWCAa2c/kfi8RfG5jAboG/mjatfA+/XBAJqT+k?=
 =?iso-8859-1?Q?M3JRLwoiNRxo2GHAuQMftEYQpAJh8HFUzIx4JB+Z1MOLUut18TnS20At3W?=
 =?iso-8859-1?Q?Gm4v4bt+mdH4fF39x6aV/GlGj60PO9YZ5UN0yLhlk4OT12WMIioVTk9HLW?=
 =?iso-8859-1?Q?qBDvR6ZfOgCEWS0r0RH2m5tyu1NHp14w+tWdk+PALM/fU6HSJMA4wStReZ?=
 =?iso-8859-1?Q?eK1BwQPPUOxDWsBO/53uTlOJfHoZ0IaO/amKuZcL+4PVk8PMRUPP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b2c8ac-1849-46db-ee5b-08deee7100ce
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 19:30:24.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8667jIinlvZbaAm2yvJQmqNZ2Qn3xK2tKNVaP5ujpFFTkvjPb3756Iwo2Hz+WW22C6YUASygGvzdRugD38XaEHZ0eiVOjtI6auamz3M/RMRDJr9vZwGC3XGuZtI3cRJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10955

On Thu, Jul 30, 2026 at 03:23:14PM +0100, Nuno Sá via B4 Relay wrote:
> [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Nuno Sá <nuno.sa@analog.com>
>
> Use the dma_slave_caps bus width helpers instead of reading the legacy
> src_addr_widths and dst_addr_widths masks directly.
>
> Keep the existing default assumption of 1, 2 and 4 byte widths when the
> DMA channel does not report slave capabilities.
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  sound/core/pcm_dmaengine.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
> index 1306b04be171..37468f4643bc 100644
> --- a/sound/core/pcm_dmaengine.c
> +++ b/sound/core/pcm_dmaengine.c
> @@ -409,15 +409,17 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
>         struct dma_chan *chan)
>  {
>         struct dma_slave_caps dma_caps;
> -       u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> -                         BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> -                         BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> +       DECLARE_DMA_BUS_WIDTHS(bus_widths) = {};
>         snd_pcm_format_t i;
>         int ret = 0;
>
>         if (!hw || !chan || !dma_data)
>                 return -EINVAL;
>
> +       __set_bit(DMA_SLAVE_BUSWIDTH_1_BYTE, bus_widths);
> +       __set_bit(DMA_SLAVE_BUSWIDTH_2_BYTES, bus_widths);
> +       __set_bit(DMA_SLAVE_BUSWIDTH_4_BYTES, bus_widths);
> +
>         ret = dma_get_slave_caps(chan, &dma_caps);
>         if (ret == 0) {
>                 if (dma_caps.cmd_pause && dma_caps.cmd_resume)
> @@ -426,9 +428,9 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
>                         hw->info |= SNDRV_PCM_INFO_BATCH;
>
>                 if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> -                       addr_widths = dma_caps.dst_addr_widths;
> +                       dma_slave_caps_copy_dst_widths(&dma_caps, bus_widths);
>                 else
> -                       addr_widths = dma_caps.src_addr_widths;
> +                       dma_slave_caps_copy_src_widths(&dma_caps, bus_widths);
>         }
>
>         /*
> @@ -460,7 +462,7 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
>                         case 24:
>                         case 32:
>                         case 64:
> -                               if (addr_widths & (1 << (bits / 8)))
> +                               if (test_bit(bits / 8, bus_widths))
>                                         hw->formats |= pcm_format_to_bits(i);
>                                 break;
>                         default:
>
> --
> 2.55.0
>
>
