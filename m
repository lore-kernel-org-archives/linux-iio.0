Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2592346FB3;
	Fri,  2 Oct 2026 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939099; cv=fail; b=FAo+0p5LDZnm1RbVDYjO7XLnpelYNGnXIUvVe3P6NDD3iYZX66+2zxTIZVKGSw9SqvdMt/qZMaeXU37Ks6DIOQoGGPGIZ8lJwIrGeaah0lDMEvN0wNLBgvSx3c8coo2hrfnPeuHN7zimD2V/zChIc5hsZZbYdb8MzeIevz8+gTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939099; c=relaxed/simple;
	bh=4LHjOSEdqncxheY3NYgpD8vRaaCCMaKgRsDmKDxeoYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ptkKIer4gJA9Frhg3ghJ79nWN0JjxjBwTC/evAzetMl8ApnF2Vh2fHAbh2/NegEv3skTrI/8BHTWldrVqjlwjcrMytEZ1i/gidoJZcJRg4t4dyExmzMaXXxo0b2GXp6hv0BpWJFlIpuAkHAc5Dmp1ztKSm2ni7gn13qCB0/FYJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=E7ynxpt+; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="E7ynxpt+"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6929lPJN2916359;
	Fri, 2 Oct 2026 07:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LZ1sj
	1e4frYBNdFO1K2eq32Xl2WXuHGoQiiJ9ZDATIk=; b=E7ynxpt+k9Hpph89BK028
	wbCmyLBFrJXjRGZ9HXrr7WCLi5NdaDVsv12o/v3JmoFbSLcyCcknukhi5d2u7ChB
	E62qArtIVq+KHk+AAFPjS0xZggcQKJIW7uv/UdB8GhHzYvBXzceWZhTa3hU8piBL
	w1TvOt9FoChpGbRYmpBLqB5fUrZkjcDh8foF/fb7JE5k8yl3eN66sBZvsBbpJnDj
	iovELLSuhjofhssQiwJACTDynqQiyUisFszhOtmz0eAiDNU5hfntILJRDnMBlXc4
	NpG0/sgB61oKn3mrMqN4wX0EeePkorobUgFF/lL/46B7frQDOKbCRF7H0MGaAHB0
	g==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h22nkjmw4-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 07:04:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3b0aB0lwNLJnBsjp464SQaOrvfdWxiKKEbdC0MDJhY5Uy0B6SrwHI9mOpKTtlPwyTDbVmOGnF+f3WLF+E0D6qkSxlbeniB6zCg1KaDkYGM8uKzG7VCtWuD8wc1LqUluGFdvBiheYYPkycJZ/KA6u1mEXZL5y0bdh10vK+2aug3KX+428v1hjheoaVi/Ox1H3maUM6J7WsvT7QhG2BmoDywUZ/zMnQ9pUyHQr6HAwSc4j3QB7tlJE55EdD7q5p3dnBYQmBJhN+NQXFtR7PNp1OoKC7wjPOZlRPY8NJ7aV06iDPpltsEQIWy/8PvtiwugtzkH1J6HcqDXwjxO0pGOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZ1sj1e4frYBNdFO1K2eq32Xl2WXuHGoQiiJ9ZDATIk=;
 b=fcnRxFZ0SlFkY/m7ZKH8mlxbrYuwa563ujqWSxXT9bU79oY8TPSukOAcQ9tXUlN/arw5x1HzEyrOQA6bIBkGTwhCeRj6+G3BQmFGUX7KP3MoY+nTEYAVbigo4ViXoiSK3LvmoTYQB65hnQ1w/bsudR8ci3wfCwPatD5p5ZjeylQ6vSeYI4iU+4vy+fdIZ+vvNzMuWw7xWo9d/+l41Wv0x2ASpTRz9okGl9qQNMj28hCfaodiKGOemQYtkXfpcZyqh/OW9QCSsQy8bX7LVgXnC8Wo6gMbaVx51VimXbsjcaXglBL8L/MS4WICY8wCl60jjKrgjyuu9NhLseS5BbRf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DS7PR03MB5464.namprd03.prod.outlook.com (2603:10b6:5:2cf::12)
 by SA0PR03MB5404.namprd03.prod.outlook.com (2603:10b6:806:bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 11:04:28 +0000
Received: from DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e]) by DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:04:28 +0000
Date: Fri, 2 Oct 2026 12:05:47 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: Add driver for the ADI ADIS16607
Message-ID: <ar-PjHNtblsDyqP_@nsa>
References: <20261001-adis16607-v1-0-9c89cee35d56@analog.com>
 <20261001-adis16607-v1-2-9c89cee35d56@analog.com>
 <ar-JrLr-JHDAT9U9@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ar-JrLr-JHDAT9U9@ashevche-desk.local>
