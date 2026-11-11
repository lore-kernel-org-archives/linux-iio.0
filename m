Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794407055;
	b=BrlFqvLKumcEckPWBXxIl+1d7sS/sLmkUk1ko7LEr63XTz7+XWgoG2HdLzKfaEdSX2ca
	 +E+ctppYcJY91VIMcwF8iZMfuR79PyreA6yO8Yt/SoLsxEaR6AlXK+sWktGktzdVsb6rk
	 4WdIvMt/L4sCnm4HLdqrVm5HiHLrpy7F+DSexPDZ2eM+qdoPOZsDF7TGgbvkovw+vsfj3
	 4SezQZwjuds9RfePApT8k723ivnRx/8RgnaJ4ppZR674d7c9mKmuTtb72DT1QMzUN2yyz
	 lYybFn41Bonkk7m942bGLNdKJn2RsnDs3EeK4VRkzr9u04TkxgNMkT5Jv53iNuTRy3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407055;
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
	bh=9+g13yVdBqFPoYTqC5a9t76fIBF4W0ALDr3pAABsrvs=;
	b=W+NiwlCXPyCf5i3jyshiE0s5JnUjkc25oN9Q0luCSudIjeRv2+Evu1NrfbFJL2Vc2NiN
	 siWh3qUBkTG1k6NNcka0yk1lFAtzS7HSS6w8zk9jEOr3pPdda7bUlOv5GG3J/sM0mWYJ8
	 rcc/p9CSPy7J7mQVvOmcYH5gLImE8YJ/uPGsV2n9qNM0bk8izFcMLGuL5ff07+Blrq85T
	 l9NmCxZ9HmfxLADdPnaxhb2Q6MNbLJv0H5/6qPYamgqh9Ig4GlA70wqT1bJeWIV5jTNFO
	 f/5UaklApK72oJ6BDVoWqqO3LjFRHJbJV97uKF4bR3M7zIY8jlqdMODRLtnzgbBjjsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=sqxop0r4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.22
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012022.outbound.protection.outlook.com [52.103.11.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C893A606A8AB;
	Wed, 11 Nov 2026 14:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C893A606A8AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=sqxop0r4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqbO4RzGhzzlQPclF3RZe3uL5G0rQ6IJ2bwxAbVyCzoX6uyqSQFYns7F79FK3UDbDNRsxreWHXzj7y+2HzSj+LRENGWY9dh/p70topq2OIhGR+7jl5mLlxiZSblx8tkslcOoKkHCpKkmgHi3BHqib5RHOxYfqeroKR7/EFlv+ddFe6VU0faTke8ciBo7GiXa4kcTD/HcLdrm6npH0dJjXWVuhTDlhC9626wbSM/xQdkjxHLjG1ymB3epPcGKTQCBzv9Yvwm7eKzYq2yGwXEIVkkQFHiboxIW6AnRpyMwNR9EfByezd/WXRv8eJ7j7vZTp8TvW9WsCV2J1efM+ALWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+g13yVdBqFPoYTqC5a9t76fIBF4W0ALDr3pAABsrvs=;
 b=ujujz48AUKo4KTvqRMFm2iZWXfPU/rq7xCkVRQYsate/a2WWhbvxW1nJ8laHy6YWrktdIaY832lYxJWOQ4GO6EeGfnOmbBjXTd/uB18DrF21ycy836CoWI1oWnvaT4f7svmiQ9uVYlPCrZtN5ocd0OEeawRviIU7q1Sufy8fkOO8nwpf03ZmIeFrzT/iR0kZmAEhYMgplGAVrZpqQQIQAE72sp7J9kPZqMXbc/nWn/ABVxMS5EFU+tquf9u+HmfbYGpiK6bxz7bThuU/M5tLJI0cmUYgPDrf6OOKctcaOHANTKsbH5L5N6s01nMWVuIITZ0h5tJmNbYhRbBuXoKDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+g13yVdBqFPoYTqC5a9t76fIBF4W0ALDr3pAABsrvs=;
 b=sqxop0r4KtLbmIUtPbODRtu55f87x6zZdzkEWsKk8thQT2fQjtBfqCzAaCrRYHMl5I9z/SZqgjtHzCkhEyulaCWGzy8I7uMR9rbWRBYQBGRKnpPEhFgIbCcRWmDMpcURhlDV4/6tdAnv+d770AgajYBriPxKYXgAu1r6nGUAuESBPS0Fav0UYtEypEDgmsKpP9DKFgK7uXUEG1pW0YtRiySuY/IjSVedvczaxi4ZNBIDcS5+Fd10phJo+oYYa3oDcLF6xJAaBMJrsbO+28MjVIADm0p51ps4kxU7ksiSzVvHiuQm+XGW8O0N9/XcM2QrrRdRnZiMiU8W+bJEDxZK3w==
Received: from MW2PR12MB2523.namprd12.prod.outlook.com (2603:10b6:907:11::22)
 by CH1PPFDB1826343.namprd12.prod.outlook.com (2603:10b6:61f:fc00::628) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 14:24:11 +0000
Received: from MW2PR12MB2523.namprd12.prod.outlook.com
 ([fe80::336b:c57a:e118:4352]) by MW2PR12MB2523.namprd12.prod.outlook.com
 ([fe80::336b:c57a:e118:4352%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 14:24:11 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v9 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Wed, 11 Nov 2026 08:23:57 -0600
Message-ID:
 <MW2PR12MB252350089A82772DE15F0E3DA5712@MW2PR12MB2523.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <MW2PR12MB25231C3FE75A17CEDACDB279A5712@MW2PR12MB2523.namprd12.prod.outlook.com>
References: <MW2PR12MB25231C3FE75A17CEDACDB279A5712@MW2PR12MB2523.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:610:e5::18) To MW2PR12MB2523.namprd12.prod.outlook.com
 (2603:10b6:907:11::22)
X-Microsoft-Original-Message-ID:
 <20261111142358.22099-5-chernyakin.victor.j@outlook.com>
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
X-MS-Office365-Filtering-Correlation-Id: 95cd04bb-cecc-4a54-7225-08df3fff7460
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|4140399003|5072599009|22141099003|25010399006|12121999013|260925184616899003|2604032031799003|24121999003|24021099003|22091999003|23021999003|15080799012|39105399006|19110799012|41001999006|8060799015|10035399007|40105399003|440099028|3412199025|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/xD7sV5hCeiCo6Q7D4vPxKePAUMWYVc1lOfewitpgz0XkQTZdxqLYejOKdZ1?=
 =?us-ascii?Q?mBBwvXLDcAax5IfDeAztdxjG8OcoeuLxIrVVSQbk/v4+QAQdT1mHz2Uwm5zj?=
 =?us-ascii?Q?Fph9d4k8VFnsQscLHTGOTPcGRtDorQRkVcGQ5LBq+ERtNGPGmDKy6317FDTL?=
 =?us-ascii?Q?LibbjOpH0+TEX2ZkAEjMnNaGI2Ux9JehTCV9zAQW2nYFRe32bUFp4eZ9ysY3?=
 =?us-ascii?Q?Rp7oN1Oth5nshDI/YmNAeJvqf/zwOPwuGoG/XjGX3f9mMGRn05oRwWSTrwoI?=
 =?us-ascii?Q?4ojd3iEs9psQoAJ7VkM/JWyzHlUNzKiMMcxW+JwXp6Sgn79M7lnX/vRRpzqW?=
 =?us-ascii?Q?3acwKdn2DTJGTB86big6S1L+pLvrjMXCbZFhMAk+Jwj6oAWdeQRKPv3ACiDW?=
 =?us-ascii?Q?iodF0Dv4MIgK4cyUE1PVPAUq7WaQhWmh+hNo4M1D561CNuPJ+8zvIKC80JyP?=
 =?us-ascii?Q?CsiyWklfza8xuq/EaYEoLNKqKDCZYUeIjNioeRpPSxV6sMGeQVzgNV2xspHV?=
 =?us-ascii?Q?RtY8KrEJI9BvbU4wveQqGY/oEuYcBQN8kEtCG4h6vowH2qaEIhbW8DwcJ46l?=
 =?us-ascii?Q?91WBLqATl+rVJRaVglwn+fhtxox98ab6B7k4byXTQSomRD6T270OVInqw8Um?=
 =?us-ascii?Q?WBIN1spZNg0lQOx1hBuGF/n2tn9yGbFMrRfpF6/kDpriVxw9pJeRbOv8yIOm?=
 =?us-ascii?Q?3l/UUD5FkR2GCx+ixirboMX0JMzYKnuJIgbUosYEb147YKGH+B+FUrkiVETD?=
 =?us-ascii?Q?0sVaUm9FR7T+xIImdUP2tsxFbme6MdlkptomyTe8rfh5DX6RDk24g2DcEVvy?=
 =?us-ascii?Q?MG1MVP+DhpZ97tl9a8hiKN0Q7yW3FfTzN23AoZyzPxGSemsp4yCUkh6P9Ovc?=
 =?us-ascii?Q?0qztRnHYSVQXsWGyVEPd+XerXuf7MCF5NuHylx3ZJbv+fJ30cwmVTyQ6yfJ1?=
 =?us-ascii?Q?iQZ31XK3DHVPvfv9VAC0G2cmHZzejtO/0OApMM+qsxeixo5ndfQqxYTrLaML?=
 =?us-ascii?Q?0HDpdGEja+DCUc0p6a7Ickhj+vFfM43AU8XmCf4pVkaDl/OFGre2MtUYpdfJ?=
 =?us-ascii?Q?Rf7v3JKb2n2hhV5bybxb64tyK+AOAFu5BzEMcT7mojfCQ24ySqUoEPnCI+md?=
 =?us-ascii?Q?pOObunV1mQpR6PMRmCAiUjisSNE4eIrN6oFd8Bc1G1Ne8K+Od0e3P4pU8mp7?=
 =?us-ascii?Q?qIHLwEDaMTT+qPeBhsRaBMEYbo0NQA4GOCb7Y5gQZ+CiDRY3Wj1egU0pkEo?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xI0jEhR4QVnGtENE8kW8zIxWkhYXjSFij8qQ+HC47+CLyYKqpNcRWDXApRbN?=
 =?us-ascii?Q?9fA1/q9GoZj29ithy7jjpD8DN5k6VpNTGZrhYSLQkTfiglht4XElNQCLrCST?=
 =?us-ascii?Q?CntSshde70EX5wiGyyUVBMSq/h5jSr04m6XIiYDtIr8m6dVglNacSyJ8cToQ?=
 =?us-ascii?Q?BswrdwkhKVu7sHs9KUkGznmCgUhHEsuvZ0t99DBOMH+xo6+iPQO+052WJMfG?=
 =?us-ascii?Q?U8yvhMHDrmVVx7z7+hqF0TWLRSTCBE3zG1NLhHxDI1wRtNU5KjD6qgL/YBvV?=
 =?us-ascii?Q?o5mQmWcZloIJr09BOhLAdsGpOthPmZbwul2kO4BXRH1nv3pwvzn+1UChE0si?=
 =?us-ascii?Q?0FVgPI83CUEdN99obGkmh8VxjN3MeEKo3PdRmil0+1MxdeRiV0tYfe28tOlU?=
 =?us-ascii?Q?nlzvID2VROFfgpSdQYERJYEyqgq10nriWdLrT68U354sixO57R/INlc7K+P9?=
 =?us-ascii?Q?lGyxOE3KhXfBFj9OwHIAXoD2V13AOds20ksabn8HWA9EgPJ4iKM2r3xldt7Z?=
 =?us-ascii?Q?v0ZSQF1lEh6dq/SHh5GJxyYDCzXuVKQZyinp+Xx/4lcnnEYpSj4fIJSyc8yt?=
 =?us-ascii?Q?ZASroUedA19maVVuKyqccmP4w3AXjtfD28cMcszSxsazDnbqmXdq1/xnf9ui?=
 =?us-ascii?Q?Y1sXQnVze96qTIhji8ByV1h3wl0NsHLtjMbDL7VMfSYrW8/gtuOxsWn+aNh3?=
 =?us-ascii?Q?NdjWlzPURKL7bEFqYXvQ6TeZoYVMFecggvVzFJ8cowZz0n8DJOCy77P+cufB?=
 =?us-ascii?Q?ewKz0ObOZ4M5075Dsw6RrmhPHOiOqqgSPP2anyuc6wNchOl34+epl+M92Ec3?=
 =?us-ascii?Q?Y8bnwWt2QcKCiCpY0YeWfM2z0T54anDzbIyT0Jt3czrjnDs+hjPyldcXIeJL?=
 =?us-ascii?Q?jcHoiK7IwjjuBQyqb9rLs0oN2d20syJ5svdMAOYylvYzBSe7Y25YEbN/N1At?=
 =?us-ascii?Q?vDCB4IyJaJhDvgHhyZfnMB1bTN6xwR35slY682sXh4Bae7f3wtoxjmPVwm78?=
 =?us-ascii?Q?8iywqSmYwOYi5hgdTCexlHuoUvbHzzzdpsOivxn0ijlVSAjxs3IlE+qJ2Chx?=
 =?us-ascii?Q?/Ez0CKN9lMmcwGbW1lk5PXuQqmZCLnB4VQZ2tqMjQIX3vVZzI/gSMFtMeist?=
 =?us-ascii?Q?K85t1+Yg5oNWAdbvGM/X+eAkP9Z+WGPaDk+KnQGN3kDX60Fr4FP9W1uSe7LE?=
 =?us-ascii?Q?TUY9KStWjjeyRTpmsl4gV/CqgRuWteRI3TmByyXmjxp0lg9EUgb/Ji0IBpq2?=
 =?us-ascii?Q?PTc7fYvaATh5G2LegcYENy6mus4MpCRV7qpOLhlBGrREsz1f3m9G1HV2I5js?=
 =?us-ascii?Q?xb/fLJUVZcplF+MH6IhFbhSDfly5hmDMliSPN0p+z0W2ZC8I0VqUmi2qwgqm?=
 =?us-ascii?Q?l+BogF14qVkivVdqaM7BWxuOt4q7aEx9WcnH2XYk8emTR8QbWw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cd04bb-cecc-4a54-7225-08df3fff7460
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2523.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 14:24:11.4222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDB1826343

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
 drivers/iio/cdc/fdc1004.c | 494 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 507 insertions(+)
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
index 000000000000..292617b3a92e
--- /dev/null
+++ b/drivers/iio/cdc/fdc1004.c
@@ -0,0 +1,494 @@
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
+	/*
+	 * The sensor's pointer register doesn't autoincrement, so bulk reads
+	 * must be split up into individual reads.
+	 */
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
+		if (val < fdc1004_offset[0] || val > fdc1004_offset[2])
+			return -EINVAL;
+
+		guard(mutex)(&data->lock);
+
+		data->offsets[chan->channel] = DIV_ROUND_CLOSEST(val, fdc1004_offset[1]);
+		return 0;
+	}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		val64 = iio_val_s64_compose(val, val2);
+		if (val64 < fdc1004_calibbias[0] || val64 > fdc1004_calibbias[2])
+			return -EINVAL;
+
+		return regmap_write(map, FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
+				    DIV_S64_ROUND_CLOSEST(val64, fdc1004_calibbias[1]));
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

