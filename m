Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.125
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793170087;
	b=fyQJpjn1PvpvmuSFUaWJHmzhN5CF/D4+KTQ7T8zBqKSzjJyyAxeyurBLjpZX7dYvWL7q
	 H+wKO0OvzL4Hs7IU6o58i4MjXRFPj8aeIxgCbKjoGwKELkHzloyGx9KEgyyQ4o56NnQUc
	 8vc9Q+BBANWEVJh+UN0ajgfskp95bXWATAHuwn92Ld/N5suHkW6U9vUVYcaIuN5uc/ehN
	 DGqjBI/tskZ0mTkJ6mEUgkbFBfKIUfHzN7X34QehBNNi6YYNxp0BS1QGh/oh1Ic/UvHZ/
	 TWC70/RLXFSsuBO7MbaqBDpInclswN4+ljUvXYdM/8s5NpctTHx+wwiKX/bzhdJPG3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793170087;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Authentication-Results-Original:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:CC:References:Content-Language:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
	 X-CodeTwoProcessed:X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
	bh=lsAT2PbpBYge1+hSiSeKhuFBIjYprkumtKIZ80iZevY=;
	b=Vh2oV5IsVOb12PwtCA5Iv+MqVz+Q+NAK1iO3mfCbpj+1ckYO+748BsbXlZoMubLz3Ii9
	 rMIQ0ZkXB+VMj2OeHQXG4L7H70F4WKfDlJR010gmRyNjWU7Hm3cwoaL34f4GDhjFxpYxb
	 1hczWKARa8Wh0qaeyb1T1WwDE3irNSN2/a+Iz1e+O1aT8BLYTLpQhvd1KO7EBviz5he+8
	 Ldyui0QrhPkweyMXshLANaIolk2vAt170WXTlLZdREEuUi1dOmRWQFQecybRj9xXcg+bW
	 A8wTr1COhmsBQcwxIqmNa/CPriLXrzMcr0cB2BSq7SV0i20cstD6/Lh+kkHt6G8kIew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=topic.nl;
	spf=pass smtp.mailfrom=topic.nl;
	dkim=pass header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256 header.s=selector2 header.b="aoEA/6J7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.125
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020125.outbound.protection.outlook.com [52.101.69.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C43606A31A;
	Wed, 28 Oct 2026 06:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21C43606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256 header.s=selector2 header.b=aoEA/6J7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOEyNusvPat4wEGujr32+AfGmV06XiZAjVbxkVaZX0FqTbe0DbG3oT8/nP7CqWusJUODNgAHOakHPJfYzKs+p7UK1LQXE98C1dCF/9AmLUrKF6WrRI+psFSsPiP1UBZZGQ3ThaBsNsYiLL4o6JtCFF9I7Isc1HnoglFNXJ+U46BUt04xTj+OrV1/5dOLiES9LJnzgR0XxXr5hIbfQkgVw3ENhbCm3xjkIm6QO2GYJNHXNpKnS5IdoNc/G6r7eobqA3x+3FaWAfnr0KuXmW5LGwuk4PhIiNWQu06s/JWvu4rV/6t4GRYOVolVyDQCDpG6wTek0XSkY32mBOfLvqnKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsAT2PbpBYge1+hSiSeKhuFBIjYprkumtKIZ80iZevY=;
 b=pCh1aMNVBCVK02Jz4GipeSTFv2VJmOjSJ7IQYGuvnwS9hYqFuFNnxVbDK9gqJMuycfMeH2nBUFy+pDX+zBU25yu2j2cgogAuvW/JlyGR0zZRNWuNvxWe1BPtDWBK69VMuHmcr3MsBQDNpMzAy9XcpBWYN6iaeDDIzSneAdtz/QcZhwd/MTFwCwbsqjJ5ihvBpwcL/SqcHCgaigzO0OAGCFENozm3WPni4hQFDUylW5Qiccbj96BCCjLz9YewQIZdi6gLDfp4bDdBIhsCNq+p9CWT1vnRadTTr0y5tbrIO2weJcIOqc7ZIB5aakVxizCfkQgaQHw1xH45iBawFThiEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=topic.nl; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsAT2PbpBYge1+hSiSeKhuFBIjYprkumtKIZ80iZevY=;
 b=aoEA/6J7oiuLAuFBt79zDi6oTucCiRy4Az4qbZhKgX9R+oWuKRUfwkJFsAdziPrg3gOaoiNFEulOC5PtyIKJv7uZk21/m7J+QwTxpiERdjNhj3k/iD1BRzEB6HENTHU22OZubA5xsJQZLIqHd8lQmOzISuJnnGaYK2bLqTZtcr4dsJqSF0in8pPofuhaWEYxoDD6OmPgfjGxnoleClbBHqfm8vg3aWLtjMevAemaqB6L/GZwf0pqXQsvqbDGOD2obo0kKk5tuxxocIAKdm7ywAIaoFZhn6cNMYelxkRkj49nXOJAxSN+uCNsWAQTWZwlnkkd9DKNSyXpdFsC5mXbUw==
Received: from WA2PEPF000008C7.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d8::694)
 by MA9PR04MB121114.eurprd04.prod.outlook.com (2603:10a6:250:116::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 06:48:00 +0000
Received: from WA1PEPF00009B39.eurprd05.prod.outlook.com (2603:10a6:1d8::116)
 by WA2PEPF000008C7.outlook.office365.com (2603:10a6:1d8::694) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22
 via Frontend Transport; Wed, 28 Oct 2026 06:48:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 20.93.157.195) smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 WA1PEPF00009B39.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 06:48:00 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (40.93.65.49) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 28 Oct 2026 06:47:59 +0000
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by PR3PR04MB7387.eurprd04.prod.outlook.com
 (2603:10a6:102:91::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 06:47:56 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 06:47:56 +0000
Message-ID: <e3d1e19a-fb81-4925-a674-60429d398456@topic.nl>
Date: Wed, 28 Oct 2026 07:47:54 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2 2/6] iio: adc: ti-ads1298: fix power-up and clock
 handling
