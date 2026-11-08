Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.80
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794168534;
	b=yhl9wbSkvqGNBzHcuZLDRu2KIIJw/J4J2ErFbvAbZL3/A7EKfLm+AxbBgj4yCDpCKCF7
	 b6bX4NwVh4uDJMLeLeI06agC/DFqH7FUKHDJZJuyZLemM7SkuCsLZBbPJFx0ci8Uqw0uO
	 tCYWuwc11ZmTUtLQmXZ67Y/XnT2MVehdsECnfMfrY7lHZyxQRBmtdBGeK8iNNS8pnn6Aj
	 /ypn6QDcu3zzQT6+abjjDfhufOUMICUCiAfMA4gD6DEh2Qk5aiMQL7W59eUuDBzQBxjHK
	 g67zvMb6tohHhYmTFxt8rc1fDcZhvKEjBMrJvxejQ2EENhUr7g+SiXZ8oVLxUwDRtHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168534;
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
	bh=0+t7hBpVH/DsLUPzYPSPTSAp+Q7PXGAWhFPftHaP+GQ=;
	b=LUr48I3Sq1TeKPpMJLQWIye4ucsBsJS8MbtbtUx3V+Fv08dz230GNvmqJtGVfojASYnJ
	 UtyliGbBDvZe/+uLD0oCImrOqQkCozVk8v1IpD3G4/1/r14ShlLMuH4lYo1mYr+etrSYB
	 rExc2b3TD1N6fX+7TowFBGlQppqOkKSKJ+UUyZgey6zYUSnxT+u8PJrR4yLoB7ajpsJ/w
	 Mn0KsIhQ+O7ufQDNF+vbufxoPpZsohAMBPAQR0HHh/+/TFRFddUt3ybgq1XXA0lMdkwF6
	 i/Qwlaug7r/gQsRNnV27BykHW8OZ90+cfaB0nVT+cA4S9LwgmNfdPEaM9nEBXR1jlKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Tg15UTp9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.80
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013080.outbound.protection.outlook.com [52.103.14.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA72606A33A;
	Sun,  8 Nov 2026 20:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAA72606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Tg15UTp9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVTbM80CchnmkZWnFf2USIxTDBNPD8BY/vpvMVsN0vCbV4a02Fo9CQLWdZYLskycVwhcWlF1JXPYduts0QOFcb7eFK99zztXGFW1iH4qEHlRWvA4IsT2OjyJeFC1+SjznTZLAyG5NXwxmEmSt8/gKJZeTtERNJsK4A9ngauKly2gpqQAvp5C5Ot1vEGMJc2qgOcYYYp0hhgRmX7n6uUwrCMZ4z65q9ff3PPQAAZzO7Ir8g3DAiJmePzFtCHUrubu2EcBLXtGOH2QW22oZzKQPTW5Ln/zQcD7Jj4Ci58YlspONaRlayv0+xt0JsU+6i2LX/D0JAr5PIjTeInsLvKYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+t7hBpVH/DsLUPzYPSPTSAp+Q7PXGAWhFPftHaP+GQ=;
 b=KjIjvUsuOm/RkQnmkHP8NZlV3QjlF0Br1BBJHUcUjy0463eRx0Sh88h+NWhVX983OReDNHnfQ+sgdJfZAXEP2kWY4XRHknw8S2Bh16ubMh8v4kVx72YL8YKC+2OdGwwDDcdlBW0dFGOEtCdcYeyz4B3BCY3vk7vd05ViM/g95pXkFuPy/IxezkVnwfHSOrKMX5RNma/Nz6o03U/93Ja4Iuuq8hjjx3On6d2fAh3KIYwrUv2HnowPhoK1tStd+8D+TGPwJcy2in7iJ0DAPeWfY7iu9rYwqrVDhywI42uYDqOaigHQeKRPk+WtzH7TMDgaNdUpKHzhentDWI7z6lZJVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+t7hBpVH/DsLUPzYPSPTSAp+Q7PXGAWhFPftHaP+GQ=;
 b=Tg15UTp9w1PK1/q9QkpGno62UQMOM3uiN//jeoN007oj82eAOwjMcoZkIsmLTG0JNQvoj6saS4B11PDQtS8WIUONkMxLM0gJ/McgEC2ZW3OtnNZDh/8NlIxleHz74IaNBiDgNCYKfoJloWFC6zW56TB//a59scfrrnIakga1oEbTF5LhtDfRJNTMe/XjWSw5RaTl26Bf9gapXuSvmbv91Mg7NUpGahyqcLx63Sqp3sc4ONjAmbhRK3v68x5MgK9FBoU+O6NbcKfzJ897tHkgDpyXQXzKc4eUPCZ/X1l8tMh0I83HekwNFirxkex2MyTXGuZaZV0XStxbXf67nXgx4w==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 20:08:51 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Sun, 8 Nov 2026
 20:08:50 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v7 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Sun,  8 Nov 2026 14:08:29 -0600
Message-ID:
 <SN1PR12MB25282CCC3930ABE760956095A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB252841150D2280C7C1294A11A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB252841150D2280C7C1294A11A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:610:b3::29) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261108200835.981970-5-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|PH7PR12MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: fde5fc68-9f23-4252-b473-08df3dd4193a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|16051099003|12121999013|8060799015|19110799012|25010399006|4140399003|23021999003|260925184616899003|24121999003|22091999003|41001999006|15080799012|5072599009|10035399007|53005399003|40105399003|26121999007|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/bmwNjKHDedOWlQeNQmI/djo469em5GKqqFyiKNOsz2vUtlqfycLu8cQW0vy?=
 =?us-ascii?Q?WGgPWddBINgZ5l4dBHxNn4ex0mzE2nTXlEmrwSATyGTlCmDLxLiKz8nmTxa0?=
 =?us-ascii?Q?ybRbR2t3D+mrsLmV2QIcrJcIPpocL9Dp5lQtUEu2fz3hWwfhnoBmeOd4bEwo?=
 =?us-ascii?Q?y9V+H9Lafs27Btb8CUuNm55FSkCRkHQicOlH0/yLtJHltCMctvayuDD+xoaZ?=
 =?us-ascii?Q?JjQxWRggMOjmg0oHBw5r+u6RdmCf7E6vES9ha3DF62VKKwvLquIJmMHNg9em?=
 =?us-ascii?Q?uZVd3lrxB7himU3JcNhBlQeIVO0Fnjn3NX/Ikq8oWXSinydNQT8oCcAsixod?=
 =?us-ascii?Q?CkLTUPWsh1r2p96pK5hf1TfqZRJsCddCMbqk70Z14IGHlWOoMYvTHQ4GL2Ew?=
 =?us-ascii?Q?g+JzRKfQVrayfkyQsA5bUUXasuhDpTl+NTdC8IPfKURVHH3lxwCfGw+6r0o9?=
 =?us-ascii?Q?/m698/4XuPQetQu3bonqz8cNjSTehlycIGWsIzBty10S2vXxJfR3TUdSXGfc?=
 =?us-ascii?Q?M6pFHFQVNbDAdYXGEaQmdylSTcai7Xo0A7OAw5+tZ9VZPbi4AKhrGJHK5fY6?=
 =?us-ascii?Q?IyiVYWpQIo97Iy3MXVyhv8Pxbf56Z5ZVdsAQDrQn+zxdzWBxtre6Y/8J7NFe?=
 =?us-ascii?Q?rJ3wkS3VKioPs4INigC2d5f0UJNcVGUa68NTAnutkeiB98nESIs1QQvO33Nv?=
 =?us-ascii?Q?I1k2SeSDv//8Z8jexvoD4/hhpo7Yfwf0HFLvImMBKzw1hj3kWH3ZDBbJpo6H?=
 =?us-ascii?Q?Y5FdtPM7+JN8Jzs8V75jC7XVpq5uKI4Pl6laCCTR11DxEe4Xm0+nN1PHxvr4?=
 =?us-ascii?Q?RgXN9PJt4iiKQ9jZXfKr0B1KDAu5yMUXtom+2CPRuczWA/2XkkeYH/73Vjg0?=
 =?us-ascii?Q?gjZKvNIt1Qz/MqPuQVQwyiNuTDxzHlBvPbHnDdr7B6UJ3+WU/ncx9buTwyLi?=
 =?us-ascii?Q?fJ8BYG3TWAJiel4V3WZyO7bui6wpwgJ4TG1fjQLZVyBvU2WL5VS292MS+EZA?=
 =?us-ascii?Q?n8u0f5+PD2wmSvhPZJ/Cn94AG2/rgBi8Q+IwVrIXybhJdGqdx/fRvG32WgbA?=
 =?us-ascii?Q?2Hlw6/qpO4Tjt0gLj5ecESC0ZA9XO9aRiQVLs/aUxWtXf/Dn2uGHz5sH06FH?=
 =?us-ascii?Q?yAuHNOFzGYiOZ51k+H+A7jOwn66d9rVsbZtJrNKdxTUDHGlA+TAia+JSFYHc?=
 =?us-ascii?Q?hHEISEmV4YGIyPdT?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D59zSCx57cvpuYmBVod5J2tMCb+bQE9ZjX6R+BhOrt1CHeQw1Gm0l/DMdACi?=
 =?us-ascii?Q?U5nRb9Ec1uDa2enJMn33EwsMKwaKklyWNZDdb/yBvMcXfpvbXMJvGn+oQ20M?=
 =?us-ascii?Q?sRthkIyN/Wofn0GxZKfLdqA5CeQqjWp3mbtJLfbPZFua/VnIqB9+SJRHxTCJ?=
 =?us-ascii?Q?p+FnKVWM8ZWuhdq1ixWrGRSqwbXktNz/ldh0ZMuAFBkG+6aj8rOxPDg7i9jq?=
 =?us-ascii?Q?z5WNHPLpyj36qBPieM/StWartRFHKsRbV8Nr+e1+7v5T8M6DQKipkjIHQxtZ?=
 =?us-ascii?Q?C/mMk0ktm+w2Mi8Ie1Upec6LlTUuQkJeB07mC7mi4wZtfMN+JcxBHKMbx7oO?=
 =?us-ascii?Q?jJZlE/rE8CySRPFiIz8T7Wre3FPmufEDEFLPuz2vrIzewOvOHwnM3AFbpV3z?=
 =?us-ascii?Q?Fu51KXZ/zLl6QQFoEFDc8cFM4S8zCTy9TpinFyv1AphTSvCGjRXenBnIYHHF?=
 =?us-ascii?Q?BpyDEnavre0lzdex43+Bw5YqIZKXLmvLvWUskkw0Y8k6sc1pj7E78cKskSvG?=
 =?us-ascii?Q?y0GSTWbpnJadcexMkIEjPjo4/jE3WVprlwxvUTdXD2U5NUywwn1oaQPaFzlh?=
 =?us-ascii?Q?riJkmUql28GsXFtqs5Yt+YxXn7bzQdVtgu1u9T+OuD/MyBmIt6j+22fAp8NC?=
 =?us-ascii?Q?+e8uF2u59i8bX3flLICeCylElSVRfoM8Xw/JXJKBtT1epcqzbWad5beLo85T?=
 =?us-ascii?Q?XWgCoZpivpzhbdvURxFVOs7IkNrtyWT7dEZ2c6/ZVWmoqlUA00Ww7M7gV3RH?=
 =?us-ascii?Q?+WfR7uRV6GR93exgSGR1n+n1thJWscSNAiCUdDj5JaVF+C9OkvOmbxr4kCd7?=
 =?us-ascii?Q?KuFGfTAclxA/uW97vUP+X0AXZbrdo8KnM50VLTGwOJF6GnzEqxUmeg3Cpxbt?=
 =?us-ascii?Q?w+75kkALUj0TDGYrPNvo26BrF8EUJ4oEs6ac7NqJAv5gh3M+pF54HNnnkDS8?=
 =?us-ascii?Q?lIbQx67LJ0+8/EPcMJtOtUL5Z27nASEwgfqIvZcXNVOjn43UW+afbLVJNKSV?=
 =?us-ascii?Q?HdyAPX3FcAXSUiILuRvJU1IeJPOtWU45zVDbQ8MR0wD9YqIxJvT0xpsh+rag?=
 =?us-ascii?Q?9s/rs5o30UYwGg5J5XqGKBQXtxWWxSU4KmAnVo8+qnum+dx6oBo6uzkTJYM5?=
 =?us-ascii?Q?zSQWPZajoqF4N+pIRlEiBkzfXWaUigA9LshpzSLNLTChiFb9DqznSWPnE6vj?=
 =?us-ascii?Q?V0V/EbLQXqJIBOm1KDrwvYOF3IXSLTsgMhYrH6vm0qgXskWvGz/6qURc9+5f?=
 =?us-ascii?Q?csnKFytgqGz+1IrKCHjrBs4q2A5tQr5pgqrX/aTHR6wBHdeu+x5f1czO3GCo?=
 =?us-ascii?Q?UvVqKofcCLlabU6q4nZeZBpj7lLIuk3X+orXk4G6bdeCV25QeSHDNqvi9iSg?=
 =?us-ascii?Q?HCJHN9E3dhMrC0NVzAlWijuCi2iNyMdQ4xSKP/PSZd1fZz+Vag=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde5fc68-9f23-4252-b473-08df3dd4193a
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 20:08:47.7338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968

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
 drivers/iio/cdc/Kconfig   |  11 +
 drivers/iio/cdc/Makefile  |   1 +
 drivers/iio/cdc/fdc1004.c | 491 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 504 insertions(+)
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
index e0a5ce66a984..1e9015fb5ae6 100644
--- a/drivers/iio/cdc/Kconfig
+++ b/drivers/iio/cdc/Kconfig
@@ -24,4 +24,15 @@ config AD7746
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7746.
 
