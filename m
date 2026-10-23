Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792745550;
	b=wPBJaqw+c0HhFeeS1T1eihkKbfxtO8gb8vHLi1gelLie4y3deQwlF+9UTC7Ba9jV7K+9
	 /5kUpHeHv6BOhylhE9JyRiSqLNJKO8xrS7G0ZITCCZWsfQjEE1UgYD5uo8Dl6K8At0hIq
	 Q9Vg7QHiYRnbulYxGc+U1+GT6yiXMGlGdoM/A9KOsna3tXgXhPjyT7+cbKWbOT03Z0gPQ
	 WB4chpDJeD2rZ8hN3ybta+XVg9+p5eZIKUkh4pJdrhOMFWAdkUa8xGjsKIGXSwYyQcGsf
	 YWoPiDA0c6TInkUsapGrVcdHmaPhO+BS2bPay23JNmFebvDDtQ9g0RDP8nowTc39FyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745550;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=l/qJLNug2vluNJV7mBiq5Dd0N2yA2rbkWPBeV2PJ3e4=;
	b=Hur1CraiRRDzamd2/54pC4ftodH9KyeWDQG0mK6kVr2yTrUG+E+P+d3TLHJjgUm9v0/Z
	 ByVFVzkvLS2T2VIFhTeHsvLRXGZItVvJPnf2ckFmw5GjEalxfPOTCP78sXiyuIGsvVq+w
	 zvWqgxU6OM/wTsdR8/faTQJcjCn9CxvTkw4LC2C1YYSv0Hm731x9FVNc8/7ryN1SKpeuz
	 068FV2w/X0f15dMhQYZnUNwhORSt+BpmPS/8dbTsIdSOVOggXTv6geN1VrOMCU892I7MY
	 ZmO/v4pcXtoM3bLsRj1KJyOzrJcXh+805As8XmJTqZAP3N7kQzIDjbseVXuyeCn0A0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=UhlnrwWs;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jgZkUmvZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34945606A31D;
	Fri, 23 Oct 2026 08:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34945606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=UhlnrwWs;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jgZkUmvZ
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7Gov9003623;
	Fri, 23 Oct 2026 04:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=l/qJLNug2vluNJV7mBiq5Dd0N2yA2rbkWPBeV2PJ3e4=; b=UhlnrwW
	sqXKoqjpR6jR/amPlZGCxIUTVAubPjxVPJehmBTc59PqhsiNkwfIDnrrIrRbxvsr
	eqBPnHddBoeNilkuRVXJYrgmPRuioc50c9WdgqmTlB4EqkA74/IMDyA21eNmAFQl
	nCfD6/YtQZh2fRGWdOOS49hBfyqzFeBdgoshdIaXWOhpFudFmlkQnt8w/fRZ1PoB
	4XlnNFIPfgJnpLzHI12kVtJfrcx7upi4feWb5q+rO+9itTyDJljzPMHu5xfkEVw1
	IgCrkPI2g4OXHNl552GYgBKGkkqmg5cOKHwUMhlsRd4q62jSt0x2q6MNCLJpH4Xe
	/K5jcrGc4Nnb0fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=l/qJL
	Nug2vluNJV7mBiq5Dd0N2yA2rbkWPBeV2PJ3e4=; b=jgZkUmvZ10LbqM8xRZsaO
	Yhi9rtfbz+7QBF1BmgEB/EA3Xd1o8XdNZI0xaLr1TdJxCUq+1k+B6/VlCdcDPjsz
	qFS84U0qdgpb4DYLBr16PVsXwcaI1w3KEc9SOGkSQJDnXcWaRvnD1uKJmvJcwrEv
	6Ln9NnTaIg486TjDilO+eJW0JgCUrlaNS5nspEEj5MJT8RKEdOmQFhvS2QhkW78g
	W4OPEidQdUZJg+Rr0toTV9u4NJWOpcprUG/LPjWBAU+TPy6uHwpdt5Q9Ifwm2tRZ
	mUyDPOhIawsBh3EM6o8wBuBwLNXbxjVNIvhy1jGzWMTLn21qjUGGvKnAxEvhQikH
	w==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hg2mvgh5a-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 04:52:25 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGpLL391iySx6OpMmSrxt45BTtKgF6GlMGeCwHk3Ccts8YAh//KG4IGD1QFeYHRa0oqfqQv8XWaWiDPyJKNGA2r4Y1DzVIYq674vJr/E3+nQONKytjeyOl4RBNF7KdArpGnGNg5twoMPPMJ8diJVOAd6fYoVEz7dmhcrmBXYVoX4l38c2v9B76DRdBi+JDNElufAF27PBcxkhk28ytsaNaIXrkJbnWYj9ceb2eE1Tjmg79n3kr5Ff7+YIHt6BOrBaYuUqE55VxyC0NxFsXHB3v9U46v+aoX2gPDaF4z0hYbZsowTssd6ckm/IUbO4tcVry/t9KiMWFqw0rH9Wtc8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/qJLNug2vluNJV7mBiq5Dd0N2yA2rbkWPBeV2PJ3e4=;
 b=PHzNAdMd4QU2/qfzML9OxbyOHa5i9dSmwlupEMRltlaeg7Qt3XpoVMLFTJGXxx8+GjnWl/eMN+zXekslKYEtMYwg6fL86oPFD3Wsvl5XLvzniaIPC3yaURz/eVteqcCkBL0wrpmhPkBaLQwIlAL/7JZZC9BnhTaPrtT3NUpiDI56oNcMryfi7415/5lFkMZYZSrek/E1IW1vgeY63RUSuhRCTp5m8AWwA2eDPwKHHVLmaeQXE0Y2ZEsOhk1jaPC7HALL+Ca/lLRib9CZX7Z7aRJBz6w4wAicqPC1raxvYIjrfGCU33+OIUJ4hOG/dJxwuT2lb3HeNIcHxA7Gy64Sug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV9PR03MB8440.namprd03.prod.outlook.com (2603:10b6:408:377::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 08:52:23 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0546.016; Fri, 23 Oct 2026
 08:52:23 +0000
Date: Fri, 23 Oct 2026 09:53:36 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Rodrigo Alencar <rodrigo.alencar@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: core: fix signed integer overflow in
 iio_str_to_fixpoint()
Message-ID: <atsgYaApZPg_3Z1N@nsa>
References: <20261022140353.24213-1-kapoorarnav43@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261022140353.24213-1-kapoorarnav43@gmail.com>
X-ClientProxiedBy: MA2P292CA0020.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::10)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV9PR03MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc4164f-8873-4271-fb80-08df30e2f432
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|260925021311599003|260925021911599003|260925022911599003|56012099006|11063799006|5023799004|261021121427099003|261021123027099003|261009223027099003|261022075727099003|261022105027099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
 9dLg/G5gudgqU1FLjZYy9oR8NIqGDGE3SqhPwYYDj5CWlcG4TlAW1mXr0D5uEXm/iYE4lt2jGZwhc0+xDaY8abViMxIlS10A/4mIf8JO4n2OrxN+cJin7vJnUquASYBmjqJSuitEI62MNcWSILv7/SfKLIDkJSniP42dQY/f/YhBiJqItoglrznLl9+RQR9kvUZBLX8r6pZlrqKmQhxmM8QOgCGzyhIy68zeSMkVyoN5FkAHekcI3u6eWt//HxGwQEt0LA823JiDFPSv9p3p8CYuwtazkMSORSTvbg9XiOpDWJW5T5F17oJ1N3WKgp8PxBJehqagttGw/CmxZYUWA6K92YXIX5C3gi1xBTpKtGbBE/Y/VX3i0zNdouSttOQdIacyAiTYZrDfDHeYI1aRSgt2A/Mf6x3YAWPC3ZteGfXrCNgVmwJOcnmyCTdjzRf2v3vGGjvTJchY56thGH3BVkvFHNnhwgGJYAzCp99I9NZRIL5qU6mSFXfkjOC/5/6ECnl+fwIUqcTeBNb6DdMYAiRBgpiXJJfnHaFRzWu+izXIcI4jOFj1OjIZa8TS/t+04NTzU70Jw5Onj2MvMFpAXeqwmV6pN3/EjEaA3QWdhK6ApGyu2FmAU+n8ZR07HH99
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(11063799006)(5023799004)(261021121427099003)(261021123027099003)(261009223027099003)(261022075727099003)(261022105027099003)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y0l0NjA2bEdQRzlZMXA2eWMrTmRleURqM1hyTThDaGVvYnRvSHQ4N29rdTJD?=
 =?utf-8?B?bmFYQW5jc2hzaTFKeGludDVFNnFWTTdZZzR2Y0dUUUdsSng0R0hrM1hndjZP?=
 =?utf-8?B?NGk3WS9yQVV5SHF3bGdzTTdLVW9lVUZ2QmFhOEswcmVrOUg2eVBDZjMva25s?=
 =?utf-8?B?ZzZkbHVKTEZhZTRlcXlBQkRXUWNYYVF5S3NBWnJEK3Zyd0RKNEs1VHBDd0h1?=
 =?utf-8?B?QzM1TjRoQXJlNis0Q0wvbjNEbEZ4UCtoejU3Z01NRXRYdnk3WnlGMXkra2Fa?=
 =?utf-8?B?d3p1dHl4SXRNOFMwSng5eDd4ZGR2RmExb2tteER3c0I0VnZERVNKNUNHUHpP?=
 =?utf-8?B?cCtWd3JxTGdWdm9xMmw0R2xMV2RBcno0NjQxa0JsSEMvRVNWUFNkcEN4M1hU?=
 =?utf-8?B?L254K1hwaDZxVjZtSC9Lc3lBQXNYYlBtRmdsNHF3QXpubGRCaDFKMk5ENlhJ?=
 =?utf-8?B?bWpzaE9haUU3T3hndmhxR0xvR3hBT0N2eUUzS3lScUozM3lFZVpPYkRKTHE2?=
 =?utf-8?B?Nzc0RldyOXhvbmxMTnlJc2UrRWoza1VNRlIxSGpPVkNPdldlaWZIN2x5bXZn?=
 =?utf-8?B?UkwzdGpjWXFZczJMODkrTzV2ZDlvdTFNSTFqV0FQMUNzbUs2YjhXdUpFMkdI?=
 =?utf-8?B?NDAvMVM1Y0tSbHFzRnRCU2tVV0dUS1hYNSszL3lWZVM3Y1huU0piWitKcCtE?=
 =?utf-8?B?ZGtDdWN4NGdBWVM5aitjZW5VOEF4d0I1KzNlSFVRQ3ZZeGhHM3RCaXNPTG5M?=
 =?utf-8?B?ZmhiUUtkaFhIdmxLNnA2b1E3YlBveEpwb0ZrdEY0cEp6RDVrcjdQR05EK3BU?=
 =?utf-8?B?NGV3Z3FoL2JzYnFjQnd2RXozRUV5T283S3diUG5XRG01aCszZG1DUE5iL3pR?=
 =?utf-8?B?azJsV1ZDSVA3eENlRjFSSE51WEpSVWFac1lFRkF4MGxTczhyMWE2NmVWYmQv?=
 =?utf-8?B?SEFMQzlHM0dNbWpHKys2dFZSNUs1MTRJK0dLZW9OSUk1MGNVL2tjVnQ5SGZE?=
 =?utf-8?B?SE45bGE4UjlzOVQxODhVcktZc2d0REFZMWN2OGVSUXBZRVk0SDRPSUZ3WVY3?=
 =?utf-8?B?ckc2YW1mUG12WjN6aE9DYUFsRTgvMzJDVTZhT1RaY2Y4RlUybVlqOFExVito?=
 =?utf-8?B?UjBuYk1Ha2FlRUJsSkx3aGxWZEF4ejUyaGhPQVZOTGtoTUVRZnZUbTBzZytI?=
 =?utf-8?B?TEZFb0lqdWxVN1lqc05wR29DT1grN1VNbHQ1ZzgzWlF4NlQwOXZuaExHOFor?=
 =?utf-8?B?WXd1M0FOYWd5TTFocUF1THFnckFLaEs3SndKMnFwVUEyelFhdlZGYzd2RWxP?=
 =?utf-8?B?QnEzcHo5S0JHbTFZeVlsb3Y0dWZkMnFaY3JVbkcwdnZSdG16UStWYTdJNEhY?=
 =?utf-8?B?SXJZRlRlbWdHSi9mSnpNeXpXN2NoS095SGpVVHdQbjVIMjViODhCOHF4TEQ5?=
 =?utf-8?B?TDBubFhZN1RBWFVxQ2Zwd1dyWWwvQmh4b1hxbUJ1OGc5Q2ZHdEZHeG9nbmJG?=
 =?utf-8?B?a0Z0T3FiZXpNZ1RuMUFxamljeExZL1hqSEJUaWxsbUswRjJqb1RpL1A0Zm1G?=
 =?utf-8?B?dU5DQWlicXk5MzN2RjQ1T2lsbjBVVXM3UFJhVVp3QVBYbWkwWmQ1MG1waWM5?=
 =?utf-8?B?Kytqajhodkd2aGFBRktoWEdaUWNWMVRZSkNqS1MzMGZwcTlFRzdITEhtYnpS?=
 =?utf-8?B?Zi82cGVSbEJFT2tHWjNsWDlhY21tdTEwTjJvN3VubkRBTVdlaU9BOFZ5dU4y?=
 =?utf-8?B?eEVKQ0VqQUprbTdnbmx3NFkzbXFwYlpBdlBGK2M5RUtQc1lWV2x5cytZaTNX?=
 =?utf-8?B?N3k0RmhERHlWUHZaUzhWdGZwSTVORUQ2M0Q0QkJ0UnFSbnpJenozckJTWTFL?=
 =?utf-8?B?Y3RFUWc4bFhjdUF5b29WUGd4a1VaWG9SRnFKVFRDczJmUUtET0E3MTh3VEtY?=
 =?utf-8?B?ZmRKeFhSUVJMWnl5cUhmWCszaUFoVDV5ZmJjSVZwUDRPbzE0b05xZWRuQmFh?=
 =?utf-8?B?Q2tmNURVeWlQazVwVThocGVIZWw4SWM0aENyUnBLNktHeXVVY3l5emhJVUpH?=
 =?utf-8?B?UEZiUnBodnhPUmdnaURiL2JVdFhjUnhXbjdrSEhyaHlQdklvelN6U2VRMmoz?=
 =?utf-8?B?SFdxQUNUcm9YZ2tNbHhtdkloemoreGJaM0dnbllCMERTdDNqRFdSMmdpNytz?=
 =?utf-8?B?cWF1eHRFNWpPZGZ4Qm1pZVNJa2N0N3FKdkErbmlFMVlaOWxyeU1PbTB2WVcr?=
 =?utf-8?B?TE91Nk5oQjMvMGk2cXF3Q0hnMjNRYSsyWGRDWTJ1TDE4M2dwSGtKcmR6WXdI?=
 =?utf-8?B?Z1ppQVVJZjdCeERzTzF3VlRjNHE5QXdiSkJUcXJ2ZlNuK2JlOW1ZZz09?=
