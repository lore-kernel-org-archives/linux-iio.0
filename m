Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E223E5EEA;
	Mon, 10 Aug 2026 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374381; cv=fail; b=uR9LfdkwQ1lEM9Z83yU5lBeLO5b+L7gyd+ZaZUhU1oEtCSTnwZ9PYL4UzELZfHqU06MPhUx7ZiUhgb+dXm+5HBYMj3TB4Jl4a3lhddYgFsH1EIb20l2kpNLp4EabhMBXPNTGBi8fsNQ9zA1uQTeP1IX5pJkGweYfOy9FGG2wmx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374381; c=relaxed/simple;
	bh=IIB6jxNZUPTivqsq/abnh/r0FSnMLzFhNZjMWBt9fAU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UyyWzxu3q3QT7d7wOLXjpsFzGJrPjn9VD61zZKfVaLbmtprLTj0Fe6LyksIpJbTdRhPaxKEh+a7Mde4lI3E4NIqt08XwYUv9KCL6AnLZNkMqR4ro6pULAoeAWS+SO9JWqT4EPb/3qTBHFB6/v8e6Oc2fSc1iCnrGlNrUWLOTl8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=A5Ufyg0z; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="A5Ufyg0z"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACsJC61464309;
	Mon, 10 Aug 2026 11:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Y74Dx
	kN4Law9hPjGjOS6bYO9uWHZVfaF3jCe2PcU70E=; b=A5Ufyg0zRkfB+RGuejKfp
	fr3LTTwK4KHPCpDKayiBl2l6N4z8n8q4Yrmv6nENFHH1vYH6Bd3x/GmboWs14ar8
	ATkUun3LIpvbxv7QFTEntEnMlluEFmdxljrnrrdfs7G/bn8BsEqhmRBpxN8JBIPD
	GjqPZbZ9fNp9XTICDZzXhIMNP4BnAfSfcyD93OvEKTvXrUvCW8NQnoj3q/chcIUP
	tKdyMvWNScRlWbbbV2PtrHM1CAbc15eH3G19F7ynj4TlLoDfxrrvfx3trfcK9vVW
	ot46bWBG2TKK+u/he/GrjqwppTtGozn9HVa8rjJrSi/q3uy5pYNAfO2ngbvopy3e
	g==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012036.outbound.protection.outlook.com [40.93.195.36])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fxjse5ast-7
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:05:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9WGkzrXQwYLO9liig+5nmkcYos5MResv50+fRhm7RxrU4E4AmEL+qQUNVejKKZzQawU7QahpHK+JS0I9hAu1HcQe5VWx0EdYi3wIc1YU1MvciQlmgbjn7KAAV0RFA9UKY0HcXJrBqwL4++gXYEnsRiG5ydAC8Ekt2SfGjtHHTfhErY5Y4VlNBbpSFjIdtnWKcrv96J9zV7CKJNHsLsf/Q7Jrg4hdE8lAwu7nO6rOv3edLmq+ZceZ5oWeDAzoWjh2AEPTlsmIm+i9V7JL5xBk1HCBFfr5mw6AA9BqP+edBaLacvX9G0lRidxjHceMbPZ6sC+Kmiads9AMueVPxtvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y74DxkN4Law9hPjGjOS6bYO9uWHZVfaF3jCe2PcU70E=;
 b=q4n53BjMvdquuFNH9ukqCtLhmUuo9hpxwVUsNOhPntqffGPiM54qVyaMAZ2cLakVr3L/OfMQpjTMiJ6TyN7mHrFjNbesyN4lGqqXKy2WawKJoZXCqyMcoRBbzB5Taf1Iay43TqHG1EQX971N/+OPBO9SvygiW3u8CEKXtB+mpt3+jCUhpNnegyPiDf4NM7K7rPFNA/TWpOiiz65byvHRUYtUaZSVGDS9qRoFLqJYY5uhuMv5g0HClx8HJb/X1VN7b38tnBs78fp0EILIoIIWRP/uEDWSJAedcCDFXefHirJ8tU2g+AOf1IfgFkIOVtK9SMEf1xGbd4RrrbEqklmc8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS7PR03MB8170.namprd03.prod.outlook.com (2603:10b6:8:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:05:46 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:05:45 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 10 Aug 2026 16:06:44 +0100
Subject: [PATCH v2 3/9] dmaengine: dw-axi-dmac: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260810-dmaengine-support-wider-dma-masks-v2-3-1f7b798d035f@analog.com>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
In-Reply-To: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786374404; l=2854;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=IIB6jxNZUPTivqsq/abnh/r0FSnMLzFhNZjMWBt9fAU=;
 b=VdvHgar7IeaozyOyn8eChFEg3MN8jFv25EKMbHoML103hZO5uCk7PikBjM8TecqTqregVm3Ig
 u4jfhiUwk4pBJlDjj+FQXaNTTFdNqPVQzaCsAeR6qsJy9+OBb4aPmmw
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0067.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::12) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS7PR03MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f31cd2-5fd0-4382-4f83-08def6f0dac8
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 pXnQQL0juOdEwEGsmV47vk2IFNm5GmNKIthKyHNmSNzvfUwqgHQVG/1Nbi2WpJhIi6IV/RXxjUtQTTPZnm6qz31OwFpc1L8U4nCGu9DsD+asQwjI+MXFeoGKVJn5G+zOcdqBGLax3YHlNn/OM8fZcv5S4vL/mvNzMnV+kiTiw8qfiGrneoWs5M2wjXYtQ6mSiT9bOum+A7P5XaBkQ13ncLjL3o5yuIjGu/ijtLACCe/aNl0dG0noX5MtPWHH0P+Z9knpYbcgueFl/up7bIgBtwlopS3tbUCu5oZmkyDCw4hO6I4dZaoOdUR1F2hQHfkQNd6xpbiqwyCe/1u9NmWLIsyfGYzHirgUR2F8gtLFaGA+vUx2ekAQbvQJnEIwKsuATlwSGhdadmh18r2hu0fJYNuq4EqSrG68bZEZn7g3Cap1fyYBjx1uGHcSfJ1Frtd5bUe8xyZ7nnonOOrPB1/b2Ofgmiohuiid5dHRep33fu5WUXkMdpkFyHhIwj3SpxaEFXDokfGpnZ1I+7fUJ0HLsiSQixTlBuvWpADjeFb7agq5covrfCENMWB9hAVuY0REVAVlSPdAduFRxyPfEFDIUxPFoR7LWsqB8CLGg5GlFrAVF0mKFmNbx6NGJLDxOTCPe50Lhr8z7HjCn1ZDvbt9IRgpwc/5oF5coEPtkcMexxA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?alJpbjA4QkZSVVVZTGJKRDRwM1R6TmdaT0VZb1FnQkd4OFlkVWFJYWVWNVhC?=
 =?utf-8?B?VFkvZURCOUVGYzh1eHZubXhWdjlSNmVOSnk5Ykd5WmN5ekpCeUFoNDdVam14?=
 =?utf-8?B?YzA0dGlGa2VsQnNqUDk3ZjcvaWRIR3pCUHRkeVhWYkZGYTdjQllBbUZIc3Bl?=
 =?utf-8?B?L3JlSDlkTHFDbkZJY1RXWFhIdUZjVlUxNWx5aFhLeGx0UHFEMFBVMUpsVFpi?=
 =?utf-8?B?cHBhTnNqQzhLRktjTUtYaE9ZcmNmWEZDcmJjNnl1cXJuN2NCMFhNWCtGSUZQ?=
 =?utf-8?B?TmRZKzZXN2RaT1AvcGVIZVlqMnoraU9WUjNRbDNUandLZHh2aWtORE4zc3lH?=
 =?utf-8?B?bG1UN0VKU3JIQzg0SWpBY1RKY1lwek9XMjlNWXUwWm1aUGV6TVFnWlNVN2FW?=
 =?utf-8?B?YmVmYVhVYWlIRk5TY1JUcUpjc0lkSmUyc0J6eCtjYkJkZkFuYmFjT29jVkFZ?=
 =?utf-8?B?cWEvWUd0NFM0SXdqZFUxUGRwZG1MM0k2aUN5ZmpIU3pJakZQckpJSVlhUWRr?=
 =?utf-8?B?amZqZW9zSHpNR2ZxaDJFTXpRb2dyZnovZ3J1OGw3cGJ1S3ZndUtTb2N0dm4w?=
 =?utf-8?B?a3htN09YS04rZUF3Uy9Yb1lySmtXMW5XZ0w4ME9ubDcwTDZxYko2a2JJN0No?=
 =?utf-8?B?QzFmRGkxRU11UW1uUUZjNmFveW9DTi8wSTZRMzdLendhS1A0Smtkb0hDa1Nl?=
 =?utf-8?B?YmJvY2tWMlZZQXp1cjF3SEVpMEtOcWlSZ1NwNkdSQUxYM1lBUTM0UjQzMFg5?=
 =?utf-8?B?SzVFMFc4cTg4YTV3eThDbk5CclNLUktaa3pQZmY0cjFnVFlyQmJ0MXpJb1Yz?=
 =?utf-8?B?SU52em5BdnpWTk56WEIvd3NkTjRoWDZjMlQ0c3ZNWkxSd0MyZUExT2gySlFP?=
 =?utf-8?B?RGdqMjVXbmthYVNSZWJ5ZUJHMWJzQ0l6TjVUbWhrc0xmak1sVTZic2FzTnNr?=
 =?utf-8?B?dzhTbG1iSmRnSW9DcmhrWjk3RnZUaVIrUVhjTFUxck5IeXRDZnFZaGVteE1h?=
 =?utf-8?B?R1htaHlwVUVhaitjS1BGQ0l0MVMwMmM3UndQb082YjFrMnlzVFVGdlRkS3Fx?=
 =?utf-8?B?b3k1VzlWOWhKSnMycHA2SlpCaUxWamhnblYxb1liNDhLVFQ5SDczdDVPZE5t?=
 =?utf-8?B?UWk2MDZValp1Tmg5L3pxZE1wSjdEd0RHcjVCRjlJaE9wZVRaWnRQVFFTUFc0?=
 =?utf-8?B?ZHB1ZHpQOElFaGVyMkx1eno4c1V4RW1PLzRpRmJBU2VqMGd0UmNZakY5bWZR?=
 =?utf-8?B?MWRDcEd3d0o2dWtEZ1NWQnhvSldua3ltZG8wZFllWXhwT3RmWlhGRGlOSWdq?=
 =?utf-8?B?Y2JJMStPNHhhaGFUYUlYaUZHYmc3NEIyVkYvUHhZYzJVclAzMHl4OUdWdFFu?=
 =?utf-8?B?WXBzNzZtZ0I1NXhzOFdDYmZBNTViZE1xYW9jSk5sTmNaaEJvRk4vZnk0V1A3?=
 =?utf-8?B?Zk51WitZQ2d6TklSRWdkU2thcXBtOWVrY2ptQlVYWVlLRVk2ZkFLUVRVaG9G?=
 =?utf-8?B?QW9VckZWNUpzV2ZhekZtaW9yU1lqMEZ2K2FrRVMxKzdYN01YUUJDbzJhYTM5?=
 =?utf-8?B?UkVvOWJSMllpcHZCRGw3UTlWYkNYdWlWTHpkRkJwaTdDc1Y2eDlEZ1hsakJP?=
 =?utf-8?B?NGkwTm0vRU44R294L2ZPZkdMeFg3ak5uaFJ5bzlKcGc1UE5SK0ptdGx6YTR2?=
 =?utf-8?B?NmFRaFppS0pSVUU3cytpS0pWbk1nSzNxWkVjODNvVTdaM3NsUFllUUVYUVVo?=
 =?utf-8?B?RG5ISUhYWFhpQ3M5U1ZPazFEUUI1YzUxS3JsdVd2OCtDNERnbVFkL0VERzRR?=
 =?utf-8?B?NWtaVk1zc1BveEM5M1cwdkFBVy90UlFGQ2RWejhpNWpkNVJGNENwVlZTVVE2?=
 =?utf-8?B?M3VEdHQ0ZURtUTdReDYwVGlvZGQrcDhld1k0QmNtajBMa2dMc3VoaDhVbjVv?=
 =?utf-8?B?ZFR4Lzd2ZkhBQlE4OHN2NHV4Y0ZFSnpjUmgvZ0luRk9tZ0VUUXplc3hRRTNN?=
 =?utf-8?B?NllEWVJXOTZNTmRxd05iQndteGd6Q3lya1RJVUxrdTZOaTRoWG5vL3Z5Tjcy?=
 =?utf-8?B?K01CaUlkM1B6L0cwb2xjSytIZThhRVp2TUlIdmE4a3JnRkNFbG5vTDlDOW9W?=
 =?utf-8?B?dXVhMlNOUlFlSjRHNFp3UVVKYkhjUU94c01MQzYvUmZ5b3NRdFJ5dHkwT1Mr?=
 =?utf-8?B?eWFBRXQ3QytZaXZUcVA0cmVZdXQ3L0x6TGhEQUlxZE9vYW1FUUtyTFhtUDcz?=
 =?utf-8?B?QnZhUlVTRzBUUVUzZFVTeGFCRWI5V29IVlZyUjhVN0czdU1lS0xNeWlaQm9s?=
 =?utf-8?B?aVVCY3RqSk5KcW9Kc2d5VjFwQWZzVGtCeFhTSXdjSjF4ZUc0Y0FmUT09?=
