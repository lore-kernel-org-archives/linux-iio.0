Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793459632;
	b=1Cs2tfHH7l9NlZrUQhSDHFziCzT4Piv6NCmA798Ze7oNfjOhlnr+zw2wqE7Q9eGW9TgG
	 qq3aa0mtlMzhG6bgahUCD5qTVIzl2rQkrcaRpoy5moCXvOPt2jGk4jMKAkAyC6hteGvh+
	 1cSG1QjDi8qdiAAfSGSyqM8OcC7iUaia7yuBLA7+443UVdrpWxxjC5rGX6I0GR9bIdjmb
	 C3vXi2ukwDVxj5M1nYevFCu9Mk3rFg9iEwNptUpbaPtuxW5Gc6YNHsdYFGDc98BTiYsEK
	 D9RZm1yEfvjO+vAR6cOhO45ANK50PaR9bWbaPerOEiABA1W4aGc9Mciqa/a8Ryshenw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459632;
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
	bh=sRWP3AP+ns0sT0Y3a3DJnG4/Y+NK9YvRh0bBZcRYWRw=;
	b=wgQIVAFpid/qjobyf8LjsdCZlTUDF86bsR4fRsf6InktCEyoZ6VUqgb9t1ot2CBUV8Ji
	 50sA5M5/rDF6p0cZVEwGVRgqihUjlYu9QTDOHw662R4LDWMgrDCkJofOCWEqqivmzWGM7
	 kJLX887J8xflhdX45vhxrD17UPavUzX71plj/xNx+AapPWITfFQkZ8fimGU83+UQuoVjq
	 YaQYlebu7C5JaaivZt9Gu+luN+xI6x1m3a/l1LLa0N9Dx/trEoC/qVOjedK8zXqv48/BE
	 3k6M3YYXV1UufLLWeWxWSIEotSiU1SHJqREyBKkmmA2NpNqVJfdGkDJIqRnN3GfR9Vw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=tpcqx31s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.16
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010016.outbound.protection.outlook.com [52.103.13.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF01F606A321;
	Sat, 31 Oct 2026 15:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF01F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=tpcqx31s
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CenhIG8OXeRNkAJQSNi29Ks9Q2iaSmZJftARx8gUNVg2v1lu/ETWnfBd4fgVPmQrBvPafGJ06p1EA7zw6ubOrjJLVqssHZJkQIYEsg/m9QmGO88ARjZdIfvYOo9u/cJOrUTFHWLBR9BdNfQfHH5uL7kNhqYhFbrFvo/SjKDXDkXf1A2qDZFhvHeK6rts0BTMJQIZU5sqJmYC1HQJY5iw6H7Aofj1IPFDDlsTI0NtUGJHbAfGT0DIdBVXXQDXFkIQbDvGqHrrSxmIbPdLIlyDFH63O3Q5vzutcr1bolx06KLAMDr1oQi4Rwd9rmcno7Z9H5DsCgWp6CGyM6+L7BsdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRWP3AP+ns0sT0Y3a3DJnG4/Y+NK9YvRh0bBZcRYWRw=;
 b=REyeDs1NJkR5wEzLhM6Os7NjVHim7J2PqUlebGQisEj9zHS5RNdQvlzJxlGZjeDnD6gwxfKR0NdeYuUkBj43wbMNGIee3uXdrQYNIdi92d/qh9hSQJuhaR0rSHAlT8Tu8ugoyUwUnHsCJqBNL9KLpam+QBPCtUzkD4kQjVSH6R3AacxU/lIUA5VQOqM9q1C7BC0aMTj2BEcIsxs71mnQGX1Hf49WPiVf1vo0f1dPBahliUZSOce2j124Bbu9hZj/K8UJ5AG5FARM1k4moRu3SJ9sakV03Pmq3gEYETP4MSGeac7dVBm7DtfiX4POCUvbiafFo68Gf5PhyZnn5C0ioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRWP3AP+ns0sT0Y3a3DJnG4/Y+NK9YvRh0bBZcRYWRw=;
 b=tpcqx31srD2/bRbtvtvsBblsFnZ6YdjjV+aoAcSjz/6dFb1Rp0vFRDSxYldaYzvanKI4YCSLBCrcgASXagtOyHCOTxh1kWe4dLu56ZmKBgrMoadtwtoiII30a+fUwRKUnPeD7C759oKZry/QOgU73l/KQvaqN5xFZopJh1yFtP/+W2WFxBgRX13u3t7uYkxjcZYscBKaKILIeVrb8tkzRi8nkJe6ZG2d4GRnmNsKhnuYO3GVwytgs+CaB6q8cViHCJ7cSkk8DbCDNWR2mMVpn82293nbbkZdPUPaRFbdi490yo+Li2B5pzICbUD3+NWWiw3ITOUZH1oMXI7mLk2qoQ==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by BN7PPF9C6E5285F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 15:13:49 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 15:13:49 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v4 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Sat, 31 Oct 2026 10:13:30 -0500
Message-ID:
 <SN1PR12MB25281F8D83D65C87BF4B6A43A56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB252803756D5D1C8F35122B8DA56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB252803756D5D1C8F35122B8DA56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::23) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261031151331.140654-5-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|BN7PPF9C6E5285F:EE_
