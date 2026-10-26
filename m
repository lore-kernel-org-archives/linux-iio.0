Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792996058;
	b=pfGs7nmHmXElLXOd7gKL/9DC35JVfThIa7DmeM80YnmXoF5Qln7Ojj9XK4BGDH8UARj+
	 pJIqYeb4YdDaQ1UuppkzS9P1x1hg0ruoTt285jfXfSjev9XKZ5Q+QH3VLEiWN7QThWD5r
	 qjeAFNggt+SSWSevQLu303+Lx8c8XYPPygqc7BE7oOCKH9T+1bGZjwxpM4JVt71O+yrc9
	 Ws9HHEhzUZaug5VfY6qzvkSJUOpeabXm4gyWQS+gA+p6hWTXV1F0LHYK+D7DGkVJTAhEZ
	 up24/n5pk6OfxKsH9AS8R2nMFubB1WhW/UYZbnaISNRtQGMuFBrFPrgN2B3cz77nYeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792996058;
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
	bh=MmNvfs+/AhtW9THy5REQw8NsFepHMwy0wYf+lyCAXmE=;
	b=qv0gTEaaXKLAdWrEXvgGUUw/9UtaAqCBVJaUXcW92uNdZHZ1rKPn77/s2N9vTLxZHPx0
	 2CCqxuLjf+swqfGz2067hhf9O+4p9cwddyR2tspowN607KYeXuJswgu69bj/XUG2bfZNG
	 kf6lymMv/2IdJVYhNwVvnM6QfAZISLox0HWIhegLJAK4Nn8N7srFRLx1q82bdo+U5sciS
	 Sj0bcihv2xRFblB6kLYBO1PyWjN9KcXveX5rFl64SXL5ZWlSNsdFppOxD0AYuhVEQVUY8
	 SNKRN7hCk0RwMj7RFYXu4zf8m/laWTWFxLBCfA3/m9OACMHcQIcSCa/TsevbTp/TCHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=topic.nl;
	spf=pass smtp.mailfrom=topic.nl;
	dkim=pass header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256 header.s=selector2 header.b=MgV8sqyZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.135
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023135.outbound.protection.outlook.com [52.101.83.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F48B606A31A;
	Mon, 26 Oct 2026 06:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F48B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256 header.s=selector2 header.b=MgV8sqyZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ysy1B/4qMsDN7kwAWqgJn28QAKx+seI9lMZQTLNSWdWo77aEtr1gzeJi3cP2joZwQ7/yc58aOPF5yKwxvOe9yotp5bQDPucNtp0zfhWQz2g39Zuh5KebhKP9Q1VD0cFjpizb+5Bpi2bLUB9szmixsi8E/s3aODPgWs1dCd3XxMhpVbHvR0roMaWWVdyozDd3XC5P4TZh1ITFxKRgFKaKsyfXDtY1O1PZSOGpTJKvZAOLlduNo1ckO3ErDd4nYRJU4GILgxSR/IYZ/wSuF86OTINsGRiK1RjeQIR9ufJM5ugQUTqhwQxCS5BUt3RstZ1S5PGibI5fgKvq0y06EaiVnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmNvfs+/AhtW9THy5REQw8NsFepHMwy0wYf+lyCAXmE=;
 b=JqEkIqI1h1LG2wC/MZ6HjZ1Etb9xd3NHZsA8ocfH3kUhr3H5YYDrYAHI4sbrxwDTNmRAuzfW5LVyMvLvSgUh0shBDlVkxi1CMIAD6haII/fZWo4zjvA8mokG16U3RqA/IteOGCH3BqDwcTp76dHe3CYp+eb9WMdkPrZUdWUgE6Wej5XHdnAo51xdM2YIxdcPA/+nHwsiB532XPYT6qDpMyey9puIFS5ouLiXvVgM5YVyaToEOVHc1gB4cEYmfVsCnS4pX8IohqCeWP9u0rhkziJErXW+XqYfduWLV5cnaIuS8pcqtk4EBtrY50Fr2oY63oOWAMdUP++IqQbc9wq+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=topic.nl; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmNvfs+/AhtW9THy5REQw8NsFepHMwy0wYf+lyCAXmE=;
 b=MgV8sqyZcBrZhDjMOOS1MLCQI0XshJRvVI3hDiKNr9naL8ohCoFSv2mg6m/Z8funPFTfhgcilYrWPfhoNcLeJLIzf4QXtLP7CbtBVH8vk7qIYZO1aVwsK5VTb9G2gbLlrEKG0l7gZ9GMFNKzut+8q0hj01xhgmLdOoY9kiJ7pnzErhLK+kaGjwMo0uBwgQDxm0z7xLQX18nP6J/J10ciAD9S4uRBr9iazDLhjNUS6ysAt4rQfPxRyyvlRiXqKnCnTkvEVOgta0eoa/itkSJaGI6QD3UcVwdNfAETnpajAnGykgr3S7+zIuwLVxuEIxde7Vb2dGD6jt83IHa0kpxcOQ==
Received: from PR1P264CA0052.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2ca::9)
 by GV2PR04MB12272.eurprd04.prod.outlook.com (2603:10a6:150:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Mon, 26 Oct
 2026 06:27:29 +0000
Received: from MA3PEPF00000409.eurprd04.prod.outlook.com
 (2603:10a6:102:2ca:cafe::99) by PR1P264CA0052.outlook.office365.com
 (2603:10a6:102:2ca::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 06:27:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 20.93.157.195) smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 MA3PEPF00000409.mail.protection.outlook.com (10.167.241.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 06:27:28 +0000
Received: from DB3PR08CU002.outbound.protection.outlook.com (40.93.64.87) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 26 Oct 2026 06:27:27 +0000
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by MIWPR04MB533597.eurprd04.prod.outlook.com
 (2603:10a6:290:d7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 06:27:24 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 06:27:23 +0000
Message-ID: <184780c8-6d87-4983-8399-6e509a250cfc@topic.nl>
Date: Mon, 26 Oct 2026 07:27:22 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2 2/6] iio: adc: ti-ads1298: fix power-up and clock
 handling
To: Stephan Costa Barros <stephanbrrs8@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
 <20261024231335.280955-3-stephanbrrs8@gmail.com>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <20261024231335.280955-3-stephanbrrs8@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P189CA0042.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::20) To VI0PR04MB12030.eurprd04.prod.outlook.com
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
	VI0PR04MB12030:EE_|MIWPR04MB533597:EE_|MA3PEPF00000409:EE_|GV2PR04MB12272:EE_
X-MS-Office365-Filtering-Correlation-Id: 630d31c9-6097-4406-f6fa-08df332a35b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|52116014|38350700014|4143699003|56012099006|261021123027099003|261021121427099003|261022105027099003|261021135927099003|261022075727099003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info-Original:
 T/sP8xkjJ+WJ2QbfK5kstGray/TkKKs5Gd7u3HG5twi7yK+UDKE/kwwY+MtAvlLdpBqTfgy3JRTZNIr+ZeIphhEJ4qXglvpHN0+7GnkHCcK1LyO+xi8hki/0+lrkGfjydUDiUj6AfEqMfft/k5/6TRKPALnXP+z4+FYTAgAqXrQI2VsaQjRkC9dQqVBD4APvJcM2th+5yn6DkItDQru7yccpkyZD5Zwnrukm4kYPw/AhsiMTiCCQey1G5f9lukecFIbp85B6s7U2y5Z4pse52p0GI2B9bACgDeSqq8sC4mkTEXdlveQGP/reLxHFesKG7fmWeEgmlvyKSKJ5xpsDWwtB03txCzghro6gLyvcrFw8yCsC9QybwGdMBrlzqDuVJceMIe6afEPRyHOs5w3Sgd1XijvvBlN6ENycAZejrResNWegnbeuPcnjjTlHrGgcJFiTnZgVEmluzOVt9t+ETkDxCPcBRG04gD/k4+FhfOyJvGt+GYPO5K9ZIAxdWy+4+6tsvv0iusBIsD0Sq/x4/YZwlx4GZGobWE6GyxV1WFO1whSRkO6LCNoeH5e+x/zIpEJyJEMtImk/BsB9yhZn59h7G8IQ9qnrCvwgWXNc4aPNnVhfz6aBXapNo57kw8PywqNW//W5ptNtW9ENcuieBrudoJY3Kl5UUDXAELPAua4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12030.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(52116014)(38350700014)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261021135927099003)(261022075727099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked: zojkO7PSDq4wdLqLvk7T7ShXiieOTMz5W2+MtZ65y21G+iQT0VhQLne3aCUmzDYxcF4Hb2pT4VFvlUbxh8muR/24A2Psf5Xq6CWgNWfvtAPT3FX7D/Zi2dDtdZF8FyXv+/AwKnQqbxwUlGcWAR4WrD20k+sgkB4ADS/vih4WqQehUayFIa09PsKc8+u/jYZ+fZtz3/+9fP74Z2haw4KevAbt6G+5YfDr1HCG2Nf7ZbINFG29I1TZLanBmCtsFwXoNiI1oSvtv8h6cOaMmJgV0BmiKVgLh73cBxg3YfQmi7kIRgI+Ul8exFoKd+84dLIS40fuRpwcuqCU+i6018CWgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR04MB533597
X-CodeTwo-MessageID: c90f7a3d-9f96-4631-a869-bff2060f406d.20261026062727@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MA3PEPF00000409.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8643f964-21cc-49e5-aee4-08df332a3267
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|14060799003|7416014|376014|35042699022|36860700016|261009223027099003|261022105027099003|261022075727099003|261021121427099003|261021135927099003|261021123027099003|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|13003099007|4143699003;
X-Microsoft-Antispam-Message-Info:
	W/D5hvhwtWYsnnK24tIPJXZtoZN/EOwAQSl8RyUMvOiEmvry1NkelfZQDQOla3pYniYmhsVl6JpwhlXRanE8k6VL8ZYoMVizAfn/GVn55QBWMdggt/DivcPziXsVnH51Z+Y/ckXPPuIjVzIX7LMFYzTDaNEA4omlm0VXJ/zUtRtjSiRoV3nyf8xx6k4AudNAtnSOJwRTa330GzOc1eQvxvNRPQoZeGbD4lXHe1/ddxscifXA9T1ULcvMOANx1Drl/PFWJrBFF1+bqJU+5LXOia6z1e4n/iW+gW5ajKQsXf7MWMRBzePXd959jL3J89Z8f5VaUxIrhonSPuF3UtHP+1RQWu7KxLZZDpXv1Vh0+JibJWx39qwMl+myj66+Dw2PwmZBW6bpK7r1V8ffFOnAIMDu+r+aRsN+oxixQEYmDgbsvMEJefoRVPsEiyOoTa0HNX+79b9LO53eKtab2jqqEUaJLhovPxJexiRwoLGW0c/+9yrr7V/FApEYx6tBPT61uOxAniRVHnb/zdoFSBv9/evcuwII/eWbPpSD05Y4niCnzhah2CDB313smXrQ8g03W80s/557jvdv0iNZQ/Vse7kVfT91X8F4Ng2g0I3tRHDpau/FjCBscALPMztpYqpm8G5Jl4I3d3hl/pQp3uyAVg==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(14060799003)(7416014)(376014)(35042699022)(36860700016)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021135927099003)(261021123027099003)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(13003099007)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K+H0wgi922mUwJ7pEfbh42CNkHz2AShuZ7dlKCc/3HixZuherCUWkB0RNvN+CvMpLH3WwBBVqze0zTHGO0aC7AizL7NlanXYYqiVroHiGSdXuN+2uhKnE72ntfwuBalKPbIcWFUZZzPWiq8Q2sJv5O+rIXYXomtM5AX/uMZryxrO7DvVl0Hwbe1gbNALHjTBX7VhO4trgC9SW5kzOGSfZpc8tJh+pYCtF+caGAh4b54UbPM3wD4iuv3uxcKTxWmlBLXcwaZ69ggGkW5uE80QqVgUOKYrRu80l5rC+1XOrEo2m7+/uvFzcRzx6SqsoCMm9CNU/Z5j2Kk0jyozigr1KZNfwEwPm/PDyJc7d1QV6GNKZjzNdeuHCOt7bQzdhvAdsJUdW28ZHJtrDwyrpvQ+gcZJV3nLjtJI8uHJeWk2AWGQKIEn82NnDjVIexRfqEfH
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 06:27:28.8143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 630d31c9-6097-4406-f6fa-08df332a35b3
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MA3PEPF00000409.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12272

