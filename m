Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC4E48097C;
	Thu,  6 Aug 2026 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031943; cv=fail; b=ogRgGcsq5cCJ1W+soT0Os+bXtXst0YayE4FPhlmkJd6vx5TYcYgw++G6Gv6LmUiqlE5tyAzRKZJce1eAVYQRl8cbJhzkngnIg0bqNvK4IAVr/gSNrdrpin+uNICl31LNsuFcfu2q2TIhpGj2SfJRjOJK31eDZmeikIUVkkS+sYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031943; c=relaxed/simple;
	bh=52Kkw72+nIrR5+F1gCawflh092r3evNWJkowqtfh+RU=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=a4cjVicjz7TFBZmokyry2l7i8f+RQRs+/lXK0Ewz7q7vtyt2hfEXmlVGM13j2Zk8sTTR0YsF1MD7PWuYXOuzsJAxthbzF7Td53zViDKRCCePS+gXZ4zsb/Lg30DO/NY5xDAR0xTsRnQCUV+UdJP0qNCiS2NbLrlQT9XlVlb3KCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AaicL+44; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AaicL+44"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EpovA3853946;
	Thu, 6 Aug 2026 11:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=goo4o
	teVUZ5fSvZEOhcjMlK4ku1FPq7HSXo6V1jb+IQ=; b=AaicL+44AIAovYHxakNFn
	WBppp+hoxA8qavA88fcu3TDPSKpaj6BkFKpWCDtkEuiZjJ+u7ArEBH0/9a3jv8Gj
	8b0mNl2fBXtNawF3AozdK7YXwlzCmArFHiyWUYGt8ms55gT9ffzBTb1NbNofmLFV
	WD8Pu0UCDMtTS/TSj7QNs2zm8/RgYkGIt2HPkPJA091Ohz+VdIj8P0tZHG7KNwOF
	ii69WmqZSCRasmLsMm0wmXaMJ0cIXXiehbyetbVIRrUI8pIpuWDZpfqBWYUki+hD
	LPlpeGt8abqLnhSVGcZ3APo1ttec/OhQGNa7BFCxkUCzqOtX+MgKsmHYZNMzJBVX
	g==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fvrcpshtg-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 11:58:52 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuM92BkhV+7AWb88bEJcKXrsF22JexUNV3mPAaR6NVd++ZZmG2Iet+g9g+tZJ7/nmsUTNnZpFQ34CRnBHXh7Oalaod5NY0sugUKCTxJdnuR1+IdLAjzWP/0NY6kbzE/CN0MjoHL5fMOoxnjXpBjCSR67nLQbXD/haDx8qHLzrsEixNMzuAFCeU+25DdB7RjORR7mE2AjxA9+FW/evE2HN23Ycga3bJjefhw85pDU+3jjKNoqvuOWMBysDRqi2lndKGCAV1Ex/bCIn3sY25QR1YPuFXxjCOnSJQhqCsOSw9NSXLcZb4qtycikWC++0lfuAfJCOy2WGIslbHuW6IPJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goo4oteVUZ5fSvZEOhcjMlK4ku1FPq7HSXo6V1jb+IQ=;
 b=RrxLOLuJXEMtw6fdfJ1qYiye3WxtvYPLc85DNrgeXkmAHYlbYD5cmDE3EEGVWLrPmEc8p4KlAPFhdXT9TeslDuK95jGpCMVgVzqlCUR1NRqBkHiw2RVkhwpUvJm2/meLmNVRYpTieoUYVuM+CHq27XbESdShMYlhhhhRBtdt07nEy7JZ5oQ+CVfuz3ZtDvX8bU7DxGquu5dFnWm7JiwpW6NapxKarag1VkgLRelzvpVzWx7QOkfnS9cV7Q5FwRBET+uHEhDC4M+EaI7J9iuu9RR03OHXOH5alt9ch8yli0bnalcgUGHCPyuh7FcVsRgTkXM7t6zoDvZl14z5g6KsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MW4PR03MB6346.namprd03.prod.outlook.com (2603:10b6:303:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 15:58:48 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 15:58:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] iio: accel: adxl367: add INT2 interrupt pin
 support
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>, linux@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260805115952.33894-1-antoniu.miclaus@analog.com>
References: <20260805115952.33894-1-antoniu.miclaus@analog.com>
Date: Thu, 06 Aug 2026 16:59:55 +0100
Message-Id: <178603199578.1212536.3347369462721950589.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786031998; l=567;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=52Kkw72+nIrR5+F1gCawflh092r3evNWJkowqtfh+RU=;
 b=0NbI8h5nkMKlfhbMddNNJ1KqCjciQAUoR7sYZiDQU+wz2yBQz4vBBp+0bs9i9AyKeehcPdABG
 puqnP68egWzDXHphb6O4QHLnFBqL+CtW7zY/V4ZEAV0Ykg5SXf98wtF
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA2P292CA0015.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::12) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MW4PR03MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 03396545-cad1-4886-f22c-08def3d39a16
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 VxvH/O5oZpyn7MmJnzBwuWc7Uy49zPmHO/jtok0r4oGb2THumvDR2EdaOYNjLNkGlYNfUX291EcyqCyF8MbwmkJkvQp0FS9llpZuCUQSK+9kGavJ+qSOIqa0cEUwWSkey+Cp9gFb+i7rcdx4/E32KWEEV/K90andzm2dWdluurpVes5rQZ95NdPieMRgoOtFfzp3aHwxGzPoOSg2v23t28opitRWXKDXqVUP3AJR6aEKxBI9dJcM7jEw8Fiyw9axhdc1XhdixXwFk8B11/ZH1ARC46DAnKE4XmfqZJQoJNfvJ2u6VKqUaGYrqGRsA84nUqmYlf28g8ZX+rg7ziILt3uhcHzX4r58NrzWmmUMJBKtN+4GwDZNmT5BJM40o38SOlcouuce9JSgcrgWzyLwwES/kFfz4KdU785bCcf20yhHTqAyXmkc3L74vA5NLaF9tduFqDIf7nLPFUkfjTD1pjKo3Lq9UE8AdDtNTmTKv5Yy7Vk5Mt84IQv0hy+I3b1OIqUECXwm7xgF6pgYMMImZ2k7CBBynT02akTvtOReozAHlYVAWsV7MmyyQ51WUXaDaIBlyocU5BnLohHacm6QJkeJoQV4oFK7mY1JGyVdpAmIL2LC0+z73qcA4OGMObOdBdSib5Fr9tw0fj0EJrqIf7YPQp2De3zfrS2YXRbyK/g=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UmlSZFNvUHl5UEV3c2k3VnQ5cHlVdUg2OGZRTlZRalJWSUcyWEkwT3RkZHdO?=
 =?utf-8?B?REg0NURFbTZDb3dxVUk0c0pQOEczSmU5cHhKNmE5QURaRWtOTEM1NWhDNEpu?=
 =?utf-8?B?WTQ0ckRBV1Vpa0NlYlBmM3NBUC9uaTJKMlh6Qm5Na0x4MEtKNWg2QlU5WjZY?=
 =?utf-8?B?Y0JIQnhVTHJSU0Voam9vemN0UjZjQUlEakdPSDE1T1FGNTh1NmxaZktGV2c0?=
 =?utf-8?B?RTNiaXJacFlobG8wYTlNQnhWQkRBcFlPWGFPbmVtdFQvY1FaNTBHTkx4elRO?=
 =?utf-8?B?eDJDc0VkQVBnVHVOQ3RobytVTmJERElxVytEakE2MW9jQi9NRjBGdU1qRm5O?=
 =?utf-8?B?cVZZMzJ5UEMyMW84V0huZzJvWjl2U2plRE1qZ0wxb25tSVk0Nkl1aTdVQXhQ?=
 =?utf-8?B?UEJJQzlJa2xSN1ZSL3BwaElGNHN2YlNSc2RaVFFIT0FJVWtCd1d6N0JFN29h?=
 =?utf-8?B?REFVbEtNWWp6cldjU2wzd2tPckhSYWc2Z3Q1ZUlhSHY3QzIxM2xLREE3VU5p?=
 =?utf-8?B?UlhXL3FkdUZKVTlwaHh6T3B6Y3lGT1VHanJhTFlHQmtJOFFFMDlkTnE1T2E4?=
 =?utf-8?B?T0NVVWl2UUhZdWx1cTRPN0FTSHhEY3dVR25waDkybkFCNEFkSStBQ1M5NUNZ?=
 =?utf-8?B?VzZsYk15WGZNczFERGRUQzJ2MHNaRnRla0psZUx2dEdMRU5JSUMvSS81VjlZ?=
 =?utf-8?B?c25pSUpkYW5nanp6ZEl1bWpZRXBvVUx0TkpEbEVmTjAySzBld2NuaVMrbDZW?=
 =?utf-8?B?cEtCNXpteGtyRFRnTDlNendqcVlYWFlTbThYNUQwTTFDN2QyaENtMXMzVkJ0?=
 =?utf-8?B?ZEU3eTlLUXQ3VXdVVTB6OWE4TkVTcko0U09MMHMzdG5YV1lyZ0swR3RIY0V3?=
 =?utf-8?B?MjdCUmxBRnhQSWZIRW5jYk1SeXZiSWMrOGNSQ2pGSk1DRFJOZWZ1MVVNUXl4?=
 =?utf-8?B?Rk4rSVc0Tm9DcVBqQjVwSXc5cjZ6UWlvMXZHK0Q0VEZYa1V1QWg3cHphdnM0?=
 =?utf-8?B?c3ZUT1ptZXZCcVZ4bE5oM3g3S0Q2V3FGcklINER4eXVMUHgwUEhhYlJFSjB1?=
 =?utf-8?B?ejFmQktZcW9zMnJndnMySXgyWmREdDlZZEdZQ2QrNVptUXBEWlZ5Y0NkSWdT?=
 =?utf-8?B?TXF2dlZpL0diYVRYWDN6c2xVZVd6THQvT2tiTXhiT29Ca2JGcjEweU41bFIw?=
 =?utf-8?B?S2NaRjgrZHpYN0FVdWNQcm5KS0dkMzhSQU5SalptdDdHQmkzOEIrUy9Xejhx?=
 =?utf-8?B?RzlGbFBNT1dWWmdnT1V1NFY4U2NxL1pJcGE2eXRGUXM3TGQ1R3NCanFsR0JK?=
 =?utf-8?B?ZUx6YXlRMEtnRWJQYXZNY05yMTQ0YnFxYjJkRTcxODlvOUUzMWkycDhTVXRz?=
 =?utf-8?B?MU5LN01Tc2hRLy8xd2JlSTNJcndqTzJjbWJ5YmNoRmRHblF4L0I4VFBETHVE?=
 =?utf-8?B?MG94NHhRNFZPbThVZk9IZTdiTmM4OTRXWkNGS3NCVjZmSkRna1JYcXdneWIy?=
 =?utf-8?B?OUM2VGRkQmVjNE9lUG5tL2tDMExjNXV0LzVHcmZvNXlJUGUrMjQ0TzF0RFBB?=
 =?utf-8?B?c25xSFlaOUN3dGRLMlNlRVZWRnNIUkhOUDc1dzBhWkZKWVdTd09DaG1XZVFn?=
 =?utf-8?B?bzF1SDVmeTAvdGY3QUJzbmFsMCtvdlNjQ0ZCb2ZMUitibFd4MTZqaVE0STQ5?=
 =?utf-8?B?UlZ0UzZlSTZaWXV5Y1F6S0hxSzUxaytoZHVJblp3cm9KclFYdk4zUDEyeU1u?=
 =?utf-8?B?MVV2V1p4eTVmWXhTNlVBbzhzaTY1N3lmTjVGbExvRTdIRy84ckg0YVFKNTBk?=
 =?utf-8?B?NVZpUzhhYzZoM2VmNjY1d0lSL3VoTEZBVThuczFWUndyYVNjV1pPRE9QbVVP?=
 =?utf-8?B?cm5KSXJFWnFlRmlHWVp4TWZvN0ZZR1JWcndmWVgrR09hbEtsMDAxZytRVlF4?=
 =?utf-8?B?SEo3NS9uSnJBTmRFempiVXRBVytDeTRhS3NtWFR2Y2dCN2ZocU12anFKL255?=
 =?utf-8?B?bTJYdHB0OTYySEZ4b2M4VWtOQTVmbldidDd5S0Z5eUR4YjNLeFgzMFhBQVJK?=
 =?utf-8?B?a2tibkZFVEpQWHVqbTk2cU9INktQdFc0VWFWbERYbm1qY0N4MVBEK09TZXRo?=
 =?utf-8?B?RjFXTVdmQ3gyOUd0T00vZmxmSmxvRG13Mk9lMy9TT1JiSG9TaEM3c2QxVmRK?=
 =?utf-8?B?c3hxeHpJNDNHdWRZRFJCYmdzU0hXU3QrWUR6dG9rQmZndk5UOWtDY3F0VzlV?=
 =?utf-8?B?UVhYdkNDSHR1MXBPbDZyYTRnK24xdHdHbmZyRVN4TlRpdzAwZEp2enp4MDQ4?=
 =?utf-8?B?RVRUeEp1aEdUbmVCbjlyWkUzU1dJQkNxSmJBdW0xN2RBMnk2R3M2QT09?=
