Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793624026;
	b=A7Ul24vQmZk9FxjIPQO7Dx5GSZomxJfvXjQW5C7nogH1Ywty2FWksObUMlt7xJdnoRZd
	 E5xAa8kzslHZqNv23sFPEhKW0IlmWsPNYhmiXKxEWevg59ug2Kp9967d1lh4oHN5778zi
	 c+JIQxOGioGvncDHvvg2RRW3ye2Esc/gkFmNyPAAmWxEDSXKfRY+bD/I7+trpJFaElG9e
	 tZwj7IqkO+RxYhm//x4H3kPVjevNJ0S2eqt1lLTKe2MdiG9rpgg3r5FTTFYCBGiqepkAT
	 gg298Tme0qP07B25FmJ27MYSZp/y86MB2U0qqZQ2bCyJwfZp96HBTvltmFLb/PiI6xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624026;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=sCDIhSRtC8yi+9gsGaMrgIx/fF2p9iFq3WqccRPdbvA=;
	b=NQeqxdGsfDHDCXhsDUwShJ+k2o2Grrwzmd4o6q3sPyC8kHjx/qHz9SKE0Tx+gull3cjS
	 d6nUuFR8ncdWaJAqdtE0uwM48TCdknSYVzehjRg1dbz7N0lDbx/FIVCZgxOw5mhB39fa2
	 EoXhU1zlCfjDW+z1CMOdy04Gh+S6iM5kbCZNpyGzDUfWACSE4Cl9E8r1eRVltwGBcRge1
	 lyEa6te7S8CJP/9Wxd9zPj/itX5WDgJPeEscnkwijaYrM2BvM3I08kMA/1cbrwb9I7kjp
	 h1iBkw9YEDnt4jHHnVble/wRHaDhPmU+zfDiOEcHmI6yFDRrU54Zl3TDRsQn23wnVfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eCXcnMtt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.62
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9FE606A338;
	Mon,  2 Nov 2026 12:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA9FE606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eCXcnMtt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/PdNUIBkDbpwjZo+Lti9//sUu9zor0P4rBoXA+BldQmDoc+86owD83KwYM+GqpnOTQ/5wsnLnZgRaEARHgtT0i4BSXtZVXMgRsUcOoJJaIRAlBltVkDJpC8yE0xMMoMHyqbxMHxjPrI1h5Qth+/ZHprpcCmhlkOKjZmJf+ZRoQjFr/ru4iCDOdTquoOxThgyQteWLjbXsuy4n/dRME7hlbWwNIwMOptap08JpYIhTUaXn1UGcOf0TIceR7KVxe6XcC17lNjBtSledpC/u/IedGAAi9EH5HrTLJyTuweW7KwcTl4qIiFvK2YSDI52znueVCbAxOD6qbU34MVI0BAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCDIhSRtC8yi+9gsGaMrgIx/fF2p9iFq3WqccRPdbvA=;
 b=oPQOwm+IM0Uo04ykH0EDLweDiVLgR30cOJJNUBT3z6mv/GOp/sNnyVbmNcYeJQJ9wLipnJODS5fXBwAaEjk0N8zy97OyR8lOn8TehEw91/xE5Zdg14zQt3DPoOlsWultDQ7vZMAlnnmrcPgKRs5v14XUeyb40fIPGv4FGAp3YYS4a4RWBNA8e6SJJC98cinG3oaoWa056IU1rpt+kt1fzAHolcT27Y+7y5wXY1CoQxVqKXaHVto4x8D/BIy+MN+2MpV/ZFrZfDTb+QucnZJNbysrZrvxmT8gwMZNs+/IO77TPgrXz/X+AIY78Oz1sNHdOYNKnxEv1RBmJRRZlqrusw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCDIhSRtC8yi+9gsGaMrgIx/fF2p9iFq3WqccRPdbvA=;
 b=eCXcnMttwUHkUeVKbYZW3GEAsZ9K6MIfD/H7tZwx1ZIJ6f8Z2+C9DvMnBk7WwmJknwLFPscn/PuDawDHLzSbnL5Dk59JajcDH4YOUA29ir9gJu09Ii3/ZvaGanpRyUkSEKUD5GuK7SUrHAPA3U1IGdSHWG2hXgRinygfAIdV7BY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:53:43 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 12:53:42 +0000
