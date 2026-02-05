Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C262814A8B;
	Thu,  5 Feb 2026 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310857; cv=fail; b=FJBquYv5hR+mY4wYIjNX3yuv0KOu35SR/EPgSoJQCEtWipFcfctc/gelrN+dIpU3uBpUP2olR1QLWsnb7sxsk5RpQqNXJb2fqzmBvmAlyui9XeTmlslKgadA2TMp0I6z4e3ZzuM8rVunubtJ887eSPcR+XUYSNtCta7f02GdD/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310857; c=relaxed/simple;
	bh=XnoMPnGNwN6MP1BkMk+KWrblOZTCu3aQd6S5lJtU/m8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FHsVduAkZf5X1XuUWpMX8a0cwP2rTVgj9YBzFHT9KivFqCixKZclwwM+udwPs4RxjvyFmseMObCcOEnb16ZI6GRkB+qqJsv8yqfMBjahf+XrQym/NG6DpXOyADztgIJ7a6wIi1bU/J/loc99YN6WDYgAG0Zj+ja6bqtzv/oYA3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y1eRUcnf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kQgSPTdj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y1eRUcnf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kQgSPTdj"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615FtvtV1718792;
	Thu, 5 Feb 2026 17:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=b9bJ0L852Z8a5laSGml2qAmzd8pb7eb5wlOmcljKOxs=; b=
	Y1eRUcnflo/khSHngIlMCmpNwG9T6ZW+pq8SGWDGRayRavK+/HUF2HoEAJdRl1sV
	cVK3xt7CLgJ1Zw7X2EGsQkq9MM1vER9l915IsCDabKO+il+R0MyJmdkuU5he3N5e
	1SLAk+qBumuHnfAFRqXS1b+KczLv+7HJpjGCmZctI0wr8M12/UrfX44BMm/NzwXX
	u0SYv0O9Qvo3woENrf4fkpRA/9LKY4tEIhpib5T1TJPTu6wqZxdDqTvTXJDHtm1m
	yz4gwaa823/OC8yX9f+JjaATpl9F4BWTKs81J90KG9nWFcokdpsC7+Dgzb3Rozyu
	+6CBpcM+2aUpUoz+iSTheA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jsqm28p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 17:00:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615G4mMr003364;
	Thu, 5 Feb 2026 17:00:44 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186df0bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 17:00:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O91FOeOMhd2eWHTYGHUPkel8FrMPJ5g16R4cb60syLbOj9mzUNtp7xdAnHo9vQfywjlbgubKbG7lDczYi3uP9QnpumZfC1ey/oe1gddZpnqStSWWtWYn+It/IUk4TWyHTdH+3FE3h4Y3kRtUJajgOjljvxRJ+oN7f7zCd6Ygz7pTm2j5sQT1mJgSQBF/mdIHdF9UF9YR5+ArAoxFy0O924i4bybHPtNi1NVV64XIr4fjXIz9jB1UGXpFCH6uBlkwqpVSPVAdREjAjvvOuiSvVEPCwkTpww5NiOjFDxgxxOufTh5H3Ijpixs6UPiCOU2kr+mg59pCAABegKv4WWDNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9bJ0L852Z8a5laSGml2qAmzd8pb7eb5wlOmcljKOxs=;
 b=h3bwH/RWK2GERUUOUzrkIb0LA06OYtVjAs04mhzHvPWKB1ysJrueqxsoADztt6UasY46zkzF5PThIEocrRT5tx+fd3ZK/XqZQgyAJP8SKtcXj4z0+HVwhynDe41mgYhtzKw1vg/My0uzzo7ZCBi7Q1iJ5ZhXtTJt83uCSoB4vWXEWdU99F7E8+LHo6+bxOIBE9nYh4GKlTfJOQ6NkEm8s2sWg67a7HklttGmd2ZVVBTmfTeE1JlNPp8vrRomtOIQgrB4/BRGzFgeodvxFSYHcdrd1U4rT0JGOG1/jDfSwr7zrTz0uLMOr4D3XGplse64YvxH820horbkWOatDu5ISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9bJ0L852Z8a5laSGml2qAmzd8pb7eb5wlOmcljKOxs=;
 b=kQgSPTdjEtwIiuSc7Qi3RMIB/ACr8oAoDb+VWBcCJV1QnhKwIzH/mLcHaQjkf44OKH7Np1pfasdNg+UmGm6I54x7fgLNDKUXu+rpKG+UQGDulneuC2WCwQxg/3RkMx3XlV4qwxvRPm/KgTieN30MUYuYD4DYfxrmtGMHbofeMeo=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by LV8PR10MB7871.namprd10.prod.outlook.com (2603:10b6:408:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 17:00:39 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 17:00:38 +0000
Message-ID: <437592e6-460d-435d-bd83-7ff8222a6130@oracle.com>
Date: Thu, 5 Feb 2026 22:30:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 next 7/7] iio: sca3000: manage device registration with
 devm helper
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
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
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <CAHp75VfSYGoNUTqDb9WLYNYeChkB4mM+LEBpyRVnLOEKkr==WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::12) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|LV8PR10MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9b5c79-e399-487e-959b-08de64d816a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0YvY3NQRkxhYXNpaFViQ3lmZkdvZ3FLUDJieVVYanE1a2kyaUZ2U2U5ajha?=
 =?utf-8?B?bktHVU9NOUdrMGRtQ2svK0ZpT1VNdGhSd09uQWtiQUlxcVRFUnpyZW9OSGJv?=
 =?utf-8?B?eGgrWFk5dmNBOFI1Y09zLzZwa3Fxa3hMM0FXYnJFbGNvM2ZTMEZXUUd1TWh3?=
 =?utf-8?B?c25EL2ltYkorNGs3K0h6OGZQenZRQW1Tb0liRVVyK1hXRWh4UXlyWGExeXls?=
 =?utf-8?B?R0xTSG8vdGZsSEovcEtPYUJneWFqcWtreGRRUEdaelFoeWlOQmxVNmg3cWg2?=
 =?utf-8?B?SmpubW1nUS83Sm9RVTdablR2TFhSSlNDdjZlY2V6a3RFSXdMcEtlbkdLMHZW?=
 =?utf-8?B?SllHQ2wwbUlKRG1NUFMyMlFCTGFEVy9aMXFSQzNhVVd6djYwTXpaMFVZUDJU?=
 =?utf-8?B?eUtPMld4MWwxWHFhSExxYjJQeEV0OXFGNWZzWkEwYjE2RW1pMDY5alFxU3FR?=
 =?utf-8?B?amJMdjh5UndXd250QVZJa0xLUGE0a0pRc2JlMnNJZndNeFprdWkvR2lpZTZk?=
 =?utf-8?B?REtFNWkzQWQ4VTJ0bnFOeW5UYUxKSCt4YW9Rakt3VHVGSUdaQWl5bFJxSjRk?=
 =?utf-8?B?bTRlbkpseVlEVlJaWUtQVndDM1VRcWVoeE1YdVRRelZKVjh0OGI0OHd5MjNL?=
 =?utf-8?B?L1dlQXAxck90elM0S1pkb25NWHB1NzVpZ0F6VmNJTDJHYnR1MWhyVlNJRUM4?=
 =?utf-8?B?WHFURmdDcUMzVm81Ym8rcXBja01QOC9xZGp1YktPR3FtSnloVUl5TlhCdlZC?=
 =?utf-8?B?a2V3ZmxidXNETGo4L2llUGZVUUhEQXBSMjQxaEcwZWdnSW9nRFE1S2x1T0Y5?=
 =?utf-8?B?S29jUWU2WHdQdmtielpqTHByMVpGTGdtWVpwaURyYkQ5enRqdEloaElNc2tB?=
 =?utf-8?B?TmhObkJoeHhNYmovR2lzc0ZpUkg5RXAxRmJmcDdFQVl0b011VEtSOW5zQlNU?=
 =?utf-8?B?Q2drOXIrcUVPbGdUYXZVcjNVR3h0dVo2NmhYanNOTSthK3VGcTRlUmp2ekR1?=
 =?utf-8?B?ZXlsYnM1NXRIODJLRWZydUEzbkFmZm1uMy9JYjZGUEtJamlRZ0ErR0ZpajNk?=
 =?utf-8?B?U1liNkxtMnFwMjNFdTdZdllya0RkWllCb0pPVElWV2xpZGJlQzdmbHdtb1JV?=
 =?utf-8?B?YjdiQ1ZqcnFpeGpUZVZmNzNJdER0aGJKQzIza0lQTjJnb2ZRN2V5bmdzd3hU?=
 =?utf-8?B?R0dZTXQ3Sks2dW8rSUJreEozTkRIQXlWMmMxbFRWQzEyV0tsRWhtRThDOUw5?=
 =?utf-8?B?N3dDYWMzbnBveVhtNmNpT0dVTmx6MUZzS3Q3bk5FM0Q4MFliSm5aeDlIM1V0?=
 =?utf-8?B?cWtLZ2FiS2JlMEZvVWE2aHNCS0orN0gvWkU2YTZVdGg5bi9YN3Vqenh4RDJ4?=
 =?utf-8?B?S2RNUjYvYkZUdlFuYkN5TllsSVNMUmUwWkZiZUJENUliOVRINk0ySmFWUFpL?=
 =?utf-8?B?TXEvdkI4MWNtQUsvRWtvY0lsZHhRcnZsUmp3N0l5ditQVUpwNlBRWUJpNVVr?=
 =?utf-8?B?dE5PUXdySzc2aVoxU2h3aGhqdEpTYUQ4ZmswOEQrVlkwZml0c2xOVG4zNkU2?=
 =?utf-8?B?RTh2aGNWNnYzaG11blBVRHR6SHZWQUhXOGJNaTFGbG1zb213QTQwSEZkSE1w?=
 =?utf-8?B?WnM2SndxRmRwckJWdWpWS3BsTUIxVlRzREZpYVJ0UlFmcWVpbURpajZ1Mlla?=
 =?utf-8?B?NktnT0E1YUJPRUg4VkswQTFEb0xQRmxrOUNiME1ncFl4MjFTOGgwb1hMQWxD?=
 =?utf-8?B?Zmx0L2V2ZUhlWjhBYTJLdDFIWUx0dzVhTThIWW9FZ05iUlRmbGN3bCtKMXkx?=
 =?utf-8?B?anNISW9HN3l0ajBsanNmMXNvbEc3WTlCUjBuQXg3NUgzalA1cVNHdUxXdEd4?=
 =?utf-8?B?Y1k1SW9aalh3RFdwWVBsQWUrZEZnd1d6VVFma29UWmt0R2NXUTBwb2VUWGUx?=
 =?utf-8?B?a1VmWHlQTlJoQlVEckx4eEd1cG5mNi9ONjRHNUIvVm0wS243THIwSFJqTnYw?=
 =?utf-8?B?eEhkaXoxUlcyd1o4NUE5a29VeExoNlpxRTdoMUtodnN2RVp5SWtOcG94QjFv?=
 =?utf-8?B?SFJUQ21TemRBQld5Qm1KMHl1OTFlTnhUQUc2dzdmOEFwNzVnVDFhWk56ZElk?=
 =?utf-8?Q?G9S8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmZ5bmdQcXlNY0Y3RGswUHZrMFZDbU5rV2ljTk5UaHdRSTBGQ1F2U285Q0Vt?=
 =?utf-8?B?eElkOWcrUFlaVkEwb1Fjb3ZQVyt0dmlGcDZqaWYrNHBsOEhzbmtJbEprT2J5?=
 =?utf-8?B?UE1ZeG1TeUJVSGZqbXRIaE11ZmkyVUR3eEZUUEk4QlpMUk1RRy9SU3J6Z2g2?=
 =?utf-8?B?V1N5RGwzMnlJNURYay9IVlhQSE5ud0RUNitNa3k5OXR1cmY4Q292NjVERDVh?=
 =?utf-8?B?ZENWd1k5OVNLOTU2aEEwSlpxRktKQkI2REhoVkV3Q0o5Rlo3SXQrZjZGYis5?=
 =?utf-8?B?eEd4cjluTFFpM0ppNzVFR0pBOEtCVnNLL1Vha0U3Z2xxby9Yc3RkUUtZVTht?=
 =?utf-8?B?VTNlck9SSm1uRStYZkV4SE5RZ2hzbW1BUFVSMXZLeGxHdzZzeFhJTWljazFM?=
 =?utf-8?B?dUpJMzIyc1pDNHUzamNrdmVyYkZaUCsxSVpUOXdxbjV3TjhKbndPakNiVXBk?=
 =?utf-8?B?cFFJSGpkUzg3N2UrT2RTcHgxbk1vTUJpcjlBRTZ1ZTZjTjJDSWwwbDJPQXdi?=
 =?utf-8?B?MlArNVZOWGJuZE53WkFkUmovUDB5aE1rMVg3bWNXVzdndlFDNUZOM3g5cEpU?=
 =?utf-8?B?UGVieG9uMXYyaW8xelVxRlJaZFdvOFJ4NDNRdkptaTVSNmdHa3R2NldDbXYv?=
 =?utf-8?B?NVFhU1hBYzhKdENaY291MGxDWDZxcEdDK0IzVnpxTjAyWU1pZVBFR0RnY05j?=
 =?utf-8?B?YXFPb2dydjVIbVBPWXhxUUlaTVFXL1RsdzZFby9TNWtvSU9GeUVUZ1BrRDNM?=
 =?utf-8?B?c3VxS1kzU1NvdjUwcEVLR0xuenlMckVGUjBKRTViaXNDT0xGblFVNEFtSFhw?=
 =?utf-8?B?S3pwYWdpRTc5UTFlRTdpdXBheEhUOXFIRkZOTzRCaE0yR3hJZCtmd0t0V0hX?=
 =?utf-8?B?ajAxY2duTTlzblF3WFlGRjVkT0djaDdqU1BqN1ZmNU1uYWVYL3JKZTBZVml2?=
 =?utf-8?B?a3NGWkhiQXd4b1cwRWpudnBrbnlMRmFORktVbDdjZ1Yxby9rclp1RHhPaVNv?=
 =?utf-8?B?TThPTmtNZlhUbElvL3hmcG80L0xObzNrWDhUeFk0UndNWm92MnJXRUxaRmlX?=
 =?utf-8?B?UWZVc3B4RjhNSE5sTDMxZFFvaEt6UTNxaVdsRGNWTkpqK2VkbDJ3RkVuYmZo?=
 =?utf-8?B?TERtNUFQMHQ4K3R1M2Q5QUNYU3ZtMmwxcXcrRG9oYytCZ1Y1MThMVDJqNzBK?=
 =?utf-8?B?Z1pKVTkxdmZXUnNjSWNHcXM3ZHVXazBDQ2dMWFVNWFQ2ZXRQUkNuckRQK0ho?=
 =?utf-8?B?allXVzdoTzcwN2t4T3FjemZ0VEJiMGZMbFBOZURodnA2QnhXNURYNEwxeXcy?=
 =?utf-8?B?OFpkSGRpbk1iMW1wayt3QXY3UHZrTkZvb21wNkcraHdxNWc0TkZUTzNoL20w?=
 =?utf-8?B?Qkh1UGJ3TDk3VEtNMytFNEp4bTVsZzFITGlhcTY4VC9DWDZycTJzTThBYzVS?=
 =?utf-8?B?QzNLUzlSUUNSeDVya3k0WkJIaU9QUkJrbWh5QmppNVNSTmpPTlQ4cHJXVnNY?=
 =?utf-8?B?VTZROUE5SHppQ1cxbFNUSk1aaVhDNUFRMlZxV0N2NkU5N1greTVLZFQvbG9G?=
 =?utf-8?B?RDBGTlFQOGxFSWtXamtpL1QzYzVkNXYzMTdSdFl3LzdxZWE4Y3N0ZFNBZUZn?=
 =?utf-8?B?Z2V6QzdwY2VGaytxQ01yRE10bVRhM0Q1MmdqVHZJOHVlRFRVanJIZ0FRcHlP?=
 =?utf-8?B?ZnNqSU1NUlE2MENnenZ2TXl4MGNNSHVvazZsOUZRM1ZtNHcvbWxFbE8va0Nk?=
 =?utf-8?B?NTI3dzJ0NGhSN0VUcmxZeERtelBac0dMZG8rdVdMSlZJdVdqVFFQQ3hpTTRU?=
 =?utf-8?B?NEJLMHVZQ085TFJDR0l2WEJxSzcxc0hQdFJDM2NleWVsOXdQVkx6ajdIOHpy?=
 =?utf-8?B?VXdMSXNnblpEaW9jTnZiVlNSa3B1bnlTMllkb2NyS1pLYUxLcWUrUW5uc1pU?=
 =?utf-8?B?WGZ1dVFRTDF1aStUOUcxa3B2Q05peFRwY0poSndUVTZ2eE5kUFMvMkNScUU0?=
 =?utf-8?B?N3pXdTZXajk1Vm5YK0RNQjM0dnYrZU1Fc1hzcFozbWVGeGpTQmtFTU5ueVBa?=
 =?utf-8?B?aExvU1g1UXlLZWU4cUppanlZZ08zUm5oelZuaWN3MXF4bklKV0pXektad21Q?=
 =?utf-8?B?ZnN0eEZ3OWFkaFBtYzltMnNqYy9IZGhPR3Z0N1JUNFNrS3dadW5qZFZXWW1B?=
 =?utf-8?B?ZHJPTHc3ZlpDeVR5cWFDUGxUL2lXcmJRQVhkeUJuRlZ0aGNlQU5wTXFmV25J?=
 =?utf-8?B?SlRNVlRYcWhiejh4Z0hGbUd5RHZtZHJkWExOMVRlRWd1RFNITDZzRW02dzVX?=
 =?utf-8?B?TVJ1Q3FJWjN0SHlvRWUzWEI1SWhNaEpITWRXeXNQVE9EMERQN2JhUXZoQTN6?=
 =?utf-8?Q?4XW4XHM1DDCpveLuJB3tyQcUjIhITy21bw2p/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q5UrNobAPxncXykqLOq6g3id3t6puIhMyHYepNoJx9jhJ085WaXEs6Cte7+jRFO5dCNHgZvsB8TEUf/4V1xoz8qYunT04SV8pS80PujbY1W7J+e0M4+2feFMjjHs9wEjP2Ar5n867AimnfWHF/mqdfJRq3gf8FG6qRyX4mpjeWsF4qGJuHuz3A1X7WXOjxqY+58+UiHuRJUt3gYblXGY9NITp4sc7CrNON43i0RpkzgqXRlXpH1FlfuEQradYNuqyqYI/0Yh70B4s9aNORk/TrXjHaGMsJ6FF/NjvzLQIOjJiCiGgB/IdTByP6tE8iWgtsMGrcbcrSGUPWR3ER56dJfmqAXTthI5J3IFtzOh/VscuKnp4hQcw4I3YE0oEgstvOjIIgwmNYU7lTCiS8FOBG9NqSihS/9rAINZQyggXAKN8ekdP4s7Q2gqX1GIHtRGL9yzWfKQTPbSjq+jYKWWu3S/iWa7K4ibGJ/36vpyp/AP+b7y87fcd4Hk8FG6+DYQ2tV7+DmH4Yt8AIPwac/KFBeHit2EdZzDvuJu+7iQHEB5Z5hNcSxit1Q54ZOi98WHPcBchqI/cz7qYkUw8yygy0+/qMogMTTPIFpkoUS2okM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9b5c79-e399-487e-959b-08de64d816a1
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 17:00:38.9391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVMC1FiFqCKbMlLudHbIcPniWCpSVCStGHw1SThbhr12sRyF8ikdpIdXnuID26akQ3lQr5FvThdjTsLuGCeApxPayYrvCyG1Cn75umXMI8nE7lcruZmG5fwVtaZxZQBl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050129
X-Authority-Analysis: v=2.4 cv=Db0aa/tW c=1 sm=1 tr=0 ts=6984ccbd cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=yPCof4ZbAAAA:8 a=tz5X1R8OnX-hZuc3I0AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: DFm4BrpppMBS5G33XC6oGP6W9pUANw-K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyOCBTYWx0ZWRfXzkiFzL/JJo/7
 mgOWWn5j9o5zjyRpQsk/nuPTuVD+wvaI5mIuGLaM18ffdr21HLvit4DOnsNYPFUYN2l4bKiad/J
 pM+WItdxzYegGhnW7vTPSHXnV758EiGP9kZPvLn6z7sVdzpBJjFCwtvkaMCfkeDXo00VvccWPjb
 u675F3WunRhgHJXBhU//V55xab7+sqiagRWesGtje++fUXEcsPsz3bf1O6cJtalV4xiXaXoO/WG
 O575FlKeiXhBGaX1ezU0iFzJEe7SgS3ElISGP71XfFu4drvwLjpW1ZwDjKa+3G3dj3xRllDFR9I
 Q9D5Fx7r0Ut3LrJ7hozE52YNcTzUGHNs1TthMY6Xt4o3FN5HZM1brIAc1qwMNSILfSzrDp5Z6n4
 kN2+vdad7+eisA6i7Ia0NuvJw23Oh0Y+BGyDPn7b5LNBEUJvW/bk3bVwtGLsvFm+4I0pSkX6ril
 iU2DWyatvUrpHSTUIxg==
