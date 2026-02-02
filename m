Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF2337B41F;
	Mon,  2 Feb 2026 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050258; cv=fail; b=lzU8b6r9mNfJ9Gkp29hitbKr1cgAl7d3PDUCRxBqQwATT3qr9tg2KyonK4sQ+0dmqkZZM5MZp1N/oTJhzgtj3hcqeVdZPufuysOazXY9N8/p6FVscOKmGyquqNWTP0aA6pzmy/uXwMOhiUGPPBt0yKioZeFaf3dgf1YB7N08li0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050258; c=relaxed/simple;
	bh=DIvZwpiXC7qcNYyjgjg5iXCr34EFV9qrfgkxF5WBB50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NHxH1NR2LyxA8zBJEhQ4H2ccexqP7aUU74i9Ns1lS/sL4oWB6VP3Ryp7uzXUct4pWCJtPRDwQ2rQT7dhiJHokkwKV2Pc7bPUBZZDcQb0Cccc/KrrrDDU6KiuV4z6+Hq73ahP81K9DHJXJnGWp7FHFsjUchkZEBuk4xMuZifvSuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FT9pnyYa; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FT9pnyYa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMvIBFcORoEeC2QZC8K8FmNCncwxYrklUum8eYE8Wkqz3yn4lIbeQwG30RCu7D+7EXLA5ohCrVxP0wMmniT0zSaPFAEygKPxiKuxu+XuZL0oOXv/KUUS7vZTv/QUqzvnsYdvslAlgwZeA+5Y0r0DaQQRgMpCQfK17jSEEOLwY94xJIl1OqRqW3crFeK7o17AMxlMuRICWl1E8h+Yf0ay2YOLxLsvEldUG5sWjBHJA7UEKrhw8fmqBCXwinG3CXUYoIuIu/GaYGfDGwI7l/vQvrVB0NpgKMcm6zcfnDSsbn5pDCALgocRdtDIr7Rburb1WNz5FUWCJa7opSepdPpT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BYdzyjbQmeysHudQSEQrfQCpNSlg9bNP0gtvZICq0o=;
 b=nKN61gFpQo1W8XC0kYLynsc4S2n+4FQIjb11GvqHzHRWXHk0ELPeBCHZTmhgXVorQBI5HXVbFiKW4eXj3O/cBLk/8DmXdWILst186e2PqByy/nEDVxMJW0Y2upIg6f6ntV271uR0KDPgWepL+yhyrq9nNPFdphCvwBeY40h1VRPXS/J/cApp/NlbZdI557kjz45bB8/NnmXJL9c9DJJaZO51w+rmDKDsBXNFXGtgxb2S5Ufof8pn+rpq5YxwHnzRmiyxXNr9sXpTEayXyRCWLoxyPsgl9ZMYcoa+Z4wah0xDnaF6m9bjYS+kKPhXk3dYAcWuWyr7Z7VNYAUjZipnig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BYdzyjbQmeysHudQSEQrfQCpNSlg9bNP0gtvZICq0o=;
 b=FT9pnyYaLeg1QaPH5QfmWIzWwNKYPwZlHerjgHs1Lx7Lf1yevStWH4G2bfEQXP22nSGaAiBUnfOTEkDTHyb83lnVSG+9ZQfS819ZnaJLrH1uXjZJrTowKDgvFzNL0hsc5vOeIl26wHf+UowfdkH4Jm4WUaMS+mmduUx0saJhPGBUxbG/nuXtX8zYhHhfJ4oOk4G2qHLy/uUIyLdCHHHyFfGD0YJpRfsLM7CuebzCjoQirbG+rFYEKEB/LLI6eICWy53bsqIC6f67oWkNc6ynrN1DuiIytjRs3dk+BlgkgItmfXz0avIAUnwAaJ0KTUQRhP1+9yjm8B7TcQZF9c9w1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:37:34 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:37:34 +0000
Date: Mon, 2 Feb 2026 11:37:25 -0500
From: Frank Li <Frank.li@nxp.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>,
	Carlos Song <carlos.song@nxp.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jean Delvare <jdelvare@suse.de>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i3c@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] [v2] i3c, iio: fix i3c driver dependencies