X-Exchange-RoutingPolicyChecked:
	cK9oVZI5IFflpopG3B2lag54z8Sw+VbCzZhYDtsJd+Y4gckAVSd6cLgnNmk5Ca8/Of0xh87BSpdCzjndApge2NFKDEKzEHUpI73AVXcn9+xEGGqB9P4G6jg+eDt2lk6KAZrbp5scfyYKpVmoR7KvzDY3zl/cPLXMFagczUbf+Wk7wye1vP/ZGOCX+KTpy9ofA2+zhY7HmJCYpWyyyjXkfm9Nbw/IBhRP8f6nucZxekttIo5T6Y0O+Ap3jEdk31KPdzEu2wYLRqsLlnTi92BlBBoWXKQnJMGn/1SJEF4C3wpxelc8F4eEF8wSSo3NYPcgInCSMjtS9OLBpEotHSYuUw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f31cd2-5fd0-4382-4f83-08def6f0dac8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:05:45.7766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtMyEQl+cPmUKpnvuMLxHk57dU85eZ9cNjw1RgSl/4Z2kR1LOaFemaYrKiHbXvGSA47esMVDzK/vxnpzbA1NWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8170
X-Proofpoint-ORIG-GUID: cK5NU3QHcZVuBxGY3RwG-WlNKoZadyRm
X-Proofpoint-GUID: cK5NU3QHcZVuBxGY3RwG-WlNKoZadyRm
X-Authority-Analysis: v=2.4 cv=MLBQXsZl c=1 sm=1 tr=0 ts=6a79e8d4 cx=c_pps
 a=1PMvcOD3Mx+UKTR1GZf1Bw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=y_OmukUNvUlgtTeSwsgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfX7mGuF3oA+VDe
 s2UIbMp8ZqrW4OW3tQxv+gEksef4zv5P75QNwJ3YBwYy/v20JBnmyNEokX0T8P0C8D8fajSIsPo
 h2sUYBIMSoZWWBp2xreFXa9JosL0uHAeDApAsQCySkd1t+TPzqjVwqdCG4+Y3SP5mhoFlSb0er2
 gPtiQ4QVMRGLzxUMVOsRdrwtqgzEz2QPxfqpqYrwSFHuLzfdayxN8Ny23GG2Y5+Ofj1TcQlJ88q
 SbSML8mwoM7HkjqBzDsyOU47N5rj+H8N4mObz6S3B0CFceJWAdX4TOMO0GFBU8gDB+1VNeq+HkV
 lUcKf08B1kt8Gd/mh9sPW4It4Y7lfh28CmnDbXQXwaNAfRDKdbbPWNcD2rR2MTCSgRpe2+9CC9d
 qS9gm3mzv2c5K/PwHI8gA8imefF1/qqNSEqHfO0GjMBGlZP6pyfYiNy3iT/l9EG5ScjD8UeQOBJ
 b+ByX90EYz/sJL/Hc4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfXy1RPM0+0RGA+
 CTei+Xb67ataUleq85qlIE6sLylrYE4yntQKNba+/ocZuPl5GOKiq8w2qXlXA+45xa/tA/wiN1H
 DgYJQSHzpLavnR3HpSfvU5FiA4tUZMcgJLy/Zmxin7TJ9c9zpho9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100130

