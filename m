Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013007.outbound.protection.outlook.com [52.101.72.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07D753C3DD;
	Wed, 23 Sep 2026 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177973; cv=fail; b=XXHEIR51Wwg+f7SM4uplMnkZKU9c1J+sNcTiOWowEG4Qcb5ECM6wHaHcrcg5Si5RkaAvsSdPAIdL30bHX+9nkZtvumW5wlRy6VUV88ht/3bJThqYpBo9NjrrsuO4YrnMbl7+SzshEnbRBJuP6SS+MMexRceOUT+ebYAtX8j0QcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177973; c=relaxed/simple;
	bh=lJGcTHc4IElikoZRpawqwm7b2E3ysC+9dIBK8hGKq/w=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=GbGM9Qp2hN8nBfHemLs9gw+PR6rZC/bOyvKPM1dHn76of0pqqgP7AnJ7rn2LOy6AMAMkNcMz94Z7ewGtYOczcCfRDi1mT5JnHayYof0HrO3fcpkv1xDlR6OFIo5GK88Uo5dabFwnS8qGvFZwo9Rqc622R82vhNTVq0OiTodWpBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ah/UU8LJ; arc=fail smtp.client-ip=52.101.72.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ah/UU8LJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQFDsbVjdWvbadbxg4Lzf2f2vvzeKABBpZ5DeTkNVwvBoWS/3kHorDK/nqS/avs5Mgc4IxmuBZEysV9bMv0PQUscOcODtYyjo8fABZ4sp34XX7iBZdT5TvbX0ZuyQ9qeZj4ctgpvyc1CuTLK/NqaVGx/XBfa1tEc3R41VOluKjZDKqvf0Y9iUMssuRWo2HvZFAHZP7XdhKksbuQ3zTsQarbxXdQTcYacY/Aavj/Tg4p9+SlD5Bm4jJWt4N5EC2i6os8c/QRDMjtCuGTBrWGNVjFeihqSUPfz52Ta/crT9y+/7aOvm4UFaNwEz7BLBoAhCBCKF6PKUVBiwATMnZGksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xyyJnzEo/lPxzlLxikA099Q6hPs+5qco8FYG5OjvVo=;
 b=V6BdceMTUihLFCXfiWdCVxJMpg/3yspMIvWh0LUYaHxpkDhPBLTvDF9sMn39Rqi4xUz8xBq1OVkPIm3H4StcaZlX6HytVHvXyUIFZ/1rBkjVuyv7cnxSbN9qS5MfFpzlG5KhtGbCnyNh6EbshhYRvk0EmG0EZe9l40D2yGcsR3Q5LVqZLC37AlpmaJv6BVy+2PZxoW5SFSxIkeODxfoU423iRNEIt737KJBX3PsGxMajWLFCZ4RlwdFwpVBGFJCXwjyiOBWQx4kIp9mNslofLu00TLg+JeX6pwUVGm2JHAvV0u+UQmIqQJAjcAzagFUJpMW7fQGc3OFDC5WkJH3aDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xyyJnzEo/lPxzlLxikA099Q6hPs+5qco8FYG5OjvVo=;
 b=ah/UU8LJvCW0seOW7Q7tya8s62gjsZr7kxrS5/aADhuRWbhC+GhgQa8J5YjVuDugRvrgpxSlCPaBEjdvTn7n9/IF9ukOfbV5N7A08+HgL6A7fdvemT5ROQqWlIqHc2qI6Eu77rXeu9/7VlJXpUIi/AsYfFOEz4JPfnBRkeqYcP0XQcoF4YlFsXaR6m7G7aq5Unq4u3v8PxGJDdGlB5WPOqw9U6Fpj+7PbkgrZArCQ47qlf5iXZdGNKYXPYLQsvANmtEkpYM8Uv66Ln6GL0DySly/a3Cda3MCB+IdBBwtWfAzrga8lZi6XWsostMrMFkybL7fsEFWOYyqKJFlULfKdQ==
Received: from PA7P264CA0413.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:39b::25)
 by DU4PR10MB8610.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 15:39:27 +0000
Received: from MAD0EPF000008B0.eurprd04.prod.outlook.com
 (2603:10a6:102:39b:cafe::7d) by PA7P264CA0413.outlook.office365.com
 (2603:10a6:102:39b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 15:39:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008B0.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:39:27 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:45:55 +0200
Received: from localhost (10.252.7.7) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:39:26 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 00/14] iio: adc: stm32: add support for stm32mp23 and
 stm32mp25
