Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793979726;
	b=EB4d8/XDNP+gq3FzjdoI3mYyrzSaa4VR7eDTzn2GKyJQam2GsNnaxNWJ4gfTZ64uNjqR
	 xlyrDc1PBYWt7iR2bohUf2rzXUkUCnq/L+1k3OWFh+CgQg0AMEP4KkEp7l2QAiHdABfvX
	 5CHiRuGqNsKmW8PQ0FOVfGxoZYsUaIQ3gkHxsqIt7riOijP0ucS0rmeMtJNGh1h4GOZC7
	 G18LeWu4Av3+p0fXIOyIZrACmE6linzxJ9R1qLwPPA34bay01luScToKXz0Hbpz9NxY4V
	 aDm3dVjD1uFgVu4hjP8sxUu1ulMZInRjAsc65c3XvG9c8sL9MYczgazXFVLiTUvk7Jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979726;
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
	bh=YZQCSJGjmjbYxTrX30oUSC5caxZx3maCkTyy1zelo+8=;
	b=kW8KIMWy7pc44ykQAW8USAt+QEmIWd/VPPeK/FiRN+gTzXi71hH8C3ldL1SeAcKhem+y
	 l5529JUreXc7iZWOlPMTYtFaMijYVtefioOwD21m0KrSQeZ50isCmEkGBuhDJ8FuX9eUz
	 RlqACRLeuXmHwmOWrW5GqAQwmv9isMHCOj4g5WH1l8Tcin3/uQYaxlsrMaSWrMtK8tbG7
	 VVGucmyaDe9L4lIcTgiyzG8dR0B7PxH5uq6mkXtd9mYd5Apvzfo5TlfTTwKoVz8vr1gak
	 oJLYtPK+PhieMrc4+Iw7b3e116ObRT+oDpIlAaEPS979SMGX94xcrkwhhIgOdcOrDxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=IR1Na9ap;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.20
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010020.outbound.protection.outlook.com [52.103.13.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A83606D802;
	Fri,  6 Nov 2026 15:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5A83606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=IR1Na9ap
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGHFHF80D+i86GoEgnwyJTS2lRIqK6kOSNTTQUYENB3I/QY5fQTyw1RysqpQOOOL6Pd+7dGEs3GBhSE41+z4SgMwN2Xn4IAF5PH5N5kIv9QeE1cZI9c1bcj7FraNTJGPAPrZ5xuXUrfQSGadTt4Sn0zpQee1PlK5ncoxLmm6Z/mQGpDKMvteT37YHtDtKopPd9vojTP9sXhXhB2pHxTlGnbAxwm5ZVeynzO53t7ddtozoipeXL3mcsbKGrvtinhwYfMAtD1x9qWRXoBucL/H4+qCnSGpfCy9Q0DB160krjJgZXSkTTS6bFUY2I3QnpcF6qqPeEqVZEtPq072E/pNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZQCSJGjmjbYxTrX30oUSC5caxZx3maCkTyy1zelo+8=;
 b=cwJyv7ww7TGUWyILCuqv4lnhM72aX0NGXNJ/d3wE42T43l1uxYur40Sa18ALt1RRIpQxBIndSue3oRhSY3Hju7d+Hc8nB7SOwbUtF1Ug8eN85rvMaU9ki03A0h+sEf1Hy/o3MMSXV56yWaAABSXHqX5lg19ubb4fynxVcmjN1HQ1S9R8L2oGZ2liryhd0LcYXWwbWWwGTa8T65k0n7MNV0SRtgmMkBZ//JaWP5N+lKwkPeYB3nVFI1RgsPCVHarniOoH0rBtTnEBgPtDtFj07qnQrh3m5ff/kN6mtD8uNAYPmwowbP2GfG/6HmSRC2BHhHPqMooXH/q9vkRuCE7uLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZQCSJGjmjbYxTrX30oUSC5caxZx3maCkTyy1zelo+8=;
 b=IR1Na9apoAC/SZWbrL/f/jZafgISAgksyhwWsN6ev2Zyv0+IcI974LAdKRMwtvjOmc5QTPk9fCiMQ2m/H0zz3tuR+y0ED42o/Bp46G7FDTFx/Kf2ZFYZOxRR7mKNaxrIAHP6ydVvdQk8uigi9w8QNvF77Ujj9jdLPMadAqlvpmC/1NIPY4K2AK48V2Lu2/wAHlMSPbBs0/W0chG7Q3QffOdbmWbeeJ+tTTcAJu0PsU8WlTMXNA9sgz4lrfYo4MsD+HQ38Sxu3cob9Mpx+J5NnpARsaaHUArZX7itOR7rgkTrIjmWiZidZiLtEAx+WcaHWuCEWxRe/sdpVWYKBTJGMw==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 15:41:51 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 15:41:51 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: [PATCH v5 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Fri,  6 Nov 2026 09:40:29 -0600
Message-ID:
 <SN1PR12MB2528BA7C696815089DCAD02FA5762@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB2528805DB17DD015E191111FA5762@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB2528805DB17DD015E191111FA5762@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:610:b0::16) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261106154136.804370-5-chernyakin.victor.j@outlook.com>
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
X-MS-Office365-Filtering-Correlation-Id: e7e06674-e659-4eb1-d654-08df3c1c792c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|24121999003|22091999003|41001999006|24021099003|15080799012|260925184616899003|8060799015|12121999013|19110799012|4140399003|25010399006|440099028|3412199025|10035399007|53005399003|40105399003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6z2NL8Tw5ygBfBcOcpiis2gNb7f6NF5NffNMgGBawmNArOBFGETxnIpLQVeb?=
 =?us-ascii?Q?pnrUe9TEanVpF5fDiDkOgOAYFLeQyTDcOvW4g8jWVCuL5Jispq0OhhHvzn0Y?=
 =?us-ascii?Q?M+DoVXHYmrTRmCfAXwhYrP+lDcJU9O8RD+rhOL3AJj/4x2B9uM6IPZ+/Azz8?=
 =?us-ascii?Q?DP4W7He2ls5uTqWZGSes6vO0kB24oixKZ6BVjqOlHptcsVxok4om/APJaUn1?=
 =?us-ascii?Q?afzN8aQtoyrkMpQ2WaxiHvd+ylyG7Pf7QKSZtRSXFcCoyBdemq31BL5v5NIf?=
 =?us-ascii?Q?zsdvllzRCZWNlR8VKLndPP6vuv9BtQefB6TXyazI8oHzZFqp59yKa/c95gE1?=
 =?us-ascii?Q?rY9cnhMyQL4Wj0B52IciE6fd03hIXgGHD3+q4cTPke7fQfgRvCeI6pSawB1m?=
 =?us-ascii?Q?b+o4FqDHrV1PlEDdF9yFz6izP9QSnzLuV/CUseXxid/tS0XUFdIj39P7rUyI?=
 =?us-ascii?Q?uOkCPMqkS8WnQvUXMjgYxeM9vM5uH/l/0mqVG3N9jhUfIbxGqzSn/Nh9izf5?=
 =?us-ascii?Q?OWbsoya/UBgn0tv7rn5B7iTV0qGRXNcxFWXW/6hkS4oSGM5c+h1zRTa8r67r?=
 =?us-ascii?Q?IgRXrDOC8PdxwMqaoF9K4LrEQXBhw0ydC68RqYVnRenQolaxz9WicrxYrb7a?=
 =?us-ascii?Q?nwUYln23ujGDdNZPvJYtdS+7Xpu/J9yvwn1Q1Nl0f7e/dUnDUBKIxT+11uBa?=
 =?us-ascii?Q?auRbRhrA6qcu4kOtjry7OasBR+w2cA+LD9l4DAS+HsKqOiXlN/mGrkLXivdC?=
 =?us-ascii?Q?RGsoPiTKWT+7f88xK77mOVDvCkNCMzHqR874B/eY2GyiUKFZaOkJ3ZuuPipN?=
 =?us-ascii?Q?RUAUFBFFEyJaiyANEhvDNl7/a2eH4of4c82bwPNpjtaamGogsrhRVi/HTbLF?=
 =?us-ascii?Q?SffS5iRe9mOWYUAI0KO0/1LWZ2Yg3Eiw56OhetdFjQ+g7RuTkfy+Os6XPJ5r?=
 =?us-ascii?Q?Od/TrTjI/ykuG5c8Qa48SeYlz4WcHe3UgxX+QyOhOdQ0M2TYkd7Sw71xyjum?=
 =?us-ascii?Q?CL+HJ2LMKBHQ3Xxn2RHZx7RmtmwgJ4tVDzYa5R+/7UjTu0JQ0GRqTMzzWIHf?=
 =?us-ascii?Q?jtqCtMxWQv5BRm6OgG+OOk4vvbSsDI+4e653XKUHOEzmg4BBzGJJ5cMHhGtN?=
 =?us-ascii?Q?FAEI0ofbs17lMzESuAHnMmQa3pgKC8AucKDbfF2AJ21ScMCzWFIYjGg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RBOMUFACdhGCa8Ut+ePGuj4Jx9DmbL2UbcbDbuY85skZdnenvInF9kgaITd5?=
 =?us-ascii?Q?2q0/EGhc2tMa6pMGVh0iLSpUNRphh54XY1riIw8hMqW8SLaW08k7qoEmcRVu?=
 =?us-ascii?Q?+KwrG99POkpNmzZfbBKavmOBD0E5KBmRWgNXlmSXaD8jnx60BE1BYx1ej5Ng?=
 =?us-ascii?Q?Oid+1cQANXKiFbvULdlUiH3fSDWR0XYAoPqrGpnEJIS8App0UaUdsbo/kQOa?=
 =?us-ascii?Q?QZ0EW0YFFOgLU9OKlAGPSNAxKfotWyVjaybFha8bCllVY4+hWWf0uY1SMasC?=
 =?us-ascii?Q?atfLxxPaeDzv1cl1i44QssZRYlTEdWf7oU1HczfdswYbbhAAeRaj+zQtwDJ7?=
 =?us-ascii?Q?oBOcNIPGxoJZHSCpGLyQFx6dTN6mHzX51uV1GLd4FBKxoTaNaKhT13ba5ARO?=
 =?us-ascii?Q?EcrvWYaVCL6chSA5/YqbuTgd8+1ejx2ADxjhkofFGEd1imlfL9IlfpPNQ6vm?=
 =?us-ascii?Q?lJMfmvTba5OdqLIHnfQulpBCowwSBqG7RpJAtzdtq1+xyPLssXD+gYAISxkb?=
 =?us-ascii?Q?qDSoTd8Gx6ClZuNsAwBZw645PtpZ5E2Xju9vlROOc9MgCpfpqtj7YaZCh6Vn?=
 =?us-ascii?Q?VLLPMPVA59UsYtZFIFWYSCGv1PQI8OK0GgHIRGM6ueH9UbChMFmnYbhzvtup?=
 =?us-ascii?Q?aDRDL6EJYrzU/MdT1Gv/9D1MHqhMJ/sfx6osQw/BtZ0hQehBhNw/GRRgNNXF?=
 =?us-ascii?Q?D7k+Z9cYbz/sTlVQwAyizr5PZUGqpww0Y+GQKjfL5jX9PBN4Gi6tRN4rmUe/?=
 =?us-ascii?Q?vixYQYmSHx5fAByCjK+cQWkNMqS069fUEpw+zBiR+Rh9YPHM36CgcjvVeDoi?=
 =?us-ascii?Q?69XsSDwZksn3yjjOENn5Jd7phnm7exleO69xJGfFtvN2Aj8dq69ceh4Iqck2?=
 =?us-ascii?Q?UOY7HEKNW+KB81CPlgnZgAceTenUkiVZq2lb/geqGNOo5Uw8kAUHQiVrWqrb?=
 =?us-ascii?Q?T/dvS80wXZGYUCOHAeYkWEv7mLSUmtssmE3BDOvvY38tfVrf7F10a/i489Hf?=
 =?us-ascii?Q?Ih+j3gaygc2Dp8byJZ4oK26hqpf5uH4z+ZL3jC3smFklmtR04dbVjpl1T8UC?=
 =?us-ascii?Q?iyMWaEfnVBrHkFoOC1shCrSNHZQtZGXlqGapQbDgdgOiHxUFitGFU5aX6B9+?=
 =?us-ascii?Q?LQKqdPOon0szW6xXrsJ5znHK3JyRNpCDsHSsLsq54x2Rj/xLYQ1CUdfbnA+F?=
 =?us-ascii?Q?09I0l5nBURqL6jCDGpEStidAlCOMp2dZ2gAmHJQd45caGrX1y2ccj3/XU/NF?=
 =?us-ascii?Q?wTPZGpKav8GHOR6UptFqKiVra4erGMuDdQM6NAW27CL9LT2xP3him9KZpgWD?=
 =?us-ascii?Q?BxKhs3mULKwUP/0I0mZGFJd0XJyKdY+D8N/b4h+h54dcegWVvd+PBJHsyHwe?=
 =?us-ascii?Q?by8gJBGtijOgWWFXG4ijDQ4y99dLjjZJVBtQ0x13wJz5gF/FFg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e06674-e659-4eb1-d654-08df3c1c792c
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 15:41:50.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329

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
 drivers/iio/cdc/fdc1004.c | 490 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 503 insertions(+)
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
index 000000000000..dabad30c26e0
--- /dev/null
+++ b/drivers/iio/cdc/fdc1004.c
@@ -0,0 +1,490 @@
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
+	-0x8000 * 488281250L, /* min */
+	+0x0001 * 488281250L, /* step */
+	+0x7FFF * 488281250L, /* max */
+};
+
+/*
+ * GAIN_CAL_CINn: 16 bits, unsigned. Format: IIO_VAL_DECIMAL64_FEMTO.
+ * 1 step = 1/(2^14) pF/pF = 0.000061035156250 pF/pF.
+ */
+static const s64 fdc1004_calibscale[] = {
+	0x0000 * 61035156250L, /* min */
+	0x0001 * 61035156250L, /* step */
+	0xFFFF * 61035156250L, /* max */
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
+	struct regmap *map = data->regmap;
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_write(map, FDC1004_REG_FDC_CONF, FDC1004_FDC_CONF_RST_MASK);
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(map, FDC1004_REG_FDC_CONF, reg_val,
+					!(ret & FDC1004_FDC_CONF_RST_MASK),
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

