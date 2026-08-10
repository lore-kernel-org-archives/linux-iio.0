Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AF43F0AB8;
	Mon, 10 Aug 2026 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374399; cv=fail; b=sATgG2gdj57BtMMkqQZvAwR17M+EhnTdiyFk3LYTX7mGj3j8XoBRAGWhGm2nrJ5s1ta66/CnAfbMweO1nD+ozL221BAj1xm5AtOodqluFplQsBF8zttSdIsPwKNnL8neMt/c9tPgqZmskHKpx9QE28Q21Vtllq1au+K0D0yAUpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374399; c=relaxed/simple;
	bh=tTeDT+KacDLMVRNd1Fjx+G8m6ApDUezZPLGktu3/qBc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rv1wKhrnbltsFGt/O6rNbs7SjWK9dzbTB9+VkkNMi77RszfdVXdJwn3C5d+sfirpAWQ3J6Tinmtd/61J0Iw+EPtaYD2dFZjMIa6/z9ZGlZZDGTVipXFTb5qApdTS/8IpQ/yqM0hBi38AE2evySc5f6wjio8rHRJfkKHswqthtYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=f6PBKI5o; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="f6PBKI5o"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACsHLI3474289;
	Mon, 10 Aug 2026 11:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5sbSd
	rq78dAOORMP9YFXgXeoZY3eR+9fIRuAU6uoRZg=; b=f6PBKI5odfQStKe1QGRD0
	uc9rdEWbiF8Z5h9u1/TOTxpZlH3jyWNaqiMjpE2tf5B+fvA9V/IBReem3o+2Lxc8
	w9S6g+rZQGhLrMMuJDudwK6+P1Nrmj3U4psBoCS9khET7/XhJYAbMjHsoNd28ihb
	2d2VENmxU/GmoBAfaS+dGba17qfXEGwsh0YkuUyRTDPGKlQdw5jqzO31oSoxCjQ3
	lHnZohAoa2Mu/IDGnw9Gg14QtsDpnA5h2yg1FosZslzGjwMadQW9O67CMUGDlRcF
	njiuq6NTMdUzKnpnuSKlCrCEQpCf6NCfypJjx9iQ5PlNxJleAs5t2t5YkMnIzRQt
	g==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fxn2jbwfm-7
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:06:12 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRl3uKVyOCbTjWmaCMWnfi/dpefHSDdFE71xwdLNcW5+yQGmeABpBYQH6ylwd6Mi7nC6bCc8Ao5IrmoJwqeyc/FeuFNe4L3BGGtmbe8N6XfgWyuG5X1cIDHg01KPfZfkUIrtIQKEp6Vn/XOIbndvVxO+TACKU+CqoLtRi8PxspKV10MluCY+IjcPxnkL1ujIF5uWrnRU5y27ge+8OzjhuQ0juJtK0VogJjjY0XAc0G29oxJlr31C7WhLSV9sHd/UvqUXpRtgk2jXVC5HG3xT/lGj2SClRsUz4hLlXSvm3Ng5uV1YzyNjmAVMJs6Xz5l2W1fE/AslSEr6YlqQB6t7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sbSdrq78dAOORMP9YFXgXeoZY3eR+9fIRuAU6uoRZg=;
 b=ZFOSfX9iz4jZ2f0LsxmjzIxNcVffFO46TT1OJOvRrIOhWWZqQh1DQDgt035V1kXQo81q5aExqweUXux9piKv/UjxWTTIJDkf1Gp5qNIp9moKjt5vWTKUgjU91LqC7XAqCt0F4hK7SlBqdV89DkRVIha7ZM4x97VjorczetlZ5+ejDSOns6gKdMCtKuZilcOygrCGubCbAxH1pC3XlQRGdi4ArXUGNerH+ccw3E8SyGymhDSVLFL0otBeLmhcogoREqrhDjA3NX4qr/VBZuQxigL2L1pie+qDxaJ5InofQBjb3KYuZtm/aiKW+I3OvW0VCxuoOaipseP0HWt6LkSVJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS7PR03MB8170.namprd03.prod.outlook.com (2603:10b6:8:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:06:02 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:06:02 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 10 Aug 2026 16:06:48 +0100
Subject: [PATCH v2 7/9] ALSA: pcm_dmaengine: Use dma_slave_caps bus width
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260810-dmaengine-support-wider-dma-masks-v2-7-1f7b798d035f@analog.com>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
In-Reply-To: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786374404; l=1998;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=tTeDT+KacDLMVRNd1Fjx+G8m6ApDUezZPLGktu3/qBc=;
 b=Ep/t/vMV7YMHbxSd8IVVMyw+8LzypHPxTi/r+sinJNVdbjHUpBmx1LN9CVzIKgAfwbplZim8e
 O+F7pB/cjRjCO47R3ug7ELxYF64ds1YNHbjHXFzCvO3NYKccpKMP1N5
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0137.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::21) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS7PR03MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: b6eb4da7-eb5b-4bb4-7beb-08def6f0e4e4
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 xn/YK9px6gNV7NJNprMOs937MykecBf0Mxg0WgwWUeob4UlNqRoSoJtdkJfDCbEKOqYw9A5mfNnWHY/JiRujLF3L1us8BrQpUZycMR4MYjLu5RG7xmifUYhOBN100VzSgZT9TFxzbkBU8c8x16+oUhkkUNldwQiTlOJuy5D7RL8pPgG57aMOdIXAsNUbOWnHB3hV6LUofrS8b03eANtJ6clZOdRln3vBQGMG7hYgWj5zP3Omb53SEBciZNVDQOsDcKEGMZ2Ryg5FneijwTU0s26KxtWYFOYXqpW7rq5p1FLroODJ/FZD2Zq3GzIQArmG5dY1bM1AZ6ds+dRV4O8xL7XDgja/x4Qy0LOdWxrznAB5wH3SyrunyvCUYweIbiLZYXOOkgMXDLr/I2E63JNbKNx6TguMXy8Z960g1oOF3hLp8dGUkIM8rDhBdeqWXiay9YRFR8b86JXNKqHjpyK9kQjCuBYVFXynDKbWWvYmYPmUDerTAuVuZqXsi1JwbaJjawtH7K7rpN358F3kDIiD6YqiNvX56CsbEgqTtMkAdPcfWUsvng8rLOCPZBzPYu5+OA76vs3CMOL9EBmyQrbLRk1odTrb9c9v0ShpaNKTQrGxjONAKjGY8X1zkydQaRBLRTFpRwgb/7pSKRv2lpSLCKyLLHaaIMT0e+6/U7e9vF4=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Wjl6eWxGeU9rSGF4UGxmYW0wQ29RbXpGUWxUbFkyK2lvbU8xa09wRjFhUEp1?=
 =?utf-8?B?OGpONDR1NTJ2eHJZOFpCV2Q5N3g3WU5QbVZBeXRXdFdJaFh5Ujg2RFcrYnpO?=
 =?utf-8?B?a2syTmd1cStya1dCVHNYOFdGYytEdU81VXdLb0xSZlFnTnN5Wm9PMHNUZmJv?=
 =?utf-8?B?RCtJMTR4VXE5NFhvQzFhSnBnN2orbVg4N25rd3MyUGJWTjJ2eWIxWW5XNlhJ?=
 =?utf-8?B?RnNIaEVycWgrTVZYV3ZEVGdUVzlFR1RjNW92NDJHNzlCelpXSUdJb2k5M0dM?=
 =?utf-8?B?Z2hZcHQzVDd4MTlKV3Q1MWI3VGZaaHlwSEkwaWxTdHIwVmlNZEJWREJGeGNK?=
 =?utf-8?B?clN6cjkwa1hhRDVpY3BkQlV4KzQ5S0VaWmpxYXp4L3BoeUFMTEpGaFRpM1VS?=
 =?utf-8?B?andGTHVQOTl4TGtJbmxpYWY1cXFVYlh3S0h3S0Z1T1hhUnRZYnNXWWhldEpC?=
 =?utf-8?B?bmhESFpacUhzMEpFYklSMDdSYlFtdVRySllXSTArOHo3T3Jjejd4OEtDeXpZ?=
 =?utf-8?B?RUowNkk2MHJaN0RpMDFiQkxPZEVQRE43UEQrK2NzQnYwdW4zQ1BkeDljOEpS?=
 =?utf-8?B?bXpUS1ZKNDJKL29DWFdxVEw4WlY3RzhLOXBreUJRb2RmWjVBaUFReWVkMW5y?=
 =?utf-8?B?d2dBTHo4SWpOQkpMbXFINmRHZ0Zwb05JK3VWdXNPRVNMbm5Cb01HQldaNFlk?=
 =?utf-8?B?Q1NzaFI5NG9kTnVUdGdOTFM2VTJMR29FZEZQRXI4VytrV0dVcERPWWgzN3Bt?=
 =?utf-8?B?M2xPSkc2MG5BMXRyazFvaGVKMUxSZWNhK2VvaXRuM2VuTUJFNGFweHVORm9I?=
 =?utf-8?B?ODdEaWxCdE1Rc0MyMk9ycVUxbHgyZ3I2YWJicXh0NVlud0RNUlR1MHozcUFK?=
 =?utf-8?B?OXZremx5U0NtSzY3U3F1YUprck10QjVJTGJlcjRBa0VLa3VEZVdyZlJtWXYy?=
 =?utf-8?B?SkNTZk9zVThpWWd0RDNBV05TK1hwYjNUUWVLRU1UN09Rb0xuSkxrd1N6ZElj?=
 =?utf-8?B?cllsejNwVWNMaXF6WWdEV1F2YWVIaVNrNVNKYzVFYlh4MUcwbW0xMGZYWVFK?=
 =?utf-8?B?cU9vbkNoSWt6dHRZUlB2Wkp0amdsVGF5Wkh3VEpMQUJwbTJxT1hSS0tHV1ZR?=
 =?utf-8?B?U2pIWWxyZTluZE94bVJBV3V6MjhiS2hqV3RRYkJlNnFmeVJZUk4yVGJ3Uk5F?=
 =?utf-8?B?RzBpRVBVRmp5andkUXlscU05YnU3YXBWRi9jZVBKSTVPenpTRlJ4ZTF1VnQz?=
 =?utf-8?B?L3Yvc2RnRjFhYUErcDhWazdOTjdiZVBBOFFRWFZJdFk3aENoaXc2eVBPT21J?=
 =?utf-8?B?L3phd1gwb1MvdmI4Qk9xZUdFUGlGUmxQT2VuTm43dTZuSWszRjRrVHpDcnli?=
 =?utf-8?B?MHp2UHRDa0tSbERHV1pxcUZCL3czUldqSm41a003aE8zRDg5R2dtYWwzVkNn?=
 =?utf-8?B?M1AzeWdzbHBpNk1VUG55Zkc2NnpSZmVpTSs3VlhIWWVKek5tTSt1MlI3NVha?=
 =?utf-8?B?bHlzbkg1bTNTSXVPUkIybllyRSswUGh4TUVSbGNCdXUvd2NmWW9rU1d6dmU5?=
 =?utf-8?B?ZGQzaHZoSXdyRDhkcnNwSnhXOTJWekRHbnh3anVYeFBTZlFYTXpPVjM4OE85?=
 =?utf-8?B?WTlMQ0RmZDNwUUQzZ1NSelBJN2RRMVJicGhRcEhNeERIVWt1VUpRNWFGME5o?=
 =?utf-8?B?UHNVU3kzNnpvTThJSEFPcExudTJNM3BXeVRQVWh3aVVNbWZyWmt4eFcwemJn?=
 =?utf-8?B?SEZBcmp6SUFWVm5VS21sU0pKOHVTVkVMdlh2bUNzOWI5WnBlRC9KazFQdGtP?=
 =?utf-8?B?NTFlR2hpVmVLbVpGcmpUR1lVVEkvRWtONXYxWUY2ZUMwY055RUlXQnVwUVpJ?=
 =?utf-8?B?Y1d1S0t3ejBmczBwdFdva0s1dnIrV1V2LzljWDlRUXp0N0RTVmJLcGp3cG1O?=
 =?utf-8?B?dEFSQ3RTMGxpNGhqaHpheHZFMGlLZy8wYzI2NWNtODY1T3dVTXZydmtGZFhq?=
 =?utf-8?B?cVFBTk16TXFxbjF4TTAxR0ZzUWlNUFZ1RERTbTZLUkpVbUgwQzF5aVdhcjJM?=
 =?utf-8?B?R3A3MmZtUGU0czU1M0JzNm40aG9ITzZvdWJwTTRGYXVvb2VrTithcUg1YklW?=
 =?utf-8?B?dlZka25lc0pkRE45dmpGUHNGQ21vc2xHL1d5ZjZKeE5iRThYWUJ2UzdET1VU?=
 =?utf-8?B?MjRqSmVTcU9oelplRElLbFA0TTd6SGJlYjZycnZiRGVEOFlWeW8rWTdlVG44?=
 =?utf-8?B?U2RmYjJ0N0ZwdkxaRTdUVmZ4NHZKdDgyUVpMdXNQVCtXanh5K3F2V0l0Tmln?=
 =?utf-8?B?ajVYcTRMMTNkQjJUazB5SXg4K3BIdHlRNUwxWDhURXQvdDA1UG1tUT09?=