X-Exchange-RoutingPolicyChecked:
	l57Qxxy5ZVmOrPfvKRRyzipbYyntYp68XCEE+CjbYE15wC8YNcxVKC+5AmfnTvXNbz1wTS0Q3T7THgTstJK5Mhbp4kMzcpL/qhdcSAbxbTnGlI5Tk2I+JiN8/3Q0sxH43lXuj3bEcnMOMbwJ+3pLlYP20Yhy5Tr89nop5kU3NK2vRvmREPx4xktPU3ELogrfKEJlGtYWUQjBPNMIBzr38QAZsVoaUAUzSlYxN5ebaNB9oUIx9x7i7BPPwC9VbsvLyAQ7XeO5wxBvOzu+MPploJ4n+20mhOK9/iwPtsN2+0q3jUu6sF4Kp/nOzmoCKawpyBdNtlZB5eSxic8SjcM7gw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc4164f-8873-4271-fb80-08df30e2f432
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 08:52:23.0903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Qh71od8g1k5bzpFvGUk0lqOazdFPcmXa/8wRe7qWVC5EqzswH6qs6q7Sefnvw17J2sYSz56HD3Xx3SdlHuriQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR03MB8440
X-Proofpoint-ORIG-GUID: yMbztQfvuKQ9sOxuZ4_-jcNsr-BJbNey
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX1s2mivkbdbTt
 Ulq5LWAZ8xkh4qXZGAdCYpBI+cs+9nDwLmCJFdy7qWBmQbTd9HcCbHY4Fyx6Q7SWy707ACT01Gi
 SCA0CUmSqdbmiA3eM2MF5YqK3RD6VC5lE5WZipGzUnXZAOoqB0Az
