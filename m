Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493892;
	b=ChPW8lRiQb8k1ivGs9U/3qX60pB5Z00uKuNc9OKf+yBI7XMZy4Akphi+wXz+WrF2YGEr
	 6eeBYaWEvUm8X+DeAgFDVBH9D5+5wyolOW/W5Sam9Ek0qE6y1P+HrxDBl/eq/U/ZWq2fI
	 K5SBMHymngg06Fdnhn/SFyWxoBlTbBhFghDX4D0E2L1Rs69uK66M+c99bh93l3quCtkoN
	 8p5mXcHHTRREqMyGni2BPqjDuALGghiEthi6R7zrJkb7GBHGz5ORwoEkBk7VgRStbjZ5Q
	 J1lefoB6lks4CH82WqVSANwC4QOLmhaziwtwR9OqtqsjemqrjxrTO/ecrF7JRt38lWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493892;
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
	bh=IXLpNNMQu0LWH+vR/Rl/gZiLQk/aYFsG0B6/l2Hi5ZM=;
	b=bbZt5yhJmQmjCxcibGaZGZOisryR+2l7uRx1ud8nDXkWO7ExByyJvjb6CdMNPxSPFPPv
	 xucM+SJDEVxtsbj/IU90u6eVwSr2/Ul6ijuTV8yFRdy+RmewVkQ71UBWsIsAGm/LUl3Vi
	 J9dIKzgSl0JsZ+o7aAm7ZekKdq46KLpW4s0i7KlR4fyBUyyQPIESkDbX9sGXJC8l2CrJG
	 o2X5Qs7cKhgPDMWwUc2NCCrgOdTX1JXlcgkdtf6aqklixloLmiRBO5MDKyCBeoRujviVT
	 mgRU13mJ7D85t75BkBuJcMMa0LBON5nQTV9YfSDdci5bRecVAkP3ZxNLu1/eNpko1AQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=oESIEg4L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.32
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3E606D544;
	Thu, 12 Nov 2026 14:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69C3E606D544
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=oESIEg4L
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sx+3G4HJOFfyXKaza+oAG+lCrpTwFon6N/q7NKXNn4IoPcTN6pGhuweh+caPrLWCsjgiStxhMSUEUd/bKfc3xSGoO5vJyFc/wlZ/zy5wUwIJj+a3v49mb5oJVKFZs7s8CPIrU8i2X13hnWEUPNW6wFKEfGs85ITueZdtKnQjiP4hG1nmCKYJPRGWvaVSzbSjahJoOI690OGEHnICBMCsjgIWR8pDBONj/g7w/bhMM0OJMzzbXLYOB4Oz6LWCe6P5TtsefZt7p4mkUpYTpI6vZ9/L3yUflqBu8r9rzh52Np6+XKxXx+TAbChcPo4klyRhvmILnY8O4UBVDP8pe3+MOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXLpNNMQu0LWH+vR/Rl/gZiLQk/aYFsG0B6/l2Hi5ZM=;
 b=ekAOvcR2AQgL5vRjeircPDuO9baqYDI2s4MOGSmaK8ZdUey7ReaxGixGVs533YD/dpvk9FO/gFp7ziPmcinwho7poLEqIM7hlFsqnZG2KMWtk8tG2hasdaD26k4f7vY+B/XTRGjFf62Dt+3x1nfXxF0Y5yGeBXrGXsR3JK97ti+gUZ3R4HGvmXE87FirjeUseJdHJJ85pTU1QrXxwhVeChYX/jk+otKlIu8G0OUwD4hCw07nWvZCJ6ziKXIBLqihoxe6lGp6toJaCDX5gkUaSneKfr7BGumkN57sTrAeB/bXY9vABshOTJJxGcqLWNpt3qruUlHobfBVy7da6ISAPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXLpNNMQu0LWH+vR/Rl/gZiLQk/aYFsG0B6/l2Hi5ZM=;
 b=oESIEg4LnsEXqLstwucgyFa7oV5dGDXtJ2XAygnyITgySVTZ2ZWd7LWyxRVSe2B0cSnj13Ri1J9ct958nH4ma6+wLDtwUC0bXcDDuJ+tqq86/rZCSOYtOxbHDvluiPi/Oxwl5Vc2rHTQTIoo/134gERC7VERKh1g3QhigUIm9ss=
