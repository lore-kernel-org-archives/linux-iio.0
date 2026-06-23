Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6B4DDA9;
	Tue, 23 Jun 2026 00:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782173204; cv=fail; b=tfCi9e2lJAUGquUWY3H3PWMjEqCVUpVgkeZ994a+isoVOCNTnUliB7+Iyt8mPlAvtl0/bp6V6vH+NvoWNhBAr8PBE3SBrwQ0ooa9meI/jPzVUI/Bdx94m6Sz0zNaejLc9dZBVA7yp2no3x0a3xsludBEvgHp3BdtNwntb4iHUMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782173204; c=relaxed/simple;
	bh=b5Zdq0s8JZPJWvtuNv3AYpkdBk/+7uXU1u/tZb07p9Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jYF0DO+XD7u6Oyi8NlWd1vu2Mim1bEmhUnRQwpbRC2do+RavrKODr6akCJicAWnBO0GRZvO7TwWk3dPtgudyJzjPlsl3uvGV94R068wrt1X90kemzyiIEWQ+iOlXCwUvEBitagx0TvPwJ1iPhQpdiVa5KELmmRNLkvqk5SGekVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iLMlu3JC; arc=fail smtp.client-ip=52.101.85.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iLMlu3JC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBEAj9+caTzKJXIEhVgfAFuMiB+d0aqGKzJxSx64UbbWQCcjX5k+jx8Z8Hpk6FN0qONTLztcvrA3o5RmeL07wLFXUM4H3C2/oBvuPdbqaFdG+WnBB9oPSxC88l+ympCa2cTDfQSNCsyCKjqHUXZUGQfoaTRZBNN0AQq7/JjoU367Vk3PCgq13lsL+QIGwtlLv0Rf99i8XtIk/DVWQCcI1iefIEtFBxgwHMGe1/iBBSp4aXGg/EDfSC7gTG47+SIRxBwEZ/evx09MQLYeleqejAyCkP1yxWmXFMvFhy2qmfHP1qnboCnOwgqVaLs+UoaSoHA/e6vnicFOLAV1DEuI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDfftv/HAQrFFA97plnPJQlpzrtFGlDvaKRbjIA4org=;
 b=b/npEGIZnLAbWOxtgV5gbPXCJIjGQQrshpP3ZgBpP/FPNWMI9PpA7sWsyo08j/vlNvj19KdEK6EU28SbxtNiQoj/YnabeStMvEQifnG6Hyo5Y67QcoJ0yOziK7uR/epanRxHh1yV1QZAzzNf78eyULGbgeWknxcuYKO6ag9JkQnJmDwH7lUv2TFQKQaoMPYPEz/uPOvPkyudein9bia6j3fU4c+WBtwhlxC9nYB15tU3XnsTUGFXND60mH+WfCZbnwyDXjx+7qXOn866Gdpr9pQIoqS30FExTL44Dg4RgB2DfpKLPu6Trksp9riy9KD9J0mCfKBDWUYh/Ugg8LmbMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDfftv/HAQrFFA97plnPJQlpzrtFGlDvaKRbjIA4org=;
 b=iLMlu3JCoXBzLu8lsTiOU/cQsqaJI6hPyDTg0fSuVi1Xd8Vz8SOn79nsH80od1Ji85/NipL9Zk3xKBFotlfQ6h+GnCzEVU4RjLCs0QXUcQ7cmgqaVIPI050j2uFsVrpOF0m9EXfOMO6b71ZIJTiDvG7HVVzXBzlf+mqmqK8Ifzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by IA1PR12MB6114.namprd12.prod.outlook.com (2603:10b6:208:3ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 00:06:38 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 00:06:38 +0000
Message-ID: <ba8e1716-dd6d-4d6f-b8d2-859276b9aa36@amd.com>
Date: Tue, 23 Jun 2026 01:06:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/5] iio: adc: versal-sysmon: add oversampling support
To: Jonathan Cameron <jic23@kernel.org>
Cc: andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 conall.ogriofa@amd.com, michal.simek@amd.com, linux@roeck-us.net,
 erimsalih@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260618101414.3462934-1-salih.erim@amd.com>
 <20260618101414.3462934-6-salih.erim@amd.com>
 <20260621172845.14460273@jic23-huawei>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260621172845.14460273@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::17) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|IA1PR12MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: eefd5e46-9fac-4bc9-e196-08ded0bb4c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	r8fidVUFfhi80d0PQQTiLMAEe7ra2bkP8N+oCuGsdyZUmjtJYWzFQj9QOm7nsQLi9qBlFme6CSltecn511r2q5qbv1uW2ifIv3iraj008MTYIdwTa+DffrqV1QsQIuc9vsSv7IdFkCpOVRYcnzBfe+eiQEufJPIT6GIiCl2MbJAbR4hMELD0gANSHJ+p0G4zkTkgDfwIqOZTdpCWmqDgw7BTCSllFa09LNt/gRmFWASt7JSkvxW00mXmhrp47kx5XdyVYGMSH1yZNoESGI8veWb5oUQTEsFFap6cm5Iq7WemTm3vS4nXFoLsJQglAuSyt3QH2oDegRyxVfjyxAkaVtXzgZV/B0fgb6EDpOVp6bGE4mfZiEICMc+FRpv+kYwWNMTkn+TvqwaKJPm/qJwqkChM6HR2PlPCer8Vzsrbb/ekwzdyGzaSNgf+adoqS48jgIIIL1SpAhDgUoOUl9+bbFwm5FRMO9too/3tb8cTmb9+9RLVSxrItXvpJN/woz41r1OYf46JnecL+Vr8XKpFSDCgPpieRp2UO4VaeASVJ04lh8o3NwjJaOJFsLN0Hs7k47164da/viklXeEuFYVUpKhlagpTBwxAXDJETnTFsht6Bh1k4wlp6vWH9DaHUxFTI24DMrrDdhQAuIdT0CsaymOYnax7zAF9erktLLANM8I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGoxQ2FsVE8xa0gzZ1hUZWV2M29CMlRWSGFhN1ZyWi9IVFMxdnBIeU92cHRp?=
 =?utf-8?B?c050TUtJSlQzM1hHWS92V1RNTGNiWTR2dXlOT0ZwMmM2Y3BBU0kxMzl0WDgr?=
 =?utf-8?B?TWNqOHNyUHdUSFUxYXVMbGwrSTgzYm9ESEw4V3FFcmxhNnI5cWNUZWNSV0N4?=
 =?utf-8?B?QXZvaTFpNnVEVlVLM1ZFeFJIbkRaNmFrZUREc3VHTXNWS0wrdXNvQ3d1eFl4?=
 =?utf-8?B?b0k1aGVsYm9scFJhWXR4RFllQkp3OUxoWk16bFBLbXpHb1RKRGZZcDlXM21K?=
 =?utf-8?B?N1ZQdW9Zc2J2cDNodUczTnA2TXZGNHVscVdUejdic2pGSTFsVDBaY2ZjWjEx?=
 =?utf-8?B?L01vVVBiZkMvNkErVUJUbGRsOHNSbi91MkFCK05mTE5iTVRZbys3ZlNhdExH?=
 =?utf-8?B?M1g5WWJZbkMzUHBSeSt2ZlZ4MDZoVkxIUDhhU2M5MDFhN3JXMm5hOXhRVXdH?=
 =?utf-8?B?YmdvNEUvN0cvekQyWW82dlJIUXpsMmdjczVCQmtXd3BHVEY0YW1oQnlnakti?=
 =?utf-8?B?MGxKWEE3QXFNOE5VaHY2UXN4VkZUVzhPcHhWOEs2YlVnZEQ1QkhMdEg1L1h3?=
 =?utf-8?B?S2sxcG9FM0ZzbEJXd2JlWC9zZW9hUnpRc2dCTFljNEZYMExwQ1dyWTdyOXpj?=
 =?utf-8?B?Wnc3cEF1ek5wdVY3N1RLUEVmRWdPUUtscDlpeDlZZVBOeTErZGMwczJVYUtw?=
 =?utf-8?B?d290TUMvZGE0WTRSUm9WZ0Y2bGJVU2FDWkR0TkRLN2ZtRkswUWxzcXJoUHo3?=
 =?utf-8?B?ZmE0WGUzc0E0NUVlcUtKVEpMQTAzOFVDVExjYlhTRDliM3pvTmtodjBxQkxL?=
 =?utf-8?B?RzJBSmwxWFZHY2p1YUNWc0hKakI0cEUwZTdQSWU4Z1VTbFRGRjlvU00rOXFh?=
 =?utf-8?B?QThLR3NMNWFWcVlmdjJxVHlERlVMZEpMZzNXV1UzZWs2SUtnQThYYlFZOG5V?=
 =?utf-8?B?NlA0N2tMdFA5L0kxazY4S3lLT0ZoTjZncmpHalNoVklweGlQaVExY28zVG5P?=
 =?utf-8?B?bzEwM1NaYjhITysyaUwzbkNteTJaamZ6a1JFVldMd0x3ZlZxRURwOUZDWHF0?=
 =?utf-8?B?YTBpbXIzUVdLdlZsS0ltRy81OGJWTEcvUVhZUjlUYlY4eWhITzZtOUZiOTAw?=
 =?utf-8?B?aDVpV3BjSTQyV0Qzc21neG96TFBuTXEwS2xYNlFoK0tSMlZWUTZwU1NvZnJ6?=
 =?utf-8?B?c1cvL25CeEU5OGxrVHZpdFRHK0ZjM04yYmtvNXl6ZUFjMDlBR1ovdWJFS0Q2?=
 =?utf-8?B?aytZWFpPTmNyWnRxV2trYjRQTmNpem1kZFhBOWdVZWw1QXo3czltRmxYYTZo?=
 =?utf-8?B?cjVObzl5V2M2MHl1T3lEN1p3TXA1WE5hTkoxUWZrNzRsckVwS093aDBLOWhK?=
 =?utf-8?B?NUVMZzRyMndvNU9hV3o1eDVSdlF3djdVNE5ERnRMRE9FY3lZVkg3OSs1dEcr?=
 =?utf-8?B?K3R6d2ZwcDYydmswMWRsaFRvbkloaHRCeFN5VHN3VFYrNGtBRjV6ckZNaWNO?=
 =?utf-8?B?QnBjSXRyaU4za2w4YXJ1aTFyOURYSXhPWDM1MGdpQncxWUg2bHJHUVYvUm43?=
 =?utf-8?B?cm1pK3h1OUovbkpNcTBROGRPRXhhdEIzdkpUYkRGdm11aHRJS1hnUzFicHVG?=
 =?utf-8?B?M3JyTVhoWXloc3pHRzdiNVJrV2FramhWK1NZYktRMW5mZlpULzNHSWFaTDZF?=
 =?utf-8?B?dWVNejRTOFhRL1Z1VmNiaHFwUHptYmhVakk4eWdweThMODBWR0tsdFYrdUZJ?=
 =?utf-8?B?ZSs4RFY2OXFnNnE4U0FZNXg4VzFHckpiazRvWmJ6WDQ1T2oyRENtUURRa0U4?=
 =?utf-8?B?ekpvbmllZG9vRENjL0tJOU9zTUhoWUJrTHZFTVRTUkRTaTR6cGdUSWtkeDlr?=
 =?utf-8?B?amNBK1l4ZEFJRnJjak1iV09idWpXZXVMVlc0MjY3dWg1SzJhTTdOQmNTZ1U2?=
 =?utf-8?B?VUU0TFQwZEhuWEZJM0ZHSlFvRXEyQ0NOVU5WRTk2QzJCQzJJRVhOYU1uaXdw?=
 =?utf-8?B?eEtOdkcvTkE5SDBwa3NUUkQvU05BYWd1RUZlSitWV2laZTZNWHJDYlhSUkRm?=
 =?utf-8?B?ZnZkTEFUaGdQT2pENnh6Nmw1Q0VkVTBoVzg1RExTYmZ4aVU4c1NNcGxsNFBr?=
 =?utf-8?B?Wmc5RlMvSVFEMWhyUjNPcXdHdGJYL09tYVo2SXQzT0s1cDNQVTJrVkY1ektW?=
 =?utf-8?B?Y2JGTGNtMlBNN2VTN1lOZEZtb2RFY24xTTZGdTNqdDBubThIMXBJMEo2ZmMv?=
 =?utf-8?B?S240YlZoTUk1RzJkNXlsUmltREE2ZlFpTjhiS2l5OVdEVXd3QzJVWGFOM2I3?=
 =?utf-8?Q?UZjOdcNtmKwZGAp0dW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eefd5e46-9fac-4bc9-e196-08ded0bb4c04
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 00:06:38.7188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6jXYcfFXkPmwc2PwJDUZ9IvXlybzFLgPTRRFTFhFV8M5o5gMa79Q2VHC3iywZHv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6114

