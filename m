Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794168530;
	b=NZfYyonqLBaaZFfxvvHqnvQ/z27j8sblfEc52Pgu4m1DzDxBkZZgV78dGMhdMAhnHc2K
	 x7cf2mghF3DeyYX0qLVP6tzsFvCyGyIPMNOV+/1J/2VqbSMBFoMm30L5s7PSVZl2S1mis
	 cMdYN2pCa1jaMsHdd6cuIOrDRhi0e1glcQS7TtW7LY5akMxK8igLTMjLOQjPfha/Lzvj0
	 vv0OT4FL2Qv3FnOBpw3Lt1Ry6K/mkBT8rLADJnFlqiqMeImwgTb1GlbNzedFKlcMa+Ttr
	 iG6T7UT6YZp3qT6d3G30jhMD8A/smg4wygVARL1X2MyzxkUxBUGGjshYV5PUfuYurmw==
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
	bh=rHdfqmh1sx28Y17GBtqfP8VlpKysSu2Fq76IJlSdA8g=;
	b=5Hb4E62dJNG9M3FlF2rMOOm4NjgrY2LTC+1Y9K6zy2FppBuFH9t8erYv+YKv0S3rEwU3
	 MxobNNrryCoBd6LiricFJmVZ+hSfQnGgzx8yhvp/dngc7gsjte5+mcq8Gv335ztStC7K6
	 coi55sfVITlDy3ckmwhs0byrc385ii3dGK6No/hqgFXjpAMcrCC6K6G4Fxce5DaFDp1B3
	 MwyZ0KC2NtZ33cSR01LAxuwHK8iRoRPZ65PDw3uQiXk56i+UxASnOH1FmYqQ2aVrsQVwc
	 5TSC+P/7COv4F7PdnHyL/zgPjWDr/aF4JQiFFr9iXVo6uZ0iNDlz6Oi/Jj+0cYWefbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Rg4X9o10;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.19
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010019.outbound.protection.outlook.com [52.103.20.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829CA606A31C;
	Sun,  8 Nov 2026 20:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 829CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Rg4X9o10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGdbHs00j6NXZIhk2mDQ0SULgzbjzN8dY4scR0l+giEitfc7cmn1mBFqg2+SNsBF2CLVWnT9Ucs7yspdovo5jtqWWYFC2RhncjfxCNPr7ZZVuK0LB7mqoTVJuz8wOZUuE75XtG6EzYVPzFCiWKoYYqgoiHjU2UmpeYfEUqIz7xilCFTD3le1gazWaEwa6ycNSQw+qXzT40pKQmGe/sY/9zD4+zc+9cvQUYEENy5waZ/ZlHbaA0ripvgdVQ4vxnl1Hr6HwygUjqR/fOySEGso3GRwW7qxZln78erdqgUflJmGVMLJkfcrdHrzUibqGa6l3dFpL621QMtdTqtmZF+stA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHdfqmh1sx28Y17GBtqfP8VlpKysSu2Fq76IJlSdA8g=;
 b=OwsE/wkK4E83mer+jEDGKhlk8yrrG1QaieaXilSi/zHP6xBZqKOid5Edz6pOaIwy+bgGh31ha4c+AxXGVzQOuh8IPE7tfl+D0By5k9uYOmyDmaibV38+YQ1JpVJdnWff7JhBqqpoqN3S+PxAgAx7GeC4kg1V9IyDa9or+4h9yZW7sElCqE1kvIGmHkqW3Ar15IeVJ3OCJn0btrjhTwxZVVmG8a79lFb++0L7HiILaXSgtv0twHDfxjds8uuLzuJ2P/5NTNnGuVag+jGAAeI0QuNCoOuukPt+qTaOlSYxKrQpsRLHfOZsIBOYlZp+ClgjdLjwB2nWAaBkBqb15S2taQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHdfqmh1sx28Y17GBtqfP8VlpKysSu2Fq76IJlSdA8g=;
 b=Rg4X9o10LWRwwhJASW/GI8NqAlt8XdytpulWz+vBKLknujGRC0HGft0zvaRBkamuMgSAXGW4+DFZoh2K3lHTNQ8899xsYbTKueWaNiCEystKibC30I//EXZr8eolNq/TJTmuJx3a+8QCxUFIazhmGGLOw1z2/VuK3a3X7nZK0ui/qdPtYan4kXnS+qMewX/WPfL2JHglt1n3H4fhjIK8kjT86UAw7V4KISktvO5EalNUtQWhgM6ZHnzVDzzAQvOWNUS+1aXiEnskfE34v52qG9ggHUneuBkLlMjoQXhl0BXnKv09PkgQ/xSz3EyVjzkBasYguNspVNI/+iNFjsxzhw==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by IA1PR12MB8465.namprd12.prod.outlook.com (2603:10b6:208:457::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 20:08:46 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Sun, 8 Nov 2026
 20:08:46 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v7 1/4] iio: prepare iio_format_value to handle higher-precision IIO_VAL_DECIMAL64_* formats
