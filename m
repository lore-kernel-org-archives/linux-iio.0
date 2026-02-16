Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969D6263C8C;
	Mon, 16 Feb 2026 10:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771236955; cv=fail; b=jemapDzX470F1z34yrs/hkKJdbXR+3c9df5IJlgWYATbEW/YF69V02Z6OhTqp+jtGPX21Hx+3X9JuzjkHxSZQjLSAAM9DvvFBdfYLKgalM+Szgp4Mf/NeXzDCIK+3zOdLAUz03lugny/GRnroSWu/qOeSYom4kKrhRe8i7TCDWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771236955; c=relaxed/simple;
	bh=IVO3rzE7o1jgIM9AA8KpPBFEGRmPxQKA/kGFMBcOqcY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rbrFxcDiAFRLvc0omdH5yXM0xJTCsMHU6hqiKcBsgZLCO/Vcp+XhMAIFqhGDQK3+EjKZybXRi4n5zxvTAjN3c6yYJ3fVe7qXdK79faXAfEkdSWlWvhol9u3m+ZoL1Vi4z1kuY95Y+u7/jD8QWSnCOsd7D1Av2mSQfXDPigZ2xgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DPsS1G/b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XCRhUd66; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DPsS1G/b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XCRhUd66"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FNjglf266066;
	Mon, 16 Feb 2026 10:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=37UnrDNtQ541kLhOjzbi8Dpzg0ZFkbwM+s5ViBEYDVU=; b=
	DPsS1G/bNOsrfPdtNFhkANdObQ11z74FB6pIJvNRH9Uh6bGzwwHNzxh9CTMBUw7Q
	6eKTlCPt4kLF9JubxGPYFYfJ/H3OsiExb7g0kMVNa5CQ86Iccck7X+vQlJITYJIs
	/abh9rb02Ab5UvGkA4Cpfx0tNHuEthXFpNRhBDJEpajyaFjo1XsHKqw4GFpad12n
	fOKZHaMcPZvvtUfBwpF22+f1tGCl+f6vFGCxnMyigFhYdCVBm/OFsnB7jV/6ZiAc
	1X8CCB34qhDK2icqYxeK+avTn02d3wyp6nL2Zpt3RMejfOIZQhj0f/FMTUo0s7Uw
	NhrXs0ydy1tLdV7rvCJIrw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj041un7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 10:15:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61G9pbSe033623;
	Mon, 16 Feb 2026 10:15:43 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cafgc7uc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 10:15:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0BoPHD71t40zhBRSkbfZmPBhPbpRhnRFMFnnpVjA2oJumT+gkWtdsDbkwMcwd6+CzGyNrigs/BFhGxzjAneWB6GohHWXJLNvs2G1/8UjrXxUnFAm+H2tPntmOKrLLyU4tcfm0D+9xu+DqNLpR5qns8T1kfaQfCwbIlE6gxXXVgF7Fpwt3MdHU2Q5EJJPH+z1+U98iJKZeRGifh47Qo5kja8h2S5a+PbLUPyGyv9q7hzMu7izytHKVDjD4C9ylqBZReHwNbqoIcIeDww/AOEmwcIyBFvYpiC06NT+MPot+RdlYQDEq3c0OEDClRAwRKXLfxXZgL1DzDnM27ixjxdog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37UnrDNtQ541kLhOjzbi8Dpzg0ZFkbwM+s5ViBEYDVU=;
 b=HR1HogoUzL011ac3YeKhd2ptRSv7jzP8DyI4C02lO62ErfGRcBN5Tzr5B08k5dtkd1POD0Pp8hom+Cw5MKBfn9S8pjgH3Arm7TIStjiy3EZFkFU1pfb158nIpHxlmW8muhWkUsWXC5tdsm63TgMC2TjVGBQn7Z0/gxp/A3+ZStXyfURX4F6CNA8LUY0Sk95dNH+dSfqciJHoboBv351D0xQ/Wsd2u0KE0Z1/zGL8rziED2sX5MMVSNNF5Cwd76kxw8H8V9Qs4+gyft0qm5nxQVv4Lf6yBMKZK3a9o3VXoJCLSK89Fb0OLhTpgr0EonNR90Px4L4L0n2/b9Giu8Xmbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37UnrDNtQ541kLhOjzbi8Dpzg0ZFkbwM+s5ViBEYDVU=;
 b=XCRhUd66q0mss3IFppW9p1tv01qPDttq7sKQko7FjwZ4vD2C/rQrd1m3AaHOLaTSLZoddAY6FeBt9cOphGTYfe5QfHfoOVppUB3JXw9taUCuW58CQAQVg3V3dXqbgzWxSO7kazRikIoMUL6pvizfaAjbwH/WdqTH1nNUeqVd6Vk=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by PH0PR10MB4695.namprd10.prod.outlook.com (2603:10b6:510:3f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Mon, 16 Feb
 2026 10:15:41 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 10:15:41 +0000
Message-ID: <74d31a2c-d515-46d2-90f0-46ff816ee3a0@oracle.com>
Date: Mon, 16 Feb 2026 15:45:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] iio: sca3000: simplify with
 spi_get_device_match_data()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260216095110.1062611-1-harshit.m.mogalapalli@oracle.com>
 <aZLrb943-fnkyB7s@smile.fi.intel.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <aZLrb943-fnkyB7s@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0256.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::16) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|PH0PR10MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ee691a-60d1-4f82-c198-08de6d44565a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V09yZWRrZW12ZERrZHp2WDl3WDdHZjh5M0c3YTZRdmpSeTZVem41dUd4U3VD?=
 =?utf-8?B?OVFaamwvY0VObG5hUUtkSmNUaElMWHFaMmZQSmV2OVZkWHFKZXlYL2l0V1lx?=
 =?utf-8?B?dmpFQWNGVlZBNHNOdWY1eXk0cEd0SG9aUE12NnFyYnlQQ1BrcUFKdHJ0ajNX?=
 =?utf-8?B?b0NaNkhWTVVJdHNFSjh1YmR3R3I2SThMTkZQOXhTeU83WXFMcUdmOFAvWnQ1?=
 =?utf-8?B?U0x2SmZmNXlXUzVkTlU4ZXlyaG5pVU13aW5iZG9KZWlJMTF1MXJDOTB5NHg0?=
 =?utf-8?B?ZGxueFlMQXBOdlpwSGZjeVErelNYSjNYV2ZSZUVZUnVWeU1MMEF6ZDV5SVg3?=
 =?utf-8?B?MGdrYVh5WktnQ3lpWXJ0ZzFmQWlMNm4zWjNmV29jRjI4VjVPUThTb3lTZjJS?=
 =?utf-8?B?MmFvVU8vQWQ3M3JBaHNTdUZjTFlWUENjNjh0L0x4N21TbDVHM1R6Mld5d2xn?=
 =?utf-8?B?QnMzWVYySVRRSCtodmpvWFJzRjhhTGgvQ0xuRks4eEVoNkhNUm9oaGpOUFdT?=
 =?utf-8?B?ZWdZVUZKVFE0QmNhdFN5QnpwVGhNbnJMMlJVSk5MZFJaUUM4WlZTd2J2enpR?=
 =?utf-8?B?SnNmOFBHS0h5WnNTM3lnUjJiYmJJQWZ4V1k1eTZWVTQrYUtneWsyRFhNRnJY?=
 =?utf-8?B?ZmFBcnZSbEVobTBvKyszVS9DZzRqSWdDNGpYZHFrZDNnQlh5Z3ZoVnE1aVJs?=
 =?utf-8?B?SGkxcWdvbXBRcXpKZThwVFJZYU5PQ3ZaSjFyNXp5Ny9zSmJLTDZsOUVLSEwr?=
 =?utf-8?B?b2txZWhTaEljN25ZcjF1RjBhcmV4aDBrU0FKSzQ2VGZ4d3VqWmNnbStnZG9u?=
 =?utf-8?B?SkZBMzlQc3R1alNCQkJsTmF0citGTm9CbFJMcUJNMjdyakVQS0dLVCtyN3JK?=
 =?utf-8?B?a0U3cm43VlRNS1Qzck4xTjVMU0Q1ZkNxTjVqQ3JyNzRnWFRlK3RMSWFGcFBm?=
 =?utf-8?B?M1Y5cGx1eCtDUFF2UzRoSUlKRWMzQmw0YVdKa0tVTkxZWHhhZ2hPY3N5OXEz?=
 =?utf-8?B?bVVBWlg2enl3bzdzVE50eDlPUE9pTXVTYWFabW5IQTM0eSt6eXBkYXg2Qjc2?=
 =?utf-8?B?YnpyRVF2elRNaWQzZEltaDliRzZpRGx5NFRXNWFTNlBOSVZrZHM2SFdPNEpI?=
 =?utf-8?B?NThHWjdLUzlHMTdHUVdrWHlIRUpYWUYyT2RSdFpzYjdJMjEwVWJMcEcyVmg5?=
 =?utf-8?B?ZHQ2SzY2WjYyNGtwaUViMklrOWVLVmJOZkpia3pJaVgyVFhMUE1zSGp4RVpq?=
 =?utf-8?B?aGNxbCtCS0x3WTQrQkdIdU9IKyt2bUs1RWxIaTZXNTRVVTNCVGljT0ZpSEc5?=
 =?utf-8?B?SHRGRUdlYnR3QUhOZnNtbFI2OTVqaHFXaktjWTFacEVYcjh0TG5wQ0htWE1w?=
 =?utf-8?B?c3Q1ekpINElscFp2cVNxQkFSRlFudUNxM0x2Y2oyNVIzSHljMFB4QUNTczY1?=
 =?utf-8?B?STl6YUpxTFljZ01KeEJtMzZGSkhibUNiY2h6dm9hM1VYQnNBaThoQXZVUGcy?=
 =?utf-8?B?WTliYVZzd3hKd0RMNXgxcjFDaVdHeS91ZHdLM1FjcDMrMEh6R0hicmtPVHlr?=
 =?utf-8?B?NDRNMThHUS9RUXd2dDh2ZTdnREJWSWsvN1lvMENCWGRzTWJPYzdwOVVOZEo5?=
 =?utf-8?B?dVVTTmJxMHQvVnVFWFVwNldLYU9iQWhTd1V2bUd0dlQwMVhmS0FWdlRIWnJK?=
 =?utf-8?B?WlE1Q3RJOEQvS1BNRkV0WlJBZ295MGRQc1Q3T2dJRjF1dHJSZ2VvdmNPYjQ0?=
 =?utf-8?B?L0wwd3h5Z2xqOWRHUktCWWFSTi9IeFRwa2lKUHdoeDZBQ3ZhWFpGdXozUWhW?=
 =?utf-8?B?WGlmazNIUWVKQThYOVlUWERkcFNOWFVIWHRla2FuYU0zT2I3bkFIaWpyOHV3?=
 =?utf-8?B?WjFNV3FSMXI4Tms4N3VQU0o5MHNSTnU0R0FIVlVldjltcGVlaVRBV0hOMEJC?=
 =?utf-8?B?NVhISEVaRXloaENEL01aZW9GVlJwcjE0Y1BJODJuTU5MWVowY1BnWloxandB?=
 =?utf-8?B?blpTcWpBTlFGdWcrUkdydUR2VVM1VlYzeCt1MFZLbDNwTjJaTzdNSEhycko0?=
 =?utf-8?B?UlVaVjQ4SU9tL0pjYnVZZUd1cGs3cnlLRDNyWENMUitvbEZLbGV6ZlpKMUZQ?=
 =?utf-8?Q?fkyY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnpOL0NQUVBJSDVFbjdEaEw4Y25GblltN0Fic21kd0VxMGkwZUJBR1VqR3R6?=
 =?utf-8?B?Y3U0ZldiQ3hYZWxodmdPNVI3TmRsZ0hJakpJcU1TYStwUFI0dFJ0Qk41Zkxi?=
 =?utf-8?B?RS81VjlnM3pSRStGcFg5UHNacVcwWGVzQjBSaFdFSlF6aDBuSlBUbERmaEZj?=
 =?utf-8?B?MW9kVCs1VFRRayt0WU15bmFXQllJNzV5V2hwOHpsOG0zVHJoOUVNellRMldv?=
 =?utf-8?B?MU9PaWZsUEpJWGJzVE41K08rWHV3dm1uZVBSdjVZQTZGR3RzSmI1eGZDSjBD?=
 =?utf-8?B?MTNhcVpaa2VuZDNTYVBvR1c3dWVvaUxsdFdhS25FM1pTMWtJYXBsTHVxT2ZL?=
 =?utf-8?B?TVF5dzJqNUs2TlhDMktXYkZROS90Z0ZXM3VsTmlPS3RpaWZYSzNWbGFkRWRM?=
 =?utf-8?B?Ym55UUgyZTF4VnBkTzZqekplTUhkbVNpeklXWnZEWnlTQThkVXlNV1dEbE9p?=
 =?utf-8?B?bWc1VVBBL1lkRUhMbkxHaTExSzJyZHU3ZllFUXdPaFlKZHBlWWFQdGhGRUxv?=
 =?utf-8?B?dnVCbloyVXJVUUFTZ0NwbXZiV29Ub2RFUVF0RmVyS3VKL00ySzFFZkhiK1JD?=
 =?utf-8?B?ais5YmtaSGcxY3dhckFOUTFyeWdaMlUxY1dqcVBmMW9XdFhPNGlYNGhRL3A3?=
 =?utf-8?B?bHhPMjVRVGpQUkFGSWliaEJKN2lvSXphUmxpMk92Rzd4RFlRS1NGOWRkUlJ0?=
 =?utf-8?B?OEFRd1JZYTNLdmtZYm1hbUttUVhzcENpQlhkSzVINUU0VGlvRWpPMGdKSnJh?=
 =?utf-8?B?aWVuWktrakhLUEpVdWE4dUo4WmhMZlByWkZPVTdqK0drc1IxYzQvVDFPRk1X?=
 =?utf-8?B?c05LN0g0Y2VESDhtT0RMa3FIVTZ6WFRIUXdJMG9EMEJXV3ZIWnlVdm9qTzdo?=
 =?utf-8?B?UFAyUUxTWklOenV4U3ZvRVJ1UFdHMkVBYzFHUDh0b2crMnVlZm9uc05jK2JR?=
 =?utf-8?B?WDlNNXpFdFhFZjBsQmE4K0gxNkdJWUREY20vdUREeCt6S3UwQ3FFN2VGcGV0?=
 =?utf-8?B?cyszNzNUeE4zdk5NektVbERlcmVsRXY2QWgvbHNGR2NWMm52U3FjNzhxaTZV?=
 =?utf-8?B?bzN3T3pIa1JnNE5sQTdBSXpKKzdZMnMvUDVrd1Rub1dDdXVpWVltcUtlTWVv?=
 =?utf-8?B?VXJqVXFjdnFwTnJHZTY3cUhtcEZCUU5wRkx2aFNGcU5BL0JSOGhJczRLMXpw?=
 =?utf-8?B?U2ZHUlVkaHFJa3E4NjNkcEI3aDRGZjhRWVg3OXNzaUhVVnVpbys3YnY0NGNJ?=
 =?utf-8?B?RktLNXd3TVVNd3BkZi9nWVNpNFBLdFFML0tMT3BmY2l4VTJqWk1mR3dNRXVp?=
 =?utf-8?B?ZHg0d2ZBcCtIWUJVY0dPTWlLWXBWM0NDdmp4S3Ivc2ZESVBKalVYRDZHR1BK?=
 =?utf-8?B?MnNQM1ZmRmNjbWdPZjErT2JoK0hSV21zY2lpOEdTdmRCOUwybDZ6OGdYWEoy?=
 =?utf-8?B?L3UvYzRlMitEYWpIZlU2VlUySkkrMFByN2NCaG5LdW9IMWplYmsxbnpoZDN3?=
 =?utf-8?B?djJSaWhUV09lSDA4bTdhN1FlaTI3dFRxOFVianB0OWVKU21HQ1pZOEN5b3pO?=
 =?utf-8?B?UmRFMmJxWk1PaC91MnMrVnJ1NWZjOGVnRkxRa1pXVUM0bDhUUTZWV3FNRWsv?=
 =?utf-8?B?RGdiWktYazlONXR6bDZYUmhHb0lrbTJXWkt4OGwxdUNSV0pFdHZCWDdxL09j?=
 =?utf-8?B?MmlQWDl0cFplWVA2UkE2amwyNUZ0VENqV1pxbTMyazF5bFU1TG8yalJqY1Ry?=
 =?utf-8?B?TlhVSU16N1BXblBHR0xiOGJVQlQwdnh6ejRSc0syWWpQeng4WEJpUkdqTFRu?=
 =?utf-8?B?MjRRSlJ5c0dZR0JaT3BlZEhERjhQVXNtVk9tMjZNR3dadEhCNENmSG5HQjU4?=
 =?utf-8?B?UmRTcGRhUFdsSEFZblluNTJYSUpCcHdHQVgyUnlHc0pMRWhGU1FjVEJudU1V?=
 =?utf-8?B?Nzd0Q2oxK252djh4Mkx1UW13MlYrcjlsdEVYVk9LQ3lwM25YeFRSS2VFVEpZ?=
 =?utf-8?B?RjB0bDVzTXdiVzhxWE5CbGYwZUxOQWxzQ3V4R1dIZkxrOHlnZmtieTlKZmpE?=
 =?utf-8?B?L0hhcmJkUTljWmJuSnN1cWN4UkZXRjEranMrcWFGYkN3TDRDRC9EZUxpV0ZQ?=
 =?utf-8?B?NkhPSUVtUCtHNDVKUVVGcVFzSHMwS2o5VWZJMmFoaXhFT3lVajFFZ25JckFN?=
 =?utf-8?B?dUJZRzJZSlVlMkVXc2hLeE9IUUhTZ0J3V0xZUVl6YzlMNzRNK1JtWlpRUHRy?=
 =?utf-8?B?ZTVwZFl0bDh6bVNhSkowVWptREdoMUNrR1JpeHBWYnRBbWsvVG1yWEZCOFpW?=
 =?utf-8?B?MkpQMWpZYklWTStLMm5hYkhoMXRTaW5LSTNpbUVjYS8zZDg2RTZzZjdFcTBX?=
 =?utf-8?Q?hvDS3vnXCwcvY7WRlgeBfdB0esa9RDLMbpnYj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J5+uPIEHytFsRS8Rnxu0b6PfuDcG7NxRbY7vPsJK/b9vpeWj0IBwIYOghE0DiaD1Wt2j/O55nFymZiJRoFmloRLsp3WOUa1po/Bs1QdMuMPajIM/j/Aec/VPmg3K0KkEWHRDSIvF/fAWlS0076iOgX/AGlFep5bJrGxG8ko8nfUNTyxmPjzp6HDSSGYIAzNvFBBsWe6gYSzVWj7Ijthnrku5iCaV3XAcjjo/HTDqnFsOJrVUmF1jsjUmEe2mVskllWMY+kzJn12e9CHzZEXhfdU6xI1lcx6DZzMLE8I6qEGHJJt4LAyyu9Jsx07PKdq2QlOYdV44W1s/zrxRP5+9MjfErMa+ldnK1j4voYHbsNhLstyrMEL9mpRjvBedkl6fAET93TbKYC0hacB9Hk/0cZ5pPXzZO9OCaL8RhR+24ITC0PwYmY3CtLQhOBZtgHjAvRWdY8nBY71t09UbIoug5IxgR9AeOrcw5oe0Dyh6AuDur0fYMGJmc5L3pvUkgr4L7bkPGStgZjiWdmM3cHqlsp8TATwnd5rCWOTbYjnpPGI+dmd9tu7DLQOH1cuL8O5NXD117JPRiLBILCN4kgSK5lIf+WAL6F1Npc6XSISup00=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ee691a-60d1-4f82-c198-08de6d44565a
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 10:15:40.9329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrH8BbkRDdcthUNBpF4kQHKa2HuR1WyNEZKNZOo2V1MCtToHkaJt9liH1wtu2oKOa346f3mDpeNlUDg1IGo+jBzFJ/+BFOKGN9TmIt0HBkPwJF1U7H7BdrqCWKTP5LPM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602160085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA4NiBTYWx0ZWRfXw84LFAozJ0iy
 niE2xGI6Cj5MCaks0zYNgFGYM+stNsbO7UGCVJY+xP+yBzFzdhxPv9GWiDuZUz/V7lTQz4j4ubM
 l3RSE8et6oDlvdGwt5D2jKLNEfvo4/OBFJSmNTjWBgOQiAdwbGhH0XyWMPK2oFRVhwrPkDms2Wm
 u8FvU32oYIsNILdKoX69dJxcXXpIQeqCTYsIn4cB9LG3YpDPm+soJfxGUyLg4u7R3NweZT1hl/6
 gUq0L6qWubWZWX+nJDeYMD+97ceSTIuATcB2+cPziNH6LO+PAfwqGKrWv9rA4oz58rqNBvFPru4
 P0u+R1BB9EO5vAmDjPbqhxUlwV0G6CnqNC968nxZU0YWkPKlknznSjuH44JZZXBt/KBH89OLLUF
 lfkRGohGybPSFtWxE+8tgmplW9dv0cctg98Ahj0bLxU+9PBXKouF6rU+Z0TsV/ew8YE/EkUYXwZ
 /HtDkgcCV3xK40OIfvua+Ff+tDU37sbFQqO3i/A8=
