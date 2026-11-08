Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794166783;
	b=2PCsp6cvhKOa48s2PQv+w8ANVF7PnHrPpgAi2ycEJjWaDq/Y10jNANn3ldM5T9IJx8zm
	 Jcs8WtUdqULZUoGfFYQh0rZq0HBxA5GTNhbU/Kx3uypeFMJeXtEbgl77b82T/od92ah7u
	 GZ9Y475h5R+8Nk5EsVTomYI5fDpxknTPD7tddETCykH47rfWIbyiC/tn3IOj+xJaJPP3R
	 z67/VimRERSW6q9ZlSVV2/UXCGSgKrVpyZYs7kUcGjO+kAUQboLKtNfay1JlX3Po+9/eR
	 vzaKeI2hvz30dQFwM0FlC2mSPDxyuNGyA9xTr+7Lp5aVOXDTWRI1s+gWV8N16vVr43g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166783;
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
	b=tUArngogJJ42G7s1xGXhjQhCfbN3IYy5u8f/zDCjW80x5M/CyFtdQkmlZre90QQ+8u3w
	 uJVvxukZ8RA0l1rd4KpNfcaWr0QkDU0kU7+U5iSXqG3dCXsnz3r6sIqxVvqw5y/S+FPL+
	 DsrkGOXe1xq2eRL8pmOvgYlWLlm+Hw/Hg1dFUSKEenFWB7NjAX4aAhZnOZld5cIkZyWwW
	 W2Mwdco4bwBWnzr8okrMjrxRLLhgtMT/ZmtxI7BhDiEG3CGg900Ldu980gOKZ0/Gxsv6S
	 GtxJCtq9rAuOK2KSB2jW2cVz7pqy454H5YolzbITbPnqRR9dHPWjMyGqcZ15Ua7OarA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=olp6tuqv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.70
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013070.outbound.protection.outlook.com [52.103.20.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFA0606A332;
	Sun,  8 Nov 2026 19:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CFA0606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=olp6tuqv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzqfIUnbfm/66mMg+zPJPbA1goMXmvB9rlBCiQMSQ55AE2X+U0QpMQxNjfx91flNOZ/Je0caQOBCFz3lOSfOb0WkDb0BycBdLayZxATn+IEmGy+n2KuvGM5K34/2thcwpF9Fy6pMCKrlLyeJJIGJjspL2OMQhtj9bY0SQgvbxxFBVtf1PwoY1QTJldRZRGTZt9oo6ouMGfwXSV11HTBOIjhVeiTmUXvPOa2s/bojd+cS8QUCA627Fc2Jqc7NNv1Yl257/pfLPj9q0ymNn+Q3u9qS42t4o3B/aODJPoSxILZ7KW5rW1+wpkOmK8n3I6il/JgSq2ur/Kmax4/l9GUxPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CapBSMZIciUjEJlH9FahIYlpO550tSMt3mXknuF+/5w=;
 b=EtP8xoZFsekb8q+lqm4YLEWrCA0HL/Nn+PrCmNDRyBsU4ul0yd5ElG4jjEZ/TNf45ZgmgOfE6ncsMDxJ1o9V+5SIX9Zfpksg/Q2vvc0jwiMfXnZP/CkT44V9IasbBRwOBg3KQZVAcR90Foyp2GtuLUNJpLGjbVHd39V1KbOYmrtR9AJW7KkndnLb/RGABh8aSPTn0MTgKZ9V9Oip8eJnnvZPtIprw8m4PXpgGfvDBgTiuoX1phtx85wlSCVRsI77i5r6ND9D3k8sspEiMilfT+p7mYGm8JrEn+mDMFE198W7tygYd9YEy7FkEEHJZNwTlsXVUL2ieyHh9P10VlAD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CapBSMZIciUjEJlH9FahIYlpO550tSMt3mXknuF+/5w=;
 b=olp6tuqvK61bQAXENEuPXqG6Zrhvm+nOLY/mDwFisdggWvslNBNg8xvKQxCk+Py+ijQNnrBvqVjA7cE56DtlL7OPEjjWZnV2aA8a3orbnUAagyFcp6BPlb3BXpGc3U1mtaxYlvvxb+6ggTRempOnhtNlysOI6CvxPEilvLTiSzkm5p8Ij1YVepWJXNvvAW78sJILqNWZaikdOZezLaJO0iEls6lxNgBqST8ScO0agD+KKV8ctkb+R6DPhyxiTeZbw5rC83A5Zs52NrovFJpCZkQ074jsl19xLdeb+P43FeCO3HEAkLkqwVnhHdRBKoG+7rhHWRttgs/lsZHnYzxb0Q==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 19:39:36 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Sun, 8 Nov 2026
 19:39:36 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v6 2/4] iio: add IIO_VAL_DECIMAL64_{ATTO,ZEPTO,YOCTO} formats