On 25-10-2026 01:13, Stephan Costa Barros wrote:
> Fix three issues with the power-up sequence and the device clock:
>
> - The datasheet powers up the supplies first, then the clock, then
>    waits t_POR =3D 2^18 clock cycles (128 ms at 2.048 MHz) before the
>    reset. The driver enabled an external clock and the vref supply
>    before AVDD, reset right away, and did not wait for the 150 ms
>    start-up of the internal reference. Follow the datasheet. Probe takes
>    about 280 ms longer.

The driver followed the correct procedure: Keep reset asserted until the=20
power is enabled.

We've seen the chips misbehave when the power supplies ramp up=20
erratically. Keeping them in reset until the power supplies are stable=20
solves that issue, if a reset signal is available. The driver is based=20
on real experience with these chips.

There is no need to wait for the internal reference startup. The=20
internal reference only affects the ADC performance, it isn't required=20
for digital communication. By the time userspace gets to use the driver,=20
those 150 ms will have passed already.

We actually have 8 (or more) of these chips on a single board. If it=20
takes 8x 280 ms extra to boot such a board, it will fail to meet medical=20
specs (reboot in 5 seconds).

The ADS1298 datasheet says "18" clock cycles, not "2^18". Quite a=20
difference. We would definitely have noticed if the reset timeout was=20
that far off.



