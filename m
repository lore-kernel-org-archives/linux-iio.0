Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023080.outbound.protection.outlook.com [40.107.159.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1CF34EF05;
	Thu, 30 Apr 2026 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777522211; cv=fail; b=cT9qldYiHfnlhpQmtZLAQW4BWCbBV52mSEkHhOj7+hckBUtKFxBWQG/RFC6tcYVng8JIqlVz8PxdH69A/vGyjZVZzEQ/Tf8lEVK0MPf7PdTlW0n/1gyM9MH6KVK+KMQKQGYMu0tMiU4FOfRTd/NJTvUuN5GZjwW7lnC4fd8Uco0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777522211; c=relaxed/simple;
	bh=DsTFaquaP7+x3aJEvXSvBlbu4dcNzxtka19TDzQLj0M=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=Av54QrykRb8Y6ARRKw2H2UZyq5jSQRBmDzb56Bk5INCBsJDEYV4B278L7s/rcW7Lpm9HqU48Lr6+xXT1qxUWEYO1cTHytjrtBBOhykMhxK5KkmEuRNVZt6W51KEPcpP9Xn8vGJuWMF3YcGAcdp5Q4MOXx5nLuisnc9NcZqCt7FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=EpEmHwGi; arc=fail smtp.client-ip=40.107.159.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="EpEmHwGi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzForAEZGbIYgmR7RSzIzzWk1wtQLgQVE8ft3FEZYoEqmVkVaXBh2UEqzwf+Vu9gQd1vKL0BHyUQ0IjUNLic9Fvi8qRstMGHtCB9kLuw17YYroOwNFAYpZQKnqPZ6sQ7LuUNT6Qiw9Yqy72tGdXDtpp5UQlp5lxTwIvvIGielTYMbhsUje/HUM/V2gB20kyV65ukLTUXmeBOcQUe5ebE7Bt32EOHBc67GhWUgzh4JQx0S+4itKfdXj5BePuSNm+GudEdAB2osnxH9npe610e4Si0H1oCo6TfweRgGQAK6ZGDlsUjJD8DREtfA7+54TTlbY8ASiXUzsY+WORrV+Nriw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krMphM2NAxVYMF/9OniqCuGV4f5a7Pz6HMQ37ozz1aw=;
 b=aZFCae0Tn6VyKapietUoenoNrLWNNPm5kwUT9UhjWT1aPzPRlfJ1K9IoWrgJH3nuLE30I0GuAGQspg0osWMRF0IJ5Sb/jEV/BlZlPGx4RqUd8XDDGncAYDfQHOa3zwVxs4Yr+FAia27C2zGN1VVvmq/X5l01axNPvxu0akww05zPiUB72d95PlMwF2IWp9xc1Kx9qGfbGAhYJ1UDM6hoTwNbXIJk6IL9UqGN2Kt9Kua3rVk4X9h4kQuWUFMZzQ5PU3ruL3irHLsoxY9RetlNMSk1Y/jR1NaWSMtqHg90+U7qLtDpGSMaoLPZWKhgQzCK1qfAWPXo69JgfFkSTTmP8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krMphM2NAxVYMF/9OniqCuGV4f5a7Pz6HMQ37ozz1aw=;
 b=EpEmHwGi0O3bVCJCGmHsLThdJZs4iFiXTsHEqWN8vbYZZDgUadUH2VwZYgD0uht4Fo8rRCK5tLbhA0/Ns70StBDV//y0TbuOdOh3g/Bp72Xy9yb5OpLo0AnPPrS36iJqNsZ37UiplxRY2gfXaJCYbCbswU0Rz1rP1/zKJNOKChM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com (2603:10a6:20b:5c1::5)
 by GVXPR02MB10967.eurprd02.prod.outlook.com (2603:10a6:150:226::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 04:10:02 +0000
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714]) by AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 04:10:02 +0000
Message-ID: <7ddc5b09-b6c9-99f9-d951-6b3ef96f8c1f@axentia.se>
Date: Thu, 30 Apr 2026 06:09:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: sv-SE
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Peter Rosin <peda@lysator.liu.se>
From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] MAINTAINERS: Update mail for Peter Rosin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0097.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::11) To AS8PR02MB9235.eurprd02.prod.outlook.com
 (2603:10a6:20b:5c1::5)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9235:EE_|GVXPR02MB10967:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf83293-c382-461b-7096-08dea66e5a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	O0ty+WFvNRKX0aq95752uhQ8Zwyhvd7Z28cNxsfkNv7Vc9+HaD+mkzXK6Sl9U+EINiLfongxJ2pHIUKJbWLQ1fy4xlqlsQTOiiQDMbPiz6bQDQBLiUAjlGc/AEaD11D5H8bsWEgrly80DGuuFLISjJKdJipj3DbBhUD8Iw3E/aXvdtI0/u9ESqxiA465/8e+W46fdMWJfwNdueTd/MxlGUQ7bqPYlA3fsIHiBLKV3/zldCSWEqIKfgT1lFo43GXC144iFzIKNWaEnCtWZPaDf5pgbV7kRVLk0qdafVpHMVHKZfotxq8TnQjum4fCtPGtd9nwJybL+dwJ239DMuFMIy5oj8IkRovAa0902AadX5Kl3hyr6SIjkCuU5OPN3PFwKrv3zW5LDjEeleg8c9WGec4QUxO88vIFLpMc8vSLpjTauiFhyYNI0ADdQlWQrxPo40SJmUHMAHaN9A1RjR82IctEkDnzhiUnjyc+FDUFTw2ElG9baAJq//UphxDkJHIDXWpmQdbPcX9o0+5aWAA5uIrlwKedNtGxR0+ydztfmJ8DFQIe83M3ED0x9KtS+NuTQwmmfuqS0uvdhO7T4dpm9DcJz6l3f7aSGGR5OeK3aNTmt64z25iTlDp6gdgdpSWHvyvjXCcI0825GgBz87MxzYF5Oz36iskAz6FiOq0WU4Z1ZLOHTABYqyJtDVQc+Wc0Oiu3F96hz0TrPmW5BvIB8RVMHY08qcn0h2B9XqnIUTY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9235.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEtWME55VUcrNjhFUUFYQU5DRUxOMjBxYWlwdnE4elFmaFhCclVsWk9LaU5u?=
 =?utf-8?B?bEN0dElKdCtJcS80cTNIOHhYd0lCYmg3enI4VXJxa2p0bk55bTcvOUN0Z1g2?=
 =?utf-8?B?MjBjaUNVaHlTYWVNMEc3My9PMlJrTkp3WHpuNGwwT2EwZ1hDcWNJUHhGV1NV?=
 =?utf-8?B?cHNSMkR5QUJZM0llRkdzN1lOTHVVTE1qVS9LWFlkbG5EQllHUjFkTVJHTmF0?=
 =?utf-8?B?QVg0SmFXUE0vc2s3aFB1TlhRRTUwYlM0VWJ0NHlXc2YrdS9La01RdDF2R3JE?=
 =?utf-8?B?R0JmVnpaSVFJdnlSeVRiczV3SzFCa2ZUYkhJL0dMMDl0ZzkwbkNjT1BLL3JF?=
 =?utf-8?B?R09BYnhNRXRldHJ5cHpSTzA2aFlIWWQ2Z0FCcUFheERHK28wRlJMOE8rOWxW?=
 =?utf-8?B?LzNJcWlISUUzenZGWGRnM3ZzMGpWcVJVY0dBZHlON0g1VEFhUHpRd3ZhMDNE?=
 =?utf-8?B?dDI0UHNKRlZmQ2puVjR3Y21zaU11NnBEazhyUm5aeFUxZzJtL0drR1drZ1hN?=
 =?utf-8?B?U0ZNTytRZFVMUlVvcTJrQXFueC9hbVVUbUxVK3dTMlFqdGI5MFNnRTNLY0Y1?=
 =?utf-8?B?RFBUSG1zRFZ3bUQvcGIxWXVIZDdnV0V2UlpoSlFDYnJBWXJXN1J0RldDTGs0?=
 =?utf-8?B?SXkzY2ZPMHhGeGhkQklsVUR5VSsvZXBRbnBVaXpzUzltYlg2Q3RNQmx6WUpq?=
 =?utf-8?B?LzBNZnAyY1p1VHc0K01qUjZtcTJreTNlbmdmcXJ2VVpEL2pRSkxYVGZZUHpB?=
 =?utf-8?B?eTlpaDVxcFYzTWFObGlYdWN4alA1eXQ5TThsQkh6RnNFYjF6bmtqbTg1Nk9u?=
 =?utf-8?B?NlpRUll1MUpWaXVBdWJlUGJMK2wrTFVSTkMycXJENFNPc2o1dzdqVEE1cmR6?=
 =?utf-8?B?ZGp3QUtpR09wZ2lPMzhnUFZjRmtuVDduNGsxQ1hhNktMSUNJSnVBNU41YWkr?=
 =?utf-8?B?WUpCUXN5dWZ3OXdpQWdiay9tWVJ4M243UVIxTTdpVDdWK1hjTVd5dENGcS9O?=
 =?utf-8?B?M2xSUHg2TFgzWE5CUlFtQStCcmZISzlYeHhXL2dyRjlmaGl5cDVWelpiZnNE?=
 =?utf-8?B?eGFKSEVwSVE0aFNhU1p4NGVZMnk2M2pEUEYyZ2pXYmJLUXdiUHNMUjUvUEJN?=
 =?utf-8?B?cUFUWjRjaXJLS0dML21STzhmOXFlbElMVkIwcktEZEpnVmxuV09aL1Bndk8z?=
 =?utf-8?B?NlJUVjFLOGRkLzVadkoxcjAzdjJJMHdtT0l6SWhjcm5PMDlXcVU2eXdZZzll?=
 =?utf-8?B?cTNBTjZTNFErbm9zL3ZPT1d2akkvNnlETzZqRzVDYnViLzFyYlVXQ29saUxx?=
 =?utf-8?B?Zm5lNUZueEFhRWtSdGVhOWV0SVgwcTZXU0p5V0VoREJEV3pnZXBEZXE5WFFZ?=
 =?utf-8?B?UXlQazZHbWhYZEJORGZudHFTMlVTWm83NEZhRTdJQUw4bG1tZlB5UFZPV2s5?=
 =?utf-8?B?R09pZTIraGUxcVQxRlZpSzVPbUFMVWVHSEJTOWJqZjFkNG9IeDNIVmNMd0Ju?=
 =?utf-8?B?N29UOTBZVW9yaFJZVk1mdWRWK1dHVlhUNWxVQmQyWHNkRzRkRWNnKzA5ZXhP?=
 =?utf-8?B?L2N2TTVadEZ3cC83a0l5OGN3dlI0SGQ5YWFLdlpWM3A0ZEQ5bDhHK0h2VXFq?=
 =?utf-8?B?NURxMnF3Rlc5dHJVNEwyNGNxeTNGWGYybzF5Q3A0bDJlc3l6bDBSYm9aUGhz?=
 =?utf-8?B?eEdMZmtwOUlVN05YWkhOazZKRUJnTGgrRDJFd21FRnhIMlpMQ2pPQWpDL2sz?=
 =?utf-8?B?T2dnNFJZMUFvUERINVpOZktmQmtJRUpMQjNmeDhuUytqcmJweS9RTGFRamtF?=
 =?utf-8?B?a0NhWTh4QUhqYytmMFZTbzFsSVQvSzBlMmdJdlAybzJWa1h3NHppWDZmd2VM?=
 =?utf-8?B?dSs1UEk0QzRaWWpJd2Nxdy9zMXE4U3pxa2crUFFJSk9PRW1aclFESC9QMFcv?=
 =?utf-8?B?OEl4N0dXYjZSUG02UXlyVmdtN3lhaUx5Z1BGV1pwd2VNOFZ3Tm9Va0kxdHZi?=
 =?utf-8?B?ZzByaFhBenNkVE45cC9lRW1lb2R6bGFrSGdLczJJUDNzL3dSNTZYVXVaT2I5?=
 =?utf-8?B?ekR6dnZwWWVERXlWOUhkb0ZIZk9CZm1ENHpETkVKVGRYSlJyVVdzM2R6Qy9t?=
 =?utf-8?B?b3p6ZWhETllvdXU1Mko2MzZYT2gyeHFPQ2xSRVhDbDBwWk92c21wN2JzSWs5?=
 =?utf-8?B?d2F4ZzNaRkM3UVJjbmlFTDdLSHVyWDZnSkNyanU5ME5vL1dHcE5YM3B5OExG?=
 =?utf-8?B?dHJvRy82UDBWTUl4UWphREF0YmU3bWtHUjF5V2g5NWowRjFxZktlanVpY09Y?=
 =?utf-8?Q?6u+PYwy+MODwrY7mD0?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf83293-c382-461b-7096-08dea66e5a1f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9235.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 04:10:02.2843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcVczs1b3P4aJLAXVH4tGB8mb3YnWHyrs5291hCo/VmX3R/LfKHWHiJInifUrFzO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB10967

