Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794581205;
	b=skGySvQN/n8uB41YoKLlw+gSsAL1rvc25sQanvA+hvlJ0owNWLV78iU/4hnO0a7CKYpP
	 R8TrmFDMUFD5m8s5YL/VnsCEtDMirsS7k5PNzZf+BZbmTQQDrFXZdvB4kdmdChmq8ACqb
	 GRWztlLwZ+QIN/q61/cJmj7Yjel5wd0soBz2Ya1eQN2u5iP4Mi6M3x9HQrWBH6wNFbVid
	 zK2e0pekXsQ62/g0JRn6IlUzdDvNzEOAWOsilEYzNIfipcdxKO6O4Yux8XhZwa0ogJcwS
	 KPFIljRDuXaz7CA0hGToiqYLgGvSerDud3O4kZlcRfG8WmxAMZbxDIpoc2w9iXukw5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581205;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:Date:Subject:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JqQONeIKNvLS7WN374lsWHrJm1wJjx6TpjeCAQTVmqQ=;
	b=ePd92Y2acsNoF351ZpcfWMnK/KJbwFzfSW2kBR3Q0H3yoqyRrMTONjm5ve7IwXVYZ+42
	 +POjtkZjmID/6eoQkaDu+G6KVZXCpNgQvVam6RFbmYrZftdJBOtSLVrk06PjpsHkVpHt5
	 SUF35kBbmLbqwvxDIpPbKUZkzB52OGAzRHpnfc6tMEUAjbgL8Ba70Gi41NBM93MXhfz1U
	 +nWH60BnAPNYX07YVurIf+tgB00uw6M6YppdGkgncxzPYwYQX1UOE9H0W+fvdc5y3p1B8
	 fZXp8xpLi4ZRJhLBmDQf11+IEemisKrCagy61hYKJunsRsyzfzzu7IZ8oHG1zwDaKVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=f+GBIZWS;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=UiKYK2Zp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD78D606A333;
	Fri, 13 Nov 2026 14:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD78D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=f+GBIZWS;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=UiKYK2Zp
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADDRLKm1748241;
	Fri, 13 Nov 2026 09:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=JqQONeIKNvLS7WN3
	74lsWHrJm1wJjx6TpjeCAQTVmqQ=; b=f+GBIZWSnWvNdZVbW76PhLwOXzIXQLKB
	03bUrKE+FQA4mcS6raAtYit/j2ELjnRriUEB8RLFonjSZsSxV4b/esCd3GLg73Jv
	GoNic4k1Q+MhI5pyPLLls4T4Boi6OzYzYOfIGpjhxbqGxWL0nsajCTe8xOUT89oh
	i30JaF+kDClnZKSxw2x5RZSJ53yHFtuJ0sbAlaqQQ9bFG1Pw8hJXolbFmvnRAhOw
	MM1QoOQQhYeYes64jTQmlcgwbONiKFxNvrqDzdE48TN4kIbGMm6jZFBAN/EGj8c3
	BlkT9qRsTbOr7RiZorQeQAeMJKedVuSqSayp0nZbr+5WjOKGh0GX2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=JqQONeIKNvLS7WN374lsWHrJm1w
	Jjx6TpjeCAQTVmqQ=; b=UiKYK2ZpaLbIFJt2rIOr6SKq6EFnSHmfOR9Ism/PMjc
	cztvlIJLUpotKXExbfy+RKJjctMdosJgnc6ux4VI8QP85v6jBLtnXOdyjKbKYsb+
	Ya+M7SKzV2+VH6iuBFtIg1UHCQ02cxK3Fp0S+gO64uifVIKE1zvhI/ccoT/LQhJI
	l78Yyyq1XHwfCNrd9IY58uygh0ndF9f+Qo/0huu0XbPcfd8DXxNIwUuD6QottNt4
	AQqAhdkuK4ViZCHzaXCGAIZwXBgFdrZT3ag+AAdpdHZHJF3lCF2DEexbIBrDBucr
	Oy3O570pn++IbqXSPqJvC3gMMS18E6Ib0hmBJs5nu4g==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hwme2v59h-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 09:46:35 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edxV68ZRHkyAhJnbZ6ohl9IZ9AfQJumB1sn3qjZDzgVl1M1zVBwFoevjPbQrZLkOkclQtt6nA6b4XRhdBrW3Z0wuv37Fp9OJbg/zo3niEuwIVXXkEerbnBh5xdt9E9WxWL9ld6gRACXwIOgyZ5FrogWWaKlAq93+rRurW8aZLuyzmvnImKXFrs3cUiqHp4XGsbGrz50eb05BEpHFTfvrBGN2Cf7xP92pxkQP/NtMd893I2oRsSGBB3Cz3bjlW6rhuVToagAXmCLzvkIFgD7gZF1P8MlEcYcoFbme0TqM2AarO0ecsO93f5aQUS7LDv4SG55b+Qy1BRnLv/deDf7Dfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqQONeIKNvLS7WN374lsWHrJm1wJjx6TpjeCAQTVmqQ=;
 b=dxhksHTzzHraTEPJRTo7w5djpbKt3akTzpLBLKIzJadU7bnS8H2VjrcFN+LnyPpn6yU2eB6j1csbTc+2WKp8As8vvxFdFsRF2MSaZ79p7Gj/LCnr9LQ9GINP+NBY4sVZ7cOlcFoXYs1NjJKuvjtxxNyazbLbI/SVf5V2kBDmRFSvrlwmWmaqlXbZw2QvfCXBxSchQ/lExjV5DjN3gqH20hV7hM4Nyj7+kN/sPXsqS1YWbExX+VKmgFttRH1ghvKnQBhiYeGZBOfXjYpXTr4AHpflfhnQM23+n3PaV+LFlreHXd081kcrQTMu17IjlOKWiXAcHcOEio1KmMeOhGZf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DS7PR03MB5464.namprd03.prod.outlook.com (2603:10b6:5:2cf::12)
 by LV5PR03MB8387.namprd03.prod.outlook.com (2603:10b6:408:35c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Fri, 13 Nov
 2026 14:46:32 +0000
Received: from DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e]) by DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e%5]) with mapi id 15.21.0592.012; Fri, 13 Nov 2026
 14:46:32 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 13 Nov 2026 14:47:51 +0000
