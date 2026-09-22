Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB03539791
	for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091781; cv=fail; b=cBP0j+k1MT8iDj6VWwEZuKijdI1EiWyn5T8MxYCRTur5jJX3qsVitqL5BirxaoYEreHnjY9O0vy6LvUSuqQmLDnzraxcvCOpHqD0EBua1AK7jOa7MfGYdib3QDyrLSeGEzO848fFZzKECupv5XNS8+743bqf1BuSiDzWASAsghs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091781; c=relaxed/simple;
	bh=9qrJ7JEG+qmbGpReWU07aZi4HaXqo9tMr8QGmkwLwFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YwKZDZrY5pw/PtoPJYgE//HABIT1HjUREjtNkTa283dBeDldNVkvX2QU9v5ga9FgBnhQo4pZTHHV7A8eGWn7qd3GtdbiZ7a+Kpt4iEg5xWJsKJ5AQML+BS1UoWjeL5BDzdj50uCuRuIjwdks4m7hK5c+BrhIQYP2wcKXcgT9e2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rAuNrnBV; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rAuNrnBV"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MEjSp4680916;
	Tue, 22 Sep 2026 11:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tB4LD
	lkE1LtHn/02ZLoYkzzAbN5OWlughdT2I71B0Zo=; b=rAuNrnBVQL0hHYvK6O1Xy
	6aStu2VYNo/Gvq9PfzKOWVIV2jU0TxrlA1JH5r4shNoaUxypzHwZVElPupxi5oSm
	XOQwm5Vg7fAMox9XVqm25Fol47AprktWkQcbEII3z8r9e1R/JHbReMKEIKSPWBY0
	rmD7ANNdVkh99uQRnxFgjYV6LIPp1kpvJcwRcHpfHbNB5+5aNIH1YHbcW8j8fM4V
	meI3oSDnnlBWsVZ4cmOIf/z23x6iLS7Z0/LVYsODG341oSHn0PbChg6/Qf5zgA4D
	jZ7ODBU7O1ElpgeUQf/jo43ENQeXVAIbI3CYrNXcU+JdoVaDAbviiRhYZFl1LALq
	w==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013012.outbound.protection.outlook.com [40.107.201.12])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gu3dmq5q0-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 11:42:54 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMe0Zfoa6CTw5M6tSs3GhJo3qfMU6r2OHdTOkLpsfDOlV8tFXYKwcGWPPkzy+DWb6ASg/k6R5dPa6rMWLi1kSKyfz6ZMuiHGbPF4oTlh8rOCS7Cn/HKEQv49m4JX6yBhyRmPPDNDhEM3iOi5I3TEDzw0qIjkBc/Za3XrLC6ARDc0FmhK7D1XUoFswP1PjfEQ2St/koZpfped0v9AsufpUpUqMd5J0SMD1P307ngjyEioGnR1fcsk4dsbsPoPu+aJMlgHUFqbxizSH/Cf7ss307t6PF+WicVGngsyuE24xoFlPB03BLJJz0dBsMUbw/SDBeZCxWvqlzxCAwC4pZmWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tB4LDlkE1LtHn/02ZLoYkzzAbN5OWlughdT2I71B0Zo=;
 b=KxtuOXf89pShgFHk93P+3CnpDSZl5gPa95XWZ4j9DPDipBb3b9STmWLxdc8oCAyUJVtw7UQduy8LDMA9nAl7dZFwO5kxteoAhl/DorSA+taCcQpAcKPv9IljwFYH7L+7AHqo5VJQmYAnMqLoP09F4ZSbMFDQK7b2gdqmoR+amboKvtgL0bErYGsVVfa/22bcCiaSHZ620tmzuM3F1c1/Ae4YPGL+vLIG9JolOAQtEdLsgkKP6PYOFb2NLEnSjX+dd0sTEfYJj7+dOy1wYpuxdL5BKze90Fbyd6cAZqq49pX2+g3YZ3A9OR4t8KJN4E7jDkMsYeyFk+wtDY4mfXfGPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by EAYPR03MB840817.namprd03.prod.outlook.com (2603:10b6:303:2fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 15:42:51 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 15:42:51 +0000
Date: Tue, 22 Sep 2026 16:44:07 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
        jic23@kernel.org, andy@kernel.org
Subject: Re: [RFC] Maintainer entry profile/contributor guide for IIO
Message-ID: <arKhAjl9cnsOSzfH@nsa>
References: <20260817111825.000063f6@gmail.com>
 <cb1937e9-c2fa-4d8d-bd95-f53423d88077@baylibre.com>
 <20260818090652.000020bc@gmail.com>
 <arD2UjzKu2k8elgM@nsa>
 <20260922165124.0000132f@gmail.com>
 <arKWs7nTaJAda-XA@nsa>
 <20260922170734.000046d7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922170734.000046d7@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|EAYPR03MB840817:EE_
X-MS-Office365-Filtering-Correlation-Id: 20342a79-f59d-41f3-6c2c-08df18c02908
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|6133799003|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 bBYFio0O0ymmQo1dmLTfxMKSo4qNKL/Ox9TqGA/9cXI2Yr1P6UtppJpz2l3xX5x8sDWKGCpUzUC2sOxNgUfZFmf+tNpDdKCiFUbBmoys2YBO/sN2ksyzloxz26kCXo4zHfIeoWmneK/Fvz2oGZCcV+W/llGpAYRKh+CNwUPlm5VaLSrYgGRiwemjHGUEtRgvAoOxQlB7xmAKhokTwdkn9pya4r3LjcR7JEx5/+EXu3HJc9bNsH+pMhjwL4ydTnIpvt6QROIuLkeET7aHr0MuyfsvXSjc/DZv59WPy7lKure9wZJ6YMcHQUA4M7OAvOM1emRGeaXChLlGRzrsfvBSS0LigDIQHtu3uKgb6nn/0oPk5ifLvzytgy45XwaedgaVSMiw2Qo91JnpiTtPazUTktn7+C4uKjfGpOcrDXzGt+BTNfgGPaN1FaR6ar4hf88CDBAcHfoh5EtZjhiyy7X1kzez4KCyQK4LgdasiNpOwECTZaerXEs50FzCqTDtWE0jXAdFDzQoKF+/6tp0AZsj12QZns3c1+yDbyuCM6uTuG4nuTX6az7ioARTN+9bB3vJ8CLucrY2VITkRl8ufK5DtRnUieqA1NsKUxOgEjlYfDmsKpYxmGb9qeZMA1sny//lh//jQBMWxEAYL969YffLUK99VbqNFn57VYKlOWHQV44=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(6133799003)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TGdENE1KcVliZFlUc0x4YjBQSFR4eE5ZK3JGQVIwc1cwMktBbkVta1ljdWpM?=
 =?utf-8?B?S2x3bFBNR3lyS2NJdlNhWUlTSU9SQjVpUGNQbEdGMWJQeGtuTDRKNzV4WjJW?=
 =?utf-8?B?dURlbHh4dnFnZnpLc3JORTA2VjhsOUxGYUVIL1FZRmhJQ0JwMm5WeUhPWFdX?=
 =?utf-8?B?eW8vYTNlN1cyMTNHTE5INFJMMFlqNHBqZjltS2I4QzVJQnRJcWt0ZW4xcGxr?=
 =?utf-8?B?cHZ6UzNwZFlOaE5BVDJ3SFdZUi8wclAvaS82VzlsdlozUk5Ea3E2OEJSbS9i?=
 =?utf-8?B?eHM5WGU1cCtvcndxb1BEbSs0TEpLS0pSS0d0OW4waDRhRUozN2pXSkhVU05R?=
 =?utf-8?B?dEFXcUhTVE1iM3ROcXBOcVFMbzBmbU4xdFU5d2JNK0I4OFgxSnJtdUtHblBh?=
 =?utf-8?B?MVRlT1NFTTBzcmU1MTkzdlNDalVFZlRUd0thdDZxZ044OElBbDJnWk5QWFJt?=
 =?utf-8?B?aVRpYnZ1SW1Ia3ZucDRBY1ZtT2JoQytnZkxtd3VDMHZTMGUySXF1WFpmWmMw?=
 =?utf-8?B?ZU1qUXg5ZkhsNmF3eWE0YUFmZmJSdXIxT1M3RU1lZVdSaktuOCtKS3V5Umxh?=
 =?utf-8?B?TS9NZzVMaWVkK25hS2xWKzc0R200dmVvY1RnbjFwTlNpTVJyemN3VFZZc0gw?=
 =?utf-8?B?bkhLelFwdHAyZnJ5Zlc0VVVvV29OeFEzc01oMjNqME5zOHBEMDVRN0VRY0gv?=
 =?utf-8?B?eFRQelAvdysyczBuMXVKNDErSjlUZFpKWXBVMnorenplZFVMTk52YjIvQzZX?=
 =?utf-8?B?bEdYb0dmeUVpZDJtbE1nbXNHYXNGMThjNitMUjc2Q05pWWNSZ0pUSHRNSEl2?=
 =?utf-8?B?WE00UDF6MzY4aTVSbEpKelZUdWpaSGFjNGlEQkRrVDQrQkZXS3owbFhLNW1X?=
 =?utf-8?B?bDRJSU9hRDRZYWZaM1lZOExTVzdkem1LUGFpYUVZM2hraEpoMnc0d2x6VGJG?=
 =?utf-8?B?Z2RkWk5MYU1yanBpazlLV0tXMGpKcnQ1MWtYQ3ZodTE2Z2pudnd4SitoTHEv?=
 =?utf-8?B?NXBzS0IyNlY5eE9rdlg2d0V3UWpHRERSd3duaTQ5a2t4Y0t4Z2R3VXVmYjFI?=
 =?utf-8?B?NVZrb1QySjduSUdONTAxdGNuWkhwQ2lEU21mYjA1cW1kWk9SUURXbS8xQnM4?=
 =?utf-8?B?dEF0bFNZM2xzVFlJTFh6NHhZZTRzMVlvbXNSM1FLSmlIQzIxcXpGMnpNNjRh?=
 =?utf-8?B?MWVkMmlaekZVN2krQWVIcVIvREdzUFFrSm51b0xpSktYWjZWNGJCcnc3UHBN?=
 =?utf-8?B?MUIvZTNTRHRWNmRVUEZzRkhVQlhiVmtYWnVETWRpdXBQTzZSWk45c2NoRkxF?=
 =?utf-8?B?V3JXVHhDeTJ0MmYxMDY1YnVnbmQrYXpIZGh1QzU4anVkdHA3WjBsT3p6VEpJ?=
 =?utf-8?B?WDhuNC9uYkd4TkhtSjlSU2c2MzQ4VnprQnE0M2thZW1ob2szQUtQWTFzN1RR?=
 =?utf-8?B?UWNoRkh3Qk5PMGtwSmRrUDMrV3A0UTJhRkpNZk5pOFExRDZMY3FnbkkxZmRx?=
 =?utf-8?B?dmNWdm92UjhYOUhEU1F3dzd3a0R2L0tSb0JodG01SmhFMUxpcUhlQXpTRWRh?=
 =?utf-8?B?YW1sQlp3dmp5NDQzUE83MUM0dWljS1BvQlRHVUFxRjcyeWF2S2dXeklEVnh6?=
 =?utf-8?B?Nm1Gdzd6ZWJJU0ViOVJWWGZkekNrMGFJdHpPcTNhOHJ5d2JGSjR2cHhGMTkz?=
 =?utf-8?B?bHZGZjZPWkI0WTNCWGxzaURIYjZQajhScGt3a3ZjdS9RaUNmdno0L0dJc2tV?=
 =?utf-8?B?WEMxckF6aFBGdnJQU1NGcTU2ajBFM2l5OFREcjdBM1FsaUZUeFRRUXc2QTVj?=
 =?utf-8?B?bFVoaUVPaEM1UmZqTVkrR2pBT1dibVQrRG5kekp1SE5NcUEwalpPdEJ0V2Qx?=
 =?utf-8?B?ZkNtcjhJK3JEdWRxRC9UNFNxQ0l2cWtZaDI0MGxUYVpUWHFHOE9QZzk1cUxQ?=
 =?utf-8?B?cy9lSUtiYnRJeGRVQkFvOVIwVUZPS1dWVkJzaWdwMWg0YlJLbVJkK0h3Vk9C?=
 =?utf-8?B?Y2lUa1dSQmJKbVV1TnBESDh5RWxqeXJ5Z01TVDhxY0dGS2hRN2tSUGxtRnNn?=
 =?utf-8?B?bUNJVEZ0UFZ2bDQ5Z21EQ29XZ0R1NGtmWmVTZjIraVhGRTBSL2dMd0Y1OVBB?=
 =?utf-8?B?dzk2aWZpWkZ3T2dTMlJtemJyNHZCQ2h3djlwSXdDaTRiMXVIRWdSN3JyN09t?=
 =?utf-8?B?MEJVd0tTeWh6dWN6aEdhMWh3bHhTL3dRdzVjeHJMMTl4b2dydTQ2eUdRUDE2?=
 =?utf-8?B?T2FBcS83ZDhlQXI1NFg2eHQyK1VKRjlhMTdPcGh0QWsxS1lHTUFkWUh0U3dT?=
 =?utf-8?B?alM4L3FWc2VKN1pFWE0raDdIeW5iK1FPWnRLcVVvMFN6UysxRHpYQT09?=
X-Exchange-RoutingPolicyChecked:
	x7+r8C+bsLMw3tVh9SrX+QeBpBr0zAcAMzqZcu0LeLdbX9AIF9Qmd0ajUeBIXIyhCD+k2xDrtcAmNdYX7ezVHAzIfRDm8lJDRnVyT1AGTF+JDu5Ptp2b9woOSC6R41lXIKYdUgVnQdwLBkzxsCeQhMJ1tvI/w9LXTLTiqrm+e1BRlNzzum6qKKGn/mOITn83IhrBrWmx9wFHr2ChrWHJOEBhxoOtMUK4o1wPapnCUtfUkJFQ64AO+b1FdcsFIZPFdCr3J2brgCWmB2zSqGh52Cx0vr7levpIBoNI6dQSWtAjw283XObH80wWNChx2a3GnhgnTf81E9f7IcDkXuwXEw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20342a79-f59d-41f3-6c2c-08df18c02908
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:42:51.2350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g//wWP1GfjywyMjjgUPFkk2tpxEmFGljBp1gbZzk3KO518hcAxXP8aLOsE8IsR9jjfvw0v296JgVBg7Ukg+k0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR03MB840817
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIyOSBTYWx0ZWRfX/rpqEFMxvdhU
 aaz0Jb5oBiWLZyCjWYe1/CSJI5tE8Jx94D5khkpalaetWgDfTO7AYH7AaDeFgnxW+Pofj25zr3m
 LRmVe5+xfkflLTtvou/GBRkKsISc7IDfq7U1Nq86fL1nIWcN85xIlhrKUPA/N3zBSn5zN1HMkv4
 u06CBTqK47d5qXAAqUibbiuELWBFu/V80f5qPcIdi++oOo7QDmeng4QKI0PWtbHgpM1VvI/Qjtc
 NTBDL2qDtoTGP74eB8pcB2iTBqjprFFNnRSAoB202EeIpi6WJ4YYaufMWIR/SXGR9pGN4q9b85k
 4oqEw8sn9t8PcZ1iYunwaz4S57purXMkvxlK85XxQ9g3kG233G+h295kpVUvgJnoSqcGvSNzfhb
 LQVTDpVt+TMEYRevmHkpWnWekDP80t13/xf6eapdiBoSNiWKX3g9Wyn9jcAAvjKj3SBiMsCBnMO
 PpJe/FW0KTJfUMBsdbA==
X-Proofpoint-GUID: 0n_UMDXNE-Qp0KjZeY4tmoECcD6Rc6R5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIyOSBTYWx0ZWRfX5CzzjHo7QMPN
 WAjEsaHA5MTdMuVHp3/Z+W9DQJEU+gSqkWY0XSFkkD4VkVqyZQGFeE5/b7VDWxPlEAuEPR6+xHe
 r9ON7gVCYze8zRPntRpnnthhZR+V5W/Z4sdHmak/OB8hBWMdSq/6
X-Proofpoint-ORIG-GUID: 0n_UMDXNE-Qp0KjZeY4tmoECcD6Rc6R5
X-Authority-Analysis: v=2.4 cv=Ae4kjHXG c=1 sm=1 tr=0 ts=6ab2a1fe cx=c_pps
 a=4sSI7CCHlwd7s46xCM5yTQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=NEAV23lmAAAA:8 a=Fv-PtERFAAAA:20 a=gAnH3GRIAAAA:8 a=7WE7n1x-56Toz66HqHoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220229

On Tue, Sep 22, 2026 at 05:07:34PM +0200, Joshua Crofts wrote:
> On Tue, 22 Sep 2026 16:03:26 +0100
> Nuno Sá <nuno.sa@analog.com> wrote:
> 
> > On Tue, Sep 22, 2026 at 04:51:24PM +0200, Joshua Crofts wrote:
> > > On Mon, 21 Sep 2026 10:28:24 +0100
> > > Nuno Sá <nuno.sa@analog.com> wrote:  
> > > > > I'd propose 2 documents:
> > > > > - entry profile - documenting the review cycle, patchwork, point people over to
> > > > >   Sashiko, relevant git tree etc.
> > > > > - code style - the TODO is fine for existing problems in the subsystem but doesn't
> > > > >   point out idioms we have in IIO, i.e. not using (the awful) kernel.h, preferring
> > > > >   devm_* functions, not failing on a mismatched ID to ensure fallback etc. This is
> > > > >   stuff that appears a lot in patches.    
> > > > 
> > > > Personally I do think we have some things (not just coding style)  that are very
> > > > specific to IIO. But maybe another docs file is not the question. Or at least one
> > > > for humans to read :)?! Have you evaluate just having an IIO entry for
> > > > sashiko? That way, hopefully the bot would take care about the subsystem
> > > > specifics and preferences.
> > > > 
> > > > I wanted to do this myself at some point but I'm always pulled for
> > > > something else so if this is feels like something you agree and would
> > > > like to get done, please go ahead :)
> > > > 
> > > > [1]: https://github.com/masoncl/review-prompts/tree/main/kernel/subsystem
> > > > 
> > > > My 2 cents!
> > > > - Nuno Sá  
> > > 
> > > There was a thread about adding Sashiko reviews to IIO but it died out :(
> > > I proposed adding an IIO-specific prompt. Any ideas on what it should contain?  
> > 
> > Not sure if I get the above. I already see sashiko doing reviews in IIO?
> > What am I missing?
> > 
> > What I mean is adding specialized IIO preferences/tecnical details to it. And for that
> > we need to add a new iio.md in [1] and a table entry in [2]. If I'm not
> > missing anything.
> > 
> > Sashiko is using the review prompt repo.
> > 
> 
> Yes, that is what I meant, adding iio.md (or something like that). I believe Sashiko
> pulls prompts from here [1] (?).

For hwmon yes. For iio we would need our own set of rules. AFAIK, sashiko will
use the entries in [2] (see my previous email) so that it will pull the
proper subsystem set of rules. Given we have none, it probably uses the
more generic technical patterns. Basically this why I suggested to have
an iio.md for the bot rather than other howto doc in tree.

- Nuno Sá

> 
> [1] https://github.com/sashiko-dev/sashiko/blob/main/third_party/prompts/kernel/subsystem/hwmon.md
> 
> -- 
> Kind regards,
> Joshua Crofts
