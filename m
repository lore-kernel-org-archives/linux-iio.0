Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795015100;
	b=PccIEsb1GbJfK0socNMS8rXkvXD1UXKI0aK7rAicsPMYqJo7BlwbPQEljO+z34W45s65
	 LxEyEjiWYaQcSRefarHtSOoHsicv0VsCpZvK75LcIIQINzpfeGMQuCAMoO44eR5aFz8Ee
	 9Cbf75muNvAg6L94rCynNhUqxvD7BmIQ8LZ0MQVbKHai2WyuK0lO9MivwaXCDvguViwN9
	 kWH0xd6ZbEzzwf/N7dSW41mR3ZBbIvbymxWafgTRA3nV3p2uahn+Ks3cuBIt3UB1Lw3PI
	 /rMlIe9Ye3Lz/yM8HCe8WwLSVgPSf8qTWgLYq5f6pV41QKKjEeo9Z39cdV668lN9S9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015100;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GajnCyRyGal0R+ApX6V1RrWNZccZzNyWfh3tmRDnA3o=;
	b=5pWHDqaYkIAzhZwyFOyB/ZFW3MF+gRnn/OQzYL0n+C/zuqfGfFsRpZhQ1+DxlAUVpXSA
	 nYcLThtpAoXMdOOyeUgd2EZ9BU00ao29GsLM+CsNBVFll/PQxxdNH9RkgXa2R4GVIw5le
	 CjR7lLJUQVU6qzLyfRUxTvhS8au/uUE5skU+QMgAGdv+fncuzh+h0JMLlfaE0RQgQ1BZo
	 8KsmxEjEYjp27slu20X95ketM/x/YP/qzTGSc3IEJSF1Eep2KFbQHYj4XranJavYjqObn
	 3TR352adg3I1XADTxA9cJNhmdDZrEwggGjrBdNCp8p1+5mYureD8lSAcbIMaVdXtzcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=F1Atf8NC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.49
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE67D60A3803;
	Wed, 18 Nov 2026 15:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE67D60A3803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=F1Atf8NC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4fcnW8XjWIVo9fLKyHE1rH4sEjdFIClL5lO9WjCWXEWqUiyR/Ut5LynIh4y1ChDtpagWBZ8ruQcj7v+FsyDpdjho9XChma8XUa4N2UpVWkeyc52AqYyiX4Vt/RLHDwAphHb8VXbsD/S5KBJRsS8vV7YdYtdTvvdQB3Krd2YYT9d1LZSgugRpeFFTzbeMipx0PNQnY3nn7AD6lQyrAEOBS85YD5GZa1ooA+kYuHNxgXqEYouR/NVQkoh1BiCTk/xIoXJIP0drK5G6B9X/G/v4oEv9nk01K7o+xBCF21z4uUqleVZL+spUqN/oi4pOy2sai6uEnnc8si6SyJbMAqMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GajnCyRyGal0R+ApX6V1RrWNZccZzNyWfh3tmRDnA3o=;
 b=jxJLA7qrEr6Bz1qmOuk3uGxJTbwdXVdunyEzGTkS9s1vUFPKPniZpEjwUAcF0cAoJxjFozAJV8McvkO2U8tXvDOazYoDIWsqacMeYOMEVbCC8t9na7g2khJ2FofMUiu3L6kEWCRkPOfOAOuM+1BFBP7+14Hvnkkn8r+sfKFn+GPSmc87E2OC1yyOTlEJIqkjE89PWf2U0leY2EXfZnMy8AgwJi+6SPBUriu4dK7ncNFqJFReyOW5De/NlcXe99giIgRUoAeHGcWGpK2wCDgoDfKXO5Pk1td2WdMn+vUuqkn5W5UiB0ldrEdoBWVG6AOGzXi9UUYzOjitiOMU+QVcNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=amd.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GajnCyRyGal0R+ApX6V1RrWNZccZzNyWfh3tmRDnA3o=;
 b=F1Atf8NCglMlNx+7D/xPhe/a2DW1fzlb5kNCbIpSYa5fJmgumFMzhThV0X/VM8eeb8xFbwKC97dEXl2Oj/dqJWJWoNj+5HqrDzS/jV4enGpVfzxxSGlPnu5LjcahvNhhWTZBoSZBbD7mHgy0z5A9A9ghh2ba9D0c2V9khgeLmadr/sy6LQWCHnwjQeSxFCUM1Th9mMrDiRlKyRsAWlIFjWbdqf/Bzg8Tf4sbpy3XXKLoJon3NmnGkkI+u9FHVA0zaSgsTeMbCAbAlHLZhwUpfhZKqclbzC/GYw9rRX/XCsI6eMgUG6HcxvT+Plwt+TpbKmI/tfXBOugs3WpxbFfQbQ==