X-Exchange-RoutingPolicyChecked:
	i0Ro2eWMAn6jACE2U7wsJCNXoinerCa1cR76L1C0VZ7f8yP/YP/s+ULBdeGU7eErHgohIKDrE6VfuXUfKU1rvprhE8W/EogOjD3LNSBtzlQHq8uAUIXldkrIUG2//+vh7REVcVagXOeluvmoxI5LO/z5tATds8aN6Pl14dZmiSxwcnVQ7ME6euxiXUErpLgdPLrD7wR06BTzg3uOOebHNJAJVYWJ1b5BfDzllUWduX8HI2BtjIzzanfoIWeGzUGskX978+rSSM33kbqM4ka3/sHiNkJQYYMhcsOGRo1ZjI7FBGTF2vuqBtdkOCWVk9zghXNEsdCI4DKuMhPgsz08wQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6eb4da7-eb5b-4bb4-7beb-08def6f0e4e4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:06:02.7288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAX5tApcXFihqhJuy28Gv87/AAbZU2dCD6z5dNv2BBM3c5yfpP9TeO2ztDiCRXAKFMiAuVdoB8Q96jbi0IzC7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8170
X-Proofpoint-ORIG-GUID: 8FYVRas-NSMjoFmciUI0-vWQ3U3E2yEG
X-Authority-Analysis: v=2.4 cv=SJ1ykuvH c=1 sm=1 tr=0 ts=6a79e8e4 cx=c_pps
 a=94FLU6K3oGZrB1XHaeOsDA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=9ik93NakFGnP5mR--uMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfX6lz7ecu/ccvU
 ZSkwJ5YRGyX7QRmWVJBRFnCmRzqT1uFe2HgGc6+F5gZe/7US+Mb1ANh9zw/ITWkGQOUy3sLftPD
 rgDpdyPINB0nY4TSOrmUDZlkh3iZfjsZhUmVapcf0tpQhjnijieo9udsLRRcputS2suCa30oDuD
 gneu+9ATAy/yvInxFbF2qyLC8I3RMQVb786w8l0bVjBmCEdEBh5q/3VfvSToNxkRuXlqS9E+4Lh
 4RRWNZB8V+xbUOMe2wfakXtC6S6lrX/9zUMLdTguzf3vXiV6DFGBoy1j0nwfaSD9ubGErXSpp5T
 a2uT0uOPeGbnVqt2yqqWoLalBqAdwyIMtfldzyffQdjozUQNRYSZNcb+NHVLbqoFOSYP17HFwYV
 qFko0ESvqi4IMK+BMyHn55vTXHBW4UOwgWyst7mYrfZhzoDC4Qita+opD+17DAhOqF5YR9MB2x9
 ajAJCkAHDujZtMymN7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfXzKG73Xn6EoMK
 uvWLTv9740fcp7DPCEhoYb0k/skRUcBeDyvRlAo4xgvpIfFvGOyUtKtjXY78VXGGtegY6TjM8BY
 68ZHPBWAAK8JK0tTyfTcBDS15X102j/PbXC0yudht+1wiypOnOhL
