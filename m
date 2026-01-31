Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59523596F5;
	Sat, 31 Jan 2026 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880902; cv=fail; b=KGmOIeQK3vxNCKVvyuTb1NL5iq8gwWQDAAYAtU8UeIe2Z59mN+uR4O3PBTtHWOPJyAIvBe4cVSfuJXPJEKOZNaRehekqOugn8M99oRWe1a+Gwxjd9y1Iq+srXEbAwODcJ87+Ndm8gXqnEiRkSyX3f//RwTWU+Mk6f0Zz2ED448k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880902; c=relaxed/simple;
	bh=+c8MlJvicBC8dRZviX9KmYWoldvv7D46hEJcCTTWZo4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pszagm/vP8ditLooqfXudV6kdIM2uVOWLY4EgcFTkD5cUFiVM9y28uEF1dn6kqwhTEebK/JY+lngeo3rH3Nwj71nXPgBTy+jytQGeIixlGuH3JJtKtT2g+TtZeJzYw3n+73gYW1wVJ470Mueg69/g0NJdUU2m2vNmFekbUbiDCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xyyo4T3K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oApef/mq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xyyo4T3K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oApef/mq"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60VFrB2R993336;
	Sat, 31 Jan 2026 17:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kuHlMT3gB7LfCjUUaS4GRgGHAMm+Dbzcf9iT4h3Zhdo=; b=
	Xyyo4T3K1XHOrlBg0/Cp3JX0I8vX+ot5NNbE0r1U0qImpcKrc+P7fQ1Fwn5wsO/B
	xo1rV+WJplkUoQGpqDZX3zXiFuV8CKGLgV5MFvEHu7wMukSunqLlepFrlDhVntyV
	eAJWj3xrHFK24gEL58YFYVbdrK/youu3zmNGpIXRcaR/PTHNWjI3IuRwKOtcQ2i6
	GSGWFipDRAzdpTi7ff3FCyRA0pOYWvueWw+1jWvTcl9J7KhSnkXigOTJdeo5Yveg
	h7h6+NlxB3P9uN84o6jKZA6lGFF3Qbyke61H1jd/Wg6Pi28LpBlg+bN96nNYusSy
	tP8+/yeBfr6xIlR42XG0Ag==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1axe09a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 Jan 2026 17:34:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60VDBAtP001253;
	Sat, 31 Jan 2026 17:34:54 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c1866xaa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 Jan 2026 17:34:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DH3UlyhtqHxqWwsOhb1iaphYOYoZlQc5Ws2Xul0CUrjTQgmcfgSD1MbfYtEz7eQF0h+9D7YwPa0dCTT0u7BiuqiK0JAWaqi9+/HX5P1OY7oMIFoT/2fzExQi4Jq+bsWkNVEol/7qevv7VFd/gchHD6tcHDom15TpRpOmcZui44Z1hWGMUUtMq7x2IKQbfJY9miU3uejRiugoI8dW9CkbyVO3KMu3lOKPLv2zA8SgTqJsPBeBdfEyp3rIlIIjfFqMh3O8NkqFF+zZwO0UKa0NAlUMFphSJ7LYyde386uFsAnKGSteO3he62k1Ljjxwv8okrbt62Glkq30ULivXOd5uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuHlMT3gB7LfCjUUaS4GRgGHAMm+Dbzcf9iT4h3Zhdo=;
 b=qPNpZSjuAWsPBkFalR7clNgfcNLi1M3Uk3ARYrnJVgKxYdJpUd7zknCKve1h4q6CNfmTsaRNnMgxXNSRpSyXdW/Sq/z4hiAesWuPeeMLd5kT8E+0lk8m8t19PN9PvVOeEa/1wM1gU4HYRslXVe+B8hXPPN+Ql+xKcMchAjeBS/nfZupo1bRUVO9NS53ML3Fy9FSMClN8I+8fuGzfXSSoqaliiGQLsCbZYNHteZFFDY1p3RD5hf/57W5a45N1Raz02LeWQarddbym9sVdxlQP695n7KRuZtEMaLBh1QH01WcreMhWHiUx+q6MKc7vmm3ekJ/lqCiCXb+6BYvl1IxmGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuHlMT3gB7LfCjUUaS4GRgGHAMm+Dbzcf9iT4h3Zhdo=;
 b=oApef/mq+d2tK731eAmVK8m8a1Lfp4No8RHfXkQTpiZrVX4f/vhp7xEDRa56EhXiTafvCJ6WIVys632rcsXaeRuavNuvAvrVt2xtG3iF8vJbO1PmA1TaUgouvljeb23jY/feLOsfRgp+U7JhIcNfdxI4C0qMzYozN6xBjxGXVkc=
