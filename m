Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E06822339;
	Thu,  5 Feb 2026 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310179; cv=fail; b=IxtSa46EHSb+cJ14Jj9NxZ0nTzT5f3JFf1FGMyKShcUmPcY8QyojMQWfopDIt9d/06hU3kM8jK1u7ioyX9egFD/9bWOcFpjuDqAgqRXI4igy/reHpCEZUAuc8kd6U+0ttRZlLF83P2B40pC65+XRgYSRlgT5WUn8As1PuGKQzsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310179; c=relaxed/simple;
	bh=ykFMs0Kk+7JXsmup+1ayaC44PRehYYwKgoh7pNZsly4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V6CRLlMtQUswlcUneZLIwLgvuxe1XMchXUUTkIT8Wg8okmYFGfhUTcGsGUoAcWhH3Sc0RFUu1aR8cz07CUasbIvblhWnrC4S77LsXcMyIETEoKuEzgQD4F5J72lU3u87A6NLgTWZxufWuby4uXf+ScvvhuViSQsKsKFnDczTG94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Nzmccc+q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VBOFTCmJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nzmccc+q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VBOFTCmJ"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615Fu8Xn730851;
	Thu, 5 Feb 2026 16:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XXLDmEwEN4ernp1Sk5Na60lB9F7/1e63ZFnM6MzqOp4=; b=
	Nzmccc+qYUonnRwiuKiDj+AJmFLC9ZsDql0VmHFEPh2Ajt7HUdI3Nx4PYbOclESh
	IqyJrnYcvGVxzBU19IORwtyInG/6FFRkAzo09C+bCOfwFLNp9aUC1GIOTthjiK0k
	vO2onVPzKh6dWnpTvxAx9idtZiMNj+eERc/2QyYZzr+obBie6asMrnQVBbnRDlFu
	W2yjiFy2ZTbDFWhZ9g/XgtZ9wNALBh3CcmqHq6lpUKxaiVpMLQM+1KeFUdDBOS2u
	J8sECiZCcRY01SL8v39Rd6SO4f8Vf1BUuZKOt55sXdttNfP8r1Ltp4BXWygKdngl
	95GtBSxcjJwl+Th4q75eAw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c4dc3sd1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 16:49:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615GiZdJ006054;
	Thu, 5 Feb 2026 16:49:32 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186dec3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 16:49:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHx1BJYD5oETKeia23akldYVaqG3qLHbZbCh/pzyJmuR9gAvKuwQHgu4RiemGVMhdjzfhvXzFeYgYkpBsAfkT9zjSdYDQ3XT12/PNiDJ5fMEpgb9Ki0yofSFmZE8BPKSbGT2PPsuVahgc/+W3okkMCdCgNXdiyArttdT2tG5EPah3zauMp2L0k6z0S2lCoZrL6pbQcPjEm1vGgCs62wwiwgP1JBhw0Fzh+fu2aZ1DXlOg6FpzHQDQ87HIiD/jw4xBRjz5YRuprv8KJe/YVDAB0AwcaDuqzWoDX0amybo6D5Un66n00skr0nqmN2bf0/aLCOWMVb3qujKYwRLQG5xAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXLDmEwEN4ernp1Sk5Na60lB9F7/1e63ZFnM6MzqOp4=;
 b=k0SF5/FuL7NBkftYDdKF6D6zhKwHmZ2A+O901jDurppVvm3jaM7efXO4qWh7dPfCOQE2SYPXobFxKtQxnbIKak4slDnpCfVPeK1Jo8yAYZJ82BnhUBfdTJI7sfYLIDPyw0x5y0H7i0nvJLekvTFz3qnZzwK425nlgqZ3TU0gW+wj1bayde/PlinocKQx7KQexkgi5CwNvOA7rzyHoepAkJtbSd+LOEGcfVMNBEtOgU2krrlGnXR8ah/Hkt4y2RgiQmCOjCffS8wAIMPmr79nnPYTe8BMganaGIUQu+rYGGH7dPf05M6cqVbwS2SiAxo9aNxExBVh3UiPAoFDwAMSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXLDmEwEN4ernp1Sk5Na60lB9F7/1e63ZFnM6MzqOp4=;
 b=VBOFTCmJd+o+VPIe8gYwvzl0t1UCwjsdOGadLp/tleMl/EDYBAhZDu5oAu4eV4rVMpmCg61L+5Uf8ps3GRI8LOTMku+vibhgTuMdvsCs8CMacGBhxSUYUaj/4ESh9eMV0V8NaxXqkiu9rxzYZn2+JkdsLjwVW4LgJTr9d76FePc=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by SA1PR10MB6496.namprd10.prod.outlook.com (2603:10b6:806:2b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 16:49:28 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 16:49:28 +0000
Message-ID: <0aa381e4-453d-4412-aec8-589f0f83c2fe@oracle.com>
Date: Thu, 5 Feb 2026 22:19:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 next 2/7] iio: sca3000: switch IRQ handling to devm
 helpers
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20260205131234.3244467-1-harshit.m.mogalapalli@oracle.com>
 <20260205131234.3244467-3-harshit.m.mogalapalli@oracle.com>
 <aYTD96nmDAEZd-a8@smile.fi.intel.com>
 <88524db5-cda6-4529-83db-54ff3b3d5819@oracle.com>
 <aYTJKaSt6WkMRIJY@smile.fi.intel.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <aYTJKaSt6WkMRIJY@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0131.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::10) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|SA1PR10MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 55805907-082d-4174-c22c-08de64d686da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MG9xZEtxVlR4NDh4WFZ0dld4ZUZVZ3ovRjNTak9jTFEyQ3R3eE5oeDlDbVBX?=
 =?utf-8?B?b293WTNXc0JrS0l4TmdvQVBiOGdld3FkbHFHYzcrUWlrMEJDQVFYY2c1UXJE?=
 =?utf-8?B?d3pnMnBGeWR1RHRKMi81Z211ZnI5ajEwM1pITzVMK0tGQmlYR29sVGIraGpD?=
 =?utf-8?B?aVQ4RVVIcm83cnNIdmFxUnhveGlBbW1CZUpZQzRpVWZpaENmVnBPOWVrd2x3?=
 =?utf-8?B?RVBBQzlnNkVod3p2aGFlTER0bURhc1lJZi9laVJXZFNhbjEyck1jSTByVEhC?=
 =?utf-8?B?ejBzRDgrR3htYU5XUGVkVU10RFRVbmt5T1RicVBNd0hHNndtTWRoamphaVRi?=
 =?utf-8?B?QXpCcjQ1RVd1L01Dc2x6OUI1S0ViaUJVRjhGdkhlakVEY0J6ZlM1UW1ZQm43?=
 =?utf-8?B?YzNXUkJWbUl2amwra2U2ZjlaeGFJM0tvcm1tNGR2dUhmYmsrZ2grTFlnZmts?=
 =?utf-8?B?NmRiSjJPWDMwWUEvSFpKYUZ2bDRnUmRHaGtqdHk2VlZNeXVaUnVxaFhTY09F?=
 =?utf-8?B?SjFDMkFOM0paVVVCM280K2hxMlQxeE00RUZLTVlUbnFsbEU1YS9EN3VEWWFY?=
 =?utf-8?B?UWVMRFc1RjFkUzhPYnpGN05OSzZUOG5rUktJQmNYZmFWSy9qYm1lS1Z3VjJi?=
 =?utf-8?B?U1JjSFJxZ0JaKzFyWGZKNlorRlZtOXdUK2Qzckk5dWlTT3ZmSllyRGFUTVUr?=
 =?utf-8?B?d096ajJEc0ozSkp0eEgvd3BzYnkvZXhCWDZIek96VkREOUhjcTV6UnhlNmVt?=
 =?utf-8?B?RHdkV3ZkWEo5OVloSjZMa3VGMVV2MTNWSzI5aVB2eFdGdUh3aEFmZmsvTFJ6?=
 =?utf-8?B?SFpCSkRiUmNLd0ZNTmEzQS94a2NxQk5od2VFTjdtVHVQZWV6Z2FMQzcrdDNF?=
 =?utf-8?B?aGswamM3am5oVHo5c0RNMVhia2VkWE8ybXJVcUY4UkNkcU8yQnlhZTVDbWNl?=
 =?utf-8?B?dW9GMHJCUFNvVlNYMm90ZEJDaVBIU25BeVI3RklWb2JrZkxaZTA3ZyttSnRD?=
 =?utf-8?B?L0Z2VFl0L2JrR2pKRjRvLzZsbVIvWllNM3ZNUTdrZjlGZnBLQStLUFJFeEVS?=
 =?utf-8?B?YUlmbHRSQVJvVDlxdWhndGVycWtjM015QlVZZW5vdU1vbjR0Zm5NUHpjdE4z?=
 =?utf-8?B?dStxbXIyMWZmM2NVUDVZMjhjN29QSUgxR05YbWtpZzZQZHNvenFEVEx1RktN?=
 =?utf-8?B?Unh3NmgwMGpJdUlidm9CYzRjM3U3cHFHZHJKTG9rdTZzRWt0c20xTWpqM2k5?=
 =?utf-8?B?clJkS3dHNFUvb0lDSDBzd1RhaWJqQVBvc3AzbCtHNjNnc3BXbSsrbGpQOHZ5?=
 =?utf-8?B?d0pqVGQyaDdkM2FxM2F0L1o3NTlKR3RlMjhwUFhSM1Bmd3RHdHNTVGlkVjJa?=
 =?utf-8?B?eHlVZXdjV3VseEZHYzRlRG9oSHZIejZpUXFaVWQxSjBtQTlwNi8zbnN1b3RF?=
 =?utf-8?B?VVRrejNDeVdEejRhZmlnY21xUGJBN3pFTWdNQ3paNVBwNXdkNGxUR0FnY0pn?=
 =?utf-8?B?SzVRb3NuZU5yd3lzQmlrVjlhMzhsWUlPUWFURzE5NmI3U0VaZlZRb2JnRG9T?=
 =?utf-8?B?TXlTUGVQaElVSU9yeDFXMS94N3UxVWpSekdzdnNBTkk0SFc0Mzd3QVlOcDQ4?=
 =?utf-8?B?UWw5a0todGVUUnpTV1hZOVlzWldpV2JuRXR5Ry9OdngyS3V6TkNRN0g2Q2VY?=
 =?utf-8?B?L1QvWlV6QUJzWXg3em9tdGszdWZLYlBOdzIzTURvQXdpbzFrN1c3dVlDZXRk?=
 =?utf-8?B?WlpOd3FNZmFQQ0diRnZ3cTNpNER0RnhUdUd4M2w3OTYya1lnWFdiRm95WFRh?=
 =?utf-8?B?aEs0NnlBeHA1VHVPa3dtVEp2TUlJZThwMVdOQlB6aURmNVl6THNlWlplT250?=
 =?utf-8?B?c0l4THRpSVdSTDVTRnlFdms1cVQyblhJZVNEK0NhMVJzanVTV0JZbnhFT21O?=
 =?utf-8?B?OEtZTEhoMGJQa0Iva1kvOFZrQkJaZnZKVktkODFiNjBuOUpGVFNveSt2cVN4?=
 =?utf-8?B?TmpYZnVrb0JjMkVPVit1Nnl2dGptTGVBSFZTSUFNaHNZOHZuSVhvenJZbUxL?=
 =?utf-8?B?d0FQcWRxMnVwd0RPSXJ5bm1NemJtV0I0K3p2SU9VbnZZTFpuQ2JiLzlLU1Yz?=
 =?utf-8?Q?O4+s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWFtZEtvNWUrNnRYZy9BdzRlcXBaR2hEM1ZMTGk0TnFzQkEvbUpubnZaS0o5?=
 =?utf-8?B?K2MydXNDS29KVVpqZVRFazh1SExBT2hMa0hDem9DVzhMd3ByYTBUS21oUzho?=
 =?utf-8?B?KzdPdkNYZU5kc2ZqVGI0c01EaUo0OUZOSEpmZEhoTEZsbWZaZUdlRkNTNlZN?=
 =?utf-8?B?Vkx0WE9vZXBBcTNVVk5QSG85QzhQMFI5VTJzUFlmd3ZFUXE5VFRlL21mb3Bj?=
 =?utf-8?B?a2pha0hSTUtKSXlUUldPSU5tNFJZaEk1MkdmQ0JrMFV1eDZFK0IxWElKMmJh?=
 =?utf-8?B?eElMYUNVdVgwdzBhQVpuc1pwdUpwTTRxK0cvTElZajNOU2EreEJwdm8xcldq?=
 =?utf-8?B?OTV4RVQranBZeklrdzJvd1YrQ093eFBLVnpyb05WRzBpRDRJcDMvalhVTVEr?=
 =?utf-8?B?WDMyVEdqZysrV3ZVdDIvM1kxNUFxYXllQ2VZMW50dkZUTG9IZnRqblN3Y0Vk?=
 =?utf-8?B?Y0Q0eWltSDh0eEhuVVdFa1lDTTJiOVA1TlVCSnZ0Nk8wSzdXcXhkcFlKUHJT?=
 =?utf-8?B?YlNOZnhHNW1MaVNKZC9iSGhtK3dpZmlRdnZyTGhObFdoaDFDV0gzbHZOZllC?=
 =?utf-8?B?WVMvemx5MCs0R3JRM1ZzWXovaWlibU84NkN3MTdsTXVLTTVmQkI0OW5xUDJC?=
 =?utf-8?B?NkdXd2J1cFhGcWRqUWpVSngzZmtWU0p2ZFY3bnF4WVVhUWhPOWdGQVY0c3Nr?=
 =?utf-8?B?UVdKUDJ1QUpmRTZxcDFUeUtrSGJZZG5iZVFZeFU5bmZubTFQd0ZVVkdpZlEy?=
 =?utf-8?B?WjhIQWhrTS9pY0lxZWdVUU5JZEloUHZmN04xSjFGWGlJbkw2TFhGYVFaUjJ3?=
 =?utf-8?B?ZWwvY05zckhid3FsM29xRnVBbWJPVXo1cDkza2NhcWZlbHlGYUt0VEl3UVV3?=
 =?utf-8?B?bk5KVHBzOXpBSHJ4dWtrRVMvRk1OMzJ6dnQyb2QxcE43ek14ZkZSQWZmenB0?=
 =?utf-8?B?alZIZnd2SVRzRlhXZ1pwaUJMTnBxMTBERHdkeTVuVnExVXNpUUZsTm5hMmgz?=
 =?utf-8?B?Y1EzNlhvZ2JQdkVOcFAycUtNMTB5WjNsQm1aM1JleHRLRzFhNFVMQVJiNjNC?=
 =?utf-8?B?VU14WWNXMW95WE9BenVFaUI3L21NMGRzZnBnYjM4K3hlNFFtMTYzdlVKQVo2?=
 =?utf-8?B?YmhoRmtKRTNYMjAvRkZYZmhacFFkYjc1SG4zL1dwUkorR1M0QmpLbTM1RXFk?=
 =?utf-8?B?T1IyRW8ybUVZclJFOG84STBDeFpjWExQTFNsSnladEVKdElJd2xrR2JMNnV4?=
 =?utf-8?B?U2RZalExVlRVb1I3OVAvaTBtMlg2T1lJeXlrdFdMaW5McTJSUlZiQkhySXdx?=
 =?utf-8?B?Z1hoQ1JlZ0F6b29uWm1nekhJRmQzTjBLQXVUVXRlWWduNkd3MXR6a20yanlr?=
 =?utf-8?B?NlFFWUJkTVM1STFGSktiVU0xL0VuR2JvaUpIQTZBSndUOXhNQ25nSUsvOHFn?=
 =?utf-8?B?TDBVRHg5Sjl1R29hRk1oK04xRkZUMGFvcXFBWnp2WGZyYkc4d2xQc3p4cXNX?=
 =?utf-8?B?MTJUa0N0WkdHVWlDcnMrS2NmZXZWVkdjNDl6NWFuOUNRdXZZaXU0bGhoWGsx?=
 =?utf-8?B?R1dNSGgyUHVjQ09WcTV2STBHRlZXb1Z6ZThYQytMRVBLZVdrZmVmYlIreWFN?=
 =?utf-8?B?SXpIWDBuRXBFREFqd1licXp4NCtPd2hyaTJmYnFJdFJhM2t2VXNIRElUcUVi?=
 =?utf-8?B?aTRiaXVObmM0bSt3N2p5dnY1dzFVQnQzR0kvMkxCZitZZS9nM0RONjJXT1Rh?=
 =?utf-8?B?MFNtVE9qNFNkeTR0anhWQWtTZXpPZ1I1SkRNaFdkd0pCRXY4aFAwTGFyOTI0?=
 =?utf-8?B?amN2am1uYXR0RHQ1Z0FERkkwNE9ISmxGVzFmcnhJUE9YcXVYSEp2dlhjTlpO?=
 =?utf-8?B?NnVmMmZNWm5hb2crQzBKcC9sSy8zbkdtR2hyV2xrZ1VSWXZFZlh6RDFLU1F4?=
 =?utf-8?B?bHJuWWJ4VGU3L2VsQkUyakNtNkpTRDduRnNxQ00wcWVleERQTUFVUlRmTkdT?=
 =?utf-8?B?b1FtWWt3RVJuTnl4aElnendqUlZXeGpZU3d3WlFZcmxDMTlqcEZ3TklVQ2o3?=
 =?utf-8?B?MWdqTDdoeGlHcEhJMXlVQlpjRzJXVGdMcDUyMlpzVmtXUzgrK0I0K1ZKQmh5?=
 =?utf-8?B?b2FHZmhSbFFEa0JRcm4xdnJ0Q2NaNmpXaFdMNzFUbThtaFhtbUF2U1pFTURo?=
 =?utf-8?B?K2JGRlJ5MXBBMXMvUkxhbWlqMGFXV0dzUEtEZzY2TTgrc3gybFI0c3JWZUxC?=
 =?utf-8?B?VGZYVzdmK0RzeHBJcFFCT3RSbkZhNi9VWDdVaHNDNk0va0ZZb0cvZUNlU2FH?=
 =?utf-8?B?WE1rRTFINmRvdVBGRzR6cVZady9YbnRzc0dFUnJPTUVYUGpRdW9mYlM2YkhL?=
 =?utf-8?Q?MgbJzpcf6EQIARybOFWe3BfSHERlo+dbwHZ7U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+x/fBEk4OD4zLIpOFEwZyY8UN5pKskQmaSiXf8fV0RjPWzDcfzuAT+Pk+RbiNdDgNpkLFH8rofoyWJObPh1S1AbKcq4AcpYeclEg/tTAazz/x1q0xAmaQIleeeXDoreo5solYhWUVaEpFg1Qad8v8o0NdCaolBS2Su3/56p6wY70wKUosiCsbFoiMecS5dhUFHVI6uYkz1vEAY0DVwHiyNNyqWZCkfGlVvuc3FZAEufuhCZIsV/NEVRZSPMvQB9zhjJoievFKaPdXPmb5VInLo8VHBUnPVvZVXDc+UTG/sFl1qDIkLag11dsRiqmVtDa6Q9fbFXFxZROLWfqFL328gj2Xh7F2lVfZLu2AQTAp7lgaRleacB6gP9W3qhUyborP1iIYQrVrPXScHRvV+3Jh/dmNtoxHzJKE1HfwQsZAAanVWf2F9VxGFwg4UND1JksqPl6528PjlhaR4wV74T0o+OdZsnQMrZhk2skzTBoysok4UMxy6BroYcMHM+YzYgn2q17GvePoNspn2PUWY9gmqjnK1et66LFR6M2IGzlb/p4qpFqAtCI3DBWdbuuw4UL6G1jm4yDNfWnXV7+E4O3SXdMEcZS/KTNjfwVgDxGMTc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55805907-082d-4174-c22c-08de64d686da
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:49:28.2295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6g7dMpabI8/jnCEcceMDb1FHdcI4Go71S4foyORuRMEaZFK5CjI/lM8+eCwytCOpPxSJEPmVSIwEexf5Y6zZL22mJdtga8/E8m9Hd8svYLaaOSqYLyo1f19ljP2qXIE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=819
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050127
X-Authority-Analysis: v=2.4 cv=SMtPlevH c=1 sm=1 tr=0 ts=6984ca1d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=BDJ_4VBMZPyBPifeRfUA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: irckQpcL4DqMhd5Dsk5gqHdddgMIbznI
X-Proofpoint-GUID: irckQpcL4DqMhd5Dsk5gqHdddgMIbznI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyNyBTYWx0ZWRfX7byxjx7mS5GS
 dWFHPGElKhX3DTTP50IxQAlvn2eYvEPjB0lMwytq0B+olG6NQ5kVrsY/DDNosncS+1p7Rb62zLx
 jBWgV58gGNvPrlaYHP0Bv87zwebrnBIgF4nFrZO+Db4sBK80aWsYx3I/5EcIZemBZXrhOcjsBd8
 X2OOxziMmT2SIywgtskHARhlDps4luIq0bE+IDx286zmB8Pkj9hUtL4mdqtJ1L2tvNYVQIYPrsy
 GmkRwVANbTlkb9ufbtVrh6FLe3Edwi/ckbF5W5Df6g+X6okvyxvUnZvorIclB+uIGAf4iLan14P
 I04I8i2Gd0Kg1TQd0spqx++r7YU3Kek+jwdr/ZtXC6dEfGMxfmtr0XsYoNwF77tIi21g4ZJBdzr
 /HObjbd9fpgnHgt3/3AIDOZSqqNG27o0afI4AZauqv0aJLpysLgfVc99kwXKSZXWNPKJjqIm4df
 V9GAjENSSiiGrVtHJHw==

On 05/02/26 22:15, Andy Shevchenko wrote:
> On Thu, Feb 05, 2026 at 10:09:45PM +0530, Harshit Mogalapalli wrote:
>> On 05/02/26 21:53, Andy Shevchenko wrote:
>>> On Thu, Feb 05, 2026 at 05:12:08AM -0800, Harshit Mogalapalli wrote:
> 
> ...
> 
>>>> -	if (spi->irq)
>>>> -		free_irq(spi->irq, indio_dev);
>>>
>>> Do we need an irq member to be in the struct after this patch?
>>
>> I probably didn't understand that question fully.
>>
>> we still have a call to ret = devm_request_threaded_irq(dev, spi->irq,
>> NULL,...) so we can't relaly get rid of the irq member I think,
>> did I understand your question right ?
> 
> Yes. But now I realised that this is the external structure, and not the one
> the driver defines. Sorry for the noise.
> 
Np, yes this is part of spi_device a more central structure. Thanks for 
checking!


Regards,
Harshit