To: Stephan Costa Barros <stephanbrrs8@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
 <20261024231335.280955-3-stephanbrrs8@gmail.com>
 <184780c8-6d87-4983-8399-6e509a250cfc@topic.nl>
 <20261028021915.29695-1-stephanbrrs8@gmail.com>
Content-Language: nl, en-US
Organization: TOPIC
In-Reply-To: <20261028021915.29695-1-stephanbrrs8@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS9PR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::19) To VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR04MB12030:EE_|PR3PR04MB7387:EE_|WA1PEPF00009B39:EE_|MA9PR04MB121114:EE_
X-MS-Office365-Filtering-Correlation-Id: 085bd268-568b-4998-0564-08df34bf685e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|261021121427099003|261026140227099003|4143699003|261022075727099003|261022105027099003|261021135927099003|10067099003|261021123027099003|22082099003|261026121527099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 3KKc48CXZmHUmB6OtnlwRdLAYKNuzSVaGSlzLtjTBWkscsW9qKiOscZq8v6CrbhZM9dZvrGgtxucUDkOllCS0UPHTwwTQ8Rk4FeEwooGLe0BTQ9LId8iF1TSaXokB58Zm3k82r2naxUMM4J+P5pcvXXAEaN+SczxryDzkF0nbV3aqK6lTtMuMID8nhiDX/Pac57m0Uem3twrp4O1KJQ7aU5GmKS4HI+lRqOn9ziVCnvFSzy9HKpEjlO5yvRf4YhWSs49ranhA29zXHwP5/1UMGe9x0GcCEuAD3DYZpsrwX6NP9RFU2h+Dr5zPj0w/sbvsNrYjZ1xwa9sflyEvPvvF6h6SjzRDE2iEgDdwSgmsu9xtwFN8UgjGWAC1qiCZP/sAju8qOJ4RTQfG49ravQLJn+dtZgXk5U1Z+IgqOvvXo8EDZJ6rXpM0UCLvxcwSf8bPFRJgAdYDv7tNNiOjPUZlcAyaGqEAbrcmMqwkn9BfCoyqlEiJCXXWtOF6CRhlDKkguloSWck2X4bO/c6sT4jsXSvd3lHPtfWi9rPP1lFRZfLx0gwNWdZe3J6GshxilgKRL8Rz7hI4YpRqLBmBQ16tqyx3adJQgfvKwX7h/+7wvfS6Pm7LPyp1eTRlFX4jrTnL3HhvXykhiQLQhkAFYzfk2dJbgA4EnFqVsHie7U1jSk=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12030.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(261021121427099003)(261026140227099003)(4143699003)(261022075727099003)(261022105027099003)(261021135927099003)(10067099003)(261021123027099003)(22082099003)(261026121527099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: Gnf/r6HNpsmlEXZ/PfzYCzsjyYzygOvrLuw5ImDivuzq+gaFVqr/GS3n7nfPJ/BjsbGmela1hivhQe2hnWvqCypBACcaY1/d0dKLgAkrDsvHmp5HHBMTvWx53aWNNFt+H6qA+vJL8t/pOnxtd1kbGf4bbf0DoB4O8oMsYJMb/sztpU4BihSxLfHqTrpJQVH/me3m9iEBzE7w5amQSqHfZFZ5YfGup5u4t+YESm8iFTp/2PbEGR7JqCyPh+HwF9y5zMAIv6DldXwqEsbiZqKPef/4eK7P30yNT63qxTnGY6Z2jVtv5bSRqhxT/VuWOM0eeWLLMO2yaTNarl/SRxcDfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7387
X-CodeTwo-MessageID: 3e973979-80e4-4fa7-95e4-95a853ae6420.20261028064759@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 WA1PEPF00009B39.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e934ba1f-f4b7-4dce-76b2-08df34bf65c5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|35042699022|23010399003|1800799024|376014|36860700016|14060799003|82310400026|261026140227099003|261021123027099003|4143699003|261022075727099003|56012099006|261021135927099003|261022105027099003|261021121427099003|10067099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4ZMZZzOjywdvKSLzNyvgAdhpGjTfQohCqg2Be+dJTWkVQGHUt9xXmAkHspf5XTYFPXqy8lSE9kUppUkOCygOl08Tbghv8LOErJjssF3/WGuBYuIf2zB0mXUHvo70xBhtVGhYmO0OSD0uJgUExaczSfGvJz9xkXnYkDasxIDu77cKeXldccKpxAUShFnizFY3FbprUwFaGUdQQumwhTS6MiC7I7ij4nrJjwn4AW8MXh3mF9LIwh8obTr7m7c2MZOwPIlyR+P3U1h4evKpmJeSSbfjuBkjtkV2bzgDssPc/rVllIW9wu9yJj8pQenJy3oO8yHem/6wKr16idTUBBTu58UBCBiJVhTb/BRc3AEN6xU0KOEoQBn4cqMz1UIloVYoDRIMLE14n23ehqBCitnYh33Ql8+WKyJU5vBlx3R03Y2YeAN6A/4vVvosdzJcRCZKqZUQVbqY83JZZm8phXub8/Eb334RcA8IWcsW93crpSeem0jYwekyY0ujFuISg5XLjqd/k8yUWD6booHcSZpEhfyP6Q3Q0CeVhZ4huAq/M4g1zlVxOGlpBROboswPF6BLdh4pYZiGjpYYUqzlP5dA32JcDc6XfulE6MXGBT9NB1ubxBCoPl/RtDy1vJu11pqe93AbRHhVJQGwF+j+SivUsUvADrybdjo8Ocg9Ud+TzoePdaSigBdMxCJPWxbYc8cXXkUt1Yy35Ahc+1zcdQH/UQ==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(7416014)(35042699022)(23010399003)(1800799024)(376014)(36860700016)(14060799003)(82310400026)(261026140227099003)(261021123027099003)(4143699003)(261022075727099003)(56012099006)(261021135927099003)(261022105027099003)(261021121427099003)(10067099003)(261026121527099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BuPU3YFex5zUdyaakRDfrg34LHM6HLKFh7mognSeV9iAhdDBp1rfsLK7TVwvrNrHWjHi9wcQz18EeVdcB8EG6Cni4kt2MyM7/zZdlszSLnGDQ2ukPvPZYjfVQpwwVZX/0ciKM9HAHuHreddJrkyH9dj/oWt6OsYlUC3SL4yD6SME8361j8LxIDG8OYxjDH4qgkcOIlppRfbvukNiRRQA7qLQsGiL669qCo3HbdLZFr6nrI80RgDGlpiVPAZV8KxG2ZxNRZDVuGNanCG+GsMLLPR+hP3oMOAgYMG+pgIZNAjb10B/B7t9Vi9sZLmHjuWqu1erCWZxwiqUnDcJi7it2a7HwsFmiarL7NMRgVNks8gvDkZlxRmvWQNv/QnQoh1QgUe7xeyClf7J8g+xns8waia1zk0e6I+1TFf+ujcxUmvW1kwJ/XcS2w096t84wSG1
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 06:48:00.0840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 085bd268-568b-4998-0564-08df34bf685e
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B39.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR04MB121114

On 10/28/26 03:19, Stephan Costa Barros wrote:
> Hi Mike,
>
> On Mon, Oct 26, 2026 at 07:27:22AM +0100, Mike Looijmans wrote:
>> On 25-10-2026 01:13, Stephan Costa Barros wrote:
>>> - The datasheet powers up the supplies first, then the clock, then
>>>     waits t_POR =3D 2^18 clock cycles (128 ms at 2.048 MHz) before the
>>>     reset. The driver enabled an external clock and the vref supply
>>>     before AVDD, reset right away, and did not wait for the 150 ms
>>>     start-up of the internal reference. Follow the datasheet. Probe tak=
es
>>>     about 280 ms longer.
>> The driver followed the correct procedure: Keep reset asserted until the
>> power is enabled.
>>
>> We've seen the chips misbehave when the power supplies ramp up
>> erratically. Keeping them in reset until the power supplies are stable
>> solves that issue, if a reset signal is available. The driver is based
>> on real experience with these chips.
> Thanks, that experience is what I lack here.
>
> The patch keeps that: RESET is still requested asserted before anything
> is enabled, and released only after AVDD, VREF and the clock are on.
> What changes is that AVDD now comes before the clock and VREF, and that
> the driver waits t_POR before releasing RESET. "reset right away" meant
> releasing it without that wait; I'll reword it.
Ah, okay.
> Is AVDD before the clock fine with you? Section 11.1 asks to keep all
> digital inputs, CLK included, low until the supplies are stable.

That sounds solid, better than it was.


>> There is no need to wait for the internal reference startup. The
>> internal reference only affects the ADC performance, it isn't required
>> for digital communication. By the time userspace gets to use the driver,
>> those 150 ms will have passed already.
> Agreed, I'll drop that wait.
>
>> We actually have 8 (or more) of these chips on a single board. If it
>> takes 8x 280 ms extra to boot such a board, it will fail to meet medical
>> specs (reboot in 5 seconds).
> Understood. Without the reference wait it is t_POR alone, 128 ms per
> chip at 2.048 MHz, still about 1 s for 8 chips probed one after another.

Which is still unreasonably long.

We modelled this into the power supply.

The 8 chips all share their power supplies, so the first to switch on will=
=20
need the delay, but the others don't. So if you put a delay on the power=20
supply, only whatever device triggers it first will have to wait. All devic=
es=20
that use that power supply will wait in parallel. And if the supply is on a=
t=20
boot, there'll be no delay.


>> The ADS1298 datasheet says "18" clock cycles, not "2^18". Quite a
>> difference. We would definitely have noticed if the reset timeout was
>> that far off.
> I read 2^18 in the current revision, SBAS459K (August 2015), Table 38:
> "t_POR, Wait after power up until reset, MIN 2^18 t_CLK", with the note
> "When using an external clock, t_POR timing does not start until CLK is
> valid". Its revision history lists "Changed power-up reset wait time in
> Table 38", so older revisions may differ. The 18 t_CLK in Figure 105 is
> the wait after the reset pulse, which the driver already does. The
> ADS1299 datasheet (SBAS499C, Table 30) gives 2^18 t_CLK as well.

Oh, you're quite right, I stand corrected. Don't recall it, it's been a whi=
le=20
since I worked on that project.


> That said, I have not seen the missing wait cause a failure on hardware.
> On my board the supplies are up long before the driver probes, so t_POR
> has passed by then, and that may be the case on yours too. Does the
> driver switch the supplies on your boards, or are they on from boot?

The AVDD is separate and shared, the DVDD is just always on (also powers th=
e=20
CPU and a bunch of IO banks).

But what I said before applies, the delay should be in the power supply. Th=
en=20
all devices sharing that supply can wait in parallel.



>
> In v3 the supply order, the t_POR wait and the clock rate become
> separate patches, as Jonathan asked, so each can be judged on its own.
>
> Regards,
> Stephan

Mike.