I'm resigning from my position at Axentia.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .mailmap    |  1 +
 MAINTAINERS | 24 +++++++++++-------------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/.mailmap b/.mailmap
index 34acd34bbf9b..7cc01b61aa0a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -677,6 +677,7 @@ Peter A Jonsson <pj@ludd.ltu.se>
 Peter Hilber <peter.hilber@oss.qualcomm.com> <quic_philber@quicinc.com>
 Peter Oruba <peter.oruba@amd.com>
 Peter Oruba <peter@oruba.de>
+Peter Rosin <peda@lysator.liu.se> <peda@axentia.se>
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev> <pierre-louis.bossart@linux.intel.com>
 Pratyush Anand <pratyush.anand@gmail.com> <pratyush.anand@st.com>
 Pratyush Yadav <pratyush@kernel.org> <ptyadav@amazon.de>
diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..75ea85732e15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4299,18 +4299,16 @@ F:	Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml
 F:	drivers/video/backlight/aw99706.c
 
 AXENTIA ARM DEVICES
-M:	Peter Rosin <peda@axentia.se>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
+S:	Orphan
 F:	arch/arm/boot/dts/microchip/at91-linea.dtsi
 F:	arch/arm/boot/dts/microchip/at91-natte.dtsi
 F:	arch/arm/boot/dts/microchip/at91-nattis-2-natte-2.dts
 F:	arch/arm/boot/dts/microchip/at91-tse850-3.dts
 
 AXENTIA ASOC DRIVERS
