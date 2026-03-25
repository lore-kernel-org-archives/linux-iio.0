Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023133.outbound.protection.outlook.com [52.101.127.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE49324336D;
	Wed, 25 Mar 2026 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422396; cv=fail; b=ie4zsj5j+6rB+Z7G6Gi7K2+eNXD8cygMX18+CacWk88g2zRL85n6Ynieoeb6sg4anhSXHoy+wRJfEXKaZRFj9mypVBQeZ6Ttn+UTSWYqM3u30JJvYcwmKUDW7POM7bOb8tJYrgNWMzfIIdRVdNzes/Qz+haSN3mFH171xa8QxtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422396; c=relaxed/simple;
	bh=Ou0/4pbdMStn5kQgkEseZZHu7lpaxlj3JdiHCVntu8k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RooGbGCY+YaDy7NG0lDQVxDlpOGMNMCNb8y2I9r/4FuLwzdbAvraejUxYPxB3uevVR4v/Z2e61mC4YbVjpc9tVGcxPglE24B0yRKzIQ5/mvO3uNflZgnbcRDv8NloZggyfWAklccbtE44Hrz0eUWltXU/S1RXRUy3dBblOE0C58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com; spf=pass smtp.mailfrom=khadas.com; arc=fail smtp.client-ip=52.101.127.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khadas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tETagZpcgDZsniFA+aQsnMT9p6FHFTLaBSuh2WjzIf9Si2gjTNNQaveOkFNjmz9XiJuovu0e/0c1Wc7Ettxu8l/mO03FaDj3/EaCIWGX4DB6FBXW+FdmhkSaUW/j6fgkT/v+uicchr6sqH7E22pBg2UBg3UA2jntw6DJ0HxWKTp+htnfgZUEtp6Vw5r8+giIe2tIBEv6bxc89r+TFqnYFXtOvJj7lLwh3CmbWKTCcykyXJz4w2TqfT6xUV8jsD8SoT8VTlCE6bTD3D80XMBqB+IAGeRGw2iWKeO/0uMSjd+PoBKqfbk2lTudiV4eAJp9El93X5Y1eQ2hXwuBDa/vcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sblz28NqA37G9gRLuwRnOFDmuhTtddWzYagJgSajb0=;
 b=rOyNKm5qcZtkSIrpaypA1p7h7JDAGJLTOTalPxPj6CPLYn7b5Nqhntfk+ECvK3iRW2tGKMNl1CrDFrIvkUKKREUe5MXJ4iGSpD4S2fyIYIHTX8PlEZi8PbXSTUefI8cDzMJJjduYTTgezJWSqC2B3s8YqWX4EaHJCjaUY9fns8FVDRzHDz3NrFCw0V2q/VVkNQ8PJCvGiBhXB7USuexLYvr6SiZJvPkLhlJq2pTigwxJ1SClRj3KDec6Nh0wvX/zwaZWbzCXp152nnP/l7yLQiLwi2Zgdl5NFn++rViiZEyP4FEM2gRUXJVfa50DM2Dhgtc6t4+ylfSPP2InQeZ0Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=khadas.com; dmarc=pass action=none header.from=khadas.com;
 dkim=pass header.d=khadas.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=khadas.com;
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com (2603:1096:308::2da)
 by JH0PR03MB7343.apcprd03.prod.outlook.com (2603:1096:990:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:06:30 +0000
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549]) by PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 07:06:30 +0000
From: Nick Xie <nick@khadas.com>
To: neil.armstrong@linaro.org,
	khilman@baylibre.com,
	martin.blumenstingl@googlemail.com,
	jbrunet@baylibre.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org
