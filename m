Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023116.outbound.protection.outlook.com [40.107.44.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B463314C3;
	Sat, 28 Feb 2026 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772261952; cv=fail; b=mT7/zwe7aP/15jCNw+iZ6moUw7yHVASVxxwWV7ZU4hwcTEUeU8c7LXpsaQOKW99o/wM7o+NxQEfuxMNEcnjy4RSL4yu/bNB4DWKbZ/Lxm7rf+WM/jZjV0Jz9WTJlWi3w6A1qqLz6omOKpbaBwqkK65+Cf9xtMWFqAx2KBD/OPfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772261952; c=relaxed/simple;
	bh=Fmq29gbtH91dw156DliBwcKRzYsjDimuknxgKZj7v2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jxaC2Xt+MwLuUUV7DPLN29PbuBJkGX3c7IV5WEsawrDgadhJGr/Fx/39F5PKDIFNUx2EQbaXO5uoDzch6ZV0TXzNYhKGqBrYJA1BuZWBxrBDYmbDU7ABMRdds7ArA0pZjUH7X941hSuXPlPmbatxClFIYSSvskxrkEmHSJKZo4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com; spf=pass smtp.mailfrom=khadas.com; arc=fail smtp.client-ip=40.107.44.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khadas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPXFP95G+SpCp3lS/iVUtqF8UwFUnQbi/ZIHIenEv7oVkp3ajprMYbmo68G6/AzlStHmOuogjF10yfsCKTKqzMjFr60EVz9AlKjnTZUkDt+MuZ/9HjpyQ9xNriLGsDJs2J7XoCBnxt9cwgYWhx84fQhVygvHxLW8Jauu0eD6t5CrWhX3RsaNDRAiTTni5UiMT7VPNBQ4p2Wr8aUi0Fd4efXUyMCb1hoK0BGV76A8CMw7O6w4P8avuKT+x8s6a5F5O5p5Hja+ajxpy8RocS6mAYi4skZya7EewjtWnGqxmUgyps7My0hdASA3PEDU3fWBqOiIfKugXbIUYnyEULm2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJPIEBzxGra6FpeKObUxonN1k6L89V29jIvA47ICgos=;
 b=DMV+wcqnNGLVEBiw8F8OO1lp+DHY0jRNrl9xhq19Ytlci5zbd+mxCA6ymvOeFD6ml0ZMwyioVwI9yI419+51V9/uRI5rDU4HpM8Zx//ZvRbrDlu4APC9Dhr0gU9RKmvUTSCAN2HFujpQtgF+enTaol7FVvUjub2Qc6dq2bZrOeKm11o1QsBB6shjg78NqkKv0gpxUQteqeySNveAq7vpHBxQG519r/6dVvJh64VqVigZBHy4yRkYBBRGxDz54MvK9rJy2PAKQ1V2JGzanTi4A3WrsK/WsslFM9SJrcLwmfz3ovGPKTLX/92pY/JganeUs4Wity7+OsnY3xkwxsJIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=khadas.com; dmarc=pass action=none header.from=khadas.com;
 dkim=pass header.d=khadas.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=khadas.com;
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com (2603:1096:308::2da)
 by SEYPR03MB6722.apcprd03.prod.outlook.com (2603:1096:101:6a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Sat, 28 Feb
 2026 06:59:09 +0000
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549]) by PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549%4]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 06:59:09 +0000
From: Nick Xie <nick@khadas.com>
To: neil.armstrong@linaro.org,
	khilman@baylibre.com,
	martin.blumenstingl@googlemail.com,
	jbrunet@baylibre.com,
	krzk+dt@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xieqinick@gmail.com,
	Nick Xie <nick@khadas.com>