+config FDC1004
+	tristate "Texas Instruments FDC1004 capacitive sensor driver"
+	depends on I2C
+	select REGMAP_I2C
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
index 000000000000..57bce00bd500
--- /dev/null
+++ b/drivers/iio/cdc/fdc1004.c
@@ -0,0 +1,491 @@
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
+#include <linux/math64.h>
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
+ * Negative values are used to cancel out any parasitic capacitance
+ * of the sensor's external circuitry.
+ */
+static const s64 fdc1004_calibbias[] = {
+	-0x8000 * 488281250LL, /* min */
+	+0x0001 * 488281250LL, /* step */
+	+0x7FFF * 488281250LL, /* max */
+};
+
+/*
+ * GAIN_CAL_CINn: 16 bits, unsigned. Format: IIO_VAL_DECIMAL64_FEMTO.
+ * 1 step = 1/(2^14) pF/pF = 0.000061035156250 pF/pF.
+ */
+static const s64 fdc1004_calibscale[] = {
+	0x0000 * 61035156250LL, /* min */
+	0x0001 * 61035156250LL, /* step */
+	0xFFFF * 61035156250LL, /* max */
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
+	.use_single_read = true,
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
+	struct regmap *map = data->regmap;
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_write(map, FDC1004_REG_FDC_CONF, FDC1004_FDC_CONF_RST_MASK);
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(map, FDC1004_REG_FDC_CONF, reg_val,
+					!(reg_val & FDC1004_FDC_CONF_RST_MASK),
+					1 * USEC_PER_MSEC, 200 * USEC_PER_MSEC);
+}
+
+static int fdc1004_read_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan,
+			    int *val, int *val2, long mask)
+{
+	struct fdc1004_data *data = iio_priv(indio_dev);
+	struct regmap *map = data->regmap;
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
+		reg_val = FIELD_PREP(FDC1004_CONF_MEAS_CHA_MASK, chan->channel) |
+			  FIELD_PREP(FDC1004_CONF_MEAS_CHB_MASK, chan->channel2) |
+			  FIELD_PREP(FDC1004_CONF_MEAS_CAPDAC_MASK,
+				     data->offsets[chan->channel]);
+		ret = regmap_write(map, FDC1004_REG_CONF_MEASn(0), reg_val);
+		if (ret)
+			return ret;
+
+		/*
+		 * Start the measurement. The "+ 1" is because the chip
+		 * wants a 1-indexed sampling frequency.
+		 */
+		reg_val = FDC1004_FDC_CONF_MEAS_n_MASK(0) |
+			  FIELD_PREP(FDC1004_FDC_CONF_RATE_MASK,
+				     data->samp_freq_index + 1);
+		ret = regmap_write(map, FDC1004_REG_FDC_CONF, reg_val);
+		if (ret)
+			return ret;
+
+		/*
+		 * Wait for the measurement to complete.
+		 * The slowest sampling frequency the chip supports is 100 SPS,
+		 * i.e. 1 sample every 10 ms, so our timeout can't be shorter
+		 * than that. Go with 40 ms to be safe.
+		 */
+		ret = regmap_read_poll_timeout(map, FDC1004_REG_FDC_CONF, reg_val,
+					       reg_val & FDC1004_FDC_CONF_DONE_n_MASK(0),
+					       1 * USEC_PER_MSEC, 40 * USEC_PER_MSEC);
+		if (ret)
+			return ret;
+
+		/*
+		 * Now read the two registers making up the measurement.
+		 * The datasheet says to read MSB first, LSB second.
+		 */
+		ret = regmap_bulk_read(map, FDC1004_REG_MEASn_MSB(0),
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
+		ret = regmap_read(map, FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
+				  &reg_val);
+		if (ret)
+			return ret;
+
+		iio_val_s64_decompose(sign_extend64(reg_val, 15) *
+				      fdc1004_calibbias[1], val, val2);
+		return IIO_VAL_DECIMAL64_FEMTO;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		ret = regmap_read(map, FDC1004_REG_GAIN_CAL_CINn(chan->channel),
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
+	struct regmap *map = data->regmap;
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
+		return regmap_write(map, FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
+				    (u16)DIV_S64_ROUND_CLOSEST(val64, fdc1004_calibbias[1]));
+	case IIO_CHAN_INFO_CALIBSCALE:
+		val64 = iio_val_s64_compose(val, val2);
+		if (val64 < fdc1004_calibscale[0] || val64 > fdc1004_calibscale[2])
+			return -EINVAL;
+
+		return regmap_write(map, FDC1004_REG_GAIN_CAL_CINn(chan->channel),
+				    DIV64_U64_ROUND_CLOSEST(val64, fdc1004_calibscale[1]));
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
+#define FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(_channel)		 \
+	{								 \
+		.type = IIO_CAPACITANCE,				 \
+		.indexed = true,					 \
+		.channel = _channel,					 \
+		.channel2 = FDC1004_CONF_MEAS_CHB_CAPDAC,		 \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		 \
+				      BIT(IIO_CHAN_INFO_OFFSET) |	 \
+				      BIT(IIO_CHAN_INFO_CALIBBIAS) |	 \
+				      BIT(IIO_CHAN_INFO_CALIBSCALE),	 \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	 \
+		.info_mask_shared_by_type_available =			 \
+			BIT(IIO_CHAN_INFO_OFFSET) |			 \
+			BIT(IIO_CHAN_INFO_CALIBBIAS) |			 \
+			BIT(IIO_CHAN_INFO_CALIBSCALE),			 \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.info_mask_shared_by_all_available =			 \
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			 \
+	}
+
+#define FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(_chan1, _chan2)	 \
+	{								 \
+		.type = IIO_CAPACITANCE,				 \
+		.indexed = true,					 \
+		.differential = true,					 \
+		.channel = _chan1,					 \
+		.channel2 = _chan2,					 \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		 \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	 \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.info_mask_shared_by_all_available =			 \
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			 \
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

