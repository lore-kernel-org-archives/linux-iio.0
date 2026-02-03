Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66FA267714;
	Tue,  3 Feb 2026 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134366; cv=fail; b=azCqyOBBWo/3RoJQewZM19yzXhnP9k3nmfYfbpczPinJBzpbdwLSBrWY1VGaWJBT0Zwq8j2aX7lTKKspTXZ4rgJxBDWOvrhaiqx6I6CFTRkb9IVZN330PKuln+MUwtq3LM+k26NARfJbnQF21FXhH+nY8tVINXI74JBIZcVtlYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134366; c=relaxed/simple;
	bh=k98udFFKTrPXr+mT/1ofJOg1rdQ3HUu7JmkP4zn5A1c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eC+d7kDiFqtiN3IoDmEYy2SdpBuZnUxnGL6qSqPwdiYVkolG9kU+OtsEslKaZdJRdTI67kiPy8ZyYXDWtuJ92rsEdMVUnTjqi4l5fRVQrIiledHwUiWQC5gRIiLoe2BEMbvGtfhh5hq7kur0wMqe7FKpnU7DbWpoFehn98j6IpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ErqVBwlZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tIBdm10e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ErqVBwlZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tIBdm10e"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138vHPA3335497;
	Tue, 3 Feb 2026 15:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PevffgjYaX9eGRFUgoFfHm0uTT64ncS1cgZh0Rzl7bI=; b=
	ErqVBwlZLrhbO7rxgxFbsS5Ek4KIbwwCTrMPOLv+vu1G6MGTH1dq1l4PhvAdOdhB
	xyz4RI9BWzWxEBoQxiCSqB0QvhJyyhi/ndDe8hjvRRoJuL2zFKJvmOObRNsEiYDs
	zpAjtlgzp4cRBoKtjWzdlTVRsGKN1yLZ2iojOL/RVyCXPFFTJvd5NHiayJPgtnPr
	ituRPlhxehHMcN8dUiK3oyNOpEiycY3QkBZuGXLpyLIA+eRdQBexQtSL+3spf99I
	7B4POVTlHWWQZQG5cgg5Fr+n1ugI8/EvK1J/y3np7DBWx52LqsSZqyKORZ2yYcWR
	P06hSD6gbTtDW789po3E5Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1arkvbfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 15:59:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 613F6wia025699;
	Tue, 3 Feb 2026 15:59:15 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c2578mh78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 15:59:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojqQf/8xfddv85d4TTwwl31mcGvkwkgJqHPQ1QkwnI3Iys1mEZI1hjiMoksJsDt5GhzKvyY4Sf96D4zbWy9fRSnIv//mWlw+DMGmqyIbopTaryt9XNlBx+r/xS8oTBRmpEuz4rJ7A+wudKCye3QjoBP1SLtJuuw61KPms+kVMtmPlk6ZIr9/L3c/5vIJcnmy9etnI7IKINtp/IEuAwtJ4oqn/5vdaI27PtK3TU+yXZdi2BqYlvbJoimsj9jOjBkg66wWhcbLOp4slaksxspPRkedXbfi4Thl1hA/+FeUeUqKqxpQEivscnI4ZeGtaczIo9iWzSp9+lQ7IzjtGe/2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PevffgjYaX9eGRFUgoFfHm0uTT64ncS1cgZh0Rzl7bI=;
 b=hwV2hWbtcG6JI+1hKo18a6YNdcFwncXE4fISwlYguZrjGcX7Y+HehYhfHrAQqB2VdzFAe7yNsXn/vOGfuIcNI1AV3SLXcwI48kssNNef/N1rt969MZb9t2kyRN8A3oda3aDc+gaQElXPRNg+UMxfHgTp/eoc63ZyKRmzCzq9O9pCK5LlQZZ/jbv/Ts1HQHObGOm69VL93UztEaatbVl0GxwUfbotzKGYxvtrRDXeMtFZVtKHNb3Mg7NcXpsNFEdPB5/jOkybPV2f9UhH+ZQyH0HtkthUxBKVkrDI560scCYE9f9NWzn1uOjtcBuQORmNuHHKplK3DPFGBm3m480JAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PevffgjYaX9eGRFUgoFfHm0uTT64ncS1cgZh0Rzl7bI=;
 b=tIBdm10ernVMcHNwGEzSFcQ3KR6ORTmXeLY08Y7E/rSJuLdZ6Q9E9SdNZwWd4QhdH7g8B1JCKy2HaZ2gKWP5S/I6BOpwMV3gVx4qrV7LAxQ2vIe83nHS8tky0t4EPecOvhJykLTmXWAkRmUbDKdYqy8UahWnUXbIlzO0nmLewIM=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by IA3PR10MB8563.namprd10.prod.outlook.com (2603:10b6:208:571::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 15:59:11 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 15:59:11 +0000
Message-ID: <c7da67a1-2a88-443f-b3c8-4f13f34fbba3@oracle.com>
Date: Tue, 3 Feb 2026 21:29:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 next 2/6] iio: sca3000: reuse device pointer for devm
 helpers
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
References: <20260203122109.689669-1-harshit.m.mogalapalli@oracle.com>
 <20260203122109.689669-3-harshit.m.mogalapalli@oracle.com>
 <aYIRf6j0fXR5NcEK@smile.fi.intel.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <aYIRf6j0fXR5NcEK@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::13) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|IA3PR10MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: d101d622-6955-4a42-c6a4-08de633d2bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WCtadzNhS0ZUUU5vUTRMQWh0Lzg1RHI4TS9scmRhZDloWVVBMzFpTmpWTWJZ?=
 =?utf-8?B?MHJ0dGFQZUphSHIvU2tBUjV4anNOQnlPcThLUVdtMUMxTmJjTGtzYWlndTE0?=
 =?utf-8?B?VlBPVnpBMEpUK2huQytzZkZCRklYUUhKSzYrSDY0OUJiUXhvWENFeVdRZkFX?=
 =?utf-8?B?azFPQ1VIc042Yzh3QXdoNW45MTZudEd6cWQyaU04cG5EbHR2YnVvd1l0N0Rt?=
 =?utf-8?B?eUxFRXQzb1k4V01FYkdjMmdTM3FkaThCUWMySCtadUxKdmViRDR0Z1RMZkJa?=
 =?utf-8?B?TXhxbG1RUCtlOWVXYjNwbkw0U3VKaTlncjNNcE5NRVZrNm9UYi9wOXplZXdX?=
 =?utf-8?B?UW9lVVh2eldsZGhxVXdqSG1LV29TVjY3eDBDUkpIcDIrODZUWk5WQkY3ZXJo?=
 =?utf-8?B?cWJzaGtmWGhVaU5HZGM4WmhSTHJFZ0lFMTN3SXQ2NGdHKyt3aCt5YTlyU1Iy?=
 =?utf-8?B?N1lTVjZFdWNRN3hBNkZIL3ZjNzNsUFVDejV5L2Z3NkFtU1FONGlkU0lIZW50?=
 =?utf-8?B?RW1hZU5pZi9LeEo2Yk8xamx6ajlzWURzanhabWFUMlFDZjFFK0JIWnFYSzRz?=
 =?utf-8?B?eFB5b1Y3UjJjS2V1NExWZ29seXZLc3pLY09qRVdSNi9wR3NuOGpqMWs5UFZD?=
 =?utf-8?B?amhyRytNZVdqbFgvVDFHVlpCdm1uNm5vU1RHU2I2Q0RZV3hDWis2dGcybDFi?=
 =?utf-8?B?TE9CQjhhMUdhVklTSU52bUpubW5KeVBwZ1I4UUwrVDQ4UDZ6R29qeWxhMFln?=
 =?utf-8?B?S1dMLzZXZitrTXlXaENoZWJlRDlPbmVRRmJUZXZFSFlNUkc5M25vOXptd1Ju?=
 =?utf-8?B?K2kvT21sQzRxSStJT1NVSlZpYjZtQkppWG1hYXRYUVNRd3FWSkVibDd3Z1Vp?=
 =?utf-8?B?bXlVYURpa2dqNFpDK2p4dlVleElIanhoRVZ1cU9QYUprSmY5bi9rV01GeHZQ?=
 =?utf-8?B?Y0RhQVZQQzBVcjJnZHEvUHlIYVl6d040TUo5cDEza3dSeXlSZmlpdEovZXZ0?=
 =?utf-8?B?WXFPbVhZZ1NuRllzck1BRjlMOXFWaHVzRmNMQ1E5WlpKMVBwZTBmaGF1Qlhv?=
 =?utf-8?B?Q0NPL3ZxU3BacittU1UrdUMwSG1TZjlCRXBCNXE1dnVYeXFLZUdCUWNVOFZ1?=
 =?utf-8?B?bmlOcFh2aURVMTYyaDRJYlF1bVdnTVZrQnhJNGQzNENVWk1iSGttSldKTDBY?=
 =?utf-8?B?VnlnNlZFYlJJSnJHUkRrd1J3SW5ST2l2R0lEQ2lFdkd4cmM3VVk0c3lUWEs4?=
 =?utf-8?B?RVg0b2x4bHk4d0Q3OUg3RXJPVWljVkRhVGg1SGRJQVozM05jdngvMGswZzFk?=
 =?utf-8?B?RlErWCtRQ1hFOC9wb3l1SnNaTjBwRDltVkxKeTE5bW9XbDJTY2RlaFBRZElM?=
 =?utf-8?B?SldSQTU2azV5UjRDd2dkWVY2SGtrMzNlRGZEU3BJZGRuYlVaeDNSQ21zUmNu?=
 =?utf-8?B?NVhjSGx5Z1RFNUF6SkxBUUJpakRkd1RQMWNRUnI0b1Ewb2xsSTNTYUQ3NlYz?=
 =?utf-8?B?VXlrQlpUS1NsVG9GaWQ4VnV0bDBYOEU3K3ZqWFlDNytSSG5qaWk5NFR0dFA1?=
 =?utf-8?B?ejJVL0ErdmFDSHBCdGRjU2VkUUZRWWlPakJPQXo5TGpEQ0pWandpMUR1Z1Yy?=
 =?utf-8?B?MTZNdVZXMzVMUThCMDFCbEVaRmxrZHhKMVhTcjRYaVFJN2xpSFE0QnRKZElT?=
 =?utf-8?B?TWE5Ym04aGlpNWNzSTZkZkhjRVZnS04vN2VGa21PclFha1dFb2VRTitmdmQ5?=
 =?utf-8?B?YytKYUpGVnA3SHVtWFhRa1QxakpDTW9RRFU2emFrTE42OEJmUkU2T3dFNm0y?=
 =?utf-8?B?MDVOM01nSE9tOEFvQnBVWnZqREcydDk0RXhZdzM2Q2g0dFNwaEVkY2JLbEov?=
 =?utf-8?B?SldCdUdtb3lGYTBYUnExaW5ZZEU2T00xRmVOVlBLRmt2WEN4bTRXL1dhNWhS?=
 =?utf-8?B?QnRNbkxTYkhLejNZamRYalNRQTdTZEFLUzJ2ZE02dkpVTkNEU1c1WTYvVkY0?=
 =?utf-8?B?SXMvcGtWdDdtSnEveDNWKzhLUWFjeTB0czRvTi9QT3Mxc0xoMTJJOUNDMnNp?=
 =?utf-8?B?cmxPWDJOYVljVXVCcGZoQTNWNzRIaTFUaSswczg1b2pwRXNHRmZKU2I4QVlN?=
 =?utf-8?Q?wNCM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkNsWXZRWHlrSEVrcFNGZ3NWeGFraE1UUHNIankwbWl1eWRGK0ZEOFFrd3pq?=
 =?utf-8?B?Vnc4dHlKNE02L0NSVWZheEJud1hkK2paZEZoa2NxeFNNT2ZHazE2eVViYnE5?=
 =?utf-8?B?SzlkckgzMXVEZFlhcEVFczlHSjRpdlIvYjcxdWhWUXptZWRua0gyUFRWbndi?=
 =?utf-8?B?SkZVUmJxYTdITGppblZ3SmRQMjVscnpsVWVWeTduSnh5cG0rS3hYT0FJLzRB?=
 =?utf-8?B?QU1ydXFNWXhlM3EwcFVORzQwQnB0YlQxRm1kODJobW9XK0lUQjZhSTBwS1l1?=
 =?utf-8?B?L0ZNUlNDYmMzaFF3OXE4ZHhMbGNkaTgwTjI3U0xqVTF4b3dNcUE2VTV1SExo?=
 =?utf-8?B?NnY3YnBicStab3d6QTZwa0NOM0xTOFF3ckhMZlFwbm0xK1dQYlQzT25vSS9B?=
 =?utf-8?B?T1BXQ1doRTN6cHp6NG5LMENZSHR5ZGJDZGdEMW8vNDdHZWZaeDhpQkJhSDNj?=
 =?utf-8?B?SjRWdWRsenVzVkYzUExDZWVrZXl1NFVkemt5YmI3TklmRGphU0FMRzcyWmxv?=
 =?utf-8?B?UFR0TTdqWjlTT2hqa3lranRNYTh2ay9BRVdZWkpXVVFrVDZvUjg2VmlOOGpS?=
 =?utf-8?B?QXhrVXhhNHplQzExaW1NSmQ4V0VWWjNHMmczb2NkMzlUOWNrVFNjRTdBUlNj?=
 =?utf-8?B?c1VqMFgydnJrd0NMb3B6ejZMelpPY2xZalNOR3ZCS0ZhQUpDZDF4REhSUzU2?=
 =?utf-8?B?YVlzYmR6dmRWNG14bldqeEFobHlYYlJLdXF6NmlrdjZRTTRnSjV4dzZ4ZEx1?=
 =?utf-8?B?a1pBRnJTWWFpYTl3azhJTGpoUkpFR3ZoV2cvM2NOMDBZeHpNVVVXdWkzdlBC?=
 =?utf-8?B?MUV4SkJwdWF5MXQwT29ZdHVCNjhjZXZwNGYrVmlVVFI4azBsNW9qQ1BKaUsx?=
 =?utf-8?B?K0JlSkRaUUp6bWw3OXpuOUtmK3p6NnE1Tlp1aDZKVHhzdi9QbkhqSVY4L0FG?=
 =?utf-8?B?WWJUbjZLeGhIRU5QYTlYNTI5QlJ0WlJodXdOS2lBVkZVT1d6azAxcFAvY1dz?=
 =?utf-8?B?bjE3ZThCRHhpbDhubzRCM09wSnVhc2V6TWxPNHVhekRLbHRKVkp4NHRRZ3Zh?=
 =?utf-8?B?Z1IyNTRCUndWNGJIRGQyMXV0eTYzTlovcFg3YWdMWG04SFVjUDVUM1ZjbnV1?=
 =?utf-8?B?YndYUXZvYW0zT2Qwa1V5U1hJck5Ed0l3WFNOSENKaVNsUHpWb0xLbEZYdHVR?=
 =?utf-8?B?Nm9EYUpoeldobkZ1MHdrQllMYUllSlphRzZ6SXV3M01MOEVEWHh6UHFaODdR?=
 =?utf-8?B?VndEWlBIV21UWXAxczYrbTVvRFpSTHVhVHBmTlJMUGVxUFpaRldqLzk2NUUw?=
 =?utf-8?B?YStGeVRwQ3lLeEpxNmllZUNibWV1d3RSUnVoNDJPKzA0Q3VvR3g4RTFBcWJN?=
 =?utf-8?B?NU1CekVkamhpTFJjZjE4bFEwZnNZSGordjRNZjIzeDVCUXY1ZXNtT1FBNzI0?=
 =?utf-8?B?bGpNYnZTZTN2SThBOXpnamtSNjJ4R3VVQW9ZK0drK3B5TVVwcDYyNW4vOVV3?=
 =?utf-8?B?TTdCMDBYaWFXQ0dPMlJ4UzA2Yno5bDJNLzFYRVJYanVTa1h0cUdndERrcmwv?=
 =?utf-8?B?YXZqWlk0eDJEVHZuNXo2ZndmVW5naXVlUmxCNmJZaUlmNjE4ckl4R0RNR3JT?=
 =?utf-8?B?K2pNelNkV3ZMOW1IekJBVGEzOFNZVXlNdnlPb2VhMzh2NVJPT203S3I0bFZl?=
 =?utf-8?B?bFR6SG1sUzZCTEpObjFEK0ZhdVhVYjlNZUpRM3lZZUNhQzNES0Vva2YyemVj?=
 =?utf-8?B?eWJtYjlvM3NpcXl5ZUh0RG9PVEU3ejVjZXBIbVV4VVdVWFI4ZlBLekkyVzA5?=
 =?utf-8?B?RzRDZFhySndUcUNmTnhLQ05WR2N6bXVDUk9RRW9MOW1HbVkxSW50cG1mVVRL?=
 =?utf-8?B?R29FR3hSYzQrQUwvb3dDWURDWENVVWxzc1cvZHZPNzhsekxLbStrMFlaTVBS?=
 =?utf-8?B?dVEzU3U1WktBNTE1SDlUYlJLeWxGc3doTDNCdk5CMVIra2VVSUkwK0hTRmVP?=
 =?utf-8?B?Y1JEYmJqdzAreWFQL25jMzd1WC91blJkZ2lUREtCZnRLWU9KQ1lLaktpc1Qr?=
 =?utf-8?B?WjJFQmZOTkQrbzVvT041dmVtMlFoZS9MNXN1dSszM1krRTYyTkVsQy9RNmcv?=
 =?utf-8?B?V3NDZzFpbWEwYnRBUG95Lzk4NmFFNzFINVVSUUNMa2lCSE5TNDRpYVFrV0dz?=
 =?utf-8?B?djRBaGZzSkRRRnlSOGVzaURhWEg5ZUpLVlpBMEl2WVJMRnQwQW4vWmpacklQ?=
 =?utf-8?B?ZWIzNlVJYmFVMm1yRXlXMDFqL1daU0xWV0ZwS2UrQU0rVHBXcEthdUp5VUtj?=
 =?utf-8?B?WS9OcWRGakZVZWMvcStHUXhOZnY5MVIzb3lua3NaZVgya2U1czRQcTEwK3dt?=
 =?utf-8?Q?DlvbsusNHD9Z14vlx9WaJTyMCkbgJ0tKRMS1G?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6Doqb1QFpLSd5PC7KJXDPfIlQHuKps1xhOkLBbb8SpNOKguXmLQZjzTb+ILq0EPCmkOh88pCU6WO2bBdoAxPkCPvN1+8UWynSw5mGZzBbP4R+P3GLYZ9RNccd200RQ1AGtIVLFKO7vA0ZdnsNlZWt0E+xKXAqW2jJV/PriUeUtmbceHKlYxkkmxlNUzIVeyYlAcsyD6CwzDKE/SrkJG6N2+ljL5130+BclpotqglQxe7lebpOPhN+GJbYDQJ9fxKoWoiyvILDv22nVtHTysXdrIsODmTe0It+Wf4EMc46hVqFgAIaSmH0i2jyBqa5xLo4w16YlePWfhLaQPqgJoGjQz/r62w9PamKoZpRnyZb6SZkZQ5rt7baMc2+cW3omscNlu2se2LVGN4Q/xhGWz0P8x7JCmX++CHUK/u85mZBtnGQe2bKHsY5U0LV5uuJ3dZm9pJZTiijnFNVR0bJun6L/AhLzSadr2hHXzGkLd9phHSlUnEjFDGvR2DmCMBTiAuJYTqy/t1zOpo+Gw18liR3j67nD3RnZBmOS2nGym55MsWZNcSYBsPmL52wGryeHkmR9CRsMLKG4S1MU+NsxZ2tqZjQ4VHAGesgJF9XCpXKh4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d101d622-6955-4a42-c6a4-08de633d2bb9
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:59:11.3425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qS1np6XcHxKmb+YnAnOKD3fggaKrBpPObzXcwG/4YZXu4Gd9q6E2JiutYlqa+6evNRitjc6/7vryII7DUOfvVycpzSRflZOPsJyz/05d41F6qaf3nH1EG9CAI6+0B9dj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8563
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602030127
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyNyBTYWx0ZWRfX/1wiuU2tq9IQ
 G7/JZySrUP9hnkGW/QOJS2IW+aWjaE9Dw18a29rSTCRx1zmXD/ljGyoeDnt3lH8Ql+PitLKXunB
 wiYSUWti16KiDjZeBOKPWcRU6pKBFBDTR8e9mC7Xm5+i8XR7umxW0q2y26Iz8AjC9YtjRQNakWM
 zGBrRP2bh4EwImGrxry0ddc9kwgyWvwCNMY4GtRi7W2Gp4UJTl4sdEJgCXgRReeUjg+zMLvKk2w
 rYjp0hRkM/GKwvUbut2AGXXci/mHng4jDoFtelFGsG2vjAtrNVsT+OV7zEGvtG7Nxa2qsB8PMLV
 fH6orhof4Tirtvp6Cpv7Inu6lE1EMjyFPH9v8LjVgMvkmbuPH+M4jHrwbDC59lhpl7vdiixlw7W
 58AWUCbXohPRqYFdN+AQkxIhQSeQc9L1uYimO2R6Fd+DHMmSHukmeVZ76VKvk+zWcHtBB19xc/H
 aPhsZJHDAPULrfnADcjXn7XfkM0Hn+wkyv0/ea1Y=
X-Proofpoint-ORIG-GUID: DX4ULdoov-dcy8yXDI9TwNhF4dD678IQ
X-Proofpoint-GUID: DX4ULdoov-dcy8yXDI9TwNhF4dD678IQ
X-Authority-Analysis: v=2.4 cv=VfL6/Vp9 c=1 sm=1 tr=0 ts=69821b54 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=mtXkG8bNM940iBd0nrMA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13644

On 03/02/26 20:47, Andy Shevchenko wrote:
> On Tue, Feb 03, 2026 at 04:20:46AM -0800, Harshit Mogalapalli wrote:
>> Cache struct device *dev and feed it to the devm helpers to simplify
>> the probe function. No functional changes.
> 
> With or without below being addressed,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
>> -	ret = devm_iio_kfifo_buffer_setup(&spi->dev, indio_dev,
>> +	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
>>   					  &sca3000_ring_setup_ops);
> 
> Now make it a single line, it's just 83 characters.
> 

Sure, will do. I thought the wrap limit is 80, but there are other 
instances in this file where the columns exceeded 80. Will address this 
in my next version.

Thanks!

Regards,
Harshit



>>   	if (ret)
> 

