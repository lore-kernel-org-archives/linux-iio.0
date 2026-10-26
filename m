Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793033500;
	b=BR7qosgiPz5j/tH7+lQXmsyUQELZUu7vdF10U4wrkjOpI8VDZgHmLDSz9Mcuu7InFS62
	 vSiqQ5+arq5s6FiVxEC6maqbU5wnX7YyHnRen6o+cT8R8voMwdbnO1eW/fnfJs+VZpGyT
	 XAn6tl1Qbhz64vu2oztXts/BVK3MAA5r3M2lspPfsCVCB7E92JZ7DI3vV1Ftnj9pT4+LR
	 B/eP3ipJb1KgvtLerF7CLEebDmhvHzz4sy8zLVQewX6wO/TO8VLPR6i1QwezSoMynSoxo
	 g1TI03f7j2XgcGSv6wh4WB1xuirwNbnACxDVyCDC/eNXZCAWXDuVxAge7kwVv/sUTvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033500;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=p6Zx+WbZrv3BFhnfTXLEh6oH4Rn9DprcpEwq96k6KfQ=;
	b=VrMHVwLTjeWCO424B9E8V+osBUP9XHMy3YlEWyvKkoJVdVTdcEmTIAOdhs4kL/p+TAt+
	 hleWR9J4FyRJx/uzarNDkdu41ApUKQzYbhbaniD4xG3Lh1gwWZiJ+S2PhPTEw6rs90qNp
	 rwNm2ck/DPJPR4/v4N3ceRS2XheZX+sVTCeZo1tqwuU4k6+Drzn72up/oz7jyiIDM0jY+
	 M6vsZS38LLzzXgh3ovaFSZkQdEkymcSYdd29HhMzXGcHgzX9qTbJEFctWN/Ib+J9gXNM8
	 11EX1q/FyxNWQXj6iY9mY69krvcOhM9LvwT7QYteZG6Z1YeE9j7sZZeI252Xi8hwIJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=EG+3XvCZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.16
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012016.outbound.protection.outlook.com [52.103.10.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB624606A329;
	Mon, 26 Oct 2026 16:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB624606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=EG+3XvCZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8QoLEAxkPjkTrbgNVphhgZAC2qp3ISENWBXVFoaElgI5rQbTNVwInXVlaiUw/tN9JKv2zKbiZ/Tg/gRzL40iKfbTq3v0m2LnycMiFUNG+lfQXpwxOb1Rv4kB5/VL4pafsJjJUncE05KlIYRv5r2PAWU3Zg11TG9mRZjMs7nrZpcKePvCC52bYrJeZLybG1MMltivoeb5lgbN/5/dh262R4K3QSNMm9jNderXlssjpyr7nyVEkPtMCbf+8Zmr7zj5nMWybWMN/8SZSIW2O9osGv+Z5qujVtoYa5ml2G/dgj/ibxfAqU4sNuvDcAsEXnaRvnrT/MjTNLDkFtUd1bb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6Zx+WbZrv3BFhnfTXLEh6oH4Rn9DprcpEwq96k6KfQ=;
 b=MAdLJDZVMuPeZtZZN1iMXnV9q5n5S+mcABIosIpa5KiVnSdnTpdVR00TZG2CuXrW/IjGtbnHQR9WGtN9el8q4Fs219QAE0f0N7TSEq94GgUpShcZLG6rgPRLfR1ccEQvLIHKyPZhgiWuej5CkQ0gjQVGElWHFhwKISvIxAxNmKMyyTf7GfO8kGpA4DEYhvsUeN2/7Na9z9PmZG0YvG949EDafW66Y+TXxEhD9T0c0927Z+VpROTtz7M3pf2ebMt8FlvOx/VfxO89y8KzRefWgo/No0bTOvfd4E7RgrDJ8+DR4JkqBw2Yz6l51yeLOGRlAENpi5XQ2/mSnEXsTLP03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6Zx+WbZrv3BFhnfTXLEh6oH4Rn9DprcpEwq96k6KfQ=;
 b=EG+3XvCZUzXDnyfEXDXFr3vxAsy8vcijmpedC4e07NPoKNnrwA0AN3L3bizOktnx/zYAXqq+WbmTJi4XHa5qzfH5Vyjdtv7hWtsvtIxFQUKb3VCu2wFV3B2vgRwler8v1OyVibu+3ST7MBMmbP240i2wp5AiISJMmhFrONDSb4jf210dw4t59oStGl9z53OPms4SrtXyh80p0hlc73qrdo1tiqNmDow0a6y6rt+6YJcJxTkLhSDeTJbE5mBOeLT3eSO3qE8Uc9c71CZ0SBMDUH1J+J+WUPFCT4mPFNyh6zKsY5EgmF8c/nIGgaEJEVxCfyireFhY+PpTKYRtpHSIKw==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by IA3PR12MB389676.namprd12.prod.outlook.com (2603:10b6:208:713::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:51:37 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 16:51:37 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v3 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Mon, 26 Oct 2026 11:51:14 -0500
Message-ID:
 <SN1PR12MB2528DB8EE8ACEBF9551ED52EA5612@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB252882C0E885BF3368E036E5A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB252882C0E885BF3368E036E5A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0093.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:25a::17) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261026165124.119890-5-chernyakin.victor.j@outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|IA3PR12MB389676:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e0d2f3-6c8b-4031-34cd-08df338165f3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|20031999006|22091999003|23021999003|24071999003|15080799012|24121999003|39105399006|5072599009|41001999006|12121999013|19110799012|8060799015|260925184616899003|4140399003|25010399006|3412199025|440099028|40105399003|261007181701699018|26121999007|11120399003|261005200801699003|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bFHQ3uke4E78Tqx8tlrQ8I9Vj2nQAPT5OJgN1KoS3IilysodREM0j9QyJSOh?=
 =?us-ascii?Q?f1SlVQLZznm0Mm8pu06K+RMGS/thCv7FsFgZFEkJ6JoCiNYaG5bI9rqDlu5l?=
 =?us-ascii?Q?M/DYYUBTEm+Ej0nqekwt9/b4ve2zcV1pP8wdEOGYDD6QfvY2K6RZXm4g2KDX?=
 =?us-ascii?Q?DMGjKwsXCSe4I8PYEih1wCw/UkVA03CUBAtCMGFX36IEFYr8QPd+AqfVU+xP?=
 =?us-ascii?Q?d7MOXMqfNf1hGgMy4/pfc94k6PYFbBe21zUvCPmo9/3nupfNSAiwjs0mr/xf?=
 =?us-ascii?Q?c1DtTAK7uOgwlvkuMEf1t4ZM2fTyEJTbz5r5BCRgxsyu6vejs84y9wYsnwjP?=
 =?us-ascii?Q?cNbhtEcvuYPv2OtFP8idgiVfzCUm9IfLnfzmtGDqJzQqBrH5RMQGWEA1HqEV?=
 =?us-ascii?Q?rtGbrd61uhXY/2YlhQs9BQ5aBTwNEN/pwFHne8B+x+mJujVWCKzE0KKtpz6d?=
 =?us-ascii?Q?wRHmY3AO7v7oK4bSJ0clAmfL1FfRFdcRyHDiiIgcPC6PnBmekvWz9t8qXsSW?=
 =?us-ascii?Q?J9LfMwwDn52YAq6Cm8GwtKljDcoyGN7pbvD2Ck7T/kgGYSkeWFDjLnZ/IK+r?=
 =?us-ascii?Q?0d9x12cIr1UtLkRwVoQJrWOr5D+qNKMc6ERTpPfzYW8xkV4ZuQeezaN4L4kH?=
 =?us-ascii?Q?POJ4BgD65hlXfshgqZB8mEW/k8ei+ASCVbxPgK40Gle4YqdQiioPDL+Cg42O?=
 =?us-ascii?Q?P0TzsuXzY3/v4NibPHk4akrWMK0zqHOvbtiP9fdglm7gFrKIevTgFf8qxZFb?=
 =?us-ascii?Q?fEO8/t62gxbd0/StZvOlCqo0OJd36qi92MFvoUXXuaJVGtG/gv3Uwa51R/ps?=
 =?us-ascii?Q?Vq4O7tyKOTI2DxpYY3DTACLhuqhiNPIa5mqEUcnXUJjHN+EiLjv+1DSryWu2?=
 =?us-ascii?Q?0FBzTCmVzmn+YvKwNdWGfviGivW/QkeSTKGgorbR4kebtczK70gProgZfiFZ?=
 =?us-ascii?Q?BdGlkHQccYPJ7Gj7NgwMEBMBPYlUVIsTHmtsTTb7EIAa2VmLQwuwME0oLPhl?=
 =?us-ascii?Q?BOFl17ZWQ0O3zJ9feu6GM+Cj19gorlEOHUkRvBXf0rlZ9ynA7x8/8NNnX2O9?=
 =?us-ascii?Q?3ECxbfr283eIqXs105iRJLPaDDgXSq9ZOwmpevCKVHgfVpeeraTgoW+ggzxi?=
 =?us-ascii?Q?MmRLiUftBLpcSUFo/rtEg0s/yTK1pQ+5qdepG8oc31YPsaq9W+nprw+qT/Zp?=
 =?us-ascii?Q?nt2qF7SLMvv4YO6bXrhusVP4JnJWQ5C7JP9BG7Iz+1N7k/FAFyIEaRsWRcp8?=
 =?us-ascii?Q?0ia2DmNydPYPEyJyBAEwuTgGMlbqN50HZ2a2AuFFog=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c1gWQ3SiU/X37W4msi/FT7uPSvMcyUrM4iAoNoPBj9BSw6V4ZjzjD4Q1ENvp?=
 =?us-ascii?Q?bLwQT/1Ygr/NxfymD7RHT7wnCYLEC558QgofJhpZCUDsCN5DCHHNcL9ICTV/?=
 =?us-ascii?Q?TkUyBUXqaVTCxv3a+u+N8wskChVqZMNRf98kF9rDCMLUe1DYG0GsSh9jyEec?=
 =?us-ascii?Q?mvB3tiagakEA2QwKPuqQ/d8vTgT5FgmzQ8SN68HE2IUTF22T1Vfifl6/h+b2?=
 =?us-ascii?Q?ZuXsKkrFcFREj2XneBzadwJhBTQHmDIaA175ngVEED7oUj32cR3o8MeWOcV4?=
 =?us-ascii?Q?r2FdGm3cnNS98JoR+029WUiym2X1fqwDub0EW5qde5Uk4fGUumvOV9lpRiOn?=
 =?us-ascii?Q?fx9094jV6ZFDlz2/mVTb8aQ+x2cUxOaevfRneewhtYP4OzIKD6LvxjnXncE5?=
 =?us-ascii?Q?BRYabJBDQ6+EZL2MlM1czpzmc1wIUjbsnj8ZZ/WTZfr8T28H6IU870t/TgnR?=
 =?us-ascii?Q?UpaTEvr95w8dKghlGbGMYlS63pUez7TUoa8GXlzhEv+5MHG0MJ5ROzNkvmCt?=
 =?us-ascii?Q?RFR6Ckgp8jZOpDuV9GifhaPsCYqh7fq+9vGPQx0VFkLoCaJr3hSW59Z5oWhU?=
 =?us-ascii?Q?heCkFQLz88TUGZhhW90jW3BGX66ngc81pLbS1IKSwuN7ySAv7TnCuWR404fp?=
 =?us-ascii?Q?QAKpUkT2GH05O4oghYMY3A7Xin5wrfeMR0OZqCF2IvHofaoXXGL842EkI50N?=
 =?us-ascii?Q?RXAnywkgSWNNuek2gajOJk22i66xVrV4Xp9qLcz1GdSldjKXTDki7jAX1nZg?=
 =?us-ascii?Q?fjyM55JROks/zZ3nLyVIjbQIgC0kE8+E0se7yUEarpKgklM/yAq3b4GWLu6+?=
 =?us-ascii?Q?iO38pvsB0ocKJkaCcybfe02aFaZb1bx9S3ieATjWioNMq5xCu0jhV88cG+c2?=
 =?us-ascii?Q?5W+2jhGfx6MqZiCCqfEg4p0GPdVZvCZKo7zJQyr6OnfIHgh7yt85dvtp7nxR?=
 =?us-ascii?Q?EfbilOVrxa4mKQLdd6mHQ8KMEZ1953URr99S2MWqsP5mH2qz9zuQYDqi9p8c?=
 =?us-ascii?Q?mk8aSSBh0cLt63n6PU4iJucowDtO7BB4ANe5gMbo8dC1Jbpvh+Ws4ECzhNG+?=
 =?us-ascii?Q?a0WlD6Xmgt6TcBQkkNkTrp/RigeIxAXPcKIBV6qTOrBIhU/ba7tBTC9KTSlW?=
 =?us-ascii?Q?VSLEK7KJs3kzj0WU+G6Dp5RakR1z6UYIcY0v5QgAtMkDww6p5EayZKr49lEG?=
 =?us-ascii?Q?Q1SxDYLaSJEb2GmquiIH0wxpc7mtlykZH0EbTJ1chLU1cNm8ktv0mMQXemHI?=
 =?us-ascii?Q?14ooiDfqkUX6fn19KOpqRMcBmqmR7O19u2TuF5mRnIn9X2hSjsYOcSCYSnRI?=
 =?us-ascii?Q?8iE4AVgFwrt92R5NaopGCyCfWLl4xoeGSgK2JgXIfCxE4Zretsf9QCl7VDgU?=
 =?us-ascii?Q?8ynK+VTeSGlLq2mvEg1Idxr+gSi7av0PWHeG6pcxNHTLrHOBpQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e0d2f3-6c8b-4031-34cd-08df338165f3
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:51:36.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB389676

The FDC1004 is a high-precision 4-channel capacitive sensor that talks
over I2C. It can report the values of each of its 4 channels individually,
as well as the difference between any two of them.

This initial driver allows performing single reads and configuring
the sensor's various settings (sample frequency, calibration
gain/offset, etc.). It could be extended with support for triggered
buffers, repeated measurement mode, and/or power management.

Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/cdc/Kconfig   |  10 +
 drivers/iio/cdc/Makefile  |   1 +
 drivers/iio/cdc/fdc1004.c | 488 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 500 insertions(+)
 create mode 100644 drivers/iio/cdc/fdc1004.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 69c23ae21016..4d926c47ad8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27392,6 +27392,7 @@ TI FDC1004 DRIVER
 M:	Victor Chernyakin <chernyakin.victor.j@outlook.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
