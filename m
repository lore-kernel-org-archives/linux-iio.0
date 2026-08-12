Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABCA40F75B;
	Wed, 12 Aug 2026 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527494; cv=fail; b=t4CyNftcjCslRPwH5FE3ntsRbF8qTAAz/WGDs8mZc3jJLMey04kIHvKDfNfuUOhWyVmoJV44o3eQZBH696wS7l53v7HSCftKdwXlpJwop56scSVmkXr+36puMLdv3YXk+Cwytde4xSzlWIjqoYs1zk1mpn5iPpi32Dz0v6jAL50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527494; c=relaxed/simple;
	bh=zT1+Dmi0TGQWHmaRIKY/ouz5TSxUHubMohJuQ8HVtpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HKrrWH5myVogWXh+J2kVhZ7E9X9d/as5gCdw6r/yJtSIRlYP9rqgVH1olf/+r0fyYsoUIsarTIcaNxJ/K/bUTkmhRmQLV0yDirrkvy5vS22kIfEfHNIU4nBqFLZseDexJEhAMRgqfWDdbCtudXa1PU/toV9Vn+lBv8jvJ/aKsk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=x/W2NeDK; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="x/W2NeDK"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C8nxNO4083232;
	Wed, 12 Aug 2026 05:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dszx+
	OxEktul2rYqZhTeNu5uobmluN0aJLBjRxyNUmM=; b=x/W2NeDKqWKvntvfdGvBR
	9MUglTIB7VjUvIiWyDpotYb4uhSwyp/0+SDnHXv2ex0kmSyR8hb2NtUi3jDOzm3S
	UXGQ9GkCEu2KnCVS+GUtG6pgJgn/mkHCW3LUckcYdhUnAHehGvY7uU5RQQKXic22
	wKEqgEDWGtecjkoeH8eaQJ6Z+6T3r6IA9t5GS6DeZduvDflNVYbHOTg8Y1wyn1B7
	k1mxXfmDcU2NjfE367+AA9n7NQSLw7UTsrAyjI8i5ueOznQ3bhurBoYD1LOG9DUt
	vh2I8c2rcoKb2bdQtMnC9mtR+u9s4/Bw9Kv3TzOMLqA463vmx5y1rAA69LL0SsV2
	g==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g0nnw04dq-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:37:49 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRarMXR3J12zdg5OQnYTwiHOWDAEbtj3Y4hKLCztQ10Ik6PzHiLIDnDSeh2kX1ExyVvoKq/5WNdwxA1chNvYvtqQlqu48n1bhMQ4uBtX9EZInLu0g403bevtcmXSy2HASsdK/sC0aVLv8EU15p1p9LLT9bRNWkL5q8aoLV/j/LfWBOWeKsrm3JgnwbtxErH0aKDflJxx7/Ep0lgyVHvSTOJl7V3jQsmCCHjYvMipVNb14VvkfDG9ecg4qJPCTkOmNqU+svAT0VAkQDq6jZ06gmlOuWLxEGmV7sLuhwqKZorhFc4/HHspW2SPGIUuxnFg4YEMYnB5rZh/r8cT67JaXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dszx+OxEktul2rYqZhTeNu5uobmluN0aJLBjRxyNUmM=;
 b=YhE1ydp0yesoK+mH69BPFBFT3SIrE1xNGRfoTfECfcroDpQy7SymqkSpHlkKjYfE+Kc4RvS1pGDUi6BS5hsWHKt+0Le8mp7vC0+gp/7k1UyutHDKidmuJ1HHlqJHt4VElzp4C6aRrlbFeJFS96US3T45bcbeOetP1XSHj8PU6qsBEGkEcbM5VfbDCyEBNSkTaM6CziPtWSA/fjZXe7ESTj2m2xDWxuM5Geylr87hRDq/LP6aH4CpvV092E8fJCGGn8KlFl105ieLertsyQ82PKROE8XwERMIOB6mURNU07sPGC0BPdJuRHcVdNzysLXHJP9ZfREpTGI9MlWJKEpYdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS0PR03MB989595.namprd03.prod.outlook.com (2603:10b6:8:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 09:37:47 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 09:37:47 +0000
Date: Wed, 12 Aug 2026 10:38:57 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <anw7veoAfnBrmKc7@nsa>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
 <20260810-dmaengine-support-wider-dma-masks-v2-1-1f7b798d035f@analog.com>
 <anoHMANpRU744hPp@ashevche-desk.local>
 <anrgDskNdV7PG-T-@nsa>
 <antirKIhG8iaMqNv@vaman>
 <anwwrvNLP2OujnWd@nsa>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anwwrvNLP2OujnWd@nsa>
X-ClientProxiedBy: MA3P292CA0012.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::16) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS0PR03MB989595:EE_
X-MS-Office365-Filtering-Correlation-Id: 697f97b5-60d6-466d-bb78-08def8555e74
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|6133799003|10067099003|5023799004|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 13fYLoLxnHqnXdtej+/vqDMLF23KkARENUinaMyUqloCfqhdnxu98/fARozQx6BrBVAHFbco938aChuJBIcfYU+bOB1/65L6JIFthZ7wDeOsFNtm3SoN8ZIaQnaaZzF1XGgkA6Hg1CJmJDqzgs101STgi+/YA+n3S4s4ijisGc3HJgyx0ePrOZG9VRakLYLoyXdGrIle9LlAVbUx7yHciksl+u54iDEGVXCUPfvXD9CwWDxsFm/cvE3Qiw2rcl2DPA1aZhFwNfy1+MRMXr7xGU3pm4n7SHsoOUB0ntfP3ctLWceNp/+8/7IsN+T0gC8W1IOB+cxPM2rN76gL59iFj+3oB70dKsoel1RdKCpnRpPevMmx+gTwv+oXDzVZw9zj8rN4J0AEt6roJCxMPQKlDzSg9GPnO2XqQdU5RYlhN6Hz+GrpkJxQ1mMuLkOuOEVYy11sqVIJJFVDeIDVaef/7oWEgdJPwvi5H/GEsBWN2zVTv6VVmnE9RUn2Pt90oknraja2jUWoCmD09LH4wyy4rkc5EbDkZsrv/HuH1boIGkmWiHpgarJUNisKdSAd5EmJHCj2ICx7GYQ3Bin8+jonivcaWev3mYvQr26f2ICAYyCSdX18lnjA4hMHKV7zsbCpSYRqsqIvgi+lwGqsXs4GwFn42Ph+g1pF68BV9G2Db1U=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(6133799003)(10067099003)(5023799004)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dnJVMWZQYWpMWnk3K0ZkbUNBQS8wOXhKNzNMUGdOVUhHLy9kbFNYMklrcW4z?=
 =?utf-8?B?REJCd0s2eDhTVWdsQWxLZlFQSXVVV0FCclFaVHpSRldoZ243V1RCRzVCZVFy?=
 =?utf-8?B?UTFxMGZrODJBZWxvSXZNR0Y5b2Erc0NvcXJWQWJ6SlZSamFHWFlWbSt3eFNC?=
 =?utf-8?B?b1dHMGtxRGUvMS92L2lTQWF1eGRZUGFDS1VmSTFGL0FnZVcyeVlFU2tOL2tr?=
 =?utf-8?B?SnkrQXNjcnc3UE1CY1kwZzBPN1gyT0hqU3djbVpHRWpGdmJrTG1mTFc5dkdN?=
 =?utf-8?B?K0tSYUZNOVZWQ2UyZDNFT2VvVXVESFZJQVFNejAyU2ljd29tYjVWQ3V4YVgz?=
 =?utf-8?B?dm8zZURvOWtubnRhdzlwUnloSUppbXdxS1VJcngwVXVxNDNtQitHQ1JRUm05?=
 =?utf-8?B?dnYySE16WklrdzA4ZENNd21vdGZMUnRBS0VjY1VRUEZoWURLV3JuVnVVMnRJ?=
 =?utf-8?B?eXBrSmIyZWZtc3JkL0F5bW9QNURtRkRhbENVNGdWRU9ZaXRnL0ZXaExEYWNh?=
 =?utf-8?B?dVppM0hQVlYyWnppd3ZUdU1WeU4vUk1hS0RRbm1LTksxcGhnYTZVVXV0b0cw?=
 =?utf-8?B?TlkremNFT1VkREFDQ1pVeTgyVWdkTXRxK0ZXT2pzVHFudlpSR2JsT0pSOXNF?=
 =?utf-8?B?d2VSZmNCV3lkNkZRQU16dVd6dkRLUVRXb1ZiRExHa1pDR1RPT3ZHWDF3OEE3?=
 =?utf-8?B?dXV5QUpzbFdBUVRUcUptYnhaVkdIMjFaa3F4UTlPRmd1SDl1T2QxN1djTkQr?=
 =?utf-8?B?SlpkNVpHU0VmZ203WW9HQlJRdVRzbGJZODZQbVFTci8vSHBEZkFldE93dE9u?=
 =?utf-8?B?MlZWejUwQzlmMm9vVlNub0F0VWtnN0luR1pTdWUzZVJHaGo1aVhqcHZmazJZ?=
 =?utf-8?B?dSt2VEZPVDhTdlczNm5UamNBeGI1R0IvRDNxZDl2cmw5UGVZQ1NaMmhldlVF?=
 =?utf-8?B?VFJZdUpsaFFNMzArQ3BEZzQ4SjYxVzhVYzdFeWNHeXJ6L004dTRJWlZIRHZB?=
 =?utf-8?B?TWxXaUVSRXJoUFN4SzRMbnRONGhqU1M0bUhZWWVIQTh6OVFxVXVES3pYSkdh?=
 =?utf-8?B?RldzN25HZzJZS3lRa1NrY0VtUDVMNCt0OGJ2YnpSMDArdHFqUkFhYUx2OGtW?=
 =?utf-8?B?OTZmTk9Za1l5RlBZTlREV1FkN1pWb0YyRUwxazhjZjZzSk16Y2pWTDFVR2dD?=
 =?utf-8?B?MGhDOEtHWWxXZkVJRHRsOE1wOS9WcjRJeEN3dXJxa2VBYUkrM3ptVE5LcXQz?=
 =?utf-8?B?UUVVTGNVbHlYL1VzNjdoTk1kbWp5Q2RISzhFdldoQVAyMGc1OG84WnRqeWt0?=
 =?utf-8?B?TVpJRGRlYTYxZVFrNE9JQ2NleCtLVjhvaVNKODRMeE1BdkpMc1JGeXRqWTRI?=
 =?utf-8?B?WDdUM1dzUzBycjVEOWZCQjhpMXYyRFpXVW1DcnhHcFhQemN5a085TXd6elNR?=
 =?utf-8?B?RkNKNVROTzRnQUp0Ykk5UytPUml6UzhmS2JnMUZQOHJ1Ylk2VGNlRnFQUUQx?=
 =?utf-8?B?eWcwamF5MFhRbTQzZWRpdEVSTy8zNXJaUFZlQ2txSTI5SFo1VWFxK2E2R3VI?=
 =?utf-8?B?UFc3VnBuaWxCdE5QUCtDU2N0R25lL0JQeGpDSVEzZEcwMGpBS0xTbjJCTkhW?=
 =?utf-8?B?Vjl3cFNSK29OUjRvRXN0K3ZyRzFuWFdNSWFNQTdGRGV0eWVzajlKSjgrYzNq?=
 =?utf-8?B?Z21acWVjRWlFblRIMmdYT01pSzdoVXY2WXJHUkxUcGtoVkxzSEtFREJwNVV6?=
 =?utf-8?B?SXZhWGo3bjhHcmFJdFpFSXdnUGhSbzVrelR0WFFtR0F3RUhLZjMvZG9Zd1lk?=
 =?utf-8?B?Wks4cGx0dFc1eXl5U2pWV21JUHFSN1NOUGd6dFNvMVRGeWpmOXdZWUNiRHdx?=
 =?utf-8?B?R25YU2N0UU1ab0NoTHZvM2NxMzllbExnNm1md0EvdlBvZzlKdjYrMVl4VmV6?=
 =?utf-8?B?OWNQeHFRYnFoZCtZQmNIUndKZ25PclZPUTRobzBZMFhtNTlBZ25SRjBSUmhW?=
 =?utf-8?B?VmV3c0Vyb2JyMUI2S3RJREoyR1FTaktycGRIZTRHcytLNE9mTE1jcVFsem1R?=
 =?utf-8?B?WTdhNlA4aGs2U2FSUGtURElCMEl1aW8vUEhOKy9Ea0tWeDM1SXJrTzJ3WjFJ?=
 =?utf-8?B?WGdaUW5EYzRZMHBUaUxjNEN3MEorSWluQUdvNWpCZ0E0UnFzZHRGRzhLSzZR?=
 =?utf-8?B?TnNyZ2dlQVEyWmIzMllRc1hQUVIvTUIyU0NaMjRiMTRxUTdsb3ZldnI2SWo1?=
 =?utf-8?B?TG8zdVZ4OUZFdXJzY051Y3ozNEYrK1NwUE9NOTJLdVZGZ2E2WDYrR2dVNEdZ?=
 =?utf-8?B?d1FFTUpMdTRqeWZmajdiTTVndEd0YWhZdGJoWktqeWQvSDUwRWVOQT09?=
