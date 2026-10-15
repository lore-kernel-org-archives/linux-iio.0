Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228EF17BCA;
	Thu, 15 Oct 2026 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059377; cv=fail; b=Ocs3Il9y/Eg2YI9A/aV02uuya/M1RVv5EETnf34YILZMaKOrbqgbjxmlBCt0rLM7zn+iuNYPvhdRVlhzs9FmD2JzfrNWUwDZc5GhZA/lnur3i8RpXDKTPxNf54oeDPRw2c5/ZyK/JC1Fktlg2DGw3uOtqoDDUyaPEBGSdiYV+vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059377; c=relaxed/simple;
	bh=FMBI2zwEPbGS78fCecDVO4gzTH2xnb8JB5fVdi8ugZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vw8+Pf27vdJqofNIF6UMaoIWn7d5KNTkitKdAqgLJ7m7RbEi2fOQcJ5LSj0YXShiCU9+V5YpBU9mdl/d/Jyx7YwtMyrPKUpxvMu02wwlkQ9jUhySoKZ4wGiXN9Kom+ItxrvVCWPq3adFseG4/XMmIiAm7fkvjg0UFSreUzxZsTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=jAmBlhvU; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=G4iJuhRv; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="jAmBlhvU";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="G4iJuhRv"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9kadR2122808;
	Thu, 15 Oct 2026 06:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=ezSetLxBID93CIDvkgT4Mc3ryqpQY+u7cctMsplOIJ0=; b=jAmBlhv
	Un2oK5ogfD5RIrWbCI7LgPjQtwzAO4e4UVw4LKIRmeLiZeTlk8IhuUPRLw85uvmf
	GnuXoBzKbk6NEJXv8wpvVV8kdCWD6VhNP3ka5cYHH+Cw5fck/JXRpPQoF4JdSfL7
	nqUYpaH0KdhlWtYxdOZ6ca6ccO+9BpGbPCQ0T3Pqt2eWe6WVhS19FfgUCKW6t62N
	upzBh2Pe6jLJerV+3Vgy3jrrElfAcpWsrXFTkR+kpWZwj4QpBNkm+GdTVrbDqSt8
	ZSWdTX/E+N2KGrzBS0zPpaRQW8v1AS2j/RxmX0wB9BluVJlqijGhHihKMtkZkW/w
	9wyAgJStUpqz4Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ezSet
	LxBID93CIDvkgT4Mc3ryqpQY+u7cctMsplOIJ0=; b=G4iJuhRve56pLU1+dQXHu
	kviDaGQq1btHEN7bijFxDyixwpMosfksepl3eWE5QeP967fgK8QE8O55I0U2OgE+
	9RCMan92I2/CPULiXL5AyKCMErjB5JWx9aJsy8CnEMfM+ObgnoesqEKbsptLEgAn
	HO+NUWIV+/Wyp/rJYqn3RQOR8m3L6BBlszreR8nbVoCUepPRjNPlPAJtVdOkA2HX
	doyVEr8CIUwdzOeVfa49xWZLLBueBl2krF5IuIMilXxZqAeksVwphLNFvIyZWI83
	WECyzNBFhHtyvNiV+erOOfldc8fcZYtqSh/wHY/4CZg32jW6ghDY4KkijraNrzlc
	A==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4haab6652k-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 06:16:10 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fknaZQhv/OJtZdmJ/2fry1O/W3sCvhhw+5OpdK2Dy3rhROhWa7y6JrRHhs+f+3YQs+r/9OrhxxkcqjCCky/R4y5fiXQE3UIBcDr2SBcssqi5/AatYBfRZtpkAvh2gGDcVgGizDeRY8ma/Sd2VTneDeY5fXZY+VZe5T9NmdYD+iTlqwNJ12EV2D4w9GABi8BGfJqLqH+uzUr5souKZXLOh3oor7q/OctCR7nH2SLnvnnJwIcEmaZPLcD6xXsmMxlozg/aO8/+In4wIVKjwjUUrMmJ3dV/ebdeaogGz3u1ItzwkyI4DA9w9mwhFhhLPdlkgy84WvAiRJ6N4p+D4P480Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezSetLxBID93CIDvkgT4Mc3ryqpQY+u7cctMsplOIJ0=;
 b=tuSR+rXwpfPmFN0w7jNluAP9udQNWDrvbQZQ7hzafdtekn6BBTqiR1DKc2DGp/3TmDk6gw9FxtZ3d4zZU9INuvg/Qp9p1FDYW/6zVCzuez1eAm2yhi+swiLAzY+m94R3q7s1raAFTqobC5GGi/osge4Lc2wgmKvhDBCRfHDqiZLWblG1EqnfqBXKq/LWFlHpLIX9+w8Mekis1KQEa8BQUI7LvDG+pzFUYDHg2JorB3RpJ9UAiNK13Qpo5pvfIBVYsNoeMRclHh5BdebHymoODa/q1GwLoeX1RavuOqHGncSWHoqchd+iJgJVmYFYQd8kNQzaS0EgSCa71xCIhCA1FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA6PR03MB7663.namprd03.prod.outlook.com (2603:10b6:806:436::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 10:16:08 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 10:16:07 +0000
Date: Thu, 15 Oct 2026 11:17:28 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Shehryar Ahmad <shehryar.amd@gmail.com>, Michael.Hennerich@analog.com,
        dlechner@baylibre.com, andy@kernel.org, linux@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Budai <robert.budai@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Radu Sabau <radu.sabau@analog.com>
Subject: Re: [RFC PATCH] iio: adis_buffer: fix buffer ordering for IIO core
 demultiplexing
Message-ID: <atCl_aZSFGLu5pf6@nsa>
References: <20260925110239.59320-1-shehryar.amd@gmail.com>
 <20260927185929.70635769@jic23-hlaptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260927185929.70635769@jic23-hlaptop>
X-ClientProxiedBy: MA2P292CA0021.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::13)
 To SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA6PR03MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfc99e1-9721-47f5-4d8d-08df2aa55409
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
 IGPJg2qIQ9wW4DeYYSj+Dc4RZMuSlGuRAykM7ck6g2eLYWf3LgJLxqVHlTJTZ1QoWhg8CtNAQMZZjkLHooDSrUcjn6499IgAQHAzrQ620m0GjDIfjWY1rPA0p/ThZPWCfGFMKzRqDjBzF71Ml42iLT7M6ccqMBge9GJDRrCJhU1hhT90L2gI8pWJB8Q/hWRPzptnINPVVlV3A3Nzu2L7sHOqoufgGrpGxs+K79P4Osu4P7FStH0nxaZXsn0+xqeWcgjMOMkYGdxBz89LWy8YXjKvn8Vdg50AUkt7Ks1wymmKO9ubNZ0LszfWL0T1qcBxRtd323Q4MHUij2IBvqttbAXCDZdTwyw4Bn/2GqZAOifZaIoZBWczzy9f85U2z6EwwkbqFDXTZz1eNWmOfhKPcL5t6ovfYJTGxbAJXOz+jrKV/37weSZn7rc1w47KGT2lyv/YMzSWA4Ea3pCEOq4tIQwiH0PY44iqWpwt41Mk7gV456MxHxQuS/2mrT3KZQqk9patjS3IL+zDxP+C8fGx2Z4je4d1VKVKy6ngQ5rRaZH9XgqPqiOyjc8qG1/C7Gy3HZDjdew+7mqXsRJrcKdIZ+AEatSUN09Y3c3ZF6wq5m0jyhrmFt6pJSm/nLWYgVKp
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aSt2U1RGdHdLSXJvblMzZjF1ZERCK1pLYmxkZXNPWjRUVE9jVnJoUHdNK25O?=
 =?utf-8?B?RGZZQ0xETTRTSHZaeFNiellxc0pVSkkyQmVLTkxBQ2dBd0N0MXJBVEI3d1lP?=
 =?utf-8?B?OHU4d0dqVEtPRW8wTVhsOXNiMzBBSkJuSXMvQ0dJMmwzaWVHSGxTMk4zbEdR?=
 =?utf-8?B?alkxYzVWUVU5cUdpTVpqYVNDTEpnamRSbXRXZGRrSDcybDhaNjZVTmdiQmRy?=
 =?utf-8?B?RE5CZnJoTkxJSktNbklUZHBsZm5sUkxKQzAzVEtlWHV0T21DWEVtMlg1V0pm?=
 =?utf-8?B?WllmdEljdDVVSTZ5K1RTNnM0Y2ZVcVZWTWxvQ3hLSEF2L3RpMm85LytHS01y?=
 =?utf-8?B?MDUzYlpUZVVOVEhxVk45dTFpNUx1SW1VakNOR0QwMTZIUzg5WVM2VDRNMEdP?=
 =?utf-8?B?RzBEZXg4Y0JBWGZ1dm95a3JZVlp4Unp6NEVZajJsUWtOSkUyaVJqSXBWajRr?=
 =?utf-8?B?bzR2WVgwU1JGNVp3WUExUVFYZWNhWHpIVUM5MnBqRU5MT0RJZTNyV0tZbGNX?=
 =?utf-8?B?dHhLWXFtVDRCZE94dXZUNlZwa1g1TGpxQ1J1dTQrZVR1YUdpK1gvaFU4U3BM?=
 =?utf-8?B?aHBmUzdhdWhvekxLbzdBQSswRHY4VVhLai9uVmo5L0xDWHNtQk5DRit3cHMv?=
 =?utf-8?B?UCswTjBjQkx5MHN6YXNVYlJSakZkSnMyWERtUktUUmZDNndoNUd2YzRtbHdt?=
 =?utf-8?B?Wm95NElZNWZDL01yWHhES2MvRDVOT0s2czIxLytqdWxsMTBqcS9TYjgrMUV5?=
 =?utf-8?B?R3BacG9MQmhVeURHSkZDTXVaekdEVWFTMnhGL3lVYVM1aW9BQ1JqQUZoTzhl?=
 =?utf-8?B?cnhab2JaS0ZIMTFGblRXSTlONHpBREU1c0lqT3dzZ3hocmZmOEo2VFJhWkM5?=
 =?utf-8?B?eE1hNjZKbDRMNGxaeFFyd3FhSW45Z2p4SW1uNlROSXI3QTl3TVZVcVdxKzFD?=
 =?utf-8?B?cGp6ZnMvbnZ1QUhDVVRTcU5BcDF5YjlNcEVGbEtrY0dMZTB5TVpXTW9LcWpl?=
 =?utf-8?B?QkRZK2NTdHhWbjRTNHlrV3k1RVBScDhHZmp5SXEzdWwza1F6bGQvd0FQWi83?=
 =?utf-8?B?T20zN0xsbjZwOWt6dWtlc1o4M0Y0TGJBWEZwdlczVjhzQ2paU1lYOHEwQUpM?=
 =?utf-8?B?bFNqOG43bys5b3RxS1d4dG1rL0xoZDNCcEUySnNjS1lGTWNLcHZwbUJCdkRs?=
 =?utf-8?B?YjVxRHljYTFrT29mRlh0NmwrOHp3cm82dGFLWGc2TlhtbVVuZkx0ZkNaTGlZ?=
 =?utf-8?B?cDhhVWlqMTU3NTBNRCt3SURLcVFycGg2aE41ZFhCWDVnQmhMYWltY2M2dWo3?=
 =?utf-8?B?bks1Zm5UZEZ5Vjd6YUViOUoxdHlNK3RJN1QvTDZTNWQxNXNXSlczZ3pxSzhh?=
 =?utf-8?B?L2ZXNlphRGd5YzdscUdIM0F0ZEJTMHl4aTUxYTVwVUh0WWwyYWdKaU56L1Av?=
 =?utf-8?B?ckwrUllwUVQ2S1NtenM5ZlR5SmNiNEhqU2o2bnR3YitncnliZUthc3dtRTAz?=
 =?utf-8?B?NitOYUNka2RKUFhTbUw4RlZncEExdFB4bDBSVFRWRlA5dUdHYjBSNmtDNFJN?=
 =?utf-8?B?YmVHWnQ1OERLYW82RE5rVTZUZzVIbzVTTFF6WWlqRW9saHpPVCsvd0dudnd6?=
 =?utf-8?B?cUkyYWJucjFPaXh3VHR6RHJEcnRTdG5QS2kxTGQxRHdQekkySjVrN1MwMmRq?=
 =?utf-8?B?ZU5zSi9kblBYbUFWUWd5V1o1U0kxTitNY3VMQmRkQ1NxajdocVVxcStjWGd6?=
 =?utf-8?B?MkV3c25udWdyVUErWmJraHk3SnE5em44cEpIc2Jxbzdjd1VSdUEyYzI5Y1RE?=
 =?utf-8?B?VTZFc0lPbEZnb0c4K2xKandKY2dURTNJWUQzL1hnUS9kOFhJeFVxNlZ0dmVN?=
 =?utf-8?B?SVpSSXQxajdFVlF1TzhMSFBkcnEyQ0dwUTB5WnJYZTZxeHRGQW9YWkZYOFpu?=
 =?utf-8?B?bUt1TG5tTHBHeWpTSkIrOGFXeVNRcjRZVHB6czgwbURPNjYxSDRXMjhPcnND?=
 =?utf-8?B?NUhzam53VGJmV0hEWEsyNmZNdjh3UDB5Q0FoWVJjQ00rdVFjT3pYcUh2Z1hi?=
 =?utf-8?B?YXI4eDQ3bXJwOXVVbTd3QllCTEJmNUl2WDlRK1FWZEs5ZDV5aFNIbjVDbEht?=
 =?utf-8?B?cVFjdVVVbXU1cVhxSGtWTjVVWGk3VUdNRDU2L2ZoeDRkOE9MYm9UVGNlazZ3?=
 =?utf-8?B?N213cndNU296Z3Q0dEZBeUZLSGVPc1R5SmZwSTlqaFZZaU9pdnNDT29XU3o2?=
 =?utf-8?B?R3FKTmIxSVVZaldKcG15R0ZZYVkzTDNpaTIyNXlwcHNodWluYUFEMnZTbTM1?=
 =?utf-8?B?cWFFM1NqdG1nc1FOdG96djRZWkRyL0xadWY3RXhPd1dxM1RJQkRndz09?=
