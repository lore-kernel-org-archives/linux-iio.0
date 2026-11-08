Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794166778;
	b=MFqm2Wnu2TIqn3SHQPH87tNwQ5ybvbMH8jpbZSDwwahxIagMdOJZDptbTQqBHm9GIuMv
	 IHipt2N1DHG0DNyz8sNKnfM7fZgJUQu7ibW63bSE/mHXG7xGH9oNYQYJhrtEpcFBEFHD4
	 vylIa2gHTWajclbYdfd0z52MfSaKJQ+6OIumXg21j4u3x7YxrgnX0dz44LPKpHYICGfXK
	 mnnF7yF0E8+0hlFF8PJn7TNKjO1fOBN4KLu8ifdbu0k5+71pdvyBjEx5b4DDdz2JPzXCZ
	 WAkTKdd2nNwWljswTeJLPHpAbWmze9nTCNmCjuDQteYIHt1u9lNz1z7/GtHjLSF1Xig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166778;
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
	b=un4YtVx/S1yt4ygU5n2bpwNnt/HMYny2VD8JXs/Lbg2td36KMAD79i9o+dc9qxYmM+Nu
	 is1uqBQ6yXp2WucqCxBY+a8pizDiivmjkQjg7MTpxA/hHdrA7QEVpAdxljNv0cWPj/cXP
	 vjMggFR58eLmWIx4mdSE4bl33tzyO9jVB1tzhOD2l0gC/czsz5sXhQsXG2VJ5l8JRg0oh
	 fnvug+tTOYbd6S+VTYhVcgZ5Aj6T1nLJk2YGk4KlVLU3Unh+QTV71HIHkX00BTvpFtYzJ
	 2t9QOIIr4xsPkynNKo06LyU/wPWNgqTMjTK+esg8UBxiYJXMAZfV5IOf0ccpyxMOeZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=BTzEeuZt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.70
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013070.outbound.protection.outlook.com [52.103.20.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30DE606A322;
	Sun,  8 Nov 2026 19:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C30DE606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=BTzEeuZt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNmFz1MUZcogqgT0TfX/LAkY0fRbut1QdO4sFb18xU1O2LvBi91NpnwTJ6SevDQSVJ1vH6O17SOocg7Ugy64+v6Xzqycu/s8OMl1R+RCloorstVEFePMPmYxp29NZovc5uAvUD/iDRoPjXvrB3qnQJ41QTzm1ZbSHc2dfY3S6b26tyrQiXdqJEwD8euHUBfMAPoTrkH2m9fK9wfNbIKjNIw15Orl0457s91V83x0L7Uh1jTiDU8uRnMaaRCtN+lmyo4QtmZygBJn1M1Z/9Ou13eSIksXm8yj8+OiSDTTTCPBDUx+UOFHmetHkE556+wWnR9Akoh+8DrQXu6BxG/4eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHdfqmh1sx28Y17GBtqfP8VlpKysSu2Fq76IJlSdA8g=;
 b=jieX6NVSx0MbbhByvgslV9aPNe6ythUY7exUfSwmCGBnjWffCw8KBI59BVPpYZj0CgXae7acXW1Vkr06lBXAmq+hfIUTORDaWYHTUKeKNEwxDgBZJKQtEVcQJEXccXqdGIuS092BxBUVvQp06tblBZEzuO8vvbSFaXxG1lgdezBipwhKmnX7hW3JUBXJDVpDzSkQ6EboImJqItiRZ9G+1MLFoz1Xy+VmgGnAPdYlSC9Ce2v3s4ZVigx4BapdqUH/6jpVQ3iA5uWk/V1mkUmjkXG0SEZs/eISw+26Q0pkoenTy6tsf2spp9gJS5E5z6RkITOMK7N5QcbRvD/db8x5Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHdfqmh1sx28Y17GBtqfP8VlpKysSu2Fq76IJlSdA8g=;
 b=BTzEeuZtPWelxi+scXxe7nJJdRWjzcRkTCYXyNVBtPxMsEUOTltgcQ/qlz+95ryrJhH3OddIrtqrtIVQhCKSkuEuedBnehwsAwLNSBpDcD5rVakWE9hZlhfinvGqsh4D+MXhoRa4BkkGdCOuxtiutKjPk402P++TgCdXPQD+3tCHkifhRo0V/DfxhIl/CI5sNfQ53fOuOdTrVUUD7jPLKAvNxi3aS22buKtz7xds00QxknnGLBj2B/avaiTnqb3FMQz7g2Qq7knoyq3Ur8eRDUSwFEKlLqYcKUYq1fLGaP0bxzOYo3pEHwHdRpkmi0y/5lqU3gAC/FMlryH7OnHoww==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 19:39:35 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Sun, 8 Nov 2026
 19:39:35 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v6 1/4] iio: prepare iio_format_value to handle higher-precision IIO_VAL_DECIMAL64_* formats