Subject: [PATCH] iio: dac: adi-axi-dac: fix swapped arguments in
 axi_dac_set_sample_rate()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-iio-fix-axi-dac-v1-1-630da3648086@analog.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM3QpAQBCG4VvRHJvaQZRbkYP9GYwDtIu25N4tD
 p++vveCwF44QJtd4PmUIOuSQHkGdtLLyCguGQpV1ERUosiKg0TUUdBpi6YxlSJrVO0qSK/Nc5q
 /Ytf/DoeZ2e5vBu77AaKDCKVzAAAA
X-Change-ID: 20261113-iio-fix-axi-dac-b7b401cb06d4
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, linux@analog.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794581279; l=1262;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=KMT2yFLS2/i89i+/0hg5k2yopX4wHtOvtJhuKgbmDzI=;
 b=O6TfxEQEX6237Ke1YJ8HgJd+jO9rlIkuShXmmnNW+etBBHWKfCdni8gshV65eqMCesL9/lopT
 Qui9dOXaqFhAUFiJe89Zr4XpDPYTCg2UmA/ZeL0Thc3BSKKFL7H8kFJ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: PR3P192CA0025.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::30) To DS7PR03MB5464.namprd03.prod.outlook.com
 (2603:10b6:5:2cf::12)
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
X-MS-TrafficTypeDiagnostic: DS7PR03MB5464:EE_|LV5PR03MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f46ca31-3bdb-4ae6-56d8-08df4194e8db
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|6133799003|18002099003|10067099003|11063799006|261028144727099003|56012099006|261021121427099003|261021123027099003|261102123227099003|261009223027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
 8NVbim9xdlgNYhp7JBdcrW+y/VB1MgF1lewc1UEyjzMoDkvIliTdWtfGrutyZSqabxBbn2XXNP4mHORIlttYPQrPW8wwPE4pgF7YUVUCH8ytUK+ZiPbrqnQuZnwBeaZ6ZGzawvyBih7cUfcXWm8bBQgmKkP4OAkk/fsE9bQ9pSETTZK0ool3V//Oyc8WAtZerZm5flZBWX3f/HZRr6gRoQrM6jlsOySq9xAWbqYTFeWC70uT34Zm8t7mecKgkOQ6xnAtSS+lNovNQyqgAE8dgkzBTbdUi15RftirJoAoxw1vg7cexfbIrd9Wq0iv+lpcd7O8MlhhLJD0/kPWvszZTNJ7IlxlXA2d5r0Yx56f14ATEfXLwH7EPNJiQ7Zal1r12ZTDMZKQ58WvjNZLJ2ES+BnLGch+U9LBVEjdbjzHWINEyq75KRqq+dCt2kxoGADtM2pZNzM2VUSZry5NVzfc/ffKtLQAhgaM97KZFTBXnNlojyWDgF7JXJ2ydGkGZPdM/WPF1BIDPv7mCRUPZgQmd0XhukwthkmbQD/S9DcG1+9RVfi6m/xr+j0vgGJ6HwYmLp7u0kEyomvzU4kNAdZQh98IPucOx9IG95+kSSCd3foqV2PuYgRNwSjjPOweDPBN+asw3Z5i/ddWgFarDD+/fmIfnexl0U2/by89AzX+QHY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5464.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(18002099003)(10067099003)(11063799006)(261028144727099003)(56012099006)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NVlteDJPVjA5QVROQVVhejFoUVJpbmlVbFZRcThWT3U0eW1CWHY0dkl5M21L?=
 =?utf-8?B?QkZ3Z1FFQUFuWDFEeHN0UEFJMWlzQjMzbHc4Nm5IcVJmVWtEdE9LdXVtQ1N1?=
 =?utf-8?B?eW9DbUtkOStMbThocXZ5dDRSVHM3ZVVrN3hpaEUwU0RwMU1MVnVCUSthdm9q?=
 =?utf-8?B?S294N09kQTJyemFNZUNDMFBtdFZnYVZFS0I5dW51QlA0OEtOanR0cnV6RkN4?=
 =?utf-8?B?VFltZkNKeXJkK3JDVjYrOVVIdW41aDNDNSs5TWV2clRTb3BGR2REZDJlTjJG?=
 =?utf-8?B?N1R0VUZaQlNXOHh1SkNKZ2pWaVdoUndzaHhoZGMzOTJRak5LbG0yUFdDMVQv?=
 =?utf-8?B?dkZZVzR6QVJhSnlML1BpZEdwS1l4V2xCM0haVTJKUUt1bVNQK0lEM2gyZ09i?=
 =?utf-8?B?clR5T3VZVHNpZk5Mc3FuS1ZVUTZPRnVKVzJySjVtSjY5MXd2SjVlTkZtc3Mw?=
 =?utf-8?B?ekZ4eTRRSjNaVFphOE5ISExreW00TTRIMjJrOW5UeWRuY2hyKzVMWGg3N2h2?=
 =?utf-8?B?eitvV3lsNFdQNS9Id2hQZzcyN2xISXRiZWl1UEh6ekE4NXRGT3RjMDdnNnhq?=
 =?utf-8?B?bWVEUnpGazFrRjJTQ2JnQVJhZSs3MVJ4NVErYldxcUtYbFpNSDBUaittb2RC?=
 =?utf-8?B?clJiaFlxQVhVY21RY1h6VHFsbFlGZjU3aWdXS2Y5SEczZC9zdnUxc2N0dG9B?=
 =?utf-8?B?M2U2RG5HYkU1cnVwck1WTlJnWS9xTE1FQ1VwenprMnEwUnFTdWltNVZ4NjM4?=
 =?utf-8?B?SFo0MTQvdzV0eXNKNWxIMlE1UmRETS9LaElVeVRraExVSVNZNHJIYXczaUx4?=
 =?utf-8?B?eis2N1pNRzd2RmlIRkRoRUJIbER2NmltWkQ5WFV5WnNjc2svWmNnWUtuS1B4?=
 =?utf-8?B?dzA5RnRRODFSY1RaYmlVRVhmZTJ4bWZwc0dZc1dSa0NtcnFCbGR2QVFReGpE?=
 =?utf-8?B?cFRZTXhheW94c1c1QS80SkF1QWhsRTFaYkUyUGEybitaRXBIY05QNjM5YUdR?=
 =?utf-8?B?NVNFU3B6aHowMFo2VTBmenNweEtZL01jUzZBWFJRWkVYUVYzTUlZRkJPZmJO?=
 =?utf-8?B?Y1djVVZOZHkrNVBEMUlGTmxiZmFnWWVuSitzQ2NkR29rSmtPRFAxSi96R0Np?=
 =?utf-8?B?UndRd2dsaWlIUm5FQlg5T1VER1cyQTJrQUZiME5mVnBzek9MZE0wYVhTaUl4?=
 =?utf-8?B?MW00ejVVYVpiOVFQZ3JoL1M4VW5mK2prKzRDcFYxcXlYaCtocW9iVWRmeTBJ?=
 =?utf-8?B?UEUxYUhoS3FMc1VaZS9vSDF2YkJTRlpta0o5cEowejR5M0dUK2tNa0p0MkFH?=
 =?utf-8?B?Zk90aDVPdVBHZTJjOUhyRFJib2t0REVTaEJVRWoydndoS3I5UkdkQThncWl1?=
 =?utf-8?B?bVVidUlBTUw4ZFp4Y3lhbWw2eVpWVzgvL0dnVGtidWZGdDM0TDV1L2M5Zll3?=
 =?utf-8?B?YitvUzVXSW0wQ3h5SUpzZGlKenNSUkhvdnIrdENHSWcxandJL1p1eU56QmVG?=
 =?utf-8?B?OXBRWHVESG1NN0NaamxjU05XS1pUcG5IT3VKNU1SQ2YyQWJTd1pKa3ljTkMr?=
 =?utf-8?B?Q3p2bGlCRWhwRXpBS242MUJaWnZMNWlWNzgxK3RwTjVQbVZaWkNhUWZuaWMy?=
 =?utf-8?B?ZkNlTXI1UHgxV0J2OFdhM2grOGNBWnN2dENHa3RhSHZBTGxGRVRocy9qb3Vu?=
 =?utf-8?B?UkdvTUhVd0NQaDR0WUF2alZoZGN2aXdibFNJa0dqWEQzS3NkdlZXVmRkWWdj?=
 =?utf-8?B?UkkyVThjOG1SdWdabnQzdTcrbDJFU2dTWXZEamEvc2FmWlhrV2xQaklMUUN6?=
 =?utf-8?B?S1puazRtRkdzSlVCbUdKVEs4cmVjWmIxNk9tVEk4eUFJR3dmc1hReTFEZE5w?=
 =?utf-8?B?UXN5TTNXQjI1aVVlZUlBNU96TVdCWVBER1I1SkE5Y1BRZlhaa2s4V010aFVQ?=
 =?utf-8?B?OTF6aHEwVUVILzcyanYrcm9UMm0vM3cvMEMrS2JMdTgxWGFpZ0U0S2I3V3ov?=
 =?utf-8?B?YW9tTGtTZGZzUUV3Z1RlY2tKMnRYRVZPV2pTZkt2YitQZm5qdndkdytHdlhn?=
 =?utf-8?B?WTdDcktOSk1FWG1lYW56Rmd5eGEyZTFCUysxczZUM2V4OTIvaE1jVFJ5SjJm?=
 =?utf-8?B?ejRqTEFqM3FEUzdsTzNqekQ1R2hNYjI2UkNuN3pLdTJnYU1JR1JFSExBdEIw?=
 =?utf-8?B?cml0d0EzMVVSZVNtUS9Md21YL3BiVnk1OXk3azlRUmRKQ291eTNUZ1ZXWlF5?=
 =?utf-8?B?Y1crcTJ2MnZ4QXdLNGxFNzBGOGhYdXFMM2JwaW1RL0ViTk41dmljUUlSTERH?=
 =?utf-8?B?UzQraElTUmsxVW9TS3hQcUJLTk9nTnplUHhJU3pPM2VMWllQRUpvZz09?=
