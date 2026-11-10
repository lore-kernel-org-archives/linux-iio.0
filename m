Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342365;
	b=zDVVamyHz/GOHC2ZRlD7D0R9A9cd5lVC6cLNlP8ajJ65+fmiO3B77DYgeKZHa+jTjumx
	 tmQTBmNjBKlX2UQ8DaKZ3bNQgwD/mAdFTW+o7D1tF72o+NbWfvqNN7auERGSARP1c8Vs8
	 rkrApbYzlQhnyPg8Oz3n9LDfp+Rkh/Jxe+anEmZKsBqCugSJD3LLASzhXqnonWBJf5C78
	 mLu11ERQ6JsTjt+kARCgByqF0HLh5LYB5rWUULOuRIRMt7yG3IxgrAlnDSzBs387flxJZ
	 B4Oy63eCuzkgAWmHaZnUg0yhne5OGMpve34UKmnbIeA70mASizfaoDJ7wngRv4cfDJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342365;
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
	b=W3n479jJ4ZTkhAcNmpTuAEq19cXXo1ztLLY8Rshj7Ef8ubGABnmVxCmRrwf24ULoKEfa
	 C73wtLRgyiWvRHHCKSn44s2vJEFqei/CglelPH8m0/54L8h47q1/AaPEkxMLgApb1l768
	 YSASb4A6t4Ip8NsEuB3TaTKeMVpf9RrYOREruyRBVMCCElUIR5pzlRT60e7Nh7cX/Mvjy
	 vu/os2yhQ7bcQ7Zz5rlUbUqU4MAqC+55eDsJdmzG2Soh4hsFLhqCQdeoDTl/A8HVhwuTp
	 Y6fq+xyHtMQ2HksYn7kj6KeAJ8cIzi7P3BoImngGzGMWNA3Io8lJuRRcAZr824qgJ4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=jeNXPa4g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.94
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013094.outbound.protection.outlook.com [52.103.20.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9EB606A896;
	Tue, 10 Nov 2026 20:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A9EB606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=jeNXPa4g
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjS+2eicy2nQC2yb5kyb4CxF79N3jVI3+KdkrSYitJ63DOn4u2uk9pFY1TE8zz+uno0W3eggv3CBGcBs5THiF1aKIJKmtv0PAkyQpwRbGlDpVQjHpV6Ph8r+pStsoA4ymC+/Y4XilQ5o/X+B58drDxTEF53C5J0W6gqXsOT79IOY+hIA/prWvmfb/+CtzRuhhZFg84CC7U1B6/97NVg43A+0WHK5hq3MAJwA7jOXXyeu72YASzeHVFq1mPMdrOI5Ut2d3YP1/NA/FR4leg+1fTlguEkQbffMU5bKevm3b3yEwJaQSLL5bODpV+nv/6ue6A6zUMQajVVVwg2F0z5s7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CapBSMZIciUjEJlH9FahIYlpO550tSMt3mXknuF+/5w=;
 b=Lu957K9WBN+bwqDT/aJq0DnUXREw8hErBWGj9l68tgUGxBpoykYznVzrQf4Ppm4RHa/q9bl0deowBUcFrQ+wwzz4XjSifokMS8kL2QwkNoyolDbzdyEMch/0sJfPJZ1iDIO2lmqyM8p9DuPfV+GC6et6r7lLhjhqDEHL9TTttIethqr2Xbxdb9BhxHPaboQwuqgc+CI805MIwucF/qj++3MEY0zmFLP52EB/236MFEPsFg/zXT6O1oufNfDtki1dbpKQvAJmO+Cc69bFbPEIexvvfSqATMcH2VlNjBydPc7EAQbb4Hp3uaqQ/ShEHounKj+9O06iVDGAgM+gRVdXRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CapBSMZIciUjEJlH9FahIYlpO550tSMt3mXknuF+/5w=;
 b=jeNXPa4gRmFPdpOvNHe667M33IeVYMn/H4c7sFoj2StzfhYXs6kSQCMgOYxsdfD4Tevgkfo8IKT4UFNMw29XWtkduXa1WggWJyUlLychMrFUNRPxAld2o1M2cmkwinrsY6VPpe3z+yc5Fd9DB06wj/ILx+KyphKwe9FZQ3HZ3KBLKenEN+C3VzQR3rISX27FR+LhmCR4faMFG3jYuuXm1TyXdSL1zjqP45lZ/vDqODom3jZko9eR7UUMwmxAJo+fCJ2MMCGw3g8OWqoObMC3yjHtiG/BgmOWQ0fZu+CttIGKJnlg0xS9MLbB3RGFYBxZrgxwwD9VYcHtBMGChyhshQ==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 20:24:38 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 20:24:37 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v8 2/4] iio: add IIO_VAL_DECIMAL64_{ATTO,ZEPTO,YOCTO} formats
