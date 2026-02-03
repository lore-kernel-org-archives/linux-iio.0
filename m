Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5137C3AE6F3;
	Tue,  3 Feb 2026 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134514; cv=fail; b=E4xPUH0ev0etTOg6heX7OFHqmxB8UfE6zqhEN0IslqcgleJHiY8l/GI12GlNZcrfHMYABU0WTT9cwzBuhjhtoqB05CnxStybb+OQ43riIDSsGpiyDwquPVrf4LQ7Ptc+F03AQKnyGzmSFmcxgO2jpSOEKZNv2j/IUIBJH53ouUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134514; c=relaxed/simple;
	bh=F1yEFmHlhIjjzl/9jSAHAxT3UgNjmLS/t3Bz7eQDivM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dnpfh5+6Oy/CRgWFNnPWcNGHyWcWl4t0TbPmWaxD/h1uLz9kY7eyp+BDAX/s/CcSrYenK5CB8ETjFcTaKvq4E1yXf6C9p5qRMsRklEW2IeQXwMTDWkhrhk9j2Kn7tvGneQw7A1RCTqS0EVI6Evs2ep/sF4jTlY7AG3ze8snUbO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=huYbtda5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aRvx3KeU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="huYbtda5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aRvx3KeU"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613EuxNZ4100762;
	Tue, 3 Feb 2026 16:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5w/h1A6LBxWiIzjSC0WrDGHcEvg9rHb9b+q9TZd9Haw=; b=
	huYbtda5jW/slgAL49dfPJfHloi83mW39x+WAWYwi/RfvHRJbttt0kVaCeV3l3oZ
	Zra5s9aC/eXMdHjYcYPxsSf/H1odcdiX+xaGBN5pKQif4FeMO+7byeYg2MTY8Bac
	3JwLmGbExI63fVbVxJZmFgnuGyvbnXmyPRomdJqZHAUdW7vWJDohocdlbMvlPW+9
	//FIn13xabzTJMsT/CAsyWh9O+XhC7JhUJsOBcZ1p6j6xcfcciT5bt7qDsk+XlNZ
	6lkxPWj+XbmwQrnwev6nxoYxNxg73OXQsD4K9xCv5dE1ALzjultPBnrSdUkpFCoB
	vatFTLxcnEUZX89H3MXDOg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3k7ug430-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 16:01:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 613F1Uul024116;
	Tue, 3 Feb 2026 16:01:42 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013042.outbound.protection.outlook.com [40.93.201.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186a16vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 16:01:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTTas7mzM2NVddqKdSEdgRuwyegBbczzv9d5l6+0ofw2PZdfyJ4PGgPnKEzCNVqgz11OkCXaHDy+YmF7ifRBA1EXqOeaWNrYsx71Old4AKQrffnMzFDLuLsjRygWlAtcde/rU4nRzvWsDSYLwX6ynKfFHJJDcAFN5/TkPFzFiTKbmcvXwjESaBUOIw1OzEXB5oU0cnuqinRgfwiHiGmOLSrZAA6/9549WvaP+hVo/t8XCkpRAYhboq0fo7XJDP182ltPvqmbbO/9h26cF92EAO+T3rdVgedEn+h3Mk9i4nt3K3yQRIipQcd6GYONxqqufK3JbId1Zc0v7FA0CffL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5w/h1A6LBxWiIzjSC0WrDGHcEvg9rHb9b+q9TZd9Haw=;
 b=nY/Vn9Z3qVV6RtF6OB0xIiD9sPCmgyi69rsNSI/2I0wazRmfS4xapK/o+uwzIvuPNMgRYaxGMte28v0usipbarJa2AipriKi28rjrxYNf8QF80yQ7J2QHXeK6qCQ0HAEIJHUi6hOcUrTKZZssv7tgal0c6i+pLvr0A5vR6trO+ZoiQvb01XVR2QZ5Dy11luRoPAu/COuMoOjYwsfhKhFp79L6WPK5q+1gGmuNBT9uM9dnoJO/re4ayxBWNSkraSuNYDhNQMVhZ6HOOEYsB6WE32ZsDiwQGPjTcO3lzCx+68fBPX5dqxnq70eYqC80e63ZTPnpGIRlLzowhs1z0JQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5w/h1A6LBxWiIzjSC0WrDGHcEvg9rHb9b+q9TZd9Haw=;
 b=aRvx3KeUPvKoneSl2tx5CQo/N55NxWmksXjniu5SwZEPUeLILHI38jlJufqjHUbb+3RldR+n5VqFRELnRjD7FAq7lNAr/naMHWX33SPlpcgxMyq1/9IX7loVOdJwBJkGxO93b53Zhlb0eDWRq9aUMXlmYMqFwu4ZtPSY34Y1NP8=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by CH3PR10MB6860.namprd10.prod.outlook.com (2603:10b6:610:14d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 16:01:30 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 16:01:30 +0000
Message-ID: <b9a7fd83-54ff-427f-9d60-3cea5d156923@oracle.com>
Date: Tue, 3 Feb 2026 21:31:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 next 6/6] iio: sca3000: use guard(mutex) to simplify
 return paths
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
References: <20260203122109.689669-1-harshit.m.mogalapalli@oracle.com>
 <20260203122109.689669-7-harshit.m.mogalapalli@oracle.com>
 <aYIS2oRIw9jXMB_r@smile.fi.intel.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <aYIS2oRIw9jXMB_r@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::20) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|CH3PR10MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7b4363-0b9e-473a-96aa-08de633d7eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2pVTDZCSGh5VzdTSm9ManlwdjQxamdUanE3MlJUV3Y4NkpVQkJhbHYxL2Np?=
 =?utf-8?B?aGZSOTV6SkZUS010UWtCNG1rYlpNc2hHa2FWcnlFaFJYNlRIQWppZ1lpNDZq?=
 =?utf-8?B?ckNFRUEyVWNXcXVyZXYwMGh0RG9CUE5kVkVvQ2c5OHpTbk8zUUd5MGlPRE9I?=
 =?utf-8?B?Qk5HcTdNUVUrSk1WT3R3ZVVqazIxVzk3NzQ5cnlEbkFxME1rRU1wOVUvK2tL?=
 =?utf-8?B?c3MxdkwxTEtIQlA3aVR2RFRWQTV0NDVTZVNybjNjalp1YTNNVHdMQWNiQ1Zt?=
 =?utf-8?B?Y0hMUmhxWjllQlVObkdNcjJ2V2xVKytEa3pvMk5hY2pWYkFSWjRtVmNiaEpF?=
 =?utf-8?B?bXMvR2hpd0hnaG1sUHFraEk1SlU5NW8yakI4eHZTUWd2NjNmeTg2Vy9RUTRj?=
 =?utf-8?B?MGwzbm1qK0U5dDNrb2gxUGk2MDV1Ti9RY1Q2dDBjejBpMzBxdVlFVkp1cG9z?=
 =?utf-8?B?allFc0VyT1hza2hLVk9MT3NCS1EzbmVMSjZuK2NGNlYzVGlMemtlN2lyTHRw?=
 =?utf-8?B?Rm1qaGV3M3I0UzVNbDBvRXZBUEhDc0JzUWxsRTlsSXZDQTFidTNoKzVmck9C?=
 =?utf-8?B?SUFSTkFEb3VMdFhnQzlRTFgyQnBBNGorZFZiMExtQnIzUjZSb1ozeGNwaVNI?=
 =?utf-8?B?L0FPWE9sL2FMTVJUbWhCbVVvaHJjamV0WklIamZjakRIS0Y4M1JVNzJnUFhy?=
 =?utf-8?B?ZkJ2SDRFajFWOWd3RWdrNjI1QmlCOWtrWld6L1c4T1R5d2k5aUxZckJ2Nzl3?=
 =?utf-8?B?cmNIeUpMSGZ5MXdybm90QTlBNXBiOGNEaGgyKytGTTZNRUgyOVR6U0ZjKzlL?=
 =?utf-8?B?cVVubVBBQjMyNndPSkRTTDVkQ004cnBmTFBFamdyWk9wa0w2VjN0T3V3b05o?=
 =?utf-8?B?bURPSnVjRDdCVFhXUStKYnJqcDZXNFFUQTZXektXclZ3UisvNzBHT0ZBWnds?=
 =?utf-8?B?WUc2alRBQ0IwelVIZGlWckhqaEJqMllCWnVTbHpEbTVJeXZ3OERRU3pweWh5?=
 =?utf-8?B?ZG1tRDdVRDkwbDl5NnZSaEpIbVoyOVEranBwanBOS0R4S0JqU2R4OUZKRTN6?=
 =?utf-8?B?RXVVTmZ5UzhDOEN5YldnSjc2bmFQUzVVRlRpbTFRTW5FOXBSQ3Zvcmk3andR?=
 =?utf-8?B?VVMyRDlYUVNCZFhlVDZVTFAxQ3RpaTFSakZtdEg4YXVkYzdXSitESysxdlpJ?=
 =?utf-8?B?VWhhcUg4REJqcjJDejRPcXMrZmFnbHRkT0ZPNFZZMStCcFVYaVp4QitTUTdr?=
 =?utf-8?B?ek4xR2NHZGQ5TUwzRldJckFFMHNjMkhSbW9WeVc3Z3gvMXY1NkVWZWRISDNr?=
 =?utf-8?B?T2F5NmRaL2JRdEk4WnNpMTlPMEpyVXo4L0kyelZhVWRud2RsTThhaWtsdnB1?=
 =?utf-8?B?MFZkQmxPdmtsTkUrQVpsUmlYSnkrVE1YRGxiTjBhdU1UZ0xTTWJrSDJkMFcr?=
 =?utf-8?B?QmYwcDBIeUNFUXdqd28zK0dub01UZ2V1ZUt3dDU1OWI0eUtlYXVubzVhL0tp?=
 =?utf-8?B?RVVLaFVUcWplVm1XaktFeGZSNDEzTXA5MlYwb2paVGFhemtNTEFsb25PZ1d4?=
 =?utf-8?B?Vkl0TnZaenUreS9vZnRYaDA4Yk5wNXVJWjlmZ3VDeGZOZDRtTE5ZT1JzNWVz?=
 =?utf-8?B?dE44RGR1MENCL05UOC96Z2RVT0xVOUVwU3d0MkdvOWR3ODMrZzYybjFFSHNB?=
 =?utf-8?B?dnJVZlN2NVRKaWlFVmpodnlzVXB3YStHU1JjWDBsNTRjbXNyc25lWUQ2K2VS?=
 =?utf-8?B?bWdscGhwWjhuNU5jcnc1Nk0rN0MvbVpjVDJsWGRNU3pyWWI2S1BxM1kraGx4?=
 =?utf-8?B?R2xxVVZ4eUJtRUY4dFlPUHRQbXVobW84OVBiMGVCZ05Ed0t0VXhNM2dXVk5Z?=
 =?utf-8?B?S1huaG9jaUFMYzhoV0pwa05XWnRQcHJMNEVJUWR1UnJNQjYxWXF1OW5qdGZk?=
 =?utf-8?B?bi9RZ045STJteTE5OEZEVCtSVnZta205OVd4OXlyTXRIZ1Jjc251NlVMR1hj?=
 =?utf-8?B?WGxhcllrY2xQaC9HYXMxaGpjRmRsS3NJWUwrZzNXSHRvZHpNRDVVOVQxdnF3?=
 =?utf-8?B?ZkVudnJIL3pnNXJVTTFqaDJUdGNVcUczMmMzandsdVN6UTJBdE9rRzBXNUUv?=
 =?utf-8?Q?FfF8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkhHZ1hSUFR3dGo3T0Jyd3RLUGFNNEZXbFFKTmxxV0xtcStPc3lMcUlJQkMz?=
 =?utf-8?B?L3pKaldZWnlDRzFhcGZtYTY0TERpMVRSa0V6bmpRUWRVYnlkYlc5VTF1UW96?=
 =?utf-8?B?S3N1WG45ZHQ4OU1lZzhXNlRTSWdtUTlTMllJS3poeS9BemkraGdKak1GRGpa?=
 =?utf-8?B?UFErajF3OXpjL05qRjBqY0VXZ2k1djBZeHlLT2ZZZTVjb1BQY3hiUk55aGxF?=
 =?utf-8?B?KzZDajlaUEwwWFVsc2Q4MGkwdjVjeCtLK084UUtYdjU2ZTgyL3o0ODVRa1V3?=
 =?utf-8?B?emw4eXhWUmRHWWh2WVRpMFc1QktDdlVWTFlnMXhyVDhla3FTcnNuejFQMldN?=
 =?utf-8?B?RGN4Z2VaczhSRFFLVk43MDRpWW1YSWJBRGhmZ3poVVJtdG5ldTJlYnppY0Qv?=
 =?utf-8?B?V09iZXMrTVZtLzFmV2pPbGZzZFVZZVh3bHdQNm5RUkllbVV5Rk1wS21Fa0dU?=
 =?utf-8?B?cEdpTFRMclltTm5GWUh2N2Z1R0M0RFFhSXdCdEVNK0tRTUZaVERFdnhTZVY2?=
 =?utf-8?B?dkxnRVRmVjI2VjNPeTR0Z3Z3R0FQbVkvdkk3R20wS1VZalh1Z01QVFNTNFRY?=
 =?utf-8?B?MW9salduSmF4a2gvODkzVkpIMUhQYVovZ216MVBHdUxhYis4bzZmNmdHTHhR?=
 =?utf-8?B?RkZ5YkdLWmN1c0FLeXJZYmEzYk9sQ0M5V2Jid0x4TEpyUEVucmRyeFZnZDFB?=
 =?utf-8?B?ODRhZEFlVkt6NmswQjZvTVdseWhOdTlSQmJTdElpL3FobUNIOGVibmlONzF5?=
 =?utf-8?B?UDFXdlNudk1Idkk0RVBXOEZNVWJpdFE4WDVSYldsRC9pMGZTSjR4bnV3bVY0?=
 =?utf-8?B?QUpwdk5GTTBJZjIzcllIVWZLYmFMY1oyZUEwQlNkaXBzZHpKU1hxMVA4ZWJX?=
 =?utf-8?B?cjlMcEI5YU1kWTJqTEpDQmQyN0wrZDc4Q2dOOEhqbWJHVXY1ZFhzRGpaelVJ?=
 =?utf-8?B?eW1jVDNJczlkZDZLZWVRVlBhTVZhWXB4M1hQeFd2YmRFVCtyYytmV05HTVdH?=
 =?utf-8?B?U1d2bHRmLzVqc2t1aVJJSGVWOU9lRWhNdDh6SExNK2lFNFBQMm9hNVBRWGli?=
 =?utf-8?B?TWVaa2ozSGpBYk1va1NwdGZkNnNORSs2QkdmaXJGdGNreDZ1OEYwUDg5Tzli?=
 =?utf-8?B?RFFqWWh1WUlaWG43bUc1d1drRkVaYTVyS3VxMHljcnBEdDkxNFVWejVodnFY?=
 =?utf-8?B?S1RYOGMvcE5YL01iMTNFeXUvK0srTGZ1cXI5V2hSTTV2YlZKZFJRSmRqTHNq?=
 =?utf-8?B?ak83Y2FLMGxSZWVWdkRBMjM5MzAzd0M0bkVNcU9uUnp0amtSL1h1aDVsS1d5?=
 =?utf-8?B?NFlpOFdIaUNiVmo0MkdoSVFiQkJZRFR5Qmo3U3pMaXp4czQ1RnBGUU9qdEFS?=
 =?utf-8?B?K1Myb1pGNmptYnJ4WEZSTWMvMUtYR2dlMFJIV0tUcU56NTZnREpkRmR4N00z?=
 =?utf-8?B?aSsyYytTLzRkL0l4aUQ1WTBjdjdtOFFuNnRKYXpHcWhlT0Mydk1kWG5MTThQ?=
 =?utf-8?B?WXdzUVVTdmlBcnU5Ylh2VVErVEdpdUt1by9ET0pVcG9wMWhaMlFiMStlaVFW?=
 =?utf-8?B?Q2phWXEyaEVZWk9xYkVyM0E5MUVHZFppMXRoZE9uK3Qvck5KK2JJdjJYUVhC?=
 =?utf-8?B?MHBXK1RnUThuNm96TVMwL2xCVlRjRWpJeTZCQmNGNjhpM2srNFl5V0RZUGcv?=
 =?utf-8?B?NkoxaDdXUy9UMXRodzJuMVpsZTFTVk5NcU5DVGtOWVpIZWdtZVlidGVEZnY3?=
 =?utf-8?B?K0Jva3ZSZnh0QjFMRHU0R243amZQTEFSZE5LbTFHajM2YVVPekdTb3JQME9t?=
 =?utf-8?B?eEM4MUhRQlBlU3FmcjRDU2xCeEtVOStGWExndTBCanA4MnU4SStzUFNudW5U?=
 =?utf-8?B?YTJWQml0RWFhK2NFelFQbm43ek5YbllxVkMzbDQwdWpLQ2xpYXhRVWdOV3F0?=
 =?utf-8?B?V1Ava2YvWlJ2dVo4L2Jwb2N5THFEalN3SFhYWU5uMFRSR0l0TlRwa0FnTmha?=
 =?utf-8?B?Y3FwSDhnZHViUkFQb09CMmpQalJoelMrV1JWOE9WamZJaHlhY1pCOHR5NTV6?=
 =?utf-8?B?SjRJM093clFuSm9KSU5UbGtOd1pPNHlFMzFURkQ3bi8wZGhTVi8rRTZGbjhz?=
 =?utf-8?B?YWdGTCtoRTQ5SFFCTTl1MjdYNVg2YTJ0bHFWMWdYVStWOEtJL3A3Nno5YTJS?=
 =?utf-8?B?UmVwd1IzWUVMdm41bU1JR3AwS0l2SktMWTJFK3MwYUdPSVBzQTQrQVBoSGU1?=
 =?utf-8?B?WXlxN1hOQStZS2hjY3loSnk3NDBYOFo2M2lYa0RrY3hadjN3TGtyZEhmUDZE?=
 =?utf-8?B?cnIrWGxmRXQ3aHIyM1E1N0EwcVNCT1J0c21YT0x1dGxyRXFqYlJORjRCVjIr?=
 =?utf-8?Q?MLY2HUK8oxZORPZLXaBdLqLJDPQ+S4i1cxzV4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vIizH1FGSb9D/cBbvy7bPIq2YZzfYudMIl+zWBgfl0y8qp/6WMyKgeLP9TNsJkTXKGYhfSJnhDuLX+/NUWLKOi797CLxRooe/0NE/sc2iSj8ifcY1UkKmbjPheoKjYwQsrDj0x5r+g4HdIOeQnk2uIPS2ujbCIWYv71p7QPSe8nDHZqcRSazJGwGBInL02LDbSuI2hph3Qlim6S3M0RqKGJt+/MXj3lFRgMeL0LSECBR16T+Xo9iH2giB/ArBcpkf0NRaDS1O3WJ32Bxk/++D+hs8mlZBAL17UmVMzXkF0nNRYkBPHfK2bp987kXxm3zr2Yvz4h2e+0G0rcy9Dn8uYCptOnybRGLLM7xj5IqaJ/mVkC60gW8Uba0wvGSz5EmTLEC0CPgoQB66vveFzl+hnsISbn87KkhmtIoxKLk/whpcWJzNmFnV82mheuY6Gkf1MdEfgPVSYN3IX7nML9Yw55L04lo4S7ILDwNvhFNeiugE3atb26/bIDl+9BrqwfLi/0RPmAD1pDMeLbsUWkhpDGWeHYZMYq7QrNMktaP1rAWEnJ4ge6W7WYvyiBjwyBARNVLmeB5jAhHYsPn7sNqYM5m1gjuRgTbUOd5yttWZqE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7b4363-0b9e-473a-96aa-08de633d7eb3
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:01:30.5749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKTzxtrdhHNSwxf/AEPM+LSpVKys5FHSNtsyo1mq4gEg3zJI8GnqgJkPFuUuaB6V+QusG65thJb94QRY6WClsYq4ZVWVHi5XgTvaUAw0t9HpEoN5d1TzBnbog/omeX2E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602030127
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyOCBTYWx0ZWRfX6MDGX1jawg57
 pIvcTpGVVio9+FkG5stGvc9Xfs9C6GyeIIlRYgoCYHbXbZRlhKhpgqsQLdVftKY4aDmFc2NuP37
 gdtoxehjC/ClwvCzBL7tSSEY6ya31ayiczQ+lcH7jdb8ozHX8tln+e2sstCXTXLcD/QHl7rVyJj
 ICaIhm4dkFckLzRS6aEvPI+jwEAAC7X+kltwOum86j/qyozEBUSvyyNL80lZglhcfYpaHoQmRWh
 hZNncjI9Wct79gfG4/5OygcsvNiQqZnq7Y45Te1da9vmmRld6GvbfD7IKTBPL7pmP8Ai/X3f68A
 2OeZUZ2T8xw6PPZUD6VzCr1WY4rNjNTRqnV3jbFSsyI2DcQvg0rZIUgT/HFe7HgSWrzJohx3tIM
 RXy3nOitnhx7gMOM/cTa101scfiVhCDutxMwXxgZdaPSWl7GIY5nKDJeURHDsDojI1OGfY6XhgM
 1POkyXKlCM6TEkTVPnw==
X-Proofpoint-GUID: DQ2K2kQM1DpVk2U_2LFTgWLEf_0zGQTD
X-Authority-Analysis: v=2.4 cv=Z7Dh3XRA c=1 sm=1 tr=0 ts=69821be7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0jrvjEXvPr3V7Ik97SAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DQ2K2kQM1DpVk2U_2LFTgWLEf_0zGQTD

Hi Andy,

On 03/02/26 20:53, Andy Shevchenko wrote:
> On Tue, Feb 03, 2026 at 04:20:50AM -0800, Harshit Mogalapalli wrote:
>> Switch sca3000_stop_all_interrupts() to use guard(mutex) to simplify the
>> error paths without needing a goto.
> 
> ...
> 
>> -	if (ret)
> 
>> +	if (!ret)
> 
> Leave the standard pattern to check for errors first.
> 

Thanks, I will do that, I agree it would look simpler that way.

Regards,
Harshit
