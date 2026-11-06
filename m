Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793979724;
	b=Kz59WHhBHlkIsdHKXpIzW+wK1wR2xV0kzu1lfCr3QGCmgWNFeWRpdNjptXjgbIWVikbW
	 DGLwNGG+omYRaZpFy82qY+7f6khnSrdS89K3SGAyYTKLhC40PnGiNgA20WAuNZWeDyMlK
	 qMR6zn6c8tKqXkzmkCGU5cGOShWPwcuXTztSEOWfIhHE9Vq5YZ/hns91vUIFnrhs8aqKc
	 zl1GkQTUkY8TbzM+QtUc9j0pvXWS7SHsQBmafWjFaRvs1Is9V/hrEaAn92rKq6AKN1BgT
	 Mmd5ls4UhIofQherK8jsYLnJTFf6UVCidulUv0GdEdO1r6tDwHhNGUr4Rzj/seJjpNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979724;
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
	b=c149owLYdpCucap6qljVR/kM5O967hORCluf9ZVyzDZ5RsOnBordMVBGTbiG06beoyXW
	 Qol0CkVK5MesJaEeTPxF5YWRrdyTfn0odcaFMtUFLnOvyuEUl1BNfgM7/I8oYTAqx6wRk
	 Y7WX1PAkWImiUisUyYPZXYYFiBZL4+RQ/C/bsgWEusRHAbU9s84lUHvUpTXbFcQor61Pn
	 ddx9Q2JRDHo2yWPmqI0LdAKSUjjBNnBj/RQ8k+prlTVm3yar+VIXHftD87EfD2eKgMbl6
	 L4EI4rXycV8m469NMiHp9xHP2rVNnYluo8NdYwDXn95yO0/VHjD1UTKgJOBLWQClBfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ovtHlGDY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.20
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010020.outbound.protection.outlook.com [52.103.13.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ADD606A32F;
	Fri,  6 Nov 2026 15:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22ADD606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ovtHlGDY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8YXgRA8QxsQbhsTnw7T8YnJhI/FPeLVpDkWu/+3LAl9sUTGg+lgzsAwHEAPj0cmRJvLnlk+EODBzJ+ZtmMCtOUQSV81xMPibvp2hyTHCiAe42pyIpWRm2KM5ANsdWZ6UhggnKOCM3V1dybxANtaYIG29vnXbmoC8qciacv/T/sSrkmztX12Wdhg/v/bNp1GjsLJhmABK+T//qaBrllTeUEA2UeeyvlkYUmIFEoDsVaF0LKgD4BTpfMRgUXoWhpulsIstX8Oyobr9O5iFOTzqJQEYKQDGUyVJWovwebTZSQ4xxZfVpApPeypjf7HgBchoBPg9t+8lIuO/3yU7hItAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHdfqmh1sx28Y17GBtqfP8VlpKysSu2Fq76IJlSdA8g=;
 b=FG7qH4EHSowegfYC9mIXYX8loJiJPzBRtncX47XDLk24gZxQzi4L1fAerme5LvOqPJLSKHskzTA3+1NPbCmcnjGffwQbUbTQxEDnQbkuFA8cyoNl8QMoPaRaZRpPeeb9V/U/G+k0d4+zpIQ4RUMZwD7vPj7wi+xD9QpR4EnTH9jPTVI959Di7qdOpFQDEXtT794gxMxrdOHmCg51POM9VUSuQbWkDGsxY84xXEuHn2AUpma4h3o5ufqMwNF0zpCWlRABEade840uHhURNf43lvqKW3GrFQeeCa6LOccZO8JtabybU9UOAWutHdhKSsaLxGFn8xRsU1QuR3VcR70oAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHdfqmh1sx28Y17GBtqfP8VlpKysSu2Fq76IJlSdA8g=;
 b=ovtHlGDYjlkyu0h64RVRyiEhB5MnU5G8KfnWOhS5mwU8Er/UjCteAzOjmKb/Mki6casnVLWI2dm01TmSFRjM0sz1WE9vUBhiHXyMEmN45GjZHs8Y3JCmAZ8aZ1xboydglCjmWN9VcdyS/jYt2rs8o9BquDMRplK7sKHSj5QMB70zjrvqrzFEjKzWweK5CY7F16wZvClzETm6yxR7QZzTLQfIAKHBq1YbhRBq6ZFqIV1opBbykbyNJAuOS1kAUyfCG65DMTKJ29FHtnP98Pz2MqTglwE8E3qhFRi8KFOKfWdxyKNcUklKHbevCBr9JD0ICAVbNd5m84N3znk3NYbPfw==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 15:41:49 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 15:41:49 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v5 1/4] iio: prepare iio_format_value to handle higher-precision IIO_VAL_DECIMAL64_* formats
