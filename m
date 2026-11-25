Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795605132;
	b=XSusO/hyS1sEtYxzDVEF8k2Uhovj3PMiKd8nWa2cgAMdutRhwmeiL6/t4Pw6V32OCwSL
	 UW+m4SH+mMJvmIZSSshbOrXKPl7o7vnk40i0fNyxvkHAL47w4ZDlPOf0TSqsC+DK4KD8f
	 RjtmLEs/c1Ck8kxRoZXwU5NglZANKR+A78kLSBbQT2/iMhSlEU0QHOsZPHKM3L+pLw3tB
	 qkmnAFy6jfncGsFRLLDBP+WMb1kEKu1bq2Vayo/nLydNP3F6NrwVecu89ooPw9Kc6gNr+
	 tdGJ4gIdquBC52HNAOkkZ0uONR0Ne5QLdXoHdYgozAHnI9Ekp3s9eQaOxYpf3VCFmcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605132;
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CPgCGVPWPW1RFWqlxT+1wXcD5YcC5VW6oy543YSExXI=;
	b=CXb6CWcnRoFIEle5EIGVjksrzu+v7FSh5mBrHVqbmTwRmAdgxpMnUXCIfw9jSxxnAwWt
	 J/rLTzD1wTVBYeYE3nv4ZWnw1rqwZkFyawyXyDqWonvYRYIOA9Fr5WxWDcayBdWz7UeMb
	 WJS38tczpiWVnSzGiSXpeFUZ4n/JwdBtM1Xfnt08cc0vtaboU5wbK52WXQ2MSN629O7NK
	 4lApg7KLAqTIzj18LhMljDKMbJQXH95ZGaUe9fLMlwkS42pUnRenadXm3Rj+nKuiuiTpl
	 71i2SlCPviSRhnek0js1ELOyxKHGfa80YwCg90A6+1+Q0JswktVCMcZ8fGbi6zYfVUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=TkmdNTvO;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=n1Jrsvox;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E2606A321;
	Wed, 25 Nov 2026 11:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D1E2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=TkmdNTvO;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=n1Jrsvox
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9nDLD1257821;
	Wed, 25 Nov 2026 06:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=CPgCGVPWPW1RFWqlxT+1wXcD5YcC5VW6oy543YSExXI=; b=TkmdNTv
	OQCfIrAsKk2VMVf7pGQ47JyBPqdXchKO7gJOosQ/qDGa7y9AOjO20wDt52QSdFnV
	MD375bqFOUbGslnDCSSQbcuzdAv6gG/e+JhiqJScq4lg3iP+fBQVLwtXhrqeMYTt
	lewoCUKJ2Xos/XymcwowYsnmSv5ECjQq4eWRK32GsYQqHbfsxokQZc6JOvF5GOz8
	DHiLqDhbzVSSn0Ng5A6OlZyrZ81L7gN15TljKaXcdmGYXypAiDBeORk1GHrepbXF
	2mLu2zJplVr3f0W2X5UVAolxs4wBiIHEeERSYfFYIMt+G9tDn/SPzHCJKJGHZHB9
	AjODN2QgkdL/epQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CPgCG
	VPWPW1RFWqlxT+1wXcD5YcC5VW6oy543YSExXI=; b=n1JrsvoxCWZUbYY/8i0Aa
	K+vw9+blOwialQJzUAe7/MJ21d4KS70hF4niERhk96yAPJhPegJgkagJqgW5UxLN
	PBp9vZaXLhFl+ofUHJIdIWGPjjKh2W57alGkuzU6d3jSjTdwnjmL5XK3+vzfBo8P
	o3zoPZ4K/tkdpbhdtVxIYh7R273No8/OyV2Kj8cwX39XB5BDJt0xROPQTYM8J7Zr
	2Vtv1y122Zf0u5g6gCtP786dGdP6YceaOXt5T39tikdvhc1wZPMQqxIgvsMIAZt6
	IwVkcLss5b7vzSg1DeeeeEWH736sgQiSUW+pk8gAGB3hYfk3as45lKXyX9rv5yra
	g==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j5ctbw9h0-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 06:11:55 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHdd2bWB0X/hi4gGMPd+k71qZedIqp5YsEi6OWBIp4ihZQ4FEnqZjqY24CSks8VfI5s9UCPyPwnFnFbM1o3q5FDUg6/Yqdy1Dp4sjryJqTacBqim+8HcBFuhqlks9HGQaelGAku8kEhLJJKCQtdU6K3705qzpP7jSuWi2UfvY5CpFr363bypM6X/SV9+3nbe3WcqYst0dE5WnsLNOu6KnuTWGZ65QOrc50kpmknsuCRfhUXnkqaeWLjifQMtYQ6rQ69TY513TKnVtDsucLJeGUkdU1+x6NTo6UOpbCiCuT2DOfETNoR1ojudYaJ+HiFM96XdB7p4ruZLZWovN16zQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPgCGVPWPW1RFWqlxT+1wXcD5YcC5VW6oy543YSExXI=;
 b=CFdMcwxmtbFZM6f3y90CVlaeyDaXn4qQ9faW+e7wOdsKopZzeuvYsO21afC1lgocmdwV1vzH1QIYrBulw9bd6P0GUMPzFxAQCB/nwC8kD5dKI+RJs/Ndx39YqzgowKOXSkykLzpO/Ys4/5BqEtP65Pu+QJuLsVpNsJ/WUbIzvdqjpkTHMxsOUcz7l3zHiuvTH3eZAXcCyaMHpZb8P7DKH7BSdQORy9FTP4jS3ksGLZIf6sbmrAMMt+x+JiggPuSAzeO2nsVhwqWnm8VEZicUCrso/JZDx4PByxHJe/0LVlGt9Q6lwGsMxCrGLxLCjWr36YQIQ5hEnFnUKNEGb0CVYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH0PR03MB5750.namprd03.prod.outlook.com (2603:10b6:510:31::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 11:11:53 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 11:11:52 +0000
Date: Wed, 25 Nov 2026 11:11:48 +0000
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
Subject: Re: [PATCH 6/6] iio: adc: ad7793: add firmware support and drop
 platform data
Message-ID: <awbA11Ps-v16BKxP@nsa>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
 <20261125-iio-adi-legacy-platdata-v1-6-54e4c8830b57@analog.com>
 <awa728YWKMfpwe8c@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awa728YWKMfpwe8c@ashevche-desk.local>
X-ClientProxiedBy: MR1P264CA0118.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::25) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH0PR03MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 02801cb2-5436-4c5f-2022-08df4ae4e8b4
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|56012099006|11063799006|261026121527099003|261021121427099003|261022075727099003|261102123227099003|22082099003|18002099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
 fnR2Af9VG/3S2HJsTb3TQJEjzBXaK6Jhr1Yf/cMZ1zMuKV3TcOi/se1cty8NnqZapj6ewjudfIYd6x3mrgNEd3vy41CXvZXJswXTBmrmqviLZjzvKcYIRawH/sl8iN01rbAsN+S4Yq27lI8pDrSyT7Xe5AA/DOPqHSeUrj1z/BbVWo67Ir2PoSHQetESf8tZ9IaZAgMz0cxW1LkOCK+pTJqKkXX/VCcF4E9gIxlWE+asJqbeOZO0t3noGCp69q0NGiQSQT44oEVCrURF3+yIR3ShRmiGEwaQx+7tga1Eok+fr/v/zGujKF6RPIAC//AnONpt9SRPoaWlV2j6ZhKCtv5Z9bwjzNakj/em5kI8U2naIu/jLHew+3n7bHlC04Xq6mjUTVyCXE3cUig+5SV1VcjoPKQyl/rqztc28myFsc8eEd/CAoVoC3KhjUfeXQ0a5VKRndWACiTVq2fAtzSEDuTMq7sGdC7fVMdRh59BgxY77zW+qXYvgb9FXIAcMB/qL6hOPyH/qlSAWUXUsmYD2JwRDYgAksikLSWXKHOLQ6WIX6iduLs33jPEzukhtSfEIjM6UcpZUPnLxBahKxX0nro6mH2arbdvoY7AzZpY/ieJUFQvGBVSreUEIvd4cJt9OsU3GL5IaspdiWPbzPn+Cn+0X1O6+hobhUnkC+9ODnA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(11063799006)(261026121527099003)(261021121427099003)(261022075727099003)(261102123227099003)(22082099003)(18002099003)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?M3RCNGZ3MWJ4VDdkaVRGck5DSEVpVlk5MUt1MVljZnVsS3IvbEdML1ppUVkz?=
 =?utf-8?B?azRnZHNMUGVZaFpvak1pZElkNElwb3c2RzNTbFZ6U2FhZnBiMXIxZWpKZ0c0?=
 =?utf-8?B?ZThpYTNGWmpKdWVBT3p2UWY0R3Q3N0w5V1BvdGQ5N2U5aEpLQWtoSlJhTW5O?=
 =?utf-8?B?QUh5Slg3amVRS2p1Uk9uVjNGSWJXNjkwczZvWUZXQS9HOXNqa1gxZXc4SC9q?=
 =?utf-8?B?L0QxZHNTc0UrcmFhQUE1TUI0eHV5c3BpeFJ6a01SVGE3OVRKemxZVlBUZWFr?=
 =?utf-8?B?Z2V2Vk1od3FLR01adEJGY0p5aVdvU3I0akZQTkUyN1ZKajRrdURYdVpuYkFw?=
 =?utf-8?B?NFJEWFlPZGhNNG5LN0RZQjViS3p4YlhhcWpoaFlYbzV3MVNpQWw0UzFPL0Fl?=
 =?utf-8?B?OHhyQkt5Qmd0dGZGVXA3MUsrVTlvNy9mTUYyZ0FqcEtVMENVeU44OWxmcjh6?=
 =?utf-8?B?dHZHWEdFb0Uwd0ppRW5EUzgvdUU4UndjbHBweEJXK04vMGRiSGNRTzFPTExp?=
 =?utf-8?B?UlMvQjlFV2pkYXlwVlFkK2VPZVZtWDNhUEMyTWpJVUJFZkdWMVR5SDNZcXNl?=
 =?utf-8?B?SUk1SFpUQkNkTzFGTmVMQ2VpQko3SGJJT2tnRGJTUVhMb2h2SmREY0JITDV3?=
 =?utf-8?B?YmlyNlJ6bm9iK2RmUys1L2xMQzAvZmpjV1dodGFqN3AxTDBsTmtHMVd1WTR2?=
 =?utf-8?B?N0dkWXh5aklwcEZOYjhlR2Z1RDhFNUpmRktvL0dERXRkRDZnZk9wVFhza3g5?=
 =?utf-8?B?N0tOQ043ZDFBUllXRzZmYlR0ZHJWaUp6Z1J2UGhiamhjQTd0cUF3NVp3ODhj?=
 =?utf-8?B?ZUs2cndCbDF1VUJiaHRQTHU5SDF6bjB5d2NUeVlPano2aDJVWUZBUTByb20r?=
 =?utf-8?B?MzRNYkU5TENqVVVmQjJmc1AwdTJhYWdzQ1NXb0dFdGQzMDdQUGJOblBsVVZT?=
 =?utf-8?B?MUpHZmJqb1FwYzdLbEZVUWM1MnZBU01rM20reUk2OTNYY1JQbFhjbEE5Y2VI?=
 =?utf-8?B?OXZUNHdtQ3FibURoekN1MVJacWVjdktXbmFhdU5aYWNNNlJvZUppVnZ2OGNq?=
 =?utf-8?B?aVJ4eW9jNWFzYS9uemIrVnZ3eE5iN1dqOEFvangyRE41ZjJreGZ6NUo4NDVO?=
 =?utf-8?B?cHdZazFhZk1QZVpXSGNsRU55RURIQkJWdmN1YjNrSWJtUU80Q2JVa2gxaGZD?=
 =?utf-8?B?cnNoOUhkUU95a1NWLytDaWYxRVZrWTE1eTVQSGJ2Z2JtemxndDBJWWNsdG83?=
 =?utf-8?B?b25CRHpGNWZRbnpqRWU2d2Vvemt4aUViSXlNd2RVWko5d2MvZW1QVUlTYkR5?=
 =?utf-8?B?UXdJVnpGb2JvS2R3QzBPQkZvZS9UU2loaGdlUzNDUms5Ym5DNUNzeXdyMTdG?=
 =?utf-8?B?YmV6QzJvNUZLcGtZN2Fzak14SzJ2WGsxbkZNWEs1ZWU1NzJBQU1udWJQUzJM?=
 =?utf-8?B?RVFLWFZVdnFEVEE2cUZVNXAwRkRtRVJBV3FITFdkUzBNaDlkK015Mk9ySy9y?=
 =?utf-8?B?ZnJ3NlV3Z0FaOFJQcXVoRzU3TUlHNnZwZ0dUKytqb1FxTnVWYm1kVHB1UGtP?=
 =?utf-8?B?bnZKMTRnbEFoUWFCUmIwbVRDOEF0VUNtNGdCcmJBeWZLRVNyTmdyYmgwbkZ0?=
 =?utf-8?B?WUxlMWNTUDI2TUtsSHBxQ2E3dmU2VGpZSmRMN0lscjVKVTlvZjFkTzQ3TmFD?=
 =?utf-8?B?MDNoTGJsT1pMR29PTDVVT2hFM3VsOVBPM2VNQm9DVCtDeks2eU9JRnJlVDhJ?=
 =?utf-8?B?RVZsaWdJOFRYUDdJUGV6bkM2VjVrMTFPaWtvYUhqZ3g1UDZOZ3F0THJXdnVL?=
 =?utf-8?B?UlA1K3RkS0c1eXZLRnNUdXhPUHlKMG95cm5naXJWdDZDSmpDcVNZNXE2UWti?=
 =?utf-8?B?Vzh0amRBaDFlZHI5aHArOHdNdjBqZ2h2b25zTXJObXZaQ1Nuc0VQeDhhUUh6?=
 =?utf-8?B?MGlaVDYyRFNkOVJtdzVrd01lS3RkL2JUTlRJdHk4MktOa3R1RTVWbENCQWFV?=
 =?utf-8?B?VUs0aWJxNDY4a1FtbjNNZitvaGVFRU56Q1Urc2lJWXhWUE1VcVJYb0hnUzdK?=
 =?utf-8?B?V2pUcGNXTWpibk5ZS1pIY09JWFp5SVp5THp0eDI5bVViT251OVFhNG5LNTEz?=
 =?utf-8?B?d0IzVFdEYmNibmpNRjNYNE5MK3R1VzdJRnJlZS8vT2xjMUg3RjRsZWp2UnpS?=
 =?utf-8?B?dGFKbzJCU09SNzVsQ2FsdUlFdUZycTFPZHcyQjgzU3pyQ1NZZmgvVDZ5RktR?=
 =?utf-8?B?T3FoQWF4OWlLNng2dC95KzBBNHppNS9XRnE5b2VFZ3R1U2MwbjZPKzRsS1dj?=
 =?utf-8?B?ZjdYMFlLaGRac1NBN2hWZmo3L0R2VWxDdzgwRmpmOVhpTnczYmx3Zz09?=