Hi Jonathan,

On 21/06/2026 17:28, Jonathan Cameron wrote:
> On Thu, 18 Jun 2026 11:14:14 +0100
> Salih Erim <salih.erim@amd.com> wrote:
> 
>> Add support for reading and writing the oversampling ratio through
>> the IIO oversampling_ratio attribute. The hardware supports averaging
>> 2, 4, 8, or 16 samples, plus a ratio of 1 (no averaging).
>>
>> Temperature and supply channels share oversampling configuration at
>> the type level (all temperature channels share one ratio, all supply
>> channels share another), exposed through info_mask_shared_by_type.
>>
>> The hardware encoding uses sample_count / 2 in a 4-bit field within
>> the CONFIG register. Per-channel averaging enable registers must also
>> be updated to activate or deactivate averaging.
>>
>> Signed-off-by: Salih Erim <salih.erim@amd.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> Sashiko I think correctly calls out that you should have
> the oversampling related bits set in info masks for the statically
> declared temp channels as well.
> 
> Otherwise looks good to me.

Agreed, will add the oversampling bits to the SYSMON_CHAN_TEMP
macro.

> 
> I will note that sashiko was busy complaining about at least
> some of these in earlier versions.  Please always take a look
> before sending next version.  If it is spouting garbage (which
> it does for I2C dma safety for instance) then best option I think
> is to reply to your own posting saying what is wrong and what is
> correct and to be addressed.

