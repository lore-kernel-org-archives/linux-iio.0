Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013019.outbound.protection.outlook.com [40.107.162.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231CE48EC8B;
	Fri, 11 Sep 2026 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141910; cv=fail; b=NZd4a2DQUzUJPsevn9awfErsFZ4KZzx/mCDbXhwGxfQOEBAY5XgAQn8FZ48vrXNfrWe50Tc3Y8RqalwwclgJyfHUSq/XXr3HH89VA2DlR1gSbz0C5DNQKNTJZi2KjtphhuRBl8YzDJ+FHubNtjZBn9eAWRVsWr0XOO/+eANA7Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141910; c=relaxed/simple;
	bh=/GYZXN+qag5dc07ihaKs1eAj/6Ei7/rOGwDpblOL0Ng=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Hr8/+L+iyZhfo1Bk/PlK5PRxagLwGt73JoAYOttjSVczA0HXRWqHQQUg5K1aOkFyOAAHN6Y2Jr18KVzQEgFxpV6gaZmx3kqBwv+lcroKugCuoI/Bh81xd+r3wocKkNO2WRcj4UrfVrMY32NvyQN8Z86tt8rSDhUc19KTT4KmBt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=YknZONUQ; arc=fail smtp.client-ip=40.107.162.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="YknZONUQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODTrhUTpRtTubHvVqf0fE6BYR9Fwmv00+Q5fgxWBU5JUkA/gojvIqS1NpLRmekHuU3ltEVt87DcboEWKDNzMb8rTt55lfLgEtH5MGK55fNVx1nUp/8qzs9HOmCviiwgpoh9aI+3KZ0JWlDXpUl/wcEJR0JvO6e8owzp+w4RZY5285923DeT81y5puk0RCRfHKfEFPu/wSgZquhZSjuQkL7NEXPs2lwjKNhAUsL/bjl/vstZ7WCx1qyxJ5wDZJfKMEF8INZywFPcGzPqRdRmb1iOJGFIKqBD9aNL+68D6T8BNQgCCTDjgKdfob2nCFx/OxrKTgsjUYeU72Va7KskfWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAoYyAkPzqZFzJg8fyHyiI+fkie1SJPMug2ZzfugPWA=;
 b=OtTr5FN/dfZM5a1/E2HwEheHu3RxHFLX1/RUK2Kyox2dIGz0bmusRm0nqJ0P7LWu3BZ/qjXjr+QmEPBug3ZrK3HOXZJePHH3uKr5v6x1z4oE4FrKOEok15hpwnvHx5zy24Bn4frojDPpTEF6Ohkq6whhc9w1w5zyNFloDxq+5coUc8w50yk8dlZHoPhWsPAxXQio+rC2B2bqcm/LTJJtieXKSh8hv8XOSm5M4VfETNZcc8GKfk8Rx+L7/l8C+F21rmtdPaaqEeLnVqvT7ShA7vCLBJuJ9FYbGIj7wZnd64AaUkdz1tDSgtxWcMFKoN4bRNtwA1XIu12KARlDOPjDEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=analog.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAoYyAkPzqZFzJg8fyHyiI+fkie1SJPMug2ZzfugPWA=;
 b=YknZONUQrXt1OTVy5NNKB1R1HZZSaQJFgk3gdgLKX2Ir1LzeYC5S8z94K/ZyfEwH+QdZgj5HEVNyPL1v6KpAzAHqLoXAVYRoHIFbjoF8g3J59vTjRo3IeLEoKVi+HcG6EJIhTE3q3V0JkmkcDuBNXfuD9o/mTt6PmtS7Fmdvfd4wnKnb50NxlEa75bME5Q2NkPbgLyUgnpBscO6Ybk6q9UPsy9X2fK/o0WpYtL0l/b/hDMHSCDalrW7BzqwIT8lU0CDuVnx2w0sGP0ri834DGViGfKBE07Wg4JuKJzMfj7yWjA6TpWKR1KYYtsdSELtqssuyyGESy3xS/vQS5QIasQ==
Received: from LO4P265CA0051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ac::13)
 by AS4PR10MB5800.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:507::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 15:51:42 +0000
