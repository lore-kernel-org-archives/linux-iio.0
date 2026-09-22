Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97670554090
	for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089339; cv=fail; b=CZjLz4zTnPtb6a59sixiGxhorOrjIkbQ+Rziurr0pBa+1oJkicKV3ymmF5wUW04vrgwfhLbN9DFoIJ1cOPBvPZbqLKtLQk6OptE90cBR8kSs/YetEvIhMZauAMlU8l1ztGj2T9cGxCkfOiBdBAJgxSgCe8imTt5M3C5jQAj5SLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089339; c=relaxed/simple;
	bh=km+9K1zwyBt7PqW3EjYHhP4P4mdEHPnaCjmntqBn2V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FB9Jw+iR15t8NjmeVJHFbl2YfZMqjVG0kTFlvGmB5ZlV1F5oybkixmN9HF//KScwaUqO//xijL8FVZr04yTt4PzffCglbsW9u+1nreHIHBfOL7GkFSZi+XPYvFoFE6XlSCkd10XYtVRja59YtYvZtlq+f4FZscHV0HD+SHn0HkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DCLP6IoP; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DCLP6IoP"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MEjJ63599868;
	Tue, 22 Sep 2026 11:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Aw7Sq
	Q9RYwv7eEWa6E+aKK9PUNGuTlofkY6HApMeyn4=; b=DCLP6IoPnHn/bJkOU7eln
	s82TD84Dn+iDwPtSW0mxgSqFtkflF0NC9mXUxAuhKitH20ocq96rvE6XO02AdK82
	vLrrFnBSCpplIHNEDzuJ8uQk5KRH6p02myvZ0QR2pS909QrqwlDhB3ol1cEFwDcM
	AeFNauGgsXMEBzeTN0DGoDFQJGWUIzNerjoUPXbMus/XD+piBZqifeOjvnwtDA+B
	AFD0Y/Dh2XKEfyPxAO2fNWmqu9xVDTwJwh1jpBWgWIIobeM32yyyA2r3uNscf6yN
	lQNpU/ItfCcX7B1Xnd0eAC2AzdXeeFY3L8eznaOpOmOSKvyolBY5NDd1HQFZJmce
	w==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gu9ydn2sy-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 11:02:13 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDFQShpuuDhByus4vgkaxE85vgr3DgKyXX1w8BDVLUX6nI+qBRmpHxmOUaALTIobqwnWVsxHY53PehQrQ9K5R1vHrsXi4d00Fb0jRXDIlPoFpXn+s2u5oSlmoDO6+bd0dKAG7Ra9uirxe6vvQrrKovsvl/yjgv3e2qj01nBGCpQIctdF0wVWj58t1KgszMdpHjhPcev/zz3OHYjQBsRvz4bJk4d3KQYKPVN6MBxdKmX33LazZLW/wGhKZPG7M4QkU+canbk/nDvtIlOjRwxsb1+zRqa+4eTouXv7V6wojx4cjvUItz7ZZv1V3ZZdcrRq6DudhXFm0oPM9S8h48Gj1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aw7SqQ9RYwv7eEWa6E+aKK9PUNGuTlofkY6HApMeyn4=;
 b=GsS7VOqOy5j47LpNYbrwtoFO7xejdDZ/CffKFuSHos/FdjgQ7HhiCsycquxR7WxEOYhy7FTnWILSfDDOx5sH5E5IP7DklNFpO2fTBV6/qRAckblas4R+tsLnUGQbbOBUoFnCOrYLxRwrU//nRYizRaLeqG1F9gQ2yLRh4SKko3XdVMofZOITv1XC8ng0/One/TbdH07tbUUriO//8NM7bD2JNo/I3ZgFrUVZMTG3XrtVP6rjZkQKx2xHf1YdJdqycgOP4jlcln4XF6kxtyCvNomLCA4bEY2haEcqf1gy8pj6ZxOciz6ZRWXJZQpoILj0yh7oibmM5ulb5hya0D7dcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BN8PR03MB5027.namprd03.prod.outlook.com (2603:10b6:408:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Tue, 22 Sep
 2026 15:02:10 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 15:02:10 +0000
Date: Tue, 22 Sep 2026 16:03:26 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
        jic23@kernel.org, andy@kernel.org
Subject: Re: [RFC] Maintainer entry profile/contributor guide for IIO
Message-ID: <arKWs7nTaJAda-XA@nsa>
References: <20260817111825.000063f6@gmail.com>
 <cb1937e9-c2fa-4d8d-bd95-f53423d88077@baylibre.com>
 <20260818090652.000020bc@gmail.com>
 <arD2UjzKu2k8elgM@nsa>
 <20260922165124.0000132f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922165124.0000132f@gmail.com>
