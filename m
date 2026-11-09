Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794244664;
	b=Ykt4lMgfJ1+PnUrThIccHO1unhoVjWVcDzChxm3zaNFX2ligPpo30U46oNsD+rGgWuse
	 0IYmfsSJ+MKYD1qE8gsBMXQDPQ0WMzxViJ9weNExzw274+3lgmqpbu8Zg13Qlwe7DADLB
	 LWmtuk2Vd5xAVCSIvd+YESmg7dj3zVWIrrw/1bcteBFCwS0ovgkDiCB7bvhFHyZio2rvi
	 036dxbURhZ8alU6Q92MnPPjF4bHW2PcBw9kYuVz9NIiZvQAyMZkspRC1YCLvqMiElu1ZA
	 D1emZmLJrDnBGHFi924LcYvmk2e8pthrw+LeU2I9YeqjQICIrwPa140qO8C4/auXOKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244664;
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
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2E5XQ4RRDdocTKNd6aTD8isucsrqn7bpNFJ8glFTcgA=;
	b=BNVZh/TAmQCw/bz+C5H6jWJfOOoxEDCroJ091wKj+2A0Vr98VkKnp8mKHFnIbbpQqU/c
	 +Z9fnlPhelv1O2ahbrnzOkc0MSZJ8aoVqr5kb39xYpPHLpXCOsDyMtMAPxHXgWXEKF9E6
	 EigWURjEZtsSiu+vQj9t+GzAdVGYGY+TTm85jU65t7Slb12NaaTsVgZ65sAN4I3dWU3Yn
	 EtorCdfPxSb84vQ66wfqpj1e3wSmZnECJlgsAtPDlZDJw25gDGr7HfrPOt8rESMw/97+w
	 VOznClOLYivtGRpMnWrb1iWdWYuR4pBh1o9qQUSoLvt/+Rny+H+RjBUagZ/IzNDxyPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="Z/YEDqhg";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=cMTpl7Cu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42F6606A321;
	Mon,  9 Nov 2026 17:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E42F6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Z/YEDqhg;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=cMTpl7Cu
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9HGvIH3854956;
	Mon, 9 Nov 2026 12:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=2E5XQ4RRDdocTKNd6aTD8isucsrqn7bpNFJ8glFTcgA=; b=Z/YEDqh
	gj7zztXtc7J0qAGOPKge5xPZN0reKlIkwTqua1hxHDrd9flzlQGGq+TA9J9kCHvE
	+qdXD7/Jb3huZO/rusercrcWN36cQOhwxfj6yf3kKNIZaNq2MIHcn77nmiv3TUKc
	p0IVA0blLydXNmmMXHLAA9KzUI5jQoqPgfzOYYt6qXsazmH233ELDi0lvfVE/nhC
	2gzQNVB/8X63dmCJ491Wsj4Xnxdd65u4lmyXaPZCrUcxnB3e33hUoARqbb77k9j4
	mn6NOLyHj/EFfACiozXOn9wjV6kzq9edbvlaGRyDgLHcuZNu9s95LieHr7xewq0j
	/bU/4K17TEqQ2Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2E5XQ
	4RRDdocTKNd6aTD8isucsrqn7bpNFJ8glFTcgA=; b=cMTpl7Cu6GX8BjIyjJ+PT
	Uzz/Oi+yfJnnghkxQSYW+T1ndfdHkJX5vlvW5lRfL6KagApIJbg4+Caiu3NZZcoj
	8KZNhRyvDsYRZXdvJ+wqW4oK5hr2MCZQ5T22tQ+AE1teGFYgKaC+wY4elIGtlIOT
	b3JyXYJeLBfl1N/mSvk5XpjVczQSww/SPL7Et+4K2LIaQWC3pttKY8BR3EhJOWAJ
	LR3vv5CIavt3lqUeE/O/D4wecHye30PZz4+Pb3PSke7aZlF4w54Rb0qh1yPjUNEq
	fZHep1m3XHl1/c+OonnNyD7PAglWMTyqWcWtXSaoJknZtpeizwpO9X+W51zBr44p
	g==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013033.outbound.protection.outlook.com [40.93.196.33])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4huhftrguc-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 12:17:33 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SC+WRha4j2hXOBs+2PKhxru9Cblz4Do6SOF3HidRkgp7+sNhSUluVdLpZRmKC3vyKklYprYQp9zeKNVODSA1PHkhuwMYwAGnOuSWNQlKK+hu88O5AN6VE+dDwyqfKBHHYleVcFG7zTk2IZ8ZlxhRp3zzjYFcTOrAiN25c4TCl8zJ7z/R9BZ05ZIKXBOA8bERrUtobGuENpLKLjvNuHSwqWg4P7+U1a+uV+frjCCk0ATI2L5uoOqxCEF5zDZLpG3LlgDto5dkCPzWUlDprq6I3w430te+/kQAjp9u+KMeZGXlu3NsVMAYRvqaFdqbbUzP7IED7k1IPB5xGtbU2JcFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2E5XQ4RRDdocTKNd6aTD8isucsrqn7bpNFJ8glFTcgA=;
 b=EY0Cyp/wXZraZ5fBI1usjpxK1+9PFS5zDQeCgJuaxRwnRWlAqZnoNOqplbFmDqMZdfVEYHKZJlwXhomJXQtpq7avDSkWpFmH2nGKL/pXpVnej0dehVyo2zHEKdrzNPv4dFIcnJhP61vq7lp9A9Pxmw/c5R55xBz3DsLKBq8NmiW1vEsqVhVaau19OGiw8BMEIenWCoigAjQMwYd75RZi6GEdt6Dm4H6H/8nSTZgxXLOHnVkOmUqUQ8q02/OJb6QtuQAmKQiPdondrh7QZ/4BfKHudKHuwJJMgzcX7rvrdhODxf6p3ZKA2LhSiiB2QWDADxp1OD3hTfahkfWVJeww9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CO1PR03MB5938.namprd03.prod.outlook.com (2603:10b6:303:9b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 17:17:28 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 17:17:28 +0000
Date: Mon, 9 Nov 2026 17:18:54 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
        paul@crapouillou.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: hold a reference while DMA-BUF is attached
Message-ID: <avH2RxfPwDrhthA8@nsa>
References: <179378580164.73301.2666197876060323279@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179378580164.73301.2666197876060323279@gmail.com>
X-ClientProxiedBy: MA2P292CA0024.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::6)
 To SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CO1PR03MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: e11662d8-fbaf-41d2-e3f5-08df3e8554a0
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|260925021911599003|260925022911599003|260925021311599003|11063799006|5023799004|56012099006|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261102123227099003|261026121527099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 cWybLaHR04pB5A256pZ/W+HJOKqk+DjE9Pp1yXmHsEi3g1Vm1aRNOl3NjwAwlPdMNhspjxTVwXELDjQir+/mIvzZjhCkK5F0XxlM5ztuUjQsuRc+7dK0mYG8zO6/SiTjlHJz9TT4/1Cklb9apWxg5APP236jz+AfR+UPycgqetyRSHowEmHPhqQGGPUSygom7Bqg3KyqBq0DyFGfrEcAVSQYgLYugNZZasSai1w0TnLcT4H7JmeW/3ZPX0l5crJWlvde0zxhWO48reXl4zK4gluz6XhBCZIUcfS7DyIYldz61EiviErZAOvzl4ZzCNf4Hr6RkSdzGl5hzYVP82XU/Q1zvlSImbdohnvcRnKoMIBhrUkfW/AXltpAuhodcebAiGEn/Y9RJ1hCkH+xlKEv0VlXUi2UECor9tZ5YqKLT9t66SoTT9LZjIdEdcGl5N5WzaumpftkIgbjxKFi9h58MsYvRng3EgrmVD3AdxrGWdhcoFwaD3sef7NqlpGULWchCNZotLJ2/uRLvXHjgvCPfCm/rYWdJxmGX2bVlSOvHuU5s6vr4v1yEkQ40rpdUL9oPRr6YwqcVICDeXR1eTZO3w/vRjfPmUg167YTmToI47PaJzSwwLlYBw6CbJtpIZjaXGfgL+EU/pLCkboaa7zokxCkOuOCYsHF0sQ5DCS7hq0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(260925021911599003)(260925022911599003)(260925021311599003)(11063799006)(5023799004)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261102123227099003)(261026121527099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WlFSNnQyTStzZnM1Z1pnVkVXN3IvbkJpMHpTQ2tReEQwaFo5ckdYWmQrcnVS?=
 =?utf-8?B?QXdGbzBsYStCaExKbHpIdUwyNTNrMWRaMlJ4Qmp6SHk0ZXlmbDlnVVgrSWRn?=
 =?utf-8?B?QUhBb21qK2ZIOUhTR3hRODVHQzQ1U3MxUkQ3aEx0Yy8wWTNlU3ROVjEvcTRj?=
 =?utf-8?B?anZ6UHZyN2pMbTZzQkpSYk83UDJDOWExMEN3SHJZT3VBWjUyTzBHU29abDJv?=
 =?utf-8?B?QXV0MDBCTjRVSkdyMjdQWHExUkZCQzlTWVpXN2lxSzZtZ0dLeXVHRzdIVndu?=
 =?utf-8?B?NWNWN3RKZC83RWg1UGxuY3lZb3dhdnFsVWo1UHl3UlJncGlXTGdVbEhNQVNt?=
 =?utf-8?B?TTdzSVZNQUR4UFpSbFQ3dmFsbnZ0N2p2WW0rdnpFdHY5MWZzbnFiL2NaOEls?=
 =?utf-8?B?VGdCV0NZUkhjb2NMM0ZBb2ZSK3ZsUjhhZUQvUU1zVmpyV0QweHQ4cXBaa082?=
 =?utf-8?B?LzhIM0V0Y014UmszYmozSUJ1TmdRT2RGakdFeEZoa0pzd3lER1FtVm9WcVI4?=
 =?utf-8?B?NlVKc3dDUitMM0RCdFpORGtzRGNmaEJwWWpKYWRYd1FEN2QyY0FIb1dORHcw?=
 =?utf-8?B?WHhpcW9PalBaYnh0VVU4SThmcEw0K0lGVHhiOWJBTURndm84WkJHbWNRbFNy?=
 =?utf-8?B?ZldydTJZK1dxTHFPV0FORDlZSlMvSm1oYnJTOXZTc1VkblVKODUybEhiaWtr?=
 =?utf-8?B?alk0S0h3aEVtanI0ZURVMmNHNGNVOXlId0ZCR2Eya0pQaWxJRUFGVCtYQlFr?=
 =?utf-8?B?TSswcFp1TWdiYXptNTV3YXJqRHRFTU1RUERhYzVMSUtjYnFWTFc0YmZTc1N2?=
 =?utf-8?B?YkN0dUlyVUR1cFNsSCtrVEFWd3R1b3NHZllzTXpVSUVRL0YwREFQcTZrN1ZU?=
 =?utf-8?B?THRNbDkxaThxakhPSVlRdFROVUVUd3ZHTytZeU5ON0tsRUJKc21Va3N6Wito?=
 =?utf-8?B?OUZMRnc4L0wxMlFtaUpLMGJtVFAvVVl6U2lOVXpzWnQwb21PSW5uVVpvUDBB?=
 =?utf-8?B?QzVwN3NoL2o2aGNWTjYxRksyVWZFd0FQYzFUNjFpZkl4ZjBqeTlUbllrcFl5?=
 =?utf-8?B?eFl6NnhYVktmRDVTcjZ1aW14NEtWMnVQQ3BrNXRra1N0b2dpUjR2NXg4NXJE?=
 =?utf-8?B?M2ZiaVNWcFN3R1BCcXRDVzM1a0FBN2dETXlCczFKUG9aQ0JTL1QwYkhta0Fk?=
 =?utf-8?B?UCttOUhLdFZvWUJzWmgvSjRDWGduNkxzNWxjSUl3WG9jMzdPTjJkaHNFenJD?=
 =?utf-8?B?dlNLSXIwQUs4VkJHVFJNSFllMzVWMXp2UXFGNDhtbkNwVnNrODJvakFCaFFa?=
 =?utf-8?B?Y0ZpWmVzVnM4TzlFMGh3cVc4VnJJTTM4Q1hYRGxGSDR6QytYNDJOMmhLVWtr?=
 =?utf-8?B?amVacFZxb1ZIYVFESVFua1VFOTNTREZMZmE5K2J3eGFUZFNXOXVUYXJMWnZx?=
 =?utf-8?B?YnBDUlZ3QSs2UXVTYUpJU3JsbFZqNUdhN3hja3hncnVMdVR5UWpqdFhSU0VS?=
 =?utf-8?B?U1NERHBWa3lwbGRybTEzRWE2bTFva1FDRlNNN2l4SXMwdDhuTnlHMWFrVXl4?=
 =?utf-8?B?bzN5SFdsVEhRQWpIUHVtenNyeko0VEhXb1lMc2JzbHU4R1NQU0FYaUJTR0V4?=
 =?utf-8?B?WUxRYUs0SnZmcTVlRTFTd0p3clJaNGRseVlVSzR6Ym5hY05ITTlqSEliYXh5?=
 =?utf-8?B?eGlBRElPRW05aHFrS3liVVNERjhKMkxWZlcwL21QTmRwZ3lHS08zNElnY1kv?=
 =?utf-8?B?bGNyTEZGMVk2TWduNEFjc1NjaG1kMVdlbkpiSlpVTHBKdDdIZldZcXhUWHFY?=
 =?utf-8?B?cGVxeWIvRTl6SkQvblMvVHFHd2JVdjR4ZTV1NEwxd0Z1V09nNCtCMFkxVURQ?=
 =?utf-8?B?RVpjbWtjMGdyakR0V2wvZEsxUjBLblAvaHJ1NCsyL0pJakRwTXpTSGF5OVF0?=
 =?utf-8?B?L0d4c0cvalVsTzN5eEYwekkvUHlkMFAvTSthRlpBbkxBKzdrSHh5UU5LMHJ3?=
 =?utf-8?B?YWNlWE9SQXM4L284UzhJSUFTd1o5ZWdjYThER0JZQnhqYnJVMzlDMjZyY0xU?=
 =?utf-8?B?bmphU3paZWVMVUNWL0EyOUU0UHYvZ3RSd3F5c0R5M2hHMUdOdWo1eE5obFRm?=
 =?utf-8?B?SXFURUZEenl2U3oxNVBBTzFqQ1VyOWZ1S2p2cUlza3FMV1c2aFl0ZkVnVU9j?=
 =?utf-8?B?d00vUHlHTHB1VmlBQXYzQXg1aVdiNFFza2hhcTZzVlRFVFhZY2FyeDlERXk3?=
 =?utf-8?B?QUF6L2FQcTFJRXlpeHBhdUtHVFhMNFFBM1NwMzhrdGtZOE80UngzNEVEYnNJ?=
 =?utf-8?B?amJaczN4MzlZZ2RGWDZrSEE2dnRHdWxNcmNhY0hsS3h0aXRuTGtKQT09?=
X-Exchange-RoutingPolicyChecked:
	lHb19qli51Wl65zVi3rTdQLj1lp2hB3EWxYsuR374jb1LFT8Z76q5Nntk7JXa334QoqagjLiJO8LB7HyhK07hDgsI/lfYwczbh5yiYTIihvkn5Ze9oko9DpHYHfmqQtB8sJ7l0cnqV76oA61l3QzoVRivi6y3lue6CAIf5XY/kIvhJvOh3yctN0SnvDeufsQkWd4SFkqNHvUZ/6V6iTJJ8GxNQ8E6ImPya/vow7YVkj7wQTx2Ll+2cMcPxJNKP2n7XMK1jAqTc2YXBOUoROzbwurjbvjyvULUJRMeHDNOFv2QH0ozdqEhqKpgcLluq97VK2NgugNvMmtj02DvYVtQQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11662d8-fbaf-41d2-e3f5-08df3e8554a0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:17:28.2855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEOdhJg8juIXXd11fBm0wfGT/8egR9TGGHqUvbaasCWPjcWAK9M4cpuI7LD5eOvKyoCjHnLPyCt0cOn3qPEbtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5938
X-Proofpoint-ORIG-GUID: cLqEsiQrqhiDFhfcoUgQQoTdQblCNDM2
X-Authority-Analysis: v=2.4 cv=DM8acCNb c=1 sm=1 tr=0 ts=6af2002d cx=c_pps
 a=uZgmHucj+isDzLb5E5/Wlw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=4hOwxLl8_rG3YeO5AbUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2OCBTYWx0ZWRfX41YncM4weiII
 opI8A6oxdL6qLe0aSqOLpjfg/wDEk91dLlX2N21QxsjkU0Cew5kkPmGfar4tEbg0zv9Rgyo/uds
 5bYdL2hEWi/qKdq0cEDWt3NtpgNtZppwZEThTZL6ZeTs8dkb9c7C
X-Proofpoint-GUID: cLqEsiQrqhiDFhfcoUgQQoTdQblCNDM2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2OCBTYWx0ZWRfXz+tO0ZpISHx3
 DzYvM/wkOD0fD+8nq+CE3pZBzhDG0e2wUfYZvZPkYDEIkajWO9C90QaaIteExwnLL/wE6DgFCsG
 /U8DNyaxAi4Q3230kXO9p9/woUEw+HfbFTOh1QAbSrSNCYOKfZ7tttiBe+g352iHMB0NTrc1qsQ
 y+bUeif0KIwpWZzk4FEDPjgPFrxTSM04Cy643SrdcB5AlYkyR+QBUYYQtZOnSf8aX2SsT2qMNNY
 PjeNxZ0mzkaFb5Vcq7FyE1XQdMcWIdYH0t7BTsXo5SbLNN/Z2TOnuhx/5qcl9a3Tph23sbl5K6L
 ppdUz3aOj5RYYGI4kQZSEmctf9K5+hqt+iJ6LC1M+Um/N3VPagR3cvzzFJY7MfC2Ahmg3c6e6tB
 LqMcKyTgWNVvmM2/lFv4+MErSiVWVG7Li+Z2XkkXZbGPHnQv/NTY0eczbh+s3PyiFcNy2VjBn/8
 GnbXUtLAAfvvhqNxgRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1011 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090068

On Wed, Nov 04, 2026 at 05:50:01PM +0800, Yaohan Li wrote:
> iio_buffer_attach_dmabuf() stores an IIO buffer pointer in the DMA-BUF
> attachment without taking a buffer reference. A delayed DMA fence
> completion can release the attachment after the IIO device has been
> unbound and its buffer freed. The release callback then dereferences
> the stale buffer while detaching the DMA-BUF.
> 
> Take a reference when storing the buffer in the attachment, and drop
> it after the final detach or when the attach operation fails. This
> keeps the buffer alive for the asynchronous completion path.
> 
> A KASAN-enabled test with a DMA-BUF-capable IIO test device reproduced
> the use-after-free on the unmodified kernel. The same delayed
> completion sequence produced no report with the change applied.
> 
> Fixes: 3e26d9f08fbe0 ("iio: core: Add new DMABUF interface infrastructure")
> Assisted-by: ZCode:GLM-4
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
> ---

Yes, the change looks reasonable to me! Assuming the cdev is closed and
userspace detaches the block before the unbind we do force all dma to
terminate on unbind and the cleanup path does shedule_work() for
the fence and so iio_dev_release() might drop the last reference to the
buffer before the fence callback is called.

The whole thing is a bit hard to reason so unless someone has strong
evidence the weak reference can be used, I would very much take the
patch. Hence:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/industrialio-buffer.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 4294101810fd7..bfa6d19471126 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1597,6 +1597,8 @@ static void iio_buffer_dmabuf_release(struct kref *ref)
>  
>  	buffer->access->detach_dmabuf(buffer, priv->block);
>  
> +	iio_buffer_put(buffer);
> +
>  	dma_buf_detach(attach->dmabuf, attach);
>  	dma_buf_put(dmabuf);
>  	kfree(priv);
> @@ -1741,7 +1743,13 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
>  	}
>  
>  	kref_init(&priv->ref);
> -	priv->buffer = buffer;
> +	/*
> +	 * Hold a reference for the asynchronous dmabuf completion path
> +	 * (iio_buffer_cleanup() -> iio_buffer_dmabuf_put() may run from a
> +	 * work item after the device has been unbound); released in
> +	 * iio_buffer_dmabuf_release().
> +	 */
> +	priv->buffer = iio_buffer_get(buffer);
>  	priv->attach = attach;
>  	attach->importer_priv = priv;
>  
> @@ -1789,6 +1797,7 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
>  err_dmabuf_put:
>  	dma_buf_put(dmabuf);
>  err_free_priv:
> +	iio_buffer_put(priv->buffer);
>  	kfree(priv);
>  
>  	return err;
> -- 
> 2.34.1
> 
