Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793459628;
	b=j89sKTRRg1QxpQbXWxcKGbm0Mfzgtv/Iwsy4UGojmvDHNhxkrZAOY4m/lrHjgksDhVKy
	 hph7TP9XlM2pVfPFkxvoaKJIsgTAYE88hFddUd93dJnb3zMCeXRp2bTQtkMRulV9ZCR7F
	 nSwzakbaVtX1VOS7gzbtRlGwO4WRDmC9tSgp9etrlt3oJoO5P+LIqpKeO7JQzJeOax2Av
	 vgFUA9tE9suNNZhErfCsxfSornAOE/UUhFqxGSCUuZK/RtIUhbHGPa/K+AtkJsIsVbEx/
	 wkXM8tl1/AdIGc1ypMJFicGaoClS6dplnZ2uYjazJmYAED4LdOfTDpkV/WjdfdiUIyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459628;
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
	b=3WjrnfROokdp4OCKS+eJB8ZG7fIUHFu7VXzaa3HrEt30QRU7b1P3GE7porMw55COO72m
	 WhQSyQ0GhjaOvjto9j0LgKksOwANI0tCpWz+EoZnjz4vCwMi/F/O2+hWgxQnsApwONf4B
	 tKzHO5f34nMg3hCdz92zBvfy9By6sgCO/ldP7w07t0VuHFvL4sViERQlpF4PoS1AvK0s5
	 H80CmtW48wEInRErOtwy5W51PMQx7FEAcWhiwoo9uH5VQv6hkNoecjZ3jJlOoFmTPNL4n
	 k11eo5SC5iwj9j9KQEds9hj1tpg1We5jOIWaM4ba9FkliJSoO47NdzIn6TwPPEGPUHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Nh2y447Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.21
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010021.outbound.protection.outlook.com [52.103.13.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A42E606A332;
	Sat, 31 Oct 2026 15:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A42E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Nh2y447Y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soEkS5//zalEXLhXiydcrvnLk0Sa7ZK+PYRNKIThQyHLDZvqcq4RO4hrKig1QFx/pNmw8yg5qwmTRM4lFxr9wrVFawbhrZxFOZ1SGQIGsTaVLzBvcEXKBqtVG/ee63RYvX35cUFEv0mP58iM/x2AkgrnOcWRBNEyE3QEy/59wTrDT74m7d/YUB6TO/rrI62VIdRWfoq+EPXfdczzLbMbbxsc4YiYmS5ySHWOxYWLx6F2XjmzNmLJPoscaShSid7xxiQhsUeSbr07DZXQuz3JbCh/8PeHCG7/bHxNUunTxa5c2AZGGKSf0unmW40r+5QooKOP2YaegeAo18jG78ygiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CapBSMZIciUjEJlH9FahIYlpO550tSMt3mXknuF+/5w=;
 b=zF97AuJgPpvcptbnNokbrBH/Wk12dKvDqahA2ThG8STlx6XyCFUbGOZvLY/dMtK8JOst9ieW8mSKOTeafF5NaR4kmYly1BnTc23fJBFWG4SpAEs+yCstZ7rN2rmSENsLvi97ZtoN4FpAj9+Y/fvmrfIjzp9/j+OFM2V2Isjs17HIckTkCtJkbAtpNjWyZrTwHpEP2e0oAE5qP93qe1Y5wr2xtQEqHHj6znG5cEsfFtUY4pbUXXXHqGeiokjX+a6YqgWKCh3Q+7mJNJjAgEYkArQ7JgpAtOUG4bg+/0ubVArTptrxRoGlOlBlIR99JGXJc0fvNfnqqsDJxhv347eGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CapBSMZIciUjEJlH9FahIYlpO550tSMt3mXknuF+/5w=;
 b=Nh2y447YFNJc+Ye8zwGvB5kx0d4qqZzbCvMeGKYI0KSZOCY2UPhdy2JKf/7tH4ZAOGabNb0BLBMJLt+YNt9fmvxe7xIz5LDh3Lj8O4bLe3Zjhv31jjmEGgiWbc90HyWBGRXJ9z2PD/G6kuPvXHIb946QjXHakdsHL1umj12TDaURE3tjg7yNadUas6KF7NkZPaEPGYuIxIKeovCaLgWdVYNXVcsfTDqyHJblHXd/f28QFsuDrof3OMiQg4PXfgu8FGucXYLWd1LfU8w+qfJvV3fbw3GaFoNNTfjhzWcWKwk7BRxi7HncFXTc6OYyOMMvTvmP+mavI6r6B+Udcbig/Q==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by BN7PPF9C6E5285F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 15:13:46 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 15:13:46 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v4 2/4] iio: add IIO_VAL_DECIMAL64_{ATTO,ZEPTO,YOCTO} formats