Received: from DU2PR04CA0265.eurprd04.prod.outlook.com (2603:10a6:10:28e::30)
 by DB9PR02MB7274.eurprd02.prod.outlook.com (2603:10a6:10:25d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 14:31:26 +0000
Received: from MAD0EPF000008B0.eurprd04.prod.outlook.com
 (2603:10a6:10:28e:cafe::23) by DU2PR04CA0265.outlook.office365.com
 (2603:10a6:10:28e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 14:31:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MAD0EPF000008B0.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:31:26 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 12 Nov
 2026 15:31:07 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 12 Nov 2026 15:31:07 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id D5CBD2627;
	Thu, 12 Nov 2026 15:31:07 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id DD7193061554; Thu, 12 Nov 2026 15:31:07 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 12 Nov 2026 15:29:28 +0100
Subject: [PATCH v9 2/7] dt-bindings: iio: imu: icm42600: Add ICM-42370-P
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
Message-ID: <20261112-b4-inv_icm42370p-v9-2-875c828a281e@axis.com>
References: <20261112-b4-inv_icm42370p-v9-0-875c828a281e@axis.com>
In-Reply-To: <20261112-b4-inv_icm42370p-v9-0-875c828a281e@axis.com>
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
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsj6enaVo6D67Nf7UqP1Wxa9+7eE591RJu8+7hmKq+8uY
 ch8l3MpoKOUhUGMi0FWTJHlnNH26P3J/3TnSDtdgpnDygQyhIGLUwAmwifJyHCJ15Tf07hAdp6y
 9km9LO7nS6wm6VRd4J59jkNL5DOT7W9GhvZeRoeKtb0J3xUdbs16cyt2uqlrXlJ9iem5Lyd8fCU
 +cgIA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B0:EE_|DB9PR02MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: d72fe7c2-4594-40a7-c658-08df40c9a254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|32650700020|36860700016|376014|7416014|1800799024|82310400026|921020|11063799006|56012099006|10067099003|261022105027099003|261022075727099003|261021135927099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	r3gp+Up1GrmoPHKiTsGv3GhAhsItaoEiONkexO4Qiknh9K0fWRQ81nJ3iDVI2tD/hLmZjej7jtnstQ11ZN8ty5xWaW3ddG/idUeCQwwSjlD09Gh/VM0K7UnYRdhYkYHKScJKhFb3HwZbRsXxYB+c81Lt4ItNXBvrdDIL5k2eaJnrMiqqFI1Zoik40perX2sl08Y+huW4qCdKAA02UD5yvKjVMYfZwZBqWcE01nUqhaiHfPSjJXs5pya4gDvra1N/hiyJADOAK5AHsQ9KBWsaiOwX6hqaJLc9u6TT/5mxtyTd+TN8LHB4S9OVlnv+kLTbobO4LoM/L8BMsT8jLjyd/pACGxYjO3VzKavzVlRM8bFHvbk7xJcr09tJU748O//rjNxxrvvxRmEYUBkOqAEEJgRDRhmGrLa7gwr+lANinZGSJnRm1cwIe8foME6xDvwTVF5bO3jqjhDZRcvxnQaeRUkz8SGb+dcWsQz6QGLYqLSTK5wx7J4udXkiWlwrPqF4wKXiyhWZiMGqo5O3xlVdbS+c+KhfqI18jaHo/fUBRtdUdLyIGFG1coa2G8/bpYA0DizgvpXI4QPLf4gqHrMLS1iZBMcrnLninjdIm7E84gePc0+Exg+2K7sznW7QdogyfWATr87b0MH6ugNTJI4jhM6Lqa7FpeOj8Hej7ZLJbk/NsF9O6AnVrhw6HigYOPFt7h+ziSNx/Ia43jUUyg2iqg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(32650700020)(36860700016)(376014)(7416014)(1800799024)(82310400026)(921020)(11063799006)(56012099006)(10067099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I8cAaL5BuOzoV5QwvOTzSvFnycZzpoMhAsbV2eEdUtOciI9M2vQKmOB5aux91QgKPOAP504wC5NAlPjchfgz/VHaJTyyM3jVjG5pyl8QDxBxYlt6HgM31toeaZJI1vGLd8DmIExk4iilH6slFlFnVhRmFHaeOJA/Pmw5y4p5dz+rvJvMhk8c5pN5g0y8dBpyUnxk28WfezEWKqFr4XhLOMvTPjGjWcDBKpP4wqRmX73bBcPpHk5Cy2qtmgTTNe+mVt//4FN7z8XZIpz9FBQ0Olf1A8cDYQxewN/o6WNu4sqloKCEPcW1HXYwlL990n8i7wdV+dHsjdFPQjVOnsMyotd3ghWmzRsyPq58HZhk5kQdjv0DwYCqRlj1XPA3zRtR80CFcvfntcqH0ajCsoGsRrIE/WFPPhL6jJb2YS8MhGHyW1HpyyXjy2kmo0HFihuG
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:31:26.5075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d72fe7c2-4594-40a7-c658-08df40c9a254
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7274

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