X-Exchange-RoutingPolicyChecked:
	1JN38TOqcpzFvaGT8zVPy0oOhV1dn3NpTs73Zb+K1XR0rkPshg0Kj7wvT4RRg3pZ/Ng1zVFYs5RUDeLShIKlK/eJuYPF4dYsmVNOt5gMQcE2Fv1hJ0WcegKmD/xf6A8YWgTu7xmowsmqlufZbEZfLCd/NS8dmXG2fU1OXSeI62BDadUpwdN/C5ggSRNJzrV+Fey+UffMcIpkBu7nPr68XHY1mL3ebyxdGRRCbEyZa6lr8FnQFY9rGZS+5QnWS8DDjGfe3Y85bKqKANZcckYKOBcWEMzzqGhpk2w/0fEYalsdKeKEjjyVKKYaV+Dzo6N5cRoJIWhwIuE3+OPDGfvadQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfc99e1-9721-47f5-4d8d-08df2aa55409
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:16:07.9372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Su8vaXb9xxZMMd3fqbB5sfzoFaJbunhm+pX9n6/WMJrECINHiHIAanA46ATSMaZAhY4rguRbix0RrVE3+BRlKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7663
X-Authority-Analysis: v=2.4 cv=VIJIDNPX c=1 sm=1 tr=0 ts=6ad0a7ea cx=c_pps
 a=ul7AMzggcqKAecwK2qVOCw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=bdtsRZq1vzi0FfE1ht8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ompg5brh0P1EsXrik3uul62CyW3Io_39