X-Exchange-RoutingPolicyChecked:
	EG+CcSgKmyC/tCBBoxqy/ms6rDh4kLuhWsT7hkZy9OnFGQVGzNcyFKmrhDlfsUf8v6pXTwx6Dq2zgb5zWV+w3Eb5/ave/ET2zC6o+noZeO3uZY6f1xtnhfVRYRJi9F4hvHfGVMEyUjAx/16Jfzgtf2Nf4jigsQnGpF3bcZKjk2VoD7yGZmVRAyeKniUCoKEgWmrQD4ahHSxLtT/RtOAn4Kzooh5KO0q4FRtdiZLXN5XY5gUJQgVZXA6y9+kUTUY9aGJq/tC/K6kLqJBR3WFYny4SD0vbwJxkr62PLvVMGVDz5hiOM/61d2pzBEMZG2Nfy6V/LnJwX2SpjXman99uxQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f46ca31-3bdb-4ae6-56d8-08df4194e8db
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5464.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:46:32.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUZABI3ScZcjhQEF+YwNiNRV943IzAFyXUsAI86fLubr7sBav7NUGwoiotGUHkGTwjDP8EPjx1XbxdjB/gxUUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR03MB8387
X-Authority-Analysis: v=2.4 cv=LvkHWXdc c=1 sm=1 tr=0 ts=6af722cb cx=c_pps
 a=qaGWf3H7ZUycNCJ7m3WmPQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=gAnH3GRIAAAA:8 a=3laWudSKIJ_Okjtr4qUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1OCBTYWx0ZWRfX7pg156OBjb1Y
 QhvhRlj6VAhTKNnKKtl+ZHeg7m8KI8NeF4sfF1bkObPbijBbuo632PejtJ7EweRVahujhpJZh3+
 j42i30kBPXb90np90wJHy7hC0PmqJHeC3wEWvFHq5f/cs54pEPiUbmRiEU9MVdXaZNb1aEfh5ik
 UyX8nmu+gC4eJ+RO+XlU3Dfrgqz83bC6qC9oVlkveugJ+wtCmDJnV5bBfvu9CeQ1a+CkeVAnTfj
 d/bfiItaYJrkOUK9dDb63mmEXRpJpkIvf6nn9VjWalrchM3cADJZjkPzzEQJ9JehZQXADDx3R95
 gjqO+AdNkjcCDzWN77XwGM0Oicqbo8aflB9rj5NM3qaPv4kJwVtLr6eq4OPYT0v0Zj6ymKSq7Lt
 e/nf2JmHqLJ5nF4QJLTYp4O71ZcsuM23+2C/QR/1Xg9PVsRwzaab+NnA65gLLnep5vxQrMGgymv
 DjB0La219cqZBE6IrAA==