Date: Sun,  8 Nov 2026 13:39:20 -0600
Message-ID:
 <SN1PR12MB2528A93C8636557F1E197415A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB25284868749912841740AEB8A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB25284868749912841740AEB8A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:610:b1::29) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261108193925.977273-2-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: b11893a2-965a-497b-35b1-08df3dd0044b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|23021999003|8060799015|19110799012|15080799012|41001999006|24121999003|22091999003|260925184616899003|4140399003|24021099003|25010399006|3412199025|440099028|40105399003|53005399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0/a4PVaEWinVou5revp3VSIEgry/Oot4K1gUSliD9//5xgU5jrZMvQb0s+1C?=
 =?us-ascii?Q?SlFvOyGotehNxXXAuHp6sgQEVxZnOblLbCV08EJfusRq9f5QOrlyzvIP8HWu?=
 =?us-ascii?Q?93TuyWalkb/wA828YKScjcJ+uF6FjQxVi5hULwG8FmP3y//tXAY58aWKB2jY?=
 =?us-ascii?Q?8tohc/hBqspsxhdA9lAfOLrmjRPGysuqabXL8vcYhVzLEQuw6yHq7v768r0C?=
 =?us-ascii?Q?qrnDaPN/UVA4u6htbALia4nom6ESLq2o44Gs4xewY3dsffK5/3HOIVbFIYj2?=
 =?us-ascii?Q?MwI8kibi3qJPD6dyurStuQrTxT4xRsFvTG0QzAXN7xKPryK+KTby058J+MJD?=
 =?us-ascii?Q?vQdrF48BRnWeNk9laN6nS8R0ifiC7/HJKESglBrKUI0QTd3lGWoUtuxPFivo?=
 =?us-ascii?Q?cT6aZldGk/AP+WDkUK8/FUyg8//oHroUSt1ZQxG8TreLseIoB3ZytRtP8UkX?=
 =?us-ascii?Q?hgvyh6Bq79M3k/6dRTZF3OlVvC4t3ZyvqY81cTP6+Nb+Ff/hVS0G5oW7waJr?=
 =?us-ascii?Q?pRxCnhVTPcz3mYFrFL2WbtSbmH1/rUls+uTAej8whpzCRcKsdlOCSnO4aU2h?=
 =?us-ascii?Q?/Rip5/IOynhsK3K3YDRIK5KRLTissmZzdiFOqBpU6vx38uotW2KIlirTlYIU?=
 =?us-ascii?Q?5G8dke8/eccDu71SpxrD1/4TVkmH+IfRyYH7KzBsRICXb6UgnRnGPyiWqPsv?=
 =?us-ascii?Q?JnqjunC7LWIv/p/KyI56JxplypuEMwfqKGJBpwHqL7IFKlWn9fNA6HAMCavF?=
 =?us-ascii?Q?c9+qGbSN6ijW0Of21yV/QbWdEvwtnSmHdqtRlNgD4Rg5P8JFnY2yOj07OO/d?=
 =?us-ascii?Q?lI3BJYI9ydBysDrNQJp37GH2BTz++6S+PJytXIvPEfG6QB727R5Pd4YUBlP1?=
 =?us-ascii?Q?edJaWUIWxD6UvgJPuUiCVYmIiE9Cw+y+cbRKDDvu4eqCuJQuhkWzqB5T/KiI?=
 =?us-ascii?Q?BMLKo9lWTcdWAV7kw6y1rD7quIXCi90X4N0kWYLy3yVdX6mejRhHz02BpTye?=
 =?us-ascii?Q?6olkvB+sOICiMLBV63vMrSAoRiKfgRDCS7YbKVhqabuyTeWpB3VX7k1ymycE?=
 =?us-ascii?Q?LeL+vfPtEzV+MayVkNRlxFVBgs+AhqDIFlUhz3X3rwUxj9VLYU8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eSR+2Lsvr/JL5MXqSNIZX0EcKClzBlEk+72fn3J8/ycvQMiKTZfucVr96a6O?=
 =?us-ascii?Q?fuTyyjvN+J+Gl8Ta4yBDIGN7JBWsUjfYBhxQtBXmwme5J+4CtKibXSDOqSd6?=
 =?us-ascii?Q?zvAITTjDNivfkbv2IkZ6Tycl4YplkwAm7DDvkZ/JhHCXhFjyKUyvg/Xzg79f?=
 =?us-ascii?Q?V7yUyO1FLS9RBPj2sVOQkkplXg4GyDcVAnVQelRb0onnvtVib7N4bDJ937qo?=
 =?us-ascii?Q?xIgLdZTY+yGGvKotHVOT4VyBBgFSTwuRpj0ecLACEz6LCGelgr0epYI+p8Hj?=
 =?us-ascii?Q?/Y3vDMhJyF1bFzeupEyxw5R6bcxBI3hcCCjNBQ+P8dbkUNGfcPXWsPMQtYfN?=
 =?us-ascii?Q?BLx1TP8tsyab3GYeXT5gilo00XrKxHQ8UHrSUEv0D86kHg7TrG4EJpzl8VYk?=
 =?us-ascii?Q?I/rPRNqqeS+pdRC1DoEZKHbxMW9udLJ1x+74A/rN9XabWs2replltMZ6uU1l?=
 =?us-ascii?Q?sSKuKUpQLts1e2iiVsXsSnU2vuzZbQCeFgYPu7jehb75oouX11216siha0eH?=
 =?us-ascii?Q?sZEVNQRGaUIlICy8S6EkYYZdHbllIMeu7SqOnomJM9uWcqXb3VLf6znpaPM0?=
 =?us-ascii?Q?boO34qyvi33YW7HSxWV1n13WswOq4WRTkAeHK6Uxo8wT+NetsENIXAAGhCJa?=
 =?us-ascii?Q?sfxwcrOirWqODJnNFh9rXTJ4Vppc960l48+zuTfx88Cx2Go7NqY65D2TKu+n?=
 =?us-ascii?Q?GeudFot7LljxtW+MfX5TMqIt3CTGl2yr020yRV0WXYgVVoxQjse5+MQDUB0X?=
 =?us-ascii?Q?67wJ0cZd2K3fpGn3WV3VvRtJ3/lVHEm/0x0H0SnijNVKtliWGK3k6X8gY1x5?=
 =?us-ascii?Q?TG7/ZJqKHQTgUgfAIJ4GtWlJBXWya2ms3HAIuAEsv2Oe41SamHdOgaMidNQ8?=
 =?us-ascii?Q?RjUDLJ1eV+9ALWBOGEKsgU/u4fzGLBOgUijcj+Jiiysb4dS6ODCXck1HKey7?=
 =?us-ascii?Q?ZQU+3QmzCAFvn02sbycC7SdsPymrP36AFZXTWp8L+XF8O2y6JyygmOFW16ty?=
 =?us-ascii?Q?P0RSvk9s4RwARB9nkeUIqFdNAS2VBl1RsMyIhz9kdxIYI0RMYNq5QGapLGci?=
 =?us-ascii?Q?hFtpaqKoKBLtf/DyO3U6ZKMOswtXPbWSaUyXGhNcCSMwBVSyjB+SGYYuScoY?=
 =?us-ascii?Q?eJEB9XGHFXtAi/ag0dhVsmjiXueUDYNuo09D2VTfqY6jdcVMpPUE049aNWHk?=
 =?us-ascii?Q?/6O0BnzLzNISPYsDcBvauf0PJab+dmobUaB0QvVwEEuQ4EWXNSkjiyxHxw/h?=
 =?us-ascii?Q?cJmcDW7SlgI47F9aO0vuyXNtaUXsYNNj4XXINQQOI31V/GpWnusw9zIdFtqe?=
 =?us-ascii?Q?6SqQWd19tAUCWnt3oXgcY2YuSjxl6aGUxhgnwhw5R4YoLd0SKZ+pXyBFL7A3?=
 =?us-ascii?Q?78qVhu/iTLrhlqs2a8IrAqxv6LGEfgH+iimhAD/gYwDzCxirqQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11893a2-965a-497b-35b1-08df3dd0044b
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 19:39:34.6568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

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

