Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342279;
	b=qLty8w/uOAFzf7YSyDNVDHaGpA60BFAqOyajGEVUnOZCoIZYQpuhNIcUndqumr6K3q45
	 qt+vKfex34Seqo9yfDb8efXZCFg5bxHCJ8oxyxgIPmVmOJI+rc5Hpg5p6d26MdcSKc/jk
	 0kCEzvuzp//Ki57s5HSYnLuXi7Y8eQrt5EHBPNEVH1gdpcIhxDcf3jRji/bUBD7h3WKuZ
	 3Z9vyLBRNDGzD1lvnuBGvxwowjiZ0RjYLJle0pmgHEI0ESiEfKP7KpCTBPAM4c+N7eYv3
	 HPfqXLksNHQgjhPcYwIczErA+j+3fa/3g4D+ZDPsBDveL9QmaHg46rInyNlTdI+Z6vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342279;
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
	b=mV8JiQyKRJvqX2u+uD+v2w5T/8vtZwijyWzvU7vj6sCnifmhtAlqi0+5xM8Z7kWBXHnK
	 PbdfFbwkp4C2gHmouS5nXWZdU6muNb3Zy2KJqdywo1LYdmxu9i8p/ZPj6axTDklWHVm28
	 GpLTvy/4rQhvSjOTBa64nTY4M00WfRxKyZC9KqWtQqKwpvj0hsWCH3cBpGY7k4lOXXjhR
	 8MCQB18rdvqKozosJiWs1OIF5VNAiYzrWQ+qXq70qbS8kyue55QXVDEE248c9SIsgmYRe
	 vhDli2BpUhSV/DMWfn1726Jbn6hbaFZ1O6VrP5A7fMxyDbK0de29g9EGu6uPRyHk8Yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=mMQPggRE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.55
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012055.outbound.protection.outlook.com [52.103.2.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD9D606A320;
	Tue, 10 Nov 2026 20:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD9D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=mMQPggRE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9mH6WKOtlxMdXHAYPkkNCl49bqYFHyeKVC8he0fFOWliukslWFN/X/IFDjkWE3x7NS5CSTonBaee8iSwakAEklGRngVKajaWMp7WQIqVjmxSwoTX9x5PSzKI99225kEi3h1HoW35CwDQqJsJHePesKrB2Sy8Gyoz8p0g1vI11hw7JoDwTEqDeeIlTYwVMuDXv5qXIs6z8o2xfm6DqrTGOKeIrj8FX215VwRvr87TIQxzhzcG4UfmRwE75Va8gxoCncUArhVeo9cE5KfplWL4aTprHcWc7EQKAQiecrkMK5wzg0MpBgfbXBDNXS1F1zu0yFcQghWB3TYvq68vFs60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHdfqmh1sx28Y17GBtqfP8VlpKysSu2Fq76IJlSdA8g=;
 b=Dbaoe5TlLmpf7eyPasa23kdGem4nY321HRkJyLXBQkA6i0o+uliTi4FhK2/4VYAHHWyD20ECi5Yo2JaWZYpaXXhejncRTOWzGpd+SPaTI7xY436Qcv1Kz6l5JwtZ4muZgE+tSNJ5gklteUTrUPiwHdiLtcrV/S/ZPuI6y/LhYjNjvjAqS2TB4oO3tbKZNClHiwfjla8ROuAAdMyxhqQsw18YtdA1f9k+SmGmo1YfsoJH96AOVLozzmpzXuGv/a+GgcAsQcZzdrhQztzMhDBtaJFOC3t7GSaFIGYn1JjqtW3l7IJo1FkIXoVozkMMRz4qlBwUgeGrSaT7oyEo/Dvvgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHdfqmh1sx28Y17GBtqfP8VlpKysSu2Fq76IJlSdA8g=;
 b=mMQPggRE6azwaDCwjgrKM8v5QEMQ2y3qjudwtnJgoRjzkMZAXiKCpyWPdX8tmvj8NdTF1m5M/Sca6wNZeTmpq9Ygj55tk6jhOpXWSMZF3foslfXPU3zCLA5TEWmTdFp6ikDtljCGgZLW5vsM7jhzG6duxSyYQpaqCAFoj2GUibX0kg3yUPz4WgIcCI2jFKP8Gg6IajJYDw5tjQG4nMOudRgIIFVjXM93bzVRQZhYX0qt6c/IVHNnj93dKmYSYZarsfGbvA1OS5NaKv5G3g8vj+WucngFGtMVHuryYtnX2ERW4DSXbyVY9k39nSQLPUpIe+/mD7t9I6OvE3aUip0Blw==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by DS0PR12MB999103.namprd12.prod.outlook.com (2603:10b6:8:2fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:24:37 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 20:24:36 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v8 1/4] iio: prepare iio_format_value to handle higher-precision IIO_VAL_DECIMAL64_* formats
Date: Tue, 10 Nov 2026 14:24:19 -0600
Message-ID:
 <SN1PR12MB252819AD03A1815095B3CCEBA5722@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB2528F139EE6C0B4576C3A0CCA5722@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB2528F139EE6C0B4576C3A0CCA5722@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:8:44d::16) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261110202424.1100154-2-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|DS0PR12MB999103:EE_
