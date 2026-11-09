Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794239963;
	b=abv/Ild6TpiPL/cN8yNAw3DEl6k3rm4k0OLAuwbz7V9E4IXNsxeWGdAUoaziY9oQbGy3
	 w/qT90aDu9nz2PJrJxYnuELAa30CX4Q1h71RtOM9qcj3nLcJevdcUbrdW/9547Thirn6P
	 iJX/flyPJbINXEp09F/NYoWjoPtkwEGUVuZmBSDJ7g3svJg1ksoHJiAZkBrb8MCDzcy8a
	 RfJa2Lat3SQSGmvXBGIVjQiggX7N5ig2l9MG0NrylEIcr6kIkZ9z5bmZKMQSEZ/YF8vVp
	 cNr/So1jm4gopN/D//1w10Y+4WaCoCY7ovTU7XTitynyeMf/BUZhvhSoUMdWs+DmbIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239963;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=tn7b6NgqBoQMhPMwc1deiwdbu1BjKbTmiTXvd0LFaXw=;
	b=uu3uRf910wl+Xnq/philp7nKy498cDn/1E13tNhJHuVhGQdTzZVURBX71TMI0ATAujOP
	 AVPUSAUPKzILkSWdvmeK4/QxDop4tVerdDS6fWY0UnHGcr/SPRkMJdsIBaOdl3Gn353g3
	 1HvVU+rCZnFiXud2K/45kjh4+gtRPlc3rjeOWZPKpYSbEvkMYr6ZrWNXBbsBeVD+hZ0cE
	 gGXvBDOVxJu20IjiksCPOcL0m+x4NfvBaxHqs39BV0JMFjOJKpZhosd/LdqTxeUOmFTh0
	 nZc9O0lAOdniWEKEZ2t7olLQYaboOxek8uEPhWO/fyU7xyF0R9zX2rOVDYRlJtTxIbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=bRU+O3oh;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Te4qVqnL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088B6606A32A;
	Mon,  9 Nov 2026 15:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 088B6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=bRU+O3oh;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Te4qVqnL
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9FPcr91582459;
	Mon, 9 Nov 2026 10:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=tn7b6NgqBoQMhPMwc1deiwdbu1BjKbTmiTXvd0LFaXw=; b=bRU+O3o
	h5h2Aba0gpvt7cDSnglY2qgvTjNjDCkzl7UPdWsbXefmUdEXIoLM2hVnalhJflRE
	KiL6lKBUI6kvR1d4JqJNPgKNOQL9KDBfuyogkpPu03oRk6wnbxVJvFjQFmrIAcq3
	2DqqKI4ueXgyishYP99HGvcxkFvCedZeOVz1KPJzWvVG/o8yemPB3aQcKDjMnnS4
	qULBVZSOtuovVAPvzbIpEijVNbRtWhfc4SahYdcT5iV+6MS4OcrZSWlqChdnKXgQ
	v+FCqTMaQA9F8CUdrFElUzIRgM2HOmIxU4wPUqoeccg8v+oLFKPmWlo8I5wR1BtF
	Jx93VNhLV42A5+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tn7b6
	NgqBoQMhPMwc1deiwdbu1BjKbTmiTXvd0LFaXw=; b=Te4qVqnLWSYQSdG5+nIbN
	I3A6OTwIj5kifFEgwodaz96paA9ppOEfQF8sYHr4o7u5dJg063zsAr10wm50hekf
	Oh1dGC/7H9Sz0eMjWeHizoWdhBc1kSEkhiqT9tI2RB+AiFq5XlqjCvSI9RoGTGc4
	nnSrtUvCziPGH0X4GvEOTGWg663Y4APEHpb92GY97idNkG4FFNBZw0Sh+6YgI4I2
	VPxPMjI8l7ssOI8opUuCsvK1H8s5PdBs/iBrHBHdrSh33san1B+uWM2aX8+IU/4e
	t0u0gf/zWcNSxi5zsJhfOlkZwkGX5ew4xBdYfCuarvg51LwRq0l+EJzS75rosTXw
	A==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hugta0a0w-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 10:59:01 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5i4llq4e71nfCXWVT3YyXgCQi/ZF9GqUrK/BGzrPYfWwNTaBF0DInRybGXcA1F4w/2HWaQbZkxBTRrf/VVJpm08mn1V/FOgadanoyHdaiWdR0XcvhTK63oe8aGeBQlwAEUSHjYRBWATuuKHm4dklv8Yl7rGH+UuIxTQ2qVsgl+BJ8aOoWkjvG+dOeD/0AEg4KOClFCjNVa9ozixmGAYPwQsLL31iEbJBeDQyQwGnggQtR1I+zwJLC9pOMqQvv51ciEBaovJs2Dn46k+ZrqUT3woxMTsvJffkwiZpDdN8NeSw2dgJjr0jDU0hJuYnwNdVugFl8mgXXh3BQLo64q4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tn7b6NgqBoQMhPMwc1deiwdbu1BjKbTmiTXvd0LFaXw=;
 b=xe0CJQvUSlhBSKz+2BlTeHwgSjVWstzRlg/cjzaDoBN46Q6+KJDLPMfdM8WlC9SdaHsuX5lVt4cRp81WExObrlJ3TL1B6JQuAnC2CAoGwDgj8OStWYYpOV3y5n+qxkQejy/5bWc4Ewq31h9QrJoDq6QqFJ2JjVzAh+ufhY6IaMU5Ml33rp3tgavkmLDzfPtVvhlZ2JPpi2Za96mixR+EvatgP7kGWQBLK1r5NdXZ6YSlHNi9V8ptF7nK/5cNGP/h0R0hX3KgmmM5CP0yKq0uUu+GTLGQXtSXIYlr+4wJ75f7pAjxsnpbiniSeenJrTbaA3lbcIpuu1/kTXFIEksK/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DSVPR03MB846340.namprd03.prod.outlook.com (2603:10b6:8:37c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 15:58:56 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 15:58:54 +0000
Date: Mon, 9 Nov 2026 16:00:21 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Song Qiang <songqiang1304521@gmail.com>,
        Radu Sabau <radu.sabau@analog.com>,
        Maxwell Doose <maxwell@maxwelld.cc>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Erikas Bitovtas <xerikasxx@gmail.com>,
        Waqar Hameed <waqar.hameed@axis.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [RESEND PATCH 00/14] IIO: Ensure iio_trigger_poll() is of the
 device owned trigger.
Message-ID: <avHt_kXGwyQNHQx9@nsa>
References: <20261109042851.1326940-1-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109042851.1326940-1-jic23@kernel.org>
X-ClientProxiedBy: MA3P292CA0062.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:49::18) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DSVPR03MB846340:EE_
X-MS-Office365-Filtering-Correlation-Id: a96922f6-100b-40ca-de07-08df3e7a5af7
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|6133799003|10067099003|11063799006|261102123227099003|261022075727099003|261022105027099003|56012099006|261021123027099003|261021121427099003|261026140227099003|261009221227099003|261028144727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
 BMLEsRc3ZM1Xqz7K5hA7xSuP1LSUXeXJ6KF2fpMeTeicbJif5jyQjcJZKcYZSUM86YetmtY2gwp9PIO8gUeZkxX7jqZNd49joDZMHO4Mkq4fS4rfnQmvGBTsqYbtjJc3tSbgHLEWUBcyoIEoMt88xDiIvchPSb3pbb0bB2n+HOtQazRai/aaS9mVUDwo93GVBM3irOCQuiwookrat4mT542FQa8fkMSvGgggq/wtC2zD+t+FfnYHJLS4kfMLQnAZJvo1jVaqkRUNcLLWbrkDbwAOUaLlYlQa3MofBNi4xeeGBqDRUORfcEOwnfuvLljRz+1o8JWyr02MZQzMWus3bqYxUB10J5bxC2kQJlrHdhixh/i2JRFvVmx/z3SI7N/Lg4TkIPX8OX2HtPXusMSxWY6qANGRui4FEQ9oNQ8ayl7s+um3ApZOEgmrWjiDTmtK1FyfmJSgKKGoZpHax0m1O3NM/91cmZncwV6m+Gk9KzyMb2dqcmzMD7okzdMcHleyANvN5j3aebHVouCT4XnGPaOv3pch8Tksy+SUrx5st67jU+ihlc9WxeYcOIV3Q0Xgonj8OsqzkqsV5Zvw4I4pBZVfMIy5JtMGWhtH18oaXobHHtQ66QdZ0OmqF45/Ex1Un58stvb+54fpOCHkKVWyIZqANzrM0oubH7bP2a7G2ew=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(261102123227099003)(261022075727099003)(261022105027099003)(56012099006)(261021123027099003)(261021121427099003)(261026140227099003)(261009221227099003)(261028144727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZUQzMUxXNWttMzdqUGxPWWZIeHAzT2MvQ3NiVlRIY1E5TmRLM01NdW9oNWd3?=
 =?utf-8?B?bDYzdmRhSFVjVWxqQU4wT0RxMnBmVzczQ3R0ZnpEeWNMcmpIWXdUYjZEL08x?=
 =?utf-8?B?cWE4S1ZUOWpmVjBKQUhmcUloamIwdkNVT1ErYkJ4MnNCQTN1NGg1VlgxN0VI?=
 =?utf-8?B?ZWlRWDdTUXFHd2VQWmltSVdML1hJTm5SM3Y0c2RtUXo4Y3V5YmtOSEhCSnVS?=
 =?utf-8?B?bFNva3NRWHlXcHl1US9DdGdTS21GRDBaY0ZDVFJXR1lTdk4vYmRKOEFzR0di?=
 =?utf-8?B?Nnh2Zm5JTzQvNWtXSmdIMFhENmJ4blREQW85VC9USVVkdDYwQVozWFFGYndx?=
 =?utf-8?B?WG5xSm9NdHhPdG5RUWkwRkRTVUhwekNtaHJMRks5ektGSzlReXpnald2WnM5?=
 =?utf-8?B?WU4xZlM5VE1WMGVGbzdtYTQzbm5ZdW9VRDAyM1pxWUdyVVVVanF0bUx4ZDZN?=
 =?utf-8?B?TkdpVW0zSTRxUUcrV2EyWXMvWE51MnphOGRYdWJlT0NTZlM5ZzFPTTBxRms5?=
 =?utf-8?B?Z0NFVFI0ZDAzVnQvLzRVS3V1MHVST3lQTTZKMisvOTA5bXIwMGM0WXR6ZFV1?=
 =?utf-8?B?Zy96dGNNeUYyaWozcTRkM0NuZEFydlZWTkZ5amUxL3ZFVDUxdkRMQTl4Um94?=
 =?utf-8?B?Ymx6VDhwVWljNzArOWpjamtPN3c2TUxTSzFzNjdoS3dKQVZCT3JPdlk5OFh4?=
 =?utf-8?B?eFF4TGg5MkJjN2w0OGo2aUlhRnhmNWR2ZndKUGJXaHlHeCtiajY3SmNORDlN?=
 =?utf-8?B?ZXhLbWhrQzIwY2g4dUFHY2FvUTRXRDZueGwxWHkxYkgvamFQNVRCS3VIaW1B?=
 =?utf-8?B?MWVvaWxnSlBmS0xYSW1KODJFWjk5YXNEcjM1MWxsL1pSdEpQNHMraWppNGRh?=
 =?utf-8?B?aUNvbVBiV25RV0hzU2wzbG8zWTVjd2hpdTlVN3pEeTd2R1ZvSFI5bHZxeWNh?=
 =?utf-8?B?WjlOYlBuS1JSNXJxdm12cFRtMUFWWkR5NXkzVDR0QmhkMU41K1N3bUpaQ05T?=
 =?utf-8?B?N1c4akFuTzhKMXZMNFdOZW9KanQ2eUxIT0l0V2hWUjNhdkNNRjgzbFN3Z29x?=
 =?utf-8?B?dzM3cHFDUThIZW43VUNWTVNONm5tZEZZRFgxa2dQUnlNTU5EKzdYcU9hQ0Vt?=
 =?utf-8?B?d1duYkx1bGE1MVRLRmF3SEkvcWNlWHZXM0tDc2l0NVZGemhjWU5qMG9QTU5n?=
 =?utf-8?B?VXhuVHRibjBja1owdFY5TzZ3T2pmVFUyYm96eVpoYW4wWXRjNE42Vmt5K3Qz?=
 =?utf-8?B?TUFBR1VXZHovVG5CK3g1YXpYNEFyZ2QybllJTU1Ibk14KzljSVpjUUFVV3Ux?=
 =?utf-8?B?bDhYZzlTKy94Ym5oTDlOYWFpNldwTEFSZklBbUNOa2ZqYVJlTllMRUlKa3Bv?=
 =?utf-8?B?SU03eFk0UGovSUExaS92VGlmNmhQbG1LL1Y0dVV6UmY0ZHFQZTFTWVdhN2lO?=
 =?utf-8?B?RFpIZ3YrdFpucjFsM2doVFk0YWRmZUxhZTYvOVFpUTBQYmF3cG96MGdPUTc4?=
 =?utf-8?B?RDhsT3BlT21mOWVJQ1dkUTJaeW5QR3E1VUIwMG5EcEgrTVFPeHFYQThRYncx?=
 =?utf-8?B?OXZ1VnZjNTliOWlkUjdXV0VFdWx2Rmd1SzlqV3dDRlU0cFI1RnAxMkQrVjhC?=
 =?utf-8?B?YXNvbEpwQUwvcVNuN2ZINXRGVEdmT05IdWE2TUJoZlZuNVgxdUhzVElSOGZI?=
 =?utf-8?B?UytrdFhnK0N1VVNEeUhTS1NsOU1IT00zcEFmL0FBdG9FaDE0cnUzWUcxN1Nh?=
 =?utf-8?B?OE9zN3k0ZG56Uk8xL3g4TTI4bjZSL1lRcEFOVElNSXdpY0luek9Zc040OFNt?=
 =?utf-8?B?SVptWW0zWjZrdmYyQzFORjgrQ2dOSFFEa3pHTHJtY29rWmRiek9FSEJiOGlW?=
 =?utf-8?B?b2tsSkZDcklCQ3gwYU1CNVhZekxJZ1QvOEFYdTZCV0wxamNUMkwyRmhyN3lu?=
 =?utf-8?B?NlFGWUVZTk5vd0VhdTlFYm5oOGE3QkRNanBhajhqc1h6MG1sL0xhQW5yOEZY?=
 =?utf-8?B?RFQzUnFCTVk0U1FtUVNCbWxSZldOUndNMDh2b0tjcVRQL2RseXhxTXJJT3c1?=
 =?utf-8?B?YUUwOTdNUVMxN1QvM2dSRVdLdUw5MFhiZGNzVS9DYVVYbkIwSEg5STZHdnpI?=
 =?utf-8?B?dm9GUzJtN1U4YUtIVUdnTFNvSUxJSTVraUpkSGF6OVBBR2pZR1RuU2NEYzEr?=
 =?utf-8?B?Z0gyL0M5NFNxd0hhVUQ2YXg2dThRMDRKSyt3aEtycHRJbjBxVHdKcnYzUXM2?=
 =?utf-8?B?ZzJwa01zUWNsaTFNY2lCL2haRElqdnhSQUp1cHR5OGNyQm5IR0xMMXgrUGw1?=
 =?utf-8?B?ZFQ5UkRoOHI3ZU8wMnhaOGpwMU9DbFpqVzBiZmpIUGFFdUVnTnNCdz09?=
X-Exchange-RoutingPolicyChecked:
	HT3Sz7kzFRssKTc9gUGUPio+LjqGVT7/dQADit5PQmjfvh2aLdoZtuYLQwAWDzfeK8zqA/BM6NHZIUW9xaoB5QEzVot4mbVHuAo/nCOLZiHrUuNmfpGGe/H5s8EGcSAcjqc2JZKm5jROI8ZPtCVDLicIaujANCAlVo26tGipB+g6rYuSaGbBTXkBAjVpcq2TGKHcDRLII7vceODqf082bKm2fu1GJOfvB+Gntk70BErdZKghX376cIL7KdE+/sZ89AInPmhs9zgWlJSTQ5l5WuftnnXNx5Y1o+LH+BLt0WfjixjvDrMn1wN697b721QhKDtntUkrOZCFrAfVvxVG1A==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96922f6-100b-40ca-de07-08df3e7a5af7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 15:58:54.4417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUqiCMqMvoB/9F/uQnsTtmqNTgFFSjClbXEiJroA1L0EAjC92mZrC0gVjSTYwrcuEmdKmvxdQ0UXsXgkESFBVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB846340
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2MyBTYWx0ZWRfX/a7Tsc5+86H7
 UjW4p/7dYPLwbzPlv/NWpv9taO+YhEJ98tCsrk7OVyEAbSPXFwb/YKba0O+ZVjAUL1BDpci34UN
 UmBgFiN7zIoEolucuXv4UbxmBibdsEMkmQpD/xajJ4YHmH5fEuhn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2MyBTYWx0ZWRfXz9Yc80GJolos
 vmubPNckT+YOHv1CQzBkbTGadLUUfbe0xK3LZ9+43fYLGSawfMQoF5daTyOxI5o2b6qC8AV+XRm
 oMsOcjXduCusG/TZkNsyh7sS4zaAudm+MkDCrsKooOgJe8YoXpGo0RqWnsgRUFAV0Ov9E0quiGz
 SZGSA6Aq4Xlnm9W5wIVEQSEaAmln8HAI7zbddMsGmES9QZkVQpFw/WSF4wdYg6DetilOnl3c/nw
 26ilU77vX/PmejwOJY7cv0mE1wAZ8Jau9VNSg6/mj+Z+7KV19nTM7e0VkKQGKvc6cmmPUK/DL5z
 CmoOqPwctQ0SClsZF3WiRiTdFDijA3+bIRg7+OW/k+y9K/4Q77OfeSiR59VfrZAOqhmptYqNTre
 AUzMIi0VTpVTBXi+PTlWUdn+SGaWi11mIThFvG6xJb5Ziu4ArscOFvHReRQ15u0G4g2Z+YVGu8S
 5y8aF9pDZ6pOIvmyRTg==
X-Proofpoint-ORIG-GUID: B2ctI1GLi5rMcMS38RhqVlKf0Mi78v8t
X-Authority-Analysis: v=2.4 cv=UP5Ijyfy c=1 sm=1 tr=0 ts=6af1edc5 cx=c_pps
 a=TVJYqPbIpBJCeYGeirASbA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=EUspDBNiAAAA:8 a=gAnH3GRIAAAA:8 a=l4ndvDu93rU00Nct59IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: B2ctI1GLi5rMcMS38RhqVlKf0Mi78v8t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090063

On Mon, Nov 09, 2026 at 04:28:37AM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> Resend due to wrong linux-iio email address. Sorry for the noise!
> 
> LLM used to help pull this fairly straight forward series together.
> 
> The primary aim here is to ensure a clean layering between the two sides
> of the trigger / pollfunc (push to buffers) divide.  The caller of
> iio_trigger_poll() and iio_trigger_poll_nested() should be using data
> relevant to the trigger, not iio_dev->trig which is the
> current_trigger for the device. Most drivers got this layering right,
> but not this set!
> 
> This is also step 1 in a plan to make iio_dev->trig opaque allowing
> more control of how it is assigned and avoiding traps around lifetimes.
> 
> Includes one precursor fix that has been broken long enough I think
> we can just merge it via the slow path along with the rest of these.
> 
> Jonathan Cameron (14):
>   iio: accel: mma8452: unregister own trigger rather than current one
>   iio: accel: mma8452: poll own trigger from interrupt handler
>   iio: adc: max1027: poll own trigger from interrupt handler
>   iio: adc: ti-ads1119: poll own trigger from interrupt handler
>   iio: adc: mxs-lradc-adc: poll own trigger from interrupt handler
>   iio: adc: at91-sama5d2: poll own trigger on data ready interrupt
>   iio: light: vl6180: poll own trigger from interrupt handler
>   iio: proximity: vl53l0x-i2c: poll own trigger from interrupt handler
>   iio: adc: ad4691: poll own trigger from interrupt handler
>   iio: chemical: scd30: poll own trigger from interrupt handler
>   iio: proximity: vl53l1x-i2c: poll own trigger from interrupt handler
>   iio: proximity: irsd200: poll own trigger from interrupt handler
>   iio: light: vcnl4000: poll own trigger from interrupt handler
>   iio: adc: at91_adc: poll the enabled trigger from interrupt handler
> 
>  drivers/iio/accel/mma8452.c         | 11 ++++++++---
>  drivers/iio/adc/ad4691.c            |  4 +++-
>  drivers/iio/adc/at91-sama5d2_adc.c  |  2 +-
>  drivers/iio/adc/at91_adc.c          |  6 ++++--
>  drivers/iio/adc/max1027.c           |  2 +-
>  drivers/iio/adc/mxs-lradc-adc.c     |  2 +-
>  drivers/iio/adc/ti-ads1119.c        |  2 +-
>  drivers/iio/chemical/scd30.h        |  2 ++
>  drivers/iio/chemical/scd30_core.c   |  4 +++-
>  drivers/iio/light/vcnl4000.c        |  4 +++-
>  drivers/iio/light/vl6180.c          |  2 +-
>  drivers/iio/proximity/irsd200.c     |  4 +++-
>  drivers/iio/proximity/vl53l0x-i2c.c |  2 +-
>  drivers/iio/proximity/vl53l1x-i2c.c |  4 +++-
>  14 files changed, 35 insertions(+), 16 deletions(-)
> 
> -- 
> 2.56.0
> 

LGTM

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

