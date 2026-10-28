Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793180113;
	b=lY33DxTFqukjDImXl8aaNjRIRljn1S8nui3Y+xjje7vHwr3fzEKJmUUnyfzkr0IY6XnV
	 yzxZoeqVoTFQVRszQV8Spla3tYX2bDeSC6nROvhW2rOlNH6H3pPOFEqNFAWgaK69Gkwut
	 JtSnWRF5XOO1yZChFtzo54bvgrxGZdR2YQqZWPGQbL49s2RuZ+5rddfMs5llfoHW8TtZ8
	 wNuKff9cyKqLUY5FvZ+ngNLXj8CwQ9sXeJ6iyXL6PGQ533mRlGDPkogj57ZgIVSjZZZnk
	 ZVzBf3BBYJHw/bUBOES3fCsOL7ERPzjvgcNsIk+vQtZvqizTJcyYX99t8E77sSUpjqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180113;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fWvXYDOpEHhTB2+IEEiUh1a9Le5wO323C4KxdTbdPw4=;
	b=3fTlb6Q5yP+YdbQzAElsAT6JPXGhz7V1PQ/PYP7XyEVZQM5xQuV6gxiG4pXWx46b2KCA
	 FnUXZCz3FIhaH4ORb0prnWMEVA45vxjR+7YNGZp0ICAWEok6BW/NKk9iQs7gp1K9sQBwV
	 jbioOiXVqMprnkzxrBkoQOStsRWSpnKRoQRxn63/FTINp7wG8EJ1veVI3lD315DJEHtFY
	 QA8rQ/3Qx5Rg95jnL21RNvnYNM9oo03zscZATRfqbibyF2/XXvYpSOfM0LNvbsSnorqJZ
	 l9JLYRxNDUwRnPervnwJbnuxc548B5tc3kRym/EdvMbA49Ub/7Ia9y3NLGHSymunFHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=gk9b4PjW;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=AU94jNvX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3BA606A31E;
	Wed, 28 Oct 2026 09:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B3BA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=gk9b4PjW;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=AU94jNvX
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8Htjo3102480;
	Wed, 28 Oct 2026 05:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=fWvXYDOpEHhTB2+IEEiUh1a9Le5wO323C4KxdTbdPw4=; b=gk9b4Pj
	W28NbKcwXI6t4Oyij/sNMFqm/UKi4Q+vEHhPHS0eeyZlGWDzEFUT4qUSgUZttfxQ
	u86Di0YcSRa8mLqvQ4+w9KdlfsgtutdtSyqvY6wgURLNTOEsNs9UQSpN2QE2LwY0
	q8mTE9jiyWpXGcVooqA9+uDkJopMCwOBKefF8z2AGtg4vXLprl+nYbajzBFYGPwv
	FKaPkMpKJcu5Tof3gl1lfsDnn/KPJ1hvC+vv901n+uLm61nQuKCnM1cZcT2nlhwJ
	UjhT2M+UUqrL5CuUv6Vd9kJG19KDMpoC50CODeT9kvHR6sAQ5JZ5sxGYOczTkkEj
	4MMdE0eyJ+LRSBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fWvXY
	DOpEHhTB2+IEEiUh1a9Le5wO323C4KxdTbdPw4=; b=AU94jNvXnjSi2PJwRMd1J
	VXuNSVwYYc767l2FO436ehOzpaanvSd08islzdkjGqgV794DZaVt/sUbWG7L6aN5
	eddPPuBFwU1/J83NQjjbFcJTjDzvbOxYJ5s+n3h1uquzShAS5NXIdu4SUIzQzT8b
	QO4T0e1REC0azGQZViUgWrjO0sv/UIn6MlMbH34GaBEpyJXVjwOCG3udwPeUcwWS
	bOpQkZZHkYpd7ExTDiK5m2SLu1JMRnihKY83TRA2vVrObCK5pzT309dWwwBRY3Xz
	FSZv+w71rLuGSprTgq6gIq4X2/cjmWKjPRjOAyTIpkQ3Wa70vmS1xuhT2Fbcpzrv
	A==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hjjbjs8t2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 05:35:05 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAY8Jav5dtaQj5x65TlsuZ36qvbOmNW0OrN7uOE905BGlE19u9bVeTs/DFmh1I2pTnqPeHLjq6VImuAyk9PA0T2jZcFUuyjmObtEbFFfpHjP3bNK72SRje54KJN5KOXqYig0vKrjklVgLfjmqGklkNbs8fYe3P4Q1eDz9DBbvx7b+vBlNGGqG2uXV0k/eWAlraF+z8sFD5+svMT+iJFmKrFbhTsLrfCcSQC/S4Ar08wFpKUBFMAv3D0oWxMYv6Ww+fQHBw3oV6xf7+UT3Zi4h0mEngEWlDIdWmmZRUGiyzNjPGmeNlEEbuiRByfVqjslE+iPMqPbq3wCR1uhVAZYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWvXYDOpEHhTB2+IEEiUh1a9Le5wO323C4KxdTbdPw4=;
 b=FCIDNmivKiD7WWhYfCOv/pbJVv1R2C3VficXL2ZeDgqL8lVi4aADQtflKJjw2dsPtxJB6u7+FE/oWl9345yJIMOoxb4EsrFtsR7Z3vpl7VYy+qlIn+EGK1ndsWc2b5wagEqP52EP9M67ripLkE/Lu//PihOaOc8pD7AMicqDAUszJiO+BnTDo4szgr5oFimKenJbaIT8pamCQbsneDSeCGRvkyVFxGzakDP+pGQktSvTfl3oh0s6WjH/YIZ3/p+V0OHcekFb1UD/nWGohBJU0wjSNuKWXCDA2BvrINlAizEnzNRflZVQ8YlnmBsBj6QpHLDbi5BlozcgZ9PJFvKaOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH0PR03MB5798.namprd03.prod.outlook.com (2603:10b6:510:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 09:34:29 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 09:34:29 +0000