X-ClientProxiedBy: MR1P264CA0031.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::18) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BN8PR03MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: b7820ac5-96c2-4912-a292-08df18ba7a52
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|13003099007|56012099006|6133799003|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 W9H92aYrP35rRwMjQOosujZO057DllQHy7nbny8jSTpOql+5e0jh8ZNvqpr4FUUHpVQAIDk0zUAkn3u+lywUTCKGNUjDXZA+A/sM7TDF7d8rtEr5Ye9nuJ6xK76fRQQ3bVwZCTK8faERYxvKXfS5S7O9l/M1wMowfis/u0ZvLnCfIWVfzYXIB5Hyo0oHCnXw1qbVxgUfKskgvx0mIRhzKHxVXN3NaUCpqZAP7/3F3QTT63FNRB22Qg+t0D/aH3vW4y+FyUzTZz8ujjMznKVXQf17zNw+Xz8Sl2wCQ75iGYQbZNhSpYme5KVc4+lJuATYgf68fyzxFPqe/A8udteOlfjQdQ7B2+QY9J6/aYZ5kRf6vpWCOFQAI+kiDPQ+f8o1ifVbfcg88WQ+4Vo2td6DfB6YaqOhXD2YeSbTIaHLkCsKZlktJ3iq+oW/mAGThjDSFtW4ysd1qUVKXZtnF7lnPPSXWi4gaT28jYefq329M9OY5M38c2tvfQ6bxK2lr6bgIkJMfeKtnoDUjZPvSDFUeGAblL5sbaCgSvu75Nu87+YWOPudL/lwlBa0Yj485uGzKnS6wLO7npRlb5QDYe5Xde5gpXI4ikq1u1Wqrytay6c+qBBSMVGNyl9GCx6EIMEVmVKdOoE/P4+Afrr8KjeSt8esvg69C2Uqe+AKQLX3FQA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(13003099007)(56012099006)(6133799003)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZklSSHQxa243Slo4ZnZXSjJHMThLV2NQYnR3by9aRlVhd0wvZzljVGJPRkE5?=
 =?utf-8?B?NVJhaVp3b3RCTnJ6Sm5Wblg0bFFGbFhCY1ZxeExrWU1LSFhUZzF3UlBBTFBr?=
 =?utf-8?B?b0VIWGdwWXF1cXdCcTU0NWdlR29zZDFWWFlCV3NDbXdFR3dTKzZxMVZTT2ZD?=
 =?utf-8?B?c3V6d1R5bExaSDIza0NGV0JTMUZFSmRNVzBrMmNuZHFhUjRML0VUMXoyYXBG?=
 =?utf-8?B?bVdmK1FUcmlKbFVZcjNGTytNWUNYOC90bnpxbWQ0YU9PcUZyNDNPWmFPcjNw?=
 =?utf-8?B?dXgyRExudStVdTJoNXRwS0VXbmNkUnJFSlJERDM5YkhMa3hZOTRoQ2NuWTlt?=
 =?utf-8?B?WXVoNGJIMWxWd0toKzV1U3JROExyRGVnN2gyeDNsdThOUE1PbFlKNUkxRmVW?=
 =?utf-8?B?QmUyYjV4NWxBMGhreXJ2SXp3cFR6Ky9vc21xeldhNmQ3YzYrZGJTQTV1OHB5?=
 =?utf-8?B?VzNBZXBicUZvWWhpdDkwQmVVSG5jMHVyL05OL3lzU3RqYkY4V2c4SE5XOUtH?=
 =?utf-8?B?ZmhhQWFWQU56Qm80VGlGN1ZTZTZZNmszZkFjbmRlUUVHU2VEQ21aT2VVamFl?=
 =?utf-8?B?UXAyUmhDVWYvTmdXNHcwVlJORGhoNW9DNG5ldnkzRkxPUXdXbFFpUjV2aFJP?=
 =?utf-8?B?akFISDZMVnF0UFJjRTUvelJpdUJHZUxwc1F6cVM0RWk4WDV4L3RWVHhYdHVY?=
 =?utf-8?B?ajRNdUd5MDVQaCtKdzVMdGl3ZmhVa0lHTEZXOUUrVGRuUTlmd1AweUxIR1pK?=
 =?utf-8?B?QTdxcmlYYXZoUFFud0hreC9KTGtUSmp3a1FJRTRQcm1ZRlJPWjhMR3VnUVFw?=
 =?utf-8?B?Yis1MmZFYXdCMU1va1ZYWDRjaDhrLzMxU2JKOGV0ZnJJa0p6RWo2QzN2b0x0?=
 =?utf-8?B?SFFkZWREbzhsWFJyNlJndExZUitBYm9VTnQxTTJwaU1jdXI1UVBKN1BpUWlk?=
 =?utf-8?B?U1d0bExZajB2aEFHS3RENWxiejcxNWx2Q2gzbDlPT2lzNTQrd1pQeFhqYWpR?=
 =?utf-8?B?eHNsK3JlYU10d2R2YllST0V2NVp2Y2VtSFA4dURSOGpzdktjSWhqRGIyWGhu?=
 =?utf-8?B?b0RGazQvVXhpK2JYanFlZUtKS1BPMi8vYy9wL1N3RW84NWFPcUMwaWFaMHZG?=
 =?utf-8?B?cVFRYkQyTkVXT2tvRnNoK0ttRXBFeUUvTWZady9VdmxZVFhSb0o1Nlc2a01W?=
 =?utf-8?B?ZWFRWjN6NFdxU2w2TERKNE92VmhYWm1KeHdsT3NsSG92RHIrTktkQ0FQbi9T?=
 =?utf-8?B?QVkxWVZXeXlZTnBxQjNBU1pWWW8xcDZURmFOb0o3MVZuTkl5ak1Zem16UENh?=
 =?utf-8?B?Q0RUT0lMOXY5ZjBGRHRqOVdjMXJOcmpMQjZiYlQ1QVppWU84QWZaSFlwU1Ur?=
 =?utf-8?B?a0hkTU5oWk5zR0N3bFBET0tDU0RzUkJ4UGJqOXE3Z3VTTzdQVDNXbEw4TFQz?=
 =?utf-8?B?aythQWN6ZzVZTVovSk4yNVNnSDdHWG1OckNvQjdJVnovbVEvUWQvVjhDMU5u?=
 =?utf-8?B?MWRsdi9MWkczdk5vakg3eDRYalEyV3YrSTNDYzRPcG1kcHFJNGVvWEtoSmhh?=
 =?utf-8?B?NmUwSy9WUzVaVi9DajB0QS9CakUyQTJ6dkJ1cWdCa0JLY28wczhhUHRvZkZB?=
 =?utf-8?B?LytNWGlTUDNsRGNGZlRjOHp1d0VFUDZ2RzJ5OFpMSHI1YzRVdGJFMUNWZVh6?=
 =?utf-8?B?OG5tdTNyMFFrY3hBYUNBcjZqeWFMVVN2WGhxb2VwM2dpVFVnTGlLL2xibGp6?=
 =?utf-8?B?K2E5VngwZGZlU2RPL1dneUxUS05xU0JuRUlvL1o3c3pJaTJ2elB2VnF0b0pD?=
 =?utf-8?B?L0crVTJJQnR6SDBWYmxPcmtOay9Zd1d4RTQyMmJnZkpMcno4SXBMZjM2aGdq?=
 =?utf-8?B?eUVoL3dNWHlkVGgyaUsyR0dibUNSNnI2UEpuTWI4VDFmRTNJMnRGMEhVVTh3?=
 =?utf-8?B?b25Bby9YOVFVVURLQU5CdC83ejlyT2tlWnp1ZGZYd3Y1Q0xVdWxoYzkvZTJo?=
 =?utf-8?B?enRveXN0WVZCMlRLdytndjhwUXRsZzdoWExHYzdIZWRtT2lmUUFrSWlubnhJ?=
 =?utf-8?B?d0k0ZTlSZC9MRUYrTERnaUs3dzUxYTJJTjVXYVIyb0ZjSmRuTTQ2bHVuNEE2?=
 =?utf-8?B?Ump5RW5GVCtDZVF4RXcrZnFkcDBjRkZSdnp2bHZONk1VcVI1Z0NmVVFNQkE3?=
 =?utf-8?B?a0NWQmtFckdrZUJHZFpubmlWbThCVG5nZ045dTBJaCtyUmxzb3BrcE5Oa3M5?=
 =?utf-8?B?VGpERUlzcGtPY3lPVmpuN0Y5MEZKWlI2bUl1bjBYZE1NYTZQMmdWQ0RzeGQ5?=
 =?utf-8?B?ZkxLazBGQy90Ny9rUkZCVWFiU2lSeHd3K3ovaUVMZUtKZDl1cWxsdz09?=
