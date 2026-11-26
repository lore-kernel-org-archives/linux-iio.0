Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795688987;
	b=P2y+fBA9xXm38aeWXVyP3tOgkA1CFHkyu87BY3uYrrKVJiMEbUjBIAG2JRGLyfnfxm0K
	 fPCaEz87zdGYdP733Jzl/4pXBSN2NACq9uuT36vYs06UkKQrt67ZbdyJeTIQKlhLU1T1/
	 i9soueOxXqFEldyYW8RX7lh+KtqInKfE4Cendt/2IRKBNlzN3FnJoON2sX1zAuV6cBz1x
	 NzuPPtfFRi6XiS49vJ4H9+rLqXNBw+EGDKDPGbWuIciAx2R046jQKClfjhtGtclVQxBaG
	 aF5/R2CUQ9Ca+VjospW9wWhD/uok1Mo2TesTVrpNu5dh6BcvXYqoGw1345XlDj1b2VQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688987;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=daOrQ/OrAjX3XU3TmfHu3G8I8boC7trpwj190Ub7L8U=;
	b=pKJiviP6prNZPNKavx+kCMxngsSlT4gR8l/9EYMl6TLMwtQU3WzzQXYPHnYPzQlFMgdy
	 CgN1xptvjJkuPcjonrdsi9LHcLBzgiCbPKGGlll2uO6YGQWus01vT3HJIkgm2F3CZIRV4
	 2FDOCXLwDifumGLNK3TjJILlWkSNyGSXUZcOZ7sOC4+IvxyXZ27Jbawb4P5/fuSun7K3D
	 vR0DBdfk5wBlzQa4h7bSI0ff4GAyLyt3UJUrGoib7Oow/Zs+bIOnwAuSP7gp6FoFl9bQW
	 35R/uKuOwN2IKHUjxtUkKDsuMHxxCSCZMEhufAIJYKcbk9PISLNHR5b1ZYiEXPl9XKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=hfMtymmv;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=IHSTUQ7q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F0D606A6B8;
	Thu, 26 Nov 2026 10:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4F0D606A6B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=hfMtymmv;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=IHSTUQ7q
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7EAdP334627;
	Thu, 26 Nov 2026 05:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=daOrQ/OrAjX3XU3TmfHu3G8I8boC7trpwj190Ub7L8U=; b=hfMtymm
	vBDqghQGPcvbAqEttQsY1CDE2mACW7nl0m5Isf9MxyEzQVDBWvdBPwoGMJDDxdde
	qYyKbMM/sUs27Sd74W24L4jCDj4lKxC6LGqppd9e3PI69DNMIOtlRDxoHPZ8uW8V
	lxeVcTHMAtzdAoQsMfRcgfMUJNt5tiUjv487yia6M1s2RKYw/Ow6W6+OdHtgmn0t
	aXQcBvFBa9C2JyEzudFsIzotZvfo1CRagU1rjCNsRZIKf6+OhY5epUKi7mNrZWgd
	Kr8yQ/3dg64dK+HWxTaPdE23nzHGN8ztmrOwKTA8PtUbI4buK/m09fXp1/SRzaVa
	wvMEkM0kceb9ezA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=daOrQ
	/OrAjX3XU3TmfHu3G8I8boC7trpwj190Ub7L8U=; b=IHSTUQ7qJ8dFgcbqk7Bv9
	kDnjBiSTrirHSScQR8gMaFxPZr23YIqBXmtyuXNYcQrpRRo14YyvMDJsomdwFhpn
	2+ZB3kW5KOg7qXoaHzFwKouGVCnR0CTjE1kkPwR8zl53fp3HwvW5zb6W5Mh1wgEp
	kc6fOVGi+jd8Ioy9ezyx7MbJPPR2Pvr9oCBJltPfjtB28ziqiyTvAFNsssF1XmIz
	KxMIyzQj64Hu37PQLGt5sHOCNvkEYVopZ0mKhlLgjPn1fQzjuiKORUuB7MJKyfPx
	zRUvJ5QvAMuvkA/L2Uq80HdUPZ6F1YusZbHJuBWnphEBva6CSwmZfpzt4uZPe3xm
	A==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j5epyhyg1-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 05:29:19 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HS1/zC6UP7zNt6vRUihUJ35aSLxpGkmnipy+gOYowYoAgog+DD6BVSW4hKekQB1sb9PXV8cI9Dv60V3IQhJpnvgfu+yxmu0rzCIy8IiSpMZ7B4P9ThxrF7jJ6beeQb1xoNW8UPkrRto8LkgEffQ8mazfX+CJFODTU3em1KKiA/++vwg8cFum1MhJuChHlZhc8Yx3GbgkWDMpJRBaOlKDuaC0lwV8LfAekYLPM/QxFD4X85O4yBl0oH4smiVYjo40KTifPGaukF9vnvcA0ylgIGEn8Eifwd+CuM3S1Rm2G+R2sl6jJbNZbKCkA3kwrEKL4PmQYMiP3c1/Kp1vUt7mVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daOrQ/OrAjX3XU3TmfHu3G8I8boC7trpwj190Ub7L8U=;
 b=fOcGKck1GdSXQBtA3pmNgIcEIc4l7yn7l8/jriXNYklOO2Xd93xyeX5Rf1ToagqPmVUTQdLxgiceT5H8+15zmCRpmurpxAo9wI6mi5sgL960FoJBRnSheRUM4nLokSORnYDFaDqWvpmZF5+HbB75KXAs65nOrqb4JSrZD2EkQyB5IVdi4AjRWsnT4xmF1eTptjygV1ZJTD4IFBgS7bxc0iF1dlHDNInI48+ITzHTOtlVOwcfLlAQzzvE52+gbXPAZv1cMQhvt2q0BQohjsb2rLNacujljBl9+JuuYAxp6qx4Xw0C/hOShwU7d4XmxdSwiybLgO4WlI2b7fy2BFLy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB7442.namprd03.prod.outlook.com (2603:10b6:806:39f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 10:28:45 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 10:28:44 +0000
Date: Thu, 26 Nov 2026 10:28:32 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux@analog.com,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/6] iio: adc: ad7266: drop platform data support
Message-ID: <awgJVUpCo0fCxPNr@nsa>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
 <20261125-iio-adi-legacy-platdata-v1-3-54e4c8830b57@analog.com>
 <awa6rrFP3-dCpIC6@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awa6rrFP3-dCpIC6@ashevche-desk.local>