X-Exchange-RoutingPolicyChecked:
	KFAlnf/hTak0PAO+zw/qyUdq8svraddtmYIj4Zsq1Xyy2qE/HxJ4C2o32PxmIbU0z8Q4u1QzERBb1xhURt7aJ9fj67ZJh6JG5bmw3GGV3ql9D2VWFIgRN6EV46cYhC2u0NDNDz3/+cvF3makj1DNRKnHAw35DZamQMxfacZdmMPpfgL0WCrs2Gy+qMWmnyBsoLl5AkYQbN/Oc7k+VXxEtGK9cqWWTz7cMJf71rjH5WwIbKUY94BAu8QPpbyssPZOmRrzilyGxqP34OC6FQ9lngDAq/GPcq43+JfDZtssGfF/I/XvKsT2ouiwF04smx7zrg0G5ZHuB+XS/Kc2PiROzA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697f97b5-60d6-466d-bb78-08def8555e74
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 09:37:47.5126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+KPCB+vEJJi+hMTe2ak3CYwNwoYReKlz4JjPpHreu94xNQPWEh7aHNnVf0iVpXRuSw1M2uJtFBBd/XXPMzCQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB989595
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3NiBTYWx0ZWRfX437bACK+cfbH
 P3PfeCRNsBbKCNbMbzCFd+xNeAPAFlNlGZMYXA/7JcTNtkJD3O6BJ2mC1UiNbCfax2a8VBeo2ud
 WV1s/QIYKCT/86wJm0WuC03Q4uzaoKw42+/VEi/UTDQS+S/IfQin
