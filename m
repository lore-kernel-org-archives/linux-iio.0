Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702383E6DFF;
	Mon, 18 May 2026 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097051; cv=fail; b=atxA7EASbB3fNxdWV1fXl9skZEmU98cAQI8T7lNHXjm+WOfwNOjgoaAopdLCp0C3fM09g6h58wR3s3ypu/L8e/KRD45enAm0fXR/0N+DVPcoz6PQqF43ixv/pcJO9T7NraHkRtXRQw0n2JWvjVdsJ086mR5RPZOGyT6UlLOO1AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097051; c=relaxed/simple;
	bh=I5W/HppxlB94wQ1Y9RzzgT8ZU1qftDaeDuWFQdGfqsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oDOKJ9wfAJdpmQFY4rgyjbhILPZDguAi4DKsZPR933mLoLIrsxB7okQj4jh7UNTA77Q1qoUadR7m+JGiORHGVQpfzR+cXRH7t8+ZJCD3q92saAj03/v1a7isczrIxpUq4dZJRFit3mt1HYHpc4J65ZzJDn7HlKVZlQ1jQC/q8kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sJ7AVV4V; arc=fail smtp.client-ip=40.93.198.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sJ7AVV4V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jy3N+y72YBZUtTrn2j1ba4WB+ZSMdetf8OVl7dZaXnE4cD7OovX34d/EkB+LmU/pxTCykZenr9no7ZJUj+V0TeX9oHMaY7tMqyprSHVhuYuU/OpoTCwoWm/nZ+ifJc9o0FyRKCpanYgNcZufN2uslMSmHoIm2tFi/FM/8NvnrRwXQ7l11kY4sEs3u771WmUm2PfyzW+4Xrr0E/sYq2eJJ0ZknS0fILG4UQ5PeT++cNgHpVNXEmZ207AsQmLm7XIlWYRtPaRXxp2ojTOMVy8mSrhniSauyMbi4PTVTTUZSCjbJZXI4mvhXchsQG+qWTmVutjSy1DDOdGxBZkyVtxkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeKbtPBJ7AVrnnnbG/RMt8TE1pBAfZLEKQBON3AVmos=;
 b=Qp+KU6159afNQEJbdudr7ltwy7UMYhl0C9Hoyk601WxDTytOkBZ2AY2KEjLvqtU2fCPfHOadBDPMOQVmcCxWlkyYkrmv0j0Z6sk29QkLQaxQmaDnkv7aBXLdCZGL1Pq3H3mE2WQdlV04NzGEp4HzeRQgubToDTy4nmgK+w2vUE6tgDzU9ShOIiiVS3vI6l46IsnOoYVJglLtrnbuiFNEhVACf1EJK6k92/R0nvmQ0kj+GnzswXMCV6AhId5KyjxTRxGKymlyNV3KF9dW37gjjXhBNF/m4YepuEbuuaZwEDOOy4r9VxVd16Ijxv9uirp+FvB3yhveqPyrewQyy/c7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeKbtPBJ7AVrnnnbG/RMt8TE1pBAfZLEKQBON3AVmos=;
 b=sJ7AVV4ViG94gSww0ljsF7cM+BEIyc+4r/QqMOvf7WEIuZs/v61wO+qC477iazJSrJr+mBiR7/+iVCHTUrEPliMdV3hx5SXMOBKJU53EsV0S3q5O0RC4YeXYGffLQ4w6rILvuP8rEuUYIy5wY7ZOVA2xFBzM+NNkH6fNMDYRRUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SN7PR12MB8028.namprd12.prod.outlook.com (2603:10b6:806:341::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 09:37:24 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 09:37:24 +0000
Message-ID: <ba1a416b-1e4a-4c75-9856-6d7a8794dab2@amd.com>
Date: Mon, 18 May 2026 11:37:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adc: Convert xilinx-xadc
 bindings to YAML schema
To: Jonathan Cameron <jic23@kernel.org>,
 Pramod Maurya <pramod.nexgen@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Salih Erim <salih.erim@amd.com>, conall.ogriofa@amd.com
References: <20260510083219.70224-1-pramod.nexgen@gmail.com>
 <20260515075736.172172-1-pramod.nexgen@gmail.com>
 <20260515075736.172172-2-pramod.nexgen@gmail.com>
 <20260516121856.12b8880f@jic23-huawei>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260516121856.12b8880f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::7) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SN7PR12MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c44c4da-1ffb-48f1-2708-08deb4c11121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|4143699003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	PMhChkEeX+i5XEfW/Mjo9gCSX+ifIyYgjPMl4bJyOt3QHE6x3dSyU3/tgr2lIiUxWDZnSyeaQtuFWObikHqf64pmLh6U7jI5iadlSKARn2NHHXM0eXaNTtif/8Fy4mKf9jc2/yUGTyt29+bS/zZ+LInBrE8B4Btfygj7ywZC8zek6K+eTBRCQUFUYD0hb1MvgF0VzNcHA+TEgU0ZuNOgCNEmh82x8NlLFHrMnEyjCHbvIYNDcGEEL8qMqNe6qTnFW0Vd/z+0iKlGk0YVbaUnKHzF7WP9frAKNSsPeutdKlbC+C1HWT582SV6VKKkLnoYCwbW45lQsH7Wf5teAJZLQT8yzzpwtkvE5tQXhlyhJapHx7/z0tQF8xzZNEB/39QJzDWU2Z/DRsCPUanJ3uumka+N6H2UG3mqBNJiyrKd9CeFJadzVkcT4R2oO6r12BGpe+9JWj9vYdQ8Emi8KSIj0Td1IQRB6HcwQkWHh+w/7NgbhLFdTgZXX4aAFM5tubGKrsAcLEZbBMzb9mRDYmAaDrmyDvoxR4J5Su+AUaByhdZokBM2PFq51Qg9wsKCLGn8ZCV/LITub2jo2HOjH8JO/sVT19TZQNvMwk79JIFoHtAHXetMFu8N7n6R6awOquziZ2nnbKOEGmALUNrhu6EOAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(4143699003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWlOL0JPWTRSUE81cDN5aml0RjcvOSt2UWhmQVcvZCt1V0dPdjhQbDRQUEI3?=
 =?utf-8?B?WGN3YVk2ZXhaajlGdm4rdXVnazh3emtlUWpqT0xVMURBdnZ0ZXM3ZU4rNW1i?=
 =?utf-8?B?ZkF1QlBXKzFIVU5IV1dWeVB2THc1T3p6ZjY5WGgxdUM5eVd4bklxT2VFRjJJ?=
 =?utf-8?B?OEs1M3NTejZScUYvTjlzNld6Y25PWFgyK1p2dUJ1T3FyR0RjVHFvM0toL3JT?=
 =?utf-8?B?TXBLRlRDTU8vWlMyL2xQM0lONU9GZnpDVno2SHZKczhMeGxNMWJlWnZGSllZ?=
 =?utf-8?B?MTlVUSt4QlRkdnZqK0ZUVnhRR3IzZ1RIRFB0eS9lckdWRXUvOXJSdTVkUEw4?=
 =?utf-8?B?bEJLS1V6SVpuakZPNmVFTVF1UUc1MFRCN1Z1UlhPT0dOVFExanF2Tk1QN1Bq?=
 =?utf-8?B?d0hlYVd1YUttTnNpR0x2eFZCdFVxQ0VmVkdndkhMeGJTZXpJZVgrVlBzM2c5?=
 =?utf-8?B?OVk1MHRTV3ArV1FiMEVzeVZIbXRmZXNhaDB4RVpKZ1hIdXhzNHpDN2FBVTBt?=
 =?utf-8?B?VTVGT0Z5aDh5VXFQQkx3NHc1dXVtS0pJcVpqbC9Tem9qMUJzN2NEWTZnRE5J?=
 =?utf-8?B?NXpvNk53MVBSaFh2eEE3T0JTMTl5K1V6Sko0V0ZnMkY4WXJnUmlOTHExTVZF?=
 =?utf-8?B?L3FQRFVFNmo0dkI3UExTWDhDaUlHV2JSV0tVbVlSTWRLSEhCc3lUZkRpTmZm?=
 =?utf-8?B?cThuT2poK21hVzNjR24xbEVsN20xTzdWKytWdllaaVBhTW44eFdaNmRuci9N?=
 =?utf-8?B?N3REL25ERE1HdC9Wa0hUbDdtaWh2NllLaUtrUjhydUpCV1ZtQ2FWV1pvci8z?=
 =?utf-8?B?VlREMXVpNEEvbG1jVjQwSFMzVE5uN0ZBWHBSNzgwNTNWQWVwZmQ3WkQzM1Nl?=
 =?utf-8?B?TG5TLzh4SGd4MXZVWE01cHlPckZKa1NpZmZhUTNudXlVcnVNZ3dJRlhkL2N5?=
 =?utf-8?B?alVURmxhUE85bnM4YXRJZHpwc3FLbUszdmNsSDE2V05hcWpsMm5hN3o5SVMx?=
 =?utf-8?B?Mm4xZG5McnVhczE4amNzcmlPRG41eEVKOTRNVVpFM3ZkQVJqUUJxeFRkOXRl?=
 =?utf-8?B?RjNia3ZKVU45Sk82cTRQbVNTRks1M21qTnFuN1NIN0d4NHJCd3kwdEhUbTZp?=
 =?utf-8?B?d0xaREVIV3poZWVuQVpDRWRBQXdtVFVUV3kwWGNMR3p2M1QwTjhaNjU2bHVk?=
 =?utf-8?B?dUZOZXhwME10N1huUHFjYVVqL1A4OXBZdGZFZWw1aVQ3TVB1TUNpYVRFNW8z?=
 =?utf-8?B?aExIUGF3M29qMWl4SklIVEVKZlpVeDh6Slo1Um5OWDZFeWtPZ0NnYVo0cDla?=
 =?utf-8?B?dGxYTmc2TTVaSk41WUkrWm0wMFJsa1RmRHlNOTduV016SFRBMk4yRDVPUG9l?=
 =?utf-8?B?U2lwK29Vd1RsMm5RQ200bkJocWFuWUNRSkdQclR2NEtBeXJNdUFHRFE3V1FI?=
 =?utf-8?B?NElETHk1aWloUG5LLzRSdXBnN2hrRzN3a0dBUHFYVTlNUlk4KzVJQmoveVN2?=
 =?utf-8?B?ZUxyaEsvaFNCajNxMzB0TXZONzFBVDZnZDlabExYMkdxNStPczgxdDhidnJn?=
 =?utf-8?B?blRObGtvci9PRmEzTmFRaXNJcGZ2S3pCWXc0T0p5MGFzb0RvaFJDMkpDQWtn?=
 =?utf-8?B?d1hHc2U1RFlpdzIyK0J5enRKU3JBcmpSWTVVOVBDNkVJQStGalpPSkFFU1d2?=
 =?utf-8?B?Z2txUnMyeUd2RjlPd3IyRzhxcW5xL1FmeGRRTjRWUFVGdFhqdXFOaGRiMXA3?=
 =?utf-8?B?ODZpTGZ6VkRUWWtSOXhLSUxKd0ovcUlhR0E0cFdCNDZHd0llenNmdlhNc2Ny?=
 =?utf-8?B?b3V5djhVUTZJMFBNLzJTc0NGdnRLcG5qb1JjeTVOTDZacUVYNHhUS0FodTE1?=
 =?utf-8?B?akMvcmlUdVd1b1JZQ0xRdXVhOHEzZDYxWU1IRk9IQTZvZUZ0dVNNTm1HN3VT?=
 =?utf-8?B?M2FLZldLcGcxT3NxZldpeE5UbFBOWVcrTWRUU1RpbDMrN0htUjJGY0huUHpU?=
 =?utf-8?B?Z3E0NExLL0p4T2lCdmducDYySDk3V0RCQVZpU2pNMk9CR0RVUDdvWDAxMWNw?=
 =?utf-8?B?MGZGNjJwekI3K1A1bXFMczUxRW83Zk5MMDdjczJzTWZkOEhuWnlqUFRTY2NR?=
 =?utf-8?B?QmQwdmJQcERLaEpPaEhWcmtGRitaUjJxOXFyNzU0MUtrZmQwdXJNVzd3S0Yz?=
 =?utf-8?B?ckczRGc5S0ZVL1BFNzg5MHVuTWJmWHBnenVvRGFtS3c2M0QxZVpIY2hvZUFW?=
 =?utf-8?B?djIybzZTM0xlMjBnT1RNc1RXdnNicE5rd0lqZmZ6enhJNzZGVVhtTkR3K0Iz?=
 =?utf-8?Q?mM9sxjlnuQAs9UZaee?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c44c4da-1ffb-48f1-2708-08deb4c11121
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:37:24.2823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BoY1Apq/mmexUiDzzvOC7E4nyY2FXNbQCzsHZoWXs5CRZMRmGfoGLBZCMpTYkIC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8028



On 5/16/26 13:18, Jonathan Cameron wrote:
> On Fri, 15 May 2026 03:57:34 -0400
> Pramod Maurya <pramod.nexgen@gmail.com> wrote:
> 
>> Convert the Xilinx XADC and UltraScale System Monitor device tree binding
>> from the legacy plain-text format to a YAML schema, enabling automated
>> validation with dt-schema.
>>
>> The new binding covers the same hardware and compatible strings:
>>    - xlnx,zynq-xadc-1.00.a (ZYNQ hardmacro)
>>    - xlnx,axi-xadc-1.00.a  (AXI softmacro)
>>    - xlnx,system-management-wiz-1.3 (UltraScale System Management Wizard)
>>
>> The xlnx,channels subnode retains its legacy name (including the comma)
>> for backwards compatibility with existing device trees.
>>
>> Place xlnx,channels under properties: now that dt-schema PR#195 allows
>> comma-containing nodenames for long-established bindings. Fix reg
>> constraints inside channel subnodes to use maxItems and an items block
>> rather than bare minimum/maximum keywords which are silently ignored on
>> array types. Remove the redundant type: boolean from xlnx,bipolar since
>> the $ref to /schemas/types.yaml#/definitions/flag already implies it.
>>
>> Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
> 
> Various folk +CC, questions for them inline!
> 
> A few comments from me.  Whilst the original was 'example rich' I don't
> see a need for more than one in the yaml.
> 
>> diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
>> new file mode 100644
>> index 000000000000..06a0ce498352
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
>> @@ -0,0 +1,210 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/xlnx,xadc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xilinx XADC and UltraScale System Monitor
>> +
>> +maintainers:
>> +  - Lars-Peter Clausen <lars@metafoo.de>
> 
> I'd like a confirmation tag from Lars that he is still happy maintaining this.
> If not Pramod, would you be willing to step up?
> 
> Maybe one of the AMD/Xilinx folk?
> 
> Please +CC Salih, Michal and Conall on future versions..
> (done on this reply).
> 
> AMD folk, given you currently have a series (including bindings) for the newer
> similar IP, would someone mind reviewing this?

Keep me in CC and I will make sure that series is reviewed.

Thanks,
Michal

