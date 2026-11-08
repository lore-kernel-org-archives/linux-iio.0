Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794168530;
	b=kuc9syWZ1vWaDrcfOkgUdZuzhA2jwavcTv9pwbE4rwEvtb3dZ7/taCjRy9SDrMzaJsa2
	 J69xb7+Waazxrd0myOqAETJVGWEUfabWVWB7iUFaDdGQcF6alI6+xG3Wy0enFk6zWZirf
	 VteyxLzjVIsFdnN0HZ6vuJGzYsEVbPYo57Wf74FkJiTwTHwEtZFGZrIECFQXzOdRtvMtV
	 J7yfLNZ8gXLynxxv9Y2HkwgW0HhqlnAfWa6dUvA8l9OdFTWPuoHlwZZzpEARBr3aSlN9f
	 gKWR0Bd0EdkxC3WVAJKYuJJhWiUWnp8p5F0ftnMWA7GNukXPR3fnjHkIB8QS7INo5TQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168530;
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
	b=RPWJs2rDVMq8Mumj5y7ajtWeOWJjUZludXnbYmbW4QOw8YpIGA+YPZxmq9ipa4YiNgSX
	 HMdh7Jsyvu2rXAHfLWYwOrZKiaCjgDAlG3ZzHXxF8n6uFEjiwL/InPKKvdJbjtCiHVipb
	 Jrv4d9QiRXWeAv5lYfr0nlv7/2HHe6x8+Tcjo1nnzoeC2eZuta9stMoXVOjzjvwZ6kKJW
	 jl+P9uq30p+Vrfk+nt4qL/qLkplV3QJ5Yr5Voh8gum5V/tTj3+rSa8SFkfZ+e4wC8Sllo
	 kBs9OLbJHWEndXISc0kn6rpg09JyAoOtbIl5CBy3CE0rvwa6VYbrmImkJ/APivxdxPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=IHAQpBvo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.19
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010019.outbound.protection.outlook.com [52.103.7.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558E2606A326;
	Sun,  8 Nov 2026 20:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 558E2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=IHAQpBvo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrgo5/lRpZi3OOhWNVPVQe7sOCsuVE8K3trwHqGEB+UHOGuD0w0Bn0euG0KcsKMzQPeA/JzwdH4zgNmvK3Slh2gTyIXD+bshp2aV2d6twZ6x88HuEgs2bo1bwVFCEkt4WgiPKpNzkjIDcqrpuxNxCTuQ2MjnCJEPlT4iAhYieQD8hK36jTX7qF4ftjZ/SM3mXk4mLsqLa0rnORbzj+0h8du4lIBNa2PZnDe6J+dXV3k5hHNh4CcntM73D9B6oQakHX8uVXPiNdLHYX8prFRLidM2+i9hvCDHKthsE44DJ4OEVSziRZhvp98AjGhIWc+gf9IASwMBUD0fCDR288Iyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CapBSMZIciUjEJlH9FahIYlpO550tSMt3mXknuF+/5w=;
 b=DIVGv9wKke4+M8Oa6ZxispVDIkUQLyB1V48ebWkNlcfOolFw1cz56KaJGouYGsTpLy8r5kI5b0nIM7wCEeaRCzBm3qczhc2LoR8Ia916sD5Dojx8MQwaRkRSAQyf0RR9LmoopzKFgdcoMMCzWgdnX6hfqy1pLzDy8+q0YSmAw6JBNbj5tXBEcsg5hC2mHUlmpeYAx0lN81sCHjrUs3WE9Rm2Byz2EldiTbihh6ZGvozd0hKFPqgMOSl+2SOV81k+MELOhgbHGSKEQXQbT/btBilrYOroGegBLi6d8NyeN6cDdL83bxZMiNAI92SFgauVNO7Spd6xlXCiDZi20R5puw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CapBSMZIciUjEJlH9FahIYlpO550tSMt3mXknuF+/5w=;
 b=IHAQpBvolXROK6rRSfdVOZ21RgLYT78QQH76JYzr+MRiR+MdBX9qFmn4/7qnc1MXWn/Say9+SCwZ5TUcMCuoyRY1tr57OH3YLCm0iHkyX6D6wLEShFJo1/60EAiSdjgy1RkJaSsiWsFhj9Iig0lB/DSNN4jLOcDs/CJVuC84tIjNz9iVOEONX8bWtiDCgUn4Z+A/uNrz9/n9QhjJjq3uHd6o7alp9tbFKz+PI/i061sSpJMFkuCFPRzYARncObd0pdt8oyKq+SxRGo21NWJy34LEJsheu47JZ+6anciWkQWYgY40iPUMJeFcmaj/EDc3g9tBNmgzMEJHvUzlqStTrw==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.12; Sun, 8 Nov 2026 20:08:48 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Sun, 8 Nov 2026
 20:08:47 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v7 2/4] iio: add IIO_VAL_DECIMAL64_{ATTO,ZEPTO,YOCTO} formats
