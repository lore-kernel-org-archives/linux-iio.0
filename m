Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793893755;
	b=lD3HUibPO7uxOsBC0AsC7Hj/DrDHhSOBFHtU+XQwIf8pZu4zFOFVKYh1uds1fFWtwF5W
	 631KqsWtX6YDaZKFLhGcoZGYZPa6+8VdQDolSon+aFELcKIF76ZE7r+n2P7rj1ySBYNnp
	 aFN7Ae1YxDsI4rMaGorLTZuu005y5mWrWylqa+Ixd0FV8OD3b0oOodf0wM/WdRDmSIJrz
	 apeei9lPXdDUxcFZgdS6+OECmjKQHnVZAe34JoG8p5h1LDsUMuqcOGrQ1pXZ5DKabLwXE
	 eiDQSR5C55LbObEqI3AdnYSKQiOgxFjBu5dv3Nz49JCyI+rRA+mPcM/7+F4IfWGsZMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893755;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Te6MKTt28E1xYUrIER4tNd+Xdp/XKOJ6cAZ9QWIzkyk=;
	b=LCbpEMWFfKtN8BEr3W3mW02bnolmDfZuCbWEtih2RuF/Ir7WQdo5Vu3qAbnmp9tUHpz2
	 D2tr9iJAdCKGnrMw5rWzhdFIBIYgzcjWKoxC0RhhJPNfABkyN+v7oMXqRMd9gM9W2+tyx
	 4fq6/wEsQdxHIC0uZfcm91buJYz0c2pS//i4Vp2c4TNlFV34mc7BHWo5KvvBKfcHj5cBR
	 QmtGGt2W8aa/oFWoml1AF5N3IDie5CwmqMyB3H5GHAKd8z9/eBHMbMWkVxIW+7eqEDQQl
	 eAhX6jZW8NADPW//suECrqIpxbAJNIMlQCciKhWnvS9xwIx6ZAS1DXR4EOB25KJr02w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=EB1PEsYN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.37
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010037.outbound.protection.outlook.com [52.101.84.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861B3606D83E;
	Thu,  5 Nov 2026 15:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 861B3606D83E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=EB1PEsYN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaaWYK7KCfogALdXmZfMJwHzRr6n8/niWi91qEnGDYYK1nwJwl5UQ/Mc81Kogx9UChVOirDzcmx3akeFMiklds8lZ746JOZx1vXCs900cHpp0yplisvasStrgOqUJcFmF6/AiBTixKw1ItGKBhbWe9gSQOwdPMWznNvPXNWCdM99UrXxY2ehiR7EHkJ06srcftzyDaQDgb/fmWNu+UTZVX/J0eof9fQXTExO4mMHDQlLZsqRkBbr2KVLTVfHvoxlY7f8GlijpstCZwI92iybXZcBz45FyPtEqIjn3DZuOqhEwKnFBgE/5Z8Qi/7H8aud3fzwI3AZ3Litv+z4OcW9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Te6MKTt28E1xYUrIER4tNd+Xdp/XKOJ6cAZ9QWIzkyk=;
 b=sXPiaxwfTEoqYX6ZZNKFsS1yu1B2cBLr7NFq4kvIkqZ0NMDJ7wBNkUCRqOwZ5OBuWf375AfJclD77fXV6c0tZtNGK2NbJAQJcZX2sAkEjnWe5X7W8pcqILgosHhs6PdtirXTUKz2+LGU8X9ZLBthgPAeDJWYBluzZqo9U0Kp/jNfAaTvPx0gYIn25M8BVXbtqPJcRLF9lJNCpwHiflKNgURXiOXmNKkea1loXVkSMaXcZ219QX6uSRUwG8UvxqEa80yzkPIHEmCiK3nyJjBKyk1RYkMsibgooLGOdpxalvKS6yy07HgNewn9/TsN5J28ZxyCWzbjURqq2cqtesazqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te6MKTt28E1xYUrIER4tNd+Xdp/XKOJ6cAZ9QWIzkyk=;
 b=EB1PEsYNAivbwq9k5rv8qIvVqI8H2AvFpsu6ANfYEJcW7Kx1IRPUQznsVuAqOnpyjZn9aMW3zuPCcL9Ne9cfRWyD+Y6w3T/QkzSDPwj4ZglKPfmYHNext7EVTj2nDqISGxDt3KdacUvUE+PyN/GBUAxpexOBl9l6AaSxEsouC0A=
Received: from VI1PR04CA0081.eurprd04.prod.outlook.com (2603:10a6:803:64::16)
 by PAWPR02MB9199.eurprd02.prod.outlook.com (2603:10a6:102:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:49:08 +0000
Received: from MI3PEPF00008496.eurprd03.prod.outlook.com
 (2603:10a6:803:64:cafe::30) by VI1PR04CA0081.outlook.office365.com
 (2603:10a6:803:64::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 15:49:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MI3PEPF00008496.mail.protection.outlook.com (10.167.240.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 15:49:08 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 5 Nov
 2026 16:49:03 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 5 Nov 2026 16:49:03 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 9648F4D2D;
	Thu,  5 Nov 2026 16:49:03 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 7A77C305D286; Thu,  5 Nov 2026 16:49:03 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 5 Nov 2026 16:48:54 +0100
Subject: [PATCH v8 6/7] iio: imu: inv_icm42607: Implement MREGx register
 access
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
Message-ID: <20261105-b4-inv_icm42370p-v8-6-b44eb96020b6@axis.com>
References: <20261105-b4-inv_icm42370p-v8-0-b44eb96020b6@axis.com>
In-Reply-To: <20261105-b4-inv_icm42370p-v8-0-b44eb96020b6@axis.com>
To: Henrik Grimler <henrik.grimler@axis.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jean-Baptiste
 Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, "Joshua
 Crofts" <crofts@kernel.org>
CC: Kanak Shilledar <kanak.shilledar@axis.com>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=26379;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=/8+AgvuTRzjEWqosmDzx9kJq0EwfIOif56s1dyaKY0Q=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsh6szR/1b1vHt+9a28vvFW//VeqaMnPqKiFBhn89XMvT
 ZfrTK3N6ihlYRDjYpAVU2Q5Z7Q9en/yP9050k6XYOawMoEMYeDiFICJrC1hZDi36/3xWsmLal8d
 7tzt/sN9Q9VwptfSkxtDGYxzZY5u+xTFyDDx/XHZ9FjBmcc3HBat10jdcmDJ5oqjvpfYCw03f1t
 0n48FAA==
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008496:EE_|PAWPR02MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bcaf92d-e361-4986-4ca2-08df3b5453ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|32650700020|23010399003|7416014|376014|1800799024|6133799003|22082099003|10063799003|18002099003|13003099007|921020|3613699012|56012099006|10067099003|5023799004|11063799006|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261022075727099003|261102130727099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	fQKZ1oOcLYM+D2G5U8CrJkdJ+wXuCDApY8BSGzToUtCabfIU7gouYGP/+MmR+NNgbTUZ1DI0OT6XkBvQftyLg7QWLqpvJ6es10hbCANXVkCVoDUZjvXWDbFqbB4hAxjWEzYAI32HjjY3NoTI5Z5mZQ34kf/fK5YNLryCM/mCi9fgUffl6NI0u3iAN9GGMZZwJt6+EAB8F4JRdulzISU+nH8Z0Igy7z40jcbtEu7wyCaK9+PSuB6EgIXNb7beENe8SkyTw16WX6JwgU9lkTDifNVUvdGeIc1RlQ3PDNfQXB4E2b3ZDLoAxobxIqBcPvv7aRS2vPUTLSCtMxND4s259Z1V0xRl8eYA2wS7WpEzFSaQBG7dfr8zjoTTYXaOBscyB/2ZfrNAdLRC6Kz+ZNcXDYis1binmCxcb+hLW/ZOcpFSk8uxDJw/WAZgze5oMkzDqtmTnm2PD5CCi1igNIqqexZY+16WJ9WUXgcFVXd1R0kmWN0gsAN9mIvTYsK69G9kfydF3gMcdhXi07xj6jnLrHrgGEUyfr+jhDlF2LYqay8Gd1wOKMQDWnzHjJG4ogsz4ziZHZNLtlOi/MRcTz4ifJl8zakZWJaat3aFVrwEAFXJoZUwbetrWp1k2FEXdYa3Nb7pG0kLpaD6hMcxnmFhP+sk+cibDqDHYMhVFqCruAH2Wu+1K2lWlvv9D6buiMDxJemZy6CSVeO13biwGO1gxQMEFXOYzy0pYe2+sOlxUD0=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(32650700020)(23010399003)(7416014)(376014)(1800799024)(6133799003)(22082099003)(10063799003)(18002099003)(13003099007)(921020)(3613699012)(56012099006)(10067099003)(5023799004)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261102130727099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eMx7CuCTuuK26HTH2tXFs1xZ/of5Vx+EjZxpoVWitVJYTuvTRinouDH6jT7vvKb4k3Ly2gNuI20fDoNuRuFG7Ab8Dp+f0ZuTZq9dZpJIHn4qrCHVs/qVQNtp08sj+e4TLpclr5yZpvpjuXtksFpl2YxIIY8BK17xkdX+6wuggPwKD87pY+OnsUyb32rFTB0QKgbl7RdFfMgHrbq3P90AZ1gptiKzNLDsGvDqTaLo28baPwZSlsP6xxXggjGofIIQa5Ih5hyE9gcPMyjhgC6dokDfZWI/wihW8dLUztxqnbpdih5ABwYHy8zgl6TstwIM2pAAPBlx7/u6KCV8hqh2ETYTFp/6vYq8bqI+yIjiKrM5Hxe7Yib9Qxq+F6q8P0+SKZcBOwFh94zsvidb2ofzWgjJunvNq7f2dUeiyiSrazinlcLqDgXfk2aarL/+F08f
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:49:08.0626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcaf92d-e361-4986-4ca2-08df3b5453ed
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008496.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9199

The device supports indirect register access to different banks. A
specific routine needs to be followed when accessing the registers in
another bank as documented in the datasheet (section 13). This is
required for accessing registers configured via the user and
implementing buffer support. The implementation is inspired from the
icm45600 driver.

The banks are defined based on their initial bank access code which are
written to the BLK_SEL_* regs. However, there is a variation for MREG1
as User Bank 0 and MREG1 both share the same 0x00, so User Bank 1 has
0x00 and MREG1 has 0x01. When MREG1 register is accessed, then BLK_SEL_*
is written with 0x00 instead of 0x01. All the register access goes
through the 16 bit virtual regmap layered on top of the 8bit bus regmap.
Bank id in the upper byte and the register address in the lower byte.
Bank 0 accesses are forwarded to the bus regmap with the bank field
stripped, while MREG accesses are forwarded to bank switching sequence.

Due to the specific bank switching routine, it is not possible to use
regmap-ranges. Only User Bank 0 supports bulk read/writes whereas other
banks can only be accessed serially. Each time some data in the other
bank needs to be accessed, it should go through the complete bank
switching sequence.

After initiating the MREGx bank access, the BLK_SEL_* should be reset to
0 even in case of failure. Ensure the internal clock is running before
initiating bank access. Add extra helper functions to separate good and
bad paths.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Datasheet: https://www.lcsc.com/product-detail/C5129967.html
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
LLM was used to implement the mreg back switching support.
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h      | 166 ++++++++-----
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 288 +++++++++++++++++++++--
 2 files changed, 375 insertions(+), 79 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 674a9896fabb3..eecf4c46cbdb0 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -167,31 +167,59 @@ struct inv_icm42607_sensor_state {
 	int filter;
 };
 
-/* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
+/*
+ * Virtual register addresses: bank id in the upper byte, register address in
+ * the lower byte. Bank 0 is directly addressable on the bus. MREG banks are
+ * reached through the BLK_SEL/MADDR/M indirect access window, one byte per
+ * transaction (datasheet section 13, no burst support).
+ *
+ * MREG1 programs BLK_SEL = 0x00, which collides with the direct bank, so it
+ * gets the distinct virtual id 0x01. MREG2 and MREG3 virtual ids match their
+ * BLK_SEL values.
+ */
+#define INV_ICM42607_REG_BANK_MASK			GENMASK(15, 8)
+#define INV_ICM42607_REG_ADDR_MASK			GENMASK(7, 0)
+
+#define INV_ICM42607_BANK0					0x00
+#define INV_ICM42607_MREG1					0x01
+#define INV_ICM42607_MREG2					0x28
+#define INV_ICM42607_MREG3					0x50
+
+/* BLK_SEL value written to the device for each virtual bank id. */
+#define INV_ICM42607_MREG1_BLK_SEL			0x00
+#define INV_ICM42607_MREG2_BLK_SEL			0x28
+#define INV_ICM42607_MREG3_BLK_SEL			0x50
+
+/*
+ * Datasheet section 13, Accessing MREGx Registers: no bus access for 10us
+ * after programming the indirect access window.
+ */
+#define INV_ICM42607_MREG_ACCESS_DELAY_US		10
 
 /* Register Map for User Bank 0 */
-#define INV_ICM42607_REG_MCLK_RDY			0x00
+#define INV_ICM42607_REG_MCLK_RDY			0x0000
+#define INV_ICM42607_MCLK_RDY_BIT			BIT(3)
 
-#define INV_ICM42607_REG_DEVICE_CONFIG			0x01
+#define INV_ICM42607_REG_DEVICE_CONFIG			0x0001
 #define INV_ICM42607_DEVICE_CONFIG_SPI_AP_4WIRE		BIT(2)
 #define INV_ICM42607_DEVICE_CONFIG_SPI_MODE		BIT(0)
 
-#define INV_ICM42607_REG_SIGNAL_PATH_RESET		0x02
+#define INV_ICM42607_REG_SIGNAL_PATH_RESET		0x0002
 #define INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET	BIT(4)
 #define INV_ICM42607_SIGNAL_PATH_RESET_FIFO_FLUSH	BIT(2)
 
-#define INV_ICM42607_REG_DRIVE_CONFIG1			0x03
+#define INV_ICM42607_REG_DRIVE_CONFIG1			0x0003
 #define INV_ICM42607_DRIVE_CONFIG1_I3C_DDR_MASK		GENMASK(5, 3)
 #define INV_ICM42607_DRIVE_CONFIG1_I3C_SDR_MASK		GENMASK(2, 0)
 
-#define INV_ICM42607_REG_DRIVE_CONFIG2			0x04
+#define INV_ICM42607_REG_DRIVE_CONFIG2			0x0004
 #define INV_ICM42607_DRIVE_CONFIG2_I2C_MASK		GENMASK(5, 3)
 #define INV_ICM42607_DRIVE_CONFIG2_ALL_MASK		GENMASK(2, 0)
 
-#define INV_ICM42607_REG_DRIVE_CONFIG3			0x05
+#define INV_ICM42607_REG_DRIVE_CONFIG3			0x0005
 #define INV_ICM42607_DRIVE_CONFIG3_SPI_MASK		GENMASK(2, 0)
 
-#define INV_ICM42607_REG_INT_CONFIG			0x06
+#define INV_ICM42607_REG_INT_CONFIG			0x0006
 #define INV_ICM42607_INT_CONFIG_INT2_LATCHED		BIT(5)
 #define INV_ICM42607_INT_CONFIG_INT2_PUSH_PULL		BIT(4)
 #define INV_ICM42607_INT_CONFIG_INT2_ACTIVE_HIGH	BIT(3)
@@ -202,81 +230,81 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_INT_CONFIG_INT1_ACTIVE_LOW		0x00
 
 /* all sensor data are 16 bits (2 registers wide) in big-endian */
-#define INV_ICM42607_REG_TEMP_DATA1			0x09
-#define INV_ICM42607_REG_TEMP_DATA0			0x0A
-#define INV_ICM42607_REG_ACCEL_DATA_X1			0x0B
-#define INV_ICM42607_REG_ACCEL_DATA_X0			0x0C
-#define INV_ICM42607_REG_ACCEL_DATA_Y1			0x0D
-#define INV_ICM42607_REG_ACCEL_DATA_Y0			0x0E
-#define INV_ICM42607_REG_ACCEL_DATA_Z1			0x0F
-#define INV_ICM42607_REG_ACCEL_DATA_Z0			0x10
-#define INV_ICM42607_REG_GYRO_DATA_X1			0x11
-#define INV_ICM42607_REG_GYRO_DATA_X0			0x12
-#define INV_ICM42607_REG_GYRO_DATA_Y1			0x13
-#define INV_ICM42607_REG_GYRO_DATA_Y0			0x14
-#define INV_ICM42607_REG_GYRO_DATA_Z1			0x15
-#define INV_ICM42607_REG_GYRO_DATA_Z0			0x16
+#define INV_ICM42607_REG_TEMP_DATA1			0x0009
+#define INV_ICM42607_REG_TEMP_DATA0			0x000A
+#define INV_ICM42607_REG_ACCEL_DATA_X1			0x000B
+#define INV_ICM42607_REG_ACCEL_DATA_X0			0x000C
+#define INV_ICM42607_REG_ACCEL_DATA_Y1			0x000D
+#define INV_ICM42607_REG_ACCEL_DATA_Y0			0x000E
+#define INV_ICM42607_REG_ACCEL_DATA_Z1			0x000F
+#define INV_ICM42607_REG_ACCEL_DATA_Z0			0x0010
+#define INV_ICM42607_REG_GYRO_DATA_X1			0x0011
+#define INV_ICM42607_REG_GYRO_DATA_X0			0x0012
+#define INV_ICM42607_REG_GYRO_DATA_Y1			0x0013
+#define INV_ICM42607_REG_GYRO_DATA_Y0			0x0014
+#define INV_ICM42607_REG_GYRO_DATA_Z1			0x0015
+#define INV_ICM42607_REG_GYRO_DATA_Z0			0x0016
 #define INV_ICM42607_DATA_INVALID			-32768
 
-#define INV_ICM42607_REG_TMST_FSYNCH			0x17
-#define INV_ICM42607_REG_TMST_FSYNCL			0x18
+#define INV_ICM42607_REG_TMST_FSYNCH			0x0017
+#define INV_ICM42607_REG_TMST_FSYNCL			0x0018
 
 /* APEX Data Registers */
-#define INV_ICM42607_REG_APEX_DATA0			0x31
-#define INV_ICM42607_REG_APEX_DATA1			0x32
-#define INV_ICM42607_REG_APEX_DATA2			0x33
-#define INV_ICM42607_REG_APEX_DATA3			0x34
-#define INV_ICM42607_REG_APEX_DATA4			0x1D
-#define INV_ICM42607_REG_APEX_DATA5			0x1E
-
-#define INV_ICM42607_REG_PWR_MGMT0			0x1F
+#define INV_ICM42607_REG_APEX_DATA0			0x0031
+#define INV_ICM42607_REG_APEX_DATA1			0x0032
+#define INV_ICM42607_REG_APEX_DATA2			0x0033
+#define INV_ICM42607_REG_APEX_DATA3			0x0034
+#define INV_ICM42607_REG_APEX_DATA4			0x001D
+#define INV_ICM42607_REG_APEX_DATA5			0x001E
+
+#define INV_ICM42607_REG_PWR_MGMT0			0x001F
 #define INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL		BIT(7)
 #define INV_ICM42607_PWR_MGMT0_IDLE			BIT(4)
 #define INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK		GENMASK(3, 2)
 #define INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK		GENMASK(1, 0)
 
-#define INV_ICM42607_REG_GYRO_CONFIG0			0x20
+#define INV_ICM42607_REG_GYRO_CONFIG0			0x0020
 #define INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK		GENMASK(6, 5)
 #define INV_ICM42607_GYRO_CONFIG0_ODR_MASK		GENMASK(3, 0)
 
-#define INV_ICM42607_REG_ACCEL_CONFIG0			0x21
+#define INV_ICM42607_REG_ACCEL_CONFIG0			0x0021
 #define INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK		GENMASK(6, 5)
 #define INV_ICM42607_ACCEL_CONFIG0_ODR_MASK		GENMASK(3, 0)
 
-#define INV_ICM42607_REG_TEMP_CONFIG0			0x22
+#define INV_ICM42607_REG_TEMP_CONFIG0			0x0022
 #define INV_ICM42607_TEMP_CONFIG0_FILTER_MASK		GENMASK(6, 4)
 
-#define INV_ICM42607_REG_GYRO_CONFIG1			0x23
+#define INV_ICM42607_REG_GYRO_CONFIG1			0x0023
 #define INV_ICM42607_GYRO_CONFIG1_FILTER_MASK		GENMASK(2, 0)
 
-#define INV_ICM42607_REG_ACCEL_CONFIG1			0x24
+#define INV_ICM42607_REG_ACCEL_CONFIG1			0x0024
 #define INV_ICM42607_ACCEL_CONFIG1_AVG_MASK		GENMASK(6, 4)
 #define INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK		GENMASK(2, 0)
 
-#define INV_ICM42607_REG_APEX_CONFIG0			0x25
+#define INV_ICM42607_REG_APEX_CONFIG0			0x0025
 #define INV_ICM42607_APEX_CONFIG0_DMP_POWER_SAVE_EN	BIT(3)
 #define INV_ICM42607_APEX_CONFIG0_DMP_INIT_EN		BIT(2)
 #define INV_ICM42607_APEX_CONFIG0_DMP_MEM_RESET_EN	BIT(0)
 
-#define INV_ICM42607_REG_APEX_CONFIG1			0x26
+#define INV_ICM42607_REG_APEX_CONFIG1			0x0026
 #define INV_ICM42607_APEX_CONFIG1_SMD_ENABLE		BIT(6)
 #define INV_ICM42607_APEX_CONFIG1_FF_ENABLE		BIT(5)
 #define INV_ICM42607_APEX_CONFIG1_TILT_ENABLE		BIT(4)
 #define INV_ICM42607_APEX_CONFIG1_PED_ENABLE		BIT(3)
 #define INV_ICM42607_APEX_CONFIG1_DMP_ODR_MASK		GENMASK(1, 0)
 
-#define INV_ICM42607_REG_WOM_CONFIG			0x27
+#define INV_ICM42607_REG_WOM_CONFIG			0x0027
 #define INV_ICM42607_WOM_CONFIG_INT_DUR_MASK		GENMASK(4, 3)
 #define INV_ICM42607_WOM_CONFIG_INT_MODE		BIT(2)
 #define INV_ICM42607_WOM_CONFIG_MODE			BIT(1)
 #define INV_ICM42607_WOM_CONFIG_EN			BIT(0)
 
-#define INV_ICM42607_REG_FIFO_CONFIG1			0x28
+#define INV_ICM42607_REG_FIFO_CONFIG1			0x0028
 #define INV_ICM42607_FIFO_CONFIG1_MODE			BIT(1)
 #define INV_ICM42607_FIFO_CONFIG1_BYPASS		BIT(0)
 
-#define INV_ICM42607_REG_FIFO_CONFIG2			0x29
-#define INV_ICM42607_REG_FIFO_CONFIG3			0x2A
+#define INV_ICM42607_REG_FIFO_CONFIG2			0x0029
+#define INV_ICM42607_REG_FIFO_CONFIG3			0x002A
 #define INV_ICM42607_FIFO_WATERMARK_VAL(_wm)		\
 		cpu_to_le16((_wm) & GENMASK(11, 0))
 /* FIFO is 2048 bytes, let 12 samples for reading latency */
@@ -284,7 +312,7 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE		8
 #define INV_ICM42607_FIFO_2SENSORS_PACKET_SIZE		16
 
-#define INV_ICM42607_REG_INT_SOURCE0			0x2B
+#define INV_ICM42607_REG_INT_SOURCE0			0x002B
 #define INV_ICM42607_INT_SOURCE0_ST_INT1_EN		BIT(7)
 #define INV_ICM42607_INT_SOURCE0_FSYNC_INT1_EN		BIT(6)
 #define INV_ICM42607_INT_SOURCE0_PLL_RDY_INT1_EN	BIT(5)
@@ -294,12 +322,12 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_INT_SOURCE0_FIFO_FULL_INT1_EN	BIT(1)
 #define INV_ICM42607_INT_SOURCE0_AGC_RDY_INT1_EN	BIT(0)
 
-#define INV_ICM42607_REG_INT_SOURCE1			0x2C
+#define INV_ICM42607_REG_INT_SOURCE1			0x002C
 #define INV_ICM42607_INT_SOURCE1_I3C_ERROR_INT1_EN	BIT(6)
 #define INV_ICM42607_INT_SOURCE1_SMD_INT1_EN		BIT(3)
 #define INV_ICM42607_INT_SOURCE1_WOM_INT1_EN		GENMASK(2, 0)
 
-#define INV_ICM42607_REG_INT_SOURCE3			0x2D
+#define INV_ICM42607_REG_INT_SOURCE3			0x002D
 #define INV_ICM42607_INT_SOURCE3_ST_INT2_EN		BIT(7)
 #define INV_ICM42607_INT_SOURCE3_FSYNC_INT2_EN		BIT(6)
 #define INV_ICM42607_INT_SOURCE3_PLL_RDY_INT2_EN	BIT(5)
@@ -309,17 +337,17 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_INT_SOURCE3_FIFO_FULL_INT2_EN	BIT(1)
 #define INV_ICM42607_INT_SOURCE3_AGC_RDY_INT2_EN	BIT(0)
 
-#define INV_ICM42607_REG_INT_SOURCE4			0x2E
+#define INV_ICM42607_REG_INT_SOURCE4			0x002E
 #define INV_ICM42607_INT_SOURCE4_I3C_ERROR_INT2_EN	BIT(6)
 #define INV_ICM42607_INT_SOURCE4_SMD_INT2_EN		BIT(3)
 #define INV_ICM42607_INT_SOURCE4_WOM_Z_INT2_EN		BIT(2)
 #define INV_ICM42607_INT_SOURCE4_WOM_Y_INT2_EN		BIT(1)
 #define INV_ICM42607_INT_SOURCE4_WOM_X_INT2_EN		BIT(0)
 
-#define INV_ICM42607_REG_FIFO_LOST_PKT0			0x2F
-#define INV_ICM42607_REG_FIFO_LOST_PKT1			0x30
+#define INV_ICM42607_REG_FIFO_LOST_PKT0			0x002F
+#define INV_ICM42607_REG_FIFO_LOST_PKT1			0x0030
 
-#define INV_ICM42607_REG_INTF_CONFIG0			0x35
+#define INV_ICM42607_REG_INTF_CONFIG0			0x0035
 #define INV_ICM42607_INTF_CONFIG0_FIFO_COUNT_FORMAT	BIT(6)
 #define INV_ICM42607_INTF_CONFIG0_FIFO_COUNT_ENDIAN	BIT(5)
 #define INV_ICM42607_INTF_CONFIG0_SENSOR_DATA_ENDIAN	BIT(4)
@@ -327,7 +355,7 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_SPI_DIS	2
 #define INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_I2C_DIS	3
 
-#define INV_ICM42607_REG_INTF_CONFIG1			0x36
+#define INV_ICM42607_REG_INTF_CONFIG1			0x0036
 #define INV_ICM42607_INTF_CONFIG1_I3C_SDR_EN		BIT(3)
 #define INV_ICM42607_INTF_CONFIG1_I3C_DDR_EN		BIT(2)
 #define INV_ICM42607_INTF_CONFIG1_CLKSEL_MASK		GENMASK(1, 0)
@@ -335,10 +363,10 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_INTF_CONFIG1_CLKSEL_PLL		1
 #define INV_ICM42607_INTF_CONFIG1_CLKSEL_OFF		2
 
-#define INV_ICM42607_REG_INT_STATUS_DRDY		0x39
+#define INV_ICM42607_REG_INT_STATUS_DRDY		0x0039
 #define INV_ICM42607_INT_STATUS_DRDY_DATA_RDY		BIT(0)
 
-#define INV_ICM42607_REG_INT_STATUS			0x3A
+#define INV_ICM42607_REG_INT_STATUS			0x003A
 #define INV_ICM42607_INT_STATUS_ST			BIT(7)
 #define INV_ICM42607_INT_STATUS_FSYNC			BIT(6)
 #define INV_ICM42607_INT_STATUS_PLL_RDY			BIT(5)
@@ -347,11 +375,11 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_INT_STATUS_FIFO_FULL		BIT(1)
 #define INV_ICM42607_INT_STATUS_AGC_RDY			BIT(0)
 
-#define INV_ICM42607_REG_INT_STATUS2			0x3B
+#define INV_ICM42607_REG_INT_STATUS2			0x003B
 #define INV_ICM42607_INT_STATUS2_SMD			BIT(3)
 #define INV_ICM42607_INT_STATUS2_WOM_INT		GENMASK(2, 0)
 
-#define INV_ICM42607_REG_INT_STATUS3			0x3C
+#define INV_ICM42607_REG_INT_STATUS3			0x003C
 #define INV_ICM42607_INT_STATUS3_STEP_DET		BIT(5)
 #define INV_ICM42607_INT_STATUS3_STEP_CNT_OVF		BIT(4)
 #define INV_ICM42607_INT_STATUS3_TILT_DET		BIT(3)
@@ -362,15 +390,35 @@ struct inv_icm42607_sensor_state {
  * FIFO count is 16 bits (2 registers) big-endian
  * FIFO data is a continuous read register to read FIFO content
  */
-#define INV_ICM42607_REG_FIFO_COUNTH			0x3D
-#define INV_ICM42607_REG_FIFO_COUNTL			0x3E
-#define INV_ICM42607_REG_FIFO_DATA			0x3F
+#define INV_ICM42607_REG_FIFO_COUNTH			0x003D
+#define INV_ICM42607_REG_FIFO_COUNTL			0x003E
+#define INV_ICM42607_REG_FIFO_DATA			0x003F
 
-#define INV_ICM42607_REG_WHOAMI				0x75
+#define INV_ICM42607_REG_WHOAMI				0x0075
 #define INV_ICM42370P_WHOAMI				0x0D
 #define INV_ICM42607P_WHOAMI				0x60
 #define INV_ICM42607_WHOAMI				0x67
 
+#define INV_ICM42607_REG_BLK_SEL_W			0x0079
+#define INV_ICM42607_REG_MADDR_W			0x007A
+#define INV_ICM42607_REG_M_W				0x007B
+#define INV_ICM42607_REG_BLK_SEL_R			0x007C
+#define INV_ICM42607_REG_MADDR_R			0x007D
+#define INV_ICM42607_REG_M_R				0x007E
+
+/* User Bank MREG 1 registers */
+#define INV_ICM42607_REG_OFFSET_USER0			0x014E
+#define INV_ICM42607_REG_OFFSET_USER1			0x014F
+#define INV_ICM42607_REG_OFFSET_USER2			0x0150
+#define INV_ICM42607_REG_OFFSET_USER3			0x0151
+#define INV_ICM42607_REG_OFFSET_USER4			0x0152
+#define INV_ICM42607_REG_OFFSET_USER5			0x0153
+#define INV_ICM42607_REG_OFFSET_USER6			0x0154
+#define INV_ICM42607_REG_OFFSET_USER7			0x0155
+#define INV_ICM42607_REG_OFFSET_USER8			0x0156
+
+/* User Bank MREG 3 registers */
+#define INV_ICM42607_REG_ZG_ST_DATA			0x5005
 /*
  * Timings as listed in section 3 of datasheet, all values listed in datasheet
  * in ms except temp startup time... setting all values in us and using
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 5ab15525c63f7..f73730493e529 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -18,62 +18,303 @@
 #include <linux/time.h>
 #include <linux/timekeeping.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 
 #include <asm/byteorder.h>
 
 #include "inv_icm42607.h"
 
-static bool inv_icm42607_is_readable_reg(struct device *dev, unsigned int reg)
+static int inv_icm42607_mclk_get(struct regmap *map, bool *idle_set)
 {
-	switch (reg) {
-	case INV_ICM42607_REG_MCLK_RDY ... INV_ICM42607_REG_INT_CONFIG:
-	case INV_ICM42607_REG_TEMP_DATA1 ... INV_ICM42607_REG_TMST_FSYNCL:
-	case INV_ICM42607_REG_APEX_DATA4 ... INV_ICM42607_REG_INTF_CONFIG1:
-	case INV_ICM42607_REG_INT_STATUS_DRDY ... INV_ICM42607_REG_FIFO_DATA:
-	case INV_ICM42607_REG_WHOAMI:
-		return true;
+	unsigned int val;
+	int ret, ret2;
+
+	*idle_set = false;
+
+	ret = regmap_test_bits(map, INV_ICM42607_REG_MCLK_RDY,
+			       INV_ICM42607_MCLK_RDY_BIT);
+	if (ret < 0)
+		return ret;
+	if (ret)
+		return 0;
+
+	/*
+	 * Clock isn't running: we're either in Sleep mode or in Accel LP mode
+	 * running on WUOSC. Force the RC oscillator on via IDLE and wait for
+	 * MCLK_RDY. Datasheet gives 10us (accel startup) to 200us (accel
+	 * transition from OFF) for this to complete.
+	 */
+	ret = regmap_set_bits(map, INV_ICM42607_REG_PWR_MGMT0,
+			      INV_ICM42607_PWR_MGMT0_IDLE);
+	if (ret)
+		return ret;
+
+	*idle_set = true;
+
+	ret = regmap_read_poll_timeout(map, INV_ICM42607_REG_MCLK_RDY, val,
+				       val & INV_ICM42607_MCLK_RDY_BIT, 10, 200);
+	if (ret) {
+		ret2 = regmap_clear_bits(map, INV_ICM42607_REG_PWR_MGMT0,
+					 INV_ICM42607_PWR_MGMT0_IDLE);
+		if (ret2)
+			dev_dbg(regmap_get_device(map),
+				"failed to clear IDLE after MCLK timeout: %d\n", ret2);
+		else
+			*idle_set = false;
 	}
 
-	return false;
+	return ret;
 }
 
-static bool inv_icm42607_is_writeable_reg(struct device *dev, unsigned int reg)
+static int inv_icm42607_mclk_put(struct regmap *map, bool idle_set)
 {
-	switch (reg) {
-	case INV_ICM42607_REG_DEVICE_CONFIG ... INV_ICM42607_REG_INT_CONFIG:
-	case INV_ICM42607_REG_PWR_MGMT0 ... INV_ICM42607_REG_INT_SOURCE4:
-	case INV_ICM42607_REG_INTF_CONFIG0 ... INV_ICM42607_REG_INTF_CONFIG1:
-		return true;
+	if (!idle_set)
+		return 0;
+
+	return regmap_clear_bits(map, INV_ICM42607_REG_PWR_MGMT0, INV_ICM42607_PWR_MGMT0_IDLE);
+}
+
+/* Only compute the BLK_SEL value, the device is not accessed. */
+static int inv_icm42607_reg_to_blk_sel(unsigned int reg, u8 *blk_sel)
+{
+	u8 bank = FIELD_GET(INV_ICM42607_REG_BANK_MASK, reg);
+
+	switch (bank) {
+	case INV_ICM42607_MREG1:
+		*blk_sel = INV_ICM42607_MREG1_BLK_SEL;
+		return 0;
+	case INV_ICM42607_MREG2:
+	case INV_ICM42607_MREG3:
+		*blk_sel = bank;
+		return 0;
+	default:
+		return -EINVAL;
 	}
+}
 
-	return false;
+/*
+ * The internal clock must be running before starting an MREG access, then the
+ * bank is selected in BLK_SEL_R or BLK_SEL_W (datasheet section 13).
+ */
+static int inv_icm42607_switch_to_mreg(struct regmap *map, unsigned int reg,
+				       unsigned int blk_sel_reg, bool *idle_set)
+{
+	u8 blk_sel;
+	int ret;
+
+	ret = inv_icm42607_reg_to_blk_sel(reg, &blk_sel);
+	if (ret)
+		return ret;
+
+	ret = inv_icm42607_mclk_get(map, idle_set);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(map, blk_sel_reg, blk_sel);
+	if (ret) {
+		inv_icm42607_mclk_put(map, *idle_set);
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * BLK_SEL must be restored to 0 after entering MREG bank (datasheet section 13) do it
+ * while the internal clock is still forced on.
+ */
+static int inv_icm42607_switch_from_mreg(struct regmap *map,
+					 unsigned int blk_sel_reg, bool idle_set)
+{
+	int ret;
+
+	ret = regmap_write(map, blk_sel_reg, 0);
+	if (ret) {
+		inv_icm42607_mclk_put(map, idle_set);
+		return ret;
+	}
+
+	return inv_icm42607_mclk_put(map, idle_set);
 }
 
+static int inv_icm42607_mreg_read(struct regmap *map, unsigned int reg,
+				  u8 *data, size_t count)
+{
+	unsigned int val;
+	bool idle_set;
+	int ret;
+
+	/* MREG access is one byte per transaction, no burst support. */
+	if (count != 1)
+		return -EINVAL;
+
+	ret = inv_icm42607_switch_to_mreg(map, reg, INV_ICM42607_REG_BLK_SEL_R,
+					  &idle_set);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(map, INV_ICM42607_REG_MADDR_R,
+			   FIELD_GET(INV_ICM42607_REG_ADDR_MASK, reg));
+	if (ret)
+		goto err_switch_from_mreg;
+
+	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
+
+	ret = regmap_read(map, INV_ICM42607_REG_M_R, &val);
+	if (ret)
+		goto err_switch_from_mreg;
+
+	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
+
+	ret = inv_icm42607_switch_from_mreg(map, INV_ICM42607_REG_BLK_SEL_R,
+					    idle_set);
+	if (ret)
+		return ret;
+
+	*data = val;
+
+	return 0;
+
+err_switch_from_mreg:
+	/* The access may have been started, respect the access delay. */
+	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
+	inv_icm42607_switch_from_mreg(map, INV_ICM42607_REG_BLK_SEL_R, idle_set);
+
+	return ret;
+}
+
+static int inv_icm42607_mreg_write(struct regmap *map, unsigned int reg,
+				   const u8 *data, size_t count)
+{
+	bool idle_set;
+	int ret;
+
+	/* MREG access is one byte per transaction, no burst support. */
+	if (count != 1)
+		return -EINVAL;
+
+	ret = inv_icm42607_switch_to_mreg(map, reg, INV_ICM42607_REG_BLK_SEL_W,
+					  &idle_set);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(map, INV_ICM42607_REG_MADDR_W,
+			   FIELD_GET(INV_ICM42607_REG_ADDR_MASK, reg));
+	if (ret)
+		goto err_switch_from_mreg;
+
+	ret = regmap_write(map, INV_ICM42607_REG_M_W, *data);
+	if (ret)
+		goto err_switch_from_mreg;
+
+	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
+
+	return inv_icm42607_switch_from_mreg(map, INV_ICM42607_REG_BLK_SEL_W,
+					     idle_set);
+
+err_switch_from_mreg:
+	/* The access may have been started, respect the access delay. */
+	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
+	inv_icm42607_switch_from_mreg(map, INV_ICM42607_REG_BLK_SEL_W, idle_set);
+
+	return ret;
+}
+
+static int inv_icm42607_read(void *context, const void *reg_buf, size_t reg_size,
+			     void *val_buf, size_t val_size)
+{
+	u16 reg = get_unaligned_be16(reg_buf);
+	struct regmap *map = context;
+
+	if (FIELD_GET(INV_ICM42607_REG_BANK_MASK, reg) != INV_ICM42607_BANK0)
+		return inv_icm42607_mreg_read(map, reg, val_buf, val_size);
+
+	return regmap_bulk_read(map, FIELD_GET(INV_ICM42607_REG_ADDR_MASK, reg),
+				val_buf, val_size);
+}
+
+static int inv_icm42607_write(void *context, const void *data, size_t count)
+{
+	unsigned int reg = get_unaligned_be16(data);
+	struct regmap *map = context;
+	const u8 *d = data;
+
+	if (FIELD_GET(INV_ICM42607_REG_BANK_MASK, reg) != INV_ICM42607_BANK0)
+		return inv_icm42607_mreg_write(map, reg, d + 2, count - 2);
+
+	return regmap_bulk_write(map, FIELD_GET(INV_ICM42607_REG_ADDR_MASK, reg),
+				 d + 2, count - 2);
+}
+
+static const struct regmap_bus inv_icm42607_regmap_bus = {
+	.read = inv_icm42607_read,
+	.write = inv_icm42607_write,
+};
+
 static bool inv_icm42607_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case INV_ICM42607_REG_MCLK_RDY:
 	case INV_ICM42607_REG_SIGNAL_PATH_RESET:
 	case INV_ICM42607_REG_TEMP_DATA1 ... INV_ICM42607_REG_APEX_DATA5:
+	/* PWR_MGMT0 IDLE bit is toggled behind the cache during MREG access. */
+	case INV_ICM42607_REG_PWR_MGMT0:
 	case INV_ICM42607_REG_APEX_CONFIG0:
 	case INV_ICM42607_REG_FIFO_LOST_PKT0 ... INV_ICM42607_REG_APEX_DATA3:
 	case INV_ICM42607_REG_INT_STATUS_DRDY:
 	case INV_ICM42607_REG_INT_STATUS ... INV_ICM42607_REG_FIFO_DATA:
+	case INV_ICM42607_REG_BLK_SEL_W ... INV_ICM42607_REG_M_R:
 		return true;
 	}
 
 	return false;
 }
 
-const struct regmap_config inv_icm42607_regmap_config = {
-	.reg_bits = 8,
+static bool inv_icm42607_is_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case INV_ICM42607_REG_MCLK_RDY ... INV_ICM42607_REG_INT_CONFIG:
+	case INV_ICM42607_REG_TEMP_DATA1 ... INV_ICM42607_REG_TMST_FSYNCL:
+	case INV_ICM42607_REG_APEX_DATA4 ... INV_ICM42607_REG_INTF_CONFIG1:
+	case INV_ICM42607_REG_INT_STATUS_DRDY ... INV_ICM42607_REG_FIFO_DATA:
+	case INV_ICM42607_REG_WHOAMI:
+	case INV_ICM42607_REG_OFFSET_USER0 ... INV_ICM42607_REG_OFFSET_USER8:
+		return true;
+	}
+
+	return false;
+}
+
+static bool inv_icm42607_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case INV_ICM42607_REG_DEVICE_CONFIG ... INV_ICM42607_REG_INT_CONFIG:
+	case INV_ICM42607_REG_PWR_MGMT0 ... INV_ICM42607_REG_INT_SOURCE4:
+	case INV_ICM42607_REG_INTF_CONFIG0 ... INV_ICM42607_REG_INTF_CONFIG1:
+	case INV_ICM42607_REG_OFFSET_USER0 ... INV_ICM42607_REG_OFFSET_USER8:
+		return true;
+	}
+
+	return false;
+}
+
+static const struct regmap_config inv_icm42607_virt_regmap_config = {
+	.name = "banks",
+	.reg_bits = 16,
 	.val_bits = 8,
+	.use_single_write = true,
 	.writeable_reg = inv_icm42607_is_writeable_reg,
 	.readable_reg = inv_icm42607_is_readable_reg,
 	.volatile_reg = inv_icm42607_is_volatile_reg,
-	.max_register = INV_ICM42607_REG_WHOAMI,
+	.max_register = INV_ICM42607_REG_ZG_ST_DATA,
 	.cache_type = REGCACHE_MAPLE,
 };
+
+/* regmap configuration for the transport regmap used by both I2C and SPI */
+const struct regmap_config inv_icm42607_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
 EXPORT_SYMBOL_NS_GPL(inv_icm42607_regmap_config, "IIO_ICM42607");
 
 /* chip initial default configuration */
@@ -620,8 +861,15 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 {
 	struct device *dev = regmap_get_device(regmap);
 	struct inv_icm42607_state *st;
+	struct regmap *regmap_custom;
 	int ret;
 
+	regmap_custom = devm_regmap_init(dev, &inv_icm42607_regmap_bus, regmap,
+					 &inv_icm42607_virt_regmap_config);
+	if (IS_ERR(regmap_custom))
+		return dev_err_probe(dev, PTR_ERR(regmap_custom),
+				     "Failed to register regmap\n");
+
 	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return -ENOMEM;
@@ -633,7 +881,7 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 		return ret;
 
 	st->hw = hw;
-	st->map = regmap;
+	st->map = regmap_custom;
 
 	ret = iio_read_mount_matrix(dev, &st->orientation);
 	if (ret)

-- 
2.43.0

