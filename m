Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022128.outbound.protection.outlook.com [52.101.126.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFCE36402B;
	Wed, 25 Mar 2026 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422412; cv=fail; b=UCjziZVQtRjjWnNGuVtYaSA/o+tjDqM/bSyUwpqQWhVqO5e1tp8fmx9u8BcjtzLHNH/pPCBgVoROxOyY8q1h8+MkBnMJvr3zLhTNpUDPe0Sla320UabJA65UlovFflUebG2bF1FjXDR5JQy5fH2HciUd6qpzpN6L3jendtqHD0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422412; c=relaxed/simple;
	bh=bnzEMzJxjN6uzSG1fQbjbJYdvyz12AWoecLmXiKWRzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pNK8tLDvenLwgEe88wjFEs7mQqg2smkJh3kA6GOAy3oMM9VmXx1Ozy74Wh/8vEUrMmz2NzMdnck95ameY+b4cszB7FxgPz9fUuQKZHWKbdx3FPS/4EFygxAv1ECmnIoH9ik6mYK5xcwOe7U9rTqgUGKkZsEh8JJDN0fNlXmT6Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com; spf=pass smtp.mailfrom=khadas.com; arc=fail smtp.client-ip=52.101.126.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khadas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A521upQ5iiIatkBxI60pEoCHAohC0BXoDd1aWrK7ASA9Uzgvy6lPsqQsFjPbMfGL8pbFYyR5WvyD1/F+4hY+1PbajvTzbUtjbu/pa5cHp5EoLZUZEuOx7kt8IQJDmJNPDJb4CLAXLaZSswtxgcFT9NHW/MP4OIu61bYXVvhp4Y42GtDrmlqOfRQnCchP2duAjnF2hCOVWS6hSLPmNcZrGavky4rpCsiadKLsx0Fjp064n2MKYAUcM/9nDAYyTc2bTMJ1TVGw3NTmrByxm2T/DwQELdLgPFQvrKPgpiMOpdxzikIswr1oVT57V7U2KoWEv2q4/s8+MaU9xGBKKUd5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzrCrJGjR3PmypvsGDuvaTqbL3Ye4CBqJdbul5iQIFo=;
 b=iN6n3fkoemmNiIBHkXd6JiQzQweO8q38BJ1tNDvRgeOlf9fvhOf4DOY4/iHfJFO5dA9qpKuNmlVQFPNN+dCX0qqU5NcER9i/Uly/2OE3+nz91RqEX1Pmf2qeUSWAaNfO6mMqBx40Gmrvkylo5dmGpJ8mul+umI/J+HbJ6p5PVJQNyGMydWztbLgdEeLHrPzyUl47lzQGsDlUsGvLk2GhzOFa40ZqBuHyAD6DoB1TIn9NCbPytSXDvUnmof/pShABp42eg0h0InzP/QxazZw6BIx2vV8mLreveq7ncQdQE2zfXWB03fkkYGPDxiLph2E0kLeyNBIctlzAeWTdpJFjkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=khadas.com; dmarc=pass action=none header.from=khadas.com;
 dkim=pass header.d=khadas.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=khadas.com;
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com (2603:1096:308::2da)
 by JH0PR03MB7343.apcprd03.prod.outlook.com (2603:1096:990:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:06:41 +0000
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549]) by PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 07:06:41 +0000
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
Subject: [PATCH v3 3/4] arm64: dts: amlogic: meson-s4: add internal SARADC controller
Date: Wed, 25 Mar 2026 15:06:17 +0800
Message-Id: <20260325070618.81955-4-nick@khadas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325070618.81955-1-nick@khadas.com>
References: <20260325070618.81955-1-nick@khadas.com>
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
X-MS-Office365-Filtering-Correlation-Id: eaba8e2a-35a5-4958-8411-08de8a3d109e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|7416014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0XFwkRAdtd0WN6IUe21cpCtMKXkLbefTxQ2wtuGiLE9bOJpqgWdh+Dg8R51hFJVjfAovK928gUWeRRLmKUDiFPNn71ucSgO3zpFq2Hkoud9MtR6Q9KcV9X+EdfKAMQjKElg40sOcNcUEFH9PORKeBppt3TB6NYGasYkXoRbmJDH0oZrGm9+2OJ7TjMJLvIibcGwFM83k9dPCt3OROiFCsCA1yalPU1tugPw3GVkGn3o47Tj4f3JK2gVoLA6R71Grx7qw9a+AxuUOXD1h9r0zPV6YmqnDMOqpkTNSd8NjW9iEG64BYjZV2jNsXsbbr9u9KCvSWlg9J1emq8cISoej9wFs0c7xQJr+GL5bIUxdxW0Jjuz/DQd9QA/gGTjsS2hB14Wq6o6ZG+ost/eGhK4gIgtuVVqBv6zdP4qibNBVXygdvnmPKLv2HLtTAeqAyo8YsL36So70Tr54Vg8gfViWhz597cyoY80839Y1qihE+ZgQu/N6AZwqIbDeNOCJWcMvNPDLPLHNpuT4EaC4hJe0wLn8EZabzGx1q2/BPdbv8JB+N6SQOefzhHaGjXS6R760klXx2st2dr8+U63zZ6Doncug7CFBt2/j0XOuR7logxd7FQFJwAyyDnDfxvI3oAPelF+IBiYchc6oHMhfqp6eHslQoUl2ib1kKE20Lat86L2FhzUIP3DNs+V2FS+STwmn8t6rXee3bG69W7GrktGzY/l5VLUd4x07v1hfxuc+5lmyfx/oOykoAmh2x6LNom89iH08BIRSz8Tp5eoGcShYE9m+sZQ7lzW+7StSsC9LlCY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF62EEA9B1D.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(7416014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4H4f2VirOxpYijhKJnyrRqkgNyRyGmKqIdmQRgZaxX5TtMjo/Q+z2EQGEUq0?=
 =?us-ascii?Q?QHEPJ8Nu8R9Bq1Vk5Rue4kKKz4F4NLLUojfWw0K40P2c7L81sLc5ny73tIwe?=
 =?us-ascii?Q?eWPYMIXgfF8djkO/q9UQ8GVFAF2fzjjMnuH3c9zxD+psavfcPPK+GLAgilkf?=
 =?us-ascii?Q?6iBgyWWLJMhKYyYA43Gz5c1lG+lYTVrmlBNaiLA9klCFojPMM1qrFhd7yWnC?=
 =?us-ascii?Q?e3nsIvh8hR2Thl1vzX1rNoS/vzgJwCh1ntooSJNOCQE+d2vbgEBMNdABhWe3?=
 =?us-ascii?Q?7dGCaLjwsgdoSlKx0XL/8QOMLjk3L195O0Y2bY3oYHy5gSj7/6FwHiq7fDqX?=
 =?us-ascii?Q?WnxK+TqFRTRPZ8UUVK9DstT1ebY8s31J2YaPExpc8gWn4imExtqVzdry6l7n?=
 =?us-ascii?Q?llNStolBS4og7ruB8SCKh32O94QZSh3yxOJ5yS7Q1jlPd+fmaY2OcHzFvnLa?=
 =?us-ascii?Q?aBQ42SXXKYcDZtaW/Vyvtkf0eu7RizZUTIe4fEyRfb/oB3FDOABHS3fF7Onz?=
 =?us-ascii?Q?dw0T3T4+ZdqYli0nUVCo4PyTwvj35IAADmNRQgJq0mXGt0Q11J855WPovqIZ?=
 =?us-ascii?Q?cGw/9W82F0egLFVVesdaZMiEC+UGRt3UvyeR2SNmm7bWMQCHxaU4cm2BISS7?=
 =?us-ascii?Q?6gMqavowzIo21g9Zg/LhBeTGDc8gnPFqy1L8FFXPdF0+3W2MxSh03xCJTJ17?=
 =?us-ascii?Q?PgO42yeVtxbLT2O+J1LLMXOnVnBRHVOB8ERLZ2eM+DPV3DemCapLxeX8c524?=
 =?us-ascii?Q?x7ixpnZxNHHyQ58VwOf85uAx9c0uNgqvkARp6VYfr57aKoel6f/HiH/74vcn?=
 =?us-ascii?Q?BOmimdcWhJ29bHB5Pmf0rz7jz9iuIAUBqKdedtc1lGEa68XKbAqW/IDAwfbh?=
 =?us-ascii?Q?ZZYjrh89bCrQY5XFmop7WW/bFd4Kng10LuzsqTsz8msyvkc+w8UYVp+1L6Zm?=
 =?us-ascii?Q?lbzIJLhunXXHmW5K0tbs1t46lkt1aQJ7pCmCvNBnJG8qVzw+rk2IO7inJshY?=
 =?us-ascii?Q?HHHaRLvBBVPyFaZGmfJjkaocBGRBNtWVOV28J8oeyrR2KUMoJ4RhS3vu2CIV?=
 =?us-ascii?Q?Vipurpw7Z4Jith1p7Sm6/2R2PiDgYbf2VSY8qLHYQyzV9QdNhFCMhxh8xshY?=
 =?us-ascii?Q?Jn5h6KJBq7VI5aGzkTdHnBMCdCzAg/hx9sGT0nhh33NRFBI/QbVSfwxPB5Cw?=
 =?us-ascii?Q?mk4jI6lN+L3uKH25W1gzMfbRUi7/LFbGnfhNRuBky8wft065G8pn2BaMGi+H?=
 =?us-ascii?Q?UKWzInDhZwUCOPbbxrv0rI/8C3XsV0Z3VFESsgBHReICZakv1Dz+S1Z53JOf?=
 =?us-ascii?Q?4g1OFaaNsY0Awuxrl/OEYX/F20zz0IULurQrJ21UDDZpeB5UDYhzbC+HPwEs?=
 =?us-ascii?Q?0yvwLUPXOc6jYAAb+WUdD4EgQe9aG5vdrBVHrvMhpwswhhaDWzka1P3pu47o?=
 =?us-ascii?Q?gVjc277Tgfqn0MpCDvrVPOXCvXWVIGsmJ7tX/KhTFHMScG0Ru1qudJ2VYLTh?=
 =?us-ascii?Q?V1QCixZgU+DEPKtWbiG/ubHTv1X/YDiQVtgXyfISijeJDb8ryJZg94SKdVjz?=
 =?us-ascii?Q?PiAofcUITF5YJQuCvt3UZeP+S/3ek5AP+cMeG3DhbhFDtAxrF2IkKkE0IwaA?=
 =?us-ascii?Q?tSW91vpoP4IvEKLfCA36ndzJW1pawsrmZubtHyXT1v/QDXsEs0H4YYgBtFum?=
 =?us-ascii?Q?BfSdHrfn0qXDPgaX8bJdAmNjO4RsoSYwC1HRlLuo6lMzUob0?=
X-OriginatorOrg: khadas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaba8e2a-35a5-4958-8411-08de8a3d109e
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:06:41.1810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9gZ1b00sgyGu+Zs/uHog4q2JNT/Ew/Nbma8N3IKETZJOwYh+gC2YlHLMOWFanDX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7343

Add the SARADC (Successive Approximation Register ADC) controller
node to the Meson S4 SoC dtsi.

It uses the S4-specific compatible string with a fallback to the
G12A generation, as there are no known hardware differences.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Nick Xie <nick@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index 4a3e9ad82d280..936a5c1353d15 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -77,6 +77,20 @@ pwrc: power-controller {
 		};
 	};
 
+	saradc: adc@fe026000 {
+		compatible = "amlogic,meson-s4-saradc",
+			     "amlogic,meson-g12a-saradc";
+		reg = <0x0 0xfe026000 0x0 0x48>;
+		#io-channel-cells = <1>;
+		interrupts = <GIC_SPI 181 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&xtal>,
+			 <&clkc_periphs CLKID_SAR_ADC>,
+			 <&clkc_periphs CLKID_SARADC>,
+			 <&clkc_periphs CLKID_SARADC_SEL>;
+		clock-names = "clkin", "core", "adc_clk", "adc_sel";
+		status = "disabled";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.34.1