Received: from ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
 (2603:10a6:600:2ac:cafe::49) by LO4P265CA0051.outlook.office365.com
 (2603:10a6:600:2ac::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Fri, 11
 Sep 2026 15:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 ZR1PEPF0000E6AD.mail.protection.outlook.com (10.167.241.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:51:41 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:57:10 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:51:41 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH 0/8] iio: adc: stm32: add support for stm32mp23 and
 stm32mp25
Date: Fri, 11 Sep 2026 17:51:22 +0200
Message-ID: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHojpGoC/yXMQQ6CMBBA0as0s3YSOqRqvYphUdpRx4RKOkhMC
 HenyPIt/l9AuQgr3MwChWdR+eQKezIQXyE/GSVVAzV0bry1GFJEnYaWhpEczhYpxEtLV+d88lC
 zsfBDfv/lvTus3/7Ncdo/sK4bnsWRBnQAAAA=
X-Change-ID: 20260911-adc-stm32mp25-v1-2ac7328559d9
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Marek Vasut <marex@nabladev.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Cheick Traore
	<cheick.traore-ext@st.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>, Cheick Traore
	<cheick.traore@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6AD:EE_|AS4PR10MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b642a07-41f7-497f-a451-08df101c92ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	YS/eYuCNUj3LlWvwWknCJXSoI5Gb4XIU5HAoMZFaCO2+kCAZF8gHFLFWidVOmI+QXI+x/SsgxWWm8p7YLmT8TEttDdWfDTdwaNKdhZaAjZrtn13VDsjGKqMiIO8YHuZV6C6PthXg1YOV86wvd9ppTm+CS9vpaJGJnhO/hd+rH3EfUIb9kBiiBu1OldAPzg0jaSWYU5ByR/0OPH5/vbizkrc8vTO6drJl+YOQCvyE1i+T2DU+gZ5TJQjSEFq6id/m6TJfUq/TodPs0zNqp3+hiJxEVTo8iL5IPvsQ/rurumN8iHXCMkMOu52tuooWTROUodqMMLzQACRI2tcGqxuvgYTCkdmkeJeidrsN9y46cTm+JtvuaTP7SReYL4eoODWIjjFwo8rMjC2a3VaXqZt6cUJLWmUcY+BkbudJYFgeYZYkJsGbgw8voMg+h+VVzcjDVn21Kh3VR/IIQY9PW8pC2a5i3i7BamsSnMA8wiKptbe1zImBAvMzJDucTpO1WVANeFkhwMW7GlU3cZJCJ38F+inRbtvurfAY8rTC9O2p2NcbpYd2VyxhFyBpPBwgxmfSUBcT1vxDkVnib7lhM+b4/Nh4YgfEvdL3FX1B04IIVZS3m2zWQGWL+YBxu4Z6y3xWYQmoHr4dmYifRSPSVcgmt4ktwK/Xn6UYw76Gr5hea2Z0Q984n8e/JiMqP+pKxTtEnWn6bIH7wsX5vKp5AYr24w==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(10067099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kxxpxckU55hAL4e4hHS4y+pD0oI8a7TfdORuKLrelPk9It2HOnKb3Ax9qaS4D/1eT89wPDmaAlq1iEH3pJl8MhcszDRwPY28FarecXq112xYAOP+/bVzw568RWC9+3tjUSLRmkG/cA10/i9MiKbvK8fSCjyQ5K/tDN5IngM3IUzrauxUafQYRX32+iCPdSKd3gB/1fIiR5rnElmiKpNO6KvCPtF43Q3YRKsbvooeropQ+as7mfQP6STFcRYxGnsL13l2hytDLu+a/0ccObyuO4oZDrQJ9OaFNgtD8FO5WSbhL0cSJNpUAWMvQSVGyElEHlj68mRjIVFcatyrAJOYfJQDhmNX71NEeSCyYANMSjUihpAlDc+MX+PxT+lBeX2s7KNmzXJoS1ztMRx8i0TIO9fiqcb8gatsIeUGZUjl1gfAv3Rdwg2xyWang8rCgNsM
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:51:41.9545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b642a07-41f7-497f-a451-08df101c92ef
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5800

Add support for STM32MP23 and STM32MP25 Analog to Digital Converter.
It's a variant of other supported STM32MP ADCs. Add the DT bindings,
driver, SOC DTS and an example on stm32mp257f-ev1 board.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Cheick Traore (1):
      arm64: dts: st: add ADC nodes on stm32mp231

Fabrice Gasnier (4):
      dt-bindings: iio: adc: stm32-adc: add support for stm32mp23 and stm32mp25
      iio: adc: stm32-adc: add support for stm32mp23 and stm32mp25
      arm64: dts: st: add ADC nodes on stm32mp251
      arm64: dts: st: add ADC support on stm32mp257f-ev1 board

Olivier Moysan (1):
      iio: adc: stm32-adc: manage characterization voltage diversity

Patrice Chotard (2):
      arm64: dts: st: add vrefint calibration on stm32mp23
      arm64: dts: st: add vrefint calibration on stm32mp25

 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  | 106 ++++-
 arch/arm64/boot/dts/st/stm32mp231.dtsi             | 117 ++++++
 arch/arm64/boot/dts/st/stm32mp251.dtsi             | 119 ++++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts         |  22 +
 drivers/iio/adc/stm32-adc-core.c                   |  91 ++++-
 drivers/iio/adc/stm32-adc-core.h                   |  23 ++
 drivers/iio/adc/stm32-adc.c                        | 444 ++++++++++++++++++++-
 7 files changed, 880 insertions(+), 42 deletions(-)
---
base-commit: 6d31021b7ce470983aeee0727f7417272c0a1cad
change-id: 20260911-adc-stm32mp25-v1-2ac7328559d9

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

