Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D293009DA;
	Tue,  3 Feb 2026 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114284; cv=fail; b=LN+LbLBRQagdejWttvcelnauNzQLG/2O+0JWELU0fY8A0+oCO0rPDx2yuw4yfWlpQ8EYZHbW564pjbki4nxgzlmB5pDlyx+wpDuzmAXqXtCZyEfmI0P6QD22QCDnR/osUbB9LcMixMtSO3NoGo05WPcVZAZfgdYVKuMIgaXLp3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114284; c=relaxed/simple;
	bh=wUwE9FFkpeg8SBAL+lxmDBNTYfOp4dsa1EPJvjUg2a8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lu4Apadp5xxqnwK1vJDhSD/sOqxj10X9CzkS/rKXNJNJ3u9Mwwl31v5+UInhri9uvi6+Ha8FwV0HLW/GT50O5f2sjlmQp7heJ3IYGsV7lOGjRsdV8gQhXYs6Hf5QQWSqZ+Atrt7fULO96hTdUWw3goL74Fh2vgmar506vhMgRiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CbEpVge6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n+Ta9lui; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CbEpVge6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n+Ta9lui"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138vFmZ3151227;
	Tue, 3 Feb 2026 10:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SxeIO1PWe2GKqGrvqwYticLnNhWx8CUZajmbKx5IDfQ=; b=
	CbEpVge6DxB3rmbRPnuh2WBa0FT3cjNyxW9+qrXo/JGWKfthC85snKd+b2nWyejj
	N1ZGoet39a58oZCzLGkwN+WwqpNb1zFzNcFiKf6HVq3SANQa08D/rPUSxHSjkT2/
	OoBLZsI/O0XhOnEpYMeH3Epcv4Jchj6iDRkNbPp0qSPlnnySrM8phzttpwPP3TpQ
	lcmjPLkqtbQ5zd6/LSRJhQb5+vKznIbkyOk2MXQmX2IY0CNut/autDXviCyUk7m3
	FP+p0FOOGR8EVSRZYjr5R9CmrKO+DAv/LV56jqWWD8dcf7xpb7vT5Mqb91XbUqOX
	xoIKOMQHCqa8VbVjS315Mw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1ataku2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 10:24:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6138WdI4025853;
	Tue, 3 Feb 2026 10:24:34 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c25788p17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 10:24:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZB0DcEM4+lQDvRsFQQZYgWcQVM1ux7k460OE0vvxj36RrsoyWXqj/vrLc2WB/fPdZKuxAyEyf+ILQCdEUrspR5R8e3A3t2G/RqbM+moopQQuCNGjSepdqWNpLOsB7U0pJ9IknWhMFUBsPfnffKz+K2z09z/nsR/r502fJscSDsqsu27zp4YKiMWpDsTQ6ryJyPrMcajHrVekma5rNBBT6wbh/xzMgCQuWA2zSA4U3UuDV33gOhTylNE1kiUueRZAOXN1xQyYOeNz4x4PBshOyoNq+FRbPWYTCilw27IATpD4snj6hLOa1nYRKoCu4vBHqhmi4cMUGZ0r60qFmYskxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxeIO1PWe2GKqGrvqwYticLnNhWx8CUZajmbKx5IDfQ=;
 b=Tp1zJPxD0wOxn8GGoUq+CgZBjm1IJIuGVuCRBQNOl9eHb30yVe4tKIuDe8Z1cysJnRCbsfkd9ADcjh1FLK1Cyl+VrkLQ63wnGiOmGpeaqh2MOm+/Nk8er0ttZKdLqa5EY4H0xxfJL/nsB5yt+CcPyF7E9NnqkMhp+yeeDAgIua0di9wPsBsZnn1hgyJ4Dk/KAGWbESngx+8bbQx9P5sy2C6eQz7QpzUE0QT00+Sm7wLYux2qgjKe1lRWdpDckMgBiWJ2Pt4mDmobEl039vXAp5AKg1uhIQVHmMIo+/MujFO1eQdk1GwI3DmAF0qigsfHcEnWtENBdhGmf/IjKhb4wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxeIO1PWe2GKqGrvqwYticLnNhWx8CUZajmbKx5IDfQ=;
 b=n+Ta9luiQFR2TwC/i3v1+ARCRMFx/jzHIabwJGR5Sid00Bvozj3Mjqxb/8vpuN8RiZwz+zv2a3p+vg3tIEsjTzACLxtaUgydXeT1xTkJ5msZF6lQAqzyclfb4Cay8gb8mL2gvqWow5fdjtX2FNK3SJzYezfhTpom1CTqRuF45EE=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by MN0PR10MB5934.namprd10.prod.outlook.com (2603:10b6:208:3ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:24:31 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 10:24:31 +0000
Message-ID: <91ba7406-b05f-4aaa-a800-b4c8cde0eeb7@oracle.com>
Date: Tue, 3 Feb 2026 15:54:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 next 1/5] iio: sca3000: cache SPI device ID in probe
To: David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron
 <jic23@kernel.org>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
        andriy.shevchenko@intel.com
