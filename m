Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795015087;
	b=gRs7vcOAJnwKh6DFLdmVFYFXL0BzwCihIN5oagcNphazFXFOqxErGPKvtVvEA5wsFaFZ
	 qqamphjwv8mswjEBS40LdImQMuD6qr/bP/+kRpkNJzuBjaNDzrE7MxY9olIfDmlGweA2p
	 fECIm0ZQAopvNUjEl7LU6Z2WBnq9RbtiR9/IBuL0Ew6FUtOlmuVHjPxSVbNL9P3crtIYy
	 ROPjY7SDJY5lDy85mXwrdDbtTlcBcIPt031m0ARAxeKD0wPUh/4VW9LVX9ba9SF72NTxi
	 1crInb5oBMBXgyoPFTvxAn06Ld5E4c/tCf2Qy4SRKCx7/vC6+5qZp8bEe9GRf7nyhtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015087;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
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
	bh=e3Tbz3OqGoB1JDSg00/T9UbvXiLM4AtiVRmzqYryQQA=;
	b=PyWu4ZeS8DV7p8b6Ns5Xt9Zg0uZKydLYJGEulUkeldldIK1ReucddlhbCVRkaSdVhYfJ
	 1KStQMbucfrq7tGPTyRrLdPPPw9JdFIggOlubv6m2AR1t4Td/FXsg5GYTjt4jYKdpEUaq
	 vgOstXViSvoL+5HOth8ibmxxE2Ll4zYg1jPlePiVTSHWGrusV7F+wgjRiBCOkxePyuWnM
	 TBZBsF7MpSswmI0ZraMe2vN69Qq96tOrF8BtKJTJaiJe/vOI88gEtLmF1+BLX2fWiPMoB
	 fGJ8W7kYn/XkHbEiEhRAsba76yTW/Y048DLK3isMSNjsEKmxRKYzbfQ3Hl7GjeF3e4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b="E+W595a/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.9
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010009.outbound.protection.outlook.com [52.101.84.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE172606A320;
	Wed, 18 Nov 2026 15:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE172606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=E+W595a/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+87gKyhkZku4qUemYTMziW7zc2GGJwRHTP2UpKe9QgsPKNersvnozgIQI+MaMOv2HTNXFYaYR06AdzfmBFHdTfvGUFe52YZZzHk/AImO7RkGHE7h4KZG7r2Wd++Y+w1YFI6TwD8RL6kCdRjsSM2eanBct95IMmaoDxFVWy8Eu7fRp2BtBoyGOmae/A0TxLJeY6Xy2LL76KuVR7YQPJs6evPtTowmWNUNByyMTA2sM4bqnk/WqrOPsWFvJluTi12zVXlBBPfm0CEVRn6wgU1dFwQrWkOnyYFylEaN5+DUSA5n0U+IA6HatzkW51qkHdUW25hRtUMkLDJ0OmBeKRedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3Tbz3OqGoB1JDSg00/T9UbvXiLM4AtiVRmzqYryQQA=;
 b=hzyX8zJ6V+qSQh4n1HbQduwfBVz11g0LNQDspham8IipsZOntLwPDyi9fVpoRfjWfiQooH73vXoDYOPx3DZ32rF/mOj1/uO0+RK4Sk8lFrwUBNWjS32K0KnMHV9GxpZGpjAUqvQfO+PSYTtOP55DBO5hCt1zK3v1ECRVWZbOtpTHe1yB/lpfJQfhT1jrcO1bVGHnGaspvTLizq49mfbd1Zw1kZHuiXojKYsDxhpi+/QyHH9ipQeSi4B3+kT8aIHubf1zwlsc8Oiivxp7OVj+ZJgKB0wwYbCRkWAUCW4/EuXYd6uqaHijhjc4d5Ag5zp3lASKnQV+0EtAq4dCj7YnAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=amd.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3Tbz3OqGoB1JDSg00/T9UbvXiLM4AtiVRmzqYryQQA=;
 b=E+W595a/7FLGHpfiWqqMMSDAgMMQXSLsHw4Cz0Zj2P1FEU8MPqaEDqsuOf8O09RQcIw/Wvswpxjx5q4erpwnSZat8uv7In7BXk5y5L8Cl5Qey7q5/HxwHiMis4w79EI8gR1Xxy3kx6PYarPyGYEFgF+vewgAajqpGQXk7dl5tC25prZzE7MHmf2ICH2BdapZFmi7G5+WmC88n8NFo1BkADSrUuOJaNMjBAvWVXwWF9OegodztRO6N9KMTBIFVrm34tjr4oGlXjaVHbZufOIV5TyAsZ09jMQQv6gvaWAwlsNUcwUgzLoFwMG4L9GxjNVEp7NV1EnMxgUsUUgaBXpNQA==
Received: from DUZPR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::13) by PA4PR10MB5587.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:261::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Wed, 18 Nov
 2026 15:18:01 +0000