Date: Sun,  8 Nov 2026 14:08:27 -0600
Message-ID:
 <SN1PR12MB25286B95C5D12441718E47B3A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB252841150D2280C7C1294A11A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB252841150D2280C7C1294A11A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:610:b3::29) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261108200835.981970-3-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: dee5373b-8b18-4c92-520e-08df3dd41831
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|15080799012|5072599009|19110799012|260925184616899003|23021999003|22091999003|24121999003|16051099003|24021099003|25010399006|4140399003|440099028|3412199025|53005399003|40105399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XMoZAN4sE0eQ4D7TuVGRTnrMjgt/n7VPEoRo9PIulyy5F3w+cfDZvFCoX/mi?=
 =?us-ascii?Q?qOUL//cDgB6xwEa7uwTAAfjtaYJMsk2xgjNrHNUC0HzzHhm0Jv2UEWnavxMw?=
 =?us-ascii?Q?crsxKMV4qvTDYE6iwCyNKtierEA3HLJHHIghso1aN+dgxrNngbnyLah9xUTY?=
 =?us-ascii?Q?8BNIHATga5hIkqDwJwKhdK9jtp8Sc6TzwftWkfkbrs/+4hdA5dofi66b0uO7?=
 =?us-ascii?Q?yUGZwsMOdaIr4Y/DCi75B5LU6nPjzNJ9onpPfTlEgRbU09q6hLHhkGHldXgW?=
 =?us-ascii?Q?TOvNhifGBdL6tV+4PFUTUr4FYIswKEI+iOTSkW7bLCOmM4nt1hk1DREY6/rD?=
 =?us-ascii?Q?32wHP6Nafw9m5EBBJTVscGqtdzn+vTmjcZk2qoE3v2KSbcaeQhdFSEe19UwF?=
 =?us-ascii?Q?5eKPd1JmQikivSSlKOplVtSfU8BBtg1lgiXWkomlt6TL1Mrh8Dt/shmYWmBP?=
 =?us-ascii?Q?8l57pNPDVi11mZ1KdZD6LjEvNh/4j3J0BRQ2Zlfu5otSZ4pyNb8s8Dbkqq2o?=
 =?us-ascii?Q?lB1vTfp88M3Hs06XZ1YuBIaulqiU2cGUDdMqAtVbubZkp9YCJNdRe7N2hiTD?=
 =?us-ascii?Q?JmCahlxCH7UZ9TqeTLpWsiZSrsazv4a3KZbgDlrst4P77LQnt3XghOY6FQbA?=
 =?us-ascii?Q?5AsW11WwFsmNwpDcpX525RgGifUrcpdzI43iooffmTFSv07Zyeuqug2Bm4Ha?=
 =?us-ascii?Q?vzQFTrrUSpum2Dv9eLZVns6dQTY03trjO3MvXuF7kJ+ODBrHZZrJSWi4AXnR?=
 =?us-ascii?Q?JK0dPRhvvs5LeubnEPIgtcEgrDyOMCjGAaIgnUlaNZlX+mXBYPzd4zgtC2zm?=
 =?us-ascii?Q?F5qHPgR6zEEB49yDeyzlVxsLV/Po3SoRuWvokp62s9DAASZUDZ+G4UZDNjr8?=
 =?us-ascii?Q?Kw1EjwpbaOV9uZl4Bxlj49Az8aDS8UvY2YqRoO3NXHYCM1Hie/lcvpvhRSxU?=
 =?us-ascii?Q?hMepH+1QurdX/BTC2B/zeF3FhZfikSo5sEyWTvTWsrDEKA+AldDt2/al1aBR?=
 =?us-ascii?Q?QnkKClGReihQ/BqpukO+Ea2Soe/Pzjw9emhhqCu737QkZGf9lNp8hbAiYwDu?=
 =?us-ascii?Q?ya4P0g4jftRRoOJk+YpGg79J58r6Ag=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hxc6F8fdPrx0z9OysU0YWPXOkKejhbfU5pLxkkskA5Kb85tjwTenwfNB5BLv?=
 =?us-ascii?Q?QD/zk6NDlKMmNiNC7fZ1H6DyhSteLRplvc4/0pD7Qh6TNWsiDca2DcLJ6rhf?=
 =?us-ascii?Q?o83i1nOyoUPkoEidzYHWhv5DRuHPAq8n5NfNXFJiLli4+fNBzXCz3tyPyT52?=
 =?us-ascii?Q?75xSmGD/p0efphD2THINbkE3NTJmrcax42rFtL8qflhN/8z8bhxraQFwgFHJ?=
 =?us-ascii?Q?iwv96F9VKXG9vJKtxTyNjP7qP3N3KU3IVUksF4dhmTltLJGuZ/iE6aI7ePtj?=
 =?us-ascii?Q?Cg//k6drR+FZbo9OYSAYbbMBbjUocqz2r9XTyV2yYmxwtHnNhiTrS+uIou4N?=
 =?us-ascii?Q?O1Ao62xxo43nrdxWdiK+nwFobYfhrr9WpiaNNyP/mIHX6coZh72sp2LTBpr4?=
 =?us-ascii?Q?pTMU46H9pBGiOOId/dF2BlhoBiZfHnWENfU3QWIKh5gurr+c9mKqr9FR2zLC?=
 =?us-ascii?Q?Mmw8hFoI8/+xGag/KKNVqWdnUESK7Bw9xK3kurQmvS12XdgocxFG5sZTFPq4?=
 =?us-ascii?Q?dqGJ6xM1KPJVAZfZTYMcLO05TBbVn2p/V2RapWFVSIThRoZKCKktkA0rJBUA?=
 =?us-ascii?Q?bMfRbmeIXIqaJgst1mYAOCelbuRJEosikWeziGa2bOTASg2ZqtNgkwayM082?=
 =?us-ascii?Q?bJomt4zgFiFGNqXWams/cF+an+bLzADZy+haqZkl8jy7WKSartD4VldLGheZ?=
 =?us-ascii?Q?6hXYklPgXFsZ61lnTxfMqNFYGOPxgjlrP8nhTAgWvMmH/8eAP07qJA//Q8Ax?=
 =?us-ascii?Q?zHFdejQUJ3wU9b/2mjyo4TXkOHqlLT7w6LoV4RH/p8XepsJF6cdc/pLXWA/S?=
 =?us-ascii?Q?akkK7BrOD9PnkFXbSb+EliP5kdVdKriyLpeb05VwRJlnMVGF+tX4IUF+lrOk?=
 =?us-ascii?Q?zjnAY+OGVnhGfnFgPwDJS0gIP3L8PyeyTcJUUs95+poNL7PtWXaqjex0j2UJ?=
 =?us-ascii?Q?CByWE1uhkMSvhJKSvdU1yzhoWH3iFaMHKIsvCKNtFJzVLjj6dtDzokOg4N7E?=
 =?us-ascii?Q?ZXqlFhUTvfMBv4zfYrwKhqBd5whY4r6yFfGZvH46DofcIln/fh7BN8tO0i20?=
 =?us-ascii?Q?+zCxi46bz4dPtVFYIhTOyTUC3mfPYaFZlSaXiI+9eyG2wm2b6usVDUAutvQx?=
 =?us-ascii?Q?8146J/ro2ULGc7c8GTPcMtQ6bbupBhQohehSqHwKbvkBXBx4vcAz4hOGzKdv?=
 =?us-ascii?Q?PQY8jYmFrUetO/Noh9HtSgN+46pvEGf7BuYE5WBDLBnY9pAa90afPkhNAMyw?=
 =?us-ascii?Q?N5WZZaQ8BIb9lapP2zy3YhN/1gGYQfk4ux8LttUAMkh+uHF0ZSNhle2Gvoy7?=
 =?us-ascii?Q?VA8yeC26p9Zze5ftotMXKIeelAU/PIXeY/SsrLhJak9NPbIrlji8g4t/eFzO?=
 =?us-ascii?Q?LJIyoXgCdSPZBZN81hONDmv7C3prazWc5BUVcUqwRpL5MliV9Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee5373b-8b18-4c92-520e-08df3dd41831
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 20:08:46.0333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745

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

