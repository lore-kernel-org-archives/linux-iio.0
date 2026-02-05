Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB8E42DFFB;
	Thu,  5 Feb 2026 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310313; cv=fail; b=LsJ1wIYYzwAU5saVxB/3kVophlfLExvNsDBtSjcJoj3caswcZ8MXxY22cNeTW6IsppREP3rx6ifouVkZOij94RQrGzaLnPOQttr9JUpJu1Bs93rnAkq299RJnxTT+P6yu9C29pGgQTaFL6ppcslTupOAtqEkTlQc5n93tyFYZZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310313; c=relaxed/simple;
	bh=aceke+0ckCpWn0Ke+6uM03iu3BJirWMj6q/t94qYJOc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BCwUepMlPhU8k0IlAVxncTW8BROMvJIrGI0LAqmZOZg7lrFUuSv7Jm3YGS0FTxScSNMenzcdyWrWppyYgjrOBDNbH01FtUmH+TNCRrYnSHASdpNtnBEuGWHs9mVWfYP9CtZGMZz1hsrsPywnSWWWePA627j+DTcB9V72RYv5+kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Oq383qWd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dT7hDbvi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Oq383qWd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dT7hDbvi"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615Fu11v1718910;
	Thu, 5 Feb 2026 16:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tgUdsxd+XUXEZ6RMxJV3+4R0e9FVPkTaDLVeIHrQsnU=; b=
	Oq383qWdEQ5XdD3VX5OCXOb2LxHIYMsarS2SAXOkbZLS1y7uuT9QmkAGntnGN99Z
	FfNAbOdzXUhj0YCLTeT5V/ZxYE0nusI9xQvz5zt2OHCFSSE1LfeF8B2EZvSUcthl
	P0Bb2+iu1el+R7PCA09vqakb+o2rpjK8la2iTaoIs87uDK1H6SEuhtjVXVLMGm6n
	Mo5SXjGNrMAk5BQQlGa3JYgcSh6/JP8R/hIQjh/nCD5JFyp7+Hk/uZSK1wX3qZYa
	Sqpnvfo3wNZ1E6VCCtsi1uvrjHMvhLEtJXb5SssGndt0ZIwx0kZqDyjxW32o/9iT
	NzPd8Ok46vJiBS9j9sKDjg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jsqm1rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 16:51:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615GikES006320;
	Thu, 5 Feb 2026 16:51:45 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186degn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 16:51:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9VkePajZKVLKhVQF3vCTtribbyaSSj+BcyZFgyRpLTXGDVn42nRH1QqOVq0ypFHvPohou70cfYy8veYE8wVvNzjNocup5xQ8lTWVInWH2d/Noh0Fs5Cq7oD8w1jJXF3E0tpKsk0c0gzSlFJbP0mUF/di4dJOH7hL+NFjYdhczGodfTBiFefhg36wZCt9H7CRPBTX5ZYg9koubML3iI72/flDFvdloFcRj3Ey6/Hi0CkauZEADcZbNKiXnjaa+EqC9AzwIDfiiXzmdzWlvHte2EDX8aaYEl6WSb+8cY6K8RDAQjWrATou3OywrMtz5N7nU61ypGTdB45JC0PCYQ24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgUdsxd+XUXEZ6RMxJV3+4R0e9FVPkTaDLVeIHrQsnU=;
 b=Gw7Gkh6xXRT8sUCRQ/C2DN9+iZjQgpE6YleybVZRTZAiG6V+X9Pz8HAQTy31zPJC4kwfcQrbFu5vBbeb2kQQWC4tmfkepYs4wt2WFN6obr8hNb6vBP/MY2Uaie84N1klZ8cG1TQq0A8hoivSw4xnZfBpeg12Hqb4g/T8/lryUOi2d729TvIT34AFr7r53H7C9xugxf1xJvfJ2D6+9AMt3O4rDy6wY6RxOry1gqdIsibIO8FPmNlPJeWWQUMswThykcs1/ifEI34IV0ej++pAjVeUl0yBJyz3V9COVOjCDEX6TWS8O2GBe15BAeqUNDdQA+s1KdjAKifvfzQZ3uMYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgUdsxd+XUXEZ6RMxJV3+4R0e9FVPkTaDLVeIHrQsnU=;
 b=dT7hDbvi9s9D9DKYXG1nhF26ynB/ZiVHPPykUOrrFbCv0geqesi8ZEzih6Du5D/EGYcpJLbx4NZNOrjNpZfPTXQur2wObN3kHjvlkrtQ/weANiksQOvHE1VPE9I/CyIA2mvsK7halLVnXKdeZwtuI2YUoZSLFsrYaQ+S/xyHUkQ=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by LV8PR10MB7871.namprd10.prod.outlook.com (2603:10b6:408:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 16:51:42 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 16:51:42 +0000
Message-ID: <34bac81e-6a6c-4cf6-b370-beead4f705c1@oracle.com>
Date: Thu, 5 Feb 2026 22:21:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 next 7/7] iio: sca3000: manage device registration with
 devm helper
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        David Lechner <dlechner@baylibe.com>
References: <20260205131234.3244467-1-harshit.m.mogalapalli@oracle.com>
 <20260205131234.3244467-8-harshit.m.mogalapalli@oracle.com>
 <aYTFUMe3jUO_bGCr@smile.fi.intel.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <aYTFUMe3jUO_bGCr@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0419.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::23) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|LV8PR10MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 22480c69-0f2b-4a7d-5601-08de64d6d6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDEzMUZ0eExZSnNlK2JSSnB0eGZxSk9aRDhMS3dwS0N4N0oxVUNNRWNpK3F5?=
 =?utf-8?B?VmRHYVdkTDRQRWI0SnZuNDNlZy9UamtVYi9qM2ZWNHB0VlhQdGRpZTNHYlhj?=
 =?utf-8?B?YkFGTzI5eGNLeDYwNW1yMXpCdjJOcFo3MUc0dXZyUk5CQ242RFFnb1QxYlBj?=
 =?utf-8?B?ajM0Wm9OUUE5cXFJQXZUM29NcE9LeVZ2L01qSlF1Ukx3cGxRWnhQTFhMTW4z?=
 =?utf-8?B?V1hBSmNFeUdTZXE5dW9qV3NuWTl1Wk1nSE50enB4c2NZaWR0U2x4RDVpbGRB?=
 =?utf-8?B?Z2ZtUzRjd0JwOXl5YTZaT2NLM0VpVk81ZjlaQmgxbHQ4UHk0ckZGYWFsZDBq?=
 =?utf-8?B?VXRSbkN6bXowQ3VaTzJkMDZMNm5pWkltSUdDVUlLNE1MMWJtbFczbkxSazU2?=
 =?utf-8?B?TnFjV2NvL3JadE1oZkJFdElxT2pqZGpORjFrU3VFUDhNZVRWRVR4QVg4end2?=
 =?utf-8?B?NlV1ZGRKZ0ZYZkQvcmppNC80Uno1ZEdMOWEyVUM5S1FPUHlraGg5UVptSWhR?=
 =?utf-8?B?T1pDT2FiL0k0ZVlsWTdPcDFreU5yRWMyNi9Ya2NwYjM1RkVaV0ZCNjJONDdj?=
 =?utf-8?B?TkZFdUZUeTRBbzhjdnY3YXIxL2dZaDBLVE9qeHVOM1VnWXRoRGhzdWl6cnBZ?=
 =?utf-8?B?cThkbXJ5MlpPZ2R2SkxveVhVYmNCc2g3SVZLU0tmamcvaDVaV1d6WFcvYW9S?=
 =?utf-8?B?T0xySm9SVVVrTnRUcU9wNHJTRkNUZTBOajc3T3Q3QjdITE9BRlRNQWR4dndV?=
 =?utf-8?B?Z3kvNVBsUWxONmFKaVNCL2VISXI4UitOOFBOaFhyYkFySVE3Q1ZSK2pybDV5?=
 =?utf-8?B?c1Zxb3pTYVd6U1BmdGc4eWdkbXZjMW5tbVN0VlZacUovSEdpeFJySXYxWGp2?=
 =?utf-8?B?VUNld1AwN3RVS0VvbEd1Sk9CMi8rQjdyRkY5MDBjMDdpMVFZYUxRc0lPbnpS?=
 =?utf-8?B?b28wNWFIWWdqTFpjK2tDa2xwWUpES3lINm9yMU9uR21ERDhkWlFrQ2xJbDlt?=
 =?utf-8?B?MlVwVW1vZkQxWUsweldEOFUybThTSHZlYWUzNjJjYjRjRTdUZzJobnNTUVBj?=
 =?utf-8?B?WEVrQTNlSnpiVnFwSzJTWko1L3kwRG45Sjl0SSt6aWZSd1pMQUU4bk5mY0pX?=
 =?utf-8?B?b3hrbCs2Ymdkdnd4QUJnN3RyZmgrNENXcU16aTVzcmpPcm9VUm1zZVo4OHBW?=
 =?utf-8?B?eXVIS1hmZW9ib3BNS0RoL01xTmdNOGVGNGVRQTBsOGNOS3ZXSVNtN3NRS1Fh?=
 =?utf-8?B?ZnIzdjRIZzhjS2FQQVR5S05MMnRvQ0t3OUtvcHZoNy9lTU1ZYy9hSmVjcCt2?=
 =?utf-8?B?ZEF3M1J3Qjlna2MycHVxaTg5Qk1Pb1l2U0RzblRUTzlmTnoxS09ZUllWS3ZP?=
 =?utf-8?B?aUR1Q1h4aGFhbitMVUpIZTZBL1lLay84YkxoVkdjQTVQS3c0RXQrT0ErOThL?=
 =?utf-8?B?eDBTSzhJMnlOenF6UlpsZVVDeWtJMlc2WFd0TDkvZkVlU01UN1hBNWw4Zy9p?=
 =?utf-8?B?WW1kSEVKeitaVW9xbU0xSjExRDFTdVNzVTFBS2hUWnF5OGtNbzIrVkloaVhP?=
 =?utf-8?B?UUVzbmNlMWh5VjZLR2dxTnR4WmVLVFFxTHQzSlN1ZUlTbkh4WFNCNFZ4ajVy?=
 =?utf-8?B?VFRDMzhoRWg2TjFrNXQxd0ZQNHFGenhVS3NVRWFUSzZCWHBLaDNEOWYxMzBm?=
 =?utf-8?B?bUw1OWFoQXhTLytkdDl3ZGxEZFRDZmdRY3Y3M1ZXd0VqdFhPa085T0VZWWhm?=
 =?utf-8?B?SXVVQlFOSjM0eTJJYXd1K0hXMW8wSm1tcG8vMkY0VnJLQXVRemhTRlFmSUt1?=
 =?utf-8?B?bk5oTk8vR0Y4d29iYmY4eldGQ3pyWEVvNmFPUElyN25IY05QTzJpYS8xUEh6?=
 =?utf-8?B?Y0Y1V3hWZDdIL0xkLzlFVzhYNjVKNFNJK0dWNnhQNVJILytmcUVycFp4bk5P?=
 =?utf-8?B?NmxtZ05qYS9BRGYycjM5VHFUUGp0aHNrVmUxcEJ6MzZSMnN5bUJvOGx0cUor?=
 =?utf-8?B?M3NSdkM0aFB1Y1cva1o3MkpidE1Ua0JCcDdyd2ZEbkVnNVdPMnlqSURsVU15?=
 =?utf-8?B?MVJYRHlLcVdraUg2czIrVjdQWHBmQm9Ka2FEb2cxNSsrUmlybEI5SjF3eEtX?=
 =?utf-8?Q?zUCE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVJGU2pMYkZCRlcwY1ZZeFc4OEhQeUZndFdEeHU3MXp0dTBXakJ3dURxN201?=
 =?utf-8?B?Y0VEUHVqM0tVR05EU3V5VUw1RnFRNk1BUjA2cWlwYXJKRGFBM25hbmROQW1Q?=
 =?utf-8?B?ODBHUElmT1Y2VkR5NENGWVRRYVgxOFhFazVIbTc3RW5ya3hpZnpzWVg1UnR6?=
 =?utf-8?B?ZDAxZVl3b1dwSlNpRE9DS096RUNUbjBEV3p4SEZFNGRVZXZ0emxmV0NvbHhx?=
 =?utf-8?B?aFJlUnptc2RsZHZnZU0vbkFjcTVSQjJ0SXFUa3hCQU90cEF5Vk1yNWZCK0VM?=
 =?utf-8?B?SUV4eURWakxDbU9XSzc4ano1czJrejRVWDFEbzNXb29QNkI2MEJ1cEMzSnB5?=
 =?utf-8?B?MCtXRERpRVdvZkxoUEQ0MTV2RkpLa2RlUkcvaDZMYXRhbmU0UUxkNi80ZTE3?=
 =?utf-8?B?WEl3ck8xQll5V0VBTTBRSUpmNWtwcWtaYjdadkNzVnVIelZXZUZKYk1GNDNt?=
 =?utf-8?B?MGROWEp5elhQbzFVZHhiUlBFVU5sZ0lOai9tOHFCa2dQZG5hY3V2d3Y3S2VX?=
 =?utf-8?B?RU1kZDY5UHJ0S2E1b29xcFlIa1ZUaUh6d2Jqb081cnROTVZnUUtHdzRPQVJO?=
 =?utf-8?B?QU03SmM0Sng5TkowRGp2Z1QvRUFqUldQcnNDK1JuMENtU2ppRWhrMWRGWWRr?=
 =?utf-8?B?Wm8zK3dyMkttY2YvNEplSjhGOE95cEZ4eTdkWTh0V3NoMmhFeENIaGJPK0Qr?=
 =?utf-8?B?eWJkajJQWHlRL3ExZzN2cjkwV21vUWN6WXhDSTJPWDBhSlBWVWl5SW1JMEt0?=
 =?utf-8?B?R2RvWGU1dHZ6Yk83MlB4dnBsMkJCbGtXWUQrck9QNDFlek5MeXNJL0t6TXNx?=
 =?utf-8?B?Y1g3c1VUVTJhVUJCRXlTUGl3ODJzMXdpUGQ4eHp4TWxocFRUSFRkS0F3elZM?=
 =?utf-8?B?VkU5c0xnWVdmL2hjTmlyMjdtRUZrNFIyR2dsdmhhb1VmQ2k2SFloUnFxYkcx?=
 =?utf-8?B?MjhFdDhTZDNaYWJwNlRWZjJJdWpzYi9Rd1NUUExhbHBKZmtyd1JqQVZLWC9o?=
 =?utf-8?B?a0p1bGo5T0dOaU1aekNySXgyanplMHRjREV4RFhDNHJVNWp5SkE2MFpJM2ZO?=
 =?utf-8?B?dW1zOW1nd1o4V0JnSmo2K0FIMy9HWUJKVUdKTHliUGhzRjZUcHRFdjZWNmdx?=
 =?utf-8?B?TitMbWFrNUtIRXIxcXJEU1NUdUFMK0UrbEFQamsrZDMxTzdRaFhlcVBVRmY4?=
 =?utf-8?B?c3JlRmEramt1RFE1RFhqaU9OUXZRdXBQVEZwWDdubUduNG9TNlhFMG10Kzg3?=
 =?utf-8?B?MCtvY3JNbDdrTm16SmlsaDJVSW9IRHQ5WjFXNThkLzFzYmhpMWpzS1RqcTVh?=
 =?utf-8?B?US9JUmplck11Q0ZwMVEyWEVjcHN4cEFMWU80cVZDRGEweVFIMVV6MGZrNUZa?=
 =?utf-8?B?RlhJeDhRUlRKZlZyV3UrZjlIdk03UDkvYWxmczcyMWU3Y3pCYXR5RUJuR01Q?=
 =?utf-8?B?MFZ0VFprQXphcjJMMjhMZW05VStvMDdwUjFOdHNkTkp4UTlyZ1ZIVjNXckxu?=
 =?utf-8?B?NHRYVUR4eDNLT0M1TVo3ekNIN1NvY296SHowOFZMTkdjTDNxMllSMCtJek5W?=
 =?utf-8?B?YUpaUHZEbmVRM2NRSUo0eFpVVksraEJYTDhSOG1VY0ZwbGU4MnkvNWQ2VlZn?=
 =?utf-8?B?RGM5RzQyMXFNN2thU0o0OEYyeWVYeUUwQ3JvQS9IREtJQlVZQ3BLaHdhWFU4?=
 =?utf-8?B?Njg5aVZxdDNPS1ROaU9WM0RYRHF4N3A4TzNGOXVEVGNnVWliWWJPRHJ0bEox?=
 =?utf-8?B?bjVRQ2kzTk1MNXp4cFpqWGJ1TUppbzZjbTJBR0x2d0NxUDVrdkhwTmdJT3hC?=
 =?utf-8?B?Ylorc0h2WFBOUDhETHRaM2o4QWVsMTQ4Mm9rUDBjTDNsOTAxSlZFVHNOSVVm?=
 =?utf-8?B?TitXSTNaMGRJVUYzQjIwbk9jMkJrVXhWUFRQdmZ6Z1NTUDEyVkdabzZVdGdq?=
 =?utf-8?B?TkFQUm81YndHN0huUHZuZEkvQk9Fd2dUMnZZejQyMzJjbzNzOExMUmsyc1ZO?=
 =?utf-8?B?ZnR0Qk5RTVlUMUpaZVVUQSs2dUJaTXpvR1p0ZWFjVkpYSnp4a0lIcEtrWDlL?=
 =?utf-8?B?WmNTVWdWLzdkTXFxK3NXNC9iOUNTdXVBdzh2R1dzV2FhaHdLVFJhREpXRUtV?=
 =?utf-8?B?U2RUZUpPYXNBaHQyMTd2ODJBRjB2Y0FEdVBPdlArMk0yNXhRZ3lsVjUrMjZT?=
 =?utf-8?B?VTNVNUNwL0J6Y0tCRVR4dWQ2SUpabE1oeFp4aFpNUXZhUlVSYXNaYnFEY2Z6?=
 =?utf-8?B?QWJPdXFmZ2JmRFlGUERhY25CU2lzdmtsbXZzVmFuYVl1S0hKSEVaZmJ6elJR?=
 =?utf-8?B?cmswOTNwZ2JySTBzQlRndVZvTVFETGw2YS9XbkFoYjF6OHNzR0VBLzU0Z2E4?=
 =?utf-8?Q?dQEWS8m2ORohesmFOSfIZmXHvQ1bevNHOnjcH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	poP6UUkTjXFoFcb39/f9lE5hh0pfhGmo1rp/x+3LKzqZwmKGFM0aB8+yA2xxzcXTSTKd4x0lzALDZtbfPr6Nbr1nXrph6rPMeqfgG1lHZMOjxmh2wFIP2NDNWdqa8AAfNjG1eaJhgmYW9NuFvWNHdPoNhj9wlo8SN73MuTBJ9W1yi/rHhGplFmkDHbmA9erqNtNJxtOu1NM5nY10G5CObU66TTjVefOnk3z1DS1A4oa/f0n+rcdmi6i/84plR5k8lhUe9DZ5i8R1Zv+eA8XdBOlm9qqQk7/MSfsTnjsB3B24FTZ6e3Pv+QuZv7VwNye91vVUQNhWEAvi2ND/XQjJ34eGcCRCheVWGXPN4zlBfhRWr9cgFRnX0a+G8mt4+Kv9Z7yOPohRt3Zue9y1Q5ftTM/b1bXGXRweYxR/fiNxHZ54WIjv3BVtuCzkahOd37Jia1A2HLlT3P0L7mG4qnOxMesXsjYqTj9UTme+dY6k5L82eAf465oKQG+jJp0CBW04HNU91W0vpYXkabRThqu9xxM2CaqgKODvTVWOSqeHRfnL0G3qewQwKzk7xdMj0U3nNz8EK2BPV0d5cnWiMqoQ0naOeg2hUEJ/VbzWqX3QeqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22480c69-0f2b-4a7d-5601-08de64d6d6d1
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:51:42.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hW855EWDcYD43ZHdl3CfDAANa0n7v28p9cK3lnsOPcRK6c5rH/swEmk5ws+lmjInsUSvyY6mgiQQcjY0celEiBGQgqTuRHlPX3WWCfgQ8r+9j6ZYBKDpfVrPeONks50v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=678
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050127
X-Authority-Analysis: v=2.4 cv=Db0aa/tW c=1 sm=1 tr=0 ts=6984caa2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CXczhl0Hp333_9DZdrwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iwwS-z1DeM7AFTtJ_Ysy8IRZbbk1mdZw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyOCBTYWx0ZWRfX31GkRJuUyNu2
 mLIsJN1Jqy1kEWTVjHe4Xpmoh+f6uXFjA92VojvoCEv7frZnccSVQfrnOCTcOjdP6K9zuPswQvC
 6PZMZRn0gDbK8oLyv95I2ta8B+ltqS+2WjLvKNyRTQyQKy/VepKwYPiO5BC7rHupWpIRmE3PPs7
 PteRbIxEkM8z7WJNnkf4mSIfTf0NQzVRXLl1Yij2vpshWyypAntKC+6/jGXOW14uiu/0gvnPnL9
 yRpJHsO1E3R2QoBtRqKxRmTd1DWuAAEhZo1fpB7kZxJY5qxGsgdKboZi4KLYJD71Y/jUcm3P6SY
 DT7X+6x0fhOBUcvs7jn3F6YlxOq9JproKGfL4FpaB6Rs6ykD7dlbRF1eaM1kVywRG/FvP1lJWV0
 bSFCiy0ZtknxTFqqFpvLd63UQu1QrC6zTdOlTHURyXva4RNMeimzHaWIe7CSjeQsLNfhipAxwuZ
 3rOjAjzsF4uGQia6lYw==
X-Proofpoint-GUID: iwwS-z1DeM7AFTtJ_Ysy8IRZbbk1mdZw

Hi Andy,

On 05/02/26 21:59, Andy Shevchenko wrote:
> On Thu, Feb 05, 2026 at 05:12:13AM -0800, Harshit Mogalapalli wrote:
>> Convert the iio registration to use devm_* helpers so the probe no
>> longer needs a separate cleanup path and remove callback can also drop
>> the unregister. After this there is no need for having a remove
>> callback, so remote it.
>>
>> No functional change intended.
> 
> ...
> 
>> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> 
> Do you still need spi_set_drvdata() or analogue in the ->probe()?
> 

That's a great catch, I don't see spi_get_drvdata() anymore after this 
series, so yes I think we should get rid of this.

Should I fold that into this patch in v6, as spi_get_drvdata() is also 
removed in this patch ?

Thanks,
Harshit
