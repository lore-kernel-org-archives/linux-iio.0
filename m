Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6DE40E8E1;
	Mon, 12 Oct 2026 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791802754; cv=fail; b=d7D/+tSEi2cvkJDMLBLejHMdvs6x6dPnjSXWt7la0KEb1N8/MH7pdIR3Z3nDiX0cngoNnwFgEN+iGDLaD+SU+qogBQPUsk3jcSHUMy4bQnrlftylMem239XKGeZS9FvZVXXphJsbgDFEhDHtEmU/xawmUN4XMPrRDpbWegRAGiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791802754; c=relaxed/simple;
	bh=sVUw/7LMIQCd6r5fX6gD53fH8nl05zl2M0N3p/5ByCw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pH0kNUZB6w0zonPTIo1jOyEG/sBdkzbCzWa0sNVEj3JX7BPtamDZQRhGPppABg8If4Fb1wwC9DG1vRte7gWPC5L4WGu4ZMpyTwqTNBLIyUhxZbl3+YuEd/mHZgkb15jxRwCLeIuk4EFHZ5OdI8AqDePfgxJpupK84qUb/LFBeDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=J+KCOSLQ; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LlpPXE6T; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="J+KCOSLQ";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LlpPXE6T"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8NtA62416616;
	Mon, 12 Oct 2026 06:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=5TgeNYbjugCz/1k5RndtL1/jXCYxroa7NfWT8ep9rfU=; b=J+KCOSL
	QD8Sz4JmSjT+qSw1uOUAYzdBQawkZi7VttGsdjAEFSMY09XDl2zUldlPAU78N+9f
	FP+3pf2iCCezoqFWijh9kAvKBp8v+rT0++HOGKtMpQkuFhE7vuc6ywW5T1K7pKXh
	PhKRZkSyF4eQudDHiVobqp4jtc1p/kOtlCusAr16SGSrmGC4nYWxm2ST4lFLI0pn
	CNxb9oVw59Cz2FBVcxfWuUo0JqARYcKe8QkqqgjxpTIIjJnIol4pqKfST/8wKm3s
	tRitJUrJr0LqpEKmmMzpU1A37cRQjc90K3PF8KfyZETuEGzTZljkFV3u5OoWmaaU
	Vb19Qzvz5iZ95mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5TgeN
	YbjugCz/1k5RndtL1/jXCYxroa7NfWT8ep9rfU=; b=LlpPXE6TRUkEez6Owo8l4
	nU4LCkw5hCJtfw1IxYIPSyyINv9DY8ggqN5ZMpI0sN7+eo+4oO/Vlnht0qNZtDlr
	v0SRpd24LRjGNMu03yUc3VPc9zm7tXiZMPNaopfo+q6Nr6UGDNRvbxvcIxYgWsCY
	SRScTBJZbiOjuaSt7pBmjOv58KayKafWKLfI+g+GzNjvLBZTr8lnQhhhvDEYAtRX
	G94oFWHFv0qonWnaGNH6FQgUZH/+oJExkDqJIZ5PDMI4dkHjf3Qr7Ixfsv94dCOg
	i7FjWg4SD2hBXy7JuXFYOa6x+kj79XmfKK8OMujtXbxxkmouboGovVLENCWLJiaF
	Q==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h86peef2r-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 06:59:08 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2r5G3ZJWnk1yOOB+UwQDMwkIyRkvJbPOBswOOurhNatNL+N59L/bDaOP0Y9XLi5MbW/YToETsBGq6Abq9BBehnSsmA0l7q6YtbDuR3/G5zIqGQMiqAAe6Qc0KSYNr4QFUsPWHjGhgcg7xPxcUGtfI7+4CbEBa189rB64CI5UmBLuzZ/R2W7GfWpp4fTUsTHGBsBJbkivaTv6XxGaY7zjowtHX6/MWyOWOidWMpsaTp2y/Ncuye+O0t5yBHbK3UXepnvaQt+NihuDtxJn91WYAHNN6RFBW6gDM/qCp1ELS7Gbf5DH9c7XUtEHqJ7btOfeE/Wu0cBEn3f7orzOtXlBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TgeNYbjugCz/1k5RndtL1/jXCYxroa7NfWT8ep9rfU=;
 b=idyAdfG9ly9xvTPccyf+LMW4wZw5qfyf3le5mzfDymUcYwlh5qVrB/J8CxCZkTequtA5+CP+AvSP8L1k91gV1aGfM3eXHbOreVIth7mCWuYgJnU+gJJG0yiWANX+AYhCCDMq/DQiIeyVyU+VntHGKLViPRQnx0dnlgE61m35fZIZsAgj3E4+hOYtVkm99VgULPfa+QdWIxWG0qH2Ovit5oO/cL4BTNdFyWifcvQew9i1iL6aX/y4oPFTLaOrT1qdL7qXQH1APJ+hWCBx/PywdhlIF7PumZPVMi4lQ+246UU1y9ePaJyKOT4ve0DshcbT+q+zfQt7vqQQ3jZ2JSO5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BN8PR03MB5121.namprd03.prod.outlook.com (2603:10b6:408:7e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 10:59:02 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 10:59:02 +0000
From: nuno.sa@analog.com
Date: Mon, 12 Oct 2026 12:00:18 +0100
To: cdcp206@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Liviu Stan <liviu.stan@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] iio: temperature: ltc2983: pass leak detector type
 explicitly