Date: Fri,  6 Nov 2026 09:40:26 -0600
Message-ID:
 <SN1PR12MB2528B4A67B738F51950A916BA5762@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB2528805DB17DD015E191111FA5762@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB2528805DB17DD015E191111FA5762@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:610:b0::16) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261106154136.804370-2-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ece19ff-b97d-45b7-9193-08df3c1c775d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|24121999003|22091999003|41001999006|24021099003|15080799012|260925184616899003|8060799015|19110799012|4140399003|25010399006|440099028|3412199025|53005399003|40105399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EASPOkc9y5SufgsvP1MJhoHIVJxgrbp7FHOYY5X6HimO1Buw1W7nS4QE1g0U?=
 =?us-ascii?Q?3NfQgD/CPz7ITU6sSJMzdt3TnrXg75qY2MUL3Sobrg09GByiAEGqWfDedt3J?=
 =?us-ascii?Q?W99nEVIID0ukq43/98+uOOETbZeAg1zk1CX1AXd9kNXLmyjQex7n8MvrXxRy?=
 =?us-ascii?Q?m0IhU016J75HF6aXtqwDKvaAhWTQNFaozyAQ3cIpEpOkvfrOntwQYsIE9QPB?=
 =?us-ascii?Q?4dLmJOsonRkQ2zzGfpwMwNhQUsJaJcWLXzgkE1cEZtqXql0PB1M9hGnMxZDu?=
 =?us-ascii?Q?DZOe6WT9mD2cBujnoJ6QH2H+HMkkkq3RNxXWdarSGV6q+DUyEchZsRCTpA2d?=
 =?us-ascii?Q?AmLbdk5YSRTSKjBTMeo3zrBX/Zoo2Ild2XDEjwBfWcLTzApt/IgbNXvpmHWM?=
 =?us-ascii?Q?ADrM575Zso6kfIhq82sqC9M8WzNmXi6tVccklLGOzMedRu604cbLzI9vsPrR?=
 =?us-ascii?Q?dyPwMS97eoTPX5usszlsNkV4BCmIOgK0LHlJCXpHrEWDqRQVdAbhLJoZvxt5?=
 =?us-ascii?Q?F1LzwWiVbkm2ZBTI7SfjcikdJGfk9YXZmacXN2Wak9HWlj+HaXFiofnP4Gjz?=
 =?us-ascii?Q?xBpS+AJtqT4qV2kDTswJcJBydhvA6qfZGYaQB/VRtIoYEnrqa5A4V1okL5Er?=
 =?us-ascii?Q?b1I9R9TL+ep77PKBgY3LtY0wmyhbqe2kYpjCwHPdzXlgjLXfme0V+PkstryG?=
 =?us-ascii?Q?NVEtfX9IVAjy91wTByQ9IN5csAyOgIXk3G2xU9w1tTPIM4YST5ARXgKUSqdS?=
 =?us-ascii?Q?MyBn0RqKhbR24T4CvCju2fJXWv4Cq5GWjWlKvEJ6ihfERR2OAngrWrFeJeh3?=
 =?us-ascii?Q?3xN8NXdibTrT4gs05kfS3pPI+hmQ2TXCnmtjYy5ZZ2lvC+1QEzexoUJkp5K4?=
 =?us-ascii?Q?Kjc31oOhG5QjDymg90YDr2arPZFMzpoQPV6lVmh0foVNXKLFNqx30QE6gCqv?=
 =?us-ascii?Q?k+SfPRDxwuG6fHuQ6qyYngb+0eLWKWmckXSFkPu4rH4paXd0Oy3JLpFvVEvr?=
 =?us-ascii?Q?j3VHxQjPvxO1sDc13i5em+EJ40oaoo7ToggHTB6hP+IJEIos0hm/SdYJLG4F?=
 =?us-ascii?Q?9PdbxXjqbhKQK/66xPulggc/lz7d723t7vfHm11XXzqTuLbxiA8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0A8LWEjGT5jAfcHL2hC8gEgxTAIPSey4X/706yUKgN67IDHuoqbvsaktDQbC?=
 =?us-ascii?Q?vq3rgv9hz7OyBpgNHX9g5QVslCCJUtcabJybFxpbeDp1UIjnuCS6SZ/EZNjb?=
 =?us-ascii?Q?OI0nfrN/upFnBiU4M5CkpTAJoKp0ouXFnD8nG09hxcWId/CxkHqPbmD7McFm?=
 =?us-ascii?Q?pjn1dj9+JeKLymX1rITPLEOiih9wBAhSvJFRXpCfdo2rDTe4WiSPVs83ZKsw?=
 =?us-ascii?Q?BqcxDPTiCGMgSashpdehZF+jKLcWM60P8/6dYnaaw4wWGy7onSVC/mXsUNh6?=
 =?us-ascii?Q?YwIOyJvWaDBHNu5QJsZU9lLIo5W0zSjGIF5diINjEh/wm0ON0rJ7RBX9NXY8?=
 =?us-ascii?Q?glsO0QcHZ7t5AqZJd0UfVOTKAngpCM0MotuF/hae+5dJMZX84sMspD6ymNwM?=
 =?us-ascii?Q?nRxSmQC/wXn7O4j+mlza8bouKJVp9/wphe3HKAslUkK+Qjxktezo9yQ4Nqqm?=
 =?us-ascii?Q?Zv+5maVTxSZ8PHAjMx6GeyOzSg7tihr18T+A7F47BAe5UHFwUsRYxtVRl8ys?=
 =?us-ascii?Q?qMy9LBhjmgu5MIAwQsEGI//PGzxSal4rU7UQqVSSTu9y1bONxwry6FExx4e5?=
 =?us-ascii?Q?e0hj+L2XxPnKuXPCOdYHNwA3qb780tiBfr063M8b+nTPMSGQlGxENoSQyS9W?=
 =?us-ascii?Q?Gxtjigx5JnQMiH1BxPJXGZGhWO0EC9RlOQBCF/uKX/uXko7p+WFkDwydVljL?=
 =?us-ascii?Q?DKivTp/JPNi6WPZW2XblNbDRzHX1Masy4GDe+j845RvzXIEsABRwnIaL8PpD?=
 =?us-ascii?Q?1ZLt/v32nQqVbhJICtd/Ag9RoGTU4NYrLSXcO9nordL2p0Zvh9riZTkAMf2a?=
 =?us-ascii?Q?W0PXMeqjDQ8pMX7vjmi/ZuittM+zlxTX3l/Kt7IY+H/iC17uEAExIrT/pfQG?=
 =?us-ascii?Q?i5nGfA6KWCvqRiPv6ABDEGiS9D8v5A4t75mFiWHO1yiks3LxfWDe/orrwMhx?=
 =?us-ascii?Q?RjDvzoIFkw5pqV7bmoXLxK0Mlyxp5BfUoMHDVHCbZeY71Zla19+woOEkFt2y?=
 =?us-ascii?Q?N1QO1UELrPHRCk/RYWssOWAGHrK+I8Iz+8jG0pUeCuqxeTDtKRNJsX5MHlPx?=
 =?us-ascii?Q?eVoSSVPmgz/PquLcSC5DwEvFq78UJsJ7YlfBrrXAQs7tfy5uPQJLhW2+3cHh?=
 =?us-ascii?Q?lPLgyOheclYSzM/+dCQskbfg1ldXllWLCBscXobsS6dIJw2gMAqyLgYDagCI?=
 =?us-ascii?Q?RUCPVxdQhoCw5KULi3O7ovb647jTvEqyfhLqPTaXhhE2GVwONXU42xG66ajs?=
 =?us-ascii?Q?kkuA6dPPhWFmV9eR9IJTAcC5P8Xd8BUwHEnjSezmnOxhpx9pVlhAjnl1w3NV?=
 =?us-ascii?Q?6dn0cH+8jkfmW1osWqC6lWVn+Y4bPak1ivECLYqqJbXs1w+YdyzrEWpRqb7r?=
 =?us-ascii?Q?Z4JOfRbW51wxGWw4fxjoIgoKbGAbBd+44gXHa6R2olbOQfPoUw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ece19ff-b97d-45b7-9193-08df3c1c775d
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 15:41:47.2150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329

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