X-Exchange-RoutingPolicyChecked:
	XdCVzaBNTM14Zvi8dPljZXpaYCZiDl8SlaVRX+N5TvJTkYBpcqLPUYXj/+hemsfcDvLk2YdkPNHuIXfQrsxxvDKTQEYiUrO0vKn6E4oZkZv5gS9KQ9LmoU6gv+KmUeVU7DsfxkFjwJXIlv+oFZY3uYaYdC87wjwyuZ0Dq+fU6UeubUz+vAxirekiFJJoZFbKqWraHSx0LXRO57/1LajHAKHeDs4zltYy2FYu+6YXocbP7Kjq65+DCGAyXFfotul/FCi8LPPwjmt1CgUI/EzeFR1l/jZ4SQJwAn1/Jybp8fnipowuZV8xwaJOY6Qh93pNxCbH3SwsNe0xC/vls16Frw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02801cb2-5436-4c5f-2022-08df4ae4e8b4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 11:11:52.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzmsUrnL7Pw7oPGKpTDND9A9d5XVnH91WmT1Rgm5syEjivxOnAJMdwwvwqOcEWaV9FCHLrkbUTDQAPD8IJlrZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5750
X-Authority-Analysis: v=2.4 cv=JrJkP84C c=1 sm=1 tr=0 ts=6b06c27b cx=c_pps
 a=5RlqQmsqPSmFSsyCuDtDZA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=Z9xE0C2JLfIMarS6JssA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 76lJs2OLeUMaCoSnFErCbvVbqmpmeCqG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NCBTYWx0ZWRfX0XAji/ruFQ+x
 /qx6SsNUQTZ//ImtqQne1zax9WLnZX0xp8s3le9N5dJ6JPlXv9qag0xVIQ/Yk2I09DSjyOOJnPB
 Hotc/QP8Lf95sanEsyt4BOz5js+13SwYXIvfKQwo5o4tPwy/3/RVFpjA+yl3DPhOp0SUrnraaJq
 2nhkyJh3ySojhjq6TWYpgnLqZWu7OnpDyK4EBoMdjVzJ47K3dfcW8zK1um3MPTtarZVTqNaXRXI
 ppbn3fCLYrLPxZFv5k1+qQg0ds+5f3Ogp6JLU24J+7jdXbosCPkG8bwXPC/7qY12xSg7V2qelyC
 YfucZgd0Plyl1z6dz/8sLOZ6ayYUyJZZdVlzFyF9rY9w+0voWT1KRa9YaWNTDmT4v6VnKVAuJmL
 e5gvMpOGgtfaIKa6nCCHmQ06xJf4I74X5gBB+w9Cb0zvIPqa1J0xUyhCZFxIu6zDEuvUjDlM02F
 1LtUfDe0Zn7EtNZ9IUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NCBTYWx0ZWRfX876xXaUrsq9W
 6dMs33Ft1df8PErVvtLKngA07RML133PVcYvB3a5VMPmnxG2MbjPowkCUSDh+/FOKryIUSTDbln
 JG2youuw4e2fOBdUPu4aZ4oLAjlY5nZwtSHUliSTvaVtD6v+ivi1
