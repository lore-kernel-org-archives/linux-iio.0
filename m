Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792741736;
	b=PGn7iSDRFfSFwcN0skB9yRtXEFgLbR1UMjZHX7wdsGt3ZghZPA2a2cH0LbYFZPhag1rh
	 5zh8lu2SKjnzxYY75w3I0i7mxEyPssvgisokRdoseBk3xJUIWISOjyuoprYufaFkq2ery
	 XChArzA5veYwsyplPO1VZNr/vvj8Za5e9kYerkn/rPQ3FUMKQ+Mp8ikLrtGaNoNVPOyZE
	 NQ473VdVOxqUzvjhe3+gA/CNOYhPUmpYqMnITTXru7CA+f/ua2o/PzbUcYm947HlgfH13
	 ewrA2angVLmwMpoCRmhCfdosZc9hUMiQF7iLDK5VltZrY+Xfh4h3XJQ+xjK1lHHFWAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741736;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 CC:X-Mailer:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=8lU6P79LwzuKwAh7P2mb9QxpDyD8Xnt67/9ecZ1x0gs=;
	b=RbMZcATWHpsEO/Om0ra0iLIbKYXatLd1z6Cl4sCWYxLz6LiiVlI8ezrMas4eJRAyV70A
	 n3PEi59XHabyaNa3lfs6SikmNNNyywDt4pxkMR9OAsLcEPQ38SNJ/YOLz1ZPiFpor6AFk
	 o18XOZmvGiyZsC+m+Hk6vRjW8k5DDmeqNN/SH0VcgXgb3LtwqiRcKZLsPKTaNN9KQmQBH
	 n8To4qn74sw4tPnuci1VZ8umgZfLFLbDMZfuAeHCgbZlnSuRkNyIjHKa/uR3rHJVGWs1c
	 Hpd4QvRIUQ39uK7oQkHxz9BpJqblnezU4eqlNDw5RjTwGg+tGRAkdJh2HsYxrqd2mew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=e0ASceYZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.33
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB64B606A31F;
	Fri, 23 Oct 2026 07:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB64B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=e0ASceYZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLlUyuXRfws5e5ahQXUQG4twtX1Q4bTLHV+J5nCTzqs0EQw9jtrdRR7L7OQjrpA71O7B/0qeOWDug2NTt7JudEJQv4mrpbcGan0xBIQj+5vA71nGGiXr6H58pDLFxWRUNXmbJEzhwcVIz0KSR+2DjBWAhJB4kZ1Q+yqb9ezIQg0mLxcH0PcyvuF+PR7a3yKM6oiJ/ZIDUiXD2xoC392m1lMvKekyHgGB/D9jYywv4mNtoglU00klg8+J5Su+vGykLflsxUw/YuOcaQZY8sN1gg6m+ZH3apbt0fl/MQ7CQeJWG79IETZrlXG4Pbje2HSYBhIHDLmU3+EV2WCkSu7adw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lU6P79LwzuKwAh7P2mb9QxpDyD8Xnt67/9ecZ1x0gs=;
 b=MCPPtgRvfxiCfGqpRi0lgNGGuN2zSF0VpBb65ZcR2NZrtBBkzGeVVodHtrgGmSrWt9TLqFb2OjSNo8Dg43dnyhkbc5VkIU9jV1CQl2E1SdfhfTXyLRr4H+KOjH6d3RZfqwaXzBHij2m5Gkex3x575w3r6a17tj04MK+SFkauxBSKi0HaNA/HAMA0oS0kWz6N7gnJm/ZwPdSegbeNbtIfqPFOIFVGZw+3/8pyxQ2K/+NhkxBzX110SQo2L3ZS2gVmzKT60uDZ98r0+RANkxoGU/NYLtRZf/KFbeSof05fmtPcNblbbg0CQ8YBPXr8GfJBOQ8mrYvFJSfhwifJJurNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lU6P79LwzuKwAh7P2mb9QxpDyD8Xnt67/9ecZ1x0gs=;
 b=e0ASceYZdXBFY3zzrtI+U7MKAq1bClpbJfRt8bbB5bkQaYNq1a9Y2kcAZay83mFF1HfZMy29bNn6YDQnKWyRe0IqggoHEeBaeqcODFPfK7EczFBWdmxFhfTu4mSqwuJkm5y7DfitCxz+oplxKcn/ZWyIXik+Gpjs/tEUKIgbNLU=