X-Proofpoint-GUID: 8FYVRas-NSMjoFmciUI0-vWQ3U3E2yEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100130

Use the dma_slave_caps bus width helpers instead of reading the legacy
src_addr_widths and dst_addr_widths masks directly.

Keep the existing default assumption of 1, 2 and 4 byte widths when the
DMA channel does not report slave capabilities.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 sound/core/pcm_dmaengine.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 1306b04be171..37468f4643bc 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -409,15 +409,17 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 	struct dma_chan *chan)
 {
 	struct dma_slave_caps dma_caps;
-	u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-			  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-			  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	DECLARE_DMA_BUS_WIDTHS(bus_widths) = {};
 	snd_pcm_format_t i;
 	int ret = 0;
 
 	if (!hw || !chan || !dma_data)
 		return -EINVAL;
 
+	__set_bit(DMA_SLAVE_BUSWIDTH_1_BYTE, bus_widths);
+	__set_bit(DMA_SLAVE_BUSWIDTH_2_BYTES, bus_widths);
+	__set_bit(DMA_SLAVE_BUSWIDTH_4_BYTES, bus_widths);
+
 	ret = dma_get_slave_caps(chan, &dma_caps);
 	if (ret == 0) {
 		if (dma_caps.cmd_pause && dma_caps.cmd_resume)
@@ -426,9 +428,9 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 			hw->info |= SNDRV_PCM_INFO_BATCH;
 
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			addr_widths = dma_caps.dst_addr_widths;
+			dma_slave_caps_copy_dst_widths(&dma_caps, bus_widths);
 		else
-			addr_widths = dma_caps.src_addr_widths;
+			dma_slave_caps_copy_src_widths(&dma_caps, bus_widths);
 	}
 
 	/*
@@ -460,7 +462,7 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 			case 24:
 			case 32:
 			case 64:
-				if (addr_widths & (1 << (bits / 8)))
+				if (test_bit(bits / 8, bus_widths))
 					hw->formats |= pcm_format_to_bits(i);
 				break;
 			default:

-- 
2.55.0

