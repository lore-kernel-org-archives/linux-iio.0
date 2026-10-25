Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792907359;
	b=reo2sCyGeFkTRa/V1er2OuMVmGYTw5O5xuNAwyfS2Kr7E4sn5R1oWFyHy5PpRY6g/rnD
	 Y5sxknSnw4HVqZLf2gjZMsYjnPD8z0rIQ1N2rDPIn+CQMiuDy1sY+x3A7Fdr77yIjjpES
	 BiNPyNuCP3yjkObamhxhi4zTj5ub5zyA+PuFOhtR22Gl5j0QRwLaxNTUgigEnlCqp5EiR
	 mN62B/5lAqfoNnbigQ8Iz1Xp7OKXbPLnMpdy8q5lClm1vlpQY0dOT/Q/Fd3XSq809Gkqz
	 aTzslpr8Fcfe2z8sbciSwYggYqtNo8C2dSb9dT/QhCAPO3BkrrS6xBetme+ynfphPlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792907359;
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
	bh=BtA1S0Y1D9cRjeoAuu3atnkdOiyh3DSbeSXixcICYh0=;
	b=AVz8N0Iar6Jgw6qvDypkPBGqzE3Z/U1Lz2PN1b7Sf6fqvFkwEdR8Qju9hl8n7VmfzLyj
	 WyHPtGnAUAsB3FQsruiYHuwSeSm/Bu5YVx++R43hMnda8TOME46oF1NLM/ODWau4T1pDF
	 GHx6GtkNtMUyYlfRLNi8LhRg0vzhrUz08hsBX8pzWSzhMophmHU3VbWf172GdhX0B/7wj
	 yk5cf4ltys4o2emxaz3aN1LSJQfHh4uk6rVFR+O8ocAczOipYk6h0NPKhgDpwn22xSSQs
	 ZmTCNpLEHpoCaIgswR8Wtym963no6NPRpJWoESxgkV586q1rM9VuuBtJlZ/Zss9Wlqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=B2Sf7hBo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.49
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012049.outbound.protection.outlook.com [52.103.20.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD762606A331;
	Sun, 25 Oct 2026 05:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD762606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=B2Sf7hBo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T233xJbKVQJANHwnKsCxDkkSNUoOSJ0x9Zs8vyGwTeGHT1JcbmwViUh4jKkTATZ9VtGuPT1puGDIS/aQrVfq8RuLiYTSirXuA7nNH7L5HjdLNdMb/Zn1Y5S2Zu7TiKOXHtU2SV9yLxdMMWFd0ARV5DQp41+h5cTqj4QgnO9Ej2igRgaZZCLRDVlkJ2e3omnDFuFcA1m93/ujjRVsiEFzL+VU+NZ1dPgMoIlxoXQajUajE7CxRf8/K6Sgxn/sxSCKAEQ0qGpFwpt825OqjJ3X1c60J/jtdKARVBA3tyFrkU7VdKdXJyofmdQS3Wv7K7Q8xys687/TnyCByCYVhr5VAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtA1S0Y1D9cRjeoAuu3atnkdOiyh3DSbeSXixcICYh0=;
 b=Yg3ZI4Nqcg8r58SyS2M811GfSJJpzqnB5ek/wolMerPojGGGqXUWZGwrq8d0wh1SBwPrOaqMxS/ecETpeG0pkLS23LfcDDtqnovSgFg7XUkQp/PdGiRwzg5x/ov9KsASpwTHH4yLErMX5XCGDVy1jAjEePNuorWkJldONO1K5+5xZaUGsXhC2lEnrSwaEnFzD7XZclaYflL92NyCOsWQPU5VdsZMXlhvWxEVlWBa3zLmwNJndsmKoy0AnQ8RrN+mDmCujskWF539+ILdEteQ0EiMw+L9vG6jSSObm3eU0X3/306wHwtw0T0dOZULTzLzAikeuQmcNlsXXiIFta7adA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtA1S0Y1D9cRjeoAuu3atnkdOiyh3DSbeSXixcICYh0=;
 b=B2Sf7hBoRCv83F1xzyf0Ygw51omKpeEcOOWeqdOUF0gUnkZw3ED62Hw1qQ9As3eo6Jafs3MRjmdgPoVcsPkyTeqmcs2oWiBJwszlyJVyQ/bfPRqGZuQUuRDZ4pOhXNeCf/yvHiEQ6Z4SxsUYz5SC8ilChFN8qMk0vPn5+ZP69JaWOGiR7Ym9+p6DC6c+UHd8DYMAbF07ZGSYKeEHGlzqgSuneAUhOOTWg+5vUQQDFA7aQM3/1OQuY6YTOCMcvkwDYS61YvDIhsR8rgFleShXCGA/xdvq1/PMw+r/cl8OM1XL6jMcW4MoIDmS3OPoNZK2DlDfkrdRcAZ4Jxwqv3KUCg==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by PH7PR12MB7915.namprd12.prod.outlook.com (2603:10b6:510:27c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Sun, 25 Oct
 2026 05:49:10 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 05:49:10 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v2 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Date: Sun, 25 Oct 2026 00:48:06 -0500
Message-ID:
 <SN1PR12MB25285E05ADA7EBA8B7010292A5622@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB2528DD1E6067CC4C0B76746FA5622@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB2528DD1E6067CC4C0B76746FA5622@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:610:53::20) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261025054850.33748-4-chernyakin.victor.j@outlook.com>
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
X-MS-Office365-Filtering-Correlation-Id: cb25cd49-b12e-4119-e4e5-08df325bafd7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|51005399006|24021099003|24121999003|22091999003|23021999003|41001999006|25010399006|19110799012|12121999013|8060799015|260925184616899003|440099028|3412199025|10035399007|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZLPqRQgL9ql/Zb11wBTEZOq8KpPKduNPLKnTm4pCDRThJH4RODga7eH8eQXu?=
 =?us-ascii?Q?qzdF6lVsHUIr7VJCX1foKtNCD5KAvcvRAw0mTIjNVlT2JI6XDgm5wDoAbIBH?=
 =?us-ascii?Q?LgVJ1+irtIsn2wU+1mA4EfEpBqqEAnohzsnrp6jK9vkYXXnDkhq3sHjajQ4m?=
 =?us-ascii?Q?HT7x7lBEYshcUbsw5WlXT29LVpMic0Qfxm6g/NwPU+4tBTQvYse2KP/7mUwm?=
 =?us-ascii?Q?G3iAvdVA+p9PLXv2adGJ4Mha8ZuF4AHU6fnVgsYVkp/Bu3zQm6ESdvvI9TFj?=
 =?us-ascii?Q?QAUcT0JgMQya0ZZ/B3+YYPGOphmNq4N5PqLh9tjkl3Plq4cvHX6fZBdpfgoX?=
 =?us-ascii?Q?ZkEVWRYlSSzYz2P4ZoIYWLUkfjwlHOtxd6UQLmQ92PqoXpVCYdycMg+C5PMr?=
 =?us-ascii?Q?y6uUSRqGQiaQxvpidR+u2HwUsFeaLI6xC1iKtlMAQjyKLajrOAnZlOQdQrm2?=
 =?us-ascii?Q?O5lVJl1LdVwMdcrzsWy6XQ+7ik0GKSOc26VVdRobzx8bXqV99XM0w2c3Wo+c?=
 =?us-ascii?Q?zWVUMX4VG/TeOxGZBsmjxAkDf53MhTLekjZVgNrpTEv7psnkWWgvJVuy0xD1?=
 =?us-ascii?Q?8U3qPTJwvGcdLy5tROOo5veH1PuowT8j610zNmzGXc2mzUX4ow1ksVGv40vl?=
 =?us-ascii?Q?Jtvva5zMGbLMBqC9mHIqYduORw3rKMrErIZLUSUezXiBnvlhWnrGFqFwHq/Z?=
 =?us-ascii?Q?Yxft58BvGn4MZCx3PlsYpUSoxUrOmg+3K1DjzkpganHUo1jqrzuoHzAOXzH5?=
 =?us-ascii?Q?YW0dGGQ9DrQzQiaCGxVNvg1CB+f7iKz0gkTeYX8Eir9UoKtnvlCQmSlJnVnZ?=
 =?us-ascii?Q?KkWQ9uG1wGvXVbgAWVWeLEmrdRCwuFBGZGztFFDHPU4GiKC9fEx//8TzS3bK?=
 =?us-ascii?Q?Zz4JqNOSDG74RXxuYf1VNhwPhtmpWIPTOYSG6B4EmZ0UvCw66iNO8g7Q9AfY?=
 =?us-ascii?Q?drcyL9ZWijJ1jbwprIxlGeX+7w3wimxHg7VPuZUatf0AwoFTyl3SDiGuTb0F?=
 =?us-ascii?Q?wT/Tb0owo842Vs23wsE/kGpNZ/i5OMkCe0AszH0m6Zscwic3xuaw46uPYvaL?=
 =?us-ascii?Q?LJH+EX+l9QpJVJTlLod76g2E8M0/xVOHsZu5+tGCJH4QMgMlB41qpvfkp/gi?=
 =?us-ascii?Q?UiRMEw8yvI3V?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7V7CGzCI+/nXmPf04LDAwXI1c/ioqOwFwt5kCiciV8OjNd/oRtD6HhF+7jdS?=
 =?us-ascii?Q?3MfNrWbD5rEwB32exttMD9gWyLT2juCeonJeUxDZ5civccL0WAzlqaF1W3I/?=
 =?us-ascii?Q?Srpb3ahze4nuvboM6GZMk9f9YV3YMClAmAhEngkLf1UYzjOp56z3GGD434wz?=
 =?us-ascii?Q?pnPfq7Jg6vsuOyclKEr1SsmS3xJ8rW2RIfuKrL9hzPVLMoDo/wqe7lCwiR9W?=
 =?us-ascii?Q?EGqknJvEKKW2hzQa3yBWYVBo2CbVq8xqtqqPLqCrCNwoqkm1oxP2+PXztfzU?=
 =?us-ascii?Q?blDMpP/6ezzyvHeFjvY2lNR8Vns1QCTrBhQrVskKP0nxmVY+xXh3vP1aXcUz?=
 =?us-ascii?Q?xbVvZ3qOXnoguk3KPKNunCiDodUdawTbRjTKEtk0bGu6oyESxqIVNwTqdVEB?=
 =?us-ascii?Q?WmIBXrkunwv3OhU/eOr+QMktS69PclSaeDB2UZ0V1GTDzUNhAdS4lbh2u1xL?=
 =?us-ascii?Q?58FU3BiyclKq8PhDaSFwsxVPq/H41k6NzHEfuj5Rm3MJTeoYQru6t958saBH?=
 =?us-ascii?Q?7gH5uoFkumnl2yGFn4/dUcLKG43SEioaStAorIQFXsuKkuUOpDy/KAl28bFU?=
 =?us-ascii?Q?iRzYHvmt9wL/68uMIZx8YZeCUyWAoujVoGFvVRclLOtLcHiAFOTXIvs4J05c?=
 =?us-ascii?Q?prG0lSG/BqPMXiJgbahqo0XgNbBNe3y8cw3fNyN9GLVHwjNVbONSs1AHKSeA?=
 =?us-ascii?Q?XxEDMvX3kzbw8xEgbjNhSWAXCTVDUgGgXxubdDQIaoQxpBKp9Lm43a13CV86?=
 =?us-ascii?Q?1PAMv5AzCAGeaJfYv4/pp74KsHZGHWg6BYNj8KynIkvOGYKXsTtwddC+Xj2M?=
 =?us-ascii?Q?kue49b/vUCM8BZRWfFPDHNkjp0fApBb1a0Vvl7IKiikfJeqfY2k+gR5rr6Iv?=
 =?us-ascii?Q?h/bGJVLowxHP8SUKzNZVQoHPvtN8xAL/w0CXZrS++nyPSJ2XNQXkHRlpiM8N?=
 =?us-ascii?Q?JNFW/7PnN26+SHUnjAvktbpykHRbZWtg+re41gxUywhY4KKBV63Eq3pCSc7K?=
 =?us-ascii?Q?RcD+sOODoynBGSg4eKvlJCzcTeycKqtcqBMBMZ8IuBf8aBvNJETU2Pnh72Lh?=
 =?us-ascii?Q?3tI9Bbtzug2FP+gl9T4qmn03sjOddh468LCu0VuxcUd1Fm10gFdCXVXI/jXg?=
 =?us-ascii?Q?P4rBeJRpJzewLQnTX5wkO8OGlvG1wxsVNNN64vCJYxKcPwLuIBAQcBbZ6yeh?=
 =?us-ascii?Q?mTeyuZyoqQwCAITW+2a5DhEKlmSdESKnDu4tILkit2bpmiKY+pbmiSNFik4a?=
 =?us-ascii?Q?/qTHqWYPqpxU7V8kwyj368rS+zxbNYOqh7T9Vi/zjOLCRVT7nSW2C6VsvhHz?=
 =?us-ascii?Q?CmlBP08aSrgMn1DU8dbr3cGQNAOx2WMsY+iEoJLZ5O92NZkII20nAc67H/Xp?=
 =?us-ascii?Q?41PgCyNDv8mNPf2Bj3vk5Nl8mfXe/0NEOiyErWoedGLxpzvbNw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb25cd49-b12e-4119-e4e5-08df325bafd7
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 05:49:08.6085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915

The FDC1004 is a high-precision 4-channel capacitive sensor that talks
over I2C. It can report the values of each of its 4 channels individually,
as well as the difference between any two of them.

This initial driver allows performing single reads and configuring
the sensor's various settings (sample frequency, calibration
gain/offset, etc.). It could be extended with support for triggered
buffers, repeated measurement mode, and/or power management.

Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/cdc/Kconfig   |  10 +
 drivers/iio/cdc/Makefile  |   1 +
 drivers/iio/cdc/fdc1004.c | 486 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 498 insertions(+)
 create mode 100644 drivers/iio/cdc/fdc1004.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 69c23ae21016..4d926c47ad8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27392,6 +27392,7 @@ TI FDC1004 DRIVER
 M:	Victor Chernyakin <chernyakin.victor.j@outlook.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