Message-ID: <aYDSxd9H1x9nY+7d@lizhi-Precision-Tower-5810>
References: <20260202160543.3654499-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202160543.3654499-1-arnd@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:a03:332::11) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: fce5834f-811b-40d5-17ff-08de62795dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LRamd6UUMdoRlJLqd0s95S9BW5se1HDqrn5frI8QamoIXOGKWYt6dRyAoanX?=
 =?us-ascii?Q?SepVwYoKEYAK9RmA4Cr3fDGUop6D8gb1uTWK6Kxwsevku/DNCgAn6Inf1UYV?=
 =?us-ascii?Q?FjHb9Il4fC9oqLMCEVHViSHNn2MK/WzkjemaQPR/nf9vD8xtgSsMEaqM4VjM?=
 =?us-ascii?Q?uZyj941kJuiO5HVavFm9HHnm5MfkejurMjwhu7JcP+W6gzGjsd1UE3Bmr63g?=
 =?us-ascii?Q?KknNl2a30lgFCwxq89ciHc5uyD9PsozfccD8NMtrziWF6hGw3/psbjuH2O7z?=
 =?us-ascii?Q?M4UtUwuaUaduhURYkxmQfbxNP73htylUkXcSKU+B0CtpnyUu1h0glDrgSM9l?=
 =?us-ascii?Q?DFeRu5+fYEQJXeHaKIajfMCwnkLc0fquWWPkcg2Ce4qtMzmdG7yUKBaUuHF9?=
 =?us-ascii?Q?tM5qd1goWisIL4npi4Q9iH4lFq0/ePppMGjOGhFMjvoQ05ocDRYCuEK8nbIP?=
 =?us-ascii?Q?PzYSzBn78bD4d90uiSTYbM8Vkw6jpXvdEvSVwhjPcLVHpqzavob+57QVUPey?=
 =?us-ascii?Q?6IzOLO9/EUJwupAhtDcO2Mi919MeFtbsFeZ6ioKTD/Z9P95dxNOjOgNb3dI7?=
 =?us-ascii?Q?O0YtmsOXpadU3BSnjGv5I1gBI8wnlG+KP1ox9t/yZbI7Lq2jrev3z2ZS3sbu?=
 =?us-ascii?Q?WvbYGZ+iYQmcVw28bv1RLRN5ZU1KChNhX+24kbqCJ/PLBFI/cEsrTjQjHHwn?=
 =?us-ascii?Q?mfalFMarilA8cBTi6PWe5H3DmjBbRkIBnOfuE720R/UQfLnV+Evt/gXIwTx/?=
 =?us-ascii?Q?20gmL8vtIQK8WQaSivt/33f+gmRJGbxj8gcIkxbikrFtsofdFxqRYmcnUxvu?=
 =?us-ascii?Q?ktcz/19sj2thLoUykD9oz33EWEkeNYl9fQHxpEsu357qeDVaEPb5pnUqQlIs?=
 =?us-ascii?Q?rf7TPTJdzwnnQ5h0CKYTXtppQfLRMO+/1mjGE0TAF4zZMn29jhbQKBbQ9c+2?=
 =?us-ascii?Q?CRxxHM+ngLBFhAyaVTOJhPwuKvrf+b//XL/lshEUSDZoRABN5Pw399HrPM/t?=
 =?us-ascii?Q?9KZKYPtzz20SvsEaW8Bt+VOBT8P19KzsazlsZhD/3ayYTvFZH/rw+TsmLlD5?=
 =?us-ascii?Q?f6Jl25vvQr7N/UugKtdUNP1Hxdu4NTBtF92K5ggc8GKi/LTs6tQXcxS26UXL?=
 =?us-ascii?Q?Hd4F2sVwUAUm7xM/41iwg5Usp4GcWTva6jbpPqq6eT4Yss7PnLK8EMxihwVh?=
 =?us-ascii?Q?pc1OH+pKh0qK2yu74eP2jbT8j+KJvFmu2GJn7D9eklH8SMay3Upxf0TPcdaS?=
 =?us-ascii?Q?TVkWTjQnB6qhzCSANdzt/IpMGxk1zzHRE+n5lveLYX6NUZIOV0RwLKWDKBNH?=
 =?us-ascii?Q?7Mghmil83XJv0vRT61glTT+NrkYfyezDIuQ0PlEfuZeB295+aHWYPx8w8+v1?=
 =?us-ascii?Q?ajyeUoNPlPWXdScv7JKx2eTYWppSPnahxovVoqbp00JMOyyWSNFOjdnt7LVk?=
 =?us-ascii?Q?bQ7XPsXUqS4g7/cwsnZRequbtQ9OaqEte+QJkQunOkdbF1s2e5svXaUs3SOV?=
 =?us-ascii?Q?a/3h1SM3hy8CfYB8O/pMLw0pm3GsFAbcfwGSO5+VX5M2pKH3tulx0Y6YW5Cs?=
 =?us-ascii?Q?kJcWCxHcd4RDsE3HfUMOFArAgVgCcFge+PqavMdPTZnQwjepIu3FERghuBU9?=
 =?us-ascii?Q?90AXBr1ZgfHRiXrrRIcQqSo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j5TDNVsUI8yLNFiVrm5+UiRFZ37grCEoyfWYCZKN4AjlHR6poYMBDDBnSRh+?=
 =?us-ascii?Q?zzH02bT/HHA1KatLgyufQ2cYDxOfKLmD4QkGi5NhsY0mYBcOFfFpTyTY54cb?=
 =?us-ascii?Q?UzDqItheVK3zTI3rsafAO6OLoqVLpmhlkUsExEq85H5NmpOx8yJcz61mo9II?=
 =?us-ascii?Q?gIs1qYH8OLNsOGuPC1qzgV3Gjji+LuEJ8yLZH9VbFBbvldLOr6tyYNZoTh9L?=
 =?us-ascii?Q?7sV8fY6/1KHIPs7Pxk5CvELMX+RVXO6s3GdNpHZDU0rlCS0nAXdD2fgvo6i/?=
 =?us-ascii?Q?+cJsuEe2sLiuplW7caukd1rPkumxkhC7r24XXHwfaIdo0y7ngRyn4Oi9oKYj?=
 =?us-ascii?Q?KMlr/HufryKp01FnWoDij+THuKxnfSiakuQfr3/fQK4V9OsuYGoP5EKE8EKq?=
 =?us-ascii?Q?i5Gnrir3UKnxN0Kv7aPh3b0m40Yt968tkK9fNi7stZpMTKD9Ulg2drRMH1fB?=
 =?us-ascii?Q?GoOvxuycS0Oomy5rlyJruLiU+thRY80F3ybE4KfcBlbAI/7BR0sC5Kjz0EnQ?=
 =?us-ascii?Q?EwyldMNLI/UVCKijhT7vIdcl5AEouSsajgJuwScx7wXwP1dHRW9AEw907CAT?=
 =?us-ascii?Q?8LZhjxHPt2rUq6zbiRDJ4iau3NkEXVcXxAKqrim/hrC8/luVOUVwDGHZxIC8?=
 =?us-ascii?Q?LlKo7NiWIygMyUagjoM2h/vZLRp5Lf4S/UE/t70IuX9xYgkRX6Xhh6erdNj1?=
 =?us-ascii?Q?2u17CX0Oqv3PxUN9KCP6RGyKzBE3rqBrvVLnYJekR9ebdAmzAU2z+toVWtzT?=
 =?us-ascii?Q?6cMNxNxj+Ml1mNF+jqvKEFy1DokV7rtmdB/FTwfA1NRTbFC9zq+fbXWBvIiM?=
 =?us-ascii?Q?+i06mU6VD9TjKC9pHuCPBuyrDm//AhpoqVO6zWgWH347HalYEF5cN8wSDpM6?=
 =?us-ascii?Q?6WpZcxCFm76L8qjGvp8GTxlj9UmtZ9sFF1ORHgirxo4vLfiLKE9nsvcrF1Iu?=
 =?us-ascii?Q?Jrox/BjVzF4QQT38bcWH82YqH7aCwGtLki7osw/ePPjo7ykOxM/MQWpkTD3a?=
 =?us-ascii?Q?Zbx/Q2zJkcQFNWqbyzrLQTjwhyeKMO+M5HYiWHn9vngyaDWWGB8dIZS38obP?=
 =?us-ascii?Q?vqYGDzSfsJhtWbK8Cen6UVj5DHqDjoVtAyPCZGNh91Ni+qbdD6mBu35Z9D7F?=
 =?us-ascii?Q?d0i8sRMdBtPqat5EXLbj2DxOxW6hKbI1Wj5b9QKs88wk22Y6QsWzDs+Y7c8T?=
 =?us-ascii?Q?zDoMigfBYB0trPK85oGOspTRhbdzwanbY4Ug2C20+Iz2VzhyMFEsEnnOppdY?=
 =?us-ascii?Q?uojZdXhDiXP216iANAtLfXbRiCzdp58GcQITLW2gh87yZl1ZaexC3d8yCM/A?=
 =?us-ascii?Q?ZUSF6ZIrNWJMfghw78Z9Yy/kqmfdF2lqGMbpZ6izo/k7Y27xH1raSE0g5+/Y?=
 =?us-ascii?Q?mP9dlAlaGvGPeG9ohblk0Cz2YGtMQBGSfS6as0Xr4TuhQnik4j9QKY/WkYBP?=
 =?us-ascii?Q?OSyewkRv8gmOwMY9CY2onyf9Ln9Rdhs0CTQGwBI9BkSdIKKy7m6KNmTOpIpU?=
 =?us-ascii?Q?Jhm/wtd0mjJWqfmsd8l1EyOXvaw/7vREx/4StL22TQlAeFgURjyXp4Gy2MyW?=
 =?us-ascii?Q?HZriR1BmYqPuUgfA6C18EsyMlCdg+q/THvp1lrtz73+195NQjvWniIHlgybf?=
 =?us-ascii?Q?y4LIV1re1ycniHJPXHJeaYktyqTfW7vzVGH3LIkyMupYmjqed/D8nrSnHpIF?=
 =?us-ascii?Q?Dm7wXjSF0/WwVnIcWn4Ksc/4xdrfgtcr990AoBo7p7Yr1Cqr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce5834f-811b-40d5-17ff-08de62795dca
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:37:34.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrSJTvDq79TK0S7p+RSIaWi0/mbeSM295bS3Mo1OPs9j0nC6Z4RvblUzVYEtEUinZrKzl0FZxgJAXSDuubOzoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406