X-Exchange-RoutingPolicyChecked:
	nbvZeslgA+kMPhpm/u6SO0PX1h/24iycq1ABbBgbfWHdW7gwDRoOR4m+8d70/06PE+WPeKUdVcdwFSFfH7OF1I7c1pEZae2MfdjYyI8u2R7ALBNDJ5vi2Kw457b12zekxeh5hB3zOVFX6FckN79ihe8co511XXnCgfOb0rSCbD0Lxer5YZoFkiyS1fpU/JKVZ6v6Dg/l2y2xj+APqPhF2peaV1AWBvN9x7BSXSoqqd0JxUtbPTYRIU1xaGwlCGqWJqidAZj/D7WBgdDKof0CxrtgZWBXa14bm2+Hl7AdtRojkiVUrsj5WCtKkw4Dqlu8S9yHxWXVcgQ0+iC8+8kFzQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03396545-cad1-4886-f22c-08def3d39a16
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 15:58:48.3487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nml44WXo54neBs0aATJurTXlI8CDPxRi1JZa7Omb8uWvzpxjWcvItRROhFlxCwTZ++hRt9JfzUIjov5vXrCTpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6346
X-Proofpoint-GUID: bP4BYLuwQY0LI3J5NqgtWeLjiJ-3ih_a
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyNCBTYWx0ZWRfX5Zj3GxGRKyv6
 +TIg2zFB0TEKa8Di0bLii+rKIV3P++BRqYFszt4aIwVibzWzaa0rxEqibuyx267aAVCUOYFyDjM
 KtPSQzo0l+nWTeM5ufdNc/yj8rBWqnxBblBgs7tPLImVjKdulGaH