+F:	drivers/iio/cdc/fdc1004.c
 
 TI FLASH MEDIA MEMORYSTICK/MMC DRIVERS
 M:	Alex Dubov <oakad@yahoo.com>
diff --git a/drivers/iio/cdc/Kconfig b/drivers/iio/cdc/Kconfig
index e0a5ce66a984..6b9ea2cd37bd 100644
--- a/drivers/iio/cdc/Kconfig
+++ b/drivers/iio/cdc/Kconfig
@@ -24,4 +24,14 @@ config AD7746
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7746.
 
+config FDC1004
+	tristate "Texas Instruments FDC1004 capacitive sensor driver"
+	depends on I2C
+	help
+	  Say yes here to build support for the Texas Instruments FDC1004
+	  capacitive sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called fdc1004.
+
 endmenu
diff --git a/drivers/iio/cdc/Makefile b/drivers/iio/cdc/Makefile
index 41db756d8020..88253f33c5a7 100644
--- a/drivers/iio/cdc/Makefile
+++ b/drivers/iio/cdc/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_AD7150) += ad7150.o
 obj-$(CONFIG_AD7746) += ad7746.o
+obj-$(CONFIG_FDC1004) += fdc1004.o
diff --git a/drivers/iio/cdc/fdc1004.c b/drivers/iio/cdc/fdc1004.c
new file mode 100644
index 000000000000..319a754ca1ce
--- /dev/null
+++ b/drivers/iio/cdc/fdc1004.c
@@ -0,0 +1,486 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Texas Instruments FDC1004 capacitive sensor driver
+ *
+ * Copyright (c) 2026 Victor Chernyakin <chernyakin.victor.j@outlook.com>
+ *
+ * Datasheet: https://www.ti.com/lit/gpn/FDC1004
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+
+#define FDC1004_REG_MEASn_MSB(n)	(2 * (n))
+#define FDC1004_REG_MEASn_LSB(n)	(2 * (n) + 1)
+#define FDC1004_REG_CONF_MEASn(n)	(0x08 + (n))
+#define FDC1004_REG_FDC_CONF		0x0C
+#define FDC1004_REG_OFFSET_CAL_CINn(n)	(0x0D + (n))
+#define FDC1004_REG_GAIN_CAL_CINn(n)	(0x11 + (n))
+
+#define FDC1004_CONF_MEAS_CHA_MASK	GENMASK(15, 13)
+#define FDC1004_CONF_MEAS_CHB_MASK	GENMASK(12, 10)
+#define FDC1004_CONF_MEAS_CHB_CAPDAC	0b100
+#define FDC1004_CONF_MEAS_CAPDAC_MASK	GENMASK(9, 5)
+
+#define FDC1004_FDC_CONF_DONE_n_MASK(n)	BIT(3 - (n))
+#define FDC1004_FDC_CONF_MEAS_n_MASK(n)	BIT(7 - (n))
+#define FDC1004_FDC_CONF_RATE_MASK	GENMASK(11, 10)
+#define FDC1004_FDC_CONF_RST_MASK	BIT(15)
+
+static const int fdc1004_samp_freqs[] = { 100, 200, 400 };
+
+/*
+ * MEASn_{MSB,LSB}: 24 bits, signed. Format: IIO_VAL_DECIMAL64_YOCTO.
+ * 1 step = 1/(2^19) pF = 1/(1000 * 2^19) nF = 0.000000001907348632812500 nF.
+ */
+static const s64 fdc1004_scale = 1907348632812500;
+
+/*
+ * CAPDAC field: 5 bits, unsigned. Format: IIO_VAL_INT.
+ * 1 step = 3.125 pF = 3.125 / 1/(2^19) raw value steps = 1638400 raw value steps.
+ */
+static const int fdc1004_offset[] = {
+	0x00 * 1638400, /* min */
+	0x01 * 1638400, /* step */
+	0x1F * 1638400, /* max */
+};
+
+/*
+ * OFFSET_CAL_CINn: 16 bits, signed. Format: IIO_VAL_DECIMAL64_FEMTO.
+ * 1 step = 1/(2^11) pF = 1/(1000 * 2^11) nF = 0.000000488281250 nF.
+ */
+static const s64 fdc1004_calibbias[] = {
+	-0x8000 * 488281250UL, /* min */
+	+0x0001 * 488281250UL, /* step */
+	+0x7FFF * 488281250UL, /* max */
+};
+
+/*
+ * GAIN_CAL_CINn: 16 bits, unsigned. Format: IIO_VAL_DECIMAL64_FEMTO.
+ * 1 step = 1/(2^14) pF/pF = 0.000061035156250 pF/pF.
+ */
+static const s64 fdc1004_calibscale[] = {
+	0x0000 * 61035156250UL, /* min */
+	0x0001 * 61035156250UL, /* step */
+	0xFFFF * 61035156250UL, /* max */
+};
+
+static const struct regmap_range fdc1004_readable_reg_ranges[] = {
+	regmap_reg_range(FDC1004_REG_MEASn_MSB(0), FDC1004_REG_GAIN_CAL_CINn(3)),
+};
+
+static const struct regmap_access_table fdc1004_readable_reg_table = {
+	.yes_ranges = fdc1004_readable_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(fdc1004_readable_reg_ranges),
+};
+
+static const struct regmap_range fdc1004_writeable_reg_ranges[] = {
+	regmap_reg_range(FDC1004_REG_CONF_MEASn(0), FDC1004_REG_GAIN_CAL_CINn(3)),
+};
+
+static const struct regmap_access_table fdc1004_writeable_reg_table = {
+	.yes_ranges = fdc1004_writeable_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(fdc1004_writeable_reg_ranges),
+};
+
+static const struct regmap_range fdc1004_volatile_reg_ranges[] = {
+	regmap_reg_range(FDC1004_REG_MEASn_MSB(0), FDC1004_REG_MEASn_LSB(3)),
+	regmap_reg_range(FDC1004_REG_FDC_CONF, FDC1004_REG_FDC_CONF),
+};
+
+static const struct regmap_access_table fdc1004_volatile_reg_table = {
+	.yes_ranges = fdc1004_volatile_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(fdc1004_volatile_reg_ranges),
+};
+
+static const struct regmap_config fdc1004_regmap_config = {
+	.name = "fdc1004",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.max_register = FDC1004_REG_GAIN_CAL_CINn(3),
+	.rd_table = &fdc1004_readable_reg_table,
+	.wr_table = &fdc1004_writeable_reg_table,
+	.volatile_table = &fdc1004_volatile_reg_table,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+struct fdc1004_data {
+	struct regmap *regmap;
+
+	/*
+	 * Serializes accesses to the chip's measurement and config
+	 * registers, and to the other struct members below.
+	 */
+	struct mutex lock;
+
+	u8 offsets[4];
+	u8 samp_freq_index;
+};
+
+static int fdc1004_soft_reset(struct fdc1004_data *data)
+{
+	int ret;
+	unsigned int val;
+
+	ret = regmap_write(data->regmap, FDC1004_REG_FDC_CONF,
+			   FDC1004_FDC_CONF_RST_MASK);
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(data->regmap, FDC1004_REG_FDC_CONF, val,
+					!(ret & FDC1004_FDC_CONF_RST_MASK),
+					1 * USEC_PER_MSEC, 200 * USEC_PER_MSEC);
+}
+
+static int fdc1004_read_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan,
+			    int *val, int *val2, long mask)
+{
+	struct fdc1004_data *data = iio_priv(indio_dev);
+	unsigned int reg_val;
+	u16 reg_vals[2];
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		iio_val_s64_decompose(fdc1004_scale, val, val2);
+		return IIO_VAL_DECIMAL64_YOCTO;
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&data->lock);
+
+		/* Configure the measurement we want. */
+		reg_val = FIELD_PREP(FDC1004_CONF_MEAS_CHA_MASK, chan->channel);
+		reg_val |= FIELD_PREP(FDC1004_CONF_MEAS_CHB_MASK, chan->channel2);
+		reg_val |= FIELD_PREP(FDC1004_CONF_MEAS_CAPDAC_MASK,
+				      data->offsets[chan->channel]);
+		ret = regmap_write(data->regmap, FDC1004_REG_CONF_MEASn(0), reg_val);
+		if (ret)
+			return ret;
+
+		/* Start the measurement. */
+		reg_val = FDC1004_FDC_CONF_MEAS_n_MASK(0);
+		/* "+ 1" because the chip wants a 1-indexed value. */
+		reg_val |= FIELD_PREP(FDC1004_FDC_CONF_RATE_MASK,
+				      data->samp_freq_index + 1);
+		ret = regmap_write(data->regmap, FDC1004_REG_FDC_CONF, reg_val);
+		if (ret)
+			return ret;
+
+		/*
+		 * Wait for the measurement to complete.
+		 * The slowest sampling frequency the chip supports is 100 SPS,
+		 * i.e. 1 sample every 10 ms, so our timeout can't be shorter than
+		 * that. Go with 40 ms to be safe.
+		 */
+		ret = regmap_read_poll_timeout(
+			data->regmap, FDC1004_REG_FDC_CONF, reg_val,
+			reg_val & FDC1004_FDC_CONF_DONE_n_MASK(0),
+			1 * USEC_PER_MSEC, 40 * USEC_PER_MSEC);
+		if (ret)
+			return ret;
+
+		/* The datasheet says to read MSB first, LSB second. */
+		ret = regmap_bulk_read(data->regmap, FDC1004_REG_MEASn_MSB(0),
+				       reg_vals, ARRAY_SIZE(reg_vals));
+		if (ret)
+			return ret;
+
+		*val = (sign_extend32(reg_vals[0], 15) << 8) | (reg_vals[1] >> 8);
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&data->lock);
+
+		*val = fdc1004_samp_freqs[data->samp_freq_index];
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_OFFSET: {
+		guard(mutex)(&data->lock);
+
+		*val = data->offsets[chan->channel] * fdc1004_offset[1];
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = regmap_read(data->regmap,
+				  FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		iio_val_s64_decompose(sign_extend64(reg_val, 15) *
+				      fdc1004_calibbias[1], val, val2);
+		return IIO_VAL_DECIMAL64_FEMTO;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		ret = regmap_read(data->regmap,
+				  FDC1004_REG_GAIN_CAL_CINn(chan->channel),
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		iio_val_s64_decompose(reg_val * fdc1004_calibscale[1], val, val2);
+		return IIO_VAL_DECIMAL64_FEMTO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const int fdc1004_calibbias_decomposed[] = {
+	lower_32_bits(fdc1004_calibbias[0]), upper_32_bits(fdc1004_calibbias[0]),
+	lower_32_bits(fdc1004_calibbias[1]), upper_32_bits(fdc1004_calibbias[1]),
+	lower_32_bits(fdc1004_calibbias[2]), upper_32_bits(fdc1004_calibbias[2]),
+};
+
+static const int fdc1004_calibscale_decomposed[] = {
+	lower_32_bits(fdc1004_calibscale[0]), upper_32_bits(fdc1004_calibscale[0]),
+	lower_32_bits(fdc1004_calibscale[1]), upper_32_bits(fdc1004_calibscale[1]),
+	lower_32_bits(fdc1004_calibscale[2]), upper_32_bits(fdc1004_calibscale[2]),
+};
+
+static int fdc1004_read_avail(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      const int **vals, int *type, int *length,
+			      long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = fdc1004_samp_freqs;
+		*length = ARRAY_SIZE(fdc1004_samp_freqs);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OFFSET:
+		*vals = fdc1004_offset;
+		*length = ARRAY_SIZE(fdc1004_offset);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*vals = fdc1004_calibbias_decomposed;
+		*length = ARRAY_SIZE(fdc1004_calibbias_decomposed);
+		*type = IIO_VAL_DECIMAL64_FEMTO;
+		return IIO_AVAIL_RANGE;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		*vals = fdc1004_calibscale_decomposed;
+		*length = ARRAY_SIZE(fdc1004_calibscale_decomposed);
+		*type = IIO_VAL_DECIMAL64_FEMTO;
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int fdc1004_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+	case IIO_CHAN_INFO_OFFSET:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS:
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return IIO_VAL_DECIMAL64_FEMTO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int fdc1004_write_raw(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan,
+			     int val, int val2, long mask)
+{
+	struct fdc1004_data *data = iio_priv(indio_dev);
+	s64 val64;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (unsigned int i = 0; i < ARRAY_SIZE(fdc1004_samp_freqs); i++) {
+			if (fdc1004_samp_freqs[i] == val) {
+				guard(mutex)(&data->lock);
+
+				data->samp_freq_index = i;
+				return 0;
+			}
+		}
+
+		return -EINVAL;
+	case IIO_CHAN_INFO_OFFSET: {
+		if (val < fdc1004_offset[0] || val > fdc1004_offset[2] ||
+		    val % fdc1004_offset[1])
+			return -EINVAL;
+
+		guard(mutex)(&data->lock);
+
+		data->offsets[chan->channel] = val / fdc1004_offset[1];
+		return 0;
+	}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		val64 = iio_val_s64_compose(val, val2);
+		if (val64 < fdc1004_calibbias[0] || val64 > fdc1004_calibbias[2])
+			return -EINVAL;
+
+		return regmap_write(data->regmap,
+				    FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
+				    DIV_ROUND_CLOSEST(val64, fdc1004_calibbias[1]));
+	case IIO_CHAN_INFO_CALIBSCALE:
+		val64 = iio_val_s64_compose(val, val2);
+		if (val64 < fdc1004_calibscale[0] || val64 > fdc1004_calibscale[2])
+			return -EINVAL;
+
+		return regmap_write(data->regmap,
+				    FDC1004_REG_GAIN_CAL_CINn(chan->channel),
+				    DIV_ROUND_CLOSEST(val64, fdc1004_calibscale[1]));
+	default:
+		return -EINVAL;
+	}
+}
+
+static int fdc1004_debugfs_reg_access(struct iio_dev *indio_dev,
+				      unsigned int reg, unsigned int writeval,
+				      unsigned int *readval)
+{
+	struct fdc1004_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->lock);
+
+	if (readval)
+		return regmap_read(data->regmap, reg, readval);
+
+	return regmap_write(data->regmap, reg, writeval);
+}
+
+#define FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(_channel)               \
+	{                                                                \
+		.type = IIO_CAPACITANCE,                                 \
+		.indexed = true,                                         \
+		.channel = _channel,                                     \
+		.channel2 = FDC1004_CONF_MEAS_CHB_CAPDAC,                \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |           \
+				      BIT(IIO_CHAN_INFO_OFFSET) |        \
+				      BIT(IIO_CHAN_INFO_CALIBBIAS) |     \
+				      BIT(IIO_CHAN_INFO_CALIBSCALE),     \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),    \
+		.info_mask_shared_by_type_available =                    \
+			BIT(IIO_CHAN_INFO_OFFSET) |                      \
+			BIT(IIO_CHAN_INFO_CALIBBIAS) |                   \
+			BIT(IIO_CHAN_INFO_CALIBSCALE),                   \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.info_mask_shared_by_all_available =                     \
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),                    \
+	}
+
+#define FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(_chan1, _chan2)         \
+	{                                                                \
+		.type = IIO_CAPACITANCE,                                 \
+		.indexed = true,                                         \
+		.differential = true,                                    \
+		.channel = _chan1,                                       \
+		.channel2 = _chan2,                                      \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),            \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),    \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.info_mask_shared_by_all_available =                     \
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),                    \
+	}
+
+static const struct iio_chan_spec fdc1004_channels[] = {
+	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(0),
+	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(1),
+	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(2),
+	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(3),
+
+	/* The sensor only supports differential measurements where CHA < CHB. */
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(0, 1),
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(0, 2),
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(0, 3),
+
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(1, 2),
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(1, 3),
+
+	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(2, 3),
+};
+
+static const struct iio_info fdc1004_info = {
+	.read_raw = fdc1004_read_raw,
+	.read_avail = fdc1004_read_avail,
+	.write_raw = fdc1004_write_raw,
+	.write_raw_get_fmt = fdc1004_write_raw_get_fmt,
+	.debugfs_reg_access = fdc1004_debugfs_reg_access,
+};
+
+static int fdc1004_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct fdc1004_data *data;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return -EOPNOTSUPP;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+
+	data->regmap = devm_regmap_init_i2c(client, &fdc1004_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	ret = devm_mutex_init(&client->dev, &data->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_regulator_get_enable(&client->dev, "vdd");
+	if (ret)
+		return ret;
+
+	ret = fdc1004_soft_reset(data);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "fdc1004";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &fdc1004_info;
+	indio_dev->channels = fdc1004_channels;
+	indio_dev->num_channels = ARRAY_SIZE(fdc1004_channels);
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id fdc1004_id[] = {
+	{ .name = "fdc1004" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, fdc1004_id);
+
+static const struct of_device_id fdc1004_of_match[] = {
+	{ .compatible = "ti,fdc1004" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, fdc1004_of_match);
+
+static struct i2c_driver fdc1004_driver = {
+	.driver = {
+		.name = "fdc1004",
+		.of_match_table = fdc1004_of_match,
+	},
+	.probe = fdc1004_probe,
+	.id_table = fdc1004_id,
+};
+module_i2c_driver(fdc1004_driver);
+
+MODULE_AUTHOR("Victor Chernyakin <chernyakin.victor.j@outlook.com>");
+MODULE_DESCRIPTION("Texas Instruments FDC1004 capacitive sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