Message-ID: <asy9jo0BRDlpM24s@nsa>
\From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
References: <20261002-iio-ltc2983-fix-string-compare-v2-1-b0a5ba847790@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002-iio-ltc2983-fix-string-compare-v2-1-b0a5ba847790@gmail.com>
X-ClientProxiedBy: MR1P264CA0008.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::13) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BN8PR03MB5121:EE_
X-MS-Office365-Filtering-Correlation-Id: af826075-a70a-4fe0-dd30-08df284fd02a
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|18002099003|22082099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 i2p4P/g03H/dTBs28kmGBhXD19woHxMLyV75XZE+vnLLR1WCYeLnILWDV6fe/lZ1hsfNYcfUw2/AkgQkY+2xu/Hw847eNTVSVp2D36M+act5RsAri9M46m1t8NR111/dKNEH6EX42EUkV2dI7B+e7gzGOS9c1FPjQDxtePgEpWK1nZvkaF+WqUxntOsgKrhrvV02fpLk/DFBDJf16VDq+IMEP8Oi+euYOdX8EAK0fs9Sf/e0dba9duUh/qSfokd85Wlsr8aa04Drn2MYKVFyh3gZ3bevF7lHKi6/Wn46rA0sNh7zDeVCql8gc1LVS2YAt4pxBn4VMUzL/iVLDpvA01ldVSPlhA58anZq2Er+VzRit9njSJGxixQM9jkP3vlqEedITHuK7Saxjy02C/e/LmxIQcaObleYM9GfewCjXkvJkhnd434i4pPTYpE3ImtkljpocUFqMiXOT5+eZuL3o6rTe2vKu10Y3c8Fpu3FXKmX4jAMwpRveAWm1Mn5pwdltbXKEKuPnddynASJB59keynb9zoChEkie/fcDawQ+1pC4V/vZTC8rWwybuWEhH1M3q9YbGRfuc4HHQuxwf8HxXunmZ4E5NHeaEg+pHw0KDVIDrJdrV1IVtM5qmT2A0LN
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Ym80emtHbDVxUTE2TXM3Tmx5SWF4WTA3RGZlRGZhbHJmNkRMQVRPUVVmNE5q?=
 =?utf-8?B?a2NwcXF3Y3hwTnlLQm41VlJuL1hudjNWZmxDc1R3YTlnejVHZTB1dnEzSmFP?=
 =?utf-8?B?NnJUci95eWtoWUxMamtHamdqWTdpK044QnZucTZWbW8raVpCNDE4NzRCZFZj?=
 =?utf-8?B?TDZhMTYxOXZsK3dSRUpaczVBWHR4WUNtWWdlU0dWWmMzV3NvT3QrVDhnZjlI?=
 =?utf-8?B?SXZRM0dZSzFjbEdxdXU1UjRKM21ybGhKM0oyQXgvWmZZYWw1VnFmUWFKVlBT?=
 =?utf-8?B?TUdnbkNrOG1HRmhOOWlnSm9sRUdQY0V5eG92T0oxMDYzYjQ1cWtlNm5kTGxh?=
 =?utf-8?B?Wk1WeGFwL0ZnSVBQcW5YaUMxZTIvemM4Q1JyNzZUd1duc1hYTHV5VjZTaUM1?=
 =?utf-8?B?bklYSzZFcWlwcHhoZVduMGRZZnhOd2I0bVpGS0xZOUlKSDQ1cnlaaFY0bTZL?=
 =?utf-8?B?b2VydHA0cmtZTnFsNW1ocEpBaTUzZHdRdXBXUWtQREMzVUJLNFQ4cnFWc1hZ?=
 =?utf-8?B?THMydk9PbzZ4cnUxSDA2NlNoVlZuai93UXBid1p0ZHk4ak1vZUFlaXZBWlVT?=
 =?utf-8?B?N1BreFJMajJ2Qk12TTdIMFZ6NXU4ZzlaYWFyRkl6d2VUNS9leCsrZlZYdTFR?=
 =?utf-8?B?eGI0eEdGejJIakpicncxdHQ4TVZQTDdWT1QzZlB1OExhU0NCb3RYWXpuU2Vl?=
 =?utf-8?B?bDUyS0N3ZVVWNFhObVAzMWNjc0pIRGxuaXFVTktNS0pXVGowZ0FIM3VZa2NV?=
 =?utf-8?B?MmRmdzFvSzJibDNMSWF3QkppZklzOXFVSm0zR3ZUVzlQeVJJOWFvaThHQW80?=
 =?utf-8?B?dU5xVjQ1MlN1MlZKQUFFZVhVM3c1UnNPVDE4Wkp4bEdDM0ZvR3NmN3Q3aWN1?=
 =?utf-8?B?N2pRcnYwWFFHZEk3TnhBK3luOUFmS1BEWjJTY1BNYkx0RzNOM2hKQkFwc3Vy?=
 =?utf-8?B?OUJpVzNjNU4vNDdmb2ZGZ1ZabGRlZ2NGRE4xU1BlMVpEUWFWV3o5WXRSMEVh?=
 =?utf-8?B?NXNMSjJvT1lkR2NQMmZWYVJubDE1TkxFbklLOFhjSHRrNTgzblZBSlA3U0ls?=
 =?utf-8?B?N1VoL1Y4MHFSSVMrdUk3aXF6ajFxajRxSUY5ZUlKWUlXRU1VamJjb1NZRW9R?=
 =?utf-8?B?R0VtZEVjVndWbEdnZW1qV3VmazhZa24xRHpFLzlKNGx2a3JCVEF6bng1MGts?=
 =?utf-8?B?ZTlaVnJvRHRmaEpLL0VyZlVsRkV5RjBSa2RKRktmWlVFNGpYbzNPUVFoeExk?=
 =?utf-8?B?UVQ2bXZBMkdNVnRqdkhDRUlVRFh0TVFkVlo3Mi82UU5HZ2lFSFBXKzNxaW52?=
 =?utf-8?B?WG8zTWJrU0xlYVJYczVNc1lSdHd4WlVwaDNKNVpYcWZhdWZLbkJ6dU9JWFFR?=
 =?utf-8?B?WjNOSW81V3haTis3cWVqRlhCazV5WlNZVlJrMEJsUEMyNGZsS1M1dlEyeVM3?=
 =?utf-8?B?S3J4V1pIcGM0aGxYUVRwUm1YdG9EckptV2NXeWl0VW9qMzNhUGcyS3hHdlhC?=
 =?utf-8?B?amJVbkdGVmxxVlgwOW9oblBXWldUK3VVdEpyQytqWHpzOFIvRzhOZzVFTndX?=
 =?utf-8?B?eTJRQkRmSlBiOXBiVW43S0tHaFd4aU4xNW9La0dmU3hzVVgxRXBzTUx0Q01t?=
 =?utf-8?B?Q3E3VGZyazV0Y1ErbkJDRkJyUTMvYTlhbWJwT015RmhSMDRJS3dHR1RxZjVv?=
 =?utf-8?B?NTVrdjQxOVpuTWtscDFFYVl5VlBMVHZaM29UNHpUd082VnlLK3V3L1FEQVVv?=
 =?utf-8?B?Z2VWQjNnUGxvUmpMblhTVUNRTERKaFZFVmhjb0krQ0RXVVhZeWdBcC9EMHpr?=
 =?utf-8?B?Y3UyeXZnTWxOSHhBdlFMWHlqK0VsdVRMS1lKMEk2WlNUcEhxNkVuMzJhRjRS?=
 =?utf-8?B?YVgrV29pdkMydmEweDhJMUZmNjVhQmUybHRRL3RRSlVKVVRDRlAwZnFSUWpI?=
 =?utf-8?B?Q05wQjZrY2N5TWpXTkVYalM0S1Z0bUx6ZHh6MlIzYUlKOHFQRjhOYXZqNHVK?=
 =?utf-8?B?alEvVGsxOUhzejFrQ3hkT2tPaDFFWk5mRkJtZjErWnBsS0JwS1MxNmxockpx?=
 =?utf-8?B?RGJNdzY5SnFxODJ5d3AzTURYRHFpUHdTNWl6WG9sQng0M1hZNEhYWThDSWVj?=
 =?utf-8?B?V0JBUmhmNGpnZzdnL0J0UTVpY1RmMyt4QWJjMFZmc1dFcUNEVFpMbHp5RWtE?=
 =?utf-8?B?bUZhMkNIbnhyYkU4UzhsUkJtVUFrTW96TTF0U29Rc1FzM2d3eGt5YmU5MDB5?=
 =?utf-8?B?UjMvTHc1K2xsYzZlV3Y5YUNHS0JGcXY5a3liMUNybEIwL1hHTDRNRitUU0ZD?=
 =?utf-8?B?L3ZDTUtBdkcraFRndjJ6MVVrb3lFcWo4ZHVrbGRYaXFKY1ppRkJEdz09?=