+F:	drivers/iio/cdc/fdc1004.c
 
 TI FLASH MEDIA MEMORYSTICK/MMC DRIVERS
 M:	Alex Dubov <oakad@yahoo.com>
diff --git a/drivers/iio/cdc/Kconfig b/drivers/iio/cdc/Kconfig
index e0a5ce66a984..6b9ea2cd37bd 100644
--- a/drivers/iio/cdc/Kconfig
+++ b/drivers/iio/cdc/Kconfig
@@ -24,4 +24,14 @@ config AD7746
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7746.
 
+config FDC1004
+	tristate "Texas Instruments FDC1004 capacitive sensor driver"
+	depends on I2C
+	help
+	  Say yes here to build support for the Texas Instruments FDC1004
+	  capacitive sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called fdc1004.
+
 endmenu
diff --git a/drivers/iio/cdc/Makefile b/drivers/iio/cdc/Makefile
index 41db756d8020..88253f33c5a7 100644
--- a/drivers/iio/cdc/Makefile
+++ b/drivers/iio/cdc/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_AD7150) += ad7150.o
 obj-$(CONFIG_AD7746) += ad7746.o
+obj-$(CONFIG_FDC1004) += fdc1004.o
diff --git a/drivers/iio/cdc/fdc1004.c b/drivers/iio/cdc/fdc1004.c
new file mode 100644
index 000000000000..1fe2874cd65a
--- /dev/null
+++ b/drivers/iio/cdc/fdc1004.c
@@ -0,0 +1,488 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Texas Instruments FDC1004 capacitive sensor driver
+ *
+ * Copyright (c) 2026 Victor Chernyakin <chernyakin.victor.j@outlook.com>
+ *
+ * Datasheet: https://www.ti.com/lit/gpn/FDC1004
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+
+#define FDC1004_REG_MEASn_MSB(n)	(2 * (n))
+#define FDC1004_REG_MEASn_LSB(n)	(2 * (n) + 1)
+#define FDC1004_REG_CONF_MEASn(n)	(0x08 + (n))
+#define FDC1004_REG_FDC_CONF		0x0C
+#define FDC1004_REG_OFFSET_CAL_CINn(n)	(0x0D + (n))
+#define FDC1004_REG_GAIN_CAL_CINn(n)	(0x11 + (n))
+
+#define FDC1004_CONF_MEAS_CHA_MASK	GENMASK(15, 13)
+#define FDC1004_CONF_MEAS_CHB_MASK	GENMASK(12, 10)
+#define FDC1004_CONF_MEAS_CHB_CAPDAC	0b100
+#define FDC1004_CONF_MEAS_CAPDAC_MASK	GENMASK(9, 5)
+
+#define FDC1004_FDC_CONF_DONE_n_MASK(n)	BIT(3 - (n))
+#define FDC1004_FDC_CONF_MEAS_n_MASK(n)	BIT(7 - (n))
+#define FDC1004_FDC_CONF_RATE_MASK	GENMASK(11, 10)
+#define FDC1004_FDC_CONF_RST_MASK	BIT(15)
+
+static const int fdc1004_samp_freqs[] = { 100, 200, 400 };
+
+/*
+ * MEASn_{MSB,LSB}: 24 bits, signed. Format: IIO_VAL_DECIMAL64_YOCTO.
+ * 1 step = 1/(2^19) pF = 1/(1000 * 2^19) nF = 0.000000001907348632812500 nF.
+ */
+static const s64 fdc1004_scale = 1907348632812500;
+
+/*
+ * CAPDAC field: 5 bits, unsigned. Format: IIO_VAL_INT.
+ * 1 step = 3.125 pF = 3.125 / 1/(2^19) raw value steps = 1638400 raw value steps.
+ */
+static const int fdc1004_offset[] = {
+	0x00 * 1638400, /* min */
+	0x01 * 1638400, /* step */
+	0x1F * 1638400, /* max */
+};
+
+/*
+ * OFFSET_CAL_CINn: 16 bits, signed. Format: IIO_VAL_DECIMAL64_FEMTO.
+ * 1 step = 1/(2^11) pF = 1/(1000 * 2^11) nF = 0.000000488281250 nF.
+ * Negative values are used to cancel out any parasitic capacitance
+ * of the sensor's external circuitry.
+ */
+static const s64 fdc1004_calibbias[] = {
+	-0x8000 * 488281250UL, /* min */
+	+0x0001 * 488281250UL, /* step */
+	+0x7FFF * 488281250UL, /* max */
+};
+
+/*
+ * GAIN_CAL_CINn: 16 bits, unsigned. Format: IIO_VAL_DECIMAL64_FEMTO.
+ * 1 step = 1/(2^14) pF/pF = 0.000061035156250 pF/pF.
+ */
+static const s64 fdc1004_calibscale[] = {
+	0x0000 * 61035156250UL, /* min */
+	0x0001 * 61035156250UL, /* step */
+	0xFFFF * 61035156250UL, /* max */
+};
+
+static const struct regmap_range fdc1004_readable_reg_ranges[] = {
+	regmap_reg_range(FDC1004_REG_MEASn_MSB(0), FDC1004_REG_GAIN_CAL_CINn(3)),
+};
+
+static const struct regmap_access_table fdc1004_readable_reg_table = {
+	.yes_ranges = fdc1004_readable_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(fdc1004_readable_reg_ranges),
+};
+
+static const struct regmap_range fdc1004_writeable_reg_ranges[] = {
+	regmap_reg_range(FDC1004_REG_CONF_MEASn(0), FDC1004_REG_GAIN_CAL_CINn(3)),
+};
+
+static const struct regmap_access_table fdc1004_writeable_reg_table = {
+	.yes_ranges = fdc1004_writeable_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(fdc1004_writeable_reg_ranges),
+};
+
+static const struct regmap_range fdc1004_volatile_reg_ranges[] = {
+	regmap_reg_range(FDC1004_REG_MEASn_MSB(0), FDC1004_REG_MEASn_LSB(3)),
+	regmap_reg_range(FDC1004_REG_FDC_CONF, FDC1004_REG_FDC_CONF),
+};
+
+static const struct regmap_access_table fdc1004_volatile_reg_table = {
+	.yes_ranges = fdc1004_volatile_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(fdc1004_volatile_reg_ranges),
+};
+
+static const struct regmap_config fdc1004_regmap_config = {
+	.name = "fdc1004",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.max_register = FDC1004_REG_GAIN_CAL_CINn(3),
+	.rd_table = &fdc1004_readable_reg_table,
+	.wr_table = &fdc1004_writeable_reg_table,
+	.volatile_table = &fdc1004_volatile_reg_table,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+struct fdc1004_data {
+	struct regmap *regmap;
+
+	/*
+	 * Serializes accesses to the chip's measurement and config
+	 * registers, and to the other struct members below.
+	 */
+	struct mutex lock;
+
+	u8 offsets[4];
+	u8 samp_freq_index;
+};
+
+static int fdc1004_soft_reset(struct fdc1004_data *data)
+{
+	int ret;
+	unsigned int val;
+
+	ret = regmap_write(data->regmap, FDC1004_REG_FDC_CONF,
+			   FDC1004_FDC_CONF_RST_MASK);
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(data->regmap, FDC1004_REG_FDC_CONF, val,
+					!(ret & FDC1004_FDC_CONF_RST_MASK),
+					1 * USEC_PER_MSEC, 200 * USEC_PER_MSEC);
+}
+
+static int fdc1004_read_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan,
+			    int *val, int *val2, long mask)
+{
+	struct fdc1004_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
+	unsigned int reg_val;
+	u16 reg_vals[2];
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		iio_val_s64_decompose(fdc1004_scale, val, val2);
+		return IIO_VAL_DECIMAL64_YOCTO;
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&data->lock);
+
+		/* Configure the measurement we want. */
+		reg_val = FIELD_PREP(FDC1004_CONF_MEAS_CHA_MASK, chan->channel)
+			| FIELD_PREP(FDC1004_CONF_MEAS_CHB_MASK, chan->channel2)
+			| FIELD_PREP(FDC1004_CONF_MEAS_CAPDAC_MASK,
+				      data->offsets[chan->channel]);
+		ret = regmap_write(map, FDC1004_REG_CONF_MEASn(0), reg_val);
+		if (ret)
+			return ret;
+
+		/* Start the measurement. */
+		reg_val = FDC1004_FDC_CONF_MEAS_n_MASK(0)
+			/* "+ 1" because the chip wants a 1-indexed value. */
+			| FIELD_PREP(FDC1004_FDC_CONF_RATE_MASK,
+				     data->samp_freq_index + 1);
+		ret = regmap_write(map, FDC1004_REG_FDC_CONF, reg_val);
+		if (ret)
+			return ret;
+
+		/*
+		 * Wait for the measurement to complete.
+		 * The slowest sampling frequency the chip supports is 100 SPS,
+		 * i.e. 1 sample every 10 ms, so our timeout can't be shorter
+		 * than that. Go with 40 ms to be safe.
+		 */
+		ret = regmap_read_poll_timeout(map, FDC1004_REG_FDC_CONF, reg_val,
+					       reg_val & FDC1004_FDC_CONF_DONE_n_MASK(0),
+					       1 * USEC_PER_MSEC, 40 * USEC_PER_MSEC);
+		if (ret)
+			return ret;
+
+		/*
+		 * Now read the two registers making up the measurement.
+		 * The datasheet says to read MSB first, LSB second.
+		 */
+		ret = regmap_bulk_read(map, FDC1004_REG_MEASn_MSB(0),
+				       reg_vals, ARRAY_SIZE(reg_vals));
+		if (ret)
+			return ret;
+
+		*val = (sign_extend32(reg_vals[0], 15) << 8) | (reg_vals[1] >> 8);
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&data->lock);
+
+		*val = fdc1004_samp_freqs[data->samp_freq_index];
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_OFFSET: {
+		guard(mutex)(&data->lock);
+
+		*val = data->offsets[chan->channel] * fdc1004_offset[1];
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = regmap_read(map, FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		iio_val_s64_decompose(sign_extend64(reg_val, 15) *
+				      fdc1004_calibbias[1], val, val2);
+		return IIO_VAL_DECIMAL64_FEMTO;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		ret = regmap_read(map, FDC1004_REG_GAIN_CAL_CINn(chan->channel),
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		iio_val_s64_decompose(reg_val * fdc1004_calibscale[1], val, val2);
+		return IIO_VAL_DECIMAL64_FEMTO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const int fdc1004_calibbias_decomposed[] = {
+	lower_32_bits(fdc1004_calibbias[0]), upper_32_bits(fdc1004_calibbias[0]),
+	lower_32_bits(fdc1004_calibbias[1]), upper_32_bits(fdc1004_calibbias[1]),
+	lower_32_bits(fdc1004_calibbias[2]), upper_32_bits(fdc1004_calibbias[2]),
+};
+
+static const int fdc1004_calibscale_decomposed[] = {
+	lower_32_bits(fdc1004_calibscale[0]), upper_32_bits(fdc1004_calibscale[0]),
+	lower_32_bits(fdc1004_calibscale[1]), upper_32_bits(fdc1004_calibscale[1]),
+	lower_32_bits(fdc1004_calibscale[2]), upper_32_bits(fdc1004_calibscale[2]),
+};
+
+static int fdc1004_read_avail(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      const int **vals, int *type, int *length,
+			      long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = fdc1004_samp_freqs;
+		*length = ARRAY_SIZE(fdc1004_samp_freqs);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OFFSET:
+		*vals = fdc1004_offset;
+		*length = ARRAY_SIZE(fdc1004_offset);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*vals = fdc1004_calibbias_decomposed;
+		*length = ARRAY_SIZE(fdc1004_calibbias_decomposed);
+		*type = IIO_VAL_DECIMAL64_FEMTO;
+		return IIO_AVAIL_RANGE;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		*vals = fdc1004_calibscale_decomposed;
+		*length = ARRAY_SIZE(fdc1004_calibscale_decomposed);
+		*type = IIO_VAL_DECIMAL64_FEMTO;
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int fdc1004_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+	case IIO_CHAN_INFO_OFFSET:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS:
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return IIO_VAL_DECIMAL64_FEMTO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int fdc1004_write_raw(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan,
+			     int val, int val2, long mask)
+{
+	struct fdc1004_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
+	s64 val64;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (unsigned int i = 0; i < ARRAY_SIZE(fdc1004_samp_freqs); i++) {
+			if (fdc1004_samp_freqs[i] == val) {
+				guard(mutex)(&data->lock);
+
+				data->samp_freq_index = i;
+				return 0;
+			}
+		}
+
+		return -EINVAL;
+	case IIO_CHAN_INFO_OFFSET: {
+		if (val < fdc1004_offset[0] || val > fdc1004_offset[2] ||
+		    val % fdc1004_offset[1])
+			return -EINVAL;
+
+		guard(mutex)(&data->lock);
+
+		data->offsets[chan->channel] = val / fdc1004_offset[1];
+		return 0;
+	}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		val64 = iio_val_s64_compose(val, val2);
+		if (val64 < fdc1004_calibbias[0] || val64 > fdc1004_calibbias[2])
+			return -EINVAL;
+
+		return regmap_write(map, FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
+				    DIV_ROUND_CLOSEST(val64, fdc1004_calibbias[1]));
+	case IIO_CHAN_INFO_CALIBSCALE:
+		val64 = iio_val_s64_compose(val, val2);
+		if (val64 < fdc1004_calibscale[0] || val64 > fdc1004_calibscale[2])
+			return -EINVAL;
+
+		return regmap_write(map, FDC1004_REG_GAIN_CAL_CINn(chan->channel),
+				    DIV_ROUND_CLOSEST(val64, fdc1004_calibscale[1]));
+	default:
+		return -EINVAL;
+	}
+}
+
+static int fdc1004_debugfs_reg_access(struct iio_dev *indio_dev,
+				      unsigned int reg, unsigned int writeval,
+				      unsigned int *readval)
+{
+	struct fdc1004_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->lock);
+
+	if (readval)
+		return regmap_read(data->regmap, reg, readval);
+
+	return regmap_write(data->regmap, reg, writeval);
+}
+
+#define FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(_channel)               \
+	{                                                                \
+		.type = IIO_CAPACITANCE,                                 \
+		.indexed = true,                                         \
+		.channel = _channel,                                     \
+		.channel2 = FDC1004_CONF_MEAS_CHB_CAPDAC,                \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |           \
+				      BIT(IIO_CHAN_INFO_OFFSET) |        \
+				      BIT(IIO_CHAN_INFO_CALIBBIAS) |     \
+				      BIT(IIO_CHAN_INFO_CALIBSCALE),     \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),    \
+		.info_mask_shared_by_type_available =                    \
+			BIT(IIO_CHAN_INFO_OFFSET) |                      \
+			BIT(IIO_CHAN_INFO_CALIBBIAS) |                   \
+			BIT(IIO_CHAN_INFO_CALIBSCALE),                   \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.info_mask_shared_by_all_available =                     \
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),                    \
+	}
+
+#define FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(_chan1, _chan2)         \
+	{                                                                \
+		.type = IIO_CAPACITANCE,                                 \
+		.indexed = true,                                         \
+		.differential = true,                                    \
+		.channel = _chan1,                                       \
+		.channel2 = _chan2,                                      \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),            \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),    \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.info_mask_shared_by_all_available =                     \
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),                    \
+	}
+
+static const struct iio_chan_spec fdc1004_channels[] = {
+	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(0),
+	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(1),
+	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(2),
+	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(3),
+
+	/* The sensor only supports differential measurements where CHA < CHB. */
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(0, 1),
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(0, 2),
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(0, 3),
+
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(1, 2),
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(1, 3),
+
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(2, 3),
+};
+
+static const struct iio_info fdc1004_info = {
+	.read_raw = fdc1004_read_raw,
+	.read_avail = fdc1004_read_avail,
+	.write_raw = fdc1004_write_raw,
+	.write_raw_get_fmt = fdc1004_write_raw_get_fmt,
+	.debugfs_reg_access = fdc1004_debugfs_reg_access,
+};
+
+static int fdc1004_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct fdc1004_data *data;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return -EOPNOTSUPP;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+
+	data->regmap = devm_regmap_init_i2c(client, &fdc1004_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	ret = devm_mutex_init(&client->dev, &data->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_regulator_get_enable(&client->dev, "vdd");
+	if (ret)
+		return ret;
+
+	ret = fdc1004_soft_reset(data);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "fdc1004";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &fdc1004_info;
+	indio_dev->channels = fdc1004_channels;
+	indio_dev->num_channels = ARRAY_SIZE(fdc1004_channels);
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id fdc1004_id[] = {
+	{ .name = "fdc1004" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, fdc1004_id);
+
+static const struct of_device_id fdc1004_of_match[] = {
+	{ .compatible = "ti,fdc1004" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, fdc1004_of_match);
+
+static struct i2c_driver fdc1004_driver = {
+	.driver = {
+		.name = "fdc1004",
+		.of_match_table = fdc1004_of_match,
+	},
+	.probe = fdc1004_probe,
+	.id_table = fdc1004_id,
+};
+module_i2c_driver(fdc1004_driver);
+
+MODULE_AUTHOR("Victor Chernyakin <chernyakin.victor.j@outlook.com>");
+MODULE_DESCRIPTION("Texas Instruments FDC1004 capacitive sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