Message-ID: <6723a142-c77e-4dcd-b05d-502a41e7b5b7@amd.com>
Date: Mon, 2 Nov 2026 13:53:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] MAINTAINERS: update Versal SysMon maintainers
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 amitrkcian2002@gmail.com
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
 <20261102122112.1723130-7-amit.kumar-mahapatra@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20261102122112.1723130-7-amit.kumar-mahapatra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0010.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34f::11) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|BL1PR12MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de02c4c-b229-4daf-db60-08df38e052ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003|261021121427099003|261026121527099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	haewhlVmDIvKGsZ+Oirz52oMnK0LmUrBmCIvVgxh1mkATsWLOBtOOSR6XTvV4Q2eiYK6BHs7f0a1Yw82RH96+an3sQekLbRub7OstbXh0JIrfEersUvkZd4FHmpHSDv7gXM2R29UY759kzxg45PNOSOn/kRnOvZXM6i5r2vK6Hqu1rmuxHr8sFhc8DC9waYj4+bb5mYeKinjrQrBIGj5L8aBmXH8IkO9UGoC0/vosWTkmpKlRQdFNX0EiM+EWDLnQ4K1vRrQlNOX4/XXfzVcv6hQ4K+jtmuH4lnKd9Xe9Fv1LwEnfQ5gOVUWq70xzDIoQmI9LmSVs0bLH8daNLUFRrR8ADpp14X3PFgsKw8cSe/gHF11pRXd3sHo255MDINyNp0Q71gCs3IDEIKWt2s5N0fiLDyL0f6HbvO6q5/UwjGeRyT5TarvtAY4Id2AQvP2ZJuKCsOCtxzXY2vcj8upTTKvGSaa25yRX9S1KRWYR3y9AKV92ul3nv2iskvWV3MYZI9X8lvA5VOFvu20s2RsgdgcRAyG6kQ0PbP/SUgFqu1O/5PsEvGslC3KqFjZysLsVBEwD+B1N4DyNgdLDwYXbhW3NEk7fv5sA+xXDXkt84qNWS6Xt6XBve3VvFwtofDsRS8zKUBfOQQjV71WQr6B6KNH9CRHhluXebyhd0im3Kc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE0vWkh2TzZyT29CTW5aOGVFeEhWWG5CTDF4aGZudlVGSVBOSXhZYXVVZFN0?=
 =?utf-8?B?MTZCQ1JrR1ZkUjJJRGdpNmt4YkhpZWUyZUdrNE51VGxlaHNjc09hTmNZTUkv?=
 =?utf-8?B?VjYwVW9vTVFXSmJVNmJ3d212MFFUanpNQ0lkS2FHV3FxMGU1NXhjSVlxWENP?=
 =?utf-8?B?TlZTVWhHcytNRkpzdTdUb0dIQTdxRktweTY1cWZ2cmMvY3YzVlVWWGtuLzdm?=
 =?utf-8?B?WlBEWVlWOWN5U0cyTTZOREtST2JIWWdNcXJzd3UwQnZHaFo1QW8vRjJGVmM2?=
 =?utf-8?B?V0tCV2FZbXNrMGw5K1BlMXhtSWlTRWhkVXcrZmljRlFHZ3BKSWxZVEF4ZTFX?=
 =?utf-8?B?Q1p1SjRFN0hpb2tFWU84cy9xVFE1R0pZZmEyczlEZ0dtWDVoazBTUGtDdWNQ?=
 =?utf-8?B?YmFUMCsyK0RLbDdiNEFUSDc0VUZOS3FNMFZUOTR2R2lMNGZ0emRpNXMwNE1Z?=
 =?utf-8?B?UHZZM3hoYzFub2dQRWVWalR3M2VWZUFvb1FDUVhBTmlwRkhHbnZXSk9kYU9p?=
 =?utf-8?B?cjZyTGhZM2hIbUZSVmdVT1lCRmZIWFVpZ0syYm5oMlZ0VzNXRm9LbHVPOTM2?=
 =?utf-8?B?RTdCV2tuVmJuSnJySll3S3NvVWtSTWVLQUhvK1BhZVJOcFlwM1lNOHVDTDU1?=
 =?utf-8?B?dzloNkJKeExVV20vRm5qM2h0ZDFvUGhobFhyV25BTFVxdmN1QWkrTWxUSHQ0?=
 =?utf-8?B?VzU2bGpIZ2lBS0hiYnI5RXluSHlyMDJlV01IVDlQY3I3STIyQmx2MU5yeUpE?=
 =?utf-8?B?K1lVVjUvV1RnSXlyUUdsOVdnMnBtYTZmY3Q2dlVOLzFYOFRvRTBWWUtWRkcw?=
 =?utf-8?B?OXRINzRWUnJLSkk4YlB1WU81NHg2UWIzdXZvVHBWVDJpT1R2bldMd20rZ1ZU?=
 =?utf-8?B?MjBoOVQ0cCtvRFc4bE9icWFaRERnZlNodVA4TWI1TWg5RmgvOWZuUG9ibDhR?=
 =?utf-8?B?QURmZ2hEcFVER1p4VUJaTGZvQ2tyL012QnJUd0hxUzZXQThlSk1hWVJNRS9M?=
 =?utf-8?B?ZTQ1NzBjamt0ZFgra05ObHlWQ3Y5ZHcxc3hZYWFCZHRkMDJhWGNaMW5nT2Js?=
 =?utf-8?B?TlpuOWFZSnM4aVVIZkF0azZRdzlrWkpjKzBNMUZ4TkxCRU1nQ2pQajhkZUpq?=
 =?utf-8?B?QUgwQzVxTTNNNHNseHNKYlBXck5vbFRRV0xSQlJUcWpVUzJKbmptNGVnVStP?=
 =?utf-8?B?eThFVzZwVTBHWk8rcGRneFVPSzBTTDV4dHFLUGJqb1VoMHlpVVYvaW5ybFhG?=
 =?utf-8?B?eFZuRk1EUHhSajkzVkFGdVhzbEVUOEhjRm5rSXVxNDNkdTUvRGlmOWd1NWdK?=
 =?utf-8?B?UDRZdnZXSEM5dHR1YlBmb1dRVkxob1pkSXF2ejdZYjVkOTd6SjlPaGtaQTJW?=
 =?utf-8?B?UjMvZXFDc1hEaHVMODE5bDlyMGo0cVpFd2ZTYk5QNCtzSVlpRm1FREZsVkxV?=
 =?utf-8?B?WGxSTGgyNDRmbzhCRW81NWgvODBiaWc3Mmp1b1grVHN3QXUrekRDMVBhR2R3?=
 =?utf-8?B?M3pPVmErVlhvaWE1K25pclhKd1JQYVhVOUl5Q3hYanhCZXMzdTV4T09zTEZw?=
 =?utf-8?B?aWFDanhMdFFOL2JlYlZnQmRUUnduclhxRExGNEN3dnRJOEZtU01McFhmWTlZ?=
 =?utf-8?B?Q24yNW5BRGk1WCtZdVQ5R2ZNOWxoR0ZPYWkwbExiZ01mUndPNXNMZWZLekoy?=
 =?utf-8?B?UUNXYWh2TnlQelZBRkFtK1pPQk9TTFVqSCsxelFqWU9YNVlKMGphenFzTmxO?=
 =?utf-8?B?RzRHWFJwMUl1L3lJMXAweEwzN216RitkWEV0bWZaU2VRQUJuQzJhQTJ3SGtK?=
 =?utf-8?B?OFdNTmJQejZzVHBLS1Rra0Q5SUVzb0Fxb2ZnblhjZ1N5Z283WnJQZTdLblgr?=
 =?utf-8?B?ZHEyZGQvQndtVnZlRElrNVM2aU1US3lXR0NqUmNEUDE4V0RyWEttdWRtRHcz?=
 =?utf-8?B?VU5teThkZUZNeE9zb1NNdmxWMThoaElna3NhY1A0YW1RMC83cFZmVURRTHdo?=
 =?utf-8?B?NjBscjFuSFRWZTBmRUEyVmUyKzhDNStRMlJwT2VIMzRxZUpabVJLS3RxWERj?=
 =?utf-8?B?cVh2VWRLVXU1RDhWbnUzcHdaVW1PMkVMVTRvQnF6WERISmp5U2tmU0hIN2Y3?=
 =?utf-8?B?M0VGSUF3MUlMc1ZTOFlhek1tQ2NOckRWaU1VS3daQjdzaHdaRGxTNGtsQlpW?=
 =?utf-8?B?UUpXU1cxWi9qVmFreFN4U0Y1ZVpnWTdPdUF0N3NzRGttUUVoblE1bDduOWo3?=
 =?utf-8?B?akIwcHMzbWJxakZRN0E5N2ZrL28wYmRYRTR5YVVHUVJJMnIwWGM4aHJiU2xo?=
 =?utf-8?B?YjhiaEVmbm4rV28xaVExK2p1MC9ZbG5meHpEOS9qTEFJMzRQVlNOdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de02c4c-b229-4daf-db60-08df38e052ff
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:53:42.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41526DYCj4d+OX1JeIdmRw/B2EHNROijIqUItmAw43xEvT1sBJYqCVrg1LoSxb0R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947



On 11/2/26 13:21, Amit Kumar Mahapatra wrote:
> Replace Salih Erim with myself as a maintainer of the Versal SysMon
> driver.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ecc22d1149d1..e3aca3bee13a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -30023,8 +30023,8 @@ F:	drivers/edac/versalnet_edac.c
>   F:	include/linux/cdx/edac_cdx_pcol.h
>   
>   XILINX VERSAL SYSMON DRIVER
> -M:	Salih Erim <salih.erim@amd.com>
>   M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> +M:	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
>   L:	linux-iio@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