X-Authority-Analysis: v=2.4 cv=YJoKWhGx c=1 sm=1 tr=0 ts=6adb2049 cx=c_pps
 a=3isWwmYGSdluMw1j68YAZQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=YcIqaAZUUrgg7i1qe_MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNSBTYWx0ZWRfX9rHboyB7YeS1
 GoObCGoaUxHneznHkkkJOx7e7noqRpD3PNyRJQE91/Tmk6RwtuLviBi6JzSsQP93EMGaU6OeJAg
 S4YCvjdUmoA99wMgQoDdYkWsipGYRfa047PUt0olfPaGOTsF1IEVpXKdr3dtB3j/CJHqFg25ew1
 TG9wHlE4c8rqUofISRlPgMffYex9JgPlTlQq1xy+Nyvv6ggbY6MXkuOXKldxM2uWi/2ExwpoVvA
 f9wKB2ndsdfhcOQ+x3U2DFHSar+OJTKNYiybSXSejnDo89IwBb/9QDLPPuq2irfJQRGxTJB7PoB
 7SAbjj9wNkuzmzpliAONWa5ICF/vd+RTdIkG8ZJwkANlsFt3DY4tKqoSfd64Cs2T/e7z7eH2MoC
 RHP51O9T9fE+qXjEhoMN4B6ciJK03Yo5L2zfUhwvxgTeUzgNJTGhdgYBKlTt/fShpoO1EDrOJWO
 mXIwZGdBAM0wCG1wWJA==
