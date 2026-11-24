Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529263;
	b=B/f54wr5jHM06YU8AXm0ELBFajrSDTN6wJIIrOb3b6+umeVf03dTwWzyFFs6SYB9QVlu
	 4n2Hw6hkrAdItyew12RvOKDuivwBaKwy+CXPbyJ3EdABGB+3Tp1/r6wZ9vD0N9WIlq2YY
	 y6BG05m4t30H5kDDkkxv2vY/p/GSCZnS0+9PHdQxQHZo96yA6gdEvtoTVqvaiQsV7UK8+
	 nYZfMyU2k2fRnGjEo3b0wCGY7xn3j4sIOpWtspEPdhLQd7QjwmQ4bLykkZiU/lmqPEpki
	 Swpr6NGLeyN0I87vvrMwQQVgHnwBkM0y1UkYpDk1bLJjekaAWQSLj6Ki1h6HqtWEiig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529263;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=EPHG9GWaAMFSXOcV1tZ/d9ijRWmV1QJ0yCWfZl9b7/8=;
	b=w9RRxC8UgLm4+xXRAi6IRtfD7jsF+hezJXwwvkBKOccEyue+tuz8z1HqyKlCsLDuCBVY
	 dKWmsKi6nQ6r710PNJSVqjqR6lX4cOlO2HvmqEy7Bj4jQFDyejWSSFoqTq1bnKfmfDnQi
	 wE5LuKTXaicp1FR8NsNZbp1ZdmbLaWKsh6NSvMz8LE4OPJ4j9DNEEPjNc3+2a1mj6sVXm
	 vI+lb7Rttw3e79nky2zQBg1jMJEXOgGNqyn5e7Q2ARHL54RiIJv2YOxw9cLCrINTHr7wV
	 DtyQY/7sZpQHva1p3zCLZ5ylFhT2I6RNUc1KlNbpYBuPTBmysaIAWhcwSK/fRWYkfrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=dRqNCbK9;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=durAtJPp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F8B606A690;
	Tue, 24 Nov 2026 14:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9F8B606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=dRqNCbK9;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=durAtJPp
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AODCN3s3110204;
	Tue, 24 Nov 2026 09:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=EPHG9GWaAMFSXOcV1tZ/d9ijRWmV1QJ0yCWfZl9b7/8=; b=dRqNCbK
	9X0wCWrOw2YSQApISg4gTJh85JIpAlCIKTDbCJwC/ZG5ab1s9F7Ln+aXsF6HBXXS
	6+FpaTOzgF2bLaNR109/fVahRc2d16dYuxuPwagh5GiiRlhA72viKm7IVeOvbq3M
	Z4U9iHLIn0ThNMH2J9Fw1l7cyGfDk8lFQyvRNTwS7+NX6bbU88CnmIUQJjFM/PlS
	1Qk+X65zQKoM8dx7J+ivmd+yRtTljkCPBtDB7/fkHhH/XtpEkIXWXqVhMtq4lVpx
	i0LpZW1GqwYjel8J0c9YJ1btWuZP1yJWnOvPuDVwafrETPiN69CBZ+kamK0OYzF/
	ziamghh95lf9MsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=EPHG9
	GWaAMFSXOcV1tZ/d9ijRWmV1QJ0yCWfZl9b7/8=; b=durAtJPpGLPLJW9adDn1U
	QqLSPQBzMv9yuVxNVUm58+PL2JznqyhmE+QRyl8NIYZxs9IvDssrfUkGtu5dsrc9
	jzHmSRBIzWc3nyS+zzovEYWYnRPVYg369ARhZqV0Sca+QviEcOTh/aJvEItL0ii5
	2EO/bZJ1H6EsCwYfLf1ToPSgrccv4eG19qTK015cB+/MtvAnuF2I1VmHGnx2de78
	tEF4t7Eb3Ms/AHuIJacdoZdbrLT9hMUNtSE/aAy8Z0SxnwTVVMDrsLzo4aG09e0C
	71sYNCnF/JyiJrjzdCTmPX/DZmv1fRUkOo9VeugpgZc8OyGz94JWQmU2FcRXbrUL
	w==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j4bfaa5cf-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 09:07:28 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFfyUr7G0GgG/Dzk7hcKxGgZeJMUslwT45EZ4AgCq5Km5gunPgBEsZMSRLNefnYSE76U0pM8/at9jhpSOqXOy1h3KNnH+v0n9nwGiOLAeX7bLhwxm6IQaiznrscLlwY5DBEwTdKenyfhbmq7DKT94+5bTsQdBw3UV9uUVNm711sbqE1zZRSIHVsQ2jC1ElJYZoGd+lZEG0qI9FDVcaPJNVVJiUqPhq74kwaslQItY11X1N7waw0RBaXotysiYMnJRq+91iUCBMm/DkaMLNm3YxVWBg2+0dUKMVZAqAFEQiodwvL+Ejw7VNAordu/IMvtVgMyfSmQND+CmnBZAXoNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPHG9GWaAMFSXOcV1tZ/d9ijRWmV1QJ0yCWfZl9b7/8=;
 b=NRvzXq0/3TrfpwTNgiMqXwuEfBCTf+C2hrz+P65IbhQ/C+EjsDgwXlvyog1OoN2FKDK5tmqyfB3xbudadxewtPcggGMDMCFFk6GOI+BvwN14R0oRCMuw9zkGPFOikJKtLVVJzElirVfFuQLDkNVd/I+j0Iuun+CDJzkNjX2eHvcogPPHdrcKtbwxylgkELhLRNV5OCPz7hHFiweclD2vZlDJdWGV6gwc+hh5gvHHLgbwchAr/tZCNg9bseUJYjtiPAJjK+HZfnuAQq4bMho8hxuKSWQerL1GrEPfVyafAYchO9Cz+XFSPaFt7Lj/RrDdiVGlU037p8sK2N1YObqBWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH4PR03MB8019.namprd03.prod.outlook.com (2603:10b6:610:242::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 14:07:20 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 14:07:20 +0000
Date: Tue, 24 Nov 2026 14:07:15 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: "Tsao, Bruce" <Bruce.Tsao@analog.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: dac: add support for AD5413
Message-ID: <awWYZBYeVHNiwsiB@nsa>
References: <20261017-ad5413-upstream-v1-0-61f40c8fef25@analog.com>
 <atXY4kLEXxmG-tnk@ashevche-desk.local>
 <DS2PR03MB84188FD41F8847EEB34759D9FB672@DS2PR03MB8418.namprd03.prod.outlook.com>
 <athZVjaGYmCyuNrW@ashevche-desk.local>
 <auhqSGR84LUTjBS7@nsa>
 <DS2PR03MB84187FC75752460484048798FB692@DS2PR03MB8418.namprd03.prod.outlook.com>
 <DS2PR03MB8418EC84B10A45C01D848D4AFB792@DS2PR03MB8418.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS2PR03MB8418EC84B10A45C01D848D4AFB792@DS2PR03MB8418.namprd03.prod.outlook.com>
X-ClientProxiedBy: MR1P264CA0094.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::27) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH4PR03MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca43984-8c33-4cc6-a95a-08df4a344136
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|11063799006|56012099006|10067099003|4143699003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
 mESHiGep9ByOIBt1PVamnuDK151/HaAhOzg2xIY8GPu0CTf/CZOWz+tsIY6E2AUEoJFw/kNSaorOUW64uYVNwELe69NuuZBoJI+t6EQE8DfvzOTikXCYy/iMTEcxU7U4iXlrUSSRw7FkAEPZlv7Qb7W12J6jTjOdt1TH0250EIkE/BAmpQRAjsjqmjUIXfJstMR8FOqTXWzX971zcTO+ef4hwl24diLYty8YkNOnp874MJOqs9F1u9FzYGRMk6mPc7ksRGQ9xsxGxJmQfTHov2QVvjUrEZxfK7GBQYumpXwAIf4hJ/cKzGLbagDoHWMmTMMGOrRS1h1lm9Y/OJA7vbf7ly2BflsPh4ZKUom5z2r2SrkXu9mUQQoQn+9PSE4c/zEhdMn7d8vAedNk7gohdg9Wo8w7adJs1G7FxT+FYOhBPvEFy0cO/GCCNwjSAvfXGIdBFgqAZaiyU1bRppstja07oRZAagnVR9KeIeC8ECfXBaM169PLa5BvZn2p1/H5wYNB9JlcSXwe2oO7JT36HrAa+axm4b5F8ziPee14aO44E37TWjxijZTnnW3qf1hbiI2i/k/nvJ2q7WPodApU4mj1YaJq3OARfrLF6YARyHd5/BRxT+hK9XUBjsfWQiqMEOCIy32TYcNsxWUuhbKfbDIUDVryph0Q+tQ7n1NdzoM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(4143699003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bitWNFFRTkJwbUpGNHJBUS94Q004ejJpZUROczZRU3BVOVdVSWtvM05Vdmhk?=
 =?utf-8?B?WUNHaE44Rk5MYnRIRDhMbFJOUUJvYnAzY1k5Y3BQR05LcHhobWVtdmxlVTVK?=
 =?utf-8?B?SWZ3ZW9zM0hiYk1yOVhERHcrNEJGUXk5Z3VHZlRCN1k1dlVSZU9HSzhNNnFh?=
 =?utf-8?B?RExIOVpMTDFlSmFLMHQ5Y1dEOEVJVFJ3a2JZRG93bFdjL2k4VkhWdEZUNUda?=
 =?utf-8?B?TmJmQ1c2a1pXbTFzTmsxRURKVXVURlMyNU9BOHd0R3QyMEYxRHgxYWNKNEZS?=
 =?utf-8?B?UGViakZOZDBGWDJLWXFmYzlyV1U3OUFDa3doYUxqL1l5d05KQkdQdXFnU1Zt?=
 =?utf-8?B?RWxuNkI0YmlyVHBLcWdTa01obkhrbXZoMUNxdFNjU1crZnM0elFOMFBHQlE2?=
 =?utf-8?B?dnFybFRMcEJnUWVDcXVKOXNIakVkVWtRTk5NR011UkwvVEo5SW1sZGR6aHlJ?=
 =?utf-8?B?NG4rWVZ1bXp6cDAzSE1kTmcySGd2TW0wUmx3NEpacVV0TGs5S0hZZ3ZneWhP?=
 =?utf-8?B?VXRTSUNRdVBWUE9YV0tXa2NqQ2pzQ1RHaGUyTjJLbG9pL0FnZC9TaUF5RnlP?=
 =?utf-8?B?dHQ1YTIxcTY0WU5BWldWdTJCQWdsK0YxcHpWUzZIVElQbWlnQ0VYN0hyQ2pR?=
 =?utf-8?B?cTFVZnlPK0loL0V6bWhteHh4dWovQ0tSSGhpcFFDRmswRWFaWUhvTW1XRllw?=
 =?utf-8?B?YmI0dHRBM2d4VjdMVkdvM2Q4MDNqRm05dHVYTlE3TWJZdFJYcjgwdjBnOWxB?=
 =?utf-8?B?dEQ2STV1TWxhRFY3dW9iOUpTT1BYcmpVNzhic3ZYa2IwMWRKU2NWbVpIeHY3?=
 =?utf-8?B?NHVBbWhzeENHdFkwVVhGWDRhNG9wTTNHU0cvUlRUM0hMblRFbUNWNXdvSlpm?=
 =?utf-8?B?V21seUVGb3RyUHc5L3JDWUl2MVg4WXh4OFZaUUd5TVNOZVJQR3lTNTFqc3M2?=
 =?utf-8?B?blpuZCtUYTVpMDNBZkNLRkFyM0ZYMXRqZXhTYVpvcUI0U0VDN0JsVmF0aEx6?=
 =?utf-8?B?TDNhQUFaVTRuRTlsVEFJV3pmNXQ0ZEIxWUVaOGthaXVKNHZLQUR5YnRlN1Jh?=
 =?utf-8?B?T3hzTFdYcjhCdDluYWFvQkNlNDBKa1dRdXdrUFJzVEdPdGRYSE9GRXFkek1U?=
 =?utf-8?B?eWRjaXNDYm1sMUF3ekRSZnlFNVp3NWtYVUs3Uzd6M21LUzZUclhnTWZaYWRq?=
 =?utf-8?B?UzkvOWxuNmJ4WU54UkZRamcvVkRWNGpEWFhldVZ6cnJsV1JheGdlL3hpZC8x?=
 =?utf-8?B?MXNXZjdCMndaM2FSMkdKSnRIeXkyeUJuRTFTQXBnN2ozeXM0VG4yd0U0TllS?=
 =?utf-8?B?VUNjQVVnT1p1Z00rY0lHQ2tlMXhNbFFXOWhrM2lBVDVkS2cvdWR4UFl1UzI4?=
 =?utf-8?B?THN3UDdkei9MZTZia0NLTEhobWVXNWZURU10KzBkOUFBZGxQeUpJb2Zia1Yy?=
 =?utf-8?B?a29EakdtVlgyeVpiK25jR1JhdlBzdVVxdk55V1dOQ01scGZtalhJUWUvbDJM?=
 =?utf-8?B?dUV1dFZPbkd0Q24yNWJQUGN0UkJuQXM0dTRFNUFid1RZekxTTmJPcDhQNXd5?=
 =?utf-8?B?cjg2VnpRSG1qNFp2dUpvUTU0Sk9uUHk3RjJCejQ2YjYrdEhSZ1RqQVM4VVU0?=
 =?utf-8?B?NUVKb01KWVhCZWJhdUdwdlQ3bU1XQ0R3Q3J6TG9JZ3J0cUdjSzJsZVpCQUtH?=
 =?utf-8?B?cjlpT1BWT01pR3FESnUxQkZaaHFiRms3S0NpWjhnbzArem1iQjV6U1gxM0wx?=
 =?utf-8?B?S1oyVXBNNEdCUmQyS2ovU2hEUjZEV3A2ZHJ0U1NwYzBzVURiQmJ6WXh0cmlk?=
 =?utf-8?B?REoraTRieTV2Nk0yNzZ2SW1Udis2SCsyWVBhUGpTNHowbER4aTgxZGRSaE8x?=
 =?utf-8?B?WWdQL2xPajNMU3JNY3Q1VFpSc0hSVnRzS1hKVjBaUnlualpaUXdpdldaUzVy?=
 =?utf-8?B?KzYrTDB3M0kyOHN1V2k0RzQrRWZ2OS9XUnhQQjVCZXMwU3hBajR0V29KWlZL?=
 =?utf-8?B?dFRnUGYvaUdMckNUVXNhQkN3K0J0by9SOVZOQVZ6QkExQzhFSDdRby9YaG5R?=
 =?utf-8?B?UW4yTjlXK1VySVBXbXNDdDNRTXh0OHVPOXdneC9ZM2l1UXV1YlU0YWltV0k5?=
 =?utf-8?B?RldscmJHc2R6cHB1N1lKT2MzRE0yUk9IVlZ1UHFQQ1A1aWpDa1daUHNJZmpJ?=
 =?utf-8?B?ellFUElLYkY0a2xkaUp4VHVOdFpNOVgweDBHYnN2T21POHpDbkQ5Z1puWVB3?=
 =?utf-8?B?NnFOeDVDTUErTS8wTzZFV2dYYmEyQXZEZXlBeVVoUG9hN0dPYW5rTXRUM0cw?=
 =?utf-8?B?bi9MQ3F4bkVBZ0hvUFRldzVMeExsOHBRR3RQZ28wTFpud0swbDBBQT09?=
X-Exchange-RoutingPolicyChecked:
	USravYkmZcYIpT+cjQmAKRYezf6DNm4tegbDIAVhc0ZsRxJzToMpGTOsfCnuWoZ3kWRIhC0XB1wduaK3F0OdOhwUbc+CDN2+pWNikNjBikVZMCFgPlt2+oUjlM/h3ea7QV0YiHx/L025beZaPQmOT4LzCBX3AygxEZ0nGcAr6Q2b0XxJ9gDXymlkd/20SpxChSbZwH5vOr+LcQRei8/WjkP54ePSrR7sl1IRIXwp8EsnN1dEssGkhKcfnZv0a1HmHqPbR7I+hPa8O8CvNeKWYLMBT5sXjjlyM/0GdF1gr9jWdjiBKo7HRUD8ih9s4FNI3ynMV1omNFE6KGE9LpZlFw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca43984-8c33-4cc6-a95a-08df4a344136
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:07:20.4613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kc6Qhew/9tBHJfu314vfwu9DDKau+bUQpuZu6qGS1RLs9uA2Nr0Pjd78f1QBxLSMhxLLjQs1Dy+pheDgQ1U4UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB8019
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1NSBTYWx0ZWRfX53dTCLiHXD4u
 Zj3MG7cg/fNTJCPiTlrDs5wELIuD/W1uRk2vhZG25b4LIdbaXSLtQ+pmEsWX2J8zd6eevVGIFTH
 IRT+I6UD2vFOThYM8I0hoYXYOh+NYS+A4lxRfswn80t910hMDsRuTZVXPmEZsrT+lrphRizNun0
 ZyJjrjLhjFrDmD4xE0KkrocnemOEKdK6F6ADCCzcDi/ne8JbDuVdGC6GD8djktYjLyGXVyFs7pL
 ddkvn39VeKWWoHDrJ1pxBneZgY/PCINu0u8ug8RLi3s26KUyZwrJVBPhW3D71tAyzxs7k7eHRpN
 R69buNNWY2CZCO9+BNqU+/eZ/fCWg1jScRfS5hAfvqk6oqT3F4GU0P2n7mZQj6hlHWNIK5INvAg
 Nt3eLDnuOj9wBK1CgDWzMQ3I/oKCDUVt9az5tYUmYcARo0e0QqMqj+/GWa2RzhZEBxA7uxFFASJ
 /9rX3bOBIb0VQhAcx9g==
X-Authority-Analysis: v=2.4 cv=OK+yTiaB c=1 sm=1 tr=0 ts=6b059a20 cx=c_pps
 a=0p5N1A/s2xr2YPsuh+j7dg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=hgoTAu6ReF3WpQNURHUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RmTLD7aGVgIhrIaMi0wblRH5prCxRj3F
X-Proofpoint-GUID: RmTLD7aGVgIhrIaMi0wblRH5prCxRj3F
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1NSBTYWx0ZWRfXw8H2bL4P/KMu
 0046QUErDvJVN+uDV2LOOAtpOIcb78BAEo2RYGwhzlPUV3mOwQZcqv2SW+Lw8ai2XsR4Y+Su0Z2
 SwxqqxLrbjAR71YHoXng2GoVQgQYnOkEU6UUaaDNDiSMLJ894koS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240055

On Thu, Nov 19, 2026 at 07:46:04AM +0000, Tsao, Bruce wrote:
> On Tue, Nov 03, 2026 at 10:06:08AM +0000, Tsao, Bruce wrote:
> > David -- since you have the background here: ad5758 currently carries
> > CRC as a TODO and disables it at probe, whereas the AD5413 implements
> > per-frame CRC. For the merged driver, would you prefer (a) keeping the
> > AD5758 CRC-off via the flag (no behaviour change), or (b) also
> > enabling CRC on the AD5758 to finish that TODO?
> >
> > I'll get started on the no-functional-change refactor in the meantime.
> 
> Hi Jonathan, David, Nuno,
> 
> A short status update on the v2 rework, plus a gentle ping on the open
> questions.
> 
> Status:
> 
> - ad5758 is now chip_info based: the per-device constants (name,
>   resolution, full scale and the DC-DC/CRC/reset traits) sit in a
>   chip_info selected via the OF/SPI match data. No functional change
>   for the AD5758; I checked this by comparing the generated object code
>   before and after.
> 
> - The AD5413 is added on top as a second chip_info: compatible and SPI
>   ID, 14-bit data alignment, an optional reset controller (falling back
>   to the existing soft reset) and the avdd/dvdd/avss supplies. These
>   are all per variant, so the AD5758 behaves as before.
> 
> The main open points are the CRC framing and the output mode, which
> is where I would like your input.
> 
> David, I would appreciate your view on the CRC question quoted above.
> 
> One more point, for David and Nuno: register access still goes
> through ad5758's own SPI helpers, which is also where the AD5413 CRC
> would go. Should this series move it to regmap, e.g. with a custom
> regmap_bus as in ltc2688, or keep the existing helpers?

If the helpers can be reused without much trouble, I'm not seeing a big
reason on changing to regmap. I do typically prefer custom regmap buses
but now you need to convert the whole thing so really to you.

As for the CRC, don't just wait for replies. Sometimes things are missed
:). I would just not change behavior for the existing devices.

> 
> Jonathan, on the output mode (your adi,ch-func pointer on the v1
> binding): in the ad5758 binding, adi,dc-dc-mode selects voltage or
> current output and with it which of adi,range-microvolt/-microamp
> applies. The AD5413 has no DC-DC converter and only one range per mode
> (+/-10.5 V or 0-24 mA), so only the mode needs describing. Two options
> for the merged binding:
> 
>   1) Reuse adi,range-microvolt / adi,range-microamp: an AD5413 node
>      carries exactly one of them, and that selects the mode. No new
>      property.
> 
>   2) A top-level adi,ch-func (1 = voltage output, 2 = current output),
>      as adi,ad74115.yaml does for its single channel, with the same
>      values ad5710r and max22007 use per channel.
> 
> Which would you prefer? Or, if you think now is the time for the
> generic DAC binding you mentioned, I am happy to go that way instead.
> 
> Jonathan, could you also confirm that you are fine with adding the
> AD5413 to the ad5758 driver and binding, rather than as a new driver?
> 

Again, my reply now might put this again on Jonathan radar but I would
say to wait a few more days, take a path and send v2. Worse case
scenario, Jonathan has other preferences and you need v3 :)

- Nuno Sá

> Thanks,
> Bruce