X-ClientProxiedBy: MR1P264CA0170.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::18) To DS7PR03MB5464.namprd03.prod.outlook.com
 (2603:10b6:5:2cf::12)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5464:EE_|SA0PR03MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: 243dcef5-9076-4b20-b7dd-08df2074ed98
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|4143699003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 v8a9yrWhPq5Tvt5Kb39ym9tYEUBgPxuHfKNxNiW0ZlNcXz44iCxk99RIH41mbMb7vhqxVxlFg4H3I54POaQk7Bs6zwX1vfEJs+QLEPqojFb2ZLfYEAd6uYDTahyOJmuVecXcqYVKU6/N+kNh1ExeHQS9bUbKCbRxGQUSgcSZjk4rcuW5VLxZrcMMbrPi39bpRbf+u6bxdFNXszqosAYit1LUKtusNkP2vNmVHPD1G4qDxqu4zuBnS3eQWnHrQvRyUDXRt6kYrbyfJHi+F8HNxUArl1PH3ozrPWmIaz1SFIBkJcrRrZdM6NRgv695OGHy8l7K87Ihk8BGk8V/BU8+rw6/nqoUXc/uZY5J2DftGoyycthJlLONtiFDsiBGHCCV1FgEHQ5yXiG7e1Pz3d+YLYaqTv41EUfweyLrCgG09IxJDMr+fabNmDWcxUEYmFDLgwgsLV2wQSUCJkjESKNyj2Xw7JidhAmOTuVX+OcSviEHN8zD3O2bpsyXX/ALaWyQC9weG8fXRjRvkCh7gf3e+FPU4jxRbOlAck2MugsJ8+0dDhXS/M+6DG77jDSSI+018vhxMCWu4ifZEkffxJYiA5m9MwVKs6fEPiS76XozrSvOR87JKR2Z+Zkc/kRAyaEykn1+M38dN3VB1GFPiulkYg5ENkiGwHzeNuLPUHjsFOA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5464.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?KzltV1llUWovVnNzd3JDVi9yOTQ2WnFra0Q4NTh5LzlXNVAvZUJsa2kwUWFi?=
 =?utf-8?B?MEc1SjNIdE1SZ2s1R2ljZU8vSkljdXREazFncXZXdmU5M0VlWUhpRlhFSFFt?=
 =?utf-8?B?RVJmcUJGcUpyOU5yLy80UGV6K1hJOWl0SHI5a2ZrMGFVb0R5RjBjVlFueFZF?=
 =?utf-8?B?NEVWczVlVVZNNys0UFYvSFQ5YkRqN0w3RjBOSWh3d0lVRnJNYWJnMHF1MW5O?=
 =?utf-8?B?d2ROaFZxeVpDN29SeGRWODlsWGtOTFNlMENKUFFQQ0ZTR0sxSGNwK2pYRUV5?=
 =?utf-8?B?S2Q0RHNwekJEdlRLeTA4VytnZHZqeHlQOUVxYmlRNTMrNlNpY05uekFYcy96?=
 =?utf-8?B?eXJHVEZ2L01EaE9SYjZJeFBWU0dud01zSkw1QnNQVDMwV002UzhPTkF1NGxB?=
 =?utf-8?B?bXIyV3ZkNng3eEtqSVVjbGJndVpXeERoQVpMNFJtQ0VQQnYvVGgvNHdiSnU2?=
 =?utf-8?B?WGhvQWtOUEh5TnR1WUNHc09CTWlibVlDcUt3RzZBYUtURjF5a284Y1BvemQz?=
 =?utf-8?B?dTBpWEdLdWhxVXZhVnhkYTRqSTluVVRXV0JZL3Z2Vi8rSm43TDdETlV5MkJi?=
 =?utf-8?B?RTRuN2xGbTBEckp2RkFBcm9DTHR6cmNkajhqVloyd3JRZzl0S1BXcEc0MzZQ?=
 =?utf-8?B?ME41alZPeml3cTZRcGo3cjk0OEl4QnN2QlZZb1A3VW1DN2hRL01TaGVFSmt3?=
 =?utf-8?B?TU5SWjNxZE1rRXdJMkt5YUM3WDJGWGZTajBPY2xqcVcvcGxxcUZkN2Q2U2lE?=
 =?utf-8?B?VTRhVm5HanNLcUorbG1SQXJpbS9rL0haZFpPSXEzejQ4TnJPbkVEZllFMVhs?=
 =?utf-8?B?U2pPa05uV3BsNDN4UlpJRU8yT3J3VlRlYitBQVJweGRwTVZjL1NpM3d1MldT?=
 =?utf-8?B?UFRnNmkwV0x0K0UwVHRjek50M0ZOd0szanNlc29NM2ZLVzhsZm9QNEM1K2Jo?=
 =?utf-8?B?emFSdGljcDJYbTZBeXU1dHQ4eHpRLzdEM0k1dEVpaW5PQ2grbmNXYkJwZ0x3?=
 =?utf-8?B?b1BsbTVmUFZ4clZhUjB3cDh1K25CdXNyS2R1Q1RSalZMM1lwUjNLcWUwbzRI?=
 =?utf-8?B?NHA3NTJWYW5QTXlza2piMXpIcHJDTndoaDNKNGpCVUpGV0pwOWdYZHJlY0Zv?=
 =?utf-8?B?NjdzbGVrTHFqNTBKRmJqT0NMNmJld0ZBZVEzQm00bnRIQ21yRmhzMnVWUUlo?=
 =?utf-8?B?bUY3NzhCVG1kTUt0NDJMNU00U1Z0Snk3WVl2OVJvZEthTGNUQVFacHJvWjZq?=
 =?utf-8?B?NDFXRmZQWVBITG9IZjRTR25xQkMwTDJyTUpqbUFMUXRQWndKTld4MUVyMzlk?=
 =?utf-8?B?SjNYaU8rbDcvUGZQZTZGZ250bDFJYnM0N1VzVGMvWkI1eTJocml4RTJiNGR6?=
 =?utf-8?B?T2hvN1pmUzVsbkJBV1BoYTYrWHQ0MVVNNXFDOVJtQnRYemV4RVA5Z2k5aWpq?=
 =?utf-8?B?RW5oN051bGNsa2RCeVNlOWJEOVI1SnBHSVhZWXVoTjFtQTk4UnZPYW1PWDdn?=
 =?utf-8?B?Vkh0Mlc0a09oYzV6WjV4RkFob2Zyc2FLMmZzUjg1SUJDSlAwVGJYQTVGa2VP?=
 =?utf-8?B?bkVMQlhUQ1lrREpEZGNyOXhRWDBiSlFRZlVZb2ZRMWVaK2xVRU0rSmRxSnhy?=
 =?utf-8?B?aExjNHFXRDZmanduZWNNNTN1UGRuZmFkd0p0MkZnZ0dBWlB4SVNCdFpIN1NU?=
 =?utf-8?B?bzJGZjliTDJQRGgwL1NDdks4bEhUZ3E3bFFGNW9sU203ZDdlWkZPSm52UTRC?=
 =?utf-8?B?OGtqRXloczg4WmpCcjJIbFdmaEJ1RjRVZlMzWU1jUTFidEYxWkJ3ZWxVcG92?=
 =?utf-8?B?RjJOK3JJSlR6bTNoZk9TY0pJeSt5Y2JRbmRZbHcvUDJOQitDZWlKMGtmUGRU?=
 =?utf-8?B?MDYrcHpubk0yaHdjMEJwOU55eDNqTTgrQTJ1TEdVaWlhRitJWkllTDBjdXEw?=
 =?utf-8?B?MmJJZGIxVmN4VFpEdWMzMGF1S3BPbmN4MS9CbEkrN0paYXRXSVJOOGlhbGxh?=
 =?utf-8?B?dkhWWmlZNXhrMDN0Ti9RV1JPNW44czZkbE0wdnUwVnIrZ1oraE9ObnBlR1dV?=
 =?utf-8?B?Q3Z3WFJJQzdxNUFESDZTcklDaXcyUDJFV1VjaGkvQW9XTjNMekEzTWRVUW9W?=
 =?utf-8?B?bnFubjBtb215MlJzWEdMbUcxRWZDMWJPdTI5dDJtZ1J3a2lDc2VGMVpHQVM3?=
 =?utf-8?B?OFhkQ1JpWXIzVDFkaTUwd0NNM2lBY29DUkpCeVI5aWVWMm1kbkJDTncwVlUr?=
 =?utf-8?B?a0RJa1N4OC9WMXQ4UDlJME5zUXBjbW1ndVRKak5KTlVWSVBhbVFTM21TQTlp?=
 =?utf-8?B?cGtYRUl1bGtmam42MEczckpFd2hIc052Q0hkcmhFbUdjTjRUUFRjdz09?=