X-Exchange-RoutingPolicyChecked:
	SRHutSChxtvzo/k/L0yoozCW+94ksqt5LUCG8M0yivIQ5tX8GtGcjHZA73Y0hllrLgKeBMwXKMhyg/RoCsJAkZym9B9nnBteR8Cl04UeY4iHhIpqnUjz5jDG6KIwW6UxuOVE0T2K6nccD9civeJz8/l5JwbVinGi343E2a2ulRsfX1Pwqa1vh2HUhywIJssE51KMZ1RYCdOtjDjguosbCGefKr8cgkJVMcZDZzqvzuQqDzj7nW1jqlsob0DNEh3lUV18+HfMGAj/pA5Pbs8ypscX7xOL8+Hfme9YOBH0ZISBIASzkENaiNKpmrZkTe5oZa6cR54GuvM6NfnJ6+yf3g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7820ac5-96c2-4912-a292-08df18ba7a52
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:02:10.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vB0o58q9mnfAlfJcF0QCGMbTN+kzUBxITxEaS0ZNTVKySuKja8iJydBlRFuYKDVjHQe6mLx8GcspLUzcgtlk8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5027
X-Proofpoint-ORIG-GUID: vJfSJhpFMzaGRO73xFGpV43f1PcJmSwb
X-Proofpoint-GUID: vJfSJhpFMzaGRO73xFGpV43f1PcJmSwb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIxOSBTYWx0ZWRfX+002t8SsPsDK
 4qE9o1OpTabefABnQGLnZU6eq3/o1m1tK/zgkJrrxkN15arWvVHhRTTCWg6L3TT0RfpLomRUFWH
 Q+TxxtaobDrwvbZqORyV/UJjqtmRX48MxbmwnkkSD0nf7c1pZt4Q
