Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793033497;
	b=BTv+/pwzsqht+7yJkEcF6E8zHuyHIKmJzi4l29/xOdcmyyp8PXESf+Kx1BSqRKrZUV2I
	 Io+aheoG/RXKUJv8ZhPzHi/mHAMMUmq6YLtkAy3HZUV1ME9jqiCkqC9LkHIW4S3Vn7xe0
	 z4uAehoL5SLqLif3ZFIcIOma+627CZwK/zXvNfHg1tA9KvI7c+qBO6lLcChbEFmXhV5MT
	 6edEeC468xqiqu7h3EW0L97t0ewwnf7i7K3ZEo5Rj4hFKrkW8HKpUik4zlRL4gsFl2mq0
	 kyWntNAvx4WsbwiZl+0uTtvXngf/AqlriZIRPdBb4L3Fr8w9pr25fHf2G7JF+KZrusQ==
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
	bh=/85Uo8ss7ZQq6Q2+KG9C9HxYnrpNxU98P6zmN6RyqDg=;
	b=hYvmADEeORU3bzzphPS0B/xYwf2wQ12bv0D/6rp/ZHL0OsFixjdfpfVQrTiD3IkeWM4W
	 vVxmNukN7nsaTXiaclBdvagXOiNp+iR+oF0NV5b0yivrY86n3r+oq6n+Et1V9vCBZjzQ+
	 pIircgXBMWL2u04zzF0BTYty/J+LOQDuUaNcZEVYraIihHD7npnWdYCVari4BN54YkWJl
	 5OjENzIOxp7Y/ZlfuTSkuIdDmL0UHhMoOD04G0vOPcU5jXQnDLpAEg6YgVCla2ghjNGKz
	 0ZjDt8KICRoAFWlvjmVyHmFltPncoljKLeJ0OeB4xGLvHgMwimvEY5IeTB8LgSICT9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=RKHWNsp2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.44
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012044.outbound.protection.outlook.com [52.103.23.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9AF606A321;
	Mon, 26 Oct 2026 16:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D9AF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=RKHWNsp2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CL34IJir0nw9FbFZ6TlyvzNi72siY+L1NOPo/12ZTBapb05QD5Mk9k+/NztaJFcH9TsfdiZSQCkbHLBkMNQcmA9citDkKuIs18lUSjfngU8rjK4am1Jk7fyIOxq3A/g5rJz6PpDTYrKxym7Ju00v6vKHocvgZew/JOlu1QSv7yCCKJpVaH78PfBtAOcudgyNwkAl64/isl+U2rh6Y/Aqpm7NLWBKUcP0Hv8o9NIRsbPf9qh/FHZXGi5MJvf1E05oU94MKtka5BN2PKjP+26ZWqB7yCIjY+LZPalE3h+TtUdTjYRl49cQghD81QS0jC8bR8fNBg5uUFN9cUUUT7nCgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/85Uo8ss7ZQq6Q2+KG9C9HxYnrpNxU98P6zmN6RyqDg=;
 b=g5JmF7di821r+EcDCPA3JJJS2i4VZGhWSEqhNRcrvD5ThH6MwxgLhPXSKcxxyG0BeywQaIuzGzbSaDPru70Kcd2fEGTQZNC714W+mG2y3Upk1cNlUJ1GNLWy30yPuLTKxUXP0EXjTxN5MZYEUni2X0Tw8yAyjt77l92BU0RpFa5zVMHkwqroQZyC+wbWZP5HH3qluUbONunX9Q1G5tUDURWaJ9uyGQFb57W8ECV4IyECORaG56tmAkLfj7VzVYSFL1KZHH9PVtfHHfMwG7IhBLJOZHjPUvm6O90IKKsLP4QXJ97eDXAO7Cf1XNgh4QjiJgCnLqnkMoOsQCRTCrNu7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/85Uo8ss7ZQq6Q2+KG9C9HxYnrpNxU98P6zmN6RyqDg=;
 b=RKHWNsp2UW1plyuAE9AsUzBlRGFypB2oQb6+oPWkvaUgNQF+OAWd8/nYEryaDstzAyAY8An5mx7TXzV5y51TlVOZhmdUGlcNqSub6jwjXOA/swGGQkmLGYavFp2eSyPpU4wArLDmyL0jOaPupStMex3Zl9umDI3PbJLZ3QE8AqoDoP1gZ5cALvsDhTyK+vaacxJTn71KT63SByQSsRNxGGPM8Juwzn5ID7Vu6SrpwnOiJfWd8GEpeYugF+3hWZr90VkMocefI06BbnBH1jFc1y6baVcrG679MsUIWTsJrB783gNFqclwpvtUTP2fWakTlNqXgcIBUnli/zwzF7hYug==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by IA3PR12MB389676.namprd12.prod.outlook.com (2603:10b6:208:713::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:51:34 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 16:51:34 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v3 1/4] iio: prepare iio_format_value to handle higher-precision IIO_VAL_DECIMAL64_* formats
Date: Mon, 26 Oct 2026 11:51:11 -0500
Message-ID:
 <SN1PR12MB2528906BE220765FAF201080A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB252882C0E885BF3368E036E5A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB252882C0E885BF3368E036E5A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0093.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:25a::17) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261026165124.119890-2-chernyakin.victor.j@outlook.com>
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
X-MS-Office365-Filtering-Correlation-Id: 757c15be-e94d-49c8-36a7-08df33816444
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|20031999006|22091999003|23021999003|24071999003|15080799012|24121999003|39105399006|5072599009|41001999006|19110799012|8060799015|260925184616899003|4140399003|25010399006|3412199025|440099028|40105399003|261007181701699018|26121999007|11120399003|261005200801699003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/o8DtnCc74Y2mhWJ1f2m9vH34TOZO/sKJ7bLvQ+qp5g4mchxXhyJ+CCmtY/6?=
 =?us-ascii?Q?wS+NUZr7iEBY7TyIiw3Qx9AV5cKefKHS1kdRJSiNaIwJg5G4rqvvxG1UdekL?=
 =?us-ascii?Q?1Ov0ssIpX/4pOwVBO37hYo+P/F8yFoyKg0dfxfbO86qBFUC0BDhwCP1Y5hmC?=
 =?us-ascii?Q?9hjEmAIwIhKBz46ytQtzEkp5m3v8Yf7aeMnFBOEiMZhXMt9cFI/pZT/LQWFC?=
 =?us-ascii?Q?laCuUiRSXtRIbp+pjnv0i3dxRgALS9pQqeUGpps+CAQjYg9696Q+wB6DJqkD?=
 =?us-ascii?Q?v/oIe4jCr9lwdPGIImffCerc/BVxVndhwW036E3kf0hJjvhnwEF5wJdYEDC3?=
 =?us-ascii?Q?mPuw6DwfVgjqNtPYQdPWsEac/300QUFzG0vAcmWIKinEsAk/tIX+U/4Ku1yJ?=
 =?us-ascii?Q?vO+Ltux1TmcG1rLsXM4b6hgxZ/bpaVDTcDzPlpsQm/DuOsNBd9TsJRlH/9B/?=
 =?us-ascii?Q?TcHKGaJqRszJn5h1k3hgD06shjp0W1h8l5rV0b9NeEeZWMWR8aQH8WAp2Bcw?=
 =?us-ascii?Q?QJNXpK/RJeNsAHTcszrz0vtnRVqoJf71qD6gYBBwUQo/dqm2CyQ6k0oBcgkY?=
 =?us-ascii?Q?fzdEBEKfzlYu+q53GReqIRowRGJPtE4upjN7z/7sX0743aoj+JN3LezRx+tg?=
 =?us-ascii?Q?5EyHE8YWClKISJe08h8rQxddRlau1/bvveSlrhA7lGJT2RvQgosNiXb4Qqce?=
 =?us-ascii?Q?pYwMyc/sgvSC/gxuMQ3jFFgi3u6o+PHx5LpJOMu6Go9Z10EveP3puYiS/Xfu?=
 =?us-ascii?Q?J3E3fhog2TpRg6FBxpPFPub3Kwer5cVwd5R9M6kWiLS4gsEt1WmCCMCZKI/n?=
 =?us-ascii?Q?7MQS0sx3aQ76s1lW2+cKHViykQh15a/MpOuK8HMbFdigtuAk76Do3h4TeAMG?=
 =?us-ascii?Q?UIJnz0yyTuyZNbxRJI4L4Qh8Pmau3IuTVEgr7S7F1x7p+HcxtDeHsjElC+Fp?=
 =?us-ascii?Q?B0Xayj2+lyVYoK0lmqt2fWsUcOIMBXnLL0MOg3qZoh8zD7+zIGk4qlVkKD7I?=
 =?us-ascii?Q?9AYKfUU2Hye7+jFRpOfA9g011joXdOPnv/NLpaQASxDvkSZupKAnVa0BlNii?=
 =?us-ascii?Q?ppz4yk59p3jCrXI+RUFSXcFEAZ7QFotQFswoXegDsLbMiDUj3BDo3JH+rIQV?=
 =?us-ascii?Q?HB+enfs7Xy7AEOXdbzNjUugRsXKzeeh433sZICZimEklj2PDg57k9SKPlv2J?=
 =?us-ascii?Q?fcl6IHrMTLUOIvvDF6emzmsGoWGR7VU1tKPGfQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?36b7B9rey9fhdsbtD7YjKdeQ7u/Jd7DzEGTNnEF7VAPt8kW+K8+Jv09BYPCS?=
 =?us-ascii?Q?bnSPPQ9cYp6PxKXe9Xx9rQJWuN2wXVQl+DV2SZrum3iyBWpGvWz0yMEuEYux?=
 =?us-ascii?Q?jTAGLrPhOkp4Ti5yhObzkJ4M2sUGezqVpvDs3BJpjSqFc5CfEHu6X45pEz1s?=
 =?us-ascii?Q?Zc4N2OFJiefaqCuJlmBNTtBX9xJJwpUn3fL6oJrrlwTXcdB3ePv5dCoQJwlz?=
 =?us-ascii?Q?2xxWPRXBCqXgT3P81h5litHLHT/6CXKtjc4YuyRmZMvqZvA1kQr1V1XtbUC4?=
 =?us-ascii?Q?2IrmLDKrnVjJKyhJAV0f7Og9+OBq0fzHZirwQMvXfbgVs1thrrtseENQemEa?=
 =?us-ascii?Q?0TrTJ7Njj0gQRatMX+difFKGceQsab9LgFnfF01w0BB5w8IRoo7YjagJMAXu?=
 =?us-ascii?Q?dcfmW+Ja/qEmqE6PQwl/z9Gz/8oj4rPB6l9Pa/YRE7n8Gdd9hGXjjI+cSYia?=
 =?us-ascii?Q?MnwtBjI53uDe2bKrI4joAqVEwnuRDfXldwnEsXPWujj92t93sd5mvJ4XvJ+g?=
 =?us-ascii?Q?qfPkcHDbpDE5t7sW0qBEOvQYWZDSyq7a5yrL1XnirhVw8nbZV4d6CE/l7thu?=
 =?us-ascii?Q?lnXn2i0Z/7Ll0AGtRda+/Cx7ivPt/s4tElu3/c1qtmjcIAeQN6pGci+OLGEK?=
 =?us-ascii?Q?PZMHfNmrqv0+Ae8M/gwo/WKDLSaYdC7FyDRFcb4HXA2bUGAuIl1pSDOvYAtU?=
 =?us-ascii?Q?o46/iyWT6HYLhKfw35265/WJ7XuvoR1oManYcswQoodlXWqoCgRLGL4oQgyw?=
 =?us-ascii?Q?5+KMRP+6Q6R0vXC3DCpWT9tzRXOdgLIXGzDPR9UGKmh8FULlehJQVo2VF0IJ?=
 =?us-ascii?Q?phWL6Vt8oVezwICVenKB4I3rDONP5o3MSFAzTUrQEDTkY4REXgZ1NOX8qD5Q?=
 =?us-ascii?Q?Au0XQRw7oqAgbT3s5cjyvbiootp9BnIWLUTeBHIinSyX0ebTxnZhIqW5Vise?=
 =?us-ascii?Q?+pabDiovbMaFNgrrek5AY8t8BO3vlF3ufcxFySQ21vW49LO//Bj5D89PsUqI?=
 =?us-ascii?Q?shgWDRQGGoyhaavlUCN4oT5S8gyiwgFOMBzzHwk8FykdzTy70OactVvymjRC?=
 =?us-ascii?Q?Gy+LKq/bQ1px3goz5e8y6OwMBJSo3oDdfZf4sianZXS6h3LkuKXciU4yB+Pa?=
 =?us-ascii?Q?T9qwPFeq/6/1NZrFtaE1dFuFKRvr0F7Rn3l00O3f3psXwVgZmNi/2Qlfr3N9?=
 =?us-ascii?Q?P5+VzgKoFxkF9JBsBlWFBKWFEiLMqLdbPtapsxLF7LolcGLidNaZreEa0CA8?=
 =?us-ascii?Q?vfJSU716oTO8FDoPh3JVQE0Ea7tmyYo8re1lV48vPTfurjM72q3cYvCm/7lN?=
 =?us-ascii?Q?xpYZ1P6eqjBSJ/+Dbaa3gcfPIbi/U7iPQN+p6WtCXeayfXi9lqCrcECN/L8N?=
 =?us-ascii?Q?7gOqIiOcH0ekaYVphIz/TnESH0khOIOoFzs78M4LZ2wxpj4+sA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757c15be-e94d-49c8-36a7-08df33816444
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:51:33.8701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB389676

