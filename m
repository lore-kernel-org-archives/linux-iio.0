Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793369201;
	b=4LDrvTss6Z0sqmW5LVGQujKvHHUL+ze151+lku/USf600IgmddNS3wbpeyKHPwpUoqu/
	 JhaobTs+ERwlVl6yjZNIFA0OJMooAOtdOGTyjfmyLR4UAg7msbXDn/IqOu2AAstK8oa+A
	 F/wd/h8o+aD22/dmX5VvHKAwl2SYQM12b8mRhkENxFN48YV6R68jOezxHm8bB3NnxPcJG
	 MYWfYgQ2qPPiJzwY4nGmVHCJ5YCa/NaxaL7JSPplU6TzKKCFs2xZCM03IzPyTqiXCUBMl
	 R0DAAXH2GVIJ2XhdJrT1nlBF2uTGU6y20hC5WvtS5yUuCGLPrf+1PBE9OMBmQLLIYrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369201;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Content-Type:Content-Transfer-Encoding:Subject:From:
	 To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=W7ZUhwkTRFn08wTjaGggu7qb0FoBEHtpHmDGWkcDjTg=;
	b=qSEbeLmRED9maJgU5D6BTey3ZowC5MigsefTGeeb+wVtqt/eVR3P4if5ChgmgBTvmr4T
	 4+tVLskKRwisRK5GHROg/DJw2ip/VIZykGm1j6kw3LueBtxygbmXKM6hXT1oQyD+LMupb
	 Djcox/KwZfJ0UkE/XgqKKkj+HjUhZeF26Y+zdageRuU20nvL4GPx1x9vS3UljKjFuO+jD
	 BhHOMApxKpgWk9opDSoNat/ZQH+CofvY3to5fIKBegMpmZjC4sd3jCGIsgF452Rp2zF7s
	 NYWlrdUCx+fI0RwlAKlCfOjsvO7A3YfM26Gjkm4tBjwb2NLk5CaiapcGeXrVxtuF7Lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=VnuzW5R4;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=kJqGuRfa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F8B606A329;
	Fri, 30 Oct 2026 14:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65F8B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=VnuzW5R4;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=kJqGuRfa
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBIA733522170;
	Fri, 30 Oct 2026 10:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=W7ZUhwkTRFn08wTjaGggu7qb0FoBEHtpHmDGWkcDjTg=; b=VnuzW5R
	40rZ2DE7oER3/yL/ohV3Gs5mT/rRouv+MY74R8+RXeexJaLQ4g+CZvAgbaFyzgUb
	kR+aU/pbKyiEY52EtIe3xt50qPgKzYHGitW7cm290Nwu6Jr29usuojROZqQqqgjd
	hLSDXFTZbmVz+gzZ+n1QLhIGpvJqhNLhLjN3BwfxiHPwqObs4C/6RYB68aR9Y+iF
	/0omiDc7Hp7oI1Bujapzj+65oUtdpFev+tljxyp+q1ycyORdxmMGILVcrVO/PJXe
	5eH4vLY2QcrlFcE6iaK3tGnq0L60tekHuEyvWtcVdWSSjkfcHs+PQIa5mo6gh+y1
	7fxihXddT//2CPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=W7ZUh
	wkTRFn08wTjaGggu7qb0FoBEHtpHmDGWkcDjTg=; b=kJqGuRfazQdRo/gUKgcQ1
	gRyHhu5jfvz3wBpSV6KP7Uz0LBPdXI8aGryLJPVdnzhhXBd+ncVZDh5qgHdQ4PpL
	eNmrrQdiyFRAZ3cv7Bs6A2hGXkkHmBruJRF3eRKR6zmr3mxeE795DdvbkXFKw/OD
	LpluTKMcOFm4ORwNr2gfApWd7ZaKf8ZxiwztTOG0AM+P7lpPXICE+dWerhcItceN
	CNWrItI6oubFHhr1VOHRGA4n+hUI/JthkY0Q+5WLEApPyqZcS6zbIDy6tlQfh19H
	G5KTX5fBHkClmhziNm7khjLSH/RVyfdWRu1+sC0DyjVIGLCcqziRzTjocC+Ybzxt
	Q==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7bv9dt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 10:06:22 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiWBUc+QqnRKcblBaj5RbPg8StZTDrrVsGEqaUx3Oyz+I7AVFaHINmtAOALWzGGfBOK/Fd9LG/v0XJV4nHoE8DtLXt/7tWXjfXYpOU1syF1vvdRB069DJFXlZYAGTXBnNT7ETsseB8mfACRrJHsoe6Y0dkFBm9pdSdJZOwjS7bgKk7Hi2dsBRoaQ8IUxgLuW4WclDnmRw/mrsBxbfnHLQwVRzByAPHXgcndsfNeXrIJrvQ1XFDtXDPQW190A1N7sxSvUu5QvssfGggCm92zNgjFFDJczL0XmGrbABUREVHC+5ajple2+tkvOfmCSM0uQ1s2GonwtmJQ/xvI/V8FUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7ZUhwkTRFn08wTjaGggu7qb0FoBEHtpHmDGWkcDjTg=;
 b=LpcBl3cPavIJZV+6CMxwUcPSnthw5r738ZR5ImAJmhFMVUleleSTUfgtBLniStUQ7ubJycxToaz3+u9N0/2OoPcZ9ea30/O0W7gXSbtwcqq/9M4vIQtXCBtl0oYMNbHptrnhjBvkBzv3hzVEDubfqFsJgCgzntv60LcfdEzbSi5a2i8cWGik9k+5TaKFp8Se/MVl95Q4PYMh6oV5b0zqq8JfOr7HKD29W9qGHW6oT4+GFrRyVGPoKftb1X1rnrmtanVNx5Tx4jilcoe83lrPY3YTP0n9vuI6k96wZBCMC3RmtuVrAyA6NGibIkcu1RIU3pMn6F5zehGHj0VtSJSA8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MN2PR03MB5280.namprd03.prod.outlook.com (2603:10b6:208:19e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 14:05:47 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 14:05:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 5/8] iio: imu: Add driver for the ADI ADIS16607
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Radu Sabau <radu.sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux@analog.com
In-Reply-To: <20261023-adis16607-v4-5-a4d541ebfd13@analog.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
 <20261023-adis16607-v4-5-a4d541ebfd13@analog.com>