Date: Sun,  8 Nov 2026 14:08:26 -0600
Message-ID:
 <SN1PR12MB2528971FE584638252ABE377A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB252841150D2280C7C1294A11A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB252841150D2280C7C1294A11A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:610:b3::29) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261108200835.981970-2-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|IA1PR12MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: e7353502-9ae2-4937-b725-08df3dd417c3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|19110799012|24121999003|41001999006|22091999003|8060799015|15080799012|5072599009|260925184616899003|25010399006|24021099003|16051099003|4140399003|3412199025|440099028|40105399003|53005399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1wxaCppXOdLIg02xc5Ak4yjQ929CyYCviPGCKf+p1VbXc/HLZwdC+ng+jw0r?=
 =?us-ascii?Q?JR9y38rR8sNJCSh5Rp8izQ2KdlWJ6P4kNIRJRn9wUlDQjbT9ziBY5rP3pptI?=
 =?us-ascii?Q?jS5iMD125r4K1Ph9T6s16eiDvuZOZq3ro0ouZFUa00pMJYcX6ieSBvkPIpr5?=
 =?us-ascii?Q?h/x/h5QREUKWdtCT/ezWmnO3Im+A2sZuBhC0BX+YN6Ac45XAMnohic5EsX8R?=
 =?us-ascii?Q?fQeF4v8unS0R2kajsXmAdHiu77re+c1p+MFVr1fluDlASCHgJskBIHSthJoF?=
 =?us-ascii?Q?Z2++SvBF78bMsy01cFertjcQtbc5umED+K6BHpQ+xU0aFRsQenXsFpCS/fSL?=
 =?us-ascii?Q?P0cKoPXtH2+vfcPLsg+1yAuIhXkUV0wQgp9Z2xlv75RY3K7a2kjlqpjJsTPA?=
 =?us-ascii?Q?1p1TRK8TsgtMfxX+T5suB0jltfBXnQ7Zpy4jX31urkpx7Z8/rKxGzr8rEVN1?=
 =?us-ascii?Q?GkdZ7+o03qa3Cwr5xQkdNODUCIaso077DHe3+Qp9FQ1AZeGANM5pOIc6F0Pp?=
 =?us-ascii?Q?gRXgvB6bTm5nX8bdOo6V1uYsNF8FbVUIj5ATq61mv1LaYJpQgaRZUC4ugxL9?=
 =?us-ascii?Q?xJ52nRPTPAdYhjToekXZU+tB030dh6MJU9w25+wUHigLTYIKIzXrL2HpVpDt?=
 =?us-ascii?Q?Cmvcvz1Vuadax1/SdlwG4cQsRLk673nWaRHNIHtzYNC91Cc0ookl1pa23nou?=
 =?us-ascii?Q?E7ViOIXc+OvyzRJEzmoQtL5BcsiePv7A5u4CVuAQwAa+xz8f+R5umzHtsEGP?=
 =?us-ascii?Q?AdqmKjsc2ZzTjvRYP17dX6wjhEOLhBqtX0GVTOij9fHHDDralIBigOmdwfcJ?=
 =?us-ascii?Q?pm+pLWRLHpTNsemejhu0LtjGVcl0His9ukYyQrDpwqiWlNOOHJUadXd2AQhN?=
 =?us-ascii?Q?35JzzhRXyD4hkS10RSh3TM91vqh+7XO3DfUZGVFbfDzRd7sd6naAbQDbDAdr?=
 =?us-ascii?Q?ERndmGUdV/HAMLJUt3RaTqrK0fvRBC1dmAuoPJHtlmbOg/oKeFGDH7dPON2c?=
 =?us-ascii?Q?X5yrw5MesknYqrudeqwTVQU7almWmmY1xLwwxkKBn7/0lNNieZoq3QXEQwgm?=
 =?us-ascii?Q?/iSTclNeBG5nfcR847KXH6PSeXrmpqqRVMywS/k7kbKZWKX2b4pmJiOZBWNf?=
 =?us-ascii?Q?HUEM3gNN6yic?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fx0O/KrtZWEb9RrymZJm3GioFKlhqMszRf8YIHeFcHNdI4HG8ohxVJrgae0I?=
 =?us-ascii?Q?9m8mSKWwWuGRazwohkOv3deGHh2JJ0ShcxYR/7UXAWzydBMljkIKCkHASqZq?=
 =?us-ascii?Q?1rcXL3XK1si9tEo1nBd1dlzehHMP45RzLYUIp5EAPdsyyGqKInLC676bmDiv?=
 =?us-ascii?Q?iNo31vltSFWGKbdXizKhIbMM+uqkbDC6wIHxzxXkrJgJkUv//6s8ZCd4ex47?=
 =?us-ascii?Q?Ji9NKOQ10WfjQo2tLJkZPRhDQ62tuoa3cgtvCTqTC7DqEApq1r/hSkXt6YGD?=
 =?us-ascii?Q?3Py2HOdGVsuM0kuhBufw0mG0pkn2Hkcf8CbGgCxclxLR5Ku4f6WV9GQnDveV?=
 =?us-ascii?Q?N4uYIzGY+t7UTaUjRxlKdMXtv1b47O9utQvuhVnQCL5upaPh+m1TcJAAxMm9?=
 =?us-ascii?Q?SU3qZnZr/8K3Uk25UesQwAZDdag29QcJZqKMtoBQkT7C3Oz+TVsid9RJYoVC?=
 =?us-ascii?Q?42t6hvPzFFfQaeBejXuPzZVBZbj8mJglZpaAmU7X5Yl31VHNgx3lhxi/kK/l?=
 =?us-ascii?Q?JBC42AGd0uaE9QTW9AAOhM0BN2AAywr32dNM5l1BJ2RmFYAtp4ZvWQTeVe4q?=
 =?us-ascii?Q?N7/ZovrehC6B+9vBgj6GsXfTXDkso0IY/aN+lsq99jOSXWs0dQJo6uGIE4Qs?=
 =?us-ascii?Q?M9uyhqHh6KMaLJ4CFOvXBvM9mwVxOMAj7FmiGM40r4qplWOZpry22jReAZYU?=
 =?us-ascii?Q?uegLC8b3QeiRLUu3a+7pVUKhQY4NGdbKuHhs5ALlSA7WRdhGaKJ/SThHq+Q6?=
 =?us-ascii?Q?rEhsEB1W0De3Q7Un7Wfi4Xra5OJvY1xevrgjPJMAAP6GwVSSTz6nQQZIGB/3?=
 =?us-ascii?Q?ITQiCOfmMiTy4lJTiw2/bNbd/6qr1Mi+BildqEqcI6BoyhbDyjgK3je/M6Wf?=
 =?us-ascii?Q?XOWSL2nbGMCMsdBzNWw3HfCl5PDSu/212AtayT+Mne+CJulWTLZvUlCc+V+9?=
 =?us-ascii?Q?qNLpoh6F0is5LkU4TzE0eBoW/vjj7ApaUtKlZtF0qpxXRff++MfzAMuTsC1z?=
 =?us-ascii?Q?ZH/idCp5viSoYFgSqlkVhgEQdk4ZLrd0OWeiGfh+nniA5wnsFBT+sybcKRMM?=
 =?us-ascii?Q?h++Fj8ASu9e6htWbuQThS3HDSfBX0afcPebKoxZD/3xWxaK4KDxzKdSe2R3z?=
 =?us-ascii?Q?yagcfM9VkaH89OBVwSOqLjP7K6XbaMzZanS0yoCMOI3ZU5Ia+n5duwz7POTF?=
 =?us-ascii?Q?1c6Ru2io3YvOWpnThZq9hwfIG9e6a0vFXUr/QsyR3+asJKY3n1LXk9dvc2iP?=
 =?us-ascii?Q?YoU09/bqZybHgWLyWouNcEWg92+zhIxHcX6+FfwQEo1jbR4HWGPNMKU2e/IQ?=
 =?us-ascii?Q?o9JJ7XxDJLl/rAVqUh/P9ZgmJvJWiViP3dymr4tuokL/+apWaod8hOPO8Uie?=
 =?us-ascii?Q?9kopfxs+h6T7W0WohuX+a/jqsmZAbhI1oE0h79PlScW/dRn4GQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7353502-9ae2-4937-b725-08df3dd417c3
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 20:08:45.2932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8465