That's a fair point. I should have been more proactive about
responding to Sashiko on-list. Will reply to the findings on this
version and do so going forward.

> 
> Thanks,
> 
> Jonathan
> 
> 
> 
>> ---
>> Changes in v10:
>>    - No code changes
>>
>> Changes in v9:
>>    - Add Reviewed-by tag from Andy Shevchenko
>>    - No code changes
>>
>> Changes in v8:
>>    - Use unsigned int for val parameter and hw_val in both
>>      osr_write helpers (Andy)
>>    - Use ~0 instead of ~0U for avg enable bitmask (Andy)
>>
>> Changes in v7:
>>    - Split sysmon_osr_write into sysmon_osr_write_temp and
>>      sysmon_osr_write_supply; caller dispatches with if/else
>>      on chan->type (Jonathan)
>>    - Restore HW encoding comment in both helpers; fix
>>      cross-reference in sysmon_osr_write_supply
>>
>> Changes in v6:
>>    - Fix FIELD_PREP indentation in sysmon_osr_write (Andy)
>>    - unsigned int for loop index in sysmon_write_raw (Andy)
>>
>> Changes in v5:
>>    - Remove unneeded parentheses in i * SYSMON_REG_STRIDE (Andy)
>>    - Use struct regmap *map local variable in
>>      sysmon_set_avg_enable (Andy)
>>    - switch instead of redundant if/if on channel_type (Andy)
>>    - Add CONFIG register readback fence after oversampling update
>>      to prevent NoC bus hang from posted writes (found during
>>      hardware stress testing)
>>
>> Changes in v4:
>>    - Return directly from sysmon_set_avg_enable calls, remove
>>      else after early returns, drop unreachable return 0 (Jonathan)
>>    - Rename mask defines to SYSMON_CONFIG_SUPPLY_OSR and
>>      SYSMON_CONFIG_TEMP_SAT_OSR (Jonathan)
>>    - Drop "bits X:Y" from GENMASK comments (Jonathan)
>>    - Blank lines after if (ret) return ret blocks (Jonathan)
>>    - Move oversampling read inside guard(mutex) scope
>>
>> Changes in v3:
>>    - No changes
>>
>> Changes in v2:
>>    - EN_AVG per-channel bitmask registers written with all-ones
>>      instead of boolean 1 when oversampling is enabled
>>    - EN_AVG write errors propagated to userspace
>>    - Oversampling limited to satellite temp and supply channels;
>>      static temp channels do not participate
>>    - Oversampling exposes actual sample counts (1,2,4,8,16) to
>>      userspace with internal HW register translation
>>    - write_raw_get_fmt returns IIO_VAL_INT for oversampling ratio
>>    - HW encoding documented (sample_count/2, not log2)
>>    - oversampling_avail is const int[] (type match fix)
>>   drivers/iio/adc/versal-sysmon-core.c | 153 ++++++++++++++++++++++++++-
>>   drivers/iio/adc/versal-sysmon.h      |  17 +++
>>   2 files changed, 169 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
>> index 50b5228aa22..bae229f27c6 100644
>> --- a/drivers/iio/adc/versal-sysmon-core.c
>> +++ b/drivers/iio/adc/versal-sysmon-core.c
> 
>> +
>>   static int sysmon_read_label(struct iio_dev *indio_dev,
>>                             struct iio_chan_spec const *chan,
>>                             char *label)
>> @@ -464,6 +602,9 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
>>
>>   static const struct iio_info sysmon_iio_info = {
>>        .read_raw = sysmon_read_raw,
>> +     .write_raw = sysmon_write_raw,
>> +     .write_raw_get_fmt = sysmon_write_raw_get_fmt,
>> +     .read_avail = sysmon_read_avail,
>>        .read_label = sysmon_read_label,
>>        .read_event_config = sysmon_read_event_config,
>>        .write_event_config = sysmon_write_event_config,
>> @@ -755,6 +896,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int ir
>>                        .indexed = 1,
>>                        .address = reg,
>>                        .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>> +                     .info_mask_shared_by_type =
>> +                             BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>> +                     .info_mask_shared_by_type_available =
>> +                             BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>>                        .event_spec = irq > 0 ?
>>                                sysmon_supply_events : NULL,
>>                        .num_event_specs = irq > 0 ?
>> @@ -786,7 +931,11 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int ir
>>                        .address = SYSMON_TEMP_SAT_BASE +
>>                                   (reg - 1) * SYSMON_REG_STRIDE,
>>                        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> -                     .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>> +                     .info_mask_shared_by_type =
>> +                             BIT(IIO_CHAN_INFO_SCALE) |
>> +                             BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>> +                     .info_mask_shared_by_type_available =
>> +                             BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>>                        .datasheet_name = label,
> 
> This stuff also needs to be set for the static channels as it applies
> to them as well.  Obviously it only makes a practical difference if
> you have no satellite sensors (in which case it makes little sense anyway)
> but it is the 'right' thing to do to document they apply there as well.

Agreed, Will fix.

Thanks,
Salih
> 
>>                };
>>        }
>> @@ -833,6 +982,8 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
>>
>>        sysmon = iio_priv(indio_dev);
>>        sysmon->regmap = regmap;
>> +     sysmon->temp_oversampling = 1;
>> +     sysmon->supply_oversampling = 1;
>>