X-Proofpoint-GUID: DFm4BrpppMBS5G33XC6oGP6W9pUANw-K

Hi Andy,

On 05/02/26 22:26, Andy Shevchenko wrote:
> On Thu, Feb 5, 2026 at 6:51 PM Harshit Mogalapalli
> <harshit.m.mogalapalli@oracle.com> wrote:
>> On 05/02/26 21:59, Andy Shevchenko wrote:
>>> On Thu, Feb 05, 2026 at 05:12:13AM -0800, Harshit Mogalapalli wrote:
> 
> ...
> 
>>>> -    struct iio_dev *indio_dev = spi_get_drvdata(spi);
>>>
>>> Do you still need spi_set_drvdata() or analogue in the ->probe()?
>>>
>>
>> That's a great catch, I don't see spi_get_drvdata() anymore after this
>> series, so yes I think we should get rid of this.
>>
>> Should I fold that into this patch in v6, as spi_get_drvdata() is also
>> removed in this patch ?
> 
> Ideally it should be done in this patch, but let's wait for Jonathan.
> He usually may tweak these small things when applying.
> 

Also, while checking the patch now, I see I copied a wrong tag(RB with 
missing r in baylibre from [1])

So that's one more thing to fix. Let me know if v6 would be a preferred 
approach, I can do it.

Thanks,
Harshit

[1] 
https://lore.kernel.org/all/a5fa2f97-9ba3-4085-bfaf-a255d24a81f0@baylibre.com/