Received: from DU6P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::13)
 by AM7PR10MB3734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:108::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Wed, 18 Nov
 2026 15:18:13 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::95) by DU6P191CA0022.outlook.office365.com
 (2603:10a6:10:540::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 15:18:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:18:08 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 18 Nov
 2026 16:18:49 +0100
Received: from localhost (10.252.16.78) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 18 Nov
 2026 16:18:03 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
Date: Wed, 18 Nov 2026 16:17:50 +0100
Subject: [PATCH v2 05/11] iio: adc: stm32-mdf: add digital filter device
 support
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261118-upstream_mdf_v2-v2-5-7939d3c3720a@foss.st.com>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
In-Reply-To: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"Sumit Semwal" <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>, Philipp Stanner <phasta@kernel.org>, "Arnaud
 Pouliquen" <arnaud.pouliquen@foss.st.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-sound@vger.kernel.org>, "Olivier
 Moysan" <olivier.moysan@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|AM7PR10MB3734:EE_
X-MS-Office365-Filtering-Correlation-Id: c00a7bbd-36a0-47f3-a893-08df45872731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|36860700016|82310400026|921020|261022075727099003|261021135927099003|261026121527099003|11063799006|56012099006|261026140227099003|10067099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|261021123027099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anNFSDI5cTBDMSsxQUhVaWJZazFpUlR4a1A1NHJzZW44U0FjUkVvbi9na2wy?=
 =?utf-8?B?LytEeDNheE5Ed2hYenpYZXJwbWRUUGFadUwyR0dZSWxXVXhVT3NOYkZtK1dR?=
 =?utf-8?B?K0lLL28wVjU5Q0F4KzZnZ1FLWGJ1YUNZY3FiSENnOHFZTmVpNWRyRzhJNjhy?=
 =?utf-8?B?cUZ3WkxTclFWQXJkci9TMlNWRnZqQ2c2QlBYajhhWTVCNGhkamlZMkVqMzZu?=
 =?utf-8?B?MjU3bmsyNEpuTG5jN0tPMXBTa0JwT0lDQXoyRGphVkxDUHVIdUtLSHhGemV5?=
 =?utf-8?B?RGhjeTN1Szh5Y1RIL29LcFZ3UXNZTDRWZW82M0xpWEtPVzhnN1NFTVl0T3Zn?=
 =?utf-8?B?RFNHRWYzR0NwNDRhVDVVV3ZJSGx0MVpvVTVTamFNYjU3VmdSLzErNXAxY1RQ?=
 =?utf-8?B?bWFRcXpYczRrYlNORWdLeklvcTZFQUcvUTNVS1d5MXdpWVdaUS9OMERjL1dj?=
 =?utf-8?B?VDVVWWNsendUK3RneXZ1TjNEL1BRUzlyYXEvcFJzcGlEd1I3MmZiNVErOTdC?=
 =?utf-8?B?TmpYZUcvM1N4c1AxQzIyeWw1WG44dUhtQXpEU0x2ZHpQK09pTWtpNG9zM21V?=
 =?utf-8?B?Tld3UDlrQkQyRHFMMlpFd05CdW9rcEh0VThWdFM5Mk1ZVXNLODRvMUVVOVA4?=
 =?utf-8?B?ME15RlpjNEhoR2JvYStmM3ZjbkdERUpXRGpaVlZJOHJQMnplRWdrWVEvdUVR?=
 =?utf-8?B?dmpUMVB4STl5cFR0Y2prWVdvQ0dvbkNlQWxkNUlRSHgyRklKTFppK1JEZWwv?=
 =?utf-8?B?KzBHL0VWMzJDbkRTL1IvRjA5cEQ2OUZBNk9URndZcjlXVllXVE1PbHJYMCsr?=
 =?utf-8?B?WE4xaVBMaWI4OFBTVmZZRTRBMjd4SldpTTBQSGl5YlgzbUkyU0NWNnV4bGdY?=
 =?utf-8?B?dzZKSXNpUHdxMEQ0MnpPVVFnNHdSeWN3bnJ6Uk9HdHNEblBEdzJRL1VQRDdt?=
 =?utf-8?B?VHlFVDkwVzB6Q2NIUGE1dGFVbE1UVU9WL2tZM3ZSS29zWjVJWWo2R3ZCS1Rr?=
 =?utf-8?B?aStRMUhvWDJ3RW1MeVVpV2VmSGpURHZTRE9SNjUzU2lNSGR1OENRTkh4SWtJ?=
 =?utf-8?B?NngvYVlJOVdvcGZLOU1JMGdMUGhJdGorb3RwUVlkWkl4YlRCaGRaNWdYTkJK?=
 =?utf-8?B?U3FuaGRhZXJCSUtJQ1U4MzcxSExMTzdQYktrcXRGcXZPck1oR1dwOVVWMXcv?=
 =?utf-8?B?TUphVkdKWWRwNEJTb0JoU0lyNi9IRTFVL0w4VERhdVU2YkFmMmI3ZXJhNENr?=
 =?utf-8?B?b2d3VEJFYkVjcm5wTzV1VUo0L1VPaHgvQjliUFZlanNyY2w0OXV2cHNmS3BG?=
 =?utf-8?B?WVBxTFRhcXlDbjZEK0Juc3RhYVJYZzExamhhaDBVbm4vQStMU2FnN3h2Y3JI?=
 =?utf-8?Q?Q+9t1OoRtEEjK5I4zekzTJs3ayuvSbQc=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(36860700016)(82310400026)(921020)(261022075727099003)(261021135927099003)(261026121527099003)(11063799006)(56012099006)(261026140227099003)(10067099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kuweHZj98VVAvDOYEg/P+N9aZ9hUoujgHfI69rRg90HnRTY7uoUd0RtrEpg+VFG3cyy5AuoagOuEBc/m1CiGKmSqGjG8MJdRye7qWTU/2mNtUyuHERL/Zj8qlmP1PvntxhC65J6NDweNCzsGy6Y7KOrin7DHQUrQxmyPG64L44H8ENs9JpxWUSepazMgD4FXjsbD+qQ3oWWuSj4GoTemgi9FAuMAKGaB7QX75QqKdLTIZs29ISFIl+fLyP+tXNOIV64dvdlbWMZusdZCBQhoQLCHl1LKwT5LaEshc6yNLTLn2XY+B8ifi0/9M3nznI235pXu7U8ZU3LyTagzwtUsobDkNjcV+jmfSSq3pBIpoaUzqglmddSVInPya9LNCIvm2ZaNNKKlPC74O01xHWlOvev29tKwYwuL8wrg/oPqGeKCIb2BLSxyNAHtfPaCbpTL
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:18:08.9212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c00a7bbd-36a0-47f3-a893-08df45872731
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3734

The digital filters ensure the decimation of the bitstream signal
received from serial interfaces, through a bitstream matrix (BSMX).

Introduce the digital filter driver structures, register map and platform
driver as the foundation for analog conversion and digital microphone
support.

Manage configuration of digital filters such as the CIC mode, reshape
filter bypass, high-pass cutoff, synchronization, interleave and
acquisition delay.

Manage also connection beteween filters and serial interfaces through
BSMX.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/Kconfig         |  15 ++
 drivers/iio/adc/Makefile        |   1 +
 drivers/iio/adc/stm32-mdf-adc.c | 514 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 530 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6bd46c79d6d6..c3e9885af22d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1753,6 +1753,21 @@ config STM32_MDF_CORE
 	  This driver can also be built as a module. If so, the module
 		  will be called stm32-mdf.
 
+config STM32_MDF_ADC
+	tristate "STMicroelectronics STM32 MDF adc"
+	depends on (ARCH_STM32 && OF) || COMPILE_TEST
+	depends on COMMON_CLK
+	select STM32_MDF_CORE
+	select IIO_BUFFER
+	select IIO_BUFFER_HW_CONSUMER
+	select IIO_BACKEND
+	help
+	  Select this option to support ADCSigma delta modulator for
+	  STMicroelectronics STM32 Multi-function digital filter.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called stm32-mdf-adc.
+
 config STMPE_ADC
 	tristate "STMicroelectronics STMPE ADC driver"
 	depends on OF && MFD_STMPE
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 811ef85a88fb..028f33f3d15a 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -146,6 +146,7 @@ obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
 obj-$(CONFIG_STM32_ADC) += stm32-adc.o
 obj-$(CONFIG_STM32_DFSDM_ADC) += stm32-dfsdm-adc.o
 obj-$(CONFIG_STM32_DFSDM_CORE) += stm32-dfsdm-core.o
+obj-$(CONFIG_STM32_MDF_ADC) += stm32-mdf-adc.o
 obj-$(CONFIG_STM32_MDF_CORE) += stm32-mdf.o
 stm32-mdf-y := stm32-mdf-core.o stm32-mdf-serial.o
 obj-$(CONFIG_STMPE_ADC) += stmpe-adc.o
diff --git a/drivers/iio/adc/stm32-mdf-adc.c b/drivers/iio/adc/stm32-mdf-adc.c
new file mode 100644
index 000000000000..411af78911c9
--- /dev/null
+++ b/drivers/iio/adc/stm32-mdf-adc.c
@@ -0,0 +1,514 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This file is part of STM32 MDF driver
+ *
+ * Copyright (C) 2023-2026, STMicroelectronics - All Rights Reserved
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/iio/backend.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/hw-consumer.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "stm32-mdf.h"
+
+#define MDF_DMA_BUFFER_SIZE (4 * PAGE_SIZE)
+#define STM32_MDF_ITF_MAX 8
+#define STM32_MDF_DATA_RES 24
+#define STM32_MDF_HPF_BYPASS -1
+#define STM32_MDF_TIMEOUT_MS msecs_to_jiffies(100)
+/*
+ * Choose a default sampling ratio supported for all filter orders with RSFLT active.
+ * 32 is the maximum decimation ratio for filter order 5, with RSFLT active.
+ */
+#define MDF_DEFAULT_DECIM_RATIO 32
+
+#define MDF_IS_FILTER0(adc)			(!((adc)->fl_id))
+#define MDF_IS_INTERLEAVED_FILT(adc)		((adc)->interleaved)
+#define MDF_IS_INTERLEAVED_FILT_NOT_0(adc)	({ typeof(adc) x = (adc);\
+						MDF_IS_INTERLEAVED_FILT(x) && !MDF_IS_FILTER0(x); })
+
+#define STM32_MDF_ERR_SCK_FREQ BIT(1)
+#define STM32_MDF_ERR_MODE_RATIO BIT(2)
+#define STM32_MDF_ERR_DECIM_RATIO BIT(3)
+
+struct stm32_mdf_dev_data {
+	int type;
+	int (*init)(struct device *dev, struct iio_dev *indio_dev);
+};
+
+struct stm32_mdf_adc_chan {
+	const char *channel_name;
+	struct iio_backend *backend;
+};
+
+/*
+ * struct stm32_mdf_adc - STM32 MDF ADC private data
+ * @entry: pointer to serial interfaces list
+ * @dev: pointer to filter device
+ * @mdf: pointer to mdf common data
+ * @regmap: regmap pointer for register read/write
+ * @node: pointer to filter node
+ * @dma_chan: filter dma channel pointer
+ * @channels: pointer to channel descriptors array
+ * @dev_data: mdf device data pointer
+ * @sitf: pointer to serial interface feeding the filter
+ * @completion: completion for conversion
+ * @dma_buf: physical dma address
+ * @phys_addr: mdf physical address
+ * @cb: iio consumer callback function pointer
+ * @cb_priv: pointer to consumer private structure
+ * @sck_freq: serial interface frequency
+ * @requested_sample_freq: requested sample frequency from IIO sysfs or from audio stream
+ * @sample_freq: actual sampling frequency
+ * @fl_id: filter index
+ * @decim_ratio: total decimation ratio
+ * @decim_cic: CIC filter decimation ratio
+ * @stu: settling time in micro seconds
+ * @nbdis: number of samples to discard
+ * @bufi: dma buffer current position
+ * @buf_sz: dma buffer size
+ * @buffer: buffer pointer for raw conversion
+ * @dflt_max: dflt maximum output
+ * @cicmode: cic filter order
+ * @hpf_cutoff: high pass filter cut-off frequency
+ * @delay: microphone delay
+ * @datsrc: data source path
+ * @rx_buf: dma buffer pointer
+ * @rsflt_bypass: reshape filter bypass flag
+ * @synced: synchronous flag
+ * @trgo: TRGO trigger flag
+ * @interleaved: interleave flag
+ */
+struct stm32_mdf_adc {
+	struct list_head entry;
+	struct device *dev;
+	struct stm32_mdf *mdf;
+	struct regmap *regmap;
+	struct fwnode_handle *node;
+	struct dma_chan *dma_chan;
+	struct stm32_mdf_adc_chan *channels;
+	const struct stm32_mdf_dev_data *dev_data;
+	struct stm32_mdf_sitf *sitf;
+	struct completion completion;
+	dma_addr_t dma_buf;
+	phys_addr_t phys_addr;
+	int (*cb)(const void *data, size_t size, void *cb_priv);
+	void *cb_priv;
+	unsigned long sck_freq;
+	unsigned long requested_sample_freq;
+	unsigned long sample_freq;
+	unsigned int fl_id;
+	unsigned int decim_ratio;
+	unsigned int decim_cic;
+	unsigned int stu;
+	unsigned int nbdis;
+	unsigned int bufi;
+	unsigned int buf_sz;
+	unsigned int dflt_max;
+	u32 *buffer;
+	u32 cicmode;
+	u32 hpf_cutoff;
+	u32 delay;
+	u32 datsrc;
+	u8 *rx_buf;
+	bool rsflt_bypass;
+	bool synced;
+	bool trgo;
+	bool interleaved;
+};
+
+struct stm32_mdf_scales {
+	unsigned int scale;
+	int gain_db;
+	int gain_lin;
+};
+
+struct stm32_mdf_log10 {
+	unsigned int raw;
+	unsigned int log;
+};
+
+enum stm32_mdf_converter_type {
+	STM32_MDF_AUDIO,
+	STM32_MDF_IIO,
+};
+
+enum stm32_mdf_data_src_type {
+	STM32_MDF_DATSRC_BSMX,
+	STM32_MDF_DATSRC_UNSUPPORTED,
+	STM32_MDF_DATSRC_ADCITF1,
+	STM32_MDF_DATSRC_ADCITF2,
+	STM32_MDF_DATSRC_NB,
+};
+
+enum stm32_mdf_acq_mode {
+	STM32_MDF_ACQ_MODE_ASYNC_CONT,
+	STM32_MDF_ACQ_MODE_ASYNC_SINGLE_SHOT,
+	STM32_MDF_ACQ_MODE_SYNC_CONT,
+	STM32_MDF_ACQ_MODE_SYNC_SINGLE_SHOT,
+	STM32_MDF_ACQ_MODE_WINDOW_CONT,
+	STM32_MDF_ACQ_MODE_SYNC_SNAPSHOT,
+	STM32_MDF_ACQ_MODE_NB,
+};
+
+enum stm32_trig_type {
+	STM32_MDF_TRGSRC_TRGO,
+	STM32_MDF_TRGSRC_OLD,
+	STM32_MDF_TRGSRC_EXT,
+	STM32_MDF_TRGSRC_NB,
+};
+
+static const unsigned int stm32_mdf_hpf_cutoff_ratio[] = {
+	625, 1250, 2500, 9500
+};
+
+/*
+ * The CIC output data resolution cannot exceed 26 bits.
+ * Output data resolution: D = N * ln(D) / ln(2) + 1 (for serial interface data),
+ * where N is filter order and D the CIC decimation factor.
+ * Following table gives the maximum decimation ratio for filter order [0..5].
+ */
+static bool stm32_mdf_adc_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MDF_BSMXCR_REG:
+	case MDF_DFLTCR_REG:
+	case MDF_DFLTCICR_REG:
+	case MDF_DFLTRSFR_REG:
+	case MDF_DFLTINTR_REG:
+	case MDF_OLDCR_REG:
+	case MDF_OLDTHLR_REG:
+	case MDF_OLDTHHR_REG:
+	case MDF_DLYCR_REG:
+	case MDF_SCDCR_REG:
+	case MDF_DFLTIER_REG:
+	case MDF_DFLTISR_REG:
+	case MDF_OECCR_REG:
+	case MDF_SNPSDR:
+	case MDF_DFLTDR_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool stm32_mdf_adc_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/*
+	 * In MDF_DFLTCR_REG register only DFLTACTIVE & DFLTRUN bits are volatile.
+	 * MDF_DFLTCR_REG is not marked as volatible to ease the suspend/resume case, and benefit
+	 * from the regcache API. Access to volatile bits is managed specifically instead.
+	 */
+	switch (reg) {
+	case MDF_DFLTISR_REG:
+	case MDF_SNPSDR:
+	case MDF_DFLTDR_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool stm32_mdf_adc_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MDF_BSMXCR_REG:
+	case MDF_DFLTCR_REG:
+	case MDF_DFLTCICR_REG:
+	case MDF_DFLTRSFR_REG:
+	case MDF_DFLTINTR_REG:
+	case MDF_OLDCR_REG:
+	case MDF_OLDTHLR_REG:
+	case MDF_OLDTHHR_REG:
+	case MDF_DLYCR_REG:
+	case MDF_SCDCR_REG:
+	case MDF_DFLTIER_REG:
+	case MDF_DFLTISR_REG:
+	case MDF_OECCR_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config stm32_mdf_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = sizeof(u32),
+	.max_register = MDF_DFLTDR_REG,
+	.readable_reg = stm32_mdf_adc_readable_reg,
+	.volatile_reg = stm32_mdf_adc_volatile_reg,
+	.writeable_reg = stm32_mdf_adc_writeable_reg,
+	.num_reg_defaults_raw = MDF_DFLTDR_REG / sizeof(u32) + 1,
+	.cache_type = REGCACHE_FLAT,
+	.fast_io = true,
+};
+
+static struct stm32_mdf_adc *stm32_mdf_get_filter_by_handle(struct stm32_mdf *mdf,
+							    struct fwnode_handle *node)
+{
+	struct stm32_mdf_adc *adc;
+
+	/* Look for filter data from filter node handle */
+	list_for_each_entry(adc, &mdf->filter_list, entry) {
+		if (adc->node == node)
+			return adc;
+	}
+	return NULL;
+}
+
+static int stm32_mdf_get_sitf(struct device *dev, struct stm32_mdf_adc *adc,
+			      struct fwnode_handle *sitf_node)
+{
+	struct stm32_mdf_sitf *sitf;
+
+	/* Look for sitf interface from node handle */
+	list_for_each_entry(sitf, &adc->mdf->sitf_list, entry) {
+		if (sitf->node == sitf_node) {
+			adc->sitf = sitf;
+			break;
+		}
+	}
+
+	if (!adc->sitf) {
+		dev_err(dev, "Serial interface not configured\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int stm32_mdf_get_filters_config(struct device *dev, struct stm32_mdf_adc *adc)
+{
+	int i, ret;
+	u32 val;
+
+	ret = device_property_read_u32(dev, "st,cic-mode", &val);
+	if (ret) {
+		dev_err(dev, "Could not get cic filter mode: %d\n", ret);
+		return ret;
+	}
+	adc->cicmode = val;
+
+	adc->rsflt_bypass = device_property_present(dev, "st,rs-filter-bypass");
+
+	adc->hpf_cutoff = STM32_MDF_HPF_BYPASS;
+	if (device_property_present(dev, "st,hpf-filter-cutoff-bp")) {
+		ret = device_property_read_u32(dev, "st,hpf-filter-cutoff-bp", &val);
+		if (ret) {
+			dev_err(dev, "Could not read HPF cut-off frequency: %d\n", ret);
+			return ret;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(stm32_mdf_hpf_cutoff_ratio); i++) {
+			if (stm32_mdf_hpf_cutoff_ratio[i] == val) {
+				adc->hpf_cutoff = i;
+				break;
+			}
+		}
+
+		if (adc->hpf_cutoff == STM32_MDF_HPF_BYPASS) {
+			dev_err(dev, "Unknown HPF cut-off frequency ratio: %d\n", val);
+			return -EINVAL;
+		}
+	}
+
+	dev_dbg(dev, "Filter [%d] config: cic mode [%d], rsflt [%s], hpf [%s]\n", adc->fl_id,
+		adc->cicmode, adc->rsflt_bypass ? "off" : "on",
+		adc->hpf_cutoff == STM32_MDF_HPF_BYPASS ? "off" : "on");
+
+	return 0;
+}
+
+static int stm32_mdf_adc_parse_of(struct platform_device *pdev, struct stm32_mdf_adc *adc)
+{
+	struct device *dev = &pdev->dev;
+	struct stm32_mdf_adc *adcm;
+	struct fwnode_handle *sitf_node;
+	struct fwnode_handle *filt_node;
+	struct fwnode_reference_args args;
+	int ret, stream, buf_size = 1;
+	u32 idx, bsmx, val;
+
+	ret = device_property_read_u32(dev, "reg", &idx);
+	if (ret) {
+		dev_err(dev, "Could not get filter index: %d\n", ret);
+		return ret;
+	}
+
+	if ((idx - 4) % 0x80) {
+		dev_err(dev, "Unexpected reg property value [%x]\n", idx);
+		return -EINVAL;
+	}
+
+	adc->fl_id = (idx >> 7) - 1;
+	if (adc->fl_id >= adc->mdf->nbf) {
+		dev_err(dev, "Wrong filter index [%d]\n", adc->fl_id);
+		return -EINVAL;
+	}
+	adc->node = dev_fwnode(dev);
+
+	if (device_property_present(&pdev->dev, "st,sync")) {
+		filt_node = fwnode_find_reference(dev_fwnode(dev), "st,sync", 0);
+		if (IS_ERR(filt_node)) {
+			dev_err(dev, "Failed to get filter sync handle %ld\n", PTR_ERR(filt_node));
+			return PTR_ERR(filt_node);
+		}
+		adc->synced = true;
+
+		adcm = stm32_mdf_get_filter_by_handle(adc->mdf, filt_node);
+		fwnode_handle_put(filt_node);
+		if (!adcm)
+			return dev_err_probe(dev, -EPROBE_DEFER, "Failed to get filter synchro\n");
+
+		/* The Synchronized master filter is the TRGO trigger source */
+		adcm->trgo = true;
+	}
+
+	if (device_property_present(&pdev->dev, "st,delay")) {
+		ret = device_property_read_u32(dev, "st,delay", &val);
+		if (ret) {
+			dev_err(dev, "Could not get filter delay: %d\n", ret);
+			return ret;
+		}
+		adc->delay = val;
+	}
+
+	/*
+	 * In interleave mode the filters in range [1..n] share their configuration with filter 0.
+	 * In this case, use config from filter 0, instead of parsing DT.
+	 */
+	if (!MDF_IS_FILTER0(adc) && adc->fl_id < adc->mdf->nb_interleave) {
+		adc->interleaved = true;
+	} else {
+		ret = stm32_mdf_get_filters_config(dev, adc);
+		if (ret)
+			return ret;
+
+		if (MDF_IS_FILTER0(adc) && adc->mdf->nb_interleave) {
+			/* Filter 0 is the TRGO trigger source in interleave mode */
+			adc->trgo = true;
+			adc->interleaved = true;
+			buf_size = adc->mdf->nb_interleave;
+		}
+	}
+
+	adc->buffer = devm_kcalloc(dev, buf_size, sizeof(u32), GFP_KERNEL);
+	if (!adc->buffer)
+		return -ENOMEM;
+
+	/* Retrieve serial interface */
+	ret = fwnode_property_get_reference_args(dev_fwnode(dev), "st,sitf", NULL, 1, 0, &args);
+	if (ret) {
+		dev_err(dev, "Serial interface node not found: %d\n", ret);
+		return ret;
+	}
+	sitf_node = args.fwnode;
+
+	/* Get stream index */
+	if (args.nargs != 1) {
+		dev_err(dev, "Failed to get stream index in st,sitf property\n");
+		fwnode_handle_put(sitf_node);
+		return -EINVAL;
+	}
+	stream = args.args[0];
+
+	/* Retrieve sitf data from sitf node phanle */
+	ret = stm32_mdf_get_sitf(dev, adc, sitf_node);
+	fwnode_handle_put(sitf_node);
+	if (ret)
+		return ret;
+
+	bsmx = adc->sitf->id * 2 + stream;
+
+	dev_dbg(dev, "Digital filter [%d] linked to sitf [%d]\n", adc->fl_id, adc->sitf->id);
+
+	/* Only support BSMX filter source right now */
+	adc->datsrc = STM32_MDF_DATSRC_BSMX;
+
+	list_add(&adc->entry, &adc->mdf->filter_list);
+
+	/* Configure BSMXCR */
+	regmap_update_bits(adc->regmap, MDF_BSMXCR_REG,
+			   MDF_BSMXCR_BSSEL_MASK, FIELD_PREP(MDF_BSMXCR_BSSEL_MASK, bsmx));
+
+	return 0;
+}
+
+static int stm32_mdf_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct stm32_mdf_adc *adc;
+	struct iio_dev *iio;
+	struct resource *res;
+	void __iomem *base;
+	int ret;
+
+	iio = devm_iio_device_alloc(dev, sizeof(*adc));
+	if (!iio) {
+		dev_err(dev, "Failed to allocate IIO device\n");
+		return -ENOMEM;
+	}
+	iio->modes = INDIO_DIRECT_MODE;
+
+	adc = iio_priv(iio);
+	adc->mdf = dev_get_drvdata(dev->parent);
+
+	platform_set_drvdata(pdev, iio);
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base), "Failed to get resource\n");
+	adc->phys_addr = res->start;
+
+	adc->regmap = stm32_mdf_regmap_init(dev, adc->mdf->kclk, base, &stm32_mdf_regmap_cfg);
+	if (IS_ERR(adc->regmap))
+		return dev_err_probe(dev, PTR_ERR(adc->regmap), "Failed to init regmap\n");
+
+	ret = stm32_mdf_adc_parse_of(pdev, adc);
+	if (ret < 0)
+		return ret;
+
+	adc->dev = dev;
+
+	return 0;
+}
+
+static void stm32_mdf_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+
+	if (!MDF_IS_INTERLEAVED_FILT_NOT_0(adc))
+		iio_device_unregister(indio_dev);
+
+	list_del(&adc->entry);
+}
+
+static struct platform_driver stm32_mdf_adc_driver = {
+	.driver = {
+		.name = "stm32-mdf-adc",
+	},
+	.probe = stm32_mdf_adc_probe,
+	.remove = stm32_mdf_adc_remove,
+};
+module_platform_driver(stm32_mdf_adc_driver);
+
+MODULE_DESCRIPTION("STM32 MDF sigma delta ADC");
+MODULE_AUTHOR("Olivier Moysan <olivier.moysan@foss.st.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BACKEND");

-- 
2.43.0

