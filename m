Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793599364;
	b=ixU3w6K4E7b0sASH2d0xb+t2Q1AiBu5xz4ooVr9lI9bHP3SBb2K0Tl4fqTia9zUHavBH
	 oDH1YB9pnRy4bhvWfayeV9gJoHOtCQF3IycsNMoWMUBZZbhcaQ1sW5N7GWnpCzQ2h1MSV
	 +v3xUZGEyquJrw9Lr00UjcAu0rGQWherjWKzYxCtuzuLmLq7+/OeQ+GnmjNJDYcalYHD1
	 9/wZTzM/l/8YIx17ASBkxpvWTy487tdsSjeEjeHmesBSrIFLhkjH22ZhoEAJ9BWBO1y4D
	 UlzGQvuoAoAshEd53Uj796m7F3GqdIJUzfPpeDNuuBPZ+DnTBEXqvnIYx1CVNC30GpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793599364;
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
	bh=v2XpE0mBCrnMBwzqVUL+2e/7Vy/CBAdt9RkDNBh4TMA=;
	b=0zM/P/2D2Y58w3BySrY9HAyVOq8RqXlyFdwmdXs3d+FUQWAbG0aBCzFJfT5p8ANWBKz6
	 H5tqqEseWi3NVNidwVtv09UG17nIyZ4hw0p8VIF0vmUO1CTkdN+fy9LTyCXgDHdGgOlGh
	 PWi/XQejotFp863CNBoSY1luPIfiVt6KFEIeim9rq+gRv9Ze177j0Vni6AFOXvX5Grcsi
	 rCLyIgaZbRRmsI/zfYgzTu4vb6MlPja1ydEK18uQsbNlLm86/Xwrl/y5vjCOoyD2qqWOF
	 4CyZydb4zEDKPHx9URSphiDfU92JjKzB8I7lO9TqhDv44BaPLcs/HRo8FzdnJnlKopw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=topic.nl;
	spf=pass smtp.mailfrom=topic.nl;
	dkim=pass header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256 header.s=selector2 header.b=ST5FPAgI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.124
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023124.outbound.protection.outlook.com [40.107.159.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B7606A327;
	Mon,  2 Nov 2026 06:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 867B7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256 header.s=selector2 header.b=ST5FPAgI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M//3mbYfvdlfvnCkoPALmOucQ7AQV9kEm77Cgju0RRn3oqOy41JOlVM0t9unPoLVIUu9yeUVH0MB+uVwN/+nxZ5RIFrJxCRqZNToMlR5y2rQZHaIVmBnoHexbmbejV66kxkgNtth99LplyGQueoNHQc+ykXS0K4SW5jey6x/QYt0qMsUIRiWfZ+7pP/qn4D7F/IDQBhVHIY4a5sZALkEwo08EkffLnglcCd/M4ij1TdGt2GUtexObYef6B9J3Lvm4faW4DWMRfx6tZLDLbkg09Y21uO5ZCwtUf8rEWAi1QsOBoYIiXR1NYIwirsLSjv7VosyCDpj1MXHVoobbtau9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2XpE0mBCrnMBwzqVUL+2e/7Vy/CBAdt9RkDNBh4TMA=;
 b=s/NP0co045WfVJLMUWjKiqpo3saRO+e0STKKHOn3QjAmRmxXVmiACTge07MpBJRf66keauEd7XX9z91KCMvVPA4tOe1fJZhGAlZnGjIDvGPXZr20xKkICN851BL0CAfRBpVG8i3fbn9DBMk+59HRCq/V1/5kon60RfSsBn+gf4IbWrvW8sTtPC8K2tYpkcBxcJRJH03TeUoPbC32hNjEoc+B70FdOA8HDnD3v31oomlBzUXtevLA2GCbYkoYYHYiaqB6G2kD559lJIpiux1vn3Q7f1Bk/Rnu93iG7bRDtGDRMi49TV8UMV5U1iESJrtIiXI9nLjRuLY4hfx92NdqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=topic.nl; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2XpE0mBCrnMBwzqVUL+2e/7Vy/CBAdt9RkDNBh4TMA=;
 b=ST5FPAgIqJDw9x1tzj2YxCwyREg0z1eH4StS0jDByNnvjGsuRRpn1x4GcCaAojaTjtAqbYORKDu73t6qnSK0guueSU7ar2tDideVRltuD2po1vLS8NyLmGW4/QQgl4s2Kvlzr+9tYbA4iWok29deiSWWFhlvfRePJdl06JCJEXZn7aIUjzQG/xqclIYn7CGVP5HbqRNKzuHZ9BAlG2HXYqKunfO5JTALEVhX2804CbC6l5637d0RBk1HTP30ZWMMyG3mwXLw30BjWr45+ohYEWE1/mGoFiopT+deLMTAc0DTHP08K+g8p/DwL7xtOAwZe54jbFpoqv2V6xQ9CqCBQw==
Received: from PR1P264CA0178.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:344::16)
 by AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 06:02:38 +0000