Date: Fri, 30 Oct 2026 14:06:58 +0000
Message-Id: <179336921875.155032.7577697183114088168.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793369220; l=3122;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=c4R5Ozkc3scZrS4k7FCXmOyr6MGyiDPjosuZlDudR3I=;
 b=JMaNI0uCq6n2StJwcI8hioGOVOaflf3iFBq70MSuZGWnb4DzIQoQaCr1mTOPt7c7+vL6gPdIP
 gEwx5iO/g8jA8ydHCbOne805sGaV666TxIrU/HW+b2y8tNsuq5N90xt
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0172.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::20) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MN2PR03MB5280:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0c9d73-04c2-4772-898e-08df368ee4be
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|3023799007|18002099003|56012099006|11063799006|4143699003|5023799004|261022075727099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261026121527099003|261009223027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
 1p3N0MMlqxLDWiBMUz0TKSD3OIEzjFXTVrk93vEGEcYjDLiXNwBNzJ+CzsEYXrhMfd7+a5ojihF9AG8sDw9JqUxpgRdMgp24admQ7HQNher3p1W2yUrv7po5ezEp1qMgsC6yP//YcQogJAb0o/kgq/PhknXTFRRphZH7LxCxVTpU8TX/xeXDSpF1QX63gKFbFoTNwTPb4hLZa5xhVvnJj+3yMXbZ8JUcu02PgZdpqdJmvKM1etiT2vFS5010obx/nJ4BZGeqsW1qvt8APVEqd7qgxW2vOwkjfcTiUxk92FV7MHlMD4QhfiFIwby95660t+Qg8v45Ygo0oE16BDUUw34hUYLR5b6OsX1JKJmCXJ0zJ/pRsz1R4MUiM2nHZowmIXBcwo2Gs70+m/UhJ8uMQky132C9FjPqDhEvyDoOGdtxU0ivOderraXnTQUprhJNnNgGXwmW6sQCO6NZ0bgVCzcc0+oY0aTY57YgEEBrqPKI30MjcKJqoYTSepcWp5Hia5JGTzEhf12io1+ghR1ZCkC4hHSjEIwgEND8rI6MVbTXS2Fi6UfExukosLUig3IxS1EP3Scz1L5D6guk/Wm2U4mIwTYJBf91CpD9eibDmDN/q/9BIlxbtLxjPSeCZewxOtBGuDBplg0WsLD3OFD68NJOTa0S+/zYocul04IhFuQ=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(3023799007)(18002099003)(56012099006)(11063799006)(4143699003)(5023799004)(261022075727099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WDFCU3VvQmltZlJNdW5JNDNLVnNOYjJYT0FNeHMrakNvVzVoZEpMRWU1dzBj?=
 =?utf-8?B?UnY1OGppM1c0RzBDSE51dkI0MmNFZHF6RU1vYTFaWnlPYmc1MzBXWS9qK0F5?=
 =?utf-8?B?V1ZGN0JiVm9CSDZPc2tTUFhSa1RieklxVjJ4WTlvRC9QcEpBZkxFdEZQU0VH?=
 =?utf-8?B?M2RaRVN2QkduTnZ5bEdvR2FaWEE2eG5wcDVZL3lSSUpjNGVwRTB2aDJBaVJF?=
 =?utf-8?B?YlBENUdCblovQWw5TzN2NjV2cHNaV3g0R0wvQTJQWEUwb2tDSjY4aGRpZTgz?=
 =?utf-8?B?YXVtWmJSeFdOeWUrSE01R0hiVTA0aG93M20rODlDaG1rOGFvRElxYWQ1bVNw?=
 =?utf-8?B?elhWTFdVU3Z0UTlVTDZnTk51WEUrdFpVcW0xTllZV3RZamJ2dk03cGdXZWE4?=
 =?utf-8?B?OEc3UXc3a3BuTXF2KzgybWxFc09EZWJwYTBGajZvVDZ0S2U4Qk0xV09JZHBZ?=
 =?utf-8?B?SUlsNHRXdml5Z1NBNmRsQ3BtR0I1N1hvQ215dHZaTzE0QkptZzVNNGphSGp2?=
 =?utf-8?B?c09UeXE3d0pkRG5SQmlvOVVnSkpLWnRnZjFFRGpBMVBtSC9oaFNQTWhNZHM0?=
 =?utf-8?B?THhXQVo0SkhaMmlkdWptUFhmbU1MNGg1TGoxVm01dEYrUGZhUEVvc1N3QjZl?=
 =?utf-8?B?d1NtNEwyaS9MdEJ1V3FXa05pNW5DakN4WjJKbUd3Nmpkc0FMVXo1OVI5NW5P?=
 =?utf-8?B?QktPMEx1OXJubGJrdXpRZlVOTFB5QnJiZ3cvMHBydnl3MU5Pd2grUzBWM3lr?=
 =?utf-8?B?Ui81YjVMem9PRjErYzNwYjEwblladmxVcmxOenNUOGhwL01GZzF1WUF0TlpH?=
 =?utf-8?B?TVhkMHV1VEpjc1NqbDI1d2ZOSlltZU9hbFNza0VmOStFRHlJOXJHaUpvbDZE?=
 =?utf-8?B?VUVlSldPdDFIdzhuZzRUMWdFRnNNK09FMkdGQWlGRm11MDllRzFNdFlxY0ky?=
 =?utf-8?B?QzVjZjN6NG4zcG0xRGhLTWFMdnlkMHRjWHM0em54cmEvcS81dy9BcWlpY1FX?=
 =?utf-8?B?VDhVbjZPdFRlU01LWUtLaE54cEJ6Z2VWdlVxa2FkNVVzWlNZeGVPcXZ6MlZR?=
 =?utf-8?B?cG1SMW9lQ1R6ditDMldPZlBicisvWmNNQ1Vza1VuMW45dXRVYURlU0MrQ250?=
 =?utf-8?B?aExORlJnS0RpcFBld3J6cU5GR2ZRcm9PaTdjM3JCUlpHdnR6TXRtRU5LalBo?=
 =?utf-8?B?bHdZdHNtRDBpMG1NaVFMZ3A4UVQ2ZHZyRzJ6Tk95bTdEQWNhVmxvSCtmWTV6?=
 =?utf-8?B?M3E3WFN2REVuYjU0L1paL09WVFgwUjJQWkttb1gxdjZNL3hJeXRWU1VBUWZF?=
 =?utf-8?B?ODkvM2wrMjFlbHMwVGR0RFlKa2hVaEx4UjUveVdmTEd2aVZCenBFb3ZnU1Vq?=
 =?utf-8?B?UDV3K3JBUzdBZnNFVFR4eFR1ZzZUK1doSVpVMU5teFl6Z1JmQVBhYXFPYmhs?=
 =?utf-8?B?bkNtcEkwN1RNL0dUaXRrRUVPd2ljMjI4VUZldnZjU3R4cUNGUGFZczIwV1pM?=
 =?utf-8?B?QlIxZXhZVXpRVWx5THN3czFQSzlNVUlkYUNOM3dZMGRGZm1kU2VtTUw1dVlv?=
 =?utf-8?B?WFlkL3RPNnZUYklRZCt6Q0liOTgrSlVLU3c4bGRjbk9jWkp5bi95MHpXaWd5?=
 =?utf-8?B?bld2Wm1rVGRwM053TXlhaFNOUnNqTkdLb3BGUG8ySGFCa3BYRGRBNFF5Umk5?=
 =?utf-8?B?VTdua0tINVpiNTRCTTJxQWc3MW1lNEF3NDRBeGhBYmtRQmExK2dNcWVCNmlD?=
 =?utf-8?B?YkRwYklGSEpGeHlNYjVFU2lHTHQvNFYwVTVrNE9XYjFLdWxGSm5ISUUrd0FF?=
 =?utf-8?B?OWJpbFNIYUtTck9sVjh5SVEzNXVyeStvMnlYTWNXb1M3a1pkOU5MZ3dNTTZD?=
 =?utf-8?B?VGQwOXF5UTNsczFScGNQQjd3bW00YisrTUZJdkV4TmJWRzJ1UFF4Q3RMbGZM?=
 =?utf-8?B?c0kvTW9waU55SzdNR1diakpaTmhGM2xiaDg3NFk3MUZ2KytpUW9DWVJ6Q2Vu?=
 =?utf-8?B?SXhWZFdFdVdreklXb0FZVlR4QlFPV0NjcGNFVTVZRVBpUVpNS0k1emE4M3c5?=
 =?utf-8?B?SzFpNDM2dDJRTTNEQk5EeHZrRmJ5N29YMnM2MnJjOUlYN0RCU3dKVXpqNFp5?=
 =?utf-8?B?OTJnQ3g4QnA1bFdzenZvU3FRMVR6ZFhXU0Q5ZDZIUmJWVTNQRGxBMjhBNnIx?=
 =?utf-8?B?ZUZCODRvcVpCZnBoTFI5d3RuWFlMOXltcnFaMzB1aWRJZno0WVVsTkI4ZEY1?=
 =?utf-8?B?Z3BLZmNud09JZUl6aXZ6bVdRNFk4R3J4MzhSRHJlc2szajFmVmtpODVEVi80?=
 =?utf-8?B?RXJxZjRUNlVvSUZ0SGZKNXUxc0xiRUVmY0I0WVIwdFhDNmo2eC9xZz09?=
