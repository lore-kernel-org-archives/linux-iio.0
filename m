Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795601997;
	b=ANrP7t+TkUE73gVsq1+dSpOK8YKNT6CqTddmr7k7F9c5qcbRkdiSVfr8tMUhqta9xQCi
	 iPI0oge3W3HJ7kYGduYmTiUGbUntbQcOcMJwsS7NcPtpPXpaJzoprjKr6zWVkvXQB21j0
	 PUI0NM9eYAEwhapO/2NfRVzjyYeEh4mtr8ln12HTpRvI5so89QvvamM/D9M3311VGHubm
	 g8OGVrQzvyeouccAf5C5nEXA0BmQ0tWxaT+wuUC20v0Ma/vHJnwJFH0XMKJ3fMSwViVPU
	 10PvBA/JlO0HZudn1Oc4+Ar05+9II2kANCWDGKkn2ZLDXBFvIbbyZvR4rnNBIs6kk+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601997;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:Date:Subject:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sM8ZILDpuK61Lq/y9B77un5RH0aX1Ikr8F6Dit3i8OM=;
	b=xcULt9JM/jFUOy4jbG+Tis8tlNZvhZz1j1XsLN+V/xUbvh2eApX+kP/IFbLvPo/D78Kr
	 G99eNgWCuFfg6P49Ssbp9X/4xielL43iAaVpHAkNrSezfxgTUppqI9LKJrgU/2hjQDesz
	 YHmkHhyKpSf4fqb1eMKek8mB/D4KmaTX/g5KJkw9AXqVvhrmzVDqZ1P4zYlk68SXq7xoq
	 l+o0fqi/qzCBwAmXCQIl/yc/1L5efkJz5umRZ4lqIKKyAsN6cOqilwbEP4jgsaYvZWVH9
	 RtIlXTXdg8V4sU8Nahc1PI1ff8CLhg4G+UoEh7Gjax/AuZjUUQTt7UDhxKAtX+snkwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OHMWU+J1;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=o54EnGtI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76181606A337;
	Wed, 25 Nov 2026 10:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76181606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OHMWU+J1;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=o54EnGtI
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9nn881789396;
	Wed, 25 Nov 2026 05:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=sM8ZILDpuK61Lq/y9B77un5RH0aX1Ikr8F6Dit3i8OM=; b=OHMWU+J
	1irvYN7WHdeJh/xwK645WpIMGqpQImXxHse8Wd0kgob2Jms2UkVYjeh85/6nJKEO
	O4Vzu41fAF1lw3APa/UhjmXuZvyXh05aC/CwkATRPKIX2USoehJM2Hnl1kVd6pp0
	ZSa2Fd8uU6zskU40MEO4oeMwKtC4JpMiPcWrOYZDQDv07Px8lKs1/e/VPVjopkok
	mHuKujIB4MDI7yyej42f9/0fW95LG0uAWmeWkYG9tQmOnVUhO2dH5VM6AFLySA64
	gZJCJaQ8hYsm7uLRMzHdSpbMe9uYKO9zmXIW2ZyCctHa66MYW6hKBs2KLr41jsjp
	z5MhN587eRGoqxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sM8ZI
	LDpuK61Lq/y9B77un5RH0aX1Ikr8F6Dit3i8OM=; b=o54EnGtImDMrUdTGySklZ
	EoUODHOW/X0uWedMgaiaKSmFwRdRq9PBu3i62KbXmxxTXJyWLYFCxDqIYhmqYECq
	18nmqz159z+hzuUosJ3PoegmeruBWaO7p4UeYJnVK/qIZ8NI+u+BixMFVsq1cplH
	IjFRroOJqaHMp3+kEUMzss//ZOas/QU4FAY7+1glw7jlQPiZ+bhIewiHmWow1Q8e
	WFa6N6dtUtG4w796Xfm2BgO5iQAqJj9qqv9oZ949OueLZGO1HN/sOrKO4FF1LSzI
	bhluSFNTBOQi14WiIfy4NAN4omHUxmqyrhzjtT0VZssC62mcZW0CXQpFGpeS3yCM
	Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j5db6dfgf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 05:19:41 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXsnGI/5XJKTDd1fYH6k3qjnn1ll8oo+tnBjFlhgMhH1PLs31tMtzuhGnglYnicCGJk/JOEfygk/pSGU1TCnQeC/HhBumwBSOJB0ja1w8cdwcxmdYwV1ni9U1FGsCW2bhENsuaxiuPSkz00iSGa3Rwr4bvLU9VAStVPnvS/7QLqMK9QYXPR5ZJ8/uqbziIEvtn5K9hMLRj13umsyvA6Kbp7KO0GW7UTsHUNnIfPnXsiJ9t/dbR1R+P/B7CX034xO0NSRqvl8rJ1S2FvkDMY9/dDYvOZDoTuxLQRJi5PMG80gHWs93P2NaX/6M+cEA8Kx6H2HBOWGVQeLNWwLHSpnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sM8ZILDpuK61Lq/y9B77un5RH0aX1Ikr8F6Dit3i8OM=;
 b=Q2/Bj1Zt+gzmEQP84tUY+6kK8txu6bUpg8eQMJpCKUmBhM2XwKjmMAcdDdG8NhxXaqbrq3WPaTzASpRbkjqIXCz9RYHKJexlJMzd8gl/OeRMxiQ8GglzPxJ5Nm4gjEnnCFDhMJA2H94zXaSvj7zpzmxs0x7cNhPGy7bwqBlUbeX8BLXuUCoCtxYnLvncvDvqBUyjW4t5kOziDqnAiPz0jP2Hugk9aEoTlrJ+s7uRzwUyH7YkjBJXcGWjWltANuna8mgcXSHyniRZzx5IvV1yI+l2rFAl3vvbNQ4aJCuf3fgi7AbaQKX+cQ9o+4T/y2vJ5XYfKWm6DPuj8NobxFyO7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MN6PR03MB7573.namprd03.prod.outlook.com (2603:10b6:208:4fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 10:19:27 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 10:19:27 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 25 Nov 2026 10:19:17 +0000
Subject: [PATCH 1/6] iio: adc: ad7887: fix on-chip reference enable logic
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-iio-adi-legacy-platdata-v1-1-54e4c8830b57@analog.com>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
In-Reply-To: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: linux@analog.com, Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795601958; l=1285;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=tCoZnevx7SLoIreCBFYxPdQRHPHfozevvERHKt6O2Gw=;
 b=pka1jFe4TIQ0YPkVezZPbbCjZs/qscqhVMSIyGSfMztNhDATOZKRfP+qcPdnkwJwo2VFqWD5H
 dXtlstqRRoFCBdvVp4EJF7mADKD4r4XD2nlpimOiE0hgcLqkMPh2kyF
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0026.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:47::11) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MN6PR03MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 40787ef6-2378-4343-adec-08df4add95da
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|261022075727099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 SL40uGL3S0e34CZM8pee2lBzESKIvBCjvzjVlor0SAzopYIaCZggPKy36HEjkC+E+pXoto9IGMQmLT7i87rlnaDoKcc/T/Gcj9X8LWSEhVPIHoKLIxHC2rnO+feLPXh58pBmYAVUIL86mrAOl6dbbovXfhVzT2khudFk/3c1t0TfWa9nEL0lNyq7P3JUSeJ35xD6aQUqitgGc6BkVp0slYYL7f6em7Pe1PzieEHf4meUsGNOPYSwP04WiSNS5zMAUZoy+x8kv6PZAR9lH0B7nb/g3Ge1buRoEyf63mPdh2jhxZb09kgS02kGama4mErHECkDDFu8v4RQ+WnW70h8CLgC70XZdIzr21Z3NICGKy2E+WwcUNVpxx4YV/CjQ4o7bKWrx86qyRK33nmQ+Qenag4TsFddidnYlfQTLXfPXJLQDsYSYwRCHWkGXB8D0G0cAWpBf45l8hUttPrgNZfGNMdx0qeeoYgsMRUHzIsX2Lrig9qB3JpzjYZo+TyBgp1C3PiGPKPc/U1krQo5fJzMoBKswg3Et+JE4QXNFrji7STakMO8lsLDaCo3DD6nmze/RIXO7BwDqif+chdPiC0Sy+UAULY2aCFez5OJOGnY89jglMAOK8JyrRof7ZapT0KDq+MbWsl+PIEAxZs6NnnNL2xfAez5KDLYWnzaS3CnRgQ=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(261022075727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?U0VrdlpxY1F2VmtvYmZSVngxWktnZlBHdUhKWXpaOVVkSHcxcjd2UTBEaVdu?=
 =?utf-8?B?Wk1aTW5Ia2ptbkNhSG1CUElTb3Z2Y3JrR3huUGRkeFJaUmFoTjFVYU45YTRZ?=
 =?utf-8?B?U1pLbGJ3S1BCRkxPYWZZUVhSblQyQTY3NXpGT29aQjVmZ1VKN1lBZmR0Q0xs?=
 =?utf-8?B?MUR3T1hhNkg0c2ZFaWtFUmxzUGdFNml6cVFpY2I3NUZhbzh2U0RQQTR0VjZN?=
 =?utf-8?B?eWNDaVBRZHpueEpaU0s4NWJ2VUEwVmNKdFA0Um9Da3RweGI3TEU1eE5nT1lG?=
 =?utf-8?B?Rk9NdS8rU095U1dsQUxwemwzQjd2YnJ4WUlxcVFCdXpDdkFaUTF4Q3g4Y0pt?=
 =?utf-8?B?NXBYaE40UjR0SGpsNkFuRjJxQXgvSXE3anMreGlkQlFSYW9xbTk5OXpNWDhk?=
 =?utf-8?B?WGF2TW9CTS9jekRNUG9xOU9tc1lEK3hIcjEraUJGeS9Vc1lxejFkQlJqbERh?=
 =?utf-8?B?bEw4U0E1WnFNSjcvTC9LazNwY1dvVDhWU0dTa0kvWjJOUHpNeGwwZXpyVmQw?=
 =?utf-8?B?dlZPeUxFWVVoUG8ybjV1aklmc2VITlBSZVVsamRLMkJ0OE9QVzE1YnNXSEdD?=
 =?utf-8?B?RzFYa0pIYjFVWG0wMkFJQVpxRDdVandNa0N6bDhTU3BKanJYOUl5M0dXNHFW?=
 =?utf-8?B?eXlDVmhuUDQza0ZDVWJoZGZKT1BNYlJUaEhJa3NhR2hJQm01V1R1akI2SUU0?=
 =?utf-8?B?ZzE3R2lIZWRaaUorcnQ4cEU1UVYzQisxK0t0clRNWnJhaXM1ejBBT05nckFO?=
 =?utf-8?B?N3lPL0hOaFBOb2NJckQyTjNVZjJTbUUxV0pKV05TZFJFcXROaTRPV0N2TU5V?=
 =?utf-8?B?NUhCdGY0Wm1qZUxGZjhtSC9ZZzVuZVJqcTVjR0h2cmJjZTl0dG5KK2pDYmhI?=
 =?utf-8?B?SEpWUERCVTdqbUlERzhZKzlsd2NrOTdGaWplaFkrQzV2Tk1nenZDMVMwejJL?=
 =?utf-8?B?RHc5cW55cEh4MzNVWis4QUFMY1lOU2tJZkJMMVdNSURldnhkSlVibk1oQjh1?=
 =?utf-8?B?cVFSYy9CRU1sdWVpclR0eU1IVnAvMUFwalVPcWV0VWV1V3NKNmNRYUU2Vjhl?=
 =?utf-8?B?aEhPYXZRRWdpaVBlT0NraDlaV2xVVE11SzVvbTF3YXhTRHdXdUczbzM4WnFH?=
 =?utf-8?B?MWlGOG5yb1BFQVY5N3RhUkZLQTd4akFzb3lWMnNzVGczNnVaSlZnMTFaV0t2?=
 =?utf-8?B?U2dHOVhUTzV3S2s1bllSR0doUDBBUTV3TjRwQlNXYWcwMTFRWU95dXJoZEdn?=
 =?utf-8?B?TXFrV281U1R6aTNxSTBreFF6R2pCcFVMeFB4djlzNzcrdkZ5S3VmU01WdGlV?=
 =?utf-8?B?REtqNUFTdmtJRmpJV3NSaE8wY2VGYUhWdkw5SVF0ZWpCS2VPVFJ5K1dvZzhW?=
 =?utf-8?B?bGZNWE93MncyYmpjcnhtamg1UU5zMVRpWnZIRGc5U3dkWnhMdzlEK1RzWUdw?=
 =?utf-8?B?STB1emxsTkJ2RGRvVkZMRVRCSko3amJ3eXN0bU5uK1RqcDRSclRseGNVaVpJ?=
 =?utf-8?B?UWZPK3N3amRwV0xDaWZFWFpyd2NsRXBCMGl1UFpGeFFESVgvUU9jZm9Pckhj?=
 =?utf-8?B?L2NOQ241NndKUS9CdzFlTWt0OU5PdUZzVnpJNm14ZWN6ZjZ2Y3RzaEFmWlVi?=
 =?utf-8?B?bTdMYU5tSmY5bHhFTmF1RXo3QVh4emVqeUNMVTNhMnFNTUJZcG8zQy8vOVlN?=
 =?utf-8?B?VUNla21PZjgwbkZJMmdCRkx1MXdDS1NPWDBYZitBMnc2M3dXRGx0KysrRzl3?=
 =?utf-8?B?cDN1YUpVUG4xR0FRZkZHUlI3MHpRYkhJY1hTdGNkZmdwQk9YWnhqbDdSeWc0?=
 =?utf-8?B?R2V6endnRnladVpkSG5Qd0t4ZmxtMm9Qc29ZRVVmM1NndlNXcVRtbUF6TEZo?=
 =?utf-8?B?UFhzMEtRbmplYVl6clI1dG9hUzBYck5vOThyL2VYeDExT0oxZEpWalMzR0Ro?=
 =?utf-8?B?eXU3OGEzY0Q0bXFVbVU1T3p6YUk3R0NNdExsUExsSS9IWjlwU1JZaWljOWxa?=
 =?utf-8?B?NE1pRUNmaHg5MlNyUzdGUG5RTE5IRys0YTJ1Y2FlZnhUeEo4SmxwQWZIbkJB?=
 =?utf-8?B?VlZNS1p3azBmVlZtTUx5bzdLYzNlK3JKN1B5Q24yODVNQVBFZkxNSnpzTytI?=
 =?utf-8?B?b1R0Y3R1MS93TENIR2w5dDJCUm02RWwwbDBNSHhVY0s5RlJNSTA1azR0L1Iv?=
 =?utf-8?B?Vk5MemFtQUI2V0JlOEk0dllTR2FCS0x1Sy81RWpYTlloaHQ2NDJOSmY1eHkz?=
 =?utf-8?B?b2NHbm03MWhyMnVpNUpVY2MrTFliSStMaWtWVnorZncvcFI4NDJiaGpRbUE5?=
 =?utf-8?B?ZFhEUXpibEUwa1FnaU04Y3d2Tkd2Y2M5RHNTMU9NaFhWUkZOWVdpQT09?=
X-Exchange-RoutingPolicyChecked:
	g6xlIXCoGp8Q7DxHUMg027MYrkJXL2CS8Tnp7/5B6O07f7bp+0SCYm2BgFg5J2rFyQwA64LjWwWghs1QykkZWIidsNiXGx9v+4DFp/jlRO22EW9R9GKqx3d3a0WJAL/A+HKYehnKCZ0VbfI4US5qwsxIOTRq8bUQU9bIbNHrybP1iYKFjbzBNQxF6DGP5dVsQRYCQeBkFdOZQZ08y4/ZI/N0sLcpsp4oY7nBa+s72wtcNtOvM6yc5KF+qMef+WEix7JBAKy5ZcisYWdi4T68bgYQe4IuC6ojNJ0TknoRjVQ7bvOGKXu++4BCJh8YcPYBkpM0kqseBvF/DqfCtngx4Q==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40787ef6-2378-4343-adec-08df4add95da
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 10:19:27.3544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fln1l7f3ovnTpK4MVZ25mpItylYTGgqLlBhVdeeSRmtNnoIYkQPSjLvEKOj3LAOjzNVWoJ7ohvjsSH6j/McxZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7573
X-Proofpoint-GUID: srollcyf9lyrOyC69QjjWqThPFCGSDLp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX76RoJqpmVTRA
 sc9P8THyZEssnc+nrnA4P38VZPx/NrH1YHqiZAgG/fquZpvfHuk0bEyI9q1PaV+10G6FsvCeEG7
 IhxDEVhM+TVTxtFTerPFA5sQrj1jjcnpmykO6s0KhFvhKCvul66EtYiUFroo74zz7Yytw0wngd8
 pvoSlAjhR+NzkNCNZUY1Fe/HmNGob3Q2jtvwCMh3ArE/KLeHwr9qW2iPF6aeLdUtsOtkPlKprQw
 1mfMzCcKC0CzZiZNcWFF7bGTYTULQAnB74JaOZ69Aazcn+sfXTz5A6a6EvI3XwnoqpLPfU3+GHv
 1kKS/NpEWLZ+XESVD+qofXMJGOjstyMWNY1GSTm/TVDhSIb45Axb5x47/2XqWxKCthF+ntcD1fC
 acox89k9vZPTNZRS3VzJPn3LYz/ERx+spszHngqsIWVG8+6w8RU/M36aU9IE0ITXgCyhtwGYBY4
 ijcaWCjItIn8kWlAwNQ==
X-Proofpoint-ORIG-GUID: srollcyf9lyrOyC69QjjWqThPFCGSDLp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX5G6dNa67w9vF
 rz6EApQ+vZyVaTXvptlr14E+ntlb6yNTvKSLQLHQoqwDO/q3Pn3TVorHO8mGHMQSYOFGBB9vvn4
 uSZIdtU5AMAzEfvksZb1VviL3usvIs3THe/d2bwoj7aTJLqbv9SE
X-Authority-Analysis: v=2.4 cv=H99OUOYi c=1 sm=1 tr=0 ts=6b06b63d cx=c_pps
 a=6KPqUB2zuHFFswelnWAHBw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gAnH3GRIAAAA:8 a=SwZPq4ZGpETAgr4qFxkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250040

The REF bit in the control register disables the on-chip 2.5 V
reference when set. Before commit 5483b8d5015b ("iio: adc: ad7887:
invert/rework external ref logic"), the driver set it when an external
reference was used. That commit replaced the use_onchip_ref platform
data flag with the presence of the vref regulator, but kept the
condition as is. As a result, the bit is now set when there is no
external reference, so the on-chip reference gets disabled exactly
when the driver relies on it, and is left enabled when an external
reference is supplied.

Only disable the on-chip reference when a vref regulator is present.

Fixes: 5483b8d5015b ("iio: adc: ad7887: invert/rework external ref logic")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/ad7887.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 827d0c2598ba..980e6a303047 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -271,7 +271,7 @@ static int ad7887_probe(struct spi_device *spi)
 	/* Setup default message */
 
 	mode = AD7887_PM_MODE4;
-	if (!st->reg)
+	if (st->reg)
 		mode |= AD7887_REF_DIS;
 	if (pdata && pdata->en_dual)
 		mode |= AD7887_DUAL;

-- 
2.56.0