X-Proofpoint-ORIG-GUID: Ompg5brh0P1EsXrik3uul62CyW3Io_39
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MCBTYWx0ZWRfX+LGZBK68Yszo
 U/t3vvUNdd+AUhioi2wP0MQhrMpfTnaUCiQstGq3/OS6/RuooQ3lzrCw1HKhjvH2yh5pkfNCpcr
 cZFPkN4waTy2S3f8pB2UPFft2I/7zCRDmsHX1Apy0gzNK0LwC7rcz/2DR3TJk/e7hIL3+wOpd2W
 Rud5CPGChX3Y03exlrBZ13tzWEBdMORthCpe97aPtWgQ5g5HjDn5Fp8+UKdpawxCUoIJlABJa23
 WRz8GWtK2yXgbjIlKNxlgvuW9z+bQDrudN3seSXghiDEYfW2aBT5sevKR3fmVlEoWG8f/mRB/37
 EVSe2Vmd3uUQ+hDy7xXhKAyyL7Xwjdj6nWqFxl3JzVfCZt2FcBth6+uIxBtHucah2iQZVtq4zDC
 B7lJjPrS5EALX1TiuGcDxhQ1Z0P8/VeEYlFhgJ/ZxItJB2NuiV42CtjAlCu2wwQVZPDC0xjbB/+
 rj+17etM/Rpcf0asbHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MCBTYWx0ZWRfX59jJBvbgPsQI
 rl6syqdoZV0JO1hqgS0kuaxlUqqfX27MKjW7hjUJlQsvWQkv7QYoDkRvvJsoIgHka81vaJtQ1+T
 bw4o+K5a1jNW+GfKKHeBMc1iwLXWDDhei0bqWvYyEyI0cEpTaV8o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1011 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150040

