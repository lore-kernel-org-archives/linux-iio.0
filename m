Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665AF46C4A3;
	Fri, 14 Aug 2026 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710467; cv=fail; b=DhGT8KTzYH75IdGZrq7DtoSTqFfw6QvmptfvRMRReiri39Kn/eCrLiI6iUZqiNos009R34zUvYWVZ+acUBiC1Gs13ZEjAzD9Aol5tK6ytK5+5Np3/NfiXGFa2zhuKsKG6pscPhA4hkId2NAaGeGUJPh6uwHOA75zjyn2/7HXCk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710467; c=relaxed/simple;
	bh=xDhpHloT33tVdZtjAl5C4fAJNHtivhRJMnBa+Dyvehw=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=An8DzcBJSgDkKRmXUqC2N7QwKryYVnSsJ07Pha+/pV6z4qZPtaPoF/d+fru3ym7NG8pKJhG2qHRlMKudraByywZkc+E4am/oNvV9c7Z5SSlhDPPAuNV+LgwiAdp8gg6wMtLteNjU8BNK815b7qAQ1IECPP3azPQU5J4bVdLtMIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cx6V5WO8; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cx6V5WO8"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EAeE7B768921;
	Fri, 14 Aug 2026 08:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WYPpy
	/XtAedRUneffyRjge9WsE/P58NPaDFrm5cq5nQ=; b=cx6V5WO8ck7k0mfpXw3Tk
	Nl9kKG7FtHKWi6tH8rBf5DLf0wklZWncnhwpDZAoUgYJZGNJj8mUd84gLBb7Dmv4
	olr/fNUuoPakegeYaopb8o6FXmtZMdRNjmrxKz/4eA57uIyFXxAD4mI1s1OW8IUO
	+WBqGIM9EfRP1lXVHxQ4p5OHpiKjWgB07XT0Jy8w+LpjWsfhfsCk5Y+wtZthEB0V
	Zm2sfTlFizpY9NksBmrekgJQB+I+hc07mQeusuIsWBQMtFGBwPqTFqGEDcHh1ZSa
	NlDclWQOoJdzL7yKrUFs/3dk98ice1Ljvg9Dcjy5mVwt57v3QAdCrcWX4RdKLJof
	w==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g1u7a1tmu-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 08:27:42 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5tUK1A/nu1yEjG8mk7jikQ3Do2i3GdhmIEbmoGPGofw3pZdeUTgVsUwyPiqSbDfdpTKYGAU8AD1Zmza2rsqnVHCyS8fnmHfHsbY6Zdb+12clu9vyXW53hVpTn9je71i+PGYbRHp0JQI8jHzQuHDygAysEiB1P9zOW6YSeL0GhN4O97qyyz/uarlpCT+DCiekBK0wZOEJselDP53MUXznsGrzNF1DPUXjU8Suzb6Jp/X8SnGJE7WUGGZa+zHq38rUk7Q34sFn/0NIawy71u6PUTHYXVj9M/A8vQGxN1VAskGmZT9QsJS6XW34s48XMFSoUeTZaPcV73oO1jyIJBaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYPpy/XtAedRUneffyRjge9WsE/P58NPaDFrm5cq5nQ=;
 b=trTiH61FdLlETMZXaPxzTbK83DuxmJOwvXZR7xS9eeDIxxlxqyY7TSXm1BaO2yTTe8JBx74jTr0GAT2RfBzaiulhU2dPyeKAIIuavbXCJFN/qmpx7GfZiMczM8rHH98L3o+7jEZYLPqk95xXs5zib62pVsVSednk7JL8YbXzMzUsicn6zD6Oyi+b9wqNjClmrgC5hqW7X3txVUPNTF5MHrLF/1pJ1KItphzsBlng69kaaT4aZc3QBSLDJz1tmgGbLXQ7/hihE2d6pHbWK/dtH3gwxf9sNROahckO531M+l5A5RYmG9593QlpwnslzX+Q70s5I4K5sYvZ40+evuMscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA0PR03MB5499.namprd03.prod.outlook.com (2603:10b6:806:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 12:27:39 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 12:27:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 3/3] iio: accel: adxl367: add support for INT2
 interrupt pin
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux@analog.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260813081452.4289-4-antoniu.miclaus@analog.com>
References: <20260813081452.4289-1-antoniu.miclaus@analog.com>
 <20260813081452.4289-4-antoniu.miclaus@analog.com>
