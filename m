Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7810635C68A;
	Thu, 30 Jul 2026 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439400; cv=fail; b=hpq6CpPrsz4+O0lbTQbAtQaZJOhQdiIoBodKHRjS+qoC0p4XHfvRugmllGYSyWBA/y/YNJOK/pYZNtsn8SpPlyFCVX/3LPKQu0ovFLyPF1SpfjkYamU6Rellj2+zh1lCDCSdVmGGGPffoD5zj6XAyhnxfRXMmzVs0UkC/J9YhEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439400; c=relaxed/simple;
	bh=RGL6YJlKRmnJUO6F9KKj3SS5sSQnDsY6aGk31wklYnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=khm/LJXM1jaym8Vq+uQB8RODic3iRlOaFZEzfP3pIneaXnsftOYjaHcUIhb/P7aktEbcviM9OluJsLHBNHB4JHueufZ3DXlNaPHgrCKbHgw6/i/dww0jLWb7youuo8tjx5qrgGQbbruuJG4lkyqTrqD1+xbjjXDbLKAe3Zykbbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oaFSsBTH reason="signature verification failed"; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oaFSsBTH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5SlYbjfcBqGUChKIVJOYV4liPxq25mz1V0yuJc7Oji0qVNoHf2jXvL+M960/+I4xfGmHEF/6raX11drRwpuns7NHWBkssWykGBs9GBfmJ+Obn/7CWExuV63MyXyB1yi7KdMWcB/KklCZaz4eP33Nigip5/j4AlSiJXX1AMslSODQHsCrK3CscwLqjBdq84oGvMeXLI9o3m5cl/JUfgApgJa6kBnBogG7VMsFcfVilPKF+Z6Gb6KDeybfwhO68XzIN0zHMELyZbohNF3YH+6Iv94iuPQuUx64N5pn7Mfg+L9GmkYGzCgB4WWZKLdqRDg+xO4+usBxWR700hKBGQIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W5AkI/4M0X+6WToOOXn3CAIhGhtyjL2DOq02KdKFi0=;
 b=mzhEhZLA/YszyoVQMYRa8sgSBMVOrSSpEE/EhAhQpwXFHdid1xKchExNHULLLPoM2qeac5cR++FUFd+g4ek8LMD2G8CcsrM8nx93sl9dUXKxhS6YNUtodSFe/Q5KxXyg5UznelUTfPhKtQ03Z2BlnCnz8xSlc51HoqDOtEp0B54lEXyBhu8w0ql42iqKFtK9gzi7Mt2/Qtu5SG1Mku2U2GUI/klW2wFojBNAciA4UrkHp0UCnyX/6P6/sJtC+jzFlSzMgVuhzFpoSWVo8xp0j0DKzAbI1NNIc95Pe/L3hOHO1JJs/flQDL0OqNmaNam346xNDyWXsQr/TmupCwFF0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W5AkI/4M0X+6WToOOXn3CAIhGhtyjL2DOq02KdKFi0=;
 b=oaFSsBTHdeltC+3sXPlnGvHta8qnoOqSyKaGhjlYn0XAelVbKAlR3BSAobhBRyyDL3jsb6pGNjJYHtIyVUgx54+COu4mwslP6FmKCFHo3TUzvvVaq3hoJiQlgR5lf9IqmsRRn0ojo0caXFcHhZoxQnah/ROSPeREMCoejNwrXhfAoPJpxTEwZm0+JWHBO6Qd/gLSatjKGDAU2IkIW1Os6KuH87VABSJILfzJlXVyeTJk2ofsgjgpIsChkdr2lR6hcvb4FyhRgiH+3vELtNICzsnunmuFI1Y/9ZYMfZ7+PSGWXX+Ou5Q3L1C+2dYQG6+7lnrwJrhxXpRS1f4uJne5MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB9317.eurprd04.prod.outlook.com (2603:10a6:102:2a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 19:23:16 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 19:23:16 +0000
Date: Thu, 30 Jul 2026 14:23:09 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: nuno.sa@analog.com
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 2/9] dmaengine: dma-axi-dmac: Use bus width capability
 helpers
Message-ID: <amuknWF-B6OZvf9i@SMW015318>
References: <20260730-dmaengine-support-wider-dma-masks-v1-0-3732f1f9d9ca@analog.com>
 <20260730-dmaengine-support-wider-dma-masks-v1-2-3732f1f9d9ca@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730-dmaengine-support-wider-dma-masks-v1-2-3732f1f9d9ca@analog.com>