X-Exchange-RoutingPolicyChecked:
	wzu8I0MBd2s632nZ4C7f6NP+WtJ40Y8IP85k2BZuFHZbgM2aVD2kpmiQtwOK+SjG3M15GISC7VGWpv26xtR7+FOA14Dudo0QQcdylzFRP/yMVEYoLU0JWNNigI5suHmma6X82Tk9cQKIcJns4KEYlWxD/xEvREoLVqHWqUq2Jwbps5P1P4EmMZfe6smEu7x9BFegVTKZnRKrjcxTdvhLRy0fM+cFkMoY9XEjz3GZQBLkZPKqaA4KxnTayS9XDY/3z8M9w5nQzthkTKovf2yRoqEAgXUF87JPwkosJhaKCKApMwlmxIBheu+LJ8z/4NVPWBm2jxuBz0xoDReTNFsYNw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af826075-a70a-4fe0-dd30-08df284fd02a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:59:02.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyWedqheXWGcj1tEfNcXr4E0ATmyyrf+dhEbgnjahLjK+AkJljJkmQAmjOxLgiVG/9aFx6c7Fvi5t+o1VggfkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5121
X-Proofpoint-GUID: XMb6UUuQnEcLHLy30O1HLp41R1TeFLgQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0MyBTYWx0ZWRfX2DpVVjmWyOBK
 cPYce4NtIOnm7MQZ9D7ie3Hr/JP///2SJK24VcHI9hI42UR6zu1U7pgTC4ptjm5qrXys0yvS16W
 WjyzCZWP0JEnAfzH6Gmb5Uh1I0c2PK98iLBL23dhMnrGf9vbpOz4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0MyBTYWx0ZWRfXyg2MKHkKbpnc
 S1QyVQ12oJ2a/VBXyKF8tZ1Wtt4CGJ0ASIj1IsoOzUh7qg28vFSsdKL6gtSUnja291IN3CFJrop
 Mr7jVZ90gS1EsnxdPYCyJiM1OoO5cJPOpqw4mZuerbjbyBVz9mHkguJzUq1Y+kJ1PEG1VFconwp
 Xj2bckPenTV+3l+oOGNcMZe7iNbpRoQKfBcPF3U3zs2nQF1VSYjcUAgJsJD2homUChbcbIkD3S9
 tYmIWs+nVl5bpaWuKUD7OeVcOYIDnhWN5hAaWIt52Nb+BhoUYEpg93aikx3zeFd41zDdmepqT4g
 E5m2kHdVoYk0PU21e4wCW4pQCf0/thBAdDTDOWyCN0twLQAhoC5kEnjD6sTx62A3m8VuyfDKj1v
 k75k9/HUHrrxN6ibNoSkSw9ocXrGGvcpDOozBrsYSWu4kSGuk/lsHi5UhTz5OwSDmdcgeoU6iai
 wYb1ZiV/XqX+VWS9N2A==
