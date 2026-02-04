Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99CC3A1D00;
	Wed,  4 Feb 2026 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206810; cv=fail; b=Gh5fu/F/JUHHyZrkh1ljXH9ZVvrFKAx7HBAxjCZlYKL7+2Rv7cnhuRyi1rgajr0mPjffMsTFX96zAWleW4YR6AIDjWxQmvyF9kM60XLJ2m0npLm8gNDikDddQAefowgZKKLEoUeEjX6GqrwXVYH0LvVLiiTiFMkEtu9xq4D6+DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206810; c=relaxed/simple;
	bh=WgIineFc740lkjUpghBreYFQEx9nH4VcO9Mpnt+DmFg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BCtbQE6QuhbnqpFLXdQx+Cgwin5kf2c8Ue2BuFUk3I4hImXCZiF3KDMZtxAlGghET2RmX5fyuPqQ2vWHOI7wo48KAGmrzJJj4oyJqlwZ7s/Z4/ROIwVdMHKLKiP5FirHzhCv4N1eDYWABEXeRFBw1mPYEkCBlwwatBLkKez8NXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rS++aPYc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QjeJ/nzo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rS++aPYc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QjeJ/nzo"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614ADDBR4161656;
	Wed, 4 Feb 2026 12:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/eAQCnTZh+vchp3bZJQQLPNEijmfiVT8WFqZuNs86WA=; b=
	rS++aPYcFpNoD8ghxGdQBjPROaGukFT70x7h+C8+iSkJSqaDR0YVCG9ZH/JpYTCE
	xmi3278cZTgCstloGq1AccsufaBy6xedUuFjxRtywKAWB3NLqy6cMcynzQf3takF
	O9D4fJ5VSfS9XN93OQEggQNWD6fxOyOvtRltHVWWS9U2NVWDz061DFi06WKOBcfe
	SS/2yOLuQ3LMvJY2qOyUyG9p8qKTM0tkjYCm/bEDY3fFbt0KWOocue69BUHK1iX8
	oSipEf+vEFxpR1ESXjbG+7nRNHym6nGcOfwMf27FBGAEzMtIqaL6JSGVJGKD1CJZ
	o1AanoWvE+QM2BgRJ8+Xrw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3j8uhr47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 12:06:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 614BAbFC018768;
	Wed, 4 Feb 2026 12:06:41 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186nvhsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 12:06:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxeqBcHeflPpV7Pwby5mSLXPbRbX+/05+M/pkIezpBnrl9+orgifBMZdq84v2b10bT6RRCgdDo49lgTKWqb7WIACbTd77p2EAVnQYOlXwTOQ5QRVSKNcs8YfALmghRMa4rfSYtH1aHgfvH4iQFZ2LgQikBRwGE2r2+1zry9UcjuOCkfTIICk0qX1JQnirO56Ei6tQ0xqa9nW6NalDBMJtvT+JTAJp3JZ3HI8ZzM1YPG8fuPeSbCQ5MyebymkpK0k43293e7JnhWb1x3j9BmEHzKPIipkBfP6HNztLOkC1pea7XajJqrACNQU56OWvHDIHkUPd/c5Pu9KyM+a2yVGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eAQCnTZh+vchp3bZJQQLPNEijmfiVT8WFqZuNs86WA=;
 b=rI3unXGy/IH2GOQPwhXAGajXK0dq4EzFDbD418kEmUFI9u5k7Zke2w/bFLtxCCgzTwIjUr7R7bB4BgmwNtRa0vlHQ2iapoxHS40xrZ0nsLR4JGO3A86tsUUiW0bIfIEjgeJV/Ic4gGO1ALcuXGPlIQmpVQtkBkRrwB/51215C1hOQ4dhLNaooEDQo5rQfwug8V3Air1FgEtzj7DC7Jhn64uwj4oBOU65WDie70VjnzD6Q+diJp11nGtStCqMDluWZ6ryPrXie9wQ8d3Vqp26IzPNUmtdDHx59zy0+R9+mXbVfCxi6mwFH8L/Qfi9aV1vgFmKWlQKU35BCqXud+dbYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eAQCnTZh+vchp3bZJQQLPNEijmfiVT8WFqZuNs86WA=;
 b=QjeJ/nzonc4bz58gtgrUNl4VgcQrzZ2CcKgI81mcXTHLuvXiIxftvkCuUmuf2wX6yAhAWjlNbESw+ylD2eDSN6bOiZUdvUMyhoIsjmVJi/gHUWYoPWRBmM4+zOkq7Qhp9qlYI+lRjOClcFgD+R4Vcz4kqGSoNDS+ld1wHCP+tCg=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by IA1PR10MB6711.namprd10.prod.outlook.com (2603:10b6:208:418::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Wed, 4 Feb
 2026 12:06:38 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9587.013; Wed, 4 Feb 2026
 12:06:38 +0000
Message-ID: <046db6b8-7daf-4bad-a24b-974894e599ad@oracle.com>
Date: Wed, 4 Feb 2026 17:36:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 next 3/6] iio: sca3000: make stop_all_interrupts()
 return void
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20260204061219.791037-1-harshit.m.mogalapalli@oracle.com>
 <20260204061219.791037-4-harshit.m.mogalapalli@oracle.com>
 <aYMLeAaQm35-4Sgl@smile.fi.intel.com>
 <6423132f-37b1-4db8-a654-437804b2f31c@oracle.com>
 <aYMY6AHtc45l4kb3@smile.fi.intel.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <aYMY6AHtc45l4kb3@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::13) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|IA1PR10MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: b75cebfd-f854-4ff9-2cd5-08de63e5d952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXIxK1JiZGVvWXY5eXZEQnRKT2JQN3JlZnZLZm5LbFhTN2h0Z0tkYnFvQjVE?=
 =?utf-8?B?UVRZRUJhSzNNcG9NU1Y0cEtDMlRjMzlacFcrVWhZa21SZjVWN1A2TDJaVDYx?=
 =?utf-8?B?Nmc2N1dqOGg2OHp6STRjMXZTYUIzZG1CRm9uVC9vZHF0b0wwdVo1TVozWHUy?=
 =?utf-8?B?bnNQdFAwS1dIRGpHelY5eXNzUlJFdERoTThObEdtZ3JRSWIzRitjejIxdWdM?=
 =?utf-8?B?QVhURzM4QmNHclI2MEtxUDhCSFY2NE56a3pMdXFNTHI4cnZXMEIrSkplOFVz?=
 =?utf-8?B?MnVRdDlURldkRTBZYm5sNWVtTk4rMk0yOEhROVNvMWwrM2xGRmZQUkhjMzNV?=
 =?utf-8?B?ZkZSWVlOUWFLUDBRNlY5MUc3emsyZ1NLRjU3ZTQvd0lNRSt4QUNqSm8zWWJW?=
 =?utf-8?B?d0x2MmJYOWZUTFFxU3owRUxkSkQ2K0ttb0VkVXZScWx2QzZ0bUdNTmphQjBM?=
 =?utf-8?B?ZjIyNHYyN29meXZLWU1RMzN0VGtDWVNGN2R4dUMxVWxQQ3BqU2lMSTcvQVAy?=
 =?utf-8?B?UUpicXVtV3FyY3diSXBCSDk2U2x4alEzRVdJb296Snd3bFhWbW5GNjBTYjY1?=
 =?utf-8?B?WWYyNmxpTzJUR0N3blZzbWJUSHdDcE52ZTBnRUFoa1lQTmZpNDRoZGUyTi9p?=
 =?utf-8?B?cXAwTWpPSVVMSGFsN0U4bTE4QmxuaFZHSWlHU2VhRjBva0tBa3NidytLVUFG?=
 =?utf-8?B?bFhaK2JJZ0xKT3VLWFc3aU8vV2swWVdmNVo1aTd6azRDTUwyNHgyQXkxWkFK?=
 =?utf-8?B?T1dSNVVBU1ZXZkVaMzQ0c2RKZkFyUHBJcithNkY2c2pVT0VrbGJWVlVPSWZC?=
 =?utf-8?B?cjc4OVQ4Sjc3a3dsU0NYa1VTZjRyYlBGSW9kREV6c0FybFVDaWNkWU1SUDFx?=
 =?utf-8?B?NDRNQWk4VCtNaEh4cEpYN0cwVUQ1ZEtFVlhMRDNFS1hJaWl3SDQzWGJXeFRJ?=
 =?utf-8?B?KzlnQXJGdGQwYVNSZTVJRm9mdWY3anBIbEllVXA2RU4xWTFFME5pQWY2SERD?=
 =?utf-8?B?K1VwWVNydWEvRGE2ay9RUm9rVUZBb041aFVLdHhiRnQ2Y3A0Ym9Pd2xOa3oy?=
 =?utf-8?B?QXV1bkpZTWFjYW5IZWx5NVlSZ1pQYTJOS254MnZ2RTFUZEdQVFVrMGJ6V2xa?=
 =?utf-8?B?c1VMbmxHbE1neG12anNaeksxN3BZeXFicDdaaTA5ekpOZCtOMnpaajQ0eTVq?=
 =?utf-8?B?M2w5MDBRK0Zta3VXb3IzOFVjcW9ubUVMM1J4MmZURU4wTnFNeGNZUitqeFEr?=
 =?utf-8?B?QlNoSGUyNlJjSU9GNWRLT3B4TXZxbklid3BScElpNDlVNE9VRUdnRmNJZ0dn?=
 =?utf-8?B?bXZ1bEhXU21GMzN5OGRVWEsyTVh1aFF4TitpSUxJekpKeVZXL2FJL3crcWcz?=
 =?utf-8?B?TkxJaEp5bEdDeWhSb25rcUpINkRrTnc1aVVMTzg1aHhySlJhSUF1MTlaaE5D?=
 =?utf-8?B?K1RWcXc5Ulk0U2ZnajZwL202OE1mKytKUGFuMTNhREI0RkNTUk5XQXc3MHVH?=
 =?utf-8?B?M291M251Skc4d21EQ09ueHgyQ01uNWJrckYwUElrOEVXZWhLT0VIenFlcHZr?=
 =?utf-8?B?ekQ3MWxuRDM5NUpCQXdpVHg2TEJ6R1RQYTVGRnVldlovTFlUdmlUUXFYWVFr?=
 =?utf-8?B?aGdzdnMxV214RHpTTG5wKzd3MlArZE5VdDZKNEUyUVQ5Y00rRTNUc0ZlaUtk?=
 =?utf-8?B?bVM1blJqYnNzSnhoM1FDM1UybHBPc29BYjgzdUVNNkVrakZVNzkzZnYxMUNO?=
 =?utf-8?B?TFNrOVIyUUxZbkJ1VG1rQUEzQVBtN2FDbVVHNlBjSlpGV2dyVHNjZ0N2a1Ax?=
 =?utf-8?B?ZkQ3YVpFT21hSWZvMFVZRWZGYWZTa09WS1F5dFZlVk9sOE1ZSE9YTlFtOFZh?=
 =?utf-8?B?OGIwZWVGKzNyc1dlcnM2NC9FTmtHUlh0WHpVTFhuQUFaaGJMdFNGczg5VGxH?=
 =?utf-8?B?V2ZsUEpydGVScjM0NS8vT2duZGg5cmdoNmVlV1RYbnZaN1NyL3ZQSFJTUkdv?=
 =?utf-8?B?amEzYWVZK3B1WDdhN0lYa0t4WmVITVU2ZFo1ZUxwWXBzM3EzRHBjakppKzVn?=
 =?utf-8?B?QVEyRXFEZDlDeWVXNEwwZjVoaXJwZGtzQXhXVjAzemM4c3FlMTZFUDcxZENI?=
 =?utf-8?Q?k3V8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0R5QWJGdi9tOTgwcUZlQWFvUVhCRzVlREE0ODY5TlFtMXhCcmhlTDIvWHRw?=
 =?utf-8?B?aVJzWFg3aUx2RGI1MlJrbmNJTERQVVhtT29YZGU2UjBUU0JudW10OGUyMC9C?=
 =?utf-8?B?TDVQdU9Md0RMajFGbEtqbFVPSlQwY3ROWW9ZNnJSeFo3bkRwbHcwSS94REpS?=
 =?utf-8?B?RG83S29FTEhuc1VTZEJtWldUU2R0SE83Ukwycm04R2hGcGYzSjdGbllYQWZ6?=
 =?utf-8?B?REJvaUFNYXpRTENYZFJxZG9BbmtJTzdOZUgxaHc4OG9KTVhTRjBaMGRWblAz?=
 =?utf-8?B?dkpUWUJaVG9hZEJFcjVBYktIZ0dxMGhHdVJRNWZDRWZEMmZmME00aFBzS0xz?=
 =?utf-8?B?Ym85UklQbm5HN2g5ZzEzUG1nek9rU2N5TmNMeGtGeThCWHVENVhjMUhVWVVN?=
 =?utf-8?B?UThCWm9acWFpQVEwTXpaSHhFQ0pRb0VVRHp4VVFPVWptVnd1NWdRSUtMVUgx?=
 =?utf-8?B?R0Rod05jWjFXZXZFcnhibmwxRUI0WkJlZHNvRkQ1YS9XalhDRDNVU0VxdEVI?=
 =?utf-8?B?eTlPVWhVWjJwR3NmL0hZUWNoUUoyQnJZRTVVTEszWnFpWGd0ZU14Y25yVi9h?=
 =?utf-8?B?WDJXbUhnWldYb1RYazZibDNHM2JJTzkrZ1QxY2ZlakNaaStXeU10Mkp6Rlho?=
 =?utf-8?B?WWhncitRK2RlazU5RjkvVXY4a1VkM0xZa0RjRnZZamQ1ejZTeDdNOGt6RjVn?=
 =?utf-8?B?bFAxV3NBZnA0NVpqbFZMZXNFZytNVVpnc1psaU9wTDZOb21CUlpmaExaYlRp?=
 =?utf-8?B?OENoWU9ZTFdMNmtWVjlYSlZKYXR3TXBuRlhxazdHQXJudFViOGlkNU1Rak5w?=
 =?utf-8?B?bmFvMXlCMXh1aUhJVUNvWWh1MTBKSmY3RzRjTkRiUzBLeTVQQWdzQlc2UnBP?=
 =?utf-8?B?TUJaZlRDRzRTWHBUWGcrTGk4NWI5aFZZRmFLNGxtbG5rMXNrbkpGSTl4Q0Z4?=
 =?utf-8?B?TnVNQjZuTkxmT2xkbzM5VFo1VnlXTFhDdnBJRmNNTFZFOHBpRGNWU0oxbE5T?=
 =?utf-8?B?Y3ZxdVY3QjVnRUoyT1p6WTFrVWpSVWRnT00wY1llOHF5OXIzQit2YkJKaUND?=
 =?utf-8?B?TlZPYjlEMGVWY2NCSCtING9wSEt1M1JoQnpOQXZNbEVXTDBYSTkyQURwcksy?=
 =?utf-8?B?Ly9sRWNLeEFqM3pxdm1hTVhxdkRUdUg4blhXc3ltV0hEcGsxbXdXV3Z3WTBU?=
 =?utf-8?B?WW5XeWNpcDh0cDBhNldmbjgwOXVKZW50WFJqSmxLOThLUG1BNEdVbktLMU5S?=
 =?utf-8?B?WWVNODRMZjBtSGlhcE02TjE5ZFFScWVjS3ZpQUVqZ0dKem5RaHVySjZPSXRz?=
 =?utf-8?B?MzRHU0YwejZEWHhvcmlmMTBEQ1dmcktySXk1bStBYTNlMjBSaENnREpWQkhr?=
 =?utf-8?B?V0p4TXJqSlBVUytnakpUeFJqcEU5WWVjdzRueHpDNHUyanJaKzNiOHVFNHJm?=
 =?utf-8?B?NU9mT3FoZ0liOFFyTW1abklLSWdMdWd3ZEIvTzZLb09QeEtwakZYZkJERHFR?=
 =?utf-8?B?Nk5UN2lyUmFkYWZzNk1pc1FaSVlld05DTGd1dUozemlzd1U5bmFjM2h6cWZI?=
 =?utf-8?B?QUZ3d3NKMGdWZkorQTFLakpicXNETHZMOHA0QnZvTGpYSEpVaDBlVTNXaXBq?=
 =?utf-8?B?RDFJRXJPKzJuazVRUUE3b3J2ZVg4TWVDaDNSQmNJQVVYeFVabVNGdDEwTVl4?=
 =?utf-8?B?MG5kRkJkQU9qYU5ma2JiRnJIM2Z0L3dBNEh2MWZSRlk5bFk4aE4yM1kwQmZ2?=
 =?utf-8?B?M1dxd1RtWmcrVllEZ1Nld0ExbHJCRzVmS04rSEgwaU0rYThkaE0wRlhvODFD?=
 =?utf-8?B?YVVxODlXcmlKV1dYZWM0UzNqRGJEQWhyeTFxVDRLdHFWMENHeHRBcWRNSHpM?=
 =?utf-8?B?K2Vnak1XMFQrSytwazZDU2Y1K3c2SXRUdnZFMkxSajdNR0hFOXZtZVlPOExS?=
 =?utf-8?B?YjFueExoUkhYNjl0T1lZVFBGc21zSG9VVDZHWHFVZkZPUWQrVFk1V0FGNHlV?=
 =?utf-8?B?WnVjampMaDNwVlVSZjJ3am4wVHBtSVdzMDlUeVNrSjNTZFl0Q1JmV0VyczZI?=
 =?utf-8?B?QU9MaW8yV1BTM3dvR3JIeDVPbTJhRmU5bk01SEc0MFFyWkd5VHR5UFBsNm55?=
 =?utf-8?B?eXZ5OVZlY0dWQUV6L0xlMFFmWExIQkR6ekYzRWR2dWNDR1VnTlJvdHBmVTg3?=
 =?utf-8?B?M2tVWHM4UXhhZUR2UXVDaVM1SVBDak1CZEZJVFJwZjVSOHVBZ1pJVEZLTjkx?=
 =?utf-8?B?eUo4UmVuSEhnbFBqMysrNXEvdHUrdWdSVGhQYkhtUVZseFk3WmlzbVhlUFZX?=
 =?utf-8?B?VzlWMVVralV6Y3hOSnlIZHBhMkRtWHBHTTFOVS80VXVjYWNZM3BMN2lBeXdN?=
 =?utf-8?Q?Up6XkpDJoiGatiBgtf+AmMAFd6QVC0Ou+ThV/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X4cNdTqJ+aYEG9ryLhYBasSTXWtCVIrD8s752/6meqAMKk1ydKbFKdKUZfiU3WW0+jPhbjsGGSBofFZVgIflT2w1XXWIa3saHWLlKVmSWZwBC6gbVaO1gQLGUM3NVSZ6yoOo3YS6EtT1aPM5r0k6B0p3e3TWCifblCPulLIpwHUxrs+8mX513gn642n4Lsm18+zZEWkiwM5uHbcY/2dXgjT8luwWCYoCK6xmCuf5xV32AW2th1pfMRNMjNppk21pkTTGCE+YLTsIGUVOcNJ/RF9/Za8JkNWRP0RJ8T8jmug8NThYhWtVN2xsCFa2E9oag0wWonYBlPsAl8VVYCVpH7F7nw3/rvlOS9hOkENk5NVnErtFPVH2OrXxVq+rvkED17wWh0f2TzNKzyDE8Y5+WGm12Fiaw1rthq/BMevc7sNYqHupLen2kF/wu0x2oD6UPae9LnSZNrUcnJem3IbP553hpJSFNev5w8v0aEMypkyFt1Hrcl8p/aAo6sl23seIY1NKsMEMf4x30sHlIhykcPgc79AjhkSs9a1nnFrN7bmNjZIzHOxPWzG5jaL69CKHn6X2x0EMLiJIIXY5tZ3dGIsO2ds06bcAIpnWgK88ZbQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75cebfd-f854-4ff9-2cd5-08de63e5d952
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 12:06:37.9918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65NMaIMeiiuvwLMbbjVUQ908gnaaFK06u+9XuV9Ymu7lOGhPJQjCioHYF1zJ8BspPXQV+GgINQtKsgeudlgWrJdIX6rMek7vBiAjOOYpS0Jeig9E37UoqUSopdcMVZ4v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6711
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=675 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602040092
X-Proofpoint-GUID: RGD60ptuz4fWlxZQmg6BkXfUKvzqKSTU
X-Proofpoint-ORIG-GUID: RGD60ptuz4fWlxZQmg6BkXfUKvzqKSTU
X-Authority-Analysis: v=2.4 cv=BJS+bVQG c=1 sm=1 tr=0 ts=69833652 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ierlkjxDrpt-FCb_mHIA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA5MiBTYWx0ZWRfXyPIa5oQAj6Yt
 IA/cLxJFqKxUAD6TdjbbMHShSECG5G4UokCGp15omVGqjyjG4177x9mRaL4obqdwm9RbRwUvfG4
 gfL99Ou3N48zlemcHb9HjyTQFI35efFRKsEWwLrkDSCerrOT2drg/Wh750lD3rp0QLMqtqIv0Su
 cTnDeNf9sYTX6ZYdJdV6zeiYkt1xdkuBbCj3OfuDGjJogE2jd+ZAUDkFMrp4qIcSW0PDxuDa2uX
 Ykiginf7EMo0eO7GgyakGdS74nUvhFTris8dcYq1jYavnNsn/fd+c9/iJXAHe6nmCtu3EwqZHvS
 Fp9S9W8Ll3QsFN7r2o2dqHa20illC/pR8W3oK4teVEiLgqXJOyZIlxntCg0sOAgygLS7cLLbmKw
 t/hplUD3ueaebQOeX/f6rWspWKi/A0QI/8buntauADvkBYMa5rvtwwGUemnbaOUBDTMBSeMZOS+
 cWKtVbwioBusa+6R7VWmopyXglYnYOGH7M/iDqtM=

