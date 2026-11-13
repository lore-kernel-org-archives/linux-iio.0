Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794590453;
	b=moQNsbV6xUnLEB7p3P5u57WuOvwy98kiWfwJSJ/viaRVu5eAlv38jnIPX8UK03TRv6DW
	 /YUyQ9TBQFYb7YuYGyeJLpqsWY5bfLDvQEwRX9KR8H1bLLSQwIvurhlDG/vmTJ6RC1EQ+
	 j0pM8PDlOh+mdG6L2oOzxI+xU/i0aDs+rQI6QtD5Hq1l2runHsustEPgq4mJWgIu9ug3E
	 8DynVGp9H/utFoK808m/4fnq1LNpzTtOtFLdB3PePabC/y4d6/Kzg9RIuAiGY25Sox0tx
	 qhclawPHPSvqqXDzfsHekwvo9uzWN2iyTS4UvGQiqoRGwBG86IW3xUR/GDHDDUBCGqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590453;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nGbff918eyCPhtwdYUj1WSUu2qGTzXJqox35FYEb9cU=;
	b=V8yRVnTc8oL7su65zQQ3K2PvNFd0IVOWmDK9DK4WcEs2Ni08Jt9jkKreWWUE0qaHaebw
	 cb3RbB5asp8aXHIWNA3B4Z7YhLfRXLEIp6nugFwiV7noq8MU/8WVCl8ZFjhd4TP04tzRi
	 5uVf7xYfNYmhZQakNOQmKiCJDeR2yD2jj0NRECAbndlJtrp+YxmCoyC1M4jXbV066pZU5
	 7Tilr/rnpH01+Y0c5bpdvPHXjbRLTQFwrpyAuqwc4+78YZrAX0loJvKCS3cnZVaVYJ21z
	 QNDy9LTJLsYIWsLYesmOtI8WX+HuqJcYxD6mhh7hbIjv78rvPrxI2BVP0XbGAM8rj0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=BFwSRehn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.24
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3A16070F28;
	Fri, 13 Nov 2026 17:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A3A16070F28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=BFwSRehn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZyJx7tW0/M9paQsimjHmgfDmB6Ox5VkzUDUaPZKgVj5jpIRkFov7dK0CZuvCIhjNQiRlEls+6/RJXWSBFwyswaTbucTpDKt6xRK+A9+sajjAv7DiTaT+Ytfj/mbW6RXesKOQPsp1cBJDdFRZtEXKDYl6FudJcAae3sZhi9DBb/rDReiJ9DQtwdowQ8CIeqyRoCQ7Snzp1cPS0YSx0IwPtzx2OGpwFyfyZPSN6pV+NAVqCZntHqwNGE8oj1FpWUFggraU2VhL1Q58gqwmpRKBxAPW34osoWVHYoV77OTd8IoDieT8i427mTNaVRrC5IoNF0RVQWd2NKJzecZzK1Q+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGbff918eyCPhtwdYUj1WSUu2qGTzXJqox35FYEb9cU=;
 b=vGqIjsxPgC8oQmah19C2oLK5S6ks+p7/PL9LDkBAdyzbE4MFxoj3CCPWEAA59SMWRThMrlU2meRC9HrW/v9FlOdbSMEHzHxVlKnZ4TvSewli8RhcNnWnubxUyf1UCH2pxtuYhB/MlqvgqDJgUxt8QL08arz3ZVPbjnP65wv6XPIGb41An4kPVn6X3uTkEo8QZw2bGKrznMr2F3AN3I8n2WCqxguGfn2zHtGtS6xZgtTDKc+Ry955m5wAxU7kXbZdNK/3iMeTrA/ZrPEOgHEDHTmYUvEa9bLZ7fc6/1+tjffRYCK111+iRRNUgbSyT2AJJcm9sCeoBHPHgqD/Sp+DqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGbff918eyCPhtwdYUj1WSUu2qGTzXJqox35FYEb9cU=;
 b=BFwSRehn28kH8Q5bv9b5Od78AUt+l330cJtfVAZYnwnDkzkuF7n+/dBj1yDNl2I3fQ2g2X74fkB78WKLRpyJouA4locGPl1bd8M4LR6+3ckpj1GVptD7qOGmPap+Dpco5Of14Vw8p4vt5wuVpjYMbA+qpgoIlo740OHHmcAyx8Q=