On Sun, Sep 27, 2026 at 06:59:29PM +0100, Jonathan Cameron wrote:
> On Fri, 25 Sep 2026 16:02:39 +0500
> Shehryar Ahmad <shehryar.amd@gmail.com> wrote:
> 
> > Hi Jonathan,
> > 
> > After issue raised by Sashiko in adis16203 graduation series [1], looking at
> > other drivers if they might have same issue. It appears that the root
> > cause is in adis_buffer.c itself. The library constructs the SPI
> > transaction in channel array order while IIO core demultiplexes in
> > scan_index order.
> > 
> > adis16209 and adis16260 have the same mismatched ordering that
> > adis16201/16203 had.
> > 
> > Rather than reordering channel arrays in affected driver,
> > would it be sensible to make adis_update_scan_mode() iterate
> > in scan_index order instead of channel array order?
> > 
> > Would this be the right approach, or is there something I'm missing?
> 
> It is definitely plausible.  For this I'd need some input from someone
> who can actually test some of these parts.
> 
> Nuno, you are listed as library maintainer - so can you get someone to
> look at this please. +CC various other folk from maintainers or who have worked
> in this area in last few years.
> 
> Otherwise, just a comment to use a Link tag for cross references.
> 

Hmm missed this one! So the issue looks very much real (just by code
inspection). Just never saw it since the more recent devices I worked with
just do burst mode which is not affected by that path. Moreover I'm not
sure any of the affected drivers is really using the IIO demux (though I
don't think that matters - seems to me the buffer will never respect
scan_index order so not sure how it was ever right).