Date: Fri, 14 Aug 2026 13:28:29 +0100
Message-Id: <178671050969.21598.13163934753300429850.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786710511; l=917;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=xDhpHloT33tVdZtjAl5C4fAJNHtivhRJMnBa+Dyvehw=;
 b=rmm7zXo0JaaXzeTHTpqgNAMDjFXIjPdli7WVOYicMtyZuIQNcDCA5RCGN4+yDZnuxCC9zWD1o
 El1/cnzdDMxCQX8vkV/r3xA4awDKW8s5skeUVP/IXSrtclDuFglUgYm
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0167.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA0PR03MB5499:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc7ff9b-e5f6-4d90-a51e-08def9ff6e08
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 CPi02HGo+j7U8xOqssqnkzoAtjNAF1RzmHJoHMCLZfSV4bE9+N9/Rt0TksDP0aq1vnO3l3a463Ps54nnDL4ci/8vqetqPuidAS5uVsmPBqQH+rvjXP5haYlpy7lQg+/k7QxjZ3AXtOBhH8M6eBpsccMrgZIjiTKpERaqAh4DDvJCjFsifwtcz+fgT+gHWt/tOBnnUi8whIUis6c3rzbj2DDfV1Gx9fGDhA6NmBDejATCadE1Xl4kn8CPGo/T5yr8BtSWLN4xYa697pdulnnzJaRD73KcXYop4P85ovW3958vOE0v9SeIrDWdI5zMRgzLnGQDlvHvwmoPqyXvsANq8bxP0vZiudpsPwxlBvjwG6Ef9kvekrwuP5areGFpn1webnKeLdZmsIljYORW5EcNVoW5pEnCKK85CYFo9bDyNoBkZ0Yh1+KQiMFDUwolQQon576+sUeOhtAs8cFxqYNpfrIdLaXs0re6fFRLPmoONPu62GmBi/sZvPh3KEkvFRHwO7R7ZeTDlsgREOpW8vXWMoqcVrKeo9sB2cTJXZv8RZIMlGXU9F8SkxgXrY2yo40PmLfB3suFNsKK8K6O2J7McAZxOdxb2rKSt18qLxkDykbTZ54ZnMCY544HfFYrSAg9P3IKRW8gazcwOuaMlnbcmMdmn29WWntKT4TGQklwaK0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?S3BHVE1VN3ZUSi9ubjJ2Z1dGNTBuNGcvL0xmQ0k5Uk5KVjJ6UnNMa3lhVzFq?=
 =?utf-8?B?S1FoZ1B3YnZ1cHBjR2FVcmVuVGFqb3lweEQrbmZPRzBDS2F2djFOREQrcTZQ?=
 =?utf-8?B?U0FMTUdIWHlhaVhOWFo2emFud0doeDNxdU9Dcm5zUmhmczVWZjNUMEUzaTJ1?=
 =?utf-8?B?dzQra3ViaXZiSy9EWnRKL2hHTHZIcXQ2QWNmeUNPbDZ0anVEY3NtMmIveXph?=
 =?utf-8?B?M0RncXpuYUZ0UnVlZXczN0hLMmVNZUtDY0JmeVIzWlFjaWhUaEc4UnlSd3RH?=
 =?utf-8?B?a2FPQWI2YUNWdk5UcUIzZWsvalA2Mm1kSXpqZ3ZiYmxRejNla3Y2dEY3dDRN?=
 =?utf-8?B?aHZXWHR2YS9CYWlCdmJ6VW1pbG5CSzFaSGU3c0pabkN6SnNmQkxWSGN3Zy9P?=
 =?utf-8?B?K21wcGVkWDVpWUEwaWtLM1Q0RWlGaUFiQU5lYmVySUtlOVFNWGFHWURTUWZz?=
 =?utf-8?B?UHBaUG56d241T2treGdsYTNGYllKbk1VeXptUWZVS2ZjSGp6cWFWNlNPd1pG?=
 =?utf-8?B?dEhZamQ0STN4dDdHaGtaNUx2WC9DRnFnRHhyQ1EwVzF1d2cvMmRTKzVmbXNV?=
 =?utf-8?B?YStZN3dFRXN5REYwU2EvLzBJaDBhY0J5ZTdsbUNJUDdZUTFZOUl2ZWxIcE1u?=
 =?utf-8?B?T296Q1poN1hBK2x5YW9BV1ZJMlUrNmprN0FXV1pqRjJBVm1zc1FBTGdhdG1n?=
 =?utf-8?B?aEZJQ0hOUFJpYnpFdjNjYml0ZzFxcWR5dUFPUjEzM2prWUZoeEx1Zy9INmd3?=
 =?utf-8?B?eWN4RlRDbS94SVlMQitIeTNsMEVyeE5KRk11VWF2c2djRnhGc085T1l5U2x0?=
 =?utf-8?B?WUNLSjRnS2IzUXd2YkpWMG1KdEp2TDdLMjgraDZaaW9NVmR3ODJNeFNyYjB2?=
 =?utf-8?B?TWpKRERadDVpOW4wczg5VzBtUFVuOWZGc2VWVndCZ3crOWY2Z0xxc0E5VklM?=
 =?utf-8?B?Smp1TWlpZG9TODF2cGFhajJTeFdHY2luZDRGZk1pS2RveEI4TEFGQzlOQUZG?=
 =?utf-8?B?aHRRVmZRU0pRN002UHVvdllsZUhZZWZ3YnpncDl3VnpMUmlQM2dzVkkzOWh2?=
 =?utf-8?B?SmQxS1pEaHltK2czTWNtT0pDMVR0STJCT25DUSszS1Mxdm91T25hQWhtNXd0?=
 =?utf-8?B?MlBidlU3WXQwcmorU3crcEgwVVIrU1RGRm84RkJTaGRIOFpVTFNTdnRRdHhv?=
 =?utf-8?B?OGJyR1E4bklKS05LNFU2Q1hYZncyOThlRENCUlFJcUdNd05sS21FaDZKVE1n?=
 =?utf-8?B?SmN2NFFCajFXR3M1NURLMkhMWURkY1RIaGZmQUhDdEY4QlIwanhWajRNUm05?=
 =?utf-8?B?VEEwekcwRHBMOTUrWGYweVFiazQ2dThscFBVZUIrU1hXOFI3a29INGNJQnF0?=
 =?utf-8?B?aHcvdk1hLzlMeHR5a1d3QkRlN2tINzUrbDNpTGR3WnowNE5iUmU0TytPVGxo?=
 =?utf-8?B?R2NOaDNFTkF0SzBQUHNjOXRCdS9aVTNFdEpGSVBsaVE2VFFzRU52dEVQQWdo?=
 =?utf-8?B?djZtbk1sS0YzUWVSdTNvNWc2RUJaa1BtQkx3YWlZN09pWEU1UGFLQVByMFNx?=
 =?utf-8?B?YTNUaGxqQ1RSK0RoZXhUOEl1dFFleS8xSmd0aERmeEhUVFFXQnpNS3d4YTJH?=
 =?utf-8?B?WWlTQkZaM3VuTEd3V0RGL1Q2azJrKzIrbk9XdEJ0OGc5V1B6d3FHQ0dKcU8v?=
 =?utf-8?B?anNweFFvT3VKYjRPZlh6NUdrWUJrangrR3Y0cTUvNVllN01EeEhvaXNIU0VD?=
 =?utf-8?B?WHlJVGZWTVNJcnBZY01vYkZWNDJqVUcyKzU1VDduOWxza0J6eGdldVUxTno0?=
 =?utf-8?B?dW5yVWpSektRdjRmdVBsTEFtNHgvMS80b1ltbmlwMm5hNFkzZ0psWFdTZWhn?=
 =?utf-8?B?dWs0M1ZlUHRpb0I5cmZsUnFsTHczcXZJQzZKVGNqb1Y2SjVsNXNEZTlNd3JJ?=
 =?utf-8?B?V0s1M2RYdmVITWhCd21MeGMvbHQxV0tOUEh2aE5vRW01ajNsaUM1eFpDaVNh?=
 =?utf-8?B?TjhPa3NXaDExWklIZDZsVnNObVlSOHRHNFRKNDhsb1VOWG1Ld0VvYjJ3NlhD?=
 =?utf-8?B?MzB6VVJUMCtsakNDaE82eWdqdHUvK0dUQ0VRTTJwVGcwTU1zUlJYZ0xjVUIw?=
 =?utf-8?B?K01YV2oxQldBT20rMEJTL3NnWWJIQnduKzkwNlhxcUVHS1RQbG9hNC9vQU5B?=
 =?utf-8?B?bXc5aHJuRE9FM1RpNkdPeGFCaEVxTGhaOHRLR0FpV0ZVZlNqTm96enhVZ0Nh?=
 =?utf-8?B?ZGNscnhZRWgwdXBVVktpQ1RCQlVLaFBOMDEydTc2YlIxZ1BURUF0cnRLMXZZ?=
 =?utf-8?B?MXJNWk54elcvR1VUaXNBM2dtZUIzYjZLNU55V0FrNDAwV1hVSloyUT09?=