X-Proofpoint-GUID: mCo12IBRYvis4jbTMY5bZGFdYGBvC6wG
X-Authority-Analysis: v=2.4 cv=UoBT8ewB c=1 sm=1 tr=0 ts=6a7c3eee cx=c_pps
 a=UZZKR2DsB1PZv1vhPkDPDA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=0QXeZJDQ4yNUCuFxPvMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mCo12IBRYvis4jbTMY5bZGFdYGBvC6wG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3NiBTYWx0ZWRfX9cvL5P+WFuxb
 RAJ6FYX54qU+FFHSVc44KpT8SJjusR5pEVmu1+jr30MX5FoP5/Vg/JNF64W7Bw82xGCOwiPCI4m
 EfNFhkSsEHip70SNgTtrjncOSuWKccIPnq2u2nYinTvIaAE85WH+6CZ0ftHKr5/zHpbReGnW+ze
 ZZ73cMLpTeb199Pes/iGZv3h1q/Jn3Amscq7z8SlGe/VxL8/wF73SG7BR/MLVPPnBHKwlTg/Ep7
 4ZOQNncvt458546fQezll75e/VSQY6B60DlxrA5C3a9Anolz0MzCMUL46AWrklAy6sujJTIfp0M
 VeQyD+NpYV/nuH1s8Y2M7e86riFdk2WJo5UU5TlWxErdv6d4UKjrzq6hyjAK25c/mrq7iaLCys6
 8pTgwVsS/9F++562QczvmG0FEMp1DzZgbX7JXoc4KMTDC9LtcRy+DkxN+vTCsh8paqoKlxFjlPM
 v8hYmrSpkwLAKlLHHYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120076