Received: from MI3PEPF0000849C.eurprd03.prod.outlook.com
 (2603:10a6:102:344:cafe::75) by PR1P264CA0178.outlook.office365.com
 (2603:10a6:102:344::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 06:02:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 20.93.157.195) smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 MI3PEPF0000849C.mail.protection.outlook.com (10.167.240.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 06:02:36 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (40.93.65.50) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 02 Nov 2026 06:02:29 +0000
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by VI0PR04MB11546.eurprd04.prod.outlook.com
 (2603:10a6:800:301::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 06:02:26 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 06:02:26 +0000
Message-ID: <350165b7-9a07-4cec-a306-e6c006f7219c@topic.nl>
Date: Mon, 2 Nov 2026 07:02:25 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2 1/6] iio: adc: ti-ads1298: fix the data read path
To: Jonathan Cameron <jic23@kernel.org>,
 Stephan Costa Barros <stephanbrrs8@gmail.com>
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
 <20261024231335.280955-2-stephanbrrs8@gmail.com>
 <20261025230601.6a2eae34@jic23-hlaptop>
 <20261028021946.29877-1-stephanbrrs8@gmail.com>
 <20261102000802.646dfd86@jic23-hlaptop>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.ed949772-52db-42ef-8d2c-847df5a618d7.250833dd-44db-45a9-a0fe-3a8f8120e7b7@emailsignatures365.codetwo.com>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <20261102000802.646dfd86@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P192CA0026.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::10) To VI0PR04MB12030.eurprd04.prod.outlook.com
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
	VI0PR04MB12030:EE_|VI0PR04MB11546:EE_|MI3PEPF0000849C:EE_|AM8PR04MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c6c1e6-6b3a-4916-f986-08df38a6e51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|23010399003|6133799003|22082099003|18002099003|10067099003|56012099006|261022105027099003|261021121427099003|261022075727099003|5023799004|4143699003|261028144727099003|38350700014|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info-Original:
 ZUY/F8Feqi/4+vd2zo1O7o9y0lJCFx0x3J2BMXevrnGIvkhYE/9U94f1e6S0gvVBeo6oqGHWFvJrqIAj+XEuD7FVsWQt3cm61cdfOlsYpWP2RWXDNe2S8dBbWfZ5JIeE12MTs2gP2Li/p+yWKZNAin+xPkq3ymiKC2/BboSexoOfstpAfam1mUSVHQL+i1Gy39szds2/efW0OnduFiTqTCRiLDMrstfVo9pDAERvJu6ZX0t/Tg/tZWRN9z5elZihhgp17e2vGb9l3jrPoCHAFEZ/21Jsef1DND+EAAOt8BcOeQJpZ230Yfi6NIgrHZKv8UDwwz2pFHduH/YkxswWgehBfz1lu5yH1V8z7p6F1TeGDaYgouhXUzmOp3G0Xfta9HiSDh2K2sZce+UqtW8YV/U5JCTp7/gySnRclZamBtq0RTEOiDUCKCBLQcCiEu3X9nDQRjfxUfX40T/I4jMXxkyMPSn+510FNOCGT2uCx1XxmHoFNa521i2pUJRGAj/30ulfZ4yptBAHmVkYTt1STU4A671vfO0DzRQSo6HpBuLNm5KtLgVPHa5p+5MbSMXA2EN16fB1f+c9d/hSq8DbS+DVOoNW2DdxcsQkghIfCTmDk8/EfWhQ2DlHBC8vdFzxWHh3X+yRIf6tiGXZzP2LGEnL4d9Z3dcUp7fDxSvXgHc=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12030.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(5023799004)(4143699003)(261028144727099003)(38350700014)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: Xuzndk2kWXr2U7hxDe8/j+gGQ8B4zXefSH9hTnIMMQCo3g1oupGnpUwfVyUetKSQMgXiT3krYlmrL6pvwOdFscVZpLC2bFRQOOx8MA9lLFkDgA46uHf2C4albFYhQ+Hu3X5apuVaEq1Erj2vER3xMNOSMgnNJxvDyHME1OcKrsSiyVPlCPMB4KEElX6rhYpJtJH7U7GObFjz8Tr9KPdxzxm/F+ukSbRbhONXi1S6oPiO9NaXKH4x/j7u5gsUvkdanB8tL6+cnQ7PgzGwX7Wrjd/M6AlsVSxg4Mt6jsS3QV7/azPvECWpjf1ciFfn2adGKDUFTELVQkq5g+/yr7uEuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11546