Subject: [PATCH v1 4/4] arm64: dts: amlogic: meson-s4-s905y4-khadas-vim1s: add Function key support
Date: Sat, 28 Feb 2026 14:58:40 +0800
Message-Id: <20260228065840.702651-5-nick@khadas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228065840.702651-1-nick@khadas.com>
References: <20260228065840.702651-1-nick@khadas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0055.jpnprd01.prod.outlook.com
 (2603:1096:405:372::11) To PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 (2603:1096:308::2da)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PPF62EEA9B1D:EE_|SEYPR03MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7bad57-ca09-4c6a-fced-08de7696debb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	Mq72GeKHliEXC43m1zzfEjpyID6kBxvydzOInuJeYlz7OAl7vAab1VPKXdvLvi6JYzfcWpTT4gg4BgVLWvFw4qUXteCZg/c1spTT6habKBqpUQq/rVy3dqKuNo6JZgp/ATija4FOtLAyXlr61pSuHHV24cEil/WmWWG96feqSxMY1+XT1aLzJJOYAPqXYWuwhgEbfvtmAY9TQlbyComEQnLsxniSEFaJ/0ky0VDqdO7kccXbo7iWJG3E8bfaN0+QUPWeDELRJ32LJ3PGPqwaSq2kYVeNL4y52W68lb0B00vHeBRN8j/lVME2ps2ZJgiLp/lOsgI0zVmjWc0pS+je89tf/PvTUizO7N+UtJNhKEgdAsJzr0iY2mKhJIACxGBZHqzphpEEV7BC55fj/upHNeQX9wW3WX1bGtL3Y55lT4/BhtO6uff8kEAxCfRfzKe4UbpSt1obkxatBTxnFw5SkEsEGT8fOL5nCIuUar55U9kwJAOc1iNKuwCJ/RKYsk9c7PH06LxO9ZQ+y3YmxLCBW4srGVWusOtAmG0Cc++c3rXmQBLY65s4J2OEdv0xu7wOG4SWOAJXUt4m6i795zuAjnc+HXo5yCt4dJne3Moh+8bBH7cPycvahtguAbVP4ayb99nOAswr0lK6plYR5D4zacNqjx2bRbqugYE9ow+iOKty0qmuSuLxap1nrw9/Hr15mZdBke/viXgDecH9oWzrVuPjbzoOC5oucV/Yhjcy001FTAgP7xk2AgfdO4MYUUfddFhk7czbxQPuT/LNkbNcUqwxn32J1Yky4HkIV1moM/w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF62EEA9B1D.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?od+AsoMbifcZUYQI/oT4Bl3I+WpjY5Rm/Dtfgln4JN7L7hi6NPXWOM10UJTl?=
 =?us-ascii?Q?yC/y9yfg6n2znMv9Q9E1SvGWXjmbfiK38OcjKkz3LgtP6U3j2q5hd1ERjGT0?=
 =?us-ascii?Q?Fcp13U/flSt/HnZkaeeG30aStIreiibBqtWynC8hEX+jeoRByzFSj6ruUp3B?=
 =?us-ascii?Q?0t3EYZkzN/0d18mLJend6pkGorkUKC8nu7/hc5cRWyq6HCTjCUNhqQrB/q7I?=
 =?us-ascii?Q?QNPBrCyK6VA8/h17+7CCg13tZN/5JTx79LBMun7o+galjCYG1cKTGS8fcKaf?=
 =?us-ascii?Q?0cGPRJ09jxW7ePangGt+ptdkFLtAp/ek+Xoo412zTSskIhIa+uvq4+azGOud?=
 =?us-ascii?Q?5PfFa9/ZX0lXZKUKkpixexBOsev89yxZNLQbVcFaK0Mi0fVqwEfXTxBFzUcf?=
 =?us-ascii?Q?1mbu4Ms0scnNIWWdSG8GCVD9QZvmA6u+A0wWBSIq2XeOn9uOjC4UOoidECca?=
 =?us-ascii?Q?894R783BrrzjEEAXleltyEYBrnzFeHORmQi99ASRT+FgnT8caCE7RCQkSd2f?=
 =?us-ascii?Q?C3OMqnvaBzaVQrnCV79/cvAgu36yvS5j0SkkgkPG4eIyYwx1YdOisEOU2ssm?=
 =?us-ascii?Q?O2CoFkoOs3FHFHJR8x+AGyaC6sKxIWxKu/RPS1kg6SsWPjZRjRxuSc5iwv9E?=
 =?us-ascii?Q?AcRxl4Tz5ah+/DWxN+NVKPqtXNCvbO3mJ5wOKhdbc5QmgPNeGZ2hL3Qwhj4r?=
 =?us-ascii?Q?RhdvuovM6/rAGD2hgeeqC/OEuCBRe5v9Xs30dHNLv70SCnmo2g0QBR4u1g/S?=
 =?us-ascii?Q?f7BSdpnJH513spqbEgGLyYutvpSRPtGw2fqM5Yp4aecMxZ8I7rGUgHv/lRKO?=
 =?us-ascii?Q?pm0VMvQFsckebFPE9eoPfCKiTvm++5BsGstFmNiik/J+zWeFg6J76GS29aKs?=
 =?us-ascii?Q?A+OKbz7fRY2fQ6NR4xJlMbEVsVsaVU6lB1WMklqgrw253Cy8GCWSI0VjpGGR?=
 =?us-ascii?Q?BXc3J79tH8fhpPXCakvpsw7M2wvxzEaBR7X7Y+Bspto6NfdMkO96gF0oX1Um?=
 =?us-ascii?Q?g4sm81qzxGJwk1ahMv/Ikr7k2uFo8C8i1lVJiCUI/fWAp+tN9l2fWf6lZhW3?=
 =?us-ascii?Q?n9A5YKcMaiwmKK+dAMWxPm+8g7y5feR8kv/Ltif6l2Wxz03JKGuWcIaDqwZS?=
 =?us-ascii?Q?W1l1bLFpMQuxGFH1u8VrL1zBYXHKvyrbGRXByQPHlDQ0zGVSbU1nivyQQ8Ug?=
 =?us-ascii?Q?b7TWDIcxtAlWVLbgV7vK9F8MgvjTMmUmyQakL75Md4NXlNqgJWBAsR1DYBK4?=
 =?us-ascii?Q?UkL7PdEqTAApDmfGweXMB6yUFuT0EV56X7B9aBwuJeQ0LLGzBHXZTXJWgQXL?=
 =?us-ascii?Q?nqgAJtGg2OzUlTFaNplq4IgYFOusPPaPSK/oigeEDBpJhDvt7kOhOYDz2C34?=
 =?us-ascii?Q?Q4evaCwS2fSvTvcI+ZnTjslGmHbfk7pLyodNKt4losZxjzsTMkUyYG+FsYMi?=
 =?us-ascii?Q?epyNfLchAtqejcF7wZju/j674zP+J1Ux78Q7HdyNoSOmGEWkHklRG7Z8tXO9?=
 =?us-ascii?Q?tu9iueI8NYmPgNi3hnzf3/yEyNrU0q4bM/E09j7qS8dgz49A12/OHEJYR860?=
 =?us-ascii?Q?aaJcy+bum1t9WjIbmoMMRYEPFeDHkJphwzuxPUEr5Gt99RAULnopthQza56r?=
 =?us-ascii?Q?M17YsDoY9+G/PuMrPmLopzUV7Tog/Gh+9fb8qZOK4EAIxPS2zNnOrrTBrKN3?=
 =?us-ascii?Q?gOoJ9DpZeBgeaSxdW7dW7oOQ/qER3JdnEqoTToxqnRC6q0z2?=