X-Proofpoint-GUID: yMbztQfvuKQ9sOxuZ4_-jcNsr-BJbNey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230035

On Thu, Oct 22, 2026 at 07:33:51PM +0530, Arnav Kapoor wrote:
> __iio_str_to_fixpoint() accumulates the integer part of the parsed number
> into an int. Feeding it a string with more digits than an int can hold
> overflows that variable, which is undefined behaviour.
> 
> The parser is reachable from userspace via the writable IIO channel
> attributes, for example the "sampling_frequency" or "in_voltage_scale"
> ones, and via the exported iio_str_to_fixpoint() helper used by a
> number of IIO drivers. A user writing a long enough string therefore
> triggers a signed integer overflow.
> 
> Use check_mul_overflow() and check_add_overflow() to accumulate the
> integer part and return -ERANGE when it does not fit into an int. The
> sign is applied while accumulating, so INT_MIN can still be parsed.
> 
> Fixes: 6807d7211327 ("iio: Factor out fixed point number parsing into its own function")
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---

LGTM (maybe a Cc to stable next time but Jonathan typically takes care
of that),

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> Changes in v2:
> - Use check_mul_overflow()/check_add_overflow() instead of open-coded
>   s64 accumulation and limits (Andy)
> - Apply the sign while accumulating so INT_MIN needs no special case
> - Drop the unrelated parenthesis change and the explicit casts (Andy)
> - Add Fixes tag (Andy)
> - Fix the truncated subject line
> - No KUnit tests for the current parser, as it is replaced by the
>   E notation series (Rodrigo)
> 
> The fractional part is left as is: with the fract_mult values used in
> tree (at most 10^8) it cannot exceed 999999999.
> 
> Tested with a userspace harness built with -fsanitize=undefined on
> inputs including "2147483647", "2147483648", "-2147483648",
> "-2147483649", "99999999999999999999", "-0.5" and "12.345\n".
> All inputs that fit into an int parse exactly as before. Compile-tested
> in tree with W=1. Applies to both togreg and fixes-togreg.
> 
> v1: https://lore.kernel.org/all/20261021225306.623361-1-kapoorarnav43@gmail.com/
> 
>  drivers/iio/industrialio-core.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index d73f2541375f..f3bf17c13cea 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -25,6 +25,7 @@
>  #include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/overflow.h>
>  #include <linux/poll.h>
>  #include <linux/property.h>
>  #include <linux/sched.h>
> @@ -1027,7 +1028,12 @@ static int __iio_str_to_fixpoint(const char *str, int fract_mult,
>  	while (*str) {
>  		if ('0' <= *str && *str <= '9') {
>  			if (integer_part) {
> -				i = i * 10 + *str - '0';
> +				int digit = *str - '0';
> +
> +				/* Accumulate with the sign applied so INT_MIN fits */
> +				if (check_mul_overflow(i, 10, &i) ||
> +				    check_add_overflow(i, negative ? -digit : digit, &i))
> +					return -ERANGE;
>  			} else {
>  				f += fract_mult * (*str - '0');
>  				fract_mult /= 10;
> @@ -1052,12 +1058,8 @@ static int __iio_str_to_fixpoint(const char *str, int fract_mult,
>  		str++;
>  	}
>  
> -	if (negative) {
> -		if (i)
> -			i = -i;
> -		else
> -			f = -f;
> -	}
> +	if (negative && !i)
> +		f = -f;
>  
>  	*integer = i;
>  	*fract = f;
> 
> base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
> -- 
> 2.53.0
> 
