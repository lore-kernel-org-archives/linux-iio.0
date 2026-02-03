Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E28314A95;
	Tue,  3 Feb 2026 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114565; cv=fail; b=oeHLDIRMM4F1I2UtFlRL1rJ/zfYGTW7khOH5FT8fn9s9fEOS+P0TRjxBWTBoqgorLqS95kyq3C61r3xzAPgh8h22UVcYTY36DqVxOfoWf5lOBg/6nTF6n9uFVeg0JfxRvsHT6UQ+7WqHteqnzFmcGFWTuhLNatOIQDniqgsx/f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114565; c=relaxed/simple;
	bh=+fAPKOY8ZeDN5MxmGsGUZbd94SfomxCvFEKtSt1cYrs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QHiWUhIUzYzD4F9Xc0TTKLwsopcCXXiCKIdeyZHrVas7rFcRgU0y0LQi4TqL4CPPOD0o94KreSRW3cbrJ/UMJokVHt/ZtoIfCRxdIahQhxIA+bvL7VoCB+WHrqLcCmkHsNvkdb+ymNzLAayr7I52+ZHxWZ+HKgEog/G5Dy5eH0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I/ImtOy+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zs7fv4Ml; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I/ImtOy+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zs7fv4Ml"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138vMYr3335524;
	Tue, 3 Feb 2026 10:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DEY8+wvMlgpI+9L2zFnW+c0MIg13Gx6MHHYghfTC+ps=; b=
	I/ImtOy+b5eFmbClMK75/lNiOhJidCLkVQeE/1mqo75eVimIgT9fxFJjFWFvjDZf
	F5IYL8gqngsHI/MJOpSfGDJdCdq1v3/P3TkXY505+85sgm07YmTtukbsntmQXPMs
	PnlemI6b9ajAGVa1mXELNfcz21CrRXXkcydLv/IuWwe4JAGXs/2H7NVnJMZ66Z6h
	UZ0bBU+6hgBEBlVonMcmZak+L+Ncr1MpTlZbtCmFvIA/uDy/5MnhXbETQd7ngVA8
	CSfF3jArATI7Ehpp5r5MaaTPtuFYCsyJUP2R66Uqf4H0X2TLXaiHVBOMSWOkVlSE
	lw31dxMb6SbdNN2MTlpO9A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1arkuu9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 10:29:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 613AOfkY001196;
	Tue, 3 Feb 2026 10:29:17 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c1869nfdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 10:29:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHHFns9fBcUkOxYO1jgALO6dqaH4QRh0Z+BIMuGmT6iKYq44AnEcHfz7uyc79rYoOz73370ji2MRyDhfLx04pT6EKAYYF+PAQBpP6ONXmLYJt/0rquE3bkorhN2e2lidaD00bEUbwIbTInr7XocninY/n5FrFtB7MAOjdlZzutfq02KVBaiW93JAAbp5N+86VLippWzgJbi43MisoEMbIoK3D4duGk9i6phvBi+Q6hEs3SE3ZO45QLbFbPCjmz2KjV9hcK6rUrKWd55JDHmvpeVrzVt5Lm6aB4w7XP7zaaoaD2aDPPF5gICOEHxm7e2ku+32et3DOO/6q/q+cui7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEY8+wvMlgpI+9L2zFnW+c0MIg13Gx6MHHYghfTC+ps=;
 b=KNP4ZHxcuCpo0cLbbEUFskyfS9JOBN4ZEGGyshFRdsJB2WwDDH5iDdOF5CSvslHU23Mn4W8GFCQcjbXPq6iDF+/7D/x9lkxWYgM2uHTk+7r8TkKyPCQDpsSF3tHsCOwmMzWDvJRapsTBURxJxtX3MFwhSdog/i0GWUoc+zGrapnqJbNmm5nsvP35PIPdnbcN1mTfsF/maFwqEkyntJoSXMC9oHHM6wwT8w46+wbXtsBHXXCstZfW/Q5SsMdtxECqMWcfZ+s+oDpTK7ig+bt7JIUa97uj3pRGnpBroZeAg5C2uKZvfKmePv/aT2vJjJWCVZZCppbZCtF/X9c6bnZJ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEY8+wvMlgpI+9L2zFnW+c0MIg13Gx6MHHYghfTC+ps=;
 b=Zs7fv4MlFGvdGHK1h4jN8k7ZyLpUpDRtQS0kLyIkTi7LR86IunvNTHFl8jHE4CquIrd38SrL23oVtfI2THSx4m9nKbNLMdc4GEjtqF5vqYFh5lrX1VlNULIRDl5kG14CIunxuV7hWKp+kdKbbnECC+cq5Zywshw0DXSjuw/Y9/k=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by MN6PR10MB8191.namprd10.prod.outlook.com (2603:10b6:208:4f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:29:13 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 10:29:13 +0000
Message-ID: <69e36be9-9145-413b-9d71-61211eef0e99@oracle.com>
Date: Tue, 3 Feb 2026 15:59:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 next 0/5] IIO: sca3000: devm resource management
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com
References: <20260202194033.627967-1-harshit.m.mogalapalli@oracle.com>
 <aYHEXc2QjMAus5Bt@smile.fi.intel.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <aYHEXc2QjMAus5Bt@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::9) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|MN6PR10MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 787fd8f0-f596-4921-1298-08de630f130b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3FQUXQ4UGUySHo1aUNUeUxQdWFQTlZ3Z3hoMnBJaDRDWmFkV202UFA1SFZr?=
 =?utf-8?B?MDcyeXUwdXRDZ09ESnBJUk9VaTNuZHlhakZqRFFZUnFVemtMSmNTZXd1Y1cr?=
 =?utf-8?B?Q1JFaGcxS1FFM1pjTGkrdGxYbkRHQVhwdHRNVHZ1SnhzVU1nVXliS2RtOWhh?=
 =?utf-8?B?VzhSUnVuUGVHVE50MU1mNlE4OU9vUGVlRGVTZEphVXAxVjlZQVR1aklqU3dH?=
 =?utf-8?B?N1V5Y0RUNG5vNGVhcnI2cHVKK2toYUlTUGtYZ0g2VXhkK05JMVIvcFpRRUpn?=
 =?utf-8?B?dFZTMWNobzRScXRHaXM2SWlkbEg1aFp5dHpHK2VROHMzVFB4VXlrcFRzcEtQ?=
 =?utf-8?B?MjlZRlJMT3Bta0liWENuTGV5dFh3eHpYZ05aRGh1dmJnOGFXQUw5NnZXTWYv?=
 =?utf-8?B?VlZiTGluenFnbmcvQ2U4TkJvYXVMRkFLOTBWNm5SSVFING5hamMzWURQRVpr?=
 =?utf-8?B?WHZjYVFzSUp4cHNHM0wxN0Mrc3N1R01kcE5Dc3hwMDRKQ0R2UGdHbXV1REZS?=
 =?utf-8?B?dWt5MGpKandEWEdlOVNDczN6WnEya0lZRU94bWhydldiUENhcHFIOVBaSER3?=
 =?utf-8?B?SVRLU2NrcWJmdU8zRjBmK0dHdWo4OUo1QTF5MFpCTGVMMjVrUkRSdlBmTVRt?=
 =?utf-8?B?SExSME9qQTZqVTBJbG5oM05wSW5xd0tkRlRMQmJLSFM5TDJLZGhTQVdCckhl?=
 =?utf-8?B?L3RZUUZJWHRZSklzeVlsMEJWc2RjakpoYk5waDNlMlAyMml2ZUREL1IydjR2?=
 =?utf-8?B?ODluQTM2WlMrSmI5RXJybFdtN205TVJMb3E5YjJUdGRndHV3bzdzWVJHSFRj?=
 =?utf-8?B?bC9ZaUJRZ3E3SVJ4WmlXc2JnQ29MaEczQlpMcEpnVXhxalA3NlR1bDBsSEVl?=
 =?utf-8?B?MUh6cDlpN3A2VW9oWUxjUEF1cXdHQTVERzYrY3F2b0ZaNFZYMk9WR3FycWZ3?=
 =?utf-8?B?UnZmYzdvd2NqYnlLM2k1cy91N2g1Q2l0MXhFT0lmSkJiL05oaFFFcFc5WFQx?=
 =?utf-8?B?VkgrSnpadEZ3b2NmR0JkS2o5L3Y4UldlZnlja01yQk8xeWp2WFlubzhtbzhE?=
 =?utf-8?B?bjQzTElVM2kwbHMwWVE0blZQRWw1L09TWDJteFd2VTV3STc5aE9od2t3M1RQ?=
 =?utf-8?B?UGR6SEg5aEVKVEdheHBtN2liNmcrYXBJT0hNSGlWS0hhbXZmY0tZVzIxZ1Jl?=
 =?utf-8?B?OU9LWFZZN0gvcDdLeXhjZWhqdHFnMDIwVGlucTlyalNSZE8wM0lTb29JRXQ2?=
 =?utf-8?B?UUkwQm5DMUxFRGY2RVpPeU0vZk41UWZyb3ZyT0VIUHZPampVem1UaERNaWN2?=
 =?utf-8?B?bWkrMncwRmRPWXZxRlRrQXVEMm5oV0grVVNmVTlLOEYvaEYrV0NNQ3Uvc1Mz?=
 =?utf-8?B?S3ZtRFltZzF0M1JLcm9jZ0FiOTRNdVpFenI0cGNjV0lkVVVSTWswbVdvLzJl?=
 =?utf-8?B?WkZIVkkyaU9iMTBWQzJyT0NaTEtUaXVaOXRpL1R4WGd0MCthSGVtYUowYWpn?=
 =?utf-8?B?M3ArSlRzeW4zNXFseGhPUTk2QWpDK3pIK2RESGhUWUFGTXlYTng1MmNVclZw?=
 =?utf-8?B?czMydktXTVpjNWR3VzZScDVmdldZMFdCL1lnZTVXYnpQY2hwUU0rYTRkYU5a?=
 =?utf-8?B?SGwxMU1PUEcrMUhiREZRdGdFVEVnZHRhQXpUWUIrY1Q4WjUweGc2Y0R1NFZl?=
 =?utf-8?B?eWNLMDl6Qkg4QnIyUHpiREYwTWdTUDBFTDVpNGpORzBvZEI1MW9ZeEZhZXVz?=
 =?utf-8?B?d1BoZ01LTkc4aDNBUjd1NXlWTlQ0TVIrY29DMXRPVFg3M1hBc2l3dXVYTEpT?=
 =?utf-8?B?Y0ZydXo1aTFKSWJYSStqc1l4cnA5Nkx5ZnVOZVY5Sm5MUEtpdzNLU3FTdWdW?=
 =?utf-8?B?Y3pRQlVLY1V4VlRwRUZaa0t3RWFpNHZWcTRrd1JMcTZodHduZ2RoMGViNTAy?=
 =?utf-8?B?Y04xZ0d5cXhUUXFpcmRpY3YybjZ3MUdFbVp1RVpMREMzR0hLYWNYL1AycXZN?=
 =?utf-8?B?Nm5FZUtQZFY1TUQ4NXlFSFA4YjhUYnVnZ1RhdmFtcGVmWTZPcG5GamYzVVNl?=
 =?utf-8?B?K2UyMmZLNy9hU0gwUHpGM0NxSExVRC92WWVzRktZZHV6eGk1YjJRczV1b3FK?=
 =?utf-8?Q?cWCU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWt6RXlHdTYydXlXZkFIWXVKY0VaSHJvNlJ6NXltNFFub25oQmY3UWdBdmp6?=
 =?utf-8?B?cE4rRDJLYnZXSTZ5NXhBdDZoc0YxSFBicmJkUTFQWVBYaXVqQ1RJOVBheCs4?=
 =?utf-8?B?N095Zmh2dENIY2VTa0dEbXI1QWE2Q0llVSt3T01BeGZGRkRsZFloTndublY0?=
 =?utf-8?B?SkpnTTJmelNRaFhGcTBxRmQraWhGSDE2WDFsZUNXVUhXRGRaYmdEbE54Z2ho?=
 =?utf-8?B?QzNqcEFpd0VUMFVrSWozeXZVNVlGSzAweElPSHgyck03dkx5T2pYMEc5enNP?=
 =?utf-8?B?RVlkeTdLUnFVdSs2Sjh3dUNZeTd0c2Y3SGRSUWZZWmRJbDJtTUJFOEUrTDdX?=
 =?utf-8?B?NHI1TFhFNmttdDgyVVJ0OHNGbjkwRGkxcEh4eFo5UnhldGdIbGZCazEybHRP?=
 =?utf-8?B?NzdoVUx3MnJENWpWajRGa0tKc014TWdjT0I4TUhQR0I0dFF6eE81VWNiV2dk?=
 =?utf-8?B?Sm82a2pnWU4xaTJmcnRWMDMxY2I4YU9lUmxPRUdkYXYzL2NMckVHWGRXMlU4?=
 =?utf-8?B?TVBIMTh0dGdhS0lvaHlWSmcwTjc1S1dxRllMWG1lLy9WSFpMWEZTaTY0L0Na?=
 =?utf-8?B?RkU3dzduYVRTSThwY1pQOWRCa0ZOWmJadmRQZUVwOFJWeU5IelYyMzJJUTgr?=
 =?utf-8?B?U0pWRzZxemRmWUprQlJ1SmI1c0o2ZmVVUkdITWQrMmRxekZDbm1SNFN1c2VS?=
 =?utf-8?B?Z2d2YXRCaFVLaGVkR041SFRJTHdHckZ4ZkdiRzlxWWNOam0vbE52Zmp3QjI3?=
 =?utf-8?B?eFB1RTZKWC9qV1VSbVd1MjFMWUl3dEpacEdtS0I1ck5wSE8xQTdNY3pWOEow?=
 =?utf-8?B?ZkQ2MHFOM0ZnMHZVNjYzeStIYWN4MjR4TVhya0FzcFNCMUFDYVhyRDZJNWNh?=
 =?utf-8?B?WlFxdWZzYW9tMDlOam5CbXg4dlUvY1hUM3B3ZXlXTlJNNEZnZnMzK0wxdjZ3?=
 =?utf-8?B?eFg5SHFOYzkwZUNGWGFoQ2dmNHg2R2Q2NW1PTzlPdXlJelZaM2RaRnFDNUdB?=
 =?utf-8?B?MkhVWmU3dFptbGsxVm5WYkE5emJ4blJGV3QyYjdFSnN6aHZyNTNrY0xXcVRZ?=
 =?utf-8?B?MzNzaUphMTlWMkpqQmFLbURSd2xMUlNuTWZFd1BDZi9CdEcxZ3BIT2RRTVdJ?=
 =?utf-8?B?YzZWdUsxd1ExK2packdoM01KZGJiZkF3T29yUCt1NlNGek9oVW1xKzNIazlV?=
 =?utf-8?B?VXB3SHgvNmdjTzFXdG9TQWFFNXgyeVVhZTROQU94cjZTVk41cXhhU1RGSW1i?=
 =?utf-8?B?L1hGSHdNM2dkQ3NnYXl6cjhjdWxUSmtRQmJWV3RRSEVIcHdJNTc4cmFwRW92?=
 =?utf-8?B?dFptZjdzVk14R3F6WmZ4ZUhkZm02Mk5yczZmOXo1bE5UZHhIUzhESTZ6ZC9q?=
 =?utf-8?B?eXJMZ09USHUrajF4aEtENkZJOHM0cWE5bEM3VE45Y0FGK3pIZ2srTTZIdWNB?=
 =?utf-8?B?b3hMVU5DY24yR0lHMkFiK2RvYnpoNWtWeFhOQUtaNzEwd1JHOGJjblpoNWxh?=
 =?utf-8?B?VmZKY1lPZTRpd1VwRU5WeFg2SmczMWpLZllxN0E0c1BwcWd4STdYbFZoUmNF?=
 =?utf-8?B?VTlxSmh4dmhhZnBqMHRMcVpSb0VLVDZhZ1hnbFJnOUJHWU00Z3VrTk5BbE1l?=
 =?utf-8?B?SUlXcVNVL3lKZDdlMVA2TEord25aTG1rcUU2NWcyR0VhVmFqQ0VDRE0vTjZl?=
 =?utf-8?B?YVFTYnRvRnpiWmFOYkoyOWxzaWIvT0JreFFQOTZBZ1VZaHd5dW5LZUhJZmR5?=
 =?utf-8?B?M2NzSEJ4QVJiUEZrSHYrTlJQakRtZVYxRUExdk11Tzl3RUplQUVFR0FselUy?=
 =?utf-8?B?S0JMcVYrdGdRRjBxR1dYMEpXRHFhL2s1UGRkTTFCVHh0bTgzVUxCVmlQVlk1?=
 =?utf-8?B?RlhtSnEvRkIzeVdzTG84K3pHVDYzblNKR1FMRVQxMGJHWHhiOUMvVXFJNkwr?=
 =?utf-8?B?dklYLzBVKzY0aU83bm9oOTF6RWpxajJabzVOMXhURU10NlU4VUhCaUwwSWFW?=
 =?utf-8?B?QXRidG5YV3MraWExOGV1TkZEZ2NXME1wWEpyQkNpM0lTcGF6QzIwOVZ5SW90?=
 =?utf-8?B?ZXFNbUlxWGlrMTR3RjR5ZzhRSGRTU2FhTy9EUE5DdmFJdDlWTmlBeWIyRzVt?=
 =?utf-8?B?bm93VVM2aXpzMjNBMWwvb1VhclVYS214MXdXM3BOenVMZk1uSThUTi9lOU8r?=
 =?utf-8?B?U01Uc1FzeGJ4dDhINXpiSHVoMUVUMjVJTjl6ZkdXZjhDcW9RSmtwTlEzN2tZ?=
 =?utf-8?B?aFZxa3VacWFYZTR2VUo0U212a09oWnNOYTcxaHFNQmQ5Unl5ZllwNGo2WkEz?=
 =?utf-8?B?aVR3YzdCZ2JyTWlYcjAyaFFMdEVwZlpQUWNUVm9aeHFRTjlPbXBkaGRCN25G?=
 =?utf-8?Q?JX4CuCBH7gcrzKP2MczCGgdzgr+UovpU6s861?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mxTMdcVKd+5UPBR19h+V39X80qjHWWYxdit1U+SHfCTeWKxyiCTDc5gAbhhspUuhmVLb7hRvUEYpxFC8vlCficmvQb8cRiyzxtKL9oZor27UGJI1tWNAjrxj1PteBYLzg02qoWhpWqIiqLmgGRvEFeytJHG1yTCd6wgydzTwYRsDptZoAuQYxKW0LDkxJQU3nOvao0Oef75ZypNu4Vb0NIIonuw9EFY2Yp+rlyqNJz3hFada9ZoWSkQkiVTo/VcWeWhx5FQx1TWKUWuTWK3Q7RHp8xgDoTz762UspRGsf1ZTII5bOTnafFCz3MMxriSrMO9/63Q/ksitid5bNk4xdD+rNBjc3WA2dhxnaNOdLq42frIsa8yQWQVjQKP71jkeIzI2wbv/ERtbb0BCOpOdbIQnnaqMy9d38yxVj19jTmlL2ljjEExOwBs5scJNMUXW8DN1xgCH/GnoadtrAswAarr0b4KJb8feNLGu733PIfWSZ3eH7CfJIIAxJZMlvdJUInDApXQILWT5Vf87oUyhiSmPS0/dYPSfGGWQ+C6an1BpHJ9OSYm3zHc7kEO7tGWTo3BV1uPJ9u55C4aI0JloZ70prphqxzSHpZPKds3YtGw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787fd8f0-f596-4921-1298-08de630f130b
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:29:13.1770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVlrM1IA4g8JAZN36PmQCITSgHBqopkQUP9Ir9KGZWlLN8UdfZcShmNPIGo08ZZLNH7N/07VLCpganBUMj8aS2KR05xZajBhWrGHHlQcJc2lnLFdYJn2MeXTeH88WV+w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=770 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602030083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA4MyBTYWx0ZWRfX97/Yqbv1O1jT
 h6i8XfTzXjmB0qzHMvJA3vBqmgA8SmylnyIyizv/1dGizxgCeC3dhG8ywBikkKqmJ2qJLEBrCPP
 ngpkLBVp09Sp9sKjVZd94CwWs6jEvcLOOmAF1pKgn4ihPrMEplLWlrFF72lbhZLhMMCukdOjPmH
 0FzSNWLvY+MC7RGy6jwdzORXwDwM9z2rrtCtgYqtuNDdFhPrWvJ1lkva4L0L29dTifLZISfLOWS
 WrZZjS3pM6IkBYowzY1vvLQt4e2iLNQcnPd4jnm8rW87gltYd1KobZu/FjQjLrDAfYwm/XYcj99
 QeDv2AYH0QAwypN/iTeCYFwoV+zLSOYgA9COrttV2i+w48bU2d+m5kvsZMDbLkRrn/yXWREZfs4
 V7xCnMlcfuE3ZY43+jP0QVj0pWuM9YDlUX/xjz+dBLq2NLwglKgMjxs9UlrLPdRvSrLBnTgh7WN
 8gzLmmnP1fMHxN1r8KQ==