X-Authority-Analysis: v=2.4 cv=QfPzLcbv c=1 sm=1 tr=0 ts=6accbd7c cx=c_pps
 a=4PCWzz9QFLYZoRw/GV/NtA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8
 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=Y2pMlBMxqVUhOPWNtzgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: XMb6UUuQnEcLHLy30O1HLp41R1TeFLgQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120043

On Fri, Oct 02, 2026 at 11:44:50AM -0500, Carlos Casadiego via B4 Relay wrote:
> From: Carlos Casadiego <cdcp206@gmail.com>
> 
> __ltc2983_custom_sensor_new() uses propname both to select the firmware
> property to read and to determine whether the custom sensor is a leak
> detector.
> 
> Pass this information explicitly from the caller instead of deriving
> the sensor type from the firmware property name. This keeps propname
> limited to identifying the property and preserves the existing
> conversion behavior.
> 
> As a side effect, this also avoids the -Wstring-compare warning reported
> by the kernel test robot for callers where GCC can determine that the
> property name cannot match "adi,custom-leak-detector".
> 
> Fixes: 3dd0c048409e ("iio: temperature: ltc2983: Add support for ADT7604")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609120045.OxEsKLIn-lkp@intel.com/
> Signed-off-by: Carlos Casadiego <cdcp206@gmail.com>
> ---

