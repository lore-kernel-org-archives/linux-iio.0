Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794407053;
	b=41bPcHgAP0Rmm0TgLeAEfZpKN1r+hxLhuOq1regHcNjaKroqPNP6Rf139TOIZVBxxF5Z
	 ikgN1cvZpGsN26zRM4BHAqUpAPp7ELboheJphwBhgTtdFNbUA1Z8IxpwJj3zEP41XWR0T
	 tqPBaAqbanuGxDMeWSvAJIETJiGOVR3Pw72xBF3PbVPBJK5SaDM+BEDQom7rwOUi6Y7EP
	 +zE2fZ/SL17v/AEpypOO6ZtYuJP0vGkO5cpKKcLiwY3XnkB+Nvo1miXOJY+2hd4SBEO+D
	 hkrEqnJcMlJJEuFXDht64n1txQCLmDgADi3O31LfRkEkK9PHDsnpX6hkxodiK8Bwskw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407053;
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
	bh=CapBSMZIciUjEJlH9FahIYlpO550tSMt3mXknuF+/5w=;
	b=towTWu1A3krUbGXLwclWSyj9UsB3ZT4GCxuJKIS5BCbqEIUmNUuAPXgLYiqc243TlBrV
	 BHv87V5GFGyZR83mqJSLYlbeG9JvT5NlJY+SJ5hB2x6v0bhn/aE7w7o8myHFJmGayqhaZ
	 bE2fNOY/SjFPsQhGFJepkK+1g0C5+4gH4hpLGwOmOeao7v5IhoNWtEZJmDQppj57Lvq77
	 XTAx5MiSXqd32WaVRWUBUWvSM0+lPB0BTY4LIYZnTl96GOJekFjbs5hujWjHSQETx3kct
	 sqf5j4kJoY9KUw//5Fyb73bz8YGIF6zEUI93uJnfls7jQGWjKeQzYIfOSvcz1zyG2mQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="jnsol/eY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.22
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012022.outbound.protection.outlook.com [52.103.11.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B47606A887;
	Wed, 11 Nov 2026 14:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64B47606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=jnsol/eY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9SupZfxbNzTs9dEm9fJFjJJ0df8HO+1mXgYg8HVIF+Vj1FvEYrqgI9dmwJV0Zgl6sUm5UyKaQR93xQ2MQ60a4qxgWmfDfTTatrJ9K1bJ5rV/Gl6gWiqvaLtG1FVSZ7ttHaAjB6Rfps3QZ4ZaREi2NfEGHHv5XvjF2SIjyVfKXE0f39bC7HvEdwcwWmvsiDBmqmPic+5djRQmiOuCthu0lvTf+aXtrQUQYsn2avChRYHbx5dKUeW3BHMoXVWUy0tiiEd1ZK10m3+LK4TP2WezHyofGKGWHMNsvIVU6Y2aPli0NNZ6sguJiZArOEnLGAUEN7+0hVT7SIi87eHEAhLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CapBSMZIciUjEJlH9FahIYlpO550tSMt3mXknuF+/5w=;
 b=wXqxiGEB5FrA5u+I0g+b8c7reOEeFI06LToc/kyoP4ImRDOA7UFVYbHF7Ow+IDsFbifhlHjARP6Q8AR/sQw/ucOruFzZR7geql5Ocxyt9N9yoZnXrU1VEmzlObaXdi0cHPCW4XbxyPL2bxr/V/Z+BUZ220+DbxkpELSTnvpUa/cZBs+CFT2FL3XWCnj10E7V2Og09n9Gxk1I1i9DNe6RvARN8169n+C5IGzqP7lveZTXKcHIxV+E4T2FVOUsekuYFI3TbDz7q+8qxqr/xRrcT5bnxj82V8NlWDPoFguXevKs0Oc5Fj1nNJp38pDQpbekti5TzrGlThogfhwpNuA9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CapBSMZIciUjEJlH9FahIYlpO550tSMt3mXknuF+/5w=;
 b=jnsol/eYi3JzlR875gxcqIvJkKYrvYPLA2rmrVekAkMHTTQY7MEvOBReesEaBF90Bd4aZEgPFYT/cERRaJPHr9j/l/pAvC30mOJ7Oxgbm1XYG89ZEJ+M4AjUQ3vsD7QnZqtQfLU2S9E37/ZdJgFC0XdM2x/EcEn0ucVe6TaGdO3td9y6Uqo+J8lIVmd0pUHh7Vh/UrTNH5MIumG3IaaNAAaUHng/yFwuRbAuBZeIjsBsBaAHsT9vtw7zkLRJd7r6pUJBoMlcUPZ3UJuRpVy1EcMAX3AOfxk5sVS13ZQURvGTS0Zc0StwBVaw9UdqvXwmommUNCydee/9zbsLMTfvTw==
Received: from MW2PR12MB2523.namprd12.prod.outlook.com (2603:10b6:907:11::22)
 by CH1PPFDB1826343.namprd12.prod.outlook.com (2603:10b6:61f:fc00::628) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 14:24:10 +0000
Received: from MW2PR12MB2523.namprd12.prod.outlook.com
 ([fe80::336b:c57a:e118:4352]) by MW2PR12MB2523.namprd12.prod.outlook.com
 ([fe80::336b:c57a:e118:4352%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 14:24:10 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v9 2/4] iio: add IIO_VAL_DECIMAL64_{ATTO,ZEPTO,YOCTO} formats
Date: Wed, 11 Nov 2026 08:23:55 -0600
Message-ID:
 <MW2PR12MB2523E85D336ED0B690B39B74A5712@MW2PR12MB2523.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <MW2PR12MB25231C3FE75A17CEDACDB279A5712@MW2PR12MB2523.namprd12.prod.outlook.com>
References: <MW2PR12MB25231C3FE75A17CEDACDB279A5712@MW2PR12MB2523.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:610:e5::18) To MW2PR12MB2523.namprd12.prod.outlook.com
 (2603:10b6:907:11::22)
X-Microsoft-Original-Message-ID:
 <20261111142358.22099-3-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: MW2PR12MB2523:EE_|CH1PPFDB1826343:EE_
X-MS-Office365-Filtering-Correlation-Id: 000dcb6a-b6b9-4f55-0038-08df3fff7305
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|4140399003|5072599009|22141099003|25010399006|260925184616899003|24121999003|24021099003|22091999003|23021999003|15080799012|39105399006|19110799012|8060799015|40105399003|440099028|3412199025|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mh9yRe5dVX3xbbJF9T9ELv7O0jI2C3C5QUU5z5xdGx2xcPhccXLkxgVRMi2c?=
 =?us-ascii?Q?v1TP/TblTkI4gUaDc/isk9AwdMndBokATllsaNhRaqiZjchMs1YJPRaKqFw/?=
 =?us-ascii?Q?80+Rcy3ATkQB5wVGSYp3j3Fd4FCacxOt2HMCoCG5laCOR0E0DbyK36Ymp65H?=
 =?us-ascii?Q?PJnXnjUI3OLjxL6jrD1VNcb3BsMqwVo7cabJkDedXrJq23zT0q7TiApkBwwJ?=
 =?us-ascii?Q?PyqgdIni95HOUsXzvT+0nwnokXyZ8o/9JEaUwTn8xjGfyAgB6NExgwkLPHO2?=
 =?us-ascii?Q?GvAh0Yh3uHt8T1UQ8kHNbA7+g0jfTymn0ol3fmVP14qZrxoEmqfaUO1UbBfQ?=
 =?us-ascii?Q?XJFfEyPeysGkEeSP0qBWD7tx6DLMA3GvHVRZgABFe/2baYwA1Kq8KLBFaN0b?=
 =?us-ascii?Q?A0TRsmG/c4ca1XfQNKLrWrSgoOJO4BcXDaVSxdQlQeymKmFJ3OusnZsxS9UA?=
 =?us-ascii?Q?fp9wvuZy7urpOev4hvbFkN6m/ykW9zgLfuNrVB4se6cHVdapgL9cHuaAsJ/c?=
 =?us-ascii?Q?3CFbLXnn9DImWtw52c/vn+7Cw58l0pTDEWHukVdtho61ppvL1lEpBRK3zw/l?=
 =?us-ascii?Q?cdyVIdlnvEJOOu/PmzG0XLCvGHWqdQNVpVT+bre5hU16M5H4u5eRqBkf7bKS?=
 =?us-ascii?Q?TJvJg9SpPdJcZEDcm8QiRd69npcfqSWsGDOJexnXJHWvC/uMErlpvkiCUpa9?=
 =?us-ascii?Q?AiXKShnZu2yFL3gjb2wH4j/FK1nvkvoXCyePT4/HY+gnI8Uo1TYElDO2ETDz?=
 =?us-ascii?Q?RDaPc7BRlucmmHAApZQQ/TDfOWK/BQTWErZxmmMrccTnEiD2AivPg5i82Pgi?=
 =?us-ascii?Q?YmYukwzaudmrU49HBTR1moUoYmg/3aRq/kmwYC8TzuwJNtsFS1USyV/KanAY?=
 =?us-ascii?Q?I/5THqSX0LWm+x2VZ2rfHrBF26Eq0HeTX/cwcZcRoeC38jM6+EvvLT/XMKqA?=
 =?us-ascii?Q?FUhWWE269gtV2/VFIztuWpTY34HH6l4IrG0k5AV/Kh5SS3dOcQctSLmB7oxd?=
 =?us-ascii?Q?EyaCY6ApkjugidjbpMDTgPR7e17gPWJJAjiobR2iLmsv8cjaWWrhd2QRtaTY?=
 =?us-ascii?Q?yB5iDY9gz9LmTRLF5XuHdYuGt7n0XA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eoNISv+Yzn5fVrMvcRAwcf6AznyhiVOs5dbHtJE//MXIOLf45DlEEDDIGIhH?=
 =?us-ascii?Q?vCjTJ4LlbehWd07Z+SsI9tfvufNTa5mseMkAV/l1sYF2p+P1bZ+TIqfN5sAk?=
 =?us-ascii?Q?0Ml1dGzajHyFcEUFPJlx6QQOf+0sN+oE9zwdwc/JA1uZdjAvLRxRxfjgDoX6?=
 =?us-ascii?Q?2XzOGxoZzz5lvZgGxY0Uub2gtc4RFSq09tnygaQBGaIzOZssMAYj9LIIoP4o?=
 =?us-ascii?Q?jhgtzV3lr5OXaiRxzbG+iS+RpmCuyLcp8Y7tGL3x6+7EIi3aSD/No00bqtfu?=
 =?us-ascii?Q?cG6EbF64MCM+vGu/WWRmCUzisNYb0g+/UWSKT6C2p3BEZfdNicCvqs4uYsNH?=
 =?us-ascii?Q?gpV4UEFqq4RCdWcHfRUkQ2l98fODZ+dfOsj6AmigkAnpp6sotKmX/RIfbZDi?=
 =?us-ascii?Q?gXcGpPj1hl7uQ5h/TDZr+O1Rwxid1jNH3/p7MRl2Q7kGBXp7yuajb/opirSw?=
 =?us-ascii?Q?QdFo3/uRb43VW/e70eAMdTDR4o+1vGHOuRWUkoOHQZMC0NWZAdTba8A/dEtc?=
 =?us-ascii?Q?uXnE85Ttxzuu9kV/afP5HFcOUn1W8+XEX0Oaw1QeqOvh2cr0ez85bP/CaXsU?=
 =?us-ascii?Q?KDWMPzQL+UWg7oC977Aumu2pJH0/gYS9JlqkMXqIfGpKIyLNqIbl4C2u74Vf?=
 =?us-ascii?Q?+FAzZC05DQDwZBlJ2ZhNZ8Xv1UzlkncOMGhFMRhFYFNsXY7JneomlRcX9L4s?=
 =?us-ascii?Q?RggdTS34x8oZtdKefGgfOEqyh11863S6Hw8/9KPTX0+E9MXQkpA+opRHuVLj?=
 =?us-ascii?Q?/zTHg6k7vSzjUrTPMTIuUP/H4ydrf1eQ3AXYAMK8l9yQ0LAiREFNUZn8l+pp?=
 =?us-ascii?Q?ei3OeeR2g0CPTp/oNfRKTQpC5/czIMRgNsLPoqhrmDRm1JC34cYVLZBCpG+w?=
 =?us-ascii?Q?XFCOZE0X7wE5tApqYts+9XWgzU4zQYSSiPYzr9JqyeaKtahOFbERNaG96jiT?=
 =?us-ascii?Q?Z0zXbyjeE8GrXao4Bn5/7BmKfXBU0i0IaToLgtLXIxRQbYDFuG6GNg6UsCFS?=
 =?us-ascii?Q?irUrSzmCULtNKl8XTt8j4Dok8GhaxJp/ij/QwrOAwXzk3QyD+Ylor51k/moT?=
 =?us-ascii?Q?A54+Gq+wsZO5p8hht4LOHPYhgDzYNa4rbFMs3yUywB2qWB4QM38MNwfd6usC?=
 =?us-ascii?Q?fCKGzGFYp9cXyq5eoHjItErkrtP1mIRbbFY0VKpjK9Wr6XSYdiQBxDLQENiS?=
 =?us-ascii?Q?sql4HlqrbSvxn81W/nRn/7JBkriL9ZD4vReSBciaieiw/f3a+PeVKRRQBygV?=
 =?us-ascii?Q?QS0501Nwo4lPIPGGodW1Kbb4NJNj7f7bmYY6/utvGXpdg5fXx57cW9TsuGdb?=
 =?us-ascii?Q?yhl7/YllS30m8aOxfLmFSPyqA854Gev60v+T+aWYGHNXHoqH+m0E1T+t7WAu?=
 =?us-ascii?Q?Wd8RBwiYCcMNesWnOLQ2kRMK98EpKS8tC3dfFN2tgLamtS3Taw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000dcb6a-b6b9-4f55-0038-08df3fff7305
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2523.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 14:24:09.0583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDB1826343

The highest-precision format IIO has right now is IIO_VAL_DECIMAL64_FEMTO,
which gives 15 decimal digits of precision after the decimal point. This
is not enough for the upcoming TI FDC1004 driver, which needs 22 digits
of precision to exactly express its scale value. This patch adds higher-
precision formats, up to IIO_VAL_DECIMAL64_YOCTO (24 digits of precision).

Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
---
 drivers/iio/industrialio-core.c    |  6 ++++++
 drivers/iio/test/iio-test-format.c | 16 ++++++++++++++++
 include/linux/iio/types.h          |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 42e92a79d1ee..21594318bb9e 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -726,6 +726,9 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 	case IIO_VAL_DECIMAL64_NANO:
 	case IIO_VAL_DECIMAL64_PICO:
 	case IIO_VAL_DECIMAL64_FEMTO:
+	case IIO_VAL_DECIMAL64_ATTO:
+	case IIO_VAL_DECIMAL64_ZEPTO:
+	case IIO_VAL_DECIMAL64_YOCTO:
 	{
 		int scale = type - IIO_VAL_DECIMAL64_BASE;
 		s64 frac;
@@ -1050,6 +1053,9 @@ static ssize_t iio_write_channel_info(struct device *dev,
 		case IIO_VAL_DECIMAL64_NANO:
 		case IIO_VAL_DECIMAL64_PICO:
 		case IIO_VAL_DECIMAL64_FEMTO:
+		case IIO_VAL_DECIMAL64_ATTO:
+		case IIO_VAL_DECIMAL64_ZEPTO:
+		case IIO_VAL_DECIMAL64_YOCTO:
 			dec_scale = type - IIO_VAL_DECIMAL64_BASE;
 			fallthrough;
 		case IIO_VAL_INT_64:
diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
index e5d0a2ac4670..43a80952a50f 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -286,6 +286,14 @@ static void iio_test_iio_format_value_decimal_64(struct kunit *test)
 
 	/* limits */
 	iio_val_s64_decompose(LLONG_MAX, &values[0], &values[1]);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_YOCTO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000009223372036854775807\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_ZEPTO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.009223372036854775807\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_ATTO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9.223372036854775807\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_FEMTO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223.372036854775807\n");
 	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_PICO, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372.036854775807\n");
 	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_NANO, ARRAY_SIZE(values), values);
@@ -294,6 +302,14 @@ static void iio_test_iio_format_value_decimal_64(struct kunit *test)
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372036854.775807\n");
 
 	iio_val_s64_decompose(LLONG_MIN, &values[0], &values[1]);
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_YOCTO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000009223372036854775808\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_ZEPTO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.009223372036854775808\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_ATTO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9.223372036854775808\n");
+	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_FEMTO, ARRAY_SIZE(values), values);
+	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9223.372036854775808\n");
 	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_PICO, ARRAY_SIZE(values), values);
 	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9223372.036854775808\n");
 	ret = iio_format_value(buf, IIO_VAL_DECIMAL64_NANO, ARRAY_SIZE(values), values);
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index d8944c9e5e90..2ef9b2a8b119 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -43,6 +43,9 @@ enum iio_event_info {
 #define IIO_VAL_DECIMAL64_NANO		(IIO_VAL_DECIMAL64_BASE + 9)
 #define IIO_VAL_DECIMAL64_PICO		(IIO_VAL_DECIMAL64_BASE + 12)
 #define IIO_VAL_DECIMAL64_FEMTO		(IIO_VAL_DECIMAL64_BASE + 15)
+#define IIO_VAL_DECIMAL64_ATTO		(IIO_VAL_DECIMAL64_BASE + 18)
+#define IIO_VAL_DECIMAL64_ZEPTO		(IIO_VAL_DECIMAL64_BASE + 21)
+#define IIO_VAL_DECIMAL64_YOCTO		(IIO_VAL_DECIMAL64_BASE + 24)
 
 static inline s64 iio_val_s64_compose(s32 val0, s32 val1)
 {
-- 
2.53.0