> ...
> - A command takes 4 cycles of the device clock to decode, the minimum
>    reset pulse is 2 cycles, and the reset takes 18 more. These were
>    converted with the nominal 2.048 MHz, so a command ends after a fixed
>    2 us, short of 4 cycles with an external clock below 2 MHz, which the
>    ADS129x allows down to 1.94 MHz. Convert them with the rate of the
>    clock in use. At 2.048 MHz the delays do not change.
>
> The clock lookup was seen to fail on a Raspberry Pi 4, with a
> fixed-clock in the device tree. The power-up order was found by review
> and reproduced on an emulated device only. The decode time was found
> with an emulated device; it is not seen on hardware running at
> 2.048 MHz.
>
> Fixes: 00ef7708fa60 ("iio: adc: ti-ads1298: Add driver")
> Signed-off-by: Stephan Costa Barros <stephanbrrs8@gmail.com>
> ---
>   drivers/iio/adc/ti-ads1298.c | 73 +++++++++++++++++++++++++-----------
>   1 file changed, 51 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index 1d32b1f47..f5965b994 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -84,8 +84,12 @@
>   #define ADS1298_MAX_CHANNELS	8
>   #define ADS1298_BITS_PER_SAMPLE	24
>   #define ADS1298_CLK_RATE_HZ	2048000
> -#define ADS1298_CLOCKS_TO_USECS(x) \
> -		(DIV_ROUND_UP((x) * MICROHZ_PER_HZ, ADS1298_CLK_RATE_HZ))
> +/* A command takes 4 clock cycles to decode, before the next one may sta=
rt */
> +#define ADS1298_DECODE_CLOCKS	4
> +/* Power-on reset: wait 2^18 clock cycles before the reset */
> +#define ADS1298_TPOR_CLOCKS	BIT(18)
> +/* Start-up time of the internal reference */
> +#define ADS1298_REF_START_UP_MS	150
>   /*
>    * Read/write register commands require 4 clocks to decode, for speeds =
above
>    * 2x the clock rate, this would require extra time between the command=
 byte and
> @@ -106,6 +110,7 @@ struct ads1298_private {
>   	struct regulator *reg_avdd;
>   	struct regulator *reg_vref;
>   	struct clk *clk;
> +	unsigned long clk_rate;
>   	struct regmap *regmap;
>   	struct completion completion;
>   	struct iio_trigger *trig;
> @@ -180,6 +185,12 @@ static const struct iio_chan_spec ads1298_channels[]=
 =3D {
>   	ADS1298_CHAN(7),
>   };
>  =20
> +static unsigned int ads1298_clocks_to_usecs(struct ads1298_private *priv=
,
> +					    unsigned int clocks)
> +{
> +	return DIV_ROUND_UP(clocks * USEC_PER_SEC, priv->clk_rate);
> +}
> +
>   static int ads1298_write_cmd(struct ads1298_private *priv, u8 command)
>   {
>   	struct spi_transfer xfer =3D {
> @@ -188,7 +199,7 @@ static int ads1298_write_cmd(struct ads1298_private *=
priv, u8 command)
>   		.len =3D 1,
>   		.speed_hz =3D ADS1298_SPI_BUS_SPEED_SLOW,
>   		.delay =3D {
> -			.value =3D 2,
> +			.value =3D ads1298_clocks_to_usecs(priv, ADS1298_DECODE_CLOCKS),
>   			.unit =3D SPI_DELAY_UNIT_USECS,
>   		},
>   	};
> @@ -433,7 +444,7 @@ static int ads1298_reg_write(void *context, unsigned =
int reg, unsigned int val)
>   		.len =3D 3,
>   		.speed_hz =3D ADS1298_SPI_BUS_SPEED_SLOW,
>   		.delay =3D {
> -			.value =3D 2,
> +			.value =3D ads1298_clocks_to_usecs(priv, ADS1298_DECODE_CLOCKS),
>   			.unit =3D SPI_DELAY_UNIT_USECS,
>   		},
>   	};
> @@ -454,7 +465,7 @@ static int ads1298_reg_read(void *context, unsigned i=
nt reg, unsigned int *val)
>   		.len =3D 3,
>   		.speed_hz =3D ADS1298_SPI_BUS_SPEED_SLOW,
>   		.delay =3D {
> -			.value =3D 2,
> +			.value =3D ads1298_clocks_to_usecs(priv, ADS1298_DECODE_CLOCKS),
>   			.unit =3D SPI_DELAY_UNIT_USECS,
>   		},
>   	};
> @@ -730,7 +741,14 @@ static int ads1298_init(struct iio_dev *indio_dev)
>   		if (regulator_get_voltage(priv->reg_avdd) >=3D 4400000)
>   			val |=3D ADS1298_MASK_CONFIG3_VREF_4V;
>   	}
> -	return regmap_write(priv->regmap, ADS1298_REG_CONFIG3, val);
> +	ret =3D regmap_write(priv->regmap, ADS1298_REG_CONFIG3, val);
> +	if (ret)
> +		return ret;
> +
> +	if (!priv->reg_vref)
> +		msleep(ADS1298_REF_START_UP_MS);
> +
> +	return 0;
>   }
>  =20
>   static int ads1298_probe(struct spi_device *spi)
> @@ -739,6 +757,7 @@ static int ads1298_probe(struct spi_device *spi)
>   	struct iio_dev *indio_dev;
>   	struct device *dev =3D &spi->dev;
>   	struct gpio_desc *reset_gpio;
> +	unsigned long clk_rate;
>   	int ret;
>  =20
>   	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*priv));
> @@ -753,6 +772,19 @@ static int ads1298_probe(struct spi_device *spi)
>   		return dev_err_probe(dev, PTR_ERR(reset_gpio),
>   				     "Cannot get reset GPIO\n");
>  =20
> +	priv->reg_avdd =3D devm_regulator_get(dev, "avdd");
> +	if (IS_ERR(priv->reg_avdd))
> +		return dev_err_probe(dev, PTR_ERR(priv->reg_avdd),
> +				     "Failed to get avdd regulator\n");
> +
> +	ret =3D regulator_enable(priv->reg_avdd);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable avdd regulator\n");
> +
> +	ret =3D devm_add_action_or_reset(dev, ads1298_reg_disable, priv->reg_av=
dd);
> +	if (ret)
> +		return ret;
> +
>   	/* VREF can be supplied externally, otherwise use internal reference *=
/
>   	priv->reg_vref =3D devm_regulator_get_optional(dev, "vref");
>   	if (IS_ERR(priv->reg_vref)) {
> @@ -771,22 +803,15 @@ static int ads1298_probe(struct spi_device *spi)
>   			return ret;
>   	}
>  =20
> -	priv->clk =3D devm_clk_get_optional_enabled(dev, "clk");
> +	/* The clock follows the supplies */
> +	priv->clk =3D devm_clk_get_optional_enabled(dev, NULL);
>   	if (IS_ERR(priv->clk))
>   		return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get clk\n");
>  =20
> -	priv->reg_avdd =3D devm_regulator_get(dev, "avdd");
> -	if (IS_ERR(priv->reg_avdd))
> -		return dev_err_probe(dev, PTR_ERR(priv->reg_avdd),
> -				     "Failed to get avdd regulator\n");
> -
> -	ret =3D regulator_enable(priv->reg_avdd);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "Failed to enable avdd regulator\n");
> -
> -	ret =3D devm_add_action_or_reset(dev, ads1298_reg_disable, priv->reg_av=
dd);
> -	if (ret)
> -		return ret;
> +	clk_rate =3D priv->clk ? clk_get_rate(priv->clk) : 0;
> +	if (!clk_rate)
> +		clk_rate =3D ADS1298_CLK_RATE_HZ;
> +	priv->clk_rate =3D clk_rate;
>  =20
>   	priv->spi =3D spi;
>   	init_completion(&priv->completion);
> @@ -800,12 +825,15 @@ static int ads1298_probe(struct spi_device *spi)
>   	indio_dev->channels =3D ads1298_channels;
>   	indio_dev->info =3D &ads1298_info;
>  =20
> +	/* Power-on reset time, counted from when the clock is valid */
> +	msleep(DIV_ROUND_UP(ADS1298_TPOR_CLOCKS * MILLI, clk_rate));
> +
>   	if (reset_gpio) {
>   		/*
>   		 * Deassert reset now that clock and power are active.
>   		 * Minimum reset pulsewidth is 2 clock cycles.
>   		 */
> -		fsleep(ADS1298_CLOCKS_TO_USECS(2));
> +		fsleep(ads1298_clocks_to_usecs(priv, 2));
>   		gpiod_set_value_cansleep(reset_gpio, 0);
>   	} else {
>   		ret =3D ads1298_write_cmd(priv, ADS1298_CMD_RESET);
> @@ -813,7 +841,7 @@ static int ads1298_probe(struct spi_device *spi)
>   			return dev_err_probe(dev, ret, "RESET failed\n");
>   	}
>   	/* Wait 18 clock cycles for reset command to complete */
> -	fsleep(ADS1298_CLOCKS_TO_USECS(18));
> +	fsleep(ads1298_clocks_to_usecs(priv, 18));
>  =20
>   	ret =3D ads1298_init(indio_dev);
>   	if (ret)
> @@ -824,7 +852,8 @@ static int ads1298_probe(struct spi_device *spi)
>   	priv->rdata_xfer.rx_buf =3D priv->rx_buffer;
>   	priv->rdata_xfer.len =3D ADS1298_SPI_RDATA_BUFFER_SIZE(indio_dev->num_=
channels);
>   	/* Must keep CS low for 4 clocks */
> -	priv->rdata_xfer.delay.value =3D 2;
> +	priv->rdata_xfer.delay.value =3D ads1298_clocks_to_usecs(priv,
> +							       ADS1298_DECODE_CLOCKS);
>   	priv->rdata_xfer.delay.unit =3D SPI_DELAY_UNIT_USECS;
>   	spi_message_init_with_transfers(&priv->rdata_msg, &priv->rdata_xfer, 1=
);
>   	priv->rdata_msg.complete =3D &ads1298_rdata_complete;


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