Date: Sat, 31 Oct 2026 10:13:28 -0500
Message-ID:
 <SN1PR12MB2528B9D3CB68414EA235CD95A56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB252803756D5D1C8F35122B8DA56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB252803756D5D1C8F35122B8DA56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::23) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261031151331.140654-3-chernyakin.victor.j@outlook.com>
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
X-MS-Office365-Filtering-Correlation-Id: 48d9d02e-2dae-43ac-6acb-08df37618f0f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|8022599003|260925184616899003|25010399006|24021099003|15080799012|23021999003|5072599009|22091999003|24121999003|26121999007|3071699003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4EiK25w2rLSActhETW/Watg9FFct0RLmLtoIKYFD44/VmV5Je+hJkNn8z3kT?=
 =?us-ascii?Q?60/Ykb7pHu2YJj8Sl/TGWuV0861LieGEMZo64RlSmQTe/MOPNDJTlrWGP8Cj?=
 =?us-ascii?Q?lqIH++VTXRf+pEnTZZbStW4P38ZJ5J5HZ9wEV5pZuKHKEn6s9fw+Y4iGZJaI?=
 =?us-ascii?Q?LyJamHfz9CHZ0z2WmJTn95U9Drg5WA1US3XNL1wYqcFS09d1Gum7we8CUWJG?=
 =?us-ascii?Q?uvejJhGlWs1k6TYxj3qu/n3kj2PN43cSZP/T828Pegul9cGSk4yO3mR+w6W0?=
 =?us-ascii?Q?3r2fGgKJku3W7CIYLbynEOwr/fEHoDB79WDpQx0vLVDm14UCPxMi/gDxYywd?=
 =?us-ascii?Q?k3PO8DSaVpYlTDoFwogl3tQwhXpaXOHkHYIgWo3rH8LxvjNgFJeL1mSoliw8?=
 =?us-ascii?Q?8rQ7/bhjI9ovYiRCS3cEe0CxJYgvGu7weOWh/lJnCakWz1OZHpJwqorUKC4g?=
 =?us-ascii?Q?pF8zcC276uZidEHOgT97XYBT84vtTz5ats+fB0RoWfWuh6Y/WAZVbDX32D/4?=
 =?us-ascii?Q?vUKwhVzmvUJ/Ztw56uJRhqinB7C8w9zEPeks7BPmdwWV2oJ+XlixVet73V1y?=
 =?us-ascii?Q?NdfZod+uaE+111c7j8uG6IeuvvLVwK0LTl1BOu+bdAf8r02C/DoIpOq/PN6u?=
 =?us-ascii?Q?K3haocM7FaRuFsoTKGVG7IRShDE68s6Rkdpg5rdoSiHhFVa90qPu7Mr0d/+A?=
 =?us-ascii?Q?SNrR/jGGUzbB+xYGMBXznfViygtwLGkiWjRudssQgZqGgjbQYwS5l1KwQpCd?=
 =?us-ascii?Q?AjqVTf4WWXzB9NVjQLEobox51asrcsXgoLLE92JKgCxhDpw5BmAITVD5OK8K?=
 =?us-ascii?Q?TFOZRJIZJr5vMRDDFcniNXRTzj8Yi8XUFG8QFX4Wq8jcbiblQ4YS2uMrzq7O?=
 =?us-ascii?Q?NtjgSBq/gZy432489zS8/fcYrpHKS3UvHyUn0roGTHMW5noRgK5WHejvxEVE?=
 =?us-ascii?Q?+zsl5+I9wpyQy9ytkgk07qECCfoPw5WJXGMSWWNWMPbuOls9Kuc10oBE4Psb?=
 =?us-ascii?Q?+wJvn8fSgSDdAzolU0m7XXds5XABgbUHseepxvccq3tWpLOkPZs4rUWZMoiU?=
 =?us-ascii?Q?ESI8srmz?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vXDZf0sVF5pDov5eHg51zHJ1XCS/jljfxigniRSNJ58hsq4g2GIFGy6CahdV?=
 =?us-ascii?Q?BG1QBy3WpN43Z9GLpsKmZEFUXSZ9U2I40c0+bTnyYn+W7UGa0spdKNxUJP8H?=
 =?us-ascii?Q?FJMUYrvCFjHgHFodrsnnKN8QhUrGbAcIJU4eu9CGdLrklzeuxkGKRsar7xrq?=
 =?us-ascii?Q?McGrf/75rm0Ln9UUMPfCkHXp9c92Ietk0TsHhEpONVo787CYymnsotleTFrs?=
 =?us-ascii?Q?1U6ZnrYdO2a/e/0irK8XABgvl/gshM+mYcuOc4m5ZwBvQcbbBPJ7U3N26Vt+?=
 =?us-ascii?Q?Qnk5fmUGF0GNxIMj4fZUmYfdPUt9+RhWT8Ofj+FCHT+Unq6jHj20jZyF5Q4S?=
 =?us-ascii?Q?mg0zPJiQ03AJF32XsWLtCyP8aj8Lor9ouJq8YaD80TpCXE0BrfFiuCo3N48f?=
 =?us-ascii?Q?XJ7MtJBUBVZC9mvCS5CS2JJ5epssReKK14liEe6kuEf9p3UkqocrcAo6nVul?=
 =?us-ascii?Q?JoEWZzzXaiJToDR2WwfmHGbbjVzh+/BWrf6TcmFY8eb7xMGpAmui8N3Zq3km?=
 =?us-ascii?Q?XNJgNfwd0H1qiS0ycNfRycz86x8AHVpf0jpFXi1zcgeTQM9Frv8KH78dl7S1?=
 =?us-ascii?Q?H84qwOWgLo5e4tyTv5gcChvDoyytqCGDlru2OQ41oBuJRcd8poV/8gM90GMV?=
 =?us-ascii?Q?kIAWfHBIpLh5+BfV6E8VgxbGh2037hw+/+ZLnnJ1agPiTL1cPZ6islQ5XRMV?=
 =?us-ascii?Q?AohMkRqTCBQt9W1r0fPAsQZTw5vqSbJEAP1g1O2TeA+U2037vMfizU4diFPX?=
 =?us-ascii?Q?ULrajdTKXGKu4Yeed9rKyXHQ39fwWDTIwQokk27mW0/mMumyNxDhZeoTXjbz?=
 =?us-ascii?Q?/QO9vqHxi4nx2jkyHsUYBguklI982QjIl7S2AvucVGlvjk0nZJlKhE6DxWSP?=
 =?us-ascii?Q?2fBM3MKxwa5U0N+IUX/x8shNFNdD3hES7p80WmTpJBd7KypezaFlUh2nBhdm?=
 =?us-ascii?Q?vsPBm//vxji8+5dPn19QHCSQkaYZv/389VbvugJItyLcDgIge2Dp517vuiqN?=
 =?us-ascii?Q?tA5lhtaQGFZeOGYpkBd2+g/nMGize/sEH707x+tJNCnx/QhRa3UF8za2F6wY?=
 =?us-ascii?Q?nPz0Tb/uR7nqiae7bR6lAy9Xf1Bzj+Jy1sKY6saixpWUdkt9RVTKVoTS7j1l?=
 =?us-ascii?Q?CgvonRir3yk3aiZrYEC9zv+Q5mlgUDmbsmPqmjWLB9kU46g5S/dzTKnt5wpF?=
 =?us-ascii?Q?EYuCisru2NTHsuofK0mRaxmwkSuQmD80OnICVWYdYiBOTrQUC6CklFE75vJq?=
 =?us-ascii?Q?R50GotgrPHcV3WKR8AyeJGw2APORS/NdSre8ILQvbJTH6W5e/5Sn56QUZIsd?=
 =?us-ascii?Q?59DHND6dv4C73K1vSg/I1y5o54ZViRSQT8JBelIGlcRiuBgigvFQIbaXguzK?=
 =?us-ascii?Q?3g9Y0iNi8SgoBGTOlydYZelB3IMor5k1IX+VbfD9URO5Rq6Ong=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d9d02e-2dae-43ac-6acb-08df37618f0f
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 15:13:46.3787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F

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