X-ClientProxiedBy: SA1PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: a5dde280-32ff-4896-1533-08deee700131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|376014|22082099003|18002099003|56012099006|11063799006|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	x5ftZ1wjK/pwsR8A/xXhofGl6UqLzABXWgER5TAJ2vpNK06mtCB2gm7SnlVE4wCZReUv/bDwd15Og9SrwV/e9QtpOMN8qLpq1EZ+K0x4aFNv/Xj4QCro9APrbeR8F5EcM6dOgiAvO7RIYzhL/sggOrM1y86ibhUIMy3RitftTkxH5mHvrGQ87JEPjaxtdRAvGjBMIGdJTu2dytw8lwDetPMGiOFcfqhwgB1/cjn5b0HmA/+Yr/SuH36RPpUmHVPOCJ8QTxp8VkZpvKR72hjoVw/zO+WoasIBiFGm1vZBwMxg7N8Y5p+JouOxEdx4KkjoETHIk/DhsnDXPgnvRCeco4J0j8lWpLoLpVkDUSNFyCaY3CcTLjzG+sdQ1tjTWu2gh40s8BI2E+e0BFh2JKuF9GjWt7c/hXj0Skb0eGvfFASpH4icJf+f4xTRCuV80zrba1AgaYbTuHVka8DIlqBVYcI+vGlY2f9BzBKZRgHTUMaP773Nnx/cqIrhYcKGjr8EoHLX5V7AqsN4Uv3+oZjfd3YxXlz0uVkfB0iP71tueqU7gTmq5ghw3Ga2UhXuhGOo6oCCV/vXfs8F+JxaUcV1cBXApNqxUmK1yNxRFzcH+2WxKNp88aeaoSkns5BJ/lc3FP8FXd6IgNX1ZwOmoYVBLbpYxw0HRZaejmLSJm4OnaA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?YGscnCXixMCSDwcPTGvXliPMncNQsDNlOtApA5VHu9QM7NVLb1vSZNYFxk?=
 =?iso-8859-1?Q?1B5it5Z6UeoDR4Za9L14SogcSz3nci1uapICm7fAwhJqWFmgKYmLVK1Mp5?=
 =?iso-8859-1?Q?xfkgnK96khJWc19prXK/OYpo8UzAG/KaglKST5h/Ia8j8i758cCIvRFHdW?=
 =?iso-8859-1?Q?BRlK2NvpTfNyUFcMY5YKITYW4oXMAZv5QHjTwmQJJIPWzTXh7oiL+gu9RD?=
 =?iso-8859-1?Q?aMP/gTdHgc+go+sWO4wIa70Nt+kMdlm/fFogYbod7mNxjSrPcZhE/LaxWf?=
 =?iso-8859-1?Q?6qVy+L9uZL+r0yxy4mlQHFvN1/D2mSPW1vd+5YKhTc/mW6B3cJHRmkyQ/P?=
 =?iso-8859-1?Q?TY0YhNdmmI8r81vpkQEAhuWn9OPfaogxB5+LTCzF0K4+7hdbserGZs8d2a?=
 =?iso-8859-1?Q?L+sMs3um03DqY8GTILbbA48M5L5QoVUOVJFupuoZq9AxxCXpaeu/2MKCUW?=
 =?iso-8859-1?Q?dntU50HfTqrW6gHUibHUgaK45kkF3mrzjnW+r/38cZ4XWgNYRMnIjdXWwz?=
 =?iso-8859-1?Q?3noZcZ6K2Luxd2Q46ThZfPAIDt03opzFu26GFV4uVHmBcioZ26/1hmHwic?=
 =?iso-8859-1?Q?iwNFEjKF10WZ/rDAOdqsfjMRI9W+KtZiI1J9Ckh3rucL6rLhgVenIp93sz?=
 =?iso-8859-1?Q?6b1RQZiWoDgFpwWsbI40Q68cKzFHtzy4ugcmH19YIfkt3Tu5oCQJkqAYz6?=
 =?iso-8859-1?Q?us5Qze2f3En7IjIvvwBsWVagCVJkgb/fJs6HKkJIS2X99eY++xlp4xY1/H?=
 =?iso-8859-1?Q?kaC7GF6DIU7laWkQTHTzGZvXZnQzclcXVbKE/5RXIUVA1KSY8n/9+syGDL?=
 =?iso-8859-1?Q?jwLMJw9sMoFtxmFCT/iLg4hbZJASeStWiSJxH5YSqxS+5aHIq4KgxKv6iP?=
 =?iso-8859-1?Q?O87mL+etmkawOcSu7iDHqhpzgYNFpJ3zJJjx4JLQMkNuM04MEHsbHgC0FQ?=
 =?iso-8859-1?Q?x9ef9UeO9jvGLWUunN5Tya4vp0JILXzX0JjdE9zFo9A5qqiwrhyoZEh17z?=
 =?iso-8859-1?Q?6iEuayVteM89/5fOeuANA2Img6yKGFtnfg5zlPxqTQF5lvCdXZF9dJoyoL?=
 =?iso-8859-1?Q?y+4uVABSC4TmTfR5eEOj1goMcgOrL5uCX7ibYIHVVMfR47o0XgFltchzo/?=
 =?iso-8859-1?Q?T6Dw2+MlVdZ+WmPBD5kQ1LXa+ufWL3hovJs0uGSK8Kw8A3/DjF1KgYRCLu?=
 =?iso-8859-1?Q?GvoTxPuUmECZkPWxI/OA4uBtpqai9OXjmpml2PWyr/nOI5oZU4athwTHz5?=
 =?iso-8859-1?Q?FtOxJ3hXbwOJ7hrZaobnhFMRIhQKKmW02DMizt6tNh+8VOwRpbMYCWa0b4?=
 =?iso-8859-1?Q?PTYEIg1+xD0XeUJu/PJRBox5aYhFRS6KokS3xT0kfrHnuKCa6GfDm3A1mS?=
 =?iso-8859-1?Q?frqJBkIIh9C5CHpuxIuaMUIs1t+pf2XxVEzaDBMk+qCokwEQZHt7wCs7Gl?=
 =?iso-8859-1?Q?D4xk+AZdQnkpnCoQsZMoUUjHAWVeZlg//lyZOa/yvWL9Iz09Yi35IppgIk?=
 =?iso-8859-1?Q?i0TX6YRl66trbFYW+2wbFrNoL266WmDTmkUYlVqFNmoVrlfBpcp+LgbjG8?=
 =?iso-8859-1?Q?hIveNEglvpZ09ytt0hbFhU4ZfaF0XkjnXrDuYKpHUAsWtYEZr5wRD4J5Le?=
 =?iso-8859-1?Q?y62r29L4dLV+7P3UR4GbZ4qbnt6wNWqbqkLT8m5VW76yj+l+D2ebEFegqr?=
 =?iso-8859-1?Q?k1/GYaFhMcsCQxfg9qWxYTDUtwMV0EwscNMtcRiMsUG+itvokvcpUwdZHx?=
 =?iso-8859-1?Q?ZL1HhwQzzECJlKcYZhYRSQmN724wY/f+c96PWtDM81yhswdgVjKVR3bLLf?=
 =?iso-8859-1?Q?Aq06oTKJHdfyqwoZ5+3LiQD1xHOEsOta6u7O/955G6e5iTHv9DJl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dde280-32ff-4896-1533-08deee700131
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 19:23:15.9923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4TXuyequ3pKXo35704iqnY9JsA7vUeVtiQ9xFtSWQ0Esl2fIPJYQ1XlHvKSV85Q2DUgWt6HRZbokKsv47TDUW4KgQtUYzk3LsKVPdWdCnZ9i4MzEyOlnEjmQSbyr4Ws
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9317

