Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022080.outbound.protection.outlook.com [40.107.75.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C21E185B48;
	Mon, 23 Mar 2026 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774229710; cv=fail; b=DvLLfjnkZ9lPQgTS76zB4ck8XlkZxPcV5yFNHKj5TctP6C4daPTSloiKkA0XC5ZBuSJX/cBmaS60T9kEFmMxHaHkrJdrJcXhULseVqehNKPecajvtWkfUYMO9EoAwZ7cO4Ef2qN0gihGgnPfXkyAPCpDG2jitNxSGfqHRdRKeWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774229710; c=relaxed/simple;
	bh=bnzEMzJxjN6uzSG1fQbjbJYdvyz12AWoecLmXiKWRzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bzKemdvtaiiAvKl62jGiDw/DMp8i08GQsHKP/Qj+JnnWAYzF40r832vQFOk06tnd8sAu+43/4DQY7/Nwq6TEtioAd7UIYQxa/5VcV/ZOgUHfXbsOMLV6FEt7ojpkjGqHraE/5lDP1EtZ44F8QqGyz2IGbrDKe3hx/+SC9pNUWZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com; spf=pass smtp.mailfrom=khadas.com; arc=fail smtp.client-ip=40.107.75.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khadas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2sY7CRRbm8jJz2rEo3fpF9yOhfQZ3JsWM78sB4lSHHnbvzSlNwpbZlOWNrzZMLrj+fhg46NYohu85rSylqUHZ4jQV/PEfbV9vWI0deYE0PpaWzw2UnUlDgAq2SyHJVpdSm8ZRSW2W5mWiJ3YchlY2p3wVhi7299IUKkzKTlSv6RFmpr2ISQM1c01fUhCtdrNNNZO30+XJedyGkcCELxCwqrcORwUgAeoZLm0jBNw4xju8ML5OmAu1sRUm2wP20KYnBbUd0T4NJoPZ7tSs2xKdqgzvNWNCje9NbRylLlJvRC1bkBxTz9Qjeg4yjK21PQYnJmaLgWnIuO3Z6KQEndNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzrCrJGjR3PmypvsGDuvaTqbL3Ye4CBqJdbul5iQIFo=;
 b=r56zCo+h9tqGj/9s+mMUnvUxoHmvsvzBVx9Q6ZHZC52zHwpuMf2clUgN7OIkPR4T+zw8do+xocbZsNURFr9WOV9wUIpkEBx1vhPsUd9m3iGz+jq4B5oDgJY59YUkg3N2mnI7MHHGUuUuY0oAASKMMQYl83zxNsNUi0CFAgfssaT2kMiQce8+TG/pqU0takuQx7eL1ziVGwhlddalNvOgU2+JGxft9heVL+LTkCJ0qM9c0CUColYiSFy2pzFkOuH/0LEhA19I0jOGZXEO0Rt7DRPCONf1RPPOG3zQXv3NPaJzTBgNWeZIeB8+t+NKzREU3a5GuESUMHw2LPo+LNPJSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=khadas.com; dmarc=pass action=none header.from=khadas.com;
 dkim=pass header.d=khadas.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=khadas.com;
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com (2603:1096:308::2da)
 by KL1PR03MB8142.apcprd03.prod.outlook.com (2603:1096:820:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.30; Mon, 23 Mar
 2026 01:35:03 +0000
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549]) by PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 01:35:03 +0000
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
Subject: [PATCH v2 3/4] arm64: dts: amlogic: meson-s4: add internal SARADC controller
Date: Mon, 23 Mar 2026 09:34:07 +0800
Message-Id: <20260323013408.429701-4-nick@khadas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323013408.429701-1-nick@khadas.com>
References: <20260323013408.429701-1-nick@khadas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::13) To PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 (2603:1096:308::2da)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PPF62EEA9B1D:EE_|KL1PR03MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ad4b8e-a9f7-45b3-8491-08de887c6800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Uec9Yvy9vEQ+Tm6u2oNW35rzgZbsOx3tQVQRmMOj7X4xFwzS0s2isvGeYExEQQUpl9TlPytNaXhLag/t2ixZarwsOhhAhIzw//1xHk2is77bJLgaLorKOmgdx5i6M5Aw56wHF7UgEdiJHAebUumAyRMlTdHUMpGuH54veJox8L87PZB9cp2uPhk0Vdt0jRsCUXihLRTp+jliju8yc8eP/R/CSs7HN6Xx5k4mpGOJblvXWiKrWn1ftkEP5ahMbmOtL2xGpDYChW6y9RHED/5i61DjaMrJiS80t2GlsZzMWTHTgmgoK22549uSfEOA/QQv2A1PkybBw1RwGE98lhDBbxvqZkyAgSH78h39Xnzh/pjtlIcJSgDpttTg/WhJu6n1Z0DVtQNzZlQuIq4Uw9gyer68QvI8PUpdqvDuBgbkU/yWwH43dJ7HTCCkhG4yKcH2N60DjT2CE/67snE9f7dT65Nkf05CpTcr9lpKJao4vSa5b+Wej4RL8OKbruaTWeaa71st2gCvdg4JbfWFg9uhEHGBwAWS1pgTEASirGXKqhuZJeW+CCv5FWWvHeQ0pxrHcsAucsKPRFN/Gj233qt3x0AlHTrcbwHvkB5Cqg8+j9k/plnrN6Ygty1LQiI7ZVdunAUQMHFyZy2+v0UcNIjDj3cISuX8NKnUJ/kx1G6++qWF2wkMexPadJ40j0mXBvtxbWNWlVmmxzv0fOnepFtNt7CYfzSzZv/z16bNBNFFKcKbqavp79NHlyYk0s7EyHeUmcNUKbN+mPfjVi9Rpm9lfTGdYIxr/xY7r6VPECslv3Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF62EEA9B1D.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NaN1+NkpnLCYBr5LDHDiosvGSOWUW7mewfK0psrzaoliiK5z6tf5oc4jx9fA?=
 =?us-ascii?Q?pBc7YCLwUj0h9sBavIRS3IREMZDUHvDlOAJ1ehp3VRhCzaWo8dttADdXqrK/?=
 =?us-ascii?Q?EhDWLB1J1U3P/32fL7rr1ZcyMu1tZjukLa6gyYm5IqRz/mA/owaz8J1gObLY?=
 =?us-ascii?Q?Tq6yPT/tKZAAV6bJaIfz2X3P09o8h1K+vv5Gt+0xRd8kJjQuDXdJu3ZTZ6vl?=
 =?us-ascii?Q?4kQJVWoIZ2QnYwKfV4OSG0xAf1D99BUUrlg+JJeRys4fTAkqKteOfpWrhDye?=
 =?us-ascii?Q?C0UaovV1hQXMFwjNRSEINcJ1GdqtifG7nFgqJQCpUdZgAYEiVNrJAnGVE3Cu?=
 =?us-ascii?Q?nvn803XiD+KoUVJdE58LdFe016O53gKWrCfwBn8L7KWOy6U8gCd4kMZ7RI7g?=
 =?us-ascii?Q?Z5yG/Zr8JrIJWWM5vJepPfUt8qkhblfsEbkdLFTVODNSFdBtM2gr1DMP82CC?=
 =?us-ascii?Q?R8xCRvS4K/2aXDeAhpqyrE8t5M1gQyaulQ6xSdIQv5J824Tb1D1YdAHvV08q?=
 =?us-ascii?Q?0iCohbA48z/tmsANcpfkosUv97IqANPhhlbgNENlM4r1W/WihACqwNntwcBq?=
 =?us-ascii?Q?buu+L1AWa+ErXOJzIQdX6lqxltAKQ0RZvX4CTedH0//GEnpL4ZeCE6FsLGt8?=
 =?us-ascii?Q?l5OSEKXIHjXnn9JP9dQ/gMbQjgdLUZSQ/1JV0AyJfCXD3z1K6L/m9VV0kqyo?=
 =?us-ascii?Q?0urFEM6ut+V/15k8ZWt6wIFnWvrygRlb6BpCNo9CQojvjIxWMk/kKiz9MMjZ?=
 =?us-ascii?Q?NhlI3xtLq4eq6ckZXAu7sz32Y/5C24nHRWyhzAcIU/cpCETqDYBdICdneVcO?=
 =?us-ascii?Q?2oiSsZnFXZcN94koNk1AgPbfrmo9IzRbiT8wF15sRAsi4rnV5PYTA7ugc38q?=
 =?us-ascii?Q?3z14IbxPHNicL28DCf0DRMvWL1g6znqzIE3uIDsS7oKk2LVsAy2NYGtzX0Nz?=
 =?us-ascii?Q?Rg+EdRblfPHRmLX2nEK7l8GojvCJ8xFnjm1mAP5DZcoyDMa2BPTazhxpe2lZ?=
 =?us-ascii?Q?25uCa00jOdYZyBX/TfnEbwk+BMWhHCMhD81e3XLctt8V7pova7FTGwhPE5IU?=
 =?us-ascii?Q?xaIwp4YDj94O2otWAXoE2U9z+GWCLSY4Tp50lwQOq6w64Dk1c/UtB96oou1o?=
 =?us-ascii?Q?83VTkmQXrxx2d1+hIp+cOlYkKmizryEt/+GwsmbkiYbpFy88UaDaU+ggnFfQ?=
 =?us-ascii?Q?YJuVQvU2NMCC6QJbPdjyvg6XbtUbCNIwpeDR8vzHt9dwHgV9AheWt9FHyNpg?=
 =?us-ascii?Q?YYRLo5IKVgTwFopphbqru23e/3aN4bouUm/3oBYun3+rK/PxUXS+/m7sq3ja?=
 =?us-ascii?Q?EFHAyKepCCDtZGf4OAS1CngErc/LiVYyHTl3UQ+FEd/37GUpWZJuZJKIwocY?=
 =?us-ascii?Q?q8Qd0APtd+BJILhs3D/Z9j4yG99beZkGumJnIe/LSRcbnDZhYwfe+6+eWoPE?=
 =?us-ascii?Q?M1JZ3yNiUbUndm6LtDeGqEKne5K7w9oXXwwHsbMuFq1HUfAGYbyj3wjiYc2X?=
 =?us-ascii?Q?wVN3WIRWrEpLlVRt4+I3/IzELLbQHvsgsCwSdDa9BeRVE979JZNozPd5WAie?=
 =?us-ascii?Q?kBeoW7yqBwSQAjrBZehVpVsoTqdWmNZIWgUPAw1asodbacR9xnExSJjel1j5?=
 =?us-ascii?Q?Y7zL8myrIB63lzKVxnzOZ2TRFsI8EUEMdYoou1NXcMP8yAyddep4dFMjHkP1?=
 =?us-ascii?Q?CHb6iJ+h0fhOFNxsTntBrRPcH9+wS5UXMKXd6YvEjJVarNXd?=
X-OriginatorOrg: khadas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ad4b8e-a9f7-45b3-8491-08de887c6800
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:35:03.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJLCq8xhHSW9VbWf5Fs3ys1m0/Zpv+9CKlRNpeuo3q0Kn4IGNoUPdsglPU1DuJGx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8142

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

