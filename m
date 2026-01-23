Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022133.outbound.protection.outlook.com [40.107.168.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB7212548;
	Fri, 23 Jan 2026 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769165363; cv=fail; b=SIcGnSa2744ZiYt6f9m5agUvIn0OWA0i6Jpiu8sBuyCs0Qg1/GI6pO4BIcbATBa0MOIPKTKDOSGNQGb/TsxJDZ2wlM85XLpbw9R6Awfb+sSrHFxJ2ltGBnHM3v9vp4qKbO5CX4j+vSRKfL9xY6GkdN9Y8XURzit2igrX/F0uJsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769165363; c=relaxed/simple;
	bh=s+PtLo6EJ6ITKAMhm17pohAnHSI0LUj97afJ+zr35Oc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z5+tkvWLg+37cSh7wGb3hUG8o9KlJt8/6rYL+FiBTJHid4YQqWYcTTqcujP2ppPgiIstWC1G8b7eXwn5b09NwWd4ewlTqSjeSxUPfJCqceEejJZZ+fxprruZHEVEEF7JZTG9tYltfRVDn/HJ1AFzPu9wv64BOsk7kbHSnxDQqRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=d7J8FKmS; arc=fail smtp.client-ip=40.107.168.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="d7J8FKmS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDF6ISQHLhFTPit4Yyh1i8kWqCbpUr+HCcKfCBInX2Y8umnxS8fBwC+IeFH/+dB50W9rxS2Xoo8cTzBBGynMH5uNoUkk3LqypYjKwUVZvKHcbwA3LSEDNrrQq7qC0OznPkCNNCqL7ZNsXtxSolZPcGcG5nbzV4ddj/T/zbBnHMnfDXrp9HIbhOh79vkHvTS6o3LmUGZCjT9D3EFrzgg0QWoKF35+T4fEfwGnNYWN3U1QshfHIc52tcCR9mr+bix/RS3ykl4aabWlAENFry/mJJM/SWUsW776u+FFS0OIF6XDlIZcM7aBriz7n7iSgBt7IVTcmfT4N/kEntTbBPmZKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s3a9vj+xx6wd1lA9wD3ZG0ji1PHiqJt0UwpHHkSUBc=;
 b=Omv1V2l2NA6BLGXlWdJ7KX7ESWwmMuHF8GOejQhHHWh7lEP48yla5BG3pK851VcqD+kBt8w+jNvw41sqE2uo7L4ReddF0WWlvf/Asldc4IRXz9xyAw5NDbcv7J6zYniMws8rS8pZ1xQAycQfZn446OnzZVjYIPPL7jsgBWoUwQrLsxXSjT7IGENRP++sE71WJiPlN/vuQkZHu5b8Klt0vN5cT2+lTG+HpDITKKY84G64jdVKFCeINHpRK4vgpokuEgEGEnVlgKqVztSr+KNFj0aJWUxiV6KYXaJFIiAZfVQJZa3m4iS1BBFaEweDN2MD/0KlfjiMTJIoCGf+L2JK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.50) smtp.rcpttodomain=analog.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s3a9vj+xx6wd1lA9wD3ZG0ji1PHiqJt0UwpHHkSUBc=;
 b=d7J8FKmSINL8pbuySFKRmQT7/XJ1hrJtPcqAjy/neBA2UuXarWq9B5QnmsMR4HJXFwfhC4NiWrQdERPfXu4RhNYLjGXHYlZjnVvDiurDMZSKMkZjFkCAg1SKC4DhV24gch06sV7b5GLa66f17e1Qb3krl4uv7Q6PwPA3T94iqZ8=
Received: from AS9PR06CA0625.eurprd06.prod.outlook.com (2603:10a6:20b:46e::16)
 by GV0P278MB1899.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:6f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:49:18 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:20b:46e:cafe::e7) by AS9PR06CA0625.outlook.office365.com
 (2603:10a6:20b:46e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.12 via Frontend Transport; Fri,
 23 Jan 2026 10:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.50)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.50; helo=ZR1P278CU001.outbound.protection.outlook.com;
 pr=C
Received: from hz-deliver02.de.seppmail.cloud (2a01:4f8:272:5fe6::218) by
 AMS0EPF000001B7.mail.protection.outlook.com (2603:10a6:20f:fff4:0:10:0:b)
 with Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 10:49:17 +0000