X-Exchange-RoutingPolicyChecked:
	WDahuXByYfwrG7GN2IBu49wSKK6AXVi95NnsGxygPVc7lPOfX4iUqVQqh5YkeemnfkSDFWIPyALY1YTAD88q7U3mQDAg15rW1ZLHVgnXk8MvlEbTcak9H+62ZlC2IpLPeQjXAKnoTft3TX4mRAtXjgB590rwe2wLhVwx5cPvvhN0YMX0SfaSkgWu4w279yQ2apfmwtbGA2ppMz4awh0PszLVqmt4REOeSypirmjwsrq1gsbi942PvxvAtUpmIk6lShEUZBf7oQPorq0PfjIvRxMhjGBrDVRmFTGplXiF8CPVWLDGSFI7/SVw0W3BO1ZkSJpwgCPTKnNO1E7FQpxUJg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243dcef5-9076-4b20-b7dd-08df2074ed98
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5464.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:04:28.5622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPxTx7+DbbYThqE7qoRkrr8w77csygW0Au8KhdjEshqGWqxlks5436cenjLBJTY0Vfwaun+HaQt2PLMGzjG1ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5404
X-Proofpoint-ORIG-GUID: WR8q_fqOhYsd9sNb8loPi9M5aSjqguyt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0MyBTYWx0ZWRfX0Op35MRyzhGV
 iiV4MCXosSqYiG25S7NzuDggO03rJg6OE4ssMllaObIOh4ax4GRZtxVjPX2TLXOu3hZvW8MuPn8
 schDliTjGWFJ0G1kUGBCVCBGyhIZRW8yf6iq64yHIyaXrhQrYaprpemzhAI+YjolDvvFeghEMaC
 KZZE4HoW39tQ9XepyyQqKTbekdBRLFtVNo4sviVexRte886G86k0sJPGPENHBCgpR8ks6h4pVaG
 V5K7ZqrnBnSYBWxlvgckWilg6xgVCD9xcmBe9xXRoMRfIm7q5BbMvkEj4j92JpWaJE6p1UKDZms
 RJrvuZjhTT3Zm0AFxgXi0B0V0tSGQBCbq7s2g71U2WRxwnpAZBdPdPxzWpSX2LM6qPAmCs7RCKP
 w9QM0Djf4vH9DO8rVSjkyTn5YCG9Fx8eacgvJmIEyBDl9a2Nv0TlgEndOC2deN2S1CszARSUdNh
 sJHXl6pq5tGVydw6XiQ==
