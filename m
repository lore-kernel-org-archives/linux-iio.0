Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792907351;
	b=JqCsjb3HK3EE6oefUo+jyjbNdQy+ONJa09GBpBEIqlZBm1YR86sSrzAbGDXy/C3QJszW
	 SJDBnGgETgik7B68yyBetENRDAWHe2cLbiMk9glhLNzokh7cVn7WB4a4nIyFLZGMepx6o
	 tLUalPZg7hZzZNPJ2rjQw4jCbvDOg2kX3HpHtcTTS+15CJ+7e1w/Sq2ODJhCnC59vxxDb
	 DPmWrrZT+7Zj+MPTs+zkfqW1d/iLoOnEr4VqJWReCFKMCSPwqcUx4u2SZ1VbdHTNs1/tc
	 Wx7LL/Bk25/xpbQcsd93DU2xJ83BPjaK7YNqbqEL9tkRda5VVECi5M/yaTD76Y26YMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792907351;
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
	bh=I3MZcKUPZ3pemyIV31bOIDimxBYuiq1LayeHHIgG+g8=;
	b=oVvqOqPaYDVZDKrj2RBrHkdU/1Fg+eRH3Fj0rwumm88EELUOVh7tibXBW2yyHr72MHCv
	 0VabsMTPTT0ZuDvaSTgGXW2iDHnPM3Lf1/m21xFpXSnLhdDcsSo1P+kBMnnoR40WNVAEq
	 qn3ajQsl5FTN0V+jwlXZNFuH9b8uLzHQ/Dnd7ka9w8KjWHI6y/d9DRfYQ4zg5PKQXEz9C
	 YkTQfxCiIdRrfBfr4MtD4430ZRqFUIEsVOu86Agjgn2fzgRddOXWzruKs/aCMjWcjXnC0
	 Fpz/G1eq2N+EwcXo55sCvUIU1PFTF1/MIg+mV/g84QbtJIMSQ+pRfwWrZLDQ1VnhHcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=tjzvxEDX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.9
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012009.outbound.protection.outlook.com [52.103.23.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D82E606A321;
	Sun, 25 Oct 2026 05:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D82E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=tjzvxEDX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZf/ZUrx3myBeGlc4Xai82UZHNUcaRTZY1MuLiyCnbNAcv+OG6PoqMHgidHGuh6a9UUy0L9fAZdnh/QxRX9prb+BoU4vLOtuai0HLU8lXA40YYObCWqNhtpyhnXiOn1KHElc1shRPGGQyrtfHCH965dnpsQzWzpWguwnYJZ6+6wMiKmUg5XwhbbUWfUXGRIgrGBsQF6GKMEHNj7NPfhpQERBj7yPp5ZW0GtP8u8UuDUz3LBLEVBiWSOTUzqgnmIQokBdLyBrdZKtRkTaqYOjrX5q9BsdVPok7UFhY8hELqFaWWuW8QZTZrOJWN+C1NNRjbtNd/bTyEABVq1c3IbUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3MZcKUPZ3pemyIV31bOIDimxBYuiq1LayeHHIgG+g8=;
 b=y6WJBZC/pTfuu4EtAkRrWU62BAtgJEeJO8l1iPgxK1hh6JawWZHqISZxO+qJbBnlSnf7XQbUB0UXYNRvBeiWewXCWh9FY1PQOSKRTRjiyuYhsEn3SqbvGTjpd7jsUl9joG7Z5KM2CTLw9ccbPGTITwn3Jxcm5hbshXk24edQQG/6fbCLuvG/B9hYjIcMiwbW3Pvj+cHl5RwRC93YyDTRcbjpEWqdBQI17OGXEdyudnZrtduXDY/Mj5tq9lplSjQ/E3SyaKStxwqnaA3scdiRI7NhkbecPZ/Pw9dViGxYYKvL/IY2OJj8nSqaoWGH25qvG1Sywt/lFHAP0mNRfRyX/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3MZcKUPZ3pemyIV31bOIDimxBYuiq1LayeHHIgG+g8=;
 b=tjzvxEDX96DTJ5X7uecnC/Z7LsPHODJcI+EAXxRYTNbcYmf8aZ0FLTGmLjM1gIjE4WN4R8Fx/g6j6N7+zzp5kR8cx02H1aWKc2cyZpJENpH8PRuDvW/j7xuv5c9ozLtYu8W9j4dguJ7vrVunC8fqJ3Cr5J9d+a+TMTk0996g/JPJhiEY+VorPyTxhqeQkF4CeufaWYSiCiMpBCjSs+DO8rMV5Ja7KctkS7nx9HItZ+OWiaqXoJjZ3c+sw9PP84JcY1mEGAjBt80bjN/pxg/03LtiOmrecGCYk2bR0FnPRxcZYdiE05EBwv1KGo9XxkcFuNg847GDl6/hLGZB6LFhsg==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by PH7PR12MB7915.namprd12.prod.outlook.com (2603:10b6:510:27c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Sun, 25 Oct
 2026 05:49:07 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 05:49:07 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v2 1/3] iio: add IIO_VAL_DECIMAL64_{ATTO,ZEPTO,YOCTO} formats
Date: Sun, 25 Oct 2026 00:48:04 -0500
Message-ID:
 <SN1PR12MB2528A44C0997DAEB1C632F0BA5622@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB2528DD1E6067CC4C0B76746FA5622@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB2528DD1E6067CC4C0B76746FA5622@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:610:53::20) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261025054850.33748-2-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|PH7PR12MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: cf0847f3-df8d-4cd1-5df6-08df325baef0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|51005399006|24021099003|24121999003|22091999003|23021999003|41001999006|25010399006|19110799012|8060799015|260925184616899003|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kjbGALbnY5LUSwsQxbfPUTA9CDUcdnAe6DBgytvu/UAzgfKh+46i29qrp2t0?=
 =?us-ascii?Q?Q59zVV2zXR5MgH1NGC7A5TPNApOjInCWyi7ALsj2jlZ1R0MUXGZUYKNgMGtP?=
 =?us-ascii?Q?IvHjLhGcvZhN+S9U4ffJYvB40WTiy6X+5kBnUr5YulLg/rbuN6P8IXL1Z6/T?=
 =?us-ascii?Q?N15+fEKBFsbjH7ox9z5VOKGMefkajaaQ4BlVFEemgo7BGFV2CB3rNnJQ/R7O?=
 =?us-ascii?Q?pXvDutm8g0xzR8zulAc1XCXsozwUocd4paQm1NaoiGVEfd3CQweglJSwdmUt?=
 =?us-ascii?Q?c7GMzm+lQkhqqrEkf2C5w8lGawvChwPIXhVwNZNOxT2VGjPp7LkJGCno+m/0?=
 =?us-ascii?Q?EwppvP4emUvKAGHb+ZK0kWBtrVtthORk6hubmul1f9EKXJBcGDlMtui9DSD3?=
 =?us-ascii?Q?VagFFSLmRKUJxV0Ckzhj2FM8UagBS0NHM+32zTXIyu+rLMZfCHC37RaJ4Af9?=
 =?us-ascii?Q?BNS//8YYDOHjObREX+EoaqiWYSOArGaMMDVVVL82hOnE7dALaU74FxOzkveK?=
 =?us-ascii?Q?0tr5liN0d1Gg05JdKxCT/+AXEi7p+K7teia4rA3ek379o3y1RmWBf0mUxy4M?=
 =?us-ascii?Q?V0++YPHf89rbaoxu3WTKui3boRL8MRw4Vw8f2KHFGQb/DGmkXFBjKGA9Tsbb?=
 =?us-ascii?Q?4o+EM0elQlcU5J4eUxEgRt37KSpySYaMgeOjq09xnW13gro7e9cW570bOVx/?=
 =?us-ascii?Q?HKmz3CDiMwFL84AItfxinGNjfsRLx0YVtfxDkbTfW33sUf/X64xHrTFGwo6i?=
 =?us-ascii?Q?NIhjanpZg2HHm1hty2uEfZqpQNMSLT9lXPOjRUz3Ykxk/MYNeFmD1pi3uoFk?=
 =?us-ascii?Q?5elL+fIWJSHp3WwclLEfp3Vzuy5T5EBoVxqbx49/BMyC0xwVy89iinGw7U4f?=
 =?us-ascii?Q?wThmv98zzZLB9lLwWZNnJCsQsHpWDYqmcM+sa/iwn5zffvmfgrg5OJofkvth?=
 =?us-ascii?Q?LxEiJnLs1cVQ+JwZT4lvd1/czsAFDdMcWz70nqcX8zTZDJbTHO7FjzhiiAdL?=
 =?us-ascii?Q?mqszmlhYx640/UUlly2raDl963GD/uWJNf11iXamNlME358Jityd7Vs9puFv?=
 =?us-ascii?Q?ZUZpezib?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qasI9HdEvMzoiQbTrQukzBHZ+lZOO8oWxtkeJYg+Gs7EyxOiXr/huEK3UWyO?=
 =?us-ascii?Q?iUmh3ewpjPLmJfLRSWa1SKPLb31ltIUD+SqW8MwkH5Pzt/Bh2gnmKZKQjic/?=
 =?us-ascii?Q?fCmKCJpFKYLFjOIOaZpF7HCqwdZFoIGZ83rKe0hn5aXtw+lHlMHowUsGhhXM?=
 =?us-ascii?Q?XVVFSre25CdpcMZ7LPLYJ0n0yQC1AVl7APxo55GOl+5dlos6tpgG0GmG48Aw?=
 =?us-ascii?Q?xFcWPW27aFspPIInHMdnTCQacg/pu2OJDH9JK9aoxPHpYyjq+5r09XUsauUd?=
 =?us-ascii?Q?zw40DTsghJey5DaA3vBl5ZEGLbPNeBDLjhlsZIGbmB63zrvQgLPz3vOjXDt+?=
 =?us-ascii?Q?37vdUHdWKvbSnKWS2mAp/mUWr/wZmeUNdaubDQg/o3KoFAXufBuaDOdfbV6m?=
 =?us-ascii?Q?7AG9GBn/BhB1x7xK4ojmjOq7GzfIxZxTnTAsCqYguwzIA+VAUK73VN38hv1v?=
 =?us-ascii?Q?QsuQyvTdxTWK8x5C+VVSsYrWgWMnHUzrfgMNL9mUnztNs/S0BA02KT+986Q5?=
 =?us-ascii?Q?x2CGbxVfRKtOembZz+8CfdmKQkKbuZV60gCTlOgsAcdihcH6ueQb80Kw9mLO?=
 =?us-ascii?Q?V5QsPdu4IMdcwaxfoK/U1iJpY1kEM3MVf1c8CPG5OH1QhujZY65Wtk1psSKl?=
 =?us-ascii?Q?qHKAAQgDmabnWznMkJdoRyVcWiY6HmlHe/VlV/0HFX8dvCkxsqr0J+mY8NUI?=
 =?us-ascii?Q?6kCP80e5uNkZPZ5q9zch/MtKCFwolYYp6HPWkU/2fh1QfcbRG8+2MZmcpzZf?=
 =?us-ascii?Q?oqq9p2c/IgqOHG44Hco5c8NpTczaI35qMC5slGtFi53SwQvz/mZEFmCQhuLB?=
 =?us-ascii?Q?JZ85zMnc161WW7DYGas7EhPtcZbl5t5PALTbXXRgI9GSBMxAvjKtgoz585In?=
 =?us-ascii?Q?K7VsQKep3mUgy63m1qtfa+9vu4qZ7eXn6zZwz4NfreUC96AsvUsBRvC35pPz?=
 =?us-ascii?Q?4pBOhpkTprThzgRKiCgp9cr78z7NC9ypi/lAmh0YeyAwUw9CyhAex6/2kHaC?=
 =?us-ascii?Q?S3vsg5s2/7qM0B8175iWxSK+TrU67lxdHqyvjfggv9Dk5Grdnlb1bNOLJ0Kj?=
 =?us-ascii?Q?K/8eho/x3Zl5moeSxud9C+DRRzasQuCm7COvakCmYOB+ui6PyplBevRfnfWH?=
 =?us-ascii?Q?wsAp52+dcjEyLNSf3zHmQ8GAyrL/NLQWLjG8RJsmXYe38Nbamyo5UuOGUol1?=
 =?us-ascii?Q?0MAEKGZ84W/BXXgEmelA2fJZZXoN/3NHl1eC0RUL0n8oItixBXmcU8UdUIYd?=
 =?us-ascii?Q?15L7SBwtiSXtK50qmSjTgxCNo1j+jH5YlUuUHYEMzZkUpHfqR99Dq9YSKs9N?=
 =?us-ascii?Q?08XWJTZAWkpcn7Chy/1WRrHhquWuRO6cDXWvu39MBbq8GmAaQFTqVdIe84Vp?=
 =?us-ascii?Q?5rZiIJW4vffmQR7MvO6kcLM+I/AVZ60yGxRfOGd3HhZj19sLIQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0847f3-df8d-4cd1-5df6-08df325baef0
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 05:49:06.9891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915

