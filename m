Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793893755;
	b=lZ3ilj+g6RZ/wZvFdm3jJ7KHvEjzBZ9HzHhuC8o3O9VYWipA6W4ZgB41U6j+zBW/uHei
	 UYC7jcTm1qyIsjW+S6Ynad2wzVnUjmGWfbIuAEWYd1wb4F8FrePHx0O+Jt3/Vc/hBVl0b
	 jczjo8DvxenkhfAgawnlr069KroACkGNmdUwQPtAmDVnLXCZRvhIA/+kZMoPm+KnkrNg/
	 KqE3dUUstdRDA6x2JG1aU2OsRfRIlC1ZLX6FyJL8vBpVqRkRrogY6iNevVjNWt0x3q4S+
	 NQDS/0m7PMHNXghYEYdjRhddQDQT2TXO8iYh2q0wxlZx1OU+mUtfYQcekXSfHtjhXXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893755;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
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
	bh=IXLpNNMQu0LWH+vR/Rl/gZiLQk/aYFsG0B6/l2Hi5ZM=;
	b=esrtiSRWE/k6Qv515Q2fMtyRSfls0wazE/KzNMbKUp2Xpep5jgL2anw/RN93dsKUEHbX
	 OJAFTvQeYxK0WWkhVemS6mKGSz6qh+1q0vdukmIeQuJNv80dV2cO7C8+Kz9BWr9JQf1T7
	 fs888lX5eNYQUyzjwwiLSOmjLnxt81G4XO4wKWWtBCNg/JcZv/ARpMmUCT/x59CehdtR3
	 xamj+2g4oxQZpOh7JXfqElvauYwNYooJkwHBormCWjYI5bVka8Oy1v9KReA0GPMJVcyU0
	 YVidkZqZu+nOzkiV/ZPi1kHWcTq4ELnET23XxUDX+1ZqvRjEqJR5QqbPQ4T3JJYceAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b="YSiR/5hB";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.9
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCFD6082BCB;
	Thu,  5 Nov 2026 15:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CCFD6082BCB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=YSiR/5hB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXdGDS77ukFWSHkMrqxURqXGZUL0taiPaan/mtPLWYhIRSJzMoZ1+4URWFTbhs5nTFE59hTNQ6bqqxDUHNYQZLn66kdYe+KyRKSbqWhYi5Bjduhv70SEyJuTfvqIprTm0qbCBAXBFsZOfn5NRLrQXhPJOtrcxsjlj1i8N3Axteql+4ywarl4j0OLy2ytwdlz8Gbv3WrMzP+fP9bNRm2VzNmNkRi5x3FnTblnueF827RDi4rHEdymWv9l7gHROXOR4wy7+Bbj9FDl7h0GkfNFzMC/mgWO7LkgTSk5pciP4cNfK1RUUxJtiNIc4urbEgAtvwz0Qk9TgOFDNcmqHc1zPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXLpNNMQu0LWH+vR/Rl/gZiLQk/aYFsG0B6/l2Hi5ZM=;
 b=jMWU+1YRro0Zgm+v1V1pdj1/OQ7baSUyZyWr2GtYDeoPylNhB+S2fio6VDDVlRmz9BE5NPLYCxQFaxkJzQ2qPJJ9aNEkR3pcjDOmsUkF9/9FqSCTMqUb3q3pPQOxNvbGeKLNShJ4KMTmIOO3b04mQPj8/M+jLGOIL/iOUrp+j//6VFERHJA4AD48nQT/um52o5LobmTo1f//4Vc9JxvjUNTDvBsc3d1ebhB8LnI2lzAafMmanUaeyNvUijtOhuIjwlbfzmR3dRSJ3D3PNo7Wmdc9Q0Pkbp51oZoem5X9EeHvCwLwZLgv7M2BdRuAMKJv9f4y2V0tyapDbpYaeh4qdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXLpNNMQu0LWH+vR/Rl/gZiLQk/aYFsG0B6/l2Hi5ZM=;
 b=YSiR/5hBx74W4w7gKQvfxzS3jl/gTCCKcZPmJw8aL8997B7wwBGC6v3o2Gk6ssIyRrc5x+H0/nbvt5FmUvfzLU7ij41jnbvxp7xCTqX9NOa8RRhsuu1c6ex4iANMZBwos6RcehjbrVpfb5HMgNqmgOdieXcOTeh+PuHcOwBD4Wc=