X-Proofpoint-GUID: WR8q_fqOhYsd9sNb8loPi9M5aSjqguyt
X-Authority-Analysis: v=2.4 cv=e7yT2qp/ c=1 sm=1 tr=0 ts=6abf8fc5 cx=c_pps
 a=4YDC/s56AEiJKWlPnw2jOg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=P89yEXoz7Pk-DROvz6AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0MyBTYWx0ZWRfX/UGwqlvA6f5/
 UhN4Bi81YkCcuLSbKc0Mi3B+K6Wr2WKSk+uvh2nl3uMufubICZOyC+a/FOQob3WYPcCCNOI/i47
 a6jXVg10eq2+IM93aGbHqy8EbvMXEOQZBUnVGRNd3MFWnFqWPy0P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020043

On Fri, Oct 02, 2026 at 01:38:36PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 01, 2026 at 12:11:50PM +0300, Radu Sabau via B4 Relay wrote:
> 
> > The ADIS16607 is a Precision MEMS IMU from Analog Devices featuring
> > triaxial gyroscope, triaxial accelerometer, delta angle, delta velocity,
> > and temperature channels. The device communicates over SPI Half-Duplex,
> > requiring custom read and write ops that differ from the standard ADIS
> > library protocol.
> > 
> > Three variants are supported:
> >   - ADIS16607-1: ±125°/s gyroscope range
> >   - ADIS16607-2: ±450°/s gyroscope range
> >   - ADIS16607-3: ±2000°/s gyroscope range
> > 
> > All variants share a ±40g accelerometer range and an 8 kHz internal
> > clock.
> > 
> > Data is acquired via 32-bit burst reads over a single held-low CS
> > transfer, providing 24-bit real resolution for all inertial channels.
> > 
> > Supported features:
> >   - Hardware FIFO mode with configurable watermark threshold
> >   - External clock with direct and scaled synchronization modes
> >   - Calibration bias for gyroscope and accelerometer axes
> >   - Configurable data-ready interrupt pin (DIO1-4)
> >   - Optional hardware reset via GPIO
> >   - Sensor self-test on probe
> >   - Sampling frequency control via decimation rate register
> >   - DebugFS entries for serial number, device ID, firmware and revision IDs
> 
> Good, now split this to be a series of 5, for example.

On of that I see that the driver is skipping adislib helpers like
locking, startup, self tests. First consider and think on how the lib
can be improved, changed in order to accommodate this device. The less
code we duplicate, the better.

- Nuno Sá

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