References: <20260202194033.627967-1-harshit.m.mogalapalli@oracle.com>
 <20260202194033.627967-2-harshit.m.mogalapalli@oracle.com>
 <38793c4d-e79a-4896-8b25-e20bc8ecbb74@baylibre.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <38793c4d-e79a-4896-8b25-e20bc8ecbb74@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0368.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::15) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|MN0PR10MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 828417f1-c44e-4f83-d57f-08de630e6b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnpaTVpUalRHekRjS1JHY20zTDZQbStZSGdDNDlnR01Db3U5bVBpMUJ5Qk9O?=
 =?utf-8?B?Znlwcmd2NlFkUlNwZEZhK3pHblpPNkM4Q2phcHdnbGFUQlZsNmU4eW1UOHhF?=
 =?utf-8?B?R0ZTZ1RPOFhUcVRNeEtMR2dLY0srbW1QazZSWnlhUGF1NUVQamdEcy8vZlJV?=
 =?utf-8?B?eEU1SUtmbGN6blJkSDBoVkJmcDFxRTdOa0k4MUlacVFrSWc4Q1YvejlUZ0s3?=
 =?utf-8?B?MkJZclFmaTdRcURubndsaXRWZDhXOTZCcmRsVGgxcWxxZ3pTNWxibkc2dUdw?=
 =?utf-8?B?Y1V0SWtHc2NTK0FvWUEwa3N5VzFaeWlkWXNoMURCMjVKaVoxWE9STzF1Tmx1?=
 =?utf-8?B?bWdBMHRic1hsc2lydUdRRUJZSEcwNWNuTjlTdnAzbHRyNE9leHc5c05HcTZZ?=
 =?utf-8?B?MG5rem4zeCt4NlNuOEdwNG44ZmxEQkJSVnV2VFRkY25HTnZmSU9LU0tQaDNj?=
 =?utf-8?B?NDhuMXJRTnhnMTRESFVwd3VBdERPWlJ4OFBtbFdhN0E3QWJmRHFaVG9qRXgx?=
 =?utf-8?B?cTdPTy9ZRmNNSkdDdzVQQkxuZ1lWd01HQ29rU0IxL25FME5vUWFaNWRRdDU4?=
 =?utf-8?B?aXhRdFJ1ckFBaTJTeHFCM0RyTVBIQ2FBVElYTWhPaHpPZlhGOWlZWHFVcmVI?=
 =?utf-8?B?K01QcDRTOS80Nk80aUhkSndxUzlkY1I0TDBEZEpocnk4anhCVzJhbnVCY1pK?=
 =?utf-8?B?bVNQdldLK0R4TjZ3cW50ZmFYWHJtdHBqdjExMWJtK3hXeXRZRWFTMFgwUFQw?=
 =?utf-8?B?K1FjNjVFOWx4V1NwbTA0L1JkUlZxRHBqQkV3R1MrYVI0a2ZJczB5SzVyQTJn?=
 =?utf-8?B?VHVBeTlxT1FQanNhMktQeDBoSlpSTlplTW1CZjVJaUVaRnB4eEhrUXg0ZW5m?=
 =?utf-8?B?M1RUNFBjcU1kTE9KbXoxSUVnSWwwV0sySU1zdCtPcG1IRXFyVWxYTUxMK0NJ?=
 =?utf-8?B?Y2hIUjFoaE1KRXFuQ3VOdVNOK2piNTF1b285bFlxOVhmWU9YeFcxUlYrZzJo?=
 =?utf-8?B?aDg1eXFPWGFjSjBTSFc0MGg1c1B3SDZKQ0xBdW1pLzVNWDZrdjRCMEJZYmVF?=
 =?utf-8?B?S1E0UTdPeFIrUW9KY0ZPMjNYbFplZzVmbU1qT1Y4c3VJVW9BRUI1YUhDaEsw?=
 =?utf-8?B?bzBMRXRBUnkzTUo0RjhGME96UjJnWERpZWRlZFhtUDRrMlRZbkxRaXphRHBE?=
 =?utf-8?B?ZXFvdmEvRmhGSGNPOGZWMHhFdDlyUEFla3B6SjFPcjN6dTQ3SkZ3Tm55RkZx?=
 =?utf-8?B?TGFudnVpbE5lL0tBWnF5a2IyMUlzVjlQWnhzTjZWN25MbmdDUTVKSW9pM2dF?=
 =?utf-8?B?SjVWNGt1dS9jZzNMTlZXei9MdU10cXN4bkdLUWo5SEdBbSsrTDRObUVPc2Rm?=
 =?utf-8?B?N1B4UnJ6N1Nub3hJNlREdElKdnRXWXlaaXdsVStaZ0FYQmZKbjlWVFZTZWZ5?=
 =?utf-8?B?RWN0ZTVGRmo3R0I0LzMrbHlTTStBZ2prOVBabTArK2tBM3JiOU1YS25EWWFa?=
 =?utf-8?B?RGpLQjVYVTdVNVQ3YzB5NFM1RUpBdXArZ3psQWZFd1NNWkRzSTNEVU5GeTRO?=
 =?utf-8?B?UnNoeUwrRlZGdUx2d3NydlB4MEp4TE95NFR2QmJRQTJEQlNKVEU0QzFFU0Jw?=
 =?utf-8?B?ZVlyWWYza0JHazZYU2hIdDJaVzhKdk9ya1ptL25aN2k0UnNTVGZWOWJNVXZu?=
 =?utf-8?B?QTVWdTNvODNLUFhKMGUrZkJOOWFScVEwRWVNd0Vnb1dkZTNlSTlkTEk5UDRa?=
 =?utf-8?B?ZnpLUzNsZEMvaTFSSlc3TVdELzNMRC8ydkxwdkNXMXJiZWZ6RU9qK1RSdytz?=
 =?utf-8?B?VUR4dU11Qy9xV1pDY1VENWNWUHdEdEZKUGVxbitFeUFmUFRDU1UrVnJQc2xB?=
 =?utf-8?B?TDBOdVJoVDF6bnQ3MDU2a3JNc1ZoWDcyaTc4UTFiNmJ6dUk0VFlnbnRzMnNB?=
 =?utf-8?B?Sy9BK2hLTDNxTXhlaHRUeHhxL2FwRmlGaDBNenQ5SnhSb2VlcStaQVI1MWE2?=
 =?utf-8?B?d3E2T2QvNkxxNTF6M3BVbUtFTDExTVhaeDBIclZ2bktiWkpCQjB4RFZ0U1h3?=
 =?utf-8?B?bE4wM3EybWVVeE5DaGVJZWlwQ0g3SWgzeW1GUzBCckFEQTRLY2dOa05FKzRv?=
 =?utf-8?Q?fZdk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU9wZ0ZCUHpiRXdMT3pQNTlVWTM5MjA1NHN0MWo5OXZFZHdXajJyeVNFQmJV?=
 =?utf-8?B?cXM5WUx0bkVaTnMrVENrd1JRbWlrQzJzZTJ2Wkx2MmppdlRCS0Y5VTNsWDdr?=
 =?utf-8?B?TXpzTU9NOVZIQ21pcVFYRXorbmJlMHFteVVFeWJObG1FSm1yOGI3cjZkZTVu?=
 =?utf-8?B?a1RodmU2OFpQMXA2QUY5Yml6bUdycnRqa3JPNFltQSt4clVQaTdBUjBRbUt2?=
 =?utf-8?B?OUlMWmoxS1F3Vzg4bTFVQlkxb0tUWXV4MkVTSWNNRENvODlJb2xjYW5NTVNl?=
 =?utf-8?B?STJabkxCNmZrdU8vVXFmSnhpaG5sT2d3c21UQnlTVjNDbjBrQ1hKREpuNXNY?=
 =?utf-8?B?Vm9TYjNUdDlyOFlrU3FWNFpOSkJSbU5RRnBDMlp0dzlZNHROc25WWFJSVmEv?=
 =?utf-8?B?NUtZNVdaWFZLRjFzQzh5RDNLZlAzc2hCanp2U1dUdDNnYmhSeXJuN05GeWJ2?=
 =?utf-8?B?QjQ2UmdvT2E5L0duSWFwVVhLSXdwQUlXSEZBRGU1OE1mZkU5WWlKQnUyN3d2?=
 =?utf-8?B?MmRYalZ3SVVxclpzNXAwa213UFlTNktoSktBV202cWdqZ0F2OGVOVS82TWdI?=
 =?utf-8?B?aUdwNUROWGp4OVVWaWNrSTRob0VhMFc1d2JOWjJHWTNVTnd1NUZ4R0JVWi9D?=
 =?utf-8?B?U3lTUGk1T2xyMDJ6dzFOZ2lMWmRzMjBDc2RqakNLRVpTS083dldvcEg4VGd0?=
 =?utf-8?B?ZXQ1YjdjTTNDQWhvZ01NK3NLbkx4VWUxRGhCT2xobWhLWDNyMjZscUROd1Fk?=
 =?utf-8?B?RWp0dXRMZ2xOeDFTdlZXWHRJWUZUTjM2MEoyazlQTTUxT0tiVEZSMEdhTHkw?=
 =?utf-8?B?bElKRUQxSUFnaWo1dEdQUDlEYWhkZDhaK3IwdjZNVHFrbkZYSXpXSUtUQWgz?=
 =?utf-8?B?dXpiTU8zYm9kQnkxcjcxQlJiSEtZZm9XSDBaTFY1cHlEZU1mekl2VlhzQWUw?=
 =?utf-8?B?MGxvNkNqc01ZNEJlbHhFL3E5aVNMU09iYlE2alVRRXhsakdRbDE1c1JzVkUv?=
 =?utf-8?B?N2VEQzlWbkdJcnAzNmphbzJLYnNRQk8xWU9aSWtqLzlDelhGMTlTOUQrR210?=
 =?utf-8?B?TWdnWVJETkR1ZjFKUVRCNmNHaE1uOVkxSmJTU2ZPRGErSnFiYVkyMlBFTUJu?=
 =?utf-8?B?STVKcHhPTFRKZ09xbXNnL1BmR1RHYjhPaGgra054akV5eHZ5TVdDY1JFTXZS?=
 =?utf-8?B?U1I5WDhKcnVteUQzZU41d3k3aWZQZThUUkVQQkRTUHgxVTVjK1RqU0ZZdDhw?=
 =?utf-8?B?ajNLYVBXelBQaXJ3YlhMR2kxTm1aRkU2VUJrdGZIQm9Vb3NZZ2RmcGpTS20z?=
 =?utf-8?B?M1lYY2p5dGt0Q3ZYMzR0ZExyK0JLU1N3N2I0MG9CcUJMQ1B3ZExSVUFaazEv?=
 =?utf-8?B?VTMyUVFETitSSE9ZZTFwamZraUVXb05BeG9TMzJrVFRnUmFIdGFvZFZjaXA0?=
 =?utf-8?B?RjVQMUxsS1lxeGlRdnhuMjVlUm05QUlIQkl0dERXZlRhZzZkcXJpTHJ4RkZN?=
 =?utf-8?B?RVNCNE9samZFWmNRdndaRGtPVHRGV1dad2V1Q2lua0VDaUZVTGFRU3g1c2g3?=
 =?utf-8?B?MWM4czJDTXlqUm50Z21nN3FySThabG9OOGxLSjlLSmZxN0VHZnNBanl1WnQ5?=
 =?utf-8?B?V09DS2lmT2VIbGRpMVVCd2czT2tFWnV2YnlWRWJqSmRiWUsxWHpwSmVvTGEw?=
 =?utf-8?B?aVdiZnhWUXd1eUFROHJKNFRIeDVTZDJncHdSVnBFSktSZHhSaERxTWErRVZN?=
 =?utf-8?B?dmF3Z0hYZU4xWHMvakEwSU90OUorZGpDZGZSU0c2N1kxTGtqaGVGYU5IYUc3?=
 =?utf-8?B?bHVGZlBuL29Da01KVnREWFlyOFNPcitVQzJqRVZSdnlhZXVNbmdGTVk2bURC?=
 =?utf-8?B?b3ZuUWtvQ1JEV3Q4WHlkNVd5Z0lYZjNmMmtYWVBteXRQa0hUa05lSk9KRGRJ?=
 =?utf-8?B?c094OVN2TE9WZ0RRMm00Ylp1MU05ZSs0Sit3azk2QW5Zb0g1Z0lsYTJzUlNj?=
 =?utf-8?B?V3FSek5hVERNdWNueHdGbW5qZkU2SitFc3ZaUncyaXFuNkZab2tuV0RWWWhP?=
 =?utf-8?B?MTJtMFltTmxTUVFFdEVpK1A0Zy83S1hiVXlBanlsUGxtZERFQTJzdFp0NERR?=
 =?utf-8?B?TzBRaVljbGNXYlhGcDlxOEphZmZBZUpxMG5uZjJ2NmlqMFNvSzkyMXNCdCt1?=
 =?utf-8?B?bTZndmFzQndhaXpEWjFSUDkxVWZGejJYVi9iWU4ybFBHVGVyUm1UMEg3NDFB?=
 =?utf-8?B?d2NyT0pya3RuN1dwaUk1bHdVc2ZMMzdkYmZHbmE3SnRkMU9WWGJ5ZG4rVldD?=
 =?utf-8?B?akFYREhHTC9oTGZzcjF6c3ZlL2VlQ2c4dFpsL2Q1UGIrTmN0SnRWVEFwbTZT?=
 =?utf-8?Q?nuqPC2u0swkTUkM3V6ePy4rJC+iQcGak6tuHb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GwX7i8fG9yNbz5+Inc9ZmeDeubqwBq/bu8GfwRfKXwRM6JNHU370P2tMOZJI/ROFL0nkoLLXxz9190gLsn1M/7KW3p6Z4ZgepmivmCxgpc8Uj/ZyBJyrpS59cb78WQY9XL+tT8HgmwKp4jlIKmdgGGClvgvulNjWBf5bu3In3UeOK4TAsT9HDBInHygOrV8HfP1JJ3l9GKY4H14skmWr7bzmovFyfxMCIoxgMiLSTUss9nlkoRGItzN8HMiiHMu5ggYNbapJoVJYE2ZQZGypyz7K/6ywp2jnwwjUTo97MRRIgX5GCAiVhaF68VTtw5XrkrEgOvg6NxuEakKvhoa1QlaFVMqQd28M1XZSoDb1z5GQ7aORecjGi3FmWg5VA4OvNokLI3PN3fO4CvYU5Dh2Q6SQUNDBnonuZqtAi0BSMZ5bBtBqLc8PP+l376SDrfma0Ua+uY94O+gQ420UY0Pe76Q1thQ3Q3flvy70qFYMTwtJ1OAjafjlvTQzkO9IMvbl1sNSMM++/Fk26wQ0OS28dVE9Y1ygK96YpJYqeTxdTOSnt82aTAdYhCYDK/koVXrthEDFXe/URTT/+mRA//HUdHOZf+Ii57m2R1Zs+tm7XOY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828417f1-c44e-4f83-d57f-08de630e6b50
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:24:31.6670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXbUJIx/TrexDFp5IWCS4mYZeKZ+/qjWwqIcPoPc00lK8LHDBVuS4mayG2J1/IXIiC9PGRs5VATHXLI+aojO8deRqrcoMMrHzpfTvuK714eNReFuZhWWSjjK3RDIk3rh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5934
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602030082
X-Proofpoint-GUID: 50Pc5bw_VXG-Jpgmihxcs3lbX2Q7iTLG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA4MiBTYWx0ZWRfX1fJp21BpIkGd
 7jxaibWf+lmUcEsZlH/9O2MXeoGeGN7ur6Z0syfFj4LkBPwz5Hdh0gRyeL7zR4wtWctx/Zslx3a
 aGx1ToHI1z3Czl6264q5w6q8ZixAh5e/0JqGNGrABoYkM2uWHmCPKqc9FVwG3HQm1br0hHjDI5o
 VCt72d+C7F7CtER+Ziz/f3bGXfWLS1fEJkkS+qz7Ld/4c1wE69E4Hk9+wF1CN8EUuMvTPKn0fc4
 JLMOwpUo8KS0a9ksKdeJXzags8DhSB4r+qoDPFaFbXc3GiZcQpNJdH3Geyky9EZNtU3xncnMgwh
 MnTEM6PyahXIg9MLWCQLIXEE0jVk6E4jr6mcVQVVAS6zkZ49prWPQfrMa+Fi3p1cs4Rlo98zSHS
 GYHNvPBuaNI3h2exHqECFVj/hcEtkfs1noE1x7haFtAILn32awm4isH/1ltlzOlbAdGwzigKuiP
 BkTH3HUb/tt1+pYdyEstJ8IDU/ewPiH5RBrH/Qzc=
