Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D76D48BD57;
	Fri,  2 Oct 2026 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942090; cv=fail; b=ihYYmpzFf0pzL9QfCgqnqPJyssVIZM2ae64CTllbJz/nv3lZnQdhIsTQqn2x90dlZMVr9M0SSz+2t6RV4sQaNJBdoAfbkZbQZD6s9erQnHNda65tfb4HHsQ3PHRCfObumQcRCmeB0o0s2ScAMUE9ucA803wI6i65Gz6b6ujKKDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942090; c=relaxed/simple;
	bh=H02Q8Ov4F5xOh1/EHgLywm0nm24t99jspeekXZgb+VM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IM6PV/YIl8PS+LCvly4dTt3/DKk5VvTZJ4REoNWl+urAND+EtWTYRDOEdPQ0oauI1QnlP6uRHeYVjknpO0HMnxyBCK5Eueklb08YqetTa30yM5QfBvQwtANdDB7JMUJONmUSQQR7kFowX/RtD3SiMr6S9t0Slev9Ylg/0ZqX+4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=cP7g9dB8; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="cP7g9dB8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZzX8pQBI2HtdrN2hHh3WH11tqeM85xWP1aIfh4FmtNurQUJDOX7LNzLlMuIQihRa6mz+xaVrxd9ZPkpUGrjBVAJiqL75H6Ec0tUWumtUZ/PpR0lmcatlLhPTpmXwJRU7OkPkcgo1K2bfukBUKAoz94/0BhScpQ7D4JlBAjg67a/Ah9ll7qjFP5e+sUyctg5DGyuCQ165zRbTio7+DIhSCnF/KJaY7El+7vsXO4RspMKxKUlkxN2HvYnDOOXjngaQlD08xOQpXAyVc23uBMOOjw9dMMRwn+SlSQM9L8HUnVNxriIZnOXE2m5UH/IzzzYq9/OcJ1pqUZO5/G0oVcCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhLMvHEmP4wfZp3Fc4jGZ65rn7DNqqZ7YqlhzD1Gmgw=;
 b=YngxVonjq5Pm2fHhE/08h4X+vKmu0bIfHOynURIN7eMa1TlYiMUDWxjJlZE7/J+0YxeDwhtKN/SZ0AyMDCqP/KQqKJFezMYUhUCw9OxdV/Sk/r2PYLu2yBazH6IosOGvn3DBlsstFVFrl4xP1mcrkyksDyGyhi+RC8LKwtEx9iLRLEKE5+RPPKcIaX5oHiVyluYhCrkio2W2xWway9Uycuk1O7C9y42E+M+8xOqCWMosBjvfpHsoYPPH29WAfFy1xVRe69A/uhj06SzHC3l7Ck9ISFTrZOEiCk/yuQH75HWJeFBIzP4pw/JJGM0Kdc+HBlChC9QrARBVsvfCtKxspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhLMvHEmP4wfZp3Fc4jGZ65rn7DNqqZ7YqlhzD1Gmgw=;
 b=cP7g9dB87/XUJH+14+PUi3NlyyqHQx6WE/S+dM9xJbDka6u4Ggyz9/hs3NwxSCqkeXGp41oPqkfrLKEF4fWeviOlsfMTYCLhuVkQMIei1+aH+AkyR4tpIcgDrxTzOpirZAApk8Huug0hH3CzhXnMw9LyCOKqX9wzH2Vv3Bi5pao=