X-Proofpoint-ORIG-GUID: 76lJs2OLeUMaCoSnFErCbvVbqmpmeCqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250044

On Wed, Nov 25, 2026 at 12:43:39PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 25, 2026 at 10:19:22AM +0000, Nuno Sá wrote:
> > The driver refuses to probe without struct ad7793_platform_data, and
> > there are no in-tree users of it. That means the driver can not be used
> > at all on a modern system.
> > 
> > Get the configuration from firmware properties instead, following the
> > new binding, and drop the platform data header:
> > 
> > - The reference is REFIN (REFIN1) if refin-supply is present, REFIN2 if
> >   refin2-supply is present, and the internal 1.17 V reference otherwise.
> >   Parts without an internal reference need refin-supply.
> > - An external clock on the CLK pin is used if given. A 128 kHz clock
> >   is divided by 2 internally.
> > - The input buffer stays enabled (as it is at power-up) unless
> >   adi,buffer-disable is set, and unipolar coding is used unless bipolar
> >   is set.
> > - The bias voltage generator, the burnout currents and the excitation
> >   current sources get their own properties.
> > 
> > While at it, also enable the AVDD and DVDD supplies, add an OF match
> > table and fold the platform data checks into the property parsing.
> 
> First of all, can this be split to a few smaller changes?
> I will look at the rest later on.

I could but is it worth it? In theory this is all actually resulting of
the same change which is dropping platdata which means supporting FW and
of_id_table (the extra supplies could another patch but it comes
down to the regulator bulk reg). I'll double check if something can be spitted
but I do prefer to keep s/platdata/of_id as one single patch.

- Nuno Sá

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
