Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013048.outbound.protection.outlook.com [40.93.196.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A56480DC1;
	Wed, 17 Jun 2026 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781714114; cv=fail; b=Vi2H4PGsNG9F5IvLLmAxHMetuz9fPq32iI+ehcIUOcgi5V0QXQfhWuybu6mQ5A/LU+WwX/LTfbOVCxwCgIIDVARgBGyZZLrKOi+XPREuymspk2xrvokimJH6eS46RIw35n86GDg869wZmtL+qT32hJKIuIPxCT2mzWlnLeRJzYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781714114; c=relaxed/simple;
	bh=w12XTugsM6f88AM0Y5CBwuYRtZMLYvTjEYIOmbRsZcw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oo2F9uInGyx+Hrb7hSxuLWOQjaTEf0QK6bHsfuZZQ+RbVsqmWqigPq81pq6DdKjVWxipgCR9GA3Lxn8QDjXJexUVw4a69rsbwKBYNYDXKKs/XedPG6e3gXxKAPAxpTDzyF7D8W12D8Tlldn7NhEJFfmNzrQivfigSa6e75DTpUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UYStWAPj; arc=fail smtp.client-ip=40.93.196.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UYStWAPj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn0zn7s+osiKXNEAsKNH62Xalt57ixql8zQz5ESDqIHqIZFnbmn0ckNSyOLsCwPEKedalgJcSwCi6PZSCnvKopIETKXCdNYPA20NXiZwWUjEkjITd+YN6+J1Oy2weguiEXHk6mH2KNsNh1gdh7Qg0gFAdiKfIaU1GpJHArepEZiNX3Snozs+dwk+0Mbkn5/JqSzfhoBRSSMuSxCmSaVFvYUV36gE4o47Vb3wpJDrjqq0u/h3j9VHOzkdQAVfTTcxsfDvy12mU7LwlH2vOqUnDamC6en56X1nbK4CuZOyv2Rlbfb+TdKTMlpaN5Xy4snK8nkYniVCl52+TsvkMqlOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5GXUFDW/xuRP62A8XVE5aULzSoi0tYbDmNflrxqn5k=;
 b=CvWZSTNeQw04pXDKrlMIgzmqFjGnOpDLoJHWCK0QffxB0L66ATTqrYMTMy+KOemoWqSmfXD1pgemPc76hKfNc3hMGBTksh5vubpE9JjWVUGi6f24f2dtal3wUCRN5hauKO93N7ofagBzl2UtfXYW48a6pDXv65Yb9yQVaYlZDEu+68l11ka9Q1QHiiCUCBHYfTPbI2m5wHebKyFXeYR1sSg07dW0k6JuriMatOCPKnvM7C0dp8rwH3xeGqwl2hrEjK9LJe+YPblnot0BvSb+PCREIRGtAoX/XIEUhqW+dgNaJK7r/dfayq9+Ng9AAkbkcktWTR+genBt/uHcx+FUhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5GXUFDW/xuRP62A8XVE5aULzSoi0tYbDmNflrxqn5k=;
 b=UYStWAPjW2eEMPM4LJ5eNSelLKELRCkc08bqbuUJVVZBOhuI5d4GL0VpxPWJ4nPOlPKTbGw/VaAZCRxA088n2cJwD1SC75vq/jziVyHZrGwE7mpa0LXyNVDydD9TnoEfBg1cpYoX/elNCuGnADV3W8r/e81lrj/bbtOYxvC/eq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Wed, 17 Jun
 2026 16:35:04 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 16:35:01 +0000
Message-ID: <23c5b7c1-00f7-4035-87de-234faa7dc5fb@amd.com>
Date: Wed, 17 Jun 2026 17:34:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] iio: adc: versal-sysmon: add oversampling support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
 linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260616131559.3029543-1-salih.erim@amd.com>
 <20260616131559.3029543-6-salih.erim@amd.com>
 <ajLAUJPpdaf8lJqG@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <ajLAUJPpdaf8lJqG@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0048.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::14) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|SJ2PR12MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 7750a4f1-d7d2-40cd-0f9a-08decc8e60b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|18002099003|22082099003|4143699003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	KwZTgRwvu5ZVKO+YUMuhZ0izzmdBN5Mj+hvN2DQ4Ot1N/zs7w+Z1Ijs2pOY5dfJsgeipdVoAofJx0+vf/2ohRRYxI84Hm1P/ZHqPkh50/VA8Z6z5uDbJ7L/m8hNTle/wLWHJ6GM2UoFbidy0/tKkz1eGp09iwyri3x4C/e81hFOX5EheP6d8qWK5zHrSKOU+uaFg63giH9VkbafeS8eqwlcL/wiGlSB4hlpqe1v5TJSKKmmF65gYmByBdvhYQ7Dl2EZGlT8Hri2qs9vCGJOWshb75vh1/g781tolDrKkK/g8lmr0qh4EPv49kMZfYzaQLMPPr4K0OwpX0Wl0i4niOwSo4//KNGron4fjIoozvk/I+AR2AVYVexj7bp5hKnVfg2pbWU+OP6IQINCBTO1JgOPj7xGkiVO3UCpnE7zUlq2mTZ5TLlkxeX1bCT2WcpiLEsbUC7WKkvWtMyhftBqNH1PiNOf+QDiEUyvqIddLRrg/Tp1T+Pp82w4WeXk4GMvA4fA1iwQJ8nfJn3VspSnB/qwaxFCZab6jLD896RlH0EGsz+Ah5yEBslXNaZFFn8d4TDeD7wlfOHy2O3w2EzJsFSAW56SOWBkzNimqm8ATQ5d9Y/Ey/lc9BEh9xMnCWeLuf7C+8mXSUxKNXwtysQ5IySQSiwTL7cy0UfxFJr/cbNQMw14Gyk/7BGSBf1N2V5/P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUx0YzQwM1FGZEpHOEx6YnA3ZXdGTW0xbEw2K0FWYXE0bEpkWUVEbG1PNElZ?=
 =?utf-8?B?RGl5Y1ZscURSdEZMR0xBc1BYN0FwdDhlUlljUVJQNVlIOGk0NXBGSXlpOFRs?=
 =?utf-8?B?T1puaVQreElzamRzMTg0TW1tdTJnbjZ4MU5teTZQTUU2Z0FQbGJIMWdZZDdV?=
 =?utf-8?B?ZzFkKzRMUm5vMnhZWHhEeCtwSXM5QzNsQUNjejMyTTdheTZGOG95SllFM2xM?=
 =?utf-8?B?ODUwN0xjSndEa1p4M0sycGlMV3FBR3lwL0VBd0Y5K0ZuQ3c1U2lZMExSWHcv?=
 =?utf-8?B?UU5VYzZZK0ZkOWpsNnQ0d3ZvUXFGRXluNzVDSFRrWGFIMTFDMFJYakhKRWo3?=
 =?utf-8?B?WHpTam5VR1FieG81amR0QWM1Q2I0NzhUa2ROYy9TTUQxWnBJM2RIdndvMXhv?=
 =?utf-8?B?ZkREUU94RnYzWkMvTytXUWtkbjNVY204Wm5UTWVPQVcrelQyNWhFVEpDVWtW?=
 =?utf-8?B?c2FJV3hJS29wQm9pN2pqVU9KVzUrRks4S0RrclpDUjdXSUk2WWxLTFpsVzNX?=
 =?utf-8?B?R1JVNCtmN2Z1ajRVcnhpMEtjZUlFdVkvbWZrVzNwaXUzUDNlNnR3THFCV3pi?=
 =?utf-8?B?VUoxNnFrT09NR01GWE9ib0FBSitUMmg0RVI2dll5WnhpbkMwdHpYYzN4cDZ1?=
 =?utf-8?B?UUV1TW1vSkhnWE4wVmxwa2U1aC9HWGdYMER5RXZTUDVIaFpFWE05UWU4cjNK?=
 =?utf-8?B?L2RrUnlUNFlFMzQwNjJmWHlFSDRJVnV1VzZkOG9DYmIrbXdOeFRCbUVxcHQr?=
 =?utf-8?B?ZUdHR1FmMzhMRW0rdDArMHAyOVZHUkJ4QzhJM1E2bjBkb0src1k4Nzl3MWxG?=
 =?utf-8?B?amx1SFJ2WTJpcEJTVS83QlZ4alFlSkdhT09yd3R4SGozakxJMmRhZW42Wjg4?=
 =?utf-8?B?MXFWalJ5N0dKM2YyRXAvM3NkVmtpMTExelZ0dVpIV0lvY3lXZG80cDdRS1Bv?=
 =?utf-8?B?REdSSGFSSnZGV1l0MEZYd3pVaXNxUnZoVlZEUzhrYW9vRkdyZjhMTW9lckpF?=
 =?utf-8?B?TFIvMm9qQ2M1Q2JnalpvMC9lQVhGRWpCV2x0TkQxY1dpREw0L1B2NU1yV0ps?=
 =?utf-8?B?cXlia1FidHJ1YzJDZTlpN2YyRnRjYXpDNnR2Vnp1KzBheXMwOFpZeTkzSE9q?=
 =?utf-8?B?ZElHQ2swbkFyL1VFNlkxRlM1ckZCYzdzMGN5U0swdVJFTFdrY0w1dGplaWFq?=
 =?utf-8?B?U3FlV1NRaVNVQ2RZV0JEQllRMnladk1HSm45aDNGRDg3b211ZTBPSGNrdWdo?=
 =?utf-8?B?ZjNqNTJ2MmJ4bVhaYzJrZ0V4VnZObGx0TGFleGtiWXo5bFJkUDhZNWdiRVNs?=
 =?utf-8?B?T3NMeFBRNzVDQ1VhZGNBVHFjQnVxY3JEVkJVbnZOV0Y2WU9teXc2MTVDZDFR?=
 =?utf-8?B?YTdqVVNNS1hnUDdrYjRqdkpKdmJoQ1Q0aDJMNmNmSmRkK1Q0cWNFSWVNL204?=
 =?utf-8?B?VCtSZ004cktST053Ky9Sa01EaGV5aEZTZDJvdDRFR3N6SWRIYWJhVnpEZitq?=
 =?utf-8?B?L1RQeFdqdzBCekcvcHEreVZ4UUlLeTlLNy9WSUhaNUhSZ2l6WVJQa1o5L0p5?=
 =?utf-8?B?eUVNUXJrRXRYaXU1ZkNlV0lvVWF2WXAzeUorSWJwclZiRmkwSFhJaGtENUEy?=
 =?utf-8?B?cGhPKzBYNWR3YW9XTm1sTDBiTkpHSXBMSXEzSkhuY24vNWNwTHA5RUJEZnl6?=
 =?utf-8?B?KzVncWowazhpYVIvSEIzMUV4NFRpMkZmK1F5YjNhYlFKY2s3NnI0L0FsQW80?=
 =?utf-8?B?OGFMVGFlZDZndWk5cC9hTTFWSFlUMmp6MmJUSEh2Y2NtRjA3ZDZCWUN2MTM1?=
 =?utf-8?B?UXNqbi84dWRsMTFnK2RScXdJRm44RGRtQW9OcXhTSVkrb1cyc2IwanAxeFU1?=
 =?utf-8?B?RE5FVmJEUEdLdmZwUW1lNWZMNkg3Z0t0Wm9LS3RPTDdNNFE5bWFCMGdJTmw3?=
 =?utf-8?B?aXVlMzVnZEpsKzY2QUFyNzVIQUlsSit3WDEzV0VUWmVRZk44Ukw2eWNpWHpT?=
 =?utf-8?B?UzBwZ0xlUTY1bDl5N0NEYUhsaGM2VnRNM2orQjNIU0pCVEI1UmVYNG45Ymxv?=
 =?utf-8?B?VzBISStrY0lRenJsRTJlVkNXWlNjVUhNTVFqY05lekJjSVZuNjBuTlFRK0pk?=
 =?utf-8?B?ZVg5ZXlDN2hzS3VFaVlBcFdNQUxoZlVZNm1LQzFKdGFXNStJTnM0dGc3MlBs?=
 =?utf-8?B?NGlZMDkvZGFUYTk1RmVDVXlNQTdnY0VobDlSM05oUngvRFBubnhFQ3l0V205?=
 =?utf-8?B?R08zcXlITnZ5bVZvQ3h2dVpxWE9DTXROclM2SDBKc0tHODY2Z3RlenlkRlYv?=
 =?utf-8?Q?uLzLWxQlkfqkS0y3HR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7750a4f1-d7d2-40cd-0f9a-08decc8e60b4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 16:35:01.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAX0RkDtWTyrLcUm32jU7jrjZpA2+98paRbBWMUwE7c+XzKCKZ2F6bQ15G83d7QF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893

Hi Andy,

On 17/06/2026 16:42, Andy Shevchenko wrote:
> On Tue, Jun 16, 2026 at 02:15:59PM +0100, Salih Erim wrote:
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
> 
> This one LGTM now,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thank you!

> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

