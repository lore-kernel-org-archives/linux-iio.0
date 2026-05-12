Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFE33839A9;
	Tue, 12 May 2026 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583749; cv=fail; b=FateUPf71+DZq6CqvtovXOWnkI6tvl/IOv5mLjmzHs+1K3uChXOGjm1k6nImIqrMK3vjGuKB3WNo4G2f+sAjRq2aSBCX0QMuQ95xmYCRpPJNH4p0xKhzV57MStK0tm9fuz8niC4DDDqX4d9XlQEpWB8ICdyhPEtJzWJsxgfCOTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583749; c=relaxed/simple;
	bh=2y5/Iz04BwcB7ejJvqJWar8xbvzW/NvS16MlqLkpiU4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HN+FajWpy4rF/Hp1WdVJjPmRg5Ilc9CqdrpzyvhaebB52yajJIzh1aC2fN3fsAas0oOlvoX2vOyUvFSObdVakeriuwqxQlBfOTcwe5kP0dM9rm8uwSGn+kvt06U34zys/ufCBoaf9Do66n4O/Fnh0tCbrvQ5LwG9QvbtjSP9mWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aaGdaYC/; arc=fail smtp.client-ip=40.93.196.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aaGdaYC/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9Cs3XuRgF6i0m0FaMn6YxfhRtwPHOumgvUHNMsptHbv0f0Spk1mVtCljaSIqE80yzJRv25mOL1g4otnJFzlg/RtftedDj46IWlzShuMFQMGIYdbkBPjopLJreJbUTx+VwUHdms1NQ/PRhuvvYmnmVJ3uoRiV7MwjhJvOz/IvDJ1g7xCZSMhVef+G46whllaHd5Zhy7+//pxKBa7/2peaupNhFHmiDYwK2up9wHfetfKH8INv9qYC5Nix56gdR/xSxmt7j9pLjfsEoa+TzkZi7L9qGgI2zmOjS22Ty4xfNfqwwoZa9eiUfaeoR4d1j4qg094aqeKn+knQckycVtn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2y5/Iz04BwcB7ejJvqJWar8xbvzW/NvS16MlqLkpiU4=;
 b=JIemiTHSRIh0qpGeZp+FQdiAF6DcRwi+QXEZUUqQ0kQzoVGzOgQimfZ+arU6f/SaQa49MnkBAE7Y7YR4S19PZZ4TdmC4JI0qhjhxyJU8G0NOPNH3PlJ1HHum94QEXTudsgzPz8pTIHgmAylUuqo09PY+AI6etl37AFtGyqBRsrVHZBPchaH5En69Y3DTmesDEo/kAdYZkv+Yx4CXvSdC/w7aKZ12sNJKnQHQbsgMTUBnWEvb4lmP/p+VqKDajmNjKS8zbwf2sR+ehqtHlK8+e8RcA/RH511fEdwyU/ZGKxIARDWlTG1+7odO2pf5LPefm4ePxyMGMyXHZiYrglGpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2y5/Iz04BwcB7ejJvqJWar8xbvzW/NvS16MlqLkpiU4=;
 b=aaGdaYC/5s909alVBV/pYKhDjCm6EkVe7U4H72KlHPN07AWOlbESian3Frmse+iDYbXNl3wxlLWYp0eBlX2QE7xjeMvbOaIqfV2TUOAFH7742J6DsuIT/fihHZBEo//wnLZOGkRP3brvpE+1zXTJUwzPGWSHZ8STCNTL4DI6Q/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 11:02:16 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 11:02:16 +0000
Message-ID: <7979e6bf-cf14-4436-b8c6-9e66019dc008@amd.com>
Date: Tue, 12 May 2026 13:02:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] iio: adc: xilinx-ams: refactor alarm handling to
 table-driven design