X-Exchange-RoutingPolicyChecked:
	tWrjv3IVDSbYFo1Uzny9mppWterKUmVP9UffFfPzrMDcstLqbjTa6YxjdcnSc9a///w4m5S/XHZFMfNAoy+3JUonmczy1vKYNIFZLKE5OAGpr6h78EegEYCFbJ4AKB0mmMqygA4MGn3S+wCk41Ag2CvR6iWvkx8zL3veG+H8FvouUInKQBhEJ8O5t1epMZz9y+fGCzO1ueMwNd4OQp8LJX8y2ceAoDuNEug84wSgg+3VIoj3BS/BtX9fThvqyma9ZeSvfL69BNlf5yW8Ffn2SdE7zzDw2KDPoVF+33h5fcWWq3eZDWMhyEDfYtnUF6b22oBaYNQhuKPx7RQA3FMfDQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0c9d73-04c2-4772-898e-08df368ee4be
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:05:46.2212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9U+i0ZgrBiqYri9lzooAxPs37PdPXSQX6/wjiZ95Liw1ACUYyO9trB3MYDjVf8YZAwwwZPvuyxWRrDMEhJxSpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5280
X-Proofpoint-GUID: 94bivL4qKzVUJ9kl-z7HC_UXnG9xR76I
X-Authority-Analysis: v=2.4 cv=Sc5i5fRu c=1 sm=1 tr=0 ts=6ae4a45e cx=c_pps
 a=ZIPBhjw7PX4DPdPA1Kx5nA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=gAnH3GRIAAAA:8 a=-gPQRGB56Xi5yFGtsWMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 94bivL4qKzVUJ9kl-z7HC_UXnG9xR76I
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfX12PdLFdpkg+m
 AEFaNZYFHFJYcYxM1kiVmtVNLy7ClPm7tHkLjkW0lKIp1U32pAZjl23NzBhz2mVs+scIbFNE79C
 8nXYPgASuZcyovKG8nssuCQv4kO/ZeReTvaHpLILq5dnlkaA9Yd0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfX3KPGhgDN1gVL
 K4drGmrRCeQKQLd9Mqkwt6gL61cWwbw/ylZhSB/w5Fa9V5WNrXLNG7liuwhDqR6JO/KQwNTVXZ0
 2Ahafiw7k0nKXqync+/bgJbmPuAcrZjEonh//M3H+t5gGUqhElUSlwwV48ocfeqlyXa+sGbjwy1
 NMBdiwtEC7vt9917nOyz+PyRV9kzWyNeBXgIJjgC8jl3BKa89M3wzUbs2oibUwHnGkdQtQXwQJk
 ZwuCg0lPajtdLdeysgEC31OcKhTl9FXlZdXQvqFSrC+M6ne7C6ghSlWPxBXEDzqG4OeYRB4GS79
 e45/OyDNIHAsgFwAtBKS+3C/l28rg/jBaov07FKVlb8StYktp57AM1mAvASdyF6a3qt2sGdbeqe
 gTPIyCT1cAyTpqNBL4J/Wlu70hOfMXdlsKcp12bXn3tw3H1XQASE5bgKdQDbI8TWffIWRlBE1va
 SaeWI8A/f+zWeGpv/WA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300056