X-OriginatorOrg: khadas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7bad57-ca09-4c6a-fced-08de7696debb
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 06:59:08.9909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNErJWNB4hSLK7CXytPJA6nGlH9hjGOmnemwOFxXXKkOESat+6pGqEisY5Ouz+7X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6722

Enable the SARADC controller and add the adc-keys node to support
the Function key found on the Khadas VIM1S board.

Signed-off-by: Nick Xie <nick@khadas.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../amlogic/meson-s4-s905y4-khadas-vim1s.dts  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4-s905y4-khadas-vim1s.dts b/arch/arm64/boot/dts/amlogic/meson-s4-s905y4-khadas-vim1s.dts
index 664d64a267f2d..792ab45c4c944 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4-s905y4-khadas-vim1s.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-s4-s905y4-khadas-vim1s.dts
@@ -40,6 +40,20 @@ secmon_reserved: secmon@5000000 {
 		};
 	};
 
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1710000>;
+		poll-interval = <100>;
+
+		button-function {
+			label = "Function";
+			linux,code = <KEY_FN>;
+			press-threshold-microvolt = <10000>;
+		};
+	};
+
 	emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio GPIOB_9 GPIO_ACTIVE_LOW>;
@@ -278,6 +292,11 @@ brcmf: wifi@1 {
 	};
 };
 
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_ao1v8>;
+};
+
 &spicc0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.34.1