Date: Sun,  8 Nov 2026 13:39:21 -0600
Message-ID:
 <SN1PR12MB25284B0B5DAB1E4C37BC940FA5742@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB25284868749912841740AEB8A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB25284868749912841740AEB8A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:610:b1::29) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261108193925.977273-3-chernyakin.victor.j@outlook.com>
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
X-MS-Office365-Filtering-Correlation-Id: 96398791-38a1-4846-c304-08df3dd004c0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|23021999003|8060799015|19110799012|15080799012|24121999003|22091999003|260925184616899003|4140399003|24021099003|25010399006|3412199025|440099028|40105399003|53005399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NFboQu5qzdenayUfByu2ynXv60qhD7kh+DCqkxlY6jAp249dnKny5hu06n+b?=
 =?us-ascii?Q?YFUpK1JrnrSBwxmFOdywEYO/M4SzFz4WNICgnzxqlfpnh6UKXIrDzXES6jEh?=
 =?us-ascii?Q?sYEj9gKw/aTZt/81IJJhSrf0T9bpF5AsHOsBwrbqs8VnDKXO9/sZOOKXvhFu?=
 =?us-ascii?Q?lF65jik9cnjj0q0vmyLxey73/F6SeOY3zq0ZnQHO2Yjwla+bbkpsRhZkziQ2?=
 =?us-ascii?Q?j7YWptqb1MlpCu8FXXvoBBEeKNtXxe4F0zZAi+hfP85OcC1GqNdBv95Uvmi8?=
 =?us-ascii?Q?FfpuzPOcwJQJYNQpxgYhyHVKGCek+d9lQ3O98MCLPgvTWFfYJriysi0FrfvV?=
 =?us-ascii?Q?R3QqAx9eFnOQvDGqj8w3ta/lSUHoCvQLLANEkVH8vKyapZyZe6SiOOuUyn9e?=
 =?us-ascii?Q?yFg+A3QeJMPklozIPbSKY1BkKe1KrYNEH3V4/A4IbrFHcP2gLP0xaXMMMOJ4?=
 =?us-ascii?Q?nb+m1PqSW7/Mw+dKs85I+zh5cbKAcMFSw0WjHtcpiAQpbSnqTeeLf9w9O2e6?=
 =?us-ascii?Q?J6ILYdDmyu9bUtlYsSkpmwg3BQ16uWRQwUYEpvVZBURBoHcuri/UoNo/Bf3N?=
 =?us-ascii?Q?jmJ8XA+Q588ovQ5tX6hCgXM/+x6oKdEGpyy1e9Hm6xcxKky0MhtO+aa99VVa?=
 =?us-ascii?Q?wAnr+hy07NJBiXAPqU7d0dlODIxS5Dq3wyC/En5TW7K/NXOqBc0wb9INH3Pd?=
 =?us-ascii?Q?uYbxoY/FwgywemzZqaRE6+2OOaIci/fB0vlwZVi0LLtxdpIvSMf08Do4w6z3?=
 =?us-ascii?Q?YaKoc4CuDW2YSXCM/OH074sSbsfWcB+Dh5dmp2afZXGdTx6f/A7AiFxlXuhD?=
 =?us-ascii?Q?LTNoyp0ty0fD5YdSphexyxR38V6Ki/P1UPdfVL7wy4k5oOBOr5YwRYcy+bH7?=
 =?us-ascii?Q?UM5t7Z8gvbG/OrP32aaGjSqf1L55sRlkj/CLWUm+XmatnnHQHYxLsj4pstEe?=
 =?us-ascii?Q?zWXE9oBJTXqzouRQbA43J62ofU6OndYepcACPK0GPwm2MCopDRUZ+Vc507J7?=
 =?us-ascii?Q?JCQuP1WcyyOKzEqeUH7Y2/sASQ4rSnGmhgDCdHk8er+VZt0vvwYZbGWvqYV1?=
 =?us-ascii?Q?o441NK8A?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A5CquJ6m3YI9GkLdIQ4bqQ26Zg4HE8PCY87Qi/6oBi4vmU2s9cWqfDl5mVOQ?=
 =?us-ascii?Q?NQe+VWaES4jtmGABpkQQGABcRRgE5iWWtEzIxhhsxgfXuTgfp5Bg0SAt9ZaE?=
 =?us-ascii?Q?z0Fk4Bz4bP7Yf7pPctXtZecW6tEh36a4hYN6vRePFfJNKZIegaPCv52s0rey?=
 =?us-ascii?Q?zvV8JXyXe59MLinGnzPo2P3xOOoiRHwec/KKDVtkjEszQhcgRdcw+n7l7906?=
 =?us-ascii?Q?1cdz8IqeHy5E5mVB92iudSaPuYSuop9nMAEQJzoxzRbd1YF7svplxMf60Ls4?=
 =?us-ascii?Q?6F3x8WT1/2W0ytmBMf/V/Y4MXItLSHl1+Q879jTZU5mzMxKlEpjNg3x35Pb3?=
 =?us-ascii?Q?/MPqyxta8Mg9M7s72ztD4rcwrGNIqRVOXiuFoatsm2gbunbGgiv81t5KJfn2?=
 =?us-ascii?Q?jDicrwDOuG+8dUonFBcWCdXeOhySPBr+vdHQ/OgaUrXvPFvpgPbgGnBj29rM?=
 =?us-ascii?Q?V1LHWQZsg32zabi3/ZkrDwz9+8dyrTHEL8eaOelPJSnoeJhG6WdGnDi2PaYW?=
 =?us-ascii?Q?hJprKbLH4l/KSs8rmKoW94rbyMt4UqyxwYuHy02fxTlybRLQQo3qCWiu/MK3?=
 =?us-ascii?Q?aoLDM00V2EcEd3zU6RhKdcJGGlrOcU7VnCaQI5Avh9pvBoqky8BwSRu+dUXu?=
 =?us-ascii?Q?w4ldmMFX8iVsK5N13e++OHDgOoYLIDCga+KQtickGHAOnRYSAb9DRMOT0rEv?=
 =?us-ascii?Q?To7PaywqffXxHURaMdOwhEuXOGxg12MOZ6ituGK2UGk1DnuamYF7HFJEi6Sc?=
 =?us-ascii?Q?Q6TNlo5oQwmsyKVChtP5V6zB2HTmwrzAMIcDi3EyCC543+3Yfux68UgJrbjp?=
 =?us-ascii?Q?Kz4Vvz/0Jw4QLaVdX6L0KHSMKLTzgUA0UsbL7R+3ymW2+/cFST3d2Zn6N5gK?=
 =?us-ascii?Q?pDoKF8zTiGP3m2SCIyKrY4Gfc/MmUb+V99qeFIxC80nGD6MXEQ+NwN1sVx/D?=
 =?us-ascii?Q?Lt5Ln6gyDCcVh7I43Pz0lBFzD47I3dOJT4wMUaG9kpwghHIXiHg2LmZ/kv/t?=
 =?us-ascii?Q?ecdhtIKmSXsMYgi4S8J6mNyGWF1mVGLOFs8Ne59lP9ZnK3woWIhMBKgzgdKT?=
 =?us-ascii?Q?60ro1opbEuOG1K+/F8kFQMBgTwRqV6GkW0FYLJKXD1sfXKqh3Y9opeORtdtB?=
 =?us-ascii?Q?+8PN19InA6eMsydE41DM2gaz2cFgbEmcBOe3KTZAIy8aIjdN8Cb80Ap1FMPM?=
 =?us-ascii?Q?OWwb7U+97oUGdj/MX4d5msMo2TYgo8oDswa9wmEMAlyuJZENPxxJN6h8vKYa?=
 =?us-ascii?Q?NdpIAu9rUGUmhqR7xjSLL/i11pFtKdQL1NuQ5cmehB8nE0NKe1Pc01zjUBOZ?=
 =?us-ascii?Q?iagQH/0tXSntvQI8uMBoMEw16an8G8fVz4XLyGLh00c4YmkNhvdpXYe0HE+P?=
 =?us-ascii?Q?PedS9gxIJ+Nl2P1tACGg6yzgg3LJlRG3+dhGBtjun9MomZrCtA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96398791-38a1-4846-c304-08df3dd004c0
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 19:39:35.5883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

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