On Fri, 23 Oct 2026 12:30:22 +0300, Radu Sabau <radu.sabau@analog.com> wrote:
> diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
> new file mode 100644
> index 000000000000..2dda306d7b54
> --- /dev/null
> +++ b/drivers/iio/imu/adis16607.c
> @@ -0,0 +1,842 @@
> [ ... skip 102 lines ... ]
> +	ADIS16607_SCAN_DELTANG_Z,
> +	ADIS16607_SCAN_TEMP,
> +};
> +
> +/*
> + * SPI Half-Duplex read operation for ADIS16607.

I assume you use half duplex because burst mode is not available in full
duplex?

> + * Protocol:
> + *   - First transfer: Send [reg | 0x80, 0, 0, 0] - device latches command
> + *   - Second transfer: Send same command, device responds in bytes 2-3
> + *   - CS toggles between transfers (cs_change = 1 on first xfer)
> + * For 4-byte reads (24-bit sensor data):
> + *   - Read MSW from reg, read LSW from reg+1
> + *   - Combine as: ((val_msw << 8) & 0xFFFF00) | val_lsw

Just repeat the above down in the code. I would only mention it close to
the code,

> + */
> +static int adis16607_spi_read(struct adis *adis, unsigned int reg,
> +			      unsigned int *val, unsigned int size)
> +{
> +	struct spi_message msg;
> +	struct spi_transfer xfers[2] = {
> +		{
> +			.tx_buf = adis->tx,
> +			.len = 4,
> +			.bits_per_word = 8,

Isn't it the default already?

> [ ... skip 13 lines ... ]
> +	case 2:
> +		adis->tx[0] = reg | BIT(7);
> +		adis->tx[1] = 0;
> +		adis->tx[2] = 0;
> +		adis->tx[3] = 0;
> +

You should not need to set those values to 0.

> [ ... skip 179 lines ... ]
> +	}
> +
> +	/* Verify the correct device is attached */
> +	ret = __adis_read_reg_16(adis, ADIS16607_REG_DEV_ID, &dev_id);
> +	if (ret)
> +		return ret;

This is not consistent. Above you print an error. Here you don't. FWIW,
I would not print it above.

> +
> +	if (dev_id != adis->data->prod_id) {
> +		dev_err(dev, "device ID mismatch: expected 0x%04x, got 0x%04x\n",
> +			adis->data->prod_id, dev_id);
> +		return -ENODEV;
> +	}
> +
> +	/* Read diag_stat to clear any latched faults */
> +	ret = __adis_read_reg_16(adis, ADIS16607_REG_DIAG_STAT, &diag_stat);
> +	if (ret)
> +		return ret;
> +
> +	ret = __adis_check_status(adis);
> +	if (ret) {
> +		dev_err(dev, "status check failed: %d\n", ret);

ditto

> [ ... skip 37 lines ... ]
> +	if (ret)
> +		return ret;
> +
> +	ret = __adis_check_status(adis);
> +	if (ret)
> +		dev_err(dev, "status check after self-test failed: %d\n", ret);

The above already logs the specific failures! I would not add more log
on top of it. So, `return __adis_check_status()`

> [ ... skip 79 lines ... ]
> +static int adis16607_get_freq(struct adis16607 *st, u32 *freq)
> +{
> +	u16 dec = 0;
> +	int ret;
> +
> +	adis_dev_auto_lock(&st->adis);

I don't see a reason for the explicit locking. At least in this patch,
adis_read_reg_16(() should be enough...

> [ ... skip 13 lines ... ]
> +	int ret;
> +
> +	if (!freq)
> +		return -EINVAL;
> +
> +	adis_dev_auto_lock(&st->adis);

You can reduce the scope of the lock

-- 
Nuno Sá <nuno.sa@analog.com>