X-MS-Office365-Filtering-Correlation-Id: 76591d41-9001-4f85-0423-08df3f68a269
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|260925184616899003|4140399003|19110799012|8060799015|15080799012|5072599009|24121999003|22091999003|23021999003|24021099003|41001999006|53005399003|40105399003|26121999007|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Se4z4LnoBKhmjs1S9mQU02gu6dXhHcspX7jdVEIGa5kfbw4I2y36+yy1bcTx?=
 =?us-ascii?Q?dkPC9n8ddEkFnxI5Afb0+6+4kwZOalvx0GibJZpvH3BvmcRGa9n1Btyg/wUT?=
 =?us-ascii?Q?50coi2OvW9mTqnWJdf731rhjzaEHfCuhDcZNlyNzpkjutFNN9YtsE0Yp1qdE?=
 =?us-ascii?Q?1SCtNNexmQzyEXsyzgakjZU7+OIeXTvSa3Q7sCOCKWiAydoG5d4zEEcMBLZM?=
 =?us-ascii?Q?aaVTV9+rYgCU7ft8aE1gGR/g79AwjJ7wX6hK6WB4yag1tq3wdSoth/ySwkyl?=
 =?us-ascii?Q?m6yN6ZnrUqFAkMBmQnsTQ+EdBui+M0F01+3dUNla9wRMYlJNCCqgSm/IKYVb?=
 =?us-ascii?Q?RC9s4jHvSjxhR9fhZHBjpHT18ZvYl1tdSdEvGnbKanLqQflZmHKKNBlXnCQu?=
 =?us-ascii?Q?YQn+qHwnKHfUPx7UIuNX0awfwHG62s/bk6mn9lmqeJmUvyjOYd9bh6jUNd/7?=
 =?us-ascii?Q?JfSvNxA6DwrXIhsgGm31nci9pf0bows77XSDUopqvdMj0omrWUz5MbDu8Saj?=
 =?us-ascii?Q?QLjZPdLLr57ihP+vcFIt95YdBcY+ummg5guYkVYQtYPhZZYEShFh/EeM4PRk?=
 =?us-ascii?Q?ToD+KkuACjfyzbtIvn8KRh8rXhElbZDhsfS/nIkMtxi1R9I9BeMx3E1ftNXH?=
 =?us-ascii?Q?qVZI2z4p/qazEVx1IqyMjR1a3q4yJpPn2YfQWNn0eo6nRTXpa2yMblEOeUo3?=
 =?us-ascii?Q?zekZxXHmUQWn9xALcW1nHprB9G7K6TxEEPEQs1DZ108HulxmXNDABL27fPIp?=
 =?us-ascii?Q?xD217xvpuMdGfOEu8JRz3g0IvQ5dFmzi8xSDYD0NPpHJvph8FNSeaheCEQbg?=
 =?us-ascii?Q?IOTL3T0zzOKcwgBATbgWqrw7Tfd9nHPdzqnGh8/PfZxwiE4OWhwiGyphGkZW?=
 =?us-ascii?Q?KPhfJDS7DHgG/iXVaMPQ57doAFdMr7Z/XyQjV0ibshZ6CJWrLf0HWD+PJKk0?=
 =?us-ascii?Q?/+4yQ6lXqf4H2V5yGJn+Fv3iFJOcs9qVl+v8F6ihudwS+F+S2aChVCwo4Sa1?=
 =?us-ascii?Q?0O4s/PUAGkO/5MpptqEnF48/c+QqPx5pXSE3KTj4Ng7TG6ynrACW34MAvLK/?=
 =?us-ascii?Q?uXFNzXWXft9H4nE3KIIH5flxp3sg7lUDCCkaZI/Ada0zZOcZwWY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g/V3URidhx4dvPEVe9UG0PUsjaL+u9ykLy31Zdn2LWQheLRXwd7HwjNGfLG5?=
 =?us-ascii?Q?+R+36B5j49S54R8dfh8AIA8hA+5yPkxtyEy5bkPeY1Ek1lyXoQzQ3QrBG6Gx?=
 =?us-ascii?Q?pz+53X/ThIXVXK3Bxv8nIOfz1W+oUavtVu2Y0uUyiRmexZosuV/RZQ/ZhgBH?=
 =?us-ascii?Q?3fqaIcvvMhOD1QjWg7wdQb3UnpfdpN6OhKOHlbVqpEkWixWuYvb0mD7xyE5W?=
 =?us-ascii?Q?TFxvkSF5VsYOeAsFQvNFoVtXb9vSUk+gWSbKHOn3ejkbsgnJiomIooUX19L7?=
 =?us-ascii?Q?HrRJ2AvIsRwPV1JOLkhQXiNoyt9ykeYgDPwe+idDf76SAGw4cgJIvt23i+Eb?=
 =?us-ascii?Q?+ewJ6A9tq0G9r/zrsYJIvfvy9ceN6Bafx5H49A6pOjXhZi7vAqygXf59dy0F?=
 =?us-ascii?Q?RJ2eDYsJhannUUP18nRn6giw1q/bip12piDCK0tPAtbAlxMynuyhlQf8Mqhl?=
 =?us-ascii?Q?Tab9lV/2os6kdfYseE6cTIqDcjoEu2kdEHrTtpd3BxlGlOAdeZy7CppfnTQC?=
 =?us-ascii?Q?30uH3qyNS6OZkgGfUVBwTy91ntuyZzzg2G4f2XKSe+ce0xyjFduXLidGThmw?=
 =?us-ascii?Q?dOty+uP7CfXAkGV1s1ipuO+P0uwWOjtrymdxPfQ109jJDEX/UD4ZRdp6VDxN?=
 =?us-ascii?Q?loKjpxzuqbu0k1bK6Snl7Dm4TTjnoCOWXRlnqequ5xMWpzT5FZ17Yk3w2LIz?=
 =?us-ascii?Q?12WCNyef9pRVcVeOMagl0Pi9cyXX9TFd0m7xRVCyDDWSnPXeUMt/RWPT5OLk?=
 =?us-ascii?Q?KZ78qnGllVlEjqwdW7cHv8NmkUIrXcjO9H79bUO+B+tO6f1N2bbHiUS+HAaw?=
 =?us-ascii?Q?2vNFIZKGlJmGuJi4gGngm+s8BkStoNphP2va7fPjDgLVB/EwjF6M4Ogl6F8U?=
 =?us-ascii?Q?GiOGUTTU8QzEZgQ+A0lIV503PWDfuR90GJNlTaS0/3CkHo0VNUqLdNZp4N9u?=
 =?us-ascii?Q?RVpupzZscuIj2FtgPMts6UuV3NzhmCxh9N57H4oGJ+pjb5mUJLSCbMNd8KcA?=
 =?us-ascii?Q?g1xWA9fndsejPtD0kepZUa+T2z6s52rFxg0g3rguN4C0tFJmTjeyK5/4//iY?=
 =?us-ascii?Q?hRPzOCznnauUh8ux8aHhUS7/h1gB7AjQm5LDcJvzfRXLyCilcPPwNwsDT51d?=
 =?us-ascii?Q?P2vqv51QgrM7wI6ZufdfsVf/DUYhxPONuUjczL8svc+hZSdHOSJxbYjT/jR8?=
 =?us-ascii?Q?7gLkRzyHH1LaINr2AQE6jERBMmFdVnYJFAvgw7vMj3s/pH3utiWgRa02HBS1?=
 =?us-ascii?Q?Ke8yqIwk7f1HZByEk/0Gzpccu6AgU+GxZ7WmBuruv2ip3Syy9rjrOAieVgfK?=
 =?us-ascii?Q?rYeU8PXJ+i78iqOXi3v2KyWBBcYiaqB/CJbra3a418iAbaV/zXL/ydwx4KWs?=
 =?us-ascii?Q?LwuHPLD3+bR43Xc9J8X0q93jKcNrIRPhbs9SnE3gR9TG/KKEhQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76591d41-9001-4f85-0423-08df3f68a269
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 20:24:34.6526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999103

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