+Cc Radu as he has been working with these devices and on the library.

Radu, can you give a quick test here? Worst case scenario and you only
have devices with burst mode, you can just tweak the driver to disable
the burst path :)

Thanks!
- Nuno Sá

> Thanks,
> 
> Jonathan
> 
> 
> > 
> > [1]: https://lore.kernel.org/all/20260914015321.7a660ab5@jic23-hlaptop/
> > 
> Link: https://lore.kernel.org/all/20260914015321.7a660ab5@jic23-hlaptop/ #[1]
> > Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
> > ---
> >  drivers/iio/imu/adis_buffer.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> > index 501da4eae..45200b753 100644
> > --- a/drivers/iio/imu/adis_buffer.c
> > +++ b/drivers/iio/imu/adis_buffer.c
> > @@ -110,10 +110,10 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
> >  		spi_message_add_tail(&adis->xfer[j], &adis->msg);
> >  	}
> >  
> > -	chan = indio_dev->channels;
> > -	for (i = 0; i < indio_dev->num_channels; i++, chan++) {
> > -		if (!test_bit(chan->scan_index, scan_mask))
> > -			continue;
> > +	for_each_set_bit(i, scan_mask, iio_get_masklength(indio_dev)) {
> > +		chan = iio_find_channel_from_si(indio_dev, i);
> > +		if (!chan)
> > +			return -EINVAL;
> >  		if (chan->scan_type.storagebits == 32)
> >  			*tx++ = cpu_to_be16((chan->address + 2) << 8);
> >  		*tx++ = cpu_to_be16(chan->address << 8);
> 