Hi Andy,

On 04/02/26 15:31, Andy Shevchenko wrote:
> On Wed, Feb 04, 2026 at 02:50:54PM +0530, Harshit Mogalapalli wrote:
>> On 04/02/26 14:33, Andy Shevchenko wrote:
>>> On Tue, Feb 03, 2026 at 10:11:58PM -0800, Harshit Mogalapalli wrote:
> 
> ...
> 
>>>>    	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
>>>>    	if (ret)
>>>> -		goto error_ret;
>>>
>>>> -error_ret:
>>>> +		goto out_unlock;
>>>
>>>> +out_unlock:
>>>
>>> While this is correct change semantically, it's not needed as very soon
>>> the other patch drops this for good, hence leave the label name unmodified.
>>
>> Agree, I was doubtful on which is the preferred approach as its not really a
>> return anymore. But thanks for explaining.
> 
> The common sense says that we need to avoid ping-pong coding (*) in the series.
> 
> *It's when one patch in the series adds the code that's going to be deleted or
> heavily modified just later in the very same series.
> 

Sure thanks for explaining, I was thinking about it from a backport 
point of view(say this patch is auto selected as a prerequisite for 
applying another patch, but guard patch is not selected because there is 
no cleanup.h is some older kernel), in that case if this patch alone 
gets backported but not the gaurd() patch, err_return label might not 
look great. But I agree its not likely to happen in this case.

Thanks for sharing your thoughts.

Regards,
Harshit

