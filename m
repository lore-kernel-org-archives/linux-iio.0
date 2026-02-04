Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EB7389441;
	Wed,  4 Feb 2026 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196883; cv=fail; b=RDqgubNJkKinKY4hjimCZryismSLD+JX+wL3uqa2PH5Ib18+3WJzNB4X358Jjnh7KKfJyjmR3u03WpW3b1praL/e6qtiAvm9qCUBUQl1D4xrv9+aHSAKxaqasd3eKLHgsPCKpHz4D0z/VUXpv64VDl2jWxOS4wWGf+8niXa8scw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196883; c=relaxed/simple;
	bh=gzGsRtAO9XRRJhwHfbVaGB6YJzy//4g8uZD427eCWBs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JdeJ4HPSDGBgkg5ScGtq0AJG3DgUiZpqd5Awvgr+S25yXTcmCIuMJ7HGCDHZU34T4gWngRUirPw6FuUtImVTegIGuB0t3IXvco9lXtzsVbs4UluIQyWCdJ4FhNrslNBibeNfY450I5dJUsKZnQf2/uDq4YVN6VFHBqWmNzOyN6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XDyNgB0d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A8IjexhL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XDyNgB0d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A8IjexhL"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613IuJTT4161566;
	Wed, 4 Feb 2026 09:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+NgIE/cW34Y1WRe5u/6GJQo/RiO1bWzOZg9WICP74HU=; b=
	XDyNgB0dE3S9YmXZNr8h/UFc8HA2Dt6B7E+0NjN3KNqyaocAGiuyt4kN2C0o2qMo
	MIXSYubrAbT+65Ul4LAhL3XE/MD6I84c819Rifm/tLizY1Q7Q6si3x3gfJcJcyBK
	/+oihMYsPpHxCw3JGnZO9S3riVimp4d2UWEc+kkyMZNLnl5FmL3ttS+fW2903+W5
	xkgKP3xesQ/Akr6VSHRTsUM3/IN6HLgNEjjpOMqIzIckRRJ6mq7l0hR4KOhBrOGA
	H10XOCISSbFb6k/RzStBy1HE593YMBDfyJf/P3svjf41jgjPjwFK/muo2KHg+Ecp
	CKkJ2bHltah8whTyh32oEA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3j8uhgxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 09:21:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6147XvOL034732;
	Wed, 4 Feb 2026 09:21:06 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011052.outbound.protection.outlook.com [40.93.194.52])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186b5r8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 09:21:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgaKdvJOPwIqe47K80hg8YRqMLhAZq/GqQUrQ0OHkMFFIFHTBZ9kXlwWwvU7T1WLKCABFuO/W4/FfNxfY/raStvRaZcd9/lCXmrVwMNV0RsdhuE9VpvUycRZDXGTtzwCRlv2XT67H4Y2PE8/KQaqG++AzGjgHL6w7V1dj+Qo/9sYYEWEvUoUDCVeT3JA558qJxFG7e08pVfCuAw9OQEOXcFKXT+jI3qKFKPi7kil2W7TejwINHak/GF1OPehHmsy2kalWp5Wnum4IgvxNT8qJbPtt5IlCKmS4cTld+YPQAW18wFqmk1fhsmFS6tSspDj8U6uGHAFhEctXXzHoO96pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NgIE/cW34Y1WRe5u/6GJQo/RiO1bWzOZg9WICP74HU=;
 b=NAbyy09IUidFZ2whi84swqAFaFtiSd+pp7qKQ7GesMQOca5QVt9g10g/9SCkcdx1STDxy+lzSvQWCxXO754LyYopzvunQGRpCV6Mi9J6lLhqCWHIyxZqcnJaXiz81BaWZmAPXvSO/+7iYyZ296LzpiKG9K8PlQxnQ+g0TeQJcIrFC4alSoL1WCgYA/2kZnD22AQqT/q/m2ZEdovmMKClNCspQPO22uwSeFqkJZqwgVRL/DZ/QrD8cTtYIcBNrCrVSu2fXRnMZDlGQ6DxpvxmF8HXvdYU2xLpyZHRniA+ZxO7juiBfJexeSnfiXvVcyO1c+xMZ6kuGJGFp0u5Domxxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NgIE/cW34Y1WRe5u/6GJQo/RiO1bWzOZg9WICP74HU=;
 b=A8IjexhLmghR14lsvJoX9RFjQuMTKWSF34FRK217OEMfrsu76dhhBdXCJE7fJG5NqFnJQqpFC2dLrd6/WciTp+jEWwNsckDrADl7U9WSKOAPLOQQAGB+ZMx5yvWjJnEPCJFY94foT4f8NA6RBH+tIWhPBXicgc24QKGLBn8QrGU=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by SJ0PR10MB4526.namprd10.prod.outlook.com (2603:10b6:a03:2d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 09:21:03 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9587.013; Wed, 4 Feb 2026
 09:21:03 +0000
Message-ID: <6423132f-37b1-4db8-a654-437804b2f31c@oracle.com>
Date: Wed, 4 Feb 2026 14:50:54 +0530
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
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <aYMLeAaQm35-4Sgl@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::8) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|SJ0PR10MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: e465102a-66fc-4f36-bb9e-08de63ceb78d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SktNR0ZiM1NTbkxkQ3g2dXozTTRUblMvemtwZkFYMWp3b2xjaTdJZHlwc2M0?=
 =?utf-8?B?S1p5L0dKdk00NjhtZWo1cnJrdTVlbHpyVEFyVElORTA5T0EyTXJVT2NZQ2RT?=
 =?utf-8?B?YVBCWkxsY0lOUzAyVllkYXFEaFRwT2d0R0toQS9RL2llMWwvdytkbnEwV3cy?=
 =?utf-8?B?WUFFSlNKVmxGYnpveFA5U2ZMR1NFWThwMVl0TGtOMW5PS05qTG53NlpIWXNj?=
 =?utf-8?B?TE5vUEFwMGF4UWkvMkh1eW15UXpkWEhaRWt5WUpHdTJGSXZYVlAwd2J3K09j?=
 =?utf-8?B?aU9tVm9hMmJidm4vcW9udnBFc2ZwcWZaZURscVB6YTVlWFNac1RWQVpnVldy?=
 =?utf-8?B?RlE3b3BMNVhHeGRmTWRMdVJLNzljWVgydzA4Q29yazBwUDRKQjdocEN0bVB5?=
 =?utf-8?B?SFpGZjdEY2ZBVVlVeEw5emtORzlFM1RXOWlya1RsRnJWcjhvek90YUxEdnVt?=
 =?utf-8?B?Si84L0U3alUwNVpSeE0yQ2k0U0J5am1HSlRJQUFaODJPbmg4SUdUdFFCSVls?=
 =?utf-8?B?SDAvenl0MEN2TTJjU01SNFo1YUFMUTBWZ2RuTzJSMVBpSEF5VzZYYjZGVDN6?=
 =?utf-8?B?Vy9kOElFWjdNSStqMHJucXNIbnVHZDFNbis5TlNlTVA4ekpFTlh5NVNyRGky?=
 =?utf-8?B?SFRKOHF3ZDJQZlh6eGdZM1FSZjlHQ3lGNDJ2M21COWt2a2Z6NkFDTEtqMkJ1?=
 =?utf-8?B?cVo0TFhvcWlZM1k1UnZvVThlQ1ZiNjRmUnE0dyticHEwWENranFqS2EwR0Y2?=
 =?utf-8?B?bWZPcCtsSXVqZk0zVTNlOW5XZE5vNFhTU1lYeUF2TW9oZW5qMXlaYkhuODVr?=
 =?utf-8?B?R2c0YzhHRmdCcERjSjVpdWh6aGUxSlQ1NnV1dVFuTFh5SGFIZnNLaVJZMzhN?=
 =?utf-8?B?TFh2NWd6ZWhYZU8yYUlCVjdyUGt6d0RkVUQ5VmNwN21jeGNsV2JQSlNjamdH?=
 =?utf-8?B?bHIxcUFrRmlOei9YOVZRa2F3ejNUa2JaWlpwY3pZUkc0Zy9acVJha2lmUGFG?=
 =?utf-8?B?WkxKeTZxN25Od3JlZFVrM1dZNkVxdWlJdGxRa3BaMkdjdEtkV0pWSjJzVTZH?=
 =?utf-8?B?TGJBMGg4QVRzYm44TEFpdEloQjdXUm4rUXJ5U0N4UlFsQTI2Mm9CbHZtQjcx?=
 =?utf-8?B?b2I3MzZZbDlhODdmSkIyQWthK1I2d1d1U2Vnc3p1YWdsd21NZER3Q1FYZGtv?=
 =?utf-8?B?N0F1NGJHUGJUOVVIcjI0cC95RGxLdi93WG9HVG5wNVJZcXlFQzVuWlYzUWNR?=
 =?utf-8?B?clpMSU4vZVpPL1lKdGM4NVN3ZHFiczhSTzBoT0ExYXNBMHdQM3h4YjhZV3lN?=
 =?utf-8?B?L3NIVHl0bmt4UElFQzBIQXRXSFlQQmxvYmJob1ZGRndNRHZ0bzBQMCtsWmpv?=
 =?utf-8?B?aVFvUE5MNG9kaWVWcXA2bGY4LzdkUlVNTzRYUGhzbzVaUTcxTFFIalB0enY2?=
 =?utf-8?B?VCs0Qm02VUZKeitrUnFGMmRhd25Mc1Vady9aZC9KblBuODZ0T0FVOHJQaUFX?=
 =?utf-8?B?SmVXN0wxUUd2NVd0NjNITFJuRzU2UWNPalN5bE51ZkZDNG1ld2twdG5kRDFp?=
 =?utf-8?B?M0hFQUlJbllhNVhvTFljWTgxc3lnc05LZUZBRSswMFZIejBWYmUvdnY5L1ZX?=
 =?utf-8?B?VDk1UExTTVNtRDFXRWVWSjMxM3AvS2dNZ0JKVitReTl1aDhHdnZMSmdiRmlw?=
 =?utf-8?B?eVA0TDJMTjB2VDlWRVR4dCt6SkVaWWpya08zalBPV0xPYmtCWlpWOWpqbW9l?=
 =?utf-8?B?OURvVFV6R0thVU5kM2FDT1hiZGRTR2wzL2FJTG9KK2FNZERlc09aSmU0Vkly?=
 =?utf-8?B?Szg3T3JVYWw3ZGczZUN1QU9kWXIzQWVzK005a0hXditZMlpiRmM4WXpYelhE?=
 =?utf-8?B?MllGQ3NEeWFVZHlXV1IvUDA3RVg1UHd2TGtGLzdiUXZKek5GQmR2UkwzcmxM?=
 =?utf-8?B?SWVFSDVONkxFb2J6Z2xBWXFIQmF3cnBWSS9xMk53bHp6NEwxY29xUWJ4amE1?=
 =?utf-8?B?MDBqRkQvKzdtcWNZMnlzNFA3K3NTWGlJTSs1dmk4Nm1oVlNDR3NmMEIyNEJo?=
 =?utf-8?B?V2MzeldaYW12bmx2aEJUblFoalNRYm1YaU1TRHJUQytGR01nUVdvQ0lqR0FP?=
 =?utf-8?Q?RuwU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHYxNVFsdXJqV0puSWZtaU9MQy84U1R2VUNNQ0s4YTllR2dPREppWmFqZWpw?=
 =?utf-8?B?eldZRlFhTUdKQzFaeEtmNllzQmZTM1A2c0N2cDljT2orVmpFRmpmOFNibjk1?=
 =?utf-8?B?YXJVY1gyL2pFOUtvU1ZFbzVRMFhtWkI2VjZaMmI5eDlYZ1lwVEM4T2hqWmFH?=
 =?utf-8?B?ZTJONzVsSmY3Rlo2eEVBRHJockJYelRTdEJKL00rUXBLSm5Bd05zZGdPUGhK?=
 =?utf-8?B?YTV2MWs0ZHNNelZ4S0dqeWFXalp1RHkrMStzdis0RFBqaUh1WTh5eldHam9U?=
 =?utf-8?B?RGdxZ1czQVZJYlBMcHF2Q0pXRlFFNDBCZTRiSFphMVRrMFE2dDhOdjRZbHJI?=
 =?utf-8?B?NW44L25iZkVJaGYrdFpYbFhQOGtaazRCOWpONTRqZmxKemZiL0grdU55a2M0?=
 =?utf-8?B?WVNGVHErWUVobFJvSWx2UVVNZmxya1Q5REwxbWl1TStFakJmejZCZEtKZVR6?=
 =?utf-8?B?SE1aanJiNUpmYnMzMTVVZzNxbkFteGhiVm4xTDVCRmJkdWZ0bEhyWkhtb1V1?=
 =?utf-8?B?WDVYQlJ1bHh1MW0xakphSlFvYitGak9WUVZvWDdNNXJHSmRhYk9pTlFrcnA4?=
 =?utf-8?B?WllLQUo1THlGSFplM0dtMzI5RzExUWVYUlR5SHJVdWFTQ29kQTZ4UEJFYmVy?=
 =?utf-8?B?MEtCODFqRmd4eUdMSGhZNjhuQmlsdTgzZUFPNGYwbEhBOUdHUWVjeEJheCs3?=
 =?utf-8?B?bXpZQnY3cW5ZelVza2k5ZnFKV0RSdTljNmZzdkdKN2E5TmVVZ3JvRGJkaTJu?=
 =?utf-8?B?VmFFbkZ0NFZZVXZpSmdlZnZYbEgzcEJRV2l0NVZUbzNwQ2hoTGFsQ0QySEVm?=
 =?utf-8?B?YlRZTHZwZndZZm5wRVpESjFWVU5oUDRBalMxS0xoYTF4VVpibVJSMGxTdm5z?=
 =?utf-8?B?bFIwNi9keTh4WEtnUzdXVmhzTldvTUNsSE50OFB4Y3cwYXBQcG92U2FDcVh2?=
 =?utf-8?B?QnZWK2JqVjY2bVpDREhVY1FKY2RSaVg5WW1YeDNqbTcrQ255RDBkQmdzYW1O?=
 =?utf-8?B?SjNTaFVhbDAvaWlYeVdVQ1gyKzN6UnNaMDNOUzNUNU1mTnRLV2g0WFRNeFY4?=
 =?utf-8?B?N0NRK0ZFTElMZzJCK1JHeGgrbjV6TXZsZkRKbHRFSUVhOVpVd0hoZnM3RFRS?=
 =?utf-8?B?bjBobW1NRjdHOFQ1ejNEMEFBL3o2UHY1Wk9kVnZJS05BMXJsVUxSZ1N1aDl3?=
 =?utf-8?B?ODRrNEltOGNWTGRxU2dMakFwNVZvYXpGNHRTNGlqcnNRNTBaQmE1Q29Dejlu?=
 =?utf-8?B?WDlTbzBDZXJlaHEwNkY3cWd3Ym9CSVNYZG1YYmVBR2ZQQjhLd1gvMEozb3Rq?=
 =?utf-8?B?TDJxNGJiTVlscTBlVmIyeW4wM2dZSG1rRnIvNjdPMTVIUVpONkM0RFZ3RFRk?=
 =?utf-8?B?U0t5RmhEd2ptRVJQZWZoTE1uaDNsc1ZUNkVRQURqaGJ6R0xWdDVmemNTVHZu?=
 =?utf-8?B?c2t2cUxVZjM1SzBWemUwQ3NFWkVqcUlIYjhlM0JXdGhzSnRKREpCMC9VbnRh?=
 =?utf-8?B?US9DZXJXZEtGYUJzWHFWZ3RiUlUvZkZBQXVlUDVNUTBrMi83UjhwbDJHSlJv?=
 =?utf-8?B?Um5kR3pYVTVhK1BCc0pPbjlJSHd1ZS9zbmdwZ1NLMlZ5L0l2bmI0MHZVMUNs?=
 =?utf-8?B?SzZSU3FqQklnRSsvaEtFZStCTmthU3daRlMyUU1LV3QrNjVFcktNTit3RG1H?=
 =?utf-8?B?WEdIMVJwVGhocWxNcHcvMmxOU1ZnZGlEaTFGeEZTOTZIUWpDbDN1b0hoVmNJ?=
 =?utf-8?B?VHZTZmhXNnVFZFA4ckNjUWF1L0pDTDR1M3FpbndjVzUvWjdCOWxiUmxxVm1y?=
 =?utf-8?B?RmRZVlJzempTcmkzUDdCUWJCdVl4WUNsYVptSGtlSGJqSWcrVGN6c3FIQk16?=
 =?utf-8?B?NjNOT2huTXQ0ZEFMV2Z0MldneTNVM3BrK0RRNmFlTzhZRUtUZllzZ1ZQaUFB?=
 =?utf-8?B?a0c0blppRGJmZzIrR3YyODNaVlZ4MEo4d1pmUUdEUkxMZlFaMnFuTzRMcHo3?=
 =?utf-8?B?dFBZL3FvejAvRXQrQzVMVjk3SGFrTllxRWd2S21Qa2ZoU2lBcFhCL1JFL1ls?=
 =?utf-8?B?a1p4R2diSnpDc1FNUUM2YXZtN0w2T2VIUnBXR1gzMGpBQ1FnWFhCallvbUJB?=
 =?utf-8?B?dlhaYUhrUUFpK0YweVZVL1NPNmlBYXNQMGhSWFFVMFdXWEl4aWQ5cUk1ZSs2?=
 =?utf-8?B?Q3cvTHVvYWJadmpTMWFCdVFPTStObVh4NDJ4TWZJamovbG8zRHlobnpyQ2Nr?=
 =?utf-8?B?Qm1NNXBSdHdXQXNsUFNNQXB5WmdxVStpNGRNejJHbVEyNWxPZWpLbGU2bmg5?=
 =?utf-8?B?VkRXQldiNUhVR1VJSWhtUVA1dTQyTlIwRUw1SGx3Nm9GR1JiUmQ5YlRWenhi?=
 =?utf-8?Q?/Jz7jFrVN9jhGFBeHvrJiHXXoBc8Gnk1v9AAj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JdrgbdHgwy75OVdDY1+3tulkcXRLXRBsVpxo21nXFKq29jV9hUwOESuRM+0/uhYMXvHrgnEDGtHf3J5aRhhwQD1ZDlKVvQKGG2cEUZho8g8rdXEpkh6IqZGfcWj53zLDrJ+4fcJHKZ8yWFbrImN5kaelngCsAS0ne+GqDANPiy2BYoiLVOKUnZfwZ5zSuxfrStvn9PEHGPN0tYmuPOX8HeNZpvgSigJoOMV5A71qxzQraKzys5PbN8FtU8waLR7gj+1iJJue+4Qx4ygDUlj7KPhd7tYe7p1NTi30+IINf0r21VbUPXrX7Gq3dHystWf7yTxJYXJe7YBuvpwe+irOLHTsopg8a0QO3sUEBxxVVFQC4IqFdIzwvaPCoBU+9ALWm8GHpp0t05hQ/6mnnRykmIjk8rBxWTC3s775rErBmFlSEX7p5peUQmrQQ5Y2q4hHpcIXZZezJ7fH4iwoM4WXxarm9ZuKgptGp+NDyicG8HJoZNvdpv8IxiQ0OmyKRaAoq5Rxljkxa+mwfg4t/DYdyakXBK9NPMe/ICZ8BKThu2R6ry0VpqKzjkfZyvF5d3f7yw/Cx/hGWLg2aef5SGUrjQ39U4YR1Oh9OOyi5w7zZic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e465102a-66fc-4f36-bb9e-08de63ceb78d
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 09:21:02.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tDYxpzgnWIm4VZShtyM8ISbVqiWKbpO8NUkeDfiD/AoouMwFOARqjFpOhcS1n+tcnN07WJHQLFmA0qEH0Cz3lOXU2P15JHvsDGJV1iQnfB6hWND4tglA2vRqQP9OZpk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_01,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602040069
X-Proofpoint-GUID: SgosqHQL1qID8HN_Q_EMhAf_MW6zFy_j
X-Proofpoint-ORIG-GUID: SgosqHQL1qID8HN_Q_EMhAf_MW6zFy_j
X-Authority-Analysis: v=2.4 cv=BJS+bVQG c=1 sm=1 tr=0 ts=69830f83 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=X_E621oe7_-VAHwxBj0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA3MCBTYWx0ZWRfX1vvhsx+mKYE7
 UilrtyyBQaDdqpuAHtBL7ztCY5tOpfM9IG/F9YyrBDr1dQmlzs9/DSOHVwHi02lTv7XGXXhQcvD
 ljegB1sAIqhgoP2UleNkd4ePmIis4F8rGw7ech72gT3bTLIax7ZNV02Z+EswF4GFPEa8hzcBG6V
 ma/dc8i9/cfpwV4tSLPy08+eV76bAtO7H4xTH7XmHoTr6IYM5TlUmlEr5568ekeRfVF45RLfW5j
 8HSd3SSz6B8vNqQZECTQ0u9ohsL7gku4DuCNo0Cz/NxV6YXJ+90Ceucs34Qa8ztRO5o4aZJVZRq
 AWX9DB15rYYDZ2HFtSplxgOPc/wr43LmkPJhAITwfcXOGv/tvNwqglu1NE4HXgXaX84ejXM/TZs
 Wx9tHKDoAAIsr3awxpXd5iyqM5R/xzqCw0I/3nqnJyfP03r7KcFYnwKm8n4bfk9DYuKKRc45Vv2
 5LVX0fkxTL8XKmkVzoA==

Hi Andy,

On 04/02/26 14:33, Andy Shevchenko wrote:
> On Tue, Feb 03, 2026 at 10:11:58PM -0800, Harshit Mogalapalli wrote:
>> sca3000_stop_all_interrupts() is called only from the driver remove
>> path and its return value is discarded, so convert the helper to return
>> void.
>>
>> No functional change.
> 
> Yeah, as I just replied, the prerequisite for this should be move upper in the
> code where you are going to use it in the future.
> 

Sure, will do that! That would make reviewing simpler.
> ...
> 
>>   	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
>>   	if (ret)
>> -		goto error_ret;
> 
>> -error_ret:
>> +		goto out_unlock;
> 
>> +out_unlock:
> 
> While this is correct change semantically, it's not needed as very soon
> the other patch drops this for good, hence leave the label name unmodified.
> 

Agree, I was doubtful on which is the preferred approach as its not 
really a return anymore. But thanks for explaining.

Regards,
Harshit