X-Authority-Analysis: v=2.4 cv=OobaWC/t c=1 sm=1 tr=0 ts=6ab29875 cx=c_pps
 a=2iQKv3wDMkjwRE6X2MvZ0A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=NEAV23lmAAAA:8 a=e8O0uTMVAAAA:20 a=gAnH3GRIAAAA:8 a=Jy0XmTB3iiWSv5Pbc5wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIxOSBTYWx0ZWRfX2jqNKlTsMy9m
 ojdTvsqMLXzak7CCVd3b3zz/xR+5wifYwDGLneAGZ/1hyvPsIFgZAmKdmH3l3lLRzXgRRODpPcb
 QzrnWD4Oki02BB1G79H4/jKdCdfJCtyFDmYWYS4tnXsTrjOifDpW7hieS3BNFnhfb8YId4tMVil
 199X8xPSUw3QK4865YmmZb/S+6SI+LnE3a94Wrhpmt1lnklrDVl76yvCmwoJExj/NWrlJo9Du41
 NnwEbpYNNL8rhFZdVKXQCI0KnMmEFEXZmFqOKhKzOowi0kZjpDgDhyUPYKjGnVNc5PUaKs1EFMC
 0b/ONymvNWjLsesrbBrLmLJh5AQW/PvU/KSlgaL1Dm+Ys1jgwquWOZGRPzFwuWdfWijx+zI0xMC
 s4xjfJG/WpCMwHkz+8UUdj0lfkZS8FouYz3o2NUrQyka2bN7B+b2oMi458aUckmkB+BjD63a4fg
 iigLZ8LNBAg0Yd01dfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220219

On Tue, Sep 22, 2026 at 04:51:24PM +0200, Joshua Crofts wrote:
> On Mon, 21 Sep 2026 10:28:24 +0100
> Nuno Sá <nuno.sa@analog.com> wrote:
> > > I'd propose 2 documents:
> > > - entry profile - documenting the review cycle, patchwork, point people over to
> > >   Sashiko, relevant git tree etc.
> > > - code style - the TODO is fine for existing problems in the subsystem but doesn't
> > >   point out idioms we have in IIO, i.e. not using (the awful) kernel.h, preferring
> > >   devm_* functions, not failing on a mismatched ID to ensure fallback etc. This is
> > >   stuff that appears a lot in patches.  
> > 
> > Personally I do think we have some things (not just coding style)  that are very
> > specific to IIO. But maybe another docs file is not the question. Or at least one
> > for humans to read :)?! Have you evaluate just having an IIO entry for
> > sashiko? That way, hopefully the bot would take care about the subsystem
> > specifics and preferences.
> > 
> > I wanted to do this myself at some point but I'm always pulled for
> > something else so if this is feels like something you agree and would
> > like to get done, please go ahead :)
> > 
> > [1]: https://github.com/masoncl/review-prompts/tree/main/kernel/subsystem
> > 
> > My 2 cents!
> > - Nuno Sá
> 
> There was a thread about adding Sashiko reviews to IIO but it died out :(
> I proposed adding an IIO-specific prompt. Any ideas on what it should contain?

Not sure if I get the above. I already see sashiko doing reviews in IIO?
What am I missing?

What I mean is adding specialized IIO preferences/tecnical details to it. And for that
we need to add a new iio.md in [1] and a table entry in [2]. If I'm not
missing anything.

Sashiko is using the review prompt repo.

[1]: https://github.com/masoncl/review-prompts/tree/main/kernel/subsystem
[2]: https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/subsystem.md

- Nuno Sá

> 
> As Krzysztof says, there isn't really a point in making a new doc as people
> just don't read docs (I know I didn't when I was starting out, but perhaps
> just consulting with an LLM was a mistake :) )
> 
> -- 
> Kind regards,
> Joshua Crofts