Date: Tue, 10 Nov 2026 14:24:20 -0600
Message-ID:
 <SN1PR12MB2528643E9AC2305F3A2D3EB5A5722@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB2528F139EE6C0B4576C3A0CCA5722@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB2528F139EE6C0B4576C3A0CCA5722@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:8:44d::16) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261110202424.1100154-3-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: fdaf9015-4ae5-4c1a-a013-08df3f68a2e2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|23021999003|15080799012|24121999003|22091999003|19110799012|8060799015|25010399006|260925184616899003|4140399003|24021099003|440099028|3412199025|40105399003|53005399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?St7s1QssBtIXduGNRfG8LUIryDPJD87QqMBMDX1z4TjIDft+1aaaInQvoneQ?=
 =?us-ascii?Q?nYUHosrJKKmGEVFN15BrPfpn5HVDUKDLXze6EhNGYVe6eG6CxOzdPejAeA5V?=
 =?us-ascii?Q?RFju76GpYMDB56azOzDKEntdT9a+vsJ5F4aAjuS0oaxCIctHLCvMmHDVRNW3?=
 =?us-ascii?Q?vumjopSgtHNB66EFvure9jySuq73H93SSEt6zaYTVACMMU6azUf07HjRUW9b?=
 =?us-ascii?Q?ptCxyueYrCDiwNfVI8Dph14I0krosHiekwtyfQU3Ea9EFFi9FxtlAHgN0avn?=
 =?us-ascii?Q?DVPiKzHW2lygUq4jhI+TmHm0q2LW9lO7kE+qWv19Ul4Il7Bki5H6FDwW7b06?=
 =?us-ascii?Q?7gsI1hEFaxeR28ywxBe3UmJadLltwFyE443zAROYV/1AlGCcwMwT9OTcO3aX?=
 =?us-ascii?Q?o8e7DbVQvzICpiUqnw3jmKidzjTj8k9b011t/cvvNHMLaos4HNdf53hrZP5y?=
 =?us-ascii?Q?2YhvsHwwjjRXtnXIt9PlB2VnLZDu5FmG5rjT7huRWHtEKafUT10QNkZ5RNp5?=
 =?us-ascii?Q?ast1zXIGp1Nt4cC2YEaoFicdp4KtLTz+Bso6RhJocF0IypSK6NzAJjxZm8y4?=
 =?us-ascii?Q?fyLm2CaYevefr34nzwpJAtzR8uhwgPVGBsj+GY5uOF1Tbj4trqCYdqv9oE6L?=
 =?us-ascii?Q?2JjNUaFRua7B9tuQDTMa6OKhAJCRP5P8/PCTLBtfOH2V0GzZzmWjry1jKxWV?=
 =?us-ascii?Q?ZGr8cyGhrGp2gq1QkFqXjQCVBgGUSPrHGeE6N9XwFmVPxPh6XOobVvFfE33R?=
 =?us-ascii?Q?/TCNBkdW5mrQMhV1VwWkqlP1npov2tbnkDkd1YXpxym7yswx6wdPwQ9XBpty?=
 =?us-ascii?Q?Ha1NY5U6lNZZycdPXe2eveVEwai3BqKIKVVCq83ki/0HAhvygyAIctZ+D1Ff?=
 =?us-ascii?Q?SyqRljGOOXn9ADQATSbb/8lDAqE4IW/RefiznVJIBcz7gf0RkUgSvg66ZmOO?=
 =?us-ascii?Q?a3CgyXfteTp5HB/0LCiqlJfDM9jQpwi1QlUtQCIFeTf8/c0/8zCdRv2J+wQB?=
 =?us-ascii?Q?1S2riJKVV9a0ZpNqOZjSAIoIpcx6u4AYnXasta9f2p1dY33Wzss+2hUq47ks?=
 =?us-ascii?Q?FmgNdCL5?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qBw2lvnEiCc5q8VcDL4X/65Cp/PsZREvv5nZqs5I2EM3hLncd8M4mHlc2Yvy?=
 =?us-ascii?Q?UaLwCwNDGz+NWs7r/6arZqYCzBV34Dc1TIBzAcXAtMWPE5AOjJBFMIuhdXfI?=
 =?us-ascii?Q?gYDjRb9Qv6DXoAto7ZBd7x9MwySQ86t7Dz63xU4iVXIZ1hOt9uKWY3Lx3/eX?=
 =?us-ascii?Q?hSvK25X5RmViZefzIy9wClgrmQHyE2jtOoyOXvLti6pa19LmMkYxBWeI4gP9?=
 =?us-ascii?Q?oR3binl4KKcO5V5Sb1ETBMQGfi5GzEFq5U4p4DzGfNcFkrTNaehSObUYs3tf?=
 =?us-ascii?Q?CkoOyWDQZqxPO2zvCdwgp9P3CqkJQJX48YVDYth/cON7BMh3Y4ghIREdUgNQ?=
 =?us-ascii?Q?b1cskUDO7tLOMLpT6EkJVwCadNMnGgVaWO09oHuFxuNOfdxWo5jhmlAZ5OXd?=
 =?us-ascii?Q?gQ2vzqgqse5xWn9tNI4ehG7uxfbPBNcOtfxqmciX8cAh9vYS+Er45i72FOhr?=
 =?us-ascii?Q?+Qgm6tFZAd+nGG+ql/IoSZZmYjmcsFRA/PXx+nnN4Drdi23lzYTe8mju8wtb?=
 =?us-ascii?Q?8HtYb3x/Ygggkn8lsq3uwJAfH+N+xrITtrpFJeOrjWcKJ5vENnmmlIXMtn6B?=
 =?us-ascii?Q?YWiOyWzrWE2edzQHLUfwEQMf1GMGA5lbbglaKNZbcvtGbo0BDynouP2Q3680?=
 =?us-ascii?Q?r0r4p2ABDP+CCo/sKrSPkHANF+3YanDN5r/bgpdI4DILINj8RUCSu6Kfjz8v?=
 =?us-ascii?Q?1po8ulgVjqOFfG8VYpUCVjrkGFTTpgnp54qriUULyX4f2eif60LHwGAote5i?=
 =?us-ascii?Q?H91s+XUaeEDANOGPqXlSr/Um8ymv0AhLxOF41ugllJ75AORBbA4b89yhD3uz?=
 =?us-ascii?Q?LX+1WG0oLCTJahBSw/9BmvXJKePwWqZvbHt5NzbdSPKug5roBjtUvEwZbs0e?=
 =?us-ascii?Q?Drfp2yyg1TZYIPMBJNb07lpqAAIheTxNDW6Q/RJR9a2ASBTrNO7WHyC1+fe3?=
 =?us-ascii?Q?akeMJybFleAkSU7wRN2uYZJ/qttg/R/JJne7Pdi+mP0lDSzSYNlr/3uCjECi?=
 =?us-ascii?Q?g+35MoSIdiDdAsCT+7uVq2tk9OC5tURJevTbbfp1oiMevb1FzDQsoRRnZrn7?=
 =?us-ascii?Q?t9u42TYlwYG5zOAj7VYjpqFkaR4vbzu8Qn5D4ETIBpdz5lb/HtOW0UyhpNCL?=
 =?us-ascii?Q?9kFg/k8geBsc212ZdUs0eCJuLhvw6l1gb6MePo8w1dpahPpDH8bsFZ23+FNx?=
 =?us-ascii?Q?mUKkLzeTymhkux+8tetaBEUpviGnmUfxAiVcrZAKG745KgZOVsVN4GHGcNDq?=
 =?us-ascii?Q?ls+mNDEfw2CVRffEf+iH6kodNr2dfvCs7RrHgBXK6uJNfdywvKWHaygwqjQN?=
 =?us-ascii?Q?TA1ZrSj1NoPdxrumMkDBKfozTloCJOg/c5MUJl4aKCWjYjMEUroMRftB05UI?=
 =?us-ascii?Q?NiF3KRkfo8LEcWjhkdr7LE79JFKHQE0zQIceL6FPCNZMmDvucQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdaf9015-4ae5-4c1a-a013-08df3f68a2e2
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 20:24:35.3880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764

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