Received: from PAYP264CA0024.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::11)
 by DB9PR02MB7292.eurprd02.prod.outlook.com (2603:10a6:10:24f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 11:54:45 +0000
Received: from MAD0EPF000008C2.eurprd05.prod.outlook.com
 (2603:10a6:102:11f:cafe::8a) by PAYP264CA0024.outlook.office365.com
 (2603:10a6:102:11f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 11:54:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MAD0EPF000008C2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 11:54:43 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 2 Oct
 2026 13:54:40 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 2 Oct 2026 13:54:40 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 5E1FB168C;
	Fri,  2 Oct 2026 13:54:40 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 52B3D305D2BF; Fri,  2 Oct 2026 13:54:40 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Fri, 2 Oct 2026 13:54:25 +0200
Subject: [PATCH v5 1/6] dt-bindings: iio: imu: icm42600: Add ICM-42670-P
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261002-b4-inv_icm42370p-v5-1-c65281b745c9@axis.com>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
In-Reply-To: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
To: Henrik Grimler <henrik.grimler@axis.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jean-Baptiste
 Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts
	<joshua.crofts1@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>
CC: Kanak Shilledar <kanak.shilledar@axis.com>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=H02Q8Ov4F5xOh1/EHgLywm0nm24t99jspeekXZgb+VM=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsjaP7t+3Z1VNaJTn/2OuBxjZZO8bE6a4XPdxS3eAkIxK
 xW/p1/W7ihlYRDjYpAVU2Q5Z7Q9en/yP9050k6XYOawMoEMYeDiFICJZLxg+B+65itjfilTtey3
 sAaJL4nvXU6ybpi/vv5G4KzA7PQtSQwM/3REjh/Qd54RLnh5tscvJ9ebJgFGIXFWtWbKdzwvigk
 2MQMA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C2:EE_|DB9PR02MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 36bcd3d4-8360-4cd9-03b3-08df207bf2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|32650700020|376014|82310400026|36860700016|22082099003|18002099003|921020|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	/EkU4GcanCmDc0W+qVpAORl6XWifM2pIHC1T28xk4J7WVO1usmvG9YKFlHODl3p/W8/CYsEF1hJBocZl2i15dlQCGu35vy+0HLlc97bmh8Q2tL3Ka2x9B6pmLnI9jHFV/7CRBaZChuC+zZqhsM3KQu7V6xh1nqYQftLjvNqEb+efI/ATQvWlC7+OOeD2P+0Lf7P6gVdNaOIRuNxQ7CCaxlDVoQguRKZTYpX9aq1r8gSl+W3e7J8JmuyK1lmLhukyOHPA3ZcYvAwS3wqm/84drtS3ziew49NBDgLzg4/rubQ2JHrEd6P4dJGdZUggaRJ7xbtfnKeZMYdJjNjPoOt9ggdCXTPgmNIoIt/1+fpYXYBjIuQtU8vo19aUuZbi7w040yRFy+AAttKSrSRN+665LAwOjG6miT/FVHf323uWoFw7Fkq1OvBxIznkumaF+V5kZCWCR7DTvcJQ62n8miU1gWp0oEAoe43Dv8nSnKs/Sn+eQ3Iy37s6Li/FAIt/GE2/vkybK3ayPdbWzt3Bj+b4kE4rolqZXtPt2EzdK9e6JRtdRExp1U1+z0LhDrnRp+xBgzXpMNVULUnh53XEtCENU9E02ftPTOzyV4DBf5IZZNLaYWNUni23DgtoG/+sGxzvYJrB5svBfbUG1rKguhgjdh/y6X0k00Qqw9Rtzi1aJxq3vh4z0HlwHk9HtfEfXqym/1GYHsBe+7gcsVjxyabyS6xJx/KvCSM3F2MxjqVuoHNMurHOO2e6+/8ncI+Ju2A5
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(32650700020)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(921020)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gsB/r5itXacoicCb86QgUkTcFbWOpSwe4l43qixYKGR/bYSHYlB62Jau0b0Xf7moJYqDo7ueQAH6dBtXJCUOZ9a+RWRYr5tDtWWowvV3JWTNwxG6jwVE4DlDKMbJrEXVqguvli4eR40TTcse/ATw03oPX6IImihRyG4lEKsYYTgPD1lMkneYSE2JcXtzMuU7XlX9mDF0k8oQb1uyGjSED7cM68uDpR85gWgNn10JNU6iiIs7vtLiCGUaq+h152NZUidvtQ0P8mYb4V5P3WrMfSbmwUUH6fbIDISe6pkHtW4haKWAicjWkYov0iKDTgQnHBqWSLIpgEHHAZ9FarFCzL4xTJnxacSb46uchzGtzageEVOmmLkDKzlcefnhalqA43w+NHQt2xqD/qwomiJAT/tX6W18/Cg8ZqyUGZYbZ9ypEHXJt31nIB+4ge+4kWw0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:54:43.8400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bcd3d4-8360-4cd9-03b3-08df207bf2f7
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008C2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7292

TDK Invensense, ICM-42670-P is a 3-axis accelerometer. The device can
support I2C, SPI and I3C. This device has very similar properties as
that of the icm42607/p. Add this device to the existing dt-binding and
update the description to match the devices.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 9e22b603d47fb..c79eb0a1a890e 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -11,10 +11,10 @@ maintainers:
 
 description: |
   6-axis MotionTracking device that combines a 3-axis gyroscope and a 3-axis
-  accelerometer.
+  accelerometer. Some devices only have a 3-axis accelerometer.
 
   It has a configurable host interface that supports I3C, I2C and SPI serial
-  communication, features a 2kB FIFO and 2 programmable interrupts with
+  communication, features up to 2.25kB FIFO and 2 programmable interrupts with
   ultra-low-power wake-on-motion support to minimize system power consumption.
 
   Other industry-leading features include InvenSense on-chip APEX Motion
@@ -28,6 +28,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - invensense,icm42370p
           - invensense,icm42600
           - invensense,icm42602
           - invensense,icm42605
@@ -81,6 +82,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - invensense,icm42370p
               - invensense,icm42600
               - invensense,icm42602
               - invensense,icm42605

-- 
2.43.0

