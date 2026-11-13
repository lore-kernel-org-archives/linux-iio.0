Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794590449;
	b=mAGwHMKke0cXm72h7zDBV5l81iDjN1+m7/OYI0BvSw46m98BooA1BacRsfaN2+XcCWxz
	 TOMmgOntHXZ2YF5wLRZcoBjYOWCM0Q2XBUlPYGkFLZNFXO08jXdKe6ZTxm66bMJsO9Mi3
	 D5uZvxqGsFarJZJXhrYteUuAsy1cyRs6YVndXsfevCZGVGi2PI20b3TPGFfQ8iu5+iL+N
	 IQSyKayf0quCACiSgNLECkBB0C+ygChDSf9oXZgsGwdAEbHtjWfUlCkZBRAZOlyQHp0qO
	 aMaavw78j4jS15Ix5Z5HeI29oFAUsXwFGaPUXRVXGG8FPLLOtOOPOodXXtKzg5dfRzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590449;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
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
	bh=Xq/fbkC79ZwjoPcXw7pahFtV7IsgJv3cLEEpv14Mc70=;
	b=Uzs4ZJRJ/BMTR8Lzao1iBBZWoi20bdww4fom+/pLB2UH2gVG28mNIzco2Jlq8Nhg+gj6
	 IWr7q6dQk2QTV5lq+m72OABqrIB5kixqNUzKEe13uFSzmSrxd65cEAQNFv00EVPA2+x44
	 +w4ohyUhW6p6YVWzJ/wcUALkTs4nH2rp6eRoPUgaCADvhrO2+CYyyfo1/v9GRCJ7FtJWH
	 FAckQp2RSQFzok0TvYjLtY1ECB7Mp9vTooOaymOnLxs8z3bZ48Vu0mfkVx0UXjQLDtqmX
	 po1H88YxdA2cGprukJ+MPq8KD5icWNOeAppf+Lc7RYVeOr8O/ERC+IcZgOE+5y7ZADg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=A9HhBbRa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.29
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013029.outbound.protection.outlook.com [52.101.83.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24996071418;
	Fri, 13 Nov 2026 17:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B24996071418
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=A9HhBbRa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDJgyidvSnZtbijJ+VAg/EDP/jFksJjC3jS7mvHzVet4/0krrkV1p7YWsyvmdiSMkSG+tRcvlN1pQ5kSpqO3fLdK5BW+20kNDiINy/ccERc2Mq0WQ5bYnbBqkoiZMs5034LQbnQk1zRag5PfwUW4JP881obZ5VKYkjl+TvaZVNav2cYTdhnjFRSKENoYQJYDW7sHa4wi4gYPHAhhTw9+w/MTlJ+e/Pd6I+i718En1Jsw5DMp6IcSYVHK3Zm8qxEP3Pgiml3ywqISGiqhmf2Ix2KrWlVP1SPhJZuHZR8yeDaMQeVgl8pabLocisClMeJcaHPqqW6sgE13KmsE3tr1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq/fbkC79ZwjoPcXw7pahFtV7IsgJv3cLEEpv14Mc70=;
 b=Lf88gpxVJMpGoFfnmxe+4chmE5eK+miO5HrcwNezJS4ZZhvud1qtsNvnSzlY2gnprO0+tmqZHZYYCVWeGjau72lw37i2lFR1DxAYnju/okmy5sKCVyuvCUhCBxwV/NNMGXTmavpnjF44Os7Q3Mj6FZXI6q5dW47UJrd3G0w2li+owo0+gsWdr6pCqpbFB2BaOZdrXQcgUNZaxVatOeAvDvHLezyUOQD9rP7TL3No5ZOlkOCcx5rcOaY2pEKi4dR3Yg+bmx/hr4/jXdWHyC+GDfTwkXMglQybmRhO6oEc+ZfGKcKondX2QDhX+Xf4+qJpTya+3lVNz2sICTm4pQPH+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq/fbkC79ZwjoPcXw7pahFtV7IsgJv3cLEEpv14Mc70=;
 b=A9HhBbRa3FTiwxztVyinlTddpsNy5SlHiC3zvYICJyZStq3BoNNQhJLQMFrKYorU1uVHLN9dNMaGod3uJiJtY0TSCCDehLou6AXSU5p1EPnjSifN84RziS6mEaCSUvW671KnUNMkpgnwqbsxZ7r7vs17Cv4PDOj99lTCFeletEI=
Received: from DU2PR04CA0219.eurprd04.prod.outlook.com (2603:10a6:10:2b1::14)
 by PA4PR02MB6846.eurprd02.prod.outlook.com (2603:10a6:102:f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:20:45 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::80) by DU2PR04CA0219.outlook.office365.com
 (2603:10a6:10:2b1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 17:20:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 17:20:45 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 13 Nov
 2026 18:20:42 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?Q?S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, <kernel@axis.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH 1/2] MAINTAINERS: Add Murata IRS-D200 PIR sensor driver
In-Reply-To: <cover.1794589264.git.waqar.hameed@axis.com>
References: <cover.1794589264.git.waqar.hameed@axis.com>
Message-ID: <084595bf5eb0182b2837b9b7b6928c7bd28d5ad6.1794589264.git.waqar.hameed@axis.com>
Date: Fri, 13 Nov 2026 18:20:42 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail10w.axis.com (10.20.40.10) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|PA4PR02MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: d4cc2109-9067-4bf6-984c-08df41aa73b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|22082099003|18002099003|261009223027099003|11063799006|56012099006|261021121427099003|261028144727099003|261026121527099003|261026140227099003|261022075727099003|261021135927099003|261022105027099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	Q5uTY6cRTa4nH5DDLLazwenUbpxnPkdHMH16C0XQxzqVd6/jFL/k5F7nLXzlQLe1Li1DXn59wCUYKOHPty1MiasTN6iV4EvGl+SfE3WznnfWDyHyfsHDnCQkinBE4C9H7uZlH1top8e4LJS09TsZp4gPrfudDY4q2tyS+c1ze48aGjXtOlgVZ7WejZQ+cqTQRForek9McuPWvTcYXJj0l07rp6h2JjNxs6Lacjyof9sY0Mkaf9OhkOZXf9k5cW1zbj8IC4jvFfmcVrxkGCEpieS0NHm+yJY1zwStNdQEIZq9c49axNV+42+c/xoGzBPONegYsgvB2XOZv3JcPP3KLr0HzPBsMrF/ET+fiEXFVjRFwdXi4Q/FzIOoorR1sFZAn1HWtrYHQDWjGnAlo9v3M1wnhhK71xa8X7smPaEUVHAsGmBjo2NvDORLp/keUHNXwOMoeurYJQIGuvF4gYfZi0nm0gaYyTsI/0+19/CEfw7X4ClRfCETkILhK+tJSjOdR/BCzpATUkyPYfDXfutuZgbSfxIGY/7YgJByAmGmj7qpp/qgutN+ubYihUyThSocdf6ZyA/YH7TIDJXuJ5XvprFY2PtbJezPPlW3blkJyV9NoT4QiHpuIPIgeMpQzpBK06i/ewDdHWgZiKiUTWQCOXzpWS9S10syn3AFI1NTENLX3NtzIHxW6DI+5OF4xtYL0wJBkWpcMIouPxW1H1D8BA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261021121427099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022075727099003)(261021135927099003)(261022105027099003)(10067099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0Dn6a5JrNFeX2gEj7DENZoGWiyNaN95Av4GXCplJpXDaFwVcNNzgJ+GXm38t1XaIOlwKKYpGWwnmj1JYzRnxT8ZEZhrXDSj1HRSqsxKIhwJ8XCK+q1Typ/kRnHotKinZimJkaHhaPIkCDuUNNt4AiaxlRPOyNuTak2Q/dURC1emW9Jbgp67bvNVAb8efjg2cD9+zd2jzd0oV8ctjK6LOKMu3VxvFSFW9a37f0P763gRleTu/cndVFFR6mgYrbu2bgBoZ9KESy/76LQISqYbfHKJT89a7KaMTauH/CRvBsKiNIAriV8+KQ1UwzwF7nzUCb5hZn7eaqu8+JVMySD8U2NVrfZxuTSLpFGSGt9a8XcmmE3XqcT49xv27r89L+0QJ6IT+7IuS4t8vABzkXebwpQBbB164y9k4IDNAvTVUwngfJ57IhxCzFW2e/JlS3k8X
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:20:45.0923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cc2109-9067-4bf6-984c-08df41aa73b5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6846

Axis Communications has resources dedicated to maintain, test and review
this driver. Thus, add myself and the company kernel mailing list to
help out with this.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7070cf5dbfe98..2cf20f1a461b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19309,6 +19309,14 @@ S:	Maintained
 F:	Documentation/hwmon/d1u74t.rst
 F:	drivers/hwmon/pmbus/d1u74t.c
 
+MURATA IRS-D200 PIR SENSOR DRIVER
+M:	Waqar Hameed <waqar.hameed@axis.com>
+L:	linux-iio@vger.kernel.org
+L:	kernel@axis.com
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml
+F:	drivers/iio/proximity/irsd200.c
+
 MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER
 M:	Bin Liu <b-liu@ti.com>
 L:	linux-usb@vger.kernel.org
-- 
2.43.0

