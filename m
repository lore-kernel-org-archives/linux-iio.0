Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794407053;
	b=ZIZ/Mzk/VWiAICA6kr99elB6tG/anlnfV0GO+aUprGZnC8hOgr45856PTYnlu2Rcwsoh
	 NSTuV0VIF0d5oU1IxRw6myPkTj5IQlHW6hx20f8+RPf1tYpUMMWRHMBbjBIWJgTcTqGNe
	 wiF0D0esC1LFHaZlzNfU03uRk0VgkoaoNUKU1bOrsA8asdl6YiudvV5SkBeo1cD4oC7xs
	 NR50A2QZghZyQ6vG2Sk/rFlfsr2ayIPPeH5zNhv+V8tr5VDFAUYWib2qJaiWiuIyYvm+7
	 vpB14pdjLWNxBB3aIN9fqohlvPe6t8UR+UmBKfYi/UrO8+xT0U5nKN9cMLeUomIRzRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407053;
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
	b=qXPA6AUDboxwnClLZmH7W/gWIFdeUJYIbaftaL6On0q+NIaaUXgd9QiBwBo1Gg7G3Cuk
	 QHbpMLRwyZZJJO+MOncYEo5qdb5af+50G0OnFpChrrP9uXCx2ULxAeetGjtHhXMtPCOmQ
	 8gWOc8U2jfzqneDWGYcFfBQQc7VnK117SegWdjl7bQefeALDOvgAsse51TG9Uik+3lFhk
	 iDTFzA2AoXxYWC+yakZBM7b4kqEI64bC3GAKaC2BkkGXAiylfvd3AKOu8H0dFwxbEWXs+
	 9azQQFEK4j1vgNnHxg2KgUjTM/6CUXbfNii7aV44XWLU6B3jkS95mGeFDfZvYOwgwSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ZK3Jy7l4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.22
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012022.outbound.protection.outlook.com [52.103.11.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F5606A339;
	Wed, 11 Nov 2026 14:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B14F5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ZK3Jy7l4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wg6XbrdXZmP8cLQ7fkMahfcfmACVkfOaVkLavDii8fwN6+oLVU/Weo5NFpwPCK06DOOGvjq0g5l37eAX5s7Ux9JjYVT6ZSRPMLBDgvLcU4j7QICnSETSST1W7LW2NZ12gMCVniwrN27w8SM9he1M4iIGQ8QjrWsxiyegDiqHcqNcaQ7YyFldYIL2Hctk7BqS8iSBGd2jTNqli6Sivr5h9y8llcsAMyBN/3lE9XC7LN11NOdUUxd2Rkv9O6KAoh3Kx4e6Fa37PWXZIeYf7JctTuY48/XzEw7ItETY9lfNT1m6Kuf9eThLSC2st7tY/JbIiVy0ergh7/EvvYPShiTVXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHdfqmh1sx28Y17GBtqfP8VlpKysSu2Fq76IJlSdA8g=;
 b=YVoCwcPFCqxGDw5gkJQ65axNu6/WYjRcL9iC4qXrGphPLsuYtUXFbzU4C/nljsfaupe8JxfQ+646wRTu532TnknmGFwqVkPb9o2GkGhjh8OZ/PKgOI7WkZbCyleVPP69oKs4N+29QBxcuXxQ1cLqZB3LJD8RyVJXE3/vsUmrvvAUQqe184qMLt87swgfUkBCt46VvPRfM92P0+K9MMF6WNkRTiFiVtXTvdxF+J3pmfgX9nZ0rTn1S52iPRiJXgg0tcJnYXC+xccS5tMGqjUU7UikGEqULJXYQGgCiEQy98oD/3wO7Ii2/DIhVjcYGtsQ06uH2Ttl4OJaotm/VH5VPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHdfqmh1sx28Y17GBtqfP8VlpKysSu2Fq76IJlSdA8g=;
 b=ZK3Jy7l4imhAFYoFtIsme79RKv6JcOqJSAcUbpzf1I+zEKQ+NgGkz5m2mXDsne1XGH7x9fxCgR0l70YEhzLva5mVbusVYuUQ0dTYaE7VRh1mfdvDOSHfoGV4aTWeFVWNfWimwQ1zmwfrjV7wybrH799cnzYpRP0RtOC7a4iATgpfi4G4O/2MuKQGA4McwsHYNQFF7RDZZk3IhcjjZKKwUtwo9Zk5dO3h8b1pD0yp1MTIA39Stoo4Xkn5aDjjwGRXlTZurNoLFVqqF70pRF2dCMrBDclnXNkgcJiwxNQML/uhUrRALJ7oC9G0wRTGjiv2H8/I0JEIuxrdHEtkUKBNHg==
Received: from MW2PR12MB2523.namprd12.prod.outlook.com (2603:10b6:907:11::22)
 by CH1PPFDB1826343.namprd12.prod.outlook.com (2603:10b6:61f:fc00::628) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 14:24:09 +0000
Received: from MW2PR12MB2523.namprd12.prod.outlook.com
 ([fe80::336b:c57a:e118:4352]) by MW2PR12MB2523.namprd12.prod.outlook.com
 ([fe80::336b:c57a:e118:4352%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 14:24:08 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v9 1/4] iio: prepare iio_format_value to handle higher-precision IIO_VAL_DECIMAL64_* formats
Date: Wed, 11 Nov 2026 08:23:54 -0600
Message-ID:
 <MW2PR12MB25236AFCF49B4A654DCB86E3A5712@MW2PR12MB2523.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <MW2PR12MB25231C3FE75A17CEDACDB279A5712@MW2PR12MB2523.namprd12.prod.outlook.com>
References: <MW2PR12MB25231C3FE75A17CEDACDB279A5712@MW2PR12MB2523.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:610:e5::18) To MW2PR12MB2523.namprd12.prod.outlook.com
 (2603:10b6:907:11::22)
X-Microsoft-Original-Message-ID:
 <20261111142358.22099-2-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: MW2PR12MB2523:EE_|CH1PPFDB1826343:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7e5bc1-b448-4d28-f7ec-08df3fff722c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|4140399003|5072599009|22141099003|25010399006|260925184616899003|24121999003|24021099003|22091999003|23021999003|15080799012|39105399006|19110799012|41001999006|8060799015|40105399003|440099028|3412199025|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rFJ7lg4ZguBVDIjienNdCLXklsoKM9WXPpp08Jo3K+SdoQI7CX+3nxjzM62s?=
 =?us-ascii?Q?7lmp4hy9Q3z1xEB0N9H32/XVZgbYKIR6sqPIfT5cZvCHOxX3ULPWlwrzCozl?=
 =?us-ascii?Q?bG/39/dVQ6ZpisVd5HV0wGJdi46OWE4sonLBTJxX91yrGoUNfRZTPi/imL/t?=
 =?us-ascii?Q?G8JGQUtrDDcBhQQKMbBeOEuzhSTy6obfQOHAZolKAdSrMoMBXqiQEJokCk2c?=
 =?us-ascii?Q?Wi6zTZ1E7IE4Jhff4b0wwxycuwdHlmjy5Go/pCYV33qWyQaEuLK8tIiG38Zq?=
 =?us-ascii?Q?kiEAbh3MCFx+8KcgyqQgKCPGLx3GDxFnxZf91hG1R6b4e94q/NMQ43gU4D4X?=
 =?us-ascii?Q?bD4TONAnWxnQFh6WxrVazgQkIAY3pnV2YC01UVplU7Mi4GbWYNgHu/G648qQ?=
 =?us-ascii?Q?3YrocqmCBaB6D/5unm660nXoYrxfwYzUdhWnniXx07VK2E60L0fCPe3bfOQj?=
 =?us-ascii?Q?7geCJBg8nb4OQ0xbP5KRknJ7ZXGs4nllJSy8bajgRcCp4FLhUlXvluF0sQkI?=
 =?us-ascii?Q?+9p7/aPUcvzZi2eKI1kwfMzh0LhBSsx1yX8uvyan1FKW7qDjZuM6kuZsvngf?=
 =?us-ascii?Q?ZDFXO5UlvKzj/sNP8jAwwYcVxwgf7xsXUjdOigEricdlDPux4wYf0kPQKXbn?=
 =?us-ascii?Q?QCHc/wKyvbP/BqoJUAhVj387e53F9umSvCYN2BSrH1n+EygmefRCWy0YMYJu?=
 =?us-ascii?Q?p4VPKG0xWbHaBuf9eKbU/jrzayYndRJP247a0u8irN5Dzwlp01LGqlj5bZJs?=
 =?us-ascii?Q?IDtB9q5FC4Te8dJYXj3Z3MLkhe7qDhPC+q6RrtGYV54YRLakqyeFSaFHFI+W?=
 =?us-ascii?Q?Q/IipH5NE7+M3R9qa2Ij0/16GMSVfDW/gQ0EJa6jJy1BOkatya+nrH362e3+?=
 =?us-ascii?Q?AGfvqGprKUAcyyb99npyf4t4vDk0qPsrM+CvMs/7ZwtSeUXvhaKy/Pb6GN2o?=
 =?us-ascii?Q?qnHvao0SPWWUH6kDItt0DqIq5omHUSaOmjIzgaduH5D5KOsYDhWQSxKfAHZ0?=
 =?us-ascii?Q?j/ZOlyPS375SJFGKi0mQ4Z4acH7A8bwov9aU7aaSS8pLhoqvjJ5DeE4RXEp6?=
 =?us-ascii?Q?Yx2SPxz8mNE3T5b9qh/laGvrmha1BYCJIhaUaNGNH9IwD1KL8nCzOAP0mshR?=
 =?us-ascii?Q?v+gCZ5GmjYsR?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T6zSi+57Jh+pP68SIqyIhQV0bqwYgCu97+Pwoef9VEjxtg/QhmD1UVgOM/Hd?=
 =?us-ascii?Q?tKbwHhiTe5HA3qU2mVb/bUl4fZ3F/0PJEhLDwpnV3XwNHbkb88PLjlTlQr0p?=
 =?us-ascii?Q?lEYLS8uoeDgaVh3YbUeAIKeIHXKsMhZELjhduJTRPLohiRqhG2Mrl2qx4nHL?=
 =?us-ascii?Q?HYTNHWiGAFXWp4cQHC60EldH4hqXo+jW+DTCbd+I1o38h4qRyYcm3Ls1FAcc?=
 =?us-ascii?Q?CG/ke8oDxn11v8dvO8grw4Da/tk7TgmK43Fsp6+sdW23s7d7W0XenprI38RY?=
 =?us-ascii?Q?WvxcII/Z51AGxE4VSQffqTR4dv5zmeGBwSC5qrVhxXsQw0ZU3jjru7esaQ3W?=
 =?us-ascii?Q?suG4iXK8X2K/5d6Q0h/6UFbbVH5HghdCGLuRgiDgTuOBwHwVxwFv1iRsH/v2?=
 =?us-ascii?Q?vKZ4/8uj37hj9cLqf2uef6KEFxE4ViJAKAE+v0oNB7bmBI998z/dqh1O8s/l?=
 =?us-ascii?Q?MeM+HXV6gO/8iYvT8Y4BFDPl3McbbNIWYF8NWdzoF7sVRqxmRwpoz1cDV2nk?=
 =?us-ascii?Q?Vip6Vl3tKih6/rJA4viZq+U/AGrGzyL0lctVZ5AtA461kCQpiyziCf9iNxrO?=
 =?us-ascii?Q?n5lGJcrZG33hOQ/uqmZpOOXlmR99FcWvd9YMpcyhyQiBO+HLoFO3Gpcc5IQ8?=
 =?us-ascii?Q?7Frhfuf4rR6tdpEI1W5VP/p7bBhOo9fRNk+RysRb57/N0MWF+flWbA7BqGsi?=
 =?us-ascii?Q?NbbFQbTksD0EwrJrfgMQGC1SCcPBXxFiHdx32xeFNkP5fsXhR+5aLJRPxx5b?=
 =?us-ascii?Q?QpETof0W7QBfKFNUFn7HBWy95kOR6/gt7IeQm+ac/Ny4TQHfQwxeTWuXCkrq?=
 =?us-ascii?Q?1srj99U2GyTdAEMQoafN4qPbGyDR9nUomcJihY6GBuCm6OpBLRx+BGud6eA5?=
 =?us-ascii?Q?/IarPmVneNWzria3EqpODtS4JjkQB2Ex+qUL/IeOtduxMxAxw6PLy5DbVaK5?=
 =?us-ascii?Q?leSyiMwJ7cnKLiw19AoG0AJfVIjjpRIb8FGS0fAg4gzMdzHe/RynecqY/tFV?=
 =?us-ascii?Q?t85tkbpdwAjt8eUAVZAbup1MGZhQ6aAEAmnRP+5QVqk/CVTL7+ozk8X2xqTO?=
 =?us-ascii?Q?PgsXwZMc68UD5YzlkyhvbhsO/nyEsOdcRj6fds/ud1T5sJK6s9CVoyRybqjS?=
 =?us-ascii?Q?MFui/4Cg91jhLBasnTqAuqDxTgzNF2pXAS8xQ3Zimkl19aFugw0Ul2LzfZdy?=
 =?us-ascii?Q?3rBo46eWQCC79xwWOedzs+gXnnHphy3M43mFMkrfVTb3/NyU3gX6asYzMchj?=
 =?us-ascii?Q?RNWFcFshdNOQw7DJDUl00IRBmmZiLvltWCYcF9bBvd+LkjzNTZ6zHTO3YYFj?=
 =?us-ascii?Q?ti3fDXTMeQznJhVvu/PU/T7nivravkmSouDVVjKyK+swtPLJe4ia+fcfsavG?=
 =?us-ascii?Q?/8zLx3JPt1VLK4dOJ9XrIKlLCVhzQXQUm68vpoyBN37E8MwDsA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7e5bc1-b448-4d28-f7ec-08df3fff722c
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2523.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 14:24:07.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDB1826343

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