Received: from CH5PR10MB997695.namprd10.prod.outlook.com
 (2603:10b6:610:2ee::6) by DS4PPFD91C619EF.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d4e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 31 Jan
 2026 17:34:52 +0000
Received: from CH5PR10MB997695.namprd10.prod.outlook.com
 ([fe80::6458:28b8:6509:8b83]) by CH5PR10MB997695.namprd10.prod.outlook.com
 ([fe80::6458:28b8:6509:8b83%3]) with mapi id 15.20.9564.014; Sat, 31 Jan 2026
 17:34:52 +0000
Message-ID: <dd790183-8c26-405d-9583-28eb34d3d73a@oracle.com>
Date: Sat, 31 Jan 2026 23:04:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 2/4] iio: sca3000: switch IRQ handling to devm
 helpers
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260130214323.236389-1-harshit.m.mogalapalli@oracle.com>
 <20260130214323.236389-3-harshit.m.mogalapalli@oracle.com>
 <20260131163011.070a80ee@jic23-huawei>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260131163011.070a80ee@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0066.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::30) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH5PR10MB997695:EE_|DS4PPFD91C619EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 31171999-f13a-4f6b-f3d1-08de60ef04cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHBYckRicXI5QnlrOXY5UnV1YnRPd0x1WEdkaURnc0p4alhrdzh1dmNtUnlW?=
 =?utf-8?B?ekcrVEVaWmozZmVtdUhwWldCa2VrYk56RXZqS2lhcEJZSVhrVTF2U2d3Z1Rp?=
 =?utf-8?B?ZEw4Q25iZUlxY2w2YkpxandpODh6YStSajMrZnhmSEYwZ285UW9aRCthWXpW?=
 =?utf-8?B?ZWhPTDlubFhkSk81RUF0ZFVsMFBSN2xzblJjaDdvY3I2Sk80NUpDVFJrT2ow?=
 =?utf-8?B?aFZDczk5S2JkNml5T2JucUhpOHdzT3lYSUJnbHFhb2RsS25scFZsMG5mekZk?=
 =?utf-8?B?QThnK2tRbTIyZEJ5bnBYS0JseG9ybkhYZEhCZUxFZEE0ZGVxeUdjMDF6OWZH?=
 =?utf-8?B?TDBqWUNvU2hDaEs3WDVMYU1LeWE3QnM4U0F1RVFYY3BzM1pKd05uQmpmQUJF?=
 =?utf-8?B?QkEydXZRQm9uUWx4aFBybVVYMkxQNTdMS2dFbHdvZWRtbGNmZk1ScDgzanBZ?=
 =?utf-8?B?MXN3alludDE1THR5RDRTVllxaHFrL3FQakp3dURTR21Qekw1SEpCZ25SZHlP?=
 =?utf-8?B?eWdqSlNQcWRCdmZxMFg3UjF4WmxLYlpqOEtlQjBrWVNyT2pmSHIzQVczbnhM?=
 =?utf-8?B?Vm9GbWJlNTlrekE3QlQ0c1R4cEVDaEJnd3Zva2VuL3dSbzlQem5xZGxDZFdt?=
 =?utf-8?B?MzY4WkVGbzM5anVlcDhSbE1hSkd3N01RbWZ1bFFTWklvQWdPbS9aNTNMNFl1?=
 =?utf-8?B?U1RHUWhrOTNVWEFuWmc1akgvZ0lhZmdSUU1yQk9GbFM1bHZCbWliSU9NVmh3?=
 =?utf-8?B?eHdxaVJlc1Y2WHR6OGRtOWFuRERsd0hUcVNucnJGcTNSY0xNWG4yOG1sSGI0?=
 =?utf-8?B?WUpYcTAyVGwyYndhQmpFa3RIWHUzb2F3QndtZ3J3dURKMVdPcUhSWlEyK1JF?=
 =?utf-8?B?bGVTZkswcmNQWUMrb0pnOHIrdm9vQmRGdzR3a0NteitIZmxJcVBianZMdFBn?=
 =?utf-8?B?MmJxeEdZMEcwNVNRUVh5aGRXZ0NYQ0NlS1N5K0VkQzJOaUZ2bDZmL1lQdjFn?=
 =?utf-8?B?UGprcFZjcy9sTTU3Kyt0QXFLTlZJZllvOG9uL2kybCtBUEd6c1FpNFBia01l?=
 =?utf-8?B?TjNjVjFtT1MzUFhxODVZZ2JMaGsrR1J1N3p2bnQ5bnY0dmVrQ0tiT3dZSWJE?=
 =?utf-8?B?ZGtOcWdFUTlXVDNsQlkxUHFKNExGTDJwT3E5aGVsMjdCY280enY3ZUNPTjFq?=
 =?utf-8?B?SFpBbWFRQ29PNHJiOWtlVzcxM0ZGaW1WcjEvNTVkc0VMeW93S2RjY1JTcTdF?=
 =?utf-8?B?dXVWRVB1cGtXbTYxOU5XWUwxaE9lYmRJMUp0YzRPOEFHMGdscUNIYlVyKzBz?=
 =?utf-8?B?VUVjMi9QNHZRUlFqYnlaQW9Nc2xOUUU0cWM5VW9OTDFocHp5cUVWUzFFbk4z?=
 =?utf-8?B?dmsvaFA5Mzc1eFh6U3ZPUXdDeURhVW1jSk0xS3c4blNwb3B2eE0xR2hhczFp?=
 =?utf-8?B?a1RleTJscTR3VFR1QlExcEh1R09WZmVYNTgzc3Jnd3NWdnVwa0YvMnhsM3cy?=
 =?utf-8?B?WEYwWmwwTmttV3M0aCt0MXZFQ01PSERMOTk3YkYvU2ltSUhhMFpCYXE5bzg1?=
 =?utf-8?B?NjEvVmNyZUFoOEdXMFFlNVVudmhUWE1Lc09PQ2UzOVF6dUJYWXArcWpKSXpN?=
 =?utf-8?B?cTVaOTlFeWtPcjFuZFcxMjRqYnFycHhscnpGQ2g0aFkvRGJaUUpmaVJHT1lm?=
 =?utf-8?B?dk1Wa0NiS2cyQ3JTRkNsYm9JQ044VmhPQ2FFUFNvSkFVck9SNldmclhZVVd5?=
 =?utf-8?B?RFZyclpPSEVlZ1JMczVEaTI4TGdnZEkvc0dmemRVS1JUai8vUnByaEovMmpX?=
 =?utf-8?B?OXRJYjU5M2NJbkVPbk9lZGsxL1JtRlhWdlJQMG8zU1BNWE01WDl0UWs3Nnpy?=
 =?utf-8?B?OFpoVU00WG5FaHFiZTlaYzR3cTdSK2RVRzF6eHdTcHNaZ1ZRWjR6LzR5YVFS?=
 =?utf-8?B?MlhyaDFlZlR0Smt5WDl1WWZseVFpNHFxWnZZaHdKdXhBWVVKNXgzd3Y1Nkhv?=
 =?utf-8?B?cjdRSGU4NzZHdm5obytGeGNKRmdsdFlNb3lJZmtEZUk1SGM3cXkzaFllQ2g4?=
 =?utf-8?B?ekdUNVcxNWxMWHQ5WVVoL0FXVit1aS80NzBua2FXcHUvRDUxTTVLYm1iaWRr?=
 =?utf-8?Q?4HZk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH5PR10MB997695.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmY4Ynp5VEROaGNnU1Y2bC81NStmYWE3TjNoRFVaYit2NGMxU1l6QmxiZjJr?=
 =?utf-8?B?UVVTRUhidnd2WUN4dzR5VWQvRHFjMUk0NVZHSHRwOGxwUHlXaEx3TE9mamtI?=
 =?utf-8?B?a0VTNjdBTCs4TlMweHo1Zy8rVVhIblVORUUvcUpyZGU0R2dzYzdkTnpyOWRV?=
 =?utf-8?B?ZzhqMTE4UXhtRHVFOTYvNkRYMEZaemZmOGJ4ZDNIOGVIRXQwQ3d3dzFDdDFV?=
 =?utf-8?B?UmtkYy9XdHNlUnNCLzBVZyt4dVByRzlERUxqL09HdG0zMkJlTVJFbXJjRjhH?=
 =?utf-8?B?cnhDOEJwY2Nyekc3NUZTbitlQitiRlNsWks5aXVEWFMzNStQd0xraWZPYVA4?=
 =?utf-8?B?amZUQ0VYUnNFa2VCL0FlZFk2bzlkTW5QSjloYU1EV1V6RDQ3eDBxRmdEWUFv?=
 =?utf-8?B?aDZQeGZZSytnVXU4Y2lPbUR5NFh2VUlYaGs1MUZ3VmJMN0hyNmJ6NFpIb1VM?=
 =?utf-8?B?TlJOcmIyWFpxaGw4Uzgvc2ZyOGlGQ3VVRVRmSVYxa3BtdUs0eWpLUmhlQ1JN?=
 =?utf-8?B?VEo2anBtNmJDelFIWHdmRFAxcTJiTHEzYThRZnRoZVJQRTFhQkZ1aGYvN3pB?=
 =?utf-8?B?QlNsNGhySVIvVldNY1ZjMXlGWWF1aytSRlZjVUNoMVJFN0Rhd1lKeEF5ZkNT?=
 =?utf-8?B?Tjg4cXZmQm9MTHVkUDl5Q0k1SUo4L3hVTkRrdXlqM2c0TTZaZk9SdEoweE1W?=
 =?utf-8?B?Y1Iwa1BFaUhJWWlvdXRBV0ZjdzZUVXovNWhncWZpSU9NaGc3dVMwcGYyVW4y?=
 =?utf-8?B?OFBEaUxMQVJ6OUpjUUkyenhpazM1M255di83YUx5akxHS3VWR0phNldhTlpJ?=
 =?utf-8?B?MmxKdmVEc3Rrbk1nbXEyRTBNZkoxMlhPbHpSUE42OWY5cHRFcjZsU2lOVjVa?=
 =?utf-8?B?QUU0eTZlZ0R0TVpRWVhFTzJPVmNKZ1lhS1NZN2x4Z3NBekZkL0ZJZXJtdFF1?=
 =?utf-8?B?ZWcvSnQ2QVdpWWZIaEVxV0VGcFBvQWQybXFQZ0hBZS92cTVJdERKR1pkeHVk?=
 =?utf-8?B?V2ErWWYrM3JJMTlscGg2RkgwVjZTZUZjaDBrTXMyZ1VpekIwdE0wR3puQVdp?=
 =?utf-8?B?cXRPbHNwdTljWklmV1pyanA5Q2RmazVLVGorMjk2ZEMvajdpWGpUaFlZUXBL?=
 =?utf-8?B?ZTF2Q2l6U1pucWNhSDhsemxIVlhtZE4ra2IrQStsS3dsQWRzTUgyQ1R6LzFp?=
 =?utf-8?B?N3ZLbzU4UGc3RStiNXRSekxER2lydmdsbmtoLzJkOSt3YmtoOWJDaWVQdVlO?=
 =?utf-8?B?M0dWckY4QVN6aS9nUlZjeXZHanU5SWVVb1FXSjRkMS9rTHNNcmtWeW53M3Bp?=
 =?utf-8?B?N3ZCUmpkR3RZNHBuQlI2SzlBV1dMR1cyZ1RtRnpubzI2cEowRS9qK3doWlpp?=
 =?utf-8?B?T0RqU1RGcHE0K3p2V2VqdWZqWThwbjRYSzFhSWtKQm9GZDkyNnhUamNvbXFj?=
 =?utf-8?B?SnpSRjZHdmNDZkVYWG9jazQ5dmxNcjI0WUFRQ3dJcDRVUXd2VnpHbTN1SWpw?=
 =?utf-8?B?UHdMaWZTZjNaUlBXMGpEMkswaWhhWXBQYXc4RFNWYkI2eFJXbW9iN3JyVjZn?=
 =?utf-8?B?VHMzSElpUWlFakJCNEFmWEo0dzNTM0drYm55Z0xST0FFV1ZtUWNGTVpIYjl3?=
 =?utf-8?B?OENqMHlVT2tWcVdRMWJKejNGNWtmNXZiZlpQMmhBYjJQZUtKd1JxanRMZDdp?=
 =?utf-8?B?QWt5NERHQmttQWFhY0prMktaY3EyRGY1VC9ubFIwWnNONGlFdmNmbnVLbEEw?=
 =?utf-8?B?Nm9Ndm9MZ05pdW1UQThuRWJNTmZoVUFUdFI1d1pISkIvOVNyaXR2ZEF0NlMx?=
 =?utf-8?B?RGV0ZnVZTGkycEZ0TmU0SXRkd1VQKzRlSWI5S2JjSkt3QVQwNUFheE95cm96?=
 =?utf-8?B?VFpRd1d2RFMrc0toL0wwa29CSDltL3Z6Mkl2aDh2YXhlV1h2NUIxUm9pMnRi?=
 =?utf-8?B?OWhoaTIzdXZmcjQ0TmQzT2ZjeVJuRjMrc2tHM284VG5NWFR6MGVaWHRYL0dO?=
 =?utf-8?B?TU4rWXI5clhBakZoTCtGR05Odm9yM0xIMlV1c0srZHN6UXpZdGViR0hXd1lw?=
 =?utf-8?B?UDJsaTFycXMyVHZXSU5qL1ZTSGNlNWY5L2kzT2RFMGhRWUtuSHdmQVF3NjAy?=
 =?utf-8?B?a3FyZTJna1N4dFRUOTFnYzBkMU5EWi8yVnlyZ2FWZElsdTBoc2IzYk45NTFX?=
 =?utf-8?B?M1RyVjREQlVIYTlieFVnQXFDb1RkWDFpN3F3bWI3MkUrQXJrWVQrRmprVWFI?=
 =?utf-8?B?Zy9OL3lwb1phNHlCUDI3ZEhjYW1FbUp0NDZ0UEFYQ1J0eW1zL2NmZlh2RnFK?=
 =?utf-8?B?ak94cDZRblFiQitZd2NxZFBGNlJFeUE1UDJWY0FHQUN5bHNPV2tpa2Z0M2J0?=
 =?utf-8?Q?XkeTX4dCFWYvkJnu5qDjJwkBGMi1QMxMK0LU2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XNYTCwEEV7+aND++x24vQCbCtHHnvnbmBr0JxS6ROjdML0nQb2XADvkSaUiG5vg4H8nw3WD/qMXGtnF1ip7afDX7QN/ic6ubBtCxCgUcaCPFNdPONGB/v3hDqk9it8z1kkjI685exUtygSRKEkLzIscXqYGqHCwYZspI5d/suWDNbLmTxN1XrOkeq1LeoTqoe85XXZa+O8InMtD78cy2rwAs6jI6FboYcNjPMt9ze5CloIoXEL8XmSLWN/w58MC2QpMqLAqTZtgCa9i+Fk2pNDfZ35OduysJa5+RXGMOLZh2Vf/O7dWaYhvAYFjzrPzX1R76VQVo3IWxKhj/yKVtQhjIa/LB0qNRSwKdBZEWdXj/kzvoAaRUiJJfFEIXak6Zr0UQKVCpDgzM/lXtno93nC5DbjyrIZ53zfKOQsqr9s8r5RFcMx8q6dy3TfRY4qLFFqO2vgKwAnGWQKqOidSLZUsxO26Cf+rVf3fBDR7ShMaYLGbcUfDpv58Svmbtd6Mj6mh263l7w+8RXS5cvYaQIfZ2/lEKE0lL8Xb6od1zYlNhbSvZ5BYSAiLWTGPZiIWafWadj0dUzT6f+J61mAQPFfM5+FssCx1i14x7NY6JAuE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31171999-f13a-4f6b-f3d1-08de60ef04cf
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 17:34:52.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqrpVoq46eTo6X13C4mrMEo9eiBmLvHgsgLchEEyz3OR9oaODtfG+q3WngtMpNDnivg5wn11QaVmnr/0i/ZrCy3AIR0va1jnQVxLs1vLh777yE9ZYTCbLROkk983/Ciz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFD91C619EF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601310148
X-Proofpoint-ORIG-GUID: Y7MykSvhRj_VeK2_ejALEKP4cEr95dbl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDE0NyBTYWx0ZWRfX5y6gpgpZGM9h
 QfX9l9DyY14+7HwEhEM0GQ7/olUCcqQ8ZsnuW+HO4ZiBi3UXveCjFVKk5OITJz6rW6LHjmQgPnI
 box6/nAee21IC9P54P0TG1XWsg6Puwuud/y+2nMfXygbypUGPIW0OTGbrkzMgcDdKKDWQtdTmEo
 KDWi35FR5NjnE6najEx30nUOAl8M95fZMY2hL+y2DqPRv2Bcj0uCgEOWmIRGlBVGxHRInbS/Y7v
 B5FeT7+Q1+dPatqK7HdiAa7t9RFI04bOIO/cc3/gweBMaCW/T8PI9rzMj9Wm7uFtJvXjXTywypo
 W+0J/r0YxgoRrjqTCbWDgY75xC5BwaMnL0b/CZHxBj6toD+zoXy6HcRdUoJnw/tWW8+MC71Ckxy
 fVtuv2YXTqEAomQ2173d6KJ4zo+xoy2OFGFvA2aLjCk78eIR5IPiotMNt+azCrkn/90rUndw1gL
 H0ycC8F9b+6p760kMBg==
X-Authority-Analysis: v=2.4 cv=F5hat6hN c=1 sm=1 tr=0 ts=697e3d3f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l2Qcq5Sju-mDbGwX53oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Y7MykSvhRj_VeK2_ejALEKP4cEr95dbl

Hi Jonathan,


On 31/01/26 22:00, Jonathan Cameron wrote:
>>   
>>   	if (spi->irq) {
>> -		ret = request_threaded_irq(spi->irq,
>> -					   NULL,
>> +		ret = devm_request_threaded_irq(dev, spi->irq, NULL,
>>   					   &sca3000_event_handler,
> Update the indent to keep these after the (
> That is:
> 		ret = devm_request_threaded_irq(dev, spi->irq, NULL,
>   						&sca3000_event_handler,
> 						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> 						"sca3000",
> etc
> 

Oh, right, I should have indented it properly, sorry about that. I 
thought checkpatch was catching these. Will fix this in a next version. 
Thanks for spotting this.

Regards,
Harshit