Date: Wed, 23 Sep 2026 17:39:03 +0200
Message-ID: <20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJfys2oC/32NQQqDMBBFryKzbsSMaGtX3qO4sJOxpqCRTCotk
 rs32n1h4PPg/zcbCHvLAtdsA8+rFevmBHjKgMZ+frCyJjFggXXRaK16Q0rCVOK0YKVWrbCnc4m
 XqmpMA2m2eB7s+1Deuh/L6/5kCrtnb4xWgvOf4+eq994ffbpCEQ9YM5NJ2Q5OJJeQk5ugizF+A
 TOQcOjEAAAA
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
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B0:EE_|DU4PR10MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f9d4a8-6e9a-4403-76a7-08df1988d9fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|23010399003|13003099007|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	B656dG15Y3rIUQkDfReLaFm6Lovm7W7H86od27nonkM5h2oAg21SA8G0FSR04r7f9ST98vAzczNiUElMv5oSNe9C2J4Yc5SaXwIo40duBU3DN7zgO9vuz3ZL0frSbp2Jubygm7xSEduZTmhJzkgkisPeyTj+Rsgf6NfFGDlhpabgpywHyXtuyyi3YbegCxePdPATyz8cIUATUeG7TOOV2ZVGKp1lCMgmGVS1HhXZQcisvxaoYwbFjhXZVFF7q3hwwbMOJI5RAbvP5xqtDBmnczxY6ZPaYCXEApOE1dsgMxDs3+sXnWR2wRNYX9E6gXm4hWbuV+2dSGqM2fxiEbLYKd6vdHw1yW8AaJLASpUndBpX8d4UNdtntTmL2T5SNNi1ojAQmJ7supfhwUMF9cKz6dXdrfHr6+Ev2ltwj5fsAOrrNXLp85EItWfgToSoj7gbupMAIxQ/wwY68zyTVJPb9Sk+9ceOwYQgIeL7aq2eHw8/N/tio7GuhqwlF+rEkUdtuSOpqARCZ0sQAPtOiSmYfCg5wmy1N1gJrO43xINDUNwm1lSfLzs6foDZtg3JhHj//lMquIwytssopPebZmvPYvZQzmgVDWArWLopbDa+7tATQxVPNchK7210+1P9NQZ3Od9WkNs8htWT8oTuEEiapw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(23010399003)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7zOcRsfUXqQjqkExe89vuLaGtZu59rdpANA39ugp2XyNwukMiJ21DCt98NNK+njgGOHT1WjnBLs0ob/xdXHoPDVBem+e9VKbJo0WSWrb9E1zUOqkYChac05/UtM4mktQnfe+7oDifjhxWvpzz7hYcmR2lcAO4RH0moPsVWC3fc4F9p5Um85hh8b5GCVjZvf5Iq56oQiDs8WhPa8J8cQnDOHNFagnLW5ispRrnezbROfFDoZj93rVw56556IyxHUbxZYBG8dV/C1WDrPbA8m62vWcvXbRNYjP62IkVaVvOHGo7BpmTQ5vYYa8SjpK9UR6qeFGHvv1ta/0Vw3cnsqdm47k1sHphNa5ruRskydWpCUiecqw/lHmfyn++xAjawhvxkLtSBlTLqhLQxRsSPKIydv1SCJy0ecftEa9qUtW5LwSYHcJfm2BeOQiVB9niQ6m
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:39:27.2043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f9d4a8-6e9a-4403-76a7-08df1988d9fa
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8610

Add support for STM32MP23 and STM32MP25 Analog to Digital Converter.
It's a variant of other supported STM32MP ADCs. Add the DT bindings,
driver, SOC DTS and an example on stm32mp257f-ev1 board.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- dt-bindings: updates since discussion with Jonathan. Drop fallback
  compatible and "st,adc-trigger-sel".
- driver: address Jonathan and Andy comments and overall:
  - Split into several pieces to prepare the infrastructure without
    functional change
  - Add stm32mp23/25 support
  - Then add vddgpu feature.
- Rebased on top of fixes sent separately, since pre-existing issues have
  been reported by Sashiko on v1.
  https://patch.msgid.link/20260916-adc-fix-intchan-v1-v3-1-b5f05b86bc60@foss.st.com
  https://patch.msgid.link/20260916-adc-fix-div0-v3-1-bedf027a6e7e@foss.st.com
- Link to v1: https://patch.msgid.link/20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com

---
Cheick Traore (1):
      arm64: dts: st: add ADC nodes on stm32mp231

Fabrice Gasnier (10):
      dt-bindings: iio: adc: stm32-adc: add support for stm32mp23 and stm32mp25
      iio: adc: stm32-adc: core: manage clock prescaler diversity
      iio: adc: stm32-adc: core: configurable number of interrupts
      iio: adc: stm32-adc: rework internal channels data
      iio: adc: stm32-adc: add vreg enable option to manage diversity
      iio: adc: stm32-adc: add support for stm32mp25
      iio: adc: stm32-adc: add support for stm32mp23
      iio: adc: stm32: add support for vddgpu on stm32mp23 and stm32mp25
      arm64: dts: st: add ADC nodes on stm32mp251
      arm64: dts: st: add ADC support on stm32mp257f-ev1 board

Olivier Moysan (1):
      iio: adc: stm32-adc: manage characterization voltage diversity

Patrice Chotard (2):
      arm64: dts: st: add vrefint calibration on stm32mp23
      arm64: dts: st: add vrefint calibration on stm32mp25

 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |  71 +++
 arch/arm64/boot/dts/st/stm32mp231.dtsi             | 116 +++++
 arch/arm64/boot/dts/st/stm32mp251.dtsi             | 116 +++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts         |  22 +
 drivers/iio/adc/stm32-adc-core.c                   |  95 +++-
 drivers/iio/adc/stm32-adc-core.h                   |  21 +
 drivers/iio/adc/stm32-adc.c                        | 570 ++++++++++++++++++++-
 7 files changed, 965 insertions(+), 46 deletions(-)
---
base-commit: 182c47735554925da9605dc9dd90a8c15a1bbae5
change-id: 20260911-adc-stm32mp25-v1-2ac7328559d9

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

