Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBE133F5BF;
	Tue,  3 Mar 2026 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540093; cv=fail; b=VG1Nv44CCuXE5t9r3pp0xWisPRko3SGlFmumuAP7uYBJqtnVrB1q/aG3tgZhWhLUB4cC3zQ/vjuhozEpfdbWgRtXRXQTEEyBDwhs//qKSqkqPZU1lMBlw0DI6c+8aO4GCE5Q8BXVidfJAkY1Hf3xTCmB9wb0b1QMkTKeYHdaNU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540093; c=relaxed/simple;
	bh=opNUdLdHLhrV4JB9q/sDe7IYoACyHq6wuM/DqXFvH9E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o1XQ2CFl4A5wUpSjLrjUW2sQmwlVHLU2RjkUtUfQOVner5EWdRUxtLEBIXrr1zGleQYfim6XUVuQWW4KCoihnBUTyjX1Jb9feC7q9VRKYk13pfC5aBqfhZbM+lfpa1GP91/0wfOpPnn1nujReVG64w7mYyE/ZbCbtOyU4BOXAks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N1pJ/BoF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q0BZlzuQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N1pJ/BoF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q0BZlzuQ"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623C9NsP068487;
	Tue, 3 Mar 2026 12:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=d7dxTh6GoaTmNP/WknXcI7fGVaPZlAT7WHetqu4w5Ho=; b=
	N1pJ/BoFleoDsmtAWYjLbGb//01ieYUvDzDGZnIsE9GWENfAbkZL3XDdAhPPSHOn
	XVvBsR6TsXiBPOvPIpRuzit2UCtKfo3IuxhWZ2XdZqTbQTvsn6qRrq37EOqk3qaG
	vnIRbNU5O36xFe5b8wOeFJ+xBa/gC6c7KGOP6p+CpKl6eXLcwS5ae8DIUoVOZ1Q/
	AnoSGQosiDvrRg4G4w0wvFD2DnUvLVtHmUy6pUQjmBJHkKO5/6ykq3gOgC6UfehQ
	QVFYInuUVSWd0Jsvye7OMF8fMza9kjZQyLIStc+3u6k0P/RWQsBcKcF1wKsLg0sb
	RL03eGTnnbB7jsKs+VhHoQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cnydbr0bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 12:14:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623CALFa034769;
	Tue, 3 Mar 2026 12:14:43 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012035.outbound.protection.outlook.com [40.93.195.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpte8uhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 12:14:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCBxPdzQ3KDlWdMH6Wm/hvLvxZyTfdk2taQJN8vktkxQR5bBWHgIwxyYwCqNKOZWTX15HYRjePYpD9ECJ8IdaPj6f442i//hvTlBbyUQAfnXJBbLheFRkxc3kX4DvKUzh4PaQL2qhKHJtKIiPF9EuuSj+UTliXO5R+Za4NP2OxEjEFTLCOYYaWmt5DGr75+tN9Oo+/l/toKXr2KUnygkR5mxOhQn3R2FsfEk4hQCzrfRiMKcbAr5f9tqZwUp+ABf8pn2RJLPpPErscjCOSpwo+w8BF5QqJoZrGcH1FECCWpOrIJnazubHIicMhVpzpZaBW/mQVc7N1mSqW3eO50Y4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7dxTh6GoaTmNP/WknXcI7fGVaPZlAT7WHetqu4w5Ho=;
 b=pU24cgXa9yDNJzHEaj7i3i6n0Xn0kojbKkCSA+puaczn+w5VJWTuc+PaU3pj+/ocAmrJ1GFtVLi5wbcJAuCKltyNNvoEn2taUazsrCaHA+BdHwPG8E8b7QBaYJeR5xPkE4iyhn+v4iG8WVX3PP6nItt5vsPSM6pFTXl1uxhUhrSSLxgrajpiKNZuFnPMv+o6ki/wfEzRwfD8Zz7yr38w8Z6kwwW6ia/mp73CbpigZdB9MsdTsz2VjoMk1nAzf3LmSQBvC0FGt34UBr1MEl5Mf38oDym9LFJXtWRlOC+6ulm51oyJrkE+0ZO9bLwFpsBp6B8VQVwVdYAy0puGNA+pUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7dxTh6GoaTmNP/WknXcI7fGVaPZlAT7WHetqu4w5Ho=;
 b=q0BZlzuQ3dsmJ8p/wfh+v4854mQ1sdZlSeaxZ7ozlIup8ZzkQwZQWtf0elTU4b/JfhpIRTqMTJZjsyI7nL6t+iQDT36otXUZP51FVOvpcdXA+/A0kYX+TwuN2dXy9H2qX0+u73Bp13v+vQqoT6nhFM2s2V2YsaWxRY8pDWHz9ds=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by PH0PR10MB5548.namprd10.prod.outlook.com (2603:10b6:510:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 12:14:38 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9654.014; Tue, 3 Mar 2026
 12:14:38 +0000
Message-ID: <51ca89f5-6db7-408e-8590-774286d544ae@oracle.com>
Date: Tue, 3 Mar 2026 17:44:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 next 7/7] iio: sca3000: manage device registration with
 devm helper
To: Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        David Lechner <dlechner@baylibe.com>
References: <20260205131234.3244467-1-harshit.m.mogalapalli@oracle.com>
 <20260205131234.3244467-8-harshit.m.mogalapalli@oracle.com>
 <aYTFUMe3jUO_bGCr@smile.fi.intel.com>
 <34bac81e-6a6c-4cf6-b370-beead4f705c1@oracle.com>
 <CAHp75VfSYGoNUTqDb9WLYNYeChkB4mM+LEBpyRVnLOEKkr==WQ@mail.gmail.com>
 <437592e6-460d-435d-bd83-7ff8222a6130@oracle.com>
 <aYTPkt5jKoX3X_4i@smile.fi.intel.com> <20260205195845.4e108117@jic23-huawei>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260205195845.4e108117@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0335.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::16) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|PH0PR10MB5548:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ab9107-79cf-48b1-c6d2-08de791e70bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	DsI4rGg8dd6iNQIyOJGI8eDyx8+ZHb21ewKKuXRYn7JCUwTPuzztIuYL7QjDBxfpEGhBZiu7OrbjtavHu6Un0F9H7f2LS3kE+uLfmytT6PitSQRUOoXfh9KObbbt5NFkj2/5OaUkST8mDXcGpVwPQAnvFKHrQKe0v/myxCf0paAyUZfsIPNTbX4JBSpR+5dL/pozK5sJsEX6voZWACfUorQ7KYzC7ZDz2eHc+MNUVjV0s0399m48qaErleKcZFKbaPywFyBhkw1ItIKOoXKDPHTAzkY4mx5cNqJHZUHwbDkCa6qp6NAe70Z2dttfyNqsR8r+PhXxISi6oGXBFKPXvQHUhwVz/fL6pQNtFgKbq0sSlKU8KURM7e0jVkFvyIBTKRth3m8I45JInbUutf/hg2AgnlbHXV33TNra/UGlrs+KE8w2oOjMTHp+v9Ajc+sX+EFNFaRL2lqnMoC5fvrDGNxvY7UFkagHRbWzEe7nGol2DnhtTZdz4fRX8rYD0u9oyuPyhxupPUv4AsPIWppL0rKOVT/vYJy7uR3fh7zrU6L/uWIL5KGnzEq7FkhaRE+ZKyH03G+Nsd67gNFRWVzHl7i6BS4d2GcwYiV+GMhKqJoEpk2h1qjvQY156Wwt350w4Rm5qwwFgmVJNUsn9+fv2J50IMa+MJVMnj8F7I8p6unytN4swvlmWcAazJQD4z2KlCpU2XjeGW9pg0e5cvAeA1BZQUwdYuQ0Vn6r3qA8BOT6+cWY3wyfnplK2NCoPTBK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkVTT0IwTzdMTzFLdWtpZkFXNnlZYS9VMDBjNHpUeWI0SkUzZVBCSlhsdlRY?=
 =?utf-8?B?TzBwL1QweURFb1NGWWp1NWV3bTFHNWlzak9ycTRPbVpSK1R2WGxDcUVSUHkz?=
 =?utf-8?B?OTFkOVZLNnpwVGRTQ3FBUm5UWUpwT1Z4TlFyOVNHaFJVS0gvQWpWeFRST1lD?=
 =?utf-8?B?a1p5bmVzbmY1dGRPamZuN1J3WUZha1czMkZnYUtGRkJwQnFxWFdISUFJem02?=
 =?utf-8?B?U2NueEdBbk05bzZ4dHlHVngySzlETGIySnZmSlhGQzQySFYxSThaSmNIMlpZ?=
 =?utf-8?B?UjlNT0I5M2JBd285dFBrM2NaQVd2STdBVm92ZFlIQWtncjZTcjU4OHMwa21F?=
 =?utf-8?B?VFJWcUhSS2NNNXllYTNCTHltalAyVlN5M1Z5bm9Yd2xRdG1mY3AvRnE3Wmk5?=
 =?utf-8?B?eXdRaVVQeVFvbmM0TGY5MU5UNm11d1QrRE9HVzM1UDlNc3I1TkxhTDNNVVBS?=
 =?utf-8?B?OVhIamdYeHllUlNaL3RXODJPQ1pZMDdsK2FpR0x0a0MvN3JwZ3RlRmgvbXpk?=
 =?utf-8?B?d2dJNzdKNTg4elBnNVBBTjJCeHJnMDNQbURJbkpNY09YTThyQ0VnekZFRHE2?=
 =?utf-8?B?OENWMjJYYXRoNDgzMjdXd0VJdXcvM2FYVXVodldKSThUaC9tbmNyYXFkeUR3?=
 =?utf-8?B?QUVKN0xhUkYrMjFXOVMvb1NCTHh3emJqUlJZMXVyb3FlcHFqa3hkRVRrK2x0?=
 =?utf-8?B?c0NEWUg5UUN1ek9HOThvemNvbFIvOERJNEFkOXJPc3dzZXJTdTlhOW02T3Ay?=
 =?utf-8?B?bG5URlIvVEZxRWlEOWFVWmVoRDU0MTJyQnhrVTd3d05kV1paYVJucjN2SStl?=
 =?utf-8?B?bERGT2VzMVZqREVJYXpjWGpEK0pPQVRxR1M5UEJieGIrZmsxYTF3ZmZqbjhY?=
 =?utf-8?B?Wk1iS3o0aVloNFFXamtUdDZzQkVHcHRVQUNXbHZmcFd4cE83WnpjYllMN3Y0?=
 =?utf-8?B?aXNaL2VweDYwZ2U5SnB5cHkrdzFNTDcyS3ErN0dKMWNGMSs5UkVKeFVNSFpk?=
 =?utf-8?B?QW1Ddng5R0RHWm1QZ0VHWWRWd3pscVpEY0VBay9NT3ZTQVpVUlhwREs4ZU16?=
 =?utf-8?B?QlhGK29FK3BZSkdNTmduV20wTTBOa2E0NVNPa1BqOUorY3pQdXdqcmswZG95?=
 =?utf-8?B?TnNjNjFGV24ra3YyMWxHZDJmaVdDeUZYZjRHMnF3eFY5WVp3Z0NtSHJ2dTM3?=
 =?utf-8?B?RXpsUm1nOEJGdy9TYVExSnIwYSt4U3NQUWJuMjd1a3FZMTJsT3Y4S2llUmdl?=
 =?utf-8?B?WjlrSCtVaDFVZ2xmNEtIVXZScXFYQVJwL3hhSHlGS3FQTU9WVkt5VkFzVC9i?=
 =?utf-8?B?UlNSZkxCWG1aZEtaS1FpdnJIYlBoeUpFYWhNV1UrdlBLQjRGRzQrK3pMeExX?=
 =?utf-8?B?bFp3OHoyTDVIQkoyQ0p4ejhLMjZpMXlGdWtLMURsQWtBdEo2aHVFSGJVdnJr?=
 =?utf-8?B?TkVYa0plbkZsUmtPVFlvTnVMVGF6cEtDZlNXeWViVUdMcHJaZVpDNGlrcEEx?=
 =?utf-8?B?bTdvRHI4cXpISWRhUGVNNHlWS0xRczZDckVydmdNcU5EeE1RTnJleUI3SXRT?=
 =?utf-8?B?SGhkZjFtQUYwd0hycVN1VnRWYTZhclhBeW9JTGZvYmdGd1pBNC83WVRrK3NW?=
 =?utf-8?B?b28xMTZuTGJobDlFanZQcU5rRnN5RXFNbnc5T08yMGJBRWdYL0xVVzdKQlVh?=
 =?utf-8?B?QXRESWZpeTNtamxkUjlyQUgveVdmNDIvb0Q3MDlHSVBESkk5cWtPTitJb3NE?=
 =?utf-8?B?OWNINVBiNy9RalIvbDluZUQ0Mm1FNnJwaTF4bm5EdGhmeEk4NnhxKzNqd3ZL?=
 =?utf-8?B?YjQ1SXVaM0dIZTQrRkhyOUlvb2h2akZiNEhrN1dKeGtIR1lWVWdGcmRMR05J?=
 =?utf-8?B?VHhVNHpaWmlZK2hUbGFmS3FacC9YSjRPci9acTNseGl4Ukd5Z0ZKUHVsc0gy?=
 =?utf-8?B?QUU1QjYrNU90YTFvOXUxSnVZaGMvdG92bE1vS01tVU1vYk1WZjYwanpENGwz?=
 =?utf-8?B?MzgzbG50TmdLaHpmWnhLbGQxbkxQb2xhTnlza3pNREZkbVA0VmtKN1FaMXR2?=
 =?utf-8?B?WmhTOStITlBjU0FTVVFwUGFQYUg4UkZhYWxFWVdRK3RsZjh5dHZwYWNBZjM5?=
 =?utf-8?B?RW9YSW81WlJMWU9IdmU5cmF2RWY5SzRUOTRpN1JIejNYSGJoZGMzQUQzSzBa?=
 =?utf-8?B?YlhaYVd4NU9SNzhmSmRzLzliY1hENTZ1d21IRGwwS1VGd1VpUXNjQzJYK1Fs?=
 =?utf-8?B?OVVja0JDMmVPVWpLcnFBMitLTmVjNSsweXo4NTJLNGxiT3lBS3hpcGNIN2lh?=
 =?utf-8?B?RE1CRlpNcjcvbDFIVnZzVlNITnE2bzh5bkdLSnBMWUlzSThKeFAvRG5NNkJu?=
 =?utf-8?Q?ZYYyzsPQv+FENVIbugwGXyj7zIMOJnGz6mNNq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wv8M+0kAnVyvTROQMWTqwPwrCvmRO84Yo99MCT51Ghj8Rb2gYF8zrvb8jesPWa+wBLamJSVTxEXX9+Hj1FCwVPxxSUQRtgLSBogPDwpTn0/aXxys09wIxi91IDFJAbi/ESWi8H79KJ8+eH4ZVPob2oqZxUOZbfGDRDs+7fWDOtlAhafLMQJSJ12zn0aH+qPEys3t0iG8PTvR9kb1EHDE8A2mJd+U5vCsS0Q6DuGwijftkfgiZ24R2yvFmhkWtHe0Qnc9Iv7k/AEt75LswYvNHabvmnCSBnpgAyibwtioGTymx08dYcGhrcqrtpcKC9V+ZC7/YnxP+bt5zEzbn/YkVq5GSMMOZov568KQMzV62WjJFs1MSwJ/tPmMbP01OOrmMtcD3pW3RHzSZ7/Z74wDbmgpS7+250LFcN9BnQgnVGjGW8ifoiHU1uw58Z41KJd1DkzMSata3vLy/TX+rlDyYxyzvhh3alsr8IAYe8qSuXwgmkXPJBO31WPTVeuBTolJsmmRrZ+eLBoBdwchb2tBAA/lvAmSLfFtkuQfuAR9zjZCQehOGzRW9sNo4BneBsMojbhRrGNXUQV7Ov7KT19m/4EhCXQIY6mGyE4Zb98M+PI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ab9107-79cf-48b1-c6d2-08de791e70bf
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 12:14:38.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxI3YUqjdfNw+hRluuepLrjH56SW68G2QLZ80qBs5gx4DkoujTRUKeV4WUaSb/dlS+PWHlnfdVdzi2Wd5ih8UzPu0EOINp+t6MLzg89WlCpj3B7ZDxVFH14Mzm6dJT6l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603030095
X-Authority-Analysis: v=2.4 cv=Oa+VzxTY c=1 sm=1 tr=0 ts=69a6d0b4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=NxKidP5Q_88Wm-i8BwUA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=IawgGOuG5U0WyFbmm1f5:22 cc=ntf awl=host:12266
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA5NiBTYWx0ZWRfX1wtkkQW5+lnl
 Y/nrUbWGw9SDqxw0KBMeMFlasmOWNe3/7bCVs1/bqIm55m7ueCvqR1xpdj2EPYYSw3uphUE2MIb
 axTjVv1ANMypDdPC1C4dH1Z4kbdHWGLFDoGYYkAuS2b5hRA+HcVapC+ck86ifjBwcaLpR0HKfOi
 TkD5m1FQrcxjkkntEL5cZTrtPKX6QxEPI4qlltRBFKer1ZXAeuMOGwaFCJ60oTyjW9LFUZvJd59
 T5XmTSK+hCMUSvxkwR2w4MksUj8lGm1S5Q2vueel6vj6L5oeSW7fZRoW4IfR1XimdOV5hDPOqQn
 9ToeQVtWjzmCNKLRHCWRB8pyqXVR4ae9W3V9Lh7rP29PB+7CvrG+TOCwHmz2eWKpq/cYzla4DQW
 XpDKAHwv7y4HFJvinvEUDdB0gnSiNHWTAD5VuyDdAY13RnR5Jsl99E6qG9rxKn3fMtK7kj01QQ/
 R8IvasksdoTO5GtT1GR4KoaZlcP4RO4/M8h7dWas=
X-Proofpoint-GUID: xN3wtsGtch4X7lXiidp1TrO7mg8W6I0U
X-Proofpoint-ORIG-GUID: xN3wtsGtch4X7lXiidp1TrO7mg8W6I0U

Hi Jonathan,

>>>> Ideally it should be done in this patch, but let's wait for Jonathan.
>>>> He usually may tweak these small things when applying.
> I removed it.
>>>>    
>>>
>>> Also, while checking the patch now, I see I copied a wrong tag(RB with
>>> missing r in baylibre from [1])
> Fixed that up.
>>>
>>> So that's one more thing to fix. Let me know if v6 would be a preferred
>>> approach, I can do it.
>>
>> Let's not hurry, wait for Jonathan to decide.
>>
>>> [1] https://lore.kernel.org/all/a5fa2f97-9ba3-4085-bfaf-a255d24a81f0@baylibre.com/
>>
> 
> And applied to the testing branch of iio.git.  Note this will be
> rebased after rc1 is out before I push it out as a branch linux-next picks
> up.

I don't see them here: 
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing

Would it be easier if I send a V6 ? With everything fixed.


Thanks,
Harshit
> 
> thanks,
> 
> Jonathan

