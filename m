Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF73A7834;
	Tue, 24 Feb 2026 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950218; cv=fail; b=mjIoits4W9si6McLg1mGA9mKVC4ito1cKfZ09rdLHwFJGXjAydZFMFSmpHYts+vPpbXNQxOCS1mQXmTV+Mzntxab1bQcb5TeXzuC/lCgpOaokmxa7+w4T6amyLk0biE1H4+zX3KHTW251u4a3N6IoA++cgTA2oCDjQ7//8LctO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950218; c=relaxed/simple;
	bh=thwYzxcK3mj7QbWHtpuvd6BPfLkKHREMMq2dG3/Lsio=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RUP8/5QfO+80jB4Mrj7Kut7oqi9FBZTygZKCacl29trZinsrPW3OJIKg9yJQgWAPkFFkcx004sYBxI5iltlWmqCkB82sXLUZNWRhNwSHolAR+facrGN3V0T9biX4ysDv4Joz/ltGeavnbcCZc37Hq2WSWuyp7SLSUM75T4FSegA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r/6UfXbI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hHSjarVc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r/6UfXbI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hHSjarVc"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OEO7vk4090209;
	Tue, 24 Feb 2026 16:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KNQpeShQ4cL02vBnKFdo035svMQsKXh4cxvhGo5AgUs=; b=
	r/6UfXbIFF561Kmyn7uANw/XPKAqlbACueqq2ruI+WdZqdcxe5JzLpzt1tcWcC4U
	GnvVZlX2Tr3VKgWw/Zv8pNaPexlwKI+bNK1MfyBvupbzVyJTZm5j+b2B91sZYOBo
	BwtjCbet3sBjmIBMFrXDnFNBvSwMmDQbiXHTEVaTFAUl6b/tm+f1J/kjYL+RtWzy
	wb/vVdBkZXB6HKl/K5YbXgts9v8mPHQsbc5lZXDAhzDDL/XPx3a9LyHNSCmlBRRZ
	zc5bTnUrqFL+lR6e8pLA9Ys9JxSWMleW1ujF+5cHlr2PKJXj75oHtYfcw1fYHqvD
	Uc5PWvHflgxBd0njWvaZ7g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3m7vj63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 16:23:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61OFiJTP006358;
	Tue, 24 Feb 2026 16:23:30 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010052.outbound.protection.outlook.com [52.101.61.52])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35a5v5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 16:23:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXAoDHIoHR63sb2RZ7+JPoOziWaM0Oe0ita4jDGnkudU2A3W544HcCk+ezHSmVbcuQhNwdA6MW7KLzaW+0RAKfMfsbLXyCoRteh1tvRTqBYaIlQBUaLurhGpvB0KoYKVf5H2RfO9yJgFu5/gfxMA1z+B4BLnAzo2Rf0qIhZRzCCqPooX+s96+oGZPK6lE/sVExFL23cHGKtsGGOU+yiv2EJANPBULwTuwAf0ADEC1Uqzn0gTK3kCE3Sm7HWqaDy2DBvhmh+e0o2KsHWidlMqfgpwTmNgvNJMZ1yLFa+KPeIjKzj4mIWacTIAlCyxegZ92jIXZysX79CFGfDDtmxwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNQpeShQ4cL02vBnKFdo035svMQsKXh4cxvhGo5AgUs=;
 b=T3oSU8VuObIBFgFsipY0AzwuFuydjScARMC6fEDRbjicxj2DvkbckM8To6ACnbIkFoCttYSKe48CgsAsbB+vtxyHa8/jdWk7dwyyVjZoqQJuyVAfqQci+ESlRZOOTjQ6L0zB7Lqa3bY2ctiA2fEf3wfVW/RRPi7ZYMDfjSIQCANFOuIow+u8+3l59Kp9YcYHT0ib7NkN6UTza4Fgw0LhOrd1ENYCKtbRfpp7crYA6xlyw0R13fgLtluubWDD3QYC6Me837ESM1QKWj1dCYwRNkC0uBMruK7ALE9L3Ru6K1YO9+Tg5tmUfDWpGr/DSCLsrbZOZFod86qbJR7r08TWhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNQpeShQ4cL02vBnKFdo035svMQsKXh4cxvhGo5AgUs=;
 b=hHSjarVctZ5zlnk75vCOgB4m03qRItIIpWYUVumQn9qGxKTcSumgJVzg/X8IriWc6mqttRpCMW1RwRujZihwsFHk2+Cqrstw9XfhljzKRpYgLvwYz5Y/7AhMcCsvriUcU4kuGiWaUl+x3mAMt4wkGpNudhZQWAmoIPTrUaVlqxM=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by DS0PR10MB8080.namprd10.prod.outlook.com (2603:10b6:8:1f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 16:23:15 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:23:15 +0000
Message-ID: <e1aa362e-e0b0-4a3d-bcc8-3277c95fb708@oracle.com>
Date: Tue, 24 Feb 2026 21:53:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2] iio: sca3000: simplify with
 spi_get_device_match_data()
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260216102453.1063866-1-harshit.m.mogalapalli@oracle.com>
 <20260220105001.7fce6c3c@jic23-huawei>
 <a85cc647-16ec-4b02-babf-0129e300a852@oracle.com>