X-Proofpoint-GUID: oskOVLF-4hTqXtZaWyAigf96o1s1f2iC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1OCBTYWx0ZWRfXw3QyO8s/dmyL
 QJEG/IB0CsSDDpOOdgEUxOtjBVP8IIRdd4wT0s3rVtNUz/APuYaf3W0gC36FMnRZHjFJWjM3kOf
 IsMxzP9RDnY+R1JYmwW/u96t7HwfmBmQQ00hQUvf3e37XNwE17PN
X-Proofpoint-ORIG-GUID: oskOVLF-4hTqXtZaWyAigf96o1s1f2iC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130058

When the interface sample rate changes, the DDS frequencies of both
tones are read back and reprogrammed so they are preserved against the
new rate. However, the tone index and the frequency were passed in the
wrong order to __axi_dac_frequency_set().

Pass the arguments in the order the function expects.

Fixes: 4e3949a192e4 ("iio: dac: add support for AXI DAC IP core")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
AI was used to generate the commit message which I looked at and removed
the extra verbosity.
---
 drivers/iio/dac/adi-axi-dac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index f4f3bc67c68e..1e2f7f27292d 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -596,7 +596,7 @@ static int axi_dac_set_sample_rate(struct iio_backend *back, unsigned int chan,
 		if (ret)
 			return ret;
 
-		ret = __axi_dac_frequency_set(st, chan, sample_rate, tone, freq);
+		ret = __axi_dac_frequency_set(st, chan, sample_rate, freq, tone);
 		if (ret)
 			return ret;
 	}

---
base-commit: b70566610b48ba49dec636019da4d696db64b085
change-id: 20261113-iio-fix-axi-dac-b7b401cb06d4
--

Thanks!
- Nuno Sá