The highest-precision format IIO has right now is IIO_VAL_DECIMAL64_FEMTO,
which gives 15 decimal digits of precision after the decimal point. This
is not enough for the upcoming TI FDC1004 driver, which needs 22 digits
of precision to exactly express its scale value. This patch adds higher-
precision formats, up to IIO_VAL_DECIMAL64_YOCTO (24 digits of precision).

Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
---
 drivers/iio/industrialio-core.c    | 28 ++++++++++++++++++++++++----
 drivers/iio/test/iio-test-format.c | 16 ++++++++++++++++
 include/linux/iio/types.h          |  3 +++
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 767a7794624a..c1c890eab6e9 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -653,6 +653,14 @@ int iio_read_mount_matrix(struct device *dev, struct iio_mount_matrix *matrix)
 }
 EXPORT_SYMBOL(iio_read_mount_matrix);
 
+/* An abs() function that doesn't have undefined behavior for LLONG_MIN. */
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
@@ -716,17 +724,26 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 	case IIO_VAL_DECIMAL64_NANO:
 	case IIO_VAL_DECIMAL64_PICO:
 	case IIO_VAL_DECIMAL64_FEMTO:
+	case IIO_VAL_DECIMAL64_ATTO:
+	case IIO_VAL_DECIMAL64_ZEPTO:
+	case IIO_VAL_DECIMAL64_YOCTO:
 	{
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
@@ -1034,6 +1051,9 @@ static ssize_t iio_write_channel_info(struct device *dev,
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