-M:	Peter Rosin <peda@axentia.se>
 L:	linux-sound@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	Documentation/devicetree/bindings/sound/axentia,*
 F:	sound/soc/atmel/tse850-pcm5142.c
 
@@ -12046,7 +12044,7 @@ F:	Documentation/i2c/busses/i2c-nvidia-gpu.rst
 F:	drivers/i2c/busses/i2c-nvidia-gpu.c
 
 I2C MUXES
-M:	Peter Rosin <peda@axentia.se>
+M:	Peter Rosin <peda@lysator.liu.se>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-arb*
@@ -12447,7 +12445,7 @@ F:	drivers/iio/industrialio-backend.c
 F:	include/linux/iio/backend.h
 
 IIO DIGITAL POTENTIOMETER DAC
-M:	Peter Rosin <peda@axentia.se>
+M:	Peter Rosin <peda@lysator.liu.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-iio-dac-dpot-dac
@@ -12455,7 +12453,7 @@ F:	Documentation/devicetree/bindings/iio/dac/dpot-dac.yaml
 F:	drivers/iio/dac/dpot-dac.c
 
 IIO ENVELOPE DETECTOR
-M:	Peter Rosin <peda@axentia.se>
+M:	Peter Rosin <peda@lysator.liu.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-iio-adc-envelope-detector
@@ -12471,7 +12469,7 @@ F:	include/linux/iio/iio-gts-helper.h
 F:	drivers/iio/test/iio-test-gts.c
 
 IIO MULTIPLEXER