Prepare iio_format_value for an upcoming patch that adds formats up
to IIO_VAL_DECIMAL64_YOCTO (a scale of 24 digits) by avoiding
computing 10^scale when doing so would overflow, and by avoiding
undefined behavior due to abs(LLONG_MIN) (which couldn't happen
previously).

Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
---
 drivers/iio/industrialio-core.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 767a7794624a..c30659ca0544 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -653,6 +653,18 @@ int iio_read_mount_matrix(struct device *dev, struct iio_mount_matrix *matrix)
 }
 EXPORT_SYMBOL(iio_read_mount_matrix);
 
+/*
+ * Regular abs(LLONG_MIN) causes signed overflow, which is undefined
+ * behavior. This variant avoids that by performing the computation in an
+ * unsigned type, for which negation is always well-defined.
+ */
+static inline u64 abs_s64_no_overflow(s64 x)
+{
+	return x < 0 ? -(u64)x : (u64)x;
+}
+
+#define GREATEST_POWER_OF_10_THAT_FITS_IN_S64 18
+
 static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 				  int size, const int *vals)
 {
@@ -720,13 +732,19 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 		int scale = type - IIO_VAL_DECIMAL64_BASE;
 		s64 frac;
 
-		tmp2 = div64_s64_rem(iio_val_s64_compose(vals[0], vals[1]),
-				     int_pow(10, scale), &frac);
+		if (scale <= GREATEST_POWER_OF_10_THAT_FITS_IN_S64) {
+			tmp2 = div64_s64_rem(iio_val_s64_compose(vals[0], vals[1]),
+					     int_pow(10, scale), &frac);
+		} else {
+			tmp2 = 0;
+			frac = iio_val_s64_compose(vals[0], vals[1]);
+		}
+
 		if (tmp2 == 0 && frac < 0)
 			l += sysfs_emit_at(buf, offset, "-");
 
-		l += sysfs_emit_at(buf, offset + l, "%lld.%0*lld", tmp2, scale,
-				   abs(frac));
+		l += sysfs_emit_at(buf, offset + l, "%lld.%0*llu", tmp2, scale,
+				   abs_s64_no_overflow(frac));
 		return l;
 	}
 	default:
-- 
2.53.0