X-MS-Office365-Filtering-Correlation-Id: 0672346d-7dfd-42c0-246f-08df376190bd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|12121999013|260925184616899003|25010399006|4140399003|24021099003|15080799012|23021999003|41001999006|5072599009|22091999003|24121999003|53005399003|40105399003|10035399007|26121999007|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DuJClMKE70MKducjxC9xbWDLFTh43cw0K83UH+q2MhyJsNPLULYGlONQhMQH?=
 =?us-ascii?Q?G1VaZGKMbWkbZHC9ECyGPkPfaPWpl+KuesGEp2HLyB3olYrgDLnBVzZKMuoA?=
 =?us-ascii?Q?AT2QTObOIcSlWscRy/wWJuhacV9oLqk36/SI+fX+PibdGI1gJwCPxKa72R6V?=
 =?us-ascii?Q?h50ZGlfxkvP/yVCIDfBHk3iQc9ggq3XPzwxQ2w9yWTBfKcj7+B8bHig04/4D?=
 =?us-ascii?Q?oxKxGjxPluEr5deVfq/1bwVEQZ/qfvvn4u1QV3aIV0BMxZIcMexRXX5gOq43?=
 =?us-ascii?Q?MhNtv6Q6nzW7shEDcHZHPT9/q6UmajtHQssjZmxxEH0mk5rS5Dgi9dmcx6kP?=
 =?us-ascii?Q?XVdJZ7Zp95+XoPKCIh+MCo+4Z8E/vEzcYL3aWbRz40d1bYcigXVkNC5c/oaT?=
 =?us-ascii?Q?1XdlZk8ZOcG8H1X4k0Ev/gFT4lrrqgJMFN5Xmya/d4kqYKEUP93RMjXUqeId?=
 =?us-ascii?Q?AOEKf3+tyVl+yjgPEzrTy5LmMag8whqlMmIleHe/UhsQCrsM8c/ptibqAUtk?=
 =?us-ascii?Q?Wwa+nzH3tFjH+7JaUiylPrXR4Q40FgW2GW0oI13cqhD02bCFE4XLmXAn1qSX?=
 =?us-ascii?Q?koij3j4FnGcLDpFuub3AA0z+izCGzMelL8046WgW6nCTAis9LdivYXHte6g5?=
 =?us-ascii?Q?1KYtxCzY3k7iPisOmD707k2lBUz8G4B4bAZMxLV4Xmm+GGvpHKIJDwaCtiM1?=
 =?us-ascii?Q?Vc9+Bo3+v4qbez2OudHc0imBYRY0BzSyMBBS3xUQz25HRAgpApSCeMwdlo2x?=
 =?us-ascii?Q?MX6RTEDbiUYOVw9YFisah6PqDpXdLWjer7Cm23ANS71zkOxb//X0R/Pnwlo2?=
 =?us-ascii?Q?i+XXsgPxDxxpreNw4jks9v3/1tc52qHRHdLfTatAhcQvhnYJT75MuwBksFIF?=
 =?us-ascii?Q?VTAAhLZIhfFTXDcrKRxRwFhI54tOL0N5zaiKn3tWTrdcxcZPZAxLor63tZT0?=
 =?us-ascii?Q?kW6I5QfyC1uNa6YhU1P35yqheIMrLuLNjV0NrZUE+K8YnOg4WyaTcLhtg8Uy?=
 =?us-ascii?Q?rwIng8CGwOHGOe2ojZRgOWCVIc3hooKUWTPNRQSb+sTE5fQpPFgNUkReJToR?=
 =?us-ascii?Q?wIth5zR03UIOTaQcaRb3sIAFNdOqSFN7uD4z9pOJDm0uUMlsE8v9H3ysIkML?=
 =?us-ascii?Q?REQIlto/apZkMEzCfyIoUYpuh4uzsQRbFBs3sitlagdWYn3U7RFFP8Q=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iplL+XYAqzzFZiXCd2hJA06agKWxogUe4N4+D5r8Mg3I57to9QnCJt7sC0wi?=
 =?us-ascii?Q?PVa3+H5oK/MRHPWMVX0HHeveXJKLx12k0F3Z9/52BzLtlUjtAsyMjxoWBIck?=
 =?us-ascii?Q?R710LxgESLV20laGtZuG12h9TH2oPzVYX9/WGFfIhesEXk/zSxwxj9OYxHb2?=
 =?us-ascii?Q?1LVKPNVz5F68yfKQ8ap4hmqyfJZzUmdAnnPFkcmnPLcYtZx4kLPgzLaBBIyh?=
 =?us-ascii?Q?6X2GXPsZNN0jTSms1/OuJtnRGIgcCbjwxVolVSpSZjoeM1IdJFQQSc9fc6Ho?=
 =?us-ascii?Q?XqnQsCNXtt5Bkf6djp/ZpNtxs/Qj5O36nC6O148GiB387+Rkv7ECfaCcl1DY?=
 =?us-ascii?Q?t8cDgh9ZNM7jyos15HxZ1KLdA2CmWgaYuDG245nMjqDzba50+k+NBHaO2aC4?=
 =?us-ascii?Q?moBmo9fzsxOxocEfx27WJbGMX88IySSkZrfRdp+NSLDER/MS5LYWMaosWUDm?=
 =?us-ascii?Q?V2GjpX+jYGqPs8xxwCeo/Hu+7sqwV4GCGOVAS4fmFaM1YbozVur/3npKb2Zh?=
 =?us-ascii?Q?iuVrbeUit9bBd/3lZmGnx/9TR1anv/yKdhqi6wrbjOvLMTWsWZodzvB/ZoPY?=
 =?us-ascii?Q?/fiSeBltK23hl2CovoVCgohUwrF6do9lVhWqyUGxl9VF6QS+A6/h39bsfvIz?=
 =?us-ascii?Q?VSSwmurNiBvmGryV8XrUylCFCYJD11soci9BbG0LEOzgQQ/4MBJ3j0ApFwR/?=
 =?us-ascii?Q?aBcKalztb0f1vd3iiwNoq6kNJjP8dcntbN5E42+dI6CVXIM34vGhIAlfm9/Z?=
 =?us-ascii?Q?/0mGkh/FUbzG6wbLmGBubebAspsCzUf0aWRS3Wro1k8ZX/KhYbry8Rv8Xe7b?=
 =?us-ascii?Q?43MePL6i3I+mxM3WSi3Bjj+Ddh+ZBui3nlBzl9IZPFoEhIVGdQ86MGkdfk+s?=
 =?us-ascii?Q?12u0SsPFXhxWh7N4209l9ebXKVpj5nuuhjfTSUmKquSwAf+uOcafEVKrv6nk?=
 =?us-ascii?Q?NyXRDKyVyDpzFfY4rcHLZIOv5arlKUENnI+XdOmB6kFumrbRW9//efVXKpk2?=
 =?us-ascii?Q?T2bvapytmid95SiVv48kLoN8SO+OUFONwUFoZ78QGJw6i47sF97WXBMvJ7FK?=
 =?us-ascii?Q?xCAjizuCJafK2ntaugQJbY3tgk/t6vgSXWRT5HoyL9mevJbKOJvNrzcXaHVa?=
 =?us-ascii?Q?7aL04Js1BoFrtQLLw9NuPUyV3kqqfnqdmftqU5A/xEV1tW5LVF1mE/EXEIw0?=
 =?us-ascii?Q?5myWZBE+llcsyy/gtVyc/775eAO4sAyJ8amY+MxIZkPNYF9wCO3zByn51to2?=
 =?us-ascii?Q?ZYdbBe2grq8AxMpTRV/IjV2N/a1L+d3LHKHClQpIZ17AQZeEwRE5zCzlkvE8?=
 =?us-ascii?Q?SSh5yV1nc0mgT0kmZLEbiwyq/UiDSp+JyG9Av55l4w3tBNHbcDcIMUqxvy11?=
 =?us-ascii?Q?2gpptfw+dMaLPE43FwyNaFvnN2ZXvRek2eh2Q4kkH2FlHkaYAg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0672346d-7dfd-42c0-246f-08df376190bd
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 15:13:49.1918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F

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
 drivers/iio/cdc/Kconfig   |  11 +
 drivers/iio/cdc/Makefile  |   1 +
 drivers/iio/cdc/fdc1004.c | 490 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 503 insertions(+)
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
index e0a5ce66a984..1e9015fb5ae6 100644
--- a/drivers/iio/cdc/Kconfig
+++ b/drivers/iio/cdc/Kconfig
@@ -24,4 +24,15 @@ config AD7746
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7746.
 
