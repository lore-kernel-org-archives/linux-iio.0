Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793033497;
	b=ND0L3BzQQ0BgU9Fr66tDdE7hK9E3qLqC1Ujsz94MCjlOEYy9TfM4j3og1muHJHTokyv5
	 Au4+HpxqOX2gZdYj1HtbwVptAjoov9cnWeKhivhK4fFLgV119/0Uhao3+6caDyqJwQp3O
	 FmVgnvge21qKM8ZUADRZQmVWiQL64TlYpQfIrfQOH1joO0ke6mLWLWc2NP0WwQnRT0cNh
	 CKoFFY1ICiiq7onIRjtqc8HmV3f8sr3UbNh7oTjXBWhD0pSucZH4BiQrTIRQ/D2bt1Q3w
	 OLPvm0Bhf+6Zw1/FzVljHWOMOFEfaps8TKlU9WH2fa9Tq7WzAv9cbygDp87YXof6FRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033497;
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
	bh=p0fwZUjdsDfJ1FzgLBPngQMiOL9ryYKrUA6rkTLi+U4=;
	b=1GncSZg7lSu0vvL4EIROy/sS5h0lSzo6V6aQM26el2w1fisKNBi0hGPy/hWz+sit3pGx
	 S7ts5Z+nh/YW6tms42Zf1GGMyNGKMQZ4cfxrJYAC6KHGJebBRf/qUX1yTubf3idTSu18O
	 7quUhySHPLR/0JBMaO9BFSVas4Xp7+4MMC+/ALSf47o1IeFxtESaDd5QDOT1Q1ff9DHp7
	 KqUdojIImawUs+e8rHrqQvgEzs3b4gNegB5cCFJ2wyOZ0j3+v2iN8Q6vP5QkL1Al5H+85
	 JWugl8SA8m1eb7HHWIQZhVb1LMS5LayUQrn5rUtYnuvWTSBvw4KD52mbd/N9aLmxmtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=q+vXoc43;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.44
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012044.outbound.protection.outlook.com [52.103.23.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A15606A31D;
	Mon, 26 Oct 2026 16:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44A15606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=q+vXoc43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwFTy2mk53RJVkuub6xDA+k4bH1g2+e4csZ3jOjdOQNxhyTjZRrp+Yx7QndWmrJvBMMsayFw9KNmW+dDiNgdd4+a75BH/wBNK0edpjKdVBGCJQg6om4uV4DTWCPwA3dHJxRaehNVbLECPsJRRo7WTIPeiITov0IpTZRmfwpG2oGfBpYeatKJ02DVkmhhgNh+6SRde9Ui/pTULUo0R1MMHE6+EgcKzUbWlKjS00HK+oXCloc1K4qEZJqj4PbYErZHuq29tCiNe3j3P5cRtRM0D3vq9ifVQHwNanDpxCj4CZ5SgVMSQbk2/cS52lnr3UXQ52tZIQgS077qr+R3NO897A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0fwZUjdsDfJ1FzgLBPngQMiOL9ryYKrUA6rkTLi+U4=;
 b=FfUjLEDFGvI8whfiKXqOciqyFxsr4dafKPFzbRpsUYp6dy0YUhzBzkyHTSdxT+rPn9eCm2WkP31k3I55r8al6vRuA0rC+DbyTnY+nR1kViMME2anlvSf4hCoeY15pmyB4X+hJM78AVVYOKsLSI/VqdAjJRGwrYYg0s9D7S57+SLarkgI0HHCNmEkc3mjX8lJdpRrY0Yu/+w5jWKODxtqwGhgufsTVlq34/XHWUwhISiGib5VCIH8mcYrCobjRy/kSBlVEm0K+TtlctWW2dPbOFxx/oaeYHJQEDU1aax8wyqnzymr5u5QL04J9rv88+WSLLdo9qIyLj9Unla/PUTupQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0fwZUjdsDfJ1FzgLBPngQMiOL9ryYKrUA6rkTLi+U4=;
 b=q+vXoc43q9450CC5M6uGm3jtFDWxQ2AZSf/Kfk08hqYG9f2+rAgjTFyuUsbuHMfeKdehSaG8AZXKEuIBVQgCbNyiOmS+/QP+Q0Y3GsVpUOeHl2N+C8QMkUlskSFxvFcwltWYVGAsM6A0QKccoROP7vUT+ptfod4063NrLDsVGOyAhFtspOE3Oxr+/Y1AwtCC1DXh5YELM4KohD0Ypy59q8/rPj51oP09T6bI1PirgtH95bq/xHYX3egIKkZAowpa1+B5hRaTjk6CgTmh84UgwIevuANjxbS8sZIMIW4xEMPymhAsZhd3Y/4dPuEp0WH8ZiUTgOIgLFL5Yf6KQH0/KA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by IA3PR12MB389676.namprd12.prod.outlook.com (2603:10b6:208:713::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:51:35 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 16:51:35 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v3 2/4] iio: add IIO_VAL_DECIMAL64_{ATTO,ZEPTO,YOCTO} formats
Date: Mon, 26 Oct 2026 11:51:12 -0500
Message-ID:
 <SN1PR12MB252883C7101859CE4C5CE867A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB252882C0E885BF3368E036E5A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB252882C0E885BF3368E036E5A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0093.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:25a::17) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261026165124.119890-3-chernyakin.victor.j@outlook.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1a599786-cbf1-4c1b-d18a-08df338164c9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|20031999006|22091999003|23021999003|24071999003|15080799012|24121999003|39105399006|5072599009|19110799012|8060799015|260925184616899003|4140399003|25010399006|3412199025|440099028|40105399003|261007181701699018|26121999007|11120399003|261005200801699003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B72hRmZVj7PoiUEsdfnWICvg9x0JJNqheDJ/30fI0XS0+bRYF3PJy/Z38lVa?=
 =?us-ascii?Q?8yRSwl4DfVFo6aLUAlTpp1H1PqjSbdYmND2OTdjveQ0YqYLJOrzJfIdyACTW?=
 =?us-ascii?Q?uenwh82wh2PZOfikTF2x6bdBmndqXz4BxZfSRd8xN1zy1smBGXDuuajSBB9Q?=
 =?us-ascii?Q?1ShPHG+yr/P8yvO4KLDWBr9tFCjDOmvhoYDWsmNTgVvfFa6OqmPs4/+q34P9?=
 =?us-ascii?Q?NCVnBQDFwTXxjGEq3gU3ZclnX13fP/sYV7us/cZHMHD1dNmsn4ynQp2x+R6n?=
 =?us-ascii?Q?eLgpJ/t/sZssp8vxr1jmUs81pkod9kCrZEO3YTADdt6Tgnde0HIA9oAdAV/p?=
 =?us-ascii?Q?cTftwo1vWLAyJO28lO1hVMkHFmIDcSp0suJbm3BA37yqnrfiS9b68iyLPGdo?=
 =?us-ascii?Q?QaRFWE6UHFYCC8B/PnAp78Br3Eg5rpqeyAmAynkl5gye6vwshkLPAuTHNnf+?=
 =?us-ascii?Q?dBE74Hg+cluFlQa4kUW8I2umq661ZCdn6JzX4zCSGSHgCq3ePZ2GEOJJHx4/?=
 =?us-ascii?Q?H28Y5zMCfhnk4CUs635u4cnSqkLxeI757FRSmJ5TS+Vvo0JeQ01cAn7WIgtL?=
 =?us-ascii?Q?iM7atIDJ5kKr5LbcovQf0O1U7rwMinVTSXuo2FKa6jgUw/7bCczdJxwPg2xy?=
 =?us-ascii?Q?8L5yI4rD63AeKs3lEYzOQO5lrsGnvPtGqwYMIF4j83wfVMLEcDLDo5ZZrtz9?=
 =?us-ascii?Q?1e9fetEL6ZemDdOGjXnkyX4p4B0GXTZlTn74aVQzkoYaypf58bJj8zdsPxBZ?=
 =?us-ascii?Q?hNWZcwNyzs/2adAhkMsjKKstBWZUCwXoscef1F5Ur/2kMt1MO6OHbZbCqpKz?=
 =?us-ascii?Q?+hupZrEoCmIZO/IDSMLsjD1S0jNfi2mugF/GPyrg66FMGxYBCP1SybRUFE73?=
 =?us-ascii?Q?KL5+2TaeuRSARKHlsNPDss0zEbjCSl0qeA5+lFZzYoz4dZzvomYNH/etyVL3?=
 =?us-ascii?Q?F/CyIh9UPK3VgE3roQakqzxX/YjX9Q+47hM4IWZpOvFH5QjhHk71sqgkh5Mc?=
 =?us-ascii?Q?PS148VzMIM4YsvQX4WqASKDWIanD1QiA5I/rdmGOBq0/axJpjLsdv/tvC42W?=
 =?us-ascii?Q?pkyl/ZMJvjcv0vuSbQalh79U8iWFrdsazXDEUgvCXv7kTP0SZqfbEEEI3LDG?=
 =?us-ascii?Q?HwTP2/yq8P5aOPyGDrmKc4k6GHun8t8XB4lsVStLxLdW62uFRWGngBI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XfwBhcjLDR4CmPlqYl9+C+k+/++uhGpeMO2igsTicKfNrghnoVNS1KZiHLV7?=
 =?us-ascii?Q?/j7+y6ztv0B6wLAId6OzcVliKVYbEGRT+0I5yYI6Fc+17WIIOzQ7CIwAMunk?=
 =?us-ascii?Q?9cSivyOJjh42xOR4gXrO1S0hI75ZmXY5gHmeR8JHSrLQaBVU2JhRPJ4Qaqwn?=
 =?us-ascii?Q?zJct4TX+YaJQxpFlybRQsAqR5p8TTlLtcK53sxNbXzpqkRL8AGZMViRAY+Ez?=
 =?us-ascii?Q?QclO4r3kTu0qa+Fov/CsZFPHBpwAhvgnppT4IhtRECLzO9klKc3+ORRVxjQD?=
 =?us-ascii?Q?wRx88yrV7Bkyklzi7BC05hh0buPAPGQWU/7hJcrpukMSVE2Tmkg5auprVVRG?=
 =?us-ascii?Q?CAoq09t3WUjp+smT0fhStp1kIXM/GQ/tPOtTNknedpEnkFKD9w9m879F/vaV?=
 =?us-ascii?Q?SCnyIoELMhpCUBdKmfJfMgKlQpNSEsF6ut9DJytQijlknrKd82SNC8GNbTw/?=
 =?us-ascii?Q?37Mj6SzBZHgYjdiObXt6bJfv/fitb7GZaYLfxQpf6iJ0KF0eLbdPzYTlGzBy?=
 =?us-ascii?Q?So+9m0q+G+RLIE/dXI7WfIyI101Sd35fw5sYKStXyzzkgn0SFZ5dDfWbCNOy?=
 =?us-ascii?Q?peMLYVpGXDcvwQsnFJ2bVE0n+f/R4kriPZKe/7b7SMhBP/tsZSSWMF4FWOt2?=
 =?us-ascii?Q?mwz7Qu5hWOlQSU/OJa6l61DVC/2E4W60TauQ3O24vtCXvGKjkW3/JAEz12/y?=
 =?us-ascii?Q?ydov5tnLfLFq+UI6b2jLzrCRAiQcPfMkb0x31ryKIZqg09j640OvRDCh5nKB?=
 =?us-ascii?Q?ac10lCHsmtp21hSdHdopP01t/wkjIC4T+dnQAtetIvoMiCPNH59XJNaJE3fs?=
 =?us-ascii?Q?EqOAFn7ZxllE1LM6Nh7u0x5appP1xXttzz7ldtiC2jVCXfDlkrkTyEkUY7cM?=
 =?us-ascii?Q?S0+4jYa84LzHKw8x5i80zrKspWn0mder7LyYgKv53SKwifhiWieiNq4fLFOU?=
 =?us-ascii?Q?CbUVzC6yU+iVEt2OQYBCYO2RsAVEwATcmSXT9IL0OOXLfxCz7U4OxOFjlrYT?=
 =?us-ascii?Q?ER2AyNQx4T7lxJJc+y6RHUaAa/Yhs7ux01baBgUYN86FgIF4yTAv64b2INVz?=
 =?us-ascii?Q?xbRiKkUtw5vXqrbg4JgstoRrQGpxz8zvMKfRDqZNFnk9CPfB3vlhFt0kiXHJ?=
 =?us-ascii?Q?+Lyg5iykRkmEI85XEngg9kF2roPoXcKZ8IAvFBEI/yQCZqLkOE+1mJw6kSoy?=
 =?us-ascii?Q?nMaIBpEBinpMtlNMlcNGKt7+G3e+YczXFaWLztlog2O1ILaZ0g6qc5uS9ONB?=
 =?us-ascii?Q?0frOBJXPryGVlW0pAZCpQzFkaXLBgLgm3XG2exBM+nxSkw+Q2hTtmFYP8Z5h?=
 =?us-ascii?Q?tbiHU7KQ5l2M/+AgTZWrpBhUl/QdSfad3ZKaYHjRJXVhPR4v1QH/HD7vdbkf?=
 =?us-ascii?Q?qHiKnZTmmu2nQvuK+ATpPjK20p34hEXwI9h7Poe9r/i/t1zB9A=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a599786-cbf1-4c1b-d18a-08df338164c9
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:51:34.7857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB389676

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
index c30659ca0544..632d91e09ef2 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -728,6 +728,9 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 	case IIO_VAL_DECIMAL64_NANO:
 	case IIO_VAL_DECIMAL64_PICO:
 	case IIO_VAL_DECIMAL64_FEMTO:
+	case IIO_VAL_DECIMAL64_ATTO:
+	case IIO_VAL_DECIMAL64_ZEPTO:
+	case IIO_VAL_DECIMAL64_YOCTO:
 	{
 		int scale = type - IIO_VAL_DECIMAL64_BASE;
 		s64 frac;
@@ -1052,6 +1055,9 @@ static ssize_t iio_write_channel_info(struct device *dev,
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