Received: from DUZP191CA0039.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::13)
 by GV1PR02MB10760.eurprd02.prod.outlook.com (2603:10a6:150:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 13 Nov
 2026 17:20:43 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::8d) by DUZP191CA0039.outlook.office365.com
 (2603:10a6:10:4f8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 13 Nov 2026 17:20:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 17:20:42 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 13 Nov
 2026 18:20:41 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?Q?S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, <kernel@axis.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH 0/2] iio: Add some drivers supported by Axis Communications
 to MAINTAINERS
Message-ID: <cover.1794589264.git.waqar.hameed@axis.com>
Date: Fri, 13 Nov 2026 18:20:41 +0100
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|GV1PR02MB10760:EE_
X-MS-Office365-Filtering-Correlation-Id: 2218bac8-915c-4894-fa6f-08df41aa7263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|18002099003|10067099003|11063799006|56012099006|261102123227099003|261026140227099003|261021135927099003|261021121427099003|261009223027099003|261022105027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	Cdo9MFgLzVd+R56YyZlNWrzuY4HrzGDbp5olk3G6DY3w9+wA+0uvhHDydSXdR+MoP12Bu8JrSQNOYGJrYRKw9gx6HEV+saPGbt474TqZtK7Bt312qFsYciht1b5FeKPEisHZ4A92ovth+jhQYakc2POHFJG6qMs6QIpVaoJ7FEvGIBMW9JC5coPZQ5vqoNQegx9v1HynCts9WIf/QYTyXz98be0QPNYmrjH4fUrtJn2mTMRKLZoSudGRZ1WnBhiWzmDmH3aAoethgIRmtb0Zj8QErrdqwG5WfjqKX+Jv7iHoE4B2UeBsS6/xL1Kju/DMuTg7HdBe1QFdjy+y9v7oUmfw6n5HFPpNSogocLVqJEvQhWj+zM2ENm6eJvU1u2rMm/tAce1/edidhxxcDtoRQuYTtLQBr8tPNTQwY/1H9pKW+16Lf0KYe9Yo6e6+PcdJ+llRiUi4iMOhAzTdFk6xET8MFBAY7kvX6lMfGiHZunQ0vlLVnhuuMYYb9/xUqwkjxRdiHtDiiSQ8uq3iRLg3wO/YASLrptBgXCR7urdZvz19XPHoszGqm/ZNh+jRskpd6yRDeJ8KYbZNMxfCOGn1z8A/KrbAb3nbeclwOoGLYvmyK5K/4F/WeOr0cNVFnRz3Qqccu2bH+e4Y6M56jXJbfUUAtdMmYrD1zvoms39UiD+3J1uPBt4+V4XrUk0RDhP5YuQqpfGCLDcuPUDSNWEFJw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(18002099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261026140227099003)(261021135927099003)(261021121427099003)(261009223027099003)(261022105027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qhPy/h8uX7rbXWw3CmqTMO3djMpl6zlApMS+f1LTRjoQqeKZIi4wgL/VAEEPvnoR2t/t8XQTBn/mzpzHVGGGGHIUUDGXrYv/VIF+mKLK5SKppbB1a4aF05XaShiAo9AajgYVRmQlsz/PHZOs0UMhW0A16hef5rDN02EtP20p+RjLQ1W9mkyS9EuVkFpQm2k7U8XjB6p+8+N7oZ527kms2m7HZIBPe3CozEQCBjmlBVwn0U/244zdVmvXRTKkRbu0CBm+c8fkbCplPBZVrMQP+ws+xhIpnC5FPcHMN4DzYtdw3JbyuDHsY8LYf5Ln1RlUa9UWuZq91mDKAB7qhJb5viZBPIvWEIzu3l3WalnggjJT/u5TJRHD6eUhdh9cTybJ+/f3onIhlYduZ6uNwSHic5WY8hxadwKH/DcGlWF4C8NBp9kuco7+q99nLwKxg1Mf
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:20:42.8071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2218bac8-915c-4894-fa6f-08df41aa7263
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10760

This patch series adds some drivers that Axis Communications originally
authored to the MAINTAINERS file. We have resources to maintain and
review patches for these, e.g. hardware and test frameworks.

Waqar Hameed (2):
  MAINTAINERS: Add Murata IRS-D200 PIR sensor driver
  MAINTAINERS: Add Nicera D3-323-AA PIR sensor driver

 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)


base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b
-- 
2.43.0