+config FDC1004
+	tristate "Texas Instruments FDC1004 capacitive sensor driver"
+	depends on I2C
+	select REGMAP_I2C
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
index 000000000000..442aa020ffe9
--- /dev/null
+++ b/drivers/iio/cdc/fdc1004.c
@@ -0,0 +1,490 @@
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
+	struct regmap *map = data->regmap;
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_write(map, FDC1004_REG_FDC_CONF, FDC1004_FDC_CONF_RST_MASK);
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(map, FDC1004_REG_FDC_CONF, reg_val,
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
+		reg_val = FIELD_PREP(FDC1004_CONF_MEAS_CHA_MASK, chan->channel) |
+			  FIELD_PREP(FDC1004_CONF_MEAS_CHB_MASK, chan->channel2) |
+			  FIELD_PREP(FDC1004_CONF_MEAS_CAPDAC_MASK,
+				     data->offsets[chan->channel]);
+		ret = regmap_write(map, FDC1004_REG_CONF_MEASn(0), reg_val);
+		if (ret)
+			return ret;
+
+		/*
+		 * Start the measurement. The "+ 1" is because the chip
+		 * wants a 1-indexed sampling frequency.
+		 */
+		reg_val = FDC1004_FDC_CONF_MEAS_n_MASK(0) |
+			  FIELD_PREP(FDC1004_FDC_CONF_RATE_MASK,
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
+#define FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(_channel)		 \
+	{								 \
+		.type = IIO_CAPACITANCE,				 \
+		.indexed = true,					 \
+		.channel = _channel,					 \
+		.channel2 = FDC1004_CONF_MEAS_CHB_CAPDAC,		 \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		 \
+				      BIT(IIO_CHAN_INFO_OFFSET) |	 \
+				      BIT(IIO_CHAN_INFO_CALIBBIAS) |	 \
+				      BIT(IIO_CHAN_INFO_CALIBSCALE),	 \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	 \
+		.info_mask_shared_by_type_available =			 \
+			BIT(IIO_CHAN_INFO_OFFSET) |			 \
+			BIT(IIO_CHAN_INFO_CALIBBIAS) |			 \
+			BIT(IIO_CHAN_INFO_CALIBSCALE),			 \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.info_mask_shared_by_all_available =			 \
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			 \
+	}
+
+#define FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(_chan1, _chan2)	 \
+	{								 \
+		.type = IIO_CAPACITANCE,				 \
+		.indexed = true,					 \
+		.differential = true,					 \
+		.channel = _chan1,					 \
+		.channel2 = _chan2,					 \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		 \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	 \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.info_mask_shared_by_all_available =			 \
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			 \
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