Content-Language: en-US
In-Reply-To: <a85cc647-16ec-4b02-babf-0129e300a852@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::17) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|DS0PR10MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: d5667413-5008-40fe-3a83-08de73c1031c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0lUNlovWTV4RERQbEwvS2V6bEtDN1hDczcxY3FrdUQ1NGRTV0hzTmhnVkgz?=
 =?utf-8?B?NGRKNkdLWWFIN05nOHprc1NKT0N4ZDZueUVmS1YrcEhaRGp6cERQR1hKdDho?=
 =?utf-8?B?WlVXcmQ3dGRPMjVvNEZOU0NwUmhyc2pnWVBmdFFMeHp0OXRvcEljUlAwMzJu?=
 =?utf-8?B?MkNqM29OWHhZeGRQcVVIWTZvVUp4M1JtLzcxTVRwdngwamJDUjZBT21zZDVx?=
 =?utf-8?B?QlFrM3VIeGtseVZmZWtaTzVueXJ6NDI2NkJOZWdtaHFvMlVRZ1lEOEZidWRm?=
 =?utf-8?B?UjBudm1FS0h6UEtiZ1dldXArM1NVMTNxbUVmVWFLQmNuUFg5TCtJY0xWQ3FB?=
 =?utf-8?B?UDNMdnhYZTZYTUF3MXNla3pQWEFBa3lpLzJ2S0czNHdrRWxXcGZPUDZzVUpx?=
 =?utf-8?B?dTNjUkhvQmtiek9Rci9kRnpob3A2Mk9WanROUEFPcWJ5TkNGQzB2WUt4Sm9N?=
 =?utf-8?B?Q1Y0NVFISXdTcC9pZXlIbTkyZzhPV3lkK3J5dlNPY0wrSXk5MXdyMXA0Z3pS?=
 =?utf-8?B?Y0FuMW9SZy9obDcvbnQ0M3plOU1JWHQ4aXhSUjQ1aHFOTjB5anlFNi9zZ21x?=
 =?utf-8?B?K1Vid2pRb1lKNFVoSTZ5Q0JPZUltckczcDh5dTJHLzdvcHRvK0Qyalo1QUNQ?=
 =?utf-8?B?K2xLeEZWUG1rbUI3OUNWakJ6ZU5NcGtKQ3Azbnlaazd6OXE5UGRGUjRaeDRl?=
 =?utf-8?B?TUFZbzRtMlZkZzFCMHdPUEpMbzNVRks5S1NhbWtZVFRva1Z6d3VlMDBOUGtq?=
 =?utf-8?B?aUl4ZG9TaDR6eTZNUFVKTC9NeGxhSVdSbkEvYTRiWnpWc2R0QUxxM2tPVWkx?=
 =?utf-8?B?V09HbWkyalZTUk95dkJYYnZPamJ5L1NySTdrYXZlZTVuc2Y4QjJscnNRclpm?=
 =?utf-8?B?WHBoV3FNZlFlbWZlUkpLSUN2dWVvYWpzQm15SEtJS0dXYi9BOTFQUFpac0Yx?=
 =?utf-8?B?UEltdytDY2cwdVM5N2dwei9zemJjbG1kUWJMUGoxbXRDNVF0bnpvblphVEJX?=
 =?utf-8?B?K2ZFTExJYnJsV3c5UWpZQ1R1QW0wdGw1RWdpdnFXOHBhckp3bjNyT2dya0Ns?=
 =?utf-8?B?SUJ4WVVPYk05V2ZwTWRIZEppdnpMbHVsR1pIcTdybnExL3VONWpDODFONEpz?=
 =?utf-8?B?SlozRllyZ3VhS1dhcHB4dGxNTnlSbkx3NjVEMGpTUFpCbmI2N0g2dXhaamZG?=
 =?utf-8?B?R2dueGsxQzNoYmpWWCtRQ1d4Q2F5TXY4L0VZSFFSZGFBU1NqaXRPSjdDR0lr?=
 =?utf-8?B?ZHdBZWIwWExQa3M3S1RKS0xtSm5CVHB0aHRGK0RubDVFcXF6K0ZGQWpBS2dS?=
 =?utf-8?B?TmdOZjIyYzIzRWZGL3hJcy9CZ2xVUFFMeFlEbWYvNXNDbzMwZHhNNmtBSTRu?=
 =?utf-8?B?Q1ZVMkNkaTIyNVpIRGpqRVp6dldmOHFqYmZ6dHlNZWpjWTJhVUhwNTdUYjhO?=
 =?utf-8?B?U3grTFUxRk9aTDdSUVRXeTBnZjNqZXFBbDM4b1VCMzV3Ulp6ZFFtMTBROVdq?=
 =?utf-8?B?elh4eFRzK09Ca1NtYUF0TWVxbDZ0MmdaSnFrc0xJWUc5MnFkUENHMUs1WWkx?=
 =?utf-8?B?WTZYcE1UK1dDRWdxT09rYmNBRldRanFMMjd3VW5kV0wybFgrVkN2YTBwa2t5?=
 =?utf-8?B?TVNiMk5mUGhNZGtlOGhzZktBUWJJeG9FMlV6aTA5eC9WeCtRRXBCakd0QUFF?=
 =?utf-8?B?YXZnSk5ZZ1JtWGNvekFQZDRTRFRobEg3YVZWelF1WmVZRjFac2NSZjN3aVdQ?=
 =?utf-8?B?blNQdlZPTkZSVEFQbld3cDJHZnBBNmVCWnM0Sk9SWERYL0FTQW9aQ242Qit5?=
 =?utf-8?B?c2dLNkFxUFRURkEyckNpSHNMcUtWRVAwRysxR3laR1I4WlJEYW1LTEc1dXF5?=
 =?utf-8?B?OHFqUTlVeHhwZ0ZYNmxYNzdqb3VTcFNqb2EwSys5NzhYcTRtUlh1VlZFbitv?=
 =?utf-8?B?VzZpbjU1WkMxd0hhS1BVMDBqYXlxZWNWckp3Vlh0THB1ZEdybEMzbWxnSGJn?=
 =?utf-8?B?WEZiM1oza211K3pQbEh2VjRmT0lETUpiUGJBREVjeWxvM2d6aXI5dXNFTW5K?=
 =?utf-8?Q?IwuwZn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SENDTURaYjA0MHZmQWp0YjlPUnlPblcxYUhXNENaR0t2MEFNVjVlbmVBaHA1?=
 =?utf-8?B?bkV5Wm5ZMVk3K0p4bzIrTUVvL0RKWVo3YmtMNTFCN0hLZlAyckZlUSs0bW4y?=
 =?utf-8?B?TmtzNGQwcXNBUUwvYTZjV0tiUHdlek9xeWFiL0dIbEhYNVN2RzZWVzJiWDhh?=
 =?utf-8?B?eFJGdWV6UVM5Wnh6alJic3lYWVhHYVNKdXljK2NDYlNUMGNBYU9Yc0ZoVU92?=
 =?utf-8?B?UHI2YzJlekR4bXAzbHoxL0FvekZNQ2RMSUhOTUV0YUlSbXc4ZlpVV3lrSmZC?=
 =?utf-8?B?NnZoeVQ4bTg0eGppNzFsYzg2T2IxcWs1S2FhSVlaTDFvR3ByYXU3VFFwTVUz?=
 =?utf-8?B?VHRvazJqZFdtb3dhaU1QekkrSFFSdHV6VWo0Y3kwTmtGVkJyYjk4eS9OZFYv?=
 =?utf-8?B?aUdIK0IvK251VzlIdFJ3SVM3TnFXcmttQjZtbHNhYWZLQ1NyU21jcnF1blNQ?=
 =?utf-8?B?Skg4RS9wTmNwZWJ1d0NCelQ3OXp4Q0FoZjZyY2pVQTMzQzVRb0ptQUlCaW4v?=
 =?utf-8?B?UjNHT3pWU3lwbWxNbHFPU3VhS3pYWVZHRUw5L1VXcXh3VUUvOWh4M1ZyS05p?=
 =?utf-8?B?TEQ3MHhvd0JtOVRHVlYvVkJaMld0NVpnMEZUUFJwNEx1dmZ4MnllUzF5cDU4?=
 =?utf-8?B?NU0rdVc5STlDZkNzVXhIc3FFaFJYRTdLd2g3ZldyaXBGZUVNN1VqWHN1cm9k?=
 =?utf-8?B?OEJMZVVYSlNmNnBKaWhEWHhoTkVGRXVDRnN3dDVwcWJzeFZYdnFhVjFiL29p?=
 =?utf-8?B?Z1U3L1VRODhkOW1Mb1dxQTVCeWM4dXhWK3F1SHdDREszLytNUDBnZjhnNWFE?=
 =?utf-8?B?THM0TlRtS0ZuWFdDdnJxK1hzR2RLbzlUOVNiWEtBaUFDUytjMnVKSFJmMHBF?=
 =?utf-8?B?MVhqRXFVRDNUSEdOYytvTFZ4OStxLzA2RGx4OG5nU1VmdWpodFFGai8wQVdI?=
 =?utf-8?B?M3NtOFpUZ3dCTWVwNHFiWEUwZUhHSjFTQy9RVTJsdXBxdUoxYVBUNGxrUExw?=
 =?utf-8?B?dHFyZUtVKzV3TzBEOS9nd2daL2xhVStHLzJIT3I5NHF2T1c3d3lOcTFZYXZw?=
 =?utf-8?B?TVA2RUI1UWNJTjFCK1NVVjYwTWhRVHczN3BvaXZTK3RTbGtVWEFUSCtld1dN?=
 =?utf-8?B?eWh6N3pLY0hKMFdTQ2tEOGNHWFk5eVByeGtKU3VHenRzWThKZjJkQjdOSkRn?=
 =?utf-8?B?NUQxVFpCMi9zTlgvTFM3ckV1NWNsekIvQ3NlL1BteWQvLzl1MUZoOE1RbVhZ?=
 =?utf-8?B?RU05ZUtoQWU2eFVVdDV1UFg4TjdCUW9tZWFvSU4rVUoyWW5QVWd4NjBzZHpQ?=
 =?utf-8?B?SUlnTUt3MnhqclNzcmJsaC8yeXVCWVRZNSswNkZrNnFKNGdCK2pCaWpwSm5K?=
 =?utf-8?B?SWdUdDIvc2x5MGtLZHR5K1JTdm5jaVMyUHZKWG5oTHNTTUdBbGlZNVZNUzRx?=
 =?utf-8?B?RWNnams1RWhmNHBIYzV3Vm43WEVmRTVTYzM3Wk9RdFE4ZS9TWnFMZ2VkVFlU?=
 =?utf-8?B?cTIyV0pZczJSditocFpTN0pyQ2g0ajMxZ0ZOelJ0UUwvclVpTGhKSlFjSkVT?=
 =?utf-8?B?ejZRZS9VVXhpR1FTUmZ1RnFIYXl3RjFnTG8xVnBncVd4bkMxaDhuZURHblVP?=
 =?utf-8?B?UTRTSnR6OExOYUxxTE01ZUFMZU4zLy94ZUw2RUtiTVQ2VUFxR0Zlc3FiY1ho?=
 =?utf-8?B?dThaaHBTcjlNemhCMUZMS0hqc090b3ZEdVU2NWdhVlJ5TFJyU1lKL0lSTnJs?=
 =?utf-8?B?OEcxYW12NHVET2VIK3pxTGY5RVhkTVpRN0x6enBpcjYxYWNWbHRLVy9aTXlm?=
 =?utf-8?B?UXZMVTlEcC9mNzRKVVo5Z2E1RlhNbVJZSXcwb1hoZFFZdnFwcS9sdXprN3dp?=
 =?utf-8?B?RVoxKzdlQzlQTHBqcW95R2NLYjVXMGF5cDJBUTFTOERvY3hXbDBTdFdReTZl?=
 =?utf-8?B?emd6ZUxrYTRQL2Y3bUFTMHFXcTZLejl3S056cjRwb0NYMnFLZExzYVZFSUdx?=
 =?utf-8?B?WXc5V3FjVWEyN2dDUHdSSjF5ZW52RXJYSmFYelE5dXJHdDdianhSdHY1Snc2?=
 =?utf-8?B?YXpoNHZZQStTdXF0a1hSU3djdTVtamZ6SDc1MkpxQkF0bTJVcHJrd2lLWEpX?=
 =?utf-8?B?MXZNcHBnTkg2LzJENitiUGpTWFRNRW8yZ2ZmRUZtQjRZWlhFMFNzbFpmUUZv?=
 =?utf-8?B?YlBCUGF3V1lSbEJLdGJmL2lPWU1oYmFhN1N6RlhFemVqa3dJTHhQU3V6TkFj?=
 =?utf-8?B?M011T2d6RndiZ2VnazBEd1Z0YVh3ZThXWHlwbkM5VU5yRmpEbTNIOCtlRGlS?=
 =?utf-8?B?bnVCcFhnWHp5Z2NHU2JtbzNNcm1IUkIxejYwUGxCNDNUMEkvUmlCaTBSc1Ju?=
 =?utf-8?Q?Gu7M7Yq934X64fFw2+w8WPHRx6kIC2pLQ9hGG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G0wDn8V77PDIrYddy9xp2n7Kjpc1+gJvHKlHdj3pQ/M36XKBA/IJzfPcrvWr4+oe7YkL1o7jogQyOBf3X3sYXReiFUC79vrh7sFw9pNXukMRsMDjjiyJOHH90H8siABuqxHUMcYpgvRobgfp7Qe92KRzKBGFWQM4LPQz5RGUDMi6kxnXrsYxpXpDkYo5f+qgUkO3JWn3XJ7R7nonCoCsyOUeiNlE3cirRaX1XSKjECx2IXxyVLmEdoDYeI33fAd43rqiZKN00wc1LOPu1blFLhffsMsFZ3/Tg6/F4Pxht9lPYSJ20KX5WpbaBSs+Nptp27RE56LCcZM8rMbKsop+0ugPKUCuHWki25z7DmJNO+hRgWIe/dCoV0M4ZzW5uqDcSF2pTWlmdFFYA0/730Uai4sLMzfCpZCYJ1mOeMifwKoFQquzmbdY7TsoSTgdQwqqT357zSiPzCP8uIflfU+LxRJKmS3JO7xF/buWGL2SBA4XMjhcuVq+gLutAKBbxYVe5ttffGr8iJC6csZ+C1S1b6DurZ1at5usZ8CaAv6mQ3PpCoaI28/6bK/GnOG0VH1NT3s2bpsP8CRjDvJsiYvhG1kbiZjfTORpFCGOAtGlyBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5667413-5008-40fe-3a83-08de73c1031c
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:23:15.3319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yp3T7W3GTo9ND59x2BgVCtbMfQls2oxsLvFru6T3WAjU06HF4Q11YgfENyxzldG2zenEnH9Xeo1ljovYkHoneq2RqrVluMftPg6Yol9v04RT97ALWbagiMY4yNHspG3i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8080
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602240136
X-Authority-Analysis: v=2.4 cv=O5U0fR9W c=1 sm=1 tr=0 ts=699dd083 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=pwRtVjG7yUonZ6oWgawA:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=z2U-W3hJrleVIN9YIjzO:22
X-Proofpoint-GUID: 6o3FBRe1Bs6HqS6lqE9ZEEtNY9HZisaN
X-Proofpoint-ORIG-GUID: 6o3FBRe1Bs6HqS6lqE9ZEEtNY9HZisaN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDEzNiBTYWx0ZWRfX2BhXrx0rPbs+
 zY3NZzani9+ETNIE2soWVoVtZNxpD0alpasG3Ywx4nyNL3CCPB/9tYOa+oDfKgk8Fi4zX3FhTWg
 tFkdXZodYRRqExGkuyl5b4CO4wOhvO0sePnWhwh0fRhGLIO1iNH47JJhbHJxCMLHoSIaROX5IYo
 jKjabB+dSHl/RSrJUQRAv76M4Z+5hGIIaTCd2mYOSqqnvhMO+PLlcVSWqGKPWCZtKqbceCoZ+ZQ
 rgcloj9xoNqV/h0qF0/wzz6VKbvNEr3jZK2y2U7jbYEnPx0K3weWwxvxPvEL+2XXLsQr56kAy2N
 BJUv6mOgJXxr+M9hfoNS6k2AErhbmSP0HTrBUTFvYfzExy86sz3Wi4S6G2Lh6R7xlPI3Gak2OV1
 sMM7MSpWT2j7HsgkOhthkriZOxnVTxcnkxZHNJmxygM4dktWrTMkLo/McGnvBePMzF1g3SmDPrO
 aoAKC48XYk2wIca5qxw==

Hi Jonathan,

On 20/02/26 17:15, Harshit Mogalapalli wrote:
>>
>> Applied to the testing branch of iio.git.  There was quite
>> a bit of fuzz (line changes) but was all straight forward.
>>
> 
> Oh, sorry for that. Maybe because these patches: https:// 
> lore.kernel.org/all/20260205195845.4e108117@jic23-huawei/ were not 
> present ?
> 
> I don't see them here: https://git.kernel.org/pub/scm/linux/kernel/git/ 
> jic23/iio.git/log/drivers/iio/accel/sca3000.c?h=testing , so asking.
> 
> This patch might have applied cleaner with the above series applied.

ping on this. Sorry if this is being tracked.

the possible reason for line changes is that 
https://lore.kernel.org/all/20260205195845.4e108117@jic23-huawei/ 
patches are not part of the branch here:

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing

While working on new patches is the testing branch right branch to use ?

Thanks,
Harshit