Cc: krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nick Xie <nick@khadas.com>
Subject: [PATCH v3 0/4] iio: adc: meson-saradc: add support for Meson S4
Date: Wed, 25 Mar 2026 15:06:14 +0800
Message-Id: <20260325070618.81955-1-nick@khadas.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 (2603:1096:308::2da)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PPF62EEA9B1D:EE_|JH0PR03MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 24512e9e-17c6-43a5-9046-08de8a3d0a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|7416014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	oLzjnK2Rq287Xk9Nihy71LPOA9VhGOzk3dWlA84ClO9YJJieRzwc/SoDJuw0pBn7cNucsAFTOnbsfQ0pz64yi0DsDaZIYijoRcww0dC3gRAYdcb/npds3ovsZo0Eplm5b1uCzOqKeR4UUu9NB1VC/+fEo/D92T2krjGHm4zRq2orwZMRU9K36rK2AjjB/5CLj8ulvMvDq69lUmEssqkYwVsmG4IgHCTDUaJTcoNWAG2Lyvca/e+6g+FpcMOCGMArbKIaSjmzkvGEsWEAIVd7FtdZgdoQJmN/7SR5UHnK2rNae/dvM1TbmoicpBFAeyEltcfe6s53P+aajXFZGBzVxZo2z8GW5/VIFFrcMeSX0EBlZycgjSYmITu4ZEQhgluGdWWxhSOE+IHIVb4KNDVr4jcjKIEz602qJqKNAXTHKIIFNSo5bZmR/5FmBMbzynjgycWKqZ22Kzx16V/JJYAA6wZNMvBWjAvBUAkzcvbHv1vBuEadVYhesmvvQcMhTxY0bAbY7XTj2PaHW5WMttlGz+fDrBladCIKZXOcKBGfhQz28Dp2SVSuikGKEsOanIO41000JwAiLaRWYjuxC5pYmLQF42yWE3TqqPm0sncxlwN4Nb6WurAdc0Jnd+GdXB1ARiOwMGrFccj9wv50colSCbsgjK1HQ7+0j0sGQI6LQoLz/lob0GZgIXYe8ZadtinxPh/35yAeEWqfDIWaLELVPauBDBR4BGOuJwTRloHGEI1wAx6Kwq1Azbs05GE8a+XuDCsYz2Nd/M03tENSMqNIMEzUW77G0DPxcDaX6orTgeg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF62EEA9B1D.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(7416014)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xp10hzy+EOo/Nf4xfPE0tb2GErVCbfAMfNzfFFd8+gI45fsur6Vy8+tpQoqG?=
 =?us-ascii?Q?xbCCMl1TgJBHKYaOIrOS39ayPmWxcZDfEWnfbW12en4NdfjAtF8qZeTWX77B?=
 =?us-ascii?Q?ohiGUJ+fiWBY4q2YEbKO4ZfsjfFls5dL8oIagw7ey6shKRobq+axva5ANIWy?=
 =?us-ascii?Q?lNBLjRkCborejGAh2UlJvJvDeGjTeryu+j2mwwmPPGz0yHyZ3BhKHGIDXnsQ?=
 =?us-ascii?Q?aS8q0zH1BpsPrTAmZWYoqmv1PrJ3xKW+t4Wpw4lk1Iy3HwYQDQt0w5UHbHRO?=
 =?us-ascii?Q?Z8oE2Kzx6imj7Bs0CTOORYUnMmbu1aZUYx8hWVkfs1MqCHyfV3jw31ZaxsnW?=
 =?us-ascii?Q?qeuOmm0nTaOhjUTWp7VbktYYSII7faqxLaBVMxSRN8fXfCMby7Ng7FXZUK1l?=
 =?us-ascii?Q?isn9cEGWbH7M+MA0+agQBDgDdEMW0jDIUcZVJPoyMJA26+jZZAQAuzYh4El3?=
 =?us-ascii?Q?wIf9AkfxK3Zvzlyj6Etb88gEYY7k3FGxdSnH8Hz/YQYLQOqyKdNIj4d/SzT2?=
 =?us-ascii?Q?aaDAnT7QQj/HhOQ1z1kJLpFUSfy490FzR6PmZgJe89v2bK0sgE9w1DhjpCla?=
 =?us-ascii?Q?9RHYmTfvsohXPXKsa8qAC8V7w6cj7kLWAEcGIxP1J0wumPEUtpCxKr8Onbtl?=
 =?us-ascii?Q?AhNVo4h73pS02kTFIqQFEetpcyF+M/nUC+NkSpXUefglaxaOWaifErrecmoL?=
 =?us-ascii?Q?ziot3c8lPc8+j8HG4dBUdZSpA8MYuhStla9v6rUMwzqQUrAhkfQfretd1mUn?=
 =?us-ascii?Q?9lzX98QAydH+op5HsAkGoEKWFun1P7BTB2YzBMVv9ND6keUYJSMJKybzk344?=
 =?us-ascii?Q?3mnldOyM6HKizSctKErk0BdkBFxNHq+XNT450mIddlyBfSCgHbODQay9OwTL?=
 =?us-ascii?Q?Wau5MwqlbNCg7MhCD+yPfH4NK1x0KsCOIUc70DfyxbTI7WqfrJwFXjzIOYQB?=
 =?us-ascii?Q?CYrj9qCT14V66qT7TN76HpczpCFUGumnI5suZqk4e2qushGEIAm8HCEuQ346?=
 =?us-ascii?Q?g0jEe+esozSekys3RolMAETdjUvjLFLRBe9WKYlcCpE6h3kI9lLuzETH0VmN?=
 =?us-ascii?Q?OYBaJD62a0pj2S6o058V7Sp+9ex39yq9UXmDU/lHS2J6CEHR4U540sZUQDyJ?=
 =?us-ascii?Q?Od9aC9zdTjpvqyNfSgsh35vQMbB2bGJRzAw3TeXo+MmTxq1FiKl7L2SgIsjc?=
 =?us-ascii?Q?T2nPt7qMrZJFntO9HlRZekKpC1LU61A8V1zPyiVu0hSyJiuqQ1+rXl26DTlb?=
 =?us-ascii?Q?ZETwILPnvmPlhrooMnuVAdrjG7Zm9ac7jv80dxQZ2+KlAXqta2DWdPRMON3y?=
 =?us-ascii?Q?JZmyINa2rb1p85/XhefDp7qNNrKeXpp9KXdwb1Nb3MRhmUeGd7DvfRs01mEX?=
 =?us-ascii?Q?QexrQfCBkiyOa5AAxuyvyg72dhHXlT8E4bdeJARbXfk3QZK71aUqro9GMXr6?=
 =?us-ascii?Q?ChzzMHfm08Vsj+92Rv8v2MQPbJnyDdjJokF/f2+yFyOJc52q7ucZlYC7rqX2?=
 =?us-ascii?Q?+DbqwmnAJ+HPAwCDLwttiszZraWZNQUkfWORrnMEhYwL8j1cwdAaksLH1tPi?=
 =?us-ascii?Q?s7t6gEjCMEt0Oa/gkenQimsvkGCdnwhaxVb+r2sKEv9PQnKb+/68TZNZdNZH?=
 =?us-ascii?Q?0DqzjP25nPGzF+ell5nP7zTrRmhEGIGVUkFYTAOWhqHFtADA8xE+aeo/hUt3?=
 =?us-ascii?Q?ded6RivouTrgd0kE8qRJfqTyQSIh9BoRQur/gD3wpnHqsY0X?=