X-Exchange-RoutingPolicyChecked:
	YmpCHdUbn0cx5eeIH13uyg8s1/UIfa/xt0EBmVogCWVVhpTaeWUox7GMx0usDkF56VuTQ7+I6vOStepUZiFQnIaY703YoxT7Kx4I8FaGj5cdTpZs+r1IEmZSgOUzEqysNJkZn5z31EK9BJMU1f5HoBmtUNyaLC4E5GQRE4ajmnWlto5krCUsmumBImVi/wpUEOVcMtF2fN3/9Dvc7dmrJFc671YRm9Dow7SeTrs+8InUmnxlSEMdhvKKvFWjdwlHU9PHw48kTEvFvbrttPjFoDxzaNf4Ay3W9DPRC1cN+S0021BdYMCknlhyDTDvfOAjqJ6hTajztDXKeT0M2UgUYw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc7ff9b-e5f6-4d90-a51e-08def9ff6e08
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 12:27:39.2180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewlWQsfS/6lSA2Hn1+HczeMKDqJTgZUuIEf0ktnioscXpi98wHDXODq8cCGWrFO57XDFUkBdsHZ/CIbya8AELA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5499
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5NCBTYWx0ZWRfXym7AgJHWVuzv
 qUJkeyPI/rQWPWODMh31q3J1cUPHhkwi16sWLl4XBSHJjFZjCHFVlczaE6kFH2eo1AHK7rLJMpz
 m5gleitcxsNKmTojWg29qThkwLiFf14zQJE85m8X7/aYmZ8+2D0R
