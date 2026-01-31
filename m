Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013022.outbound.protection.outlook.com [52.101.83.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C8533ADA7
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769876942; cv=fail; b=Ml+EH4F1Ru8nyG/3j522xIwHLxCQFWGbqlpPfyLJRZO0InumDV0f3OR19eRxFFbTuo9gdAKw/deR3PYDkeeaEZKOSsL0Ob+oQEEVgZ6+D9kRwRiMglWydig87xuuV2fl8610fwr2GOWHUrVZz6WqPWp/XME2b1XphsaXbnhu+/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769876942; c=relaxed/simple;
	bh=CX1NXzdYKCZaZonkTLhKlktElNJz+Ukv6xQhH6+Pw1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H34S5CVlybwJ00rJvZ1t/7AwcelhiHDv7mCoccUtgWkkcl5YFsqxoLcruKMsMTxI3pOjhspeXdLllbuOVIpceAKp202/bpnVgGNl8S5n3hEXzBRTgHLYk6M98Fu7PpERcGj+81HyaiCJ0EfZVrNUYRrHBLCymyoZv99T1dYqvkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SrQQmSKN; arc=fail smtp.client-ip=52.101.83.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SrQQmSKN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJvtwpjv4s0TuFexz5UaXfmFxrDqB8k17se4yClA7AYPyw2w8cGbdWKoWqSP3G7GGe/uzupspXYUHQoIgBeG6cRZ+e4IiI0toMdn78mpMWSYzWXc/pVxW8CFEkP++G127eQlGHKUh1K8D6tNkVsdCT/2GEEFktAIi03AyKC3Hfhir0vXIJ+8WDB5sUz8F4CbFkRyR5W6WCgUngPV5yriy7vkOCk39EJgJOFOl+z0zevftZz3+oci6peneHdUbR6i+HJrcaN8TNwsTaF5N/4gPJHdsdFBx8z4xSqIu0YjOeM/zNQoM7+BQRre2MkI+ROadgO97Xxt2ApbfKG/MUxGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjiPMBnPfTHRxXv1Kk/gtOoq48R9SKnVXGecdzklgbg=;
 b=vicLNmTs6SjbDEOfqDmnwkuUbBglYfg84GJkZnfmdIKnfx52fJ1ngRWZrcVWE/9BqRl7pEC66TOWeX4HJbWX+3mA2seGsfZg38qPQDB1/rvMo0T7v6BaHazw0n/ELuIfs4N4a+WeSBcGqMpbFnj+LZ4Vy84e+pGEF6WXNtWToKPpcatdZxTFYR7j57mBfTFIfzyVeFOGA5Uh05c/IeHmQ0/L4Zgc4HeA35M2FEkD8Q23NRwASDqLTzaASbF3AtBOLbKVxQ3cYpTsvgRfslq/T4B7qSAFl/ePwUx6sSGf90pZjj+FIQsOCJuGIKBuuqObqR2tq32MaoNSN6ee7H+tkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjiPMBnPfTHRxXv1Kk/gtOoq48R9SKnVXGecdzklgbg=;
 b=SrQQmSKNrNWh3pDgO+EHRPNBxcx1g+hpze/SnU55cBGIHK3XWIVCjHl731X1PuDRMT6kgjDTR0MATzIz56bBeS8iozwKSdFV+OpL9OXJJsP/UWHfbBGF6hY4YLONaBSyDgRknINdRGM9leC/ux2Ww4ytdEkIkZI225rdwbXDYHCW2WJWNXhhz6jgDJ7aEVbOcr7AKxl/JQUxHN+2jpSiB0bR4/QldAYz5zam8PhEhBt6DWEV9Jd7yoJBhrCPdgBJFALvtip8bFVU2mV5mvbonzKaMzY9b4Pv8vYU4AtnhZGr0DjySQdqSq+2sCAg2QRHPVRzbEWizMFqKdsxKQvjFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DUZPR04MB9872.eurprd04.prod.outlook.com (2603:10a6:10:4dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Sat, 31 Jan
 2026 16:28:57 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Sat, 31 Jan 2026
 16:28:57 +0000
Date: Sat, 31 Jan 2026 11:28:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: magn: mmc5633: Fix Kconfig for combination of I3C
 as module and driver builtin
Message-ID: <aX4twoTb/BOvBzik@lizhi-Precision-Tower-5810>
References: <20260131123901.227952-1-jic23@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131123901.227952-1-jic23@kernel.org>
X-ClientProxiedBy: PH7PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:510:33d::11) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DUZPR04MB9872:EE_
X-MS-Office365-Filtering-Correlation-Id: 993c76dd-adbb-4148-4a24-08de60e5d529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SG/6PCNBKV8CjNR4ZxhWgxQT0NSihetOsI9A7g76UdHXWEe4ttE6PXSIABps?=
 =?us-ascii?Q?5CeeaXNe+gLKXiAXjD7NlMNOigLMBF0tRI9dm+IbyVkQ+SD/4JFlqRZzAnfj?=
 =?us-ascii?Q?yn0kPKFS2xsFrmaGYAQ9nieKpB5rBF6k34HpCu3aaEYcjgtSZlmpvx2sGigC?=
 =?us-ascii?Q?/C4I49uTZb8Hpa6I7xt0RJ69lKYbEaesTpP/1MnPLERO7fktZWc0ifLinHXI?=
 =?us-ascii?Q?auTZlMNRzVZIjPobnUlZaKIFKMgdoOebj+xli3WYf9Ne9wUc5hFFzj8iCgvB?=
 =?us-ascii?Q?IMIdDBi6t/zyZihSIHiXSNerol6ro78JT3tax7phyeiRhD/7TbNsfzSiJpx/?=
 =?us-ascii?Q?H//xfyWkzEiovTQnp+52IMJ4hRvPwZijsyHM+E8z80u0DNc+EtBNSdW+Ofbc?=
 =?us-ascii?Q?GrAQsq+BiQjXItJnFwTrf95LLDvNbvqciObV/jsKLl8J5cbqvfOq5+/i7Kzj?=
 =?us-ascii?Q?QEIEuCD6FEUMVqtJcY36NeeXAxZinywfeD7piraezIj1btCRP7ZXicR01R+z?=
 =?us-ascii?Q?B1gx9nC8uhql+YYW25s9klWf6nWN1xZrNnfqpdxQINoTf2sl6KtmwwryZfrX?=
 =?us-ascii?Q?RUIUYFGXVwk6qA24CC55zbEQ4JbdF2HHnFyKTH3NB49GDuI7wkuXTI+Zx5Tl?=
 =?us-ascii?Q?YnxJx+yYkzPfTiO7k3rZsCJMa2eG6GTfCFvhjDiQD+84pcQlsMa3xp4IPZHn?=
 =?us-ascii?Q?4l8+FWeUmLojOfxhalk3VMjX7/XN5MDax7X6ILXqEhGzHdk0p1jT6tQFfJjU?=
 =?us-ascii?Q?LB8LZX40/iwpw1vynl7KGtV8z0TFdtMgbZM5srcCxYnpS0dvRXxtkQwJ3HKw?=
 =?us-ascii?Q?mrmHw71FXXMYBuSmNdSZuAD0hYAxvtEQEpZTC7WKaweVWQGqJfyjzVwxjCDp?=
 =?us-ascii?Q?c9E4UngrpKc0Hd4KK+Cz2/cu4jRbVGB6NlG5kXMrIzLcEinoe7G/0coRcDZI?=
 =?us-ascii?Q?/IvNFl65/quuQjx81A9q5joofLviVYflRpzNsoUrzIx3jB9XJjYFkAZ1Wxzh?=
 =?us-ascii?Q?0Y+4PNNbz3CXN1ldSflj2SNa2qhUV0dIxNjFFD8Wkl4VxymywfMjrjBLW7R7?=
 =?us-ascii?Q?JTBHTfofvvRs7HQKFKnHRpT9j+S9nm7Kq80zlV+TwJYMMFLI4jxj3N0T3lRI?=
 =?us-ascii?Q?rSd2FDPxWJ9ep2tCEB0gjH4MGOWRASX5dqtz2R0agz119ZEe3mDXRSunf8LN?=
 =?us-ascii?Q?uIbuwRUTe45LE1gIdSk0Y9uRqwIvnt3oGltjVQKYqCrUzj0mXYcYBQYQMvfp?=
 =?us-ascii?Q?JXbOOxGQmRXUjBLROUEpK5mpn4QHxh01EwkZL0DmNf8W6Mo1Bl/mifVHkC8O?=
 =?us-ascii?Q?2tT7OR1Jyr/3TwLf9MHiEdO1lIFLVQX5EgLkwIlfllp0jv1YdI326+U+aHwQ?=
 =?us-ascii?Q?n4hYXjK8UsJCtvY/tyeJmpemuPaKiXCX3EyU34irOjHQT2iaeCd2j9pCBb3v?=
 =?us-ascii?Q?DgKtsqN2/NJTEsXnHuUlC1epZ9K3wiIUxyDjpN74pvGEJfnCLbnqfzPpjONH?=
 =?us-ascii?Q?HOKmKXFcvbayuY+qRXIlT7slD9SCEcW2Es4hqgLNQg3UnEfm9YLdzgkoi127?=
 =?us-ascii?Q?y6PyBAZKQciJvZISTdkCpRThwqLqE3muKdzH8xIJPSADlejiVyxAdZssrtlD?=
 =?us-ascii?Q?i+1q85Vu25tELSOk8UQdVSo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JHhY0ApUOeNTLVcgfxF9e6TUvkud0M6/4UJBXLEhh7NLLX1CJtTeeqEX5AbJ?=
 =?us-ascii?Q?tG+0CWMo/fLSWR23DlwCzoS3V1DLNPxQe7Bavh0VjTDtUqvoxHNZSPQi/zqY?=
 =?us-ascii?Q?ODDC+JPLUiipnA4oWUrD2FK8WT906qyolhDwbfP7NIfekemtPcw2tARWm7bx?=
 =?us-ascii?Q?Wk3K2g39SzQn1wycnQ8hek0Pwf3L9lV3CQeLnJla+hK48tyIPeOHvy7HHsKv?=
 =?us-ascii?Q?mS7xwn+LUp7c3e7V2R4Aib6Ty7UISrGzRN67ldHrHtTw8BCsOPrwlWgTdJ1H?=
 =?us-ascii?Q?DPQmEE2WOHdFH5+VtGNr3NGBYgoRuTMcV4soff1bVqCwn5fVeuQcohMRwWO8?=
 =?us-ascii?Q?MC4UhOEbNh9/hffOMPzmEUR9YtCIDUs5W8WhBBratIgaBoSzOO35jxLk2Z6+?=
 =?us-ascii?Q?mDd90Pr3vlekRWj9ItT1wb8F+78ZMmW8pY5z7l2FqDvAfkiQzkwWXdSTAyU2?=
 =?us-ascii?Q?L9/LfCJeYA08/XyddW1/vPzg4wz3Q5fvGH3MUJcHE+vgofEsfnynnwz8E0RM?=
 =?us-ascii?Q?GMvTSkPxuz4kviyIE7gidH86UHpP/djIoReH2dbZ00ZNrWvGbttcQnG4NVnw?=
 =?us-ascii?Q?qQJf/Kfxaz0zk0bv8Tm51T9sKI4aGp0H+6ZpHySAcqRFI9b/L2Iy1RNja9Mk?=
 =?us-ascii?Q?6ZdFF2c7DRQ/f7Aga8WaSgWsGt+W6gWwvsTWKus88GfZ9mKM4C2CeEdDAuqu?=
 =?us-ascii?Q?JRnc8qBaCqyu4H+d/5ftTIg0+fZCQ11mjLZtGpvatynOYNtiIKqSS9nwG7NW?=
 =?us-ascii?Q?utrMzLICLzPDSG+R6JhmpyfrfKc0A/Us5BS0nrggXv+QeM3+WkRoh3MCZpkm?=
 =?us-ascii?Q?nerFV8PEtlSf++38jdk1sh4B43Jp1UD+yntgLjwC9Bf9+1C/fM/5W6k5qoEN?=
 =?us-ascii?Q?NFPX42c7AcPkDFOm7w2hzBmRSMGaLpCKhvghv0gmsfstvJnHyA8KGuEXiXGu?=
 =?us-ascii?Q?63nT5iFXjI0888WgC67Yr0Ts+X5YAfqdC0UgOlL/L4q66/8M01iR9xofsUPx?=
 =?us-ascii?Q?xb5bXFpQaTsd/R5cdUtlOEz9+yIE8zMnkXvbcQaxTuHKbbPh0n7GZDcx0+7b?=
 =?us-ascii?Q?rzHxqXWCU9qm9m/IvSP/98yS40obpfsTXqgMvivXs4R/gXQflwFFwtJqyfis?=
 =?us-ascii?Q?0cFhAsnTcQWANH+QppNYOl3tz1focZ5WILaNkDqnAB3kFENW7lIyINxVCMSJ?=
 =?us-ascii?Q?IVPVtDov5wNfNB5V5ZlYKyh/afJa5ej/G164Ln3400zc193s1Gi1IvOMnh/+?=
 =?us-ascii?Q?TNiWtMncfWBTdQl0frF6F1rZqKP9Tzo+Kh+niB+co9FDJgqpd7OtQPoFewvv?=
 =?us-ascii?Q?cPV4vyCjQez/w8P0hfuI5VR+DgoUTIZzaqe10Sp++Ope1vVf7dHWPwHM2/fB?=
 =?us-ascii?Q?qLRJFBovAqSfEZPFAUuG6gQuAzThcjXrjsg87kJFXHICG8UaUoCEqcZv+XI6?=
 =?us-ascii?Q?97wmC+H3vEmou5HcK1/Ey/UhMvR/Th5hgKW0K4fLMTuO/68fP5dgLYjK/vcs?=
 =?us-ascii?Q?mLx2OMou5h2S4J+Kth7s72FJJa0WMb/a4JpuT7HEBr2JztWvE1lpbcNEpKtx?=
 =?us-ascii?Q?qo7A6QqeMlY5TGKKA0mfGMywD3KrllEglYc04PdCCmUTQhHkds/xxy8eew4v?=
 =?us-ascii?Q?ScKZfIKQUdQxgnccjDyZOc68jgaR2Llb1gjwtuaPJHLtZU/SOtV35PvxE6sA?=
 =?us-ascii?Q?gl/iRjofCLpTnNMSFFnQjT95oZOof45/3Vnl3zszbBKm3HZY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993c76dd-adbb-4148-4a24-08de60e5d529
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 16:28:57.4864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32f+9SXW8eHret6R0w5/Lu+kpltcggwfWKR8ZaBXa1FoE4X0Hj9sr/9EmX31LW6cyi27TsXGpAuzmFsRQxclnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9872

On Sat, Jan 31, 2026 at 12:39:01PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>
> Fix based on similar fix in:
> commit 83b645ee43f7 ("hwmon: tmp108: fix I3C dependency")
>
> Note to keep things simple I'm now requiring I2C.
> That can probably be relaxed in future, but I want to reduce the test
> set of builds for now given this is blocker for the main IIO pull request.
>
> Fixes: e559c8641460 ("iio: magn: mmc5633: Ensure REGMAP_I2C / I3C not build if I2C / I3C is not.")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601310904.DueZdiuY-lkp@intel.com/
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>
> Note this is already on the IIO togreg branch given very short timing.
> Any review much appreciated!

Thank you for quick fix.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
>  drivers/iio/magnetometer/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 2b81b22c9550..9345fb6d5317 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -141,9 +141,10 @@ config MMC35240
>
>  config MMC5633
>  	tristate "MEMSIC MMC5633 3-axis magnetic sensor"
> -	select REGMAP_I2C if I2C
> +	select REGMAP_I2C
>  	select REGMAP_I3C if I3C
> -	depends on I2C || I3C
> +	depends on I2C
> +	depends on I3C || !I3C
>  	help
>  	  Say yes here to build support for the MEMSIC MMC5633 3-axis
>  	  magnetic sensor.
> --
> 2.52.0
>