Date: Wed, 28 Oct 2026 09:35:52 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Edmund Berenson <edmund.berenson@emlix.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 06/15] iio: adc: ad7923: add the AD7927 to the SPI ID
 table
Message-ID: <auHBuXD-rgDoIzSu@nsa>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
 <20261027-llm-char-misc-iio-v1-6-0d818334f6c7@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261027-llm-char-misc-iio-v1-6-0d818334f6c7@linuxfoundation.org>
X-ClientProxiedBy: MR1P264CA0141.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::15) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH0PR03MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: cedfee09-796b-4cbb-7139-08df34d6aa24
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|18002099003|261026121527099003|22082099003|56012099006|4143699003|11063799006|10067099003|261021121427099003|261022075727099003|261009223027099003|261022113327099003;
X-Microsoft-Antispam-Message-Info:
 Jyq3GU7xnuJm+8/ZItuk/8utu165jYnKIrPV4NbqMkMpG/+7Tki/u4vYbGyT6ZN+zCydntNr8N1SIJ/n2unK8lbU2HTShBg3+u7DngD0DBv2cCE5UP6hlnGVncx2GTy2IpRUXNb1Rw28C4DxLWzS4ZqKzQVODi7CWxSAG+bD2HFq0BYzFNuksQIPU/ZibkSzvQ68i7nGBQmUKrtmyzprjeDIyjZJr/k49E8lRP4qLIIoAg9bR5i7uOGalVoirFMmxjEjaeBtCqLVq8rtlgZLyL8/O2gHHDrhRqzPKfDK7PYsUVRVY93jdICUL05mHuw8ZgkTcQvVjMRJTWcv73NaR6HHWMuBBTa6YTZaWznxLkrNQmWFlyhO/t5ZZmRxAfxiJL4FLkZTOawpth8F/cVxUXzhu2y0Lwognn/hJ4gsgtbsLxyKKiwd9fFRoUHcvOYEbeZ0q00l7irO9Iny2zavbv0QKLVh2QbtNN1e8aPHKOOrJehOgq3+xJ0sbTQvqz9bwy5c5MpGllWJoFcAINfPpbKWVQ8s4JcQ4nHALS6BDUlhVVWNzjXMbe3OEZ3MQE3VL16fv+LcOHZiam+VaYCQi6w3qthfTSeS9YOCjg4WEhWU6gqUHxmLLCjJQz4qVJt01kMOgfJg0ggM/jeYP8v6FRf5SzzMqwSDJqDLY3zXXWE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(18002099003)(261026121527099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003)(261021121427099003)(261022075727099003)(261009223027099003)(261022113327099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MEQ4YU5RS0x1SlYyeUVBMWNYTU1KWkM3N3l4S2pjejBNRnNBamNNSXJRZlpU?=
 =?utf-8?B?Z1RYZ2x0M0gzclc1cXlzb1crcnZPN1RmYjl6ZmFxWGJwblFyd0tST1huNVl6?=
 =?utf-8?B?YktmU2MzQlVEd2FDeGErdURWU0d1NVJMNEN3Skptd1RhQmhpSVNPbnVUN1p2?=
 =?utf-8?B?ajJObE5KdG15S0Z4SmNFaFFOQTQva0thS2plLzViSm5oMVhsRTZSeTlacmV4?=
 =?utf-8?B?SEJST3JDZzk5S1RKanpkVVU0MGZ5NzN0eEsrOVFzL1c4VFVkOUtLWUJGWkpG?=
 =?utf-8?B?QTg0ZTNXcUdWSTFOWk5idDJ4bkUxVXlJMWtLVGI4aGZTSHh1enFvQjZjWURF?=
 =?utf-8?B?OVNmRkJJMHZMcFJEUTVrMTNZZWxFQ3BtTndoeXE3ZXpuUm91eEMzUXBHdFZy?=
 =?utf-8?B?VXNSdUt4S1Z3Nzk2TFM4MVJ3U0pvZ29TdlMrSE5BUncvK091eTFMckMxR0Vq?=
 =?utf-8?B?Sjd2aEJCbWxpclBRejV1cXVuOUxsQXhjaWUvUmJmZDM4SWlKZjFsOVhWazA0?=
 =?utf-8?B?L0pLSlcwTkszU3lHVGxKaTREalBJdEdmcXNLQ2FtdVRuRjlKcHJTMjNGMTUx?=
 =?utf-8?B?YnZha05yaUtUS1pUNGloMi96WFlkNzhaSEx3eDBIdmo3ZXc3c1FyV2toU3hi?=
 =?utf-8?B?RzlRMDJCZlJmd3lHa2ZyZGhEcHVBSk10UFIrbzM1SG1obXJRZVhONk5QeG0r?=
 =?utf-8?B?a1RHcXBCSUM0WTZCbUpaUDBpaUluL2hhNUNwYmJ6dWhTOWk2VGNweG9tbWdK?=
 =?utf-8?B?MXIzR1puSlJZQjdDWWt2U0xsZzdlckVEMzZVQjRoSGV6cS84T3ArNzR0SGxQ?=
 =?utf-8?B?bW9JQzVROTRlcXFLM1d4ZlZSQnFsTXp5VW5WS0FTVDMvRmhLNzBYZnpYaEF6?=
 =?utf-8?B?V3l1ejl3d2ZUeGhPUjlIeGJrY3BDU3JGSm8wZTFNdEFkRzhWMU9RcDN4N0k3?=
 =?utf-8?B?VGpSSkpCRzQwUUtYcGFGS2dCSkxTdnltYlRrY3hmQzRPV242NjJxdklLWTIw?=
 =?utf-8?B?dDhrdXQxY1RvWklMeGRQdDBKMmgwbCtieW00QlUraHJNTDVVMUpPSjh5aDFx?=
 =?utf-8?B?R1RsTE16Q0lwVFczZFQ5WDBGTFpaZHo0R1BKZmVOSDNPd2t2ZGNleE0relpr?=
 =?utf-8?B?TTFaelFSWXVCM0RFUCsyZjBOa21GRHp5OURUcWx2UHVzNkVtU2dPYjk2SHFT?=
 =?utf-8?B?Nmx2TFhPdm5MWitiOGZKMEtRRVFwVTV0TjJjMnJPYnN5Z1dtMFFqRUtacks2?=
 =?utf-8?B?K3ozNEpnVEw2S2FjM3hET051QkMzMmRtNE1hdElhcWdWcmZHOEFXMVZud3dK?=
 =?utf-8?B?TmJqK0RaL2lJTWZoOWR4ck53T3Vsd1RGbXQwWndHakZXakc0TGVla1diUWFw?=
 =?utf-8?B?clBKSUc4WnEvY09QL2puZWNKWVA0bUc0Ylh0UVQ0djRCRDA3MTdQS3BRK3Y0?=
 =?utf-8?B?NVRreEtHYnRSVnV5R2VjMTZia1hDS2FMK3ZGY3UrekpwcFJFNExQaDYwcXND?=
 =?utf-8?B?M1FCVzVjYWQ4YVpCZFJ3b283UlczQTdGWG9MOVNCYTNmbU5CMjB0VUhaQTcy?=
 =?utf-8?B?RVZYVlVOWkd0YkVCcGJLdzhyMVR2UXJjcmViVndiL2R4NTl2ZWljVzM5bFVP?=
 =?utf-8?B?MWx5REs4UEtCZkxic3ZiOUlGbGtHSjBQbjdRYWlWS2lnTVFNVkRKVG8yMUgr?=
 =?utf-8?B?amlNYVFjNnVoZjd0eHIraVUza1lJaXE5SnRDV1YzMktQMHNYMkhLYnl2NFdD?=
 =?utf-8?B?VDFSRUtWR2FTZUZ6Rmw1N0EzaUFmOWdKSnVTNGVleGlEVkFablJuQ1NxMUx1?=
 =?utf-8?B?L3A0SzlxbFo1MkRLWEJMWEh4WGlBZ05LZURSVkRvVldoSnlWWHVoK3VzSE9x?=
 =?utf-8?B?UWh6TFhpcVVCNWRMbG1YTFphb3pGUVhoVTJ1cTRoUjY2Snc4SmcrbklMVllW?=
 =?utf-8?B?U3ZqWEY3L0srTDljTzRtS1hrb3lkd01xQnN0MGVTVUdqRmd1ZGx0SmRlcFY1?=
 =?utf-8?B?YzJqVFVxOEw1T05lUFB4S2VQWWRFd0p1aXI2WGlaa2JMeDN2WUNRU1pKOGVs?=
 =?utf-8?B?SjBWb2NqMnpTNVoxWlNmQ2l4YW5nQ0VidFIxVG15cTFSem5FOUluRVVIdXla?=
 =?utf-8?B?RFIzYkFsTG9mampTZ1V5TVBJMmJXVlVYNXFaRTFhMzdSOTk0U1J3TC9oZjNG?=
 =?utf-8?B?MlkvNWZGTjgxTnR4bDFURUpZV2RILzhwdzBXTVUrVittbUV2UE9rdm5qaENk?=
 =?utf-8?B?NUhyd005Q1B0YkxsRGZlVUhJb1Z3eW1IK0R2aE1XV2c2RXN4VzBpdmQ5dG1U?=
 =?utf-8?B?YmRWMnRuaGNhZERNZHpCcy9TYUxLT04xYWFybzZNVDc0cnJ3U0twZz09?=
X-Exchange-RoutingPolicyChecked:
	DjhKm+jLj7pmnrih/6HP00JP5qrXAMX2RR2Cpj1bhQ6oKksTROw/AJuzPJwqw4VbIDHUAogJxzA/XklMqbDxUQgkyNc61Rk0akjCOnpprv2MBL8qsLwcDYiGHUT3iulOnHqCZpVvZVnbMTeB+jH6c8VEvV9C9wOVIHnJ95kO+3ee+Lg+wAhtRMTnbKKllJBtG94JtvCSqglrDXFCwfwjOQ/BWX2zV+pkdwgd01azUuyooNjXLsTn7xf4hMij0xOaMhOhiZu0DkPI7sei+P4Zgb+rejPYZ7hA1GOStuKH/jtYunSP1DtdtEqbf7wxgcbh/AUlJdZnDkg+Jqv0xYtLvQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cedfee09-796b-4cbb-7139-08df34d6aa24
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 09:34:29.4542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkVbxgAKiEcWCqpFPxpq8uUU/32hXRuz493uFnWHKlg0xWal1DN4tP+xpWsNIolSsoMd8ComAebQgws2NjnpVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5798
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzNyBTYWx0ZWRfX7jEDXCnPgkIj
 nuaQzrNwTVJ3MXCZ5qbcUm6/Vt9lJ1Y6fhtOkMRV1Q/0mo4oFW8XHFVYrm40RjxecQSWx4cYqn4
 AIkJtUMslps3SDfQ4zuZtBgVw68fD+fA/NZ93vsKTsJJmeC0vdfp0VURRaO5gsHg/u5AkQncymW
 3o6/TcuqsNcso6XOGd0Iv3vev5736Pmm4t6Mk5utFknyR1oyy9Ut8AYREGBrdy7DNiTHDY0S+w9
 M5jJsGOXO40QVQHxnCjhQHLoDNTmfCH/3Kd44CM3fACNZdH9BPvgclypuWvxd6/or5+859MpwLa
 1RZWvA0LK8wWLLuQytQmDv+n3ES/JpxHbxoP8qyhArnYr7KamJ6w3rEuR7mIhpEh4a20k9vFZzF
 htoDQ1XqoXBO6mOY/zLGWiRwxewyyh4+uwUXpxeXcf8G54MIa3I+PhGxytaOeiXHrr5KxqUKtK8
 kTDin6suUhRu1mo5fvg==
X-Authority-Analysis: v=2.4 cv=btPZl0ai c=1 sm=1 tr=0 ts=6ae1c1c9 cx=c_pps
 a=H9d2Io+6O/etw3jU54J+0Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=maIFttP_AAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=-3QgrcovAAAA:8 a=ag1SF4gXAAAA:8 a=CKKaxu_BevKv6J5ghRUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=qR24C9TJY6iBuJVj_x8Y:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=sID8nOgl6N6ptD1j8Mz9:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzNyBTYWx0ZWRfXyynjyHHKM6m8
 h1omcnJQMR2LsXp9g5v9umTJbkp0B+oVbK+ftTaGa34dmd7bUCyXIVUYBlUEHTz3CibYYI0nWQ4
 hgRUSDh4+MJNsUODmwXYB3zcXdEoyT+D/nyj3me2TDwYBX9Aqzo/
X-Proofpoint-ORIG-GUID: 6yX1RUAK6Mx9W_fGSO-H_aPbTyH6YdgC
X-Proofpoint-GUID: 6yX1RUAK6Mx9W_fGSO-H_aPbTyH6YdgC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280037

On Tue, Oct 27, 2026 at 05:19:10PM +0100, Greg Kroah-Hartman wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> The binding describes the AD7927 as
> 
>   compatible = "adi,ad7927", "adi,ad7928";
> 
> The OF match takes the second string. The modalias of the SPI device is
> made from the first one, "ad7927", which is not in the spi_device_id table:
> spi_get_device_id() returns NULL and ad7923_probe() dereferences it for
> the chip information. The module is not loaded automatically either, as the
> uevent of an SPI device says "spi:ad7927".
> 
> Add the name, with the data of the AD7928.
> 
> Fixes: 1140f96cd4af ("dt-bindings: iio: adc: ad7923: adjust documentation")
> Cc: stable <stable@kernel.org>
> Cc: "Nuno Sá" <nuno.sa@analog.com>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Edmund Berenson <edmund.berenson@emlix.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/adc/ad7923.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index 44e014da9722..69fafb4aa4ea 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -366,6 +366,7 @@ static const struct spi_device_id ad7923_id[] = {
>  	{ .name = "ad7924", .driver_data = AD7924 },
>  	{ .name = "ad7908", .driver_data = AD7908 },
>  	{ .name = "ad7918", .driver_data = AD7918 },
> +	{ .name = "ad7927", .driver_data = AD7928 },
>  	{ .name = "ad7928", .driver_data = AD7928 },
>  	{ }
>  };
> 
> -- 
> 2.56.0
> 