X-Authority-Analysis: v=2.4 cv=O+w0fR9W c=1 sm=1 tr=0 ts=6992ee51 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=QyXUC8HyAAAA:8
 a=PXmWLe18g-QktsZzejgA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13697
X-Proofpoint-GUID: ITxG_t_qxWH3sfEnPtAfXo_clV8YigI3
X-Proofpoint-ORIG-GUID: ITxG_t_qxWH3sfEnPtAfXo_clV8YigI3

Hi Andy,

On 16/02/26 15:33, Andy Shevchenko wrote:
> On Mon, Feb 16, 2026 at 01:51:05AM -0800, Harshit Mogalapalli wrote:
>> Refactor each sca3000 variant with it's own chip_info struct, update the
>> sca3000_probe() to use spi_get_device_match_data().
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Thanks for the review!


> ...
> 
>> -	st->info = &sca3000_spi_chip_info_tbl[spi_get_device_id(spi)
>> -					      ->driver_data];
>> +	st->info = spi_get_device_match_data(spi);
> 
>> +	if (!st->info)
>> +		return -EINVAL;
> 
> This is a dead check. Just make it a requirement and drop dead code.
> The support of a new HW will be assumed not tested at all if there
> is no driver_data.
>

I agree, will drop the check in V2.

There are a few commits like this which added NULL checks, so I was not 
fully sure.

commit: c5d8facf107a ("iio: adc: ad7192: properly check 
spi_get_device_match_data()")


Thanks,
Harshit