Prepare iio_format_value for an upcoming patch that adds formats up
to IIO_VAL_DECIMAL64_YOCTO (a scale of 24 digits) by avoiding
computing 10^scale when doing so would overflow, and by avoiding
undefined behavior due to abs(LLONG_MIN) (which couldn't happen
previously).

Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
---
 drivers/iio/industrialio-core.c | 24 ++++++++++++++++++++----
 include/linux/iio/iio.h         |  3 +++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 767a7794624a..42e92a79d1ee 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -653,6 +653,16 @@ int iio_read_mount_matrix(struct device *dev, struct iio_mount_matrix *matrix)
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
 static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 				  int size, const int *vals)
 {
@@ -720,13 +730,19 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 		int scale = type - IIO_VAL_DECIMAL64_BASE;
 		s64 frac;
 
-		tmp2 = div64_s64_rem(iio_val_s64_compose(vals[0], vals[1]),
-				     int_pow(10, scale), &frac);
+		if (scale <= IIO_INTLOG10_S64_MAX) {
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
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 711c00f67371..7cb72ae282b6 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -1132,4 +1132,7 @@ int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
  */
 #define IIO_M_S_2_TO_G(ms2) (((ms2) * 100000ULL + 980665ULL / 2) / 980665ULL)
 
+#define IIO_INTLOG10_S64_MAX 18
+#define IIO_INTLOG10_U64_MAX 19
+
 #endif /* _INDUSTRIAL_IO_H_ */
-- 
2.53.0

