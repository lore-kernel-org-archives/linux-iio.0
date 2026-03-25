Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022128.outbound.protection.outlook.com [52.101.126.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940713624BC;
	Wed, 25 Mar 2026 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422414; cv=fail; b=o3ZTe01LWZ4z7RypKTtpB4gmSX6hM7tJQOuQW9Px2wYcskHOCliJgm2C2phuDpcY0gn3dyraSb4aBCJ0S/2mncPY0TZIx0f3LWu5+teu6aCXTa4KCvYymWzUAaeYjm/AHZZ6NXpT3yD+8J2RGeX9trWSLRmxe/M0b0JbEEuVfMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422414; c=relaxed/simple;
	bh=UpSbnHiWth6F34uWtlroDOPdl0dwej1rds+oiJi4OgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cy1tz71UzoVka8zB446BmAZts5V3tfcCeBwDuA2SroFgODQnmKb5YWXkQeW6S1Y97R4DbZJC9G419SpBi90jGpzbWO2AVLb82FX27ZNSZtMWCJWMwNHevmtyxnOHSi6eOctsacnOzBbMUPfW9hNaIjkwFLqioIm9yDgquCxIDMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com; spf=pass smtp.mailfrom=khadas.com; arc=fail smtp.client-ip=52.101.126.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khadas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkMG7Y6frC7ppbpg+sqhLzuxWGfdE2upoiXYygF+jK1VwoU3unRU4Vr0a3tX1wbVwkA0WvuBLYxEzpgINU/WTxmq0z8jQkXtey96nAEOz5rJrOKvpXKDK+4GdQbEN4p8KliNSwtULxM+BdSseJEXNhtwmuonUbQWht/pLO1MGI2KmZWpFEyYHMkPcqZd0QY/Vu4uC+j6jDdgDULmCEv74VmcZoZNqJWgT+UuIfWlepq6bhOXOiRWZepBfqyVwmmhusgobq+WA/1b7IQzpA8wNTMpoKpPHPiGPASvf08bVEZ+lzuol4tVnroHRi8cuGloSbBBDBiZj1n4Gbzf8M//Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev6BjyMHQ+Spg8JGgQiSSbgoj6dStlvXRI8YWEH59sg=;
 b=fs927mmje6O3OtBlk4RG3+kkDGGlE4Cug2Xd61BmTEQTBU+ySWLqRWBwh5o1pNyIFJoDvtEo3GwmFuNnQ/UCdeNApaNWYyOHROLvLCO8/4RmgQMjDr47r/TZRZDOR+GzXT1W83HbkcUAsH6yR4NJgS8pK2USDOgH8CI6MfozJO5ZFuc8IYCTeiYLRlv0D1Lf+cObZVbruR4vHrU3cPi1GFsQ94J9EG1NVWPgOSoPi1PEj5FrriSab5/CNm1iZCFwfAcXMZduPIF3rvIW1biUtlaXDf+j2mIrk0XdL6f55C8tSdPmYx6YouIYLF0IW9CZemWpk6EBd5uRKJAdShtHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=khadas.com; dmarc=pass action=none header.from=khadas.com;
 dkim=pass header.d=khadas.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=khadas.com;
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com (2603:1096:308::2da)
 by JH0PR03MB7343.apcprd03.prod.outlook.com (2603:1096:990:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:06:45 +0000
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549]) by PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 07:06:45 +0000
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
Subject: [PATCH v3 4/4] arm64: dts: amlogic: meson-s4-s905y4-khadas-vim1s: add Function key support
Date: Wed, 25 Mar 2026 15:06:18 +0800
Message-Id: <20260325070618.81955-5-nick@khadas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 03cfe2fa-3ee5-40cc-23bf-08de8a3d12f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|7416014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+OF8zNcGH7m0g7n4/IEZcxv/pI7wWnMliunWBKD1IrdAqWldIj0QeCZuJJt2wv3AeAOHZIbRCcB71SGvJN0LTxoJg8vcm3Owc4YakuON2XL7LQUHmmeA7xnuR5HSikhfZG+A38zn6nujtNASrRP0xa7v6YtdUF/SpJYV22mZA9tn10SJFfpezu2nZEyWsu9cMgB6oKnr8u0jcb4nb3Jo9uWCfy09HiVT4D5GemG2p3G2hqJj9OZfOtGhsrblf0RVVZReHNrlqJKQ6dDHTW4elKuihfMIXN1xfDDk64r8UuUO3tFdFp+7e6YZcCEoQq6jy9itu8p6r0WONuUMT02D9C7z10FwoWEzCSXWSOluj4xQL+riFGt2gJ6Tb7n+KJoJThQvLq7SkAsOYCBRfYrENrJdIDC97HMvnTOnnY3rfZuc4O2+4BzmfZKiefJ7YP3f4aFFLmizo8BADFdrz2N0xl6oF0q4U1CO7D4pKo3wwBspHSODdRTjit9m9Ri4x0d85gCo06IncbnDclGRYE7ILYShMv4Dg2q9fiqS3qH7nqFmHvis1IgFyh7gIIIM+MYVMNBy2DB0B7sgXyBgOZla96TYOK0nPXIgIHn5UXcO5oS5kUrawO8UQ+lKzHQAKI3msNQn/yX4er9nToY4oawgcR/n53cDzrwQQttc7xESYFET8N/pn4jOZ5TJYJEffdSrNU5hNTLD/7IsRCa4v9w7vfxNE7vStbqQTqH+iCt7/J32qiA6JX4rMpJrFyh5Gp6bmp/wzSeyO3HMN9ianSu29JjOondIKjoioz6oB36pc6A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF62EEA9B1D.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(7416014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BNftECGKsJ+/UQ/lqUleoMBubsWuGyShV/xEKNBdN1czA/+DUuJHLa2halxS?=
 =?us-ascii?Q?oXM3inGBo3ijoo9eDQlPZ17RgkZThpKzK95lASra7KrrbrihWYULb87Zasz/?=
 =?us-ascii?Q?YRC9zTs33HfwmzJ/rAsN9oL7t8+XmmhInYW0UXxvNkvL1nZtCu2bzHEW7fD1?=
 =?us-ascii?Q?daWWjKO1L+w31hrQrmG13bqGz4xr1NwWOD5MlMpOMkKLmw0/Ntvap0QtUT0s?=
 =?us-ascii?Q?I4n3bquvtq2x0VFBEYAH1/y088Kc2iSYQpnGp3ER+XNtCEu8vPsD+ZKkg7Wj?=
 =?us-ascii?Q?w2VxMMmGqCp80r2CvsQlVc8lGLwt0j80wgGe/rejamSVRRXKUc77NYlWS9iL?=
 =?us-ascii?Q?2ijF5eeXl67dPC6ePe977SrgkaIFwNnmiur3z70uQEl1/2e6NpfRoRjEsqqQ?=
 =?us-ascii?Q?+Fga2R2tfkzTEIKuQgqSMDy174MCQXAUUGOazMrrrtYGy+SW4b2YSx4svsAC?=
 =?us-ascii?Q?3tKqUvEHAqKTaC/8jG1bEB5FB83F/XhIFzB1T+0DEROM2iBZPjtP39RMLOSE?=
 =?us-ascii?Q?9qzTuGTIG61pftt3uqzQB1104vKtbQpRjeKhm4OaBEBlpzPIXUKfoEH80zlO?=
 =?us-ascii?Q?m9xcTeEvmD8n2N/dbhiOA2XVqW7TezP8LPflyd0Xxwg9Mv2jkD2l6Qp6Ja6Q?=
 =?us-ascii?Q?NFwDnzLX26AbP22LxeKP7XRBwiFps1CsBrmYF/gYDkhQfvl74abr1iXIsVuh?=
 =?us-ascii?Q?ssr9Jy8RI0u8C6wx1Wx5NYr4eZbfAkaoL8mmfGSyZ9cxHAhn5ryh4sy9n4h4?=
 =?us-ascii?Q?j+0Vq/25Gl3llmDYs0+fyPCt9NlcMefh5htMDSX1oA41/PjjsFw4A5pCPks0?=
 =?us-ascii?Q?W2y6Kk9ZxR1CIcUCrAJznLwD8c5nY/pgDwyqvMMAUJdTkFBgSmFnDaPudzKl?=
 =?us-ascii?Q?iCQ8RFcRt/xRuZ0vqAanTrzqnlviEfd5otPsInfd3eH+/v+sCOHQQf3v1hFS?=
 =?us-ascii?Q?ZjB7IB3PVw/emykFP/wqkhSiVkLHTAbmgKWnL9M+iutfhQyTarNSQ8Wgb7oi?=
 =?us-ascii?Q?dXAQzqQP3SCmVSKdwlY6ZjFQhUvTGsOwWJ/zKf+rkIbbpnzmu19BeBQVNbcs?=
 =?us-ascii?Q?A0m1ivJGJ9b4TU81qobFvpfJYN6xrkbjF8Bl9VuLmca22+Ih1Y8G8+7CUJwG?=
 =?us-ascii?Q?kp4AZLMBjXFTEy613LiWCTE9MsMwiLehPn3Nzl+wKyeREhxYA3uDg7oRImBD?=
 =?us-ascii?Q?x5qIQT+NObmV+ACf8lTRoSCxXwzunc2D/YQ87smA7JsnQdRtbaSlMZVuHsfR?=
 =?us-ascii?Q?QRXyI6rgAot0MqUXGbICG38QaJmqqlz0KWyesPUpx7W+d+fKCM5Cgf+lu+22?=
 =?us-ascii?Q?Q4rQF9unDTbo7Z6ocDEcQe/iEsPN4fZifCOpVe42e+OuV5wOpV/f39GTeiwr?=
 =?us-ascii?Q?ndsOqZfj+DU6g0Y9vqLNOae6K3Qi+cLsgASXwo30GuuN+2cl/xyS34MC+bDS?=
 =?us-ascii?Q?ZJuXl+MMphvVd2bjlIhu1nFYNa8CgkGEbVlTvlp0KTelMg30f/5y+nB//O/g?=
 =?us-ascii?Q?1pcZS3fqncmvxm8SZc62MsadVwZqHoHblyCocwIBH3/IyGn7SYq99oz9G4RN?=
 =?us-ascii?Q?E/hfZUmPf6it3vehhu4klD1JbooRKud8wiML+LGl1sCLVmdUFWruA2FvTMES?=
 =?us-ascii?Q?uWjZgHf94uz0N4Rt03Ny+TpEODq+1zfh8UwVyxkbatHw521WZtgjH7sM3bBi?=
 =?us-ascii?Q?AdSuitR72nEEfc5squY3ECc7VtiHLcohF4iPbbIc1TduwOx/?=
X-OriginatorOrg: khadas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cfe2fa-3ee5-40cc-23bf-08de8a3d12f7
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:06:45.2541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8TNazrT8eNQhyInozj73+VORv2hfWtYOW6BCaM5qO3LFxrJWubiY8boKj0NHfTW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7343

Enable the SARADC controller and add the adc-keys node to support
the Function key found on the Khadas VIM1S board.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Nick Xie <nick@khadas.com>
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