On Mon, Feb 02, 2026 at 05:04:46PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> All combined i2c/i3c drivers appear to suffer from the same link
> time problem when CONFIG_I3C is set to 'm':
>
> arm-linux-gnueabi-ld: drivers/iio/magnetometer/mmc5633.o: in function `mmc5633_i3c_driver_init':
> mmc5633.c:(.init.text+0x30): undefined reference to `i3c_driver_register_with_owner'
>
> This was previously fixed several times by marking individual
> drivers as 'depends on I2C; depends on I3C || !I3C', but this gets
> tedious and is somewhat confusing.
>
> Add a Kconfig symbol 'I3C_OR_I2C' to help replace those dependencies,
> and use this in all the existing drivers that had already fixed it
> as well as the new mmc5633 driver.
>
> Fixes: 6e5f6bf2e3f0 ("iio: magnetometer: Add mmc5633 sensor")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: restore accidentally deleted lines
> ---
>  drivers/hwmon/Kconfig            |  6 ++----
>  drivers/i3c/Kconfig              | 12 ++++++++++++

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/iio/magnetometer/Kconfig |  2 +-
>  drivers/misc/amd-sbi/Kconfig     |  3 +--
>  4 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 41c381764c2b..ecfba861f66d 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1493,8 +1493,7 @@ config SENSORS_LM73
>
>  config SENSORS_LM75
>  	tristate "National Semiconductor LM75 and compatibles"
> -	depends on I2C
> -	depends on I3C || !I3C
> +	depends on I3C_OR_I2C
>  	select REGMAP_I2C
>  	select REGMAP_I3C if I3C
>  	help
> @@ -2392,8 +2391,7 @@ config SENSORS_TMP103
>
>  config SENSORS_TMP108
>  	tristate "Texas Instruments TMP108"
> -	depends on I2C
> -	depends on I3C || !I3C
> +	depends on I3C_OR_I2C
>  	select REGMAP_I2C
>  	select REGMAP_I3C if I3C
>  	help
> diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
> index 30a441506f61..626c54b386d5 100644
> --- a/drivers/i3c/Kconfig
> +++ b/drivers/i3c/Kconfig
> @@ -22,3 +22,15 @@ menuconfig I3C
>  if I3C
>  source "drivers/i3c/master/Kconfig"
>  endif # I3C
> +
> +config I3C_OR_I2C
> +	tristate
> +	default m if I3C=m
> +	default I2C
> +	help
> +	  Device drivers using module_i3c_i2c_driver() can use either
> +	  i2c or i3c hosts, but cannot be built-in for the kernel when
> +	  CONFIG_I3C=m.
> +
> +	  Add 'depends on I2C_OR_I3C' in Kconfig for those drivers to
> +	  get the correct dependencies.
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 2b81b22c9550..448fef4e5716 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -143,7 +143,7 @@ config MMC5633
>  	tristate "MEMSIC MMC5633 3-axis magnetic sensor"
>  	select REGMAP_I2C if I2C
>  	select REGMAP_I3C if I3C
> -	depends on I2C || I3C
> +	depends on I3C_OR_I2C
>  	help
>  	  Say yes here to build support for the MEMSIC MMC5633 3-axis
>  	  magnetic sensor.
> diff --git a/drivers/misc/amd-sbi/Kconfig b/drivers/misc/amd-sbi/Kconfig
> index be022c71a90c..30e7fad7356c 100644
> --- a/drivers/misc/amd-sbi/Kconfig
> +++ b/drivers/misc/amd-sbi/Kconfig
> @@ -1,10 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config AMD_SBRMI_I2C
>  	tristate "AMD side band RMI support"
> -	depends on I2C
> +	depends on I3C_OR_I2C
>  	depends on ARM || ARM64 || COMPILE_TEST
>  	select REGMAP_I2C
> -	depends on I3C || !I3C
>  	select REGMAP_I3C if I3C
>  	help
>  	  Side band RMI over I2C/I3C support for AMD out of band management.
> --
> 2.39.5
>
