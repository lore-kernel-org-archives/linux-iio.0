Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011044.outbound.protection.outlook.com [40.107.130.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE92039E162;
	Tue,  6 Oct 2026 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273495; cv=fail; b=d9NHd1vXMwstt3L+kwcMWSO2aC2V44cROSUf/QRqS5a6Vbc+xsK020jBk4yLf3Gd49rSMTTrrWtgyyFCr+rNjchLBQheDp693f7atFbrd9KXCxQKsmcov2t5zcIa2/rUMGxV99aelGWqYXtu420GDpLn171kDZ8Bf2a45Dn9918=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273495; c=relaxed/simple;
	bh=6co2aMrSDDZQZBuLCJZQqRJwhT2IZ2J/HNqoYzR/lJE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ZBXtt/fxP+JwnuRH710hXyQvKW6R1OTpNrRrCqMMgDoEZKCVuTZ323312uBLRalq/FQPl0N5RuexpzSA6hru1OD879jOwgiXhLCWfj4SmlPakZrKB2k1yhCEL2SbT64XHtXKuW1jhxMsYaOFqjPkQlpFLs1cmhYjCd/R3aQvoYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=JA+HXIFx; arc=fail smtp.client-ip=40.107.130.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="JA+HXIFx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWXuRkP5a/aMq3iRtQSvGSj31X0sBVnDHJimgh7aiDZ2JtkZzm3Fvcb0CrIcBs29XHOpow+uLwtKzmy4N7sYgfuYrK/2oeQgbIo0n+8fuab0S3hDeNDAiKVpJ9dUkYY4HUXZU11SgWKJZ8zHI8QNLieUbgDrjDjmIcyAz1/1carRBzIor8xg4wro0Rezp0k+JGBZDdR6dxVHpFoXbk/qNZhMPYfBF/Ht/vyvAOzrbnjk4LFNukTeCJLT5RvHGW4zJHIwRAnpebpVxFH2MSjtRHfy2XRdt2rqFFWGZA5C3jWtsFjwdwpb8o/4rYMW9MngT1zXRZV1S4EFEMDxfRzIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tjicE9VPF+PU9G85Tx6hdrnKiCBhWyUt27oc1U70xE=;
 b=if2EQWcmIOmCA3xcxb7ku0QBPZb5wuiPdoMlQ/QzDrmU68CPibH8kHiSl3juwcfU35pic8sYiYvSb7l0oJ1SEEx1L0N0tDDP8XBR0VltprI8KqzXfsFSpOMhNjseiZ1nF9pkX7alJcwwR22C6jLRmUBfzWjso95loJcyvAuRiLcBkaxHjmFv0d3S6oLwIVv3LlaZkIUIg8MuwWdgcj85LebBUOZTujimMockCqH5mVSqnCeWHifd1mJM0gblVnJ7bYGHr/vn630z9OYEPAaYl7IEukoQXE1wemaChXT+6dxz3vRu4V+53mpmCiXvUxivOSSsUxyx0b6/+C4Vp6LvXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tjicE9VPF+PU9G85Tx6hdrnKiCBhWyUt27oc1U70xE=;
 b=JA+HXIFxVtbeHNxJYJ8eUHRJQ3fqewsjhGNLuvMMs6PXKXAWLdchMIymDa8MWpU7WFhKSbFPOXsjGn8Tr94kJL/TZcrCh4zxkKxeNZAqee0kjT1z3XtOmOIaOVwaFeEqcVXVM5XxojB15DmbrdfiAGlRPleduqRy/IS1Zs1A84VvttVhLzRw3jn+u88E44XsN2QZt/hPdBHWjxtZ1QMeha1qtSWXQ8X12Y78PXbYYp9s86uNowauEd8a0KZ54FdZxFkn7pDFfNP+Iro1ER83gW0BQ+rYLv0ZI/5/O4kW0s07bRCsIrLRLvDhLRhwNLBGBvb0cF62yD9psxR1t9BSMA==
Received: from AS9PR06CA0070.eurprd06.prod.outlook.com (2603:10a6:20b:464::21)
 by AS4PR10MB5743.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 6 Oct
 2026 07:58:10 +0000
Received: from AMS1EPF00000094.eurprd05.prod.outlook.com
 (2603:10a6:20b:464:cafe::a8) by AS9PR06CA0070.outlook.office365.com
 (2603:10a6:20b:464::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Tue, 6
 Oct 2026 07:58:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000094.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 07:58:09 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 10:04:10 +0200
Received: from localhost (10.252.27.219) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 09:58:06 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v4 00/15] iio: adc: stm32: add support for stm32mp23 and
 stm32mp25
Date: Tue, 6 Oct 2026 09:57:31 +0200
Message-ID: <20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOupxGoC/33OwQrCMAwG4FeRnq20ydY5T76HeNjSTCvMyTKHI
 nt323kRFSEQfki+5KGE+8CiNouH6nkMErpzDNlyoehYnQ+sg49ZgQFnSmt15UnL0CK0F8j1aDV
 UVCCs87z0pYprl56bcJvJ3f6V5VqfmIbkpIljkKHr7/PN0aa5P3wso4kbcMzkY982nchKhhV1r
 UoHRngjAH8QEInM1WRsmWNB7pvANwLNDwITYdwaswyNLz6+mKbpCT1Zd9FKAQAA
X-Change-ID: 20260911-adc-stm32mp25-v1-2ac7328559d9
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Joshua Crofts <joshua.crofts1@gmail.com>, Marek Vasut
	<marex@nabladev.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Conor Dooley
	<conor.dooley@microchip.com>, Cheick Traore <cheick.traore-ext@st.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>, Patrice Chotard
	<patrice.chotard@foss.st.com>, Cheick Traore <cheick.traore@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000094:EE_|AS4PR10MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 4159e29f-cb3e-4b06-c576-08df237f901c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|23010399003|82310400026|10067099003|260925021911599003|260925021311599003|11063799006|56012099006|260925022911599003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1EbjTkVFUrRIxpRYcN8tX8giYCHRDTePzb3FowaUuOEdi9SWpjojGBbpivLaP8OQIY4Jo03DUoF/Kk+l3nZfrBazPangsAJX6pJESlX9s0SXt+FfFnhLpBOC4Sii9SJ/1neL75xGhmnLJHzZAMRMixsR7kJ9WQEsT1aoHKfrZn7VFMNgYZ2f+mu++o11YLmnXNYXAPWsmpTHt0cdv6lsSIdeGXxHie6f5vJ2MdpWqqFa/8I7chO3peNFU5GtDNEGYzzggNxkE9p0FXJqs57aDDb5kMBF8MH93UaVaxfgTEKv8JIY9fUhtYbMZ7KvviTJWOPYW7K4IL5/cKuJTEuR5JYiTsgYl42G6rtl9tBVjy976pvQuPRXv+U+ubnirkcA6OuU7VYSLybMlWCTUp0TLK1LzcDjm91mT/vQA4S67pjakGKVaqQnzv3hBZSqA78fqeUynSVQcqpDjKRsh3ldjR1pJyKDg7r2kOiEkMkienUOkIWWWp37FiN6X8swrjxDbnzvA+KSPlDZvfF03H3OYqaQBqPoifhmc6DeeqlJ0Mwb/VDACS1PozFd2IJWHC2iH3RYGAqK9UG3ba5pVmCb+FtQEgSCrXLUsQCXj38r1GpUMb2Rzwb5BIxuEU3XphkRyu2d3xz9E95z4Bv0tRe2fuiK1yn5f4diOgLq/44AAmU=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(23010399003)(82310400026)(10067099003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(260925022911599003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Eiu2gERqaAte6nEAlgqeSJpj9gGmNIgbpzsVEPBpp2KmtuW+pnhKm7ftDnvCI5LXWMPvP8rAUJv9zSpcpvObwEN1dlSouT85ahT/8t/S8tJX/aaEjFhFFuXtnsB/ZB7KdlhIBE8Jl2RbYYxV44iJJ3Z83FUzdRvb+pKSQBA/rVYwphqRjhZib7E2l/RtSyuu7AaIiFCNrkz9lmc9n3z+/SAaD/ohfM2d/DNElkRfqley6OkRng6+tf5k+ORPK0CcMeNCrIdF0iqRVYQiOntge6yttZc3JteNGwKlkYBxOrduwEdC0zPGiZlOHqmNjQhnX9GS/bu9EmpzWfFJJjX9lMuD4O2lzVsdviB1wnXSBAE7t5lTPeQfznfWhwhpAg/JaUPri6xMKU3a7871Eo4IeBS4QGJfjD8tjBYFaPpI+C7QaXTTbsWvPH0FOV42jKu4
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:58:09.4651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4159e29f-cb3e-4b06-c576-08df237f901c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000094.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5743

Add support for STM32MP23 and STM32MP25 Analog to Digital Converter.
It's a variant of other supported STM32MP ADCs. Add the DT bindings,
driver, SOC DTS and an example on stm32mp257f-ev1 board.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- Improve differential calibration routine since Sashiko comments
- Use mV SI unit as advised by Joshua
- Use const array or structs as advised by Joshua and Sashiko
- Add collected Acks or Rb from Conor and Joshua
- Link to v3: https://patch.msgid.link/20260930-adc-stm32mp25-v1-v3-0-406834430d72@foss.st.com

Changes in v3:
- Refactor the calibration routines since Andy comments
- Style cleanup since Andy comments (added one precursor patch)
- Adopt field_prep as advised by Jonathan on patch 2
- Rebased on additional fix that has been applied separately
  ("iio: adc: stm32: fix minimum sampling time values")
- Link to v2: https://patch.msgid.link/20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com

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

Fabrice Gasnier (11):
      dt-bindings: iio: adc: stm32-adc: add support for stm32mp23 and stm32mp25
      iio: adc: stm32-adc: core: manage clock prescaler diversity
      iio: adc: stm32-adc: core: configurable number of interrupts
      iio: adc: stm32-adc: rework internal channels data
      iio: adc: stm32-adc: add vreg enable option to manage diversity
      iio: adc: stm32-adc: preferred style cleanup
      iio: adc: stm32-adc: add support for stm32mp25
      iio: adc: stm32-adc: add support for stm32mp23
      iio: adc: stm32-adc: add support for vddgpu on stm32mp23 and stm32mp25
      arm64: dts: st: add ADC nodes on stm32mp251
      arm64: dts: st: add ADC support on stm32mp257f-ev1 board

Olivier Moysan (1):
      iio: adc: stm32-adc: manage characterization voltage diversity

Patrice Chotard (2):
      arm64: dts: st: add vrefint calibration on stm32mp23
      arm64: dts: st: add vrefint calibration on stm32mp25

 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |  71 +++
 arch/arm64/boot/dts/st/stm32mp231.dtsi             | 116 ++++
 arch/arm64/boot/dts/st/stm32mp251.dtsi             | 116 ++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts         |  22 +
 drivers/iio/adc/stm32-adc-core.c                   | 104 ++--
 drivers/iio/adc/stm32-adc-core.h                   |  21 +
 drivers/iio/adc/stm32-adc.c                        | 602 ++++++++++++++++++++-
 7 files changed, 992 insertions(+), 60 deletions(-)
---
base-commit: 7b05d04fbd3e7aa3380767122eba0b3df2882ede
change-id: 20260911-adc-stm32mp25-v1-2ac7328559d9

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