X-CodeTwo-MessageID: 4512bf28-89ff-4bd8-9672-8bbe9925aaee.20261102060229@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MI3PEPF0000849C.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f6e408b9-2ddf-495d-ebb0-08df38a6dee0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|14060799003|1800799024|35042699022|23010399003|6133799003|10067099003|22082099003|18002099003|13003099007|56012099006|5023799004|4143699003|261021121427099003|261021123027099003|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	1hTrZu748xldjAJJUxLabHHG4Hp6Bkg0H+duifzoaky+rZz7dPIHs/ZH08tRizEM+54mrlvbd8emBEnSj/NjwNlzJNN+P0ATO1mmWZS89tTCWb25wsmVF/vo2cbo/SiLPrzmWcIXKMuolF/EWwSPSm43meijL6nqS4zwQIznm5crBTvWILLteNrm1p0QGggsvbh8nvP9Vz/3BHdqL7Ygxo+/65x+yNkOrWgDV5BtsgDy0JkopGChj9BUGrjrNCAYgYIzxtOKocVu7xj2zg/ACTIfdIsERVmJ2Hg1hSc9K1vJRC0V5CmVQd/cVjFjtUb8FWAvLiHpxUK5uCBUvi4lTZD3dAALSY/dccq5EXm/35PATxGzyKIMyWp/kVYyyDXNVn3jHRKeh3BylxFCywni32qKzglgnRKxsLeK703uZLAFQeMjT6sdBJXmz2ZnxcXCEw2qXxA+hoK6T8i7DLn5emfa2/ZRB5lfyuGdmP1+rd7MzlhYtcusuiulSRlWqyE1IQXmNebFajdmbeVVwMfMbJihq1AOtdCQMYM0aArjMgfIgABmHsU8RjLtEsP9vqSxgFAd8vzKjwCAtfPQjvZejNTyOhssQ0JP2Jzav1KWWngbl1rYYJp54avmSn1bp0ctUcLGWH+AgR0YIK/qvWXblQ==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(14060799003)(1800799024)(35042699022)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(13003099007)(56012099006)(5023799004)(4143699003)(261021121427099003)(261021123027099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261028144727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zyylAVpP1aj/7980x8r0m0LU5Uh0hW/+hDhkMsL/kD8LX39+Vu3sA5yvejADpXObmiBKBdB4TOe/I+V0GJpF8gxsZlNrTpFaRmhNrJZXaVX2FQY5msUeDhqVSkD+69iO9JzLJNqaggd00FzhrVZa3yU+NML/OQMwwPGaFiNwx1+YEnG8GtP5WnQBiO7JfIsZO7TTmS7JHvVZS5K886orZPz7e+S5ZwMQ3iP/A+L1XSq+t5jjU3ol/ZOmc77//nq4FFCoUnfFOaAuKOGnZkGrZYL5USAjXsIUcATZp2M7+Yz20zAi/G3dEzfstUut4tP1Xi95q3ThJIrxppw/xPorT3JDPaPqZO4/3JZqfu5nrAIV8yu9MjXewqblZAaB0JYqO5bAO0yji9WOd4BwPCvYwLmdT762VPldISXNtrDxF286CqdpqdKWyfKpw4ihh4rW
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 06:02:36.6343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c6c1e6-6b3a-4916-f986-08df38a6e51d
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000849C.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7284

Resent, this one got out as a HTML mail and the company mail server=20
added some bits... Sorry for the inconvenience.


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Systems B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 79=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 02-11-2026 01:08, Jonathan Cameron wrote:
>>> Complicated sounding solution. Can we claim buffered mode instead?
>>> That would ensure the update_scan_mode and this don't race and mostly
>>> would be taking an uncontended lock.
>> I don't see how to do it where the race is. The sample is pushed from
>> ads1298_rdata_complete(), the completion of that spi_async(), which the
>> SPI core "invokes in a context which can't sleep".
> Ah.  I'd missed that complexity and was assuming this was a normal
> threaded interrupt handler.  One simplification here would be to stop usi=
ng
> async spi and instead just use synchronous spi in an interrupt thread whi=
ch
> is how most drivers handle similar flows.

The async SPI is there for a reason - at least the hardware we had at=20
the time would drop samples with the threaded interrupt solution.

The hardware wasn't really designed with an application CPU in mind, or=20
they would have added a small FIFO to reduce the interrupt rate.=C2=A0At it=
s=20
nominal 500 Hz frequency the interrupt rate is already 1 kHz.

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E:mike.looijmans@topic.nl
W:www.topic.nl