X-ClientProxiedBy: MA2P292CA0026.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::12)
 To SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA3PR03MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c3820a-2191-482c-179c-08df4ba80c83
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|10067099003|11063799006|56012099006|4143699003|261028144727099003|261022075727099003|261022105027099003|261022115727099003|261022113327099003|261021123027099003|261021130227099003|261021121427099003|261021135927099003|261026130827099003|261026121527099003|261026140227099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 VVBZr/KVsfscRp4YZww/hBVv/JiTioHoBCLcOypU5F8kWZs/bDl3jgQZJLMCZ1t7+Bo1snoczjBtz22zcA21lqp6MRoHjMd6azltwOY7xdALDKlKNFj5qTwy16K/jW9qutOmJLQI3DXFSF+V8W8QbupnWbdOcD05fWJel6E2Mh5r3+ZbceEUTkCgmN9ppOJExLfh/gk1vDHZhUvs5L6pZiFhrqVXdZmoOXfOsh3iDIGphMK9L63pG32SHZKUxPp2waZnpn9Ikz7rU4LZ5Ia91PaFdFfaBdb0eo95z+lyYZuPsY9HfRuvqCO+QihfY6I6zRHMgrQoQfi7uabvocan28umngQSrqP/ReJK83dyn8j4e5iCN0j8iIMbKBBDkxGoA+XOxTe3BqDUKkDwO1i6pRwJQNS972FKqMN3aHhz2uuY5WFWJCyBqT5yiT2zclEIlEOU6/JWZHQk5tPXxkIqfqaPN0lv+dp1LIS87rFbzLgiTKbZAtOkvGdXbL3z41J6S7HLhTp0eInpcSXvWkCH6UnJLdINfxSH0yfxMDgVsfV4LiI866bbFT4jRGNnWyzJiJw6G3FcjSF9d/m6YZRnY6VRhFob1MY+oN48Ssxj1/bqVh1SvmBgsMHNvSP4IDyQ0ujTXdTdist7cyZzdlOyjK9/NFOGhk67BfVc72mngjo=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(261028144727099003)(261022075727099003)(261022105027099003)(261022115727099003)(261022113327099003)(261021123027099003)(261021130227099003)(261021121427099003)(261021135927099003)(261026130827099003)(261026121527099003)(261026140227099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RnBvRHJBUW82dno5U3BSNml2emxUUStUVG0xZVpMUHUyVStGdGdISlJ4QlFD?=
 =?utf-8?B?b3o5Zm93amdMQWttVUFzYnJnaHBSZHdpMW1Idlp1dVkxQ3BSZ1h5Z1pxYzIy?=
 =?utf-8?B?TVhBMW43eldTYWUzL3dvREZwY2I0YnRDWEZLZmZ6M2UweG0rMjR6ck4yTFBu?=
 =?utf-8?B?Z21ZZEVQNmdZKzVaYVVuWjRtTk8wS3d6b29yRUZPSUcvRFpGNmVlbmhVS01Q?=
 =?utf-8?B?Q1ZJNDZ0cERFMzJQcndRRDVubGxwWFVlS05oUE5yOHVTWXMxM0N3NmlKUmwx?=
 =?utf-8?B?SmlJenNmcitnNU9zRUlXRjg4aDdMdHB3US9RUmpMamNSV0NlbXNRSVJ6QTRH?=
 =?utf-8?B?VHFHYk1kV2N2UVNlU0pyQ0tJSUwvcHdlWm9BNHpHYXRGYTgwcFo5a0N6Wi84?=
 =?utf-8?B?Z3kvYkVVNk84cU9HZVBCUlJKWGJZbzJxSlp3WEwxaFVQaDN6aFRQSkRCV3BR?=
 =?utf-8?B?OHh4dnRyYkd0QjcxTllNUndqWllyWTdyRGNjNUtCS08vUDRscUoyL0lvWkY5?=
 =?utf-8?B?a29mUHNWZVI0NWllTW5pY2JYTlRyWVJEUUJ3S2dLWWVCU3dXTHZQeG0vZWVz?=
 =?utf-8?B?dDd3dC9TVGZTRTdTY0tsNnRzYWVqVGNXMUptaVZOdXdTbUtUNENyakdlbjcv?=
 =?utf-8?B?OXFFcjNBQjh4OVFrRGZmelRPOWJUN0Z4anRoNmk0eU9FVDBEaDNMNFJWalNh?=
 =?utf-8?B?eGZSdzZsdUM3d0o5TU8zdlR2Wjh1aXBkb0FkVndwT3RIT0I4ZWZidTd3bUtN?=
 =?utf-8?B?KzZnTkdHY1IveVVIendYem1wVGdpQ1dBTnRlNXNiWHQ4UkNoWkR1R1Zhc2Fm?=
 =?utf-8?B?WkxzZXdqN21tMVBJTVE0RVRVMWcwUjYyRTNMUzlyby9SUzBaRFpiUHVNenlE?=
 =?utf-8?B?UDRtZ2NlbGVkMW1NVm5iZS9GZE1FZDhhM3BQY2UrYWtHNDh0SFFjekU4cWNt?=
 =?utf-8?B?UCtaT3EwcituS1hXMVRTRGswRUt4ZzVIM1NSK3daTjV3QVNNbDR3L1kzMEVG?=
 =?utf-8?B?QlFtbTRaKzdlZnJzbVNtSDhuTHFYSDVGVDJBakcwakl1ZGY1TmpVaWwxS3dC?=
 =?utf-8?B?M1luTUt4dXo4NTNXTENzeGNneFNOaWhuOW1JVzY1QTlGTnZ4Q3N5Z0x6bCtS?=
 =?utf-8?B?UTlNVEZtWFAzdE5VR3NiMjZoZzhzZjZwNU9uMnNqTUpUNTlLbmFKZlAwYXIz?=
 =?utf-8?B?K0c5MmdRYmdQcitlYktoVU52a0FGR002QVp0THZUYXFRcE9WN3pHK2RTYUtX?=
 =?utf-8?B?TTY0ZUV3S1ZYZ2g3aWk2bkNLT3NvcmxMY0x6TkZpaXZLV3hNYXpZaG5iSm1C?=
 =?utf-8?B?S1Y3SXFrSkU0enB0NVBzSG92QlpLZ1dseHNaRVpFMnBobGhoMEd6L3c3SGlk?=
 =?utf-8?B?TW9RVSt5QzNValpSaUgrblloT25hLytUb1FwWkVTd2RVSnFCRDY3Z2xLVnpD?=
 =?utf-8?B?MTkyemF5TkZVaEhIMWduc3hDL1ZQcTZtMWFWTUc0a2VpNUpwb0dpZnVQcFBY?=
 =?utf-8?B?bHBTREFhL1FhM1c2ZTA0T0I1VWVtamFCOXlaSDh4V2w4TzEwazdWdXVrM3pV?=
 =?utf-8?B?dWcwT1RTY2E2bjRGUXBkWHNPeDdBWlJOM3NuRUd3anhMYjhxTUtpbWFsUlIw?=
 =?utf-8?B?WlhwbDRqYUFSei9Udzk2Qzd3bWNIb2M1em5scy9WUzMxb1lJblBMVGV5d0FH?=
 =?utf-8?B?MDIwcEU3a3I2c3VscUsvSFhCTklBZmRYV2txeFFTamJxcmhueEVaME0raW5n?=
 =?utf-8?B?ZjZVaXIvUkg2UEpzQXVQWFV6WlVCWFRtRURQT0VHc1VLdFE2TEszT0l6Smc5?=
 =?utf-8?B?a3ZxdmFyN2wraFhwY0lzWEM3dEtvNnRDYmFTQVhmbzF6WlYvQ05DaWpDUDFt?=
 =?utf-8?B?NkZBV3RKY3UzTi9xSVFobnRYczFlWjZiQ0hZakoxOU44Z0hTWmlNd3hDWW1w?=
 =?utf-8?B?eEJyQ1IyVmh1TXZydzlYOUVZajdCcmQ2Rjg0aDUxL0Y1MUxGeVd4MUgxaHVL?=
 =?utf-8?B?cE9xKzVjM00yQ0JVNFhOaTJDNDJNcDJaVGNVMjgwWW9TMEFSZDhFVUlXWkF0?=
 =?utf-8?B?YUhHSzNVSmNVQ2JjTGRDc29JN1FrUFZGNkx5NDFUMkd4NUpHU2cyMVcwOFVt?=
 =?utf-8?B?bmdTRXpJTEExZXZ1TnFKL3BRVzBrSlRZWlV2Y2VMcHJOZTQvNlhLd0ZuUUhT?=
 =?utf-8?B?V2tFa3V5bG82cEV0RVZTeDExaXJyZmFGVkJaaDNFVDJQeko3NXhJS0szdTZO?=
 =?utf-8?B?K3E0WWxWOXRZSytDZnZsbnRRRjZYUWJ6MUx1MU5CSzlYUUN6c3JpeXl0R1c4?=
 =?utf-8?B?QUttNnNDV1lMSEpsaHJlQ2xWelhRM1VyUHluWVA2Z1dLTHR5VUwydz09?=
X-Exchange-RoutingPolicyChecked:
	VCCi2YNCP36iAoo9ZiXJYmmr7q1y51mvDWv+unoRa/fVyWpGrz2vOHgSxbxWojMf7ayaPgzrcV/Xlj0Eedq8DPuAjF5Z4Ifoi02KTTha3XBpwkKooBeljRkQuPbRTiUvIBVJnMjYsNydPJaOrouA+JIzb5ixg13SBaCJQWj6asJMTRA+HoXWRuuO5a0dcYSyqk1DgBtIati6vSq7322hhFl30G3L+YEwVG4uMvy+JFjtPSIec6AEMaF/8FP+riC6RNz8KE48vdfBvp/zONrw4IniegOd3xQAfZcEyTtA932LwgbI/3g16bZc5IH211bsTkN4Vm5okmfmGOd2nPTLjg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c3820a-2191-482c-179c-08df4ba80c83
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:28:44.8396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKyuvuqWQr+jR5ad4J+YXotttYBYBRII0SbyUygCdCWXO/Tggw6iIlhrBbSGT2viUEvQyMwOXR0L1Dildhls+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7442
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0MCBTYWx0ZWRfX+PVOagwELA7k
 kNFK/TUIa/4XgMgcePmrs0K2spdJ2J6y7wO42+1zqXOT6whQbPO416mCtpXTSgZLTqeO+Z4EczK
 oUqEZQsZLXkTmXaOhmEzlvpGqQC26v2a4M68MbmTtsEYC8SKfo6OSwdzkM5fP9qLrywawq31m1H
 xIuCdDTc6yaqQmsayPze1n3SgVMojvhl4k0JRAKwlygRxli3loVDBcb/5l9i+nYOrrqYYI03zMT
 IXeemJ35CDGhZigYkmTNBv1RvEcDKE4vH/zQSYrsZKFfzjUf9GaId1/vhlhDcix1j6JB4/j6jMV
 pDeFnq2S3d+fLrLIiHjNNj+ZW4p50FlSv09D8M7iN4jdzI4EH+EQ1Ch7X1YgtOq3iKLV+vC0sgh
 MiK+2e6vJ+E1FzIGIrIZILT4ehCFIB3SM0AcKIuSP3LEZH9DMtWttaTe3lCyKc3EZtGWevyUA3u
 9kYuhYonjyn4ulz7nGA==
X-Proofpoint-GUID: c_iMw-i5a8ta87Kh3NF4ulxdsCRU0lwF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0MCBTYWx0ZWRfXzh3fE4OlDRRC
 p+AYHV5OZzi6ZZH+SKSymUg3KeUO2JZwIXsuV9JFq8CXb+Uqz1IEyndd6ji28guYGPHlO5Vq1uJ
 V0OxxZs3LEvN3esVVynRPgLNrG6eJyVZgCb2YD/cgPaSPFGABkY6
X-Proofpoint-ORIG-GUID: c_iMw-i5a8ta87Kh3NF4ulxdsCRU0lwF
X-Authority-Analysis: v=2.4 cv=G+WJgNk5 c=1 sm=1 tr=0 ts=6b0809ff cx=c_pps
 a=qLcLqgYGKfI026PYVGi9KQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=4aK5FxYzVOJ5r5g2hSkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260040

On Wed, Nov 25, 2026 at 12:38:38PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 25, 2026 at 10:19:19AM +0000, Nuno Sá wrote:
> > There are no in-tree users of struct ad7266_platform_data. Without it,
> > the driver already falls back to a fixed address, differential mode
> > and the 0V - VREF input range.
> > 
> > Drop the platform data header and move the range and mode enums into
> > the driver. The code for the address GPIOs, the pseudo differential and
> > single-ended modes and the 0V - 2VREF range is kept so it can be
> > enabled again should someone need it and add firmware properties for
> > it.
> 
> ...
> 
> > +	/*
> > +	 * The address GPIOs, the other sample modes and the 0V - 2VREF range
> > +	 * could only be selected through platform data, which had no users.
> > +	 * Keep the support around in case someone needs it and adds firmware
> > +	 * properties for it.
> > +	 */
> 
> Same comment about the comment.
> 
> ...
> 
> > +	if (!st->fixed_addr) {
> > +		for (i = 0; i < ARRAY_SIZE(st->gpios); ++i) {
> > +			st->gpios[i] = devm_gpiod_get(&spi->dev,
> >  						      ad7266_gpio_labels[i],
> >  						      GPIOD_OUT_LOW);
> > +			if (IS_ERR(st->gpios[i]))
> > +				return PTR_ERR(st->gpios[i]);
> >  		}
> 
> Side note: Have you considered switching to GPIO array APIs?

Nope. One thing I've stated in the cover is that I really don't to fall
into a refactor trap. All of these are fairly old drivers so I'm sure
there's a lot of things to improve. I just don't have the bandwidth.
Even with AI :).

- Nuno Sá

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