Received: from DUZPR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::13) by MA9PR02MB520490.eurprd02.prod.outlook.com
 (2603:10a6:250:104::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 07:48:51 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::91) by DUZPR01CA0035.outlook.office365.com
 (2603:10a6:10:468::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 07:48:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 07:48:50 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 23 Oct
 2026 09:48:48 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 23 Oct 2026 09:48:48 +0200
Received: from pc46036-2141.se.axis.com (pc46036-2141.se.axis.com [10.94.180.139])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 1198D3CB0;
	Fri, 23 Oct 2026 09:48:48 +0200 (CEST)
Received: by pc46036-2141.se.axis.com (Postfix, from userid 16197)
	id 0A79B584AC3D; Fri, 23 Oct 2026 09:48:48 +0200 (CEST)
From: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Subject: [PATCH 0/3] This series adds support for Texas Instruments OPT4041
 Ambient light sensor
Date: Fri, 23 Oct 2026 09:48:12 +0200
Message-ID: <20261023-opt4041-v1-0-45227f82d05c@axis.com>
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
X-B4-Tracking: v=1; b=H4sIAD0R22oC/yXMQQ5AMBCF4avIrDWZQRFXEQt0ylggLSIRd1csv
 +R/7wLPTthDFV3g+BAvyxxAcQT92M4DKzHBkGCSE2KhlnXLMCNFZUralJrQWAj16tjK+T3VzW+
 /dxP32zuH+34AF1/sVWsAAAA=
X-Change-ID: 20261007-opt4041-18315d8510df
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Stefan
 Windfeldt-Prytz" <stefan.windfeldt-prytz@axis.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jesper X Nilsson <jesper.x.nilsson@axis.com>,
	<kernel@axis.com>
X-Mailer: b4 0.16.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|MA9PR02MB520490:EE_
X-MS-Office365-Filtering-Correlation-Id: e6eae6a3-ce69-48e3-af19-08df30da1417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|82310400026|36860700016|10067099003|13003099007|261009223027099003|261009221227099003|261021123027099003|261021121427099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	XdL8w95kHIg4fSRbXeO7DppjzFbLezexzGr/XP20Fw0tY+9cz6x5N1utQ4QQUaOyI1acUDi20lBe5i3oobdxaoJNbNThy+dL22qD2cO1tQNA20xlZzhcKsRYcyqWn6IKGV3GZdbiWrwVDBIdb84jfDKYQ0Ryqs5Y/Mijo3BYRiOihC3nFSYG82NbaWjFKpeXTqc6Um85KVNXcZkb0BFXRUh8Yd9QaBOxqCpdY8mwEzRa0rK+vmnhcV8Z6WXdYsW/nbeW7D20JD/Au1QbJJQz3virtMIl9IJC6V4Ife+wJUg+hbC8h7okMl0Xt0baIRBjEUYLPM76Ntu8fnchoBAyHBinz61Qw5bTbEa8eBMqWD2cBgNZApfOXC8zk9vTDRLR/iyMdXOgrqw4e+VJasaV+WWOjWRCoe/2cdEF8pYuRfznLgQxXbNyhHISKFTPKGtxO+deP/8nxhP2uX5+0x/2PVA4piEOIONk/xSQ3kfaAw7k75Ai0qbb80mVMHb7MMAZoGnp7kPoGxcX+/whGiIqy2RMxU3BAS2tb5y6UEqH30e/Fsa1cfdRdnEMA78uyVx7d9H9R+vaVVM92CcLFYtvR3atL5cH8MKYx39usT0Xn5lw0VyfvKedA4xeNa3QDyPAJ35i68gsHqotT/ssU+FxSWJuaZafq2VCILl9z+QjJVLe7DKNX6ss+tIWtd2ijLMuiOT6Wzbqlb0B7ewCbbYHyQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(82310400026)(36860700016)(10067099003)(13003099007)(261009223027099003)(261009221227099003)(261021123027099003)(261021121427099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uAuNUhLq4zZVRs6WjoT8iQE3fSQ8igsjUXV1vV2wKJXrr8tDI57JL+OcdizkyQKb2ycKFmI/qsn4jtx1QzHjVgpw3LlivJiptjJ5DpGASb0ANL8+hDLJug8zjmFwR0J0EwgjzKSw12XQgG2SgsJsoPitq3HXngQ30pHt7+ZO07Mpbgpi3U5pspk8zTTHdGN6Uu/kqANqeB2wFnxyljZl2WKTt9eoZid5uvW6MLyy7u08lVk7quBbbXmVSU6vMvxU7k7Y9YDIDUEbT4YjsFflpVJqbNmi2rsZ6NoxnecEvBTdytFdZPg9vsYYzv0Gjf4yxfjSBw3xNRxfOUlt4DafPe1UIvUUP8MsKHb6Cz18lqQMI7q84et59frFIOkxZyjXWZnoENBzP8frbGKKLRlSIP0tYN7ATY8xJXw9kvj8USLPnaRRQ6Kj+R6ktlOW7t96
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 07:48:50.7509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6eae6a3-ce69-48e3-af19-08df30da1417
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR02MB520490

Extend the opt4001 driver to support OPT4041, since it is so similar to
OPT4001. The OPT4041 adds a second channel, a wide band channel ranging
from 380nm to 1000nm. The register map is almost the same for both
devices. OPT4001 has an internal fifo of size four, OPT4041 has two
fifos of size two, one for each channel.

Since OPT4041 has two channels it has one bit in register 0Bh to select
which channel is compared to the threshold register. The driver does not
support setting the threshold registers, so no new support has been
added for this.

The OPT4041 is pin compatible and has the same package as
opt4001-sot-5x3. Although the device id is different, I added a new
compatible string since the driver already had different compatible
strings to differentiate between the two OPT4001.

Datasheet: https://www.ti.com/lit/gpn/opt4041

Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>
---
Jesper X Nilsson (3):
      dt-bindings: iio: light: opt4001: add opt4041
      iio: light: opt4001: refactor driver to prepare to support more devices
      iio: light: opt4001: add support for opt4041

 .../devicetree/bindings/iio/light/ti,opt4001.yaml  |   9 +-
 drivers/iio/light/Kconfig                          |   2 +-
 drivers/iio/light/opt4001.c                        | 144 ++++++++++++++++-----
 3 files changed, 121 insertions(+), 34 deletions(-)
---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261007-opt4041-18315d8510df

Best regards,
--  
Jesper X Nilsson <jesper.x.nilsson@axis.com>