X-Proofpoint-ORIG-GUID: 50Pc5bw_VXG-Jpgmihxcs3lbX2Q7iTLG
X-Authority-Analysis: v=2.4 cv=IaqKmGqa c=1 sm=1 tr=0 ts=6981cce3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=hgaxu-HfiBkvFUVaSUkA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13644

Hi David,

On 03/02/26 04:31, David Lechner wrote:
> On 2/2/26 1:40 PM, Harshit Mogalapalli wrote:
>> Store the spi_device_id at probe entry and reuse it for the name and
>> chip info instead of calling spi_get_device_id() repeatedly.
> 
> Even better would be to replace spi_get_device_id() with
> pi_get_device_match_data() and turn sca3000_spi_chip_info_tbl[]
> into individual structs that are used directly as the match
> data pointers.
>

Thanks for the review.

Jonathan also suggested this on v1, but thought of doing this item 
separate to this patch series(as its a functional change) , would you 
mind if I do it in a separate patch after this series ?


>>
>> Reuse the local dev pointer for resource managed helpers. While at it,
>> reshuffle variable list in a reverse Christmas tree order.
> 
> The dev cleanup sounds like a second unrelated change that can be split
> out from the spi_get_device_id() changes.
> 

Sure I will separate dev cleanup and device_id extraction into separate 
patches.

Thanks for the suggestion.

Regards,
Harshit