X-Proofpoint-ORIG-GUID: Z5cc2a-iNDS07IZNArsUIzON5-IDdMMT
X-Proofpoint-GUID: Z5cc2a-iNDS07IZNArsUIzON5-IDdMMT
X-Authority-Analysis: v=2.4 cv=VfL6/Vp9 c=1 sm=1 tr=0 ts=6981cdfd cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HBZIQFnn4sKx2q7GS_YA:9 a=QEXdDO2ut3YA:10

Hi Andy,

On 03/02/26 15:18, Andy Shevchenko wrote:
> On Mon, Feb 02, 2026 at 11:40:07AM -0800, Harshit Mogalapalli wrote:
>> Hi,
>>
>> This is an attempt to update sca3000 accelerometer driver to make use
>> of devm_ based helpers where needed. I have split it into 5 patches.
>>
>> Patch 1 - some refactoring and simplification.
>> Patch 2 - switches request_threaded_irq() over to the devm helper
>> Patch 3 - Used devm_add_action_or_reset() for disabling interrupts.
>> (Ensured the ordering of teardown bits remain same)
>> Patch 4 - manage device registration with devm helper
>> Patch 5 - Make use of guard() in sca3000_stop_all_interrupts() function.
>>
>> Thanks a lot to Jonathan for detailed review of V1.
>>
>> During v1 review comments, Jonathan Cameron kindly provided some great
>> suggestions to improve this driver. One of them is making use of
>> gaurd(mutex) - autocleanup style, patch 5 does that for one function.
>>
>> Yet to be addressed tasks:
>> 1. We shouldn't be using the spi_device_id at all.
>> 2. Modernize other fucntions to make use of autocleanup style locking
>> which simpifies the code and makes error paths cleaner.
>>
>> I will be working on these two above tasks and will be sending a
>> different patches for those.
>>
>> The series builds cleanly and I have performed static analysis with
>> smatch checker but haven't tested on actual hardware.
> 
> David already reviewed and v3 is anticipated, so I try to look into that one.
> 

Sure, I am working on v3.

Thank you very much.


Regards,
Harshit