Advertise the supported bus widths through dma_set_src_bus_widths()
and dma_set_dst_bus_widths() instead of assigning the legacy u32 masks
directly. This keeps the driver using the new bitmap representation
while preserving legacy fields during the transition.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 39 +++++++++++++++-----------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index eebed2474210..0fc4aa537346 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -33,20 +33,6 @@
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
-/*
- * The set of bus widths supported by the DMA controller. DW AXI DMAC supports
- * master data bus width up to 512 bits (for both AXI master interfaces), but
- * it depends on IP block configuration.
- */
-#define AXI_DMA_BUSWIDTHS		  \
-	(DMA_SLAVE_BUSWIDTH_1_BYTE	| \
-	DMA_SLAVE_BUSWIDTH_2_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_4_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_8_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_16_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_32_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_64_BYTES)
-
 #define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
 #define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
 #define AXI_DMA_FLAG_USE_CFG2		BIT(2)
@@ -1482,6 +1468,20 @@ static int dw_probe(struct platform_device *pdev)
 	unsigned int flags;
 	u32 i;
 	int ret;
+	/*
+	 * The set of bus widths supported by the DMA controller. DW AXI DMAC
+	 * supports master data bus width up to 512 bits (for both AXI master
+	 * interfaces), but it depends on IP block configuration.
+	 */
+	enum dma_slave_buswidth axi_dma_buswidths[] = {
+		DMA_SLAVE_BUSWIDTH_1_BYTE,
+		DMA_SLAVE_BUSWIDTH_2_BYTES,
+		DMA_SLAVE_BUSWIDTH_4_BYTES,
+		DMA_SLAVE_BUSWIDTH_8_BYTES,
+		DMA_SLAVE_BUSWIDTH_16_BYTES,
+		DMA_SLAVE_BUSWIDTH_32_BYTES,
+		DMA_SLAVE_BUSWIDTH_64_BYTES,
+	};
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -1565,8 +1565,15 @@ static int dw_probe(struct platform_device *pdev)
 
 	/* DMA capabilities */
 	dw->dma.max_burst = hdata->axi_rw_burst_len;
-	dw->dma.src_addr_widths = AXI_DMA_BUSWIDTHS;
-	dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
+	ret = dma_set_src_bus_widths(&dw->dma, axi_dma_buswidths,
+				     ARRAY_SIZE(axi_dma_buswidths));
+	if (ret)
+		return ret;
+
+	ret = dma_set_dst_bus_widths(&dw->dma, axi_dma_buswidths,
+				     ARRAY_SIZE(axi_dma_buswidths));
+	if (ret)
+		return ret;
 	dw->dma.directions = BIT(DMA_MEM_TO_MEM);
 	dw->dma.directions |= BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
 	dw->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;

-- 
2.55.0