Received: from hz-glue06.de.seppmail.cloud (unknown [10.11.0.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver02.de.seppmail.cloud (Postfix) with ESMTPS id 4dyF6j2pfWzyRm;
	Fri, 23 Jan 2026 11:49:17 +0100 (CET)
Received: from hz-glue06.de.seppmail.cloud (unknown [172.18.0.5])
	by hz-glue06.de.seppmail.cloud (Postfix) with SMTP id 4dyF6j2fcyz20sD;
	Fri, 23 Jan 2026 11:49:17 +0100 (CET)
X-SEPP-Suspect: 452a5f0cc6fa4bd9b570e983f573040a
Received: from hz-scan02.de.seppmail.cloud (unknown [10.11.0.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue06.de.seppmail.cloud (Postfix) with ESMTPS id 4dyF6j2DLhz20rC;
	Fri, 23 Jan 2026 11:49:17 +0100 (CET)
Received: from hz-scan02 (localhost [127.0.0.1])
	by hz-scan02.de.seppmail.cloud (Postfix) with SMTP id 4dyF6j1ddgz6FKk;
	Fri, 23 Jan 2026 11:49:17 +0100 (CET)
Received: from hz-m365gate02.de.seppmail.cloud (unknown [10.11.0.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan02.de.seppmail.cloud (Postfix) with ESMTPS;
	Fri, 23 Jan 2026 11:49:15 +0100 (CET)
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17012050.outbound.protection.outlook.com [40.93.85.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate02.de.seppmail.cloud (Postfix) with ESMTPS id 4dyF6f2TBwz2vN2;
	Fri, 23 Jan 2026 11:49:14 +0100 (CET)
Received: from DU2PR04CA0190.eurprd04.prod.outlook.com (2603:10a6:10:28d::15)
 by ZR0P278MB0744.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:43::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:49:11 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:28d:cafe::c5) by DU2PR04CA0190.outlook.office365.com
 (2603:10a6:10:28d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Fri,
 23 Jan 2026 10:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 10:49:09 +0000
Received: from ZRZP278CU001.outbound.protection.outlook.com (40.93.85.28) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 23 Jan 2026 10:49:07 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 ZR4P278MB2012.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b5::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Fri, 23 Jan 2026 10:49:04 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::30b2:3be9:48ab:c354]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::30b2:3be9:48ab:c354%6]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 10:49:04 +0000
From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
CC: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dev-jorge.sanjuangarcia@duagon.com,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Subject: [RESEND PATCH v2 0/1] iio: Remove MODULE_ALIAS from men_z188_adc
Date: Fri, 23 Jan 2026 11:48:04 +0100
Message-ID: <20260123104805.15975-1-dev-josejavier.rodriguez@duagon.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MA3P292CA0035.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::14) To ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:34::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0523:EE_|ZR4P278MB2012:EE_|DB5PEPF00014B9E:EE_|ZR0P278MB0744:EE_|AMS0EPF000001B7:EE_|GV0P278MB1899:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a7e3fd-c6e5-41a2-3ae1-08de5a6d0ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?OxbyYdMHIFCAs4pOPc9+LaVJWdsaGtiY+CoHbbUPmnUvqytLu12lb3OPIx0H?=
 =?us-ascii?Q?bxlH3XABzs9pW5lX9lfPxpNolBwzYTfzV3PuGVcWFfZAQlWtQDP0GVv1gOWm?=
 =?us-ascii?Q?QZ/+duJUrsp8j9Iyvh73dMbXnZxGk8r4ryJJTA7gjZuY6YH2zAC5/zUPi2Ux?=
 =?us-ascii?Q?1odiiRFP8JTtak7EWM5VeBRl8ObesgJZgq1YIuIYMyBkpReipRTeiagLQu30?=
 =?us-ascii?Q?+lR6wrWT4TDw1dcEsakID8vCAA5RlAXWAM660T9gYjP8RcGgPbupzvSaE4vq?=
 =?us-ascii?Q?CwSJJReAE7uW4mmva8Fyoh9F0fvqlQfbNTVeYI/+YIuToqrMaOHU7kyEcbhp?=
 =?us-ascii?Q?kuS5zqUDgoPGZurUAqcnDlPWyFOZRuPIppj8vyRecJKd0XSO5r5BkcIbJglB?=
 =?us-ascii?Q?2P/zhHlSCqENjyKBaIo+W60EVA071+EOwhUumwnK7JiinYSNPdFVyemNGWJ1?=
 =?us-ascii?Q?WPVJg8CXt5iQFh3nK5Mesq97UbsOVNVsKXVXaOWDZjZz6YZ304eacgXodV5j?=
 =?us-ascii?Q?8TACzOo9Uec0McrmfQsFUCwSe8qSj0s4mC6EZhY3smDh74SISxTixAyypX/i?=
 =?us-ascii?Q?bQo63mVDhZ7zCfGCkZtzrijxwljO5PxsDL4UipSONaLWzxpBM+g/mDa6CAWA?=
 =?us-ascii?Q?ckge5qmoqtAyNS1DlXKIJld8L5S6ttWruV9iLN1yib6Z35pqSgzu8FjJilTK?=
 =?us-ascii?Q?i4c7UyLkEIMIRX+SuO8alogCQnzGrGAgTOIBtQbgBx/YtDjDXjLBP7gPjUsd?=
 =?us-ascii?Q?CG5wKDkR7v+cGgNpuZLUvXLwrY0bT98jcXmKy80rN3Zb07xbEspZmkQVLoq8?=
 =?us-ascii?Q?vsKgHFBQJjRkktvad7faY9jK+8Uf3+v/5eAJ4AtSm8JRKuGs2O7NdzI25PXS?=
 =?us-ascii?Q?3qa7Du5CiNNLMPrrFffmebAbkofOZBt6RdG81dtLK6zhp29uGBMX+YNQ3IT0?=
 =?us-ascii?Q?gWfGpyQTFNQe0BeHZE6EZeKp57ud9U9z8JQUSiRl3MG6ikYplcys/SqzMtYj?=
 =?us-ascii?Q?cXAERChn5JpJkrgcglzUVB5VrnwfwX5aUIJ76cKpiCj9zmUy0t6u/obZSH1Z?=
 =?us-ascii?Q?g8XKSG9N/xqQWZR2viP13swIVUI/Std7EQJWMZYCz45u8FdKmKRIY1xz4gKE?=
 =?us-ascii?Q?mI+5U1OZIAtqMdSy6uMlSajnjLVTdTKmFnzplB/y8Qsk97mJmL6Kxb2K513G?=
 =?us-ascii?Q?4bysqG0zJjGJpQiGpqfutYSzHgOnDt3FmV7mMYCk/AglZZbLm2qmYUEQpWVj?=
 =?us-ascii?Q?VDtjOXA7Ck528uGJbFcEgUkqzczq3N0MDxH5Yc+9gXOTdaFjd6ACEtSlF32V?=
 =?us-ascii?Q?gzAdmHzXapZ8CtXisizhhUYtIuEFz63VcQ2y0vaq9R4jmjhcFh4n5974r/oT?=
 =?us-ascii?Q?J5HNNHb9JUoRyPLkrS2zJYhDimhzv7wsRtSPtQnco2KauQalZaZt2uDqadhU?=
 =?us-ascii?Q?oTJhLJKGhnH0UYBZaBqDDcJqMPPZ/i5tOviIcfg24nLq3OFJAZNg7LPHTEoB?=
 =?us-ascii?Q?Z83xGRAurL6vMdXpu/RgMJjNr3z2MYPUV5SkOQRtQdweWiwXIspis2OsrVRx?=
 =?us-ascii?Q?qnc886/oJSQ2ZZ33vzS7+waTprokMK9kdjDz4D9jhj1FbOLqjx+Tlj1GU8kR?=
 =?us-ascii?Q?dbCGyaBv1nKpvvsb3mvABVk=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB2012
X-CodeTwo-MessageID: e499b61e-9cd5-47ff-a8db-562f8bb25966.20260123104907@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 9e85f684-b188-4236-a2f5-08de5a6d0691
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|14060799003|35042699022|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?QngtTWzP1t9Xdp/UcoTkNWC1fqCW5eUwGwMxER32NT3RrTeegeJ/l5R73Yz9?=
 =?us-ascii?Q?haaYhwm67le5jREsBf9/221UuXPxVMceP4yzosLtWsrbqNhA9OdIuENQqUoq?=
 =?us-ascii?Q?RZyeTTyMsV1Rx+ete75ijLzttY4ophdu85/UIzZZeKjny6GoYQz7j3ClCQcM?=
 =?us-ascii?Q?+iowK8Km7IoM5wbhsML3C2EFnj7pfPUhTmF8tEcXZu/21WHz18lvLVxNOLXw?=
 =?us-ascii?Q?3FO2hbM4MxIoQPvYtDRqyW5/g/9PV9gT8ttTRgrGQVolL7sPOa2TZMf3WkOD?=
 =?us-ascii?Q?DmPs1d2CWZs/WuH9UbQifMbWK/1sky8YEGhonKDwqg8/ElLOjz1YiS/cArLY?=
 =?us-ascii?Q?c2vo7e+Sz9Pi8ohpv5oCT3xNB5xO+rmL9AMrKX+9QzpYW5xucgS6YrsYBj6L?=
 =?us-ascii?Q?yyH8rYSGA6WoPMP5IbL56bRODmTpEQQw/uwppMG4ptFSmNoktBN4kIpz9Ooe?=
 =?us-ascii?Q?2/4Hhpvfq6qToycyTSdEVM8uBJPrmEhPgg4T5YhB5a2R9WCJibryki0NeGXJ?=
 =?us-ascii?Q?gctk/EMfY/uNfjEJuFkNViKEkIeTACp2MkidpPcb15BnG7lDl6Tevi4dGil/?=
 =?us-ascii?Q?ljLL7PaOP+f5TlImKONM3V7/wQm9oIBFz3FVbC17VOv/jngTjz0cJ9EwOpqY?=
 =?us-ascii?Q?GwvPzGg5LgA9w/AHK8AUH14cKclLRVxtdDc+jIlR3QX5WT+G2FVVRtUVO+S/?=
 =?us-ascii?Q?SE9T7w5cacnjFzhuCXTLpfIELZ+Ij6CKjR3OczoHFNkTNtj8mtp5C0Fuh6mi?=
 =?us-ascii?Q?C9zRgl6qambUE4Qrozg2mNDHUxNRtUTQHnn2sIZXT4lB3Uk5MnNJTow2wH7b?=
 =?us-ascii?Q?sefne8V4KbbkOp2DSrY9rYUkN8qLLpoLhMt8GXSistZzz0n8sMbg7X0EYu+U?=
 =?us-ascii?Q?45SA8fP/huC4u5mIPWZkZLhE6TBsV6BTal/falR/CCflL9bPrZoEsdWwt3Oi?=
 =?us-ascii?Q?GujM8PmA3FB6SJn66SRAiIvS4uWyCiXcqd1M8t5gr5yqKIa0uWTW8/mMO5TW?=
 =?us-ascii?Q?idKpBDU1nUcM60+xCo/4fyM191w6YCKHaf6rTnaRB6zevSAyvsupjbchexV0?=
 =?us-ascii?Q?hfsfz2zJ+aVZ1zFZ7+gWP2/aQjJnCCZFoSvsoYC9gtsBesxc+lQfv/gN5C0w?=
 =?us-ascii?Q?vm2B16tbn6XrM+FPHmtxQojbxqtSoMILRaaBUGxHYs2bhOedxqnBhPaoRYWf?=
 =?us-ascii?Q?UPuo+KYiwC7GvInSIKrHv691wll6c0QGkgeCXlVdGETunm/WJwAeHDnibchm?=
 =?us-ascii?Q?kKCS/FBIA2sCcLryRNXcPDqUeq52hKkBlmGo4W5q3wDvA10No8UWsmDWUSj4?=
 =?us-ascii?Q?nQu6U0JiE8BhA0tuHdMhLBoU5PEJZyUGfFRnxnj7rHMOEd0n+iJXU3f8+7dh?=
 =?us-ascii?Q?f+Bux+3LlyQk/pANDt2jaWkGwiwTelT4vkSXGe75f8yaZ1Z656zTWwZprtJD?=
 =?us-ascii?Q?70YUoGJHRbduj8Uxj3LXhy09JUO93ydPs8T6oyQoAf1XbtvMKLztFkozqAPf?=
 =?us-ascii?Q?tZKQY+ZEgRY3GCFRT60fhltT7r9w1307QW5c0BkUriFcltzRUDt6f68uQWWg?=
 =?us-ascii?Q?Rnqo57ehBqbp5GOSDl5UVp6EdTVoV0CSei6Vu5rJBjcpWhQpOVoS5Vp4Et35?=
 =?us-ascii?Q?OiJ1E8iR7yo79RM1tIYudOsndCyvsvXp9JVPbK29OA/cCxka0O73Nq2zASNn?=
 =?us-ascii?Q?7gD62w=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0744
X-SEPP-CCCVersion: 2025-12-11T08:12:51+01:00 9ed91da2
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.50];domain=ZR1P278CU001.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.50];domain=ZR1P278CU001.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ec722a3a-1ddd-47e8-f615-08de5a6d0a1a
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|10070799003|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/EAexJMMhzGdKqnzSvv+lFYo+2q5ELBT3f654FrtU0mTJkA24ST8r/sha6+G?=
 =?us-ascii?Q?lkXtr0T8IwnYLC4pCJXxCPX91EHqKdHT/DaSdfIdTVHPSCrUk4RlHR4o9Lhw?=
 =?us-ascii?Q?81d7MwPXBXB3FIf6zh+g03k9TE5o+CxoB95uKEHuVBfnHh+rYRhHP70KzdzP?=
 =?us-ascii?Q?iqw+WNyiV5D5l+gJO+OT5Etin9WvVR4Gx3y3NEL5vmdA/7mkS6Z3Ux+U0Cv6?=
 =?us-ascii?Q?JinJ3+bOpAQJFRFaoCYiLaam0aLm+xCFX4e0jNK7v8Sx8qycf1eVh19PqkMW?=
 =?us-ascii?Q?BsSe74qces74ap4RHpN9FF3mA7DiQkseAVaJbYsHHGATR1HK9WVInawuUqG2?=
 =?us-ascii?Q?gXX2/3YRjoRecASKv9EByZiJjs4GlyUHxXdDJhsddHA9hkFybqx/i6mB1IY5?=
 =?us-ascii?Q?BgFneyuTtl+drEd8qRmqIZFdDqfHL47MffvIcbOtS4wXha7QLpetYL1TK3p+?=
 =?us-ascii?Q?ppIYNZoOYAO1/sLoGmhxPWDjce6cQlofdwptqhwRt5FbluXJvoXUxRQfTSk4?=
 =?us-ascii?Q?K8qszOf1BlvqR17xKfUKSROqsaikC7FHFTzYZ2odF6KdbVUCk1i7bEWBLNcp?=
 =?us-ascii?Q?mvl8xjUQtWXGvxwaXcHYkm1T1okrxsUKwJEE2FHWJzkUapmU+BXlB+I10ezJ?=
 =?us-ascii?Q?VdhC+8jyRcb/TA5ghE8YXGk3dwSNlhD98cRTNoFnnUvqd4vlEX1LuEmKWqoe?=
 =?us-ascii?Q?zPUE25YjHHegwlk9mKWff9Q+DyU6uHF4RMHFtTr8QHVHgetXsJL4juSfxd1B?=
 =?us-ascii?Q?cvtKG3nufgN2/C0n4iGAw+5OV47LQrIOa6kiD/704w4Xv1OE+JC2dYafujC9?=
 =?us-ascii?Q?oEtGMTtvSKb6XWavJJl4/3V1/mGcIOxCugj62L6gEd2nmBi3Qq96Xw4fWwzl?=
 =?us-ascii?Q?W7ZuTE7qoMzn4Ki4nKnGQeE8sbCfoN573byLhC95XwGTmufg4R2Xad8G0fC7?=
 =?us-ascii?Q?39A0ekvScERdfLo0xJqv63dRVl22i2tnBHtyVQqZyFQx8NA+BtP8QxzZIGRy?=
 =?us-ascii?Q?1GKQvTu5AEC6zVyeeGJ+FvZwciIN5Bui+ZiPSX/ic5wnixTRO2MUIhcWzedq?=
 =?us-ascii?Q?vALfA13R2JhcaNEn/KqJMEaLNs03kJNg6NEeNfpQx6TjEVZUi0srt/ZXv7y9?=
 =?us-ascii?Q?YS1Yz3wFyresfo2cxmLSmpt+BZwdCjEiCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:2a01:4f8:272:5fe6::218;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278CU001.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17012050.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(10070799003)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:49:17.7875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a7e3fd-c6e5-41a2-3ae1-08de5a6d0ec2
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[2a01:4f8:272:5fe6::218];Helo=[hz-deliver02.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1899

The first patches I sent for fixing the autoload problem encountered
on mcb device drivers were 2. The first [1] was focused on updating the
modpost process for letting kbuild to access to the data within
MODULE_DEVICE_TABLE and the second one [2] for removing the MODULE_ALIAS
on all mcb client drivers.

They were rejected and Andy suggested me to split the second patch
in a per-driver basis instead of sending all drivers' changes in a
single patch once the first patch was merged.

The first patch is already merged on Linus's Git repository for 6.19-rc4

commit 1f4ea4838b13 ("mcb: Add missing modpost build support")

So now I am sending this patch for removing MODULE_ALIAS on the mcb driver
in this subsystem as it is no longer required. This cleanup is being sent
to each affected subsystem separately, as per the review suggestion to ease
the handling for maintainers.

[1] https://lore.kernel.org/all/20251127155452.42660-2-dev-josejavier.rodri=
guez@duagon.com/
[2] https://lore.kernel.org/all/20251127155452.42660-3-dev-josejavier.rodri=
guez@duagon.com/

changes in v2:
- Renane commit message

Jose Javier Rodriguez Barbarin (1):
  iio: adc: men_z188_adc: drop unneeded MODULE_ALIAS

 drivers/iio/adc/men_z188_adc.c | 1 -
 1 file changed, 1 deletion(-)

--=20
2.52.0