On Thu, Jul 30, 2026 at 03:23:09PM +0100, Nuno Sá via B4 Relay wrote:
> [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Nuno Sá <nuno.sa@analog.com>
>
> Advertise the source and destination bus widths through the new
> dma_set_{src,dst}_bus_width() helpers instead of open-coding the legacy
> BIT() mask. This moves the driver onto the representation that can
> express widths of 32 bytes and above while keeping the legacy u32 fields
> populated during the transition.
>
> While at it, give the channel width members their proper
> enum dma_slave_buswidth type.
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dma-axi-dmac.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index d47ff27e1408..26912330e3c8 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -152,8 +152,8 @@ struct axi_dmac_chan {
>         struct list_head active_descs;
>         enum dma_transfer_direction direction;
>
> -       unsigned int src_width;
> -       unsigned int dest_width;
> +       enum dma_slave_buswidth src_width;
> +       enum dma_slave_buswidth dest_width;
>         unsigned int src_type;
>         unsigned int dest_type;
>
> @@ -1262,8 +1262,13 @@ static int axi_dmac_probe(struct platform_device *pdev)
>         dma_dev->device_terminate_all = axi_dmac_terminate_all;
>         dma_dev->device_synchronize = axi_dmac_synchronize;
>         dma_dev->dev = &pdev->dev;
> -       dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
> -       dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
> +       ret = dma_set_src_bus_width(dma_dev, dmac->chan.src_width);
> +       if (ret)
> +               return ret;
> +
> +       ret = dma_set_dst_bus_width(dma_dev, dmac->chan.dest_width);
> +       if (ret)
> +               return ret;
>         dma_dev->directions = BIT(dmac->chan.direction);
>         dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
>         dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
>
> --
> 2.55.0
>
>