To: Guilherme Ivo Bozi <guilherme.bozi@usp.br>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Salih Erim <salih.erim@amd.com>, Conall O'Griofa
 <conall.ogriofa@amd.com>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260414224245.8493-1-guilherme.bozi@usp.br>
 <20260425163449.547b7ed9@jic23-huawei>
 <CAJgF-xv2SpaOu+6K6k3CzFVNfWTx8LyeGJMZjLheCSETOR3Yzg@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAJgF-xv2SpaOu+6K6k3CzFVNfWTx8LyeGJMZjLheCSETOR3Yzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::33) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 04cc9988-4dd1-4392-c07a-08deb015ed8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yEy2OEVm+zdQVP/U178abDm/28/IRW6pdknTzeWBGKrGeAKut5PQjW5NDmI0os7j8vbqp264gYV7w4mWUProbrckNBfcPdJ7QWomlYJACaZaRDaiVEaceYQQEaCCLDrSwIIPv/wZddWEzfQ6LNkrGNrbP0fAK4UfYbDiOm9XAtEDYWBL0+KTN4vxyh383D5WTo8GQsXUGNP6qoGzr8d3kaUbdDfV0ZgF6UByycUBLMja5t2CYBE8V9o+9A+HA2eflLU2XJyYPPENmdZWnx2CJVuVGzZ95OPKhGZFJQp0kjitZjCfDdaZk+Wwpa45uQ+aYSRtq3mdPo0p0tSznJ8+71agf33S1YF6V0NIMsSVTCDbdr0+TFyaWWn+w121i4/uoOXeZ4A0DBlJu7jfYt5fXHfq2+cVrhMcwsmMTFqgS1wBgIVJ/2grpX3+LnHw3uCt37HNSMsZ0Hf5kjz0oyDzXL1O3g7ejPWJ+3aD2t5sGtAiEGIxl/WVUNepMgHluXKD+9FxSqEIkZQHbLpF1Dxn0futSTwDmb9tvTdbSKg0oNKgJQ90zE5WWCbFmYmO0yRrPnD7kdvEiZUWvorbfQnB7uy4UGI39V9VykBj8413I5zLZ+aX55SRSznL14F55uB5VUcuHFaiFzs6NvBy/VKOh4eRUFKAu7kLXODZRVEb4Y/3CKi1goK2hVoVeLMfgpaE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmIvdHd5SWh0Zzk2UzVLa1VwQUtjd3lyaVZvT2Y0dWRscTdrb3FnaThPWjF1?=
 =?utf-8?B?L3JJa1dyTU15MHRuK0VwTGdNNWtkUzdoc3FjUytzWU4xRTNvcUt4ZFdMRStk?=
 =?utf-8?B?REovTEtKSDE2S1YvMEt4NFg0d2lKckRCOWErZ1cyRUM1UDNWeThSVS8xSmpU?=
 =?utf-8?B?bGcrZXVER2FZSUlKOWRiTFlOZFM4VHR4YjhoaWl5akJSMGZnVzk5OWxqcU56?=
 =?utf-8?B?Q3Y0QlBsRXE1QXdPYms0RDREOFE3YzgrQnJsQXo2S1ZlV2xzN01iRnhDNi92?=
 =?utf-8?B?cE94WFlOd3Y4QTl6ZXVQb3EwQUtEMDBncXlNRnJlaWR3Wlc4Zk1VOC9qWFpN?=
 =?utf-8?B?TmVtRkNpcysva1pybGY4UUhCRGNndHQzdDg4dEt3OGlCR0wvU1FGaXFIb0E3?=
 =?utf-8?B?TlJ1MHJSd1FucUdvU0g5V1dFRDE1aFQ2ZFNWNDREUHNyOHU1WUtidUZlQ1Zr?=
 =?utf-8?B?eWF2WTlUV2RvUWFZVlZEZ3ZlTXU2bzR0QmU3aHhkcTdneUhxeTVCV2liSUJj?=
 =?utf-8?B?ejJkU3I3SmhTQWFDOCt2a1JyNHFrelZHbXpUWVhac3hmN29adzNXTERrSVoy?=
 =?utf-8?B?SjE2bitIMUdrS3p6Wk5PeU5OOUthQVV5bHRTei9oSEZRc2J4dFlVUUdWbDVr?=
 =?utf-8?B?TE5IdHY5b1lUb2NLNmpBaWV2dzkxRXIzODV2cWk1MGFzdkFpRDYzWS9XbnRm?=
 =?utf-8?B?dDI2eWxEZ3pjdjJQK0g1bTFNL3FzN0RRalpGblRXRXluS1dHa0Rxa3ZhaTJ1?=
 =?utf-8?B?VElGeWJQUHg1RVJZQzJPY0t1Z1JXaitNdis4RXVFUUx6TFY0OEE2ZGhUY3N6?=
 =?utf-8?B?OVFsSjU1WTdZZ2RQZGh6VEQzTWo5U2thdWpxZkp1UzVVWk9QaFZxcjByY1Nj?=
 =?utf-8?B?UytlZzlYQ0tYTUJpTlI1ckNRV0txN0t5cUhrNnY2M2dybW1Idm9uMXdrNjZW?=
 =?utf-8?B?ZnBWaFdhdlhQME1nNHU4Y2ErQlZCWU5ha1RZdnJjSmNjYnVFUXByYlBlSXZR?=
 =?utf-8?B?RGJvajZnTDBWRHdDMzk1VkYwalZTckxPLzNxemRra3I1V3dZUWhHYWpPakc0?=
 =?utf-8?B?WXJlVlk3b3FkUlgvVDVGMExRaWREM1FyQzdDbS96dkhQZHlBV3BmeEk3UG1U?=
 =?utf-8?B?UkNodkI3ODZ0bmpFWVpobkFrUi93QjVRUlJ3bzdYV0VoZkxZR21nbzFpUHcz?=
 =?utf-8?B?VGthSTZsQmpJSVRWSU9ib1ZjcnRKRmhUUVBuelFJVXhJQWRiSlZzOE5iOVRU?=
 =?utf-8?B?TTlXUTJMVUN6TlB0R2NyU094R0tyL243cmh5ZDlTbFNuOE01ZDdXaDRXSVJ0?=
 =?utf-8?B?TWYyeVNVRE5LTmZ2d3AyOWtKVmpIbzB3Rk9PcGV5Mjk3K3cvR3NBZVB5OFht?=
 =?utf-8?B?RDVsL1FWNFFIWWxVZFovVWtFME9qNVZIMkt5aVRNaCtubXJGdS9XSmhxdW1C?=
 =?utf-8?B?REhheEFTb0lvc211UlVtMXpMVXN6Zjl0MHAyYlN6QVV3Ujl0UnhtOFlSaGZF?=
 =?utf-8?B?Z2pRcW1PMG5BRVV6SDU1N1hUOHpwTTlDUGpIK2tCUUtlMGZmOGhxaGFML0lY?=
 =?utf-8?B?TG5BcVhZc29aVTlIOC9zZjd2MzVsSENHckIwMTBFVWJvOURLQUhaUjZsUWVQ?=
 =?utf-8?B?bzFsaVB6QjRqTDJFcWFlZzNqN1BRN2xMRXFtcGV0b0RydTlXaU5BNUZSaWI1?=
 =?utf-8?B?TFkxUUZrUFpvL1RGK0Y0K3UrMmwvdEdSNWZORjF5dzdhSVNCVG4zeHRYUTdm?=
 =?utf-8?B?NmR5L0FRYnBiVnJaVkR0cTRIQ05tZlVTQWhzR0JqSWEzUlEzTWloUzBPMGw4?=
 =?utf-8?B?UTBFSjNucmtTZHFxMDJjWjE5K2pwaGsxeHVhSVMrWnFpQXVMYTRVL1VXUnVL?=
 =?utf-8?B?ZTU1TE9PMnBkVnEwWFNiWnZmQnR1aXQvNnp4ckwyanROWHp1MnAxcTJJbFdm?=
 =?utf-8?B?R1hrYVlWdFFidzZ2UWlTQzI2VXFmSXdaV091MkcydFk1L2hDemhCZzFYL252?=
 =?utf-8?B?YVRCZlE4bGQ4OGZheG9Ub1ZiQk0yeDc5TWd3V2EyN0ljZ1hYaGpWUHR0dWV2?=
 =?utf-8?B?KytCU3VzbGlyb3RJOVNyY0pGVDdJRThPaUE1S2orRy8yRzBCM0RyTXlISFU2?=
 =?utf-8?B?M3pGeGR0d3dNeWwrdGc5REhLRWFPV1hUTjBCaEJQRXFHNlVyRkV3UlErOTdk?=
 =?utf-8?B?Qld3UExabmZ5VmMwSkpOb1Rtd3d1RWxpcHNwSmNHcVBSUDFkRHhPMTVZVllE?=
 =?utf-8?B?SGRDMHRIQitISmVQMUJNeUlvTmlZcmFKUnRHV3F0OE9sNGNPTGRkYVZpRkF2?=
 =?utf-8?B?OXhrS1ltOVQ3WW9rbGJ0YW85R2NIbHFONXJMMm9hSG1lbm5DWTdIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cc9988-4dd1-4392-c07a-08deb015ed8a
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 11:02:16.0890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTpswnFbTR/+yR1M3WYROgeDr5VnrndihakHbS+sPdrkC1Ikf3/681nquuK54j/H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771

Hi Ivo,

On 5/12/26 13:00, Guilherme Ivo Bozi wrote:
>> This series looks fine to me.
>>
>> Given the AMD Xilinx folk are fairly active reviewers I'm just
>> waiting on them taking a look.
> Hi, just checking in on this series since it’s been some time.
> Any updates from AMD Xilinx review or anything else needed from
> my side?

Checking internally who can test this. Please give me some time.

Thanks,
Michal
