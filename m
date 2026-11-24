Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795539229;
	b=piAvaiCL42Gwgs9w/u9gZlYWHUqydUbB67kGQI66TO9ONYOvA1yK/npMR74w4Z6AFFtF
	 rfYF0fWpTZlQUYowojjP3I89TMmJPHLMOayXf9pdrwkVauLqnEnKT9+ynL1Yfe9E0iNx/
	 BBO7OyOaDYIG4oL6fVIUawTuuNaPrkAg2Vhp/wg64VhviDHy3JcqcoCGM5yFAjIbYLJIC
	 bAcefSFTH0uvzviyOyqkqhAJOaIb2EskNtUh1LJ6wGDeFv4FAo1AEMNuy+dBMrV6SU07D
	 JIS9w3eFGljFELfKMwSwr/UjdP3n7Kyn5hHzK//uVFWfbbHorlfX51bJXNfC22cx8Vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539229;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=iOk5q+z3t+gH5BFuZnM8gF4oMYS6RiydYksgAOOMLSM=;
	b=vluAhZ4u7Y8w2C1GUGvetbXeKBMKlrawWgvoQrcEfEZzwU9f/Oc1ApS8XLmbguaftfBH
	 6aSnnMdiRu3JeP28xYkD95dEa8Vx8wGTQpT4jvqO2mSADNwifP6hZYgRwbBAqkdrPoKMB
	 AhHfYy5uOgiZ9NoE/60T2l1MdgpFXptDDSkUeslU6RhoCpqbCq2Q2IrflFecPsGXwh9tS
	 yZ8vsoazsbZdGqjY5n0SY3Yczfp3p04RySwDkumJ3GIBbIP5dQz6TjL762YvZZthAhMBH
	 IJkEcab/buptRqAAgNzCJGhlAUiQOHFaUSZsoxDj61W/iRlQ13dtpMKekoVWnvaUecQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cP+QMTBv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.5
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012005.outbound.protection.outlook.com [52.101.53.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB4606A333;
	Tue, 24 Nov 2026 16:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6AB4606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cP+QMTBv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCPrdgomcWqxp8zNYiEjdxruq8zdWpRPUmjKxl5IN5wasnfgYkAOwNj1VsTuJY9fLvN4kTfcrqfXZE5hHMY5fVfnolfQUAM336Ii/DuIRbB1gUoTQPVQcHGVmiN6uqV+ciV88dHtQ4m/Uv1xR1Ro35KaJuL83FHQ9+YlEEeG7oDd6BfSDefJCM+GHXITvW/V7k7ji7LQo3aaH2/yqBkODKuVH5FYepzbmw7C9U/RBf5CqysfT6o+l2o0WjHFa8kknPkvvsSo5Hk93A2wG6eg6rnnc0EHyNYZ2M9NkCq/MZ/aZANDh3RZSk3VroLvzwixVFQVJQHD379ZrT3t4JRZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOk5q+z3t+gH5BFuZnM8gF4oMYS6RiydYksgAOOMLSM=;
 b=ZLjIUnDUBRb07wcRvBW2JAkozh3L+yZkpfVRVJmOq1onMBJV+K4bm2/LHDAfmoep98piS7+oVUDM3nA02F3sQjdf8iNG+OH+tV/bZybRO7CTIWR6lSY2LszC9ZbPvyyMjpqkcx4YVbCbh6pyslY4On4aWlhrX5M9+HxXZtiC9hZAO4SnlEQVpocdWf7X2mpxd+nPcQ2ZiLOyLAOPG9YbGb1ueajYkw1QwPPl9g0anw1iD4cU76DO2J+L9mqvkKwI42PyUYiTV9W4WP3soR7+WzvCM8pO8XCCjhHFSLXY3kG5FlfAsr9eiQQ0ERYXF2jrtTQrnl7nP8LzBcXgA6K1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOk5q+z3t+gH5BFuZnM8gF4oMYS6RiydYksgAOOMLSM=;
 b=cP+QMTBv/6mNI2Aq/ykLJZmyJROj2ejn8uN8H+s8J0PTtoNydnIFxthQ1FoNTZId4gxMrNRsiHPM0IHsjWKfUwHeSv7HOjZXdYrhyu5dpBEEJMcH/210aXepmBAJqHQTdmjhK7NXU1D6v7vJCJveRc8CV0lN8QbpaaTgvPUl380=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9559.namprd12.prod.outlook.com (2603:10b6:930:fd::14)
 by CY1PR12MB9626.namprd12.prod.outlook.com (2603:10b6:930:106::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 16:53:36 +0000
Received: from CY1PR12MB9559.namprd12.prod.outlook.com
 ([fe80::1761:23a3:6ab5:fbb8]) by CY1PR12MB9559.namprd12.prod.outlook.com
 ([fe80::1761:23a3:6ab5:fbb8%7]) with mapi id 15.21.0639.010; Tue, 24 Nov 2026
 16:53:36 +0000
Message-ID: <f7273b47-0835-4afb-9e45-ddf729f05b8e@amd.com>
Date: Tue, 24 Nov 2026 22:23:29 +0530
User-Agent: Mozilla Thunderbird
From: "Nagavarapu, Dileep Kumar" <dnagavar@amd.com>
Subject: Re: [PATCH v5 14/16] iio: adc: xilinx-xadc: Split driver into core
 and platform files
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Conall O'Griofa <conall.ogriofa@amd.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@amd.com, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
 <20261110050201.1850399-15-dileepkumar.nagavarapu@amd.com>
 <avNGcpcemoeE3J7O@ashevche-desk.local>
 <42949fe9-b336-40e7-8a8e-43f6d24da9bc@amd.com>
 <awVzDqxuwsOjoFCi@ashevche-desk.local>
Content-Language: en-US
In-Reply-To: <awVzDqxuwsOjoFCi@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::11) To CY1PR12MB9559.namprd12.prod.outlook.com
 (2603:10b6:930:fd::14)
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
X-MS-TrafficTypeDiagnostic: CY1PR12MB9559:EE_|CY1PR12MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: d67845e5-539d-489f-55ac-08df4a4b7b4b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|4143699003|261022105027099003|261026140227099003|261022075727099003|11063799006|56012099006|261021121427099003|10067099003|261102123227099003|261021123027099003|261009223027099003|261028144727099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	VSsrgWtflf+Ad38mKbi6mJBGaDef7nL6JdxfB6TCijLKjaAPCBOmglDuXi77+z4b7AKLMZe51kWYxi/fCDehi49CVgUgquU696IBpCma+HSZ89bnEcDMSpVovi9ZNRvQSK+90Zqkduzx1xFoWxzZ/sKZ0IwWu+BxBAxlR688f5/DseEQayGY8emHina7trTSknPedhlFVoN/fQofmLhM8rO89zwWEZl4gecrWJIy4AjWzFwlqnDSw6x8DdNXAZJIly3eWEtxN5YIoGbrpGSCGUPHxioLA6vsCEriqZ/sxi6CNEJ9QsQLBgiLbfpRuYZwM2eUdFo9ddnTMRKI9ayp2wR9slS0kPipsHrhPfTn2QliF7etgMZBjH73veXXXfGglmW6vIIODJjWsGMUIuQqGm5N7hlGYnF6wjnKIpseU4UsDcvRe+FsMiF0h1tEuT7oIFUdwwrez4LFz2UH8ukDSUzuW2col1YysPiqI3fcxGJIdWM/pRHYuCna+PdcUY0cafknY5t8BkyoNs6aXptH9wlOH276vA+XUEmBGBMu9RZ6i6ywNzTrJhV0ggK2QlUO17ThJnfuPypAb72sAQY5vbuwVElDe3/d++UW6noe5XXip7I9DXA7QYZ4UpKZAUnNzA+ckFHUVysW7xav+ze/nQcsP5BCbKaUES7+KLHTW1o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9559.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(261022105027099003)(261026140227099003)(261022075727099003)(11063799006)(56012099006)(261021121427099003)(10067099003)(261102123227099003)(261021123027099003)(261009223027099003)(261028144727099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1UyaWRQUDhVaTBXMTdubE9nYkI2RlNRWDNETFptdDVUZzdSTE5vZnBDb0xy?=
 =?utf-8?B?bVI2UkQwUHkrUDhWWHcyaHJ3aERDMFpUWjFGQ21MdE9Rbkx4c0MrcDFhTThQ?=
 =?utf-8?B?Z283RW14cG44NFk2L3pYLzFKWkYxMjROM00zRExxS1FDcFpxK216RTdJakIv?=
 =?utf-8?B?SEtvTFBhcXNtYnJ5aXR5SzlBK0cwQ2hXTjc1STVlcFN5ODNoOU5DQkNSVmNq?=
 =?utf-8?B?QnpFWEZsbDYvY21ESXJReDVQam83QndCZWpON3YrTTVFRitJbjNPVVRUdWNm?=
 =?utf-8?B?Q3IxbTczWTRNdVk4eUN5MFFOY1J6cEVIRmt0d2pTaUNSSDhieC8xNlpRQTZI?=
 =?utf-8?B?THQyL1h2UE5jMHJ1bmxLd1cweDBWTHV0NllvWDZ3dkh4bHRnOW5DN2l4M1hl?=
 =?utf-8?B?YmdZRVVrUy9Sb1c0eHVIQUt0QUs2THBOWUgyR3lMNVBuYWtLMHZqV1htOG92?=
 =?utf-8?B?Zy9BbmV2R3BvdTNlKzVwbm5yOThrU21NcCtLcXd0ODl5RGQxa0V3YUVFb3B6?=
 =?utf-8?B?VmdYS2l3NW8zdDRhUnV2Y1M4U2xIeGpjMDVOa1VtZXRFMGRBNkgvT3owNXNK?=
 =?utf-8?B?ODczNTVaZUczWWY2WFpQSGVmaWs5UW5FMWczdEp2OXZBeWRLd01KcG1XZ3oy?=
 =?utf-8?B?SU12dmo5WXMxTHRHUThpTnZ6RmRpcnVSaXMzbXdrSXlqcUp4dWNzSlVpY0hr?=
 =?utf-8?B?Rk1ENDF1QXAyUGJSK0dwdUJlSVVDUXhKdGlvZVJDeG85bEliNCtlQlhaQUwr?=
 =?utf-8?B?ZFZpRlpMaThOQ2Y1VVRGMHdhNkZQTWJxbWtLSzI4OU5kSTBvbkVrRkNxcmkz?=
 =?utf-8?B?VXdOKy8zM01oWTlROUlFc0luejFtVXMxTCtPSVI4V0NreTZ0TVA1WnpCUHd6?=
 =?utf-8?B?dUZocHA1Y2xzOHRkTEd2ZjRpN3gxVS9NaGozSGV3aThUY01mRWZ0b25mZTNl?=
 =?utf-8?B?ZU9qUXp6NzFpQmkzNStsOUlnTWJvNjFUYVdwWGI4VmRzUmZpVHhOZEVoU21T?=
 =?utf-8?B?N1JabWx6MUcvZ0prU2pmeWprSkFWZlNSZXZxbEtiK200amNaaHJMekNlNkRN?=
 =?utf-8?B?MVh4b0tPTDBRT1BsWnM3M3lzcFd3cVdhMG95dFNic1hNaWRCVnpsWmtnZkJx?=
 =?utf-8?B?eUd6c2NaS2pzZVRPY1cyQzQwL3dmVll4T3h6UkpOQ3dIaHB1b2pLbnVXMWFS?=
 =?utf-8?B?Z1hRRnpvTU1ySEc0V3M1Y1k2ckZaNFVtaytKVTAxUUdBcXFzZUxkeGdWSElM?=
 =?utf-8?B?aWJEVUlLRGo4bUl2eGxadGRGVkUzRENWYlZJMnZ4T1ZEVG9IOXBYampBeUFw?=
 =?utf-8?B?VE1DZ2tOUTZsRTZaUGNSTlZoVTBNc01GVTUzK1NnbDdZZTAzSThPckg3Nnlu?=
 =?utf-8?B?WGsrMHVzSHVWbnNjOUpwNXFsdGdhOHVqNEtCOE5ZejJpb01DWWMxcSs2eS83?=
 =?utf-8?B?a3hNRjhycjJFTVhOQWdVd1AraGJZazlIVS9iVXBGckkzNFNuQVFJWkFHRm5t?=
 =?utf-8?B?YWZ6QnJrUndTNExla25BL3lxU09Vak5HakVQeXF4WG5tWnlyZTdhOVVYeGtR?=
 =?utf-8?B?SHZUVjVVaDNXUjNhYnlleEx4MnRyaHE1UnpwQlJxZnhQWUc1NjBkY2JNcktP?=
 =?utf-8?B?V1lnckhRVHovR2t4YUQ4NDVKS1FKRWRWRVlvMDBoRTRmWlgvVTRUYXg4RFpM?=
 =?utf-8?B?WFhNNTNWdGRISTBnQkpRWVppcjkydDc0Z3VsNDUzdWRTTFFGeWptMFQ4OFZi?=
 =?utf-8?B?d1pKSXU4Q1pXZXJUQVZacWNOaXBlbUJMZk02V3E0SFpOeUY4RGY0ZjhYZ3pU?=
 =?utf-8?B?dVJydk5uV05TSEloV1NRd1VWM3FqUC9GUXpuR2Vnc0phZy90QjYxZ2lVYStW?=
 =?utf-8?B?R2xGNGxyMDl3KytOQ2gxQys5cUpvQTNTbjd4amwzR3NqM3NSOWo2UU9DaUV2?=
 =?utf-8?B?R3haMVR4WVVJRFhyc3dtSUZQSERLL1o0dk56MC9RL0dMSno2b1lzUXViTFZz?=
 =?utf-8?B?c0ZIOUQxdjVmQVdzVnM0cTJGVks0RkhTSmY1T1RyTzhrRU9JQzdvek5WL2hG?=
 =?utf-8?B?M2lSKzJMZnFSTDNCOFllU1FYWU5hbnN6T2pOMytUZjZoMnp2aUx1VWI4YUpM?=
 =?utf-8?B?WkVsb2RCZmQ4YXlDd2twMi9rcDY4UkhzSEJJSUFLTGZBU1RsbG5wZUhJMENS?=
 =?utf-8?B?TXQ0anlnS2NIOFA3dTFGUjI3K3VxVTdHWFc0UnZYNnhxMkdQOW5UamVLRytm?=
 =?utf-8?B?ZkpTdkRRbmRWNDdpRFVLSWRiemRLZ0wyL0NBcnkzZDBPUG1yU2dUZW41Smxx?=
 =?utf-8?Q?2RgAmZLltlf2EdSiTB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67845e5-539d-489f-55ac-08df4a4b7b4b
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9559.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 16:53:36.6912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h364Rl0b8toisIpNwFpDRCkjrsSLroorKjdjCsFpjNR37SqXyYCMqwGwSlvGol2Ak3MP/XWwRM6TJTHTi3GvyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9626



On 11/24/2026 4:50 PM, Andy Shevchenko wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, Nov 24, 2026 at 04:33:59PM +0530, Nagavarapu, Dileep Kumar wrote:
>> On 11/10/2026 9:59 PM, Andy Shevchenko wrote:
>>> On Tue, Nov 10, 2026 at 10:31:59AM +0530, Dileep Kumar Nagavarapu wrote:
> 
> ...
> 
>>>> ---
>>>>    drivers/iio/adc/Kconfig                       |   8 +-
>>>>    drivers/iio/adc/Makefile                      |   5 +-
>>>>    drivers/iio/adc/xilinx-xadc-core.c            | 690 +--------------
>>>>    drivers/iio/adc/xilinx-xadc-events.c          |   1 +
>>>>    ...inx-xadc-core.c => xilinx-xadc-platform.c} | 818 +-----------------
>>>>    drivers/iio/adc/xilinx-xadc.h                 |  27 +
>>>>    6 files changed, 72 insertions(+), 1477 deletions(-)
>>>
>>> This is weird statistics... I think it's a bug in Git. What it did, it copies
>>> -core.c twice and uses statistics on each file after that without duplicating
>>> the *original* amount of lines.
>>
>> I generated the patches using the following command: "git format-patch \
>>     -M \
>>     -C10% \
>>     --histogram \
>>     --base=origin/togreg \
>>     --cover-letter \
> 
>>     --subject-prefix="PATCH v5" \
> 
> Hint: You can use -v5 instead of the above long parameter.
> 
>>     origin/togreg..HEAD"
>>

>> If I remove the 10% similarity threshold from the command,
> 
> 10% is way too low threshold!
> 

Is it OK to use `-M -C --histogram` (default thresholds) instead? With
it, xilinx-xadc-platform.c is shown as a new file with all lines as
additions rather than as a copy of xilinx-xadc-core.c. The statistics
then look like this:

  drivers/iio/adc/Kconfig                |   8 +-
  drivers/iio/adc/Makefile               |   5 +-
  drivers/iio/adc/xilinx-xadc-core.c     | 688 +------------------------
  drivers/iio/adc/xilinx-xadc-events.c   |   1 +
  drivers/iio/adc/xilinx-xadc-platform.c | 677 ++++++++++++++++++++++++
  drivers/iio/adc/xilinx-xadc.h          |  28 +
  6 files changed, 733 insertions(+), 674 deletions(-)

Are these statistics OK?


>> xilinx-xadc-platform.c is no longer detected as a copy of the original
>> xilinx-xadc-core.c, which is not the expected output.
>> Is there a better command or approach that would allow Git to recognize
>> xilinx-xadc-platform.c as being split from the original file while also
>> producing meaningful diff statistics?
> 
> But it's not a full copy. Have you tried to apply the patch from the mailing
> list and see if `git am` correctly recognises the split?
> 

Yes. I applied the v5 series from the mailing list with `git am`
and all patches applied without errors

> 
> --
> With Best Regards,
> Andy Shevchenko