X-Proofpoint-ORIG-GUID: bP4BYLuwQY0LI3J5NqgtWeLjiJ-3ih_a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyNCBTYWx0ZWRfX4LVT/LoSkBdu
 GLr1+Va/6GXyg3o3yevKmWjmbKSlml8uAgMrYDCbtkbLzIk39lXvpP+5EH6XoLFL5/W7qSiYwjT
 OHA/ZBfPtw+munkVC/aOL1c1cw9ohab93gMdkxcK0YY+P2zZgPtDlaM4LbsAElPdl9mBRPmLKQx
 ke380gffcQkhT+KnnyiOVjPlU/6lKa9SWNtZCEyBn21tcQiEPEiXYyu/xKFZymgN7FPu84yEdvC
 T2IQS4m4fWli6bNKPM8nHaFXWrON2ZmqIX4Y9N3xJs7/TwpFtusPUAdlzB52xd1KruffE9sa31J
 I8jMSHWzvy75FL+qITRjIGwBihYc/OW3VcK8XenjGwfwTGBWYmbXK3VT9x4XgUeCCbYTKwxaLA4
 AJbMbJ/6BSJwc4aCgKezdUnJbe3cThQ+2aNY6TnrkXy+qFifl0h8cyoWlnT481XPmkHecINxuBw
 0SFoBG7qKSeTvNmZsnw==
X-Authority-Analysis: v=2.4 cv=IPwyzAvG c=1 sm=1 tr=0 ts=6a74af3c cx=c_pps
 a=AhJDvPO6yzy99x9PXTlr3w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=gAnH3GRIAAAA:8 a=xH0938MPqczHS9J9ShwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060124

On Wed, 05 Aug 2026 14:59:50 +0300, Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> [...]
> 
>  .../bindings/iio/accel/adi,adxl367.yaml       | 11 ++++++-
>  drivers/iio/accel/adxl367.c                   | 33 +++++++++++++++++--
>  2 files changed, 40 insertions(+), 4 deletions(-)
> 
> --

Given that you touching this driver, maybe it's a good opportunity to
update MAINTAINERS given that Cosmin's email does not exist anymore.
If you want to take it, add yourself. Otherwise use ADI list
<linux@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