X-Authority-Analysis: v=2.4 cv=KsN9H2WN c=1 sm=1 tr=0 ts=6a7f09be cx=c_pps
 a=m+Y8nsmXU8Fd5URmI4pqsQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=gAnH3GRIAAAA:8 a=EKhcIlWS2E3xxh7DzpgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5NCBTYWx0ZWRfX5UnamM6P8jGx
 H8xG0vJST3J5io6svi7+C5lHGAixxXWL9wOS8i3XhveblKTdzkJI50YxzYE6M1pXdlimft/CyBG
 0j10fSsLI9b1H7Z0CmhTioEVdYN+rIfpDEvcO1Bx1W1P+xb2DArfiJ+U4kCA+oL8L3cYM5nZVx1
 7vLad+4U/Jk3FQoGQTPO3SmoUWkBPwdC2LgexcJBfa+dby8jFCR0KXTdmvHluFJ+GWZiv+EVRsg
 DuDRu4s9EDcVAZ59w9EefN4z80Mf+qXwIhOh/Ztlvo/jiOuDG7Q2CnPDP1uHSS3e3eyeIafhDT/
 T/MeSjktMYOVcnctvK5q4fCqvt4hx8Y5LYM8vnyk3QFQ8v3nLHD+7ejBH2XfQC94VWNy7yKmHPh
 cI4/HRCq8zo6C+pYd3sZ2z07RvtMlPFIO+KAN+VSPTkni8kExn/CFepKHxdBdnBUiK7X3kO/obx
 YJPoUYDE5uUQuM9CEVg==
X-Proofpoint-GUID: 3vFWi4pXV5Oxh-ezARjnTgH5EsHGtQm_
X-Proofpoint-ORIG-GUID: 3vFWi4pXV5Oxh-ezARjnTgH5EsHGtQm_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140094

On Thu, 13 Aug 2026 11:14:52 +0300, Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index 8c3de11a10a3..df385740b17b 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -1426,6 +1430,31 @@ static int adxl367_setup(struct adxl367_state *st)
>  	return adxl367_set_measure_en(st, true);
>  }
>  
> +static int adxl367_set_int_map_reg(struct adxl367_state *st)
> +{
> +	int irq;
> +
> +	irq = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
> +	if (irq == -EPROBE_DEFER)
> +		return irq;
> +	if (irq > 0) {
> +		st->int_map_reg = ADXL367_REG_INT1_MAP;
> +		return 0;

sashiko point is sensible but I guess both INT ouputs are pretty much
the same? So even even if there's a mismatch against spi/i2c I guess
it is not problematic?

- Nuno Sá

-- 
Nuno Sá <nuno.sa@analog.com>