-M:	Peter Rosin <peda@axentia.se>
+M:	Peter Rosin <peda@lysator.liu.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
@@ -12502,7 +12500,7 @@ F:	include/linux/iio/
 F:	tools/iio/
 
 IIO UNIT CONVERTER
-M:	Peter Rosin <peda@axentia.se>
+M:	Peter Rosin <peda@lysator.liu.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
@@ -15719,7 +15717,7 @@ F:	Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
 F:	drivers/media/i2c/max96717.c
 
 MAX9860 MONO AUDIO VOICE CODEC DRIVER
-M:	Peter Rosin <peda@axentia.se>
+M:	Peter Rosin <peda@lysator.liu.se>
 L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/max9860.txt
@@ -15934,7 +15932,7 @@ F:	Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
 F:	drivers/net/can/spi/mcp251xfd/
 
 MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
-M:	Peter Rosin <peda@axentia.se>
+M:	Peter Rosin <peda@lysator.liu.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
@@ -18238,7 +18236,7 @@ F:	include/linux/mmc/
 F:	include/uapi/linux/mmc/
 
 MULTIPLEXER SUBSYSTEM
-M:	Peter Rosin <peda@axentia.se>
+M:	Peter Rosin <peda@lysator.liu.se>
 S:	Odd Fixes
 F:	Documentation/ABI/testing/sysfs-class-mux*
 F:	Documentation/devicetree/bindings/mux/
@@ -19314,7 +19312,7 @@ F:	include/dt-bindings/display/tda998x.h
 K:	"nxp,tda998x"
 
 NXP TFA9879 DRIVER
-M:	Peter Rosin <peda@axentia.se>
+M:	Peter Rosin <peda@lysator.liu.se>
 L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/trivial-codec.yaml
-- 
2.20.1