Looks to me this is the one to apply. So:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> Changes in v2:
> - Reframe the change around passing the leak detector type explicitly,
>   with the compiler warning as a side effect.
> - Drop const qualifiers from bool parameters as suggested by Andy
>   Shevchenko.
> - Link to v1: https://patch.msgid.link/20260929-iio-ltc2983-fix-string-compare-v1-1-d67d612d6ddd@gmail.com
> 
> To: Nuno Sá <nuno.sa@analog.com>
> To: Jonathan Cameron <jic23@kernel.org>
> To: David Lechner <dlechner@baylibre.com>
> To: Andy Shevchenko <andy@kernel.org>
> To: Liviu Stan <liviu.stan@analog.com>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/iio/temperature/ltc2983.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index 6efb5252a773..6abaf64c8498 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -471,8 +471,9 @@ static int __ltc2983_chan_custom_sensor_assign(struct ltc2983_data *st,
>  
>  static struct ltc2983_custom_sensor *
>  __ltc2983_custom_sensor_new(struct ltc2983_data *st, const struct fwnode_handle *fn,
> -			    const char *propname, const bool is_steinhart,
> -			    const u32 resolution, const bool has_signed)
> +			    const char *propname, bool is_steinhart,
> +			    const u32 resolution, bool has_signed,
> +			    bool is_leak_detector)
>  {
>  	struct ltc2983_custom_sensor *new_custom;
>  	struct device *dev = &st->spi->dev;
> @@ -545,7 +546,7 @@ __ltc2983_custom_sensor_new(struct ltc2983_data *st, const struct fwnode_handle
>  			 * to µK so __convert_to_raw() produces the correct hardware
>  			 * encoding: P + 273.15 K.
>  			 */
> -			if ((index % 2) != 0 && !strcmp(propname, "adi,custom-leak-detector"))
> +			if ((index % 2) != 0 && is_leak_detector)
>  				temp = temp * 1000000 + 273150000;
>  
>  			if ((index % 2) != 0)
> @@ -836,7 +837,7 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
>  
>  		thermo->custom = __ltc2983_custom_sensor_new(st, child,
>  							     propname, false,
> -							     16384, true);
> +							     16384, true, false);
>  		if (IS_ERR(thermo->custom))
>  			return ERR_CAST(thermo->custom);
>  	}
> @@ -950,7 +951,8 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
>  	if (sensor->type == LTC2983_SENSOR_RTD_CUSTOM) {
>  		rtd->custom = __ltc2983_custom_sensor_new(st, child,
>  							  "adi,custom-rtd",
> -							  false, 2048, false);
> +							  false, 2048, false,
> +							  false);
>  		if (IS_ERR(rtd->custom))
>  			return ERR_CAST(rtd->custom);
>  	}
> @@ -1068,7 +1070,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
>  		thermistor->custom = __ltc2983_custom_sensor_new(st, child,
>  								 propname,
>  								 steinhart,
> -								 64, false);
> +								 64, false, false);
>  		if (IS_ERR(thermistor->custom))
>  			return ERR_CAST(thermistor->custom);
>  	}
> @@ -1184,7 +1186,7 @@ ltc2983_copper_trace_new(const struct fwnode_handle *child, struct ltc2983_data
>  						 "adi,custom-copper-trace is required for >1 ohm copper trace\n");
>  
>  		ct->custom = __ltc2983_custom_sensor_new(st, child, "adi,custom-copper-trace",
> -							 false, 2048, false);
> +							 false, 2048, false, false);
>  		if (IS_ERR(ct->custom))
>  			return ERR_CAST(ct->custom);
>  
> @@ -1275,7 +1277,7 @@ ltc2983_leak_detector_new(const struct fwnode_handle *child, struct ltc2983_data
>  					 "adi,custom-leak-detector is required for leak detectors\n");
>  
>  	ld->custom = __ltc2983_custom_sensor_new(st, child, "adi,custom-leak-detector",
> -						 false, 16, false);
> +						 false, 16, false, true);
>  	if (IS_ERR(ld->custom))
>  		return ERR_CAST(ld->custom);
>  
> @@ -1488,7 +1490,7 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
>  					 sensor->chan);
>  
>  	temp->custom = __ltc2983_custom_sensor_new(st, child, "adi,custom-temp",
> -						   false, 4096, true);
> +						   false, 4096, true, false);
>  	if (IS_ERR(temp->custom))
>  		return ERR_CAST(temp->custom);
>  
> 
> ---
> base-commit: d2f2868d2f487b418f68db2ef5bd7cf41722ee68
> change-id: 20260929-iio-ltc2983-fix-string-compare-c919244f019d
> 
> Best regards,
> --  
> Carlos Casadiego <cdcp206@gmail.com>
> 
> 