X-OriginatorOrg: khadas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24512e9e-17c6-43a5-9046-08de8a3d0a32
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:06:30.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgHcPRxZlOlfzKoLnFJ8fYAGmBcpX7CfrkkLkZLScqYt4EogpUFQRvn0jfDr6qDO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7343

This series adds support for the SARADC IP block found in the Amlogic
Meson S4 (S905Y4) SoC and enables it for the Khadas VIM1S board to
support the onboard ADC 'Function' key.

There are no known hardware differences between the SARADC on the S4
and the previous G12A generation. The S4 bindings utilize a fallback
to G12A, but a dedicated driver match entry is included to ensure the
correct part name is exposed to the userspace ABI.

Changes in v3:
- Patch 1: Updated the commit message to explicitly explain why the
  comment regarding the generic fallback was added.
- Patch 2: Retained the driver patch and updated the commit message to
  clarify that the dedicated match entry is kept specifically for
  userspace ABI naming purposes.
- Link to v2: https://lore.kernel.org/all/20260323013408.429701-1-nick@khadas.com/

Changes in v2:
- Addressed feedback from Krzysztof Kozlowski:
  - Updated dt-bindings commit message to explain the hardware compatibility.
  - Separated the S4 compatible string in the YAML bindings to ensure it
    correctly falls back to the specific "amlogic,meson-g12a-saradc" rather
    than the generic "amlogic,meson-saradc".
  - Updated the S4 SoC dtsi to use the correct G12A fallback.
- Added Martin's Reviewed-by tags where appropriate.
- Link to v1: https://lore.kernel.org/all/20260228065840.702651-1-nick@khadas.com/


Nick Xie (4):
  dt-bindings: iio: adc: amlogic,meson-saradc: add S4 compatible
  iio: adc: meson-saradc: add support for Meson S4
  arm64: dts: amlogic: meson-s4: add internal SARADC controller
  arm64: dts: amlogic: meson-s4-s905y4-khadas-vim1s: add Function key
    support

 .../iio/adc/amlogic,meson-saradc.yaml         |  4 ++++
 .../amlogic/meson-s4-s905y4-khadas-vim1s.dts  | 19 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi     | 14 ++++++++++++++
 drivers/iio/adc/meson_saradc.c                |  8 ++++++++
 4 files changed, 45 insertions(+)

-- 
2.34.1