Received: from DUZPR01CA0202.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::13) by DU4PR02MB11124.eurprd02.prod.outlook.com
 (2603:10a6:10:58e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:49:10 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:4b6:cafe::8d) by DUZPR01CA0202.outlook.office365.com
 (2603:10a6:10:4b6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 15:49:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 15:49:06 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Thu, 5 Nov
 2026 16:49:03 +0100
Received: from se-mail10w.axis.com (10.20.40.10) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 5 Nov
 2026 16:49:03 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 5 Nov 2026 16:49:03 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 828824D2B;
	Thu,  5 Nov 2026 16:49:03 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 75C62305D280; Thu,  5 Nov 2026 16:49:03 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 5 Nov 2026 16:48:50 +0100
Subject: [PATCH v8 2/7] dt-bindings: iio: imu: icm42600: Add ICM-42670-P
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
Message-ID: <20261105-b4-inv_icm42370p-v8-2-b44eb96020b6@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=PsgyAn2iUnCnZGLPXCZum8Q5tUlwLB/PSjOL3PJAjjY=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsh6szSvfYX+yxKNeCeZf3uuHJof8K721pkq/qVyrpGLi
 g8ndPHN6ShlYRDjYpAVU2Q5Z7Q9en/yP9050k6XYOawMoEMYeDiFICJhC5j+MPp21lWvVbd/u3b
 Wco1ORHX7we6sj/Z9Ygte5/g8517T99h+CtvbnLt8v8DV7i4/h98+Fl/74HsHX+D92sxfFJx/yB
 jpMgCAA==
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|DU4PR02MB11124:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba52530-e7d3-430d-8077-08df3b545325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|32650700020|7416014|23010399003|376014|1800799024|18002099003|22082099003|10067099003|13003099007|921020|56012099006|11063799006|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261021135927099003|261026140227099003|261009223027099003|261102123227099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	6gLWtCYTWrNYVAt1BuveZ0nTlPfuyHtYLMidzeDQVkUvRrYV2KF9ZVfAcy+IM/xVHBtK49LpRNEnEzMxLd7aXIzpH/Qkw8hjAv/jdbviUrAAmpxp20tldxJH3mDQjBt8GN0FFH84ULnP398W8WOoyQ+qcFfwZ+jbnwOFUq4baAFbJT8zFxEEFle/ABTbmaU4+RwK85gbISAk0Y2lMWtZvaep2SgE15gaVFWxSrdtqqNnNpPvU6s/NdtNmV+sgDb7cOsH3OwzEYitd1a4mux8Ldzo+ClXgX2UBk91kNFjZqY9v2UoTXt+3LQDIzAyxtmKyDAUA1Yzk8pm3fN6Py7Wqfzru81sQRfoPKoRKGFQxu83oPRszpgKyVA38pAHDbJjOSAYQZzhwxA0SuDV64UeDQynY90iAOhfSHfy5qxY99/tluq+Tt7ofvrEKAPcO8CRs5pWhoaaAQcqt2h9Y516DLO+Gwj/sat4Z+kGoqcfOULBxb6hmp7f1GWbU1I2fjKCLkIrY1mLUltsPNShyJpNSJ7rcHWFsqKrKqEfvMjWD/2hY2SioYW5rbyW9CFASSvEUhCUt6XqrvB+6ERwyhkXUK6Rkg8xCB1scP3Unnfb1ALICaLCEKteLz26CulwmS+nuCV3P0Q1kNNhIhqYsCkkM1gtqJGGyCZLMF9oNVPYroF9ebkBI3EE+noT/23770NphkIf5mft+oeIYFObpAR4pw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(32650700020)(7416014)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(13003099007)(921020)(56012099006)(11063799006)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261021135927099003)(261026140227099003)(261009223027099003)(261102123227099003)(261022075727099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KVuS65cq0rtZAKy+85Q6/NGe/h1LILgJt9ChyrZ4C6R8u3Mo+XezzBnxDgqjrmthhF6A7o0xVd8StJ5uJpEX40zm15gT3iTt1nC4pPcqBo/wXVCMwQVy/JPFQguJFwTXonQ7rZdMFr70rQOyXbeJAv3S67psIWWTUMb68kNVdQHX8WnKXSs57YDK3C3ajj52IhRJGjtWLhyUNkqBWK1HHY6ij0kTZhfs3WpAaqND/0tnc6eakoSIVdCfbeiqUIhEal/d5wCgtKfw1Gp5wzmrzG7aTwo+gY3WOYX9HQO3zvYOi7EeJ+kj/31nF0E/GiS7jFT9Zr9F4DtHDHoSW4R2Z/ceaK7zbeJ+OjfyYdH921giYbPBrCDZaA0GW8D652kPHdqkZChGzsirlDOF5pShYwte8p3vZ+YsGiNnkVA2vhPxJ08Tdx2DPk09CIUEQFlG
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:49:06.7654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba52530-e7d3-430d-8077-08df3b545325
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR02MB11124

TDK Invensense, ICM-42370-P is a 3-axis accelerometer. The device can
support I2C, SPI and I3C. This device only has an accelerometer and
lacks gyroscope and it has very similar properties as that of the
icm42607/p the gyroscope feature is controlled via the driver depending
on the device. Add this device to the existing dt-binding and update the
description to match the devices.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 8d16421c6f82e..7c5f42f384672 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -11,10 +11,11 @@ maintainers:
 
 description: |
   6-axis MotionTracking device that combines a 3-axis gyroscope and a 3-axis
-  accelerometer.
+  accelerometer. Some devices such as the Invensense, ICM-42370-P only has a
+  3-axis accelerometer.
 
   It has a configurable host interface that supports I3C, I2C and SPI serial
-  communication, features a 2kB FIFO and 2 programmable interrupts with
+  communication, features up to 2.25kB FIFO and 2 programmable interrupts with
   ultra-low-power wake-on-motion support to minimize system power consumption.
 
   Other industry-leading features include InvenSense on-chip APEX Motion
@@ -28,6 +29,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - invensense,icm42370p
           - invensense,icm42600
           - invensense,icm42602
           - invensense,icm42605

-- 
2.43.0