On Wed, Aug 12, 2026 at 10:08:34AM +0100, Nuno Sá wrote:
> On Tue, Aug 11, 2026 at 11:28:04PM +0530, Vinod Koul wrote:
> > On 11-08-26, 09:46, Nuno Sá wrote:
> > > On Mon, Aug 10, 2026 at 08:15:28PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Aug 10, 2026 at 04:06:42PM +0100, Nuno Sá wrote:
> > > > > The src_addr_widths and dst_addr_widths capability masks encode each
> > > > > supported width as a bit whose position equals the corresponding
> > > > > enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
> > > > > 4). As these masks are plain u32, widths of 32 bytes and above
> > > > > (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> > > > > be represented at all.
> > > > > 
> > > > > Introduce bitmap-based bus width capabilities that span the full enum
> > > > > range. To allow DMA controller producers to be converted incrementally,
> > > > > keep the legacy dma_device u32 fields alongside the new bitmaps:
> > > > > producers using the new helpers populate the bitmap and mirror the low
> > > > > 32 bits back into the legacy field, while dma_get_slave_caps() folds a
> > > > > legacy-only producer's u32 into the returned bitmap.
> > > > > 
> > > > > Add helpers for producers and consumers so users do not need to depend
> > > > > on the bitmap layout directly. Once the remaining producers are
> > > > > converted, the legacy dma_device u32 fields can be dropped.
> > > > 
> > > > ...
> > > > 
> > > > > +++ b/include/linux/dmaengine.h
> > > > 
> > > > >  #ifndef LINUX_DMAENGINE_H
> > > > >  #define LINUX_DMAENGINE_H
> > > > >  
> > > > > +#include <linux/bitops.h>
> > > > 
> > > > Ah, this is unfortunate, this is a wrong header, the correct one is bitmap.h
> > > > and I think we may not include it here (see below on why).
> > > > 
> > > > >  #include <linux/device.h>
> > > > >  #include <linux/err.h>
> > > > >  #include <linux/uio.h>
> > > > 
> > > > ...
> > > > 
> > > > > +static inline enum dma_slave_buswidth
> > > > > +__dma_slave_caps_get_width_min(const unsigned long *bus_widths)
> > > > > +{
> > > > > +	enum dma_slave_buswidth width = find_first_bit(bus_widths,
> > > > > +						       DMA_SLAVE_BUSWIDTH_MAX);
> > > > 
> > > > This is from find.h which is internals of bitmap.h.
> > > > 
> > > > > +	if (width == DMA_SLAVE_BUSWIDTH_MAX)
> > > > > +		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > > > +
> > > > > +	return width;
> > > > > +}
> > > > 
> > > > The (big) problem is quite a header dependencies hell we have. All my cleanup
> > > > work of kernel.h I started on the simplest thing I wanted, id est to make
> > > > bitmap_zalloc() and similar to be static inlines. But it's impossible to achieve
> > > > (and I think that no one, except may be Ingo, see his 2000+ patch series a few
> > > >  years back, is capable of fix that at once). That's why having bitmap.h in the
> > > > kernel wide public _header_ is bad, bad idea (at least at the current state of
> > > > affairs). So, make it exported function instead and keep bitmap.h in dmaengine.c.
> > > > 
> > > > ...
> > > > 
> > > > > +/**
> > > > > + * dma_slave_caps_copy_src_widths - copy source bus width capabilities
> > > > > + * @caps: DMA slave capabilities
> > > > > + * @bus_widths: destination bitmap declared with DECLARE_DMA_BUS_WIDTHS()
> > > > > + */
> > > > > +static inline void
> > > > > +dma_slave_caps_copy_src_widths(const struct dma_slave_caps *caps,
> > > > > +			       unsigned long *bus_widths)
> > > > > +{
> > > > > +	bitmap_copy(bus_widths, caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
> > > > > +}
> > > > 
> > > > > +/**
> > > > > + * dma_slave_caps_copy_dst_widths - copy destination bus width capabilities
> > > > > + * @caps: DMA slave capabilities
> > > > > + * @bus_widths: destination bitmap declared with DECLARE_DMA_BUS_WIDTHS()
> > > > > + */
> > > > > +static inline void
> > > > > +dma_slave_caps_copy_dst_widths(const struct dma_slave_caps *caps,
> > > > > +			       unsigned long *bus_widths)
> > > > > +{
> > > > > +	bitmap_copy(bus_widths, caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
> > > > > +}
> > > > 
> > > > As per above.
> > > > 
> > > > ...
> > > > 
> > > > Another (compromise approach) is to split the header that includes bitmap.h to
> > > > something like dmaengine-width.h, but I don't know how spread this use is. Do
> > > > we have all the users of the current dmaengine.h to use these APIs? If not,
> > > > split, if yes, then comment on this in the cover letter and perhaps that will
> > > > justify including bitmap.h in the dmaengine.h (but personally I am fully
> > > > against that).
> > > > 
> > > 
> > > Hmm I don't think all dmaengine.h will use this API. Maybe on the
> > > producer side but even in that case I don't think so. These are all tiny
> > > wrappers that make sense to be inlined but OTOH, I don't think any of
> > > these needs to be called in any fastpath. And I do understand the header
> > > pain in here but honestly, no strong feelings. So, I'll pretty much
> > > defer this to Frank or Vinod.
> > > 
> > > Frank, Vinod any preference?
> > 
> > This header is where we push stuff in, so I would try to keep it clean,
> > so I guess better to go with Andy suggestion here
> 
> Andy,
> 
> Just remembered that bitmap.h is already included in dmaengine.h anyways. bitops.h
> is because of __set/clear_bit().

So, simpler thing would be to move __dma_cap_zero() in dmaengine.c. But
all other related things are inline APIs and we would be moving this one
just because of something that live in dmaengine.h for a long time now.
We could think about some dma-caps.h but that's honestly just out of
scope for the current series and nothing I can really commit in doing.

Likely do the same for the bus_width API though I think the split
header might also work. The one place where the new API will be almost
always used is in the producer side (so drivers/dma).

But again, honestly, I'm just tempted in saying, let's leave it as-is.
bitmap.h is already part of dmaengine.h anyways.

- Nuno Sá

> 
> - Nuno Sá
> 
> > 
> > -- 
> > ~Vinod