Received: from MA3PEPF00000408.eurprd04.prod.outlook.com
 (2603:10a6:10:46b:cafe::7f) by DUZPR01CA0025.outlook.office365.com
 (2603:10a6:10:46b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 15:18:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MA3PEPF00000408.mail.protection.outlook.com (10.167.241.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:18:00 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 18 Nov
 2026 16:19:00 +0100
Received: from localhost (10.252.16.78) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 18 Nov
 2026 16:17:58 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
Subject: [PATCH v2 00/11] iio: adc: stm32: add mdf support for stm32mp2
Date: Wed, 18 Nov 2026 16:17:45 +0100
Message-ID: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
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
X-B4-Tracking: v=1; b=H4sIAJnB/WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Mj3dKC4pKi1MTc+NyUtPgyI11zMwMTgxRLS0Nji1QloK6CotS0zAq
 widGxtbUADFPvYWEAAAA=
X-Change-ID: 20261112-upstream_mdf_v2-76040d99138e
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
X-MS-TrafficTypeDiagnostic: MA3PEPF00000408:EE_|PA4PR10MB5587:EE_
X-MS-Office365-Filtering-Correlation-Id: e50d67df-9264-41e8-5d8c-08df45872233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|7416014|261028144727099003|261102123227099003|261102130727099003|261021135927099003|261021123027099003|261021121427099003|261021130227099003|261026140227099003|261026121527099003|261022115727099003|261022075727099003|921020|11063799006|261026130827099003|261022113327099003|56012099006|10067099003|261022105027099003|18002099003|6133799003|261009221227099003|261009223027099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	0VNCwyNBkK8hflG+yFL/FXEl06eQdRzwUYClVn0XCkfaGsweLbuuDsEvnyhyBMjk7TlLkN4aaaC+1ImvPXbp1uCXc4jzwuoIV+EhBbdzJ2z9sXfB4jmle6EI9NXZvHbn66kjh6ipDHKma4e1BFjqKBoDR1P0hmzdImrvfiDKH14COoM6laOysjjQeLoRgkdzSZLVZbuwvD9+qKOoRFhzlJMrD+r6OGBAMFZDbzlCvRSeSIuTvxqb0w0+eGsRjiow6dZ60RMcUFOU61kpbt/4dWiQhUSjjpjuIozPed9bES6rHTBH2VNjABW7oRYo6geimXwxNG1T3ZkhHTNSClN0zVe4LEql8GSGnykuOc32K4Cwaaih4KRAN+2TyTi2CvTofo+tatOSAv4+0syODhtq9PS3AM28MuK3tRNA+JenFldlME1ryz4zNISwWZCZIvLADe3C9020WUVDxLS2kuyd7bPgSpDs0WAvgcKBfwmV/x+9NxVGOjEwWl/UYTTwfPIoq/aVuIvt6WoevZGfttzk90skBCw0GuOkhwUY3FkDk/X76DV9gjApFeAhvaNhqIk3um2RtxG92pjeIyw6Rw8I99oBi6n3cepZDIUyoYxSR83KbMNEwGj3wt135Gjx7Qs1EVhChrVuqkfgF49Wqr7SDabNASnH9AUpu+uoZLBYnbDpPuedLp9FdEhY0+Im1CLPUQQujtDcyVAtfF/244l3sw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(7416014)(261028144727099003)(261102123227099003)(261102130727099003)(261021135927099003)(261021123027099003)(261021121427099003)(261021130227099003)(261026140227099003)(261026121527099003)(261022115727099003)(261022075727099003)(921020)(11063799006)(261026130827099003)(261022113327099003)(56012099006)(10067099003)(261022105027099003)(18002099003)(6133799003)(261009221227099003)(261009223027099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WAOWp0D/K0DrHpsfg/3tc+yCCvrXJ71zz3+OK8Cg/Aukt8vmTj3G2DP7VD93vA7vcB2V9klO5XFKz6gwYU3LmSNWwJFn7xeWGcoPTFT19OtH+D/FhZg/gMJOkMQJpcykMpZrEN/ho/i7pm3PbIEhRSKvE0ObExDLO17lbxVdnxFE1W9CKV252vz/H5IExa1+LrATGI+cVYQwFgHeZZO1Y5GUltgtZBzV2SX6odvZZD3l0x3fkZUEb/IB1K6/+6pc0MOksZSTGVbemdrIbktsWgxFLYUZE/lTxn35KzfN8q/cMqs+DMC8I6Sb3EWAXmJXuNvNjG66tV9Aahsf7O8G36u1ENFlxFMHRfCep0N5hiv1U9TZsf1dvFM5e2cfETEclmRweIMktljmJOp9WsqBzkCNZs7/0x2viWFx7dH4A+vWHt37hG4cvXzCbQe54Zkm
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:18:00.5456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e50d67df-9264-41e8-5d8c-08df45872233
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MA3PEPF00000408.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5587

This series adds support for the STM32 Multi-function Digital Filter
(MDF) found on STM32MP2 SoCs. MDF converts bitstreams from external
sigma-delta modulators and PDM microphones into samples for IIO and
ASoC consumers.

The drivers support direct IIO conversions, cyclic DMA acquisition,
CIC configuration and scaling, synchronized and interleaved filters,
and external timer triggers. An ASoC DAI provides PDM microphone capture.

This revision addresses the v1 review comments listed below and splits
the driver patch into smaller functional patches for readability.
It retains the existing IIO backend interface for external sigma-delta
modulators, pending agreement on the preferred abstraction.

These changes do not resolve all v1 review comments. In particular, the
frontend/backend architecture, DT child-node model and complete clock
topology remain open discussion points.

* Open questions: MDF topology (backend/frontend)

In Analog Devices use of the IIO backend framework, the AXI ADC is a
hardware backend, while the AD9467 is a hardware frontend. The external
sigma-delta modulator is actually a hardware frontend in the MDF signal
chain. The difference from the AD9467 use case is which driver owns the
aggregate IIO device.

Option 1:
One option would be to generalize the existing backend abstraction to
represent components contributing to an aggregate IIO device,
independently of their position in the signal chain.

The existing framework appears to provide the required mechanisms. None
of these mechanisms inherently requires the provider to be a hardware backend.
A generic component/provider model would support both topologies without
duplicating interfaces or requiring reciprocal dependencies. The key
point here is to preserve the compatibility of APIs and DT bindings.

Option 2:
Alternatively, if the backend abstraction should retain its hardware
meaning, we could introduce an explicit frontend-provider abstraction
sharing the existing infrastructure. Frontend operations would cover
analog-side control and conversion parameters.

Would generalizing the existing abstraction be acceptable, or would a
separate frontend interface built on shared infrastructure be preferred?

Option 3:
An aggregate IIO device based on the component framework, as discussed
in previous threads, could also be considered. I currently regard this
as a fallback solution:
https://lore.kernel.org/all/ec411432-4b77-4410-b0aa-b29f73b82c84@foss.st.com/

* Driver implementation

Serial interfaces (SITF) are shared resources managed directly by the
MDF core and no longer have separate platform devices. This revision
retains their DT nodes to describe configuration and clock connections,
and to allow filters to reference their input bitstreams without
duplicating shared settings.

This revision also retains a platform device for each MDF filter, as
each filter manages its own registers, interrupt, DMA channel and IIO
acquisition state, with a separate suspend/resume lifecycle.

* Clock management

Several clock-management review comments are addressed in this revision:
- The provider-side clock-frequency property has been removed. Consumers
  request CCK rates through assigned-clocks and assigned-clock-rates.
- The clock-names property has been removed. The core acquires its single
  input clock by index, and CCK gating uses regmap-based clock operations.
- Remove the unused clock-ranges property, as the core now explicitly
  shares the kernel clock with the serial interfaces and filters instead
  of relying on parent clock lookup.

Clock topology point remains open, awaiting clarification of the MDF topology.

Changes since v1:
- Split the large IIO driver patch into smaller functional patches.
- Replace provider-side clock-frequency with consumer-assigned CCK rates
  through the common clock framework.
- Remove the platform devices for serial interfaces.
- Replace the interleave phandle list with a filter count, covering
  consecutive filters starting at filter 0.
- Simplify clock-output-names, remove clock-names, reset-names and
  filter-level clock properties, and move mdf-dai into an explicit
  property outside the conditional schema.
- Rename the binding to match the STM32MP25 compatible, sort compatible
  entries, and simplify the binding patch subject.
- Use unsigned long for match data, improve probe error reporting and
  wrapping, remove a probe-success debug message, and add kernel-doc for
  exported core functions.
- Use scoped spinlock guards.
- Remove empty serial-interface runtime-PM callbacks.
- Remove the redundant ASoC platform module alias.

Additional fixes since v1 (following Sashiko review):
- Compute the settling-time discard count with 64-bit arithmetic.
- Size cyclic DMA periods in complete scans and validate buffer and
  period alignment before starting DMA.
- Fix backend-enable rollback so backend zero is disabled as well.
- Use managed allocation for the conversion buffer and managed IIO
  triggered-buffer setup.
- Release temporary synchronization and serial-interface firmware-node
  references. Replacing interleave phandles also removes the associated
  stored node references.
- Avoid unregistering secondary interleaved filters that were never
  registered as IIO devices.
- Use managed acquisition of the optional serial clock.
- Replace the GCD-based CCK divider selection with a search for the
  largest valid divisor, allowing non-power-of-two divider values.
- Remove the selection of the undefined COMMON_CLK_REGMAP symbol.

Previous discussion:
https://lore.kernel.org/all/20261001145702.2628429-1-olivier.moysan@foss.st.com/

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
Olivier Moysan (11):
      dt-bindings: iio: adc: add stm32mp2 mdf filter
      iio: adc: stm32-mdf: add core registration
      iio: adc: stm32-mdf: add cck clocks provider
      iio: adc: stm32-mdf: add serial interfaces support
      iio: adc: stm32-mdf: add digital filter device support
      iio: adc: stm32-mdf: configure cic filters and sample rates
      iio: adc: stm32-mdf: add direct iio conversion support
      iio: adc: stm32-mdf: add dma buffered acquisition support
      iio: adc: stm32-mdf: add external timer trigger support
      iio: adc: stm32-mdf: add dmic audio filter support
      ASoC: stm32: add mdf dai support

 .../bindings/iio/adc/st,stm32mp25-mdf.yaml         |  341 ++++
 drivers/iio/adc/Kconfig                            |   29 +
 drivers/iio/adc/Makefile                           |    3 +
 drivers/iio/adc/stm32-mdf-adc.c                    | 2080 ++++++++++++++++++++
 drivers/iio/adc/stm32-mdf-core.c                   |  899 +++++++++
 drivers/iio/adc/stm32-mdf-serial.c                 |  223 +++
 drivers/iio/adc/stm32-mdf.h                        |  275 +++
 include/linux/iio/adc/stm32-mdf-adc.h              |   19 +
 sound/soc/stm/Kconfig                              |   15 +
 sound/soc/stm/Makefile                             |    3 +
 sound/soc/stm/stm32_amdf.c                         |  375 ++++
 11 files changed, 4262 insertions(+)
---
base-commit: d922ed738439e1d5b4701df7f4cdd49a09925624
change-id: 20261112-upstream_mdf_v2-76040d99138e

Best regards,
--  
Olivier Moysan <olivier.moysan@foss.st.com>

